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

#include once "_mingw_unicode.bi"

extern "Windows"

#define __RPCDCEP_H__

type _RPC_VERSION
	MajorVersion as ushort
	MinorVersion as ushort
end type

type RPC_VERSION as _RPC_VERSION

type _RPC_SYNTAX_IDENTIFIER
	SyntaxGUID as GUID
	SyntaxVersion as RPC_VERSION
end type

type RPC_SYNTAX_IDENTIFIER as _RPC_SYNTAX_IDENTIFIER
type PRPC_SYNTAX_IDENTIFIER as _RPC_SYNTAX_IDENTIFIER ptr

type _RPC_MESSAGE
	Handle as RPC_BINDING_HANDLE
	DataRepresentation as ulong
	Buffer as any ptr
	BufferLength as ulong
	ProcNum as ulong
	TransferSyntax as PRPC_SYNTAX_IDENTIFIER
	RpcInterfaceInformation as any ptr
	ReservedForRuntime as any ptr
	ManagerEpv as any ptr
	ImportContext as any ptr
	RpcFlags as ulong
end type

type RPC_MESSAGE as _RPC_MESSAGE
type PRPC_MESSAGE as _RPC_MESSAGE ptr

type RPC_ADDRESS_CHANGE_TYPE as long
enum
	PROTOCOL_NOT_LOADED = 1
	PROTOCOL_LOADED
	PROTOCOL_ADDRESS_CHANGE
end enum

const RPC_CONTEXT_HANDLE_DEFAULT_GUARD = cptr(any ptr, -4083)
const RPC_CONTEXT_HANDLE_DEFAULT_FLAGS = &h00000000u
const RPC_CONTEXT_HANDLE_FLAGS = &h30000000u
const RPC_CONTEXT_HANDLE_SERIALIZE = &h10000000u
const RPC_CONTEXT_HANDLE_DONT_SERIALIZE = &h20000000u
const RPC_NCA_FLAGS_DEFAULT = &h00000000
const RPC_NCA_FLAGS_IDEMPOTENT = &h00000001
const RPC_NCA_FLAGS_BROADCAST = &h00000002
const RPC_NCA_FLAGS_MAYBE = &h00000004
const RPC_BUFFER_COMPLETE = &h00001000
const RPC_BUFFER_PARTIAL = &h00002000
const RPC_BUFFER_EXTRA = &h00004000
const RPC_BUFFER_ASYNC = &h00008000
const RPC_BUFFER_NONOTIFY = &h00010000
const RPCFLG_MESSAGE = &h01000000u
const RPCFLG_AUTO_COMPLETE = &h08000000u
const RPCFLG_LOCAL_CALL = &h10000000u
const RPCFLG_INPUT_SYNCHRONOUS = &h20000000u
const RPCFLG_ASYNCHRONOUS = &h40000000u
const RPCFLG_NON_NDR = &h80000000u
const RPCFLG_HAS_MULTI_SYNTAXES = &h02000000u
const RPCFLG_HAS_CALLBACK = &h04000000u
const RPC_FLAGS_VALID_BIT = &h00008000
type RPC_DISPATCH_FUNCTION as sub(byval Message as PRPC_MESSAGE)

type RPC_DISPATCH_TABLE
	DispatchTableCount as ulong
	DispatchTable as RPC_DISPATCH_FUNCTION ptr
	Reserved as LONG_PTR
end type

type PRPC_DISPATCH_TABLE as RPC_DISPATCH_TABLE ptr

type _RPC_PROTSEQ_ENDPOINT
	RpcProtocolSequence as ubyte ptr
	Endpoint as ubyte ptr
end type

type RPC_PROTSEQ_ENDPOINT as _RPC_PROTSEQ_ENDPOINT
type PRPC_PROTSEQ_ENDPOINT as _RPC_PROTSEQ_ENDPOINT ptr
const NT351_INTERFACE_SIZE = &h40
const RPC_INTERFACE_HAS_PIPES = &h0001

type _RPC_SERVER_INTERFACE
	Length as ulong
	InterfaceId as RPC_SYNTAX_IDENTIFIER
	TransferSyntax as RPC_SYNTAX_IDENTIFIER
	DispatchTable as PRPC_DISPATCH_TABLE
	RpcProtseqEndpointCount as ulong
	RpcProtseqEndpoint as PRPC_PROTSEQ_ENDPOINT
	DefaultManagerEpv as any ptr
	InterpreterInfo as const any ptr
	Flags as ulong
end type

type RPC_SERVER_INTERFACE as _RPC_SERVER_INTERFACE
type PRPC_SERVER_INTERFACE as _RPC_SERVER_INTERFACE ptr

type _RPC_CLIENT_INTERFACE
	Length as ulong
	InterfaceId as RPC_SYNTAX_IDENTIFIER
	TransferSyntax as RPC_SYNTAX_IDENTIFIER
	DispatchTable as PRPC_DISPATCH_TABLE
	RpcProtseqEndpointCount as ulong
	RpcProtseqEndpoint as PRPC_PROTSEQ_ENDPOINT
	Reserved as ULONG_PTR
	InterpreterInfo as const any ptr
	Flags as ulong
end type

type RPC_CLIENT_INTERFACE as _RPC_CLIENT_INTERFACE
type PRPC_CLIENT_INTERFACE as _RPC_CLIENT_INTERFACE ptr
declare function I_RpcNegotiateTransferSyntax(byval Message as RPC_MESSAGE ptr) as RPC_STATUS
declare function I_RpcGetBuffer(byval Message as RPC_MESSAGE ptr) as RPC_STATUS
declare function I_RpcGetBufferWithObject(byval Message as RPC_MESSAGE ptr, byval ObjectUuid as UUID ptr) as RPC_STATUS
declare function I_RpcSendReceive(byval Message as RPC_MESSAGE ptr) as RPC_STATUS
declare function I_RpcFreeBuffer(byval Message as RPC_MESSAGE ptr) as RPC_STATUS
declare function I_RpcSend(byval Message as PRPC_MESSAGE) as RPC_STATUS
declare function I_RpcReceive(byval Message as PRPC_MESSAGE, byval Size as ulong) as RPC_STATUS
declare function I_RpcFreePipeBuffer(byval Message as RPC_MESSAGE ptr) as RPC_STATUS
declare function I_RpcReallocPipeBuffer(byval Message as PRPC_MESSAGE, byval NewSize as ulong) as RPC_STATUS
type I_RPC_MUTEX as any ptr
declare sub I_RpcRequestMutex(byval Mutex as I_RPC_MUTEX ptr)
declare sub I_RpcClearMutex(byval Mutex as I_RPC_MUTEX)
declare sub I_RpcDeleteMutex(byval Mutex as I_RPC_MUTEX)
declare function I_RpcAllocate(byval Size as ulong) as any ptr
declare sub I_RpcFree(byval Object as any ptr)
declare sub I_RpcPauseExecution(byval Milliseconds as ulong)
declare function I_RpcGetExtendedError() as RPC_STATUS
type PRPC_RUNDOWN as sub(byval AssociationContext as any ptr)
declare function I_RpcMonitorAssociation(byval Handle as RPC_BINDING_HANDLE, byval RundownRoutine as PRPC_RUNDOWN, byval Context as any ptr) as RPC_STATUS
declare function I_RpcStopMonitorAssociation(byval Handle as RPC_BINDING_HANDLE) as RPC_STATUS
declare function I_RpcGetCurrentCallHandle() as RPC_BINDING_HANDLE
declare function I_RpcGetAssociationContext(byval BindingHandle as RPC_BINDING_HANDLE, byval AssociationContext as any ptr ptr) as RPC_STATUS
declare function I_RpcGetServerContextList(byval BindingHandle as RPC_BINDING_HANDLE) as any ptr
declare sub I_RpcSetServerContextList(byval BindingHandle as RPC_BINDING_HANDLE, byval ServerContextList as any ptr)
declare function I_RpcNsInterfaceExported(byval EntryNameSyntax as ulong, byval EntryName as ushort ptr, byval RpcInterfaceInformation as RPC_SERVER_INTERFACE ptr) as RPC_STATUS
declare function I_RpcNsInterfaceUnexported(byval EntryNameSyntax as ulong, byval EntryName as ushort ptr, byval RpcInterfaceInformation as RPC_SERVER_INTERFACE ptr) as RPC_STATUS
declare function I_RpcBindingToStaticStringBindingW(byval Binding as RPC_BINDING_HANDLE, byval StringBinding as ushort ptr ptr) as RPC_STATUS
declare function I_RpcBindingInqSecurityContext(byval Binding as RPC_BINDING_HANDLE, byval SecurityContextHandle as any ptr ptr) as RPC_STATUS
declare function I_RpcBindingInqWireIdForSnego(byval Binding as RPC_BINDING_HANDLE, byval WireId as RPC_CSTR) as RPC_STATUS
declare function I_RpcBindingInqMarshalledTargetInfo(byval Binding as RPC_BINDING_HANDLE, byval MarshalledTargetInfoLength as ulong ptr, byval MarshalledTargetInfo as RPC_CSTR ptr) as RPC_STATUS
declare function I_RpcBindingInqLocalClientPID(byval Binding as RPC_BINDING_HANDLE, byval Pid as ulong ptr) as RPC_STATUS
declare function I_RpcBindingHandleToAsyncHandle(byval Binding as RPC_BINDING_HANDLE, byval AsyncHandle as any ptr ptr) as RPC_STATUS
declare function I_RpcNsBindingSetEntryNameW(byval Binding as RPC_BINDING_HANDLE, byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR) as RPC_STATUS

#ifdef UNICODE
	declare function I_RpcNsBindingSetEntryName alias "I_RpcNsBindingSetEntryNameW"(byval Binding as RPC_BINDING_HANDLE, byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR) as RPC_STATUS
#endif

declare function I_RpcNsBindingSetEntryNameA(byval Binding as RPC_BINDING_HANDLE, byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR) as RPC_STATUS

#ifndef UNICODE
	declare function I_RpcNsBindingSetEntryName alias "I_RpcNsBindingSetEntryNameA"(byval Binding as RPC_BINDING_HANDLE, byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR) as RPC_STATUS
#endif

declare function I_RpcServerUseProtseqEp2A(byval NetworkAddress as RPC_CSTR, byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval Endpoint as RPC_CSTR, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS

#ifndef UNICODE
	declare function I_RpcServerUseProtseqEp2 alias "I_RpcServerUseProtseqEp2A"(byval NetworkAddress as RPC_CSTR, byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval Endpoint as RPC_CSTR, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS
#endif

declare function I_RpcServerUseProtseqEp2W(byval NetworkAddress as RPC_WSTR, byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval Endpoint as RPC_WSTR, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS

#ifdef UNICODE
	declare function I_RpcServerUseProtseqEp2 alias "I_RpcServerUseProtseqEp2W"(byval NetworkAddress as RPC_WSTR, byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval Endpoint as RPC_WSTR, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS
#endif

declare function I_RpcServerUseProtseq2W(byval NetworkAddress as RPC_WSTR, byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS

#ifdef UNICODE
	declare function I_RpcServerUseProtseq2 alias "I_RpcServerUseProtseq2W"(byval NetworkAddress as RPC_WSTR, byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS
#endif

declare function I_RpcServerUseProtseq2A(byval NetworkAddress as RPC_CSTR, byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS

#ifndef UNICODE
	declare function I_RpcServerUseProtseq2 alias "I_RpcServerUseProtseq2A"(byval NetworkAddress as RPC_CSTR, byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as any ptr) as RPC_STATUS
#endif

declare function I_RpcBindingInqDynamicEndpointW(byval Binding as RPC_BINDING_HANDLE, byval DynamicEndpoint as RPC_WSTR ptr) as RPC_STATUS

#ifdef UNICODE
	declare function I_RpcBindingInqDynamicEndpoint alias "I_RpcBindingInqDynamicEndpointW"(byval Binding as RPC_BINDING_HANDLE, byval DynamicEndpoint as RPC_WSTR ptr) as RPC_STATUS
#endif

declare function I_RpcBindingInqDynamicEndpointA(byval Binding as RPC_BINDING_HANDLE, byval DynamicEndpoint as RPC_CSTR ptr) as RPC_STATUS

#ifndef UNICODE
	declare function I_RpcBindingInqDynamicEndpoint alias "I_RpcBindingInqDynamicEndpointA"(byval Binding as RPC_BINDING_HANDLE, byval DynamicEndpoint as RPC_CSTR ptr) as RPC_STATUS
#endif

declare function I_RpcServerCheckClientRestriction(byval Context as RPC_BINDING_HANDLE) as RPC_STATUS
const TRANSPORT_TYPE_CN = &h01
const TRANSPORT_TYPE_DG = &h02
const TRANSPORT_TYPE_LPC = &h04
const TRANSPORT_TYPE_WMSG = &h08
declare function I_RpcBindingInqTransportType(byval Binding as RPC_BINDING_HANDLE, byval Type as ulong ptr) as RPC_STATUS

type _RPC_TRANSFER_SYNTAX
	Uuid as UUID
	VersMajor as ushort
	VersMinor as ushort
end type

type RPC_TRANSFER_SYNTAX as _RPC_TRANSFER_SYNTAX
declare function I_RpcIfInqTransferSyntaxes(byval RpcIfHandle as RPC_IF_HANDLE, byval TransferSyntaxes as RPC_TRANSFER_SYNTAX ptr, byval TransferSyntaxSize as ulong, byval TransferSyntaxCount as ulong ptr) as RPC_STATUS
declare function I_UuidCreate(byval Uuid as UUID ptr) as RPC_STATUS
declare function I_RpcBindingCopy(byval SourceBinding as RPC_BINDING_HANDLE, byval DestinationBinding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function I_RpcBindingIsClientLocal(byval BindingHandle as RPC_BINDING_HANDLE, byval ClientLocalFlag as ulong ptr) as RPC_STATUS
declare function I_RpcBindingInqConnId(byval Binding as RPC_BINDING_HANDLE, byval ConnId as any ptr ptr, byval pfFirstCall as long ptr) as RPC_STATUS
declare sub I_RpcSsDontSerializeContext()
declare function I_RpcLaunchDatagramReceiveThread(byval pAddress as any ptr) as RPC_STATUS
declare function I_RpcServerRegisterForwardFunction(byval pForwardFunction as function(byval InterfaceId as UUID ptr, byval InterfaceVersion as RPC_VERSION ptr, byval ObjectId as UUID ptr, byval Rpcpro as ubyte ptr, byval ppDestEndpoint as any ptr ptr) as RPC_STATUS) as RPC_STATUS
declare function I_RpcServerInqAddressChangeFn() as sub(byval arg as any ptr)
declare function I_RpcServerSetAddressChangeFn(byval pAddressChangeFn as sub(byval arg as any ptr)) as RPC_STATUS
const RPC_P_ADDR_FORMAT_TCP_IPV4 = 1
const RPC_P_ADDR_FORMAT_TCP_IPV6 = 2
declare function I_RpcServerInqLocalConnAddress(byval Binding as RPC_BINDING_HANDLE, byval Buffer as any ptr, byval BufferSize as ulong ptr, byval AddressFormat as ulong ptr) as RPC_STATUS
declare sub I_RpcSessionStrictContextHandle()
declare function I_RpcTurnOnEEInfoPropagation() as RPC_STATUS
declare function I_RpcConnectionInqSockBuffSize(byval RecvBuffSize as ulong ptr, byval SendBuffSize as ulong ptr) as RPC_STATUS
declare function I_RpcConnectionSetSockBuffSize(byval RecvBuffSize as ulong, byval SendBuffSize as ulong) as RPC_STATUS
type RPCLT_PDU_FILTER_FUNC as sub cdecl(byval Buffer as any ptr, byval BufferLength as ulong, byval fDatagram as long)
type RPC_SETFILTER_FUNC as sub cdecl(byval pfnFilter as RPCLT_PDU_FILTER_FUNC)
declare function I_RpcServerInqTransportType(byval Type as ulong ptr) as RPC_STATUS
declare function I_RpcMapWin32Status(byval Status as RPC_STATUS) as long

type _RPC_C_OPT_METADATA_DESCRIPTOR
	BufferSize as ulong
	Buffer as zstring ptr
end type

type RPC_C_OPT_METADATA_DESCRIPTOR as _RPC_C_OPT_METADATA_DESCRIPTOR

type _RDR_CALLOUT_STATE
	LastError as RPC_STATUS
	LastEEInfo as any ptr
	LastCalledStage as RPC_HTTP_REDIRECTOR_STAGE
	ServerName as ushort ptr
	ServerPort as ushort ptr
	RemoteUser as ushort ptr
	AuthType as ushort ptr
	ResourceTypePresent as ubyte
	MetadataPresent as ubyte
	SessionIdPresent as ubyte
	InterfacePresent as ubyte
	ResourceType as UUID
	Metadata as RPC_C_OPT_METADATA_DESCRIPTOR
	SessionId as UUID
	Interface as RPC_SYNTAX_IDENTIFIER
	CertContext as any ptr
end type

type RDR_CALLOUT_STATE as _RDR_CALLOUT_STATE
type I_RpcProxyIsValidMachineFn as function(byval pszMachine as zstring ptr, byval pszDotMachine as zstring ptr, byval dwPortNumber as ulong) as RPC_STATUS
type I_RpcProxyGetClientAddressFn as function(byval Context as any ptr, byval Buffer as zstring ptr, byval BufferLength as ulong ptr) as RPC_STATUS
type I_RpcProxyGetConnectionTimeoutFn as function(byval ConnectionTimeout as ulong ptr) as RPC_STATUS
type I_RpcPerformCalloutFn as function(byval Context as any ptr, byval CallOutState as RDR_CALLOUT_STATE ptr, byval Stage as RPC_HTTP_REDIRECTOR_STAGE) as RPC_STATUS
type I_RpcFreeCalloutStateFn as sub(byval CallOutState as RDR_CALLOUT_STATE ptr)

type tagI_RpcProxyCallbackInterface
	IsValidMachineFn as I_RpcProxyIsValidMachineFn
	GetClientAddressFn as I_RpcProxyGetClientAddressFn
	GetConnectionTimeoutFn as I_RpcProxyGetConnectionTimeoutFn
	PerformCalloutFn as I_RpcPerformCalloutFn
	FreeCalloutStateFn as I_RpcFreeCalloutStateFn
end type

type I_RpcProxyCallbackInterface as tagI_RpcProxyCallbackInterface
const RPC_PROXY_CONNECTION_TYPE_IN_PROXY = 0
const RPC_PROXY_CONNECTION_TYPE_OUT_PROXY = 1
declare function I_RpcProxyNewConnection(byval ConnectionType as ulong, byval ServerAddress as ushort ptr, byval ServerPort as ushort ptr, byval MinConnTimeout as ushort ptr, byval ConnectionParameter as any ptr, byval CallOutState as RDR_CALLOUT_STATE ptr, byval ProxyCallbackInterface as I_RpcProxyCallbackInterface ptr) as RPC_STATUS
declare function I_RpcReplyToClientWithStatus(byval ConnectionParameter as any ptr, byval RpcStatus as RPC_STATUS) as RPC_STATUS
declare sub I_RpcRecordCalloutFailure(byval RpcStatus as RPC_STATUS, byval CallOutState as RDR_CALLOUT_STATE ptr, byval DllName as ushort ptr)

end extern
