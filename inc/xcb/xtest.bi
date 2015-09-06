'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2006 Ian Osgood
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
''     constant XCB_TEST_GET_VERSION => XCB_TEST_GET_VERSION_
''     constant XCB_TEST_COMPARE_CURSOR => XCB_TEST_COMPARE_CURSOR_
''     constant XCB_TEST_FAKE_INPUT => XCB_TEST_FAKE_INPUT_
''     constant XCB_TEST_GRAB_CONTROL => XCB_TEST_GRAB_CONTROL_

extern "C"

#define __XTEST_H
const XCB_TEST_MAJOR_VERSION = 2
const XCB_TEST_MINOR_VERSION = 2
extern xcb_test_id as xcb_extension_t

type xcb_test_get_version_cookie_t
	sequence as ulong
end type

const XCB_TEST_GET_VERSION_ = 0

type xcb_test_get_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ubyte
	pad0 as ubyte
	minor_version as ushort
end type

type xcb_test_get_version_reply_t
	response_type as ubyte
	major_version as ubyte
	sequence as ushort
	length as ulong
	minor_version as ushort
end type

type xcb_test_cursor_t as long
enum
	XCB_TEST_CURSOR_NONE = 0
	XCB_TEST_CURSOR_CURRENT = 1
end enum

type xcb_test_compare_cursor_cookie_t
	sequence as ulong
end type

const XCB_TEST_COMPARE_CURSOR_ = 1

type xcb_test_compare_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	cursor as xcb_cursor_t
end type

type xcb_test_compare_cursor_reply_t
	response_type as ubyte
	same as ubyte
	sequence as ushort
	length as ulong
end type

const XCB_TEST_FAKE_INPUT_ = 2

type xcb_test_fake_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	as ubyte type
	detail as ubyte
	pad0(0 to 1) as ubyte
	time as ulong
	root as xcb_window_t
	pad1(0 to 7) as ubyte
	rootX as short
	rootY as short
	pad2(0 to 6) as ubyte
	deviceid as ubyte
end type

const XCB_TEST_GRAB_CONTROL_ = 3

type xcb_test_grab_control_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	impervious as ubyte
	pad0(0 to 2) as ubyte
end type

declare function xcb_test_get_version(byval c as xcb_connection_t ptr, byval major_version as ubyte, byval minor_version as ushort) as xcb_test_get_version_cookie_t
declare function xcb_test_get_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ubyte, byval minor_version as ushort) as xcb_test_get_version_cookie_t
declare function xcb_test_get_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_test_get_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_test_get_version_reply_t ptr
declare function xcb_test_compare_cursor(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval cursor as xcb_cursor_t) as xcb_test_compare_cursor_cookie_t
declare function xcb_test_compare_cursor_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval cursor as xcb_cursor_t) as xcb_test_compare_cursor_cookie_t
declare function xcb_test_compare_cursor_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_test_compare_cursor_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_test_compare_cursor_reply_t ptr
declare function xcb_test_fake_input_checked(byval c as xcb_connection_t ptr, byval type as ubyte, byval detail as ubyte, byval time as ulong, byval root as xcb_window_t, byval rootX as short, byval rootY as short, byval deviceid as ubyte) as xcb_void_cookie_t
declare function xcb_test_fake_input(byval c as xcb_connection_t ptr, byval type as ubyte, byval detail as ubyte, byval time as ulong, byval root as xcb_window_t, byval rootX as short, byval rootY as short, byval deviceid as ubyte) as xcb_void_cookie_t
declare function xcb_test_grab_control_checked(byval c as xcb_connection_t ptr, byval impervious as ubyte) as xcb_void_cookie_t
declare function xcb_test_grab_control(byval c as xcb_connection_t ptr, byval impervious as ubyte) as xcb_void_cookie_t

end extern
