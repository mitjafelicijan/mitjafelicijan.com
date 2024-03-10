---
title: "Re-Inventing Task Runner That I Actually Used Daily"
url: /re-inventing-task-runner-that-i-actually-used-daily.html
date: 2023-05-31T12:21:10+02:00
type: post
draft: false
---

Couple of months ago I had this brilliant idea of re-inventing the wheel by
making an alternative for make. And so I went. Boldly into the battle. And to my
big surprise my attempt resulted in not a completely useless piece of software.

My initial requirements were quite simple but soon grow into something more
ambitious. And looking back I should have stuck to the simple version. My
laziness was on my side this time though. Because I haven’t implemented some of
the features I now realise I really didn’t need them and they would bog the
whole program and make it be something it was never meant to be.

My basic requirements were following:

- Syntax should be a tiny bit inspired by Rake and Rakefiles.
- Should borrow the overall feel of a unit test experience.
- Using something like Python would be a bit of an overkill.
- The program must be statically compiled, so it can run on same architecture
  without libc, musl dependencies or things like that.
- Install ruby for rake is a bit overkill and can not be done with certain
  really lightweight distributions like Alpine Linux. This tool would be usable
  on such lightweight systems for remote debugging.
- I want to use it for more than just compiling things. I want to use it as an
  entry-point into a project, and I want this to help me indirectly document the
  project as well.
- It should be an abstraction over bash shell or the default system shell.
    - Each task essentially becomes its own shell instance.
- Must work on Linux and macOS systems.
- By default, running `erd` list all the available tasks (when I use make, I
  usually put a disclaimer that you should check Makefile to see all available
  target).
- Should support passing arguments when you run it from a shell.
- Normal variable as the same as environmental variables. There is no
  distinction. Every variable is also essentially an environment variable and
  can be used by other programs.
- State between tasks is not shared, and this makes this “pure” shell instances.
- Should be single-threaded for the start and later expanded with `@spawn`
  command.
- Variables behave like macros and are preprocessed before evaluation.
- Should support something like `assure` that would check if programs like C
  compiler or Python (whatever the project requires) are installed on a machine.

Quite a reasonable list of requirements. I do this things already in my
Makefiles or/and Bash scripts. But I would like to avoid repeating myself every
time I start working on something new.

So I started with the following syntax.

```ruby
@env on

# Override the default shell.
@shell /bin/bash

# Assure that program is installed.
@assure docker-compose pip python3

# Load local dotenv files (these are then globally available).
@dotenv .env
@dotenv .env.sample
@dotenv some_other_file

# This are local variables but still accessible in tasks.
@var HI = "hey"
@var TOKEN = "sometoken"
@var EMAIL = "m@m.com"
@var PASSWORD = "pass"
@var EDITOR = "vim"

@task dev "Test chars .:'}{]!//" does
  echo "..." $HI
end

@task clean "Cleans the obj files" does
  rm .obj
end

@task greet "Greets the user" does
  echo "Hi user $TOKEN or $WINDOWID $EMAIL"
end

@task stack "Starts Docker stack" does
  docker-compose -f stack.yml up
end

@task todo "Shows all todos in source files and count them" does
  grep -ir "TODO|FIXME" . | wc -l
end

@task test1 "For testing 1" does
  unknown-command
  echo "test1"
  ls -lha
end

@task test2 "For testing 2" does
  echo "test1"
  ls -lha
  docker-compose -f samples/stack.yml up
end
```

One thing that I really like about Errand. Yes, this is what it is called. And
it is available at https://git.mitjafelicijan.com/errand.git/about/. Moving
on. One thing that I really like is that a task is a persistent shell. By that I
mean, that the whole task, even if it contains multiple command in one shell.
In make each line in a target is that and you need to combine lines or add `\`
at the end of the line.

```bash
# How you do this things in make.
target:
	source .venv/bin/activate \
	python script.py
```

This solves this problem. Consider each task and what is being executed in that
task a shell that will only close when all the tasks are completed.

By self-documenting I mean that if you are in a directory with `Errandfile` in,
if you only type `erd` and press enter it should by default display all the
possible targets. In make i was doing this by having a first target be something
like `default` that echos the message “Check Makefile for all available target.”
Because all of the tasks in Errand require a message I use that to display let’s
call it table of contents.

Because I don’t use any external dependencies this whole thing can be statically
compiled. So that also checked one of the boxes.

It works on Linux and on a Mac so that’s also a bonus. I don’t believe this
would work on Windows machines because of the way that I use shell instances. By
you could use something like Windows Subsystem for Linux and run it in
there. That is a valid option.

To finish this essay off, how was it to use it in “real life”. I have to be
honest. Some of the missing features still bother me. `@dotenv` directive is
still missing and I need to implement this ASAP.

Another thing that needs to happen is support for streaming output. Currently
commands like `docker-compose` that runs in foreground mode is not compatible
with Errand. So commands that stream output are an issue.  I need to revisit how
I initiate shell and how I read stdout and stderr.  But that shouldn’t be a
problem.

I have been very satisfied with this thing. I am pleasantly surprised by how
useful it is. I really wanted to test this in the wild before I commit to it. I
have more abandoned project than Google and it’s bringing a massive shame to my
family at this point. So I wanted to be sure that this is even useful. And it
actually is. Quite surprised at myself.

I really need to package this now and write proper docs. And maybe rewrite
tokeniser. Its atrocious right now. Site to behold! But that is an issue for
another time.
