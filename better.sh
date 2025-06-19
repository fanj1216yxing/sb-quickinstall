apt install lsof
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
sudo iptables -P INPUT ACCEPT && sudo iptables -P FORWARD ACCEPT && sudo iptables -P OUTPUT ACCEPT && sudo iptables -F && curl -fsSL https://get.docker.com | sh && sudo systemctl enable docker && sudo systemctl start docker

bash -c 'echo -e "* soft nofile 1048576\n* hard nofile 1048576" >> /etc/security/limits.conf && echo "session required pam_limits.so" >> /etc/pam.d/common-session && echo "fs.file-max = 1048576" >> /etc/sysctl.conf && sysctl -p && SERVICE_NAME=yourapp.service && SERVICE_PATH=/etc/systemd/system/$SERVICE_NAME && echo -e "[Unit]\nDescription=High FD App\nAfter=network.target\n\n[Service]\nExecStart=/usr/bin/env bash -c '\''echo Hello World'\''\nRestart=always\nLimitNOFILE=1048576\n\n[Install]\nWantedBy=multi-user.target" > $SERVICE_PATH && systemctl daemon-reexec && systemctl daemon-reload && systemctl enable --now $SERVICE_NAME'

curl -L https://raw.githubusercontent.com/spiritLHLS/one-click-installation-script/main/install_scripts/dlm.sh -o dlm.sh && chmod +x dlm.sh && bash dlm.sh
curl -L https://raw.githubusercontent.com/spiritLHLS/addzram/main/addzram.sh -o addzram.sh && chmod +x addzram.sh && bash addzram.sh

echo 'vm.swappiness=90' >> /etc/sysctl.conf
sysctl -p

echo -e "${gl_lv}切换到网站搭建优化模式...${gl_bai}"

	echo -e "${gl_lv}优化文件描述符...${gl_bai}"
	ulimit -n 65535

	echo -e "${gl_lv}优化虚拟内存...${gl_bai}"
	sysctl -w vm.swappiness=10 2>/dev/null
	sysctl -w vm.dirty_ratio=20 2>/dev/null
	sysctl -w vm.dirty_background_ratio=10 2>/dev/null
	sysctl -w vm.overcommit_memory=1 2>/dev/null
	sysctl -w vm.min_free_kbytes=65536 2>/dev/null

	echo -e "${gl_lv}优化网络设置...${gl_bai}"
	sysctl -w net.core.rmem_max=16777216 2>/dev/null
	sysctl -w net.core.wmem_max=16777216 2>/dev/null
	sysctl -w net.core.netdev_max_backlog=5000 2>/dev/null
	sysctl -w net.core.somaxconn=4096 2>/dev/null
	sysctl -w net.ipv4.tcp_rmem='4096 87380 16777216' 2>/dev/null
	sysctl -w net.ipv4.tcp_wmem='4096 65536 16777216' 2>/dev/null
	sysctl -w net.ipv4.tcp_congestion_control=bbr 2>/dev/null
	sysctl -w net.ipv4.tcp_max_syn_backlog=8192 2>/dev/null
	sysctl -w net.ipv4.tcp_tw_reuse=1 2>/dev/null
	sysctl -w net.ipv4.ip_local_port_range='1024 65535' 2>/dev/null

	echo -e "${gl_lv}优化缓存管理...${gl_bai}"
	sysctl -w vm.vfs_cache_pressure=50 2>/dev/null

	echo -e "${gl_lv}优化CPU设置...${gl_bai}"
	sysctl -w kernel.sched_autogroup_enabled=0 2>/dev/null

	echo -e "${gl_lv}其他优化...${gl_bai}"
	# 禁用透明大页面，减少延迟
	echo never > /sys/kernel/mm/transparent_hugepage/enabled
	# 禁用 NUMA balancing
	sysctl -w kernel.numa_balancing=0 2>/dev/null

 docker run -d --restart=always --name="portainer" -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock 6053537/portainer-ce


