#!/bin/bash
#
# This runs fbc on all the .bas files in this directory and captures fbc's
# output into corresponding .txt files. This is done for multiple compilation
# targets, which can produce different test results (e.g. due to 32bit vs 64bit
# differences or because sizeof(wstring) depends on the OS).
#
# fbc's output is being run through a sed replace to strip out the
# filename.bas(linenumber) part. This way we get the plain warning message only,
# and there won't be unnecessary changes due to changing line numbers when
# adding test cases, etc.
#
# The *.txt files are included in the Git repo, so Git can be used to check for
# problems such as missing or duplicate warnings.
#
# The test cases themselves use #print to indicate where warnings should appear,
# which allows checking the test results in detail.
#

FBC=`printenv FBC`
FBC=${FBC:-fbc}

function run_tests() {
	fbtarget="$1"
	txtdir=r/$fbtarget

	mkdir -p $txtdir
	rm -f $txtdir/*

	for i in *.bas; do
		echo "TEST $fbtarget $i"
		withoutext=${i%.bas}

		$FBC -maxerr inf -w constness -target $fbtarget $i -r -m $withoutext | \
			sed -e 's,^.*\.\(bas\|bi\)(.*) warning .*(.*): ,\t,g' > \
			$txtdir/$withoutext.txt
	done

	rm -f *.asm *.c

	# Change *.txt files over to CRLF on Windows (MSYS sed produces LF...)
	case `uname` in
	*MINGW*)
		unix2dos -q $txtdir/*
	esac
}

run_tests dos
run_tests linux-x86
run_tests linux-x86_64
run_tests win32
run_tests win64
