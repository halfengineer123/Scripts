#!/bin/bash

# Configurable thresholds
CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=80

# Log file location
LOG_FILE="/var/log/system_health.log"

# Get current metrics
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEMORY_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')

# Log and alert function
log_and_alert() {
    local message="$1"
    echo "$(date): $message" | tee -a $LOG_FILE
}

# Check CPU usage
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    log_and_alert "High CPU usage detected: ${CPU_USAGE}%"
fi

# Check Memory usage
if (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l) )); then
    log_and_alert "High Memory usage detected: ${MEMORY_USAGE}%"
fi

# Check Disk usage
if (( $(echo "$DISK_USAGE > $DISK_THRESHOLD" | bc -l) )); then
    log_and_alert "High Disk usage detected: ${DISK_USAGE}%"
fi
