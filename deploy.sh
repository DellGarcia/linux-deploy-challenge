cp nginx.conf /etc/nginx/nginx.conf
cp website/index.html /var/www/html/index.html

nginx -s reload