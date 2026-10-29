#!/bin/bash
# System report script - author: Serik Assylzhan

STUDENT_NAME="Serik Assylzhan"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_FILE="$SCRIPT_DIR/../logs/Serik_Assylzhan_system_report.log"

{
  echo "=============================================="
  echo "Student full name : $STUDENT_NAME"
  echo "Date and time     : $(date '+%Y-%m-%d %H:%M:%S')"
  echo "Current user      : $(whoami)"
  echo "--- Operating system and kernel ---"
  if [ "$(uname -s)" = "Darwin" ]; then
    echo "OS     : $(sw_vers -productName) $(sw_vers -productVersion)"
    echo "Kernel : $(uname -sr)"
    echo "--- CPU ---"
    echo "Model  : $(sysctl -n machdep.cpu.brand_string)"
    echo "Cores  : $(sysctl -n hw.ncpu)"
    echo "--- Memory ---"
    echo "Total RAM : $(( $(sysctl -n hw.memsize) / 1024 / 1024 / 1024 )) GB"
    vm_stat | head -5
  else
    echo "OS     : $(grep PRETTY_NAME /etc/os-release | cut -d= -f2 | tr -d '"')"
    echo "Kernel : $(uname -r)"
    echo "--- CPU ---"
    echo "Model  : $(lscpu | grep 'Model name' | sed 's/Model name:[ ]*//')"
    echo "Cores  : $(nproc)"
    echo "--- Memory ---"
    free -h
  fi
  echo "--- Disk usage ---"
  df -h
  echo "--- Available space on / ---"
  df -h / | awk 'NR==2 {print "Available: " $4 " (used " $5 ")"}'
  echo ""
} | tee -a "$LOG_FILE"
