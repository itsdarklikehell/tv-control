#!/bin/bash
#tv source
echo "switching source to RPI."
notify -t "switching tv source to RPI." > /dev/null
echo "as" | cec-client RPI -s -d 1'
echo "pow 0" | cec-client RPI -s -d 1
