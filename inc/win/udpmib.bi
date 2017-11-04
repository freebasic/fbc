'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   DISCLAIMER
''   This file has no copyright assigned and is placed in the Public Domain.
''   This file is part of the mingw-w64 runtime package.
''
''   The mingw-w64 runtime package and its code is distributed in the hope that it 
''   will be useful but WITHOUT ANY WARRANTY.  ALL WARRANTIES, EXPRESSED OR 
''   IMPLIED ARE HEREBY DISCLAIMED.  This includes but is not limited to 
''   warranties of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#define _INC_UDPMIB
const ANY_SIZE = 1

#if _WIN32_WINNT >= &h0600
	type _MIB_UDP6ROW
		dwLocalAddr as IN6_ADDR
		dwLocalScopeId as DWORD
		dwLocalPort as DWORD
	end type

	type MIB_UDP6ROW as _MIB_UDP6ROW
	type PMIB_UDP6ROW as _MIB_UDP6ROW ptr

	type _MIB_UDP6TABLE
		dwNumEntries as DWORD
		table(0 to 0) as MIB_UDP6ROW
	end type

	type MIB_UDP6TABLE as _MIB_UDP6TABLE
	type PMIB_UDP6TABLE as _MIB_UDP6TABLE ptr
#endif
