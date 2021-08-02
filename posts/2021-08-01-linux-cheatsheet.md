---
Title: List of essential Linux commands for server management
Description: List of essential Linux commands for server management
Slug: linux-cheatsheet
Listing: true
Created: 2021-08-01
Tags: []
---

**Table of contents**

1. [Generate SSH key](#generate-ssh-key)
2. [Login to host via SSH](#login-to-host-via-ssh)
3. [Execute command on a server through SSH](#execute-command-on-a-server-through-ssh)
4. [Displays currently logged in users in the system](#displays-currently-logged-in-users-in-the-system)
5. [Displays Linux system information](#displays-linux-system-information)
6. [Displays kernel release information](#displays-kernel-release-information)
7. [Shows the system hostname](#shows-the-system-hostname)
8. [Shows system reboot history](#shows-system-reboot-history)
9. [Displays information about the user](#displays-information-about-the-user)
10. [Displays IP addresses and all the network interfaces](#displays-ip-addresses-and-all-the-network-interfaces)
11. [Downloads a file from an online source](#downloads-a-file-from-an-online-source)
12. [Compress a file with gzip](#compress-a-file-with-gzip)
13. [Interactive disk usage analyzer](#interactive-disk-usage-analyzer)
14. [Install Node.js using the Node Version Manager](#install-nodejs-using-the-node-version-manager)
15. [Too long; didn't read](#too-long-didnt-read)
16. [Combine all Nginx access logs to one big log file](#combine-all-nginx-access-logs-to-one-big-log-file)
17. [Set up Redis server](#set-up-redis-server)
18. [Generate statistics of your webserver](#generate-statistics-of-your-webserver)
19. [Search for a given pattern in files](#search-for-a-given-pattern-in-files)
20. [Find proccess ID for a specific program](#find-proccess-id-for-a-specific-program)
21. [Print name of current/working directory](#print-name-of-currentworking-directory)
22. [Creates a blank new file](#creates-a-blank-new-file)
23. [Displays first lines in a file](#displays-first-lines-in-a-file)
24. [Displays last lines in a file](#displays-last-lines-in-a-file)
25. [Count lines in a file](#count-lines-in-a-file)
26. [Find all instances of the file](#find-all-instances-of-the-file)
27. [Find file names that begin with ‘index’ in /home folder](#find-file-names-that-begin-with-index-in-home-folder)
28. [Find files larger than 100MB in the home folder](#find-files-larger-than-100mb-in-the-home-folder)
29. [Displays block devices related information](#displays-block-devices-related-information)
30. [Displays free space on mounted systems](#displays-free-space-on-mounted-systems)
31. [Displays free and used memory in the system](#displays-free-and-used-memory-in-the-system)
32. [Displays all active listening ports](#displays-all-active-listening-ports)
33. [Kill a process violently](#kill-a-process-violently)
34. [List files opened by user](#list-files-opened-by-user)
35. [Execute "df -h", showing periodic updates](#execute-df--h-showing-periodic-updates)


##### Generate SSH key

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"

# when no support for Ed25519 present
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

Note: By default SSH keys get stored to `/home/<username>/.ssh/` folder.



##### Login to host via SSH

```bash
# connect to host as your local username
ssh host

# connect to host as user
ssh <user>@<host>

# connect to host using port
ssh -p <port> <user>@<host>
```



##### Execute command on a server through SSH

```bash
# execute one command
ssh root@100.100.100.100 "ls /root"

# execute many commands
ssh root@100.100.100.100 "cd /root;touch file.txt"
```



##### Displays currently logged in users in the system

```bash
w
```



##### Displays Linux system information

```bash
uname
```



##### Displays kernel release information

```bash
uname -r
```



##### Shows the system hostname

```bash
hostname
```



##### Shows system reboot history

```bash
last reboot
```



##### Displays information about the user

```bash
sudo apt install finger
finger <username>
```



##### Displays IP addresses and all the network interfaces

```bash
ip addr show
```



##### Downloads a file from an online source

```bash
wget https://example.com/example.tgz
```

Note: If URL contains ?, & enclose the URL in double quotes.



##### Compress a file with gzip

```bash
# will not keep the original file
gzip file.txt

# will keep the original file
gzip --keep file.txt
```



##### Interactive disk usage analyzer

```bash
sudo apt install ncdu

ncdu
ncdu <path/to/directory>
```



##### Install Node.js using the Node Version Manager

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
source ~/.bashrc

nvm install v13
```



##### Too long; didn't read

```bash
npm install -g tldr

tldr tar
```



##### Combine all Nginx access logs to one big log file

```bash
zcat -f /var/log/nginx/access.log* > /var/log/nginx/access-all.log
```



##### Set up Redis server

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



##### Generate statistics of your webserver

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



##### Search for a given pattern in files

```bash
grep -r ‘pattern’ files
```



##### Find proccess ID for a specific program

```bash
pgrep nginx
```



##### Print name of current/working directory

```bash
pwd
```



##### Creates a blank new file

```bash
touch newfile.txt
```



##### Displays first lines in a file

```bash
# -n <x> presents the number of lines (10 by default)
head -n 20 somefile.txt
```



##### Displays last lines in a file

```bash
# -n <x> presents the number of lines (10 by default)
tail -n 20 somefile.txt

# -f follows the changes in file (doesn't closes)
tail -f somefile.txt
```



##### Count lines in a file

```bash
wc -l somefile.txt
```



##### Find all instances of the file

```bash
sudo apt install mlocate

locate somefile.txt
```



##### Find file names that begin with ‘index’ in /home folder

```bash
find /home/ -name "index"
```



##### Find files larger than 100MB in the home folder

```bash
find /home -size +100M
```



##### Displays block devices related information

```bash
lsblk
```



##### Displays free space on mounted systems

```bash
df -h
```



##### Displays free and used memory in the system

```bash
free -h
```



##### Displays all active listening ports

```bash
sudo apt install net-tools

netstat -pnltu
```



##### Kill a process violently

```bash
kill -9 <pid>
```



##### List files opened by user

```bash
lsof -u <user>
```



##### Execute "df -h", showing periodic updates

```bash
# -n 1 means every second
watch -n 1 df -h
```



