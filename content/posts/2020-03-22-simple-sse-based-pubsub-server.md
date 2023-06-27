---
title: Simple Server-Sent Events based PubSub Server
url: simple-server-sent-events-based-pubsub-server.html
date: 2020-03-22T12:00:00+02:00
draft: false
---

## Before we continue ...

Publisher Subscriber model is nothing new and there are many amazing solutions
out there, so writing a new one would be a waste of time if other solutions
wouldn't have quite complex install procedures and weren't so hard to maintain.
But to be fair, comparing this simple server with something like
[Kafka](https://kafka.apache.org/) or [RabbitMQ](https://www.rabbitmq.com/) is
laughable at the least. Those solutions are enterprise grade and have many
mechanisms there to ensure messages aren't lost and much more. Regardless of
these drawbacks, this method has been tested on a large website and worked until
now without any problems. So now, that we got that cleared up, let's continue.

***Wiki definition:** Publish/subscribe messaging, or pub/sub messaging, is a
form of asynchronous service-to-service communication used in serverless and
microservices architectures. In a pub/sub model, any message published to a
topic is immediately received by all the subscribers to the topic.*

## General goals

- provide a simple server that relays messages to all the connected clients,
- messages can be posted on specific topics,
- messages get sent via [Server-Sent
  Events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events)
  to all the subscribers.

## How exactly does the pub/sub model work?

The easiest way to explain this is with diagram bellow. Basic function is
simple. We have subscribers that receive messages, and we have publishers that
create and post messages. Similar model is also well know pattern that works on
a premise of consumers and producers, and they take similar roles.

![How PubSub works](/assets/simple-pubsub-server/pubsub-overview.png)

**These are some naive characteristics we want to achieve:**

- producer is publishing messages to subscribe topic,
- consumer is receiving messages from subscribed topic,
- servers is also known as Broker,
- broker does not store messages or tracks success,
- broker uses
  [FIFO](https://en.wikipedia.org/wiki/FIFO_(computing_and_electronics)) method
  for delivering messages,
- if consumer wants to receive messages from a topic, producer and consumer
  topics must match,
- consumer can subscribe to multiple topics,
- producer can publish to multiple topics,
- each message has a messageId.

**Known drawbacks:**

- messages will not be stored in a persistent queue or unreceived messages like
  [DeadLetterQueue](https://en.wikipedia.org/wiki/Dead_letter_queue) so old
  messages could be lost on server restart,
- [Server-Sent
  Events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events)
  opens a long-running connection between the client and the server so make sure
  if your setup is load balanced that the load balancer in this case can have
  long opened connection,
- no system moderation due to the dynamic nature of creating queues.

## Server-Sent Events

Read more about it on [official specification
page](https://html.spec.whatwg.org/multipage/server-sent-events.html).

### Current browser support

![Browser support](/assets/simple-pubsub-server/caniuse.png)

Check
[https://caniuse.com/#feat=eventsource](https://caniuse.com/#feat=eventsource)
for latest information about browser support.

### Known issues

- Firefox 52 and below do not support EventSource in web/shared workers
- In Firefox prior to version 36 server-sent events do not reconnect
  automatically in case of a connection interrupt (bug)
- Reportedly, CORS in EventSource is currently supported in Firefox 10+, Opera
  12+, Chrome 26+, Safari 7.0+.
- Antivirus software may block the event streaming data chunks.

Source: [https://caniuse.com/#feat=eventsource](https://caniuse.com/#feat=eventsource)

### Message format

The simplest message that can be sent is only with data attribute:

```bash
data: this is a simple message
<blank line>
```

You can send message IDs to be used if the connection is dropped:

```bash
id: 33
data: this is line one
data: this is line two
<blank line>
```

And you can specify your own event types (the above messages will all trigger
the message event):

```bash
id: 36
event: price
data: 103.34
<blank line>
```

### Server requirements

The important thing is how you send headers and which headers are sent by the
server that triggers browser to threat response as a EventStream.

Headers responsible for this are:

```bash
Content-Type: text/event-stream
Cache-Control: no-cache
Connection: keep-alive
```

### Debugging with Google Chrome

Google Chrome provides build-in debugging and exploration tool for [Server-Sent
Events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events)
which is quite nice and available from Developer Tools under Network tab.

> You can debug only client side events that get received and not the server
> ones. For debugging server events add `console.log` to `server.js` code and
> print out events.

![Google Chrome Developer Tools EventStream](/assets/simple-pubsub-server/chrome-debugging.png)

## Server implementation

For the sake of this example we will use [Node.js](https://nodejs.org/en/) with
[Express](https://expressjs.com) as our router since this is the easiest way to
get started and we will use already written SSE library for node
[sse-pubsub](https://www.npmjs.com/package/sse-pubsub) so we don't reinvent the
wheel.

```bash
npm init --yes

npm install express
npm install body-parser
npm install sse-pubsub
```

Basic implementation of a server (`server.js`):

```js
const express = require('express');
const bodyParser = require('body-parser');
const SSETopic = require('sse-pubsub');

const app = express();
const port = process.env.PORT || 4000;

// topics container
const sseTopics = {};

app.use(bodyParser.json());

// open for all cors
app.all('*', (req, res, next) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
  next();
});

// preflight request error fix
app.options('*', async (req, res) => {
  res.header('Access-Control-Allow-Origin', '*');
  res.header('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type');
  res.send('OK');
});

// serve the event streams
app.get('/stream/:topic', async (req, res, next) => {
  const topic = req.params.topic;

  if (!(topic in sseTopics)) {
    sseTopics[topic] = new SSETopic({
      pingInterval: 0,
      maxStreamDuration: 15000,
    });
  }

  // subscribing client to topic
  sseTopics[topic].subscribe(req, res);
});

// accepts new messages into topic
app.post('/publish', async (req, res) => {
  let body = req.body;
  let status = 200;

  console.log('Incoming message:', req.body);

  if (
    body.hasOwnProperty('topic') &&
    body.hasOwnProperty('event') &&
    body.hasOwnProperty('message')
  ) {
    const topic = req.body.topic;
    const event = req.body.event;
    const message = req.body.message;

    if (topic in sseTopics) {
      // sends message to all the subscribers
      sseTopics[topic].publish(message, event);
    }
  } else {
    status = 400;
  }

  res.status(status).send({
    status,
  });
});

// returns JSON object of all opened topics
app.get('/status', async (req, res) => {
  res.send(sseTopics);
});

// health-check endpoint
app.get('/', async (req, res) => {
  res.send('OK');
});

// return a 404 if no routes match
app.use((req, res, next) => {
  res.set('Cache-Control', 'private, no-store');
  res.status(404).end('Not found');
});

// starts the server
app.listen(port, () => {
  console.log(`PubSub server running on http://localhost:${port}`);
});
```

### Our custom message format

Each message posted on a server must be in a specific format that out server
accepts. Having structure like this allows us to have multiple separated type of
events on each topic.

With this we can separate streams and only receive events that belong to the
topic.

One example would be, that we have index page and we want to receive messages
about new upvotes or new subscribers but we don't want to follow events for
other pages. This reduces clutter and overall network. And structure is much
nicer and maintanable.

```json
{
  "topic": "sample-topic",
  "event": "sample-event",
  "message": { "name": "John" }
}
```

## Publisher and subscriber clients

### Publisher and subscriber in action

<video src="/assets/simple-pubsub-server/clients.m4v" controls></video>

You can download [the code](../simple-pubsub-server/sse-pubsub-server.zip) and
follow along.

### Publisher

As talked about above publisher is the one that send messages to the
broker/server. Message inside the payload can be whatever you want (string,
object, array). I would however personally avoid send large chunks of data like
blobs and such.

```html
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Publisher</title>
  </head>

  <body>

    <h1>Publisher</h1>

    <fieldset>
      <p>
        <label>Server:</label>
        <input type="text" id="server" value="http://localhost:4000">
      </p>
      <p>
        <label>Topic:</label>
        <input type="text" id="topic" value="sample-topic">
      </p>
      <p>
        <label>Event:</label>
        <input type="text" id="event" value="sample-event">
      </p>
      <p>
        <label>Message:</label>
        <input type="text" id="message" value='{"name": "John"}'>
      </p>
      <p>
        <button type="button" id="button">Publish message to topic</button>
      </p>
    </fieldset>

    <script>

      const button = document.querySelector('#button');
      const server = document.querySelector('#server');
      const topic = document.querySelector('#topic');
      const event = document.querySelector('#event');
      const message = document.querySelector('#message');

      button.addEventListener('click', async (evt) => {
        const req = await fetch(`${server.value}/publish`, {
          method: 'post',
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({
            topic: topic.value,
            event: event.value,
            message: JSON.parse(message.value),
          }),
        });

        const res = await req.json();
        console.log(res);
      });

    </script>

  </body>

</html>
```

### Subscriber

Subscriber is responsible for receiving new messages that come from server via
publisher. The code bellow is very rudimentary but works and follows the
implementation guidelines for EventSource.

You can use either Developer Tools Console to see incoming messages or you can
defer to Debugging with Google Chrome section above to see all EventStream
messages.

> Don't be alarmed if the subscriber gets disconnected from the server every so
> often. The code we have here resets connection every 15s but it automatically
> get reconnected and fetches all messages up to last received message id. This
> setting can be adjusted in `server.js` file; search for the
> `maxStreamDuration` variable.

```html
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Subscriber</title>
    <link rel="stylesheet" href="style.css">
  </head>

  <body>

    <h1>Subscriber</h1>

    <fieldset>
      <p>
        <label>Server:</label>
        <input type="text" id="server" value="http://localhost:4000">
      </p>
      <p>
        <label>Topic:</label>
        <input type="text" id="topic" value="sample-topic">
      </p>
      <p>
        <label>Event:</label>
        <input type="text" id="event" value="sample-event">
      </p>
      <p>
        <button type="button" id="button">Subscribe to topic</button>
      </p>
    </fieldset>

    <script>

      const button = document.querySelector('#button');
      const server = document.querySelector('#server');
      const topic = document.querySelector('#topic');
      const event = document.querySelector('#event');

      button.addEventListener('click', async (evt) => {

        let es = new EventSource(`${server.value}/stream/${topic.value}`);

        es.addEventListener(event.value, function (evt) {
          console.log(`incoming message`, JSON.parse(evt.data));
        });

        es.addEventListener('open', function (evt) {
          console.log('connected', evt);
        });

        es.addEventListener('error', function (evt) {
          console.log('error', evt);
        });

      });

    </script>

  </body>

</html>
```

## Reading further

- [Using server-sent events](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events)
- [Using SSE Instead Of WebSockets For Unidirectional Data Flow Over HTTP/2](https://www.smashingmagazine.com/2018/02/sse-websockets-data-flow-http2/)
- [What is Server-Sent Events?](https://apifriends.com/api-streaming/server-sent-events/)
- [An HTTP/2 extension for bidirectional messaging communication](https://tools.ietf.org/id/draft-xie-bidirectional-messaging-01.html)
- [Introduction to HTTP/2](https://developers.google.com/web/fundamentals/performance/http2)
- [The WebSocket API (WebSockets)](https://developer.mozilla.org/en-US/docs/Web/API/WebSockets_API)

