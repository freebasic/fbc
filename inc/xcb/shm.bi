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
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_SHM_QUERY_VERSION => XCB_SHM_QUERY_VERSION_
''     constant XCB_SHM_ATTACH => XCB_SHM_ATTACH_
''     constant XCB_SHM_DETACH => XCB_SHM_DETACH_
''     constant XCB_SHM_PUT_IMAGE => XCB_SHM_PUT_IMAGE_
''     constant XCB_SHM_GET_IMAGE => XCB_SHM_GET_IMAGE_
''     constant XCB_SHM_CREATE_PIXMAP => XCB_SHM_CREATE_PIXMAP_
''     constant XCB_SHM_ATTACH_FD => XCB_SHM_ATTACH_FD_
''     constant XCB_SHM_CREATE_SEGMENT => XCB_SHM_CREATE_SEGMENT_

extern "C"

#define __SHM_H
const XCB_SHM_MAJOR_VERSION = 1
const XCB_SHM_MINOR_VERSION = 2
extern xcb_shm_id as xcb_extension_t
type xcb_shm_seg_t as ulong

type xcb_shm_seg_iterator_t
	data as xcb_shm_seg_t ptr
	as long rem
	index as long
end type

const XCB_SHM_COMPLETION = 0

type xcb_shm_completion_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	drawable as xcb_drawable_t
	minor_event as ushort
	major_event as ubyte
	pad1 as ubyte
	shmseg as xcb_shm_seg_t
	offset as ulong
end type

const XCB_SHM_BAD_SEG = 0
type xcb_shm_bad_seg_error_t as xcb_value_error_t

type xcb_shm_query_version_cookie_t
	sequence as ulong
end type

const XCB_SHM_QUERY_VERSION_ = 0

type xcb_shm_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_shm_query_version_reply_t
	response_type as ubyte
	shared_pixmaps as ubyte
	sequence as ushort
	length as ulong
	major_version as ushort
	minor_version as ushort
	uid as ushort
	gid as ushort
	pixmap_format as ubyte
	pad0(0 to 14) as ubyte
end type

const XCB_SHM_ATTACH_ = 1

type xcb_shm_attach_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	shmseg as xcb_shm_seg_t
	shmid as ulong
	read_only as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_SHM_DETACH_ = 2

type xcb_shm_detach_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	shmseg as xcb_shm_seg_t
end type

const XCB_SHM_PUT_IMAGE_ = 3

type xcb_shm_put_image_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	total_width as ushort
	total_height as ushort
	src_x as ushort
	src_y as ushort
	src_width as ushort
	src_height as ushort
	dst_x as short
	dst_y as short
	depth as ubyte
	format as ubyte
	send_event as ubyte
	pad0 as ubyte
	shmseg as xcb_shm_seg_t
	offset as ulong
end type

type xcb_shm_get_image_cookie_t
	sequence as ulong
end type

const XCB_SHM_GET_IMAGE_ = 4

type xcb_shm_get_image_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	x as short
	y as short
	width as ushort
	height as ushort
	plane_mask as ulong
	format as ubyte
	pad0(0 to 2) as ubyte
	shmseg as xcb_shm_seg_t
	offset as ulong
end type

type xcb_shm_get_image_reply_t
	response_type as ubyte
	depth as ubyte
	sequence as ushort
	length as ulong
	visual as xcb_visualid_t
	size as ulong
end type

const XCB_SHM_CREATE_PIXMAP_ = 5

type xcb_shm_create_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	pid as xcb_pixmap_t
	drawable as xcb_drawable_t
	width as ushort
	height as ushort
	depth as ubyte
	pad0(0 to 2) as ubyte
	shmseg as xcb_shm_seg_t
	offset as ulong
end type

const XCB_SHM_ATTACH_FD_ = 6

type xcb_shm_attach_fd_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	shmseg as xcb_shm_seg_t
	read_only as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_shm_create_segment_cookie_t
	sequence as ulong
end type

const XCB_SHM_CREATE_SEGMENT_ = 7

type xcb_shm_create_segment_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	shmseg as xcb_shm_seg_t
	size as ulong
	read_only as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_shm_create_segment_reply_t
	response_type as ubyte
	nfd as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

declare sub xcb_shm_seg_next(byval i as xcb_shm_seg_iterator_t ptr)
declare function xcb_shm_seg_end(byval i as xcb_shm_seg_iterator_t) as xcb_generic_iterator_t
declare function xcb_shm_query_version(byval c as xcb_connection_t ptr) as xcb_shm_query_version_cookie_t
declare function xcb_shm_query_version_unchecked(byval c as xcb_connection_t ptr) as xcb_shm_query_version_cookie_t
declare function xcb_shm_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shm_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shm_query_version_reply_t ptr
declare function xcb_shm_attach_checked(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t, byval shmid as ulong, byval read_only as ubyte) as xcb_void_cookie_t
declare function xcb_shm_attach(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t, byval shmid as ulong, byval read_only as ubyte) as xcb_void_cookie_t
declare function xcb_shm_detach_checked(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t) as xcb_void_cookie_t
declare function xcb_shm_detach(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t) as xcb_void_cookie_t
declare function xcb_shm_put_image_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval total_width as ushort, byval total_height as ushort, byval src_x as ushort, byval src_y as ushort, byval src_width as ushort, byval src_height as ushort, byval dst_x as short, byval dst_y as short, byval depth as ubyte, byval format as ubyte, byval send_event as ubyte, byval shmseg as xcb_shm_seg_t, byval offset as ulong) as xcb_void_cookie_t
declare function xcb_shm_put_image(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval total_width as ushort, byval total_height as ushort, byval src_x as ushort, byval src_y as ushort, byval src_width as ushort, byval src_height as ushort, byval dst_x as short, byval dst_y as short, byval depth as ubyte, byval format as ubyte, byval send_event as ubyte, byval shmseg as xcb_shm_seg_t, byval offset as ulong) as xcb_void_cookie_t
declare function xcb_shm_get_image(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval plane_mask as ulong, byval format as ubyte, byval shmseg as xcb_shm_seg_t, byval offset as ulong) as xcb_shm_get_image_cookie_t
declare function xcb_shm_get_image_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval plane_mask as ulong, byval format as ubyte, byval shmseg as xcb_shm_seg_t, byval offset as ulong) as xcb_shm_get_image_cookie_t
declare function xcb_shm_get_image_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shm_get_image_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shm_get_image_reply_t ptr
declare function xcb_shm_create_pixmap_checked(byval c as xcb_connection_t ptr, byval pid as xcb_pixmap_t, byval drawable as xcb_drawable_t, byval width as ushort, byval height as ushort, byval depth as ubyte, byval shmseg as xcb_shm_seg_t, byval offset as ulong) as xcb_void_cookie_t
declare function xcb_shm_create_pixmap(byval c as xcb_connection_t ptr, byval pid as xcb_pixmap_t, byval drawable as xcb_drawable_t, byval width as ushort, byval height as ushort, byval depth as ubyte, byval shmseg as xcb_shm_seg_t, byval offset as ulong) as xcb_void_cookie_t
declare function xcb_shm_attach_fd_checked(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t, byval shm_fd as long, byval read_only as ubyte) as xcb_void_cookie_t
declare function xcb_shm_attach_fd(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t, byval shm_fd as long, byval read_only as ubyte) as xcb_void_cookie_t
declare function xcb_shm_create_segment(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t, byval size as ulong, byval read_only as ubyte) as xcb_shm_create_segment_cookie_t
declare function xcb_shm_create_segment_unchecked(byval c as xcb_connection_t ptr, byval shmseg as xcb_shm_seg_t, byval size as ulong, byval read_only as ubyte) as xcb_shm_create_segment_cookie_t
declare function xcb_shm_create_segment_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shm_create_segment_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shm_create_segment_reply_t ptr
declare function xcb_shm_create_segment_reply_fds(byval c as xcb_connection_t ptr, byval reply as xcb_shm_create_segment_reply_t ptr) as long ptr

end extern
