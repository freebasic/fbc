'' FreeBASIC binding for xtrans-1.3.5

#pragma once

#include once "Xtrans.bi"
#include once "crt/errno.bi"

#ifdef __FB_WIN32__
	#include once "crt/limits.bi"
#else
	#include once "crt/sys/socket.bi"
	#include once "crt/netinet/in.bi"
	#include once "crt/arpa/inet.bi"
#endif

#include once "crt/stddef.bi"

extern "C"

#define _XTRANSINT_H_

#ifdef __FB_WIN32__
	#define _WILLWINSOCK_
	#define ESET(val) WSASetLastError(val)
	#define EGET() WSAGetLastError()
#else
	#define ESET(val) scope : errno = val : end scope
	#define EGET() errno
#endif

type _Xtransport as _Xtransport_
type _XtransConnFd as _XtransConnFd_

type _XtransConnInfo_
	transptr as _Xtransport ptr
	index as long
	priv as zstring ptr
	flags as long
	fd as long
	port as zstring ptr
	family as long
	addr as zstring ptr
	addrlen as long
	peeraddr as zstring ptr
	peeraddrlen as long
	recv_fds as _XtransConnFd ptr
	send_fds as _XtransConnFd ptr
end type

const XTRANS_OPEN_COTS_CLIENT = 1
const XTRANS_OPEN_COTS_SERVER = 2
const XTRANS_OPEN_CLTS_CLIENT = 3
const XTRANS_OPEN_CLTS_SERVER = 4

type _Xtransport_
	TransName as const zstring ptr
	flags as long
	SetOption as function(byval as XtransConnInfo, byval as long, byval as long) as long
	BytesReadable as function(byval as XtransConnInfo, byval as BytesReadable_t ptr) as long
	Read as function(byval as XtransConnInfo, byval as zstring ptr, byval as long) as long
	Write as function(byval as XtransConnInfo, byval as zstring ptr, byval as long) as long
	Readv as function(byval as XtransConnInfo, byval as iovec ptr, byval as long) as long
	Writev as function(byval as XtransConnInfo, byval as iovec ptr, byval as long) as long
	Disconnect as function(byval as XtransConnInfo) as long
	Close as function(byval as XtransConnInfo) as long
	CloseForCloning as function(byval as XtransConnInfo) as long
end type

type Xtransport as _Xtransport

type _Xtransport_table
	transport as Xtransport ptr
	transport_id as long
end type

type Xtransport_table as _Xtransport_table
const TRANS_ALIAS = 1 shl 0
const TRANS_LOCAL = 1 shl 1
const TRANS_DISABLED = 1 shl 2
const TRANS_NOLISTEN = 1 shl 3
const TRANS_NOUNLINK = 1 shl 4
const TRANS_ABSTRACT = 1 shl 5
const TRANS_NOXAUTH = 1 shl 6
const TRANS_RECEIVED = 1 shl 7
#define TRANS_KEEPFLAGS (TRANS_NOUNLINK or TRANS_ABSTRACT)

end extern
