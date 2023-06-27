---
title: Trying out Helix code editor as my main editor
url: tying-out-helix-code-editor.html
date: 2022-06-30T12:00:00+02:00
draft: false
---

I have been searching for a lightweight code editor for quite some time. One of
the main reasons was that I wanted something that doesn't burn through CPU and
RAM usage is not through the roof. I have been mostly using Visual Studio Code.
It's been an outstanding editor. I have no quarrel with it at all. It's just
time to spice life up with something new.

I have been on this search for a couple of years. I have tried Vim, Neovim,
Emacs, Doom Emacs, Micro and couple more. Among most of them, I liked Micro and
Doom Emacs the most. Micro editor was a little too basic for me. And Doom Emacs
was a bit too hardcore. This does not reflect on any of the editors. It's just
my personal preference.

> I tried Helix Editor about a year ago. But I didn't pay attention to it.
> Tried it and saw it's similar to Vi and just said no. I was premature to
> dismiss it.

One of the things I actually miss is line wrapping for certain files. When
writing Markdown, line wrapping would be very helpful. Editing such a document
is frustrating to say the least. Some of the Markdown to HTML converters don't
take kindly of new lines between sentences. Not paragraphs, sentences. And I use
Markdown to write this blog you are reading.

But other than this, I have been extremely satisfied by it. It's been a pleasant
surprise. There have been zero issues with the editor.

One thing to do before you are able to use autocompletion and make use Language
Server support is to install the language server with NPM.

```sh
npm install -g typescript typescript-language-server
```

I am still getting used to the keyboard shortcuts and getting better. What Helix
does really well is packing in sane defaults and even though because currently
there is no plugin support I haven't found any need for them. It has all that
you would need. It goes to extreme measures to show a user what is going on with
popups that show you what the keyboard shortcuts are.

And it comes us packed with many
[really good themes](https://github.com/helix-editor/helix/wiki/Themes).

![Editor](/assets/helix-editor/editor.png)

It's still young but has this mature feeling to it. It has sane defaults and
mimics Vim (works a bit differently, but the overall idea is similar).
