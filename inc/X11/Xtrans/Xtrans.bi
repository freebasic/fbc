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

#ifndef __FB_64BIT__
	#include once "crt/long.bi"
#endif

#include once "X11/Xfuncproto.bi"
#include once "X11/Xos.bi"

#ifdef __FB_UNIX__
	#include once "crt/sys/socket.bi"
	#include once "crt/sys/uio.bi"
#endif

#ifdef __FB_WIN32__
	#include once "X11/Xw32defs.bi"
#endif

extern "C"

#define _XTRANS_H_
#define TRANS(func) _XTrans##func
const XTRANS_MAX_ADDR_LEN = 128

type Xtransaddr
	addr(0 to 127) as ubyte
end type

#ifdef __FB_64BIT__
	type BytesReadable_t as long
#else
	type BytesReadable_t as clong
#endif

type _XtransConnInfo as _XtransConnInfo_
type XtransConnInfo as _XtransConnInfo ptr
const TRANS_NONBLOCKING = 1
const TRANS_CLOSEONEXEC = 2
const TRANS_CONNECT_FAILED = -1
const TRANS_TRY_CONNECT_AGAIN = -2
const TRANS_IN_PROGRESS = -3
const TRANS_CREATE_LISTENER_FAILED = -1
const TRANS_ADDR_IN_USE = -2
const TRANS_ACCEPT_BAD_MALLOC = -1
const TRANS_ACCEPT_FAILED = -2
const TRANS_ACCEPT_MISC_ERROR = -3
const TRANS_RESET_NOOP = 1
const TRANS_RESET_NEW_FD = 2
const TRANS_RESET_FAILURE = 3

declare sub _XTransFreeConnInfo(byval as XtransConnInfo)
declare function _XTransSetOption(byval as XtransConnInfo, byval as long, byval as long) as long
declare function _XTransBytesReadable(byval as XtransConnInfo, byval as BytesReadable_t ptr) as long
declare function _XTransRead(byval as XtransConnInfo, byval as zstring ptr, byval as long) as long
declare function _XTransWrite(byval as XtransConnInfo, byval as zstring ptr, byval as long) as long
declare function _XTransReadv(byval as XtransConnInfo, byval as iovec ptr, byval as long) as long
declare function _XTransWritev(byval as XtransConnInfo, byval as iovec ptr, byval as long) as long
declare function _XTransSendFd(byval ciptr as XtransConnInfo, byval fd as long, byval do_close as long) as long
declare function _XTransRecvFd(byval ciptr as XtransConnInfo) as long
declare function _XTransDisconnect(byval as XtransConnInfo) as long
declare function _XTransClose(byval as XtransConnInfo) as long
declare function _XTransCloseForCloning(byval as XtransConnInfo) as long
declare function _XTransIsLocal(byval as XtransConnInfo) as long
declare function _XTransGetMyAddr(byval as XtransConnInfo, byval as long ptr, byval as long ptr, byval as Xtransaddr ptr ptr) as long
declare function _XTransGetPeerAddr(byval as XtransConnInfo, byval as long ptr, byval as long ptr, byval as Xtransaddr ptr ptr) as long
declare function _XTransGetConnectionNumber(byval as XtransConnInfo) as long
declare function _XTransGetHostname(byval as zstring ptr, byval as long) as long

end extern
