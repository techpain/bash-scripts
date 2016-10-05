#!/bin/bash
# 2016-07-15  --techpain

# This script shows a sorted count of IP addresses in a log file.
# Usage: ./top-IP-list.sh <number of log lines> /ath/to/logfile

EXPECTED_ARGS=2

if [ $# -ne $EXPECTED_ARGS ]
then
  echo
  echo "Usage:   $0 <number of log lines> /path/to/logfile"
  echo
  echo "Example: $0 15000 /var/log/maillog"
  echo
  exit $E_BADARGS
fi


EXTERNAL=$(tail -n$1 $2 | grep -oe '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | grep -ve '10\.[0-9]*\.[0-9]*\.[0-9]*' | sort | uniq -c | sort -nr | head -n20)
INTERNAL=$(tail -n$1 $2 | grep -oe '10\.[0-9]*\.[0-9]*\.[0-9]*' | sort | uniq -c | sort -nr | head -n20)
SINCETIME=$(tail -n$1 $2 | head -n1 | awk '{print $1,$2,$3}')

echo
echo "Searching last $1 lines in $2, starts at $SINCETIME"
echo
echo "Internal IP addresses"
echo "$INTERNAL"
echo
echo "External IP addresses"
echo "$EXTERNAL"
echo
