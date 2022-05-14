
deactivate


echo "[Unit]
Description=gunicorn daemon
After=network.target
[Service]
User=ubuntu
Group=www-data
WorkingDirectory=/home/ubuntu/
ExecStart=/home/ubuntu/env/bin/gunicorn \
          --access-logfile - \
          --workers 3 \
          --bind 0.0.0.0:8000 \
          djangot.wsgi:application
[Install]
WantedBy=multi-user.target" > /etc/systemd/system/gunicorn.service


echo "server {
    listen 80;
    server_name 15.207.221.133;
    location = /favicon.ico { access_log off; log_not_found off; }
    location /static/ {
        root /home/ubuntu;
    }
    location / {
        include proxy_params;
        proxy_pass http://15.207.221.133:8000;
    }
}" > /etc/nginx/sites-available/djangot2






sudo ln -s /etc/nginx/sites-available/djangot2 /etc/nginx/sites-enabled/
sudo rm /etc/nginx/sites-enabled/default
sudo systemctl restart nginx
