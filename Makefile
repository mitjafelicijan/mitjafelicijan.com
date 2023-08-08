MAKEFLAGS=-j4

# Using: https://github.com/mitjafelicijan/jbmafp

dev:
	jbmafp --build --server

openring:
	openring -l 165 -n 8 -p 1 \
		-s https://jcs.org/rss \
		-s https://chotrin.org/rss.xml \
		-s https://drewdevault.com/feed.xml \
		-s https://offbeatpursuit.com/blog/index.rss \
		-s https://mirzapandzo.com/rss.xml \
		-s https://journal.valeriansaliou.name/rss/ \
		-s https://neil.computer/rss/ \
		-s https://solar.lowtechmagazine.com/posts/index.xml \
		< templates/openring.html \
		> templates/includes/openring.html

build: openring
	jbmafp --build

deploy: build
	rsync -az --delete public/ root@mitjafelicijan.com:/var/www/html/mitjafelicijan.com/
	ssh root@mitjafelicijan.com chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf
