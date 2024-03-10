---
title: Install Plan9port on Linux
url: install-plan9port-linux.html
date: 2023-05-12T12:00:00+02:00
type: note
draft: false
---

Install Plan9port on Linux. This applies to
[Plan9port](https://9fans.github.io/plan9port/). This is a port of many Plan 9
programs to Unix-like operating systems. Useful for programs like `9term` and
`rc`.

```sh
sudo apt-get install gcc libx11-dev libxt-dev libxext-dev libfontconfig1-dev
git clone https://github.com/9fans/plan9port $HOME/plan9
cd $HOME/plan9/plan9port
./INSTALL -r $HOME/plan9
```

