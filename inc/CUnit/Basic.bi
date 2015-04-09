'' FreeBASIC binding for CUnit-2.1-3

#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

#define CUNIT_BASIC_H_SEEN

type CU_BasicRunMode as long
enum
	CU_BRM_NORMAL = 0
	CU_BRM_SILENT
	CU_BRM_VERBOSE
end enum

declare function CU_basic_run_tests() as CU_ErrorCode
declare function CU_basic_run_suite(byval pSuite as CU_pSuite) as CU_ErrorCode
declare function CU_basic_run_test(byval pSuite as CU_pSuite, byval pTest as CU_pTest) as CU_ErrorCode
declare sub CU_basic_set_mode(byval mode as CU_BasicRunMode)
declare function CU_basic_get_mode() as CU_BasicRunMode
declare sub CU_basic_show_failures(byval pFailure as CU_pFailureRecord)

end extern
