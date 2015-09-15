#!/bin/bash
#Well, here we go again eh?
base=/var/mobile/Whited00r
log=/var/mobile/Whited00r/debug.txt
pull_configurator(){
date >> $log
echo "#######################" >> $log
echo "#      Configurator   #" >> $log
echo "#######################" >> $log
preferenceFiles=("/var/mobile/Library/Preferences/com.whited00r.configurator.plist" "/var/mobile/Library/Preferences/com.whited00r.wd7ui.plist" "/var/mobile/Library/Preferences/com.whited00r.wd7lockscreen.plist" "/var/mobile/Library/Preferences/com.whited00r.bruce.plist" "/var/mobile/Library/Preferences/com.darlo770.folders.plist" "/var/mobile/Library/Preferences/com.darlo770.multitasking.plist" "/var/mobile/Library/Preferences/com.whited00r.controlcenter.plist" "/var/mobile/Library/Preferences/com.atm.atm.plist");
for pref in "${preferenceFiles[@]}";
do
prefsName=$(echo "$pref" | sed 's!.*/!!'); 
echo >> $log
echo "###|#|$prefsName|#|###" >> $log
#Loop through the keys from the current preference file we are using
plutil -keys $pref | while read key; do
value=$(plutil -"$key" "$pref")
if [[ "$value" == "0" ]];
  then value="Disabled";
elif [[ "$value" == "1" ]];
  then value="Enabled";
fi
echo "$key : $value" >> $log
done
done
echo >> $log
echo >> $log
}
pull_substrates(){
echo "#######################" >> $log
echo "#      Substrates     #" >> $log
echo "#######################" >> $log
echo >> $log
ls /Library/MobileSubstrate/DynamicLibraries | grep -v .plist | while read substrate; do
value=$(if echo $substrate | grep .dylib >>/dev/null;
	then echo "Enabled";
	else echo "Disabled";
	fi)
echo "-`printf $substrate | sed 's/.dylib//;s/.disabled//;s/\*$//'` = $value" >> $log
done;
echo >> $log
echo >> $log
}
pull_packages(){
echo "#######################" >> $log
echo "#   Cydia Packages    #" >> $log
echo "#######################" >> $log
echo >> $log
dpkg -l >> $log
echo >> $log
echo >> $log
}
if [[ -f $log ]];
then
rm -rf $log;
fi
pull_configurator
pull_substrates
pull_packages