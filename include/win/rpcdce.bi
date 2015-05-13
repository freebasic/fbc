''
''
'' rpcdce -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_rpcdce_bi__
#define __win_rpcdce_bi__

#include once "win/basetyps.bi"

#define RPC_C_BINDING_INFINITE_TIMEOUT 10
#define RPC_C_BINDING_MIN_TIMEOUT 0
#define RPC_C_BINDING_DEFAULT_TIMEOUT 5
#define RPC_C_BINDING_MAX_TIMEOUT 9
#define RPC_C_CANCEL_INFINITE_TIMEOUT (-1)
#define RPC_C_LISTEN_MAX_CALLS_DEFAULT 1234
#define RPC_C_PROTSEQ_MAX_REQS_DEFAULT 10
#define RPC_C_BIND_TO_ALL_NICS 1
#define RPC_C_USE_INTERNET_PORT 1
#define RPC_C_USE_INTRANET_PORT 2
#define RPC_C_STATS_CALLS_IN 0
#define RPC_C_STATS_CALLS_OUT 1
#define RPC_C_STATS_PKTS_IN 2
#define RPC_C_STATS_PKTS_OUT 3
#define RPC_IF_AUTOLISTEN &h0001
#define RPC_IF_OLE 2
#define RPC_C_MGMT_INQ_IF_IDS 0
#define RPC_C_MGMT_INQ_PRINC_NAME 1
#define RPC_C_MGMT_INQ_STATS 2
#define RPC_C_MGMT_IS_SERVER_LISTEN 3
#define RPC_C_MGMT_STOP_SERVER_LISTEN 4
#define RPC_C_EP_ALL_ELTS 0
#define RPC_C_EP_MATCH_BY_IF 1
#define RPC_C_EP_MATCH_BY_OBJ 2
#define RPC_C_EP_MATCH_BY_BOTH 3
#define RPC_C_VERS_ALL 1
#define RPC_C_VERS_COMPATIBLE 2
#define RPC_C_VERS_EXACT 3
#define RPC_C_VERS_MAJOR_ONLY 4
#define RPC_C_VERS_UPTO 5
#define DCE_C_ERROR_STRING_LEN 256
#define RPC_C_PARM_MAX_PACKET_LENGTH 1
#define RPC_C_PARM_BUFFER_LENGTH 2
#define RPC_C_AUTHN_LEVEL_DEFAULT 0
#define RPC_C_AUTHN_LEVEL_NONE 1
#define RPC_C_AUTHN_LEVEL_CONNECT 2
#define RPC_C_AUTHN_LEVEL_CALL 3
#define RPC_C_AUTHN_LEVEL_PKT 4
#define RPC_C_AUTHN_LEVEL_PKT_INTEGRITY 5
#define RPC_C_AUTHN_LEVEL_PKT_PRIVACY 6
#define RPC_C_IMP_LEVEL_ANONYMOUS 1
#define RPC_C_IMP_LEVEL_IDENTIFY 2
#define RPC_C_IMP_LEVEL_IMPERSONATE 3
#define RPC_C_IMP_LEVEL_DELEGATE 4
#define RPC_C_QOS_IDENTITY_STATIC 0
#define RPC_C_QOS_IDENTITY_DYNAMIC 1
#define RPC_C_QOS_CAPABILITIES_DEFAULT 0
#define RPC_C_QOS_CAPABILITIES_MUTUAL_AUTH 1
#define RPC_C_AUTHN_NONE 0
#define RPC_C_AUTHN_DCE_PRIVATE 1
#define RPC_C_AUTHN_DCE_PUBLIC 2
#define RPC_C_AUTHN_DEC_PUBLIC 4
#define RPC_C_AUTHN_WINNT 10
#define RPC_C_AUTHN_DEFAULT &hFFFFFFFF
#define SEC_WINNT_AUTH_IDENTITY_ANSI &h1
#define SEC_WINNT_AUTH_IDENTITY_UNICODE &h2
#define RPC_C_AUTHZ_NONE 0
#define RPC_C_AUTHZ_NAME 1
#define RPC_C_AUTHZ_DCE 2
#define RPC_C_AUTHZ_DEFAULT &hFFFFFFFF

type RPC_BINDING_HANDLE as I_RPC_HANDLE
type handle_t as RPC_BINDING_HANDLE

type RPC_BINDING_VECTOR
	Count as uinteger
	BindingH(0 to 1-1) as RPC_BINDING_HANDLE
end type

type UUID_VECTOR
	Count as uinteger
	Uuid(0 to 1-1) as UUID ptr
end type

type RPC_IF_HANDLE as any ptr

type RPC_IF_ID
	Uuid as UUID
	VersMajor as ushort
	VersMinor as ushort
end type

type RPC_POLICY
	Length as uinteger
	EndpointFlags as uinteger
	NICFlags as uinteger
end type

type PRPC_POLICY as RPC_POLICY ptr
type RPC_OBJECT_INQ_FN as any
type RPC_IF_CALLBACK_FN as RPC_STATUS

type RPC_STATS_VECTOR
	Count as uinteger
	Stats(0 to 1-1) as uinteger
end type

type RPC_IF_ID_VECTOR
	Count as uinteger
	IfId(0 to 1-1) as RPC_IF_ID ptr
end type

type RPC_AUTH_IDENTITY_HANDLE as any ptr
type RPC_AUTHZ_HANDLE as any ptr

type RPC_SECURITY_QOS
	Version as uinteger
	Capabilities as uinteger
	IdentityTracking as uinteger
	ImpersonationType as uinteger
end type

type PRPC_SECURITY_QOS as RPC_SECURITY_QOS ptr

#ifdef UNICODE
type SEC_WINNT_AUTH_IDENTITY_W
	User as ushort ptr
	UserLength as uinteger
	Domain as ushort ptr
	DomainLength as uinteger
	Password as ushort ptr
	PasswordLength as uinteger
	Flags as uinteger
end type

type PSEC_WINNT_AUTH_IDENTITY_W as SEC_WINNT_AUTH_IDENTITY_W ptr

#else ''UNICODE
type SEC_WINNT_AUTH_IDENTITY_A
	User as ubyte ptr
	UserLength as uinteger
	Domain as ubyte ptr
	DomainLength as uinteger
	Password as ubyte ptr
	PasswordLength as uinteger
	Flags as uinteger
end type

type PSEC_WINNT_AUTH_IDENTITY_A as SEC_WINNT_AUTH_IDENTITY_A ptr
#endif ''UNICODE

type RPC_CLIENT_INFORMATION1
	UserName as ubyte ptr
	ComputerName as ubyte ptr
	Privilege as ushort
	AuthFlags as uinteger
end type

type PRPC_CLIENT_INFORMATION1 as RPC_CLIENT_INFORMATION1 ptr
type RPC_EP_INQ_HANDLE as I_RPC_HANDLE ptr
type RPC_MGMT_AUTHORIZATION_FN as function (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as RPC_STATUS ptr) as integer

#ifdef UNICODE
type RPC_PROTSEQ_VECTORW
	Count as uinteger
	Protseq(0 to 1-1) as ushort ptr
end type

type RPC_PROTSEQ_VECTOR as RPC_PROTSEQ_VECTORW
type SEC_WINNT_AUTH_IDENTITY as SEC_WINNT_AUTH_IDENTITY_W
type PSEC_WINNT_AUTH_IDENTITY as PSEC_WINNT_AUTH_IDENTITY_W
type _SEC_WINNT_AUTH_IDENTITY as SEC_WINNT_AUTH_IDENTITY_W

declare function RpcBindingFromStringBinding alias "RpcBindingFromStringBindingW" (byval as ushort ptr, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingToStringBinding alias "RpcBindingToStringBindingW" (byval as RPC_BINDING_HANDLE, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcStringBindingCompose alias "RpcStringBindingComposeW" (byval as ushort ptr, byval as ushort ptr, byval as ushort ptr, byval as ushort ptr, byval as ushort ptr, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcStringBindingParse alias "RpcStringBindingParseW" (byval as ushort ptr, byval as ushort ptr ptr, byval as ushort ptr ptr, byval as ushort ptr ptr, byval as ushort ptr ptr, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcStringFree alias "RpcStringFreeW" (byval as ushort ptr ptr) as RPC_STATUS
declare function RpcNetworkIsProtseqValid alias "RpcNetworkIsProtseqValidW" (byval as ushort ptr) as RPC_STATUS
declare function RpcNetworkInqProtseqs alias "RpcNetworkInqProtseqsW" (byval as RPC_PROTSEQ_VECTORW ptr ptr) as RPC_STATUS
declare function RpcProtseqVectorFree alias "RpcProtseqVectorFreeW" (byval as RPC_PROTSEQ_VECTORW ptr ptr) as RPC_STATUS
declare function RpcServerUseProtseq alias "RpcServerUseProtseqW" (byval as ushort ptr, byval as uinteger, byval as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqEx alias "RpcServerUseProtseqExW" (byval as ushort ptr, byval as uinteger, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqEp alias "RpcServerUseProtseqEpW" (byval as ushort ptr, byval as uinteger, byval as ushort ptr, byval as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqEpEx alias "RpcServerUseProtseqEpExW" (byval as ushort ptr, byval as uinteger, byval as ushort ptr, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqIf alias "RpcServerUseProtseqIfW" (byval as ushort ptr, byval as uinteger, byval as RPC_IF_HANDLE, byval as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqIfEx alias "RpcServerUseProtseqIfExW" (byval as ushort ptr, byval as uinteger, byval as RPC_IF_HANDLE, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcMgmtInqServerPrincName alias "RpcMgmtInqServerPrincNameW" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcServerInqDefaultPrincName alias "RpcServerInqDefaultPrincNameW" (byval as uinteger, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcNsBindingInqEntryName alias "RpcNsBindingInqEntryNameW" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as ushort ptr ptr) as RPC_STATUS
declare function RpcBindingInqAuthClient alias "RpcBindingInqAuthClientW" (byval as RPC_BINDING_HANDLE, byval as RPC_AUTHZ_HANDLE ptr, byval as ushort ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfo alias "RpcBindingInqAuthInfoW" (byval as RPC_BINDING_HANDLE, byval as ushort ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as RPC_AUTH_IDENTITY_HANDLE ptr, byval as uinteger ptr) as RPC_STATUS
declare function RpcBindingSetAuthInfo alias "RpcBindingSetAuthInfoW" (byval as RPC_BINDING_HANDLE, byval as ushort ptr, byval as uinteger, byval as uinteger, byval as RPC_AUTH_IDENTITY_HANDLE, byval as uinteger) as RPC_STATUS
declare function RpcBindingSetAuthInfoEx alias "RpcBindingSetAuthInfoExW" (byval as RPC_BINDING_HANDLE, byval as ushort ptr, byval as uinteger, byval as uinteger, byval as RPC_AUTH_IDENTITY_HANDLE, byval as uinteger, byval as RPC_SECURITY_QOS ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfoEx alias "RpcBindingInqAuthInfoExW" (byval as RPC_BINDING_HANDLE, byval as ushort ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as RPC_AUTH_IDENTITY_HANDLE ptr, byval as uinteger ptr, byval as uinteger, byval as RPC_SECURITY_QOS ptr) as RPC_STATUS

#else ''UNICODE
type RPC_PROTSEQ_VECTORA
	Count as uinteger
	Protseq(0 to 1-1) as ubyte ptr
end type

type RPC_PROTSEQ_VECTOR as RPC_PROTSEQ_VECTORA
type SEC_WINNT_AUTH_IDENTITY as SEC_WINNT_AUTH_IDENTITY_A
type PSEC_WINNT_AUTH_IDENTITY as PSEC_WINNT_AUTH_IDENTITY_A
type _SEC_WINNT_AUTH_IDENTITY as SEC_WINNT_AUTH_IDENTITY_A

declare function RpcBindingFromStringBinding alias "RpcBindingFromStringBindingA" (byval as ubyte ptr, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingToStringBinding alias "RpcBindingToStringBindingA" (byval as RPC_BINDING_HANDLE, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcStringBindingCompose alias "RpcStringBindingComposeA" (byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcStringBindingParse alias "RpcStringBindingParseA" (byval as ubyte ptr, byval as ubyte ptr ptr, byval as ubyte ptr ptr, byval as ubyte ptr ptr, byval as ubyte ptr ptr, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcStringFree alias "RpcStringFreeA" (byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcNetworkIsProtseqValid alias "RpcNetworkIsProtseqValidA" (byval as ubyte ptr) as RPC_STATUS
declare function RpcNetworkInqProtseqs alias "RpcNetworkInqProtseqsA" (byval as RPC_PROTSEQ_VECTORA ptr ptr) as RPC_STATUS
declare function RpcProtseqVectorFree alias "RpcProtseqVectorFreeA" (byval as RPC_PROTSEQ_VECTORA ptr ptr) as RPC_STATUS
declare function RpcServerUseProtseq alias "RpcServerUseProtseqA" (byval as ubyte ptr, byval as uinteger, byval as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqEx alias "RpcServerUseProtseqExA" (byval as ubyte ptr, byval MaxCalls as uinteger, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqEp alias "RpcServerUseProtseqEpA" (byval as ubyte ptr, byval as uinteger, byval as ubyte ptr, byval as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqEpEx alias "RpcServerUseProtseqEpExA" (byval as ubyte ptr, byval as uinteger, byval as ubyte ptr, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseProtseqIf alias "RpcServerUseProtseqIfA" (byval as ubyte ptr, byval as uinteger, byval as RPC_IF_HANDLE, byval as any ptr) as RPC_STATUS
declare function RpcServerUseProtseqIfEx alias "RpcServerUseProtseqIfExA" (byval as ubyte ptr, byval as uinteger, byval as RPC_IF_HANDLE, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcMgmtInqServerPrincName alias "RpcMgmtInqServerPrincNameA" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcServerInqDefaultPrincName alias "RpcServerInqDefaultPrincNameA" (byval as uinteger, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcNsBindingInqEntryName alias "RpcNsBindingInqEntryNameA" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as ubyte ptr ptr) as RPC_STATUS
declare function RpcBindingInqAuthClient alias "RpcBindingInqAuthClientA" (byval as RPC_BINDING_HANDLE, byval as RPC_AUTHZ_HANDLE ptr, byval as ubyte ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as uinteger ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfo alias "RpcBindingInqAuthInfoA" (byval as RPC_BINDING_HANDLE, byval as ubyte ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as RPC_AUTH_IDENTITY_HANDLE ptr, byval as uinteger ptr) as RPC_STATUS
declare function RpcBindingSetAuthInfo alias "RpcBindingSetAuthInfoA" (byval as RPC_BINDING_HANDLE, byval as ubyte ptr, byval as uinteger, byval as uinteger, byval as RPC_AUTH_IDENTITY_HANDLE, byval as uinteger) as RPC_STATUS
declare function RpcBindingSetAuthInfoEx alias "RpcBindingSetAuthInfoExA" (byval as RPC_BINDING_HANDLE, byval as ubyte ptr, byval as uinteger, byval as uinteger, byval as RPC_AUTH_IDENTITY_HANDLE, byval as uinteger, byval as RPC_SECURITY_QOS ptr) as RPC_STATUS
declare function RpcBindingInqAuthInfoEx alias "RpcBindingInqAuthInfoExA" (byval as RPC_BINDING_HANDLE, byval as ubyte ptr ptr, byval as uinteger ptr, byval as uinteger ptr, byval as RPC_AUTH_IDENTITY_HANDLE ptr, byval as uinteger ptr, byval as uinteger, byval as RPC_SECURITY_QOS ptr) as RPC_STATUS
#endif ''UNICODE

type RPC_AUTH_KEY_RETRIEVAL_FN as sub (byval as any ptr, byval as ushort ptr, byval as uinteger, byval as any ptr ptr, byval as RPC_STATUS ptr)

declare function RpcBindingCopy alias "RpcBindingCopy" (byval as RPC_BINDING_HANDLE, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingFree alias "RpcBindingFree" (byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare function RpcBindingInqObject alias "RpcBindingInqObject" (byval as RPC_BINDING_HANDLE, byval as UUID ptr) as RPC_STATUS
declare function RpcBindingReset alias "RpcBindingReset" (byval as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcBindingSetObject alias "RpcBindingSetObject" (byval as RPC_BINDING_HANDLE, byval as UUID ptr) as RPC_STATUS
declare function RpcMgmtInqDefaultProtectLevel alias "RpcMgmtInqDefaultProtectLevel" (byval as uinteger, byval as uinteger ptr) as RPC_STATUS
declare function RpcBindingVectorFree alias "RpcBindingVectorFree" (byval as RPC_BINDING_VECTOR ptr ptr) as RPC_STATUS
declare function RpcIfInqId alias "RpcIfInqId" (byval as RPC_IF_HANDLE, byval as RPC_IF_ID ptr) as RPC_STATUS
declare function RpcMgmtInqComTimeout alias "RpcMgmtInqComTimeout" (byval as RPC_BINDING_HANDLE, byval as uinteger ptr) as RPC_STATUS
declare function RpcMgmtSetComTimeout alias "RpcMgmtSetComTimeout" (byval as RPC_BINDING_HANDLE, byval as uinteger) as RPC_STATUS
declare function RpcMgmtSetCancelTimeout alias "RpcMgmtSetCancelTimeout" (byval Timeout as integer) as RPC_STATUS
declare function RpcObjectInqType alias "RpcObjectInqType" (byval as UUID ptr, byval as UUID ptr) as RPC_STATUS
declare function RpcObjectSetInqFn alias "RpcObjectSetInqFn" (byval as RPC_OBJECT_INQ_FN ptr) as RPC_STATUS
declare function RpcObjectSetType alias "RpcObjectSetType" (byval as UUID ptr, byval as UUID ptr) as RPC_STATUS
declare function RpcServerInqIf alias "RpcServerInqIf" (byval as RPC_IF_HANDLE, byval as UUID ptr, byval as any ptr ptr) as RPC_STATUS
declare function RpcServerListen alias "RpcServerListen" (byval as uinteger, byval as uinteger, byval as uinteger) as RPC_STATUS
declare function RpcServerRegisterIf alias "RpcServerRegisterIf" (byval as RPC_IF_HANDLE, byval as UUID ptr, byval as any ptr) as RPC_STATUS
declare function RpcServerRegisterIfEx alias "RpcServerRegisterIfEx" (byval as RPC_IF_HANDLE, byval as UUID ptr, byval as any ptr, byval as uinteger, byval as uinteger, byval as RPC_IF_CALLBACK_FN ptr) as RPC_STATUS
declare function RpcServerUnregisterIf alias "RpcServerUnregisterIf" (byval as RPC_IF_HANDLE, byval as UUID ptr, byval as uinteger) as RPC_STATUS
declare function RpcServerUseAllProtseqs alias "RpcServerUseAllProtseqs" (byval as uinteger, byval as any ptr) as RPC_STATUS
declare function RpcServerUseAllProtseqsEx alias "RpcServerUseAllProtseqsEx" (byval as uinteger, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcServerUseAllProtseqsIf alias "RpcServerUseAllProtseqsIf" (byval as uinteger, byval as RPC_IF_HANDLE, byval as any ptr) as RPC_STATUS
declare function RpcServerUseAllProtseqsIfEx alias "RpcServerUseAllProtseqsIfEx" (byval as uinteger, byval as RPC_IF_HANDLE, byval as any ptr, byval as PRPC_POLICY) as RPC_STATUS
declare function RpcMgmtStatsVectorFree alias "RpcMgmtStatsVectorFree" (byval as RPC_STATS_VECTOR ptr ptr) as RPC_STATUS
declare function RpcMgmtInqStats alias "RpcMgmtInqStats" (byval as RPC_BINDING_HANDLE, byval as RPC_STATS_VECTOR ptr ptr) as RPC_STATUS
declare function RpcMgmtIsServerListening alias "RpcMgmtIsServerListening" (byval as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcMgmtStopServerListening alias "RpcMgmtStopServerListening" (byval as RPC_BINDING_HANDLE) as RPC_STATUS
declare function RpcMgmtWaitServerListen alias "RpcMgmtWaitServerListen" () as RPC_STATUS
declare function RpcMgmtSetServerStackSize alias "RpcMgmtSetServerStackSize" (byval as uinteger) as RPC_STATUS
declare sub RpcSsDontSerializeContext alias "RpcSsDontSerializeContext" ()
declare function RpcMgmtEnableIdleCleanup alias "RpcMgmtEnableIdleCleanup" () as RPC_STATUS
declare function RpcMgmtInqIfIds alias "RpcMgmtInqIfIds" (byval as RPC_BINDING_HANDLE, byval as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcIfIdVectorFree alias "RpcIfIdVectorFree" (byval as RPC_IF_ID_VECTOR ptr ptr) as RPC_STATUS
declare function RpcEpResolveBinding alias "RpcEpResolveBinding" (byval as RPC_BINDING_HANDLE, byval as RPC_IF_HANDLE) as RPC_STATUS
declare function RpcBindingServerFromClient alias "RpcBindingServerFromClient" (byval as RPC_BINDING_HANDLE, byval as RPC_BINDING_HANDLE ptr) as RPC_STATUS
declare sub RpcRaiseException alias "RpcRaiseException" (byval as RPC_STATUS)
declare function RpcTestCancel alias "RpcTestCancel" () as RPC_STATUS
declare function RpcCancelThread alias "RpcCancelThread" (byval as any ptr) as RPC_STATUS
declare function UuidCreate alias "UuidCreate" (byval as UUID ptr) as RPC_STATUS
declare function UuidCompare alias "UuidCompare" (byval as UUID ptr, byval as UUID ptr, byval as RPC_STATUS ptr) as integer
declare function UuidCreateNil alias "UuidCreateNil" (byval as UUID ptr) as RPC_STATUS
declare function UuidEqual alias "UuidEqual" (byval as UUID ptr, byval as UUID ptr, byval as RPC_STATUS ptr) as integer
declare function UuidHash alias "UuidHash" (byval as UUID ptr, byval as RPC_STATUS ptr) as ushort
declare function UuidIsNil alias "UuidIsNil" (byval as UUID ptr, byval as RPC_STATUS ptr) as integer
declare function RpcEpUnregister alias "RpcEpUnregister" (byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqBegin alias "RpcMgmtEpEltInqBegin" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as RPC_IF_ID ptr, byval as uinteger, byval as UUID ptr, byval as RPC_EP_INQ_HANDLE ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqDone alias "RpcMgmtEpEltInqDone" (byval as RPC_EP_INQ_HANDLE ptr) as RPC_STATUS
declare function RpcMgmtEpUnregister alias "RpcMgmtEpUnregister" (byval as RPC_BINDING_HANDLE, byval as RPC_IF_ID ptr, byval as RPC_BINDING_HANDLE, byval as UUID ptr) as RPC_STATUS
declare function RpcMgmtSetAuthorizationFn alias "RpcMgmtSetAuthorizationFn" (byval as RPC_MGMT_AUTHORIZATION_FN) as RPC_STATUS
declare function RpcMgmtInqParameter alias "RpcMgmtInqParameter" (byval as uinteger, byval as uinteger ptr) as RPC_STATUS
declare function RpcMgmtSetParameter alias "RpcMgmtSetParameter" (byval as uinteger, byval as uinteger) as RPC_STATUS
declare function RpcMgmtBindingInqParameter alias "RpcMgmtBindingInqParameter" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as uinteger ptr) as RPC_STATUS
declare function RpcMgmtBindingSetParameter alias "RpcMgmtBindingSetParameter" (byval as RPC_BINDING_HANDLE, byval as uinteger, byval as uinteger) as RPC_STATUS

#ifdef UNICODE
declare function RpcServerRegisterAuthInfo alias "RpcServerRegisterAuthInfoW" (byval as ushort ptr, byval as uinteger, byval as RPC_AUTH_KEY_RETRIEVAL_FN, byval as any ptr) as RPC_STATUS
declare function UuidToString alias "UuidToStringW" (byval as UUID ptr, byval as ushort ptr ptr) as RPC_STATUS
declare function UuidFromString alias "UuidFromStringW" (byval as ushort ptr, byval as UUID ptr) as RPC_STATUS
declare function RpcEpRegisterNoReplace alias "RpcEpRegisterNoReplaceW" (byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr, byval as ushort ptr) as RPC_STATUS
declare function RpcEpRegister alias "RpcEpRegisterW" (byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr, byval as ushort ptr) as RPC_STATUS
declare function DceErrorInqText alias "DceErrorInqTextW" (byval as RPC_STATUS, byval as ushort ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqNext alias "RpcMgmtEpEltInqNextW" (byval as RPC_EP_INQ_HANDLE, byval as RPC_IF_ID ptr, byval as RPC_BINDING_HANDLE ptr, byval as UUID ptr, byval as ushort ptr ptr) as RPC_STATUS

#else ''UNICODE
declare function RpcServerRegisterAuthInfo alias "RpcServerRegisterAuthInfoA" (byval as ubyte ptr, byval as uinteger, byval as RPC_AUTH_KEY_RETRIEVAL_FN, byval as any ptr) as RPC_STATUS
declare function UuidToString alias "UuidToStringA" (byval as UUID ptr, byval as ubyte ptr ptr) as RPC_STATUS
declare function UuidFromString alias "UuidFromStringA" (byval as ubyte ptr, byval as UUID ptr) as RPC_STATUS
declare function RpcEpRegisterNoReplace alias "RpcEpRegisterNoReplaceA" (byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr, byval as ubyte ptr) as RPC_STATUS
declare function RpcEpRegister alias "RpcEpRegisterA" (byval as RPC_IF_HANDLE, byval as RPC_BINDING_VECTOR ptr, byval as UUID_VECTOR ptr, byval as ubyte ptr) as RPC_STATUS
declare function DceErrorInqText alias "DceErrorInqTextA" (byval as RPC_STATUS, byval as ubyte ptr) as RPC_STATUS
declare function RpcMgmtEpEltInqNext alias "RpcMgmtEpEltInqNextA" (byval as RPC_EP_INQ_HANDLE, byval as RPC_IF_ID ptr, byval as RPC_BINDING_HANDLE ptr, byval as UUID ptr, byval as ubyte ptr ptr) as RPC_STATUS

#endif ''UNICODE

#include once "win/rpcdcep.bi"

#endif
