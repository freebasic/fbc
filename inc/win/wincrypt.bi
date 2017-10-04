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

#include once "_mingw.bi"
#include once "_mingw_unicode.bi"
#include once "guiddef.bi"
#include once "winapifamily.bi"

extern "Windows"

#define __WINCRYPT_H__
#define GET_ALG_CLASS(x) (x and (7 shl 13))
#define GET_ALG_TYPE(x) (x and (15 shl 9))
#define GET_ALG_SID(x) (x and 511)
const ALG_CLASS_ANY = 0
const ALG_CLASS_SIGNATURE = 1 shl 13
const ALG_CLASS_MSG_ENCRYPT = 2 shl 13
const ALG_CLASS_DATA_ENCRYPT = 3 shl 13
const ALG_CLASS_HASH = 4 shl 13
const ALG_CLASS_KEY_EXCHANGE = 5 shl 13
const ALG_CLASS_ALL = 7 shl 13
const ALG_TYPE_ANY = 0
const ALG_TYPE_DSS = 1 shl 9
const ALG_TYPE_RSA = 2 shl 9
const ALG_TYPE_BLOCK = 3 shl 9
const ALG_TYPE_STREAM = 4 shl 9
const ALG_TYPE_DH = 5 shl 9
const ALG_TYPE_SECURECHANNEL = 6 shl 9
const ALG_SID_ANY = 0
const ALG_SID_RSA_ANY = 0
const ALG_SID_RSA_PKCS = 1
const ALG_SID_RSA_MSATWORK = 2
const ALG_SID_RSA_ENTRUST = 3
const ALG_SID_RSA_PGP = 4
const ALG_SID_DSS_ANY = 0
const ALG_SID_DSS_PKCS = 1
const ALG_SID_DSS_DMS = 2

#if _WIN32_WINNT >= &h0600
	const ALG_SID_ECDSA = 3
#endif

const ALG_SID_DES = 1
const ALG_SID_3DES = 3
const ALG_SID_DESX = 4
const ALG_SID_IDEA = 5
const ALG_SID_CAST = 6
const ALG_SID_SAFERSK64 = 7
const ALG_SID_SAFERSK128 = 8
const ALG_SID_3DES_112 = 9
const ALG_SID_SKIPJACK = 10
const ALG_SID_TEK = 11
const ALG_SID_CYLINK_MEK = 12
const ALG_SID_RC5 = 13
const ALG_SID_AES_128 = 14
const ALG_SID_AES_192 = 15
const ALG_SID_AES_256 = 16
const ALG_SID_AES = 17
const CRYPT_MODE_CBCI = 6
const CRYPT_MODE_CFBP = 7
const CRYPT_MODE_OFBP = 8
const CRYPT_MODE_CBCOFM = 9
const CRYPT_MODE_CBCOFMI = 10
const ALG_SID_RC2 = 2
const ALG_SID_RC4 = 1
const ALG_SID_SEAL = 2
const ALG_SID_DH_SANDF = 1
const ALG_SID_DH_EPHEM = 2
const ALG_SID_AGREED_KEY_ANY = 3
const ALG_SID_KEA = 4

#if _WIN32_WINNT >= &h0600
	const ALG_SID_ECDH = 5
#endif

const ALG_SID_MD2 = 1
const ALG_SID_MD4 = 2
const ALG_SID_MD5 = 3
const ALG_SID_SHA = 4
const ALG_SID_SHA1 = 4
const ALG_SID_MAC = 5
const ALG_SID_RIPEMD = 6
const ALG_SID_RIPEMD160 = 7
const ALG_SID_SSL3SHAMD5 = 8
const ALG_SID_HMAC = 9
const ALG_SID_TLS1PRF = 10
const ALG_SID_HASH_REPLACE_OWF = 11
const ALG_SID_SHA_256 = 12
const ALG_SID_SHA_384 = 13
const ALG_SID_SHA_512 = 14
const ALG_SID_SSL3_MASTER = 1
const ALG_SID_SCHANNEL_MASTER_HASH = 2
const ALG_SID_SCHANNEL_MAC_KEY = 3
const ALG_SID_PCT1_MASTER = 4
const ALG_SID_SSL2_MASTER = 5
const ALG_SID_TLS1_MASTER = 6
const ALG_SID_SCHANNEL_ENC_KEY = 7

#if _WIN32_WINNT >= &h0600
	const ALG_SID_ECMQV = 1
#endif

const ALG_SID_EXAMPLE = 80
#define ALGIDDEF
type ALG_ID as ulong
const CALG_MD2 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_MD2
const CALG_MD4 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_MD4
const CALG_MD5 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_MD5
const CALG_SHA = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_SHA
const CALG_SHA1 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_SHA1
const CALG_MAC = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_MAC
const CALG_RSA_SIGN = (ALG_CLASS_SIGNATURE or ALG_TYPE_RSA) or ALG_SID_RSA_ANY
const CALG_DSS_SIGN = (ALG_CLASS_SIGNATURE or ALG_TYPE_DSS) or ALG_SID_DSS_ANY
const CALG_NO_SIGN = (ALG_CLASS_SIGNATURE or ALG_TYPE_ANY) or ALG_SID_ANY
const CALG_RSA_KEYX = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_RSA) or ALG_SID_RSA_ANY
const CALG_DES = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_DES
const CALG_3DES_112 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_3DES_112
const CALG_3DES = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_3DES
const CALG_DESX = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_DESX
const CALG_RC2 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_RC2
const CALG_RC4 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM) or ALG_SID_RC4
const CALG_SEAL = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_STREAM) or ALG_SID_SEAL
const CALG_DH_SF = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH) or ALG_SID_DH_SANDF
const CALG_DH_EPHEM = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH) or ALG_SID_DH_EPHEM
const CALG_AGREEDKEY_ANY = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH) or ALG_SID_AGREED_KEY_ANY
const CALG_KEA_KEYX = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH) or ALG_SID_KEA
const CALG_HUGHES_MD5 = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_ANY) or ALG_SID_MD5
const CALG_SKIPJACK = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_SKIPJACK
const CALG_TEK = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_TEK
const CALG_CYLINK_MEK = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_CYLINK_MEK
const CALG_SSL3_SHAMD5 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_SSL3SHAMD5
const CALG_SSL3_MASTER = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_SSL3_MASTER
const CALG_SCHANNEL_MASTER_HASH = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_SCHANNEL_MASTER_HASH
const CALG_SCHANNEL_MAC_KEY = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_SCHANNEL_MAC_KEY
const CALG_SCHANNEL_ENC_KEY = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_SCHANNEL_ENC_KEY
const CALG_PCT1_MASTER = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_PCT1_MASTER
const CALG_SSL2_MASTER = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_SSL2_MASTER
const CALG_TLS1_MASTER = (ALG_CLASS_MSG_ENCRYPT or ALG_TYPE_SECURECHANNEL) or ALG_SID_TLS1_MASTER
const CALG_RC5 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_RC5
const CALG_HMAC = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_HMAC
const CALG_TLS1PRF = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_TLS1PRF
const CALG_HASH_REPLACE_OWF = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_HASH_REPLACE_OWF
const CALG_AES_128 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_AES_128
const CALG_AES_192 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_AES_192
const CALG_AES_256 = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_AES_256
const CALG_AES = (ALG_CLASS_DATA_ENCRYPT or ALG_TYPE_BLOCK) or ALG_SID_AES
const CALG_SHA_256 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_SHA_256
const CALG_SHA_384 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_SHA_384
const CALG_SHA_512 = (ALG_CLASS_HASH or ALG_TYPE_ANY) or ALG_SID_SHA_512

#if _WIN32_WINNT >= &h0600
	const CALG_ECDH = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_DH) or ALG_SID_ECDH
	const CALG_ECMQV = (ALG_CLASS_KEY_EXCHANGE or ALG_TYPE_ANY) or ALG_SID_ECMQV
	const CALG_ECDSA = (ALG_CLASS_SIGNATURE or ALG_TYPE_DSS) or ALG_SID_ECDSA
#endif

#define HCRYPTPROV_DEFINED
type HCRYPTHASH as ULONG_PTR
type HCRYPTKEY as ULONG_PTR
type HCRYPTPROV as ULONG_PTR

const CRYPT_VERIFYCONTEXT = &hf0000000
const CRYPT_NEWKEYSET = &h8
const CRYPT_DELETEKEYSET = &h10
const CRYPT_MACHINE_KEYSET = &h20
const CRYPT_SILENT = &h40

#if _WIN32_WINNT >= &h0600
	const CRYPT_DEFAULT_CONTAINER_OPTIONAL = &h80
#endif

const CRYPT_EXPORTABLE = &h1
const CRYPT_USER_PROTECTED = &h2
const CRYPT_CREATE_SALT = &h4
const CRYPT_UPDATE_KEY = &h8
const CRYPT_NO_SALT = &h10
const CRYPT_PREGEN = &h40
const CRYPT_RECIPIENT = &h10
const CRYPT_INITIATOR = &h40
const CRYPT_ONLINE = &h80
const CRYPT_SF = &h100
const CRYPT_CREATE_IV = &h200
const CRYPT_KEK = &h400
const CRYPT_DATA_KEY = &h800
const CRYPT_VOLATILE = &h1000
const CRYPT_SGCKEY = &h2000
const CRYPT_ARCHIVABLE = &h4000

#if _WIN32_WINNT >= &h0600
	const CRYPT_FORCE_KEY_PROTECTION_HIGH = &h8000
#endif

const CRYPT_USER_PROTECTED_STRONG = &h100000
const RSA1024BIT_KEY = &h4000000
const CRYPT_SERVER = &h400
const KEY_LENGTH_MASK = &hffff0000
const CRYPT_Y_ONLY = &h1
const CRYPT_SSL2_FALLBACK = &h2
const CRYPT_DESTROYKEY = &h4
const CRYPT_DECRYPT_RSA_NO_PADDING_CHECK = &h20
const CRYPT_OAEP = &h40
const CRYPT_BLOB_VER3 = &h80
const CRYPT_IPSEC_HMAC_KEY = &h100
const CRYPT_SECRETDIGEST = &h1
const CRYPT_OWF_REPL_LM_HASH = &h1
const CRYPT_LITTLE_ENDIAN = &h1
const CRYPT_NOHASHOID = &h1
const CRYPT_TYPE2_FORMAT = &h2
const CRYPT_X931_FORMAT = &h4
const CRYPT_MACHINE_DEFAULT = &h1
const CRYPT_USER_DEFAULT = &h2
const CRYPT_DELETE_DEFAULT = &h4
const SIMPLEBLOB = &h1
const PUBLICKEYBLOB = &h6
const PRIVATEKEYBLOB = &h7
const PLAINTEXTKEYBLOB = &h8
const OPAQUEKEYBLOB = &h9
const PUBLICKEYBLOBEX = &ha
const SYMMETRICWRAPKEYBLOB = &hb
const KEYSTATEBLOB = &hc
const AT_KEYEXCHANGE = 1
const AT_SIGNATURE = 2
const CRYPT_USERDATA = 1
const KP_IV = 1
const KP_SALT = 2
const KP_PADDING = 3
const KP_MODE = 4
const KP_MODE_BITS = 5
const KP_PERMISSIONS = 6
const KP_ALGID = 7
const KP_BLOCKLEN = 8
const KP_KEYLEN = 9
const KP_SALT_EX = 10
const KP_P = 11
const KP_G = 12
const KP_Q = 13
const KP_X = 14
const KP_Y = 15
const KP_RA = 16
const KP_RB = 17
const KP_INFO = 18
const KP_EFFECTIVE_KEYLEN = 19
const KP_SCHANNEL_ALG = 20
const KP_CLIENT_RANDOM = 21
const KP_SERVER_RANDOM = 22
const KP_RP = 23
const KP_PRECOMP_MD5 = 24
const KP_PRECOMP_SHA = 25
const KP_CERTIFICATE = 26
const KP_CLEAR_KEY = 27
const KP_PUB_EX_LEN = 28
const KP_PUB_EX_VAL = 29
const KP_KEYVAL = 30
const KP_ADMIN_PIN = 31
const KP_KEYEXCHANGE_PIN = 32
const KP_SIGNATURE_PIN = 33
const KP_PREHASH = 34
const KP_ROUNDS = 35
const KP_OAEP_PARAMS = 36
const KP_CMS_KEY_INFO = 37
const KP_CMS_DH_KEY_INFO = 38
const KP_PUB_PARAMS = 39
const KP_VERIFY_PARAMS = 40
const KP_HIGHEST_VERSION = 41
const KP_GET_USE_COUNT = 42
const KP_PIN_ID = 43
const KP_PIN_INFO = 44
const PKCS5_PADDING = 1
const RANDOM_PADDING = 2
const ZERO_PADDING = 3
const CRYPT_MODE_CBC = 1
const CRYPT_MODE_ECB = 2
const CRYPT_MODE_OFB = 3
const CRYPT_MODE_CFB = 4
const CRYPT_MODE_CTS = 5
const CRYPT_ENCRYPT = &h1
const CRYPT_DECRYPT = &h2
const CRYPT_EXPORT = &h4
const CRYPT_READ = &h8
const CRYPT_WRITE = &h10
const CRYPT_MAC = &h20
const CRYPT_EXPORT_KEY = &h40
const CRYPT_IMPORT_KEY = &h80
const CRYPT_ARCHIVE = &h100
const HP_ALGID = &h1
const HP_HASHVAL = &h2
const HP_HASHSIZE = &h4
const HP_HMAC_INFO = &h5
const HP_TLS1PRF_LABEL = &h6
const HP_TLS1PRF_SEED = &h7
const CRYPT_FAILED = FALSE
const CRYPT_SUCCEED = CTRUE
#define RCRYPT_SUCCEEDED(RT) ((RT) = CRYPT_SUCCEED)
#define RCRYPT_FAILED(RT) ((RT) = CRYPT_FAILED)
const PP_ENUMALGS = 1
const PP_ENUMCONTAINERS = 2
const PP_IMPTYPE = 3
const PP_NAME = 4
const PP_VERSION = 5
const PP_CONTAINER = 6
const PP_CHANGE_PASSWORD = 7
const PP_KEYSET_SEC_DESCR = 8
const PP_CERTCHAIN = 9
const PP_KEY_TYPE_SUBTYPE = 10
const PP_PROVTYPE = 16
const PP_KEYSTORAGE = 17
const PP_APPLI_CERT = 18
const PP_SYM_KEYSIZE = 19
const PP_SESSION_KEYSIZE = 20
const PP_UI_PROMPT = 21
const PP_ENUMALGS_EX = 22
const PP_ENUMMANDROOTS = 25
const PP_ENUMELECTROOTS = 26
const PP_KEYSET_TYPE = 27
const PP_ADMIN_PIN = 31
const PP_KEYEXCHANGE_PIN = 32
const PP_SIGNATURE_PIN = 33
const PP_SIG_KEYSIZE_INC = 34
const PP_KEYX_KEYSIZE_INC = 35
const PP_UNIQUE_CONTAINER = 36
const PP_SGC_INFO = 37
const PP_USE_HARDWARE_RNG = 38
const PP_KEYSPEC = 39
const PP_ENUMEX_SIGNING_PROT = 40
const PP_CRYPT_COUNT_KEY_USE = 41

#if _WIN32_WINNT >= &h0600
	const PP_USER_CERTSTORE = 42
	const PP_SMARTCARD_READER = 43
	const PP_SMARTCARD_GUID = 45
	const PP_ROOT_CERTSTORE = 46
#endif

#if _WIN32_WINNT = &h0602
	const PP_SMARTCARD_READER_ICON = 47
#endif

const CRYPT_FIRST = 1
const CRYPT_NEXT = 2
const CRYPT_SGC_ENUM = 4
const CRYPT_IMPL_HARDWARE = 1
const CRYPT_IMPL_SOFTWARE = 2
const CRYPT_IMPL_MIXED = 3
const CRYPT_IMPL_UNKNOWN = 4
const CRYPT_IMPL_REMOVABLE = 8
const CRYPT_SEC_DESCR = &h1
const CRYPT_PSTORE = &h2
const CRYPT_UI_PROMPT = &h4
const CRYPT_FLAG_PCT1 = &h1
const CRYPT_FLAG_SSL2 = &h2
const CRYPT_FLAG_SSL3 = &h4
const CRYPT_FLAG_TLS1 = &h8
const CRYPT_FLAG_IPSEC = &h10
const CRYPT_FLAG_SIGNING = &h20
const CRYPT_SGC = &h1
const CRYPT_FASTSGC = &h2
const PP_CLIENT_HWND = 1
const PP_CONTEXT_INFO = 11
const PP_KEYEXCHANGE_KEYSIZE = 12
const PP_SIGNATURE_KEYSIZE = 13
const PP_KEYEXCHANGE_ALG = 14
const PP_SIGNATURE_ALG = 15
const PP_DELETEKEY = 24

#if _WIN32_WINNT >= &h0600
	const PP_PIN_PROMPT_STRING = 44
	const PP_SECURE_KEYEXCHANGE_PIN = 47
	const PP_SECURE_SIGNATURE_PIN = 48
#endif

const PROV_RSA_FULL = 1
const PROV_RSA_SIG = 2
const PROV_DSS = 3
const PROV_FORTEZZA = 4
const PROV_MS_EXCHANGE = 5
const PROV_SSL = 6
const PROV_STT_MER = 7
const PROV_STT_ACQ = 8
const PROV_STT_BRND = 9
const PROV_STT_ROOT = 10
const PROV_STT_ISS = 11
const PROV_RSA_SCHANNEL = 12
const PROV_DSS_DH = 13
const PROV_EC_ECDSA_SIG = 14
const PROV_EC_ECNRA_SIG = 15
const PROV_EC_ECDSA_FULL = 16
const PROV_EC_ECNRA_FULL = 17
const PROV_DH_SCHANNEL = 18
const PROV_SPYRUS_LYNKS = 20
const PROV_RNG = 21
const PROV_INTEL_SEC = 22
const PROV_REPLACE_OWF = 23
const PROV_RSA_AES = 24

#ifdef UNICODE
	#define MS_DEF_PROV MS_DEF_PROV_W
	#define MS_ENHANCED_PROV MS_ENHANCED_PROV_W
	#define MS_STRONG_PROV MS_STRONG_PROV_W
	#define MS_DEF_RSA_SIG_PROV MS_DEF_RSA_SIG_PROV_W
	#define MS_DEF_RSA_SCHANNEL_PROV MS_DEF_RSA_SCHANNEL_PROV_W
	#define MS_DEF_DSS_PROV MS_DEF_DSS_PROV_W
	#define MS_DEF_DSS_DH_PROV MS_DEF_DSS_DH_PROV_W
	#define MS_ENH_DSS_DH_PROV MS_ENH_DSS_DH_PROV_W
	#define MS_DEF_DH_SCHANNEL_PROV MS_DEF_DH_SCHANNEL_PROV_W
	#define MS_SCARD_PROV MS_SCARD_PROV_W
	#define MS_ENH_RSA_AES_PROV_XP MS_ENH_RSA_AES_PROV_XP_W
	#define MS_ENH_RSA_AES_PROV MS_ENH_RSA_AES_PROV_W
#else
	#define MS_DEF_PROV MS_DEF_PROV_A
	#define MS_ENHANCED_PROV MS_ENHANCED_PROV_A
	#define MS_STRONG_PROV MS_STRONG_PROV_A
	#define MS_DEF_RSA_SIG_PROV MS_DEF_RSA_SIG_PROV_A
	#define MS_DEF_RSA_SCHANNEL_PROV MS_DEF_RSA_SCHANNEL_PROV_A
	#define MS_DEF_DSS_PROV MS_DEF_DSS_PROV_A
	#define MS_DEF_DSS_DH_PROV MS_DEF_DSS_DH_PROV_A
	#define MS_ENH_DSS_DH_PROV MS_ENH_DSS_DH_PROV_A
	#define MS_DEF_DH_SCHANNEL_PROV MS_DEF_DH_SCHANNEL_PROV_A
	#define MS_SCARD_PROV MS_SCARD_PROV_A
	#define MS_ENH_RSA_AES_PROV_XP MS_ENH_RSA_AES_PROV_XP_A
	#define MS_ENH_RSA_AES_PROV MS_ENH_RSA_AES_PROV_A
#endif

#define MS_DEF_PROV_A "Microsoft Base Cryptographic Provider v1.0"
#define MS_DEF_PROV_W wstr("Microsoft Base Cryptographic Provider v1.0")
#define MS_ENHANCED_PROV_A "Microsoft Enhanced Cryptographic Provider v1.0"
#define MS_ENHANCED_PROV_W wstr("Microsoft Enhanced Cryptographic Provider v1.0")
#define MS_STRONG_PROV_A "Microsoft Strong Cryptographic Provider"
#define MS_STRONG_PROV_W wstr("Microsoft Strong Cryptographic Provider")
#define MS_DEF_RSA_SIG_PROV_A "Microsoft RSA Signature Cryptographic Provider"
#define MS_DEF_RSA_SIG_PROV_W wstr("Microsoft RSA Signature Cryptographic Provider")
#define MS_DEF_RSA_SCHANNEL_PROV_A "Microsoft RSA SChannel Cryptographic Provider"
#define MS_DEF_RSA_SCHANNEL_PROV_W wstr("Microsoft RSA SChannel Cryptographic Provider")
#define MS_DEF_DSS_PROV_A "Microsoft Base DSS Cryptographic Provider"
#define MS_DEF_DSS_PROV_W wstr("Microsoft Base DSS Cryptographic Provider")
#define MS_DEF_DSS_DH_PROV_A "Microsoft Base DSS and Diffie-Hellman Cryptographic Provider"
#define MS_DEF_DSS_DH_PROV_W wstr("Microsoft Base DSS and Diffie-Hellman Cryptographic Provider")
#define MS_ENH_DSS_DH_PROV_A "Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider"
#define MS_ENH_DSS_DH_PROV_W wstr("Microsoft Enhanced DSS and Diffie-Hellman Cryptographic Provider")
#define MS_DEF_DH_SCHANNEL_PROV_A "Microsoft DH SChannel Cryptographic Provider"
#define MS_DEF_DH_SCHANNEL_PROV_W wstr("Microsoft DH SChannel Cryptographic Provider")
#define MS_SCARD_PROV_A "Microsoft Base Smart Card Crypto Provider"
#define MS_SCARD_PROV_W wstr("Microsoft Base Smart Card Crypto Provider")
#define MS_ENH_RSA_AES_PROV_A "Microsoft Enhanced RSA and AES Cryptographic Provider"
#define MS_ENH_RSA_AES_PROV_W wstr("Microsoft Enhanced RSA and AES Cryptographic Provider")
#define MS_ENH_RSA_AES_PROV_XP_A "Microsoft Enhanced RSA and AES Cryptographic Provider (Prototype)"
#define MS_ENH_RSA_AES_PROV_XP_W wstr("Microsoft Enhanced RSA and AES Cryptographic Provider (Prototype)")
const MAXUIDLEN = 64
#define EXPO_OFFLOAD_REG_VALUE "ExpoOffload"
#define EXPO_OFFLOAD_FUNC_NAME "OffloadModExpo"
#define szKEY_CRYPTOAPI_PRIVATE_KEY_OPTIONS !"Software\\Policies\\Microsoft\\Cryptography"
#define szKEY_CACHE_ENABLED "CachePrivateKeys"
#define szKEY_CACHE_SECONDS "PrivateKeyLifetimeSeconds"
#define szPRIV_KEY_CACHE_MAX_ITEMS "PrivKeyCacheMaxItems"
const cPRIV_KEY_CACHE_MAX_ITEMS_DEFAULT = 20
#define szPRIV_KEY_CACHE_PURGE_INTERVAL_SECONDS "PrivKeyCachePurgeIntervalSeconds"
const cPRIV_KEY_CACHE_PURGE_INTERVAL_SECONDS_DEFAULT = 86400
const CUR_BLOB_VERSION = 2

type _CMS_KEY_INFO
	dwVersion as DWORD
	Algid as ALG_ID
	pbOID as UBYTE ptr
	cbOID as DWORD
end type

type CMS_KEY_INFO as _CMS_KEY_INFO
type PCMS_KEY_INFO as _CMS_KEY_INFO ptr

type _HMAC_Info
	HashAlgid as ALG_ID
	pbInnerString as UBYTE ptr
	cbInnerString as DWORD
	pbOuterString as UBYTE ptr
	cbOuterString as DWORD
end type

type HMAC_INFO as _HMAC_Info
type PHMAC_INFO as _HMAC_Info ptr

type _SCHANNEL_ALG
	dwUse as DWORD
	Algid as ALG_ID
	cBits as DWORD
	dwFlags as DWORD
	dwReserved as DWORD
end type

type SCHANNEL_ALG as _SCHANNEL_ALG
type PSCHANNEL_ALG as _SCHANNEL_ALG ptr
const SCHANNEL_MAC_KEY = &h0
const SCHANNEL_ENC_KEY = &h1
const INTERNATIONAL_USAGE = &h1

type _PROV_ENUMALGS
	aiAlgid as ALG_ID
	dwBitLen as DWORD
	dwNameLen as DWORD
	szName as zstring * 20
end type

type PROV_ENUMALGS as _PROV_ENUMALGS

type _PROV_ENUMALGS_EX
	aiAlgid as ALG_ID
	dwDefaultLen as DWORD
	dwMinLen as DWORD
	dwMaxLen as DWORD
	dwProtocols as DWORD
	dwNameLen as DWORD
	szName as zstring * 20
	dwLongNameLen as DWORD
	szLongName as zstring * 40
end type

type PROV_ENUMALGS_EX as _PROV_ENUMALGS_EX

type _PUBLICKEYSTRUC
	bType as UBYTE
	bVersion as UBYTE
	reserved as WORD
	aiKeyAlg as ALG_ID
end type

type BLOBHEADER as _PUBLICKEYSTRUC
type PUBLICKEYSTRUC as _PUBLICKEYSTRUC

type _RSAPUBKEY
	magic as DWORD
	bitlen as DWORD
	pubexp as DWORD
end type

type RSAPUBKEY as _RSAPUBKEY

type _PUBKEY
	magic as DWORD
	bitlen as DWORD
end type

type DHPUBKEY as _PUBKEY
type DSSPUBKEY as _PUBKEY
type KEAPUBKEY as _PUBKEY
type TEKPUBKEY as _PUBKEY

type _DSSSEED
	counter as DWORD
	seed(0 to 19) as UBYTE
end type

type DSSSEED as _DSSSEED

type _PUBKEYVER3
	magic as DWORD
	bitlenP as DWORD
	bitlenQ as DWORD
	bitlenJ as DWORD
	DSSSeed as DSSSEED
end type

type DHPUBKEY_VER3 as _PUBKEYVER3
type DSSPUBKEY_VER3 as _PUBKEYVER3

type _PRIVKEYVER3
	magic as DWORD
	bitlenP as DWORD
	bitlenQ as DWORD
	bitlenJ as DWORD
	bitlenX as DWORD
	DSSSeed as DSSSEED
end type

type DHPRIVKEY_VER3 as _PRIVKEYVER3
type DSSPRIVKEY_VER3 as _PRIVKEYVER3

type _KEY_TYPE_SUBTYPE
	dwKeySpec as DWORD
	as GUID Type
	Subtype as GUID
end type

type KEY_TYPE_SUBTYPE as _KEY_TYPE_SUBTYPE
type PKEY_TYPE_SUBTYPE as _KEY_TYPE_SUBTYPE ptr

type _CERT_FORTEZZA_DATA_PROP
	SerialNumber(0 to 7) as ubyte
	CertIndex as long
	CertLabel(0 to 35) as ubyte
end type

type CERT_FORTEZZA_DATA_PROP as _CERT_FORTEZZA_DATA_PROP

type _CRYPT_RC4_KEY_STATE
	Key(0 to 15) as ubyte
	SBox(0 to 255) as ubyte
	i as ubyte
	j as ubyte
end type

type CRYPT_RC4_KEY_STATE as _CRYPT_RC4_KEY_STATE
type PCRYPT_RC4_KEY_STATE as _CRYPT_RC4_KEY_STATE ptr

type _CRYPT_DES_KEY_STATE
	Key(0 to 7) as ubyte
	IV(0 to 7) as ubyte
	Feedback(0 to 7) as ubyte
end type

type CRYPT_DES_KEY_STATE as _CRYPT_DES_KEY_STATE
type PCRYPT_DES_KEY_STATE as _CRYPT_DES_KEY_STATE ptr

type _CRYPT_3DES_KEY_STATE
	Key(0 to 23) as ubyte
	IV(0 to 7) as ubyte
	Feedback(0 to 7) as ubyte
end type

type CRYPT_3DES_KEY_STATE as _CRYPT_3DES_KEY_STATE
type PCRYPT_3DES_KEY_STATE as _CRYPT_3DES_KEY_STATE ptr

#if _WIN32_WINNT >= &h0600
	type _CRYPT_AES_128_KEY_STATE
		Key(0 to 15) as ubyte
		IV(0 to 15) as ubyte
		EncryptionState(0 to 10, 0 to 15) as ubyte
		DecryptionState(0 to 10, 0 to 15) as ubyte
		Feedback(0 to 15) as ubyte
	end type

	type CRYPT_AES_128_KEY_STATE as _CRYPT_AES_128_KEY_STATE
	type PCRYPT_AES_128_KEY_STATE as _CRYPT_AES_128_KEY_STATE ptr

	type _CRYPT_AES_256_KEY_STATE
		Key(0 to 31) as ubyte
		IV(0 to 15) as ubyte
		EncryptionState(0 to 14, 0 to 15) as ubyte
		DecryptionState(0 to 14, 0 to 15) as ubyte
		Feedback(0 to 15) as ubyte
	end type

	type CRYPT_AES_256_KEY_STATE as _CRYPT_AES_256_KEY_STATE
	type PCRYPT_AES_256_KEY_STATE as _CRYPT_AES_256_KEY_STATE ptr
#endif

#define CRYPTO_BLOBS_DEFINED

type _CRYPTOAPI_BLOB
	cbData as DWORD
	pbData as UBYTE ptr
end type

type CRYPT_INTEGER_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_INTEGER_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_UINT_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_UINT_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_OBJID_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_OBJID_BLOB as _CRYPTOAPI_BLOB ptr
type CERT_NAME_BLOB as _CRYPTOAPI_BLOB
type PCERT_NAME_BLOB as _CRYPTOAPI_BLOB ptr
type CERT_RDN_VALUE_BLOB as _CRYPTOAPI_BLOB
type PCERT_RDN_VALUE_BLOB as _CRYPTOAPI_BLOB ptr
type CERT_BLOB as _CRYPTOAPI_BLOB
type PCERT_BLOB as _CRYPTOAPI_BLOB ptr
type CRL_BLOB as _CRYPTOAPI_BLOB
type PCRL_BLOB as _CRYPTOAPI_BLOB ptr
type DATA_BLOB as _CRYPTOAPI_BLOB
type PDATA_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_DATA_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_DATA_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_HASH_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_HASH_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_DIGEST_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_DIGEST_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_DER_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_DER_BLOB as _CRYPTOAPI_BLOB ptr
type CRYPT_ATTR_BLOB as _CRYPTOAPI_BLOB
type PCRYPT_ATTR_BLOB as _CRYPTOAPI_BLOB ptr

type _CMS_DH_KEY_INFO
	dwVersion as DWORD
	Algid as ALG_ID
	pszContentEncObjId as LPSTR
	PubInfo as CRYPT_DATA_BLOB
	pReserved as any ptr
end type

type CMS_DH_KEY_INFO as _CMS_DH_KEY_INFO
type PCMS_DH_KEY_INFO as _CMS_DH_KEY_INFO ptr
declare function CryptAcquireContextA(byval phProv as HCRYPTPROV ptr, byval szContainer as LPCSTR, byval szProvider as LPCSTR, byval dwProvType as DWORD, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CryptAcquireContext alias "CryptAcquireContextA"(byval phProv as HCRYPTPROV ptr, byval szContainer as LPCSTR, byval szProvider as LPCSTR, byval dwProvType as DWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function CryptAcquireContextW(byval phProv as HCRYPTPROV ptr, byval szContainer as LPCWSTR, byval szProvider as LPCWSTR, byval dwProvType as DWORD, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CryptAcquireContext alias "CryptAcquireContextW"(byval phProv as HCRYPTPROV ptr, byval szContainer as LPCWSTR, byval szProvider as LPCWSTR, byval dwProvType as DWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function CryptReleaseContext(byval hProv as HCRYPTPROV, byval dwFlags as DWORD) as WINBOOL
declare function CryptGenKey(byval hProv as HCRYPTPROV, byval Algid as ALG_ID, byval dwFlags as DWORD, byval phKey as HCRYPTKEY ptr) as WINBOOL
declare function CryptDeriveKey(byval hProv as HCRYPTPROV, byval Algid as ALG_ID, byval hBaseData as HCRYPTHASH, byval dwFlags as DWORD, byval phKey as HCRYPTKEY ptr) as WINBOOL
declare function CryptDestroyKey(byval hKey as HCRYPTKEY) as WINBOOL
declare function CryptSetKeyParam(byval hKey as HCRYPTKEY, byval dwParam as DWORD, byval pbData as const UBYTE ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptGetKeyParam(byval hKey as HCRYPTKEY, byval dwParam as DWORD, byval pbData as UBYTE ptr, byval pdwDataLen as DWORD ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptSetHashParam(byval hHash as HCRYPTHASH, byval dwParam as DWORD, byval pbData as const UBYTE ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptGetHashParam(byval hHash as HCRYPTHASH, byval dwParam as DWORD, byval pbData as UBYTE ptr, byval pdwDataLen as DWORD ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptSetProvParam(byval hProv as HCRYPTPROV, byval dwParam as DWORD, byval pbData as const UBYTE ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptGetProvParam(byval hProv as HCRYPTPROV, byval dwParam as DWORD, byval pbData as UBYTE ptr, byval pdwDataLen as DWORD ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptGenRandom(byval hProv as HCRYPTPROV, byval dwLen as DWORD, byval pbBuffer as UBYTE ptr) as WINBOOL
declare function CryptGetUserKey(byval hProv as HCRYPTPROV, byval dwKeySpec as DWORD, byval phUserKey as HCRYPTKEY ptr) as WINBOOL
declare function CryptExportKey(byval hKey as HCRYPTKEY, byval hExpKey as HCRYPTKEY, byval dwBlobType as DWORD, byval dwFlags as DWORD, byval pbData as UBYTE ptr, byval pdwDataLen as DWORD ptr) as WINBOOL
declare function CryptImportKey(byval hProv as HCRYPTPROV, byval pbData as const UBYTE ptr, byval dwDataLen as DWORD, byval hPubKey as HCRYPTKEY, byval dwFlags as DWORD, byval phKey as HCRYPTKEY ptr) as WINBOOL
declare function CryptEncrypt(byval hKey as HCRYPTKEY, byval hHash as HCRYPTHASH, byval Final as WINBOOL, byval dwFlags as DWORD, byval pbData as UBYTE ptr, byval pdwDataLen as DWORD ptr, byval dwBufLen as DWORD) as WINBOOL
declare function CryptDecrypt(byval hKey as HCRYPTKEY, byval hHash as HCRYPTHASH, byval Final as WINBOOL, byval dwFlags as DWORD, byval pbData as UBYTE ptr, byval pdwDataLen as DWORD ptr) as WINBOOL
declare function CryptCreateHash(byval hProv as HCRYPTPROV, byval Algid as ALG_ID, byval hKey as HCRYPTKEY, byval dwFlags as DWORD, byval phHash as HCRYPTHASH ptr) as WINBOOL
declare function CryptHashData(byval hHash as HCRYPTHASH, byval pbData as const UBYTE ptr, byval dwDataLen as DWORD, byval dwFlags as DWORD) as WINBOOL
declare function CryptHashSessionKey(byval hHash as HCRYPTHASH, byval hKey as HCRYPTKEY, byval dwFlags as DWORD) as WINBOOL
declare function CryptDestroyHash(byval hHash as HCRYPTHASH) as WINBOOL
declare function CryptSignHashA(byval hHash as HCRYPTHASH, byval dwKeySpec as DWORD, byval szDescription as LPCSTR, byval dwFlags as DWORD, byval pbSignature as UBYTE ptr, byval pdwSigLen as DWORD ptr) as WINBOOL

#ifndef UNICODE
	declare function CryptSignHash alias "CryptSignHashA"(byval hHash as HCRYPTHASH, byval dwKeySpec as DWORD, byval szDescription as LPCSTR, byval dwFlags as DWORD, byval pbSignature as UBYTE ptr, byval pdwSigLen as DWORD ptr) as WINBOOL
#endif

declare function CryptSignHashW(byval hHash as HCRYPTHASH, byval dwKeySpec as DWORD, byval szDescription as LPCWSTR, byval dwFlags as DWORD, byval pbSignature as UBYTE ptr, byval pdwSigLen as DWORD ptr) as WINBOOL

#ifdef UNICODE
	declare function CryptSignHash alias "CryptSignHashW"(byval hHash as HCRYPTHASH, byval dwKeySpec as DWORD, byval szDescription as LPCWSTR, byval dwFlags as DWORD, byval pbSignature as UBYTE ptr, byval pdwSigLen as DWORD ptr) as WINBOOL
#endif

declare function CryptVerifySignatureA(byval hHash as HCRYPTHASH, byval pbSignature as const UBYTE ptr, byval dwSigLen as DWORD, byval hPubKey as HCRYPTKEY, byval szDescription as LPCSTR, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CryptVerifySignature alias "CryptVerifySignatureA"(byval hHash as HCRYPTHASH, byval pbSignature as const UBYTE ptr, byval dwSigLen as DWORD, byval hPubKey as HCRYPTKEY, byval szDescription as LPCSTR, byval dwFlags as DWORD) as WINBOOL
#endif

declare function CryptVerifySignatureW(byval hHash as HCRYPTHASH, byval pbSignature as const UBYTE ptr, byval dwSigLen as DWORD, byval hPubKey as HCRYPTKEY, byval szDescription as LPCWSTR, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CryptVerifySignature alias "CryptVerifySignatureW"(byval hHash as HCRYPTHASH, byval pbSignature as const UBYTE ptr, byval dwSigLen as DWORD, byval hPubKey as HCRYPTKEY, byval szDescription as LPCWSTR, byval dwFlags as DWORD) as WINBOOL
#endif

declare function CryptSetProviderA(byval pszProvName as LPCSTR, byval dwProvType as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CryptSetProvider alias "CryptSetProviderA"(byval pszProvName as LPCSTR, byval dwProvType as DWORD) as WINBOOL
#endif

declare function CryptSetProviderW(byval pszProvName as LPCWSTR, byval dwProvType as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CryptSetProvider alias "CryptSetProviderW"(byval pszProvName as LPCWSTR, byval dwProvType as DWORD) as WINBOOL
#endif

declare function CryptSetProviderExA(byval pszProvName as LPCSTR, byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CryptSetProviderEx alias "CryptSetProviderExA"(byval pszProvName as LPCSTR, byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD) as WINBOOL
#endif

declare function CryptSetProviderExW(byval pszProvName as LPCWSTR, byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CryptSetProviderEx alias "CryptSetProviderExW"(byval pszProvName as LPCWSTR, byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD) as WINBOOL
#endif

declare function CryptGetDefaultProviderA(byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pszProvName as LPSTR, byval pcbProvName as DWORD ptr) as WINBOOL

#ifndef UNICODE
	declare function CryptGetDefaultProvider alias "CryptGetDefaultProviderA"(byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pszProvName as LPSTR, byval pcbProvName as DWORD ptr) as WINBOOL
#endif

declare function CryptGetDefaultProviderW(byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pszProvName as LPWSTR, byval pcbProvName as DWORD ptr) as WINBOOL

#ifdef UNICODE
	declare function CryptGetDefaultProvider alias "CryptGetDefaultProviderW"(byval dwProvType as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pszProvName as LPWSTR, byval pcbProvName as DWORD ptr) as WINBOOL
#endif

declare function CryptEnumProviderTypesA(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szTypeName as LPSTR, byval pcbTypeName as DWORD ptr) as WINBOOL

#ifndef UNICODE
	declare function CryptEnumProviderTypes alias "CryptEnumProviderTypesA"(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szTypeName as LPSTR, byval pcbTypeName as DWORD ptr) as WINBOOL
#endif

declare function CryptEnumProviderTypesW(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szTypeName as LPWSTR, byval pcbTypeName as DWORD ptr) as WINBOOL

#ifdef UNICODE
	declare function CryptEnumProviderTypes alias "CryptEnumProviderTypesW"(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szTypeName as LPWSTR, byval pcbTypeName as DWORD ptr) as WINBOOL
#endif

declare function CryptEnumProvidersA(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szProvName as LPSTR, byval pcbProvName as DWORD ptr) as WINBOOL

#ifndef UNICODE
	declare function CryptEnumProviders alias "CryptEnumProvidersA"(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szProvName as LPSTR, byval pcbProvName as DWORD ptr) as WINBOOL
#endif

declare function CryptEnumProvidersW(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szProvName as LPWSTR, byval pcbProvName as DWORD ptr) as WINBOOL

#ifdef UNICODE
	declare function CryptEnumProviders alias "CryptEnumProvidersW"(byval dwIndex as DWORD, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval pdwProvType as DWORD ptr, byval szProvName as LPWSTR, byval pcbProvName as DWORD ptr) as WINBOOL
#endif

declare function CryptContextAddRef(byval hProv as HCRYPTPROV, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptDuplicateKey(byval hKey as HCRYPTKEY, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval phKey as HCRYPTKEY ptr) as WINBOOL
declare function CryptDuplicateHash(byval hHash as HCRYPTHASH, byval pdwReserved as DWORD ptr, byval dwFlags as DWORD, byval phHash as HCRYPTHASH ptr) as WINBOOL
declare function GetEncSChannel cdecl(byval pData as UBYTE ptr ptr, byval dwDecSize as DWORD ptr) as WINBOOL
type HCRYPTPROV_OR_NCRYPT_KEY_HANDLE as ULONG_PTR
type HCRYPTPROV_LEGACY as ULONG_PTR

end extern

#include once "bcrypt.bi"
#include once "ncrypt.bi"

extern "Windows"

type _CRYPT_BIT_BLOB
	cbData as DWORD
	pbData as UBYTE ptr
	cUnusedBits as DWORD
end type

type CRYPT_BIT_BLOB as _CRYPT_BIT_BLOB
type PCRYPT_BIT_BLOB as _CRYPT_BIT_BLOB ptr

type _CRYPT_ALGORITHM_IDENTIFIER
	pszObjId as LPSTR
	Parameters as CRYPT_OBJID_BLOB
end type

type CRYPT_ALGORITHM_IDENTIFIER as _CRYPT_ALGORITHM_IDENTIFIER
type PCRYPT_ALGORITHM_IDENTIFIER as _CRYPT_ALGORITHM_IDENTIFIER ptr
#define szOID_RSA "1.2.840.113549"
#define szOID_PKCS "1.2.840.113549.1"
#define szOID_RSA_HASH "1.2.840.113549.2"
#define szOID_RSA_ENCRYPT "1.2.840.113549.3"
#define szOID_PKCS_1 "1.2.840.113549.1.1"
#define szOID_PKCS_2 "1.2.840.113549.1.2"
#define szOID_PKCS_3 "1.2.840.113549.1.3"
#define szOID_PKCS_4 "1.2.840.113549.1.4"
#define szOID_PKCS_5 "1.2.840.113549.1.5"
#define szOID_PKCS_6 "1.2.840.113549.1.6"
#define szOID_PKCS_7 "1.2.840.113549.1.7"
#define szOID_PKCS_8 "1.2.840.113549.1.8"
#define szOID_PKCS_9 "1.2.840.113549.1.9"
#define szOID_PKCS_10 "1.2.840.113549.1.10"
#define szOID_PKCS_12 "1.2.840.113549.1.12"
#define szOID_RSA_RSA "1.2.840.113549.1.1.1"
#define szOID_RSA_MD2RSA "1.2.840.113549.1.1.2"
#define szOID_RSA_MD4RSA "1.2.840.113549.1.1.3"
#define szOID_RSA_MD5RSA "1.2.840.113549.1.1.4"
#define szOID_RSA_SHA1RSA "1.2.840.113549.1.1.5"
#define szOID_RSA_SETOAEP_RSA "1.2.840.113549.1.1.6"
#define szOID_RSAES_OAEP "1.2.840.113549.1.1.7"
#define szOID_RSA_MGF1 "1.2.840.113549.1.1.8"
#define szOID_RSA_PSPECIFIED "1.2.840.113549.1.1.9"
#define szOID_RSA_SSA_PSS "1.2.840.113549.1.1.10"
#define szOID_RSA_SHA256RSA "1.2.840.113549.1.1.11"
#define szOID_RSA_SHA384RSA "1.2.840.113549.1.1.12"
#define szOID_RSA_SHA512RSA "1.2.840.113549.1.1.13"
#define szOID_RSA_DH "1.2.840.113549.1.3.1"
#define szOID_RSA_data "1.2.840.113549.1.7.1"
#define szOID_RSA_signedData "1.2.840.113549.1.7.2"
#define szOID_RSA_envelopedData "1.2.840.113549.1.7.3"
#define szOID_RSA_signEnvData "1.2.840.113549.1.7.4"
#define szOID_RSA_digestedData "1.2.840.113549.1.7.5"
#define szOID_RSA_hashedData "1.2.840.113549.1.7.5"
#define szOID_RSA_encryptedData "1.2.840.113549.1.7.6"
#define szOID_RSA_emailAddr "1.2.840.113549.1.9.1"
#define szOID_RSA_unstructName "1.2.840.113549.1.9.2"
#define szOID_RSA_contentType "1.2.840.113549.1.9.3"
#define szOID_RSA_messageDigest "1.2.840.113549.1.9.4"
#define szOID_RSA_signingTime "1.2.840.113549.1.9.5"
#define szOID_RSA_counterSign "1.2.840.113549.1.9.6"
#define szOID_RSA_challengePwd "1.2.840.113549.1.9.7"
#define szOID_RSA_unstructAddr "1.2.840.113549.1.9.8"
#define szOID_RSA_extCertAttrs "1.2.840.113549.1.9.9"
#define szOID_RSA_certExtensions "1.2.840.113549.1.9.14"
#define szOID_RSA_SMIMECapabilities "1.2.840.113549.1.9.15"
#define szOID_RSA_preferSignedData "1.2.840.113549.1.9.15.1"
#define szOID_TIMESTAMP_TOKEN "1.2.840.113549.1.9.16.1.4"
#define szOID_RFC3161_counterSign "1.3.6.1.4.1.311.3.3.1"
#define szOID_RSA_SMIMEalg "1.2.840.113549.1.9.16.3"
#define szOID_RSA_SMIMEalgESDH "1.2.840.113549.1.9.16.3.5"
#define szOID_RSA_SMIMEalgCMS3DESwrap "1.2.840.113549.1.9.16.3.6"
#define szOID_RSA_SMIMEalgCMSRC2wrap "1.2.840.113549.1.9.16.3.7"
#define szOID_RSA_MD2 "1.2.840.113549.2.2"
#define szOID_RSA_MD4 "1.2.840.113549.2.4"
#define szOID_RSA_MD5 "1.2.840.113549.2.5"
#define szOID_RSA_RC2CBC "1.2.840.113549.3.2"
#define szOID_RSA_RC4 "1.2.840.113549.3.4"
#define szOID_RSA_DES_EDE3_CBC "1.2.840.113549.3.7"
#define szOID_RSA_RC5_CBCPad "1.2.840.113549.3.9"
#define szOID_ANSI_X942 "1.2.840.10046"
#define szOID_ANSI_X942_DH "1.2.840.10046.2.1"
#define szOID_X957 "1.2.840.10040"
#define szOID_X957_DSA "1.2.840.10040.4.1"
#define szOID_X957_SHA1DSA "1.2.840.10040.4.3"
#define szOID_ECC_PUBLIC_KEY "1.2.840.10045.2.1"
#define szOID_ECC_CURVE_P256 "1.2.840.10045.3.1.7"
#define szOID_ECC_CURVE_P384 "1.3.132.0.34"
#define szOID_ECC_CURVE_P521 "1.3.132.0.35"
#define szOID_ECDSA_SHA1 "1.2.840.10045.4.1"
#define szOID_ECDSA_SPECIFIED "1.2.840.10045.4.3"
#define szOID_ECDSA_SHA256 "1.2.840.10045.4.3.2"
#define szOID_ECDSA_SHA384 "1.2.840.10045.4.3.3"
#define szOID_ECDSA_SHA512 "1.2.840.10045.4.3.4"
#define szOID_NIST_AES128_CBC "2.16.840.1.101.3.4.1.2"
#define szOID_NIST_AES192_CBC "2.16.840.1.101.3.4.1.22"
#define szOID_NIST_AES256_CBC "2.16.840.1.101.3.4.1.42"
#define szOID_NIST_AES128_WRAP "2.16.840.1.101.3.4.1.5"
#define szOID_NIST_AES192_WRAP "2.16.840.1.101.3.4.1.25"
#define szOID_NIST_AES256_WRAP "2.16.840.1.101.3.4.1.45"
#define szOID_DH_SINGLE_PASS_STDDH_SHA1_KDF "1.3.133.16.840.63.0.2"
#define szOID_DH_SINGLE_PASS_STDDH_SHA256_KDF "1.3.132.1.11.1"
#define szOID_DH_SINGLE_PASS_STDDH_SHA384_KDF "1.3.132.1.11.2"
#define szOID_DS "2.5"
#define szOID_DSALG "2.5.8"
#define szOID_DSALG_CRPT "2.5.8.1"
#define szOID_DSALG_HASH "2.5.8.2"
#define szOID_DSALG_SIGN "2.5.8.3"
#define szOID_DSALG_RSA "2.5.8.1.1"
#define szOID_OIW "1.3.14"
#define szOID_OIWSEC "1.3.14.3.2"
#define szOID_OIWSEC_md4RSA "1.3.14.3.2.2"
#define szOID_OIWSEC_md5RSA "1.3.14.3.2.3"
#define szOID_OIWSEC_md4RSA2 "1.3.14.3.2.4"
#define szOID_OIWSEC_desECB "1.3.14.3.2.6"
#define szOID_OIWSEC_desCBC "1.3.14.3.2.7"
#define szOID_OIWSEC_desOFB "1.3.14.3.2.8"
#define szOID_OIWSEC_desCFB "1.3.14.3.2.9"
#define szOID_OIWSEC_desMAC "1.3.14.3.2.10"
#define szOID_OIWSEC_rsaSign "1.3.14.3.2.11"
#define szOID_OIWSEC_dsa "1.3.14.3.2.12"
#define szOID_OIWSEC_shaDSA "1.3.14.3.2.13"
#define szOID_OIWSEC_mdc2RSA "1.3.14.3.2.14"
#define szOID_OIWSEC_shaRSA "1.3.14.3.2.15"
#define szOID_OIWSEC_dhCommMod "1.3.14.3.2.16"
#define szOID_OIWSEC_desEDE "1.3.14.3.2.17"
#define szOID_OIWSEC_sha "1.3.14.3.2.18"
#define szOID_OIWSEC_mdc2 "1.3.14.3.2.19"
#define szOID_OIWSEC_dsaComm "1.3.14.3.2.20"
#define szOID_OIWSEC_dsaCommSHA "1.3.14.3.2.21"
#define szOID_OIWSEC_rsaXchg "1.3.14.3.2.22"
#define szOID_OIWSEC_keyHashSeal "1.3.14.3.2.23"
#define szOID_OIWSEC_md2RSASign "1.3.14.3.2.24"
#define szOID_OIWSEC_md5RSASign "1.3.14.3.2.25"
#define szOID_OIWSEC_sha1 "1.3.14.3.2.26"
#define szOID_OIWSEC_dsaSHA1 "1.3.14.3.2.27"
#define szOID_OIWSEC_dsaCommSHA1 "1.3.14.3.2.28"
#define szOID_OIWSEC_sha1RSASign "1.3.14.3.2.29"
#define szOID_OIWDIR "1.3.14.7.2"
#define szOID_OIWDIR_CRPT "1.3.14.7.2.1"
#define szOID_OIWDIR_HASH "1.3.14.7.2.2"
#define szOID_OIWDIR_SIGN "1.3.14.7.2.3"
#define szOID_OIWDIR_md2 "1.3.14.7.2.2.1"
#define szOID_OIWDIR_md2RSA "1.3.14.7.2.3.1"
#define szOID_INFOSEC "2.16.840.1.101.2.1"
#define szOID_INFOSEC_sdnsSignature "2.16.840.1.101.2.1.1.1"
#define szOID_INFOSEC_mosaicSignature "2.16.840.1.101.2.1.1.2"
#define szOID_INFOSEC_sdnsConfidentiality "2.16.840.1.101.2.1.1.3"
#define szOID_INFOSEC_mosaicConfidentiality "2.16.840.1.101.2.1.1.4"
#define szOID_INFOSEC_sdnsIntegrity "2.16.840.1.101.2.1.1.5"
#define szOID_INFOSEC_mosaicIntegrity "2.16.840.1.101.2.1.1.6"
#define szOID_INFOSEC_sdnsTokenProtection "2.16.840.1.101.2.1.1.7"
#define szOID_INFOSEC_mosaicTokenProtection "2.16.840.1.101.2.1.1.8"
#define szOID_INFOSEC_sdnsKeyManagement "2.16.840.1.101.2.1.1.9"
#define szOID_INFOSEC_mosaicKeyManagement "2.16.840.1.101.2.1.1.10"
#define szOID_INFOSEC_sdnsKMandSig "2.16.840.1.101.2.1.1.11"
#define szOID_INFOSEC_mosaicKMandSig "2.16.840.1.101.2.1.1.12"
#define szOID_INFOSEC_SuiteASignature "2.16.840.1.101.2.1.1.13"
#define szOID_INFOSEC_SuiteAConfidentiality "2.16.840.1.101.2.1.1.14"
#define szOID_INFOSEC_SuiteAIntegrity "2.16.840.1.101.2.1.1.15"
#define szOID_INFOSEC_SuiteATokenProtection "2.16.840.1.101.2.1.1.16"
#define szOID_INFOSEC_SuiteAKeyManagement "2.16.840.1.101.2.1.1.17"
#define szOID_INFOSEC_SuiteAKMandSig "2.16.840.1.101.2.1.1.18"
#define szOID_INFOSEC_mosaicUpdatedSig "2.16.840.1.101.2.1.1.19"
#define szOID_INFOSEC_mosaicKMandUpdSig "2.16.840.1.101.2.1.1.20"
#define szOID_INFOSEC_mosaicUpdatedInteg "2.16.840.1.101.2.1.1.21"
#define szOID_NIST_sha256 "2.16.840.1.101.3.4.2.1"
#define szOID_NIST_sha384 "2.16.840.1.101.3.4.2.2"
#define szOID_NIST_sha512 "2.16.840.1.101.3.4.2.3"

type _CRYPT_OBJID_TABLE
	dwAlgId as DWORD
	pszObjId as LPCSTR
end type

type CRYPT_OBJID_TABLE as _CRYPT_OBJID_TABLE
type PCRYPT_OBJID_TABLE as _CRYPT_OBJID_TABLE ptr

type _CRYPT_HASH_INFO
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Hash as CRYPT_HASH_BLOB
end type

type CRYPT_HASH_INFO as _CRYPT_HASH_INFO
type PCRYPT_HASH_INFO as _CRYPT_HASH_INFO ptr

type _CERT_EXTENSION
	pszObjId as LPSTR
	fCritical as WINBOOL
	Value as CRYPT_OBJID_BLOB
end type

type CERT_EXTENSION as _CERT_EXTENSION
type PCERT_EXTENSION as _CERT_EXTENSION ptr
type PCCERT_EXTENSION as const CERT_EXTENSION ptr

type _CRYPT_ATTRIBUTE_TYPE_VALUE
	pszObjId as LPSTR
	Value as CRYPT_OBJID_BLOB
end type

type CRYPT_ATTRIBUTE_TYPE_VALUE as _CRYPT_ATTRIBUTE_TYPE_VALUE
type PCRYPT_ATTRIBUTE_TYPE_VALUE as _CRYPT_ATTRIBUTE_TYPE_VALUE ptr

type _CRYPT_ATTRIBUTE
	pszObjId as LPSTR
	cValue as DWORD
	rgValue as PCRYPT_ATTR_BLOB
end type

type CRYPT_ATTRIBUTE as _CRYPT_ATTRIBUTE
type PCRYPT_ATTRIBUTE as _CRYPT_ATTRIBUTE ptr

type _CRYPT_ATTRIBUTES
	cAttr as DWORD
	rgAttr as PCRYPT_ATTRIBUTE
end type

type CRYPT_ATTRIBUTES as _CRYPT_ATTRIBUTES
type PCRYPT_ATTRIBUTES as _CRYPT_ATTRIBUTES ptr

type _CERT_RDN_ATTR
	pszObjId as LPSTR
	dwValueType as DWORD
	Value as CERT_RDN_VALUE_BLOB
end type

type CERT_RDN_ATTR as _CERT_RDN_ATTR
type PCERT_RDN_ATTR as _CERT_RDN_ATTR ptr
#define szOID_COMMON_NAME "2.5.4.3"
#define szOID_SUR_NAME "2.5.4.4"
#define szOID_DEVICE_SERIAL_NUMBER "2.5.4.5"
#define szOID_COUNTRY_NAME "2.5.4.6"
#define szOID_LOCALITY_NAME "2.5.4.7"
#define szOID_STATE_OR_PROVINCE_NAME "2.5.4.8"
#define szOID_STREET_ADDRESS "2.5.4.9"
#define szOID_ORGANIZATION_NAME "2.5.4.10"
#define szOID_ORGANIZATIONAL_UNIT_NAME "2.5.4.11"
#define szOID_TITLE "2.5.4.12"
#define szOID_DESCRIPTION "2.5.4.13"
#define szOID_SEARCH_GUIDE "2.5.4.14"
#define szOID_BUSINESS_CATEGORY "2.5.4.15"
#define szOID_POSTAL_ADDRESS "2.5.4.16"
#define szOID_POSTAL_CODE "2.5.4.17"
#define szOID_POST_OFFICE_BOX "2.5.4.18"
#define szOID_PHYSICAL_DELIVERY_OFFICE_NAME "2.5.4.19"
#define szOID_TELEPHONE_NUMBER "2.5.4.20"
#define szOID_TELEX_NUMBER "2.5.4.21"
#define szOID_TELETEXT_TERMINAL_IDENTIFIER "2.5.4.22"
#define szOID_FACSIMILE_TELEPHONE_NUMBER "2.5.4.23"
#define szOID_X21_ADDRESS "2.5.4.24"
#define szOID_INTERNATIONAL_ISDN_NUMBER "2.5.4.25"
#define szOID_REGISTERED_ADDRESS "2.5.4.26"
#define szOID_DESTINATION_INDICATOR "2.5.4.27"
#define szOID_PREFERRED_DELIVERY_METHOD "2.5.4.28"
#define szOID_PRESENTATION_ADDRESS "2.5.4.29"
#define szOID_SUPPORTED_APPLICATION_CONTEXT "2.5.4.30"
#define szOID_MEMBER "2.5.4.31"
#define szOID_OWNER "2.5.4.32"
#define szOID_ROLE_OCCUPANT "2.5.4.33"
#define szOID_SEE_ALSO "2.5.4.34"
#define szOID_USER_PASSWORD "2.5.4.35"
#define szOID_USER_CERTIFICATE "2.5.4.36"
#define szOID_CA_CERTIFICATE "2.5.4.37"
#define szOID_AUTHORITY_REVOCATION_LIST "2.5.4.38"
#define szOID_CERTIFICATE_REVOCATION_LIST "2.5.4.39"
#define szOID_CROSS_CERTIFICATE_PAIR "2.5.4.40"
#define szOID_GIVEN_NAME "2.5.4.42"
#define szOID_INITIALS "2.5.4.43"
#define szOID_DN_QUALIFIER "2.5.4.46"
#define szOID_DOMAIN_COMPONENT "0.9.2342.19200300.100.1.25"
#define szOID_PKCS_12_FRIENDLY_NAME_ATTR "1.2.840.113549.1.9.20"
#define szOID_PKCS_12_LOCAL_KEY_ID "1.2.840.113549.1.9.21"
#define szOID_PKCS_12_KEY_PROVIDER_NAME_ATTR "1.3.6.1.4.1.311.17.1"
#define szOID_LOCAL_MACHINE_KEYSET "1.3.6.1.4.1.311.17.2"
#define szOID_PKCS_12_EXTENDED_ATTRIBUTES "1.3.6.1.4.1.311.17.3"
#define szOID_PKCS_12_PROTECTED_PASSWORD_SECRET_BAG_TYPE_ID "1.3.6.1.4.1.311.17.4"
#define szOID_KEYID_RDN "1.3.6.1.4.1.311.10.7.1"
#define szOID_EV_RDN_LOCALE "1.3.6.1.4.1.311.60.2.1.1"
#define szOID_EV_RDN_STATE_OR_PROVINCE "1.3.6.1.4.1.311.60.2.1.2"
#define szOID_EV_RDN_COUNTRY "1.3.6.1.4.1.311.60.2.1.3"
const CERT_RDN_ANY_TYPE = 0
const CERT_RDN_ENCODED_BLOB = 1
const CERT_RDN_OCTET_STRING = 2
const CERT_RDN_NUMERIC_STRING = 3
const CERT_RDN_PRINTABLE_STRING = 4
const CERT_RDN_TELETEX_STRING = 5
const CERT_RDN_T61_STRING = 5
const CERT_RDN_VIDEOTEX_STRING = 6
const CERT_RDN_IA5_STRING = 7
const CERT_RDN_GRAPHIC_STRING = 8
const CERT_RDN_VISIBLE_STRING = 9
const CERT_RDN_ISO646_STRING = 9
const CERT_RDN_GENERAL_STRING = 10
const CERT_RDN_UNIVERSAL_STRING = 11
const CERT_RDN_INT4_STRING = 11
const CERT_RDN_BMP_STRING = 12
const CERT_RDN_UNICODE_STRING = 12
const CERT_RDN_UTF8_STRING = 13
const CERT_RDN_TYPE_MASK = &h000000ff
const CERT_RDN_FLAGS_MASK = &hff000000
const CERT_RDN_ENABLE_T61_UNICODE_FLAG = &h80000000
const CERT_RDN_ENABLE_UTF8_UNICODE_FLAG = &h20000000
const CERT_RDN_FORCE_UTF8_UNICODE_FLAG = &h10000000
const CERT_RDN_DISABLE_CHECK_TYPE_FLAG = &h40000000
const CERT_RDN_DISABLE_IE4_UTF8_FLAG = &h1000000
const CERT_RDN_ENABLE_PUNYCODE_FLAG = &h2000000
#define IS_CERT_RDN_CHAR_STRING(X) (((X) and CERT_RDN_TYPE_MASK) >= CERT_RDN_NUMERIC_STRING)

type _CERT_RDN
	cRDNAttr as DWORD
	rgRDNAttr as PCERT_RDN_ATTR
end type

type CERT_RDN as _CERT_RDN
type PCERT_RDN as _CERT_RDN ptr

type _CERT_NAME_INFO
	cRDN as DWORD
	rgRDN as PCERT_RDN
end type

type CERT_NAME_INFO as _CERT_NAME_INFO
type PCERT_NAME_INFO as _CERT_NAME_INFO ptr

type _CERT_NAME_VALUE
	dwValueType as DWORD
	Value as CERT_RDN_VALUE_BLOB
end type

type CERT_NAME_VALUE as _CERT_NAME_VALUE
type PCERT_NAME_VALUE as _CERT_NAME_VALUE ptr

type _CERT_PUBLIC_KEY_INFO
	Algorithm as CRYPT_ALGORITHM_IDENTIFIER
	PublicKey as CRYPT_BIT_BLOB
end type

type CERT_PUBLIC_KEY_INFO as _CERT_PUBLIC_KEY_INFO
type PCERT_PUBLIC_KEY_INFO as _CERT_PUBLIC_KEY_INFO ptr
#define CERT_RSA_PUBLIC_KEY_OBJID szOID_RSA_RSA
#define CERT_DEFAULT_OID_PUBLIC_KEY_SIGN szOID_RSA_RSA
#define CERT_DEFAULT_OID_PUBLIC_KEY_XCHG szOID_RSA_RSA

type _CRYPT_ECC_PRIVATE_KEY_INFO
	dwVersion as DWORD
	PrivateKey as CRYPT_DER_BLOB
	szCurveOid as LPSTR
	PublicKey as CRYPT_BIT_BLOB
end type

type CRYPT_ECC_PRIVATE_KEY_INFO as _CRYPT_ECC_PRIVATE_KEY_INFO
type PCRYPT_ECC_PRIVATE_KEY_INFO as _CRYPT_ECC_PRIVATE_KEY_INFO ptr
const CRYPT_ECC_PRIVATE_KEY_INFO_v1 = 1

type _CRYPT_PRIVATE_KEY_INFO
	Version as DWORD
	Algorithm as CRYPT_ALGORITHM_IDENTIFIER
	PrivateKey as CRYPT_DER_BLOB
	pAttributes as PCRYPT_ATTRIBUTES
end type

type CRYPT_PRIVATE_KEY_INFO as _CRYPT_PRIVATE_KEY_INFO
type PCRYPT_PRIVATE_KEY_INFO as _CRYPT_PRIVATE_KEY_INFO ptr

type _CRYPT_ENCRYPTED_PRIVATE_KEY_INFO
	EncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedPrivateKey as CRYPT_DATA_BLOB
end type

type CRYPT_ENCRYPTED_PRIVATE_KEY_INFO as _CRYPT_ENCRYPTED_PRIVATE_KEY_INFO
type PCRYPT_ENCRYPTED_PRIVATE_KEY_INFO as _CRYPT_ENCRYPTED_PRIVATE_KEY_INFO ptr
type PCRYPT_DECRYPT_PRIVATE_KEY_FUNC as function(byval Algorithm as CRYPT_ALGORITHM_IDENTIFIER, byval EncryptedPrivateKey as CRYPT_DATA_BLOB, byval pbClearTextKey as UBYTE ptr, byval pcbClearTextKey as DWORD ptr, byval pVoidDecryptFunc as LPVOID) as WINBOOL
type PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC as function(byval pAlgorithm as CRYPT_ALGORITHM_IDENTIFIER ptr, byval pClearTextPrivateKey as CRYPT_DATA_BLOB ptr, byval pbEncryptedKey as UBYTE ptr, byval pcbEncryptedKey as DWORD ptr, byval pVoidEncryptFunc as LPVOID) as WINBOOL
type PCRYPT_RESOLVE_HCRYPTPROV_FUNC as function(byval pPrivateKeyInfo as CRYPT_PRIVATE_KEY_INFO ptr, byval phCryptProv as HCRYPTPROV ptr, byval pVoidResolveFunc as LPVOID) as WINBOOL

type _CRYPT_PKCS8_IMPORT_PARAMS
	PrivateKey as CRYPT_DIGEST_BLOB
	pResolvehCryptProvFunc as PCRYPT_RESOLVE_HCRYPTPROV_FUNC
	pVoidResolveFunc as LPVOID
	pDecryptPrivateKeyFunc as PCRYPT_DECRYPT_PRIVATE_KEY_FUNC
	pVoidDecryptFunc as LPVOID
end type

type CRYPT_PKCS8_IMPORT_PARAMS as _CRYPT_PKCS8_IMPORT_PARAMS
type PCRYPT_PKCS8_IMPORT_PARAMS as _CRYPT_PKCS8_IMPORT_PARAMS ptr
type CRYPT_PRIVATE_KEY_BLOB_AND_PARAMS as _CRYPT_PKCS8_IMPORT_PARAMS
type PCRYPT_PRIVATE_KEY_BLOB_AND_PARAMS as _CRYPT_PKCS8_IMPORT_PARAMS ptr

type _CRYPT_PKCS8_EXPORT_PARAMS
	hCryptProv as HCRYPTPROV
	dwKeySpec as DWORD
	pszPrivateKeyObjId as LPSTR
	pEncryptPrivateKeyFunc as PCRYPT_ENCRYPT_PRIVATE_KEY_FUNC
	pVoidEncryptFunc as LPVOID
end type

type CRYPT_PKCS8_EXPORT_PARAMS as _CRYPT_PKCS8_EXPORT_PARAMS
type PCRYPT_PKCS8_EXPORT_PARAMS as _CRYPT_PKCS8_EXPORT_PARAMS ptr

type _CERT_INFO
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

type CERT_INFO as _CERT_INFO
type PCERT_INFO as _CERT_INFO ptr
const CERT_V1 = 0
const CERT_V2 = 1
const CERT_V3 = 2
const CERT_INFO_VERSION_FLAG = 1
const CERT_INFO_SERIAL_NUMBER_FLAG = 2
const CERT_INFO_SIGNATURE_ALGORITHM_FLAG = 3
const CERT_INFO_ISSUER_FLAG = 4
const CERT_INFO_NOT_BEFORE_FLAG = 5
const CERT_INFO_NOT_AFTER_FLAG = 6
const CERT_INFO_SUBJECT_FLAG = 7
const CERT_INFO_SUBJECT_PUBLIC_KEY_INFO_FLAG = 8
const CERT_INFO_ISSUER_UNIQUE_ID_FLAG = 9
const CERT_INFO_SUBJECT_UNIQUE_ID_FLAG = 10
const CERT_INFO_EXTENSION_FLAG = 11

type _CRL_ENTRY
	SerialNumber as CRYPT_INTEGER_BLOB
	RevocationDate as FILETIME
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type CRL_ENTRY as _CRL_ENTRY
type PCRL_ENTRY as _CRL_ENTRY ptr

type _CRL_INFO
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

type CRL_INFO as _CRL_INFO
type PCRL_INFO as _CRL_INFO ptr
const CRL_V1 = 0
const CRL_V2 = 1
const CERT_BUNDLE_CERTIFICATE = 0
const CERT_BUNDLE_CRL = 1

type _CERT_OR_CRL_BLOB
	dwChoice as DWORD
	cbEncoded as DWORD
	pbEncoded as UBYTE ptr
end type

type CERT_OR_CRL_BLOB as _CERT_OR_CRL_BLOB
type PCERT_OR_CRL_BLOB as _CERT_OR_CRL_BLOB ptr

type _CERT_OR_CRL_BUNDLE
	cItem as DWORD
	rgItem as PCERT_OR_CRL_BLOB
end type

type CERT_OR_CRL_BUNDLE as _CERT_OR_CRL_BUNDLE
type PCERT_OR_CRL_BUNDLE as _CERT_OR_CRL_BUNDLE ptr

type _CERT_REQUEST_INFO
	dwVersion as DWORD
	Subject as CERT_NAME_BLOB
	SubjectPublicKeyInfo as CERT_PUBLIC_KEY_INFO
	cAttribute as DWORD
	rgAttribute as PCRYPT_ATTRIBUTE
end type

type CERT_REQUEST_INFO as _CERT_REQUEST_INFO
type PCERT_REQUEST_INFO as _CERT_REQUEST_INFO ptr
const CERT_REQUEST_V1 = 0

type _CERT_KEYGEN_REQUEST_INFO
	dwVersion as DWORD
	SubjectPublicKeyInfo as CERT_PUBLIC_KEY_INFO
	pwszChallengeString as LPWSTR
end type

type CERT_KEYGEN_REQUEST_INFO as _CERT_KEYGEN_REQUEST_INFO
type PCERT_KEYGEN_REQUEST_INFO as _CERT_KEYGEN_REQUEST_INFO ptr
const CERT_KEYGEN_REQUEST_V1 = 0

type _CERT_SIGNED_CONTENT_INFO
	ToBeSigned as CRYPT_DER_BLOB
	SignatureAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Signature as CRYPT_BIT_BLOB
end type

type CERT_SIGNED_CONTENT_INFO as _CERT_SIGNED_CONTENT_INFO
type PCERT_SIGNED_CONTENT_INFO as _CERT_SIGNED_CONTENT_INFO ptr

type _CTL_USAGE
	cUsageIdentifier as DWORD
	rgpszUsageIdentifier as LPSTR ptr
end type

type CTL_USAGE as _CTL_USAGE
type PCTL_USAGE as _CTL_USAGE ptr
type CERT_ENHKEY_USAGE as _CTL_USAGE
type PCERT_ENHKEY_USAGE as _CTL_USAGE ptr
type PCCTL_USAGE as const CTL_USAGE ptr
type PCCERT_ENHKEY_USAGE as const CERT_ENHKEY_USAGE ptr

type _CTL_ENTRY
	SubjectIdentifier as CRYPT_DATA_BLOB
	cAttribute as DWORD
	rgAttribute as PCRYPT_ATTRIBUTE
end type

type CTL_ENTRY as _CTL_ENTRY
type PCTL_ENTRY as _CTL_ENTRY ptr

type _CTL_INFO
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

type CTL_INFO as _CTL_INFO
type PCTL_INFO as _CTL_INFO ptr
const CTL_V1 = 0

type _CRYPT_TIME_STAMP_REQUEST_INFO
	pszTimeStampAlgorithm as LPSTR
	pszContentType as LPSTR
	Content as CRYPT_OBJID_BLOB
	cAttribute as DWORD
	rgAttribute as PCRYPT_ATTRIBUTE
end type

type CRYPT_TIME_STAMP_REQUEST_INFO as _CRYPT_TIME_STAMP_REQUEST_INFO
type PCRYPT_TIME_STAMP_REQUEST_INFO as _CRYPT_TIME_STAMP_REQUEST_INFO ptr

type _CRYPT_ENROLLMENT_NAME_VALUE_PAIR
	pwszName as LPWSTR
	pwszValue as LPWSTR
end type

type CRYPT_ENROLLMENT_NAME_VALUE_PAIR as _CRYPT_ENROLLMENT_NAME_VALUE_PAIR
type PCRYPT_ENROLLMENT_NAME_VALUE_PAIR as _CRYPT_ENROLLMENT_NAME_VALUE_PAIR ptr

type _CRYPT_CSP_PROVIDER
	dwKeySpec as DWORD
	pwszProviderName as LPWSTR
	Signature as CRYPT_BIT_BLOB
end type

type CRYPT_CSP_PROVIDER as _CRYPT_CSP_PROVIDER
type PCRYPT_CSP_PROVIDER as _CRYPT_CSP_PROVIDER ptr
const CERT_ENCODING_TYPE_MASK = &h0000ffff
const CMSG_ENCODING_TYPE_MASK = &hffff0000
#define GET_CERT_ENCODING_TYPE(T) (T and CERT_ENCODING_TYPE_MASK)
#define GET_CMSG_ENCODING_TYPE(T) (T and CMSG_ENCODING_TYPE_MASK)
const CRYPT_ASN_ENCODING = &h1
const CRYPT_NDR_ENCODING = &h2
const X509_ASN_ENCODING = &h1
const X509_NDR_ENCODING = &h2
const PKCS_7_ASN_ENCODING = &h10000
const PKCS_7_NDR_ENCODING = &h20000
declare function CryptFormatObject(byval dwCertEncodingType as DWORD, byval dwFormatType as DWORD, byval dwFormatStrType as DWORD, byval pFormatStruct as any ptr, byval lpszStructType as LPCSTR, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval pbFormat as any ptr, byval pcbFormat as DWORD ptr) as WINBOOL
const CRYPT_FORMAT_STR_MULTI_LINE = &h1
const CRYPT_FORMAT_STR_NO_HEX = &h10
const CRYPT_FORMAT_SIMPLE = &h1
const CRYPT_FORMAT_X509 = &h2
const CRYPT_FORMAT_OID = &h4
const CRYPT_FORMAT_RDN_SEMICOLON = &h100
const CRYPT_FORMAT_RDN_CRLF = &h200
const CRYPT_FORMAT_RDN_UNQUOTE = &h400
const CRYPT_FORMAT_RDN_REVERSE = &h800
const CRYPT_FORMAT_COMMA = &h1000
const CRYPT_FORMAT_SEMICOLON = CRYPT_FORMAT_RDN_SEMICOLON
const CRYPT_FORMAT_CRLF = CRYPT_FORMAT_RDN_CRLF
type PFN_CRYPT_ALLOC as function(byval cbSize as uinteger) as LPVOID
type PFN_CRYPT_FREE as sub(byval pv as LPVOID)

type _CRYPT_ENCODE_PARA
	cbSize as DWORD
	pfnAlloc as PFN_CRYPT_ALLOC
	pfnFree as PFN_CRYPT_FREE
end type

type CRYPT_ENCODE_PARA as _CRYPT_ENCODE_PARA
type PCRYPT_ENCODE_PARA as _CRYPT_ENCODE_PARA ptr
declare function CryptEncodeObjectEx(byval dwCertEncodingType as DWORD, byval lpszStructType as LPCSTR, byval pvStructInfo as const any ptr, byval dwFlags as DWORD, byval pEncodePara as PCRYPT_ENCODE_PARA, byval pvEncoded as any ptr, byval pcbEncoded as DWORD ptr) as WINBOOL
declare function CryptEncodeObject(byval dwCertEncodingType as DWORD, byval lpszStructType as LPCSTR, byval pvStructInfo as const any ptr, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr) as WINBOOL
const CRYPT_ENCODE_NO_SIGNATURE_BYTE_REVERSAL_FLAG = &h8
const CRYPT_ENCODE_ALLOC_FLAG = &h8000
const CRYPT_UNICODE_NAME_ENCODE_ENABLE_T61_UNICODE_FLAG = CERT_RDN_ENABLE_T61_UNICODE_FLAG
const CRYPT_UNICODE_NAME_ENCODE_ENABLE_UTF8_UNICODE_FLAG = CERT_RDN_ENABLE_UTF8_UNICODE_FLAG
const CRYPT_UNICODE_NAME_ENCODE_FORCE_UTF8_UNICODE_FLAG = CERT_RDN_FORCE_UTF8_UNICODE_FLAG
const CRYPT_UNICODE_NAME_ENCODE_DISABLE_CHECK_TYPE_FLAG = CERT_RDN_DISABLE_CHECK_TYPE_FLAG
const CRYPT_SORTED_CTL_ENCODE_HASHED_SUBJECT_IDENTIFIER_FLAG = &h10000
const CRYPT_ENCODE_ENABLE_PUNYCODE_FLAG = &h20000
const CRYPT_ENCODE_ENABLE_UTF8PERCENT_FLAG = &h40000
const CRYPT_ENCODE_ENABLE_IA5CONVERSION_FLAG = CRYPT_ENCODE_ENABLE_PUNYCODE_FLAG or CRYPT_ENCODE_ENABLE_UTF8PERCENT_FLAG

type _CRYPT_DECODE_PARA
	cbSize as DWORD
	pfnAlloc as PFN_CRYPT_ALLOC
	pfnFree as PFN_CRYPT_FREE
end type

type CRYPT_DECODE_PARA as _CRYPT_DECODE_PARA
type PCRYPT_DECODE_PARA as _CRYPT_DECODE_PARA ptr
declare function CryptDecodeObjectEx(byval dwCertEncodingType as DWORD, byval lpszStructType as LPCSTR, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval dwFlags as DWORD, byval pDecodePara as PCRYPT_DECODE_PARA, byval pvStructInfo as any ptr, byval pcbStructInfo as DWORD ptr) as WINBOOL
declare function CryptDecodeObject(byval dwCertEncodingType as DWORD, byval lpszStructType as LPCSTR, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval dwFlags as DWORD, byval pvStructInfo as any ptr, byval pcbStructInfo as DWORD ptr) as WINBOOL
const CRYPT_DECODE_NOCOPY_FLAG = &h1
const CRYPT_DECODE_TO_BE_SIGNED_FLAG = &h2
const CRYPT_DECODE_SHARE_OID_STRING_FLAG = &h4
const CRYPT_DECODE_NO_SIGNATURE_BYTE_REVERSAL_FLAG = &h8
const CRYPT_DECODE_ALLOC_FLAG = &h8000
const CRYPT_UNICODE_NAME_DECODE_DISABLE_IE4_UTF8_FLAG = CERT_RDN_DISABLE_IE4_UTF8_FLAG
const CRYPT_DECODE_ENABLE_PUNYCODE_FLAG = &h2000000
const CRYPT_DECODE_ENABLE_UTF8PERCENT_FLAG = &h4000000
const CRYPT_DECODE_ENABLE_IA5CONVERSION_FLAG = CRYPT_DECODE_ENABLE_PUNYCODE_FLAG or CRYPT_DECODE_ENABLE_UTF8PERCENT_FLAG
const CRYPT_ENCODE_DECODE_NONE = 0
const X509_CERT = cast(LPCSTR, 1)
const X509_CERT_TO_BE_SIGNED = cast(LPCSTR, 2)
const X509_CERT_CRL_TO_BE_SIGNED = cast(LPCSTR, 3)
const X509_CERT_REQUEST_TO_BE_SIGNED = cast(LPCSTR, 4)
const X509_EXTENSIONS = cast(LPCSTR, 5)
const X509_NAME_VALUE = cast(LPCSTR, 6)
const X509_NAME = cast(LPCSTR, 7)
const X509_PUBLIC_KEY_INFO = cast(LPCSTR, 8)
const X509_AUTHORITY_KEY_ID = cast(LPCSTR, 9)
const X509_KEY_ATTRIBUTES = cast(LPCSTR, 10)
const X509_KEY_USAGE_RESTRICTION = cast(LPCSTR, 11)
const X509_ALTERNATE_NAME = cast(LPCSTR, 12)
const X509_BASIC_CONSTRAINTS = cast(LPCSTR, 13)
const X509_KEY_USAGE = cast(LPCSTR, 14)
const X509_BASIC_CONSTRAINTS2 = cast(LPCSTR, 15)
const X509_CERT_POLICIES = cast(LPCSTR, 16)
const PKCS_UTC_TIME = cast(LPCSTR, 17)
const PKCS_TIME_REQUEST = cast(LPCSTR, 18)
const RSA_CSP_PUBLICKEYBLOB = cast(LPCSTR, 19)
const X509_UNICODE_NAME = cast(LPCSTR, 20)
const X509_KEYGEN_REQUEST_TO_BE_SIGNED = cast(LPCSTR, 21)
const PKCS_ATTRIBUTE = cast(LPCSTR, 22)
const PKCS_CONTENT_INFO_SEQUENCE_OF_ANY = cast(LPCSTR, 23)
const X509_UNICODE_NAME_VALUE = cast(LPCSTR, 24)
const X509_ANY_STRING = X509_NAME_VALUE
const X509_UNICODE_ANY_STRING = X509_UNICODE_NAME_VALUE
const X509_OCTET_STRING = cast(LPCSTR, 25)
const X509_BITS = cast(LPCSTR, 26)
const X509_INTEGER = cast(LPCSTR, 27)
const X509_MULTI_BYTE_INTEGER = cast(LPCSTR, 28)
const X509_ENUMERATED = cast(LPCSTR, 29)
const X509_CHOICE_OF_TIME = cast(LPCSTR, 30)
const X509_AUTHORITY_KEY_ID2 = cast(LPCSTR, 31)
const X509_AUTHORITY_INFO_ACCESS = cast(LPCSTR, 32)
const X509_SUBJECT_INFO_ACCESS = X509_AUTHORITY_INFO_ACCESS
const X509_CRL_REASON_CODE = X509_ENUMERATED
const PKCS_CONTENT_INFO = cast(LPCSTR, 33)
const X509_SEQUENCE_OF_ANY = cast(LPCSTR, 34)
const X509_CRL_DIST_POINTS = cast(LPCSTR, 35)
const X509_ENHANCED_KEY_USAGE = cast(LPCSTR, 36)
const PKCS_CTL = cast(LPCSTR, 37)
const X509_MULTI_BYTE_UINT = cast(LPCSTR, 38)
const X509_DSS_PUBLICKEY = X509_MULTI_BYTE_UINT
const X509_DSS_PARAMETERS = cast(LPCSTR, 39)
const X509_DSS_SIGNATURE = cast(LPCSTR, 40)
const PKCS_RC2_CBC_PARAMETERS = cast(LPCSTR, 41)
const PKCS_SMIME_CAPABILITIES = cast(LPCSTR, 42)
const X509_QC_STATEMENTS_EXT = cast(LPCSTR, 42)
const PKCS_RSA_PRIVATE_KEY = cast(LPCSTR, 43)
const PKCS_PRIVATE_KEY_INFO = cast(LPCSTR, 44)
const PKCS_ENCRYPTED_PRIVATE_KEY_INFO = cast(LPCSTR, 45)
const X509_PKIX_POLICY_QUALIFIER_USERNOTICE = cast(LPCSTR, 46)
const X509_DH_PUBLICKEY = X509_MULTI_BYTE_UINT
const X509_DH_PARAMETERS = cast(LPCSTR, 47)
const X509_ECC_SIGNATURE = cast(LPCSTR, 47)
const PKCS_ATTRIBUTES = cast(LPCSTR, 48)
const PKCS_SORTED_CTL = cast(LPCSTR, 49)
const X942_DH_PARAMETERS = cast(LPCSTR, 50)
const X509_BITS_WITHOUT_TRAILING_ZEROES = cast(LPCSTR, 51)
const X942_OTHER_INFO = cast(LPCSTR, 52)
const X509_CERT_PAIR = cast(LPCSTR, 53)
const X509_ISSUING_DIST_POINT = cast(LPCSTR, 54)
const X509_NAME_CONSTRAINTS = cast(LPCSTR, 55)
const X509_POLICY_MAPPINGS = cast(LPCSTR, 56)
const X509_POLICY_CONSTRAINTS = cast(LPCSTR, 57)
const X509_CROSS_CERT_DIST_POINTS = cast(LPCSTR, 58)
const CMC_DATA = cast(LPCSTR, 59)
const CMC_RESPONSE = cast(LPCSTR, 60)
const CMC_STATUS = cast(LPCSTR, 61)
const CMC_ADD_EXTENSIONS = cast(LPCSTR, 62)
const CMC_ADD_ATTRIBUTES = cast(LPCSTR, 63)
const X509_CERTIFICATE_TEMPLATE = cast(LPCSTR, 64)
const OCSP_SIGNED_REQUEST = cast(LPCSTR, 65)
const OCSP_REQUEST = cast(LPCSTR, 66)
const OCSP_RESPONSE = cast(LPCSTR, 67)
const OCSP_BASIC_SIGNED_RESPONSE = cast(LPCSTR, 68)
const OCSP_BASIC_RESPONSE = cast(LPCSTR, 69)
const X509_LOGOTYPE_EXT = cast(LPCSTR, 70)
const X509_BIOMETRIC_EXT = cast(LPCSTR, 71)
const CNG_RSA_PUBLIC_KEY_BLOB = cast(LPCSTR, 72)
const X509_OBJECT_IDENTIFIER = cast(LPCSTR, 73)
const X509_ALGORITHM_IDENTIFIER = cast(LPCSTR, 74)
const PKCS_RSA_SSA_PSS_PARAMETERS = cast(LPCSTR, 75)
const PKCS_RSAES_OAEP_PARAMETERS = cast(LPCSTR, 76)
const ECC_CMS_SHARED_INFO = cast(LPCSTR, 77)
const TIMESTAMP_REQUEST = cast(LPCSTR, 78)
const TIMESTAMP_RESPONSE = cast(LPCSTR, 79)
const TIMESTAMP_INFO = cast(LPCSTR, 80)
const X509_CERT_BUNDLE = cast(LPCSTR, 81)
const X509_ECC_PRIVATE_KEY = cast(LPCSTR, 82)
const CNG_RSA_PRIVATE_KEY_BLOB = cast(LPCSTR, 83)
const PKCS7_SIGNER_INFO = cast(LPCSTR, 500)
const CMS_SIGNER_INFO = cast(LPCSTR, 501)
#define szOID_AUTHORITY_KEY_IDENTIFIER "2.5.29.1"
#define szOID_KEY_ATTRIBUTES "2.5.29.2"
#define szOID_CERT_POLICIES_95 "2.5.29.3"
#define szOID_KEY_USAGE_RESTRICTION "2.5.29.4"
#define szOID_SUBJECT_ALT_NAME "2.5.29.7"
#define szOID_ISSUER_ALT_NAME "2.5.29.8"
#define szOID_BASIC_CONSTRAINTS "2.5.29.10"
#define szOID_KEY_USAGE "2.5.29.15"
#define szOID_PRIVATEKEY_USAGE_PERIOD "2.5.29.16"
#define szOID_BASIC_CONSTRAINTS2 "2.5.29.19"
#define szOID_CERT_POLICIES "2.5.29.32"
#define szOID_ANY_CERT_POLICY "2.5.29.32.0"
#define szOID_INHIBIT_ANY_POLICY "2.5.29.54"
#define szOID_AUTHORITY_KEY_IDENTIFIER2 "2.5.29.35"
#define szOID_SUBJECT_KEY_IDENTIFIER "2.5.29.14"
#define szOID_SUBJECT_ALT_NAME2 "2.5.29.17"
#define szOID_ISSUER_ALT_NAME2 "2.5.29.18"
#define szOID_CRL_REASON_CODE "2.5.29.21"
#define szOID_REASON_CODE_HOLD "2.5.29.23"
#define szOID_CRL_DIST_POINTS "2.5.29.31"
#define szOID_ENHANCED_KEY_USAGE "2.5.29.37"
#define szOID_ANY_ENHANCED_KEY_USAGE "2.5.29.37.0"
#define szOID_CRL_NUMBER "2.5.29.20"
#define szOID_DELTA_CRL_INDICATOR "2.5.29.27"
#define szOID_ISSUING_DIST_POINT "2.5.29.28"
#define szOID_FRESHEST_CRL "2.5.29.46"
#define szOID_NAME_CONSTRAINTS "2.5.29.30"
#define szOID_POLICY_MAPPINGS "2.5.29.33"
#define szOID_LEGACY_POLICY_MAPPINGS "2.5.29.5"
#define szOID_POLICY_CONSTRAINTS "2.5.29.36"
#define szOID_RENEWAL_CERTIFICATE "1.3.6.1.4.1.311.13.1"
#define szOID_ENROLLMENT_NAME_VALUE_PAIR "1.3.6.1.4.1.311.13.2.1"
#define szOID_ENROLLMENT_CSP_PROVIDER "1.3.6.1.4.1.311.13.2.2"
#define szOID_OS_VERSION "1.3.6.1.4.1.311.13.2.3"
#define szOID_ENROLLMENT_AGENT "1.3.6.1.4.1.311.20.2.1"
#define szOID_PKIX "1.3.6.1.5.5.7"
#define szOID_PKIX_PE "1.3.6.1.5.5.7.1"
#define szOID_AUTHORITY_INFO_ACCESS "1.3.6.1.5.5.7.1.1"
#define szOID_SUBJECT_INFO_ACCESS "1.3.6.1.5.5.7.1.11"
#define szOID_BIOMETRIC_EXT "1.3.6.1.5.5.7.1.2"
#define szOID_QC_STATEMENTS_EXT "1.3.6.1.5.5.7.1.3"
#define szOID_LOGOTYPE_EXT "1.3.6.1.5.5.7.1.12"
#define szOID_CERT_EXTENSIONS "1.3.6.1.4.1.311.2.1.14"
#define szOID_NEXT_UPDATE_LOCATION "1.3.6.1.4.1.311.10.2"
#define szOID_REMOVE_CERTIFICATE "1.3.6.1.4.1.311.10.8.1"
#define szOID_CROSS_CERT_DIST_POINTS "1.3.6.1.4.1.311.10.9.1"
#define szOID_CTL "1.3.6.1.4.1.311.10.1"
#define szOID_SORTED_CTL "1.3.6.1.4.1.311.10.1.1"
#define szOID_SERIALIZED "1.3.6.1.4.1.311.10.3.3.1"
#define szOID_NT_PRINCIPAL_NAME "1.3.6.1.4.1.311.20.2.3"
#define szOID_INTERNATIONALIZED_EMAIL_ADDRESS "1.3.6.1.4.1.311.20.2.4"
#define szOID_PRODUCT_UPDATE "1.3.6.1.4.1.311.31.1"
#define szOID_ANY_APPLICATION_POLICY "1.3.6.1.4.1.311.10.12.1"
#define szOID_AUTO_ENROLL_CTL_USAGE "1.3.6.1.4.1.311.20.1"
#define szOID_ENROLL_CERTTYPE_EXTENSION "1.3.6.1.4.1.311.20.2"
#define szOID_CERT_MANIFOLD "1.3.6.1.4.1.311.20.3"
#define szOID_CERTSRV_CA_VERSION "1.3.6.1.4.1.311.21.1"
#define szOID_CERTSRV_PREVIOUS_CERT_HASH "1.3.6.1.4.1.311.21.2"
#define szOID_CRL_VIRTUAL_BASE "1.3.6.1.4.1.311.21.3"
#define szOID_CRL_NEXT_PUBLISH "1.3.6.1.4.1.311.21.4"
#define szOID_KP_CA_EXCHANGE "1.3.6.1.4.1.311.21.5"
#define szOID_KP_KEY_RECOVERY_AGENT "1.3.6.1.4.1.311.21.6"
#define szOID_CERTIFICATE_TEMPLATE "1.3.6.1.4.1.311.21.7"
#define szOID_ENTERPRISE_OID_ROOT "1.3.6.1.4.1.311.21.8"
#define szOID_RDN_DUMMY_SIGNER "1.3.6.1.4.1.311.21.9"
#define szOID_APPLICATION_CERT_POLICIES "1.3.6.1.4.1.311.21.10"
#define szOID_APPLICATION_POLICY_MAPPINGS "1.3.6.1.4.1.311.21.11"
#define szOID_APPLICATION_POLICY_CONSTRAINTS "1.3.6.1.4.1.311.21.12"
#define szOID_ARCHIVED_KEY_ATTR "1.3.6.1.4.1.311.21.13"
#define szOID_CRL_SELF_CDP "1.3.6.1.4.1.311.21.14"
#define szOID_REQUIRE_CERT_CHAIN_POLICY "1.3.6.1.4.1.311.21.15"
#define szOID_ARCHIVED_KEY_CERT_HASH "1.3.6.1.4.1.311.21.16"
#define szOID_ISSUED_CERT_HASH "1.3.6.1.4.1.311.21.17"
#define szOID_DS_EMAIL_REPLICATION "1.3.6.1.4.1.311.21.19"
#define szOID_REQUEST_CLIENT_INFO "1.3.6.1.4.1.311.21.20"
#define szOID_ENCRYPTED_KEY_HASH "1.3.6.1.4.1.311.21.21"
#define szOID_CERTSRV_CROSSCA_VERSION "1.3.6.1.4.1.311.21.22"
#define szOID_NTDS_REPLICATION "1.3.6.1.4.1.311.25.1"
#define szOID_SUBJECT_DIR_ATTRS "2.5.29.9"
#define szOID_PKIX_KP "1.3.6.1.5.5.7.3"
#define szOID_PKIX_KP_SERVER_AUTH "1.3.6.1.5.5.7.3.1"
#define szOID_PKIX_KP_CLIENT_AUTH "1.3.6.1.5.5.7.3.2"
#define szOID_PKIX_KP_CODE_SIGNING "1.3.6.1.5.5.7.3.3"
#define szOID_PKIX_KP_EMAIL_PROTECTION "1.3.6.1.5.5.7.3.4"
#define szOID_PKIX_KP_IPSEC_END_SYSTEM "1.3.6.1.5.5.7.3.5"
#define szOID_PKIX_KP_IPSEC_TUNNEL "1.3.6.1.5.5.7.3.6"
#define szOID_PKIX_KP_IPSEC_USER "1.3.6.1.5.5.7.3.7"
#define szOID_PKIX_KP_TIMESTAMP_SIGNING "1.3.6.1.5.5.7.3.8"
#define szOID_PKIX_KP_OCSP_SIGNING "1.3.6.1.5.5.7.3.9"
#define szOID_PKIX_OCSP_NONCE "1.3.6.1.5.5.7.48.1.2"
#define szOID_PKIX_OCSP_NOCHECK "1.3.6.1.5.5.7.48.1.5"
#define szOID_IPSEC_KP_IKE_INTERMEDIATE "1.3.6.1.5.5.8.2.2"
#define szOID_PKINIT_KP_KDC "1.3.6.1.5.2.3.5"
#define szOID_KP_CTL_USAGE_SIGNING "1.3.6.1.4.1.311.10.3.1"
#define szOID_KP_TIME_STAMP_SIGNING "1.3.6.1.4.1.311.10.3.2"
#define szOID_SERVER_GATED_CRYPTO "1.3.6.1.4.1.311.10.3.3"
#define szOID_SGC_NETSCAPE "2.16.840.1.113730.4.1"
#define szOID_KP_EFS "1.3.6.1.4.1.311.10.3.4"
#define szOID_EFS_RECOVERY "1.3.6.1.4.1.311.10.3.4.1"
#define szOID_WHQL_CRYPTO "1.3.6.1.4.1.311.10.3.5"
#define szOID_NT5_CRYPTO "1.3.6.1.4.1.311.10.3.6"
#define szOID_OEM_WHQL_CRYPTO "1.3.6.1.4.1.311.10.3.7"
#define szOID_EMBEDDED_NT_CRYPTO "1.3.6.1.4.1.311.10.3.8"
#define szOID_ROOT_LIST_SIGNER "1.3.6.1.4.1.311.10.3.9"
#define szOID_KP_QUALIFIED_SUBORDINATION "1.3.6.1.4.1.311.10.3.10"
#define szOID_KP_KEY_RECOVERY "1.3.6.1.4.1.311.10.3.11"
#define szOID_KP_DOCUMENT_SIGNING "1.3.6.1.4.1.311.10.3.12"
#define szOID_KP_LIFETIME_SIGNING "1.3.6.1.4.1.311.10.3.13"
#define szOID_KP_MOBILE_DEVICE_SOFTWARE "1.3.6.1.4.1.311.10.3.14"
#define szOID_KP_SMART_DISPLAY "1.3.6.1.4.1.311.10.3.15"
#define szOID_KP_CSP_SIGNATURE "1.3.6.1.4.1.311.10.3.16"
#define szOID_DRM "1.3.6.1.4.1.311.10.5.1"
#define szOID_DRM_INDIVIDUALIZATION "1.3.6.1.4.1.311.10.5.2"
#define szOID_LICENSES "1.3.6.1.4.1.311.10.6.1"
#define szOID_LICENSE_SERVER "1.3.6.1.4.1.311.10.6.2"
#define szOID_KP_SMARTCARD_LOGON "1.3.6.1.4.1.311.20.2.2"
#define szOID_KP_KERNEL_MODE_CODE_SIGNING "1.3.6.1.4.1.311.61.1.1"
#define szOID_KP_KERNEL_MODE_TRUSTED_BOOT_SIGNING "1.3.6.1.4.1.311.61.4.1"
#define szOID_REVOKED_LIST_SIGNER "1.3.6.1.4.1.311.10.3.19"
#define szOID_DISALLOWED_LIST "1.3.6.1.4.1.311.10.3.30"
#define szOID_KP_KERNEL_MODE_HAL_EXTENSION_SIGNING "1.3.6.1.4.1.311.61.5.1"
#define szOID_YESNO_TRUST_ATTR "1.3.6.1.4.1.311.10.4.1"
#define szOID_PKIX_POLICY_QUALIFIER_CPS "1.3.6.1.5.5.7.2.1"
#define szOID_PKIX_POLICY_QUALIFIER_USERNOTICE "1.3.6.1.5.5.7.2.2"
#define szOID_ROOT_PROGRAM_FLAGS "1.3.6.1.4.1.311.60.1.1"
const CERT_ROOT_PROGRAM_FLAG_ORG = &h80
const CERT_ROOT_PROGRAM_FLAG_LSC = &h40
const CERT_ROOT_PROGRAM_FLAG_SUBJECT_LOGO = &h20
const CERT_ROOT_PROGRAM_FLAG_OU = &h10
const CERT_ROOT_PROGRAM_FLAG_ADDRESS = &h08
#define szOID_CERT_POLICIES_95_QUALIFIER1 "2.16.840.1.113733.1.7.1.1"

type _CERT_EXTENSIONS
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type CERT_EXTENSIONS as _CERT_EXTENSIONS
type PCERT_EXTENSIONS as _CERT_EXTENSIONS ptr
const CERT_UNICODE_RDN_ERR_INDEX_MASK = &h3ff
const CERT_UNICODE_RDN_ERR_INDEX_SHIFT = 22
const CERT_UNICODE_ATTR_ERR_INDEX_MASK = &h3f
const CERT_UNICODE_ATTR_ERR_INDEX_SHIFT = 16
const CERT_UNICODE_VALUE_ERR_INDEX_MASK = &hffff
const CERT_UNICODE_VALUE_ERR_INDEX_SHIFT = 0
#define GET_CERT_UNICODE_RDN_ERR_INDEX(X) ((X shr CERT_UNICODE_RDN_ERR_INDEX_SHIFT) and CERT_UNICODE_RDN_ERR_INDEX_MASK)
#define GET_CERT_UNICODE_ATTR_ERR_INDEX(X) ((X shr CERT_UNICODE_ATTR_ERR_INDEX_SHIFT) and CERT_UNICODE_ATTR_ERR_INDEX_MASK)
#define GET_CERT_UNICODE_VALUE_ERR_INDEX(X) (X and CERT_UNICODE_VALUE_ERR_INDEX_MASK)

type _CERT_AUTHORITY_KEY_ID_INFO
	KeyId as CRYPT_DATA_BLOB
	CertIssuer as CERT_NAME_BLOB
	CertSerialNumber as CRYPT_INTEGER_BLOB
end type

type CERT_AUTHORITY_KEY_ID_INFO as _CERT_AUTHORITY_KEY_ID_INFO
type PCERT_AUTHORITY_KEY_ID_INFO as _CERT_AUTHORITY_KEY_ID_INFO ptr

type _CERT_PRIVATE_KEY_VALIDITY
	NotBefore as FILETIME
	NotAfter as FILETIME
end type

type CERT_PRIVATE_KEY_VALIDITY as _CERT_PRIVATE_KEY_VALIDITY
type PCERT_PRIVATE_KEY_VALIDITY as _CERT_PRIVATE_KEY_VALIDITY ptr

type _CERT_KEY_ATTRIBUTES_INFO
	KeyId as CRYPT_DATA_BLOB
	IntendedKeyUsage as CRYPT_BIT_BLOB
	pPrivateKeyUsagePeriod as PCERT_PRIVATE_KEY_VALIDITY
end type

type CERT_KEY_ATTRIBUTES_INFO as _CERT_KEY_ATTRIBUTES_INFO
type PCERT_KEY_ATTRIBUTES_INFO as _CERT_KEY_ATTRIBUTES_INFO ptr
const CERT_ENCIPHER_ONLY_KEY_USAGE = &h01
const CERT_OFFLINE_CRL_SIGN_KEY_USAGE = &h02
const CERT_KEY_CERT_SIGN_KEY_USAGE = &h04
const CERT_KEY_AGREEMENT_KEY_USAGE = &h08
const CERT_DATA_ENCIPHERMENT_KEY_USAGE = &h10
const CERT_KEY_ENCIPHERMENT_KEY_USAGE = &h20
const CERT_NON_REPUDIATION_KEY_USAGE = &h40
const CERT_DIGITAL_SIGNATURE_KEY_USAGE = &h80
const CERT_DECIPHER_ONLY_KEY_USAGE = &h80

type _CERT_POLICY_ID
	cCertPolicyElementId as DWORD
	rgpszCertPolicyElementId as LPSTR ptr
end type

type CERT_POLICY_ID as _CERT_POLICY_ID
type PCERT_POLICY_ID as _CERT_POLICY_ID ptr

type _CERT_KEY_USAGE_RESTRICTION_INFO
	cCertPolicyId as DWORD
	rgCertPolicyId as PCERT_POLICY_ID
	RestrictedKeyUsage as CRYPT_BIT_BLOB
end type

type CERT_KEY_USAGE_RESTRICTION_INFO as _CERT_KEY_USAGE_RESTRICTION_INFO
type PCERT_KEY_USAGE_RESTRICTION_INFO as _CERT_KEY_USAGE_RESTRICTION_INFO ptr

type _CERT_OTHER_NAME
	pszObjId as LPSTR
	Value as CRYPT_OBJID_BLOB
end type

type CERT_OTHER_NAME as _CERT_OTHER_NAME
type PCERT_OTHER_NAME as _CERT_OTHER_NAME ptr

type _CERT_ALT_NAME_ENTRY
	dwAltNameChoice as DWORD

	union
		pOtherName as PCERT_OTHER_NAME
		pwszRfc822Name as LPWSTR
		pwszDNSName as LPWSTR
		DirectoryName as CERT_NAME_BLOB
		pwszURL as LPWSTR
		IPAddress as CRYPT_DATA_BLOB
		pszRegisteredID as LPSTR
	end union
end type

type CERT_ALT_NAME_ENTRY as _CERT_ALT_NAME_ENTRY
type PCERT_ALT_NAME_ENTRY as _CERT_ALT_NAME_ENTRY ptr
const CERT_ALT_NAME_OTHER_NAME = 1
const CERT_ALT_NAME_RFC822_NAME = 2
const CERT_ALT_NAME_DNS_NAME = 3
const CERT_ALT_NAME_X400_ADDRESS = 4
const CERT_ALT_NAME_DIRECTORY_NAME = 5
const CERT_ALT_NAME_EDI_PARTY_NAME = 6
const CERT_ALT_NAME_URL = 7
const CERT_ALT_NAME_IP_ADDRESS = 8
const CERT_ALT_NAME_REGISTERED_ID = 9

type _CERT_ALT_NAME_INFO
	cAltEntry as DWORD
	rgAltEntry as PCERT_ALT_NAME_ENTRY
end type

type CERT_ALT_NAME_INFO as _CERT_ALT_NAME_INFO
type PCERT_ALT_NAME_INFO as _CERT_ALT_NAME_INFO ptr
const CERT_ALT_NAME_ENTRY_ERR_INDEX_MASK = &hff
const CERT_ALT_NAME_ENTRY_ERR_INDEX_SHIFT = 16
const CERT_ALT_NAME_VALUE_ERR_INDEX_MASK = &h0000ffff
const CERT_ALT_NAME_VALUE_ERR_INDEX_SHIFT = 0
#define GET_CERT_ALT_NAME_ENTRY_ERR_INDEX(X) ((X shr CERT_ALT_NAME_ENTRY_ERR_INDEX_SHIFT) and CERT_ALT_NAME_ENTRY_ERR_INDEX_MASK)
#define GET_CERT_ALT_NAME_VALUE_ERR_INDEX(X) (X and CERT_ALT_NAME_VALUE_ERR_INDEX_MASK)

type _CERT_BASIC_CONSTRAINTS_INFO
	SubjectType as CRYPT_BIT_BLOB
	fPathLenConstraint as WINBOOL
	dwPathLenConstraint as DWORD
	cSubtreesConstraint as DWORD
	rgSubtreesConstraint as CERT_NAME_BLOB ptr
end type

type CERT_BASIC_CONSTRAINTS_INFO as _CERT_BASIC_CONSTRAINTS_INFO
type PCERT_BASIC_CONSTRAINTS_INFO as _CERT_BASIC_CONSTRAINTS_INFO ptr
const CERT_CA_SUBJECT_FLAG = &h80
const CERT_END_ENTITY_SUBJECT_FLAG = &h40

type _CERT_BASIC_CONSTRAINTS2_INFO
	fCA as WINBOOL
	fPathLenConstraint as WINBOOL
	dwPathLenConstraint as DWORD
end type

type CERT_BASIC_CONSTRAINTS2_INFO as _CERT_BASIC_CONSTRAINTS2_INFO
type PCERT_BASIC_CONSTRAINTS2_INFO as _CERT_BASIC_CONSTRAINTS2_INFO ptr

type _CERT_POLICY_QUALIFIER_INFO
	pszPolicyQualifierId as LPSTR
	Qualifier as CRYPT_OBJID_BLOB
end type

type CERT_POLICY_QUALIFIER_INFO as _CERT_POLICY_QUALIFIER_INFO
type PCERT_POLICY_QUALIFIER_INFO as _CERT_POLICY_QUALIFIER_INFO ptr

type _CERT_POLICY_INFO
	pszPolicyIdentifier as LPSTR
	cPolicyQualifier as DWORD
	rgPolicyQualifier as CERT_POLICY_QUALIFIER_INFO ptr
end type

type CERT_POLICY_INFO as _CERT_POLICY_INFO
type PCERT_POLICY_INFO as _CERT_POLICY_INFO ptr

type _CERT_POLICIES_INFO
	cPolicyInfo as DWORD
	rgPolicyInfo as CERT_POLICY_INFO ptr
end type

type CERT_POLICIES_INFO as _CERT_POLICIES_INFO
type PCERT_POLICIES_INFO as _CERT_POLICIES_INFO ptr

type _CERT_POLICY_QUALIFIER_NOTICE_REFERENCE
	pszOrganization as LPSTR
	cNoticeNumbers as DWORD
	rgNoticeNumbers as long ptr
end type

type CERT_POLICY_QUALIFIER_NOTICE_REFERENCE as _CERT_POLICY_QUALIFIER_NOTICE_REFERENCE
type PCERT_POLICY_QUALIFIER_NOTICE_REFERENCE as _CERT_POLICY_QUALIFIER_NOTICE_REFERENCE ptr

type _CERT_POLICY_QUALIFIER_USER_NOTICE
	pNoticeReference as CERT_POLICY_QUALIFIER_NOTICE_REFERENCE ptr
	pszDisplayText as LPWSTR
end type

type CERT_POLICY_QUALIFIER_USER_NOTICE as _CERT_POLICY_QUALIFIER_USER_NOTICE
type PCERT_POLICY_QUALIFIER_USER_NOTICE as _CERT_POLICY_QUALIFIER_USER_NOTICE ptr

type _CPS_URLS
	pszURL as LPWSTR
	pAlgorithm as CRYPT_ALGORITHM_IDENTIFIER ptr
	pDigest as CRYPT_DATA_BLOB ptr
end type

type CPS_URLS as _CPS_URLS
type PCPS_URLS as _CPS_URLS ptr

type _CERT_POLICY95_QUALIFIER1
	pszPracticesReference as LPWSTR
	pszNoticeIdentifier as LPSTR
	pszNSINoticeIdentifier as LPSTR
	cCPSURLs as DWORD
	rgCPSURLs as CPS_URLS ptr
end type

type CERT_POLICY95_QUALIFIER1 as _CERT_POLICY95_QUALIFIER1
type PCERT_POLICY95_QUALIFIER1 as _CERT_POLICY95_QUALIFIER1 ptr

type _CERT_POLICY_MAPPING
	pszIssuerDomainPolicy as LPSTR
	pszSubjectDomainPolicy as LPSTR
end type

type CERT_POLICY_MAPPING as _CERT_POLICY_MAPPING
type PCERT_POLICY_MAPPING as _CERT_POLICY_MAPPING ptr

type _CERT_POLICY_MAPPINGS_INFO
	cPolicyMapping as DWORD
	rgPolicyMapping as PCERT_POLICY_MAPPING
end type

type CERT_POLICY_MAPPINGS_INFO as _CERT_POLICY_MAPPINGS_INFO
type PCERT_POLICY_MAPPINGS_INFO as _CERT_POLICY_MAPPINGS_INFO ptr

type _CERT_POLICY_CONSTRAINTS_INFO
	fRequireExplicitPolicy as WINBOOL
	dwRequireExplicitPolicySkipCerts as DWORD
	fInhibitPolicyMapping as WINBOOL
	dwInhibitPolicyMappingSkipCerts as DWORD
end type

type CERT_POLICY_CONSTRAINTS_INFO as _CERT_POLICY_CONSTRAINTS_INFO
type PCERT_POLICY_CONSTRAINTS_INFO as _CERT_POLICY_CONSTRAINTS_INFO ptr

type _CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY
	pszObjId as LPSTR
	cValue as DWORD
	rgValue as PCRYPT_DER_BLOB
end type

type CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY as _CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY
type PCRYPT_CONTENT_INFO_SEQUENCE_OF_ANY as _CRYPT_CONTENT_INFO_SEQUENCE_OF_ANY ptr

type _CRYPT_CONTENT_INFO
	pszObjId as LPSTR
	Content as CRYPT_DER_BLOB
end type

type CRYPT_CONTENT_INFO as _CRYPT_CONTENT_INFO
type PCRYPT_CONTENT_INFO as _CRYPT_CONTENT_INFO ptr

type _CRYPT_SEQUENCE_OF_ANY
	cValue as DWORD
	rgValue as PCRYPT_DER_BLOB
end type

type CRYPT_SEQUENCE_OF_ANY as _CRYPT_SEQUENCE_OF_ANY
type PCRYPT_SEQUENCE_OF_ANY as _CRYPT_SEQUENCE_OF_ANY ptr

type _CERT_AUTHORITY_KEY_ID2_INFO
	KeyId as CRYPT_DATA_BLOB
	AuthorityCertIssuer as CERT_ALT_NAME_INFO
	AuthorityCertSerialNumber as CRYPT_INTEGER_BLOB
end type

type CERT_AUTHORITY_KEY_ID2_INFO as _CERT_AUTHORITY_KEY_ID2_INFO
type PCERT_AUTHORITY_KEY_ID2_INFO as _CERT_AUTHORITY_KEY_ID2_INFO ptr

type _CERT_ACCESS_DESCRIPTION
	pszAccessMethod as LPSTR
	AccessLocation as CERT_ALT_NAME_ENTRY
end type

type CERT_ACCESS_DESCRIPTION as _CERT_ACCESS_DESCRIPTION
type PCERT_ACCESS_DESCRIPTION as _CERT_ACCESS_DESCRIPTION ptr

type _CERT_AUTHORITY_INFO_ACCESS
	cAccDescr as DWORD
	rgAccDescr as PCERT_ACCESS_DESCRIPTION
end type

type CERT_AUTHORITY_INFO_ACCESS as _CERT_AUTHORITY_INFO_ACCESS
type PCERT_AUTHORITY_INFO_ACCESS as _CERT_AUTHORITY_INFO_ACCESS ptr
type CERT_SUBJECT_INFO_ACCESS as CERT_AUTHORITY_INFO_ACCESS
type PCERT_SUBJECT_INFO_ACCESS as CERT_AUTHORITY_INFO_ACCESS ptr

#define szOID_PKIX_ACC_DESCR "1.3.6.1.5.5.7.48"
#define szOID_PKIX_OCSP "1.3.6.1.5.5.7.48.1"
#define szOID_PKIX_CA_ISSUERS "1.3.6.1.5.5.7.48.2"
#define szOID_PKIX_TIME_STAMPING "1.3.6.1.5.5.7.48.3"
#define szOID_PKIX_CA_REPOSITORY "1.3.6.1.5.5.7.48.5"
const CRL_REASON_UNSPECIFIED = 0
const CRL_REASON_KEY_COMPROMISE = 1
const CRL_REASON_CA_COMPROMISE = 2
const CRL_REASON_AFFILIATION_CHANGED = 3
const CRL_REASON_SUPERSEDED = 4
const CRL_REASON_CESSATION_OF_OPERATION = 5
const CRL_REASON_CERTIFICATE_HOLD = 6
const CRL_REASON_REMOVE_FROM_CRL = 8

type _CRL_DIST_POINT_NAME
	dwDistPointNameChoice as DWORD

	union
		FullName as CERT_ALT_NAME_INFO
	end union
end type

type CRL_DIST_POINT_NAME as _CRL_DIST_POINT_NAME
type PCRL_DIST_POINT_NAME as _CRL_DIST_POINT_NAME ptr
const CRL_DIST_POINT_NO_NAME = 0
const CRL_DIST_POINT_FULL_NAME = 1
const CRL_DIST_POINT_ISSUER_RDN_NAME = 2

type _CRL_DIST_POINT
	DistPointName as CRL_DIST_POINT_NAME
	ReasonFlags as CRYPT_BIT_BLOB
	CRLIssuer as CERT_ALT_NAME_INFO
end type

type CRL_DIST_POINT as _CRL_DIST_POINT
type PCRL_DIST_POINT as _CRL_DIST_POINT ptr
const CRL_REASON_UNUSED_FLAG = &h80
const CRL_REASON_KEY_COMPROMISE_FLAG = &h40
const CRL_REASON_CA_COMPROMISE_FLAG = &h20
const CRL_REASON_AFFILIATION_CHANGED_FLAG = &h10
const CRL_REASON_SUPERSEDED_FLAG = &h08
const CRL_REASON_CESSATION_OF_OPERATION_FLAG = &h04
const CRL_REASON_CERTIFICATE_HOLD_FLAG = &h02

type _CRL_DIST_POINTS_INFO
	cDistPoint as DWORD
	rgDistPoint as PCRL_DIST_POINT
end type

type CRL_DIST_POINTS_INFO as _CRL_DIST_POINTS_INFO
type PCRL_DIST_POINTS_INFO as _CRL_DIST_POINTS_INFO ptr
const CRL_DIST_POINT_ERR_INDEX_MASK = &h7f
const CRL_DIST_POINT_ERR_INDEX_SHIFT = 24
#define GET_CRL_DIST_POINT_ERR_INDEX(X) ((X shr CRL_DIST_POINT_ERR_INDEX_SHIFT) and CRL_DIST_POINT_ERR_INDEX_MASK)
const CRL_DIST_POINT_ERR_CRL_ISSUER_BIT = &h80000000
#define IS_CRL_DIST_POINT_ERR_CRL_ISSUER(X) (0 <> (X and CRL_DIST_POINT_ERR_CRL_ISSUER_BIT))

type _CROSS_CERT_DIST_POINTS_INFO
	dwSyncDeltaTime as DWORD
	cDistPoint as DWORD
	rgDistPoint as PCERT_ALT_NAME_INFO
end type

type CROSS_CERT_DIST_POINTS_INFO as _CROSS_CERT_DIST_POINTS_INFO
type PCROSS_CERT_DIST_POINTS_INFO as _CROSS_CERT_DIST_POINTS_INFO ptr
const CROSS_CERT_DIST_POINT_ERR_INDEX_MASK = &hff
const CROSS_CERT_DIST_POINT_ERR_INDEX_SHIFT = 24
#define GET_CROSS_CERT_DIST_POINT_ERR_INDEX(X) ((X shr CROSS_CERT_DIST_POINT_ERR_INDEX_SHIFT) and CROSS_CERT_DIST_POINT_ERR_INDEX_MASK)

type _CERT_PAIR
	Forward as CERT_BLOB
	Reverse as CERT_BLOB
end type

type CERT_PAIR as _CERT_PAIR
type PCERT_PAIR as _CERT_PAIR ptr

type _CRL_ISSUING_DIST_POINT
	DistPointName as CRL_DIST_POINT_NAME
	fOnlyContainsUserCerts as WINBOOL
	fOnlyContainsCACerts as WINBOOL
	OnlySomeReasonFlags as CRYPT_BIT_BLOB
	fIndirectCRL as WINBOOL
end type

type CRL_ISSUING_DIST_POINT as _CRL_ISSUING_DIST_POINT
type PCRL_ISSUING_DIST_POINT as _CRL_ISSUING_DIST_POINT ptr

type _CERT_GENERAL_SUBTREE
	Base as CERT_ALT_NAME_ENTRY
	dwMinimum as DWORD
	fMaximum as WINBOOL
	dwMaximum as DWORD
end type

type CERT_GENERAL_SUBTREE as _CERT_GENERAL_SUBTREE
type PCERT_GENERAL_SUBTREE as _CERT_GENERAL_SUBTREE ptr

type _CERT_NAME_CONSTRAINTS_INFO
	cPermittedSubtree as DWORD
	rgPermittedSubtree as PCERT_GENERAL_SUBTREE
	cExcludedSubtree as DWORD
	rgExcludedSubtree as PCERT_GENERAL_SUBTREE
end type

type CERT_NAME_CONSTRAINTS_INFO as _CERT_NAME_CONSTRAINTS_INFO
type PCERT_NAME_CONSTRAINTS_INFO as _CERT_NAME_CONSTRAINTS_INFO ptr
const CERT_EXCLUDED_SUBTREE_BIT = &h80000000
#define IS_CERT_EXCLUDED_SUBTREE(X) (0 <> (X and CERT_EXCLUDED_SUBTREE_BIT))
const SORTED_CTL_EXT_FLAGS_OFFSET = 0
const SORTED_CTL_EXT_COUNT_OFFSET = 4
const SORTED_CTL_EXT_MAX_COLLISION_OFFSET = 8
const SORTED_CTL_EXT_HASH_BUCKET_OFFSET = 12
const SORTED_CTL_EXT_HASHED_SUBJECT_IDENTIFIER_FLAG = &h1

type _CERT_DSS_PARAMETERS
	p as CRYPT_UINT_BLOB
	q as CRYPT_UINT_BLOB
	g as CRYPT_UINT_BLOB
end type

type CERT_DSS_PARAMETERS as _CERT_DSS_PARAMETERS
type PCERT_DSS_PARAMETERS as _CERT_DSS_PARAMETERS ptr
const CERT_DSS_R_LEN = 20
const CERT_DSS_S_LEN = 20
const CERT_DSS_SIGNATURE_LEN = CERT_DSS_R_LEN + CERT_DSS_S_LEN
const CERT_MAX_ASN_ENCODED_DSS_SIGNATURE_LEN = 48

type _CERT_DH_PARAMETERS
	p as CRYPT_UINT_BLOB
	g as CRYPT_UINT_BLOB
end type

type CERT_DH_PARAMETERS as _CERT_DH_PARAMETERS
type PCERT_DH_PARAMETERS as _CERT_DH_PARAMETERS ptr

type _CERT_ECC_SIGNATURE
	r as CRYPT_UINT_BLOB
	s as CRYPT_UINT_BLOB
end type

type CERT_ECC_SIGNATURE as _CERT_ECC_SIGNATURE
type PCERT_ECC_SIGNATURE as _CERT_ECC_SIGNATURE ptr

type _CERT_X942_DH_VALIDATION_PARAMS
	seed as CRYPT_BIT_BLOB
	pgenCounter as DWORD
end type

type CERT_X942_DH_VALIDATION_PARAMS as _CERT_X942_DH_VALIDATION_PARAMS
type PCERT_X942_DH_VALIDATION_PARAMS as _CERT_X942_DH_VALIDATION_PARAMS ptr

type _CERT_X942_DH_PARAMETERS
	p as CRYPT_UINT_BLOB
	g as CRYPT_UINT_BLOB
	q as CRYPT_UINT_BLOB
	j as CRYPT_UINT_BLOB
	pValidationParams as PCERT_X942_DH_VALIDATION_PARAMS
end type

type CERT_X942_DH_PARAMETERS as _CERT_X942_DH_PARAMETERS
type PCERT_X942_DH_PARAMETERS as _CERT_X942_DH_PARAMETERS ptr
const CRYPT_X942_COUNTER_BYTE_LENGTH = 4
const CRYPT_X942_KEY_LENGTH_BYTE_LENGTH = 4
const CRYPT_X942_PUB_INFO_BYTE_LENGTH = 512 / 8

type _CRYPT_X942_OTHER_INFO
	pszContentEncryptionObjId as LPSTR
	rgbCounter(0 to 3) as UBYTE
	rgbKeyLength(0 to 3) as UBYTE
	PubInfo as CRYPT_DATA_BLOB
end type

type CRYPT_X942_OTHER_INFO as _CRYPT_X942_OTHER_INFO
type PCRYPT_X942_OTHER_INFO as _CRYPT_X942_OTHER_INFO ptr
const CRYPT_ECC_CMS_SHARED_INFO_SUPPPUBINFO_BYTE_LENGTH = 4

type _CRYPT_ECC_CMS_SHARED_INFO
	Algorithm as CRYPT_ALGORITHM_IDENTIFIER
	EntityUInfo as CRYPT_DATA_BLOB
	rgbSuppPubInfo(0 to 3) as UBYTE
end type

type CRYPT_ECC_CMS_SHARED_INFO as _CRYPT_ECC_CMS_SHARED_INFO
type PCRYPT_ECC_CMS_SHARED_INFO as _CRYPT_ECC_CMS_SHARED_INFO ptr

type _CRYPT_RC2_CBC_PARAMETERS
	dwVersion as DWORD
	fIV as WINBOOL
	rgbIV(0 to 7) as UBYTE
end type

type CRYPT_RC2_CBC_PARAMETERS as _CRYPT_RC2_CBC_PARAMETERS
type PCRYPT_RC2_CBC_PARAMETERS as _CRYPT_RC2_CBC_PARAMETERS ptr
const CRYPT_RC2_40BIT_VERSION = 160
const CRYPT_RC2_56BIT_VERSION = 52
const CRYPT_RC2_64BIT_VERSION = 120
const CRYPT_RC2_128BIT_VERSION = 58

type _CRYPT_SMIME_CAPABILITY
	pszObjId as LPSTR
	Parameters as CRYPT_OBJID_BLOB
end type

type CRYPT_SMIME_CAPABILITY as _CRYPT_SMIME_CAPABILITY
type PCRYPT_SMIME_CAPABILITY as _CRYPT_SMIME_CAPABILITY ptr

type _CRYPT_SMIME_CAPABILITIES
	cCapability as DWORD
	rgCapability as PCRYPT_SMIME_CAPABILITY
end type

type CRYPT_SMIME_CAPABILITIES as _CRYPT_SMIME_CAPABILITIES
type PCRYPT_SMIME_CAPABILITIES as _CRYPT_SMIME_CAPABILITIES ptr

type _CERT_QC_STATEMENT
	pszStatementId as LPSTR
	StatementInfo as CRYPT_OBJID_BLOB
end type

type CERT_QC_STATEMENT as _CERT_QC_STATEMENT
type PCERT_QC_STATEMENT as _CERT_QC_STATEMENT ptr

type _CERT_QC_STATEMENTS_EXT_INFO
	cStatement as DWORD
	rgStatement as PCERT_QC_STATEMENT
end type

type CERT_QC_STATEMENTS_EXT_INFO as _CERT_QC_STATEMENTS_EXT_INFO
type PCERT_QC_STATEMENTS_EXT_INFO as _CERT_QC_STATEMENTS_EXT_INFO ptr
#define szOID_QC_EU_COMPLIANCE "0.4.0.1862.1.1"
#define szOID_QC_SSCD "0.4.0.1862.1.4"

type _CRYPT_MASK_GEN_ALGORITHM
	pszObjId as LPSTR
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
end type

type CRYPT_MASK_GEN_ALGORITHM as _CRYPT_MASK_GEN_ALGORITHM
type PCRYPT_MASK_GEN_ALGORITHM as _CRYPT_MASK_GEN_ALGORITHM ptr

type _CRYPT_RSA_SSA_PSS_PARAMETERS
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	MaskGenAlgorithm as CRYPT_MASK_GEN_ALGORITHM
	dwSaltLength as DWORD
	dwTrailerField as DWORD
end type

type CRYPT_RSA_SSA_PSS_PARAMETERS as _CRYPT_RSA_SSA_PSS_PARAMETERS
type PCRYPT_RSA_SSA_PSS_PARAMETERS as _CRYPT_RSA_SSA_PSS_PARAMETERS ptr
const PKCS_RSA_SSA_PSS_TRAILER_FIELD_BC = 1

type _CRYPT_PSOURCE_ALGORITHM
	pszObjId as LPSTR
	EncodingParameters as CRYPT_DATA_BLOB
end type

type CRYPT_PSOURCE_ALGORITHM as _CRYPT_PSOURCE_ALGORITHM
type PCRYPT_PSOURCE_ALGORITHM as _CRYPT_PSOURCE_ALGORITHM ptr

type _CRYPT_RSAES_OAEP_PARAMETERS
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	MaskGenAlgorithm as CRYPT_MASK_GEN_ALGORITHM
	PSourceAlgorithm as CRYPT_PSOURCE_ALGORITHM
end type

type CRYPT_RSAES_OAEP_PARAMETERS as _CRYPT_RSAES_OAEP_PARAMETERS
type PCRYPT_RSAES_OAEP_PARAMETERS as _CRYPT_RSAES_OAEP_PARAMETERS ptr
#define szOID_VERISIGN_PRIVATE_6_9 "2.16.840.1.113733.1.6.9"
#define szOID_VERISIGN_ONSITE_JURISDICTION_HASH "2.16.840.1.113733.1.6.11"
#define szOID_VERISIGN_BITSTRING_6_13 "2.16.840.1.113733.1.6.13"
#define szOID_VERISIGN_ISS_STRONG_CRYPTO "2.16.840.1.113733.1.8.1"
#define szOID_NETSCAPE "2.16.840.1.113730"
#define szOID_NETSCAPE_CERT_EXTENSION "2.16.840.1.113730.1"
#define szOID_NETSCAPE_CERT_TYPE "2.16.840.1.113730.1.1"
#define szOID_NETSCAPE_BASE_URL "2.16.840.1.113730.1.2"
#define szOID_NETSCAPE_REVOCATION_URL "2.16.840.1.113730.1.3"
#define szOID_NETSCAPE_CA_REVOCATION_URL "2.16.840.1.113730.1.4"
#define szOID_NETSCAPE_CERT_RENEWAL_URL "2.16.840.1.113730.1.7"
#define szOID_NETSCAPE_CA_POLICY_URL "2.16.840.1.113730.1.8"
#define szOID_NETSCAPE_SSL_SERVER_NAME "2.16.840.1.113730.1.12"
#define szOID_NETSCAPE_COMMENT "2.16.840.1.113730.1.13"
#define szOID_NETSCAPE_DATA_TYPE "2.16.840.1.113730.2"
#define szOID_NETSCAPE_CERT_SEQUENCE "2.16.840.1.113730.2.5"
const NETSCAPE_SIGN_CA_CERT_TYPE = &h01
const NETSCAPE_SMIME_CA_CERT_TYPE = &h02
const NETSCAPE_SSL_CA_CERT_TYPE = &h04
const NETSCAPE_SIGN_CERT_TYPE = &h10
const NETSCAPE_SMIME_CERT_TYPE = &h20
const NETSCAPE_SSL_SERVER_AUTH_CERT_TYPE = &h40
const NETSCAPE_SSL_CLIENT_AUTH_CERT_TYPE = &h80
#define szOID_CT_PKI_DATA "1.3.6.1.5.5.7.12.2"
#define szOID_CT_PKI_RESPONSE "1.3.6.1.5.5.7.12.3"
#define szOID_PKIX_NO_SIGNATURE "1.3.6.1.5.5.7.6.2"
#define szOID_CMC "1.3.6.1.5.5.7.7"
#define szOID_CMC_STATUS_INFO "1.3.6.1.5.5.7.7.1"
#define szOID_CMC_IDENTIFICATION "1.3.6.1.5.5.7.7.2"
#define szOID_CMC_IDENTITY_PROOF "1.3.6.1.5.5.7.7.3"
#define szOID_CMC_DATA_RETURN "1.3.6.1.5.5.7.7.4"
#define szOID_CMC_TRANSACTION_ID "1.3.6.1.5.5.7.7.5"
#define szOID_CMC_SENDER_NONCE "1.3.6.1.5.5.7.7.6"
#define szOID_CMC_RECIPIENT_NONCE "1.3.6.1.5.5.7.7.7"
#define szOID_CMC_ADD_EXTENSIONS "1.3.6.1.5.5.7.7.8"
#define szOID_CMC_ENCRYPTED_POP "1.3.6.1.5.5.7.7.9"
#define szOID_CMC_DECRYPTED_POP "1.3.6.1.5.5.7.7.10"
#define szOID_CMC_LRA_POP_WITNESS "1.3.6.1.5.5.7.7.11"
#define szOID_CMC_GET_CERT "1.3.6.1.5.5.7.7.15"
#define szOID_CMC_GET_CRL "1.3.6.1.5.5.7.7.16"
#define szOID_CMC_REVOKE_REQUEST "1.3.6.1.5.5.7.7.17"
#define szOID_CMC_REG_INFO "1.3.6.1.5.5.7.7.18"
#define szOID_CMC_RESPONSE_INFO "1.3.6.1.5.5.7.7.19"
#define szOID_CMC_QUERY_PENDING "1.3.6.1.5.5.7.7.21"
#define szOID_CMC_ID_POP_LINK_RANDOM "1.3.6.1.5.5.7.7.22"
#define szOID_CMC_ID_POP_LINK_WITNESS "1.3.6.1.5.5.7.7.23"
#define szOID_CMC_ID_CONFIRM_CERT_ACCEPTANCE "1.3.6.1.5.5.7.7.24"
#define szOID_CMC_ADD_ATTRIBUTES "1.3.6.1.4.1.311.10.10.1"

type _CMC_TAGGED_ATTRIBUTE
	dwBodyPartID as DWORD
	Attribute as CRYPT_ATTRIBUTE
end type

type CMC_TAGGED_ATTRIBUTE as _CMC_TAGGED_ATTRIBUTE
type PCMC_TAGGED_ATTRIBUTE as _CMC_TAGGED_ATTRIBUTE ptr

type _CMC_TAGGED_CERT_REQUEST
	dwBodyPartID as DWORD
	SignedCertRequest as CRYPT_DER_BLOB
end type

type CMC_TAGGED_CERT_REQUEST as _CMC_TAGGED_CERT_REQUEST
type PCMC_TAGGED_CERT_REQUEST as _CMC_TAGGED_CERT_REQUEST ptr

type _CMC_TAGGED_REQUEST
	dwTaggedRequestChoice as DWORD

	union
		pTaggedCertRequest as PCMC_TAGGED_CERT_REQUEST
	end union
end type

type CMC_TAGGED_REQUEST as _CMC_TAGGED_REQUEST
type PCMC_TAGGED_REQUEST as _CMC_TAGGED_REQUEST ptr
const CMC_TAGGED_CERT_REQUEST_CHOICE = 1

type _CMC_TAGGED_CONTENT_INFO
	dwBodyPartID as DWORD
	EncodedContentInfo as CRYPT_DER_BLOB
end type

type CMC_TAGGED_CONTENT_INFO as _CMC_TAGGED_CONTENT_INFO
type PCMC_TAGGED_CONTENT_INFO as _CMC_TAGGED_CONTENT_INFO ptr

type _CMC_TAGGED_OTHER_MSG
	dwBodyPartID as DWORD
	pszObjId as LPSTR
	Value as CRYPT_OBJID_BLOB
end type

type CMC_TAGGED_OTHER_MSG as _CMC_TAGGED_OTHER_MSG
type PCMC_TAGGED_OTHER_MSG as _CMC_TAGGED_OTHER_MSG ptr

type _CMC_DATA_INFO
	cTaggedAttribute as DWORD
	rgTaggedAttribute as PCMC_TAGGED_ATTRIBUTE
	cTaggedRequest as DWORD
	rgTaggedRequest as PCMC_TAGGED_REQUEST
	cTaggedContentInfo as DWORD
	rgTaggedContentInfo as PCMC_TAGGED_CONTENT_INFO
	cTaggedOtherMsg as DWORD
	rgTaggedOtherMsg as PCMC_TAGGED_OTHER_MSG
end type

type CMC_DATA_INFO as _CMC_DATA_INFO
type PCMC_DATA_INFO as _CMC_DATA_INFO ptr

type _CMC_RESPONSE_INFO
	cTaggedAttribute as DWORD
	rgTaggedAttribute as PCMC_TAGGED_ATTRIBUTE
	cTaggedContentInfo as DWORD
	rgTaggedContentInfo as PCMC_TAGGED_CONTENT_INFO
	cTaggedOtherMsg as DWORD
	rgTaggedOtherMsg as PCMC_TAGGED_OTHER_MSG
end type

type CMC_RESPONSE_INFO as _CMC_RESPONSE_INFO
type PCMC_RESPONSE_INFO as _CMC_RESPONSE_INFO ptr

type _CMC_PEND_INFO
	PendToken as CRYPT_DATA_BLOB
	PendTime as FILETIME
end type

type CMC_PEND_INFO as _CMC_PEND_INFO
type PCMC_PEND_INFO as _CMC_PEND_INFO ptr

type _CMC_STATUS_INFO
	dwStatus as DWORD
	cBodyList as DWORD
	rgdwBodyList as DWORD ptr
	pwszStatusString as LPWSTR
	dwOtherInfoChoice as DWORD

	union
		dwFailInfo as DWORD
		pPendInfo as PCMC_PEND_INFO
	end union
end type

type CMC_STATUS_INFO as _CMC_STATUS_INFO
type PCMC_STATUS_INFO as _CMC_STATUS_INFO ptr
const CMC_OTHER_INFO_NO_CHOICE = 0
const CMC_OTHER_INFO_FAIL_CHOICE = 1
const CMC_OTHER_INFO_PEND_CHOICE = 2
const CMC_STATUS_SUCCESS = 0
const CMC_STATUS_FAILED = 2
const CMC_STATUS_PENDING = 3
const CMC_STATUS_NO_SUPPORT = 4
const CMC_STATUS_CONFIRM_REQUIRED = 5
const CMC_FAIL_BAD_ALG = 0
const CMC_FAIL_BAD_MESSAGE_CHECK = 1
const CMC_FAIL_BAD_REQUEST = 2
const CMC_FAIL_BAD_TIME = 3
const CMC_FAIL_BAD_CERT_ID = 4
const CMC_FAIL_UNSUPORTED_EXT = 5
const CMC_FAIL_MUST_ARCHIVE_KEYS = 6
const CMC_FAIL_BAD_IDENTITY = 7
const CMC_FAIL_POP_REQUIRED = 8
const CMC_FAIL_POP_FAILED = 9
const CMC_FAIL_NO_KEY_REUSE = 10
const CMC_FAIL_INTERNAL_CA_ERROR = 11
const CMC_FAIL_TRY_LATER = 12

type _CMC_ADD_EXTENSIONS_INFO
	dwCmcDataReference as DWORD
	cCertReference as DWORD
	rgdwCertReference as DWORD ptr
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type CMC_ADD_EXTENSIONS_INFO as _CMC_ADD_EXTENSIONS_INFO
type PCMC_ADD_EXTENSIONS_INFO as _CMC_ADD_EXTENSIONS_INFO ptr

type _CMC_ADD_ATTRIBUTES_INFO
	dwCmcDataReference as DWORD
	cCertReference as DWORD
	rgdwCertReference as DWORD ptr
	cAttribute as DWORD
	rgAttribute as PCRYPT_ATTRIBUTE
end type

type CMC_ADD_ATTRIBUTES_INFO as _CMC_ADD_ATTRIBUTES_INFO
type PCMC_ADD_ATTRIBUTES_INFO as _CMC_ADD_ATTRIBUTES_INFO ptr

type _CERT_TEMPLATE_EXT
	pszObjId as LPSTR
	dwMajorVersion as DWORD
	fMinorVersion as WINBOOL
	dwMinorVersion as DWORD
end type

type CERT_TEMPLATE_EXT as _CERT_TEMPLATE_EXT
type PCERT_TEMPLATE_EXT as _CERT_TEMPLATE_EXT ptr

type _CERT_HASHED_URL
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Hash as CRYPT_HASH_BLOB
	pwszUrl as LPWSTR
end type

type CERT_HASHED_URL as _CERT_HASHED_URL
type PCERT_HASHED_URL as _CERT_HASHED_URL ptr

type _CERT_LOGOTYPE_DETAILS
	pwszMimeType as LPWSTR
	cHashedUrl as DWORD
	rgHashedUrl as PCERT_HASHED_URL
end type

type CERT_LOGOTYPE_DETAILS as _CERT_LOGOTYPE_DETAILS
type PCERT_LOGOTYPE_DETAILS as _CERT_LOGOTYPE_DETAILS ptr

type _CERT_LOGOTYPE_REFERENCE
	cHashedUrl as DWORD
	rgHashedUrl as PCERT_HASHED_URL
end type

type CERT_LOGOTYPE_REFERENCE as _CERT_LOGOTYPE_REFERENCE
type PCERT_LOGOTYPE_REFERENCE as _CERT_LOGOTYPE_REFERENCE ptr

type _CERT_LOGOTYPE_IMAGE_INFO
	dwLogotypeImageInfoChoice as DWORD
	dwFileSize as DWORD
	dwXSize as DWORD
	dwYSize as DWORD
	dwLogotypeImageResolutionChoice as DWORD

	union
		dwNumBits as DWORD
		dwTableSize as DWORD
	end union

	pwszLanguage as LPWSTR
end type

type CERT_LOGOTYPE_IMAGE_INFO as _CERT_LOGOTYPE_IMAGE_INFO
type PCERT_LOGOTYPE_IMAGE_INFO as _CERT_LOGOTYPE_IMAGE_INFO ptr
const CERT_LOGOTYPE_GRAY_SCALE_IMAGE_INFO_CHOICE = 1
const CERT_LOGOTYPE_COLOR_IMAGE_INFO_CHOICE = 2
const CERT_LOGOTYPE_NO_IMAGE_RESOLUTION_CHOICE = 0
const CERT_LOGOTYPE_BITS_IMAGE_RESOLUTION_CHOICE = 1
const CERT_LOGOTYPE_TABLE_SIZE_IMAGE_RESOLUTION_CHOICE = 2

type _CERT_LOGOTYPE_IMAGE
	LogotypeDetails as CERT_LOGOTYPE_DETAILS
	pLogotypeImageInfo as PCERT_LOGOTYPE_IMAGE_INFO
end type

type CERT_LOGOTYPE_IMAGE as _CERT_LOGOTYPE_IMAGE
type PCERT_LOGOTYPE_IMAGE as _CERT_LOGOTYPE_IMAGE ptr

type _CERT_LOGOTYPE_AUDIO_INFO
	dwFileSize as DWORD
	dwPlayTime as DWORD
	dwChannels as DWORD
	dwSampleRate as DWORD
	pwszLanguage as LPWSTR
end type

type CERT_LOGOTYPE_AUDIO_INFO as _CERT_LOGOTYPE_AUDIO_INFO
type PCERT_LOGOTYPE_AUDIO_INFO as _CERT_LOGOTYPE_AUDIO_INFO ptr

type _CERT_LOGOTYPE_AUDIO
	LogotypeDetails as CERT_LOGOTYPE_DETAILS
	pLogotypeAudioInfo as PCERT_LOGOTYPE_AUDIO_INFO
end type

type CERT_LOGOTYPE_AUDIO as _CERT_LOGOTYPE_AUDIO
type PCERT_LOGOTYPE_AUDIO as _CERT_LOGOTYPE_AUDIO ptr

type _CERT_LOGOTYPE_DATA
	cLogotypeImage as DWORD
	rgLogotypeImage as PCERT_LOGOTYPE_IMAGE
	cLogotypeAudio as DWORD
	rgLogotypeAudio as PCERT_LOGOTYPE_AUDIO
end type

type CERT_LOGOTYPE_DATA as _CERT_LOGOTYPE_DATA
type PCERT_LOGOTYPE_DATA as _CERT_LOGOTYPE_DATA ptr

type _CERT_LOGOTYPE_INFO
	dwLogotypeInfoChoice as DWORD

	union
		pLogotypeDirectInfo as PCERT_LOGOTYPE_DATA
		pLogotypeIndirectInfo as PCERT_LOGOTYPE_REFERENCE
	end union
end type

type CERT_LOGOTYPE_INFO as _CERT_LOGOTYPE_INFO
type PCERT_LOGOTYPE_INFO as _CERT_LOGOTYPE_INFO ptr
const CERT_LOGOTYPE_DIRECT_INFO_CHOICE = 1
const CERT_LOGOTYPE_INDIRECT_INFO_CHOICE = 2

type _CERT_OTHER_LOGOTYPE_INFO
	pszObjId as LPSTR
	LogotypeInfo as CERT_LOGOTYPE_INFO
end type

type CERT_OTHER_LOGOTYPE_INFO as _CERT_OTHER_LOGOTYPE_INFO
type PCERT_OTHER_LOGOTYPE_INFO as _CERT_OTHER_LOGOTYPE_INFO ptr
#define szOID_LOYALTY_OTHER_LOGOTYPE "1.3.6.1.5.5.7.20.1"
#define szOID_BACKGROUND_OTHER_LOGOTYPE "1.3.6.1.5.5.7.20.2"

type _CERT_LOGOTYPE_EXT_INFO
	cCommunityLogo as DWORD
	rgCommunityLogo as PCERT_LOGOTYPE_INFO
	pIssuerLogo as PCERT_LOGOTYPE_INFO
	pSubjectLogo as PCERT_LOGOTYPE_INFO
	cOtherLogo as DWORD
	rgOtherLogo as PCERT_OTHER_LOGOTYPE_INFO
end type

type CERT_LOGOTYPE_EXT_INFO as _CERT_LOGOTYPE_EXT_INFO
type PCERT_LOGOTYPE_EXT_INFO as _CERT_LOGOTYPE_EXT_INFO ptr

type _CERT_BIOMETRIC_DATA
	dwTypeOfBiometricDataChoice as DWORD

	union
		dwPredefined as DWORD
		pszObjId as LPSTR
	end union

	HashedUrl as CERT_HASHED_URL
end type

type CERT_BIOMETRIC_DATA as _CERT_BIOMETRIC_DATA
type PCERT_BIOMETRIC_DATA as _CERT_BIOMETRIC_DATA ptr
const CERT_BIOMETRIC_PREDEFINED_DATA_CHOICE = 1
const CERT_BIOMETRIC_OID_DATA_CHOICE = 2
const CERT_BIOMETRIC_PICTURE_TYPE = 0
const CERT_BIOMETRIC_SIGNATURE_TYPE = 1

type _CERT_BIOMETRIC_EXT_INFO
	cBiometricData as DWORD
	rgBiometricData as PCERT_BIOMETRIC_DATA
end type

type CERT_BIOMETRIC_EXT_INFO as _CERT_BIOMETRIC_EXT_INFO
type PCERT_BIOMETRIC_EXT_INFO as _CERT_BIOMETRIC_EXT_INFO ptr

type _OCSP_SIGNATURE_INFO
	SignatureAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	Signature as CRYPT_BIT_BLOB
	cCertEncoded as DWORD
	rgCertEncoded as PCERT_BLOB
end type

type OCSP_SIGNATURE_INFO as _OCSP_SIGNATURE_INFO
type POCSP_SIGNATURE_INFO as _OCSP_SIGNATURE_INFO ptr

type _OCSP_SIGNED_REQUEST_INFO
	ToBeSigned as CRYPT_DER_BLOB
	pOptionalSignatureInfo as POCSP_SIGNATURE_INFO
end type

type OCSP_SIGNED_REQUEST_INFO as _OCSP_SIGNED_REQUEST_INFO
type POCSP_SIGNED_REQUEST_INFO as _OCSP_SIGNED_REQUEST_INFO ptr

type _OCSP_CERT_ID
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	IssuerNameHash as CRYPT_HASH_BLOB
	IssuerKeyHash as CRYPT_HASH_BLOB
	SerialNumber as CRYPT_INTEGER_BLOB
end type

type OCSP_CERT_ID as _OCSP_CERT_ID
type POCSP_CERT_ID as _OCSP_CERT_ID ptr

type _OCSP_REQUEST_ENTRY
	CertId as OCSP_CERT_ID
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type OCSP_REQUEST_ENTRY as _OCSP_REQUEST_ENTRY
type POCSP_REQUEST_ENTRY as _OCSP_REQUEST_ENTRY ptr

type _OCSP_REQUEST_INFO
	dwVersion as DWORD
	pRequestorName as PCERT_ALT_NAME_ENTRY
	cRequestEntry as DWORD
	rgRequestEntry as POCSP_REQUEST_ENTRY
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type OCSP_REQUEST_INFO as _OCSP_REQUEST_INFO
type POCSP_REQUEST_INFO as _OCSP_REQUEST_INFO ptr
const OCSP_REQUEST_V1 = 0

type _OCSP_RESPONSE_INFO
	dwStatus as DWORD
	pszObjId as LPSTR
	Value as CRYPT_OBJID_BLOB
end type

type OCSP_RESPONSE_INFO as _OCSP_RESPONSE_INFO
type POCSP_RESPONSE_INFO as _OCSP_RESPONSE_INFO ptr
const OCSP_SUCCESSFUL_RESPONSE = 0
const OCSP_MALFORMED_REQUEST_RESPONSE = 1
const OCSP_INTERNAL_ERROR_RESPONSE = 2
const OCSP_TRY_LATER_RESPONSE = 3
const OCSP_SIG_REQUIRED_RESPONSE = 5
const OCSP_UNAUTHORIZED_RESPONSE = 6
#define szOID_PKIX_OCSP_BASIC_SIGNED_RESPONSE "1.3.6.1.5.5.7.48.1.1"

type _OCSP_BASIC_SIGNED_RESPONSE_INFO
	ToBeSigned as CRYPT_DER_BLOB
	SignatureInfo as OCSP_SIGNATURE_INFO
end type

type OCSP_BASIC_SIGNED_RESPONSE_INFO as _OCSP_BASIC_SIGNED_RESPONSE_INFO
type POCSP_BASIC_SIGNED_RESPONSE_INFO as _OCSP_BASIC_SIGNED_RESPONSE_INFO ptr

type _OCSP_BASIC_REVOKED_INFO
	RevocationDate as FILETIME
	dwCrlReasonCode as DWORD
end type

type OCSP_BASIC_REVOKED_INFO as _OCSP_BASIC_REVOKED_INFO
type POCSP_BASIC_REVOKED_INFO as _OCSP_BASIC_REVOKED_INFO ptr

type _OCSP_BASIC_RESPONSE_ENTRY
	CertId as OCSP_CERT_ID
	dwCertStatus as DWORD

	union
		pRevokedInfo as POCSP_BASIC_REVOKED_INFO
	end union

	ThisUpdate as FILETIME
	NextUpdate as FILETIME
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type OCSP_BASIC_RESPONSE_ENTRY as _OCSP_BASIC_RESPONSE_ENTRY
type POCSP_BASIC_RESPONSE_ENTRY as _OCSP_BASIC_RESPONSE_ENTRY ptr
const OCSP_BASIC_GOOD_CERT_STATUS = 0
const OCSP_BASIC_REVOKED_CERT_STATUS = 1
const OCSP_BASIC_UNKNOWN_CERT_STATUS = 2

type _OCSP_BASIC_RESPONSE_INFO
	dwVersion as DWORD
	dwResponderIdChoice as DWORD

	union
		ByNameResponderId as CERT_NAME_BLOB
		ByKeyResponderId as CRYPT_HASH_BLOB
	end union

	ProducedAt as FILETIME
	cResponseEntry as DWORD
	rgResponseEntry as POCSP_BASIC_RESPONSE_ENTRY
	cExtension as DWORD
	rgExtension as PCERT_EXTENSION
end type

type OCSP_BASIC_RESPONSE_INFO as _OCSP_BASIC_RESPONSE_INFO
type POCSP_BASIC_RESPONSE_INFO as _OCSP_BASIC_RESPONSE_INFO ptr
const OCSP_BASIC_RESPONSE_V1 = 0
const OCSP_BASIC_BY_NAME_RESPONDER_ID = 1
const OCSP_BASIC_BY_KEY_RESPONDER_ID = 2
type HCRYPTOIDFUNCSET as any ptr
type HCRYPTOIDFUNCADDR as any ptr
#define CRYPT_OID_ENCODE_OBJECT_FUNC "CryptDllEncodeObject"
#define CRYPT_OID_DECODE_OBJECT_FUNC "CryptDllDecodeObject"
#define CRYPT_OID_ENCODE_OBJECT_EX_FUNC "CryptDllEncodeObjectEx"
#define CRYPT_OID_DECODE_OBJECT_EX_FUNC "CryptDllDecodeObjectEx"
#define CRYPT_OID_CREATE_COM_OBJECT_FUNC "CryptDllCreateCOMObject"
#define CRYPT_OID_VERIFY_REVOCATION_FUNC "CertDllVerifyRevocation"
#define CRYPT_OID_VERIFY_CTL_USAGE_FUNC "CertDllVerifyCTLUsage"
#define CRYPT_OID_FORMAT_OBJECT_FUNC "CryptDllFormatObject"
#define CRYPT_OID_FIND_OID_INFO_FUNC "CryptDllFindOIDInfo"
#define CRYPT_OID_FIND_LOCALIZED_NAME_FUNC "CryptDllFindLocalizedName"
#define CRYPT_OID_REGPATH !"Software\\Microsoft\\Cryptography\\OID"
#define CRYPT_OID_REG_ENCODING_TYPE_PREFIX "EncodingType "
#define CRYPT_OID_REG_DLL_VALUE_NAME wstr("Dll")
#define CRYPT_OID_REG_FUNC_NAME_VALUE_NAME wstr("FuncName")
#define CRYPT_OID_REG_FUNC_NAME_VALUE_NAME_A "FuncName"
#define CRYPT_OID_REG_FLAGS_VALUE_NAME wstr("CryptFlags")
#define CRYPT_DEFAULT_OID "DEFAULT"

type _CRYPT_OID_FUNC_ENTRY
	pszOID as LPCSTR
	pvFuncAddr as any ptr
end type

type CRYPT_OID_FUNC_ENTRY as _CRYPT_OID_FUNC_ENTRY
type PCRYPT_OID_FUNC_ENTRY as _CRYPT_OID_FUNC_ENTRY ptr
const CRYPT_INSTALL_OID_FUNC_BEFORE_FLAG = 1
const CRYPT_GET_INSTALLED_OID_FUNC_FLAG = &h1
const CRYPT_REGISTER_FIRST_INDEX = 0
const CRYPT_REGISTER_LAST_INDEX = &hffffffff

declare function CryptInstallOIDFunctionAddress(byval hModule as HMODULE, byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval cFuncEntry as DWORD, byval rgFuncEntry as const CRYPT_OID_FUNC_ENTRY ptr, byval dwFlags as DWORD) as WINBOOL
declare function CryptInitOIDFunctionSet(byval pszFuncName as LPCSTR, byval dwFlags as DWORD) as HCRYPTOIDFUNCSET
declare function CryptGetOIDFunctionAddress(byval hFuncSet as HCRYPTOIDFUNCSET, byval dwEncodingType as DWORD, byval pszOID as LPCSTR, byval dwFlags as DWORD, byval ppvFuncAddr as any ptr ptr, byval phFuncAddr as HCRYPTOIDFUNCADDR ptr) as WINBOOL
declare function CryptGetDefaultOIDDllList(byval hFuncSet as HCRYPTOIDFUNCSET, byval dwEncodingType as DWORD, byval pwszDllList as wstring ptr, byval pcchDllList as DWORD ptr) as WINBOOL
declare function CryptGetDefaultOIDFunctionAddress(byval hFuncSet as HCRYPTOIDFUNCSET, byval dwEncodingType as DWORD, byval pwszDll as LPCWSTR, byval dwFlags as DWORD, byval ppvFuncAddr as any ptr ptr, byval phFuncAddr as HCRYPTOIDFUNCADDR ptr) as WINBOOL
declare function CryptFreeOIDFunctionAddress(byval hFuncAddr as HCRYPTOIDFUNCADDR, byval dwFlags as DWORD) as WINBOOL
declare function CryptRegisterOIDFunction(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pszOID as LPCSTR, byval pwszDll as LPCWSTR, byval pszOverrideFuncName as LPCSTR) as WINBOOL
declare function CryptUnregisterOIDFunction(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pszOID as LPCSTR) as WINBOOL
declare function CryptRegisterDefaultOIDFunction(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval dwIndex as DWORD, byval pwszDll as LPCWSTR) as WINBOOL
declare function CryptUnregisterDefaultOIDFunction(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pwszDll as LPCWSTR) as WINBOOL
declare function CryptSetOIDFunctionValue(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pszOID as LPCSTR, byval pwszValueName as LPCWSTR, byval dwValueType as DWORD, byval pbValueData as const UBYTE ptr, byval cbValueData as DWORD) as WINBOOL
declare function CryptGetOIDFunctionValue(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pszOID as LPCSTR, byval pwszValueName as LPCWSTR, byval pdwValueType as DWORD ptr, byval pbValueData as UBYTE ptr, byval pcbValueData as DWORD ptr) as WINBOOL
type PFN_CRYPT_ENUM_OID_FUNC as function(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pszOID as LPCSTR, byval cValue as DWORD, byval rgdwValueType as const DWORD ptr, byval rgpwszValueName as const LPCWSTR ptr, byval rgpbValueData as const UBYTE const ptr ptr, byval rgcbValueData as const DWORD ptr, byval pvArg as any ptr) as WINBOOL
declare function CryptEnumOIDFunction(byval dwEncodingType as DWORD, byval pszFuncName as LPCSTR, byval pszOID as LPCSTR, byval dwFlags as DWORD, byval pvArg as any ptr, byval pfnEnumOIDFunc as PFN_CRYPT_ENUM_OID_FUNC) as WINBOOL

const CRYPT_MATCH_ANY_ENCODING_TYPE = &hffffffff
const CALG_OID_INFO_CNG_ONLY = &hffffffff
const CALG_OID_INFO_PARAMETERS = &hfffffffe
#define IS_SPECIAL_OID_INFO_ALGID(Algid) (Algid >= CALG_OID_INFO_PARAMETERS)
#define CRYPT_OID_INFO_HASH_PARAMETERS_ALGORITHM wstr("CryptOIDInfoHashParameters")
#define CRYPT_OID_INFO_ECC_PARAMETERS_ALGORITHM wstr("CryptOIDInfoECCParameters")
#define CRYPT_OID_INFO_MGF1_PARAMETERS_ALGORITHM wstr("CryptOIDInfoMgf1Parameters")
#define CRYPT_OID_INFO_NO_SIGN_ALGORITHM wstr("CryptOIDInfoNoSign")
#define CRYPT_OID_INFO_OAEP_PARAMETERS_ALGORITHM wstr("CryptOIDInfoOAEPParameters")
#define CRYPT_OID_INFO_ECC_WRAP_PARAMETERS_ALGORITHM wstr("CryptOIDInfoECCWrapParameters")
#define CRYPT_OID_INFO_NO_PARAMETERS_ALGORITHM wstr("CryptOIDInfoNoParameters")

type _CRYPT_OID_INFO
	cbSize as DWORD
	pszOID as LPCSTR
	pwszName as LPCWSTR
	dwGroupId as DWORD

	union
		dwValue as DWORD
		Algid as ALG_ID
		dwLength as DWORD
	end union

	ExtraInfo as CRYPT_DATA_BLOB
end type

type CRYPT_OID_INFO as _CRYPT_OID_INFO
type PCRYPT_OID_INFO as _CRYPT_OID_INFO ptr
type CCRYPT_OID_INFO as const CRYPT_OID_INFO
type PCCRYPT_OID_INFO as const CRYPT_OID_INFO ptr

const CRYPT_HASH_ALG_OID_GROUP_ID = 1
const CRYPT_ENCRYPT_ALG_OID_GROUP_ID = 2
const CRYPT_PUBKEY_ALG_OID_GROUP_ID = 3
const CRYPT_SIGN_ALG_OID_GROUP_ID = 4
const CRYPT_RDN_ATTR_OID_GROUP_ID = 5
const CRYPT_EXT_OR_ATTR_OID_GROUP_ID = 6
const CRYPT_ENHKEY_USAGE_OID_GROUP_ID = 7
const CRYPT_POLICY_OID_GROUP_ID = 8
const CRYPT_TEMPLATE_OID_GROUP_ID = 9
const CRYPT_KDF_OID_GROUP_ID = 10
const CRYPT_LAST_OID_GROUP_ID = 10
const CRYPT_FIRST_ALG_OID_GROUP_ID = CRYPT_HASH_ALG_OID_GROUP_ID
const CRYPT_LAST_ALG_OID_GROUP_ID = CRYPT_SIGN_ALG_OID_GROUP_ID
const CRYPT_OID_INHIBIT_SIGNATURE_FORMAT_FLAG = &h1
const CRYPT_OID_USE_PUBKEY_PARA_FOR_PKCS7_FLAG = &h2
const CRYPT_OID_NO_NULL_ALGORITHM_PARA_FLAG = &h4
const CRYPT_OID_PUBKEY_ENCRYPT_ONLY_FLAG = &h40000000
const CRYPT_OID_PUBKEY_SIGN_ONLY_FLAG = &h80000000
declare function CryptFindOIDInfo(byval dwKeyType as DWORD, byval pvKey as any ptr, byval dwGroupId as DWORD) as PCCRYPT_OID_INFO
const CRYPT_OID_INFO_OID_KEY = 1
const CRYPT_OID_INFO_NAME_KEY = 2
const CRYPT_OID_INFO_ALGID_KEY = 3
const CRYPT_OID_INFO_SIGN_KEY = 4
const CRYPT_OID_INFO_CNG_ALGID_KEY = 5
const CRYPT_OID_INFO_CNG_SIGN_KEY = 6
const CRYPT_OID_INFO_OID_KEY_FLAGS_MASK = &hffff0000
const CRYPT_OID_INFO_PUBKEY_SIGN_KEY_FLAG = &h80000000
const CRYPT_OID_INFO_PUBKEY_ENCRYPT_KEY_FLAG = &h40000000
const CRYPT_OID_DISABLE_SEARCH_DS_FLAG = &h80000000
const CRYPT_OID_INFO_OID_GROUP_BIT_LEN_MASK = &h0fff0000
const CRYPT_OID_INFO_OID_GROUP_BIT_LEN_SHIFT = 16
const CRYPT_INSTALL_OID_INFO_BEFORE_FLAG = 1
type PFN_CRYPT_ENUM_OID_INFO as function(byval pInfo as PCCRYPT_OID_INFO, byval pvArg as any ptr) as WINBOOL

declare function CryptRegisterOIDInfo(byval pInfo as PCCRYPT_OID_INFO, byval dwFlags as DWORD) as WINBOOL
declare function CryptUnregisterOIDInfo(byval pInfo as PCCRYPT_OID_INFO) as WINBOOL
declare function CryptEnumOIDInfo(byval dwGroupId as DWORD, byval dwFlags as DWORD, byval pvArg as any ptr, byval pfnEnumOIDInfo as PFN_CRYPT_ENUM_OID_INFO) as WINBOOL
declare function CryptFindLocalizedName(byval pwszCryptName as LPCWSTR) as LPCWSTR

const CRYPT_LOCALIZED_NAME_ENCODING_TYPE = 0
#define CRYPT_LOCALIZED_NAME_OID "LocalizedNames"
#define CERT_STRONG_SIGN_ECDSA_ALGORITHM wstr("ECDSA")

type _CERT_STRONG_SIGN_SERIALIZED_INFO
	dwFlags as DWORD
	pwszCNGSignHashAlgids as LPWSTR
	pwszCNGPubKeyMinBitLengths as LPWSTR
end type

type CERT_STRONG_SIGN_SERIALIZED_INFO as _CERT_STRONG_SIGN_SERIALIZED_INFO
type PCERT_STRONG_SIGN_SERIALIZED_INFO as _CERT_STRONG_SIGN_SERIALIZED_INFO ptr

type _CERT_STRONG_SIGN_PARA
	cbSize as DWORD
	dwInfoChoice as DWORD

	union
		pvInfo as any ptr
		pSerializedInfo as PCERT_STRONG_SIGN_SERIALIZED_INFO
		pszOID as LPSTR
	end union
end type

type CERT_STRONG_SIGN_PARA as _CERT_STRONG_SIGN_PARA
type PCERT_STRONG_SIGN_PARA as _CERT_STRONG_SIGN_PARA ptr
type PCCERT_STRONG_SIGN_PARA as const CERT_STRONG_SIGN_PARA ptr

const CERT_STRONG_SIGN_SERIALIZED_INFO_CHOICE = 1
const CERT_STRONG_SIGN_OID_INFO_CHOICE = 2
const CERT_STRONG_SIGN_ENABLE_CRL_CHECK = &h1
const CERT_STRONG_SIGN_ENABLE_OCSP_CHECK = &h2
#define szOID_CERT_STRONG_SIGN_OS_PREFIX "1.3.6.1.4.1.311.72.1."
#define szOID_CERT_STRONG_SIGN_OS_1 "1.3.6.1.4.1.311.72.1.1"
#define szOID_CERT_STRONG_SIGN_OS_CURRENT szOID_CERT_STRONG_SIGN_OS_1
#define CERT_STRONG_SIGN_PARA_OS_1 (sizeof(CERT_STRONG_SIGN_PARA), CERT_STRONG_SIGN_OID_INFO_CHOICE, szOID_CERT_STRONG_SIGN_OS_1)
#define CERT_STRONG_SIGN_PARA_OS_CURRENT (sizeof(CERT_STRONG_SIGN_PARA), CERT_STRONG_SIGN_OID_INFO_CHOICE, szOID_CERT_STRONG_SIGN_OS_CURRENT)
#define szOID_CERT_STRONG_KEY_OS_PREFIX "1.3.6.1.4.1.311.72.2."
#define szOID_CERT_STRONG_KEY_OS_1 "1.3.6.1.4.1.311.72.2.1"
#define szOID_CERT_STRONG_KEY_OS_CURRENT szOID_CERT_STRONG_KEY_OS_1
#define CERT_STRONG_KEY_PARA_OS_1 (sizeof(CERT_STRONG_SIGN_PARA), CERT_STRONG_SIGN_OID_INFO_CHOICE, szOID_CERT_STRONG_KEY_OS_1)
#define CERT_STRONG_KEY_PARA_OS_CURRENT (sizeof(CERT_STRONG_SIGN_PARA), CERT_STRONG_SIGN_OID_INFO_CHOICE, szOID_CERT_STRONG_KEY_OS_CURRENT)
type HCRYPTMSG as any ptr
#define szOID_PKCS_7_DATA "1.2.840.113549.1.7.1"
#define szOID_PKCS_7_SIGNED "1.2.840.113549.1.7.2"
#define szOID_PKCS_7_ENVELOPED "1.2.840.113549.1.7.3"
#define szOID_PKCS_7_SIGNEDANDENVELOPED "1.2.840.113549.1.7.4"
#define szOID_PKCS_7_DIGESTED "1.2.840.113549.1.7.5"
#define szOID_PKCS_7_ENCRYPTED "1.2.840.113549.1.7.6"
#define szOID_PKCS_9_CONTENT_TYPE "1.2.840.113549.1.9.3"
#define szOID_PKCS_9_MESSAGE_DIGEST "1.2.840.113549.1.9.4"
const CMSG_DATA = 1
const CMSG_SIGNED = 2
const CMSG_ENVELOPED = 3
const CMSG_SIGNED_AND_ENVELOPED = 4
const CMSG_HASHED = 5
const CMSG_ENCRYPTED = 6
const CMSG_ALL_FLAGS = culng(not 0u)
const CMSG_DATA_FLAG = 1 shl CMSG_DATA
const CMSG_SIGNED_FLAG = 1 shl CMSG_SIGNED
const CMSG_ENVELOPED_FLAG = 1 shl CMSG_ENVELOPED
const CMSG_SIGNED_AND_ENVELOPED_FLAG = 1 shl CMSG_SIGNED_AND_ENVELOPED
const CMSG_HASHED_FLAG = 1 shl CMSG_HASHED
const CMSG_ENCRYPTED_FLAG = 1 shl CMSG_ENCRYPTED

type _CERT_ISSUER_SERIAL_NUMBER
	Issuer as CERT_NAME_BLOB
	SerialNumber as CRYPT_INTEGER_BLOB
end type

type CERT_ISSUER_SERIAL_NUMBER as _CERT_ISSUER_SERIAL_NUMBER
type PCERT_ISSUER_SERIAL_NUMBER as _CERT_ISSUER_SERIAL_NUMBER ptr

type _CERT_ID
	dwIdChoice as DWORD

	union
		IssuerSerialNumber as CERT_ISSUER_SERIAL_NUMBER
		KeyId as CRYPT_HASH_BLOB
		HashId as CRYPT_HASH_BLOB
	end union
end type

type CERT_ID as _CERT_ID
type PCERT_ID as _CERT_ID ptr
const CERT_ID_ISSUER_SERIAL_NUMBER = 1
const CERT_ID_KEY_IDENTIFIER = 2
const CERT_ID_SHA1_HASH = 3

type _CMSG_SIGNER_ENCODE_INFO
	cbSize as DWORD
	pCertInfo as PCERT_INFO

	union
		hCryptProv as HCRYPTPROV
		hNCryptKey as NCRYPT_KEY_HANDLE
	end union

	dwKeySpec as DWORD
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvHashAuxInfo as any ptr
	cAuthAttr as DWORD
	rgAuthAttr as PCRYPT_ATTRIBUTE
	cUnauthAttr as DWORD
	rgUnauthAttr as PCRYPT_ATTRIBUTE
end type

type CMSG_SIGNER_ENCODE_INFO as _CMSG_SIGNER_ENCODE_INFO
type PCMSG_SIGNER_ENCODE_INFO as _CMSG_SIGNER_ENCODE_INFO ptr

type _CMSG_SIGNED_ENCODE_INFO
	cbSize as DWORD
	cSigners as DWORD
	rgSigners as PCMSG_SIGNER_ENCODE_INFO
	cCertEncoded as DWORD
	rgCertEncoded as PCERT_BLOB
	cCrlEncoded as DWORD
	rgCrlEncoded as PCRL_BLOB
end type

type CMSG_SIGNED_ENCODE_INFO as _CMSG_SIGNED_ENCODE_INFO
type PCMSG_SIGNED_ENCODE_INFO as _CMSG_SIGNED_ENCODE_INFO ptr
type CMSG_RECIPIENT_ENCODE_INFO as _CMSG_RECIPIENT_ENCODE_INFO
type PCMSG_RECIPIENT_ENCODE_INFO as _CMSG_RECIPIENT_ENCODE_INFO ptr

type _CMSG_ENVELOPED_ENCODE_INFO
	cbSize as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	ContentEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvEncryptionAuxInfo as any ptr
	cRecipients as DWORD
	rgpRecipients as PCERT_INFO ptr
end type

type CMSG_ENVELOPED_ENCODE_INFO as _CMSG_ENVELOPED_ENCODE_INFO
type PCMSG_ENVELOPED_ENCODE_INFO as _CMSG_ENVELOPED_ENCODE_INFO ptr

type _CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
	cbSize as DWORD
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvKeyEncryptionAuxInfo as any ptr
	hCryptProv as HCRYPTPROV_LEGACY
	RecipientPublicKey as CRYPT_BIT_BLOB
	RecipientId as CERT_ID
end type

type CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO as _CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
type PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO as _CMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO ptr

type _CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO
	cbSize as DWORD
	RecipientPublicKey as CRYPT_BIT_BLOB
	RecipientId as CERT_ID
	Date as FILETIME
	pOtherAttr as PCRYPT_ATTRIBUTE_TYPE_VALUE
end type

type CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO as _CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO
type PCMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO as _CMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO ptr

type _CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
	cbSize as DWORD
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvKeyEncryptionAuxInfo as any ptr
	KeyWrapAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvKeyWrapAuxInfo as any ptr
	hCryptProv as HCRYPTPROV_LEGACY
	dwKeySpec as DWORD
	dwKeyChoice as DWORD

	union
		pEphemeralAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER
		pSenderId as PCERT_ID
	end union

	UserKeyingMaterial as CRYPT_DATA_BLOB
	cRecipientEncryptedKeys as DWORD
	rgpRecipientEncryptedKeys as PCMSG_RECIPIENT_ENCRYPTED_KEY_ENCODE_INFO ptr
end type

type CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO as _CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
type PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO as _CMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO ptr
const CMSG_KEY_AGREE_EPHEMERAL_KEY_CHOICE = 1
const CMSG_KEY_AGREE_STATIC_KEY_CHOICE = 2

type _CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
	cbSize as DWORD
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvKeyEncryptionAuxInfo as any ptr
	hCryptProv as HCRYPTPROV
	dwKeyChoice as DWORD

	union
		hKeyEncryptionKey as HCRYPTKEY
		pvKeyEncryptionKey as any ptr
	end union

	KeyId as CRYPT_DATA_BLOB
	Date as FILETIME
	pOtherAttr as PCRYPT_ATTRIBUTE_TYPE_VALUE
end type

type CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO as _CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
type PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO as _CMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO ptr
const CMSG_MAIL_LIST_HANDLE_KEY_CHOICE = 1
const CMSG_KEY_TRANS_RECIPIENT = 1
const CMSG_KEY_AGREE_RECIPIENT = 2
const CMSG_MAIL_LIST_RECIPIENT = 3
const CMSG_RC4_NO_SALT_FLAG = &h40000000
const CMSG_SP3_COMPATIBLE_ENCRYPT_FLAG = &h80000000

type _CMSG_RECIPIENT_ENCODE_INFO
	dwRecipientChoice as DWORD

	union
		pKeyTrans as PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO
		pKeyAgree as PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO
		pMailList as PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO
	end union
end type

type _CMSG_RC2_AUX_INFO
	cbSize as DWORD
	dwBitLen as DWORD
end type

type CMSG_RC2_AUX_INFO as _CMSG_RC2_AUX_INFO
type PCMSG_RC2_AUX_INFO as _CMSG_RC2_AUX_INFO ptr

type _CMSG_SP3_COMPATIBLE_AUX_INFO
	cbSize as DWORD
	dwFlags as DWORD
end type

type CMSG_SP3_COMPATIBLE_AUX_INFO as _CMSG_SP3_COMPATIBLE_AUX_INFO
type PCMSG_SP3_COMPATIBLE_AUX_INFO as _CMSG_SP3_COMPATIBLE_AUX_INFO ptr

type _CMSG_RC4_AUX_INFO
	cbSize as DWORD
	dwBitLen as DWORD
end type

type CMSG_RC4_AUX_INFO as _CMSG_RC4_AUX_INFO
type PCMSG_RC4_AUX_INFO as _CMSG_RC4_AUX_INFO ptr

type _CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO
	cbSize as DWORD
	SignedInfo as CMSG_SIGNED_ENCODE_INFO
	EnvelopedInfo as CMSG_ENVELOPED_ENCODE_INFO
end type

type CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO as _CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO
type PCMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO as _CMSG_SIGNED_AND_ENVELOPED_ENCODE_INFO ptr

type _CMSG_HASHED_ENCODE_INFO
	cbSize as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvHashAuxInfo as any ptr
end type

type CMSG_HASHED_ENCODE_INFO as _CMSG_HASHED_ENCODE_INFO
type PCMSG_HASHED_ENCODE_INFO as _CMSG_HASHED_ENCODE_INFO ptr

type _CMSG_ENCRYPTED_ENCODE_INFO
	cbSize as DWORD
	ContentEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvEncryptionAuxInfo as any ptr
end type

type CMSG_ENCRYPTED_ENCODE_INFO as _CMSG_ENCRYPTED_ENCODE_INFO
type PCMSG_ENCRYPTED_ENCODE_INFO as _CMSG_ENCRYPTED_ENCODE_INFO ptr
type PFN_CMSG_STREAM_OUTPUT as function(byval pvArg as const any ptr, byval pbData as UBYTE ptr, byval cbData as DWORD, byval fFinal as WINBOOL) as WINBOOL
const CMSG_INDEFINITE_LENGTH = &hffffffff

type _CMSG_STREAM_INFO
	cbContent as DWORD
	pfnStreamOutput as PFN_CMSG_STREAM_OUTPUT
	pvArg as any ptr
end type

type CMSG_STREAM_INFO as _CMSG_STREAM_INFO
type PCMSG_STREAM_INFO as _CMSG_STREAM_INFO ptr
const CMSG_BARE_CONTENT_FLAG = &h1
const CMSG_LENGTH_ONLY_FLAG = &h2
const CMSG_DETACHED_FLAG = &h4
const CMSG_AUTHENTICATED_ATTRIBUTES_FLAG = &h8
const CMSG_CONTENTS_OCTETS_FLAG = &h10
const CMSG_MAX_LENGTH_FLAG = &h20
const CMSG_CMS_ENCAPSULATED_CONTENT_FLAG = &h40
const CMSG_CRYPT_RELEASE_CONTEXT_FLAG = &h8000

declare function CryptMsgOpenToEncode(byval dwMsgEncodingType as DWORD, byval dwFlags as DWORD, byval dwMsgType as DWORD, byval pvMsgEncodeInfo as const any ptr, byval pszInnerContentObjID as LPSTR, byval pStreamInfo as PCMSG_STREAM_INFO) as HCRYPTMSG
declare function CryptMsgCalculateEncodedLength(byval dwMsgEncodingType as DWORD, byval dwFlags as DWORD, byval dwMsgType as DWORD, byval pvMsgEncodeInfo as const any ptr, byval pszInnerContentObjID as LPSTR, byval cbData as DWORD) as DWORD
declare function CryptMsgOpenToDecode(byval dwMsgEncodingType as DWORD, byval dwFlags as DWORD, byval dwMsgType as DWORD, byval hCryptProv as HCRYPTPROV_LEGACY, byval pRecipientInfo as PCERT_INFO, byval pStreamInfo as PCMSG_STREAM_INFO) as HCRYPTMSG
declare function CryptMsgDuplicate(byval hCryptMsg as HCRYPTMSG) as HCRYPTMSG
declare function CryptMsgClose(byval hCryptMsg as HCRYPTMSG) as WINBOOL
declare function CryptMsgUpdate(byval hCryptMsg as HCRYPTMSG, byval pbData as const UBYTE ptr, byval cbData as DWORD, byval fFinal as WINBOOL) as WINBOOL
declare function CryptMsgGetParam(byval hCryptMsg as HCRYPTMSG, byval dwParamType as DWORD, byval dwIndex as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL

const CMSG_TYPE_PARAM = 1
const CMSG_CONTENT_PARAM = 2
const CMSG_BARE_CONTENT_PARAM = 3
const CMSG_INNER_CONTENT_TYPE_PARAM = 4
const CMSG_SIGNER_COUNT_PARAM = 5
const CMSG_SIGNER_INFO_PARAM = 6
const CMSG_SIGNER_CERT_INFO_PARAM = 7
const CMSG_SIGNER_HASH_ALGORITHM_PARAM = 8
const CMSG_SIGNER_AUTH_ATTR_PARAM = 9
const CMSG_SIGNER_UNAUTH_ATTR_PARAM = 10
const CMSG_CERT_COUNT_PARAM = 11
const CMSG_CERT_PARAM = 12
const CMSG_CRL_COUNT_PARAM = 13
const CMSG_CRL_PARAM = 14
const CMSG_ENVELOPE_ALGORITHM_PARAM = 15
const CMSG_RECIPIENT_COUNT_PARAM = 17
const CMSG_RECIPIENT_INDEX_PARAM = 18
const CMSG_RECIPIENT_INFO_PARAM = 19
const CMSG_HASH_ALGORITHM_PARAM = 20
const CMSG_HASH_DATA_PARAM = 21
const CMSG_COMPUTED_HASH_PARAM = 22
const CMSG_ENCRYPT_PARAM = 26
const CMSG_ENCRYPTED_DIGEST = 27
const CMSG_ENCODED_SIGNER = 28
const CMSG_ENCODED_MESSAGE = 29
const CMSG_VERSION_PARAM = 30
const CMSG_ATTR_CERT_COUNT_PARAM = 31
const CMSG_ATTR_CERT_PARAM = 32
const CMSG_CMS_RECIPIENT_COUNT_PARAM = 33
const CMSG_CMS_RECIPIENT_INDEX_PARAM = 34
const CMSG_CMS_RECIPIENT_ENCRYPTED_KEY_INDEX_PARAM = 35
const CMSG_CMS_RECIPIENT_INFO_PARAM = 36
const CMSG_UNPROTECTED_ATTR_PARAM = 37
const CMSG_SIGNER_CERT_ID_PARAM = 38
const CMSG_CMS_SIGNER_INFO_PARAM = 39

type _CMSG_SIGNER_INFO
	dwVersion as DWORD
	Issuer as CERT_NAME_BLOB
	SerialNumber as CRYPT_INTEGER_BLOB
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	HashEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedHash as CRYPT_DATA_BLOB
	AuthAttrs as CRYPT_ATTRIBUTES
	UnauthAttrs as CRYPT_ATTRIBUTES
end type

type CMSG_SIGNER_INFO as _CMSG_SIGNER_INFO
type PCMSG_SIGNER_INFO as _CMSG_SIGNER_INFO ptr

type _CMSG_CMS_SIGNER_INFO
	dwVersion as DWORD
	SignerId as CERT_ID
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	HashEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedHash as CRYPT_DATA_BLOB
	AuthAttrs as CRYPT_ATTRIBUTES
	UnauthAttrs as CRYPT_ATTRIBUTES
end type

type CMSG_CMS_SIGNER_INFO as _CMSG_CMS_SIGNER_INFO
type PCMSG_CMS_SIGNER_INFO as _CMSG_CMS_SIGNER_INFO ptr
type CMSG_ATTR as CRYPT_ATTRIBUTES
type PCMSG_ATTR as CRYPT_ATTRIBUTES ptr

const CMSG_SIGNED_DATA_V1 = 1
const CMSG_SIGNED_DATA_V3 = 3
const CMSG_SIGNED_DATA_PKCS_1_5_VERSION = CMSG_SIGNED_DATA_V1
const CMSG_SIGNED_DATA_CMS_VERSION = CMSG_SIGNED_DATA_V3
const CMSG_SIGNER_INFO_V1 = 1
const CMSG_SIGNER_INFO_V3 = 3
const CMSG_SIGNER_INFO_PKCS_1_5_VERSION = CMSG_SIGNER_INFO_V1
const CMSG_SIGNER_INFO_CMS_VERSION = CMSG_SIGNER_INFO_V3
const CMSG_HASHED_DATA_V0 = 0
const CMSG_HASHED_DATA_V2 = 2
const CMSG_HASHED_DATA_PKCS_1_5_VERSION = CMSG_HASHED_DATA_V0
const CMSG_HASHED_DATA_CMS_VERSION = CMSG_HASHED_DATA_V2
const CMSG_ENVELOPED_DATA_V0 = 0
const CMSG_ENVELOPED_DATA_V2 = 2
const CMSG_ENVELOPED_DATA_PKCS_1_5_VERSION = CMSG_ENVELOPED_DATA_V0
const CMSG_ENVELOPED_DATA_CMS_VERSION = CMSG_ENVELOPED_DATA_V2

type _CMSG_KEY_TRANS_RECIPIENT_INFO
	dwVersion as DWORD
	RecipientId as CERT_ID
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedKey as CRYPT_DATA_BLOB
end type

type CMSG_KEY_TRANS_RECIPIENT_INFO as _CMSG_KEY_TRANS_RECIPIENT_INFO
type PCMSG_KEY_TRANS_RECIPIENT_INFO as _CMSG_KEY_TRANS_RECIPIENT_INFO ptr

type _CMSG_RECIPIENT_ENCRYPTED_KEY_INFO
	RecipientId as CERT_ID
	EncryptedKey as CRYPT_DATA_BLOB
	Date as FILETIME
	pOtherAttr as PCRYPT_ATTRIBUTE_TYPE_VALUE
end type

type CMSG_RECIPIENT_ENCRYPTED_KEY_INFO as _CMSG_RECIPIENT_ENCRYPTED_KEY_INFO
type PCMSG_RECIPIENT_ENCRYPTED_KEY_INFO as _CMSG_RECIPIENT_ENCRYPTED_KEY_INFO ptr

type _CMSG_KEY_AGREE_RECIPIENT_INFO
	dwVersion as DWORD
	dwOriginatorChoice as DWORD

	union
		OriginatorCertId as CERT_ID
		OriginatorPublicKeyInfo as CERT_PUBLIC_KEY_INFO
	end union

	UserKeyingMaterial as CRYPT_DATA_BLOB
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	cRecipientEncryptedKeys as DWORD
	rgpRecipientEncryptedKeys as PCMSG_RECIPIENT_ENCRYPTED_KEY_INFO ptr
end type

type CMSG_KEY_AGREE_RECIPIENT_INFO as _CMSG_KEY_AGREE_RECIPIENT_INFO
type PCMSG_KEY_AGREE_RECIPIENT_INFO as _CMSG_KEY_AGREE_RECIPIENT_INFO ptr
const CMSG_KEY_AGREE_ORIGINATOR_CERT = 1
const CMSG_KEY_AGREE_ORIGINATOR_PUBLIC_KEY = 2

type _CMSG_MAIL_LIST_RECIPIENT_INFO
	dwVersion as DWORD
	KeyId as CRYPT_DATA_BLOB
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedKey as CRYPT_DATA_BLOB
	Date as FILETIME
	pOtherAttr as PCRYPT_ATTRIBUTE_TYPE_VALUE
end type

type CMSG_MAIL_LIST_RECIPIENT_INFO as _CMSG_MAIL_LIST_RECIPIENT_INFO
type PCMSG_MAIL_LIST_RECIPIENT_INFO as _CMSG_MAIL_LIST_RECIPIENT_INFO ptr

type _CMSG_CMS_RECIPIENT_INFO
	dwRecipientChoice as DWORD

	union
		pKeyTrans as PCMSG_KEY_TRANS_RECIPIENT_INFO
		pKeyAgree as PCMSG_KEY_AGREE_RECIPIENT_INFO
		pMailList as PCMSG_MAIL_LIST_RECIPIENT_INFO
	end union
end type

type CMSG_CMS_RECIPIENT_INFO as _CMSG_CMS_RECIPIENT_INFO
type PCMSG_CMS_RECIPIENT_INFO as _CMSG_CMS_RECIPIENT_INFO ptr
const CMSG_ENVELOPED_RECIPIENT_V0 = 0
const CMSG_ENVELOPED_RECIPIENT_V2 = 2
const CMSG_ENVELOPED_RECIPIENT_V3 = 3
const CMSG_ENVELOPED_RECIPIENT_V4 = 4
const CMSG_KEY_TRANS_PKCS_1_5_VERSION = CMSG_ENVELOPED_RECIPIENT_V0
const CMSG_KEY_TRANS_CMS_VERSION = CMSG_ENVELOPED_RECIPIENT_V2
const CMSG_KEY_AGREE_VERSION = CMSG_ENVELOPED_RECIPIENT_V3
const CMSG_MAIL_LIST_VERSION = CMSG_ENVELOPED_RECIPIENT_V4
declare function CryptMsgControl(byval hCryptMsg as HCRYPTMSG, byval dwFlags as DWORD, byval dwCtrlType as DWORD, byval pvCtrlPara as const any ptr) as WINBOOL
const CMSG_CTRL_VERIFY_SIGNATURE = 1
const CMSG_CTRL_DECRYPT = 2
const CMSG_CTRL_VERIFY_HASH = 5
const CMSG_CTRL_ADD_SIGNER = 6
const CMSG_CTRL_DEL_SIGNER = 7
const CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR = 8
const CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR = 9
const CMSG_CTRL_ADD_CERT = 10
const CMSG_CTRL_DEL_CERT = 11
const CMSG_CTRL_ADD_CRL = 12
const CMSG_CTRL_DEL_CRL = 13
const CMSG_CTRL_ADD_ATTR_CERT = 14
const CMSG_CTRL_DEL_ATTR_CERT = 15
const CMSG_CTRL_KEY_TRANS_DECRYPT = 16
const CMSG_CTRL_KEY_AGREE_DECRYPT = 17
const CMSG_CTRL_MAIL_LIST_DECRYPT = 18
const CMSG_CTRL_VERIFY_SIGNATURE_EX = 19
const CMSG_CTRL_ADD_CMS_SIGNER_INFO = 20
const CMSG_CTRL_ENABLE_STRONG_SIGNATURE = 21

type _CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA
	cbSize as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	dwSignerIndex as DWORD
	dwSignerType as DWORD
	pvSigner as any ptr
end type

type CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA as _CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA
type PCMSG_CTRL_VERIFY_SIGNATURE_EX_PARA as _CMSG_CTRL_VERIFY_SIGNATURE_EX_PARA ptr
const CMSG_VERIFY_SIGNER_PUBKEY = 1
const CMSG_VERIFY_SIGNER_CERT = 2
const CMSG_VERIFY_SIGNER_CHAIN = 3
const CMSG_VERIFY_SIGNER_NULL = 4

type _CMSG_CTRL_DECRYPT_PARA
	cbSize as DWORD

	union
		hCryptProv as HCRYPTPROV
		hNCryptKey as NCRYPT_KEY_HANDLE
	end union

	dwKeySpec as DWORD
	dwRecipientIndex as DWORD
end type

type CMSG_CTRL_DECRYPT_PARA as _CMSG_CTRL_DECRYPT_PARA
type PCMSG_CTRL_DECRYPT_PARA as _CMSG_CTRL_DECRYPT_PARA ptr

type _CMSG_CTRL_KEY_TRANS_DECRYPT_PARA
	cbSize as DWORD

	union
		hCryptProv as HCRYPTPROV
		hNCryptKey as NCRYPT_KEY_HANDLE
	end union

	dwKeySpec as DWORD
	pKeyTrans as PCMSG_KEY_TRANS_RECIPIENT_INFO
	dwRecipientIndex as DWORD
end type

type CMSG_CTRL_KEY_TRANS_DECRYPT_PARA as _CMSG_CTRL_KEY_TRANS_DECRYPT_PARA
type PCMSG_CTRL_KEY_TRANS_DECRYPT_PARA as _CMSG_CTRL_KEY_TRANS_DECRYPT_PARA ptr

type _CMSG_CTRL_KEY_AGREE_DECRYPT_PARA
	cbSize as DWORD

	union
		hCryptProv as HCRYPTPROV
		hNCryptKey as NCRYPT_KEY_HANDLE
	end union

	dwKeySpec as DWORD
	pKeyAgree as PCMSG_KEY_AGREE_RECIPIENT_INFO
	dwRecipientIndex as DWORD
	dwRecipientEncryptedKeyIndex as DWORD
	OriginatorPublicKey as CRYPT_BIT_BLOB
end type

type CMSG_CTRL_KEY_AGREE_DECRYPT_PARA as _CMSG_CTRL_KEY_AGREE_DECRYPT_PARA
type PCMSG_CTRL_KEY_AGREE_DECRYPT_PARA as _CMSG_CTRL_KEY_AGREE_DECRYPT_PARA ptr

type _CMSG_CTRL_MAIL_LIST_DECRYPT_PARA
	cbSize as DWORD
	hCryptProv as HCRYPTPROV
	pMailList as PCMSG_MAIL_LIST_RECIPIENT_INFO
	dwRecipientIndex as DWORD
	dwKeyChoice as DWORD

	union
		hKeyEncryptionKey as HCRYPTKEY
		pvKeyEncryptionKey as any ptr
	end union
end type

type CMSG_CTRL_MAIL_LIST_DECRYPT_PARA as _CMSG_CTRL_MAIL_LIST_DECRYPT_PARA
type PCMSG_CTRL_MAIL_LIST_DECRYPT_PARA as _CMSG_CTRL_MAIL_LIST_DECRYPT_PARA ptr

type _CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA
	cbSize as DWORD
	dwSignerIndex as DWORD
	blob as CRYPT_DATA_BLOB
end type

type CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA as _CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA
type PCMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA as _CMSG_CTRL_ADD_SIGNER_UNAUTH_ATTR_PARA ptr

type _CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA
	cbSize as DWORD
	dwSignerIndex as DWORD
	dwUnauthAttrIndex as DWORD
end type

type CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA as _CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA
type PCMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA as _CMSG_CTRL_DEL_SIGNER_UNAUTH_ATTR_PARA ptr
const CMSG_VERIFY_COUNTER_SIGN_ENABLE_STRONG_FLAG = &h1
declare function CryptMsgVerifyCountersignatureEncoded(byval hCryptProv as HCRYPTPROV_LEGACY, byval dwEncodingType as DWORD, byval pbSignerInfo as PBYTE, byval cbSignerInfo as DWORD, byval pbSignerInfoCountersignature as PBYTE, byval cbSignerInfoCountersignature as DWORD, byval pciCountersigner as PCERT_INFO) as WINBOOL
declare function CryptMsgVerifyCountersignatureEncodedEx(byval hCryptProv as HCRYPTPROV_LEGACY, byval dwEncodingType as DWORD, byval pbSignerInfo as PBYTE, byval cbSignerInfo as DWORD, byval pbSignerInfoCountersignature as PBYTE, byval cbSignerInfoCountersignature as DWORD, byval dwSignerType as DWORD, byval pvSigner as any ptr, byval dwFlags as DWORD, byval pvExtra as any ptr) as WINBOOL
declare function CryptMsgCountersign(byval hCryptMsg as HCRYPTMSG, byval dwIndex as DWORD, byval cCountersigners as DWORD, byval rgCountersigners as PCMSG_SIGNER_ENCODE_INFO) as WINBOOL
declare function CryptMsgCountersignEncoded(byval dwEncodingType as DWORD, byval pbSignerInfo as PBYTE, byval cbSignerInfo as DWORD, byval cCountersigners as DWORD, byval rgCountersigners as PCMSG_SIGNER_ENCODE_INFO, byval pbCountersignature as PBYTE, byval pcbCountersignature as PDWORD) as WINBOOL
type PFN_CMSG_ALLOC as function(byval cb as uinteger) as any ptr
type PFN_CMSG_FREE as sub(byval pv as any ptr)

#define CMSG_OID_GEN_ENCRYPT_KEY_FUNC "CryptMsgDllGenEncryptKey"
#define CMSG_OID_EXPORT_ENCRYPT_KEY_FUNC "CryptMsgDllExportEncryptKey"
#define CMSG_OID_IMPORT_ENCRYPT_KEY_FUNC "CryptMsgDllImportEncryptKey"

type PFN_CMSG_GEN_ENCRYPT_KEY as function(byval phCryptProv as HCRYPTPROV ptr, byval paiEncrypt as PCRYPT_ALGORITHM_IDENTIFIER, byval pvEncryptAuxInfo as PVOID, byval pPublicKeyInfo as PCERT_PUBLIC_KEY_INFO, byval pfnAlloc as PFN_CMSG_ALLOC, byval phEncryptKey as HCRYPTKEY ptr, byval ppbEncryptParameters as PBYTE ptr, byval pcbEncryptParameters as PDWORD) as WINBOOL
type PFN_CMSG_EXPORT_ENCRYPT_KEY as function(byval hCryptProv as HCRYPTPROV, byval hEncryptKey as HCRYPTKEY, byval pPublicKeyInfo as PCERT_PUBLIC_KEY_INFO, byval pbData as PBYTE, byval pcbData as PDWORD) as WINBOOL
type PFN_CMSG_IMPORT_ENCRYPT_KEY as function(byval hCryptProv as HCRYPTPROV, byval dwKeySpec as DWORD, byval paiEncrypt as PCRYPT_ALGORITHM_IDENTIFIER, byval paiPubKey as PCRYPT_ALGORITHM_IDENTIFIER, byval pbEncodedKey as PBYTE, byval cbEncodedKey as DWORD, byval phEncryptKey as HCRYPTKEY ptr) as WINBOOL
const CMSG_DEFAULT_INSTALLABLE_FUNC_OID = cast(LPCSTR, 1)

type _CMSG_CONTENT_ENCRYPT_INFO
	cbSize as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	ContentEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvEncryptionAuxInfo as any ptr
	cRecipients as DWORD
	rgCmsRecipients as PCMSG_RECIPIENT_ENCODE_INFO
	pfnAlloc as PFN_CMSG_ALLOC
	pfnFree as PFN_CMSG_FREE
	dwEncryptFlags as DWORD

	union
		hContentEncryptKey as HCRYPTKEY
		hCNGContentEncryptKey as BCRYPT_KEY_HANDLE
	end union

	dwFlags as DWORD
	fCNG as WINBOOL
	pbCNGContentEncryptKeyObject as UBYTE ptr
	pbContentEncryptKey as UBYTE ptr
	cbContentEncryptKey as DWORD
end type

type CMSG_CONTENT_ENCRYPT_INFO as _CMSG_CONTENT_ENCRYPT_INFO
type PCMSG_CONTENT_ENCRYPT_INFO as _CMSG_CONTENT_ENCRYPT_INFO ptr
const CMSG_CONTENT_ENCRYPT_PAD_ENCODED_LEN_FLAG = &h1
const CMSG_CONTENT_ENCRYPT_FREE_PARA_FLAG = &h1
const CMSG_CONTENT_ENCRYPT_FREE_OBJID_FLAG = &h2
const CMSG_CONTENT_ENCRYPT_RELEASE_CONTEXT_FLAG = &h8000
#define CMSG_OID_GEN_CONTENT_ENCRYPT_KEY_FUNC "CryptMsgDllGenContentEncryptKey"
#define CMSG_OID_CAPI1_GEN_CONTENT_ENCRYPT_KEY_FUNC CMSG_OID_GEN_CONTENT_ENCRYPT_KEY_FUNC
#define CMSG_OID_CNG_GEN_CONTENT_ENCRYPT_KEY_FUNC "CryptMsgDllCNGGenContentEncryptKey"
type PFN_CMSG_GEN_CONTENT_ENCRYPT_KEY as function(byval pContentEncryptInfo as PCMSG_CONTENT_ENCRYPT_INFO, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL

type _CMSG_KEY_TRANS_ENCRYPT_INFO
	cbSize as DWORD
	dwRecipientIndex as DWORD
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedKey as CRYPT_DATA_BLOB
	dwFlags as DWORD
end type

type CMSG_KEY_TRANS_ENCRYPT_INFO as _CMSG_KEY_TRANS_ENCRYPT_INFO
type PCMSG_KEY_TRANS_ENCRYPT_INFO as _CMSG_KEY_TRANS_ENCRYPT_INFO ptr
const CMSG_KEY_TRANS_ENCRYPT_FREE_PARA_FLAG = &h1
const CMSG_KEY_TRANS_ENCRYPT_FREE_OBJID_FLAG = &h2
#define CMSG_OID_EXPORT_KEY_TRANS_FUNC "CryptMsgDllExportKeyTrans"
#define CMSG_OID_CAPI1_EXPORT_KEY_TRANS_FUNC CMSG_OID_EXPORT_KEY_TRANS_FUNC
#define CMSG_OID_CNG_EXPORT_KEY_TRANS_FUNC "CryptMsgDllCNGExportKeyTrans"
type PFN_CMSG_EXPORT_KEY_TRANS as function(byval pContentEncryptInfo as PCMSG_CONTENT_ENCRYPT_INFO, byval pKeyTransEncodeInfo as PCMSG_KEY_TRANS_RECIPIENT_ENCODE_INFO, byval pKeyTransEncryptInfo as PCMSG_KEY_TRANS_ENCRYPT_INFO, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL

type _CMSG_KEY_AGREE_KEY_ENCRYPT_INFO
	cbSize as DWORD
	EncryptedKey as CRYPT_DATA_BLOB
end type

type CMSG_KEY_AGREE_KEY_ENCRYPT_INFO as _CMSG_KEY_AGREE_KEY_ENCRYPT_INFO
type PCMSG_KEY_AGREE_KEY_ENCRYPT_INFO as _CMSG_KEY_AGREE_KEY_ENCRYPT_INFO ptr

type _CMSG_KEY_AGREE_ENCRYPT_INFO
	cbSize as DWORD
	dwRecipientIndex as DWORD
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	UserKeyingMaterial as CRYPT_DATA_BLOB
	dwOriginatorChoice as DWORD

	union
		OriginatorCertId as CERT_ID
		OriginatorPublicKeyInfo as CERT_PUBLIC_KEY_INFO
	end union

	cKeyAgreeKeyEncryptInfo as DWORD
	rgpKeyAgreeKeyEncryptInfo as PCMSG_KEY_AGREE_KEY_ENCRYPT_INFO ptr
	dwFlags as DWORD
end type

type CMSG_KEY_AGREE_ENCRYPT_INFO as _CMSG_KEY_AGREE_ENCRYPT_INFO
type PCMSG_KEY_AGREE_ENCRYPT_INFO as _CMSG_KEY_AGREE_ENCRYPT_INFO ptr
const CMSG_KEY_AGREE_ENCRYPT_FREE_PARA_FLAG = &h1
const CMSG_KEY_AGREE_ENCRYPT_FREE_MATERIAL_FLAG = &h2
const CMSG_KEY_AGREE_ENCRYPT_FREE_PUBKEY_ALG_FLAG = &h4
const CMSG_KEY_AGREE_ENCRYPT_FREE_PUBKEY_PARA_FLAG = &h8
const CMSG_KEY_AGREE_ENCRYPT_FREE_PUBKEY_BITS_FLAG = &h10
const CMSG_KEY_AGREE_ENCRYPT_FREE_OBJID_FLAG = &h20
#define CMSG_OID_EXPORT_KEY_AGREE_FUNC "CryptMsgDllExportKeyAgree"
#define CMSG_OID_CAPI1_EXPORT_KEY_AGREE_FUNC CMSG_OID_EXPORT_KEY_AGREE_FUNC
#define CMSG_OID_CNG_EXPORT_KEY_AGREE_FUNC "CryptMsgDllCNGExportKeyAgree"
type PFN_CMSG_EXPORT_KEY_AGREE as function(byval pContentEncryptInfo as PCMSG_CONTENT_ENCRYPT_INFO, byval pKeyAgreeEncodeInfo as PCMSG_KEY_AGREE_RECIPIENT_ENCODE_INFO, byval pKeyAgreeEncryptInfo as PCMSG_KEY_AGREE_ENCRYPT_INFO, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL

type _CMSG_MAIL_LIST_ENCRYPT_INFO
	cbSize as DWORD
	dwRecipientIndex as DWORD
	KeyEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	EncryptedKey as CRYPT_DATA_BLOB
	dwFlags as DWORD
end type

type CMSG_MAIL_LIST_ENCRYPT_INFO as _CMSG_MAIL_LIST_ENCRYPT_INFO
type PCMSG_MAIL_LIST_ENCRYPT_INFO as _CMSG_MAIL_LIST_ENCRYPT_INFO ptr
const CMSG_MAIL_LIST_ENCRYPT_FREE_PARA_FLAG = &h1
const CMSG_MAIL_LIST_ENCRYPT_FREE_OBJID_FLAG = &h2
#define CMSG_OID_EXPORT_MAIL_LIST_FUNC "CryptMsgDllExportMailList"
#define CMSG_OID_CAPI1_EXPORT_MAIL_LIST_FUNC CMSG_OID_EXPORT_MAIL_LIST_FUNC
#define CMSG_OID_IMPORT_KEY_TRANS_FUNC "CryptMsgDllImportKeyTrans"
#define CMSG_OID_CAPI1_IMPORT_KEY_TRANS_FUNC CMSG_OID_IMPORT_KEY_TRANS_FUNC
#define CMSG_OID_IMPORT_KEY_AGREE_FUNC "CryptMsgDllImportKeyAgree"
#define CMSG_OID_CAPI1_IMPORT_KEY_AGREE_FUNC CMSG_OID_IMPORT_KEY_AGREE_FUNC
#define CMSG_OID_IMPORT_MAIL_LIST_FUNC "CryptMsgDllImportMailList"
#define CMSG_OID_CAPI1_IMPORT_MAIL_LIST_FUNC CMSG_OID_IMPORT_MAIL_LIST_FUNC

type PFN_CMSG_EXPORT_MAIL_LIST as function(byval pContentEncryptInfo as PCMSG_CONTENT_ENCRYPT_INFO, byval pMailListEncodeInfo as PCMSG_MAIL_LIST_RECIPIENT_ENCODE_INFO, byval pMailListEncryptInfo as PCMSG_MAIL_LIST_ENCRYPT_INFO, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
type PFN_CMSG_IMPORT_KEY_TRANS as function(byval pContentEncryptionAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pKeyTransDecryptPara as PCMSG_CTRL_KEY_TRANS_DECRYPT_PARA, byval dwFlags as DWORD, byval pvReserved as any ptr, byval phContentEncryptKey as HCRYPTKEY ptr) as WINBOOL
type PFN_CMSG_IMPORT_KEY_AGREE as function(byval pContentEncryptionAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pKeyAgreeDecryptPara as PCMSG_CTRL_KEY_AGREE_DECRYPT_PARA, byval dwFlags as DWORD, byval pvReserved as any ptr, byval phContentEncryptKey as HCRYPTKEY ptr) as WINBOOL
type PFN_CMSG_IMPORT_MAIL_LIST as function(byval pContentEncryptionAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pMailListDecryptPara as PCMSG_CTRL_MAIL_LIST_DECRYPT_PARA, byval dwFlags as DWORD, byval pvReserved as any ptr, byval phContentEncryptKey as HCRYPTKEY ptr) as WINBOOL

type _CMSG_CNG_CONTENT_DECRYPT_INFO
	cbSize as DWORD
	ContentEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pfnAlloc as PFN_CMSG_ALLOC
	pfnFree as PFN_CMSG_FREE
	hNCryptKey as NCRYPT_KEY_HANDLE
	pbContentEncryptKey as UBYTE ptr
	cbContentEncryptKey as DWORD
	hCNGContentEncryptKey as BCRYPT_KEY_HANDLE
	pbCNGContentEncryptKeyObject as UBYTE ptr
end type

type CMSG_CNG_CONTENT_DECRYPT_INFO as _CMSG_CNG_CONTENT_DECRYPT_INFO
type PCMSG_CNG_CONTENT_DECRYPT_INFO as _CMSG_CNG_CONTENT_DECRYPT_INFO ptr
#define CMSG_OID_CNG_IMPORT_KEY_TRANS_FUNC "CryptMsgDllCNGImportKeyTrans"
#define CMSG_OID_CNG_IMPORT_KEY_AGREE_FUNC "CryptMsgDllCNGImportKeyAgree"
#define CMSG_OID_CNG_IMPORT_CONTENT_ENCRYPT_KEY_FUNC "CryptMsgDllCNGImportContentEncryptKey"

type PFN_CMSG_CNG_IMPORT_KEY_TRANS as function(byval pCNGContentDecryptInfo as PCMSG_CNG_CONTENT_DECRYPT_INFO, byval pKeyTransDecryptPara as PCMSG_CTRL_KEY_TRANS_DECRYPT_PARA, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
type PFN_CMSG_CNG_IMPORT_KEY_AGREE as function(byval pCNGContentDecryptInfo as PCMSG_CNG_CONTENT_DECRYPT_INFO, byval pKeyAgreeDecryptPara as PCMSG_CTRL_KEY_AGREE_DECRYPT_PARA, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
type PFN_CMSG_CNG_IMPORT_CONTENT_ENCRYPT_KEY as function(byval pCNGContentDecryptInfo as PCMSG_CNG_CONTENT_DECRYPT_INFO, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
type HCERTSTORE as any ptr

type _CERT_CONTEXT
	dwCertEncodingType as DWORD
	pbCertEncoded as UBYTE ptr
	cbCertEncoded as DWORD
	pCertInfo as PCERT_INFO
	hCertStore as HCERTSTORE
end type

type CERT_CONTEXT as _CERT_CONTEXT
type PCERT_CONTEXT as _CERT_CONTEXT ptr
type PCCERT_CONTEXT as const CERT_CONTEXT ptr

type _CRL_CONTEXT
	dwCertEncodingType as DWORD
	pbCrlEncoded as UBYTE ptr
	cbCrlEncoded as DWORD
	pCrlInfo as PCRL_INFO
	hCertStore as HCERTSTORE
end type

type CRL_CONTEXT as _CRL_CONTEXT
type PCRL_CONTEXT as _CRL_CONTEXT ptr
type PCCRL_CONTEXT as const CRL_CONTEXT ptr

type _CTL_CONTEXT
	dwMsgAndCertEncodingType as DWORD
	pbCtlEncoded as UBYTE ptr
	cbCtlEncoded as DWORD
	pCtlInfo as PCTL_INFO
	hCertStore as HCERTSTORE
	hCryptMsg as HCRYPTMSG
	pbCtlContent as UBYTE ptr
	cbCtlContent as DWORD
end type

type CTL_CONTEXT as _CTL_CONTEXT
type PCTL_CONTEXT as _CTL_CONTEXT ptr
type PCCTL_CONTEXT as const CTL_CONTEXT ptr

const CERT_KEY_PROV_HANDLE_PROP_ID = 1
const CERT_KEY_PROV_INFO_PROP_ID = 2
const CERT_SHA1_HASH_PROP_ID = 3
const CERT_MD5_HASH_PROP_ID = 4
const CERT_HASH_PROP_ID = CERT_SHA1_HASH_PROP_ID
const CERT_KEY_CONTEXT_PROP_ID = 5
const CERT_KEY_SPEC_PROP_ID = 6
const CERT_IE30_RESERVED_PROP_ID = 7
const CERT_PUBKEY_HASH_RESERVED_PROP_ID = 8
const CERT_ENHKEY_USAGE_PROP_ID = 9
const CERT_CTL_USAGE_PROP_ID = CERT_ENHKEY_USAGE_PROP_ID
const CERT_NEXT_UPDATE_LOCATION_PROP_ID = 10
const CERT_FRIENDLY_NAME_PROP_ID = 11
const CERT_PVK_FILE_PROP_ID = 12
const CERT_DESCRIPTION_PROP_ID = 13
const CERT_ACCESS_STATE_PROP_ID = 14
const CERT_SIGNATURE_HASH_PROP_ID = 15
const CERT_SMART_CARD_DATA_PROP_ID = 16
const CERT_EFS_PROP_ID = 17
const CERT_FORTEZZA_DATA_PROP_ID = 18
const CERT_ARCHIVED_PROP_ID = 19
const CERT_KEY_IDENTIFIER_PROP_ID = 20
const CERT_AUTO_ENROLL_PROP_ID = 21
const CERT_PUBKEY_ALG_PARA_PROP_ID = 22
const CERT_CROSS_CERT_DIST_POINTS_PROP_ID = 23
const CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID = 24
const CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID = 25
const CERT_ENROLLMENT_PROP_ID = 26
const CERT_DATE_STAMP_PROP_ID = 27
const CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID = 28
const CERT_SUBJECT_NAME_MD5_HASH_PROP_ID = 29
const CERT_EXTENDED_ERROR_INFO_PROP_ID = 30
const CERT_RENEWAL_PROP_ID = 64
const CERT_ARCHIVED_KEY_HASH_PROP_ID = 65
const CERT_AUTO_ENROLL_RETRY_PROP_ID = 66
const CERT_AIA_URL_RETRIEVED_PROP_ID = 67
const CERT_AUTHORITY_INFO_ACCESS_PROP_ID = 68
const CERT_BACKED_UP_PROP_ID = 69
const CERT_OCSP_RESPONSE_PROP_ID = 70
const CERT_REQUEST_ORIGINATOR_PROP_ID = 71
const CERT_SOURCE_LOCATION_PROP_ID = 72
const CERT_SOURCE_URL_PROP_ID = 73
const CERT_NEW_KEY_PROP_ID = 74
const CERT_OCSP_CACHE_PREFIX_PROP_ID = 75
const CERT_SMART_CARD_ROOT_INFO_PROP_ID = 76
const CERT_NO_AUTO_EXPIRE_CHECK_PROP_ID = 77
const CERT_NCRYPT_KEY_HANDLE_PROP_ID = 78
const CERT_HCRYPTPROV_OR_NCRYPT_KEY_HANDLE_PROP_ID = 79
const CERT_SUBJECT_INFO_ACCESS_PROP_ID = 80
const CERT_CA_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID = 81
const CERT_CA_DISABLE_CRL_PROP_ID = 82
const CERT_ROOT_PROGRAM_CERT_POLICIES_PROP_ID = 83
const CERT_ROOT_PROGRAM_NAME_CONSTRAINTS_PROP_ID = 84
const CERT_SUBJECT_OCSP_AUTHORITY_INFO_ACCESS_PROP_ID = 85
const CERT_SUBJECT_DISABLE_CRL_PROP_ID = 86
const CERT_CEP_PROP_ID = 87
const CERT_SIGN_HASH_CNG_ALG_PROP_ID = 89
const CERT_SCARD_PIN_ID_PROP_ID = 90
const CERT_SCARD_PIN_INFO_PROP_ID = 91
const CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID = 92
const CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 93
const CERT_ISSUER_PUB_KEY_BIT_LENGTH_PROP_ID = 94
const CERT_ISSUER_CHAIN_SIGN_HASH_CNG_ALG_PROP_ID = 95
const CERT_ISSUER_CHAIN_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = 96
const CERT_NO_EXPIRE_NOTIFICATION_PROP_ID = 97
const CERT_AUTH_ROOT_SHA256_HASH_PROP_ID = 98
const CERT_NCRYPT_KEY_HANDLE_TRANSFER_PROP_ID = 99
const CERT_HCRYPTPROV_TRANSFER_PROP_ID = 100
const CERT_SMART_CARD_READER_PROP_ID = 101
const CERT_SEND_AS_TRUSTED_ISSUER_PROP_ID = 102
const CERT_KEY_REPAIR_ATTEMPTED_PROP_ID = 103
const CERT_DISALLOWED_FILETIME_PROP_ID = 104
const CERT_ROOT_PROGRAM_CHAIN_POLICIES_PROP_ID = 105
const CERT_SMART_CARD_READER_NON_REMOVABLE_PROP_ID = 106
const CERT_FIRST_RESERVED_PROP_ID = 107
const CERT_LAST_RESERVED_PROP_ID = &h00007fff
const CERT_FIRST_USER_PROP_ID = &h8000
const CERT_LAST_USER_PROP_ID = &h0000ffff
#define IS_CERT_HASH_PROP_ID(X) (((CERT_SHA1_HASH_PROP_ID = (X)) orelse (CERT_MD5_HASH_PROP_ID = (X))) orelse (CERT_SIGNATURE_HASH_PROP_ID = (X)))
#define IS_PUBKEY_HASH_PROP_ID(X) ((CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID = (X)) orelse (CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID = (X)))
#define IS_CHAIN_HASH_PROP_ID(X) ((((CERT_ISSUER_PUBLIC_KEY_MD5_HASH_PROP_ID = (X)) orelse (CERT_SUBJECT_PUBLIC_KEY_MD5_HASH_PROP_ID = (X))) orelse (CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID = (X))) orelse (CERT_SUBJECT_NAME_MD5_HASH_PROP_ID = (X)))
#define IS_STRONG_SIGN_PROP_ID(X) (((CERT_SIGN_HASH_CNG_ALG_PROP_ID = (X)) orelse (CERT_SUBJECT_PUB_KEY_BIT_LENGTH_PROP_ID = (X))) orelse (CERT_PUB_KEY_CNG_ALG_BIT_LENGTH_PROP_ID = (X)))
#define szOID_CERT_PROP_ID_PREFIX "1.3.6.1.4.1.311.10.11."
#define _szPROP_ID(PropId) #PropId
#define szOID_CERT_PROP_ID(PropId) szOID_CERT_PROP_ID_PREFIX _szPROP_ID(PropId)
#define __CRYPT32WTEXT(quote) wstr(quote)
#define _CRYPT32WTEXT(quote) __CRYPT32WTEXT(quote)
#define wszOID_CERT_PROP_ID(PropId) (_CRYPT32WTEXT(szOID_CERT_PROP_ID_PREFIX) + _CRYPT32WTEXT(_szPROP_ID(PropId)))
#define szOID_CERT_KEY_IDENTIFIER_PROP_ID "1.3.6.1.4.1.311.10.11.20"
#define szOID_CERT_ISSUER_SERIAL_NUMBER_MD5_HASH_PROP_ID "1.3.6.1.4.1.311.10.11.28"
#define szOID_CERT_SUBJECT_NAME_MD5_HASH_PROP_ID "1.3.6.1.4.1.311.10.11.29"
#define szOID_CERT_MD5_HASH_PROP_ID "1.3.6.1.4.1.311.10.11.4"
#define szOID_CERT_SIGNATURE_HASH_PROP_ID "1.3.6.1.4.1.311.10.11.15"
#define szOID_DISALLOWED_HASH szOID_CERT_SIGNATURE_HASH_PROP_ID
#define szOID_CERT_DISALLOWED_FILETIME_PROP_ID "1.3.6.1.4.1.311.10.11.104"
const CERT_ACCESS_STATE_WRITE_PERSIST_FLAG = &h1
const CERT_ACCESS_STATE_SYSTEM_STORE_FLAG = &h2
const CERT_ACCESS_STATE_LM_SYSTEM_STORE_FLAG = &h4
const CERT_ACCESS_STATE_GP_SYSTEM_STORE_FLAG = &h8
const CERT_ACCESS_STATE_SHARED_USER_FLAG = &h10
#define szOID_ROOT_PROGRAM_AUTO_UPDATE_CA_REVOCATION "1.3.6.1.4.1.311.60.3.1"
#define szOID_ROOT_PROGRAM_AUTO_UPDATE_END_REVOCATION "1.3.6.1.4.1.311.60.3.2"
#define szOID_ROOT_PROGRAM_NO_OCSP_FAILOVER_TO_CRL "1.3.6.1.4.1.311.60.3.3"

type _CRYPT_KEY_PROV_PARAM
	dwParam as DWORD
	pbData as UBYTE ptr
	cbData as DWORD
	dwFlags as DWORD
end type

type CRYPT_KEY_PROV_PARAM as _CRYPT_KEY_PROV_PARAM
type PCRYPT_KEY_PROV_PARAM as _CRYPT_KEY_PROV_PARAM ptr

type _CRYPT_KEY_PROV_INFO
	pwszContainerName as LPWSTR
	pwszProvName as LPWSTR
	dwProvType as DWORD
	dwFlags as DWORD
	cProvParam as DWORD
	rgProvParam as PCRYPT_KEY_PROV_PARAM
	dwKeySpec as DWORD
end type

type CRYPT_KEY_PROV_INFO as _CRYPT_KEY_PROV_INFO
type PCRYPT_KEY_PROV_INFO as _CRYPT_KEY_PROV_INFO ptr
const CERT_SET_KEY_PROV_HANDLE_PROP_ID = &h1
const CERT_SET_KEY_CONTEXT_PROP_ID = &h1
const CERT_NCRYPT_KEY_SPEC = &hffffffff

type _CERT_KEY_CONTEXT
	cbSize as DWORD

	union
		hCryptProv as HCRYPTPROV
		hNCryptKey as NCRYPT_KEY_HANDLE
	end union

	dwKeySpec as DWORD
end type

type CERT_KEY_CONTEXT as _CERT_KEY_CONTEXT
type PCERT_KEY_CONTEXT as _CERT_KEY_CONTEXT ptr

type _ROOT_INFO_LUID
	LowPart as DWORD
	HighPart as LONG
end type

type ROOT_INFO_LUID as _ROOT_INFO_LUID
type PROOT_INFO_LUID as _ROOT_INFO_LUID ptr

type _CRYPT_SMART_CARD_ROOT_INFO
	rgbCardID(0 to 15) as UBYTE
	luid as ROOT_INFO_LUID
end type

type CRYPT_SMART_CARD_ROOT_INFO as _CRYPT_SMART_CARD_ROOT_INFO
type PCRYPT_SMART_CARD_ROOT_INFO as _CRYPT_SMART_CARD_ROOT_INFO ptr
const CERT_STORE_PROV_MSG = cast(LPCSTR, 1)
const CERT_STORE_PROV_MEMORY = cast(LPCSTR, 2)
const CERT_STORE_PROV_FILE = cast(LPCSTR, 3)
const CERT_STORE_PROV_REG = cast(LPCSTR, 4)
const CERT_STORE_PROV_PKCS7 = cast(LPCSTR, 5)
const CERT_STORE_PROV_SERIALIZED = cast(LPCSTR, 6)
const CERT_STORE_PROV_FILENAME_A = cast(LPCSTR, 7)
const CERT_STORE_PROV_FILENAME_W = cast(LPCSTR, 8)
const CERT_STORE_PROV_FILENAME = CERT_STORE_PROV_FILENAME_W
const CERT_STORE_PROV_SYSTEM_A = cast(LPCSTR, 9)
const CERT_STORE_PROV_SYSTEM_W = cast(LPCSTR, 10)
const CERT_STORE_PROV_SYSTEM = CERT_STORE_PROV_SYSTEM_W
const CERT_STORE_PROV_COLLECTION = cast(LPCSTR, 11)
const CERT_STORE_PROV_SYSTEM_REGISTRY_A = cast(LPCSTR, 12)
const CERT_STORE_PROV_SYSTEM_REGISTRY_W = cast(LPCSTR, 13)
const CERT_STORE_PROV_SYSTEM_REGISTRY = CERT_STORE_PROV_SYSTEM_REGISTRY_W
const CERT_STORE_PROV_PHYSICAL_W = cast(LPCSTR, 14)
const CERT_STORE_PROV_PHYSICAL = CERT_STORE_PROV_PHYSICAL_W
const CERT_STORE_PROV_SMART_CARD_W = cast(LPCSTR, 15)
const CERT_STORE_PROV_SMART_CARD = CERT_STORE_PROV_SMART_CARD_W
const CERT_STORE_PROV_LDAP_W = cast(LPCSTR, 16)
const CERT_STORE_PROV_LDAP = CERT_STORE_PROV_LDAP_W
const CERT_STORE_PROV_PKCS12 = cast(LPCSTR, 17)
#define sz_CERT_STORE_PROV_MEMORY "Memory"
#define sz_CERT_STORE_PROV_FILENAME_W "File"
#define sz_CERT_STORE_PROV_FILENAME sz_CERT_STORE_PROV_FILENAME_W
#define sz_CERT_STORE_PROV_SYSTEM_W "System"
#define sz_CERT_STORE_PROV_SYSTEM sz_CERT_STORE_PROV_SYSTEM_W
#define sz_CERT_STORE_PROV_PKCS7 "PKCS7"
#define sz_CERT_STORE_PROV_PKCS12 "PKCS12"
#define sz_CERT_STORE_PROV_SERIALIZED "Serialized"
#define sz_CERT_STORE_PROV_COLLECTION "Collection"
#define sz_CERT_STORE_PROV_SYSTEM_REGISTRY_W "SystemRegistry"
#define sz_CERT_STORE_PROV_SYSTEM_REGISTRY sz_CERT_STORE_PROV_SYSTEM_REGISTRY_W
#define sz_CERT_STORE_PROV_PHYSICAL_W "Physical"
#define sz_CERT_STORE_PROV_PHYSICAL sz_CERT_STORE_PROV_PHYSICAL_W
#define sz_CERT_STORE_PROV_SMART_CARD_W "SmartCard"
#define sz_CERT_STORE_PROV_SMART_CARD sz_CERT_STORE_PROV_SMART_CARD_W
#define sz_CERT_STORE_PROV_LDAP_W "Ldap"
#define sz_CERT_STORE_PROV_LDAP sz_CERT_STORE_PROV_LDAP_W
const CERT_STORE_SIGNATURE_FLAG = &h1
const CERT_STORE_TIME_VALIDITY_FLAG = &h2
const CERT_STORE_REVOCATION_FLAG = &h4
const CERT_STORE_NO_CRL_FLAG = &h10000
const CERT_STORE_NO_ISSUER_FLAG = &h20000
const CERT_STORE_BASE_CRL_FLAG = &h100
const CERT_STORE_DELTA_CRL_FLAG = &h200
const CERT_STORE_NO_CRYPT_RELEASE_FLAG = &h1
const CERT_STORE_SET_LOCALIZED_NAME_FLAG = &h2
const CERT_STORE_DEFER_CLOSE_UNTIL_LAST_FREE_FLAG = &h4
const CERT_STORE_DELETE_FLAG = &h10
const CERT_STORE_UNSAFE_PHYSICAL_FLAG = &h20
const CERT_STORE_SHARE_STORE_FLAG = &h40
const CERT_STORE_SHARE_CONTEXT_FLAG = &h80
const CERT_STORE_MANIFOLD_FLAG = &h100
const CERT_STORE_ENUM_ARCHIVED_FLAG = &h200
const CERT_STORE_UPDATE_KEYID_FLAG = &h400
const CERT_STORE_BACKUP_RESTORE_FLAG = &h800
const CERT_STORE_READONLY_FLAG = &h8000
const CERT_STORE_OPEN_EXISTING_FLAG = &h4000
const CERT_STORE_CREATE_NEW_FLAG = &h2000
const CERT_STORE_MAXIMUM_ALLOWED_FLAG = &h1000
const CERT_SYSTEM_STORE_MASK = &hffff0000
const CERT_SYSTEM_STORE_RELOCATE_FLAG = &h80000000

type _CERT_SYSTEM_STORE_RELOCATE_PARA
	union
		hKeyBase as HKEY
		pvBase as any ptr
	end union

	union
		pvSystemStore as any ptr
		pszSystemStore as LPCSTR
		pwszSystemStore as LPCWSTR
	end union
end type

type CERT_SYSTEM_STORE_RELOCATE_PARA as _CERT_SYSTEM_STORE_RELOCATE_PARA
type PCERT_SYSTEM_STORE_RELOCATE_PARA as _CERT_SYSTEM_STORE_RELOCATE_PARA ptr
const CERT_SYSTEM_STORE_DEFER_READ_FLAG = &h20000000
const CERT_SYSTEM_STORE_UNPROTECTED_FLAG = &h40000000
const CERT_SYSTEM_STORE_LOCATION_MASK = &h00ff0000
const CERT_SYSTEM_STORE_LOCATION_SHIFT = 16
const CERT_SYSTEM_STORE_CURRENT_USER_ID = 1
const CERT_SYSTEM_STORE_LOCAL_MACHINE_ID = 2
const CERT_SYSTEM_STORE_CURRENT_SERVICE_ID = 4
const CERT_SYSTEM_STORE_SERVICES_ID = 5
const CERT_SYSTEM_STORE_USERS_ID = 6
const CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY_ID = 7
const CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY_ID = 8
const CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE_ID = 9
const CERT_SYSTEM_STORE_CURRENT_USER = CERT_SYSTEM_STORE_CURRENT_USER_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_LOCAL_MACHINE = CERT_SYSTEM_STORE_LOCAL_MACHINE_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_CURRENT_SERVICE = CERT_SYSTEM_STORE_CURRENT_SERVICE_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_SERVICES = CERT_SYSTEM_STORE_SERVICES_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_USERS = CERT_SYSTEM_STORE_USERS_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY = CERT_SYSTEM_STORE_CURRENT_USER_GROUP_POLICY_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY = CERT_SYSTEM_STORE_LOCAL_MACHINE_GROUP_POLICY_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
const CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE = CERT_SYSTEM_STORE_LOCAL_MACHINE_ENTERPRISE_ID shl CERT_SYSTEM_STORE_LOCATION_SHIFT
#define CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH wstr(!"Software\\Policies\\Microsoft\\SystemCertificates")
#define CERT_EFSBLOB_REGPATH CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH wstr(!"\\EFS")
#define CERT_EFSBLOB_VALUE_NAME wstr("EFSBlob")
#define CERT_PROT_ROOT_FLAGS_REGPATH CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH wstr(!"\\Root\\ProtectedRoots")
#define CERT_PROT_ROOT_FLAGS_VALUE_NAME wstr("Flags")
const CERT_PROT_ROOT_DISABLE_CURRENT_USER_FLAG = &h1
const CERT_PROT_ROOT_INHIBIT_ADD_AT_INIT_FLAG = &h2
const CERT_PROT_ROOT_INHIBIT_PURGE_LM_FLAG = &h4
const CERT_PROT_ROOT_DISABLE_LM_AUTH_FLAG = &h8
const CERT_PROT_ROOT_ONLY_LM_GPT_FLAG = &h8
const CERT_PROT_ROOT_DISABLE_NT_AUTH_REQUIRED_FLAG = &h10
const CERT_PROT_ROOT_DISABLE_NOT_DEFINED_NAME_CONSTRAINT_FLAG = &h20
const CERT_PROT_ROOT_DISABLE_PEER_TRUST = &h10000
#define CERT_PROT_ROOT_PEER_USAGES_VALUE_NAME wstr("PeerUsages")
#define CERT_PROT_ROOT_PEER_USAGES_VALUE_NAME_A "PeerUsages"
#define CERT_PROT_ROOT_PEER_USAGES_DEFAULT_A szOID_PKIX_KP_CLIENT_AUTH !"\0" szOID_PKIX_KP_EMAIL_PROTECTION !"\0" szOID_KP_EFS !"\0"
#define CERT_TRUST_PUB_SAFER_GROUP_POLICY_REGPATH CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH wstr(!"\\TrustedPublisher\\Safer")
#define CERT_LOCAL_MACHINE_SYSTEM_STORE_REGPATH wstr(!"Software\\Microsoft\\SystemCertificates")
#define CERT_TRUST_PUB_SAFER_LOCAL_MACHINE_REGPATH CERT_LOCAL_MACHINE_SYSTEM_STORE_REGPATH wstr(!"\\TrustedPublisher\\Safer")
#define CERT_TRUST_PUB_AUTHENTICODE_FLAGS_VALUE_NAME wstr("AuthenticodeFlags")
const CERT_TRUST_PUB_ALLOW_TRUST_MASK = &h3
const CERT_TRUST_PUB_ALLOW_END_USER_TRUST = &h0
const CERT_TRUST_PUB_ALLOW_MACHINE_ADMIN_TRUST = &h1
const CERT_TRUST_PUB_ALLOW_ENTERPRISE_ADMIN_TRUST = &h2
const CERT_TRUST_PUB_CHECK_PUBLISHER_REV_FLAG = &h100
const CERT_TRUST_PUB_CHECK_TIMESTAMP_REV_FLAG = &h200
#define CERT_OCM_SUBCOMPONENTS_LOCAL_MACHINE_REGPATH wstr(!"SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Setup\\OC Manager\\Subcomponents")
#define CERT_OCM_SUBCOMPONENTS_ROOT_AUTO_UPDATE_VALUE_NAME wstr("RootAutoUpdate")
#define CERT_DISABLE_ROOT_AUTO_UPDATE_REGPATH CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH wstr(!"\\AuthRoot")
#define CERT_DISABLE_ROOT_AUTO_UPDATE_VALUE_NAME wstr("DisableRootAutoUpdate")
#define CERT_AUTO_UPDATE_LOCAL_MACHINE_REGPATH CERT_LOCAL_MACHINE_SYSTEM_STORE_REGPATH wstr(!"\\AuthRoot\\AutoUpdate")
#define CERT_AUTO_UPDATE_ROOT_DIR_URL_VALUE_NAME wstr("RootDirUrl")
#define CERT_AUTH_ROOT_AUTO_UPDATE_LOCAL_MACHINE_REGPATH CERT_AUTO_UPDATE_LOCAL_MACHINE_REGPATH
#define CERT_AUTH_ROOT_AUTO_UPDATE_ROOT_DIR_URL_VALUE_NAME CERT_AUTO_UPDATE_ROOT_DIR_URL_VALUE_NAME
#define CERT_AUTH_ROOT_AUTO_UPDATE_SYNC_DELTA_TIME_VALUE_NAME wstr("SyncDeltaTime")
#define CERT_AUTH_ROOT_AUTO_UPDATE_FLAGS_VALUE_NAME wstr("Flags")
const CERT_AUTH_ROOT_AUTO_UPDATE_DISABLE_UNTRUSTED_ROOT_LOGGING_FLAG = &h1
const CERT_AUTH_ROOT_AUTO_UPDATE_DISABLE_PARTIAL_CHAIN_LOGGING_FLAG = &h2
const CERT_AUTO_UPDATE_DISABLE_RANDOM_QUERY_STRING_FLAG = &h4
#define CERT_AUTH_ROOT_AUTO_UPDATE_LAST_SYNC_TIME_VALUE_NAME wstr("LastSyncTime")
#define CERT_AUTH_ROOT_AUTO_UPDATE_ENCODED_CTL_VALUE_NAME wstr("EncodedCtl")
#define CERT_AUTH_ROOT_CTL_FILENAME wstr("authroot.stl")
#define CERT_AUTH_ROOT_CTL_FILENAME_A "authroot.stl"
#define CERT_AUTH_ROOT_CAB_FILENAME wstr("authrootstl.cab")
#define CERT_AUTH_ROOT_SEQ_FILENAME wstr("authrootseq.txt")
#define CERT_AUTH_ROOT_CERT_EXT wstr(".crt")
#define CERT_DISALLOWED_CERT_AUTO_UPDATE_SYNC_DELTA_TIME_VALUE_NAME wstr("DisallowedCertSyncDeltaTime")
#define CERT_DISALLOWED_CERT_AUTO_UPDATE_LAST_SYNC_TIME_VALUE_NAME wstr("DisallowedCertLastSyncTime")
#define CERT_DISALLOWED_CERT_AUTO_UPDATE_ENCODED_CTL_VALUE_NAME wstr("DisallowedCertEncodedCtl")
#define CERT_DISALLOWED_CERT_CTL_FILENAME wstr("disallowedcert.stl")
#define CERT_DISALLOWED_CERT_CTL_FILENAME_A "disallowedcert.stl"
#define CERT_DISALLOWED_CERT_CAB_FILENAME wstr("disallowedcertstl.cab")
#define CERT_DISALLOWED_CERT_AUTO_UPDATE_LIST_IDENTIFIER wstr("DisallowedCert_AutoUpdate_1")
const CERT_REGISTRY_STORE_REMOTE_FLAG = &h10000
const CERT_REGISTRY_STORE_SERIALIZED_FLAG = &h20000
const CERT_REGISTRY_STORE_CLIENT_GPT_FLAG = &h80000000
const CERT_REGISTRY_STORE_LM_GPT_FLAG = &h1000000

type _CERT_REGISTRY_STORE_CLIENT_GPT_PARA
	hKeyBase as HKEY
	pwszRegPath as LPWSTR
end type

type CERT_REGISTRY_STORE_CLIENT_GPT_PARA as _CERT_REGISTRY_STORE_CLIENT_GPT_PARA
type PCERT_REGISTRY_STORE_CLIENT_GPT_PARA as _CERT_REGISTRY_STORE_CLIENT_GPT_PARA ptr
const CERT_REGISTRY_STORE_ROAMING_FLAG = &h40000

type _CERT_REGISTRY_STORE_ROAMING_PARA
	hKey as HKEY
	pwszStoreDirectory as LPWSTR
end type

type CERT_REGISTRY_STORE_ROAMING_PARA as _CERT_REGISTRY_STORE_ROAMING_PARA
type PCERT_REGISTRY_STORE_ROAMING_PARA as _CERT_REGISTRY_STORE_ROAMING_PARA ptr
const CERT_REGISTRY_STORE_MY_IE_DIRTY_FLAG = &h80000
const CERT_REGISTRY_STORE_EXTERNAL_FLAG = &h100000
#define CERT_IE_DIRTY_FLAGS_REGPATH wstr(!"Software\\Microsoft\\Cryptography\\IEDirtyFlags")
const CERT_FILE_STORE_COMMIT_ENABLE_FLAG = &h10000
const CERT_LDAP_STORE_SIGN_FLAG = &h10000
const CERT_LDAP_STORE_AREC_EXCLUSIVE_FLAG = &h20000
const CERT_LDAP_STORE_OPENED_FLAG = &h40000

type _CERT_LDAP_STORE_OPENED_PARA
	pvLdapSessionHandle as any ptr
	pwszLdapUrl as LPCWSTR
end type

type CERT_LDAP_STORE_OPENED_PARA as _CERT_LDAP_STORE_OPENED_PARA
type PCERT_LDAP_STORE_OPENED_PARA as _CERT_LDAP_STORE_OPENED_PARA ptr
const CERT_LDAP_STORE_UNBIND_FLAG = &h80000
declare function CertOpenStore(byval lpszStoreProvider as LPCSTR, byval dwEncodingType as DWORD, byval hCryptProv as HCRYPTPROV_LEGACY, byval dwFlags as DWORD, byval pvPara as const any ptr) as HCERTSTORE
type HCERTSTOREPROV as any ptr
#define CRYPT_OID_OPEN_STORE_PROV_FUNC "CertDllOpenStoreProv"

type _CERT_STORE_PROV_INFO
	cbSize as DWORD
	cStoreProvFunc as DWORD
	rgpvStoreProvFunc as any ptr ptr
	hStoreProv as HCERTSTOREPROV
	dwStoreProvFlags as DWORD
	hStoreProvFuncAddr2 as HCRYPTOIDFUNCADDR
end type

type CERT_STORE_PROV_INFO as _CERT_STORE_PROV_INFO
type PCERT_STORE_PROV_INFO as _CERT_STORE_PROV_INFO ptr
type PFN_CERT_DLL_OPEN_STORE_PROV_FUNC as function(byval lpszStoreProvider as LPCSTR, byval dwEncodingType as DWORD, byval hCryptProv as HCRYPTPROV_LEGACY, byval dwFlags as DWORD, byval pvPara as const any ptr, byval hCertStore as HCERTSTORE, byval pStoreProvInfo as PCERT_STORE_PROV_INFO) as WINBOOL

const CERT_STORE_PROV_EXTERNAL_FLAG = &h1
const CERT_STORE_PROV_DELETED_FLAG = &h2
const CERT_STORE_PROV_NO_PERSIST_FLAG = &h4
const CERT_STORE_PROV_SYSTEM_STORE_FLAG = &h8
const CERT_STORE_PROV_LM_SYSTEM_STORE_FLAG = &h10
const CERT_STORE_PROV_GP_SYSTEM_STORE_FLAG = &h20
const CERT_STORE_PROV_SHARED_USER_FLAG = &h40
const CERT_STORE_PROV_CLOSE_FUNC = 0
const CERT_STORE_PROV_READ_CERT_FUNC = 1
const CERT_STORE_PROV_WRITE_CERT_FUNC = 2
const CERT_STORE_PROV_DELETE_CERT_FUNC = 3
const CERT_STORE_PROV_SET_CERT_PROPERTY_FUNC = 4
const CERT_STORE_PROV_READ_CRL_FUNC = 5
const CERT_STORE_PROV_WRITE_CRL_FUNC = 6
const CERT_STORE_PROV_DELETE_CRL_FUNC = 7
const CERT_STORE_PROV_SET_CRL_PROPERTY_FUNC = 8
const CERT_STORE_PROV_READ_CTL_FUNC = 9
const CERT_STORE_PROV_WRITE_CTL_FUNC = 10
const CERT_STORE_PROV_DELETE_CTL_FUNC = 11
const CERT_STORE_PROV_SET_CTL_PROPERTY_FUNC = 12
const CERT_STORE_PROV_CONTROL_FUNC = 13
const CERT_STORE_PROV_FIND_CERT_FUNC = 14
const CERT_STORE_PROV_FREE_FIND_CERT_FUNC = 15
const CERT_STORE_PROV_GET_CERT_PROPERTY_FUNC = 16
const CERT_STORE_PROV_FIND_CRL_FUNC = 17
const CERT_STORE_PROV_FREE_FIND_CRL_FUNC = 18
const CERT_STORE_PROV_GET_CRL_PROPERTY_FUNC = 19
const CERT_STORE_PROV_FIND_CTL_FUNC = 20
const CERT_STORE_PROV_FREE_FIND_CTL_FUNC = 21
const CERT_STORE_PROV_GET_CTL_PROPERTY_FUNC = 22
const CERT_STORE_PROV_WRITE_ADD_FLAG = &h1

type PFN_CERT_STORE_PROV_CLOSE as sub(byval hStoreProv as HCERTSTOREPROV, byval dwFlags as DWORD)
type PFN_CERT_STORE_PROV_READ_CERT as function(byval hStoreProv as HCERTSTOREPROV, byval pStoreCertContext as PCCERT_CONTEXT, byval dwFlags as DWORD, byval ppProvCertContext as PCCERT_CONTEXT ptr) as WINBOOL
type PFN_CERT_STORE_PROV_WRITE_CERT as function(byval hStoreProv as HCERTSTOREPROV, byval pCertContext as PCCERT_CONTEXT, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_DELETE_CERT as function(byval hStoreProv as HCERTSTOREPROV, byval pCertContext as PCCERT_CONTEXT, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_SET_CERT_PROPERTY as function(byval hStoreProv as HCERTSTOREPROV, byval pCertContext as PCCERT_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL
type PFN_CERT_STORE_PROV_READ_CRL as function(byval hStoreProv as HCERTSTOREPROV, byval pStoreCrlContext as PCCRL_CONTEXT, byval dwFlags as DWORD, byval ppProvCrlContext as PCCRL_CONTEXT ptr) as WINBOOL
type PFN_CERT_STORE_PROV_WRITE_CRL as function(byval hStoreProv as HCERTSTOREPROV, byval pCrlContext as PCCRL_CONTEXT, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_DELETE_CRL as function(byval hStoreProv as HCERTSTOREPROV, byval pCrlContext as PCCRL_CONTEXT, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_SET_CRL_PROPERTY as function(byval hStoreProv as HCERTSTOREPROV, byval pCrlContext as PCCRL_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL
type PFN_CERT_STORE_PROV_READ_CTL as function(byval hStoreProv as HCERTSTOREPROV, byval pStoreCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD, byval ppProvCtlContext as PCCTL_CONTEXT ptr) as WINBOOL
type PFN_CERT_STORE_PROV_WRITE_CTL as function(byval hStoreProv as HCERTSTOREPROV, byval pCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_DELETE_CTL as function(byval hStoreProv as HCERTSTOREPROV, byval pCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_SET_CTL_PROPERTY as function(byval hStoreProv as HCERTSTOREPROV, byval pCtlContext as PCCTL_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL
type PFN_CERT_STORE_PROV_CONTROL as function(byval hStoreProv as HCERTSTOREPROV, byval dwFlags as DWORD, byval dwCtrlType as DWORD, byval pvCtrlPara as const any ptr) as WINBOOL

type _CERT_STORE_PROV_FIND_INFO
	cbSize as DWORD
	dwMsgAndCertEncodingType as DWORD
	dwFindFlags as DWORD
	dwFindType as DWORD
	pvFindPara as const any ptr
end type

type CERT_STORE_PROV_FIND_INFO as _CERT_STORE_PROV_FIND_INFO
type PCERT_STORE_PROV_FIND_INFO as _CERT_STORE_PROV_FIND_INFO ptr
type CCERT_STORE_PROV_FIND_INFO as const CERT_STORE_PROV_FIND_INFO
type PCCERT_STORE_PROV_FIND_INFO as const CERT_STORE_PROV_FIND_INFO ptr
type PFN_CERT_STORE_PROV_FIND_CERT as function(byval hStoreProv as HCERTSTOREPROV, byval pFindInfo as PCCERT_STORE_PROV_FIND_INFO, byval pPrevCertContext as PCCERT_CONTEXT, byval dwFlags as DWORD, byval ppvStoreProvFindInfo as any ptr ptr, byval ppProvCertContext as PCCERT_CONTEXT ptr) as WINBOOL
type PFN_CERT_STORE_PROV_FREE_FIND_CERT as function(byval hStoreProv as HCERTSTOREPROV, byval pCertContext as PCCERT_CONTEXT, byval pvStoreProvFindInfo as any ptr, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_GET_CERT_PROPERTY as function(byval hStoreProv as HCERTSTOREPROV, byval pCertContext as PCCERT_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
type PFN_CERT_STORE_PROV_FIND_CRL as function(byval hStoreProv as HCERTSTOREPROV, byval pFindInfo as PCCERT_STORE_PROV_FIND_INFO, byval pPrevCrlContext as PCCRL_CONTEXT, byval dwFlags as DWORD, byval ppvStoreProvFindInfo as any ptr ptr, byval ppProvCrlContext as PCCRL_CONTEXT ptr) as WINBOOL
type PFN_CERT_STORE_PROV_FREE_FIND_CRL as function(byval hStoreProv as HCERTSTOREPROV, byval pCrlContext as PCCRL_CONTEXT, byval pvStoreProvFindInfo as any ptr, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_GET_CRL_PROPERTY as function(byval hStoreProv as HCERTSTOREPROV, byval pCrlContext as PCCRL_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
type PFN_CERT_STORE_PROV_FIND_CTL as function(byval hStoreProv as HCERTSTOREPROV, byval pFindInfo as PCCERT_STORE_PROV_FIND_INFO, byval pPrevCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD, byval ppvStoreProvFindInfo as any ptr ptr, byval ppProvCtlContext as PCCTL_CONTEXT ptr) as WINBOOL
type PFN_CERT_STORE_PROV_FREE_FIND_CTL as function(byval hStoreProv as HCERTSTOREPROV, byval pCtlContext as PCCTL_CONTEXT, byval pvStoreProvFindInfo as any ptr, byval dwFlags as DWORD) as WINBOOL
type PFN_CERT_STORE_PROV_GET_CTL_PROPERTY as function(byval hStoreProv as HCERTSTOREPROV, byval pCtlContext as PCCTL_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
declare function CertDuplicateStore(byval hCertStore as HCERTSTORE) as HCERTSTORE

const CERT_STORE_SAVE_AS_STORE = 1
const CERT_STORE_SAVE_AS_PKCS7 = 2
const CERT_STORE_SAVE_AS_PKCS12 = 3
const CERT_STORE_SAVE_TO_FILE = 1
const CERT_STORE_SAVE_TO_MEMORY = 2
const CERT_STORE_SAVE_TO_FILENAME_A = 3
const CERT_STORE_SAVE_TO_FILENAME_W = 4
const CERT_STORE_SAVE_TO_FILENAME = CERT_STORE_SAVE_TO_FILENAME_W
const CERT_CLOSE_STORE_FORCE_FLAG = &h1
const CERT_CLOSE_STORE_CHECK_FLAG = &h2

declare function CertSaveStore(byval hCertStore as HCERTSTORE, byval dwEncodingType as DWORD, byval dwSaveAs as DWORD, byval dwSaveTo as DWORD, byval pvSaveToPara as any ptr, byval dwFlags as DWORD) as WINBOOL
declare function CertCloseStore(byval hCertStore as HCERTSTORE, byval dwFlags as DWORD) as WINBOOL
declare function CertGetSubjectCertificateFromStore(byval hCertStore as HCERTSTORE, byval dwCertEncodingType as DWORD, byval pCertId as PCERT_INFO) as PCCERT_CONTEXT
declare function CertEnumCertificatesInStore(byval hCertStore as HCERTSTORE, byval pPrevCertContext as PCCERT_CONTEXT) as PCCERT_CONTEXT
declare function CertFindCertificateInStore(byval hCertStore as HCERTSTORE, byval dwCertEncodingType as DWORD, byval dwFindFlags as DWORD, byval dwFindType as DWORD, byval pvFindPara as const any ptr, byval pPrevCertContext as PCCERT_CONTEXT) as PCCERT_CONTEXT

const CERT_COMPARE_MASK = &hffff
const CERT_COMPARE_SHIFT = 16
const CERT_COMPARE_ANY = 0
const CERT_COMPARE_SHA1_HASH = 1
const CERT_COMPARE_NAME = 2
const CERT_COMPARE_ATTR = 3
const CERT_COMPARE_MD5_HASH = 4
const CERT_COMPARE_PROPERTY = 5
const CERT_COMPARE_PUBLIC_KEY = 6
const CERT_COMPARE_HASH = CERT_COMPARE_SHA1_HASH
const CERT_COMPARE_NAME_STR_A = 7
const CERT_COMPARE_NAME_STR_W = 8
const CERT_COMPARE_KEY_SPEC = 9
const CERT_COMPARE_ENHKEY_USAGE = 10
const CERT_COMPARE_CTL_USAGE = CERT_COMPARE_ENHKEY_USAGE
const CERT_COMPARE_SUBJECT_CERT = 11
const CERT_COMPARE_ISSUER_OF = 12
const CERT_COMPARE_EXISTING = 13
const CERT_COMPARE_SIGNATURE_HASH = 14
const CERT_COMPARE_KEY_IDENTIFIER = 15
const CERT_COMPARE_CERT_ID = 16
const CERT_COMPARE_CROSS_CERT_DIST_POINTS = 17
const CERT_COMPARE_PUBKEY_MD5_HASH = 18
const CERT_COMPARE_SUBJECT_INFO_ACCESS = 19
const CERT_COMPARE_HASH_STR = 20
const CERT_COMPARE_HAS_PRIVATE_KEY = 21
const CERT_FIND_ANY = CERT_COMPARE_ANY shl CERT_COMPARE_SHIFT
const CERT_FIND_SHA1_HASH = CERT_COMPARE_SHA1_HASH shl CERT_COMPARE_SHIFT
const CERT_FIND_MD5_HASH = CERT_COMPARE_MD5_HASH shl CERT_COMPARE_SHIFT
const CERT_FIND_SIGNATURE_HASH = CERT_COMPARE_SIGNATURE_HASH shl CERT_COMPARE_SHIFT
const CERT_FIND_KEY_IDENTIFIER = CERT_COMPARE_KEY_IDENTIFIER shl CERT_COMPARE_SHIFT
const CERT_FIND_HASH = CERT_FIND_SHA1_HASH
const CERT_FIND_PROPERTY = CERT_COMPARE_PROPERTY shl CERT_COMPARE_SHIFT
const CERT_FIND_PUBLIC_KEY = CERT_COMPARE_PUBLIC_KEY shl CERT_COMPARE_SHIFT
const CERT_FIND_SUBJECT_NAME = (CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT) or CERT_INFO_SUBJECT_FLAG
const CERT_FIND_SUBJECT_ATTR = (CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT) or CERT_INFO_SUBJECT_FLAG
const CERT_FIND_ISSUER_NAME = (CERT_COMPARE_NAME shl CERT_COMPARE_SHIFT) or CERT_INFO_ISSUER_FLAG
const CERT_FIND_ISSUER_ATTR = (CERT_COMPARE_ATTR shl CERT_COMPARE_SHIFT) or CERT_INFO_ISSUER_FLAG
const CERT_FIND_SUBJECT_STR_A = (CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT) or CERT_INFO_SUBJECT_FLAG
const CERT_FIND_SUBJECT_STR_W = (CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT) or CERT_INFO_SUBJECT_FLAG
const CERT_FIND_SUBJECT_STR = CERT_FIND_SUBJECT_STR_W
const CERT_FIND_ISSUER_STR_A = (CERT_COMPARE_NAME_STR_A shl CERT_COMPARE_SHIFT) or CERT_INFO_ISSUER_FLAG
const CERT_FIND_ISSUER_STR_W = (CERT_COMPARE_NAME_STR_W shl CERT_COMPARE_SHIFT) or CERT_INFO_ISSUER_FLAG
const CERT_FIND_ISSUER_STR = CERT_FIND_ISSUER_STR_W
const CERT_FIND_KEY_SPEC = CERT_COMPARE_KEY_SPEC shl CERT_COMPARE_SHIFT
const CERT_FIND_ENHKEY_USAGE = CERT_COMPARE_ENHKEY_USAGE shl CERT_COMPARE_SHIFT
const CERT_FIND_CTL_USAGE = CERT_FIND_ENHKEY_USAGE
const CERT_FIND_SUBJECT_CERT = CERT_COMPARE_SUBJECT_CERT shl CERT_COMPARE_SHIFT
const CERT_FIND_ISSUER_OF = CERT_COMPARE_ISSUER_OF shl CERT_COMPARE_SHIFT
const CERT_FIND_EXISTING = CERT_COMPARE_EXISTING shl CERT_COMPARE_SHIFT
const CERT_FIND_CERT_ID = CERT_COMPARE_CERT_ID shl CERT_COMPARE_SHIFT
const CERT_FIND_CROSS_CERT_DIST_POINTS = CERT_COMPARE_CROSS_CERT_DIST_POINTS shl CERT_COMPARE_SHIFT
const CERT_FIND_PUBKEY_MD5_HASH = CERT_COMPARE_PUBKEY_MD5_HASH shl CERT_COMPARE_SHIFT
const CERT_FIND_SUBJECT_INFO_ACCESS = CERT_COMPARE_SUBJECT_INFO_ACCESS shl CERT_COMPARE_SHIFT
const CERT_FIND_HASH_STR = CERT_COMPARE_HASH_STR shl CERT_COMPARE_SHIFT
const CERT_FIND_HAS_PRIVATE_KEY = CERT_COMPARE_HAS_PRIVATE_KEY shl CERT_COMPARE_SHIFT
const CERT_FIND_OPTIONAL_ENHKEY_USAGE_FLAG = &h1
const CERT_FIND_EXT_ONLY_ENHKEY_USAGE_FLAG = &h2
const CERT_FIND_PROP_ONLY_ENHKEY_USAGE_FLAG = &h4
const CERT_FIND_NO_ENHKEY_USAGE_FLAG = &h8
const CERT_FIND_OR_ENHKEY_USAGE_FLAG = &h10
const CERT_FIND_VALID_ENHKEY_USAGE_FLAG = &h20
const CERT_FIND_OPTIONAL_CTL_USAGE_FLAG = CERT_FIND_OPTIONAL_ENHKEY_USAGE_FLAG
const CERT_FIND_EXT_ONLY_CTL_USAGE_FLAG = CERT_FIND_EXT_ONLY_ENHKEY_USAGE_FLAG
const CERT_FIND_PROP_ONLY_CTL_USAGE_FLAG = CERT_FIND_PROP_ONLY_ENHKEY_USAGE_FLAG
const CERT_FIND_NO_CTL_USAGE_FLAG = CERT_FIND_NO_ENHKEY_USAGE_FLAG
const CERT_FIND_OR_CTL_USAGE_FLAG = CERT_FIND_OR_ENHKEY_USAGE_FLAG
const CERT_FIND_VALID_CTL_USAGE_FLAG = CERT_FIND_VALID_ENHKEY_USAGE_FLAG

declare function CertGetIssuerCertificateFromStore(byval hCertStore as HCERTSTORE, byval pSubjectContext as PCCERT_CONTEXT, byval pPrevIssuerContext as PCCERT_CONTEXT, byval pdwFlags as DWORD ptr) as PCCERT_CONTEXT
declare function CertVerifySubjectCertificateContext(byval pSubject as PCCERT_CONTEXT, byval pIssuer as PCCERT_CONTEXT, byval pdwFlags as DWORD ptr) as WINBOOL
declare function CertDuplicateCertificateContext(byval pCertContext as PCCERT_CONTEXT) as PCCERT_CONTEXT
declare function CertCreateCertificateContext(byval dwCertEncodingType as DWORD, byval pbCertEncoded as const UBYTE ptr, byval cbCertEncoded as DWORD) as PCCERT_CONTEXT
declare function CertFreeCertificateContext(byval pCertContext as PCCERT_CONTEXT) as WINBOOL
declare function CertSetCertificateContextProperty(byval pCertContext as PCCERT_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL

type _CRL_FIND_ISSUED_FOR_PARA
	pSubjectCert as PCCERT_CONTEXT
	pIssuerCert as PCCERT_CONTEXT
end type

type CRL_FIND_ISSUED_FOR_PARA as _CRL_FIND_ISSUED_FOR_PARA
type PCRL_FIND_ISSUED_FOR_PARA as _CRL_FIND_ISSUED_FOR_PARA ptr

type _CTL_ANY_SUBJECT_INFO
	SubjectAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	SubjectIdentifier as CRYPT_DATA_BLOB
end type

type CTL_ANY_SUBJECT_INFO as _CTL_ANY_SUBJECT_INFO
type PCTL_ANY_SUBJECT_INFO as _CTL_ANY_SUBJECT_INFO ptr
const CERT_SET_PROPERTY_INHIBIT_PERSIST_FLAG = &h40000000
const CERT_SET_PROPERTY_IGNORE_PERSIST_ERROR_FLAG = &h80000000
const CTL_ENTRY_FROM_PROP_CHAIN_FLAG = &h1
const CRL_FIND_ANY = 0
const CRL_FIND_ISSUED_BY = 1
const CRL_FIND_EXISTING = 2
const CRL_FIND_ISSUED_FOR = 3
const CRL_FIND_ISSUED_BY_AKI_FLAG = &h1
const CRL_FIND_ISSUED_BY_SIGNATURE_FLAG = &h2
const CRL_FIND_ISSUED_BY_DELTA_FLAG = &h4
const CRL_FIND_ISSUED_BY_BASE_FLAG = &h8
const CRL_FIND_ISSUED_FOR_SET_STRONG_PROPERTIES_FLAG = &h10
const CERT_STORE_ADD_NEW = 1
const CERT_STORE_ADD_USE_EXISTING = 2
const CERT_STORE_ADD_REPLACE_EXISTING = 3
const CERT_STORE_ADD_ALWAYS = 4
const CERT_STORE_ADD_REPLACE_EXISTING_INHERIT_PROPERTIES = 5
const CERT_STORE_ADD_NEWER = 6
const CERT_STORE_ADD_NEWER_INHERIT_PROPERTIES = 7
const CERT_STORE_CERTIFICATE_CONTEXT = 1
const CERT_STORE_CRL_CONTEXT = 2
const CERT_STORE_CTL_CONTEXT = 3
const CERT_STORE_ALL_CONTEXT_FLAG = culng(not 0u)
const CERT_STORE_CERTIFICATE_CONTEXT_FLAG = 1 shl CERT_STORE_CERTIFICATE_CONTEXT
const CERT_STORE_CRL_CONTEXT_FLAG = 1 shl CERT_STORE_CRL_CONTEXT
const CERT_STORE_CTL_CONTEXT_FLAG = 1 shl CERT_STORE_CTL_CONTEXT
const CTL_ANY_SUBJECT_TYPE = 1
const CTL_CERT_SUBJECT_TYPE = 2

declare function CertGetCertificateContextProperty(byval pCertContext as PCCERT_CONTEXT, byval dwPropId as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
declare function CertEnumCertificateContextProperties(byval pCertContext as PCCERT_CONTEXT, byval dwPropId as DWORD) as DWORD
declare function CertCreateCTLEntryFromCertificateContextProperties(byval pCertContext as PCCERT_CONTEXT, byval cOptAttr as DWORD, byval rgOptAttr as PCRYPT_ATTRIBUTE, byval dwFlags as DWORD, byval pvReserved as any ptr, byval pCtlEntry as PCTL_ENTRY, byval pcbCtlEntry as DWORD ptr) as WINBOOL
declare function CertSetCertificateContextPropertiesFromCTLEntry(byval pCertContext as PCCERT_CONTEXT, byval pCtlEntry as PCTL_ENTRY, byval dwFlags as DWORD) as WINBOOL
declare function CertGetCRLFromStore(byval hCertStore as HCERTSTORE, byval pIssuerContext as PCCERT_CONTEXT, byval pPrevCrlContext as PCCRL_CONTEXT, byval pdwFlags as DWORD ptr) as PCCRL_CONTEXT
declare function CertEnumCRLsInStore(byval hCertStore as HCERTSTORE, byval pPrevCrlContext as PCCRL_CONTEXT) as PCCRL_CONTEXT
declare function CertFindCRLInStore(byval hCertStore as HCERTSTORE, byval dwCertEncodingType as DWORD, byval dwFindFlags as DWORD, byval dwFindType as DWORD, byval pvFindPara as const any ptr, byval pPrevCrlContext as PCCRL_CONTEXT) as PCCRL_CONTEXT
declare function CertDuplicateCRLContext(byval pCrlContext as PCCRL_CONTEXT) as PCCRL_CONTEXT
declare function CertCreateCRLContext(byval dwCertEncodingType as DWORD, byval pbCrlEncoded as const UBYTE ptr, byval cbCrlEncoded as DWORD) as PCCRL_CONTEXT
declare function CertFreeCRLContext(byval pCrlContext as PCCRL_CONTEXT) as WINBOOL
declare function CertSetCRLContextProperty(byval pCrlContext as PCCRL_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL
declare function CertGetCRLContextProperty(byval pCrlContext as PCCRL_CONTEXT, byval dwPropId as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
declare function CertEnumCRLContextProperties(byval pCrlContext as PCCRL_CONTEXT, byval dwPropId as DWORD) as DWORD
declare function CertFindCertificateInCRL(byval pCert as PCCERT_CONTEXT, byval pCrlContext as PCCRL_CONTEXT, byval dwFlags as DWORD, byval pvReserved as any ptr, byval ppCrlEntry as PCRL_ENTRY ptr) as WINBOOL
declare function CertIsValidCRLForCertificate(byval pCert as PCCERT_CONTEXT, byval pCrl as PCCRL_CONTEXT, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
declare function CertAddEncodedCertificateToStore(byval hCertStore as HCERTSTORE, byval dwCertEncodingType as DWORD, byval pbCertEncoded as const UBYTE ptr, byval cbCertEncoded as DWORD, byval dwAddDisposition as DWORD, byval ppCertContext as PCCERT_CONTEXT ptr) as WINBOOL
declare function CertAddCertificateContextToStore(byval hCertStore as HCERTSTORE, byval pCertContext as PCCERT_CONTEXT, byval dwAddDisposition as DWORD, byval ppStoreContext as PCCERT_CONTEXT ptr) as WINBOOL
declare function CertAddSerializedElementToStore(byval hCertStore as HCERTSTORE, byval pbElement as const UBYTE ptr, byval cbElement as DWORD, byval dwAddDisposition as DWORD, byval dwFlags as DWORD, byval dwContextTypeFlags as DWORD, byval pdwContextType as DWORD ptr, byval ppvContext as const any ptr ptr) as WINBOOL
declare function CertDeleteCertificateFromStore(byval pCertContext as PCCERT_CONTEXT) as WINBOOL
declare function CertAddEncodedCRLToStore(byval hCertStore as HCERTSTORE, byval dwCertEncodingType as DWORD, byval pbCrlEncoded as const UBYTE ptr, byval cbCrlEncoded as DWORD, byval dwAddDisposition as DWORD, byval ppCrlContext as PCCRL_CONTEXT ptr) as WINBOOL
declare function CertAddCRLContextToStore(byval hCertStore as HCERTSTORE, byval pCrlContext as PCCRL_CONTEXT, byval dwAddDisposition as DWORD, byval ppStoreContext as PCCRL_CONTEXT ptr) as WINBOOL
declare function CertDeleteCRLFromStore(byval pCrlContext as PCCRL_CONTEXT) as WINBOOL
declare function CertSerializeCertificateStoreElement(byval pCertContext as PCCERT_CONTEXT, byval dwFlags as DWORD, byval pbElement as UBYTE ptr, byval pcbElement as DWORD ptr) as WINBOOL
declare function CertSerializeCRLStoreElement(byval pCrlContext as PCCRL_CONTEXT, byval dwFlags as DWORD, byval pbElement as UBYTE ptr, byval pcbElement as DWORD ptr) as WINBOOL
declare function CertDuplicateCTLContext(byval pCtlContext as PCCTL_CONTEXT) as PCCTL_CONTEXT
declare function CertCreateCTLContext(byval dwMsgAndCertEncodingType as DWORD, byval pbCtlEncoded as const UBYTE ptr, byval cbCtlEncoded as DWORD) as PCCTL_CONTEXT
declare function CertFreeCTLContext(byval pCtlContext as PCCTL_CONTEXT) as WINBOOL
declare function CertSetCTLContextProperty(byval pCtlContext as PCCTL_CONTEXT, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL
declare function CertGetCTLContextProperty(byval pCtlContext as PCCTL_CONTEXT, byval dwPropId as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
declare function CertEnumCTLContextProperties(byval pCtlContext as PCCTL_CONTEXT, byval dwPropId as DWORD) as DWORD
declare function CertEnumCTLsInStore(byval hCertStore as HCERTSTORE, byval pPrevCtlContext as PCCTL_CONTEXT) as PCCTL_CONTEXT
declare function CertFindSubjectInCTL(byval dwEncodingType as DWORD, byval dwSubjectType as DWORD, byval pvSubject as any ptr, byval pCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD) as PCTL_ENTRY
declare function CertFindCTLInStore(byval hCertStore as HCERTSTORE, byval dwMsgAndCertEncodingType as DWORD, byval dwFindFlags as DWORD, byval dwFindType as DWORD, byval pvFindPara as const any ptr, byval pPrevCtlContext as PCCTL_CONTEXT) as PCCTL_CONTEXT

const CTL_FIND_ANY = 0
const CTL_FIND_SHA1_HASH = 1
const CTL_FIND_MD5_HASH = 2
const CTL_FIND_USAGE = 3
const CTL_FIND_SUBJECT = 4
const CTL_FIND_EXISTING = 5
const CTL_FIND_SAME_USAGE_FLAG = &h1
const CTL_FIND_NO_LIST_ID_CBDATA = &hffffffff
const CTL_FIND_NO_SIGNER_PTR = cast(PCERT_INFO, -1)
const CERT_STORE_CTRL_RESYNC = 1
const CERT_STORE_CTRL_NOTIFY_CHANGE = 2
const CERT_STORE_CTRL_COMMIT = 3
const CERT_STORE_CTRL_AUTO_RESYNC = 4
const CERT_STORE_CTRL_CANCEL_NOTIFY = 5
const CERT_STORE_CTRL_INHIBIT_DUPLICATE_HANDLE_FLAG = &h1
const CERT_STORE_CTRL_COMMIT_FORCE_FLAG = &h1
const CERT_STORE_CTRL_COMMIT_CLEAR_FLAG = &h2
const CERT_STORE_LOCALIZED_NAME_PROP_ID = &h1000
const CERT_CREATE_CONTEXT_NOCOPY_FLAG = &h1
const CERT_CREATE_CONTEXT_SORTED_FLAG = &h2
const CERT_CREATE_CONTEXT_NO_HCRYPTMSG_FLAG = &h4
const CERT_CREATE_CONTEXT_NO_ENTRY_FLAG = &h8
const CERT_PHYSICAL_STORE_ADD_ENABLE_FLAG = &h1
const CERT_PHYSICAL_STORE_OPEN_DISABLE_FLAG = &h2
const CERT_PHYSICAL_STORE_REMOTE_OPEN_DISABLE_FLAG = &h4
const CERT_PHYSICAL_STORE_INSERT_COMPUTER_NAME_ENABLE_FLAG = &h8

type _CTL_FIND_USAGE_PARA
	cbSize as DWORD
	SubjectUsage as CTL_USAGE
	ListIdentifier as CRYPT_DATA_BLOB
	pSigner as PCERT_INFO
end type

type CTL_FIND_USAGE_PARA as _CTL_FIND_USAGE_PARA
type PCTL_FIND_USAGE_PARA as _CTL_FIND_USAGE_PARA ptr

type _CTL_FIND_SUBJECT_PARA
	cbSize as DWORD
	pUsagePara as PCTL_FIND_USAGE_PARA
	dwSubjectType as DWORD
	pvSubject as any ptr
end type

type CTL_FIND_SUBJECT_PARA as _CTL_FIND_SUBJECT_PARA
type PCTL_FIND_SUBJECT_PARA as _CTL_FIND_SUBJECT_PARA ptr
type PFN_CERT_CREATE_CONTEXT_SORT_FUNC as function(byval cbTotalEncoded as DWORD, byval cbRemainEncoded as DWORD, byval cEntry as DWORD, byval pvSort as any ptr) as WINBOOL

type _CERT_CREATE_CONTEXT_PARA
	cbSize as DWORD
	pfnFree as PFN_CRYPT_FREE
	pvFree as any ptr
	pfnSort as PFN_CERT_CREATE_CONTEXT_SORT_FUNC
	pvSort as any ptr
end type

type CERT_CREATE_CONTEXT_PARA as _CERT_CREATE_CONTEXT_PARA
type PCERT_CREATE_CONTEXT_PARA as _CERT_CREATE_CONTEXT_PARA ptr

type _CERT_SYSTEM_STORE_INFO
	cbSize as DWORD
end type

type CERT_SYSTEM_STORE_INFO as _CERT_SYSTEM_STORE_INFO
type PCERT_SYSTEM_STORE_INFO as _CERT_SYSTEM_STORE_INFO ptr

type _CERT_PHYSICAL_STORE_INFO
	cbSize as DWORD
	pszOpenStoreProvider as LPSTR
	dwOpenEncodingType as DWORD
	dwOpenFlags as DWORD
	OpenParameters as CRYPT_DATA_BLOB
	dwFlags as DWORD
	dwPriority as DWORD
end type

type CERT_PHYSICAL_STORE_INFO as _CERT_PHYSICAL_STORE_INFO
type PCERT_PHYSICAL_STORE_INFO as _CERT_PHYSICAL_STORE_INFO ptr
declare function CertAddEncodedCTLToStore(byval hCertStore as HCERTSTORE, byval dwMsgAndCertEncodingType as DWORD, byval pbCtlEncoded as const UBYTE ptr, byval cbCtlEncoded as DWORD, byval dwAddDisposition as DWORD, byval ppCtlContext as PCCTL_CONTEXT ptr) as WINBOOL
declare function CertAddCTLContextToStore(byval hCertStore as HCERTSTORE, byval pCtlContext as PCCTL_CONTEXT, byval dwAddDisposition as DWORD, byval ppStoreContext as PCCTL_CONTEXT ptr) as WINBOOL
declare function CertSerializeCTLStoreElement(byval pCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD, byval pbElement as UBYTE ptr, byval pcbElement as DWORD ptr) as WINBOOL
declare function CertDeleteCTLFromStore(byval pCtlContext as PCCTL_CONTEXT) as WINBOOL
declare function CertAddCertificateLinkToStore(byval hCertStore as HCERTSTORE, byval pCertContext as PCCERT_CONTEXT, byval dwAddDisposition as DWORD, byval ppStoreContext as PCCERT_CONTEXT ptr) as WINBOOL
declare function CertAddCRLLinkToStore(byval hCertStore as HCERTSTORE, byval pCrlContext as PCCRL_CONTEXT, byval dwAddDisposition as DWORD, byval ppStoreContext as PCCRL_CONTEXT ptr) as WINBOOL
declare function CertAddCTLLinkToStore(byval hCertStore as HCERTSTORE, byval pCtlContext as PCCTL_CONTEXT, byval dwAddDisposition as DWORD, byval ppStoreContext as PCCTL_CONTEXT ptr) as WINBOOL
declare function CertAddStoreToCollection(byval hCollectionStore as HCERTSTORE, byval hSiblingStore as HCERTSTORE, byval dwUpdateFlags as DWORD, byval dwPriority as DWORD) as WINBOOL
declare sub CertRemoveStoreFromCollection(byval hCollectionStore as HCERTSTORE, byval hSiblingStore as HCERTSTORE)
declare function CertControlStore(byval hCertStore as HCERTSTORE, byval dwFlags as DWORD, byval dwCtrlType as DWORD, byval pvCtrlPara as const any ptr) as WINBOOL
declare function CertSetStoreProperty(byval hCertStore as HCERTSTORE, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pvData as const any ptr) as WINBOOL
declare function CertGetStoreProperty(byval hCertStore as HCERTSTORE, byval dwPropId as DWORD, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
declare function CertCreateContext(byval dwContextType as DWORD, byval dwEncodingType as DWORD, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval dwFlags as DWORD, byval pCreatePara as PCERT_CREATE_CONTEXT_PARA) as const any ptr
declare function CertRegisterSystemStore(byval pvSystemStore as const any ptr, byval dwFlags as DWORD, byval pStoreInfo as PCERT_SYSTEM_STORE_INFO, byval pvReserved as any ptr) as WINBOOL
declare function CertRegisterPhysicalStore(byval pvSystemStore as const any ptr, byval dwFlags as DWORD, byval pwszStoreName as LPCWSTR, byval pStoreInfo as PCERT_PHYSICAL_STORE_INFO, byval pvReserved as any ptr) as WINBOOL
declare function CertUnregisterSystemStore(byval pvSystemStore as const any ptr, byval dwFlags as DWORD) as WINBOOL
declare function CertUnregisterPhysicalStore(byval pvSystemStore as const any ptr, byval dwFlags as DWORD, byval pwszStoreName as LPCWSTR) as WINBOOL

type PFN_CERT_ENUM_SYSTEM_STORE_LOCATION as function(byval pwszStoreLocation as LPCWSTR, byval dwFlags as DWORD, byval pvReserved as any ptr, byval pvArg as any ptr) as WINBOOL
type PFN_CERT_ENUM_SYSTEM_STORE as function(byval pvSystemStore as const any ptr, byval dwFlags as DWORD, byval pStoreInfo as PCERT_SYSTEM_STORE_INFO, byval pvReserved as any ptr, byval pvArg as any ptr) as WINBOOL
type PFN_CERT_ENUM_PHYSICAL_STORE as function(byval pvSystemStore as const any ptr, byval dwFlags as DWORD, byval pwszStoreName as LPCWSTR, byval pStoreInfo as PCERT_PHYSICAL_STORE_INFO, byval pvReserved as any ptr, byval pvArg as any ptr) as WINBOOL

const CERT_PHYSICAL_STORE_PREDEFINED_ENUM_FLAG = &h1
#define CERT_PHYSICAL_STORE_DEFAULT_NAME wstr(".Default")
#define CERT_PHYSICAL_STORE_GROUP_POLICY_NAME wstr(".GroupPolicy")
#define CERT_PHYSICAL_STORE_LOCAL_MACHINE_NAME wstr(".LocalMachine")
#define CERT_PHYSICAL_STORE_DS_USER_CERTIFICATE_NAME wstr(".UserCertificate")
#define CERT_PHYSICAL_STORE_LOCAL_MACHINE_GROUP_POLICY_NAME wstr(".LocalMachineGroupPolicy")
#define CERT_PHYSICAL_STORE_ENTERPRISE_NAME wstr(".Enterprise")
#define CERT_PHYSICAL_STORE_AUTH_ROOT_NAME wstr(".AuthRoot")
#define CERT_PHYSICAL_STORE_SMART_CARD_NAME wstr(".SmartCard")

declare function CertEnumSystemStoreLocation(byval dwFlags as DWORD, byval pvArg as any ptr, byval pfnEnum as PFN_CERT_ENUM_SYSTEM_STORE_LOCATION) as WINBOOL
declare function CertEnumSystemStore(byval dwFlags as DWORD, byval pvSystemStoreLocationPara as any ptr, byval pvArg as any ptr, byval pfnEnum as PFN_CERT_ENUM_SYSTEM_STORE) as WINBOOL
declare function CertEnumPhysicalStore(byval pvSystemStore as const any ptr, byval dwFlags as DWORD, byval pvArg as any ptr, byval pfnEnum as PFN_CERT_ENUM_PHYSICAL_STORE) as WINBOOL

#define CRYPT_OID_OPEN_SYSTEM_STORE_PROV_FUNC "CertDllOpenSystemStoreProv"
#define CRYPT_OID_REGISTER_SYSTEM_STORE_FUNC "CertDllRegisterSystemStore"
#define CRYPT_OID_UNREGISTER_SYSTEM_STORE_FUNC "CertDllUnregisterSystemStore"
#define CRYPT_OID_ENUM_SYSTEM_STORE_FUNC "CertDllEnumSystemStore"
#define CRYPT_OID_REGISTER_PHYSICAL_STORE_FUNC "CertDllRegisterPhysicalStore"
#define CRYPT_OID_UNREGISTER_PHYSICAL_STORE_FUNC "CertDllUnregisterPhysicalStore"
#define CRYPT_OID_ENUM_PHYSICAL_STORE_FUNC "CertDllEnumPhysicalStore"
#define CRYPT_OID_SYSTEM_STORE_LOCATION_VALUE_NAME wstr("SystemStoreLocation")
const CMSG_TRUSTED_SIGNER_FLAG = &h1
const CMSG_SIGNER_ONLY_FLAG = &h2
const CMSG_USE_SIGNER_INDEX_FLAG = &h4
const CMSG_CMS_ENCAPSULATED_CTL_FLAG = &h8000
const CMSG_ENCODE_SORTED_CTL_FLAG = &h1
const CMSG_ENCODE_HASHED_SUBJECT_IDENTIFIER_FLAG = &h2

declare function CertGetEnhancedKeyUsage(byval pCertContext as PCCERT_CONTEXT, byval dwFlags as DWORD, byval pUsage as PCERT_ENHKEY_USAGE, byval pcbUsage as DWORD ptr) as WINBOOL
declare function CertSetEnhancedKeyUsage(byval pCertContext as PCCERT_CONTEXT, byval pUsage as PCERT_ENHKEY_USAGE) as WINBOOL
declare function CertAddEnhancedKeyUsageIdentifier(byval pCertContext as PCCERT_CONTEXT, byval pszUsageIdentifier as LPCSTR) as WINBOOL
declare function CertRemoveEnhancedKeyUsageIdentifier(byval pCertContext as PCCERT_CONTEXT, byval pszUsageIdentifier as LPCSTR) as WINBOOL
declare function CertGetValidUsages(byval cCerts as DWORD, byval rghCerts as PCCERT_CONTEXT ptr, byval cNumOIDs as long ptr, byval rghOIDs as LPSTR ptr, byval pcbOIDs as DWORD ptr) as WINBOOL
declare function CryptMsgGetAndVerifySigner(byval hCryptMsg as HCRYPTMSG, byval cSignerStore as DWORD, byval rghSignerStore as HCERTSTORE ptr, byval dwFlags as DWORD, byval ppSigner as PCCERT_CONTEXT ptr, byval pdwSignerIndex as DWORD ptr) as WINBOOL
declare function CryptMsgSignCTL(byval dwMsgEncodingType as DWORD, byval pbCtlContent as UBYTE ptr, byval cbCtlContent as DWORD, byval pSignInfo as PCMSG_SIGNED_ENCODE_INFO, byval dwFlags as DWORD, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr) as WINBOOL
declare function CryptMsgEncodeAndSignCTL(byval dwMsgEncodingType as DWORD, byval pCtlInfo as PCTL_INFO, byval pSignInfo as PCMSG_SIGNED_ENCODE_INFO, byval dwFlags as DWORD, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr) as WINBOOL
declare function CertFindSubjectInSortedCTL(byval pSubjectIdentifier as PCRYPT_DATA_BLOB, byval pCtlContext as PCCTL_CONTEXT, byval dwFlags as DWORD, byval pvReserved as any ptr, byval pEncodedAttributes as PCRYPT_DER_BLOB) as WINBOOL
declare function CertEnumSubjectInSortedCTL(byval pCtlContext as PCCTL_CONTEXT, byval ppvNextSubject as any ptr ptr, byval pSubjectIdentifier as PCRYPT_DER_BLOB, byval pEncodedAttributes as PCRYPT_DER_BLOB) as WINBOOL

type _CTL_VERIFY_USAGE_PARA
	cbSize as DWORD
	ListIdentifier as CRYPT_DATA_BLOB
	cCtlStore as DWORD
	rghCtlStore as HCERTSTORE ptr
	cSignerStore as DWORD
	rghSignerStore as HCERTSTORE ptr
end type

type CTL_VERIFY_USAGE_PARA as _CTL_VERIFY_USAGE_PARA
type PCTL_VERIFY_USAGE_PARA as _CTL_VERIFY_USAGE_PARA ptr

type _CTL_VERIFY_USAGE_STATUS
	cbSize as DWORD
	dwError as DWORD
	dwFlags as DWORD
	ppCtl as PCCTL_CONTEXT ptr
	dwCtlEntryIndex as DWORD
	ppSigner as PCCERT_CONTEXT ptr
	dwSignerIndex as DWORD
end type

type CTL_VERIFY_USAGE_STATUS as _CTL_VERIFY_USAGE_STATUS
type PCTL_VERIFY_USAGE_STATUS as _CTL_VERIFY_USAGE_STATUS ptr
const CERT_VERIFY_INHIBIT_CTL_UPDATE_FLAG = &h1
const CERT_VERIFY_TRUSTED_SIGNERS_FLAG = &h2
const CERT_VERIFY_NO_TIME_CHECK_FLAG = &h4
const CERT_VERIFY_ALLOW_MORE_USAGE_FLAG = &h8
const CERT_VERIFY_UPDATED_CTL_FLAG = &h1
declare function CertVerifyCTLUsage(byval dwEncodingType as DWORD, byval dwSubjectType as DWORD, byval pvSubject as any ptr, byval pSubjectUsage as PCTL_USAGE, byval dwFlags as DWORD, byval pVerifyUsagePara as PCTL_VERIFY_USAGE_PARA, byval pVerifyUsageStatus as PCTL_VERIFY_USAGE_STATUS) as WINBOOL

type _CERT_REVOCATION_CRL_INFO
	cbSize as DWORD
	pBaseCrlContext as PCCRL_CONTEXT
	pDeltaCrlContext as PCCRL_CONTEXT
	pCrlEntry as PCRL_ENTRY
	fDeltaCrlEntry as WINBOOL
end type

type CERT_REVOCATION_CRL_INFO as _CERT_REVOCATION_CRL_INFO
type PCERT_REVOCATION_CRL_INFO as _CERT_REVOCATION_CRL_INFO ptr
type CERT_REVOCATION_CHAIN_PARA as _CERT_REVOCATION_CHAIN_PARA
type PCERT_REVOCATION_CHAIN_PARA as _CERT_REVOCATION_CHAIN_PARA ptr

type _CERT_REVOCATION_PARA
	cbSize as DWORD
	pIssuerCert as PCCERT_CONTEXT
	cCertStore as DWORD
	rgCertStore as HCERTSTORE ptr
	hCrlStore as HCERTSTORE
	pftTimeToUse as LPFILETIME
end type

type CERT_REVOCATION_PARA as _CERT_REVOCATION_PARA
type PCERT_REVOCATION_PARA as _CERT_REVOCATION_PARA ptr

type _CERT_REVOCATION_STATUS
	cbSize as DWORD
	dwIndex as DWORD
	dwError as DWORD
	dwReason as DWORD
	fHasFreshnessTime as WINBOOL
	dwFreshnessTime as DWORD
end type

type CERT_REVOCATION_STATUS as _CERT_REVOCATION_STATUS
type PCERT_REVOCATION_STATUS as _CERT_REVOCATION_STATUS ptr
const CERT_CONTEXT_REVOCATION_TYPE = 1
const CERT_VERIFY_REV_CHAIN_FLAG = &h1
const CERT_VERIFY_CACHE_ONLY_BASED_REVOCATION = &h2
const CERT_VERIFY_REV_ACCUMULATIVE_TIMEOUT_FLAG = &h4
const CERT_VERIFY_REV_SERVER_OCSP_FLAG = &h8
const CERT_VERIFY_REV_NO_OCSP_FAILOVER_TO_CRL_FLAG = &h10
const CERT_UNICODE_IS_RDN_ATTRS_FLAG = &h1
const CERT_CASE_INSENSITIVE_IS_RDN_ATTRS_FLAG = &h2
const CRYPT_VERIFY_CERT_SIGN_SUBJECT_BLOB = 1
const CRYPT_VERIFY_CERT_SIGN_SUBJECT_CERT = 2
const CRYPT_VERIFY_CERT_SIGN_SUBJECT_CRL = 3
const CRYPT_VERIFY_CERT_SIGN_SUBJECT_OCSP_BASIC_SIGNED_RESPONSE = 4
const CRYPT_VERIFY_CERT_SIGN_ISSUER_PUBKEY = 1
const CRYPT_VERIFY_CERT_SIGN_ISSUER_CERT = 2
const CRYPT_VERIFY_CERT_SIGN_ISSUER_CHAIN = 3
const CRYPT_VERIFY_CERT_SIGN_ISSUER_NULL = 4
const CRYPT_VERIFY_CERT_SIGN_DISABLE_MD2_MD4_FLAG = &h1
const CRYPT_VERIFY_CERT_SIGN_SET_STRONG_PROPERTIES_FLAG = &h2
const CRYPT_VERIFY_CERT_SIGN_RETURN_STRONG_PROPERTIES_FLAG = &h4
#define CRYPT_OID_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC "CryptDllExtractEncodedSignatureParameters"
#define CRYPT_OID_SIGN_AND_ENCODE_HASH_FUNC "CryptDllSignAndEncodeHash"
#define CRYPT_OID_VERIFY_ENCODED_SIGNATURE_FUNC "CryptDllVerifyEncodedSignature"
const CRYPT_DEFAULT_CONTEXT_AUTO_RELEASE_FLAG = &h1
const CRYPT_DEFAULT_CONTEXT_PROCESS_FLAG = &h2
const CRYPT_DEFAULT_CONTEXT_CERT_SIGN_OID = 1
const CRYPT_DEFAULT_CONTEXT_MULTI_CERT_SIGN_OID = 2

type _CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO
	CertSignHashCNGAlgPropData as CRYPT_DATA_BLOB
	CertIssuerPubKeyBitLengthPropData as CRYPT_DATA_BLOB
end type

type CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO as _CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO
type PCRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO as _CRYPT_VERIFY_CERT_SIGN_STRONG_PROPERTIES_INFO ptr
type PFN_CRYPT_EXTRACT_ENCODED_SIGNATURE_PARAMETERS_FUNC as function(byval dwCertEncodingType as DWORD, byval pSignatureAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval ppvDecodedSignPara as any ptr ptr, byval ppwszCNGHashAlgid as LPWSTR ptr) as WINBOOL
type PFN_CRYPT_SIGN_AND_ENCODE_HASH_FUNC as function(byval hKey as NCRYPT_KEY_HANDLE, byval dwCertEncodingType as DWORD, byval pSignatureAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pvDecodedSignPara as any ptr, byval pwszCNGPubKeyAlgid as LPCWSTR, byval pwszCNGHashAlgid as LPCWSTR, byval pbComputedHash as UBYTE ptr, byval cbComputedHash as DWORD, byval pbSignature as UBYTE ptr, byval pcbSignature as DWORD ptr) as WINBOOL
type PFN_CRYPT_VERIFY_ENCODED_SIGNATURE_FUNC as function(byval dwCertEncodingType as DWORD, byval pPubKeyInfo as PCERT_PUBLIC_KEY_INFO, byval pSignatureAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pvDecodedSignPara as any ptr, byval pwszCNGPubKeyAlgid as LPCWSTR, byval pwszCNGHashAlgid as LPCWSTR, byval pbComputedHash as UBYTE ptr, byval cbComputedHash as DWORD, byval pbSignature as UBYTE ptr, byval cbSignature as DWORD) as WINBOOL
type HCRYPTDEFAULTCONTEXT as any ptr

type _CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA
	cOID as DWORD
	rgpszOID as LPSTR ptr
end type

type CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA as _CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA
type PCRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA as _CRYPT_DEFAULT_CONTEXT_MULTI_OID_PARA ptr
declare function CertVerifyRevocation(byval dwEncodingType as DWORD, byval dwRevType as DWORD, byval cContext as DWORD, byval rgpvContext as PVOID ptr, byval dwFlags as DWORD, byval pRevPara as PCERT_REVOCATION_PARA, byval pRevStatus as PCERT_REVOCATION_STATUS) as WINBOOL
declare function CertCompareIntegerBlob(byval pInt1 as PCRYPT_INTEGER_BLOB, byval pInt2 as PCRYPT_INTEGER_BLOB) as WINBOOL
declare function CertCompareCertificate(byval dwCertEncodingType as DWORD, byval pCertId1 as PCERT_INFO, byval pCertId2 as PCERT_INFO) as WINBOOL
declare function CertCompareCertificateName(byval dwCertEncodingType as DWORD, byval pCertName1 as PCERT_NAME_BLOB, byval pCertName2 as PCERT_NAME_BLOB) as WINBOOL
declare function CertIsRDNAttrsInCertificateName(byval dwCertEncodingType as DWORD, byval dwFlags as DWORD, byval pCertName as PCERT_NAME_BLOB, byval pRDN as PCERT_RDN) as WINBOOL
declare function CertComparePublicKeyInfo(byval dwCertEncodingType as DWORD, byval pPublicKey1 as PCERT_PUBLIC_KEY_INFO, byval pPublicKey2 as PCERT_PUBLIC_KEY_INFO) as WINBOOL
declare function CertGetPublicKeyLength(byval dwCertEncodingType as DWORD, byval pPublicKey as PCERT_PUBLIC_KEY_INFO) as DWORD
declare function CryptVerifyCertificateSignature(byval hCryptProv as HCRYPTPROV_LEGACY, byval dwCertEncodingType as DWORD, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval pPublicKey as PCERT_PUBLIC_KEY_INFO) as WINBOOL
declare function CryptVerifyCertificateSignatureEx(byval hCryptProv as HCRYPTPROV_LEGACY, byval dwCertEncodingType as DWORD, byval dwSubjectType as DWORD, byval pvSubject as any ptr, byval dwIssuerType as DWORD, byval pvIssuer as any ptr, byval dwFlags as DWORD, byval pvExtra as any ptr) as WINBOOL
declare function CertIsStrongHashToSign(byval pStrongSignPara as PCCERT_STRONG_SIGN_PARA, byval pwszCNGHashAlgid as LPCWSTR, byval pSigningCert as PCCERT_CONTEXT) as WINBOOL
declare function CryptHashToBeSigned(byval hCryptProv as HCRYPTPROV_LEGACY, byval dwCertEncodingType as DWORD, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL
declare function CryptHashCertificate(byval hCryptProv as HCRYPTPROV_LEGACY, byval Algid as ALG_ID, byval dwFlags as DWORD, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL

#if _WIN32_WINNT >= &h0600
	declare function CryptHashCertificate2(byval pwszCNGHashAlgid as LPCWSTR, byval dwFlags as DWORD, byval pvReserved as any ptr, byval pbEncoded as const UBYTE ptr, byval cbEncoded as DWORD, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL
#endif

declare function CryptSignCertificate(byval hCryptProvOrNCryptKey as HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, byval dwKeySpec as DWORD, byval dwCertEncodingType as DWORD, byval pbEncodedToBeSigned as const UBYTE ptr, byval cbEncodedToBeSigned as DWORD, byval pSignatureAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pvHashAuxInfo as const any ptr, byval pbSignature as UBYTE ptr, byval pcbSignature as DWORD ptr) as WINBOOL
declare function CryptSignAndEncodeCertificate(byval hCryptProvOrNCryptKey as HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, byval dwKeySpec as DWORD, byval dwCertEncodingType as DWORD, byval lpszStructType as LPCSTR, byval pvStructInfo as const any ptr, byval pSignatureAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pvHashAuxInfo as const any ptr, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr) as WINBOOL
declare function CertVerifyTimeValidity(byval pTimeToVerify as LPFILETIME, byval pCertInfo as PCERT_INFO) as LONG
declare function CertVerifyCRLTimeValidity(byval pTimeToVerify as LPFILETIME, byval pCrlInfo as PCRL_INFO) as LONG
declare function CertVerifyValidityNesting(byval pSubjectInfo as PCERT_INFO, byval pIssuerInfo as PCERT_INFO) as WINBOOL
declare function CertVerifyCRLRevocation(byval dwCertEncodingType as DWORD, byval pCertId as PCERT_INFO, byval cCrlInfo as DWORD, byval rgpCrlInfo as PCRL_INFO ptr) as WINBOOL
declare function CertAlgIdToOID(byval dwAlgId as DWORD) as LPCSTR
declare function CertOIDToAlgId(byval pszObjId as LPCSTR) as DWORD
declare function CertFindExtension(byval pszObjId as LPCSTR, byval cExtensions as DWORD, byval rgExtensions as CERT_EXTENSION ptr) as PCERT_EXTENSION
declare function CertFindAttribute(byval pszObjId as LPCSTR, byval cAttr as DWORD, byval rgAttr as CRYPT_ATTRIBUTE ptr) as PCRYPT_ATTRIBUTE
declare function CertFindRDNAttr(byval pszObjId as LPCSTR, byval pName as PCERT_NAME_INFO) as PCERT_RDN_ATTR
declare function CertGetIntendedKeyUsage(byval dwCertEncodingType as DWORD, byval pCertInfo as PCERT_INFO, byval pbKeyUsage as UBYTE ptr, byval cbKeyUsage as DWORD) as WINBOOL
declare function CryptInstallDefaultContext(byval hCryptProv as HCRYPTPROV, byval dwDefaultType as DWORD, byval pvDefaultPara as const any ptr, byval dwFlags as DWORD, byval pvReserved as any ptr, byval phDefaultContext as HCRYPTDEFAULTCONTEXT ptr) as WINBOOL
declare function CryptUninstallDefaultContext(byval hDefaultContext as HCRYPTDEFAULTCONTEXT, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
declare function CryptExportPublicKeyInfo(byval hCryptProvOrNCryptKey as HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, byval dwKeySpec as DWORD, byval dwCertEncodingType as DWORD, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval pcbInfo as DWORD ptr) as WINBOOL
declare function CryptExportPublicKeyInfoEx(byval hCryptProvOrNCryptKey as HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, byval dwKeySpec as DWORD, byval dwCertEncodingType as DWORD, byval pszPublicKeyObjId as LPSTR, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval pcbInfo as DWORD ptr) as WINBOOL
#define CRYPT_OID_EXPORT_PUBLIC_KEY_INFO_FUNC "CryptDllExportPublicKeyInfoEx"
#define CRYPT_OID_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC "CryptDllExportPublicKeyInfoEx2"
type PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_EX2_FUNC as function(byval hNCryptKey as NCRYPT_KEY_HANDLE, byval dwCertEncodingType as DWORD, byval pszPublicKeyObjId as LPSTR, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval pcbInfo as DWORD ptr) as WINBOOL

#if _WIN32_WINNT >= &h0601
	#define CRYPT_OID_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC "CryptDllExportPublicKeyInfoFromBCryptKeyHandle"
	type PFN_CRYPT_EXPORT_PUBLIC_KEY_INFO_FROM_BCRYPT_HANDLE_FUNC as function(byval hBCryptKey as BCRYPT_KEY_HANDLE, byval dwCertEncodingType as DWORD, byval pszPublicKeyObjId as LPSTR, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval pcbInfo as DWORD ptr) as WINBOOL
	declare function CryptExportPublicKeyInfoFromBCryptKeyHandle(byval hBCryptKey as BCRYPT_KEY_HANDLE, byval dwCertEncodingType as DWORD, byval pszPublicKeyObjId as LPSTR, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval pcbInfo as DWORD ptr) as WINBOOL
#endif

#define CRYPT_OID_IMPORT_PUBLIC_KEY_INFO_FUNC "CryptDllImportPublicKeyInfoEx"
#define CRYPT_OID_IMPORT_PRIVATE_KEY_INFO_FUNC "CryptDllImportPrivateKeyInfoEx"
#define CRYPT_OID_EXPORT_PRIVATE_KEY_INFO_FUNC "CryptDllExportPrivateKeyInfoEx"
const CRYPT_ACQUIRE_CACHE_FLAG = &h1
const CRYPT_ACQUIRE_USE_PROV_INFO_FLAG = &h2
const CRYPT_ACQUIRE_COMPARE_KEY_FLAG = &h4
const CRYPT_ACQUIRE_NO_HEALING = &h8
const CRYPT_ACQUIRE_SILENT_FLAG = &h40
const CRYPT_ACQUIRE_WINDOW_HANDLE_FLAG = &h80
const CRYPT_ACQUIRE_NCRYPT_KEY_FLAGS_MASK = &h70000
const CRYPT_ACQUIRE_ALLOW_NCRYPT_KEY_FLAG = &h10000
const CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG = &h20000
const CRYPT_ACQUIRE_ONLY_NCRYPT_KEY_FLAG = &h40000
const CRYPT_FIND_USER_KEYSET_FLAG = &h1
const CRYPT_FIND_MACHINE_KEYSET_FLAG = &h2
const CRYPT_FIND_SILENT_KEYSET_FLAG = &h40
const CRYPT_DELETE_KEYSET = CRYPT_DELETEKEYSET
type PFN_IMPORT_PRIV_KEY_FUNC as function(byval hCryptProv as HCRYPTPROV, byval pPrivateKeyInfo as CRYPT_PRIVATE_KEY_INFO ptr, byval dwFlags as DWORD, byval pvAuxInfo as any ptr) as WINBOOL
type PFN_EXPORT_PRIV_KEY_FUNC as function(byval hCryptProv as HCRYPTPROV, byval dwKeySpec as DWORD, byval pszPrivateKeyObjId as LPSTR, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pPrivateKeyInfo as CRYPT_PRIVATE_KEY_INFO ptr, byval pcbPrivateKeyInfo as DWORD ptr) as WINBOOL
declare function CryptImportPublicKeyInfo(byval hCryptProv as HCRYPTPROV, byval dwCertEncodingType as DWORD, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval phKey as HCRYPTKEY ptr) as WINBOOL
declare function CryptImportPublicKeyInfoEx(byval hCryptProv as HCRYPTPROV, byval dwCertEncodingType as DWORD, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval aiKeyAlg as ALG_ID, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval phKey as HCRYPTKEY ptr) as WINBOOL

#if _WIN32_WINNT >= &h0600
	#define CRYPT_OID_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC "CryptDllImportPublicKeyInfoEx2"
	type PFN_IMPORT_PUBLIC_KEY_INFO_EX2_FUNC as function(byval dwCertEncodingType as DWORD, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval phKey as BCRYPT_KEY_HANDLE ptr) as WINBOOL
	declare function CryptImportPublicKeyInfoEx2(byval dwCertEncodingType as DWORD, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval phKey as BCRYPT_KEY_HANDLE ptr) as WINBOOL
#endif

declare function CryptAcquireCertificatePrivateKey(byval pCert as PCCERT_CONTEXT, byval dwFlags as DWORD, byval pvParameters as any ptr, byval phCryptProvOrNCryptKey as HCRYPTPROV_OR_NCRYPT_KEY_HANDLE ptr, byval pdwKeySpec as DWORD ptr, byval pfCallerFreeProvOrNCryptKey as WINBOOL ptr) as WINBOOL
declare function CryptFindCertificateKeyProvInfo(byval pCert as PCCERT_CONTEXT, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
declare function CryptImportPKCS8(byval sPrivateKeyAndParams as CRYPT_PKCS8_IMPORT_PARAMS, byval dwFlags as DWORD, byval phCryptProv as HCRYPTPROV ptr, byval pvAuxInfo as any ptr) as WINBOOL
declare function CryptExportPKCS8(byval hCryptProv as HCRYPTPROV, byval dwKeySpec as DWORD, byval pszPrivateKeyObjId as LPSTR, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pbPrivateKeyBlob as UBYTE ptr, byval pcbPrivateKeyBlob as DWORD ptr) as WINBOOL
declare function CryptExportPKCS8Ex(byval psExportParams as CRYPT_PKCS8_EXPORT_PARAMS ptr, byval dwFlags as DWORD, byval pvAuxInfo as any ptr, byval pbPrivateKeyBlob as UBYTE ptr, byval pcbPrivateKeyBlob as DWORD ptr) as WINBOOL
declare function CryptHashPublicKeyInfo(byval hCryptProv as HCRYPTPROV_LEGACY, byval Algid as ALG_ID, byval dwFlags as DWORD, byval dwCertEncodingType as DWORD, byval pInfo as PCERT_PUBLIC_KEY_INFO, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL
declare function CertRDNValueToStrA(byval dwValueType as DWORD, byval pValue as PCERT_RDN_VALUE_BLOB, byval psz as LPSTR, byval csz as DWORD) as DWORD

#ifndef UNICODE
	declare function CertRDNValueToStr alias "CertRDNValueToStrA"(byval dwValueType as DWORD, byval pValue as PCERT_RDN_VALUE_BLOB, byval psz as LPSTR, byval csz as DWORD) as DWORD
#endif

declare function CertRDNValueToStrW(byval dwValueType as DWORD, byval pValue as PCERT_RDN_VALUE_BLOB, byval psz as LPWSTR, byval csz as DWORD) as DWORD

#ifdef UNICODE
	declare function CertRDNValueToStr alias "CertRDNValueToStrW"(byval dwValueType as DWORD, byval pValue as PCERT_RDN_VALUE_BLOB, byval psz as LPWSTR, byval csz as DWORD) as DWORD
#endif

declare function CertNameToStrA(byval dwCertEncodingType as DWORD, byval pName as PCERT_NAME_BLOB, byval dwStrType as DWORD, byval psz as LPSTR, byval csz as DWORD) as DWORD

#ifndef UNICODE
	declare function CertNameToStr alias "CertNameToStrA"(byval dwCertEncodingType as DWORD, byval pName as PCERT_NAME_BLOB, byval dwStrType as DWORD, byval psz as LPSTR, byval csz as DWORD) as DWORD
#endif

declare function CertNameToStrW(byval dwCertEncodingType as DWORD, byval pName as PCERT_NAME_BLOB, byval dwStrType as DWORD, byval psz as LPWSTR, byval csz as DWORD) as DWORD

#ifdef UNICODE
	declare function CertNameToStr alias "CertNameToStrW"(byval dwCertEncodingType as DWORD, byval pName as PCERT_NAME_BLOB, byval dwStrType as DWORD, byval psz as LPWSTR, byval csz as DWORD) as DWORD
#endif

const CERT_SIMPLE_NAME_STR = 1
const CERT_OID_NAME_STR = 2
const CERT_X500_NAME_STR = 3
const CERT_XML_NAME_STR = 4
const CERT_NAME_STR_DISABLE_IE4_UTF8_FLAG = &h10000
const CERT_NAME_STR_ENABLE_T61_UNICODE_FLAG = &h20000
const CERT_NAME_STR_ENABLE_UTF8_UNICODE_FLAG = &h40000
const CERT_NAME_STR_FORCE_UTF8_DIR_STR_FLAG = &h80000
const CERT_NAME_STR_FORWARD_FLAG = &h1000000
const CERT_NAME_STR_REVERSE_FLAG = &h2000000
const CERT_NAME_STR_COMMA_FLAG = &h4000000
const CERT_NAME_STR_CRLF_FLAG = &h8000000
const CERT_NAME_STR_NO_QUOTING_FLAG = &h10000000
const CERT_NAME_STR_NO_PLUS_FLAG = &h20000000
const CERT_NAME_STR_SEMICOLON_FLAG = &h40000000
const CERT_NAME_STR_DISABLE_UTF8_DIR_STR_FLAG = &h100000
const CERT_NAME_STR_ENABLE_PUNYCODE_FLAG = &h200000
declare function CertStrToNameA(byval dwCertEncodingType as DWORD, byval pszX500 as LPCSTR, byval dwStrType as DWORD, byval pvReserved as any ptr, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr, byval ppszError as LPCSTR ptr) as WINBOOL

#ifndef UNICODE
	declare function CertStrToName alias "CertStrToNameA"(byval dwCertEncodingType as DWORD, byval pszX500 as LPCSTR, byval dwStrType as DWORD, byval pvReserved as any ptr, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr, byval ppszError as LPCSTR ptr) as WINBOOL
#endif

declare function CertStrToNameW(byval dwCertEncodingType as DWORD, byval pszX500 as LPCWSTR, byval dwStrType as DWORD, byval pvReserved as any ptr, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr, byval ppszError as LPCWSTR ptr) as WINBOOL

#ifdef UNICODE
	declare function CertStrToName alias "CertStrToNameW"(byval dwCertEncodingType as DWORD, byval pszX500 as LPCWSTR, byval dwStrType as DWORD, byval pvReserved as any ptr, byval pbEncoded as UBYTE ptr, byval pcbEncoded as DWORD ptr, byval ppszError as LPCWSTR ptr) as WINBOOL
#endif

declare function CertGetNameStringA(byval pCertContext as PCCERT_CONTEXT, byval dwType as DWORD, byval dwFlags as DWORD, byval pvTypePara as any ptr, byval pszNameString as LPSTR, byval cchNameString as DWORD) as DWORD

#ifndef UNICODE
	declare function CertGetNameString alias "CertGetNameStringA"(byval pCertContext as PCCERT_CONTEXT, byval dwType as DWORD, byval dwFlags as DWORD, byval pvTypePara as any ptr, byval pszNameString as LPSTR, byval cchNameString as DWORD) as DWORD
#endif

declare function CertGetNameStringW(byval pCertContext as PCCERT_CONTEXT, byval dwType as DWORD, byval dwFlags as DWORD, byval pvTypePara as any ptr, byval pszNameString as LPWSTR, byval cchNameString as DWORD) as DWORD

#ifdef UNICODE
	declare function CertGetNameString alias "CertGetNameStringW"(byval pCertContext as PCCERT_CONTEXT, byval dwType as DWORD, byval dwFlags as DWORD, byval pvTypePara as any ptr, byval pszNameString as LPWSTR, byval cchNameString as DWORD) as DWORD
#endif

const CERT_NAME_EMAIL_TYPE = 1
const CERT_NAME_RDN_TYPE = 2
const CERT_NAME_ATTR_TYPE = 3
const CERT_NAME_SIMPLE_DISPLAY_TYPE = 4
const CERT_NAME_FRIENDLY_DISPLAY_TYPE = 5
const CERT_NAME_DNS_TYPE = 6
const CERT_NAME_URL_TYPE = 7
const CERT_NAME_UPN_TYPE = 8
const CERT_NAME_ISSUER_FLAG = &h1
const CERT_NAME_DISABLE_IE4_UTF8_FLAG = &h10000
const CERT_NAME_SEARCH_ALL_NAMES_FLAG = &h2
type PFN_CRYPT_GET_SIGNER_CERTIFICATE as function(byval pvGetArg as any ptr, byval dwCertEncodingType as DWORD, byval pSignerId as PCERT_INFO, byval hMsgCertStore as HCERTSTORE) as PCCERT_CONTEXT

type _CRYPT_SIGN_MESSAGE_PARA
	cbSize as DWORD
	dwMsgEncodingType as DWORD
	pSigningCert as PCCERT_CONTEXT
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvHashAuxInfo as any ptr
	cMsgCert as DWORD
	rgpMsgCert as PCCERT_CONTEXT ptr
	cMsgCrl as DWORD
	rgpMsgCrl as PCCRL_CONTEXT ptr
	cAuthAttr as DWORD
	rgAuthAttr as PCRYPT_ATTRIBUTE
	cUnauthAttr as DWORD
	rgUnauthAttr as PCRYPT_ATTRIBUTE
	dwFlags as DWORD
	dwInnerContentType as DWORD
end type

type CRYPT_SIGN_MESSAGE_PARA as _CRYPT_SIGN_MESSAGE_PARA
type PCRYPT_SIGN_MESSAGE_PARA as _CRYPT_SIGN_MESSAGE_PARA ptr
const CRYPT_MESSAGE_BARE_CONTENT_OUT_FLAG = &h1
const CRYPT_MESSAGE_ENCAPSULATED_CONTENT_OUT_FLAG = &h2
const CRYPT_MESSAGE_KEYID_SIGNER_FLAG = &h4
const CRYPT_MESSAGE_SILENT_KEYSET_FLAG = &h40

type _CRYPT_VERIFY_MESSAGE_PARA
	cbSize as DWORD
	dwMsgAndCertEncodingType as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	pfnGetSignerCertificate as PFN_CRYPT_GET_SIGNER_CERTIFICATE
	pvGetArg as any ptr
end type

type CRYPT_VERIFY_MESSAGE_PARA as _CRYPT_VERIFY_MESSAGE_PARA
type PCRYPT_VERIFY_MESSAGE_PARA as _CRYPT_VERIFY_MESSAGE_PARA ptr

type _CRYPT_ENCRYPT_MESSAGE_PARA
	cbSize as DWORD
	dwMsgEncodingType as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	ContentEncryptionAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvEncryptionAuxInfo as any ptr
	dwFlags as DWORD
	dwInnerContentType as DWORD
end type

type CRYPT_ENCRYPT_MESSAGE_PARA as _CRYPT_ENCRYPT_MESSAGE_PARA
type PCRYPT_ENCRYPT_MESSAGE_PARA as _CRYPT_ENCRYPT_MESSAGE_PARA ptr
const CRYPT_MESSAGE_KEYID_RECIPIENT_FLAG = &h4

type _CRYPT_DECRYPT_MESSAGE_PARA
	cbSize as DWORD
	dwMsgAndCertEncodingType as DWORD
	cCertStore as DWORD
	rghCertStore as HCERTSTORE ptr
end type

type CRYPT_DECRYPT_MESSAGE_PARA as _CRYPT_DECRYPT_MESSAGE_PARA
type PCRYPT_DECRYPT_MESSAGE_PARA as _CRYPT_DECRYPT_MESSAGE_PARA ptr

type _CRYPT_HASH_MESSAGE_PARA
	cbSize as DWORD
	dwMsgEncodingType as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvHashAuxInfo as any ptr
end type

type CRYPT_HASH_MESSAGE_PARA as _CRYPT_HASH_MESSAGE_PARA
type PCRYPT_HASH_MESSAGE_PARA as _CRYPT_HASH_MESSAGE_PARA ptr

type _CRYPT_KEY_SIGN_MESSAGE_PARA
	cbSize as DWORD
	dwMsgAndCertEncodingType as DWORD

	union
		hCryptProv as HCRYPTPROV
		hNCryptKey as NCRYPT_KEY_HANDLE
	end union

	dwKeySpec as DWORD
	HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
	pvHashAuxInfo as any ptr
	PubKeyAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
end type

type CRYPT_KEY_SIGN_MESSAGE_PARA as _CRYPT_KEY_SIGN_MESSAGE_PARA
type PCRYPT_KEY_SIGN_MESSAGE_PARA as _CRYPT_KEY_SIGN_MESSAGE_PARA ptr

type _CRYPT_KEY_VERIFY_MESSAGE_PARA
	cbSize as DWORD
	dwMsgEncodingType as DWORD
	hCryptProv as HCRYPTPROV_LEGACY
end type

type CRYPT_KEY_VERIFY_MESSAGE_PARA as _CRYPT_KEY_VERIFY_MESSAGE_PARA
type PCRYPT_KEY_VERIFY_MESSAGE_PARA as _CRYPT_KEY_VERIFY_MESSAGE_PARA ptr

type _CERT_CHAIN
	cCerts as DWORD
	certs as PCERT_BLOB
	keyLocatorInfo as CRYPT_KEY_PROV_INFO
end type

type CERT_CHAIN as _CERT_CHAIN
type PCERT_CHAIN as _CERT_CHAIN ptr
declare function CryptSignMessage(byval pSignPara as PCRYPT_SIGN_MESSAGE_PARA, byval fDetachedSignature as WINBOOL, byval cToBeSigned as DWORD, byval rgpbToBeSigned as const UBYTE ptr ptr, byval rgcbToBeSigned as DWORD ptr, byval pbSignedBlob as UBYTE ptr, byval pcbSignedBlob as DWORD ptr) as WINBOOL
declare function CryptVerifyMessageSignature(byval pVerifyPara as PCRYPT_VERIFY_MESSAGE_PARA, byval dwSignerIndex as DWORD, byval pbSignedBlob as const UBYTE ptr, byval cbSignedBlob as DWORD, byval pbDecoded as UBYTE ptr, byval pcbDecoded as DWORD ptr, byval ppSignerCert as PCCERT_CONTEXT ptr) as WINBOOL
declare function CryptGetMessageSignerCount(byval dwMsgEncodingType as DWORD, byval pbSignedBlob as const UBYTE ptr, byval cbSignedBlob as DWORD) as LONG
declare function CryptGetMessageCertificates(byval dwMsgAndCertEncodingType as DWORD, byval hCryptProv as HCRYPTPROV_LEGACY, byval dwFlags as DWORD, byval pbSignedBlob as const UBYTE ptr, byval cbSignedBlob as DWORD) as HCERTSTORE
declare function CryptVerifyDetachedMessageSignature(byval pVerifyPara as PCRYPT_VERIFY_MESSAGE_PARA, byval dwSignerIndex as DWORD, byval pbDetachedSignBlob as const UBYTE ptr, byval cbDetachedSignBlob as DWORD, byval cToBeSigned as DWORD, byval rgpbToBeSigned as const UBYTE ptr ptr, byval rgcbToBeSigned as DWORD ptr, byval ppSignerCert as PCCERT_CONTEXT ptr) as WINBOOL
declare function CryptEncryptMessage(byval pEncryptPara as PCRYPT_ENCRYPT_MESSAGE_PARA, byval cRecipientCert as DWORD, byval rgpRecipientCert as PCCERT_CONTEXT ptr, byval pbToBeEncrypted as const UBYTE ptr, byval cbToBeEncrypted as DWORD, byval pbEncryptedBlob as UBYTE ptr, byval pcbEncryptedBlob as DWORD ptr) as WINBOOL
declare function CryptDecryptMessage(byval pDecryptPara as PCRYPT_DECRYPT_MESSAGE_PARA, byval pbEncryptedBlob as const UBYTE ptr, byval cbEncryptedBlob as DWORD, byval pbDecrypted as UBYTE ptr, byval pcbDecrypted as DWORD ptr, byval ppXchgCert as PCCERT_CONTEXT ptr) as WINBOOL
declare function CryptSignAndEncryptMessage(byval pSignPara as PCRYPT_SIGN_MESSAGE_PARA, byval pEncryptPara as PCRYPT_ENCRYPT_MESSAGE_PARA, byval cRecipientCert as DWORD, byval rgpRecipientCert as PCCERT_CONTEXT ptr, byval pbToBeSignedAndEncrypted as const UBYTE ptr, byval cbToBeSignedAndEncrypted as DWORD, byval pbSignedAndEncryptedBlob as UBYTE ptr, byval pcbSignedAndEncryptedBlob as DWORD ptr) as WINBOOL
declare function CryptDecryptAndVerifyMessageSignature(byval pDecryptPara as PCRYPT_DECRYPT_MESSAGE_PARA, byval pVerifyPara as PCRYPT_VERIFY_MESSAGE_PARA, byval dwSignerIndex as DWORD, byval pbEncryptedBlob as const UBYTE ptr, byval cbEncryptedBlob as DWORD, byval pbDecrypted as UBYTE ptr, byval pcbDecrypted as DWORD ptr, byval ppXchgCert as PCCERT_CONTEXT ptr, byval ppSignerCert as PCCERT_CONTEXT ptr) as WINBOOL
declare function CryptDecodeMessage(byval dwMsgTypeFlags as DWORD, byval pDecryptPara as PCRYPT_DECRYPT_MESSAGE_PARA, byval pVerifyPara as PCRYPT_VERIFY_MESSAGE_PARA, byval dwSignerIndex as DWORD, byval pbEncodedBlob as const UBYTE ptr, byval cbEncodedBlob as DWORD, byval dwPrevInnerContentType as DWORD, byval pdwMsgType as DWORD ptr, byval pdwInnerContentType as DWORD ptr, byval pbDecoded as UBYTE ptr, byval pcbDecoded as DWORD ptr, byval ppXchgCert as PCCERT_CONTEXT ptr, byval ppSignerCert as PCCERT_CONTEXT ptr) as WINBOOL
declare function CryptHashMessage(byval pHashPara as PCRYPT_HASH_MESSAGE_PARA, byval fDetachedHash as WINBOOL, byval cToBeHashed as DWORD, byval rgpbToBeHashed as const UBYTE ptr ptr, byval rgcbToBeHashed as DWORD ptr, byval pbHashedBlob as UBYTE ptr, byval pcbHashedBlob as DWORD ptr, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL
declare function CryptVerifyMessageHash(byval pHashPara as PCRYPT_HASH_MESSAGE_PARA, byval pbHashedBlob as UBYTE ptr, byval cbHashedBlob as DWORD, byval pbToBeHashed as UBYTE ptr, byval pcbToBeHashed as DWORD ptr, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL
declare function CryptVerifyDetachedMessageHash(byval pHashPara as PCRYPT_HASH_MESSAGE_PARA, byval pbDetachedHashBlob as UBYTE ptr, byval cbDetachedHashBlob as DWORD, byval cToBeHashed as DWORD, byval rgpbToBeHashed as const UBYTE ptr ptr, byval rgcbToBeHashed as DWORD ptr, byval pbComputedHash as UBYTE ptr, byval pcbComputedHash as DWORD ptr) as WINBOOL
declare function CryptSignMessageWithKey(byval pSignPara as PCRYPT_KEY_SIGN_MESSAGE_PARA, byval pbToBeSigned as const UBYTE ptr, byval cbToBeSigned as DWORD, byval pbSignedBlob as UBYTE ptr, byval pcbSignedBlob as DWORD ptr) as WINBOOL
declare function CryptVerifyMessageSignatureWithKey(byval pVerifyPara as PCRYPT_KEY_VERIFY_MESSAGE_PARA, byval pPublicKeyInfo as PCERT_PUBLIC_KEY_INFO, byval pbSignedBlob as const UBYTE ptr, byval cbSignedBlob as DWORD, byval pbDecoded as UBYTE ptr, byval pcbDecoded as DWORD ptr) as WINBOOL
declare function CertOpenSystemStoreA(byval hProv as HCRYPTPROV_LEGACY, byval szSubsystemProtocol as LPCSTR) as HCERTSTORE

#ifndef UNICODE
	declare function CertOpenSystemStore alias "CertOpenSystemStoreA"(byval hProv as HCRYPTPROV_LEGACY, byval szSubsystemProtocol as LPCSTR) as HCERTSTORE
#endif

declare function CertOpenSystemStoreW(byval hProv as HCRYPTPROV_LEGACY, byval szSubsystemProtocol as LPCWSTR) as HCERTSTORE

#ifdef UNICODE
	declare function CertOpenSystemStore alias "CertOpenSystemStoreW"(byval hProv as HCRYPTPROV_LEGACY, byval szSubsystemProtocol as LPCWSTR) as HCERTSTORE
#endif

declare function CertAddEncodedCertificateToSystemStoreA(byval szCertStoreName as LPCSTR, byval pbCertEncoded as const UBYTE ptr, byval cbCertEncoded as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CertAddEncodedCertificateToSystemStore alias "CertAddEncodedCertificateToSystemStoreA"(byval szCertStoreName as LPCSTR, byval pbCertEncoded as const UBYTE ptr, byval cbCertEncoded as DWORD) as WINBOOL
#endif

declare function CertAddEncodedCertificateToSystemStoreW(byval szCertStoreName as LPCWSTR, byval pbCertEncoded as const UBYTE ptr, byval cbCertEncoded as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CertAddEncodedCertificateToSystemStore alias "CertAddEncodedCertificateToSystemStoreW"(byval szCertStoreName as LPCWSTR, byval pbCertEncoded as const UBYTE ptr, byval cbCertEncoded as DWORD) as WINBOOL
#endif

declare function FindCertsByIssuer(byval pCertChains as PCERT_CHAIN, byval pcbCertChains as DWORD ptr, byval pcCertChains as DWORD ptr, byval pbEncodedIssuerName as UBYTE ptr, byval cbEncodedIssuerName as DWORD, byval pwszPurpose as LPCWSTR, byval dwKeySpec as DWORD) as HRESULT
declare function CryptQueryObject(byval dwObjectType as DWORD, byval pvObject as const any ptr, byval dwExpectedContentTypeFlags as DWORD, byval dwExpectedFormatTypeFlags as DWORD, byval dwFlags as DWORD, byval pdwMsgAndCertEncodingType as DWORD ptr, byval pdwContentType as DWORD ptr, byval pdwFormatType as DWORD ptr, byval phCertStore as HCERTSTORE ptr, byval phMsg as HCRYPTMSG ptr, byval ppvContext as const any ptr ptr) as WINBOOL
const CERT_QUERY_OBJECT_FILE = &h1
const CERT_QUERY_OBJECT_BLOB = &h2
const CERT_QUERY_CONTENT_CERT = 1
const CERT_QUERY_CONTENT_CTL = 2
const CERT_QUERY_CONTENT_CRL = 3
const CERT_QUERY_CONTENT_SERIALIZED_STORE = 4
const CERT_QUERY_CONTENT_SERIALIZED_CERT = 5
const CERT_QUERY_CONTENT_SERIALIZED_CTL = 6
const CERT_QUERY_CONTENT_SERIALIZED_CRL = 7
const CERT_QUERY_CONTENT_PKCS7_SIGNED = 8
const CERT_QUERY_CONTENT_PKCS7_UNSIGNED = 9
const CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED = 10
const CERT_QUERY_CONTENT_PKCS10 = 11
const CERT_QUERY_CONTENT_PFX = 12
const CERT_QUERY_CONTENT_CERT_PAIR = 13
const CERT_QUERY_CONTENT_PFX_AND_LOAD = 14
const CERT_QUERY_CONTENT_FLAG_CERT = 1 shl CERT_QUERY_CONTENT_CERT
const CERT_QUERY_CONTENT_FLAG_CTL = 1 shl CERT_QUERY_CONTENT_CTL
const CERT_QUERY_CONTENT_FLAG_CRL = 1 shl CERT_QUERY_CONTENT_CRL
const CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE = 1 shl CERT_QUERY_CONTENT_SERIALIZED_STORE
const CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT = 1 shl CERT_QUERY_CONTENT_SERIALIZED_CERT
const CERT_QUERY_CONTENT_FLAG_SERIALIZED_CTL = 1 shl CERT_QUERY_CONTENT_SERIALIZED_CTL
const CERT_QUERY_CONTENT_FLAG_SERIALIZED_CRL = 1 shl CERT_QUERY_CONTENT_SERIALIZED_CRL
const CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED = 1 shl CERT_QUERY_CONTENT_PKCS7_SIGNED
const CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED = 1 shl CERT_QUERY_CONTENT_PKCS7_UNSIGNED
const CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED = 1 shl CERT_QUERY_CONTENT_PKCS7_SIGNED_EMBED
const CERT_QUERY_CONTENT_FLAG_PKCS10 = 1 shl CERT_QUERY_CONTENT_PKCS10
const CERT_QUERY_CONTENT_FLAG_PFX = 1 shl CERT_QUERY_CONTENT_PFX
const CERT_QUERY_CONTENT_FLAG_CERT_PAIR = 1 shl CERT_QUERY_CONTENT_CERT_PAIR
const CERT_QUERY_CONTENT_FLAG_PFX_AND_LOAD = 1 shl CERT_QUERY_CONTENT_PFX_AND_LOAD
const CERT_QUERY_CONTENT_FLAG_ALL = (((((((((((CERT_QUERY_CONTENT_FLAG_CERT or CERT_QUERY_CONTENT_FLAG_CTL) or CERT_QUERY_CONTENT_FLAG_CRL) or CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE) or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT) or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CTL) or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CRL) or CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED) or CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED) or CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED_EMBED) or CERT_QUERY_CONTENT_FLAG_PKCS10) or CERT_QUERY_CONTENT_FLAG_PFX) or CERT_QUERY_CONTENT_FLAG_CERT_PAIR
const CERT_QUERY_CONTENT_FLAG_ALL_ISSUER_CERT = (((CERT_QUERY_CONTENT_FLAG_CERT or CERT_QUERY_CONTENT_FLAG_SERIALIZED_STORE) or CERT_QUERY_CONTENT_FLAG_SERIALIZED_CERT) or CERT_QUERY_CONTENT_FLAG_PKCS7_SIGNED) or CERT_QUERY_CONTENT_FLAG_PKCS7_UNSIGNED
const CERT_QUERY_FORMAT_BINARY = 1
const CERT_QUERY_FORMAT_BASE64_ENCODED = 2
const CERT_QUERY_FORMAT_ASN_ASCII_HEX_ENCODED = 3
const CERT_QUERY_FORMAT_FLAG_BINARY = 1 shl CERT_QUERY_FORMAT_BINARY
const CERT_QUERY_FORMAT_FLAG_BASE64_ENCODED = 1 shl CERT_QUERY_FORMAT_BASE64_ENCODED
const CERT_QUERY_FORMAT_FLAG_ASN_ASCII_HEX_ENCODED = 1 shl CERT_QUERY_FORMAT_ASN_ASCII_HEX_ENCODED
const CERT_QUERY_FORMAT_FLAG_ALL = (CERT_QUERY_FORMAT_FLAG_BINARY or CERT_QUERY_FORMAT_FLAG_BASE64_ENCODED) or CERT_QUERY_FORMAT_FLAG_ASN_ASCII_HEX_ENCODED

type HCRYPTASYNC as HANDLE
type PHCRYPTASYNC as HANDLE ptr
type PFN_CRYPT_ASYNC_PARAM_FREE_FUNC as sub(byval pszParamOid as LPSTR, byval pvParam as LPVOID)

declare function CryptMemAlloc(byval cbSize as ULONG) as LPVOID
declare function CryptMemRealloc(byval pv as LPVOID, byval cbSize as ULONG) as LPVOID
declare sub CryptMemFree(byval pv as LPVOID)
declare function CryptCreateAsyncHandle(byval dwFlags as DWORD, byval phAsync as PHCRYPTASYNC) as WINBOOL
declare function CryptSetAsyncParam(byval hAsync as HCRYPTASYNC, byval pszParamOid as LPSTR, byval pvParam as LPVOID, byval pfnFree as PFN_CRYPT_ASYNC_PARAM_FREE_FUNC) as WINBOOL
declare function CryptGetAsyncParam(byval hAsync as HCRYPTASYNC, byval pszParamOid as LPSTR, byval ppvParam as LPVOID ptr, byval ppfnFree as PFN_CRYPT_ASYNC_PARAM_FREE_FUNC ptr) as WINBOOL
declare function CryptCloseAsyncHandle(byval hAsync as HCRYPTASYNC) as WINBOOL

type _CRYPT_BLOB_ARRAY
	cBlob as DWORD
	rgBlob as PCRYPT_DATA_BLOB
end type

type CRYPT_BLOB_ARRAY as _CRYPT_BLOB_ARRAY
type PCRYPT_BLOB_ARRAY as _CRYPT_BLOB_ARRAY ptr

type _CRYPT_CREDENTIALS
	cbSize as DWORD
	pszCredentialsOid as LPCSTR
	pvCredentials as LPVOID
end type

type CRYPT_CREDENTIALS as _CRYPT_CREDENTIALS
type PCRYPT_CREDENTIALS as _CRYPT_CREDENTIALS ptr
const CREDENTIAL_OID_PASSWORD_CREDENTIALS_A = cast(LPCSTR, 1)
const CREDENTIAL_OID_PASSWORD_CREDENTIALS_W = cast(LPCSTR, 2)

#ifdef UNICODE
	const CREDENTIAL_OID_PASSWORD_CREDENTIALS = CREDENTIAL_OID_PASSWORD_CREDENTIALS_W
#else
	const CREDENTIAL_OID_PASSWORD_CREDENTIALS = CREDENTIAL_OID_PASSWORD_CREDENTIALS_A
#endif

type _CRYPT_PASSWORD_CREDENTIALSA
	cbSize as DWORD
	pszUsername as LPSTR
	pszPassword as LPSTR
end type

type CRYPT_PASSWORD_CREDENTIALSA as _CRYPT_PASSWORD_CREDENTIALSA
type PCRYPT_PASSWORD_CREDENTIALSA as _CRYPT_PASSWORD_CREDENTIALSA ptr

type _CRYPT_PASSWORD_CREDENTIALSW
	cbSize as DWORD
	pszUsername as LPWSTR
	pszPassword as LPWSTR
end type

type CRYPT_PASSWORD_CREDENTIALSW as _CRYPT_PASSWORD_CREDENTIALSW
type PCRYPT_PASSWORD_CREDENTIALSW as _CRYPT_PASSWORD_CREDENTIALSW ptr

#ifdef UNICODE
	type CRYPT_PASSWORD_CREDENTIALS as CRYPT_PASSWORD_CREDENTIALSW
	type PCRYPT_PASSWORD_CREDENTIALS as PCRYPT_PASSWORD_CREDENTIALSW
#else
	type CRYPT_PASSWORD_CREDENTIALS as CRYPT_PASSWORD_CREDENTIALSA
	type PCRYPT_PASSWORD_CREDENTIALS as PCRYPT_PASSWORD_CREDENTIALSA
#endif

#define SCHEME_OID_RETRIEVE_ENCODED_OBJECT_FUNC "SchemeDllRetrieveEncodedObject"
#define SCHEME_OID_RETRIEVE_ENCODED_OBJECTW_FUNC "SchemeDllRetrieveEncodedObjectW"
#define CONTEXT_OID_CREATE_OBJECT_CONTEXT_FUNC "ContextDllCreateObjectContext"
type PFN_FREE_ENCODED_OBJECT_FUNC as sub(byval pszObjectOid as LPCSTR, byval pObject as PCRYPT_BLOB_ARRAY, byval pvFreeContext as LPVOID)
const CONTEXT_OID_CERTIFICATE = cast(LPCSTR, 1)
const CONTEXT_OID_CRL = cast(LPCSTR, 2)
const CONTEXT_OID_CTL = cast(LPCSTR, 3)
const CONTEXT_OID_PKCS7 = cast(LPCSTR, 4)
const CONTEXT_OID_CAPI2_ANY = cast(LPCSTR, 5)
const CONTEXT_OID_OCSP_RESP = cast(LPCSTR, 6)
const CRYPT_RETRIEVE_MULTIPLE_OBJECTS = &h1
const CRYPT_CACHE_ONLY_RETRIEVAL = &h2
const CRYPT_WIRE_ONLY_RETRIEVAL = &h4
const CRYPT_DONT_CACHE_RESULT = &h8
const CRYPT_ASYNC_RETRIEVAL = &h10
const CRYPT_VERIFY_CONTEXT_SIGNATURE = &h20
const CRYPT_VERIFY_DATA_HASH = &h40
const CRYPT_KEEP_TIME_VALID = &h80
const CRYPT_DONT_VERIFY_SIGNATURE = &h100
const CRYPT_DONT_CHECK_TIME_VALIDITY = &h200
const CRYPT_CHECK_FRESHNESS_TIME_VALIDITY = &h400
const CRYPT_ACCUMULATIVE_TIMEOUT = &h800
const CRYPT_STICKY_CACHE_RETRIEVAL = &h1000
const CRYPT_LDAP_SCOPE_BASE_ONLY_RETRIEVAL = &h2000
const CRYPT_OFFLINE_CHECK_RETRIEVAL = &h4000
const CRYPT_LDAP_INSERT_ENTRY_ATTRIBUTE = &h8000
const CRYPT_LDAP_SIGN_RETRIEVAL = &h10000
const CRYPT_NO_AUTH_RETRIEVAL = &h20000
const CRYPT_LDAP_AREC_EXCLUSIVE_RETRIEVAL = &h40000
const CRYPT_AIA_RETRIEVAL = &h80000
const CRYPT_HTTP_POST_RETRIEVAL = &h100000
const CRYPT_PROXY_CACHE_RETRIEVAL = &h200000
const CRYPT_NOT_MODIFIED_RETRIEVAL = &h400000
const CRYPT_ENABLE_SSL_REVOCATION_RETRIEVAL = &h800000
const CRYPT_OCSP_ONLY_RETRIEVAL = &h1000000
const CRYPT_NO_OCSP_FAILOVER_TO_CRL_RETRIEVAL = &h2000000
const CRYPT_RANDOM_QUERY_STRING_RETRIEVAL = &h4000000

type _CRYPTNET_URL_CACHE_PRE_FETCH_INFO
	cbSize as DWORD
	dwObjectType as DWORD
	dwError as DWORD
	dwReserved as DWORD
	ThisUpdateTime as FILETIME
	NextUpdateTime as FILETIME
	PublishTime as FILETIME
end type

type CRYPTNET_URL_CACHE_PRE_FETCH_INFO as _CRYPTNET_URL_CACHE_PRE_FETCH_INFO
type PCRYPTNET_URL_CACHE_PRE_FETCH_INFO as _CRYPTNET_URL_CACHE_PRE_FETCH_INFO ptr
const CRYPTNET_URL_CACHE_PRE_FETCH_NONE = 0
const CRYPTNET_URL_CACHE_PRE_FETCH_BLOB = 1
const CRYPTNET_URL_CACHE_PRE_FETCH_CRL = 2
const CRYPTNET_URL_CACHE_PRE_FETCH_OCSP = 3
const CRYPTNET_URL_CACHE_PRE_FETCH_AUTOROOT_CAB = 5
const CRYPTNET_URL_CACHE_PRE_FETCH_DISALLOWED_CERT_CAB = 6

type _CRYPTNET_URL_CACHE_FLUSH_INFO
	cbSize as DWORD
	dwExemptSeconds as DWORD
	ExpireTime as FILETIME
end type

type CRYPTNET_URL_CACHE_FLUSH_INFO as _CRYPTNET_URL_CACHE_FLUSH_INFO
type PCRYPTNET_URL_CACHE_FLUSH_INFO as _CRYPTNET_URL_CACHE_FLUSH_INFO ptr
const CRYPTNET_URL_CACHE_DEFAULT_FLUSH = 0
const CRYPTNET_URL_CACHE_DISABLE_FLUSH = &hffffffff

type _CRYPTNET_URL_CACHE_RESPONSE_INFO
	cbSize as DWORD
	wResponseType as WORD
	wResponseFlags as WORD
	LastModifiedTime as FILETIME
	dwMaxAge as DWORD
	pwszETag as LPCWSTR
	dwProxyId as DWORD
end type

type CRYPTNET_URL_CACHE_RESPONSE_INFO as _CRYPTNET_URL_CACHE_RESPONSE_INFO
type PCRYPTNET_URL_CACHE_RESPONSE_INFO as _CRYPTNET_URL_CACHE_RESPONSE_INFO ptr
const CRYPTNET_URL_CACHE_RESPONSE_NONE = 0
const CRYPTNET_URL_CACHE_RESPONSE_HTTP = 1
const CRYPTNET_URL_CACHE_RESPONSE_VALIDATED = &h8000

type _CRYPT_RETRIEVE_AUX_INFO
	cbSize as DWORD
	pLastSyncTime as FILETIME ptr
	dwMaxUrlRetrievalByteCount as DWORD
	pPreFetchInfo as PCRYPTNET_URL_CACHE_PRE_FETCH_INFO
	pFlushInfo as PCRYPTNET_URL_CACHE_FLUSH_INFO
	ppResponseInfo as PCRYPTNET_URL_CACHE_RESPONSE_INFO ptr
	pwszCacheFileNamePrefix as LPWSTR
	pftCacheResync as LPFILETIME
	fProxyCacheRetrieval as WINBOOL
	dwHttpStatusCode as DWORD
end type

type CRYPT_RETRIEVE_AUX_INFO as _CRYPT_RETRIEVE_AUX_INFO
type PCRYPT_RETRIEVE_AUX_INFO as _CRYPT_RETRIEVE_AUX_INFO ptr
declare function CryptRetrieveObjectByUrlA(byval pszUrl as LPCSTR, byval pszObjectOid as LPCSTR, byval dwRetrievalFlags as DWORD, byval dwTimeout as DWORD, byval ppvObject as LPVOID ptr, byval hAsyncRetrieve as HCRYPTASYNC, byval pCredentials as PCRYPT_CREDENTIALS, byval pvVerify as LPVOID, byval pAuxInfo as PCRYPT_RETRIEVE_AUX_INFO) as WINBOOL
declare function CryptRetrieveObjectByUrlW(byval pszUrl as LPCWSTR, byval pszObjectOid as LPCSTR, byval dwRetrievalFlags as DWORD, byval dwTimeout as DWORD, byval ppvObject as LPVOID ptr, byval hAsyncRetrieve as HCRYPTASYNC, byval pCredentials as PCRYPT_CREDENTIALS, byval pvVerify as LPVOID, byval pAuxInfo as PCRYPT_RETRIEVE_AUX_INFO) as WINBOOL

#ifdef UNICODE
	declare function CryptRetrieveObjectByUrl alias "CryptRetrieveObjectByUrlW"(byval pszUrl as LPCWSTR, byval pszObjectOid as LPCSTR, byval dwRetrievalFlags as DWORD, byval dwTimeout as DWORD, byval ppvObject as LPVOID ptr, byval hAsyncRetrieve as HCRYPTASYNC, byval pCredentials as PCRYPT_CREDENTIALS, byval pvVerify as LPVOID, byval pAuxInfo as PCRYPT_RETRIEVE_AUX_INFO) as WINBOOL
#else
	declare function CryptRetrieveObjectByUrl alias "CryptRetrieveObjectByUrlA"(byval pszUrl as LPCSTR, byval pszObjectOid as LPCSTR, byval dwRetrievalFlags as DWORD, byval dwTimeout as DWORD, byval ppvObject as LPVOID ptr, byval hAsyncRetrieve as HCRYPTASYNC, byval pCredentials as PCRYPT_CREDENTIALS, byval pvVerify as LPVOID, byval pAuxInfo as PCRYPT_RETRIEVE_AUX_INFO) as WINBOOL
#endif

type PFN_CRYPT_CANCEL_RETRIEVAL as function(byval dwFlags as DWORD, byval pvArg as any ptr) as WINBOOL
declare function CryptInstallCancelRetrieval(byval pfnCancel as PFN_CRYPT_CANCEL_RETRIEVAL, byval pvArg as const any ptr, byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
declare function CryptUninstallCancelRetrieval(byval dwFlags as DWORD, byval pvReserved as any ptr) as WINBOOL
declare function CryptCancelAsyncRetrieval(byval hAsyncRetrieval as HCRYPTASYNC) as WINBOOL
const CRYPT_PARAM_ASYNC_RETRIEVAL_COMPLETION = cast(LPCSTR, 1)
type PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC as sub(byval pvCompletion as LPVOID, byval dwCompletionCode as DWORD, byval pszUrl as LPCSTR, byval pszObjectOid as LPSTR, byval pvObject as LPVOID)

type _CRYPT_ASYNC_RETRIEVAL_COMPLETION
	pfnCompletion as PFN_CRYPT_ASYNC_RETRIEVAL_COMPLETION_FUNC
	pvCompletion as LPVOID
end type

type CRYPT_ASYNC_RETRIEVAL_COMPLETION as _CRYPT_ASYNC_RETRIEVAL_COMPLETION
type PCRYPT_ASYNC_RETRIEVAL_COMPLETION as _CRYPT_ASYNC_RETRIEVAL_COMPLETION ptr
const CRYPT_PARAM_CANCEL_ASYNC_RETRIEVAL = cast(LPCSTR, 2)
type PFN_CANCEL_ASYNC_RETRIEVAL_FUNC as function(byval hAsyncRetrieve as HCRYPTASYNC) as WINBOOL
const CRYPT_GET_URL_FROM_PROPERTY = &h1
const CRYPT_GET_URL_FROM_EXTENSION = &h2
const CRYPT_GET_URL_FROM_UNAUTH_ATTRIBUTE = &h4
const CRYPT_GET_URL_FROM_AUTH_ATTRIBUTE = &h8

type _CRYPT_URL_ARRAY
	cUrl as DWORD
	rgwszUrl as LPWSTR ptr
end type

type CRYPT_URL_ARRAY as _CRYPT_URL_ARRAY
type PCRYPT_URL_ARRAY as _CRYPT_URL_ARRAY ptr

type _CRYPT_URL_INFO
	cbSize as DWORD
	dwSyncDeltaTime as DWORD
	cGroup as DWORD
	rgcGroupEntry as DWORD ptr
end type

type CRYPT_URL_INFO as _CRYPT_URL_INFO
type PCRYPT_URL_INFO as _CRYPT_URL_INFO ptr
declare function CryptGetObjectUrl(byval pszUrlOid as LPCSTR, byval pvPara as LPVOID, byval dwFlags as DWORD, byval pUrlArray as PCRYPT_URL_ARRAY, byval pcbUrlArray as DWORD ptr, byval pUrlInfo as PCRYPT_URL_INFO, byval pcbUrlInfo as DWORD ptr, byval pvReserved as LPVOID) as WINBOOL
#define URL_OID_GET_OBJECT_URL_FUNC "UrlDllGetObjectUrl"
const URL_OID_CERTIFICATE_ISSUER = cast(LPCSTR, 1)
const URL_OID_CERTIFICATE_CRL_DIST_POINT = cast(LPCSTR, 2)
const URL_OID_CTL_ISSUER = cast(LPCSTR, 3)
const URL_OID_CTL_NEXT_UPDATE = cast(LPCSTR, 4)
const URL_OID_CRL_ISSUER = cast(LPCSTR, 5)
const URL_OID_CERTIFICATE_FRESHEST_CRL = cast(LPCSTR, 6)
const URL_OID_CRL_FRESHEST_CRL = cast(LPCSTR, 7)
const URL_OID_CROSS_CERT_DIST_POINT = cast(LPCSTR, 8)
const URL_OID_CERTIFICATE_OCSP = cast(LPCSTR, 9)
const URL_OID_CERTIFICATE_OCSP_AND_CRL_DIST_POINT = cast(LPCSTR, 10)
const URL_OID_CERTIFICATE_CRL_DIST_POINT_AND_OCSP = cast(LPCSTR, 11)
const URL_OID_CROSS_CERT_SUBJECT_INFO_ACCESS = cast(LPCSTR, 12)
const URL_OID_CERTIFICATE_ONLY_OCSP = cast(LPCSTR, 13)

type _CERT_CRL_CONTEXT_PAIR
	pCertContext as PCCERT_CONTEXT
	pCrlContext as PCCRL_CONTEXT
end type

type CERT_CRL_CONTEXT_PAIR as _CERT_CRL_CONTEXT_PAIR
type PCERT_CRL_CONTEXT_PAIR as _CERT_CRL_CONTEXT_PAIR ptr
type PCCERT_CRL_CONTEXT_PAIR as const CERT_CRL_CONTEXT_PAIR ptr

type _CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO
	cbSize as DWORD
	iDeltaCrlIndicator as long
	pftCacheResync as LPFILETIME
	pLastSyncTime as LPFILETIME
	pMaxAgeTime as LPFILETIME
	pChainPara as PCERT_REVOCATION_CHAIN_PARA
	pDeltaCrlIndicator as PCRYPT_INTEGER_BLOB
end type

type CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO as _CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO
type PCRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO as _CRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO ptr
type PFN_CRYPT_ENUM_KEYID_PROP as function(byval pKeyIdentifier as const CRYPT_HASH_BLOB ptr, byval dwFlags as DWORD, byval pvReserved as any ptr, byval pvArg as any ptr, byval cProp as DWORD, byval rgdwPropId as DWORD ptr, byval rgpvData as any ptr ptr, byval rgcbData as DWORD ptr) as WINBOOL

#define TIME_VALID_OID_GET_OBJECT_FUNC "TimeValidDllGetObject"
#define CERT_CHAIN_CONFIG_REGPATH wstr(!"Software\\Microsoft\\Cryptography\\OID\\EncodingType 0\\CertDllCreateCertificateChainEngine\\Config")
const TIME_VALID_OID_GET_CTL = cast(LPCSTR, 1)
const TIME_VALID_OID_GET_CRL = cast(LPCSTR, 2)
const TIME_VALID_OID_GET_CRL_FROM_CERT = cast(LPCSTR, 3)
const TIME_VALID_OID_GET_FRESHEST_CRL_FROM_CERT = cast(LPCSTR, 4)
const TIME_VALID_OID_GET_FRESHEST_CRL_FROM_CRL = cast(LPCSTR, 5)
#define TIME_VALID_OID_FLUSH_OBJECT_FUNC "TimeValidDllFlushObject"
const TIME_VALID_OID_FLUSH_CTL = cast(LPCSTR, 1)
const TIME_VALID_OID_FLUSH_CRL = cast(LPCSTR, 2)
const TIME_VALID_OID_FLUSH_CRL_FROM_CERT = cast(LPCSTR, 3)
const TIME_VALID_OID_FLUSH_FRESHEST_CRL_FROM_CERT = cast(LPCSTR, 4)
const TIME_VALID_OID_FLUSH_FRESHEST_CRL_FROM_CRL = cast(LPCSTR, 5)
const CERT_CREATE_SELFSIGN_NO_SIGN = 1
const CERT_CREATE_SELFSIGN_NO_KEY_INFO = 2
const CRYPT_KEYID_DELETE_FLAG = &h10
const CRYPT_KEYID_MACHINE_FLAG = &h20
const CRYPT_KEYID_SET_NEW_FLAG = &h2000
const CRYPT_KEYID_ALLOC_FLAG = &h8000

declare function CryptGetTimeValidObject(byval pszTimeValidOid as LPCSTR, byval pvPara as LPVOID, byval pIssuer as PCCERT_CONTEXT, byval pftValidFor as LPFILETIME, byval dwFlags as DWORD, byval dwTimeout as DWORD, byval ppvObject as LPVOID ptr, byval pCredentials as PCRYPT_CREDENTIALS, byval pExtraInfo as PCRYPT_GET_TIME_VALID_OBJECT_EXTRA_INFO) as WINBOOL
declare function CryptFlushTimeValidObject(byval pszFlushTimeValidOid as LPCSTR, byval pvPara as LPVOID, byval pIssuer as PCCERT_CONTEXT, byval dwFlags as DWORD, byval pvReserved as LPVOID) as WINBOOL
declare function CertCreateSelfSignCertificate(byval hCryptProvOrNCryptKey as HCRYPTPROV_OR_NCRYPT_KEY_HANDLE, byval pSubjectIssuerBlob as PCERT_NAME_BLOB, byval dwFlags as DWORD, byval pKeyProvInfo as PCRYPT_KEY_PROV_INFO, byval pSignatureAlgorithm as PCRYPT_ALGORITHM_IDENTIFIER, byval pStartTime as PSYSTEMTIME, byval pEndTime as PSYSTEMTIME, byval pExtensions as PCERT_EXTENSIONS) as PCCERT_CONTEXT
declare function CryptGetKeyIdentifierProperty(byval pKeyIdentifier as const CRYPT_HASH_BLOB ptr, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pwszComputerName as LPCWSTR, byval pvReserved as any ptr, byval pvData as any ptr, byval pcbData as DWORD ptr) as WINBOOL
declare function CryptSetKeyIdentifierProperty(byval pKeyIdentifier as const CRYPT_HASH_BLOB ptr, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pwszComputerName as LPCWSTR, byval pvReserved as any ptr, byval pvData as const any ptr) as WINBOOL
declare function CryptEnumKeyIdentifierProperties(byval pKeyIdentifier as const CRYPT_HASH_BLOB ptr, byval dwPropId as DWORD, byval dwFlags as DWORD, byval pwszComputerName as LPCWSTR, byval pvReserved as any ptr, byval pvArg as any ptr, byval pfnEnum as PFN_CRYPT_ENUM_KEYID_PROP) as WINBOOL
declare function CryptCreateKeyIdentifierFromCSP(byval dwCertEncodingType as DWORD, byval pszPubKeyOID as LPCSTR, byval pPubKeyStruc as const PUBLICKEYSTRUC ptr, byval cbPubKeyStruc as DWORD, byval dwFlags as DWORD, byval pvReserved as any ptr, byval pbHash as UBYTE ptr, byval pcbHash as DWORD ptr) as WINBOOL

#define CERT_CHAIN_MAX_URL_RETRIEVAL_BYTE_COUNT_VALUE_NAME wstr("MaxUrlRetrievalByteCount")
const CERT_CHAIN_MAX_URL_RETRIEVAL_BYTE_COUNT_DEFAULT = (100 * 1024) * 1024
#define CERT_CHAIN_CACHE_RESYNC_FILETIME_VALUE_NAME wstr("ChainCacheResyncFiletime")
#define CERT_CHAIN_DISABLE_MANDATORY_BASIC_CONSTRAINTS_VALUE_NAME wstr("DisableMandatoryBasicConstraints")
#define CERT_CHAIN_DISABLE_CA_NAME_CONSTRAINTS_VALUE_NAME wstr("DisableCANameConstraints")
#define CERT_CHAIN_DISABLE_UNSUPPORTED_CRITICAL_EXTENSIONS_VALUE_NAME wstr("DisableUnsupportedCriticalExtensions")
#define CERT_CHAIN_MAX_AIA_URL_COUNT_IN_CERT_VALUE_NAME wstr("MaxAIAUrlCountInCert")
const CERT_CHAIN_MAX_AIA_URL_COUNT_IN_CERT_DEFAULT = 5
#define CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_COUNT_PER_CHAIN_VALUE_NAME wstr("MaxAIAUrlRetrievalCountPerChain")
const CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_COUNT_PER_CHAIN_DEFAULT = 3
#define CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_BYTE_COUNT_VALUE_NAME wstr("MaxAIAUrlRetrievalByteCount")
const CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_BYTE_COUNT_DEFAULT = 100000
#define CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_CERT_COUNT_VALUE_NAME wstr("MaxAIAUrlRetrievalCertCount")
const CERT_CHAIN_MAX_AIA_URL_RETRIEVAL_CERT_COUNT_DEFAULT = 10
#define CERT_CHAIN_OCSP_VALIDITY_SECONDS_VALUE_NAME wstr("OcspValiditySeconds")
const CERT_CHAIN_OCSP_VALIDITY_SECONDS_DEFAULT = (12 * 60) * 60
#define CERT_CHAIN_ENABLE_WEAK_SIGNATURE_FLAGS_VALUE_NAME wstr("EnableWeakSignatureFlags")
const CERT_CHAIN_ENABLE_MD2_MD4_FLAG = &h1
const CERT_CHAIN_ENABLE_WEAK_RSA_ROOT_FLAG = &h2
const CERT_CHAIN_ENABLE_WEAK_LOGGING_FLAG = &h4
const CERT_CHAIN_ENABLE_ONLY_WEAK_LOGGING_FLAG = &h8
#define CERT_CHAIN_MIN_RSA_PUB_KEY_BIT_LENGTH_VALUE_NAME wstr("MinRsaPubKeyBitLength")
const CERT_CHAIN_MIN_RSA_PUB_KEY_BIT_LENGTH_DEFAULT = 1023
const CERT_CHAIN_MIN_RSA_PUB_KEY_BIT_LENGTH_DISABLE = &hffffffff
#define CERT_CHAIN_WEAK_RSA_PUB_KEY_TIME_VALUE_NAME wstr("WeakRsaPubKeyTime")
const CERT_CHAIN_WEAK_RSA_PUB_KEY_TIME_DEFAULT = &h01ca8a755c6e0000ull
#define CERT_CHAIN_WEAK_SIGNATURE_LOG_DIR_VALUE_NAME wstr("WeakSignatureLogDir")
#define CERT_SRV_OCSP_RESP_MIN_VALIDITY_SECONDS_VALUE_NAME wstr("SrvOcspRespMinValiditySeconds")
const CERT_SRV_OCSP_RESP_MIN_VALIDITY_SECONDS_DEFAULT = 10 * 60
#define CERT_SRV_OCSP_RESP_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_VALUE_NAME wstr("SrvOcspRespUrlRetrievalTimeoutMilliseconds")
const CERT_SRV_OCSP_RESP_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_DEFAULT = 15 * 1000
#define CERT_SRV_OCSP_RESP_MAX_BEFORE_NEXT_UPDATE_SECONDS_VALUE_NAME wstr("SrvOcspRespMaxBeforeNextUpdateSeconds")
const CERT_SRV_OCSP_RESP_MAX_BEFORE_NEXT_UPDATE_SECONDS_DEFAULT = (4 * 60) * 60
#define CERT_SRV_OCSP_RESP_MIN_BEFORE_NEXT_UPDATE_SECONDS_VALUE_NAME wstr("SrvOcspRespMinBeforeNextUpdateSeconds")
const CERT_SRV_OCSP_RESP_MIN_BEFORE_NEXT_UPDATE_SECONDS_DEFAULT = 2 * 60
#define CERT_SRV_OCSP_RESP_MIN_AFTER_NEXT_UPDATE_SECONDS_VALUE_NAME wstr("SrvOcspRespMinAfterNextUpdateSeconds")
const CERT_SRV_OCSP_RESP_MIN_AFTER_NEXT_UPDATE_SECONDS_DEFAULT = 1 * 60
#define CRYPTNET_MAX_CACHED_OCSP_PER_CRL_COUNT_VALUE_NAME wstr("CryptnetMaxCachedOcspPerCrlCount")
const CRYPTNET_MAX_CACHED_OCSP_PER_CRL_COUNT_DEFAULT = 500
const CRYPTNET_OCSP_AFTER_CRL_DISABLE = &hffffffff
#define CRYPTNET_URL_CACHE_DEFAULT_FLUSH_EXEMPT_SECONDS_VALUE_NAME wstr("CryptnetDefaultFlushExemptSeconds")
const CRYPTNET_URL_CACHE_DEFAULT_FLUSH_EXEMPT_SECONDS_DEFAULT = ((28 * 24) * 60) * 60
#define CRYPTNET_PRE_FETCH_MIN_MAX_AGE_SECONDS_VALUE_NAME wstr("CryptnetPreFetchMinMaxAgeSeconds")
const CRYPTNET_PRE_FETCH_MIN_MAX_AGE_SECONDS_DEFAULT = (1 * 60) * 60
#define CRYPTNET_PRE_FETCH_MAX_MAX_AGE_SECONDS_VALUE_NAME wstr("CryptnetPreFetchMaxMaxAgeSeconds")
const CRYPTNET_PRE_FETCH_MAX_MAX_AGE_SECONDS_DEFAULT = ((14 * 24) * 60) * 60
#define CRYPTNET_PRE_FETCH_MIN_OCSP_VALIDITY_PERIOD_SECONDS_VALUE_NAME wstr("CryptnetPreFetchMinOcspValidityPeriodSeconds")
const CRYPTNET_PRE_FETCH_MIN_OCSP_VALIDITY_PERIOD_SECONDS_DEFAULT = ((14 * 24) * 60) * 60
#define CRYPTNET_PRE_FETCH_AFTER_PUBLISH_PRE_FETCH_DIVISOR_VALUE_NAME wstr("CryptnetPreFetchAfterPublishPreFetchDivisor")
const CRYPTNET_PRE_FETCH_AFTER_PUBLISH_PRE_FETCH_DIVISOR_DEFAULT = 10
#define CRYPTNET_PRE_FETCH_BEFORE_NEXT_UPDATE_PRE_FETCH_DIVISOR_VALUE_NAME wstr("CryptnetPreFetchBeforeNextUpdatePreFetchDivisor")
const CRYPTNET_PRE_FETCH_BEFORE_NEXT_UPDATE_PRE_FETCH_DIVISOR_DEFAULT = 20
#define CRYPTNET_PRE_FETCH_MIN_BEFORE_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME wstr("CryptnetPreFetchMinBeforeNextUpdatePreFetchSeconds")
const CRYPTNET_PRE_FETCH_MIN_BEFORE_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_DEFAULT = (1 * 60) * 60
#define CRYPTNET_PRE_FETCH_VALIDITY_PERIOD_AFTER_NEXT_UPDATE_PRE_FETCH_DIVISOR_VALUE_NAME wstr("CryptnetPreFetchValidityPeriodAfterNextUpdatePreFetchDivisor")
const CRYPTNET_PRE_FETCH_VALIDITY_PERIOD_AFTER_NEXT_UPDATE_PRE_FETCH_DIVISOR_DEFAULT = 10
#define CRYPTNET_PRE_FETCH_MAX_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME wstr("CryptnetPreFetchMaxAfterNextUpdatePreFetchPeriodSeconds")
const CRYPTNET_PRE_FETCH_MAX_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_DEFAULT = (4 * 60) * 60
#define CRYPTNET_PRE_FETCH_MIN_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME wstr("CryptnetPreFetchMinAfterNextUpdatePreFetchPeriodSeconds")
const CRYPTNET_PRE_FETCH_MIN_AFTER_NEXT_UPDATE_PRE_FETCH_PERIOD_SECONDS_DEFAULT = 30 * 60
#define CRYPTNET_PRE_FETCH_AFTER_CURRENT_TIME_PRE_FETCH_PERIOD_SECONDS_VALUE_NAME wstr("CryptnetPreFetchAfterCurrentTimePreFetchPeriodSeconds")
const CRYPTNET_PRE_FETCH_AFTER_CURRENT_TIME_PRE_FETCH_PERIOD_SECONDS_DEFAULT = 30 * 60
#define CRYPTNET_PRE_FETCH_TRIGGER_PERIOD_SECONDS_VALUE_NAME wstr("CryptnetPreFetchTriggerPeriodSeconds")
const CRYPTNET_PRE_FETCH_TRIGGER_PERIOD_SECONDS_DEFAULT = 10 * 60
const CRYPTNET_PRE_FETCH_TRIGGER_DISABLE = &hffffffff
#define CRYPTNET_PRE_FETCH_SCAN_AFTER_TRIGGER_DELAY_SECONDS_VALUE_NAME wstr("CryptnetPreFetchScanAfterTriggerDelaySeconds")
const CRYPTNET_PRE_FETCH_SCAN_AFTER_TRIGGER_DELAY_SECONDS_DEFAULT = 30
#define CRYPTNET_PRE_FETCH_RETRIEVAL_TIMEOUT_SECONDS_VALUE_NAME wstr("CryptnetPreFetchRetrievalTimeoutSeconds")
const CRYPTNET_PRE_FETCH_RETRIEVAL_TIMEOUT_SECONDS_DEFAULT = 5 * 60
#define CERT_GROUP_POLICY_CHAIN_CONFIG_REGPATH CERT_GROUP_POLICY_SYSTEM_STORE_REGPATH wstr(!"\\ChainEngine\\Config")
#define CERT_CHAIN_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_VALUE_NAME wstr("ChainUrlRetrievalTimeoutMilliseconds")
const CERT_CHAIN_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_DEFAULT = 15 * 1000
#define CERT_CHAIN_REV_ACCUMULATIVE_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_VALUE_NAME wstr("ChainRevAccumulativeUrlRetrievalTimeoutMilliseconds")
const CERT_CHAIN_REV_ACCUMULATIVE_URL_RETRIEVAL_TIMEOUT_MILLISECONDS_DEFAULT = 20 * 1000
#define CERT_RETR_BEHAVIOR_INET_AUTH_VALUE_NAME wstr("EnableInetUnknownAuth")
#define CERT_RETR_BEHAVIOR_INET_STATUS_VALUE_NAME wstr("EnableInetLocal")
#define CERT_RETR_BEHAVIOR_FILE_VALUE_NAME wstr("AllowFileUrlScheme")
#define CERT_RETR_BEHAVIOR_LDAP_VALUE_NAME wstr("DisableLDAPSignAndEncrypt")
#define CRYPTNET_CACHED_OCSP_SWITCH_TO_CRL_COUNT_VALUE_NAME wstr("CryptnetCachedOcspSwitchToCrlCount")
const CRYPTNET_CACHED_OCSP_SWITCH_TO_CRL_COUNT_DEFAULT = 50
const CRYPTNET_CRL_BEFORE_OCSP_ENABLE = &hffffffff
#define CERT_CHAIN_DISABLE_AIA_URL_RETRIEVAL_VALUE_NAME wstr("DisableAIAUrlRetrieval")
#define CERT_CHAIN_OPTIONS_VALUE_NAME wstr("Options")
const CERT_CHAIN_OPTION_DISABLE_AIA_URL_RETRIEVAL = &h2
const CERT_CHAIN_OPTION_ENABLE_SIA_URL_RETRIEVAL = &h4
#define CERT_CHAIN_CROSS_CERT_DOWNLOAD_INTERVAL_HOURS_VALUE_NAME wstr("CrossCertDownloadIntervalHours")
const CERT_CHAIN_CROSS_CERT_DOWNLOAD_INTERVAL_HOURS_DEFAULT = 24 * 7
#define CERT_CHAIN_CRL_VALIDITY_EXT_PERIOD_HOURS_VALUE_NAME wstr("CRLValidityExtensionPeriod")
const CERT_CHAIN_CRL_VALIDITY_EXT_PERIOD_HOURS_DEFAULT = 12
#define HCCE_CURRENT_USER cast(HCERTCHAINENGINE, NULL)
#define HCCE_LOCAL_MACHINE cast(HCERTCHAINENGINE, &h1)
const CERT_CHAIN_CACHE_END_CERT = &h1
const CERT_CHAIN_THREAD_STORE_SYNC = &h2
const CERT_CHAIN_CACHE_ONLY_URL_RETRIEVAL = &h4
const CERT_CHAIN_USE_LOCAL_MACHINE_STORE = &h8
const CERT_CHAIN_ENABLE_CACHE_AUTO_UPDATE = &h10
const CERT_CHAIN_ENABLE_SHARE_STORE = &h20
type HCERTCHAINENGINE as HANDLE

type _CERT_CHAIN_ENGINE_CONFIG
	cbSize as DWORD
	hRestrictedRoot as HCERTSTORE
	hRestrictedTrust as HCERTSTORE
	hRestrictedOther as HCERTSTORE
	cAdditionalStore as DWORD
	rghAdditionalStore as HCERTSTORE ptr
	dwFlags as DWORD
	dwUrlRetrievalTimeout as DWORD
	MaximumCachedCertificates as DWORD
	CycleDetectionModulus as DWORD

	#if _WIN32_WINNT >= &h0601
		hExclusiveRoot as HCERTSTORE
		hExclusiveTrustedPeople as HCERTSTORE
	#endif

	#if _WIN32_WINNT = &h0602
		dwExclusiveFlags as DWORD
	#endif
end type

type CERT_CHAIN_ENGINE_CONFIG as _CERT_CHAIN_ENGINE_CONFIG
type PCERT_CHAIN_ENGINE_CONFIG as _CERT_CHAIN_ENGINE_CONFIG ptr

#if _WIN32_WINNT = &h0602
	const CERT_CHAIN_EXCLUSIVE_ENABLE_CA_FLAG = &h1
#endif

declare function CertCreateCertificateChainEngine(byval pConfig as PCERT_CHAIN_ENGINE_CONFIG, byval phChainEngine as HCERTCHAINENGINE ptr) as WINBOOL
declare sub CertFreeCertificateChainEngine(byval hChainEngine as HCERTCHAINENGINE)
declare function CertResyncCertificateChainEngine(byval hChainEngine as HCERTCHAINENGINE) as WINBOOL

type _CERT_TRUST_STATUS
	dwErrorStatus as DWORD
	dwInfoStatus as DWORD
end type

type CERT_TRUST_STATUS as _CERT_TRUST_STATUS
type PCERT_TRUST_STATUS as _CERT_TRUST_STATUS ptr
const CERT_TRUST_NO_ERROR = &h0
const CERT_TRUST_IS_NOT_TIME_VALID = &h1
const CERT_TRUST_IS_NOT_TIME_NESTED = &h2
const CERT_TRUST_IS_REVOKED = &h4
const CERT_TRUST_IS_NOT_SIGNATURE_VALID = &h8
const CERT_TRUST_IS_NOT_VALID_FOR_USAGE = &h10
const CERT_TRUST_IS_UNTRUSTED_ROOT = &h20
const CERT_TRUST_REVOCATION_STATUS_UNKNOWN = &h40
const CERT_TRUST_IS_CYCLIC = &h80
const CERT_TRUST_INVALID_EXTENSION = &h100
const CERT_TRUST_INVALID_POLICY_CONSTRAINTS = &h200
const CERT_TRUST_INVALID_BASIC_CONSTRAINTS = &h400
const CERT_TRUST_INVALID_NAME_CONSTRAINTS = &h800
const CERT_TRUST_HAS_NOT_SUPPORTED_NAME_CONSTRAINT = &h1000
const CERT_TRUST_HAS_NOT_DEFINED_NAME_CONSTRAINT = &h2000
const CERT_TRUST_HAS_NOT_PERMITTED_NAME_CONSTRAINT = &h4000
const CERT_TRUST_HAS_EXCLUDED_NAME_CONSTRAINT = &h8000
const CERT_TRUST_IS_PARTIAL_CHAIN = &h10000
const CERT_TRUST_CTL_IS_NOT_TIME_VALID = &h20000
const CERT_TRUST_CTL_IS_NOT_SIGNATURE_VALID = &h40000
const CERT_TRUST_CTL_IS_NOT_VALID_FOR_USAGE = &h80000
const CERT_TRUST_IS_OFFLINE_REVOCATION = &h1000000
const CERT_TRUST_NO_ISSUANCE_CHAIN_POLICY = &h2000000
const CERT_TRUST_IS_EXPLICIT_DISTRUST = &h4000000
const CERT_TRUST_HAS_NOT_SUPPORTED_CRITICAL_EXT = &h8000000
const CERT_TRUST_HAS_WEAK_SIGNATURE = &h100000
const CERT_TRUST_HAS_EXACT_MATCH_ISSUER = &h1
const CERT_TRUST_HAS_KEY_MATCH_ISSUER = &h2
const CERT_TRUST_HAS_NAME_MATCH_ISSUER = &h4
const CERT_TRUST_IS_SELF_SIGNED = &h8
const CERT_TRUST_AUTO_UPDATE_CA_REVOCATION = &h10
const CERT_TRUST_AUTO_UPDATE_END_REVOCATION = &h20
const CERT_TRUST_NO_OCSP_FAILOVER_TO_CRL = &h40
const CERT_TRUST_HAS_PREFERRED_ISSUER = &h100
const CERT_TRUST_HAS_ISSUANCE_CHAIN_POLICY = &h200
const CERT_TRUST_HAS_VALID_NAME_CONSTRAINTS = &h400
const CERT_TRUST_IS_PEER_TRUSTED = &h800
const CERT_TRUST_HAS_CRL_VALIDITY_EXTENDED = &h1000
const CERT_TRUST_IS_FROM_EXCLUSIVE_TRUST_STORE = &h2000

#if _WIN32_WINNT = &h0602
	const CERT_TRUST_IS_CA_TRUSTED = &h4000
#endif

const CERT_TRUST_IS_COMPLEX_CHAIN = &h10000

type _CERT_REVOCATION_INFO
	cbSize as DWORD
	dwRevocationResult as DWORD
	pszRevocationOid as LPCSTR
	pvOidSpecificInfo as LPVOID
	fHasFreshnessTime as WINBOOL
	dwFreshnessTime as DWORD
	pCrlInfo as PCERT_REVOCATION_CRL_INFO
end type

type CERT_REVOCATION_INFO as _CERT_REVOCATION_INFO
type PCERT_REVOCATION_INFO as _CERT_REVOCATION_INFO ptr

type _CERT_TRUST_LIST_INFO
	cbSize as DWORD
	pCtlEntry as PCTL_ENTRY
	pCtlContext as PCCTL_CONTEXT
end type

type CERT_TRUST_LIST_INFO as _CERT_TRUST_LIST_INFO
type PCERT_TRUST_LIST_INFO as _CERT_TRUST_LIST_INFO ptr

type _CERT_CHAIN_ELEMENT
	cbSize as DWORD
	pCertContext as PCCERT_CONTEXT
	TrustStatus as CERT_TRUST_STATUS
	pRevocationInfo as PCERT_REVOCATION_INFO
	pIssuanceUsage as PCERT_ENHKEY_USAGE
	pApplicationUsage as PCERT_ENHKEY_USAGE
	pwszExtendedErrorInfo as LPCWSTR
end type

type CERT_CHAIN_ELEMENT as _CERT_CHAIN_ELEMENT
type PCERT_CHAIN_ELEMENT as _CERT_CHAIN_ELEMENT ptr
type PCCERT_CHAIN_ELEMENT as const CERT_CHAIN_ELEMENT ptr

type _CERT_SIMPLE_CHAIN
	cbSize as DWORD
	TrustStatus as CERT_TRUST_STATUS
	cElement as DWORD
	rgpElement as PCERT_CHAIN_ELEMENT ptr
	pTrustListInfo as PCERT_TRUST_LIST_INFO
	fHasRevocationFreshnessTime as WINBOOL
	dwRevocationFreshnessTime as DWORD
end type

type CERT_SIMPLE_CHAIN as _CERT_SIMPLE_CHAIN
type PCERT_SIMPLE_CHAIN as _CERT_SIMPLE_CHAIN ptr
type PCCERT_SIMPLE_CHAIN as const CERT_SIMPLE_CHAIN ptr
type CERT_CHAIN_CONTEXT as _CERT_CHAIN_CONTEXT
type PCERT_CHAIN_CONTEXT as _CERT_CHAIN_CONTEXT ptr
type PCCERT_CHAIN_CONTEXT as const CERT_CHAIN_CONTEXT ptr

type _CERT_CHAIN_CONTEXT
	cbSize as DWORD
	TrustStatus as CERT_TRUST_STATUS
	cChain as DWORD
	rgpChain as PCERT_SIMPLE_CHAIN ptr
	cLowerQualityChainContext as DWORD
	rgpLowerQualityChainContext as PCCERT_CHAIN_CONTEXT ptr
	fHasRevocationFreshnessTime as WINBOOL
	dwRevocationFreshnessTime as DWORD
	dwCreateFlags as DWORD
	ChainId as GUID
end type

const USAGE_MATCH_TYPE_AND = &h0
const USAGE_MATCH_TYPE_OR = &h1

type _CERT_USAGE_MATCH
	dwType as DWORD
	Usage as CERT_ENHKEY_USAGE
end type

type CERT_USAGE_MATCH as _CERT_USAGE_MATCH
type PCERT_USAGE_MATCH as _CERT_USAGE_MATCH ptr

type _CTL_USAGE_MATCH
	dwType as DWORD
	Usage as CTL_USAGE
end type

type CTL_USAGE_MATCH as _CTL_USAGE_MATCH
type PCTL_USAGE_MATCH as _CTL_USAGE_MATCH ptr

type _CERT_CHAIN_PARA
	cbSize as DWORD
	RequestedUsage as CERT_USAGE_MATCH
end type

type CERT_CHAIN_PARA as _CERT_CHAIN_PARA
type PCERT_CHAIN_PARA as _CERT_CHAIN_PARA ptr
const CERT_CHAIN_STRONG_SIGN_DISABLE_END_CHECK_FLAG = &h1
const CERT_CHAIN_DISABLE_PASS1_QUALITY_FILTERING = &h40
const CERT_CHAIN_RETURN_LOWER_QUALITY_CONTEXTS = &h80
const CERT_CHAIN_DISABLE_AUTH_ROOT_AUTO_UPDATE = &h100
const CERT_CHAIN_TIMESTAMP_TIME = &h200
const CERT_CHAIN_ENABLE_PEER_TRUST = &h400
const CERT_CHAIN_DISABLE_MY_PEER_TRUST = &h800
const CERT_CHAIN_DISABLE_MD2_MD4 = &h1000
const CERT_CHAIN_REVOCATION_CHECK_END_CERT = &h10000000
const CERT_CHAIN_REVOCATION_CHECK_CHAIN = &h20000000
const CERT_CHAIN_REVOCATION_CHECK_CHAIN_EXCLUDE_ROOT = &h40000000
const CERT_CHAIN_REVOCATION_CHECK_CACHE_ONLY = &h80000000
const CERT_CHAIN_REVOCATION_ACCUMULATIVE_TIMEOUT = &h8000000
const CERT_CHAIN_REVOCATION_CHECK_OCSP_CERT = &h4000000

declare function CertGetCertificateChain(byval hChainEngine as HCERTCHAINENGINE, byval pCertContext as PCCERT_CONTEXT, byval pTime as LPFILETIME, byval hAdditionalStore as HCERTSTORE, byval pChainPara as PCERT_CHAIN_PARA, byval dwFlags as DWORD, byval pvReserved as LPVOID, byval ppChainContext as PCCERT_CHAIN_CONTEXT ptr) as WINBOOL
declare sub CertFreeCertificateChain(byval pChainContext as PCCERT_CHAIN_CONTEXT)
declare function CertDuplicateCertificateChain(byval pChainContext as PCCERT_CHAIN_CONTEXT) as PCCERT_CHAIN_CONTEXT

type _CERT_REVOCATION_CHAIN_PARA
	cbSize as DWORD
	hChainEngine as HCERTCHAINENGINE
	hAdditionalStore as HCERTSTORE
	dwChainFlags as DWORD
	dwUrlRetrievalTimeout as DWORD
	pftCurrentTime as LPFILETIME
	pftCacheResync as LPFILETIME
	cbMaxUrlRetrievalByteCount as DWORD
end type

const REVOCATION_OID_CRL_REVOCATION = cast(LPCSTR, 1)

type _CRL_REVOCATION_INFO
	pCrlEntry as PCRL_ENTRY
	pCrlContext as PCCRL_CONTEXT
	pCrlIssuerChain as PCCERT_CHAIN_CONTEXT
end type

type CRL_REVOCATION_INFO as _CRL_REVOCATION_INFO
type PCRL_REVOCATION_INFO as _CRL_REVOCATION_INFO ptr
declare function CertFindChainInStore(byval hCertStore as HCERTSTORE, byval dwCertEncodingType as DWORD, byval dwFindFlags as DWORD, byval dwFindType as DWORD, byval pvFindPara as const any ptr, byval pPrevChainContext as PCCERT_CHAIN_CONTEXT) as PCCERT_CHAIN_CONTEXT
const CERT_CHAIN_FIND_BY_ISSUER = 1
type PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK as function(byval pCert as PCCERT_CONTEXT, byval pvFindArg as any ptr) as WINBOOL

type _CERT_CHAIN_FIND_BY_ISSUER_PARA
	cbSize as DWORD
	pszUsageIdentifier as LPCSTR
	dwKeySpec as DWORD
	dwAcquirePrivateKeyFlags as DWORD
	cIssuer as DWORD
	rgIssuer as CERT_NAME_BLOB ptr
	pfnFindCallback as PFN_CERT_CHAIN_FIND_BY_ISSUER_CALLBACK
	pvFindArg as any ptr
end type

type CERT_CHAIN_FIND_ISSUER_PARA as _CERT_CHAIN_FIND_BY_ISSUER_PARA
type PCERT_CHAIN_FIND_ISSUER_PARA as _CERT_CHAIN_FIND_BY_ISSUER_PARA ptr
type CERT_CHAIN_FIND_BY_ISSUER_PARA as _CERT_CHAIN_FIND_BY_ISSUER_PARA
type PCERT_CHAIN_FIND_BY_ISSUER_PARA as _CERT_CHAIN_FIND_BY_ISSUER_PARA ptr

const CERT_CHAIN_FIND_BY_ISSUER_COMPARE_KEY_FLAG = &h1
const CERT_CHAIN_FIND_BY_ISSUER_COMPLEX_CHAIN_FLAG = &h2
const CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_URL_FLAG = &h4
const CERT_CHAIN_FIND_BY_ISSUER_LOCAL_MACHINE_FLAG = &h8
const CERT_CHAIN_FIND_BY_ISSUER_NO_KEY_FLAG = &h4000
const CERT_CHAIN_FIND_BY_ISSUER_CACHE_ONLY_FLAG = &h8000

type _CERT_CHAIN_POLICY_PARA
	cbSize as DWORD
	dwFlags as DWORD
	pvExtraPolicyPara as any ptr
end type

type CERT_CHAIN_POLICY_PARA as _CERT_CHAIN_POLICY_PARA
type PCERT_CHAIN_POLICY_PARA as _CERT_CHAIN_POLICY_PARA ptr

type _CERT_CHAIN_POLICY_STATUS
	cbSize as DWORD
	dwError as DWORD
	lChainIndex as LONG
	lElementIndex as LONG
	pvExtraPolicyStatus as any ptr
end type

type CERT_CHAIN_POLICY_STATUS as _CERT_CHAIN_POLICY_STATUS
type PCERT_CHAIN_POLICY_STATUS as _CERT_CHAIN_POLICY_STATUS ptr
const CERT_CHAIN_POLICY_IGNORE_NOT_TIME_VALID_FLAG = &h1
const CERT_CHAIN_POLICY_IGNORE_CTL_NOT_TIME_VALID_FLAG = &h2
const CERT_CHAIN_POLICY_IGNORE_NOT_TIME_NESTED_FLAG = &h4
const CERT_CHAIN_POLICY_IGNORE_INVALID_BASIC_CONSTRAINTS_FLAG = &h8
const CERT_CHAIN_POLICY_IGNORE_ALL_NOT_TIME_VALID_FLAGS = (CERT_CHAIN_POLICY_IGNORE_NOT_TIME_VALID_FLAG or CERT_CHAIN_POLICY_IGNORE_CTL_NOT_TIME_VALID_FLAG) or CERT_CHAIN_POLICY_IGNORE_NOT_TIME_NESTED_FLAG
const CERT_CHAIN_POLICY_ALLOW_UNKNOWN_CA_FLAG = &h10
const CERT_CHAIN_POLICY_IGNORE_WRONG_USAGE_FLAG = &h20
const CERT_CHAIN_POLICY_IGNORE_INVALID_NAME_FLAG = &h40
const CERT_CHAIN_POLICY_IGNORE_INVALID_POLICY_FLAG = &h80
const CERT_CHAIN_POLICY_IGNORE_END_REV_UNKNOWN_FLAG = &h100
const CERT_CHAIN_POLICY_IGNORE_CTL_SIGNER_REV_UNKNOWN_FLAG = &h200
const CERT_CHAIN_POLICY_IGNORE_CA_REV_UNKNOWN_FLAG = &h400
const CERT_CHAIN_POLICY_IGNORE_ROOT_REV_UNKNOWN_FLAG = &h800
const CERT_CHAIN_POLICY_IGNORE_ALL_REV_UNKNOWN_FLAGS = ((CERT_CHAIN_POLICY_IGNORE_END_REV_UNKNOWN_FLAG or CERT_CHAIN_POLICY_IGNORE_CTL_SIGNER_REV_UNKNOWN_FLAG) or CERT_CHAIN_POLICY_IGNORE_CA_REV_UNKNOWN_FLAG) or CERT_CHAIN_POLICY_IGNORE_ROOT_REV_UNKNOWN_FLAG
const CERT_CHAIN_POLICY_IGNORE_PEER_TRUST_FLAG = &h1000
const CERT_CHAIN_POLICY_IGNORE_NOT_SUPPORTED_CRITICAL_EXT_FLAG = &h2000
const CERT_CHAIN_POLICY_TRUST_TESTROOT_FLAG = &h4000
const CERT_CHAIN_POLICY_ALLOW_TESTROOT_FLAG = &h8000
declare function CertVerifyCertificateChainPolicy(byval pszPolicyOID as LPCSTR, byval pChainContext as PCCERT_CHAIN_CONTEXT, byval pPolicyPara as PCERT_CHAIN_POLICY_PARA, byval pPolicyStatus as PCERT_CHAIN_POLICY_STATUS) as WINBOOL
#define CRYPT_OID_VERIFY_CERTIFICATE_CHAIN_POLICY_FUNC "CertDllVerifyCertificateChainPolicy"
const CERT_CHAIN_POLICY_BASE = cast(LPCSTR, 1)
const CERT_CHAIN_POLICY_AUTHENTICODE = cast(LPCSTR, 2)
const CERT_CHAIN_POLICY_AUTHENTICODE_TS = cast(LPCSTR, 3)
const CERT_CHAIN_POLICY_SSL = cast(LPCSTR, 4)
const CERT_CHAIN_POLICY_BASIC_CONSTRAINTS = cast(LPCSTR, 5)
const CERT_CHAIN_POLICY_NT_AUTH = cast(LPCSTR, 6)
const CERT_CHAIN_POLICY_MICROSOFT_ROOT = cast(LPCSTR, 7)
const CERT_CHAIN_POLICY_EV = cast(LPCSTR, 8)

type _AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA
	cbSize as DWORD
	dwRegPolicySettings as DWORD
	pSignerInfo as PCMSG_SIGNER_INFO
end type

type AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA as _AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA
type PAUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA as _AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_PARA ptr

type _AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS
	cbSize as DWORD
	fCommercial as WINBOOL
end type

type AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS as _AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS
type PAUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS as _AUTHENTICODE_EXTRA_CERT_CHAIN_POLICY_STATUS ptr

type _AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA
	cbSize as DWORD
	dwRegPolicySettings as DWORD
	fCommercial as WINBOOL
end type

type AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA as _AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA
type PAUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA as _AUTHENTICODE_TS_EXTRA_CERT_CHAIN_POLICY_PARA ptr
const AUTHTYPE_CLIENT = 1
const AUTHTYPE_SERVER = 2

type _HTTPSPolicyCallbackData
	union
		cbStruct as DWORD
		cbSize as DWORD
	end union

	dwAuthType as DWORD
	fdwChecks as DWORD
	pwszServerName as wstring ptr
end type

type HTTPSPolicyCallbackData as _HTTPSPolicyCallbackData
type PHTTPSPolicyCallbackData as _HTTPSPolicyCallbackData ptr
type SSL_EXTRA_CERT_CHAIN_POLICY_PARA as _HTTPSPolicyCallbackData
type PSSL_EXTRA_CERT_CHAIN_POLICY_PARA as _HTTPSPolicyCallbackData ptr

const BASIC_CONSTRAINTS_CERT_CHAIN_POLICY_CA_FLAG = &h80000000
const BASIC_CONSTRAINTS_CERT_CHAIN_POLICY_END_ENTITY_FLAG = &h40000000
const MICROSOFT_ROOT_CERT_CHAIN_POLICY_ENABLE_TEST_ROOT_FLAG = &h10000
const MICROSOFT_ROOT_CERT_CHAIN_POLICY_CHECK_APPLICATION_ROOT_FLAG = &h20000

type _EV_EXTRA_CERT_CHAIN_POLICY_PARA
	cbSize as DWORD
	dwRootProgramQualifierFlags as DWORD
end type

type EV_EXTRA_CERT_CHAIN_POLICY_PARA as _EV_EXTRA_CERT_CHAIN_POLICY_PARA
type PEV_EXTRA_CERT_CHAIN_POLICY_PARA as _EV_EXTRA_CERT_CHAIN_POLICY_PARA ptr

type _EV_EXTRA_CERT_CHAIN_POLICY_STATUS
	cbSize as DWORD
	dwQualifiers as DWORD
	dwIssuanceUsageIndex as DWORD
end type

type EV_EXTRA_CERT_CHAIN_POLICY_STATUS as _EV_EXTRA_CERT_CHAIN_POLICY_STATUS
type PEV_EXTRA_CERT_CHAIN_POLICY_STATUS as _EV_EXTRA_CERT_CHAIN_POLICY_STATUS ptr
declare function CryptStringToBinaryA(byval pszString as LPCSTR, byval cchString as DWORD, byval dwFlags as DWORD, byval pbBinary as UBYTE ptr, byval pcbBinary as DWORD ptr, byval pdwSkip as DWORD ptr, byval pdwFlags as DWORD ptr) as WINBOOL

#ifndef UNICODE
	declare function CryptStringToBinary alias "CryptStringToBinaryA"(byval pszString as LPCSTR, byval cchString as DWORD, byval dwFlags as DWORD, byval pbBinary as UBYTE ptr, byval pcbBinary as DWORD ptr, byval pdwSkip as DWORD ptr, byval pdwFlags as DWORD ptr) as WINBOOL
#endif

declare function CryptStringToBinaryW(byval pszString as LPCWSTR, byval cchString as DWORD, byval dwFlags as DWORD, byval pbBinary as UBYTE ptr, byval pcbBinary as DWORD ptr, byval pdwSkip as DWORD ptr, byval pdwFlags as DWORD ptr) as WINBOOL

#ifdef UNICODE
	declare function CryptStringToBinary alias "CryptStringToBinaryW"(byval pszString as LPCWSTR, byval cchString as DWORD, byval dwFlags as DWORD, byval pbBinary as UBYTE ptr, byval pcbBinary as DWORD ptr, byval pdwSkip as DWORD ptr, byval pdwFlags as DWORD ptr) as WINBOOL
#endif

declare function CryptBinaryToStringA(byval pbBinary as const UBYTE ptr, byval cbBinary as DWORD, byval dwFlags as DWORD, byval pszString as LPSTR, byval pcchString as DWORD ptr) as WINBOOL

#ifndef UNICODE
	declare function CryptBinaryToString alias "CryptBinaryToStringA"(byval pbBinary as const UBYTE ptr, byval cbBinary as DWORD, byval dwFlags as DWORD, byval pszString as LPSTR, byval pcchString as DWORD ptr) as WINBOOL
#endif

declare function CryptBinaryToStringW(byval pbBinary as const UBYTE ptr, byval cbBinary as DWORD, byval dwFlags as DWORD, byval pszString as LPWSTR, byval pcchString as DWORD ptr) as WINBOOL

#ifdef UNICODE
	declare function CryptBinaryToString alias "CryptBinaryToStringW"(byval pbBinary as const UBYTE ptr, byval cbBinary as DWORD, byval dwFlags as DWORD, byval pszString as LPWSTR, byval pcchString as DWORD ptr) as WINBOOL
#endif

const CRYPT_STRING_BASE64HEADER = &h0
const CRYPT_STRING_BASE64 = &h1
const CRYPT_STRING_BINARY = &h2
const CRYPT_STRING_BASE64REQUESTHEADER = &h00000003
const CRYPT_STRING_HEX = &h4
const CRYPT_STRING_HEXASCII = &h00000005
const CRYPT_STRING_BASE64_ANY = &h00000006
const CRYPT_STRING_ANY = &h00000007
const CRYPT_STRING_HEX_ANY = &h8
const CRYPT_STRING_BASE64X509CRLHEADER = &h00000009
const CRYPT_STRING_HEXADDR = &h0000000a
const CRYPT_STRING_HEXASCIIADDR = &h0000000b
const CRYPT_STRING_HEXRAW = &h0000000c
const CRYPT_STRING_HASHDATA = &h10000000
const CRYPT_STRING_STRICT = &h20000000
const CRYPT_STRING_NOCRLF = &h40000000
const CRYPT_STRING_NOCR = &h80000000
#define szOID_PKCS_12_PbeIds "1.2.840.113549.1.12.1"
#define szOID_PKCS_12_pbeWithSHA1And128BitRC4 "1.2.840.113549.1.12.1.1"
#define szOID_PKCS_12_pbeWithSHA1And40BitRC4 "1.2.840.113549.1.12.1.2"
#define szOID_PKCS_12_pbeWithSHA1And3KeyTripleDES "1.2.840.113549.1.12.1.3"
#define szOID_PKCS_12_pbeWithSHA1And2KeyTripleDES "1.2.840.113549.1.12.1.4"
#define szOID_PKCS_12_pbeWithSHA1And128BitRC2 "1.2.840.113549.1.12.1.5"
#define szOID_PKCS_12_pbeWithSHA1And40BitRC2 "1.2.840.113549.1.12.1.6"

type _CRYPT_PKCS12_PBE_PARAMS
	iIterations as long
	cbSalt as ULONG
end type

type CRYPT_PKCS12_PBE_PARAMS as _CRYPT_PKCS12_PBE_PARAMS
declare function PFXImportCertStore(byval pPFX as CRYPT_DATA_BLOB ptr, byval szPassword as LPCWSTR, byval dwFlags as DWORD) as HCERTSTORE
const PKCS12_IMPORT_SILENT = &h40
const CRYPT_USER_KEYSET = &h1000
const PKCS12_PREFER_CNG_KSP = &h100
const PKCS12_ALWAYS_CNG_KSP = &h200
const PKCS12_ALLOW_OVERWRITE_KEY = &h4000
const PKCS12_NO_PERSIST_KEY = &h8000
const PKCS12_IMPORT_RESERVED_MASK = &hffff0000
#define PKCS12_OBJECT_LOCATOR_ALL_IMPORT_FLAGS (((PKCS12_ALWAYS_CNG_KSP or PKCS12_NO_PERSIST_KEY) or PKCS12_IMPORT_SILENT) or PKCS12_INCLUDE_EXTENDED_PROPERTIES)

declare function PFXIsPFXBlob(byval pPFX as CRYPT_DATA_BLOB ptr) as WINBOOL
declare function PFXVerifyPassword(byval pPFX as CRYPT_DATA_BLOB ptr, byval szPassword as LPCWSTR, byval dwFlags as DWORD) as WINBOOL
declare function PFXExportCertStoreEx(byval hStore as HCERTSTORE, byval pPFX as CRYPT_DATA_BLOB ptr, byval szPassword as LPCWSTR, byval pvPara as any ptr, byval dwFlags as DWORD) as WINBOOL

const REPORT_NO_PRIVATE_KEY = &h1
const REPORT_NOT_ABLE_TO_EXPORT_PRIVATE_KEY = &h2
const EXPORT_PRIVATE_KEYS = &h4
const PKCS12_INCLUDE_EXTENDED_PROPERTIES = &h10
const PKCS12_PROTECT_TO_DOMAIN_SIDS = &h20
const PKCS12_EXPORT_SILENT = &h40
const PKCS12_EXPORT_RESERVED_MASK = &hffff0000
declare function PFXExportCertStore(byval hStore as HCERTSTORE, byval pPFX as CRYPT_DATA_BLOB ptr, byval szPassword as LPCWSTR, byval dwFlags as DWORD) as WINBOOL

#if _WIN32_WINNT >= &h0600
	type HCERT_SERVER_OCSP_RESPONSE as any ptr
	declare function CertOpenServerOcspResponse(byval pChainContext as PCCERT_CHAIN_CONTEXT, byval dwFlags as DWORD, byval pvReserved as LPVOID) as HCERT_SERVER_OCSP_RESPONSE
	const CERT_SERVER_OCSP_RESPONSE_ASYNC_FLAG = &h1
	declare sub CertAddRefServerOcspResponse(byval hServerOcspResponse as HCERT_SERVER_OCSP_RESPONSE)
	declare sub CertCloseServerOcspResponse(byval hServerOcspResponse as HCERT_SERVER_OCSP_RESPONSE, byval dwFlags as DWORD)
	type CERT_SERVER_OCSP_RESPONSE_CONTEXT as _CERT_SERVER_OCSP_RESPONSE_CONTEXT
	type PCERT_SERVER_OCSP_RESPONSE_CONTEXT as _CERT_SERVER_OCSP_RESPONSE_CONTEXT ptr
	type PCCERT_SERVER_OCSP_RESPONSE_CONTEXT as const CERT_SERVER_OCSP_RESPONSE_CONTEXT ptr

	type _CERT_SERVER_OCSP_RESPONSE_CONTEXT
		cbSize as DWORD
		pbEncodedOcspResponse as UBYTE ptr
		cbEncodedOcspResponse as DWORD
	end type

	declare function CertGetServerOcspResponseContext(byval hServerOcspResponse as HCERT_SERVER_OCSP_RESPONSE, byval dwFlags as DWORD, byval pvReserved as LPVOID) as PCCERT_SERVER_OCSP_RESPONSE_CONTEXT
	declare sub CertAddRefServerOcspResponseContext(byval pServerOcspResponseContext as PCCERT_SERVER_OCSP_RESPONSE_CONTEXT)
	declare sub CertFreeServerOcspResponseContext(byval pServerOcspResponseContext as PCCERT_SERVER_OCSP_RESPONSE_CONTEXT)
#endif

declare function CertRetrieveLogoOrBiometricInfo(byval pCertContext as PCCERT_CONTEXT, byval lpszLogoOrBiometricType as LPCSTR, byval dwRetrievalFlags as DWORD, byval dwTimeout as DWORD, byval dwFlags as DWORD, byval pvReserved as any ptr, byval ppbData as UBYTE ptr ptr, byval pcbData as DWORD ptr, byval ppwszMimeType as LPWSTR ptr) as WINBOOL
const CERT_RETRIEVE_ISSUER_LOGO = cast(LPCSTR, 1)
const CERT_RETRIEVE_SUBJECT_LOGO = cast(LPCSTR, 2)
const CERT_RETRIEVE_COMMUNITY_LOGO = cast(LPCSTR, 3)
const CERT_RETRIEVE_BIOMETRIC_PREDEFINED_BASE_TYPE = cast(LPCSTR, 1000)
const CERT_RETRIEVE_BIOMETRIC_PICTURE_TYPE = CERT_RETRIEVE_BIOMETRIC_PREDEFINED_BASE_TYPE + CERT_BIOMETRIC_PICTURE_TYPE
const CERT_RETRIEVE_BIOMETRIC_SIGNATURE_TYPE = CERT_RETRIEVE_BIOMETRIC_PREDEFINED_BASE_TYPE + CERT_BIOMETRIC_SIGNATURE_TYPE

#if _WIN32_WINNT >= &h0601
	type _CERT_SELECT_CHAIN_PARA
		hChainEngine as HCERTCHAINENGINE
		pTime as PFILETIME
		hAdditionalStore as HCERTSTORE
		pChainPara as PCERT_CHAIN_PARA
		dwFlags as DWORD
	end type

	type CERT_SELECT_CHAIN_PARA as _CERT_SELECT_CHAIN_PARA
	type PCERT_SELECT_CHAIN_PARA as _CERT_SELECT_CHAIN_PARA ptr
	type PCCERT_SELECT_CHAIN_PARA as const CERT_SELECT_CHAIN_PARA ptr
	const CERT_SELECT_MAX_PARA = 500

	type _CERT_SELECT_CRITERIA
		dwType as DWORD
		cPara as DWORD
		ppPara as any ptr ptr
	end type

	type CERT_SELECT_CRITERIA as _CERT_SELECT_CRITERIA
	type PCERT_SELECT_CRITERIA as _CERT_SELECT_CRITERIA ptr
	type PCCERT_SELECT_CRITERIA as const CERT_SELECT_CRITERIA ptr

	const CERT_SELECT_BY_ENHKEY_USAGE = 1
	const CERT_SELECT_BY_KEY_USAGE = 2
	const CERT_SELECT_BY_POLICY_OID = 3
	const CERT_SELECT_BY_PROV_NAME = 4
	const CERT_SELECT_BY_EXTENSION = 5
	const CERT_SELECT_BY_SUBJECT_HOST_NAME = 6
	const CERT_SELECT_BY_ISSUER_ATTR = 7
	const CERT_SELECT_BY_SUBJECT_ATTR = 8
	const CERT_SELECT_BY_ISSUER_NAME = 9
	const CERT_SELECT_BY_PUBLIC_KEY = 10
	const CERT_SELECT_BY_TLS_SIGNATURES = 11
	const CERT_SELECT_LAST = CERT_SELECT_BY_TLS_SIGNATURES
	const CERT_SELECT_MAX = CERT_SELECT_LAST * 3
	const CERT_SELECT_ALLOW_EXPIRED = &h1
	const CERT_SELECT_TRUSTED_ROOT = &h2
	const CERT_SELECT_DISALLOW_SELFSIGNED = &h4
	const CERT_SELECT_HAS_PRIVATE_KEY = &h8
	const CERT_SELECT_HAS_KEY_FOR_SIGNATURE = &h10
	const CERT_SELECT_HAS_KEY_FOR_KEY_EXCHANGE = &h20
	const CERT_SELECT_HARDWARE_ONLY = &h40
	const CERT_SELECT_ALLOW_DUPLICATES = &h80
	declare function CertSelectCertificateChains(byval pSelectionContext as LPCGUID, byval dwFlags as DWORD, byval pChainParameters as PCCERT_SELECT_CHAIN_PARA, byval cCriteria as DWORD, byval rgpCriteria as PCCERT_SELECT_CRITERIA, byval hStore as HCERTSTORE, byval pcSelection as PDWORD, byval pprgpSelection as PCCERT_CHAIN_CONTEXT ptr ptr) as WINBOOL
	declare sub CertFreeCertificateChainList(byval prgpSelection as PCCERT_CHAIN_CONTEXT ptr)
	const TIMESTAMP_VERSION = 1

	type _CRYPT_TIMESTAMP_REQUEST
		dwVersion as DWORD
		HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
		HashedMessage as CRYPT_DER_BLOB
		pszTSAPolicyId as LPSTR
		Nonce as CRYPT_INTEGER_BLOB
		fCertReq as WINBOOL
		cExtension as DWORD
		rgExtension as PCERT_EXTENSION
	end type

	type CRYPT_TIMESTAMP_REQUEST as _CRYPT_TIMESTAMP_REQUEST
	type PCRYPT_TIMESTAMP_REQUEST as _CRYPT_TIMESTAMP_REQUEST ptr

	type _CRYPT_TIMESTAMP_RESPONSE
		dwStatus as DWORD
		cFreeText as DWORD
		rgFreeText as LPWSTR ptr
		FailureInfo as CRYPT_BIT_BLOB
		ContentInfo as CRYPT_DER_BLOB
	end type

	type CRYPT_TIMESTAMP_RESPONSE as _CRYPT_TIMESTAMP_RESPONSE
	type PCRYPT_TIMESTAMP_RESPONSE as _CRYPT_TIMESTAMP_RESPONSE ptr
	const TIMESTAMP_STATUS_GRANTED = 0
	const TIMESTAMP_STATUS_GRANTED_WITH_MODS = 1
	const TIMESTAMP_STATUS_REJECTED = 2
	const TIMESTAMP_STATUS_WAITING = 3
	const TIMESTAMP_STATUS_REVOCATION_WARNING = 4
	const TIMESTAMP_STATUS_REVOKED = 5
	const TIMESTAMP_FAILURE_BAD_ALG = 0
	const TIMESTAMP_FAILURE_BAD_REQUEST = 2
	const TIMESTAMP_FAILURE_BAD_FORMAT = 5
	const TIMESTAMP_FAILURE_TIME_NOT_AVAILABLE = 14
	const TIMESTAMP_FAILURE_POLICY_NOT_SUPPORTED = 15
	const TIMESTAMP_FAILURE_EXTENSION_NOT_SUPPORTED = 16
	const TIMESTAMP_FAILURE_INFO_NOT_AVAILABLE = 17
	const TIMESTAMP_FAILURE_SYSTEM_FAILURE = 25

	type _CRYPT_TIMESTAMP_ACCURACY
		dwSeconds as DWORD
		dwMillis as DWORD
		dwMicros as DWORD
	end type

	type CRYPT_TIMESTAMP_ACCURACY as _CRYPT_TIMESTAMP_ACCURACY
	type PCRYPT_TIMESTAMP_ACCURACY as _CRYPT_TIMESTAMP_ACCURACY ptr

	type _CRYPT_TIMESTAMP_INFO
		dwVersion as DWORD
		pszTSAPolicyId as LPSTR
		HashAlgorithm as CRYPT_ALGORITHM_IDENTIFIER
		HashedMessage as CRYPT_DER_BLOB
		SerialNumber as CRYPT_INTEGER_BLOB
		ftTime as FILETIME
		pvAccuracy as PCRYPT_TIMESTAMP_ACCURACY
		fOrdering as WINBOOL
		Nonce as CRYPT_DER_BLOB
		Tsa as CRYPT_DER_BLOB
		cExtension as DWORD
		rgExtension as PCERT_EXTENSION
	end type

	type CRYPT_TIMESTAMP_INFO as _CRYPT_TIMESTAMP_INFO
	type PCRYPT_TIMESTAMP_INFO as _CRYPT_TIMESTAMP_INFO ptr

	type _CRYPT_TIMESTAMP_CONTEXT
		cbEncoded as DWORD
		pbEncoded as UBYTE ptr
		pTimeStamp as PCRYPT_TIMESTAMP_INFO
	end type

	type CRYPT_TIMESTAMP_CONTEXT as _CRYPT_TIMESTAMP_CONTEXT
	type PCRYPT_TIMESTAMP_CONTEXT as _CRYPT_TIMESTAMP_CONTEXT ptr

	type _CRYPT_TIMESTAMP_PARA
		pszTSAPolicyId as LPCSTR
		fRequestCerts as WINBOOL
		Nonce as CRYPT_INTEGER_BLOB
		cExtension as DWORD
		rgExtension as PCERT_EXTENSION
	end type

	type CRYPT_TIMESTAMP_PARA as _CRYPT_TIMESTAMP_PARA
	type PCRYPT_TIMESTAMP_PARA as _CRYPT_TIMESTAMP_PARA ptr
	declare function CryptRetrieveTimeStamp(byval wszUrl as LPCWSTR, byval dwRetrievalFlags as DWORD, byval dwTimeout as DWORD, byval pszHashId as LPCSTR, byval pPara as const CRYPT_TIMESTAMP_PARA ptr, byval pbData as const UBYTE ptr, byval cbData as DWORD, byval ppTsContext as PCRYPT_TIMESTAMP_CONTEXT ptr, byval ppTsSigner as PCCERT_CONTEXT ptr, byval phStore as HCERTSTORE ptr) as WINBOOL
	const TIMESTAMP_DONT_HASH_DATA = &h1
	const TIMESTAMP_VERIFY_CONTEXT_SIGNATURE = &h20
	const TIMESTAMP_NO_AUTH_RETRIEVAL = &h20000
	declare function CryptVerifyTimeStampSignature(byval pbTSContentInfo as const UBYTE ptr, byval cbTSContentInfo as DWORD, byval pbData as const UBYTE ptr, byval cbData as DWORD, byval hAdditionalStore as HCERTSTORE, byval ppTsContext as PCRYPT_TIMESTAMP_CONTEXT ptr, byval ppTsSigner as PCCERT_CONTEXT ptr, byval phStore as HCERTSTORE ptr) as WINBOOL
#endif

#if _WIN32_WINNT = &h0602
	const CRYPT_OBJECT_LOCATOR_SPN_NAME_TYPE = 1
	const CRYPT_OBJECT_LOCATOR_LAST_RESERVED_NAME_TYPE = 32
	const CRYPT_OBJECT_LOCATOR_FIRST_RESERVED_USER_NAME_TYPE = 33
	const CRYPT_OBJECT_LOCATOR_LAST_RESERVED_USER_NAME_TYPE = &h0000ffff
	#define SSL_OBJECT_LOCATOR_PFX_FUNC "SslObjectLocatorInitializePfx"
	#define SSL_OBJECT_LOCATOR_ISSUER_LIST_FUNC "SslObjectLocatorInitializeIssuerList"
	#define SSL_OBJECT_LOCATOR_CERT_VALIDATION_CONFIG_FUNC "SslObjectLocatorInitializeCertValidationConfig"
	const CRYPT_OBJECT_LOCATOR_RELEASE_SYSTEM_SHUTDOWN = 1
	const CRYPT_OBJECT_LOCATOR_RELEASE_SERVICE_STOP = 2
	const CRYPT_OBJECT_LOCATOR_RELEASE_PROCESS_EXIT = 3
	const CRYPT_OBJECT_LOCATOR_RELEASE_DLL_UNLOAD = 4

	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH as function(byval pContext as LPVOID, byval rgIdentifierOrNameList as PCERT_NAME_BLOB ptr, byval dwIdentifierOrNameListCount as DWORD) as WINBOOL
	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET as function(byval pPluginContext as LPVOID, byval pIdentifier as PCRYPT_DATA_BLOB, byval dwNameType as DWORD, byval pNameBlob as PCERT_NAME_BLOB, byval ppbContent as PBYTE ptr, byval pcbContent as DWORD ptr, byval ppwszPassword as PCWSTR ptr, byval ppIdentifier as PCRYPT_DATA_BLOB ptr) as WINBOOL
	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE as sub(byval dwReason as DWORD, byval pPluginContext as LPVOID)
	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD as sub(byval pPluginContext as LPVOID, byval pwszPassword as PCWSTR)
	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE as sub(byval pPluginContext as LPVOID, byval pbData as PBYTE)
	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER as sub(byval pPluginContext as LPVOID, byval pIdentifier as PCRYPT_DATA_BLOB)

	type _CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE
		cbSize as DWORD
		pfnGet as PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_GET
		pfnRelease as PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_RELEASE
		pfnFreePassword as PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_PASSWORD
		pfnFree as PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE
		pfnFreeIdentifier as PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FREE_IDENTIFIER
	end type

	type CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE as _CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE
	type PCRYPT_OBJECT_LOCATOR_PROVIDER_TABLE as _CRYPT_OBJECT_LOCATOR_PROVIDER_TABLE ptr
	type PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_INITIALIZE as function(byval pfnFlush as PFN_CRYPT_OBJECT_LOCATOR_PROVIDER_FLUSH, byval pContext as LPVOID, byval pdwExpectedObjectCount as DWORD ptr, byval ppFuncTable as PCRYPT_OBJECT_LOCATOR_PROVIDER_TABLE ptr, byval ppPluginContext as any ptr ptr) as WINBOOL
#endif

#define __DPAPI_H__
#define CRYPTPROTECT_DEFAULT_PROVIDER (&hdf9d8cd0, &h1501, &h11d1, (&h8c, &h7a, &h00, &hc0, &h4f, &hc2, &h97, &heb))
#define szFORCE_KEY_PROTECTION "ForceKeyProtection"
const dwFORCE_KEY_PROTECTION_DISABLED = &h0
const dwFORCE_KEY_PROTECTION_USER_SELECT = &h1
const dwFORCE_KEY_PROTECTION_HIGH = &h2
const CRYPTPROTECT_PROMPT_ON_UNPROTECT = &h1
const CRYPTPROTECT_PROMPT_ON_PROTECT = &h2
const CRYPTPROTECT_PROMPT_RESERVED = &h04
const CRYPTPROTECT_PROMPT_STRONG = &h08
const CRYPTPROTECT_PROMPT_REQUIRE_STRONG = &h10
const CRYPTPROTECT_UI_FORBIDDEN = &h1
const CRYPTPROTECT_LOCAL_MACHINE = &h4
const CRYPTPROTECT_CRED_SYNC = &h8
const CRYPTPROTECT_AUDIT = &h10
const CRYPTPROTECT_NO_RECOVERY = &h20
const CRYPTPROTECT_VERIFY_PROTECTION = &h40
const CRYPTPROTECT_CRED_REGENERATE = &h80
const CRYPTPROTECT_FIRST_RESERVED_FLAGVAL = &h0fffffff
const CRYPTPROTECT_LAST_RESERVED_FLAGVAL = &hffffffff
const CRYPTPROTECTMEMORY_BLOCK_SIZE = 16
const CRYPTPROTECTMEMORY_SAME_PROCESS = &h0
const CRYPTPROTECTMEMORY_CROSS_PROCESS = &h1
const CRYPTPROTECTMEMORY_SAME_LOGON = &h2

type _CRYPTPROTECT_PROMPTSTRUCT
	cbSize as DWORD
	dwPromptFlags as DWORD
	hwndApp as HWND
	szPrompt as LPCWSTR
end type

type CRYPTPROTECT_PROMPTSTRUCT as _CRYPTPROTECT_PROMPTSTRUCT
type PCRYPTPROTECT_PROMPTSTRUCT as _CRYPTPROTECT_PROMPTSTRUCT ptr
declare function CryptProtectData(byval pDataIn as DATA_BLOB ptr, byval szDataDescr as LPCWSTR, byval pOptionalEntropy as DATA_BLOB ptr, byval pvReserved as PVOID, byval pPromptStruct as CRYPTPROTECT_PROMPTSTRUCT ptr, byval dwFlags as DWORD, byval pDataOut as DATA_BLOB ptr) as WINBOOL
declare function CryptUnprotectData(byval pDataIn as DATA_BLOB ptr, byval ppszDataDescr as LPWSTR ptr, byval pOptionalEntropy as DATA_BLOB ptr, byval pvReserved as PVOID, byval pPromptStruct as CRYPTPROTECT_PROMPTSTRUCT ptr, byval dwFlags as DWORD, byval pDataOut as DATA_BLOB ptr) as WINBOOL
declare function CryptProtectMemory(byval pDataIn as LPVOID, byval cbDataIn as DWORD, byval dwFlags as DWORD) as WINBOOL
declare function CryptUnprotectMemory(byval pDataIn as LPVOID, byval cbDataIn as DWORD, byval dwFlags as DWORD) as WINBOOL

#if _WIN32_WINNT = &h0602
	declare function CryptProtectDataNoUI(byval pDataIn as DATA_BLOB ptr, byval szDataDescr as LPCWSTR, byval pOptionalEntropy as DATA_BLOB ptr, byval pvReserved as PVOID, byval pPromptStruct as CRYPTPROTECT_PROMPTSTRUCT ptr, byval dwFlags as DWORD, byval pbOptionalPassword as const UBYTE ptr, byval cbOptionalPassword as DWORD, byval pDataOut as DATA_BLOB ptr) as WINBOOL
	declare function CryptUnprotectDataNoUI(byval pDataIn as DATA_BLOB ptr, byval ppszDataDescr as LPWSTR ptr, byval pOptionalEntropy as DATA_BLOB ptr, byval pvReserved as PVOID, byval pPromptStruct as CRYPTPROTECT_PROMPTSTRUCT ptr, byval dwFlags as DWORD, byval pbOptionalPassword as const UBYTE ptr, byval cbOptionalPassword as DWORD, byval pDataOut as DATA_BLOB ptr) as WINBOOL
#endif

#if _WIN32_WINNT >= &h0600
	declare function CryptUpdateProtectedState(byval pOldSid as PSID, byval pwszOldPassword as LPCWSTR, byval dwFlags as DWORD, byval pdwSuccessCount as DWORD ptr, byval pdwFailureCount as DWORD ptr) as WINBOOL
#endif

end extern
