#!/bin/bash

# install python libs from requirements
pip3 install -r /code/requirements-mini-server.txt

# Copy cron file
crontab -u root /code/cron-mini-server.txt

# Start Cron 
cron -f

# link cron.log to STDOUT
# ln -s /proc/$(cat /var/run/crond.pid)/fd/1 /var/log/cron.log
