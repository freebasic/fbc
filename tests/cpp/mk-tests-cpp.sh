#!/bin/bash

function chk() {
	rm -f $1-cpp.o
	make -f $1.bmk CFLAGS="-m64 -O0"
	fbc -g -exx $1-fbc.bas $1-cpp.o -x $1-fbc.exe $2
	./$1-fbc.exe
}

function do_clean() {
	rm -f $1-cpp.o
	rm -f $1-fbc.exe
	rm -f $1-fbc.o
}

function do_clean_all() {
	do_clean "mangle"
	do_clean "call"
	do_clean "call2"
	do_clean "this"
	do_clean "class"
	do_clean "bop"
	do_clean "fbcall"
	do_clean "derived"
}

function chk_all() {
#	chk "mangle" "-gen gas"
	chk "mangle" "-gen gcc"

#	chk "call" "-gen gas"
	chk "call" "-gen gcc"

#	chk "call2" "-gen gas"
	chk "call2" "-gen gcc"

#	chk "this" "-gen gas"
	chk "this" "-gen gcc"

#	chk "class" "-gen gas"
	chk "class" "-gen gcc"

#	chk "bop" "-gen gas"
	chk "bop" "-gen gcc"

#	chk "fbcall" "-gen gas"
	chk "fbcall" "-gen gcc"

#	chk "derived" "-gen gas"
	chk "derived" "-gen gcc"
}

if [ -z "$1" ]; then
	chk_all
	exit 0
fi

case $1 in
mangle|call|call2|this|class|bop|fbcall|derived)
	chk "$1" "-gen gcc"
	;;
clean)
	do_clean_all
	;;
*)
	echo "expected clean|mangle|call|call2|this|class|bop|fbcall|derived"
	;;
esac

