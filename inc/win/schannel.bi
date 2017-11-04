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
#include once "wincrypt.bi"

extern "C"

#define __SCHANNEL_H__
#define UNISP_NAME_A "Microsoft Unified Security Protocol Provider"
#define UNISP_NAME_W wstr("Microsoft Unified Security Protocol Provider")
#define SSL2SP_NAME_A "Microsoft SSL 2.0"
#define SSL2SP_NAME_W wstr("Microsoft SSL 2.0")
#define SSL3SP_NAME_A "Microsoft SSL 3.0"
#define SSL3SP_NAME_W wstr("Microsoft SSL 3.0")
#define TLS1SP_NAME_A "Microsoft TLS 1.0"
#define TLS1SP_NAME_W wstr("Microsoft TLS 1.0")
#define PCT1SP_NAME_A "Microsoft PCT 1.0"
#define PCT1SP_NAME_W wstr("Microsoft PCT 1.0")
#define SCHANNEL_NAME_A "Schannel"
#define SCHANNEL_NAME_W wstr("Schannel")

#ifdef UNICODE
	#define UNISP_NAME UNISP_NAME_W
	#define PCT1SP_NAME PCT1SP_NAME_W
	#define SSL2SP_NAME SSL2SP_NAME_W
	#define SSL3SP_NAME SSL3SP_NAME_W
	#define TLS1SP_NAME TLS1SP_NAME_W
	#define SCHANNEL_NAME SCHANNEL_NAME_W
#else
	#define UNISP_NAME UNISP_NAME_A
	#define PCT1SP_NAME PCT1SP_NAME_A
	#define SSL2SP_NAME SSL2SP_NAME_A
	#define SSL3SP_NAME SSL3SP_NAME_A
	#define TLS1SP_NAME TLS1SP_NAME_A
	#define SCHANNEL_NAME SCHANNEL_NAME_A
#endif

const UNISP_RPC_ID = 14
const SECPKG_ATTR_ISSUER_LIST = &h50
const SECPKG_ATTR_REMOTE_CRED = &h51
const SECPKG_ATTR_LOCAL_CRED = &h52
const SECPKG_ATTR_REMOTE_CERT_CONTEXT = &h53
const SECPKG_ATTR_LOCAL_CERT_CONTEXT = &h54
const SECPKG_ATTR_ROOT_STORE = &h55
const SECPKG_ATTR_SUPPORTED_ALGS = &h56
const SECPKG_ATTR_CIPHER_STRENGTHS = &h57
const SECPKG_ATTR_SUPPORTED_PROTOCOLS = &h58
const SECPKG_ATTR_ISSUER_LIST_EX = &h59
const SECPKG_ATTR_CONNECTION_INFO = &h5a
const SECPKG_ATTR_EAP_KEY_BLOCK = &h5b
const SECPKG_ATTR_MAPPED_CRED_ATTR = &h5c
const SECPKG_ATTR_SESSION_INFO = &h5d
const SECPKG_ATTR_APP_DATA = &h5e

type _SecPkgContext_IssuerListInfo
	cbIssuerList as DWORD
	pIssuerList as PBYTE
end type

type SecPkgContext_IssuerListInfo as _SecPkgContext_IssuerListInfo
type PSecPkgContext_IssuerListInfo as _SecPkgContext_IssuerListInfo ptr

type _SecPkgContext_RemoteCredentialInfo
	cbCertificateChain as DWORD
	pbCertificateChain as PBYTE
	cCertificates as DWORD
	fFlags as DWORD
	dwBits as DWORD
end type

type SecPkgContext_RemoteCredentialInfo as _SecPkgContext_RemoteCredentialInfo
type PSecPkgContext_RemoteCredentialInfo as _SecPkgContext_RemoteCredentialInfo ptr
type SecPkgContext_RemoteCredenitalInfo as SecPkgContext_RemoteCredentialInfo
type PSecPkgContext_RemoteCredenitalInfo as SecPkgContext_RemoteCredentialInfo ptr

const RCRED_STATUS_NOCRED = &h00000000
const RCRED_CRED_EXISTS = &h00000001
const RCRED_STATUS_UNKNOWN_ISSUER = &h00000002

type _SecPkgContext_LocalCredentialInfo
	cbCertificateChain as DWORD
	pbCertificateChain as PBYTE
	cCertificates as DWORD
	fFlags as DWORD
	dwBits as DWORD
end type

type SecPkgContext_LocalCredentialInfo as _SecPkgContext_LocalCredentialInfo
type PSecPkgContext_LocalCredentialInfo as _SecPkgContext_LocalCredentialInfo ptr
type SecPkgContext_LocalCredenitalInfo as SecPkgContext_LocalCredentialInfo
type PSecPkgContext_LocalCredenitalInfo as SecPkgContext_LocalCredentialInfo ptr

const LCRED_STATUS_NOCRED = &h00000000
const LCRED_CRED_EXISTS = &h00000001
const LCRED_STATUS_UNKNOWN_ISSUER = &h00000002

type _SecPkgCred_SupportedAlgs
	cSupportedAlgs as DWORD
	palgSupportedAlgs as ALG_ID ptr
end type

type SecPkgCred_SupportedAlgs as _SecPkgCred_SupportedAlgs
type PSecPkgCred_SupportedAlgs as _SecPkgCred_SupportedAlgs ptr

type _SecPkgCred_CipherStrengths
	dwMinimumCipherStrength as DWORD
	dwMaximumCipherStrength as DWORD
end type

type SecPkgCred_CipherStrengths as _SecPkgCred_CipherStrengths
type PSecPkgCred_CipherStrengths as _SecPkgCred_CipherStrengths ptr

type _SecPkgCred_SupportedProtocols
	grbitProtocol as DWORD
end type

type SecPkgCred_SupportedProtocols as _SecPkgCred_SupportedProtocols
type PSecPkgCred_SupportedProtocols as _SecPkgCred_SupportedProtocols ptr

type _SecPkgContext_IssuerListInfoEx
	aIssuers as PCERT_NAME_BLOB
	cIssuers as DWORD
end type

type SecPkgContext_IssuerListInfoEx as _SecPkgContext_IssuerListInfoEx
type PSecPkgContext_IssuerListInfoEx as _SecPkgContext_IssuerListInfoEx ptr

type _SecPkgContext_ConnectionInfo
	dwProtocol as DWORD
	aiCipher as ALG_ID
	dwCipherStrength as DWORD
	aiHash as ALG_ID
	dwHashStrength as DWORD
	aiExch as ALG_ID
	dwExchStrength as DWORD
end type

type SecPkgContext_ConnectionInfo as _SecPkgContext_ConnectionInfo
type PSecPkgContext_ConnectionInfo as _SecPkgContext_ConnectionInfo ptr

type _SecPkgContext_EapKeyBlock
	rgbKeys(0 to 127) as UBYTE
	rgbIVs(0 to 63) as UBYTE
end type

type SecPkgContext_EapKeyBlock as _SecPkgContext_EapKeyBlock
type PSecPkgContext_EapKeyBlock as _SecPkgContext_EapKeyBlock ptr

type _SecPkgContext_MappedCredAttr
	dwAttribute as DWORD
	pvBuffer as PVOID
end type

type SecPkgContext_MappedCredAttr as _SecPkgContext_MappedCredAttr
type PSecPkgContext_MappedCredAttr as _SecPkgContext_MappedCredAttr ptr
const SSL_SESSION_RECONNECT = 1

type _SecPkgContext_SessionInfo
	dwFlags as DWORD
	cbSessionId as DWORD
	rgbSessionId(0 to 31) as UBYTE
end type

type SecPkgContext_SessionInfo as _SecPkgContext_SessionInfo
type PSecPkgContext_SessionInfo as _SecPkgContext_SessionInfo ptr

type _SecPkgContext_SessionAppData
	dwFlags as DWORD
	cbAppData as DWORD
	pbAppData as PBYTE
end type

type SecPkgContext_SessionAppData as _SecPkgContext_SessionAppData
type PSecPkgContext_SessionAppData as _SecPkgContext_SessionAppData ptr
const SCH_CRED_V1 = &h00000001
const SCH_CRED_V2 = &h00000002
const SCH_CRED_VERSION = &h00000002
const SCH_CRED_V3 = &h00000003
const SCHANNEL_CRED_VERSION = &h00000004
type _HMAPPER as _HMAPPER_

type _SCHANNEL_CRED
	dwVersion as DWORD
	cCreds as DWORD
	paCred as PCCERT_CONTEXT ptr
	hRootStore as HCERTSTORE
	cMappers as DWORD
	aphMappers as _HMAPPER ptr ptr
	cSupportedAlgs as DWORD
	palgSupportedAlgs as ALG_ID ptr
	grbitEnabledProtocols as DWORD
	dwMinimumCipherStrength as DWORD
	dwMaximumCipherStrength as DWORD
	dwSessionLifespan as DWORD
	dwFlags as DWORD
	dwCredFormat as DWORD
end type

type SCHANNEL_CRED as _SCHANNEL_CRED
type PSCHANNEL_CRED as _SCHANNEL_CRED ptr
const SCH_CRED_FORMAT_CERT_HASH = &h00000001
const SCH_CRED_MAX_SUPPORTED_ALGS = 256
const SCH_CRED_MAX_SUPPORTED_CERTS = 100

type _SCHANNEL_CERT_HASH
	dwLength as DWORD
	dwFlags as DWORD
	hProv as HCRYPTPROV
	ShaHash(0 to 19) as UBYTE
end type

type SCHANNEL_CERT_HASH as _SCHANNEL_CERT_HASH
type PSCHANNEL_CERT_HASH as _SCHANNEL_CERT_HASH ptr
const SCH_MACHINE_CERT_HASH = &h00000001
const SCH_CRED_NO_SYSTEM_MAPPER = &h00000002
const SCH_CRED_NO_SERVERNAME_CHECK = &h00000004
const SCH_CRED_MANUAL_CRED_VALIDATION = &h00000008
const SCH_CRED_NO_DEFAULT_CREDS = &h00000010
const SCH_CRED_AUTO_CRED_VALIDATION = &h00000020
const SCH_CRED_USE_DEFAULT_CREDS = &h00000040
const SCH_CRED_DISABLE_RECONNECTS = &h00000080
const SCH_CRED_REVOCATION_CHECK_END_CERT = &h00000100
const SCH_CRED_REVOCATION_CHECK_CHAIN = &h00000200
const SCH_CRED_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = &h00000400
const SCH_CRED_IGNORE_NO_REVOCATION_CHECK = &h00000800
const SCH_CRED_IGNORE_REVOCATION_OFFLINE = &h00001000
const SCH_CRED_REVOCATION_CHECK_CACHE_ONLY = &h00004000
const SCH_CRED_CACHE_ONLY_URL_RETRIEVAL = &h00008000
const SCHANNEL_RENEGOTIATE = 0
const SCHANNEL_SHUTDOWN = 1
const SCHANNEL_ALERT = 2
const SCHANNEL_SESSION = 3

type _SCHANNEL_ALERT_TOKEN
	dwTokenType as DWORD
	dwAlertType as DWORD
	dwAlertNumber as DWORD
end type

type SCHANNEL_ALERT_TOKEN as _SCHANNEL_ALERT_TOKEN
const TLS1_ALERT_WARNING = 1
const TLS1_ALERT_FATAL = 2
const TLS1_ALERT_CLOSE_NOTIFY = 0
const TLS1_ALERT_UNEXPECTED_MESSAGE = 10
const TLS1_ALERT_BAD_RECORD_MAC = 20
const TLS1_ALERT_DECRYPTION_FAILED = 21
const TLS1_ALERT_RECORD_OVERFLOW = 22
const TLS1_ALERT_DECOMPRESSION_FAIL = 30
const TLS1_ALERT_HANDSHAKE_FAILURE = 40
const TLS1_ALERT_BAD_CERTIFICATE = 42
const TLS1_ALERT_UNSUPPORTED_CERT = 43
const TLS1_ALERT_CERTIFICATE_REVOKED = 44
const TLS1_ALERT_CERTIFICATE_EXPIRED = 45
const TLS1_ALERT_CERTIFICATE_UNKNOWN = 46
const TLS1_ALERT_ILLEGAL_PARAMETER = 47
const TLS1_ALERT_UNKNOWN_CA = 48
const TLS1_ALERT_ACCESS_DENIED = 49
const TLS1_ALERT_DECODE_ERROR = 50
const TLS1_ALERT_DECRYPT_ERROR = 51
const TLS1_ALERT_EXPORT_RESTRICTION = 60
const TLS1_ALERT_PROTOCOL_VERSION = 70
const TLS1_ALERT_INSUFFIENT_SECURITY = 71
const TLS1_ALERT_INTERNAL_ERROR = 80
const TLS1_ALERT_USER_CANCELED = 90
const TLS1_ALERT_NO_RENEGOTIATATION = 100
const SSL_SESSION_ENABLE_RECONNECTS = 1
const SSL_SESSION_DISABLE_RECONNECTS = 2

type _SCHANNEL_SESSION_TOKEN
	dwTokenType as DWORD
	dwFlags as DWORD
end type

type SCHANNEL_SESSION_TOKEN as _SCHANNEL_SESSION_TOKEN
const CERT_SCHANNEL_IIS_PRIVATE_KEY_PROP_ID = CERT_FIRST_USER_PROP_ID + 0
const CERT_SCHANNEL_IIS_PASSWORD_PROP_ID = CERT_FIRST_USER_PROP_ID + 1
const CERT_SCHANNEL_SGC_CERTIFICATE_PROP_ID = CERT_FIRST_USER_PROP_ID + 2
const SP_PROT_PCT1_SERVER = &h00000001
const SP_PROT_PCT1_CLIENT = &h00000002
const SP_PROT_PCT1 = SP_PROT_PCT1_SERVER or SP_PROT_PCT1_CLIENT
const SP_PROT_SSL2_SERVER = &h00000004
const SP_PROT_SSL2_CLIENT = &h00000008
const SP_PROT_SSL2 = SP_PROT_SSL2_SERVER or SP_PROT_SSL2_CLIENT
const SP_PROT_SSL3_SERVER = &h00000010
const SP_PROT_SSL3_CLIENT = &h00000020
const SP_PROT_SSL3 = SP_PROT_SSL3_SERVER or SP_PROT_SSL3_CLIENT
const SP_PROT_TLS1_SERVER = &h00000040
const SP_PROT_TLS1_CLIENT = &h00000080
const SP_PROT_TLS1 = SP_PROT_TLS1_SERVER or SP_PROT_TLS1_CLIENT
const SP_PROT_SSL3TLS1_CLIENTS = SP_PROT_TLS1_CLIENT or SP_PROT_SSL3_CLIENT
const SP_PROT_SSL3TLS1_SERVERS = SP_PROT_TLS1_SERVER or SP_PROT_SSL3_SERVER
const SP_PROT_SSL3TLS1 = SP_PROT_SSL3 or SP_PROT_TLS1
const SP_PROT_UNI_SERVER = &h40000000
const SP_PROT_UNI_CLIENT = &h80000000
const SP_PROT_UNI = SP_PROT_UNI_SERVER or SP_PROT_UNI_CLIENT
const SP_PROT_ALL = &hffffffff
const SP_PROT_NONE = 0
const SP_PROT_CLIENTS = (((SP_PROT_PCT1_CLIENT or SP_PROT_SSL2_CLIENT) or SP_PROT_SSL3_CLIENT) or SP_PROT_UNI_CLIENT) or SP_PROT_TLS1_CLIENT
const SP_PROT_SERVERS = (((SP_PROT_PCT1_SERVER or SP_PROT_SSL2_SERVER) or SP_PROT_SSL3_SERVER) or SP_PROT_UNI_SERVER) or SP_PROT_TLS1_SERVER
type SSL_EMPTY_CACHE_FN_A as function(byval pszTargetName as LPSTR, byval dwFlags as DWORD) as WINBOOL
declare function SslEmptyCacheA(byval pszTargetName as LPSTR, byval dwFlags as DWORD) as WINBOOL
type SSL_EMPTY_CACHE_FN_W as function(byval pszTargetName as LPWSTR, byval dwFlags as DWORD) as WINBOOL
declare function SslEmptyCacheW(byval pszTargetName as LPWSTR, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	type SSL_EMPTY_CACHE_FN as SSL_EMPTY_CACHE_FN_W
	declare function SslEmptyCache alias "SslEmptyCacheW"(byval pszTargetName as LPWSTR, byval dwFlags as DWORD) as WINBOOL
#else
	type SSL_EMPTY_CACHE_FN as SSL_EMPTY_CACHE_FN_A
	declare function SslEmptyCache alias "SslEmptyCacheA"(byval pszTargetName as LPSTR, byval dwFlags as DWORD) as WINBOOL
#endif

type _SSL_CREDENTIAL_CERTIFICATE
	cbPrivateKey as DWORD
	pPrivateKey as PBYTE
	cbCertificate as DWORD
	pCertificate as PBYTE
	pszPassword as PSTR
end type

type SSL_CREDENTIAL_CERTIFICATE as _SSL_CREDENTIAL_CERTIFICATE
type PSSL_CREDENTIAL_CERTIFICATE as _SSL_CREDENTIAL_CERTIFICATE ptr
const SCHANNEL_SECRET_TYPE_CAPI = &h00000001
const SCHANNEL_SECRET_PRIVKEY = &h00000002
const SCH_CRED_X509_CERTCHAIN = &h00000001
const SCH_CRED_X509_CAPI = &h00000002
const SCH_CRED_CERT_CONTEXT = &h00000003

type _SCH_CRED
	dwVersion as DWORD
	cCreds as DWORD
	paSecret as PVOID ptr
	paPublic as PVOID ptr
	cMappers as DWORD
	aphMappers as _HMAPPER ptr ptr
end type

type SCH_CRED as _SCH_CRED
type PSCH_CRED as _SCH_CRED ptr

type _SCH_CRED_SECRET_CAPI
	dwType as DWORD
	hProv as HCRYPTPROV
end type

type SCH_CRED_SECRET_CAPI as _SCH_CRED_SECRET_CAPI
type PSCH_CRED_SECRET_CAPI as _SCH_CRED_SECRET_CAPI ptr

type _SCH_CRED_SECRET_PRIVKEY
	dwType as DWORD
	pPrivateKey as PBYTE
	cbPrivateKey as DWORD
	pszPassword as PSTR
end type

type SCH_CRED_SECRET_PRIVKEY as _SCH_CRED_SECRET_PRIVKEY
type PSCH_CRED_SECRET_PRIVKEY as _SCH_CRED_SECRET_PRIVKEY ptr

type _SCH_CRED_PUBLIC_CERTCHAIN
	dwType as DWORD
	cbCertChain as DWORD
	pCertChain as PBYTE
end type

type SCH_CRED_PUBLIC_CERTCHAIN as _SCH_CRED_PUBLIC_CERTCHAIN
type PSCH_CRED_PUBLIC_CERTCHAIN as _SCH_CRED_PUBLIC_CERTCHAIN ptr

type _SCH_CRED_PUBLIC_CAPI
	dwType as DWORD
	hProv as HCRYPTPROV
end type

type SCH_CRED_PUBLIC_CAPI as _SCH_CRED_PUBLIC_CAPI
type PSCH_CRED_PUBLIC_CAPI as _SCH_CRED_PUBLIC_CAPI ptr

type _PctPublicKey
	as DWORD Type
	cbKey as DWORD
	pKey(0 to 0) as UCHAR
end type

type PctPublicKey as _PctPublicKey

type _X509Certificate
	Version as DWORD
	SerialNumber(0 to 3) as DWORD
	SignatureAlgorithm as ALG_ID
	ValidFrom as FILETIME
	ValidUntil as FILETIME
	pszIssuer as PSTR
	pszSubject as PSTR
	pPublicKey as PctPublicKey ptr
end type

type X509Certificate as _X509Certificate
type PX509Certificate as _X509Certificate ptr
declare function SslGenerateKeyPair(byval pCerts as PSSL_CREDENTIAL_CERTIFICATE, byval pszDN as PSTR, byval pszPassword as PSTR, byval Bits as DWORD) as WINBOOL
declare sub SslGenerateRandomBits(byval pRandomData as PUCHAR, byval cRandomData as LONG)
declare function SslCrackCertificate(byval pbCertificate as PUCHAR, byval cbCertificate as DWORD, byval dwFlags as DWORD, byval ppCertificate as PX509Certificate ptr) as WINBOOL
declare sub SslFreeCertificate(byval pCertificate as PX509Certificate)

#ifdef __FB_64BIT__
	declare function SslGetMaximumKeySize(byval Reserved as DWORD) as DWORD
#else
	declare function SslGetMaximumKeySize stdcall(byval Reserved as DWORD) as DWORD
#endif

declare function SslGetDefaultIssuers(byval pbIssuers as PBYTE, byval pcbIssuers as DWORD ptr) as WINBOOL
#define SSL_CRACK_CERTIFICATE_NAME __TEXT("SslCrackCertificate")
#define SSL_FREE_CERTIFICATE_NAME __TEXT("SslFreeCertificate")

#ifndef __FB_64BIT__
	type SSL_CRACK_CERTIFICATE_FN as function stdcall(byval pbCertificate as PUCHAR, byval cbCertificate as DWORD, byval VerifySignature as WINBOOL, byval ppCertificate as PX509Certificate ptr) as WINBOOL
	type SSL_FREE_CERTIFICATE_FN as sub stdcall(byval pCertificate as PX509Certificate)
#elseif defined(__FB_64BIT__) and (_WIN32_WINNT >= &h0600)
	type SSL_CRACK_CERTIFICATE_FN as function(byval pbCertificate as PUCHAR, byval cbCertificate as DWORD, byval VerifySignature as WINBOOL, byval ppCertificate as PX509Certificate ptr) as WINBOOL
	type SSL_FREE_CERTIFICATE_FN as sub(byval pCertificate as PX509Certificate)
#endif

#if _WIN32_WINNT >= &h0600
	type _SecPkgContext_EapPrfInfo
		dwVersion as DWORD
		cbPrfData as DWORD
	end type

	type SecPkgContext_EapPrfInfo as _SecPkgContext_EapPrfInfo
	type PSecPkgContext_EapPrfInfo as _SecPkgContext_EapPrfInfo ptr
#endif

#if _WIN32_WINNT >= &h0601
	type _SecPkgContext_SupportedSignatures
		cSignatureAndHashAlgorithms as WORD
		pSignatureAndHashAlgorithms as WORD ptr
	end type

	type SecPkgContext_SupportedSignatures as _SecPkgContext_SupportedSignatures
	type PSecPkgContext_SupportedSignatures as _SecPkgContext_SupportedSignatures ptr
#elseif defined(__FB_64BIT__) and (_WIN32_WINNT <= &h0502)
	type SSL_CRACK_CERTIFICATE_FN as function(byval pbCertificate as PUCHAR, byval cbCertificate as DWORD, byval VerifySignature as WINBOOL, byval ppCertificate as PX509Certificate ptr) as WINBOOL
	type SSL_FREE_CERTIFICATE_FN as sub(byval pCertificate as PX509Certificate)
#endif

end extern
