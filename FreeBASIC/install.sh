#!/bin/sh

base="/usr/share"
dest="$base/freebasic"

if [ ! -w $base ]
then
	echo
	echo "You need root priviledges to run this install script!"
	echo
	exit 1
fi

mkdir -p -m 0755 "$dest"/bin
mkdir -p -m 0755 "$dest"/inc
mkdir -p -m 0755 "$dest"/lib

cp lib/linux/* "$dest"/lib
cp -r inc/* "$dest"/inc
cp fbc "$dest"/bin
rm -f /usr/bin/fbc
(cd /usr/bin; ln -s "$dest"/bin/fbc fbc)

echo
echo "==================================================================="
echo "FreeBASIC compiler successfully installed in $dest"
echo "A link to the compiler binary has also been created as /usr/bin/fbc"
echo "==================================================================="
echo

