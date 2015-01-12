#pragma once

#include once "_mingw_unicode.bi"
#include once "guiddef.bi"

extern "Windows"

#define __RPCDCE_H__

type RPC_CSTR as ubyte ptr
type RPC_WSTR as ushort ptr
type RPC_BINDING_HANDLE as I_RPC_HANDLE
type handle_t as RPC_BINDING_HANDLE

#define rpc_binding_handle_t RPC_BINDING_HANDLE
#define UUID_DEFINED

type UUID as GUID

#define uuid_t UUID

type _RPC_BINDING_VECTOR
	Count as ulong
	BindingH(0 to 0) as RPC_BINDING_HANDLE
end type

type RPC_BINDING_VECTOR as _RPC_BINDING_VECTOR

#define rpc_binding_vector_t RPC_BINDING_VECTOR

type _UUID_VECTOR
	Count as ulong
	Uuid(0 to 0) as UUID ptr
end type

type UUID_VECTOR as _UUID_VECTOR

#define uuid_vector_t UUID_VECTOR

type RPC_IF_HANDLE as any ptr

#define IFID_DEFINED

type _RPC_IF_ID
	Uuid as UUID
	VersMajor as ushort
	VersMinor as ushort
end type

type RPC_IF_ID as _RPC_IF_ID

#define RPC_C_BINDING_INFINITE_TIMEOUT 10
#define RPC_C_BINDING_MIN_TIMEOUT 0
#define RPC_C_BINDING_DEFAULT_TIMEOUT 5
#define RPC_C_BINDING_MAX_TIMEOUT 9
#define RPC_C_CANCEL_INFINITE_TIMEOUT (-1)
#define RPC_C_LISTEN_MAX_CALLS_DEFAULT 1234
#define RPC_C_PROTSEQ_MAX_REQS_DEFAULT 10
#define RPC_C_BIND_TO_ALL_NICS 1
#define RPC_C_USE_INTERNET_PORT &h1
#define RPC_C_USE_INTRANET_PORT &h2
#define RPC_C_DONT_FAIL &h4
#define RPC_C_MQ_TEMPORARY &h0000
#define RPC_C_MQ_PERMANENT &h0001
#define RPC_C_MQ_CLEAR_ON_OPEN &h0002
#define RPC_C_MQ_USE_EXISTING_SECURITY &h0004
#define RPC_C_MQ_AUTHN_LEVEL_NONE &h0000
#define RPC_C_MQ_AUTHN_LEVEL_PKT_INTEGRITY &h0008
#define RPC_C_MQ_AUTHN_LEVEL_PKT_PRIVACY &h0010
#define RPC_C_OPT_MQ_DELIVERY 1
#define RPC_C_OPT_MQ_PRIORITY 2
#define RPC_C_OPT_MQ_JOURNAL 3
#define RPC_C_OPT_MQ_ACKNOWLEDGE 4
#define RPC_C_OPT_MQ_AUTHN_SERVICE 5
#define RPC_C_OPT_MQ_AUTHN_LEVEL 6
#define RPC_C_OPT_MQ_TIME_TO_REACH_QUEUE 7
#define RPC_C_OPT_MQ_TIME_TO_BE_RECEIVED 8
#define RPC_C_OPT_BINDING_NONCAUSAL 9
#define RPC_C_OPT_SECURITY_CALLBACK 10
#define RPC_C_OPT_UNIQUE_BINDING 11
#define RPC_C_OPT_CALL_TIMEOUT 12
#define RPC_C_OPT_DONT_LINGER 13
#define RPC_C_OPT_MAX_OPTIONS 14
#define RPC_C_MQ_EXPRESS 0
#define RPC_C_MQ_RECOVERABLE 1
#define RPC_C_MQ_JOURNAL_NONE 0
#define RPC_C_MQ_JOURNAL_DEADLETTER 1
#define RPC_C_MQ_JOURNAL_ALWAYS 2
#define RPC_C_FULL_CERT_CHAIN &h0001

type _RPC_PROTSEQ_VECTORA
	Count as ulong
	Protseq(0 to 0) as ubyte ptr
end type

type RPC_PROTSEQ_VECTORA as _RPC_PROTSEQ_VECTORA

type _RPC_PROTSEQ_VECTORW
	Count as ulong
	Protseq(0 to 0) as ushort ptr
end type

type RPC_PROTSEQ_VECTORW as _RPC_PROTSEQ_VECTORW

#ifdef UNICODE
	#define RPC_PROTSEQ_VECTOR RPC_PROTSEQ_VECTORW
#else
	#define RPC_PROTSEQ_VECTOR RPC_PROTSEQ_VECTORA
#endif

type _RPC_POLICY
	Length as ulong
	EndpointFlags as ulong
	NICFlags as ulong
end type

type RPC_POLICY as _RPC_POLICY
type PRPC_POLICY as _RPC_POLICY ptr

#define RPC_MGR_EPV any

type RPC_STATS_VECTOR
	Count as ulong
	Stats(0 to 0) as ulong
end type

#define RPC_C_STATS_CALLS_IN 0
#define RPC_C_STATS_CALLS_OUT 1
#define RPC_C_STATS_PKTS_IN 2
#define RPC_C_STATS_PKTS_OUT 3

type RPC_IF_ID_VECTOR
	Count as ulong
	IfId(0 to 0) as RPC_IF_ID ptr
end type

#ifdef UNICODE
	#define RpcBindingFromStringBinding RpcBindingFromStringBindingW
	#define RpcBindingToStringBinding RpcBindingToStringBindingW
	#define RpcStringBindingCompose RpcStringBindingComposeW
	#define RpcStringBindingParse RpcStringBindingParseW
	#define RpcStringFree RpcStringFreeW
	#define RpcNetworkIsProtseqValid RpcNetworkIsProtseqValidW
	#define RpcNetworkInqProtseqs RpcNetworkInqProtseqsW
	#define RpcProtseqVectorFree RpcProtseqVectorFreeW
	#define RpcServerUseProtseq RpcServerUseProtseqW
	#define RpcServerUseProtseqEx RpcServerUseProtseqExW
	#define RpcServerUseProtseqEp RpcServerUseProtseqEpW
	#define RpcServerUseProtseqEpEx RpcServerUseProtseqEpExW
	#define RpcServerUseProtseqIf RpcServerUseProtseqIfW
	#define RpcServerUseProtseqIfEx RpcServerUseProtseqIfExW
	#define RpcMgmtInqServerPrincName RpcMgmtInqServerPrincNameW
	#define RpcServerInqDefaultPrincName RpcServerInqDefaultPrincNameW
	#define RpcNsBindingInqEntryName RpcNsBindingInqEntryNameW
#else
	#define RpcBindingFromStringBinding RpcBindingFromStringBindingA
	#define RpcBindingToStringBinding RpcBindingToStringBindingA
	#define RpcStringBindingCompose RpcStringBindingComposeA
	#define RpcStringBindingParse RpcStringBindingParseA
	#define RpcStringFree RpcStringFreeA
	#define RpcNetworkIsProtseqValid RpcNetworkIsProtseqValidA
	#define RpcNetworkInqProtseqs RpcNetworkInqProtseqsA
	#define RpcProtseqVectorFree RpcProtseqVectorFreeA
	#define RpcServerUseProtseq RpcServerUseProtseqA
	#define RpcServerUseProtseqEx RpcServerUseProtseqExA
	#define RpcServerUseProtseqEp RpcServerUseProtseqEpA
	#define RpcServerUseProtseqEpEx RpcServerUseProtseqEpExA
	#define RpcServerUseProtseqIf RpcServerUseProtseqIfA
	#define RpcServerUseProtseqIfEx RpcServerUseProtseqIfExA
	#define RpcMgmtInqServerPrincName RpcMgmtInqServerPrincNameA
	#define RpcServerInqDefaultPrincName RpcServerInqDefaultPrincNameA
	#define RpcNsBindingInqEntryName RpcNsBindingInqEntryNameA
#endif

declare function RpcBindingCopy(byval SourceBinding as RPC_BINDING_HANDLE, byval DestinationBinding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingFree(byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingSetOption(byval hBinding as RPC_BINDING_HANDLE, byval option_ as ulong, byval optionValue as ULONG_PTR) as RPC_STATUS
declare function RpcBindingInqOption(byval hBinding as RPC_BINDING_HANDLE, byval option_ as ulong, byval pOptionValue as ULONG_PTR ptr) as RPC_STATUS
declare function RpcBindingFromStringBindingA(byval StringBinding as RPC_CSTR, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingFromStringBindingW(byval StringBinding as RPC_WSTR, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcSsGetContextBinding(byval ContextHandle as any ptr, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingInqObject(byval Binding as RPC_BINDING_HANDLE, byval ObjectUuid as UUID ptr) as RPC_STATUS
declare function RpcBindingReset(byval Binding as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcBindingSetObject(byval Binding as RPC_BINDING_HANDLE, byval ObjectUuid as UUID ptr) as RPC_STATUS
declare function RpcMgmtInqDefaultProtectLevel(byval AuthnSvc as ulong, byval AuthnLevel as ulong ptr) as RPC_STATUS
declare function RpcBindingToStringBindingA(byval Binding as RPC_BINDING_HANDLE, byval StringBinding as RPC_CSTR ptr) as RPC_STATUS
declare function RpcBindingToStringBindingW(byval Binding as RPC_BINDING_HANDLE, byval StringBinding as RPC_WSTR ptr) as RPC_STATUS
declare function RpcBindingVectorFree(byval BindingVector as RPC_BINDING_VECTOR ptr ptr) as RPC_STATUS
declare function RpcStringBindingComposeA(byval ObjUuid as RPC_CSTR, byval Protseq as RPC_CSTR, byval NetworkAddr as RPC_CSTR, byval Endpoint as RPC_CSTR, byval Options as RPC_CSTR, byval StringBinding as RPC_CSTR ptr) as RPC_STATUS
declare function RpcStringBindingComposeW(byval ObjUuid as RPC_WSTR, byval Protseq as RPC_WSTR, byval NetworkAddr as RPC_WSTR, byval Endpoint as RPC_WSTR, byval Options as RPC_WSTR, byval StringBinding as RPC_WSTR ptr) as RPC_STATUS
declare function RpcStringBindingParseA(byval StringBinding as RPC_CSTR, byval ObjUuid as RPC_CSTR ptr, byval Protseq as RPC_CSTR ptr, byval NetworkAddr as RPC_CSTR ptr, byval Endpoint as RPC_CSTR ptr, byval NetworkOptions as RPC_CSTR ptr) as RPC_STATUS
declare function RpcStringBindingParseW(byval StringBinding as RPC_WSTR, byval ObjUuid as RPC_WSTR ptr, byval Protseq as RPC_WSTR ptr, byval NetworkAddr as RPC_WSTR ptr, byval Endpoint as RPC_WSTR ptr, byval NetworkOptions as RPC_WSTR ptr) as RPC_STATUS
declare function RpcStringFreeA(byval String_ as RPC_CSTR ptr) as RPC_STATUS
declare function RpcStringFreeW(byval String_ as RPC_WSTR ptr) as RPC_STATUS
declare function RpcIfInqId(byval RpcIfHandle as RPC_IF_HANDLE, byval RpcIfId as RPC_IF_ID ptr) as RPC_STATUS
declare function RpcNetworkIsProtseqValidA(byval Protseq as RPC_CSTR) as RPC_STATUS
declare function RpcNetworkIsProtseqValidW(byval Protseq as RPC_WSTR) as RPC_STATUS
declare function RpcMgmtInqComTimeout(byval Binding as RPC_BINDING_HANDLE, byval Timeout as ulong ptr) as RPC_STATUS
declare function RpcMgmtSetComTimeout(byval Binding as RPC_BINDING_HANDLE, byval Timeout as ulong) as RPC_STATUS
declare function RpcMgmtSetCancelTimeout(byval Timeout as long) as RPC_STATUS
declare function RpcNetworkInqProtseqsA(byval ProtseqVector as RPC_PROTSEQ_VECTORA ptr ptr) as RPC_STATUS
declare function RpcNetworkInqProtseqsW(byval ProtseqVector as RPC_PROTSEQ_VECTORW ptr ptr) as RPC_STATUS
declare function RpcObjectInqType(byval ObjUuid as UUID ptr, byval TypeUuid as UUID ptr) as RPC_STATUS
declare function RpcObjectSetInqFn(byval InquiryFn as sub(byval ObjectUuid as UUID ptr, byval TypeUuid as UUID ptr, byval Status as RPC_STATUS ptr)) as RPC_STATUS
declare function RpcObjectSetType(byval ObjUuid as UUID ptr, byval TypeUuid as UUID ptr) as RPC_STATUS
declare function RpcProtseqVectorFreeA(byval ProtseqVector as RPC_PROTSEQ_VECTORA ptr ptr) as RPC_STATUS
declare function RpcProtseqVectorFreeW(byval ProtseqVector as RPC_PROTSEQ_VECTORW ptr ptr) as RPC_STATUS
declare function RpcServerInqBindings(byval BindingVector as RPC_BINDING_VECTOR ptr ptr) as RPC_STATUS
declare function RpcServerInqIf(byval IfSpec as RPC_IF_HANDLE, byval MgrTypeUuid as UUID ptr, byval MgrEpv as any ptr ptr) as RPC_STATUS
declare function RpcServerListen(byval MinimumCallThreads as ulong, byval MaxCalls as ulong, byval DontWait as ulong) as RPC_STATUS
declare function RpcServerRegisterIf(byval IfSpec as RPC_IF_HANDLE, byval MgrTypeUuid as UUID ptr, byval MgrEpv as any ptr) as RPC_STATUS
declare function RpcServerRegisterIfEx(byval IfSpec as RPC_IF_HANDLE, byval MgrTypeUuid as UUID ptr, byval MgrEpv as any ptr, byval Flags as ulong, byval MaxCalls as ulong, byval IfCallback as function(byval InterfaceUuid as RPC_IF_HANDLE, byval Context as any ptr) as RPC_STATUS) as RPC_STATUS
declare function RpcServerRegisterIf2(byval IfSpec as RPC_IF_HANDLE, byval MgrTypeUuid as UUID ptr, byval MgrEpv as any ptr, byval Flags as ulong, byval MaxCalls as ulong, byval MaxRpcSize as ulong, byval IfCallbackFn as function(byval InterfaceUuid as RPC_IF_HANDLE, byval Context as any ptr) as RPC_STATUS) as RPC_STATUS
declare function RpcServerUnregisterIf(byval IfSpec as RPC_IF_HANDLE, byval MgrTypeUuid as UUID ptr, byval WaitForCallsToComplete as ulong) as RPC_STATUS
declare function RpcServerUnregisterIfEx(byval IfSpec as RPC_IF_HANDLE, byval MgrTypeUuid as UUID ptr, byval RundownContextHandles as long) as RPC_STATUS
declare function RpcServerUseAllProtseqs(byval MaxCalls as ulong, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseAllProtseqsEx(byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseAllProtseqsIf(byval MaxCalls as ulong, byval IfSpec as RPC_IF_HANDLE, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseAllProtseqsIfEx(byval MaxCalls as ulong, byval IfSpec as RPC_IF_HANDLE, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqA(byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqExA(byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqW(byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqExW(byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqEpA(byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval Endpoint as RPC_CSTR, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqEpExA(byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval Endpoint as RPC_CSTR, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqEpW(byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval Endpoint as RPC_WSTR, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqEpExW(byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval Endpoint as RPC_WSTR, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqIfA(byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval IfSpec as RPC_IF_HANDLE, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqIfExA(byval Protseq as RPC_CSTR, byval MaxCalls as ulong, byval IfSpec as RPC_IF_HANDLE, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqIfW(byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval IfSpec as RPC_IF_HANDLE, byval SecurityDescriptor as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqIfExW(byval Protseq as RPC_WSTR, byval MaxCalls as ulong, byval IfSpec as RPC_IF_HANDLE, byval SecurityDescriptor as any ptr, byval Policy as PRPC_POLICY) as RPC_STATUS
declare sub RpcServerYield()
declare function RpcMgmtStatsVectorFree(byval StatsVector as RPC_STATS_VECTOR ptr ptr) as RPC_STATUS
declare function RpcMgmtInqStats(byval Binding as RPC_BINDING_HANDLE, byval Statistics as RPC_STATS_VECTOR ptr ptr) as RPC_STATUS
declare function RpcMgmtIsServerListening(byval Binding as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcMgmtStopServerListening(byval Binding as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcMgmtWaitServerListen() as RPC_STATUS
declare function RpcMgmtSetServerStackSize(byval ThreadStackSize as ulong) as RPC_STATUS
declare sub RpcSsDontSerializeContext()
declare function RpcMgmtEnableIdleCleanup() as RPC_STATUS
declare function RpcMgmtInqIfIds(byval Binding as RPC_BINDING_HANDLE, byval IfIdVector as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcIfIdVectorFree(byval IfIdVector as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcMgmtInqServerPrincNameA(byval Binding as RPC_BINDING_HANDLE, byval AuthnSvc as ulong, byval ServerPrincName as RPC_CSTR ptr) as RPC_STATUS
declare function RpcMgmtInqServerPrincNameW(byval Binding as RPC_BINDING_HANDLE, byval AuthnSvc as ulong, byval ServerPrincName as RPC_WSTR ptr) as RPC_STATUS
declare function RpcServerInqDefaultPrincNameA(byval AuthnSvc as ulong, byval PrincName as RPC_CSTR ptr) as RPC_STATUS
declare function RpcServerInqDefaultPrincNameW(byval AuthnSvc as ulong, byval PrincName as RPC_WSTR ptr) as RPC_STATUS
declare function RpcEpResolveBinding(byval Binding as RPC_BINDING_HANDLE, byval IfSpec as RPC_IF_HANDLE) as RPC_STATUS
declare function RpcNsBindingInqEntryNameA(byval Binding as RPC_BINDING_HANDLE, byval EntryNameSyntax as ulong, byval EntryName as RPC_CSTR ptr) as RPC_STATUS
declare function RpcNsBindingInqEntryNameW(byval Binding as RPC_BINDING_HANDLE, byval EntryNameSyntax as ulong, byval EntryName as RPC_WSTR ptr) as RPC_STATUS

type RPC_AUTH_IDENTITY_HANDLE as any ptr
type RPC_AUTHZ_HANDLE as any ptr

#define RPC_C_AUTHN_LEVEL_DEFAULT 0
#define RPC_C_AUTHN_LEVEL_NONE 1
#define RPC_C_AUTHN_LEVEL_CONNECT 2
#define RPC_C_AUTHN_LEVEL_CALL 3
#define RPC_C_AUTHN_LEVEL_PKT 4
#define RPC_C_AUTHN_LEVEL_PKT_INTEGRITY 5
#define RPC_C_AUTHN_LEVEL_PKT_PRIVACY 6
#define RPC_C_IMP_LEVEL_DEFAULT 0
#define RPC_C_IMP_LEVEL_ANONYMOUS 1
#define RPC_C_IMP_LEVEL_IDENTIFY 2
#define RPC_C_IMP_LEVEL_IMPERSONATE 3
#define RPC_C_IMP_LEVEL_DELEGATE 4
#define RPC_C_QOS_IDENTITY_STATIC 0
#define RPC_C_QOS_IDENTITY_DYNAMIC 1
#define RPC_C_QOS_CAPABILITIES_DEFAULT &h0
#define RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH &h1
#define RPC_C_QOS_CAPABILITIES_MAKE_FULLSIC &h2
#define RPC_C_QOS_CAPABILITIES_ANY_AUTHORITY &h4
#define RPC_C_QOS_CAPABILITIES_IGNORE_DELEGATE_FAILURE &h8
#define RPC_C_QOS_CAPABILITIES_LOCAL_MA_HINT &h10
#define RPC_C_PROTECT_LEVEL_DEFAULT RPC_C_AUTHN_LEVEL_DEFAULT
#define RPC_C_PROTECT_LEVEL_NONE RPC_C_AUTHN_LEVEL_NONE
#define RPC_C_PROTECT_LEVEL_CONNECT RPC_C_AUTHN_LEVEL_CONNECT
#define RPC_C_PROTECT_LEVEL_CALL RPC_C_AUTHN_LEVEL_CALL
#define RPC_C_PROTECT_LEVEL_PKT RPC_C_AUTHN_LEVEL_PKT
#define RPC_C_PROTECT_LEVEL_PKT_INTEGRITY RPC_C_AUTHN_LEVEL_PKT_INTEGRITY
#define RPC_C_PROTECT_LEVEL_PKT_PRIVACY RPC_C_AUTHN_LEVEL_PKT_PRIVACY
#define RPC_C_AUTHN_NONE 0
#define RPC_C_AUTHN_DCE_PRIVATE 1
#define RPC_C_AUTHN_DCE_PUBLIC 2
#define RPC_C_AUTHN_DEC_PUBLIC 4
#define RPC_C_AUTHN_GSS_NEGOTIATE 9
#define RPC_C_AUTHN_WINNT 10
#define RPC_C_AUTHN_GSS_SCHANNEL 14
#define RPC_C_AUTHN_GSS_KERBEROS 16
#define RPC_C_AUTHN_DPA 17
#define RPC_C_AUTHN_MSN 18
#define RPC_C_AUTHN_DIGEST 21
#define RPC_C_AUTHN_MQ 100
#define RPC_C_AUTHN_DEFAULT __MSABI_LONG(&hFFFFFFFF)
#define RPC_C_NO_CREDENTIALS cast(RPC_AUTH_IDENTITY_HANDLE, MAXUINT_PTR)
#define RPC_C_SECURITY_QOS_VERSION __MSABI_LONG(1)
#define RPC_C_SECURITY_QOS_VERSION_1 __MSABI_LONG(1)

type _RPC_SECURITY_QOS
	Version as ulong
	Capabilities as ulong
	IdentityTracking as ulong
	ImpersonationType as ulong
end type

type RPC_SECURITY_QOS as _RPC_SECURITY_QOS
type PRPC_SECURITY_QOS as _RPC_SECURITY_QOS ptr

#define _AUTH_IDENTITY_DEFINED
#define SEC_WINNT_AUTH_IDENTITY_ANSI &h1
#define SEC_WINNT_AUTH_IDENTITY_UNICODE &h2

type _SEC_WINNT_AUTH_IDENTITY_W
	User as ushort ptr
	UserLength as ulong
	Domain as ushort ptr
	DomainLength as ulong
	Password as ushort ptr
	PasswordLength as ulong
	Flags as ulong
end type

type SEC_WINNT_AUTH_IDENTITY_W as _SEC_WINNT_AUTH_IDENTITY_W
type PSEC_WINNT_AUTH_IDENTITY_W as _SEC_WINNT_AUTH_IDENTITY_W ptr

type _SEC_WINNT_AUTH_IDENTITY_A
	User as ubyte ptr
	UserLength as ulong
	Domain as ubyte ptr
	DomainLength as ulong
	Password as ubyte ptr
	PasswordLength as ulong
	Flags as ulong
end type

type SEC_WINNT_AUTH_IDENTITY_A as _SEC_WINNT_AUTH_IDENTITY_A
type PSEC_WINNT_AUTH_IDENTITY_A as _SEC_WINNT_AUTH_IDENTITY_A ptr

#ifdef UNICODE
	#define SEC_WINNT_AUTH_IDENTITY SEC_WINNT_AUTH_IDENTITY_W
	#define PSEC_WINNT_AUTH_IDENTITY PSEC_WINNT_AUTH_IDENTITY_W
	#define _SEC_WINNT_AUTH_IDENTITY _SEC_WINNT_AUTH_IDENTITY_W
#else
	#define SEC_WINNT_AUTH_IDENTITY SEC_WINNT_AUTH_IDENTITY_A
	#define PSEC_WINNT_AUTH_IDENTITY PSEC_WINNT_AUTH_IDENTITY_A
	#define _SEC_WINNT_AUTH_IDENTITY _SEC_WINNT_AUTH_IDENTITY_A
#endif

#define RPC_C_SECURITY_QOS_VERSION_2 __MSABI_LONG(2)
#define RPC_C_AUTHN_INFO_TYPE_HTTP 1
#define RPC_C_HTTP_AUTHN_TARGET_SERVER 1
#define RPC_C_HTTP_AUTHN_TARGET_PROXY 2
#define RPC_C_HTTP_AUTHN_SCHEME_BASIC &h00000001
#define RPC_C_HTTP_AUTHN_SCHEME_NTLM &h00000002
#define RPC_C_HTTP_AUTHN_SCHEME_PASSPORT &h00000004
#define RPC_C_HTTP_AUTHN_SCHEME_DIGEST &h00000008
#define RPC_C_HTTP_AUTHN_SCHEME_NEGOTIATE &h00000010
#define RPC_C_HTTP_AUTHN_SCHEME_CERT &h00010000
#define RPC_C_HTTP_FLAG_USE_SSL 1
#define RPC_C_HTTP_FLAG_USE_FIRST_AUTH_SCHEME 2
#define RPC_C_HTTP_FLAG_IGNORE_CERT_CN_INVALID 8

type _RPC_HTTP_TRANSPORT_CREDENTIALS_W
	TransportCredentials as SEC_WINNT_AUTH_IDENTITY_W ptr
	Flags as ulong
	AuthenticationTarget as ulong
	NumberOfAuthnSchemes as ulong
	AuthnSchemes as ulong ptr
	ServerCertificateSubject as ushort ptr
end type

type RPC_HTTP_TRANSPORT_CREDENTIALS_W as _RPC_HTTP_TRANSPORT_CREDENTIALS_W
type PRPC_HTTP_TRANSPORT_CREDENTIALS_W as _RPC_HTTP_TRANSPORT_CREDENTIALS_W ptr

type _RPC_HTTP_TRANSPORT_CREDENTIALS_A
	TransportCredentials as SEC_WINNT_AUTH_IDENTITY_A ptr
	Flags as ulong
	AuthenticationTarget as ulong
	NumberOfAuthnSchemes as ulong
	AuthnSchemes as ulong ptr
	ServerCertificateSubject as ubyte ptr
end type

type RPC_HTTP_TRANSPORT_CREDENTIALS_A as _RPC_HTTP_TRANSPORT_CREDENTIALS_A
type PRPC_HTTP_TRANSPORT_CREDENTIALS_A as _RPC_HTTP_TRANSPORT_CREDENTIALS_A ptr

union ___RPC_SECURITY_QOS_V2_W_u
	HttpCredentials as RPC_HTTP_TRANSPORT_CREDENTIALS_W ptr
end union

type _RPC_SECURITY_QOS_V2_W
	Version as ulong
	Capabilities as ulong
	IdentityTracking as ulong
	ImpersonationType as ulong
	AdditionalSecurityInfoType as ulong
	u as ___RPC_SECURITY_QOS_V2_W_u
end type

type RPC_SECURITY_QOS_V2_W as _RPC_SECURITY_QOS_V2_W
type PRPC_SECURITY_QOS_V2_W as _RPC_SECURITY_QOS_V2_W ptr

union ___RPC_SECURITY_QOS_V2_A_u
	HttpCredentials as RPC_HTTP_TRANSPORT_CREDENTIALS_A ptr
end union

type _RPC_SECURITY_QOS_V2_A
	Version as ulong
	Capabilities as ulong
	IdentityTracking as ulong
	ImpersonationType as ulong
	AdditionalSecurityInfoType as ulong
	u as ___RPC_SECURITY_QOS_V2_A_u
end type

type RPC_SECURITY_QOS_V2_A as _RPC_SECURITY_QOS_V2_A
type PRPC_SECURITY_QOS_V2_A as _RPC_SECURITY_QOS_V2_A ptr

#define RPC_C_SECURITY_QOS_VERSION_3 __MSABI_LONG(3)

union ___RPC_SECURITY_QOS_V3_W_u
	HttpCredentials as RPC_HTTP_TRANSPORT_CREDENTIALS_W ptr
end union

type _RPC_SECURITY_QOS_V3_W
	Version as ulong
	Capabilities as ulong
	IdentityTracking as ulong
	ImpersonationType as ulong
	AdditionalSecurityInfoType as ulong
	u as ___RPC_SECURITY_QOS_V3_W_u
	Sid as any ptr
end type

type RPC_SECURITY_QOS_V3_W as _RPC_SECURITY_QOS_V3_W
type PRPC_SECURITY_QOS_V3_W as _RPC_SECURITY_QOS_V3_W ptr

union ___RPC_SECURITY_QOS_V3_A_u
	HttpCredentials as RPC_HTTP_TRANSPORT_CREDENTIALS_A ptr
end union

type _RPC_SECURITY_QOS_V3_A
	Version as ulong
	Capabilities as ulong
	IdentityTracking as ulong
	ImpersonationType as ulong
	AdditionalSecurityInfoType as ulong
	u as ___RPC_SECURITY_QOS_V3_A_u
	Sid as any ptr
end type

type RPC_SECURITY_QOS_V3_A as _RPC_SECURITY_QOS_V3_A
type PRPC_SECURITY_QOS_V3_A as _RPC_SECURITY_QOS_V3_A ptr

#ifdef UNICODE
	#define RPC_SECURITY_QOS_V2 RPC_SECURITY_QOS_V2_W
	#define PRPC_SECURITY_QOS_V2 PRPC_SECURITY_QOS_V2_W
	#define _RPC_SECURITY_QOS_V2 _RPC_SECURITY_QOS_V2_W
	#define RPC_HTTP_TRANSPORT_CREDENTIALS RPC_HTTP_TRANSPORT_CREDENTIALS_W
	#define PRPC_HTTP_TRANSPORT_CREDENTIALS PRPC_HTTP_TRANSPORT_CREDENTIALS_W
	#define _RPC_HTTP_TRANSPORT_CREDENTIALS _RPC_HTTP_TRANSPORT_CREDENTIALS_W
	#define RPC_SECURITY_QOS_V3 RPC_SECURITY_QOS_V3_W
	#define PRPC_SECURITY_QOS_V3 PRPC_SECURITY_QOS_V3_W
	#define _RPC_SECURITY_QOS_V3 _RPC_SECURITY_QOS_V3_W
#else
	#define RPC_SECURITY_QOS_V2 RPC_SECURITY_QOS_V2_A
	#define PRPC_SECURITY_QOS_V2 PRPC_SECURITY_QOS_V2_A
	#define _RPC_SECURITY_QOS_V2 _RPC_SECURITY_QOS_V2_A
	#define RPC_HTTP_TRANSPORT_CREDENTIALS RPC_HTTP_TRANSPORT_CREDENTIALS_A
	#define PRPC_HTTP_TRANSPORT_CREDENTIALS PRPC_HTTP_TRANSPORT_CREDENTIALS_A
	#define _RPC_HTTP_TRANSPORT_CREDENTIALS _RPC_HTTP_TRANSPORT_CREDENTIALS_A
	#define RPC_SECURITY_QOS_V3 RPC_SECURITY_QOS_V3_A
	#define PRPC_SECURITY_QOS_V3 PRPC_SECURITY_QOS_V3_A
	#define _RPC_SECURITY_QOS_V3 _RPC_SECURITY_QOS_V3_A
#endif

type _RPC_HTTP_REDIRECTOR_STAGE as long
enum
	RPCHTTP_RS_REDIRECT = 1
	RPCHTTP_RS_ACCESS_1
	RPCHTTP_RS_SESSION
	RPCHTTP_RS_ACCESS_2
	RPCHTTP_RS_INTERFACE
end enum

type RPC_HTTP_REDIRECTOR_STAGE as _RPC_HTTP_REDIRECTOR_STAGE
type RPC_NEW_HTTP_PROXY_CHANNEL as function(byval RedirectorStage as RPC_HTTP_REDIRECTOR_STAGE, byval ServerName as ushort ptr, byval ServerPort as ushort ptr, byval RemoteUser as ushort ptr, byval AuthType as ushort ptr, byval ResourceUuid as any ptr, byval Metadata as any ptr, byval SessionId as any ptr, byval Interface as any ptr, byval Reserved as any ptr, byval Flags as ulong, byval NewServerName as ushort ptr ptr, byval NewServerPort as ushort ptr ptr) as RPC_STATUS
type RPC_HTTP_PROXY_FREE_STRING as sub(byval String_ as ushort ptr)

#define RPC_C_AUTHZ_NONE 0
#define RPC_C_AUTHZ_NAME 1
#define RPC_C_AUTHZ_DCE 2
#define RPC_C_AUTHZ_DEFAULT &hffffffff

declare function RpcImpersonateClient(byval BindingHandle as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcRevertToSelfEx(byval BindingHandle as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcRevertToSelf() as RPC_STATUS
declare function RpcBindingInqAuthClientA(byval ClientBinding as RPC_BINDING_HANDLE, byval Privs as RPC_AUTHZ_HANDLE ptr, byval ServerPrincName as RPC_CSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthzSvc as ulong ptr) as RPC_STATUS
declare function RpcBindingInqAuthClientW(byval ClientBinding as RPC_BINDING_HANDLE, byval Privs as RPC_AUTHZ_HANDLE ptr, byval ServerPrincName as RPC_WSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthzSvc as ulong ptr) as RPC_STATUS
declare function RpcBindingInqAuthClientExA(byval ClientBinding as RPC_BINDING_HANDLE, byval Privs as RPC_AUTHZ_HANDLE ptr, byval ServerPrincName as RPC_CSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthzSvc as ulong ptr, byval Flags as ulong) as RPC_STATUS
declare function RpcBindingInqAuthClientExW(byval ClientBinding as RPC_BINDING_HANDLE, byval Privs as RPC_AUTHZ_HANDLE ptr, byval ServerPrincName as RPC_WSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthzSvc as ulong ptr, byval Flags as ulong) as RPC_STATUS
declare function RpcBindingInqAuthInfoA(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_CSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE ptr, byval AuthzSvc as ulong ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfoW(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_WSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE ptr, byval AuthzSvc as ulong ptr) as RPC_STATUS
declare function RpcBindingSetAuthInfoA(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_CSTR, byval AuthnLevel as ulong, byval AuthnSvc as ulong, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE, byval AuthzSvc as ulong) as RPC_STATUS
declare function RpcBindingSetAuthInfoExA(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_CSTR, byval AuthnLevel as ulong, byval AuthnSvc as ulong, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE, byval AuthzSvc as ulong, byval SecurityQos as RPC_SECURITY_QOS ptr) as RPC_STATUS
declare function RpcBindingSetAuthInfoW(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_WSTR, byval AuthnLevel as ulong, byval AuthnSvc as ulong, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE, byval AuthzSvc as ulong) as RPC_STATUS
declare function RpcBindingSetAuthInfoExW(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_WSTR, byval AuthnLevel as ulong, byval AuthnSvc as ulong, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE, byval AuthzSvc as ulong, byval SecurityQOS as RPC_SECURITY_QOS ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfoExA(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_CSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE ptr, byval AuthzSvc as ulong ptr, byval RpcQosVersion as ulong, byval SecurityQOS as RPC_SECURITY_QOS ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfoExW(byval Binding as RPC_BINDING_HANDLE, byval ServerPrincName as RPC_WSTR ptr, byval AuthnLevel as ulong ptr, byval AuthnSvc as ulong ptr, byval AuthIdentity as RPC_AUTH_IDENTITY_HANDLE ptr, byval AuthzSvc as ulong ptr, byval RpcQosVersion as ulong, byval SecurityQOS as RPC_SECURITY_QOS ptr) as RPC_STATUS

type RPC_AUTH_KEY_RETRIEVAL_FN as sub(byval Arg as any ptr, byval ServerPrincName as ushort ptr, byval KeyVer as ulong, byval Key as any ptr ptr, byval Status as RPC_STATUS ptr)

declare function RpcServerRegisterAuthInfoA(byval ServerPrincName as RPC_CSTR, byval AuthnSvc as ulong, byval GetKeyFn as RPC_AUTH_KEY_RETRIEVAL_FN, byval Arg as any ptr) as RPC_STATUS
declare function RpcServerRegisterAuthInfoW(byval ServerPrincName as RPC_WSTR, byval AuthnSvc as ulong, byval GetKeyFn as RPC_AUTH_KEY_RETRIEVAL_FN, byval Arg as any ptr) as RPC_STATUS

#ifdef UNICODE
	#define RpcBindingInqAuthClient RpcBindingInqAuthClientW
	#define RpcBindingInqAuthClientEx RpcBindingInqAuthClientExW
	#define RpcBindingInqAuthInfo RpcBindingInqAuthInfoW
	#define RpcBindingSetAuthInfo RpcBindingSetAuthInfoW
	#define RpcServerRegisterAuthInfo RpcServerRegisterAuthInfoW
	#define RpcBindingInqAuthInfoEx RpcBindingInqAuthInfoExW
	#define RpcBindingSetAuthInfoEx RpcBindingSetAuthInfoExW
#else
	#define RpcBindingInqAuthClient RpcBindingInqAuthClientA
	#define RpcBindingInqAuthClientEx RpcBindingInqAuthClientExA
	#define RpcBindingInqAuthInfo RpcBindingInqAuthInfoA
	#define RpcBindingSetAuthInfo RpcBindingSetAuthInfoA
	#define RpcServerRegisterAuthInfo RpcServerRegisterAuthInfoA
	#define RpcBindingInqAuthInfoEx RpcBindingInqAuthInfoExA
	#define RpcBindingSetAuthInfoEx RpcBindingSetAuthInfoExA
#endif

type RPC_CLIENT_INFORMATION1
	UserName as ubyte ptr
	ComputerName as ubyte ptr
	Privilege as ushort
	AuthFlags as ulong
end type

type PRPC_CLIENT_INFORMATION1 as RPC_CLIENT_INFORMATION1 ptr

#ifdef UNICODE
	#define UuidFromString UuidFromStringW
	#define UuidToString UuidToStringW
	#define RpcEpRegisterNoReplace RpcEpRegisterNoReplaceW
	#define RpcEpRegister RpcEpRegisterW
	#define DceErrorInqText DceErrorInqTextW
#else
	#define UuidFromString UuidFromStringA
	#define UuidToString UuidToStringA
	#define RpcEpRegisterNoReplace RpcEpRegisterNoReplaceA
	#define RpcEpRegister RpcEpRegisterA
	#define DceErrorInqText DceErrorInqTextA
#endif

#define DCE_C_ERROR_STRING_LEN 256

declare function RpcBindingServerFromClient(byval ClientBinding as RPC_BINDING_HANDLE, byval ServerBinding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare sub RpcRaiseException(byval exception as RPC_STATUS)
declare function RpcTestCancel() as RPC_STATUS
declare function RpcServerTestCancel(byval BindingHandle as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcCancelThread(byval Thread as any ptr) as RPC_STATUS
declare function RpcCancelThreadEx(byval Thread as any ptr, byval Timeout as long) as RPC_STATUS
declare function UuidCreate(byval Uuid as UUID ptr) as RPC_STATUS
declare function UuidCreateSequential(byval Uuid as UUID ptr) as RPC_STATUS
declare function UuidToStringA(byval Uuid as UUID ptr, byval StringUuid as RPC_CSTR ptr) as RPC_STATUS
declare function UuidFromStringA(byval StringUuid as RPC_CSTR, byval Uuid as UUID ptr) as RPC_STATUS
declare function UuidToStringW(byval Uuid as UUID ptr, byval StringUuid as RPC_WSTR ptr) as RPC_STATUS
declare function UuidFromStringW(byval StringUuid as RPC_WSTR, byval Uuid as UUID ptr) as RPC_STATUS
declare function UuidCompare(byval Uuid1 as UUID ptr, byval Uuid2 as UUID ptr, byval Status as RPC_STATUS ptr) as long
declare function UuidCreateNil(byval NilUuid as UUID ptr) as RPC_STATUS
declare function UuidEqual(byval Uuid1 as UUID ptr, byval Uuid2 as UUID ptr, byval Status as RPC_STATUS ptr) as long
declare function UuidHash(byval Uuid as UUID ptr, byval Status as RPC_STATUS ptr) as ushort
declare function UuidIsNil(byval Uuid as UUID ptr, byval Status as RPC_STATUS ptr) as long
declare function RpcEpRegisterNoReplaceA(byval IfSpec as RPC_IF_HANDLE, byval BindingVector as RPC_BINDING_VECTOR ptr, byval UuidVector as UUID_VECTOR ptr, byval Annotation as RPC_CSTR) as RPC_STATUS
declare function RpcEpRegisterNoReplaceW(byval IfSpec as RPC_IF_HANDLE, byval BindingVector as RPC_BINDING_VECTOR ptr, byval UuidVector as UUID_VECTOR ptr, byval Annotation as RPC_WSTR) as RPC_STATUS
declare function RpcEpRegisterA(byval IfSpec as RPC_IF_HANDLE, byval BindingVector as RPC_BINDING_VECTOR ptr, byval UuidVector as UUID_VECTOR ptr, byval Annotation as RPC_CSTR) as RPC_STATUS
declare function RpcEpRegisterW(byval IfSpec as RPC_IF_HANDLE, byval BindingVector as RPC_BINDING_VECTOR ptr, byval UuidVector as UUID_VECTOR ptr, byval Annotation as RPC_WSTR) as RPC_STATUS
declare function RpcEpUnregister(byval IfSpec as RPC_IF_HANDLE, byval BindingVector as RPC_BINDING_VECTOR ptr, byval UuidVector as UUID_VECTOR ptr) as RPC_STATUS
declare function DceErrorInqTextA(byval RpcStatus as RPC_STATUS, byval ErrorText as RPC_CSTR) as RPC_STATUS
declare function DceErrorInqTextW(byval RpcStatus as RPC_STATUS, byval ErrorText as RPC_WSTR) as RPC_STATUS

type RPC_EP_INQ_HANDLE as I_RPC_HANDLE ptr

#define RPC_C_EP_ALL_ELTS 0
#define RPC_C_EP_MATCH_BY_IF 1
#define RPC_C_EP_MATCH_BY_OBJ 2
#define RPC_C_EP_MATCH_BY_BOTH 3
#define RPC_C_VERS_ALL 1
#define RPC_C_VERS_COMPATIBLE 2
#define RPC_C_VERS_EXACT 3
#define RPC_C_VERS_MAJOR_ONLY 4
#define RPC_C_VERS_UPTO 5

#ifdef UNICODE
	#define RpcMgmtEpEltInqNext RpcMgmtEpEltInqNextW
#else
	#define RpcMgmtEpEltInqNext RpcMgmtEpEltInqNextA
#endif

declare function RpcMgmtEpEltInqBegin(byval EpBinding as RPC_BINDING_HANDLE, byval InquiryType as ulong, byval IfId as RPC_IF_ID ptr, byval VersOption as ulong, byval ObjectUuid as UUID ptr, byval InquiryContext as RPC_EP_INQ_HANDLE ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqDone(byval InquiryContext as RPC_EP_INQ_HANDLE ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqNextA(byval InquiryContext as RPC_EP_INQ_HANDLE, byval IfId as RPC_IF_ID ptr, byval Binding as RPC_BINDING_HANDLE ptr, byval ObjectUuid as UUID ptr, byval Annotation as RPC_CSTR ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqNextW(byval InquiryContext as RPC_EP_INQ_HANDLE, byval IfId as RPC_IF_ID ptr, byval Binding as RPC_BINDING_HANDLE ptr, byval ObjectUuid as UUID ptr, byval Annotation as RPC_WSTR ptr) as RPC_STATUS
declare function RpcMgmtEpUnregister(byval EpBinding as RPC_BINDING_HANDLE, byval IfId as RPC_IF_ID ptr, byval Binding as RPC_BINDING_HANDLE, byval ObjectUuid as UUID ptr) as RPC_STATUS

type RPC_MGMT_AUTHORIZATION_FN as function(byval ClientBinding as RPC_BINDING_HANDLE, byval RequestedMgmtOperation as ulong, byval Status as RPC_STATUS ptr) as long

#define RPC_C_MGMT_INQ_IF_IDS 0
#define RPC_C_MGMT_INQ_PRINC_NAME 1
#define RPC_C_MGMT_INQ_STATS 2
#define RPC_C_MGMT_IS_SERVER_LISTEN 3
#define RPC_C_MGMT_STOP_SERVER_LISTEN 4

declare function RpcMgmtSetAuthorizationFn(byval AuthorizationFn as RPC_MGMT_AUTHORIZATION_FN) as RPC_STATUS

#define RPC_C_PARM_MAX_PACKET_LENGTH 1
#define RPC_C_PARM_BUFFER_LENGTH 2
#define RPC_IF_AUTOLISTEN &h0001
#define RPC_IF_OLE &h0002
#define RPC_IF_ALLOW_UNKNOWN_AUTHORITY &h0004
#define RPC_IF_ALLOW_SECURE_ONLY &h0008
#define RPC_IF_ALLOW_CALLBACKS_WITH_NO_AUTH &h0010
#define RPC_IF_ALLOW_LOCAL_ONLY &h0020
#define RPC_IF_SEC_NO_CACHE &h0040

#if _WIN32_WINNT = &h0602
	type _RPC_BINDING_HANDLE_OPTIONS_V1
		Version as ulong
		Flags as ulong
		ComTimeout as ulong
		CallTimeout as ulong
	end type

	type RPC_BINDING_HANDLE_OPTIONS_V1 as _RPC_BINDING_HANDLE_OPTIONS_V1
	type RPC_BINDING_HANDLE_OPTIONS as _RPC_BINDING_HANDLE_OPTIONS_V1

	type RPC_BINDING_HANDLE_SECURITY_V1
		Version as ulong
		ServerPrincName as ushort ptr
		AuthnLevel as ulong
		AuthnSvc as ulong

		#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
			AuthIdentity as SEC_WINNT_AUTH_IDENTITY_W ptr
		#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
			AuthIdentity as SEC_WINNT_AUTH_IDENTITY_A ptr
		#endif

		SecurityQos as RPC_SECURITY_QOS ptr
	end type

	type RPC_BINDING_HANDLE_SECURITY as RPC_BINDING_HANDLE_SECURITY_V1

	union ___RPC_BINDING_HANDLE_TEMPLATE_u1
		Reserved as ushort ptr
	end union

	type _RPC_BINDING_HANDLE_TEMPLATE
		Version as ulong
		Flags as ulong
		ProtocolSequence as ulong
		NetworkAddress as ushort ptr
		StringEndpoint as ushort ptr
		u1 as ___RPC_BINDING_HANDLE_TEMPLATE_u1
		ObjectUuid as UUID
	end type

	type RPC_BINDING_HANDLE_TEMPLATE_V1 as _RPC_BINDING_HANDLE_TEMPLATE
	type RPC_BINDING_HANDLE_TEMPLATE as _RPC_BINDING_HANDLE_TEMPLATE

	#define RPC_CALL_STATUS_IN_PROGRESS &h01
	#define RPC_CALL_STATUS_CANCELLED &h02
	#define RPC_CALL_STATUS_DISCONNECTED &h03

	declare function RpcBindingCreateA(byval Template as RPC_BINDING_HANDLE_TEMPLATE ptr, byval Security as RPC_BINDING_HANDLE_SECURITY ptr, byval Options as RPC_BINDING_HANDLE_OPTIONS ptr, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
	declare function RpcBindingCreateW(byval Template as RPC_BINDING_HANDLE_TEMPLATE ptr, byval Security as RPC_BINDING_HANDLE_SECURITY ptr, byval Options as RPC_BINDING_HANDLE_OPTIONS ptr, byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
#endif

#if defined(UNICODE) and (_WIN32_WINNT = &h0602)
	#define RpcBindingCreate RpcBindingCreateW
#elseif (not defined(UNICODE)) and (_WIN32_WINNT = &h0602)
	#define RpcBindingCreate RpcBindingCreateA
#endif

#if _WIN32_WINNT = &h0602
	declare function RpcServerInqBindingHandle cdecl(byval Binding as RPC_BINDING_HANDLE ptr) as RPC_STATUS
#endif

end extern

#include once "rpcdcep.bi"
