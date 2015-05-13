''
''
'' rpc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rpc_bi__
#define __win_rpc_bi__

#include once "windows.bi"

type I_RPC_HANDLE as any ptr
type RPC_STATUS as integer

#include once "win/rpcdce.bi"
#include once "win/rpcnsi.bi"
#include once "win/rpcnterr.bi"
#include once "win/winerror.bi"

declare function RpcImpersonateClient alias "RpcImpersonateClient" (byval as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcRevertToSelf alias "RpcRevertToSelf" () as RPC_STATUS
declare function I_RpcMapWin32Status alias "I_RpcMapWin32Status" (byval as RPC_STATUS) as integer

#endif
