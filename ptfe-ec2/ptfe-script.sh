#!/bin/bash

###Check if jq is installed
which jq  ||  (apt-get update; apt-get install jq -y)


 sleep 100



apt-get update

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common\
    aufs-tools \
    cgroupfs-mount \
    libltdl7 \
    pigz -y




####Install docker
apt install /home/ubuntu/ptfe-ec2/*.deb -y

sleep 100

mkdir /home/ubuntu/ptfe-ec2/replicated
tar xzf /home/ubuntu/ptfe-ec2/replicated.tar.gz -C /home/ubuntu/ptfe-ec2/replicated

####Install replicated
[ -f /etc/replicated.conf ] || cp /home/ubuntu/ptfe-ec2/replicated.conf /etc/replicated.conf
pushd  /home/ubuntu/ptfe-ec2/replicated
bash ./install.sh airgap no-proxy private-address=10.0.1.161