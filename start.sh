#!/bin/bash

# Initialize the timeout variable (default is empty)
TIMEOUT=""

# Check if a timeout value was provided
while [[ "$#" -gt 0 ]]; do
    case $1 in
    --timeout=*) TIMEOUT="${1#*=}" ;;
    *) echo "Unknown option: $1" ;;
    esac
    shift
done

# Kill the process with the name bdgovcptegpxtv
pkill -f bdgovcptegpxtv

# Remove log files
rm -f /home/spcast/SPCast/syndication/logs/*.log*

# Set permissions
chmod +x spcast_syndication.liq

# Replace the value in syndication_credentials_alternate.liq
source_password=$(cat /usr/share/zabbix/sp/secure/autodj_source_password.txt.php)
sed -i "s/spChangeToAutoDJSourcePassword/$source_password/" /home/spcast/SPCast/syndication/syndication_credentials_alternate.liq

# Execute the spcast_syndication.liq with the name bdgovcptegpxtv
if [[ -n "$TIMEOUT" ]]; then
    timeout "$TIMEOUT" bash -c './spcast_syndication.liq --name "bdgovcptegpxtv"' >/dev/null 2>&1
else
    bash -c './spcast_syndication.liq --name "bdgovcptegpxtv"' >/dev/null 2>&1
fi
