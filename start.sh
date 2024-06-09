#!/bin/bash

# Kill the process with the name bdgovcptegpxtv
pkill -f bdgovcptegpxtv

# Remove log files
find /home/spcast/SPCast/syndication/logs/ -name "*.log*" -type f -mtime +3 -exec rm -f {} \;

# Set permissions
chmod +x spcast_syndication.liq

# Replace the value in syndication_credentials_alternate.liq
source_password=$(cat /usr/share/zabbix/sp/secure/autodj_source_password.txt.php)
sed -i "s/spChangeToAutoDJSourcePassword/$source_password/" /home/spcast/SPCast/syndication/syndication_credentials_alternate.liq

# Execute the spcast_syndication.liq with the name bdgovcptegpxtv
bash -c './spcast_syndication.liq --name "bdgovcptegpxtv"' >/dev/null 2>&1
