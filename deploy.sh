echo "Copiando configurações do Nginx..."
cp nginx.conf /etc/nginx/nginx.conf

echo "Copiando website para /var/wwww/html/"
cp -r website/ /var/www/html/index.html

nginx -s reload
echo "Script executado com sucesso"