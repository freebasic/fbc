#!/bin/bash
set -e

fbtarget="$1"
case "$1" in
linux-x86|linux-x86_64) ;;
"") fbtarget=`fbc -print host`;;
*)  echo "usage: ./linux.sh [linux-x86 | linux-x86_64]" && exit 1;;
esac

case "$2" in
"") fbccommit="master";;
*)  fbccommit="$2";;
esac

mkdir -p input
mkdir -p output
./update-fbc-src.sh
rm -rf build
mkdir build
cd build

# Download & extract FB for bootstrapping
bootfb_title=FreeBASIC-1.00.0-$fbtarget
bootfb_package=$bootfb_title.tar.xz
../download.sh ../input/$bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
tar xf ../input/$bootfb_package

# fbc sources
echo "preparing fbc sources for build"
cp -R ../input/fbc .
cd fbc && git reset --hard "$fbccommit" && cd ..

mkdir tempinstall

function build() {
	echo
	echo "uname = `uname`"
	echo "gcc -print-file-name=libgcc.a = `gcc -print-file-name=libgcc.a`"
	echo

	cd fbc
	echo
	echo "bootstrapping normal fbc"
	echo
	make FBC=../$bootfb_title/bin/fbc
	make install prefix=../tempinstall
	echo
	echo "rebuilding normal fbc"
	echo
	make clean-compiler
	make FBC=../tempinstall/bin/fbc
	cd ..

	cd fbc && make bindist && cd ..
	cp fbc/contrib/manifest/FreeBASIC-$fbtarget.lst		../output
	cp fbc/*.tar.*		../output

	cd ..
}

build | tee log.txt 2>&1
