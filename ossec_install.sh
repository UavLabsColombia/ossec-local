#!/bin/bash
#
# @dorancemc - 10-sep-2016
#
# Script para installar ossec
# Validado en : Debian 7+, Ubuntu 16+, Centos 6+
#
#

linux_variant() {
  if [ -f "/etc/debian_version" ]; then
    distro="debian"
  elif [ -f "/etc/redhat-release" ]; then
    distro="redhat"
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
  echo "deb http://ossec.wazuh.com/repos/apt/${distro} ${version} main" > /etc/apt/sources.list.d/ossec.list
  apt-key adv --fetch-keys http://ossec.wazuh.com/repos/apt/conf/ossec-key.gpg.key
  apt-get update
  apt-cache search ossec
  if [ "$install" == "server" ]; then
    apt-get install ossec-hids -y
  else
    apt-get install ossec-hids-agent -y
  fi
}

redhat() {
  if ! command_exists wget ; then
    yum install wget -y
  fi
  wget -q https://www.atomicorp.com/RPM-GPG-KEY.art.txt 1>/dev/null 2>&1
  wget -q https://www.atomicorp.com/RPM-GPG-KEY.atomicorp.txt 1>/dev/null 2>&1
  rpm -import RPM-GPG-KEY.art.txt >/dev/null 2>&1
  rpm -import RPM-GPG-KEY.atomicorp.txt >/dev/null 2>&1
  wget -q http://updates.atomicorp.com/channels/atomic/centos/6/x86_64/RPMS/atomic-release-1.0-21.el6.art.noarch.rpm
  rpm -Uvh atomic-release-1.0-21.el6.art.noarch.rpm
  if [ "$install" == "server" ]; then
    yum install -y ossec-hids-server
  else
    yum install -y ossec-hids-client
  fi  
}

unknown() {
  echo "distro no soportada por este script :( "
}

run_core() {
  linux_variant
  $distro
}

run_core
