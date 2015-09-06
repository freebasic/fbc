'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2004 Josh Triplett
''   Copyright (C) 2007 Jeremy Kolb
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
#include once "xfixes.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_DAMAGE_QUERY_VERSION => XCB_DAMAGE_QUERY_VERSION_
''     constant XCB_DAMAGE_CREATE => XCB_DAMAGE_CREATE_
''     constant XCB_DAMAGE_DESTROY => XCB_DAMAGE_DESTROY_
''     constant XCB_DAMAGE_SUBTRACT => XCB_DAMAGE_SUBTRACT_
''     constant XCB_DAMAGE_ADD => XCB_DAMAGE_ADD_
''     constant XCB_DAMAGE_NOTIFY => XCB_DAMAGE_NOTIFY_

extern "C"

#define __DAMAGE_H
const XCB_DAMAGE_MAJOR_VERSION = 1
const XCB_DAMAGE_MINOR_VERSION = 1
extern xcb_damage_id as xcb_extension_t
type xcb_damage_damage_t as ulong

type xcb_damage_damage_iterator_t
	data as xcb_damage_damage_t ptr
	as long rem
	index as long
end type

type xcb_damage_report_level_t as long
enum
	XCB_DAMAGE_REPORT_LEVEL_RAW_RECTANGLES = 0
	XCB_DAMAGE_REPORT_LEVEL_DELTA_RECTANGLES = 1
	XCB_DAMAGE_REPORT_LEVEL_BOUNDING_BOX = 2
	XCB_DAMAGE_REPORT_LEVEL_NON_EMPTY = 3
end enum

const XCB_DAMAGE_BAD_DAMAGE = 0

type xcb_damage_bad_damage_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

type xcb_damage_query_version_cookie_t
	sequence as ulong
end type

const XCB_DAMAGE_QUERY_VERSION_ = 0

type xcb_damage_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ulong
	client_minor_version as ulong
end type

type xcb_damage_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
	pad1(0 to 15) as ubyte
end type

const XCB_DAMAGE_CREATE_ = 1

type xcb_damage_create_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	damage as xcb_damage_damage_t
	drawable as xcb_drawable_t
	level as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_DAMAGE_DESTROY_ = 2

type xcb_damage_destroy_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	damage as xcb_damage_damage_t
end type

const XCB_DAMAGE_SUBTRACT_ = 3

type xcb_damage_subtract_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	damage as xcb_damage_damage_t
	repair as xcb_xfixes_region_t
	parts as xcb_xfixes_region_t
end type

const XCB_DAMAGE_ADD_ = 4

type xcb_damage_add_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	region as xcb_xfixes_region_t
end type

const XCB_DAMAGE_NOTIFY_ = 0

type xcb_damage_notify_event_t
	response_type as ubyte
	level as ubyte
	sequence as ushort
	drawable as xcb_drawable_t
	damage as xcb_damage_damage_t
	timestamp as xcb_timestamp_t
	area as xcb_rectangle_t
	geometry as xcb_rectangle_t
end type

declare sub xcb_damage_damage_next(byval i as xcb_damage_damage_iterator_t ptr)
declare function xcb_damage_damage_end(byval i as xcb_damage_damage_iterator_t) as xcb_generic_iterator_t
declare function xcb_damage_query_version(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_damage_query_version_cookie_t
declare function xcb_damage_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_damage_query_version_cookie_t
declare function xcb_damage_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_damage_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_damage_query_version_reply_t ptr
declare function xcb_damage_create_checked(byval c as xcb_connection_t ptr, byval damage as xcb_damage_damage_t, byval drawable as xcb_drawable_t, byval level as ubyte) as xcb_void_cookie_t
declare function xcb_damage_create(byval c as xcb_connection_t ptr, byval damage as xcb_damage_damage_t, byval drawable as xcb_drawable_t, byval level as ubyte) as xcb_void_cookie_t
declare function xcb_damage_destroy_checked(byval c as xcb_connection_t ptr, byval damage as xcb_damage_damage_t) as xcb_void_cookie_t
declare function xcb_damage_destroy(byval c as xcb_connection_t ptr, byval damage as xcb_damage_damage_t) as xcb_void_cookie_t
declare function xcb_damage_subtract_checked(byval c as xcb_connection_t ptr, byval damage as xcb_damage_damage_t, byval repair as xcb_xfixes_region_t, byval parts as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_damage_subtract(byval c as xcb_connection_t ptr, byval damage as xcb_damage_damage_t, byval repair as xcb_xfixes_region_t, byval parts as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_damage_add_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval region as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_damage_add(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval region as xcb_xfixes_region_t) as xcb_void_cookie_t

end extern
