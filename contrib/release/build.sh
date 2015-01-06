#!/bin/bash
#
# This script downloads & extracts DJGPP/MinGW.org/MinGW-w64 toolchains,
# FB packages for bootstrapping, fbc sources, etc., then builds normal and
# standalone versions of fbc, and finally creates the complete packages ready to
# be released.
#   - Downloaded archives are cached in the input/ dir
#   - Output packages & manifests are put in the output/ dir
#   - Toolchain source packages are downloaded too
#   - fbc sources are retrieved from Git; you can specify the exact commit to
#     build, the default is "master".
#
# ./build.sh <target> [<fbc-commit>]
#
# <target> can be one of:
#   dos
#       DOS build: must run on Win32. Uses Win32 MSYS, but switches to DJGPP for
#       building FB.
#   linux-x86
#   linux-x86_64
#       native builds on GNU/Linux x86/x64_64 - relying on the host toolchains;
#       no gcc toolchain is downloaded; no standalone version of FB is built.
#   win32
#       32bit MinGW-w64 build: must run on Win32. Uses MSYS.
#   win32-mingworg
#       32bit MinGW.org build: must run on Win32. Uses MSYS.
#   win64
#       64bit MinGW-w64 build: must run on Win64. Uses Win32 MSYS, but overrides
#       the FB makefile's uname check in order to build for 64bit instead of
#       32bit.
#
# Requirements:
#   - MSYS environment on Windows with: bash, wget/curl, zip, unzip, patch, make, findutils
#     (win32/win64 builds need to be able to run ./configure scripts, to build libffi)
#   - 7z (7-zip) in the PATH (win32/win64)
#   - makensis (NSIS) in the PATH (FB-win32 installer)
#   - git in the PATH
#   - internet access for downloading input packages and fbc via git
# 
# Some of the ideas behind this script:
#   - Automating the build process for FB releases => less room for mistakes
#   - Starting from scratch everytime => clean builds
#   - Specifying the exact DJGPP/MinGW packages to use => reproducible builds
#   - Only work locally, e.g. don't touch existing DJGPP/MinGW setups on the host
# 
# TODO:
#   - win32: build NSIS installer + fbdoc CHM
#   - win32/win64: build libcunit too, package the libffi/libcunit builds
#
set -e

target="$1"
case "$target" in
dos|linux-x86|linux-x86_64|win32|win64)
	fbtarget=$target;;
win32-mingworg)
	fbtarget=win32;;
*)
	echo "usage: ./build.sh [dos|linux-x86|linux-x86_64|win32|win32-mingworg|win64 [<commit>]]" && exit 1;;
esac

case "$2" in
"") fbccommit="master";;
*)  fbccommit="$2";;
esac

echo "building FB-$target (uname = `uname`, uname -m = `uname -m`)"
mkdir -p input
mkdir -p output
rm -rf build
mkdir build

echo "updating input/fbc repo"
cd input
if [ ! -d fbc ]; then
	git clone https://github.com/freebasic/fbc.git
fi
cd fbc
git fetch
git fetch --tags
git remote prune origin
git reset --hard origin/master
cd ../..

cd build

function download() {
	filename="$1"
	url="$2"

	if [ -f "$filename" ]; then
		echo "cached      $filename"
	else
		echo "downloading $filename"
		#if ! wget -O "$filename" "$url"; then
		if ! curl -L -o "$filename" "$url"; then
			echo "download failed"
			rm -f "$filename"
			exit 1
		fi
	fi
}

function download_mingw() {
	download "../input/MinGW.org/$1" "http://downloads.sourceforge.net/mingw/${1}?download"
}

function get_mingww64_toolchain() {
	bits="$1"
	arch="$2"

	gccversion=4.9.2
	dir=Toolchains%20targetting%20Win64/Personal%20Builds/mingw-builds/$gccversion/threads-win32/sjlj/
	file=$arch-$gccversion-release-win32-sjlj-rt_v3-rev1.7z

	mkdir -p ../input/MinGW-w64
	download "../input/MinGW-w64/$file" \
		"http://sourceforge.net/projects/mingw-w64/files/$dir$file/download"

	7z x "../input/MinGW-w64/$file" > /dev/null
}

case "$target" in
dos)
	DJGPP_MIRROR="ftp://ftp.fu-berlin.de/pc/languages/djgpp/"

	function download_djgpp() {
		dir="$1"
		package="$2"
		mkdir -p ../input/DJGPP
		download "../input/DJGPP/${package}.zip" "${DJGPP_MIRROR}${dir}${package}.zip"
	}

	# binutils/gcc/gdb (needs updating to new versions)
	download_djgpp beta/v2gnu/ bnu225b
	download_djgpp beta/v2gnu/ gcc492b
	download_djgpp beta/v2gnu/ gpp492b
	download_djgpp beta/v2gnu/ gdb771b

	# rest to complete the DJGPP install (usually no changes needed)
	download_djgpp beta/v2/ djdev204
	download_djgpp beta/v2gnu/ fil41b
	download_djgpp beta/v2gnu/ mak40b
	download_djgpp beta/v2gnu/ shl2011b

	# Sources for stuff that goes into the FB-dos package (needs updating to new versions)
	download_djgpp current/v2gnu/ bnu225s
	download_djgpp beta/v2gnu/ gcc492s
	download_djgpp current/v2gnu/ gdb771s
	download_djgpp beta/v2/ djlsr204

	unzip -q ../input/DJGPP/djdev204.zip
	unzip -q ../input/DJGPP/shl2011b.zip
	unzip -q ../input/DJGPP/fil41b.zip
	unzip -q ../input/DJGPP/mak40b.zip
	unzip -q ../input/DJGPP/gdb771b.zip
	unzip -q ../input/DJGPP/bnu225b.zip
	unzip -q ../input/DJGPP/gcc492b.zip
	unzip -q ../input/DJGPP/gpp492b.zip
	;;
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
	download ../input/dx80_mgw.zip http://alleg.sourceforge.net/files/dx80_mgw.zip
	unzip ../input/dx80_mgw.zip include/ddraw.h include/dinput.h

	# Work around http://sourceforge.net/p/mingw/bugs/2039/
	patch -p0 < ../mingworg-fix-wcharh.patch
	;;
win64)
	get_mingww64_toolchain 64 x86_64
	mv mingw64/* . && rmdir mingw64
	;;
esac

bootfb_title=FreeBASIC-1.00.0-$fbtarget

case $fbtarget in
linux*)
	# Download & extract FB for bootstrapping
	bootfb_package=$bootfb_title.tar.xz
	download ../input/$bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
	tar xf ../input/$bootfb_package

	# fbc sources
	cp -R ../input/fbc .
	cd fbc && git reset --hard "$fbccommit" && cd ..

	mkdir tempinstall
	;;
*)
	# Download & extract FB for bootstrapping
	bootfb_package=$bootfb_title.zip
	download ../input/$bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
	unzip -q ../input/$bootfb_package

	# fbc sources
	cp -R ../input/fbc fbc
	cp -R ../input/fbc fbcsa
	cd fbc   && git reset --hard "$fbccommit" && cd ..
	cd fbcsa && git reset --hard "$fbccommit" && cd ..
	echo "prefix := `pwd -W`"     > fbc/config.mk
	echo "ENABLE_STANDALONE := 1" > fbcsa/config.mk

	# On 64bit, we have to override the FB makefile's uname check, because MSYS uname reports 32bit still
	if [ $fbtarget = win64 ]; then
		echo "TARGET_ARCH := x86_64" >> fbc/config.mk
		echo "TARGET_ARCH := x86_64" >> fbcsa/config.mk
	fi
	;;
esac

case $fbtarget in
win32|win64)
	# libffi sources
	libffi_title=libffi-3.2.1
	libffi_package="${libffi_title}.tar.gz"
	download "../input/$libffi_package" "ftp://sourceware.org/pub/libffi/$libffi_package"
	echo "extracting $libffi_package"
	tar xf "../input/$libffi_package"
	;;
esac

function dosbuild() {
	dospath=`pwd -W`

	cat <<EOF > open-djgpp.bat
set DJGPP=$dospath/djgpp.env
set PATH=$dospath/bin;%PATH%
cmd
EOF

	cat <<EOF > build.bat
@echo off

set DJGPP=$dospath/djgpp.env
set PATH=$dospath/bin

echo build PATH = %PATH%
echo.

echo uname:
uname
if ERRORLEVEL 1 exit /b
echo.

echo make --version:
make --version
if ERRORLEVEL 1 exit /b
echo.

echo gcc --version:
gcc --version
if ERRORLEVEL 1 exit /b
echo.

echo gcc -print-file-name=libgcc.a:
gcc -print-file-name=libgcc.a
if ERRORLEVEL 1 exit /b
echo.

echo bootstrapping normal fbc:
cd fbc
make FBC=../FreeBASIC-1.00.0-dos/fbc.exe
if ERRORLEVEL 1 exit /b
make install
if ERRORLEVEL 1 exit /b
cd ..

echo rebuilding normal fbc:
cd fbc
make clean-compiler
if ERRORLEVEL 1 exit /b
make
if ERRORLEVEL 1 exit /b
make install
if ERRORLEVEL 1 exit /b
cd ..

echo building standalone fbc:
cd fbcsa
make
if ERRORLEVEL 1 exit /b
cd ..
EOF

	cmd /c build.bat

	echo
	echo "copying binutils/libs/etc."
	echo

	mkdir -p fbcsa/bin/dos
	cp bin/ar.exe bin/as.exe bin/gdb.exe bin/gprof.exe bin/ld.exe fbcsa/bin/dos/
	cp lib/crt0.o lib/gcrt0.o lib/libdbg.a lib/libemu.a lib/libm.a fbcsa/lib/dos/
	cp lib/libstdcxx.a fbcsa/lib/dos/libstdcx.a
	cp lib/libsupcxx.a fbcsa/lib/dos/libsupcx.a
	cp lib/gcc/djgpp/4.92/libgcc.a fbcsa/lib/dos/

	cd fbc
	make bindist TARGET_OS=dos DISABLE_DOCS=1
	cd ..
	cd fbcsa
	make bindist TARGET_OS=dos
	cd ..

	mv fbc/*.zip fbcsa/*.zip                  ../output
	mv fbc/contrib/manifest/fbc-dos.lst       ../output
	mv fbc/contrib/manifest/FreeBASIC-dos.lst ../output
}

function linuxbuild() {
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

function windowsbuild() {
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

	cd fbcsa && make mingw-libs && cd ..
	cd fbcsa/lib/win32 && make && cd ../../..

	case "$target" in
	win32)
		# Take MinGW.org's gdb, because the gdb from the MinGW-w64 toolchain has much more
		# dependencies (e.g. Python for scripting purposes) which we probably don't want/need.
		# (this should probably be reconsidered someday)
		cp mingworg-gdb/bin/gdb.exe			fbcsa/bin/win32
		cp mingworg-gdb/bin/libgcc_s_dw2-1.dll		fbcsa/bin/win32
		cp mingworg-gdb/bin/zlib1.dll			fbcsa/bin/win32
		;;
	win32-mingworg)
		cp bin/gdb.exe			fbcsa/bin/win32
		cp bin/libgcc_s_dw2-1.dll	fbcsa/bin/win32
		cp bin/zlib1.dll		fbcsa/bin/win32
		;;
	esac

	# TODO: GoRC.exe should really be taken from its homepage
	# <http://www.godevtool.com/>, but it was offline today
	cp $bootfb_title/bin/$fbtarget/GoRC.exe		fbcsa/bin/$fbtarget

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

case $fbtarget in
dos)         dosbuild;;
linux*)      linuxbuild   | tee log.txt 2>&1;;
win32|win64) windowsbuild | tee log.txt 2>&1;;
esac
