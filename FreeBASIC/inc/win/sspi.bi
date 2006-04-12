''
''
'' sspi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_sspi_bi__
#define __win_sspi_bi__

#define SECPKG_CRED_INBOUND 1
#define SECPKG_CRED_OUTBOUND 2
#define SECPKG_CRED_BOTH (2 or 1)
#define SECPKG_CRED_ATTR_NAMES 1
#define SECPKG_FLAG_INTEGRITY 1
#define SECPKG_FLAG_PRIVACY 2
#define SECPKG_FLAG_TOKEN_ONLY 4
#define SECPKG_FLAG_DATAGRAM 8
#define SECPKG_FLAG_CONNECTION 16
#define SECPKG_FLAG_MULTI_REQUIRED 32
#define SECPKG_FLAG_CLIENT_ONLY 64
#define SECPKG_FLAG_EXTENDED_ERROR 128
#define SECPKG_FLAG_IMPERSONATION 256
#define SECPKG_FLAG_ACCEPT_WIN32_NAME 512
#define SECPKG_FLAG_STREAM 1024
#define SECPKG_ATTR_AUTHORITY 6
#define SECPKG_ATTR_CONNECTION_INFO 90
#define SECPKG_ATTR_ISSUER_LIST 80
#define SECPKG_ATTR_ISSUER_LIST_EX 89
#define SECPKG_ATTR_KEY_INFO 5
#define SECPKG_ATTR_LIFESPAN 2
#define SECPKG_ATTR_LOCAL_CERT_CONTEXT 84
#define SECPKG_ATTR_LOCAL_CRED 82
#define SECPKG_ATTR_NAMES 1
#define SECPKG_ATTR_PROTO_INFO 7
#define SECPKG_ATTR_REMOTE_CERT_CONTEXT 83
#define SECPKG_ATTR_REMOTE_CRED 81
#define SECPKG_ATTR_SIZES 0
#define SECPKG_ATTR_STREAM_SIZES 4
#define SECBUFFER_EMPTY 0
#define SECBUFFER_DATA 1
#define SECBUFFER_TOKEN 2
#define SECBUFFER_PKG_PARAMS 3
#define SECBUFFER_MISSING 4
#define SECBUFFER_EXTRA 5
#define SECBUFFER_STREAM_TRAILER 6
#define SECBUFFER_STREAM_HEADER 7
#define SECBUFFER_PADDING 9
#define SECBUFFER_STREAM 10
#define SECBUFFER_READONLY &h80000000
#define SECBUFFER_ATTRMASK &hf0000000
#define UNISP_NAME "Microsoft Unified Security Protocol Provider"
#define SECBUFFER_VERSION 0

type SecHandle
	dwLower as ULONG_PTR
	dwUpper as ULONG_PTR
end type

type PSecHandle as SecHandle ptr

type SecBuffer
	cbBuffer as ULONG
	BufferType as ULONG
	pvBuffer as PVOID
end type

type PSecBuffer as SecBuffer ptr
type CredHandle as SecHandle
type PCredHandle as PSecHandle
type CtxtHandle as SecHandle
type PCtxtHandle as PSecHandle

type SECURITY_INTEGER
	LowPart as uinteger
	HighPart as integer
end type

type TimeStamp as SECURITY_INTEGER
type PTimeStamp as SECURITY_INTEGER ptr

type SecBufferDesc
	ulVersion as ULONG
	cBuffers as ULONG
	pBuffers as PSecBuffer
end type

type PSecBufferDesc as SecBufferDesc ptr

type SecPkgContext_StreamSizes
	cbHeader as ULONG
	cbTrailer as ULONG
	cbMaximumMessage as ULONG
	cBuffers as ULONG
	cbBlockSize as ULONG
end type

type PSecPkgContext_StreamSizes as SecPkgContext_StreamSizes ptr

type SecPkgContext_Sizes
	cbMaxToken as ULONG
	cbMaxSIgnature as ULONG
	cbBlockSize as ULONG
	cbSecurityTrailer as ULONG
end type

type PSecPkgContext_Sizes as SecPkgContext_Sizes ptr

#ifdef UNICODE
type SecPkgContext_AuthorityW
	sAuthorityName as SEC_WCHAR ptr
end type

type PSecPkgContext_AuthorityW as SecPkgContext_AuthorityW ptr

type SecPkgContext_KeyInfoW
	sSignatureAlgorithmName as SEC_WCHAR ptr
	sEncryptAlgorithmName as SEC_WCHAR ptr
	KeySize as ULONG
	SignatureAlgorithm as ULONG
	EncryptAlgorithm as ULONG
end type

type PSecPkgContext_KeyInfoW as SecPkgContext_KeyInfoW ptr

#else ''UNICODE
type SecPkgContext_AuthorityA
	sAuthorityName as SEC_CHAR ptr
end type

type PSecPkgContext_AuthorityA as SecPkgContext_AuthorityA ptr

type SecPkgContext_KeyInfoA
	sSignatureAlgorithmName as SEC_CHAR ptr
	sEncryptAlgorithmName as SEC_CHAR ptr
	KeySize as ULONG
	SignatureAlgorithm as ULONG
	EncryptAlgorithm as ULONG
end type

type PSecPkgContext_KeyInfoA as SecPkgContext_KeyInfoA ptr
#endif ''UNICODE

type SecPkgContext_LifeSpan
	tsStart as TimeStamp
	tsExpiry as TimeStamp
end type

type PSecPkgContext_LifeSpan as SecPkgContext_LifeSpan ptr

#ifdef UNICODE
type SecPkgContext_NamesW
	sUserName as SEC_WCHAR ptr
end type

type PSecPkgContext_NamesW as SecPkgContext_NamesW ptr

type SecPkgInfoW
	fCapabilities as ULONG
	wVersion as USHORT
	wRPCID as USHORT
	cbMaxToken as ULONG
	Name as SEC_WCHAR ptr
	Comment as SEC_WCHAR ptr
end type

type PSecPkgInfoW as SecPkgInfoW ptr

type SecPkgContext_PackageInfo
	PackageInfo as PSecPkgInfoW
end type

type SecPkgContext_PackageInfo as SecPkgContext_PackageInfo
type PSecPkgContext_PackageInfo as SecPkgContext_PackageInfo ptr

type SecPkgCredentials_NamesW
	sUserName as SEC_WCHAR ptr
end type

type PSecPkgCredentialsNamesW as SecPkgCredentials_NamesW ptr

#else ''UNICODE
type SecPkgContext_NamesA
	sUserName as SEC_CHAR ptr
end type

type PSecPkgContext_NamesA as SecPkgContext_NamesA ptr

type SecPkgInfoA
	fCapabilities as ULONG
	wVersion as USHORT
	wRPCID as USHORT
	cbMaxToken as ULONG
	Name as SEC_CHAR ptr
	Comment as SEC_CHAR ptr
end type

type PSecPkgInfoA as SecPkgInfoA ptr

type SecPkgCredentials_NamesA
	sUserName as SEC_CHAR ptr
end type

type PSecPkgCredentialsNamesA as SecPkgCredentials_NamesA ptr
#endif ''UNICODE

type SEC_GET_KEY_FN as sub ()
type FREE_CREDENTIALS_HANDLE_FN as function (byval as PCredHandle) as SECURITY_STATUS
type ACCEPT_SECURITY_CONTEXT_FN as function (byval as PCredHandle, byval as PCtxtHandle, byval as PSecBufferDesc, byval as ULONG, byval as ULONG, byval as PCtxtHandle, byval as PSecBufferDesc, byval as PULONG, byval as PTimeStamp) as SECURITY_STATUS
type COMPLETE_AUTH_TOKEN_FN as function (byval as PCtxtHandle, byval as PSecBufferDesc) as SECURITY_STATUS
type DELETE_SECURITY_CONTEXT_FN as function (byval as PCtxtHandle) as SECURITY_STATUS
type IMPERSONATE_SECURITY_CONTEXT_FN as function (byval as PCtxtHandle) as SECURITY_STATUS
type REVERT_SECURITY_CONTEXT_FN as function (byval as PCtxtHandle) as SECURITY_STATUS
type MAKE_SIGNATURE_FN as function (byval as PCtxtHandle, byval as ULONG, byval as PSecBufferDesc, byval as ULONG) as SECURITY_STATUS
type VERIFY_SIGNATURE_FN as function (byval as PCtxtHandle, byval as PSecBufferDesc, byval as ULONG, byval as PULONG) as SECURITY_STATUS
type FREE_CONTEXT_BUFFER_FN as function (byval as PVOID) as SECURITY_STATUS
type ENCRYPT_MESSAGE_FN as function (byval as PCtxtHandle, byval as ULONG, byval as PSecBufferDesc, byval as ULONG) as SECURITY_STATUS
type DECRYPT_MESSAGE_FN as function (byval as PCtxtHandle, byval as PSecBufferDesc, byval as ULONG, byval as PULONG) as SECURITY_STATUS

#ifdef UNICODE
type ENUMERATE_SECURITY_PACKAGES_FN_W as function (byval as PULONG, byval as PSecPkgInfoW ptr) as SECURITY_STATUS
type QUERY_CREDENTIALS_ATTRIBUTES_FN_W as function (byval as PCredHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
type ACQUIRE_CREDENTIALS_HANDLE_FN_W as function (byval as SEC_WCHAR ptr, byval as SEC_WCHAR ptr, byval as ULONG, byval as PLUID, byval as PVOID, byval as SEC_GET_KEY_FN, byval as PVOID, byval as PCredHandle, byval as PTimeStamp) as SECURITY_STATUS
type INITIALIZE_SECURITY_CONTEXT_FN_W as function (byval as PCredHandle, byval as PCtxtHandle, byval as SEC_WCHAR ptr, byval as ULONG, byval as ULONG, byval as ULONG, byval as PSecBufferDesc, byval as ULONG, byval as PCtxtHandle, byval as PSecBufferDesc, byval as PULONG, byval as PTimeStamp) as SECURITY_STATUS
type APPLY_CONTROL_TOKEN_FN_W as function (byval as PCtxtHandle, byval as PSecBufferDesc) as SECURITY_STATUS
type QUERY_CONTEXT_ATTRIBUTES_FN_W as function (byval as PCtxtHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
type QUERY_SECURITY_PACKAGE_INFO_FN_W as function (byval as SEC_WCHAR ptr, byval as PSecPkgInfoW ptr) as SECURITY_STATUS
#endif
type ENUMERATE_SECURITY_PACKAGES_FN_A as function (byval as PULONG, byval as PSecPkgInfoA ptr) as SECURITY_STATUS
type QUERY_CREDENTIALS_ATTRIBUTES_FN_A as function (byval as PCredHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
type ACQUIRE_CREDENTIALS_HANDLE_FN_A as function (byval as SEC_CHAR ptr, byval as SEC_CHAR ptr, byval as ULONG, byval as PLUID, byval as PVOID, byval as SEC_GET_KEY_FN, byval as PVOID, byval as PCredHandle, byval as PTimeStamp) as SECURITY_STATUS
type INITIALIZE_SECURITY_CONTEXT_FN_A as function (byval as PCredHandle, byval as PCtxtHandle, byval as SEC_CHAR ptr, byval as ULONG, byval as ULONG, byval as ULONG, byval as PSecBufferDesc, byval as ULONG, byval as PCtxtHandle, byval as PSecBufferDesc, byval as PULONG, byval as PTimeStamp) as SECURITY_STATUS
type APPLY_CONTROL_TOKEN_FN_A as function (byval as PCtxtHandle, byval as PSecBufferDesc) as SECURITY_STATUS
type QUERY_CONTEXT_ATTRIBUTES_FN_A as function (byval as PCtxtHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
type QUERY_SECURITY_PACKAGE_INFO_FN_A as function (byval as SEC_CHAR ptr, byval as PSecPkgInfoA ptr) as SECURITY_STATUS


#ifdef UNICODE
type SecurityFunctionTableW
	dwVersion as uinteger
	EnumerateSecurityPackagesW as ENUMERATE_SECURITY_PACKAGES_FN_W
	QueryCredentialsAttributesW as QUERY_CREDENTIALS_ATTRIBUTES_FN_W
	AcquireCredentialsHandleW as ACQUIRE_CREDENTIALS_HANDLE_FN_W
	FreeCredentialsHandle as FREE_CREDENTIALS_HANDLE_FN
	Reserved2 as any ptr
	InitializeSecurityContextA as INITIALIZE_SECURITY_CONTEXT_FN_A
	AcceptSecurityContext as ACCEPT_SECURITY_CONTEXT_FN
	CompleteAuthToken as COMPLETE_AUTH_TOKEN_FN
	DeleteSecurityContext as DELETE_SECURITY_CONTEXT_FN
	ApplyControlTokenW as APPLY_CONTROL_TOKEN_FN_W
	QueryContextAttributesW as QUERY_CONTEXT_ATTRIBUTES_FN_W
	ImpersonateSecurityContext as IMPERSONATE_SECURITY_CONTEXT_FN
	RevertSecurityContext as REVERT_SECURITY_CONTEXT_FN
	MakeSignature as MAKE_SIGNATURE_FN
	VerifySignature as VERIFY_SIGNATURE_FN
	FreeContextBuffer as FREE_CONTEXT_BUFFER_FN
	QuerySecurityPackageInfoA as QUERY_SECURITY_PACKAGE_INFO_FN_A
	Reserved3 as any ptr
	Reserved4 as any ptr
	Unknown1 as any ptr
	Unknown2 as any ptr
	Unknown3 as any ptr
	Unknown4 as any ptr
	Unknown5 as any ptr
	EncryptMessage as ENCRYPT_MESSAGE_FN
	DecryptMessage as DECRYPT_MESSAGE_FN
end type

type PSecurityFunctionTableW as SecurityFunctionTableW ptr
type INIT_SECURITY_INTERFACE_W as function () as PSecurityFunctionTableW

#else ''UNICODE
type SecurityFunctionTableA
	dwVersion as uinteger
	EnumerateSecurityPackagesA as ENUMERATE_SECURITY_PACKAGES_FN_A
	QueryCredentialsAttributesA as QUERY_CREDENTIALS_ATTRIBUTES_FN_A
	AcquireCredentialsHandleA as ACQUIRE_CREDENTIALS_HANDLE_FN_A
	FreeCredentialsHandle as FREE_CREDENTIALS_HANDLE_FN
	Reserved2 as any ptr
	InitializeSecurityContextA as INITIALIZE_SECURITY_CONTEXT_FN_A
	AcceptSecurityContext as ACCEPT_SECURITY_CONTEXT_FN
	CompleteAuthToken as COMPLETE_AUTH_TOKEN_FN
	DeleteSecurityContext as DELETE_SECURITY_CONTEXT_FN
	ApplyControlTokenA as APPLY_CONTROL_TOKEN_FN_A
	QueryContextAttributesA as QUERY_CONTEXT_ATTRIBUTES_FN_A
	ImpersonateSecurityContext as IMPERSONATE_SECURITY_CONTEXT_FN
	RevertSecurityContext as REVERT_SECURITY_CONTEXT_FN
	MakeSignature as MAKE_SIGNATURE_FN
	VerifySignature as VERIFY_SIGNATURE_FN
	FreeContextBuffer as FREE_CONTEXT_BUFFER_FN
	QuerySecurityPackageInfoA as QUERY_SECURITY_PACKAGE_INFO_FN_A
	Reserved3 as any ptr
	Reserved4 as any ptr
	Unknown1 as any ptr
	Unknown2 as any ptr
	Unknown3 as any ptr
	Unknown4 as any ptr
	Unknown5 as any ptr
	EncryptMessage as ENCRYPT_MESSAGE_FN
	DecryptMessage as DECRYPT_MESSAGE_FN
end type

type PSecurityFunctionTableA as SecurityFunctionTableA ptr
type INIT_SECURITY_INTERFACE_A as function () as PSecurityFunctionTableA
#endif ''UNICODE

declare function FreeCredentialsHandle alias "FreeCredentialsHandle" (byval as PCredHandle) as SECURITY_STATUS
declare function AcceptSecurityContext alias "AcceptSecurityContext" (byval as PCredHandle, byval as PCtxtHandle, byval as PSecBufferDesc, byval as ULONG, byval as ULONG, byval as PCtxtHandle, byval as PSecBufferDesc, byval as PULONG, byval as PTimeStamp) as SECURITY_STATUS
declare function FreeContextBuffer alias "FreeContextBuffer" (byval as PVOID) as SECURITY_STATUS
declare function DecryptMessage alias "DecryptMessage" (byval as PCtxtHandle, byval as PSecBufferDesc, byval as ULONG, byval as PULONG) as SECURITY_STATUS
declare function EncryptMessage alias "EncryptMessage" (byval as PCtxtHandle, byval as ULONG, byval as PSecBufferDesc, byval as ULONG) as SECURITY_STATUS
declare function DeleteSecurityContext alias "DeleteSecurityContext" (byval as PCtxtHandle) as SECURITY_STATUS
declare function CompleteAuthToken alias "CompleteAuthToken" (byval as PCtxtHandle, byval as PSecBufferDesc) as SECURITY_STATUS
declare function ImpersonateSecurityContext alias "ImpersonateSecurityContext" (byval as PCtxtHandle) as SECURITY_STATUS
declare function RevertSecurityContext alias "RevertSecurityContext" (byval as PCtxtHandle) as SECURITY_STATUS
declare function MakeSignature alias "MakeSignature" (byval as PCtxtHandle, byval as ULONG, byval as PSecBufferDesc, byval as ULONG) as SECURITY_STATUS
declare function VerifySignature alias "VerifySignature" (byval as PCtxtHandle, byval as PSecBufferDesc, byval as ULONG, byval as PULONG) as SECURITY_STATUS

#ifdef UNICODE
declare function EnumerateSecurityPackages alias "EnumerateSecurityPackagesW" (byval as PULONG, byval as PSecPkgInfoW ptr) as SECURITY_STATUS
declare function AcquireCredentialsHandle alias "AcquireCredentialsHandleW" (byval as SEC_WCHAR ptr, byval as SEC_WCHAR ptr, byval as ULONG, byval as PLUID, byval as PVOID, byval as SEC_GET_KEY_FN, byval as PVOID, byval as PCredHandle, byval as PTimeStamp) as SECURITY_STATUS
declare function InitializeSecurityContext alias "InitializeSecurityContextW" (byval as PCredHandle, byval as PCtxtHandle, byval as SEC_WCHAR ptr, byval as ULONG, byval as ULONG, byval as ULONG, byval as PSecBufferDesc, byval as ULONG, byval as PCtxtHandle, byval as PSecBufferDesc, byval as PULONG, byval as PTimeStamp) as SECURITY_STATUS
declare function QueryContextAttributes alias "QueryContextAttributesW" (byval as PCtxtHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
declare function QueryCredentialsAttributes alias "QueryCredentialsAttributesW" (byval as PCredHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
declare function ApplyControlToken alias "ApplyControlTokenW" (byval as PCtxtHandle, byval as PSecBufferDesc) as SECURITY_STATUS
declare function QuerySecurityPackageInfo alias "QuerySecurityPackageInfoW" (byval as SEC_WCHAR ptr, byval as PSecPkgInfoW ptr) as SECURITY_STATUS
declare function InitSecurityInterface alias "InitSecurityInterfaceW" () as PSecurityFunctionTableW

type ENUMERATE_SECURITY_PACKAGES_FN as ENUMERATE_SECURITY_PACKAGES_FN_W
type QUERY_CREDENTIALS_ATTRIBUTES_FN as QUERY_CREDENTIALS_ATTRIBUTES_FN_W
type ACQUIRE_CREDENTIALS_HANDLE_FN as ACQUIRE_CREDENTIALS_HANDLE_FN_W
type INITIALIZE_SECURITY_CONTEXT_FN as INITIALIZE_SECURITY_CONTEXT_FN_W
type APPLY_CONTROL_TOKEN_FN as APPLY_CONTROL_TOKEN_FN_W
type QUERY_CONTEXT_ATTRIBUTES_FN as QUERY_CONTEXT_ATTRIBUTES_FN_W
type QUERY_SECURITY_PACKAGE_INFO_FN as QUERY_SECURITY_PACKAGE_INFO_FN_W
type INIT_SECURITY_INTERFACE as INIT_SECURITY_INTERFACE_W

#else ''UNICODE
declare function EnumerateSecurityPackages alias "EnumerateSecurityPackagesA" (byval as PULONG, byval as PSecPkgInfoA ptr) as SECURITY_STATUS
declare function AcquireCredentialsHandle alias "AcquireCredentialsHandleA" (byval as SEC_CHAR ptr, byval as SEC_CHAR ptr, byval as ULONG, byval as PLUID, byval as PVOID, byval as SEC_GET_KEY_FN, byval as PVOID, byval as PCredHandle, byval as PTimeStamp) as SECURITY_STATUS
declare function InitializeSecurityContext alias "InitializeSecurityContextA" (byval as PCredHandle, byval as PCtxtHandle, byval as SEC_CHAR ptr, byval as ULONG, byval as ULONG, byval as ULONG, byval as PSecBufferDesc, byval as ULONG, byval as PCtxtHandle, byval as PSecBufferDesc, byval as PULONG, byval as PTimeStamp) as SECURITY_STATUS
declare function QueryContextAttributes alias "QueryContextAttributesA" (byval as PCtxtHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
declare function QueryCredentialsAttributes alias "QueryCredentialsAttributesA" (byval as PCredHandle, byval as ULONG, byval as PVOID) as SECURITY_STATUS
declare function ApplyControlToken alias "ApplyControlTokenA" (byval as PCtxtHandle, byval as PSecBufferDesc) as SECURITY_STATUS
declare function QuerySecurityPackageInfo alias "QuerySecurityPackageInfoA" (byval as SEC_CHAR ptr, byval as PSecPkgInfoA ptr) as SECURITY_STATUS
declare function InitSecurityInterface alias "InitSecurityInterfaceA" () as PSecurityFunctionTableA

type ENUMERATE_SECURITY_PACKAGES_FN as ENUMERATE_SECURITY_PACKAGES_FN_A
type QUERY_CREDENTIALS_ATTRIBUTES_FN as QUERY_CREDENTIALS_ATTRIBUTES_FN_A
type ACQUIRE_CREDENTIALS_HANDLE_FN as ACQUIRE_CREDENTIALS_HANDLE_FN_A
type INITIALIZE_SECURITY_CONTEXT_FN as INITIALIZE_SECURITY_CONTEXT_FN_A
type APPLY_CONTROL_TOKEN_FN as APPLY_CONTROL_TOKEN_FN_A
type QUERY_CONTEXT_ATTRIBUTES_FN as QUERY_CONTEXT_ATTRIBUTES_FN_A
type QUERY_SECURITY_PACKAGE_INFO_FN as QUERY_SECURITY_PACKAGE_INFO_FN_A
type INIT_SECURITY_INTERFACE as INIT_SECURITY_INTERFACE_A

#endif ''UNICODE

#endif
