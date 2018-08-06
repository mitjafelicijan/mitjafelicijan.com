---
layout: post
title: GCE, AWS, Docker and why I choose classic VM’s and DigitalOcean for my current project
description: Reasons why I choose DigitalOcean for my project
---

**Table of content**

- [Docker tools and complexity that comes with it](#docker-tools-and-complexity-that-comes-with-it)
- [Lack of real life examples of Docker in action](#lack-of-real-life-examples-of-docker-in-action)
- [Ease of deployment](#ease-of-deployment)
- [Where to go from here](#where-to-go-from-here)

I have been developing a product for the past few months and one of product’s requirement is the ability to automatically scale quickly on system’s demand.

As most of you probably know system design is much more important then actual code that will drive the product. And this was my main concern when developing this product. I have read anything I could get my hands on about Docker as it was hyped so much in media for the past two years. At a first glance Docker was ideal fit for this platform. But then as I started to seriously experiment with it and developing around it several problems occurred. Well, it would be unfair to call them problems but lets say drawbacks when developing rapidly.

To put it in perspective: this project is basically MVP that needs to automatically scale when new customers signs up. These customers are sending metrics to my system that is later visualized and analyzed. There were some basic requirements that I needed the answer before I choose technology.

- Pricing involving hardware and infrastructure.
- Ease of implementation/deployment and scaling.
- How much will this cost me per customer?

The way I envisioned the architecture was straight forward → simple nodes in cluster that take care of x number of customers (1 node ~ 10 customers). I found that pricing in GCE and AWS is very hard to predict → what the cost will be when system would scale. And this was necessary for me to know in order to make financial projection of costs. This is the most important thing for me at this time as I am deciding on prices we should charge future customers and establish healthy revenue model and subsequently business model. I want this product to organically scale and fuel its future development with money made by product itself → very little startup capital (10 nodes for six months & capital for company expanses). I have made many simulations but could not figure out with at least some certainty what will that cost be. Based on this both of the providers are currently not suited for me. So I choose DigitalOcean. They have really straight forward pricing model and this allowed me to make pretty accurate cost matrix for my infrastructure.

I love hard metrics. By this I mean metrics I can test now and have trust they will hold in the future. This was the reason I found Docker too volatile as containers are spawned and halted and there is really no way in predicting this numbers. I have no problem with spawning multiple VMs and not using them but having basically limited control over that is at this time unacceptable for me.

## Docker tools and complexity that comes with it

Probably some of you will correct me on this one, but I find all this management tools like Kubernetes, Swarm etc a bit overkill for a startup project. All this tools are able to scale really massively but they all require extensive knowledge of DevOps. When you are a one man band trying to push a product out, there just is no time to learn these tools and concepts in depth in order to really take advantage of their features. It is much easier to use internal metrics of your app (uwsgi stats server, golang middleware stats) and simply fetch them to one server and visualize them. That task alone took me couple of hours and I had simple metrics system in place that with collaboration of DigitalOcean API enabled me to auto spawn new VMs on demand when users reached max number of users supported by current number of nodes. There is something to say about simplicity of this solution. And I love simple solutions.

## Lack of real life examples of Docker in action

I found many HelloWorld examples and tutorials showing how to spawn containers and deploying simple python apps but I haven’t found really clear example of showing how to battle permanent storage with containers, load balancing, disk management, ip & port management.

This is not Docker’s nor community’s fault to be absolutely clear. It just shows that it is not that simple to deploy real-world application with Docker. Maybe my software architecture is not designed with Docker in mind.

## Ease of deployment

What I really love about Docker is ease of deployment of your application code via container. Multilayered architecture of Docker images also adds to pros list. And the fact that containers sit on top of host OS makes it very intriguing. But if you use container engine from Google you basically spawn VM’s and run containers in this machines and this takes bare-metal approach out of the equation. So at the end you still use hypervisior. I guess if I had my own hardware servers I would be able to fully take advantage of containers.

Because most of my code in nodes is written in Golang and C++ deployment becomes pretty easy. All I have to do is replace binaries on node and that’s that. To avoid downtime I have two instances of one node and I load balance between them. So when I am updating software I first update on node1.A and then node1.B if first one is successful.

## Where to go from here

Docker is amazing technology. But the weird pricing model and steep learning curve for deployment of real live application at this time is too much of a hassle for me. I am sure I could lower costs with Docker approach but it would just took too much time at this stage to implement it properly.

I am currently trying to adapt my project to fit Docker and I believe this would be an interesting solution. Idea is to use one container for one customer. I would just need to find the solution for auto-spawning containers on demand for a specific customer. I would then need a flexible load balancer to correctly forward traffic to container designated for this customer. The problem I have is that I need very flexible storage solution because the amount of data that will be aggregated will scale exponentially and I need to permanently store this on disk. And VM approach is allowing me to precisely calculate per customer per VM how much disk I need. Maybe one of you may have a better solution.
