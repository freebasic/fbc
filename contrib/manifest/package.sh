#!/bin/sh
set -ex

show_usage()
{
  echo "usage: contrib/manifest/package.sh <release-name> <package-name>"
  echo " e.g.: contrib/manifest/package.sh linux FreeBASIC-0.24.0-linux"
}

if [ -z "$1" ] || [ -z "$2" ]; then
  show_usage
  exit 1
fi

# For non-standalone releases, copy the includes into the proper directory
case "$1" in
linux|mingw32)
	mkdir -p include/freebasic/
	cp -r inc/* include/freebasic/
	;;
djgpp)
	mkdir -p include/freebas/
	cp -r inc/* include/freebas/
	;;
esac

# Remove existing archive, if any
case "$1" in
dos|djgpp|win32|mingw32)
	rm -f $2.zip
	;;
*)
	rm $2.tar.gz
	;;
esac

# Update the manifest (so you can verify the archive content)
find . -type f | cut -c3- | contrib/manifest/exclude "$1" | sort -f > "contrib/manifest/$1.lst"

# Create an archive containing all the files listed in the manifest
case "$1" in
dos|djgpp|win32|mingw32)
	zip -q $2.zip -@ < contrib/manifest/$1.lst
	;;
*)
	tar -czf $2.tar.gz -T contrib/manifest/$1.lst
	;;
esac

# Remove the non-standalone include directory again (if any)
rm -rf include/freebasic/ include/freebas/
