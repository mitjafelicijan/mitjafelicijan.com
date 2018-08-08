layout: true
---

## Test online slideshow

Couple of example slides to test

---

## JSON example

Some code examples.

```json
{
  "short_name": "MF",
  "name": "Mitja Felicijan",
  "author": "Mitja Felicijan",
  "icons": [{
    "src": "/assets/avatar.png",
    "sizes": "512x512",
    "type": "image/png"
  }],
  "start_url": "/",
  "display": "fullscreen",
  "theme_color": "#000000",
  "background_color": "#000000"
}
```

---

## Python example

Some code examples.

```python
@app.route("{}".format(args["path"]), method=["GET"])
def route_default():
  with open("static/index.html", "r") as fp:
    data = str(fp.read())
    data = data.replace("$$path$$", args["path"])
    data = data.replace("$$cache$$", CACHE_VER)
    data = data.replace("$$db$$", str(args["redis_database"]))
  return data
```

---

## Tables

| URL           | Num of requests | Transfered | Finish  | DOMContentLoaded | Load   |
| ------------- | --------------- | ---------- | ------- | ---------------- | ------ |
| cnn.com       | 134             | 3.22 MB    | 4.7 s   | 575 ms           | 3.60 s |
| youtube.com   | 61              | 1.8 MB     | 5.13 s  | 1.78 s           | 1.97   |
| wikipedia.com | 11              | 64.5 KB    | 642 ms  | 531 ms           | 573 ms |
| reddit.com    | 177             | 12.9 MB    | 7.65 MB | 2.03 s           | 3.74 s |
| amamzon.com   | 278             | 8.0 MB     | 5.20 s  | 1.15s            | 2.99 s |
| twitter.com   | 2'2             | 5.1 MB     | 23.48 s | 3.20 s           | 4.55 s |
| twitch.tv     | 177             | 4.4 MB     | 5.08 s  | 579 ms           | 798 ms |
| microsoft.com | 77              | 1.1 MB     | 3.96 s  | 1.01 s           | 1.26 s |
