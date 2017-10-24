#!/bin/bash
set -ex

source "$(dirname "$0")/bootstrap-settings.sh"

# Build fbc
rm -f config.mk
if [ "$1" = "32" ]; then
	echo "CC := gcc -m32" >> config.mk
	echo "TARGET_ARCH := x86" >> config.mk
fi
echo "FBFLAGS := -g -exx -maxerr 1" >> config.mk
echo "CFLAGS := -g -O2 -Werror -Wfatal-errors -DDEBUG" >> config.mk
make -j$(nproc) FBC="$bootstrap_package/bin/fbc -i $bootstrap_package/inc" </dev/null
mv bin/fbc bin/fbc1
make -j$(nproc) clean-compiler
# Rebuild fbc with itself
make -j$(nproc) compiler FBC='bin/fbc1 -i inc' </dev/null
rm bin/fbc1

# Run fbc tests
make cunit-tests </dev/null

make log-tests </dev/null
if grep RESULT=FAILED tests/failed-*.log; then
	grep RESULT=FAILED tests/failed-*.log | while read ln; do
		logfile="tests/$(echo "$ln" | cut -d: -f2)"
		echo
		echo "$logfile"
		echo
		cat "$logfile"
	done
	exit 1
fi

make warning-tests </dev/null
git update-index -q --ignore-submodules --refresh
if ! git diff-files --quiet --ignore-submodules; then
	git diff
	exit 1
fi

# Build fbdoc tools
export FBC='../../bin/fbc -i ../../inc'
cd doc/libfbdoc
make FBC="$FBC"
cd ../fbdoc
make FBC="$FBC"
cd ../fbchkdoc
make FBC="$FBC"
