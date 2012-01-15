''
''
'' Xtrans -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xtrans_bi__
#define __Xtrans_bi__

#define XTRANS_MAX_ADDR_LEN 128

type Xtransaddr
	addr(0 to 128-1) as ubyte
end type

type BytesReadable_t as integer
type XtransConnInfo as _XtransConnInfo ptr

#define TRANS_NONBLOCKING 1
#define TRANS_CLOSEONEXEC 2
#define TRANS_CONNECT_FAILED -1
#define TRANS_TRY_CONNECT_AGAIN -2
#define TRANS_IN_PROGRESS -3
#define TRANS_CREATE_LISTENER_FAILED -1
#define TRANS_ADDR_IN_USE -2
#define TRANS_ACCEPT_BAD_MALLOC -1
#define TRANS_ACCEPT_FAILED -2
#define TRANS_ACCEPT_MISC_ERROR -3
#define TRANS_RESET_NOOP 1
#define TRANS_RESET_NEW_FD 2
#define TRANS_RESET_FAILURE 3

declare sub _XTransFreeConnInfo cdecl alias "_XTransFreeConnInfo" (byval as XtransConnInfo)
declare function _XTransSetOption cdecl alias "_XTransSetOption" (byval as XtransConnInfo, byval as integer, byval as integer) as integer
declare function _XTransBytesReadable cdecl alias "_XTransBytesReadable" (byval as XtransConnInfo, byval as BytesReadable_t ptr) as integer
declare function _XTransRead cdecl alias "_XTransRead" (byval as XtransConnInfo, byval as zstring ptr, byval as integer) as integer
declare function _XTransWrite cdecl alias "_XTransWrite" (byval as XtransConnInfo, byval as zstring ptr, byval as integer) as integer
declare function _XTransReadv cdecl alias "_XTransReadv" (byval as XtransConnInfo, byval as iovec ptr, byval as integer) as integer
declare function _XTransWritev cdecl alias "_XTransWritev" (byval as XtransConnInfo, byval as iovec ptr, byval as integer) as integer
declare function _XTransDisconnect cdecl alias "_XTransDisconnect" (byval as XtransConnInfo) as integer
declare function _XTransClose cdecl alias "_XTransClose" (byval as XtransConnInfo) as integer
declare function _XTransCloseForCloning cdecl alias "_XTransCloseForCloning" (byval as XtransConnInfo) as integer
declare function _XTransIsLocal cdecl alias "_XTransIsLocal" (byval as XtransConnInfo) as integer
declare function _XTransGetMyAddr cdecl alias "_XTransGetMyAddr" (byval as XtransConnInfo, byval as integer ptr, byval as integer ptr, byval as Xtransaddr ptr ptr) as integer
declare function _XTransGetPeerAddr cdecl alias "_XTransGetPeerAddr" (byval as XtransConnInfo, byval as integer ptr, byval as integer ptr, byval as Xtransaddr ptr ptr) as integer
declare function _XTransGetConnectionNumber cdecl alias "_XTransGetConnectionNumber" (byval as XtransConnInfo) as integer
declare function _XTransGetHostname cdecl alias "_XTransGetHostname" (byval as zstring ptr, byval as integer) as integer

#endif
