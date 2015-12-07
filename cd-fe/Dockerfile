FROM nginx:latest
MAINTAINER Richard Attermeyer version: 0.1

COPY html /usr/share/nginx/html
COPY nginx.static /etc/nginx/conf.d/10-nginx.conf

RUN chmod -R +r /usr/share/nginx/html

