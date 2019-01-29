#!/bin/bash

echo $(date) " - Installing EPEL"

sudo yum install -y epel-release

echo $(date) " - EPEL successfully installed"

echo $(date) " - Installing Dev Tools"

sudo yum install -y "@Development Tools" python2-pip openssl-devel python-devel gcc libffi-devel

echo $(date) " - Installing Dev Tools"

echo $(date) " - Removing Ansible 2.7"
sudo yum -y remove ansible

echo $(date) " - Installing Ansible 2.6.5"
sudo pip install -I ansible==2.6.5

echo $(date) " - Installing Centos Openshift"

sudo yum -y install centos-release-openshift-origin

echo $(date) " - EPEL successfully installed"

echo $(date) " - Updating SO"

sudo yum -y update

echo $(date) " - SO Updated"

