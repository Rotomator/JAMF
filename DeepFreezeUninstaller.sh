#!/bin/bash
# doylema 2018

########################################################################################################################
#    1. Create a policy to run this script, triggered at reoccurring check-in, scoped to a smart group for             #
#       computers with DFXControl.app installed.                                                                       #
#    2. After DeepFreeze is removed the computers will check and be removed from the smart group. The policy will      #
#       no longer be exicuted on the computer.                                                                         #
#    3. Create a policy to update inventory.  See line 46 policy -event updateinventory                                #
#       Also add or remove any custom policies in the script.  See line 43 #Policy to ....                             #
#    4. Use your DF username and password!!!                                                             #
########################################################################################################################

# Set computer to boot thawed
DFXPSWD="Your DF Password" /Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u "Your DF Username" -p bootThawed

#Create Script

/bin/mkdir /usr/local/scripts

cat <<"EOF" > "/usr/local/scripts/deepfreeze.sh"
#!/bin/bash

# Checks to see if Deep Freeze is installed and removes it!

if [[ -d /Applications/Faronics/DFXControl.app ]]; then
echo "The Folder Exists"
#Uninstall Deepfreeze
DFXPSWD="Your DF Password" /Library/Application\ Support/Faronics/Deep\ Freeze/deepfreeze -u "Your DF Username" -p uninstall
shutdown -r now 

else 

# If its not installed it will remove the Script and LaunchDaemon 
echo "The Folder Does Not Exist"

# Remove LaunchDaemon
/bin/rm -f /Library/LaunchDaemons/com.scripts.deepfreezex.plist

# Remove Script
/bin/rm -f /usr/local/scripts/deepfreeze.sh
lauchctl remove com.scripts.deepfreezex

#Policy to fix my management accounts
/usr/local/bin/jamf policy -event managementAccount

#Policy to update inventory
/usr/local/bin/jamf policy -event updateinventory

exit 0

fi

## Sleep for 30s to give the mac a chance to connect to network
sleep 30

## Update Device Inventory
/usr/local/jamf/bin/jamf recon

exit 0

EOF

/usr/sbin/chown root:admin /usr/local/scripts/deepfreeze.sh
/bin/chmod 755 /usr/local/scripts/deepfreeze.sh

# Install the LaunchDaemon

 cat << EOF > /Library/LaunchDaemons/com.scripts.deepfreezex.plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Label</key>
	<string>com.scripts.deepfreezex</string>
	<key>ProgramArguments</key>
	<array>
		<string>/bin/bash</string>
		<string>-c</string>
		<string>/usr/local/scripts/deepfreeze.sh</string>
	</array>
	<key>RunAtLoad</key>
	<true/>
</dict>
</plist>
EOF

##Set the permission on the file just made.
/usr/sbin/chown root:wheel /Library/LaunchDaemons/com.scripts.deepfreezex.plist
/bin/chmod 644 /Library/LaunchDaemons/com.scripts.deepfreezex.plist

shutdown -r now 
exit 0