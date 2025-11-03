#!/bin/bash

set -xe

openssl ecparam -out attestation_key.pem -name prime256v1 -genkey
openssl pkcs8 -topk8 -inform PEM -outform PEM -in attestation_key.pem -out attestation_key_pkcs8.pem -nocrypt
openssl req -new -sha256 -key attestation_key.pem -out attestation_cert.csr -config attestation_cert.conf
openssl x509 -req -sha256 -in attestation_cert.csr -signkey attestation_key.pem -out attestation_cert.pem -days 3650 -extfile attestation_cert.conf -extensions v3_req
openssl x509 -in attestation_cert.pem -inform PEM -out attestation_cert.crt -outform DER

