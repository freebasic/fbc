#!/bin/sh


usage()
{
	cat <<EOF
	
Usage: ./install.sh -i|-u [dest]

-i	Install FreeBASIC in dest/
-u	Uninstall FreeBASIC from dest/
dest	Destination directory (defaults to /usr)

Installation creates dest/lib/freebasic and /dest/include/freebasic, where 
library and header files are copied to, respectively. 
The man page is copied to /usr/share/man/man1. 

Uninstallation removes these directories, and their contents, in addition 
to the man file.

EOF
	exit 1
}


i_success_msg()
{
	echo
	echo "================================================================================"
	echo "***** FreeBASIC compiler successfully installed in $INSTALLDIR *****"
	echo "================================================================================"
	echo
}
install()
{
	mkdir -p -m 0755 "$INSTALLDIR"/lib/freebasic && \
	mkdir -p -m 0755 "$INSTALLDIR"/include/freebasic && \
	mkdir -p -m 0755 "$INSTALLDIR"/bin && \
	mkdir -p -m 0755 "$INSTALLDIR"/share/man/man1 && \
	cp lib/linux/* "$INSTALLDIR"/lib/freebasic/ && \
	cp -r inc/* "$INSTALLDIR"/include/freebasic/ && \
	gzip -c docs/fbc.1 > "$INSTALLDIR"/share/man/man1/fbc.1.gz && \
	cp fbc "$INSTALLDIR"/bin/ && \
	i_success_msg
}

u_success_msg()
{
	echo
	echo "================================================================================"
	echo "***** FreeBASIC compiler successfully uninstalled from $INSTALLDIR *****"
	echo "================================================================================"
	echo
}
uninstall()
{
	rm -fr "$INSTALLDIR"/lib/freebasic && \
	rm -fr "$INSTALLDIR"/include/freebasic && \
	rm -f "$INSTALLDIR"/bin/fbc && \
	rm -f "$INSTALLDIR"/share/man/man1/fbc.1.gz && \
	u_success_msg
}

case "$1" in
	"-i")	ACTION="install";;
	"-u")	ACTION="uninstall";;
	*)		usage;;
esac

if [ "$2" != "" ]; then
	INSTALLDIR="$2"
else
	INSTALLDIR="/usr"
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
	"uninstall")	uninstall;;
esac


