#!/bin/bash


RED="\033[31m"      # Red color (for warnings)
GREEN="\033[32m"    # Green color (for success)
BLUE="\033[34m"     # Blue color (for headers)
YELLOW="\033[33m"   # Yellow color (for general info)
RESET="\033[0m"     # Reset color to default

LOG_FILE="/home/mazen/scripts/task1/monitoring_script/test.log"

{
  echo -e "--------------- Disk Usage Check ---------------"
  
  
  THRESHOLD=80
  
 
  df -h --output=pcent,target | tail -n +2 | awk -v threshold=$THRESHOLD -v logfile="$LOG_FILE" '
  {
    usage = $1; gsub("%", "", usage); 
    mount_point = $2;


{
  echo -e "--------------- CPU Usage Check ---------------"
  
 
  cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8"% used"}')
  echo "CPU Usage: $cpu_usage"
  echo ""
} >> $LOG_FILE


{
  echo -e "--------------- Memory Details ---------------"
  
  mem_total=$(free -m | awk '/Mem:/ {print $2}')
  mem_used=$(free -m | awk '/Mem:/ {print $3}')
  mem_free=$(free -m | awk '/Mem:/ {print $4}')
  mem_percentage=$(awk "BEGIN {printf \"%.2f\", ($mem_used / $mem_total) * 100}")

  printf "Total Memory: %10d MB\n" "$mem_total"
  printf "Used Memory:  %10d MB (%.2f%%)\n" "$mem_used" "$mem_percentage"
  printf "Free Memory:  %10d MB\n" "$mem_free"
  echo ""
} >> $LOG_FILE


{
  echo -e "--------------- Running Processes Check ---------------"
  
  echo "Top 5 Processes by CPU Usage:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | awk '{printf "PID: %-6s PPID: %-6s CMD: %-20s MEM: %-5s CPU: %-5s\n", $1, $2, $3, $4, $5}'
  echo ""


  echo "Top 5 Processes by Memory Usage:"
  ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 6 | awk '{printf "PID: %-6s PPID: %-6s CMD: %-20s MEM: %-5s CPU: %-5s\n", $1, $2, $3, $4, $5}'
  echo ""
} >> $LOG_FILE
