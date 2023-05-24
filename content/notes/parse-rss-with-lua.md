---
title: Parse RSS feeds with Lua
url: parse-rss-with-lua.html
date: 2023-05-23
type: notes
draft: false
tags: [lua, rss]
---

Example of parsing RSS feeds with Lua. Before running the script install:
- feedparser with `luarocks install feedparser`
- luasocket with `luarocks install luasocket`

```lua
local http = require("socket.http")
local feedparser = require("feedparser")

local feed_url = "https://mitjafelicijan.com/feed.rss"

local response, status, _ = http.request(feed_url)
if status == 200 then
  local parsed = feedparser.parse(response)

  -- Print out feed details.
  print("> Title   ", parsed.feed.title)
  print("> Author  ", parsed.feed.author)
  print("> ID      ", parsed.feed.id)
  print("> Entries ", #parsed.entries)

  for _, item in ipairs(parsed.entries) do
    print("GUID    ", item.guid)
    print("Title   ", item.title)
    print("Link    ", item.link)
    print("Summary ", item.summary)
  end
else
  print("! Request failed. Status:", status)
end
```
