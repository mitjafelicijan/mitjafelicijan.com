---
title: "Bulk thumbnails"
permalink: /bulk-make-thumbnails.html
date: 2023-06-04T20:46:56+02:00
layout: post
type: note
draft: false
tags: [bash]
---

Make bulk thumbnails of JPGs with ImageMagick.

```sh
#!/bin/bash

directory="./images/"
dimensions="360x360"

for file in "$directory"*.jpg; do
  convert "$file" -resize $dimensions "$file" "${file%.*}-thumbnail.jpg"
done
```
