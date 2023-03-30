#!/bin/bash
sudo apt update
sudo apt -y install apache2
sudo echo "Testando from $(hostname) $(hostname -i)"  > /var/www/html/index.html