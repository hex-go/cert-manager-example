#!/usr/bin/env bash
openssl genrsa -out ca.key 4096

openssl req -x509 -new -nodes -key ca.key -subj "/CN=icos.city" -days 3650 -reqexts v3_req -extensions v3_ca -out ca.crt

openssl genrsa -out icos.city.key 4096
openssl req -new -sha256 -key icos.city.key -out icos.city.csr -subj "/CN=icos.city"

openssl x509 -req -in icos.city.csr -CA ca.crt -CAkey ca.key -CAcreateserial -days 3560 -out icos.city.crt -extfile icos.city.ini -extensions ext

kubectl --kubeconfig=/home/hex/m1c2 create secret tls test-secret  --cert=icos.city.crt --key=icos.city.key -n mars