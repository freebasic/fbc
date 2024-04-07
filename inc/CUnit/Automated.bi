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
''   FreeBASIC development team

#pragma once

#include once "CUnit.bi"
#include once "TestDB.bi"

extern "C"

#define CUNIT_AUTOMATED_H_SEEN
declare sub CU_automated_run_tests()
declare function CU_list_tests_to_file() as CU_ErrorCode
declare sub CU_set_output_filename(byval szFilenameRoot as const zstring ptr)
declare sub CU_automated_enable_junit_xml(byval bFlag as long)
declare sub CU_automated_package_name_set(byval pName as const zstring ptr)
declare function CU_automated_package_name_get() as const zstring ptr

end extern
