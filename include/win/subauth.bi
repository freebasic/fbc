''
''
'' subauth -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_subauth_bi__
#define __win_subauth_bi__

#define STATUS_SUCCESS 0
#define CYPHER_BLOCK_LENGTH 8
#define USER_SESSION_KEY_LENGTH (8*2)
#define CLEAR_BLOCK_LENGTH 8
#define MSV1_0_PASSTHRU 1
#define MSV1_0_GUEST_LOGON 2
#define MSV1_0_VALIDATION_LOGOFF_TIME 1
#define MSV1_0_VALIDATION_KICKOFF_TIME 2
#define MSV1_0_VALIDATION_LOGON_SERVER 4
#define MSV1_0_VALIDATION_LOGON_DOMAIN 8
#define MSV1_0_VALIDATION_SESSION_KEY 16
#define MSV1_0_VALIDATION_USER_FLAGS 32
#define MSV1_0_VALIDATION_USER_ID 64
#define MSV1_0_SUBAUTH_ACCOUNT_DISABLED 1
#define MSV1_0_SUBAUTH_PASSWORD 2
#define MSV1_0_SUBAUTH_WORKSTATIONS 4
#define MSV1_0_SUBAUTH_LOGON_HOURS 8
#define MSV1_0_SUBAUTH_ACCOUNT_EXPIRY 16
#define MSV1_0_SUBAUTH_PASSWORD_EXPIRY 32
#define MSV1_0_SUBAUTH_ACCOUNT_TYPE 64
#define MSV1_0_SUBAUTH_LOCKOUT 128
#define NEXT_FREE_ACCOUNT_CONTROL_BIT 131072
#define SAM_DAYS_PER_WEEK 7
#define SAM_HOURS_PER_WEEK 168
#define SAM_MINUTES_PER_WEEK 10080
#define STATUS_INVALID_INFO_CLASS &hC0000003L
#define STATUS_NO_SUCH_USER &hC0000064L
#define STATUS_WRONG_PASSWORD &hC000006AL
#define STATUS_PASSWORD_RESTRICTION &hC000006CL
#define STATUS_LOGON_FAILURE &hC000006DL
#define STATUS_ACCOUNT_RESTRICTION &hC000006EL
#define STATUS_INVALID_LOGON_HOURS &hC000006FL
#define STATUS_INVALID_WORKSTATION &hC0000070L
#define STATUS_PASSWORD_EXPIRED &hC0000071L
#define STATUS_ACCOUNT_DISABLED &hC0000072L
#define STATUS_INSUFFICIENT_RESOURCES &hC000009AL
#define STATUS_ACCOUNT_EXPIRED &hC0000193L
#define STATUS_PASSWORD_MUST_CHANGE &hC0000224L
#define STATUS_ACCOUNT_LOCKED_OUT &hC0000234L
#define USER_ACCOUNT_DISABLED 1
#define USER_HOME_DIRECTORY_REQUIRED 2
#define USER_PASSWORD_NOT_REQUIRED 4
#define USER_TEMP_DUPLICATE_ACCOUNT 8
#define USER_NORMAL_ACCOUNT 16
#define USER_MNS_LOGON_ACCOUNT 32
#define USER_INTERDOMAIN_TRUST_ACCOUNT 64
#define USER_WORKSTATION_TRUST_ACCOUNT 128
#define USER_SERVER_TRUST_ACCOUNT 256
#define USER_DONT_EXPIRE_PASSWORD 512
#define USER_ACCOUNT_AUTO_LOCKED 1024
#define USER_ENCRYPTED_TEXT_PASSWORD_ALLOWED 2048
#define USER_SMARTCARD_REQUIRED 4096
#define USER_TRUSTED_FOR_DELEGATION 8192
#define USER_NOT_DELEGATED 16384
#define USER_USE_DES_KEY_ONLY 32768
#define USER_DONT_REQUIRE_PREAUTH 65536
#define USER_MACHINE_ACCOUNT_MASK 448
#define USER_ACCOUNT_TYPE_MASK 472
#define USER_ALL_PARAMETERS 2097152

type NTSTATUS as LONG
type PNTSTATUS as LONG ptr

#ifndef UNICODE_STRING
type UNICODE_STRING
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PWSTR
end type

type PUNICODE_STRING as UNICODE_STRING ptr
#endif

#ifndef STRING_
type STRING_
	Length as USHORT
	MaximumLength as USHORT
	Buffer as PCHAR
end type

type PSTRING as STRING_ ptr
type SAM_HANDLE as PVOID
type PSAM_HANDLE as PVOID ptr
#endif

type OLD_LARGE_INTEGER
	LowPart as ULONG
	HighPart as LONG
end type

type POLD_LARGE_INTEGER as OLD_LARGE_INTEGER ptr

enum NETLOGON_LOGON_INFO_CLASS
	NetlogonInteractiveInformation = 1
	NetlogonNetworkInformation
	NetlogonServiceInformation
	NetlogonGenericInformation
	NetlogonInteractiveTransitiveInformation
	NetlogonNetworkTransitiveInformation
	NetlogonServiceTransitiveInformation
end enum

type CYPHER_BLOCK
	data as zstring * 8
end type

type PCYPHER_BLOCK as CYPHER_BLOCK ptr

type CLEAR_BLOCK
	data as zstring * 8
end type

type PCLEAR_BLOCK as CLEAR_BLOCK ptr

type LM_OWF_PASSWORD
	data(0 to 2-1) as CYPHER_BLOCK
end type

type PLM_OWF_PASSWORD as LM_OWF_PASSWORD ptr

type USER_SESSION_KEY
	data(0 to 2-1) as CYPHER_BLOCK
end type

type PUSER_SESSION_KEY as USER_SESSION_KEY ptr

type LM_CHALLENGE as CLEAR_BLOCK
type PLM_CHALLENGE as CLEAR_BLOCK ptr
type NT_OWF_PASSWORD as LM_OWF_PASSWORD
type PNT_OWF_PASSWORD as LM_OWF_PASSWORD ptr
type NT_CHALLENGE as LM_CHALLENGE
type PNT_CHALLENGE as LM_CHALLENGE ptr

type LOGON_HOURS
	UnitsPerWeek as USHORT
	LogonHours as PUCHAR
end type

type PLOGON_HOURS as LOGON_HOURS ptr

type SR_SECURITY_DESCRIPTOR
	Length as ULONG
	SecurityDescriptor as PUCHAR
end type

type PSR_SECURITY_DESCRIPTOR as SR_SECURITY_DESCRIPTOR ptr

type USER_ALL_INFORMATION
	LastLogon as LARGE_INTEGER
	LastLogoff as LARGE_INTEGER
	PasswordLastSet as LARGE_INTEGER
	AccountExpires as LARGE_INTEGER
	PasswordCanChange as LARGE_INTEGER
	PasswordMustChange as LARGE_INTEGER
	UserName as UNICODE_STRING
	FullName as UNICODE_STRING
	HomeDirectory as UNICODE_STRING
	HomeDirectoryDrive as UNICODE_STRING
	ScriptPath as UNICODE_STRING
	ProfilePath as UNICODE_STRING
	AdminComment as UNICODE_STRING
	WorkStations as UNICODE_STRING
	UserComment as UNICODE_STRING
	Parameters as UNICODE_STRING
	LmPassword as UNICODE_STRING
	NtPassword as UNICODE_STRING
	PrivateData as UNICODE_STRING
	SecurityDescriptor as SR_SECURITY_DESCRIPTOR
	UserId as ULONG
	PrimaryGroupId as ULONG
	UserAccountControl as ULONG
	WhichFields as ULONG
	LogonHours as LOGON_HOURS
	BadPasswordCount as USHORT
	LogonCount as USHORT
	CountryCode as USHORT
	CodePage as USHORT
	LmPasswordPresent as BOOLEAN
	NtPasswordPresent as BOOLEAN
	PasswordExpired as BOOLEAN
	PrivateDataSensitive as BOOLEAN
end type

type PUSER_ALL_INFORMATION as USER_ALL_INFORMATION ptr

type MSV1_0_VALIDATION_INFO
	LogoffTime as LARGE_INTEGER
	KickoffTime as LARGE_INTEGER
	LogonServer as UNICODE_STRING
	LogonDomainName as UNICODE_STRING
	SessionKey as USER_SESSION_KEY
	Authoritative as BOOLEAN
	UserFlags as ULONG
	WhichFields as ULONG
	UserId as ULONG
end type

type PMSV1_0_VALIDATION_INFO as MSV1_0_VALIDATION_INFO ptr

type NETLOGON_LOGON_IDENTITY_INFO
	LogonDomainName as UNICODE_STRING
	ParameterControl as ULONG
	LogonId as OLD_LARGE_INTEGER
	UserName as UNICODE_STRING
	Workstation as UNICODE_STRING
end type

type PNETLOGON_LOGON_IDENTITY_INFO as NETLOGON_LOGON_IDENTITY_INFO ptr

type NETLOGON_INTERACTIVE_INFO
	Identity as NETLOGON_LOGON_IDENTITY_INFO
	LmOwfPassword as LM_OWF_PASSWORD
	NtOwfPassword as NT_OWF_PASSWORD
end type

type PNETLOGON_INTERACTIVE_INFO as NETLOGON_INTERACTIVE_INFO ptr

type NETLOGON_GENERIC_INFO
	Identity as NETLOGON_LOGON_IDENTITY_INFO
	PackageName as UNICODE_STRING
	DataLength as ULONG
	LogonData as PUCHAR
end type

type PNETLOGON_GENERIC_INFO as NETLOGON_GENERIC_INFO ptr

type NETLOGON_NETWORK_INFO
	Identity as NETLOGON_LOGON_IDENTITY_INFO
	LmChallenge as LM_CHALLENGE
	NtChallengeResponse as STRING_
	LmChallengeResponse as STRING_
end type

type PNETLOGON_NETWORK_INFO as NETLOGON_NETWORK_INFO ptr

type NETLOGON_SERVICE_INFO
	Identity as NETLOGON_LOGON_IDENTITY_INFO
	LmOwfPassword as LM_OWF_PASSWORD
	NtOwfPassword as NT_OWF_PASSWORD
end type

type PNETLOGON_SERVICE_INFO as NETLOGON_SERVICE_INFO ptr

declare function Msv1_0SubAuthenticationRoutine alias "Msv1_0SubAuthenticationRoutine" (byval as NETLOGON_LOGON_INFO_CLASS, byval as PVOID, byval as ULONG, byval as PUSER_ALL_INFORMATION, byval as PULONG, byval as PULONG, byval as PBOOLEAN, byval as PLARGE_INTEGER, byval as PLARGE_INTEGER) as NTSTATUS
declare function Msv1_0SubAuthenticationFilter alias "Msv1_0SubAuthenticationFilter" (byval as NETLOGON_LOGON_INFO_CLASS, byval as PVOID, byval as ULONG, byval as PUSER_ALL_INFORMATION, byval as PULONG, byval as PULONG, byval as PBOOLEAN, byval as PLARGE_INTEGER, byval as PLARGE_INTEGER) as NTSTATUS
declare function Msv1_0SubAuthenticationRoutineGeneric alias "Msv1_0SubAuthenticationRoutineGeneric" (byval as PVOID, byval as ULONG, byval as PULONG, byval as PVOID ptr) as NTSTATUS
declare function Msv1_0SubAuthenticationRoutineEx alias "Msv1_0SubAuthenticationRoutineEx" (byval as NETLOGON_LOGON_INFO_CLASS, byval as PVOID, byval as ULONG, byval as PUSER_ALL_INFORMATION, byval as SAM_HANDLE, byval as PMSV1_0_VALIDATION_INFO, byval as PULONG) as NTSTATUS

#endif
