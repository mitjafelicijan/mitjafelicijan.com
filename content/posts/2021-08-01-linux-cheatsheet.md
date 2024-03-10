---
title: List of essential Linux commands for server management
url: linux-cheatsheet.html
date: 2021-08-01T12:00:00+02:00
type: post
draft: false
---

**Generate SSH key**

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"

# when no support for Ed25519 present
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Note: By default SSH keys get stored to `/home/<username>/.ssh/` folder.

**Login to host via SSH**

```bash
# connect to host as your local username
ssh host

# connect to host as user
ssh <user>@<host>

# connect to host using port
ssh -p <port> <user>@<host>
```

**Execute command on a server through SSH**

```bash
# execute one command
ssh root@100.100.100.100 "ls /root"

# execute many commands
ssh root@100.100.100.100 "cd /root;touch file.txt"
```

**Displays currently logged in users in the system**

```bash
w
```

**Displays Linux system information**

```bash
uname
```

**Displays kernel release information**

```bash
uname -r
```

**Shows the system hostname**

```bash
hostname
```

**Shows system reboot history**

```bash
last reboot
```

**Displays information about the user**

```bash
sudo apt install finger
finger <username>
```

**Displays IP addresses and all the network interfaces**

```bash
ip addr show
```

**Downloads a file from an online source**

```bash
wget https://example.com/example.tgz
```

Note: If URL contains ?, & enclose the URL in double quotes.

**Compress a file with gzip**

```bash
# will not keep the original file
gzip file.txt

# will keep the original file
gzip --keep file.txt
```

**Interactive disk usage analyzer**

```bash
sudo apt install ncdu

ncdu
ncdu <path/to/directory>
```

**Install Node.js using the Node Version Manager**

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc

nvm install v13
```

**Too long; didn't read**

```bash
npm install -g tldr

tldr tar
```

**Combine all Nginx access logs to one big log file**

```bash
zcat -f /var/log/nginx/access.log* > /var/log/nginx/access-all.log
```

**Set up Redis server**

```bash
sudo apt install redis-server redis-tools

# check if server is running
sudo service redis status

# set and get a key value
redis-cli set mykey myvalue
redis-cli get mykey

# interactive shell
redis-cli
```

**Generate statistics of your webserver**

```bash
sudo apt install goaccess

# check if installed
goaccess -v

# combine logs
zcat -f /var/log/nginx/access.log* > /var/log/nginx/access-all.log

# export to single html
goaccess \
  --log-file=/var/log/nginx/access-all.log \
  --log-format=COMBINED \
  --exclude-ip=0.0.0.0 \
  --ignore-crawlers \
  --real-os \
  --output=/var/www/html/stats.html

# cleanup afterwards
rm /var/log/nginx/access-all.log
```

**Search for a given pattern in files**

```bash
grep -r ‘pattern’ files
```

**Find proccess ID for a specific program**

```bash
pgrep nginx
```

**Print name of current/working directory**

```bash
pwd
```

**Creates a blank new file**

```bash
touch newfile.txt
```

**Displays first lines in a file**

```bash
# -n <x> presents the number of lines (10 by default)
head -n 20 somefile.txt
```

**Displays last lines in a file**

```bash
# -n <x> presents the number of lines (10 by default)
tail -n 20 somefile.txt

# -f follows the changes in file (doesn't closes)
tail -f somefile.txt
```

**Count lines in a file**

```bash
wc -l somefile.txt
```

**Find all instances of the file**

```bash
sudo apt install mlocate

locate somefile.txt
```

**Find file names that begin with ‘index’ in /home folder**

```bash
find /home/ -name "index"
```

**Find files larger than 100MB in the home folder**

```bash
find /home -size +100M
```

**Displays block devices related information**

```bash
lsblk
```

**Displays free space on mounted systems**

```bash
df -h
```

**Displays free and used memory in the system**

```bash
free -h
```

**Displays all active listening ports**

```bash
sudo apt install net-tools

netstat -pnltu
```

**Kill a process violently**

```bash
kill -9 <pid>
```

**List files opened by user**

```bash
lsof -u <user>
```

**Execute "df -h", showing periodic updates**

```bash
# -n 1 means every second
watch -n 1 df -h
```

