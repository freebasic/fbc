#!/bin/sh
set -ex

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: contrib/manifest/package.sh <release-name> <package-name>"
  echo " e.g.: contrib/manifest/package.sh linux FreeBASIC-0.24.0-linux"
  exit 1
fi

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
