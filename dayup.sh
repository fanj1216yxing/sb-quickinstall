lsof | grep '(deleted)'
sync
echo 3 > /proc/sys/vm/drop_caches
echo 0 > /proc/sys/vm/drop_caches





rm -rf dayup.sh
