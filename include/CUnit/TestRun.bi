''
''
'' TestRun -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_TestRun_bi__
#define __CUnit_TestRun_bi__

#include once "CUnit/CUnit.bi"
#include once "CUnit/CUError.bi"
#include once "CUnit/TestDB.bi"

type CU_FailureRecord
	uiLineNumber as uinteger
	strFileName as zstring ptr
	strCondition as zstring ptr
	pTest as CU_pTest
	pSuite as CU_pSuite
	pNext as CU_FailureRecord ptr
	pPrev as CU_FailureRecord ptr
end type

type CU_pFailureRecord as CU_FailureRecord ptr

type CU_RunSummary
	nSuitesRun as uinteger
	nSuitesFailed as uinteger
	nTestsRun as uinteger
	nTestsFailed as uinteger
	nAsserts as uinteger
	nAssertsFailed as uinteger
	nFailureRecords as uinteger
end type

type CU_pRunSummary as CU_RunSummary ptr

type CU_TestStartMessageHandler as sub cdecl(byval as CU_pTest, byval as CU_pSuite)
type CU_TestCompleteMessageHandler as sub cdecl(byval as CU_pTest, byval as CU_pSuite, byval as CU_pFailureRecord)
type CU_AllTestsCompleteMessageHandler as sub cdecl(byval as CU_pFailureRecord)
type CU_SuiteInitFailureMessageHandler as sub cdecl(byval as CU_pSuite)
type CU_SuiteCleanupFailureMessageHandler as sub cdecl(byval as CU_pSuite)

declare sub CU_set_test_start_handler cdecl alias "CU_set_test_start_handler" (byval pTestStartMessage as CU_TestStartMessageHandler)
declare sub CU_set_test_complete_handler cdecl alias "CU_set_test_complete_handler" (byval pTestCompleteMessage as CU_TestCompleteMessageHandler)
declare sub CU_set_all_test_complete_handler cdecl alias "CU_set_all_test_complete_handler" (byval pAllTestsCompleteMessage as CU_AllTestsCompleteMessageHandler)
declare sub CU_set_suite_init_failure_handler cdecl alias "CU_set_suite_init_failure_handler" (byval pSuiteInitFailureMessage as CU_SuiteInitFailureMessageHandler)
declare sub CU_set_suite_cleanup_failure_handler cdecl alias "CU_set_suite_cleanup_failure_handler" (byval pSuiteCleanupFailureMessage as CU_SuiteCleanupFailureMessageHandler)
declare function CU_get_test_start_handler cdecl alias "CU_get_test_start_handler" () as CU_TestStartMessageHandler
declare function CU_get_test_complete_handler cdecl alias "CU_get_test_complete_handler" () as CU_TestCompleteMessageHandler
declare function CU_get_all_test_complete_handler cdecl alias "CU_get_all_test_complete_handler" () as CU_AllTestsCompleteMessageHandler
declare function CU_get_suite_init_failure_handler cdecl alias "CU_get_suite_init_failure_handler" () as CU_SuiteInitFailureMessageHandler
declare function CU_get_suite_cleanup_failure_handler cdecl alias "CU_get_suite_cleanup_failure_handler" () as CU_SuiteCleanupFailureMessageHandler
declare function CU_run_all_tests cdecl alias "CU_run_all_tests" () as CU_ErrorCode
declare function CU_run_suite cdecl alias "CU_run_suite" (byval pSuite as CU_pSuite) as CU_ErrorCode
declare function CU_run_test cdecl alias "CU_run_test" (byval pSuite as CU_pSuite, byval pTest as CU_pTest) as CU_ErrorCode
declare function CU_get_number_of_suites_run cdecl alias "CU_get_number_of_suites_run" () as uinteger
declare function CU_get_number_of_suites_failed cdecl alias "CU_get_number_of_suites_failed" () as uinteger
declare function CU_get_number_of_tests_run cdecl alias "CU_get_number_of_tests_run" () as uinteger
declare function CU_get_number_of_tests_failed cdecl alias "CU_get_number_of_tests_failed" () as uinteger
declare function CU_get_number_of_asserts cdecl alias "CU_get_number_of_asserts" () as uinteger
declare function CU_get_number_of_successes cdecl alias "CU_get_number_of_successes" () as uinteger
declare function CU_get_number_of_failures cdecl alias "CU_get_number_of_failures" () as uinteger
declare function CU_get_number_of_failure_records cdecl alias "CU_get_number_of_failure_records" () as uinteger
declare function CU_get_failure_list cdecl alias "CU_get_failure_list" () as CU_pFailureRecord
declare function CU_get_run_summary cdecl alias "CU_get_run_summary" () as CU_pRunSummary
declare function CU_get_current_suite cdecl alias "CU_get_current_suite" () as CU_pSuite
declare function CU_get_current_test cdecl alias "CU_get_current_test" () as CU_pTest
declare function CU_is_test_running cdecl alias "CU_is_test_running" () as integer
declare sub CU_clear_previous_results cdecl alias "CU_clear_previous_results" ()
declare function CU_assertImplementation cdecl alias "CU_assertImplementation" (byval bValue as integer, byval uiLine as uinteger, byval strCondition as zstring ptr, byval strFile as zstring ptr, byval strFunction as zstring ptr, byval bFatal as integer) as integer

#endif
