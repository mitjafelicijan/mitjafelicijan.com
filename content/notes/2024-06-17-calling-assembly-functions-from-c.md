---
title: "Calling assembly functions from C"
url: calling-assembly-functions-from-c.html
date: 2024-06-17T16:12:13+02:00
type: note
draft: false
tags: [c]
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

Use this table to see what each register is being used for.

| Register | Conventional use                | Low 32-bits | Low 16-bits | Low 8-bits |
|----------|---------------------------------|-------------|-------------|------------|
| %rax     | Return value, caller-saved      | %eax        | %ax         | %al        |
| %rdi     | 1st argument, caller-saved      | %edi        | %di         | %dil       |
| %rsi     | 2nd argument, caller-saved      | %esi        | %si         | %sil       |
| %rdx     | 3rd argument, caller-saved      | %edx        | %dx         | %dl        |
| %rcx     | 4th argument, caller-saved      | %ecx        | %cx         | %cl        |
| %r8      | 5th argument, caller-saved      | %r8d        | %r8w        | %r8b       |
| %r9      | 6th argument, caller-saved      | %r9d        | %r9w        | %r9b       |
| %r10     | Scratch/temporary, caller-saved | %r10d       | %r10w       | %r10b      |
| %r11     | Scratch/temporary, caller-saved | %r11d       | %r11w       | %r11b      |
| %rsp     | Stack pointer, callee-saved     | %esp        | %sp         | %spl       |
| %rbx     | Local variable, callee-saved    | %ebx        | %bx         | %bl        |
| %rbp     | Local variable, callee-saved    | %ebp        | %bp         | %bpl       |
| %r12     | Local variable, callee-saved    | %r12d       | %r12w       | %r12b      |
| %r13     | Local variable, callee-saved    | %r13d       | %r13w       | %r13b      |
| %r14     | Local variable, callee-saved    | %r14d       | %r14w       | %r14b      |
| %r15     | Local variable, callee-saved    | %r15d       | %r15w       | %r15b      |
| %rip     | Instruction pointer             |             |             |            |
| %rflags  | Status/condition code bits      |             |             |            |

You can read more about [x86-64 Machine-Level Programming](/assets/notes/asm64-handout.pdf).

