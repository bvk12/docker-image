FROM ubuntu:latest

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y apache2
copy index.html /var/www/html/index.html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]