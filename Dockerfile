FROM nginx

RUN awk '$1 ~ "^deb" { $3 = $3 "-backports"; print; exit }' /etc/apt/sources.list > /etc/apt/sources.list.d/backports.list && \
    apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
    apt-get update && \
    apt-get install -y --no-install-recommends certbot -t jessie-backports && \
    apt-get install -y --no-install-recommends python-dnspython && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/

RUN mkdir -p /var/www/letsencrypt/ && \
    mkdir -p /etc/letsencrypt/

RUN echo 'rsa-key-size = 4096\n\
text = True\n\
agree-tos = True\n\
renew-by-default = True\n\
webroot-path = /var/www/letsencrypt\n\
' > /etc/letsencrypt/cli.ini

ADD nginx.conf /etc/nginx/nginx.conf

VOLUME /etc/letsencrypt
