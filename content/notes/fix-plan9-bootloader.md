---
title: Fix bootloader not being written in Plan9
url: fix-plan9-bootloader.html
date: 2023-05-11T12:00:00+02:00
type: notes
draft: false
tags: [plan9, bootloader]
---

If the bootloader is not being written to a disk when installing 9front on real
harware try clearing first sector of the disk with the following command.

```sh
dd if=/dev/zero of=/dev/sdX bs=512 count=1

# If command above doesn't work try this one, wait couple of seconds and
# press delete key to stop the command.
cat </dev/zero >/dev/sd*/data
```

