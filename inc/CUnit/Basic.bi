#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

enum CU_BasicRunMode
	CU_BRM_NORMAL = 0
	CU_BRM_SILENT
	CU_BRM_VERBOSE
end enum

declare function CU_basic_run_tests() as long
declare function CU_basic_run_suite(byval pSuite as CU_pSuite) as long
declare function CU_basic_run_test(byval pSuite as CU_pSuite, byval pTest as CU_pTest) as long
declare sub CU_basic_set_mode(byval mode as long)
declare function CU_basic_get_mode() as long
declare sub CU_basic_show_failures(byval pFailure as CU_pFailureRecord)

end extern
