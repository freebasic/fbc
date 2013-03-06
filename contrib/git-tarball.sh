#!/bin/sh
set -ex

git archive -o FreeBASIC-`date +%Y.%m.%d`-source.tar.gz HEAD
