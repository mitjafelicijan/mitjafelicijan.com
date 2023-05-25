---
title: "#cat-v on weechat configuration"
url: catv-weechat-config.html
date: 2023-05-09T12:00:00+02:00
type: notes
draft: false
tags: [irc, weechat, cat-v]
---

Set up weechat to connect to #cat-v on oftc. This applies to [weechat](https://weechat.org/)
but should be similar for other irc clients.

```sh
# Install weechat and launch it and execute the following commands.

/server add oftc irc.oftc.net -tls
/set irc.server.oftc.autoconnect on
/set irc.server.oftc.autojoin "#cat-v"
/set irc.server.oftc.nicks "nick1,nick2,nick3"
```
