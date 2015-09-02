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
#include once "xproto.bi"
#include once "shm.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_XV_QUERY_EXTENSION => XCB_XV_QUERY_EXTENSION_
''     constant XCB_XV_QUERY_ADAPTORS => XCB_XV_QUERY_ADAPTORS_
''     constant XCB_XV_QUERY_ENCODINGS => XCB_XV_QUERY_ENCODINGS_
''     constant XCB_XV_GRAB_PORT => XCB_XV_GRAB_PORT_
''     constant XCB_XV_UNGRAB_PORT => XCB_XV_UNGRAB_PORT_
''     constant XCB_XV_PUT_VIDEO => XCB_XV_PUT_VIDEO_
''     constant XCB_XV_PUT_STILL => XCB_XV_PUT_STILL_
''     constant XCB_XV_GET_VIDEO => XCB_XV_GET_VIDEO_
''     constant XCB_XV_GET_STILL => XCB_XV_GET_STILL_
''     constant XCB_XV_STOP_VIDEO => XCB_XV_STOP_VIDEO_
''     constant XCB_XV_SELECT_VIDEO_NOTIFY => XCB_XV_SELECT_VIDEO_NOTIFY_
''     constant XCB_XV_SELECT_PORT_NOTIFY => XCB_XV_SELECT_PORT_NOTIFY_
''     constant XCB_XV_QUERY_BEST_SIZE => XCB_XV_QUERY_BEST_SIZE_
''     constant XCB_XV_SET_PORT_ATTRIBUTE => XCB_XV_SET_PORT_ATTRIBUTE_
''     constant XCB_XV_GET_PORT_ATTRIBUTE => XCB_XV_GET_PORT_ATTRIBUTE_
''     constant XCB_XV_QUERY_PORT_ATTRIBUTES => XCB_XV_QUERY_PORT_ATTRIBUTES_
''     constant XCB_XV_LIST_IMAGE_FORMATS => XCB_XV_LIST_IMAGE_FORMATS_
''     constant XCB_XV_QUERY_IMAGE_ATTRIBUTES => XCB_XV_QUERY_IMAGE_ATTRIBUTES_
''     constant XCB_XV_PUT_IMAGE => XCB_XV_PUT_IMAGE_
''     constant XCB_XV_SHM_PUT_IMAGE => XCB_XV_SHM_PUT_IMAGE_

extern "C"

#define __XV_H
const XCB_XV_MAJOR_VERSION = 2
const XCB_XV_MINOR_VERSION = 2
extern xcb_xv_id as xcb_extension_t
type xcb_xv_port_t as ulong

type xcb_xv_port_iterator_t
	data as xcb_xv_port_t ptr
	as long rem
	index as long
end type

type xcb_xv_encoding_t as ulong

type xcb_xv_encoding_iterator_t
	data as xcb_xv_encoding_t ptr
	as long rem
	index as long
end type

type xcb_xv_type_t as long
enum
	XCB_XV_TYPE_INPUT_MASK = 1
	XCB_XV_TYPE_OUTPUT_MASK = 2
	XCB_XV_TYPE_VIDEO_MASK = 4
	XCB_XV_TYPE_STILL_MASK = 8
	XCB_XV_TYPE_IMAGE_MASK = 16
end enum

type xcb_xv_image_format_info_type_t as long
enum
	XCB_XV_IMAGE_FORMAT_INFO_TYPE_RGB = 0
	XCB_XV_IMAGE_FORMAT_INFO_TYPE_YUV = 1
end enum

type xcb_xv_image_format_info_format_t as long
enum
	XCB_XV_IMAGE_FORMAT_INFO_FORMAT_PACKED = 0
	XCB_XV_IMAGE_FORMAT_INFO_FORMAT_PLANAR = 1
end enum

type xcb_xv_attribute_flag_t as long
enum
	XCB_XV_ATTRIBUTE_FLAG_GETTABLE = 1
	XCB_XV_ATTRIBUTE_FLAG_SETTABLE = 2
end enum

type xcb_xv_video_notify_reason_t as long
enum
	XCB_XV_VIDEO_NOTIFY_REASON_STARTED = 0
	XCB_XV_VIDEO_NOTIFY_REASON_STOPPED = 1
	XCB_XV_VIDEO_NOTIFY_REASON_BUSY = 2
	XCB_XV_VIDEO_NOTIFY_REASON_PREEMPTED = 3
	XCB_XV_VIDEO_NOTIFY_REASON_HARD_ERROR = 4
end enum

type xcb_xv_scanline_order_t as long
enum
	XCB_XV_SCANLINE_ORDER_TOP_TO_BOTTOM = 0
	XCB_XV_SCANLINE_ORDER_BOTTOM_TO_TOP = 1
end enum

type xcb_xv_grab_port_status_t as long
enum
	XCB_XV_GRAB_PORT_STATUS_SUCCESS = 0
	XCB_XV_GRAB_PORT_STATUS_BAD_EXTENSION = 1
	XCB_XV_GRAB_PORT_STATUS_ALREADY_GRABBED = 2
	XCB_XV_GRAB_PORT_STATUS_INVALID_TIME = 3
	XCB_XV_GRAB_PORT_STATUS_BAD_REPLY = 4
	XCB_XV_GRAB_PORT_STATUS_BAD_ALLOC = 5
end enum

type xcb_xv_rational_t
	numerator as long
	denominator as long
end type

type xcb_xv_rational_iterator_t
	data as xcb_xv_rational_t ptr
	as long rem
	index as long
end type

type xcb_xv_format_t
	visual as xcb_visualid_t
	depth as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_xv_format_iterator_t
	data as xcb_xv_format_t ptr
	as long rem
	index as long
end type

type xcb_xv_adaptor_info_t
	base_id as xcb_xv_port_t
	name_size as ushort
	num_ports as ushort
	num_formats as ushort
	as ubyte type
	pad0 as ubyte
end type

type xcb_xv_adaptor_info_iterator_t
	data as xcb_xv_adaptor_info_t ptr
	as long rem
	index as long
end type

type xcb_xv_encoding_info_t
	encoding as xcb_xv_encoding_t
	name_size as ushort
	width as ushort
	height as ushort
	pad0(0 to 1) as ubyte
	rate as xcb_xv_rational_t
end type

type xcb_xv_encoding_info_iterator_t
	data as xcb_xv_encoding_info_t ptr
	as long rem
	index as long
end type

type xcb_xv_image_t
	id as ulong
	width as ushort
	height as ushort
	data_size as ulong
	num_planes as ulong
end type

type xcb_xv_image_iterator_t
	data as xcb_xv_image_t ptr
	as long rem
	index as long
end type

type xcb_xv_attribute_info_t
	flags as ulong
	min as long
	max as long
	size as ulong
end type

type xcb_xv_attribute_info_iterator_t
	data as xcb_xv_attribute_info_t ptr
	as long rem
	index as long
end type

type xcb_xv_image_format_info_t
	id as ulong
	as ubyte type
	byte_order as ubyte
	pad0(0 to 1) as ubyte
	guid(0 to 15) as ubyte
	bpp as ubyte
	num_planes as ubyte
	pad1(0 to 1) as ubyte
	depth as ubyte
	pad2(0 to 2) as ubyte
	red_mask as ulong
	green_mask as ulong
	blue_mask as ulong
	format as ubyte
	pad3(0 to 2) as ubyte
	y_sample_bits as ulong
	u_sample_bits as ulong
	v_sample_bits as ulong
	vhorz_y_period as ulong
	vhorz_u_period as ulong
	vhorz_v_period as ulong
	vvert_y_period as ulong
	vvert_u_period as ulong
	vvert_v_period as ulong
	vcomp_order(0 to 31) as ubyte
	vscanline_order as ubyte
	pad4(0 to 10) as ubyte
end type

type xcb_xv_image_format_info_iterator_t
	data as xcb_xv_image_format_info_t ptr
	as long rem
	index as long
end type

const XCB_XV_BAD_PORT = 0

type xcb_xv_bad_port_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_XV_BAD_ENCODING = 1

type xcb_xv_bad_encoding_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_XV_BAD_CONTROL = 2

type xcb_xv_bad_control_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_XV_VIDEO_NOTIFY = 0

type xcb_xv_video_notify_event_t
	response_type as ubyte
	reason as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	drawable as xcb_drawable_t
	port as xcb_xv_port_t
end type

const XCB_XV_PORT_NOTIFY = 1

type xcb_xv_port_notify_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	time as xcb_timestamp_t
	port as xcb_xv_port_t
	attribute as xcb_atom_t
	value as long
end type

type xcb_xv_query_extension_cookie_t
	sequence as ulong
end type

const XCB_XV_QUERY_EXTENSION_ = 0

type xcb_xv_query_extension_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_xv_query_extension_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major as ushort
	minor as ushort
end type

type xcb_xv_query_adaptors_cookie_t
	sequence as ulong
end type

const XCB_XV_QUERY_ADAPTORS_ = 1

type xcb_xv_query_adaptors_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_xv_query_adaptors_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_adaptors as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_xv_query_encodings_cookie_t
	sequence as ulong
end type

const XCB_XV_QUERY_ENCODINGS_ = 2

type xcb_xv_query_encodings_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
end type

type xcb_xv_query_encodings_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_encodings as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_xv_grab_port_cookie_t
	sequence as ulong
end type

const XCB_XV_GRAB_PORT_ = 3

type xcb_xv_grab_port_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	time as xcb_timestamp_t
end type

type xcb_xv_grab_port_reply_t
	response_type as ubyte
	result as ubyte
	sequence as ushort
	length as ulong
end type

const XCB_XV_UNGRAB_PORT_ = 4

type xcb_xv_ungrab_port_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	time as xcb_timestamp_t
end type

const XCB_XV_PUT_VIDEO_ = 5

type xcb_xv_put_video_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	vid_x as short
	vid_y as short
	vid_w as ushort
	vid_h as ushort
	drw_x as short
	drw_y as short
	drw_w as ushort
	drw_h as ushort
end type

const XCB_XV_PUT_STILL_ = 6

type xcb_xv_put_still_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	vid_x as short
	vid_y as short
	vid_w as ushort
	vid_h as ushort
	drw_x as short
	drw_y as short
	drw_w as ushort
	drw_h as ushort
end type

const XCB_XV_GET_VIDEO_ = 7

type xcb_xv_get_video_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	vid_x as short
	vid_y as short
	vid_w as ushort
	vid_h as ushort
	drw_x as short
	drw_y as short
	drw_w as ushort
	drw_h as ushort
end type

const XCB_XV_GET_STILL_ = 8

type xcb_xv_get_still_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	vid_x as short
	vid_y as short
	vid_w as ushort
	vid_h as ushort
	drw_x as short
	drw_y as short
	drw_w as ushort
	drw_h as ushort
end type

const XCB_XV_STOP_VIDEO_ = 9

type xcb_xv_stop_video_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
end type

const XCB_XV_SELECT_VIDEO_NOTIFY_ = 10

type xcb_xv_select_video_notify_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	onoff as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_XV_SELECT_PORT_NOTIFY_ = 11

type xcb_xv_select_port_notify_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	onoff as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_xv_query_best_size_cookie_t
	sequence as ulong
end type

const XCB_XV_QUERY_BEST_SIZE_ = 12

type xcb_xv_query_best_size_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	vid_w as ushort
	vid_h as ushort
	drw_w as ushort
	drw_h as ushort
	motion as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_xv_query_best_size_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	actual_width as ushort
	actual_height as ushort
end type

const XCB_XV_SET_PORT_ATTRIBUTE_ = 13

type xcb_xv_set_port_attribute_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	attribute as xcb_atom_t
	value as long
end type

type xcb_xv_get_port_attribute_cookie_t
	sequence as ulong
end type

const XCB_XV_GET_PORT_ATTRIBUTE_ = 14

type xcb_xv_get_port_attribute_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	attribute as xcb_atom_t
end type

type xcb_xv_get_port_attribute_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	value as long
end type

type xcb_xv_query_port_attributes_cookie_t
	sequence as ulong
end type

const XCB_XV_QUERY_PORT_ATTRIBUTES_ = 15

type xcb_xv_query_port_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
end type

type xcb_xv_query_port_attributes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_attributes as ulong
	text_size as ulong
	pad1(0 to 15) as ubyte
end type

type xcb_xv_list_image_formats_cookie_t
	sequence as ulong
end type

const XCB_XV_LIST_IMAGE_FORMATS_ = 16

type xcb_xv_list_image_formats_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
end type

type xcb_xv_list_image_formats_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_formats as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_xv_query_image_attributes_cookie_t
	sequence as ulong
end type

const XCB_XV_QUERY_IMAGE_ATTRIBUTES_ = 17

type xcb_xv_query_image_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	id as ulong
	width as ushort
	height as ushort
end type

type xcb_xv_query_image_attributes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_planes as ulong
	data_size as ulong
	width as ushort
	height as ushort
	pad1(0 to 11) as ubyte
end type

const XCB_XV_PUT_IMAGE_ = 18

type xcb_xv_put_image_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	id as ulong
	src_x as short
	src_y as short
	src_w as ushort
	src_h as ushort
	drw_x as short
	drw_y as short
	drw_w as ushort
	drw_h as ushort
	width as ushort
	height as ushort
end type

const XCB_XV_SHM_PUT_IMAGE_ = 19

type xcb_xv_shm_put_image_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	port as xcb_xv_port_t
	drawable as xcb_drawable_t
	gc as xcb_gcontext_t
	shmseg as xcb_shm_seg_t
	id as ulong
	offset as ulong
	src_x as short
	src_y as short
	src_w as ushort
	src_h as ushort
	drw_x as short
	drw_y as short
	drw_w as ushort
	drw_h as ushort
	width as ushort
	height as ushort
	send_event as ubyte
	pad0(0 to 2) as ubyte
end type

declare sub xcb_xv_port_next(byval i as xcb_xv_port_iterator_t ptr)
declare function xcb_xv_port_end(byval i as xcb_xv_port_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xv_encoding_next(byval i as xcb_xv_encoding_iterator_t ptr)
declare function xcb_xv_encoding_end(byval i as xcb_xv_encoding_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xv_rational_next(byval i as xcb_xv_rational_iterator_t ptr)
declare function xcb_xv_rational_end(byval i as xcb_xv_rational_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xv_format_next(byval i as xcb_xv_format_iterator_t ptr)
declare function xcb_xv_format_end(byval i as xcb_xv_format_iterator_t) as xcb_generic_iterator_t
declare function xcb_xv_adaptor_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_adaptor_info_name(byval R as const xcb_xv_adaptor_info_t ptr) as zstring ptr
declare function xcb_xv_adaptor_info_name_length(byval R as const xcb_xv_adaptor_info_t ptr) as long
declare function xcb_xv_adaptor_info_name_end(byval R as const xcb_xv_adaptor_info_t ptr) as xcb_generic_iterator_t
declare function xcb_xv_adaptor_info_formats(byval R as const xcb_xv_adaptor_info_t ptr) as xcb_xv_format_t ptr
declare function xcb_xv_adaptor_info_formats_length(byval R as const xcb_xv_adaptor_info_t ptr) as long
declare function xcb_xv_adaptor_info_formats_iterator(byval R as const xcb_xv_adaptor_info_t ptr) as xcb_xv_format_iterator_t
declare sub xcb_xv_adaptor_info_next(byval i as xcb_xv_adaptor_info_iterator_t ptr)
declare function xcb_xv_adaptor_info_end(byval i as xcb_xv_adaptor_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_xv_encoding_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_encoding_info_name(byval R as const xcb_xv_encoding_info_t ptr) as zstring ptr
declare function xcb_xv_encoding_info_name_length(byval R as const xcb_xv_encoding_info_t ptr) as long
declare function xcb_xv_encoding_info_name_end(byval R as const xcb_xv_encoding_info_t ptr) as xcb_generic_iterator_t
declare sub xcb_xv_encoding_info_next(byval i as xcb_xv_encoding_info_iterator_t ptr)
declare function xcb_xv_encoding_info_end(byval i as xcb_xv_encoding_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_xv_image_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_image_pitches(byval R as const xcb_xv_image_t ptr) as ulong ptr
declare function xcb_xv_image_pitches_length(byval R as const xcb_xv_image_t ptr) as long
declare function xcb_xv_image_pitches_end(byval R as const xcb_xv_image_t ptr) as xcb_generic_iterator_t
declare function xcb_xv_image_offsets(byval R as const xcb_xv_image_t ptr) as ulong ptr
declare function xcb_xv_image_offsets_length(byval R as const xcb_xv_image_t ptr) as long
declare function xcb_xv_image_offsets_end(byval R as const xcb_xv_image_t ptr) as xcb_generic_iterator_t
declare function xcb_xv_image_data(byval R as const xcb_xv_image_t ptr) as ubyte ptr
declare function xcb_xv_image_data_length(byval R as const xcb_xv_image_t ptr) as long
declare function xcb_xv_image_data_end(byval R as const xcb_xv_image_t ptr) as xcb_generic_iterator_t
declare sub xcb_xv_image_next(byval i as xcb_xv_image_iterator_t ptr)
declare function xcb_xv_image_end(byval i as xcb_xv_image_iterator_t) as xcb_generic_iterator_t
declare function xcb_xv_attribute_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_attribute_info_name(byval R as const xcb_xv_attribute_info_t ptr) as zstring ptr
declare function xcb_xv_attribute_info_name_length(byval R as const xcb_xv_attribute_info_t ptr) as long
declare function xcb_xv_attribute_info_name_end(byval R as const xcb_xv_attribute_info_t ptr) as xcb_generic_iterator_t
declare sub xcb_xv_attribute_info_next(byval i as xcb_xv_attribute_info_iterator_t ptr)
declare function xcb_xv_attribute_info_end(byval i as xcb_xv_attribute_info_iterator_t) as xcb_generic_iterator_t
declare sub xcb_xv_image_format_info_next(byval i as xcb_xv_image_format_info_iterator_t ptr)
declare function xcb_xv_image_format_info_end(byval i as xcb_xv_image_format_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_xv_query_extension(byval c as xcb_connection_t ptr) as xcb_xv_query_extension_cookie_t
declare function xcb_xv_query_extension_unchecked(byval c as xcb_connection_t ptr) as xcb_xv_query_extension_cookie_t
declare function xcb_xv_query_extension_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_query_extension_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_query_extension_reply_t ptr
declare function xcb_xv_query_adaptors_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_query_adaptors(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_xv_query_adaptors_cookie_t
declare function xcb_xv_query_adaptors_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_xv_query_adaptors_cookie_t
declare function xcb_xv_query_adaptors_info_length(byval R as const xcb_xv_query_adaptors_reply_t ptr) as long
declare function xcb_xv_query_adaptors_info_iterator(byval R as const xcb_xv_query_adaptors_reply_t ptr) as xcb_xv_adaptor_info_iterator_t
declare function xcb_xv_query_adaptors_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_query_adaptors_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_query_adaptors_reply_t ptr
declare function xcb_xv_query_encodings_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_query_encodings(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t) as xcb_xv_query_encodings_cookie_t
declare function xcb_xv_query_encodings_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t) as xcb_xv_query_encodings_cookie_t
declare function xcb_xv_query_encodings_info_length(byval R as const xcb_xv_query_encodings_reply_t ptr) as long
declare function xcb_xv_query_encodings_info_iterator(byval R as const xcb_xv_query_encodings_reply_t ptr) as xcb_xv_encoding_info_iterator_t
declare function xcb_xv_query_encodings_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_query_encodings_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_query_encodings_reply_t ptr
declare function xcb_xv_grab_port(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval time as xcb_timestamp_t) as xcb_xv_grab_port_cookie_t
declare function xcb_xv_grab_port_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval time as xcb_timestamp_t) as xcb_xv_grab_port_cookie_t
declare function xcb_xv_grab_port_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_grab_port_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_grab_port_reply_t ptr
declare function xcb_xv_ungrab_port_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_xv_ungrab_port(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval time as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_xv_put_video_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_put_video(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_put_still_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_put_still(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_get_video_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_get_video(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_get_still_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_get_still(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval vid_x as short, byval vid_y as short, byval vid_w as ushort, byval vid_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort) as xcb_void_cookie_t
declare function xcb_xv_stop_video_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_xv_stop_video(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_xv_select_video_notify_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval onoff as ubyte) as xcb_void_cookie_t
declare function xcb_xv_select_video_notify(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval onoff as ubyte) as xcb_void_cookie_t
declare function xcb_xv_select_port_notify_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval onoff as ubyte) as xcb_void_cookie_t
declare function xcb_xv_select_port_notify(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval onoff as ubyte) as xcb_void_cookie_t
declare function xcb_xv_query_best_size(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval vid_w as ushort, byval vid_h as ushort, byval drw_w as ushort, byval drw_h as ushort, byval motion as ubyte) as xcb_xv_query_best_size_cookie_t
declare function xcb_xv_query_best_size_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval vid_w as ushort, byval vid_h as ushort, byval drw_w as ushort, byval drw_h as ushort, byval motion as ubyte) as xcb_xv_query_best_size_cookie_t
declare function xcb_xv_query_best_size_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_query_best_size_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_query_best_size_reply_t ptr
declare function xcb_xv_set_port_attribute_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval attribute as xcb_atom_t, byval value as long) as xcb_void_cookie_t
declare function xcb_xv_set_port_attribute(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval attribute as xcb_atom_t, byval value as long) as xcb_void_cookie_t
declare function xcb_xv_get_port_attribute(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval attribute as xcb_atom_t) as xcb_xv_get_port_attribute_cookie_t
declare function xcb_xv_get_port_attribute_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval attribute as xcb_atom_t) as xcb_xv_get_port_attribute_cookie_t
declare function xcb_xv_get_port_attribute_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_get_port_attribute_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_get_port_attribute_reply_t ptr
declare function xcb_xv_query_port_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_query_port_attributes(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t) as xcb_xv_query_port_attributes_cookie_t
declare function xcb_xv_query_port_attributes_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t) as xcb_xv_query_port_attributes_cookie_t
declare function xcb_xv_query_port_attributes_attributes_length(byval R as const xcb_xv_query_port_attributes_reply_t ptr) as long
declare function xcb_xv_query_port_attributes_attributes_iterator(byval R as const xcb_xv_query_port_attributes_reply_t ptr) as xcb_xv_attribute_info_iterator_t
declare function xcb_xv_query_port_attributes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_query_port_attributes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_query_port_attributes_reply_t ptr
declare function xcb_xv_list_image_formats_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_list_image_formats(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t) as xcb_xv_list_image_formats_cookie_t
declare function xcb_xv_list_image_formats_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t) as xcb_xv_list_image_formats_cookie_t
declare function xcb_xv_list_image_formats_format(byval R as const xcb_xv_list_image_formats_reply_t ptr) as xcb_xv_image_format_info_t ptr
declare function xcb_xv_list_image_formats_format_length(byval R as const xcb_xv_list_image_formats_reply_t ptr) as long
declare function xcb_xv_list_image_formats_format_iterator(byval R as const xcb_xv_list_image_formats_reply_t ptr) as xcb_xv_image_format_info_iterator_t
declare function xcb_xv_list_image_formats_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_list_image_formats_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_list_image_formats_reply_t ptr
declare function xcb_xv_query_image_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_xv_query_image_attributes(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval id as ulong, byval width as ushort, byval height as ushort) as xcb_xv_query_image_attributes_cookie_t
declare function xcb_xv_query_image_attributes_unchecked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval id as ulong, byval width as ushort, byval height as ushort) as xcb_xv_query_image_attributes_cookie_t
declare function xcb_xv_query_image_attributes_pitches(byval R as const xcb_xv_query_image_attributes_reply_t ptr) as ulong ptr
declare function xcb_xv_query_image_attributes_pitches_length(byval R as const xcb_xv_query_image_attributes_reply_t ptr) as long
declare function xcb_xv_query_image_attributes_pitches_end(byval R as const xcb_xv_query_image_attributes_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xv_query_image_attributes_offsets(byval R as const xcb_xv_query_image_attributes_reply_t ptr) as ulong ptr
declare function xcb_xv_query_image_attributes_offsets_length(byval R as const xcb_xv_query_image_attributes_reply_t ptr) as long
declare function xcb_xv_query_image_attributes_offsets_end(byval R as const xcb_xv_query_image_attributes_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_xv_query_image_attributes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_xv_query_image_attributes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_xv_query_image_attributes_reply_t ptr
declare function xcb_xv_put_image_sizeof(byval _buffer as const any ptr, byval data_len as ulong) as long
declare function xcb_xv_put_image_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval id as ulong, byval src_x as short, byval src_y as short, byval src_w as ushort, byval src_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort, byval width as ushort, byval height as ushort, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_xv_put_image(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval id as ulong, byval src_x as short, byval src_y as short, byval src_w as ushort, byval src_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort, byval width as ushort, byval height as ushort, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_xv_shm_put_image_checked(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval shmseg as xcb_shm_seg_t, byval id as ulong, byval offset as ulong, byval src_x as short, byval src_y as short, byval src_w as ushort, byval src_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort, byval width as ushort, byval height as ushort, byval send_event as ubyte) as xcb_void_cookie_t
declare function xcb_xv_shm_put_image(byval c as xcb_connection_t ptr, byval port as xcb_xv_port_t, byval drawable as xcb_drawable_t, byval gc as xcb_gcontext_t, byval shmseg as xcb_shm_seg_t, byval id as ulong, byval offset as ulong, byval src_x as short, byval src_y as short, byval src_w as ushort, byval src_h as ushort, byval drw_x as short, byval drw_y as short, byval drw_w as ushort, byval drw_h as ushort, byval width as ushort, byval height as ushort, byval send_event as ubyte) as xcb_void_cookie_t

end extern
