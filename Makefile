dev:
	browser-sync ./public/ -w --no-notify --no-open --extensions=.html

clean:
	rm -rf public/*

generate:
	staticgen --generate

deploy: clean generate
	firebase deploy
