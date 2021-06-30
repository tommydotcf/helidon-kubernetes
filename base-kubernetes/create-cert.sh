#!/bin/bash
echo creating tls secret using sommon name of store.$1.nip.io
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout tls.key -out tls.crt -subj "/CN=store.$1.nip.io/O=nginxsvc"