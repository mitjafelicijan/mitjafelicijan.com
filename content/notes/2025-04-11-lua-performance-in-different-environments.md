---
title: Lua performance in different environments
url: lua-performance-in-different-environments.html
date: 2025-04-11T16:13:13+02:00
type: note
draft: false
tags: []
---

A quick look into difference in performance when running Lua normally vs Luajit
vs Lua embedded in C program. 

You can also check code on GitHub
[@mitjafelicijan/probe/c-luajit](https://github.com/mitjafelicijan/probe/tree/master/c-luajit).

Do not take this data as a benchmark, it's just a naive quick checkup.

## Naive and intentionally slow implementation of Fibonacci sequence

```lua
-- Naive recursive implementation to increase the time of computation.
function fibonacci(n)
    if n == 0 then
        return 0
    elseif n == 1 then
        return 1
    else
        return fibonacci(n - 1) + fibonacci(n - 2)
    end
end

local n = 40
local result = fibonacci(n)
print("The " .. n .. "th Fibonacci number is: " .. result)
```

## Embedded Lua primer

```sh
#include <lua.h>
#include <lualib.h>
#include <lauxlib.h>

int main(void) {
    lua_State *L = luaL_newstate();
    luaL_openlibs(L);

    if (luaL_loadfile(L, "fibonacci.luac") || lua_pcall(L, 0, 0, 0)) {
        fprintf(stderr, "Error: %s\n", lua_tostring(L, -1));
        return 1;
    }

    lua_close(L);
    return 0;
}
```

## Quick results

| Lua    | Luajit | Lua embedded in C |
|--------|--------|-------------------|
| 6.006s | 1.065s | 1.065s            |

## Test script

```sh
#!/usr/bin/env bash

ITERATIONS=120

# Just Lua interpreter
for i in $(seq 1 $ITERATIONS); do
    echo "> lua run #$i/$ITERATIONS"
    /usr/bin/time -f "%e,%U,%S" lua fibonacci.lua > /dev/null 2>> out.lua.txt
done

# Using Luajit
for i in $(seq 1 $ITERATIONS); do
    echo "> luajit run #$i/$ITERATIONS"
    /usr/bin/time -f "%e,%U,%S" luajit fibonacci.lua > /dev/null 2>> out.luajit.txt
done

# With C and Luajit
for i in $(seq 1 $ITERATIONS); do
    echo "> cluajit run #$i/$ITERATIONS"
    /usr/bin/time -f "%e,%U,%S" ./fibonacci > /dev/null 2>> out.cluajit.txt
done
```
