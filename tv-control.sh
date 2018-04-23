#!/bin/bash

####	CONFIG	####
CONFIG(){
VOICE="flite" #use flite, festival or espeak
}
####	CONFIG END	####

TVON(){
echo "Switching tv on" | tee >($VOICE)
echo "on 0" | cec-client RPI -s -d 1
TVSTAT
}

TVOFF(){
echo "Switching tv off" | tee >($VOICE)
echo "standby 0" | cec-client RPI -s -d 1
TVSTAT
}

TVSTAT(){
echo "Getting tv status" | tee >($VOICE)
echo "pow 0" | cec-cient RPI -s -d 1
}

TVSRCE(){
echo "Switching tv source" | tee >($VOICE)
echo "as" | cec-client RPI -s -d 1
}

EXIT(){
echo "Thank you fot using this script."
}

####	EXEC	####
CONFIG

CHOICE=$(whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
	"On" "Switch tv on." \
	"Off" "Switch tv off." \
	"Status" "Check tv status." \
	"Source" "Switch tv to RPI source." \
	"Exit" "Exit back to CLI." 3>&2 2>&1 1>&3
)
if [ $CHOICE = "On" ];
then
TVON
fi
if [ $CHOICE = "Off" ];
then
TVOFF
fi
if [ $CHOICE = "Status" ];
then
TVSTAT
fi
if [ $CHOICE = "Source" ];
then
TVSRCE
fi
if [ $CHOICE = "Exit" ];
then
EXIT
fi
####	EXEC END	####
