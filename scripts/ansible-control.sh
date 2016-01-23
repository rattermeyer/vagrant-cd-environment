#!/bin/sh
chown vagrant: /home/vagrant/.ssh/id_rsa
chmod u+rw,go-rwx /home/vagrant/.ssh/id_rsa

mkdir -p /root/.ssh
mv /tmp/id_rsa /root/.ssh
chown root: /root/.ssh/id_rsa
chmod u+rw,go-rwx /root/.ssh/id_rsa

apt-get update
apt-get install -y git vim software-properties-common
apt-add-repository ppa:ansible/ansible
apt-get update
apt-get install -y ansible
apt-get upgrade -y
rm -r /etc/ansible
git clone https://github.com/rattermeyer/ansible-cdenv.git /etc/ansible
cd /etc/ansible 
ansible-playbook -b site.yml
