''
''
'' schannel -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_schannel_bi__
#define __win_schannel_bi__

#include once "win/wincrypt.bi"

#define SCHANNEL_CRED_VERSION 4
#define SCHANNEL_SHUTDOWN 1
#define AUTHTYPE_CLIENT 1
#define AUTHTYPE_SERVER 2
#define SP_PROT_TLS1_CLIENT 128
#define SP_PROT_TLS1_SERVER 64
#define SP_PROT_SSL3_CLIENT 32
#define SP_PROT_SSL3_SERVER 16
#define SP_PROT_SSL2_CLIENT 8
#define SP_PROT_SSL2_SERVER 4
#define SP_PROT_PCT1_SERVER 1
#define SP_PROT_PCT1_CLIENT 2
#define SP_PROT_PCT1 (2 or 1)
#define SP_PROT_TLS1 (128 or 64)
#define SP_PROT_SSL2 (8 or 4)
#define SP_PROT_SSL3 (32 or 16)
#define SCH_CRED_NO_SYSTEM_MAPPER 2
#define SCH_CRED_NO_SERVERNAME_CHECK 4
#define SCH_CRED_MANUAL_CRED_VALIDATION 8
#define SCH_CRED_NO_DEFAULT_CREDS 16
#define SCH_CRED_AUTO_CRED_VALIDATION 32
#define SCH_CRED_REVOCATION_CHECK_CHAIN 512
#define SCH_CRED_REVOCATION_CHECK_END_CERT 256
#define SCH_CRED_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT 1024
#define SCH_CRED_IGNORE_NO_REVOCATION_CHECK 2048
#define SCH_CRED_IGNORE_REVOCATION_OFFLINE 4096
#define SCH_CRED_USE_DEFAULT_CREDS 64

type SCHANNEL_CRED
	dwVersion as DWORD
	cCreds as DWORD
	paCred as PCCERT_CONTEXT ptr
	hRootStore as HCERTSTORE
	cMappers as DWORD
	aphMappers as any ptr ptr
	cSupportedAlgs as DWORD
	palgSupportedAlgs as ALG_ID ptr
	grbitEnabledProtocols as DWORD
	dwMinimumCypherStrength as DWORD
	dwMaximumCypherStrength as DWORD
	dwSessionLifespan as DWORD
	dwFlags as DWORD
	reserved as DWORD
end type

type PSCHANNEL_CRED as SCHANNEL_CRED ptr

type SecPkgCred_SupportedAlgs
	cSupportedAlgs as DWORD
	palgSupportedAlgs as ALG_ID ptr
end type

type PSecPkgCred_SupportedAlgs as SecPkgCred_SupportedAlgs ptr

type SecPkgCred_CypherStrengths
	dwMinimumCypherStrength as DWORD
	dwMaximumCypherStrength as DWORD
end type

type PSecPkgCred_CypherStrengths as SecPkgCred_CypherStrengths ptr

type SecPkgCred_SupportedProtocols
	grbitProtocol as DWORD
end type

type PSecPkgCred_SupportedProtocols as SecPkgCred_SupportedProtocols ptr

type SecPkgContext_IssuerListInfoEx
	aIssuers as PCERT_NAME_BLOB
	cIssuers as DWORD
end type

type PSecPkgContext_IssuerListInfoEx as SecPkgContext_IssuerListInfoEx ptr

type SecPkgContext_ConnectionInfo
	dwProtocol as DWORD
	aiCipher as ALG_ID
	dwCipherStrength as DWORD
	aiHash as ALG_ID
	dwHashStrength as DWORD
	aiExch as ALG_ID
	dwExchStrength as DWORD
end type

type PSecPkgContext_ConnectionInfo as SecPkgContext_ConnectionInfo ptr

#endif
