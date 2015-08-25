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
declare sub CU_set_error(byval error as CU_ErrorCode)

end extern
