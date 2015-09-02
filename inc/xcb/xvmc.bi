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
#include once "xv.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XVMC_QUERY_VERSION => XCB_XVMC_QUERY_VERSION_
''     constant XCB_XVMC_LIST_SURFACE_TYPES => XCB_XVMC_LIST_SURFACE_TYPES_
''     constant XCB_XVMC_CREATE_CONTEXT => XCB_XVMC_CREATE_CONTEXT_
''     constant XCB_XVMC_DESTROY_CONTEXT => XCB_XVMC_DESTROY_CONTEXT_
''     constant XCB_XVMC_CREATE_SURFACE => XCB_XVMC_CREATE_SURFACE_
''     constant XCB_XVMC_DESTROY_SURFACE => XCB_XVMC_DESTROY_SURFACE_
''     constant XCB_XVMC_CREATE_SUBPICTURE => XCB_XVMC_CREATE_SUBPICTURE_
''     constant XCB_XVMC_DESTROY_SUBPICTURE => XCB_XVMC_DESTROY_SUBPICTURE_
''     constant XCB_XVMC_LIST_SUBPICTURE_TYPES => XCB_XVMC_LIST_SUBPICTURE_TYPES_

extern "C"

#define __XVMC_H
const XCB_XVMC_MAJOR_VERSION = 1
const XCB_XVMC_MINOR_VERSION = 1
extern xcb_xvmc_id as xcb_extension_t
type xcb_xvmc_context_t as ulong

type xcb_xvmc_context_iterator_t
	data as xcb_xvmc_context_t ptr
	as long rem
	index as long
end type

type xcb_xvmc_surface_t as ulong

type xcb_xvmc_surface_iterator_t
	data as xcb_xvmc_surface_t ptr
	as long rem
	index as long
end type

type xcb_xvmc_subpicture_t as ulong

type xcb_xvmc_subpicture_iterator_t
	data as xcb_xvmc_subpicture_t ptr
	as long rem
	index as long
end type

type xcb_xvmc_surface_info_t
	id as xcb_xvmc_surface_t
	chroma_format as ushort
	pad0 as ushort
	max_width as ushort
	max_height as ushort
	subpicture_max_width as ushort
	subpicture_max_height as ushort
	mc_type as ulong
	flags as ulong
end type

type xcb_xvmc_surface_info_iterator_t
	data as xcb_xvmc_surface_info_t ptr
	as long rem
	index as long
end type

type xcb_xvmc_query_version_cookie_t
	sequence as ulong
end type

const XCB_XVMC_QUERY_VERSION_ = 0

type xcb_xvmc_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xvmc_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major as ulong
	minor as ulong
end type

type xcb_xvmc_list_surface_types_cookie_t
	sequence as ulong
end type

const XCB_XVMC_LIST_SURFACE_TYPES_ = 1

type xcb_xvmc_list_surface_types_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port_id as xcb_xv_port_t
end type

type xcb_xvmc_list_surface_types_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_xvmc_create_context_cookie_t
	sequence as ulong
end type

const XCB_XVMC_CREATE_CONTEXT_ = 2

type xcb_xvmc_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_id as xcb_xvmc_context_t
	port_id as xcb_xv_port_t
	surface_id as xcb_xvmc_surface_t
	width as ushort
	height as ushort
	flags as ulong
end type

type xcb_xvmc_create_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width_actual as ushort
	height_actual as ushort
	flags_return as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_XVMC_DESTROY_CONTEXT_ = 3

type xcb_xvmc_destroy_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_id as xcb_xvmc_context_t
end type

type xcb_xvmc_create_surface_cookie_t
	sequence as ulong
end type

const XCB_XVMC_CREATE_SURFACE_ = 4

type xcb_xvmc_create_surface_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	surface_id as xcb_xvmc_surface_t
	context_id as xcb_xvmc_context_t
end type

type xcb_xvmc_create_surface_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

const XCB_XVMC_DESTROY_SURFACE_ = 5

type xcb_xvmc_destroy_surface_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	surface_id as xcb_xvmc_surface_t
end type

type xcb_xvmc_create_subpicture_cookie_t
	sequence as ulong
end type

const XCB_XVMC_CREATE_SUBPICTURE_ = 6

type xcb_xvmc_create_subpicture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	subpicture_id as xcb_xvmc_subpicture_t
	context as xcb_xvmc_context_t
	xvimage_id as ulong
	width as ushort
	height as ushort
end type

type xcb_xvmc_create_subpicture_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width_actual as ushort
	height_actual as ushort
	num_palette_entries as ushort
	entry_bytes as ushort
	component_order(0 to 3) as ubyte
	pad1(0 to 11) as ubyte
end type

const XCB_XVMC_DESTROY_SUBPICTURE_ = 7

type xcb_xvmc_destroy_subpicture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	subpicture_id as xcb_xvmc_subpicture_t
end type

type xcb_xvmc_list_subpicture_types_cookie_t
	sequence as ulong
end type

const XCB_XVMC_LIST_SUBPICTURE_TYPES_ = 8

type xcb_xvmc_list_subpicture_types_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port_id as xcb_xv_port_t
	surface_id as xcb_xvmc_surface_t
end type

type xcb_xvmc_list_subpicture_types_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num as ulong
	pad1(0 to 19) as ubyte
end type

declare sub xcb_xvmc_context_next(byval i as xcb_xvmc_context_iterator_t ptr)
declare function xcb_xvmc_context_end(byval i as xcb_xvmc_context_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xvmc_surface_next(byval i as xcb_xvmc_surface_iterator_t ptr)
declare function xcb_xvmc_surface_end(byval i as xcb_xvmc_surface_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xvmc_subpicture_next(byval i as xcb_xvmc_subpicture_iterator_t ptr)
declare function xcb_xvmc_subpicture_end(byval i as xcb_xvmc_subpicture_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xvmc_surface_info_next(byval i as xcb_xvmc_surface_info_iterator_t ptr)
declare function xcb_xvmc_surface_info_end(byval i as xcb_xvmc_surface_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_xvmc_query_version(byval c as xcb_connection_t ptr) as xcb_xvmc_query_version_cookie_t
declare function xcb_xvmc_query_version_unchecked(byval c as xcb_connection_t ptr) as xcb_xvmc_query_version_cookie_t
declare function xcb_xvmc_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xvmc_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xvmc_query_version_reply_t ptr
declare function xcb_xvmc_list_surface_types_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xvmc_list_surface_types(byval c as xcb_connection_t ptr, byval port_id as xcb_xv_port_t) as xcb_xvmc_list_surface_types_cookie_t
declare function xcb_xvmc_list_surface_types_unchecked(byval c as xcb_connection_t ptr, byval port_id as xcb_xv_port_t) as xcb_xvmc_list_surface_types_cookie_t
declare function xcb_xvmc_list_surface_types_surfaces(byval R as const xcb_xvmc_list_surface_types_reply_t ptr) as xcb_xvmc_surface_info_t ptr
declare function xcb_xvmc_list_surface_types_surfaces_length(byval R as const xcb_xvmc_list_surface_types_reply_t ptr) as long
declare function xcb_xvmc_list_surface_types_surfaces_iterator(byval R as const xcb_xvmc_list_surface_types_reply_t ptr) as xcb_xvmc_surface_info_iterator_t
declare function xcb_xvmc_list_surface_types_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xvmc_list_surface_types_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xvmc_list_surface_types_reply_t ptr
declare function xcb_xvmc_create_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xvmc_create_context(byval c as xcb_connection_t ptr, byval context_id as xcb_xvmc_context_t, byval port_id as xcb_xv_port_t, byval surface_id as xcb_xvmc_surface_t, byval width as ushort, byval height as ushort, byval flags as ulong) as xcb_xvmc_create_context_cookie_t
declare function xcb_xvmc_create_context_unchecked(byval c as xcb_connection_t ptr, byval context_id as xcb_xvmc_context_t, byval port_id as xcb_xv_port_t, byval surface_id as xcb_xvmc_surface_t, byval width as ushort, byval height as ushort, byval flags as ulong) as xcb_xvmc_create_context_cookie_t
declare function xcb_xvmc_create_context_priv_data(byval R as const xcb_xvmc_create_context_reply_t ptr) as ulong ptr
declare function xcb_xvmc_create_context_priv_data_length(byval R as const xcb_xvmc_create_context_reply_t ptr) as long
declare function xcb_xvmc_create_context_priv_data_end(byval R as const xcb_xvmc_create_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xvmc_create_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xvmc_create_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xvmc_create_context_reply_t ptr
declare function xcb_xvmc_destroy_context_checked(byval c as xcb_connection_t ptr, byval context_id as xcb_xvmc_context_t) as xcb_void_cookie_t
declare function xcb_xvmc_destroy_context(byval c as xcb_connection_t ptr, byval context_id as xcb_xvmc_context_t) as xcb_void_cookie_t
declare function xcb_xvmc_create_surface_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xvmc_create_surface(byval c as xcb_connection_t ptr, byval surface_id as xcb_xvmc_surface_t, byval context_id as xcb_xvmc_context_t) as xcb_xvmc_create_surface_cookie_t
declare function xcb_xvmc_create_surface_unchecked(byval c as xcb_connection_t ptr, byval surface_id as xcb_xvmc_surface_t, byval context_id as xcb_xvmc_context_t) as xcb_xvmc_create_surface_cookie_t
declare function xcb_xvmc_create_surface_priv_data(byval R as const xcb_xvmc_create_surface_reply_t ptr) as ulong ptr
declare function xcb_xvmc_create_surface_priv_data_length(byval R as const xcb_xvmc_create_surface_reply_t ptr) as long
declare function xcb_xvmc_create_surface_priv_data_end(byval R as const xcb_xvmc_create_surface_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xvmc_create_surface_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xvmc_create_surface_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xvmc_create_surface_reply_t ptr
declare function xcb_xvmc_destroy_surface_checked(byval c as xcb_connection_t ptr, byval surface_id as xcb_xvmc_surface_t) as xcb_void_cookie_t
declare function xcb_xvmc_destroy_surface(byval c as xcb_connection_t ptr, byval surface_id as xcb_xvmc_surface_t) as xcb_void_cookie_t
declare function xcb_xvmc_create_subpicture_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xvmc_create_subpicture(byval c as xcb_connection_t ptr, byval subpicture_id as xcb_xvmc_subpicture_t, byval context as xcb_xvmc_context_t, byval xvimage_id as ulong, byval width as ushort, byval height as ushort) as xcb_xvmc_create_subpicture_cookie_t
declare function xcb_xvmc_create_subpicture_unchecked(byval c as xcb_connection_t ptr, byval subpicture_id as xcb_xvmc_subpicture_t, byval context as xcb_xvmc_context_t, byval xvimage_id as ulong, byval width as ushort, byval height as ushort) as xcb_xvmc_create_subpicture_cookie_t
declare function xcb_xvmc_create_subpicture_priv_data(byval R as const xcb_xvmc_create_subpicture_reply_t ptr) as ulong ptr
declare function xcb_xvmc_create_subpicture_priv_data_length(byval R as const xcb_xvmc_create_subpicture_reply_t ptr) as long
declare function xcb_xvmc_create_subpicture_priv_data_end(byval R as const xcb_xvmc_create_subpicture_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xvmc_create_subpicture_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xvmc_create_subpicture_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xvmc_create_subpicture_reply_t ptr
declare function xcb_xvmc_destroy_subpicture_checked(byval c as xcb_connection_t ptr, byval subpicture_id as xcb_xvmc_subpicture_t) as xcb_void_cookie_t
declare function xcb_xvmc_destroy_subpicture(byval c as xcb_connection_t ptr, byval subpicture_id as xcb_xvmc_subpicture_t) as xcb_void_cookie_t
declare function xcb_xvmc_list_subpicture_types_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xvmc_list_subpicture_types(byval c as xcb_connection_t ptr, byval port_id as xcb_xv_port_t, byval surface_id as xcb_xvmc_surface_t) as xcb_xvmc_list_subpicture_types_cookie_t
declare function xcb_xvmc_list_subpicture_types_unchecked(byval c as xcb_connection_t ptr, byval port_id as xcb_xv_port_t, byval surface_id as xcb_xvmc_surface_t) as xcb_xvmc_list_subpicture_types_cookie_t
declare function xcb_xvmc_list_subpicture_types_types(byval R as const xcb_xvmc_list_subpicture_types_reply_t ptr) as xcb_xv_image_format_info_t ptr
declare function xcb_xvmc_list_subpicture_types_types_length(byval R as const xcb_xvmc_list_subpicture_types_reply_t ptr) as long
declare function xcb_xvmc_list_subpicture_types_types_iterator(byval R as const xcb_xvmc_list_subpicture_types_reply_t ptr) as xcb_xv_image_format_info_iterator_t
declare function xcb_xvmc_list_subpicture_types_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xvmc_list_subpicture_types_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xvmc_list_subpicture_types_reply_t ptr

end extern
