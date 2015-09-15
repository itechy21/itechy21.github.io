echo "Removing items..."
./remove.sh
echo "Done" 
sleep 2
echo "build debs on iPod!!!"
sleep 4
echo "Now building package listing..."
dpkg-scanpackages -m . /dev/null >./Packages
bzip2 -k -f ./Packages
echo "Done. Repo is up to date :)"
echo "[̲̅$̲̅(̲̅100̲̅)̲̅$̲̅]"