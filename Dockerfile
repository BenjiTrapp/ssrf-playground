FROM ubuntu:16.04

######################################################################
# ☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠
# ATTENTION: DO NOT RUN IN PRODUCTION - THIS APP IS BROKEN BY DESIGN!
#            
#                     !!!SPOILER ALERT!!!
#         Do not read the stuff below or you'll miss all the fun
#                     !!!SPOILER ALERT!!!
#
# ☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠☠
######################################################################


RUN apt-get -y update  && apt-get -y upgrade
RUN apt-get install apache2 php libapache2-mod-php php-mcrypt php-curl curl -y

# Setup Mock EC2 Metadata Service
RUN curl -kLo /var/ec2-metadata-mock https://github.com/aws/amazon-ec2-metadata-mock/releases/download/v1.10.1/ec2-metadata-mock-`uname | tr '[:upper:]' '[:lower:]'`-amd64 && \
    chmod +x /var/ec2-metadata-mock

COPY aemm-metadata-values.json /var/

COPY www/ /var/www/html/

# Add the flags - spoiler alert!
RUN echo "flag{w3lcom3_t0_th3_jungl3}" >> /etc/flag.txt && \
    mkdir -p /var/run/secrets/kubernetes.io/serviceaccount/ && \
    echo "flag{1t_15_0nly_y4ml_th3y_s41d}" >> /var/run/secrets/kubernetes.io/serviceaccount/token && \
    echo "ssrf-playground-prod" >> /var/run/secrets/kubernetes.io/serviceaccount/namespace && \
    echo "yes - here are normaly certifcates stored" >> /var/run/secrets/kubernetes.io/serviceaccount/ca.crt \
    chmod 777 /etc/shadow

RUN usermod -aG root www-data

CMD /var/ec2-metadata-mock -c /var/aemm-metadata-values.json -s & apachectl -D FOREGROUND && fg

EXPOSE 8080 8443
