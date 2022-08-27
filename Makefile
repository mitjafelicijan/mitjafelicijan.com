dev:
	hugo server

deploy:
	hugo
	rsync -a --delete public/ root@165.22.87.180:/var/www/html/mitjafelicijan.com/
	ssh root@165.22.87.180 chown www-data:www-data /var/www/html/mitjafelicijan.com/ -Rf
