deploy:
	alternator --build
	cd public && scp -r * root@165.22.87.180:/var/www/html/mitjafelicijan.com/