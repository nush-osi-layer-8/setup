#!/bin/bash

echo
echo "Installing some essential stuff"
echo

commands=(
	"apt-get update"
	"echo wireshark-common wireshark-common/install-setuid boolean true | debconf-set-selections -v"
	"apt-get install -y curl vim dhex binutils testdisk libimage-exiftool-perl wireshark"
)

for c in "${commands[@]}"; do
	echo "Running command:"
	echo "	$c"
	echo
	#echo -n "Press [ENTER] to continue: "
	#read -r
	#echo
	bash -c "$c"
	echo
done

echo
echo "Phoning home that you ran this script"
echo 

curl -X POST https://port8091.labs.0x.no/
