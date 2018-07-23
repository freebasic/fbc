
' TEST_MODE : MULTI_MODULE_TEST

#include "multi_module_subs.bi"

/'
	MULTI_MODULE_TEST tag indicates that this file is
	tested as part of the log-tests.mk testing method
	and will need a .bmk makefile to specify the files
	needed in the test.

	Used in the multi-module tests:
		- multi_module_fail.bmk
		- multi_module_ok.bmk
'/

public sub TestOK()
  assert(0=0)
end sub

public sub TestFail()
  assert (1=0)
end sub
