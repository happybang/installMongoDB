#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
clear
echo "#############################################################"
echo "# Install mongoDB_3.2.3 for CentOS6.x (32bit/64bit)"
echo "#############################################################"
echo ""

function downloadMongo(){
cd /root
if ［ $（getconf WORD_BIT） = ‘32’ ］ && ［ $（getconf LONG_BIT） = ‘64’ ］ ; then
wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-rhel62-v3.6-latest.tgz
else
wget http://downloads.mongodb.org/linux/mongodb-linux-x86_64-rhel62-v3.6-latest.tgz
fi
}

function rootness(){
if [[ $EUID -ne 0 ]]; then
echo "Error:This script must be run as root!" 1>&2
exit 1
fi
}

function installMongo(){
tar zxvf mongodb-linux*
mv mongodb-linux* mongodb
cd mongodb
mkdir db
mkdir logs
cd bin
touch mongodb.conf
cat > mongodb.conf << EOF
dbpath=/usr/local/mongodb/db
logpath=/usr/local/mongodb/logs/mongodb.log
port=27017
fork=true
nohttpinterface=true
EOF
cd /root
rm -f mongodb-linux*
mv mongodb/ /usr/local/
/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/bin/mongodb.conf
echo "/usr/local/mongodb/bin/mongod --config /usr/local/mongodb/bin/mongodb.conf" >> /etc/rc.d/rc.local
ln -s /usr/local/mongodb/bin/mongo /usr/bin/
}

function runMongo(){
mongo
}

function start(){
rootness
downloadMongo
installMongo
runMongo
}

start



