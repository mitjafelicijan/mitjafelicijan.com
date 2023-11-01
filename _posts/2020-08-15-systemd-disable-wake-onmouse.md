---
title: Disable mouse wake from suspend with systemd service
permalink: /disable-mouse-wake-from-suspend-with-systemd-service.html
date: 2020-08-15T12:00:00+02:00
layout: post
type: post
draft: false
---

I recently bought [ThinkPad
X220](https://www.laptopmag.com/reviews/laptops/lenovo-thinkpad-x220) just as a
joke on eBay to test Linux distributions and play around with things and not
destroy my main machine. Little to my knowledge I felt in love with it.  Man,
they really made awesome machines back then.

After changing disk that came with it to SSD and installing Ubuntu to test if 
everything works I noticed that even after a single touch of my external mouse
the system would wake up from sleep even though the lid was shut down.

I wouldn't even noticed it if laptop didn't have [LED
sleep indicator](https://support.lenovo.com/lk/en/solutions/~/media/Images/ContentImages/p/pd025386_x1_status_03.ashx?w=426&h=262).
I already had a bad experience with Linux and it's power management. I had a
[Dell Inspiron 7537](https://www.pcmag.com/reviews/dell-inspiron-15-7537) laptop
with a touchscreen and while traveling it decided to wake up and started cooking
in my backpack to the point that the digitizer responsible for touch actually
glue off and the whole screen got wrecked. So, I am a bit touchy about this.

I went on solution hunting and to my surprise there is no easy way to disable
specific devices to perform wake up. Why is this not under the power management 
tab in setting is really strange.

After googling for a solution I found [this nice article describing the
solution](https://codetrips.com/2020/03/18/ubuntu-disable-mouse-wake-from-suspend/)
that worked for me. The only problem with this solution was that he added his
solution to `.bashrc` and this triggers `sudo` that asks for a password each
time new terminal is opened, which get annoying quickly since I open a lot of
terminals all the time.

I followed his instructions and got to solution `sudo sh -c "echo 'disabled' >
/sys/bus/usb/devices/2-1.1/power/wakeup"`.

I created a system service file `sudo nano
/etc/systemd/system/disable-mouse-wakeup.service` and removed `sudo` and
replaced `sh` with `/usr/bin/sh` and pasted all that in `ExecStart`.

```ini
[Unit]
Description=Disables wakeup on mouse event
After=network.target
StartLimitIntervalSec=0

[Service]
Type=simple
Restart=always
RestartSec=1
User=root
ExecStart=/usr/bin/sh -c "echo 'disabled' > /sys/bus/usb/devices/2-1.1/power/wakeup"

[Install]
WantedBy=multi-user.target
```

After that I enabled, started and checked status of service.

```sh
sudo systemctl enable disable-mouse-wakeup.service
sudo systemctl start disable-mouse-wakeup.service
sudo systemctl status disable-mouse-wakeup.service
```

This will permanently disable that device from wakeing up you computer on boot.
If you have many devices you would like to surpress from waking up your machine
I would create a shell script and call that instead of direclty doing it in
service file.
