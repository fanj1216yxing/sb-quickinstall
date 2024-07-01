apt -y update
apt install curl
y
apt install wget
y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
mkdir -p /home/joals&& cd /home/joals
docker run -d -p 3105:3105 -v /home/joals:/data --name="joal" --joal-conf="/data" --spring.main.web-environment=true --server.port="3105" --joal.ui.path.prefix="imlala" --joal.ui.secret-token="lala.im" --restart unless-stopped anthonyraymond/joal:2.1.36
wget -P /home/joals https://raw.githubusercontent.com/fanj1216yxing/sb-quickinstall/main/config.jspn
docker restart joal
