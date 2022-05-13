#!/bin/bash
deactivate


echo "[Unit]
Description=gunicorn daemon

After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/
ExecStart=/home/ubuntu/env/bin/gunicorn \
          

echo "server {
    listen 80;
    server_name 3.110.171.125;
    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/ubuntu;
    }
    location / {
        include proxy_params;
        proxy_pass http://unix:/run/gunicorn.sock;
    }
}" > /etc/nginx/sites-available/djangot2

sudo ln -s /etc/nginx/sites-available/djangot2 /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

