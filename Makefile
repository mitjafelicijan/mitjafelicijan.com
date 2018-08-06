clean:
	-rm -Rf _site/

run: clean
	bundle exec jekyll serve --incremental

publish:
	git add .
	git commit -m "update"
	git push
