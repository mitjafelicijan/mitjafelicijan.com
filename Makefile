provision:
	cd ~/Junk \
	git clone https://git.sr.ht/~sircmpwn/openring \
	cd openring \
	go build \
	go install

dither:
	bash tools/dither-images.sh

openring:
	openring -l 165 -n 4 -p 1 \
		-s https://cronokirby.com/posts/index.xml \
		-s https://drewdevault.com/feed.xml \
		-s https://danluu.com/atom.xml \
		-s https://serokell.io/blog.rss.xml \
		< template/openring.tmpl \
		> template/openring-build.html

dev: openring
	alternator --watch

build:
	mkdir -p public
	openring -l 165 -n 4 -p 1 \
		-s https://cronokirby.com/posts/index.xml \
		-s https://drewdevault.com/feed.xml \
		-s https://danluu.com/atom.xml \
		-s https://serokell.io/blog.rss.xml \
		< template/openring.tmpl \
		> template/openring-build.html

	alternator --build
	rm template/openring-build.html

server:
	python3 -m http.server 8000 --directory public

deploy: build
	cd public && scp -r * root@165.22.87.180:/var/www/html/mitjafelicijan.com/
	ssh root@165.22.87.180 chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf
