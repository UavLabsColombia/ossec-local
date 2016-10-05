#!/bin/bash
#
# @dorancemc - 10-sep-2016
#
# Script para installar ossec
# Validado en : Debian 7+, Ubuntu 16+, Centos 6+, SuSE 13+
#
#

linux_variant() {
  if [ -f "/etc/debian_version" ]; then
    distro="debian"
  elif [ -f "/etc/redhat-release" ]; then
    distro="redhat"
  elif [ -f "/etc/SuSE-release" ]; then
    distro="suse"
  else
    distro="unknown"
  fi
}

command_exists () {
    type "$1" &> /dev/null ;
}

debian() {
  if ! command_exists lsb_release ; then
    apt-get install -y lsb-release
  fi
  distro=$(lsb_release -s -i | tr '[:upper:]' '[:lower:]')
  version=$(lsb_release -s -c )
  echo "deb http://ossec.wazuh.com/repos/apt/${distro} ${version} main" > /etc/apt/sources.list.d/ossec.list &&
  apt-key adv --fetch-keys http://ossec.wazuh.com/repos/apt/conf/ossec-key.gpg.key &&
  apt-get update &&
  apt-cache search ossec &&
  if [ "$install" = "server" ]; then
    apt-get install ossec-hids -y
  else
    apt-get install ossec-hids-agent -y
  fi
}

redhat() {
  if ! command_exists wget ; then
    yum install wget -y
  fi
  wget -q https://www.atomicorp.com/RPM-GPG-KEY.art.txt 1>/dev/null 2>&1 &&
  wget -q https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt 1>/dev/null 2>&1 &&
  rpm -import RPM-GPG-KEY.art.txt >/dev/null 2>&1 &&
  rpm -import RPM-GPG-KEY.atomicorp.txt >/dev/null 2>&1 &&
  wget -q http://updates.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-21.el6.art.noarch.rpm &&
  rpm -Uvh atomic-release-1.0-21.el6.art.noarch.rpm &&
  if [ "$install" == "server" ]; then
    yum install -y ossec-hids-server
  else
    yum install -y ossec-hids-client
  fi  
}

suse (){
  if ! command_exists wget ; then
    zypper --non-interactive install wget 
  fi
  zypper --non-interactive install gcc &&
  mkdir -p /tmp/ossec && cd /tmp/ossec &&
  wget https://github.com/ossec/ossec-hids/archive/v2.8.3.tar.gz &&
  tar -zxvf v2.8.3 &&
  cd ossec-hids-2.8.3/src/ &&
  if [ "$install" == "server" ]; then
    make setlocal && make all && make local
  else
    make setagent && make all && make agent
  fi 
  cp init/ossec-hids-suse.init /etc/init.d/ossec-hids
  chmod 755 /etc/init.d/ossec-hids
  chkconfig --add ossec-hids
}

unknown() {
  echo "distro no soportada por este script :( "
}

run_core() {
  linux_variant
  $distro
}

run_core
