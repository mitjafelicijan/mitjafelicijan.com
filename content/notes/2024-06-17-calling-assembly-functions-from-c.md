---
title: "Calling assembly functions from C"
url: calling-assembly-functions-from-c.html
date: 2024-06-17T16:12:13+02:00
type: note
draft: false
---

This is using the portable GNU assembler and TinyCC compiler but GCC or Clang
can be used as well.

First lets define a simple function in assembly.

```asm
# sum.s
.intel_syntax noprefix

.global sum

.text

sum:
    add rdi, rsi
    mov rax, rdi
    ret
```

Lets compile this with GNU assembler `as sum.s -o sum.o`.

Now we need a C program that calls this function.

```c
// main.c
#include <stdio.h>

// We need to define the signature of the function.
int sum(int a, int b);

int main() {
    for(int i=0; i<10; ++i) {
        printf("SUM of 5+%d is %d\n", i, sum(5, i));
    }
    return 0;
}
```

Now lets compile and link into final program with `tcc main.c sum.o -o main`.

