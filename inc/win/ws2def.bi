'' FreeBASIC binding for mingw-w64-v4.0.1

#pragma once

#include once "_mingw.bi"
#include once "winapifamily.bi"

#define _WS2DEF_

type _SCOPE_LEVEL as long
enum
	ScopeLevelInterface = 1
	ScopeLevelLink = 2
	ScopeLevelSubnet = 3
	ScopeLevelAdmin = 4
	ScopeLevelSite = 5
	ScopeLevelOrganization = 8
	ScopeLevelGlobal = 14
	ScopeLevelCount = 16
end enum

type SCOPE_LEVEL as _SCOPE_LEVEL

type _SCOPE_ID
	union
		type
			Zone : 28 as ULONG
			Level : 4 as ULONG
		end type

		Value as ULONG
	end union
end type

type SCOPE_ID as _SCOPE_ID
type PSCOPE_ID as _SCOPE_ID ptr
