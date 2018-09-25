clean:
	-rm -Rf _site/

run: clean
	bundle exec jekyll serve --host=0.0.0.0 --incremental --drafts

publish:
	cp _includes/site.min.css assets/site.min.css # for service worker
	git add .
	git commit -m "content update"
	git push
