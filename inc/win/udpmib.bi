#pragma once

#define _INC_UDPMIB
#define ANY_SIZE 1

#if _WIN32_WINNT = &h0602
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
