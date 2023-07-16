---
title: "Simple presentations with Markdown"
url: presentations-with-markdown.html
date: 2023-06-21T08:54:48+02:00
type: note
draft: false
tags: [random]
---

A simple way to make presentations without using desktop apps or using online
services is https://github.com/remarkjs/remark.

First create `index.html` and be sure you make changes to `config` variable.

```html
<!DOCTYPE html>
<html>

<head>
    <title></title>
    <meta charset="utf-8">
    <style>
        body {
            font-family: 'SF Pro Display';
        }

        .remark-code,
        .remark-inline-code {
            font-family: 'SF Mono';
            font-size: medium;
            background-color: gainsboro;
            border-radius: 5px;
            padding: 0 5px;
        }
    </style>
</head>

<body>
    <textarea id="source"></textarea>
    <script src="https://remarkjs.com/downloads/remark-latest.min.js"></script>
    <script>
		const config = {
			title: 'My presentation',
			file: 'presentation.md',
		};
	
		document.title = config.title;
        remark.create({ sourceUrl: config.file });
    </script>
</body>

</html>
```

Now the markdown file `presentation.md` with presenetation. `---` is used to
separate slides. Other stuff is just pure markdown.

```md
class: center, middle

# Main title of the presentation

---

# Fist slide

Eveniet mollitia nemo architecto rerum aut iure iste. Sit nihil nobis libero iusto fugit nam laudantium ut. Dignissimos corrupti laudantium nisi.

- Lorem ipsum dolor sit amet, consectetur adipiscing elit.
- Integer aliquet mauris a felis fringilla, ut congue massa finibus.

---

# Slide two

- Lorem ipsum dolor sit amet, consectetur adipiscing elit.
- Vestibulum eget leo ac dolor venenatis pulvinar.
```
