MAKEFLAGS=-j4

dev: tailwind-watch dev-server

dev-server: openring
	hugo server --bind=0.0.0.0 --buildDrafts

tailwind-watch:
	npx tailwindcss --jit --minify --watch \
		-i ./themes/simple/static/css/tailwind.css \
		-o ./static/general/index.css

tailwind-build:
	npx tailwindcss --jit --minify \
		-i ./themes/simple/static/css/tailwind.css \
		-o ./static/general/index.css

deploy: openring tailwind-build
	hugo --gc --minify
	rsync -az --delete public/ root@mitjafelicijan.com:/var/www/html/mitjafelicijan.com/
	ssh root@mitjafelicijan.com chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf

openring:
	openring -l 165 -n 6 -p 1 \
		-s https://drewdevault.com/feed.xml \
		-s https://danluu.com/atom.xml \
		-s https://mirzapandzo.com/rss.xml \
		-s https://serokell.io/blog.rss.xml \
		-s https://cronokirby.com/posts/index.xml \
		-s https://www.jeffgeerling.com/blog.xml \
		< themes/simple/openring/openring.html \
		> themes/simple/layouts/partials/openring.html

provision:
	npm install
	cd ~/Junk \
	git clone https://git.sr.ht/~sircmpwn/openring \
	cd openring \
	go build \
	go install
