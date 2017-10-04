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

#define _INC_TCPMIB

#if _WIN32_WINNT >= &h0600
	type MIB_TCP_STATE as long

	type _TCP_CONNECTION_OFFLOAD_STATE as long
	enum
		TcpConnectionOffloadStateInHost = 0
		TcpConnectionOffloadStateOffloading = 1
		TcpConnectionOffloadStateOffloaded = 2
		TcpConnectionOffloadStateUploading = 3
		TcpConnectionOffloadStateMax = 4
	end enum

	type TCP_CONNECTION_OFFLOAD_STATE as _TCP_CONNECTION_OFFLOAD_STATE

	type _MIB_TCP6ROW
		State as MIB_TCP_STATE
		LocalAddr as IN6_ADDR
		dwLocalScopeId as DWORD
		dwLocalPort as DWORD
		RemoteAddr as IN6_ADDR
		dwRemoteScopeId as DWORD
		dwRemotePort as DWORD
	end type

	type MIB_TCP6ROW as _MIB_TCP6ROW
	type PMIB_TCP6ROW as _MIB_TCP6ROW ptr

	type _MIB_TCP6TABLE
		dwNumEntries as DWORD
		table(0 to 0) as MIB_TCP6ROW
	end type

	type MIB_TCP6TABLE as _MIB_TCP6TABLE
	type PMIB_TCP6TABLE as _MIB_TCP6TABLE ptr

	type _MIB_TCP6ROW2
		LocalAddr as IN6_ADDR
		dwLocalScopeId as DWORD
		dwLocalPort as DWORD
		RemoteAddr as IN6_ADDR
		dwRemoteScopeId as DWORD
		dwRemotePort as DWORD
		State as MIB_TCP_STATE
		dwOwningPid as DWORD
		dwOffloadState as TCP_CONNECTION_OFFLOAD_STATE
	end type

	type MIB_TCP6ROW2 as _MIB_TCP6ROW2
	type PMIB_TCP6ROW2 as _MIB_TCP6ROW2 ptr

	type _MIB_TCP6TABLE2
		dwNumEntries as DWORD
		table(0 to 0) as MIB_TCP6ROW2
	end type

	type MIB_TCP6TABLE2 as _MIB_TCP6TABLE2
	type PMIB_TCP6TABLE2 as _MIB_TCP6TABLE2 ptr

	type _MIB_TCPROW2
		dwState as DWORD
		dwLocalAddr as DWORD
		dwLocalPort as DWORD
		dwRemoteAddr as DWORD
		dwRemotePort as DWORD
		dwOffloadState as TCP_CONNECTION_OFFLOAD_STATE
	end type

	type MIB_TCPROW2 as _MIB_TCPROW2
	type PMIB_TCPROW2 as _MIB_TCPROW2 ptr

	type _MIB_TCPTABLE2
		dwNumEntries as DWORD
		table(0 to 0) as MIB_TCPROW2
	end type

	type MIB_TCPTABLE2 as _MIB_TCPTABLE2
	type PMIB_TCPTABLE2 as _MIB_TCPTABLE2 ptr
#endif
