---
title: My love and hate relationship with Node.js
url: my-love-and-hate-relationship-with-nodejs.html
date: 2020-03-30T12:00:00+02:00
type: post
draft: false
---

Previous project I was working on was being coded in
[Golang](https://golang.org/). Also was my first project using it. And damn,
that was an awesome experience. The whole thing is just superb. From how errors
are handled. The C-like way you handle compiling. The way the language is
structured making it incredibly versatile and easy to learn.

It may cause some pain for somebody that is not used of using interfaces to map
JSON and doing the recompilation all the time. But we have tools like
[entr](http://eradman.com/entrproject/) and
[make](https://www.gnu.org/software/make/) to fix that.

But we are not here to talk about my undying love for **Golang**. Only in some
way we probably should. It is an excellent example of how modern language should
be designed. And because I have used it extensively in the last couple of years
this probably taints my views of other languages. And is doing me a great
disservice. Nevertheless, here we are.

About two years ago I started flirting with [Node.js](https://nodejs.org/en/)
for a project I started working on. What I wanted was to have things written in
a language that is widely used, and we could get additional developers for.  As
much as **Golang** is amazing it's really hard to get developers for it.  Even
now. And after playing around with it for a week I felt in love with the speed
of iteration and massive package ecosystem. Do you want SSO? You got it!  Do you
want some esoteric library for something? There is a strong chance somebody
wrote it. It is so extensive that you find yourself evaluating packages based on
**GitHub stars** and number of contributors. You get swallowed by the vanity
metrics and that potentially will become the downfall of Node.js.

Because of the sheer amount of choice I often got anxiety when choosing
libraries. Will I choose the correct one? Is this library something that will be
supported for a foreseeable future or not? I am used of using libraries that are
being in development for 10 years plus (Python, C) and that gave me some sort of
comfort. And it is probably unfair to Node.js and community to expect same
dedication.

Moving forward ... Work started and things were great. **Speed of iteration was
insane**. For some feature that I would need a day in Golang only took me hour
or two. I became lazy! Using packages all over the place. Falling into the same
trap as others. Packages on top of packages.  And [npm](https://www.npmjs.com/)
didn't help at all. The way that the package manager works is just
horrendous. And not allowing to have node_modules outside the project is also
the stupidest idea ever.

So at that point I started feeling the technical debt that comes with Node.js
and the whole ecosystem. What nobody tells you is that **structuring large
Node.js apps** is more problematic than one would think.  And going microservice
for every single thing is also a bad idea. The amount of networking you
introduce with that approach always ends up being a pain in the ass. And I don't
even want to go into system administration here. The overhead is
insane. Package-lock.json made many days feel like living hell for me. And I
would eat the cost of all this if it meant for better development
experience. Well, it didn't.

The **lack of Typescript** support in the interpreter is still mind boggling to
me. Why haven't they added native support yet for this is beyond me?! That would
have solved so many problems. Lack of type safety became a problem somewhere in
the middle of the project where the codebase was sufficiently large enough to
present problems. We started adding arguments to functions and there was **no
way to implicitly define argument types**. And because at that point there were
a lot of functions, it became impossible to know what each one accepts,
development became more and more trial and error based.

I tried **implementing Typescript**, but that would present a large refactor
that we were not willing to do at that point. The benefits were not enough.  I
also tried [Flow - static type checker](https://flow.org/) but implementation
was also horrible. What Typescript and Flow forces you is to have src folder and
then **transpile** your code into dist folder and run it with node. WTH is that
all about. Why can't this be done in memory or some virtual file system?  Why? I
see no reason why this couldn't be done like this. But it is what it is.  I
abandoned all hope for static type checking.

One of the problems that resulted from not having interfaces or types was
inability to model out our data from **Elasticsearch**. I could have done a
**pedestrian implementation** of it, but there must be a better way of doing
this without resorting to some hack basically. Or maybe I haven't found a
solution, which is also a possibility. I have looked, though. No juice!

**Error handling?** Is that a joke?

Thank god for **await/async**. Without it, I would have probably just abandoned
the whole thing and went with something else like Python. That's all I am going
to say about this :)

I started asking myself a question if Node.js is actually ready to be used in a
**large scale applications**? And this was a totally wrong question. What I
should have been asking myself was, how to use Node.js in large scale
application. And you don't get this in **marketing material** for Express or Koa
etc. They never tell you this. Making Node.js scale on infrastructure or in
codebase is really **more of an art than a science**. And just like with the
whole JavaScript ecosystem:

- impossible to master,
- half of your time you work on your tooling,
- just accept transpilers that convert one code into another (holly smokes),
- error handling is a joke,
- standards? What standards?

But on the other hand. As I did, you will also learn to love it. Learn to use it
quickly and do impossible things in crazy limited time.

I hate to admit it. But I love Node.js. Dammit, I love it :)

**2023 Update**: I hate Node.js!
