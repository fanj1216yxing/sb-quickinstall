fallocate -l 4G /swapfile

ls -lh /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

swapon --show

free -h

wapon