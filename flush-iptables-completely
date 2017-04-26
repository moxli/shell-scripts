#!/bin/bash
x="/sbin/iptables"
# Exit if /sbin/iptables does not exist
[ ! -x "$x" ] && { echo "$0: \"${x}\" command not found."; exit 1; }
# Reset the default chain policy back to ACCEPT
$x -P INPUT ACCEPT
$x -P FORWARD ACCEPT
$x -P OUTPUT ACCEPT
# Flush all chains and delete all custom chains
$x -F
$x -X
# Flush all nat settings
$x -t nat -F
$x -t nat -X
# Flush all mangle (packet alertion) settings
$x -t mangle -F
$x -t mangle -X
# Flush all raw settings
$x iptables -t raw -F
$x -t raw -X
