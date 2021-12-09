
#!/bin/sh

DIR=`pwd`

mkdir -p .downloads

cd .downloads

blob_download() {
  set -eu
  local package=$1
  local url=$2
  local f=$3
  if [ ! -f ${DIR}/blobs/${package}/${f} ];then
    curl -L -J ${url} -o ${f}
    bosh add-blob --dir=${DIR} ${f} ${package}/${f}
  fi
}

LOGSTASH_VERSION=7.14.1

if [ ! -f ${DIR}/blobs/logstash/logstash-${LOGSTASH_VERSION}.tar.gz ];then
    curl -L -J -o logstash-${LOGSTASH_VERSION}.tar.gz https://artifacts.elastic.co/downloads/logstash/logstash-${LOGSTASH_VERSION}-linux-x86_64.tar.gz
    bosh add-blob --dir=${DIR} logstash-${LOGSTASH_VERSION}.tar.gz logstash/logstash-${LOGSTASH_VERSION}.tar.gz
fi

blob_download python3.7 https://www.python.org/ftp/python/3.7.12/Python-3.7.12.tgz Python-3.7.12.tgz

cd -
