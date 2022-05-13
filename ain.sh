#!/bin/bash
deactivate


echo "[Unit]
Description=gunicorn daemon
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/
ExecStart=/home/ubuntu/env/bin/gunicorn 
         
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/gunicorn.service


echo "server {
    listen 80;
    server_name 3.110.171.125;
  
    location / {
        include proxy_params;
        proxy_pass /home/ubuntu/env/bin/gunicorn 
    }
}" > /etc/nginx/sites-available/djangot2

sudo ln -s /etc/nginx/sites-available/djangot2 /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default

sudo systemctl restart nginx
