---
title: "Making cgit look nicer"
url: making-cgit-look-nicer.html
date: 2023-06-24T13:33:58+02:00
type: notes
draft: false
tags: [git]
---

For personal use I have a private Git server set up and I use GitHub just as a
mirror. By default the cgit theme looks a bit dated so I made the folowing
theme.

- `/etc/cgitrc`

```ini
css=/cgit.css
logo=/startrek.gif
favicon=/favicon.png
source-filter=/usr/lib/cgit/filters/syntax-highlighting-edited.sh
about-filter=/usr/lib/cgit/filters/about-formatting.sh

local-time=1
snapshots=tar.gz
repository-sort=age
cache-size=1000
branch-sort=age
summary-log=200
max-atom-items=50
max-repo-count=100

enable-index-owner=0
enable-follow-links=1
enable-log-filecount=1
enable-log-linecount=1

root-title=Place for code, experiments and other bullshit!
root-desc=
clone-url=git@git.mitjafelicijan.com:/home/git/$CGIT_REPO_URL

mimetype.gif=image/gif
mimetype.html=text/html
mimetype.jpg=image/jpeg
mimetype.jpeg=image/jpeg
mimetype.pdf=application/pdf
mimetype.png=image/png
mimetype.svg=image/svg+xml

readme=:README.md
readme=:readme.md

# Must be at the end!
virtual-root=/
scan-path=/home/git/
```

For `syntax-highlighting-edited.sh` follow instructions on
[https://wiki.archlinux.org/title/Cgit](https://wiki.archlinux.org/title/Cgit#Using_highlight).

- `/usr/share/cgit/cgit.css`

```css
* {
        font-size: 11pt;
}

body {
        font-family: monospace;
        background: white;
        padding: 1em;
}

th, td {
        text-align: left;
}

/* HEADER */

#header {
        margin-bottom: 1em;
}

#header .logo img {
        display: block;
        height: 3em;
        margin-right: 10px;
}

#header .sub.right {
        display: none;
}

/* FOOTER */

.footer {
        margin-top: 2em;
        font-style: italic;
}

.footer, .footer a {
        color: gray;
}

/* TABS */

.tabs a {
        margin-bottom: 2em;
        display: inline-block;
        margin-right: 1em;
}

.tabs td a:only-child {
        display: none;
}

/* HIDING ELEMENTS */

.cgit-panel, .form {
        display: none;
}

/* LISTS */

.list td, .list th {
        padding-right: 2em;
}

.list .nohover a {
        color: black;
}

.list .button {
        padding-right: 0.5em;
}

/* COMMIT */

.commit-subject {
        padding: 1em 0;
}

.decoration a {
        padding-left: 0.5em;
}

.commit-info th {
        padding-right: 1em;
}

.commit-subject {
        padding: 2em 0;
}

table.diff div.head {
        padding-top: 2em;
}

table.diffstat td {
        padding-right: 1em;
}

/* CONTENT */

.linenumbers {
        padding-right: 0.5em;
}

.linenumbers a {
        color: gray;
}

.pager {
        display: flex;
        list-style-type: none;
        padding: 0;
        gap: 0.5em;
}

/* DIFF COLORS */

table.diff {
        width: 100%;
}

table.diff td {
        white-space: pre;
}

table.diff td div.head {
        font-weight: bold;
        margin-top: 1em;
        color: black;
}

table.diff td div.hunk {
        color: #009;
}

table.diff td div.add {
        color: green;
}

table.diff td div.del {
        color: red;
}
```
