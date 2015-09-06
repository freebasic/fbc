'' FreeBASIC binding for mingw-w64-v4.0.4
''
'' based on the C header files:
''   This Software is provided under the Zope Public License (ZPL) Version 2.1.
''
''   Copyright (c) 2009, 2010 by the mingw-w64 project
''
''   See the AUTHORS file for the list of contributors to the mingw-w64 project.
''
''   This license has been certified as open source. It has also been designated
''   as GPL compatible by the Free Software Foundation (FSF).
''
''   Redistribution and use in source and binary forms, with or without
''   modification, are permitted provided that the following conditions are met:
''
''     1. Redistributions in source code must retain the accompanying copyright
''        notice, this list of conditions, and the following disclaimer.
''     2. Redistributions in binary form must reproduce the accompanying
''        copyright notice, this list of conditions, and the following disclaimer
''        in the documentation and/or other materials provided with the
''        distribution.
''     3. Names of the copyright holders must not be used to endorse or promote
''        products derived from this software without prior written permission
''        from the copyright holders.
''     4. The right to distribute this software or to use it for any purpose does
''        not give you the right to use Servicemarks (sm) or Trademarks (tm) of
''        the copyright holders.  Use of them is covered by separate agreement
''        with the copyright holders.
''     5. If any files are modified, you must cause the modified files to carry
''        prominent notices stating that you changed the files and the date of
''        any change.
''
''   Disclaimer
''
''   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS ``AS IS'' AND ANY EXPRESSED
''   OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
''   OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY DIRECT, INDIRECT,
''   INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
''   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, 
''   OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
''   LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
''   NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
''   EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "winapifamily.bi"
#include once "bcrypt.bi"

extern "Windows"

#define __NCRYPT_H__
type SECURITY_STATUS as LONG
#define __SECSTATUS_DEFINED__
const NCRYPT_MAX_KEY_NAME_LENGTH = 512
const NCRYPT_MAX_ALG_ID_LENGTH = 512
#define MS_KEY_STORAGE_PROVIDER wstr("Microsoft Software Key Storage Provider")
#define MS_SMART_CARD_KEY_STORAGE_PROVIDER wstr("Microsoft Smart Card Key Storage Provider")
#define MS_PLATFORM_KEY_STORAGE_PROVIDER wstr("Microsoft Platform Crypto Provider")
#define NCRYPT_RSA_ALGORITHM BCRYPT_RSA_ALGORITHM
#define NCRYPT_RSA_SIGN_ALGORITHM BCRYPT_RSA_SIGN_ALGORITHM
#define NCRYPT_DH_ALGORITHM BCRYPT_DH_ALGORITHM
#define NCRYPT_DSA_ALGORITHM BCRYPT_DSA_ALGORITHM
#define NCRYPT_MD2_ALGORITHM BCRYPT_MD2_ALGORITHM
#define NCRYPT_MD4_ALGORITHM BCRYPT_MD4_ALGORITHM
#define NCRYPT_MD5_ALGORITHM BCRYPT_MD5_ALGORITHM
#define NCRYPT_SHA1_ALGORITHM BCRYPT_SHA1_ALGORITHM
#define NCRYPT_SHA256_ALGORITHM BCRYPT_SHA256_ALGORITHM
#define NCRYPT_SHA384_ALGORITHM BCRYPT_SHA384_ALGORITHM
#define NCRYPT_SHA512_ALGORITHM BCRYPT_SHA512_ALGORITHM
#define NCRYPT_ECDSA_P256_ALGORITHM BCRYPT_ECDSA_P256_ALGORITHM
#define NCRYPT_ECDSA_P384_ALGORITHM BCRYPT_ECDSA_P384_ALGORITHM
#define NCRYPT_ECDSA_P521_ALGORITHM BCRYPT_ECDSA_P521_ALGORITHM
#define NCRYPT_ECDH_P256_ALGORITHM BCRYPT_ECDH_P256_ALGORITHM
#define NCRYPT_ECDH_P384_ALGORITHM BCRYPT_ECDH_P384_ALGORITHM
#define NCRYPT_ECDH_P521_ALGORITHM BCRYPT_ECDH_P521_ALGORITHM

#if _WIN32_WINNT = &h0602
	#define NCRYPT_AES_ALGORITHM BCRYPT_AES_ALGORITHM
	#define NCRYPT_RC2_ALGORITHM BCRYPT_RC2_ALGORITHM
	#define NCRYPT_3DES_ALGORITHM BCRYPT_3DES_ALGORITHM
	#define NCRYPT_DES_ALGORITHM BCRYPT_DES_ALGORITHM
	#define NCRYPT_DESX_ALGORITHM BCRYPT_DESX_ALGORITHM
	#define NCRYPT_3DES_112_ALGORITHM BCRYPT_3DES_112_ALGORITHM
	#define NCRYPT_SP800108_CTR_HMAC_ALGORITHM BCRYPT_SP800108_CTR_HMAC_ALGORITHM
	#define NCRYPT_SP80056A_CONCAT_ALGORITHM BCRYPT_SP80056A_CONCAT_ALGORITHM
	#define NCRYPT_PBKDF2_ALGORITHM BCRYPT_PBKDF2_ALGORITHM
	#define NCRYPT_CAPI_KDF_ALGORITHM BCRYPT_CAPI_KDF_ALGORITHM
#endif

#define NCRYPT_KEY_STORAGE_ALGORITHM wstr("KEY_STORAGE")
const NCRYPT_CIPHER_INTERFACE = BCRYPT_CIPHER_INTERFACE
const NCRYPT_HASH_INTERFACE = BCRYPT_HASH_INTERFACE
const NCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE = BCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE
const NCRYPT_SECRET_AGREEMENT_INTERFACE = BCRYPT_SECRET_AGREEMENT_INTERFACE
const NCRYPT_SIGNATURE_INTERFACE = BCRYPT_SIGNATURE_INTERFACE

#if _WIN32_WINNT = &h0602
	const NCRYPT_KEY_DERIVATION_INTERFACE = BCRYPT_KEY_DERIVATION_INTERFACE
#endif

const NCRYPT_KEY_STORAGE_INTERFACE = &h00010001
const NCRYPT_SCHANNEL_INTERFACE = &h00010002
const NCRYPT_SCHANNEL_SIGNATURE_INTERFACE = &h00010003

#if _WIN32_WINNT = &h0602
	const NCRYPT_KEY_PROTECTION_INTERFACE = &h00010004
#endif

#define NCRYPT_RSA_ALGORITHM_GROUP NCRYPT_RSA_ALGORITHM
#define NCRYPT_DH_ALGORITHM_GROUP NCRYPT_DH_ALGORITHM
#define NCRYPT_DSA_ALGORITHM_GROUP NCRYPT_DSA_ALGORITHM
#define NCRYPT_ECDSA_ALGORITHM_GROUP wstr("ECDSA")
#define NCRYPT_ECDH_ALGORITHM_GROUP wstr("ECDH")

#if _WIN32_WINNT = &h0602
	#define NCRYPT_AES_ALGORITHM_GROUP NCRYPT_AES_ALGORITHM
	#define NCRYPT_RC2_ALGORITHM_GROUP NCRYPT_RC2_ALGORITHM
	#define NCRYPT_DES_ALGORITHM_GROUP wstr("DES")
	#define NCRYPT_KEY_DERIVATION_GROUP wstr("KEY_DERIVATION")
#endif

const NCRYPTBUFFER_VERSION = 0
const NCRYPTBUFFER_EMPTY = 0
const NCRYPTBUFFER_DATA = 1
const NCRYPTBUFFER_PROTECTION_DESCRIPTOR_STRING = 3
const NCRYPTBUFFER_PROTECTION_FLAGS = 4
const NCRYPTBUFFER_SSL_CLIENT_RANDOM = 20
const NCRYPTBUFFER_SSL_SERVER_RANDOM = 21
const NCRYPTBUFFER_SSL_HIGHEST_VERSION = 22
const NCRYPTBUFFER_SSL_CLEAR_KEY = 23
const NCRYPTBUFFER_SSL_KEY_ARG_DATA = 24
const NCRYPTBUFFER_PKCS_OID = 40
const NCRYPTBUFFER_PKCS_ALG_OID = 41
const NCRYPTBUFFER_PKCS_ALG_PARAM = 42
const NCRYPTBUFFER_PKCS_ALG_ID = 43
const NCRYPTBUFFER_PKCS_ATTRS = 44
const NCRYPTBUFFER_PKCS_KEY_NAME = 45
const NCRYPTBUFFER_PKCS_SECRET = 46
const NCRYPTBUFFER_CERT_BLOB = 47
const NCRYPT_NO_PADDING_FLAG = &h1
const NCRYPT_PAD_PKCS1_FLAG = &h2
const NCRYPT_PAD_OAEP_FLAG = &h4
const NCRYPT_PAD_PSS_FLAG = &h8

#if _WIN32_WINNT = &h0602
	const NCRYPT_PAD_CIPHER_FLAG = &h10
	const NCRYPT_CIPHER_NO_PADDING_FLAG = &h0
	const NCRYPT_CIPHER_BLOCK_PADDING_FLAG = &h1
	const NCRYPT_CIPHER_OTHER_PADDING_FLAG = &h2
#endif

type PFN_NCRYPT_ALLOC as function(byval cbSize as SIZE_T_) as LPVOID
type PFN_NCRYPT_FREE as sub(byval pv as LPVOID)

type NCRYPT_ALLOC_PARA
	cbSize as DWORD
	pfnAlloc as PFN_NCRYPT_ALLOC
	pfnFree as PFN_NCRYPT_FREE
end type

type NCryptBuffer as BCryptBuffer
type PNCryptBuffer as BCryptBuffer ptr
type NCryptBufferDesc as BCryptBufferDesc
type PNCryptBufferDesc as BCryptBufferDesc ptr
type NCRYPT_HANDLE as ULONG_PTR
type NCRYPT_PROV_HANDLE as ULONG_PTR
type NCRYPT_KEY_HANDLE as ULONG_PTR
type NCRYPT_HASH_HANDLE as ULONG_PTR
type NCRYPT_SECRET_HANDLE as ULONG_PTR

#if _WIN32_WINNT = &h0602
	type _NCRYPT_CIPHER_PADDING_INFO
		cbSize as ULONG
		dwFlags as DWORD
		pbIV as PUCHAR
		cbIV as ULONG
		pbOtherInfo as PUCHAR
		cbOtherInfo as ULONG
	end type

	type NCRYPT_CIPHER_PADDING_INFO as _NCRYPT_CIPHER_PADDING_INFO
	type PNCRYPT_CIPHER_PADDING_INFO as _NCRYPT_CIPHER_PADDING_INFO ptr
#endif

const NCRYPT_NO_KEY_VALIDATION = BCRYPT_NO_KEY_VALIDATION
const NCRYPT_MACHINE_KEY_FLAG = &h20
const NCRYPT_SILENT_FLAG = &h40
const NCRYPT_OVERWRITE_KEY_FLAG = &h80
const NCRYPT_WRITE_KEY_TO_LEGACY_STORE_FLAG = &h200
const NCRYPT_DO_NOT_FINALIZE_FLAG = &h400
const NCRYPT_PERSIST_ONLY_FLAG = &h40000000
const NCRYPT_PERSIST_FLAG = &h80000000
const NCRYPT_REGISTER_NOTIFY_FLAG = &h1
const NCRYPT_UNREGISTER_NOTIFY_FLAG = &h2
const NCRYPT_CIPHER_OPERATION = BCRYPT_CIPHER_OPERATION
const NCRYPT_HASH_OPERATION = BCRYPT_HASH_OPERATION
const NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION = BCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION
const NCRYPT_SECRET_AGREEMENT_OPERATION = BCRYPT_SECRET_AGREEMENT_OPERATION
const NCRYPT_SIGNATURE_OPERATION = BCRYPT_SIGNATURE_OPERATION
const NCRYPT_RNG_OPERATION = BCRYPT_RNG_OPERATION

#if _WIN32_WINNT = &h0602
	const NCRYPT_KEY_DERIVATION_OPERATION = BCRYPT_KEY_DERIVATION_OPERATION
#endif

const NCRYPT_MACHINE_KEY_FLAG = &h20
const NCRYPT_MACHINE_KEY_FLAG = &h20
const NCRYPT_SILENT_FLAG = &h40
const NCRYPT_MACHINE_KEY_FLAG = &h20
const NCRYPT_OVERWRITE_KEY_FLAG = &h80

type _NCryptAlgorithmName
	pszName as LPWSTR
	dwClass as DWORD
	dwAlgOperations as DWORD
	dwFlags as DWORD
end type

type NCryptAlgorithmName as _NCryptAlgorithmName

type NCryptKeyName
	pszName as LPWSTR
	pszAlgid as LPWSTR
	dwLegacyKeySpec as DWORD
	dwFlags as DWORD
end type

type NCryptProviderName
	pszName as LPWSTR
	pszComment as LPWSTR
end type

declare function NCryptOpenStorageProvider(byval phProvider as NCRYPT_PROV_HANDLE ptr, byval pszProviderName as LPCWSTR, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptEnumAlgorithms(byval hProvider as NCRYPT_PROV_HANDLE, byval dwAlgOperations as DWORD, byval pdwAlgCount as DWORD ptr, byval ppAlgList as NCryptAlgorithmName ptr ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptIsAlgSupported(byval hProvider as NCRYPT_PROV_HANDLE, byval pszAlgId as LPCWSTR, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptEnumKeys(byval hProvider as NCRYPT_PROV_HANDLE, byval pszScope as LPCWSTR, byval ppKeyName as NCryptKeyName ptr ptr, byval ppEnumState as PVOID ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptEnumStorageProviders(byval pdwProviderCount as DWORD ptr, byval ppProviderList as NCryptProviderName ptr ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptFreeBuffer(byval pvInput as PVOID) as SECURITY_STATUS
declare function NCryptOpenKey(byval hProvider as NCRYPT_PROV_HANDLE, byval phKey as NCRYPT_KEY_HANDLE ptr, byval pszKeyName as LPCWSTR, byval dwLegacyKeySpec as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptCreatePersistedKey(byval hProvider as NCRYPT_PROV_HANDLE, byval phKey as NCRYPT_KEY_HANDLE ptr, byval pszAlgId as LPCWSTR, byval pszKeyName as LPCWSTR, byval dwLegacyKeySpec as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS

#define NCRYPT_NAME_PROPERTY wstr("Name")
#define NCRYPT_UNIQUE_NAME_PROPERTY wstr("Unique Name")
#define NCRYPT_ALGORITHM_PROPERTY wstr("Algorithm Name")
#define NCRYPT_LENGTH_PROPERTY wstr("Length")
#define NCRYPT_LENGTHS_PROPERTY wstr("Lengths")
#define NCRYPT_BLOCK_LENGTH_PROPERTY wstr("Block Length")

#if _WIN32_WINNT = &h0602
	#define NCRYPT_CHAINING_MODE_PROPERTY wstr("Chaining Mode")
	#define NCRYPT_AUTH_TAG_LENGTH wstr("AuthTagLength")
#endif

#define NCRYPT_UI_POLICY_PROPERTY wstr("UI Policy")
#define NCRYPT_EXPORT_POLICY_PROPERTY wstr("Export Policy")
#define NCRYPT_WINDOW_HANDLE_PROPERTY wstr("HWND Handle")
#define NCRYPT_USE_CONTEXT_PROPERTY wstr("Use Context")
#define NCRYPT_IMPL_TYPE_PROPERTY wstr("Impl Type")
#define NCRYPT_KEY_USAGE_PROPERTY wstr("Key Usage")
#define NCRYPT_KEY_TYPE_PROPERTY wstr("Key Type")
#define NCRYPT_VERSION_PROPERTY wstr("Version")
#define NCRYPT_SECURITY_DESCR_SUPPORT_PROPERTY wstr("Security Descr Support")
#define NCRYPT_SECURITY_DESCR_PROPERTY wstr("Security Descr")
#define NCRYPT_USE_COUNT_ENABLED_PROPERTY wstr("Enabled Use Count")
#define NCRYPT_USE_COUNT_PROPERTY wstr("Use Count")
#define NCRYPT_LAST_MODIFIED_PROPERTY wstr("Modified")
#define NCRYPT_MAX_NAME_LENGTH_PROPERTY wstr("Max Name Length")
#define NCRYPT_ALGORITHM_GROUP_PROPERTY wstr("Algorithm Group")
#define NCRYPT_DH_PARAMETERS_PROPERTY BCRYPT_DH_PARAMETERS
#define NCRYPT_PROVIDER_HANDLE_PROPERTY wstr("Provider Handle")
#define NCRYPT_PIN_PROPERTY wstr("SmartCardPin")
#define NCRYPT_READER_PROPERTY wstr("SmartCardReader")
#define NCRYPT_SMARTCARD_GUID_PROPERTY wstr("SmartCardGuid")
#define NCRYPT_CERTIFICATE_PROPERTY wstr("SmartCardKeyCertificate")
#define NCRYPT_PIN_PROMPT_PROPERTY wstr("SmartCardPinPrompt")
#define NCRYPT_USER_CERTSTORE_PROPERTY wstr("SmartCardUserCertStore")
#define NCRYPT_ROOT_CERTSTORE_PROPERTY wstr("SmartcardRootCertStore")
#define NCRYPT_SECURE_PIN_PROPERTY wstr("SmartCardSecurePin")
#define NCRYPT_ASSOCIATED_ECDH_KEY wstr("SmartCardAssociatedECDHKey")
#define NCRYPT_SCARD_PIN_ID wstr("SmartCardPinId")
#define NCRYPT_SCARD_PIN_INFO wstr("SmartCardPinInfo")

#if _WIN32_WINNT = &h0602
	#define NCRYPT_READER_ICON_PROPERTY wstr("SmartCardReaderIcon")
	#define NCRYPT_KDF_SECRET_VALUE wstr("KDFKeySecret")
	#define NCRYPT_PCP_PLATFORM_TYPE_PROPERTY wstr("PCP_PLATFORM_TYPE")
	#define NCRYPT_PCP_PROVIDER_VERSION_PROPERTY wstr("PCP_PROVIDER_VERSION")
	#define NCRYPT_PCP_EKPUB_PROPERTY wstr("PCP_EKPUB")
	#define NCRYPT_PCP_EKCERT_PROPERTY wstr("PCP_EKCERT")
	#define NCRYPT_PCP_EKNVCERT_PROPERTY wstr("PCP_EKNVCERT")
	#define NCRYPT_PCP_SRKPUB_PROPERTY wstr("PCP_SRKPUB")
	#define NCRYPT_PCP_PCRTABLE_PROPERTY wstr("PCP_PCRTABLE")
	#define NCRYPT_PCP_CHANGEPASSWORD_PROPERTY wstr("PCP_CHANGEPASSWORD")
	#define NCRYPT_PCP_PASSWORD_REQUIRED_PROPERTY wstr("PCP_PASSWORD_REQUIRED")
	#define NCRYPT_PCP_USAGEAUTH_PROPERTY wstr("PCP_USAGEAUTH")
	#define NCRYPT_PCP_MIGRATIONPASSWORD_PROPERTY wstr("PCP_MIGRATIONPASSWORD")
	#define NCRYPT_PCP_EXPORT_ALLOWED_PROPERTY wstr("PCP_EXPORT_ALLOWED")
	#define NCRYPT_PCP_STORAGEPARENT_PROPERTY wstr("PCP_STORAGEPARENT")
	#define NCRYPT_PCP_PROVIDERHANDLE_PROPERTY wstr("PCP_PROVIDERMHANDLE")
	#define NCRYPT_PCP_PLATFORMHANDLE_PROPERTY wstr("PCP_PLATFORMHANDLE")
	#define NCRYPT_PCP_PLATFORM_BINDING_PCRMASK_PROPERTY wstr("PCP_PLATFORM_BINDING_PCRMASK")
	#define NCRYPT_PCP_PLATFORM_BINDING_PCRDIGESTLIST_PROPERTY wstr("PCP_PLATFORM_BINDING_PCRDIGESTLIST")
	#define NCRYPT_PCP_PLATFORM_BINDING_PCRDIGEST_PROPERTY wstr("PCP_PLATFORM_BINDING_PCRDIGEST")
	#define NCRYPT_PCP_KEY_USAGE_POLICY_PROPERTY wstr("PCP_KEY_USAGE_POLICY")
	#define NCRYPT_PCP_TPM12_IDBINDING_PROPERTY wstr("PCP_TPM12_IDBINDING")
	#define NCRYPT_PCP_TPM12_IDACTIVATION_PROPERTY wstr("PCP_TPM12_IDACTIVATION")
	#define NCRYPT_PCP_KEYATTESTATION_PROPERTY wstr("PCP_TPM12_KEYATTESTATION")
	#define NCRYPT_PCP_ALTERNATE_KEY_STORAGE_LOCATION_PROPERTY wstr("PCP_ALTERNATE_KEY_STORAGE_LOCATION")
	const NCRYPT_TPM12_PROVIDER = &h00010000
	const NCRYPT_PCP_SIGNATURE_KEY = &h1
	const NCRYPT_PCP_ENCRYPTION_KEY = &h2
	const NCRYPT_PCP_GENERIC_KEY = NCRYPT_PCP_SIGNATURE_KEY or NCRYPT_PCP_ENCRYPTION_KEY
	const NCRYPT_PCP_STORAGE_KEY = &h00000004
	const NCRYPT_PCP_IDENTITY_KEY = &h00000008
	#define NCRYPT_INITIALIZATION_VECTOR BCRYPT_INITIALIZATION_VECTOR
#endif

const NCRYPT_MAX_PROPERTY_NAME = 64
const NCRYPT_MAX_PROPERTY_DATA = &h100000
const NCRYPT_ALLOW_EXPORT_FLAG = &h1
const NCRYPT_ALLOW_PLAINTEXT_EXPORT_FLAG = &h2
const NCRYPT_ALLOW_ARCHIVING_FLAG = &h00000004
const NCRYPT_ALLOW_PLAINTEXT_ARCHIVING_FLAG = &h00000008
const NCRYPT_IMPL_HARDWARE_FLAG = &h1
const NCRYPT_IMPL_SOFTWARE_FLAG = &h2
const NCRYPT_IMPL_REMOVABLE_FLAG = &h00000008
const NCRYPT_IMPL_HARDWARE_RNG_FLAG = &h00000010
const NCRYPT_ALLOW_DECRYPT_FLAG = &h1
const NCRYPT_ALLOW_SIGNING_FLAG = &h2
const NCRYPT_ALLOW_KEY_AGREEMENT_FLAG = &h00000004
const NCRYPT_ALLOW_ALL_USAGES = &h00ffffff
const NCRYPT_UI_PROTECT_KEY_FLAG = &h1
const NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG = &h2
const NCRYPT_PERSIST_ONLY_FLAG = &h40000000
const NCRYPT_PERSIST_FLAG = &h80000000
const NCRYPT_PERSIST_ONLY_FLAG = &h40000000

type __NCRYPT_UI_POLICY
	dwVersion as DWORD
	dwFlags as DWORD
	pszCreationTitle as LPCWSTR
	pszFriendlyName as LPCWSTR
	pszDescription as LPCWSTR
end type

type NCRYPT_UI_POLICY as __NCRYPT_UI_POLICY

type __NCRYPT_SUPPORTED_LENGTHS
	dwMinLength as DWORD
	dwMaxLength as DWORD
	dwIncrement as DWORD
	dwDefaultLength as DWORD
end type

type NCRYPT_SUPPORTED_LENGTHS as __NCRYPT_SUPPORTED_LENGTHS
declare function NCryptGetProperty(byval hObject as NCRYPT_HANDLE, byval pszProperty as LPCWSTR, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptSetProperty(byval hObject as NCRYPT_HANDLE, byval pszProperty as LPCWSTR, byval pbInput as PBYTE, byval cbInput as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptFinalizeKey(byval hKey as NCRYPT_KEY_HANDLE, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptEncrypt(byval hKey as NCRYPT_KEY_HANDLE, byval pbInput as PBYTE, byval cbInput as DWORD, byval pPaddingInfo as any ptr, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptDecrypt(byval hKey as NCRYPT_KEY_HANDLE, byval pbInput as PBYTE, byval cbInput as DWORD, byval pPaddingInfo as any ptr, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS

#if _WIN32_WINNT = &h0602
	type _NCRYPT_KEY_BLOB_HEADER
		cbSize as ULONG
		dwMagic as ULONG
		cbAlgName as ULONG
		cbKeyData as ULONG
	end type

	type NCRYPT_KEY_BLOB_HEADER as _NCRYPT_KEY_BLOB_HEADER
	type PNCRYPT_KEY_BLOB_HEADER as _NCRYPT_KEY_BLOB_HEADER ptr
	const NCRYPT_CIPHER_KEY_BLOB_MAGIC = &h52485043
	const NCRYPT_PROTECTED_KEY_BLOB_MAGIC = &h4b545250
	#define NCRYPT_CIPHER_KEY_BLOB wstr("CipherKeyBlob")
	#define NCRYPT_PROTECTED_KEY_BLOB wstr("ProtectedKeyBlob")
#endif

#define NCRYPT_PKCS7_ENVELOPE_BLOB wstr("PKCS7_ENVELOPE")
#define NCRYPT_PKCS8_PRIVATE_KEY_BLOB wstr("PKCS8_PRIVATEKEY")
#define NCRYPT_OPAQUETRANSPORT_BLOB wstr("OpaqueTransport")
const NCRYPT_MACHINE_KEY_FLAG = &h20
const NCRYPT_EXPORT_LEGACY_FLAG = &h00000800
const NCRYPT_REGISTER_NOTIFY_FLAG = &h1
const NCRYPT_UNREGISTER_NOTIFY_FLAG = &h2
const NCRYPT_MACHINE_KEY_FLAG = &h20
#define NCRYPT_KEY_STORAGE_INTERFACE_VERSION BCRYPT_MAKE_INTERFACE_VERSION(1, 0)
#define NCRYPT_KEY_STORAGE_INTERFACE_VERSION_2 BCRYPT_MAKE_INTERFACE_VERSION(2, 0)

declare function NCryptImportKey(byval hProvider as NCRYPT_PROV_HANDLE, byval hImportKey as NCRYPT_KEY_HANDLE, byval pszBlobType as LPCWSTR, byval pParameterList as NCryptBufferDesc ptr, byval phKey as NCRYPT_KEY_HANDLE ptr, byval pbData as PBYTE, byval cbData as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptExportKey(byval hKey as NCRYPT_KEY_HANDLE, byval hExportKey as NCRYPT_KEY_HANDLE, byval pszBlobType as LPCWSTR, byval pParameterList as NCryptBufferDesc ptr, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptSignHash(byval hKey as NCRYPT_KEY_HANDLE, byval pPaddingInfo as any ptr, byval pbHashValue as PBYTE, byval cbHashValue as DWORD, byval pbSignature as PBYTE, byval cbSignature as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptVerifySignature(byval hKey as NCRYPT_KEY_HANDLE, byval pPaddingInfo as any ptr, byval pbHashValue as PBYTE, byval cbHashValue as DWORD, byval pbSignature as PBYTE, byval cbSignature as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptDeleteKey(byval hKey as NCRYPT_KEY_HANDLE, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptFreeObject(byval hObject as NCRYPT_HANDLE) as SECURITY_STATUS
declare function NCryptIsKeyHandle(byval hKey as NCRYPT_KEY_HANDLE) as WINBOOL
declare function NCryptTranslateHandle(byval phProvider as NCRYPT_PROV_HANDLE ptr, byval phKey as NCRYPT_KEY_HANDLE ptr, byval hLegacyProv as HCRYPTPROV, byval hLegacyKey as HCRYPTKEY, byval dwLegacyKeySpec as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptNotifyChangeKey(byval hProvider as NCRYPT_PROV_HANDLE, byval phEvent as HANDLE ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptSecretAgreement(byval hPrivKey as NCRYPT_KEY_HANDLE, byval hPubKey as NCRYPT_KEY_HANDLE, byval phAgreedSecret as NCRYPT_SECRET_HANDLE ptr, byval dwFlags as DWORD) as SECURITY_STATUS
declare function NCryptDeriveKey(byval hSharedSecret as NCRYPT_SECRET_HANDLE, byval pwszKDF as LPCWSTR, byval pParameterList as NCryptBufferDesc ptr, byval pbDerivedKey as PBYTE, byval cbDerivedKey as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as ULONG) as SECURITY_STATUS

#if _WIN32_WINNT = &h0602
	declare function NCryptKeyDerivation(byval hKey as NCRYPT_KEY_HANDLE, byval pParameterList as NCryptBufferDesc ptr, byval pbDerivedKey as PUCHAR, byval cbDerivedKey as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as ULONG) as SECURITY_STATUS
#endif

end extern
