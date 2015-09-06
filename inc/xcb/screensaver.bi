'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2005 Vincent Torri.
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person ob/Sintaining a copy
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
''     constant XCB_SCREENSAVER_QUERY_VERSION => XCB_SCREENSAVER_QUERY_VERSION_
''     constant XCB_SCREENSAVER_QUERY_INFO => XCB_SCREENSAVER_QUERY_INFO_
''     constant XCB_SCREENSAVER_SELECT_INPUT => XCB_SCREENSAVER_SELECT_INPUT_
''     constant XCB_SCREENSAVER_SET_ATTRIBUTES => XCB_SCREENSAVER_SET_ATTRIBUTES_
''     constant XCB_SCREENSAVER_UNSET_ATTRIBUTES => XCB_SCREENSAVER_UNSET_ATTRIBUTES_
''     constant XCB_SCREENSAVER_SUSPEND => XCB_SCREENSAVER_SUSPEND_

extern "C"

#define __SCREENSAVER_H
const XCB_SCREENSAVER_MAJOR_VERSION = 1
const XCB_SCREENSAVER_MINOR_VERSION = 1
extern xcb_screensaver_id as xcb_extension_t

type xcb_screensaver_kind_t as long
enum
	XCB_SCREENSAVER_KIND_BLANKED = 0
	XCB_SCREENSAVER_KIND_INTERNAL = 1
	XCB_SCREENSAVER_KIND_EXTERNAL = 2
end enum

type xcb_screensaver_event_t as long
enum
	XCB_SCREENSAVER_EVENT_NOTIFY_MASK = 1
	XCB_SCREENSAVER_EVENT_CYCLE_MASK = 2
end enum

type xcb_screensaver_state_t as long
enum
	XCB_SCREENSAVER_STATE_OFF = 0
	XCB_SCREENSAVER_STATE_ON = 1
	XCB_SCREENSAVER_STATE_CYCLE = 2
	XCB_SCREENSAVER_STATE_DISABLED = 3
end enum

type xcb_screensaver_query_version_cookie_t
	sequence as ulong
end type

const XCB_SCREENSAVER_QUERY_VERSION_ = 0

type xcb_screensaver_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ubyte
	client_minor_version as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_screensaver_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major_version as ushort
	server_minor_version as ushort
	pad1(0 to 19) as ubyte
end type

type xcb_screensaver_query_info_cookie_t
	sequence as ulong
end type

const XCB_SCREENSAVER_QUERY_INFO_ = 1

type xcb_screensaver_query_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

type xcb_screensaver_query_info_reply_t
	response_type as ubyte
	state as ubyte
	sequence as ushort
	length as ulong
	saver_window as xcb_window_t
	ms_until_server as ulong
	ms_since_user_input as ulong
	event_mask as ulong
	kind as ubyte
	pad0(0 to 6) as ubyte
end type

const XCB_SCREENSAVER_SELECT_INPUT_ = 2

type xcb_screensaver_select_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	event_mask as ulong
end type

const XCB_SCREENSAVER_SET_ATTRIBUTES_ = 3

type xcb_screensaver_set_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	x as short
	y as short
	width as ushort
	height as ushort
	border_width as ushort
	_class as ubyte
	depth as ubyte
	visual as xcb_visualid_t
	value_mask as ulong
end type

const XCB_SCREENSAVER_UNSET_ATTRIBUTES_ = 4

type xcb_screensaver_unset_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

const XCB_SCREENSAVER_SUSPEND_ = 5

type xcb_screensaver_suspend_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	suspend as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_SCREENSAVER_NOTIFY = 0

type xcb_screensaver_notify_event_t
	response_type as ubyte
	state as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	root as xcb_window_t
	window as xcb_window_t
	kind as ubyte
	forced as ubyte
	pad0(0 to 13) as ubyte
end type

declare function xcb_screensaver_query_version(byval c as xcb_connection_t ptr, byval client_major_version as ubyte, byval client_minor_version as ubyte) as xcb_screensaver_query_version_cookie_t
declare function xcb_screensaver_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ubyte, byval client_minor_version as ubyte) as xcb_screensaver_query_version_cookie_t
declare function xcb_screensaver_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_screensaver_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_screensaver_query_version_reply_t ptr
declare function xcb_screensaver_query_info(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_screensaver_query_info_cookie_t
declare function xcb_screensaver_query_info_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_screensaver_query_info_cookie_t
declare function xcb_screensaver_query_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_screensaver_query_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_screensaver_query_info_reply_t ptr
declare function xcb_screensaver_select_input_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_screensaver_select_input(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_screensaver_set_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_screensaver_set_attributes_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval border_width as ushort, byval _class as ubyte, byval depth as ubyte, byval visual as xcb_visualid_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_screensaver_set_attributes(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval border_width as ushort, byval _class as ubyte, byval depth as ubyte, byval visual as xcb_visualid_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_screensaver_unset_attributes_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_screensaver_unset_attributes(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_screensaver_suspend_checked(byval c as xcb_connection_t ptr, byval suspend as ubyte) as xcb_void_cookie_t
declare function xcb_screensaver_suspend(byval c as xcb_connection_t ptr, byval suspend as ubyte) as xcb_void_cookie_t

end extern
