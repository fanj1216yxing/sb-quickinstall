bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) -u aaa -p 123456 -c 3072 -q 4.3.9 -l v1.2.19 -3
bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/tr.sh)
1
1
fallocate -l 16G /swapfile
ls -lh /swapfile
chmod 600 /swapfile
mkswap /swapfile
swapon /swapfile
swapon --show
free -h
apt install lsof
