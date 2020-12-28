MAKEFLAGS += -j2

dev: server watch

watch:
	find content/* templates/* static/* | entr make generate

server:
	browser-sync start --server ./public --watch --no-open --no-notify

clean:
	rm -rf public/*

generate:
	staticgen --generate

deploy: clean generate copy-weekly-links
	firebase deploy

copy-weekly-links:
	mkdir -p public/weekly-newsletter-archive
	cp -rf newsletter/generated/* public/weekly-newsletter-archive/
