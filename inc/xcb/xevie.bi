'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2004 Josh Triplett.  All Rights Reserved.
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
''     constant XCB_XEVIE_QUERY_VERSION => XCB_XEVIE_QUERY_VERSION_
''     constant XCB_XEVIE_START => XCB_XEVIE_START_
''     constant XCB_XEVIE_END => XCB_XEVIE_END_
''     constant XCB_XEVIE_SEND => XCB_XEVIE_SEND_
''     constant XCB_XEVIE_SELECT_INPUT => XCB_XEVIE_SELECT_INPUT_

extern "C"

#define __XEVIE_H
const XCB_XEVIE_MAJOR_VERSION = 1
const XCB_XEVIE_MINOR_VERSION = 0
extern xcb_xevie_id as xcb_extension_t

type xcb_xevie_query_version_cookie_t
	sequence as ulong
end type

const XCB_XEVIE_QUERY_VERSION_ = 0

type xcb_xevie_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ushort
	client_minor_version as ushort
end type

type xcb_xevie_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major_version as ushort
	server_minor_version as ushort
	pad1(0 to 19) as ubyte
end type

type xcb_xevie_start_cookie_t
	sequence as ulong
end type

const XCB_XEVIE_START_ = 1

type xcb_xevie_start_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_xevie_start_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_xevie_end_cookie_t
	sequence as ulong
end type

const XCB_XEVIE_END_ = 2

type xcb_xevie_end_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cmap as ulong
end type

type xcb_xevie_end_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_xevie_datatype_t as long
enum
	XCB_XEVIE_DATATYPE_UNMODIFIED = 0
	XCB_XEVIE_DATATYPE_MODIFIED = 1
end enum

type xcb_xevie_event_t
	pad0(0 to 31) as ubyte
end type

type xcb_xevie_event_iterator_t
	data as xcb_xevie_event_t ptr
	as long rem
	index as long
end type

type xcb_xevie_send_cookie_t
	sequence as ulong
end type

const XCB_XEVIE_SEND_ = 3

type xcb_xevie_send_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	event as xcb_xevie_event_t
	data_type as ulong
	pad0(0 to 63) as ubyte
end type

type xcb_xevie_send_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_xevie_select_input_cookie_t
	sequence as ulong
end type

const XCB_XEVIE_SELECT_INPUT_ = 4

type xcb_xevie_select_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	event_mask as ulong
end type

type xcb_xevie_select_input_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

declare function xcb_xevie_query_version(byval c as xcb_connection_t ptr, byval client_major_version as ushort, byval client_minor_version as ushort) as xcb_xevie_query_version_cookie_t
declare function xcb_xevie_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ushort, byval client_minor_version as ushort) as xcb_xevie_query_version_cookie_t
declare function xcb_xevie_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xevie_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xevie_query_version_reply_t ptr
declare function xcb_xevie_start(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xevie_start_cookie_t
declare function xcb_xevie_start_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xevie_start_cookie_t
declare function xcb_xevie_start_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xevie_start_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xevie_start_reply_t ptr
declare function xcb_xevie_end(byval c as xcb_connection_t ptr, byval cmap as ulong) as xcb_xevie_end_cookie_t
declare function xcb_xevie_end_unchecked(byval c as xcb_connection_t ptr, byval cmap as ulong) as xcb_xevie_end_cookie_t
declare function xcb_xevie_end_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xevie_end_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xevie_end_reply_t ptr
declare sub xcb_xevie_event_next(byval i as xcb_xevie_event_iterator_t ptr)
declare function xcb_xevie_event_end(byval i as xcb_xevie_event_iterator_t) as xcb_generic_iterator_t
declare function xcb_xevie_send(byval c as xcb_connection_t ptr, byval event as xcb_xevie_event_t, byval data_type as ulong) as xcb_xevie_send_cookie_t
declare function xcb_xevie_send_unchecked(byval c as xcb_connection_t ptr, byval event as xcb_xevie_event_t, byval data_type as ulong) as xcb_xevie_send_cookie_t
declare function xcb_xevie_send_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xevie_send_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xevie_send_reply_t ptr
declare function xcb_xevie_select_input(byval c as xcb_connection_t ptr, byval event_mask as ulong) as xcb_xevie_select_input_cookie_t
declare function xcb_xevie_select_input_unchecked(byval c as xcb_connection_t ptr, byval event_mask as ulong) as xcb_xevie_select_input_cookie_t
declare function xcb_xevie_select_input_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xevie_select_input_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xevie_select_input_reply_t ptr

end extern
