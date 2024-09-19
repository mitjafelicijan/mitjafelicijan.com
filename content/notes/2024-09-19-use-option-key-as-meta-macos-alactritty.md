---
title: "Use option key as meta in Alacritty under macOS"
url: use-option-key-as-meta-macos-alactritty.html
date: 2024-09-19T16:13:13+02:00
type: note
draft: false
tags: []
---

To use option key under macOS as Meta key use the option
`option_as_alt` and set it to `"Both"`.

This is the example for the newer Toml file format.

```toml
# ~/.alacritty.toml
[window]
option_as_alt = "Both"
```

And this is the older YAML format.

```yaml
# ~/.alacritty.yml
window:
  option_as_alt: Both
```

Check more at https://alacritty.org/config-alacritty.html#s20.
