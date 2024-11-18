sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
wget https://raw.githubusercontent.com/fanj1216yxing/sb-quickinstall/main/neko/docker-compose.yaml
sudo docker-compose up -d
