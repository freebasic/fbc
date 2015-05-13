#!/bin/sh
set -e

if [ -z "$1" ]; then
  echo "usage: contrib/manifest/update.sh <release-name>"
  echo "(the release name as used in pattern.ini and manifest file names)"
  exit 1
fi

find . -type f | cut -c3- | contrib/manifest/exclude "$1" | sort -f > "contrib/manifest/$1.lst"
