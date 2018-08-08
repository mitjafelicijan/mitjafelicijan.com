clean:
	-rm -Rf _site/

run: clean
	bundle exec jekyll serve --incremental --drafts

publish:
	cp _includes/site.min.css assets/site.min.css # for service worker
	git add .
	git commit -m "content update"
	git push
