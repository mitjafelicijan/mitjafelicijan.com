---
title: "The abysmal state of GNU/Linux and a case against shared object libraries"
url: the-abysmal-state-of-gnu-linux-and-a-case-against-shared-object-libraries.html
date: 2024-03-10T21:41:52+01:00
type: post
draft: false
---

## Personal critique

This is in part difficult to write since I have been daily driving
GNU/Linux for 20 years now, but I think it is necessary to be honest
about this.  How come GNU/Linux is worse than it was 10 years ago? This
may very well be a subjective opinion, or maybe I am looking at the
situation with rose-tinted glasses.

> A full disclaimer, this weekend my system that is pretty vanilla
just decided to die after an update. And this was not a full version
upgrade. Just a normal update that I do many times per week.

Sure, we now have [PipeWire](https://www.pipewire.org/) and
[Wayland](https://wayland.freedesktop.org/). We enjoy many modern
advances and yet, the practical use for me is worse than it was 10 years
ago. Now all of a sudden, I can't rely on the system to be stable like
it was. I don't remember the system bricking after an update, or the
system becoming laggy after 10 days of uptime. This may be the issue with
[Fedora](https://fedoraproject.org/), though.

Over the years, I have daily driven many
distributions. From [Gentoo](https://www.gentoo.org/),
[Arch](https://archlinux.org/), [Fedora](https://fedoraproject.org/)
to [Ubuntu](https://www.debian.org/). My best memories were always with
[Debian](https://www.debian.org/). Just pure Debian always proved to be
the most stable system. I never had issue or system breaking after an
update. I can't say the same for Fedora.

From the get-go, I had issues. I have an Nvidia card and even
booting presented issues on occasion. This never happened on
other distributions, though they had their problems. Updating the
system was basically an exercise in gambling. How come an operating
system that boasts with the stability is so unstable? And this was
not isolated to my main machine. This also happened on my [X220
ThinkPad](https://www.cnet.com/reviews/lenovo-thinkpad-x220-review/)
with Fedora on.

Shared dependencies were a mistake! There, I said it! I understand
that disk space was limited back then and this was a legitimate
constraint. But this has given me more grief than any other thing. I am
all in for [AppImages](https://appimage.org/) or something like that. I
don't care if these images are 10x bigger. Disk space now is plenty, and
they solve the issue with "libFlac.8.so is missing" and I have version
12 installed. Which comes with unnecessary symlinking, downloading of
older versions and hoping that this will resolve the issue.

Now, the biggest apologist of GNU/Linux will never admit this and
even saying something is wrong with this is considered a mortal sin. I,
however, am not concerned with cultist behaviors. This is bullshit! Things
should be better than 10 years ago, not worse. And I don't care how
much lipstick you put on this pig. After more than 20 years of using
Linux as my main system, I think I have earned a badge that gives me
the right to say the truth.

Regardless of all this, I am still a massive fan. I still think GNU/Linux
is probably the most unobtrusive operating system, bar none. But the
complexity has gotten the best of it. It's bloated and too complicated
at this point. Understandably, you can't have a modern operating system
that competes with alternatives without sacrificing simplicity. But I
still think that there is another way.

One of the best aspects of GNU/Linux must be outstanding package manager
support. Nevertheless, they are essentially solving a problem that should
have been solved and done with years ago. The number of gymnastics
that happen in the background for you to install a software is just
mind-boggling. The dependency graphs are insane. And Snaps and Flatpaks
tried to solve some of these things, but until a distribution comes out
that is completely devoid of shared dependencies, we will still live in
this purgatory.

Let's compare these two distributions when it comes to packages sizes
and shared object libraries and see they fair.

## Debian

```ini
root@debian: cat /etc/os-release

PRETTY_NAME="Debian GNU/Linux 12 (bookworm)"
NAME="Debian GNU/Linux"
VERSION_ID="12"
VERSION="12 (bookworm)"
VERSION_CODENAME=bookworm
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"
```

### Top 20 packages by size

```sh
dpkg-query -W --showformat='${Installed-Size}\t${Package}\n' | sort -nr | head -n 20 | awk '{size=$1;unit="KB"; if (size >= 1024) {size=size/1024; unit="MB"}; if (size >= 1024) {size=size/1024; unit="GB"}; printf "%.2f %s\t%s\n", size, unit, $2}'
```

| Size      | Package                    |
|-----------|----------------------------|
| 651.87 MB | libwine                    |
| 389.26 MB | linux-image-6.1.0-18-amd64 |
| 345.76 MB | brave-browser              |
| 323.74 MB | google-chrome-stable       |
| 265.31 MB | llvm-14-dev                |
| 225.76 MB | firefox-esr                |
| 141.77 MB | fluid-soundfont-gm         |
| 114.67 MB | libreoffice-core           |
| 113.41 MB | containerd.io              |
| 112.77 MB | libnvidia-rtcore           |
| 111.92 MB | libllvm15                  |
| 106.56 MB | ibus-data                  |
| 104.92 MB | libllvm14                  |
| 99.20 MB  | docker-ce                  |
| 77.39 MB  | docker-buildx-plugin       |
| 72.00 MB  | libwebkit2gtk-4.1-0        |
| 71.93 MB  | libwebkit2gtk-4.0-37       |
| 70.51 MB  | libwebkitgtk-6.0-4         |
| 69.25 MB  | nvidia-kernel-dkms         |
| 66.64 MB  | gcc-12                     |

This is more or less fresh system that is being used daily for work.

### Number of packages installed

```sh
dpkg -l | grep '^ii' | wc -l

2217
```

### Number of shared object libraries on system (*.so)

*Note: Some of them could be symlinks to each other so take this with
a grain of salt.*

```sh
find /lib /lib64 /usr/lib /usr/lib64 -follow -type f -name "*.so.*" | wc -l

5156
```

### Shared objects sorted by size

```sh
find /lib /lib64 /usr/lib /usr/lib64 -type f -name "*.so.*" -exec du -h {} + | sort -rh | head -n 20
```

| Size | Package                                                        |
|------|----------------------------------------------------------------|
| 113M | /usr/lib/x86_64-linux-gnu/libnvidia-rtcore.so.525.147.05       |
| 112M | /usr/lib/x86_64-linux-gnu/libLLVM-15.so.1                      |
| 105M | /usr/lib/x86_64-linux-gnu/libLLVM-14.so.1                      |
| 70M  | /usr/lib/x86_64-linux-gnu/libwebkit2gtk-4.1.so.0.12.8          |
| 70M  | /usr/lib/x86_64-linux-gnu/libwebkit2gtk-4.0.so.37.67.8         |
| 69M  | /usr/lib/x86_64-linux-gnu/libwebkitgtk-6.0.so.4.4.8            |
| 57M  | /usr/lib/llvm-14/lib/libclang-cpp.so.14                        |
| 45M  | /usr/lib/x86_64-linux-gnu/libnode.so.108                       |
| 43M  | /usr/lib/x86_64-linux-gnu/libnvidia-glcore.so.525.147.05       |
| 41M  | /usr/lib/x86_64-linux-gnu/libnvidia-eglcore.so.525.147.05      |
| 31M  | /usr/lib/x86_64-linux-gnu/libmozjs-102.so.102.15.1             |
| 30M  | /usr/lib/x86_64-linux-gnu/libicudata.so.72.1                   |
| 30M  | /usr/lib/x86_64-linux-gnu/libclang-14.so.14.0.6                |
| 29M  | /usr/lib/x86_64-linux-gnu/nvidia/current/libcuda.so.525.147.05 |
| 28M  | /usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-6.0.so.1.1.14   |
| 28M  | /usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-4.1.so.0.4.14   |
| 28M  | /usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-4.0.so.18.23.14 |
| 24M  | /usr/lib/x86_64-linux-gnu/libnvidia-glvkspirv.so.525.147.05    |
| 23M  | /usr/lib/x86_64-linux-gnu/libz3.so.4                           |
| 22M  | /usr/lib/x86_64-linux-gnu/libgs.so.10.00                       |

## Fedora

```ini
root@fedora: cat /etc/os-release

NAME="Fedora Linux"
VERSION="36 (Workstation Edition)"
ID=fedora
VERSION_ID=36
VERSION_CODENAME=""
PLATFORM_ID="platform:f36"
PRETTY_NAME="Fedora Linux 36 (Workstation Edition)"
ANSI_COLOR="0;38;2;60;110;180"
LOGO=fedora-logo-icon
CPE_NAME="cpe:/o:fedoraproject:fedora:36"
HOME_URL="https://fedoraproject.org/"
DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora/f36/system-administrators-guide/"
SUPPORT_URL="https://ask.fedoraproject.org/"
BUG_REPORT_URL="https://bugzilla.redhat.com/"
REDHAT_BUGZILLA_PRODUCT="Fedora"
REDHAT_BUGZILLA_PRODUCT_VERSION=36
REDHAT_SUPPORT_PRODUCT="Fedora"
REDHAT_SUPPORT_PRODUCT_VERSION=36
PRIVACY_POLICY_URL="https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
SUPPORT_END=2023-05-16
VARIANT="Workstation Edition"
VARIANT_ID=workstation
```

### Top 20 packages by size

```sh
rpm -qa --queryformat '%{SIZE}\t%{NAME}\n' | sort -rn | head -n 20 | awk '{size=$1;unit="B"; if (size >= 1024) {size=size/1024; unit="KB"}; if (size >= 1024) {size=size/1024; unit="MB"}; if (size >= 1024) {size=size/1024; unit="GB"}; printf "%.2f %s\t%s\n", size, unit, $2}'
```

| Size      | Package                      |
|-----------|------------------------------|
| 572.91 MB | google-cloud-sdk             |
| 559.76 MB | wine-core                    |
| 530.12 MB | wine-core                    |
| 383.76 MB | code                         |
| 350.98 MB | golang-bin                   |
| 318.04 MB | brave-browser                |
| 302.78 MB | google-chrome-stable         |
| 282.24 MB | libreoffice-core             |
| 273.43 MB | firefox                      |
| 253.00 MB | ocaml                        |
| 223.60 MB | proj-data-us                 |
| 219.46 MB | zoom                         |
| 217.81 MB | glibc-all-langpacks          |
| 199.31 MB | qemu-user                    |
| 196.79 MB | edk2-aarch64                 |
| 194.77 MB | fluid-soundfont-lite-patches |
| 194.25 MB | java-17-openjdk-headless     |
| 176.75 MB | java-11-openjdk-headless     |
| 156.80 MB | pandoc                       |
| 154.82 MB | qt5-qtwebengine              |

What is interesting that the most of these packages are from a a system
that are daily in use.

### Number of packages installed

```sh
dnf list installed | tail -n +3 | wc -l

3484
```

### Number of shared object libraries on system (*.so)

*Note: Some of them could be symlinks to each other so take this with
a grain of salt.*

```sh
find /lib /lib64 /usr/lib /usr/lib64 -follow -type f -name "*.so.*" | wc -l

8894
```

### Shared objects sorted by size

```sh
find /lib /lib64 /usr/lib /usr/lib64 -type f -name "*.so.*" -exec du -h {} + | sort -rh | head -n 20
```

| Size | Package                                                                        |
|------|--------------------------------------------------------------------------------|
| 128M | /usr/lib64/libQt5WebEngineCore.so.5.15.10                                      |
| 55M  | /usr/lib64/llvm13/lib/libclang-cpp.so.13                                       |
| 53M  | /usr/lib64/libclang-cpp.so.14                                                  |
| 50M  | /usr/lib64/libwebkit2gtk-4.0.so.37.57.6                                        |
| 49M  | /usr/lib64/libnode.so.93                                                       |
| 45M  | /usr/lib64/libOpenImageDenoise.so.1.4.3                                        |
| 33M  | /usr/lib64/llvm13/lib/libclang.so.13.0.1                                       |
| 30M  | /usr/lib64/libclang.so.14.0.5                                                  |
| 29M  | /usr/lib64/libopenvdb.so.9.0.0                                                 |
| 28M  | /usr/lib/libicudata.so.69.1                                                    |
| 28M  | /usr/lib64/libmozjs-78.so.0.0.0                                                |
| 28M  | /usr/lib64/libicudata.so.69.1                                                  |
| 26M  | /usr/lib64/libusd_usd_ms.so.0                                                  |
| 26M  | /usr/lib64/libgdal.so.30.0.3                                                   |
| 22M  | /usr/lib64/libjavascriptcoregtk-4.0.so.18.21.6                                 |
| 22M  | /usr/lib64/libgs.so.9.56                                                       |
| 22M  | /usr/lib64/google-cloud-sdk/platform/bundledpythonunix/lib/libpython3.9.so.1.0 |
| 17M  | /usr/lib64/libgtkd-3.so.0.9.0                                                  |
| 17M  | /usr/lib64/libgeocoding.so.8.12                                                |
| 14M  | /usr/lib64/libmfxhw64.so.1.35                                                  |

## Quick observation

```
/usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-6.0.so.1.1.14
/usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-4.1.so.0.4.14
/usr/lib/x86_64-linux-gnu/libjavascriptcoregtk-4.0.so.18.23.14
```

These three packages are probably used by three different applications,
and nothing else needs them. I could be mistaken, but in any case they
should just be packaged alongside the application that requires them
and be done with it.

## So, now what?

The main point is that, yes these packages can be big, but if we are
honest, what would a couple of additional megabytes that would include
shared object libraries actually do? Probably nothing! And it would make
maintenance an entirely different game.

There is also this big elephant in the room, the users. They aren't
concerned about package dependencies. They don't care if an application
is 20 megabytes bigger. Nobody cares! But they certainly do care about
borked systems and non-working dependencies and hunting for solutions why
`libFlac` was not found even though they have it installed (allthough
slightly different version).

Operating systems should abstract these complexities away from the
user. And I am not saying that the Linux kernel is at fault. I mean the
operating system as a whole.

This is why I am a massive proponent of
[AppImages](https://appimage.org/). Flatpaks and Snaps are OK, but they
still have their own package management and the whole dependency problem
because they try to optimize for space, and they sacrifice the simplicity.

It would be an interesting exercise to make a prototype distribution
that does not rely on shared objects, but has everything packed in
AppImages. Probably a foolish endeavor, but maybe worth looking into. I
sense this kind of distribution would be highly unusable. Interesting
how far we have gotten that this kind of distribution is almost not
possible anymore.

The year of the GNU/Linux desktop? I have strong doubts. We are in a
worse state than we were. Not only that, but the sheer amount of choice
is paralyzing at this point. This is very relatable to [The Paradox of
Choice](https://en.wikipedia.org/wiki/The_Paradox_of_Choice). The
more options we have, the worse it
gets. [Wayland](https://wayland.freedesktop.org/) competing with
[X](https://www.x.org/wiki/). So many window managers, you just get
lost. So many choices. I have no idea if this is even salvageable,
or something new must be made.

A quick shoutout to [AppImageHub](https://www.appimagehub.com/). If
possible, I continually try to find applications there and take care of
updating them myself. I don't need hand holding or a constant up-to date
system. I just want my system to be stable and when some application has
gotten some significant new features I can download that myself. It's
about the choice and not being forced into this churn that requires
constant updating and keeping up with things. At this point, using
GNU/Linux is more like a second job, and I was so stoked when this was
not a case anymore in the past. This is why I feel like the last 10
years were a regression disguised as progress.

Some interesting talks and videos

- [Jonathan Blow on how an operating system should work](https://www.youtube.com/watch?v=k0uE_chSnV8)
- [The Thirty Million Line Problem by Casey Muratori](https://www.youtube.com/watch?v=kZRE7HIO3vk)
- [GNU is Bloated! by Luke Smith](https://www.youtube.com/watch?v=nTCHapo8QFM)
