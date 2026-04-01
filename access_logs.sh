#!/bin/bash

# Path to log file in Windows Documents folder (Git Bash/WSL format)
LOG_FILE="/c/Users/HP/Desktop/DevOpsPracticals/Practicals/nginx.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "Log file not found at $LOG_FILE"
  exit 1
fi

echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo ""
echo "Top 5 most requested paths:"
awk -F\" '{print $2}' "$LOG_FILE" | awk '{print $2}' | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo ""
echo "Top 5 response status codes:"
awk '{print $9}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{print $2 " - " $1 " requests"}'

echo ""
echo "Top 5 user agents:"
awk -F\" '{print $6}' "$LOG_FILE" | sort | uniq -c | sort -nr | head -5 | awk '{
    count=$1
    $1=""
    sub(/^ /, "")
    print $0 " - " count " requests"
}'