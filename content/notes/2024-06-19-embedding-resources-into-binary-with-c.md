---
title: "Embedding resources into binary with C"
url: embedding-resources-into-binary-with-c.html
date: 2024-06-19T16:13:13+02:00
type: note
draft: false
tags: [c]
---

[Binary resource inclusion](https://en.cppreference.com/w/c/preprocessor/embed)
preprocessor has been put into the C23 standard but has not yet been
implemented by the compilers. 

Until then a workaround with
[`xxd`](https://en.cppreference.com/w/c/preprocessor/embed) is possible without
spending time on rolling out your own.

`xxd` has an option to export to C header file which makes this much easier.
This works for all files be that text files or binary ones such as images, etc.

Convert `text.txt` into a C header file with `xxd -i test.txt > test.h`. This
creates the following file and uses the filename for variable names.

```c
// test.h
unsigned char test_txt[] = {
  0x54, 0x68, 0x65, 0x20, 0x66, 0x69, 0x72, 0x73, 0x74, 0x20, 0x72, 0x75,
  0x6c, 0x65, 0x20, 0x69, 0x73, 0x20, 0x74, 0x79, 0x70, 0x69, 0x63, 0x61,
  0x6c, 0x20, 0x6f, 0x66, 0x20, 0x71, 0x75, 0x61, 0x6e, 0x74, 0x75, 0x6d,
  ...
  };
unsigned int test_txt_len = 547;
```

Then use it in C in this manner.

```c
// main.c
#include <stdio.h>
#include "test.h"

int main(void) {
  printf("Testing embedding of files into binary.\n");

  for (unsigned int i = 0; i < test_txt_len; i++) {
    printf("%02x ", test_txt[i]);
  }
  printf("\n\n");

  for (unsigned int i = 0; i < test_txt_len; i++) {
    printf("%c", test_txt[i]);
  }
  printf("\n\n");

  return 0;
}
```
