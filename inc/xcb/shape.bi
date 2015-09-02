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
''     constant XCB_SHAPE_QUERY_VERSION => XCB_SHAPE_QUERY_VERSION_
''     constant XCB_SHAPE_RECTANGLES => XCB_SHAPE_RECTANGLES_
''     constant XCB_SHAPE_MASK => XCB_SHAPE_MASK_
''     constant XCB_SHAPE_COMBINE => XCB_SHAPE_COMBINE_
''     constant XCB_SHAPE_OFFSET => XCB_SHAPE_OFFSET_
''     constant XCB_SHAPE_QUERY_EXTENTS => XCB_SHAPE_QUERY_EXTENTS_
''     constant XCB_SHAPE_SELECT_INPUT => XCB_SHAPE_SELECT_INPUT_
''     constant XCB_SHAPE_INPUT_SELECTED => XCB_SHAPE_INPUT_SELECTED_
''     constant XCB_SHAPE_GET_RECTANGLES => XCB_SHAPE_GET_RECTANGLES_

extern "C"

#define __SHAPE_H
const XCB_SHAPE_MAJOR_VERSION = 1
const XCB_SHAPE_MINOR_VERSION = 1
extern xcb_shape_id as xcb_extension_t
type xcb_shape_op_t as ubyte

type xcb_shape_op_iterator_t
	data as xcb_shape_op_t ptr
	as long rem
	index as long
end type

type xcb_shape_kind_t as ubyte

type xcb_shape_kind_iterator_t
	data as xcb_shape_kind_t ptr
	as long rem
	index as long
end type

type xcb_shape_so_t as long
enum
	XCB_SHAPE_SO_SET = 0
	XCB_SHAPE_SO_UNION = 1
	XCB_SHAPE_SO_INTERSECT = 2
	XCB_SHAPE_SO_SUBTRACT = 3
	XCB_SHAPE_SO_INVERT = 4
end enum

type xcb_shape_sk_t as long
enum
	XCB_SHAPE_SK_BOUNDING = 0
	XCB_SHAPE_SK_CLIP = 1
	XCB_SHAPE_SK_INPUT = 2
end enum

const XCB_SHAPE_NOTIFY = 0

type xcb_shape_notify_event_t
	response_type as ubyte
	shape_kind as xcb_shape_kind_t
	sequence as ushort
	affected_window as xcb_window_t
	extents_x as short
	extents_y as short
	extents_width as ushort
	extents_height as ushort
	server_time as xcb_timestamp_t
	shaped as ubyte
	pad0(0 to 10) as ubyte
end type

type xcb_shape_query_version_cookie_t
	sequence as ulong
end type

const XCB_SHAPE_QUERY_VERSION_ = 0

type xcb_shape_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_shape_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ushort
	minor_version as ushort
end type

const XCB_SHAPE_RECTANGLES_ = 1

type xcb_shape_rectangles_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	operation as xcb_shape_op_t
	destination_kind as xcb_shape_kind_t
	ordering as ubyte
	pad0 as ubyte
	destination_window as xcb_window_t
	x_offset as short
	y_offset as short
end type

const XCB_SHAPE_MASK_ = 2

type xcb_shape_mask_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	operation as xcb_shape_op_t
	destination_kind as xcb_shape_kind_t
	pad0(0 to 1) as ubyte
	destination_window as xcb_window_t
	x_offset as short
	y_offset as short
	source_bitmap as xcb_pixmap_t
end type

const XCB_SHAPE_COMBINE_ = 3

type xcb_shape_combine_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	operation as xcb_shape_op_t
	destination_kind as xcb_shape_kind_t
	source_kind as xcb_shape_kind_t
	pad0 as ubyte
	destination_window as xcb_window_t
	x_offset as short
	y_offset as short
	source_window as xcb_window_t
end type

const XCB_SHAPE_OFFSET_ = 4

type xcb_shape_offset_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	destination_kind as xcb_shape_kind_t
	pad0(0 to 2) as ubyte
	destination_window as xcb_window_t
	x_offset as short
	y_offset as short
end type

type xcb_shape_query_extents_cookie_t
	sequence as ulong
end type

const XCB_SHAPE_QUERY_EXTENTS_ = 5

type xcb_shape_query_extents_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	destination_window as xcb_window_t
end type

type xcb_shape_query_extents_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	bounding_shaped as ubyte
	clip_shaped as ubyte
	pad1(0 to 1) as ubyte
	bounding_shape_extents_x as short
	bounding_shape_extents_y as short
	bounding_shape_extents_width as ushort
	bounding_shape_extents_height as ushort
	clip_shape_extents_x as short
	clip_shape_extents_y as short
	clip_shape_extents_width as ushort
	clip_shape_extents_height as ushort
end type

const XCB_SHAPE_SELECT_INPUT_ = 6

type xcb_shape_select_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	destination_window as xcb_window_t
	enable as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_shape_input_selected_cookie_t
	sequence as ulong
end type

const XCB_SHAPE_INPUT_SELECTED_ = 7

type xcb_shape_input_selected_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	destination_window as xcb_window_t
end type

type xcb_shape_input_selected_reply_t
	response_type as ubyte
	enabled as ubyte
	sequence as ushort
	length as ulong
end type

type xcb_shape_get_rectangles_cookie_t
	sequence as ulong
end type

const XCB_SHAPE_GET_RECTANGLES_ = 8

type xcb_shape_get_rectangles_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	source_kind as xcb_shape_kind_t
	pad0(0 to 2) as ubyte
end type

type xcb_shape_get_rectangles_reply_t
	response_type as ubyte
	ordering as ubyte
	sequence as ushort
	length as ulong
	rectangles_len as ulong
	pad0(0 to 19) as ubyte
end type

declare sub xcb_shape_op_next(byval i as xcb_shape_op_iterator_t ptr)
declare function xcb_shape_op_end(byval i as xcb_shape_op_iterator_t) as xcb_generic_iterator_t
declare sub xcb_shape_kind_next(byval i as xcb_shape_kind_iterator_t ptr)
declare function xcb_shape_kind_end(byval i as xcb_shape_kind_iterator_t) as xcb_generic_iterator_t
declare function xcb_shape_query_version(byval c as xcb_connection_t ptr) as xcb_shape_query_version_cookie_t
declare function xcb_shape_query_version_unchecked(byval c as xcb_connection_t ptr) as xcb_shape_query_version_cookie_t
declare function xcb_shape_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shape_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shape_query_version_reply_t ptr
declare function xcb_shape_rectangles_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_shape_rectangles_checked(byval c as xcb_connection_t ptr, byval operation as xcb_shape_op_t, byval destination_kind as xcb_shape_kind_t, byval ordering as ubyte, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_shape_rectangles(byval c as xcb_connection_t ptr, byval operation as xcb_shape_op_t, byval destination_kind as xcb_shape_kind_t, byval ordering as ubyte, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_shape_mask_checked(byval c as xcb_connection_t ptr, byval operation as xcb_shape_op_t, byval destination_kind as xcb_shape_kind_t, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short, byval source_bitmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_shape_mask(byval c as xcb_connection_t ptr, byval operation as xcb_shape_op_t, byval destination_kind as xcb_shape_kind_t, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short, byval source_bitmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_shape_combine_checked(byval c as xcb_connection_t ptr, byval operation as xcb_shape_op_t, byval destination_kind as xcb_shape_kind_t, byval source_kind as xcb_shape_kind_t, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short, byval source_window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_shape_combine(byval c as xcb_connection_t ptr, byval operation as xcb_shape_op_t, byval destination_kind as xcb_shape_kind_t, byval source_kind as xcb_shape_kind_t, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short, byval source_window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_shape_offset_checked(byval c as xcb_connection_t ptr, byval destination_kind as xcb_shape_kind_t, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short) as xcb_void_cookie_t
declare function xcb_shape_offset(byval c as xcb_connection_t ptr, byval destination_kind as xcb_shape_kind_t, byval destination_window as xcb_window_t, byval x_offset as short, byval y_offset as short) as xcb_void_cookie_t
declare function xcb_shape_query_extents(byval c as xcb_connection_t ptr, byval destination_window as xcb_window_t) as xcb_shape_query_extents_cookie_t
declare function xcb_shape_query_extents_unchecked(byval c as xcb_connection_t ptr, byval destination_window as xcb_window_t) as xcb_shape_query_extents_cookie_t
declare function xcb_shape_query_extents_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shape_query_extents_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shape_query_extents_reply_t ptr
declare function xcb_shape_select_input_checked(byval c as xcb_connection_t ptr, byval destination_window as xcb_window_t, byval enable as ubyte) as xcb_void_cookie_t
declare function xcb_shape_select_input(byval c as xcb_connection_t ptr, byval destination_window as xcb_window_t, byval enable as ubyte) as xcb_void_cookie_t
declare function xcb_shape_input_selected(byval c as xcb_connection_t ptr, byval destination_window as xcb_window_t) as xcb_shape_input_selected_cookie_t
declare function xcb_shape_input_selected_unchecked(byval c as xcb_connection_t ptr, byval destination_window as xcb_window_t) as xcb_shape_input_selected_cookie_t
declare function xcb_shape_input_selected_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shape_input_selected_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shape_input_selected_reply_t ptr
declare function xcb_shape_get_rectangles_sizeof(byval _buffer as const any ptr) as long
declare function xcb_shape_get_rectangles(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval source_kind as xcb_shape_kind_t) as xcb_shape_get_rectangles_cookie_t
declare function xcb_shape_get_rectangles_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval source_kind as xcb_shape_kind_t) as xcb_shape_get_rectangles_cookie_t
declare function xcb_shape_get_rectangles_rectangles(byval R as const xcb_shape_get_rectangles_reply_t ptr) as xcb_rectangle_t ptr
declare function xcb_shape_get_rectangles_rectangles_length(byval R as const xcb_shape_get_rectangles_reply_t ptr) as long
declare function xcb_shape_get_rectangles_rectangles_iterator(byval R as const xcb_shape_get_rectangles_reply_t ptr) as xcb_rectangle_iterator_t
declare function xcb_shape_get_rectangles_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_shape_get_rectangles_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_shape_get_rectangles_reply_t ptr

end extern
