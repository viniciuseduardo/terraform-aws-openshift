#!/bin/bash

export LANG=C
export ANSIBLE_HOST_KEY_CHECKING=False
export ANSIBLE_FORKS=5
export ANSIBLE_PIPELINING=True
export USE_COMMUNITY="${use_community}"

if [ -z $USE_COMMUNITY ]; then
    echo "It's a OCP"
    ansible-playbook -i $HOME/inventory.yaml $HOME/node-repos-playbook.yaml || { echo "Error on register repos" ; exit 1 ; }
else
    echo "It's a OKD"
    ansible all -i $HOME/inventory.yaml -m yum -a 'name=wget,git,net-tools,bind-utils,yum-utils,iptables-services,bridge-utils,bash-completion,kexec-tools,sos,psacct,atomic state=present'
    ansible all -i $HOME/inventory.yaml -m yum -a 'name=docker-1.13.1 state=present'
    ansible all -i $HOME/inventory.yaml -m systemd -a 'name=docker state=started enabled=yes'
fi

rm -Rf $HOME/openshift-ansible
git clone -b release-3.11 https://github.com/viniciuseduardo/openshift-ansible.git
cd $HOME/openshift-ansible

echo $(date) " - Setting up NetworkManager on eth0"
DOMAIN=`domainname -d`
DNSSERVER=`tail -1 /etc/resolv.conf | cut -d ' ' -f 2`

ansible-playbook -i $HOME/inventory.yaml playbooks/openshift-node/network_manager.yml

sleep 10
ansible all -i $HOME/inventory.yaml -m systemd -a 'name=NetworkManager state=restarted'

sleep 10
ansible all -i $HOME/inventory.yaml -o -m command -a 'nmcli con modify eth0 ipv4.dns-search $DOMAIN, ipv4.dns $DNSSERVER'
ansible all -i $HOME/inventory.yaml -m systemd -a 'name=NetworkManager state=restarted'

echo $(date) " - NetworkManager configuration complete"

# sleep 5

# echo $(date) " - Running Prerequisites via Ansible Playbook"
# ansible-playbook -i $HOME/inventory.yaml playbooks/prerequisites.yml || { echo "Error on prerequisites" ; exit 1 ; }
# echo $(date) " - Prerequisites check complete"

# sleep 5

# echo $(date) " - Installing OpenShift Container Platform via Ansible Playbook"
# ansible-playbook -i $HOME/inventory.yaml playbooks/deploy_cluster.yml || { echo "Error on deploying cluster" ; exit 1 ; }
# echo $(date) " - OpenShift Origin Cluster install complete"