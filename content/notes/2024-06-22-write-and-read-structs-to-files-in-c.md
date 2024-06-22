---
title: "Write and read structs to/from files in C"
url: write-and-read-structs-to-files-in-c.html
date: 2024-06-22T16:13:13+02:00
type: note
draft: false
tags: [c]
---

First let's define a shared header file for the struct definition.

```c
// struct.h
typedef struct {
    char name[50];
    int health;
    float damage;
} Character;
```

Now lets write it to a `character.dat` file.

```c
// write.c
#include <stdio.h>
#include <string.h>

#include "struct.h"

int main(void) {
    printf("Write struct\n");

    Character ch;

    strcpy(ch.name, "John Doe");
    ch.health = 30;
    ch.damage = 5.9;

    FILE* file = fopen("character.dat", "wb");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    fwrite(&ch, sizeof(Character), 1, file);
    fclose(file);

    return 0;
}
```

And reading and serializing back to a struct.

```c
// read.c
#include <stdio.h>

#include "struct.h"

int main(void) {
    printf("Read struct\n");

    Character ch;

    FILE* file = fopen("character.dat", "rb");
    if (file == NULL) {
        perror("Error opening file");
        return 1;
    }

    fread(&ch, sizeof(Character), 1, file);
    fclose(file);

    printf("Name: %s\n", ch.name);
    printf("Health: %d\n", ch.health);
    printf("Damage: %.1f\n", ch.damage);

    return 0;
}
```

