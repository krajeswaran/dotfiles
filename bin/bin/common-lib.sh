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
