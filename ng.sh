sudo apt update -y
sudo apt install nginx -y
sudo mkdir -p /etc/nginx/sites-available /etc/nginx/sites-enabled /var/www/my_static_site
echo "<html><body><h1>Sorry,You have been blocked</h1><p>You are unable to access this website.</p></body></html>"
sudo tee /var/www/my_static_site/index.html
echo 'server { listen 80;server_name _; root /var/www/my_static_site; index index.html; location / { try_files $uri $uri/ =404; } }' | sudo tee /etc/nginx/sites-available/my_static_site
sudo ln -s /etc/nginx/sites-available/my_static_site /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl reload nginx
sudo systemctl start nginx
sudo systemctl status nginx
