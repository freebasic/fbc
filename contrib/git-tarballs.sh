#!/bin/sh
set -ex

version="$1"
if [ -z "$version" ]; then
	version=`date +%Y.%m.%d`
fi
name="FreeBASIC-$version-source"

# LF .tar.gz and .tar.xz
git -c core.autocrlf=false archive --format tar --prefix "$name/" HEAD | tar xf -
tar -czf "$name.tar.gz" "$name"
tar -cJf "$name.tar.xz" "$name"
rm -rf "$name"

# CRLF .zip with low word size/fast bytes setting (for DOS),
# CRLF .7z
git -c core.autocrlf=true archive --format tar --prefix "$name/" HEAD | tar xf -
7z a -tzip -mfb=8 "$name.zip" "$name" > /dev/null
7z a              "$name.7z"  "$name" > /dev/null
rm -rf "$name"
