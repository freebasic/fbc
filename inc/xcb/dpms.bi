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
''     constant XCB_DPMS_GET_VERSION => XCB_DPMS_GET_VERSION_
''     constant XCB_DPMS_CAPABLE => XCB_DPMS_CAPABLE_
''     constant XCB_DPMS_GET_TIMEOUTS => XCB_DPMS_GET_TIMEOUTS_
''     constant XCB_DPMS_SET_TIMEOUTS => XCB_DPMS_SET_TIMEOUTS_
''     constant XCB_DPMS_ENABLE => XCB_DPMS_ENABLE_
''     constant XCB_DPMS_DISABLE => XCB_DPMS_DISABLE_
''     constant XCB_DPMS_FORCE_LEVEL => XCB_DPMS_FORCE_LEVEL_
''     constant XCB_DPMS_INFO => XCB_DPMS_INFO_

extern "C"

#define __DPMS_H
const XCB_DPMS_MAJOR_VERSION = 0
const XCB_DPMS_MINOR_VERSION = 0
extern xcb_dpms_id as xcb_extension_t

type xcb_dpms_get_version_cookie_t
	sequence as ulong
end type

const XCB_DPMS_GET_VERSION_ = 0

type xcb_dpms_get_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ushort
	client_minor_version as ushort
end type

type xcb_dpms_get_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	server_major_version as ushort
	server_minor_version as ushort
end type

type xcb_dpms_capable_cookie_t
	sequence as ulong
end type

const XCB_DPMS_CAPABLE_ = 1

type xcb_dpms_capable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_dpms_capable_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	capable as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_dpms_get_timeouts_cookie_t
	sequence as ulong
end type

const XCB_DPMS_GET_TIMEOUTS_ = 2

type xcb_dpms_get_timeouts_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_dpms_get_timeouts_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	standby_timeout as ushort
	suspend_timeout as ushort
	off_timeout as ushort
	pad1(0 to 17) as ubyte
end type

const XCB_DPMS_SET_TIMEOUTS_ = 3

type xcb_dpms_set_timeouts_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	standby_timeout as ushort
	suspend_timeout as ushort
	off_timeout as ushort
end type

const XCB_DPMS_ENABLE_ = 4

type xcb_dpms_enable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

const XCB_DPMS_DISABLE_ = 5

type xcb_dpms_disable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_dpms_dpms_mode_t as long
enum
	XCB_DPMS_DPMS_MODE_ON = 0
	XCB_DPMS_DPMS_MODE_STANDBY = 1
	XCB_DPMS_DPMS_MODE_SUSPEND = 2
	XCB_DPMS_DPMS_MODE_OFF = 3
end enum

const XCB_DPMS_FORCE_LEVEL_ = 6

type xcb_dpms_force_level_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	power_level as ushort
end type

type xcb_dpms_info_cookie_t
	sequence as ulong
end type

const XCB_DPMS_INFO_ = 7

type xcb_dpms_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_dpms_info_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	power_level as ushort
	state as ubyte
	pad1(0 to 20) as ubyte
end type

declare function xcb_dpms_get_version(byval c as xcb_connection_t ptr, byval client_major_version as ushort, byval client_minor_version as ushort) as xcb_dpms_get_version_cookie_t
declare function xcb_dpms_get_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ushort, byval client_minor_version as ushort) as xcb_dpms_get_version_cookie_t
declare function xcb_dpms_get_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dpms_get_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dpms_get_version_reply_t ptr
declare function xcb_dpms_capable(byval c as xcb_connection_t ptr) as xcb_dpms_capable_cookie_t
declare function xcb_dpms_capable_unchecked(byval c as xcb_connection_t ptr) as xcb_dpms_capable_cookie_t
declare function xcb_dpms_capable_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dpms_capable_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dpms_capable_reply_t ptr
declare function xcb_dpms_get_timeouts(byval c as xcb_connection_t ptr) as xcb_dpms_get_timeouts_cookie_t
declare function xcb_dpms_get_timeouts_unchecked(byval c as xcb_connection_t ptr) as xcb_dpms_get_timeouts_cookie_t
declare function xcb_dpms_get_timeouts_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dpms_get_timeouts_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dpms_get_timeouts_reply_t ptr
declare function xcb_dpms_set_timeouts_checked(byval c as xcb_connection_t ptr, byval standby_timeout as ushort, byval suspend_timeout as ushort, byval off_timeout as ushort) as xcb_void_cookie_t
declare function xcb_dpms_set_timeouts(byval c as xcb_connection_t ptr, byval standby_timeout as ushort, byval suspend_timeout as ushort, byval off_timeout as ushort) as xcb_void_cookie_t
declare function xcb_dpms_enable_checked(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_dpms_enable(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_dpms_disable_checked(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_dpms_disable(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_dpms_force_level_checked(byval c as xcb_connection_t ptr, byval power_level as ushort) as xcb_void_cookie_t
declare function xcb_dpms_force_level(byval c as xcb_connection_t ptr, byval power_level as ushort) as xcb_void_cookie_t
declare function xcb_dpms_info(byval c as xcb_connection_t ptr) as xcb_dpms_info_cookie_t
declare function xcb_dpms_info_unchecked(byval c as xcb_connection_t ptr) as xcb_dpms_info_cookie_t
declare function xcb_dpms_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dpms_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dpms_info_reply_t ptr

end extern
