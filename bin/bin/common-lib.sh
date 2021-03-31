function proceed() {
	echo $1
	select ynq in "Yes" "No" "Quit"; do
		case $ynq in
			Yes ) return 0; break;;
			No ) return -1; break;;
			Quit ) exit;;
		esac
	done
}

function haz_root() {
#Check if run as root
ROOT_UID="0"
if [ "$UID" -ne "$ROOT_UID" ] ; then
    echo "You must be root run this!"
    return -1
fi
return 0
}
