#pragma once

#include once "crt/errno.bi"
#include once "CUnit.bi"

extern "C"

#define CUNIT_CUERROR_H_SEEN

type CU_ErrorCode as long
enum
	CUE_SUCCESS = 0
	CUE_NOMEMORY = 1
	CUE_NOREGISTRY = 10
	CUE_REGISTRY_EXISTS = 11
	CUE_NOSUITE = 20
	CUE_NO_SUITENAME = 21
	CUE_SINIT_FAILED = 22
	CUE_SCLEAN_FAILED = 23
	CUE_DUP_SUITE = 24
	CUE_SUITE_INACTIVE = 25
	CUE_NOTEST = 30
	CUE_NO_TESTNAME = 31
	CUE_DUP_TEST = 32
	CUE_TEST_NOT_IN_SUITE = 33
	CUE_TEST_INACTIVE = 34
	CUE_FOPEN_FAILED = 40
	CUE_FCLOSE_FAILED = 41
	CUE_BAD_FILENAME = 42
	CUE_WRITE_ERROR = 43
end enum

type CU_ErrorAction as long
enum
	CUEA_IGNORE
	CUEA_FAIL
	CUEA_ABORT
end enum

declare function CU_get_error() as CU_ErrorCode
declare function CU_get_error_msg() as const zstring ptr
declare sub CU_set_error_action(byval action as CU_ErrorAction)
declare function CU_get_error_action() as CU_ErrorAction
declare sub CU_set_error(byval error_ as CU_ErrorCode)

end extern
