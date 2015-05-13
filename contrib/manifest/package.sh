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
zip)
	# Copy all the files listed in the manifest into a directory named <release-name>
	zip -q temp.zip -@ < contrib/manifest/$1.lst
	mkdir $2
	cd $2
	unzip -q ../temp.zip
	cd ..
	rm temp.zip

	# Now package that directory
	zip -q -r $2.zip $2

	rm -rf $2
	;;
targz)
	# Copy all the files listed in the manifest into a directory named <release-name>
	tar -c -z -f temp.tar.gz -T contrib/manifest/$1.lst
	mkdir $2
	cd $2
	tar -x -z -f ../temp.tar.gz
	cd ..
	rm temp.tar.gz

	# Now package that directory
	tar -c -z -f $2.tar.gz $2

	rm -rf $2
	;;
*)
	show_usage
	exit 1
	;;
esac
