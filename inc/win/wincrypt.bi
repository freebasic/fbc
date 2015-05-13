''
''
'' wincrypt -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_wincrypt_bi__
#define __win_wincrypt_bi__

#define MS_DEF_PROV "Microsoft Base Cryptographic Provider v1.0"
#define MS_ENHANCED_PROV "Microsoft Enhanced Cryptographic Provider v1.0"
#define MS_STRONG_PROV "Microsoft Strong Cryptographic Provider"
#define MS_DEF_RSA_SIG_PROV "Microsoft RSA Signature Cryptographic Provider"
#define MS_DEF_RSA_SCHANNEL_PROV "Microsoft RSA SChannel Cryptographic Provider"
#define MS_DEF_DSS_PROV "Microsoft Base DSS Cryptographic Provider"
#define MS_DEF_DSS_DH_PROV "Microsoft Base DSS and Diffie-Hellman Cryptographic Provider"
#define MS_ENH_DSS_DH_PROV "Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider"
#define MS_DEF_DH_SCHANNEL_PROV "Microsoft DH SChannel Cryptographic Provider"
#define MS_SCARD_PROV "Microsoft Base Smart Card Crypto Provider"

#define ALG_CLASS_ANY 0
#define ALG_CLASS_SIGNATURE 8192
#define ALG_CLASS_MSG_ENCRYPT 16384
#define ALG_CLASS_DATA_ENCRYPT 24576
#define ALG_CLASS_HASH 32768
#define ALG_CLASS_KEY_EXCHANGE 40960
#define ALG_CLASS_ALL 57344
#define ALG_TYPE_ANY 0
#define ALG_TYPE_DSS 512
#define ALG_TYPE_RSA 1024
#define ALG_TYPE_BLOCK 1536
#define ALG_TYPE_STREAM 2048
#define ALG_TYPE_DH 2560
#define ALG_TYPE_SECURECHANNEL 3072
#define ALG_SID_ANY 0
#define ALG_SID_RSA_ANY 0
#define ALG_SID_RSA_PKCS 1
#define ALG_SID_RSA_MSATWORK 2
#define ALG_SID_RSA_ENTRUST 3
#define ALG_SID_RSA_PGP 4
#define ALG_SID_DSS_ANY 0
#define ALG_SID_DSS_PKCS 1
#define ALG_SID_DSS_DMS 2
#define ALG_SID_DES 1
#define ALG_SID_3DES 3
#define ALG_SID_DESX 4
#define ALG_SID_IDEA 5
#define ALG_SID_CAST 6
#define ALG_SID_SAFERSK64 7
#define ALG_SID_SAFERSK128 8
#define ALG_SID_3DES_112 9
#define ALG_SID_SKIPJACK 10
#define ALG_SID_TEK 11
#define ALG_SID_CYLINK_MEK 12
#define ALG_SID_RC5 13
#define ALG_SID_RC2 2
#define ALG_SID_RC4 1
#define ALG_SID_SEAL 2
#define ALG_SID_MD2 1
#define ALG_SID_MD4 2
#define ALG_SID_MD5 3
#define ALG_SID_SHA 4
#define ALG_SID_MAC 5
#define ALG_SID_RIPEMD 6
#define ALG_SID_RIPEMD160 7
#define ALG_SID_SSL3SHAMD5 8
#define ALG_SID_HMAC 9
#define ALG_SID_TLS1PRF 10
#define ALG_SID_AES_128 14
#define ALG_SID_AES_192 15
#define ALG_SID_AES_256 16
#define ALG_SID_AES 17
#define ALG_SID_EXAMPLE 80
#define CALG_MD2 (32768 or 0 or 1)
#define CALG_MD4 (32768 or 0 or 2)
#define CALG_MD5 (32768 or 0 or 3)
#define CALG_SHA (32768 or 0 or 4)
#define CALG_SHA1 (32768 or 0 or 4)
#define CALG_MAC (32768 or 0 or 5)
#define CALG_3DES (24576 or 1536 or 3)
#define CALG_CYLINK_MEK (24576 or 1536 or 12)
#define CALG_SKIPJACK (24576 or 1536 or 10)
#define CALG_KEA_KEYX (40960 or 2048 or 512 or 4)
#define CALG_RSA_SIGN (8192 or 1024 or 0)
#define CALG_DSS_SIGN (8192 or 512 or 0)
#define CALG_RSA_KEYX (40960 or 1024 or 0)
#define CALG_DES (24576 or 1536 or 1)
#define CALG_RC2 (24576 or 1536 or 2)
#define CALG_RC4 (24576 or 2048 or 1)
#define CALG_SEAL (24576 or 2048 or 2)
#define CALG_DH_EPHEM (40960 or 2048 or 512 or 2)
#define CALG_DESX (24576 or 1536 or 4)
#define CALG_AES_128 (24576 or 1536 or 14)
#define CALG_AES_192 (24576 or 1536 or 15)
#define CALG_AES_256 (24576 or 1536 or 16)
#define CALG_AES (24576 or 1536 or 17)
#define CRYPT_VERIFYCONTEXT &hF0000000
#define CRYPT_NEWKEYSET 8
#define CRYPT_DELETEKEYSET 16
#define CRYPT_MACHINE_KEYSET 32
#define CRYPT_SILENT 64
#define CRYPT_EXPORTABLE 1
#define CRYPT_USER_PROTECTED 2
#define CRYPT_CREATE_SALT 4
#define CRYPT_UPDATE_KEY 8
#define SIMPLEBLOB 1
#define PUBLICKEYBLOB 6
#define PRIVATEKEYBLOB 7
#define PLAINTEXTKEYBLOB 8
#define OPAQUEKEYBLOB 9
#define PUBLICKEYBLOBEX 10
#define SYMMETRICWRAPKEYBLOB 11
#define AT_KEYEXCHANGE 1
#define AT_SIGNATURE 2
#define CRYPT_USERDATA 1
#define KP_IV 1
#define KP_SALT 2
#define KP_PADDING 3
#define KP_MODE 4
#define KP_MODE_BITS 5
#define KP_PERMISSIONS 6
#define KP_ALGID 7
#define KP_BLOCKLEN 8
#define PKCS5_PADDING 1
#define CRYPT_MODE_CBC 1
#define CRYPT_MODE_ECB 2
#define CRYPT_MODE_OFB 3
#define CRYPT_MODE_CFB 4
#define CRYPT_MODE_CTS 5
#define CRYPT_MODE_CBCI 6
#define CRYPT_MODE_CFBP 7
#define CRYPT_MODE_OFBP 8
#define CRYPT_MODE_CBCOFM 9
#define CRYPT_MODE_CBCOFMI 10
#define CRYPT_ENCRYPT 1
#define CRYPT_DECRYPT 2
#define CRYPT_EXPORT 4
#define CRYPT_READ 8
#define CRYPT_WRITE 16
#define CRYPT_MAC 32
#define HP_ALGID 1
#define HP_HASHVAL 2
#define HP_HASHSIZE 4
#define HP_HMAC_INFO 5
#define CRYPT_FAILED 0
#define CRYPT_SUCCEED 1
#define RCRYPT_SUCCEEDED(r) ((r)=CRYPT_SUCCEED)
#define RCRYPT_FAILED(r) ((r)=CRYPT_FAILED)
#define PP_ENUMALGS 1
#define PP_ENUMCONTAINERS 2
#define PP_IMPTYPE 3
#define PP_NAME 4
#define PP_VERSION 5
#define PP_CONTAINER 6
#define PP_CHANGE_PASSWORD 7
#define PP_KEYSET_SEC_DESCR 8
#define PP_CERTCHAIN 9
#define PP_KEY_TYPE_SUBTYPE 10
#define PP_PROVTYPE 16
#define PP_KEYSTORAGE 17
#define PP_APPLI_CERT 18
#define PP_SYM_KEYSIZE 19
#define PP_SESSION_KEYSIZE 20
#define PP_UI_PROMPT 21
#define PP_ENUMALGS_EX 22
#define PP_ENUMMANDROOTS 25
#define PP_ENUMELECTROOTS 26
#define PP_KEYSET_TYPE 27
#define PP_ADMIN_PIN 31
#define PP_KEYEXCHANGE_PIN 32
#define PP_SIGNATURE_PIN 33
#define PP_SIG_KEYSIZE_INC 34
#define PP_KEYX_KEYSIZE_INC 35
#define PP_UNIQUE_CONTAINER 36
#define PP_SGC_INFO 37
#define PP_USE_HARDWARE_RNG 38
#define PP_KEYSPEC 39
#define PP_ENUMEX_SIGNING_PROT 40
#define CRYPT_FIRST 1
#define CRYPT_NEXT 2
#define CRYPT_IMPL_HARDWARE 1
#define CRYPT_IMPL_SOFTWARE 2
#define CRYPT_IMPL_MIXED 3
#define CRYPT_IMPL_UNKNOWN 4
#define PROV_RSA_FULL 1
#define PROV_RSA_SIG 2
#define PROV_DSS 3
#define PROV_FORTEZZA 4
#define PROV_MS_MAIL 5
#define PROV_SSL 6
#define PROV_STT_MER 7
#define PROV_STT_ACQ 8
#define PROV_STT_BRND 9
#define PROV_STT_ROOT 10
#define PROV_STT_ISS 11
#define PROV_RSA_SCHANNEL 12
#define PROV_DSS_DH 13
#define PROV_EC_ECDSA_SIG 14
#define PROV_EC_ECNRA_SIG 15
#define PROV_EC_ECDSA_FULL 16
#define PROV_EC_ECNRA_FULL 17
#define PROV_DH_SCHANNEL 18
#define PROV_SPYRUS_LYNKS 20
#define PROV_RNG 21
#define PROV_INTEL_SEC 22
#define PROV_RSA_AES 24
#define MAXUIDLEN 64
#define CUR_BLOB_VERSION 2
#define X509_ASN_ENCODING 1
#define PKCS_7_ASN_ENCODING 65536
#define CERT_V1 0
#define CERT_V2 1
#define CERT_V3 2
#define CERT_E_CHAINING (-2146762486)
#define CERT_E_CN_NO_MATCH (-2146762481)
#define CERT_E_EXPIRED (-2146762495)
#define CERT_E_PURPOSE (-2146762490)
#define CERT_E_REVOCATION_FAILURE (-2146762482)
#define CERT_E_REVOKED (-2146762484)
#define CERT_E_ROLE (-2146762493)
#define CERT_E_UNTRUSTEDROOT (-2146762487)
#define CERT_E_UNTRUSTEDTESTROOT (-2146762483)
#define CERT_E_VALIDITYPERIODNESTING (-2146762494)
#define CERT_E_WRONG_USAGE (-2146762480)
#define CERT_E_PATHLENCONST (-2146762492)
#define CERT_E_CRITICAL (-2146762491)
#define CERT_E_ISSUERCHAINING (-2146762489)
#define CERT_E_MALFORMED (-2146762488)
#define CRYPT_E_REVOCATION_OFFLINE (-2146885613)
#define CRYPT_E_REVOKED (-2146885616)
#define TRUST_E_BASIC_CONSTRAINTS (-2146869223)
#define TRUST_E_CERT_SIGNATURE (-2146869244)
#define TRUST_E_FAIL (-2146762485)
#define CERT_TRUST_NO_ERROR 0
#define CERT_TRUST_IS_NOT_TIME_VALID 1
#define CERT_TRUST_IS_NOT_TIME_NESTED 2
#define CERT_TRUST_IS_REVOKED 4
#define CERT_TRUST_IS_NOT_SIGNATURE_VALID 8
#define CERT_TRUST_IS_NOT_VALID_FOR_USAGE 16
#define CERT_TRUST_IS_UNTRUSTED_ROOT 32
#define CERT_TRUST_REVOCATION_STATUS_UNKNOWN 64
#define CERT_TRUST_IS_CYCLIC 128
#define CERT_TRUST_IS_PARTIAL_CHAIN 65536
#define CERT_TRUST_CTL_IS_NOT_TIME_VALID 131072
#define CERT_TRUST_CTL_IS_NOT_SIGNATURE_VALID 262144
#define CERT_TRUST_CTL_IS_NOT_VALID_FOR_USAGE 524288
#define CERT_TRUST_HAS_EXACT_MATCH_ISSUER 1
#define CERT_TRUST_HAS_KEY_MATCH_ISSUER 2
#define CERT_TRUST_HAS_NAME_MATCH_ISSUER 4
#define CERT_TRUST_IS_SELF_SIGNED 8
#define CERT_TRUST_IS_COMPLEX_CHAIN 65536
#define CERT_CHAIN_POLICY_BASE cptr(LPCSTR, 1)
#define CERT_CHAIN_POLICY_AUTHENTICODE  cptr(LPCSTR, 2)
#define CERT_CHAIN_POLICY_AUTHENTICODE_TS  cptr(LPCSTR, 3)
#define CERT_CHAIN_POLICY_SSL  cptr(LPCSTR, 4)
#define CERT_CHAIN_POLICY_BASIC_CONSTRAINTS cptr(LPCSTR, 5)
#define CERT_CHAIN_POLICY_NT_AUTH cptr(LPCSTR, 6)
#define USAGE_MATCH_TYPE_AND 0
#define USAGE_MATCH_TYPE_OR 1
#define CERT_SIMPLE_NAME_STR 1
#define CERT_OID_NAME_STR 2
#define CERT_X500_NAME_STR 3
#define CERT_NAME_STR_SEMICOLON_FLAG 1073741824
#define CERT_NAME_STR_CRLF_FLAG 134217728
#define CERT_NAME_STR_NO_PLUS_FLAG 536870912
#define CERT_NAME_STR_NO_QUOTING_FLAG 268435456
#define CERT_NAME_STR_REVERSE_FLAG 33554432
#define CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG 131072
#define CERT_FIND_ANY 0
#define CERT_FIND_CERT_ID 1048576
#define CERT_FIND_CTL_USAGE 655360
#define CERT_FIND_ENHKEY_USAGE 655360
#define CERT_FIND_EXISTING 851968
#define CERT_FIND_HASH 65536
#define CERT_FIND_ISSUER_ATTR 196612
#define CERT_FIND_ISSUER_NAME 131076
#define CERT_FIND_ISSUER_OF 786432
#define CERT_FIND_KEY_IDENTIFIER 983040
#define CERT_FIND_KEY_SPEC 589824
#define CERT_FIND_MD5_HASH 262144
#define CERT_FIND_PROPERTY 327680
#define CERT_FIND_PUBLIC_KEY 393216
#define CERT_FIND_SHA1_HASH 65536
#define CERT_FIND_SIGNATURE_HASH 917504
#define CERT_FIND_SUBJECT_ATTR 196615
#define CERT_FIND_SUBJECT_CERT 720896
#define CERT_FIND_SUBJECT_NAME 131079
#define CERT_FIND_SUBJECT_STR_A 458759
#define CERT_FIND_SUBJECT_STR_W 524295
#define CERT_FIND_ISSUER_STR_A 458756
#define CERT_FIND_ISSUER_STR_W 524292
#define CERT_FIND_OR_ENHKEY_USAGE_FLAG 16
#define CERT_FIND_OPTIONAL_ENHKEY_USAGE_FLAG 1
#define CERT_FIND_NO_ENHKEY_USAGE_FLAG 8
#define CERT_FIND_VALID_ENHKEY_USAGE_FLAG 32
#define CERT_FIND_EXT_ONLY_ENHKEY_USAGE_FLAG 2
#define CERT_CASE_INSENSITIVE_IS_RDN_ATTRS_FLAG 2
#define CERT_UNICODE_IS_RDN_ATTRS_FLAG 1
#define CERT_CHAIN_FIND_BY_ISSUER 1
#define CERT_CHAIN_FIND_BY_ISSUER_COMPARE_KEY_FLAG 1
#define CERT_CHAIN_FIND_BY_ISSUER_COMPLEX_CHAIN_FLAG 2
#define CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_FLAG 32768
#define CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_URL_FLAG 4
#define CERT_CHAIN_FIND_BY_ISSUER_LOCAL_MACHINE_FLAG 8
#define CERT_CHAIN_FIND_BY_ISSUER_NO_KEY_FLAG 16384
#define CERT_STORE_PROV_SYSTEM 10
#define CERT_SYSTEM_STORE_LOCAL_MACHINE 131072
#define szOID_PKIX_KP_SERVER_AUTH "4235600"
#define szOID_SERVER_GATED_CRYPTO "4235658"
#define szOID_SGC_NETSCAPE "2.16.840.1.113730.4.1"
#define szOID_PKIX_KP_CLIENT_AUTH "1.3.6.1.5.5.7.3.2"
#define CRYPT_NOHASHOID &h00000001
#define CRYPT_NO_SALT &h10
#define CRYPT_PREGEN &h40
#define CRYPT_RECIPIENT &h10
#define CRYPT_INITIATOR &h40
#define CRYPT_ONLINE &h80
#define CRYPT_SF &h100
#define CRYPT_CREATE_IV &h200
#define CRYPT_KEK &h400
#define CRYPT_DATA_KEY &h800
#define CRYPT_VOLATILE &h1000
#define CRYPT_SGCKEY &h2000
#define KP_KEYLEN &h00000009
#define KP_SALT_EX &h0000000a
#define KP_P &h000000&b
#define KP_G &h0000000c
#define KP_Q &h0000000d
#define KP_X &h0000000e
#define KP_Y &h0000000f
#define KP_RA &h00000010
#define KP_RB &h00000011
#define KP_INFO &h00000012
#define KP_EFFECTIVE_KEYLEN &h00000013
#define KP_SCHANNEL_ALG &h00000014
#define KP_PUB_PARAMS &h00000027
#define CRYPT_FLAG_PCT1 &h0001
#define CRYPT_FLAG_SSL2 &h0002
#define CRYPT_FLAG_SSL3 &h0004
#define CRYPT_FLAG_TLS1 &h0008
#define CRYPT_FLAG_IPSEC &h0010
#define CRYPT_FLAG_SIGNING &h0020
#define SCHANNEL_MAC_KEY &h00000000
#define SCHANNEL_ENC_KEY &h00000001
#define INTERNATIONAL_USAGE &h00000001

type ALG_ID as UINT

type VTableProvStruc
	FuncVerifyImage as FARPROC
end type

type PVTableProvStruc as VTableProvStruc ptr

type HCRYPTPROV as ULONG
type HCRYPTKEY as ULONG
type HCRYPTHASH as ULONG
type HCERTSTORE as PVOID
type HCRYPTMSG as PVOID
type HCERTCHAINENGINE as PVOID

type CRYPTOAPI_BLOB
	cbData as DWORD
	pbData as UBYTE ptr
end type

type CRYPT_INTEGER_BLOB as CRYPTOAPI_BLOB
type PCRYPT_INTEGER_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_UINT_BLOB as CRYPTOAPI_BLOB
type PCRYPT_UINT_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_OBJID_BLOB as CRYPTOAPI_BLOB
type PCRYPT_OBJID_BLOB as CRYPTOAPI_BLOB ptr
type CERT_NAME_BLOB as CRYPTOAPI_BLOB
type PCERT_NAME_BLOB as CRYPTOAPI_BLOB ptr
type CERT_RDN_VALUE_BLOB as CRYPTOAPI_BLOB
type PCERT_RDN_VALUE_BLOB as CRYPTOAPI_BLOB ptr
type CERT_BLOB as CRYPTOAPI_BLOB
type PCERT_BLOB as CRYPTOAPI_BLOB ptr
type CRL_BLOB as CRYPTOAPI_BLOB
type PCRL_BLOB as CRYPTOAPI_BLOB ptr
type DATA_BLOB as CRYPTOAPI_BLOB
type PDATA_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_DATA_BLOB as CRYPTOAPI_BLOB
type PCRYPT_DATA_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_HASH_BLOB as CRYPTOAPI_BLOB
type PCRYPT_HASH_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_DIGEST_BLOB as CRYPTOAPI_BLOB
type PCRYPT_DIGEST_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_DER_BLOB as CRYPTOAPI_BLOB
type PCRYPT_DER_BLOB as CRYPTOAPI_BLOB ptr
type CRYPT_ATTR_BLOB as CRYPTOAPI_BLOB
type PCRYPT_ATTR_BLOB as CRYPTOAPI_BLOB ptr

type SSL_EXTRA_CERT_CHAIN_POLICY_PARA
	cbStruct as DWORD
	dwAuthType as DWORD
	fdwChecks as DWORD
	pwszServerName as LPWSTR
end type

type PSSL_EXTRA_CERT_CHAIN_POLICY_PARA as SSL_EXTRA_CERT_CHAIN_POLICY_PARA ptr
type HTTPSPolicyCallbackData as SSL_EXTRA_CERT_CHAIN_POLICY_PARA
type PHTTPSPolicyCallbackData as SSL_EXTRA_CERT_CHAIN_POLICY_PARA ptr

type CERT_CHAIN_POLICY_PARA
	cbSize as DWORD
	dwFlags as DWORD
	pvExtraPolicyPara as any ptr
end type

type PCERT_CHAIN_POLICY_PARA as CERT_CHAIN_POLICY_PARA ptr

type CERT_CHAIN_POLICY_STATUS
	cbSize as DWORD
	dwError as DWORD
	lChainIndex as LONG
	lElementIndex as LONG
	pvExtraPolicyStatus as any ptr
end type

type PCERT_CHAIN_POLICY_STATUS as CERT_CHAIN_POLICY_STATUS ptr

type CRYPT_ALGORITHM_IDENTIFIER
	pszObjId as LPSTR
	Parameters as CRYPT_OBJID_BLOB
end type

type PCRYPT_ALGORITHM_IDENTIFIER as CRYPT_ALGORITHM_IDENTIFIER ptr

type CRYPT_BIT_BLOB
	cbData as DWORD
	pbData as UBYTE ptr
	cUnusedBits as DWORD
end type

type PCRYPT_BIT_BLOB as CRYPT_BIT_BLOB ptr

type CERT_PUBLIC_KEY_INFO
	Algorithm as CRYPT_ALGORITHM_IDENTIFIER
	PublicKey as CRYPT_BIT_BLOB
end type

type PCERT_PUBLIC_KEY_INFO as CERT_PUBLIC_KEY_INFO ptr

type CERT_EXTENSION
	pszObjId as LPSTR
	fCritical as BOOL
	Value as CRYPT_OBJID_BLOB
end type

type PCERT_EXTENSION as CERT_EXTENSION ptr

type CERT_INFO
	dwVersion as DWORD
	SerialNumber as CRYPT_INTEGER_BLOB
	SignatureAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Issuer as CERT_NAME_BLOB
	NotBefore as FILETIME
	NotAfter as FILETIME
	Subject as CERT_NAME_BLOB
	SubjectPublicKeyInfo as CERT_PUBLIC_KEY_INFO
	IssuerUniqueId as CRYPT_BIT_BLOB
	SubjectUniqueId as CRYPT_BIT_BLOB
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type PCERT_INFO as CERT_INFO ptr

type CERT_CONTEXT
	dwCertEncodingType as DWORD
	pbCertEncoded as UBYTE ptr
	cbCertEncoded as DWORD
	pCertInfo as PCERT_INFO
	hCertStore as HCERTSTORE
end type

type PCERT_CONTEXT as CERT_CONTEXT ptr
type PCCERT_CONTEXT as CERT_CONTEXT ptr

type CTL_USAGE
	cUsageIdentifier as DWORD
	rgpszUsageIdentifier as LPSTR ptr
end type

type PCTRL_USAGE as CTL_USAGE ptr
type CERT_ENHKEY_USAGE as CTL_USAGE
type PCERT_ENHKEY_USAGE as CTL_USAGE ptr

type CERT_USAGE_MATCH
	dwType as DWORD
	Usage as CERT_ENHKEY_USAGE
end type

type PCERT_USAGE_MATCH as CERT_USAGE_MATCH ptr

type CERT_CHAIN_PARA
	cbSize as DWORD
	RequestedUsage as CERT_USAGE_MATCH
end type

type PCERT_CHAIN_PARA as CERT_CHAIN_PARA ptr
type PFNCERT_CHAIN_FIND_BY_ISSUER_CALLBACK as function (byval as PCCERT_CONTEXT, byval as any ptr) as BOOL

type CERT_CHAIN_FIND_BY_ISSUER_PARA
	cbSize as DWORD
	pszUsageIdentifier as LPCSTR
	dwKeySpec as DWORD
	dwAcquirePrivateKeyFlags as DWORD
	cIssuer as DWORD
	rgIssuer as CERT_NAME_BLOB ptr
	pfnFIndCallback as PFNCERT_CHAIN_FIND_BY_ISSUER_CALLBACK
	pvFindArg as any ptr
	pdwIssuerChainIndex as DWORD ptr
	pdwIssuerElementIndex as DWORD ptr
end type

type PCERT_CHAIN_FIND_BY_ISSUER_PARA as CERT_CHAIN_FIND_BY_ISSUER_PARA ptr

type CERT_TRUST_STATUS
	dwErrorStatus as DWORD
	dwInfoStatus as DWORD
end type

type PCERT_TRUST_STATUS as CERT_TRUST_STATUS ptr

type CRL_ENTRY
	SerialNumber as CRYPT_INTEGER_BLOB
	RevocationDate as FILETIME
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type PCRL_ENTRY as CRL_ENTRY ptr

type CRL_INFO
	dwVersion as DWORD
	SignatureAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Issuer as CERT_NAME_BLOB
	ThisUpdate as FILETIME
	NextUpdate as FILETIME
	cCRLEntry as DWORD
	rgCRLEntry as PCRL_ENTRY
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type PCRL_INFO as CRL_INFO ptr

type CRL_CONTEXT
	dwCertEncodingType as DWORD
	pbCrlEncoded as UBYTE ptr
	cbCrlEncoded as DWORD
	pCrlInfo as PCRL_INFO
	hCertStore as HCERTSTORE
end type

type PCRL_CONTEXT as CRL_CONTEXT ptr
type PCCRL_CONTEXT as const CRL_CONTEXT ptr

type CERT_REVOCATIONCRL_INFO
	cbSize as DWORD
	pBaseCRLContext as PCCRL_CONTEXT
	pDeltaCRLContext as PCCRL_CONTEXT
	pCrlEntry as PCRL_ENTRY
	fDeltaCrlEntry as BOOL
end type

type PCERT_REVOCATIONCRL_INFO as CERT_REVOCATIONCRL_INFO ptr

type CERT_REVOCATION_INFO
	cbSize as DWORD
	dwRevocationResult as DWORD
	pszRevocationOid as LPCSTR
	pvOidSpecificInfo as LPVOID
	fHasFreshnessTime as BOOL
	dwFreshnessTime as DWORD
	pCrlInfo as PCERT_REVOCATIONCRL_INFO
end type

type PCERT_REVOCATION_INFO as CERT_REVOCATION_INFO ptr

type CERT_CHAIN_ELEMENT
	cbSize as DWORD
	pCertContext as PCCERT_CONTEXT
	TrustStatus as CERT_TRUST_STATUS
	pRevocationInfo as PCERT_REVOCATION_INFO
	pIssuanceUsage as PCERT_ENHKEY_USAGE
	pApplicationUsage as PCERT_ENHKEY_USAGE
end type

type PCERT_CHAIN_ELEMENT as CERT_CHAIN_ELEMENT ptr

type CRYPT_ATTRIBUTE
	pszObjId as LPSTR
	cValue as DWORD
	rgValue as PCRYPT_ATTR_BLOB
end type

type PCRYPT_ATTRIBUTE as CRYPT_ATTRIBUTE ptr

type CTL_ENTRY
	SubjectIdentifier as CRYPT_DATA_BLOB
	cAttribute as DWORD
	rgAttribute as PCRYPT_ATTRIBUTE
end type

type PCTL_ENTRY as CTL_ENTRY ptr

type CTL_INFO
	dwVersion as DWORD
	SubjectUsage as CTL_USAGE
	ListIdentifier as CRYPT_DATA_BLOB
	SequenceNumber as CRYPT_INTEGER_BLOB
	ThisUpdate as FILETIME
	NextUpdate as FILETIME
	SubjectAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	cCTLEntry as DWORD
	rgCTLEntry as PCTL_ENTRY
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type PCTL_INFO as CTL_INFO ptr

type CTL_CONTEXT
	dwMsgAndCertEncodingType as DWORD
	pbCtlEncoded as UBYTE ptr
	cbCtlEncoded as DWORD
	pCtlInfo as PCTL_INFO
	hCertStore as HCERTSTORE
	hCryptMsg as HCRYPTMSG
	pbCtlContent as UBYTE ptr
	cbCtlContent as DWORD
end type

type PCTL_CONTEXT as CTL_CONTEXT ptr
type PCCTL_CONTEXT as const CTL_CONTEXT ptr

type CERT_TRUST_LIST_INFO
	cbSize as DWORD
	pCtlEntry as PCTL_ENTRY
	pCtlContext as PCCTL_CONTEXT
end type

type PCERT_TRUST_LIST_INFO as CERT_TRUST_LIST_INFO ptr

type CERT_SIMPLE_CHAIN
	cbSize as DWORD
	TrustStatus as CERT_TRUST_STATUS
	cElement as DWORD
	rgpElement as PCERT_CHAIN_ELEMENT ptr
	pTrustListInfo as PCERT_TRUST_LIST_INFO
	fHasRevocationFreshnessTime as BOOL
	dwRevocationFreshnessTime as DWORD
end type

type PCERT_SIMPLE_CHAIN as CERT_SIMPLE_CHAIN ptr
type PCCERT_CHAIN_CONTEXT as const CERT_CHAIN_CONTEXT ptr

type CERT_CHAIN_CONTEXT
	cbSize as DWORD
	TrustStatus as CERT_TRUST_STATUS
	cChain as DWORD
	rgpChain as PCERT_SIMPLE_CHAIN ptr
	cLowerQualityChainContext as DWORD
	rgpLowerQualityChainContext as PCCERT_CHAIN_CONTEXT ptr
	fHasRevocationFreshnessTime as BOOL
	dwRevocationFreshnessTime as DWORD
end type

type PCERT_CHAIN_CONTEXT as CERT_CHAIN_CONTEXT ptr

type PROV_ENUMALGS
	aiAlgid as ALG_ID
	dwBitLen as DWORD
	dwNameLen as DWORD
	szName as zstring * 20
end type

type PUBLICKEYSTRUC
	bType_ as UBYTE
	bVersion as UBYTE
	reserved as WORD
	aiKeyAlg as ALG_ID
end type

type RSAPUBKEY
	magic as DWORD
	bitlen as DWORD
	pubexp as DWORD
end type

type HMAC_Info
	HashAlgid as ALG_ID
	pbInnerString as UBYTE ptr
	cbInnerString as DWORD
	pbOuterString as UBYTE ptr
	cbOuterString as DWORD
end type

type PHMAC_INFO as HMAC_Info ptr

declare function CertCloseStore alias "CertCloseStore" (byval as HCERTSTORE, byval as DWORD) as BOOL
declare function CertGetCertificateChain alias "CertGetCertificateChain" (byval as HCERTCHAINENGINE, byval as PCCERT_CONTEXT, byval as LPFILETIME, byval as HCERTSTORE, byval as PCERT_CHAIN_PARA, byval as DWORD, byval as LPVOID, byval as PCCERT_CHAIN_CONTEXT ptr) as BOOL
declare function CertVerifyCertificateChainPolicy alias "CertVerifyCertificateChainPolicy" (byval as LPCSTR, byval as PCCERT_CHAIN_CONTEXT, byval as PCERT_CHAIN_POLICY_PARA, byval as PCERT_CHAIN_POLICY_STATUS) as BOOL
declare sub CertFreeCertificateChain alias "CertFreeCertificateChain" (byval as PCCERT_CHAIN_CONTEXT)
declare function CertOpenStore alias "CertOpenStore" (byval as LPCSTR, byval as DWORD, byval as HCRYPTPROV, byval as DWORD, byval as any ptr) as HCERTSTORE
declare function CertFindCertificateInStore alias "CertFindCertificateInStore" (byval as HCERTSTORE, byval as DWORD, byval as DWORD, byval as DWORD, byval as any ptr, byval as PCCERT_CONTEXT) as PCCERT_CONTEXT
declare function CertFreeCertificateContext alias "CertFreeCertificateContext" (byval as PCCERT_CONTEXT) as BOOL
declare function CertGetIssuerCertificateFromStore alias "CertGetIssuerCertificateFromStore" (byval as HCERTSTORE, byval as PCCERT_CONTEXT, byval as PCCERT_CONTEXT, byval as DWORD ptr) as PCCERT_CONTEXT
declare function CertFindChainInStore alias "CertFindChainInStore" (byval as HCERTSTORE, byval as DWORD, byval as DWORD, byval as DWORD, byval as any ptr, byval as PCCERT_CHAIN_CONTEXT) as PCCERT_CHAIN_CONTEXT
declare function CryptContextAddRef alias "CryptContextAddRef" (byval as HCRYPTPROV, byval as DWORD ptr, byval as DWORD) as BOOL
declare function CryptReleaseContext alias "CryptReleaseContext" (byval as HCRYPTPROV, byval as DWORD) as BOOL
declare function CryptGenKey alias "CryptGenKey" (byval as HCRYPTPROV, byval as ALG_ID, byval as DWORD, byval as HCRYPTKEY ptr) as BOOL
declare function CryptDeriveKey alias "CryptDeriveKey" (byval as HCRYPTPROV, byval as ALG_ID, byval as HCRYPTHASH, byval as DWORD, byval as HCRYPTKEY ptr) as BOOL
declare function CryptDestroyKey alias "CryptDestroyKey" (byval as HCRYPTKEY) as BOOL
declare function CryptSetKeyParam alias "CryptSetKeyParam" (byval as HCRYPTKEY, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function CryptGetKeyParam alias "CryptGetKeyParam" (byval as HCRYPTKEY, byval as DWORD, byval as PBYTE, byval as PDWORD, byval as DWORD) as BOOL
declare function CryptSetHashParam alias "CryptSetHashParam" (byval as HCRYPTHASH, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function CryptGetHashParam alias "CryptGetHashParam" (byval as HCRYPTHASH, byval as DWORD, byval as PBYTE, byval as PDWORD, byval as DWORD) as BOOL
declare function CryptSetProvParam alias "CryptSetProvParam" (byval as HCRYPTPROV, byval as DWORD, byval as PBYTE, byval as DWORD) as BOOL
declare function CryptGetProvParam alias "CryptGetProvParam" (byval as HCRYPTPROV, byval as DWORD, byval as PBYTE, byval as PDWORD, byval as DWORD) as BOOL
declare function CryptGenRandom alias "CryptGenRandom" (byval as HCRYPTPROV, byval as DWORD, byval as PBYTE) as BOOL
declare function CryptGetUserKey alias "CryptGetUserKey" (byval as HCRYPTPROV, byval as DWORD, byval as HCRYPTKEY ptr) as BOOL
declare function CryptExportKey alias "CryptExportKey" (byval as HCRYPTKEY, byval as HCRYPTKEY, byval as DWORD, byval as DWORD, byval as PBYTE, byval as PDWORD) as BOOL
declare function CryptImportKey alias "CryptImportKey" (byval as HCRYPTPROV, byval as PBYTE, byval as DWORD, byval as HCRYPTKEY, byval as DWORD, byval as HCRYPTKEY ptr) as BOOL
declare function CryptEncrypt alias "CryptEncrypt" (byval as HCRYPTKEY, byval as HCRYPTHASH, byval as BOOL, byval as DWORD, byval as PBYTE, byval as PDWORD, byval as DWORD) as BOOL
declare function CryptDecrypt alias "CryptDecrypt" (byval as HCRYPTKEY, byval as HCRYPTHASH, byval as BOOL, byval as DWORD, byval as PBYTE, byval as PDWORD) as BOOL
declare function CryptCreateHash alias "CryptCreateHash" (byval as HCRYPTPROV, byval as ALG_ID, byval as HCRYPTKEY, byval as DWORD, byval as HCRYPTHASH ptr) as BOOL
declare function CryptHashData alias "CryptHashData" (byval as HCRYPTHASH, byval as PBYTE, byval as DWORD, byval as DWORD) as BOOL
declare function CryptHashSessionKey alias "CryptHashSessionKey" (byval as HCRYPTHASH, byval as HCRYPTKEY, byval as DWORD) as BOOL
declare function CryptGetHashValue alias "CryptGetHashValue" (byval as HCRYPTHASH, byval as DWORD, byval as PBYTE, byval as PDWORD) as BOOL
declare function CryptDestroyHash alias "CryptDestroyHash" (byval as HCRYPTHASH) as BOOL

#ifdef UNICODE
declare function CertNameToStr alias "CertNameToStrW" (byval as DWORD, byval as PCERT_NAME_BLOB, byval as DWORD, byval as LPWSTR, byval as DWORD) as DWORD
declare function CertOpenSystemStore alias "CertOpenSystemStoreW" (byval as HCRYPTPROV, byval as LPCWSTR) as HCERTSTORE
declare function CryptAcquireContext alias "CryptAcquireContextW" (byval as HCRYPTPROV ptr, byval as LPCWSTR, byval as LPCWSTR, byval as DWORD, byval as DWORD) as BOOL
declare function CryptSignHash alias "CryptSignHashW" (byval as HCRYPTHASH, byval as DWORD, byval as LPCWSTR, byval as DWORD, byval as PBYTE, byval as PDWORD) as BOOL
declare function CryptVerifySignature alias "CryptVerifySignatureW" (byval as HCRYPTHASH, byval as PBYTE, byval as DWORD, byval as HCRYPTKEY, byval as LPCWSTR, byval as DWORD) as BOOL
declare function CryptSetProvider alias "CryptSetProviderW" (byval as LPCWSTR, byval as DWORD) as BOOL

#define CERT_FIND_SUBJECT_STR CERT_FIND_SUBJECT_STR_W
#define CERT_FIND_ISSUER_STR CERT_FIND_ISSUER_STR_W

#else ''UNICODE
declare function CertNameToStr alias "CertNameToStrA" (byval as DWORD, byval as PCERT_NAME_BLOB, byval as DWORD, byval as LPSTR, byval as DWORD) as DWORD
declare function CertOpenSystemStore alias "CertOpenSystemStoreA" (byval as HCRYPTPROV, byval as LPCSTR) as HCERTSTORE
declare function CryptAcquireContext alias "CryptAcquireContextA" (byval as HCRYPTPROV ptr, byval as LPCSTR, byval as LPCSTR, byval as DWORD, byval as DWORD) as BOOL
declare function CryptSignHash alias "CryptSignHashA" (byval as HCRYPTHASH, byval as DWORD, byval as LPCSTR, byval as DWORD, byval as PBYTE, byval as PDWORD) as BOOL
declare function CryptVerifySignature alias "CryptVerifySignatureA" (byval as HCRYPTHASH, byval as PBYTE, byval as DWORD, byval as HCRYPTKEY, byval as LPCSTR, byval as DWORD) as BOOL
declare function CryptSetProvider alias "CryptSetProviderA" (byval as LPCSTR, byval as DWORD) as BOOL

#define CERT_FIND_SUBJECT_STR CERT_FIND_SUBJECT_STR_A
#define CERT_FIND_ISSUER_STR CERT_FIND_ISSUER_STR_A
#endif ''UNICODE

#endif
