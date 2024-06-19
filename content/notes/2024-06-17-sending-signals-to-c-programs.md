---
title: "Sending signals to C programs"
url: sending-signals-to-c-program.html
date: 2024-06-17T16:13:13+02:00
type: note
draft: false
tags: [c]
---

For simple and easy IPC to the C program we can use signals.
https://www.man7.org/linux/man-pages/man7/signal.7.html

Only two user defined signals are available (`SIGUSR1` and `SIGUSR2`) but you
can hijack other ones even though this is really not advisable.

```c
// signal.c
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>

void handle_signal(int signal) {
    printf("Signal received: %d\n", signal);
}

int main() {
    signal(SIGUSR1, handle_signal); // is equal to 10
    signal(SIGUSR2, handle_signal); // is equal to 12

    while(1) {
        sleep(1);
    }

    return 0;
}
```

Compile with `gcc -o signal signal.c` and run the program with `./signal` and
then from another terminal send the signal to the program with `kill -10
$(pidof signal)` which should print out `Signal received: 10`.

| Signal      | x86/ARM | Alpha/ | MIPS   | PARISC | Notes         |
|-------------|---------|--------|--------|--------|---------------|
| SIGHUP      | 1       | 1      | 1      | 1      |               |
| SIGINT      | 2       | 2      | 2      | 2      |               |
| SIGQUIT     | 3       | 3      | 3      | 3      |               |
| SIGILL      | 4       | 4      | 4      | 4      |               |
| SIGTRAP     | 5       | 5      | 5      | 5      |               |
| SIGABRT     | 6       | 6      | 6      | 6      |               |
| SIGIOT      | 6       | 6      | 6      | 6      |               |
| SIGBUS      | 7       | 10     | 10     | 10     |               |
| SIGEMT      | -       | 7      | 7      | -      |               |
| SIGFPE      | 8       | 8      | 8      | 8      |               |
| SIGKILL     | 9       | 9      | 9      | 9      |               |
| **SIGUSR1** | **10**  | **30** | **16** | **16** |               |
| SIGSEGV     | 11      | 11     | 11     | 11     |               |
| **SIGUSR2** | **12**  | **31** | **17** | **17** |               |
| SIGPIPE     | 13      | 13     | 13     | 13     |               |
| SIGALRM     | 14      | 14     | 14     | 14     |               |
| SIGTERM     | 15      | 15     | 15     | 15     |               |
| SIGSTKFLT   | 16      | -      | -      | 7      |               |
| SIGCHLD     | 17      | 20     | 18     | 18     |               |
| SIGCLD      | -       | -      | 18     | -      |               |
| SIGCONT     | 18      | 19     | 25     | 26     |               |
| SIGSTOP     | 19      | 17     | 23     | 24     |               |
| SIGTSTP     | 20      | 18     | 24     | 25     |               |
| SIGTTIN     | 21      | 21     | 26     | 27     |               |
| SIGTTOU     | 22      | 22     | 27     | 28     |               |
| SIGURG      | 23      | 16     | 21     | 29     |               |
| SIGXCPU     | 24      | 24     | 30     | 12     |               |
| SIGXFSZ     | 25      | 25     | 31     | 30     |               |
| SIGVTALRM   | 26      | 26     | 28     | 20     |               |
| SIGPROF     | 27      | 27     | 29     | 21     |               |
| SIGWINCH    | 28      | 28     | 20     | 23     |               |
| SIGIO       | 29      | 23     | 22     | 22     |               |
| SIGPOLL     |         |        |        |        | Same as SIGIO |
| SIGPWR      | 30      | 29/-   | 19     | 19     |               |
| SIGINFO     | -       | 29/-   | -      | -      |               |
| SIGLOST     | -       | -/29   | -      | -      |               |
| SIGSYS      | 31      | 12     | 12     | 31     |               |
| SIGUNUSED   | 31      | -      | -      | 31     |               |

