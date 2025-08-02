include makext.mk

help: .help

MAKEFLAGS+=-j2
PROJECTS_FILENAME = content/pages/projects.md

dev: watch server # Starts a development server

watch:
	find . -type f \( -name "*.html" -o -name "*.js" -o -name "*.md" -o -name "*.yaml" -o -name "*.css" -o -name "*.xml" \) | entr jbmafp -b

server:
	jbmafp -s

update-projects: projects-header # Update projects page
	cat content/pages/projects.fossil.md.part \
		content/pages/projects.github.md.part >> \
		content/pages/projects.md

projects-header:
	echo "---" > $(PROJECTS_FILENAME)
	echo "title: Personal projects" >> $(PROJECTS_FILENAME)
	echo "date: 2024-10-21T12:00:00+02:00" >> $(PROJECTS_FILENAME)
	echo "url: projects.html" >> $(PROJECTS_FILENAME)
	echo "type: page-no-title" >> $(PROJECTS_FILENAME)
	echo "draft: false" >> $(PROJECTS_FILENAME)
	echo "---\n" >> $(PROJECTS_FILENAME)

update-fossil: # Update Fossil projects
	cd tools && bash fossil-projects.sh

update-github: # Update GitHub projects
	cd tools && python github-projects.py
