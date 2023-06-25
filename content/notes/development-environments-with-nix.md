---
title: "Development environments with Nix"
url: development-environments-with-nix.html
date: 2023-06-25T16:38:10+02:00
type: notes
draft: false
tags: [random]
---

Nix is amazing for making reproducible cross OS development environment.

First you need to [install Nix package manager](https://nixos.org/download.html).

- Create a file `shell.nix` in your project folder.
- In the section that has `python3` etc add programs you want to use. These can
  be CLI or GUI applications. It doesn't matter to Nix.

```nix
{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = with pkgs.buildPackages; [
	  python3
	  tinycc
	];
}
```

And then run it `nix-shell`. By default it will look for `shell.nix` file. If
you want to specify a different file use `nix-shell file.nix`. That is about it.

When the shell is spawned it could happen that your `PS1` prompt will be
overwritten and your prompt will look differently. In that case you need to
either do `NIX_SHELL_PRESERVE_PROMPT=1 nix shell` or add
`NIX_SHELL_PRESERVE_PROMPT` variable to your `bashrc` or `zshrc` file and set it
to `1`.

I also have a modified `PS1` prompt for Bash that I use and it also catches the
usage of Nix shell.

```sh
NIX_SHELL_PRESERVE_PROMPT=1

parse_git_branch() {
	git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

is_inside_nix_shell() {
	nix_shell_name="$(basename "$IN_NIX_SHELL" 2>/dev/null)"
	if [[ -n "$nix_shell_name" ]]; then
		echo " \e[0;36m(nix-shell)\e[0m"
	fi
}

export PS1="[\033[38;5;9m\]\u@\h\[$(tput sgr0)\]]$(is_inside_nix_shell)\[\033[33m\]\$(parse_git_branch)\[\033[00m\] \w\[$(tput sgr0)\] \n$ "
```

And this is what it looks like when you are in a Nix shell. Otherwise that part
of prompt is omitted

![PS1 Prompt](/notes/ps1-prompt.png)

More resources:

- https://nixos.wiki/wiki/Development_environment_with_nix-shell
- https://nixos.wiki/wiki/Main_Page
- https://itsfoss.com/why-use-nixos/
- https://mynixos.com/
