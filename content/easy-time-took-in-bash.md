---
title: "Easy measure time took in a bash script"
url: easy-time-took-in-bash.html
date: 2023-05-28T17:53:20+02:00
type: note
draft: false
tags: [bash]
---

In Bash, the `$SECONDS` variable is a special variable that automatically keeps
track of the number of seconds since the current shell or script started
executing. It starts counting from the moment the script begins running.

```bash
#!/bin/bash

# Reset the timer to zero.
SECONDS=0

# Do something.
sleep 5

# Print the time elapsed.
echo "Time taken: $SECONDS seconds"
```
