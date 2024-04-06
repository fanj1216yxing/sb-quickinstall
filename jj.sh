apt -y update
apt -y install default-jre supervisor
mkdir -p /opt/joal&& cd /opt/joal
wget https://github.com/anthonyraymond/joal/releases/download/2.1.19/joal.tar.gz
tar -xzvf joal.tar.gz

echo "[program:joal]" >> /etc/supervisor/conf.d/joal.conf
echo "priority=1" >> /etc/supervisor/conf.d/joal.conf
echo "directory=/opt/joal" >> /etc/supervisor/conf.d/joal.conf
echo "command=/usr/bin/java -jar jack-of-all-trades-2.1.19.jar --joal-conf="/opt/joal" --spring.main.web-environment=true --server.port=50001 --joal.ui.path.prefix="imlala" --joal.ui.secret-token="lala.im"" >> /etc/supervisor/conf.d/joal.conf
echo "autostart=true" >> /etc/supervisor/conf.d/joal.conf
echo "autorestart=true" >> /etc/supervisor/conf.d/joal.conf
echo "redirect_stderr=true" >> /etc/supervisor/conf.d/joal.conf
echo "stdout_logfile=/var/log/supervisor/joal.log" >> /etc/supervisor/conf.d/joal.conf
supervisorctl update
supervisorctl status joal
