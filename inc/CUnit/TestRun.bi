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

#include once "CUnit.bi"
#include once "CUError.bi"
#include once "TestDB.bi"
#include once "crt/stdio.bi"

extern "C"

#define CUNIT_TESTRUN_H_SEEN

type CU_FailureTypes as long
enum
	CUF_SuiteInactive = 1
	CUF_SuiteInitFailed
	CUF_SuiteCleanupFailed
	CUF_TestInactive
	CUF_AssertFailed
end enum

type CU_FailureType as CU_FailureTypes

type CU_FailureRecord
	as CU_FailureType type
	uiLineNumber as ulong
	strFileName as zstring ptr
	strCondition as zstring ptr
	pTest as CU_pTest
	pSuite as CU_pSuite
	pNext as CU_FailureRecord ptr
	pPrev as CU_FailureRecord ptr
end type

type CU_pFailureRecord as CU_FailureRecord ptr

type CU_RunSummary
	PackageName as zstring * 50
	nSuitesRun as ulong
	nSuitesFailed as ulong
	nSuitesInactive as ulong
	nTestsRun as ulong
	nTestsFailed as ulong
	nTestsInactive as ulong
	nAsserts as ulong
	nAssertsFailed as ulong
	nFailureRecords as ulong
	ElapsedTime as double
end type

type CU_pRunSummary as CU_RunSummary ptr
type CU_SuiteStartMessageHandler as sub(byval pSuite as const CU_pSuite)
type CU_TestStartMessageHandler as sub(byval pTest as const CU_pTest, byval pSuite as const CU_pSuite)
type CU_TestCompleteMessageHandler as sub(byval pTest as const CU_pTest, byval pSuite as const CU_pSuite, byval pFailure as const CU_pFailureRecord)
type CU_SuiteCompleteMessageHandler as sub(byval pSuite as const CU_pSuite, byval pFailure as const CU_pFailureRecord)
type CU_AllTestsCompleteMessageHandler as sub(byval pFailure as const CU_pFailureRecord)
type CU_SuiteInitFailureMessageHandler as sub(byval pSuite as const CU_pSuite)
type CU_SuiteCleanupFailureMessageHandler as sub(byval pSuite as const CU_pSuite)

declare sub CU_set_suite_start_handler(byval pSuiteStartMessage as CU_SuiteStartMessageHandler)
declare sub CU_set_test_start_handler(byval pTestStartMessage as CU_TestStartMessageHandler)
declare sub CU_set_test_complete_handler(byval pTestCompleteMessage as CU_TestCompleteMessageHandler)
declare sub CU_set_suite_complete_handler(byval pSuiteCompleteMessage as CU_SuiteCompleteMessageHandler)
declare sub CU_set_all_test_complete_handler(byval pAllTestsCompleteMessage as CU_AllTestsCompleteMessageHandler)
declare sub CU_set_suite_init_failure_handler(byval pSuiteInitFailureMessage as CU_SuiteInitFailureMessageHandler)
declare sub CU_set_suite_cleanup_failure_handler(byval pSuiteCleanupFailureMessage as CU_SuiteCleanupFailureMessageHandler)
declare function CU_get_suite_start_handler() as CU_SuiteStartMessageHandler
declare function CU_get_test_start_handler() as CU_TestStartMessageHandler
declare function CU_get_test_complete_handler() as CU_TestCompleteMessageHandler
declare function CU_get_suite_complete_handler() as CU_SuiteCompleteMessageHandler
declare function CU_get_all_test_complete_handler() as CU_AllTestsCompleteMessageHandler
declare function CU_get_suite_init_failure_handler() as CU_SuiteInitFailureMessageHandler
declare function CU_get_suite_cleanup_failure_handler() as CU_SuiteCleanupFailureMessageHandler
declare function CU_run_all_tests() as CU_ErrorCode
declare function CU_run_suite(byval pSuite as CU_pSuite) as CU_ErrorCode
declare function CU_run_test(byval pSuite as CU_pSuite, byval pTest as CU_pTest) as CU_ErrorCode
declare sub CU_set_fail_on_inactive(byval new_inactive as long)
declare function CU_get_fail_on_inactive() as long
declare function CU_get_number_of_suites_run() as ulong
declare function CU_get_number_of_suites_failed() as ulong
declare function CU_get_number_of_suites_inactive() as ulong
declare function CU_get_number_of_tests_run() as ulong
declare function CU_get_number_of_tests_failed() as ulong
declare function CU_get_number_of_tests_inactive() as ulong
declare function CU_get_number_of_asserts() as ulong
declare function CU_get_number_of_successes() as ulong
declare function CU_get_number_of_failures() as ulong
declare function CU_get_number_of_failure_records() as ulong
declare function CU_get_elapsed_time() as double
declare function CU_get_failure_list() as CU_pFailureRecord
declare function CU_get_run_summary() as CU_pRunSummary
declare function CU_get_run_results_string() as zstring ptr
declare sub CU_print_run_results(byval file as FILE ptr)
declare function CU_get_current_suite() as CU_pSuite
declare function CU_get_current_test() as CU_pTest
declare function CU_is_test_running() as long
declare sub CU_clear_previous_results()
declare function CU_assertImplementation(byval bValue as long, byval uiLine as ulong, byval strCondition as const zstring ptr, byval strFile as const zstring ptr, byval strFunction as const zstring ptr, byval bFatal as long) as long

end extern
