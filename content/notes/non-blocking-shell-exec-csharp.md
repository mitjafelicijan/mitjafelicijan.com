---
title: Execute not blocking async shell command in C#
url: non-blocking-shell-exec-csharp.html
date: 2023-05-22T12:00:00+02:00
type: notes
draft: false
tags: [csharp, async, shell]
---

Execute a shell command in async in C# while not blocking the UI thread.

```c#
private async Task executeCopyCommand()
{
  await Task.Run(() =>
  {
    var processStartInfo = new ProcessStartInfo("cmd", "/c dir")
    {
      RedirectStandardOutput = true,
      UseShellExecute = false,
      CreateNoWindow = true
    };

    var process = new Process
    {
      StartInfo = processStartInfo
    };

    process.Start();
    process.WaitForExit();
  });
}
```

Make sure that `async` is present in the function definition and `await` is
used in the method that calls `executeCopyCommand()`.

```c#
private async void button_Click(object sender, EventArgs e)
{
  await executeCopyCommand();
}
```
