#!/bin/sh
set -ex

version=`date +%Y.%m.%d`
name="FreeBASIC-$version-source"
git archive --format zip -o "$name.zip" --prefix "$name/" HEAD
