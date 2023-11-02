MAKEFLAGS+=-j3

dev: watch server

webring:
	ruby bin/webring.py

watch:
	jekyll b --watch

server:
	mkdir -p _site && cd _site && python3 -m http.server 6969
