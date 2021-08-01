FreeBASIC Tests
===============

This is the directory for FreeBASIC compiler and runtime tests.

Requirements - Windows / Linux / Dos
------------------------------------
   - FreeBASIC Compiler 1.06.0 or above
   - a build environment with common *nix commands available
     on the path
   - make, sh, find, xargs, grep, sed, cat, rm


Summary
-------

All of the tests are made and the results reported though a single
main makefile located in the top directory of the test tree.

use 'make' to get a list of the options available.


Making the Tests
----------------

The following two commands will make all tests:

$ make unit-tests
   generates fbc-tests[.exe]

$ make log-tests
   generates failed-test-fb.log
   generates failed-test-fblite.log
   generates failed-test-qb.log
   generates failed-test-deprecated.log
   if all tests passed, the log file reports "None found"

Other Examples:

Use 'make unit-tests' to build the fbcunit-compatible tests.  This
will create fbc-tests[.exe] at the top of the tree.

If the fbcunit library is not already made, 'make unit-tests' 
will automatically make it.

Use 'make log-tests' to build all non-fbcunit type tests.  This will
create log files, which are summarized and saved in 'failed.log'
for any failed tests.

Use 'make failed-tests' to rebuild just those tests that failed in
the last testing session using 'make log-tests'.

Use 'make clean' to clean-up files, or to force the test package to
rescan directories for new or dropped test files.

Use 'make mostlyclean' to clean-up nearly all the files when it is
known that no tests have been added or dropped between test sessions.

Use 'make log-tests FB_LANG=fb | fblite | qb | deprecated' to make a specific
set of -lang tests.


Options
-------
OS=DOS
   Indicate that test suite is being built under a djgpp environment

FBC=/path/fbc
   Specify the location of the fbc compiler

FB_LANG=fb | fblite | qb | deprecated
   Specify the compiler dialect

DEBUG=1
   Adds '-g' option to add debugging information.

EXTRAERR=1
   Adds '-exx' option to add extra error checking.

ARCH=486
   Adds '-arch ARCH' option when compiling tests.

TARGET=arch-os-variant
   Adds '-target TARGET' option when compiling tests. This is used
   for cross-compiling; normally you pass a binutils target triplet.

FPU=FPU|SSE
   Adds '-fpu FPU|SSE' option when compiling tests.

ENABLE_CHECK_BUGS=1
   Adds '-d ENABLE_CHECK_BUGS=1' when compiling tests. This is used
   enable additional tests for known bugs that are not yet fixed.

ENABLE_CONSOLE_OUTPUT=1
   Add '-d ENABLE_CONSOLE_OUTPUT' when compiling tests. This is used
   to turn on printing output to the console.


How the tests are collected
---------------------------

All of the directories listed in 'dirlist.mk' in the makefile
variable $(DIRLIST) are scanned for files with the extension
'.bmk' or '.bas'.  When matching filenames are found, the contents
of the file is then scanned to determine the method of testing
needed for that specific file. For adding tests in new folders
manually add the new folder names in dirlist.mk.

This scan autogenerates "unit-tests.inc", which holds all files to be 
included in unit-tests.

For forcing a rescan you should run "make clean", which will remove all
files resulting from previous runs and leave a cleaned tests environment.

By default '-lang fb' tests are collected unless 'FB_LANG=?' option
is given.


fbcunit tests (unit-tests)
------------------------------

fbcunit compatible tests are linked with the fbcunit
library and most follow a structure as shown in the following
example:

Sample FBCUNIT compatible test (using SUITE/TEST macros)

   ' TEST_MODE : FBCUNIT_COMPATIBLE

   #include "fbcunit.bi"
   SUITE( pretest )
      TEST( test_true )
          CU_ASSERT_TRUE( true ) 
      END_TEST
   END_SUITE
   ' EOF


Sample FBCUNIT compatible test (using the 'old' way)

   ' TEST_MODE : FBCUNIT_COMPATIBLE

   #include "fbcunit.bi"

   namespace fbc_tests.pretest

   sub test_true cdecl ()
     CU_ASSERT_TRUE( true )
   end sub

   private sub ctor () constructor

     fbcu.add_suite("fbc_tests.pretest")
     fbcu.add_test("test_true", @test_true)

   end sub

   end namespace
   ' EOF

Consult the fbcunit documentation for a listing of available
assertions and testing methods (tests\fbcunit\inc\fbcunit.bi).


non-unit compatible test (log-tests)
-------------------------------------

Each non-fbcunit compatible test should have one of the following 
test-mode tags present in the source file:

' One of:
' TEST_MODE : COMPILE_ONLY_OK
' TEST_MODE : COMPILE_ONLY_FAIL
' TEST_MODE : COMPILE_AND_RUN_OK
' TEST_MODE : COMPILE_AND_RUN_FAIL
' TEST_MODE : MULTI_MODULE_TEST

Files are scanned for these tags to build of list of tests to perform,
the method to use when performing the test and the expected result.
Files that do not have one of the tags present may not get tested.


Mutli-module tests and encoded files
------------------------------------

Mult-module tests are composed of a '.bmk' file and several source
files.  An example .bmk file:

# One of:
# TEST_MODE : MULTI_MODULE_OK
# TEST_MODE : MULTI_MODULE_FAIL
# TEST_MODE : FBCUNIT_COMPATIBLE

MAIN := my_test.bas
SRCS := my_test1.bas my_test2.bas my_test3.bas

# EOF

Use a '.bmk' file to link modules compiled by other compilers, e.g.
C/C++. To do that just define a list of .o files as EXTRA_OBJS, and
provide build rules for those files. See e.g. namespace/cpp/cpp.bmk.

A '.bmk' can also be used to indicate the test type for a source file
that is not normally readable with various GNU based streams. For,
example UTF-32.  The '.bmk' is read only for the tag, and at testing
time, is substituted with '.bas'.


Files
-----

Makefile
   the main makefile for building tests and reporting results.  This 
   makefile makes use of other makefile (sub-makefiles) to get the
   job done.

dirlist.mk
   list of directories that to be testsed.  Edit this file when new
   directories are added to the testing tree.

unit-tests.mk
   a sub-makefile for building fbcunit compatible tests

log-tests.mk
   a sub-makefile for building all other tests that are not fbcunit 
   compatible.

bmk-make.mk
   a sub-makefile for building a single executable.

common.mk
   some common variables needed by most other makefiles

unit-tests.inc
   generated automatically when 'make unit-tests' is invoked.
   Lists all of the fbcunit-compatible tests.

log-tests.inc
   generated automatically when 'make log-tests' is invoked.
   Lists all of the tests.

failed.log
   a summary of the test results for all failed tests.  To get more
   information on a specific failed test, view the '.log' saved in
   the same directory as the test file.

const/generator
   helper program and database to generate and check const type tests

optimizations\generator
   helper program to create extensive 'math-torture-*.bas' tests

check-suite-names.sh
   maintenance tool to test that SUITE() names in basic source files are
   named in an expected way.  Test suite names should match the
   directory/filename.bas where they are written.  See comments in the bash
   script for more information on the method used.

## EOF
