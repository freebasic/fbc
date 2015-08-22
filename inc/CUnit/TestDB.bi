'' FreeBASIC binding for CUnit-2.1-3
''
'' based on the C header files:
''   CUnit - A Unit testing framework library for C.
''   Copyright (C) 2001       Anil Kumar
''   Copyright (C) 2004-2006  Anil Kumar, Jerry St.Clair
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301  USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/setjmp.bi"
#include once "CUnit.bi"
#include once "CUError.bi"

'' The following symbols have been renamed:
''     #define CU_ADD_TEST => CU_ADD_TEST_

extern "C"

#define CUNIT_TESTDB_H_SEEN
type CU_InitializeFunc as function() as long
type CU_CleanupFunc as function() as long
type CU_TestFunc as sub()
type CU_SetUpFunc as sub()
type CU_TearDownFunc as sub()

type CU_Test
	pName as zstring ptr
	fActive as long
	pTestFunc as CU_TestFunc
	pJumpBuf as jmp_buf ptr
	pNext as CU_Test ptr
	pPrev as CU_Test ptr
end type

type CU_pTest as CU_Test ptr

type CU_Suite
	pName as zstring ptr
	fActive as long
	pTest as CU_pTest
	pInitializeFunc as CU_InitializeFunc
	pCleanupFunc as CU_CleanupFunc
	pSetUpFunc as CU_SetUpFunc
	pTearDownFunc as CU_TearDownFunc
	uiNumberOfTests as ulong
	pNext as CU_Suite ptr
	pPrev as CU_Suite ptr
	uiNumberOfTestsFailed as ulong
	uiNumberOfTestsSuccess as ulong
end type

type CU_pSuite as CU_Suite ptr

type CU_TestRegistry
	uiNumberOfSuites as ulong
	uiNumberOfTests as ulong
	pSuite as CU_pSuite
end type

type CU_pTestRegistry as CU_TestRegistry ptr
declare function CU_initialize_registry() as CU_ErrorCode
declare sub CU_cleanup_registry()
declare function CU_registry_initialized() as long
declare function CU_add_suite(byval strName as const zstring ptr, byval pInit as CU_InitializeFunc, byval pClean as CU_CleanupFunc) as CU_pSuite
declare function CU_add_suite_with_setup_and_teardown(byval strName as const zstring ptr, byval pInit as CU_InitializeFunc, byval pClean as CU_CleanupFunc, byval pSetup as CU_SetUpFunc, byval pTear as CU_TearDownFunc) as CU_pSuite
declare function CU_set_suite_active(byval pSuite as CU_pSuite, byval fNewActive as long) as CU_ErrorCode
declare function CU_set_suite_name(byval pSuite as CU_pSuite, byval strNewName as const zstring ptr) as CU_ErrorCode
declare function CU_set_suite_initfunc(byval pSuite as CU_pSuite, byval pNewInit as CU_InitializeFunc) as CU_ErrorCode
declare function CU_set_suite_cleanupfunc(byval pSuite as CU_pSuite, byval pNewClean as CU_CleanupFunc) as CU_ErrorCode
declare function CU_get_suite(byval strName as const zstring ptr) as CU_pSuite
declare function CU_get_suite_at_pos(byval pos as ulong) as CU_pSuite
declare function CU_get_suite_pos(byval pSuite as CU_pSuite) as ulong
declare function CU_get_suite_pos_by_name(byval strName as const zstring ptr) as ulong
declare function CU_add_test(byval pSuite as CU_pSuite, byval strName as const zstring ptr, byval pTestFunc as CU_TestFunc) as CU_pTest
declare function CU_set_test_active(byval pTest as CU_pTest, byval fNewActive as long) as CU_ErrorCode
declare function CU_set_test_name(byval pTest as CU_pTest, byval strNewName as const zstring ptr) as CU_ErrorCode
declare function CU_set_test_func(byval pTest as CU_pTest, byval pNewFunc as CU_TestFunc) as CU_ErrorCode
declare function CU_get_test(byval pSuite as CU_pSuite, byval strName as const zstring ptr) as CU_pTest
declare function CU_get_test_at_pos(byval pSuite as CU_pSuite, byval pos as ulong) as CU_pTest
declare function CU_get_test_pos(byval pSuite as CU_pSuite, byval pTest as CU_pTest) as ulong
declare function CU_get_test_pos_by_name(byval pSuite as CU_pSuite, byval strName as const zstring ptr) as ulong
#define CU_ADD_TEST_(suite, test) CU_add_test(suite, #test, cast(CU_TestFunc, test))

type CU_TestInfo
	pName as const zstring ptr
	pTestFunc as CU_TestFunc
end type

type CU_pTestInfo as CU_TestInfo ptr

type CU_SuiteInfo
	pName as const zstring ptr
	pInitFunc as CU_InitializeFunc
	pCleanupFunc as CU_CleanupFunc
	pSetUpFunc as CU_SetUpFunc
	pTearDownFunc as CU_TearDownFunc
	pTests as CU_TestInfo ptr
end type

type CU_pSuiteInfo as CU_SuiteInfo ptr
#define CU_TEST_INFO_NULL (NULL, NULL)
#define CU_SUITE_INFO_NULL (NULL, NULL, NULL, NULL, NULL, NULL)
declare function CU_register_suites(byval suite_info as CU_SuiteInfo ptr) as CU_ErrorCode
declare function CU_register_nsuites(byval suite_count as long, ...) as CU_ErrorCode
declare function CU_get_registry() as CU_pTestRegistry
declare function CU_set_registry(byval pTestRegistry as CU_pTestRegistry) as CU_pTestRegistry
declare function CU_create_new_registry() as CU_pTestRegistry
declare sub CU_destroy_existing_registry(byval ppRegistry as CU_pTestRegistry ptr)
declare function CU_get_suite_by_name(byval szSuiteName as const zstring ptr, byval pRegistry as CU_pTestRegistry) as CU_pSuite
declare function CU_get_suite_by_index(byval index as ulong, byval pRegistry as CU_pTestRegistry) as CU_pSuite
declare function CU_get_test_by_name(byval szTestName as const zstring ptr, byval pSuite as CU_pSuite) as CU_pTest
declare function CU_get_test_by_index(byval index as ulong, byval pSuite as CU_pSuite) as CU_pTest

end extern
