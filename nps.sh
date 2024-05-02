wget --no-check-certificate https://lnmp.club/lnmp1.9-full.tar.gz
md5sum lnmp1.9-full.tar.gz
tar zxf lnmp1.9-full.tar.gz && cd lnmp1.9-full && LNMP_Auto="y" DBSelect="10" Bin="n" DB_Root_Password="password230523" InstallInnodb="y" PHPSelect="12" SelectMalloc="1" ./install.sh lnmp
cd /root/lnmp1.9-full
./addons.sh install opcache
./addons.sh install fileinfo
./addons.sh install redis
cd /root/lnmp1.9-full/src
tar -jxvf php-8.0.20.tar.bz2
cd php-8.0.20/ext/gmp
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config
make && make install
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
mysql -u root -p 
password230523 
create database  nexusphp default charset=utf8mb4 collate utf8mb4_general_ci;
quit
cd /home/wwwroot
wget https://github.com/xiaomlove/nexusphp/archive/refs/tags/v1.8.10.zip
unzip v1.8.10.zip
mkdir pt.jp.rolling.eu.org 
cp -r nexusphp-1.8.10/. /home/wwwroot/pt.jp.rolling.eu.org
cd /home/wwwroot/pt.jp.rolling.eu.org
composer install
cp -R /home/wwwroot/pt.jp.rolling.eu.org/nexus/Install/install /home/wwwroot/pt.jp.rolling.eu.org/public/
chmod -R 0777 /home/wwwroot/pt.jp.rolling.eu.org
wget --no-check-certificate https://web-dl.cc/share/pt.jp.rolling.eu.org.conf
mv pt.jp.rolling.eu.org.conf /usr/local/nginx/conf/vhost/demo.nexusphp.org.conf
cat > /usr/local/nginx/conf/vhost/demo.nexusphp.org.conf <<- EOM
server {
# 以实际为准
root RUN_PATH; 

server_name pt.jp.rolling.eu.org;

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

access_log /var/log/nginx/pt.jp.rolling.eu.org.access.log;
error_log /var/log/nginx/pt.jp.rolling.eu.org.error.log;
}
EOM
cd /usr/local/php/etc/php-fpm.d
wget --no-check-certificate https://web-dl.cc/share/php-fpm-pt.conf
echo 'include = etc/php-fpm.d/*.conf' | sudo tee -a /usr/local/php/etc/php-fpm.conf
/etc/init.d/php-fpm restart
