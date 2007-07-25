#!/bin/sh


usage()
{
	cat <<EOF
	
Usage: ./install.sh -i|-u [dest]

-i	Install FreeBASIC in dest/freebasic
-u	Uninstall FreeBASIC from dest/freebasic
dest	Destination directory (defaults to /usr/share)

EOF
	exit 1
}


install()
{
	dest="$INSTALLDIR/freebasic"
	link="/usr/bin"
	
	mkdir -p -m 0755 "$dest"/bin/linux
	mkdir -p -m 0755 "$dest"/inc
	mkdir -p -m 0755 "$dest"/lib/linux

	cp lib/linux/* "$dest"/lib/linux
	cp -r inc/* "$dest"/inc
	cp bin/linux/* "$dest"/bin/linux
	cp fbc "$dest"

	if [ -w $link ]; then
		rm -f "$link"/fbc
		echo "#!/bin/sh">"$link"/fbc
		echo "$dest/fbc -prefix $dest $*">>"$link"/fbc
		chmod a+x "$link"/fbc
		linkmsg="A link to the compiler binary has also been created as $link/fbc"
	else
		linkmsg="It was not possible to install a link to the compiler binary as $link/fbc"
	fi

	echo
	echo "================================================================================"
	echo "FreeBASIC compiler successfully installed in $dest"
	echo $linkmsg
	echo "================================================================================"
	echo
}


uninstall()
{
	dest="$INSTALLDIR/freebasic"
	link="/usr/bin"
	
	rm -fr $dest
	if [ -w $link ]; then
		rm -f "$link"/fbc
	fi

	echo
	echo "================================================================================"
	echo "FreeBASIC compiler successfully uninstalled from $dest"
	echo "================================================================================"
	echo
}



case "$1" in
	"-i")	ACTION="install";;
	"-u")	ACTION="uninstall";;
	*)		usage;;
esac

if [ "$2" != "" ]; then
	INSTALLDIR="$2"
else
	INSTALLDIR="/usr/share"
fi

if [ ! -d $INSTALLDIR ]; then
	echo
	echo "$INSTALLDIR is not a valid directory"
	echo
	exit 1
fi

if [ ! -w $INSTALLDIR ]; then
	echo
	echo "You need root priviledges to access $INSTALLDIR"
	echo
	exit 1
fi


case $ACTION in
	"install")	install;;
	"uninstall")uninstall;;
esac


