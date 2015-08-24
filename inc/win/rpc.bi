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

#include once "_mingw.bi"
#include once "windows.bi"
#include once "basetsd.bi"

#define __RPC_H__

#ifdef __FB_64BIT__
	#define __RPC_WIN64__
#else
	#define __RPC_WIN32__
#endif

#define __MIDL_USER_DEFINED
type I_RPC_HANDLE as any ptr
type RPC_STATUS as long
#define RPC_UNICODE_SUPPORTED
#define RpcExceptionCode() GetExceptionCode()
#define RpcAbnormalTermination() AbnormalTermination()

#include once "rpcdce.bi"
#include once "rpcnsi.bi"
#include once "rpcnterr.bi"
#include once "rpcasync.bi"
