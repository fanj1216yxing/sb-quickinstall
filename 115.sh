cd /home/wwwroot
wget https://github.com/xiaomlove/nexusphp/archive/refs/tags/v1.8.10.zip
unzip v1.8.10.zip
mkdir pt.rolling.jp.eu.org
cp -r nexusphp-1.8.10/. /home/wwwroot/pt.rolling.jp.eu.org
cd /home/wwwroot/pt.jp.rolling.eu.org
composer install --ignore-platform-reqs
cp -R /home/wwwroot/pt.rolling.jp.eu.org/nexus/Install/install /home/wwwroot/pt.rolling.jp.eu.org/public/
chmod -R 0777 /home/wwwroot/pt.rolling.jp.eu.org
wget --no-check-certificate https://web-dl.cc/share/pt.jp.rolling.eu.org.conf
mv pt.rolling.jp.eu.org.conf /usr/local/nginx/conf/vhost/demo.nexusphp.org.conf
cat > /usr/local/nginx/conf/vhost/demo.nexusphp.org.conf <<- EOM
server {
# 以实际为准
root RUN_PATH; 

server_name pt.rolling.jp.eu.org;

location / {
    index index.html index.php;
    try_files $uri $uri/ /nexus.php$is_args$args;
}

# Filament
location ^~ /filament {
    try_files $uri $uri/ /nexus.php$is_args$args;
}

location ~ \.php {
    # 以实际为准
    fastcgi_pass 127.0.0.1:9000; 
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    include fastcgi_params;
}

access_log /var/log/nginx/pt.rolling.jp.eu.org.access.log;
error_log /var/log/nginx/pt.rolling.jp.eu.org.error.log;
}
EOM
cd /usr/local/php/etc/php-fpm.d
wget --no-check-certificate https://web-dl.cc/share/php-fpm-pt.conf
echo 'include = etc/php-fpm.d/*.conf' | sudo tee -a /usr/local/php/etc/php-fpm.conf
/etc/init.d/php-fpm restart
