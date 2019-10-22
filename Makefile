GS ?= gostatic

compile:
	$(GS) config

w:
	-rm public -rf
	$(GS) -w config

deploy: compile
	firebase deploy
