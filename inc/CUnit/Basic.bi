''
''
'' Basic -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_Basic_bi__
#define __CUnit_Basic_bi__

#include once "CUnit/CUnit.bi"
#include once "CUnit/TestDB.bi"

extern "C"

enum CU_BasicRunMode
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

#endif
