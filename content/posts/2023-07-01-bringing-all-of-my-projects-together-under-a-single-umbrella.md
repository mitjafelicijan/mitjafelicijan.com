---
title: "Bringing all of my projects together under a single umbrella"
url: bringing-all-of-my-projects-together-under-a-single-umbrella.html
date: 2023-07-01T18:49:07+02:00
draft: false
---

## What is the issue anyway?

Over the years, I have accumulated a bunch of virtual servers on my
[DigitalOcean](https://www.digitalocean.com/) account for small experimental
projects I dabble in. And this has resulted in quite a bill. I mean, I wouldn't
care if these projects were actually being used. But there were just being there
unused and wasting resources. Which makes this an unnecessary burden on me.

Most of them are just small HTML pages that have an endpoint or two to read data
from or to, and for that reason I wrote servers left and right. To be honest,
all of those things could have been done with [CGI
scripts](https://en.wikipedia.org/wiki/Common_Gateway_Interface) and that would
have been more than enough.

Recently, I decided to stop language hopping and focus on a simpler stack which
includes C, Go and Lua. And I can accomplish all the things I am interested in.

## Finding a web server replacement

Usually I had [Nginx](https://nginx.org/en/) in front of these small web servers
and I had to manage SSL certificates and all that jazz. I am bored with these
things. I don't want to manage any of this bullshit anymore.

So the logical move forward was to find a solid alternative for this. I have
ended up on [Caddy server](https://caddyserver.com/). I've used it in the past
but kind of forgotten about it. What I really like about it is an ease of use
and a bunch of out of the box functionalities that come with it.

These are the _pitch_ points from their website:

- **Secure by Default**: Caddy is the only web server that uses HTTPS by
  default. A hardened TLS stack with modern protocols preserves privacy and
  exposes MITM attacks.
- **Config API**: As its primary mode of configuration, Caddy's REST API makes
  it easy to automate and integrate with your apps.
- **No Dependencies**: Because Caddy is written in Go, its binaries are entirely
  self-contained and run on every platform, including containers without libc.
- **Modular Stack**: Take back control over your compute edge. Caddy can be
  extended with everything you need using plugins.

I had just a few requirements:

- Automatic SSL
- Static file server
- Basic authentication
- CGI script support

And the vanilla version does all of it, but CGI scripts. But that can easily be
fixed with their modular approach. You can do this on their website and build a
custom version of the server, or do it with Docker.

This is a `Dockerfile` I used to build a custom server.

```Dockerfile
FROM caddy:builder AS builder

RUN xcaddy build \
  --with github.com/aksdb/caddy-cgi

FROM caddy:latest
RUN apk add --no-cache nano

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
```

## Getting rid of all the unnecessary virtual machines

The next step was to get a handle on the number of virtual servers I have all
over the place.

I decided to move all the projects and services into two main VMs:

- personal server (still Nginx)
  - git server
  - files static server
  - personal blog
- projects server (Caddy server)
  - personal experiments
  - other projects

I will focus on projects' server in this post since it's more interesting.

## Testing CGI scripts

The first thing I tested was how CGI scripts work under Caddy. This is
particularly import to me because almost all of my experiments and mini projects
need this to work.

To configure Caddy server, you must provide the server with a configuration
file. By default, it's called `Caaddyfile`.

```caddyfile
{
  order cgi before respond
}

examples.mitjafelicijan.com {
  cgi /bash-test /opt/projects/examples/bash-test.sh
  cgi /tcl-test /opt/projects/examples/tcl-test.tcl
  cgi /lua-test /opt/projects/examples/lua-test.lua

  root * /opt/projects/examples
  file_server
}
```

- The order is very important. Make sure that `order cgi before respond` is at
  the top of the configuration file.
- Also, when you run with Caddy v2, make sure you provide `adapter` argument
  like this `/usr/bin/caddy run --watch --environ --config /etc/caddy/Caddyfile
  --adapter caddyfile`. Otherwise, Caddy will try to use a different format for
  config file.

I did a small batch of tests with [Bash](https://www.gnu.org/software/bash/),
[Tcl](https://www.tcl-lang.org/) and [Lua](https://www.lua.org/). Here is a
cheat sheet if you need it.

Let's get Bash out the way first.

```bash
#!/usr/bin/bash

printf "Content-type: text/plain\n\n"

printf "Hello from Bash\n\n"
printf "PATH_INFO     [%s]\n" $PATH_INFO
printf "QUERY_STRING  [%s]\n" $QUERY_STRING
printf "\n"

for i in {0..9..1}; do
  printf "> %s\n" $i
done

exit 0
```

This one is for Tcl script.

```tcl
#!/usr/bin/tclsh

puts "Content-type: text/plain\n"

puts "Hello from Tcl\n"
puts "PATH_INFO     \[$env(PATH_INFO)\]"
puts "QUERY_STRING  \[$env(QUERY_STRING)\]"
puts ""

for {set i 0} {$i < 10} {incr i} {
  puts "> $i"
}
```

And for the final example, Lua.

```lua
#!/usr/bin/lua

print("Content-type: text/plain\n")

print("Hello from Lua\n")
print(string.format("PATH_INFO     [%s]", os.getenv("PATH_INFO")))
print(string.format("QUERY_STRING  [%s]", os.getenv("QUERY_STRING")))
print()

for i = 0, 9 do
  print(string.format("> %d", i))
end
```

## Basic authentication

One thing was also to have an option for some sort of authentication, and
something like [Basic access
authentication](https://en.wikipedia.org/wiki/Basic_access_authentication) would
be more than enough.

Thankfully, Caddy supports this out of the box already. Below is an updated
example.

```Caddyfile
{
    order cgi before respond
}

examples.mitjafelicijan.com {
  cgi /bash-test /opt/projects/examples/bash-test.sh
  cgi /tcl-test /opt/projects/examples/tcl-test.tcl
  cgi /lua-test /opt/projects/examples/lua-test.lua

  root * /opt/projects/examples
  file_server

  basicauth * {
    bob $2a$14$/wCgaf9oMnmQa20txB76u.nI1AldGMBT/1J7fXCfgOiRShwz/JOkK
  }
}
```

`basicauth *` matches everything under this domain/sub-domain and protects it
with Basic Authentication.

- `bob` is the username
- `hash` is the password

To generate these passwords, execute `caddy hash-password` and this will prompt
you to insert a password twice and spit out a hashed password that you can put
in your configuration file.

Restart the server and you are ready to go.

## Making Caddy a service with systemd

After the tests were successful, I copied `caddy` to `/usr/bin/caddy` and copied
`Caddyfile` to `/etc/caddy/Caddyfile`.

Now off to the systemd. Each systemd service requires you to create a service
file.

- I created a `/etc/systemd/system/caddy.service` and put the following content
  in the file.

```systemd
[Unit]
Description=Caddy
Documentation=https://caddyserver.com/docs/
After=network.target network-online.target
Requires=network-online.target

[Service]
Type=notify
User=root
Group=root
ExecStart=/usr/bin/caddy run --environ --config /etc/caddy/Caddyfile --adapter caddyfile
ExecReload=/usr/bin/caddy reload --config /etc/caddy/Caddyfile --force --adapter caddyfile
TimeoutStopSec=5s
LimitNOFILE=1048576
LimitNPROC=512
PrivateTmp=true
ProtectSystem=full
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```

- Then I enabled the service with `systemctl enable caddy.service`.
- And then I started the service with `systemctl start caddy.service`.

This was about all that I needed to do to get it running. Now I can easily add
new subdomains and domains to the main configuration file and be done with
it. No manual Let's Encrypt shenanigans needed.
