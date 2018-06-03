#!/bin/bash
#tv status
#tv control
echo "getting tv status."
notify -t "getting tv status." > /dev/null
echo "pow 0" | cec-client RPI -s -d 1
echo "pow 0" | cec-client RPI -s -d 1 | flite
