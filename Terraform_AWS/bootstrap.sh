#!/bin/bash

echo '127.0.0.1 ${self.tags.Name}' | sudo tee -a /etc/hosts
sudo sed -i "s/\^HOSTNAME=.*/HOSTNAME=test1/g" /etc/sysconfig/network