FROM nginx

RUN apt-get update && \
    apt-get install -y --no-install-recommends python3-dnspython certbot && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/ && \
    mkdir -p /var/www/letsencrypt/

COPY ./overlay/ /

VOLUME /etc/letsencrypt
