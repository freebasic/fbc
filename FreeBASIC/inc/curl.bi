''
''
'' curl -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __curl_bi__
#define __curl_bi__

#inclib "curl"

'' begin include curlver.bi
#define LIBCURL_VERSION "7.15.4"
#define LIBCURL_VERSION_MAJOR 7
#define LIBCURL_VERSION_MINOR 15
#define LIBCURL_VERSION_PATCH 4
#define LIBCURL_VERSION_NUM &h070f04

#include once "crt/stdio.bi"
#include once "crt/limits.bi"
#include once "crt/sys/types.bi"
#include once "crt/time.bi"

type CURL as any
type curl_off_t as off_t

#define _FILE_OFFSET_BITS 0
#define FILESIZEBITS 0

#define CURL_FORMAT_OFF_T "%ld"

type curl_slist_ as curl_slist

type curl_httppost
	next as curl_httppost ptr
	name as zstring ptr
	namelength as integer
	contents as zstring ptr
	contentslength as integer
	buffer as zstring ptr
	bufferlength as integer
	contenttype as zstring ptr
	contentheader as curl_slist_ ptr
	more as curl_httppost ptr
	flags as integer
	HTTPPOST_FILENAME as integer
	HTTPPOST_READFILE as integer
	HTTPPOST_PTRNAME as integer
	HTTPPOST_PTRCONTENTS as integer
	HTTPPOST_BUFFER as integer
	HTTPPOST_PTRBUFFER as integer
	showfilename as zstring ptr
end type

#define HTTPPOST_FILENAME (1 shl 0)
#define HTTPPOST_READFILE (1 shl 1)
#define HTTPPOST_PTRNAME (1 shl 2)
#define HTTPPOST_PTRCONTENTS (1 shl 3)
#define HTTPPOST_BUFFER (1 shl 4)
#define HTTPPOST_PTRBUFFER (1 shl 5)

type curl_progress_callback as function cdecl(byval as any ptr, byval as double, byval as double, byval as double, byval as double) as integer

#define CURL_MAX_WRITE_SIZE 16384

type curl_write_callback as function cdecl(byval as zstring ptr, byval as size_t, byval as size_t, byval as any ptr) as size_t

#define CURL_READFUNC_ABORT &h10000000

type curl_read_callback as function cdecl(byval as zstring ptr, byval as size_t, byval as size_t, byval as any ptr) as size_t
type curl_passwd_callback as function cdecl(byval as any ptr, byval as zstring ptr, byval as zstring ptr, byval as integer) as integer

enum curlioerr
	CURLIOE_OK
	CURLIOE_UNKNOWNCMD
	CURLIOE_FAILRESTART
	CURLIOE_LAST
end enum


enum curliocmd
	CURLIOCMD_NOP
	CURLIOCMD_RESTARTREAD
	CURLIOCMD_LAST
end enum

type curl_ioctl_callback as function cdecl(byval as CURL ptr, byval as integer, byval as any ptr) as curlioerr
type curl_malloc_callback as sub cdecl(byval as size_t)
type curl_free_callback as sub cdecl(byval as any ptr)
type curl_realloc_callback as sub cdecl(byval as any ptr, byval as size_t)
type curl_strdup_callback as function cdecl(byval as zstring ptr) as byte ptr
type curl_calloc_callback as sub cdecl(byval as size_t, byval as size_t)

enum curl_infotype
	CURLINFO_TEXT = 0
	CURLINFO_HEADER_IN
	CURLINFO_HEADER_OUT
	CURLINFO_DATA_IN
	CURLINFO_DATA_OUT
	CURLINFO_SSL_DATA_IN
	CURLINFO_SSL_DATA_OUT
	CURLINFO_END
end enum

type curl_debug_callback as function cdecl(byval as CURL ptr, byval as curl_infotype, byval as zstring ptr, byval as size_t, byval as any ptr) as integer

enum CURLcode
	CURLE_OK = 0
	CURLE_UNSUPPORTED_PROTOCOL
	CURLE_FAILED_INIT
	CURLE_URL_MALFORMAT
	CURLE_URL_MALFORMAT_USER
	CURLE_COULDNT_RESOLVE_PROXY
	CURLE_COULDNT_RESOLVE_HOST
	CURLE_COULDNT_CONNECT
	CURLE_FTP_WEIRD_SERVER_REPLY
	CURLE_FTP_ACCESS_DENIED
	CURLE_FTP_USER_PASSWORD_INCORRECT
	CURLE_FTP_WEIRD_PASS_REPLY
	CURLE_FTP_WEIRD_USER_REPLY
	CURLE_FTP_WEIRD_PASV_REPLY
	CURLE_FTP_WEIRD_227_FORMAT
	CURLE_FTP_CANT_GET_HOST
	CURLE_FTP_CANT_RECONNECT
	CURLE_FTP_COULDNT_SET_BINARY
	CURLE_PARTIAL_FILE
	CURLE_FTP_COULDNT_RETR_FILE
	CURLE_FTP_WRITE_ERROR
	CURLE_FTP_QUOTE_ERROR
	CURLE_HTTP_RETURNED_ERROR
	CURLE_WRITE_ERROR
	CURLE_MALFORMAT_USER
	CURLE_FTP_COULDNT_STOR_FILE
	CURLE_READ_ERROR
	CURLE_OUT_OF_MEMORY
	CURLE_OPERATION_TIMEOUTED
	CURLE_FTP_COULDNT_SET_ASCII
	CURLE_FTP_PORT_FAILED
	CURLE_FTP_COULDNT_USE_REST
	CURLE_FTP_COULDNT_GET_SIZE
	CURLE_HTTP_RANGE_ERROR
	CURLE_HTTP_POST_ERROR
	CURLE_SSL_CONNECT_ERROR
	CURLE_BAD_DOWNLOAD_RESUME
	CURLE_FILE_COULDNT_READ_FILE
	CURLE_LDAP_CANNOT_BIND
	CURLE_LDAP_SEARCH_FAILED
	CURLE_LIBRARY_NOT_FOUND
	CURLE_FUNCTION_NOT_FOUND
	CURLE_ABORTED_BY_CALLBACK
	CURLE_BAD_FUNCTION_ARGUMENT
	CURLE_BAD_CALLING_ORDER
	CURLE_INTERFACE_FAILED
	CURLE_BAD_PASSWORD_ENTERED
	CURLE_TOO_MANY_REDIRECTS
	CURLE_UNKNOWN_TELNET_OPTION
	CURLE_TELNET_OPTION_SYNTAX
	CURLE_OBSOLETE
	CURLE_SSL_PEER_CERTIFICATE
	CURLE_GOT_NOTHING
	CURLE_SSL_ENGINE_NOTFOUND
	CURLE_SSL_ENGINE_SETFAILED
	CURLE_SEND_ERROR
	CURLE_RECV_ERROR
	CURLE_SHARE_IN_USE
	CURLE_SSL_CERTPROBLEM
	CURLE_SSL_CIPHER
	CURLE_SSL_CACERT
	CURLE_BAD_CONTENT_ENCODING
	CURLE_LDAP_INVALID_URL
	CURLE_FILESIZE_EXCEEDED
	CURLE_FTP_SSL_FAILED
	CURLE_SEND_FAIL_REWIND
	CURLE_SSL_ENGINE_INITFAILED
	CURLE_LOGIN_DENIED
	CURLE_TFTP_NOTFOUND
	CURLE_TFTP_PERM
	CURLE_TFTP_DISKFULL
	CURLE_TFTP_ILLEGAL
	CURLE_TFTP_UNKNOWNID
	CURLE_TFTP_EXISTS
	CURLE_TFTP_NOSUCHUSER
	CURLE_CONV_FAILED
	CURLE_CONV_REQD
	CURL_LAST
end enum

#define CURLE_OPERATION_TIMEDOUT CURLE_OPERATION_TIMEOUTED
#define CURLE_HTTP_NOT_FOUND CURLE_HTTP_RETURNED_ERROR
#define CURLE_HTTP_PORT_FAILED CURLE_INTERFACE_FAILED
#define CURLE_FTP_PARTIAL_FILE CURLE_PARTIAL_FILE
#define CURLE_FTP_BAD_DOWNLOAD_RESUME CURLE_BAD_DOWNLOAD_RESUME
#define CURLE_ALREADY_COMPLETE 99999

type curl_conv_callback as function cdecl(byval as zstring ptr, byval as size_t) as CURLcode
type curl_ssl_ctx_callback as function cdecl(byval as CURL ptr, byval as any ptr, byval as any ptr) as CURLcode

enum curl_proxytype
	CURLPROXY_HTTP = 0
	CURLPROXY_SOCKS4 = 4
	CURLPROXY_SOCKS5 = 5
end enum


#define CURLAUTH_NONE 0
#define CURLAUTH_BASIC (1 shl 0)
#define CURLAUTH_DIGEST (1 shl 1)
#define CURLAUTH_GSSNEGOTIATE (1 shl 2)
#define CURLAUTH_NTLM (1 shl 3)
#define CURLAUTH_ANY (not 0)
#define CURLAUTH_ANYSAFE (not (1 shl 0))
#define CURLE_ALREADY_COMPLETE 99999
#define CURL_ERROR_SIZE 256

enum curl_ftpssl
	CURLFTPSSL_NONE
	CURLFTPSSL_TRY
	CURLFTPSSL_CONTROL
	CURLFTPSSL_ALL
	CURLFTPSSL_LAST
end enum


enum curl_ftpauth
	CURLFTPAUTH_DEFAULT
	CURLFTPAUTH_SSL
	CURLFTPAUTH_TLS
	CURLFTPAUTH_LAST
end enum


enum curl_ftpmethod
	CURLFTPMETHOD_DEFAULT
	CURLFTPMETHOD_MULTICWD
	CURLFTPMETHOD_NOCWD
	CURLFTPMETHOD_SINGLECWD
	CURLFTPMETHOD_LAST
end enum


#define CURLOPTTYPE_LONG 0
#define CURLOPTTYPE_OBJECTPOINT 10000
#define CURLOPTTYPE_FUNCTIONPOINT 20000
#define CURLOPTTYPE_OFF_T 30000

enum CURLoption
	CURLOPT_FILE = 10000+1
	CURLOPT_URL = 10000+2
	CURLOPT_PORT = 0+3
	CURLOPT_PROXY = 10000+4
	CURLOPT_USERPWD = 10000+5
	CURLOPT_PROXYUSERPWD = 10000+6
	CURLOPT_RANGE = 10000+7
	CURLOPT_INFILE = 10000+9
	CURLOPT_ERRORBUFFER = 10000+10
	CURLOPT_WRITEFUNCTION = 20000+11
	CURLOPT_READFUNCTION = 20000+12
	CURLOPT_TIMEOUT = 0+13
	CURLOPT_INFILESIZE = 0+14
	CURLOPT_POSTFIELDS = 10000+15
	CURLOPT_REFERER = 10000+16
	CURLOPT_FTPPORT = 10000+17
	CURLOPT_USERAGENT = 10000+18
	CURLOPT_LOW_SPEED_LIMIT = 0+19
	CURLOPT_LOW_SPEED_TIME = 0+20
	CURLOPT_RESUME_FROM = 0+21
	CURLOPT_COOKIE = 10000+22
	CURLOPT_HTTPHEADER = 10000+23
	CURLOPT_HTTPPOST = 10000+24
	CURLOPT_SSLCERT = 10000+25
	CURLOPT_SSLCERTPASSWD = 10000+26
	CURLOPT_SSLKEYPASSWD = 10000+26
	CURLOPT_CRLF = 0+27
	CURLOPT_QUOTE = 10000+28
	CURLOPT_WRITEHEADER = 10000+29
	CURLOPT_COOKIEFILE = 10000+31
	CURLOPT_SSLVERSION = 0+32
	CURLOPT_TIMECONDITION = 0+33
	CURLOPT_TIMEVALUE = 0+34
	CURLOPT_CUSTOMREQUEST = 10000+36
	CURLOPT_STDERR = 10000+37
	CURLOPT_POSTQUOTE = 10000+39
	CURLOPT_WRITEINFO = 10000+40
	CURLOPT_VERBOSE = 0+41
	CURLOPT_HEADER = 0+42
	CURLOPT_NOPROGRESS = 0+43
	CURLOPT_NOBODY = 0+44
	CURLOPT_FAILONERROR = 0+45
	CURLOPT_UPLOAD = 0+46
	CURLOPT_POST = 0+47
	CURLOPT_FTPLISTONLY = 0+48
	CURLOPT_FTPAPPEND = 0+50
	CURLOPT_NETRC = 0+51
	CURLOPT_FOLLOWLOCATION = 0+52
	CURLOPT_TRANSFERTEXT = 0+53
	CURLOPT_PUT = 0+54
	CURLOPT_PROGRESSFUNCTION = 20000+56
	CURLOPT_PROGRESSDATA = 10000+57
	CURLOPT_AUTOREFERER = 0+58
	CURLOPT_PROXYPORT = 0+59
	CURLOPT_POSTFIELDSIZE = 0+60
	CURLOPT_HTTPPROXYTUNNEL = 0+61
	CURLOPT_INTERFACE = 10000+62
	CURLOPT_KRB4LEVEL = 10000+63
	CURLOPT_SSL_VERIFYPEER = 0+64
	CURLOPT_CAINFO = 10000+65
	CURLOPT_MAXREDIRS = 0+68
	CURLOPT_FILETIME = 0+69
	CURLOPT_TELNETOPTIONS = 10000+70
	CURLOPT_MAXCONNECTS = 0+71
	CURLOPT_CLOSEPOLICY = 0+72
	CURLOPT_FRESH_CONNECT = 0+74
	CURLOPT_FORBID_REUSE = 0+75
	CURLOPT_RANDOM_FILE = 10000+76
	CURLOPT_EGDSOCKET = 10000+77
	CURLOPT_CONNECTTIMEOUT = 0+78
	CURLOPT_HEADERFUNCTION = 20000+79
	CURLOPT_HTTPGET = 0+80
	CURLOPT_SSL_VERIFYHOST = 0+81
	CURLOPT_COOKIEJAR = 10000+82
	CURLOPT_SSL_CIPHER_LIST = 10000+83
	CURLOPT_HTTP_VERSION = 0+84
	CURLOPT_FTP_USE_EPSV = 0+85
	CURLOPT_SSLCERTTYPE = 10000+86
	CURLOPT_SSLKEY = 10000+87
	CURLOPT_SSLKEYTYPE = 10000+88
	CURLOPT_SSLENGINE = 10000+89
	CURLOPT_SSLENGINE_DEFAULT = 0+90
	CURLOPT_DNS_USE_GLOBAL_CACHE = 0+91
	CURLOPT_DNS_CACHE_TIMEOUT = 0+92
	CURLOPT_PREQUOTE = 10000+93
	CURLOPT_DEBUGFUNCTION = 20000+94
	CURLOPT_DEBUGDATA = 10000+95
	CURLOPT_COOKIESESSION = 0+96
	CURLOPT_CAPATH = 10000+97
	CURLOPT_BUFFERSIZE = 0+98
	CURLOPT_NOSIGNAL = 0+99
	CURLOPT_SHARE = 10000+100
	CURLOPT_PROXYTYPE = 0+101
	CURLOPT_ENCODING = 10000+102
	CURLOPT_PRIVATE = 10000+103
	CURLOPT_HTTP200ALIASES = 10000+104
	CURLOPT_UNRESTRICTED_AUTH = 0+105
	CURLOPT_FTP_USE_EPRT = 0+106
	CURLOPT_HTTPAUTH = 0+107
	CURLOPT_SSL_CTX_FUNCTION = 20000+108
	CURLOPT_SSL_CTX_DATA = 10000+109
	CURLOPT_FTP_CREATE_MISSING_DIRS = 0+110
	CURLOPT_PROXYAUTH = 0+111
	CURLOPT_FTP_RESPONSE_TIMEOUT = 0+112
	CURLOPT_IPRESOLVE = 0+113
	CURLOPT_MAXFILESIZE = 0+114
	CURLOPT_INFILESIZE_LARGE = 30000+115
	CURLOPT_RESUME_FROM_LARGE = 30000+116
	CURLOPT_MAXFILESIZE_LARGE = 30000+117
	CURLOPT_NETRC_FILE = 10000+118
	CURLOPT_FTP_SSL = 0+119
	CURLOPT_POSTFIELDSIZE_LARGE = 30000+120
	CURLOPT_TCP_NODELAY = 0+121
	CURLOPT_SOURCE_USERPWD = 10000+123
	CURLOPT_SOURCE_PREQUOTE = 10000+127
	CURLOPT_SOURCE_POSTQUOTE = 10000+128
	CURLOPT_FTPSSLAUTH = 0+129
	CURLOPT_IOCTLFUNCTION = 20000+130
	CURLOPT_IOCTLDATA = 10000+131
	CURLOPT_SOURCE_URL = 10000+132
	CURLOPT_SOURCE_QUOTE = 10000+133
	CURLOPT_FTP_ACCOUNT = 10000+134
	CURLOPT_COOKIELIST = 10000+135
	CURLOPT_IGNORE_CONTENT_LENGTH = 0+136
	CURLOPT_FTP_SKIP_PASV_IP = 0+137
	CURLOPT_FTP_FILEMETHOD = 0+138
	CURLOPT_LOCALPORT = 0+139
	CURLOPT_LOCALPORTRANGE = 0+140
	CURLOPT_CONNECT_ONLY = 0+141
	CURLOPT_CONV_FROM_NETWORK_FUNCTION = 20000+142
	CURLOPT_CONV_TO_NETWORK_FUNCTION = 20000+143
	CURLOPT_CONV_FROM_UTF8_FUNCTION = 20000+144
	CURLOPT_LASTENTRY
end enum


#define CURL_IPRESOLVE_WHATEVER 0
#define CURL_IPRESOLVE_V4 1
#define CURL_IPRESOLVE_V6 2
#define CURLOPT_WRITEDATA CURLOPT_FILE
#define CURLOPT_READDATA CURLOPT_INFILE
#define CURLOPT_HEADERDATA CURLOPT_WRITEHEADER
#define CURLOPT_HTTPREQUEST -1
#define CURLOPT_MUTE -2
#define CURLOPT_PASSWDFUNCTION -3
#define CURLOPT_PASSWDDATA -4
#define CURLOPT_CLOSEFUNCTION -5
#define CURLOPT_SOURCE_HOST -6
#define CURLOPT_SOURCE_PATH -7
#define CURLOPT_SOURCE_PORT -8
#define CURLOPT_PASV_HOST -9

enum 
	CURL_HTTP_VERSION_NONE
	CURL_HTTP_VERSION_1_0
	CURL_HTTP_VERSION_1_1
	CURL_HTTP_VERSION_LAST
end enum

enum CURL_NETRC_OPTION
	CURL_NETRC_IGNORED
	CURL_NETRC_OPTIONAL
	CURL_NETRC_REQUIRED
	CURL_NETRC_LAST
end enum

enum 
	CURL_SSLVERSION_DEFAULT
	CURL_SSLVERSION_TLSv1
	CURL_SSLVERSION_SSLv2
	CURL_SSLVERSION_SSLv3
	CURL_SSLVERSION_LAST
end enum

enum curl_TimeCond
	CURL_TIMECOND_NONE
	CURL_TIMECOND_IFMODSINCE
	CURL_TIMECOND_IFUNMODSINCE
	CURL_TIMECOND_LASTMOD
	CURL_TIMECOND_LAST
end enum


declare function curl_strequal cdecl alias "curl_strequal" (byval s1 as zstring ptr, byval s2 as zstring ptr) as integer
declare function curl_strnequal cdecl alias "curl_strnequal" (byval s1 as zstring ptr, byval s2 as zstring ptr, byval n as size_t) as integer

enum CURLformoption
	CURLFORM_NOTHING
	CURLFORM_COPYNAME
	CURLFORM_PTRNAME
	CURLFORM_NAMELENGTH
	CURLFORM_COPYCONTENTS
	CURLFORM_PTRCONTENTS
	CURLFORM_CONTENTSLENGTH
	CURLFORM_FILECONTENT
	CURLFORM_ARRAY
	CURLFORM_OBSOLETE
	CURLFORM_FILE
	CURLFORM_BUFFER
	CURLFORM_BUFFERPTR
	CURLFORM_BUFFERLENGTH
	CURLFORM_CONTENTTYPE
	CURLFORM_CONTENTHEADER
	CURLFORM_FILENAME
	CURLFORM_END
	CURLFORM_OBSOLETE2
	CURLFORM_LASTENTRY
end enum


type curl_forms
	option as CURLformoption
	value as zstring ptr
end type

enum CURLFORMcode
	CURL_FORMADD_OK
	CURL_FORMADD_MEMORY
	CURL_FORMADD_OPTION_TWICE
	CURL_FORMADD_NULL
	CURL_FORMADD_UNKNOWN_OPTION
	CURL_FORMADD_INCOMPLETE
	CURL_FORMADD_ILLEGAL_ARRAY
	CURL_FORMADD_DISABLED
	CURL_FORMADD_LAST
end enum


declare function curl_formadd cdecl alias "curl_formadd" (byval httppost as curl_httppost ptr ptr, byval last_post as curl_httppost ptr ptr, ...) as CURLFORMcode
declare sub curl_formfree cdecl alias "curl_formfree" (byval form as curl_httppost ptr)
declare function curl_getenv cdecl alias "curl_getenv" (byval variable as zstring ptr) as zstring ptr
declare function curl_version cdecl alias "curl_version" () as zstring ptr
declare function curl_easy_escape cdecl alias "curl_easy_escape" (byval handle as CURL ptr, byval string as zstring ptr, byval length as integer) as zstring ptr
declare function curl_escape cdecl alias "curl_escape" (byval string as zstring ptr, byval length as integer) as zstring ptr
declare function curl_easy_unescape cdecl alias "curl_easy_unescape" (byval handle as CURL ptr, byval string as zstring ptr, byval length as integer, byval outlength as integer ptr) as zstring ptr
declare function curl_unescape cdecl alias "curl_unescape" (byval string as zstring ptr, byval length as integer) as zstring ptr
declare sub curl_free cdecl alias "curl_free" (byval p as any ptr)
declare function curl_global_init cdecl alias "curl_global_init" (byval flags as integer) as CURLcode
declare function curl_global_init_mem cdecl alias "curl_global_init_mem" (byval flags as integer, byval m as curl_malloc_callback, byval f as curl_free_callback, byval r as curl_realloc_callback, byval s as curl_strdup_callback, byval c as curl_calloc_callback) as CURLcode
declare sub curl_global_cleanup cdecl alias "curl_global_cleanup" ()

type curl_slist
	data as zstring ptr
	next as curl_slist ptr
end type

declare function curl_slist_append cdecl alias "curl_slist_append" (byval as curl_slist ptr, byval as zstring ptr) as curl_slist ptr
declare sub curl_slist_free_all cdecl alias "curl_slist_free_all" (byval as curl_slist ptr)
declare function curl_getdate cdecl alias "curl_getdate" (byval p as zstring ptr, byval unused as time_t ptr) as time_t

#define CURLINFO_STRING &h100000
#define CURLINFO_LONG &h200000
#define CURLINFO_DOUBLE &h300000
#define CURLINFO_SLIST &h400000
#define CURLINFO_MASK &h0fffff
#define CURLINFO_TYPEMASK &hf00000

enum CURLINFO
	CURLINFO_NONE
	CURLINFO_EFFECTIVE_URL = &h100000+1
	CURLINFO_RESPONSE_CODE = &h200000+2
	CURLINFO_TOTAL_TIME = &h300000+3
	CURLINFO_NAMELOOKUP_TIME = &h300000+4
	CURLINFO_CONNECT_TIME = &h300000+5
	CURLINFO_PRETRANSFER_TIME = &h300000+6
	CURLINFO_SIZE_UPLOAD = &h300000+7
	CURLINFO_SIZE_DOWNLOAD = &h300000+8
	CURLINFO_SPEED_DOWNLOAD = &h300000+9
	CURLINFO_SPEED_UPLOAD = &h300000+10
	CURLINFO_HEADER_SIZE = &h200000+11
	CURLINFO_REQUEST_SIZE = &h200000+12
	CURLINFO_SSL_VERIFYRESULT = &h200000+13
	CURLINFO_FILETIME = &h200000+14
	CURLINFO_CONTENT_LENGTH_DOWNLOAD = &h300000+15
	CURLINFO_CONTENT_LENGTH_UPLOAD = &h300000+16
	CURLINFO_STARTTRANSFER_TIME = &h300000+17
	CURLINFO_CONTENT_TYPE = &h100000+18
	CURLINFO_REDIRECT_TIME = &h300000+19
	CURLINFO_REDIRECT_COUNT = &h200000+20
	CURLINFO_PRIVATE = &h100000+21
	CURLINFO_HTTP_CONNECTCODE = &h200000+22
	CURLINFO_HTTPAUTH_AVAIL = &h200000+23
	CURLINFO_PROXYAUTH_AVAIL = &h200000+24
	CURLINFO_OS_ERRNO = &h200000+25
	CURLINFO_NUM_CONNECTS = &h200000+26
	CURLINFO_SSL_ENGINES = &h400000+27
	CURLINFO_COOKIELIST = &h400000+28
	CURLINFO_LASTSOCKET = &h200000+29
	CURLINFO_FTP_ENTRY_PATH = &h100000+30
	CURLINFO_LASTONE = 30
end enum


enum curl_closepolicy
	CURLCLOSEPOLICY_NONE
	CURLCLOSEPOLICY_OLDEST
	CURLCLOSEPOLICY_LEAST_RECENTLY_USED
	CURLCLOSEPOLICY_LEAST_TRAFFIC
	CURLCLOSEPOLICY_SLOWEST
	CURLCLOSEPOLICY_CALLBACK
	CURLCLOSEPOLICY_LAST
end enum


#define CURL_GLOBAL_SSL (1 shl 0)
#define CURL_GLOBAL_WIN32 (1 shl 1)
#define CURL_GLOBAL_ALL ((1 shl 0) or (1 shl 1))
#define CURL_GLOBAL_NOTHING 0
#define CURL_GLOBAL_DEFAULT ((1 shl 0) or (1 shl 1))

enum curl_lock_data
	CURL_LOCK_DATA_NONE = 0
	CURL_LOCK_DATA_SHARE
	CURL_LOCK_DATA_COOKIE
	CURL_LOCK_DATA_DNS
	CURL_LOCK_DATA_SSL_SESSION
	CURL_LOCK_DATA_CONNECT
	CURL_LOCK_DATA_LAST
end enum


enum curl_lock_access
	CURL_LOCK_ACCESS_NONE = 0
	CURL_LOCK_ACCESS_SHARED = 1
	CURL_LOCK_ACCESS_SINGLE = 2
	CURL_LOCK_ACCESS_LAST
end enum

type curl_lock_function as sub cdecl(byval as CURL ptr, byval as curl_lock_data, byval as curl_lock_access, byval as any ptr)
type curl_unlock_function as sub cdecl(byval as CURL ptr, byval as curl_lock_data, byval as any ptr)
type CURLSH as any

enum CURLSHcode
	CURLSHE_OK
	CURLSHE_BAD_OPTION
	CURLSHE_IN_USE
	CURLSHE_INVALID
	CURLSHE_NOMEM
	CURLSHE_LAST
end enum


enum CURLSHoption
	CURLSHOPT_NONE
	CURLSHOPT_SHARE
	CURLSHOPT_UNSHARE
	CURLSHOPT_LOCKFUNC
	CURLSHOPT_UNLOCKFUNC
	CURLSHOPT_USERDATA
	CURLSHOPT_LAST
end enum


declare function curl_share_init cdecl alias "curl_share_init" () as CURLSH ptr
declare function curl_share_setopt cdecl alias "curl_share_setopt" (byval as CURLSH ptr, byval option as CURLSHoption, ...) as CURLSHcode
declare function curl_share_cleanup cdecl alias "curl_share_cleanup" (byval as CURLSH ptr) as CURLSHcode

enum CURLversion
	CURLVERSION_FIRST
	CURLVERSION_SECOND
	CURLVERSION_THIRD
	CURLVERSION_LAST
end enum

#define CURLVERSION_NOW CURLVERSION_THIRD

type curl_version_info_data
	age as CURLversion
	version as zstring ptr
	version_num as uinteger
	host as zstring ptr
	features as integer
	ssl_version as zstring ptr
	ssl_version_num as integer
	libz_version as zstring ptr
	protocols as byte ptr ptr
	ares as zstring ptr
	ares_num as integer
	libidn as zstring ptr
end type

#define CURL_VERSION_IPV6 (1 shl 0)
#define CURL_VERSION_KERBEROS4 (1 shl 1)
#define CURL_VERSION_SSL (1 shl 2)
#define CURL_VERSION_LIBZ (1 shl 3)
#define CURL_VERSION_NTLM (1 shl 4)
#define CURL_VERSION_GSSNEGOTIATE (1 shl 5)
#define CURL_VERSION_DEBUG (1 shl 6)
#define CURL_VERSION_ASYNCHDNS (1 shl 7)
#define CURL_VERSION_SPNEGO (1 shl 8)
#define CURL_VERSION_LARGEFILE (1 shl 9)
#define CURL_VERSION_IDN (1 shl 10)
#define CURL_VERSION_SSPI (1 shl 11)
#define CURL_VERSION_CONV (1 shl 12)

declare function curl_version_info cdecl alias "curl_version_info" (byval as CURLversion) as curl_version_info_data ptr
declare function curl_easy_strerror cdecl alias "curl_easy_strerror" (byval as CURLcode) as zstring ptr
declare function curl_share_strerror cdecl alias "curl_share_strerror" (byval as CURLSHcode) as zstring ptr

'' begin include easy.bi
declare function curl_easy_init cdecl alias "curl_easy_init" () as CURL ptr
declare function curl_easy_setopt cdecl alias "curl_easy_setopt" (byval curl as CURL ptr, byval option as CURLoption, ...) as CURLcode
declare function curl_easy_perform cdecl alias "curl_easy_perform" (byval curl as CURL ptr) as CURLcode
declare sub curl_easy_cleanup cdecl alias "curl_easy_cleanup" (byval curl as CURL ptr)
declare function curl_easy_getinfo cdecl alias "curl_easy_getinfo" (byval curl as CURL ptr, byval info as CURLINFO, ...) as CURLcode
declare function curl_easy_duphandle cdecl alias "curl_easy_duphandle" (byval curl as CURL ptr) as CURL ptr
declare sub curl_easy_reset cdecl alias "curl_easy_reset" (byval curl as CURL ptr)
'' end include

'' begin include multi.bi
#ifdef __FB_WIN32__
# include once "win/winsock2.bi"
#else
# include once "crt/sys/socket.bi"
#endif
#include once "crt/sys/time.bi"
#include once "crt/sys/types.bi"

type CURLM as any
type curl_socket_t as integer

#define CURL_SOCKET_BAD -1

enum CURLMcode
	CURLM_CALL_MULTI_PERFORM = -1
	CURLM_OK
	CURLM_BAD_HANDLE
	CURLM_BAD_EASY_HANDLE
	CURLM_OUT_OF_MEMORY
	CURLM_INTERNAL_ERROR
	CURLM_BAD_SOCKET
	CURLM_UNKNOWN_OPTION
	CURLM_LAST
end enum


enum CURLMSG_
	CURLMSG_NONE
	CURLMSG_DONE
	CURLMSG_LAST
end enum

union CURLMsg_data
	whatever as any ptr
	result as CURLcode
end union

type CURLMsg
	msg as CURLMSG_
	easy_handle as CURL ptr
	data as CURLMsg_data
end type

declare function curl_multi_init cdecl alias "curl_multi_init" () as CURLM ptr
declare function curl_multi_add_handle cdecl alias "curl_multi_add_handle" (byval multi_handle as CURLM ptr, byval curl_handle as CURL ptr) as CURLMcode
declare function curl_multi_remove_handle cdecl alias "curl_multi_remove_handle" (byval multi_handle as CURLM ptr, byval curl_handle as CURL ptr) as CURLMcode
declare function curl_multi_fdset cdecl alias "curl_multi_fdset" (byval multi_handle as CURLM ptr, byval read_fd_set as fd_set ptr, byval write_fd_set as fd_set ptr, byval exc_fd_set as fd_set ptr, byval max_fd as integer ptr) as CURLMcode
declare function curl_multi_perform cdecl alias "curl_multi_perform" (byval multi_handle as CURLM ptr, byval running_handles as integer ptr) as CURLMcode
declare function curl_multi_cleanup cdecl alias "curl_multi_cleanup" (byval multi_handle as CURLM ptr) as CURLMcode
declare function curl_multi_info_read cdecl alias "curl_multi_info_read" (byval multi_handle as CURLM ptr, byval msgs_in_queue as integer ptr) as CURLMsg ptr
declare function curl_multi_strerror cdecl alias "curl_multi_strerror" (byval as CURLMcode) as zstring ptr

#define CURL_POLL_NONE 0
#define CURL_POLL_IN 1
#define CURL_POLL_OUT 2
#define CURL_POLL_INOUT 3
#define CURL_POLL_REMOVE 4
#define CURL_SOCKET_TIMEOUT -1

type curl_socket_callback as function cdecl(byval as CURL ptr, byval as curl_socket_t, byval as integer, byval as any ptr) as integer

declare function curl_multi_socket cdecl alias "curl_multi_socket" (byval multi_handle as CURLM ptr, byval s as curl_socket_t) as CURLMcode
declare function curl_multi_socket_all cdecl alias "curl_multi_socket_all" (byval multi_handle as CURLM ptr) as CURLMcode
declare function curl_multi_timeout cdecl alias "curl_multi_timeout" (byval multi_handle as CURLM ptr, byval milliseconds as integer ptr) as CURLMcode

enum CURLMoption
	CURLMOPT_SOCKETFUNCTION = 20000+1
	CURLMOPT_SOCKETDATA = 10000+2
	CURLMOPT_LASTENTRY
end enum


declare function curl_multi_setopt cdecl alias "curl_multi_setopt" (byval multi_handle as CURLM ptr, byval option as CURLMoption, ...) as CURLMcode
'' end include

#endif
