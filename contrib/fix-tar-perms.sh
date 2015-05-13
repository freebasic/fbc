#!/bin/sh
set -ex

if [ ! -f "$1" ]; then
  echo "please specify a .tar.gz on the command line"
  exit 1
fi

# Extract the .tar.gz into a temp dir
tempdir=`mktemp -d`
tar -xzf "$1" -C "$tempdir"

# Set everything to standard permissions (for deb packages)
find "$tempdir" -type d               -print0 | xargs -0 chmod 755
find "$tempdir" -type f   -executable -print0 | xargs -0 chmod 755
find "$tempdir" -type f ! -executable -print0 | xargs -0 chmod 644

# Create new tarball, under fakeroot, to also set the owner/group to root
# (more generic than the current user)
oldpwd="$PWD"
cd "$tempdir"
tarball="fixed-`basename $1`"
fakeroot tar -czf "$tarball" *
cd "$oldpwd"

mv "$tempdir/$tarball" .
rm -rf "$tempdir"
