---
title: Show uptime per boot session on Linux systems
url: show-uptime-per-boot-session-on-linux-systems.html
date: 2026-06-08T16:13:13+02:00
type: note
draft: false
tags: []
---

Parses `last reboot` output to show how long each boot session lasted, sorted
longest-first. The `-F` (full date) and `-w` (wide) flags give complete
timestamps.

```sh
last reboot -F -w | awk '
/^reboot/ {
    start = $5" "$6" "$7" "$8" "$9
    cmd = "date -d \"" start "\" +%s"
    cmd | getline ts
    close(cmd)

    if (prev_ts != "") {
        diff = prev_ts - ts
        days = int(diff / 86400)
        hours = int((diff % 86400) / 3600)
        mins = int((diff % 3600) / 60)

        printf "%4dd %02dh %02dm  booted: %s\n", days, hours, mins, start
    }

    prev_ts = ts
}' | sort -nr
```


The results should look something like this:

```txt
 191d 22h 58m  booted: Thu Nov 20 18:22:58 2025
  89d 04h 49m  booted: Wed Apr 2 09:23:05 2025
  85d 01h 48m  booted: Wed Jul 23 13:08:34 2025
  48d 22h 04m  booted: Fri Dec 6 17:38:10 2024
  43d 11h 34m  booted: Tue Oct 1 07:11:49 2024
  40d 19h 27m  booted: Thu Feb 20 12:55:40 2025
  35d 04h 26m  booted: Thu Oct 16 14:56:34 2025
  26d 21h 12m  booted: Fri Jan 24 15:43:01 2025
  22d 23h 51m  booted: Wed Nov 13 17:46:13 2024
  22d 22h 55m  booted: Mon Jun 30 14:12:51 2025
   6d 05h 52m  booted: Sun May 31 18:21:19 2026
   4d 00h 24m  booted: Thu Sep 26 07:33:16 2024
   1d 22h 32m  booted: Sun Jun 7 00:13:43 2026
   0d 23h 13m  booted: Mon Sep 30 07:58:09 2024
   0d 01h 01m  booted: Thu Sep 26 05:46:49 2024
   0d 00h 45m  booted: Thu Sep 26 06:48:05 2024
   0d 00h 05m  booted: Thu Sep 26 05:41:34 2024
   0d 00h 05m  booted: Thu Sep 26 05:33:34 2024
   0d 00h 02m  booted: Thu Sep 26 05:39:08 2024
```
