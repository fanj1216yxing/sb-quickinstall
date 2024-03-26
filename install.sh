apt-get update&&apt-get upgrade
apt-get -y purge apache2-* bind9-* xinetd samba-* nscd-* portmap sendmail-* sasl2-bin
apt-get -y purge lynx memtester unixodbc python-* odbcinst-* sudo tcpdump ttf-*
apt-get autoremove && apt-get clean
apt install curl unzip wget -y
bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) -u aaa -p 123456 -c 3072 -q 4.3.9 -l v1.2.19 -3
bash <(wget -qO- https://raw.githubusercontent.com/fanj1216yxing/sb-quickinstall/main/tr.sh)
1
1
fallocate -l 16G /swapfile
ls -lh /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
swapon --show
free -h
bash <(wget -qO- https://raw.githubusercontent.com/fanj1216yxing/sb-quickinstall/main/better.sh)
