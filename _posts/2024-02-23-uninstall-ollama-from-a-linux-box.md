---
title: Uninstall Ollama from a Linux box
permalink: /uninstall-ollama-from-a-linux-box.html
date: 2024-02-23
layout: post
draft: false
type: note
---
I have had some issues with Ollama not being up-to-date. If Ollama is installed with a curl command, it adds a systemd service.

```sh
sudo systemctl stop ollama
sudo systemctl disable ollama
sudo rm /etc/systemd/system/ollama.service
sudo systemctl daemon-reload

sudo rm /usr/local/bin/ollama

sudo userdel ollama
sudo groupdel ollama

rm -r ~/.ollama
sudo rm -rf /usr/share/ollama
```

That is about it.