---
title: What I've learned developing ad server
permalink: /what-i-ve-learned-developing-ad-server.html
date: 2017-04-17T12:00:00+02:00
layout: post
type: post
draft: false
---

For the past year and half I have been developing native advertising server that
contextually matches ads and displays them in different template forms on
variety of websites. This project grew from serving thousands of ads per day to
millions.

The system is made from couple of core components:

- API for serving ads,
- Utils - cronjobs and queue management tools,
- Dashboard UI.

Initial release was using [MongoDB](https://www.mongodb.com/) for full-text
search but was later replaced by [Elasticsearch](https://www.elastic.co/) for
better CPU utilization and better search performance. This provided us with many
amazing functionalities of [Elasticsearch](https://www.elastic.co/).  You should
check it out if you do any search related operations.

Because the premise of the server is to provide native ad experience, they are
rendered on the client side via simple templating engine. This ensures that ads
can be displayed number of different ways based on the visual style of the
page. And this makes JavaScript client library quite complex.

So now that you know basic information about the product lets get into the
lessons we learned.

## Aggregate everything

After beta version was released everything (impressions, clicks, etc) was
written in nanosecond resolution in the database. At that time we were using
[PostgreSQL](https://www.postgresql.org/) and database quickly grew way above
200GB in disk space. And that was problematic. Statistics took disturbingly long
time to aggregate. Also using indexes on stats table in database was no help
after we reached 500 million datapoints.

> There is a marketing product information and there is real life experience.
And the tend to be quite the opposite.

This was the reason that now everything is aggregated on daily basis and this
data is then fed to Elastic in form of daily summary. With this we achieved we
can now track many more dimensions such as zone, channel and platform
information.  And with this information we can now adapt occurrences of ads on
specific places more precisely.

We have also adapted [Redis](https://redis.io/) as a full-time citizen in our
stack. Because Redis also stores information on a local disk we have some sort
of backup if server would accidentally suffer some failure.

All the real-time statistics for ad serving and redirecting is presented as
counters in Redis instance and daily extracted and pushed to Elastic.

## Measure everything

The thing about software is that we really don't know how well it is performing
under load until such load is presented. When testing locally everything is fine
but when on production things tend to fall apart.

As a solution for this we are measuring everything we can. Function execution
time (by encapsulating functions with timers), server performance (cpu, memory,
disk, etc), Nginx and [uWSGI](https://uwsgi-docs.readthedocs.io/) performance.
We sacrifice a bit of performance for the sake of this information. And we store
all this information for later analysis.

**Example of function execution time**

```json
{
  "get_final_filtered_ads": {
    "counter": 1931250,
    "avg": 0.0066143431,
    "elapsed": 12773.9500310003
  },
  "store_keywords_statistics": {
    "counter": 1931011,
    "avg": 0.0004605267,
    "elapsed": 889.2821669996
  },
  "match_by_context": {
    "counter": 1931011,
    "avg": 0.0055960716,
    "elapsed": 10806.0758889999
  },
  "match_by_high_performance": {
    "counter": 262,
    "avg": 0.0152770229,
    "elapsed": 4.00258
  },
  "store_impression_stats": {
    "counter": 1931250,
    "avg": 0.0006189991,
    "elapsed": 1195.4419869999
  }
}
```

We have also started profiling with [cProfile](https://pymotw.com/2/profile/)
and then visualizing with [KCachegrind](http://kcachegrind.sourceforge.net/).
This provides much more detailed look into code execution.

## Cache control is your friend

Because we use Javascript library for rendering ads we rely on this script
extensively and when in need we need to be able to change behavior of the script
quickly.

In our case we can not simply replace javascript url in html code. It usually
takes a day or two for the guys who maintain sites to change code or add
?ver=xxx attribute. And this makes rapid deployment and testing very difficult
and time consuming. There is a limitation of how much you can test locally.

We are now in the process of integrating [Google Tag
Manager](https://www.google.com/analytics/tag-manager/) but couple of websites
are developed on ASP.net platform that have some problems with tag manager. With
a solution below we are certain that we are serving latest version of the
script.

And it only takes one mistake and users have the script cached and in case of
caching it for 1 year you probably know where the problem is.

```nginx
# nginx ➜ /etc/nginx/sites-available/default
location /static/ {
  alias /path-to-static-content/;
  autoindex off;
  charset utf-8;
  gzip on;
  gzip_types text/plain application/javascript application/x-javascript text/javascript text/xml text/css;
  location ~* \.(ico|gif|jpeg|jpg|png|woff|ttf|otf|svg|woff2|eot)$ {
    expires 1y;
    add_header Pragma public;
    add_header Cache-Control "public";
  }
  location ~* \.(css|js|txt)$ {
    expires 3600s;
    add_header Pragma public;
    add_header Cache-Control "public, must-revalidate";
  }
}
```

Also be careful when redirecting to url in your python code. We noticed that if
we didn't precisely setup cache control and expire headers in response we didn't
get the request on the server and therefore couldn't measure clicks.  So when
redirecting do as follows and there will be no problems.

```python
# python ➜ bottlepy web micro-framework
response = bottle.HTTPResponse(status=302)
response.set_header("Cache-Control", "no-store, no-cache, must-revalidate")
response.set_header("Expires", "Thu, 01 Jan 1970 00:00:00 GMT")
response.set_header("Location", url)
return response
```

> Cache control in browsers is quite aggressive and you need to be precise to
avoid future problems. We learned that lesson the hard way.

## Learn NGINX

When deciding on a web server we went with Nginx as a reverse proxy for our
applications. We adapted micro-service oriented architecture early in the
project to ensure when we scale we can easily add additional servers to our
cluster. And Nginx was crucial to perform load balancing and static content
delivery.

At first our config file was quite simple and later grew larger. After patching
and adding new settings I sat down and learned more about the guts of Nginx.
This proved to be very useful and we were able to squeeze much more out of our
setup. So I advise you to take your time and read through the
[documentation](https://nginx.org/en/docs/). This saved us a lot of headache.
Googling for solutions only goes so far.

## Use Redis/Memcached

As explained above we are using caching basically for everything. It is the
corner stone of our services. At first we were very careful about the quantity
of things we stored in [Redis](https://redis.io/). But we later found out that
the memory footprint is very low even when storing large amount of data in it.

So we gradually increased our usage to caching whole HTML outputs of dashboard.
This improved our performance in order of magnitude. And by using native TTL
support this goes hand in hand with our needs.

The reason why we choose [Redis](https://redis.io/) over
[Memcached](https://memcached.org/) was the nature of scalability of Redis out
of the box. But all this can be achieved with Memcached.

## Conclusion

There are a lot more details that could have been written and every single topic
in here deserves it's own post but you probably got the idea about the problems
we faced.
