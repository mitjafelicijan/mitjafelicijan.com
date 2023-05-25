---
title: Mount Plan9 over network
url: mount-plan9-over-network.html
date: 2023-05-07T12:00:00+02:00
type: notes
draft: false
tags: [plan9, linux, 9pfs]
---

- First install libfuse with sudo apt install libfuse-dev.
- Then clone https://github.com/ftrvxmtrx/9pfs and compile it with make.
- Copy 9pfs to your path.

```sh
# On Plan9 side
ip/ipconfig # enables network
aux/listen1 -tv tcp!*!9999 /bin/exportfs -r tmp # export tmp folder

# On Linux side
9pfs 172.18.0.1 -p 9999 local_folder # mount
umount local_folder # unmount
```

