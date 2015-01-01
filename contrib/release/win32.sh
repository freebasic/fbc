#!/bin/bash
set -e

target="$1"
if [ -z "$target" ]; then
	target=`fbc -print host`
fi

case "$target" in
win32|win64)    fbtarget=$target;;
win32-mingworg) fbtarget=win32;;
*)              echo "usage: ./win32.sh [win32 | win32-mingworg]" && exit 1;;
esac

mkdir -p input
mkdir -p output
rm -rf build
mkdir build
cd build

function download_mingw() {
	../download.sh "../input/MinGW.org/$1" "http://downloads.sourceforge.net/mingw/${1}?download"
}

function get_mingww64_toolchain() {
	bits="$1"
	arch="$2"

	gccversion=4.9.2
	dir=Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/$gccversion/threads-win32/sjlj/
	file=$arch-$gccversion-release-win32-sjlj-rt_v3-rev1.7z

	mkdir -p ../input/MinGW-w64
	../download.sh "../input/MinGW-w64/$file" \
		"http://sourceforge.net/projects/mingw-w64/files/$dir$file/download"

	7z x "../input/MinGW-w64/$file" > /dev/null
}

case "$target" in
win32)
	get_mingww64_toolchain 32 i686
	mv mingw32/* . && rmdir mingw32

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
win64)
	get_mingww64_toolchain 64 x86_64
	mv mingw64/* . && rmdir mingw64
	;;
esac

# Download & extract FB for bootstrapping
bootfb_title=FreeBASIC-1.00.0-$fbtarget
../download.sh ../input/$bootfb_title.zip "https://downloads.sourceforge.net/fbc/${bootfb_title}.zip?download"
unzip -q ../input/$bootfb_title.zip

# fbc sources
../download.sh ../input/fbc-master.zip "https://github.com/freebasic/fbc/archive/master.zip"
unzip -q ../input/fbc-master.zip && mv fbc-master fbc   && echo "prefix := `pwd -W`"     > fbc/config.mk
unzip -q ../input/fbc-master.zip && mv fbc-master fbcsa && echo "ENABLE_STANDALONE := 1" > fbcsa/config.mk

# On 64bit, we have to override the FB makefile's uname check, because MSYS uname reports 32bit still
if [ "$target" = win64 ]; then
	echo "TARGET_ARCH := x86_64" >> fbc/config.mk
	echo "TARGET_ARCH := x86_64" >> fbcsa/config.mk
fi

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
	if [ "$target" = win64 ]; then
		CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32
	else
		CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static
	fi
	make
	case "$target" in
	win32)		cp include/ffi.h include/ffitarget.h ../i686-w64-mingw32/include;;
	win32-mingworg)	cp include/ffi.h include/ffitarget.h ../include;;
	win64)		cp include/ffi.h include/ffitarget.h ../x86_64-w64-mingw32/include;;
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

	mkdir -p fbcsa/bin/$fbtarget
	cp bin/ar.exe			fbcsa/bin/$fbtarget
	cp bin/as.exe			fbcsa/bin/$fbtarget
	cp bin/dlltool.exe		fbcsa/bin/$fbtarget
	cp bin/ld.exe			fbcsa/bin/$fbtarget

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
	cp $bootfb_title/bin/$fbtarget/GoRC.exe		fbcsa/bin/$fbtarget

	cp `gcc -print-file-name=crtbegin.o`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=crtend.o`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=crt2.o`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=dllcrt2.o`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=gcrt2.o`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libgcc.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libgcc_eh.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libmingw32.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libmingwex.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libmoldname.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libsupc++.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libstdc++.a`	fbcsa/lib/$fbtarget
	cp `gcc -print-file-name=libgmon.a`	fbcsa/lib/$fbtarget

	cp "$libffi_build"/.libs/libffi.a	fbcsa/lib/$fbtarget

	# Reduce .exe sizes by dropping debug info
	# (this was at least needed for MinGW.org's gdb, and probably nothing else,
	# but it shouldn't hurt either)
	strip -g fbcsa/bin/$fbtarget/*

	case "$target" in
	win32|win64)
		cd fbc && make bindist DISABLE_DOCS=1 && cd ..
		cd fbcsa && make bindist && cd ..
		cp fbc/contrib/manifest/fbc-$fbtarget.lst		../output
		cp fbcsa/contrib/manifest/FreeBASIC-$fbtarget.lst	../output
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
