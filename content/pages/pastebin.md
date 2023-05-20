---
title: Pastebin
date: 2023-05-19
url: pastebin.html
draft: false
---

*No additional explanation provided here. Use blog for more detailed stuff.*

**▒ Previews how man page written in Troff will look like**

```sh
# On Linux system.
groff -man -Tascii filename

# On Plan9 system.
man 1 filename
```

**▒ Convert all MKV files into WebM format**

```sh
find ./ -name '*.mkv' -exec bash -c 'ffmpeg -i "$0" -vcodec libvpx -acodec libvorbis -cpu-used 5 -threads 8 "${0%%.mp4}.webm"' {} \;
```

**▒ Convert all MKV files into MP4 format**

```sh
find ./ -name '*.mkv' -exec bash -c 'ffmpeg -i "$0" c:a copy -c:v copy -cpu-used 5 -threads 8 "${0%%.mp4}.mp4"' {} \;
```

**▒ Download list of YouTube files**

```js
// Used to get list of raw URL's from YouTube's video tab'.
// Copy them into videos.txt.
document.querySelectorAll('#contents a.ytd-thumbnail.style-scope.ytd-thumbnail').forEach(el => console.log(el.href))
```

Download and install https://github.com/yt-dlp/yt-dlp.

```sh
yt-dlp --batch-file videos.txt -N `nproc` -f webm
```

**▒ Install Plan9port on Linux**

```sh
sudo apt-get install gcc libx11-dev libxt-dev libxext-dev libfontconfig1-dev
git clone https://github.com/9fans/plan9port $HOME/plan9
cd $HOME/plan9/plan9port
./INSTALL -r $HOME/plan9
```

**▒ Fix bootloader not being written in Plan9**

If the bootloader is not being written to a disk when installing 9front on
real harware try clearing first sector of the disk with the following command.

```sh
dd if=/dev/zero of=/dev/sdX bs=512 count=1

# If command above doesn't work try this one, wait couple of seconds and
# press delete key to stop the command.
cat </dev/zero >/dev/sd*/data
```

**▒ Take a screenshot in Plan9**

```sh
cat /dev/screen | topng > screen.png
```

**▒ #cat-v on weechat configuration**

```sh
# Install weechat and launch it and execute the following commands.

/server add oftc irc.oftc.net -tls
/set irc.server.oftc.autoconnect on
/set irc.server.oftc.autojoin "#cat-v"
/set irc.server.oftc.nicks "nick1,nick2,nick3"
```

**▒ Write ISO to USB Key**

```sh
sudo dd if=iso_file.iso of=/dev/sdX bs=4M status=progress conv=fdatasync
```

**▒ Mount Plan9 over network**

- First install `libfuse` with `sudo apt install libfuse-dev`.
- Then clone https://github.com/ftrvxmtrx/9pfs and compile it with `make`.
- Copy `9pfs` to your path.

```sh
# On Plan9 side
ip/ipconfig # enables network
aux/listen1 -tv tcp!*!9999 /bin/exportfs -r tmp # export tmp folder

# On Linux side
9pfs 172.18.0.1 -p 9999 local_folder # mount
umount local_folder # unmount
```

**▒ Push to multiple origins at once in Git**

```sh
git config --global alias.pushall '!sh -c "git remote | xargs -L1 git push --all"'
```

**▒ Run 9front in Qemu**

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
