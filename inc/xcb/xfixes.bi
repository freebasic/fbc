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
#include once "render.bi"
#include once "shape.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XFIXES_QUERY_VERSION => XCB_XFIXES_QUERY_VERSION_
''     constant XCB_XFIXES_CHANGE_SAVE_SET => XCB_XFIXES_CHANGE_SAVE_SET_
''     constant XCB_XFIXES_SELECT_SELECTION_INPUT => XCB_XFIXES_SELECT_SELECTION_INPUT_
''     constant XCB_XFIXES_SELECT_CURSOR_INPUT => XCB_XFIXES_SELECT_CURSOR_INPUT_
''     constant XCB_XFIXES_GET_CURSOR_IMAGE => XCB_XFIXES_GET_CURSOR_IMAGE_
''     constant XCB_XFIXES_CREATE_REGION => XCB_XFIXES_CREATE_REGION_
''     constant XCB_XFIXES_CREATE_REGION_FROM_BITMAP => XCB_XFIXES_CREATE_REGION_FROM_BITMAP_
''     constant XCB_XFIXES_CREATE_REGION_FROM_WINDOW => XCB_XFIXES_CREATE_REGION_FROM_WINDOW_
''     constant XCB_XFIXES_CREATE_REGION_FROM_GC => XCB_XFIXES_CREATE_REGION_FROM_GC_
''     constant XCB_XFIXES_CREATE_REGION_FROM_PICTURE => XCB_XFIXES_CREATE_REGION_FROM_PICTURE_
''     constant XCB_XFIXES_DESTROY_REGION => XCB_XFIXES_DESTROY_REGION_
''     constant XCB_XFIXES_SET_REGION => XCB_XFIXES_SET_REGION_
''     constant XCB_XFIXES_COPY_REGION => XCB_XFIXES_COPY_REGION_
''     constant XCB_XFIXES_UNION_REGION => XCB_XFIXES_UNION_REGION_
''     constant XCB_XFIXES_INTERSECT_REGION => XCB_XFIXES_INTERSECT_REGION_
''     constant XCB_XFIXES_SUBTRACT_REGION => XCB_XFIXES_SUBTRACT_REGION_
''     constant XCB_XFIXES_INVERT_REGION => XCB_XFIXES_INVERT_REGION_
''     constant XCB_XFIXES_TRANSLATE_REGION => XCB_XFIXES_TRANSLATE_REGION_
''     constant XCB_XFIXES_REGION_EXTENTS => XCB_XFIXES_REGION_EXTENTS_
''     constant XCB_XFIXES_FETCH_REGION => XCB_XFIXES_FETCH_REGION_
''     constant XCB_XFIXES_SET_GC_CLIP_REGION => XCB_XFIXES_SET_GC_CLIP_REGION_
''     constant XCB_XFIXES_SET_WINDOW_SHAPE_REGION => XCB_XFIXES_SET_WINDOW_SHAPE_REGION_
''     constant XCB_XFIXES_SET_PICTURE_CLIP_REGION => XCB_XFIXES_SET_PICTURE_CLIP_REGION_
''     constant XCB_XFIXES_SET_CURSOR_NAME => XCB_XFIXES_SET_CURSOR_NAME_
''     constant XCB_XFIXES_GET_CURSOR_NAME => XCB_XFIXES_GET_CURSOR_NAME_
''     constant XCB_XFIXES_GET_CURSOR_IMAGE_AND_NAME => XCB_XFIXES_GET_CURSOR_IMAGE_AND_NAME_
''     constant XCB_XFIXES_CHANGE_CURSOR => XCB_XFIXES_CHANGE_CURSOR_
''     constant XCB_XFIXES_CHANGE_CURSOR_BY_NAME => XCB_XFIXES_CHANGE_CURSOR_BY_NAME_
''     constant XCB_XFIXES_EXPAND_REGION => XCB_XFIXES_EXPAND_REGION_
''     constant XCB_XFIXES_HIDE_CURSOR => XCB_XFIXES_HIDE_CURSOR_
''     constant XCB_XFIXES_SHOW_CURSOR => XCB_XFIXES_SHOW_CURSOR_
''     constant XCB_XFIXES_CREATE_POINTER_BARRIER => XCB_XFIXES_CREATE_POINTER_BARRIER_
''     constant XCB_XFIXES_DELETE_POINTER_BARRIER => XCB_XFIXES_DELETE_POINTER_BARRIER_

extern "C"

#define __XFIXES_H
const XCB_XFIXES_MAJOR_VERSION = 5
const XCB_XFIXES_MINOR_VERSION = 0
extern xcb_xfixes_id as xcb_extension_t

type xcb_xfixes_query_version_cookie_t
	sequence as ulong
end type

const XCB_XFIXES_QUERY_VERSION_ = 0

type xcb_xfixes_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ulong
	client_minor_version as ulong
end type

type xcb_xfixes_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
	pad1(0 to 15) as ubyte
end type

type xcb_xfixes_save_set_mode_t as long
enum
	XCB_XFIXES_SAVE_SET_MODE_INSERT = 0
	XCB_XFIXES_SAVE_SET_MODE_DELETE = 1
end enum

type xcb_xfixes_save_set_target_t as long
enum
	XCB_XFIXES_SAVE_SET_TARGET_NEAREST = 0
	XCB_XFIXES_SAVE_SET_TARGET_ROOT = 1
end enum

type xcb_xfixes_save_set_mapping_t as long
enum
	XCB_XFIXES_SAVE_SET_MAPPING_MAP = 0
	XCB_XFIXES_SAVE_SET_MAPPING_UNMAP = 1
end enum

const XCB_XFIXES_CHANGE_SAVE_SET_ = 1

type xcb_xfixes_change_save_set_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	mode as ubyte
	target as ubyte
	map as ubyte
	pad0 as ubyte
	window as xcb_window_t
end type

type xcb_xfixes_selection_event_t as long
enum
	XCB_XFIXES_SELECTION_EVENT_SET_SELECTION_OWNER = 0
	XCB_XFIXES_SELECTION_EVENT_SELECTION_WINDOW_DESTROY = 1
	XCB_XFIXES_SELECTION_EVENT_SELECTION_CLIENT_CLOSE = 2
end enum

type xcb_xfixes_selection_event_mask_t as long
enum
	XCB_XFIXES_SELECTION_EVENT_MASK_SET_SELECTION_OWNER = 1
	XCB_XFIXES_SELECTION_EVENT_MASK_SELECTION_WINDOW_DESTROY = 2
	XCB_XFIXES_SELECTION_EVENT_MASK_SELECTION_CLIENT_CLOSE = 4
end enum

const XCB_XFIXES_SELECTION_NOTIFY = 0

type xcb_xfixes_selection_notify_event_t
	response_type as ubyte
	subtype as ubyte
	sequence as ushort
	window as xcb_window_t
	owner as xcb_window_t
	selection as xcb_atom_t
	timestamp as xcb_timestamp_t
	selection_timestamp as xcb_timestamp_t
	pad0(0 to 7) as ubyte
end type

const XCB_XFIXES_SELECT_SELECTION_INPUT_ = 2

type xcb_xfixes_select_selection_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	selection as xcb_atom_t
	event_mask as ulong
end type

type xcb_xfixes_cursor_notify_t as long
enum
	XCB_XFIXES_CURSOR_NOTIFY_DISPLAY_CURSOR = 0
end enum

type xcb_xfixes_cursor_notify_mask_t as long
enum
	XCB_XFIXES_CURSOR_NOTIFY_MASK_DISPLAY_CURSOR = 1
end enum

const XCB_XFIXES_CURSOR_NOTIFY = 1

type xcb_xfixes_cursor_notify_event_t
	response_type as ubyte
	subtype as ubyte
	sequence as ushort
	window as xcb_window_t
	cursor_serial as ulong
	timestamp as xcb_timestamp_t
	name as xcb_atom_t
	pad0(0 to 11) as ubyte
end type

const XCB_XFIXES_SELECT_CURSOR_INPUT_ = 3

type xcb_xfixes_select_cursor_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	event_mask as ulong
end type

type xcb_xfixes_get_cursor_image_cookie_t
	sequence as ulong
end type

const XCB_XFIXES_GET_CURSOR_IMAGE_ = 4

type xcb_xfixes_get_cursor_image_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xfixes_get_cursor_image_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	x as short
	y as short
	width as ushort
	height as ushort
	xhot as ushort
	yhot as ushort
	cursor_serial as ulong
	pad1(0 to 7) as ubyte
end type

type xcb_xfixes_region_t as ulong

type xcb_xfixes_region_iterator_t
	data as xcb_xfixes_region_t ptr
	as long rem
	index as long
end type

const XCB_XFIXES_BAD_REGION = 0

type xcb_xfixes_bad_region_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

type xcb_xfixes_region_enum_t as long
enum
	XCB_XFIXES_REGION_NONE = 0
end enum

const XCB_XFIXES_CREATE_REGION_ = 5

type xcb_xfixes_create_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
end type

const XCB_XFIXES_CREATE_REGION_FROM_BITMAP_ = 6

type xcb_xfixes_create_region_from_bitmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
	bitmap as xcb_pixmap_t
end type

const XCB_XFIXES_CREATE_REGION_FROM_WINDOW_ = 7

type xcb_xfixes_create_region_from_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
	window as xcb_window_t
	kind as xcb_shape_kind_t
	pad0(0 to 2) as ubyte
end type

const XCB_XFIXES_CREATE_REGION_FROM_GC_ = 8

type xcb_xfixes_create_region_from_gc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
	gc as xcb_gcontext_t
end type

const XCB_XFIXES_CREATE_REGION_FROM_PICTURE_ = 9

type xcb_xfixes_create_region_from_picture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
	picture as xcb_render_picture_t
end type

const XCB_XFIXES_DESTROY_REGION_ = 10

type xcb_xfixes_destroy_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
end type

const XCB_XFIXES_SET_REGION_ = 11

type xcb_xfixes_set_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
end type

const XCB_XFIXES_COPY_REGION_ = 12

type xcb_xfixes_copy_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source as xcb_xfixes_region_t
	destination as xcb_xfixes_region_t
end type

const XCB_XFIXES_UNION_REGION_ = 13

type xcb_xfixes_union_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source1 as xcb_xfixes_region_t
	source2 as xcb_xfixes_region_t
	destination as xcb_xfixes_region_t
end type

const XCB_XFIXES_INTERSECT_REGION_ = 14

type xcb_xfixes_intersect_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source1 as xcb_xfixes_region_t
	source2 as xcb_xfixes_region_t
	destination as xcb_xfixes_region_t
end type

const XCB_XFIXES_SUBTRACT_REGION_ = 15

type xcb_xfixes_subtract_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source1 as xcb_xfixes_region_t
	source2 as xcb_xfixes_region_t
	destination as xcb_xfixes_region_t
end type

const XCB_XFIXES_INVERT_REGION_ = 16

type xcb_xfixes_invert_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source as xcb_xfixes_region_t
	bounds as xcb_rectangle_t
	destination as xcb_xfixes_region_t
end type

const XCB_XFIXES_TRANSLATE_REGION_ = 17

type xcb_xfixes_translate_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
	dx as short
	dy as short
end type

const XCB_XFIXES_REGION_EXTENTS_ = 18

type xcb_xfixes_region_extents_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source as xcb_xfixes_region_t
	destination as xcb_xfixes_region_t
end type

type xcb_xfixes_fetch_region_cookie_t
	sequence as ulong
end type

const XCB_XFIXES_FETCH_REGION_ = 19

type xcb_xfixes_fetch_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	region as xcb_xfixes_region_t
end type

type xcb_xfixes_fetch_region_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	extents as xcb_rectangle_t
	pad1(0 to 15) as ubyte
end type

const XCB_XFIXES_SET_GC_CLIP_REGION_ = 20

type xcb_xfixes_set_gc_clip_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	gc as xcb_gcontext_t
	region as xcb_xfixes_region_t
	x_origin as short
	y_origin as short
end type

const XCB_XFIXES_SET_WINDOW_SHAPE_REGION_ = 21

type xcb_xfixes_set_window_shape_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	dest as xcb_window_t
	dest_kind as xcb_shape_kind_t
	pad0(0 to 2) as ubyte
	x_offset as short
	y_offset as short
	region as xcb_xfixes_region_t
end type

const XCB_XFIXES_SET_PICTURE_CLIP_REGION_ = 22

type xcb_xfixes_set_picture_clip_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	region as xcb_xfixes_region_t
	x_origin as short
	y_origin as short
end type

const XCB_XFIXES_SET_CURSOR_NAME_ = 23

type xcb_xfixes_set_cursor_name_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cursor as xcb_cursor_t
	nbytes as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_xfixes_get_cursor_name_cookie_t
	sequence as ulong
end type

const XCB_XFIXES_GET_CURSOR_NAME_ = 24

type xcb_xfixes_get_cursor_name_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cursor as xcb_cursor_t
end type

type xcb_xfixes_get_cursor_name_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	atom as xcb_atom_t
	nbytes as ushort
	pad1(0 to 17) as ubyte
end type

type xcb_xfixes_get_cursor_image_and_name_cookie_t
	sequence as ulong
end type

const XCB_XFIXES_GET_CURSOR_IMAGE_AND_NAME_ = 25

type xcb_xfixes_get_cursor_image_and_name_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xfixes_get_cursor_image_and_name_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	x as short
	y as short
	width as ushort
	height as ushort
	xhot as ushort
	yhot as ushort
	cursor_serial as ulong
	cursor_atom as xcb_atom_t
	nbytes as ushort
	pad1(0 to 1) as ubyte
end type

const XCB_XFIXES_CHANGE_CURSOR_ = 26

type xcb_xfixes_change_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source as xcb_cursor_t
	destination as xcb_cursor_t
end type

const XCB_XFIXES_CHANGE_CURSOR_BY_NAME_ = 27

type xcb_xfixes_change_cursor_by_name_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	src as xcb_cursor_t
	nbytes as ushort
	pad0(0 to 1) as ubyte
end type

const XCB_XFIXES_EXPAND_REGION_ = 28

type xcb_xfixes_expand_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	source as xcb_xfixes_region_t
	destination as xcb_xfixes_region_t
	left as ushort
	right as ushort
	top as ushort
	bottom as ushort
end type

const XCB_XFIXES_HIDE_CURSOR_ = 29

type xcb_xfixes_hide_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_XFIXES_SHOW_CURSOR_ = 30

type xcb_xfixes_show_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_xfixes_barrier_t as ulong

type xcb_xfixes_barrier_iterator_t
	data as xcb_xfixes_barrier_t ptr
	as long rem
	index as long
end type

type xcb_xfixes_barrier_directions_t as long
enum
	XCB_XFIXES_BARRIER_DIRECTIONS_POSITIVE_X = 1
	XCB_XFIXES_BARRIER_DIRECTIONS_POSITIVE_Y = 2
	XCB_XFIXES_BARRIER_DIRECTIONS_NEGATIVE_X = 4
	XCB_XFIXES_BARRIER_DIRECTIONS_NEGATIVE_Y = 8
end enum

const XCB_XFIXES_CREATE_POINTER_BARRIER_ = 31

type xcb_xfixes_create_pointer_barrier_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	barrier as xcb_xfixes_barrier_t
	window as xcb_window_t
	x1 as ushort
	y1 as ushort
	x2 as ushort
	y2 as ushort
	directions as ulong
	pad0(0 to 1) as ubyte
	num_devices as ushort
end type

const XCB_XFIXES_DELETE_POINTER_BARRIER_ = 32

type xcb_xfixes_delete_pointer_barrier_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	barrier as xcb_xfixes_barrier_t
end type

declare function xcb_xfixes_query_version(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_xfixes_query_version_cookie_t
declare function xcb_xfixes_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_xfixes_query_version_cookie_t
declare function xcb_xfixes_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xfixes_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xfixes_query_version_reply_t ptr
declare function xcb_xfixes_change_save_set_checked(byval c as xcb_connection_t ptr, byval mode as ubyte, byval target as ubyte, byval map as ubyte, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xfixes_change_save_set(byval c as xcb_connection_t ptr, byval mode as ubyte, byval target as ubyte, byval map as ubyte, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xfixes_select_selection_input_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval selection as xcb_atom_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_xfixes_select_selection_input(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval selection as xcb_atom_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_xfixes_select_cursor_input_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_xfixes_select_cursor_input(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval event_mask as ulong) as xcb_void_cookie_t
declare function xcb_xfixes_get_cursor_image_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_get_cursor_image(byval c as xcb_connection_t ptr) as xcb_xfixes_get_cursor_image_cookie_t
declare function xcb_xfixes_get_cursor_image_unchecked(byval c as xcb_connection_t ptr) as xcb_xfixes_get_cursor_image_cookie_t
declare function xcb_xfixes_get_cursor_image_cursor_image(byval R as const xcb_xfixes_get_cursor_image_reply_t ptr) as ulong ptr
declare function xcb_xfixes_get_cursor_image_cursor_image_length(byval R as const xcb_xfixes_get_cursor_image_reply_t ptr) as long
declare function xcb_xfixes_get_cursor_image_cursor_image_end(byval R as const xcb_xfixes_get_cursor_image_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xfixes_get_cursor_image_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xfixes_get_cursor_image_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xfixes_get_cursor_image_reply_t ptr
declare sub xcb_xfixes_region_next(byval i as xcb_xfixes_region_iterator_t ptr)
declare function xcb_xfixes_region_end(byval i as xcb_xfixes_region_iterator_t) as xcb_generic_iterator_t
declare function xcb_xfixes_create_region_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_xfixes_create_region_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_xfixes_create_region(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_bitmap_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval bitmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_bitmap(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval bitmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_window_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval window as xcb_window_t, byval kind as xcb_shape_kind_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_window(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval window as xcb_window_t, byval kind as xcb_shape_kind_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_gc_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval gc as xcb_gcontext_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_gc(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval gc as xcb_gcontext_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_picture_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval picture as xcb_render_picture_t) as xcb_void_cookie_t
declare function xcb_xfixes_create_region_from_picture(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval picture as xcb_render_picture_t) as xcb_void_cookie_t
declare function xcb_xfixes_destroy_region_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_destroy_region(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_set_region_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_xfixes_set_region_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_xfixes_set_region(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_xfixes_copy_region_checked(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_copy_region(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_union_region_checked(byval c as xcb_connection_t ptr, byval source1 as xcb_xfixes_region_t, byval source2 as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_union_region(byval c as xcb_connection_t ptr, byval source1 as xcb_xfixes_region_t, byval source2 as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_intersect_region_checked(byval c as xcb_connection_t ptr, byval source1 as xcb_xfixes_region_t, byval source2 as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_intersect_region(byval c as xcb_connection_t ptr, byval source1 as xcb_xfixes_region_t, byval source2 as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_subtract_region_checked(byval c as xcb_connection_t ptr, byval source1 as xcb_xfixes_region_t, byval source2 as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_subtract_region(byval c as xcb_connection_t ptr, byval source1 as xcb_xfixes_region_t, byval source2 as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_invert_region_checked(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval bounds as xcb_rectangle_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_invert_region(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval bounds as xcb_rectangle_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_translate_region_checked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval dx as short, byval dy as short) as xcb_void_cookie_t
declare function xcb_xfixes_translate_region(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t, byval dx as short, byval dy as short) as xcb_void_cookie_t
declare function xcb_xfixes_region_extents_checked(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_region_extents(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_fetch_region_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_fetch_region(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t) as xcb_xfixes_fetch_region_cookie_t
declare function xcb_xfixes_fetch_region_unchecked(byval c as xcb_connection_t ptr, byval region as xcb_xfixes_region_t) as xcb_xfixes_fetch_region_cookie_t
declare function xcb_xfixes_fetch_region_rectangles(byval R as const xcb_xfixes_fetch_region_reply_t ptr) as xcb_rectangle_t ptr
declare function xcb_xfixes_fetch_region_rectangles_length(byval R as const xcb_xfixes_fetch_region_reply_t ptr) as long
declare function xcb_xfixes_fetch_region_rectangles_iterator(byval R as const xcb_xfixes_fetch_region_reply_t ptr) as xcb_rectangle_iterator_t
declare function xcb_xfixes_fetch_region_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xfixes_fetch_region_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xfixes_fetch_region_reply_t ptr
declare function xcb_xfixes_set_gc_clip_region_checked(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t, byval region as xcb_xfixes_region_t, byval x_origin as short, byval y_origin as short) as xcb_void_cookie_t
declare function xcb_xfixes_set_gc_clip_region(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t, byval region as xcb_xfixes_region_t, byval x_origin as short, byval y_origin as short) as xcb_void_cookie_t
declare function xcb_xfixes_set_window_shape_region_checked(byval c as xcb_connection_t ptr, byval dest as xcb_window_t, byval dest_kind as xcb_shape_kind_t, byval x_offset as short, byval y_offset as short, byval region as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_set_window_shape_region(byval c as xcb_connection_t ptr, byval dest as xcb_window_t, byval dest_kind as xcb_shape_kind_t, byval x_offset as short, byval y_offset as short, byval region as xcb_xfixes_region_t) as xcb_void_cookie_t
declare function xcb_xfixes_set_picture_clip_region_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval region as xcb_xfixes_region_t, byval x_origin as short, byval y_origin as short) as xcb_void_cookie_t
declare function xcb_xfixes_set_picture_clip_region(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval region as xcb_xfixes_region_t, byval x_origin as short, byval y_origin as short) as xcb_void_cookie_t
declare function xcb_xfixes_set_cursor_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_set_cursor_name_checked(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t, byval nbytes as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_xfixes_set_cursor_name(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t, byval nbytes as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_xfixes_get_cursor_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_get_cursor_name(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t) as xcb_xfixes_get_cursor_name_cookie_t
declare function xcb_xfixes_get_cursor_name_unchecked(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t) as xcb_xfixes_get_cursor_name_cookie_t
declare function xcb_xfixes_get_cursor_name_name(byval R as const xcb_xfixes_get_cursor_name_reply_t ptr) as zstring ptr
declare function xcb_xfixes_get_cursor_name_name_length(byval R as const xcb_xfixes_get_cursor_name_reply_t ptr) as long
declare function xcb_xfixes_get_cursor_name_name_end(byval R as const xcb_xfixes_get_cursor_name_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xfixes_get_cursor_name_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xfixes_get_cursor_name_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xfixes_get_cursor_name_reply_t ptr
declare function xcb_xfixes_get_cursor_image_and_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_get_cursor_image_and_name(byval c as xcb_connection_t ptr) as xcb_xfixes_get_cursor_image_and_name_cookie_t
declare function xcb_xfixes_get_cursor_image_and_name_unchecked(byval c as xcb_connection_t ptr) as xcb_xfixes_get_cursor_image_and_name_cookie_t
declare function xcb_xfixes_get_cursor_image_and_name_name(byval R as const xcb_xfixes_get_cursor_image_and_name_reply_t ptr) as zstring ptr
declare function xcb_xfixes_get_cursor_image_and_name_name_length(byval R as const xcb_xfixes_get_cursor_image_and_name_reply_t ptr) as long
declare function xcb_xfixes_get_cursor_image_and_name_name_end(byval R as const xcb_xfixes_get_cursor_image_and_name_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xfixes_get_cursor_image_and_name_cursor_image(byval R as const xcb_xfixes_get_cursor_image_and_name_reply_t ptr) as ulong ptr
declare function xcb_xfixes_get_cursor_image_and_name_cursor_image_length(byval R as const xcb_xfixes_get_cursor_image_and_name_reply_t ptr) as long
declare function xcb_xfixes_get_cursor_image_and_name_cursor_image_end(byval R as const xcb_xfixes_get_cursor_image_and_name_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xfixes_get_cursor_image_and_name_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xfixes_get_cursor_image_and_name_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xfixes_get_cursor_image_and_name_reply_t ptr
declare function xcb_xfixes_change_cursor_checked(byval c as xcb_connection_t ptr, byval source as xcb_cursor_t, byval destination as xcb_cursor_t) as xcb_void_cookie_t
declare function xcb_xfixes_change_cursor(byval c as xcb_connection_t ptr, byval source as xcb_cursor_t, byval destination as xcb_cursor_t) as xcb_void_cookie_t
declare function xcb_xfixes_change_cursor_by_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_change_cursor_by_name_checked(byval c as xcb_connection_t ptr, byval src as xcb_cursor_t, byval nbytes as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_xfixes_change_cursor_by_name(byval c as xcb_connection_t ptr, byval src as xcb_cursor_t, byval nbytes as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_xfixes_expand_region_checked(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t, byval left as ushort, byval right as ushort, byval top as ushort, byval bottom as ushort) as xcb_void_cookie_t
declare function xcb_xfixes_expand_region(byval c as xcb_connection_t ptr, byval source as xcb_xfixes_region_t, byval destination as xcb_xfixes_region_t, byval left as ushort, byval right as ushort, byval top as ushort, byval bottom as ushort) as xcb_void_cookie_t
declare function xcb_xfixes_hide_cursor_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xfixes_hide_cursor(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xfixes_show_cursor_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_xfixes_show_cursor(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare sub xcb_xfixes_barrier_next(byval i as xcb_xfixes_barrier_iterator_t ptr)
declare function xcb_xfixes_barrier_end(byval i as xcb_xfixes_barrier_iterator_t) as xcb_generic_iterator_t
declare function xcb_xfixes_create_pointer_barrier_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xfixes_create_pointer_barrier_checked(byval c as xcb_connection_t ptr, byval barrier as xcb_xfixes_barrier_t, byval window as xcb_window_t, byval x1 as ushort, byval y1 as ushort, byval x2 as ushort, byval y2 as ushort, byval directions as ulong, byval num_devices as ushort, byval devices as const ushort ptr) as xcb_void_cookie_t
declare function xcb_xfixes_create_pointer_barrier(byval c as xcb_connection_t ptr, byval barrier as xcb_xfixes_barrier_t, byval window as xcb_window_t, byval x1 as ushort, byval y1 as ushort, byval x2 as ushort, byval y2 as ushort, byval directions as ulong, byval num_devices as ushort, byval devices as const ushort ptr) as xcb_void_cookie_t
declare function xcb_xfixes_delete_pointer_barrier_checked(byval c as xcb_connection_t ptr, byval barrier as xcb_xfixes_barrier_t) as xcb_void_cookie_t
declare function xcb_xfixes_delete_pointer_barrier(byval c as xcb_connection_t ptr, byval barrier as xcb_xfixes_barrier_t) as xcb_void_cookie_t

end extern
