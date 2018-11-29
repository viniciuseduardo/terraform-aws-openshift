#!/bin/bash

# Install dev tools.
echo $(date) " - Installing Dev Tools"

yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel

echo $(date) " - Removing Ansible 2.7"
yum -y remove ansible

echo $(date) " - Installing Ansible 2.6.5"
sudo pip install -I ansible==2.6.5

echo $(date) " - Installing EPEL"

sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

echo $(date) " - EPEL successfully installed"

echo $(date) " - Installing Centos Openshift"

sudo yum -y install centos-release-openshift-origin

echo $(date) " - EPEL successfully installed"

echo $(date) " - Updating SO"

sudo yum -y update

echo $(date) " - SO Updated"

