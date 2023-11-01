---
title: The strange case of Elasticsearch allocation failure
permalink: /the-strange-case-of-elasticsearch-allocation-failure.html
date: 2020-03-29T12:00:00+02:00
layout: post
type: post
draft: false
---

I've been using Elasticsearch in production for 5 years now and never had a
single problem with it. Hell, never even known there could be a problem. Just
worked. All this time. The first node that I deployed is still being used in
production, never updated, upgraded, touched in anyway.

All this bliss came to an abrupt end this Friday when I got notification that
Elasticsearch cluster went warm. Well, warm is not that bad right? Wrong!
Quickly after that I got another email which sent chills down my spine.  Cluster
is now red. RED! Now, shit really hit the fan!

I tried googling what could be the problem and after executing allocation
function noticed that some shards were unassigned and 5 attempts were already
made (which is BTW to my luck the maximum) and that meant I am basically fucked.
They also applied that one should wait for cluster to re-balance itself. So, I
waited. One hour, two hours, several hours. Nothing, still RED.

The strangest thing about it all was, that queries were still being fulfilled.
Data was coming out. On the outside it looked like nothing was wrong but
everybody that would look at the cluster would know immediately that something
was very very wrong and we were living on borrowed time here.

> **Please, DO NOT do what I did.** Seriously! Please ask someone on official
forums or if you know an expert please consult him. There could be million of
reasons and these solution fit my problem. Maybe in your case it would
disastrous. I had all the data backed up and even if I would fail spectacularly
I would be able to restore the data. It would be a huge pain and I would loose
couple of days but I had a plan B.

Executing allocation and told me what the problem was but no clear solution yet.

```yaml
GET /_cat/allocation?format=json
```

I got a message that `ALLOCATION_FAILED` with additional info `failed to create
shard, failure ioexception[failed to obtain in-memory shard lock]`.  Well
splendid! I must also say that our cluster is capable more than enough to handle
the traffic. Also JVM memory pressure never was an issue. So what happened
really then?

I tried also re-routing failed ones with no success due to AWS restrictions on
having managed Elasticsearch cluster (they lock some of the functions).

```yaml
POST /_cluster/reroute?retry_failed=true
```

I got a message that significantly reduced my options.

```json
{
  "Message": "Your request: '/_cluster/reroute' is not allowed."
}
```

After that I went on a hunt again. I won't bother you with all the details
because hours/days went by until I was finally able to re-index the problematic
index and hoped for the best. Until that moment even re-indexing was giving me
errors.

```yaml
POST _reindex
{
  "source": {
    "index": "myindex"
  },
  "dest": {
    "index": "myindex-new"
  }
}
```

I needed to do this multiple times to get all the documents re-indexed. Then I
dropped the original one with the following command.

```yaml
DELETE /myindex
```

And re-indexed again new one in the original one (well by name only).

```yaml
POST _reindex
{
  "source": {
    "index": "myindex-new"
  },
  "dest": {
    "index": "myindex"
  }
}
```

On the surface it looks like all is working but I have a long road in front of
me to get all the things working again. Cluster now shows that it is in Green
mode but I am also getting a notification that the cluster has processing status
which could mean million of things.

Godspeed!

