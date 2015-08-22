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

extern "C"

#define CUNIT_UTIL_H_SEEN
const CUNIT_MAX_ENTITY_LEN = 5
declare function CU_translate_special_characters(byval szSrc as const zstring ptr, byval szDest as zstring ptr, byval maxlen as uinteger) as uinteger
declare function CU_translated_strlen(byval szSrc as const zstring ptr) as uinteger
declare function CU_compare_strings(byval szSrc as const zstring ptr, byval szDest as const zstring ptr) as long
declare sub CU_trim_left(byval szString as zstring ptr)
declare sub CU_trim_right(byval szString as zstring ptr)
declare sub CU_trim(byval szString as zstring ptr)
declare function CU_number_width(byval number as long) as uinteger

end extern
