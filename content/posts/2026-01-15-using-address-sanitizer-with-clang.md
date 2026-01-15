---
title: Using Address Sanitizer with clang
url: using-address-sanitizer-with-clang.html
date: 2026-01-15T16:13:13+02:00
type: post
draft: false
tags: []
---

## What -fsanitize=address does

- Enables AddressSanitizer (ASan): a compile and link time instrumentation plus
  runtime library that detects memory errors.
- Detects: out-of-bounds accesses (heap, stack, globals), use-after-free, some
  use-after-return, double/invalid free, and (on some platforms) leaks.
- How it works: instrumented memory accesses are checked against a shadow
  memory; violations produce an error report with a stack trace and abort the
  program.
- Trade-offs: ~2x runtime slowdown (varies), higher memory use, large virtual
  address space reservation on 64-bit, and requires linking the ASan runtime
  (not suitable for production builds).
- Usage: compile and link with `-fsanitize=address` (and typically `-g` and
  `-O0`). Runtime behavior can be tuned via `ASAN_OPTIONS` and
  symbolization via llvm-symbolizer.

More about ASan on https://clang.llvm.org/docs/AddressSanitizer.html.

## An example how to use it

```c
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

int main(void) {
    char *p = malloc(10);
    if (!p) return 1;

    // Out-of-bounds write (heap buffer overflow).
    strcpy(p, "This string is way too long for the buffer");

    // Use-after-free (unreachable if program aborts on previous error).
    free(p);
    p[0] = 'x';

    return 0;
}
```

Now let's compile with proper flags with `clang -O0 -g -fsanitize=address -o
main main.c`.

If you run the binary it should trigger ASan.  You can also specify what to
show with `ASAN_OPTIONS=detect_leaks=1:verbosity=1:symbolize=1 ./main` and you
should see something like this.

```text
MemToShadow(shadow): 0x00008fff7000 0x000091ff6dff 0x004091ff6e00 0x02008fff6fff
redzone=16
max_redzone=2048
quarantine_size_mb=256M
thread_local_quarantine_size_kb=1024K
malloc_context_size=30
SHADOW_SCALE: 3
SHADOW_GRANULARITY: 8
SHADOW_OFFSET: 0x00007fff8000
==28825==Installed the sigaction for signal 11
==28825==Installed the sigaction for signal 7
==28825==Installed the sigaction for signal 8
==28825==T0: FakeStack created: 0x7be4d10f7000 -- 0x7be4d1c00000 stack_size_log: 20; mmapped 11300K, noreserve=0
==28825==T0: stack [0x7ffcf551c000,0x7ffcf5d1c000) size 0x800000; local=0x7ffcf5d1a664
==28825==AddressSanitizer Init done
=================================================================
==28825==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c04d25e001a at pc 0x5653c583826a bp 0x7ffcf5d1a5f0 sp 0x7ffcf5d19da8
WRITE of size 43 at 0x7c04d25e001a thread T0
    #0 0x5653c5838269 in strcpy (/home/m/Junk/fsanitize/main+0xb7269) (BuildId: 69a0723cc8e27d59eb584f6cc902f6f12915111a)
    #1 0x5653c5894e13 in main /home/m/Junk/fsanitize/main.c:10:5
    #2 0x7fe4d328bbfb in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16
    #3 0x7fe4d328bcb4 in __libc_start_main@GLIBC_2.2.5 csu/../csu/libc-start.c:360:3
    #4 0x5653c57ad360 in _start /builddir/glibc-2.41/csu/../sysdeps/x86_64/start.S:115

0x7c04d25e001a is located 0 bytes after 10-byte region [0x7c04d25e0010,0x7c04d25e001a)
allocated by thread T0 here:
    #0 0x5653c5851ca4 in malloc (/home/m/Junk/fsanitize/main+0xd0ca4) (BuildId: 69a0723cc8e27d59eb584f6cc902f6f12915111a)
    #1 0x5653c5894de8 in main /home/m/Junk/fsanitize/main.c:6:15
    #2 0x7fe4d328bbfb in __libc_start_call_main csu/../sysdeps/nptl/libc_start_call_main.h:58:16

SUMMARY: AddressSanitizer: heap-buffer-overflow (/home/m/Junk/fsanitize/main+0xb7269) (BuildId: 69a0723cc8e27d59eb584f6cc902f6f12915111a) in strcpy
Shadow bytes around the buggy address:
  0x7c04d25dfd80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7c04d25dfe00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7c04d25dfe80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7c04d25dff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x7c04d25dff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x7c04d25e0000: fa fa 00[02]fa fa fa fa fa fa fa fa fa fa fa fa
  0x7c04d25e0080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7c04d25e0100: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7c04d25e0180: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7c04d25e0200: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x7c04d25e0280: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==28825==ABORTING
```
