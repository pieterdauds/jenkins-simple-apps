FROM registry:5000/httpd:latest
WORKDIR /var/www/html
COPY index.html /usr/local/apache2/htdocs
expose 80
