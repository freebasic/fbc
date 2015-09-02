'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright © 2013 Keith Packard
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that copyright
''   notice and this permission notice appear in supporting documentation, and
''   that the name of the copyright holders not be used in advertising or
''   publicity pertaining to distribution of the software without specific,
''   written prior permission.  The copyright holders make no representations
''   about the suitability of this software for any purpose.  It is provided "as
''   is" without express or implied warranty.
''
''   THE COPYRIGHT HOLDERS DISCLAIM ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
''   INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
''   EVENT SHALL THE COPYRIGHT HOLDERS BE LIABLE FOR ANY SPECIAL, INDIRECT OR
''   CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,
''   DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER
''   TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE
''   OF THIS SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_DRI3_QUERY_VERSION => XCB_DRI3_QUERY_VERSION_
''     constant XCB_DRI3_OPEN => XCB_DRI3_OPEN_
''     constant XCB_DRI3_PIXMAP_FROM_BUFFER => XCB_DRI3_PIXMAP_FROM_BUFFER_
''     constant XCB_DRI3_BUFFER_FROM_PIXMAP => XCB_DRI3_BUFFER_FROM_PIXMAP_
''     constant XCB_DRI3_FENCE_FROM_FD => XCB_DRI3_FENCE_FROM_FD_
''     constant XCB_DRI3_FD_FROM_FENCE => XCB_DRI3_FD_FROM_FENCE_

extern "C"

#define __DRI3_H
const XCB_DRI3_MAJOR_VERSION = 1
const XCB_DRI3_MINOR_VERSION = 0
extern xcb_dri3_id as xcb_extension_t

type xcb_dri3_query_version_cookie_t
	sequence as ulong
end type

const XCB_DRI3_QUERY_VERSION_ = 0

type xcb_dri3_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
end type

type xcb_dri3_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
end type

type xcb_dri3_open_cookie_t
	sequence as ulong
end type

const XCB_DRI3_OPEN_ = 1

type xcb_dri3_open_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	provider as ulong
end type

type xcb_dri3_open_reply_t
	response_type as ubyte
	nfd as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

const XCB_DRI3_PIXMAP_FROM_BUFFER_ = 2

type xcb_dri3_pixmap_from_buffer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	pixmap as xcb_pixmap_t
	drawable as xcb_drawable_t
	size as ulong
	width as ushort
	height as ushort
	stride as ushort
	depth as ubyte
	bpp as ubyte
end type

type xcb_dri3_buffer_from_pixmap_cookie_t
	sequence as ulong
end type

const XCB_DRI3_BUFFER_FROM_PIXMAP_ = 3

type xcb_dri3_buffer_from_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	pixmap as xcb_pixmap_t
end type

type xcb_dri3_buffer_from_pixmap_reply_t
	response_type as ubyte
	nfd as ubyte
	sequence as ushort
	length as ulong
	size as ulong
	width as ushort
	height as ushort
	stride as ushort
	depth as ubyte
	bpp as ubyte
	pad0(0 to 11) as ubyte
end type

const XCB_DRI3_FENCE_FROM_FD_ = 4

type xcb_dri3_fence_from_fd_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	fence as ulong
	initially_triggered as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_dri3_fd_from_fence_cookie_t
	sequence as ulong
end type

const XCB_DRI3_FD_FROM_FENCE_ = 5

type xcb_dri3_fd_from_fence_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	fence as ulong
end type

type xcb_dri3_fd_from_fence_reply_t
	response_type as ubyte
	nfd as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

declare function xcb_dri3_query_version(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_dri3_query_version_cookie_t
declare function xcb_dri3_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_dri3_query_version_cookie_t
declare function xcb_dri3_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri3_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri3_query_version_reply_t ptr
declare function xcb_dri3_open(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval provider as ulong) as xcb_dri3_open_cookie_t
declare function xcb_dri3_open_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval provider as ulong) as xcb_dri3_open_cookie_t
declare function xcb_dri3_open_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri3_open_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri3_open_reply_t ptr
declare function xcb_dri3_open_reply_fds(byval c as xcb_connection_t ptr, byval reply as xcb_dri3_open_reply_t ptr) as long ptr
declare function xcb_dri3_pixmap_from_buffer_checked(byval c as xcb_connection_t ptr, byval pixmap as xcb_pixmap_t, byval drawable as xcb_drawable_t, byval size as ulong, byval width as ushort, byval height as ushort, byval stride as ushort, byval depth as ubyte, byval bpp as ubyte, byval pixmap_fd as long) as xcb_void_cookie_t
declare function xcb_dri3_pixmap_from_buffer(byval c as xcb_connection_t ptr, byval pixmap as xcb_pixmap_t, byval drawable as xcb_drawable_t, byval size as ulong, byval width as ushort, byval height as ushort, byval stride as ushort, byval depth as ubyte, byval bpp as ubyte, byval pixmap_fd as long) as xcb_void_cookie_t
declare function xcb_dri3_buffer_from_pixmap(byval c as xcb_connection_t ptr, byval pixmap as xcb_pixmap_t) as xcb_dri3_buffer_from_pixmap_cookie_t
declare function xcb_dri3_buffer_from_pixmap_unchecked(byval c as xcb_connection_t ptr, byval pixmap as xcb_pixmap_t) as xcb_dri3_buffer_from_pixmap_cookie_t
declare function xcb_dri3_buffer_from_pixmap_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri3_buffer_from_pixmap_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri3_buffer_from_pixmap_reply_t ptr
declare function xcb_dri3_buffer_from_pixmap_reply_fds(byval c as xcb_connection_t ptr, byval reply as xcb_dri3_buffer_from_pixmap_reply_t ptr) as long ptr
declare function xcb_dri3_fence_from_fd_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval fence as ulong, byval initially_triggered as ubyte, byval fence_fd as long) as xcb_void_cookie_t
declare function xcb_dri3_fence_from_fd(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval fence as ulong, byval initially_triggered as ubyte, byval fence_fd as long) as xcb_void_cookie_t
declare function xcb_dri3_fd_from_fence(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval fence as ulong) as xcb_dri3_fd_from_fence_cookie_t
declare function xcb_dri3_fd_from_fence_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval fence as ulong) as xcb_dri3_fd_from_fence_cookie_t
declare function xcb_dri3_fd_from_fence_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri3_fd_from_fence_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri3_fd_from_fence_reply_t ptr
declare function xcb_dri3_fd_from_fence_reply_fds(byval c as xcb_connection_t ptr, byval reply as xcb_dri3_fd_from_fence_reply_t ptr) as long ptr

end extern
