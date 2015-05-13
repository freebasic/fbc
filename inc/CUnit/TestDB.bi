#pragma once

#include once "crt/setjmp.bi"
#include once "CUnit.bi"
#include once "CUError.bi"

extern "C"

type CU_InitializeFunc as function() as long
type CU_CleanupFunc as function() as long
type CU_TestFunc as sub()

type CU_Test_
	pName as zstring ptr
	fActive as long
	pTestFunc as CU_TestFunc
	pJumpBuf as jmp_buf ptr
	pNext as CU_Test_ ptr
	pPrev as CU_Test_ ptr
end type

type CU_pTest as CU_Test_ ptr

type CU_Suite
	pName as zstring ptr
	fActive as long
	pTest as CU_pTest
	pInitializeFunc as CU_InitializeFunc
	pCleanupFunc as CU_CleanupFunc
	uiNumberOfTests as ulong
	pNext as CU_Suite ptr
	pPrev as CU_Suite ptr
end type

type CU_pSuite as CU_Suite ptr

type CU_TestRegistry
	uiNumberOfSuites as ulong
	uiNumberOfTests as ulong
	pSuite as CU_pSuite
end type

type CU_pTestRegistry as CU_TestRegistry ptr

declare function CU_initialize_registry() as long
declare sub CU_cleanup_registry()
declare function CU_registry_initialized() as long
declare function CU_add_suite(byval strName as const zstring ptr, byval pInit as CU_InitializeFunc, byval pClean as CU_CleanupFunc) as CU_pSuite
declare function CU_set_suite_active(byval pSuite as CU_pSuite, byval fNewActive as long) as long
declare function CU_set_suite_name(byval pSuite as CU_pSuite, byval strNewName as const zstring ptr) as long
declare function CU_set_suite_initfunc(byval pSuite as CU_pSuite, byval pNewInit as CU_InitializeFunc) as long
declare function CU_set_suite_cleanupfunc(byval pSuite as CU_pSuite, byval pNewClean as CU_CleanupFunc) as long
declare function CU_get_suite(byval strName as const zstring ptr) as CU_pSuite
declare function CU_get_suite_at_pos(byval pos as ulong) as CU_pSuite
declare function CU_get_suite_pos(byval pSuite as CU_pSuite) as ulong
declare function CU_get_suite_pos_by_name(byval strName as const zstring ptr) as ulong
declare function CU_add_test(byval pSuite as CU_pSuite, byval strName as const zstring ptr, byval pTestFunc as CU_TestFunc) as CU_pTest
declare function CU_set_test_active(byval pTest as CU_pTest, byval fNewActive as long) as long
declare function CU_set_test_name(byval pTest as CU_pTest, byval strNewName as const zstring ptr) as long
declare function CU_set_test_func(byval pTest as CU_pTest, byval pNewFunc as CU_TestFunc) as long
declare function CU_get_test(byval pSuite as CU_pSuite, byval strName as const zstring ptr) as CU_pTest
declare function CU_get_test_at_pos(byval pSuite as CU_pSuite, byval pos as ulong) as CU_pTest
declare function CU_get_test_pos(byval pSuite as CU_pSuite, byval pTest as CU_pTest) as ulong
declare function CU_get_test_pos_by_name(byval pSuite as CU_pSuite, byval strName as const zstring ptr) as ulong

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

#define CU_TEST_INFO_NULL (NULL, NULL)
#define CU_SUITE_INFO_NULL (NULL, NULL, NULL, NULL)

declare function CU_register_suites(byval suite_info as CU_SuiteInfo ptr) as long
declare function CU_register_nsuites(byval suite_count as long, ...) as long
declare function CU_get_registry() as CU_pTestRegistry
declare function CU_set_registry(byval pTestRegistry as CU_pTestRegistry) as CU_pTestRegistry
declare function CU_create_new_registry() as CU_pTestRegistry
declare sub CU_destroy_existing_registry(byval ppRegistry as CU_pTestRegistry ptr)
declare function CU_get_suite_by_name(byval szSuiteName as const zstring ptr, byval pRegistry as CU_pTestRegistry) as CU_pSuite
declare function CU_get_suite_by_index(byval index as ulong, byval pRegistry as CU_pTestRegistry) as CU_pSuite
declare function CU_get_test_by_name(byval szTestName as const zstring ptr, byval pSuite as CU_pSuite) as CU_pTest
declare function CU_get_test_by_index(byval index as ulong, byval pSuite as CU_pSuite) as CU_pTest

end extern
