#! /bin/sh

export PATH=/bin:/usr/bin:/sbin:/usr/sbin

cd $(dirname $0)
git fetch origin master
git reset --hard origin/master

python ../killswitch.py killswitch.yml &

# Clear some persisted remains.
sed -i '/192.168/d' /etc/hosts

# Prepare ephemeral space.
cp -r /home/ubuntu/buildslave /mnt/buildslave
chown -R ubuntu:ubuntu /mnt/buildslave

su - ubuntu -c "cd /mnt/buildslave && buildslave start"
