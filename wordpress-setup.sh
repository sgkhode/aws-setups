#!/usr/bin/env bash

echo "
----------------------
 Step 1: Install The Lego Client
----------------------
"
cd /tmp

curl -Ls https://api.github.com/repos/xenolf/lego/releases/latest | grep browser_download_url | grep linux_amd64 | cut -d '"' -f 4 | wget -i -
tar xf lego*
sudo mkdir -p /opt/bitnami/letsencrypt
sudo mv lego /opt/bitnami/letsencrypt/lego


echo "
----------------------
Step 2: Generate A Let’s Encrypt Certificate For Your Domain
----------------------
"
sudo /opt/bitnami/ctlscript.sh stop

sudo /opt/bitnami/letsencrypt/lego --tls --email="sgkhode@gmail.com" --domains="wordsmaya.com" --domains="www.wordsmaya.com" --path="/opt/bitnami/letsencrypt" run


echo "
----------------------
Step 2: Generate A Let’s Encrypt Certificate For Your Domain
----------------------
"

sudo mv /opt/bitnami/nginx/conf/server.crt /opt/bitnami/nginx/conf/server.crt.old
sudo mv /opt/bitnami/nginx/conf/server.key /opt/bitnami/nginx/conf/server.key.old
sudo mv /opt/bitnami/nginx/conf/server.csr /opt/bitnami/nginx/conf/server.csr.old
sudo ln -sf /opt/bitnami/letsencrypt/certificates/wordsmaya.com.key /opt/bitnami/nginx/conf/server.key
sudo ln -sf /opt/bitnami/letsencrypt/certificates/wordsmaya.com.crt /opt/bitnami/nginx/conf/server.crt
sudo chown root:root /opt/bitnami/nginx/conf/server*
sudo chmod 600 /opt/bitnami/nginx/conf/server*


sudo /opt/bitnami/ctlscript.sh start

rm -rf /opt/bitnami/letsencrypt

echo "
----------------------
Step 2: Setup Renew The Let’s Encrypt Certificate
----------------------
"
