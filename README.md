# JAMF
Jamf Scripts

1. Create a policy to run this script, triggered at reoccurring check-in, scoped to a smart group for computers with DFXControl.app installed.       

2. After DeepFreeze is removed the computers will check and be removed from the smart group. The policy will no longer be exicuted on the computer.

3. Create a policy to update inventory.  (See line 46 policy -event updateinventory.)  Also add or remove any custom policies in the script.  (See line 43 #Policy to ....) 

4. Use your DF username and password!!!                                                                           

