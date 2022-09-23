#!/bin/bash

ENV_FILE=./.env
NGINX_CRT_FILE=./nginx.crt
NGINX_KEY_FILE=./nginx.key

if test -f "$ENV_FILE"; then
    echo "env file exists"
else
    echo "creating env file from example"
    cp .env.example .env
fi

if test -f "$NGINX_CRT_FILE" && test -f "$NGINX_KEY_FILE"; then
    echo "ssl certificate file exists"
else
    echo "creating new ssl certificate"
    openssl req \
        -x509 \
        -nodes \
        -days 1825 \
        -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=www.example.com" \
        -newkey rsa:2048 \
        -keyout ./nginx.key \
        -out ./nginx.crt
fi

docker compose up -d --build
