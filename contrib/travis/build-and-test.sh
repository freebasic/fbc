#!/bin/bash
set -ex

source "$(dirname "$0")/bootstrap-settings.sh"

if [ "$1" = "32" ]; then
	echo "CC = gcc -m32" > config.mk
	echo "TARGET_ARCH = x86" >> config.mk
fi
make -j$(nproc) FBC="$bootstrap_package/bin/fbc -i $bootstrap_package/inc" </dev/null
mv bin/fbc bin/fbc1
make -j$(nproc) clean-compiler
make -j$(nproc) compiler FBC='bin/fbc1 -i inc' </dev/null
rm bin/fbc1

make cunit-tests </dev/null

make log-tests </dev/null
if grep RESULT=FAILED tests/failed-*.log; then
	exit 1
fi

make warning-tests </dev/null
git update-index -q --ignore-submodules --refresh
if ! git diff-files --quiet --ignore-submodules; then
	git diff
	exit 1
fi
