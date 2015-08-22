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
