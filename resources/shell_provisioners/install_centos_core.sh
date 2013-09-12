#!/bin/bash -x

URL=https://github.com/cfengine/core.git

# If /var/cfengine exists, do nothing, assume it's installed already
test -d /var/cfengine && exit 0

cd /var/tmp

# half of these packages are not on various CentOS versions
yum install -y git autoconf libtool libtokyocabinet-dev tokyocabinet-devel libpcre3-dev pcre-devel libxml2-dev libxml2-devel libvirt-dev libvirt-devel libacl1-dev libacl-devel bison flex make libssl-dev openssl-devel

if [ -z "$1" ]; then
    git clone -q --depth 1 $URL ./core
else
    git clone -q --depth 1 --branch $1 $URL ./core
fi

cd ./core
./autogen.sh
make
make install
