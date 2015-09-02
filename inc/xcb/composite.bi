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
#include once "xproto.bi"
#include once "xfixes.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_COMPOSITE_QUERY_VERSION => XCB_COMPOSITE_QUERY_VERSION_
''     constant XCB_COMPOSITE_REDIRECT_WINDOW => XCB_COMPOSITE_REDIRECT_WINDOW_
''     constant XCB_COMPOSITE_REDIRECT_SUBWINDOWS => XCB_COMPOSITE_REDIRECT_SUBWINDOWS_
''     constant XCB_COMPOSITE_UNREDIRECT_WINDOW => XCB_COMPOSITE_UNREDIRECT_WINDOW_
''     constant XCB_COMPOSITE_UNREDIRECT_SUBWINDOWS => XCB_COMPOSITE_UNREDIRECT_SUBWINDOWS_
''     constant XCB_COMPOSITE_CREATE_REGION_FROM_BORDER_CLIP => XCB_COMPOSITE_CREATE_REGION_FROM_BORDER_CLIP_
''     constant XCB_COMPOSITE_NAME_WINDOW_PIXMAP => XCB_COMPOSITE_NAME_WINDOW_PIXMAP_
''     constant XCB_COMPOSITE_GET_OVERLAY_WINDOW => XCB_COMPOSITE_GET_OVERLAY_WINDOW_
''     constant XCB_COMPOSITE_RELEASE_OVERLAY_WINDOW => XCB_COMPOSITE_RELEASE_OVERLAY_WINDOW_

extern "C"

#define __COMPOSITE_H
const XCB_COMPOSITE_MAJOR_VERSION = 0
const XCB_COMPOSITE_MINOR_VERSION = 4
extern xcb_composite_id as xcb_extension_t

type xcb_composite_redirect_t as long
enum
	XCB_COMPOSITE_REDIRECT_AUTOMATIC = 0
	XCB_COMPOSITE_REDIRECT_MANUAL = 1
end enum

type xcb_composite_query_version_cookie_t
	sequence as ulong
end type

const XCB_COMPOSITE_QUERY_VERSION_ = 0

type xcb_composite_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ulong
	client_minor_version as ulong
end type

type xcb_composite_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
	pad1(0 to 15) as ubyte
end type

const XCB_COMPOSITE_REDIRECT_WINDOW_ = 1

type xcb_composite_redirect_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	update as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_COMPOSITE_REDIRECT_SUBWINDOWS_ = 2

type xcb_composite_redirect_subwindows_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	update as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_COMPOSITE_UNREDIRECT_WINDOW_ = 3

type xcb_composite_unredirect_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	update as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_COMPOSITE_UNREDIRECT_SUBWINDOWS_ = 4

type xcb_composite_unredirect_subwindows_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	update as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_COMPOSITE_CREATE_REGION_FROM_BORDER_CLIP_ = 5

type xcb_composite_create_region_from_border_clip_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
	window as xcb_window_t
end type

const XCB_COMPOSITE_NAME_WINDOW_PIXMAP_ = 6

type xcb_composite_name_window_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	pixmap as xcb_pixmap_t
end type

type xcb_composite_get_overlay_window_cookie_t
	sequence as ulong
end type

const XCB_COMPOSITE_GET_OVERLAY_WINDOW_ = 7

type xcb_composite_get_overlay_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_composite_get_overlay_window_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	overlay_win as xcb_window_t
	pad1(0 to 19) as ubyte
end type

const XCB_COMPOSITE_RELEASE_OVERLAY_WINDOW_ = 8

type xcb_composite_release_overlay_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

declare function xcb_composite_query_version(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_composite_query_version_cookie_t
declare function xcb_composite_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_composite_query_version_cookie_t
declare function xcb_composite_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_composite_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_composite_query_version_reply_t ptr
declare function xcb_composite_redirect_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_redirect_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_redirect_subwindows_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_redirect_subwindows(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_unredirect_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_unredirect_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_unredirect_subwindows_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_unredirect_subwindows(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval update as ubyte) as xcb_void_cookie_t
declare function xcb_composite_create_region_from_border_clip_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_composite_create_region_from_border_clip(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_composite_name_window_pixmap_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval pixmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_composite_name_window_pixmap(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval pixmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_composite_get_overlay_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_composite_get_overlay_window_cookie_t
declare function xcb_composite_get_overlay_window_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_composite_get_overlay_window_cookie_t
declare function xcb_composite_get_overlay_window_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_composite_get_overlay_window_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_composite_get_overlay_window_reply_t ptr
declare function xcb_composite_release_overlay_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_composite_release_overlay_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t

end extern
