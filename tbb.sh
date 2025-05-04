#!/bin/bash

# 一键安装 Syncthing 脚本 for Debian/Ubuntu
# 自动安装 + 开机自启 + 远程访问配置 + 设置密码 + 显示设备ID

USERNAME=${SUDO_USER:-$USER}
HOMEDIR=$(eval echo ~$USERNAME)

# 设置登录用户名和密码
WEB_USER="admin"
WEB_PASS="99905230523.aoi"  # <-- 你可以改成自己想要的密码

echo "📦 安装 Syncthing..."
sudo apt update
sudo apt install -y syncthing

echo "🚀 启动一次 Syncthing 生成配置文件..."
sudo -u $USERNAME syncthing -generate "$HOMEDIR/.config/syncthing"

CONFIG="$HOMEDIR/.config/syncthing/config.xml"

echo "🔧 修改配置：允许远程访问，设置用户名密码..."

# 修改 Web UI 地址为 0.0.0.0:8384
sed -i 's|<address>127.0.0.1:8384</address>|<address>0.0.0.0:8384</address>|' "$CONFIG"

# 插入用户和密码
if ! grep -q "<user>" "$CONFIG"; then
  sed -i '/<gui>/a \ \ \ \ <user>'"$WEB_USER"'</user>\n    <password>'"$WEB_PASS"'</password>' "$CONFIG"
fi

# 启用 systemd user 服务
echo "🛠️ 设置 systemd 用户服务开机自启..."
sudo loginctl enable-linger $USERNAME
sudo -u $USERNAME systemctl --user enable syncthing
sudo -u $USERNAME systemctl --user start syncthing

# 等待服务启动
echo "⏳ 等待 Syncthing 启动中..."
sleep 5

# 显示设备 ID
DEVICE_ID=$(sudo -u $USERNAME syncthing --device-id)

echo "✅ Syncthing 安装完成！"
echo "🌐 Web UI 地址：http://<你的服务器IP>:8384"
echo "👤 登录用户名：$WEB_USER"
echo "🔒 登录密码：$WEB_PASS"
echo "🆔 当前设备 ID：$DEVICE_ID"
