apt-get update
apt install curl unzip wget -y
bash <(wget -qO- https://raw.githubusercontent.com/jerry048/Dedicated-Seedbox/main/Install.sh) -u aaa -p 123456 -q 4.3.9 -l v1.2.19
bash <(wget -qO- https://raw.githubusercontent.com/fanj1216yxing/sb-quickinstall/main/tr.sh)
1
1
fallocate -l 1G /swapfile

ls -lh /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

swapon --show

free -h

bash <(wget -qO- https://raw.githubusercontent.com/fanj1216yxing/sb-quickinstall/main/better.sh)
