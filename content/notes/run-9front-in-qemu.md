---
title: Run 9front in Qemu
url: run-9front-in-qemu.html
date: 2023-05-05
type: notes
draft: false
---

Run 9front in Qemu. This applies to [Plan9](https://9p.io/plan9/) and
[9front](https://9front.org/).

Download from here http://9front.org/iso/.

```sh
# Create a qcow2 image.
qemu-img create -f qcow2 $HOME/VM/9front.qcow2.img 30G

# Run the VM.
qemu-system-x86_64 -cpu host -enable-kvm -m 1024 \
    -net nic,model=virtio,macaddr=52:54:00:00:EE:03 -net user \
    -device virtio-scsi-pci,id=scsi \
    -drive if=none,id=vd0,file=$HOME/VM/9front.qcow2.img \
    -device scsi-hd,drive=vd0 \
    -drive if=none,id=vd1,file=$HOME/VM/ISO/9front.386.iso \
    -device scsi-cd,drive=vd1,bootindex=0
```
