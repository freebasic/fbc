'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2005 Jeremy Kolb.
''   Copyright © 2009 Intel Corporation
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
''     constant XCB_DRI2_QUERY_VERSION => XCB_DRI2_QUERY_VERSION_
''     constant XCB_DRI2_CONNECT => XCB_DRI2_CONNECT_
''     constant XCB_DRI2_AUTHENTICATE => XCB_DRI2_AUTHENTICATE_
''     constant XCB_DRI2_CREATE_DRAWABLE => XCB_DRI2_CREATE_DRAWABLE_
''     constant XCB_DRI2_DESTROY_DRAWABLE => XCB_DRI2_DESTROY_DRAWABLE_
''     constant XCB_DRI2_GET_BUFFERS => XCB_DRI2_GET_BUFFERS_
''     constant XCB_DRI2_COPY_REGION => XCB_DRI2_COPY_REGION_
''     constant XCB_DRI2_GET_BUFFERS_WITH_FORMAT => XCB_DRI2_GET_BUFFERS_WITH_FORMAT_
''     constant XCB_DRI2_SWAP_BUFFERS => XCB_DRI2_SWAP_BUFFERS_
''     constant XCB_DRI2_GET_MSC => XCB_DRI2_GET_MSC_
''     constant XCB_DRI2_WAIT_MSC => XCB_DRI2_WAIT_MSC_
''     constant XCB_DRI2_WAIT_SBC => XCB_DRI2_WAIT_SBC_
''     constant XCB_DRI2_SWAP_INTERVAL => XCB_DRI2_SWAP_INTERVAL_
''     constant XCB_DRI2_GET_PARAM => XCB_DRI2_GET_PARAM_

extern "C"

#define __DRI2_H
const XCB_DRI2_MAJOR_VERSION = 1
const XCB_DRI2_MINOR_VERSION = 4
extern xcb_dri2_id as xcb_extension_t

type xcb_dri2_attachment_t as long
enum
	XCB_DRI2_ATTACHMENT_BUFFER_FRONT_LEFT = 0
	XCB_DRI2_ATTACHMENT_BUFFER_BACK_LEFT = 1
	XCB_DRI2_ATTACHMENT_BUFFER_FRONT_RIGHT = 2
	XCB_DRI2_ATTACHMENT_BUFFER_BACK_RIGHT = 3
	XCB_DRI2_ATTACHMENT_BUFFER_DEPTH = 4
	XCB_DRI2_ATTACHMENT_BUFFER_STENCIL = 5
	XCB_DRI2_ATTACHMENT_BUFFER_ACCUM = 6
	XCB_DRI2_ATTACHMENT_BUFFER_FAKE_FRONT_LEFT = 7
	XCB_DRI2_ATTACHMENT_BUFFER_FAKE_FRONT_RIGHT = 8
	XCB_DRI2_ATTACHMENT_BUFFER_DEPTH_STENCIL = 9
	XCB_DRI2_ATTACHMENT_BUFFER_HIZ = 10
end enum

type xcb_dri2_driver_type_t as long
enum
	XCB_DRI2_DRIVER_TYPE_DRI = 0
	XCB_DRI2_DRIVER_TYPE_VDPAU = 1
end enum

type xcb_dri2_event_type_t as long
enum
	XCB_DRI2_EVENT_TYPE_EXCHANGE_COMPLETE = 1
	XCB_DRI2_EVENT_TYPE_BLIT_COMPLETE = 2
	XCB_DRI2_EVENT_TYPE_FLIP_COMPLETE = 3
end enum

type xcb_dri2_dri2_buffer_t
	attachment as ulong
	name as ulong
	pitch as ulong
	cpp as ulong
	flags as ulong
end type

type xcb_dri2_dri2_buffer_iterator_t
	data as xcb_dri2_dri2_buffer_t ptr
	as long rem
	index as long
end type

type xcb_dri2_attach_format_t
	attachment as ulong
	format as ulong
end type

type xcb_dri2_attach_format_iterator_t
	data as xcb_dri2_attach_format_t ptr
	as long rem
	index as long
end type

type xcb_dri2_query_version_cookie_t
	sequence as ulong
end type

const XCB_DRI2_QUERY_VERSION_ = 0

type xcb_dri2_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
end type

type xcb_dri2_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
end type

type xcb_dri2_connect_cookie_t
	sequence as ulong
end type

const XCB_DRI2_CONNECT_ = 1

type xcb_dri2_connect_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	driver_type as ulong
end type

type xcb_dri2_connect_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	driver_name_length as ulong
	device_name_length as ulong
	pad1(0 to 15) as ubyte
end type

type xcb_dri2_authenticate_cookie_t
	sequence as ulong
end type

const XCB_DRI2_AUTHENTICATE_ = 2

type xcb_dri2_authenticate_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	magic as ulong
end type

type xcb_dri2_authenticate_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	authenticated as ulong
end type

const XCB_DRI2_CREATE_DRAWABLE_ = 3

type xcb_dri2_create_drawable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

const XCB_DRI2_DESTROY_DRAWABLE_ = 4

type xcb_dri2_destroy_drawable_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

type xcb_dri2_get_buffers_cookie_t
	sequence as ulong
end type

const XCB_DRI2_GET_BUFFERS_ = 5

type xcb_dri2_get_buffers_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	count as ulong
end type

type xcb_dri2_get_buffers_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width as ulong
	height as ulong
	count as ulong
	pad1(0 to 11) as ubyte
end type

type xcb_dri2_copy_region_cookie_t
	sequence as ulong
end type

const XCB_DRI2_COPY_REGION_ = 6

type xcb_dri2_copy_region_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	region as ulong
	dest as ulong
	src as ulong
end type

type xcb_dri2_copy_region_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
end type

type xcb_dri2_get_buffers_with_format_cookie_t
	sequence as ulong
end type

const XCB_DRI2_GET_BUFFERS_WITH_FORMAT_ = 7

type xcb_dri2_get_buffers_with_format_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	count as ulong
end type

type xcb_dri2_get_buffers_with_format_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	width as ulong
	height as ulong
	count as ulong
	pad1(0 to 11) as ubyte
end type

type xcb_dri2_swap_buffers_cookie_t
	sequence as ulong
end type

const XCB_DRI2_SWAP_BUFFERS_ = 8

type xcb_dri2_swap_buffers_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	target_msc_hi as ulong
	target_msc_lo as ulong
	divisor_hi as ulong
	divisor_lo as ulong
	remainder_hi as ulong
	remainder_lo as ulong
end type

type xcb_dri2_swap_buffers_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	swap_hi as ulong
	swap_lo as ulong
end type

type xcb_dri2_get_msc_cookie_t
	sequence as ulong
end type

const XCB_DRI2_GET_MSC_ = 9

type xcb_dri2_get_msc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

type xcb_dri2_get_msc_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ust_hi as ulong
	ust_lo as ulong
	msc_hi as ulong
	msc_lo as ulong
	sbc_hi as ulong
	sbc_lo as ulong
end type

type xcb_dri2_wait_msc_cookie_t
	sequence as ulong
end type

const XCB_DRI2_WAIT_MSC_ = 10

type xcb_dri2_wait_msc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	target_msc_hi as ulong
	target_msc_lo as ulong
	divisor_hi as ulong
	divisor_lo as ulong
	remainder_hi as ulong
	remainder_lo as ulong
end type

type xcb_dri2_wait_msc_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ust_hi as ulong
	ust_lo as ulong
	msc_hi as ulong
	msc_lo as ulong
	sbc_hi as ulong
	sbc_lo as ulong
end type

type xcb_dri2_wait_sbc_cookie_t
	sequence as ulong
end type

const XCB_DRI2_WAIT_SBC_ = 11

type xcb_dri2_wait_sbc_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	target_sbc_hi as ulong
	target_sbc_lo as ulong
end type

type xcb_dri2_wait_sbc_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ust_hi as ulong
	ust_lo as ulong
	msc_hi as ulong
	msc_lo as ulong
	sbc_hi as ulong
	sbc_lo as ulong
end type

const XCB_DRI2_SWAP_INTERVAL_ = 12

type xcb_dri2_swap_interval_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	interval as ulong
end type

type xcb_dri2_get_param_cookie_t
	sequence as ulong
end type

const XCB_DRI2_GET_PARAM_ = 13

type xcb_dri2_get_param_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
	param as ulong
end type

type xcb_dri2_get_param_reply_t
	response_type as ubyte
	is_param_recognized as ubyte
	sequence as ushort
	length as ulong
	value_hi as ulong
	value_lo as ulong
end type

const XCB_DRI2_BUFFER_SWAP_COMPLETE = 0

type xcb_dri2_buffer_swap_complete_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event_type as ushort
	pad1(0 to 1) as ubyte
	drawable as xcb_drawable_t
	ust_hi as ulong
	ust_lo as ulong
	msc_hi as ulong
	msc_lo as ulong
	sbc as ulong
end type

const XCB_DRI2_INVALIDATE_BUFFERS = 1

type xcb_dri2_invalidate_buffers_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	drawable as xcb_drawable_t
end type

declare sub xcb_dri2_dri2_buffer_next(byval i as xcb_dri2_dri2_buffer_iterator_t ptr)
declare function xcb_dri2_dri2_buffer_end(byval i as xcb_dri2_dri2_buffer_iterator_t) as xcb_generic_iterator_t
declare sub xcb_dri2_attach_format_next(byval i as xcb_dri2_attach_format_iterator_t ptr)
declare function xcb_dri2_attach_format_end(byval i as xcb_dri2_attach_format_iterator_t) as xcb_generic_iterator_t
declare function xcb_dri2_query_version(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_dri2_query_version_cookie_t
declare function xcb_dri2_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_dri2_query_version_cookie_t
declare function xcb_dri2_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_query_version_reply_t ptr
declare function xcb_dri2_connect_sizeof(byval _buffer as const any ptr) as long
declare function xcb_dri2_connect(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval driver_type as ulong) as xcb_dri2_connect_cookie_t
declare function xcb_dri2_connect_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval driver_type as ulong) as xcb_dri2_connect_cookie_t
declare function xcb_dri2_connect_driver_name(byval R as const xcb_dri2_connect_reply_t ptr) as zstring ptr
declare function xcb_dri2_connect_driver_name_length(byval R as const xcb_dri2_connect_reply_t ptr) as long
declare function xcb_dri2_connect_driver_name_end(byval R as const xcb_dri2_connect_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_dri2_connect_alignment_pad(byval R as const xcb_dri2_connect_reply_t ptr) as any ptr
declare function xcb_dri2_connect_alignment_pad_length(byval R as const xcb_dri2_connect_reply_t ptr) as long
declare function xcb_dri2_connect_alignment_pad_end(byval R as const xcb_dri2_connect_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_dri2_connect_device_name(byval R as const xcb_dri2_connect_reply_t ptr) as zstring ptr
declare function xcb_dri2_connect_device_name_length(byval R as const xcb_dri2_connect_reply_t ptr) as long
declare function xcb_dri2_connect_device_name_end(byval R as const xcb_dri2_connect_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_dri2_connect_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_connect_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_connect_reply_t ptr
declare function xcb_dri2_authenticate(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval magic as ulong) as xcb_dri2_authenticate_cookie_t
declare function xcb_dri2_authenticate_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval magic as ulong) as xcb_dri2_authenticate_cookie_t
declare function xcb_dri2_authenticate_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_authenticate_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_authenticate_reply_t ptr
declare function xcb_dri2_create_drawable_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_dri2_create_drawable(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_dri2_destroy_drawable_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_dri2_destroy_drawable(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_void_cookie_t
declare function xcb_dri2_get_buffers_sizeof(byval _buffer as const any ptr, byval attachments_len as ulong) as long
declare function xcb_dri2_get_buffers(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval count as ulong, byval attachments_len as ulong, byval attachments as const ulong ptr) as xcb_dri2_get_buffers_cookie_t
declare function xcb_dri2_get_buffers_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval count as ulong, byval attachments_len as ulong, byval attachments as const ulong ptr) as xcb_dri2_get_buffers_cookie_t
declare function xcb_dri2_get_buffers_buffers(byval R as const xcb_dri2_get_buffers_reply_t ptr) as xcb_dri2_dri2_buffer_t ptr
declare function xcb_dri2_get_buffers_buffers_length(byval R as const xcb_dri2_get_buffers_reply_t ptr) as long
declare function xcb_dri2_get_buffers_buffers_iterator(byval R as const xcb_dri2_get_buffers_reply_t ptr) as xcb_dri2_dri2_buffer_iterator_t
declare function xcb_dri2_get_buffers_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_get_buffers_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_get_buffers_reply_t ptr
declare function xcb_dri2_copy_region(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval region as ulong, byval dest as ulong, byval src as ulong) as xcb_dri2_copy_region_cookie_t
declare function xcb_dri2_copy_region_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval region as ulong, byval dest as ulong, byval src as ulong) as xcb_dri2_copy_region_cookie_t
declare function xcb_dri2_copy_region_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_copy_region_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_copy_region_reply_t ptr
declare function xcb_dri2_get_buffers_with_format_sizeof(byval _buffer as const any ptr, byval attachments_len as ulong) as long
declare function xcb_dri2_get_buffers_with_format(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval count as ulong, byval attachments_len as ulong, byval attachments as const xcb_dri2_attach_format_t ptr) as xcb_dri2_get_buffers_with_format_cookie_t
declare function xcb_dri2_get_buffers_with_format_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval count as ulong, byval attachments_len as ulong, byval attachments as const xcb_dri2_attach_format_t ptr) as xcb_dri2_get_buffers_with_format_cookie_t
declare function xcb_dri2_get_buffers_with_format_buffers(byval R as const xcb_dri2_get_buffers_with_format_reply_t ptr) as xcb_dri2_dri2_buffer_t ptr
declare function xcb_dri2_get_buffers_with_format_buffers_length(byval R as const xcb_dri2_get_buffers_with_format_reply_t ptr) as long
declare function xcb_dri2_get_buffers_with_format_buffers_iterator(byval R as const xcb_dri2_get_buffers_with_format_reply_t ptr) as xcb_dri2_dri2_buffer_iterator_t
declare function xcb_dri2_get_buffers_with_format_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_get_buffers_with_format_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_get_buffers_with_format_reply_t ptr
declare function xcb_dri2_swap_buffers(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval target_msc_hi as ulong, byval target_msc_lo as ulong, byval divisor_hi as ulong, byval divisor_lo as ulong, byval remainder_hi as ulong, byval remainder_lo as ulong) as xcb_dri2_swap_buffers_cookie_t
declare function xcb_dri2_swap_buffers_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval target_msc_hi as ulong, byval target_msc_lo as ulong, byval divisor_hi as ulong, byval divisor_lo as ulong, byval remainder_hi as ulong, byval remainder_lo as ulong) as xcb_dri2_swap_buffers_cookie_t
declare function xcb_dri2_swap_buffers_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_swap_buffers_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_swap_buffers_reply_t ptr
declare function xcb_dri2_get_msc(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_dri2_get_msc_cookie_t
declare function xcb_dri2_get_msc_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_dri2_get_msc_cookie_t
declare function xcb_dri2_get_msc_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_get_msc_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_get_msc_reply_t ptr
declare function xcb_dri2_wait_msc(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval target_msc_hi as ulong, byval target_msc_lo as ulong, byval divisor_hi as ulong, byval divisor_lo as ulong, byval remainder_hi as ulong, byval remainder_lo as ulong) as xcb_dri2_wait_msc_cookie_t
declare function xcb_dri2_wait_msc_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval target_msc_hi as ulong, byval target_msc_lo as ulong, byval divisor_hi as ulong, byval divisor_lo as ulong, byval remainder_hi as ulong, byval remainder_lo as ulong) as xcb_dri2_wait_msc_cookie_t
declare function xcb_dri2_wait_msc_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_wait_msc_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_wait_msc_reply_t ptr
declare function xcb_dri2_wait_sbc(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval target_sbc_hi as ulong, byval target_sbc_lo as ulong) as xcb_dri2_wait_sbc_cookie_t
declare function xcb_dri2_wait_sbc_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval target_sbc_hi as ulong, byval target_sbc_lo as ulong) as xcb_dri2_wait_sbc_cookie_t
declare function xcb_dri2_wait_sbc_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_wait_sbc_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_wait_sbc_reply_t ptr
declare function xcb_dri2_swap_interval_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval interval as ulong) as xcb_void_cookie_t
declare function xcb_dri2_swap_interval(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval interval as ulong) as xcb_void_cookie_t
declare function xcb_dri2_get_param(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval param as ulong) as xcb_dri2_get_param_cookie_t
declare function xcb_dri2_get_param_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t, byval param as ulong) as xcb_dri2_get_param_cookie_t
declare function xcb_dri2_get_param_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_dri2_get_param_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_dri2_get_param_reply_t ptr

end extern
