''
''
'' rpcdcep -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rpcdcep_bi__
#define __win_rpcdcep_bi__

#define RPC_NCA_FLAGS_DEFAULT 0
#define RPC_NCA_FLAGS_IDEMPOTENT 1
#define RPC_NCA_FLAGS_BROADCAST 2
#define RPC_NCA_FLAGS_MAYBE 4
#define RPCFLG_ASYNCHRONOUS &h40000000
#define RPCFLG_INPUT_SYNCHRONOUS &h20000000
#define RPC_FLAGS_VALID_BIT &h8000
#define TRANSPORT_TYPE_CN 1
#define TRANSPORT_TYPE_DG 2
#define TRANSPORT_TYPE_LPC 4
#define TRANSPORT_TYPE_WMSG 8

type RPC_VERSION
	MajorVersion as ushort
	MinorVersion as ushort
end type

type RPC_SYNTAX_IDENTIFIER
	SyntaxGUID as GUID
	SyntaxVersion as RPC_VERSION
end type

type PRPC_SYNTAX_IDENTIFIER as RPC_SYNTAX_IDENTIFIER ptr

type RPC_MESSAGE
	Handle as HANDLE
	DataRepresentation as uinteger
	Buffer as any ptr
	BufferLength as uinteger
	ProcNum as uinteger
	TransferSyntax as PRPC_SYNTAX_IDENTIFIER
	RpcInterfaceInformation as any ptr
	ReservedForRuntime as any ptr
	ManagerEpv as any ptr
	ImportContext as any ptr
	RpcFlags as uinteger
end type

type PRPC_MESSAGE as RPC_MESSAGE ptr
type RPC_DISPATCH_FUNCTION as sub (byval as PRPC_MESSAGE)

type RPC_DISPATCH_TABLE
	DispatchTableCount as uinteger
	DispatchTable as RPC_DISPATCH_FUNCTION ptr
	Reserved as integer
end type

type PRPC_DISPATCH_TABLE as RPC_DISPATCH_TABLE ptr

type RPC_PROTSEQ_ENDPOINT
	RpcProtocolSequence as ubyte ptr
	Endpoint as ubyte ptr
end type

type PRPC_PROTSEQ_ENDPOINT as RPC_PROTSEQ_ENDPOINT ptr

type RPC_SERVER_INTERFACE
	Length as uinteger
	InterfaceId as RPC_SYNTAX_IDENTIFIER
	TransferSyntax as RPC_SYNTAX_IDENTIFIER
	DispatchTable as PRPC_DISPATCH_TABLE
	RpcProtseqEndpointCount as uinteger
	RpcProtseqEndpoint as PRPC_PROTSEQ_ENDPOINT
	DefaultManagerEpv as any ptr
	InterpreterInfo as any ptr
end type

type PRPC_SERVER_INTERFACE as RPC_SERVER_INTERFACE ptr

type RPC_CLIENT_INTERFACE
	Length as uinteger
	InterfaceId as RPC_SYNTAX_IDENTIFIER
	TransferSyntax as RPC_SYNTAX_IDENTIFIER
	DispatchTable as PRPC_DISPATCH_TABLE
	RpcProtseqEndpointCount as uinteger
	RpcProtseqEndpoint as PRPC_PROTSEQ_ENDPOINT
	Reserved as uinteger
	InterpreterInfo as any ptr
end type

type PRPC_CLIENT_INTERFACE as RPC_CLIENT_INTERFACE ptr
type I_RPC_MUTEX as any ptr

type RPC_TRANSFER_SYNTAX
	Uuid as GUID
	VersMajor as ushort
	VersMinor as ushort
end type

type RPC_BLOCKING_FN as function(byval as any ptr, byval as any ptr, byval as any ptr) as RPC_STATUS
type RPC_FORWARD_FUNCTION as function (byval as GUID ptr, byval as RPC_VERSION ptr, byval as GUID ptr, byval as ubyte ptr, byval as any ptr ptr) as long

declare function I_RpcGetBuffer alias "I_RpcGetBuffer" (byval as RPC_MESSAGE ptr) as integer
declare function I_RpcSendReceive alias "I_RpcSendReceive" (byval as RPC_MESSAGE ptr) as integer
declare function I_RpcSend alias "I_RpcSend" (byval as RPC_MESSAGE ptr) as integer
declare function I_RpcFreeBuffer alias "I_RpcFreeBuffer" (byval as RPC_MESSAGE ptr) as integer
declare sub I_RpcRequestMutex alias "I_RpcRequestMutex" (byval as I_RPC_MUTEX ptr)
declare sub I_RpcClearMutex alias "I_RpcClearMutex" (byval as I_RPC_MUTEX)
declare sub I_RpcDeleteMutex alias "I_RpcDeleteMutex" (byval as I_RPC_MUTEX)
declare function I_RpcAllocate alias "I_RpcAllocate" (byval as uinteger) as any ptr
declare sub I_RpcFree alias "I_RpcFree" (byval as any ptr)
declare sub I_RpcPauseExecution alias "I_RpcPauseExecution" (byval as uinteger)

type PRPC_RUNDOWN as sub (byval as any ptr)

declare function I_RpcMonitorAssociation alias "I_RpcMonitorAssociation" (byval as HANDLE, byval as PRPC_RUNDOWN, byval as any ptr) as integer
declare function I_RpcStopMonitorAssociation alias "I_RpcStopMonitorAssociation" (byval as HANDLE) as integer
declare function I_RpcGetCurrentCallHandle alias "I_RpcGetCurrentCallHandle" () as HANDLE
declare function I_RpcGetAssociationContext alias "I_RpcGetAssociationContext" (byval as any ptr ptr) as integer
declare function I_RpcSetAssociationContext alias "I_RpcSetAssociationContext" (byval as any ptr) as integer
declare function I_RpcNsBindingSetEntryName alias "I_RpcNsBindingSetEntryName" (byval as HANDLE, byval as uinteger, byval as ushort ptr) as integer
declare function I_RpcBindingInqDynamicEndpoint alias "I_RpcBindingInqDynamicEndpoint" (byval as HANDLE, byval as ushort ptr ptr) as integer
declare function I_RpcBindingInqTransportType alias "I_RpcBindingInqTransportType" (byval as HANDLE, byval as uinteger ptr) as integer
declare function I_RpcIfInqTransferSyntaxes alias "I_RpcIfInqTransferSyntaxes" (byval as HANDLE, byval as RPC_TRANSFER_SYNTAX ptr, byval as uinteger, byval as uinteger ptr) as integer
declare function I_UuidCreate alias "I_UuidCreate" (byval as GUID ptr) as integer
declare function I_RpcBindingCopy alias "I_RpcBindingCopy" (byval as HANDLE, byval as HANDLE ptr) as integer
declare function I_RpcBindingIsClientLocal alias "I_RpcBindingIsClientLocal" (byval as HANDLE, byval as uinteger ptr) as integer
declare sub I_RpcSsDontSerializeContext alias "I_RpcSsDontSerializeContext" ()
declare function I_RpcServerRegisterForwardFunction alias "I_RpcServerRegisterForwardFunction" (byval as RPC_FORWARD_FUNCTION) as integer
declare function I_RpcConnectionInqSockBuffSize alias "I_RpcConnectionInqSockBuffSize" (byval as uinteger ptr, byval as uinteger ptr) as integer
declare function I_RpcConnectionSetSockBuffSize alias "I_RpcConnectionSetSockBuffSize" (byval as uinteger, byval as uinteger) as integer
declare function I_RpcBindingSetAsync alias "I_RpcBindingSetAsync" (byval as HANDLE, byval as RPC_BLOCKING_FN) as integer
declare function I_RpcAsyncSendReceive alias "I_RpcAsyncSendReceive" (byval as RPC_MESSAGE ptr, byval as any ptr) as integer
declare function I_RpcGetThreadWindowHandle alias "I_RpcGetThreadWindowHandle" (byval as any ptr ptr) as integer
declare function I_RpcServerThreadPauseListening alias "I_RpcServerThreadPauseListening" () as integer
declare function I_RpcServerThreadContinueListening alias "I_RpcServerThreadContinueListening" () as integer

#ifdef UNICODE
declare function I_RpcServerUnregisterEndpoint alias "I_RpcServerUnregisterEndpointA" (byval as ubyte ptr, byval as ubyte ptr) as integer

#else ''UNICODE
declare function I_RpcServerUnregisterEndpoint alias "I_RpcServerUnregisterEndpointW" (byval as ushort ptr, byval as ushort ptr) as integer

#endif ''UNICODE

#endif
