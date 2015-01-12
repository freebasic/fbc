#pragma once

#include once "_mingw_unicode.bi"

#inclib "wininet"

extern "Windows"

#define _WININET_

type HINTERNET as LPVOID
type LPHINTERNET as HINTERNET ptr
type INTERNET_PORT as WORD
type LPINTERNET_PORT as INTERNET_PORT ptr

#define INTERNET_INVALID_PORT_NUMBER 0
#define INTERNET_DEFAULT_FTP_PORT 21
#define INTERNET_DEFAULT_GOPHER_PORT 70
#define INTERNET_DEFAULT_HTTP_PORT 80
#define INTERNET_DEFAULT_HTTPS_PORT 443
#define INTERNET_DEFAULT_SOCKS_PORT 1080
#define INTERNET_MAX_HOST_NAME_LENGTH 256
#define INTERNET_MAX_USER_NAME_LENGTH 128
#define INTERNET_MAX_PASSWORD_LENGTH 128
#define INTERNET_MAX_PORT_NUMBER_LENGTH 5
#define INTERNET_MAX_PORT_NUMBER_VALUE 65535
#define INTERNET_MAX_PATH_LENGTH 2048
#define INTERNET_MAX_SCHEME_LENGTH 32
#define INTERNET_MAX_URL_LENGTH ((INTERNET_MAX_SCHEME_LENGTH + sizeof("://")) + INTERNET_MAX_PATH_LENGTH)
#define INTERNET_KEEP_ALIVE_UNKNOWN cast(DWORD, -1)
#define INTERNET_KEEP_ALIVE_ENABLED 1
#define INTERNET_KEEP_ALIVE_DISABLED 0
#define INTERNET_REQFLAG_FROM_CACHE &h00000001
#define INTERNET_REQFLAG_ASYNC &h00000002
#define INTERNET_REQFLAG_VIA_PROXY &h00000004
#define INTERNET_REQFLAG_NO_HEADERS &h00000008
#define INTERNET_REQFLAG_PASSIVE &h00000010
#define INTERNET_REQFLAG_CACHE_WRITE_DISABLED &h00000040
#define INTERNET_REQFLAG_NET_TIMEOUT &h00000080
#define INTERNET_FLAG_RELOAD &h80000000
#define INTERNET_FLAG_RAW_DATA &h40000000
#define INTERNET_FLAG_EXISTING_CONNECT &h20000000
#define INTERNET_FLAG_ASYNC &h10000000
#define INTERNET_FLAG_PASSIVE &h08000000
#define INTERNET_FLAG_NO_CACHE_WRITE &h04000000
#define INTERNET_FLAG_DONT_CACHE INTERNET_FLAG_NO_CACHE_WRITE
#define INTERNET_FLAG_MAKE_PERSISTENT &h02000000
#define INTERNET_FLAG_FROM_CACHE &h01000000
#define INTERNET_FLAG_OFFLINE INTERNET_FLAG_FROM_CACHE
#define INTERNET_FLAG_SECURE &h00800000
#define INTERNET_FLAG_KEEP_CONNECTION &h00400000
#define INTERNET_FLAG_NO_AUTO_REDIRECT &h00200000
#define INTERNET_FLAG_READ_PREFETCH &h00100000
#define INTERNET_FLAG_NO_COOKIES &h00080000
#define INTERNET_FLAG_NO_AUTH &h00040000
#define INTERNET_FLAG_RESTRICTED_ZONE &h00020000
#define INTERNET_FLAG_CACHE_IF_NET_FAIL &h00010000
#define INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP &h00008000
#define INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS &h00004000
#define INTERNET_FLAG_IGNORE_CERT_DATE_INVALID &h00002000
#define INTERNET_FLAG_IGNORE_CERT_CN_INVALID &h00001000
#define INTERNET_FLAG_RESYNCHRONIZE &h00000800
#define INTERNET_FLAG_HYPERLINK &h00000400
#define INTERNET_FLAG_NO_UI &h00000200
#define INTERNET_FLAG_PRAGMA_NOCACHE &h00000100
#define INTERNET_FLAG_CACHE_ASYNC &h00000080
#define INTERNET_FLAG_FORMS_SUBMIT &h00000040
#define INTERNET_FLAG_FWD_BACK &h00000020
#define INTERNET_FLAG_NEED_FILE &h00000010
#define INTERNET_FLAG_MUST_CACHE_REQUEST INTERNET_FLAG_NEED_FILE
#define INTERNET_FLAG_TRANSFER_ASCII FTP_TRANSFER_TYPE_ASCII
#define INTERNET_FLAG_TRANSFER_BINARY FTP_TRANSFER_TYPE_BINARY
#define SECURITY_INTERNET_MASK (((INTERNET_FLAG_IGNORE_CERT_CN_INVALID or INTERNET_FLAG_IGNORE_CERT_DATE_INVALID) or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS) or INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP)
#define INTERNET_FLAGS_MASK (((((((((((((((((((((((((((INTERNET_FLAG_RELOAD or INTERNET_FLAG_RAW_DATA) or INTERNET_FLAG_EXISTING_CONNECT) or INTERNET_FLAG_ASYNC) or INTERNET_FLAG_PASSIVE) or INTERNET_FLAG_NO_CACHE_WRITE) or INTERNET_FLAG_MAKE_PERSISTENT) or INTERNET_FLAG_FROM_CACHE) or INTERNET_FLAG_SECURE) or INTERNET_FLAG_KEEP_CONNECTION) or INTERNET_FLAG_NO_AUTO_REDIRECT) or INTERNET_FLAG_READ_PREFETCH) or INTERNET_FLAG_NO_COOKIES) or INTERNET_FLAG_NO_AUTH) or INTERNET_FLAG_CACHE_IF_NET_FAIL) or SECURITY_INTERNET_MASK) or INTERNET_FLAG_RESYNCHRONIZE) or INTERNET_FLAG_HYPERLINK) or INTERNET_FLAG_NO_UI) or INTERNET_FLAG_PRAGMA_NOCACHE) or INTERNET_FLAG_CACHE_ASYNC) or INTERNET_FLAG_FORMS_SUBMIT) or INTERNET_FLAG_NEED_FILE) or INTERNET_FLAG_RESTRICTED_ZONE) or INTERNET_FLAG_TRANSFER_BINARY) or INTERNET_FLAG_TRANSFER_ASCII) or INTERNET_FLAG_FWD_BACK) or INTERNET_FLAG_BGUPDATE)
#define INTERNET_ERROR_MASK_INSERT_CDROM &h1
#define INTERNET_ERROR_MASK_COMBINED_SEC_CERT &h2
#define INTERNET_ERROR_MASK_NEED_MSN_SSPI_PKG &h4
#define INTERNET_ERROR_MASK_LOGIN_FAILURE_DISPLAY_ENTITY_BODY &h8
#define INTERNET_OPTIONS_MASK (not INTERNET_FLAGS_MASK)
#define WININET_API_FLAG_ASYNC &h00000001
#define WININET_API_FLAG_SYNC &h00000004
#define WININET_API_FLAG_USE_CONTEXT &h00000008
#define INTERNET_NO_CALLBACK 0

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

#define IDSI_FLAG_KEEP_ALIVE &h00000001
#define IDSI_FLAG_SECURE &h00000002
#define IDSI_FLAG_PROXY &h00000004
#define IDSI_FLAG_TUNNEL &h00000008

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
	union __INTERNET_PER_CONN_OPTIONA_Value
		dwValue as DWORD
		pszValue as LPSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONA
		dwOption as DWORD
		Value as __INTERNET_PER_CONN_OPTIONA_Value
	end type
#else
	union __INTERNET_PER_CONN_OPTIONA_Value field = 4
		dwValue as DWORD
		pszValue as LPSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONA field = 4
		dwOption as DWORD
		Value as __INTERNET_PER_CONN_OPTIONA_Value
	end type
#endif

type LPINTERNET_PER_CONN_OPTIONA as INTERNET_PER_CONN_OPTIONA ptr

#ifdef __FB_64BIT__
	union __INTERNET_PER_CONN_OPTIONW_Value
		dwValue as DWORD
		pszValue as LPWSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONW
		dwOption as DWORD
		Value as __INTERNET_PER_CONN_OPTIONW_Value
	end type
#else
	union __INTERNET_PER_CONN_OPTIONW_Value field = 4
		dwValue as DWORD
		pszValue as LPWSTR
		ftValue as FILETIME
	end union

	type INTERNET_PER_CONN_OPTIONW field = 4
		dwOption as DWORD
		Value as __INTERNET_PER_CONN_OPTIONW_Value
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

#define INTERNET_PER_CONN_FLAGS 1
#define INTERNET_PER_CONN_PROXY_SERVER 2
#define INTERNET_PER_CONN_PROXY_BYPASS 3
#define INTERNET_PER_CONN_AUTOCONFIG_URL 4
#define INTERNET_PER_CONN_AUTODISCOVERY_FLAGS 5
#define INTERNET_PER_CONN_AUTOCONFIG_SECONDARY_URL 6
#define INTERNET_PER_CONN_AUTOCONFIG_RELOAD_DELAY_MINS 7
#define INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_TIME 8
#define INTERNET_PER_CONN_AUTOCONFIG_LAST_DETECT_URL 9
#define INTERNET_PER_CONN_FLAGS_UI 10
#define PROXY_TYPE_DIRECT &h00000001
#define PROXY_TYPE_PROXY &h00000002
#define PROXY_TYPE_AUTO_PROXY_URL &h00000004
#define PROXY_TYPE_AUTO_DETECT &h00000008
#define AUTO_PROXY_FLAG_USER_SET &h00000001
#define AUTO_PROXY_FLAG_ALWAYS_DETECT &h00000002
#define AUTO_PROXY_FLAG_DETECTION_RUN &h00000004
#define AUTO_PROXY_FLAG_MIGRATED &h00000008
#define AUTO_PROXY_FLAG_DONT_CACHE_PROXY_RESULT &h00000010
#define AUTO_PROXY_FLAG_CACHE_INIT_RUN &h00000020
#define AUTO_PROXY_FLAG_DETECTION_SUSPECT &h00000040

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

#define ISO_FORCE_DISCONNECTED &h00000001

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

	#define InternetTimeFromSystemTime InternetTimeFromSystemTimeW
#else
	type INTERNET_BUFFERS as INTERNET_BUFFERSA
	type LPINTERNET_BUFFERS as LPINTERNET_BUFFERSA

	declare function InternetTimeFromSystemTime(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPSTR, byval cbTime as DWORD) as WINBOOL
#endif

declare function InternetTimeFromSystemTimeA(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPSTR, byval cbTime as DWORD) as WINBOOL
declare function InternetTimeFromSystemTimeW(byval pst as const SYSTEMTIME ptr, byval dwRFC as DWORD, byval lpszTime as LPWSTR, byval cbTime as DWORD) as WINBOOL

#define INTERNET_RFC1123_FORMAT 0
#define INTERNET_RFC1123_BUFSIZE 30

#ifdef UNICODE
	#define InternetCrackUrl InternetCrackUrlW
	#define InternetCreateUrl InternetCreateUrlW
	#define InternetCanonicalizeUrl InternetCanonicalizeUrlW
	#define InternetCombineUrl InternetCombineUrlW
	#define InternetTimeToSystemTime InternetTimeToSystemTimeW
#else
	#define InternetCrackUrl InternetCrackUrlA
	#define InternetCreateUrl InternetCreateUrlA
	#define InternetCanonicalizeUrl InternetCanonicalizeUrlA
	#define InternetCombineUrl InternetCombineUrlA

	declare function InternetTimeToSystemTime(byval lpszTime as LPCSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetTimeToSystemTimeA(byval lpszTime as LPCSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL
declare function InternetTimeToSystemTimeW(byval lpszTime as LPCWSTR, byval pst as SYSTEMTIME ptr, byval dwReserved as DWORD) as WINBOOL
declare function InternetCrackUrlA(byval lpszUrl as LPCSTR, byval dwUrlLength as DWORD, byval dwFlags as DWORD, byval lpUrlComponents as LPURL_COMPONENTSA) as WINBOOL
declare function InternetCrackUrlW(byval lpszUrl as LPCWSTR, byval dwUrlLength as DWORD, byval dwFlags as DWORD, byval lpUrlComponents as LPURL_COMPONENTSW) as WINBOOL
declare function InternetCreateUrlA(byval lpUrlComponents as LPURL_COMPONENTSA, byval dwFlags as DWORD, byval lpszUrl as LPSTR, byval lpdwUrlLength as LPDWORD) as WINBOOL
declare function InternetCreateUrlW(byval lpUrlComponents as LPURL_COMPONENTSW, byval dwFlags as DWORD, byval lpszUrl as LPWSTR, byval lpdwUrlLength as LPDWORD) as WINBOOL
declare function InternetCanonicalizeUrlA(byval lpszUrl as LPCSTR, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
declare function InternetCanonicalizeUrlW(byval lpszUrl as LPCWSTR, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
declare function InternetCombineUrlA(byval lpszBaseUrl as LPCSTR, byval lpszRelativeUrl as LPCSTR, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL
declare function InternetCombineUrlW(byval lpszBaseUrl as LPCWSTR, byval lpszRelativeUrl as LPCWSTR, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD, byval dwFlags as DWORD) as WINBOOL

#define ICU_ESCAPE &h80000000
#define ICU_USERNAME &h40000000
#define ICU_NO_ENCODE &h20000000
#define ICU_DECODE &h10000000
#define ICU_NO_META &h08000000
#define ICU_ENCODE_SPACES_ONLY &h04000000
#define ICU_BROWSER_MODE &h02000000
#define ICU_ENCODE_PERCENT &h00001000

#ifdef UNICODE
	#define InternetOpen InternetOpenW
#else
	#define InternetOpen InternetOpenA
#endif

declare function InternetOpenA(byval lpszAgent as LPCSTR, byval dwAccessType as DWORD, byval lpszProxy as LPCSTR, byval lpszProxyBypass as LPCSTR, byval dwFlags as DWORD) as HINTERNET
declare function InternetOpenW(byval lpszAgent as LPCWSTR, byval dwAccessType as DWORD, byval lpszProxy as LPCWSTR, byval lpszProxyBypass as LPCWSTR, byval dwFlags as DWORD) as HINTERNET

#define INTERNET_OPEN_TYPE_PRECONFIG 0
#define INTERNET_OPEN_TYPE_DIRECT 1
#define INTERNET_OPEN_TYPE_PROXY 3
#define INTERNET_OPEN_TYPE_PRECONFIG_WITH_NO_AUTOPROXY 4
#define PRE_CONFIG_INTERNET_ACCESS INTERNET_OPEN_TYPE_PRECONFIG
#define LOCAL_INTERNET_ACCESS INTERNET_OPEN_TYPE_DIRECT
#define CERN_PROXY_INTERNET_ACCESS INTERNET_OPEN_TYPE_PROXY

#ifdef UNICODE
	#define InternetConnect InternetConnectW
#else
	#define InternetConnect InternetConnectA
#endif

declare function InternetCloseHandle(byval hInternet as HINTERNET) as WINBOOL
declare function InternetConnectA(byval hInternet as HINTERNET, byval lpszServerName as LPCSTR, byval nServerPort as INTERNET_PORT, byval lpszUserName as LPCSTR, byval lpszPassword as LPCSTR, byval dwService as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function InternetConnectW(byval hInternet as HINTERNET, byval lpszServerName as LPCWSTR, byval nServerPort as INTERNET_PORT, byval lpszUserName as LPCWSTR, byval lpszPassword as LPCWSTR, byval dwService as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

#define INTERNET_SERVICE_FTP 1
#define INTERNET_SERVICE_GOPHER 2
#define INTERNET_SERVICE_HTTP 3

#ifdef UNICODE
	#define InternetOpenUrl InternetOpenUrlW
	#define InternetReadFileEx InternetReadFileExW
#else
	#define InternetOpenUrl InternetOpenUrlA
	#define InternetReadFileEx InternetReadFileExA
#endif

declare function InternetOpenUrlA(byval hInternet as HINTERNET, byval lpszUrl as LPCSTR, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function InternetOpenUrlW(byval hInternet as HINTERNET, byval lpszUrl as LPCWSTR, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function InternetReadFile(byval hFile as HINTERNET, byval lpBuffer as LPVOID, byval dwNumberOfBytesToRead as DWORD, byval lpdwNumberOfBytesRead as LPDWORD) as WINBOOL
declare function InternetReadFileExA(byval hFile as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function InternetReadFileExW(byval hFile as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#define IRF_ASYNC WININET_API_FLAG_ASYNC
#define IRF_SYNC WININET_API_FLAG_SYNC
#define IRF_USE_CONTEXT WININET_API_FLAG_USE_CONTEXT
#define IRF_NO_WAIT &h00000008

#ifdef UNICODE
	#define InternetFindNextFile InternetFindNextFileW
	#define InternetQueryOption InternetQueryOptionW
	#define InternetSetOption InternetSetOptionW
	#define InternetSetOptionEx InternetSetOptionExW
#else
	#define InternetFindNextFile InternetFindNextFileA
	#define InternetQueryOption InternetQueryOptionA
	#define InternetSetOption InternetSetOptionA
	#define InternetSetOptionEx InternetSetOptionExA
#endif

declare function InternetSetFilePointer(byval hFile as HINTERNET, byval lDistanceToMove as LONG, byval pReserved as PVOID, byval dwMoveMethod as DWORD, byval dwContext as DWORD_PTR) as DWORD
declare function InternetWriteFile(byval hFile as HINTERNET, byval lpBuffer as LPCVOID, byval dwNumberOfBytesToWrite as DWORD, byval lpdwNumberOfBytesWritten as LPDWORD) as WINBOOL
declare function InternetQueryDataAvailable(byval hFile as HINTERNET, byval lpdwNumberOfBytesAvailable as LPDWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function InternetFindNextFileA(byval hFind as HINTERNET, byval lpvFindData as LPVOID) as WINBOOL
declare function InternetFindNextFileW(byval hFind as HINTERNET, byval lpvFindData as LPVOID) as WINBOOL
declare function InternetQueryOptionA(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as WINBOOL
declare function InternetQueryOptionW(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD) as WINBOOL
declare function InternetSetOptionA(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD) as WINBOOL
declare function InternetSetOptionW(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD) as WINBOOL
declare function InternetSetOptionExA(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwFlags as DWORD) as WINBOOL
declare function InternetSetOptionExW(byval hInternet as HINTERNET, byval dwOption as DWORD, byval lpBuffer as LPVOID, byval dwBufferLength as DWORD, byval dwFlags as DWORD) as WINBOOL
declare function InternetLockRequestFile(byval hInternet as HINTERNET, byval lphLockRequestInfo as HANDLE ptr) as WINBOOL
declare function InternetUnlockRequestFile(byval hLockRequestInfo as HANDLE) as WINBOOL

#define ISO_GLOBAL &h00000001
#define ISO_REGISTRY &h00000002
#define ISO_VALID_FLAGS (ISO_GLOBAL or ISO_REGISTRY)
#define INTERNET_OPTION_CALLBACK 1
#define INTERNET_OPTION_CONNECT_TIMEOUT 2
#define INTERNET_OPTION_CONNECT_RETRIES 3
#define INTERNET_OPTION_CONNECT_BACKOFF 4
#define INTERNET_OPTION_SEND_TIMEOUT 5
#define INTERNET_OPTION_CONTROL_SEND_TIMEOUT INTERNET_OPTION_SEND_TIMEOUT
#define INTERNET_OPTION_RECEIVE_TIMEOUT 6
#define INTERNET_OPTION_CONTROL_RECEIVE_TIMEOUT INTERNET_OPTION_RECEIVE_TIMEOUT
#define INTERNET_OPTION_DATA_SEND_TIMEOUT 7
#define INTERNET_OPTION_DATA_RECEIVE_TIMEOUT 8
#define INTERNET_OPTION_HANDLE_TYPE 9
#define INTERNET_OPTION_LISTEN_TIMEOUT 11
#define INTERNET_OPTION_READ_BUFFER_SIZE 12
#define INTERNET_OPTION_WRITE_BUFFER_SIZE 13
#define INTERNET_OPTION_ASYNC_ID 15
#define INTERNET_OPTION_ASYNC_PRIORITY 16
#define INTERNET_OPTION_PARENT_HANDLE 21
#define INTERNET_OPTION_KEEP_CONNECTION 22
#define INTERNET_OPTION_REQUEST_FLAGS 23
#define INTERNET_OPTION_EXTENDED_ERROR 24
#define INTERNET_OPTION_OFFLINE_MODE 26
#define INTERNET_OPTION_CACHE_STREAM_HANDLE 27
#define INTERNET_OPTION_USERNAME 28
#define INTERNET_OPTION_PASSWORD 29
#define INTERNET_OPTION_ASYNC 30
#define INTERNET_OPTION_SECURITY_FLAGS 31
#define INTERNET_OPTION_SECURITY_CERTIFICATE_STRUCT 32
#define INTERNET_OPTION_DATAFILE_NAME 33
#define INTERNET_OPTION_URL 34
#define INTERNET_OPTION_SECURITY_CERTIFICATE 35
#define INTERNET_OPTION_SECURITY_KEY_BITNESS 36
#define INTERNET_OPTION_REFRESH 37
#define INTERNET_OPTION_PROXY 38
#define INTERNET_OPTION_SETTINGS_CHANGED 39
#define INTERNET_OPTION_VERSION 40
#define INTERNET_OPTION_USER_AGENT 41
#define INTERNET_OPTION_END_BROWSER_SESSION 42
#define INTERNET_OPTION_PROXY_USERNAME 43
#define INTERNET_OPTION_PROXY_PASSWORD 44
#define INTERNET_OPTION_CONTEXT_VALUE 45
#define INTERNET_OPTION_CONNECT_LIMIT 46
#define INTERNET_OPTION_SECURITY_SELECT_CLIENT_CERT 47
#define INTERNET_OPTION_POLICY 48
#define INTERNET_OPTION_DISCONNECTED_TIMEOUT 49
#define INTERNET_OPTION_CONNECTED_STATE 50
#define INTERNET_OPTION_IDLE_STATE 51
#define INTERNET_OPTION_OFFLINE_SEMANTICS 52
#define INTERNET_OPTION_SECONDARY_CACHE_KEY 53
#define INTERNET_OPTION_CALLBACK_FILTER 54
#define INTERNET_OPTION_CONNECT_TIME 55
#define INTERNET_OPTION_SEND_THROUGHPUT 56
#define INTERNET_OPTION_RECEIVE_THROUGHPUT 57
#define INTERNET_OPTION_REQUEST_PRIORITY 58
#define INTERNET_OPTION_HTTP_VERSION 59
#define INTERNET_OPTION_RESET_URLCACHE_SESSION 60
#define INTERNET_OPTION_ERROR_MASK 62
#define INTERNET_OPTION_FROM_CACHE_TIMEOUT 63
#define INTERNET_OPTION_BYPASS_EDITED_ENTRY 64
#define INTERNET_OPTION_DIAGNOSTIC_SOCKET_INFO 67
#define INTERNET_OPTION_CODEPAGE 68
#define INTERNET_OPTION_CACHE_TIMESTAMPS 69
#define INTERNET_OPTION_DISABLE_AUTODIAL 70
#define INTERNET_OPTION_MAX_CONNS_PER_SERVER 73
#define INTERNET_OPTION_MAX_CONNS_PER_1_0_SERVER 74
#define INTERNET_OPTION_PER_CONNECTION_OPTION 75
#define INTERNET_OPTION_DIGEST_AUTH_UNLOAD 76
#define INTERNET_OPTION_IGNORE_OFFLINE 77
#define INTERNET_OPTION_IDENTITY 78
#define INTERNET_OPTION_REMOVE_IDENTITY 79
#define INTERNET_OPTION_ALTER_IDENTITY 80
#define INTERNET_OPTION_SUPPRESS_BEHAVIOR 81
#define INTERNET_OPTION_AUTODIAL_MODE 82
#define INTERNET_OPTION_AUTODIAL_CONNECTION 83
#define INTERNET_OPTION_CLIENT_CERT_CONTEXT 84
#define INTERNET_OPTION_AUTH_FLAGS 85
#define INTERNET_OPTION_COOKIES_3RD_PARTY 86
#define INTERNET_OPTION_DISABLE_PASSPORT_AUTH 87
#define INTERNET_OPTION_SEND_UTF8_SERVERNAME_TO_PROXY 88
#define INTERNET_OPTION_EXEMPT_CONNECTION_LIMIT 89
#define INTERNET_OPTION_ENABLE_PASSPORT_AUTH 90
#define INTERNET_OPTION_HIBERNATE_INACTIVE_WORKER_THREADS 91
#define INTERNET_OPTION_ACTIVATE_WORKER_THREADS 92
#define INTERNET_OPTION_RESTORE_WORKER_THREAD_DEFAULTS 93
#define INTERNET_OPTION_SOCKET_SEND_BUFFER_LENGTH 94
#define INTERNET_OPTION_PROXY_SETTINGS_CHANGED 95
#define INTERNET_OPTION_DATAFILE_EXT 96
#define INTERNET_FIRST_OPTION INTERNET_OPTION_CALLBACK
#define INTERNET_LAST_OPTION INTERNET_OPTION_DATAFILE_EXT
#define INTERNET_PRIORITY_FOREGROUND 1000
#define INTERNET_HANDLE_TYPE_INTERNET 1
#define INTERNET_HANDLE_TYPE_CONNECT_FTP 2
#define INTERNET_HANDLE_TYPE_CONNECT_GOPHER 3
#define INTERNET_HANDLE_TYPE_CONNECT_HTTP 4
#define INTERNET_HANDLE_TYPE_FTP_FIND 5
#define INTERNET_HANDLE_TYPE_FTP_FIND_HTML 6
#define INTERNET_HANDLE_TYPE_FTP_FILE 7
#define INTERNET_HANDLE_TYPE_FTP_FILE_HTML 8
#define INTERNET_HANDLE_TYPE_GOPHER_FIND 9
#define INTERNET_HANDLE_TYPE_GOPHER_FIND_HTML 10
#define INTERNET_HANDLE_TYPE_GOPHER_FILE 11
#define INTERNET_HANDLE_TYPE_GOPHER_FILE_HTML 12
#define INTERNET_HANDLE_TYPE_HTTP_REQUEST 13
#define INTERNET_HANDLE_TYPE_FILE_REQUEST 14
#define AUTH_FLAG_DISABLE_NEGOTIATE &h00000001
#define AUTH_FLAG_ENABLE_NEGOTIATE &h00000002
#define AUTH_FLAG_DISABLE_BASIC_CLEARCHANNEL &h00000004
#define SECURITY_FLAG_SECURE &h00000001
#define SECURITY_FLAG_STRENGTH_WEAK &h10000000
#define SECURITY_FLAG_STRENGTH_MEDIUM &h40000000
#define SECURITY_FLAG_STRENGTH_STRONG &h20000000
#define SECURITY_FLAG_UNKNOWNBIT &h80000000
#define SECURITY_FLAG_FORTEZZA &h08000000
#define SECURITY_FLAG_NORMALBITNESS SECURITY_FLAG_STRENGTH_WEAK
#define SECURITY_FLAG_SSL &h00000002
#define SECURITY_FLAG_SSL3 &h00000004
#define SECURITY_FLAG_PCT &h00000008
#define SECURITY_FLAG_PCT4 &h00000010
#define SECURITY_FLAG_IETFSSL4 &h00000020
#define SECURITY_FLAG_40BIT SECURITY_FLAG_STRENGTH_WEAK
#define SECURITY_FLAG_128BIT SECURITY_FLAG_STRENGTH_STRONG
#define SECURITY_FLAG_56BIT SECURITY_FLAG_STRENGTH_MEDIUM
#define SECURITY_FLAG_IGNORE_REVOCATION &h00000080
#define SECURITY_FLAG_IGNORE_UNKNOWN_CA &h00000100
#define SECURITY_FLAG_IGNORE_WRONG_USAGE &h00000200
#define SECURITY_FLAG_IGNORE_CERT_CN_INVALID INTERNET_FLAG_IGNORE_CERT_CN_INVALID
#define SECURITY_FLAG_IGNORE_CERT_DATE_INVALID INTERNET_FLAG_IGNORE_CERT_DATE_INVALID
#define SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTPS INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTPS
#define SECURITY_FLAG_IGNORE_REDIRECT_TO_HTTP INTERNET_FLAG_IGNORE_REDIRECT_TO_HTTP
#define SECURITY_SET_MASK ((((SECURITY_FLAG_IGNORE_REVOCATION or SECURITY_FLAG_IGNORE_UNKNOWN_CA) or SECURITY_FLAG_IGNORE_CERT_CN_INVALID) or SECURITY_FLAG_IGNORE_CERT_DATE_INVALID) or SECURITY_FLAG_IGNORE_WRONG_USAGE)
#define AUTODIAL_MODE_NEVER 1
#define AUTODIAL_MODE_ALWAYS 2
#define AUTODIAL_MODE_NO_NETWORK_PRESENT 4

#ifdef UNICODE
	#define InternetGetLastResponseInfo InternetGetLastResponseInfoW
#else
	#define InternetGetLastResponseInfo InternetGetLastResponseInfoA
#endif

declare function InternetGetLastResponseInfoA(byval lpdwError as LPDWORD, byval lpszBuffer as LPSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
declare function InternetGetLastResponseInfoW(byval lpdwError as LPDWORD, byval lpszBuffer as LPWSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL

type INTERNET_STATUS_CALLBACK as sub(byval hInternet as HINTERNET, byval dwContext as DWORD_PTR, byval dwInternetStatus as DWORD, byval lpvStatusInformation as LPVOID, byval dwStatusInformationLength as DWORD)
type LPINTERNET_STATUS_CALLBACK as INTERNET_STATUS_CALLBACK ptr

#ifdef UNICODE
	#define InternetSetStatusCallback InternetSetStatusCallbackW
#else
	declare function InternetSetStatusCallback(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK
#endif

declare function InternetSetStatusCallbackA(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK
declare function InternetSetStatusCallbackW(byval hInternet as HINTERNET, byval lpfnInternetCallback as INTERNET_STATUS_CALLBACK) as INTERNET_STATUS_CALLBACK

#define INTERNET_STATUS_RESOLVING_NAME 10
#define INTERNET_STATUS_NAME_RESOLVED 11
#define INTERNET_STATUS_CONNECTING_TO_SERVER 20
#define INTERNET_STATUS_CONNECTED_TO_SERVER 21
#define INTERNET_STATUS_SENDING_REQUEST 30
#define INTERNET_STATUS_REQUEST_SENT 31
#define INTERNET_STATUS_RECEIVING_RESPONSE 40
#define INTERNET_STATUS_RESPONSE_RECEIVED 41
#define INTERNET_STATUS_CTL_RESPONSE_RECEIVED 42
#define INTERNET_STATUS_PREFETCH 43
#define INTERNET_STATUS_CLOSING_CONNECTION 50
#define INTERNET_STATUS_CONNECTION_CLOSED 51
#define INTERNET_STATUS_HANDLE_CREATED 60
#define INTERNET_STATUS_HANDLE_CLOSING 70
#define INTERNET_STATUS_DETECTING_PROXY 80
#define INTERNET_STATUS_REQUEST_COMPLETE 100
#define INTERNET_STATUS_REDIRECT 110
#define INTERNET_STATUS_INTERMEDIATE_RESPONSE 120
#define INTERNET_STATUS_USER_INPUT_REQUIRED 140
#define INTERNET_STATUS_STATE_CHANGE 200
#define INTERNET_STATUS_COOKIE_SENT 320
#define INTERNET_STATUS_COOKIE_RECEIVED 321
#define INTERNET_STATUS_PRIVACY_IMPACTED 324
#define INTERNET_STATUS_P3P_HEADER 325
#define INTERNET_STATUS_P3P_POLICYREF 326
#define INTERNET_STATUS_COOKIE_HISTORY 327
#define INTERNET_STATE_CONNECTED &h00000001
#define INTERNET_STATE_DISCONNECTED &h00000002
#define INTERNET_STATE_DISCONNECTED_BY_USER &h00000010
#define INTERNET_STATE_IDLE &h00000100
#define INTERNET_STATE_BUSY &h00000200

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

#define INTERNET_INVALID_STATUS_CALLBACK cast(INTERNET_STATUS_CALLBACK, cast(INT_PTR, -1))
#define FTP_TRANSFER_TYPE_UNKNOWN &h00000000
#define FTP_TRANSFER_TYPE_ASCII &h00000001
#define FTP_TRANSFER_TYPE_BINARY &h00000002
#define FTP_TRANSFER_TYPE_MASK (FTP_TRANSFER_TYPE_ASCII or FTP_TRANSFER_TYPE_BINARY)

#ifdef UNICODE
	#define FtpFindFirstFile FtpFindFirstFileW
	#define FtpGetFile FtpGetFileW
	#define FtpPutFile FtpPutFileW
	#define FtpDeleteFile FtpDeleteFileW
	#define FtpRenameFile FtpRenameFileW
	#define FtpOpenFile FtpOpenFileW
	#define FtpCreateDirectory FtpCreateDirectoryW
	#define FtpRemoveDirectory FtpRemoveDirectoryW
	#define FtpSetCurrentDirectory FtpSetCurrentDirectoryW
	#define FtpGetCurrentDirectory FtpGetCurrentDirectoryW
	#define FtpCommand FtpCommandW
#else
	#define FtpFindFirstFile FtpFindFirstFileA
	#define FtpGetFile FtpGetFileA
	#define FtpPutFile FtpPutFileA
	#define FtpDeleteFile FtpDeleteFileA
	#define FtpRenameFile FtpRenameFileA
	#define FtpOpenFile FtpOpenFileA
	#define FtpCreateDirectory FtpCreateDirectoryA
	#define FtpRemoveDirectory FtpRemoveDirectoryA
	#define FtpSetCurrentDirectory FtpSetCurrentDirectoryA
	#define FtpGetCurrentDirectory FtpGetCurrentDirectoryA
	#define FtpCommand FtpCommandA
#endif

declare function FtpFindFirstFileA(byval hConnect as HINTERNET, byval lpszSearchFile as LPCSTR, byval lpFindFileData as LPWIN32_FIND_DATAA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function FtpFindFirstFileW(byval hConnect as HINTERNET, byval lpszSearchFile as LPCWSTR, byval lpFindFileData as LPWIN32_FIND_DATAW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function FtpGetFileA(byval hConnect as HINTERNET, byval lpszRemoteFile as LPCSTR, byval lpszNewFile as LPCSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpGetFileW(byval hConnect as HINTERNET, byval lpszRemoteFile as LPCWSTR, byval lpszNewFile as LPCWSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpPutFileA(byval hConnect as HINTERNET, byval lpszLocalFile as LPCSTR, byval lpszNewRemoteFile as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpPutFileW(byval hConnect as HINTERNET, byval lpszLocalFile as LPCWSTR, byval lpszNewRemoteFile as LPCWSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpGetFileEx(byval hFtpSession as HINTERNET, byval lpszRemoteFile as LPCSTR, byval lpszNewFile as LPCWSTR, byval fFailIfExists as WINBOOL, byval dwFlagsAndAttributes as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpPutFileEx(byval hFtpSession as HINTERNET, byval lpszLocalFile as LPCWSTR, byval lpszNewRemoteFile as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function FtpDeleteFileA(byval hConnect as HINTERNET, byval lpszFileName as LPCSTR) as WINBOOL
declare function FtpDeleteFileW(byval hConnect as HINTERNET, byval lpszFileName as LPCWSTR) as WINBOOL
declare function FtpRenameFileA(byval hConnect as HINTERNET, byval lpszExisting as LPCSTR, byval lpszNew as LPCSTR) as WINBOOL
declare function FtpRenameFileW(byval hConnect as HINTERNET, byval lpszExisting as LPCWSTR, byval lpszNew as LPCWSTR) as WINBOOL
declare function FtpOpenFileA(byval hConnect as HINTERNET, byval lpszFileName as LPCSTR, byval dwAccess as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function FtpOpenFileW(byval hConnect as HINTERNET, byval lpszFileName as LPCWSTR, byval dwAccess as DWORD, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function FtpCreateDirectoryA(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL
declare function FtpCreateDirectoryW(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL
declare function FtpRemoveDirectoryA(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL
declare function FtpRemoveDirectoryW(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL
declare function FtpSetCurrentDirectoryA(byval hConnect as HINTERNET, byval lpszDirectory as LPCSTR) as WINBOOL
declare function FtpSetCurrentDirectoryW(byval hConnect as HINTERNET, byval lpszDirectory as LPCWSTR) as WINBOOL
declare function FtpGetCurrentDirectoryA(byval hConnect as HINTERNET, byval lpszCurrentDirectory as LPSTR, byval lpdwCurrentDirectory as LPDWORD) as WINBOOL
declare function FtpGetCurrentDirectoryW(byval hConnect as HINTERNET, byval lpszCurrentDirectory as LPWSTR, byval lpdwCurrentDirectory as LPDWORD) as WINBOOL
declare function FtpCommandA(byval hConnect as HINTERNET, byval fExpectResponse as WINBOOL, byval dwFlags as DWORD, byval lpszCommand as LPCSTR, byval dwContext as DWORD_PTR, byval phFtpCommand as HINTERNET ptr) as WINBOOL
declare function FtpCommandW(byval hConnect as HINTERNET, byval fExpectResponse as WINBOOL, byval dwFlags as DWORD, byval lpszCommand as LPCWSTR, byval dwContext as DWORD_PTR, byval phFtpCommand as HINTERNET ptr) as WINBOOL
declare function FtpGetFileSize(byval hFile as HINTERNET, byval lpdwFileSizeHigh as LPDWORD) as DWORD

#define MAX_GOPHER_DISPLAY_TEXT 128
#define MAX_GOPHER_SELECTOR_TEXT 256
#define MAX_GOPHER_HOST_NAME INTERNET_MAX_HOST_NAME_LENGTH
#define MAX_GOPHER_LOCATOR_LENGTH ((((((((((1 + MAX_GOPHER_DISPLAY_TEXT) + 1) + MAX_GOPHER_SELECTOR_TEXT) + 1) + MAX_GOPHER_HOST_NAME) + 1) + INTERNET_MAX_PORT_NUMBER_LENGTH) + 1) + 1) + 2)

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

#define GOPHER_TYPE_TEXT_FILE &h00000001
#define GOPHER_TYPE_DIRECTORY &h00000002
#define GOPHER_TYPE_CSO &h00000004
#define GOPHER_TYPE_ERROR &h00000008
#define GOPHER_TYPE_MAC_BINHEX &h00000010
#define GOPHER_TYPE_DOS_ARCHIVE &h00000020
#define GOPHER_TYPE_UNIX_UUENCODED &h00000040
#define GOPHER_TYPE_INDEX_SERVER &h00000080
#define GOPHER_TYPE_TELNET &h00000100
#define GOPHER_TYPE_BINARY &h00000200
#define GOPHER_TYPE_REDUNDANT &h00000400
#define GOPHER_TYPE_TN3270 &h00000800
#define GOPHER_TYPE_GIF &h00001000
#define GOPHER_TYPE_IMAGE &h00002000
#define GOPHER_TYPE_BITMAP &h00004000
#define GOPHER_TYPE_MOVIE &h00008000
#define GOPHER_TYPE_SOUND &h00010000
#define GOPHER_TYPE_HTML &h00020000
#define GOPHER_TYPE_PDF &h00040000
#define GOPHER_TYPE_CALENDAR &h00080000
#define GOPHER_TYPE_INLINE &h00100000
#define GOPHER_TYPE_UNKNOWN &h20000000
#define GOPHER_TYPE_ASK &h40000000
#define GOPHER_TYPE_GOPHER_PLUS &h80000000
#define IS_GOPHER_FILE(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_FILE_MASK, TRUE, FALSE))
#define IS_GOPHER_DIRECTORY(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_DIRECTORY, TRUE, FALSE))
#define IS_GOPHER_PHONE_SERVER(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_CSO, TRUE, FALSE))
#define IS_GOPHER_ERROR(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_ERROR, TRUE, FALSE))
#define IS_GOPHER_INDEX_SERVER(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_INDEX_SERVER, TRUE, FALSE))
#define IS_GOPHER_TELNET_SESSION(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_TELNET, TRUE, FALSE))
#define IS_GOPHER_BACKUP_SERVER(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_REDUNDANT, TRUE, FALSE))
#define IS_GOPHER_TN3270_SESSION(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_TN3270, TRUE, FALSE))
#define IS_GOPHER_ASK(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_ASK, TRUE, FALSE))
#define IS_GOPHER_PLUS(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_GOPHER_PLUS, TRUE, FALSE))
#define IS_GOPHER_TYPE_KNOWN(type) cast(WINBOOL, iif((type) and GOPHER_TYPE_UNKNOWN, FALSE, TRUE))
#define GOPHER_TYPE_FILE_MASK (((((((((((((GOPHER_TYPE_TEXT_FILE or GOPHER_TYPE_MAC_BINHEX) or GOPHER_TYPE_DOS_ARCHIVE) or GOPHER_TYPE_UNIX_UUENCODED) or GOPHER_TYPE_BINARY) or GOPHER_TYPE_GIF) or GOPHER_TYPE_IMAGE) or GOPHER_TYPE_BITMAP) or GOPHER_TYPE_MOVIE) or GOPHER_TYPE_SOUND) or GOPHER_TYPE_HTML) or GOPHER_TYPE_PDF) or GOPHER_TYPE_CALENDAR) or GOPHER_TYPE_INLINE)

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
	union __AttributeType
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
		AttributeType as __AttributeType
	end type
#else
	union __AttributeType field = 4
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
		AttributeType as __AttributeType
	end type
#endif

type LPGOPHER_ATTRIBUTE_TYPE as GOPHER_ATTRIBUTE_TYPE ptr

#define MAX_GOPHER_CATEGORY_NAME 128
#define MAX_GOPHER_ATTRIBUTE_NAME 128
#define MIN_GOPHER_ATTRIBUTE_LENGTH 256
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
#define GOPHER_ATTRIBUTE_ID_BASE &habcccc00
#define GOPHER_CATEGORY_ID_ALL (GOPHER_ATTRIBUTE_ID_BASE + 1)
#define GOPHER_CATEGORY_ID_INFO (GOPHER_ATTRIBUTE_ID_BASE + 2)
#define GOPHER_CATEGORY_ID_ADMIN (GOPHER_ATTRIBUTE_ID_BASE + 3)
#define GOPHER_CATEGORY_ID_VIEWS (GOPHER_ATTRIBUTE_ID_BASE + 4)
#define GOPHER_CATEGORY_ID_ABSTRACT (GOPHER_ATTRIBUTE_ID_BASE + 5)
#define GOPHER_CATEGORY_ID_VERONICA (GOPHER_ATTRIBUTE_ID_BASE + 6)
#define GOPHER_CATEGORY_ID_ASK (GOPHER_ATTRIBUTE_ID_BASE + 7)
#define GOPHER_CATEGORY_ID_UNKNOWN (GOPHER_ATTRIBUTE_ID_BASE + 8)
#define GOPHER_ATTRIBUTE_ID_ALL (GOPHER_ATTRIBUTE_ID_BASE + 9)
#define GOPHER_ATTRIBUTE_ID_ADMIN (GOPHER_ATTRIBUTE_ID_BASE + 10)
#define GOPHER_ATTRIBUTE_ID_MOD_DATE (GOPHER_ATTRIBUTE_ID_BASE + 11)
#define GOPHER_ATTRIBUTE_ID_TTL (GOPHER_ATTRIBUTE_ID_BASE + 12)
#define GOPHER_ATTRIBUTE_ID_SCORE (GOPHER_ATTRIBUTE_ID_BASE + 13)
#define GOPHER_ATTRIBUTE_ID_RANGE (GOPHER_ATTRIBUTE_ID_BASE + 14)
#define GOPHER_ATTRIBUTE_ID_SITE (GOPHER_ATTRIBUTE_ID_BASE + 15)
#define GOPHER_ATTRIBUTE_ID_ORG (GOPHER_ATTRIBUTE_ID_BASE + 16)
#define GOPHER_ATTRIBUTE_ID_LOCATION (GOPHER_ATTRIBUTE_ID_BASE + 17)
#define GOPHER_ATTRIBUTE_ID_GEOG (GOPHER_ATTRIBUTE_ID_BASE + 18)
#define GOPHER_ATTRIBUTE_ID_TIMEZONE (GOPHER_ATTRIBUTE_ID_BASE + 19)
#define GOPHER_ATTRIBUTE_ID_PROVIDER (GOPHER_ATTRIBUTE_ID_BASE + 20)
#define GOPHER_ATTRIBUTE_ID_VERSION (GOPHER_ATTRIBUTE_ID_BASE + 21)
#define GOPHER_ATTRIBUTE_ID_ABSTRACT (GOPHER_ATTRIBUTE_ID_BASE + 22)
#define GOPHER_ATTRIBUTE_ID_VIEW (GOPHER_ATTRIBUTE_ID_BASE + 23)
#define GOPHER_ATTRIBUTE_ID_TREEWALK (GOPHER_ATTRIBUTE_ID_BASE + 24)
#define GOPHER_ATTRIBUTE_ID_UNKNOWN (GOPHER_ATTRIBUTE_ID_BASE + 25)

#ifdef UNICODE
	#define GopherCreateLocator GopherCreateLocatorW
	#define GopherGetLocatorType GopherGetLocatorTypeW
	#define GopherFindFirstFile GopherFindFirstFileW
	#define GopherOpenFile GopherOpenFileW
	#define GopherGetAttribute GopherGetAttributeW
#else
	#define GopherCreateLocator GopherCreateLocatorA
	#define GopherGetLocatorType GopherGetLocatorTypeA
	#define GopherFindFirstFile GopherFindFirstFileA
	#define GopherOpenFile GopherOpenFileA
	#define GopherGetAttribute GopherGetAttributeA
#endif

declare function GopherCreateLocatorA(byval lpszHost as LPCSTR, byval nServerPort as INTERNET_PORT, byval lpszDisplayString as LPCSTR, byval lpszSelectorString as LPCSTR, byval dwGopherType as DWORD, byval lpszLocator as LPSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
declare function GopherCreateLocatorW(byval lpszHost as LPCWSTR, byval nServerPort as INTERNET_PORT, byval lpszDisplayString as LPCWSTR, byval lpszSelectorString as LPCWSTR, byval dwGopherType as DWORD, byval lpszLocator as LPWSTR, byval lpdwBufferLength as LPDWORD) as WINBOOL
declare function GopherGetLocatorTypeA(byval lpszLocator as LPCSTR, byval lpdwGopherType as LPDWORD) as WINBOOL
declare function GopherGetLocatorTypeW(byval lpszLocator as LPCWSTR, byval lpdwGopherType as LPDWORD) as WINBOOL
declare function GopherFindFirstFileA(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszSearchString as LPCSTR, byval lpFindData as LPGOPHER_FIND_DATAA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function GopherFindFirstFileW(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszSearchString as LPCWSTR, byval lpFindData as LPGOPHER_FIND_DATAW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function GopherOpenFileA(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszView as LPCSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function GopherOpenFileW(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszView as LPCWSTR, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET

type GOPHER_ATTRIBUTE_ENUMERATOR as function(byval lpAttributeInfo as LPGOPHER_ATTRIBUTE_TYPE, byval dwError as DWORD) as WINBOOL

declare function GopherGetAttributeA(byval hConnect as HINTERNET, byval lpszLocator as LPCSTR, byval lpszAttributeName as LPCSTR, byval lpBuffer as LPBYTE, byval dwBufferLength as DWORD, byval lpdwCharactersReturned as LPDWORD, byval lpfnEnumerator as GOPHER_ATTRIBUTE_ENUMERATOR, byval dwContext as DWORD_PTR) as WINBOOL
declare function GopherGetAttributeW(byval hConnect as HINTERNET, byval lpszLocator as LPCWSTR, byval lpszAttributeName as LPCWSTR, byval lpBuffer as LPBYTE, byval dwBufferLength as DWORD, byval lpdwCharactersReturned as LPDWORD, byval lpfnEnumerator as GOPHER_ATTRIBUTE_ENUMERATOR, byval dwContext as DWORD_PTR) as WINBOOL

#define HTTP_MAJOR_VERSION 1
#define HTTP_MINOR_VERSION 0
#define HTTP_VERSIONA "HTTP/1.0"
#define HTTP_VERSIONW wstr("HTTP/1.0")

#ifdef UNICODE
	#define HTTP_VERSION HTTP_VERSIONW
#else
	#define HTTP_VERSION HTTP_VERSIONA
#endif

#define HTTP_QUERY_MIME_VERSION 0
#define HTTP_QUERY_CONTENT_TYPE 1
#define HTTP_QUERY_CONTENT_TRANSFER_ENCODING 2
#define HTTP_QUERY_CONTENT_ID 3
#define HTTP_QUERY_CONTENT_DESCRIPTION 4
#define HTTP_QUERY_CONTENT_LENGTH 5
#define HTTP_QUERY_CONTENT_LANGUAGE 6
#define HTTP_QUERY_ALLOW 7
#define HTTP_QUERY_PUBLIC 8
#define HTTP_QUERY_DATE 9
#define HTTP_QUERY_EXPIRES 10
#define HTTP_QUERY_LAST_MODIFIED 11
#define HTTP_QUERY_MESSAGE_ID 12
#define HTTP_QUERY_URI 13
#define HTTP_QUERY_DERIVED_FROM 14
#define HTTP_QUERY_COST 15
#define HTTP_QUERY_LINK 16
#define HTTP_QUERY_PRAGMA 17
#define HTTP_QUERY_VERSION 18
#define HTTP_QUERY_STATUS_CODE 19
#define HTTP_QUERY_STATUS_TEXT 20
#define HTTP_QUERY_RAW_HEADERS 21
#define HTTP_QUERY_RAW_HEADERS_CRLF 22
#define HTTP_QUERY_CONNECTION 23
#define HTTP_QUERY_ACCEPT 24
#define HTTP_QUERY_ACCEPT_CHARSET 25
#define HTTP_QUERY_ACCEPT_ENCODING 26
#define HTTP_QUERY_ACCEPT_LANGUAGE 27
#define HTTP_QUERY_AUTHORIZATION 28
#define HTTP_QUERY_CONTENT_ENCODING 29
#define HTTP_QUERY_FORWARDED 30
#define HTTP_QUERY_FROM 31
#define HTTP_QUERY_IF_MODIFIED_SINCE 32
#define HTTP_QUERY_LOCATION 33
#define HTTP_QUERY_ORIG_URI 34
#define HTTP_QUERY_REFERER 35
#define HTTP_QUERY_RETRY_AFTER 36
#define HTTP_QUERY_SERVER 37
#define HTTP_QUERY_TITLE 38
#define HTTP_QUERY_USER_AGENT 39
#define HTTP_QUERY_WWW_AUTHENTICATE 40
#define HTTP_QUERY_PROXY_AUTHENTICATE 41
#define HTTP_QUERY_ACCEPT_RANGES 42
#define HTTP_QUERY_SET_COOKIE 43
#define HTTP_QUERY_COOKIE 44
#define HTTP_QUERY_REQUEST_METHOD 45
#define HTTP_QUERY_REFRESH 46
#define HTTP_QUERY_CONTENT_DISPOSITION 47
#define HTTP_QUERY_AGE 48
#define HTTP_QUERY_CACHE_CONTROL 49
#define HTTP_QUERY_CONTENT_BASE 50
#define HTTP_QUERY_CONTENT_LOCATION 51
#define HTTP_QUERY_CONTENT_MD5 52
#define HTTP_QUERY_CONTENT_RANGE 53
#define HTTP_QUERY_ETAG 54
#define HTTP_QUERY_HOST 55
#define HTTP_QUERY_IF_MATCH 56
#define HTTP_QUERY_IF_NONE_MATCH 57
#define HTTP_QUERY_IF_RANGE 58
#define HTTP_QUERY_IF_UNMODIFIED_SINCE 59
#define HTTP_QUERY_MAX_FORWARDS 60
#define HTTP_QUERY_PROXY_AUTHORIZATION 61
#define HTTP_QUERY_RANGE 62
#define HTTP_QUERY_TRANSFER_ENCODING 63
#define HTTP_QUERY_UPGRADE 64
#define HTTP_QUERY_VARY 65
#define HTTP_QUERY_VIA 66
#define HTTP_QUERY_WARNING 67
#define HTTP_QUERY_EXPECT 68
#define HTTP_QUERY_PROXY_CONNECTION 69
#define HTTP_QUERY_UNLESS_MODIFIED_SINCE 70
#define HTTP_QUERY_ECHO_REQUEST 71
#define HTTP_QUERY_ECHO_REPLY 72
#define HTTP_QUERY_ECHO_HEADERS 73
#define HTTP_QUERY_ECHO_HEADERS_CRLF 74
#define HTTP_QUERY_PROXY_SUPPORT 75
#define HTTP_QUERY_AUTHENTICATION_INFO 76
#define HTTP_QUERY_PASSPORT_URLS 77
#define HTTP_QUERY_PASSPORT_CONFIG 78
#define HTTP_QUERY_MAX 78
#define HTTP_QUERY_CUSTOM 65535
#define HTTP_QUERY_FLAG_REQUEST_HEADERS &h80000000
#define HTTP_QUERY_FLAG_SYSTEMTIME &h40000000
#define HTTP_QUERY_FLAG_NUMBER &h20000000
#define HTTP_QUERY_FLAG_COALESCE &h10000000
#define HTTP_QUERY_MODIFIER_FLAGS_MASK (((HTTP_QUERY_FLAG_REQUEST_HEADERS or HTTP_QUERY_FLAG_SYSTEMTIME) or HTTP_QUERY_FLAG_NUMBER) or HTTP_QUERY_FLAG_COALESCE)
#define HTTP_QUERY_HEADER_MASK (not HTTP_QUERY_MODIFIER_FLAGS_MASK)
#define HTTP_STATUS_CONTINUE 100
#define HTTP_STATUS_SWITCH_PROTOCOLS 101
#define HTTP_STATUS_OK 200
#define HTTP_STATUS_CREATED 201
#define HTTP_STATUS_ACCEPTED 202
#define HTTP_STATUS_PARTIAL 203
#define HTTP_STATUS_NO_CONTENT 204
#define HTTP_STATUS_RESET_CONTENT 205
#define HTTP_STATUS_PARTIAL_CONTENT 206
#define HTTP_STATUS_AMBIGUOUS 300
#define HTTP_STATUS_MOVED 301
#define HTTP_STATUS_REDIRECT 302
#define HTTP_STATUS_REDIRECT_METHOD 303
#define HTTP_STATUS_NOT_MODIFIED 304
#define HTTP_STATUS_USE_PROXY 305
#define HTTP_STATUS_REDIRECT_KEEP_VERB 307
#define HTTP_STATUS_BAD_REQUEST 400
#define HTTP_STATUS_DENIED 401
#define HTTP_STATUS_PAYMENT_REQ 402
#define HTTP_STATUS_FORBIDDEN 403
#define HTTP_STATUS_NOT_FOUND 404
#define HTTP_STATUS_BAD_METHOD 405
#define HTTP_STATUS_NONE_ACCEPTABLE 406
#define HTTP_STATUS_PROXY_AUTH_REQ 407
#define HTTP_STATUS_REQUEST_TIMEOUT 408
#define HTTP_STATUS_CONFLICT 409
#define HTTP_STATUS_GONE 410
#define HTTP_STATUS_LENGTH_REQUIRED 411
#define HTTP_STATUS_PRECOND_FAILED 412
#define HTTP_STATUS_REQUEST_TOO_LARGE 413
#define HTTP_STATUS_URI_TOO_LONG 414
#define HTTP_STATUS_UNSUPPORTED_MEDIA 415
#define HTTP_STATUS_RETRY_WITH 449
#define HTTP_STATUS_SERVER_ERROR 500
#define HTTP_STATUS_NOT_SUPPORTED 501
#define HTTP_STATUS_BAD_GATEWAY 502
#define HTTP_STATUS_SERVICE_UNAVAIL 503
#define HTTP_STATUS_GATEWAY_TIMEOUT 504
#define HTTP_STATUS_VERSION_NOT_SUP 505
#define HTTP_STATUS_FIRST HTTP_STATUS_CONTINUE
#define HTTP_STATUS_LAST HTTP_STATUS_VERSION_NOT_SUP

#ifdef UNICODE
	#define HttpOpenRequest HttpOpenRequestW
	#define HttpAddRequestHeaders HttpAddRequestHeadersW
#else
	#define HttpOpenRequest HttpOpenRequestA
	#define HttpAddRequestHeaders HttpAddRequestHeadersA
#endif

declare function HttpOpenRequestA(byval hConnect as HINTERNET, byval lpszVerb as LPCSTR, byval lpszObjectName as LPCSTR, byval lpszVersion as LPCSTR, byval lpszReferrer as LPCSTR, byval lplpszAcceptTypes as LPCSTR ptr, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function HttpOpenRequestW(byval hConnect as HINTERNET, byval lpszVerb as LPCWSTR, byval lpszObjectName as LPCWSTR, byval lpszVersion as LPCWSTR, byval lpszReferrer as LPCWSTR, byval lplpszAcceptTypes as LPCWSTR ptr, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as HINTERNET
declare function HttpAddRequestHeadersA(byval hRequest as HINTERNET, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval dwModifiers as DWORD) as WINBOOL
declare function HttpAddRequestHeadersW(byval hRequest as HINTERNET, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval dwModifiers as DWORD) as WINBOOL

#define HTTP_ADDREQ_INDEX_MASK &h0000FFFF
#define HTTP_ADDREQ_FLAGS_MASK &hFFFF0000
#define HTTP_ADDREQ_FLAG_ADD_IF_NEW &h10000000
#define HTTP_ADDREQ_FLAG_ADD &h20000000
#define HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA &h40000000
#define HTTP_ADDREQ_FLAG_COALESCE_WITH_SEMICOLON &h01000000
#define HTTP_ADDREQ_FLAG_COALESCE HTTP_ADDREQ_FLAG_COALESCE_WITH_COMMA
#define HTTP_ADDREQ_FLAG_REPLACE &h80000000

#ifdef UNICODE
	#define HttpSendRequest HttpSendRequestW
	#define HttpSendRequestEx HttpSendRequestExW
#else
	#define HttpSendRequest HttpSendRequestA
	#define HttpSendRequestEx HttpSendRequestExA
#endif

declare function HttpSendRequestA(byval hRequest as HINTERNET, byval lpszHeaders as LPCSTR, byval dwHeadersLength as DWORD, byval lpOptional as LPVOID, byval dwOptionalLength as DWORD) as WINBOOL
declare function HttpSendRequestW(byval hRequest as HINTERNET, byval lpszHeaders as LPCWSTR, byval dwHeadersLength as DWORD, byval lpOptional as LPVOID, byval dwOptionalLength as DWORD) as WINBOOL
declare function HttpSendRequestExA(byval hRequest as HINTERNET, byval lpBuffersIn as LPINTERNET_BUFFERSA, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function HttpSendRequestExW(byval hRequest as HINTERNET, byval lpBuffersIn as LPINTERNET_BUFFERSW, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL

#define HSR_ASYNC WININET_API_FLAG_ASYNC
#define HSR_SYNC WININET_API_FLAG_SYNC
#define HSR_USE_CONTEXT WININET_API_FLAG_USE_CONTEXT
#define HSR_INITIATE &h00000008
#define HSR_DOWNLOAD &h00000010
#define HSR_CHUNKED &h00000020

#ifdef UNICODE
	#define HttpEndRequest HttpEndRequestW
	#define HttpQueryInfo HttpQueryInfoW
#else
	#define HttpEndRequest HttpEndRequestA
	#define HttpQueryInfo HttpQueryInfoA
#endif

declare function HttpEndRequestA(byval hRequest as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSA, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function HttpEndRequestW(byval hRequest as HINTERNET, byval lpBuffersOut as LPINTERNET_BUFFERSW, byval dwFlags as DWORD, byval dwContext as DWORD_PTR) as WINBOOL
declare function HttpQueryInfoA(byval hRequest as HINTERNET, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpdwIndex as LPDWORD) as WINBOOL
declare function HttpQueryInfoW(byval hRequest as HINTERNET, byval dwInfoLevel as DWORD, byval lpBuffer as LPVOID, byval lpdwBufferLength as LPDWORD, byval lpdwIndex as LPDWORD) as WINBOOL

#define INTERNET_COOKIE_IS_SECURE &h01
#define INTERNET_COOKIE_IS_SESSION &h02
#define INTERNET_COOKIE_THIRD_PARTY &h10
#define INTERNET_COOKIE_PROMPT_REQUIRED &h20
#define INTERNET_COOKIE_EVALUATE_P3P &h40
#define INTERNET_COOKIE_APPLY_P3P &h80
#define INTERNET_COOKIE_P3P_ENABLED &h100
#define INTERNET_COOKIE_IS_RESTRICTED &h200
#define INTERNET_COOKIE_IE6 &h400
#define INTERNET_COOKIE_IS_LEGACY &h800

#ifdef UNICODE
	#define InternetSetCookie InternetSetCookieW
	#define InternetGetCookie InternetGetCookieW
	#define InternetSetCookieEx InternetSetCookieExW
	#define InternetGetCookieEx InternetGetCookieExW
	#define InternetCheckConnection InternetCheckConnectionW
#else
	#define InternetSetCookie InternetSetCookieA
	#define InternetGetCookie InternetGetCookieA
	#define InternetSetCookieEx InternetSetCookieExA
	#define InternetGetCookieEx InternetGetCookieExA
	#define InternetCheckConnection InternetCheckConnectionA
#endif

declare function InternetSetCookieA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPCSTR) as WINBOOL
declare function InternetSetCookieW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPCWSTR) as WINBOOL
declare function InternetGetCookieA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPSTR, byval lpdwSize as LPDWORD) as WINBOOL
declare function InternetGetCookieW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPWSTR, byval lpdwSize as LPDWORD) as WINBOOL
declare function InternetSetCookieExA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPCSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR) as DWORD
declare function InternetSetCookieExW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD_PTR) as DWORD
declare function InternetGetCookieExA(byval lpszUrl as LPCSTR, byval lpszCookieName as LPCSTR, byval lpszCookieData as LPSTR, byval lpdwSize as LPDWORD, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function InternetGetCookieExW(byval lpszUrl as LPCWSTR, byval lpszCookieName as LPCWSTR, byval lpszCookieData as LPWSTR, byval lpdwSize as LPDWORD, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function InternetAttemptConnect(byval dwReserved as DWORD) as DWORD
declare function InternetCheckConnectionA(byval lpszUrl as LPCSTR, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetCheckConnectionW(byval lpszUrl as LPCWSTR, byval dwFlags as DWORD, byval dwReserved as DWORD) as WINBOOL

#define FLAG_ICC_FORCE_CONNECTION &h00000001
#define FLAGS_ERROR_UI_FILTER_FOR_ERRORS &h01
#define FLAGS_ERROR_UI_FLAGS_CHANGE_OPTIONS &h02
#define FLAGS_ERROR_UI_FLAGS_GENERATE_DATA &h04
#define FLAGS_ERROR_UI_FLAGS_NO_UI &h08
#define FLAGS_ERROR_UI_SERIALIZE_DIALOGS &h10

declare function InternetAuthNotifyCallback cdecl(byval dwContext as DWORD_PTR, byval dwReturn as DWORD, byval lpReserved as LPVOID) as DWORD

type PFN_AUTH_NOTIFY as function(byval as DWORD_PTR, byval as DWORD, byval as LPVOID) as DWORD

#ifdef __FB_64BIT__
	type INTERNET_AUTH_NOTIFY_DATA
		cbStruct as DWORD
		dwOptions as DWORD
		pfnNotify as PFN_AUTH_NOTIFY
		dwContext as DWORD_PTR
	end type
#else
	type INTERNET_AUTH_NOTIFY_DATA field = 4
		cbStruct as DWORD
		dwOptions as DWORD
		pfnNotify as PFN_AUTH_NOTIFY
		dwContext as DWORD_PTR
	end type
#endif

#ifdef UNICODE
	#define InternetConfirmZoneCrossing InternetConfirmZoneCrossingW
#else
	declare function InternetConfirmZoneCrossing(byval hWnd as HWND, byval szUrlPrev as LPSTR, byval szUrlNew as LPSTR, byval bPost as WINBOOL) as DWORD
#endif

declare function ResumeSuspendedDownload(byval hRequest as HINTERNET, byval dwResultCode as DWORD) as WINBOOL
declare function InternetErrorDlg(byval hWnd as HWND, byval hRequest as HINTERNET, byval dwError as DWORD, byval dwFlags as DWORD, byval lppvData as LPVOID ptr) as DWORD
declare function InternetConfirmZoneCrossingA(byval hWnd as HWND, byval szUrlPrev as LPSTR, byval szUrlNew as LPSTR, byval bPost as WINBOOL) as DWORD
declare function InternetConfirmZoneCrossingW(byval hWnd as HWND, byval szUrlPrev as LPWSTR, byval szUrlNew as LPWSTR, byval bPost as WINBOOL) as DWORD

#define INTERNET_ERROR_BASE 12000
#define ERROR_INTERNET_OUT_OF_HANDLES (INTERNET_ERROR_BASE + 1)
#define ERROR_INTERNET_TIMEOUT (INTERNET_ERROR_BASE + 2)
#define ERROR_INTERNET_EXTENDED_ERROR (INTERNET_ERROR_BASE + 3)
#define ERROR_INTERNET_INTERNAL_ERROR (INTERNET_ERROR_BASE + 4)
#define ERROR_INTERNET_INVALID_URL (INTERNET_ERROR_BASE + 5)
#define ERROR_INTERNET_UNRECOGNIZED_SCHEME (INTERNET_ERROR_BASE + 6)
#define ERROR_INTERNET_NAME_NOT_RESOLVED (INTERNET_ERROR_BASE + 7)
#define ERROR_INTERNET_PROTOCOL_NOT_FOUND (INTERNET_ERROR_BASE + 8)
#define ERROR_INTERNET_INVALID_OPTION (INTERNET_ERROR_BASE + 9)
#define ERROR_INTERNET_BAD_OPTION_LENGTH (INTERNET_ERROR_BASE + 10)
#define ERROR_INTERNET_OPTION_NOT_SETTABLE (INTERNET_ERROR_BASE + 11)
#define ERROR_INTERNET_SHUTDOWN (INTERNET_ERROR_BASE + 12)
#define ERROR_INTERNET_INCORRECT_USER_NAME (INTERNET_ERROR_BASE + 13)
#define ERROR_INTERNET_INCORRECT_PASSWORD (INTERNET_ERROR_BASE + 14)
#define ERROR_INTERNET_LOGIN_FAILURE (INTERNET_ERROR_BASE + 15)
#define ERROR_INTERNET_INVALID_OPERATION (INTERNET_ERROR_BASE + 16)
#define ERROR_INTERNET_OPERATION_CANCELLED (INTERNET_ERROR_BASE + 17)
#define ERROR_INTERNET_INCORRECT_HANDLE_TYPE (INTERNET_ERROR_BASE + 18)
#define ERROR_INTERNET_INCORRECT_HANDLE_STATE (INTERNET_ERROR_BASE + 19)
#define ERROR_INTERNET_NOT_PROXY_REQUEST (INTERNET_ERROR_BASE + 20)
#define ERROR_INTERNET_REGISTRY_VALUE_NOT_FOUND (INTERNET_ERROR_BASE + 21)
#define ERROR_INTERNET_BAD_REGISTRY_PARAMETER (INTERNET_ERROR_BASE + 22)
#define ERROR_INTERNET_NO_DIRECT_ACCESS (INTERNET_ERROR_BASE + 23)
#define ERROR_INTERNET_NO_CONTEXT (INTERNET_ERROR_BASE + 24)
#define ERROR_INTERNET_NO_CALLBACK (INTERNET_ERROR_BASE + 25)
#define ERROR_INTERNET_REQUEST_PENDING (INTERNET_ERROR_BASE + 26)
#define ERROR_INTERNET_INCORRECT_FORMAT (INTERNET_ERROR_BASE + 27)
#define ERROR_INTERNET_ITEM_NOT_FOUND (INTERNET_ERROR_BASE + 28)
#define ERROR_INTERNET_CANNOT_CONNECT (INTERNET_ERROR_BASE + 29)
#define ERROR_INTERNET_CONNECTION_ABORTED (INTERNET_ERROR_BASE + 30)
#define ERROR_INTERNET_CONNECTION_RESET (INTERNET_ERROR_BASE + 31)
#define ERROR_INTERNET_FORCE_RETRY (INTERNET_ERROR_BASE + 32)
#define ERROR_INTERNET_INVALID_PROXY_REQUEST (INTERNET_ERROR_BASE + 33)
#define ERROR_INTERNET_NEED_UI (INTERNET_ERROR_BASE + 34)
#define ERROR_INTERNET_HANDLE_EXISTS (INTERNET_ERROR_BASE + 36)
#define ERROR_INTERNET_SEC_CERT_DATE_INVALID (INTERNET_ERROR_BASE + 37)
#define ERROR_INTERNET_SEC_CERT_CN_INVALID (INTERNET_ERROR_BASE + 38)
#define ERROR_INTERNET_HTTP_TO_HTTPS_ON_REDIR (INTERNET_ERROR_BASE + 39)
#define ERROR_INTERNET_HTTPS_TO_HTTP_ON_REDIR (INTERNET_ERROR_BASE + 40)
#define ERROR_INTERNET_MIXED_SECURITY (INTERNET_ERROR_BASE + 41)
#define ERROR_INTERNET_CHG_POST_IS_NON_SECURE (INTERNET_ERROR_BASE + 42)
#define ERROR_INTERNET_POST_IS_NON_SECURE (INTERNET_ERROR_BASE + 43)
#define ERROR_INTERNET_CLIENT_AUTH_CERT_NEEDED (INTERNET_ERROR_BASE + 44)
#define ERROR_INTERNET_INVALID_CA (INTERNET_ERROR_BASE + 45)
#define ERROR_INTERNET_CLIENT_AUTH_NOT_SETUP (INTERNET_ERROR_BASE + 46)
#define ERROR_INTERNET_ASYNC_THREAD_FAILED (INTERNET_ERROR_BASE + 47)
#define ERROR_INTERNET_REDIRECT_SCHEME_CHANGE (INTERNET_ERROR_BASE + 48)
#define ERROR_INTERNET_DIALOG_PENDING (INTERNET_ERROR_BASE + 49)
#define ERROR_INTERNET_RETRY_DIALOG (INTERNET_ERROR_BASE + 50)
#define ERROR_INTERNET_HTTPS_HTTP_SUBMIT_REDIR (INTERNET_ERROR_BASE + 52)
#define ERROR_INTERNET_INSERT_CDROM (INTERNET_ERROR_BASE + 53)
#define ERROR_INTERNET_FORTEZZA_LOGIN_NEEDED (INTERNET_ERROR_BASE + 54)
#define ERROR_INTERNET_SEC_CERT_ERRORS (INTERNET_ERROR_BASE + 55)
#define ERROR_INTERNET_SEC_CERT_NO_REV (INTERNET_ERROR_BASE + 56)
#define ERROR_INTERNET_SEC_CERT_REV_FAILED (INTERNET_ERROR_BASE + 57)
#define ERROR_FTP_TRANSFER_IN_PROGRESS (INTERNET_ERROR_BASE + 110)
#define ERROR_FTP_DROPPED (INTERNET_ERROR_BASE + 111)
#define ERROR_FTP_NO_PASSIVE_MODE (INTERNET_ERROR_BASE + 112)
#define ERROR_GOPHER_PROTOCOL_ERROR (INTERNET_ERROR_BASE + 130)
#define ERROR_GOPHER_NOT_FILE (INTERNET_ERROR_BASE + 131)
#define ERROR_GOPHER_DATA_ERROR (INTERNET_ERROR_BASE + 132)
#define ERROR_GOPHER_END_OF_DATA (INTERNET_ERROR_BASE + 133)
#define ERROR_GOPHER_INVALID_LOCATOR (INTERNET_ERROR_BASE + 134)
#define ERROR_GOPHER_INCORRECT_LOCATOR_TYPE (INTERNET_ERROR_BASE + 135)
#define ERROR_GOPHER_NOT_GOPHER_PLUS (INTERNET_ERROR_BASE + 136)
#define ERROR_GOPHER_ATTRIBUTE_NOT_FOUND (INTERNET_ERROR_BASE + 137)
#define ERROR_GOPHER_UNKNOWN_LOCATOR (INTERNET_ERROR_BASE + 138)
#define ERROR_HTTP_HEADER_NOT_FOUND (INTERNET_ERROR_BASE + 150)
#define ERROR_HTTP_DOWNLEVEL_SERVER (INTERNET_ERROR_BASE + 151)
#define ERROR_HTTP_INVALID_SERVER_RESPONSE (INTERNET_ERROR_BASE + 152)
#define ERROR_HTTP_INVALID_HEADER (INTERNET_ERROR_BASE + 153)
#define ERROR_HTTP_INVALID_QUERY_REQUEST (INTERNET_ERROR_BASE + 154)
#define ERROR_HTTP_HEADER_ALREADY_EXISTS (INTERNET_ERROR_BASE + 155)
#define ERROR_HTTP_REDIRECT_FAILED (INTERNET_ERROR_BASE + 156)
#define ERROR_HTTP_NOT_REDIRECTED (INTERNET_ERROR_BASE + 160)
#define ERROR_HTTP_COOKIE_NEEDS_CONFIRMATION (INTERNET_ERROR_BASE + 161)
#define ERROR_HTTP_COOKIE_DECLINED (INTERNET_ERROR_BASE + 162)
#define ERROR_HTTP_REDIRECT_NEEDS_CONFIRMATION (INTERNET_ERROR_BASE + 168)
#define ERROR_INTERNET_SECURITY_CHANNEL_ERROR (INTERNET_ERROR_BASE + 157)
#define ERROR_INTERNET_UNABLE_TO_CACHE_FILE (INTERNET_ERROR_BASE + 158)
#define ERROR_INTERNET_TCPIP_NOT_INSTALLED (INTERNET_ERROR_BASE + 159)
#define ERROR_INTERNET_DISCONNECTED (INTERNET_ERROR_BASE + 163)
#define ERROR_INTERNET_SERVER_UNREACHABLE (INTERNET_ERROR_BASE + 164)
#define ERROR_INTERNET_PROXY_SERVER_UNREACHABLE (INTERNET_ERROR_BASE + 165)
#define ERROR_INTERNET_BAD_AUTO_PROXY_SCRIPT (INTERNET_ERROR_BASE + 166)
#define ERROR_INTERNET_UNABLE_TO_DOWNLOAD_SCRIPT (INTERNET_ERROR_BASE + 167)
#define ERROR_INTERNET_SEC_INVALID_CERT (INTERNET_ERROR_BASE + 169)
#define ERROR_INTERNET_SEC_CERT_REVOKED (INTERNET_ERROR_BASE + 170)
#define ERROR_INTERNET_FAILED_DUETOSECURITYCHECK (INTERNET_ERROR_BASE + 171)
#define ERROR_INTERNET_NOT_INITIALIZED (INTERNET_ERROR_BASE + 172)
#define ERROR_INTERNET_NEED_MSN_SSPI_PKG (INTERNET_ERROR_BASE + 173)
#define ERROR_INTERNET_LOGIN_FAILURE_DISPLAY_ENTITY_BODY (INTERNET_ERROR_BASE + 174)
#define INTERNET_ERROR_LAST ERROR_INTERNET_LOGIN_FAILURE_DISPLAY_ENTITY_BODY
#define NORMAL_CACHE_ENTRY &h00000001
#define STICKY_CACHE_ENTRY &h00000004
#define EDITED_CACHE_ENTRY &h00000008
#define TRACK_OFFLINE_CACHE_ENTRY &h00000010
#define TRACK_ONLINE_CACHE_ENTRY &h00000020
#define SPARSE_CACHE_ENTRY &h00010000
#define COOKIE_CACHE_ENTRY &h00100000
#define URLHISTORY_CACHE_ENTRY &h00200000
#define URLCACHE_FIND_DEFAULT_FILTER (((((NORMAL_CACHE_ENTRY or COOKIE_CACHE_ENTRY) or URLHISTORY_CACHE_ENTRY) or TRACK_OFFLINE_CACHE_ENTRY) or TRACK_ONLINE_CACHE_ENTRY) or STICKY_CACHE_ENTRY)

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

#define CACHEGROUP_ATTRIBUTE_GET_ALL &hffffffff
#define CACHEGROUP_ATTRIBUTE_BASIC &h00000001
#define CACHEGROUP_ATTRIBUTE_FLAG &h00000002
#define CACHEGROUP_ATTRIBUTE_TYPE &h00000004
#define CACHEGROUP_ATTRIBUTE_QUOTA &h00000008
#define CACHEGROUP_ATTRIBUTE_GROUPNAME &h00000010
#define CACHEGROUP_ATTRIBUTE_STORAGE &h00000020
#define CACHEGROUP_FLAG_NONPURGEABLE &h00000001
#define CACHEGROUP_FLAG_GIDONLY &h00000004
#define CACHEGROUP_FLAG_FLUSHURL_ONDELETE &h00000002
#define CACHEGROUP_SEARCH_ALL &h00000000
#define CACHEGROUP_SEARCH_BYURL &h00000001
#define CACHEGROUP_TYPE_INVALID &h00000001
#define CACHEGROUP_READWRITE_MASK (((CACHEGROUP_ATTRIBUTE_TYPE or CACHEGROUP_ATTRIBUTE_QUOTA) or CACHEGROUP_ATTRIBUTE_GROUPNAME) or CACHEGROUP_ATTRIBUTE_STORAGE)
#define GROUPNAME_MAX_LENGTH 120
#define GROUP_OWNER_STORAGE_SIZE 4

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

	#define CreateUrlCacheEntry CreateUrlCacheEntryW
	#define CommitUrlCacheEntry CommitUrlCacheEntryW
	#define RetrieveUrlCacheEntryFile RetrieveUrlCacheEntryFileW
	#define UnlockUrlCacheEntryFile UnlockUrlCacheEntryFileW
	#define RetrieveUrlCacheEntryStream RetrieveUrlCacheEntryStreamW
	#define GetUrlCacheEntryInfo GetUrlCacheEntryInfoW
	#define GetUrlCacheGroupAttribute GetUrlCacheGroupAttributeW
	#define SetUrlCacheGroupAttribute SetUrlCacheGroupAttributeW
	#define GetUrlCacheEntryInfoEx GetUrlCacheEntryInfoExW
#else
	type INTERNET_CACHE_GROUP_INFO as INTERNET_CACHE_GROUP_INFOA
	type LPINTERNET_CACHE_GROUP_INFO as LPINTERNET_CACHE_GROUP_INFOA

	#define CreateUrlCacheEntry CreateUrlCacheEntryA
	#define CommitUrlCacheEntry CommitUrlCacheEntryA
	#define RetrieveUrlCacheEntryFile RetrieveUrlCacheEntryFileA
	#define UnlockUrlCacheEntryFile UnlockUrlCacheEntryFileA
	#define RetrieveUrlCacheEntryStream RetrieveUrlCacheEntryStreamA
	#define GetUrlCacheEntryInfo GetUrlCacheEntryInfoA
	#define GetUrlCacheGroupAttribute GetUrlCacheGroupAttributeA
	#define SetUrlCacheGroupAttribute SetUrlCacheGroupAttributeA
	#define GetUrlCacheEntryInfoEx GetUrlCacheEntryInfoExA
#endif

declare function CreateUrlCacheEntryA(byval lpszUrlName as LPCSTR, byval dwExpectedFileSize as DWORD, byval lpszFileExtension as LPCSTR, byval lpszFileName as LPSTR, byval dwReserved as DWORD) as WINBOOL
declare function CreateUrlCacheEntryW(byval lpszUrlName as LPCWSTR, byval dwExpectedFileSize as DWORD, byval lpszFileExtension as LPCWSTR, byval lpszFileName as LPWSTR, byval dwReserved as DWORD) as WINBOOL
declare function CommitUrlCacheEntryA(byval lpszUrlName as LPCSTR, byval lpszLocalFileName as LPCSTR, byval ExpireTime as FILETIME, byval LastModifiedTime as FILETIME, byval CacheEntryType as DWORD, byval lpHeaderInfo as LPBYTE, byval dwHeaderSize as DWORD, byval lpszFileExtension as LPCSTR, byval lpszOriginalUrl as LPCSTR) as WINBOOL
declare function CommitUrlCacheEntryW(byval lpszUrlName as LPCWSTR, byval lpszLocalFileName as LPCWSTR, byval ExpireTime as FILETIME, byval LastModifiedTime as FILETIME, byval CacheEntryType as DWORD, byval lpszHeaderInfo as LPWSTR, byval dwHeaders as DWORD, byval lpszFileExtension as LPCWSTR, byval lpszOriginalUrl as LPCWSTR) as WINBOOL
declare function RetrieveUrlCacheEntryFileA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval dwReserved as DWORD) as WINBOOL
declare function RetrieveUrlCacheEntryFileW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval dwReserved as DWORD) as WINBOOL
declare function UnlockUrlCacheEntryFileA(byval lpszUrlName as LPCSTR, byval dwReserved as DWORD) as WINBOOL
declare function UnlockUrlCacheEntryFileW(byval lpszUrlName as LPCWSTR, byval dwReserved as DWORD) as WINBOOL
declare function RetrieveUrlCacheEntryStreamA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval fRandomRead as WINBOOL, byval dwReserved as DWORD) as HANDLE
declare function RetrieveUrlCacheEntryStreamW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval fRandomRead as WINBOOL, byval dwReserved as DWORD) as HANDLE
declare function ReadUrlCacheEntryStream(byval hUrlCacheStream as HANDLE, byval dwLocation as DWORD, byval lpBuffer as LPVOID, byval lpdwLen as LPDWORD, byval Reserved as DWORD) as WINBOOL
declare function UnlockUrlCacheEntryStream(byval hUrlCacheStream as HANDLE, byval Reserved as DWORD) as WINBOOL
declare function GetUrlCacheEntryInfoA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
declare function GetUrlCacheEntryInfoW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
declare function FindFirstUrlCacheGroup(byval dwFlags as DWORD, byval dwFilter as DWORD, byval lpSearchCondition as LPVOID, byval dwSearchCondition as DWORD, byval lpGroupId as GROUPID ptr, byval lpReserved as LPVOID) as HANDLE
declare function FindNextUrlCacheGroup(byval hFind as HANDLE, byval lpGroupId as GROUPID ptr, byval lpReserved as LPVOID) as WINBOOL
declare function GetUrlCacheGroupAttributeA(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOA, byval lpdwGroupInfo as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
declare function GetUrlCacheGroupAttributeW(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOW, byval lpdwGroupInfo as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
declare function SetUrlCacheGroupAttributeA(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOA, byval lpReserved as LPVOID) as WINBOOL
declare function SetUrlCacheGroupAttributeW(byval gid as GROUPID, byval dwFlags as DWORD, byval dwAttributes as DWORD, byval lpGroupInfo as LPINTERNET_CACHE_GROUP_INFOW, byval lpReserved as LPVOID) as WINBOOL
declare function CreateUrlCacheGroup(byval dwFlags as DWORD, byval lpReserved as LPVOID) as GROUPID
declare function DeleteUrlCacheGroup(byval GroupId as GROUPID, byval dwFlags as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function GetUrlCacheEntryInfoExA(byval lpszUrl as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD, byval lpszRedirectUrl as LPSTR, byval lpcbRedirectUrl as LPDWORD, byval lpReserved as LPVOID, byval dwFlags as DWORD) as WINBOOL
declare function GetUrlCacheEntryInfoExW(byval lpszUrl as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD, byval lpszRedirectUrl as LPWSTR, byval lpcbRedirectUrl as LPDWORD, byval lpReserved as LPVOID, byval dwFlags as DWORD) as WINBOOL

#define CACHE_ENTRY_ATTRIBUTE_FC &h00000004
#define CACHE_ENTRY_HITRATE_FC &h00000010
#define CACHE_ENTRY_MODTIME_FC &h00000040
#define CACHE_ENTRY_EXPTIME_FC &h00000080
#define CACHE_ENTRY_ACCTIME_FC &h00000100
#define CACHE_ENTRY_SYNCTIME_FC &h00000200
#define CACHE_ENTRY_HEADERINFO_FC &h00000400
#define CACHE_ENTRY_EXEMPT_DELTA_FC &h00000800

#ifdef UNICODE
	#define SetUrlCacheEntryInfo SetUrlCacheEntryInfoW
	#define FindFirstUrlCacheEntryEx FindFirstUrlCacheEntryExW
	#define FindNextUrlCacheEntryEx FindNextUrlCacheEntryExW
	#define FindFirstUrlCacheEntry FindFirstUrlCacheEntryW
	#define FindNextUrlCacheEntry FindNextUrlCacheEntryW
	#define InternetDial InternetDialW
	#define InternetGoOnline InternetGoOnlineW
	#define DeleteUrlCacheEntry DeleteUrlCacheEntryW
	#define SetUrlCacheEntryGroup SetUrlCacheEntryGroupW
#else
	#define SetUrlCacheEntryInfo SetUrlCacheEntryInfoA
	#define FindFirstUrlCacheEntryEx FindFirstUrlCacheEntryExA
	#define FindNextUrlCacheEntryEx FindNextUrlCacheEntryExA
	#define FindFirstUrlCacheEntry FindFirstUrlCacheEntryA
	#define FindNextUrlCacheEntry FindNextUrlCacheEntryA

	declare function SetUrlCacheEntryGroup(byval lpszUrlName as LPCSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL
	declare function DeleteUrlCacheEntry(byval lpszUrlName as LPCSTR) as WINBOOL
	declare function InternetDial(byval hwndParent as HWND, byval lpszConnectoid as LPSTR, byval dwFlags as DWORD, byval lpdwConnection as LPDWORD, byval dwReserved as DWORD) as DWORD
	declare function InternetGoOnline(byval lpszURL as LPSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL
#endif

declare function SetUrlCacheEntryInfoA(byval lpszUrlName as LPCSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval dwFieldControl as DWORD) as WINBOOL
declare function SetUrlCacheEntryInfoW(byval lpszUrlName as LPCWSTR, byval lpCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval dwFieldControl as DWORD) as WINBOOL

#define INTERNET_CACHE_GROUP_ADD 0
#define INTERNET_CACHE_GROUP_REMOVE 1

declare function SetUrlCacheEntryGroupA(byval lpszUrlName as LPCSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function SetUrlCacheEntryGroupW(byval lpszUrlName as LPCWSTR, byval dwFlags as DWORD, byval GroupId as GROUPID, byval pbGroupAttributes as LPBYTE, byval cbGroupAttributes as DWORD, byval lpReserved as LPVOID) as WINBOOL
declare function FindFirstUrlCacheEntryExA(byval lpszUrlSearchPattern as LPCSTR, byval dwFlags as DWORD, byval dwFilter as DWORD, byval GroupId as GROUPID, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as HANDLE
declare function FindFirstUrlCacheEntryExW(byval lpszUrlSearchPattern as LPCWSTR, byval dwFlags as DWORD, byval dwFilter as DWORD, byval GroupId as GROUPID, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as HANDLE
declare function FindNextUrlCacheEntryExA(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
declare function FindNextUrlCacheEntryExW(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbEntryInfo as LPDWORD, byval lpGroupAttributes as LPVOID, byval lpcbGroupAttributes as LPDWORD, byval lpReserved as LPVOID) as WINBOOL
declare function FindFirstUrlCacheEntryA(byval lpszUrlSearchPattern as LPCSTR, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as HANDLE
declare function FindFirstUrlCacheEntryW(byval lpszUrlSearchPattern as LPCWSTR, byval lpFirstCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as HANDLE
declare function FindNextUrlCacheEntryA(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOA, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
declare function FindNextUrlCacheEntryW(byval hEnumHandle as HANDLE, byval lpNextCacheEntryInfo as LPINTERNET_CACHE_ENTRY_INFOW, byval lpcbCacheEntryInfo as LPDWORD) as WINBOOL
declare function FindCloseUrlCache(byval hEnumHandle as HANDLE) as WINBOOL
declare function DeleteUrlCacheEntryA(byval lpszUrlName as LPCSTR) as WINBOOL
declare function DeleteUrlCacheEntryW(byval lpszUrlName as LPCWSTR) as WINBOOL
declare function InternetDialA(byval hwndParent as HWND, byval lpszConnectoid as LPSTR, byval dwFlags as DWORD, byval lpdwConnection as DWORD_PTR ptr, byval dwReserved as DWORD) as DWORD
declare function InternetDialW(byval hwndParent as HWND, byval lpszConnectoid as LPWSTR, byval dwFlags as DWORD, byval lpdwConnection as DWORD_PTR ptr, byval dwReserved as DWORD) as DWORD

#define INTERNET_DIAL_FORCE_PROMPT &h2000
#define INTERNET_DIAL_SHOW_OFFLINE &h4000
#define INTERNET_DIAL_UNATTENDED &h8000

declare function InternetHangUp(byval dwConnection as DWORD_PTR, byval dwReserved as DWORD) as DWORD

#define INTERENT_GOONLINE_REFRESH &h00000001
#define INTERENT_GOONLINE_MASK &h00000001

declare function InternetGoOnlineA(byval lpszURL as LPSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL
declare function InternetGoOnlineW(byval lpszURL as LPWSTR, byval hwndParent as HWND, byval dwFlags as DWORD) as WINBOOL
declare function InternetAutodial(byval dwFlags as DWORD, byval hwndParent as HWND) as WINBOOL

#define INTERNET_AUTODIAL_FORCE_ONLINE 1
#define INTERNET_AUTODIAL_FORCE_UNATTENDED 2
#define INTERNET_AUTODIAL_FAILIFSECURITYCHECK 4
#define INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT 8
#define INTERNET_AUTODIAL_FLAGS_MASK (((INTERNET_AUTODIAL_FORCE_ONLINE or INTERNET_AUTODIAL_FORCE_UNATTENDED) or INTERNET_AUTODIAL_FAILIFSECURITYCHECK) or INTERNET_AUTODIAL_OVERRIDE_NET_PRESENT)

declare function InternetAutodialHangup(byval dwReserved as DWORD) as WINBOOL
declare function InternetGetConnectedState(byval lpdwFlags as LPDWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetGetConnectedStateExA(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPSTR, byval dwBufLen as DWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetGetConnectedStateExW(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPWSTR, byval dwBufLen as DWORD, byval dwReserved as DWORD) as WINBOOL

#define PROXY_AUTO_DETECT_TYPE_DHCP 1
#define PROXY_AUTO_DETECT_TYPE_DNS_A 2

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
	#define InternetGetConnectedStateEx InternetGetConnectedStateExW
#else
	declare function InternetGetConnectedStateEx(byval lpdwFlags as LPDWORD, byval lpszConnectionName as LPSTR, byval dwNameLen as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetInitializeAutoProxyDll(byval dwReserved as DWORD) as WINBOOL
declare function InternetDeInitializeAutoProxyDll(byval lpszMime as LPSTR, byval dwReserved as DWORD) as WINBOOL
declare function InternetGetProxyInfo(byval lpszUrl as LPCSTR, byval dwUrlLength as DWORD, byval lpszUrlHostName as LPSTR, byval dwUrlHostNameLength as DWORD, byval lplpszProxyHostName as LPSTR ptr, byval lpdwProxyHostNameLength as LPDWORD) as WINBOOL
declare function DetectAutoProxyUrl(byval lpszAutoProxyUrl as LPSTR, byval dwAutoProxyUrlLength as DWORD, byval dwDetectFlags as DWORD) as WINBOOL
declare function CreateMD5SSOHash(byval pszChallengeInfo as PWSTR, byval pwszRealm as PWSTR, byval pwszTarget as PWSTR, byval pbHexHash as PBYTE) as WINBOOL

#define INTERNET_CONNECTION_MODEM &h01
#define INTERNET_CONNECTION_LAN &h02
#define INTERNET_CONNECTION_PROXY &h04
#define INTERNET_CONNECTION_MODEM_BUSY &h08
#define INTERNET_RAS_INSTALLED &h10
#define INTERNET_CONNECTION_OFFLINE &h20
#define INTERNET_CONNECTION_CONFIGURED &h40

type PFN_DIAL_HANDLER as function(byval as HWND, byval as LPCSTR, byval as DWORD, byval as LPDWORD) as DWORD

#define INTERNET_CUSTOMDIAL_CONNECT 0
#define INTERNET_CUSTOMDIAL_UNATTENDED 1
#define INTERNET_CUSTOMDIAL_DISCONNECT 2
#define INTERNET_CUSTOMDIAL_SHOWOFFLINE 4
#define INTERNET_CUSTOMDIAL_SAFE_FOR_UNATTENDED 1
#define INTERNET_CUSTOMDIAL_WILL_SUPPLY_STATE 2
#define INTERNET_CUSTOMDIAL_CAN_HANGUP 4

#ifdef UNICODE
	#define InternetSetPerSiteCookieDecision InternetSetPerSiteCookieDecisionW
	#define InternetGetPerSiteCookieDecision InternetGetPerSiteCookieDecisionW
	#define InternetEnumPerSiteCookieDecision InternetEnumPerSiteCookieDecisionW
	#define InternetSetDialState InternetSetDialStateW
#else
	#define InternetSetPerSiteCookieDecision InternetSetPerSiteCookieDecisionA
	#define InternetGetPerSiteCookieDecision InternetGetPerSiteCookieDecisionA
	#define InternetEnumPerSiteCookieDecision InternetEnumPerSiteCookieDecisionA

	declare function InternetSetDialState(byval lpszConnectoid as LPCSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL
#endif

declare function InternetSetDialStateA(byval lpszConnectoid as LPCSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL
declare function InternetSetDialStateW(byval lpszConnectoid as LPCWSTR, byval dwState as DWORD, byval dwReserved as DWORD) as WINBOOL

#define INTERNET_DIALSTATE_DISCONNECTED 1

declare function InternetSetPerSiteCookieDecisionA(byval pchHostName as LPCSTR, byval dwDecision as DWORD) as WINBOOL
declare function InternetSetPerSiteCookieDecisionW(byval pchHostName as LPCWSTR, byval dwDecision as DWORD) as WINBOOL
declare function InternetGetPerSiteCookieDecisionA(byval pchHostName as LPCSTR, byval pResult as ulong ptr) as WINBOOL
declare function InternetGetPerSiteCookieDecisionW(byval pchHostName as LPCWSTR, byval pResult as ulong ptr) as WINBOOL
declare function InternetClearAllPerSiteCookieDecisions() as WINBOOL
declare function InternetEnumPerSiteCookieDecisionA(byval pszSiteName as LPSTR, byval pcSiteNameSize as ulong ptr, byval pdwDecision as ulong ptr, byval dwIndex as ulong) as WINBOOL
declare function InternetEnumPerSiteCookieDecisionW(byval pszSiteName as LPWSTR, byval pcSiteNameSize as ulong ptr, byval pdwDecision as ulong ptr, byval dwIndex as ulong) as WINBOOL

#define INTERNET_IDENTITY_FLAG_PRIVATE_CACHE &h01
#define INTERNET_IDENTITY_FLAG_SHARED_CACHE &h02
#define INTERNET_IDENTITY_FLAG_CLEAR_DATA &h04
#define INTERNET_IDENTITY_FLAG_CLEAR_COOKIES &h08
#define INTERNET_IDENTITY_FLAG_CLEAR_HISTORY &h10
#define INTERNET_IDENTITY_FLAG_CLEAR_CONTENT &h20
#define INTERNET_SUPPRESS_RESET_ALL &h00
#define INTERNET_SUPPRESS_COOKIE_POLICY &h01
#define INTERNET_SUPPRESS_COOKIE_POLICY_RESET &h02
#define PRIVACY_TEMPLATE_NO_COOKIES 0
#define PRIVACY_TEMPLATE_HIGH 1
#define PRIVACY_TEMPLATE_MEDIUM_HIGH 2
#define PRIVACY_TEMPLATE_MEDIUM 3
#define PRIVACY_TEMPLATE_MEDIUM_LOW 4
#define PRIVACY_TEMPLATE_LOW 5
#define PRIVACY_TEMPLATE_CUSTOM 100
#define PRIVACY_TEMPLATE_ADVANCED 101
#define PRIVACY_TEMPLATE_MAX PRIVACY_TEMPLATE_LOW
#define PRIVACY_TYPE_FIRST_PARTY 0
#define PRIVACY_TYPE_THIRD_PARTY 1

declare function PrivacySetZonePreferenceW(byval dwZone as DWORD, byval dwType as DWORD, byval dwTemplate as DWORD, byval pszPreference as LPCWSTR) as DWORD
declare function PrivacyGetZonePreferenceW(byval dwZone as DWORD, byval dwType as DWORD, byval pdwTemplate as LPDWORD, byval pszBuffer as LPWSTR, byval pdwBufferLength as LPDWORD) as DWORD

end extern
