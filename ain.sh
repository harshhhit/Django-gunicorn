#!/bin/bash
deactivate
echo "[Unit]
Description=gunicorn socket
[Socket]
ListenStream=/run/gunicorn.sock
[Install]
WantedBy=sockets.target" > /etc/systemd/system/gunicorn.socket

echo "[Unit]
Description=gunicorn daemon
Requires=gunicorn.socket
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/
ExecStart=/home/ubuntu/env/bin/gunicorn \
          --access-logfile - \
          --workers 3 \
          --bind unix:/run/gunicorn.sock \
          djangot.wsgi:application
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/gunicorn.service

sudo systemctl start gunicorn.socket
sudo systemctl enable gunicorn.socket

echo "server {
    listen 80;
    server_name localhost:80;
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
