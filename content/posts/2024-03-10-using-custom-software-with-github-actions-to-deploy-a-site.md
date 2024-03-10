---
title: "Using custom software with Github Actions to deploy a site"
url: using-custom-software-with-github-actions-to-deploy-a-site.html
date: 2024-03-10T15:30:11+01:00
type: post
draft: false
---

By default, GitHub uses Jekyll for their site generator which is fine,
but it has some issues and the complexity is not really worth it for me.

You could argue that Jekyll is simple, which it is to some degree,
but it can become complicated quite quickly if you start adding your
own spin on things.

A while ago I wrote a simple static site generator called "[jbmafp -
Just Build Me A Fucking Page](https://github.com/mitjafelicijan/jbmafp)"
which was a protest against [Hugo](https://gohugo.io). Hugo is fine but
again, if you try doing something that conflicts with the dogma they
prescribe you are in trouble.

I also moved this blog from self-hosted virtual machine to just GitHub
Pages. I didn't want to bother myself managing that server anymore. And
this presented a slight problem because I didn't want to use the default
`_docs` folder GitHub wants you to use, and I also didn't want to upload
`public` folder that gets generated to GitHub.

Thankfully, there is a way to use custom software to generate your site
like `jbmafp`.

To achieve this you need to create a file `.github/workflows/deploy.yaml`
in the root of your repository.

```yaml
name: Build and Deploy to Pages

on:
  push:
    branches: ["master"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v3
      - name: Setup Pages
        uses: actions/configure-pages@v3
      - name: Run a multi-line script
        run: |
          wget https://github.com/mitjafelicijan/jbmafp/releases/download/v0.1/jbmafp.zip
          unzip jbmafp.zip
          chmod +x jbmafp
          ./jbmafp -b
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: './public'
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v2
```

This is an example for `jbmafp`. When I execute `./jbmafp -b` the program
creates `public` folder and puts all content there. And the directive
`with: path: './public'` tells `actions/deploy-pages@v2` to look for
`public` folder instead of `docs` folder.

This can be used with anything, actually. Hugo, Gatsby, Astro, you
name it.
