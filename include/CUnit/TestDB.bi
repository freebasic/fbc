''
''
'' TestDB -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_TestDB_bi__
#define __CUnit_TestDB_bi__

#include once "crt/setjmp.bi"
#include once "CUnit/CUnit.bi"
#include once "CUnit/CUError.bi"

type CU_InitializeFunc as function cdecl() as integer
type CU_CleanupFunc as function cdecl() as integer
type CU_TestFunc as sub cdecl()

type CU_Test_
	pName as zstring ptr
	pTestFunc as CU_TestFunc
	pJumpBuf as jmp_buf ptr
	pNext as CU_Test_ ptr
	pPrev as CU_Test_ ptr
end type

type CU_pTest as CU_Test_ ptr

type CU_Suite
	pName as zstring ptr
	pTest as CU_pTest
	pInitializeFunc as CU_InitializeFunc
	pCleanupFunc as CU_CleanupFunc
	uiNumberOfTests as uinteger
	pNext as CU_Suite ptr
	pPrev as CU_Suite ptr
end type

type CU_pSuite as CU_Suite ptr

type CU_TestRegistry
	uiNumberOfSuites as uinteger
	uiNumberOfTests as uinteger
	pSuite as CU_pSuite
end type

type CU_pTestRegistry as CU_TestRegistry ptr

declare function CU_initialize_registry cdecl alias "CU_initialize_registry" () as CU_ErrorCode
declare sub CU_cleanup_registry cdecl alias "CU_cleanup_registry" ()
declare function CU_registry_initialized cdecl alias "CU_registry_initialized" () as integer
declare function CU_add_suite cdecl alias "CU_add_suite" (byval strName as zstring ptr, byval pInit as CU_InitializeFunc, byval pClean as CU_CleanupFunc) as CU_pSuite
declare function CU_add_test cdecl alias "CU_add_test" (byval pSuite as CU_pSuite, byval strName as zstring ptr, byval pTestFunc as CU_TestFunc) as CU_pTest

#define CU_ADD_TEST_(suite, test) CU_add_test(suite, #test, cast(CU_TestFunc,test))

type CU_TestInfo
	pName as zstring ptr
	pTestFunc as CU_TestFunc
end type

type CU_pTestInfo as CU_TestInfo ptr

type CU_SuiteInfo
	pName as zstring ptr
	pInitFunc as CU_InitializeFunc
	pCleanupFunc as CU_CleanupFunc
	pTests as CU_TestInfo ptr
end type

type CU_pSuiteInfo as CU_SuiteInfo ptr

declare function CU_register_suites cdecl alias "CU_register_suites" (byval suite_info as CU_SuiteInfo ptr) as CU_ErrorCode
declare function CU_register_nsuites cdecl alias "CU_register_nsuites" (byval suite_count as integer, ...) as CU_ErrorCode
declare function CU_get_registry cdecl alias "CU_get_registry" () as CU_pTestRegistry
declare function CU_set_registry cdecl alias "CU_set_registry" (byval pTestRegistry as CU_pTestRegistry) as CU_pTestRegistry
declare function CU_create_new_registry cdecl alias "CU_create_new_registry" () as CU_pTestRegistry
declare sub CU_destroy_existing_registry cdecl alias "CU_destroy_existing_registry" (byval ppRegistry as CU_pTestRegistry ptr)
declare function CU_get_suite_by_name cdecl alias "CU_get_suite_by_name" (byval szSuiteName as zstring ptr, byval pRegistry as CU_pTestRegistry) as CU_pSuite
declare function CU_get_test_by_name cdecl alias "CU_get_test_by_name" (byval szTestName as zstring ptr, byval pSuite as CU_pSuite) as CU_pTest

#endif
