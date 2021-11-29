#!/bin/bash
# check that test suites name in basic source files match the directory/file name
#
# given 'directory/filename.bas', the format for the suite name in the basic
# source file should be:
#   SUITE( fbc_tests.directory.filename )
#
# For conversion of dir/file to suite.name
# 1) valid filenames should contain only characters 
#    'a-z', 'A-Z', '0-9', '_', '-' 
# 2) '.bas' file extension is dropped
# 3) hyphen '-' characters in directory/filename are replaced
#    with underscore '_'
# 4) if the directory.filename conflicts with a fbc keyword, i.e. compile error, 
#    an underscore '_' suffix is added
#

# temporary filename prefix
tmpfile="suite-names-"

usage () {
	echo "usage: $0 command"
	echo
	echo "command:"
	echo "   check    perform the name checks, requires 'grep' and 'sed'"
	echo "            temporary files ${tmpfile}?.lst will be created"
	echo "            results are output to stdout"
	echo "   clean    clean-up temporary files (if script aborted)"
	echo "   list-utf list all unicode encoded files based on git"
	echo
	echo "exit code:"
	echo "   0 = suite names match dir/file - no mismatches found"
	echo "   1 = mismatches found"
	echo
	exit 1 
}

do_clean () {
	rm -f ${tmpfile}1.lst ${tmpfile}2.lst ${tmpfile}3.lst ${tmpfile}4.lst ${tmpfile}5.lst  
}

do_check () {

	# search for *.bas files containing SUITE lines (ignore case)
	# output from grep expected to be './dir/file.bas:line:SUITE( fbc_tests.dir.file)'
	# note that the pattern contains a literal tab character

	# !!!FIXME!!! - grep does not search the utf encoded file	

	grep -i -r -n --include=*.bas --exclude-dir=fbcunit -e '^[ 	]*SUITE.*(.*).*$' . > ${tmpfile}1.lst 

	# extract dir/file and dir.file from previous output
	# write to a new file in the format 'dir1:file1:dir2:file2:original-grep-match'
	sed ${tmpfile}1.lst  -e 's/\.\/\([-A-Za-z0-9_]*\)\/\([-A-Za-z0-9_]*\)\.bas:[0-9]*:SUITE([ ]*fbc_tests\.\([A-Za-z0-9_]*\)\.\([A-Za-z0-9_]*\)[ ]*)/\1:\2:\3:\4:\0/' > ${tmpfile}2.lst

	# replace all '-' with '_'
	sed ${tmpfile}2.lst -e 's/-/_/g' > ${tmpfile}3.lst

	# compare dir1[_]?==dir2 and file1[_]?==file2 and replace with empty line
	sed ${tmpfile}3.lst -e 's/\([A-Za-z0-9_]*\):\([A-Za-z0-9_]*\):\1_*:\2_*:\(.*\)//' > ${tmpfile}4.lst

	# strip out empty line, remaining lines should be the ones originally found by grep not matching
	# output to stdout
	sed ${tmpfile}4.lst -n -e '/^..*$/p' > ${tmpfile}5.lst
	
	# test if the last file generated was not empty - if it was not empty then
	# mismatched directory/filename.bas and suite names were found
	if [ -s ${tmpfile}5.lst ]; then
		cat ${tmpfile}5.lst 
		return_val=1
	else
		return_val=0
	fi 

	# clean-up all the temp files before we exit
	do_clean
	
	# return 0=no mismatches found
	#        1=mismatches found
	exit ${return_val}
}

do_list_utf () {
	# search the current git repo and list all files that appear to be unicode
	#
	# git diff `git hash-object -t tree /dev/null` --numstat origin/master -- '*.bas' '*.bi' | grep '^\-'
	#
	# `git hash-object -t tree /dev/null`
	# this is a known object name, so we can just write it out
	# windows has trouble with the /dev/null in a script (but not from the shell prompt)
	emptytree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
	
	git diff $emptytree HEAD --numstat -- '*.bas' '*.bi' | grep '^\-'
}

case "$1" in
check)
	do_check
	;;
list-utf)
	do_list_utf
	;;
clean)
	do_clean
	exit 0
	;;
esac

usage
