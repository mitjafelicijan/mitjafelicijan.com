GS ?= gostatic

compile: clean
	$(GS) config

clean:
	-rm public -rf

dev: clean
	$(GS) -w config

deploy: clean compile
	firebase deploy
