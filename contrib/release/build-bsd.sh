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
# ./build-bsd.sh <target> <fbc-commit-id> [--offline] [--repo url] [--remote name]
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
#   when given, build.sh will stop with exit code 1 if the file is not already
#   in the download cache.
#
# --repo url
#   specify an additional repo url to fetch in to the local repo other than the
#   official https://github.com/freebasic/fbc.git repo.
#
# --remote name
#   specifies the remote name to add and use when referring to the other repo
#   url. remote name will default to 'other' if the --repo option was given.
#   remote name will default to 'origin' if the --repo option was not given.
#
# --recipe name
#   specify which build recipe to use:
#     * -freebsd-13.0-x86
#     * -freebsd-13.0-x86_64
#     * -freebsd-13.4-x86
#     * -freebsd-13.4-x86_64
#
#   Not all recipes are supported on all targets.
#
# Requirements:
#   - gmake and other gnu tools
#
set -e

usage() {
	echo "usage: ./build.sh target <fbc commit id> [options]"
	echo ""
	echo "target:"
	echo "   freebsd-x86|freebsd-x86_64"
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
# recipe_name is from the command line option, empty string if not given
# user_recipe is either explicit (from command line) or automatic (below)
if [ ! -z "$recipe_name" ]; then
	# recipe_name may be blank and optionally start with a dash '-'
	# user_recipe must be blank or start with a dash '-'
	case "$recipe_name" in
	""|-*)
		user_recipe=$recipe_name
		;;
	*)
		user_recipe=-$recipe_name
		;;
	esac
	named_recipe=$user_recipe
else
	# if no recipe given, set the default recipe for the main package
	user_recipe=
	case "$target" in
	win32|win64)
		named_recipe=-winlibs-gcc-9.3.0
		;;
	linux-arm)
		# named recipe wasn't given, try and figure it out ...
		if [ -f /etc/os-release ]; then
			host_os_id=$(grep -oP '(?<=^ID=).+' /etc/os-release | tr -d '"')
			host_os_ver=$(grep -oP '(?<=^VERSION_ID=).+' /etc/os-release | tr -d '"')
		fi
		case "$host_os_id-$host_os_ver" in
		raspbian-9)
			named_recipe=-raspbian9-arm
			;;
		esac
		;;
	esac
fi

echo "building FB-$target (uname = `uname`, uname -m = `uname -m`)"
echo "from repository: https://github.com/freebasic/fbc.git"
if [ ! -z "$user_recipe" ]; then
	echo "user gave recipe '$user_recipe'"
fi
if [ ! -z "$named_recipe" ]; then
	echo "using named recipe '$named_recipe'"
fi
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
echo "buildinfo: $buildinfo"
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


BUILD_BOOTFBCFLAGS=
AppendBOOTFBCFLAGS() {
	if [ ! -z "$1" ]; then
		if [ -z "$BUILD_BOOTFBCFLAGS" ]; then
			BUILD_BOOTFBCFLAGS="$1"
		else
			BUILD_BOOTFBCFLAGS="$BUILD_BOOTFBCFLAGS $1"
		fi
	fi
}

# choose a bootstrap source for the target
case $fbtarget in
freebsd-x86|freebsd-x86_64)
	bootfb_title=FreeBASIC-1.09.0-$fbtarget
	;;
esac

if [ ! -z "$named_recipe" ]; then
	AppendBOOTFBCFLAGS "FBPACKTARGET=${named_recipe#-}"
fi

case $fbtarget in
freebsd*)
	# Special case: freebsd builds use the host gcc toolchain
	# echo "$(lsb_release -d -s), $(uname -m), $(gcc --version | head -1)" >> $buildinfo

	# Download & extract FB for bootstrapping
	bootfb_package=$bootfb_title.tar.xz
	download $bootfb_package "https://downloads.sourceforge.net/fbc/${bootfb_package}?download"
	tar xf ../input/$bootfb_package || rm -f ../input/$bootfb_package

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
	gmake FBC=../$bootfb_title/bin/fbc FBSHA1=$FBSHA1 $BUILD_BOOTFBCFLAGS
	gmake install prefix=../tempinstall
	echo
	echo "rebuilding normal fbc"
	echo
	gmake clean-compiler
	gmake FBC=../tempinstall/bin/fbc FBSHA1=$FBSHA1 $BUILD_BOOTFBCFLAGS
	cd ..

	echo "copying files to output directory"
	cd fbc && gmake bindist FBSHA1=$FBSHA1 $BUILD_BOOTFBCFLAGS && cd ..
	cp fbc/*.tar.* ../output
	if [ ! -z "$user_recipe" ]; then
		cp fbc/contrib/manifest/FreeBASIC$user_recipe.lst ../output
	else
		cp fbc/contrib/manifest/FreeBASIC-$fbtarget.lst ../output
	fi
	echo "freebsd build done"
}

case $fbtarget in
freebsd*)    freebsdbuild | tee log.txt 2>&1;;
esac
