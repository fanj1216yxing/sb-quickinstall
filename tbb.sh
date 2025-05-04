#!/bin/bash

# 自动安装 + system-wide 运行 Syncthing 脚本 for Debian/Ubuntu
# 使用 systemctl start syncthing@用户名 方式，避免 user bus 问题

USERNAME=${SUDO_USER:-$USER}
HOMEDIR=$(eval echo ~$USERNAME)

WEB_USER="admin"
WEB_PASS="99905230523.aoi"  # <-- 修改为你需要的密码

echo "📦 安装 Syncthing..."
sudo apt update
sudo apt install -y syncthing

echo "📁 创建 systemd 服务配置文件..."
cat <<EOF | sudo tee /etc/systemd/system/syncthing@.service >/dev/null
[Unit]
Description=Syncthing - Open Source Continuous File Synchronization for %i
After=network.target

[Service]
User=%i
ExecStart=/usr/bin/syncthing serve --no-browser --logflags=0
Restart=on-failure
SuccessExitStatus=3 4

[Install]
WantedBy=multi-user.target
EOF

echo "🔧 启动 Syncthing 一次生成配置..."
sudo -u $USERNAME syncthing -generate "$HOMEDIR/.config/syncthing"

CONFIG="$HOMEDIR/.config/syncthing/config.xml"

echo "🛠️ 修改配置：允许远程访问，设置用户名密码..."
sed -i 's|<address>127.0.0.1:8384</address>|<address>0.0.0.0:8384</address>|' "$CONFIG"

# 设置 Web UI 登录凭证
if ! grep -q "<user>" "$CONFIG"; then
  sed -i '/<gui>/a \ \ \ \ <user>'"$WEB_USER"'</user>\n    <password>'"$WEB_PASS"'</password>' "$CONFIG"
fi

echo "🚀 启动并启用 system-wide 服务..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable syncthing@$USERNAME
sudo systemctl start syncthing@$USERNAME

echo "⏳ 等待 Syncthing 启动中..."
sleep 5

DEVICE_ID=$(sudo -u $USERNAME syncthing --device-id)

echo "✅ Syncthing 安装完成！"
echo "🌐 Web UI 地址：http://<你的服务器IP>:8384"
echo "👤 登录用户名：$WEB_USER"
echo "🔒 登录密码：$WEB_PASS"
echo "🆔 当前设备 ID：$DEVICE_ID"
