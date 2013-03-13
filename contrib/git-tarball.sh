#!/bin/sh
set -ex

version=`date +%Y.%m.%d`
name="FreeBASIC-$version-source"
git archive -o "$name.tar.gz" --prefix "$name/" HEAD
