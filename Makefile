provision:
	cd ~/Junk
	git clone https://git.sr.ht/~sircmpwn/openring
	cd openring
	go build
	go install

build:
	openring -n 4 -p 2 \
		-s https://drewdevault.com/feed.xml \
		-s https://danluu.com/atom.xml \
		< template/openring.tmpl \
		> template/openring-build.html

	alternator --build
	rm template/openring-build.html

deploy: build
	cd public && scp -r * root@165.22.87.180:/var/www/html/mitjafelicijan.com/
