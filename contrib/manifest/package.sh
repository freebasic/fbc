#!/bin/sh
set -ex

show_usage()
{
  echo "usage: contrib/manifest/package.sh <release-name> <version>"
  echo " e.g.: contrib/manifest/package.sh linux 0.24.0"
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

# Temporarily copy fbc.exe into position
case "$1" in
linux)
	cp bin/fbc-new bin/fbc
	;;
mingw32|djgpp)
	cp bin/fbc-new.exe bin/fbc.exe
	;;
win32|dos)
	cp fbc-new.exe fbc.exe
	;;
esac

# Remove existing archive, if any
case "$1" in
dos|djgpp|win32|mingw32)
	rm -f "FreeBASIC-$2-$1.zip"
	;;
*)
	rm -f "FreeBASIC-$2-$1.tar.gz"
	;;
esac

# Update the manifest (so you can verify the archive content)
find . -type f | cut -c3- | contrib/manifest/exclude "$1" | sort -f > "contrib/manifest/$1.lst"

# Create an archive containing all the files listed in the manifest
case "$1" in
dos|djgpp|win32|mingw32)

	# Copy all the files listed in the manifest into a directory named <release-name>
	zip -q temp.zip -@ < contrib/manifest/$1.lst
	mkdir FreeBASIC-$2-$1
	cd FreeBASIC-$2-$1
	unzip -q ../temp.zip
	cd ..
	rm temp.zip

	# Now package that directory
	zip -q -r FreeBASIC-$2-$1.zip FreeBASIC-$2-$1

	rm -rf FreeBASIC-$2-$1
	;;
*)
	# Copy all the files listed in the manifest into a directory named <release-name>
	tar -czf temp.tar.gz -T contrib/manifest/$1.lst
	mkdir FreeBASIC-$2-$1
	cd FreeBASIC-$2-$1
	tar -xzf ../temp.tar.gz
	cd ..
	rm temp.tar.gz

	# Now package that directory
	tar -czf FreeBASIC-$2-$1.tar.gz FreeBASIC-$2-$1

	rm -rf FreeBASIC-$2-$1
	;;
esac

# Remove the non-standalone include directory again (if any)
rm -rf include/

# Same for fbc.exe
rm -f fbc.exe fbc bin/fbc.exe bin/fbc
