bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) -u aaa -p 123456 -c 3072 -q 4.3.9 -l v1.2.19 -3
sudo fallocate -l 16G /swapfile
ls -lh /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
free -h
apt install lsof
echo '* - nofile 999900' | sudo tee -a /etc/security/limits.conf
