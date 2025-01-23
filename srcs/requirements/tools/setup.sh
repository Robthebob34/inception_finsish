#!/bin/bash

# Create data directories
sudo mkdir -p /home/rheck/data/wordpress
sudo mkdir -p /home/rheck/data/mariadb

# Set permissions
sudo chmod 777 /home/rheck/data/wordpress
sudo chmod 777 /home/rheck/data/mariadb

# Set ownership
sudo chown -R www-data:www-data /home/rheck/data/wordpress
