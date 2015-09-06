'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2001-2004 Bart Massey and Jamey Sharp.
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
''   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the names of the authors or their
''   institutions shall not be used in advertising or otherwise to promote the
''   sale, use or other dealings in this Software without prior written
''   authorization from the authors.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"

extern "C"

#define __XCBEXT_H

type xcb_extension_t_
	name as const zstring ptr
	global_id as long
end type

type xcb_protocol_request_t
	count as uinteger
	ext as xcb_extension_t ptr
	opcode as ubyte
	isvoid as ubyte
end type

type xcb_send_request_flags_t as long
enum
	XCB_REQUEST_CHECKED = 1 shl 0
	XCB_REQUEST_RAW = 1 shl 1
	XCB_REQUEST_DISCARD_REPLY = 1 shl 2
	XCB_REQUEST_REPLY_FDS = 1 shl 3
end enum

declare function xcb_send_request(byval c as xcb_connection_t ptr, byval flags as long, byval vector as iovec ptr, byval request as const xcb_protocol_request_t ptr) as ulong
declare sub xcb_send_fd(byval c as xcb_connection_t ptr, byval fd as long)
declare function xcb_take_socket(byval c as xcb_connection_t ptr, byval return_socket as sub(byval closure as any ptr), byval closure as any ptr, byval flags as long, byval sent as ulongint ptr) as long
declare function xcb_writev(byval c as xcb_connection_t ptr, byval vector as iovec ptr, byval count as long, byval requests as ulongint) as long
declare function xcb_wait_for_reply(byval c as xcb_connection_t ptr, byval request as ulong, byval e as xcb_generic_error_t ptr ptr) as any ptr
declare function xcb_poll_for_reply(byval c as xcb_connection_t ptr, byval request as ulong, byval reply as any ptr ptr, byval error as xcb_generic_error_t ptr ptr) as long
declare function xcb_get_reply_fds(byval c as xcb_connection_t ptr, byval reply as any ptr, byval replylen as uinteger) as long ptr
declare function xcb_popcount(byval mask as ulong) as long
declare function xcb_sumof(byval list as ubyte ptr, byval len as long) as long

end extern
