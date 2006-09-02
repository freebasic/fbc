FreeBASIC Tests
===============

This is the directory for FreeBASIC compiler and runtime tests.

Requirements - Windows / Linux
------------------------------
   - FreeBASIC Compiler 0.17 or above
   - make, sh, find, xargs, grep, sed, cat
   - cunit (version?)

Requirements - Dos
------------------
   - FreeBASIC Compiler 0.17 or above
   - make, sh, find, xargs, grep, sed, cat
cunit is not necessary as there is an alternative method to
build the tests described in *Making the Tests*.

Summary
-------

All of the test making and reporting is done though a single
main makfile located in the top directory of the test tree.

use 'make' to get a list of the options available.


Making the Tests
----------------

Use 'make cunit-tests' to build the cunit-compatible tests.  This
will create fbc-tests[.exe] at the top of the tree.

If cunit is not already made, 'make cunit-tests' will automatically
make it with the options fail=1 basic=1.

Use 'make log-tests' to build all of the other tests.  This will
create log files, which are summarized and saved in 'failed.log'
for any failed tests.

Use 'make log-tests ALLOW_CUNIT=1' to build the cunit tests along
with the log-tests.  ALLOW_CUNIT=1 is slower than actually linking
with the cunit library, but will allow the tests to be run on DOS
systems.  (No support for cunit on dos as of this writing)

Use 'make failed-tests' to rebuild just those tests that failed on
in the last testing run.

Use 'make clean' to clean-up files, or to force the test package to
rescan directories for new or dropped test files.

Use 'make mostlyclean' to clean-up nearly all the files when it is
known that no tests have been added or dropped between test sessions.

If 'make log-tests ALLOW_CUNIT=1' was used to build the tests then
'make clean ALLOW_CUNIT=1' must be used to clean-up.


How the tests are written
-------------------------

Each source file should have one of the following test-modes present:

' One of:
' TEST_MODE : COMPILE_ONLY_OK
' TEST_MODE : COMPILE_ONLY_FAIL
' TEST_MODE : COMPILE_AND_RUN_OK
' TEST_MODE : COMPILE_AND_RUN_FAIL
' TEST_MODE : MULTI_MODULE_TEST

Files are scanned for these tags to bild of list of tests to perform,
the mothod to use when performing the test and the expected result.
Files that do not have one of the tags present may not get tests.

Mutli-module tests and encoded files
------------------------------------

Mult-module tests are composed of a '.bmk' file and several source
files.  For example:

# One of:
# TEST_MODE : MULTI_MODULE_OK
# TEST_MODE : MULTI_MODULE_FAIL
# TEST_MODE : CUNIT_COMPATIBLE

MAIN := my_test.bas
SRCS := my_test1.bas my_test2.bas my_test3.bas

# EOF

A '.bmk' can also be used to indicate the test type for a source file
that are not normally readable with various GNU based streams. For,
example UTF-32.  The '.bmk' is read only for the tag, and at testing
time, is substituted with '.bas'.


Files
-----

Makefile
   the main make fail for building tests and reporting results.  This 
   makefile makes use of other makefile (sub-makefiles) to get the
   job done.

dirlist.mk
   list of directories that to be testsed.  Edit this file when new
   directories are added to the testing tree.

cunit-tests.mk
   a sub-makefile for building cunit compatible tests

log-tests.mk
   a sub-makefile for building all other tests that are not cunit 
   compatible.

bmk-make.mk
   a sub-makefile for build a single executable.

common.mk
   some common variables needed by most other makefiles


cunit-tests.inc
   generated automatically when 'make cunit-tests' is invoked.
   Lists all of the cunit-compatible tests.

log-tests.inc
   generated automatically when 'make log-tests' is invoked.
   Lists all of the tests.

failed.log
   concatenation of all logs for each failed test.

