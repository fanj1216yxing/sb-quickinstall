apt install lsof
apt install curl unzip wget -y 
#add swap、zram
apt install curl unzip wget -y && sudo fallocate -l 2G /home/Downloads/swapfile && ls -lh /home/Downloads/swapfile && chmod 600 /home/Downloads/swapfile && mkswap /home/Downloads/swapfile && swapon /home/Downloads/swapfile && swapon --show && free -h 
curl -L https://raw.githubusercontent.com/spiritLHLS/addzram/main/addzram.sh -o addzram.sh && chmod +x addzram.sh && bash addzram.sh
sudo swapoff /home/Downloads/swapfile
grep -q '^/home/Downloads/swapfile' /etc/fstab || echo '/home/Downloads/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo swapon --priority 10 /home/Downloads/swapfile
sudo swapon /home/Downloads/swapfile


echo '* - nofile 999900' | sudo tee -a /etc/security/limits.conf
ulimit -n 999900
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
sysctl -p
sysctl net.ipv4.tcp_available_congestion_control
lsmod | grep bbr
rmmod virtio_balloon
echo 3 > /proc/sys/net/ipv4/tcp_fastopen
echo 'net.ipv4.tcp_fastopen = 3' >> /etc/sysctl.conf
echo f > /sys/class/net/eth0/queues/rx-0/rps_cpus

bash -c 'echo -e "* soft nofile 1048576\n* hard nofile 1048576" >> /etc/security/limits.conf && echo "session required pam_limits.so" >> /etc/pam.d/common-session && echo "fs.file-max = 1048576" >> /etc/sysctl.conf && sysctl -p && SERVICE_NAME=yourapp.service && SERVICE_PATH=/etc/systemd/system/$SERVICE_NAME && echo -e "[Unit]\nDescription=High FD App\nAfter=network.target\n\n[Service]\nExecStart=/usr/bin/env bash -c '\''echo Hello World'\''\nRestart=always\nLimitNOFILE=1048576\n\n[Install]\nWantedBy=multi-user.target" > $SERVICE_PATH && systemctl daemon-reexec && systemctl daemon-reload && systemctl enable --now $SERVICE_NAME'

curl -L https://raw.githubusercontent.com/spiritLHLS/one-click-installation-script/main/install_scripts/dlm.sh -o dlm.sh && chmod +x dlm.sh && bash dlm.sh



curl wget sudo socat htop iftop unzip tar tmux ffmpeg btop ranger ncdu fzf vim nano git


