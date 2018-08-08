---
layout: post
title: Using DigitalOcean Spaces Object Storage with FUSE
description: Using DigitalOcean Spaces Object Storage with FUSE
---

**Table of contents**

- [Is it possible to use them as a mounted drive with FUSE?](#is-it-possible-to-use-them-as-a-mounted-drive-with-fuse)
- [Will the performance degrade over time and over different sizes of objects?](#will-the-performance-degrade-over-time-and-over-different-sizes-of-objects)
	- [Measurement experiment 1: File copy](#measurement-experiment-1-file-copy)
	- [Measurement experiment 2: SQLite performanse](#measurement-experiment-2-sqlite-performanse)
- [Can storage be mounted on multiple machines at the same time and be writable?](#can-storage-be-mounted-on-multiple-machines-at-the-same-time-and-be-writable)
- [Observations and conslusion](#observations-and-conslusion)

Couple of months ago [DigitalOcean](https://www.digitalocean.com) introduced new product called [Spaces](https://blog.digitalocean.com/introducing-spaces-object-storage/) which is Object Storage very similar to Amazon's S3. This really peaked my interest, because this was something I was missing and even the thought of going over the internet for such functionality was in no interest to me. Also in fashion with their previous pricing this also is very cheap and pricing page is a no-brainer compared to AWS or GCE. [Prices are clearly and precisely defined and outlined](https://www.digitalocean.com/pricing/). You must love them for that :)

### Initial requirements

* Is it possible to use them as a mounted drive with FUSE? (tl;dr YES)
* Will the performance degrade over time and over different sizes of objects? (tl;dr NO&YES)
* Can storage be mounted on multiple machines at the same time and be writable? (tl;dr YES)

> Let me be clear. This scripts I use are made just for benchmarking and are not intended to be used in real-life situations. Besides that, I am looking into using this approaches but adding caching service in front of it and then dumping everything as an object to storage. This could potentially be some interesting post of itself. But in case you would need real-time data without eventual consistency please take this scripts as they are: not usable in such situations.

## Is it possible to use them as a mounted drive with FUSE?

Well, actually they can be used in such manor. Because they are similar to [AWS S3](https://aws.amazon.com/s3/) many tools are available and you can find many articles and [Stackoverflow items](https://stackoverflow.com/search?q=s3+fuse).

To make this work you will need DigitalOcean account. If you don't have one you will not be able to test this code. But if you have an account then you go and [create new Droplet](https://cloud.digitalocean.com/droplets/new?size=s-1vcpu-1gb&region=ams3&distro=debian&distroImage=debian-9-x64&options=private_networking,install_agent). If you click on this link you will already have preselected Debian 9 with smallest VM option.

* Please be sure to add you SSH key, because we will login to this machine remotely.
* If you change your region please remember which one you choose because we will need this information when we try to mount space to our machine.

Instuctions on how to use SSH keys and how to setup them are available in article [How To Use SSH Keys with DigitalOcean Droplets](https://www.digitalocean.com/community/tutorials/how-to-use-ssh-keys-with-digitalocean-droplets).

![DigitalOcean Droplets](/files/fuse-droplets.png)

After we created Droplet it's time to create new Space. This is done by clicking on a button [Create](https://cloud.digitalocean.com/spaces/new) (right top corner) and selecting Spaces. Choose pronounceable ```Unique name``` because we will use it in examples below. You can either choose Private or Public, it doesn't matter in our case. And you can always change that in the future.

When you have created new Space we should [generate Access key](https://cloud.digitalocean.com/settings/api/tokens). This link will guide to the page when you can generate this key. After you create new one, please save provided Key and Secret because Secret will not be shown again.

![DigitalOcean Spaces](/files/fuse-spaces.png)

Now that we have new Space and Access key we should SSH into our machine.

```bash
# replace IP with the ip of your newly created droplet
ssh root@IP

# this will install utilities for mounting storage objects as FUSE
apt install s3fs

# we now need to provide credentials (access key we created earlier)
# replace KEY and SECRET with your own credentials but leave the colon between them
# we also need to set proper permissions
echo "KEY:SECRET" > .passwd-s3fs
chmod 600 .passwd-s3fs

# now we mount space to our machine
# replace UNIQUE-NAME with the name you choose earlier
# if you choose different region for your space be careful about -ourl option (ams3)
s3fs UNIQUE-NAME /mnt/ -ourl=https://ams3.digitaloceanspaces.com -ouse_cache=/tmp

# now we try to create a file
# once you mount it may take a couple of seconds to retrieve data
echo "Hello cruel world" > /mnt/hello.txt
```

After all this you can return to your browser and go to [DigitalOcean Spaces](https://cloud.digitalocean.com/spaces) and click on your created space. If file hello.txt is present you have successfully mounted space to your machine and wrote data to it.

I choose the same region for my Droplet and my Space but you don't have to. You can have different regions. What this actually does to performance I don't know.

Additional information on FUSE:

* [Github project page for s3fs](https://github.com/s3fs-fuse/s3fs-fuse)
* [FUSE - Filesystem in Userspace](https://en.wikipedia.org/wiki/Filesystem_in_Userspace)

## Will the performance degrade over time and over different sizes of objects?

For this task I didn't want to just read and write text files or uploading images. I actually wanted to figure out if using something like SQlite is viable in this case.

### Measurement experiment 1: File copy

```bash
# first we create some dummy files at different sizes
dd if=/dev/zero of=10KB.dat bs=1024 count=10 #10KB
dd if=/dev/zero of=100KB.dat bs=1024 count=100 #100KB
dd if=/dev/zero of=1MB.dat bs=1024 count=1024 #1MB
dd if=/dev/zero of=10MB.dat bs=1024 count=10240 #10MB

# now we set time command to only return real
TIMEFORMAT=%R

# now lets test it
(time cp 10KB.dat /mnt/) |& tee -a 10KB.results.txt

# and now we automate
# this will perform the same operation 100 times
# this will output results into separated files based on objecty size
n=0; while (( n++ < 100 )); do (time cp 10KB.dat /mnt/10KB.$n.dat) |& tee -a 10KB.results.txt; done
n=0; while (( n++ < 100 )); do (time cp 100KB.dat /mnt/100KB.$n.dat) |& tee -a 100KB.results.txt; done
n=0; while (( n++ < 100 )); do (time cp 1MB.dat /mnt/1MB.$n.dat) |& tee -a 1MB.results.txt; done
n=0; while (( n++ < 100 )); do (time cp 10MB.dat /mnt/10MB.$n.dat) |& tee -a 10MB.results.txt; done
```

Files of size 100MB were not successfully transferred and ended up displaying error (cp: failed to close '/mnt/100MB.1.dat': Operation not permitted).

As I suspected, object size is not really that important. Sadly I don't have the time to test performance over periods of time. But if some of you would do it please send me your data. I would be interested in seeing results.

**Here are plotted results**

You can download [raw result here](/files/copy-benchmarks.tsv). Measurements are in seconds.

<script src="/assets/plotly-latest.min.js"></script>
<div id="copy-benchmarks"></div>
<script>
(function(){
	var request = new XMLHttpRequest();
	request.open("GET", "/files/copy-benchmarks.tsv", true);
	request.onload = function() {
		if (request.status >= 200 && request.status < 400) {
			var payload = request.responseText.trim();
			var tsv = payload.split("\n");
			for (var i=0; i<tsv.length; i++) { tsv[i] = tsv[i].split("\t"); }
			var traces = [];
			var headers = tsv[0];
			tsv.shift();
			Array.prototype.forEach.call(headers, function(el, idx) {
				var x = [];
				var y = [];
				for (var j=0; j<tsv.length; j++) {
					x.push(j);
					y.push(parseFloat(tsv[j][idx].replace(",", ".")));
				}
				traces.push({ x: x, y: y, type: "scatter", name: el, line: { width: 1, shape: "spline" } });
			});
			var copy = Plotly.newPlot("copy-benchmarks", traces, { legend: {"orientation": "h"}, height: 400, margin: { l: 40, r: 0, b: 20, t: 30, pad: 0 }, yaxis: { title: "execution time in seconds", titlefont: { size: 12 } }, xaxis: { title: "fn(i)", titlefont: { size: 12 } } });
		} else { }
	};
	request.onerror = function() { };
	request.send(null);
})();
</script>

As far as these tests show, performance is quite stable and can be predicted which is fantastic. But this is a small test and spans only over couple of hours. So you should not completely trust them.

### Measurement experiment 2: SQLite performanse

I was unable to use database file directly from mounted drive so this is a no-go as I suspected. So I executed code below on a local disk just to get some benchmarks. I inserted 1000 records with DROPTABLE, CREATETABLE, INSERTMANY, FETCHALL, COMMIT for 1000 times to generate statistics. As you can see performance of SQLite is quite amazing. You could then potentially just copy file to mounted drive and be done with it.

```python
import time
import sqlite3
import sys

if len(sys.argv) < 3:
  print("usage: python sqlite-benchmark.py DB_PATH NUM_RECORDS REPEAT")
  exit()

def data_iter(x):
  for i in range(x):
    yield "m" + str(i), "f" + str(i*i)

header_line = "%s\t%s\t%s\t%s\t%s\n" % ("DROPTABLE", "CREATETABLE", "INSERTMANY", "FETCHALL", "COMMIT")
with open("sqlite-benchmarks.tsv", "w") as fp:
  fp.write(header_line)

start_time = time.time()
conn = sqlite3.connect(sys.argv[1])
c = conn.cursor()
end_time = time.time()
result_time = CONNECT = end_time - start_time
print("CONNECT: %g seconds" % (result_time))

start_time = time.time()
c.execute("PRAGMA journal_mode=WAL")
c.execute("PRAGMA temp_store=MEMORY")
c.execute("PRAGMA synchronous=OFF")
result_time = PRAGMA = end_time - start_time
print("PRAGMA: %g seconds" % (result_time))

for i in range(int(sys.argv[3])):
  print("#%i" % (i))

  start_time = time.time()
  c.execute("drop table if exists test")
  end_time = time.time()
  result_time = DROPTABLE = end_time - start_time
  print("DROPTABLE: %g seconds" % (result_time))

  start_time = time.time()
  c.execute("create table if not exists test(a,b)")
  end_time = time.time()
  result_time = CREATETABLE = end_time - start_time
  print("CREATETABLE: %g seconds" % (result_time))

  start_time = time.time()
  c.executemany("INSERT INTO test VALUES (?, ?)", data_iter(int(sys.argv[2])))
  end_time = time.time()
  result_time = INSERTMANY = end_time - start_time
  print("INSERTMANY: %g seconds" % (result_time))

  start_time = time.time()
  c.execute("select count(*) from test")
  res = c.fetchall()
  end_time = time.time()
  result_time = FETCHALL = end_time - start_time
  print("FETCHALL: %g seconds" % (result_time))

  start_time = time.time()
  conn.commit()
  end_time = time.time()
  result_time = COMMIT = end_time - start_time
  print("COMMIT: %g seconds" % (result_time))

  print
  log_line = "%f\t%f\t%f\t%f\t%f\n" % (DROPTABLE, CREATETABLE, INSERTMANY, FETCHALL, COMMIT)
  with open("sqlite-benchmarks.tsv", "a") as fp:
    fp.write(log_line)

start_time = time.time()
conn.close()
end_time = time.time()
result_time = CLOSE = end_time - start_time
print("CLOSE: %g seconds" % (result_time))
```

You can download [raw result here](/files/sqlite-benchmarks.tsv). And again, these results are done on a local block storage and do not represent capabilities of object storage. With my current approach and state of the test code these can not be done. I would need to make Python code much more robust and check locking etc.

<div id="sqlite-benchmarks"></div>
<script>
(function(){
	var request = new XMLHttpRequest();
	request.open("GET", "/files/sqlite-benchmarks.tsv", true);
	request.onload = function() {
		if (request.status >= 200 && request.status < 400) {
			var payload = request.responseText.trim();
			var tsv = payload.split("\n");
			for (var i=0; i<tsv.length; i++) { tsv[i] = tsv[i].split("\t"); }
			var traces = [];
			var headers = tsv[0];
			tsv.shift();
			Array.prototype.forEach.call(headers, function(el, idx) {
				var x = [];
				var y = [];
				for (var j=0; j<tsv.length; j++) {
					x.push(j);
					y.push(parseFloat(tsv[j][idx].replace(",", ".")));
				}
				traces.push({ x: x, y: y, type: "scatter", name: el, line: { width: 1, shape: "spline" } });
			});
			var sqlite = Plotly.newPlot("sqlite-benchmarks", traces, { legend: {"orientation": "h"}, height: 400, margin: { l: 50, r: 0, b: 20, t: 30, pad: 0 }, yaxis: { title: "execution time in seconds", titlefont: { size: 12 } } });
		} else { }
	};
	request.onerror = function() { };
	request.send(null);
})();
</script>

## Can storage be mounted on multiple machines at the same time and be writable?

Well, this one didn't take long to test. And the answer is **YES**. I mounted space on both machines and measured same performance on both machines. But because file is downloaded before write and then uploaded on complete there could potentially be problems is another process is trying to access the same file.

## Observations and conslusion

Using Spaces in this way makes it easier to access and manage files. But besides that you would need to write additional code to make this one play nice with you applications.

Nevertheless, this was extremely simple to setup and use and this is just another excellent product in DigitalOcean product line. I found this exercise very valuable and am thinking about implementing some sort of mechanism for SQLite, so data can be stored on Spaces and accessed by many VM's. For a project where data doesn't need to be accessible in real-time and can have couple of minutes old data this would be very interesting. If any of you find this proposal interesting please write in a comment box below or shoot me an email and I will keep you posted.
