#pragma once

#define _INC_NCRYPT

#if _WIN32_WINNT = &h0602
	extern "Windows"

	#define NCRYPTBUFFER_SSL_CLIENT_RANDOM 20
	#define NCRYPTBUFFER_SSL_SERVER_RANDOM 21
	#define NCRYPTBUFFER_SSL_HIGHEST_VERSION 22
	#define NCRYPTBUFFER_SSL_CLEAR_KEY 23
	#define NCRYPTBUFFER_SSL_KEY_ARG_DATA 24
	#define NCRYPTBUFFER_PKCS_OID 40
	#define NCRYPTBUFFER_PKCS_ALG_OID 41
	#define NCRYPTBUFFER_PKCS_ALG_PARAM 42
	#define NCRYPTBUFFER_PKCS_ALG_ID 43
	#define NCRYPTBUFFER_PKCS_ATTRS 44
	#define NCRYPTBUFFER_PKCS_KEY_NAME 45
	#define NCRYPTBUFFER_PKCS_SECRET 46
	#define NCRYPTBUFFER_CERT_BLOB 47
	type SECURITY_STATUS as LONG
	#define __SECSTATUS_DEFINED__
	#define __NCRYPT_KEY_HANDLE__

	type NCRYPT_KEY_HANDLE as ULONG_PTR
	type NCRYPT_PROV_HANDLE as ULONG_PTR
	type NCRYPT_SECRET_HANDLE as ULONG_PTR
	type NCRYPT_HANDLE as ULONG_PTR
	#define __HCRYPTKEY__
	type HCRYPTPROV as ULONG_PTR
	type HCRYPTKEY as ULONG_PTR

	type _NCryptBuffer
		cbBuffer as ULONG
		BufferType as ULONG
		pvBuffer as PVOID
	end type

	type NCryptBuffer as _NCryptBuffer
	type PNCryptBuffer as _NCryptBuffer ptr

	type _NCryptBufferDesc
		ulVersion as ULONG
		cBuffers as ULONG
		pBuffers as PNCryptBuffer
	end type

	type NCryptBufferDesc as _NCryptBufferDesc
	type PNCryptBufferDesc as _NCryptBufferDesc ptr

	type __NCRYPT_SUPPORTED_LENGTHS
		dwMinLength as DWORD
		dwMaxLength as DWORD
		dwIncrement as DWORD
		dwDefaultLength as DWORD
	end type

	type NCRYPT_SUPPORTED_LENGTHS as __NCRYPT_SUPPORTED_LENGTHS
	#define NCRYPT_UI_PROTECT_KEY_FLAG &h00000001
	#define NCRYPT_UI_FORCE_HIGH_PROTECTION_FLAG &h00000002

	type __NCRYPT_UI_POLICY
		dwVersion as DWORD
		dwFlags as DWORD
		pszCreationTitle as LPCWSTR
		pszFriendlyName as LPCWSTR
		pszDescription as LPCWSTR
	end type

	type NCRYPT_UI_POLICY as __NCRYPT_UI_POLICY

	type __NCRYPT_UI_POLICY_BLOB
		dwVersion as DWORD
		dwFlags as DWORD
		cbCreationTitle as DWORD
		cbFriendlyName as DWORD
		cbDescription as DWORD
	end type

	type NCRYPT_UI_POLICY_BLOB as __NCRYPT_UI_POLICY_BLOB

	type NCryptKeyName
		pszName as LPWSTR
		pszAlgid as LPWSTR
		dwLegacyKeySpec as DWORD
		dwFlags as DWORD
	end type

	#define NCRYPT_ASYMMETRIC_ENCRYPTION_INTERFACE &h00000003
	#define NCRYPT_SECRET_AGREEMENT_INTERFACE &h00000004
	#define NCRYPT_SIGNATURE_INTERFACE &h00000005

	type _NCryptAlgorithmName
		pszName as LPWSTR
		dwClass as DWORD
		dwAlgOperations as DWORD
		dwFlags as DWORD
	end type

	type NCryptAlgorithmName as _NCryptAlgorithmName

	type NCryptProviderName
		pszName as LPWSTR
		pszComment as LPWSTR
	end type

	declare function NCryptExportKey(byval hKey as NCRYPT_KEY_HANDLE, byval hExportKey as NCRYPT_KEY_HANDLE, byval pszBlobType as LPCWSTR, byval pParameterList as NCryptBufferDesc ptr, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptCreatePersistedKey(byval hProvider as NCRYPT_PROV_HANDLE, byval phKey as NCRYPT_KEY_HANDLE ptr, byval pszAlgId as LPCWSTR, byval pszKeyName as LPCWSTR, byval dwLegacyKeySpec as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptDecrypt(byval hKey as NCRYPT_KEY_HANDLE, byval pbInput as PBYTE, byval cbInput as DWORD, byval pPaddingInfo as any ptr, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptDeleteKey(byval hKey as NCRYPT_KEY_HANDLE, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptDeriveKey(byval hSharedSecret as NCRYPT_SECRET_HANDLE, byval pwszKDF as LPCWSTR, byval pParameterList as NCryptBufferDesc ptr, byval pbDerivedKey as PBYTE, byval cbDerivedKey as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as ULONG) as SECURITY_STATUS
	declare function NCryptEncrypt(byval hKey as NCRYPT_KEY_HANDLE, byval pbInput as PBYTE, byval cbInput as DWORD, byval pPaddingInfo as any ptr, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS

	#define NCRYPT_CIPHER_OPERATION &h00000001
	#define NCRYPT_HASH_OPERATION &h00000002
	#define NCRYPT_ASYMMETRIC_ENCRYPTION_OPERATION &h00000004
	#define NCRYPT_SECRET_AGREEMENT_OPERATION &h00000008
	#define NCRYPT_SIGNATURE_OPERATION &h00000010
	#define NCRYPT_RNG_OPERATION &h00000020

	declare function NCryptEnumAlgorithms(byval hProvider as NCRYPT_PROV_HANDLE, byval dwAlgOperations as DWORD, byval pdwAlgCount as DWORD ptr, byval ppAlgList as NCryptAlgorithmName ptr ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptEnumKeys(byval hProvider as NCRYPT_PROV_HANDLE, byval pszScope as LPCWSTR, byval ppKeyName as NCryptKeyName ptr ptr, byval ppEnumState as PVOID ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptEnumStorageProviders(byval pdwProviderCount as DWORD ptr, byval ppProviderList as NCryptProviderName ptr ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptFinalizeKey cdecl(byval hKey as NCRYPT_KEY_HANDLE, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptFreeBuffer(byval pvInput as PVOID) as SECURITY_STATUS
	declare function NCryptFreeObject(byval hObject as NCRYPT_HANDLE) as SECURITY_STATUS
	declare function NCryptGetProperty(byval hObject as NCRYPT_HANDLE, byval pszProperty as LPCWSTR, byval pbOutput as PBYTE, byval cbOutput as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptImportKey(byval hProvider as NCRYPT_PROV_HANDLE, byval hImportKey as NCRYPT_KEY_HANDLE, byval pszBlobType as LPCWSTR, byval pParameterList as NCryptBufferDesc ptr, byval phKey as NCRYPT_KEY_HANDLE ptr, byval pbData as PBYTE, byval cbData as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptIsAlgSupported(byval hProvider as NCRYPT_PROV_HANDLE, byval pszAlgId as LPCWSTR, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptIsKeyHandle(byval hKey as NCRYPT_KEY_HANDLE) as WINBOOL
	declare function NCryptNotifyChangeKey(byval hProvider as NCRYPT_PROV_HANDLE, byval phEvent as HANDLE ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptOpenKey(byval hProvider as NCRYPT_PROV_HANDLE, byval phKey as NCRYPT_KEY_HANDLE ptr, byval pszKeyName as LPCWSTR, byval dwLegacyKeySpec as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptOpenStorageProvider(byval phProvider as NCRYPT_PROV_HANDLE ptr, byval pszProviderName as LPCWSTR, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptSecretAgreement(byval hPrivKey as NCRYPT_KEY_HANDLE, byval hPubKey as NCRYPT_KEY_HANDLE, byval phSecret as NCRYPT_SECRET_HANDLE ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptSetProperty(byval hObject as NCRYPT_HANDLE, byval pszProperty as LPCWSTR, byval pbInput as PBYTE, byval cbInput as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptSignHash(byval hKey as NCRYPT_KEY_HANDLE, byval pPaddingInfo as any ptr, byval pbHashValue as PBYTE, byval cbHashValue as DWORD, byval pbSignature as PBYTE, byval cbSignature as DWORD, byval pcbResult as DWORD ptr, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptTranslateHandle(byval phProvider as NCRYPT_PROV_HANDLE ptr, byval phKey as NCRYPT_KEY_HANDLE ptr, byval hLegacyProv as HCRYPTPROV, byval hLegacyKey as HCRYPTKEY, byval dwLegacyKeySpec as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS
	declare function NCryptVerifySignature(byval hKey as NCRYPT_KEY_HANDLE, byval pPaddingInfo as any ptr, byval pbHashValue as PBYTE, byval cbHashValue as DWORD, byval pbSignature as PBYTE, byval cbSignature as DWORD, byval dwFlags as DWORD) as SECURITY_STATUS

	end extern
#endif
