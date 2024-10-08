---
title: Wireless Application Protocol and the mobile web before the web
url: wap-mobile-web-before-the-web.html
date: 2021-12-30T12:00:00+02:00
type: post
draft: false
---

## A little stroll down the history lane

About two weeks ago, I watched this outstanding documentary on YouTube
[Springboard: the secret history of the first real
smartphone](https://www.youtube.com/watch?v=b9_Vh9h3Ohw) about the history of
smartphones and phones in general. It brought back so many memories. I never had
an actual smartphone before the Android. The closest to smartphone was [Sony
Ericsson P1](https://www.gsmarena.com/sony_ericsson_p1-1982.php).  A fantastic
phone and I broke it in Prague after a party and that was one of those rare
occasions where I was actually mad at myself. But nevertheless, after that
phone, the next one was an Android one.

Before that, I only owned normal phones from Nokia and Siemens etc. Nothing
special, actually. These are the phones we are talking about. Before 2007.
Apple and Android phones didn't exist yet.

These phones were rocking:

- No selfie cameras.
- ~2 inch displays.
- ~120 MHz beast CPU's.
- 144p main cameras.
- But they had a headphone jack.

Let's take a look at these beauties.

![Old phones](/assets/posts/wap/phones.gif)

## WAP - Wireless Application Protocol

Not that one! We are talking about Wireless Application Protocol and not Cardi
B's song 😃

WAP stands for Wireless Application Protocol. It is a protocol designed for
micro-browsers, and it enables the access of internet in the mobile devices.  It
uses the mark-up language WML (Wireless Markup Language and not HTML), WML is
defined as XML 1.0 application. Furthermore, it enables creating web
applications for mobile devices. In 1998, WAP Forum was founded by Ericson,
Motorola, Nokia and Unwired Planet whose aim was to standardize the various
wireless technologies via protocols.
[(source)](https://www.geeksforgeeks.org/wireless-application-protocol/)

WAP protocol was resulted by the joint efforts of the various members of WAP
Forum. In 2002, WAP forum was merged with various other forums of the industry,
resulting in the formation of Open Mobile Alliance (OMA).
[(source)](https://www.geeksforgeeks.org/wireless-application-protocol/)

These were some wild times. Devices had tiny screens and data transmission rates
were abominable. But they were capable of rendering WML (Wireless Markup
Language). This was very similar to HTML, actually. It is a markup language,
after all.

These pages could be served by [Apache](https://apache.org/) and could be
generated by CGI scripts on the backend. The only difference was the limited
markup language.

## WML - Wireless Markup Language

Just like web browsers use HTML for content structure, older mobile device
browsers use WML - if you need to support really old mobile phones using WML
browsers, you will need to know about it. WML is XML-based (an XML vocabulary
just like XHTML and MathML, but not HTML) and does not use the same metaphor as
HTML. HTML is a single document with some metadata packed away in the head, and
a body encapsulating the visible page. With WML, the metaphor does not envisage
a page, but rather a deck of cards. A WML file might have several pages or cards
contained within it.
[(source)](https://www.w3.org/wiki/Introduction_to_mobile_web)

```html
<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.1//EN" "http://www.wapforum.org/DTD/wml_1.1.xml">
<wml>
  <card id="home" title="Example Homepage">
    <p>Welcome to the Example homepage</p>
  </card>
</wml>
```

There is an amazing tutorial on [Tutorialpoint about
WML](https://www.tutorialspoint.com/wml/index.htm).

## Converting Digg to WML

This task is completely useless and not really feasible nowadays, but I had to
give it a try for old-time sake. Since the data is already there in a form of
RSS feed, I could take this feed and parse it and create a WML version of the
homepage.

We will need:

- Python3 + Pip
- ImageMagick
- feedparser and mako templating

```sh
# for fedora 35
sudo dnf install ImageMagick python3-pip

# tempalting engine for python
pip install mako --user

# for parsing rss feeds
pip install feedparser --user
```

Project folder structure should look like the following.

```
12:43:53 m@khan wap → tree -L 1
.
├── generate.py
└── template.wml

```

After that, I created a small template for the homepage.

```html
<?xml version="1.0"?>
<!DOCTYPE wml PUBLIC "-//WAPFORUM//DTD WML 1.2//EN" "http://www.wapforum.org/DTD/wml_1.2.xml">

<wml>

  <card title="Digg - What the Internet is talking about right now">

    % for item in entries:
      <p><img src="/images/${item.id}.jpg" width="175" height="95" alt="${item.title}" /></p>
      <p><small>${item.kicker}</small></p>
      <p><big><b>${item.title}</b></big></p>
      <p>${item.description}</p>
    % endfor

  </card>

</wml>
```

And the parser that parses RSS feed looks like this.

```python
import os
import feedparser
from mako.template import Template

os.system('mkdir -p www/images')

template = Template(filename='template.wml')

feed = feedparser.parse('https://digg.com/rss/top.xml')

entries = feed.entries[:15]

for entry in entries:
  print('Processing image with id {}'.format(entry.id))
  os.system('wget -q -O www/images/{}.jpg "{}"'.format(entry.id, entry.links[1].href))
  os.system('convert www/images/{}.jpg -type Grayscale -resize 175x -depth 3 -quality 30 www/images/{}.jpg'.format(entry.id, entry.id))

html = template.render(entries = entries)

with open('www/index.wml', 'w+') as fp:
  fp.write(html)
```

This script will create a folder `www` and in the folder `www/images` for
storing resized images.

> Be sure you don't use SSL and use just normal HTTP for serving the content.
> These old phones will have problems with TLS 1.3 etc.

If you look at the python file, I convert all the images into tiny B&W images.
They should be WBMP (Wireless BitMaP) but I choose JPEGs for this, and it seems
to work properly.

Because I currently don't have a phone old enough to test it on, I used an
emulator. And it was really hard to find one. I found [WAP
Proof](http://wap-proof.sharewarejunction.com/) on shareware junction, and it
did the job well enough. I will try to find and actual device to test it on.

<video src="/assets/posts/wap/emulator.mp4" controls></video>

If you are using Nginx to serve the contents, add a directive to the hosts file
that will automatically server `index.wml` file.

```nginx
server {
  index index.wml index.html index.htm index.nginx-debian.html;
}
```

## Conclusion

Well, this was pointless, but very fun! I hope you enjoyed it as much as I did.
I will try to find an old phone to test it on. If you have any questions, feel
free to ask in the comments.
