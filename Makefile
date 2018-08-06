clean:
	-rm -Rf _site/

run: clean
	bundle exec jekyll serve --incremental
