#ifndef __CURL_BI__
#define __CURL_BI__

#inclib "curl"

#define LIBCURL_COPYRIGHT "1996 - 2011 Daniel Stenberg, <daniel@haxx.se>."
#define LIBCURL_VERSION "7.21.6"
#define LIBCURL_VERSION_MAJOR 7
#define LIBCURL_VERSION_MINOR 21
#define LIBCURL_VERSION_PATCH 6
#define LIBCURL_VERSION_NUM &h071506
#define LIBCURL_TIMESTAMP "Fri Apr 22 17:18:50 UTC 2011"

type curl_off_t as longint

#ifdef __FB_WIN32__
    #include once "win/winsock2.bi"
#else
    #include once "crt/sys/socket.bi"
#endif
#include once "crt/sys/time.bi"
#include once "crt/sys/types.bi"

extern "c"

type CURL as any

#ifdef __FB_WIN32__
    type curl_socket_t as SOCKET
    #define CURL_SOCKET_BAD INVALID_SOCKET
#else
    type curl_socket_t as integer
    #define CURL_SOCKET_BAD -1
#endif

type curl_slist_ as curl_slist

type curl_httppost
    as curl_httppost ptr next
    as ubyte ptr name
    as long namelength
    as ubyte ptr contents
    as long contentslength
    as ubyte ptr buffer
    as long bufferlength
    as zstring ptr contenttype
    as curl_slist_ ptr contentheader
    as curl_httppost ptr more
    as long flags
    as zstring ptr showfilename
    as any ptr userp
end type

#define HTTPPOST_FILENAME       (1 shl 0)
#define HTTPPOST_READFILE       (1 shl 1)
#define HTTPPOST_PTRNAME        (1 shl 2)
#define HTTPPOST_PTRCONTENTS    (1 shl 3)
#define HTTPPOST_BUFFER         (1 shl 4)
#define HTTPPOST_PTRBUFFER      (1 shl 5)
#define HTTPPOST_CALLBACK       (1 shl 6)

type curl_progress_callback as function _
    ( _
        byval as any ptr, _
        byval as double, _
        byval as double, _
        byval as double, _
        byval as double _
    ) as integer

#define CURL_MAX_WRITE_SIZE 16384
#define CURL_MAX_HTTP_HEADER (100*1024)

#define CURL_WRITEFUNC_PAUSE &h10000001
type curl_write_callback as function _
    ( _
        byval as ubyte ptr, _
        byval as size_t, _
        byval as size_t, _
        byval as any ptr _
    ) as size_t

enum curlfiletype
    CURLFILETYPE_FILE = 0
    CURLFILETYPE_DIRECTORY
    CURLFILETYPE_SYMLINK
    CURLFILETYPE_DEVICE_BLOCK
    CURLFILETYPE_DEVICE_CHAR
    CURLFILETYPE_NAMEDPIPE
    CURLFILETYPE_SOCKET
    CURLFILETYPE_DOOR
    CURLFILETYPE_UNKNOWN
end enum

#define CURLFINFOFLAG_KNOWN_FILENAME    (1 shl 0)
#define CURLFINFOFLAG_KNOWN_FILETYPE    (1 shl 1)
#define CURLFINFOFLAG_KNOWN_TIME        (1 shl 2)
#define CURLFINFOFLAG_KNOWN_PERM        (1 shl 3)
#define CURLFINFOFLAG_KNOWN_UID         (1 shl 4)
#define CURLFINFOFLAG_KNOWN_GID         (1 shl 5)
#define CURLFINFOFLAG_KNOWN_SIZE        (1 shl 6)
#define CURLFINFOFLAG_KNOWN_HLINKCOUNT  (1 shl 7)

type curl_fileinfo_strings
    as zstring ptr time
    as zstring ptr perm
    as zstring ptr user
    as zstring ptr group
    as zstring ptr target
end type

type curl_fileinfo
    as zstring ptr filename
    as curlfiletype filetype
    as time_t time
    as uinteger perm
    as integer uid
    as integer gid
    as curl_off_t size
    as long hardlinks
    as curl_fileinfo_strings strings
    as uinteger flags
    as ubyte ptr b_data
    as size_t b_size
    as size_t b_used
end type

#define CURL_CHUNK_BGN_FUNC_OK      0
#define CURL_CHUNK_BGN_FUNC_FAIL    1
#define CURL_CHUNK_BGN_FUNC_SKIP    2

type curl_chunk_bgn_callback as function _
    ( _
        byval as const any ptr, _
        byval as any ptr, _
        byval as integer _
    ) as long

#define CURL_CHUNK_END_FUNC_OK      0
#define CURL_CHUNK_END_FUNC_FAIL    1

type curl_chunk_end_callback as function(byval as any ptr) as long

#define CURL_FNMATCHFUNC_MATCH    0
#define CURL_FNMATCHFUNC_NOMATCH  1
#define CURL_FNMATCHFUNC_FAIL     2

type curl_fnmatch_callback as function _
    ( _
        byval as any ptr, _
        byval as const zstring ptr, _
        byval as const zstring ptr _
    ) as integer

#define CURL_SEEKFUNC_OK       0
#define CURL_SEEKFUNC_FAIL     1
#define CURL_SEEKFUNC_CANTSEEK 2
type curl_seek_callback as function _
    ( _
        byval as any ptr, _
        byval as curl_off_t, _
        byval as integer _
    ) as integer

#define CURL_READFUNC_ABORT &h10000000
#define CURL_READFUNC_PAUSE &h10000001

type curl_read_callback as function _
    ( _
        byval as ubyte ptr, _
        byval as size_t, _
        byval as size_t, _
        byval as any ptr _
    ) as size_t

enum curlsocktype
    CURLSOCKTYPE_IPCXN
    CURLSOCKTYPE_LAST
end enum

#define CURL_SOCKOPT_OK 0
#define CURL_SOCKOPT_ERROR 1
#define CURL_SOCKOPT_ALREADY_CONNECTED 2

type curl_sockopt_callback as function _
    ( _
        byval as any ptr, _
        byval as curl_socket_t, _
        byval as curlsocktype _
    ) as integer

type curl_sockaddr
    as integer family
    as integer socktype
    as integer protocol
    as uinteger addrlen
    as sockaddr addr
end type

type curl_opensocket_callback as function _
    ( _
        byval as any ptr, _
        byval as curlsocktype, _
        byval as curl_sockaddr ptr _
    ) as curl_socket_t

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

type curl_ioctl_callback as function _
    ( _
        byval as CURL ptr, _
        byval as integer, _
        byval as any ptr _
    ) as curlioerr

type curl_malloc_callback as function(byval as size_t) as any ptr
type curl_free_callback as sub(byval as any ptr)
type curl_realloc_callback as function(byval as any ptr, byval as size_t) as any ptr
type curl_strdup_callback as function(byval as const zstring ptr) as zstring ptr
type curl_calloc_callback as function(byval as size_t, byval as size_t) as any ptr

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

type curl_debug_callback as function _
    ( _
        byval as CURL ptr, _
        byval as curl_infotype, _
        byval as ubyte ptr, _
        byval as size_t, _
        byval as any ptr _
    ) as integer

enum CURLcode
    CURLE_OK = 0
    CURLE_UNSUPPORTED_PROTOCOL
    CURLE_FAILED_INIT
    CURLE_URL_MALFORMAT
    CURLE_NOT_BUILT_IN
    CURLE_COULDNT_RESOLVE_PROXY
    CURLE_COULDNT_RESOLVE_HOST
    CURLE_COULDNT_CONNECT
    CURLE_FTP_WEIRD_SERVER_REPLY
    CURLE_REMOTE_ACCESS_DENIED
    CURLE_OBSOLETE10
    CURLE_FTP_WEIRD_PASS_REPLY
    CURLE_OBSOLETE12
    CURLE_FTP_WEIRD_PASV_REPLY
    CURLE_FTP_WEIRD_227_FORMAT
    CURLE_FTP_CANT_GET_HOST
    CURLE_OBSOLETE16
    CURLE_FTP_COULDNT_SET_TYPE
    CURLE_PARTIAL_FILE
    CURLE_FTP_COULDNT_RETR_FILE
    CURLE_OBSOLETE20
    CURLE_QUOTE_ERROR
    CURLE_HTTP_RETURNED_ERROR
    CURLE_WRITE_ERROR
    CURLE_OBSOLETE24
    CURLE_UPLOAD_FAILED
    CURLE_READ_ERROR
    CURLE_OUT_OF_MEMORY
    CURLE_OPERATION_TIMEDOUT
    CURLE_OBSOLETE29
    CURLE_FTP_PORT_FAILED
    CURLE_FTP_COULDNT_USE_REST
    CURLE_OBSOLETE32
    CURLE_RANGE_ERROR
    CURLE_HTTP_POST_ERROR
    CURLE_SSL_CONNECT_ERROR
    CURLE_BAD_DOWNLOAD_RESUME
    CURLE_FILE_COULDNT_READ_FILE
    CURLE_LDAP_CANNOT_BIND
    CURLE_LDAP_SEARCH_FAILED
    CURLE_OBSOLETE40
    CURLE_FUNCTION_NOT_FOUND
    CURLE_ABORTED_BY_CALLBACK
    CURLE_BAD_FUNCTION_ARGUMENT
    CURLE_OBSOLETE44
    CURLE_INTERFACE_FAILED
    CURLE_OBSOLETE46
    CURLE_TOO_MANY_REDIRECTS
    CURLE_UNKNOWN_OPTION
    CURLE_TELNET_OPTION_SYNTAX
    CURLE_OBSOLETE50
    CURLE_PEER_FAILED_VERIFICATION
    CURLE_GOT_NOTHING
    CURLE_SSL_ENGINE_NOTFOUND
    CURLE_SSL_ENGINE_SETFAILED
    CURLE_SEND_ERROR
    CURLE_RECV_ERROR
    CURLE_OBSOLETE57
    CURLE_SSL_CERTPROBLEM
    CURLE_SSL_CIPHER
    CURLE_SSL_CACERT
    CURLE_BAD_CONTENT_ENCODING
    CURLE_LDAP_INVALID_URL
    CURLE_FILESIZE_EXCEEDED
    CURLE_USE_SSL_FAILED
    CURLE_SEND_FAIL_REWIND
    CURLE_SSL_ENGINE_INITFAILED
    CURLE_LOGIN_DENIED
    CURLE_TFTP_NOTFOUND
    CURLE_TFTP_PERM
    CURLE_REMOTE_DISK_FULL
    CURLE_TFTP_ILLEGAL
    CURLE_TFTP_UNKNOWNID
    CURLE_REMOTE_FILE_EXISTS
    CURLE_TFTP_NOSUCHUSER
    CURLE_CONV_FAILED
    CURLE_CONV_REQD
    CURLE_SSL_CACERT_BADFILE
    CURLE_REMOTE_FILE_NOT_FOUND
    CURLE_SSH
    CURLE_SSL_SHUTDOWN_FAILED
    CURLE_AGAIN
    CURLE_SSL_CRL_BADFILE
    CURLE_SSL_ISSUER_ERROR
    CURLE_FTP_PRET_FAILED
    CURLE_RTSP_CSEQ_ERROR
    CURLE_RTSP_SESSION_ERROR
    CURLE_FTP_BAD_FILE_LIST
    CURLE_CHUNK_FAILED
    CURL_LAST
end enum

type curl_conv_callback as function(byval as ubyte ptr, byval as size_t) as CURLcode
type curl_ssl_ctx_callback as function _
    ( _
        byval as CURL ptr, _
        byval as any ptr, _
        byval as any ptr _
    ) as CURLcode

enum curl_proxytype
    CURLPROXY_HTTP = 0
    CURLPROXY_HTTP_1_0 = 1
    CURLPROXY_SOCKS4 = 4
    CURLPROXY_SOCKS5 = 5
    CURLPROXY_SOCKS4A = 6
    CURLPROXY_SOCKS5_HOSTNAME = 7
end enum

#define CURLAUTH_NONE         0
#define CURLAUTH_BASIC        (1 shl 0)
#define CURLAUTH_DIGEST       (1 shl 1)
#define CURLAUTH_GSSNEGOTIATE (1 shl 2)
#define CURLAUTH_NTLM         (1 shl 3)
#define CURLAUTH_DIGEST_IE    (1 shl 4)
#define CURLAUTH_ONLY         (1 shl 31)
#define CURLAUTH_ANY (not (CURLAUTH_DIGEST_IE))
#define CURLAUTH_ANYSAFE (not (CURLAUTH_BASIC or CURLAUTH_DIGEST_IE))

#define CURLSSH_AUTH_ANY       (not 0)
#define CURLSSH_AUTH_NONE      0
#define CURLSSH_AUTH_PUBLICKEY (1 shl 0)
#define CURLSSH_AUTH_PASSWORD  (1 shl 1)
#define CURLSSH_AUTH_HOST      (1 shl 2)
#define CURLSSH_AUTH_KEYBOARD  (1 shl 3)
#define CURLSSH_AUTH_DEFAULT CURLSSH_AUTH_ANY

#define CURL_ERROR_SIZE 256

enum curl_khkey_type
    CURLKHTYPE_UNKNOWN
    CURLKHTYPE_RSA1
    CURLKHTYPE_RSA
    CURLKHTYPE_DSS
end enum

type curl_khkey
    as const ubyte ptr key
    as size_t len
    as curl_khkey_type keytype
end type

enum curl_khstat
    CURLKHSTAT_FINE_ADD_TO_FILE
    CURLKHSTAT_FINE
    CURLKHSTAT_REJECT
    CURLKHSTAT_DEFER
    CURLKHSTAT_LAST
end enum

enum curl_khmatch
    CURLKHMATCH_OK
    CURLKHMATCH_MISMATCH
    CURLKHMATCH_MISSING
    CURLKHMATCH_LAST
end enum

type curl_sshkeycallback as function _
    ( _
        byval as CURL ptr, _
        byval as const curl_khkey ptr, _
        byval as const curl_khkey ptr, _
        byval as curl_khmatch, _
        byval as any ptr _
    ) as integer

enum curl_usessl
    CURLUSESSL_NONE
    CURLUSESSL_TRY
    CURLUSESSL_CONTROL
    CURLUSESSL_ALL
    CURLUSESSL_LAST
end enum

enum curl_ftpccc
    CURLFTPSSL_CCC_NONE
    CURLFTPSSL_CCC_PASSIVE
    CURLFTPSSL_CCC_ACTIVE
    CURLFTPSSL_CCC_LAST
end enum

enum curl_ftpauth
    CURLFTPAUTH_DEFAULT
    CURLFTPAUTH_SSL
    CURLFTPAUTH_TLS
    CURLFTPAUTH_LAST
end enum

enum curl_ftpcreatedir
    CURLFTP_CREATE_DIR_NONE
    CURLFTP_CREATE_DIR
    CURLFTP_CREATE_DIR_RETRY
    CURLFTP_CREATE_DIR_LAST
end enum

enum curl_ftpmethod
    CURLFTPMETHOD_DEFAULT
    CURLFTPMETHOD_MULTICWD
    CURLFTPMETHOD_NOCWD
    CURLFTPMETHOD_SINGLECWD
    CURLFTPMETHOD_LAST
end enum

#define CURLPROTO_HTTP   (1 shl 0)
#define CURLPROTO_HTTPS  (1 shl 1)
#define CURLPROTO_FTP    (1 shl 2)
#define CURLPROTO_FTPS   (1 shl 3)
#define CURLPROTO_SCP    (1 shl 4)
#define CURLPROTO_SFTP   (1 shl 5)
#define CURLPROTO_TELNET (1 shl 6)
#define CURLPROTO_LDAP   (1 shl 7)
#define CURLPROTO_LDAPS  (1 shl 8)
#define CURLPROTO_DICT   (1 shl 9)
#define CURLPROTO_FILE   (1 shl 10)
#define CURLPROTO_TFTP   (1 shl 11)
#define CURLPROTO_IMAP   (1 shl 12)
#define CURLPROTO_IMAPS  (1 shl 13)
#define CURLPROTO_POP3   (1 shl 14)
#define CURLPROTO_POP3S  (1 shl 15)
#define CURLPROTO_SMTP   (1 shl 16)
#define CURLPROTO_SMTPS  (1 shl 17)
#define CURLPROTO_RTSP   (1 shl 18)
#define CURLPROTO_RTMP   (1 shl 19)
#define CURLPROTO_RTMPT  (1 shl 20)
#define CURLPROTO_RTMPE  (1 shl 21)
#define CURLPROTO_RTMPTE (1 shl 22)
#define CURLPROTO_RTMPS  (1 shl 23)
#define CURLPROTO_RTMPTS (1 shl 24)
#define CURLPROTO_GOPHER (1 shl 25)
#define CURLPROTO_ALL    (not 0)

#define CURLOPTTYPE_LONG          0
#define CURLOPTTYPE_OBJECTPOINT   10000
#define CURLOPTTYPE_FUNCTIONPOINT 20000
#define CURLOPTTYPE_OFF_T         30000

enum CURLoption
    CURLOPT_FILE                    = CURLOPTTYPE_OBJECTPOINT + 1
    CURLOPT_URL                     = CURLOPTTYPE_OBJECTPOINT + 2
    CURLOPT_PORT                    = CURLOPTTYPE_LONG + 3
    CURLOPT_PROXY                   = CURLOPTTYPE_OBJECTPOINT + 4
    CURLOPT_USERPWD                 = CURLOPTTYPE_OBJECTPOINT + 5
    CURLOPT_PROXYUSERPWD            = CURLOPTTYPE_OBJECTPOINT + 6
    CURLOPT_RANGE                   = CURLOPTTYPE_OBJECTPOINT + 7
    CURLOPT_INFILE                  = CURLOPTTYPE_OBJECTPOINT + 9
    CURLOPT_ERRORBUFFER             = CURLOPTTYPE_OBJECTPOINT + 10
    CURLOPT_WRITEFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 11
    CURLOPT_READFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 12
    CURLOPT_TIMEOUT                 = CURLOPTTYPE_LONG + 13
    CURLOPT_INFILESIZE              = CURLOPTTYPE_LONG + 14
    CURLOPT_POSTFIELDS              = CURLOPTTYPE_OBJECTPOINT + 15
    CURLOPT_REFERER                 = CURLOPTTYPE_OBJECTPOINT + 16
    CURLOPT_FTPPORT                 = CURLOPTTYPE_OBJECTPOINT + 17
    CURLOPT_USERAGENT               = CURLOPTTYPE_OBJECTPOINT + 18
    CURLOPT_LOW_SPEED_LIMIT         = CURLOPTTYPE_LONG + 19
    CURLOPT_LOW_SPEED_TIME          = CURLOPTTYPE_LONG + 20
    CURLOPT_RESUME_FROM             = CURLOPTTYPE_LONG + 21
    CURLOPT_COOKIE                  = CURLOPTTYPE_OBJECTPOINT + 22
    CURLOPT_HTTPHEADER              = CURLOPTTYPE_OBJECTPOINT + 23
    CURLOPT_HTTPPOST                = CURLOPTTYPE_OBJECTPOINT + 24
    CURLOPT_SSLCERT                 = CURLOPTTYPE_OBJECTPOINT + 25
    CURLOPT_KEYPASSWD               = CURLOPTTYPE_OBJECTPOINT + 26
    CURLOPT_CRLF                    = CURLOPTTYPE_LONG + 27
    CURLOPT_QUOTE                   = CURLOPTTYPE_OBJECTPOINT + 28
    CURLOPT_WRITEHEADER             = CURLOPTTYPE_OBJECTPOINT + 29
    CURLOPT_COOKIEFILE              = CURLOPTTYPE_OBJECTPOINT + 31
    CURLOPT_SSLVERSION              = CURLOPTTYPE_LONG + 32
    CURLOPT_TIMECONDITION           = CURLOPTTYPE_LONG + 33
    CURLOPT_TIMEVALUE               = CURLOPTTYPE_LONG + 34
    CURLOPT_CUSTOMREQUEST           = CURLOPTTYPE_OBJECTPOINT + 36
    CURLOPT_STDERR                  = CURLOPTTYPE_OBJECTPOINT + 37
    CURLOPT_POSTQUOTE               = CURLOPTTYPE_OBJECTPOINT + 39
    CURLOPT_WRITEINFO               = CURLOPTTYPE_OBJECTPOINT + 40
    CURLOPT_VERBOSE                 = CURLOPTTYPE_LONG + 41
    CURLOPT_HEADER                  = CURLOPTTYPE_LONG + 42
    CURLOPT_NOPROGRESS              = CURLOPTTYPE_LONG + 43
    CURLOPT_NOBODY                  = CURLOPTTYPE_LONG + 44
    CURLOPT_FAILONERROR             = CURLOPTTYPE_LONG + 45
    CURLOPT_UPLOAD                  = CURLOPTTYPE_LONG + 46
    CURLOPT_POST                    = CURLOPTTYPE_LONG + 47
    CURLOPT_DIRLISTONLY             = CURLOPTTYPE_LONG + 48
    CURLOPT_APPEND                  = CURLOPTTYPE_LONG + 50
    CURLOPT_NETRC                   = CURLOPTTYPE_LONG + 51
    CURLOPT_FOLLOWLOCATION          = CURLOPTTYPE_LONG + 52
    CURLOPT_TRANSFERTEXT            = CURLOPTTYPE_LONG + 53
    CURLOPT_PUT                     = CURLOPTTYPE_LONG + 54
    CURLOPT_PROGRESSFUNCTION        = CURLOPTTYPE_FUNCTIONPOINT + 56
    CURLOPT_PROGRESSDATA            = CURLOPTTYPE_OBJECTPOINT + 57
    CURLOPT_AUTOREFERER             = CURLOPTTYPE_LONG + 58
    CURLOPT_PROXYPORT               = CURLOPTTYPE_LONG + 59
    CURLOPT_POSTFIELDSIZE           = CURLOPTTYPE_LONG + 60
    CURLOPT_HTTPPROXYTUNNEL         = CURLOPTTYPE_LONG + 61
    CURLOPT_INTERFACE               = CURLOPTTYPE_OBJECTPOINT + 62
    CURLOPT_KRBLEVEL                = CURLOPTTYPE_OBJECTPOINT + 63
    CURLOPT_SSL_VERIFYPEER          = CURLOPTTYPE_LONG + 64
    CURLOPT_CAINFO                  = CURLOPTTYPE_OBJECTPOINT + 65
    CURLOPT_MAXREDIRS               = CURLOPTTYPE_LONG + 68
    CURLOPT_FILETIME                = CURLOPTTYPE_LONG + 69
    CURLOPT_TELNETOPTIONS           = CURLOPTTYPE_OBJECTPOINT + 70
    CURLOPT_MAXCONNECTS             = CURLOPTTYPE_LONG + 71
    CURLOPT_CLOSEPOLICY             = CURLOPTTYPE_LONG + 72
    CURLOPT_FRESH_CONNECT           = CURLOPTTYPE_LONG + 74
    CURLOPT_FORBID_REUSE            = CURLOPTTYPE_LONG + 75
    CURLOPT_RANDOM_FILE             = CURLOPTTYPE_OBJECTPOINT + 76
    CURLOPT_EGDSOCKET               = CURLOPTTYPE_OBJECTPOINT + 77
    CURLOPT_CONNECTTIMEOUT          = CURLOPTTYPE_LONG + 78
    CURLOPT_HEADERFUNCTION          = CURLOPTTYPE_FUNCTIONPOINT + 79
    CURLOPT_HTTPGET                 = CURLOPTTYPE_LONG + 80
    CURLOPT_SSL_VERIFYHOST          = CURLOPTTYPE_LONG + 81
    CURLOPT_COOKIEJAR               = CURLOPTTYPE_OBJECTPOINT + 82
    CURLOPT_SSL_CIPHER_LIST         = CURLOPTTYPE_OBJECTPOINT + 83
    CURLOPT_HTTP_VERSION            = CURLOPTTYPE_LONG + 84
    CURLOPT_FTP_USE_EPSV            = CURLOPTTYPE_LONG + 85
    CURLOPT_SSLCERTTYPE             = CURLOPTTYPE_OBJECTPOINT + 86
    CURLOPT_SSLKEY                  = CURLOPTTYPE_OBJECTPOINT + 87
    CURLOPT_SSLKEYTYPE              = CURLOPTTYPE_OBJECTPOINT + 88
    CURLOPT_SSLENGINE               = CURLOPTTYPE_OBJECTPOINT + 89
    CURLOPT_SSLENGINE_DEFAULT       = CURLOPTTYPE_LONG + 90
    CURLOPT_DNS_USE_GLOBAL_CACHE    = CURLOPTTYPE_LONG + 91
    CURLOPT_DNS_CACHE_TIMEOUT       = CURLOPTTYPE_LONG + 92
    CURLOPT_PREQUOTE                = CURLOPTTYPE_OBJECTPOINT + 93
    CURLOPT_DEBUGFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 94
    CURLOPT_DEBUGDATA               = CURLOPTTYPE_OBJECTPOINT + 95
    CURLOPT_COOKIESESSION           = CURLOPTTYPE_LONG + 96
    CURLOPT_CAPATH                  = CURLOPTTYPE_OBJECTPOINT + 97
    CURLOPT_BUFFERSIZE              = CURLOPTTYPE_LONG + 98
    CURLOPT_NOSIGNAL                = CURLOPTTYPE_LONG + 99
    CURLOPT_SHARE                   = CURLOPTTYPE_OBJECTPOINT + 100
    CURLOPT_PROXYTYPE               = CURLOPTTYPE_LONG + 101
    CURLOPT_ACCEPT_ENCODING         = CURLOPTTYPE_OBJECTPOINT + 102
    CURLOPT_PRIVATE                 = CURLOPTTYPE_OBJECTPOINT + 103
    CURLOPT_HTTP200ALIASES          = CURLOPTTYPE_OBJECTPOINT + 104
    CURLOPT_UNRESTRICTED_AUTH       = CURLOPTTYPE_LONG + 105
    CURLOPT_FTP_USE_EPRT            = CURLOPTTYPE_LONG + 106
    CURLOPT_HTTPAUTH                = CURLOPTTYPE_LONG + 107
    CURLOPT_SSL_CTX_FUNCTION        = CURLOPTTYPE_FUNCTIONPOINT + 108
    CURLOPT_SSL_CTX_DATA            = CURLOPTTYPE_OBJECTPOINT + 109
    CURLOPT_FTP_CREATE_MISSING_DIRS = CURLOPTTYPE_LONG + 110
    CURLOPT_PROXYAUTH               = CURLOPTTYPE_LONG + 111
    CURLOPT_FTP_RESPONSE_TIMEOUT    = CURLOPTTYPE_LONG + 112
    CURLOPT_IPRESOLVE               = CURLOPTTYPE_LONG + 113
    CURLOPT_MAXFILESIZE             = CURLOPTTYPE_LONG + 114
    CURLOPT_INFILESIZE_LARGE        = CURLOPTTYPE_OFF_T + 115
    CURLOPT_RESUME_FROM_LARGE       = CURLOPTTYPE_OFF_T + 116
    CURLOPT_MAXFILESIZE_LARGE       = CURLOPTTYPE_OFF_T + 117
    CURLOPT_NETRC_FILE              = CURLOPTTYPE_OBJECTPOINT + 118
    CURLOPT_USE_SSL                 = CURLOPTTYPE_LONG + 119
    CURLOPT_POSTFIELDSIZE_LARGE     = CURLOPTTYPE_OFF_T + 120
    CURLOPT_TCP_NODELAY             = CURLOPTTYPE_LONG + 121
    CURLOPT_FTPSSLAUTH              = CURLOPTTYPE_LONG + 129
    CURLOPT_IOCTLFUNCTION           = CURLOPTTYPE_FUNCTIONPOINT + 130
    CURLOPT_IOCTLDATA               = CURLOPTTYPE_OBJECTPOINT + 131
    CURLOPT_FTP_ACCOUNT             = CURLOPTTYPE_OBJECTPOINT + 134
    CURLOPT_COOKIELIST              = CURLOPTTYPE_OBJECTPOINT + 135
    CURLOPT_IGNORE_CONTENT_LENGTH   = CURLOPTTYPE_LONG + 136
    CURLOPT_FTP_SKIP_PASV_IP        = CURLOPTTYPE_LONG + 137
    CURLOPT_FTP_FILEMETHOD          = CURLOPTTYPE_LONG + 138
    CURLOPT_LOCALPORT               = CURLOPTTYPE_LONG + 139
    CURLOPT_LOCALPORTRANGE          = CURLOPTTYPE_LONG + 140
    CURLOPT_CONNECT_ONLY            = CURLOPTTYPE_LONG + 141
    CURLOPT_CONV_FROM_NETWORK_FUNCTION = CURLOPTTYPE_FUNCTIONPOINT + 142
    CURLOPT_CONV_TO_NETWORK_FUNCTION = CURLOPTTYPE_FUNCTIONPOINT + 143
    CURLOPT_CONV_FROM_UTF8_FUNCTION = CURLOPTTYPE_FUNCTIONPOINT + 144
    CURLOPT_MAX_SEND_SPEED_LARGE    = CURLOPTTYPE_OFF_T + 145
    CURLOPT_MAX_RECV_SPEED_LARGE    = CURLOPTTYPE_OFF_T + 146
    CURLOPT_FTP_ALTERNATIVE_TO_USER = CURLOPTTYPE_OBJECTPOINT + 147
    CURLOPT_SOCKOPTFUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 148
    CURLOPT_SOCKOPTDATA             = CURLOPTTYPE_OBJECTPOINT + 149
    CURLOPT_SSL_SESSIONID_CACHE     = CURLOPTTYPE_LONG + 150
    CURLOPT_SSH_AUTH_TYPES          = CURLOPTTYPE_LONG + 151
    CURLOPT_SSH_PUBLIC_KEYFILE      = CURLOPTTYPE_OBJECTPOINT + 152
    CURLOPT_SSH_PRIVATE_KEYFILE     = CURLOPTTYPE_OBJECTPOINT + 153
    CURLOPT_FTP_SSL_CCC             = CURLOPTTYPE_LONG + 154
    CURLOPT_TIMEOUT_MS              = CURLOPTTYPE_LONG + 155
    CURLOPT_CONNECTTIMEOUT_MS       = CURLOPTTYPE_LONG + 156
    CURLOPT_HTTP_TRANSFER_DECODING  = CURLOPTTYPE_LONG + 157
    CURLOPT_HTTP_CONTENT_DECODING   = CURLOPTTYPE_LONG + 158
    CURLOPT_NEW_FILE_PERMS          = CURLOPTTYPE_LONG + 159
    CURLOPT_NEW_DIRECTORY_PERMS     = CURLOPTTYPE_LONG + 160
    CURLOPT_POSTREDIR               = CURLOPTTYPE_LONG + 161
    CURLOPT_SSH_HOST_PUBLIC_KEY_MD5 = CURLOPTTYPE_OBJECTPOINT + 162
    CURLOPT_OPENSOCKETFUNCTION      = CURLOPTTYPE_FUNCTIONPOINT + 163
    CURLOPT_OPENSOCKETDATA          = CURLOPTTYPE_OBJECTPOINT + 164
    CURLOPT_COPYPOSTFIELDS          = CURLOPTTYPE_OBJECTPOINT + 165
    CURLOPT_PROXY_TRANSFER_MODE     = CURLOPTTYPE_LONG + 166
    CURLOPT_SEEKFUNCTION            = CURLOPTTYPE_FUNCTIONPOINT + 167
    CURLOPT_SEEKDATA                = CURLOPTTYPE_OBJECTPOINT + 168
    CURLOPT_CRLFILE                 = CURLOPTTYPE_OBJECTPOINT + 169
    CURLOPT_ISSUERCERT              = CURLOPTTYPE_OBJECTPOINT + 170
    CURLOPT_ADDRESS_SCOPE           = CURLOPTTYPE_LONG + 171
    CURLOPT_CERTINFO                = CURLOPTTYPE_LONG + 172
    CURLOPT_USERNAME                = CURLOPTTYPE_OBJECTPOINT + 173
    CURLOPT_PASSWORD                = CURLOPTTYPE_OBJECTPOINT + 174
    CURLOPT_PROXYUSERNAME           = CURLOPTTYPE_OBJECTPOINT + 175
    CURLOPT_PROXYPASSWORD           = CURLOPTTYPE_OBJECTPOINT + 176
    CURLOPT_NOPROXY                 = CURLOPTTYPE_OBJECTPOINT + 177
    CURLOPT_TFTP_BLKSIZE            = CURLOPTTYPE_LONG + 178
    CURLOPT_SOCKS5_GSSAPI_SERVICE   = CURLOPTTYPE_OBJECTPOINT + 179
    CURLOPT_SOCKS5_GSSAPI_NEC       = CURLOPTTYPE_LONG + 180
    CURLOPT_PROTOCOLS               = CURLOPTTYPE_LONG + 181
    CURLOPT_REDIR_PROTOCOLS         = CURLOPTTYPE_LONG + 182
    CURLOPT_SSH_KNOWNHOSTS          = CURLOPTTYPE_OBJECTPOINT + 183
    CURLOPT_SSH_KEYFUNCTION         = CURLOPTTYPE_FUNCTIONPOINT + 184
    CURLOPT_SSH_KEYDATA             = CURLOPTTYPE_OBJECTPOINT + 185
    CURLOPT_MAIL_FROM               = CURLOPTTYPE_OBJECTPOINT + 186
    CURLOPT_MAIL_RCPT               = CURLOPTTYPE_OBJECTPOINT + 187
    CURLOPT_FTP_USE_PRET            = CURLOPTTYPE_LONG + 188
    CURLOPT_RTSP_REQUEST            = CURLOPTTYPE_LONG + 189
    CURLOPT_RTSP_SESSION_ID         = CURLOPTTYPE_OBJECTPOINT + 190
    CURLOPT_RTSP_STREAM_URI         = CURLOPTTYPE_OBJECTPOINT + 191
    CURLOPT_RTSP_TRANSPORT          = CURLOPTTYPE_OBJECTPOINT + 192
    CURLOPT_RTSP_CLIENT_CSEQ        = CURLOPTTYPE_LONG + 193
    CURLOPT_RTSP_SERVER_CSEQ        = CURLOPTTYPE_LONG + 194
    CURLOPT_INTERLEAVEDATA          = CURLOPTTYPE_OBJECTPOINT + 195
    CURLOPT_INTERLEAVEFUNCTION      = CURLOPTTYPE_FUNCTIONPOINT + 196
    CURLOPT_WILDCARDMATCH           = CURLOPTTYPE_LONG + 197
    CURLOPT_CHUNK_BGN_FUNCTION      = CURLOPTTYPE_FUNCTIONPOINT + 198
    CURLOPT_CHUNK_END_FUNCTION      = CURLOPTTYPE_FUNCTIONPOINT + 199
    CURLOPT_FNMATCH_FUNCTION        = CURLOPTTYPE_FUNCTIONPOINT + 200
    CURLOPT_CHUNK_DATA              = CURLOPTTYPE_OBJECTPOINT + 201
    CURLOPT_FNMATCH_DATA            = CURLOPTTYPE_OBJECTPOINT + 202
    CURLOPT_RESOLVE                 = CURLOPTTYPE_OBJECTPOINT + 203
    CURLOPT_TLSAUTH_USERNAME        = CURLOPTTYPE_OBJECTPOINT + 204
    CURLOPT_TLSAUTH_PASSWORD        = CURLOPTTYPE_OBJECTPOINT + 205
    CURLOPT_TLSAUTH_TYPE            = CURLOPTTYPE_OBJECTPOINT + 206
    CURLOPT_TRANSFER_ENCODING       = CURLOPTTYPE_LONG + 207
    CURLOPT_LASTENTRY
end enum

#define CURLOPT_SERVER_RESPONSE_TIMEOUT CURLOPT_FTP_RESPONSE_TIMEOUT

#define CURL_IPRESOLVE_WHATEVER 0
#define CURL_IPRESOLVE_V4       1
#define CURL_IPRESOLVE_V6       2

#define CURLOPT_WRITEDATA CURLOPT_FILE
#define CURLOPT_READDATA  CURLOPT_INFILE
#define CURLOPT_HEADERDATA CURLOPT_WRITEHEADER
#define CURLOPT_RTSPHEADER CURLOPT_HTTPHEADER

enum
    CURL_HTTP_VERSION_NONE
    CURL_HTTP_VERSION_1_0
    CURL_HTTP_VERSION_1_1
    CURL_HTTP_VERSION_LAST
end enum

enum
    CURL_RTSPREQ_NONE
    CURL_RTSPREQ_OPTIONS
    CURL_RTSPREQ_DESCRIBE
    CURL_RTSPREQ_ANNOUNCE
    CURL_RTSPREQ_SETUP
    CURL_RTSPREQ_PLAY
    CURL_RTSPREQ_PAUSE
    CURL_RTSPREQ_TEARDOWN
    CURL_RTSPREQ_GET_PARAMETER
    CURL_RTSPREQ_SET_PARAMETER
    CURL_RTSPREQ_RECORD
    CURL_RTSPREQ_RECEIVE
    CURL_RTSPREQ_LAST
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

enum CURL_TLSAUTH
    CURL_TLSAUTH_NONE
    CURL_TLSAUTH_SRP
    CURL_TLSAUTH_LAST
end enum

#define CURL_REDIR_GET_ALL  0
#define CURL_REDIR_POST_301 1
#define CURL_REDIR_POST_302 2
#define CURL_REDIR_POST_ALL (CURL_REDIR_POST_301 or CURL_REDIR_POST_302)

enum curl_TimeCond
    CURL_TIMECOND_NONE
    CURL_TIMECOND_IFMODSINCE
    CURL_TIMECOND_IFUNMODSINCE
    CURL_TIMECOND_LASTMOD
    CURL_TIMECOND_LAST
end enum

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
    CURLFORM_STREAM
    CURLFORM_LASTENTRY
end enum

type curl_forms
    as CURLformoption option
    as const zstring ptr value
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

declare function curl_formadd _
    ( _
        byval as curl_httppost ptr ptr, _
        byval as curl_httppost ptr ptr, _
        ... _
    ) as CURLFORMcode

type curl_formget_callback as function _
    ( _
        byval as any ptr, _
        byval as const ubyte ptr, _
        byval as size_t _
    ) as size_t

declare function curl_formget _
    ( _
        byval as curl_httppost ptr, _
        byval as any ptr, _
        byval as curl_formget_callback _
    ) as integer

declare sub curl_formfree(byval as curl_httppost ptr)
declare function curl_getenv(byval as const zstring ptr) as zstring ptr
declare function curl_version() as zstring ptr
declare function curl_easy_escape _
    ( _
        byval as CURL ptr, _
        byval as const zstring ptr, _
        byval as integer _
    ) as zstring ptr
declare function curl_escape _
    ( _
        byval as const zstring ptr, _
        byval as integer _
    ) as zstring ptr
declare function curl_easy_unescape _
    ( _
        byval as CURL ptr, _
        byval as const zstring ptr, _
        byval as integer, _
        byval as integer ptr _
    ) as zstring ptr
declare function curl_unescape _
    ( _
        byval as const zstring ptr, _
        byval as integer _
    ) as zstring ptr
declare sub curl_free(byval as any ptr)
declare function curl_global_init(byval as long) as CURLcode
declare function curl_global_init_mem _
    ( _
        byval as long, _
        byval as curl_malloc_callback, _
        byval as curl_free_callback, _
        byval as curl_realloc_callback, _
        byval as curl_strdup_callback, _
        byval as curl_calloc_callback _
    ) as CURLcode

declare sub curl_global_cleanup()

type curl_slist
    as zstring ptr data
    as curl_slist ptr next
end type

declare function curl_slist_append _
    ( _
        byval as curl_slist ptr, _
        byval as const zstring ptr _
    ) as curl_slist ptr
declare sub curl_slist_free_all(byval as curl_slist ptr)
declare function curl_getdate(byval as const zstring ptr, byval as const time_t ptr) as time_t

type curl_certinfo
    as integer num_of_certs
    as curl_slist ptr ptr certinfo
end type

#define CURLINFO_STRING   &h100000
#define CURLINFO_LONG     &h200000
#define CURLINFO_DOUBLE   &h300000
#define CURLINFO_SLIST    &h400000
#define CURLINFO_MASK     &h0fffff
#define CURLINFO_TYPEMASK &hf00000

enum CURLINFO
    CURLINFO_NONE
    CURLINFO_EFFECTIVE_URL    = CURLINFO_STRING + 1
    CURLINFO_RESPONSE_CODE    = CURLINFO_LONG   + 2
    CURLINFO_TOTAL_TIME       = CURLINFO_DOUBLE + 3
    CURLINFO_NAMELOOKUP_TIME  = CURLINFO_DOUBLE + 4
    CURLINFO_CONNECT_TIME     = CURLINFO_DOUBLE + 5
    CURLINFO_PRETRANSFER_TIME = CURLINFO_DOUBLE + 6
    CURLINFO_SIZE_UPLOAD      = CURLINFO_DOUBLE + 7
    CURLINFO_SIZE_DOWNLOAD    = CURLINFO_DOUBLE + 8
    CURLINFO_SPEED_DOWNLOAD   = CURLINFO_DOUBLE + 9
    CURLINFO_SPEED_UPLOAD     = CURLINFO_DOUBLE + 10
    CURLINFO_HEADER_SIZE      = CURLINFO_LONG   + 11
    CURLINFO_REQUEST_SIZE     = CURLINFO_LONG   + 12
    CURLINFO_SSL_VERIFYRESULT = CURLINFO_LONG   + 13
    CURLINFO_FILETIME         = CURLINFO_LONG   + 14
    CURLINFO_CONTENT_LENGTH_DOWNLOAD   = CURLINFO_DOUBLE + 15
    CURLINFO_CONTENT_LENGTH_UPLOAD     = CURLINFO_DOUBLE + 16
    CURLINFO_STARTTRANSFER_TIME = CURLINFO_DOUBLE + 17
    CURLINFO_CONTENT_TYPE     = CURLINFO_STRING + 18
    CURLINFO_REDIRECT_TIME    = CURLINFO_DOUBLE + 19
    CURLINFO_REDIRECT_COUNT   = CURLINFO_LONG   + 20
    CURLINFO_PRIVATE          = CURLINFO_STRING + 21
    CURLINFO_HTTP_CONNECTCODE = CURLINFO_LONG   + 22
    CURLINFO_HTTPAUTH_AVAIL   = CURLINFO_LONG   + 23
    CURLINFO_PROXYAUTH_AVAIL  = CURLINFO_LONG   + 24
    CURLINFO_OS_ERRNO         = CURLINFO_LONG   + 25
    CURLINFO_NUM_CONNECTS     = CURLINFO_LONG   + 26
    CURLINFO_SSL_ENGINES      = CURLINFO_SLIST  + 27
    CURLINFO_COOKIELIST       = CURLINFO_SLIST  + 28
    CURLINFO_LASTSOCKET       = CURLINFO_LONG   + 29
    CURLINFO_FTP_ENTRY_PATH   = CURLINFO_STRING + 30
    CURLINFO_REDIRECT_URL     = CURLINFO_STRING + 31
    CURLINFO_PRIMARY_IP       = CURLINFO_STRING + 32
    CURLINFO_APPCONNECT_TIME  = CURLINFO_DOUBLE + 33
    CURLINFO_CERTINFO         = CURLINFO_SLIST  + 34
    CURLINFO_CONDITION_UNMET  = CURLINFO_LONG   + 35
    CURLINFO_RTSP_SESSION_ID  = CURLINFO_STRING + 36
    CURLINFO_RTSP_CLIENT_CSEQ = CURLINFO_LONG   + 37
    CURLINFO_RTSP_SERVER_CSEQ = CURLINFO_LONG   + 38
    CURLINFO_RTSP_CSEQ_RECV   = CURLINFO_LONG   + 39
    CURLINFO_PRIMARY_PORT     = CURLINFO_LONG   + 40
    CURLINFO_LOCAL_IP         = CURLINFO_STRING + 41
    CURLINFO_LOCAL_PORT       = CURLINFO_LONG   + 42
    CURLINFO_LASTONE          = 42
end enum

#define CURLINFO_HTTP_CODE CURLINFO_RESPONSE_CODE

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
#define CURL_GLOBAL_ALL (CURL_GLOBAL_SSL or CURL_GLOBAL_WIN32)
#define CURL_GLOBAL_NOTHING 0
#define CURL_GLOBAL_DEFAULT CURL_GLOBAL_ALL

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

type curl_lock_function as sub _
    ( _
        byval as CURL ptr, _
        byval as curl_lock_data, _
        byval as curl_lock_access, _
        byval as any ptr _
    )
type curl_unlock_function as sub _
    ( _
        byval as CURL ptr, _
        byval as curl_lock_data, _
        byval as any ptr _
    )
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

declare function curl_share_init() as CURLSH ptr
declare function curl_share_setopt _
    ( _
        byval as CURLSH ptr, _
        byval as CURLSHoption, _
        ... _
    ) as CURLSHcode
declare function curl_share_cleanup(byval as CURLSH ptr) as CURLSHcode

enum CURLversion
    CURLVERSION_FIRST
    CURLVERSION_SECOND
    CURLVERSION_THIRD
    CURLVERSION_FOURTH
    CURLVERSION_LAST
end enum

#define CURLVERSION_NOW CURLVERSION_FOURTH

type curl_version_info_data
    as CURLversion age
    as const zstring ptr version
    as uinteger version_num
    as const zstring ptr host
    as integer features
    as const zstring ptr ssl_version
    as long ssl_version_num
    as const zstring ptr libz_version
    as const zstring const ptr ptr protocols
    as const zstring ptr ares
    as integer ares_num
    as const zstring ptr libidn
    as integer iconv_ver_num
    as const zstring ptr libssh_version
end type

#define CURL_VERSION_IPV6      (1 shl 0)
#define CURL_VERSION_KERBEROS4 (1 shl 1)
#define CURL_VERSION_SSL       (1 shl 2)
#define CURL_VERSION_LIBZ      (1 shl 3)
#define CURL_VERSION_NTLM      (1 shl 4)
#define CURL_VERSION_GSSNEGOTIATE (1 shl 5)
#define CURL_VERSION_DEBUG     (1 shl 6)
#define CURL_VERSION_ASYNCHDNS (1 shl 7)
#define CURL_VERSION_SPNEGO    (1 shl 8)
#define CURL_VERSION_LARGEFILE (1 shl 9)
#define CURL_VERSION_IDN       (1 shl 10)
#define CURL_VERSION_SSPI      (1 shl 11)
#define CURL_VERSION_CONV      (1 shl 12)
#define CURL_VERSION_CURLDEBUG (1 shl 13)
#define CURL_VERSION_TLSAUTH_SRP (1 shl 14)

declare function curl_version_info(byval as CURLversion) as curl_version_info_data ptr
declare function curl_easy_strerror(byval as CURLcode) as const zstring ptr
declare function curl_share_strerror(byval as CURLSHcode) as const zstring ptr
declare function curl_easy_pause(byval as CURL ptr, byval as integer) as CURLcode

#define CURLPAUSE_RECV      (1 shl 0)
#define CURLPAUSE_RECV_CONT (0)
#define CURLPAUSE_SEND      (1 shl 2)
#define CURLPAUSE_SEND_CONT (0)
#define CURLPAUSE_ALL       (CURLPAUSE_RECV or CURLPAUSE_SEND)
#define CURLPAUSE_CONT      (CURLPAUSE_RECV_CONT or CURLPAUSE_SEND_CONT)

declare function curl_easy_init() as CURL ptr
declare function curl_easy_setopt _
    ( _
        byval as CURL ptr, _
        byval as CURLoption, _
        ... _
    ) as CURLcode
declare function curl_easy_perform(byval as CURL ptr) as CURLcode
declare sub curl_easy_cleanup(byval as CURL ptr)
declare function curl_easy_getinfo _
    ( _
        byval as CURL ptr, _
        byval as CURLINFO, _
        ... _
    ) as CURLcode
declare function curl_easy_duphandle(byval as CURL ptr) as CURL ptr
declare sub curl_easy_reset(byval as CURL ptr)
declare function curl_easy_recv _
    ( _
        byval as CURL ptr, _
        byval as any ptr, _
        byval as size_t, _
        byval as size_t ptr _
    ) as CURLcode
declare function curl_easy_send _
    ( _
        byval as CURL ptr, _
        byval as const any ptr, _
        byval as size_t, _
        byval as size_t ptr _
    ) as CURLcode

type CURLM as any

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

#define CURLM_CALL_MULTI_SOCKET CURLM_CALL_MULTI_PERFORM

enum CURLMSG_enum
    CURLMSG_NONE
    CURLMSG_DONE
    CURLMSG_LAST
end enum

type CURLMsg_data
    union
        as any ptr whatever
        as CURLcode result
    end union
end type

type CURLMsg
    as CURLMSG_enum msg
    as CURL ptr easy_handle
    as CURLMsg_data data
end type

declare function curl_multi_init() as CURLM ptr
declare function curl_multi_add_handle _
    ( _
        byval as CURLM ptr, _
        byval as CURL ptr _
    ) as CURLMcode
declare function curl_multi_remove_handle _
    ( _
        byval as CURLM ptr, _
        byval as CURL ptr _
    ) as CURLMcode
declare function curl_multi_fdset _
    ( _
        byval as CURLM ptr, _
        byval as fd_set ptr, _
        byval as fd_set ptr, _
        byval as fd_set ptr, _
        byval as integer ptr _
    ) as CURLMcode
declare function curl_multi_perform _
    ( _
        byval as CURLM ptr, _
        byval as integer ptr _
    ) as CURLMcode
declare function curl_multi_cleanup(byval as CURLM ptr) as CURLMcode
declare function curl_multi_info_read _
    ( _
        byval as CURLM ptr, _
        byval as integer ptr _
    ) as CURLMsg ptr
declare function curl_multi_strerror(byval as CURLMcode) as const zstring ptr

#define CURL_POLL_NONE   0
#define CURL_POLL_IN     1
#define CURL_POLL_OUT    2
#define CURL_POLL_INOUT  3
#define CURL_POLL_REMOVE 4

#define CURL_SOCKET_TIMEOUT CURL_SOCKET_BAD

#define CURL_CSELECT_IN   &h01
#define CURL_CSELECT_OUT  &h02
#define CURL_CSELECT_ERR  &h04

type curl_socket_callback as function _
    ( _
        byval as CURL ptr, _
        byval as curl_socket_t, _
        byval as integer, _
        byval as any ptr, _
        byval as any ptr _
    ) as integer

type curl_multi_timer_callback as function _
    ( _
        byval as CURLM ptr, _
        byval as long, _
        byval as any ptr _
    ) as integer

/'
declare function curl_multi_socket _
    ( _
        byval as CURLM ptr, _
        byval as curl_socket_t, _
        byval as integer ptr _
    ) as CURLMcode
'/

declare function curl_multi_socket_action _
    ( _
        byval as CURLM ptr, _
        byval as curl_socket_t, _
        byval as integer, _
        byval as integer ptr _
    ) as CURLMcode

declare function curl_multi_socket_all _
    ( _
        byval as CURLM ptr, _
        byval as integer ptr _
    ) as CURLMcode

#define curl_multi_socket(x,y,z) curl_multi_socket_action(x,y,0,z)

declare function curl_multi_timeout _
    ( _
        byval as CURLM ptr, _
        byval as long ptr _
    ) as CURLMcode

enum CURLMoption
    CURLMOPT_SOCKETFUNCTION     = CURLOPTTYPE_FUNCTIONPOINT + 1
    CURLMOPT_SOCKETDATA         = CURLOPTTYPE_OBJECTPOINT + 2
    CURLMOPT_PIPELINING         = CURLOPTTYPE_LONG + 3
    CURLMOPT_TIMERFUNCTION      = CURLOPTTYPE_FUNCTIONPOINT + 4
    CURLMOPT_TIMERDATA          = CURLOPTTYPE_OBJECTPOINT + 5
    CURLMOPT_MAXCONNECTS        = CURLOPTTYPE_LONG + 6
    CURLMOPT_LASTENTRY
end enum

declare function curl_multi_setopt _
    ( _
        byval as CURLM ptr, _
        byval as CURLMoption, _
        ... _
    ) as CURLMcode

declare function curl_multi_assign _
    ( _
        byval as CURLM ptr, _
        byval as curl_socket_t, _
        byval as any ptr _
    ) as CURLMcode

end extern

#endif
