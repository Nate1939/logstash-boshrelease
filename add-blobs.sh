
#!/bin/sh

DIR=`pwd`

mkdir -p .downloads

cd .downloads



if [ ! -f ${DIR}/blobs/java/openjdk-1.8.0_172.tar.gz ];then
    curl -L -O -J https://download.run.pivotal.io/openjdk-jdk/trusty/x86_64/openjdk-1.8.0_172.tar.gz
    bosh add-blob --dir=${DIR} openjdk-1.8.0_172.tar.gz java/openjdk-1.8.0_172.tar.gz
fi

LOGSTASH_VERSION=6.4.0

if [ ! -f ${DIR}/blobs/logstash/logstash-${LOGSTASH_VERSION}.tar.gz ];then
    curl -L -O -J https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}.tar.gz
    bosh add-blob --dir=${DIR} logstash-${LOGSTASH_VERSION}.tar.gz logstash/logstash-${LOGSTASH_VERSION}.tar.gz
fi

cd -
