#!/bin/sh
apt-get update && apt-get install -yq gnupg2 wget lsb-release

#wget -O - https://files.freeswitch.org/repo/deb/debian-release/fsstretch-archive-keyring.asc | apt-key add -
 
#echo "deb http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" > /etc/apt/sources.list.d/freeswitch.list
#echo "deb-src http://files.freeswitch.org/repo/deb/debian-release/ `lsb_release -sc` main" >> /etc/apt/sources.list.d/freeswitch.list
 

#cd depends

#apt-get install ./*.deb

#cd ..

apt-get update -y

./bootstrap.sh -j

./configure --enable-core-pgsql-support

make

make install

make all cd-sounds-install cd-moh-install

ln -s /usr/local/agnoconnect/bin/freeswitch /usr/bin/agnoconnect

ln -s /usr/local/agnoconnect/bin/fs_cli /usr/bin/as_cli

sudo groupadd agnoconnect

sudo adduser --quiet --system --home /usr/local/agnoconnect --gecos "agnoconnect open source softswitch" --ingroup agnoconnect agnoconnect --disabled-password

chown -R agnoconnect:agnoconnect /usr/local/agnoconnect/

chmod -R ug=rwX,o= /usr/local/agnoconnect/

chmod -R u=rwx,g=rx /usr/local/agnoconnect/bin/*

cp /usr/src/agnoconnect/debian/agnoconnect-systemd.agnoconnect.service /etc/systemd/system/agnoconnect.service

systemctl daemon-reload

systemctl enable agnoconnect

systemctl start agnoconnect

systemctl status agnoconnect


exit 0
