---
title: Replacing Dropbox in favor of DigitalOcean spaces
permalink: /replacing-dropbox-in-favor-of-digitalocean-spaces.html
date: 2021-01-24T12:00:00+02:00
layout: post
type: post
draft: false
---

A few months ago I experimented with DigitalOcean spaces as my backup solution
that could [replace Dropbox
eventually](/digitalocean-spaces-to-sync-between-computers.html).  That solution
worked quite nicely, and I was amazed how smashing together a couple of existing
solutions would work this fine.

I have been running that solution in the background for a couple of months now
and kind of forgot about it. But recent developments around deplatforming and
having us people hostages of technology and big companies speed up my goals to
become less dependent on
[Google](https://edition.cnn.com/2020/12/17/tech/google-antitrust-lawsuit/index.html),
[Dropbox](https://www.pcworld.com/article/2048680/dropbox-takes-a-peek-at-files.html)
etc and take back some control.

I am not a conspiracy theory nut, but to be honest, what these companies are
doing lately is out of control. It is a matter of principle at this point. I
have almost completely degoogled my life all the way from ditching Gmail,
YouTube and most of the services surrounding Google. And I must tell you, I feel
so good. I haven't felt this way for a long time.

**Anyways. Let's get to the meat of things.**

Before you continue you should read my post about [syncing to
Dropbox](/digitalocean-spaces-to-sync-between-computers.html).

> Also to note, I am using Linux on my machine with Gnome desktop environment.
This should work on MacOS too. To use this on Windows I suggest using
[Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
or [Cygwin](https://www.cygwin.com/).

## Folder structure

I liked structure from Dropbox. One folder where everything is located and
synced. So, that's why adopted this also for my sync setup.

```go
~/Vault
   ↳ backup
   ↳ bin
   ↳ documents
   ↳ projects
```

All of my code is located in `~/Vault/projects` folder. And most of the projects
are Git repositories. I do not use this sync method for backup per see but in
case I reinstall my machine I can easily recreate all the important folder
structure with one quick command. No external drives needed that can fail etc.

## Sync script

My sync script is located in `~/Vault/bin/vault-backup.sh`

```bash
#!/bin/bash

# dconf load /com/gexperts/Tilix/ < tilix.dconf
# 0 2 * * * sh ~/Vault/bin/vault-backup.sh

cd ~/Vault/backup/dotfiles

MACHINE=$(whoami)@$(hostname)
mkdir -p $MACHINE
cd $MACHINE

cp ~/.config/VSCodium/User/settings.json settings.json
cp ~/.s3cfg s3cfg
cp ~/.bash_extended bash_extended
cp ~/.ssh ssh -rf

codium --list-extensions > vscode-extension.txt
dconf dump /com/gexperts/Tilix/ > tilix.dconf

cd ~/Vault
s3cmd sync --delete-removed --exclude 'node_modules/*' --exclude '.git/*' --exclude '.venv/*' ./ s3://bucket-name/backup/

echo `date +"%D %T"` >> ~/.vault.log

notify-send \
	-u normal \
	-i /usr/share/icons/Adwaita/96x96/status/security-medium-symbolic.symbolic.png \
	"Vault sync succeded at `date +"%D %T"`"
```

This script also backups some of the dotfiles I use and sends notification to
Gnome notification center. It is a straightforward solution. Nothing special
going on.

> One obvious benefit of this is that I can omit syncing Node's `node_modules`
> or Python's `.venv` and `.git` folders.

You can use this script in a combination with [Cron](https://en.wikipedia.org/wiki/Cron).

```txt
0 2 * * * sh ~/Vault/bin/vault-backup.sh
```

When you start syncing your local stuff with a remote server you can review your
items on DigitalOcean.

![Dropbox Spaces](/assets/posts/dropbox-sync/dropbox-spaces.png){:loading="lazy"}

I have been using this script now for quite some time, and it's working
flawlessly. I also uninstalled Dropbox and stopped using it completely.

All I need to do is write a Bash script that does the reverse and downloads from
remote server to local folder. This could be another post.
