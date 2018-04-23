#!/bin/bash

####	CONFIG	####
CONFIG(){
VOICE="flite" #use flite, festival or espeak
CEC_CLIENT="cec-client RPI -s -d 1"
}
####	CONFIG END	####

TVON(){
whiptail --title "Tv On" --msgbox "Switching tv on." 8 78
echo "Switching tv on." | tee >($VOICE)
echo "on 0" | $CEC_CLIENT | tee >($VOICE)
TVSTAT
}

TVOFF(){
whiptail --title "Tv Off" --msgbox "Switching tv off." 8 78
echo "Switching tv off." | tee >($VOICE)
echo "standby 0" | $CEC_CLIENT | tee >($VOICE)
TVSTAT
}

TVSTAT(){
echo "Getting tv status." | tee >($VOICE)
echo "pow 0" | $CEC_CLIENT | tee >($VOICE)
#whiptail --title "Tv Status" --msgbox "$TVSTAT"  8 78
read -rsp $'Press any key to continue...\n' -n 1 key
}

TVSRCE(){
echo "Switching tv source" | tee >($VOICE)
echo "as" | $CEC_CLIENT | tee >($VOICE)
read -rsp $'Press any key to continue...\n' -n 1 key
}

EXIT(){
break
whiptail --title "Exit" --msgbox "Thank you for using this script." 8 78
echo "Thank you for using this script."
}

####	EXEC	####
CONFIG
while true; do
CHOICE=$(whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
	"On" "Switch tv on." \
	"Off" "Switch tv off." \
	"Status" "Check tv status." \
	"Source" "Switch tv to RPI source." \
	"Exit" "Exit back to CLI." 3>&2 2>&1 1>&3
)

case $CHOICE in
On)
TVON
;;
Off)
TVOFF
;;
Status)
TVSTAT
;;
Source)
TVSRCE
;;
Exit)
break
;;
*)
echo "That is not a valid choice."
;;
esac
done
#if [ $CHOICE = "On" ];
#then
#TVON
#fi
#if [ $CHOICE = "Off" ];
#then
#TVOFF
#fi
#if [ $CHOICE = "Status" ];
#then
#TVSTAT
#fi
#if [ $CHOICE = "Source" ];
#then
#TVSRCE
#fi
#if [ $CHOICE = "Exit" ];
#then
#EXIT
#fi
#done
####	EXEC END	####
