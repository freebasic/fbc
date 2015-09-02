'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2005 Jeremy Kolb.
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
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XF86DRI_QUERY_VERSION => XCB_XF86DRI_QUERY_VERSION_
''     constant XCB_XF86DRI_QUERY_DIRECT_RENDERING_CAPABLE => XCB_XF86DRI_QUERY_DIRECT_RENDERING_CAPABLE_
''     constant XCB_XF86DRI_OPEN_CONNECTION => XCB_XF86DRI_OPEN_CONNECTION_
''     constant XCB_XF86DRI_CLOSE_CONNECTION => XCB_XF86DRI_CLOSE_CONNECTION_
''     constant XCB_XF86DRI_GET_CLIENT_DRIVER_NAME => XCB_XF86DRI_GET_CLIENT_DRIVER_NAME_
''     constant XCB_XF86DRI_CREATE_CONTEXT => XCB_XF86DRI_CREATE_CONTEXT_
''     constant XCB_XF86DRI_DESTROY_CONTEXT => XCB_XF86DRI_DESTROY_CONTEXT_
''     constant XCB_XF86DRI_CREATE_DRAWABLE => XCB_XF86DRI_CREATE_DRAWABLE_
''     constant XCB_XF86DRI_DESTROY_DRAWABLE => XCB_XF86DRI_DESTROY_DRAWABLE_
''     constant XCB_XF86DRI_GET_DRAWABLE_INFO => XCB_XF86DRI_GET_DRAWABLE_INFO_
''     constant XCB_XF86DRI_GET_DEVICE_INFO => XCB_XF86DRI_GET_DEVICE_INFO_
''     constant XCB_XF86DRI_AUTH_CONNECTION => XCB_XF86DRI_AUTH_CONNECTION_

extern "C"

#define __XF86DRI_H
const XCB_XF86DRI_MAJOR_VERSION = 4
const XCB_XF86DRI_MINOR_VERSION = 1
extern xcb_xf86dri_id as xcb_extension_t

type xcb_xf86dri_drm_clip_rect_t
	x1 as short
	y1 as short
	x2 as short
	x3 as short
end type

type xcb_xf86dri_drm_clip_rect_iterator_t
	data as xcb_xf86dri_drm_clip_rect_t ptr
	as long rem
	index as long
end type

type xcb_xf86dri_query_version_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_QUERY_VERSION_ = 0

type xcb_xf86dri_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xf86dri_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	dri_major_version as ushort
	dri_minor_version as ushort
	dri_minor_patch as ulong
end type

type xcb_xf86dri_query_direct_rendering_capable_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_QUERY_DIRECT_RENDERING_CAPABLE_ = 1

type xcb_xf86dri_query_direct_rendering_capable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_xf86dri_query_direct_rendering_capable_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	is_capable as ubyte
end type

type xcb_xf86dri_open_connection_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_OPEN_CONNECTION_ = 2

type xcb_xf86dri_open_connection_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_xf86dri_open_connection_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	sarea_handle_low as ulong
	sarea_handle_high as ulong
	bus_id_len as ulong
	pad1(0 to 11) as ubyte
end type

const XCB_XF86DRI_CLOSE_CONNECTION_ = 3

type xcb_xf86dri_close_connection_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_xf86dri_get_client_driver_name_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_GET_CLIENT_DRIVER_NAME_ = 4

type xcb_xf86dri_get_client_driver_name_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_xf86dri_get_client_driver_name_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	client_driver_major_version as ulong
	client_driver_minor_version as ulong
	client_driver_patch_version as ulong
	client_driver_name_len as ulong
	pad1(0 to 7) as ubyte
end type

type xcb_xf86dri_create_context_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_CREATE_CONTEXT_ = 5

type xcb_xf86dri_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	visual as ulong
	context as ulong
end type

type xcb_xf86dri_create_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	hw_context as ulong
end type

const XCB_XF86DRI_DESTROY_CONTEXT_ = 6

type xcb_xf86dri_destroy_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	context as ulong
end type

type xcb_xf86dri_create_drawable_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_CREATE_DRAWABLE_ = 7

type xcb_xf86dri_create_drawable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	drawable as ulong
end type

type xcb_xf86dri_create_drawable_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	hw_drawable_handle as ulong
end type

const XCB_XF86DRI_DESTROY_DRAWABLE_ = 8

type xcb_xf86dri_destroy_drawable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	drawable as ulong
end type

type xcb_xf86dri_get_drawable_info_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_GET_DRAWABLE_INFO_ = 9

type xcb_xf86dri_get_drawable_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	drawable as ulong
end type

type xcb_xf86dri_get_drawable_info_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	drawable_table_index as ulong
	drawable_table_stamp as ulong
	drawable_origin_X as short
	drawable_origin_Y as short
	drawable_size_W as short
	drawable_size_H as short
	num_clip_rects as ulong
	back_x as short
	back_y as short
	num_back_clip_rects as ulong
end type

type xcb_xf86dri_get_device_info_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_GET_DEVICE_INFO_ = 10

type xcb_xf86dri_get_device_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_xf86dri_get_device_info_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	framebuffer_handle_low as ulong
	framebuffer_handle_high as ulong
	framebuffer_origin_offset as ulong
	framebuffer_size as ulong
	framebuffer_stride as ulong
	device_private_size as ulong
end type

type xcb_xf86dri_auth_connection_cookie_t
	sequence as ulong
end type

const XCB_XF86DRI_AUTH_CONNECTION_ = 11

type xcb_xf86dri_auth_connection_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	magic as ulong
end type

type xcb_xf86dri_auth_connection_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	authenticated as ulong
end type

declare sub xcb_xf86dri_drm_clip_rect_next(byval i as xcb_xf86dri_drm_clip_rect_iterator_t ptr)
declare function xcb_xf86dri_drm_clip_rect_end(byval i as xcb_xf86dri_drm_clip_rect_iterator_t) as xcb_generic_iterator_t
declare function xcb_xf86dri_query_version(byval c as xcb_connection_t ptr) as xcb_xf86dri_query_version_cookie_t
declare function xcb_xf86dri_query_version_unchecked(byval c as xcb_connection_t ptr) as xcb_xf86dri_query_version_cookie_t
declare function xcb_xf86dri_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_query_version_reply_t ptr
declare function xcb_xf86dri_query_direct_rendering_capable(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_query_direct_rendering_capable_cookie_t
declare function xcb_xf86dri_query_direct_rendering_capable_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_query_direct_rendering_capable_cookie_t
declare function xcb_xf86dri_query_direct_rendering_capable_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_query_direct_rendering_capable_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_query_direct_rendering_capable_reply_t ptr
declare function xcb_xf86dri_open_connection_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xf86dri_open_connection(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_open_connection_cookie_t
declare function xcb_xf86dri_open_connection_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_open_connection_cookie_t
declare function xcb_xf86dri_open_connection_bus_id(byval R as const xcb_xf86dri_open_connection_reply_t ptr) as zstring ptr
declare function xcb_xf86dri_open_connection_bus_id_length(byval R as const xcb_xf86dri_open_connection_reply_t ptr) as long
declare function xcb_xf86dri_open_connection_bus_id_end(byval R as const xcb_xf86dri_open_connection_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xf86dri_open_connection_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_open_connection_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_open_connection_reply_t ptr
declare function xcb_xf86dri_close_connection_checked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_void_cookie_t
declare function xcb_xf86dri_close_connection(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_void_cookie_t
declare function xcb_xf86dri_get_client_driver_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xf86dri_get_client_driver_name(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_get_client_driver_name_cookie_t
declare function xcb_xf86dri_get_client_driver_name_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_get_client_driver_name_cookie_t
declare function xcb_xf86dri_get_client_driver_name_client_driver_name(byval R as const xcb_xf86dri_get_client_driver_name_reply_t ptr) as zstring ptr
declare function xcb_xf86dri_get_client_driver_name_client_driver_name_length(byval R as const xcb_xf86dri_get_client_driver_name_reply_t ptr) as long
declare function xcb_xf86dri_get_client_driver_name_client_driver_name_end(byval R as const xcb_xf86dri_get_client_driver_name_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xf86dri_get_client_driver_name_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_get_client_driver_name_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_get_client_driver_name_reply_t ptr
declare function xcb_xf86dri_create_context(byval c as xcb_connection_t ptr, byval screen as ulong, byval visual as ulong, byval context as ulong) as xcb_xf86dri_create_context_cookie_t
declare function xcb_xf86dri_create_context_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong, byval visual as ulong, byval context as ulong) as xcb_xf86dri_create_context_cookie_t
declare function xcb_xf86dri_create_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_create_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_create_context_reply_t ptr
declare function xcb_xf86dri_destroy_context_checked(byval c as xcb_connection_t ptr, byval screen as ulong, byval context as ulong) as xcb_void_cookie_t
declare function xcb_xf86dri_destroy_context(byval c as xcb_connection_t ptr, byval screen as ulong, byval context as ulong) as xcb_void_cookie_t
declare function xcb_xf86dri_create_drawable(byval c as xcb_connection_t ptr, byval screen as ulong, byval drawable as ulong) as xcb_xf86dri_create_drawable_cookie_t
declare function xcb_xf86dri_create_drawable_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong, byval drawable as ulong) as xcb_xf86dri_create_drawable_cookie_t
declare function xcb_xf86dri_create_drawable_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_create_drawable_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_create_drawable_reply_t ptr
declare function xcb_xf86dri_destroy_drawable_checked(byval c as xcb_connection_t ptr, byval screen as ulong, byval drawable as ulong) as xcb_void_cookie_t
declare function xcb_xf86dri_destroy_drawable(byval c as xcb_connection_t ptr, byval screen as ulong, byval drawable as ulong) as xcb_void_cookie_t
declare function xcb_xf86dri_get_drawable_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xf86dri_get_drawable_info(byval c as xcb_connection_t ptr, byval screen as ulong, byval drawable as ulong) as xcb_xf86dri_get_drawable_info_cookie_t
declare function xcb_xf86dri_get_drawable_info_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong, byval drawable as ulong) as xcb_xf86dri_get_drawable_info_cookie_t
declare function xcb_xf86dri_get_drawable_info_clip_rects(byval R as const xcb_xf86dri_get_drawable_info_reply_t ptr) as xcb_xf86dri_drm_clip_rect_t ptr
declare function xcb_xf86dri_get_drawable_info_clip_rects_length(byval R as const xcb_xf86dri_get_drawable_info_reply_t ptr) as long
declare function xcb_xf86dri_get_drawable_info_clip_rects_iterator(byval R as const xcb_xf86dri_get_drawable_info_reply_t ptr) as xcb_xf86dri_drm_clip_rect_iterator_t
declare function xcb_xf86dri_get_drawable_info_back_clip_rects(byval R as const xcb_xf86dri_get_drawable_info_reply_t ptr) as xcb_xf86dri_drm_clip_rect_t ptr
declare function xcb_xf86dri_get_drawable_info_back_clip_rects_length(byval R as const xcb_xf86dri_get_drawable_info_reply_t ptr) as long
declare function xcb_xf86dri_get_drawable_info_back_clip_rects_iterator(byval R as const xcb_xf86dri_get_drawable_info_reply_t ptr) as xcb_xf86dri_drm_clip_rect_iterator_t
declare function xcb_xf86dri_get_drawable_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_get_drawable_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_get_drawable_info_reply_t ptr
declare function xcb_xf86dri_get_device_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xf86dri_get_device_info(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_get_device_info_cookie_t
declare function xcb_xf86dri_get_device_info_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_xf86dri_get_device_info_cookie_t
declare function xcb_xf86dri_get_device_info_device_private(byval R as const xcb_xf86dri_get_device_info_reply_t ptr) as ulong ptr
declare function xcb_xf86dri_get_device_info_device_private_length(byval R as const xcb_xf86dri_get_device_info_reply_t ptr) as long
declare function xcb_xf86dri_get_device_info_device_private_end(byval R as const xcb_xf86dri_get_device_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xf86dri_get_device_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_get_device_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_get_device_info_reply_t ptr
declare function xcb_xf86dri_auth_connection(byval c as xcb_connection_t ptr, byval screen as ulong, byval magic as ulong) as xcb_xf86dri_auth_connection_cookie_t
declare function xcb_xf86dri_auth_connection_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong, byval magic as ulong) as xcb_xf86dri_auth_connection_cookie_t
declare function xcb_xf86dri_auth_connection_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xf86dri_auth_connection_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xf86dri_auth_connection_reply_t ptr

end extern
