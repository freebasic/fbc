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

#include once "sspi.bi"

extern "Windows"

#define _NTSECPKG_
type PLSA_CLIENT_REQUEST as PVOID ptr

type _LSA_TOKEN_INFORMATION_TYPE as long
enum
	LsaTokenInformationNull
	LsaTokenInformationV1
	LsaTokenInformationV2
end enum

type LSA_TOKEN_INFORMATION_TYPE as _LSA_TOKEN_INFORMATION_TYPE
type PLSA_TOKEN_INFORMATION_TYPE as _LSA_TOKEN_INFORMATION_TYPE ptr

type _LSA_TOKEN_INFORMATION_NULL
	ExpirationTime as LARGE_INTEGER
	Groups as PTOKEN_GROUPS
end type

type LSA_TOKEN_INFORMATION_NULL as _LSA_TOKEN_INFORMATION_NULL
type PLSA_TOKEN_INFORMATION_NULL as _LSA_TOKEN_INFORMATION_NULL ptr

type _LSA_TOKEN_INFORMATION_V1
	ExpirationTime as LARGE_INTEGER
	User as TOKEN_USER
	Groups as PTOKEN_GROUPS
	PrimaryGroup as TOKEN_PRIMARY_GROUP
	Privileges as PTOKEN_PRIVILEGES
	Owner as TOKEN_OWNER
	DefaultDacl as TOKEN_DEFAULT_DACL
end type

type LSA_TOKEN_INFORMATION_V1 as _LSA_TOKEN_INFORMATION_V1
type PLSA_TOKEN_INFORMATION_V1 as _LSA_TOKEN_INFORMATION_V1 ptr
type LSA_TOKEN_INFORMATION_V2 as LSA_TOKEN_INFORMATION_V1
type PLSA_TOKEN_INFORMATION_V2 as LSA_TOKEN_INFORMATION_V1 ptr
type PLSA_CREATE_LOGON_SESSION as function(byval LogonId as PLUID) as NTSTATUS
type PLSA_DELETE_LOGON_SESSION as function(byval LogonId as PLUID) as NTSTATUS
type PLSA_ADD_CREDENTIAL as function(byval LogonId as PLUID, byval AuthenticationPackage as ULONG, byval PrimaryKeyValue as PLSA_STRING, byval Credentials as PLSA_STRING) as NTSTATUS
type PLSA_GET_CREDENTIALS as function(byval LogonId as PLUID, byval AuthenticationPackage as ULONG, byval QueryContext as PULONG, byval RetrieveAllCredentials as WINBOOLEAN, byval PrimaryKeyValue as PLSA_STRING, byval PrimaryKeyLength as PULONG, byval Credentials as PLSA_STRING) as NTSTATUS
type PLSA_DELETE_CREDENTIAL as function(byval LogonId as PLUID, byval AuthenticationPackage as ULONG, byval PrimaryKeyValue as PLSA_STRING) as NTSTATUS
type PLSA_ALLOCATE_LSA_HEAP as function(byval Length as ULONG) as PVOID
type PLSA_FREE_LSA_HEAP as sub(byval Base as PVOID)
type PLSA_ALLOCATE_PRIVATE_HEAP as function(byval Length as SIZE_T_) as PVOID
type PLSA_FREE_PRIVATE_HEAP as sub(byval Base as PVOID)
type PLSA_ALLOCATE_CLIENT_BUFFER as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval LengthRequired as ULONG, byval ClientBaseAddress as PVOID ptr) as NTSTATUS
type PLSA_FREE_CLIENT_BUFFER as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval ClientBaseAddress as PVOID) as NTSTATUS
type PLSA_COPY_TO_CLIENT_BUFFER as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval Length as ULONG, byval ClientBaseAddress as PVOID, byval BufferToCopy as PVOID) as NTSTATUS
type PLSA_COPY_FROM_CLIENT_BUFFER as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval Length as ULONG, byval BufferToCopy as PVOID, byval ClientBaseAddress as PVOID) as NTSTATUS

type _LSA_DISPATCH_TABLE
	CreateLogonSession as PLSA_CREATE_LOGON_SESSION
	DeleteLogonSession as PLSA_DELETE_LOGON_SESSION
	AddCredential as PLSA_ADD_CREDENTIAL
	GetCredentials as PLSA_GET_CREDENTIALS
	DeleteCredential as PLSA_DELETE_CREDENTIAL
	AllocateLsaHeap as PLSA_ALLOCATE_LSA_HEAP
	FreeLsaHeap as PLSA_FREE_LSA_HEAP
	AllocateClientBuffer as PLSA_ALLOCATE_CLIENT_BUFFER
	FreeClientBuffer as PLSA_FREE_CLIENT_BUFFER
	CopyToClientBuffer as PLSA_COPY_TO_CLIENT_BUFFER
	CopyFromClientBuffer as PLSA_COPY_FROM_CLIENT_BUFFER
end type

type LSA_DISPATCH_TABLE as _LSA_DISPATCH_TABLE
type PLSA_DISPATCH_TABLE as _LSA_DISPATCH_TABLE ptr
#define LSA_AP_NAME_INITIALIZE_PACKAGE !"LsaApInitializePackage\0"
#define LSA_AP_NAME_LOGON_USER !"LsaApLogonUser\0"
#define LSA_AP_NAME_LOGON_USER_EX !"LsaApLogonUserEx\0"
#define LSA_AP_NAME_CALL_PACKAGE !"LsaApCallPackage\0"
#define LSA_AP_NAME_LOGON_TERMINATED !"LsaApLogonTerminated\0"
#define LSA_AP_NAME_CALL_PACKAGE_UNTRUSTED !"LsaApCallPackageUntrusted\0"
#define LSA_AP_NAME_CALL_PACKAGE_PASSTHROUGH !"LsaApCallPackagePassthrough\0"

type PLSA_AP_INITIALIZE_PACKAGE as function(byval AuthenticationPackageId as ULONG, byval LsaDispatchTable as PLSA_DISPATCH_TABLE, byval Database as PLSA_STRING, byval Confidentiality as PLSA_STRING, byval AuthenticationPackageName as PLSA_STRING ptr) as NTSTATUS
type PLSA_AP_LOGON_USER as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval LogonType as SECURITY_LOGON_TYPE, byval AuthenticationInformation as PVOID, byval ClientAuthenticationBase as PVOID, byval AuthenticationInformationLength as ULONG, byval ProfileBuffer as PVOID ptr, byval ProfileBufferLength as PULONG, byval LogonId as PLUID, byval SubStatus as PNTSTATUS, byval TokenInformationType as PLSA_TOKEN_INFORMATION_TYPE, byval TokenInformation as PVOID ptr, byval AccountName as PLSA_UNICODE_STRING ptr, byval AuthenticatingAuthority as PLSA_UNICODE_STRING ptr) as NTSTATUS
type PLSA_AP_LOGON_USER_EX as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval LogonType as SECURITY_LOGON_TYPE, byval AuthenticationInformation as PVOID, byval ClientAuthenticationBase as PVOID, byval AuthenticationInformationLength as ULONG, byval ProfileBuffer as PVOID ptr, byval ProfileBufferLength as PULONG, byval LogonId as PLUID, byval SubStatus as PNTSTATUS, byval TokenInformationType as PLSA_TOKEN_INFORMATION_TYPE, byval TokenInformation as PVOID ptr, byval AccountName as PUNICODE_STRING ptr, byval AuthenticatingAuthority as PUNICODE_STRING ptr, byval MachineName as PUNICODE_STRING ptr) as NTSTATUS
type PLSA_AP_CALL_PACKAGE as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval ProtocolSubmitBuffer as PVOID, byval ClientBufferBase as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
type PLSA_AP_CALL_PACKAGE_PASSTHROUGH as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval ProtocolSubmitBuffer as PVOID, byval ClientBufferBase as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
type PLSA_AP_LOGON_TERMINATED as sub(byval LogonId as PLUID)
type PLSA_AP_CALL_PACKAGE_UNTRUSTED as function(byval ClientRequest as PLSA_CLIENT_REQUEST, byval ProtocolSubmitBuffer as PVOID, byval ClientBufferBase as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
#define _SAM_CREDENTIAL_UPDATE_DEFINED
type PSAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE as function cdecl(byval ClearPassword as PUNICODE_STRING, byval OldCredentials as PVOID, byval OldCredentialSize as ULONG, byval UserAccountControl as ULONG, byval UPN as PUNICODE_STRING, byval UserName as PUNICODE_STRING, byval NetbiosDomainName as PUNICODE_STRING, byval DnsDomainName as PUNICODE_STRING, byval NewCredentials as PVOID ptr, byval NewCredentialSize as ULONG ptr) as NTSTATUS
#define SAM_CREDENTIAL_UPDATE_NOTIFY_ROUTINE "CredentialUpdateNotify"
type PSAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE as function cdecl(byval CredentialName as PUNICODE_STRING) as WINBOOLEAN
#define SAM_CREDENTIAL_UPDATE_REGISTER_ROUTINE "CredentialUpdateRegister"
type PSAM_CREDENTIAL_UPDATE_FREE_ROUTINE as sub cdecl(byval p as PVOID)
#define SAM_CREDENTIAL_UPDATE_FREE_ROUTINE "CredentialUpdateFree"
type SEC_THREAD_START as LPTHREAD_START_ROUTINE
type SEC_ATTRS as LPSECURITY_ATTRIBUTES
#define SecEqualLuid(L1, L2) ((cast(PLUID, L1)->LowPart = cast(PLUID, L2)->LowPart) andalso (cast(PLUID, L1)->HighPart = cast(PLUID, L2)->HighPart))
#define SecIsZeroLuid(L1) ((L1->LowPart or L1->HighPart) = 0)

type _SECPKG_CLIENT_INFO
	LogonId as LUID
	ProcessID as ULONG
	ThreadID as ULONG
	HasTcbPrivilege as WINBOOLEAN
	Impersonating as WINBOOLEAN
	Restricted as WINBOOLEAN
	ClientFlags as UCHAR
	ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL
end type

type SECPKG_CLIENT_INFO as _SECPKG_CLIENT_INFO
type PSECPKG_CLIENT_INFO as _SECPKG_CLIENT_INFO ptr
const SECPKG_CLIENT_PROCESS_TERMINATED = &h01
const SECPKG_CLIENT_THREAD_TERMINATED = &h02

type _SECPKG_CALL_INFO
	ProcessId as ULONG
	ThreadId as ULONG
	Attributes as ULONG
	CallCount as ULONG
end type

type SECPKG_CALL_INFO as _SECPKG_CALL_INFO
type PSECPKG_CALL_INFO as _SECPKG_CALL_INFO ptr
const SECPKG_CALL_KERNEL_MODE = &h00000001
const SECPKG_CALL_ANSI = &h00000002
const SECPKG_CALL_URGENT = &h00000004
const SECPKG_CALL_RECURSIVE = &h00000008
const SECPKG_CALL_IN_PROC = &h00000010
const SECPKG_CALL_CLEANUP = &h00000020
const SECPKG_CALL_WOWCLIENT = &h00000040
const SECPKG_CALL_THREAD_TERM = &h00000080
const SECPKG_CALL_PROCESS_TERM = &h00000100
const SECPKG_CALL_IS_TCB = &h00000200

type _SECPKG_SUPPLEMENTAL_CRED
	PackageName as UNICODE_STRING
	CredentialSize as ULONG
	Credentials as PUCHAR
end type

type SECPKG_SUPPLEMENTAL_CRED as _SECPKG_SUPPLEMENTAL_CRED
type PSECPKG_SUPPLEMENTAL_CRED as _SECPKG_SUPPLEMENTAL_CRED ptr
type LSA_SEC_HANDLE as ULONG_PTR
type PLSA_SEC_HANDLE as LSA_SEC_HANDLE ptr

type _SECPKG_SUPPLEMENTAL_CRED_ARRAY
	CredentialCount as ULONG
	Credentials(0 to 0) as SECPKG_SUPPLEMENTAL_CRED
end type

type SECPKG_SUPPLEMENTAL_CRED_ARRAY as _SECPKG_SUPPLEMENTAL_CRED_ARRAY
type PSECPKG_SUPPLEMENTAL_CRED_ARRAY as _SECPKG_SUPPLEMENTAL_CRED_ARRAY ptr
const SECBUFFER_UNMAPPED = &h40000000
const SECBUFFER_KERNEL_MAP = &h20000000
type PLSA_CALLBACK_FUNCTION as function(byval Argument1 as ULONG_PTR, byval Argument2 as ULONG_PTR, byval InputBuffer as PSecBuffer, byval OutputBuffer as PSecBuffer) as NTSTATUS
const PRIMARY_CRED_CLEAR_PASSWORD = &h1
const PRIMARY_CRED_OWF_PASSWORD = &h2
const PRIMARY_CRED_UPDATE = &h4
const PRIMARY_CRED_CACHED_LOGON = &h8
const PRIMARY_CRED_LOGON_NO_TCB = &h10
const PRIMARY_CRED_LOGON_PACKAGE_SHIFT = 24
const PRIMARY_CRED_PACKAGE_MASK = &hff000000

type _SECPKG_PRIMARY_CRED
	LogonId as LUID
	DownlevelName as UNICODE_STRING
	DomainName as UNICODE_STRING
	Password as UNICODE_STRING
	OldPassword as UNICODE_STRING
	UserSid as PSID
	Flags as ULONG
	DnsDomainName as UNICODE_STRING
	Upn as UNICODE_STRING
	LogonServer as UNICODE_STRING
	Spare1 as UNICODE_STRING
	Spare2 as UNICODE_STRING
	Spare3 as UNICODE_STRING
	Spare4 as UNICODE_STRING
end type

type SECPKG_PRIMARY_CRED as _SECPKG_PRIMARY_CRED
type PSECPKG_PRIMARY_CRED as _SECPKG_PRIMARY_CRED ptr
const MAX_CRED_SIZE = 1024
const SECPKG_STATE_ENCRYPTION_PERMITTED = &h01
const SECPKG_STATE_STRONG_ENCRYPTION_PERMITTED = &h02
const SECPKG_STATE_DOMAIN_CONTROLLER = &h04
const SECPKG_STATE_WORKSTATION = &h08
const SECPKG_STATE_STANDALONE = &h10

type _SECPKG_PARAMETERS
	Version as ULONG
	MachineState as ULONG
	SetupMode as ULONG
	DomainSid as PSID
	DomainName as UNICODE_STRING
	DnsDomainName as UNICODE_STRING
	DomainGuid as GUID
end type

type SECPKG_PARAMETERS as _SECPKG_PARAMETERS
type PSECPKG_PARAMETERS as _SECPKG_PARAMETERS ptr

type _SECPKG_EXTENDED_INFORMATION_CLASS as long
enum
	SecpkgGssInfo = 1
	SecpkgContextThunks
	SecpkgMutualAuthLevel
	SecpkgWowClientDll
	SecpkgExtraOids
	SecpkgMaxInfo
end enum

type SECPKG_EXTENDED_INFORMATION_CLASS as _SECPKG_EXTENDED_INFORMATION_CLASS

type _SECPKG_GSS_INFO
	EncodedIdLength as ULONG
	EncodedId(0 to 3) as UCHAR
end type

type SECPKG_GSS_INFO as _SECPKG_GSS_INFO
type PSECPKG_GSS_INFO as _SECPKG_GSS_INFO ptr

type _SECPKG_CONTEXT_THUNKS
	InfoLevelCount as ULONG
	Levels(0 to 0) as ULONG
end type

type SECPKG_CONTEXT_THUNKS as _SECPKG_CONTEXT_THUNKS
type PSECPKG_CONTEXT_THUNKS as _SECPKG_CONTEXT_THUNKS ptr

type _SECPKG_MUTUAL_AUTH_LEVEL
	MutualAuthLevel as ULONG
end type

type SECPKG_MUTUAL_AUTH_LEVEL as _SECPKG_MUTUAL_AUTH_LEVEL
type PSECPKG_MUTUAL_AUTH_LEVEL as _SECPKG_MUTUAL_AUTH_LEVEL ptr

type _SECPKG_WOW_CLIENT_DLL
	WowClientDllPath as SECURITY_STRING
end type

type SECPKG_WOW_CLIENT_DLL as _SECPKG_WOW_CLIENT_DLL
type PSECPKG_WOW_CLIENT_DLL as _SECPKG_WOW_CLIENT_DLL ptr
const SECPKG_MAX_OID_LENGTH = 32

type _SECPKG_SERIALIZED_OID
	OidLength as ULONG
	OidAttributes as ULONG
	OidValue(0 to 31) as UCHAR
end type

type SECPKG_SERIALIZED_OID as _SECPKG_SERIALIZED_OID
type PSECPKG_SERIALIZED_OID as _SECPKG_SERIALIZED_OID ptr

type _SECPKG_EXTRA_OIDS
	OidCount as ULONG
	Oids(0 to 0) as SECPKG_SERIALIZED_OID
end type

type SECPKG_EXTRA_OIDS as _SECPKG_EXTRA_OIDS
type PSECPKG_EXTRA_OIDS as _SECPKG_EXTRA_OIDS ptr

union _SECPKG_EXTENDED_INFORMATION_Info
	GssInfo as SECPKG_GSS_INFO
	ContextThunks as SECPKG_CONTEXT_THUNKS
	MutualAuthLevel as SECPKG_MUTUAL_AUTH_LEVEL
	WowClientDll as SECPKG_WOW_CLIENT_DLL
	ExtraOids as SECPKG_EXTRA_OIDS
end union

type _SECPKG_EXTENDED_INFORMATION
	Class as SECPKG_EXTENDED_INFORMATION_CLASS
	Info as _SECPKG_EXTENDED_INFORMATION_Info
end type

type SECPKG_EXTENDED_INFORMATION as _SECPKG_EXTENDED_INFORMATION
type PSECPKG_EXTENDED_INFORMATION as _SECPKG_EXTENDED_INFORMATION ptr
const SECPKG_ATTR_SASL_CONTEXT = &h00010000

type _SecPkgContext_SaslContext
	SaslContext as PVOID
end type

type SecPkgContext_SaslContext as _SecPkgContext_SaslContext
type PSecPkgContext_SaslContext as _SecPkgContext_SaslContext ptr
const SECPKG_ATTR_THUNK_ALL = &h00010000
#define SECURITY_USER_DATA_DEFINED

type _SECURITY_USER_DATA
	UserName as SECURITY_STRING
	LogonDomainName as SECURITY_STRING
	LogonServer as SECURITY_STRING
	pSid as PSID
end type

type SECURITY_USER_DATA as _SECURITY_USER_DATA
type PSECURITY_USER_DATA as _SECURITY_USER_DATA ptr
type SecurityUserData as SECURITY_USER_DATA
type PSecurityUserData as SECURITY_USER_DATA ptr
const UNDERSTANDS_LONG_NAMES = 1
const NO_LONG_NAMES = 2

type _SECPKG_SESSIONINFO_TYPE as long
enum
	SecSessionPrimaryCred
end enum

type SECPKG_SESSIONINFO_TYPE as _SECPKG_SESSIONINFO_TYPE

type _SECPKG_NAME_TYPE as long
enum
	SecNameSamCompatible
	SecNameAlternateId
	SecNameFlat
	SecNameDN
	SecNameSPN
end enum

type SECPKG_NAME_TYPE as _SECPKG_NAME_TYPE
const NOTIFIER_FLAG_NEW_THREAD = &h00000001
const NOTIFIER_FLAG_ONE_SHOT = &h00000002
const NOTIFIER_FLAG_SECONDS = &h80000000
const NOTIFIER_TYPE_INTERVAL = 1
const NOTIFIER_TYPE_HANDLE_WAIT = 2
const NOTIFIER_TYPE_STATE_CHANGE = 3
const NOTIFIER_TYPE_NOTIFY_EVENT = 4
const NOTIFIER_TYPE_IMMEDIATE = 16
const NOTIFY_CLASS_PACKAGE_CHANGE = 1
const NOTIFY_CLASS_ROLE_CHANGE = 2
const NOTIFY_CLASS_DOMAIN_CHANGE = 3
const NOTIFY_CLASS_REGISTRY_CHANGE = 4

type _SECPKG_EVENT_PACKAGE_CHANGE
	ChangeType as ULONG
	PackageId as LSA_SEC_HANDLE
	PackageName as SECURITY_STRING
end type

type SECPKG_EVENT_PACKAGE_CHANGE as _SECPKG_EVENT_PACKAGE_CHANGE
type PSECPKG_EVENT_PACKAGE_CHANGE as _SECPKG_EVENT_PACKAGE_CHANGE ptr
const SECPKG_PACKAGE_CHANGE_LOAD = 0
const SECPKG_PACKAGE_CHANGE_UNLOAD = 1
const SECPKG_PACKAGE_CHANGE_SELECT = 2

type _SECPKG_EVENT_ROLE_CHANGE
	PreviousRole as ULONG
	NewRole as ULONG
end type

type SECPKG_EVENT_ROLE_CHANGE as _SECPKG_EVENT_ROLE_CHANGE
type PSECPKG_EVENT_ROLE_CHANGE as _SECPKG_EVENT_ROLE_CHANGE ptr
type SECPKG_EVENT_DOMAIN_CHANGE as _SECPKG_PARAMETERS
type PSECPKG_EVENT_DOMAIN_CHANGE as _SECPKG_PARAMETERS ptr

type _SECPKG_EVENT_NOTIFY
	EventClass as ULONG
	Reserved as ULONG
	EventDataSize as ULONG
	EventData as PVOID
	PackageParameter as PVOID
end type

type SECPKG_EVENT_NOTIFY as _SECPKG_EVENT_NOTIFY
type PSECPKG_EVENT_NOTIFY as _SECPKG_EVENT_NOTIFY ptr
type PLSA_IMPERSONATE_CLIENT as function() as NTSTATUS
type PLSA_UNLOAD_PACKAGE as function() as NTSTATUS
type PLSA_DUPLICATE_HANDLE as function(byval SourceHandle as HANDLE, byval DestionationHandle as PHANDLE) as NTSTATUS
type PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS as function(byval LogonId as PLUID, byval SupplementalCredSize as ULONG, byval SupplementalCreds as PVOID, byval Synchronous as WINBOOLEAN) as NTSTATUS
type PLSA_CREATE_THREAD as function(byval SecurityAttributes as SEC_ATTRS, byval StackSize as ULONG, byval StartFunction as SEC_THREAD_START, byval ThreadParameter as PVOID, byval CreationFlags as ULONG, byval ThreadId as PULONG) as HANDLE
type PLSA_GET_CLIENT_INFO as function(byval ClientInfo as PSECPKG_CLIENT_INFO) as NTSTATUS
type PLSA_REGISTER_NOTIFICATION as function(byval StartFunction as SEC_THREAD_START, byval Parameter as PVOID, byval NotificationType as ULONG, byval NotificationClass as ULONG, byval NotificationFlags as ULONG, byval IntervalMinutes as ULONG, byval WaitEvent as HANDLE) as HANDLE
type PLSA_CANCEL_NOTIFICATION as function(byval NotifyHandle as HANDLE) as NTSTATUS
type PLSA_MAP_BUFFER as function(byval InputBuffer as PSecBuffer, byval OutputBuffer as PSecBuffer) as NTSTATUS
type PLSA_CREATE_TOKEN as function(byval LogonId as PLUID, byval TokenSource as PTOKEN_SOURCE, byval LogonType as SECURITY_LOGON_TYPE, byval ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL, byval TokenInformationType as LSA_TOKEN_INFORMATION_TYPE, byval TokenInformation as PVOID, byval TokenGroups as PTOKEN_GROUPS, byval AccountName as PUNICODE_STRING, byval AuthorityName as PUNICODE_STRING, byval Workstation as PUNICODE_STRING, byval ProfilePath as PUNICODE_STRING, byval Token as PHANDLE, byval SubStatus as PNTSTATUS) as NTSTATUS
type PLSA_AUDIT_LOGON as sub(byval Status as NTSTATUS, byval SubStatus as NTSTATUS, byval AccountName as PUNICODE_STRING, byval AuthenticatingAuthority as PUNICODE_STRING, byval WorkstationName as PUNICODE_STRING, byval UserSid as PSID, byval LogonType as SECURITY_LOGON_TYPE, byval TokenSource as PTOKEN_SOURCE, byval LogonId as PLUID)
type PLSA_CALL_PACKAGE as function(byval AuthenticationPackage as PUNICODE_STRING, byval ProtocolSubmitBuffer as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
type PLSA_CALL_PACKAGEEX as function(byval AuthenticationPackage as PUNICODE_STRING, byval ClientBufferBase as PVOID, byval ProtocolSubmitBuffer as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
type PLSA_GET_CALL_INFO as function(byval Info as PSECPKG_CALL_INFO) as WINBOOLEAN
type PLSA_CREATE_SHARED_MEMORY as function(byval MaxSize as ULONG, byval InitialSize as ULONG) as PVOID
type PLSA_ALLOCATE_SHARED_MEMORY as function(byval SharedMem as PVOID, byval Size as ULONG) as PVOID
type PLSA_FREE_SHARED_MEMORY as sub(byval SharedMem as PVOID, byval Memory as PVOID)
type PLSA_DELETE_SHARED_MEMORY as function(byval SharedMem as PVOID) as WINBOOLEAN
type PLSA_OPEN_SAM_USER as function(byval Name as PSECURITY_STRING, byval NameType as SECPKG_NAME_TYPE, byval Prefix as PSECURITY_STRING, byval AllowGuest as WINBOOLEAN, byval Reserved as ULONG, byval UserHandle as PVOID ptr) as NTSTATUS
type PLSA_GET_USER_CREDENTIALS as function(byval UserHandle as PVOID, byval PrimaryCreds as PVOID ptr, byval PrimaryCredsSize as PULONG, byval SupplementalCreds as PVOID ptr, byval SupplementalCredsSize as PULONG) as NTSTATUS
type PLSA_GET_USER_AUTH_DATA as function(byval UserHandle as PVOID, byval UserAuthData as PUCHAR ptr, byval UserAuthDataSize as PULONG) as NTSTATUS
type PLSA_CLOSE_SAM_USER as function(byval UserHandle as PVOID) as NTSTATUS
type PLSA_CONVERT_AUTH_DATA_TO_TOKEN as function(byval UserAuthData as PVOID, byval UserAuthDataSize as ULONG, byval ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL, byval TokenSource as PTOKEN_SOURCE, byval LogonType as SECURITY_LOGON_TYPE, byval AuthorityName as PUNICODE_STRING, byval Token as PHANDLE, byval LogonId as PLUID, byval AccountName as PUNICODE_STRING, byval SubStatus as PNTSTATUS) as NTSTATUS
type PLSA_CLIENT_CALLBACK as function(byval Callback as PCHAR, byval Argument1 as ULONG_PTR, byval Argument2 as ULONG_PTR, byval Input as PSecBuffer, byval Output as PSecBuffer) as NTSTATUS
type PLSA_REGISTER_CALLBACK as function(byval CallbackId as ULONG, byval Callback as PLSA_CALLBACK_FUNCTION) as NTSTATUS
type PLSA_UPDATE_PRIMARY_CREDENTIALS as function(byval PrimaryCredentials as PSECPKG_PRIMARY_CRED, byval Credentials as PSECPKG_SUPPLEMENTAL_CRED_ARRAY) as NTSTATUS
type PLSA_GET_AUTH_DATA_FOR_USER as function(byval Name as PSECURITY_STRING, byval NameType as SECPKG_NAME_TYPE, byval Prefix as PSECURITY_STRING, byval UserAuthData as PUCHAR ptr, byval UserAuthDataSize as PULONG, byval UserFlatName as PUNICODE_STRING) as NTSTATUS
type PLSA_CRACK_SINGLE_NAME as function(byval FormatOffered as ULONG, byval PerformAtGC as WINBOOLEAN, byval NameInput as PUNICODE_STRING, byval Prefix as PUNICODE_STRING, byval RequestedFormat as ULONG, byval CrackedName as PUNICODE_STRING, byval DnsDomainName as PUNICODE_STRING, byval SubStatus as PULONG) as NTSTATUS
type PLSA_AUDIT_ACCOUNT_LOGON as function(byval AuditId as ULONG, byval Success as WINBOOLEAN, byval Source as PUNICODE_STRING, byval ClientName as PUNICODE_STRING, byval MappedName as PUNICODE_STRING, byval Status as NTSTATUS) as NTSTATUS
type PLSA_CALL_PACKAGE_PASSTHROUGH as function(byval AuthenticationPackage as PUNICODE_STRING, byval ClientBufferBase as PVOID, byval ProtocolSubmitBuffer as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
type PLSA_PROTECT_MEMORY as sub(byval Buffer as PVOID, byval BufferSize as ULONG)
type PLSA_OPEN_TOKEN_BY_LOGON_ID as function(byval LogonId as PLUID, byval RetTokenHandle as HANDLE ptr) as NTSTATUS
type PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN as function(byval UserAuthData as PUCHAR, byval UserAuthDataSize as ULONG, byval Reserved as PVOID, byval ExpandedAuthData as PUCHAR ptr, byval ExpandedAuthDataSize as PULONG) as NTSTATUS
type PLSA_CREATE_TOKEN_EX as function(byval LogonId as PLUID, byval TokenSource as PTOKEN_SOURCE, byval LogonType as SECURITY_LOGON_TYPE, byval ImpersonationLevel as SECURITY_IMPERSONATION_LEVEL, byval TokenInformationType as LSA_TOKEN_INFORMATION_TYPE, byval TokenInformation as PVOID, byval TokenGroups as PTOKEN_GROUPS, byval Workstation as PUNICODE_STRING, byval ProfilePath as PUNICODE_STRING, byval SessionInformation as PVOID, byval SessionInformationType as SECPKG_SESSIONINFO_TYPE, byval Token as PHANDLE, byval SubStatus as PNTSTATUS) as NTSTATUS

type _SEC_WINNT_AUTH_IDENTITY32
	User as ULONG
	UserLength as ULONG
	Domain as ULONG
	DomainLength as ULONG
	Password as ULONG
	PasswordLength as ULONG
	Flags as ULONG
end type

type SEC_WINNT_AUTH_IDENTITY32 as _SEC_WINNT_AUTH_IDENTITY32
type PSEC_WINNT_AUTH_IDENTITY32 as _SEC_WINNT_AUTH_IDENTITY32 ptr

type _SEC_WINNT_AUTH_IDENTITY_EX32
	Version as ULONG
	Length as ULONG
	User as ULONG
	UserLength as ULONG
	Domain as ULONG
	DomainLength as ULONG
	Password as ULONG
	PasswordLength as ULONG
	Flags as ULONG
	PackageList as ULONG
	PackageListLength as ULONG
end type

type SEC_WINNT_AUTH_IDENTITY_EX32 as _SEC_WINNT_AUTH_IDENTITY_EX32
type PSEC_WINNT_AUTH_IDENTITY_EX32 as _SEC_WINNT_AUTH_IDENTITY_EX32 ptr

type _LSA_SECPKG_FUNCTION_TABLE
	CreateLogonSession as PLSA_CREATE_LOGON_SESSION
	DeleteLogonSession as PLSA_DELETE_LOGON_SESSION
	AddCredential as PLSA_ADD_CREDENTIAL
	GetCredentials as PLSA_GET_CREDENTIALS
	DeleteCredential as PLSA_DELETE_CREDENTIAL
	AllocateLsaHeap as PLSA_ALLOCATE_LSA_HEAP
	FreeLsaHeap as PLSA_FREE_LSA_HEAP
	AllocateClientBuffer as PLSA_ALLOCATE_CLIENT_BUFFER
	FreeClientBuffer as PLSA_FREE_CLIENT_BUFFER
	CopyToClientBuffer as PLSA_COPY_TO_CLIENT_BUFFER
	CopyFromClientBuffer as PLSA_COPY_FROM_CLIENT_BUFFER
	ImpersonateClient as PLSA_IMPERSONATE_CLIENT
	UnloadPackage as PLSA_UNLOAD_PACKAGE
	DuplicateHandle as PLSA_DUPLICATE_HANDLE
	SaveSupplementalCredentials as PLSA_SAVE_SUPPLEMENTAL_CREDENTIALS
	CreateThread as PLSA_CREATE_THREAD
	GetClientInfo as PLSA_GET_CLIENT_INFO
	RegisterNotification as PLSA_REGISTER_NOTIFICATION
	CancelNotification as PLSA_CANCEL_NOTIFICATION
	MapBuffer as PLSA_MAP_BUFFER
	CreateToken as PLSA_CREATE_TOKEN
	AuditLogon as PLSA_AUDIT_LOGON
	CallPackage as PLSA_CALL_PACKAGE
	FreeReturnBuffer as PLSA_FREE_LSA_HEAP
	GetCallInfo as PLSA_GET_CALL_INFO
	CallPackageEx as PLSA_CALL_PACKAGEEX
	CreateSharedMemory as PLSA_CREATE_SHARED_MEMORY
	AllocateSharedMemory as PLSA_ALLOCATE_SHARED_MEMORY
	FreeSharedMemory as PLSA_FREE_SHARED_MEMORY
	DeleteSharedMemory as PLSA_DELETE_SHARED_MEMORY
	OpenSamUser as PLSA_OPEN_SAM_USER
	GetUserCredentials as PLSA_GET_USER_CREDENTIALS
	GetUserAuthData as PLSA_GET_USER_AUTH_DATA
	CloseSamUser as PLSA_CLOSE_SAM_USER
	ConvertAuthDataToToken as PLSA_CONVERT_AUTH_DATA_TO_TOKEN
	ClientCallback as PLSA_CLIENT_CALLBACK
	UpdateCredentials as PLSA_UPDATE_PRIMARY_CREDENTIALS
	GetAuthDataForUser as PLSA_GET_AUTH_DATA_FOR_USER
	CrackSingleName as PLSA_CRACK_SINGLE_NAME
	AuditAccountLogon as PLSA_AUDIT_ACCOUNT_LOGON
	CallPackagePassthrough as PLSA_CALL_PACKAGE_PASSTHROUGH
	DummyFunction1 as PLSA_PROTECT_MEMORY
	DummyFunction2 as PLSA_PROTECT_MEMORY
	DummyFunction3 as PLSA_PROTECT_MEMORY
	LsaProtectMemory as PLSA_PROTECT_MEMORY
	LsaUnprotectMemory as PLSA_PROTECT_MEMORY
	OpenTokenByLogonId as PLSA_OPEN_TOKEN_BY_LOGON_ID
	ExpandAuthDataForDomain as PLSA_EXPAND_AUTH_DATA_FOR_DOMAIN
	AllocatePrivateHeap as PLSA_ALLOCATE_PRIVATE_HEAP
	FreePrivateHeap as PLSA_FREE_PRIVATE_HEAP
	CreateTokenEx as PLSA_CREATE_TOKEN_EX
	DummyFunction4 as PLSA_PROTECT_MEMORY
end type

type LSA_SECPKG_FUNCTION_TABLE as _LSA_SECPKG_FUNCTION_TABLE
type PLSA_SECPKG_FUNCTION_TABLE as _LSA_SECPKG_FUNCTION_TABLE ptr

type _SECPKG_DLL_FUNCTIONS
	AllocateHeap as PLSA_ALLOCATE_LSA_HEAP
	FreeHeap as PLSA_FREE_LSA_HEAP
	RegisterCallback as PLSA_REGISTER_CALLBACK
end type

type SECPKG_DLL_FUNCTIONS as _SECPKG_DLL_FUNCTIONS
type PSECPKG_DLL_FUNCTIONS as _SECPKG_DLL_FUNCTIONS ptr
type PLSA_AP_LOGON_USER_EX2 as function cdecl(byval ClientRequest as PLSA_CLIENT_REQUEST, byval LogonType as SECURITY_LOGON_TYPE, byval AuthenticationInformation as PVOID, byval ClientAuthenticationBase as PVOID, byval AuthenticationInformationLength as ULONG, byval ProfileBuffer as PVOID ptr, byval ProfileBufferLength as PULONG, byval LogonId as PLUID, byval SubStatus as PNTSTATUS, byval TokenInformationType as PLSA_TOKEN_INFORMATION_TYPE, byval TokenInformation as PVOID ptr, byval AccountName as PUNICODE_STRING ptr, byval AuthenticatingAuthority as PUNICODE_STRING ptr, byval MachineName as PUNICODE_STRING ptr, byval PrimaryCredentials as PSECPKG_PRIMARY_CRED, byval CachedCredentials as PSECPKG_SUPPLEMENTAL_CRED_ARRAY ptr) as NTSTATUS
#define LSA_AP_NAME_LOGON_USER_EX2 !"LsaApLogonUserEx2\0"
#define SP_ACCEPT_CREDENTIALS_NAME !"SpAcceptCredentials\0"

type _SECPKG_FUNCTION_TABLE
	InitializePackage as PLSA_AP_INITIALIZE_PACKAGE
	LogonUser as PLSA_AP_LOGON_USER
	CallPackage as PLSA_AP_CALL_PACKAGE
	LogonTerminated as PLSA_AP_LOGON_TERMINATED
	CallPackageUntrusted as PLSA_AP_CALL_PACKAGE_UNTRUSTED
	CallPackagePassthrough as PLSA_AP_CALL_PACKAGE_PASSTHROUGH
	LogonUserEx as PLSA_AP_LOGON_USER_EX
	LogonUserEx2 as PLSA_AP_LOGON_USER_EX2
	Initialize as function(byval PackageId as ULONG_PTR, byval Parameters as PSECPKG_PARAMETERS, byval FunctionTable as PLSA_SECPKG_FUNCTION_TABLE) as NTSTATUS
	Shutdown as function() as NTSTATUS

	#ifdef UNICODE
		GetInfo as function(byval PackageInfo as PSecPkgInfoW) as NTSTATUS
	#else
		GetInfo as function(byval PackageInfo as PSecPkgInfoA) as NTSTATUS
	#endif

	AcceptCredentials as function(byval LogonType as SECURITY_LOGON_TYPE, byval AccountName as PUNICODE_STRING, byval PrimaryCredentials as PSECPKG_PRIMARY_CRED, byval SupplementalCredentials as PSECPKG_SUPPLEMENTAL_CRED) as NTSTATUS
	AcquireCredentialsHandle as function(byval PrincipalName as PUNICODE_STRING, byval CredentialUseFlags as ULONG, byval LogonId as PLUID, byval AuthorizationData as PVOID, byval GetKeyFunciton as PVOID, byval GetKeyArgument as PVOID, byval CredentialHandle as PLSA_SEC_HANDLE, byval ExpirationTime as PTimeStamp) as NTSTATUS
	QueryCredentialsAttributes as function(byval CredentialHandle as LSA_SEC_HANDLE, byval CredentialAttribute as ULONG, byval Buffer as PVOID) as NTSTATUS
	FreeCredentialsHandle as function(byval CredentialHandle as LSA_SEC_HANDLE) as NTSTATUS
	SaveCredentials as function(byval CredentialHandle as LSA_SEC_HANDLE, byval Credentials as PSecBuffer) as NTSTATUS
	GetCredentials as function(byval CredentialHandle as LSA_SEC_HANDLE, byval Credentials as PSecBuffer) as NTSTATUS
	DeleteCredentials as function(byval CredentialHandle as LSA_SEC_HANDLE, byval Key as PSecBuffer) as NTSTATUS
	InitLsaModeContext as function(byval CredentialHandle as LSA_SEC_HANDLE, byval ContextHandle as LSA_SEC_HANDLE, byval TargetName as PUNICODE_STRING, byval ContextRequirements as ULONG, byval TargetDataRep as ULONG, byval InputBuffers as PSecBufferDesc, byval NewContextHandle as PLSA_SEC_HANDLE, byval OutputBuffers as PSecBufferDesc, byval ContextAttributes as PULONG, byval ExpirationTime as PTimeStamp, byval MappedContext as PBOOLEAN, byval ContextData as PSecBuffer) as NTSTATUS
	AcceptLsaModeContext as function(byval CredentialHandle as LSA_SEC_HANDLE, byval ContextHandle as LSA_SEC_HANDLE, byval InputBuffer as PSecBufferDesc, byval ContextRequirements as ULONG, byval TargetDataRep as ULONG, byval NewContextHandle as PLSA_SEC_HANDLE, byval OutputBuffer as PSecBufferDesc, byval ContextAttributes as PULONG, byval ExpirationTime as PTimeStamp, byval MappedContext as PBOOLEAN, byval ContextData as PSecBuffer) as NTSTATUS
	DeleteContext as function(byval ContextHandle as LSA_SEC_HANDLE) as NTSTATUS
	ApplyControlToken as function(byval ContextHandle as LSA_SEC_HANDLE, byval ControlToken as PSecBufferDesc) as NTSTATUS
	GetUserInfo as function(byval LogonId as PLUID, byval Flags as ULONG, byval UserData as PSecurityUserData ptr) as NTSTATUS
	GetExtendedInformation as function(byval Class as SECPKG_EXTENDED_INFORMATION_CLASS, byval ppInformation as PSECPKG_EXTENDED_INFORMATION ptr) as NTSTATUS
	QueryContextAttributes as function(byval ContextHandle as LSA_SEC_HANDLE, byval ContextAttribute as ULONG, byval Buffer as PVOID) as NTSTATUS
	AddCredentials as function(byval CredentialHandle as LSA_SEC_HANDLE, byval PrincipalName as PUNICODE_STRING, byval Package as PUNICODE_STRING, byval CredentialUseFlags as ULONG, byval AuthorizationData as PVOID, byval GetKeyFunciton as PVOID, byval GetKeyArgument as PVOID, byval ExpirationTime as PTimeStamp) as NTSTATUS
	SetExtendedInformation as function(byval Class as SECPKG_EXTENDED_INFORMATION_CLASS, byval Info as PSECPKG_EXTENDED_INFORMATION) as NTSTATUS
	SetContextAttributes as function(byval ContextHandle as LSA_SEC_HANDLE, byval ContextAttribute as ULONG, byval Buffer as PVOID, byval BufferSize as ULONG) as NTSTATUS
	SetCredentialsAttributes as function(byval CredentialHandle as LSA_SEC_HANDLE, byval CredentialAttribute as ULONG, byval Buffer as PVOID, byval BufferSize as ULONG) as NTSTATUS
end type

type SECPKG_FUNCTION_TABLE as _SECPKG_FUNCTION_TABLE
type PSECPKG_FUNCTION_TABLE as _SECPKG_FUNCTION_TABLE ptr

type _SECPKG_USER_FUNCTION_TABLE
	InstanceInit as function(byval Version as ULONG, byval FunctionTable as PSECPKG_DLL_FUNCTIONS, byval UserFunctions as PVOID ptr) as NTSTATUS
	InitUserModeContext as function(byval ContextHandle as LSA_SEC_HANDLE, byval PackedContext as PSecBuffer) as NTSTATUS
	MakeSignature as function(byval ContextHandle as LSA_SEC_HANDLE, byval QualityOfProtection as ULONG, byval MessageBuffers as PSecBufferDesc, byval MessageSequenceNumber as ULONG) as NTSTATUS
	VerifySignature as function(byval ContextHandle as LSA_SEC_HANDLE, byval MessageBuffers as PSecBufferDesc, byval MessageSequenceNumber as ULONG, byval QualityOfProtection as PULONG) as NTSTATUS
	SealMessage as function(byval ContextHandle as LSA_SEC_HANDLE, byval QualityOfProtection as ULONG, byval MessageBuffers as PSecBufferDesc, byval MessageSequenceNumber as ULONG) as NTSTATUS
	UnsealMessage as function(byval ContextHandle as LSA_SEC_HANDLE, byval MessageBuffers as PSecBufferDesc, byval MessageSequenceNumber as ULONG, byval QualityOfProtection as PULONG) as NTSTATUS
	GetContextToken as function(byval ContextHandle as LSA_SEC_HANDLE, byval ImpersonationToken as PHANDLE) as NTSTATUS
	QueryContextAttributes as function(byval ContextHandle as LSA_SEC_HANDLE, byval ContextAttribute as ULONG, byval Buffer as PVOID) as NTSTATUS
	CompleteAuthToken as function(byval ContextHandle as LSA_SEC_HANDLE, byval InputBuffer as PSecBufferDesc) as NTSTATUS
	DeleteUserModeContext as function(byval ContextHandle as LSA_SEC_HANDLE) as NTSTATUS
	FormatCredentials as function(byval Credentials as PSecBuffer, byval FormattedCredentials as PSecBuffer) as NTSTATUS
	MarshallSupplementalCreds as function(byval CredentialSize as ULONG, byval Credentials as PUCHAR, byval MarshalledCredSize as PULONG, byval MarshalledCreds as PVOID ptr) as NTSTATUS
	ExportContext as function(byval phContext as LSA_SEC_HANDLE, byval fFlags as ULONG, byval pPackedContext as PSecBuffer, byval pToken as PHANDLE) as NTSTATUS
	ImportContext as function(byval pPackedContext as PSecBuffer, byval Token as HANDLE, byval phContext as PLSA_SEC_HANDLE) as NTSTATUS
end type

type SECPKG_USER_FUNCTION_TABLE as _SECPKG_USER_FUNCTION_TABLE
type PSECPKG_USER_FUNCTION_TABLE as _SECPKG_USER_FUNCTION_TABLE ptr
type SpLsaModeInitializeFn as function(byval LsaVersion as ULONG, byval PackageVersion as PULONG, byval ppTables as PSECPKG_FUNCTION_TABLE ptr, byval pcTables as PULONG) as NTSTATUS
type SpUserModeInitializeFn as function(byval LsaVersion as ULONG, byval PackageVersion as PULONG, byval ppTables as PSECPKG_USER_FUNCTION_TABLE ptr, byval pcTables as PULONG) as NTSTATUS

#define SECPKG_LSAMODEINIT_NAME "SpLsaModeInitialize"
#define SECPKG_USERMODEINIT_NAME "SpUserModeInitialize"
const SECPKG_INTERFACE_VERSION = &h00010000
const SECPKG_INTERFACE_VERSION_2 = &h00020000
const SECPKG_INTERFACE_VERSION_3 = &h00040000

type _KSEC_CONTEXT_TYPE as long
enum
	KSecPaged
	KSecNonPaged
end enum

type KSEC_CONTEXT_TYPE as _KSEC_CONTEXT_TYPE

type _KSEC_LIST_ENTRY
	List as LIST_ENTRY
	RefCount as LONG
	Signature as ULONG
	OwningList as PVOID
	Reserved as PVOID
end type

type KSEC_LIST_ENTRY as _KSEC_LIST_ENTRY
type PKSEC_LIST_ENTRY as _KSEC_LIST_ENTRY ptr
#macro KsecInitializeListEntry(Entry, SigValue)
	cast(PKSEC_LIST_ENTRY, Entry)->List.Flink = NULL
	cast(PKSEC_LIST_ENTRY, Entry)->List.Blink = NULL
	cast(PKSEC_LIST_ENTRY, Entry)->RefCount = 1
	cast(PKSEC_LIST_ENTRY, Entry)->Signature = SigValue
	cast(PKSEC_LIST_ENTRY, Entry)->OwningList = NULL
	cast(PKSEC_LIST_ENTRY, Entry)->Reserved = NULL
#endmacro
declare function KSecCreateContextList(byval Type as KSEC_CONTEXT_TYPE) as PVOID
declare sub KSecInsertListEntry(byval List as PVOID, byval Entry as PKSEC_LIST_ENTRY)
declare function KSecReferenceListEntry(byval Entry as PKSEC_LIST_ENTRY, byval Signature as ULONG, byval RemoveNoRef as WINBOOLEAN) as NTSTATUS
declare sub KSecDereferenceListEntry(byval Entry as PKSEC_LIST_ENTRY, byval Delete_ as WINBOOLEAN ptr)
declare function KSecSerializeWinntAuthData(byval pvAuthData as PVOID, byval Size as PULONG, byval SerializedData as PVOID ptr) as NTSTATUS
declare function KSecSerializeSchannelAuthData(byval pvAuthData as PVOID, byval Size as PULONG, byval SerializedData as PVOID ptr) as NTSTATUS

type PKSEC_CREATE_CONTEXT_LIST as function(byval Type as KSEC_CONTEXT_TYPE) as PVOID
type PKSEC_INSERT_LIST_ENTRY as sub(byval List as PVOID, byval Entry as PKSEC_LIST_ENTRY)
type PKSEC_REFERENCE_LIST_ENTRY as function(byval Entry as PKSEC_LIST_ENTRY, byval Signature as ULONG, byval RemoveNoRef as WINBOOLEAN) as NTSTATUS
type PKSEC_DEREFERENCE_LIST_ENTRY as sub(byval Entry as PKSEC_LIST_ENTRY, byval Delete_ as WINBOOLEAN ptr)
type PKSEC_SERIALIZE_WINNT_AUTH_DATA as function(byval pvAuthData as PVOID, byval Size as PULONG, byval SerializedData as PVOID ptr) as NTSTATUS
type PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA as function(byval pvAuthData as PVOID, byval Size as PULONG, byval SerializedData as PVOID ptr) as NTSTATUS

type _SECPKG_KERNEL_FUNCTIONS
	AllocateHeap as PLSA_ALLOCATE_LSA_HEAP
	FreeHeap as PLSA_FREE_LSA_HEAP
	CreateContextList as PKSEC_CREATE_CONTEXT_LIST
	InsertListEntry as PKSEC_INSERT_LIST_ENTRY
	ReferenceListEntry as PKSEC_REFERENCE_LIST_ENTRY
	DereferenceListEntry as PKSEC_DEREFERENCE_LIST_ENTRY
	SerializeWinntAuthData as PKSEC_SERIALIZE_WINNT_AUTH_DATA
	SerializeSchannelAuthData as PKSEC_SERIALIZE_SCHANNEL_AUTH_DATA
end type

type SECPKG_KERNEL_FUNCTIONS as _SECPKG_KERNEL_FUNCTIONS
type PSECPKG_KERNEL_FUNCTIONS as _SECPKG_KERNEL_FUNCTIONS ptr

type _SECPKG_KERNEL_FUNCTION_TABLE
	Initialize as function(byval FunctionTable as PSECPKG_KERNEL_FUNCTIONS) as NTSTATUS
	DeleteContext as function(byval ContextId as LSA_SEC_HANDLE, byval LsaContextId as PLSA_SEC_HANDLE) as NTSTATUS
	InitContext as function(byval ContextId as LSA_SEC_HANDLE, byval ContextData as PSecBuffer, byval NewContextId as PLSA_SEC_HANDLE) as NTSTATUS
	MapHandle as function(byval ContextId as LSA_SEC_HANDLE, byval LsaContextId as PLSA_SEC_HANDLE) as NTSTATUS
	Sign as function(byval ContextId as LSA_SEC_HANDLE, byval fQOP as ULONG, byval Message as PSecBufferDesc, byval MessageSeqNo as ULONG) as NTSTATUS
	Verify as function(byval ContextId as LSA_SEC_HANDLE, byval Message as PSecBufferDesc, byval MessageSeqNo as ULONG, byval pfQOP as PULONG) as NTSTATUS
	Seal as function(byval ContextId as LSA_SEC_HANDLE, byval fQOP as ULONG, byval Message as PSecBufferDesc, byval MessageSeqNo as ULONG) as NTSTATUS
	Unseal as function(byval ContextId as LSA_SEC_HANDLE, byval Message as PSecBufferDesc, byval MessageSeqNo as ULONG, byval pfQOP as PULONG) as NTSTATUS
	GetToken as function(byval ContextId as LSA_SEC_HANDLE, byval ImpersonationToken as PHANDLE, byval RawToken as PACCESS_TOKEN ptr) as NTSTATUS
	QueryAttributes as function(byval ContextId as LSA_SEC_HANDLE, byval Attribute as ULONG, byval Buffer as PVOID) as NTSTATUS
	CompleteToken as function(byval ContextId as LSA_SEC_HANDLE, byval Token as PSecBufferDesc) as NTSTATUS
	ExportContext as function(byval phContext as LSA_SEC_HANDLE, byval fFlags as ULONG, byval pPackedContext as PSecBuffer, byval pToken as PHANDLE) as NTSTATUS
	ImportContext as function(byval pPackedContext as PSecBuffer, byval Token as HANDLE, byval phContext as PLSA_SEC_HANDLE) as NTSTATUS
	SetPackagePagingMode as function(byval PagingMode as WINBOOLEAN) as NTSTATUS
	SerializeAuthData as function(byval pvAuthData as PVOID, byval Size as PULONG, byval SerializedData as PVOID ptr) as NTSTATUS
end type

type SECPKG_KERNEL_FUNCTION_TABLE as _SECPKG_KERNEL_FUNCTION_TABLE
type PSECPKG_KERNEL_FUNCTION_TABLE as _SECPKG_KERNEL_FUNCTION_TABLE ptr
declare function KSecRegisterSecurityProvider(byval ProviderName as PSECURITY_STRING, byval Table as PSECPKG_KERNEL_FUNCTION_TABLE) as SECURITY_STATUS
extern KspKernelFunctions as SECPKG_KERNEL_FUNCTIONS

end extern
