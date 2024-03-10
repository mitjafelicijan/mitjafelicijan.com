---
title: Cache busting in Hugo
url: /cachebusting-in-hugo.html
date: 2023-05-01T12:00:00+02:00
type: note
draft: false
---

```html
\{\{ $cachebuster := delimit (shuffle (split (md5 "6fab11c6669976d759d2992eff1dd5be") "" )) "" \}\}

<link rel="stylesheet" href="/style.css?v=\{\{ $cachebuster \}\}">
```

This `6fab11c6669976d759d2992eff1dd5be` can be random string you generate use.
You can use whatever you want.
