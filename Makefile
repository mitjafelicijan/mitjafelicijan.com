watch:
	find content/*.md | entr make generate

server:
	browser-sync start --server ./public --watch --no-open --no-notify

clean:
	rm -rf public/*

generate:
	staticgen --generate

deploy: clean generate
	firebase deploy
