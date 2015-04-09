'' FreeBASIC binding for mingw-w64-v3.3.0

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
