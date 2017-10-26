#!/bin/bash
set -ex

source "$(dirname "$0")/bootstrap-settings.sh"

# Build fbc
rm -f config.mk
if [ "$FBTRAVIS_TARGET_BITS" = "32" ]; then
	echo "CC := gcc -m32" >> config.mk
	echo "TARGET_ARCH := x86" >> config.mk
fi
if [ "$FBTRAVIS_COMPILER_DEBUG" = "1" ]; then
	echo "FBFLAGS += -g -exx" >> config.mk
	echo "CFLAGS += -g -Werror -DDEBUG" >> config.mk
else
	echo "CFLAGS += -Werror" >> config.mk
fi
make -j$(nproc) FBC="$bootstrap_package/bin/fbc -i $bootstrap_package/inc" </dev/null
mv bin/fbc bin/fbc1
make -j$(nproc) clean-compiler

# Rebuild fbc with itself
make -j$(nproc) compiler FBC='bin/fbc1 -i inc' </dev/null
rm bin/fbc1

# Run fbc tests
FBC_FOR_TESTS="$PWD/bin/fbc -i $PWD/inc"
if [ "$FBTRAVIS_TESTS_DEBUG" = "1" ]; then
	FBC_FOR_TESTS="$FBC_FOR_TESTS -g -exx"
fi

cd tests
make cunit-tests FBC="$FBC_FOR_TESTS" </dev/null
cd ..

cd tests
make log-tests FBC="$FBC_FOR_TESTS" </dev/null
cd ..
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

cd tests/warnings
FBC="$FBC_FOR_TESTS" ./test.sh </dev/null
cd ../..
git update-index -q --ignore-submodules --refresh
if ! git diff-files --quiet --ignore-submodules; then
	git diff
	exit 1
fi

# Build fbdoc tools
cd doc/libfbdoc
make FBC="$FBC_FOR_TESTS"
cd ../fbdoc
make FBC="$FBC_FOR_TESTS"
cd ../fbchkdoc
make FBC="$FBC_FOR_TESTS"
