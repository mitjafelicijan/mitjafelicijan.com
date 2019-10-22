GS ?= gostatic

compile:
	$(GS) config

dev:
	-rm public -rf
	$(GS) -w config

deploy: compile
	firebase deploy
