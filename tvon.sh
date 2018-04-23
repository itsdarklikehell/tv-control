#!/bin/bash
#tv on
echo "switching on tv." | tee >(flite)
notify -t "switching tv on." > /dev/null
echo "on 0" | cec-client RPI -s -d 1
echo "pow 0" | cec-client RPI -s -d 1
