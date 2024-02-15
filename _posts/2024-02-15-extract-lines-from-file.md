---
title: "Extract lines from a file with sed"
permalink: /extract-lines-from-file-with-sed.html
date: 2024-02-14T01:04:28+02:00
layout: post
type: note
draft: false
---

Easy way to extract line ranges (like from line 200 to line 210) with sed.

```sh
sed -n '200,210p' data/Homo_sapiens.GRCh38.dna.chromosome.18.fa

# then pipe it to a new file with

sed -n '200,210p' data/Homo_sapiens.GRCh38.dna.chromosome.18.fa > new.fa
```

`head` or `tail` could be used to extract from begining of the end of the file.
