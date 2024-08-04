#!/bin/bash

# Install Apache
sudo apt-get update
sudo apt-get install apache2 -y

# Create custom webpage

echo "<html>
      <head>
        <title>Welcome to Sprint 4</title>
      </head>
      <body>
        <h1>Success!  You have provisioned a linux web server</h1>
        <h2>Machine Type: $(uname -m)</h2>
        <h2>Kernel Version: $(uname -r)</h2>
        <h2>OS Version: $(lsb_release -d | cut -f2-)</h2>
        <h2>Host name: $(hostname -f)</h2>
      </body>
      </html>" | sudo tee /var/www/html/index.html
# Restart Apache
sudo systemctl restart apache2
sudo systemctl enable apache2