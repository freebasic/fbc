#!/bin/bash
set -e

target="$1"
case "$1" in
win32|win32-mingworg)
	;;
"")
	target="win32"
	;;
*)
	echo "usage: ./win32.sh [win32 | win32-mingworg]"
	exit 1
	;;
esac

echo "removing existing $target/ dir"
rm -rf "$target"
mkdir "$target"
mkdir -p output

echo "working inside $target/ dir"
cd "$target"

function download_mingw() {
	../download.sh "../input/MinGW.org/$1" "http://downloads.sourceforge.net/mingw/${1}?download"
}

case "$target" in
win32)
	# Download & extract MinGW-w64 toolchain
	mingww64_package=i686-4.9.2-release-win32-sjlj-rt_v3-rev1.7z
	mkdir -p ../input/MinGW-w64
	../download.sh "../input/MinGW-w64/$mingww64_package" "http://sourceforge.net/projects/mingw-w64/files/Toolchains%20targetting%20Win32/Personal%20Builds/mingw-builds/4.9.2/threads-win32/sjlj/${mingww64_package}/download"
	echo "extracting $mingww64_package"
	7z x "../input/MinGW-w64/$mingww64_package" > /dev/null

	# Move things out of the mingw32/ dir that is used in the 32bit MinGW-w64 toolchain package
	mv mingw32/* .
	rmdir mingw32

	mkdir -p ../input/MinGW.org
	mkdir mingworg-gdb
	function get_mingworggdb() {
		download_mingw "$1" 
		tar xf "../input/MinGW.org/$1" -C mingworg-gdb
	}
	get_mingworggdb gcc-core-4.8.1-4-mingw32-dll.tar.lzma
	get_mingworggdb gdb-7.6.1-1-mingw32-bin.tar.lzma
	get_mingworggdb zlib-1.2.8-1-mingw32-dll.tar.lzma
	;;
win32-mingworg)
	# Download & extract MinGW.org toolchain
	mkdir -p ../input/MinGW.org
	function download_extract_mingw() {
		download_mingw "$1" 
		tar xf "../input/MinGW.org/$1"
	}
	download_extract_mingw mingwrt-4.0.3-1-mingw32-dev.tar.lzma
	download_extract_mingw w32api-4.0.3-1-mingw32-dev.tar.lzma
	download_extract_mingw binutils-2.24-1-mingw32-bin.tar.xz
	download_extract_mingw gcc-c++-4.8.1-4-mingw32-bin.tar.lzma
	download_extract_mingw gcc-c++-4.8.1-4-mingw32-dev.tar.lzma
	download_extract_mingw gcc-core-4.8.1-4-mingw32-bin.tar.lzma
	download_extract_mingw gcc-core-4.8.1-4-mingw32-dev.tar.lzma
	download_extract_mingw gcc-core-4.8.1-4-mingw32-dll.tar.lzma
	download_extract_mingw gdb-7.6.1-1-mingw32-bin.tar.lzma
	download_extract_mingw zlib-1.2.8-1-mingw32-dll.tar.lzma
	download_extract_mingw gmp-5.1.2-1-mingw32-dll.tar.lzma
	download_extract_mingw mpc-1.0.1-2-mingw32-dll.tar.lzma
	download_extract_mingw mpfr-3.1.2-2-mingw32-dll.tar.lzma

	# Add ddraw.h and dinput.h for FB's gfxlib2
	../download.sh ../input/dx80_mgw.zip http://alleg.sourceforge.net/files/dx80_mgw.zip
	unzip ../input/dx80_mgw.zip include/ddraw.h include/dinput.h

	# Work around http://sourceforge.net/p/mingw/bugs/2039/
	patch -p0 < ../mingworg-fix-wcharh.patch
	;;
esac

# Download & extract FB for bootstrapping
bootfb_title=FreeBASIC-1.00.0-win32
../download.sh ../input/$bootfb_title.zip "https://downloads.sourceforge.net/fbc/${bootfb_title}.zip?download"
unzip -q ../input/$bootfb_title.zip

# fbc sources
../download.sh ../input/fbc-master.zip "https://github.com/freebasic/fbc/archive/master.zip"
unzip -q ../input/fbc-master.zip && mv fbc-master fbc   && echo "prefix := `pwd -W`"     > fbc/config.mk
unzip -q ../input/fbc-master.zip && mv fbc-master fbcsa && echo "ENABLE_STANDALONE := 1" > fbcsa/config.mk

# libffi sources
libffi_title=libffi-3.2.1
libffi_package="${libffi_title}.tar.gz"
../download.sh "../input/$libffi_package" "ftp://sourceware.org/pub/libffi/$libffi_package"
echo "extracting $libffi_package"
tar xf "../input/$libffi_package"

# Function for the build process, so we can easily capture the log output
function build() {
	# Add our toolchain's bin/ to the PATH, so hopefully we'll only use
	# its gcc and not one from the host
	origPATH="$PATH"
	export PATH="$PWD/bin:$PATH"

	echo
	echo "build PATH = $PATH"
	echo "uname = `uname`"
	echo "which gcc = `which gcc`"
	echo "gcc -print-file-name=libgcc.a = `gcc -print-file-name=libgcc.a`"
	echo

	echo
	echo "building libffi"
	echo
	libffi_build="${libffi_title}-build"
	mkdir "$libffi_build"
	cd "$libffi_build"
	CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static
	make
	case "$target" in
	win32)
		cp include/ffi.h include/ffitarget.h ../i686-w64-mingw32/include;;
	win32-mingworg)
		cp include/ffi.h include/ffitarget.h ../include;;
	esac
	cd ..

	cd fbc
	echo
	echo "bootstrapping normal fbc"
	echo
	make FBC=../$bootfb_title/fbc.exe
	make install
	echo
	echo "rebuilding normal fbc"
	echo
	make clean-compiler
	make
	cd ..

	cd fbcsa
	echo
	echo "building standalone fbc"
	echo
	make
	cd ..

	echo
	echo "copying binutils/libs/etc."
	echo

	mkdir -p fbcsa/bin/win32
	cp bin/ar.exe			fbcsa/bin/win32
	cp bin/as.exe			fbcsa/bin/win32
	cp bin/dlltool.exe		fbcsa/bin/win32
	cp bin/ld.exe			fbcsa/bin/win32

	case "$target" in
	win32)
		cd fbcsa/lib/win32 && make && cd ../../..
		# Take MinGW.org's gdb, because the gdb from the MinGW-w64 toolchain has much more
		# dependencies (e.g. Python for scripting purposes) which we probably don't want/need.
		# (this should probably be reconsidered someday)
		cp mingworg-gdb/bin/gdb.exe			fbcsa/bin/win32
		cp mingworg-gdb/bin/libgcc_s_dw2-1.dll		fbcsa/bin/win32
		cp mingworg-gdb/bin/zlib1.dll			fbcsa/bin/win32
		;;
	win32-mingworg)
		cd fbcsa/lib/win32 && make MINGWORG=1 && cd ../../..
		cp bin/gdb.exe			fbcsa/bin/win32
		cp bin/libgcc_s_dw2-1.dll	fbcsa/bin/win32
		cp bin/zlib1.dll		fbcsa/bin/win32
		;;
	esac

	# TODO: GoRC.exe should really be taken from its homepage
	# <http://www.godevtool.com/>, but it was offline today
	cp $bootfb_title/bin/win32/GoRC.exe		fbcsa/bin/win32

	cp `gcc -print-file-name=crtbegin.o`	fbcsa/lib/win32
	cp `gcc -print-file-name=crtend.o`	fbcsa/lib/win32
	cp `gcc -print-file-name=crt2.o`	fbcsa/lib/win32
	cp `gcc -print-file-name=dllcrt2.o`	fbcsa/lib/win32
	cp `gcc -print-file-name=gcrt2.o`	fbcsa/lib/win32
	cp `gcc -print-file-name=libgcc.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libgcc_eh.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libmingw32.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libmingwex.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libmoldname.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libsupc++.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libstdc++.a`	fbcsa/lib/win32
	cp `gcc -print-file-name=libgmon.a`	fbcsa/lib/win32

	cp "$libffi_build"/.libs/libffi.a	fbcsa/lib/win32

	# Reduce .exe sizes by dropping debug info
	# (this was at least needed for MinGW.org's gdb, and probably nothing else,
	# but it shouldn't hurt either)
	strip -g fbcsa/bin/win32/*

	case "$target" in
	win32)
		cd fbc && make bindist DISABLE_DOCS=1 && cd ..
		cd fbcsa && make bindist && cd ..
		cp fbc/contrib/manifest/fbc-win32.lst		../output
		cp fbcsa/contrib/manifest/FreeBASIC-win32.lst	../output
		;;
	win32-mingworg)
		cd fbc && make bindist DISABLE_DOCS=1 FBPACKSUFFIX=-mingworg && cd ..
		cd fbcsa && make bindist FBPACKSUFFIX=-mingworg && cd ..
		cp fbc/contrib/manifest/fbc-win32-mingworg.lst		../output
		cp fbcsa/contrib/manifest/FreeBASIC-win32-mingworg.lst	../output
		;;
	esac

	cp fbc/*.zip fbc/*.7z		../output
	cp fbcsa/*.zip fbcsa/*.7z	../output

	export PATH="$origPATH"
	cd ..
}

build | tee log.txt 2>&1
