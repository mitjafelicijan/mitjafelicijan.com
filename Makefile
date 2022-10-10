dev: openring
	hugo server --bind=0.0.0.0

deploy: openring
	hugo --gc --minify
	rsync -az --delete public/ root@165.22.87.180:/var/www/html/mitjafelicijan.com/
	ssh root@165.22.87.180 chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf

openring:
	openring -l 165 -n 6 -p 1 \
		-s https://drewdevault.com/feed.xml \
		-s https://danluu.com/atom.xml \
		-s https://mirzapandzo.com/feed/feed.xml \
		-s https://serokell.io/blog.rss.xml \
		-s https://cronokirby.com/posts/index.xml \
		-s https://www.jeffgeerling.com/blog.xml \
		< themes/simple/openring/openring.html \
		> themes/simple/layouts/partials/openring.html

provision:
	cd ~/Junk \
	git clone https://git.sr.ht/~sircmpwn/openring \
	cd openring \
	go build \
	go install
