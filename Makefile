MAKEFLAGS=-j4

# Using: https://github.com/mitjafelicijan/jbmafp

build: openring
	python3 vault.py
	jbmafp --build

dev:
	jbmafp --build --server

openring:
	openring -l 300 -n 10 -p 1 \
		-s https://jcs.org/rss \
		-s https://landley.net/rss.xml \
		-s https://drewdevault.com/feed.xml \
		-s https://offbeatpursuit.com/blog/index.rss \
		-s https://mirzapandzo.com/rss.xml \
		-s https://journal.valeriansaliou.name/rss/ \
		-s https://neil.computer/rss/ \
		-s https://michael.stapelberg.ch/feed.xml \
		-s https://utcc.utoronto.ca/~cks/space/blog/?atom \
		-s https://szymonkaliski.com/feed.xml \
		< templates/openring.html \
		> templates/includes/openring.html

deploy: build
	rsync -az --delete public/ root@mitjafelicijan.com:/var/www/html/mitjafelicijan.com/
	ssh root@mitjafelicijan.com chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf
