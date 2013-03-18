#!/bin/sh
set -ex

if [ ! -f "$1" ] || [ -z "$2" ] || [ -z "$3" ] ]; then
  echo "usage:  $0  FB-binary.tar.gz  maintainer  email"
  exit 1
fi

tarballbasename=`echo "$1" | sed -e 's/\.[a-zA-Z0-9\.]*$//g'`

fbversion=`echo "$tarballbasename" | cut -d- -f 2`
distro="debian6"
name="freebasic"
version="${fbversion}~${distro}"
arch="i386"
maintainer="$2"
email="$3"

list_depends()
{
	distro="$1"
	arch="$2"

	# Determine the deb dependencies
	case "$arch" in
	i386)
		echo "libc6"
		echo "libncurses5"
		echo "binutils"
		echo "gcc"
		echo "g++"
		echo "libc6-dev"
		echo "libncurses5-dev"
		echo "libx11-dev"
		echo "libxext-dev"
		echo "libxpm-dev"
		echo "libxrandr-dev"
		echo "libxrender-dev"
		;;
	amd64)
		case "$distro" in
		debian*)
			echo "ia32-libs-dev"
			echo "gcc-multilib"
			echo "g++-multilib"
			echo "lib32ncurses5-dev"
			;;
		ubuntu*)
			echo "ia32-libs"
			echo "gcc-multilib"
			echo "g++-multilib"
			echo "lib32ncurses5-dev"
			;;
		esac
		;;
	esac
}

mkdir package
mkdir -m 0755 package/usr
mkdir -m 0755 package/usr/bin
mkdir -m 0755 package/usr/include
mkdir -m 0755 package/usr/lib
mkdir -m 0755 package/DEBIAN

# Extract the binary .tar.gz into FreeBASIC-x.xx.x-abcdef/
tar -xzf "$1"

# install.sh into package/usr/
cd "$tarballbasename"
./install.sh -i ../package/usr/
cd ..

cd package/usr

# install.sh currently installs the man page into prefix/man/,
# but it should be in prefix/share/man/ (for lintian).
mkdir -p share/man/man1
cp man/man1/fbc.1.gz share/man/man1
rm -r man

# Repackage the fbc.1.gz with best compression (for lintian).
gzip -d -c share/man/man1/fbc.1.gz > share/man/man1/fbc.1
rm         share/man/man1/fbc.1.gz
gzip -9 -c share/man/man1/fbc.1    > share/man/man1/fbc.1.gz
rm         share/man/man1/fbc.1

# Copy in the copyright file
mkdir -p "share/doc/$name"
cp ../../copyright "share/doc/$name"

# And changelogs
sed	-e "s/@name@/$name/g"                  \
	-e "s/@version@/$version/g"            \
	-e "s/@date@/`date -R`/g"              \
	-e "s/@maintainer@/$maintainer/g"      \
	-e "s/@email@/$email/g"                \
	../../changelog.Debian                 \
	>  "share/doc/$name/changelog.Debian"
gzip -9 -c "share/doc/$name/changelog.Debian" \
         > "share/doc/$name/changelog.Debian.gz"
rm         "share/doc/$name/changelog.Debian"
gzip -9 -c ../../"$tarballbasename"/changelog.txt \
         > "share/doc/$name/changelog.gz"

cd ../..

find package/usr -type d               -print0 | xargs -0 chmod 755
find package/usr -type f   -executable -print0 | xargs -0 chmod 755
find package/usr -type f ! -executable -print0 | xargs -0 chmod 644

# Generate the md5sums
cd package
find usr -type f | sort | xargs md5sum > DEBIAN/md5sums
chmod 644 DEBIAN/md5sums
cd ..

# Get all depends, in one line, separated by commas
depends=`list_depends "$distro" "$arch" | \
	while read i; do printf "$i, "; done | \
	sed -e 's/, $//g'`

# Find installed size via 'du'
installsize=`du -s package/usr/ | sed "s,	package/usr/,,g"`

# Copy in the control file, and fill in the placeholder strings in it.
sed	-e "s/@name@/$name/g"                  \
	-e "s/@version@/$version/g"            \
	-e "s/@arch@/$arch/g"                  \
	-e "s/@depends@/$depends/g"            \
	-e "s/@installsize@/$installsize/g"    \
	-e "s/@maintainer@/$maintainer/g"      \
	-e "s/@email@/$email/g"                \
	control > package/DEBIAN/control

# Create the .deb
debfile="${name}_${version}_${arch}.deb"
fakeroot dpkg-deb --build package "$debfile"

# Clean up
rm -rf "$tarballbasename" package

lintian "$debfile"
