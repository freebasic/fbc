'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2006 Jeremy Kolb.
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
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XINERAMA_QUERY_VERSION => XCB_XINERAMA_QUERY_VERSION_
''     constant XCB_XINERAMA_GET_STATE => XCB_XINERAMA_GET_STATE_
''     constant XCB_XINERAMA_GET_SCREEN_COUNT => XCB_XINERAMA_GET_SCREEN_COUNT_
''     constant XCB_XINERAMA_GET_SCREEN_SIZE => XCB_XINERAMA_GET_SCREEN_SIZE_
''     constant XCB_XINERAMA_IS_ACTIVE => XCB_XINERAMA_IS_ACTIVE_
''     constant XCB_XINERAMA_QUERY_SCREENS => XCB_XINERAMA_QUERY_SCREENS_

extern "C"

#define __XINERAMA_H
const XCB_XINERAMA_MAJOR_VERSION = 1
const XCB_XINERAMA_MINOR_VERSION = 1
extern xcb_xinerama_id as xcb_extension_t

type xcb_xinerama_screen_info_t
	x_org as short
	y_org as short
	width as ushort
	height as ushort
end type

type xcb_xinerama_screen_info_iterator_t
	data as xcb_xinerama_screen_info_t ptr
	as long rem
	index as long
end type

type xcb_xinerama_query_version_cookie_t
	sequence as ulong
end type

const XCB_XINERAMA_QUERY_VERSION_ = 0

type xcb_xinerama_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major as ubyte
	minor as ubyte
end type

type xcb_xinerama_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major as ushort
	minor as ushort
end type

type xcb_xinerama_get_state_cookie_t
	sequence as ulong
end type

const XCB_XINERAMA_GET_STATE_ = 1

type xcb_xinerama_get_state_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_xinerama_get_state_reply_t
	response_type as ubyte
	state as ubyte
	sequence as ushort
	length as ulong
	window as xcb_window_t
end type

type xcb_xinerama_get_screen_count_cookie_t
	sequence as ulong
end type

const XCB_XINERAMA_GET_SCREEN_COUNT_ = 2

type xcb_xinerama_get_screen_count_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_xinerama_get_screen_count_reply_t
	response_type as ubyte
	screen_count as ubyte
	sequence as ushort
	length as ulong
	window as xcb_window_t
end type

type xcb_xinerama_get_screen_size_cookie_t
	sequence as ulong
end type

const XCB_XINERAMA_GET_SCREEN_SIZE_ = 3

type xcb_xinerama_get_screen_size_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	screen as ulong
end type

type xcb_xinerama_get_screen_size_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width as ulong
	height as ulong
	window as xcb_window_t
	screen as ulong
end type

type xcb_xinerama_is_active_cookie_t
	sequence as ulong
end type

const XCB_XINERAMA_IS_ACTIVE_ = 4

type xcb_xinerama_is_active_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xinerama_is_active_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	state as ulong
end type

type xcb_xinerama_query_screens_cookie_t
	sequence as ulong
end type

const XCB_XINERAMA_QUERY_SCREENS_ = 5

type xcb_xinerama_query_screens_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xinerama_query_screens_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	number as ulong
	pad1(0 to 19) as ubyte
end type

declare sub xcb_xinerama_screen_info_next(byval i as xcb_xinerama_screen_info_iterator_t ptr)
declare function xcb_xinerama_screen_info_end(byval i as xcb_xinerama_screen_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_xinerama_query_version(byval c as xcb_connection_t ptr, byval major as ubyte, byval minor as ubyte) as xcb_xinerama_query_version_cookie_t
declare function xcb_xinerama_query_version_unchecked(byval c as xcb_connection_t ptr, byval major as ubyte, byval minor as ubyte) as xcb_xinerama_query_version_cookie_t
declare function xcb_xinerama_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xinerama_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xinerama_query_version_reply_t ptr
declare function xcb_xinerama_get_state(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_xinerama_get_state_cookie_t
declare function xcb_xinerama_get_state_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_xinerama_get_state_cookie_t
declare function xcb_xinerama_get_state_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xinerama_get_state_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xinerama_get_state_reply_t ptr
declare function xcb_xinerama_get_screen_count(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_xinerama_get_screen_count_cookie_t
declare function xcb_xinerama_get_screen_count_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_xinerama_get_screen_count_cookie_t
declare function xcb_xinerama_get_screen_count_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xinerama_get_screen_count_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xinerama_get_screen_count_reply_t ptr
declare function xcb_xinerama_get_screen_size(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval screen as ulong) as xcb_xinerama_get_screen_size_cookie_t
declare function xcb_xinerama_get_screen_size_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval screen as ulong) as xcb_xinerama_get_screen_size_cookie_t
declare function xcb_xinerama_get_screen_size_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xinerama_get_screen_size_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xinerama_get_screen_size_reply_t ptr
declare function xcb_xinerama_is_active(byval c as xcb_connection_t ptr) as xcb_xinerama_is_active_cookie_t
declare function xcb_xinerama_is_active_unchecked(byval c as xcb_connection_t ptr) as xcb_xinerama_is_active_cookie_t
declare function xcb_xinerama_is_active_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xinerama_is_active_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xinerama_is_active_reply_t ptr
declare function xcb_xinerama_query_screens_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xinerama_query_screens(byval c as xcb_connection_t ptr) as xcb_xinerama_query_screens_cookie_t
declare function xcb_xinerama_query_screens_unchecked(byval c as xcb_connection_t ptr) as xcb_xinerama_query_screens_cookie_t
declare function xcb_xinerama_query_screens_screen_info(byval R as const xcb_xinerama_query_screens_reply_t ptr) as xcb_xinerama_screen_info_t ptr
declare function xcb_xinerama_query_screens_screen_info_length(byval R as const xcb_xinerama_query_screens_reply_t ptr) as long
declare function xcb_xinerama_query_screens_screen_info_iterator(byval R as const xcb_xinerama_query_screens_reply_t ptr) as xcb_xinerama_screen_info_iterator_t
declare function xcb_xinerama_query_screens_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xinerama_query_screens_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xinerama_query_screens_reply_t ptr

end extern
