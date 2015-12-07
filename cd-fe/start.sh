#!/bin/bash
service nginx start
consul-template -consul=$CONSUL_URL -template="/tmp/nginx.ctmpl:/etc/nginx/conf.d/nginx.conf:service nginx reload"
