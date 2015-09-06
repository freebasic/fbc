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

#inclib "wininet"

#include once "_mingw_unicode.bi"

extern "Windows"

#define _WININET_
type HINTERNET as LPVOID
type LPHINTERNET as HINTERNET ptr
type INTERNET_PORT as WORD
type LPINTERNET_PORT as INTERNET_PORT ptr

const INTERNET_INVALID_PORT_NUMBER = 0
const INTERNET_DEFAULT_FTP_PORT = 21
const INTERNET_DEFAULT_GOPHER_PORT = 70
const INTERNET_DEFAULT_HTTP_PORT = 80
const INTERNET_DEFAULT_HTTPS_PORT = 443
const INTERNET_DEFAULT_SOCKS_PORT = 1080
const INTERNET_MAX_HOST_NAME_LENGTH = 256
const INTERNET_MAX_USER_NAME_LENGTH = 128
const INTERNET_MAX_PASSWORD_LENGTH = 128
const INTERNET_MAX_PORT_NUMBER_LENGTH = 5
const INTERNET_MAX_PORT_NUMBER_VALUE = 65535
const INTERNET_MAX_PATH_LENGTH = 2048
const INTERNET_MAX_SCHEME_LENGTH = 32
#define INTERNET_MAX_URL_LENGTH ((INTERNET_MAX_SCHEME_LENGTH + sizeof("://")) + INTERNET_MAX_PATH_LENGTH)
const INTERNET_KEEP_ALIVE_UNKNOWN = cast(DWORD, -1)
const INTERNET_KEEP_ALIVE_ENABLED = 1
const INTERNET_KEEP_ALIVE_DISABLED = 0
const INTERNET_REQFLAG_FROM_CACHE = &h00000001
const INTERNET_REQFLAG_ASYNC = &h00000002
const INTERNET_REQFLAG_VIA_PROXY = &h00000004
const INTERNET_REQFLAG_NO_HEADERS = &h00000008
const INTERNET_REQFLAG_PASSIVE = &h00000010
const INTERNET_REQFLAG_CACHE_WRITE_DISABLED = &h00000040
const INTERNET_REQFLAG_NET_TIMEOUT = &h00000080
const INTERNET_FLAG_RELOAD = &h80000000
const INTERNET_FLAG_RAW_DATA = &h40000000
const INTERNET_FLAG_EXISTING_CONNECT = &h20000000
const INTERNET_FLAG_ASYNC = &h10000000
const INTERNET_FLAG_PASSIVE = &h08000000
const INTERNET_FLAG_NO_CACHE_WRITE = &h04000000
const INTERNET_FLAG_DONT_CACHE = INTERNET_FLAG_NO_CACHE_WRITE
const INTERNET_FLAG_MAKE_PERSISTENT = &h02000000
const INTERNET_FLAG_FROM_CACHE = &h01000000
const INTERNET_FLAG_OFFLINE = INTERNET_FLAG_FROM_CACHE
const INTERNET_FLAG_SECURE = &h00800000
const INTERNET_FLAG_KEEP_CONNECTION = &h00400000
const INTERNET_FLAG_NO_AUTO_REDIRECT = &h00200000
const INTERNET_FLAG_READ_PREFETCH = &h00100000
const INTERNET_FLAG_NO_COOKIES = &h00080000
const INTERNET_FLAG_NO_AUTH = &h00040000
const INTERNET_FLAG_RESTRICTED_ZONE = &h00020000
const INTERNET_FLAG_CACHE_IF_NET_FAIL = &h00010000
const INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP = &h00008000
const INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS = &h00004000
const INTERNET_FLAG_IGNORE_CERT_DATE_INVALID = &h00002000
const INTERNET_FLAG_IGNORE_CERT_CN_INVALID = &h00001000
const INTERNET_FLAG_RESYNCHRONIZE = &h00000800
const INTERNET_FLAG_HYPERLINK = &h00000400
const INTERNET_FLAG_NO_UI = &h00000200
const INTERNET_FLAG_PRAGMA_NOCACHE = &h00000100
const INTERNET_FLAG_CACHE_ASYNC = &h00000080
const INTERNET_FLAG_FORMS_SUBMIT = &h00000040
const INTERNET_FLAG_FWD_BACK = &h00000020
const INTERNET_FLAG_NEED_FILE = &h00000010
const INTERNET_FLAG_MUST_CACHE_REQUEST = INTERNET_FLAG_NEED_FILE
const SECURITY_INTERNET_MASK = ((INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID) or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS) or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP
#define INTERNET_FLAGS_MASK (((((((((((((((((((((((((((INTERNET_FLAG_RELOAD or INTERNET_FLAG_RAW_DATA) or INTERNET_FLAG_EXISTING_CONNECT) or INTERNET_FLAG_ASYNC) or INTERNET_FLAG_PASSIVE) or INTERNET_FLAG_NO_CACHE_WRITE) or INTERNET_FLAG_MAKE_PERSISTENT) or INTERNET_FLAG_FROM_CACHE) or INTERNET_FLAG_SECURE) or INTERNET_FLAG_KEEP_CONNECTION) or INTERNET_FLAG_NO_AUTO_REDIRECT) or INTERNET_FLAG_READ_PREFETCH) or INTERNET_FLAG_NO_COOKIES) or INTERNET_FLAG_NO_AUTH) or INTERNET_FLAG_CACHE_IF_NET_FAIL) or SECURITY_INTERNET_MASK) or INTERNET_FLAG_RESYNCHRONIZE) or INTERNET_FLAG_HYPERLINK) or INTERNET_FLAG_NO_UI) or INTERNET_FLAG_PRAGMA_NOCACHE) or INTERNET_FLAG_CACHE_ASYNC) or INTERNET_FLAG_FORMS_SUBMIT) or INTERNET_FLAG_NEED_FILE) or INTERNET_FLAG_RESTRICTED_ZONE) or INTERNET_FLAG_TRANSFER_BINARY) or INTERNET_FLAG_TRANSFER_ASCII) or INTERNET_FLAG_FWD_BACK) or INTERNET_FLAG_BGUPDATE)
const INTERNET_ERROR_MASK_INSERT_CDROM = &h1
const INTERNET_ERROR_MASK_COMBINED_SEC_CERT = &h2
const INTERNET_ERROR_MASK_NEED_MSN_SSPI_PKG = &h4
const INTERNET_ERROR_MASK_LOGIN_FAILURE_DISPLAY_ENTITY_BODY = &h8
#define INTERNET_OPTIONS_MASK (not INTERNET_FLAGS_MASK)
const WININET_API_FLAG_ASYNC = &h00000001
const WININET_API_FLAG_SYNC = &h00000004
const WININET_API_FLAG_USE_CONTEXT = &h00000008
const INTERNET_NO_CALLBACK = 0

type INTERNET_SCHEME as long
enum
	INTERNET_SCHEME_PARTIAL = -2
	INTERNET_SCHEME_UNKNOWN = -1
	INTERNET_SCHEME_DEFAULT = 0
	INTERNET_SCHEME_FTP
	INTERNET_SCHEME_GOPHER
	INTERNET_SCHEME_HTTP
	INTERNET_SCHEME_HTTPS
	INTERNET_SCHEME_FILE
	INTERNET_SCHEME_NEWS
	INTERNET_SCHEME_MAILTO
	INTERNET_SCHEME_SOCKS
	INTERNET_SCHEME_JAVASCRIPT
	INTERNET_SCHEME_VBSCRIPT
	INTERNET_SCHEME_RES
	INTERNET_SCHEME_FIRST = INTERNET_SCHEME_FTP
	INTERNET_SCHEME_LAST = INTERNET_SCHEME_RES
end enum

type LPINTERNET_SCHEME as INTERNET_SCHEME ptr

#ifdef __FB_64BIT__
	type INTERNET_ASYNC_RESULT
		dwResult as DWORD_PTR
		dwError as DWORD
	end type
#else
	type INTERNET_ASYNC_RESULT field = 4
		dwResult as DWORD_PTR
		dwError as DWORD
	end type
#endif

type LPINTERNET_ASYNC_RESULT as INTERNET_ASYNC_RESULT ptr

#ifdef __FB_64BIT__
	type INTERNET_DIAGNOSTIC_SOCKET_INFO
		Socket as DWORD_PTR
		SourcePort as DWORD
		DestPort as DWORD
		Flags as DWORD
	end type
#else
	type INTERNET_DIAGNOSTIC_SOCKET_INFO field = 4
		Socket as DWORD_PTR
		SourcePort as DWORD
		DestPort as DWORD
		Flags as DWORD
	end type
#endif

type LPINTERNET_DIAGNOSTIC_SOCKET_INFO as INTERNET_DIAGNOSTIC_SOCKET_INFO ptr
const IDSI_FLAG_KEEP_ALIVE = &h00000001
const IDSI_FLAG_SECURE = &h00000002
const IDSI_FLAG_PROXY = &h00000004
const IDSI_FLAG_TUNNEL = &h00000008

#ifdef __FB_64BIT__
	type INTERNET_PROXY_INFO
		dwAccessType as DWORD
		lpszProxy as LPCTSTR
		lpszProxyBypass as LPCTSTR
	end type
#else
	type INTERNET_PROXY_INFO field = 4
		dwAccessType as DWORD
		lpszProxy as LPCTSTR
		lpszProxyBypass as LPCTSTR
	end type
#endif

type LPINTERNET_PROXY_INFO as INTERNET_PROXY_INFO ptr

#ifdef __FB_64BIT__
	union INTERNET_PER_CONN_OPTIONA_Value
		dwValue as DWORD
		pszValue as LPSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONA
		dwOption as DWORD
		Value as INTERNET_PER_CONN_OPTIONA_Value
	end type
#else
	union INTERNET_PER_CONN_OPTIONA_Value field = 4
		dwValue as DWORD
		pszValue as LPSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONA field = 4
		dwOption as DWORD
		Value as INTERNET_PER_CONN_OPTIONA_Value
	end type
#endif

type LPINTERNET_PER_CONN_OPTIONA as INTERNET_PER_CONN_OPTIONA ptr

#ifdef __FB_64BIT__
	union INTERNET_PER_CONN_OPTIONW_Value
		dwValue as DWORD
		pszValue as LPWSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONW
		dwOption as DWORD
		Value as INTERNET_PER_CONN_OPTIONW_Value
	end type
#else
	union INTERNET_PER_CONN_OPTIONW_Value field = 4
		dwValue as DWORD
		pszValue as LPWSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONW field = 4
		dwOption as DWORD
		Value as INTERNET_PER_CONN_OPTIONW_Value
	end type
#endif

type LPINTERNET_PER_CONN_OPTIONW as INTERNET_PER_CONN_OPTIONW ptr

#ifdef UNICODE
	type INTERNET_PER_CONN_OPTION as INTERNET_PER_CONN_OPTIONW
	type LPINTERNET_PER_CONN_OPTION as LPINTERNET_PER_CONN_OPTIONW
#else
	type INTERNET_PER_CONN_OPTION as INTERNET_PER_CONN_OPTIONA
	type LPINTERNET_PER_CONN_OPTION as LPINTERNET_PER_CONN_OPTIONA
#endif

#ifdef __FB_64BIT__
	type INTERNET_PER_CONN_OPTION_LISTA
		dwSize as DWORD
		pszConnection as LPSTR
		dwOptionCount as DWORD
		dwOptionError as DWORD
		pOptions as LPINTERNET_PER_CONN_OPTIONA
	end type
#else
	type INTERNET_PER_CONN_OPTION_LISTA field = 4
		dwSize as DWORD
		pszConnection as LPSTR
		dwOptionCount as DWORD
		dwOptionError as DWORD
		pOptions as LPINTERNET_PER_CONN_OPTIONA
	end type
#endif

type LPINTERNET_PER_CONN_OPTION_LISTA as INTERNET_PER_CONN_OPTION_LISTA ptr

#ifdef __FB_64BIT__
	type INTERNET_PER_CONN_OPTION_LISTW
		dwSize as DWORD
		pszConnection as LPWSTR
		dwOptionCount as DWORD
		dwOptionError as DWORD
		pOptions as LPINTERNET_PER_CONN_OPTIONW
	end type
#else
	type INTERNET_PER_CONN_OPTION_LISTW field = 4
		dwSize as DWORD
		pszConnection as LPWSTR
		dwOptionCount as DWORD
		dwOptionError as DWORD
		pOptions as LPINTERNET_PER_CONN_OPTIONW
	end type
#endif

type LPINTERNET_PER_CONN_OPTION_LISTW as INTERNET_PER_CONN_OPTION_LISTW ptr

#ifdef UNICODE
	type INTERNET_PER_CONN_OPTION_LIST as INTERNET_PER_CONN_OPTION_LISTW
	type LPINTERNET_PER_CONN_OPTION_LIST as LPINTERNET_PER_CONN_OPTION_LISTW
#else
	type INTERNET_PER_CONN_OPTION_LIST as INTERNET_PER_CONN_OPTION_LISTA
	type LPINTERNET_PER_CONN_OPTION_LIST as LPINTERNET_PER_CONN_OPTION_LISTA
#endif

const INTERNET_PER_CONN_FLAGS = 1
const INTERNET_PER_CONN_PROXY_SERVER = 2
const INTERNET_PER_CONN_PROXY_BYPASS = 3
const INTERNET_PER_CONN_AUTOCONFIG_URL = 4
const INTERNET_PER_CONN_AUTODISCOVERY_FLAGS = 5
const INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL = 6
const INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS = 7
const INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME = 8
const INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL = 9
const INTERNET_PER_CONN_FLAGS_UI = 10
const PROXY_TYPE_DIRECT = &h00000001
const PROXY_TYPE_PROXY = &h00000002
const PROXY_TYPE_AUTO_PROXY_URL = &h00000004
const PROXY_TYPE_AUTO_DETECT = &h00000008
const AUTO_PROXY_FLAG_USER_SET = &h00000001
const AUTO_PROXY_FLAG_ALWAYS_DETECT = &h00000002
const AUTO_PROXY_FLAG_DETECTION_RUN = &h00000004
const AUTO_PROXY_FLAG_MIGRATED = &h00000008
const AUTO_PROXY_FLAG_DONT_CACHE_PROXY_RESULT = &h00000010
const AUTO_PROXY_FLAG_CACHE_INIT_RUN = &h00000020
const AUTO_PROXY_FLAG_DETECTION_SUSPECT = &h00000040

#ifdef __FB_64BIT__
	type INTERNET_VERSION_INFO
		dwMajorVersion as DWORD
		dwMinorVersion as DWORD
	end type
#else
	type INTERNET_VERSION_INFO field = 4
		dwMajorVersion as DWORD
		dwMinorVersion as DWORD
	end type
#endif

type LPINTERNET_VERSION_INFO as INTERNET_VERSION_INFO ptr

#ifdef __FB_64BIT__
	type HTTP_VERSION_INFO
		dwMajorVersion as DWORD
		dwMinorVersion as DWORD
	end type
#else
	type HTTP_VERSION_INFO field = 4
		dwMajorVersion as DWORD
		dwMinorVersion as DWORD
	end type
#endif

type LPHTTP_VERSION_INFO as HTTP_VERSION_INFO ptr

#ifdef __FB_64BIT__
	type INTERNET_CONNECTED_INFO
		dwConnectedState as DWORD
		dwFlags as DWORD
	end type
#else
	type INTERNET_CONNECTED_INFO field = 4
		dwConnectedState as DWORD
		dwFlags as DWORD
	end type
#endif

type LPINTERNET_CONNECTED_INFO as INTERNET_CONNECTED_INFO ptr
const ISO_FORCE_DISCONNECTED = &h00000001

#ifdef __FB_64BIT__
	type URL_COMPONENTSA
		dwStructSize as DWORD
		lpszScheme as LPSTR
		dwSchemeLength as DWORD
		nScheme as INTERNET_SCHEME
		lpszHostName as LPSTR
		dwHostNameLength as DWORD
		nPort as INTERNET_PORT
		lpszUserName as LPSTR
		dwUserNameLength as DWORD
		lpszPassword as LPSTR
		dwPasswordLength as DWORD
		lpszUrlPath as LPSTR
		dwUrlPathLength as DWORD
		lpszExtraInfo as LPSTR
		dwExtraInfoLength as DWORD
	end type
#else
	type URL_COMPONENTSA field = 4
		dwStructSize as DWORD
		lpszScheme as LPSTR
		dwSchemeLength as DWORD
		nScheme as INTERNET_SCHEME
		lpszHostName as LPSTR
		dwHostNameLength as DWORD
		nPort as INTERNET_PORT
		lpszUserName as LPSTR
		dwUserNameLength as DWORD
		lpszPassword as LPSTR
		dwPasswordLength as DWORD
		lpszUrlPath as LPSTR
		dwUrlPathLength as DWORD
		lpszExtraInfo as LPSTR
		dwExtraInfoLength as DWORD
	end type
#endif

type LPURL_COMPONENTSA as URL_COMPONENTSA ptr

#ifdef __FB_64BIT__
	type URL_COMPONENTSW
		dwStructSize as DWORD
		lpszScheme as LPWSTR
		dwSchemeLength as DWORD
		nScheme as INTERNET_SCHEME
		lpszHostName as LPWSTR
		dwHostNameLength as DWORD
		nPort as INTERNET_PORT
		lpszUserName as LPWSTR
		dwUserNameLength as DWORD
		lpszPassword as LPWSTR
		dwPasswordLength as DWORD
		lpszUrlPath as LPWSTR
		dwUrlPathLength as DWORD
		lpszExtraInfo as LPWSTR
		dwExtraInfoLength as DWORD
	end type
#else
	type URL_COMPONENTSW field = 4
		dwStructSize as DWORD
		lpszScheme as LPWSTR
		dwSchemeLength as DWORD
		nScheme as INTERNET_SCHEME
		lpszHostName as LPWSTR
		dwHostNameLength as DWORD
		nPort as INTERNET_PORT
		lpszUserName as LPWSTR
		dwUserNameLength as DWORD
		lpszPassword as LPWSTR
		dwPasswordLength as DWORD
		lpszUrlPath as LPWSTR
		dwUrlPathLength as DWORD
		lpszExtraInfo as LPWSTR
		dwExtraInfoLength as DWORD
	end type
#endif

type LPURL_COMPONENTSW as URL_COMPONENTSW ptr

#ifdef UNICODE
	type URL_COMPONENTS as URL_COMPONENTSW
	type LPURL_COMPONENTS as LPURL_COMPONENTSW
#else
	type URL_COMPONENTS as URL_COMPONENTSA
	type LPURL_COMPONENTS as LPURL_COMPONENTSA
#endif

#ifdef __FB_64BIT__
	type INTERNET_CERTIFICATE_INFO
		ftExpiry as FILETIME
		ftStart as FILETIME
		lpszSubjectInfo as LPTSTR
		lpszIssuerInfo as LPTSTR
		lpszProtocolName as LPTSTR
		lpszSignatureAlgName as LPTSTR
		lpszEncryptionAlgName as LPTSTR
		dwKeySize as DWORD
	end type
#else
	type INTERNET_CERTIFICATE_INFO field = 4
		ftExpiry as FILETIME
		ftStart as FILETIME
		lpszSubjectInfo as LPTSTR
		lpszIssuerInfo as LPTSTR
		lpszProtocolName as LPTSTR
		lpszSignatureAlgName as LPTSTR
		lpszEncryptionAlgName as LPTSTR
		dwKeySize as DWORD
	end type
#endif

type LPINTERNET_CERTIFICATE_INFO as INTERNET_CERTIFICATE_INFO ptr

#ifdef __FB_64BIT__
	type _INTERNET_BUFFERSA
		dwStructSize as DWORD
		Next as _INTERNET_BUFFERSA ptr
		lpcszHeader as LPCSTR
		dwHeadersLength as DWORD
		dwHeadersTotal as DWORD
		lpvBuffer as LPVOID
		dwBufferLength as DWORD
		dwBufferTotal as DWORD
		dwOffsetLow as DWORD
		dwOffsetHigh as DWORD
	end type
#else
	type _INTERNET_BUFFERSA field = 4
		dwStructSize as DWORD
		Next as _INTERNET_BUFFERSA ptr
		lpcszHeader as LPCSTR
		dwHeadersLength as DWORD
		dwHeadersTotal as DWORD
		lpvBuffer as LPVOID
		dwBufferLength as DWORD
		dwBufferTotal as DWORD
		dwOffsetLow as DWORD
		dwOffsetHigh as DWORD
	end type
#endif

type INTERNET_BUFFERSA as _INTERNET_BUFFERSA
type LPINTERNET_BUFFERSA as _INTERNET_BUFFERSA ptr

#ifdef __FB_64BIT__
	type _INTERNET_BUFFERSW
		dwStructSize as DWORD
		Next as _INTERNET_BUFFERSW ptr
		lpcszHeader as LPCWSTR
		dwHeadersLength as DWORD
		dwHeadersTotal as DWORD
		lpvBuffer as LPVOID
		dwBufferLength as DWORD
		dwBufferTotal as DWORD
		dwOffsetLow as DWORD
		dwOffsetHigh as DWORD
	end type
#else
	type _INTERNET_BUFFERSW field = 4
		dwStructSize as DWORD
		Next as _INTERNET_BUFFERSW ptr
		lpcszHeader as LPCWSTR
		dwHeadersLength as DWORD
		dwHeadersTotal as DWORD
		lpvBuffer as LPVOID
		dwBufferLength as DWORD
		dwBufferTotal as DWORD
		dwOffsetLow as DWORD
		dwOffsetHigh as DWORD
	end type
#endif

type INTERNET_BUFFERSW as _INTERNET_BUFFERSW
type LPINTERNET_BUFFERSW as _INTERNET_BUFFERSW ptr

#ifdef UNICODE
	type INTERNET_BUFFERS as INTERNET_BUFFERSW
	type LPINTERNET_BUFFERS as LPINTERNET_BUFFERSW
#else
	type INTERNET_BUFFERS as INTERNET_BUFFERSA
	type LPINTERNET_BUFFERS as LPINTERNET_BUFFERSA
	declare function InternetTimeFromSystemTime(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPSTR, byval cbTime as DWORD) as WINBOOL
#endif

declare function InternetTimeFromSystemTimeA(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPSTR, byval cbTime as DWORD) as WINBOOL
declare function InternetTimeFromSystemTimeW(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPWSTR, byval cbTime as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetTimeFromSystemTime alias "InternetTimeFromSystemTimeW"(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPWSTR, byval cbTime as DWORD) as WINBOOL
#endif

const INTERNET_RFC1123_FORMAT = 0
const INTERNET_RFC1123_BUFSIZE = 30

#ifndef UNICODE
	declare function InternetTimeToSystemTime(byval lpszTime as LPCSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetTimeToSystemTimeA(byval lpszTime as LPCSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL
declare function InternetTimeToSystemTimeW(byval lpszTime as LPCWSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetTimeToSystemTime alias "InternetTimeToSystemTimeW"(byval lpszTime as LPCWSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetCrackUrlA(byval lpszUrl as LPCSTR, byval dwUrlLength as DWORD, byval dwFlags as DWORD, byval lpUrlComponents as LPURL_COMPONENTSA) as WINBOOL

#ifndef UNICODE
	declare function InternetCrackUrl alias "InternetCrackUrlA"(byval lpszUrl as LPCSTR, byval dwUrlLength as DWORD, byval dwFlags as DWORD, byval lpUrlComponents as LPURL_COMPONENTSA) as WINBOOL
#endif

declare function InternetCrackUrlW(byval lpszUrl as LPCWSTR, byval dwUrlLength as DWORD, byval dwFlags as DWORD, byval lpUrlComponents as LPURL_COMPONENTSW) as WINBOOL

#ifdef UNICODE
	declare function InternetCrackUrl alias "InternetCrackUrlW"(byval lpszUrl as LPCWSTR, byval dwUrlLength as DWORD, byval dwFlags as DWORD, byval lpUrlComponents as LPURL_COMPONENTSW) as WINBOOL
#endif

declare function InternetCreateUrlA(byval lpUrlComponents as LPURL_COMPONENTSA, byval dwFlags as DWORD, byval lpszUrl as LPSTR, byval lpdwUrlLength as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetCreateUrl alias "InternetCreateUrlA"(byval lpUrlComponents as LPURL_COMPONENTSA, byval dwFlags as DWORD, byval lpszUrl as LPSTR, byval lpdwUrlLength as LPDWORD) as WINBOOL
#endif

declare function InternetCreateUrlW(byval lpUrlComponents as LPURL_COMPONENTSW, byval dwFlags as DWORD, byval lpszUrl as LPWSTR, byval lpdwUrlLength as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetCreateUrl alias "InternetCreateUrlW"(byval lpUrlComponents as LPURL_COMPONENTSW, byval dwFlags as DWORD, byval lpszUrl as LPWSTR, byval lpdwUrlLength as LPDWORD) as WINBOOL
#endif

declare function InternetCanonicalizeUrlA(byval lpszUrl as LPCSTR, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetCanonicalizeUrl alias "InternetCanonicalizeUrlA"(byval lpszUrl as LPCSTR, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function InternetCanonicalizeUrlW(byval lpszUrl as LPCWSTR, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetCanonicalizeUrl alias "InternetCanonicalizeUrlW"(byval lpszUrl as LPCWSTR, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function InternetCombineUrlA(byval lpszBaseUrl as LPCSTR, byval lpszRelativeUrl as LPCSTR, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetCombineUrl alias "InternetCombineUrlA"(byval lpszBaseUrl as LPCSTR, byval lpszRelativeUrl as LPCSTR, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function InternetCombineUrlW(byval lpszBaseUrl as LPCWSTR, byval lpszRelativeUrl as LPCWSTR, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetCombineUrl alias "InternetCombineUrlW"(byval lpszBaseUrl as LPCWSTR, byval lpszRelativeUrl as LPCWSTR, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
#endif

const ICU_ESCAPE = &h80000000
const ICU_USERNAME = &h40000000
const ICU_NO_ENCODE = &h20000000
const ICU_DECODE = &h10000000
const ICU_NO_META = &h08000000
const ICU_ENCODE_SPACES_ONLY = &h04000000
const ICU_BROWSER_MODE = &h02000000
const ICU_ENCODE_PERCENT = &h00001000
declare function InternetOpenA(byval lpszAgent as LPCSTR, byval dwAccessType as DWORD, byval lpszProxy as LPCSTR, byval lpszProxyBypass as LPCSTR, byval dwFlags as DWORD) as HINTERNET

#ifndef UNICODE
	declare function InternetOpen alias "InternetOpenA"(byval lpszAgent as LPCSTR, byval dwAccessType as DWORD, byval lpszProxy as LPCSTR, byval lpszProxyBypass as LPCSTR, byval dwFlags as DWORD) as HINTERNET
#endif

declare function InternetOpenW(byval lpszAgent as LPCWSTR, byval dwAccessType as DWORD, byval lpszProxy as LPCWSTR, byval lpszProxyBypass as LPCWSTR, byval dwFlags as DWORD) as HINTERNET

#ifdef UNICODE
	declare function InternetOpen alias "InternetOpenW"(byval lpszAgent as LPCWSTR, byval dwAccessType as DWORD, byval lpszProxy as LPCWSTR, byval lpszProxyBypass as LPCWSTR, byval dwFlags as DWORD) as HINTERNET
#endif

const INTERNET_OPEN_TYPE_PRECONFIG = 0
const INTERNET_OPEN_TYPE_DIRECT = 1
const INTERNET_OPEN_TYPE_PROXY = 3
const INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY = 4
const PRE_CONFIG_INTERNET_ACCESS = INTERNET_OPEN_TYPE_PRECONFIG
const LOCAL_INTERNET_ACCESS = INTERNET_OPEN_TYPE_DIRECT
const CERN_PROXY_INTERNET_ACCESS = INTERNET_OPEN_TYPE_PROXY
declare function InternetCloseHandle(byval hInternet as HINTERNET) as WINBOOL
declare function InternetConnectA(byval hInternet as HINTERNET, byval lpszServerName as LPCSTR, byval nServerPort as INTERNET_PORT, byval lpszUserName as LPCSTR, byval lpszPassword as LPCSTR, byval dwService as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function InternetConnect alias "InternetConnectA"(byval hInternet as HINTERNET, byval lpszServerName as LPCSTR, byval nServerPort as INTERNET_PORT, byval lpszUserName as LPCSTR, byval lpszPassword as LPCSTR, byval dwService as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function InternetConnectW(byval hInternet as HINTERNET, byval lpszServerName as LPCWSTR, byval nServerPort as INTERNET_PORT, byval lpszUserName as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwService as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function InternetConnect alias "InternetConnectW"(byval hInternet as HINTERNET, byval lpszServerName as LPCWSTR, byval nServerPort as INTERNET_PORT, byval lpszUserName as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwService as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

const INTERNET_SERVICE_FTP = 1
const INTERNET_SERVICE_GOPHER = 2
const INTERNET_SERVICE_HTTP = 3
declare function InternetOpenUrlA(byval hInternet as HINTERNET, byval lpszUrl as LPCSTR, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function InternetOpenUrl alias "InternetOpenUrlA"(byval hInternet as HINTERNET, byval lpszUrl as LPCSTR, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function InternetOpenUrlW(byval hInternet as HINTERNET, byval lpszUrl as LPCWSTR, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function InternetOpenUrl alias "InternetOpenUrlW"(byval hInternet as HINTERNET, byval lpszUrl as LPCWSTR, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function InternetReadFile(byval hFile as HINTERNET, byval lpBuffer as LPVOID, byval dwNumberOfBytesToRead as DWORD, byval lpdwNumberOfBytesRead as LPDWORD) as WINBOOL
declare function InternetReadFileExA(byval hFile as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifndef UNICODE
	declare function InternetReadFileEx alias "InternetReadFileExA"(byval hFile as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function InternetReadFileExW(byval hFile as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifdef UNICODE
	declare function InternetReadFileEx alias "InternetReadFileExW"(byval hFile as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

const IRF_ASYNC = WININET_API_FLAG_ASYNC
const IRF_SYNC = WININET_API_FLAG_SYNC
const IRF_USE_CONTEXT = WININET_API_FLAG_USE_CONTEXT
const IRF_NO_WAIT = &h00000008

declare function InternetSetFilePointer(byval hFile as HINTERNET, byval lDistanceToMove as LONG, byval pReserved as PVOID, byval dwMoveMethod as DWORD, byval dwContext as DWORD_PTR) as DWORD
declare function InternetWriteFile(byval hFile as HINTERNET, byval lpBuffer as LPCVOID, byval dwNumberOfBytesToWrite as DWORD, byval lpdwNumberOfBytesWritten as LPDWORD) as WINBOOL
declare function InternetQueryDataAvailable(byval hFile as HINTERNET, byval lpdwNumberOfBytesAvailable as LPDWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function InternetFindNextFileA(byval hFind as HINTERNET, byval lpvFindData as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function InternetFindNextFile alias "InternetFindNextFileA"(byval hFind as HINTERNET, byval lpvFindData as LPVOID) as WINBOOL
#endif

declare function InternetFindNextFileW(byval hFind as HINTERNET, byval lpvFindData as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function InternetFindNextFile alias "InternetFindNextFileW"(byval hFind as HINTERNET, byval lpvFindData as LPVOID) as WINBOOL
#endif

declare function InternetQueryOptionA(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetQueryOption alias "InternetQueryOptionA"(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as WINBOOL
#endif

declare function InternetQueryOptionW(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetQueryOption alias "InternetQueryOptionW"(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as WINBOOL
#endif

declare function InternetSetOptionA(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetSetOption alias "InternetSetOptionA"(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD) as WINBOOL
#endif

declare function InternetSetOptionW(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetSetOption alias "InternetSetOptionW"(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD) as WINBOOL
#endif

declare function InternetSetOptionExA(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetSetOptionEx alias "InternetSetOptionExA"(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function InternetSetOptionExW(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetSetOptionEx alias "InternetSetOptionExW"(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwFlags as DWORD) as WINBOOL
#endif

declare function InternetLockRequestFile(byval hInternet as HINTERNET, byval lphLockRequestInfo as HANDLE ptr) as WINBOOL
declare function InternetUnlockRequestFile(byval hLockRequestInfo as HANDLE) as WINBOOL
const ISO_GLOBAL = &h00000001
const ISO_REGISTRY = &h00000002
const ISO_VALID_FLAGS = ISO_GLOBAL or ISO_REGISTRY
const INTERNET_OPTION_CALLBACK = 1
const INTERNET_OPTION_CONNECT_TIMEOUT = 2
const INTERNET_OPTION_CONNECT_RETRIES = 3
const INTERNET_OPTION_CONNECT_BACKOFF = 4
const INTERNET_OPTION_SEND_TIMEOUT = 5
const INTERNET_OPTION_CONTROL_SEND_TIMEOUT = INTERNET_OPTION_SEND_TIMEOUT
const INTERNET_OPTION_RECEIVE_TIMEOUT = 6
const INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT = INTERNET_OPTION_RECEIVE_TIMEOUT
const INTERNET_OPTION_DATA_SEND_TIMEOUT = 7
const INTERNET_OPTION_DATA_RECEIVE_TIMEOUT = 8
const INTERNET_OPTION_HANDLE_TYPE = 9
const INTERNET_OPTION_LISTEN_TIMEOUT = 11
const INTERNET_OPTION_READ_BUFFER_SIZE = 12
const INTERNET_OPTION_WRITE_BUFFER_SIZE = 13
const INTERNET_OPTION_ASYNC_ID = 15
const INTERNET_OPTION_ASYNC_PRIORITY = 16
const INTERNET_OPTION_PARENT_HANDLE = 21
const INTERNET_OPTION_KEEP_CONNECTION = 22
const INTERNET_OPTION_REQUEST_FLAGS = 23
const INTERNET_OPTION_EXTENDED_ERROR = 24
const INTERNET_OPTION_OFFLINE_MODE = 26
const INTERNET_OPTION_CACHE_STREAM_HANDLE = 27
const INTERNET_OPTION_USERNAME = 28
const INTERNET_OPTION_PASSWORD = 29
const INTERNET_OPTION_ASYNC = 30
const INTERNET_OPTION_SECURITY_FLAGS = 31
const INTERNET_OPTION_SECURITY_CERTIFICATE_STRUCT = 32
const INTERNET_OPTION_DATAFILE_NAME = 33
const INTERNET_OPTION_URL = 34
const INTERNET_OPTION_SECURITY_CERTIFICATE = 35
const INTERNET_OPTION_SECURITY_KEY_BITNESS = 36
const INTERNET_OPTION_REFRESH = 37
const INTERNET_OPTION_PROXY = 38
const INTERNET_OPTION_SETTINGS_CHANGED = 39
const INTERNET_OPTION_VERSION = 40
const INTERNET_OPTION_USER_AGENT = 41
const INTERNET_OPTION_END_BROWSER_SESSION = 42
const INTERNET_OPTION_PROXY_USERNAME = 43
const INTERNET_OPTION_PROXY_PASSWORD = 44
const INTERNET_OPTION_CONTEXT_VALUE = 45
const INTERNET_OPTION_CONNECT_LIMIT = 46
const INTERNET_OPTION_SECURITY_SELECT_CLIENT_CERT = 47
const INTERNET_OPTION_POLICY = 48
const INTERNET_OPTION_DISCONNECTED_TIMEOUT = 49
const INTERNET_OPTION_CONNECTED_STATE = 50
const INTERNET_OPTION_IDLE_STATE = 51
const INTERNET_OPTION_OFFLINE_SEMANTICS = 52
const INTERNET_OPTION_SECONDARY_CACHE_KEY = 53
const INTERNET_OPTION_CALLBACK_FILTER = 54
const INTERNET_OPTION_CONNECT_TIME = 55
const INTERNET_OPTION_SEND_THROUGHPUT = 56
const INTERNET_OPTION_RECEIVE_THROUGHPUT = 57
const INTERNET_OPTION_REQUEST_PRIORITY = 58
const INTERNET_OPTION_HTTP_VERSION = 59
const INTERNET_OPTION_RESET_URLCACHE_SESSION = 60
const INTERNET_OPTION_ERROR_MASK = 62
const INTERNET_OPTION_FROM_CACHE_TIMEOUT = 63
const INTERNET_OPTION_BYPASS_EDITED_ENTRY = 64
const INTERNET_OPTION_DIAGNOSTIC_SOCKET_INFO = 67
const INTERNET_OPTION_CODEPAGE = 68
const INTERNET_OPTION_CACHE_TIMESTAMPS = 69
const INTERNET_OPTION_DISABLE_AUTODIAL = 70
const INTERNET_OPTION_MAX_CONNS_PER_SERVER = 73
const INTERNET_OPTION_MAX_CONNS_PER_1_0_SERVER = 74
const INTERNET_OPTION_PER_CONNECTION_OPTION = 75
const INTERNET_OPTION_DIGEST_AUTH_UNLOAD = 76
const INTERNET_OPTION_IGNORE_OFFLINE = 77
const INTERNET_OPTION_IDENTITY = 78
const INTERNET_OPTION_REMOVE_IDENTITY = 79
const INTERNET_OPTION_ALTER_IDENTITY = 80
const INTERNET_OPTION_SUPPRESS_BEHAVIOR = 81
const INTERNET_OPTION_AUTODIAL_MODE = 82
const INTERNET_OPTION_AUTODIAL_CONNECTION = 83
const INTERNET_OPTION_CLIENT_CERT_CONTEXT = 84
const INTERNET_OPTION_AUTH_FLAGS = 85
const INTERNET_OPTION_COOKIES_3RD_PARTY = 86
const INTERNET_OPTION_DISABLE_PASSPORT_AUTH = 87
const INTERNET_OPTION_SEND_UTF8_SERVERNAME_TO_PROXY = 88
const INTERNET_OPTION_EXEMPT_CONNECTION_LIMIT = 89
const INTERNET_OPTION_ENABLE_PASSPORT_AUTH = 90
const INTERNET_OPTION_HIBERNATE_INACTIVE_WORKER_THREADS = 91
const INTERNET_OPTION_ACTIVATE_WORKER_THREADS = 92
const INTERNET_OPTION_RESTORE_WORKER_THREAD_DEFAULTS = 93
const INTERNET_OPTION_SOCKET_SEND_BUFFER_LENGTH = 94
const INTERNET_OPTION_PROXY_SETTINGS_CHANGED = 95
const INTERNET_OPTION_DATAFILE_EXT = 96
const INTERNET_FIRST_OPTION = INTERNET_OPTION_CALLBACK
const INTERNET_LAST_OPTION = INTERNET_OPTION_DATAFILE_EXT
const INTERNET_PRIORITY_FOREGROUND = 1000
const INTERNET_HANDLE_TYPE_INTERNET = 1
const INTERNET_HANDLE_TYPE_CONNECT_FTP = 2
const INTERNET_HANDLE_TYPE_CONNECT_GOPHER = 3
const INTERNET_HANDLE_TYPE_CONNECT_HTTP = 4
const INTERNET_HANDLE_TYPE_FTP_FIND = 5
const INTERNET_HANDLE_TYPE_FTP_FIND_HTML = 6
const INTERNET_HANDLE_TYPE_FTP_FILE = 7
const INTERNET_HANDLE_TYPE_FTP_FILE_HTML = 8
const INTERNET_HANDLE_TYPE_GOPHER_FIND = 9
const INTERNET_HANDLE_TYPE_GOPHER_FIND_HTML = 10
const INTERNET_HANDLE_TYPE_GOPHER_FILE = 11
const INTERNET_HANDLE_TYPE_GOPHER_FILE_HTML = 12
const INTERNET_HANDLE_TYPE_HTTP_REQUEST = 13
const INTERNET_HANDLE_TYPE_FILE_REQUEST = 14
const AUTH_FLAG_DISABLE_NEGOTIATE = &h00000001
const AUTH_FLAG_ENABLE_NEGOTIATE = &h00000002
const AUTH_FLAG_DISABLE_BASIC_CLEARCHANNEL = &h00000004
const SECURITY_FLAG_SECURE = &h00000001
const SECURITY_FLAG_STRENGTH_WEAK = &h10000000
const SECURITY_FLAG_STRENGTH_MEDIUM = &h40000000
const SECURITY_FLAG_STRENGTH_STRONG = &h20000000
const SECURITY_FLAG_UNKNOWNBIT = &h80000000
const SECURITY_FLAG_FORTEZZA = &h08000000
const SECURITY_FLAG_NORMALBITNESS = SECURITY_FLAG_STRENGTH_WEAK
const SECURITY_FLAG_SSL = &h00000002
const SECURITY_FLAG_SSL3 = &h00000004
const SECURITY_FLAG_PCT = &h00000008
const SECURITY_FLAG_PCT4 = &h00000010
const SECURITY_FLAG_IETFSSL4 = &h00000020
const SECURITY_FLAG_40BIT = SECURITY_FLAG_STRENGTH_WEAK
const SECURITY_FLAG_128BIT = SECURITY_FLAG_STRENGTH_STRONG
const SECURITY_FLAG_56BIT = SECURITY_FLAG_STRENGTH_MEDIUM
const SECURITY_FLAG_IGNORE_REVOCATION = &h00000080
const SECURITY_FLAG_IGNORE_UNKNOWN_CA = &h00000100
const SECURITY_FLAG_IGNORE_WRONG_USAGE = &h00000200
const SECURITY_FLAG_IGNORE_CERT_CN_INVALID = INTERNET_FLAG_IGNORE_CERT_CN_INVALID
const SECURITY_FLAG_IGNORE_CERT_DATE_INVALID = INTERNET_FLAG_IGNORE_CERT_DATE_INVALID
const SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTPS = INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS
const SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTP = INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP
const SECURITY_SET_MASK = (((SECURITY_FLAG_IGNORE_REVOCATION or SECURITY_FLAG_IGNORE_UNKNOWN_CA) or SECURITY_FLAG_IGNORE_CERT_CN_INVALID) or SECURITY_FLAG_IGNORE_CERT_DATE_INVALID) or SECURITY_FLAG_IGNORE_WRONG_USAGE
const AUTODIAL_MODE_NEVER = 1
const AUTODIAL_MODE_ALWAYS = 2
const AUTODIAL_MODE_NO_NETWORK_PRESENT = 4
declare function InternetGetLastResponseInfoA(byval lpdwError as LPDWORD, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetGetLastResponseInfo alias "InternetGetLastResponseInfoA"(byval lpdwError as LPDWORD, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
#endif

declare function InternetGetLastResponseInfoW(byval lpdwError as LPDWORD, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetGetLastResponseInfo alias "InternetGetLastResponseInfoW"(byval lpdwError as LPDWORD, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
#endif

type INTERNET_STATUS_CALLBACK as sub(byval hInternet as HINTERNET, byval dwContext as DWORD_PTR, byval dwInternetStatus as DWORD, byval lpvStatusInformation as LPVOID, byval dwStatusInformationLength as DWORD)
type LPINTERNET_STATUS_CALLBACK as INTERNET_STATUS_CALLBACK ptr

#ifndef UNICODE
	declare function InternetSetStatusCallback(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK
#endif

declare function InternetSetStatusCallbackA(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK
declare function InternetSetStatusCallbackW(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK

#ifdef UNICODE
	declare function InternetSetStatusCallback alias "InternetSetStatusCallbackW"(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK
#endif

const INTERNET_STATUS_RESOLVING_NAME = 10
const INTERNET_STATUS_NAME_RESOLVED = 11
const INTERNET_STATUS_CONNECTING_TO_SERVER = 20
const INTERNET_STATUS_CONNECTED_TO_SERVER = 21
const INTERNET_STATUS_SENDING_REQUEST = 30
const INTERNET_STATUS_REQUEST_SENT = 31
const INTERNET_STATUS_RECEIVING_RESPONSE = 40
const INTERNET_STATUS_RESPONSE_RECEIVED = 41
const INTERNET_STATUS_CTL_RESPONSE_RECEIVED = 42
const INTERNET_STATUS_PREFETCH = 43
const INTERNET_STATUS_CLOSING_CONNECTION = 50
const INTERNET_STATUS_CONNECTION_CLOSED = 51
const INTERNET_STATUS_HANDLE_CREATED = 60
const INTERNET_STATUS_HANDLE_CLOSING = 70
const INTERNET_STATUS_DETECTING_PROXY = 80
const INTERNET_STATUS_REQUEST_COMPLETE = 100
const INTERNET_STATUS_REDIRECT = 110
const INTERNET_STATUS_INTERMEDIATE_RESPONSE = 120
const INTERNET_STATUS_USER_INPUT_REQUIRED = 140
const INTERNET_STATUS_STATE_CHANGE = 200
const INTERNET_STATUS_COOKIE_SENT = 320
const INTERNET_STATUS_COOKIE_RECEIVED = 321
const INTERNET_STATUS_PRIVACY_IMPACTED = 324
const INTERNET_STATUS_P3P_HEADER = 325
const INTERNET_STATUS_P3P_POLICYREF = 326
const INTERNET_STATUS_COOKIE_HISTORY = 327
const INTERNET_STATE_CONNECTED = &h00000001
const INTERNET_STATE_DISCONNECTED = &h00000002
const INTERNET_STATE_DISCONNECTED_BY_USER = &h00000010
const INTERNET_STATE_IDLE = &h00000100
const INTERNET_STATE_BUSY = &h00000200

type InternetCookieState as long
enum
	COOKIE_STATE_UNKNOWN = &h0
	COOKIE_STATE_ACCEPT = &h1
	COOKIE_STATE_PROMPT = &h2
	COOKIE_STATE_LEASH = &h3
	COOKIE_STATE_DOWNGRADE = &h4
	COOKIE_STATE_REJECT = &h5
	COOKIE_STATE_MAX = COOKIE_STATE_REJECT
end enum

#ifdef __FB_64BIT__
	type IncomingCookieState
		cSession as long
		cPersistent as long
		cAccepted as long
		cLeashed as long
		cDowngraded as long
		cBlocked as long
		pszLocation as const zstring ptr
	end type

	type OutgoingCookieState
		cSent as long
		cSuppressed as long
		pszLocation as const zstring ptr
	end type

	type InternetCookieHistory
		fAccepted as WINBOOL
		fLeashed as WINBOOL
		fDowngraded as WINBOOL
		fRejected as WINBOOL
	end type

	type CookieDecision
		dwCookieState as DWORD
		fAllowSession as WINBOOL
	end type
#else
	type IncomingCookieState field = 4
		cSession as long
		cPersistent as long
		cAccepted as long
		cLeashed as long
		cDowngraded as long
		cBlocked as long
		pszLocation as const zstring ptr
	end type

	type OutgoingCookieState field = 4
		cSent as long
		cSuppressed as long
		pszLocation as const zstring ptr
	end type

	type InternetCookieHistory field = 4
		fAccepted as WINBOOL
		fLeashed as WINBOOL
		fDowngraded as WINBOOL
		fRejected as WINBOOL
	end type

	type CookieDecision field = 4
		dwCookieState as DWORD
		fAllowSession as WINBOOL
	end type
#endif

const INTERNET_INVALID_STATUS_CALLBACK = cast(INTERNET_STATUS_CALLBACK, cast(INT_PTR, -1))
const FTP_TRANSFER_TYPE_UNKNOWN = &h00000000
const FTP_TRANSFER_TYPE_ASCII = &h00000001
const INTERNET_FLAG_TRANSFER_ASCII = FTP_TRANSFER_TYPE_ASCII
const FTP_TRANSFER_TYPE_BINARY = &h00000002
const INTERNET_FLAG_TRANSFER_BINARY = FTP_TRANSFER_TYPE_BINARY
const FTP_TRANSFER_TYPE_MASK = FTP_TRANSFER_TYPE_ASCII or FTP_TRANSFER_TYPE_BINARY
declare function FtpFindFirstFileA(byval hConnect as HINTERNET, byval lpszSearchFile as LPCSTR, byval lpFindFileData as LPWIN32_FIND_DATAA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function FtpFindFirstFile alias "FtpFindFirstFileA"(byval hConnect as HINTERNET, byval lpszSearchFile as LPCSTR, byval lpFindFileData as LPWIN32_FIND_DATAA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function FtpFindFirstFileW(byval hConnect as HINTERNET, byval lpszSearchFile as LPCWSTR, byval lpFindFileData as LPWIN32_FIND_DATAW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function FtpFindFirstFile alias "FtpFindFirstFileW"(byval hConnect as HINTERNET, byval lpszSearchFile as LPCWSTR, byval lpFindFileData as LPWIN32_FIND_DATAW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function FtpGetFileA(byval hConnect as HINTERNET, byval lpszRemoteFile as LPCSTR, byval lpszNewFile as LPCSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifndef UNICODE
	declare function FtpGetFile alias "FtpGetFileA"(byval hConnect as HINTERNET, byval lpszRemoteFile as LPCSTR, byval lpszNewFile as LPCSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function FtpGetFileW(byval hConnect as HINTERNET, byval lpszRemoteFile as LPCWSTR, byval lpszNewFile as LPCWSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifdef UNICODE
	declare function FtpGetFile alias "FtpGetFileW"(byval hConnect as HINTERNET, byval lpszRemoteFile as LPCWSTR, byval lpszNewFile as LPCWSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function FtpPutFileA(byval hConnect as HINTERNET, byval lpszLocalFile as LPCSTR, byval lpszNewRemoteFile as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifndef UNICODE
	declare function FtpPutFile alias "FtpPutFileA"(byval hConnect as HINTERNET, byval lpszLocalFile as LPCSTR, byval lpszNewRemoteFile as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function FtpPutFileW(byval hConnect as HINTERNET, byval lpszLocalFile as LPCWSTR, byval lpszNewRemoteFile as LPCWSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifdef UNICODE
	declare function FtpPutFile alias "FtpPutFileW"(byval hConnect as HINTERNET, byval lpszLocalFile as LPCWSTR, byval lpszNewRemoteFile as LPCWSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function FtpGetFileEx(byval hFtpSession as HINTERNET, byval lpszRemoteFile as LPCSTR, byval lpszNewFile as LPCWSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpPutFileEx(byval hFtpSession as HINTERNET, byval lpszLocalFile as LPCWSTR, byval lpszNewRemoteFile as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpDeleteFileA(byval hConnect as HINTERNET, byval lpszFileName as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function FtpDeleteFile alias "FtpDeleteFileA"(byval hConnect as HINTERNET, byval lpszFileName as LPCSTR) as WINBOOL
#endif

declare function FtpDeleteFileW(byval hConnect as HINTERNET, byval lpszFileName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function FtpDeleteFile alias "FtpDeleteFileW"(byval hConnect as HINTERNET, byval lpszFileName as LPCWSTR) as WINBOOL
#endif

declare function FtpRenameFileA(byval hConnect as HINTERNET, byval lpszExisting as LPCSTR, byval lpszNew as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function FtpRenameFile alias "FtpRenameFileA"(byval hConnect as HINTERNET, byval lpszExisting as LPCSTR, byval lpszNew as LPCSTR) as WINBOOL
#endif

declare function FtpRenameFileW(byval hConnect as HINTERNET, byval lpszExisting as LPCWSTR, byval lpszNew as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function FtpRenameFile alias "FtpRenameFileW"(byval hConnect as HINTERNET, byval lpszExisting as LPCWSTR, byval lpszNew as LPCWSTR) as WINBOOL
#endif

declare function FtpOpenFileA(byval hConnect as HINTERNET, byval lpszFileName as LPCSTR, byval dwAccess as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function FtpOpenFile alias "FtpOpenFileA"(byval hConnect as HINTERNET, byval lpszFileName as LPCSTR, byval dwAccess as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function FtpOpenFileW(byval hConnect as HINTERNET, byval lpszFileName as LPCWSTR, byval dwAccess as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function FtpOpenFile alias "FtpOpenFileW"(byval hConnect as HINTERNET, byval lpszFileName as LPCWSTR, byval dwAccess as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function FtpCreateDirectoryA(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function FtpCreateDirectory alias "FtpCreateDirectoryA"(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL
#endif

declare function FtpCreateDirectoryW(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function FtpCreateDirectory alias "FtpCreateDirectoryW"(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL
#endif

declare function FtpRemoveDirectoryA(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function FtpRemoveDirectory alias "FtpRemoveDirectoryA"(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL
#endif

declare function FtpRemoveDirectoryW(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function FtpRemoveDirectory alias "FtpRemoveDirectoryW"(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL
#endif

declare function FtpSetCurrentDirectoryA(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function FtpSetCurrentDirectory alias "FtpSetCurrentDirectoryA"(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL
#endif

declare function FtpSetCurrentDirectoryW(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function FtpSetCurrentDirectory alias "FtpSetCurrentDirectoryW"(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL
#endif

declare function FtpGetCurrentDirectoryA(byval hConnect as HINTERNET, byval lpszCurrentDirectory as LPSTR, byval lpdwCurrentDirectory as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function FtpGetCurrentDirectory alias "FtpGetCurrentDirectoryA"(byval hConnect as HINTERNET, byval lpszCurrentDirectory as LPSTR, byval lpdwCurrentDirectory as LPDWORD) as WINBOOL
#endif

declare function FtpGetCurrentDirectoryW(byval hConnect as HINTERNET, byval lpszCurrentDirectory as LPWSTR, byval lpdwCurrentDirectory as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function FtpGetCurrentDirectory alias "FtpGetCurrentDirectoryW"(byval hConnect as HINTERNET, byval lpszCurrentDirectory as LPWSTR, byval lpdwCurrentDirectory as LPDWORD) as WINBOOL
#endif

declare function FtpCommandA(byval hConnect as HINTERNET, byval fExpectResponse as WINBOOL, byval dwFlags as DWORD, byval lpszCommand as LPCSTR, byval dwContext as DWORD_PTR, byval phFtpCommand as HINTERNET ptr) as WINBOOL

#ifndef UNICODE
	declare function FtpCommand alias "FtpCommandA"(byval hConnect as HINTERNET, byval fExpectResponse as WINBOOL, byval dwFlags as DWORD, byval lpszCommand as LPCSTR, byval dwContext as DWORD_PTR, byval phFtpCommand as HINTERNET ptr) as WINBOOL
#endif

declare function FtpCommandW(byval hConnect as HINTERNET, byval fExpectResponse as WINBOOL, byval dwFlags as DWORD, byval lpszCommand as LPCWSTR, byval dwContext as DWORD_PTR, byval phFtpCommand as HINTERNET ptr) as WINBOOL

#ifdef UNICODE
	declare function FtpCommand alias "FtpCommandW"(byval hConnect as HINTERNET, byval fExpectResponse as WINBOOL, byval dwFlags as DWORD, byval lpszCommand as LPCWSTR, byval dwContext as DWORD_PTR, byval phFtpCommand as HINTERNET ptr) as WINBOOL
#endif

declare function FtpGetFileSize(byval hFile as HINTERNET, byval lpdwFileSizeHigh as LPDWORD) as DWORD
const MAX_GOPHER_DISPLAY_TEXT = 128
const MAX_GOPHER_SELECTOR_TEXT = 256
const MAX_GOPHER_HOST_NAME = INTERNET_MAX_HOST_NAME_LENGTH
const MAX_GOPHER_LOCATOR_LENGTH = (((((((((1 + MAX_GOPHER_DISPLAY_TEXT) + 1) + MAX_GOPHER_SELECTOR_TEXT) + 1) + MAX_GOPHER_HOST_NAME) + 1) + INTERNET_MAX_PORT_NUMBER_LENGTH) + 1) + 1) + 2

#ifdef __FB_64BIT__
	type GOPHER_FIND_DATAA
		DisplayString as zstring * 128 + 1
		GopherType as DWORD
		SizeLow as DWORD
		SizeHigh as DWORD
		LastModificationTime as FILETIME
		Locator as zstring * ((((((((((1 + 128) + 1) + 256) + 1) + 256) + 1) + 5) + 1) + 1) + 2) + 1
	end type
#else
	type GOPHER_FIND_DATAA field = 4
		DisplayString as zstring * 128 + 1
		GopherType as DWORD
		SizeLow as DWORD
		SizeHigh as DWORD
		LastModificationTime as FILETIME
		Locator as zstring * ((((((((((1 + 128) + 1) + 256) + 1) + 256) + 1) + 5) + 1) + 1) + 2) + 1
	end type
#endif

type LPGOPHER_FIND_DATAA as GOPHER_FIND_DATAA ptr

#ifdef __FB_64BIT__
	type GOPHER_FIND_DATAW
		DisplayString as wstring * 128 + 1
		GopherType as DWORD
		SizeLow as DWORD
		SizeHigh as DWORD
		LastModificationTime as FILETIME
		Locator as wstring * ((((((((((1 + 128) + 1) + 256) + 1) + 256) + 1) + 5) + 1) + 1) + 2) + 1
	end type
#else
	type GOPHER_FIND_DATAW field = 4
		DisplayString as wstring * 128 + 1
		GopherType as DWORD
		SizeLow as DWORD
		SizeHigh as DWORD
		LastModificationTime as FILETIME
		Locator as wstring * ((((((((((1 + 128) + 1) + 256) + 1) + 256) + 1) + 5) + 1) + 1) + 2) + 1
	end type
#endif

type LPGOPHER_FIND_DATAW as GOPHER_FIND_DATAW ptr

#ifdef UNICODE
	type GOPHER_FIND_DATA as GOPHER_FIND_DATAW
	type LPGOPHER_FIND_DATA as LPGOPHER_FIND_DATAW
#else
	type GOPHER_FIND_DATA as GOPHER_FIND_DATAA
	type LPGOPHER_FIND_DATA as LPGOPHER_FIND_DATAA
#endif

const GOPHER_TYPE_TEXT_FILE = &h00000001
const GOPHER_TYPE_DIRECTORY = &h00000002
const GOPHER_TYPE_CSO = &h00000004
const GOPHER_TYPE_ERROR = &h00000008
const GOPHER_TYPE_MAC_BINHEX = &h00000010
const GOPHER_TYPE_DOS_ARCHIVE = &h00000020
const GOPHER_TYPE_UNIX_UUENCODED = &h00000040
const GOPHER_TYPE_INDEX_SERVER = &h00000080
const GOPHER_TYPE_TELNET = &h00000100
const GOPHER_TYPE_BINARY = &h00000200
const GOPHER_TYPE_REDUNDANT = &h00000400
const GOPHER_TYPE_TN3270 = &h00000800
const GOPHER_TYPE_GIF = &h00001000
const GOPHER_TYPE_IMAGE = &h00002000
const GOPHER_TYPE_BITMAP = &h00004000
const GOPHER_TYPE_MOVIE = &h00008000
const GOPHER_TYPE_SOUND = &h00010000
const GOPHER_TYPE_HTML = &h00020000
const GOPHER_TYPE_PDF = &h00040000
const GOPHER_TYPE_CALENDAR = &h00080000
const GOPHER_TYPE_INLINE = &h00100000
const GOPHER_TYPE_UNKNOWN = &h20000000
const GOPHER_TYPE_ASK = &h40000000
const GOPHER_TYPE_GOPHER_PLUS = &h80000000
#define IS_GOPHER_FILE(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_FILE_MASK, CTRUE, FALSE))
#define IS_GOPHER_DIRECTORY(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_DIRECTORY, CTRUE, FALSE))
#define IS_GOPHER_PHONE_SERVER(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_CSO, CTRUE, FALSE))
#define IS_GOPHER_ERROR(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_ERROR, CTRUE, FALSE))
#define IS_GOPHER_INDEX_SERVER(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_INDEX_SERVER, CTRUE, FALSE))
#define IS_GOPHER_TELNET_SESSION(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_TELNET, CTRUE, FALSE))
#define IS_GOPHER_BACKUP_SERVER(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_REDUNDANT, CTRUE, FALSE))
#define IS_GOPHER_TN3270_SESSION(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_TN3270, CTRUE, FALSE))
#define IS_GOPHER_ASK(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_ASK, CTRUE, FALSE))
#define IS_GOPHER_PLUS(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_GOPHER_PLUS, CTRUE, FALSE))
#define IS_GOPHER_TYPE_KNOWN(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_UNKNOWN, FALSE, CTRUE))
const GOPHER_TYPE_FILE_MASK = ((((((((((((GOPHER_TYPE_TEXT_FILE or GOPHER_TYPE_MAC_BINHEX) or GOPHER_TYPE_DOS_ARCHIVE) or GOPHER_TYPE_UNIX_UUENCODED) or GOPHER_TYPE_BINARY) or GOPHER_TYPE_GIF) or GOPHER_TYPE_IMAGE) or GOPHER_TYPE_BITMAP) or GOPHER_TYPE_MOVIE) or GOPHER_TYPE_SOUND) or GOPHER_TYPE_HTML) or GOPHER_TYPE_PDF) or GOPHER_TYPE_CALENDAR) or GOPHER_TYPE_INLINE

#ifdef __FB_64BIT__
	type GOPHER_ADMIN_ATTRIBUTE_TYPE
		Comment as LPCTSTR
		EmailAddress as LPCTSTR
	end type
#else
	type GOPHER_ADMIN_ATTRIBUTE_TYPE field = 4
		Comment as LPCTSTR
		EmailAddress as LPCTSTR
	end type
#endif

type LPGOPHER_ADMIN_ATTRIBUTE_TYPE as GOPHER_ADMIN_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_MOD_DATE_ATTRIBUTE_TYPE
		DateAndTime as FILETIME
	end type
#else
	type GOPHER_MOD_DATE_ATTRIBUTE_TYPE field = 4
		DateAndTime as FILETIME
	end type
#endif

type LPGOPHER_MOD_DATE_ATTRIBUTE_TYPE as GOPHER_MOD_DATE_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_TTL_ATTRIBUTE_TYPE
		Ttl as DWORD
	end type
#else
	type GOPHER_TTL_ATTRIBUTE_TYPE field = 4
		Ttl as DWORD
	end type
#endif

type LPGOPHER_TTL_ATTRIBUTE_TYPE as GOPHER_TTL_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_SCORE_ATTRIBUTE_TYPE
		Score as INT_
	end type
#else
	type GOPHER_SCORE_ATTRIBUTE_TYPE field = 4
		Score as INT_
	end type
#endif

type LPGOPHER_SCORE_ATTRIBUTE_TYPE as GOPHER_SCORE_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE
		LowerBound as INT_
		UpperBound as INT_
	end type
#else
	type GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE field = 4
		LowerBound as INT_
		UpperBound as INT_
	end type
#endif

type LPGOPHER_SCORE_RANGE_ATTRIBUTE_TYPE as GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_SITE_ATTRIBUTE_TYPE
		Site as LPCTSTR
	end type
#else
	type GOPHER_SITE_ATTRIBUTE_TYPE field = 4
		Site as LPCTSTR
	end type
#endif

type LPGOPHER_SITE_ATTRIBUTE_TYPE as GOPHER_SITE_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_ORGANIZATION_ATTRIBUTE_TYPE
		Organization as LPCTSTR
	end type
#else
	type GOPHER_ORGANIZATION_ATTRIBUTE_TYPE field = 4
		Organization as LPCTSTR
	end type
#endif

type LPGOPHER_ORGANIZATION_ATTRIBUTE_TYPE as GOPHER_ORGANIZATION_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_LOCATION_ATTRIBUTE_TYPE
		Location as LPCTSTR
	end type
#else
	type GOPHER_LOCATION_ATTRIBUTE_TYPE field = 4
		Location as LPCTSTR
	end type
#endif

type LPGOPHER_LOCATION_ATTRIBUTE_TYPE as GOPHER_LOCATION_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE
		DegreesNorth as INT_
		MinutesNorth as INT_
		SecondsNorth as INT_
		DegreesEast as INT_
		MinutesEast as INT_
		SecondsEast as INT_
	end type
#else
	type GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE field = 4
		DegreesNorth as INT_
		MinutesNorth as INT_
		SecondsNorth as INT_
		DegreesEast as INT_
		MinutesEast as INT_
		SecondsEast as INT_
	end type
#endif

type LPGOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE as GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_TIMEZONE_ATTRIBUTE_TYPE
		Zone as INT_
	end type
#else
	type GOPHER_TIMEZONE_ATTRIBUTE_TYPE field = 4
		Zone as INT_
	end type
#endif

type LPGOPHER_TIMEZONE_ATTRIBUTE_TYPE as GOPHER_TIMEZONE_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_PROVIDER_ATTRIBUTE_TYPE
		Provider as LPCTSTR
	end type
#else
	type GOPHER_PROVIDER_ATTRIBUTE_TYPE field = 4
		Provider as LPCTSTR
	end type
#endif

type LPGOPHER_PROVIDER_ATTRIBUTE_TYPE as GOPHER_PROVIDER_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_VERSION_ATTRIBUTE_TYPE
		Version as LPCTSTR
	end type
#else
	type GOPHER_VERSION_ATTRIBUTE_TYPE field = 4
		Version as LPCTSTR
	end type
#endif

type LPGOPHER_VERSION_ATTRIBUTE_TYPE as GOPHER_VERSION_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_ABSTRACT_ATTRIBUTE_TYPE
		ShortAbstract as LPCTSTR
		AbstractFile as LPCTSTR
	end type
#else
	type GOPHER_ABSTRACT_ATTRIBUTE_TYPE field = 4
		ShortAbstract as LPCTSTR
		AbstractFile as LPCTSTR
	end type
#endif

type LPGOPHER_ABSTRACT_ATTRIBUTE_TYPE as GOPHER_ABSTRACT_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_VIEW_ATTRIBUTE_TYPE
		ContentType as LPCTSTR
		Language as LPCTSTR
		Size as DWORD
	end type
#else
	type GOPHER_VIEW_ATTRIBUTE_TYPE field = 4
		ContentType as LPCTSTR
		Language as LPCTSTR
		Size as DWORD
	end type
#endif

type LPGOPHER_VIEW_ATTRIBUTE_TYPE as GOPHER_VIEW_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_VERONICA_ATTRIBUTE_TYPE
		TreeWalk as WINBOOL
	end type
#else
	type GOPHER_VERONICA_ATTRIBUTE_TYPE field = 4
		TreeWalk as WINBOOL
	end type
#endif

type LPGOPHER_VERONICA_ATTRIBUTE_TYPE as GOPHER_VERONICA_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_ASK_ATTRIBUTE_TYPE
		QuestionType as LPCTSTR
		QuestionText as LPCTSTR
	end type
#else
	type GOPHER_ASK_ATTRIBUTE_TYPE field = 4
		QuestionType as LPCTSTR
		QuestionText as LPCTSTR
	end type
#endif

type LPGOPHER_ASK_ATTRIBUTE_TYPE as GOPHER_ASK_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	type GOPHER_UNKNOWN_ATTRIBUTE_TYPE
		Text as LPCTSTR
	end type
#else
	type GOPHER_UNKNOWN_ATTRIBUTE_TYPE field = 4
		Text as LPCTSTR
	end type
#endif

type LPGOPHER_UNKNOWN_ATTRIBUTE_TYPE as GOPHER_UNKNOWN_ATTRIBUTE_TYPE ptr

#ifdef __FB_64BIT__
	union GOPHER_ATTRIBUTE_TYPE_AttributeType
		Admin as GOPHER_ADMIN_ATTRIBUTE_TYPE
		ModDate as GOPHER_MOD_DATE_ATTRIBUTE_TYPE
		Ttl as GOPHER_TTL_ATTRIBUTE_TYPE
		Score as GOPHER_SCORE_ATTRIBUTE_TYPE
		ScoreRange as GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE
		Site as GOPHER_SITE_ATTRIBUTE_TYPE
		Organization as GOPHER_ORGANIZATION_ATTRIBUTE_TYPE
		Location as GOPHER_LOCATION_ATTRIBUTE_TYPE
		GeographicalLocation as GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE
		TimeZone as GOPHER_TIMEZONE_ATTRIBUTE_TYPE
		Provider as GOPHER_PROVIDER_ATTRIBUTE_TYPE
		Version as GOPHER_VERSION_ATTRIBUTE_TYPE
		Abstract as GOPHER_ABSTRACT_ATTRIBUTE_TYPE
		View as GOPHER_VIEW_ATTRIBUTE_TYPE
		Veronica as GOPHER_VERONICA_ATTRIBUTE_TYPE
		Ask as GOPHER_ASK_ATTRIBUTE_TYPE
		Unknown as GOPHER_UNKNOWN_ATTRIBUTE_TYPE
	end union

	type GOPHER_ATTRIBUTE_TYPE
		CategoryId as DWORD
		AttributeId as DWORD
		AttributeType as GOPHER_ATTRIBUTE_TYPE_AttributeType
	end type
#else
	union GOPHER_ATTRIBUTE_TYPE_AttributeType field = 4
		Admin as GOPHER_ADMIN_ATTRIBUTE_TYPE
		ModDate as GOPHER_MOD_DATE_ATTRIBUTE_TYPE
		Ttl as GOPHER_TTL_ATTRIBUTE_TYPE
		Score as GOPHER_SCORE_ATTRIBUTE_TYPE
		ScoreRange as GOPHER_SCORE_RANGE_ATTRIBUTE_TYPE
		Site as GOPHER_SITE_ATTRIBUTE_TYPE
		Organization as GOPHER_ORGANIZATION_ATTRIBUTE_TYPE
		Location as GOPHER_LOCATION_ATTRIBUTE_TYPE
		GeographicalLocation as GOPHER_GEOGRAPHICAL_LOCATION_ATTRIBUTE_TYPE
		TimeZone as GOPHER_TIMEZONE_ATTRIBUTE_TYPE
		Provider as GOPHER_PROVIDER_ATTRIBUTE_TYPE
		Version as GOPHER_VERSION_ATTRIBUTE_TYPE
		Abstract as GOPHER_ABSTRACT_ATTRIBUTE_TYPE
		View as GOPHER_VIEW_ATTRIBUTE_TYPE
		Veronica as GOPHER_VERONICA_ATTRIBUTE_TYPE
		Ask as GOPHER_ASK_ATTRIBUTE_TYPE
		Unknown as GOPHER_UNKNOWN_ATTRIBUTE_TYPE
	end union

	type GOPHER_ATTRIBUTE_TYPE field = 4
		CategoryId as DWORD
		AttributeId as DWORD
		AttributeType as GOPHER_ATTRIBUTE_TYPE_AttributeType
	end type
#endif

type LPGOPHER_ATTRIBUTE_TYPE as GOPHER_ATTRIBUTE_TYPE ptr
const MAX_GOPHER_CATEGORY_NAME = 128
const MAX_GOPHER_ATTRIBUTE_NAME = 128
const MIN_GOPHER_ATTRIBUTE_LENGTH = 256
#define GOPHER_INFO_CATEGORY __TEXT("+INFO")
#define GOPHER_ADMIN_CATEGORY __TEXT("+ADMIN")
#define GOPHER_VIEWS_CATEGORY __TEXT("+VIEWS")
#define GOPHER_ABSTRACT_CATEGORY __TEXT("+ABSTRACT")
#define GOPHER_VERONICA_CATEGORY __TEXT("+VERONICA")
#define GOPHER_ADMIN_ATTRIBUTE __TEXT("Admin")
#define GOPHER_MOD_DATE_ATTRIBUTE __TEXT("Mod-Date")
#define GOPHER_TTL_ATTRIBUTE __TEXT("TTL")
#define GOPHER_SCORE_ATTRIBUTE __TEXT("Score")
#define GOPHER_RANGE_ATTRIBUTE __TEXT("Score-range")
#define GOPHER_SITE_ATTRIBUTE __TEXT("Site")
#define GOPHER_ORG_ATTRIBUTE __TEXT("Org")
#define GOPHER_LOCATION_ATTRIBUTE __TEXT("Loc")
#define GOPHER_GEOG_ATTRIBUTE __TEXT("Geog")
#define GOPHER_TIMEZONE_ATTRIBUTE __TEXT("TZ")
#define GOPHER_PROVIDER_ATTRIBUTE __TEXT("Provider")
#define GOPHER_VERSION_ATTRIBUTE __TEXT("Version")
#define GOPHER_ABSTRACT_ATTRIBUTE __TEXT("Abstract")
#define GOPHER_VIEW_ATTRIBUTE __TEXT("View")
#define GOPHER_TREEWALK_ATTRIBUTE __TEXT("treewalk")
const GOPHER_ATTRIBUTE_ID_BASE = &habcccc00
const GOPHER_CATEGORY_ID_ALL = GOPHER_ATTRIBUTE_ID_BASE + 1
const GOPHER_CATEGORY_ID_INFO = GOPHER_ATTRIBUTE_ID_BASE + 2
const GOPHER_CATEGORY_ID_ADMIN = GOPHER_ATTRIBUTE_ID_BASE + 3
const GOPHER_CATEGORY_ID_VIEWS = GOPHER_ATTRIBUTE_ID_BASE + 4
const GOPHER_CATEGORY_ID_ABSTRACT = GOPHER_ATTRIBUTE_ID_BASE + 5
const GOPHER_CATEGORY_ID_VERONICA = GOPHER_ATTRIBUTE_ID_BASE + 6
const GOPHER_CATEGORY_ID_ASK = GOPHER_ATTRIBUTE_ID_BASE + 7
const GOPHER_CATEGORY_ID_UNKNOWN = GOPHER_ATTRIBUTE_ID_BASE + 8
const GOPHER_ATTRIBUTE_ID_ALL = GOPHER_ATTRIBUTE_ID_BASE + 9
const GOPHER_ATTRIBUTE_ID_ADMIN = GOPHER_ATTRIBUTE_ID_BASE + 10
const GOPHER_ATTRIBUTE_ID_MOD_DATE = GOPHER_ATTRIBUTE_ID_BASE + 11
const GOPHER_ATTRIBUTE_ID_TTL = GOPHER_ATTRIBUTE_ID_BASE + 12
const GOPHER_ATTRIBUTE_ID_SCORE = GOPHER_ATTRIBUTE_ID_BASE + 13
const GOPHER_ATTRIBUTE_ID_RANGE = GOPHER_ATTRIBUTE_ID_BASE + 14
const GOPHER_ATTRIBUTE_ID_SITE = GOPHER_ATTRIBUTE_ID_BASE + 15
const GOPHER_ATTRIBUTE_ID_ORG = GOPHER_ATTRIBUTE_ID_BASE + 16
const GOPHER_ATTRIBUTE_ID_LOCATION = GOPHER_ATTRIBUTE_ID_BASE + 17
const GOPHER_ATTRIBUTE_ID_GEOG = GOPHER_ATTRIBUTE_ID_BASE + 18
const GOPHER_ATTRIBUTE_ID_TIMEZONE = GOPHER_ATTRIBUTE_ID_BASE + 19
const GOPHER_ATTRIBUTE_ID_PROVIDER = GOPHER_ATTRIBUTE_ID_BASE + 20
const GOPHER_ATTRIBUTE_ID_VERSION = GOPHER_ATTRIBUTE_ID_BASE + 21
const GOPHER_ATTRIBUTE_ID_ABSTRACT = GOPHER_ATTRIBUTE_ID_BASE + 22
const GOPHER_ATTRIBUTE_ID_VIEW = GOPHER_ATTRIBUTE_ID_BASE + 23
const GOPHER_ATTRIBUTE_ID_TREEWALK = GOPHER_ATTRIBUTE_ID_BASE + 24
const GOPHER_ATTRIBUTE_ID_UNKNOWN = GOPHER_ATTRIBUTE_ID_BASE + 25
declare function GopherCreateLocatorA(byval lpszHost as LPCSTR, byval nServerPort as INTERNET_PORT, byval lpszDisplayString as LPCSTR, byval lpszSelectorString as LPCSTR, byval dwGopherType as DWORD, byval lpszLocator as LPSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GopherCreateLocator alias "GopherCreateLocatorA"(byval lpszHost as LPCSTR, byval nServerPort as INTERNET_PORT, byval lpszDisplayString as LPCSTR, byval lpszSelectorString as LPCSTR, byval dwGopherType as DWORD, byval lpszLocator as LPSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
#endif

declare function GopherCreateLocatorW(byval lpszHost as LPCWSTR, byval nServerPort as INTERNET_PORT, byval lpszDisplayString as LPCWSTR, byval lpszSelectorString as LPCWSTR, byval dwGopherType as DWORD, byval lpszLocator as LPWSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GopherCreateLocator alias "GopherCreateLocatorW"(byval lpszHost as LPCWSTR, byval nServerPort as INTERNET_PORT, byval lpszDisplayString as LPCWSTR, byval lpszSelectorString as LPCWSTR, byval dwGopherType as DWORD, byval lpszLocator as LPWSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
#endif

declare function GopherGetLocatorTypeA(byval lpszLocator as LPCSTR, byval lpdwGopherType as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GopherGetLocatorType alias "GopherGetLocatorTypeA"(byval lpszLocator as LPCSTR, byval lpdwGopherType as LPDWORD) as WINBOOL
#endif

declare function GopherGetLocatorTypeW(byval lpszLocator as LPCWSTR, byval lpdwGopherType as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GopherGetLocatorType alias "GopherGetLocatorTypeW"(byval lpszLocator as LPCWSTR, byval lpdwGopherType as LPDWORD) as WINBOOL
#endif

declare function GopherFindFirstFileA(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszSearchString as LPCSTR, byval lpFindData as LPGOPHER_FIND_DATAA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function GopherFindFirstFile alias "GopherFindFirstFileA"(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszSearchString as LPCSTR, byval lpFindData as LPGOPHER_FIND_DATAA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function GopherFindFirstFileW(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszSearchString as LPCWSTR, byval lpFindData as LPGOPHER_FIND_DATAW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function GopherFindFirstFile alias "GopherFindFirstFileW"(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszSearchString as LPCWSTR, byval lpFindData as LPGOPHER_FIND_DATAW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function GopherOpenFileA(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszView as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function GopherOpenFile alias "GopherOpenFileA"(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszView as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function GopherOpenFileW(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszView as LPCWSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function GopherOpenFile alias "GopherOpenFileW"(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszView as LPCWSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

type GOPHER_ATTRIBUTE_ENUMERATOR as function(byval lpAttributeInfo as LPGOPHER_ATTRIBUTE_TYPE, byval dwError as DWORD) as WINBOOL
declare function GopherGetAttributeA(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszAttributeName as LPCSTR, byval lpBuffer as LPBYTE, byval dwBufferLength as DWORD, byval lpdwCharactersReturned as LPDWORD, byval lpfnEnumerator as GOPHER_ATTRIBUTE_ENUMERATOR, byval dwContext as DWORD_PTR) as WINBOOL

#ifndef UNICODE
	declare function GopherGetAttribute alias "GopherGetAttributeA"(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszAttributeName as LPCSTR, byval lpBuffer as LPBYTE, byval dwBufferLength as DWORD, byval lpdwCharactersReturned as LPDWORD, byval lpfnEnumerator as GOPHER_ATTRIBUTE_ENUMERATOR, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function GopherGetAttributeW(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszAttributeName as LPCWSTR, byval lpBuffer as LPBYTE, byval dwBufferLength as DWORD, byval lpdwCharactersReturned as LPDWORD, byval lpfnEnumerator as GOPHER_ATTRIBUTE_ENUMERATOR, byval dwContext as DWORD_PTR) as WINBOOL

#ifdef UNICODE
	declare function GopherGetAttribute alias "GopherGetAttributeW"(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszAttributeName as LPCWSTR, byval lpBuffer as LPBYTE, byval dwBufferLength as DWORD, byval lpdwCharactersReturned as LPDWORD, byval lpfnEnumerator as GOPHER_ATTRIBUTE_ENUMERATOR, byval dwContext as DWORD_PTR) as WINBOOL
#endif

const HTTP_MAJOR_VERSION = 1
const HTTP_MINOR_VERSION = 0
#define HTTP_VERSIONA "HTTP/1.0"
#define HTTP_VERSIONW wstr("HTTP/1.0")

#ifdef UNICODE
	#define HTTP_VERSION HTTP_VERSIONW
#else
	#define HTTP_VERSION HTTP_VERSIONA
#endif

const HTTP_QUERY_MIME_VERSION = 0
const HTTP_QUERY_CONTENT_TYPE = 1
const HTTP_QUERY_CONTENT_TRANSFER_ENCODING = 2
const HTTP_QUERY_CONTENT_ID = 3
const HTTP_QUERY_CONTENT_DESCRIPTION = 4
const HTTP_QUERY_CONTENT_LENGTH = 5
const HTTP_QUERY_CONTENT_LANGUAGE = 6
const HTTP_QUERY_ALLOW = 7
const HTTP_QUERY_PUBLIC = 8
const HTTP_QUERY_DATE = 9
const HTTP_QUERY_EXPIRES = 10
const HTTP_QUERY_LAST_MODIFIED = 11
const HTTP_QUERY_MESSAGE_ID = 12
const HTTP_QUERY_URI = 13
const HTTP_QUERY_DERIVED_FROM = 14
const HTTP_QUERY_COST = 15
const HTTP_QUERY_LINK = 16
const HTTP_QUERY_PRAGMA = 17
const HTTP_QUERY_VERSION = 18
const HTTP_QUERY_STATUS_CODE = 19
const HTTP_QUERY_STATUS_TEXT = 20
const HTTP_QUERY_RAW_HEADERS = 21
const HTTP_QUERY_RAW_HEADERS_CRLF = 22
const HTTP_QUERY_CONNECTION = 23
const HTTP_QUERY_ACCEPT = 24
const HTTP_QUERY_ACCEPT_CHARSET = 25
const HTTP_QUERY_ACCEPT_ENCODING = 26
const HTTP_QUERY_ACCEPT_LANGUAGE = 27
const HTTP_QUERY_AUTHORIZATION = 28
const HTTP_QUERY_CONTENT_ENCODING = 29
const HTTP_QUERY_FORWARDED = 30
const HTTP_QUERY_FROM = 31
const HTTP_QUERY_IF_MODIFIED_SINCE = 32
const HTTP_QUERY_LOCATION = 33
const HTTP_QUERY_ORIG_URI = 34
const HTTP_QUERY_REFERER = 35
const HTTP_QUERY_RETRY_AFTER = 36
const HTTP_QUERY_SERVER = 37
const HTTP_QUERY_TITLE = 38
const HTTP_QUERY_USER_AGENT = 39
const HTTP_QUERY_WWW_AUTHENTICATE = 40
const HTTP_QUERY_PROXY_AUTHENTICATE = 41
const HTTP_QUERY_ACCEPT_RANGES = 42
const HTTP_QUERY_SET_COOKIE = 43
const HTTP_QUERY_COOKIE = 44
const HTTP_QUERY_REQUEST_METHOD = 45
const HTTP_QUERY_REFRESH = 46
const HTTP_QUERY_CONTENT_DISPOSITION = 47
const HTTP_QUERY_AGE = 48
const HTTP_QUERY_CACHE_CONTROL = 49
const HTTP_QUERY_CONTENT_BASE = 50
const HTTP_QUERY_CONTENT_LOCATION = 51
const HTTP_QUERY_CONTENT_MD5 = 52
const HTTP_QUERY_CONTENT_RANGE = 53
const HTTP_QUERY_ETAG = 54
const HTTP_QUERY_HOST = 55
const HTTP_QUERY_IF_MATCH = 56
const HTTP_QUERY_IF_NONE_MATCH = 57
const HTTP_QUERY_IF_RANGE = 58
const HTTP_QUERY_IF_UNMODIFIED_SINCE = 59
const HTTP_QUERY_MAX_FORWARDS = 60
const HTTP_QUERY_PROXY_AUTHORIZATION = 61
const HTTP_QUERY_RANGE = 62
const HTTP_QUERY_TRANSFER_ENCODING = 63
const HTTP_QUERY_UPGRADE = 64
const HTTP_QUERY_VARY = 65
const HTTP_QUERY_VIA = 66
const HTTP_QUERY_WARNING = 67
const HTTP_QUERY_EXPECT = 68
const HTTP_QUERY_PROXY_CONNECTION = 69
const HTTP_QUERY_UNLESS_MODIFIED_SINCE = 70
const HTTP_QUERY_ECHO_REQUEST = 71
const HTTP_QUERY_ECHO_REPLY = 72
const HTTP_QUERY_ECHO_HEADERS = 73
const HTTP_QUERY_ECHO_HEADERS_CRLF = 74
const HTTP_QUERY_PROXY_SUPPORT = 75
const HTTP_QUERY_AUTHENTICATION_INFO = 76
const HTTP_QUERY_PASSPORT_URLS = 77
const HTTP_QUERY_PASSPORT_CONFIG = 78
const HTTP_QUERY_MAX = 78
const HTTP_QUERY_CUSTOM = 65535
const HTTP_QUERY_FLAG_REQUEST_HEADERS = &h80000000
const HTTP_QUERY_FLAG_SYSTEMTIME = &h40000000
const HTTP_QUERY_FLAG_NUMBER = &h20000000
const HTTP_QUERY_FLAG_COALESCE = &h10000000
const HTTP_QUERY_MODIFIER_FLAGS_MASK = ((HTTP_QUERY_FLAG_REQUEST_HEADERS or HTTP_QUERY_FLAG_SYSTEMTIME) or HTTP_QUERY_FLAG_NUMBER) or HTTP_QUERY_FLAG_COALESCE
const HTTP_QUERY_HEADER_MASK = not HTTP_QUERY_MODIFIER_FLAGS_MASK
const HTTP_STATUS_CONTINUE = 100
const HTTP_STATUS_SWITCH_PROTOCOLS = 101
const HTTP_STATUS_OK = 200
const HTTP_STATUS_CREATED = 201
const HTTP_STATUS_ACCEPTED = 202
const HTTP_STATUS_PARTIAL = 203
const HTTP_STATUS_NO_CONTENT = 204
const HTTP_STATUS_RESET_CONTENT = 205
const HTTP_STATUS_PARTIAL_CONTENT = 206
const HTTP_STATUS_AMBIGUOUS = 300
const HTTP_STATUS_MOVED = 301
const HTTP_STATUS_REDIRECT = 302
const HTTP_STATUS_REDIRECT_METHOD = 303
const HTTP_STATUS_NOT_MODIFIED = 304
const HTTP_STATUS_USE_PROXY = 305
const HTTP_STATUS_REDIRECT_KEEP_VERB = 307
const HTTP_STATUS_BAD_REQUEST = 400
const HTTP_STATUS_DENIED = 401
const HTTP_STATUS_PAYMENT_REQ = 402
const HTTP_STATUS_FORBIDDEN = 403
const HTTP_STATUS_NOT_FOUND = 404
const HTTP_STATUS_BAD_METHOD = 405
const HTTP_STATUS_NONE_ACCEPTABLE = 406
const HTTP_STATUS_PROXY_AUTH_REQ = 407
const HTTP_STATUS_REQUEST_TIMEOUT = 408
const HTTP_STATUS_CONFLICT = 409
const HTTP_STATUS_GONE = 410
const HTTP_STATUS_LENGTH_REQUIRED = 411
const HTTP_STATUS_PRECOND_FAILED = 412
const HTTP_STATUS_REQUEST_TOO_LARGE = 413
const HTTP_STATUS_URI_TOO_LONG = 414
const HTTP_STATUS_UNSUPPORTED_MEDIA = 415
const HTTP_STATUS_RETRY_WITH = 449
const HTTP_STATUS_SERVER_ERROR = 500
const HTTP_STATUS_NOT_SUPPORTED = 501
const HTTP_STATUS_BAD_GATEWAY = 502
const HTTP_STATUS_SERVICE_UNAVAIL = 503
const HTTP_STATUS_GATEWAY_TIMEOUT = 504
const HTTP_STATUS_VERSION_NOT_SUP = 505
const HTTP_STATUS_FIRST = HTTP_STATUS_CONTINUE
const HTTP_STATUS_LAST = HTTP_STATUS_VERSION_NOT_SUP
declare function HttpOpenRequestA(byval hConnect as HINTERNET, byval lpszVerb as LPCSTR, byval lpszObjectName as LPCSTR, byval lpszVersion as LPCSTR, byval lpszReferrer as LPCSTR, byval lplpszAcceptTypes as LPCSTR ptr, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifndef UNICODE
	declare function HttpOpenRequest alias "HttpOpenRequestA"(byval hConnect as HINTERNET, byval lpszVerb as LPCSTR, byval lpszObjectName as LPCSTR, byval lpszVersion as LPCSTR, byval lpszReferrer as LPCSTR, byval lplpszAcceptTypes as LPCSTR ptr, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function HttpOpenRequestW(byval hConnect as HINTERNET, byval lpszVerb as LPCWSTR, byval lpszObjectName as LPCWSTR, byval lpszVersion as LPCWSTR, byval lpszReferrer as LPCWSTR, byval lplpszAcceptTypes as LPCWSTR ptr, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#ifdef UNICODE
	declare function HttpOpenRequest alias "HttpOpenRequestW"(byval hConnect as HINTERNET, byval lpszVerb as LPCWSTR, byval lpszObjectName as LPCWSTR, byval lpszVersion as LPCWSTR, byval lpszReferrer as LPCWSTR, byval lplpszAcceptTypes as LPCWSTR ptr, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
#endif

declare function HttpAddRequestHeadersA(byval hRequest as HINTERNET, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval dwModifiers as DWORD) as WINBOOL

#ifndef UNICODE
	declare function HttpAddRequestHeaders alias "HttpAddRequestHeadersA"(byval hRequest as HINTERNET, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval dwModifiers as DWORD) as WINBOOL
#endif

declare function HttpAddRequestHeadersW(byval hRequest as HINTERNET, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval dwModifiers as DWORD) as WINBOOL

#ifdef UNICODE
	declare function HttpAddRequestHeaders alias "HttpAddRequestHeadersW"(byval hRequest as HINTERNET, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval dwModifiers as DWORD) as WINBOOL
#endif

const HTTP_ADDREQ_INDEX_MASK = &h0000FFFF
const HTTP_ADDREQ_FLAGS_MASK = &hFFFF0000
const HTTP_ADDREQ_FLAG_ADD_IF_NEW = &h10000000
const HTTP_ADDREQ_FLAG_ADD = &h20000000
const HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA = &h40000000
const HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON = &h01000000
const HTTP_ADDREQ_FLAG_COALESCE = HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA
const HTTP_ADDREQ_FLAG_REPLACE = &h80000000
declare function HttpSendRequestA(byval hRequest as HINTERNET, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval lpOptional as LPVOID, byval dwOptionalLength as DWORD) as WINBOOL

#ifndef UNICODE
	declare function HttpSendRequest alias "HttpSendRequestA"(byval hRequest as HINTERNET, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval lpOptional as LPVOID, byval dwOptionalLength as DWORD) as WINBOOL
#endif

declare function HttpSendRequestW(byval hRequest as HINTERNET, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval lpOptional as LPVOID, byval dwOptionalLength as DWORD) as WINBOOL

#ifdef UNICODE
	declare function HttpSendRequest alias "HttpSendRequestW"(byval hRequest as HINTERNET, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval lpOptional as LPVOID, byval dwOptionalLength as DWORD) as WINBOOL
#endif

declare function HttpSendRequestExA(byval hRequest as HINTERNET, byval lpBuffersIn as LPINTERNET_BUFFERSA, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifndef UNICODE
	declare function HttpSendRequestEx alias "HttpSendRequestExA"(byval hRequest as HINTERNET, byval lpBuffersIn as LPINTERNET_BUFFERSA, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function HttpSendRequestExW(byval hRequest as HINTERNET, byval lpBuffersIn as LPINTERNET_BUFFERSW, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifdef UNICODE
	declare function HttpSendRequestEx alias "HttpSendRequestExW"(byval hRequest as HINTERNET, byval lpBuffersIn as LPINTERNET_BUFFERSW, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

const HSR_ASYNC = WININET_API_FLAG_ASYNC
const HSR_SYNC = WININET_API_FLAG_SYNC
const HSR_USE_CONTEXT = WININET_API_FLAG_USE_CONTEXT
const HSR_INITIATE = &h00000008
const HSR_DOWNLOAD = &h00000010
const HSR_CHUNKED = &h00000020
declare function HttpEndRequestA(byval hRequest as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifndef UNICODE
	declare function HttpEndRequest alias "HttpEndRequestA"(byval hRequest as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function HttpEndRequestW(byval hRequest as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#ifdef UNICODE
	declare function HttpEndRequest alias "HttpEndRequestW"(byval hRequest as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
#endif

declare function HttpQueryInfoA(byval hRequest as HINTERNET, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpdwIndex as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function HttpQueryInfo alias "HttpQueryInfoA"(byval hRequest as HINTERNET, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpdwIndex as LPDWORD) as WINBOOL
#endif

declare function HttpQueryInfoW(byval hRequest as HINTERNET, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpdwIndex as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function HttpQueryInfo alias "HttpQueryInfoW"(byval hRequest as HINTERNET, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpdwIndex as LPDWORD) as WINBOOL
#endif

const INTERNET_COOKIE_IS_SECURE = &h01
const INTERNET_COOKIE_IS_SESSION = &h02
const INTERNET_COOKIE_THIRD_PARTY = &h10
const INTERNET_COOKIE_PROMPT_REQUIRED = &h20
const INTERNET_COOKIE_EVALUATE_P3P = &h40
const INTERNET_COOKIE_APPLY_P3P = &h80
const INTERNET_COOKIE_P3P_ENABLED = &h100
const INTERNET_COOKIE_IS_RESTRICTED = &h200
const INTERNET_COOKIE_IE6 = &h400
const INTERNET_COOKIE_IS_LEGACY = &h800
declare function InternetSetCookieA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function InternetSetCookie alias "InternetSetCookieA"(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPCSTR) as WINBOOL
#endif

declare function InternetSetCookieW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function InternetSetCookie alias "InternetSetCookieW"(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPCWSTR) as WINBOOL
#endif

declare function InternetGetCookieA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPSTR, byval lpdwSize as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetGetCookie alias "InternetGetCookieA"(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPSTR, byval lpdwSize as LPDWORD) as WINBOOL
#endif

declare function InternetGetCookieW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPWSTR, byval lpdwSize as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetGetCookie alias "InternetGetCookieW"(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPWSTR, byval lpdwSize as LPDWORD) as WINBOOL
#endif

declare function InternetSetCookieExA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPCSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR) as DWORD

#ifndef UNICODE
	declare function InternetSetCookieEx alias "InternetSetCookieExA"(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPCSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR) as DWORD
#endif

declare function InternetSetCookieExW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR) as DWORD

#ifdef UNICODE
	declare function InternetSetCookieEx alias "InternetSetCookieExW"(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR) as DWORD
#endif

declare function InternetGetCookieExA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPSTR, byval lpdwSize as LPDWORD, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function InternetGetCookieEx alias "InternetGetCookieExA"(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPSTR, byval lpdwSize as LPDWORD, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function InternetGetCookieExW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPWSTR, byval lpdwSize as LPDWORD, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function InternetGetCookieEx alias "InternetGetCookieExW"(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPWSTR, byval lpdwSize as LPDWORD, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function InternetAttemptConnect(byval dwReserved as DWORD) as DWORD
declare function InternetCheckConnectionA(byval lpszUrl as LPCSTR, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetCheckConnection alias "InternetCheckConnectionA"(byval lpszUrl as LPCSTR, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetCheckConnectionW(byval lpszUrl as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetCheckConnection alias "InternetCheckConnectionW"(byval lpszUrl as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

const FLAG_ICC_FORCE_CONNECTION = &h00000001
const FLAGS_ERROR_UI_FILTER_FOR_ERRORS = &h01
const FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS = &h02
const FLAGS_ERROR_UI_FLAGS_GENERATE_DATA = &h04
const FLAGS_ERROR_UI_FLAGS_NO_UI = &h08
const FLAGS_ERROR_UI_SERIALIZE_DIALOGS = &h10
declare function InternetAuthNotifyCallback cdecl(byval dwContext as DWORD_PTR, byval dwReturn as DWORD, byval lpReserved as LPVOID) as DWORD
type PFN_AUTH_NOTIFY as function(byval as DWORD_PTR, byval as DWORD, byval as LPVOID) as DWORD

#ifndef __FB_64BIT__
	type INTERNET_AUTH_NOTIFY_DATA field = 4
		cbStruct as DWORD
		dwOptions as DWORD
		pfnNotify as PFN_AUTH_NOTIFY
		dwContext as DWORD_PTR
	end type
#elseif defined(__FB_64BIT__) and (not defined(UNICODE))
	type INTERNET_AUTH_NOTIFY_DATA
		cbStruct as DWORD
		dwOptions as DWORD
		pfnNotify as PFN_AUTH_NOTIFY
		dwContext as DWORD_PTR
	end type
#endif

#ifndef UNICODE
	declare function InternetConfirmZoneCrossing(byval hWnd as HWND, byval szUrlPrev as LPSTR, byval szUrlNew as LPSTR, byval bPost as WINBOOL) as DWORD
#elseif defined(__FB_64BIT__) and defined(UNICODE)
	type INTERNET_AUTH_NOTIFY_DATA
		cbStruct as DWORD
		dwOptions as DWORD
		pfnNotify as PFN_AUTH_NOTIFY
		dwContext as DWORD_PTR
	end type
#endif

declare function ResumeSuspendedDownload(byval hRequest as HINTERNET, byval dwResultCode as DWORD) as WINBOOL
declare function InternetErrorDlg(byval hWnd as HWND, byval hRequest as HINTERNET, byval dwError as DWORD, byval dwFlags as DWORD, byval lppvData as LPVOID ptr) as DWORD
declare function InternetConfirmZoneCrossingA(byval hWnd as HWND, byval szUrlPrev as LPSTR, byval szUrlNew as LPSTR, byval bPost as WINBOOL) as DWORD
declare function InternetConfirmZoneCrossingW(byval hWnd as HWND, byval szUrlPrev as LPWSTR, byval szUrlNew as LPWSTR, byval bPost as WINBOOL) as DWORD

#ifdef UNICODE
	declare function InternetConfirmZoneCrossing alias "InternetConfirmZoneCrossingW"(byval hWnd as HWND, byval szUrlPrev as LPWSTR, byval szUrlNew as LPWSTR, byval bPost as WINBOOL) as DWORD
#endif

const INTERNET_ERROR_BASE = 12000
const ERROR_INTERNET_OUT_OF_HANDLES = INTERNET_ERROR_BASE + 1
const ERROR_INTERNET_TIMEOUT = INTERNET_ERROR_BASE + 2
const ERROR_INTERNET_EXTENDED_ERROR = INTERNET_ERROR_BASE + 3
const ERROR_INTERNET_INTERNAL_ERROR = INTERNET_ERROR_BASE + 4
const ERROR_INTERNET_INVALID_URL = INTERNET_ERROR_BASE + 5
const ERROR_INTERNET_UNRECOGNIZED_SCHEME = INTERNET_ERROR_BASE + 6
const ERROR_INTERNET_NAME_NOT_RESOLVED = INTERNET_ERROR_BASE + 7
const ERROR_INTERNET_PROTOCOL_NOT_FOUND = INTERNET_ERROR_BASE + 8
const ERROR_INTERNET_INVALID_OPTION = INTERNET_ERROR_BASE + 9
const ERROR_INTERNET_BAD_OPTION_LENGTH = INTERNET_ERROR_BASE + 10
const ERROR_INTERNET_OPTION_NOT_SETTABLE = INTERNET_ERROR_BASE + 11
const ERROR_INTERNET_SHUTDOWN = INTERNET_ERROR_BASE + 12
const ERROR_INTERNET_INCORRECT_USER_NAME = INTERNET_ERROR_BASE + 13
const ERROR_INTERNET_INCORRECT_PASSWORD = INTERNET_ERROR_BASE + 14
const ERROR_INTERNET_LOGIN_FAILURE = INTERNET_ERROR_BASE + 15
const ERROR_INTERNET_INVALID_OPERATION = INTERNET_ERROR_BASE + 16
const ERROR_INTERNET_OPERATION_CANCELLED = INTERNET_ERROR_BASE + 17
const ERROR_INTERNET_INCORRECT_HANDLE_TYPE = INTERNET_ERROR_BASE + 18
const ERROR_INTERNET_INCORRECT_HANDLE_STATE = INTERNET_ERROR_BASE + 19
const ERROR_INTERNET_NOT_PROXY_REQUEST = INTERNET_ERROR_BASE + 20
const ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND = INTERNET_ERROR_BASE + 21
const ERROR_INTERNET_BAD_REGISTRY_PARAMETER = INTERNET_ERROR_BASE + 22
const ERROR_INTERNET_NO_DIRECT_ACCESS = INTERNET_ERROR_BASE + 23
const ERROR_INTERNET_NO_CONTEXT = INTERNET_ERROR_BASE + 24
const ERROR_INTERNET_NO_CALLBACK = INTERNET_ERROR_BASE + 25
const ERROR_INTERNET_REQUEST_PENDING = INTERNET_ERROR_BASE + 26
const ERROR_INTERNET_INCORRECT_FORMAT = INTERNET_ERROR_BASE + 27
const ERROR_INTERNET_ITEM_NOT_FOUND = INTERNET_ERROR_BASE + 28
const ERROR_INTERNET_CANNOT_CONNECT = INTERNET_ERROR_BASE + 29
const ERROR_INTERNET_CONNECTION_ABORTED = INTERNET_ERROR_BASE + 30
const ERROR_INTERNET_CONNECTION_RESET = INTERNET_ERROR_BASE + 31
const ERROR_INTERNET_FORCE_RETRY = INTERNET_ERROR_BASE + 32
const ERROR_INTERNET_INVALID_PROXY_REQUEST = INTERNET_ERROR_BASE + 33
const ERROR_INTERNET_NEED_UI = INTERNET_ERROR_BASE + 34
const ERROR_INTERNET_HANDLE_EXISTS = INTERNET_ERROR_BASE + 36
const ERROR_INTERNET_SEC_CERT_DATE_INVALID = INTERNET_ERROR_BASE + 37
const ERROR_INTERNET_SEC_CERT_CN_INVALID = INTERNET_ERROR_BASE + 38
const ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR = INTERNET_ERROR_BASE + 39
const ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR = INTERNET_ERROR_BASE + 40
const ERROR_INTERNET_MIXED_SECURITY = INTERNET_ERROR_BASE + 41
const ERROR_INTERNET_CHG_POST_IS_NON_SECURE = INTERNET_ERROR_BASE + 42
const ERROR_INTERNET_POST_IS_NON_SECURE = INTERNET_ERROR_BASE + 43
const ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED = INTERNET_ERROR_BASE + 44
const ERROR_INTERNET_INVALID_CA = INTERNET_ERROR_BASE + 45
const ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP = INTERNET_ERROR_BASE + 46
const ERROR_INTERNET_ASYNC_THREAD_FAILED = INTERNET_ERROR_BASE + 47
const ERROR_INTERNET_REDIRECT_SCHEME_CHANGE = INTERNET_ERROR_BASE + 48
const ERROR_INTERNET_DIALOG_PENDING = INTERNET_ERROR_BASE + 49
const ERROR_INTERNET_RETRY_DIALOG = INTERNET_ERROR_BASE + 50
const ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR = INTERNET_ERROR_BASE + 52
const ERROR_INTERNET_INSERT_CDROM = INTERNET_ERROR_BASE + 53
const ERROR_INTERNET_FORTEZZA_LOGIN_NEEDED = INTERNET_ERROR_BASE + 54
const ERROR_INTERNET_SEC_CERT_ERRORS = INTERNET_ERROR_BASE + 55
const ERROR_INTERNET_SEC_CERT_NO_REV = INTERNET_ERROR_BASE + 56
const ERROR_INTERNET_SEC_CERT_REV_FAILED = INTERNET_ERROR_BASE + 57
const ERROR_FTP_TRANSFER_IN_PROGRESS = INTERNET_ERROR_BASE + 110
const ERROR_FTP_DROPPED = INTERNET_ERROR_BASE + 111
const ERROR_FTP_NO_PASSIVE_MODE = INTERNET_ERROR_BASE + 112
const ERROR_GOPHER_PROTOCOL_ERROR = INTERNET_ERROR_BASE + 130
const ERROR_GOPHER_NOT_FILE = INTERNET_ERROR_BASE + 131
const ERROR_GOPHER_DATA_ERROR = INTERNET_ERROR_BASE + 132
const ERROR_GOPHER_END_OF_DATA = INTERNET_ERROR_BASE + 133
const ERROR_GOPHER_INVALID_LOCATOR = INTERNET_ERROR_BASE + 134
const ERROR_GOPHER_INCORRECT_LOCATOR_TYPE = INTERNET_ERROR_BASE + 135
const ERROR_GOPHER_NOT_GOPHER_PLUS = INTERNET_ERROR_BASE + 136
const ERROR_GOPHER_ATTRIBUTE_NOT_FOUND = INTERNET_ERROR_BASE + 137
const ERROR_GOPHER_UNKNOWN_LOCATOR = INTERNET_ERROR_BASE + 138
const ERROR_HTTP_HEADER_NOT_FOUND = INTERNET_ERROR_BASE + 150
const ERROR_HTTP_DOWNLEVEL_SERVER = INTERNET_ERROR_BASE + 151
const ERROR_HTTP_INVALID_SERVER_RESPONSE = INTERNET_ERROR_BASE + 152
const ERROR_HTTP_INVALID_HEADER = INTERNET_ERROR_BASE + 153
const ERROR_HTTP_INVALID_QUERY_REQUEST = INTERNET_ERROR_BASE + 154
const ERROR_HTTP_HEADER_ALREADY_EXISTS = INTERNET_ERROR_BASE + 155
const ERROR_HTTP_REDIRECT_FAILED = INTERNET_ERROR_BASE + 156
const ERROR_HTTP_NOT_REDIRECTED = INTERNET_ERROR_BASE + 160
const ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION = INTERNET_ERROR_BASE + 161
const ERROR_HTTP_COOKIE_DECLINED = INTERNET_ERROR_BASE + 162
const ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION = INTERNET_ERROR_BASE + 168
const ERROR_INTERNET_SECURITY_CHANNEL_ERROR = INTERNET_ERROR_BASE + 157
const ERROR_INTERNET_UNABLE_TO_CACHE_FILE = INTERNET_ERROR_BASE + 158
const ERROR_INTERNET_TCPIP_NOT_INSTALLED = INTERNET_ERROR_BASE + 159
const ERROR_INTERNET_DISCONNECTED = INTERNET_ERROR_BASE + 163
const ERROR_INTERNET_SERVER_UNREACHABLE = INTERNET_ERROR_BASE + 164
const ERROR_INTERNET_PROXY_SERVER_UNREACHABLE = INTERNET_ERROR_BASE + 165
const ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT = INTERNET_ERROR_BASE + 166
const ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT = INTERNET_ERROR_BASE + 167
const ERROR_INTERNET_SEC_INVALID_CERT = INTERNET_ERROR_BASE + 169
const ERROR_INTERNET_SEC_CERT_REVOKED = INTERNET_ERROR_BASE + 170
const ERROR_INTERNET_FAILED_DUETOSECURITYCHECK = INTERNET_ERROR_BASE + 171
const ERROR_INTERNET_NOT_INITIALIZED = INTERNET_ERROR_BASE + 172
const ERROR_INTERNET_NEED_MSN_SSPI_PKG = INTERNET_ERROR_BASE + 173
const ERROR_INTERNET_LOGIN_FAILURE_DISPLAY_ENTITY_BODY = INTERNET_ERROR_BASE + 174
const INTERNET_ERROR_LAST = ERROR_INTERNET_LOGIN_FAILURE_DISPLAY_ENTITY_BODY
const NORMAL_CACHE_ENTRY = &h00000001
const STICKY_CACHE_ENTRY = &h00000004
const EDITED_CACHE_ENTRY = &h00000008
const TRACK_OFFLINE_CACHE_ENTRY = &h00000010
const TRACK_ONLINE_CACHE_ENTRY = &h00000020
const SPARSE_CACHE_ENTRY = &h00010000
const COOKIE_CACHE_ENTRY = &h00100000
const URLHISTORY_CACHE_ENTRY = &h00200000
const URLCACHE_FIND_DEFAULT_FILTER = ((((NORMAL_CACHE_ENTRY or COOKIE_CACHE_ENTRY) or URLHISTORY_CACHE_ENTRY) or TRACK_OFFLINE_CACHE_ENTRY) or TRACK_ONLINE_CACHE_ENTRY) or STICKY_CACHE_ENTRY

#ifdef __FB_64BIT__
	type _INTERNET_CACHE_ENTRY_INFOA
		dwStructSize as DWORD
		lpszSourceUrlName as LPSTR
		lpszLocalFileName as LPSTR
		CacheEntryType as DWORD
		dwUseCount as DWORD
		dwHitRate as DWORD
		dwSizeLow as DWORD
		dwSizeHigh as DWORD
		LastModifiedTime as FILETIME
		ExpireTime as FILETIME
		LastAccessTime as FILETIME
		LastSyncTime as FILETIME
		lpHeaderInfo as LPSTR
		dwHeaderInfoSize as DWORD
		lpszFileExtension as LPSTR

		union
			dwReserved as DWORD
			dwExemptDelta as DWORD
		end union
	end type
#else
	type _INTERNET_CACHE_ENTRY_INFOA field = 4
		dwStructSize as DWORD
		lpszSourceUrlName as LPSTR
		lpszLocalFileName as LPSTR
		CacheEntryType as DWORD
		dwUseCount as DWORD
		dwHitRate as DWORD
		dwSizeLow as DWORD
		dwSizeHigh as DWORD
		LastModifiedTime as FILETIME
		ExpireTime as FILETIME
		LastAccessTime as FILETIME
		LastSyncTime as FILETIME
		lpHeaderInfo as LPSTR
		dwHeaderInfoSize as DWORD
		lpszFileExtension as LPSTR

		union field = 4
			dwReserved as DWORD
			dwExemptDelta as DWORD
		end union
	end type
#endif

type INTERNET_CACHE_ENTRY_INFOA as _INTERNET_CACHE_ENTRY_INFOA
type LPINTERNET_CACHE_ENTRY_INFOA as _INTERNET_CACHE_ENTRY_INFOA ptr

#ifdef __FB_64BIT__
	type _INTERNET_CACHE_ENTRY_INFOW
		dwStructSize as DWORD
		lpszSourceUrlName as LPWSTR
		lpszLocalFileName as LPWSTR
		CacheEntryType as DWORD
		dwUseCount as DWORD
		dwHitRate as DWORD
		dwSizeLow as DWORD
		dwSizeHigh as DWORD
		LastModifiedTime as FILETIME
		ExpireTime as FILETIME
		LastAccessTime as FILETIME
		LastSyncTime as FILETIME
		lpHeaderInfo as LPWSTR
		dwHeaderInfoSize as DWORD
		lpszFileExtension as LPWSTR

		union
			dwReserved as DWORD
			dwExemptDelta as DWORD
		end union
	end type
#else
	type _INTERNET_CACHE_ENTRY_INFOW field = 4
		dwStructSize as DWORD
		lpszSourceUrlName as LPWSTR
		lpszLocalFileName as LPWSTR
		CacheEntryType as DWORD
		dwUseCount as DWORD
		dwHitRate as DWORD
		dwSizeLow as DWORD
		dwSizeHigh as DWORD
		LastModifiedTime as FILETIME
		ExpireTime as FILETIME
		LastAccessTime as FILETIME
		LastSyncTime as FILETIME
		lpHeaderInfo as LPWSTR
		dwHeaderInfoSize as DWORD
		lpszFileExtension as LPWSTR

		union field = 4
			dwReserved as DWORD
			dwExemptDelta as DWORD
		end union
	end type
#endif

type INTERNET_CACHE_ENTRY_INFOW as _INTERNET_CACHE_ENTRY_INFOW
type LPINTERNET_CACHE_ENTRY_INFOW as _INTERNET_CACHE_ENTRY_INFOW ptr

#ifdef UNICODE
	type INTERNET_CACHE_ENTRY_INFO as INTERNET_CACHE_ENTRY_INFOW
	type LPINTERNET_CACHE_ENTRY_INFO as LPINTERNET_CACHE_ENTRY_INFOW
#else
	type INTERNET_CACHE_ENTRY_INFO as INTERNET_CACHE_ENTRY_INFOA
	type LPINTERNET_CACHE_ENTRY_INFO as LPINTERNET_CACHE_ENTRY_INFOA
#endif

#ifdef __FB_64BIT__
	type _INTERNET_CACHE_TIMESTAMPS
		ftExpires as FILETIME
		ftLastModified as FILETIME
	end type
#else
	type _INTERNET_CACHE_TIMESTAMPS field = 4
		ftExpires as FILETIME
		ftLastModified as FILETIME
	end type
#endif

type INTERNET_CACHE_TIMESTAMPS as _INTERNET_CACHE_TIMESTAMPS
type LPINTERNET_CACHE_TIMESTAMPS as _INTERNET_CACHE_TIMESTAMPS ptr
type GROUPID as LONGLONG

const CACHEGROUP_ATTRIBUTE_GET_ALL = &hffffffff
const CACHEGROUP_ATTRIBUTE_BASIC = &h00000001
const CACHEGROUP_ATTRIBUTE_FLAG = &h00000002
const CACHEGROUP_ATTRIBUTE_TYPE = &h00000004
const CACHEGROUP_ATTRIBUTE_QUOTA = &h00000008
const CACHEGROUP_ATTRIBUTE_GROUPNAME = &h00000010
const CACHEGROUP_ATTRIBUTE_STORAGE = &h00000020
const CACHEGROUP_FLAG_NONPURGEABLE = &h00000001
const CACHEGROUP_FLAG_GIDONLY = &h00000004
const CACHEGROUP_FLAG_FLUSHURL_ONDELETE = &h00000002
const CACHEGROUP_SEARCH_ALL = &h00000000
const CACHEGROUP_SEARCH_BYURL = &h00000001
const CACHEGROUP_TYPE_INVALID = &h00000001
const CACHEGROUP_READWRITE_MASK = ((CACHEGROUP_ATTRIBUTE_TYPE or CACHEGROUP_ATTRIBUTE_QUOTA) or CACHEGROUP_ATTRIBUTE_GROUPNAME) or CACHEGROUP_ATTRIBUTE_STORAGE
const GROUPNAME_MAX_LENGTH = 120
const GROUP_OWNER_STORAGE_SIZE = 4

#ifdef __FB_64BIT__
	type _INTERNET_CACHE_GROUP_INFOA
		dwGroupSize as DWORD
		dwGroupFlags as DWORD
		dwGroupType as DWORD
		dwDiskUsage as DWORD
		dwDiskQuota as DWORD
		dwOwnerStorage(0 to 3) as DWORD
		szGroupName as zstring * 120
	end type
#else
	type _INTERNET_CACHE_GROUP_INFOA field = 4
		dwGroupSize as DWORD
		dwGroupFlags as DWORD
		dwGroupType as DWORD
		dwDiskUsage as DWORD
		dwDiskQuota as DWORD
		dwOwnerStorage(0 to 3) as DWORD
		szGroupName as zstring * 120
	end type
#endif

type INTERNET_CACHE_GROUP_INFOA as _INTERNET_CACHE_GROUP_INFOA
type LPINTERNET_CACHE_GROUP_INFOA as _INTERNET_CACHE_GROUP_INFOA ptr

#ifdef __FB_64BIT__
	type _INTERNET_CACHE_GROUP_INFOW
		dwGroupSize as DWORD
		dwGroupFlags as DWORD
		dwGroupType as DWORD
		dwDiskUsage as DWORD
		dwDiskQuota as DWORD
		dwOwnerStorage(0 to 3) as DWORD
		szGroupName as wstring * 120
	end type
#else
	type _INTERNET_CACHE_GROUP_INFOW field = 4
		dwGroupSize as DWORD
		dwGroupFlags as DWORD
		dwGroupType as DWORD
		dwDiskUsage as DWORD
		dwDiskQuota as DWORD
		dwOwnerStorage(0 to 3) as DWORD
		szGroupName as wstring * 120
	end type
#endif

type INTERNET_CACHE_GROUP_INFOW as _INTERNET_CACHE_GROUP_INFOW
type LPINTERNET_CACHE_GROUP_INFOW as _INTERNET_CACHE_GROUP_INFOW ptr

#ifdef UNICODE
	type INTERNET_CACHE_GROUP_INFO as INTERNET_CACHE_GROUP_INFOW
	type LPINTERNET_CACHE_GROUP_INFO as LPINTERNET_CACHE_GROUP_INFOW
#else
	type INTERNET_CACHE_GROUP_INFO as INTERNET_CACHE_GROUP_INFOA
	type LPINTERNET_CACHE_GROUP_INFO as LPINTERNET_CACHE_GROUP_INFOA
#endif

declare function CreateUrlCacheEntryA(byval lpszUrlName as LPCSTR, byval dwExpectedFileSize as DWORD, byval lpszFileExtension as LPCSTR, byval lpszFileName as LPSTR, byval dwReserved as DWORD) as WINBOOL

#ifndef UNICODE
	declare function CreateUrlCacheEntry alias "CreateUrlCacheEntryA"(byval lpszUrlName as LPCSTR, byval dwExpectedFileSize as DWORD, byval lpszFileExtension as LPCSTR, byval lpszFileName as LPSTR, byval dwReserved as DWORD) as WINBOOL
#endif

declare function CreateUrlCacheEntryW(byval lpszUrlName as LPCWSTR, byval dwExpectedFileSize as DWORD, byval lpszFileExtension as LPCWSTR, byval lpszFileName as LPWSTR, byval dwReserved as DWORD) as WINBOOL

#ifdef UNICODE
	declare function CreateUrlCacheEntry alias "CreateUrlCacheEntryW"(byval lpszUrlName as LPCWSTR, byval dwExpectedFileSize as DWORD, byval lpszFileExtension as LPCWSTR, byval lpszFileName as LPWSTR, byval dwReserved as DWORD) as WINBOOL
#endif

declare function CommitUrlCacheEntryA(byval lpszUrlName as LPCSTR, byval lpszLocalFileName as LPCSTR, byval ExpireTime as FILETIME, byval LastModifiedTime as FILETIME, byval CacheEntryType as DWORD, byval lpHeaderInfo as LPBYTE, byval dwHeaderSize as DWORD, byval lpszFileExtension as LPCSTR, byval lpszOriginalUrl as LPCSTR) as WINBOOL

#ifndef UNICODE
	declare function CommitUrlCacheEntry alias "CommitUrlCacheEntryA"(byval lpszUrlName as LPCSTR, byval lpszLocalFileName as LPCSTR, byval ExpireTime as FILETIME, byval LastModifiedTime as FILETIME, byval CacheEntryType as DWORD, byval lpHeaderInfo as LPBYTE, byval dwHeaderSize as DWORD, byval lpszFileExtension as LPCSTR, byval lpszOriginalUrl as LPCSTR) as WINBOOL
#endif

declare function CommitUrlCacheEntryW(byval lpszUrlName as LPCWSTR, byval lpszLocalFileName as LPCWSTR, byval ExpireTime as FILETIME, byval LastModifiedTime as FILETIME, byval CacheEntryType as DWORD, byval lpszHeaderInfo as LPWSTR, byval dwHeaders as DWORD, byval lpszFileExtension as LPCWSTR, byval lpszOriginalUrl as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function CommitUrlCacheEntry alias "CommitUrlCacheEntryW"(byval lpszUrlName as LPCWSTR, byval lpszLocalFileName as LPCWSTR, byval ExpireTime as FILETIME, byval LastModifiedTime as FILETIME, byval CacheEntryType as DWORD, byval lpszHeaderInfo as LPWSTR, byval dwHeaders as DWORD, byval lpszFileExtension as LPCWSTR, byval lpszOriginalUrl as LPCWSTR) as WINBOOL
#endif

declare function RetrieveUrlCacheEntryFileA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval dwReserved as DWORD) as WINBOOL

#ifndef UNICODE
	declare function RetrieveUrlCacheEntryFile alias "RetrieveUrlCacheEntryFileA"(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function RetrieveUrlCacheEntryFileW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval dwReserved as DWORD) as WINBOOL

#ifdef UNICODE
	declare function RetrieveUrlCacheEntryFile alias "RetrieveUrlCacheEntryFileW"(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function UnlockUrlCacheEntryFileA(byval lpszUrlName as LPCSTR, byval dwReserved as DWORD) as WINBOOL

#ifndef UNICODE
	declare function UnlockUrlCacheEntryFile alias "UnlockUrlCacheEntryFileA"(byval lpszUrlName as LPCSTR, byval dwReserved as DWORD) as WINBOOL
#endif

declare function UnlockUrlCacheEntryFileW(byval lpszUrlName as LPCWSTR, byval dwReserved as DWORD) as WINBOOL

#ifdef UNICODE
	declare function UnlockUrlCacheEntryFile alias "UnlockUrlCacheEntryFileW"(byval lpszUrlName as LPCWSTR, byval dwReserved as DWORD) as WINBOOL
#endif

declare function RetrieveUrlCacheEntryStreamA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval fRandomRead as WINBOOL, byval dwReserved as DWORD) as HANDLE

#ifndef UNICODE
	declare function RetrieveUrlCacheEntryStream alias "RetrieveUrlCacheEntryStreamA"(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval fRandomRead as WINBOOL, byval dwReserved as DWORD) as HANDLE
#endif

declare function RetrieveUrlCacheEntryStreamW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval fRandomRead as WINBOOL, byval dwReserved as DWORD) as HANDLE

#ifdef UNICODE
	declare function RetrieveUrlCacheEntryStream alias "RetrieveUrlCacheEntryStreamW"(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval fRandomRead as WINBOOL, byval dwReserved as DWORD) as HANDLE
#endif

declare function ReadUrlCacheEntryStream(byval hUrlCacheStream as HANDLE, byval dwLocation as DWORD, byval lpBuffer as LPVOID, byval lpdwLen as LPDWORD, byval Reserved as DWORD) as WINBOOL
declare function UnlockUrlCacheEntryStream(byval hUrlCacheStream as HANDLE, byval Reserved as DWORD) as WINBOOL
declare function GetUrlCacheEntryInfoA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function GetUrlCacheEntryInfo alias "GetUrlCacheEntryInfoA"(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
#endif

declare function GetUrlCacheEntryInfoW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function GetUrlCacheEntryInfo alias "GetUrlCacheEntryInfoW"(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
#endif

declare function FindFirstUrlCacheGroup(byval dwFlags as DWORD, byval dwFilter as DWORD, byval lpSearchCondition as LPVOID, byval dwSearchCondition as DWORD, byval lpGroupId as GROUPID ptr, byval lpReserved as LPVOID) as HANDLE
declare function FindNextUrlCacheGroup(byval hFind as HANDLE, byval lpGroupId as GROUPID ptr, byval lpReserved as LPVOID) as WINBOOL
declare function GetUrlCacheGroupAttributeA(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOA, byval lpdwGroupInfo as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function GetUrlCacheGroupAttribute alias "GetUrlCacheGroupAttributeA"(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOA, byval lpdwGroupInfo as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function GetUrlCacheGroupAttributeW(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOW, byval lpdwGroupInfo as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function GetUrlCacheGroupAttribute alias "GetUrlCacheGroupAttributeW"(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOW, byval lpdwGroupInfo as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function SetUrlCacheGroupAttributeA(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOA, byval lpReserved as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function SetUrlCacheGroupAttribute alias "SetUrlCacheGroupAttributeA"(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOA, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function SetUrlCacheGroupAttributeW(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOW, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function SetUrlCacheGroupAttribute alias "SetUrlCacheGroupAttributeW"(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOW, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function CreateUrlCacheGroup(byval dwFlags as DWORD, byval lpReserved as LPVOID) as GROUPID
declare function DeleteUrlCacheGroup(byval GroupId as GROUPID, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function GetUrlCacheEntryInfoExA(byval lpszUrl as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval lpszRedirectUrl as LPSTR, byval lpcbRedirectUrl as LPDWORD, byval lpReserved as LPVOID, byval dwFlags as DWORD) as WINBOOL

#ifndef UNICODE
	declare function GetUrlCacheEntryInfoEx alias "GetUrlCacheEntryInfoExA"(byval lpszUrl as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval lpszRedirectUrl as LPSTR, byval lpcbRedirectUrl as LPDWORD, byval lpReserved as LPVOID, byval dwFlags as DWORD) as WINBOOL
#endif

declare function GetUrlCacheEntryInfoExW(byval lpszUrl as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval lpszRedirectUrl as LPWSTR, byval lpcbRedirectUrl as LPDWORD, byval lpReserved as LPVOID, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function GetUrlCacheEntryInfoEx alias "GetUrlCacheEntryInfoExW"(byval lpszUrl as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval lpszRedirectUrl as LPWSTR, byval lpcbRedirectUrl as LPDWORD, byval lpReserved as LPVOID, byval dwFlags as DWORD) as WINBOOL
#endif

const CACHE_ENTRY_ATTRIBUTE_FC = &h00000004
const CACHE_ENTRY_HITRATE_FC = &h00000010
const CACHE_ENTRY_MODTIME_FC = &h00000040
const CACHE_ENTRY_EXPTIME_FC = &h00000080
const CACHE_ENTRY_ACCTIME_FC = &h00000100
const CACHE_ENTRY_SYNCTIME_FC = &h00000200
const CACHE_ENTRY_HEADERINFO_FC = &h00000400
const CACHE_ENTRY_EXEMPT_DELTA_FC = &h00000800

#ifndef UNICODE
	declare function SetUrlCacheEntryGroup(byval lpszUrlName as LPCSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL
	declare function DeleteUrlCacheEntry(byval lpszUrlName as LPCSTR) as WINBOOL
	declare function InternetDial(byval hwndParent as HWND, byval lpszConnectoid as LPSTR, byval dwFlags as DWORD, byval lpdwConnection as LPDWORD, byval dwReserved as DWORD) as DWORD
	declare function InternetGoOnline(byval lpszURL as LPSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL
#endif

declare function SetUrlCacheEntryInfoA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval dwFieldControl as DWORD) as WINBOOL

#ifndef UNICODE
	declare function SetUrlCacheEntryInfo alias "SetUrlCacheEntryInfoA"(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval dwFieldControl as DWORD) as WINBOOL
#endif

declare function SetUrlCacheEntryInfoW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval dwFieldControl as DWORD) as WINBOOL

#ifdef UNICODE
	declare function SetUrlCacheEntryInfo alias "SetUrlCacheEntryInfoW"(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval dwFieldControl as DWORD) as WINBOOL
#endif

const INTERNET_CACHE_GROUP_ADD = 0
const INTERNET_CACHE_GROUP_REMOVE = 1
declare function SetUrlCacheEntryGroupA(byval lpszUrlName as LPCSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function SetUrlCacheEntryGroupW(byval lpszUrlName as LPCWSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function SetUrlCacheEntryGroup alias "SetUrlCacheEntryGroupW"(byval lpszUrlName as LPCWSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function FindFirstUrlCacheEntryExA(byval lpszUrlSearchPattern as LPCSTR, byval dwFlags as DWORD, byval dwFilter as DWORD, byval GroupId as GROUPID, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as HANDLE

#ifndef UNICODE
	declare function FindFirstUrlCacheEntryEx alias "FindFirstUrlCacheEntryExA"(byval lpszUrlSearchPattern as LPCSTR, byval dwFlags as DWORD, byval dwFilter as DWORD, byval GroupId as GROUPID, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as HANDLE
#endif

declare function FindFirstUrlCacheEntryExW(byval lpszUrlSearchPattern as LPCWSTR, byval dwFlags as DWORD, byval dwFilter as DWORD, byval GroupId as GROUPID, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as HANDLE

#ifdef UNICODE
	declare function FindFirstUrlCacheEntryEx alias "FindFirstUrlCacheEntryExW"(byval lpszUrlSearchPattern as LPCWSTR, byval dwFlags as DWORD, byval dwFilter as DWORD, byval GroupId as GROUPID, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as HANDLE
#endif

declare function FindNextUrlCacheEntryExA(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifndef UNICODE
	declare function FindNextUrlCacheEntryEx alias "FindNextUrlCacheEntryExA"(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function FindNextUrlCacheEntryExW(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as WINBOOL

#ifdef UNICODE
	declare function FindNextUrlCacheEntryEx alias "FindNextUrlCacheEntryExW"(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
#endif

declare function FindFirstUrlCacheEntryA(byval lpszUrlSearchPattern as LPCSTR, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as HANDLE

#ifndef UNICODE
	declare function FindFirstUrlCacheEntry alias "FindFirstUrlCacheEntryA"(byval lpszUrlSearchPattern as LPCSTR, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as HANDLE
#endif

declare function FindFirstUrlCacheEntryW(byval lpszUrlSearchPattern as LPCWSTR, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as HANDLE

#ifdef UNICODE
	declare function FindFirstUrlCacheEntry alias "FindFirstUrlCacheEntryW"(byval lpszUrlSearchPattern as LPCWSTR, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as HANDLE
#endif

declare function FindNextUrlCacheEntryA(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL

#ifndef UNICODE
	declare function FindNextUrlCacheEntry alias "FindNextUrlCacheEntryA"(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
#endif

declare function FindNextUrlCacheEntryW(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function FindNextUrlCacheEntry alias "FindNextUrlCacheEntryW"(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
#endif

declare function FindCloseUrlCache(byval hEnumHandle as HANDLE) as WINBOOL
declare function DeleteUrlCacheEntryA(byval lpszUrlName as LPCSTR) as WINBOOL
declare function DeleteUrlCacheEntryW(byval lpszUrlName as LPCWSTR) as WINBOOL

#ifdef UNICODE
	declare function DeleteUrlCacheEntry alias "DeleteUrlCacheEntryW"(byval lpszUrlName as LPCWSTR) as WINBOOL
#endif

declare function InternetDialA(byval hwndParent as HWND, byval lpszConnectoid as LPSTR, byval dwFlags as DWORD, byval lpdwConnection as DWORD_PTR ptr, byval dwReserved as DWORD) as DWORD
declare function InternetDialW(byval hwndParent as HWND, byval lpszConnectoid as LPWSTR, byval dwFlags as DWORD, byval lpdwConnection as DWORD_PTR ptr, byval dwReserved as DWORD) as DWORD

#ifdef UNICODE
	declare function InternetDial alias "InternetDialW"(byval hwndParent as HWND, byval lpszConnectoid as LPWSTR, byval dwFlags as DWORD, byval lpdwConnection as DWORD_PTR ptr, byval dwReserved as DWORD) as DWORD
#endif

const INTERNET_DIAL_FORCE_PROMPT = &h2000
const INTERNET_DIAL_SHOW_OFFLINE = &h4000
const INTERNET_DIAL_UNATTENDED = &h8000
declare function InternetHangUp(byval dwConnection as DWORD_PTR, byval dwReserved as DWORD) as DWORD
const INTERENT_GOONLINE_REFRESH = &h00000001
const INTERENT_GOONLINE_MASK = &h00000001
declare function InternetGoOnlineA(byval lpszURL as LPSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL
declare function InternetGoOnlineW(byval lpszURL as LPWSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetGoOnline alias "InternetGoOnlineW"(byval lpszURL as LPWSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL
#endif

declare function InternetAutodial(byval dwFlags as DWORD, byval hwndParent as HWND) as WINBOOL
const INTERNET_AUTODIAL_FORCE_ONLINE = 1
const INTERNET_AUTODIAL_FORCE_UNATTENDED = 2
const INTERNET_AUTODIAL_FAILIFSECURITYCHECK = 4
const INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT = 8
const INTERNET_AUTODIAL_FLAGS_MASK = ((INTERNET_AUTODIAL_FORCE_ONLINE or INTERNET_AUTODIAL_FORCE_UNATTENDED) or INTERNET_AUTODIAL_FAILIFSECURITYCHECK) or INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT

declare function InternetAutodialHangup(byval dwReserved as DWORD) as WINBOOL
declare function InternetGetConnectedState(byval lpdwFlags as LPDWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetGetConnectedStateExA(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPSTR, byval dwBufLen as DWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetGetConnectedStateExW(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPWSTR, byval dwBufLen as DWORD, byval dwReserved as DWORD) as WINBOOL
const PROXY_AUTO_DETECT_TYPE_DHCP = 1
const PROXY_AUTO_DETECT_TYPE_DNS_A = 2

#ifdef __FB_64BIT__
	type AutoProxyHelperVtbl
		IsResolvable as function(byval lpszHost as LPSTR) as WINBOOL
		GetIPAddress as function(byval lpszIPAddress as LPSTR, byval lpdwIPAddressSize as LPDWORD) as DWORD
		ResolveHostName as function(byval lpszHostName as LPSTR, byval lpszIPAddress as LPSTR, byval lpdwIPAddressSize as LPDWORD) as DWORD
		IsInNet as function(byval lpszIPAddress as LPSTR, byval lpszDest as LPSTR, byval lpszMask as LPSTR) as WINBOOL
	end type

	type AUTO_PROXY_SCRIPT_BUFFER
		dwStructSize as DWORD
		lpszScriptBuffer as LPSTR
		dwScriptBufferSize as DWORD
	end type
#else
	type AutoProxyHelperVtbl field = 4
		IsResolvable as function(byval lpszHost as LPSTR) as WINBOOL
		GetIPAddress as function(byval lpszIPAddress as LPSTR, byval lpdwIPAddressSize as LPDWORD) as DWORD
		ResolveHostName as function(byval lpszHostName as LPSTR, byval lpszIPAddress as LPSTR, byval lpdwIPAddressSize as LPDWORD) as DWORD
		IsInNet as function(byval lpszIPAddress as LPSTR, byval lpszDest as LPSTR, byval lpszMask as LPSTR) as WINBOOL
	end type

	type AUTO_PROXY_SCRIPT_BUFFER field = 4
		dwStructSize as DWORD
		lpszScriptBuffer as LPSTR
		dwScriptBufferSize as DWORD
	end type
#endif

type LPAUTO_PROXY_SCRIPT_BUFFER as AUTO_PROXY_SCRIPT_BUFFER ptr

#ifdef __FB_64BIT__
	type AutoProxyHelperFunctions
		lpVtbl as const AutoProxyHelperVtbl ptr
	end type
#else
	type AutoProxyHelperFunctions field = 4
		lpVtbl as const AutoProxyHelperVtbl ptr
	end type
#endif

type pfnInternetInitializeAutoProxyDll as function(byval dwVersion as DWORD, byval lpszDownloadedTempFile as LPSTR, byval lpszMime as LPSTR, byval lpAutoProxyCallbacks as AutoProxyHelperFunctions ptr, byval lpAutoProxyScriptBuffer as LPAUTO_PROXY_SCRIPT_BUFFER) as WINBOOL
type pfnInternetDeInitializeAutoProxyDll as function(byval lpszMime as LPSTR, byval dwReserved as DWORD) as WINBOOL
type pfnInternetGetProxyInfo as function(byval lpszUrl as LPCSTR, byval dwUrlLength as DWORD, byval lpszUrlHostName as LPSTR, byval dwUrlHostNameLength as DWORD, byval lplpszProxyHostName as LPSTR ptr, byval lpdwProxyHostNameLength as LPDWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetGetConnectedStateEx alias "InternetGetConnectedStateExW"(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPWSTR, byval dwBufLen as DWORD, byval dwReserved as DWORD) as WINBOOL
#else
	declare function InternetGetConnectedStateEx(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPSTR, byval dwNameLen as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetInitializeAutoProxyDll(byval dwReserved as DWORD) as WINBOOL
declare function InternetDeInitializeAutoProxyDll(byval lpszMime as LPSTR, byval dwReserved as DWORD) as WINBOOL
declare function InternetGetProxyInfo(byval lpszUrl as LPCSTR, byval dwUrlLength as DWORD, byval lpszUrlHostName as LPSTR, byval dwUrlHostNameLength as DWORD, byval lplpszProxyHostName as LPSTR ptr, byval lpdwProxyHostNameLength as LPDWORD) as WINBOOL
declare function DetectAutoProxyUrl(byval lpszAutoProxyUrl as LPSTR, byval dwAutoProxyUrlLength as DWORD, byval dwDetectFlags as DWORD) as WINBOOL
declare function CreateMD5SSOHash(byval pszChallengeInfo as PWSTR, byval pwszRealm as PWSTR, byval pwszTarget as PWSTR, byval pbHexHash as PBYTE) as WINBOOL

const INTERNET_CONNECTION_MODEM = &h01
const INTERNET_CONNECTION_LAN = &h02
const INTERNET_CONNECTION_PROXY = &h04
const INTERNET_CONNECTION_MODEM_BUSY = &h08
const INTERNET_RAS_INSTALLED = &h10
const INTERNET_CONNECTION_OFFLINE = &h20
const INTERNET_CONNECTION_CONFIGURED = &h40
type PFN_DIAL_HANDLER as function(byval as HWND, byval as LPCSTR, byval as DWORD, byval as LPDWORD) as DWORD
const INTERNET_CUSTOMDIAL_CONNECT = 0
const INTERNET_CUSTOMDIAL_UNATTENDED = 1
const INTERNET_CUSTOMDIAL_DISCONNECT = 2
const INTERNET_CUSTOMDIAL_SHOWOFFLINE = 4
const INTERNET_CUSTOMDIAL_SAFE_FOR_UNATTENDED = 1
const INTERNET_CUSTOMDIAL_WILL_SUPPLY_STATE = 2
const INTERNET_CUSTOMDIAL_CAN_HANGUP = 4

#ifndef UNICODE
	declare function InternetSetDialState(byval lpszConnectoid as LPCSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetSetDialStateA(byval lpszConnectoid as LPCSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetSetDialStateW(byval lpszConnectoid as LPCWSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetSetDialState alias "InternetSetDialStateW"(byval lpszConnectoid as LPCWSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

const INTERNET_DIALSTATE_DISCONNECTED = 1
declare function InternetSetPerSiteCookieDecisionA(byval pchHostName as LPCSTR, byval dwDecision as DWORD) as WINBOOL

#ifndef UNICODE
	declare function InternetSetPerSiteCookieDecision alias "InternetSetPerSiteCookieDecisionA"(byval pchHostName as LPCSTR, byval dwDecision as DWORD) as WINBOOL
#endif

declare function InternetSetPerSiteCookieDecisionW(byval pchHostName as LPCWSTR, byval dwDecision as DWORD) as WINBOOL

#ifdef UNICODE
	declare function InternetSetPerSiteCookieDecision alias "InternetSetPerSiteCookieDecisionW"(byval pchHostName as LPCWSTR, byval dwDecision as DWORD) as WINBOOL
#endif

declare function InternetGetPerSiteCookieDecisionA(byval pchHostName as LPCSTR, byval pResult as ulong ptr) as WINBOOL

#ifndef UNICODE
	declare function InternetGetPerSiteCookieDecision alias "InternetGetPerSiteCookieDecisionA"(byval pchHostName as LPCSTR, byval pResult as ulong ptr) as WINBOOL
#endif

declare function InternetGetPerSiteCookieDecisionW(byval pchHostName as LPCWSTR, byval pResult as ulong ptr) as WINBOOL

#ifdef UNICODE
	declare function InternetGetPerSiteCookieDecision alias "InternetGetPerSiteCookieDecisionW"(byval pchHostName as LPCWSTR, byval pResult as ulong ptr) as WINBOOL
#endif

declare function InternetClearAllPerSiteCookieDecisions() as WINBOOL
declare function InternetEnumPerSiteCookieDecisionA(byval pszSiteName as LPSTR, byval pcSiteNameSize as ulong ptr, byval pdwDecision as ulong ptr, byval dwIndex as ulong) as WINBOOL

#ifndef UNICODE
	declare function InternetEnumPerSiteCookieDecision alias "InternetEnumPerSiteCookieDecisionA"(byval pszSiteName as LPSTR, byval pcSiteNameSize as ulong ptr, byval pdwDecision as ulong ptr, byval dwIndex as ulong) as WINBOOL
#endif

declare function InternetEnumPerSiteCookieDecisionW(byval pszSiteName as LPWSTR, byval pcSiteNameSize as ulong ptr, byval pdwDecision as ulong ptr, byval dwIndex as ulong) as WINBOOL

#ifdef UNICODE
	declare function InternetEnumPerSiteCookieDecision alias "InternetEnumPerSiteCookieDecisionW"(byval pszSiteName as LPWSTR, byval pcSiteNameSize as ulong ptr, byval pdwDecision as ulong ptr, byval dwIndex as ulong) as WINBOOL
#endif

const INTERNET_IDENTITY_FLAG_PRIVATE_CACHE = &h01
const INTERNET_IDENTITY_FLAG_SHARED_CACHE = &h02
const INTERNET_IDENTITY_FLAG_CLEAR_DATA = &h04
const INTERNET_IDENTITY_FLAG_CLEAR_COOKIES = &h08
const INTERNET_IDENTITY_FLAG_CLEAR_HISTORY = &h10
const INTERNET_IDENTITY_FLAG_CLEAR_CONTENT = &h20
const INTERNET_SUPPRESS_RESET_ALL = &h00
const INTERNET_SUPPRESS_COOKIE_POLICY = &h01
const INTERNET_SUPPRESS_COOKIE_POLICY_RESET = &h02
const PRIVACY_TEMPLATE_NO_COOKIES = 0
const PRIVACY_TEMPLATE_HIGH = 1
const PRIVACY_TEMPLATE_MEDIUM_HIGH = 2
const PRIVACY_TEMPLATE_MEDIUM = 3
const PRIVACY_TEMPLATE_MEDIUM_LOW = 4
const PRIVACY_TEMPLATE_LOW = 5
const PRIVACY_TEMPLATE_CUSTOM = 100
const PRIVACY_TEMPLATE_ADVANCED = 101
const PRIVACY_TEMPLATE_MAX = PRIVACY_TEMPLATE_LOW
const PRIVACY_TYPE_FIRST_PARTY = 0
const PRIVACY_TYPE_THIRD_PARTY = 1
declare function PrivacySetZonePreferenceW(byval dwZone as DWORD, byval dwType as DWORD, byval dwTemplate as DWORD, byval pszPreference as LPCWSTR) as DWORD
declare function PrivacyGetZonePreferenceW(byval dwZone as DWORD, byval dwType as DWORD, byval pdwTemplate as LPDWORD, byval pszBuffer as LPWSTR, byval pdwBufferLength as LPDWORD) as DWORD

end extern
