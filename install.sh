#!/bin/sh
set -e

case "$1" in
"-i" | "-u")
	;;
*)
	echo "usage:"
	echo "./install.sh -i [prefix]    install FB into prefix directory"
	echo "./install.sh -u [prefix]    uninstall FB from prefix directory"
	echo "(default prefix: /usr/local)"
	exit 1
	;;
esac

if [ -n "$2" ]; then
  prefix="$2"
else
  prefix=/usr/local
fi

if [ ! -d "$prefix" ]; then
	echo "$prefix is not a valid directory"
	exit 1
fi

if [ ! -w "$prefix" ]; then
	echo "You need root priviledges to access $prefix"
	exit 1
fi

case "$1" in
"-i")
	dir="`dirname '$0'`/"
	if [ "$dir" = "/" ]; then
		dir=""
	fi

	mkdir -p -m 0755 "$prefix/bin"
	install "${dir}"bin/fbc "$prefix/bin"

	mkdir -p -m 0755 "$prefix/include/freebasic"
	cp -R "${dir}"include/freebasic/* "$prefix/include/freebasic"

	mkdir -p -m 0755 "$prefix/lib/freebasic"
	cp -R "${dir}"lib/freebasic/* "$prefix/lib/freebasic"

	mkdir -p -m 0755 "$prefix/man/man1"
	gzip -c "${dir}"doc/fbc.1 > "$prefix/man/man1/fbc.1.gz"

	echo "FreeBASIC compiler successfully installed in $prefix"
	;;
"-u")
	rm -f "$prefix/bin/fbc"
	rm -rf "$prefix/include/freebasic"
	rm -rf "$prefix/lib/freebasic"
	rm -f "$prefix/man/man1/fbc.1.gz"
	echo "FreeBASIC compiler successfully uninstalled from $prefix"
	;;
esac
