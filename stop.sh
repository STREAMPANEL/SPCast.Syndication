#!/bin/bash

# Kill any existing process with the name bdgovcptegpxtv
pkill -f bdgovcptegpxtv

# Remove restart file
rm -f /usr/share/zabbix/sp/secure/.stop_syndication
