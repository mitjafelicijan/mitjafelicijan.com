---
title: "Extract lines from a file with sed"
url: extract-lines-from-file-with-sed.html
date: 2024-02-15T10:04:28+02:00
type: note
draft: false
---

Easy way to extract line ranges (from line 200 to line 210) with sed.

```sh
sed -n '200,210p' data/Homo_sapiens.GRCh38.dna.chromosome.18.fa

# then pipe it to a new file with

sed -n '200,210p' data/Homo_sapiens.GRCh38.dna.chromosome.18.fa > new.fa
```

`head` or `tail` could be used to extract from begining of the end of the file.
