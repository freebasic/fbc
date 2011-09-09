#!/bin/sh
#
# To turn this into an installer, append a .tar.gz, e.g.:
#    cp template.sh freebasic.run
#    cat freebasic.tar.gz >> freebasic.run
# It will be extracted directly into the specified prefix,
# so it should have the appropriate directory structure bin/, lib/ etc.

prefix=/usr/local
first_line_of_data=48

install_fb() {
	echo "Extracting $0 into '$prefix'..."
	# Get the content of this file starting with the first line of data,
	# then unpack it as .tar.gz into $prefix.
	tail -n +$first_line_of_data "$0" | tar xzf - -C "$prefix" && \
	echo " ok"
}

remove_fb() {
	echo "Removing FreeBASIC from '$prefix'..."
	rm -rf "$prefix/lib/freebasic" && \
	rm -rf "$prefix/include/freebasic" && \
	rm -f "$prefix/bin/fbc" && \
	rm -rf "$prefix/share/freebasic" && \
	rm -f "$prefix/man/man1/fbc.1.gz" && \
	echo " ok"
}

# Command line option check
case "$1" in
"install")
	install_fb
	;;
"remove")
	remove_fb
	;;
*)
	echo "This is the self-extracting FreeBASIC for Linux installer."
	echo "This FreeBASIC compiler is configured to be installed into '$prefix'."
	echo "Available commands:"
	echo "  install    Extract FreeBASIC into '$prefix'"
	echo "  remove     Remove FreeBASIC from '$prefix'"
	;;
esac

exit
