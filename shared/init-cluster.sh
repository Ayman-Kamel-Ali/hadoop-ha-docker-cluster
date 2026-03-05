#!/bin/bash

# 1. Install required packages
apt-get update -y
apt-get install -y openjdk-11-jdk ssh rsync wget nano pdsh

# 2. Setup passwordless SSH across all nodes using the shared volume
mkdir -p ~/.ssh

if [ ! -f /shared/id_rsa ]; then
    echo "Generating SSH keys for the cluster..."
    ssh-keygen -t rsa -P '' -f /shared/id_rsa
    cp /shared/id_rsa.pub /shared/authorized_keys
fi

cp /shared/id_rsa ~/.ssh/
cp /shared/id_rsa.pub ~/.ssh/
cp /shared/authorized_keys ~/.ssh/
chmod 600 ~/.ssh/id_rsa
chmod 644 ~/.ssh/authorized_keys

# 3. Start the SSH daemon
service ssh start

echo "Setup complete on $(hostname)"