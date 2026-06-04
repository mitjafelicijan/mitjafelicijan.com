---
title: Nvidia driver works but the monitor stays black with No Signal error
url: nvidia-driver-works-but-the-monitor-stays-black-with-no-signal.html
date: 2026-06-04T16:13:13+02:00
type: note
draft: false
tags: []
---

Void Linux upgrade caused monitor to show "No Signal".

**Bare in mind that if you manually added the fix, the upgrade can revert your change.**

> **TL;DR**
>
> After a Void Linux upgrade, the monitor showed **"No Signal"** even though
> the NVIDIA driver loaded correctly and `nvidia-smi` detected the GPU. The
> issue was that NVIDIA DRM modesetting was not enabled, causing DRM display
> connectors (DisplayPort/HDMI) to not be exposed under `/sys/class/drm/`.
>
> Add the following kernel parameter to Grub config file `/etc/default/grub`.
>
> ```text
> GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1"
> ```
>
> Then regenerate the GRUB configuration and reboot.
>
> ```bash
> sudo grub-mkconfig -o /boot/grub/grub.cfg
> sudo reboot
> ```

## Symptoms

- Monitor showed "No Signal"
- NVIDIA driver loaded successfully
- `nvidia-smi` worked and detected the RTX 3080 Ti
- DKMS modules were built for the running kernel
- No Nouveau module was loaded

```bash
lsmod | grep -E 'nvidia|nouveau'
```

Output:

```text
nvidia_drm
nvidia_modeset
nvidia
```

## Investigation

The NVIDIA driver appeared healthy:

```bash
nvidia-smi
```

Output:

```text
NVIDIA GeForce RTX 3080 Ti             Disp.A Off
```

The GPU was detected correctly, but no display outputs were active.

Next, I inspected the DRM devices:

```bash
ls -l /sys/class/drm/
```

Output:

```text
card0
renderD128
version
```

Expected connector entries (such as below) were missing.

```text
card0-DP-1
card0-DP-2
card0-HDMI-A-1
```

This indicated that the NVIDIA DRM layer was not exposing any display connectors to the kernel.

## Cause

The running kernel command line was:

```bash
cat /proc/cmdline
```

Output:

```text
BOOT_IMAGE=/boot/vmlinuz-6.18.34_1 root=UUID=d41c9246-090e-47f4-af08-8ea490e6b06b ro loglevel=4
```

`nvidia-drm.modeset=1` parameter was missing after the upgrade.

Without NVIDIA DRM modesetting enabled, the proprietary driver loaded
successfully but failed to expose display connectors, causing the monitor to
lose signal.

## Fix the issue

Edit `/etc/default/grub` and add `GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1"`.

Then regenerate the GRUB configuration and reboot.

```bash
sudo grub-mkconfig -o /boot/grub/grub.cfg
sudo reboot
```

## Notes

- NVIDIA DKMS modules were correctly built for the running kernel.
- The NVIDIA kernel modules loaded successfully.
- `nvidia-smi` worked as expected.
- No Nouveau modules were active.
- The missing DRM connector entries were the key clue that pointed to a modesetting issue.

This diagnosis should be considered a likely root cause until confirmed by successfully booting with `nvidia-drm.modeset=1`.
