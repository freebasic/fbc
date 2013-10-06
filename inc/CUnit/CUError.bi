''
''
'' CUError -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CUnit_CUError_bi__
#define __CUnit_CUError_bi__

#include once "crt/errno.bi"
#include once "CUnit/CUnit.bi"

extern "C"

enum CU_ErrorCode
	CUE_SUCCESS = 0
	CUE_NOMEMORY = 1
	CUE_NOREGISTRY = 10
	CUE_REGISTRY_EXISTS = 11
	CUE_NOSUITE = 20
	CUE_NO_SUITENAME = 21
	CUE_SINIT_FAILED = 22
	CUE_SCLEAN_FAILED = 23
	CUE_DUP_SUITE = 24
	CUE_NOTEST = 30
	CUE_NO_TESTNAME = 31
	CUE_DUP_TEST = 32
	CUE_TEST_NOT_IN_SUITE = 33
	CUE_FOPEN_FAILED = 40
	CUE_FCLOSE_FAILED = 41
	CUE_BAD_FILENAME = 42
	CUE_WRITE_ERROR = 43
end enum

enum CU_ErrorAction
	CUEA_IGNORE
	CUEA_FAIL
	CUEA_ABORT
end enum

declare function CU_get_error() as CU_ErrorCode
declare function CU_get_error_msg() as zstring ptr
declare sub CU_set_error_action(byval action as CU_ErrorAction)
declare function CU_get_error_action() as CU_ErrorAction
declare sub CU_set_error(byval error as CU_ErrorCode)

end extern

#endif
