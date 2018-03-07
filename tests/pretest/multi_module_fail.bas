
' TEST_MODE : MULTI_MODULE_TEST

/'
	MULTI_MODULE_TEST tag indicates that this file is
	tested as part of the log-tests.mk testing method
	and will need a .bmk makefile to specify the files
	needed in the test.

	Expected results:
		1) compile successfully using multi_module_fail.bmk
		   makefile.  log-tests.mk should automatically
		   recognize this a multi-module test due the
		   presence of the .bmk file
		2) execute and fail at run-time on assertion 
		   and return non-zero exit code
		3) reported as success by log-tests.mk 
'/

#include "multi_module_subs.bi"

TestFail()

