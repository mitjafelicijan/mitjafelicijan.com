---
title: Extend Lua with custom C functions using Clang
url: extend-lua-with-custom-c.html
date: 2023-05-23T12:00:00+02:00
type: notes
draft: false
tags: [lua, clang, c]
---

Here is a boilerplate for extending Lua with custom C functions. This requires
Clang and Lua 5.1 to be installed. GCC can be used instead of Clang, but the
Makefile will need to be modified.

- nativefunc.c

  ```c
  #include <lua.h>
  #include <lauxlib.h>

  static int l_mult50(lua_State *L) {
    double number = luaL_checknumber(L, 1);
    lua_pushnumber(L, number * 50);
    return 1;
  }

  int luaopen_nativefunc(lua_State *L) {
    static const struct luaL_Reg nativeFuncLib[] = {{"mult50", l_mult50}, {NULL, NULL}};

    luaL_register(L, "nativelib", nativeFuncLib);
    return 1;
  }
  ```

- main.lua

  ```lua
  require "nativefunc"
  print(nativelib.mult50(50))
  ```

- Makefile

  ```Makefile
  CC       = clang
  CFLAGS   =
  INCLUDES = `pkg-config lua5.1 --cflags-only-I`

  all:
    $(CC) -shared -o nativefunc.so -fPIC nativefunc.c $(CFLAGS) $(INCLUDES)

  clean:
    rm *.so
  ```

