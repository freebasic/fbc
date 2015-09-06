'' FreeBASIC binding for xtrans-1.3.5
''
'' based on the C header files:
''
''   Copyright 1993, 1994, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
''   OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR
''   OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
''   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall
''   not be used in advertising or otherwise to promote the sale, use or
''   other dealings in this Software without prior written authorization
''   from The Open Group.
''
''    * Copyright 1993, 1994 NCR Corporation - Dayton, Ohio, USA
''    *
''    * All Rights Reserved
''    *
''    * Permission to use, copy, modify, and distribute this software and its
''    * documentation for any purpose and without fee is hereby granted, provided
''    * that the above copyright notice appear in all copies and that both that
''    * copyright notice and this permission notice appear in supporting
''    * documentation, and that the name NCR not be used in advertising
''    * or publicity pertaining to distribution of the software without specific,
''    * written prior permission.  NCR makes no representations about the
''    * suitability of this software for any purpose.  It is provided "as is"
''    * without express or implied warranty.
''    *
''    * NCR DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''    * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN
''    * NO EVENT SHALL NCR BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''    * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS
''    * OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT,
''    * NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN
''    * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "Xtrans.bi"
#include once "crt/errno.bi"

#ifdef __FB_UNIX__
	#include once "crt/sys/socket.bi"
	#include once "crt/netinet/in.bi"
	#include once "crt/arpa/inet.bi"
#else
	#include once "crt/limits.bi"
#endif

#include once "crt/stddef.bi"

extern "C"

#define _XTRANSINT_H_

#ifdef __FB_UNIX__
	#define ESET(val) scope : errno = val : end scope
	#define EGET() errno
#else
	#define _WILLWINSOCK_
	#define ESET(val) WSASetLastError(val)
	#define EGET() WSAGetLastError()
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
const TRANS_KEEPFLAGS = TRANS_NOUNLINK or TRANS_ABSTRACT

end extern
