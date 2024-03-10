---
title: "AWS EB PyYAML fix"
url: /aws-eb-pyyaml-fix.html
date: 2023-09-18T07:27:29+02:00
type: note
draft: false
---

Recent update of my system completely borked [EB CLI](https://docs.aws.amazon.com/elasticbeanstalk/latest/dg/eb-cli3-install-advanced.html)
on my machine.

I tried installing it with `pip install awsebcli --upgrade --user` and it failed.

The error was the following.

```text
Collecting PyYAML<6.1,>=5.3.1 (from awsebcli)
  Using cached PyYAML-5.4.1.tar.gz (175 kB)
  Installing build dependencies ... done
  Getting requirements to build wheel ... error
  error: subprocess-exited-with-error
  
  × Getting requirements to build wheel did not run successfully.
  │ exit code: 1
  ╰─> [68 lines of output]
```

To fix this issue with PyYAML you must install PyYAML separately.

Do the following and try installing `eb` again after.

```sh
echo 'Cython < 3.0' > /tmp/constraint.txt
PIP_CONSTRAINT=/tmp/constraint.txt pip install 'PyYAML==5.4.1'
```
