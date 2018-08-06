clean:
	-rm -Rf _site/

run: clean
	bundle exec jekyll serve --incremental --drafts

publish:
	git add .
	git commit -m "content update"
	git push
