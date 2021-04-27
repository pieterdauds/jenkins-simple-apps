FROM registry:5000/httpd:latest
WORKDIR /var/www/html
COPY index.html /var/www/html/
expose 80
