#!/bin/sh
set -ex

FB_VERSION=`date '+%Y.%m.%d'`
FB_TITLE="FreeBASIC-$FB_VERSION-source-asm"
FB_TARBALL="$FB_TITLE.tar.gz"

if [ ! -f "src/compiler/fbc.bas" ]; then
  echo "Please run this from the fbc root directory"
  exit 1
fi

make -f contrib/bootstrap/makefile clean GEN=gas
make -f contrib/bootstrap/makefile prepare GEN=gas

tar czf "$FB_TARBALL" *

make -f contrib/bootstrap/makefile clean GEN=gas
