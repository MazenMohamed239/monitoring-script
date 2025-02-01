#System Monitoring Script

This is a bash script designed to monitor system resources and log the results to a file. It checks various aspects of your system's health, including:

Disk usage
CPU usage
Memory usage
Running processes (top 5 by CPU and memory usage)
The script outputs the results to a log file, and it also sends email notifications when certain thresholds are exceeded (specifically for disk usage).

Features
Disk Usage Monitoring: Checks the disk usage for each mounted filesystem and compares it to a predefined threshold. If usage exceeds the threshold (80% by default), it sends an email notification.
CPU Usage Monitoring: Retrieves the current CPU usage.
Memory Usage Monitoring: Shows total, used, and free memory, along with the percentage of memory used.
Running Processes Monitoring: Displays the top 5 processes by CPU and memory usage.
Log File: Appends the results to a log file and includes timestamps for each new report.
Prerequisites
Linux or Unix-based system
mutt installed for email notifications (you need to configure it with an SMTP server)
Bash shell (default on most Linux/Unix systems)
Installation
Clone or download this repository to your local system.

Ensure the mutt command is configured to send emails. If it’s not configured, follow this guide to set it up.

Set the correct path for the LOG_FILE variable in the script (currently set to /home/ali/scripts/task1/monitor_system_script/test.log).

Make the script executable:

bash
Copy
chmod +x monitor_system.sh
Usage
Run the script manually:

bash
Copy
./monitor_system.sh
You can set up a cron job to run the script at a regular interval (e.g., every hour):

bash
Copy
crontab -e
Add the following line to run the script every hour:

bash
Copy
0 * * * * /path/to/monitor_system.sh
Configuration
Disk Usage Threshold: The disk usage threshold is currently set to 80%. You can change it by modifying the THRESHOLD variable in the script.

Log File Location: The results are logged to /home/ali/scripts/task1/monitor_system_script/test.log. You can change the path by modifying the LOG_FILE variable in the script.

Email Notifications: Modify the email address in the following line to send notifications to a different address:

bash
Copy
system("echo \"Warning: Disk usage for " mount_point " is at " usage "%. Please take action.\" | mutt -s \"Disk Usage Alert\" mmazen.m23@gmail.com")
