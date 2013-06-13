#!/bin/sh
set -ex

if [ ! -f "$1" ]; then
  echo "please specify the FB source .tar.gz on the command line"
  exit 1
fi

fbversion=`date '+%Y.%m.%d'`
fbtarball="FreeBASIC-$fbversion-source-asm.tar.gz"

# Extract the source .tar.gz into a temp dir
tempdir=`mktemp -d`
tar -xzf "$1" -C "$tempdir"

# Pre-compile the *.bas files to *.asm, and create a new .tar.gz with them
oldpwd="$PWD"
cd "$tempdir"

cd "FreeBASIC-$fbversion-source"

# Build fbc
make compiler

# Use that fbc to pre-compile its own *.bas files to *.asm
# (unlike using the host fbc to pre-compile, this ensures that the resulting
# *.asm files are ABI-compatible to the rtlib in this source tree)
make -f contrib/bootstrap.mk prepare GEN=gas FBC='bin/fbc -i inc'

# Remove bin/fbc and the *.o files again
make clean

cd ..
mv "FreeBASIC-$fbversion-source" "FreeBASIC-$fbversion-source-asm"

# Create asm tarball
tar -czf "$fbtarball" "FreeBASIC-$fbversion-source-asm"

cd "$oldpwd"

mv "$tempdir/$fbtarball" .
rm -rf "$tempdir"
