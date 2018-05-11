#!/bin/bash
# doylema 2018

########################################################################################################################
#    1. Create a policy to run this script, triggered at reoccurring check-in, scoped to a smart group for             #
#       computers with DFXControl.app installed.                                                                       #
#    2. After DeepFreeze is removed the computers will check and be removed from the smart group. The policy will      #
#       no longer be exicuted on the computer.                                                                         #
#    3. Create a policy to update inventory.  See line 26 policy -event updateinventory                                #                           #
########################################################################################################################

FrozenStatus='/usr/bin/defaults read /Library/Preferences/com.apple.RemoteDesktop Text1'

if [[ -d /Applications/Faronics/DFXControl.app ]]; then
echo "The Folder Exists"

    elif [ "$FrozenStatus" = "Frozen" ]; then
	    echo "I'm freezing"
        # Thaw
        DFXPSWD=" " /Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u " " -p bootThawed
        shutdown -r now 
        
	    else
		    echo "I'm already thawed!"
            DFXPSWD=" " /Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u " " -p uninstall
            jamf policy -event updateinventory
            exit 0
		fi

