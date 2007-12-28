''
''
'' ntsecapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_ntsecapi_bi__
#define __win_ntsecapi_bi__

#inclib "advapi32"

#define KERB_WRAP_NO_ENCRYPT &h80000001
#define LOGON_GUEST 1
#define LOGON_NOENCRYPTION 2
#define LOGON_CACHED_ACCOUNT 4
#define LOGON_USED_LM_PASSWORD 8
#define LOGON_EXTRA_SIDS 32
#define LOGON_SUBAUTH_SESSION_KEY 64
#define LOGON_SERVER_TRUST_ACCOUNT 128
#define LOGON_NTLMV2_ENABLED 256
#define LOGON_RESOURCE_GROUPS 512
#define LOGON_PROFILE_PATH_RETURNED 1024
#define LOGON_GRACE_LOGON 16777216
#define LSA_MODE_PASSWORD_PROTECTED 1
#define LSA_MODE_INDIVIDUAL_ACCOUNTS 2
#define LSA_MODE_MANDATORY_ACCESS 3
#define LSA_MODE_LOG_FULL 4
#define LSA_SUCCESS(x) (cint(x)>=0)
#define MICROSOFT_KERBEROS_NAME "Kerberos"
#define MSV1_0_ALLOW_SERVER_TRUST_ACCOUNT 32
#define MSV1_0_ALLOW_WORKSTATION_TRUST_ACCOUNT 2048
#define MSV1_0_CHALLENGE_LENGTH 8
#define MSV1_0_CLEARTEXT_PASSWORD_ALLOWED 2
#define MSV1_0_CRED_LM_PRESENT 1
#define MSV1_0_CRED_NT_PRESENT 2
#define MSV1_0_CRED_VERSION 0
#define MSV1_0_DONT_TRY_GUEST_ACCOUNT 16
#define MSV1_0_NTLM3_INPUT_LENGTH (sizeof(MSV1_0_NTLM3_RESPONSE)-MSV1_0_NTLM3_RESPONSE_LENGTH)
#define MSV1_0_LANMAN_SESSION_KEY_LENGTH 8
#define MSV1_0_MAX_NTLM3_LIFE 1800
#define MSV1_0_MAX_AVL_SIZE 64000
#define MSV1_0_MNS_LOGON 16777216
#define MSV1_0_NTLM3_RESPONSE_LENGTH 16
#define MSV1_0_NTLM3_OWF_LENGTH 16
#define MSV1_0_OWF_PASSWORD_LENGTH 16
#define MSV1_0_PACKAGE_NAME "MICROSOFT_AUTHENTICATION_PACKAGE_V1_0"
#define MSV1_0_PACKAGE_NAMEW wstr("MICROSOFT_AUTHENTICATION_PACKAGE_V1_0")
#define MSV1_0_PACKAGE_NAMEW_LENGTH sizeof(MSV1_0_PACKAGE_NAMEW)-sizeof(WCHAR)
#define MSV1_0_RETURN_USER_PARAMETERS 8
#define MSV1_0_RETURN_PASSWORD_EXPIRY 64
#define MSV1_0_RETURN_PROFILE_PATH 512
#define MSV1_0_SUBAUTHENTICATION_DLL_EX 1048576
#define MSV1_0_SUBAUTHENTICATION_DLL &hff000000
#define MSV1_0_SUBAUTHENTICATION_DLL_SHIFT 24
#define MSV1_0_SUBAUTHENTICATION_DLL_RAS 2
#define MSV1_0_SUBAUTHENTICATION_DLL_IIS 132
#define MSV1_0_SUBAUTHENTICATION_FLAGS &hff000000
#define MSV1_0_SUBAUTHENTICATION_KEY $"System\CurrentControlSet\Control\Lsa\MSV1_0"
#define MSV1_0_SUBAUTHENTICATION_VALUE "Auth"
#define MSV1_0_TRY_GUEST_ACCOUNT_ONLY 256
#define MSV1_0_TRY_SPECIFIED_DOMAIN_ONLY 1024
#define MSV1_0_UPDATE_LOGON_STATISTICS 4
#define MSV1_0_USE_CLIENT_CHALLENGE 128
#define MSV1_0_USER_SESSION_KEY_LENGTH 16
#define POLICY_VIEW_LOCAL_INFORMATION 1
#define POLICY_VIEW_AUDIT_INFORMATION 2
#define POLICY_GET_PRIVATE_INFORMATION 4
#define POLICY_TRUST_ADMIN 8
#define POLICY_CREATE_ACCOUNT 16
#define POLICY_CREATE_SECRET 32
#define POLICY_CREATE_PRIVILEGE 64
#define POLICY_SET_DEFAULT_QUOTA_LIMITS 128
#define POLICY_SET_AUDIT_REQUIREMENTS 256
#define POLICY_AUDIT_LOG_ADMIN 512
#define POLICY_SERVER_ADMIN 1024
#define POLICY_LOOKUP_NAMES 2048
#define POLICY_READ (&h20000 or 6)
#define POLICY_WRITE (&h20000 or 2040)
#define POLICY_EXECUTE (&h20000 or 2049)
#define POLICY_ALL_ACCESS (&hF0000 or 4095)
#define POLICY_AUDIT_EVENT_UNCHANGED 0
#define POLICY_AUDIT_EVENT_SUCCESS 1
#define POLICY_AUDIT_EVENT_FAILURE 2
#define POLICY_AUDIT_EVENT_NONE 4
#define POLICY_AUDIT_EVENT_MASK 7
#define POLICY_LOCATION_LOCAL 1
#define POLICY_LOCATION_DS 2
#define POLICY_MACHINE_POLICY_LOCAL 0
#define POLICY_MACHINE_POLICY_DEFAULTED 1
#define POLICY_MACHINE_POLICY_EXPLICIT 2
#define POLICY_MACHINE_POLICY_UNKNOWN &hFFFFFFFF
#define POLICY_QOS_SCHANEL_REQUIRED 1
#define POLICY_QOS_OUTBOUND_INTEGRITY 2
#define POLICY_QOS_OUTBOUND_CONFIDENTIALITY 4
#define POLICY_QOS_INBOUND_INTEGREITY 8
#define POLICY_QOS_INBOUND_CONFIDENTIALITY 16
#define POLICY_QOS_ALLOW_LOCAL_ROOT_CERT_STORE 32
#define POLICY_QOS_RAS_SERVER_ALLOWED 64
#define POLICY_QOS_DHCP_SERVER_ALLOWD 128
#define POLICY_KERBEROS_FORWARDABLE 1
#define POLICY_KERBEROS_PROXYABLE 2
#define POLICY_KERBEROS_RENEWABLE 4
#define POLICY_KERBEROS_POSTDATEABLE 8
#define SAM_PASSWORD_CHANGE_NOTIFY_ROUTINE "PasswordChangeNotify"
#define SAM_INIT_NOTIFICATION_ROUTINE "InitializeChangeNotify"
#define SAM_PASSWORD_FILTER_ROUTINE "PasswordFilter"
#define SE_INTERACTIVE_LOGON_NAME "SeInteractiveLogonRight"
#define SE_NETWORK_LOGON_NAME "SeNetworkLogonRight"
#define SE_BATCH_LOGON_NAME "SeBatchLogonRight"
#define SE_SERVICE_LOGON_NAME "SeServiceLogonRight"
#define TRUST_ATTRIBUTE_NON_TRANSITIVE 1
#define TRUST_ATTRIBUTE_UPLEVEL_ONLY 2
#define TRUST_ATTRIBUTE_TREE_PARENT 4194304
#define TRUST_ATTRIBUTES_VALID -16580609
#define TRUST_AUTH_TYPE_NONE 0
#define TRUST_AUTH_TYPE_NT4OWF 1
#define TRUST_AUTH_TYPE_CLEAR 2
#define TRUST_DIRECTION_DISABLED 0
#define TRUST_DIRECTION_INBOUND 1
#define TRUST_DIRECTION_OUTBOUND 2
#define TRUST_DIRECTION_BIDIRECTIONAL 3
#define TRUST_TYPE_DOWNLEVEL 1
#define TRUST_TYPE_UPLEVEL 2
#define TRUST_TYPE_MIT 3
#define TRUST_TYPE_DCE 4

#ifndef __win_ntdef_bi__
type NTSTATUS as LONG
type PNTSTATUS as LONG ptr

type UNICODE_STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PWSTR
end type

type PUNICODE_STRING as UNICODE_STRING ptr

type STRING_
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PCHAR
end type

type PSTRING as STRING_ ptr
#endif

type LSA_UNICODE_STRING as UNICODE_STRING
type PLSA_UNICODE_STRING as UNICODE_STRING ptr
type LSA_STRING as STRING_
type PLSA_STRING as STRING_ ptr

enum MSV1_0_LOGON_SUBMIT_TYPE
	MsV1_0InteractiveLogon = 2
	MsV1_0Lm20Logon
	MsV1_0NetworkLogon
	MsV1_0SubAuthLogon
	MsV1_0WorkstationUnlockLogon = 7
end enum

type PMSV1_0_LOGON_SUBMIT_TYPE as MSV1_0_LOGON_SUBMIT_TYPE

enum MSV1_0_PROFILE_BUFFER_TYPE
	MsV1_0InteractiveProfile = 2
	MsV1_0Lm20LogonProfile
	MsV1_0SmartCardProfile
end enum

type PMSV1_0_PROFILE_BUFFER_TYPE as MSV1_0_PROFILE_BUFFER_TYPE

enum MSV1_0_AVID
	MsvAvEOL
	MsvAvNbComputerName
	MsvAvNbDomainName
	MsvAvDnsComputerName
	MsvAvDnsDomainName
end enum


enum MSV1_0_PROTOCOL_MESSAGE_TYPE
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
end enum

type PMSV1_0_PROTOCOL_MESSAGE_TYPE as MSV1_0_PROTOCOL_MESSAGE_TYPE

enum POLICY_LSA_SERVER_ROLE
	PolicyServerRoleBackup = 2
	PolicyServerRolePrimary
end enum

type PPOLICY_LSA_SERVER_ROLE as POLICY_LSA_SERVER_ROLE

enum POLICY_SERVER_ENABLE_STATE
	PolicyServerEnabled = 2
	PolicyServerDisabled
end enum

type PPOLICY_SERVER_ENABLE_STATE as POLICY_SERVER_ENABLE_STATE

enum POLICY_INFORMATION_CLASS
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
	PolicyEfsInformation
end enum

type PPOLICY_INFORMATION_CLASS as POLICY_INFORMATION_CLASS

enum POLICY_AUDIT_EVENT_TYPE
	AuditCategorySystem
	AuditCategoryLogon
	AuditCategoryObjectAccess
	AuditCategoryPrivilegeUse
	AuditCategoryDetailedTracking
	AuditCategoryPolicyChange
	AuditCategoryAccountManagement
	AuditCategoryDirectoryServiceAccess
	AuditCategoryAccountLogon
end enum

type PPOLICY_AUDIT_EVENT_TYPE as POLICY_AUDIT_EVENT_TYPE

enum POLICY_LOCAL_INFORMATION_CLASS
	PolicyLocalAuditEventsInformation = 1
	PolicyLocalPdAccountInformation
	PolicyLocalAccountDomainInformation
	PolicyLocalLsaServerRoleInformation
	PolicyLocalReplicaSourceInformation
	PolicyLocalModificationInformation
	PolicyLocalAuditFullSetInformation
	PolicyLocalAuditFullQueryInformation
	PolicyLocalDnsDomainInformation
	PolicyLocalIPSecReferenceInformation
	PolicyLocalMachinePasswordInformation
	PolicyLocalQualityOfServiceInformation
	PolicyLocalPolicyLocationInformation
end enum

type PPOLICY_LOCAL_INFORMATION_CLASS as POLICY_LOCAL_INFORMATION_CLASS

enum POLICY_DOMAIN_INFORMATION_CLASS
	PolicyDomainIPSecReferenceInformation = 1
	PolicyDomainQualityOfServiceInformation
	PolicyDomainEfsInformation
	PolicyDomainPublicKeyInformation
	PolicyDomainPasswordPolicyInformation
	PolicyDomainLockoutInformation
	PolicyDomainKerberosTicketInformation
end enum

type PPOLICY_DOMAIN_INFORMATION_CLASS as POLICY_DOMAIN_INFORMATION_CLASS

enum SECURITY_LOGON_TYPE
	Interactive = 2
	Network
	Batch
	Service
	Proxy
	Unlock_
end enum

type PSECURITY_LOGON_TYPE as SECURITY_LOGON_TYPE

enum TRUSTED_INFORMATION_CLASS
	TrustedDomainNameInformation = 1
	TrustedControllersInformation
	TrustedPosixOffsetInformation
	TrustedPasswordInformation
	TrustedDomainInformationBasic
	TrustedDomainInformationEx
	TrustedDomainAuthInformation
	TrustedDomainFullInformation
end enum

type PTRUSTED_INFORMATION_CLASS as TRUSTED_INFORMATION_CLASS

type DOMAIN_PASSWORD_INFORMATION
	MinPasswordLength as USHORT
	PasswordHistoryLength as USHORT
	PasswordProperties as ULONG
	MaxPasswordAge as LARGE_INTEGER
	MinPasswordAge as LARGE_INTEGER
end type

type PDOMAIN_PASSWORD_INFORMATION as DOMAIN_PASSWORD_INFORMATION ptr
type LSA_ENUMERATION_HANDLE as ULONG
type PLSA_ENUMERATION_HANDLE as ULONG ptr

type LSA_ENUMERATION_INFORMATION
	Sid as PSID
end type

type PLSA_ENUMERATION_INFORMATION as LSA_ENUMERATION_INFORMATION ptr
type LSA_OPERATIONAL_MODE as ULONG
type PLSA_OPERATIONAL_MODE as ULONG ptr

#ifndef __win_ntdef_bi__
type LSA_OBJECT_ATTRIBUTES
	Length as ULONG
	RootDirectory as HANDLE
	ObjectName as PLSA_UNICODE_STRING
	Attributes as ULONG
	SecurityDescriptor as PVOID
	SecurityQualityOfService as PVOID
end type

type OBJECT_ATTRIBUTES as LSA_OBJECT_ATTRIBUTES
type POBJECT_ATTRIBUTES as LSA_OBJECT_ATTRIBUTES ptr
#endif
type PLSA_OBJECT_ATTRIBUTES as OBJECT_ATTRIBUTES ptr

type LSA_TRUST_INFORMATION
	Name as LSA_UNICODE_STRING
	Sid as PSID
end type

type PLSA_TRUST_INFORMATION as LSA_TRUST_INFORMATION ptr

type LSA_REFERENCED_DOMAIN_LIST
	Entries as ULONG
	Domains as PLSA_TRUST_INFORMATION
end type

type PLSA_REFERENCED_DOMAIN_LIST as LSA_REFERENCED_DOMAIN_LIST ptr

type LSA_TRANSLATED_SID
	Use as SID_NAME_USE
	RelativeId as ULONG
	DomainIndex as LONG
end type

type PLSA_TRANSLATED_SID as LSA_TRANSLATED_SID ptr

type LSA_TRANSLATED_NAME
	Use as SID_NAME_USE
	Name as LSA_UNICODE_STRING
	DomainIndex as LONG
end type

type PLSA_TRANSLATED_NAME as LSA_TRANSLATED_NAME ptr

type MSV1_0_INTERACTIVE_LOGON
	MessageType as MSV1_0_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Password as UNICODE_STRING
end type

type PMSV1_0_INTERACTIVE_LOGON as MSV1_0_INTERACTIVE_LOGON ptr

type MSV1_0_INTERACTIVE_PROFILE
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

type PMSV1_0_INTERACTIVE_PROFILE as MSV1_0_INTERACTIVE_PROFILE ptr

type MSV1_0_LM20_LOGON
	MessageType as MSV1_0_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Workstation as UNICODE_STRING
	ChallengeToClient(0 to 8-1) as UCHAR
	CaseSensitiveChallengeResponse as STRING_
	CaseInsensitiveChallengeResponse as STRING_
	ParameterControl as ULONG
end type

type PMSV1_0_LM20_LOGON as MSV1_0_LM20_LOGON ptr

type MSV1_0_SUBAUTH_LOGON
	MessageType as MSV1_0_LOGON_SUBMIT_TYPE
	LogonDomainName as UNICODE_STRING
	UserName as UNICODE_STRING
	Workstation as UNICODE_STRING
	ChallengeToClient(0 to 8-1) as UCHAR
	AuthenticationInfo1 as STRING_
	AuthenticationInfo2 as STRING_
	ParameterControl as ULONG
	SubAuthPackageId as ULONG
end type

type PMSV1_0_SUBAUTH_LOGON as MSV1_0_SUBAUTH_LOGON ptr

type MSV1_0_LM20_LOGON_PROFILE
	MessageType as MSV1_0_PROFILE_BUFFER_TYPE
	KickOffTime as LARGE_INTEGER
	LogoffTime as LARGE_INTEGER
	UserFlags as ULONG
	UserSessionKey(0 to 16-1) as UCHAR
	LogonDomainName as UNICODE_STRING
	LanmanSessionKey(0 to 8-1) as UCHAR
	LogonServer as UNICODE_STRING
	UserParameters as UNICODE_STRING
end type

type PMSV1_0_LM20_LOGON_PROFILE as MSV1_0_LM20_LOGON_PROFILE ptr

type MSV1_0_SUPPLEMENTAL_CREDENTIAL
	Version as ULONG
	Flags as ULONG
	LmPassword(0 to 16-1) as UCHAR
	NtPassword(0 to 16-1) as UCHAR
end type

type PMSV1_0_SUPPLEMENTAL_CREDENTIAL as MSV1_0_SUPPLEMENTAL_CREDENTIAL ptr

type MSV1_0_NTLM3_RESPONSE
	Response(0 to 16-1) as UCHAR
	RespType as UCHAR
	HiRespType as UCHAR
	Flags as USHORT
	MsgWord as ULONG
	TimeStamp as ULONGLONG
	ChallengeFromClient(0 to 8-1) as UCHAR
	AvPairsOff as ULONG
	Buffer(0 to 1-1) as UCHAR
end type

type PMSV1_0_NTLM3_RESPONSE as MSV1_0_NTLM3_RESPONSE ptr

type MSV1_0_AV_PAIR
	AvId as USHORT
	AvLen as USHORT
end type

type PMSV1_0_AV_PAIR as MSV1_0_AV_PAIR ptr

type MSV1_0_CHANGEPASSWORD_REQUEST
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	DomainName as UNICODE_STRING
	AccountName as UNICODE_STRING
	OldPassword as UNICODE_STRING
	NewPassword as UNICODE_STRING
	Impersonating as BOOLEAN
end type

type PMSV1_0_CHANGEPASSWORD_REQUEST as MSV1_0_CHANGEPASSWORD_REQUEST ptr

type MSV1_0_CHANGEPASSWORD_RESPONSE
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	PasswordInfoValid as BOOLEAN
	DomainPasswordInfo as DOMAIN_PASSWORD_INFORMATION
end type

type PMSV1_0_CHANGEPASSWORD_RESPONSE as MSV1_0_CHANGEPASSWORD_RESPONSE ptr

type MSV1_0_SUBAUTH_REQUEST
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	SubAuthPackageId as ULONG
	SubAuthInfoLength as ULONG
	SubAuthSubmitBuffer as PUCHAR
end type

type PMSV1_0_SUBAUTH_REQUEST as MSV1_0_SUBAUTH_REQUEST ptr

type MSV1_0_SUBAUTH_RESPONSE
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	SubAuthInfoLength as ULONG
	SubAuthReturnBuffer as PUCHAR
end type

type PMSV1_0_SUBAUTH_RESPONSE as MSV1_0_SUBAUTH_RESPONSE ptr

#define MSV1_0_DERIVECRED_TYPE_SHA1 0

type MSV1_0_DERIVECRED_REQUEST
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	LogonId as LUID
	DeriveCredType as ULONG
	DeriveCredInfoLength as ULONG
	DeriveCredSubmitBuffer(0 to 1-1) as UCHAR
end type

type PMSV1_0_DERIVECRED_REQUEST as MSV1_0_DERIVECRED_REQUEST ptr

type MSV1_0_DERIVECRED_RESPONSE
	MessageType as MSV1_0_PROTOCOL_MESSAGE_TYPE
	DeriveCredInfoLength as ULONG
	DeriveCredReturnBuffer(0 to 1-1) as UCHAR
end type

type PMSV1_0_DERIVECRED_RESPONSE as MSV1_0_DERIVECRED_RESPONSE ptr
type POLICY_AUDIT_EVENT_OPTIONS as ULONG
type PPOLICY_AUDIT_EVENT_OPTIONS as ULONG ptr

type POLICY_PRIVILEGE_DEFINITION
	Name as LSA_UNICODE_STRING
	LocalValue as LUID
end type

type PPOLICY_PRIVILEGE_DEFINITION as POLICY_PRIVILEGE_DEFINITION ptr

type POLICY_AUDIT_LOG_INFO
	AuditLogPercentFull as ULONG
	MaximumLogSize as ULONG
	AuditRetentionPeriod as LARGE_INTEGER
	AuditLogFullShutdownInProgress as BOOLEAN
	TimeToShutdown as LARGE_INTEGER
	NextAuditRecordId as ULONG
end type

type PPOLICY_AUDIT_LOG_INFO as POLICY_AUDIT_LOG_INFO ptr

type POLICY_AUDIT_EVENTS_INFO
	AuditingMode as BOOLEAN
	EventAuditingOptions as PPOLICY_AUDIT_EVENT_OPTIONS
	MaximumAuditEventCount as ULONG
end type

type PPOLICY_AUDIT_EVENTS_INFO as POLICY_AUDIT_EVENTS_INFO ptr

type POLICY_ACCOUNT_DOMAIN_INFO
	DomainName as LSA_UNICODE_STRING
	DomainSid as PSID
end type

type PPOLICY_ACCOUNT_DOMAIN_INFO as POLICY_ACCOUNT_DOMAIN_INFO ptr

type POLICY_PRIMARY_DOMAIN_INFO
	Name as LSA_UNICODE_STRING
	Sid as PSID
end type

type PPOLICY_PRIMARY_DOMAIN_INFO as POLICY_PRIMARY_DOMAIN_INFO ptr

type POLICY_DNS_DOMAIN_INFO
	Name as LSA_UNICODE_STRING
	DnsDomainName as LSA_UNICODE_STRING
	DnsTreeName as LSA_UNICODE_STRING
	DomainGuid as GUID
	Sid as PSID
end type

type PPOLICY_DNS_DOMAIN_INFO as POLICY_DNS_DOMAIN_INFO ptr

type POLICY_PD_ACCOUNT_INFO
	Name as LSA_UNICODE_STRING
end type

type PPOLICY_PD_ACCOUNT_INFO as POLICY_PD_ACCOUNT_INFO ptr

type POLICY_LSA_SERVER_ROLE_INFO
	LsaServerRole as POLICY_LSA_SERVER_ROLE
end type

type PPOLICY_LSA_SERVER_ROLE_INFO as POLICY_LSA_SERVER_ROLE_INFO ptr

type POLICY_REPLICA_SOURCE_INFO
	ReplicaSource as LSA_UNICODE_STRING
	ReplicaAccountName as LSA_UNICODE_STRING
end type

type PPOLICY_REPLICA_SOURCE_INFO as POLICY_REPLICA_SOURCE_INFO ptr

type POLICY_DEFAULT_QUOTA_INFO
	QuotaLimits as QUOTA_LIMITS
end type

type PPOLICY_DEFAULT_QUOTA_INFO as POLICY_DEFAULT_QUOTA_INFO ptr

type POLICY_MODIFICATION_INFO
	ModifiedId as LARGE_INTEGER
	DatabaseCreationTime as LARGE_INTEGER
end type

type PPOLICY_MODIFICATION_INFO as POLICY_MODIFICATION_INFO ptr

type POLICY_AUDIT_FULL_SET_INFO
	ShutDownOnFull as BOOLEAN
end type

type PPOLICY_AUDIT_FULL_SET_INFO as POLICY_AUDIT_FULL_SET_INFO ptr

type POLICY_AUDIT_FULL_QUERY_INFO
	ShutDownOnFull as BOOLEAN
	LogIsFull as BOOLEAN
end type

type PPOLICY_AUDIT_FULL_QUERY_INFO as POLICY_AUDIT_FULL_QUERY_INFO ptr

type POLICY_EFS_INFO
	InfoLength as ULONG
	EfsBlob as PUCHAR
end type

type PPOLICY_EFS_INFO as POLICY_EFS_INFO ptr

type POLICY_LOCAL_IPSEC_REFERENCE_INFO
	ObjectPath as LSA_UNICODE_STRING
end type

type PPOLICY_LOCAL_IPSEC_REFERENCE_INFO as POLICY_LOCAL_IPSEC_REFERENCE_INFO ptr

type POLICY_LOCAL_MACHINE_PASSWORD_INFO
	PasswordChangeInterval as LARGE_INTEGER
end type

type PPOLICY_LOCAL_MACHINE_PASSWORD_INFO as POLICY_LOCAL_MACHINE_PASSWORD_INFO ptr

type POLICY_LOCALPOLICY_LOCATION_INFO
	PolicyLocation as ULONG
end type

type PPOLICY_LOCALPOLICY_LOCATION_INFO as POLICY_LOCALPOLICY_LOCATION_INFO ptr

type POLICY_LOCAL_QUALITY_OF_SERVICE_INFO
	QualityOfService as ULONG
end type

type PPOLICY_LOCAL_QUALITY_OF_SERVICE_INFO as POLICY_LOCAL_QUALITY_OF_SERVICE_INFO ptr
type POLICY_DOMAIN_QUALITY_OF_SERVICE_INFO as POLICY_LOCAL_QUALITY_OF_SERVICE_INFO
type PPOLICY_DOMAIN_QUALITY_OF_SERVICE_INFO as POLICY_LOCAL_QUALITY_OF_SERVICE_INFO ptr

type POLICY_DOMAIN_PUBLIC_KEY_INFO
	InfoLength as ULONG
	PublicKeyInfo as PUCHAR
end type

type PPOLICY_DOMAIN_PUBLIC_KEY_INFO as POLICY_DOMAIN_PUBLIC_KEY_INFO ptr

type POLICY_DOMAIN_LOCKOUT_INFO
	LockoutDuration as LARGE_INTEGER
	LockoutObservationWindow as LARGE_INTEGER
	LockoutThreshold as USHORT
end type

type PPOLICY_DOMAIN_LOCKOUT_INFO as POLICY_DOMAIN_LOCKOUT_INFO ptr

type POLICY_DOMAIN_PASSWORD_INFO
	MinPasswordLength as USHORT
	PasswordHistoryLength as USHORT
	PasswordProperties as ULONG
	MaxPasswordAge as LARGE_INTEGER
	MinPasswordAge as LARGE_INTEGER
end type

type PPOLICY_DOMAIN_PASSWORD_INFO as POLICY_DOMAIN_PASSWORD_INFO ptr

type POLICY_DOMAIN_KERBEROS_TICKET_INFO
	AuthenticationOptions as ULONG
	MinTicketAge as LARGE_INTEGER
	MaxTicketAge as LARGE_INTEGER
	MaxRenewAge as LARGE_INTEGER
	ProxyLifetime as LARGE_INTEGER
	ForceLogoff as LARGE_INTEGER
end type

type PPOLICY_DOMAIN_KERBEROS_TICKET_INFO as POLICY_DOMAIN_KERBEROS_TICKET_INFO ptr
type LSA_HANDLE as PVOID
type PLSA_HANDLE as PVOID ptr

type TRUSTED_DOMAIN_NAME_INFO
	Name as LSA_UNICODE_STRING
end type

type PTRUSTED_DOMAIN_NAME_INFO as TRUSTED_DOMAIN_NAME_INFO ptr

type TRUSTED_CONTROLLERS_INFO
	Entries as ULONG
	Names as PLSA_UNICODE_STRING
end type

type PTRUSTED_CONTROLLERS_INFO as TRUSTED_CONTROLLERS_INFO ptr

type TRUSTED_POSIX_OFFSET_INFO
	Offset as ULONG
end type

type PTRUSTED_POSIX_OFFSET_INFO as TRUSTED_POSIX_OFFSET_INFO ptr

type TRUSTED_PASSWORD_INFO
	Password as LSA_UNICODE_STRING
	OldPassword as LSA_UNICODE_STRING
end type

type PTRUSTED_PASSWORD_INFO as TRUSTED_PASSWORD_INFO ptr
type TRUSTED_DOMAIN_INFORMATION_BASIC as LSA_TRUST_INFORMATION
type PTRUSTED_DOMAIN_INFORMATION_BASIC as PLSA_TRUST_INFORMATION ptr

type TRUSTED_DOMAIN_INFORMATION_EX
	Name as LSA_UNICODE_STRING
	FlatName as LSA_UNICODE_STRING
	Sid as PSID
	TrustDirection as ULONG
	TrustType as ULONG
	TrustAttributes as ULONG
end type

type PTRUSTED_DOMAIN_INFORMATION_EX as TRUSTED_DOMAIN_INFORMATION_EX ptr

type LSA_AUTH_INFORMATION
	LastUpdateTime as LARGE_INTEGER
	AuthType as ULONG
	AuthInfoLength as ULONG
	AuthInfo as PUCHAR
end type

type PLSA_AUTH_INFORMATION as LSA_AUTH_INFORMATION ptr

type TRUSTED_DOMAIN_AUTH_INFORMATION
	IncomingAuthInfos as ULONG
	IncomingAuthenticationInformation as PLSA_AUTH_INFORMATION
	IncomingPreviousAuthenticationInformation as PLSA_AUTH_INFORMATION
	OutgoingAuthInfos as ULONG
	OutgoingAuthenticationInformation as PLSA_AUTH_INFORMATION
	OutgoingPreviousAuthenticationInformation as PLSA_AUTH_INFORMATION
end type

type PTRUSTED_DOMAIN_AUTH_INFORMATION as TRUSTED_DOMAIN_AUTH_INFORMATION ptr

type TRUSTED_DOMAIN_FULL_INFORMATION
	Information as TRUSTED_DOMAIN_INFORMATION_EX
	PosixOffset as TRUSTED_POSIX_OFFSET_INFO
	AuthInformation as TRUSTED_DOMAIN_AUTH_INFORMATION
end type

type PTRUSTED_DOMAIN_FULL_INFORMATION as TRUSTED_DOMAIN_FULL_INFORMATION ptr

declare function LsaAddAccountRights alias "LsaAddAccountRights" (byval as LSA_HANDLE, byval as PSID, byval as PLSA_UNICODE_STRING, byval as ULONG) as NTSTATUS
declare function LsaCallAuthenticationPackage alias "LsaCallAuthenticationPackage" (byval as HANDLE, byval as ULONG, byval as PVOID, byval as ULONG, byval as PVOID ptr, byval as PULONG, byval as PNTSTATUS) as NTSTATUS
declare function LsaClose alias "LsaClose" (byval as LSA_HANDLE) as NTSTATUS
declare function LsaConnectUntrusted alias "LsaConnectUntrusted" (byval as PHANDLE) as NTSTATUS
declare function LsaCreateTrustedDomainEx alias "LsaCreateTrustedDomainEx" (byval as LSA_HANDLE, byval as PTRUSTED_DOMAIN_INFORMATION_EX, byval as PTRUSTED_DOMAIN_AUTH_INFORMATION, byval as ACCESS_MASK, byval as PLSA_HANDLE) as NTSTATUS
declare function LsaDeleteTrustedDomain alias "LsaDeleteTrustedDomain" (byval as LSA_HANDLE, byval as PSID) as NTSTATUS
declare function LsaDeregisterLogonProcess alias "LsaDeregisterLogonProcess" (byval as HANDLE) as NTSTATUS
declare function LsaEnumerateAccountRights alias "LsaEnumerateAccountRights" (byval as LSA_HANDLE, byval as PSID, byval as PLSA_UNICODE_STRING ptr, byval as PULONG) as NTSTATUS
declare function LsaEnumerateAccountsWithUserRight alias "LsaEnumerateAccountsWithUserRight" (byval as LSA_HANDLE, byval as PLSA_UNICODE_STRING, byval as PVOID ptr, byval as PULONG) as NTSTATUS
declare function LsaEnumerateTrustedDomains alias "LsaEnumerateTrustedDomains" (byval as LSA_HANDLE, byval as PLSA_ENUMERATION_HANDLE, byval as PVOID ptr, byval as ULONG, byval as PULONG) as NTSTATUS
declare function LsaEnumerateTrustedDomainsEx alias "LsaEnumerateTrustedDomainsEx" (byval as LSA_HANDLE, byval as PLSA_ENUMERATION_HANDLE, byval as TRUSTED_INFORMATION_CLASS, byval as PVOID ptr, byval as ULONG, byval as PULONG) as NTSTATUS
declare function LsaFreeMemory alias "LsaFreeMemory" (byval as PVOID) as NTSTATUS
declare function LsaFreeReturnBuffer alias "LsaFreeReturnBuffer" (byval as PVOID) as NTSTATUS
declare function LsaLogonUser alias "LsaLogonUser" (byval as HANDLE, byval as PLSA_STRING, byval as SECURITY_LOGON_TYPE, byval as ULONG, byval as PVOID, byval as ULONG, byval as PTOKEN_GROUPS, byval as PTOKEN_SOURCE, byval as PVOID ptr, byval as PULONG, byval as PLUID, byval as PHANDLE, byval as PQUOTA_LIMITS, byval as PNTSTATUS) as NTSTATUS
declare function LsaLookupAuthenticationPackage alias "LsaLookupAuthenticationPackage" (byval as HANDLE, byval as PLSA_STRING, byval as PULONG) as NTSTATUS
declare function LsaLookupNames alias "LsaLookupNames" (byval as LSA_HANDLE, byval as ULONG, byval as PLSA_UNICODE_STRING, byval as PLSA_REFERENCED_DOMAIN_LIST ptr, byval as PLSA_TRANSLATED_SID ptr) as NTSTATUS
declare function LsaLookupSids alias "LsaLookupSids" (byval as LSA_HANDLE, byval as ULONG, byval as PSID ptr, byval as PLSA_REFERENCED_DOMAIN_LIST ptr, byval as PLSA_TRANSLATED_NAME ptr) as NTSTATUS
declare function LsaNtStatusToWinError alias "LsaNtStatusToWinError" (byval as NTSTATUS) as ULONG
declare function LsaOpenPolicy alias "LsaOpenPolicy" (byval as PLSA_UNICODE_STRING, byval as PLSA_OBJECT_ATTRIBUTES, byval as ACCESS_MASK, byval as PLSA_HANDLE) as NTSTATUS
declare function LsaQueryDomainInformationPolicy alias "LsaQueryDomainInformationPolicy" (byval as LSA_HANDLE, byval as POLICY_DOMAIN_INFORMATION_CLASS, byval as PVOID ptr) as NTSTATUS
declare function LsaQueryInformationPolicy alias "LsaQueryInformationPolicy" (byval as LSA_HANDLE, byval as POLICY_INFORMATION_CLASS, byval as PVOID ptr) as NTSTATUS
declare function LsaQueryLocalInformationPolicy alias "LsaQueryLocalInformationPolicy" (byval as LSA_HANDLE, byval as POLICY_LOCAL_INFORMATION_CLASS, byval as PVOID ptr) as NTSTATUS
declare function LsaQueryTrustedDomainInfo alias "LsaQueryTrustedDomainInfo" (byval as LSA_HANDLE, byval as PSID, byval as TRUSTED_INFORMATION_CLASS, byval as PVOID ptr) as NTSTATUS
declare function LsaQueryTrustedDomainInfoByName alias "LsaQueryTrustedDomainInfoByName" (byval as LSA_HANDLE, byval as PLSA_UNICODE_STRING, byval as TRUSTED_INFORMATION_CLASS, byval as PVOID ptr) as NTSTATUS
declare function LsaRegisterLogonProcess alias "LsaRegisterLogonProcess" (byval as PLSA_STRING, byval as PHANDLE, byval as PLSA_OPERATIONAL_MODE) as NTSTATUS
declare function LsaRemoveAccountRights alias "LsaRemoveAccountRights" (byval as LSA_HANDLE, byval as PSID, byval as BOOLEAN, byval as PLSA_UNICODE_STRING, byval as ULONG) as NTSTATUS
declare function LsaRetrievePrivateData alias "LsaRetrievePrivateData" (byval as LSA_HANDLE, byval as PLSA_UNICODE_STRING, byval as PLSA_UNICODE_STRING ptr) as NTSTATUS
declare function LsaSetDomainInformationPolicy alias "LsaSetDomainInformationPolicy" (byval as LSA_HANDLE, byval as POLICY_DOMAIN_INFORMATION_CLASS, byval as PVOID) as NTSTATUS
declare function LsaSetInformationPolicy alias "LsaSetInformationPolicy" (byval as LSA_HANDLE, byval as POLICY_INFORMATION_CLASS, byval as PVOID) as NTSTATUS
declare function LsaSetLocalInformationPolicy alias "LsaSetLocalInformationPolicy" (byval as LSA_HANDLE, byval as POLICY_LOCAL_INFORMATION_CLASS, byval as PVOID) as NTSTATUS
declare function LsaSetTrustedDomainInformation alias "LsaSetTrustedDomainInformation" (byval as LSA_HANDLE, byval as PSID, byval as TRUSTED_INFORMATION_CLASS, byval as PVOID) as NTSTATUS
declare function LsaSetTrustedDomainInfoByName alias "LsaSetTrustedDomainInfoByName" (byval as LSA_HANDLE, byval as PLSA_UNICODE_STRING, byval as TRUSTED_INFORMATION_CLASS, byval as PVOID) as NTSTATUS
declare function LsaStorePrivateData alias "LsaStorePrivateData" (byval as LSA_HANDLE, byval as PLSA_UNICODE_STRING, byval as PLSA_UNICODE_STRING) as NTSTATUS

type PSAM_PASSWORD_NOTIFICATION_ROUTINE as function (byval as PUNICODE_STRING, byval as ULONG, byval as PUNICODE_STRING) as NTSTATUS
type PSAM_INIT_NOTIFICATION_ROUTINE as function () as BOOLEAN
type PSAM_PASSWORD_FILTER_ROUTINE as function (byval as PUNICODE_STRING, byval as PUNICODE_STRING, byval as PUNICODE_STRING, byval as BOOLEAN) as BOOLEAN

#endif
