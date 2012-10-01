#ifndef __CURL_BI__
#define __CURL_BI__

/'**************************************************************************
 *                                  _   _ ____  _
 *  Project                     ___| | | |  _ \| |
 *                             / __| | | | |_) | |
 *                            | (__| |_| |  _ <| |___
 *                             \___|\___/|_| \_\_____|
 *
 * Copyright (C) 1998 - 2012, Daniel Stenberg, <daniel@haxx.se>, et al.
 *
 * This software is licensed as described in the file COPYING, which
 * you should have received as part of this distribution. The terms
 * are also available at http://curl.haxx.se/docs/copyright.html.
 *
 * You may opt to use, copy, modify, merge, publish, distribute and/or sell
 * copies of the Software, and permit persons to whom the Software is
 * furnished to do so, under the terms of the COPYING file.
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY OF ANY
 * KIND, either express or implied.
 *
 **************************************************************************'/

/'
 * If you have libcurl problems, all docs and details are found here:
 *   http://curl.haxx.se/libcurl/
 *
 * curl-library mailing list subscription and unsubscription web interface:
 *   http://cool.haxx.se/mailman/listinfo/curl-library/
 '/

#inclib "curl"

/' This is the global package copyright '/
#define LIBCURL_COPYRIGHT "1996 - 2011 Daniel Stenberg, <daniel@haxx.se>."

/' This is the version number of the libcurl package from which this header
   file origins: '/
#define LIBCURL_VERSION "7.24.0"

/' The numeric version number is also available "in parts" by using these
   defines: '/
#define LIBCURL_VERSION_MAJOR 7
#define LIBCURL_VERSION_MINOR 24
#define LIBCURL_VERSION_PATCH 0

/' This is the numeric version of the libcurl version number, meant for easier
   parsing and comparions by programs. The LIBCURL_VERSION_NUM define will
   always follow this syntax:

         0xXXYYZZ

   Where XX, YY and ZZ are the main version, release and patch numbers in
   hexadecimal (using 8 bits each). All three numbers are always represented
   using two digits.  1.2 would appear as "0x010200" while version 9.11.7
   appears as "0x090b07".

   This 6-digit (24 bits) hexadecimal number does not show pre-release number,
   and it is always a greater number in a more recent release. It makes
   comparisons with greater than and less than work.
'/
#define LIBCURL_VERSION_NUM &h071800

/'
 * This is the date and time when the full source package was created. The
 * timestamp is not stored in git, as the timestamp is properly set in the
 * tarballs by the maketgz script.
 *
 * The format of the date should follow this template:
 *
 * "Mon Feb 12 11:35:33 UTC 2007"
 '/
#define LIBCURL_TIMESTAMP "Tue Jan 24 08:58:51 UTC 2012"

#ifdef __FB_DOS__
#define CURL_FORMAT_CURL_OFF_T     "lld"
#define CURL_FORMAT_CURL_OFF_TU    "llu"
#define CURL_FORMAT_OFF_T          "%lld"
#define CURL_TYPEOF_CURL_SOCKLEN_T integer

#elseif defined(__FB_WIN32__)
#define CURL_FORMAT_CURL_OFF_T     "I64d"
#define CURL_FORMAT_CURL_OFF_TU    "I64u"
#define CURL_FORMAT_OFF_T          "%I64d"
#define CURL_TYPEOF_CURL_SOCKLEN_T integer

#else
#define CURL_FORMAT_CURL_OFF_T     "lld"
#define CURL_FORMAT_CURL_OFF_TU    "llu"
#define CURL_FORMAT_OFF_T          "%lld"
#define CURL_TYPEOF_CURL_SOCKLEN_T socklen_t

#endif

#ifdef CURL_NO_OLDIES
#undef CURL_FORMAT_OFF_T /' not required since 7.19.0 - obsoleted in 7.20.0 '/
#endif

#ifdef __FB_WIN32__
    #include once "win/winsock2.bi"
#else
    #include once "crt/sys/socket.bi"
#endif
#include once "crt/sys/time.bi"
#include once "crt/sys/types.bi"

type as CURL_TYPEOF_CURL_SOCKLEN_T curl_socklen_t
type as longint curl_off_t

extern "C"

type as any CURL

#ifdef __FB_WIN32__
    type as SOCKET curl_socket_t
    #define CURL_SOCKET_BAD INVALID_SOCKET
#else
    type as integer curl_socket_t
    #define CURL_SOCKET_BAD (-1)
#endif

type curl_slist_ as curl_slist

type curl_httppost
  as curl_httppost ptr next         /' next entry in the list '/
  as byte ptr name                  /' pointer to allocated name '/
  as long namelength                /' length of name length '/
  as byte ptr contents              /' pointer to allocated data contents '/
  as long contentslength            /' length of contents field '/
  as byte ptr buffer                /' pointer to allocated buffer contents '/
  as long bufferlength              /' length of buffer field '/
  as zstring ptr contenttype        /' Content-Type '/
  as curl_slist_ ptr contentheader  /' list of extra headers for this form '/
  as curl_httppost ptr more         /' if one field name has more than one
                                       file, this link should link to following
                                       files '/
  as long flags                     /' as defined below '/
#define HTTPPOST_FILENAME (1 shl 0) /' specified content is a file name '/
#define HTTPPOST_READFILE (1 shl 1) /' specified content is a file name '/
#define HTTPPOST_PTRNAME (1 shl 2)  /' name is only stored pointer
                                       do not free in formfree '/
#define HTTPPOST_PTRCONTENTS (1 shl 3) /' contents is only stored pointer
                                          do not free in formfree '/
#define HTTPPOST_BUFFER (1 shl 4)      /' upload file from buffer '/
#define HTTPPOST_PTRBUFFER (1 shl 5)   /' upload file from pointer contents '/
#define HTTPPOST_CALLBACK (1 shl 6) /' upload file contents by using the
                                       regular read callback to get the data
                                       and pass the given pointer as custom
                                       pointer '/

  as zstring ptr showfilename       /' The file name to show. If not set, the
                                       actual file name will be used (if this
                                       is a file part) '/
  as any ptr userp                  /' custom pointer used for
                                       HTTPPOST_CALLBACK posts '/
end type

type as function(byval clientp as any ptr, _
                 byval dltotal as double, _
                 byval dlnow as double, _
                 byval ultotal as double, _
                 byval ulnow as double) as integer curl_progress_callback

#ifndef CURL_MAX_WRITE_SIZE
  /' Tests have proven that 20K is a very bad buffer size for uploads on
     Windows, while 16K for some odd reason performed a lot better.
     We do the ifndef check to allow this value to easier be changed at build
     time for those who feel adventurous. The practical minimum is about
     400 bytes since libcurl uses a buffer of this size as a scratch area
     (unrelated to network send operations). '/
#define CURL_MAX_WRITE_SIZE 16384
#endif

#ifndef CURL_MAX_HTTP_HEADER
/' The only reason to have a max limit for this is to avoid the risk of a bad
   server feeding libcurl with a never-ending header that will cause reallocs
   infinitely '/
#define CURL_MAX_HTTP_HEADER (100*1024)
#endif

/' This is a magic return code for the write callback that, when returned,
   will signal libcurl to pause receiving on the current transfer. '/
#define CURL_WRITEFUNC_PAUSE &h10000001

type as function(byval buffer as byte ptr, _
                 byval size as size_t, _
                 byval nitems as size_t, _
                 byval outstream as any ptr) as size_t curl_write_callback

/' enumeration of file types '/
enum curlfiletype
  CURLFILETYPE_FILE = 0
  CURLFILETYPE_DIRECTORY
  CURLFILETYPE_SYMLINK
  CURLFILETYPE_DEVICE_BLOCK
  CURLFILETYPE_DEVICE_CHAR
  CURLFILETYPE_NAMEDPIPE
  CURLFILETYPE_SOCKET
  CURLFILETYPE_DOOR /' is possible only on Sun Solaris now '/

  CURLFILETYPE_UNKNOWN /' should never occur '/
end enum

#define CURLFINFOFLAG_KNOWN_FILENAME    (1 shl 0)
#define CURLFINFOFLAG_KNOWN_FILETYPE    (1 shl 1)
#define CURLFINFOFLAG_KNOWN_TIME        (1 shl 2)
#define CURLFINFOFLAG_KNOWN_PERM        (1 shl 3)
#define CURLFINFOFLAG_KNOWN_UID         (1 shl 4)
#define CURLFINFOFLAG_KNOWN_GID         (1 shl 5)
#define CURLFINFOFLAG_KNOWN_SIZE        (1 shl 6)
#define CURLFINFOFLAG_KNOWN_HLINKCOUNT  (1 shl 7)

/' Content of this structure depends on information which is known and is
   achievable (e.g. by FTP LIST parsing). Please see the url_easy_setopt(3) man
   page for callbacks returning this structure -- some fields are mandatory,
   some others are optional. The FLAG field has special meaning. '/

type curl_fileinfo_strings
  /' If some of these fields is not NULL, it is a pointer to b_data. '/
  as zstring ptr time
  as zstring ptr perm
  as zstring ptr user
  as zstring ptr group
  as zstring ptr target /' pointer to the target filename of a symlink '/
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

  /' used internally '/
  as byte ptr b_data
  as size_t b_size
  as size_t b_used
end type

/' return codes for CURLOPT_CHUNK_BGN_FUNCTION '/
#define CURL_CHUNK_BGN_FUNC_OK      0
#define CURL_CHUNK_BGN_FUNC_FAIL    1 /' tell the lib to end the task '/
#define CURL_CHUNK_BGN_FUNC_SKIP    2 /' skip this chunk over '/

/' if splitting of data transfer is enabled, this callback is called before
   download of an individual chunk started. Note that parameter "remains" works
   only for FTP wildcard downloading (for now), otherwise is not used '/
type as function(byval transfer_info as const any ptr, _
                 byval ptr as any ptr, _
                 byval remains as integer) as long curl_chunk_bgn_callback

/' return codes for CURLOPT_CHUNK_END_FUNCTION '/
#define CURL_CHUNK_END_FUNC_OK      0
#define CURL_CHUNK_END_FUNC_FAIL    1 /' tell the lib to end the task '/

/' If splitting of data transfer is enabled this callback is called after
   download of an individual chunk finished.
   Note! After this callback was set then it have to be called FOR ALL chunks.
   Even if downloading of this chunk was skipped in CHUNK_BGN_FUNC.
   This is the reason why we don't need "transfer_info" parameter in this
   callback and we are not interested in "remains" parameter too. '/
type as function(byval ptr as any ptr) as long curl_chunk_end_callback

/' return codes for FNMATCHFUNCTION '/
#define CURL_FNMATCHFUNC_MATCH    0 /' string corresponds to the pattern '/
#define CURL_FNMATCHFUNC_NOMATCH  1 /' pattern doesn't match the string '/
#define CURL_FNMATCHFUNC_FAIL     2 /' an error occurred '/

/' callback type for wildcard downloading pattern matching. If the
   string matches the pattern, return CURL_FNMATCHFUNC_MATCH value, etc. '/
type as function(byval ptr as any ptr, _
                 byval pattern as const zstring ptr, _
                 byval string as const zstring ptr) as integer curl_fnmatch_callback

/' These are the return codes for the seek callbacks '/
#define CURL_SEEKFUNC_OK       0
#define CURL_SEEKFUNC_FAIL     1 /' fail the entire transfer '/
#define CURL_SEEKFUNC_CANTSEEK 2 /' tell libcurl seeking can't be done, so
                                    libcurl might try other means instead '/
type as function(byval instream as any ptr, _
                 byval offset as curl_off_t, _
                 byval origin as integer) as integer curl_seek_callback /' 'whence' '/

/' This is a return code for the read callback that, when returned, will
   signal libcurl to immediately abort the current transfer. '/
#define CURL_READFUNC_ABORT &h10000000
/' This is a return code for the read callback that, when returned, will
   signal libcurl to pause sending data on the current transfer. '/
#define CURL_READFUNC_PAUSE &h10000001

type as function(byval buffer as byte ptr, _
                 byval size as size_t, _
                 byval nitems as size_t, _
                 byval instream as any ptr) as size_t curl_read_callback

enum  curlsocktype
  CURLSOCKTYPE_IPCXN /' socket created for a specific IP connection '/
  CURLSOCKTYPE_LAST   /' never use '/
end enum

/' The return code from the sockopt_callback can signal information back
   to libcurl: '/
#define CURL_SOCKOPT_OK 0
#define CURL_SOCKOPT_ERROR 1 /' causes libcurl to abort and return
                                CURLE_ABORTED_BY_CALLBACK '/
#define CURL_SOCKOPT_ALREADY_CONNECTED 2

type as function(byval clientp as any ptr, _
                 byval curlfd as curl_socket_t, _
                 byval purpose as curlsocktype) as integer curl_sockopt_callback

type curl_sockaddr
  as integer family
  as integer socktype
  as integer protocol
  as uinteger addrlen   /' addrlen was a socklen_t type before 7.18.0 but it
                           turned really ugly and painful on the systems that
                           lack this type '/
  as sockaddr addr
end type

type as function(byval clientp as any ptr, _
                 byval purpose as curlsocktype, _
                 byval address as curl_sockaddr ptr) as curl_socket_t curl_opensocket_callback

type as function(byval clientp as any ptr, byval item as curl_socket_t) as integer curl_closesocket_callback

enum curlioerr
  CURLIOE_OK            /' I/O operation successful '/
  CURLIOE_UNKNOWNCMD    /' command was unknown to callback '/
  CURLIOE_FAILRESTART   /' failed to restart the read '/
  CURLIOE_LAST           /' never use '/
end enum

enum  curliocmd
  CURLIOCMD_NOP         /' no operation '/
  CURLIOCMD_RESTARTREAD /' restart the read stream from start '/
  CURLIOCMD_LAST         /' never use '/
end enum

type as function(byval handle as CURL ptr, _
                 byval cmd as integer, _
                 byval clientp as any ptr) as curlioerr curl_ioctl_callback

/'
 * The following typedef's are signatures of malloc, free, realloc, strdup and
 * calloc respectively.  Function pointers of these types can be passed to the
 * curl_global_init_mem() function to set user defined memory management
 * callback routines.
 '/
type as function(byval size as size_t) as any ptr curl_malloc_callback
type as sub(byval ptr as any ptr) curl_free_callback
type as function(byval ptr as any ptr, byval size as size_t) as any ptr curl_realloc_callback
type as function(byval str as const zstring ptr) as zstring ptr curl_strdup_callback
type as function(byval nmemb as size_t, byval size as size_t) as any ptr curl_calloc_callback

/' the kind of data that is passed to information_callback'/
enum curl_infotype
  CURLINFO_TEXT = 0
  CURLINFO_HEADER_IN    /' 1 '/
  CURLINFO_HEADER_OUT   /' 2 '/
  CURLINFO_DATA_IN      /' 3 '/
  CURLINFO_DATA_OUT     /' 4 '/
  CURLINFO_SSL_DATA_IN  /' 5 '/
  CURLINFO_SSL_DATA_OUT /' 6 '/
  CURLINFO_END
end enum

type as function(byval handle as CURL ptr,      /' the handle/transfer this concerns '/ _
                 byval type as curl_infotype,   /' what kind of data '/ _
                 byval data as byte ptr,        /' points to the data '/ _
                 byval size as size_t,          /' size of the data pointed to '/ _
                 byval userptr as any ptr) as integer curl_debug_callback    /' whatever the user please '/

/' All possible error codes from all sorts of curl functions. Future versions
   may return other values, stay prepared.

   Always add new return codes last. Never *EVER* remove any. The return
   codes must remain the same!
 '/

enum CURLcode
  CURLE_OK = 0
  CURLE_UNSUPPORTED_PROTOCOL    /' 1 '/
  CURLE_FAILED_INIT             /' 2 '/
  CURLE_URL_MALFORMAT           /' 3 '/
  CURLE_NOT_BUILT_IN            /' 4 - [was obsoleted in August 2007 for
                                    7.17.0, reused in April 2011 for 7.21.5] '/
  CURLE_COULDNT_RESOLVE_PROXY   /' 5 '/
  CURLE_COULDNT_RESOLVE_HOST    /' 6 '/
  CURLE_COULDNT_CONNECT         /' 7 '/
  CURLE_FTP_WEIRD_SERVER_REPLY  /' 8 '/
  CURLE_REMOTE_ACCESS_DENIED    /' 9 a service was denied by the server
                                    due to lack of access - when login fails
                                    this is not returned. '/
  CURLE_FTP_ACCEPT_FAILED       /' 10 - [was obsoleted in April 2006 for
                                    7.15.4, reused in Dec 2011 for 7.24.0]'/
  CURLE_FTP_WEIRD_PASS_REPLY    /' 11 '/
  CURLE_FTP_ACCEPT_TIMEOUT      /' 12 - timeout occurred accepting server
                                    [was obsoleted in August 2007 for 7.17.0,
                                    reused in Dec 2011 for 7.24.0]'/
  CURLE_FTP_WEIRD_PASV_REPLY    /' 13 '/
  CURLE_FTP_WEIRD_227_FORMAT    /' 14 '/
  CURLE_FTP_CANT_GET_HOST       /' 15 '/
  CURLE_OBSOLETE16              /' 16 - NOT USED '/
  CURLE_FTP_COULDNT_SET_TYPE    /' 17 '/
  CURLE_PARTIAL_FILE            /' 18 '/
  CURLE_FTP_COULDNT_RETR_FILE   /' 19 '/
  CURLE_OBSOLETE20              /' 20 - NOT USED '/
  CURLE_QUOTE_ERROR             /' 21 - quote command failure '/
  CURLE_HTTP_RETURNED_ERROR     /' 22 '/
  CURLE_WRITE_ERROR             /' 23 '/
  CURLE_OBSOLETE24              /' 24 - NOT USED '/
  CURLE_UPLOAD_FAILED           /' 25 - failed upload "command" '/
  CURLE_READ_ERROR              /' 26 - couldn't open/read from file '/
  CURLE_OUT_OF_MEMORY           /' 27 '/
  /' Note: CURLE_OUT_OF_MEMORY may sometimes indicate a conversion error
           instead of a memory allocation error if CURL_DOES_CONVERSIONS
           is defined
  '/
  CURLE_OPERATION_TIMEDOUT      /' 28 - the timeout time was reached '/
  CURLE_OBSOLETE29              /' 29 - NOT USED '/
  CURLE_FTP_PORT_FAILED         /' 30 - FTP PORT operation failed '/
  CURLE_FTP_COULDNT_USE_REST    /' 31 - the REST command failed '/
  CURLE_OBSOLETE32              /' 32 - NOT USED '/
  CURLE_RANGE_ERROR             /' 33 - RANGE "command" didn't work '/
  CURLE_HTTP_POST_ERROR         /' 34 '/
  CURLE_SSL_CONNECT_ERROR       /' 35 - wrong when connecting with SSL '/
  CURLE_BAD_DOWNLOAD_RESUME     /' 36 - couldn't resume download '/
  CURLE_FILE_COULDNT_READ_FILE  /' 37 '/
  CURLE_LDAP_CANNOT_BIND        /' 38 '/
  CURLE_LDAP_SEARCH_FAILED      /' 39 '/
  CURLE_OBSOLETE40              /' 40 - NOT USED '/
  CURLE_FUNCTION_NOT_FOUND      /' 41 '/
  CURLE_ABORTED_BY_CALLBACK     /' 42 '/
  CURLE_BAD_FUNCTION_ARGUMENT   /' 43 '/
  CURLE_OBSOLETE44              /' 44 - NOT USED '/
  CURLE_INTERFACE_FAILED        /' 45 - CURLOPT_INTERFACE failed '/
  CURLE_OBSOLETE46              /' 46 - NOT USED '/
  CURLE_TOO_MANY_REDIRECTS      /' 47 - catch endless re-direct loops '/
  CURLE_UNKNOWN_OPTION          /' 48 - User specified an unknown option '/
  CURLE_TELNET_OPTION_SYNTAX    /' 49 - Malformed telnet option '/
  CURLE_OBSOLETE50              /' 50 - NOT USED '/
  CURLE_PEER_FAILED_VERIFICATION /' 51 - peer's certificate or fingerprint
                                     wasn't verified fine '/
  CURLE_GOT_NOTHING             /' 52 - when this is a specific error '/
  CURLE_SSL_ENGINE_NOTFOUND     /' 53 - SSL crypto engine not found '/
  CURLE_SSL_ENGINE_SETFAILED    /' 54 - can not set SSL crypto engine as
                                    default '/
  CURLE_SEND_ERROR              /' 55 - failed sending network data '/
  CURLE_RECV_ERROR              /' 56 - failure in receiving network data '/
  CURLE_OBSOLETE57              /' 57 - NOT IN USE '/
  CURLE_SSL_CERTPROBLEM         /' 58 - problem with the local certificate '/
  CURLE_SSL_CIPHER              /' 59 - couldn't use specified cipher '/
  CURLE_SSL_CACERT              /' 60 - problem with the CA cert (path?) '/
  CURLE_BAD_CONTENT_ENCODING    /' 61 - Unrecognized/bad encoding '/
  CURLE_LDAP_INVALID_URL        /' 62 - Invalid LDAP URL '/
  CURLE_FILESIZE_EXCEEDED       /' 63 - Maximum file size exceeded '/
  CURLE_USE_SSL_FAILED          /' 64 - Requested FTP SSL level failed '/
  CURLE_SEND_FAIL_REWIND        /' 65 - Sending the data requires a rewind
                                    that failed '/
  CURLE_SSL_ENGINE_INITFAILED   /' 66 - failed to initialise ENGINE '/
  CURLE_LOGIN_DENIED            /' 67 - user, password or similar was not
                                    accepted and we failed to login '/
  CURLE_TFTP_NOTFOUND           /' 68 - file not found on server '/
  CURLE_TFTP_PERM               /' 69 - permission problem on server '/
  CURLE_REMOTE_DISK_FULL        /' 70 - out of disk space on server '/
  CURLE_TFTP_ILLEGAL            /' 71 - Illegal TFTP operation '/
  CURLE_TFTP_UNKNOWNID          /' 72 - Unknown transfer ID '/
  CURLE_REMOTE_FILE_EXISTS      /' 73 - File already exists '/
  CURLE_TFTP_NOSUCHUSER         /' 74 - No such user '/
  CURLE_CONV_FAILED             /' 75 - conversion failed '/
  CURLE_CONV_REQD               /' 76 - caller must register conversion
                                    callbacks using curl_easy_setopt options
                                    CURLOPT_CONV_FROM_NETWORK_FUNCTION,
                                    CURLOPT_CONV_TO_NETWORK_FUNCTION, and
                                    CURLOPT_CONV_FROM_UTF8_FUNCTION '/
  CURLE_SSL_CACERT_BADFILE      /' 77 - could not load CACERT file, missing
                                    or wrong format '/
  CURLE_REMOTE_FILE_NOT_FOUND   /' 78 - remote file not found '/
  CURLE_SSH                     /' 79 - error from the SSH layer, somewhat
                                    generic so the error message will be of
                                    interest when this has happened '/

  CURLE_SSL_SHUTDOWN_FAILED     /' 80 - Failed to shut down the SSL
                                    connection '/
  CURLE_AGAIN                   /' 81 - socket is not ready for send/recv,
                                    wait till it's ready and try again (Added
                                    in 7.18.2) '/
  CURLE_SSL_CRL_BADFILE         /' 82 - could not load CRL file, missing or
                                    wrong format (Added in 7.19.0) '/
  CURLE_SSL_ISSUER_ERROR        /' 83 - Issuer check failed.  (Added in
                                    7.19.0) '/
  CURLE_FTP_PRET_FAILED         /' 84 - a PRET command failed '/
  CURLE_RTSP_CSEQ_ERROR         /' 85 - mismatch of RTSP CSeq numbers '/
  CURLE_RTSP_SESSION_ERROR      /' 86 - mismatch of RTSP Session Ids '/
  CURLE_FTP_BAD_FILE_LIST       /' 87 - unable to parse FTP file list '/
  CURLE_CHUNK_FAILED            /' 88 - chunk callback reported error '/
  CURL_LAST /' never use! '/
end enum

#ifndef CURL_NO_OLDIES /' define this to test if your app builds with all
                          the obsolete stuff removed! '/

/' Previously obsoletes error codes re-used in 7.24.0 '/
#define CURLE_OBSOLETE10 CURLE_FTP_ACCEPT_FAILED
#define CURLE_OBSOLETE12 CURLE_FTP_ACCEPT_TIMEOUT

/'  compatibility with older names '/
#define CURLOPT_ENCODING CURLOPT_ACCEPT_ENCODING

/' The following were added in 7.21.5, April 2011 '/
#define CURLE_UNKNOWN_TELNET_OPTION CURLE_UNKNOWN_OPTION

/' The following were added in 7.17.1 '/
/' These are scheduled to disappear by 2009 '/
#define CURLE_SSL_PEER_CERTIFICATE CURLE_PEER_FAILED_VERIFICATION

/' The following were added in 7.17.0 '/
/' These are scheduled to disappear by 2009 '/
#define CURLE_OBSOLETE CURLE_OBSOLETE50 /' no one should be using this! '/
#define CURLE_BAD_PASSWORD_ENTERED CURLE_OBSOLETE46
#define CURLE_BAD_CALLING_ORDER CURLE_OBSOLETE44
#define CURLE_FTP_USER_PASSWORD_INCORRECT CURLE_OBSOLETE10
#define CURLE_FTP_CANT_RECONNECT CURLE_OBSOLETE16
#define CURLE_FTP_COULDNT_GET_SIZE CURLE_OBSOLETE32
#define CURLE_FTP_COULDNT_SET_ASCII CURLE_OBSOLETE29
#define CURLE_FTP_WEIRD_USER_REPLY CURLE_OBSOLETE12
#define CURLE_FTP_WRITE_ERROR CURLE_OBSOLETE20
#define CURLE_LIBRARY_NOT_FOUND CURLE_OBSOLETE40
#define CURLE_MALFORMAT_USER CURLE_OBSOLETE24
#define CURLE_SHARE_IN_USE CURLE_OBSOLETE57
#define CURLE_URL_MALFORMAT_USER CURLE_NOT_BUILT_IN

#define CURLE_FTP_ACCESS_DENIED CURLE_REMOTE_ACCESS_DENIED
#define CURLE_FTP_COULDNT_SET_BINARY CURLE_FTP_COULDNT_SET_TYPE
#define CURLE_FTP_QUOTE_ERROR CURLE_QUOTE_ERROR
#define CURLE_TFTP_DISKFULL CURLE_REMOTE_DISK_FULL
#define CURLE_TFTP_EXISTS CURLE_REMOTE_FILE_EXISTS
#define CURLE_HTTP_RANGE_ERROR CURLE_RANGE_ERROR
#define CURLE_FTP_SSL_FAILED CURLE_USE_SSL_FAILED

/' The following were added earlier '/

#define CURLE_OPERATION_TIMEOUTED CURLE_OPERATION_TIMEDOUT

#define CURLE_HTTP_NOT_FOUND CURLE_HTTP_RETURNED_ERROR
#define CURLE_HTTP_PORT_FAILED CURLE_INTERFACE_FAILED
#define CURLE_FTP_COULDNT_STOR_FILE CURLE_UPLOAD_FAILED

#define CURLE_FTP_PARTIAL_FILE CURLE_PARTIAL_FILE
#define CURLE_FTP_BAD_DOWNLOAD_RESUME CURLE_BAD_DOWNLOAD_RESUME

/' This was the error code 50 in 7.7.3 and a few earlier versions, this
   is no longer used by libcurl but is instead #defined here only to not
   make programs break '/
#define CURLE_ALREADY_COMPLETE 99999

#endif /'!CURL_NO_OLDIES'/

/' This prototype applies to all conversion callbacks '/
type as function(byval buffer as byte ptr, byval length as size_t) as CURLcode curl_conv_callback

type as function(byval curl as CURL ptr,    /' easy handle '/ _
                 byval ssl_ctx as any ptr, /' actually an OpenSSL SSL_CTX '/ _
                 byval userptr as any ptr) as CURLcode curl_ssl_ctx_callback

enum curl_proxytype
  CURLPROXY_HTTP = 0    /' added in 7.10, new in 7.19.4 default is to use
                           CONNECT HTTP/1.1 '/
  CURLPROXY_HTTP_1_0 = 1    /' added in 7.19.4, force to use CONNECT
                               HTTP/1.0  '/
  CURLPROXY_SOCKS4 = 4  /' support added in 7.15.2, enum existed already
                           in 7.10 '/
  CURLPROXY_SOCKS5 = 5  /' added in 7.10 '/
  CURLPROXY_SOCKS4A = 6 /' added in 7.18.0 '/
  CURLPROXY_SOCKS5_HOSTNAME = 7 /' Use the SOCKS5 protocol but pass along the
                                   host name rather than the IP address. added
                                   in 7.18.0 '/
end enum  /' this enum was added in 7.10 '/

#define CURLAUTH_NONE         0          /' nothing '/
#define CURLAUTH_BASIC        (1 shl 0)  /' Basic (default) '/
#define CURLAUTH_DIGEST       (1 shl 1)  /' Digest '/
#define CURLAUTH_GSSNEGOTIATE (1 shl 2)  /' GSS-Negotiate '/
#define CURLAUTH_NTLM         (1 shl 3)  /' NTLM '/
#define CURLAUTH_DIGEST_IE    (1 shl 4)  /' Digest with IE flavour '/
#define CURLAUTH_NTLM_WB      (1 shl 5)  /' NTLM delegating to winbind helper '/
#define CURLAUTH_ONLY         (1 shl 31) /' used together with a single other
                                            type to force no auth or just that
                                            single type '/
#define CURLAUTH_ANY (not CURLAUTH_DIGEST_IE)  /' all fine types set '/
#define CURLAUTH_ANYSAFE (not (CURLAUTH_BASIC or CURLAUTH_DIGEST_IE))

#define CURLSSH_AUTH_ANY       (not 0)   /' all types supported by the server '/
#define CURLSSH_AUTH_NONE      0         /' none allowed, silly but complete '/
#define CURLSSH_AUTH_PUBLICKEY (1 shl 0) /' public/private key files '/
#define CURLSSH_AUTH_PASSWORD  (1 shl 1) /' password '/
#define CURLSSH_AUTH_HOST      (1 shl 2) /' host key files '/
#define CURLSSH_AUTH_KEYBOARD  (1 shl 3) /' keyboard interactive '/
#define CURLSSH_AUTH_DEFAULT CURLSSH_AUTH_ANY

#define CURLGSSAPI_DELEGATION_NONE        0         /' no delegation (default) '/
#define CURLGSSAPI_DELEGATION_POLICY_FLAG (1 shl 0) /' if permitted by policy '/
#define CURLGSSAPI_DELEGATION_FLAG        (1 shl 1) /' delegate always '/

#define CURL_ERROR_SIZE 256

enum curl_khkey_type
  CURLKHTYPE_UNKNOWN
  CURLKHTYPE_RSA1
  CURLKHTYPE_RSA
  CURLKHTYPE_DSS
end enum

type curl_khkey
  as const byte ptr key /' points to a zero-terminated string encoded with base64
                           if len is zero, otherwise to the "raw" data '/
  as size_t len
  as curl_khkey_type keytype
end type

/' this is the set of return values expected from the curl_sshkeycallback
   callback '/
enum curl_khstat
  CURLKHSTAT_FINE_ADD_TO_FILE
  CURLKHSTAT_FINE
  CURLKHSTAT_REJECT  /' reject the connection, return an error '/
  CURLKHSTAT_DEFER   /' do not accept it, but we can't answer right now so
                        this causes a CURLE_DEFER error but otherwise the
                        connection will be left intact etc '/
  CURLKHSTAT_LAST    /' not for use, only a marker for last-in-list '/
end enum

/' this is the set of status codes pass in to the callback '/
enum curl_khmatch
  CURLKHMATCH_OK        /' match '/
  CURLKHMATCH_MISMATCH  /' host found, key mismatch! '/
  CURLKHMATCH_MISSING   /' no matching host/key found '/
  CURLKHMATCH_LAST      /' not for use, only a marker for last-in-list '/
end enum

type as function(byval easy as CURL ptr,     /' easy handle '/ _
                 byval knownkey as const curl_khkey ptr, /' known '/ _
                 byval foundkey as const curl_khkey ptr, /' found '/ _
                 byval as curl_khmatch,      /' libcurl's view on the keys '/ _
                 byval clientp as any ptr) as integer curl_sshkeycallback /' custom pointer passed from app '/

/' parameter for the CURLOPT_USE_SSL option '/
enum curl_usessl
  CURLUSESSL_NONE     /' do not attempt to use SSL '/
  CURLUSESSL_TRY      /' try using SSL, proceed anyway otherwise '/
  CURLUSESSL_CONTROL  /' SSL for the control connection or fail '/
  CURLUSESSL_ALL      /' SSL for all communication or fail '/
  CURLUSESSL_LAST     /' not an option, never use '/
end enum

#ifndef CURL_NO_OLDIES /' define this to test if your app builds with all
                          the obsolete stuff removed! '/

/' Backwards compatibility with older names '/
/' These are scheduled to disappear by 2009 '/

#define CURLFTPSSL_NONE CURLUSESSL_NONE
#define CURLFTPSSL_TRY CURLUSESSL_TRY
#define CURLFTPSSL_CONTROL CURLUSESSL_CONTROL
#define CURLFTPSSL_ALL CURLUSESSL_ALL
#define CURLFTPSSL_LAST CURLUSESSL_LAST
#define curl_ftpssl curl_usessl
#endif /'!CURL_NO_OLDIES'/

/' parameter for the CURLOPT_FTP_SSL_CCC option '/
enum curl_ftpccc
  CURLFTPSSL_CCC_NONE     /' do not send CCC '/
  CURLFTPSSL_CCC_PASSIVE  /' Let the server initiate the shutdown '/
  CURLFTPSSL_CCC_ACTIVE   /' Initiate the shutdown '/
  CURLFTPSSL_CCC_LAST     /' not an option, never use '/
end enum

/' parameter for the CURLOPT_FTPSSLAUTH option '/
enum curl_ftpauth
  CURLFTPAUTH_DEFAULT /' let libcurl decide '/
  CURLFTPAUTH_SSL     /' use "AUTH SSL" '/
  CURLFTPAUTH_TLS     /' use "AUTH TLS" '/
  CURLFTPAUTH_LAST    /' not an option, never use '/
end enum

/' parameter for the CURLOPT_FTP_CREATE_MISSING_DIRS option '/
enum curl_ftpcreatedir
  CURLFTP_CREATE_DIR_NONE   /' do NOT create missing dirs! '/
  CURLFTP_CREATE_DIR        /' (FTP/SFTP) if CWD fails, try MKD and then CWD
                               again if MKD succeeded, for SFTP this does
                               similar magic '/
  CURLFTP_CREATE_DIR_RETRY  /' (FTP only) if CWD fails, try MKD and then CWD
                               again even if MKD failed! '/
  CURLFTP_CREATE_DIR_LAST   /' not an option, never use '/
end enum

/' parameter for the CURLOPT_FTP_FILEMETHOD option '/
enum curl_ftpmethod
  CURLFTPMETHOD_DEFAULT    /' let libcurl pick '/
  CURLFTPMETHOD_MULTICWD   /' single CWD operation for each path part '/
  CURLFTPMETHOD_NOCWD      /' no CWD at all '/
  CURLFTPMETHOD_SINGLECWD  /' one CWD to full dir, then work on file '/
  CURLFTPMETHOD_LAST       /' not an option, never use '/
end enum

/' CURLPROTO_ defines are for the CURLOPT_*PROTOCOLS options '/
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
#define CURLPROTO_ALL    (not 0) /' enable everything '/

/' long may be 32 or 64 bits, but we should never depend on anything else
   but 32 '/
#define CURLOPTTYPE_LONG          0
#define CURLOPTTYPE_OBJECTPOINT   10000
#define CURLOPTTYPE_FUNCTIONPOINT 20000
#define CURLOPTTYPE_OFF_T         30000

/' name is uppercase CURLOPT_<name>,
   type is one of the defined CURLOPTTYPE_<type>
   number is unique identifier '/
#undef CINIT
#define CINIT(na,t,nu) CURLOPT_##na = CURLOPTTYPE_##t + nu

/'
 * This macro-mania below setups the CURLOPT_[what] enum, to be used with
 * curl_easy_setopt(). The first argument in the CINIT() macro is the [what]
 * word.
 '/

enum CURLoption
  /' This is the FILE * or void * the regular output should be written to. '/
  CINIT(FILE, OBJECTPOINT, 1)

  /' The full URL to get/put '/
  CINIT(URL,  OBJECTPOINT, 2)

  /' Port number to connect to, if other than default. '/
  CINIT(PORT, LONG, 3)

  /' Name of proxy to use. '/
  CINIT(PROXY, OBJECTPOINT, 4)

  /' "name:password" to use when fetching. '/
  CINIT(USERPWD, OBJECTPOINT, 5)

  /' "name:password" to use with proxy. '/
  CINIT(PROXYUSERPWD, OBJECTPOINT, 6)

  /' Range to get, specified as an ASCII string. '/
  CINIT(RANGE, OBJECTPOINT, 7)

  /' not used '/

  /' Specified file stream to upload from (use as input): '/
  CINIT(INFILE, OBJECTPOINT, 9)

  /' Buffer to receive error messages in, must be at least CURL_ERROR_SIZE
   * bytes big. If this is not used, error messages go to stderr instead: '/
  CINIT(ERRORBUFFER, OBJECTPOINT, 10)

  /' Function that will be called to store the output (instead of fwrite). The
   * parameters will use fwrite() syntax, make sure to follow them. '/
  CINIT(WRITEFUNCTION, FUNCTIONPOINT, 11)

  /' Function that will be called to read the input (instead of fread). The
   * parameters will use fread() syntax, make sure to follow them. '/
  CINIT(READFUNCTION, FUNCTIONPOINT, 12)

  /' Time-out the read operation after this amount of seconds '/
  CINIT(TIMEOUT, LONG, 13)

  /' If the CURLOPT_INFILE is used, this can be used to inform libcurl about
   * how large the file being sent really is. That allows better error
   * checking and better verifies that the upload was successful. -1 means
   * unknown size.
   *
   * For large file support, there is also a _LARGE version of the key
   * which takes an off_t type, allowing platforms with larger off_t
   * sizes to handle larger files.  See below for INFILESIZE_LARGE.
   '/
  CINIT(INFILESIZE, LONG, 14)

  /' POST static input fields. '/
  CINIT(POSTFIELDS, OBJECTPOINT, 15)

  /' Set the referrer page (needed by some CGIs) '/
  CINIT(REFERER, OBJECTPOINT, 16)

  /' Set the FTP PORT string (interface name, named or numerical IP address)
     Use i.e '-' to use default address. '/
  CINIT(FTPPORT, OBJECTPOINT, 17)

  /' Set the User-Agent string (examined by some CGIs) '/
  CINIT(USERAGENT, OBJECTPOINT, 18)

  /' If the download receives less than "low speed limit" bytes/second
   * during "low speed time" seconds, the operations is aborted.
   * You could i.e if you have a pretty high speed connection, abort if
   * it is less than 2000 bytes/sec during 20 seconds.
   '/

  /' Set the "low speed limit" '/
  CINIT(LOW_SPEED_LIMIT, LONG, 19)

  /' Set the "low speed time" '/
  CINIT(LOW_SPEED_TIME, LONG, 20)

  /' Set the continuation offset.
   *
   * Note there is also a _LARGE version of this key which uses
   * off_t types, allowing for large file offsets on platforms which
   * use larger-than-32-bit off_t's.  Look below for RESUME_FROM_LARGE.
   '/
  CINIT(RESUME_FROM, LONG, 21)

  /' Set cookie in request: '/
  CINIT(COOKIE, OBJECTPOINT, 22)

  /' This points to a linked list of headers, struct curl_slist kind '/
  CINIT(HTTPHEADER, OBJECTPOINT, 23)

  /' This points to a linked list of post entries, struct curl_httppost '/
  CINIT(HTTPPOST, OBJECTPOINT, 24)

  /' name of the file keeping your private SSL-certificate '/
  CINIT(SSLCERT, OBJECTPOINT, 25)

  /' password for the SSL or SSH private key '/
  CINIT(KEYPASSWD, OBJECTPOINT, 26)

  /' send TYPE parameter? '/
  CINIT(CRLF, LONG, 27)

  /' send linked-list of QUOTE commands '/
  CINIT(QUOTE, OBJECTPOINT, 28)

  /' send FILE * or void * to store headers to, if you use a callback it
     is simply passed to the callback unmodified '/
  CINIT(WRITEHEADER, OBJECTPOINT, 29)

  /' point to a file to read the initial cookies from, also enables
     "cookie awareness" '/
  CINIT(COOKIEFILE, OBJECTPOINT, 31)

  /' What version to specifically try to use.
     See CURL_SSLVERSION defines below. '/
  CINIT(SSLVERSION, LONG, 32)

  /' What kind of HTTP time condition to use, see defines '/
  CINIT(TIMECONDITION, LONG, 33)

  /' Time to use with the above condition. Specified in number of seconds
     since 1 Jan 1970 '/
  CINIT(TIMEVALUE, LONG, 34)

  /' 35 = OBSOLETE '/

  /' Custom request, for customizing the get command like
     HTTP: DELETE, TRACE and others
     FTP: to use a different list command
     '/
  CINIT(CUSTOMREQUEST, OBJECTPOINT, 36)

  /' HTTP request, for odd commands like DELETE, TRACE and others '/
  CINIT(STDERR, OBJECTPOINT, 37)

  /' 38 is not used '/

  /' send linked-list of post-transfer QUOTE commands '/
  CINIT(POSTQUOTE, OBJECTPOINT, 39)

  CINIT(WRITEINFO, OBJECTPOINT, 40) /' DEPRECATED, do not use! '/

  CINIT(VERBOSE, LONG, 41)      /' talk a lot '/
  CINIT(HEADER, LONG, 42)       /' throw the header out too '/
  CINIT(NOPROGRESS, LONG, 43)   /' shut off the progress meter '/
  CINIT(NOBODY, LONG, 44)       /' use HEAD to get http document '/
  CINIT(FAILONERROR, LONG, 45)  /' no output on http error codes >= 300 '/
  CINIT(UPLOAD, LONG, 46)       /' this is an upload '/
  CINIT(POST, LONG, 47)         /' HTTP POST method '/
  CINIT(DIRLISTONLY, LONG, 48)  /' bare names when listing directories '/

  CINIT(APPEND, LONG, 50)       /' Append instead of overwrite on upload! '/

  /' Specify whether to read the user+password from the .netrc or the URL.
   * This must be one of the CURL_NETRC_* enums below. '/
  CINIT(NETRC, LONG, 51)

  CINIT(FOLLOWLOCATION, LONG, 52)  /' use Location: Luke! '/

  CINIT(TRANSFERTEXT, LONG, 53) /' transfer data in text/ASCII format '/
  CINIT(PUT, LONG, 54)          /' HTTP PUT '/

  /' 55 = OBSOLETE '/

  /' Function that will be called instead of the internal progress display
   * function. This function should be defined as the curl_progress_callback
   * prototype defines. '/
  CINIT(PROGRESSFUNCTION, FUNCTIONPOINT, 56)

  /' Data passed to the progress callback '/
  CINIT(PROGRESSDATA, OBJECTPOINT, 57)

  /' We want the referrer field set automatically when following locations '/
  CINIT(AUTOREFERER, LONG, 58)

  /' Port of the proxy, can be set in the proxy string as well with:
     "[host]:[port]" '/
  CINIT(PROXYPORT, LONG, 59)

  /' size of the POST input data, if strlen() is not good to use '/
  CINIT(POSTFIELDSIZE, LONG, 60)

  /' tunnel non-http operations through a HTTP proxy '/
  CINIT(HTTPPROXYTUNNEL, LONG, 61)

  /' Set the interface string to use as outgoing network interface '/
  CINIT(INTERFACE, OBJECTPOINT, 62)

  /' Set the krb4/5 security level, this also enables krb4/5 awareness.  This
   * is a string, 'clear', 'safe', 'confidential' or 'private'.  If the string
   * is set but doesn't match one of these, 'private' will be used.  '/
  CINIT(KRBLEVEL, OBJECTPOINT, 63)

  /' Set if we should verify the peer in ssl handshake, set 1 to verify. '/
  CINIT(SSL_VERIFYPEER, LONG, 64)

  /' The CApath or CAfile used to validate the peer certificate
     this option is used only if SSL_VERIFYPEER is true '/
  CINIT(CAINFO, OBJECTPOINT, 65)

  /' 66 = OBSOLETE '/
  /' 67 = OBSOLETE '/

  /' Maximum number of http redirects to follow '/
  CINIT(MAXREDIRS, LONG, 68)

  /' Pass a long set to 1 to get the date of the requested document (if
     possible)! Pass a zero to shut it off. '/
  CINIT(FILETIME, LONG, 69)

  /' This points to a linked list of telnet options '/
  CINIT(TELNETOPTIONS, OBJECTPOINT, 70)

  /' Max amount of cached alive connections '/
  CINIT(MAXCONNECTS, LONG, 71)

  CINIT(CLOSEPOLICY, LONG, 72) /' DEPRECATED, do not use! '/

  /' 73 = OBSOLETE '/

  /' Set to explicitly use a new connection for the upcoming transfer.
     Do not use this unless you're absolutely sure of this, as it makes the
     operation slower and is less friendly for the network. '/
  CINIT(FRESH_CONNECT, LONG, 74)

  /' Set to explicitly forbid the upcoming transfer's connection to be re-used
     when done. Do not use this unless you're absolutely sure of this, as it
     makes the operation slower and is less friendly for the network. '/
  CINIT(FORBID_REUSE, LONG, 75)

  /' Set to a file name that contains random data for libcurl to use to
     seed the random engine when doing SSL connects. '/
  CINIT(RANDOM_FILE, OBJECTPOINT, 76)

  /' Set to the Entropy Gathering Daemon socket pathname '/
  CINIT(EGDSOCKET, OBJECTPOINT, 77)

  /' Time-out connect operations after this amount of seconds, if connects
     are OK within this time, then fine... This only aborts the connect
     phase. [Only works on unix-style/SIGALRM operating systems] '/
  CINIT(CONNECTTIMEOUT, LONG, 78)

  /' Function that will be called to store headers (instead of fwrite). The
   * parameters will use fwrite() syntax, make sure to follow them. '/
  CINIT(HEADERFUNCTION, FUNCTIONPOINT, 79)

  /' Set this to force the HTTP request to get back to GET. Only really usable
     if POST, PUT or a custom request have been used first.
   '/
  CINIT(HTTPGET, LONG, 80)

  /' Set if we should verify the Common name from the peer certificate in ssl
   * handshake, set 1 to check existence, 2 to ensure that it matches the
   * provided hostname. '/
  CINIT(SSL_VERIFYHOST, LONG, 81)

  /' Specify which file name to write all known cookies in after completed
     operation. Set file name to "-" (dash) to make it go to stdout. '/
  CINIT(COOKIEJAR, OBJECTPOINT, 82)

  /' Specify which SSL ciphers to use '/
  CINIT(SSL_CIPHER_LIST, OBJECTPOINT, 83)

  /' Specify which HTTP version to use! This must be set to one of the
     CURL_HTTP_VERSION* enums set below. '/
  CINIT(HTTP_VERSION, LONG, 84)

  /' Specifically switch on or off the FTP engine's use of the EPSV command. By
     default, that one will always be attempted before the more traditional
     PASV command. '/
  CINIT(FTP_USE_EPSV, LONG, 85)

  /' type of the file keeping your SSL-certificate ("DER", "PEM", "ENG") '/
  CINIT(SSLCERTTYPE, OBJECTPOINT, 86)

  /' name of the file keeping your private SSL-key '/
  CINIT(SSLKEY, OBJECTPOINT, 87)

  /' type of the file keeping your private SSL-key ("DER", "PEM", "ENG") '/
  CINIT(SSLKEYTYPE, OBJECTPOINT, 88)

  /' crypto engine for the SSL-sub system '/
  CINIT(SSLENGINE, OBJECTPOINT, 89)

  /' set the crypto engine for the SSL-sub system as default
     the param has no meaning...
   '/
  CINIT(SSLENGINE_DEFAULT, LONG, 90)

  /' Non-zero value means to use the global dns cache '/
  CINIT(DNS_USE_GLOBAL_CACHE, LONG, 91) /' DEPRECATED, do not use! '/

  /' DNS cache timeout '/
  CINIT(DNS_CACHE_TIMEOUT, LONG, 92)

  /' send linked-list of pre-transfer QUOTE commands '/
  CINIT(PREQUOTE, OBJECTPOINT, 93)

  /' set the debug function '/
  CINIT(DEBUGFUNCTION, FUNCTIONPOINT, 94)

  /' set the data for the debug function '/
  CINIT(DEBUGDATA, OBJECTPOINT, 95)

  /' mark this as start of a cookie session '/
  CINIT(COOKIESESSION, LONG, 96)

  /' The CApath directory used to validate the peer certificate
     this option is used only if SSL_VERIFYPEER is true '/
  CINIT(CAPATH, OBJECTPOINT, 97)

  /' Instruct libcurl to use a smaller receive buffer '/
  CINIT(BUFFERSIZE, LONG, 98)

  /' Instruct libcurl to not use any signal/alarm handlers, even when using
     timeouts. This option is useful for multi-threaded applications.
     See libcurl-the-guide for more background information. '/
  CINIT(NOSIGNAL, LONG, 99)

  /' Provide a CURLShare for mutexing non-ts data '/
  CINIT(SHARE, OBJECTPOINT, 100)

  /' indicates type of proxy. accepted values are CURLPROXY_HTTP (default),
     CURLPROXY_SOCKS4, CURLPROXY_SOCKS4A and CURLPROXY_SOCKS5. '/
  CINIT(PROXYTYPE, LONG, 101)

  /' Set the Accept-Encoding string. Use this to tell a server you would like
     the response to be compressed. Before 7.21.6, this was known as
     CURLOPT_ENCODING '/
  CINIT(ACCEPT_ENCODING, OBJECTPOINT, 102)

  /' Set pointer to private data '/
  CINIT(PRIVATE, OBJECTPOINT, 103)

  /' Set aliases for HTTP 200 in the HTTP Response header '/
  CINIT(HTTP200ALIASES, OBJECTPOINT, 104)

  /' Continue to send authentication (user+password) when following locations,
     even when hostname changed. This can potentially send off the name
     and password to whatever host the server decides. '/
  CINIT(UNRESTRICTED_AUTH, LONG, 105)

  /' Specifically switch on or off the FTP engine's use of the EPRT command (
     it also disables the LPRT attempt). By default, those ones will always be
     attempted before the good old traditional PORT command. '/
  CINIT(FTP_USE_EPRT, LONG, 106)

  /' Set this to a bitmask value to enable the particular authentications
     methods you like. Use this in combination with CURLOPT_USERPWD.
     Note that setting multiple bits may cause extra network round-trips. '/
  CINIT(HTTPAUTH, LONG, 107)

  /' Set the ssl context callback function, currently only for OpenSSL ssl_ctx
     in second argument. The function must be matching the
     curl_ssl_ctx_callback proto. '/
  CINIT(SSL_CTX_FUNCTION, FUNCTIONPOINT, 108)

  /' Set the userdata for the ssl context callback function's third
     argument '/
  CINIT(SSL_CTX_DATA, OBJECTPOINT, 109)

  /' FTP Option that causes missing dirs to be created on the remote server.
     In 7.19.4 we introduced the convenience enums for this option using the
     CURLFTP_CREATE_DIR prefix.
  '/
  CINIT(FTP_CREATE_MISSING_DIRS, LONG, 110)

  /' Set this to a bitmask value to enable the particular authentications
     methods you like. Use this in combination with CURLOPT_PROXYUSERPWD.
     Note that setting multiple bits may cause extra network round-trips. '/
  CINIT(PROXYAUTH, LONG, 111)

  /' FTP option that changes the timeout, in seconds, associated with
     getting a response.  This is different from transfer timeout time and
     essentially places a demand on the FTP server to acknowledge commands
     in a timely manner. '/
  CINIT(FTP_RESPONSE_TIMEOUT, LONG, 112)
#define CURLOPT_SERVER_RESPONSE_TIMEOUT CURLOPT_FTP_RESPONSE_TIMEOUT

  /' Set this option to one of the CURL_IPRESOLVE_* defines (see below) to
     tell libcurl to resolve names to those IP versions only. This only has
     affect on systems with support for more than one, i.e IPv4 _and_ IPv6. '/
  CINIT(IPRESOLVE, LONG, 113)

  /' Set this option to limit the size of a file that will be downloaded from
     an HTTP or FTP server.

     Note there is also _LARGE version which adds large file support for
     platforms which have larger off_t sizes.  See MAXFILESIZE_LARGE below. '/
  CINIT(MAXFILESIZE, LONG, 114)

  /' See the comment for INFILESIZE above, but in short, specifies
   * the size of the file being uploaded.  -1 means unknown.
   '/
  CINIT(INFILESIZE_LARGE, OFF_T, 115)

  /' Sets the continuation offset.  There is also a LONG version of this;
   * look above for RESUME_FROM.
   '/
  CINIT(RESUME_FROM_LARGE, OFF_T, 116)

  /' Sets the maximum size of data that will be downloaded from
   * an HTTP or FTP server.  See MAXFILESIZE above for the LONG version.
   '/
  CINIT(MAXFILESIZE_LARGE, OFF_T, 117)

  /' Set this option to the file name of your .netrc file you want libcurl
     to parse (using the CURLOPT_NETRC option). If not set, libcurl will do
     a poor attempt to find the user's home directory and check for a .netrc
     file in there. '/
  CINIT(NETRC_FILE, OBJECTPOINT, 118)

  /' Enable SSL/TLS for FTP, pick one of:
     CURLFTPSSL_TRY     - try using SSL, proceed anyway otherwise
     CURLFTPSSL_CONTROL - SSL for the control connection or fail
     CURLFTPSSL_ALL     - SSL for all communication or fail
  '/
  CINIT(USE_SSL, LONG, 119)

  /' The _LARGE version of the standard POSTFIELDSIZE option '/
  CINIT(POSTFIELDSIZE_LARGE, OFF_T, 120)

  /' Enable/disable the TCP Nagle algorithm '/
  ''CINIT(TCP_NODELAY, LONG, 121) '' TCP_NODELAY is defined by winsock2.bi
  CURLOPT_TCP_NODELAY = CURLOPTTYPE_LONG + 121

  /' 122 OBSOLETE, used in 7.12.3. Gone in 7.13.0 '/
  /' 123 OBSOLETE. Gone in 7.16.0 '/
  /' 124 OBSOLETE, used in 7.12.3. Gone in 7.13.0 '/
  /' 125 OBSOLETE, used in 7.12.3. Gone in 7.13.0 '/
  /' 126 OBSOLETE, used in 7.12.3. Gone in 7.13.0 '/
  /' 127 OBSOLETE. Gone in 7.16.0 '/
  /' 128 OBSOLETE. Gone in 7.16.0 '/

  /' When FTP over SSL/TLS is selected (with CURLOPT_USE_SSL), this option
     can be used to change libcurl's default action which is to first try
     "AUTH SSL" and then "AUTH TLS" in this order, and proceed when a OK
     response has been received.

     Available parameters are:
     CURLFTPAUTH_DEFAULT - let libcurl decide
     CURLFTPAUTH_SSL     - try "AUTH SSL" first, then TLS
     CURLFTPAUTH_TLS     - try "AUTH TLS" first, then SSL
  '/
  CINIT(FTPSSLAUTH, LONG, 129)

  CINIT(IOCTLFUNCTION, FUNCTIONPOINT, 130)
  CINIT(IOCTLDATA, OBJECTPOINT, 131)

  /' 132 OBSOLETE. Gone in 7.16.0 '/
  /' 133 OBSOLETE. Gone in 7.16.0 '/

  /' zero terminated string for pass on to the FTP server when asked for
     "account" info '/
  CINIT(FTP_ACCOUNT, OBJECTPOINT, 134)

  /' feed cookies into cookie engine '/
  CINIT(COOKIELIST, OBJECTPOINT, 135)

  /' ignore Content-Length '/
  CINIT(IGNORE_CONTENT_LENGTH, LONG, 136)

  /' Set to non-zero to skip the IP address received in a 227 PASV FTP server
     response. Typically used for FTP-SSL purposes but is not restricted to
     that. libcurl will then instead use the same IP address it used for the
     control connection. '/
  CINIT(FTP_SKIP_PASV_IP, LONG, 137)

  /' Select "file method" to use when doing FTP, see the curl_ftpmethod
     above. '/
  CINIT(FTP_FILEMETHOD, LONG, 138)

  /' Local port number to bind the socket to '/
  CINIT(LOCALPORT, LONG, 139)

  /' Number of ports to try, including the first one set with LOCALPORT.
     Thus, setting it to 1 will make no additional attempts but the first.
  '/
  CINIT(LOCALPORTRANGE, LONG, 140)

  /' no transfer, set up connection and let application use the socket by
     extracting it with CURLINFO_LASTSOCKET '/
  CINIT(CONNECT_ONLY, LONG, 141)

  /' Function that will be called to convert from the
     network encoding (instead of using the iconv calls in libcurl) '/
  CINIT(CONV_FROM_NETWORK_FUNCTION, FUNCTIONPOINT, 142)

  /' Function that will be called to convert to the
     network encoding (instead of using the iconv calls in libcurl) '/
  CINIT(CONV_TO_NETWORK_FUNCTION, FUNCTIONPOINT, 143)

  /' Function that will be called to convert from UTF8
     (instead of using the iconv calls in libcurl)
     Note that this is used only for SSL certificate processing '/
  CINIT(CONV_FROM_UTF8_FUNCTION, FUNCTIONPOINT, 144)

  /' if the connection proceeds too quickly then need to slow it down '/
  /' limit-rate: maximum number of bytes per second to send or receive '/
  CINIT(MAX_SEND_SPEED_LARGE, OFF_T, 145)
  CINIT(MAX_RECV_SPEED_LARGE, OFF_T, 146)

  /' Pointer to command string to send if USER/PASS fails. '/
  CINIT(FTP_ALTERNATIVE_TO_USER, OBJECTPOINT, 147)

  /' callback function for setting socket options '/
  CINIT(SOCKOPTFUNCTION, FUNCTIONPOINT, 148)
  CINIT(SOCKOPTDATA, OBJECTPOINT, 149)

  /' set to 0 to disable session ID re-use for this transfer, default is
     enabled (== 1) '/
  CINIT(SSL_SESSIONID_CACHE, LONG, 150)

  /' allowed SSH authentication methods '/
  CINIT(SSH_AUTH_TYPES, LONG, 151)

  /' Used by scp/sftp to do public/private key authentication '/
  CINIT(SSH_PUBLIC_KEYFILE, OBJECTPOINT, 152)
  CINIT(SSH_PRIVATE_KEYFILE, OBJECTPOINT, 153)

  /' Send CCC (Clear Command Channel) after authentication '/
  CINIT(FTP_SSL_CCC, LONG, 154)

  /' Same as TIMEOUT and CONNECTTIMEOUT, but with ms resolution '/
  CINIT(TIMEOUT_MS, LONG, 155)
  CINIT(CONNECTTIMEOUT_MS, LONG, 156)

  /' set to zero to disable the libcurl's decoding and thus pass the raw body
     data to the application even when it is encoded/compressed '/
  CINIT(HTTP_TRANSFER_DECODING, LONG, 157)
  CINIT(HTTP_CONTENT_DECODING, LONG, 158)

  /' Permission used when creating new files and directories on the remote
     server for protocols that support it, SFTP/SCP/FILE '/
  CINIT(NEW_FILE_PERMS, LONG, 159)
  CINIT(NEW_DIRECTORY_PERMS, LONG, 160)

  /' Set the behaviour of POST when redirecting. Values must be set to one
     of CURL_REDIR* defines below. This used to be called CURLOPT_POST301 '/
  CINIT(POSTREDIR, LONG, 161)

  /' used by scp/sftp to verify the host's public key '/
  CINIT(SSH_HOST_PUBLIC_KEY_MD5, OBJECTPOINT, 162)

  /' Callback function for opening socket (instead of socket(2)). Optionally,
     callback is able change the address or refuse to connect returning
     CURL_SOCKET_BAD.  The callback should have type
     curl_opensocket_callback '/
  CINIT(OPENSOCKETFUNCTION, FUNCTIONPOINT, 163)
  CINIT(OPENSOCKETDATA, OBJECTPOINT, 164)

  /' POST volatile input fields. '/
  CINIT(COPYPOSTFIELDS, OBJECTPOINT, 165)

  /' set transfer mode (;type=<a|i>) when doing FTP via an HTTP proxy '/
  CINIT(PROXY_TRANSFER_MODE, LONG, 166)

  /' Callback function for seeking in the input stream '/
  CINIT(SEEKFUNCTION, FUNCTIONPOINT, 167)
  CINIT(SEEKDATA, OBJECTPOINT, 168)

  /' CRL file '/
  CINIT(CRLFILE, OBJECTPOINT, 169)

  /' Issuer certificate '/
  CINIT(ISSUERCERT, OBJECTPOINT, 170)

  /' (IPv6) Address scope '/
  CINIT(ADDRESS_SCOPE, LONG, 171)

  /' Collect certificate chain info and allow it to get retrievable with
     CURLINFO_CERTINFO after the transfer is complete. (Unfortunately) only
     working with OpenSSL-powered builds. '/
  CINIT(CERTINFO, LONG, 172)

  /' "name" and "pwd" to use when fetching. '/
  CINIT(USERNAME, OBJECTPOINT, 173)
  CINIT(PASSWORD, OBJECTPOINT, 174)

    /' "name" and "pwd" to use with Proxy when fetching. '/
  CINIT(PROXYUSERNAME, OBJECTPOINT, 175)
  CINIT(PROXYPASSWORD, OBJECTPOINT, 176)

  /' Comma separated list of hostnames defining no-proxy zones. These should
     match both hostnames directly, and hostnames within a domain. For
     example, local.com will match local.com and www.local.com, but NOT
     notlocal.com or www.notlocal.com. For compatibility with other
     implementations of this, .local.com will be considered to be the same as
     local.com. A single * is the only valid wildcard, and effectively
     disables the use of proxy. '/
  CINIT(NOPROXY, OBJECTPOINT, 177)

  /' block size for TFTP transfers '/
  CINIT(TFTP_BLKSIZE, LONG, 178)

  /' Socks Service '/
  CINIT(SOCKS5_GSSAPI_SERVICE, OBJECTPOINT, 179)

  /' Socks Service '/
  CINIT(SOCKS5_GSSAPI_NEC, LONG, 180)

  /' set the bitmask for the protocols that are allowed to be used for the
     transfer, which thus helps the app which takes URLs from users or other
     external inputs and want to restrict what protocol(s) to deal
     with. Defaults to CURLPROTO_ALL. '/
  CINIT(PROTOCOLS, LONG, 181)

  /' set the bitmask for the protocols that libcurl is allowed to follow to,
     as a subset of the CURLOPT_PROTOCOLS ones. That means the protocol needs
     to be set in both bitmasks to be allowed to get redirected to. Defaults
     to all protocols except FILE and SCP. '/
  CINIT(REDIR_PROTOCOLS, LONG, 182)

  /' set the SSH knownhost file name to use '/
  CINIT(SSH_KNOWNHOSTS, OBJECTPOINT, 183)

  /' set the SSH host key callback, must point to a curl_sshkeycallback
     function '/
  CINIT(SSH_KEYFUNCTION, FUNCTIONPOINT, 184)

  /' set the SSH host key callback custom pointer '/
  CINIT(SSH_KEYDATA, OBJECTPOINT, 185)

  /' set the SMTP mail originator '/
  CINIT(MAIL_FROM, OBJECTPOINT, 186)

  /' set the SMTP mail receiver(s) '/
  CINIT(MAIL_RCPT, OBJECTPOINT, 187)

  /' FTP: send PRET before PASV '/
  CINIT(FTP_USE_PRET, LONG, 188)

  /' RTSP request method (OPTIONS, SETUP, PLAY, etc...) '/
  CINIT(RTSP_REQUEST, LONG, 189)

  /' The RTSP session identifier '/
  CINIT(RTSP_SESSION_ID, OBJECTPOINT, 190)

  /' The RTSP stream URI '/
  CINIT(RTSP_STREAM_URI, OBJECTPOINT, 191)

  /' The Transport: header to use in RTSP requests '/
  CINIT(RTSP_TRANSPORT, OBJECTPOINT, 192)

  /' Manually initialize the client RTSP CSeq for this handle '/
  CINIT(RTSP_CLIENT_CSEQ, LONG, 193)

  /' Manually initialize the server RTSP CSeq for this handle '/
  CINIT(RTSP_SERVER_CSEQ, LONG, 194)

  /' The stream to pass to INTERLEAVEFUNCTION. '/
  CINIT(INTERLEAVEDATA, OBJECTPOINT, 195)

  /' Let the application define a custom write method for RTP data '/
  CINIT(INTERLEAVEFUNCTION, FUNCTIONPOINT, 196)

  /' Turn on wildcard matching '/
  CINIT(WILDCARDMATCH, LONG, 197)

  /' Directory matching callback called before downloading of an
     individual file (chunk) started '/
  CINIT(CHUNK_BGN_FUNCTION, FUNCTIONPOINT, 198)

  /' Directory matching callback called after the file (chunk)
     was downloaded, or skipped '/
  CINIT(CHUNK_END_FUNCTION, FUNCTIONPOINT, 199)

  /' Change match (fnmatch-like) callback for wildcard matching '/
  CINIT(FNMATCH_FUNCTION, FUNCTIONPOINT, 200)

  /' Let the application define custom chunk data pointer '/
  CINIT(CHUNK_DATA, OBJECTPOINT, 201)

  /' FNMATCH_FUNCTION user pointer '/
  CINIT(FNMATCH_DATA, OBJECTPOINT, 202)

  /' send linked-list of name:port:address sets '/
  CINIT(RESOLVE, OBJECTPOINT, 203)

  /' Set a username for authenticated TLS '/
  CINIT(TLSAUTH_USERNAME, OBJECTPOINT, 204)

  /' Set a password for authenticated TLS '/
  CINIT(TLSAUTH_PASSWORD, OBJECTPOINT, 205)

  /' Set authentication type for authenticated TLS '/
  CINIT(TLSAUTH_TYPE, OBJECTPOINT, 206)

  /' Set to 1 to enable the "TE:" header in HTTP requests to ask for
     compressed transfer-encoded responses. Set to 0 to disable the use of TE:
     in outgoing requests. The current default is 0, but it might change in a
     future libcurl release.

     libcurl will ask for the compressed methods it knows of, and if that
     isn't any, it will not ask for transfer-encoding at all even if this
     option is set to 1.

  '/
  CINIT(TRANSFER_ENCODING, LONG, 207)

  /' Callback function for closing socket (instead of close(2)). The callback
     should have type curl_closesocket_callback '/
  CINIT(CLOSESOCKETFUNCTION, FUNCTIONPOINT, 208)
  CINIT(CLOSESOCKETDATA, OBJECTPOINT, 209)

  /' allow GSSAPI credential delegation '/
  CINIT(GSSAPI_DELEGATION, LONG, 210)

  /' Set the name servers to use for DNS resolution '/
  CINIT(DNS_SERVERS, OBJECTPOINT, 211)

  /' Time-out accept operations (currently for FTP only) after this amount
     of miliseconds. '/
  CINIT(ACCEPTTIMEOUT_MS, LONG, 212)

  CURLOPT_LASTENTRY /' the last unused '/
end enum

#ifndef CURL_NO_OLDIES /' define this to test if your app builds with all
                          the obsolete stuff removed! '/

/' Backwards compatibility with older names '/
/' These are scheduled to disappear by 2011 '/

/' This was added in version 7.19.1 '/
#define CURLOPT_POST301 CURLOPT_POSTREDIR

/' These are scheduled to disappear by 2009 '/

/' The following were added in 7.17.0 '/
#define CURLOPT_SSLKEYPASSWD CURLOPT_KEYPASSWD
#define CURLOPT_FTPAPPEND CURLOPT_APPEND
#define CURLOPT_FTPLISTONLY CURLOPT_DIRLISTONLY
#define CURLOPT_FTP_SSL CURLOPT_USE_SSL

/' The following were added earlier '/

#define CURLOPT_SSLCERTPASSWD CURLOPT_KEYPASSWD
#define CURLOPT_KRB4LEVEL CURLOPT_KRBLEVEL

#else
/' This is set if CURL_NO_OLDIES is defined at compile-time '/
#undef CURLOPT_DNS_USE_GLOBAL_CACHE /' soon obsolete '/
#endif


  /' Below here follows defines for the CURLOPT_IPRESOLVE option. If a host
     name resolves addresses using more than one IP protocol version, this
     option might be handy to force libcurl to use a specific IP version. '/
#define CURL_IPRESOLVE_WHATEVER 0 /' default, resolves addresses to all IP
                                     versions that your system allows '/
#define CURL_IPRESOLVE_V4       1 /' resolve to ipv4 addresses '/
#define CURL_IPRESOLVE_V6       2 /' resolve to ipv6 addresses '/

  /' three convenient "aliases" that follow the name scheme better '/
#define CURLOPT_WRITEDATA CURLOPT_FILE
#define CURLOPT_READDATA  CURLOPT_INFILE
#define CURLOPT_HEADERDATA CURLOPT_WRITEHEADER
#define CURLOPT_RTSPHEADER CURLOPT_HTTPHEADER

  /' These enums are for use with the CURLOPT_HTTP_VERSION option. '/
enum
  CURL_HTTP_VERSION_NONE  /' setting this means we don't care, and that we'd
                             like the library to choose the best possible
                             for us! '/
  CURL_HTTP_VERSION_1_0   /' please use HTTP 1.0 in the request '/
  CURL_HTTP_VERSION_1_1   /' please use HTTP 1.1 in the request '/

  CURL_HTTP_VERSION_LAST /' *ILLEGAL* http version '/
end enum

/'
 * Public API enums for RTSP requests
 '/
enum
    CURL_RTSPREQ_NONE /' first in list '/
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
    CURL_RTSPREQ_LAST /' last in list '/
end enum

  /' These enums are for use with the CURLOPT_NETRC option. '/
enum CURL_NETRC_OPTION
  CURL_NETRC_IGNORED      /' The .netrc will never be read.
                           * This is the default. '/
  CURL_NETRC_OPTIONAL     /' A user:password in the URL will be preferred
                           * to one in the .netrc. '/
  CURL_NETRC_REQUIRED     /' A user:password in the URL will be ignored.
                           * Unless one is set programmatically, the .netrc
                           * will be queried. '/
  CURL_NETRC_LAST
end enum

enum
  CURL_SSLVERSION_DEFAULT
  CURL_SSLVERSION_TLSv1
  CURL_SSLVERSION_SSLv2
  CURL_SSLVERSION_SSLv3

  CURL_SSLVERSION_LAST /' never use, keep last '/
end enum

enum CURL_TLSAUTH
  CURL_TLSAUTH_NONE
  CURL_TLSAUTH_SRP
  CURL_TLSAUTH_LAST /' never use, keep last '/
end enum

/' symbols to use with CURLOPT_POSTREDIR.
   CURL_REDIR_POST_301 and CURL_REDIR_POST_302 can be bitwise ORed so that
   CURL_REDIR_POST_301 | CURL_REDIR_POST_302 == CURL_REDIR_POST_ALL '/

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


/' curl_strequal() and curl_strnequal() are subject for removal in a future
   libcurl, see lib/README.curlx for details '/
declare function curl_strequal(byval s1 as const zstring ptr, byval s2 as const zstring ptr) as integer
declare function curl_strnequal(byval s1 as const zstring ptr, byval s2 as const zstring ptr, byval n as size_t) as integer

/' name is uppercase CURLFORM_<name> '/
#undef CFINIT
#define CFINIT(name) CURLFORM_##name

enum CURLformoption
  CFINIT(NOTHING)        /'******** the first one is unused ***********'/

  /'  '/
  CFINIT(COPYNAME)
  CFINIT(PTRNAME)
  CFINIT(NAMELENGTH)
  CFINIT(COPYCONTENTS)
  CFINIT(PTRCONTENTS)
  CFINIT(CONTENTSLENGTH)
  CFINIT(FILECONTENT)
  CFINIT(ARRAY)
  CFINIT(OBSOLETE)
  CFINIT(FILE)

  CFINIT(BUFFER)
  CFINIT(BUFFERPTR)
  CFINIT(BUFFERLENGTH)

  CFINIT(CONTENTTYPE)
  CFINIT(CONTENTHEADER)
  CFINIT(FILENAME)
  CFINIT(END)
  CFINIT(OBSOLETE2)

  CFINIT(STREAM)

  CURLFORM_LASTENTRY /' the last unused '/
end enum

#undef CFINIT /' done '/

/' structure to be used as parameter for CURLFORM_ARRAY '/
type curl_forms
  as CURLformoption option
  as const zstring ptr value
end type

/' use this for multipart formpost building '/
/' Returns code for curl_formadd()
 *
 * Returns:
 * CURL_FORMADD_OK             on success
 * CURL_FORMADD_MEMORY         if the FormInfo allocation fails
 * CURL_FORMADD_OPTION_TWICE   if one option is given twice for one Form
 * CURL_FORMADD_NULL           if a null pointer was given for a char
 * CURL_FORMADD_MEMORY         if the allocation of a FormInfo struct failed
 * CURL_FORMADD_UNKNOWN_OPTION if an unknown option was used
 * CURL_FORMADD_INCOMPLETE     if the some FormInfo is not complete (or error)
 * CURL_FORMADD_MEMORY         if a curl_httppost struct cannot be allocated
 * CURL_FORMADD_MEMORY         if some allocation for string copying failed.
 * CURL_FORMADD_ILLEGAL_ARRAY  if an illegal option is used in an array
 *
 **************************************************************************'/
enum CURLFORMcode
  CURL_FORMADD_OK /' first, no error '/

  CURL_FORMADD_MEMORY
  CURL_FORMADD_OPTION_TWICE
  CURL_FORMADD_NULL
  CURL_FORMADD_UNKNOWN_OPTION
  CURL_FORMADD_INCOMPLETE
  CURL_FORMADD_ILLEGAL_ARRAY
  CURL_FORMADD_DISABLED /' libcurl was built with this disabled '/

  CURL_FORMADD_LAST /' last '/
end enum

/'
 * NAME curl_formadd()
 *
 * DESCRIPTION
 *
 * Pretty advanced function for building multi-part formposts. Each invoke
 * adds one part that together construct a full post. Then use
 * CURLOPT_HTTPPOST to send it off to libcurl.
 '/
declare function curl_formadd(byval httppost as curl_httppost ptr ptr, _
                              byval last_post as curl_httppost ptr ptr, _
                              ...) as CURLFORMcode

/'
 * callback function for curl_formget()
 * The void *arg pointer will be the one passed as second argument to
 *   curl_formget().
 * The character buffer passed to it must not be freed.
 * Should return the buffer length passed to it as the argument "len" on
 *   success.
 '/
type as function(byval arg as any ptr, byval buf as const byte ptr, _
                 byval len as size_t) as size_t curl_formget_callback

/'
 * NAME curl_formget()
 *
 * DESCRIPTION
 *
 * Serialize a curl_httppost struct built with curl_formadd().
 * Accepts a void pointer as second argument which will be passed to
 * the curl_formget_callback function.
 * Returns 0 on success.
 '/
declare function curl_formget(byval form as curl_httppost ptr, byval arg as any ptr, _
                              byval append as curl_formget_callback) as integer
/'
 * NAME curl_formfree()
 *
 * DESCRIPTION
 *
 * Free a multipart formpost previously built with curl_formadd().
 '/
declare sub curl_formfree(byval form as curl_httppost ptr)

/'
 * NAME curl_getenv()
 *
 * DESCRIPTION
 *
 * Returns a malloc()'ed string that MUST be curl_free()ed after usage is
 * complete. DEPRECATED - see lib/README.curlx
 '/
declare function curl_getenv(byval variable as const zstring ptr) as zstring ptr

/'
 * NAME curl_version()
 *
 * DESCRIPTION
 *
 * Returns a static ascii string of the libcurl version.
 '/
declare function curl_version() as zstring ptr

/'
 * NAME curl_easy_escape()
 *
 * DESCRIPTION
 *
 * Escapes URL strings (converts all letters consider illegal in URLs to their
 * %XX versions). This function returns a new allocated string or NULL if an
 * error occurred.
 '/
declare function curl_easy_escape(byval handle as CURL ptr, _
                                  byval string as const zstring ptr, _
                                  byval length as integer) as zstring ptr

/' the previous version: '/
declare function curl_escape(byval string as const zstring ptr, _
                             byval length as integer) as zstring ptr


/'
 * NAME curl_easy_unescape()
 *
 * DESCRIPTION
 *
 * Unescapes URL encoding in strings (converts all %XX codes to their 8bit
 * versions). This function returns a new allocated string or NULL if an error
 * occurred.
 * Conversion Note: On non-ASCII platforms the ASCII %XX codes are
 * converted into the host encoding.
 '/
declare function curl_easy_unescape(byval handle as CURL ptr, _
                                    byval string as const zstring ptr, _
                                    byval length as integer, _
                                    byval outlength as integer ptr) as zstring ptr

/' the previous version '/
declare function curl_unescape(byval string as const zstring ptr, _
                               byval length as integer) as zstring ptr

/'
 * NAME curl_free()
 *
 * DESCRIPTION
 *
 * Provided for de-allocation in the same translation unit that did the
 * allocation. Added in libcurl 7.10
 '/
declare sub curl_free(byval p as any ptr)

/'
 * NAME curl_global_init()
 *
 * DESCRIPTION
 *
 * curl_global_init() should be invoked exactly once for each application that
 * uses libcurl and before any call of other libcurl functions.
 *
 * This function is not thread-safe!
 '/
declare function curl_global_init(byval flags as long) as CURLcode

/'
 * NAME curl_global_init_mem()
 *
 * DESCRIPTION
 *
 * curl_global_init() or curl_global_init_mem() should be invoked exactly once
 * for each application that uses libcurl.  This function can be used to
 * initialize libcurl and set user defined memory management callback
 * functions.  Users can implement memory management routines to check for
 * memory leaks, check for mis-use of the curl library etc.  User registered
 * callback routines with be invoked by this library instead of the system
 * memory management routines like malloc, free etc.
 '/
declare function curl_global_init_mem(byval flags as long, _
                                      byval m as curl_malloc_callback, _
                                      byval f as curl_free_callback, _
                                      byval r as curl_realloc_callback, _
                                      byval s as curl_strdup_callback, _
                                      byval c as curl_calloc_callback) as CURLcode

/'
 * NAME curl_global_cleanup()
 *
 * DESCRIPTION
 *
 * curl_global_cleanup() should be invoked exactly once for each application
 * that uses libcurl
 '/
declare sub curl_global_cleanup()

/' linked-list structure for the CURLOPT_QUOTE option (and other) '/
type curl_slist
  as zstring ptr data
  as curl_slist ptr next
end type

/'
 * NAME curl_slist_append()
 *
 * DESCRIPTION
 *
 * Appends a string to a linked list. If no list exists, it will be created
 * first. Returns the new list, after appending.
 '/
declare function curl_slist_append(byval as curl_slist ptr, _
                                   byval as const zstring ptr) as curl_slist ptr

/'
 * NAME curl_slist_free_all()
 *
 * DESCRIPTION
 *
 * free a previously built curl_slist.
 '/
declare sub curl_slist_free_all(byval as curl_slist ptr)

/'
 * NAME curl_getdate()
 *
 * DESCRIPTION
 *
 * Returns the time, in seconds since 1 Jan 1970 of the time string given in
 * the first argument. The time argument in the second parameter is unused
 * and should be set to NULL.
 '/
declare function curl_getdate(byval p as const zstring ptr, byval unused as const time_t ptr) as time_t

/' info about the certificate chain, only for OpenSSL builds. Asked
   for with CURLOPT_CERTINFO / CURLINFO_CERTINFO '/
type curl_certinfo
  as integer num_of_certs        /' number of certificates with information '/
  as curl_slist ptr ptr certinfo /' for each index in this array, there's a
                                    linked list with textual information in the
                                    format "name: value" '/
end type

#define CURLINFO_STRING   &h100000
#define CURLINFO_LONG     &h200000
#define CURLINFO_DOUBLE   &h300000
#define CURLINFO_SLIST    &h400000
#define CURLINFO_MASK     &h0fffff
#define CURLINFO_TYPEMASK &hf00000

enum CURLINFO
  CURLINFO_NONE /' first, never use this '/
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
  /' Fill in new entries below here! '/

  CURLINFO_LASTONE          = 42
end enum

/' CURLINFO_RESPONSE_CODE is the new name for the option previously known as
   CURLINFO_HTTP_CODE '/
#define CURLINFO_HTTP_CODE CURLINFO_RESPONSE_CODE

enum curl_closepolicy
  CURLCLOSEPOLICY_NONE /' first, never use this '/

  CURLCLOSEPOLICY_OLDEST
  CURLCLOSEPOLICY_LEAST_RECENTLY_USED
  CURLCLOSEPOLICY_LEAST_TRAFFIC
  CURLCLOSEPOLICY_SLOWEST
  CURLCLOSEPOLICY_CALLBACK

  CURLCLOSEPOLICY_LAST /' last, never use this '/
end enum

#define CURL_GLOBAL_SSL (1 shl 0)
#define CURL_GLOBAL_WIN32 (1 shl 1)
#define CURL_GLOBAL_ALL (CURL_GLOBAL_SSL or CURL_GLOBAL_WIN32)
#define CURL_GLOBAL_NOTHING 0
#define CURL_GLOBAL_DEFAULT CURL_GLOBAL_ALL


/'****************************************************************************
 * Setup defines, protos etc for the sharing stuff.
 '/

/' Different data locks for a single share '/
enum curl_lock_data
  CURL_LOCK_DATA_NONE = 0
  /'  CURL_LOCK_DATA_SHARE is used internally to say that
   *  the locking is just made to change the internal state of the share
   *  itself.
   '/
  CURL_LOCK_DATA_SHARE
  CURL_LOCK_DATA_COOKIE
  CURL_LOCK_DATA_DNS
  CURL_LOCK_DATA_SSL_SESSION
  CURL_LOCK_DATA_CONNECT
  CURL_LOCK_DATA_LAST
end enum

/' Different lock access types '/
enum curl_lock_access
  CURL_LOCK_ACCESS_NONE = 0    /' unspecified action '/
  CURL_LOCK_ACCESS_SHARED = 1  /' for read perhaps '/
  CURL_LOCK_ACCESS_SINGLE = 2  /' for write perhaps '/
  CURL_LOCK_ACCESS_LAST        /' never use '/
end enum

type as sub(byval handle as CURL ptr, _
            byval data as curl_lock_data, _
            byval locktype as curl_lock_access, _
            byval userptr as any ptr) curl_lock_function
type as sub(byval handle as CURL ptr, _
            byval data as curl_lock_data, _
            byval userptr as any ptr) curl_unlock_function

type as any CURLSH

enum CURLSHcode
  CURLSHE_OK   /' all is fine '/
  CURLSHE_BAD_OPTION  /' 1 '/
  CURLSHE_IN_USE      /' 2 '/
  CURLSHE_INVALID     /' 3 '/
  CURLSHE_NOMEM       /' 4 out of memory '/
  CURLSHE_NOT_BUILT_IN /' 5 feature not present in lib '/
  CURLSHE_LAST        /' never use '/
end enum

enum CURLSHoption
  CURLSHOPT_NONE   /' don't use '/
  CURLSHOPT_SHARE    /' specify a data type to share '/
  CURLSHOPT_UNSHARE  /' specify which data type to stop sharing '/
  CURLSHOPT_LOCKFUNC    /' pass in a 'curl_lock_function' pointer '/
  CURLSHOPT_UNLOCKFUNC  /' pass in a 'curl_unlock_function' pointer '/
  CURLSHOPT_USERDATA    /' pass in a user data pointer used in the lock/unlock
                           callback functions '/
  CURLSHOPT_LAST  /' never use '/
end enum

declare function curl_share_init() as CURLSH ptr
declare function curl_share_setopt(byval as CURLSH ptr, byval option as CURLSHoption, ...) as CURLSHcode
declare function curl_share_cleanup(byval as CURLSH ptr) as CURLSHcode

/'***************************************************************************
 * Structures for querying information about the curl library at runtime.
 '/

enum CURLversion
  CURLVERSION_FIRST
  CURLVERSION_SECOND
  CURLVERSION_THIRD
  CURLVERSION_FOURTH
  CURLVERSION_LAST /' never actually use this '/
end enum

/' The 'CURLVERSION_NOW' is the symbolic name meant to be used by
   basically all programs ever that want to get version information. It is
   meant to be a built-in version number for what kind of struct the caller
   expects. If the struct ever changes, we redefine the NOW to another enum
   from above. '/
#define CURLVERSION_NOW CURLVERSION_FOURTH

type curl_version_info_data
  as CURLversion age                /' age of the returned struct '/
  as const zstring ptr version      /' LIBCURL_VERSION '/
  as uinteger version_num           /' LIBCURL_VERSION_NUM '/
  as const zstring ptr host         /' OS/host/cpu/machine when configured '/
  as integer features               /' bitmask, see defines below '/
  as const zstring ptr ssl_version  /' human readable string '/
  as long ssl_version_num           /' not used anymore, always 0 '/
  as const zstring ptr libz_version /' human readable string '/
  /' protocols is terminated by an entry with a NULL protoname '/
  as const zstring const ptr ptr protocols

  /' The fields below this were added in CURLVERSION_SECOND '/
  as const zstring ptr ares
  as integer ares_num

  /' This field was added in CURLVERSION_THIRD '/
  as const zstring ptr libidn

  /' These field were added in CURLVERSION_FOURTH '/

  /' Same as '_libiconv_version' if built with HAVE_ICONV '/
  as integer iconv_ver_num

  as const zstring ptr libssh_version /' human readable string '/
end type

#define CURL_VERSION_IPV6      (1 shl 0)  /' IPv6-enabled '/
#define CURL_VERSION_KERBEROS4 (1 shl 1)  /' kerberos auth is supported '/
#define CURL_VERSION_SSL       (1 shl 2)  /' SSL options are present '/
#define CURL_VERSION_LIBZ      (1 shl 3)  /' libz features are present '/
#define CURL_VERSION_NTLM      (1 shl 4)  /' NTLM auth is supported '/
#define CURL_VERSION_GSSNEGOTIATE (1 shl 5) /' Negotiate auth support '/
#define CURL_VERSION_DEBUG     (1 shl 6)  /' built with debug capabilities '/
#define CURL_VERSION_ASYNCHDNS (1 shl 7)  /' asynchronous dns resolves '/
#define CURL_VERSION_SPNEGO    (1 shl 8)  /' SPNEGO auth '/
#define CURL_VERSION_LARGEFILE (1 shl 9)  /' supports files bigger than 2GB '/
#define CURL_VERSION_IDN       (1 shl 10) /' International Domain Names support '/
#define CURL_VERSION_SSPI      (1 shl 11) /' SSPI is supported '/
#define CURL_VERSION_CONV      (1 shl 12) /' character conversions supported '/
#define CURL_VERSION_CURLDEBUG (1 shl 13) /' debug memory tracking supported '/
#define CURL_VERSION_TLSAUTH_SRP (1 shl 14) /' TLS-SRP auth is supported '/
#define CURL_VERSION_NTLM_WB   (1 shl 15) /' NTLM delegating to winbind helper '/

/'
 * NAME curl_version_info()
 *
 * DESCRIPTION
 *
 * This function returns a pointer to a static copy of the version info
 * struct. See above.
 '/
declare function curl_version_info(byval as CURLversion) as curl_version_info_data ptr

/'
 * NAME curl_easy_strerror()
 *
 * DESCRIPTION
 *
 * The curl_easy_strerror function may be used to turn a CURLcode value
 * into the equivalent human readable error string.  This is useful
 * for printing meaningful error messages.
 '/
declare function curl_easy_strerror(byval as CURLcode) as const zstring ptr

/'
 * NAME curl_share_strerror()
 *
 * DESCRIPTION
 *
 * The curl_share_strerror function may be used to turn a CURLSHcode value
 * into the equivalent human readable error string.  This is useful
 * for printing meaningful error messages.
 '/
declare function curl_share_strerror(byval as CURLSHcode) as const zstring ptr

/'
 * NAME curl_easy_pause()
 *
 * DESCRIPTION
 *
 * The curl_easy_pause function pauses or unpauses transfers. Select the new
 * state by setting the bitmask, use the convenience defines below.
 *
 '/
declare function curl_easy_pause(byval handle as CURL ptr, byval bitmask as integer) as CURLcode

#define CURLPAUSE_RECV      (1 shl 0)
#define CURLPAUSE_RECV_CONT (0)

#define CURLPAUSE_SEND      (1 shl 2)
#define CURLPAUSE_SEND_CONT (0)

#define CURLPAUSE_ALL       (CURLPAUSE_RECV or CURLPAUSE_SEND)
#define CURLPAUSE_CONT      (CURLPAUSE_RECV_CONT or CURLPAUSE_SEND_CONT)

declare function curl_easy_init() as CURL ptr
declare function curl_easy_setopt(byval curl as CURL ptr, byval option as CURLoption, ...) as CURLcode
declare function curl_easy_perform(byval curl as CURL ptr) as CURLcode
declare sub curl_easy_cleanup(byval curl as CURL ptr)

/'
 * NAME curl_easy_getinfo()
 *
 * DESCRIPTION
 *
 * Request internal information from the curl session with this function.  The
 * third argument MUST be a pointer to a long, a pointer to a char * or a
 * pointer to a double (as the documentation describes elsewhere).  The data
 * pointed to will be filled in accordingly and can be relied upon only if the
 * function returns CURLE_OK.  This function is intended to get used *AFTER* a
 * performed transfer, all results from this function are undefined until the
 * transfer is completed.
 '/
declare function curl_easy_getinfo(byval curl as CURL ptr, byval info as CURLINFO, ...) as CURLcode


/'
 * NAME curl_easy_duphandle()
 *
 * DESCRIPTION
 *
 * Creates a new curl session handle with the same options set for the handle
 * passed in. Duplicating a handle could only be a matter of cloning data and
 * options, internal state info and things like persistent connections cannot
 * be transferred. It is useful in multithreaded applications when you can run
 * curl_easy_duphandle() for each new thread to avoid a series of identical
 * curl_easy_setopt() invokes in every thread.
 '/
declare function curl_easy_duphandle(byval curl as CURL ptr) as CURL ptr

/'
 * NAME curl_easy_reset()
 *
 * DESCRIPTION
 *
 * Re-initializes a CURL handle to the default values. This puts back the
 * handle to the same state as it was in when it was just created.
 *
 * It does keep: live connections, the Session ID cache, the DNS cache and the
 * cookies.
 '/
declare sub curl_easy_reset(byval curl as CURL ptr)

/'
 * NAME curl_easy_recv()
 *
 * DESCRIPTION
 *
 * Receives data from the connected socket. Use after successful
 * curl_easy_perform() with CURLOPT_CONNECT_ONLY option.
 '/
declare function curl_easy_recv(byval curl as CURL ptr, byval buffer as any ptr, byval buflen as size_t, _
                                byval n as size_t ptr) as CURLcode

/'
 * NAME curl_easy_send()
 *
 * DESCRIPTION
 *
 * Sends data over the connected socket. Use after successful
 * curl_easy_perform() with CURLOPT_CONNECT_ONLY option.
 '/
declare function curl_easy_send(byval curl as CURL ptr, byval buffer as const any ptr, _
                                byval buflen as size_t, byval n as size_t ptr) as CURLcode

type as any CURLM

enum CURLMcode
  CURLM_CALL_MULTI_PERFORM = -1  /' please call curl_multi_perform() or
                                    curl_multi_socket*() soon '/
  CURLM_OK
  CURLM_BAD_HANDLE      /' the passed-in handle is not a valid CURLM handle '/
  CURLM_BAD_EASY_HANDLE /' an easy handle was not good/valid '/
  CURLM_OUT_OF_MEMORY   /' if you ever get this, you're in deep sh*t '/
  CURLM_INTERNAL_ERROR  /' this is a libcurl bug '/
  CURLM_BAD_SOCKET      /' the passed in socket argument did not match '/
  CURLM_UNKNOWN_OPTION  /' curl_multi_setopt() with unsupported option '/
  CURLM_LAST
end enum

/' just to make code nicer when using curl_multi_socket() you can now check
   for CURLM_CALL_MULTI_SOCKET too in the same style it works for
   curl_multi_perform() and CURLM_CALL_MULTI_PERFORM '/
#define CURLM_CALL_MULTI_SOCKET CURLM_CALL_MULTI_PERFORM

enum CURLMSG_
  CURLMSG_NONE  /' first, not used '/
  CURLMSG_DONE  /' This easy handle has completed. 'result' contains
                   the CURLcode of the transfer '/
  CURLMSG_LAST  /' last, not used '/
end enum

union CURLMsg_data
  as any ptr whatever  /' message-specific data '/
  as CURLcode result   /' return code for transfer '/
end union

type CURLMsg
  as CURLMSG_ msg         /' what this message means '/
  as CURL ptr easy_handle /' the handle it concerns '/
  as CURLMsg_data data
end type

/'
 * Name:    curl_multi_init()
 *
 * Desc:    inititalize multi-style curl usage
 *
 * Returns: a new CURLM handle to use in all 'curl_multi' functions.
 '/
declare function curl_multi_init() as CURLM ptr

/'
 * Name:    curl_multi_add_handle()
 *
 * Desc:    add a standard curl handle to the multi stack
 *
 * Returns: CURLMcode type, general multi error code.
 '/
declare function curl_multi_add_handle(byval multi_handle as CURLM ptr, _
                                       byval curl_handle as CURL ptr) as CURLMcode

 /'
  * Name:    curl_multi_remove_handle()
  *
  * Desc:    removes a curl handle from the multi stack again
  *
  * Returns: CURLMcode type, general multi error code.
  '/
declare function curl_multi_remove_handle(byval multi_handle as CURLM ptr, _
                                          byval curl_handle as CURL ptr) as CURLMcode

 /'
  * Name:    curl_multi_fdset()
  *
  * Desc:    Ask curl for its fd_set sets. The app can use these to select() or
  *          poll() on. We want curl_multi_perform() called as soon as one of
  *          them are ready.
  *
  * Returns: CURLMcode type, general multi error code.
  '/
declare function curl_multi_fdset(byval multi_handle as CURLM ptr, _
                                  byval read_fd_set as fd_set ptr, _
                                  byval write_fd_set as fd_set ptr, _
                                  byval exc_fd_set as fd_set ptr, _
                                  byval max_fd as integer ptr) as CURLMcode

 /'
  * Name:    curl_multi_perform()
  *
  * Desc:    When the app thinks there's data available for curl it calls this
  *          function to read/write whatever there is right now. This returns
  *          as soon as the reads and writes are done. This function does not
  *          require that there actually is data available for reading or that
  *          data can be written, it can be called just in case. It returns
  *          the number of handles that still transfer data in the second
  *          argument's integer-pointer.
  *
  * Returns: CURLMcode type, general multi error code. *NOTE* that this only
  *          returns errors etc regarding the whole multi stack. There might
  *          still have occurred problems on invidual transfers even when this
  *          returns OK.
  '/
declare function curl_multi_perform(byval multi_handle as CURLM ptr, _
                                    byval running_handles as integer ptr) as CURLMcode

 /'
  * Name:    curl_multi_cleanup()
  *
  * Desc:    Cleans up and removes a whole multi stack. It does not free or
  *          touch any individual easy handles in any way. We need to define
  *          in what state those handles will be if this function is called
  *          in the middle of a transfer.
  *
  * Returns: CURLMcode type, general multi error code.
  '/
declare function curl_multi_cleanup(byval multi_handle as CURLM ptr) as CURLMcode

/'
 * Name:    curl_multi_info_read()
 *
 * Desc:    Ask the multi handle if there's any messages/informationals from
 *          the individual transfers. Messages include informationals such as
 *          error code from the transfer or just the fact that a transfer is
 *          completed. More details on these should be written down as well.
 *
 *          Repeated calls to this function will return a new struct each
 *          time, until a special "end of msgs" struct is returned as a signal
 *          that there is no more to get at this point.
 *
 *          The data the returned pointer points to will not survive calling
 *          curl_multi_cleanup().
 *
 *          The 'CURLMsg' struct is meant to be very simple and only contain
 *          very basic informations. If more involved information is wanted,
 *          we will provide the particular "transfer handle" in that struct
 *          and that should/could/would be used in subsequent
 *          curl_easy_getinfo() calls (or similar). The point being that we
 *          must never expose complex structs to applications, as then we'll
 *          undoubtably get backwards compatibility problems in the future.
 *
 * Returns: A pointer to a filled-in struct, or NULL if it failed or ran out
 *          of structs. It also writes the number of messages left in the
 *          queue (after this read) in the integer the second argument points
 *          to.
 '/
declare function curl_multi_info_read(byval multi_handle as CURLM ptr, _
                                      byval msgs_in_queue as integer ptr) as CURLMsg ptr

/'
 * Name:    curl_multi_strerror()
 *
 * Desc:    The curl_multi_strerror function may be used to turn a CURLMcode
 *          value into the equivalent human readable error string.  This is
 *          useful for printing meaningful error messages.
 *
 * Returns: A pointer to a zero-terminated error message.
 '/
declare function curl_multi_strerror(byval as CURLMcode) as const zstring ptr

/'
 * Name:    curl_multi_socket() and
 *          curl_multi_socket_all()
 *
 * Desc:    An alternative version of curl_multi_perform() that allows the
 *          application to pass in one of the file descriptors that have been
 *          detected to have "action" on them and let libcurl perform.
 *          See man page for details.
 '/
#define CURL_POLL_NONE   0
#define CURL_POLL_IN     1
#define CURL_POLL_OUT    2
#define CURL_POLL_INOUT  3
#define CURL_POLL_REMOVE 4

#define CURL_SOCKET_TIMEOUT CURL_SOCKET_BAD

#define CURL_CSELECT_IN   &h01
#define CURL_CSELECT_OUT  &h02
#define CURL_CSELECT_ERR  &h04

type as function(byval easy as CURL ptr,    /' easy handle '/ _
                 byval s as curl_socket_t,  /' socket '/ _
                 byval what as integer,     /' see above '/ _
                 byval userp as any ptr,    /' private callback pointer '/ _
                 byval socketp as any ptr) as integer curl_socket_callback  /' private socket pointer '/

/'
 * Name:    curl_multi_timer_callback
 *
 * Desc:    Called by libcurl whenever the library detects a change in the
 *          maximum number of milliseconds the app is allowed to wait before
 *          curl_multi_socket() or curl_multi_perform() must be called
 *          (to allow libcurl's timed events to take place).
 *
 * Returns: The callback should return zero.
 '/
type as function(byval multi as CURLM ptr, /' multi handle '/ _
                 byval timeout_ms as long, /' see above '/ _
                 byval userp as any ptr) as integer curl_multi_timer_callback  /' private callback pointer '/

declare function curl_multi_socket(byval multi_handle as CURLM ptr, byval s as curl_socket_t, _
                                   byval running_handles as integer ptr) as CURLMcode

declare function curl_multi_socket_action(byval multi_handle as CURLM ptr, _
                                          byval s as curl_socket_t, _
                                          byval ev_bitmask as integer, _
                                          byval running_handles as integer ptr) as CURLMcode

declare function curl_multi_socket_all(byval multi_handle as CURLM ptr, _
                                       byval running_handles as integer ptr) as CURLMcode

/'
 * Name:    curl_multi_timeout()
 *
 * Desc:    Returns the maximum number of milliseconds the app is allowed to
 *          wait before curl_multi_socket() or curl_multi_perform() must be
 *          called (to allow libcurl's timed events to take place).
 *
 * Returns: CURLM error code.
 '/
declare function curl_multi_timeout(byval multi_handle as CURLM ptr, _
                                    byval milliseconds as long ptr) as CURLMcode

#undef CINIT
#define CINIT(name,type,num) CURLMOPT_##name = CURLOPTTYPE_##type + num

enum CURLMoption
  /' This is the socket callback function pointer '/
  CINIT(SOCKETFUNCTION, FUNCTIONPOINT, 1)

  /' This is the argument passed to the socket callback '/
  CINIT(SOCKETDATA, OBJECTPOINT, 2)

    /' set to 1 to enable pipelining for this multi handle '/
  CINIT(PIPELINING, LONG, 3)

   /' This is the timer callback function pointer '/
  CINIT(TIMERFUNCTION, FUNCTIONPOINT, 4)

  /' This is the argument passed to the timer callback '/
  CINIT(TIMERDATA, OBJECTPOINT, 5)

  /' maximum number of entries in the connection cache '/
  CINIT(MAXCONNECTS, LONG, 6)

  CURLMOPT_LASTENTRY /' the last unused '/
end enum

/'
 * Name:    curl_multi_setopt()
 *
 * Desc:    Sets options for the multi handle.
 *
 * Returns: CURLM error code.
 '/
declare function curl_multi_setopt(byval multi_handle as CURLM ptr, _
                                   byval option as CURLMoption, ...) as CURLMcode

/'
 * Name:    curl_multi_assign()
 *
 * Desc:    This function sets an association in the multi handle between the
 *          given socket and a private pointer of the application. This is
 *          (only) useful for curl_multi_socket uses.
 *
 * Returns: CURLM error code.
 '/
declare function curl_multi_assign(byval multi_handle as CURLM ptr, _
                                   byval sockfd as curl_socket_t, byval sockp as any ptr) as CURLMcode

end extern

#endif
