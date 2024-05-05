apt install curl unzip wget -y
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
