apt -y update
apt install curl
y
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
mkdir -p /home/joals&& cd /home/joals
docker run -d -p 3105:3105 -v /home/joals:/data --name="joal" anthonyraymond/joal:2.1.36 --joal-conf="/data" --spring.main.web-environment=true --server.port="3105" --joal.ui.path.prefix="imlala" --joal.ui.secret-token="lala.im"

echo "[program:joal]" >> /etc/supervisor/conf.d/joal.conf
echo "priority=1" >> /etc/supervisor/conf.d/joal.conf
echo "directory=/opt/joal" >> /etc/supervisor/conf.d/joal.conf
echo "command=/usr/bin/java -jar jack-of-all-trades-2.1.36.jar --joal-conf="/opt/joal" --spring.main.web-environment=true --server.port=50001 --joal.ui.path.prefix="imlala" --joal.ui.secret-token="lala.im"" >> /etc/supervisor/conf.d/joal.conf
echo "autostart=true" >> /etc/supervisor/conf.d/joal.conf
echo "autorestart=true" >> /etc/supervisor/conf.d/joal.conf
echo "redirect_stderr=true" >> /etc/supervisor/conf.d/joal.conf
echo "stdout_logfile=/var/log/supervisor/joal.log" >> /etc/supervisor/conf.d/joal.conf
