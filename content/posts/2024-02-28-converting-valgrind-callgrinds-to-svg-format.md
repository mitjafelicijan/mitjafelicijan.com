---
title: Converting Valgrind callgrinds to SVG format
url: converting-valgrind-callgrinds-to-svg-format.html
date: 2024-02-28T03:23:00+01:00
type: post
draft: false
---

Lately I have been doing a lot of systems programming and profiling is
the name of the game when it comes to developing good software.

I found [Valgrind](https://valgrind.org) indispensable for profiling
and getting callgraphs.

Most of the time there are better alternatives that SVG to drill intro the
callgraphs but if you need to put put a callgraph on a webpage or maybe
send it to somebody that does not have all of the necessary software to
view these things then SVG is the perfect format for this.

Theses are couple of amazing applications to view callgraphs that get
exported by [Valgrind](https://valgrind.org):

- [Kcachegrind](https://kcachegrind.github.io/html/Home.html) - Linux
- [WinCacheGrind](https://ceefour.github.io/wincachegrind/) - Windows
- [Profiling Viewer](https://profilingviewer.com/) - macOS

This is how Kcachekrind looks with a callgraph loaded in. Not only that,
with Kcachegrind you can also explore assembly produced by the compiler
and get much more insight into the profile of your application.

![Kcachekrind screenshot](/assets/posts/valgrind-callgrind-svg/kcachegrind.png)

After this point you will need couple of things installed on your
system. I will show how you do this on Fedora 39.

```sh
# Install valgrind which will do the actual profiling.
sudo dnf install valgrind

# Install Kcachegrind for local visualizing.
sudo dnf install kcachegrind

# Install gprof2dot for conversion from .dot to .svg.
pip install gprof2dot  
```

Let's make a simple C program and test out profiling and the whole shebang.

```c
#include <stdio.h>

int main() {
  printf("Oh, hi Mark\n");
  return 0;
}
```

Then let's compile, convert to dot and then SVG file.

```shell
clang hi.c -o c-hi
valgrind --tool=callgrind --dump-instr=yes --collect-jumps=yes ./c-hi
gprof2dot --format=callgrind --output=out.c.dot --colormap=print callgrind.out.546168
cat out.c.dot | dot -Tsvg > out.c.svg
```

This gives us an SVG file like this.

![SVG callgrind for C program](/assets/posts/valgrind-callgrind-svg/out.c.svg)

And this also works on other binaries.

Lets give Zig a go.

```zig
const std = @import("std");

pub fn main() !void {
  std.debug.print("Oh, hi Mark!\n", .{});
}
```

Now repeat the whole compile, convert cycle.

```shell
zig build-exe hi.zig --name zig-hi
valgrind --tool=callgrind --dump-instr=yes --collect-jumps=yes ./zig-hi
gprof2dot --format=callgrind --output=out.zig.dot --colormap=print callgrind.out.546168
cat out.zig.dot | dot -Tsvg > out.zig.svg
```

![SVG callgrind for Zig program](/assets/posts/valgrind-callgrind-svg/out.zig.svg)

Now, to be fair
[Kcachegrind](https://kcachegrind.github.io/html/Home.html) is much nicer
for local exploration and digging deep into the callgraphs, but the SVG
format can still provide valid information for documentation and things
of that nature.
