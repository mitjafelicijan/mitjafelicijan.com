---
title: Using Digitalocean Spaces to sync between computers
url: digitalocean-spaces-to-sync-between-computers.html
date: 2020-09-09T12:00:00+02:00
draft: false
---

I've been using [Dropbox](https://www.dropbox.com/) for probably **10+ years**
now and I-ve became so used to it that it runs in the background that I don't
even imagine a world without it. But it's not without problems.

At first I had problems with `.venv` environments for Python and the only
solution for excluding synchronization for this folder was to manually exclude a
specific folder which is not really scalable. FYI, my whole project folder is
synced on [Dropbox](https://www.dropbox.com/). This of course introduced a lot
of syncing of files and folders that are not needed or even break things on
other machines. In the case of **Python**, I couldn't use that on my second
machine. I needed to delete `.venv` folder and pip it again which synced files
again to the main machine. This was very frustrating. **Nodejs** handles this
much nicer and I can just run the scripts without deleting `node_modules` again
and reinstalling. However, `node_modules` is a beast of its own. It creates so
many files that OS has a problem counting them when you check the folder
contents for size.

I wanted something similar to Dropbox. I could without the instant syncing but
it would need to be fast and had the option for me to exclude folders like
`node_modules, .venv, .git` and folders like that.

I went on a hunt for an alternative to [Dropbox](https://www.dropbox.com/) 
and found:

- [Tresorit](https://tresorit.com/)
- [Sync.com](https://sync.com)
- [Box](https://www.box.com/)

You know, the usual list of suspects. I didn't include [Google
drive](https://drive.google.com) or [One drive](https://onedrive.live.com/)
since they are even more draconian than Dropbox.

> All this does not stem from me being paranoid but recently these companies 
> have became more and more aggressive and they keep violating our privacy when 
> they share our data with 3rd party services. It is getting out of control.

So, my main problem was still there. No way of excluding a specific folder from
syncing. And before we go into "*But you have git, isn't that enough?*", I must
say, that many of the files (PDFs, spreadsheets, etc) I have in a `git` repo
don't get pushed upstream to Git and I still want to have them synced across my
computers.

I initially wanted to use [rsync](https://linux.die.net/man/1/rsync) but I would
need to then have a remote VPS or transfer between my computers directly.  I
wanted a solution where all my files could be accessible to me without my
machine.

> **WARNING: This solution will cost you money!** DigitalOcean Spaces are $5 per
month and there are some bandwidth limitations and if you go beyond that you get
billed additionally.

Then I remembered that I could use something like
[S3](https://en.wikipedia.org/wiki/Amazon_S3) since it has versioning and is
fully managed. I didn't want to go down the AWS rabbit hole with this so I
choose [DigitalOcean Spaces](https://www.digitalocean.com/products/spaces/).

Then I needed a command-line tool to sync between source and target. I found
this nice tool [s3cmd](https://s3tools.org/s3cmd) and it is in the Ubuntu
repositories.

```bash
sudo apt install s3cmd
```

After installation will I create a new Space bucket on DigitalOcean. Remember
the zone you will choose because you will need it when you will configure
`s3cmd`.

Then I visited [Digitalocean Applications &
API](https://cloud.digitalocean.com/account/api/tokens) and generated **Spaces
access keys**. Save both key and secret somewhere safe because when you will
leave the page secret will not be available anymore to you and you will need to
re-generate it.

```bash
# enter your key and secret and correct endpoint
# my endpoint is ams3.digitaloceanspaces.com because
# I created my bucket in Amsterdam regiin
s3cmd --configure
```

After that I played around with options for `s3cmd` and got to the following
command.

```bash
# I executed this command from my projects folder
cd projects
s3cmd sync --delete-removed --exclude 'node_modules/*' --exclude '.git/*' --exclude '.venv/*' ./ s3://my-bucket-name/projects/
```

When syncing int he other direction you will need to change the order of the 
`SOURCE` and `TARGET` to `s3://my-bucket-name/projects/` and `./`.

> Be sure that all the paths have trailing slash so that sync knows that this 
> are directories.

I am planning to implement some sort of a `.ignore` file that will enable me to
have a project-specific exclude options.

I am currently running this every hour as a cronjob which is perfectly fine for
now when I am testing how this whole thing works and how it all will turn out.

I have also created a small Gnome extension which is still very unstable, but
when/if this whole experiment pays of I will share on Github.
