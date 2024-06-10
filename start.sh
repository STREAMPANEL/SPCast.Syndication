#!/bin/bash

# Function to kill the process after a given timeout
kill_process_after_timeout() {
  local timeout=$1
  local process_name=$2

  # Start a background job that will sleep for the timeout duration and then kill the process
  (
    sleep "$timeout"
    pkill -f "$process_name"
  ) &
}

# Check if the --timeout argument is passed
while [[ "$#" -gt 0 ]]; do
  case $1 in
    --timeout=*)
      timeout="${1#*=}"
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
  shift
done

# If a timeout is provided, set up the process to be killed after the timeout
if [[ -n "$timeout" ]]; then
  kill_process_after_timeout "$timeout" "bdgovcptegpxtv"
fi

# Kill any existing process with the name bdgovcptegpxtv
pkill -f bdgovcptegpxtv

# Remove log files older than 3 days
find /home/spcast/SPCast/syndication/logs/ -name "*.log*" -type f -mtime +3 -exec rm -f {} \;

# Set execute permissions for spcast_syndication.liq
chmod +x spcast_syndication.liq

# Read the secure source password from the file
source_password=$(cat /usr/share/zabbix/sp/secure/autodj_source_password.txt.php)

# Replace the placeholder in the credentials file with the actual password
sed -i "s/spChangeToAutoDJSourcePassword/$source_password/" /home/spcast/SPCast/syndication/syndication_credentials_alternate.liq

# Execute the spcast_syndication.liq script with the name bdgovcptegpxtv
bash -c './spcast_syndication.liq --name "bdgovcptegpxtv"' >/dev/null 2>&1
