'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2001-2006 Bart Massey, Jamey Sharp, and Josh Triplett.
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

#include once "crt/long.bi"
#ifdef __FB_WIN32__
	#include once "xcb_windefs.bi"
#else
	#include once "crt/sys/uio.bi"
#endif

extern "C"

#define __XCB_H__
const X_PROTOCOL = 11
const X_PROTOCOL_REVISION = 0
const X_TCP_PORT = 6000
const XCB_CONN_ERROR = 1
const XCB_CONN_CLOSED_EXT_NOTSUPPORTED = 2
const XCB_CONN_CLOSED_MEM_INSUFFICIENT = 3
const XCB_CONN_CLOSED_REQ_LEN_EXCEED = 4
const XCB_CONN_CLOSED_PARSE_ERR = 5
const XCB_CONN_CLOSED_INVALID_SCREEN = 6
const XCB_CONN_CLOSED_FDPASSING_FAILED = 7
#define XCB_TYPE_PAD(T, I) ((-(I)) and iif(sizeof(T) > 4, 3, sizeof(T) - 1))

type xcb_generic_iterator_t
	data as any ptr
	as long rem
	index as long
end type

type xcb_generic_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
end type

type xcb_generic_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	pad(0 to 6) as ulong
	full_sequence as ulong
end type

type xcb_ge_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	pad1 as ushort
	pad(0 to 4) as ulong
	full_sequence as ulong
end type

type xcb_generic_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	resource_id as ulong
	minor_code as ushort
	major_code as ubyte
	pad0 as ubyte
	pad(0 to 4) as ulong
	full_sequence as ulong
end type

type xcb_void_cookie_t
	sequence as ulong
end type

end extern

#include once "xproto.bi"

extern "C"

const XCB_NONE = cast(clong, 0)
const XCB_COPY_FROM_PARENT = cast(clong, 0)
const XCB_CURRENT_TIME = cast(clong, 0)
const XCB_NO_SYMBOL = cast(clong, 0)

type xcb_auth_info_t
	namelen as long
	name as zstring ptr
	datalen as long
	data as zstring ptr
end type

declare function xcb_flush(byval c as xcb_connection_t ptr) as long
declare function xcb_get_maximum_request_length(byval c as xcb_connection_t ptr) as ulong
declare sub xcb_prefetch_maximum_request_length(byval c as xcb_connection_t ptr)
declare function xcb_wait_for_event(byval c as xcb_connection_t ptr) as xcb_generic_event_t ptr
declare function xcb_poll_for_event(byval c as xcb_connection_t ptr) as xcb_generic_event_t ptr
declare function xcb_poll_for_queued_event(byval c as xcb_connection_t ptr) as xcb_generic_event_t ptr
type xcb_special_event_t as xcb_special_event
declare function xcb_poll_for_special_event(byval c as xcb_connection_t ptr, byval se as xcb_special_event_t ptr) as xcb_generic_event_t ptr
declare function xcb_wait_for_special_event(byval c as xcb_connection_t ptr, byval se as xcb_special_event_t ptr) as xcb_generic_event_t ptr
type xcb_extension_t as xcb_extension_t_
declare function xcb_register_for_special_xge(byval c as xcb_connection_t ptr, byval ext as xcb_extension_t ptr, byval eid as ulong, byval stamp as ulong ptr) as xcb_special_event_t ptr
declare sub xcb_unregister_for_special_event(byval c as xcb_connection_t ptr, byval se as xcb_special_event_t ptr)
declare function xcb_request_check(byval c as xcb_connection_t ptr, byval cookie as xcb_void_cookie_t) as xcb_generic_error_t ptr
declare sub xcb_discard_reply(byval c as xcb_connection_t ptr, byval sequence as ulong)
declare function xcb_get_extension_data(byval c as xcb_connection_t ptr, byval ext as xcb_extension_t ptr) as const xcb_query_extension_reply_t ptr
declare sub xcb_prefetch_extension_data(byval c as xcb_connection_t ptr, byval ext as xcb_extension_t ptr)
declare function xcb_get_setup(byval c as xcb_connection_t ptr) as const xcb_setup_t ptr
declare function xcb_get_file_descriptor(byval c as xcb_connection_t ptr) as long
declare function xcb_connection_has_error(byval c as xcb_connection_t ptr) as long
declare function xcb_connect_to_fd(byval fd as long, byval auth_info as xcb_auth_info_t ptr) as xcb_connection_t ptr
declare sub xcb_disconnect(byval c as xcb_connection_t ptr)
declare function xcb_parse_display(byval name as const zstring ptr, byval host as zstring ptr ptr, byval display as long ptr, byval screen as long ptr) as long
declare function xcb_connect(byval displayname as const zstring ptr, byval screenp as long ptr) as xcb_connection_t ptr
declare function xcb_connect_to_display_with_auth_info(byval display as const zstring ptr, byval auth as xcb_auth_info_t ptr, byval screen as long ptr) as xcb_connection_t ptr
declare function xcb_generate_id(byval c as xcb_connection_t ptr) as ulong

end extern
