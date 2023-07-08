MAKEFLAGS=-j4

# Using: https://github.com/mitjafelicijan/jbmafp

build:
	jbmafp --build

deploy:
	jbmafp --build
	rsync -az --delete public/ root@mitjafelicijan.com:/var/www/html/mitjafelicijan.com/
	ssh root@mitjafelicijan.com chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf
