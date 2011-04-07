FreeBASIC Tests
===============

This is the directory for FreeBASIC compiler and runtime tests.

Requirements - Windows / Linux / Dos
------------------------------------
   - FreeBASIC Compiler 0.20.0 or above
   - make, sh, find, xargs, grep, sed, cat, rm

Summary
-------

All of the tests are made and the results reported though a single
main makefile located in the top directory of the test tree.

use 'make' to get a list of the options available.


Making the Tests
----------------

The following two commands will make all tests:

make cunit-tests
   generates fbc-tests[.exe]

make log-tests
   generates failed-test-fb.log
   generates failed-test-qb.log
   generates failed-test-deprecated.log
   if all tests passed, the log file reports "None found"

Other Examples:

Use 'make cunit-tests' to build the cunit-compatible tests.  This
will create fbc-tests[.exe] at the top of the tree.

If the fbcu library is not already made, 'make cunit-tests' 
will automatically make it with the options fail=1 basic=1.

Use 'make log-tests' to build all non-cunit type tests.  This will
create log files, which are summarized and saved in 'failed.log'
for any failed tests.

Use 'make log-tests ALLOW_CUNIT=1' to build the cunit tests along
with the log-tests.  ALLOW_CUNIT=1 is slower than actually linking
with the fbcu/cunit library, but should allow tests to be run
without needing the libcunit.a library.

When 'ALLOW_CUNIT=1' is used, fbcu/fake/fbcu.bi is used as a
replacement for fbcu/include/fbcu.bi.  This alternate include file
may be needed for building the tests under DOS.

Use 'make failed-tests' to rebuild just those tests that failed in
the last testing session using 'make log-tests'.

Use 'make clean' to clean-up files, or to force the test package to
rescan directories for new or dropped test files.

Use 'make mostlyclean' to clean-up nearly all the files when it is
known that no tests have been added or dropped between test sessions.

If 'make log-tests ALLOW_CUNIT=1' was used to build the tests then
'make clean ALLOW_CUNIT=1' must be used to clean-up.

Use 'make log-tests FB_LANG=fb | qb | deprecated' to make a specific
set of -lang tests.


Options
-------
OS=DOS
   Indicate that test suite is being built under a djgpp environment

FBC=/path/fbc
   Specify the location of the fbc compiler

FB_LANG=fb | qb | deprecated
   Specify the compiler dialect

DEBUG=1
   Adds '-g' option to add debugging information.

EXTRAERR=1
   Adds '-exx' option to add extra error checking.

ARCH=486
   Adds '-arch ARCH' option when compiling tests.

FPU=FPU|SSE
   Adds '-fpu FPU|SSE' option when compiling tests.


How the tests are collected
---------------------------

All of the directories listed in 'dirlist.mk' in the makefile
variable $(DIRLIST) are scanned for files with the extension
'.bmk' or '.bas'.  When matching filenames are found, the contents
of the file is then scanned to determine the method of testing
needed for that specific file.

By default '-lang fb' tests are collected unless 'FB_LANG=?' option
is given.


fbcu/cunit tests (cunit-tests)
------------------------------

fbcu/cunit compatible tests are linked with the fbcu and cunit
libraries and most follow a structure as shown in the following
example:

Sample FBCU/CUNIT compatible test

   ' TEST_MODE : CUNIT_COMPATIBLE

   #include "fbcu.bi"

   namespace fbc_tests.pretest

   sub test_true cdecl ()
     CU_ASSERT_TRUE( -1 )
   end sub

   private sub ctor () constructor

     fbcu.add_suite("fb-tests-cunit-pretests")
     fbcu.add_test("test_true", @test_true)

   end sub

   end namespace
   ' EOF

Consult the cunit documentation for a listing of available
assertions and testing methods.


non-cunit compatible test (log-tests)
-------------------------------------

Each non-fbcu/cunit compatible test should have one of the following 
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
# TEST_MODE : CUNIT_COMPATIBLE

MAIN := my_test.bas
SRCS := my_test1.bas my_test2.bas my_test3.bas

# EOF

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

cunit-tests.mk
   a sub-makefile for building cunit compatible tests

log-tests.mk
   a sub-makefile for building all other tests that are not cunit 
   compatible.

bmk-make.mk
   a sub-makefile for building a single executable.

common.mk
   some common variables needed by most other makefiles

cunit-tests.inc
   generated automatically when 'make cunit-tests' is invoked.
   Lists all of the cunit-compatible tests.

log-tests.inc
   generated automatically when 'make log-tests' is invoked.
   Lists all of the tests.

failed.log
   a summary of the test results for all failed tests.  To get more
   information on a specific failed test, view the '.log' saved in
   the same directory as the test file.


How to make libcunit.a on DOS
-----------------------------
I had some trouble using the usual configure/make scipts and wrote
this makefile for dos to compile the cunit library.

## get and unzip CUnit-2.1-0-src.zip
##
## place this makefile in Cunit-2.1-0/cunit
## and save as 'makefile.dos'.  
## Then build libcunit.a by running
##   'make -f makefile.dos'
##
## Finally, 
##    copy libcunit.a to FreeBASIC/lib/dos

RM = rm
AR = ar
GCC = gcc

SRCS := Sources/Automated/Automated.c
SRCS += Sources/Basic/Basic.c
SRCS += Sources/Console/Console.c
SRCS += Sources/Framework/CUError.c
SRCS += Sources/Framework/MyMem.c
SRCS += Sources/Framework/TestDB.c
SRCS += Sources/Framework/TestRun.c
SRCS += Sources/Framework/Util.c

OBJS := $(patsubst %.c,%.o,$(SRCS))

LIBNAME = libcunit.a

%.o : %.c
	$(GCC) -c $< -I./Headers -o $@

all: $(LIBNAME)

$(LIBNAME): $(OBJS)
	$(AR) cru $(LIBNAME) $(OBJS)

.PHONY: clean
clean:
	$(RM) -f $(OBJS)
	$(RM) -f $(LIBNAME)

## EOF
