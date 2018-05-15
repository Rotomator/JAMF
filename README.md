# JAMF Uninstall Deep Freeze
Removes Deep Freeze with one policy 

DeepFreezeUnistaller.sh was a practice using LaunchDaemons and can cause boot loops if somthing goes wrong!

SimpleDeepFreezeUninstaller.sh is the practical way to go.

1. Create a policy to run this script, triggered at reoccurring check-in, scoped to a smart group for computers 
with DFXControl.app installed.       

2. After DeepFreeze is removed the computers will check and be removed from the smart group. The policy will no 
longer be exicuted on the computer.

3. Create a policy to update inventory.  Also add or remove any custom policies in the script.  

4. Use your DF username and password!!!   

5. You may want to rebuild your fusion drive if it was disabled for deepfreeze.  FusionRebuild.sh is how I completed this process. 


