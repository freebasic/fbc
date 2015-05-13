#pragma once

extern "Windows"

#define __RPCNSIP_H__

type RPC_IMPORT_CONTEXT_P
	LookupContext as RPC_NS_HANDLE
	ProposedHandle as RPC_BINDING_HANDLE
	Bindings as RPC_BINDING_VECTOR ptr
end type

type PRPC_IMPORT_CONTEXT_P as RPC_IMPORT_CONTEXT_P ptr
declare function I_RpcNsGetBuffer(byval Message as PRPC_MESSAGE) as RPC_STATUS
declare function I_RpcNsSendReceive(byval Message as PRPC_MESSAGE, byval Handle as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare sub I_RpcNsRaiseException(byval Message as PRPC_MESSAGE, byval Status as RPC_STATUS)
declare function I_RpcReBindBuffer(byval Message as PRPC_MESSAGE) as RPC_STATUS
declare function I_NsServerBindSearch() as RPC_STATUS
declare function I_NsClientBindSearch() as RPC_STATUS
declare sub I_NsClientBindDone()

end extern
