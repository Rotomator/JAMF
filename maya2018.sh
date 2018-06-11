#!/bin/bash

#2018 MAYA STANDALONE REGISTR

#LOGIN USER TO REGISTER
/usr/bin/osascript <<EOF
tell application "System Events"
keystroke "USERNAME"
keystroke tab
delay 0.5
keystroke "PASSWORD"
delay 0.5
keystroke return
keystroke return
end tell
EOF

#SCRIPT TO SERIALIZE PRODUCT
/Users/Shared/Install\ Maya\ 2018.app/Contents/MacOS/setup --noui --force --serial_number=<YOUR SERIAL> --product_key=<KEY> --license_type=kStandalone
/Users/Shared/Install\ Maya\ 2018.app/Contents/Resources/adlmreg -i S <KEY> <KEY> 2018.0.0.F <YOUR SERIAL> /Library/Application\ Support/Autodesk/Adlm/PIT/2018/MayaConfig.pit
mkdir /Library/Application\ Support/Autodesk/CLM/LGS/<KEY>_2018.0.0.F
touch /Library/Application\ Support/Autodesk/CLM/LGS/<KEY>_2018.0.0.F/LGS.data
chmod 777 /Library/Application\ Support/Autodesk/CLM/LGS/<KEY>_2018.0.0.F/LGS.data
echo "_STANDALONE" >> /Library/Application\ Support/Autodesk/CLM/LGS/<KEY>_2018.0.0.F/LGS.data

reboot
