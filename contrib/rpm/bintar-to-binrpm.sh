#!/bin/sh
set -ex

if [ ! -f "$1" ]; then
  echo "please specify the FB binary .tar.gz on the command line"
  exit 1
fi

tarballbasename=`echo "$1" | sed -e 's/\.[a-zA-Z0-9\.]*$//g'`

name="freebasic"
version=`echo "$tarballbasename" | cut -d- -f 2`
release="1"
arch="i386"

list_requires()
{
	distro="$1"
	arch="$2"

	case "$distro" in
	opensuse*)
		case "$arch" in
		i386)
			echo "binutils"
			echo "gcc"
			echo "ncurses-devel"
			echo "xorg-x11-devel"
			echo "libffi46-devel"
			;;
		x86_64)
			echo "binutils"
			echo "gcc-32bit"
			echo "ncurses-devel-32bit"
			echo "xorg-x11-devel-32bit"
			echo "xorg-x11-libX11-devel-32bit"
			echo "xorg-x11-libXext-devel-32bit"
			echo "xorg-x11-libXrender-devel-32bit"
			echo "xorg-x11-libXpm-devel-32bit"
			echo "libffi46-devel-32bit "
			;;
		esac
		;;
	fedora*)
		case "$arch" in
		i386)
			echo "binutils"
			echo "gcc"
			echo "ncurses-devel"
			echo "libffi-devel"
			echo "libX11-devel"
			echo "libXext-devel"
			echo "libXpm-devel"
			echo "libXrandr-devel"
			echo "libXrender-devel"
			;;
		x86_64)
			echo "binutils"
			echo "gcc"
			echo "ncurses-devel.i686"
			echo "libffi-devel.i686"
			echo "libX11-devel.i686"
			echo "libXext-devel.i686"
			echo "libXpm-devel.i686"
			echo "libXrandr-devel.i686"
			echo "libXrender-devel.i686"
			;;
		esac
		;;
	esac
}

mkdir -p rpmbuild/RPMS
mkdir -p rpmbuild/SRPMS
mkdir -p rpmbuild/BUILD
mkdir -p rpmbuild/SOURCES
mkdir -p rpmbuild/SPECS

# Copy in the tarball
cp "$1" rpmbuild/SOURCES

# Get all required packages, in one line, separated by commas
requires=`list_requires "$distro" "$arch" | \
	while read i; do printf "$i, "; done | \
	sed -e 's/, $//g'`


sed	-e "s/@name@/$name/g"              \
	-e "s/@version@/$version/g"        \
	-e "s/@release@/$release/g"        \
	-e "s/@arch@/$arch/g"              \
	-e "s:@tarball@:$1:g"              \
	-e "s:@tarballbasename@:$tarballbasename:g"  \
	-e "s/@requires@/$requires/g"      \
	spec > rpmbuild/SPECS/$name.spec

# Temporarily extract and install, to get the file list
tar -xf "$1"
mkdir usr
cd $tarballbasename
./install.sh -i ../usr
cd ..
find usr -type f | while read file; do echo "/$file"; done | sort >> rpmbuild/SPECS/$name.spec
rm -rf $tarballbasename usr

rpmbuild --define "_topdir $PWD/rpmbuild" -bb rpmbuild/SPECS/$name.spec

mv "rpmbuild/RPMS/${arch}/${name}-${version}-${release}.${arch}.rpm" .
rm -rf rpmbuild
