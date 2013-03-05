#!/bin/sh
set -ex

show_usage()
{
  echo "usage: contrib/manifest/package.sh <release-name> <package-name> {targz|zip}"
  echo " e.g.: contrib/manifest/package.sh linux FreeBASIC-0.24.0-linux targz"
}

if [ -z "$1" ] || [ -z "$2" ]; then
  show_usage
  exit 1
fi

case "$3" in
zip|targz)
	;;
*)
	show_usage
	exit 1
	;;
esac


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
case "$3" in
zip)
	rm -f $2.zip
	;;
targz)
	rm $2.tar.gz
	;;
esac

# Update the manifest (so you can verify the archive content)
find . -type f | cut -c3- | contrib/manifest/exclude "$1" | sort -f > "contrib/manifest/$1.lst"

# Create an archive containing all the files listed in the manifest
case "$3" in
zip)
	zip -q $2.zip -@ < contrib/manifest/$1.lst
	;;
targz)
	tar -c -z -f $2.tar.gz -T contrib/manifest/$1.lst
	;;
esac

# Remove the non-standalone include directory again (if any)
rm -rf include/freebasic/ include/freebas/
