# Nginx Let's Encrypt Proxy
Docker Image with nginx & certbot 
-----

## Features
* Redirect all http traffic to https
* Server the acme challenge in http thru nginx

## Basic Usage
```bash
# Add --staging to all command in order test all the process without reaching api limit of Let's encrypt

# Run the container 
docker run -p 80:80 --name='nginx-letsencypt-proxy' nightech/nginx-letsencrypt proxy

# Cert generation
docker exec nginx-letsencypt certbot certonly -n --webroot --staging -d {DOMAIN} -d {SUBDOMAIN} -m {EMAIL}

# DNS challenge
docker exec -ti nginx-letsencypt certbot certonly --manual --preferred-challenges=dns-01  -d {DOMAIN} -d {SUBDOMAIN} -m {EMAIL}

# Cert renew (not working with dns challenge, used certonly command
docker exec nginx-letsencypt certbot renew 

# Crontab example 
docker exec nginx-letsencypt certbot renew  && docker exec {NGINX-CONTAINER} nginx -s reload 
```
