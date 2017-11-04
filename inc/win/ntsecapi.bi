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

#inclib "advapi32"

#include once "guiddef.bi"

'' The following symbols have been renamed:
''     typedef STRING => STRING_

extern "Windows"

#define _NTSECAPI_
type LSA_OPERATIONAL_MODE as ULONG
type PLSA_OPERATIONAL_MODE as ULONG ptr
const LSA_MODE_PASSWORD_PROTECTED = &h00000001
const LSA_MODE_INDIVIDUAL_ACCOUNTS = &h00000002
const LSA_MODE_MANDATORY_ACCESS = &h00000004
const LSA_MODE_LOG_FULL = &h00000008

type _SECURITY_LOGON_TYPE as long
enum
	Interactive = 2
	Network
	Batch
	Service
	Proxy
	Unlock_
	NetworkCleartext
	NewCredentials
	RemoteInteractive
	CachedInteractive
	CachedRemoteInteractive
	CachedUnlock
end enum

type SECURITY_LOGON_TYPE as _SECURITY_LOGON_TYPE
type PSECURITY_LOGON_TYPE as _SECURITY_LOGON_TYPE ptr
#define _NTLSA_AUDIT_

type _SE_ADT_PARAMETER_TYPE as long
enum
	SeAdtParmTypeNone = 0
	SeAdtParmTypeString
	SeAdtParmTypeFileSpec
	SeAdtParmTypeUlong
	SeAdtParmTypeSid
	SeAdtParmTypeLogonId
	SeAdtParmTypeNoLogonId
	SeAdtParmTypeAccessMask
	SeAdtParmTypePrivs
	SeAdtParmTypeObjectTypes
	SeAdtParmTypeHexUlong
	SeAdtParmTypePtr
	SeAdtParmTypeTime
	SeAdtParmTypeGuid
	SeAdtParmTypeLuid
	SeAdtParmTypeHexInt64
	SeAdtParmTypeStringList
	SeAdtParmTypeSidList
	SeAdtParmTypeDuration
	SeAdtParmTypeUserAccountControl
	SeAdtParmTypeNoUac
	SeAdtParmTypeMessage
	SeAdtParmTypeDateTime
	SeAdtParmTypeSockAddr
end enum

type SE_ADT_PARAMETER_TYPE as _SE_ADT_PARAMETER_TYPE
type PSE_ADT_PARAMETER_TYPE as _SE_ADT_PARAMETER_TYPE ptr
const SE_ADT_OBJECT_ONLY = &h1

type _SE_ADT_OBJECT_TYPE
	ObjectType as GUID
	Flags as USHORT
	Level as USHORT
	AccessMask as ACCESS_MASK
end type

type SE_ADT_OBJECT_TYPE as _SE_ADT_OBJECT_TYPE
type PSE_ADT_OBJECT_TYPE as _SE_ADT_OBJECT_TYPE ptr

type _SE_ADT_PARAMETER_ARRAY_ENTRY
	as SE_ADT_PARAMETER_TYPE Type
	Length as ULONG
	Data(0 to 1) as ULONG_PTR
	Address as PVOID
end type

type SE_ADT_PARAMETER_ARRAY_ENTRY as _SE_ADT_PARAMETER_ARRAY_ENTRY
type PSE_ADT_PARAMETER_ARRAY_ENTRY as _SE_ADT_PARAMETER_ARRAY_ENTRY ptr
const SE_MAX_AUDIT_PARAMETERS = 32
const SE_MAX_GENERIC_AUDIT_PARAMETERS = 28

type _SE_ADT_PARAMETER_ARRAY
	CategoryId as ULONG
	AuditId as ULONG
	ParameterCount as ULONG
	Length as ULONG
	as USHORT Type
	Flags as ULONG
	Parameters(0 to 31) as SE_ADT_PARAMETER_ARRAY_ENTRY
end type

type SE_ADT_PARAMETER_ARRAY as _SE_ADT_PARAMETER_ARRAY
type PSE_ADT_PARAMETER_ARRAY as _SE_ADT_PARAMETER_ARRAY ptr
const SE_ADT_PARAMETERS_SELF_RELATIVE = &h00000001

type _POLICY_AUDIT_EVENT_TYPE as long
enum
	AuditCategorySystem = 0
	AuditCategoryLogon
	AuditCategoryObjectAccess
	AuditCategoryPrivilegeUse
	AuditCategoryDetailedTracking
	AuditCategoryPolicyChange
	AuditCategoryAccountManagement
	AuditCategoryDirectoryServiceAccess
	AuditCategoryAccountLogon
end enum

type POLICY_AUDIT_EVENT_TYPE as _POLICY_AUDIT_EVENT_TYPE
type PPOLICY_AUDIT_EVENT_TYPE as _POLICY_AUDIT_EVENT_TYPE ptr
const POLICY_AUDIT_EVENT_UNCHANGED = &h00000000
const POLICY_AUDIT_EVENT_SUCCESS = &h00000001
const POLICY_AUDIT_EVENT_FAILURE = &h00000002
const POLICY_AUDIT_EVENT_NONE = &h00000004
const POLICY_AUDIT_EVENT_MASK = ((POLICY_AUDIT_EVENT_SUCCESS or POLICY_AUDIT_EVENT_FAILURE) or POLICY_AUDIT_EVENT_UNCHANGED) or POLICY_AUDIT_EVENT_NONE

type _LSA_UNICODE_STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PWSTR
end type

type LSA_UNICODE_STRING as _LSA_UNICODE_STRING
type PLSA_UNICODE_STRING as _LSA_UNICODE_STRING ptr

type _LSA_STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PCHAR
end type

type LSA_STRING as _LSA_STRING
type PLSA_STRING as _LSA_STRING ptr

type _LSA_OBJECT_ATTRIBUTES
	Length as ULONG
	RootDirectory as HANDLE
	ObjectName as PLSA_UNICODE_STRING
	Attributes as ULONG
	SecurityDescriptor as PVOID
	SecurityQualityOfService as PVOID
end type

type LSA_OBJECT_ATTRIBUTES as _LSA_OBJECT_ATTRIBUTES
type PLSA_OBJECT_ATTRIBUTES as _LSA_OBJECT_ATTRIBUTES ptr
#define LSA_SUCCESS(Error) (cast(LONG, (Error)) >= 0)
declare function LsaRegisterLogonProcess(byval LogonProcessName as PLSA_STRING, byval LsaHandle as PHANDLE, byval SecurityMode as PLSA_OPERATIONAL_MODE) as NTSTATUS
declare function LsaLogonUser(byval LsaHandle as HANDLE, byval OriginName as PLSA_STRING, byval LogonType as SECURITY_LOGON_TYPE, byval AuthenticationPackage as ULONG, byval AuthenticationInformation as PVOID, byval AuthenticationInformationLength as ULONG, byval LocalGroups as PTOKEN_GROUPS, byval SourceContext as PTOKEN_SOURCE, byval ProfileBuffer as PVOID ptr, byval ProfileBufferLength as PULONG, byval LogonId as PLUID, byval Token as PHANDLE, byval Quotas as PQUOTA_LIMITS, byval SubStatus as PNTSTATUS) as NTSTATUS
declare function LsaLookupAuthenticationPackage(byval LsaHandle as HANDLE, byval PackageName as PLSA_STRING, byval AuthenticationPackage as PULONG) as NTSTATUS
declare function LsaFreeReturnBuffer(byval Buffer as PVOID) as NTSTATUS
declare function LsaCallAuthenticationPackage(byval LsaHandle as HANDLE, byval AuthenticationPackage as ULONG, byval ProtocolSubmitBuffer as PVOID, byval SubmitBufferLength as ULONG, byval ProtocolReturnBuffer as PVOID ptr, byval ReturnBufferLength as PULONG, byval ProtocolStatus as PNTSTATUS) as NTSTATUS
declare function LsaDeregisterLogonProcess(byval LsaHandle as HANDLE) as NTSTATUS
declare function LsaConnectUntrusted(byval LsaHandle as PHANDLE) as NTSTATUS

const POLICY_VIEW_LOCAL_INFORMATION = &h00000001
const POLICY_VIEW_AUDIT_INFORMATION = &h00000002
const POLICY_GET_PRIVATE_INFORMATION = &h00000004
const POLICY_TRUST_ADMIN = &h00000008
const POLICY_CREATE_ACCOUNT = &h00000010
const POLICY_CREATE_SECRET = &h00000020
const POLICY_CREATE_PRIVILEGE = &h00000040
const POLICY_SET_DEFAULT_QUOTA_LIMITS = &h00000080
const POLICY_SET_AUDIT_REQUIREMENTS = &h00000100
const POLICY_AUDIT_LOG_ADMIN = &h00000200
const POLICY_SERVER_ADMIN = &h00000400
const POLICY_LOOKUP_NAMES = &h00000800
const POLICY_NOTIFICATION = &h00001000
const POLICY_ALL_ACCESS = (((((((((((STANDARD_RIGHTS_REQUIRED or POLICY_VIEW_LOCAL_INFORMATION) or POLICY_VIEW_AUDIT_INFORMATION) or POLICY_GET_PRIVATE_INFORMATION) or POLICY_TRUST_ADMIN) or POLICY_CREATE_ACCOUNT) or POLICY_CREATE_SECRET) or POLICY_CREATE_PRIVILEGE) or POLICY_SET_DEFAULT_QUOTA_LIMITS) or POLICY_SET_AUDIT_REQUIREMENTS) or POLICY_AUDIT_LOG_ADMIN) or POLICY_SERVER_ADMIN) or POLICY_LOOKUP_NAMES
const POLICY_READ = (STANDARD_RIGHTS_READ or POLICY_VIEW_AUDIT_INFORMATION) or POLICY_GET_PRIVATE_INFORMATION
const POLICY_WRITE = (((((((STANDARD_RIGHTS_WRITE or POLICY_TRUST_ADMIN) or POLICY_CREATE_ACCOUNT) or POLICY_CREATE_SECRET) or POLICY_CREATE_PRIVILEGE) or POLICY_SET_DEFAULT_QUOTA_LIMITS) or POLICY_SET_AUDIT_REQUIREMENTS) or POLICY_AUDIT_LOG_ADMIN) or POLICY_SERVER_ADMIN
const POLICY_EXECUTE = (STANDARD_RIGHTS_EXECUTE or POLICY_VIEW_LOCAL_INFORMATION) or POLICY_LOOKUP_NAMES

type _LSA_TRUST_INFORMATION
	Name as LSA_UNICODE_STRING
	Sid as PSID
end type

type LSA_TRUST_INFORMATION as _LSA_TRUST_INFORMATION
type PLSA_TRUST_INFORMATION as _LSA_TRUST_INFORMATION ptr

type _LSA_REFERENCED_DOMAIN_LIST
	Entries as ULONG
	Domains as PLSA_TRUST_INFORMATION
end type

type LSA_REFERENCED_DOMAIN_LIST as _LSA_REFERENCED_DOMAIN_LIST
type PLSA_REFERENCED_DOMAIN_LIST as _LSA_REFERENCED_DOMAIN_LIST ptr

type _LSA_TRANSLATED_SID
	Use as SID_NAME_USE
	RelativeId as ULONG
	DomainIndex as LONG
end type

type LSA_TRANSLATED_SID as _LSA_TRANSLATED_SID
type PLSA_TRANSLATED_SID as _LSA_TRANSLATED_SID ptr

type _LSA_TRANSLATED_SID2
	Use as SID_NAME_USE
	Sid as PSID
	DomainIndex as LONG
	Flags as ULONG
end type

type LSA_TRANSLATED_SID2 as _LSA_TRANSLATED_SID2
type PLSA_TRANSLATED_SID2 as _LSA_TRANSLATED_SID2 ptr

type _LSA_TRANSLATED_NAME
	Use as SID_NAME_USE
	Name as LSA_UNICODE_STRING
	DomainIndex as LONG
end type

type LSA_TRANSLATED_NAME as _LSA_TRANSLATED_NAME
type PLSA_TRANSLATED_NAME as _LSA_TRANSLATED_NAME ptr

type _POLICY_LSA_SERVER_ROLE as long
enum
	PolicyServerRoleBackup = 2
	PolicyServerRolePrimary
end enum

type POLICY_LSA_SERVER_ROLE as _POLICY_LSA_SERVER_ROLE
type PPOLICY_LSA_SERVER_ROLE as _POLICY_LSA_SERVER_ROLE ptr
type POLICY_AUDIT_EVENT_OPTIONS as ULONG
type PPOLICY_AUDIT_EVENT_OPTIONS as ULONG ptr

type _POLICY_INFORMATION_CLASS as long
enum
	PolicyAuditLogInformation = 1
	PolicyAuditEventsInformation
	PolicyPrimaryDomainInformation
	PolicyPdAccountInformation
	PolicyAccountDomainInformation
	PolicyLsaServerRoleInformation
	PolicyReplicaSourceInformation
	PolicyDefaultQuotaInformation
	PolicyModificationInformation
	PolicyAuditFullSetInformation
	PolicyAuditFullQueryInformation
	PolicyDnsDomainInformation
	PolicyDnsDomainInformationInt
end enum

type POLICY_INFORMATION_CLASS as _POLICY_INFORMATION_CLASS
type PPOLICY_INFORMATION_CLASS as _POLICY_INFORMATION_CLASS ptr

type _POLICY_AUDIT_LOG_INFO
	AuditLogPercentFull as ULONG
	MaximumLogSize as ULONG
	AuditRetentionPeriod as LARGE_INTEGER
	AuditLogFullShutdownInProgress as WINBOOLEAN
	TimeToShutdown as LARGE_INTEGER
	NextAuditRecordId as ULONG
end type

type POLICY_AUDIT_LOG_INFO as _POLICY_AUDIT_LOG_INFO
type PPOLICY_AUDIT_LOG_INFO as _POLICY_AUDIT_LOG_INFO ptr

type _POLICY_AUDIT_EVENTS_INFO
	AuditingMode as WINBOOLEAN
	EventAuditingOptions as PPOLICY_AUDIT_EVENT_OPTIONS
	MaximumAuditEventCount as ULONG
end type

type POLICY_AUDIT_EVENTS_INFO as _POLICY_AUDIT_EVENTS_INFO
type PPOLICY_AUDIT_EVENTS_INFO as _POLICY_AUDIT_EVENTS_INFO ptr

type _POLICY_ACCOUNT_DOMAIN_INFO
	DomainName as LSA_UNICODE_STRING
	DomainSid as PSID
end type

type POLICY_ACCOUNT_DOMAIN_INFO as _POLICY_ACCOUNT_DOMAIN_INFO
type PPOLICY_ACCOUNT_DOMAIN_INFO as _POLICY_ACCOUNT_DOMAIN_INFO ptr

type _POLICY_PRIMARY_DOMAIN_INFO
	Name as LSA_UNICODE_STRING
	Sid as PSID
end type

type POLICY_PRIMARY_DOMAIN_INFO as _POLICY_PRIMARY_DOMAIN_INFO
type PPOLICY_PRIMARY_DOMAIN_INFO as _POLICY_PRIMARY_DOMAIN_INFO ptr

type _POLICY_DNS_DOMAIN_INFO
	Name as LSA_UNICODE_STRING
	DnsDomainName as LSA_UNICODE_STRING
	DnsForestName as LSA_UNICODE_STRING
	DomainGuid as GUID
	Sid as PSID
end type

type POLICY_DNS_DOMAIN_INFO as _POLICY_DNS_DOMAIN_INFO
type PPOLICY_DNS_DOMAIN_INFO as _POLICY_DNS_DOMAIN_INFO ptr

type _POLICY_PD_ACCOUNT_INFO
	Name as LSA_UNICODE_STRING
end type

type POLICY_PD_ACCOUNT_INFO as _POLICY_PD_ACCOUNT_INFO
type PPOLICY_PD_ACCOUNT_INFO as _POLICY_PD_ACCOUNT_INFO ptr

type _POLICY_LSA_SERVER_ROLE_INFO
	LsaServerRole as POLICY_LSA_SERVER_ROLE
end type

type POLICY_LSA_SERVER_ROLE_INFO as _POLICY_LSA_SERVER_ROLE_INFO
type PPOLICY_LSA_SERVER_ROLE_INFO as _POLICY_LSA_SERVER_ROLE_INFO ptr

type _POLICY_REPLICA_SOURCE_INFO
	ReplicaSource as LSA_UNICODE_STRING
	ReplicaAccountName as LSA_UNICODE_STRING
end type

type POLICY_REPLICA_SOURCE_INFO as _POLICY_REPLICA_SOURCE_INFO
type PPOLICY_REPLICA_SOURCE_INFO as _POLICY_REPLICA_SOURCE_INFO ptr

type _POLICY_DEFAULT_QUOTA_INFO
	QuotaLimits as QUOTA_LIMITS
end type

type POLICY_DEFAULT_QUOTA_INFO as _POLICY_DEFAULT_QUOTA_INFO
type PPOLICY_DEFAULT_QUOTA_INFO as _POLICY_DEFAULT_QUOTA_INFO ptr

type _POLICY_MODIFICATION_INFO
	ModifiedId as LARGE_INTEGER
	DatabaseCreationTime as LARGE_INTEGER
end type

type POLICY_MODIFICATION_INFO as _POLICY_MODIFICATION_INFO
type PPOLICY_MODIFICATION_INFO as _POLICY_MODIFICATION_INFO ptr

type _POLICY_AUDIT_FULL_SET_INFO
	ShutDownOnFull as WINBOOLEAN
end type

type POLICY_AUDIT_FULL_SET_INFO as _POLICY_AUDIT_FULL_SET_INFO
type PPOLICY_AUDIT_FULL_SET_INFO as _POLICY_AUDIT_FULL_SET_INFO ptr

type _POLICY_AUDIT_FULL_QUERY_INFO
	ShutDownOnFull as WINBOOLEAN
	LogIsFull as WINBOOLEAN
end type

type POLICY_AUDIT_FULL_QUERY_INFO as _POLICY_AUDIT_FULL_QUERY_INFO
type PPOLICY_AUDIT_FULL_QUERY_INFO as _POLICY_AUDIT_FULL_QUERY_INFO ptr

type _POLICY_DOMAIN_INFORMATION_CLASS as long
enum
	PolicyDomainEfsInformation = 2
	PolicyDomainKerberosTicketInformation
end enum

type POLICY_DOMAIN_INFORMATION_CLASS as _POLICY_DOMAIN_INFORMATION_CLASS
type PPOLICY_DOMAIN_INFORMATION_CLASS as _POLICY_DOMAIN_INFORMATION_CLASS ptr

type _POLICY_DOMAIN_EFS_INFO
	InfoLength as ULONG
	EfsBlob as PUCHAR
end type

type POLICY_DOMAIN_EFS_INFO as _POLICY_DOMAIN_EFS_INFO
type PPOLICY_DOMAIN_EFS_INFO as _POLICY_DOMAIN_EFS_INFO ptr
const POLICY_KERBEROS_VALIDATE_CLIENT = &h00000080

type _POLICY_DOMAIN_KERBEROS_TICKET_INFO
	AuthenticationOptions as ULONG
	MaxServiceTicketAge as LARGE_INTEGER
	MaxTicketAge as LARGE_INTEGER
	MaxRenewAge as LARGE_INTEGER
	MaxClockSkew as LARGE_INTEGER
	Reserved as LARGE_INTEGER
end type

type POLICY_DOMAIN_KERBEROS_TICKET_INFO as _POLICY_DOMAIN_KERBEROS_TICKET_INFO
type PPOLICY_DOMAIN_KERBEROS_TICKET_INFO as _POLICY_DOMAIN_KERBEROS_TICKET_INFO ptr

type _POLICY_NOTIFICATION_INFORMATION_CLASS as long
enum
	PolicyNotifyAuditEventsInformation = 1
	PolicyNotifyAccountDomainInformation
	PolicyNotifyServerRoleInformation
	PolicyNotifyDnsDomainInformation
	PolicyNotifyDomainEfsInformation
	PolicyNotifyDomainKerberosTicketInformation
	PolicyNotifyMachineAccountPasswordInformation
end enum

type POLICY_NOTIFICATION_INFORMATION_CLASS as _POLICY_NOTIFICATION_INFORMATION_CLASS
type PPOLICY_NOTIFICATION_INFORMATION_CLASS as _POLICY_NOTIFICATION_INFORMATION_CLASS ptr
type LSA_HANDLE as PVOID
type PLSA_HANDLE as PVOID ptr

type _TRUSTED_INFORMATION_CLASS as long
enum
	TrustedDomainNameInformation = 1
	TrustedControllersInformation
	TrustedPosixOffsetInformation
	TrustedPasswordInformation
	TrustedDomainInformationBasic
	TrustedDomainInformationEx
	TrustedDomainAuthInformation
	TrustedDomainFullInformation
	TrustedDomainAuthInformationInternal
	TrustedDomainFullInformationInternal
	TrustedDomainInformationEx2Internal
	TrustedDomainFullInformation2Internal
end enum

type TRUSTED_INFORMATION_CLASS as _TRUSTED_INFORMATION_CLASS
type PTRUSTED_INFORMATION_CLASS as _TRUSTED_INFORMATION_CLASS ptr

type _TRUSTED_DOMAIN_NAME_INFO
	Name as LSA_UNICODE_STRING
end type

type TRUSTED_DOMAIN_NAME_INFO as _TRUSTED_DOMAIN_NAME_INFO
type PTRUSTED_DOMAIN_NAME_INFO as _TRUSTED_DOMAIN_NAME_INFO ptr

type _TRUSTED_CONTROLLERS_INFO
	Entries as ULONG
	Names as PLSA_UNICODE_STRING
end type

type TRUSTED_CONTROLLERS_INFO as _TRUSTED_CONTROLLERS_INFO
type PTRUSTED_CONTROLLERS_INFO as _TRUSTED_CONTROLLERS_INFO ptr

type _TRUSTED_POSIX_OFFSET_INFO
	Offset as ULONG
end type

type TRUSTED_POSIX_OFFSET_INFO as _TRUSTED_POSIX_OFFSET_INFO
type PTRUSTED_POSIX_OFFSET_INFO as _TRUSTED_POSIX_OFFSET_INFO ptr

type _TRUSTED_PASSWORD_INFO
	Password as LSA_UNICODE_STRING
	OldPassword as LSA_UNICODE_STRING
end type

type TRUSTED_PASSWORD_INFO as _TRUSTED_PASSWORD_INFO
type PTRUSTED_PASSWORD_INFO as _TRUSTED_PASSWORD_INFO ptr
type TRUSTED_DOMAIN_INFORMATION_BASIC as LSA_TRUST_INFORMATION
type PTRUSTED_DOMAIN_INFORMATION_BASIC as PLSA_TRUST_INFORMATION

const TRUST_DIRECTION_DISABLED = &h00000000
const TRUST_DIRECTION_INBOUND = &h00000001
const TRUST_DIRECTION_OUTBOUND = &h00000002
const TRUST_DIRECTION_BIDIRECTIONAL = TRUST_DIRECTION_INBOUND or TRUST_DIRECTION_OUTBOUND
const TRUST_TYPE_DOWNLEVEL = &h00000001
const TRUST_TYPE_UPLEVEL = &h00000002
const TRUST_TYPE_MIT = &h00000003
const TRUST_ATTRIBUTE_NON_TRANSITIVE = &h00000001
const TRUST_ATTRIBUTE_UPLEVEL_ONLY = &h00000002
const TRUST_ATTRIBUTE_QUARANTINED_DOMAIN = &h00000004
const TRUST_ATTRIBUTE_FOREST_TRANSITIVE = &h00000008
const TRUST_ATTRIBUTE_CROSS_ORGANIZATION = &h00000010
const TRUST_ATTRIBUTE_WITHIN_FOREST = &h00000020
const TRUST_ATTRIBUTE_TREAT_AS_EXTERNAL = &h00000040
const TRUST_ATTRIBUTE_TRUST_USES_RC4_ENCRYPTION = &h00000080
const TRUST_ATTRIBUTES_VALID = &hFF03FFFF
const TRUST_ATTRIBUTES_USER = &hFF000000

type _TRUSTED_DOMAIN_INFORMATION_EX
	Name as LSA_UNICODE_STRING
	FlatName as LSA_UNICODE_STRING
	Sid as PSID
	TrustDirection as ULONG
	TrustType as ULONG
	TrustAttributes as ULONG
end type

type TRUSTED_DOMAIN_INFORMATION_EX as _TRUSTED_DOMAIN_INFORMATION_EX
type PTRUSTED_DOMAIN_INFORMATION_EX as _TRUSTED_DOMAIN_INFORMATION_EX ptr

type _TRUSTED_DOMAIN_INFORMATION_EX2
	Name as LSA_UNICODE_STRING
	FlatName as LSA_UNICODE_STRING
	Sid as PSID
	TrustDirection as ULONG
	TrustType as ULONG
	TrustAttributes as ULONG
	ForestTrustLength as ULONG
	ForestTrustInfo as PUCHAR
end type

type TRUSTED_DOMAIN_INFORMATION_EX2 as _TRUSTED_DOMAIN_INFORMATION_EX2
type PTRUSTED_DOMAIN_INFORMATION_EX2 as _TRUSTED_DOMAIN_INFORMATION_EX2 ptr
const TRUST_AUTH_TYPE_NONE = 0
const TRUST_AUTH_TYPE_NT4OWF = 1
const TRUST_AUTH_TYPE_CLEAR = 2
const TRUST_AUTH_TYPE_VERSION = 3

type _LSA_AUTH_INFORMATION
	LastUpdateTime as LARGE_INTEGER
	AuthType as ULONG
	AuthInfoLength as ULONG
	AuthInfo as PUCHAR
end type

type LSA_AUTH_INFORMATION as _LSA_AUTH_INFORMATION
type PLSA_AUTH_INFORMATION as _LSA_AUTH_INFORMATION ptr

type _TRUSTED_DOMAIN_AUTH_INFORMATION
	IncomingAuthInfos as ULONG
	IncomingAuthenticationInformation as PLSA_AUTH_INFORMATION
	IncomingPreviousAuthenticationInformation as PLSA_AUTH_INFORMATION
	OutgoingAuthInfos as ULONG
	OutgoingAuthenticationInformation as PLSA_AUTH_INFORMATION
	OutgoingPreviousAuthenticationInformation as PLSA_AUTH_INFORMATION
end type

type TRUSTED_DOMAIN_AUTH_INFORMATION as _TRUSTED_DOMAIN_AUTH_INFORMATION
type PTRUSTED_DOMAIN_AUTH_INFORMATION as _TRUSTED_DOMAIN_AUTH_INFORMATION ptr

type _TRUSTED_DOMAIN_FULL_INFORMATION
	Information as TRUSTED_DOMAIN_INFORMATION_EX
	PosixOffset as TRUSTED_POSIX_OFFSET_INFO
	AuthInformation as TRUSTED_DOMAIN_AUTH_INFORMATION
end type

type TRUSTED_DOMAIN_FULL_INFORMATION as _TRUSTED_DOMAIN_FULL_INFORMATION
type PTRUSTED_DOMAIN_FULL_INFORMATION as _TRUSTED_DOMAIN_FULL_INFORMATION ptr

type _TRUSTED_DOMAIN_FULL_INFORMATION2
	Information as TRUSTED_DOMAIN_INFORMATION_EX2
	PosixOffset as TRUSTED_POSIX_OFFSET_INFO
	AuthInformation as TRUSTED_DOMAIN_AUTH_INFORMATION
end type

type TRUSTED_DOMAIN_FULL_INFORMATION2 as _TRUSTED_DOMAIN_FULL_INFORMATION2
type PTRUSTED_DOMAIN_FULL_INFORMATION2 as _TRUSTED_DOMAIN_FULL_INFORMATION2 ptr

type LSA_FOREST_TRUST_RECORD_TYPE as long
enum
	ForestTrustTopLevelName
	ForestTrustTopLevelNameEx
	ForestTrustDomainInfo
	ForestTrustRecordTypeLast = ForestTrustDomainInfo
end enum

const LSA_FTRECORD_DISABLED_REASONS = &h0000FFFF
const LSA_TLN_DISABLED_NEW = &h00000001
const LSA_TLN_DISABLED_ADMIN = &h00000002
const LSA_TLN_DISABLED_CONFLICT = &h00000004
const LSA_SID_DISABLED_ADMIN = &h00000001
const LSA_SID_DISABLED_CONFLICT = &h00000002
const LSA_NB_DISABLED_ADMIN = &h00000004
const LSA_NB_DISABLED_CONFLICT = &h00000008

type _LSA_FOREST_TRUST_DOMAIN_INFO
	Sid as PSID
	DnsName as LSA_UNICODE_STRING
	NetbiosName as LSA_UNICODE_STRING
end type

type LSA_FOREST_TRUST_DOMAIN_INFO as _LSA_FOREST_TRUST_DOMAIN_INFO
type PLSA_FOREST_TRUST_DOMAIN_INFO as _LSA_FOREST_TRUST_DOMAIN_INFO ptr
const MAX_FOREST_TRUST_BINARY_DATA_SIZE = 128 * 1024

type _LSA_FOREST_TRUST_BINARY_DATA
	Length as ULONG
	Buffer as PUCHAR
end type

type LSA_FOREST_TRUST_BINARY_DATA as _LSA_FOREST_TRUST_BINARY_DATA
type PLSA_FOREST_TRUST_BINARY_DATA as _LSA_FOREST_TRUST_BINARY_DATA ptr

union _LSA_FOREST_TRUST_RECORD_ForestTrustData
	TopLevelName as LSA_UNICODE_STRING
	DomainInfo as LSA_FOREST_TRUST_DOMAIN_INFO
	Data as LSA_FOREST_TRUST_BINARY_DATA
end union

type _LSA_FOREST_TRUST_RECORD
	Flags as ULONG
	ForestTrustType as LSA_FOREST_TRUST_RECORD_TYPE
	Time as LARGE_INTEGER
	ForestTrustData as _LSA_FOREST_TRUST_RECORD_ForestTrustData
end type

type LSA_FOREST_TRUST_RECORD as _LSA_FOREST_TRUST_RECORD
type PLSA_FOREST_TRUST_RECORD as _LSA_FOREST_TRUST_RECORD ptr
const MAX_RECORDS_IN_FOREST_TRUST_INFO = 4000

type _LSA_FOREST_TRUST_INFORMATION
	RecordCount as ULONG
	Entries as PLSA_FOREST_TRUST_RECORD ptr
end type

type LSA_FOREST_TRUST_INFORMATION as _LSA_FOREST_TRUST_INFORMATION
type PLSA_FOREST_TRUST_INFORMATION as _LSA_FOREST_TRUST_INFORMATION ptr

type LSA_FOREST_TRUST_COLLISION_RECORD_TYPE as long
enum
	CollisionTdo
	CollisionXref
	CollisionOther
end enum

type _LSA_FOREST_TRUST_COLLISION_RECORD
	Index as ULONG
	as LSA_FOREST_TRUST_COLLISION_RECORD_TYPE Type
	Flags as ULONG
	Name as LSA_UNICODE_STRING
end type

type LSA_FOREST_TRUST_COLLISION_RECORD as _LSA_FOREST_TRUST_COLLISION_RECORD
type PLSA_FOREST_TRUST_COLLISION_RECORD as _LSA_FOREST_TRUST_COLLISION_RECORD ptr

type _LSA_FOREST_TRUST_COLLISION_INFORMATION
	RecordCount as ULONG
	Entries as PLSA_FOREST_TRUST_COLLISION_RECORD ptr
end type

type LSA_FOREST_TRUST_COLLISION_INFORMATION as _LSA_FOREST_TRUST_COLLISION_INFORMATION
type PLSA_FOREST_TRUST_COLLISION_INFORMATION as _LSA_FOREST_TRUST_COLLISION_INFORMATION ptr
type LSA_ENUMERATION_HANDLE as ULONG
type PLSA_ENUMERATION_HANDLE as ULONG ptr

type _LSA_ENUMERATION_INFORMATION
	Sid as PSID
end type

type LSA_ENUMERATION_INFORMATION as _LSA_ENUMERATION_INFORMATION
type PLSA_ENUMERATION_INFORMATION as _LSA_ENUMERATION_INFORMATION ptr
declare function LsaFreeMemory(byval Buffer as PVOID) as NTSTATUS
declare function LsaClose(byval ObjectHandle as LSA_HANDLE) as NTSTATUS

#if _WIN32_WINNT >= &h0600
	type _LSA_LAST_INTER_LOGON_INFO
		LastSuccessfulLogon as LARGE_INTEGER
		LastFailedLogon as LARGE_INTEGER
		FailedAttemptCountSinceLastSuccessfulLogon as ULONG
	end type

	type LSA_LAST_INTER_LOGON_INFO as _LSA_LAST_INTER_LOGON_INFO
	type PLSA_LAST_INTER_LOGON_INFO as _LSA_LAST_INTER_LOGON_INFO ptr
#endif

type _SECURITY_LOGON_SESSION_DATA
	Size as ULONG
	LogonId as LUID
	UserName as LSA_UNICODE_STRING
	LogonDomain as LSA_UNICODE_STRING
	AuthenticationPackage as LSA_UNICODE_STRING
	LogonType as ULONG
	Session as ULONG
	Sid as PSID
	LogonTime as LARGE_INTEGER
	LogonServer as LSA_UNICODE_STRING
	DnsDomainName as LSA_UNICODE_STRING
	Upn as LSA_UNICODE_STRING

	#if _WIN32_WINNT >= &h0600
		UserFlags as ULONG
		LastLogonInfo as LSA_LAST_INTER_LOGON_INFO
		LogonScript as LSA_UNICODE_STRING
		ProfilePath as LSA_UNICODE_STRING
		HomeDirectory as LSA_UNICODE_STRING
		HomeDirectoryDrive as LSA_UNICODE_STRING
		LogoffTime as LARGE_INTEGER
		KickOffTime as LARGE_INTEGER
		PasswordLastSet as LARGE_INTEGER
		PasswordCanChange as LARGE_INTEGER
		PasswordMustChange as LARGE_INTEGER
	#endif
end type

type SECURITY_LOGON_SESSION_DATA as _SECURITY_LOGON_SESSION_DATA
type PSECURITY_LOGON_SESSION_DATA as _SECURITY_LOGON_SESSION_DATA ptr
declare function LsaEnumerateLogonSessions(byval LogonSessionCount as PULONG, byval LogonSessionList as PLUID ptr) as NTSTATUS
declare function LsaGetLogonSessionData(byval LogonId as PLUID, byval ppLogonSessionData as PSECURITY_LOGON_SESSION_DATA ptr) as NTSTATUS
declare function LsaOpenPolicy(byval SystemName as PLSA_UNICODE_STRING, byval ObjectAttributes as PLSA_OBJECT_ATTRIBUTES, byval DesiredAccess as ACCESS_MASK, byval PolicyHandle as PLSA_HANDLE) as NTSTATUS
declare function LsaQueryInformationPolicy(byval PolicyHandle as LSA_HANDLE, byval InformationClass as POLICY_INFORMATION_CLASS, byval Buffer as PVOID ptr) as NTSTATUS
declare function LsaSetInformationPolicy(byval PolicyHandle as LSA_HANDLE, byval InformationClass as POLICY_INFORMATION_CLASS, byval Buffer as PVOID) as NTSTATUS
declare function LsaQueryDomainInformationPolicy(byval PolicyHandle as LSA_HANDLE, byval InformationClass as POLICY_DOMAIN_INFORMATION_CLASS, byval Buffer as PVOID ptr) as NTSTATUS
declare function LsaSetDomainInformationPolicy(byval PolicyHandle as LSA_HANDLE, byval InformationClass as POLICY_DOMAIN_INFORMATION_CLASS, byval Buffer as PVOID) as NTSTATUS
declare function LsaRegisterPolicyChangeNotification(byval InformationClass as POLICY_NOTIFICATION_INFORMATION_CLASS, byval NotificationEventHandle as HANDLE) as NTSTATUS
declare function LsaUnregisterPolicyChangeNotification(byval InformationClass as POLICY_NOTIFICATION_INFORMATION_CLASS, byval NotificationEventHandle as HANDLE) as NTSTATUS
declare function LsaEnumerateTrustedDomains(byval PolicyHandle as LSA_HANDLE, byval EnumerationContext as PLSA_ENUMERATION_HANDLE, byval Buffer as PVOID ptr, byval PreferedMaximumLength as ULONG, byval CountReturned as PULONG) as NTSTATUS
declare function LsaLookupNames(byval PolicyHandle as LSA_HANDLE, byval Count as ULONG, byval Names as PLSA_UNICODE_STRING, byval ReferencedDomains as PLSA_REFERENCED_DOMAIN_LIST ptr, byval Sids as PLSA_TRANSLATED_SID ptr) as NTSTATUS
declare function LsaLookupNames2(byval PolicyHandle as LSA_HANDLE, byval Flags as ULONG, byval Count as ULONG, byval Names as PLSA_UNICODE_STRING, byval ReferencedDomains as PLSA_REFERENCED_DOMAIN_LIST ptr, byval Sids as PLSA_TRANSLATED_SID2 ptr) as NTSTATUS
declare function LsaLookupSids(byval PolicyHandle as LSA_HANDLE, byval Count as ULONG, byval Sids as PSID ptr, byval ReferencedDomains as PLSA_REFERENCED_DOMAIN_LIST ptr, byval Names as PLSA_TRANSLATED_NAME ptr) as NTSTATUS

#define SE_INTERACTIVE_LOGON_NAME __TEXT("SeInteractiveLogonRight")
#define SE_NETWORK_LOGON_NAME __TEXT("SeNetworkLogonRight")
#define SE_BATCH_LOGON_NAME __TEXT("SeBatchLogonRight")
#define SE_SERVICE_LOGON_NAME __TEXT("SeServiceLogonRight")
#define SE_DENY_INTERACTIVE_LOGON_NAME __TEXT("SeDenyInteractiveLogonRight")
#define SE_DENY_NETWORK_LOGON_NAME __TEXT("SeDenyNetworkLogonRight")
#define SE_DENY_BATCH_LOGON_NAME __TEXT("SeDenyBatchLogonRight")
#define SE_DENY_SERVICE_LOGON_NAME __TEXT("SeDenyServiceLogonRight")
#define SE_REMOTE_INTERACTIVE_LOGON_NAME __TEXT("SeRemoteInteractiveLogonRight")
#define SE_DENY_REMOTE_INTERACTIVE_LOGON_NAME __TEXT("SeDenyRemoteInteractiveLogonRight")

declare function LsaEnumerateAccountsWithUserRight(byval PolicyHandle as LSA_HANDLE, byval UserRight as PLSA_UNICODE_STRING, byval Buffer as PVOID ptr, byval CountReturned as PULONG) as NTSTATUS
declare function LsaEnumerateAccountRights(byval PolicyHandle as LSA_HANDLE, byval AccountSid as PSID, byval UserRights as PLSA_UNICODE_STRING ptr, byval CountOfRights as PULONG) as NTSTATUS
declare function LsaAddAccountRights(byval PolicyHandle as LSA_HANDLE, byval AccountSid as PSID, byval UserRights as PLSA_UNICODE_STRING, byval CountOfRights as ULONG) as NTSTATUS
declare function LsaRemoveAccountRights(byval PolicyHandle as LSA_HANDLE, byval AccountSid as PSID, byval AllRights as WINBOOLEAN, byval UserRights as PLSA_UNICODE_STRING, byval CountOfRights as ULONG) as NTSTATUS
declare function LsaOpenTrustedDomainByName(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainName as PLSA_UNICODE_STRING, byval DesiredAccess as ACCESS_MASK, byval TrustedDomainHandle as PLSA_HANDLE) as NTSTATUS
declare function LsaQueryTrustedDomainInfo(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainSid as PSID, byval InformationClass as TRUSTED_INFORMATION_CLASS, byval Buffer as PVOID ptr) as NTSTATUS
declare function LsaSetTrustedDomainInformation(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainSid as PSID, byval InformationClass as TRUSTED_INFORMATION_CLASS, byval Buffer as PVOID) as NTSTATUS
declare function LsaDeleteTrustedDomain(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainSid as PSID) as NTSTATUS
declare function LsaQueryTrustedDomainInfoByName(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainName as PLSA_UNICODE_STRING, byval InformationClass as TRUSTED_INFORMATION_CLASS, byval Buffer as PVOID ptr) as NTSTATUS
declare function LsaSetTrustedDomainInfoByName(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainName as PLSA_UNICODE_STRING, byval InformationClass as TRUSTED_INFORMATION_CLASS, byval Buffer as PVOID) as NTSTATUS
declare function LsaEnumerateTrustedDomainsEx(byval PolicyHandle as LSA_HANDLE, byval EnumerationContext as PLSA_ENUMERATION_HANDLE, byval Buffer as PVOID ptr, byval PreferedMaximumLength as ULONG, byval CountReturned as PULONG) as NTSTATUS
declare function LsaCreateTrustedDomainEx(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainInformation as PTRUSTED_DOMAIN_INFORMATION_EX, byval AuthenticationInformation as PTRUSTED_DOMAIN_AUTH_INFORMATION, byval DesiredAccess as ACCESS_MASK, byval TrustedDomainHandle as PLSA_HANDLE) as NTSTATUS
declare function LsaQueryForestTrustInformation(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainName as PLSA_UNICODE_STRING, byval ForestTrustInfo as PLSA_FOREST_TRUST_INFORMATION ptr) as NTSTATUS
declare function LsaSetForestTrustInformation(byval PolicyHandle as LSA_HANDLE, byval TrustedDomainName as PLSA_UNICODE_STRING, byval ForestTrustInfo as PLSA_FOREST_TRUST_INFORMATION, byval CheckOnly as WINBOOLEAN, byval CollisionInfo as PLSA_FOREST_TRUST_COLLISION_INFORMATION ptr) as NTSTATUS
declare function LsaStorePrivateData(byval PolicyHandle as LSA_HANDLE, byval KeyName as PLSA_UNICODE_STRING, byval PrivateData as PLSA_UNICODE_STRING) as NTSTATUS
declare function LsaRetrievePrivateData(byval PolicyHandle as LSA_HANDLE, byval KeyName as PLSA_UNICODE_STRING, byval PrivateData as PLSA_UNICODE_STRING ptr) as NTSTATUS
declare function LsaNtStatusToWinError(byval Status as NTSTATUS) as ULONG
#define _NTLSA_IFS_

type NEGOTIATE_MESSAGES as long
enum
	NegEnumPackagePrefixes = 0
	NegGetCallerName = 1
	NegCallPackageMax
end enum

const NEGOTIATE_MAX_PREFIX = 32

type _NEGOTIATE_PACKAGE_PREFIX
	PackageId as ULONG_PTR
	PackageDataA as PVOID
	PackageDataW as PVOID
	PrefixLen as ULONG_PTR
	Prefix(0 to 31) as UCHAR
end type

type NEGOTIATE_PACKAGE_PREFIX as _NEGOTIATE_PACKAGE_PREFIX
type PNEGOTIATE_PACKAGE_PREFIX as _NEGOTIATE_PACKAGE_PREFIX ptr

type _NEGOTIATE_PACKAGE_PREFIXES
	MessageType as ULONG
	PrefixCount as ULONG
	Offset as ULONG
	Pad as ULONG
end type

type NEGOTIATE_PACKAGE_PREFIXES as _NEGOTIATE_PACKAGE_PREFIXES
type PNEGOTIATE_PACKAGE_PREFIXES as _NEGOTIATE_PACKAGE_PREFIXES ptr

type _NEGOTIATE_CALLER_NAME_REQUEST
	MessageType as ULONG
	LogonId as LUID
end type

type NEGOTIATE_CALLER_NAME_REQUEST as _NEGOTIATE_CALLER_NAME_REQUEST
type PNEGOTIATE_CALLER_NAME_REQUEST as _NEGOTIATE_CALLER_NAME_REQUEST ptr

type _NEGOTIATE_CALLER_NAME_RESPONSE
	MessageType as ULONG
	CallerName as PWSTR
end type

type NEGOTIATE_CALLER_NAME_RESPONSE as _NEGOTIATE_CALLER_NAME_RESPONSE
type PNEGOTIATE_CALLER_NAME_RESPONSE as _NEGOTIATE_CALLER_NAME_RESPONSE ptr
#ifndef __UNICODE_STRING_DEFINED
#define __UNICODE_STRING_DEFINED
type UNICODE_STRING as LSA_UNICODE_STRING
type PUNICODE_STRING as LSA_UNICODE_STRING ptr
#endif
#ifndef __STRING_DEFINED
#define __STRING_DEFINED
type STRING_ as LSA_STRING
type PSTRING as LSA_STRING ptr
#endif
#define _DOMAIN_PASSWORD_INFORMATION_DEFINED

type _DOMAIN_PASSWORD_INFORMATION
	MinPasswordLength as USHORT
	PasswordHistoryLength as USHORT
	PasswordProperties as ULONG
	MaxPasswordAge as LARGE_INTEGER
	MinPasswordAge as LARGE_INTEGER
end type

type DOMAIN_PASSWORD_INFORMATION as _DOMAIN_PASSWORD_INFORMATION
type PDOMAIN_PASSWORD_INFORMATION as _DOMAIN_PASSWORD_INFORMATION ptr
const DOMAIN_PASSWORD_COMPLEX = &h00000001
const DOMAIN_PASSWORD_NO_ANON_CHANGE = &h00000002
const DOMAIN_PASSWORD_NO_CLEAR_CHANGE = &h00000004
const DOMAIN_LOCKOUT_ADMINS = &h00000008
const DOMAIN_PASSWORD_STORE_CLEARTEXT = &h00000010
const DOMAIN_REFUSE_PASSWORD_CHANGE = &h00000020
#define _PASSWORD_NOTIFICATION_DEFINED
type PSAM_PASSWORD_NOTIFICATION_ROUTINE as function cdecl(byval UserName as PUNICODE_STRING, byval RelativeId as ULONG, byval NewPassword as PUNICODE_STRING) as NTSTATUS
#define SAM_PASSWORD_CHANGE_NOTIFY_ROUTINE "PasswordChangeNotify"
type PSAM_INIT_NOTIFICATION_ROUTINE as function cdecl() as WINBOOLEAN
#define SAM_INIT_NOTIFICATION_ROUTINE "InitializeChangeNotify"
#define SAM_PASSWORD_FILTER_ROUTINE "PasswordFilter"
type PSAM_PASSWORD_FILTER_ROUTINE as function cdecl(byval AccountName as PUNICODE_STRING, byval FullName as PUNICODE_STRING, byval Password as PUNICODE_STRING, byval SetOperation as WINBOOLEAN) as WINBOOLEAN
#define MSV1_0_PACKAGE_NAME "MICROSOFT_AUTHENTICATION_PACKAGE_V1_0"
#define MSV1_0_PACKAGE_NAMEW wstr("MICROSOFT_AUTHENTICATION_PACKAGE_V1_0")
#define MSV1_0_PACKAGE_NAMEW_LENGTH (sizeof(MSV1_0_PACKAGE_NAMEW) - sizeof(WCHAR))
#define MSV1_0_SUBAUTHENTICATION_KEY !"SYSTEM\\CurrentControlSet\\Control\\Lsa\\MSV1_0"
#define MSV1_0_SUBAUTHENTICATION_VALUE "Auth"

type _MSV1_0_LOGON_SUBMIT_TYPE as long
enum
	MsV1_0InteractiveLogon = 2
	MsV1_0Lm20Logon
	MsV1_0NetworkLogon
	MsV1_0SubAuthLogon
	MsV1_0WorkstationUnlockLogon = 7
end enum

type MSV1_0_LOGON_SUBMIT_TYPE as _MSV1_0_LOGON_SUBMIT_TYPE
type PMSV1_0_LOGON_SUBMIT_TYPE as _MSV1_0_LOGON_SUBMIT_TYPE ptr

type _MSV1_0_PROFILE_BUFFER_TYPE as long
enum
	MsV1_0InteractiveProfile = 2
	MsV1_0Lm20LogonProfile
	MsV1_0SmartCardProfile
end enum

type MSV1_0_PROFILE_BUFFER_TYPE as _MSV1_0_PROFILE_BUFFER_TYPE
type PMSV1_0_PROFILE_BUFFER_TYPE as _MSV1_0_PROFILE_BUFFER_TYPE ptr

type _MSV1_0_INTERACTIVE_LOGON
	MessageType as MSV1_0_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Password as UNICODE_STRING
end type

type MSV1_0_INTERACTIVE_LOGON as _MSV1_0_INTERACTIVE_LOGON
type PMSV1_0_INTERACTIVE_LOGON as _MSV1_0_INTERACTIVE_LOGON ptr

type _MSV1_0_INTERACTIVE_PROFILE
	MessageType as MSV1_0_PROFILE_BUFFER_TYPE
	LogonCount as USHORT
	BadPasswordCount as USHORT
	LogonTime as LARGE_INTEGER
	LogoffTime as LARGE_INTEGER
	KickOffTime as LARGE_INTEGER
	PasswordLastSet as LARGE_INTEGER
	PasswordCanChange as LARGE_INTEGER
	PasswordMustChange as LARGE_INTEGER
	LogonScript as UNICODE_STRING
	HomeDirectory as UNICODE_STRING
	FullName as UNICODE_STRING
	ProfilePath as UNICODE_STRING
	HomeDirectoryDrive as UNICODE_STRING
	LogonServer as UNICODE_STRING
	UserFlags as ULONG
end type

type MSV1_0_INTERACTIVE_PROFILE as _MSV1_0_INTERACTIVE_PROFILE
type PMSV1_0_INTERACTIVE_PROFILE as _MSV1_0_INTERACTIVE_PROFILE ptr
const MSV1_0_CHALLENGE_LENGTH = 8
const MSV1_0_USER_SESSION_KEY_LENGTH = 16
const MSV1_0_LANMAN_SESSION_KEY_LENGTH = 8
const MSV1_0_CLEARTEXT_PASSWORD_ALLOWED = &h02
const MSV1_0_UPDATE_LOGON_STATISTICS = &h04
const MSV1_0_RETURN_USER_PARAMETERS = &h08
const MSV1_0_DONT_TRY_GUEST_ACCOUNT = &h10
const MSV1_0_ALLOW_SERVER_TRUST_ACCOUNT = &h20
const MSV1_0_RETURN_PASSWORD_EXPIRY = &h40
const MSV1_0_USE_CLIENT_CHALLENGE = &h80
const MSV1_0_TRY_GUEST_ACCOUNT_ONLY = &h100
const MSV1_0_RETURN_PROFILE_PATH = &h200
const MSV1_0_TRY_SPECIFIED_DOMAIN_ONLY = &h400
const MSV1_0_ALLOW_WORKSTATION_TRUST_ACCOUNT = &h800
const MSV1_0_DISABLE_PERSONAL_FALLBACK = &h00001000
const MSV1_0_ALLOW_FORCE_GUEST = &h00002000
const MSV1_0_CLEARTEXT_PASSWORD_SUPPLIED = &h00004000
const MSV1_0_USE_DOMAIN_FOR_ROUTING_ONLY = &h00008000
const MSV1_0_SUBAUTHENTICATION_DLL_EX = &h00100000
const MSV1_0_ALLOW_MSVCHAPV2 = &h00010000
const MSV1_0_SUBAUTHENTICATION_DLL = &hFF000000
const MSV1_0_SUBAUTHENTICATION_DLL_SHIFT = 24
const MSV1_0_MNS_LOGON = &h01000000
const MSV1_0_SUBAUTHENTICATION_DLL_RAS = 2
const MSV1_0_SUBAUTHENTICATION_DLL_IIS = 132

type _MSV1_0_LM20_LOGON
	MessageType as MSV1_0_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Workstation as UNICODE_STRING
	ChallengeToClient(0 to 7) as UCHAR
	CaseSensitiveChallengeResponse as STRING_
	CaseInsensitiveChallengeResponse as STRING_
	ParameterControl as ULONG
end type

type MSV1_0_LM20_LOGON as _MSV1_0_LM20_LOGON
type PMSV1_0_LM20_LOGON as _MSV1_0_LM20_LOGON ptr

type _MSV1_0_SUBAUTH_LOGON
	MessageType as MSV1_0_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Workstation as UNICODE_STRING
	ChallengeToClient(0 to 7) as UCHAR
	AuthenticationInfo1 as STRING_
	AuthenticationInfo2 as STRING_
	ParameterControl as ULONG
	SubAuthPackageId as ULONG
end type

type MSV1_0_SUBAUTH_LOGON as _MSV1_0_SUBAUTH_LOGON
type PMSV1_0_SUBAUTH_LOGON as _MSV1_0_SUBAUTH_LOGON ptr
const LOGON_GUEST = &h01
const LOGON_NOENCRYPTION = &h02
const LOGON_CACHED_ACCOUNT = &h04
const LOGON_USED_LM_PASSWORD = &h08
const LOGON_EXTRA_SIDS = &h20
const LOGON_SUBAUTH_SESSION_KEY = &h40
const LOGON_SERVER_TRUST_ACCOUNT = &h80
const LOGON_NTLMV2_ENABLED = &h100
const LOGON_RESOURCE_GROUPS = &h200
const LOGON_PROFILE_PATH_RETURNED = &h400
const MSV1_0_SUBAUTHENTICATION_FLAGS = &hFF000000
const LOGON_GRACE_LOGON = &h01000000

type _MSV1_0_LM20_LOGON_PROFILE
	MessageType as MSV1_0_PROFILE_BUFFER_TYPE
	KickOffTime as LARGE_INTEGER
	LogoffTime as LARGE_INTEGER
	UserFlags as ULONG
	UserSessionKey(0 to 15) as UCHAR
	LogonDomainName as UNICODE_STRING
	LanmanSessionKey(0 to 7) as UCHAR
	LogonServer as UNICODE_STRING
	UserParameters as UNICODE_STRING
end type

type MSV1_0_LM20_LOGON_PROFILE as _MSV1_0_LM20_LOGON_PROFILE
type PMSV1_0_LM20_LOGON_PROFILE as _MSV1_0_LM20_LOGON_PROFILE ptr
const MSV1_0_OWF_PASSWORD_LENGTH = 16
const MSV1_0_CRED_LM_PRESENT = &h1
const MSV1_0_CRED_NT_PRESENT = &h2
const MSV1_0_CRED_VERSION = 0

type _MSV1_0_SUPPLEMENTAL_CREDENTIAL
	Version as ULONG
	Flags as ULONG
	LmPassword(0 to 15) as UCHAR
	NtPassword(0 to 15) as UCHAR
end type

type MSV1_0_SUPPLEMENTAL_CREDENTIAL as _MSV1_0_SUPPLEMENTAL_CREDENTIAL
type PMSV1_0_SUPPLEMENTAL_CREDENTIAL as _MSV1_0_SUPPLEMENTAL_CREDENTIAL ptr
const MSV1_0_NTLM3_RESPONSE_LENGTH = 16
const MSV1_0_NTLM3_OWF_LENGTH = 16
const MSV1_0_MAX_NTLM3_LIFE = 129600
const MSV1_0_MAX_AVL_SIZE = 64000
const MSV1_0_AV_FLAG_FORCE_GUEST = &h00000001

type _MSV1_0_NTLM3_RESPONSE
	Response(0 to 15) as UCHAR
	RespType as UCHAR
	HiRespType as UCHAR
	Flags as USHORT
	MsgWord as ULONG
	TimeStamp as ULONGLONG
	ChallengeFromClient(0 to 7) as UCHAR
	AvPairsOff as ULONG
	Buffer as zstring * 1
end type

type MSV1_0_NTLM3_RESPONSE as _MSV1_0_NTLM3_RESPONSE
type PMSV1_0_NTLM3_RESPONSE as _MSV1_0_NTLM3_RESPONSE ptr
#define MSV1_0_NTLM3_INPUT_LENGTH (sizeof(MSV1_0_NTLM3_RESPONSE) - MSV1_0_NTLM3_RESPONSE_LENGTH)
#define MSV1_0_NTLM3_MIN_NT_RESPONSE_LENGTH RTL_SIZEOF_THROUGH_FIELD(MSV1_0_NTLM3_RESPONSE, AvPairsOff)

type MSV1_0_AVID as long
enum
	MsvAvEOL
	MsvAvNbComputerName
	MsvAvNbDomainName
	MsvAvDnsComputerName
	MsvAvDnsDomainName
	MsvAvDnsTreeName
	MsvAvFlags
end enum

type _MSV1_0_AV_PAIR
	AvId as USHORT
	AvLen as USHORT
end type

type MSV1_0_AV_PAIR as _MSV1_0_AV_PAIR
type PMSV1_0_AV_PAIR as _MSV1_0_AV_PAIR ptr

type _MSV1_0_PROTOCOL_MESSAGE_TYPE as long
enum
	MsV1_0Lm20ChallengeRequest = 0
	MsV1_0Lm20GetChallengeResponse
	MsV1_0EnumerateUsers
	MsV1_0GetUserInfo
	MsV1_0ReLogonUsers
	MsV1_0ChangePassword
	MsV1_0ChangeCachedPassword
	MsV1_0GenericPassthrough
	MsV1_0CacheLogon
	MsV1_0SubAuth
	MsV1_0DeriveCredential
	MsV1_0CacheLookup
	MsV1_0SetProcessOption
end enum

type MSV1_0_PROTOCOL_MESSAGE_TYPE as _MSV1_0_PROTOCOL_MESSAGE_TYPE
type PMSV1_0_PROTOCOL_MESSAGE_TYPE as _MSV1_0_PROTOCOL_MESSAGE_TYPE ptr

type _MSV1_0_CHANGEPASSWORD_REQUEST
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	DomainName as UNICODE_STRING
	AccountName as UNICODE_STRING
	OldPassword as UNICODE_STRING
	NewPassword as UNICODE_STRING
	Impersonating as WINBOOLEAN
end type

type MSV1_0_CHANGEPASSWORD_REQUEST as _MSV1_0_CHANGEPASSWORD_REQUEST
type PMSV1_0_CHANGEPASSWORD_REQUEST as _MSV1_0_CHANGEPASSWORD_REQUEST ptr

type _MSV1_0_CHANGEPASSWORD_RESPONSE
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	PasswordInfoValid as WINBOOLEAN
	DomainPasswordInfo as DOMAIN_PASSWORD_INFORMATION
end type

type MSV1_0_CHANGEPASSWORD_RESPONSE as _MSV1_0_CHANGEPASSWORD_RESPONSE
type PMSV1_0_CHANGEPASSWORD_RESPONSE as _MSV1_0_CHANGEPASSWORD_RESPONSE ptr

type _MSV1_0_PASSTHROUGH_REQUEST
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	DomainName as UNICODE_STRING
	PackageName as UNICODE_STRING
	DataLength as ULONG
	LogonData as PUCHAR
	Pad as ULONG
end type

type MSV1_0_PASSTHROUGH_REQUEST as _MSV1_0_PASSTHROUGH_REQUEST
type PMSV1_0_PASSTHROUGH_REQUEST as _MSV1_0_PASSTHROUGH_REQUEST ptr

type _MSV1_0_PASSTHROUGH_RESPONSE
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	Pad as ULONG
	DataLength as ULONG
	ValidationData as PUCHAR
end type

type MSV1_0_PASSTHROUGH_RESPONSE as _MSV1_0_PASSTHROUGH_RESPONSE
type PMSV1_0_PASSTHROUGH_RESPONSE as _MSV1_0_PASSTHROUGH_RESPONSE ptr

type _MSV1_0_SUBAUTH_REQUEST
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	SubAuthPackageId as ULONG
	SubAuthInfoLength as ULONG
	SubAuthSubmitBuffer as PUCHAR
end type

type MSV1_0_SUBAUTH_REQUEST as _MSV1_0_SUBAUTH_REQUEST
type PMSV1_0_SUBAUTH_REQUEST as _MSV1_0_SUBAUTH_REQUEST ptr

type _MSV1_0_SUBAUTH_RESPONSE
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	SubAuthInfoLength as ULONG
	SubAuthReturnBuffer as PUCHAR
end type

type MSV1_0_SUBAUTH_RESPONSE as _MSV1_0_SUBAUTH_RESPONSE
type PMSV1_0_SUBAUTH_RESPONSE as _MSV1_0_SUBAUTH_RESPONSE ptr
declare function SystemFunction036 cdecl(byval RandomBuffer as PVOID, byval RandomBufferLength as ULONG) as WINBOOLEAN
declare function RtlGenRandom cdecl alias "SystemFunction036"(byval RandomBuffer as PVOID, byval RandomBufferLength as ULONG) as WINBOOLEAN
const RTL_ENCRYPT_MEMORY_SIZE = 8
const RTL_ENCRYPT_OPTION_CROSS_PROCESS = &h01
const RTL_ENCRYPT_OPTION_SAME_LOGON = &h02

declare function SystemFunction040 cdecl(byval Memory as PVOID, byval MemorySize as ULONG, byval OptionFlags as ULONG) as NTSTATUS
declare function RtlEncryptMemory cdecl alias "SystemFunction040"(byval Memory as PVOID, byval MemorySize as ULONG, byval OptionFlags as ULONG) as NTSTATUS
declare function SystemFunction041 cdecl(byval Memory as PVOID, byval MemorySize as ULONG, byval OptionFlags as ULONG) as NTSTATUS
declare function RtlDecryptMemory cdecl alias "SystemFunction041"(byval Memory as PVOID, byval MemorySize as ULONG, byval OptionFlags as ULONG) as NTSTATUS

const KERBEROS_VERSION = 5
const KERBEROS_REVISION = 6
const KERB_ETYPE_NULL = 0
const KERB_ETYPE_DES_CBC_CRC = 1
const KERB_ETYPE_DES_CBC_MD4 = 2
const KERB_ETYPE_DES_CBC_MD5 = 3
const KERB_ETYPE_RC4_MD4 = -128
const KERB_ETYPE_RC4_PLAIN2 = -129
const KERB_ETYPE_RC4_LM = -130
const KERB_ETYPE_RC4_SHA = -131
const KERB_ETYPE_DES_PLAIN = -132
const KERB_ETYPE_RC4_HMAC_OLD = -133
const KERB_ETYPE_RC4_PLAIN_OLD = -134
const KERB_ETYPE_RC4_HMAC_OLD_EXP = -135
const KERB_ETYPE_RC4_PLAIN_OLD_EXP = -136
const KERB_ETYPE_RC4_PLAIN = -140
const KERB_ETYPE_RC4_PLAIN_EXP = -141
const KERB_ETYPE_DSA_SHA1_CMS = 9
const KERB_ETYPE_RSA_MD5_CMS = 10
const KERB_ETYPE_RSA_SHA1_CMS = 11
const KERB_ETYPE_RC2_CBC_ENV = 12
const KERB_ETYPE_RSA_ENV = 13
const KERB_ETYPE_RSA_ES_OEAP_ENV = 14
const KERB_ETYPE_DES_EDE3_CBC_ENV = 15
const KERB_ETYPE_DSA_SIGN = 8
const KERB_ETYPE_RSA_PRIV = 9
const KERB_ETYPE_RSA_PUB = 10
const KERB_ETYPE_RSA_PUB_MD5 = 11
const KERB_ETYPE_RSA_PUB_SHA1 = 12
const KERB_ETYPE_PKCS7_PUB = 13
const KERB_ETYPE_DES3_CBC_MD5 = 5
const KERB_ETYPE_DES3_CBC_SHA1 = 7
const KERB_ETYPE_DES3_CBC_SHA1_KD = 16
const KERB_ETYPE_DES_CBC_MD5_NT = 20
const KERB_ETYPE_RC4_HMAC_NT = 23
const KERB_ETYPE_RC4_HMAC_NT_EXP = 24
const KERB_CHECKSUM_NONE = 0
const KERB_CHECKSUM_CRC32 = 1
const KERB_CHECKSUM_MD4 = 2
const KERB_CHECKSUM_KRB_DES_MAC = 4
const KERB_CHECKSUM_KRB_DES_MAC_K = 5
const KERB_CHECKSUM_MD5 = 7
const KERB_CHECKSUM_MD5_DES = 8
const KERB_CHECKSUM_LM = -130
const KERB_CHECKSUM_SHA1 = -131
const KERB_CHECKSUM_REAL_CRC32 = -132
const KERB_CHECKSUM_DES_MAC = -133
const KERB_CHECKSUM_DES_MAC_MD5 = -134
const KERB_CHECKSUM_MD25 = -135
const KERB_CHECKSUM_RC4_MD5 = -136
const KERB_CHECKSUM_MD5_HMAC = -137
const KERB_CHECKSUM_HMAC_MD5 = -138
const AUTH_REQ_ALLOW_FORWARDABLE = &h00000001
const AUTH_REQ_ALLOW_PROXIABLE = &h00000002
const AUTH_REQ_ALLOW_POSTDATE = &h00000004
const AUTH_REQ_ALLOW_RENEWABLE = &h00000008
const AUTH_REQ_ALLOW_NOADDRESS = &h00000010
const AUTH_REQ_ALLOW_ENC_TKT_IN_SKEY = &h00000020
const AUTH_REQ_ALLOW_VALIDATE = &h00000040
const AUTH_REQ_VALIDATE_CLIENT = &h00000080
const AUTH_REQ_OK_AS_DELEGATE = &h00000100
const AUTH_REQ_PREAUTH_REQUIRED = &h00000200
const AUTH_REQ_TRANSITIVE_TRUST = &h00000400
const AUTH_REQ_ALLOW_S4U_DELEGATE = &h00000800
const AUTH_REQ_PER_USER_FLAGS = (((AUTH_REQ_ALLOW_FORWARDABLE or AUTH_REQ_ALLOW_PROXIABLE) or AUTH_REQ_ALLOW_POSTDATE) or AUTH_REQ_ALLOW_RENEWABLE) or AUTH_REQ_ALLOW_VALIDATE
const KERB_TICKET_FLAGS_reserved = &h80000000
const KERB_TICKET_FLAGS_forwardable = &h40000000
const KERB_TICKET_FLAGS_forwarded = &h20000000
const KERB_TICKET_FLAGS_proxiable = &h10000000
const KERB_TICKET_FLAGS_proxy = &h08000000
const KERB_TICKET_FLAGS_may_postdate = &h04000000
const KERB_TICKET_FLAGS_postdated = &h02000000
const KERB_TICKET_FLAGS_invalid = &h01000000
const KERB_TICKET_FLAGS_renewable = &h00800000
const KERB_TICKET_FLAGS_initial = &h00400000
const KERB_TICKET_FLAGS_pre_authent = &h00200000
const KERB_TICKET_FLAGS_hw_authent = &h00100000
const KERB_TICKET_FLAGS_ok_as_delegate = &h00040000
const KERB_TICKET_FLAGS_name_canonicalize = &h00010000
const KERB_TICKET_FLAGS_reserved1 = &h00000001
const KRB_NT_UNKNOWN = 0
const KRB_NT_PRINCIPAL = 1
const KRB_NT_PRINCIPAL_AND_ID = -131
const KRB_NT_SRV_INST = 2
const KRB_NT_SRV_INST_AND_ID = -132
const KRB_NT_SRV_HST = 3
const KRB_NT_SRV_XHST = 4
const KRB_NT_UID = 5
const KRB_NT_ENTERPRISE_PRINCIPAL = 10
const KRB_NT_ENT_PRINCIPAL_AND_ID = -130
const KRB_NT_MS_PRINCIPAL = -128
const KRB_NT_MS_PRINCIPAL_AND_ID = -129
#define KERB_IS_MS_PRINCIPAL(_x_) (((_x_) <= KRB_NT_MS_PRINCIPAL) orelse ((_x_) >= KRB_NT_ENTERPRISE_PRINCIPAL))
const KERB_WRAP_NO_ENCRYPT = &h80000001

type _KERB_LOGON_SUBMIT_TYPE as long
enum
	KerbInteractiveLogon = 2
	KerbSmartCardLogon = 6
	KerbWorkstationUnlockLogon = 7
	KerbSmartCardUnlockLogon = 8
	KerbProxyLogon = 9
	KerbTicketLogon = 10
	KerbTicketUnlockLogon = 11
	KerbS4ULogon = 12

	#if _WIN32_WINNT >= &h0600
		KerbCertificateLogon = 13
		KerbCertificateS4ULogon = 14
		KerbCertificateUnlockLogon = 15
	#endif
end enum

type KERB_LOGON_SUBMIT_TYPE as _KERB_LOGON_SUBMIT_TYPE
type PKERB_LOGON_SUBMIT_TYPE as _KERB_LOGON_SUBMIT_TYPE ptr

type _KERB_INTERACTIVE_LOGON
	MessageType as KERB_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Password as UNICODE_STRING
end type

type KERB_INTERACTIVE_LOGON as _KERB_INTERACTIVE_LOGON
type PKERB_INTERACTIVE_LOGON as _KERB_INTERACTIVE_LOGON ptr

type _KERB_INTERACTIVE_UNLOCK_LOGON
	Logon as KERB_INTERACTIVE_LOGON
	LogonId as LUID
end type

type KERB_INTERACTIVE_UNLOCK_LOGON as _KERB_INTERACTIVE_UNLOCK_LOGON
type PKERB_INTERACTIVE_UNLOCK_LOGON as _KERB_INTERACTIVE_UNLOCK_LOGON ptr

type _KERB_SMART_CARD_LOGON
	MessageType as KERB_LOGON_SUBMIT_TYPE
	Pin as UNICODE_STRING
	CspDataLength as ULONG
	CspData as PUCHAR
end type

type KERB_SMART_CARD_LOGON as _KERB_SMART_CARD_LOGON
type PKERB_SMART_CARD_LOGON as _KERB_SMART_CARD_LOGON ptr

type _KERB_SMART_CARD_UNLOCK_LOGON
	Logon as KERB_SMART_CARD_LOGON
	LogonId as LUID
end type

type KERB_SMART_CARD_UNLOCK_LOGON as _KERB_SMART_CARD_UNLOCK_LOGON
type PKERB_SMART_CARD_UNLOCK_LOGON as _KERB_SMART_CARD_UNLOCK_LOGON ptr

type _KERB_TICKET_LOGON
	MessageType as KERB_LOGON_SUBMIT_TYPE
	Flags as ULONG
	ServiceTicketLength as ULONG
	TicketGrantingTicketLength as ULONG
	ServiceTicket as PUCHAR
	TicketGrantingTicket as PUCHAR
end type

type KERB_TICKET_LOGON as _KERB_TICKET_LOGON
type PKERB_TICKET_LOGON as _KERB_TICKET_LOGON ptr
const KERB_LOGON_FLAG_ALLOW_EXPIRED_TICKET = &h1

type _KERB_TICKET_UNLOCK_LOGON
	Logon as KERB_TICKET_LOGON
	LogonId as LUID
end type

type KERB_TICKET_UNLOCK_LOGON as _KERB_TICKET_UNLOCK_LOGON
type PKERB_TICKET_UNLOCK_LOGON as _KERB_TICKET_UNLOCK_LOGON ptr

type _KERB_S4U_LOGON
	MessageType as KERB_LOGON_SUBMIT_TYPE
	Flags as ULONG
	ClientUpn as UNICODE_STRING
	ClientRealm as UNICODE_STRING
end type

type KERB_S4U_LOGON as _KERB_S4U_LOGON
type PKERB_S4U_LOGON as _KERB_S4U_LOGON ptr

type _KERB_PROFILE_BUFFER_TYPE as long
enum
	KerbInteractiveProfile = 2
	KerbSmartCardProfile = 4
	KerbTicketProfile = 6
end enum

type KERB_PROFILE_BUFFER_TYPE as _KERB_PROFILE_BUFFER_TYPE
type PKERB_PROFILE_BUFFER_TYPE as _KERB_PROFILE_BUFFER_TYPE ptr

type _KERB_INTERACTIVE_PROFILE
	MessageType as KERB_PROFILE_BUFFER_TYPE
	LogonCount as USHORT
	BadPasswordCount as USHORT
	LogonTime as LARGE_INTEGER
	LogoffTime as LARGE_INTEGER
	KickOffTime as LARGE_INTEGER
	PasswordLastSet as LARGE_INTEGER
	PasswordCanChange as LARGE_INTEGER
	PasswordMustChange as LARGE_INTEGER
	LogonScript as UNICODE_STRING
	HomeDirectory as UNICODE_STRING
	FullName as UNICODE_STRING
	ProfilePath as UNICODE_STRING
	HomeDirectoryDrive as UNICODE_STRING
	LogonServer as UNICODE_STRING
	UserFlags as ULONG
end type

type KERB_INTERACTIVE_PROFILE as _KERB_INTERACTIVE_PROFILE
type PKERB_INTERACTIVE_PROFILE as _KERB_INTERACTIVE_PROFILE ptr

type _KERB_SMART_CARD_PROFILE
	Profile as KERB_INTERACTIVE_PROFILE
	CertificateSize as ULONG
	CertificateData as PUCHAR
end type

type KERB_SMART_CARD_PROFILE as _KERB_SMART_CARD_PROFILE
type PKERB_SMART_CARD_PROFILE as _KERB_SMART_CARD_PROFILE ptr

type KERB_CRYPTO_KEY
	KeyType as LONG
	Length as ULONG
	Value as PUCHAR
end type

type PKERB_CRYPTO_KEY as KERB_CRYPTO_KEY ptr

type _KERB_TICKET_PROFILE
	Profile as KERB_INTERACTIVE_PROFILE
	SessionKey as KERB_CRYPTO_KEY
end type

type KERB_TICKET_PROFILE as _KERB_TICKET_PROFILE
type PKERB_TICKET_PROFILE as _KERB_TICKET_PROFILE ptr

type _KERB_PROTOCOL_MESSAGE_TYPE as long
enum
	KerbDebugRequestMessage = 0
	KerbQueryTicketCacheMessage
	KerbChangeMachinePasswordMessage
	KerbVerifyPacMessage
	KerbRetrieveTicketMessage
	KerbUpdateAddressesMessage
	KerbPurgeTicketCacheMessage
	KerbChangePasswordMessage
	KerbRetrieveEncodedTicketMessage
	KerbDecryptDataMessage
	KerbAddBindingCacheEntryMessage
	KerbSetPasswordMessage
	KerbSetPasswordExMessage
	KerbVerifyCredentialsMessage
	KerbQueryTicketCacheExMessage
	KerbPurgeTicketCacheExMessage
	KerbRefreshSmartcardCredentialsMessage
	KerbAddExtraCredentialsMessage
	KerbQuerySupplementalCredentialsMessage
	KerbTransferCredentialsMessage
	KerbQueryTicketCacheEx2Message
end enum

type KERB_PROTOCOL_MESSAGE_TYPE as _KERB_PROTOCOL_MESSAGE_TYPE
type PKERB_PROTOCOL_MESSAGE_TYPE as _KERB_PROTOCOL_MESSAGE_TYPE ptr

type _KERB_QUERY_TKT_CACHE_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
end type

type KERB_QUERY_TKT_CACHE_REQUEST as _KERB_QUERY_TKT_CACHE_REQUEST
type PKERB_QUERY_TKT_CACHE_REQUEST as _KERB_QUERY_TKT_CACHE_REQUEST ptr

type _KERB_TICKET_CACHE_INFO
	ServerName as UNICODE_STRING
	RealmName as UNICODE_STRING
	StartTime as LARGE_INTEGER
	EndTime as LARGE_INTEGER
	RenewTime as LARGE_INTEGER
	EncryptionType as LONG
	TicketFlags as ULONG
end type

type KERB_TICKET_CACHE_INFO as _KERB_TICKET_CACHE_INFO
type PKERB_TICKET_CACHE_INFO as _KERB_TICKET_CACHE_INFO ptr

type _KERB_TICKET_CACHE_INFO_EX
	ClientName as UNICODE_STRING
	ClientRealm as UNICODE_STRING
	ServerName as UNICODE_STRING
	ServerRealm as UNICODE_STRING
	StartTime as LARGE_INTEGER
	EndTime as LARGE_INTEGER
	RenewTime as LARGE_INTEGER
	EncryptionType as LONG
	TicketFlags as ULONG
end type

type KERB_TICKET_CACHE_INFO_EX as _KERB_TICKET_CACHE_INFO_EX
type PKERB_TICKET_CACHE_INFO_EX as _KERB_TICKET_CACHE_INFO_EX ptr

type _KERB_TICKET_CACHE_INFO_EX2
	ClientName as UNICODE_STRING
	ClientRealm as UNICODE_STRING
	ServerName as UNICODE_STRING
	ServerRealm as UNICODE_STRING
	StartTime as LARGE_INTEGER
	EndTime as LARGE_INTEGER
	RenewTime as LARGE_INTEGER
	EncryptionType as LONG
	TicketFlags as ULONG
	SessionKeyType as ULONG
end type

type KERB_TICKET_CACHE_INFO_EX2 as _KERB_TICKET_CACHE_INFO_EX2
type PKERB_TICKET_CACHE_INFO_EX2 as _KERB_TICKET_CACHE_INFO_EX2 ptr

type _KERB_QUERY_TKT_CACHE_RESPONSE
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	CountOfTickets as ULONG
	Tickets(0 to 0) as KERB_TICKET_CACHE_INFO
end type

type KERB_QUERY_TKT_CACHE_RESPONSE as _KERB_QUERY_TKT_CACHE_RESPONSE
type PKERB_QUERY_TKT_CACHE_RESPONSE as _KERB_QUERY_TKT_CACHE_RESPONSE ptr

type _KERB_QUERY_TKT_CACHE_EX_RESPONSE
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	CountOfTickets as ULONG
	Tickets(0 to 0) as KERB_TICKET_CACHE_INFO_EX
end type

type KERB_QUERY_TKT_CACHE_EX_RESPONSE as _KERB_QUERY_TKT_CACHE_EX_RESPONSE
type PKERB_QUERY_TKT_CACHE_EX_RESPONSE as _KERB_QUERY_TKT_CACHE_EX_RESPONSE ptr

type _KERB_QUERY_TKT_CACHE_EX2_RESPONSE
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	CountOfTickets as ULONG
	Tickets(0 to 0) as KERB_TICKET_CACHE_INFO_EX2
end type

type KERB_QUERY_TKT_CACHE_EX2_RESPONSE as _KERB_QUERY_TKT_CACHE_EX2_RESPONSE
type PKERB_QUERY_TKT_CACHE_EX2_RESPONSE as _KERB_QUERY_TKT_CACHE_EX2_RESPONSE ptr

type _SecHandle
	dwLower as ULONG_PTR
	dwUpper as ULONG_PTR
end type

type SecHandle as _SecHandle
type PSecHandle as _SecHandle ptr
#define __SECHANDLE_DEFINED__
const KERB_USE_DEFAULT_TICKET_FLAGS = &h0
const KERB_RETRIEVE_TICKET_DEFAULT = &h0
const KERB_RETRIEVE_TICKET_DONT_USE_CACHE = &h1
const KERB_RETRIEVE_TICKET_USE_CACHE_ONLY = &h2
const KERB_RETRIEVE_TICKET_USE_CREDHANDLE = &h4
const KERB_RETRIEVE_TICKET_AS_KERB_CRED = &h8
const KERB_RETRIEVE_TICKET_WITH_SEC_CRED = &h10
const KERB_RETRIEVE_TICKET_CACHE_TICKET = &h20
const KERB_ETYPE_DEFAULT = &h0

type _KERB_AUTH_DATA
	as ULONG Type
	Length as ULONG
	Data as PUCHAR
end type

type KERB_AUTH_DATA as _KERB_AUTH_DATA
type PKERB_AUTH_DATA as _KERB_AUTH_DATA ptr

type _KERB_NET_ADDRESS
	Family as ULONG
	Length as ULONG
	Address as PCHAR
end type

type KERB_NET_ADDRESS as _KERB_NET_ADDRESS
type PKERB_NET_ADDRESS as _KERB_NET_ADDRESS ptr

type _KERB_NET_ADDRESSES
	Number as ULONG
	Addresses(0 to 0) as KERB_NET_ADDRESS
end type

type KERB_NET_ADDRESSES as _KERB_NET_ADDRESSES
type PKERB_NET_ADDRESSES as _KERB_NET_ADDRESSES ptr

type _KERB_EXTERNAL_NAME
	NameType as SHORT
	NameCount as USHORT
	Names(0 to 0) as UNICODE_STRING
end type

type KERB_EXTERNAL_NAME as _KERB_EXTERNAL_NAME
type PKERB_EXTERNAL_NAME as _KERB_EXTERNAL_NAME ptr

type _KERB_EXTERNAL_TICKET
	ServiceName as PKERB_EXTERNAL_NAME
	TargetName as PKERB_EXTERNAL_NAME
	ClientName as PKERB_EXTERNAL_NAME
	DomainName as UNICODE_STRING
	TargetDomainName as UNICODE_STRING
	AltTargetDomainName as UNICODE_STRING
	SessionKey as KERB_CRYPTO_KEY
	TicketFlags as ULONG
	Flags as ULONG
	KeyExpirationTime as LARGE_INTEGER
	StartTime as LARGE_INTEGER
	EndTime as LARGE_INTEGER
	RenewUntil as LARGE_INTEGER
	TimeSkew as LARGE_INTEGER
	EncodedTicketSize as ULONG
	EncodedTicket as PUCHAR
end type

type KERB_EXTERNAL_TICKET as _KERB_EXTERNAL_TICKET
type PKERB_EXTERNAL_TICKET as _KERB_EXTERNAL_TICKET ptr

type _KERB_RETRIEVE_TKT_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	TargetName as UNICODE_STRING
	TicketFlags as ULONG
	CacheOptions as ULONG
	EncryptionType as LONG
	CredentialsHandle as SecHandle
end type

type KERB_RETRIEVE_TKT_REQUEST as _KERB_RETRIEVE_TKT_REQUEST
type PKERB_RETRIEVE_TKT_REQUEST as _KERB_RETRIEVE_TKT_REQUEST ptr

type _KERB_RETRIEVE_TKT_RESPONSE
	Ticket as KERB_EXTERNAL_TICKET
end type

type KERB_RETRIEVE_TKT_RESPONSE as _KERB_RETRIEVE_TKT_RESPONSE
type PKERB_RETRIEVE_TKT_RESPONSE as _KERB_RETRIEVE_TKT_RESPONSE ptr

type _KERB_PURGE_TKT_CACHE_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	ServerName as UNICODE_STRING
	RealmName as UNICODE_STRING
end type

type KERB_PURGE_TKT_CACHE_REQUEST as _KERB_PURGE_TKT_CACHE_REQUEST
type PKERB_PURGE_TKT_CACHE_REQUEST as _KERB_PURGE_TKT_CACHE_REQUEST ptr
const KERB_PURGE_ALL_TICKETS = 1

type _KERB_PURGE_TKT_CACHE_EX_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	Flags as ULONG
	TicketTemplate as KERB_TICKET_CACHE_INFO_EX
end type

type KERB_PURGE_TKT_CACHE_EX_REQUEST as _KERB_PURGE_TKT_CACHE_EX_REQUEST
type PKERB_PURGE_TKT_CACHE_EX_REQUEST as _KERB_PURGE_TKT_CACHE_EX_REQUEST ptr

type _KERB_CHANGEPASSWORD_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	DomainName as UNICODE_STRING
	AccountName as UNICODE_STRING
	OldPassword as UNICODE_STRING
	NewPassword as UNICODE_STRING
	Impersonating as WINBOOLEAN
end type

type KERB_CHANGEPASSWORD_REQUEST as _KERB_CHANGEPASSWORD_REQUEST
type PKERB_CHANGEPASSWORD_REQUEST as _KERB_CHANGEPASSWORD_REQUEST ptr

type _KERB_SETPASSWORD_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	CredentialsHandle as SecHandle
	Flags as ULONG
	DomainName as UNICODE_STRING
	AccountName as UNICODE_STRING
	Password as UNICODE_STRING
end type

type KERB_SETPASSWORD_REQUEST as _KERB_SETPASSWORD_REQUEST
type PKERB_SETPASSWORD_REQUEST as _KERB_SETPASSWORD_REQUEST ptr

type _KERB_SETPASSWORD_EX_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	CredentialsHandle as SecHandle
	Flags as ULONG
	AccountRealm as UNICODE_STRING
	AccountName as UNICODE_STRING
	Password as UNICODE_STRING
	ClientRealm as UNICODE_STRING
	ClientName as UNICODE_STRING
	Impersonating as WINBOOLEAN
	KdcAddress as UNICODE_STRING
	KdcAddressType as ULONG
end type

type KERB_SETPASSWORD_EX_REQUEST as _KERB_SETPASSWORD_EX_REQUEST
type PKERB_SETPASSWORD_EX_REQUEST as _KERB_SETPASSWORD_EX_REQUEST ptr
const DS_UNKNOWN_ADDRESS_TYPE = 0
const KERB_SETPASS_USE_LOGONID = 1
const KERB_SETPASS_USE_CREDHANDLE = 2

type _KERB_DECRYPT_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	Flags as ULONG
	CryptoType as LONG
	KeyUsage as LONG
	Key as KERB_CRYPTO_KEY
	EncryptedDataSize as ULONG
	InitialVectorSize as ULONG
	InitialVector as PUCHAR
	EncryptedData as PUCHAR
end type

type KERB_DECRYPT_REQUEST as _KERB_DECRYPT_REQUEST
type PKERB_DECRYPT_REQUEST as _KERB_DECRYPT_REQUEST ptr
const KERB_DECRYPT_FLAG_DEFAULT_KEY = &h00000001

type _KERB_DECRYPT_RESPONSE
	DecryptedData(0 to 0) as UCHAR
end type

type KERB_DECRYPT_RESPONSE as _KERB_DECRYPT_RESPONSE
type PKERB_DECRYPT_RESPONSE as _KERB_DECRYPT_RESPONSE ptr

type _KERB_ADD_BINDING_CACHE_ENTRY_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	RealmName as UNICODE_STRING
	KdcAddress as UNICODE_STRING
	AddressType as ULONG
end type

type KERB_ADD_BINDING_CACHE_ENTRY_REQUEST as _KERB_ADD_BINDING_CACHE_ENTRY_REQUEST
type PKERB_ADD_BINDING_CACHE_ENTRY_REQUEST as _KERB_ADD_BINDING_CACHE_ENTRY_REQUEST ptr

type _KERB_REFRESH_SCCRED_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	CredentialBlob as UNICODE_STRING
	LogonId as LUID
	Flags as ULONG
end type

type KERB_REFRESH_SCCRED_REQUEST as _KERB_REFRESH_SCCRED_REQUEST
type PKERB_REFRESH_SCCRED_REQUEST as _KERB_REFRESH_SCCRED_REQUEST ptr
const KERB_REFRESH_SCCRED_RELEASE = &h0
const KERB_REFRESH_SCCRED_GETTGT = &h1

type _KERB_ADD_CREDENTIALS_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	UserName as UNICODE_STRING
	DomainName as UNICODE_STRING
	Password as UNICODE_STRING
	LogonId as LUID
	Flags as ULONG
end type

type KERB_ADD_CREDENTIALS_REQUEST as _KERB_ADD_CREDENTIALS_REQUEST
type PKERB_ADD_CREDENTIALS_REQUEST as _KERB_ADD_CREDENTIALS_REQUEST ptr
const KERB_REQUEST_ADD_CREDENTIAL = 1
const KERB_REQUEST_REPLACE_CREDENTIAL = 2
const KERB_REQUEST_REMOVE_CREDENTIAL = 4

type _KERB_TRANSFER_CRED_REQUEST
	MessageType as KERB_PROTOCOL_MESSAGE_TYPE
	OriginLogonId as LUID
	DestinationLogonId as LUID
	Flags as ULONG
end type

type KERB_TRANSFER_CRED_REQUEST as _KERB_TRANSFER_CRED_REQUEST
type PKERB_TRANSFER_CRED_REQUEST as _KERB_TRANSFER_CRED_REQUEST ptr

#if _WIN32_WINNT >= &h0600
	const PER_USER_POLICY_UNCHANGED = &h00
	const PER_USER_AUDIT_SUCCESS_INCLUDE = &h01
	const PER_USER_AUDIT_SUCCESS_EXCLUDE = &h02
	const PER_USER_AUDIT_FAILURE_INCLUDE = &h04
	const PER_USER_AUDIT_FAILURE_EXCLUDE = &h08
	const PER_USER_AUDIT_NONE = &h10

	type _AUDIT_POLICY_INFORMATION
		AuditSubCategoryGuid as GUID
		AuditingInformation as ULONG
		AuditCategoryGuid as GUID
	end type

	type AUDIT_POLICY_INFORMATION as _AUDIT_POLICY_INFORMATION
	type PAUDIT_POLICY_INFORMATION as _AUDIT_POLICY_INFORMATION ptr
	type PCAUDIT_POLICY_INFORMATION as _AUDIT_POLICY_INFORMATION ptr

	type _POLICY_AUDIT_SID_ARRAY
		UsersCount as ULONG
		UserSidArray as PSID ptr
	end type

	type POLICY_AUDIT_SID_ARRAY as _POLICY_AUDIT_SID_ARRAY
	type PPOLICY_AUDIT_SID_ARRAY as _POLICY_AUDIT_SID_ARRAY ptr

	type _KERB_CERTIFICATE_LOGON
		MessageType as KERB_LOGON_SUBMIT_TYPE
		DomainName as UNICODE_STRING
		UserName as UNICODE_STRING
		Pin as UNICODE_STRING
		Flags as ULONG
		CspDataLength as ULONG
		CspData as PUCHAR
	end type

	type KERB_CERTIFICATE_LOGON as _KERB_CERTIFICATE_LOGON
	type PKERB_CERTIFICATE_LOGON as _KERB_CERTIFICATE_LOGON ptr

	type _KERB_CERTIFICATE_UNLOCK_LOGON
		Logon as KERB_CERTIFICATE_LOGON
		LogonId as LUID
	end type

	type KERB_CERTIFICATE_UNLOCK_LOGON as _KERB_CERTIFICATE_UNLOCK_LOGON
	type PKERB_CERTIFICATE_UNLOCK_LOGON as _KERB_CERTIFICATE_UNLOCK_LOGON ptr

	type _KERB_SMARTCARD_CSP_INFO
		dwCspInfoLen as DWORD
		MessageType as DWORD

		union
			ContextInformation as PVOID
			SpaceHolderForWow64 as ULONG64
		end union

		flags as DWORD
		KeySpec as DWORD
		nCardNameOffset as ULONG
		nReaderNameOffset as ULONG
		nContainerNameOffset as ULONG
		nCSPNameOffset as ULONG
		bBuffer as TCHAR
	end type

	type KERB_SMARTCARD_CSP_INFO as _KERB_SMARTCARD_CSP_INFO
	type PKERB_SMARTCARD_CSP_INFO as _KERB_SMARTCARD_CSP_INFO ptr
	declare function AuditComputeEffectivePolicyBySid(byval pSid as const PSID, byval pSubCategoryGuids as const GUID ptr, byval PolicyCount as ULONG, byval ppAuditPolicy as PAUDIT_POLICY_INFORMATION ptr) as WINBOOLEAN
	declare sub AuditFree(byval Buffer as PVOID)
	declare function AuditSetSystemPolicy(byval pAuditPolicy as PCAUDIT_POLICY_INFORMATION, byval PolicyCount as ULONG) as WINBOOLEAN
	declare function AuditQuerySystemPolicy(byval pSubCategoryGuids as const GUID ptr, byval PolicyCount as ULONG, byval ppAuditPolicy as PAUDIT_POLICY_INFORMATION ptr) as WINBOOLEAN
	declare function AuditSetPerUserPolicy(byval pSid as const PSID, byval pAuditPolicy as PCAUDIT_POLICY_INFORMATION, byval PolicyCount as ULONG) as WINBOOLEAN
	declare function AuditQueryPerUserPolicy(byval pSid as const PSID, byval pSubCategoryGuids as const GUID ptr, byval PolicyCount as ULONG, byval ppAuditPolicy as PAUDIT_POLICY_INFORMATION ptr) as WINBOOLEAN
	declare function AuditComputeEffectivePolicyByToken(byval hTokenHandle as HANDLE, byval pSubCategoryGuids as const GUID ptr, byval PolicyCount as ULONG, byval ppAuditPolicy as PAUDIT_POLICY_INFORMATION ptr) as WINBOOLEAN
	declare function AuditEnumerateCategories(byval ppAuditCategoriesArray as GUID ptr ptr, byval pCountReturned as PULONG) as WINBOOLEAN
	declare function AuditEnumeratePerUserPolicy(byval ppAuditSidArray as PPOLICY_AUDIT_SID_ARRAY ptr) as WINBOOLEAN
	declare function AuditEnumerateSubCategories(byval pAuditCategoryGuid as const GUID ptr, byval bRetrieveAllSubCategories as WINBOOLEAN, byval ppAuditSubCategoriesArray as GUID ptr ptr, byval pCountReturned as PULONG) as WINBOOLEAN
	declare function AuditLookupCategoryGuidFromCategoryId(byval AuditCategoryId as POLICY_AUDIT_EVENT_TYPE, byval pAuditCategoryGuid as GUID ptr) as WINBOOLEAN
	declare function AuditQuerySecurity(byval SecurityInformation as SECURITY_INFORMATION, byval ppSecurityDescriptor as PSECURITY_DESCRIPTOR ptr) as WINBOOLEAN
	declare function AuditLookupSubCategoryNameA(byval pAuditSubCategoryGuid as const GUID ptr, byval ppszSubCategoryName as LPSTR ptr) as WINBOOLEAN
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function AuditLookupSubCategoryName alias "AuditLookupSubCategoryNameA"(byval pAuditSubCategoryGuid as const GUID ptr, byval ppszSubCategoryName as LPSTR ptr) as WINBOOLEAN
#endif

#if _WIN32_WINNT >= &h0600
	declare function AuditLookupSubCategoryNameW(byval pAuditSubCategoryGuid as const GUID ptr, byval ppszSubCategoryName as LPWSTR ptr) as WINBOOLEAN
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function AuditLookupSubCategoryName alias "AuditLookupSubCategoryNameW"(byval pAuditSubCategoryGuid as const GUID ptr, byval ppszSubCategoryName as LPWSTR ptr) as WINBOOLEAN
#endif

#if _WIN32_WINNT >= &h0600
	declare function AuditLookupCategoryNameA(byval pAuditCategoryGuid as const GUID ptr, byval ppszCategoryName as LPSTR ptr) as WINBOOLEAN
#endif

#if (not defined(UNICODE)) and (_WIN32_WINNT >= &h0600)
	declare function AuditLookupCategoryName alias "AuditLookupCategoryNameA"(byval pAuditCategoryGuid as const GUID ptr, byval ppszCategoryName as LPSTR ptr) as WINBOOLEAN
#endif

#if _WIN32_WINNT >= &h0600
	declare function AuditLookupCategoryNameW(byval pAuditCategoryGuid as const GUID ptr, byval ppszCategoryName as LPWSTR ptr) as WINBOOLEAN
#endif

#if defined(UNICODE) and (_WIN32_WINNT >= &h0600)
	declare function AuditLookupCategoryName alias "AuditLookupCategoryNameW"(byval pAuditCategoryGuid as const GUID ptr, byval ppszCategoryName as LPWSTR ptr) as WINBOOLEAN
#endif

#if _WIN32_WINNT >= &h0600
	declare function AuditLookupCategoryIdFromCategoryGuid(byval pAuditCategoryGuid as const GUID ptr, byval pAuditCategoryId as PPOLICY_AUDIT_EVENT_TYPE) as WINBOOLEAN
	declare function AuditSetSecurity(byval SecurityInformation as SECURITY_INFORMATION, byval pSecurityDescriptor as PSECURITY_DESCRIPTOR) as WINBOOLEAN
#endif

end extern
