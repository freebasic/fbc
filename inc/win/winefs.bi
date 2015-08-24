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

extern "Windows"

#define __WINEFS_H__

type _CERTIFICATE_BLOB
	dwCertEncodingType as DWORD
	cbData as DWORD
	pbData as PBYTE
end type

type EFS_CERTIFICATE_BLOB as _CERTIFICATE_BLOB
type PEFS_CERTIFICATE_BLOB as _CERTIFICATE_BLOB ptr

type _EFS_HASH_BLOB
	cbData as DWORD
	pbData as PBYTE
end type

type EFS_HASH_BLOB as _EFS_HASH_BLOB
type PEFS_HASH_BLOB as _EFS_HASH_BLOB ptr

type _EFS_RPC_BLOB
	cbData as DWORD
	pbData as PBYTE
end type

type EFS_RPC_BLOB as _EFS_RPC_BLOB
type PEFS_RPC_BLOB as _EFS_RPC_BLOB ptr

type _EFS_KEY_INFO
	dwVersion as DWORD
	Entropy as ULONG
	Algorithm as ALG_ID
	KeyLength as ULONG
end type

type EFS_KEY_INFO as _EFS_KEY_INFO
type PEFS_KEY_INFO as _EFS_KEY_INFO ptr

type _ENCRYPTION_CERTIFICATE
	cbTotalLength as DWORD
	pUserSid as SID ptr
	pCertBlob as PEFS_CERTIFICATE_BLOB
end type

type ENCRYPTION_CERTIFICATE as _ENCRYPTION_CERTIFICATE
type PENCRYPTION_CERTIFICATE as _ENCRYPTION_CERTIFICATE ptr
const MAX_SID_SIZE = 256

type _ENCRYPTION_CERTIFICATE_HASH
	cbTotalLength as DWORD
	pUserSid as SID ptr
	pHash as PEFS_HASH_BLOB
	lpDisplayInformation as LPWSTR
end type

type ENCRYPTION_CERTIFICATE_HASH as _ENCRYPTION_CERTIFICATE_HASH
type PENCRYPTION_CERTIFICATE_HASH as _ENCRYPTION_CERTIFICATE_HASH ptr

type _ENCRYPTION_CERTIFICATE_HASH_LIST
	nCert_Hash as DWORD
	pUsers as PENCRYPTION_CERTIFICATE_HASH ptr
end type

type ENCRYPTION_CERTIFICATE_HASH_LIST as _ENCRYPTION_CERTIFICATE_HASH_LIST
type PENCRYPTION_CERTIFICATE_HASH_LIST as _ENCRYPTION_CERTIFICATE_HASH_LIST ptr

type _ENCRYPTION_CERTIFICATE_LIST
	nUsers as DWORD
	pUsers as PENCRYPTION_CERTIFICATE ptr
end type

type ENCRYPTION_CERTIFICATE_LIST as _ENCRYPTION_CERTIFICATE_LIST
type PENCRYPTION_CERTIFICATE_LIST as _ENCRYPTION_CERTIFICATE_LIST ptr
declare function QueryUsersOnEncryptedFile(byval lpFileName as LPCWSTR, byval pUsers as PENCRYPTION_CERTIFICATE_HASH_LIST ptr) as DWORD
declare function QueryRecoveryAgentsOnEncryptedFile(byval lpFileName as LPCWSTR, byval pRecoveryAgents as PENCRYPTION_CERTIFICATE_HASH_LIST ptr) as DWORD
declare function RemoveUsersFromEncryptedFile(byval lpFileName as LPCWSTR, byval pHashes as PENCRYPTION_CERTIFICATE_HASH_LIST) as DWORD
declare function AddUsersToEncryptedFile(byval lpFileName as LPCWSTR, byval pUsers as PENCRYPTION_CERTIFICATE_LIST) as DWORD
declare function SetUserFileEncryptionKey(byval pEncryptionCertificate as PENCRYPTION_CERTIFICATE) as DWORD
declare sub FreeEncryptionCertificateHashList(byval pHashes as PENCRYPTION_CERTIFICATE_HASH_LIST)
declare function EncryptionDisable(byval DirPath as LPCWSTR, byval Disable as WINBOOL) as WINBOOL
declare function DuplicateEncryptionInfoFile(byval SrcFileName as LPCWSTR, byval DstFileName as LPCWSTR, byval dwCreationDistribution as DWORD, byval dwAttributes as DWORD, byval lpSecurityAttributes as const LPSECURITY_ATTRIBUTES) as DWORD

end extern
