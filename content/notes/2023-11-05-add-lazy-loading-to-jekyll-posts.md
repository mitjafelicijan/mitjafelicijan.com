---
title: "Add lazy loading of images in Jekyll posts"
url: add-lazy-loading-to-jekyll-posts.html
date: 2023-11-05T09:04:28+02:00
type: note
draft: false
---

Normally you define images with `![]()` in markdown files. But jekyll also
provides a way to adding custom attributes to tags with `{:attr="value"}`.

If you have lots of posts this command will append `` to all
images in all your markdown files.

```md
![image-title](/path/to/your/image.jpg)
```

will become

```md
![image-title](/path/to/your/image.jpg)
```

Shell line bellow. Go into the folder where your posts are (probably `_posts`).

```sh
find . -type f -name "*.md" -exec sed -i -E 's/(\!\[.*\]\((.*?)\))$/\1/' {} \;
```

Under the hood this adds `loading="lazy"` to HTML `img` nodes.

That is about it.
