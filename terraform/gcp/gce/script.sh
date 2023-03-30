#!/bin/bash
apt update
apt -y install apache2
echo "Testando from <p>$(hostname)</p><p> $(hostname -i)</p>"  > /var/www/html/index.html