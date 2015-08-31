'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

extern "C"

#define __wtypesbase_h__
#define __IWinTypesBase_INTERFACE_DEFINED__
extern IWinTypesBase_v0_1_c_ifspec as RPC_IF_HANDLE
extern IWinTypesBase_v0_1_s_ifspec as RPC_IF_HANDLE
type OLECHAR as WCHAR
type LPOLESTR as wstring ptr
type LPCOLESTR as const wstring ptr
#define OLESTR(str) wstr(str)
type UCHAR as ubyte

type _COAUTHIDENTITY
	User as USHORT ptr
	UserLength as ULONG
	Domain as USHORT ptr
	DomainLength as ULONG
	Password as USHORT ptr
	PasswordLength as ULONG
	Flags as ULONG
end type

type COAUTHIDENTITY as _COAUTHIDENTITY

type _COAUTHINFO
	dwAuthnSvc as DWORD
	dwAuthzSvc as DWORD
	pwszServerPrincName as LPWSTR
	dwAuthnLevel as DWORD
	dwImpersonationLevel as DWORD
	pAuthIdentityData as COAUTHIDENTITY ptr
	dwCapabilities as DWORD
end type

type COAUTHINFO as _COAUTHINFO
type SCODE as LONG
type PSCODE as SCODE ptr

type tagMEMCTX as long
enum
	MEMCTX_TASK = 1
	MEMCTX_SHARED = 2
	MEMCTX_MACSYSTEM = 3
	MEMCTX_UNKNOWN = -1
	MEMCTX_SAME = -2
end enum

type MEMCTX as tagMEMCTX
#define _ROTREGFLAGS_DEFINED
const ROTREGFLAGS_ALLOWANYCLIENT = &h1
#define _APPIDREGFLAGS_DEFINED
const APPIDREGFLAGS_ACTIVATE_IUSERVER_INDESKTOP = &h1
const APPIDREGFLAGS_SECURE_SERVER_PROCESS_SD_AND_BIND = &h2
const APPIDREGFLAGS_ISSUE_ACTIVATION_RPC_AT_IDENTIFY = &h4
const APPIDREGFLAGS_IUSERVER_UNMODIFIED_LOGON_TOKEN = &h8
const APPIDREGFLAGS_IUSERVER_SELF_SID_IN_LAUNCH_PERMISSION = &h10
const APPIDREGFLAGS_IUSERVER_ACTIVATE_IN_CLIENT_SESSION_ONLY = &h20
const APPIDREGFLAGS_RESERVED1 = &h40
#define _DCOMSCM_REMOTECALL_FLAGS_DEFINED
const DCOMSCM_ACTIVATION_USE_ALL_AUTHNSERVICES = &h1
const DCOMSCM_ACTIVATION_DISALLOW_UNSECURE_CALL = &h2
const DCOMSCM_RESOLVE_USE_ALL_AUTHNSERVICES = &h4
const DCOMSCM_RESOLVE_DISALLOW_UNSECURE_CALL = &h8
const DCOMSCM_PING_USE_MID_AUTHNSERVICE = &h10
const DCOMSCM_PING_DISALLOW_UNSECURE_CALL = &h20

type tagCLSCTX as long
enum
	CLSCTX_INPROC_SERVER = &h1
	CLSCTX_INPROC_HANDLER = &h2
	CLSCTX_LOCAL_SERVER = &h4
	CLSCTX_INPROC_SERVER16 = &h8
	CLSCTX_REMOTE_SERVER = &h10
	CLSCTX_INPROC_HANDLER16 = &h20
	CLSCTX_RESERVED1 = &h40
	CLSCTX_RESERVED2 = &h80
	CLSCTX_RESERVED3 = &h100
	CLSCTX_RESERVED4 = &h200
	CLSCTX_NO_CODE_DOWNLOAD = &h400
	CLSCTX_RESERVED5 = &h800
	CLSCTX_NO_CUSTOM_MARSHAL = &h1000
	CLSCTX_ENABLE_CODE_DOWNLOAD = &h2000
	CLSCTX_NO_FAILURE_LOG = &h4000
	CLSCTX_DISABLE_AAA = &h8000
	CLSCTX_ENABLE_AAA = &h10000
	CLSCTX_FROM_DEFAULT_CONTEXT = &h20000
	CLSCTX_ACTIVATE_32_BIT_SERVER = &h40000
	CLSCTX_ACTIVATE_64_BIT_SERVER = &h80000
	CLSCTX_ENABLE_CLOAKING = &h100000
	CLSCTX_APPCONTAINER = &h400000
	CLSCTX_ACTIVATE_AAA_AS_IU = &h800000
	CLSCTX_PS_DLL = clng(&h80000000)
end enum

type CLSCTX as tagCLSCTX
const CLSCTX_VALID_MASK = ((((((((((((((((CLSCTX_INPROC_SERVER or CLSCTX_INPROC_HANDLER) or CLSCTX_LOCAL_SERVER) or CLSCTX_INPROC_SERVER16) or CLSCTX_REMOTE_SERVER) or CLSCTX_NO_CODE_DOWNLOAD) or CLSCTX_NO_CUSTOM_MARSHAL) or CLSCTX_ENABLE_CODE_DOWNLOAD) or CLSCTX_NO_FAILURE_LOG) or CLSCTX_DISABLE_AAA) or CLSCTX_ENABLE_AAA) or CLSCTX_FROM_DEFAULT_CONTEXT) or CLSCTX_ACTIVATE_32_BIT_SERVER) or CLSCTX_ACTIVATE_64_BIT_SERVER) or CLSCTX_ENABLE_CLOAKING) or CLSCTX_APPCONTAINER) or CLSCTX_ACTIVATE_AAA_AS_IU) or CLSCTX_PS_DLL

type tagMSHLFLAGS as long
enum
	MSHLFLAGS_NORMAL = 0
	MSHLFLAGS_TABLESTRONG = 1
	MSHLFLAGS_TABLEWEAK = 2
	MSHLFLAGS_NOPING = 4
	MSHLFLAGS_RESERVED1 = 8
	MSHLFLAGS_RESERVED2 = 16
	MSHLFLAGS_RESERVED3 = 32
	MSHLFLAGS_RESERVED4 = 64
end enum

type MSHLFLAGS as tagMSHLFLAGS

type tagMSHCTX as long
enum
	MSHCTX_LOCAL = 0
	MSHCTX_NOSHAREDMEM = 1
	MSHCTX_DIFFERENTMACHINE = 2
	MSHCTX_INPROC = 3
	MSHCTX_CROSSCTX = 4
end enum

type MSHCTX as tagMSHCTX

type _BYTE_BLOB
	clSize as ULONG
	abData(0 to 0) as ubyte
end type

type BYTE_BLOB as _BYTE_BLOB
type UP_BYTE_BLOB as BYTE_BLOB ptr

type _WORD_BLOB
	clSize as ULONG
	asData(0 to 0) as ushort
end type

type WORD_BLOB as _WORD_BLOB
type UP_WORD_BLOB as WORD_BLOB ptr

type _DWORD_BLOB
	clSize as ULONG
	alData(0 to 0) as ULONG
end type

type DWORD_BLOB as _DWORD_BLOB
type UP_DWORD_BLOB as DWORD_BLOB ptr

type _FLAGGED_BYTE_BLOB
	fFlags as ULONG
	clSize as ULONG
	abData(0 to 0) as ubyte
end type

type FLAGGED_BYTE_BLOB as _FLAGGED_BYTE_BLOB
type UP_FLAGGED_BYTE_BLOB as FLAGGED_BYTE_BLOB ptr

type _FLAGGED_WORD_BLOB
	fFlags as ULONG
	clSize as ULONG
	asData(0 to 0) as ushort
end type

type FLAGGED_WORD_BLOB as _FLAGGED_WORD_BLOB
type UP_FLAGGED_WORD_BLOB as FLAGGED_WORD_BLOB ptr

type _BYTE_SIZEDARR
	clSize as ULONG
	pData as ubyte ptr
end type

type BYTE_SIZEDARR as _BYTE_SIZEDARR

type _SHORT_SIZEDARR
	clSize as ULONG
	pData as ushort ptr
end type

type WORD_SIZEDARR as _SHORT_SIZEDARR

type _LONG_SIZEDARR
	clSize as ULONG
	pData as ULONG ptr
end type

type DWORD_SIZEDARR as _LONG_SIZEDARR

type _HYPER_SIZEDARR
	clSize as ULONG
	pData as longint ptr
end type

type HYPER_SIZEDARR as _HYPER_SIZEDARR
#define _tagBLOB_DEFINED
#define _BLOB_DEFINED
#define _LPBLOB_DEFINED

type tagBLOB
	cbSize as ULONG
	pBlobData as UBYTE ptr
end type

type BLOB as tagBLOB
type LPBLOB as tagBLOB ptr

end extern
