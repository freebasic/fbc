#!/bin/sh


usage()
{
	cat <<EOF
	
Usage: 
./install.sh -i
./install.sh -u [dest]

-i	Install FreeBASIC at the compiler configured prefix
-u	Uninstall FreeBASIC from the compiler configured prefix, unless dest is 
specified, then PREFIX=dest.

Installation creates PREFIX/lib/freebasic and PREFIX/include/freebasic, where 
library and header files are copied to, respectively. 

If necessary, PREFIX/bin will be created. A copy (not a symlink) of fbc will 
be placed at PREFIX/bin

The man page is copied to PREFIX/share/man/man1. 

Uninstallation removes these directories, and their contents, in addition 
to the man file and fbc.

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
	cp -ru inc/* "$INSTALLDIR"/include/freebasic/ && \
	gzip -c docs/fbc.1 > "$INSTALLDIR"/share/man/man1/fbc.1.gz && \
	cp fbc "$INSTALLDIR"/bin/ && \
	chmod a+x "$INSTALLDIR"/bin/fbc && \
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

INSTALLDIR=`./fbc -version | grep prefix | cut -c24- -`
if [ "$2" != "" ]; then
	if [ "$ACTION" = "install" ]; then
		echo "WARNING: The path is assumed from ./fbc, setting installation path to ["$2"] is being ignored..."
	else
		INSTALLDIR="$2"
	fi
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


