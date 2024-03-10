MAKEFLAGS+=-j2

dev: watch server

watch:
	find . -type f \( -name "*.html" -o -name "*.js" -o -name "*.md" -o -name "*.yaml" -o -name "*.css" -o -name "*.xml" \) | entr jbmafp -b

server:
	jbmafp -s
