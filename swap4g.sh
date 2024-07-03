fallocate -l 9G /swapfile

ls -lh /swapfile

chmod 600 /swapfile

mkswap /swapfile

swapon /swapfile

swapon --show

free -h

wapon
apt install lsof
echo '* - nofile 999900' | sudo tee -a /etc/security/limits.conf
ulimit -n 999900
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
lsmod | grep bbr

