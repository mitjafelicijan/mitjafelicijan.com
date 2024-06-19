---
title: "Compile drawterm on Fedora 38"
url: compile-drawterm-on-fedora-38.html
date: 2023-09-25T09:04:28+02:00
type: note
draft: false
tags: [plan9]
---

First install two dependencies:

```sh
sudo dnf install libX11-devel libXt-devel
```

Clone the repo and compile it:

```sh
git clone git://git.9front.org/plan9front/drawterm
cd drawterm
CONF=unix make
```

That should produce `drawterm` binary.
