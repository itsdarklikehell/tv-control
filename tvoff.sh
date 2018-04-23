#!/bin/bash
#tv off
echo "switching off tv."
notify -t "switching tv off." > /dev/null
echo "standby 0" | cec-client RPI -s -d 1
echo "pow 0" | cec-client RPI -s -d 1

