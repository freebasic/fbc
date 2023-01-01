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
#   linux-arm
#   linux-aarch64
#       native builds on GNU/arm/aarch64 - relying on the host toolchains;
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
# --recipe name
#   specify which build recipe to use.  Not all recipes are supported on all targets.
#       -gcc-5.2.0          (mingw-w64 project)
#       -gcc-7.1.0          (mingw-w64 project)
#       -gcc-7.1.0r0        (mingw-w64 project)
#       -gcc-7.1.0r2        (mingw-w64 project)
#       -gcc-7.3.0          (mingw-w64 project)
#       -gcc-8.1.0          (mingw-w64 project)
#       -winlibs-gcc-8.4.0  (winlibs mingwrt 7.0.0r1)
#       -winlibs-gcc-9.3.0  (winlibs mingwrt 7.0.0r3 - sjlj)
#       -winlibs-gcc-9.3.0  (winlibs mingwrt 7.0.0r4)
#       -winlibs-gcc-10.2.0 (winlibs mingwrt 8.0.0r8)
#       -winlibs-gcc-10.3.0 (winlibs mingwrt 8.0.0r1)
#       -equation-gcc-8.3.0 (Equation - experimental)
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
	echo "usage: ./build.sh target <fbc commit id> [options]"
	echo ""
	echo "target:"
	echo "   linux-x86|linux-x86_64"
	echo "   linux-arm|linux-aarch64"
	echo "   dos|win32|win32-mingworg|win64"
	echo ""
	echo "<fbc commit id>:"
	echo "   commit-id      hash value of the commit"
	echo "   name-id        name of the branch or tag"
	echo ""
	echo "options:"
	echo "   --offline      only use cached files, don't download from net"
	echo "   --repo url     specify alternate name for repo to fetch from"
	echo "                  in addition to origin repo"
	echo "   --remote name  specify the name to use for the alternate remote"
	echo "   --recipe name  specify a build recipe to use"
	echo "   --use-libffi-cache"
	echo "                  don't build libffi, just use the chaced files"
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
--recipe)
	recipe_name="$2"
	shift; shift
	;;
--use-libffi-cache)
	uselibfficache=Y
	shift
	;;
dos|linux-x86|linux-x86_64|win32|win64|linux-arm|linux-aarch64)
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

# check recipe name
# TODO: error on invalid combination of target and recipe
if [ ! -z "$recipe_name" ]; then
	user_recipe=$recipe_name
	named_recipe=$recipe_name
else
	# if no recipe given, set the default recipe for the main package
	user_recipe=
	case "$target" in
	win32|win64)
		named_recipe=-winlibs-gcc-9.3.0
		;;
	*)
		named_recipe=
		;;
	esac
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

# grab the FBSHA1 now, instead of forcing fbc/makefile to do it
# and we don't want to rely on host having git in the path
FBSHA1="$(git rev-parse HEAD)"

cd ../..

cd build

buildinfo=../output/buildinfo-$target$user_recipe.txt
echo "fbc $fbccommit $target, build based on:" > $buildinfo
echo "named recipe: $named_recipe" >> $buildinfo 
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

repack_equation_exe() {
	packname="$1"
	instname="$packname-installer"

	echo "Removing previous repack directories"
	rm -rf repack
	mkdir repack

	cd repack
	mkdir $packname
	mkdir $instname
	
	echo "Extracting installer files from $packname.exe"
	cd $instname
	7z x -y ../../$packname.exe > /dev/null
	
	echo "Copying directory structure"
	cd source
	find . -type d | xargs -L 1 -I % mkdir -p ../../$packname/%
	
	echo "Decompressing individual files"
	# careful here with the quoting; this uses stdout redirection
	find . -type f -exec sh -c "bzip2 -d -c '{}' > '../../$packname/{}'" \;

	cd ../..
	
	echo "Creating normal 7z archive $packname.7z in cache"
	7z a ../$packname.7z $packname > /dev/null
	
	cd ..

	# clean-up
	rm -rf ./repack
}

get_equation_toolchain() {
	bits="$1"
	arch="$2"
	toolchain=equation

	case "$named_recipe" in
	-equation-gcc-8.3.0)
		gccversion=8.3.0
		mingwbuildsrev=
		mingwruntime=
		;;
	*)
		echo "get_equation_toolchain(): invalid recipe $named_recipe"
		exit 1
		;;
	esac

	dir=http://www.equation.com/ftpdir/gcc/

	file=gcc-$gccversion-$bits
	binUrl=$dir$file.exe

	srcfile=gcc-$gccversion.tar.xz
	srcUrl=$dir$srcfile

	mkdir -p ../input/equation
	download "equation/$file.exe" $binUrl
	download "equation/$srcfile"  $srcUrl
	if [ -f "../input/equation/$file.7z" ]; then
		echo "found $file.7z already repacked"
	else
		lastdir="$PWD"
		cd ../input/equation
		repack_equation_exe $file
		cd "$lastdir"
	fi 
	7z x "../input/equation/$file.7z" > /dev/null
	mv ./$file ./mingw$bits
}

get_winlibs_toolchain() {
	bits="$1"
	arch="$2"
	toolchain=winlibs

	if [ "$bits" = "32" ]; then
		default_eh=dwarf
	else
		default_eh=seh
	fi

	case "$named_recipe" in
	-winlibs-gcc-10.3.0)
		gccversion=10.3.0
		llvmversion=11.1.0
		mingwruntime=8.0.0
		mingwbuildsrev=r1
		winlibsdir=$gccversion-$llvmversion-$mingwruntime-$mingwbuildsrev
		file=winlibs-$arch-posix-$default_eh-gcc-$gccversion-mingw-w64-$mingwruntime-$mingwbuildsrev.7z
		;;
	-winlibs-gcc-10.2.0)
		gccversion=10.2.0
		llvmversion=10.0.1
		mingwruntime=7.0.0
		mingwbuildsrev=r4
		winlibsdir=$gccversion-$mingwruntime-$mingwbuildsrev
		file=winlibs-$arch-posix-$default_eh-gcc-$gccversion-mingw-w64-$mingwruntime-$mingwbuildsrev.7z
		;;
#	-winlibs-gcc-9.3.0)
#		gccversion=9.3.0
#		llvmversion=10.0.0
#		mingwruntime=7.0.0
#		mingwbuildsrev=r3
#		toolchain=winlibs
#		winlibsdir=$gccversion-$llvmversion-$mingwruntime-$mingwbuildsrev
#		file=winlibs-$arch-posix-$default_eh-gcc-$gccversion-llvm-$llvmversion-mingw-w64-$mingwruntime-$mingwbuildsrev.7z
#		;;
	-winlibs-gcc-9.3.0)
		gccversion=9.3.0
		llvmversion=
		mingwruntime=7.0.0
		mingwbuildsrev=r3
		winlibsdir=$gccversion-$mingwruntime-sjlj-$mingwbuildsrev
		file=winlibs-mingw-w64-$arch-$gccversion-$mingwruntime-$mingwbuildsrev-sjlj.7z
		;;
	-winlibs-gcc-8.4.0)
		gccversion=8.4.0
		llvmversion=
		mingwbuildsrev=r1
		mingwruntime=7.0.0
		winlibsdir=$gccversion-$mingwruntime-$mingwbuildsrev
		file=mingw-w64-$arch-$gccversion-$mingwruntime.7z
		;;
	*)
		echo "get_winlibs_toolchain(): invalid recipe $named_recipe"
		exit 1
		;;
	esac

	dir=brechtsanders/winlibs_mingw/releases/download/$winlibsdir/
	binUrl=https://github.com/$dir$file
	srcfile=src-$winlibsdir.tar.gz
	srcUrl=https://github.com/brechtsanders/winlibs_mingw/archive/refs/tags/$winlibsdir.tar.gz

	mkdir -p ../input/winlibs
	download "winlibs/$file"    $binUrl
	download "winlibs/$srcfile" $srcUrl
	7z x "../input/winlibs/$file" > /dev/null
}

get_mingww64_toolchain() {
	bits="$1"
	arch="$2"
	toolchain=mingw-w64
	
	case "$named_recipe" in
	-gcc-8.1.0)
		gccversion=8.1.0
		mingwbuildsrev=rev0
		mingwruntime=v6
		;;
	-gcc-7.3.0)
		gccversion=7.3.0
		mingwbuildsrev=rev0
		mingwruntime=v5
		;;
	-gcc-7.1.0r2)
		gccversion=7.1.0
		mingwbuildsrev=rev2
		mingwruntime=v5
		;;
	-gcc-7.1.0|-gcc-7.1.0r0)
		gccversion=7.1.0
		mingwbuildsrev=rev0
		mingwruntime=v5
		;;
	-gcc-5.2.0)
		gccversion=5.2.0
		mingwbuildsrev=rev0
		mingwruntime=v4
		;;
	*)
		echo "unknown recipe $named_recipe"
		exit 1
	esac

	# mingw-w64 project - personal builds
	dir=Toolchains%20targetting%20Win$bits/Personal%20Builds/mingw-builds/$gccversion/threads-win32/sjlj/

	file=$arch-$gccversion-release-win32-sjlj-rt_$mingwruntime-$mingwbuildsrev.7z
	binUrl=http://sourceforge.net/projects/mingw-w64/files/$dir$file/download

	srcfile=src-$gccversion-release-rt_$mingwruntime-$mingwbuildsrev.tar.7z
	srcUrl=http://sourceforge.net/projects/mingw-w64/files/Toolchain%20sources/Personal%20Builds/mingw-builds/$gccversion/$srcfile/download

	mkdir -p ../input/MinGW-w64
	download "MinGW-w64/$file"    $binUrl
	download "MinGW-w64/$srcfile" $srcUrl
	7z x "../input/MinGW-w64/$file" > /dev/null
}

get_windows_toolchain() {
	bits="$1"
	arch="$2"

	case "$named_recipe" in
	-winlibs-*)
		get_winlibs_toolchain $bits $arch
		;;
	-equation-*)
		get_equation_toolchain $bits $arch
		;;
	-gcc-*)
		get_mingww64_toolchain $bits $arch
		;;
	*)
		echo "get_windows_toolchain(): invalid recipe $named_recipe"
		exit 1
		;;
	esac
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
	gccver=930
	djgppgccversiondir=9
	bnuver=2351
	gdbver=771
	djpkg=current

	# binutils/gcc/gdb (needs updating to new versions)
	download_djgpp ${djpkg}/v2gnu/ bnu${bnuver}b
	download_djgpp ${djpkg}/v2gnu/ gcc${gccver}b
	download_djgpp ${djpkg}/v2gnu/ gpp${gccver}b
	download_djgpp ${djpkg}/v2gnu/ gdb${gdbver}b

	# rest to complete the DJGPP install (usually no changes needed)
	download_djgpp ${djpkg}/v2/ djdev${djver}

	download_djgpp ${djpkg}/v2gnu/ fil41br3
	download_djgpp ${djpkg}/v2gnu/ mak43br2
	download_djgpp ${djpkg}/v2gnu/ shl2011br3
	download_djgpp ${djpkg}/v2gnu/ pth207b 

	download_djgpp ${djpkg}/v2tk/ ls080b 

	# Sources for stuff that goes into the FB-dos package (needs updating to new versions)
	download_djgpp ${djpkg}/v2gnu/ bnu${bnuver}s
	download_djgpp ${djpkg}/v2gnu/ gcc${gccver}s
	download_djgpp ${djpkg}/v2gnu/ gdb${gdbver}s
	download_djgpp ${djpkg}/v2/    djlsr${djver}

	unzip -qo ../input/DJGPP/djdev${djver}.zip
	
	unzip -qo ../input/DJGPP/shl2011br3.zip
	unzip -qo ../input/DJGPP/fil41br3.zip
	unzip -qo ../input/DJGPP/mak43br2.zip
	unzip -qo ../input/DJGPP/pth207b.zip

	unzip -qo ../input/DJGPP/ls080b.zip
	
	unzip -qo ../input/DJGPP/gdb${gdbver}b.zip
	unzip -qo ../input/DJGPP/bnu${bnuver}b.zip
	unzip -qo ../input/DJGPP/gcc${gccver}b.zip
	unzip -qo ../input/DJGPP/gpp${gccver}b.zip
	
	patch -p0 < ../djgpp-pthread-types.patch
	;;
win32)
	get_windows_toolchain 32 i686
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
	download_extract_mingw libiconv-1.14-3-mingw32-dll.tar.lzma

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
	get_windows_toolchain 64 x86_64
	mv mingw64/* . && rmdir mingw64
	;;
esac

# choose a bootstrap source for the target
case $fbtarget in
linux-arm|linux-aarch64)
	bootfb_title=FreeBASIC-1.07.2-$fbtarget
	;;
*)
	bootfb_title=FreeBASIC-1.06.0-$fbtarget
	;;
esac

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
	# libffi sources https://github.com/libffi/libffi/releases/download/v3.3/libffi-3.3.tar.gz. 
	libffi_title=libffi-3.3
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
make FBSHA1=$FBSHA1 FBC=../$bootfb_title/fbc.exe
if ERRORLEVEL 1 exit /b
make install
if ERRORLEVEL 1 exit /b
cd ..

echo rebuilding normal fbc:
cd fbc
make clean-compiler
if ERRORLEVEL 1 exit /b
make FBSHA1=$FBSHA1
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
make FBSHA1=$FBSHA1 ENABLE_STANDALONE=1
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
	cp lib/dxe.ld fbc/lib/dos/dxe.ld 
	cp lib/crt0.o lib/gcrt0.o lib/libdbg.a lib/libemu.a lib/libm.a fbc/lib/dos/
	cp lib/libstdcxx.a fbc/lib/dos/libstdcx.a
	cp lib/libsupcxx.a fbc/lib/dos/libsupcx.a
	cp lib/libsocket.a fbc/lib/dos/libsocket.a
	cp lib/libpthread.a fbc/lib/dos/libpthread.a
	cp lib/gcc/djgpp/$djgppgccversiondir/libgcc.a fbc/lib/dos/

	cd fbc
	make bindist TARGET_OS=dos DISABLE_DOCS=1 FBSHA1=$FBSHA1
	make bindist TARGET_OS=dos ENABLE_STANDALONE=1 FBSHA1=$FBSHA1
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
	make FBC=../$bootfb_title/bin/fbc FBSHA1=$FBSHA1
	make install prefix=../tempinstall
	echo
	echo "rebuilding normal fbc"
	echo
	make clean-compiler
	make FBC=../tempinstall/bin/fbc FBSHA1=$FBSHA1
	cd ..

	cd fbc && make bindist FBSHA1=$FBSHA1 && cd ..
	cp fbc/*.tar.* ../output
	cp fbc/contrib/manifest/FreeBASIC-$fbtarget.lst ../output
}

libffibuild() {

	# on fbc 1.08.0 we changed the libffi version so
	# don't use any cached files when building the packages
	# commented out for future reference
	# do we already have the files we need?
	if [ "$uselibfficache" = "Y" ]; then
	if [ -f "../input/$libffi_title/$target$named_recipe/ffi.h" ]; then
	if [ -f "../input/$libffi_title/$target$named_recipe/ffitarget.h" ]; then
	if [ -f "../input/$libffi_title/$target$named_recipe/libffi.a" ]; then
		echo
		echo "using cached libffi: $libffi_title/$target$named_recipe"
		echo
		return
	fi
	fi
	fi
	fi

	# or just grab the files we need from the package?
	# we might copy in the files directly if we unable to build libffi ourselves
	# as was the case for libffi-3.2.1 and some gcc tool chains
	# so just leave this section commented out for reference
#	case "$named_recipe" in
#	-gcc-7.1.0|-gcc-7.1.0r0|-gcc-7.1.0r2|-gcc-7.3.0|-gcc-8.1.0)
#		mkdir -p ../input/$libffi_title/$target$named_recipe
#		cp opt/lib/libffi-3.3/include/ffi.h       ../input/$libffi_title/$target$named_recipe
#		cp opt/lib/libffi-3.3/include/ffitarget.h ../input/$libffi_title/$target$named_recipe
#		cp opt/lib/libffi.a                       ../input/$libffi_title/$target$named_recipe
#		return
#		;;
#	esac

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
	mkdir -p ../../input/$libffi_title/$target$named_recipe
	cp include/ffi.h include/ffitarget.h ../../input/$libffi_title/$target$named_recipe
	cp .libs/libffi.a ../../input/$libffi_title/$target$named_recipe
	cd ..
}

windowsbuild() {
	# Add our toolchain's bin/ to the PATH, so hopefully we'll only use
	# its gcc and not one from the host
	origPATH="$PATH"
	export PATH="$PWD/bin:$PATH"
	echo "Current Path: $PATH"
	echo "gcc version: `gcc -dumpversion`"
	echo >> $buildinfo
	echo "gcc version: `gcc -dumpversion`" >> $buildinfo

	libffibuild
	# copy our stored files to the build
	case "$toolchain" in
	equation)
		case "$target" in
		win32)          cp ../input/$libffi_title/$target$named_recipe/ffi.h ../input/$libffi_title/$target$named_recipe/ffitarget.h ./i686-pc-mingw32/include;;
		win64)          cp ../input/$libffi_title/$target$named_recipe/ffi.h ../input/$libffi_title/$target$named_recipe/ffitarget.h ./x86_64-w64-mingw32/include;;
		esac
		;;
	*)
		case "$target" in
		win32)          cp ../input/$libffi_title/$target$named_recipe/ffi.h ../input/$libffi_title/$target$named_recipe/ffitarget.h ./i686-w64-mingw32/include;;
		win32-mingworg) cp ../input/$libffi_title/$target$named_recipe/ffi.h ../input/$libffi_title/$target$named_recipe/ffitarget.h ./include;;
		win64)          cp ../input/$libffi_title/$target$named_recipe/ffi.h ../input/$libffi_title/$target$named_recipe/ffitarget.h ./x86_64-w64-mingw32/include;;
		esac
		;;
	esac

	cd fbc
	echo
	echo "bootstrapping normal fbc"
	echo
	case "$target" in
	win32-mingworg) make FBSHA1=$FBSHA1 FBC=../$bootfb_title/fbc.exe CFLAGS=-DDISABLE_D3D10;;
	*)              make FBSHA1=$FBSHA1 FBC=../$bootfb_title/fbc.exe;;
	esac
	make install
	echo
	echo "rebuilding normal fbc"
	echo
	make clean-compiler

	case "$toolchain" in
	equation)
		# hack:
		# patch in crt_glob.bas to enable command line wildard expansion
		# equation-crt-glob.bas:
		#     extern as integer _dowildcard alias "_dowildcard"
		#     dim shared _dowildcard as integer = -1
		# careful, this adds the module to the bootstrap and source packages
		cp ../../input/fbc/contrib/release/equation-crt-glob.bas src/compiler/equation-crt-glob.bas
		;;
	esac

	case "$target" in
	win32-mingworg) make FBSHA1=$FBSHA1 CFLAGS=-DDISABLE_D3D10;;
	*)              make FBSHA1=$FBSHA1;;
	esac
	cd ..

	cd fbc
	echo
	echo "building standalone fbc"
	echo
	rm src/compiler/obj/$fbtarget/fbc.o
	case "$target" in
	win32-mingworg) make FBSHA1=$FBSHA1 ENABLE_STANDALONE=1 CFLAGS=-DDISABLE_D3D10;;
	*)              make FBSHA1=$FBSHA1 ENABLE_STANDALONE=1;;
	esac

	cd ..

	mkdir -p fbc/bin/$fbtarget
	cp bin/ar.exe		fbc/bin/$fbtarget
	cp bin/as.exe		fbc/bin/$fbtarget
	cp bin/dlltool.exe	fbc/bin/$fbtarget
	cp bin/gprof.exe	fbc/bin/$fbtarget
	cp bin/ld.exe		fbc/bin/$fbtarget

	case "$named_recipe" in
	-equation-gcc-8.3.0)
		cp bin/gcc.exe fbc/bin/$target
		cp bin/gdb.exe fbc/bin/$target

		case "$target" in
		win32)
			# copy all the dll's from libexec; they are needed for cc1.exe
			cp --parents libexec/gcc/i686-pc-mingw32/$gccversion/cc1.exe fbc/bin
			;;
		win64)
			# copy all the dll's from libexec; they are needed for cc1.exe
			cp --parents libexec/gcc/x86_64-w64-mingw32/$gccversion/cc1.exe fbc/bin
			;;
		*)
			echo "windowsbuild(): invalid target $target"
			exit 1
			;;
		esac
		;;
	-winlibs-gcc-8.4.0|-winlibs-gcc-9.3.0|-winlibs-gcc-10.2.0|-winlibs-gcc-10.3.0)
		# -winlibs-gcc-X.X is being built from winlibs and the binutils have a few dependencies
		# copy these to the bin directory - they go with the executables and should
		# not be used as general libraries
		cp bin/libdl.dll            fbc/bin/$fbtarget
		cp bin/libiconv-2.dll       fbc/bin/$fbtarget
		cp bin/libintl-8.dll        fbc/bin/$fbtarget
		cp bin/libwinpthread-1.dll  fbc/bin/$fbtarget
		cp bin/zlib1.dll            fbc/bin/$fbtarget
		cp bin/gcc.exe fbc/bin/$target

		# copy the exception handling DLL
		# libgcc_s_sjlj-1.dll  - SJLJ win32 or win53
		# libgcc_s_dw2.dll     - dwarf2 win32
		# libgcc_s_seh.dll     - SEH win64
		cp bin/libgcc_s_*-1.dll	fbc/bin/$fbtarget

		case "$target" in
		win32)
			# copy all the dll's from libexec; they are needed for cc1.exe
			cp --parents libexec/gcc/i686-w64-mingw32/$gccversion/cc1.exe fbc/bin
			cp --parents libexec/gcc/i686-w64-mingw32/$gccversion/*.dll   fbc/bin
			#also copy as.exe and ld.exe to satify 'gcc --help -v'
			cp bin/as.exe fbc/bin/libexec/gcc/i686-w64-mingw32/$gccversion/as.exe  
			cp bin/ld.exe fbc/bin/libexec/gcc/i686-w64-mingw32/$gccversion/ld.exe  
			;;
		win64)
			# copy all the dll's from libexec; they are needed for cc1.exe
			cp --parents libexec/gcc/x86_64-w64-mingw32/$gccversion/cc1.exe fbc/bin
			cp --parents libexec/gcc/x86_64-w64-mingw32/$gccversion/*.dll   fbc/bin
			#also copy as.exe and ld.exe to satify 'gcc --help -v'
			cp bin/as.exe fbc/bin/libexec/gcc/x86_64-w64-mingw32/$gccversion/as.exe  
			cp bin/ld.exe fbc/bin/libexec/gcc/x86_64-w64-mingw32/$gccversion/ld.exe  
			;;
		*)
			echo "windowsbuild(): invalid target $target"
			exit 1
			;;
		esac
		;;
	*)
		case "$target" in
		win32)
			# !!! TODO !!! re-evaluate the gdb used with later gcc versions
			# Take MinGW.org's gdb, because the gdb from the MinGW-w64 toolchain has much more
			# dependencies (e.g. Python for scripting purposes) which we probably don't want/need.
			# (this should probably be reconsidered someday)
			cp mingworg-gdb/bin/gdb.exe             fbc/bin/win32
			cp mingworg-gdb/bin/libgcc_s_dw2-1.dll  fbc/bin/win32
			cp mingworg-gdb/bin/zlib1.dll           fbc/bin/win32

			cp bin/gcc.exe fbc/bin/win32
			cp --parents libexec/gcc/i686-w64-mingw32/$gccversion/cc1.exe fbc/bin

			;;
		win32-mingworg)
			cp bin/gdb.exe              fbc/bin/win32
			cp bin/libgcc_s_dw2-1.dll   fbc/bin/win32
			cp bin/libiconv-2.dll       fbc/bin/win32
			cp bin/zlib1.dll            fbc/bin/win32
			;;
		win64)
			cp bin/gcc.exe fbc/bin/win64
			cp --parents libexec/gcc/x86_64-w64-mingw32/$gccversion/cc1.exe fbc/bin
			;;
		esac
		;;
	esac

	cd fbc && make mingw-libs ENABLE_STANDALONE=1 && cd ..

	if [ $fbtarget = "win32" ]; then
		cd fbc/lib/win32 && make && cd ../../..
	fi

	cp ../input/$libffi_title/$target$named_recipe/libffi.a fbc/lib/$fbtarget

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
		make bindist DISABLE_DOCS=1 FBPACKSUFFIX=$user_recipe FBSHA1=$FBSHA1
		make bindist ENABLE_STANDALONE=1 FBPACKSUFFIX=$user_recipe FBSHA1=$FBSHA1
		;;
	win32-mingworg)
		make bindist DISABLE_DOCS=1 FBPACKSUFFIX=-mingworg FBSHA1=$FBSHA1
		make bindist ENABLE_STANDALONE=1 FBPACKSUFFIX=-mingworg FBSHA1=$FBSHA1
		;;
	esac
	cd ..

	# Only build the installer, if we are also
	# building the default package
	if [ -z "$user_recipe" ]; then
	if [ "$target" = win32 ]; then
		cd fbc/contrib/nsis-installer
		cp ../../FreeBASIC-*-win32.zip .
		make
		cd ../../..
		cp fbc/contrib/nsis-installer/FreeBASIC-*-win32.exe ../output
	fi
	fi

	cp fbc/*.zip fbc/*.7z ../output
	cp fbc/contrib/manifest/fbc-$target$user_recipe.lst       ../output
	cp fbc/contrib/manifest/FreeBASIC-$target$user_recipe.lst ../output

	export PATH="$origPATH"
	cd ..
}

case $fbtarget in
dos)         dosbuild;;
linux*)      linuxbuild   | tee log.txt 2>&1;;
win32|win64) windowsbuild | tee log.txt 2>&1;;
esac
