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

'' The following symbols have been renamed:
''     constant XCB_CREATE_WINDOW => XCB_CREATE_WINDOW_
''     constant XCB_CHANGE_WINDOW_ATTRIBUTES => XCB_CHANGE_WINDOW_ATTRIBUTES_
''     constant XCB_GET_WINDOW_ATTRIBUTES => XCB_GET_WINDOW_ATTRIBUTES_
''     constant XCB_DESTROY_WINDOW => XCB_DESTROY_WINDOW_
''     constant XCB_DESTROY_SUBWINDOWS => XCB_DESTROY_SUBWINDOWS_
''     constant XCB_CHANGE_SAVE_SET => XCB_CHANGE_SAVE_SET_
''     constant XCB_REPARENT_WINDOW => XCB_REPARENT_WINDOW_
''     constant XCB_MAP_WINDOW => XCB_MAP_WINDOW_
''     constant XCB_MAP_SUBWINDOWS => XCB_MAP_SUBWINDOWS_
''     constant XCB_UNMAP_WINDOW => XCB_UNMAP_WINDOW_
''     constant XCB_UNMAP_SUBWINDOWS => XCB_UNMAP_SUBWINDOWS_
''     constant XCB_CONFIGURE_WINDOW => XCB_CONFIGURE_WINDOW_
''     constant XCB_CIRCULATE_WINDOW => XCB_CIRCULATE_WINDOW_
''     constant XCB_GET_GEOMETRY => XCB_GET_GEOMETRY_
''     constant XCB_QUERY_TREE => XCB_QUERY_TREE_
''     constant XCB_INTERN_ATOM => XCB_INTERN_ATOM_
''     constant XCB_GET_ATOM_NAME => XCB_GET_ATOM_NAME_
''     constant XCB_CHANGE_PROPERTY => XCB_CHANGE_PROPERTY_
''     constant XCB_DELETE_PROPERTY => XCB_DELETE_PROPERTY_
''     constant XCB_GET_PROPERTY => XCB_GET_PROPERTY_
''     constant XCB_LIST_PROPERTIES => XCB_LIST_PROPERTIES_
''     constant XCB_SET_SELECTION_OWNER => XCB_SET_SELECTION_OWNER_
''     constant XCB_GET_SELECTION_OWNER => XCB_GET_SELECTION_OWNER_
''     constant XCB_CONVERT_SELECTION => XCB_CONVERT_SELECTION_
''     constant XCB_SEND_EVENT => XCB_SEND_EVENT_
''     constant XCB_GRAB_POINTER => XCB_GRAB_POINTER_
''     constant XCB_UNGRAB_POINTER => XCB_UNGRAB_POINTER_
''     constant XCB_GRAB_BUTTON => XCB_GRAB_BUTTON_
''     constant XCB_UNGRAB_BUTTON => XCB_UNGRAB_BUTTON_
''     constant XCB_CHANGE_ACTIVE_POINTER_GRAB => XCB_CHANGE_ACTIVE_POINTER_GRAB_
''     constant XCB_GRAB_KEYBOARD => XCB_GRAB_KEYBOARD_
''     constant XCB_UNGRAB_KEYBOARD => XCB_UNGRAB_KEYBOARD_
''     constant XCB_GRAB_KEY => XCB_GRAB_KEY_
''     constant XCB_UNGRAB_KEY => XCB_UNGRAB_KEY_
''     constant XCB_ALLOW_EVENTS => XCB_ALLOW_EVENTS_
''     constant XCB_GRAB_SERVER => XCB_GRAB_SERVER_
''     constant XCB_UNGRAB_SERVER => XCB_UNGRAB_SERVER_
''     constant XCB_QUERY_POINTER => XCB_QUERY_POINTER_
''     constant XCB_GET_MOTION_EVENTS => XCB_GET_MOTION_EVENTS_
''     constant XCB_TRANSLATE_COORDINATES => XCB_TRANSLATE_COORDINATES_
''     constant XCB_WARP_POINTER => XCB_WARP_POINTER_
''     constant XCB_SET_INPUT_FOCUS => XCB_SET_INPUT_FOCUS_
''     constant XCB_GET_INPUT_FOCUS => XCB_GET_INPUT_FOCUS_
''     constant XCB_QUERY_KEYMAP => XCB_QUERY_KEYMAP_
''     constant XCB_OPEN_FONT => XCB_OPEN_FONT_
''     constant XCB_CLOSE_FONT => XCB_CLOSE_FONT_
''     constant XCB_QUERY_FONT => XCB_QUERY_FONT_
''     constant XCB_QUERY_TEXT_EXTENTS => XCB_QUERY_TEXT_EXTENTS_
''     constant XCB_LIST_FONTS => XCB_LIST_FONTS_
''     constant XCB_LIST_FONTS_WITH_INFO => XCB_LIST_FONTS_WITH_INFO_
''     constant XCB_SET_FONT_PATH => XCB_SET_FONT_PATH_
''     constant XCB_GET_FONT_PATH => XCB_GET_FONT_PATH_
''     constant XCB_CREATE_PIXMAP => XCB_CREATE_PIXMAP_
''     constant XCB_FREE_PIXMAP => XCB_FREE_PIXMAP_
''     constant XCB_CREATE_GC => XCB_CREATE_GC_
''     constant XCB_CHANGE_GC => XCB_CHANGE_GC_
''     constant XCB_COPY_GC => XCB_COPY_GC_
''     constant XCB_SET_DASHES => XCB_SET_DASHES_
''     constant XCB_SET_CLIP_RECTANGLES => XCB_SET_CLIP_RECTANGLES_
''     constant XCB_FREE_GC => XCB_FREE_GC_
''     constant XCB_CLEAR_AREA => XCB_CLEAR_AREA_
''     constant XCB_COPY_AREA => XCB_COPY_AREA_
''     constant XCB_COPY_PLANE => XCB_COPY_PLANE_
''     constant XCB_POLY_POINT => XCB_POLY_POINT_
''     constant XCB_POLY_LINE => XCB_POLY_LINE_
''     constant XCB_POLY_SEGMENT => XCB_POLY_SEGMENT_
''     constant XCB_POLY_RECTANGLE => XCB_POLY_RECTANGLE_
''     constant XCB_POLY_ARC => XCB_POLY_ARC_
''     constant XCB_FILL_POLY => XCB_FILL_POLY_
''     constant XCB_POLY_FILL_RECTANGLE => XCB_POLY_FILL_RECTANGLE_
''     constant XCB_POLY_FILL_ARC => XCB_POLY_FILL_ARC_
''     constant XCB_PUT_IMAGE => XCB_PUT_IMAGE_
''     constant XCB_GET_IMAGE => XCB_GET_IMAGE_
''     constant XCB_POLY_TEXT_8 => XCB_POLY_TEXT_8_
''     constant XCB_POLY_TEXT_16 => XCB_POLY_TEXT_16_
''     constant XCB_IMAGE_TEXT_8 => XCB_IMAGE_TEXT_8_
''     constant XCB_IMAGE_TEXT_16 => XCB_IMAGE_TEXT_16_
''     constant XCB_CREATE_COLORMAP => XCB_CREATE_COLORMAP_
''     constant XCB_FREE_COLORMAP => XCB_FREE_COLORMAP_
''     constant XCB_COPY_COLORMAP_AND_FREE => XCB_COPY_COLORMAP_AND_FREE_
''     constant XCB_INSTALL_COLORMAP => XCB_INSTALL_COLORMAP_
''     constant XCB_UNINSTALL_COLORMAP => XCB_UNINSTALL_COLORMAP_
''     constant XCB_LIST_INSTALLED_COLORMAPS => XCB_LIST_INSTALLED_COLORMAPS_
''     constant XCB_ALLOC_COLOR => XCB_ALLOC_COLOR_
''     constant XCB_ALLOC_NAMED_COLOR => XCB_ALLOC_NAMED_COLOR_
''     constant XCB_ALLOC_COLOR_CELLS => XCB_ALLOC_COLOR_CELLS_
''     constant XCB_ALLOC_COLOR_PLANES => XCB_ALLOC_COLOR_PLANES_
''     constant XCB_FREE_COLORS => XCB_FREE_COLORS_
''     constant XCB_STORE_COLORS => XCB_STORE_COLORS_
''     constant XCB_STORE_NAMED_COLOR => XCB_STORE_NAMED_COLOR_
''     constant XCB_QUERY_COLORS => XCB_QUERY_COLORS_
''     constant XCB_LOOKUP_COLOR => XCB_LOOKUP_COLOR_
''     constant XCB_CREATE_CURSOR => XCB_CREATE_CURSOR_
''     constant XCB_CREATE_GLYPH_CURSOR => XCB_CREATE_GLYPH_CURSOR_
''     constant XCB_FREE_CURSOR => XCB_FREE_CURSOR_
''     constant XCB_RECOLOR_CURSOR => XCB_RECOLOR_CURSOR_
''     constant XCB_QUERY_BEST_SIZE => XCB_QUERY_BEST_SIZE_
''     constant XCB_QUERY_EXTENSION => XCB_QUERY_EXTENSION_
''     constant XCB_LIST_EXTENSIONS => XCB_LIST_EXTENSIONS_
''     constant XCB_CHANGE_KEYBOARD_MAPPING => XCB_CHANGE_KEYBOARD_MAPPING_
''     constant XCB_GET_KEYBOARD_MAPPING => XCB_GET_KEYBOARD_MAPPING_
''     constant XCB_CHANGE_KEYBOARD_CONTROL => XCB_CHANGE_KEYBOARD_CONTROL_
''     constant XCB_GET_KEYBOARD_CONTROL => XCB_GET_KEYBOARD_CONTROL_
''     constant XCB_BELL => XCB_BELL_
''     constant XCB_CHANGE_POINTER_CONTROL => XCB_CHANGE_POINTER_CONTROL_
''     constant XCB_GET_POINTER_CONTROL => XCB_GET_POINTER_CONTROL_
''     constant XCB_SET_SCREEN_SAVER => XCB_SET_SCREEN_SAVER_
''     constant XCB_GET_SCREEN_SAVER => XCB_GET_SCREEN_SAVER_
''     constant XCB_CHANGE_HOSTS => XCB_CHANGE_HOSTS_
''     constant XCB_LIST_HOSTS => XCB_LIST_HOSTS_
''     constant XCB_SET_ACCESS_CONTROL => XCB_SET_ACCESS_CONTROL_
''     constant XCB_SET_CLOSE_DOWN_MODE => XCB_SET_CLOSE_DOWN_MODE_
''     constant XCB_KILL_CLIENT => XCB_KILL_CLIENT_
''     constant XCB_ROTATE_PROPERTIES => XCB_ROTATE_PROPERTIES_
''     constant XCB_FORCE_SCREEN_SAVER => XCB_FORCE_SCREEN_SAVER_
''     constant XCB_SET_POINTER_MAPPING => XCB_SET_POINTER_MAPPING_
''     constant XCB_GET_POINTER_MAPPING => XCB_GET_POINTER_MAPPING_
''     constant XCB_SET_MODIFIER_MAPPING => XCB_SET_MODIFIER_MAPPING_
''     constant XCB_GET_MODIFIER_MAPPING => XCB_GET_MODIFIER_MAPPING_
''     constant XCB_NO_OPERATION => XCB_NO_OPERATION_

extern "C"

#define __XPROTO_H

type xcb_char2b_t
	byte1 as ubyte
	byte2 as ubyte
end type

type xcb_char2b_iterator_t
	data as xcb_char2b_t ptr
	as long rem
	index as long
end type

type xcb_window_t as ulong

type xcb_window_iterator_t
	data as xcb_window_t ptr
	as long rem
	index as long
end type

type xcb_pixmap_t as ulong

type xcb_pixmap_iterator_t
	data as xcb_pixmap_t ptr
	as long rem
	index as long
end type

type xcb_cursor_t as ulong

type xcb_cursor_iterator_t
	data as xcb_cursor_t ptr
	as long rem
	index as long
end type

type xcb_font_t as ulong

type xcb_font_iterator_t
	data as xcb_font_t ptr
	as long rem
	index as long
end type

type xcb_gcontext_t as ulong

type xcb_gcontext_iterator_t
	data as xcb_gcontext_t ptr
	as long rem
	index as long
end type

type xcb_colormap_t as ulong

type xcb_colormap_iterator_t
	data as xcb_colormap_t ptr
	as long rem
	index as long
end type

type xcb_atom_t as ulong

type xcb_atom_iterator_t
	data as xcb_atom_t ptr
	as long rem
	index as long
end type

type xcb_drawable_t as ulong

type xcb_drawable_iterator_t
	data as xcb_drawable_t ptr
	as long rem
	index as long
end type

type xcb_fontable_t as ulong

type xcb_fontable_iterator_t
	data as xcb_fontable_t ptr
	as long rem
	index as long
end type

type xcb_visualid_t as ulong

type xcb_visualid_iterator_t
	data as xcb_visualid_t ptr
	as long rem
	index as long
end type

type xcb_timestamp_t as ulong

type xcb_timestamp_iterator_t
	data as xcb_timestamp_t ptr
	as long rem
	index as long
end type

type xcb_keysym_t as ulong

type xcb_keysym_iterator_t
	data as xcb_keysym_t ptr
	as long rem
	index as long
end type

type xcb_keycode_t as ubyte

type xcb_keycode_iterator_t
	data as xcb_keycode_t ptr
	as long rem
	index as long
end type

type xcb_button_t as ubyte

type xcb_button_iterator_t
	data as xcb_button_t ptr
	as long rem
	index as long
end type

type xcb_point_t
	x as short
	y as short
end type

type xcb_point_iterator_t
	data as xcb_point_t ptr
	as long rem
	index as long
end type

type xcb_rectangle_t
	x as short
	y as short
	width as ushort
	height as ushort
end type

type xcb_rectangle_iterator_t
	data as xcb_rectangle_t ptr
	as long rem
	index as long
end type

type xcb_arc_t
	x as short
	y as short
	width as ushort
	height as ushort
	angle1 as short
	angle2 as short
end type

type xcb_arc_iterator_t
	data as xcb_arc_t ptr
	as long rem
	index as long
end type

type xcb_format_t
	depth as ubyte
	bits_per_pixel as ubyte
	scanline_pad as ubyte
	pad0(0 to 4) as ubyte
end type

type xcb_format_iterator_t
	data as xcb_format_t ptr
	as long rem
	index as long
end type

type xcb_visual_class_t as long
enum
	XCB_VISUAL_CLASS_STATIC_GRAY = 0
	XCB_VISUAL_CLASS_GRAY_SCALE = 1
	XCB_VISUAL_CLASS_STATIC_COLOR = 2
	XCB_VISUAL_CLASS_PSEUDO_COLOR = 3
	XCB_VISUAL_CLASS_TRUE_COLOR = 4
	XCB_VISUAL_CLASS_DIRECT_COLOR = 5
end enum

type xcb_visualtype_t
	visual_id as xcb_visualid_t
	_class as ubyte
	bits_per_rgb_value as ubyte
	colormap_entries as ushort
	red_mask as ulong
	green_mask as ulong
	blue_mask as ulong
	pad0(0 to 3) as ubyte
end type

type xcb_visualtype_iterator_t
	data as xcb_visualtype_t ptr
	as long rem
	index as long
end type

type xcb_depth_t
	depth as ubyte
	pad0 as ubyte
	visuals_len as ushort
	pad1(0 to 3) as ubyte
end type

type xcb_depth_iterator_t
	data as xcb_depth_t ptr
	as long rem
	index as long
end type

type xcb_event_mask_t as long
enum
	XCB_EVENT_MASK_NO_EVENT = 0
	XCB_EVENT_MASK_KEY_PRESS = 1
	XCB_EVENT_MASK_KEY_RELEASE = 2
	XCB_EVENT_MASK_BUTTON_PRESS = 4
	XCB_EVENT_MASK_BUTTON_RELEASE = 8
	XCB_EVENT_MASK_ENTER_WINDOW = 16
	XCB_EVENT_MASK_LEAVE_WINDOW = 32
	XCB_EVENT_MASK_POINTER_MOTION = 64
	XCB_EVENT_MASK_POINTER_MOTION_HINT = 128
	XCB_EVENT_MASK_BUTTON_1_MOTION = 256
	XCB_EVENT_MASK_BUTTON_2_MOTION = 512
	XCB_EVENT_MASK_BUTTON_3_MOTION = 1024
	XCB_EVENT_MASK_BUTTON_4_MOTION = 2048
	XCB_EVENT_MASK_BUTTON_5_MOTION = 4096
	XCB_EVENT_MASK_BUTTON_MOTION = 8192
	XCB_EVENT_MASK_KEYMAP_STATE = 16384
	XCB_EVENT_MASK_EXPOSURE = 32768
	XCB_EVENT_MASK_VISIBILITY_CHANGE = 65536
	XCB_EVENT_MASK_STRUCTURE_NOTIFY = 131072
	XCB_EVENT_MASK_RESIZE_REDIRECT = 262144
	XCB_EVENT_MASK_SUBSTRUCTURE_NOTIFY = 524288
	XCB_EVENT_MASK_SUBSTRUCTURE_REDIRECT = 1048576
	XCB_EVENT_MASK_FOCUS_CHANGE = 2097152
	XCB_EVENT_MASK_PROPERTY_CHANGE = 4194304
	XCB_EVENT_MASK_COLOR_MAP_CHANGE = 8388608
	XCB_EVENT_MASK_OWNER_GRAB_BUTTON = 16777216
end enum

type xcb_backing_store_t as long
enum
	XCB_BACKING_STORE_NOT_USEFUL = 0
	XCB_BACKING_STORE_WHEN_MAPPED = 1
	XCB_BACKING_STORE_ALWAYS = 2
end enum

type xcb_screen_t
	root as xcb_window_t
	default_colormap as xcb_colormap_t
	white_pixel as ulong
	black_pixel as ulong
	current_input_masks as ulong
	width_in_pixels as ushort
	height_in_pixels as ushort
	width_in_millimeters as ushort
	height_in_millimeters as ushort
	min_installed_maps as ushort
	max_installed_maps as ushort
	root_visual as xcb_visualid_t
	backing_stores as ubyte
	save_unders as ubyte
	root_depth as ubyte
	allowed_depths_len as ubyte
end type

type xcb_screen_iterator_t
	data as xcb_screen_t ptr
	as long rem
	index as long
end type

type xcb_setup_request_t
	byte_order as ubyte
	pad0 as ubyte
	protocol_major_version as ushort
	protocol_minor_version as ushort
	authorization_protocol_name_len as ushort
	authorization_protocol_data_len as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_setup_request_iterator_t
	data as xcb_setup_request_t ptr
	as long rem
	index as long
end type

type xcb_setup_failed_t
	status as ubyte
	reason_len as ubyte
	protocol_major_version as ushort
	protocol_minor_version as ushort
	length as ushort
end type

type xcb_setup_failed_iterator_t
	data as xcb_setup_failed_t ptr
	as long rem
	index as long
end type

type xcb_setup_authenticate_t
	status as ubyte
	pad0(0 to 4) as ubyte
	length as ushort
end type

type xcb_setup_authenticate_iterator_t
	data as xcb_setup_authenticate_t ptr
	as long rem
	index as long
end type

type xcb_image_order_t as long
enum
	XCB_IMAGE_ORDER_LSB_FIRST = 0
	XCB_IMAGE_ORDER_MSB_FIRST = 1
end enum

type xcb_setup_t
	status as ubyte
	pad0 as ubyte
	protocol_major_version as ushort
	protocol_minor_version as ushort
	length as ushort
	release_number as ulong
	resource_id_base as ulong
	resource_id_mask as ulong
	motion_buffer_size as ulong
	vendor_len as ushort
	maximum_request_length as ushort
	roots_len as ubyte
	pixmap_formats_len as ubyte
	image_byte_order as ubyte
	bitmap_format_bit_order as ubyte
	bitmap_format_scanline_unit as ubyte
	bitmap_format_scanline_pad as ubyte
	min_keycode as xcb_keycode_t
	max_keycode as xcb_keycode_t
	pad1(0 to 3) as ubyte
end type

type xcb_setup_iterator_t
	data as xcb_setup_t ptr
	as long rem
	index as long
end type

type xcb_mod_mask_t as long
enum
	XCB_MOD_MASK_SHIFT = 1
	XCB_MOD_MASK_LOCK = 2
	XCB_MOD_MASK_CONTROL = 4
	XCB_MOD_MASK_1 = 8
	XCB_MOD_MASK_2 = 16
	XCB_MOD_MASK_3 = 32
	XCB_MOD_MASK_4 = 64
	XCB_MOD_MASK_5 = 128
	XCB_MOD_MASK_ANY = 32768
end enum

type xcb_key_but_mask_t as long
enum
	XCB_KEY_BUT_MASK_SHIFT = 1
	XCB_KEY_BUT_MASK_LOCK = 2
	XCB_KEY_BUT_MASK_CONTROL = 4
	XCB_KEY_BUT_MASK_MOD_1 = 8
	XCB_KEY_BUT_MASK_MOD_2 = 16
	XCB_KEY_BUT_MASK_MOD_3 = 32
	XCB_KEY_BUT_MASK_MOD_4 = 64
	XCB_KEY_BUT_MASK_MOD_5 = 128
	XCB_KEY_BUT_MASK_BUTTON_1 = 256
	XCB_KEY_BUT_MASK_BUTTON_2 = 512
	XCB_KEY_BUT_MASK_BUTTON_3 = 1024
	XCB_KEY_BUT_MASK_BUTTON_4 = 2048
	XCB_KEY_BUT_MASK_BUTTON_5 = 4096
end enum

type xcb_window_enum_t as long
enum
	XCB_WINDOW_NONE = 0
end enum

const XCB_KEY_PRESS = 2

type xcb_key_press_event_t
	response_type as ubyte
	detail as xcb_keycode_t
	sequence as ushort
	time as xcb_timestamp_t
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	root_x as short
	root_y as short
	event_x as short
	event_y as short
	state as ushort
	same_screen as ubyte
	pad0 as ubyte
end type

const XCB_KEY_RELEASE = 3
type xcb_key_release_event_t as xcb_key_press_event_t

type xcb_button_mask_t as long
enum
	XCB_BUTTON_MASK_1 = 256
	XCB_BUTTON_MASK_2 = 512
	XCB_BUTTON_MASK_3 = 1024
	XCB_BUTTON_MASK_4 = 2048
	XCB_BUTTON_MASK_5 = 4096
	XCB_BUTTON_MASK_ANY = 32768
end enum

const XCB_BUTTON_PRESS = 4

type xcb_button_press_event_t
	response_type as ubyte
	detail as xcb_button_t
	sequence as ushort
	time as xcb_timestamp_t
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	root_x as short
	root_y as short
	event_x as short
	event_y as short
	state as ushort
	same_screen as ubyte
	pad0 as ubyte
end type

const XCB_BUTTON_RELEASE = 5
type xcb_button_release_event_t as xcb_button_press_event_t

type xcb_motion_t as long
enum
	XCB_MOTION_NORMAL = 0
	XCB_MOTION_HINT = 1
end enum

const XCB_MOTION_NOTIFY = 6

type xcb_motion_notify_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	root_x as short
	root_y as short
	event_x as short
	event_y as short
	state as ushort
	same_screen as ubyte
	pad0 as ubyte
end type

type xcb_notify_detail_t as long
enum
	XCB_NOTIFY_DETAIL_ANCESTOR = 0
	XCB_NOTIFY_DETAIL_VIRTUAL = 1
	XCB_NOTIFY_DETAIL_INFERIOR = 2
	XCB_NOTIFY_DETAIL_NONLINEAR = 3
	XCB_NOTIFY_DETAIL_NONLINEAR_VIRTUAL = 4
	XCB_NOTIFY_DETAIL_POINTER = 5
	XCB_NOTIFY_DETAIL_POINTER_ROOT = 6
	XCB_NOTIFY_DETAIL_NONE = 7
end enum

type xcb_notify_mode_t as long
enum
	XCB_NOTIFY_MODE_NORMAL = 0
	XCB_NOTIFY_MODE_GRAB = 1
	XCB_NOTIFY_MODE_UNGRAB = 2
	XCB_NOTIFY_MODE_WHILE_GRABBED = 3
end enum

const XCB_ENTER_NOTIFY = 7

type xcb_enter_notify_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	root as xcb_window_t
	event as xcb_window_t
	child as xcb_window_t
	root_x as short
	root_y as short
	event_x as short
	event_y as short
	state as ushort
	mode as ubyte
	same_screen_focus as ubyte
end type

const XCB_LEAVE_NOTIFY = 8
type xcb_leave_notify_event_t as xcb_enter_notify_event_t
const XCB_FOCUS_IN = 9

type xcb_focus_in_event_t
	response_type as ubyte
	detail as ubyte
	sequence as ushort
	event as xcb_window_t
	mode as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_FOCUS_OUT = 10
type xcb_focus_out_event_t as xcb_focus_in_event_t
const XCB_KEYMAP_NOTIFY = 11

type xcb_keymap_notify_event_t
	response_type as ubyte
	keys(0 to 30) as ubyte
end type

const XCB_EXPOSE = 12

type xcb_expose_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	window as xcb_window_t
	x as ushort
	y as ushort
	width as ushort
	height as ushort
	count as ushort
	pad1(0 to 1) as ubyte
end type

const XCB_GRAPHICS_EXPOSURE = 13

type xcb_graphics_exposure_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	drawable as xcb_drawable_t
	x as ushort
	y as ushort
	width as ushort
	height as ushort
	minor_opcode as ushort
	count as ushort
	major_opcode as ubyte
	pad1(0 to 2) as ubyte
end type

const XCB_NO_EXPOSURE = 14

type xcb_no_exposure_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	drawable as xcb_drawable_t
	minor_opcode as ushort
	major_opcode as ubyte
	pad1 as ubyte
end type

type xcb_visibility_t as long
enum
	XCB_VISIBILITY_UNOBSCURED = 0
	XCB_VISIBILITY_PARTIALLY_OBSCURED = 1
	XCB_VISIBILITY_FULLY_OBSCURED = 2
end enum

const XCB_VISIBILITY_NOTIFY = 15

type xcb_visibility_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	window as xcb_window_t
	state as ubyte
	pad1(0 to 2) as ubyte
end type

const XCB_CREATE_NOTIFY = 16

type xcb_create_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	parent as xcb_window_t
	window as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
	border_width as ushort
	override_redirect as ubyte
	pad1 as ubyte
end type

const XCB_DESTROY_NOTIFY = 17

type xcb_destroy_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
end type

const XCB_UNMAP_NOTIFY = 18

type xcb_unmap_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
	from_configure as ubyte
	pad1(0 to 2) as ubyte
end type

const XCB_MAP_NOTIFY = 19

type xcb_map_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
	override_redirect as ubyte
	pad1(0 to 2) as ubyte
end type

const XCB_MAP_REQUEST = 20

type xcb_map_request_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	parent as xcb_window_t
	window as xcb_window_t
end type

const XCB_REPARENT_NOTIFY = 21

type xcb_reparent_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
	parent as xcb_window_t
	x as short
	y as short
	override_redirect as ubyte
	pad1(0 to 2) as ubyte
end type

const XCB_CONFIGURE_NOTIFY = 22

type xcb_configure_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
	above_sibling as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
	border_width as ushort
	override_redirect as ubyte
	pad1 as ubyte
end type

const XCB_CONFIGURE_REQUEST = 23

type xcb_configure_request_event_t
	response_type as ubyte
	stack_mode as ubyte
	sequence as ushort
	parent as xcb_window_t
	window as xcb_window_t
	sibling as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
	border_width as ushort
	value_mask as ushort
end type

const XCB_GRAVITY_NOTIFY = 24

type xcb_gravity_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
	x as short
	y as short
end type

const XCB_RESIZE_REQUEST = 25

type xcb_resize_request_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	window as xcb_window_t
	width as ushort
	height as ushort
end type

type xcb_place_t as long
enum
	XCB_PLACE_ON_TOP = 0
	XCB_PLACE_ON_BOTTOM = 1
end enum

const XCB_CIRCULATE_NOTIFY = 26

type xcb_circulate_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event as xcb_window_t
	window as xcb_window_t
	pad1(0 to 3) as ubyte
	place as ubyte
	pad2(0 to 2) as ubyte
end type

const XCB_CIRCULATE_REQUEST = 27
type xcb_circulate_request_event_t as xcb_circulate_notify_event_t

type xcb_property_t as long
enum
	XCB_PROPERTY_NEW_VALUE = 0
	XCB_PROPERTY_DELETE = 1
end enum

const XCB_PROPERTY_NOTIFY = 28

type xcb_property_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	window as xcb_window_t
	atom as xcb_atom_t
	time as xcb_timestamp_t
	state as ubyte
	pad1(0 to 2) as ubyte
end type

const XCB_SELECTION_CLEAR = 29

type xcb_selection_clear_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	owner as xcb_window_t
	selection as xcb_atom_t
end type

type xcb_time_t as long
enum
	XCB_TIME_CURRENT_TIME = 0
end enum

type xcb_atom_enum_t as long
enum
	XCB_ATOM_NONE = 0
	XCB_ATOM_ANY = 0
	XCB_ATOM_PRIMARY = 1
	XCB_ATOM_SECONDARY = 2
	XCB_ATOM_ARC = 3
	XCB_ATOM_ATOM = 4
	XCB_ATOM_BITMAP = 5
	XCB_ATOM_CARDINAL = 6
	XCB_ATOM_COLORMAP = 7
	XCB_ATOM_CURSOR = 8
	XCB_ATOM_CUT_BUFFER0 = 9
	XCB_ATOM_CUT_BUFFER1 = 10
	XCB_ATOM_CUT_BUFFER2 = 11
	XCB_ATOM_CUT_BUFFER3 = 12
	XCB_ATOM_CUT_BUFFER4 = 13
	XCB_ATOM_CUT_BUFFER5 = 14
	XCB_ATOM_CUT_BUFFER6 = 15
	XCB_ATOM_CUT_BUFFER7 = 16
	XCB_ATOM_DRAWABLE = 17
	XCB_ATOM_FONT = 18
	XCB_ATOM_INTEGER = 19
	XCB_ATOM_PIXMAP = 20
	XCB_ATOM_POINT = 21
	XCB_ATOM_RECTANGLE = 22
	XCB_ATOM_RESOURCE_MANAGER = 23
	XCB_ATOM_RGB_COLOR_MAP = 24
	XCB_ATOM_RGB_BEST_MAP = 25
	XCB_ATOM_RGB_BLUE_MAP = 26
	XCB_ATOM_RGB_DEFAULT_MAP = 27
	XCB_ATOM_RGB_GRAY_MAP = 28
	XCB_ATOM_RGB_GREEN_MAP = 29
	XCB_ATOM_RGB_RED_MAP = 30
	XCB_ATOM_STRING = 31
	XCB_ATOM_VISUALID = 32
	XCB_ATOM_WINDOW = 33
	XCB_ATOM_WM_COMMAND = 34
	XCB_ATOM_WM_HINTS = 35
	XCB_ATOM_WM_CLIENT_MACHINE = 36
	XCB_ATOM_WM_ICON_NAME = 37
	XCB_ATOM_WM_ICON_SIZE = 38
	XCB_ATOM_WM_NAME = 39
	XCB_ATOM_WM_NORMAL_HINTS = 40
	XCB_ATOM_WM_SIZE_HINTS = 41
	XCB_ATOM_WM_ZOOM_HINTS = 42
	XCB_ATOM_MIN_SPACE = 43
	XCB_ATOM_NORM_SPACE = 44
	XCB_ATOM_MAX_SPACE = 45
	XCB_ATOM_END_SPACE = 46
	XCB_ATOM_SUPERSCRIPT_X = 47
	XCB_ATOM_SUPERSCRIPT_Y = 48
	XCB_ATOM_SUBSCRIPT_X = 49
	XCB_ATOM_SUBSCRIPT_Y = 50
	XCB_ATOM_UNDERLINE_POSITION = 51
	XCB_ATOM_UNDERLINE_THICKNESS = 52
	XCB_ATOM_STRIKEOUT_ASCENT = 53
	XCB_ATOM_STRIKEOUT_DESCENT = 54
	XCB_ATOM_ITALIC_ANGLE = 55
	XCB_ATOM_X_HEIGHT = 56
	XCB_ATOM_QUAD_WIDTH = 57
	XCB_ATOM_WEIGHT = 58
	XCB_ATOM_POINT_SIZE = 59
	XCB_ATOM_RESOLUTION = 60
	XCB_ATOM_COPYRIGHT = 61
	XCB_ATOM_NOTICE = 62
	XCB_ATOM_FONT_NAME = 63
	XCB_ATOM_FAMILY_NAME = 64
	XCB_ATOM_FULL_NAME = 65
	XCB_ATOM_CAP_HEIGHT = 66
	XCB_ATOM_WM_CLASS = 67
	XCB_ATOM_WM_TRANSIENT_FOR = 68
end enum

const XCB_SELECTION_REQUEST = 30

type xcb_selection_request_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	owner as xcb_window_t
	requestor as xcb_window_t
	selection as xcb_atom_t
	target as xcb_atom_t
	property as xcb_atom_t
end type

const XCB_SELECTION_NOTIFY = 31

type xcb_selection_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	requestor as xcb_window_t
	selection as xcb_atom_t
	target as xcb_atom_t
	property as xcb_atom_t
end type

type xcb_colormap_state_t as long
enum
	XCB_COLORMAP_STATE_UNINSTALLED = 0
	XCB_COLORMAP_STATE_INSTALLED = 1
end enum

type xcb_colormap_enum_t as long
enum
	XCB_COLORMAP_NONE = 0
end enum

const XCB_COLORMAP_NOTIFY = 32

type xcb_colormap_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	window as xcb_window_t
	colormap as xcb_colormap_t
	_new as ubyte
	state as ubyte
	pad1(0 to 1) as ubyte
end type

union xcb_client_message_data_t
	data8(0 to 19) as ubyte
	data16(0 to 9) as ushort
	data32(0 to 4) as ulong
end union

type xcb_client_message_data_iterator_t
	data as xcb_client_message_data_t ptr
	as long rem
	index as long
end type

const XCB_CLIENT_MESSAGE = 33

type xcb_client_message_event_t
	response_type as ubyte
	format as ubyte
	sequence as ushort
	window as xcb_window_t
	as xcb_atom_t type
	data as xcb_client_message_data_t
end type

type xcb_mapping_t as long
enum
	XCB_MAPPING_MODIFIER = 0
	XCB_MAPPING_KEYBOARD = 1
	XCB_MAPPING_POINTER = 2
end enum

const XCB_MAPPING_NOTIFY = 34

type xcb_mapping_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	request as ubyte
	first_keycode as xcb_keycode_t
	count as ubyte
	pad1 as ubyte
end type

const XCB_GE_GENERIC = 35

type xcb_ge_generic_event_t
	response_type as ubyte
	extension as ubyte
	sequence as ushort
	length as ulong
	event_type as ushort
	pad0(0 to 21) as ubyte
	full_sequence as ulong
end type

const XCB_REQUEST = 1

type xcb_request_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	bad_value as ulong
	minor_opcode as ushort
	major_opcode as ubyte
	pad0 as ubyte
end type

const XCB_VALUE = 2

type xcb_value_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	bad_value as ulong
	minor_opcode as ushort
	major_opcode as ubyte
	pad0 as ubyte
end type

const XCB_WINDOW = 3
type xcb_window_error_t as xcb_value_error_t
const XCB_PIXMAP = 4
type xcb_pixmap_error_t as xcb_value_error_t
const XCB_ATOM = 5
type xcb_atom_error_t as xcb_value_error_t
const XCB_CURSOR = 6
type xcb_cursor_error_t as xcb_value_error_t
const XCB_FONT = 7
type xcb_font_error_t as xcb_value_error_t
const XCB_MATCH = 8
type xcb_match_error_t as xcb_request_error_t
const XCB_DRAWABLE = 9
type xcb_drawable_error_t as xcb_value_error_t
const XCB_ACCESS = 10
type xcb_access_error_t as xcb_request_error_t
const XCB_ALLOC = 11
type xcb_alloc_error_t as xcb_request_error_t
const XCB_COLORMAP = 12
type xcb_colormap_error_t as xcb_value_error_t
const XCB_G_CONTEXT = 13
type xcb_g_context_error_t as xcb_value_error_t
const XCB_ID_CHOICE = 14
type xcb_id_choice_error_t as xcb_value_error_t
const XCB_NAME = 15
type xcb_name_error_t as xcb_request_error_t
const XCB_LENGTH = 16
type xcb_length_error_t as xcb_request_error_t
const XCB_IMPLEMENTATION = 17
type xcb_implementation_error_t as xcb_request_error_t

type xcb_window_class_t as long
enum
	XCB_WINDOW_CLASS_COPY_FROM_PARENT = 0
	XCB_WINDOW_CLASS_INPUT_OUTPUT = 1
	XCB_WINDOW_CLASS_INPUT_ONLY = 2
end enum

type xcb_cw_t as long
enum
	XCB_CW_BACK_PIXMAP = 1
	XCB_CW_BACK_PIXEL = 2
	XCB_CW_BORDER_PIXMAP = 4
	XCB_CW_BORDER_PIXEL = 8
	XCB_CW_BIT_GRAVITY = 16
	XCB_CW_WIN_GRAVITY = 32
	XCB_CW_BACKING_STORE = 64
	XCB_CW_BACKING_PLANES = 128
	XCB_CW_BACKING_PIXEL = 256
	XCB_CW_OVERRIDE_REDIRECT = 512
	XCB_CW_SAVE_UNDER = 1024
	XCB_CW_EVENT_MASK = 2048
	XCB_CW_DONT_PROPAGATE = 4096
	XCB_CW_COLORMAP = 8192
	XCB_CW_CURSOR = 16384
end enum

type xcb_back_pixmap_t as long
enum
	XCB_BACK_PIXMAP_NONE = 0
	XCB_BACK_PIXMAP_PARENT_RELATIVE = 1
end enum

type xcb_gravity_t as long
enum
	XCB_GRAVITY_BIT_FORGET = 0
	XCB_GRAVITY_WIN_UNMAP = 0
	XCB_GRAVITY_NORTH_WEST = 1
	XCB_GRAVITY_NORTH = 2
	XCB_GRAVITY_NORTH_EAST = 3
	XCB_GRAVITY_WEST = 4
	XCB_GRAVITY_CENTER = 5
	XCB_GRAVITY_EAST = 6
	XCB_GRAVITY_SOUTH_WEST = 7
	XCB_GRAVITY_SOUTH = 8
	XCB_GRAVITY_SOUTH_EAST = 9
	XCB_GRAVITY_STATIC = 10
end enum

const XCB_CREATE_WINDOW_ = 1

type xcb_create_window_request_t
	major_opcode as ubyte
	depth as ubyte
	length as ushort
	wid as xcb_window_t
	parent as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
	border_width as ushort
	_class as ushort
	visual as xcb_visualid_t
	value_mask as ulong
end type

const XCB_CHANGE_WINDOW_ATTRIBUTES_ = 2

type xcb_change_window_attributes_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
	value_mask as ulong
end type

type xcb_map_state_t as long
enum
	XCB_MAP_STATE_UNMAPPED = 0
	XCB_MAP_STATE_UNVIEWABLE = 1
	XCB_MAP_STATE_VIEWABLE = 2
end enum

type xcb_get_window_attributes_cookie_t
	sequence as ulong
end type

const XCB_GET_WINDOW_ATTRIBUTES_ = 3

type xcb_get_window_attributes_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_get_window_attributes_reply_t
	response_type as ubyte
	backing_store as ubyte
	sequence as ushort
	length as ulong
	visual as xcb_visualid_t
	_class as ushort
	bit_gravity as ubyte
	win_gravity as ubyte
	backing_planes as ulong
	backing_pixel as ulong
	save_under as ubyte
	map_is_installed as ubyte
	map_state as ubyte
	override_redirect as ubyte
	colormap as xcb_colormap_t
	all_event_masks as ulong
	your_event_mask as ulong
	do_not_propagate_mask as ushort
	pad0(0 to 1) as ubyte
end type

const XCB_DESTROY_WINDOW_ = 4

type xcb_destroy_window_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_DESTROY_SUBWINDOWS_ = 5

type xcb_destroy_subwindows_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_set_mode_t as long
enum
	XCB_SET_MODE_INSERT = 0
	XCB_SET_MODE_DELETE = 1
end enum

const XCB_CHANGE_SAVE_SET_ = 6

type xcb_change_save_set_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_REPARENT_WINDOW_ = 7

type xcb_reparent_window_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
	parent as xcb_window_t
	x as short
	y as short
end type

const XCB_MAP_WINDOW_ = 8

type xcb_map_window_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_MAP_SUBWINDOWS_ = 9

type xcb_map_subwindows_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_UNMAP_WINDOW_ = 10

type xcb_unmap_window_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

const XCB_UNMAP_SUBWINDOWS_ = 11

type xcb_unmap_subwindows_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_config_window_t as long
enum
	XCB_CONFIG_WINDOW_X = 1
	XCB_CONFIG_WINDOW_Y = 2
	XCB_CONFIG_WINDOW_WIDTH = 4
	XCB_CONFIG_WINDOW_HEIGHT = 8
	XCB_CONFIG_WINDOW_BORDER_WIDTH = 16
	XCB_CONFIG_WINDOW_SIBLING = 32
	XCB_CONFIG_WINDOW_STACK_MODE = 64
end enum

type xcb_stack_mode_t as long
enum
	XCB_STACK_MODE_ABOVE = 0
	XCB_STACK_MODE_BELOW = 1
	XCB_STACK_MODE_TOP_IF = 2
	XCB_STACK_MODE_BOTTOM_IF = 3
	XCB_STACK_MODE_OPPOSITE = 4
end enum

const XCB_CONFIGURE_WINDOW_ = 12

type xcb_configure_window_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
	value_mask as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_circulate_t as long
enum
	XCB_CIRCULATE_RAISE_LOWEST = 0
	XCB_CIRCULATE_LOWER_HIGHEST = 1
end enum

const XCB_CIRCULATE_WINDOW_ = 13

type xcb_circulate_window_request_t
	major_opcode as ubyte
	direction as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_get_geometry_cookie_t
	sequence as ulong
end type

const XCB_GET_GEOMETRY_ = 14

type xcb_get_geometry_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

type xcb_get_geometry_reply_t
	response_type as ubyte
	depth as ubyte
	sequence as ushort
	length as ulong
	root as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
	border_width as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_query_tree_cookie_t
	sequence as ulong
end type

const XCB_QUERY_TREE_ = 15

type xcb_query_tree_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_query_tree_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	root as xcb_window_t
	parent as xcb_window_t
	children_len as ushort
	pad1(0 to 13) as ubyte
end type

type xcb_intern_atom_cookie_t
	sequence as ulong
end type

const XCB_INTERN_ATOM_ = 16

type xcb_intern_atom_request_t
	major_opcode as ubyte
	only_if_exists as ubyte
	length as ushort
	name_len as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_intern_atom_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	atom as xcb_atom_t
end type

type xcb_get_atom_name_cookie_t
	sequence as ulong
end type

const XCB_GET_ATOM_NAME_ = 17

type xcb_get_atom_name_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	atom as xcb_atom_t
end type

type xcb_get_atom_name_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	name_len as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_prop_mode_t as long
enum
	XCB_PROP_MODE_REPLACE = 0
	XCB_PROP_MODE_PREPEND = 1
	XCB_PROP_MODE_APPEND = 2
end enum

const XCB_CHANGE_PROPERTY_ = 18

type xcb_change_property_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
	window as xcb_window_t
	property as xcb_atom_t
	as xcb_atom_t type
	format as ubyte
	pad0(0 to 2) as ubyte
	data_len as ulong
end type

const XCB_DELETE_PROPERTY_ = 19

type xcb_delete_property_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
	property as xcb_atom_t
end type

type xcb_get_property_type_t as long
enum
	XCB_GET_PROPERTY_TYPE_ANY = 0
end enum

type xcb_get_property_cookie_t
	sequence as ulong
end type

const XCB_GET_PROPERTY_ = 20

type xcb_get_property_request_t
	major_opcode as ubyte
	_delete as ubyte
	length as ushort
	window as xcb_window_t
	property as xcb_atom_t
	as xcb_atom_t type
	long_offset as ulong
	long_length as ulong
end type

type xcb_get_property_reply_t
	response_type as ubyte
	format as ubyte
	sequence as ushort
	length as ulong
	as xcb_atom_t type
	bytes_after as ulong
	value_len as ulong
	pad0(0 to 11) as ubyte
end type

type xcb_list_properties_cookie_t
	sequence as ulong
end type

const XCB_LIST_PROPERTIES_ = 21

type xcb_list_properties_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_list_properties_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	atoms_len as ushort
	pad1(0 to 21) as ubyte
end type

const XCB_SET_SELECTION_OWNER_ = 22

type xcb_set_selection_owner_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	owner as xcb_window_t
	selection as xcb_atom_t
	time as xcb_timestamp_t
end type

type xcb_get_selection_owner_cookie_t
	sequence as ulong
end type

const XCB_GET_SELECTION_OWNER_ = 23

type xcb_get_selection_owner_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	selection as xcb_atom_t
end type

type xcb_get_selection_owner_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	owner as xcb_window_t
end type

const XCB_CONVERT_SELECTION_ = 24

type xcb_convert_selection_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	requestor as xcb_window_t
	selection as xcb_atom_t
	target as xcb_atom_t
	property as xcb_atom_t
	time as xcb_timestamp_t
end type

type xcb_send_event_dest_t as long
enum
	XCB_SEND_EVENT_DEST_POINTER_WINDOW = 0
	XCB_SEND_EVENT_DEST_ITEM_FOCUS = 1
end enum

const XCB_SEND_EVENT_ = 25

type xcb_send_event_request_t
	major_opcode as ubyte
	propagate as ubyte
	length as ushort
	destination as xcb_window_t
	event_mask as ulong
	event as zstring * 32
end type

type xcb_grab_mode_t as long
enum
	XCB_GRAB_MODE_SYNC = 0
	XCB_GRAB_MODE_ASYNC = 1
end enum

type xcb_grab_status_t as long
enum
	XCB_GRAB_STATUS_SUCCESS = 0
	XCB_GRAB_STATUS_ALREADY_GRABBED = 1
	XCB_GRAB_STATUS_INVALID_TIME = 2
	XCB_GRAB_STATUS_NOT_VIEWABLE = 3
	XCB_GRAB_STATUS_FROZEN = 4
end enum

type xcb_cursor_enum_t as long
enum
	XCB_CURSOR_NONE = 0
end enum

type xcb_grab_pointer_cookie_t
	sequence as ulong
end type

const XCB_GRAB_POINTER_ = 26

type xcb_grab_pointer_request_t
	major_opcode as ubyte
	owner_events as ubyte
	length as ushort
	grab_window as xcb_window_t
	event_mask as ushort
	pointer_mode as ubyte
	keyboard_mode as ubyte
	confine_to as xcb_window_t
	cursor as xcb_cursor_t
	time as xcb_timestamp_t
end type

type xcb_grab_pointer_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
end type

const XCB_UNGRAB_POINTER_ = 27

type xcb_ungrab_pointer_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	time as xcb_timestamp_t
end type

type xcb_button_index_t as long
enum
	XCB_BUTTON_INDEX_ANY = 0
	XCB_BUTTON_INDEX_1 = 1
	XCB_BUTTON_INDEX_2 = 2
	XCB_BUTTON_INDEX_3 = 3
	XCB_BUTTON_INDEX_4 = 4
	XCB_BUTTON_INDEX_5 = 5
end enum

const XCB_GRAB_BUTTON_ = 28

type xcb_grab_button_request_t
	major_opcode as ubyte
	owner_events as ubyte
	length as ushort
	grab_window as xcb_window_t
	event_mask as ushort
	pointer_mode as ubyte
	keyboard_mode as ubyte
	confine_to as xcb_window_t
	cursor as xcb_cursor_t
	button as ubyte
	pad0 as ubyte
	modifiers as ushort
end type

const XCB_UNGRAB_BUTTON_ = 29

type xcb_ungrab_button_request_t
	major_opcode as ubyte
	button as ubyte
	length as ushort
	grab_window as xcb_window_t
	modifiers as ushort
	pad0(0 to 1) as ubyte
end type

const XCB_CHANGE_ACTIVE_POINTER_GRAB_ = 30

type xcb_change_active_pointer_grab_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cursor as xcb_cursor_t
	time as xcb_timestamp_t
	event_mask as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_grab_keyboard_cookie_t
	sequence as ulong
end type

const XCB_GRAB_KEYBOARD_ = 31

type xcb_grab_keyboard_request_t
	major_opcode as ubyte
	owner_events as ubyte
	length as ushort
	grab_window as xcb_window_t
	time as xcb_timestamp_t
	pointer_mode as ubyte
	keyboard_mode as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_grab_keyboard_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
end type

const XCB_UNGRAB_KEYBOARD_ = 32

type xcb_ungrab_keyboard_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	time as xcb_timestamp_t
end type

type xcb_grab_t as long
enum
	XCB_GRAB_ANY = 0
end enum

const XCB_GRAB_KEY_ = 33

type xcb_grab_key_request_t
	major_opcode as ubyte
	owner_events as ubyte
	length as ushort
	grab_window as xcb_window_t
	modifiers as ushort
	key as xcb_keycode_t
	pointer_mode as ubyte
	keyboard_mode as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_UNGRAB_KEY_ = 34

type xcb_ungrab_key_request_t
	major_opcode as ubyte
	key as xcb_keycode_t
	length as ushort
	grab_window as xcb_window_t
	modifiers as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_allow_t as long
enum
	XCB_ALLOW_ASYNC_POINTER = 0
	XCB_ALLOW_SYNC_POINTER = 1
	XCB_ALLOW_REPLAY_POINTER = 2
	XCB_ALLOW_ASYNC_KEYBOARD = 3
	XCB_ALLOW_SYNC_KEYBOARD = 4
	XCB_ALLOW_REPLAY_KEYBOARD = 5
	XCB_ALLOW_ASYNC_BOTH = 6
	XCB_ALLOW_SYNC_BOTH = 7
end enum

const XCB_ALLOW_EVENTS_ = 35

type xcb_allow_events_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
	time as xcb_timestamp_t
end type

const XCB_GRAB_SERVER_ = 36

type xcb_grab_server_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

const XCB_UNGRAB_SERVER_ = 37

type xcb_ungrab_server_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_query_pointer_cookie_t
	sequence as ulong
end type

const XCB_QUERY_POINTER_ = 38

type xcb_query_pointer_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_query_pointer_reply_t
	response_type as ubyte
	same_screen as ubyte
	sequence as ushort
	length as ulong
	root as xcb_window_t
	child as xcb_window_t
	root_x as short
	root_y as short
	win_x as short
	win_y as short
	mask as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_timecoord_t
	time as xcb_timestamp_t
	x as short
	y as short
end type

type xcb_timecoord_iterator_t
	data as xcb_timecoord_t ptr
	as long rem
	index as long
end type

type xcb_get_motion_events_cookie_t
	sequence as ulong
end type

const XCB_GET_MOTION_EVENTS_ = 39

type xcb_get_motion_events_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
	start as xcb_timestamp_t
	stop as xcb_timestamp_t
end type

type xcb_get_motion_events_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	events_len as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_translate_coordinates_cookie_t
	sequence as ulong
end type

const XCB_TRANSLATE_COORDINATES_ = 40

type xcb_translate_coordinates_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	src_window as xcb_window_t
	dst_window as xcb_window_t
	src_x as short
	src_y as short
end type

type xcb_translate_coordinates_reply_t
	response_type as ubyte
	same_screen as ubyte
	sequence as ushort
	length as ulong
	child as xcb_window_t
	dst_x as short
	dst_y as short
end type

const XCB_WARP_POINTER_ = 41

type xcb_warp_pointer_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	src_window as xcb_window_t
	dst_window as xcb_window_t
	src_x as short
	src_y as short
	src_width as ushort
	src_height as ushort
	dst_x as short
	dst_y as short
end type

type xcb_input_focus_t as long
enum
	XCB_INPUT_FOCUS_NONE = 0
	XCB_INPUT_FOCUS_POINTER_ROOT = 1
	XCB_INPUT_FOCUS_PARENT = 2
	XCB_INPUT_FOCUS_FOLLOW_KEYBOARD = 3
end enum

const XCB_SET_INPUT_FOCUS_ = 42

type xcb_set_input_focus_request_t
	major_opcode as ubyte
	revert_to as ubyte
	length as ushort
	focus as xcb_window_t
	time as xcb_timestamp_t
end type

type xcb_get_input_focus_cookie_t
	sequence as ulong
end type

const XCB_GET_INPUT_FOCUS_ = 43

type xcb_get_input_focus_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_input_focus_reply_t
	response_type as ubyte
	revert_to as ubyte
	sequence as ushort
	length as ulong
	focus as xcb_window_t
end type

type xcb_query_keymap_cookie_t
	sequence as ulong
end type

const XCB_QUERY_KEYMAP_ = 44

type xcb_query_keymap_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_query_keymap_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	keys(0 to 31) as ubyte
end type

const XCB_OPEN_FONT_ = 45

type xcb_open_font_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	fid as xcb_font_t
	name_len as ushort
	pad1(0 to 1) as ubyte
end type

const XCB_CLOSE_FONT_ = 46

type xcb_close_font_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	font as xcb_font_t
end type

type xcb_font_draw_t as long
enum
	XCB_FONT_DRAW_LEFT_TO_RIGHT = 0
	XCB_FONT_DRAW_RIGHT_TO_LEFT = 1
end enum

type xcb_fontprop_t
	name as xcb_atom_t
	value as ulong
end type

type xcb_fontprop_iterator_t
	data as xcb_fontprop_t ptr
	as long rem
	index as long
end type

type xcb_charinfo_t
	left_side_bearing as short
	right_side_bearing as short
	character_width as short
	ascent as short
	descent as short
	attributes as ushort
end type

type xcb_charinfo_iterator_t
	data as xcb_charinfo_t ptr
	as long rem
	index as long
end type

type xcb_query_font_cookie_t
	sequence as ulong
end type

const XCB_QUERY_FONT_ = 47

type xcb_query_font_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	font as xcb_fontable_t
end type

type xcb_query_font_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	min_bounds as xcb_charinfo_t
	pad1(0 to 3) as ubyte
	max_bounds as xcb_charinfo_t
	pad2(0 to 3) as ubyte
	min_char_or_byte2 as ushort
	max_char_or_byte2 as ushort
	default_char as ushort
	properties_len as ushort
	draw_direction as ubyte
	min_byte1 as ubyte
	max_byte1 as ubyte
	all_chars_exist as ubyte
	font_ascent as short
	font_descent as short
	char_infos_len as ulong
end type

type xcb_query_text_extents_cookie_t
	sequence as ulong
end type

const XCB_QUERY_TEXT_EXTENTS_ = 48

type xcb_query_text_extents_request_t
	major_opcode as ubyte
	odd_length as ubyte
	length as ushort
	font as xcb_fontable_t
end type

type xcb_query_text_extents_reply_t
	response_type as ubyte
	draw_direction as ubyte
	sequence as ushort
	length as ulong
	font_ascent as short
	font_descent as short
	overall_ascent as short
	overall_descent as short
	overall_width as long
	overall_left as long
	overall_right as long
end type

type xcb_str_t
	name_len as ubyte
end type

type xcb_str_iterator_t
	data as xcb_str_t ptr
	as long rem
	index as long
end type

type xcb_list_fonts_cookie_t
	sequence as ulong
end type

const XCB_LIST_FONTS_ = 49

type xcb_list_fonts_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	max_names as ushort
	pattern_len as ushort
end type

type xcb_list_fonts_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	names_len as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_list_fonts_with_info_cookie_t
	sequence as ulong
end type

const XCB_LIST_FONTS_WITH_INFO_ = 50

type xcb_list_fonts_with_info_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	max_names as ushort
	pattern_len as ushort
end type

type xcb_list_fonts_with_info_reply_t
	response_type as ubyte
	name_len as ubyte
	sequence as ushort
	length as ulong
	min_bounds as xcb_charinfo_t
	pad0(0 to 3) as ubyte
	max_bounds as xcb_charinfo_t
	pad1(0 to 3) as ubyte
	min_char_or_byte2 as ushort
	max_char_or_byte2 as ushort
	default_char as ushort
	properties_len as ushort
	draw_direction as ubyte
	min_byte1 as ubyte
	max_byte1 as ubyte
	all_chars_exist as ubyte
	font_ascent as short
	font_descent as short
	replies_hint as ulong
end type

const XCB_SET_FONT_PATH_ = 51

type xcb_set_font_path_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	font_qty as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_get_font_path_cookie_t
	sequence as ulong
end type

const XCB_GET_FONT_PATH_ = 52

type xcb_get_font_path_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_font_path_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	path_len as ushort
	pad1(0 to 21) as ubyte
end type

const XCB_CREATE_PIXMAP_ = 53

type xcb_create_pixmap_request_t
	major_opcode as ubyte
	depth as ubyte
	length as ushort
	pid as xcb_pixmap_t
	drawable as xcb_drawable_t
	width as ushort
	height as ushort
end type

const XCB_FREE_PIXMAP_ = 54

type xcb_free_pixmap_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	pixmap as xcb_pixmap_t
end type

type xcb_gc_t as long
enum
	XCB_GC_FUNCTION = 1
	XCB_GC_PLANE_MASK = 2
	XCB_GC_FOREGROUND = 4
	XCB_GC_BACKGROUND = 8
	XCB_GC_LINE_WIDTH = 16
	XCB_GC_LINE_STYLE = 32
	XCB_GC_CAP_STYLE = 64
	XCB_GC_JOIN_STYLE = 128
	XCB_GC_FILL_STYLE = 256
	XCB_GC_FILL_RULE = 512
	XCB_GC_TILE = 1024
	XCB_GC_STIPPLE = 2048
	XCB_GC_TILE_STIPPLE_ORIGIN_X = 4096
	XCB_GC_TILE_STIPPLE_ORIGIN_Y = 8192
	XCB_GC_FONT = 16384
	XCB_GC_SUBWINDOW_MODE = 32768
	XCB_GC_GRAPHICS_EXPOSURES = 65536
	XCB_GC_CLIP_ORIGIN_X = 131072
	XCB_GC_CLIP_ORIGIN_Y = 262144
	XCB_GC_CLIP_MASK = 524288
	XCB_GC_DASH_OFFSET = 1048576
	XCB_GC_DASH_LIST = 2097152
	XCB_GC_ARC_MODE = 4194304
end enum

type xcb_gx_t as long
enum
	XCB_GX_CLEAR = 0
	XCB_GX_AND = 1
	XCB_GX_AND_REVERSE = 2
	XCB_GX_COPY = 3
	XCB_GX_AND_INVERTED = 4
	XCB_GX_NOOP = 5
	XCB_GX_XOR = 6
	XCB_GX_OR = 7
	XCB_GX_NOR = 8
	XCB_GX_EQUIV = 9
	XCB_GX_INVERT = 10
	XCB_GX_OR_REVERSE = 11
	XCB_GX_COPY_INVERTED = 12
	XCB_GX_OR_INVERTED = 13
	XCB_GX_NAND = 14
	XCB_GX_SET = 15
end enum

type xcb_line_style_t as long
enum
	XCB_LINE_STYLE_SOLID = 0
	XCB_LINE_STYLE_ON_OFF_DASH = 1
	XCB_LINE_STYLE_DOUBLE_DASH = 2
end enum

type xcb_cap_style_t as long
enum
	XCB_CAP_STYLE_NOT_LAST = 0
	XCB_CAP_STYLE_BUTT = 1
	XCB_CAP_STYLE_ROUND = 2
	XCB_CAP_STYLE_PROJECTING = 3
end enum

type xcb_join_style_t as long
enum
	XCB_JOIN_STYLE_MITER = 0
	XCB_JOIN_STYLE_ROUND = 1
	XCB_JOIN_STYLE_BEVEL = 2
end enum

type xcb_fill_style_t as long
enum
	XCB_FILL_STYLE_SOLID = 0
	XCB_FILL_STYLE_TILED = 1
	XCB_FILL_STYLE_STIPPLED = 2
	XCB_FILL_STYLE_OPAQUE_STIPPLED = 3
end enum

type xcb_fill_rule_t as long
enum
	XCB_FILL_RULE_EVEN_ODD = 0
	XCB_FILL_RULE_WINDING = 1
end enum

type xcb_subwindow_mode_t as long
enum
	XCB_SUBWINDOW_MODE_CLIP_BY_CHILDREN = 0
	XCB_SUBWINDOW_MODE_INCLUDE_INFERIORS = 1
end enum

type xcb_arc_mode_t as long
enum
	XCB_ARC_MODE_CHORD = 0
	XCB_ARC_MODE_PIE_SLICE = 1
end enum

const XCB_CREATE_GC_ = 55

type xcb_create_gc_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cid as xcb_gcontext_t
	drawable as xcb_drawable_t
	value_mask as ulong
end type

const XCB_CHANGE_GC_ = 56

type xcb_change_gc_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	gc as xcb_gcontext_t
	value_mask as ulong
end type

const XCB_COPY_GC_ = 57

type xcb_copy_gc_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	src_gc as xcb_gcontext_t
	dst_gc as xcb_gcontext_t
	value_mask as ulong
end type

const XCB_SET_DASHES_ = 58

type xcb_set_dashes_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	gc as xcb_gcontext_t
	dash_offset as ushort
	dashes_len as ushort
end type

type xcb_clip_ordering_t as long
enum
	XCB_CLIP_ORDERING_UNSORTED = 0
	XCB_CLIP_ORDERING_Y_SORTED = 1
	XCB_CLIP_ORDERING_YX_SORTED = 2
	XCB_CLIP_ORDERING_YX_BANDED = 3
end enum

const XCB_SET_CLIP_RECTANGLES_ = 59

type xcb_set_clip_rectangles_request_t
	major_opcode as ubyte
	ordering as ubyte
	length as ushort
	gc as xcb_gcontext_t
	clip_x_origin as short
	clip_y_origin as short
end type

const XCB_FREE_GC_ = 60

type xcb_free_gc_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	gc as xcb_gcontext_t
end type

const XCB_CLEAR_AREA_ = 61

type xcb_clear_area_request_t
	major_opcode as ubyte
	exposures as ubyte
	length as ushort
	window as xcb_window_t
	x as short
	y as short
	width as ushort
	height as ushort
end type

const XCB_COPY_AREA_ = 62

type xcb_copy_area_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	src_drawable as xcb_drawable_t
	dst_drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	src_x as short
	src_y as short
	dst_x as short
	dst_y as short
	width as ushort
	height as ushort
end type

const XCB_COPY_PLANE_ = 63

type xcb_copy_plane_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	src_drawable as xcb_drawable_t
	dst_drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	src_x as short
	src_y as short
	dst_x as short
	dst_y as short
	width as ushort
	height as ushort
	bit_plane as ulong
end type

type xcb_coord_mode_t as long
enum
	XCB_COORD_MODE_ORIGIN = 0
	XCB_COORD_MODE_PREVIOUS = 1
end enum

const XCB_POLY_POINT_ = 64

type xcb_poly_point_request_t
	major_opcode as ubyte
	coordinate_mode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

const XCB_POLY_LINE_ = 65

type xcb_poly_line_request_t
	major_opcode as ubyte
	coordinate_mode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

type xcb_segment_t
	x1 as short
	y1 as short
	x2 as short
	y2 as short
end type

type xcb_segment_iterator_t
	data as xcb_segment_t ptr
	as long rem
	index as long
end type

const XCB_POLY_SEGMENT_ = 66

type xcb_poly_segment_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

const XCB_POLY_RECTANGLE_ = 67

type xcb_poly_rectangle_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

const XCB_POLY_ARC_ = 68

type xcb_poly_arc_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

type xcb_poly_shape_t as long
enum
	XCB_POLY_SHAPE_COMPLEX = 0
	XCB_POLY_SHAPE_NONCONVEX = 1
	XCB_POLY_SHAPE_CONVEX = 2
end enum

const XCB_FILL_POLY_ = 69

type xcb_fill_poly_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	shape as ubyte
	coordinate_mode as ubyte
	pad1(0 to 1) as ubyte
end type

const XCB_POLY_FILL_RECTANGLE_ = 70

type xcb_poly_fill_rectangle_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

const XCB_POLY_FILL_ARC_ = 71

type xcb_poly_fill_arc_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
end type

type xcb_image_format_t as long
enum
	XCB_IMAGE_FORMAT_XY_BITMAP = 0
	XCB_IMAGE_FORMAT_XY_PIXMAP = 1
	XCB_IMAGE_FORMAT_Z_PIXMAP = 2
end enum

const XCB_PUT_IMAGE_ = 72

type xcb_put_image_request_t
	major_opcode as ubyte
	format as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	width as ushort
	height as ushort
	dst_x as short
	dst_y as short
	left_pad as ubyte
	depth as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_get_image_cookie_t
	sequence as ulong
end type

const XCB_GET_IMAGE_ = 73

type xcb_get_image_request_t
	major_opcode as ubyte
	format as ubyte
	length as ushort
	drawable as xcb_drawable_t
	x as short
	y as short
	width as ushort
	height as ushort
	plane_mask as ulong
end type

type xcb_get_image_reply_t
	response_type as ubyte
	depth as ubyte
	sequence as ushort
	length as ulong
	visual as xcb_visualid_t
	pad0(0 to 19) as ubyte
end type

const XCB_POLY_TEXT_8_ = 74

type xcb_poly_text_8_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	x as short
	y as short
end type

const XCB_POLY_TEXT_16_ = 75

type xcb_poly_text_16_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	x as short
	y as short
end type

const XCB_IMAGE_TEXT_8_ = 76

type xcb_image_text_8_request_t
	major_opcode as ubyte
	string_len as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	x as short
	y as short
end type

const XCB_IMAGE_TEXT_16_ = 77

type xcb_image_text_16_request_t
	major_opcode as ubyte
	string_len as ubyte
	length as ushort
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	x as short
	y as short
end type

type xcb_colormap_alloc_t as long
enum
	XCB_COLORMAP_ALLOC_NONE = 0
	XCB_COLORMAP_ALLOC_ALL = 1
end enum

const XCB_CREATE_COLORMAP_ = 78

type xcb_create_colormap_request_t
	major_opcode as ubyte
	alloc as ubyte
	length as ushort
	mid as xcb_colormap_t
	window as xcb_window_t
	visual as xcb_visualid_t
end type

const XCB_FREE_COLORMAP_ = 79

type xcb_free_colormap_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
end type

const XCB_COPY_COLORMAP_AND_FREE_ = 80

type xcb_copy_colormap_and_free_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	mid as xcb_colormap_t
	src_cmap as xcb_colormap_t
end type

const XCB_INSTALL_COLORMAP_ = 81

type xcb_install_colormap_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
end type

const XCB_UNINSTALL_COLORMAP_ = 82

type xcb_uninstall_colormap_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
end type

type xcb_list_installed_colormaps_cookie_t
	sequence as ulong
end type

const XCB_LIST_INSTALLED_COLORMAPS_ = 83

type xcb_list_installed_colormaps_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_list_installed_colormaps_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	cmaps_len as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_alloc_color_cookie_t
	sequence as ulong
end type

const XCB_ALLOC_COLOR_ = 84

type xcb_alloc_color_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
	red as ushort
	green as ushort
	blue as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_alloc_color_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	red as ushort
	green as ushort
	blue as ushort
	pad1(0 to 1) as ubyte
	pixel as ulong
end type

type xcb_alloc_named_color_cookie_t
	sequence as ulong
end type

const XCB_ALLOC_NAMED_COLOR_ = 85

type xcb_alloc_named_color_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
	name_len as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_alloc_named_color_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pixel as ulong
	exact_red as ushort
	exact_green as ushort
	exact_blue as ushort
	visual_red as ushort
	visual_green as ushort
	visual_blue as ushort
end type

type xcb_alloc_color_cells_cookie_t
	sequence as ulong
end type

const XCB_ALLOC_COLOR_CELLS_ = 86

type xcb_alloc_color_cells_request_t
	major_opcode as ubyte
	contiguous as ubyte
	length as ushort
	cmap as xcb_colormap_t
	colors as ushort
	planes as ushort
end type

type xcb_alloc_color_cells_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pixels_len as ushort
	masks_len as ushort
	pad1(0 to 19) as ubyte
end type

type xcb_alloc_color_planes_cookie_t
	sequence as ulong
end type

const XCB_ALLOC_COLOR_PLANES_ = 87

type xcb_alloc_color_planes_request_t
	major_opcode as ubyte
	contiguous as ubyte
	length as ushort
	cmap as xcb_colormap_t
	colors as ushort
	reds as ushort
	greens as ushort
	blues as ushort
end type

type xcb_alloc_color_planes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pixels_len as ushort
	pad1(0 to 1) as ubyte
	red_mask as ulong
	green_mask as ulong
	blue_mask as ulong
	pad2(0 to 7) as ubyte
end type

const XCB_FREE_COLORS_ = 88

type xcb_free_colors_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
	plane_mask as ulong
end type

type xcb_color_flag_t as long
enum
	XCB_COLOR_FLAG_RED = 1
	XCB_COLOR_FLAG_GREEN = 2
	XCB_COLOR_FLAG_BLUE = 4
end enum

type xcb_coloritem_t
	pixel as ulong
	red as ushort
	green as ushort
	blue as ushort
	flags as ubyte
	pad0 as ubyte
end type

type xcb_coloritem_iterator_t
	data as xcb_coloritem_t ptr
	as long rem
	index as long
end type

const XCB_STORE_COLORS_ = 89

type xcb_store_colors_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
end type

const XCB_STORE_NAMED_COLOR_ = 90

type xcb_store_named_color_request_t
	major_opcode as ubyte
	flags as ubyte
	length as ushort
	cmap as xcb_colormap_t
	pixel as ulong
	name_len as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_rgb_t
	red as ushort
	green as ushort
	blue as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_rgb_iterator_t
	data as xcb_rgb_t ptr
	as long rem
	index as long
end type

type xcb_query_colors_cookie_t
	sequence as ulong
end type

const XCB_QUERY_COLORS_ = 91

type xcb_query_colors_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
end type

type xcb_query_colors_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	colors_len as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_lookup_color_cookie_t
	sequence as ulong
end type

const XCB_LOOKUP_COLOR_ = 92

type xcb_lookup_color_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cmap as xcb_colormap_t
	name_len as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_lookup_color_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	exact_red as ushort
	exact_green as ushort
	exact_blue as ushort
	visual_red as ushort
	visual_green as ushort
	visual_blue as ushort
end type

type xcb_pixmap_enum_t as long
enum
	XCB_PIXMAP_NONE = 0
end enum

const XCB_CREATE_CURSOR_ = 93

type xcb_create_cursor_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cid as xcb_cursor_t
	source as xcb_pixmap_t
	mask as xcb_pixmap_t
	fore_red as ushort
	fore_green as ushort
	fore_blue as ushort
	back_red as ushort
	back_green as ushort
	back_blue as ushort
	x as ushort
	y as ushort
end type

type xcb_font_enum_t as long
enum
	XCB_FONT_NONE = 0
end enum

const XCB_CREATE_GLYPH_CURSOR_ = 94

type xcb_create_glyph_cursor_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cid as xcb_cursor_t
	source_font as xcb_font_t
	mask_font as xcb_font_t
	source_char as ushort
	mask_char as ushort
	fore_red as ushort
	fore_green as ushort
	fore_blue as ushort
	back_red as ushort
	back_green as ushort
	back_blue as ushort
end type

const XCB_FREE_CURSOR_ = 95

type xcb_free_cursor_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cursor as xcb_cursor_t
end type

const XCB_RECOLOR_CURSOR_ = 96

type xcb_recolor_cursor_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	cursor as xcb_cursor_t
	fore_red as ushort
	fore_green as ushort
	fore_blue as ushort
	back_red as ushort
	back_green as ushort
	back_blue as ushort
end type

type xcb_query_shape_of_t as long
enum
	XCB_QUERY_SHAPE_OF_LARGEST_CURSOR = 0
	XCB_QUERY_SHAPE_OF_FASTEST_TILE = 1
	XCB_QUERY_SHAPE_OF_FASTEST_STIPPLE = 2
end enum

type xcb_query_best_size_cookie_t
	sequence as ulong
end type

const XCB_QUERY_BEST_SIZE_ = 97

type xcb_query_best_size_request_t
	major_opcode as ubyte
	_class as ubyte
	length as ushort
	drawable as xcb_drawable_t
	width as ushort
	height as ushort
end type

type xcb_query_best_size_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width as ushort
	height as ushort
end type

type xcb_query_extension_cookie_t
	sequence as ulong
end type

const XCB_QUERY_EXTENSION_ = 98

type xcb_query_extension_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	name_len as ushort
	pad1(0 to 1) as ubyte
end type

type xcb_query_extension_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	present as ubyte
	major_opcode as ubyte
	first_event as ubyte
	first_error as ubyte
end type

type xcb_list_extensions_cookie_t
	sequence as ulong
end type

const XCB_LIST_EXTENSIONS_ = 99

type xcb_list_extensions_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_list_extensions_reply_t
	response_type as ubyte
	names_len as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

const XCB_CHANGE_KEYBOARD_MAPPING_ = 100

type xcb_change_keyboard_mapping_request_t
	major_opcode as ubyte
	keycode_count as ubyte
	length as ushort
	first_keycode as xcb_keycode_t
	keysyms_per_keycode as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_get_keyboard_mapping_cookie_t
	sequence as ulong
end type

const XCB_GET_KEYBOARD_MAPPING_ = 101

type xcb_get_keyboard_mapping_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	first_keycode as xcb_keycode_t
	count as ubyte
end type

type xcb_get_keyboard_mapping_reply_t
	response_type as ubyte
	keysyms_per_keycode as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

type xcb_kb_t as long
enum
	XCB_KB_KEY_CLICK_PERCENT = 1
	XCB_KB_BELL_PERCENT = 2
	XCB_KB_BELL_PITCH = 4
	XCB_KB_BELL_DURATION = 8
	XCB_KB_LED = 16
	XCB_KB_LED_MODE = 32
	XCB_KB_KEY = 64
	XCB_KB_AUTO_REPEAT_MODE = 128
end enum

type xcb_led_mode_t as long
enum
	XCB_LED_MODE_OFF = 0
	XCB_LED_MODE_ON = 1
end enum

type xcb_auto_repeat_mode_t as long
enum
	XCB_AUTO_REPEAT_MODE_OFF = 0
	XCB_AUTO_REPEAT_MODE_ON = 1
	XCB_AUTO_REPEAT_MODE_DEFAULT = 2
end enum

const XCB_CHANGE_KEYBOARD_CONTROL_ = 102

type xcb_change_keyboard_control_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	value_mask as ulong
end type

type xcb_get_keyboard_control_cookie_t
	sequence as ulong
end type

const XCB_GET_KEYBOARD_CONTROL_ = 103

type xcb_get_keyboard_control_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_keyboard_control_reply_t
	response_type as ubyte
	global_auto_repeat as ubyte
	sequence as ushort
	length as ulong
	led_mask as ulong
	key_click_percent as ubyte
	bell_percent as ubyte
	bell_pitch as ushort
	bell_duration as ushort
	pad0(0 to 1) as ubyte
	auto_repeats(0 to 31) as ubyte
end type

const XCB_BELL_ = 104

type xcb_bell_request_t
	major_opcode as ubyte
	percent as byte
	length as ushort
end type

const XCB_CHANGE_POINTER_CONTROL_ = 105

type xcb_change_pointer_control_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	acceleration_numerator as short
	acceleration_denominator as short
	threshold as short
	do_acceleration as ubyte
	do_threshold as ubyte
end type

type xcb_get_pointer_control_cookie_t
	sequence as ulong
end type

const XCB_GET_POINTER_CONTROL_ = 106

type xcb_get_pointer_control_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_pointer_control_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	acceleration_numerator as ushort
	acceleration_denominator as ushort
	threshold as ushort
	pad1(0 to 17) as ubyte
end type

type xcb_blanking_t as long
enum
	XCB_BLANKING_NOT_PREFERRED = 0
	XCB_BLANKING_PREFERRED = 1
	XCB_BLANKING_DEFAULT = 2
end enum

type xcb_exposures_t as long
enum
	XCB_EXPOSURES_NOT_ALLOWED = 0
	XCB_EXPOSURES_ALLOWED = 1
	XCB_EXPOSURES_DEFAULT = 2
end enum

const XCB_SET_SCREEN_SAVER_ = 107

type xcb_set_screen_saver_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	timeout as short
	interval as short
	prefer_blanking as ubyte
	allow_exposures as ubyte
end type

type xcb_get_screen_saver_cookie_t
	sequence as ulong
end type

const XCB_GET_SCREEN_SAVER_ = 108

type xcb_get_screen_saver_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_screen_saver_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	timeout as ushort
	interval as ushort
	prefer_blanking as ubyte
	allow_exposures as ubyte
	pad1(0 to 17) as ubyte
end type

type xcb_host_mode_t as long
enum
	XCB_HOST_MODE_INSERT = 0
	XCB_HOST_MODE_DELETE = 1
end enum

type xcb_family_t as long
enum
	XCB_FAMILY_INTERNET = 0
	XCB_FAMILY_DECNET = 1
	XCB_FAMILY_CHAOS = 2
	XCB_FAMILY_SERVER_INTERPRETED = 5
	XCB_FAMILY_INTERNET_6 = 6
end enum

const XCB_CHANGE_HOSTS_ = 109

type xcb_change_hosts_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
	family as ubyte
	pad0 as ubyte
	address_len as ushort
end type

type xcb_host_t
	family as ubyte
	pad0 as ubyte
	address_len as ushort
end type

type xcb_host_iterator_t
	data as xcb_host_t ptr
	as long rem
	index as long
end type

type xcb_list_hosts_cookie_t
	sequence as ulong
end type

const XCB_LIST_HOSTS_ = 110

type xcb_list_hosts_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_list_hosts_reply_t
	response_type as ubyte
	mode as ubyte
	sequence as ushort
	length as ulong
	hosts_len as ushort
	pad0(0 to 21) as ubyte
end type

type xcb_access_control_t as long
enum
	XCB_ACCESS_CONTROL_DISABLE = 0
	XCB_ACCESS_CONTROL_ENABLE = 1
end enum

const XCB_SET_ACCESS_CONTROL_ = 111

type xcb_set_access_control_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
end type

type xcb_close_down_t as long
enum
	XCB_CLOSE_DOWN_DESTROY_ALL = 0
	XCB_CLOSE_DOWN_RETAIN_PERMANENT = 1
	XCB_CLOSE_DOWN_RETAIN_TEMPORARY = 2
end enum

const XCB_SET_CLOSE_DOWN_MODE_ = 112

type xcb_set_close_down_mode_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
end type

type xcb_kill_t as long
enum
	XCB_KILL_ALL_TEMPORARY = 0
end enum

const XCB_KILL_CLIENT_ = 113

type xcb_kill_client_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	resource as ulong
end type

const XCB_ROTATE_PROPERTIES_ = 114

type xcb_rotate_properties_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
	window as xcb_window_t
	atoms_len as ushort
	delta as short
end type

type xcb_screen_saver_t as long
enum
	XCB_SCREEN_SAVER_RESET = 0
	XCB_SCREEN_SAVER_ACTIVE = 1
end enum

const XCB_FORCE_SCREEN_SAVER_ = 115

type xcb_force_screen_saver_request_t
	major_opcode as ubyte
	mode as ubyte
	length as ushort
end type

type xcb_mapping_status_t as long
enum
	XCB_MAPPING_STATUS_SUCCESS = 0
	XCB_MAPPING_STATUS_BUSY = 1
	XCB_MAPPING_STATUS_FAILURE = 2
end enum

type xcb_set_pointer_mapping_cookie_t
	sequence as ulong
end type

const XCB_SET_POINTER_MAPPING_ = 116

type xcb_set_pointer_mapping_request_t
	major_opcode as ubyte
	map_len as ubyte
	length as ushort
end type

type xcb_set_pointer_mapping_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
end type

type xcb_get_pointer_mapping_cookie_t
	sequence as ulong
end type

const XCB_GET_POINTER_MAPPING_ = 117

type xcb_get_pointer_mapping_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_pointer_mapping_reply_t
	response_type as ubyte
	map_len as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

type xcb_map_index_t as long
enum
	XCB_MAP_INDEX_SHIFT = 0
	XCB_MAP_INDEX_LOCK = 1
	XCB_MAP_INDEX_CONTROL = 2
	XCB_MAP_INDEX_1 = 3
	XCB_MAP_INDEX_2 = 4
	XCB_MAP_INDEX_3 = 5
	XCB_MAP_INDEX_4 = 6
	XCB_MAP_INDEX_5 = 7
end enum

type xcb_set_modifier_mapping_cookie_t
	sequence as ulong
end type

const XCB_SET_MODIFIER_MAPPING_ = 118

type xcb_set_modifier_mapping_request_t
	major_opcode as ubyte
	keycodes_per_modifier as ubyte
	length as ushort
end type

type xcb_set_modifier_mapping_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
end type

type xcb_get_modifier_mapping_cookie_t
	sequence as ulong
end type

const XCB_GET_MODIFIER_MAPPING_ = 119

type xcb_get_modifier_mapping_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

type xcb_get_modifier_mapping_reply_t
	response_type as ubyte
	keycodes_per_modifier as ubyte
	sequence as ushort
	length as ulong
	pad0(0 to 23) as ubyte
end type

const XCB_NO_OPERATION_ = 127

type xcb_no_operation_request_t
	major_opcode as ubyte
	pad0 as ubyte
	length as ushort
end type

declare sub xcb_char2b_next(byval i as xcb_char2b_iterator_t ptr)
declare function xcb_char2b_end(byval i as xcb_char2b_iterator_t) as xcb_generic_iterator_t
declare sub xcb_window_next(byval i as xcb_window_iterator_t ptr)
declare function xcb_window_end(byval i as xcb_window_iterator_t) as xcb_generic_iterator_t
declare sub xcb_pixmap_next(byval i as xcb_pixmap_iterator_t ptr)
declare function xcb_pixmap_end(byval i as xcb_pixmap_iterator_t) as xcb_generic_iterator_t
declare sub xcb_cursor_next(byval i as xcb_cursor_iterator_t ptr)
declare function xcb_cursor_end(byval i as xcb_cursor_iterator_t) as xcb_generic_iterator_t
declare sub xcb_font_next(byval i as xcb_font_iterator_t ptr)
declare function xcb_font_end(byval i as xcb_font_iterator_t) as xcb_generic_iterator_t
declare sub xcb_gcontext_next(byval i as xcb_gcontext_iterator_t ptr)
declare function xcb_gcontext_end(byval i as xcb_gcontext_iterator_t) as xcb_generic_iterator_t
declare sub xcb_colormap_next(byval i as xcb_colormap_iterator_t ptr)
declare function xcb_colormap_end(byval i as xcb_colormap_iterator_t) as xcb_generic_iterator_t
declare sub xcb_atom_next(byval i as xcb_atom_iterator_t ptr)
declare function xcb_atom_end(byval i as xcb_atom_iterator_t) as xcb_generic_iterator_t
declare sub xcb_drawable_next(byval i as xcb_drawable_iterator_t ptr)
declare function xcb_drawable_end(byval i as xcb_drawable_iterator_t) as xcb_generic_iterator_t
declare sub xcb_fontable_next(byval i as xcb_fontable_iterator_t ptr)
declare function xcb_fontable_end(byval i as xcb_fontable_iterator_t) as xcb_generic_iterator_t
declare sub xcb_visualid_next(byval i as xcb_visualid_iterator_t ptr)
declare function xcb_visualid_end(byval i as xcb_visualid_iterator_t) as xcb_generic_iterator_t
declare sub xcb_timestamp_next(byval i as xcb_timestamp_iterator_t ptr)
declare function xcb_timestamp_end(byval i as xcb_timestamp_iterator_t) as xcb_generic_iterator_t
declare sub xcb_keysym_next(byval i as xcb_keysym_iterator_t ptr)
declare function xcb_keysym_end(byval i as xcb_keysym_iterator_t) as xcb_generic_iterator_t
declare sub xcb_keycode_next(byval i as xcb_keycode_iterator_t ptr)
declare function xcb_keycode_end(byval i as xcb_keycode_iterator_t) as xcb_generic_iterator_t
declare sub xcb_button_next(byval i as xcb_button_iterator_t ptr)
declare function xcb_button_end(byval i as xcb_button_iterator_t) as xcb_generic_iterator_t
declare sub xcb_point_next(byval i as xcb_point_iterator_t ptr)
declare function xcb_point_end(byval i as xcb_point_iterator_t) as xcb_generic_iterator_t
declare sub xcb_rectangle_next(byval i as xcb_rectangle_iterator_t ptr)
declare function xcb_rectangle_end(byval i as xcb_rectangle_iterator_t) as xcb_generic_iterator_t
declare sub xcb_arc_next(byval i as xcb_arc_iterator_t ptr)
declare function xcb_arc_end(byval i as xcb_arc_iterator_t) as xcb_generic_iterator_t
declare sub xcb_format_next(byval i as xcb_format_iterator_t ptr)
declare function xcb_format_end(byval i as xcb_format_iterator_t) as xcb_generic_iterator_t
declare sub xcb_visualtype_next(byval i as xcb_visualtype_iterator_t ptr)
declare function xcb_visualtype_end(byval i as xcb_visualtype_iterator_t) as xcb_generic_iterator_t
declare function xcb_depth_sizeof(byval _buffer as const any ptr) as long
declare function xcb_depth_visuals(byval R as const xcb_depth_t ptr) as xcb_visualtype_t ptr
declare function xcb_depth_visuals_length(byval R as const xcb_depth_t ptr) as long
declare function xcb_depth_visuals_iterator(byval R as const xcb_depth_t ptr) as xcb_visualtype_iterator_t
declare sub xcb_depth_next(byval i as xcb_depth_iterator_t ptr)
declare function xcb_depth_end(byval i as xcb_depth_iterator_t) as xcb_generic_iterator_t
declare function xcb_screen_sizeof(byval _buffer as const any ptr) as long
declare function xcb_screen_allowed_depths_length(byval R as const xcb_screen_t ptr) as long
declare function xcb_screen_allowed_depths_iterator(byval R as const xcb_screen_t ptr) as xcb_depth_iterator_t
declare sub xcb_screen_next(byval i as xcb_screen_iterator_t ptr)
declare function xcb_screen_end(byval i as xcb_screen_iterator_t) as xcb_generic_iterator_t
declare function xcb_setup_request_sizeof(byval _buffer as const any ptr) as long
declare function xcb_setup_request_authorization_protocol_name(byval R as const xcb_setup_request_t ptr) as zstring ptr
declare function xcb_setup_request_authorization_protocol_name_length(byval R as const xcb_setup_request_t ptr) as long
declare function xcb_setup_request_authorization_protocol_name_end(byval R as const xcb_setup_request_t ptr) as xcb_generic_iterator_t
declare function xcb_setup_request_authorization_protocol_data(byval R as const xcb_setup_request_t ptr) as zstring ptr
declare function xcb_setup_request_authorization_protocol_data_length(byval R as const xcb_setup_request_t ptr) as long
declare function xcb_setup_request_authorization_protocol_data_end(byval R as const xcb_setup_request_t ptr) as xcb_generic_iterator_t
declare sub xcb_setup_request_next(byval i as xcb_setup_request_iterator_t ptr)
declare function xcb_setup_request_end(byval i as xcb_setup_request_iterator_t) as xcb_generic_iterator_t
declare function xcb_setup_failed_sizeof(byval _buffer as const any ptr) as long
declare function xcb_setup_failed_reason(byval R as const xcb_setup_failed_t ptr) as zstring ptr
declare function xcb_setup_failed_reason_length(byval R as const xcb_setup_failed_t ptr) as long
declare function xcb_setup_failed_reason_end(byval R as const xcb_setup_failed_t ptr) as xcb_generic_iterator_t
declare sub xcb_setup_failed_next(byval i as xcb_setup_failed_iterator_t ptr)
declare function xcb_setup_failed_end(byval i as xcb_setup_failed_iterator_t) as xcb_generic_iterator_t
declare function xcb_setup_authenticate_sizeof(byval _buffer as const any ptr) as long
declare function xcb_setup_authenticate_reason(byval R as const xcb_setup_authenticate_t ptr) as zstring ptr
declare function xcb_setup_authenticate_reason_length(byval R as const xcb_setup_authenticate_t ptr) as long
declare function xcb_setup_authenticate_reason_end(byval R as const xcb_setup_authenticate_t ptr) as xcb_generic_iterator_t
declare sub xcb_setup_authenticate_next(byval i as xcb_setup_authenticate_iterator_t ptr)
declare function xcb_setup_authenticate_end(byval i as xcb_setup_authenticate_iterator_t) as xcb_generic_iterator_t
declare function xcb_setup_sizeof(byval _buffer as const any ptr) as long
declare function xcb_setup_vendor(byval R as const xcb_setup_t ptr) as zstring ptr
declare function xcb_setup_vendor_length(byval R as const xcb_setup_t ptr) as long
declare function xcb_setup_vendor_end(byval R as const xcb_setup_t ptr) as xcb_generic_iterator_t
declare function xcb_setup_pixmap_formats(byval R as const xcb_setup_t ptr) as xcb_format_t ptr
declare function xcb_setup_pixmap_formats_length(byval R as const xcb_setup_t ptr) as long
declare function xcb_setup_pixmap_formats_iterator(byval R as const xcb_setup_t ptr) as xcb_format_iterator_t
declare function xcb_setup_roots_length(byval R as const xcb_setup_t ptr) as long
declare function xcb_setup_roots_iterator(byval R as const xcb_setup_t ptr) as xcb_screen_iterator_t
declare sub xcb_setup_next(byval i as xcb_setup_iterator_t ptr)
declare function xcb_setup_end(byval i as xcb_setup_iterator_t) as xcb_generic_iterator_t
declare sub xcb_client_message_data_next(byval i as xcb_client_message_data_iterator_t ptr)
declare function xcb_client_message_data_end(byval i as xcb_client_message_data_iterator_t) as xcb_generic_iterator_t
declare function xcb_create_window_sizeof(byval _buffer as const any ptr) as long
type xcb_connection_t as xcb_connection_t_
declare function xcb_create_window_checked(byval c as xcb_connection_t ptr, byval depth as ubyte, byval wid as xcb_window_t, byval parent as xcb_window_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval border_width as ushort, byval _class as ushort, byval visual as xcb_visualid_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_create_window(byval c as xcb_connection_t ptr, byval depth as ubyte, byval wid as xcb_window_t, byval parent as xcb_window_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval border_width as ushort, byval _class as ushort, byval visual as xcb_visualid_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_change_window_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_change_window_attributes_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_change_window_attributes(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_get_window_attributes(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_get_window_attributes_cookie_t
declare function xcb_get_window_attributes_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_get_window_attributes_cookie_t
declare function xcb_get_window_attributes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_window_attributes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_window_attributes_reply_t ptr
declare function xcb_destroy_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_destroy_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_destroy_subwindows_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_destroy_subwindows(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_change_save_set_checked(byval c as xcb_connection_t ptr, byval mode as ubyte, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_change_save_set(byval c as xcb_connection_t ptr, byval mode as ubyte, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_reparent_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval parent as xcb_window_t, byval x as short, byval y as short) as xcb_void_cookie_t
declare function xcb_reparent_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval parent as xcb_window_t, byval x as short, byval y as short) as xcb_void_cookie_t
declare function xcb_map_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_map_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_map_subwindows_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_map_subwindows(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_unmap_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_unmap_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_unmap_subwindows_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_unmap_subwindows(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_configure_window_sizeof(byval _buffer as const any ptr) as long
declare function xcb_configure_window_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval value_mask as ushort, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_configure_window(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval value_mask as ushort, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_circulate_window_checked(byval c as xcb_connection_t ptr, byval direction as ubyte, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_circulate_window(byval c as xcb_connection_t ptr, byval direction as ubyte, byval window as xcb_window_t) as xcb_void_cookie_t
declare function xcb_get_geometry(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_get_geometry_cookie_t
declare function xcb_get_geometry_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_get_geometry_cookie_t
declare function xcb_get_geometry_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_geometry_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_geometry_reply_t ptr
declare function xcb_query_tree_sizeof(byval _buffer as const any ptr) as long
declare function xcb_query_tree(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_query_tree_cookie_t
declare function xcb_query_tree_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_query_tree_cookie_t
declare function xcb_query_tree_children(byval R as const xcb_query_tree_reply_t ptr) as xcb_window_t ptr
declare function xcb_query_tree_children_length(byval R as const xcb_query_tree_reply_t ptr) as long
declare function xcb_query_tree_children_end(byval R as const xcb_query_tree_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_query_tree_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_tree_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_tree_reply_t ptr
declare function xcb_intern_atom_sizeof(byval _buffer as const any ptr) as long
declare function xcb_intern_atom(byval c as xcb_connection_t ptr, byval only_if_exists as ubyte, byval name_len as ushort, byval name as const zstring ptr) as xcb_intern_atom_cookie_t
declare function xcb_intern_atom_unchecked(byval c as xcb_connection_t ptr, byval only_if_exists as ubyte, byval name_len as ushort, byval name as const zstring ptr) as xcb_intern_atom_cookie_t
declare function xcb_intern_atom_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_intern_atom_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_intern_atom_reply_t ptr
declare function xcb_get_atom_name_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_atom_name(byval c as xcb_connection_t ptr, byval atom as xcb_atom_t) as xcb_get_atom_name_cookie_t
declare function xcb_get_atom_name_unchecked(byval c as xcb_connection_t ptr, byval atom as xcb_atom_t) as xcb_get_atom_name_cookie_t
declare function xcb_get_atom_name_name(byval R as const xcb_get_atom_name_reply_t ptr) as zstring ptr
declare function xcb_get_atom_name_name_length(byval R as const xcb_get_atom_name_reply_t ptr) as long
declare function xcb_get_atom_name_name_end(byval R as const xcb_get_atom_name_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_get_atom_name_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_atom_name_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_atom_name_reply_t ptr
declare function xcb_change_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_change_property_checked(byval c as xcb_connection_t ptr, byval mode as ubyte, byval window as xcb_window_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval format as ubyte, byval data_len as ulong, byval data as const any ptr) as xcb_void_cookie_t
declare function xcb_change_property(byval c as xcb_connection_t ptr, byval mode as ubyte, byval window as xcb_window_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval format as ubyte, byval data_len as ulong, byval data as const any ptr) as xcb_void_cookie_t
declare function xcb_delete_property_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_delete_property(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_get_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_property(byval c as xcb_connection_t ptr, byval _delete as ubyte, byval window as xcb_window_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval long_offset as ulong, byval long_length as ulong) as xcb_get_property_cookie_t
declare function xcb_get_property_unchecked(byval c as xcb_connection_t ptr, byval _delete as ubyte, byval window as xcb_window_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval long_offset as ulong, byval long_length as ulong) as xcb_get_property_cookie_t
declare function xcb_get_property_value(byval R as const xcb_get_property_reply_t ptr) as any ptr
declare function xcb_get_property_value_length(byval R as const xcb_get_property_reply_t ptr) as long
declare function xcb_get_property_value_end(byval R as const xcb_get_property_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_get_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_property_reply_t ptr
declare function xcb_list_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_list_properties(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_list_properties_cookie_t
declare function xcb_list_properties_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_list_properties_cookie_t
declare function xcb_list_properties_atoms(byval R as const xcb_list_properties_reply_t ptr) as xcb_atom_t ptr
declare function xcb_list_properties_atoms_length(byval R as const xcb_list_properties_reply_t ptr) as long
declare function xcb_list_properties_atoms_end(byval R as const xcb_list_properties_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_list_properties_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_list_properties_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_list_properties_reply_t ptr
declare function xcb_set_selection_owner_checked(byval c as xcb_connection_t ptr, byval owner as xcb_window_t, byval selection as xcb_atom_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_set_selection_owner(byval c as xcb_connection_t ptr, byval owner as xcb_window_t, byval selection as xcb_atom_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_get_selection_owner(byval c as xcb_connection_t ptr, byval selection as xcb_atom_t) as xcb_get_selection_owner_cookie_t
declare function xcb_get_selection_owner_unchecked(byval c as xcb_connection_t ptr, byval selection as xcb_atom_t) as xcb_get_selection_owner_cookie_t
declare function xcb_get_selection_owner_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_selection_owner_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_selection_owner_reply_t ptr
declare function xcb_convert_selection_checked(byval c as xcb_connection_t ptr, byval requestor as xcb_window_t, byval selection as xcb_atom_t, byval target as xcb_atom_t, byval property as xcb_atom_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_convert_selection(byval c as xcb_connection_t ptr, byval requestor as xcb_window_t, byval selection as xcb_atom_t, byval target as xcb_atom_t, byval property as xcb_atom_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_send_event_checked(byval c as xcb_connection_t ptr, byval propagate as ubyte, byval destination as xcb_window_t, byval event_mask as ulong, byval event as const zstring ptr) as xcb_void_cookie_t
declare function xcb_send_event(byval c as xcb_connection_t ptr, byval propagate as ubyte, byval destination as xcb_window_t, byval event_mask as ulong, byval event as const zstring ptr) as xcb_void_cookie_t
declare function xcb_grab_pointer(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval event_mask as ushort, byval pointer_mode as ubyte, byval keyboard_mode as ubyte, byval confine_to as xcb_window_t, byval cursor as xcb_cursor_t, byval time as xcb_timestamp_t) as xcb_grab_pointer_cookie_t
declare function xcb_grab_pointer_unchecked(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval event_mask as ushort, byval pointer_mode as ubyte, byval keyboard_mode as ubyte, byval confine_to as xcb_window_t, byval cursor as xcb_cursor_t, byval time as xcb_timestamp_t) as xcb_grab_pointer_cookie_t
declare function xcb_grab_pointer_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_grab_pointer_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_grab_pointer_reply_t ptr
declare function xcb_ungrab_pointer_checked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_ungrab_pointer(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_grab_button_checked(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval event_mask as ushort, byval pointer_mode as ubyte, byval keyboard_mode as ubyte, byval confine_to as xcb_window_t, byval cursor as xcb_cursor_t, byval button as ubyte, byval modifiers as ushort) as xcb_void_cookie_t
declare function xcb_grab_button(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval event_mask as ushort, byval pointer_mode as ubyte, byval keyboard_mode as ubyte, byval confine_to as xcb_window_t, byval cursor as xcb_cursor_t, byval button as ubyte, byval modifiers as ushort) as xcb_void_cookie_t
declare function xcb_ungrab_button_checked(byval c as xcb_connection_t ptr, byval button as ubyte, byval grab_window as xcb_window_t, byval modifiers as ushort) as xcb_void_cookie_t
declare function xcb_ungrab_button(byval c as xcb_connection_t ptr, byval button as ubyte, byval grab_window as xcb_window_t, byval modifiers as ushort) as xcb_void_cookie_t
declare function xcb_change_active_pointer_grab_checked(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t, byval time as xcb_timestamp_t, byval event_mask as ushort) as xcb_void_cookie_t
declare function xcb_change_active_pointer_grab(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t, byval time as xcb_timestamp_t, byval event_mask as ushort) as xcb_void_cookie_t
declare function xcb_grab_keyboard(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval time as xcb_timestamp_t, byval pointer_mode as ubyte, byval keyboard_mode as ubyte) as xcb_grab_keyboard_cookie_t
declare function xcb_grab_keyboard_unchecked(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval time as xcb_timestamp_t, byval pointer_mode as ubyte, byval keyboard_mode as ubyte) as xcb_grab_keyboard_cookie_t
declare function xcb_grab_keyboard_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_grab_keyboard_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_grab_keyboard_reply_t ptr
declare function xcb_ungrab_keyboard_checked(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_ungrab_keyboard(byval c as xcb_connection_t ptr, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_grab_key_checked(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval modifiers as ushort, byval key as xcb_keycode_t, byval pointer_mode as ubyte, byval keyboard_mode as ubyte) as xcb_void_cookie_t
declare function xcb_grab_key(byval c as xcb_connection_t ptr, byval owner_events as ubyte, byval grab_window as xcb_window_t, byval modifiers as ushort, byval key as xcb_keycode_t, byval pointer_mode as ubyte, byval keyboard_mode as ubyte) as xcb_void_cookie_t
declare function xcb_ungrab_key_checked(byval c as xcb_connection_t ptr, byval key as xcb_keycode_t, byval grab_window as xcb_window_t, byval modifiers as ushort) as xcb_void_cookie_t
declare function xcb_ungrab_key(byval c as xcb_connection_t ptr, byval key as xcb_keycode_t, byval grab_window as xcb_window_t, byval modifiers as ushort) as xcb_void_cookie_t
declare function xcb_allow_events_checked(byval c as xcb_connection_t ptr, byval mode as ubyte, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_allow_events(byval c as xcb_connection_t ptr, byval mode as ubyte, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_grab_server_checked(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_grab_server(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_ungrab_server_checked(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_ungrab_server(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_query_pointer(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_query_pointer_cookie_t
declare function xcb_query_pointer_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_query_pointer_cookie_t
declare function xcb_query_pointer_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_pointer_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_pointer_reply_t ptr
declare sub xcb_timecoord_next(byval i as xcb_timecoord_iterator_t ptr)
declare function xcb_timecoord_end(byval i as xcb_timecoord_iterator_t) as xcb_generic_iterator_t
declare function xcb_get_motion_events_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_motion_events(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval start as xcb_timestamp_t, byval stop as xcb_timestamp_t) as xcb_get_motion_events_cookie_t
declare function xcb_get_motion_events_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval start as xcb_timestamp_t, byval stop as xcb_timestamp_t) as xcb_get_motion_events_cookie_t
declare function xcb_get_motion_events_events(byval R as const xcb_get_motion_events_reply_t ptr) as xcb_timecoord_t ptr
declare function xcb_get_motion_events_events_length(byval R as const xcb_get_motion_events_reply_t ptr) as long
declare function xcb_get_motion_events_events_iterator(byval R as const xcb_get_motion_events_reply_t ptr) as xcb_timecoord_iterator_t
declare function xcb_get_motion_events_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_motion_events_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_motion_events_reply_t ptr
declare function xcb_translate_coordinates(byval c as xcb_connection_t ptr, byval src_window as xcb_window_t, byval dst_window as xcb_window_t, byval src_x as short, byval src_y as short) as xcb_translate_coordinates_cookie_t
declare function xcb_translate_coordinates_unchecked(byval c as xcb_connection_t ptr, byval src_window as xcb_window_t, byval dst_window as xcb_window_t, byval src_x as short, byval src_y as short) as xcb_translate_coordinates_cookie_t
declare function xcb_translate_coordinates_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_translate_coordinates_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_translate_coordinates_reply_t ptr
declare function xcb_warp_pointer_checked(byval c as xcb_connection_t ptr, byval src_window as xcb_window_t, byval dst_window as xcb_window_t, byval src_x as short, byval src_y as short, byval src_width as ushort, byval src_height as ushort, byval dst_x as short, byval dst_y as short) as xcb_void_cookie_t
declare function xcb_warp_pointer(byval c as xcb_connection_t ptr, byval src_window as xcb_window_t, byval dst_window as xcb_window_t, byval src_x as short, byval src_y as short, byval src_width as ushort, byval src_height as ushort, byval dst_x as short, byval dst_y as short) as xcb_void_cookie_t
declare function xcb_set_input_focus_checked(byval c as xcb_connection_t ptr, byval revert_to as ubyte, byval focus as xcb_window_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_set_input_focus(byval c as xcb_connection_t ptr, byval revert_to as ubyte, byval focus as xcb_window_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_get_input_focus(byval c as xcb_connection_t ptr) as xcb_get_input_focus_cookie_t
declare function xcb_get_input_focus_unchecked(byval c as xcb_connection_t ptr) as xcb_get_input_focus_cookie_t
declare function xcb_get_input_focus_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_input_focus_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_input_focus_reply_t ptr
declare function xcb_query_keymap(byval c as xcb_connection_t ptr) as xcb_query_keymap_cookie_t
declare function xcb_query_keymap_unchecked(byval c as xcb_connection_t ptr) as xcb_query_keymap_cookie_t
declare function xcb_query_keymap_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_keymap_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_keymap_reply_t ptr
declare function xcb_open_font_sizeof(byval _buffer as const any ptr) as long
declare function xcb_open_font_checked(byval c as xcb_connection_t ptr, byval fid as xcb_font_t, byval name_len as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_open_font(byval c as xcb_connection_t ptr, byval fid as xcb_font_t, byval name_len as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_close_font_checked(byval c as xcb_connection_t ptr, byval font as xcb_font_t) as xcb_void_cookie_t
declare function xcb_close_font(byval c as xcb_connection_t ptr, byval font as xcb_font_t) as xcb_void_cookie_t
declare sub xcb_fontprop_next(byval i as xcb_fontprop_iterator_t ptr)
declare function xcb_fontprop_end(byval i as xcb_fontprop_iterator_t) as xcb_generic_iterator_t
declare sub xcb_charinfo_next(byval i as xcb_charinfo_iterator_t ptr)
declare function xcb_charinfo_end(byval i as xcb_charinfo_iterator_t) as xcb_generic_iterator_t
declare function xcb_query_font_sizeof(byval _buffer as const any ptr) as long
declare function xcb_query_font(byval c as xcb_connection_t ptr, byval font as xcb_fontable_t) as xcb_query_font_cookie_t
declare function xcb_query_font_unchecked(byval c as xcb_connection_t ptr, byval font as xcb_fontable_t) as xcb_query_font_cookie_t
declare function xcb_query_font_properties(byval R as const xcb_query_font_reply_t ptr) as xcb_fontprop_t ptr
declare function xcb_query_font_properties_length(byval R as const xcb_query_font_reply_t ptr) as long
declare function xcb_query_font_properties_iterator(byval R as const xcb_query_font_reply_t ptr) as xcb_fontprop_iterator_t
declare function xcb_query_font_char_infos(byval R as const xcb_query_font_reply_t ptr) as xcb_charinfo_t ptr
declare function xcb_query_font_char_infos_length(byval R as const xcb_query_font_reply_t ptr) as long
declare function xcb_query_font_char_infos_iterator(byval R as const xcb_query_font_reply_t ptr) as xcb_charinfo_iterator_t
declare function xcb_query_font_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_font_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_font_reply_t ptr
declare function xcb_query_text_extents_sizeof(byval _buffer as const any ptr, byval string_len as ulong) as long
declare function xcb_query_text_extents(byval c as xcb_connection_t ptr, byval font as xcb_fontable_t, byval string_len as ulong, byval string as const xcb_char2b_t ptr) as xcb_query_text_extents_cookie_t
declare function xcb_query_text_extents_unchecked(byval c as xcb_connection_t ptr, byval font as xcb_fontable_t, byval string_len as ulong, byval string as const xcb_char2b_t ptr) as xcb_query_text_extents_cookie_t
declare function xcb_query_text_extents_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_text_extents_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_text_extents_reply_t ptr
declare function xcb_str_sizeof(byval _buffer as const any ptr) as long
declare function xcb_str_name(byval R as const xcb_str_t ptr) as zstring ptr
declare function xcb_str_name_length(byval R as const xcb_str_t ptr) as long
declare function xcb_str_name_end(byval R as const xcb_str_t ptr) as xcb_generic_iterator_t
declare sub xcb_str_next(byval i as xcb_str_iterator_t ptr)
declare function xcb_str_end(byval i as xcb_str_iterator_t) as xcb_generic_iterator_t
declare function xcb_list_fonts_sizeof(byval _buffer as const any ptr) as long
declare function xcb_list_fonts(byval c as xcb_connection_t ptr, byval max_names as ushort, byval pattern_len as ushort, byval pattern as const zstring ptr) as xcb_list_fonts_cookie_t
declare function xcb_list_fonts_unchecked(byval c as xcb_connection_t ptr, byval max_names as ushort, byval pattern_len as ushort, byval pattern as const zstring ptr) as xcb_list_fonts_cookie_t
declare function xcb_list_fonts_names_length(byval R as const xcb_list_fonts_reply_t ptr) as long
declare function xcb_list_fonts_names_iterator(byval R as const xcb_list_fonts_reply_t ptr) as xcb_str_iterator_t
declare function xcb_list_fonts_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_list_fonts_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_list_fonts_reply_t ptr
declare function xcb_list_fonts_with_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_list_fonts_with_info(byval c as xcb_connection_t ptr, byval max_names as ushort, byval pattern_len as ushort, byval pattern as const zstring ptr) as xcb_list_fonts_with_info_cookie_t
declare function xcb_list_fonts_with_info_unchecked(byval c as xcb_connection_t ptr, byval max_names as ushort, byval pattern_len as ushort, byval pattern as const zstring ptr) as xcb_list_fonts_with_info_cookie_t
declare function xcb_list_fonts_with_info_properties(byval R as const xcb_list_fonts_with_info_reply_t ptr) as xcb_fontprop_t ptr
declare function xcb_list_fonts_with_info_properties_length(byval R as const xcb_list_fonts_with_info_reply_t ptr) as long
declare function xcb_list_fonts_with_info_properties_iterator(byval R as const xcb_list_fonts_with_info_reply_t ptr) as xcb_fontprop_iterator_t
declare function xcb_list_fonts_with_info_name(byval R as const xcb_list_fonts_with_info_reply_t ptr) as zstring ptr
declare function xcb_list_fonts_with_info_name_length(byval R as const xcb_list_fonts_with_info_reply_t ptr) as long
declare function xcb_list_fonts_with_info_name_end(byval R as const xcb_list_fonts_with_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_list_fonts_with_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_list_fonts_with_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_list_fonts_with_info_reply_t ptr
declare function xcb_set_font_path_sizeof(byval _buffer as const any ptr) as long
declare function xcb_set_font_path_checked(byval c as xcb_connection_t ptr, byval font_qty as ushort, byval font as const xcb_str_t ptr) as xcb_void_cookie_t
declare function xcb_set_font_path(byval c as xcb_connection_t ptr, byval font_qty as ushort, byval font as const xcb_str_t ptr) as xcb_void_cookie_t
declare function xcb_get_font_path_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_font_path(byval c as xcb_connection_t ptr) as xcb_get_font_path_cookie_t
declare function xcb_get_font_path_unchecked(byval c as xcb_connection_t ptr) as xcb_get_font_path_cookie_t
declare function xcb_get_font_path_path_length(byval R as const xcb_get_font_path_reply_t ptr) as long
declare function xcb_get_font_path_path_iterator(byval R as const xcb_get_font_path_reply_t ptr) as xcb_str_iterator_t
declare function xcb_get_font_path_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_font_path_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_font_path_reply_t ptr
declare function xcb_create_pixmap_checked(byval c as xcb_connection_t ptr, byval depth as ubyte, byval pid as xcb_pixmap_t, byval drawable as xcb_drawable_t, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_create_pixmap(byval c as xcb_connection_t ptr, byval depth as ubyte, byval pid as xcb_pixmap_t, byval drawable as xcb_drawable_t, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_free_pixmap_checked(byval c as xcb_connection_t ptr, byval pixmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_free_pixmap(byval c as xcb_connection_t ptr, byval pixmap as xcb_pixmap_t) as xcb_void_cookie_t
declare function xcb_create_gc_sizeof(byval _buffer as const any ptr) as long
declare function xcb_create_gc_checked(byval c as xcb_connection_t ptr, byval cid as xcb_gcontext_t, byval drawable as xcb_drawable_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_create_gc(byval c as xcb_connection_t ptr, byval cid as xcb_gcontext_t, byval drawable as xcb_drawable_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_change_gc_sizeof(byval _buffer as const any ptr) as long
declare function xcb_change_gc_checked(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_change_gc(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_copy_gc_checked(byval c as xcb_connection_t ptr, byval src_gc as xcb_gcontext_t, byval dst_gc as xcb_gcontext_t, byval value_mask as ulong) as xcb_void_cookie_t
declare function xcb_copy_gc(byval c as xcb_connection_t ptr, byval src_gc as xcb_gcontext_t, byval dst_gc as xcb_gcontext_t, byval value_mask as ulong) as xcb_void_cookie_t
declare function xcb_set_dashes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_set_dashes_checked(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t, byval dash_offset as ushort, byval dashes_len as ushort, byval dashes as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_set_dashes(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t, byval dash_offset as ushort, byval dashes_len as ushort, byval dashes as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_set_clip_rectangles_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_set_clip_rectangles_checked(byval c as xcb_connection_t ptr, byval ordering as ubyte, byval gc as xcb_gcontext_t, byval clip_x_origin as short, byval clip_y_origin as short, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_set_clip_rectangles(byval c as xcb_connection_t ptr, byval ordering as ubyte, byval gc as xcb_gcontext_t, byval clip_x_origin as short, byval clip_y_origin as short, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_free_gc_checked(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t) as xcb_void_cookie_t
declare function xcb_free_gc(byval c as xcb_connection_t ptr, byval gc as xcb_gcontext_t) as xcb_void_cookie_t
declare function xcb_clear_area_checked(byval c as xcb_connection_t ptr, byval exposures as ubyte, byval window as xcb_window_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_clear_area(byval c as xcb_connection_t ptr, byval exposures as ubyte, byval window as xcb_window_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_copy_area_checked(byval c as xcb_connection_t ptr, byval src_drawable as xcb_drawable_t, byval dst_drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval src_x as short, byval src_y as short, byval dst_x as short, byval dst_y as short, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_copy_area(byval c as xcb_connection_t ptr, byval src_drawable as xcb_drawable_t, byval dst_drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval src_x as short, byval src_y as short, byval dst_x as short, byval dst_y as short, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_copy_plane_checked(byval c as xcb_connection_t ptr, byval src_drawable as xcb_drawable_t, byval dst_drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval src_x as short, byval src_y as short, byval dst_x as short, byval dst_y as short, byval width as ushort, byval height as ushort, byval bit_plane as ulong) as xcb_void_cookie_t
declare function xcb_copy_plane(byval c as xcb_connection_t ptr, byval src_drawable as xcb_drawable_t, byval dst_drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval src_x as short, byval src_y as short, byval dst_x as short, byval dst_y as short, byval width as ushort, byval height as ushort, byval bit_plane as ulong) as xcb_void_cookie_t
declare function xcb_poly_point_sizeof(byval _buffer as const any ptr, byval points_len as ulong) as long
declare function xcb_poly_point_checked(byval c as xcb_connection_t ptr, byval coordinate_mode as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval points_len as ulong, byval points as const xcb_point_t ptr) as xcb_void_cookie_t
declare function xcb_poly_point(byval c as xcb_connection_t ptr, byval coordinate_mode as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval points_len as ulong, byval points as const xcb_point_t ptr) as xcb_void_cookie_t
declare function xcb_poly_line_sizeof(byval _buffer as const any ptr, byval points_len as ulong) as long
declare function xcb_poly_line_checked(byval c as xcb_connection_t ptr, byval coordinate_mode as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval points_len as ulong, byval points as const xcb_point_t ptr) as xcb_void_cookie_t
declare function xcb_poly_line(byval c as xcb_connection_t ptr, byval coordinate_mode as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval points_len as ulong, byval points as const xcb_point_t ptr) as xcb_void_cookie_t
declare sub xcb_segment_next(byval i as xcb_segment_iterator_t ptr)
declare function xcb_segment_end(byval i as xcb_segment_iterator_t) as xcb_generic_iterator_t
declare function xcb_poly_segment_sizeof(byval _buffer as const any ptr, byval segments_len as ulong) as long
declare function xcb_poly_segment_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval segments_len as ulong, byval segments as const xcb_segment_t ptr) as xcb_void_cookie_t
declare function xcb_poly_segment(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval segments_len as ulong, byval segments as const xcb_segment_t ptr) as xcb_void_cookie_t
declare function xcb_poly_rectangle_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_poly_rectangle_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_poly_rectangle(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_poly_arc_sizeof(byval _buffer as const any ptr, byval arcs_len as ulong) as long
declare function xcb_poly_arc_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval arcs_len as ulong, byval arcs as const xcb_arc_t ptr) as xcb_void_cookie_t
declare function xcb_poly_arc(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval arcs_len as ulong, byval arcs as const xcb_arc_t ptr) as xcb_void_cookie_t
declare function xcb_fill_poly_sizeof(byval _buffer as const any ptr, byval points_len as ulong) as long
declare function xcb_fill_poly_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval shape as ubyte, byval coordinate_mode as ubyte, byval points_len as ulong, byval points as const xcb_point_t ptr) as xcb_void_cookie_t
declare function xcb_fill_poly(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval shape as ubyte, byval coordinate_mode as ubyte, byval points_len as ulong, byval points as const xcb_point_t ptr) as xcb_void_cookie_t
declare function xcb_poly_fill_rectangle_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_poly_fill_rectangle_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_poly_fill_rectangle(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_poly_fill_arc_sizeof(byval _buffer as const any ptr, byval arcs_len as ulong) as long
declare function xcb_poly_fill_arc_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval arcs_len as ulong, byval arcs as const xcb_arc_t ptr) as xcb_void_cookie_t
declare function xcb_poly_fill_arc(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval arcs_len as ulong, byval arcs as const xcb_arc_t ptr) as xcb_void_cookie_t
declare function xcb_put_image_sizeof(byval _buffer as const any ptr, byval data_len as ulong) as long
declare function xcb_put_image_checked(byval c as xcb_connection_t ptr, byval format as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval width as ushort, byval height as ushort, byval dst_x as short, byval dst_y as short, byval left_pad as ubyte, byval depth as ubyte, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_put_image(byval c as xcb_connection_t ptr, byval format as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval width as ushort, byval height as ushort, byval dst_x as short, byval dst_y as short, byval left_pad as ubyte, byval depth as ubyte, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_get_image_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_image(byval c as xcb_connection_t ptr, byval format as ubyte, byval drawable as xcb_drawable_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval plane_mask as ulong) as xcb_get_image_cookie_t
declare function xcb_get_image_unchecked(byval c as xcb_connection_t ptr, byval format as ubyte, byval drawable as xcb_drawable_t, byval x as short, byval y as short, byval width as ushort, byval height as ushort, byval plane_mask as ulong) as xcb_get_image_cookie_t
declare function xcb_get_image_data(byval R as const xcb_get_image_reply_t ptr) as ubyte ptr
declare function xcb_get_image_data_length(byval R as const xcb_get_image_reply_t ptr) as long
declare function xcb_get_image_data_end(byval R as const xcb_get_image_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_get_image_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_image_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_image_reply_t ptr
declare function xcb_poly_text_8_sizeof(byval _buffer as const any ptr, byval items_len as ulong) as long
declare function xcb_poly_text_8_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval items_len as ulong, byval items as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_poly_text_8(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval items_len as ulong, byval items as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_poly_text_16_sizeof(byval _buffer as const any ptr, byval items_len as ulong) as long
declare function xcb_poly_text_16_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval items_len as ulong, byval items as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_poly_text_16(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval items_len as ulong, byval items as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_image_text_8_sizeof(byval _buffer as const any ptr) as long
declare function xcb_image_text_8_checked(byval c as xcb_connection_t ptr, byval string_len as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_image_text_8(byval c as xcb_connection_t ptr, byval string_len as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_image_text_16_sizeof(byval _buffer as const any ptr) as long
declare function xcb_image_text_16_checked(byval c as xcb_connection_t ptr, byval string_len as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval string as const xcb_char2b_t ptr) as xcb_void_cookie_t
declare function xcb_image_text_16(byval c as xcb_connection_t ptr, byval string_len as ubyte, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval x as short, byval y as short, byval string as const xcb_char2b_t ptr) as xcb_void_cookie_t
declare function xcb_create_colormap_checked(byval c as xcb_connection_t ptr, byval alloc as ubyte, byval mid as xcb_colormap_t, byval window as xcb_window_t, byval visual as xcb_visualid_t) as xcb_void_cookie_t
declare function xcb_create_colormap(byval c as xcb_connection_t ptr, byval alloc as ubyte, byval mid as xcb_colormap_t, byval window as xcb_window_t, byval visual as xcb_visualid_t) as xcb_void_cookie_t
declare function xcb_free_colormap_checked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_free_colormap(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_copy_colormap_and_free_checked(byval c as xcb_connection_t ptr, byval mid as xcb_colormap_t, byval src_cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_copy_colormap_and_free(byval c as xcb_connection_t ptr, byval mid as xcb_colormap_t, byval src_cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_install_colormap_checked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_install_colormap(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_uninstall_colormap_checked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_uninstall_colormap(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t) as xcb_void_cookie_t
declare function xcb_list_installed_colormaps_sizeof(byval _buffer as const any ptr) as long
declare function xcb_list_installed_colormaps(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_list_installed_colormaps_cookie_t
declare function xcb_list_installed_colormaps_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_list_installed_colormaps_cookie_t
declare function xcb_list_installed_colormaps_cmaps(byval R as const xcb_list_installed_colormaps_reply_t ptr) as xcb_colormap_t ptr
declare function xcb_list_installed_colormaps_cmaps_length(byval R as const xcb_list_installed_colormaps_reply_t ptr) as long
declare function xcb_list_installed_colormaps_cmaps_end(byval R as const xcb_list_installed_colormaps_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_list_installed_colormaps_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_list_installed_colormaps_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_list_installed_colormaps_reply_t ptr
declare function xcb_alloc_color(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval red as ushort, byval green as ushort, byval blue as ushort) as xcb_alloc_color_cookie_t
declare function xcb_alloc_color_unchecked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval red as ushort, byval green as ushort, byval blue as ushort) as xcb_alloc_color_cookie_t
declare function xcb_alloc_color_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_alloc_color_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_alloc_color_reply_t ptr
declare function xcb_alloc_named_color_sizeof(byval _buffer as const any ptr) as long
declare function xcb_alloc_named_color(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval name_len as ushort, byval name as const zstring ptr) as xcb_alloc_named_color_cookie_t
declare function xcb_alloc_named_color_unchecked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval name_len as ushort, byval name as const zstring ptr) as xcb_alloc_named_color_cookie_t
declare function xcb_alloc_named_color_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_alloc_named_color_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_alloc_named_color_reply_t ptr
declare function xcb_alloc_color_cells_sizeof(byval _buffer as const any ptr) as long
declare function xcb_alloc_color_cells(byval c as xcb_connection_t ptr, byval contiguous as ubyte, byval cmap as xcb_colormap_t, byval colors as ushort, byval planes as ushort) as xcb_alloc_color_cells_cookie_t
declare function xcb_alloc_color_cells_unchecked(byval c as xcb_connection_t ptr, byval contiguous as ubyte, byval cmap as xcb_colormap_t, byval colors as ushort, byval planes as ushort) as xcb_alloc_color_cells_cookie_t
declare function xcb_alloc_color_cells_pixels(byval R as const xcb_alloc_color_cells_reply_t ptr) as ulong ptr
declare function xcb_alloc_color_cells_pixels_length(byval R as const xcb_alloc_color_cells_reply_t ptr) as long
declare function xcb_alloc_color_cells_pixels_end(byval R as const xcb_alloc_color_cells_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_alloc_color_cells_masks(byval R as const xcb_alloc_color_cells_reply_t ptr) as ulong ptr
declare function xcb_alloc_color_cells_masks_length(byval R as const xcb_alloc_color_cells_reply_t ptr) as long
declare function xcb_alloc_color_cells_masks_end(byval R as const xcb_alloc_color_cells_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_alloc_color_cells_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_alloc_color_cells_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_alloc_color_cells_reply_t ptr
declare function xcb_alloc_color_planes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_alloc_color_planes(byval c as xcb_connection_t ptr, byval contiguous as ubyte, byval cmap as xcb_colormap_t, byval colors as ushort, byval reds as ushort, byval greens as ushort, byval blues as ushort) as xcb_alloc_color_planes_cookie_t
declare function xcb_alloc_color_planes_unchecked(byval c as xcb_connection_t ptr, byval contiguous as ubyte, byval cmap as xcb_colormap_t, byval colors as ushort, byval reds as ushort, byval greens as ushort, byval blues as ushort) as xcb_alloc_color_planes_cookie_t
declare function xcb_alloc_color_planes_pixels(byval R as const xcb_alloc_color_planes_reply_t ptr) as ulong ptr
declare function xcb_alloc_color_planes_pixels_length(byval R as const xcb_alloc_color_planes_reply_t ptr) as long
declare function xcb_alloc_color_planes_pixels_end(byval R as const xcb_alloc_color_planes_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_alloc_color_planes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_alloc_color_planes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_alloc_color_planes_reply_t ptr
declare function xcb_free_colors_sizeof(byval _buffer as const any ptr, byval pixels_len as ulong) as long
declare function xcb_free_colors_checked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval plane_mask as ulong, byval pixels_len as ulong, byval pixels as const ulong ptr) as xcb_void_cookie_t
declare function xcb_free_colors(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval plane_mask as ulong, byval pixels_len as ulong, byval pixels as const ulong ptr) as xcb_void_cookie_t
declare sub xcb_coloritem_next(byval i as xcb_coloritem_iterator_t ptr)
declare function xcb_coloritem_end(byval i as xcb_coloritem_iterator_t) as xcb_generic_iterator_t
declare function xcb_store_colors_sizeof(byval _buffer as const any ptr, byval items_len as ulong) as long
declare function xcb_store_colors_checked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval items_len as ulong, byval items as const xcb_coloritem_t ptr) as xcb_void_cookie_t
declare function xcb_store_colors(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval items_len as ulong, byval items as const xcb_coloritem_t ptr) as xcb_void_cookie_t
declare function xcb_store_named_color_sizeof(byval _buffer as const any ptr) as long
declare function xcb_store_named_color_checked(byval c as xcb_connection_t ptr, byval flags as ubyte, byval cmap as xcb_colormap_t, byval pixel as ulong, byval name_len as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare function xcb_store_named_color(byval c as xcb_connection_t ptr, byval flags as ubyte, byval cmap as xcb_colormap_t, byval pixel as ulong, byval name_len as ushort, byval name as const zstring ptr) as xcb_void_cookie_t
declare sub xcb_rgb_next(byval i as xcb_rgb_iterator_t ptr)
declare function xcb_rgb_end(byval i as xcb_rgb_iterator_t) as xcb_generic_iterator_t
declare function xcb_query_colors_sizeof(byval _buffer as const any ptr, byval pixels_len as ulong) as long
declare function xcb_query_colors(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval pixels_len as ulong, byval pixels as const ulong ptr) as xcb_query_colors_cookie_t
declare function xcb_query_colors_unchecked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval pixels_len as ulong, byval pixels as const ulong ptr) as xcb_query_colors_cookie_t
declare function xcb_query_colors_colors(byval R as const xcb_query_colors_reply_t ptr) as xcb_rgb_t ptr
declare function xcb_query_colors_colors_length(byval R as const xcb_query_colors_reply_t ptr) as long
declare function xcb_query_colors_colors_iterator(byval R as const xcb_query_colors_reply_t ptr) as xcb_rgb_iterator_t
declare function xcb_query_colors_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_colors_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_colors_reply_t ptr
declare function xcb_lookup_color_sizeof(byval _buffer as const any ptr) as long
declare function xcb_lookup_color(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval name_len as ushort, byval name as const zstring ptr) as xcb_lookup_color_cookie_t
declare function xcb_lookup_color_unchecked(byval c as xcb_connection_t ptr, byval cmap as xcb_colormap_t, byval name_len as ushort, byval name as const zstring ptr) as xcb_lookup_color_cookie_t
declare function xcb_lookup_color_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_lookup_color_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_lookup_color_reply_t ptr
declare function xcb_create_cursor_checked(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval source as xcb_pixmap_t, byval mask as xcb_pixmap_t, byval fore_red as ushort, byval fore_green as ushort, byval fore_blue as ushort, byval back_red as ushort, byval back_green as ushort, byval back_blue as ushort, byval x as ushort, byval y as ushort) as xcb_void_cookie_t
declare function xcb_create_cursor(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval source as xcb_pixmap_t, byval mask as xcb_pixmap_t, byval fore_red as ushort, byval fore_green as ushort, byval fore_blue as ushort, byval back_red as ushort, byval back_green as ushort, byval back_blue as ushort, byval x as ushort, byval y as ushort) as xcb_void_cookie_t
declare function xcb_create_glyph_cursor_checked(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval source_font as xcb_font_t, byval mask_font as xcb_font_t, byval source_char as ushort, byval mask_char as ushort, byval fore_red as ushort, byval fore_green as ushort, byval fore_blue as ushort, byval back_red as ushort, byval back_green as ushort, byval back_blue as ushort) as xcb_void_cookie_t
declare function xcb_create_glyph_cursor(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval source_font as xcb_font_t, byval mask_font as xcb_font_t, byval source_char as ushort, byval mask_char as ushort, byval fore_red as ushort, byval fore_green as ushort, byval fore_blue as ushort, byval back_red as ushort, byval back_green as ushort, byval back_blue as ushort) as xcb_void_cookie_t
declare function xcb_free_cursor_checked(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t) as xcb_void_cookie_t
declare function xcb_free_cursor(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t) as xcb_void_cookie_t
declare function xcb_recolor_cursor_checked(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t, byval fore_red as ushort, byval fore_green as ushort, byval fore_blue as ushort, byval back_red as ushort, byval back_green as ushort, byval back_blue as ushort) as xcb_void_cookie_t
declare function xcb_recolor_cursor(byval c as xcb_connection_t ptr, byval cursor as xcb_cursor_t, byval fore_red as ushort, byval fore_green as ushort, byval fore_blue as ushort, byval back_red as ushort, byval back_green as ushort, byval back_blue as ushort) as xcb_void_cookie_t
declare function xcb_query_best_size(byval c as xcb_connection_t ptr, byval _class as ubyte, byval drawable as xcb_drawable_t, byval width as ushort, byval height as ushort) as xcb_query_best_size_cookie_t
declare function xcb_query_best_size_unchecked(byval c as xcb_connection_t ptr, byval _class as ubyte, byval drawable as xcb_drawable_t, byval width as ushort, byval height as ushort) as xcb_query_best_size_cookie_t
declare function xcb_query_best_size_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_best_size_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_best_size_reply_t ptr
declare function xcb_query_extension_sizeof(byval _buffer as const any ptr) as long
declare function xcb_query_extension(byval c as xcb_connection_t ptr, byval name_len as ushort, byval name as const zstring ptr) as xcb_query_extension_cookie_t
declare function xcb_query_extension_unchecked(byval c as xcb_connection_t ptr, byval name_len as ushort, byval name as const zstring ptr) as xcb_query_extension_cookie_t
declare function xcb_query_extension_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_query_extension_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_query_extension_reply_t ptr
declare function xcb_list_extensions_sizeof(byval _buffer as const any ptr) as long
declare function xcb_list_extensions(byval c as xcb_connection_t ptr) as xcb_list_extensions_cookie_t
declare function xcb_list_extensions_unchecked(byval c as xcb_connection_t ptr) as xcb_list_extensions_cookie_t
declare function xcb_list_extensions_names_length(byval R as const xcb_list_extensions_reply_t ptr) as long
declare function xcb_list_extensions_names_iterator(byval R as const xcb_list_extensions_reply_t ptr) as xcb_str_iterator_t
declare function xcb_list_extensions_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_list_extensions_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_list_extensions_reply_t ptr
declare function xcb_change_keyboard_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_change_keyboard_mapping_checked(byval c as xcb_connection_t ptr, byval keycode_count as ubyte, byval first_keycode as xcb_keycode_t, byval keysyms_per_keycode as ubyte, byval keysyms as const xcb_keysym_t ptr) as xcb_void_cookie_t
declare function xcb_change_keyboard_mapping(byval c as xcb_connection_t ptr, byval keycode_count as ubyte, byval first_keycode as xcb_keycode_t, byval keysyms_per_keycode as ubyte, byval keysyms as const xcb_keysym_t ptr) as xcb_void_cookie_t
declare function xcb_get_keyboard_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_keyboard_mapping(byval c as xcb_connection_t ptr, byval first_keycode as xcb_keycode_t, byval count as ubyte) as xcb_get_keyboard_mapping_cookie_t
declare function xcb_get_keyboard_mapping_unchecked(byval c as xcb_connection_t ptr, byval first_keycode as xcb_keycode_t, byval count as ubyte) as xcb_get_keyboard_mapping_cookie_t
declare function xcb_get_keyboard_mapping_keysyms(byval R as const xcb_get_keyboard_mapping_reply_t ptr) as xcb_keysym_t ptr
declare function xcb_get_keyboard_mapping_keysyms_length(byval R as const xcb_get_keyboard_mapping_reply_t ptr) as long
declare function xcb_get_keyboard_mapping_keysyms_end(byval R as const xcb_get_keyboard_mapping_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_get_keyboard_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_keyboard_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_keyboard_mapping_reply_t ptr
declare function xcb_change_keyboard_control_sizeof(byval _buffer as const any ptr) as long
declare function xcb_change_keyboard_control_checked(byval c as xcb_connection_t ptr, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_change_keyboard_control(byval c as xcb_connection_t ptr, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_get_keyboard_control(byval c as xcb_connection_t ptr) as xcb_get_keyboard_control_cookie_t
declare function xcb_get_keyboard_control_unchecked(byval c as xcb_connection_t ptr) as xcb_get_keyboard_control_cookie_t
declare function xcb_get_keyboard_control_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_keyboard_control_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_keyboard_control_reply_t ptr
declare function xcb_bell_checked(byval c as xcb_connection_t ptr, byval percent as byte) as xcb_void_cookie_t
declare function xcb_bell(byval c as xcb_connection_t ptr, byval percent as byte) as xcb_void_cookie_t
declare function xcb_change_pointer_control_checked(byval c as xcb_connection_t ptr, byval acceleration_numerator as short, byval acceleration_denominator as short, byval threshold as short, byval do_acceleration as ubyte, byval do_threshold as ubyte) as xcb_void_cookie_t
declare function xcb_change_pointer_control(byval c as xcb_connection_t ptr, byval acceleration_numerator as short, byval acceleration_denominator as short, byval threshold as short, byval do_acceleration as ubyte, byval do_threshold as ubyte) as xcb_void_cookie_t
declare function xcb_get_pointer_control(byval c as xcb_connection_t ptr) as xcb_get_pointer_control_cookie_t
declare function xcb_get_pointer_control_unchecked(byval c as xcb_connection_t ptr) as xcb_get_pointer_control_cookie_t
declare function xcb_get_pointer_control_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_pointer_control_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_pointer_control_reply_t ptr
declare function xcb_set_screen_saver_checked(byval c as xcb_connection_t ptr, byval timeout as short, byval interval as short, byval prefer_blanking as ubyte, byval allow_exposures as ubyte) as xcb_void_cookie_t
declare function xcb_set_screen_saver(byval c as xcb_connection_t ptr, byval timeout as short, byval interval as short, byval prefer_blanking as ubyte, byval allow_exposures as ubyte) as xcb_void_cookie_t
declare function xcb_get_screen_saver(byval c as xcb_connection_t ptr) as xcb_get_screen_saver_cookie_t
declare function xcb_get_screen_saver_unchecked(byval c as xcb_connection_t ptr) as xcb_get_screen_saver_cookie_t
declare function xcb_get_screen_saver_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_screen_saver_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_screen_saver_reply_t ptr
declare function xcb_change_hosts_sizeof(byval _buffer as const any ptr) as long
declare function xcb_change_hosts_checked(byval c as xcb_connection_t ptr, byval mode as ubyte, byval family as ubyte, byval address_len as ushort, byval address as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_change_hosts(byval c as xcb_connection_t ptr, byval mode as ubyte, byval family as ubyte, byval address_len as ushort, byval address as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_host_sizeof(byval _buffer as const any ptr) as long
declare function xcb_host_address(byval R as const xcb_host_t ptr) as ubyte ptr
declare function xcb_host_address_length(byval R as const xcb_host_t ptr) as long
declare function xcb_host_address_end(byval R as const xcb_host_t ptr) as xcb_generic_iterator_t
declare sub xcb_host_next(byval i as xcb_host_iterator_t ptr)
declare function xcb_host_end(byval i as xcb_host_iterator_t) as xcb_generic_iterator_t
declare function xcb_list_hosts_sizeof(byval _buffer as const any ptr) as long
declare function xcb_list_hosts(byval c as xcb_connection_t ptr) as xcb_list_hosts_cookie_t
declare function xcb_list_hosts_unchecked(byval c as xcb_connection_t ptr) as xcb_list_hosts_cookie_t
declare function xcb_list_hosts_hosts_length(byval R as const xcb_list_hosts_reply_t ptr) as long
declare function xcb_list_hosts_hosts_iterator(byval R as const xcb_list_hosts_reply_t ptr) as xcb_host_iterator_t
declare function xcb_list_hosts_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_list_hosts_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_list_hosts_reply_t ptr
declare function xcb_set_access_control_checked(byval c as xcb_connection_t ptr, byval mode as ubyte) as xcb_void_cookie_t
declare function xcb_set_access_control(byval c as xcb_connection_t ptr, byval mode as ubyte) as xcb_void_cookie_t
declare function xcb_set_close_down_mode_checked(byval c as xcb_connection_t ptr, byval mode as ubyte) as xcb_void_cookie_t
declare function xcb_set_close_down_mode(byval c as xcb_connection_t ptr, byval mode as ubyte) as xcb_void_cookie_t
declare function xcb_kill_client_checked(byval c as xcb_connection_t ptr, byval resource as ulong) as xcb_void_cookie_t
declare function xcb_kill_client(byval c as xcb_connection_t ptr, byval resource as ulong) as xcb_void_cookie_t
declare function xcb_rotate_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_rotate_properties_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval atoms_len as ushort, byval delta as short, byval atoms as const xcb_atom_t ptr) as xcb_void_cookie_t
declare function xcb_rotate_properties(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval atoms_len as ushort, byval delta as short, byval atoms as const xcb_atom_t ptr) as xcb_void_cookie_t
declare function xcb_force_screen_saver_checked(byval c as xcb_connection_t ptr, byval mode as ubyte) as xcb_void_cookie_t
declare function xcb_force_screen_saver(byval c as xcb_connection_t ptr, byval mode as ubyte) as xcb_void_cookie_t
declare function xcb_set_pointer_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_set_pointer_mapping(byval c as xcb_connection_t ptr, byval map_len as ubyte, byval map as const ubyte ptr) as xcb_set_pointer_mapping_cookie_t
declare function xcb_set_pointer_mapping_unchecked(byval c as xcb_connection_t ptr, byval map_len as ubyte, byval map as const ubyte ptr) as xcb_set_pointer_mapping_cookie_t
declare function xcb_set_pointer_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_set_pointer_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_set_pointer_mapping_reply_t ptr
declare function xcb_get_pointer_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_pointer_mapping(byval c as xcb_connection_t ptr) as xcb_get_pointer_mapping_cookie_t
declare function xcb_get_pointer_mapping_unchecked(byval c as xcb_connection_t ptr) as xcb_get_pointer_mapping_cookie_t
declare function xcb_get_pointer_mapping_map(byval R as const xcb_get_pointer_mapping_reply_t ptr) as ubyte ptr
declare function xcb_get_pointer_mapping_map_length(byval R as const xcb_get_pointer_mapping_reply_t ptr) as long
declare function xcb_get_pointer_mapping_map_end(byval R as const xcb_get_pointer_mapping_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_get_pointer_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_pointer_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_pointer_mapping_reply_t ptr
declare function xcb_set_modifier_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_set_modifier_mapping(byval c as xcb_connection_t ptr, byval keycodes_per_modifier as ubyte, byval keycodes as const xcb_keycode_t ptr) as xcb_set_modifier_mapping_cookie_t
declare function xcb_set_modifier_mapping_unchecked(byval c as xcb_connection_t ptr, byval keycodes_per_modifier as ubyte, byval keycodes as const xcb_keycode_t ptr) as xcb_set_modifier_mapping_cookie_t
declare function xcb_set_modifier_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_set_modifier_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_set_modifier_mapping_reply_t ptr
declare function xcb_get_modifier_mapping_sizeof(byval _buffer as const any ptr) as long
declare function xcb_get_modifier_mapping(byval c as xcb_connection_t ptr) as xcb_get_modifier_mapping_cookie_t
declare function xcb_get_modifier_mapping_unchecked(byval c as xcb_connection_t ptr) as xcb_get_modifier_mapping_cookie_t
declare function xcb_get_modifier_mapping_keycodes(byval R as const xcb_get_modifier_mapping_reply_t ptr) as xcb_keycode_t ptr
declare function xcb_get_modifier_mapping_keycodes_length(byval R as const xcb_get_modifier_mapping_reply_t ptr) as long
declare function xcb_get_modifier_mapping_keycodes_end(byval R as const xcb_get_modifier_mapping_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_get_modifier_mapping_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_get_modifier_mapping_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_get_modifier_mapping_reply_t ptr
declare function xcb_no_operation_checked(byval c as xcb_connection_t ptr) as xcb_void_cookie_t
declare function xcb_no_operation(byval c as xcb_connection_t ptr) as xcb_void_cookie_t

end extern
