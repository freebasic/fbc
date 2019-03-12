#!/bin/bash
#
# This script downloads & extracts DJGPP/MinGW.org/MinGW-w64 toolchains,
# FB packages for bootstrapping, fbc sources, etc., then builds normal and
# standalone versions of fbc, and finally creates the complete packages ready to
# be released.
#   - Downloaded archives are cached in the input/ dir
#   - Output packages & manifests are put in the output/ dir
#   - Toolchain source packages are downloaded too
#   - fbc sources are retrieved from Git; you have to specify the exact commit
#     to build (or a tag/branch name).
#
# The standalone fbc is built in the same directory as the normal fbc, by just
# rebuilding src/compiler/obj/$fbtarget/fbc.o (that's all that's affected by
# ENABLE_STANDALONE, except for the directory layout). This way we avoid
# unnecessary full rebuilds.
#
# ./build.sh <target> <fbc-commit-id> [--offline] [--repo url] [--remote name]
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
# <fbc-commit-id>
#   can be:
#       - a SHA-1 hash to refer to a specific commit
#       - a branch or tag name in origin remote
#       - a remote branch or tag name, must specify "remote-name/branch".
#
# --offline
#   when given, build.sh will stop with exit code 1 if the file is not already in
#   in the download cache.
#
# --repo url
#   specify an additional repo url to fetch in to the local repo other than the 
#   official https://github.com/freebasic/fbc.git repo.
#
# --remote name
#   specifies the remote name to add and use when referring to the other repo url.
#   remote name will default to 'other' if the --repo option was given.
#   remote name will default to 'origin' if the --repo option was not given.
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
#   - win32: fbdoc CHM
#   - package libffi
#
set -e

usage() {
	echo "usage: ./build.sh dos|linux-x86|linux-x86_64|win32|win32-mingworg|win64 <fbc commit id> [--offline] [--repo url] [--remote name]"
	exit 1
}

# parse command line arguments
while [[ $# -gt 0 ]] 
do
arg="$1"
case $arg in
--offline)
	offline=Y
	shift
	;;
--repo)
	repo_url="$2"
	shift; shift
	;;
--remote)
	remote_name="$2"
	shift; shift
	;;
dos|linux-x86|linux-x86_64|win32|win64)
	target="$1"
	fbtarget=$target
	shift
	;;
win32-mingworg)
	target="$1"
	fbtarget=win32
	shift
	;;
*)
	fbccommit="$1"
	shift
	;;	
esac
done

# need a target and a commit id
if [ -z "$target" -o -z "$fbccommit" ]; then
	usage
fi

# default values if none given
offline=${offline:-N}

# if we have an alternate repo url, then set a default value for the remote name
# otherwise we are only using the official repo, so set the remote name to origin
if [ ! -z "$repo_url" ]; then
	remote_name=${remote_name:-other}
else
	remote_name=${remote_name:-origin}
fi

echo "building FB-$target (uname = `uname`, uname -m = `uname -m`)"
echo "from repository: https://github.com/freebasic/fbc.git"
if [ ! -z "$repo_url" ]; then
	echo "from repository: $repo_url"
fi
mkdir -p input
mkdir -p output
rm -rf build
mkdir build

echo "updating input/fbc repo"
cd input

# origin/master must be the official repo, always get it first
if [ ! -d fbc ]; then
	git clone "https://github.com/freebasic/fbc.git" fbc
fi

cd fbc

git fetch origin
git fetch --tags origin
git remote prune origin
git reset --hard origin/master

# if given an alternate repo url, then make sure the
# remote name refers to the alternate repo url
if [ ! -z "$repo_url" ]; then
	if git remote | grep -Fxq "$remote_name"; then
		git remote remove "$remote_name"
	fi
	git remote add "$remote_name" "$repo_url"
	git fetch "$remote_name"
	git fetch --tags "$remote_name"
	git remote prune "$remote_name"
	git reset --hard "$fbccommit"
fi

cd ../..

cd build

buildinfo=../output/buildinfo-$target.txt
echo "fbc $fbccommit $target, build based on:" > $buildinfo
echo >> $buildinfo

copyfile() {
	srcfile="$1"
	dstfile="$2"
	
	if [ -f "$dstfile" ]; then
		echo "cached      $dstfile"
	else
		if [ -f "$srcfile" ]; then
			echo "copying $srcfile to $dstfile"
			cp -p "$srcfile" "$dstfile"
		else
			echo "$srcfile not found, stopping"
			exit 1
		fi
	fi
}

download() {
	filename="$1"
	url="$2"

	if [ -f "../input/$filename" ]; then
		echo "cached      $filename"
	else
		if [ $offline = "Y" ]; then
			echo "not cached  $filename"
			echo "in offline mode, stopping"
			exit 1
		else
			echo "downloading $filename"
			#if ! wget -O "../input/$filename" "$url"; then
			if ! curl -L -o "../input/$filename" "$url"; then
				echo "download failed"
				rm -f "../input/$filename"
				exit 1
			fi	
		fi
	fi

	echo "$filename <$url>" >> $buildinfo
}

download_mingw() {
	download "MinGW.org/$1" "http://downloads.sourceforge.net/mingw/${1}?download"
}

get_mingww64_toolchain() {
	bits="$1"
	arch="$2"

	gccversion=5.2.0
	mingwbuildsrev=rev0
	dir=Toolchains%20targetting%20Win$bits/Personal%20Builds/mingw-builds/$gccversion/threads-win32/sjlj/
	file=$arch-$gccversion-release-win32-sjlj-rt_v4-$mingwbuildsrev.7z

	mkdir -p ../input/MinGW-w64
	download "MinGW-w64/$file" "http://sourceforge.net/projects/mingw-w64/files/$dir$file/download"

	srcfile=src-$gccversion-release-rt_v4-$mingwbuildsrev.tar.7z
	download "MinGW-w64/$srcfile" "http://sourceforge.net/projects/mingw-w64/files/Toolchain%20sources/Personal%20Builds/mingw-builds/$gccversion/$srcfile/download"

	7z x "../input/MinGW-w64/$file" > /dev/null
}

case "$target" in
dos)
	DJGPP_MIRROR="ftp://ftp.fu-berlin.de/pc/languages/djgpp/"

	download_djgpp() {
		dir="$1"
		package="$2"
		mkdir -p ../input/DJGPP
		download "DJGPP/${package}.zip" "${DJGPP_MIRROR}${dir}${package}.zip"
	}

   	djver=205
	gccver=710
	djgppgccversiondir=7
	bnuver=229
	gdbver=771
	djpkg=current

	# binutils/gcc/gdb (needs updating to new versions)
	download_djgpp ${djpkg}/v2gnu/ bnu${bnuver}b
	download_djgpp ${djpkg}/v2gnu/ gcc${gccver}b
	download_djgpp ${djpkg}/v2gnu/ gpp${gccver}b
	download_djgpp ${djpkg}/v2gnu/ gdb${gdbver}b

	# rest to complete the DJGPP install (usually no changes needed)
	download_djgpp ${djpkg}/v2/ djdev${djver}

	download_djgpp ${djpkg}/v2gnu/ fil41br2
	download_djgpp ${djpkg}/v2gnu/ mak421b
	download_djgpp ${djpkg}/v2gnu/ shl2011br2
	download_djgpp ${djpkg}/v2gnu/ pth207b 

	download_djgpp ${djpkg}/v2tk/ ls080b 

	# Sources for stuff that goes into the FB-dos package (needs updating to new versions)
	download_djgpp ${djpkg}/v2gnu/ bnu${bnuver}s
	download_djgpp ${djpkg}/v2gnu/ gcc${gccver}s
	download_djgpp ${djpkg}/v2gnu/ gdb${gdbver}s
	download_djgpp ${djpkg}/v2/    djlsr${djver}

	unzip -qo ../input/DJGPP/djdev${djver}.zip
	
	unzip -qo ../input/DJGPP/shl2011br2.zip
	unzip -qo ../input/DJGPP/fil41br2.zip
	unzip -qo ../input/DJGPP/mak421b.zip
	unzip -qo ../input/DJGPP/pth207b.zip

	unzip -qo ../input/DJGPP/ls080b.zip
	
	unzip -qo ../input/DJGPP/gdb${gdbver}b.zip
	unzip -qo ../input/DJGPP/bnu${bnuver}b.zip
	unzip -qo ../input/DJGPP/gcc${gccver}b.zip
	unzip -qo ../input/DJGPP/gpp${gccver}b.zip
	
	patch -p0 < ../djgpp-fix-pthread.patch
	;;
win32)
	get_mingww64_toolchain 32 i686
	mv mingw32/* . && rmdir mingw32

	mkdir -p ../input/MinGW.org
	mkdir mingworg-gdb
	get_mingworggdb() {
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
	download_extract_mingw() {
		download_mingw "$1" 
		tar xf "../input/MinGW.org/$1"
	}
	download_extract_mingw mingwrt-4.0.3-1-mingw32-dev.tar.lzma
	download_extract_mingw w32api-4.0.3-1-mingw32-dev.tar.lzma
	download_extract_mingw binutils-2.25.1-1-mingw32-bin.tar.xz
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

    # if ddraw.h & dinput.h were added manually:
	# copyfile "../input/MinGW.org/ddraw.h" "include/ddraw.h"
	# copyfile "../input/MinGW.org/dinput.h" "include/dinput.h"

	# download link for dx80_mgw.zip from https://liballeg.org/old.html
	download dx80_mgw.zip https://download.tuxfamily.org/allegro/files/dx80_mgw.zip
	unzip ../input/dx80_mgw.zip include/ddraw.h include/dinput.h

	# Work around http://sourceforge.net/p/mingw/bugs/2039/
	patch -p0 < ../mingworg-fix-wcharh.patch
	;;
win64)
	get_mingww64_toolchain 64 x86_64
	mv mingw64/* . && rmdir mingw64
	;;
esac

bootfb_title=FreeBASIC-1.05.0-$fbtarget

case $fbtarget in
linux*)
	# Special case: linux builds use the host gcc toolchain
	echo "$(lsb_release -d -s), $(uname -m), $(gcc --version | head -1)" >> $buildinfo

	# Download & extract FB for bootstrapping
	bootfb_package=$bootfb_title.tar.xz
	download $bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
	tar xf ../input/$bootfb_package

	# fbc sources
	cp -R ../input/fbc .
	cd fbc && git reset --hard "$fbccommit" && cd ..

	mkdir tempinstall
	;;
*)
	# Download & extract FB for bootstrapping
	bootfb_package=$bootfb_title.zip
	download $bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
	unzip -q ../input/$bootfb_package

	# fbc sources
	cp -R ../input/fbc fbc
	cd fbc && git reset --hard "$fbccommit" && cd ..
	echo "prefix := `pwd -W`" > fbc/config.mk

	# On 64bit, we have to override the FB makefile's uname check, because MSYS uname reports 32bit still
	if [ $fbtarget = win64 ]; then
		echo "TARGET_ARCH := x86_64" >> fbc/config.mk
	fi
	;;
esac

case $fbtarget in
win32|win64)
	# libffi sources
	libffi_title=libffi-3.2.1
	libffi_package="${libffi_title}.tar.gz"
	download "$libffi_package" "ftp://sourceware.org/pub/libffi/$libffi_package"
	echo "extracting $libffi_package"
	tar xf "../input/$libffi_package"
	;;
esac

dosbuild() {
	dospath=`pwd -W`

	cat <<EOF > build.bat
@echo off
set DJGPP=$dospath/djgpp.env
set PATH=$dospath/bin

echo bootstrapping normal fbc:
cd fbc
make FBC=../$bootfb_title/fbc.exe
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
EOF

	cat <<EOF > buildsa.bat
@echo off
set DJGPP=$dospath/djgpp.env
set PATH=$dospath/bin

cd fbc
make ENABLE_STANDALONE=1
if ERRORLEVEL 1 exit /b
cd ..
EOF

	cmd /c build.bat

	echo "building standalone fbc:"
	rm fbc/src/compiler/obj/$fbtarget/fbc.o
	cmd /c buildsa.bat

	mkdir -p fbc/bin/dos
	cp bin/ar.exe bin/as.exe bin/gdb.exe bin/gprof.exe bin/ld.exe fbc/bin/dos/
	cp bin/dxe3gen.exe fbc/bin/dos/
	cp lib/crt0.o lib/gcrt0.o lib/libdbg.a lib/libemu.a lib/libm.a fbc/lib/dos/
	cp lib/libstdcxx.a fbc/lib/dos/libstdcx.a
	cp lib/libsupcxx.a fbc/lib/dos/libsupcx.a
	cp lib/libsocket.a fbc/lib/dos/libsocket.a
	cp lib/libpthread.a fbc/lib/dos/libpthread.a
	cp lib/gcc/djgpp/$djgppgccversiondir/libgcc.a fbc/lib/dos/

	cd fbc
	make bindist TARGET_OS=dos DISABLE_DOCS=1
	make bindist TARGET_OS=dos ENABLE_STANDALONE=1
	cd ..

	cp fbc/*.zip ../output
	cp fbc/contrib/manifest/fbc-dos.lst       ../output
	cp fbc/contrib/manifest/FreeBASIC-dos.lst ../output
}

linuxbuild() {
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
	cp fbc/*.tar.* ../output
	cp fbc/contrib/manifest/FreeBASIC-$fbtarget.lst ../output
}

libffibuild() {

	# do we already have the files we need?
	if [ -f "../input/$libffi_title/$target/ffi.h" ]; then
	if [ -f "../input/$libffi_title/$target/ffitarget.h" ]; then
	if [ -f "../input/$libffi_title/$target/libffi.a" ]; then
		echo
		echo "using cached libffi: $libffi_title/$target"
		echo
		return
	fi
	fi
	fi

	echo
	echo "building libffi"
	echo
	libffi_build="${libffi_title}-build"
	mkdir "$libffi_build"
	cd "$libffi_build"
	if [ "$target" = win64 ]; then
		CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static --build=x86_64-w64-mingw32 --host=x86_64-w64-mingw32
	elif [ "$target" = win32 ]; then
		# force host even for 32-bit, we might be cross compiling from x86_64 to x86
		CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static --host=i686-w64-mingw32
	else
		CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static
	fi
	make
	# stash some files in the input folder to make rebuilding faster
	mkdir -p ../../input/$libffi_title/$target
	cp include/ffi.h include/ffitarget.h ../../input/$libffi_title/$target
	cp .libs/libffi.a ../../input/$libffi_title/$target 
	cd ..
}

windowsbuild() {
	# Add our toolchain's bin/ to the PATH, so hopefully we'll only use
	# its gcc and not one from the host
	origPATH="$PATH"
	export PATH="$PWD/bin:$PATH"

    libffibuild
   	case "$target" in
	win32)			cp ../input/$libffi_title/$target/ffi.h ../input/$libffi_title/$target/ffitarget.h ./i686-w64-mingw32/include;;
	win32-mingworg)	cp ../input/$libffi_title/$target/ffi.h ../input/$libffi_title/$target/ffitarget.h ./include;;
	win64)			cp ../input/$libffi_title/$target/ffi.h ../input/$libffi_title/$target/ffitarget.h ./x86_64-w64-mingw32/include;;
	esac

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

	cd fbc
	echo
	echo "building standalone fbc"
	echo
	rm src/compiler/obj/$fbtarget/fbc.o
	make ENABLE_STANDALONE=1
	cd ..

	mkdir -p fbc/bin/$fbtarget
	cp bin/ar.exe		fbc/bin/$fbtarget
	cp bin/as.exe		fbc/bin/$fbtarget
	cp bin/dlltool.exe	fbc/bin/$fbtarget
	cp bin/gprof.exe	fbc/bin/$fbtarget
	cp bin/ld.exe		fbc/bin/$fbtarget

	cd fbc && make mingw-libs ENABLE_STANDALONE=1 && cd ..

	if [ $fbtarget = "win32" ]; then
		cd fbc/lib/win32 && make && cd ../../..
	fi

	case "$target" in
	win32)
		# Take MinGW.org's gdb, because the gdb from the MinGW-w64 toolchain has much more
		# dependencies (e.g. Python for scripting purposes) which we probably don't want/need.
		# (this should probably be reconsidered someday)
		cp mingworg-gdb/bin/gdb.exe		fbc/bin/win32
		cp mingworg-gdb/bin/libgcc_s_dw2-1.dll	fbc/bin/win32
		cp mingworg-gdb/bin/zlib1.dll		fbc/bin/win32
		;;
	win32-mingworg)
		cp bin/gdb.exe			fbc/bin/win32
		cp bin/libgcc_s_dw2-1.dll	fbc/bin/win32
		cp bin/zlib1.dll		fbc/bin/win32
		;;
	win64)
		cp bin/gcc.exe fbc/bin/win64
		cp --parents libexec/gcc/x86_64-w64-mingw32/$gccversion/cc1.exe fbc/bin
		;;
	esac

	cp ../input/$libffi_title/$target/libffi.a	fbc/lib/$fbtarget

	# Reduce .exe sizes by dropping debug info
	# (this was at least needed for MinGW.org's gdb, and probably nothing else,
	# but it shouldn't hurt either)
	strip -g fbc/bin/$fbtarget/*

	# get GoRC.exe from author site
	download "Gorc.zip" "http://www.godevtool.com/Gorc.zip"
	unzip ../input/Gorc.zip GoRC.exe -d fbc/bin/$fbtarget

	cd fbc
	case "$target" in
	win32|win64)
		make bindist DISABLE_DOCS=1
		make bindist ENABLE_STANDALONE=1
		;;
	win32-mingworg)
		make bindist DISABLE_DOCS=1 FBPACKSUFFIX=-mingworg
		make bindist ENABLE_STANDALONE=1 FBPACKSUFFIX=-mingworg
		;;
	esac
	cd ..

	if [ "$target" = win32 ]; then
		cd fbc/contrib/nsis-installer
		cp ../../FreeBASIC-*-win32.zip .
		make
		cd ../../..
		cp fbc/contrib/nsis-installer/FreeBASIC-*-win32.exe ../output
	fi

	cp fbc/*.zip fbc/*.7z ../output
	cp fbc/contrib/manifest/fbc-$target.lst		../output
	cp fbc/contrib/manifest/FreeBASIC-$target.lst	../output

	export PATH="$origPATH"
	cd ..
}

case $fbtarget in
dos)         dosbuild;;
linux*)      linuxbuild   | tee log.txt 2>&1;;
win32|win64) windowsbuild | tee log.txt 2>&1;;
esac
