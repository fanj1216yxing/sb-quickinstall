apt install lsof
echo '* - nofile 999900' | sudo tee -a /etc/security/limits.conf
ulimit -n 999900
