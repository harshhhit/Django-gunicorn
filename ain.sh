#!/bin/bash
deactivate

echo "server {
    listen 80;
    server_name 3.110.171.125;
   
    location / {
        include proxy_params;
        proxy_pass /home/ubuntu/env/bin/gunicorn ;
    }
}" > /etc/nginx/sites-available/djangot2

sudo ln -s /etc/nginx/sites-available/djangot2 /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx

