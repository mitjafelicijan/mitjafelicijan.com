---
layout: post
title: The Bullshit Web - Development's POV
description: State of front-end development and what this does to the future of web
---

**Table of contents**

- [Initial thoughts](#initial-thoughts)
- [Front-end frameworks](#front-end-frameworks)
- [Obsolescence to the rescue](#obsolescence-to-the-rescue)
- [Unnecessary complexity](#unnecessary-complexity)
- [Speed of development trumps code quality](#speed-of-development-trumps-code-quality)
- [Load times of most popular websites](#load-times-of-most-popular-websites)

## Initial thoughts

I have recently read an amazing essay by Nick Heer on the web called [The Bullshit Web](https://pxlnv.com/blog/bullshit-web/) and it got me thinking about the future of the web as it is today.

> The average internet connection in the United States is about six times as fast as it was just ten years ago, but instead of making it faster to browse the same types of websites, we’re simply occupying that extra bandwidth with more stuff.
>
> **-- Nick Heer**

I really try to stray away from frond-end development as much as possible. The reason is nowhere close to me having any bad opinions but having to work with clients on visual stuff drains me to the point of sheer horror.

I have observed silently the progress that was made in this field because I thought things will get better with time. I was so wrong. So wrong. Not only that things got extremely complicated to work with, the whole stack because so massive even simple pages have insanely large footprint.

The Bullshit Web essay concentrates mostly on page sizes and AMP but I would like to address tooling and technologies for development in this post.

Currently we have two types of websites:

- informational websites,
- web applications.

The problem that occurs is that more and more websites are treathed as web application where simple web page would suffice. And this in my opinion adds insult to the injury.

We talk about progressive web applications, AMP, and other technologies that are solving the problems of bandwidth, usability and in general making web faster but in reality this rarely gets applied in real life scenarios. Most of the time this are just demos on conferences.

## Front-end frameworks

I am not of those purists that denies usage of JavaScript frameworks or SASS but there are limits to where this obsession should go. In order to use these technologies properly one should ask himself where exactly they are needed and not use them like hammer for nails.

Whenever I need to do front-end UI I usually check specification before embarking on journey of coding. And most of the times I really don't need frameworks. Most of the code I need to write in JavaScript is done in couple of hundred lines of code and does exactly what specification requires. And developer that will be working on this code after me doesn't need to learn new framework, tooling, etc. Just pure vanilla JavaScript. In all of my years as a developer I can count on fingers on my one hand when I used some sort of a framework. And even in this exceptions we later rewrote code to vanilla JavaScript because maintaining complex code was just to time consuming.

There is an argument to be made for using frameworks in cases where multiple people are working a project and code must be easily transferable and on-boarding process must be swift. But in reality this is just another bullshit excuse to stick with what is "cool". I stand by Function over Form. And this also conflicts with the notion that frameworks never change. Frameworks evolve and adapt to market needs and most of the times get massive and hard to maintain. And we get stuck with massive codebase that is developed with many hacks and workarounds, because framework didn't support some feature at the time of development. I personally hate workarounds and being a smart-ass that intentionally makes code harder to read. I find frameworks similar to the story about Cain and Abel. Either you get murdered or framework gets. Most of the times framework dies and leaves legacy nobody would want.

Huge strives have been made to address this problem and many fantastic frameworks emerged and some of theme are absolutely amazing. But there needs to be a strong case for using them in a project. We should never blindly use them regardless of the problem we are trying to solve.

I must admit that tooling around front-end is getting better and better and we are slowly getting there but there still is a long road ahead.

## Obsolescence to the rescue

We can all agree that frameworks or libraries usually are there to fill the gap what currently is widely supported by the standard. Most of this so called frameworks are just libraries that unifies browser compatibility. The prime example of this is jQuery. There was a time almost everybody was using jQuery. But through time HTML5 specs were updated to include ideas from jQuery and this filled the browser compatibility gap. There is this awesome article [The Rise and Fall of jQuery](https://www.evolutionjobs.com/uk/media/the-rise-and-fall-of-jquery-117981/).

Don't get me wrong. Yes, I dislike jQuery but I find it indispensable and without it our web would be very different. For the worst in my opinion. It was a huge stepping stone for front-end development. But there comes a time where technologies get obsolete and standards catch up with the requirements of the field.

And because libraries and frameworks have short lifespan I try to stay away from them and if possible use vanilla code. There is a wonderfull article about [The Brutal Lifecycle of JavaScript Frameworks](https://stackoverflow.blog/2018/01/11/brutal-lifecycle-javascript-frameworks/) that explains how quick they popup and become obsolete.

> JavaScript UI frameworks and libraries work in cycles. Every six months or so, a new one pops up, claiming that it has revolutionized UI development. Thousands of developers adopt it into their new projects, blog posts are written, Stack Overflow questions are asked and answered, and then a newer (and even more revolutionary) framework pops up to usurp the throne.
>
> **-- Ian Allen**

## Unnecessary complexity

Libraries have a tendency to speed up development which is ok but there are a huge drawbacks in the future. Most of the times we work on simple projects. Not everybody is working on Facebook, Google or that kind of mamuth apps and by using libraries provided to us by these companies we introduce complexity these companies need in order to make their apps. And usually these libraries include edge case functionalities that only apply to them and by providing simpler way to use libraries very complex approaches get implemented.

Another reason for me to not use frameworks and libraries is that there usually is a team behind a project and by working on a feature by your own it takes too much time to read through the documentation and properly understand what the reasoning was behind a feature in a library. Most of the stuff (dashboarding, tables, widgets) that I work on are done much faster by pure using JS. Codebase footprint is smaller and doesn't require other developers to learn a completly new framework.

This freameworks are heavily opinionated. No question about it. And by using them you accept their dogma. And by doing so you put yourself in a wierd position when new "disruptive" framework comes to life. If we think about it these frameworks should rather be called "approaches".

> *Just to be completely honest*
>
> There are use-cases for such frameworks. And there are situations where they are indispensable. I am not saying that they don't make sense. All I am saying that in my line of work I noticed that not every project is fit for a framework and it's better to not use them in such cases.

An awesome talk about [Learning from JavaScript Libraries by Trevor Landau](https://www.youtube.com/watch?v=u2PgPWj8KrM).

## Speed of development trumps code quality

I have found out that most of these frameworks or libraries have become very difficult to undestand in a matter of hours. In the past this was diifferent somehow. You could learn jQuery in a matter of hours and use it the next day like you were a pro. I know that it's not fair to compare framework and library but for our case this is acceptable.

Every developer should have the knowledge and experience when selecting or not selection framework. I always stay true to [Occam's razor](https://en.wikipedia.org/wiki/Occam%27s_razor). And when prototyping I always use as barebone setup as I can. I see no problem with completly dumping a block of code and replacing it with something more complex if this makes sense. But there needs to be a huge reason behind this decision.

Workarounds are one of the nessesary evils perticulary when dealing with frameworks. Either because the lack of time of just plain reason that framework doesn't support something. And this is the my main problem with them. In real life we don't have the time to properly implement ideas behind a framework. And when shit hits the fan we butcher up the code and mix different ideas just to catch a deadline. And this is in contadiction with the whole idea of using a framework.

The impact that this has on quality and readability of code is massive. And threating this just as a symptom is probably the worst thing you can do. Through time these hacked-up code becomes legacy and additional code is molded to the code that already is in the codebase. And by doing this our code becomes more and more foregin of the initial concept.

Code quality and readability should come first regardless of frameworks and libraries. Code should be as close to bare-metal as possible so when frameworks change our code is still usable and can be refreshed by any developer with the basic knowledge of desired programming language.

## Load times of most popular websites

All this directly impacts performanse. Terabytes of bandwidth wasted because there was a decision made early in the development cycle. Laggy performance, slow loading, bad experience just because development team was not cautious enough.

Here are some examples of loading times. It's up to you to decide if this really is the best way to do web.

| URL                | Num of requests | Transfered | Finish  | DOMContentLoaded | Load   |
| ------------------ | --------------- | ---------- | ------- | ---------------- | ------ |
| cnn.com            | 134             | 3.22 MB    | 4.7 s   | 575 ms           | 3.60 s |
| youtube.com        | 61              | 1.8 MB     | 5.13 s  | 1.78 s           | 1.97   |
| wikipedia.com      | 11              | 64.5 KB    | 642 ms  | 531 ms           | 573 ms |
| reddit.com         | 177             | 12.9 MB    | 7.65 MB | 2.03 s           | 3.74 s |
| amazon.com         | 278             | 8.0 MB     | 5.20 s  | 1.15s            | 2.99 s |
| twitter.com        | 202             | 5.1 MB     | 23.48 s | 3.20 s           | 4.55 s |
| twitch.tv          | 177             | 4.4 MB     | 5.08 s  | 579 ms           | 798 ms |
| microsoft.com      | 77              | 1.1 MB     | 3.96 s  | 1.01 s           | 1.26 s |
| huffingtonpost.com | 134             | 2.9 MB     | 2.30 s  | 789 ms           | 1.47 s |
| nytimes.com        | 240             | 2.9 MB     | 4.64 s  | 1.30 s           | 4.29 s |
| foxnews.com        | 195             | 1.7 MB     | 4.42 s  | 1.25 s           | 3.86 s |
| theguardian.com    | 203             | 2.8 MB     | 2.75 s  | 784 ms           | 2.43 s |
| bbc.com            | 127             | 1.3 MB     | 3.44 s  | 1.24 s           | 2.65 s |

Chrome Browser Developer tools was used to measure load times.
