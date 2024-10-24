---
title: Projects
date: 2024-10-21T12:00:00+02:00
url: projects.html
type: page
draft: false
---

- [Simple snapshot manager](#simple-snapshot-manager)
- [Just build me a fucking page](#just-build-me-a-fucking-page)
- [Clutch, nested X11 dwm sessions](#clutch-nested-x11-dwm-sessions)

While most of my projects are hosted on
[GitHub](https://github.com/mitjafelicijan), I wanted a centralized location to
store them independently of GitHub and provide different versions in a bit
cleaner way.

## Simple snapshot manager

Simple snapshot utility that uses TAR to compress current directory into a
`.tar` file while ignoring some of the directories.
[GitHub repository](https://github.com/mitjafelicijan/sm).

- Version 0.1 / 2024-10-21 ([sm-v0.1.tar](/snapshots/sm-v0.1.tar))
  - First release.
  - Able to tag and create tar snapshots.

## Clutch, nested X11 dwm sessions

Clutch allows you to run nested dwm session inside your existing X or Wayland
session. This comes in handy when you already have a desktop environment
running (like Gnome) but you want to have a tiling window manager as well.
[GitHub repository](https://github.com/mitjafelicijan/clutch).

- Version 0.1 / 2024-07-19 ([clutch-v0.1.tar](/snapshots/clutch-v0.1.tar))
  - First release.

## Just build me a fucking page

A simple static site generator that is semi compatible with
[Hugo](https://gohugo.io/) and aims to be a simpler version of it, getting out
of your way when it comes to taxonomies. [GitHub
repository](https://github.com/mitjafelicijan/jbmafp).

- Version 0.3 / 2024-06-22 ([jbmafp-v0.3.tar](/snapshots/jbmafp-v0.3.tar))
  - Added better ergonomics for filtering.
  - Added filter `filterbytype`.
- Version 0.2 / 2024-06-18 ([jbmafp-v0.2.tar](/snapshots/jbmafp-v0.2.tar))
  - Added filters `first`, `last`, `random`.
- Version 0.1 / 2024-03-10 ([jbmafp-v0.1.tar](/snapshots/jbmafp-v0.1.tar))
  - First release.
