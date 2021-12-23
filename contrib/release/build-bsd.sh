#!/bin/sh
#
# Created from ./build.sh and modified for freebsd.
#
# Creates the complete packages ready to be released.
#   - Downloaded archives are cached in the input/ dir
#   - Output packages & manifests are put in the output/ dir
#   - Toolchain source packages are downloaded too
#   - fbc sources are retrieved from Git; you have to specify the exact commit
#     to build (or a tag/branch name).
#
# ./build-bsp.sh <target> <fbc-commit-id> [--offline] [--repo url] [--remote name]
#
# <target> can be one of:
#   freebsd-x86
#   freebsd-x86_64
#       native builds on GNU/FreeBSD x86/x86_64 using gmake and gcc toolchains;
#       no gcc toolchain is downloaded; no standalone version of FB is built.
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
#   not used
#
# Requirements:
#   - gmake and other gnu tools
# 
set -e

usage() {
	echo "usage: ./build-bsd.sh freebsd-x86|freebsd-x86_64 <fbc commit id> [--offline] [--repo url] [--remote name] [--recipe name]"
	exit 1
}

# parse command line arguments
while [ $# -gt 0 ]
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
freebsd-x86|freebsd-x86_64)
	target="$1"
	fbtarget=$target
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
	recipe=$recipe_name
else
	recipe=""
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

buildinfo=../output/buildinfo-$target$recipe.txt
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


# choose a bootstrap source for the target
case $fbtarget in
freebsd-x86|freebsd-x86_64)
	bootfb_title=FreeBASIC-1.09.0-$fbtarget
	;;
esac

case $fbtarget in
freebsd*)
	# Special case: freebsd builds use the host gcc toolchain
	# echo "$(lsb_release -d -s), $(uname -m), $(gcc --version | head -1)" >> $buildinfo

	# Download & extract FB for bootstrapping
	bootfb_package=$bootfb_title.tar.xz
	download $bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
	tar xf ../input/$bootfb_package

	# fbc sources
	cp -R ../input/fbc .
	cd fbc && git reset --hard "$fbccommit" && cd ..

	mkdir tempinstall
	;;
esac

freebsdbuild() {
	cd fbc
	echo
	echo "bootstrapping normal fbc"
	echo
	gmake FBC=../$bootfb_title/bin/fbc FBSHA1=$FBSHA1
	gmake install prefix=../tempinstall
	echo
	echo "rebuilding normal fbc"
	echo
	gmake clean-compiler
	gmake FBC=../tempinstall/bin/fbc FBSHA1=$FBSHA1
	cd ..

	cd fbc && gmake bindist FBSHA1=$FBSHA1 && cd ..
	cp fbc/*.tar.* ../output
	cp fbc/contrib/manifest/FreeBASIC-$fbtarget.lst ../output
}

libffibuild() {
	echo
	echo "building libffi"
	echo
	libffi_build="${libffi_title}-build"
	mkdir "$libffi_build"
	cd "$libffi_build"
	CFLAGS=-O2 ../$libffi_title/configure --disable-shared --enable-static
	gmake
	# stash some files in the input folder to make rebuilding faster
	mkdir -p ../../input/$libffi_title/$target$recipe
	cp include/ffi.h include/ffitarget.h ../../input/$libffi_title/$target$recipe
	cp .libs/libffi.a ../../input/$libffi_title/$target$recipe
	cd ..
}

case $fbtarget in
freebsd*)    freebsdbuild | tee log.txt 2>&1;;
esac
