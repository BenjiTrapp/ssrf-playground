FROM ubuntu:16.04

RUN apt-get -y update  && apt-get -y upgrade
RUN apt-get install apache2 php libapache2-mod-php php-mcrypt php-curl -y

COPY www/ /var/www/html/
RUN  echo "ctf{w3lcom3_t0_th3_jungl3}" >> /etc/flag.txt

CMD ["apachectl", "-D", "FOREGROUND"]
EXPOSE 80 443
