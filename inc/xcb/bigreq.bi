'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2001-2004 Bart Massey, Jamey Sharp, and Josh Triplett.
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is
''   furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in all
''   copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
''   AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
''   ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
''   WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_BIG_REQUESTS_ENABLE => XCB_BIG_REQUESTS_ENABLE_

extern "C"

#define __BIGREQ_H
const XCB_BIGREQUESTS_MAJOR_VERSION = 0
const XCB_BIGREQUESTS_MINOR_VERSION = 0
extern xcb_big_requests_id as xcb_extension_t

type xcb_big_requests_enable_cookie_t
	sequence as ulong
end type

const XCB_BIG_REQUESTS_ENABLE_ = 0

type xcb_big_requests_enable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_big_requests_enable_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	maximum_request_length as ulong
end type

declare function xcb_big_requests_enable(byval c as xcb_connection_t ptr) as xcb_big_requests_enable_cookie_t
declare function xcb_big_requests_enable_unchecked(byval c as xcb_connection_t ptr) as xcb_big_requests_enable_cookie_t
declare function xcb_big_requests_enable_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_big_requests_enable_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_big_requests_enable_reply_t ptr

end extern
