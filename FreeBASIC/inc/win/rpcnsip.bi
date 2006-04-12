''
''
'' rpcnsip -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rpcnsip_bi__
#define __win_rpcnsip_bi__

type RPC_IMPORT_CONTEXT_P
	LookupContext as RPC_NS_HANDLE
	ProposedHandle as RPC_BINDING_HANDLE
	Bindings as RPC_BINDING_VECTOR ptr
end type

type PRPC_IMPORT_CONTEXT_P as RPC_IMPORT_CONTEXT_P ptr

declare function I_RpcNsGetBuffer alias "I_RpcNsGetBuffer" (byval as PRPC_MESSAGE) as RPC_STATUS
declare function I_RpcNsSendReceive alias "I_RpcNsSendReceive" (byval as PRPC_MESSAGE, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare sub I_RpcNsRaiseException alias "I_RpcNsRaiseException" (byval as PRPC_MESSAGE, byval as RPC_STATUS)
declare function I_RpcReBindBuffer alias "I_RpcReBindBuffer" (byval as PRPC_MESSAGE) as RPC_STATUS
declare function I_NsServerBindSearch alias "I_NsServerBindSearch" () as RPC_STATUS
declare function I_NsClientBindSearch alias "I_NsClientBindSearch" () as RPC_STATUS
declare sub I_NsClientBindDone alias "I_NsClientBindDone" ()

#endif
