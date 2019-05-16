---
layout: post
title: Golang profiling simplified
description: Golang profiling made easy
slug: golang-profiling-simplified
type: note
date: 2017-03-07
---

**Table of contents**

1. [Where are my pprof files?](#where-are-my-pprof-files)
2. [Why is my cpu profile empty?](#why-is-my-cpu-profile-empty)
3. [Profiling](#profiling)
   1. [Memory profiling](#memory-profiling)
   2. [CPU profiling](#cpu-profiling)
   3. [Generating profiling reports](#generating-profiling-reports)

Many posts have been written regarding profiling in Golang and I haven’t found proper tutorial regarding this. Almost all of them are missing some part of important information and it gets pretty frustrating when you have a deadline and are not finding simple distilled solution.

Nevertheless, after searching and experimenting I have found a solution that works for me and probably should also for you.

## Where are my pprof files?

By default pprof files are generated in /tmp/ folder. You can override folder where this files are generated programmatically in your golang code as we will see below in example.

## Why is my cpu profile empty?

I have found out that sometimes CPU profile is empty because program was not executing long enough. Programs, that execute too quickly don’t produce pprof file in my cases. Well, file is generated but only contains 4KB of information.

## Profiling

As you can see from examples we are executing dummy_benchmark functions to ensure some sort of execution. Memory profiling can be done without such a “complex” function. But CPU profiling needs it.

Both memory and CPU profiling examples are almost the same. Only parameters in main function when calling profile.Start are different. When we set profile.ProfilePath(“.”) we tell profiler to store pprof files in the same folder as our program.

### Memory profiling

```go
package main

import (
  "fmt"
  "time"
  "github.com/pkg/profile"
)

func dummy_benchmark() {

  fmt.Println("first set ...")
  for i := 0; i < 918231333; i++ {
    i *= 2
    i /= 2
  }

  <-time.After(time.Second*3)

  fmt.Println("sencond set ...")
  for i := 0; i < 9182312232; i++ {
    i *= 2
    i /= 2
  }
}

func main() {
  defer profile.Start(profile.MemProfile, profile.ProfilePath("."), profile.NoShutdownHook).Stop()
  dummy_benchmark()
}
```

### CPU profiling

```go
package main

import (
  "fmt"
  "time"
  "github.com/pkg/profile"
)

func dummy_benchmark() {

  fmt.Println("first set ...")
  for i := 0; i < 918231333; i++ {
    i *= 2
    i /= 2
  }

  <-time.After(time.Second*3)

  fmt.Println("sencond set ...")
  for i := 0; i < 9182312232; i++ {
    i *= 2
    i /= 2
  }
}

func main() {
  defer profile.Start(profile.CPUProfile, profile.ProfilePath("."), profile.NoShutdownHook).Stop()
  dummy_benchmark()
}
```

### Generating profiling reports

```bash
# memory profiling
go build mem.go
./mem
go tool pprof -pdf ./mem mem.pprof > mem.pdf

# cpu profiling
go build cpu.go
./cpu
go tool pprof -pdf ./cpu cpu.pprof > cpu.pdf
```

This will generate PDF document with visualized profile.

- [Memory PDF profile example](/files/golang-profiling-mem.pdf)
- [CPU PDF profile example](/files/golang-profiling-cpu.pdf)
