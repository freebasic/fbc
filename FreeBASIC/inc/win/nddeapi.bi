''
''
'' nddeapi -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_nddeapi_bi__
#define __win_nddeapi_bi__

#inclib "nddeapi"

#define CNLEN 15
#define UNCLEN (15+2)
#define SEP_CHAR asc(",")
#define BAR_CHAR "|"
#define NDDE_NO_ERROR 0
#define NDDE_ACCESS_DENIED 1
#define NDDE_BUF_TOO_SMALL 2
#define NDDE_ERROR_MORE_DATA 3
#define NDDE_INVALID_SERVER 4
#define NDDE_INVALID_SHARE 5
#define NDDE_INVALID_PARAMETER 6
#define NDDE_INVALID_LEVEL 7
#define NDDE_INVALID_PASSWORD 8
#define NDDE_INVALID_ITEMNAME 9
#define NDDE_INVALID_TOPIC 10
#define NDDE_INTERNAL_ERROR 11
#define NDDE_OUT_OF_MEMORY 12
#define NDDE_INVALID_APPNAME 13
#define NDDE_NOT_IMPLEMENTED 14
#define NDDE_SHARE_ALREADY_EXIST 15
#define NDDE_SHARE_NOT_EXIST 16
#define NDDE_INVALID_FILENAME 17
#define NDDE_NOT_RUNNING 18
#define NDDE_INVALID_WINDOW 19
#define NDDE_INVALID_SESSION 20
#define NDDE_INVALID_ITEM_LIST 21
#define NDDE_SHARE_DATA_CORRUPTED 22
#define NDDE_REGISTRY_ERROR 23
#define NDDE_CANT_ACCESS_SERVER 24
#define NDDE_INVALID_SPECIAL_COMMAND 25
#define NDDE_INVALID_SECURITY_DESC 26
#define NDDE_TRUST_SHARE_FAIL 27
#define MAX_NDDESHARENAME 256
#define MAX_DOMAINNAME 15
#define MAX_USERNAME 15
#define MAX_APPNAME 255
#define MAX_TOPICNAME 255
#define MAX_ITEMNAME 255
#define NDDEF_NOPASSWORDPROMPT &h0001
#define NDDEF_NOCACHELOOKUP &h0002
#define NDDEF_STRIP_NDDE &h0004
#define SHARE_TYPE_OLD &h01
#define SHARE_TYPE_NEW &h02
#define SHARE_TYPE_STATIC &h04
#define NDDE_TRUST_SHARE_START &h80000000L
#define NDDE_TRUST_SHARE_INIT &h40000000L
#define NDDE_TRUST_SHARE_DEL &h20000000L
#define NDDE_TRUST_CMD_SHOW &h10000000L
#define NDDE_CMD_SHOW_MASK &h0000FFFFL

type NDdeShareInfo_tag
	lRevision as LONG
	lpszShareName as LPTSTR
	lShareType as LONG
	lpszAppTopicList as LPTSTR
	fSharedFlag as LONG
	fService as LONG
	fStartAppFlag as LONG
	nCmdShow as LONG
	qModifyId(0 to 2-1) as LONG
	cNumItems as LONG
	lpszItemList as LPTSTR
end type

#ifdef UNICODE
declare function NDdeGetErrorString alias "NDdeGetErrorStringW" (byval as UINT, byval as LPWSTR, byval as DWORD) as UINT
declare function NDdeGetShareSecurity alias "NDdeGetShareSecurityW" (byval as LPWSTR, byval as LPWSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PDWORD) as UINT
declare function NDdeGetTrustedShare alias "NDdeGetTrustedShareW" (byval as LPWSTR, byval as LPWSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD) as UINT
declare function NDdeIsValidShareName alias "NDdeIsValidShareNameW" (byval as LPWSTR) as BOOL
declare function NDdeIsValidAppTopicList alias "NDdeIsValidAppTopicListW" (byval as LPWSTR) as BOOL
declare function NDdeSetShareSecurity alias "NDdeSetShareSecurityW" (byval as LPWSTR, byval as LPWSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as UINT
declare function NDdeSetTrustedShare alias "NDdeSetTrustedShareW" (byval as LPWSTR, byval as LPWSTR, byval as DWORD) as UINT
declare function NDdeShareAdd alias "NDdeShareAddW" (byval as LPWSTR, byval as UINT, byval as PSECURITY_DESCRIPTOR, byval as PBYTE, byval as DWORD) as UINT
declare function NDdeShareDel alias "NDdeShareDelW" (byval as LPWSTR, byval as LPWSTR, byval as UINT) as UINT
declare function NDdeShareEnum alias "NDdeShareEnumW" (byval as LPWSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as UINT
declare function NDdeShareGetInfo alias "NDdeShareGetInfoW" (byval as LPWSTR, byval as LPWSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PWORD) as UINT
declare function NDdeShareSetInfo alias "NDdeShareSetInfoW" (byval as LPWSTR, byval as LPWSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as WORD) as UINT
declare function NDdeTrustedShareEnum alias "NDdeTrustedShareEnumW" (byval as LPWSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as UINT

#else
declare function NDdeGetErrorString alias "NDdeGetErrorStringA" (byval as UINT, byval as LPSTR, byval as DWORD) as UINT
declare function NDdeGetShareSecurity alias "NDdeGetShareSecurityA" (byval as LPSTR, byval as LPSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR, byval as DWORD, byval as PDWORD) as UINT
declare function NDdeGetTrustedShare alias "NDdeGetTrustedShareA" (byval as LPSTR, byval as LPSTR, byval as PDWORD, byval as PDWORD, byval as PDWORD) as UINT
declare function NDdeIsValidShareName alias "NDdeIsValidShareNameA" (byval as LPSTR) as BOOL
declare function NDdeIsValidAppTopicList alias "NDdeIsValidAppTopicListA" (byval as LPSTR) as BOOL
declare function NDdeSetShareSecurity alias "NDdeSetShareSecurityA" (byval as LPSTR, byval as LPSTR, byval as SECURITY_INFORMATION, byval as PSECURITY_DESCRIPTOR) as UINT
declare function NDdeSetTrustedShare alias "NDdeSetTrustedShareA" (byval as LPSTR, byval as LPSTR, byval as DWORD) as UINT
declare function NDdeShareAdd alias "NDdeShareAddA" (byval as LPSTR, byval as UINT, byval as PSECURITY_DESCRIPTOR, byval as PBYTE, byval as DWORD) as UINT
declare function NDdeShareDel alias "NDdeShareDelA" (byval as LPSTR, byval as LPSTR, byval as UINT) as UINT
declare function NDdeShareEnum alias "NDdeShareEnumA" (byval as LPSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as UINT
declare function NDdeShareGetInfo alias "NDdeShareGetInfoA" (byval as LPSTR, byval as LPSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PWORD) as UINT
declare function NDdeShareSetInfo alias "NDdeShareSetInfoA" (byval as LPSTR, byval as LPSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as WORD) as UINT
declare function NDdeTrustedShareEnum alias "NDdeTrustedShareEnumA" (byval as LPSTR, byval as UINT, byval as PBYTE, byval as DWORD, byval as PDWORD, byval as PDWORD) as UINT

#endif

#endif
