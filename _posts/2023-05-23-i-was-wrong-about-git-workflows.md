---
title: I think I was completely wrong about Git workflows
permalink: /i-was-wrong-about-git-workflows.html
date: 2023-05-23T12:00:00+02:00
layout: post
type: post
draft: false
tags: []
---

I have been using some approximation of [Git
Flow](https://jeffkreeftmeijer.com/git-flow/) for years now and never really
questioned it to be honest. When I create a repo I create develop branch and set
it as default one and then merge to master from there. Seems reasonable enough.

One thing that I have learned is that long living branches are the devil.  They
always end up making a huge mess when they need to be merged eventually into
master. So by that reason, what is the develop branch if not the longest living
feature branch. And from my personal experience there was never a situation
where I wasn’t sweating bullets when I had to merge develop back to master.

This realisation started to give me pause. So why the hell am I doing this, and
is there a better way. Well the solution was always there. And it comes in a
form of [git tags](https://git-scm.com/book/en/v2/Git-Basics-Tagging).

So what are git tags? Git tags are references to specific points in a Git
repository's history. They are used to mark important milestones, such as
releases or significant commits, making it easier to identify and access
specific versions of a project.

Somehow we have all hijacked the meaning of the master branch that it has to be
the most releasable version of code. And this is also where the confusing about
versioning the software kicks in. Because master branch implicitly says that we
are dealing with the rolling release type of a software. And by having a develop
branch we are hacking around this confusion. With a separation of develop and
master we lock functionalities into place and forcing a stable vs development
version of the software.

But if that is true and the long living branches are the devil then why have
develop at all. I think that most of this comes to how continuous integration is
being done. There usually is no granular access to tags and CD software deploys
what is present on a specific branch, may that be master for production and
develop for staging. This is a gross simplification and by having this in place
we have completely removed tagging as a viable option to create a fix point in
software cycle that says, this is the production ready code.

One cool thing about tags are that you can checkout a specific tag. So they
behave very similarly as branches in that regard. And you don’t have the
overhead of having two mainstream branches.

So what is the solution? One approach is to use development workflow, where all
changes are made on the smaller branches and continuously merged into
master. Where the software is ready to be pushed to production you tag the
master branch. This approach eliminates the need for long-lived branches and
simplifies the development process. It also encourages developers to make small,
incremental changes that can be tested and deployed quickly. However, this
approach may not be suitable for all projects or teams that heavily rely on
automated deployment based on branch names only.

This also requires that developers always keep production in mind. No more
living on an island of the develop branch. All your actions and code need to be
ready to meet production standards on a much smaller timescale.

I think that we have complicated the workflow in an honest attempt to make
things more streamlined but in the process of doing this, we have inadvertently
made our lives much more complicated.

In conclusion, it's important to re-evaluate our workflows from time to time to
see if they still make sense and if there are better alternatives available.
Long-living branches can be problematic, and using tags to mark important
milestones can simplify the development process.

