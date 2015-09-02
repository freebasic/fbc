'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2006 Jeremy Kolb, Ian Osgood
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
#include once "render.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_RANDR_QUERY_VERSION => XCB_RANDR_QUERY_VERSION_
''     constant XCB_RANDR_SET_SCREEN_CONFIG => XCB_RANDR_SET_SCREEN_CONFIG_
''     constant XCB_RANDR_SELECT_INPUT => XCB_RANDR_SELECT_INPUT_
''     constant XCB_RANDR_GET_SCREEN_INFO => XCB_RANDR_GET_SCREEN_INFO_
''     constant XCB_RANDR_GET_SCREEN_SIZE_RANGE => XCB_RANDR_GET_SCREEN_SIZE_RANGE_
''     constant XCB_RANDR_SET_SCREEN_SIZE => XCB_RANDR_SET_SCREEN_SIZE_
''     constant XCB_RANDR_GET_SCREEN_RESOURCES => XCB_RANDR_GET_SCREEN_RESOURCES_
''     constant XCB_RANDR_GET_OUTPUT_INFO => XCB_RANDR_GET_OUTPUT_INFO_
''     constant XCB_RANDR_LIST_OUTPUT_PROPERTIES => XCB_RANDR_LIST_OUTPUT_PROPERTIES_
''     constant XCB_RANDR_QUERY_OUTPUT_PROPERTY => XCB_RANDR_QUERY_OUTPUT_PROPERTY_
''     constant XCB_RANDR_CONFIGURE_OUTPUT_PROPERTY => XCB_RANDR_CONFIGURE_OUTPUT_PROPERTY_
''     constant XCB_RANDR_CHANGE_OUTPUT_PROPERTY => XCB_RANDR_CHANGE_OUTPUT_PROPERTY_
''     constant XCB_RANDR_DELETE_OUTPUT_PROPERTY => XCB_RANDR_DELETE_OUTPUT_PROPERTY_
''     constant XCB_RANDR_GET_OUTPUT_PROPERTY => XCB_RANDR_GET_OUTPUT_PROPERTY_
''     constant XCB_RANDR_CREATE_MODE => XCB_RANDR_CREATE_MODE_
''     constant XCB_RANDR_DESTROY_MODE => XCB_RANDR_DESTROY_MODE_
''     constant XCB_RANDR_ADD_OUTPUT_MODE => XCB_RANDR_ADD_OUTPUT_MODE_
''     constant XCB_RANDR_DELETE_OUTPUT_MODE => XCB_RANDR_DELETE_OUTPUT_MODE_
''     constant XCB_RANDR_GET_CRTC_INFO => XCB_RANDR_GET_CRTC_INFO_
''     constant XCB_RANDR_SET_CRTC_CONFIG => XCB_RANDR_SET_CRTC_CONFIG_
''     constant XCB_RANDR_GET_CRTC_GAMMA_SIZE => XCB_RANDR_GET_CRTC_GAMMA_SIZE_
''     constant XCB_RANDR_GET_CRTC_GAMMA => XCB_RANDR_GET_CRTC_GAMMA_
''     constant XCB_RANDR_SET_CRTC_GAMMA => XCB_RANDR_SET_CRTC_GAMMA_
''     constant XCB_RANDR_GET_SCREEN_RESOURCES_CURRENT => XCB_RANDR_GET_SCREEN_RESOURCES_CURRENT_
''     constant XCB_RANDR_SET_CRTC_TRANSFORM => XCB_RANDR_SET_CRTC_TRANSFORM_
''     constant XCB_RANDR_GET_CRTC_TRANSFORM => XCB_RANDR_GET_CRTC_TRANSFORM_
''     constant XCB_RANDR_GET_PANNING => XCB_RANDR_GET_PANNING_
''     constant XCB_RANDR_SET_PANNING => XCB_RANDR_SET_PANNING_
''     constant XCB_RANDR_SET_OUTPUT_PRIMARY => XCB_RANDR_SET_OUTPUT_PRIMARY_
''     constant XCB_RANDR_GET_OUTPUT_PRIMARY => XCB_RANDR_GET_OUTPUT_PRIMARY_
''     constant XCB_RANDR_GET_PROVIDERS => XCB_RANDR_GET_PROVIDERS_
''     constant XCB_RANDR_GET_PROVIDER_INFO => XCB_RANDR_GET_PROVIDER_INFO_
''     constant XCB_RANDR_SET_PROVIDER_OFFLOAD_SINK => XCB_RANDR_SET_PROVIDER_OFFLOAD_SINK_
''     constant XCB_RANDR_SET_PROVIDER_OUTPUT_SOURCE => XCB_RANDR_SET_PROVIDER_OUTPUT_SOURCE_
''     constant XCB_RANDR_LIST_PROVIDER_PROPERTIES => XCB_RANDR_LIST_PROVIDER_PROPERTIES_
''     constant XCB_RANDR_QUERY_PROVIDER_PROPERTY => XCB_RANDR_QUERY_PROVIDER_PROPERTY_
''     constant XCB_RANDR_CONFIGURE_PROVIDER_PROPERTY => XCB_RANDR_CONFIGURE_PROVIDER_PROPERTY_
''     constant XCB_RANDR_CHANGE_PROVIDER_PROPERTY => XCB_RANDR_CHANGE_PROVIDER_PROPERTY_
''     constant XCB_RANDR_DELETE_PROVIDER_PROPERTY => XCB_RANDR_DELETE_PROVIDER_PROPERTY_
''     constant XCB_RANDR_GET_PROVIDER_PROPERTY => XCB_RANDR_GET_PROVIDER_PROPERTY_

extern "C"

#define __RANDR_H
const XCB_RANDR_MAJOR_VERSION = 1
const XCB_RANDR_MINOR_VERSION = 4
extern xcb_randr_id as xcb_extension_t
type xcb_randr_mode_t as ulong

type xcb_randr_mode_iterator_t
	data as xcb_randr_mode_t ptr
	as long rem
	index as long
end type

type xcb_randr_crtc_t as ulong

type xcb_randr_crtc_iterator_t
	data as xcb_randr_crtc_t ptr
	as long rem
	index as long
end type

type xcb_randr_output_t as ulong

type xcb_randr_output_iterator_t
	data as xcb_randr_output_t ptr
	as long rem
	index as long
end type

type xcb_randr_provider_t as ulong

type xcb_randr_provider_iterator_t
	data as xcb_randr_provider_t ptr
	as long rem
	index as long
end type

const XCB_RANDR_BAD_OUTPUT = 0

type xcb_randr_bad_output_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RANDR_BAD_CRTC = 1

type xcb_randr_bad_crtc_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RANDR_BAD_MODE = 2

type xcb_randr_bad_mode_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RANDR_BAD_PROVIDER = 3

type xcb_randr_bad_provider_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

type xcb_randr_rotation_t as long
enum
	XCB_RANDR_ROTATION_ROTATE_0 = 1
	XCB_RANDR_ROTATION_ROTATE_90 = 2
	XCB_RANDR_ROTATION_ROTATE_180 = 4
	XCB_RANDR_ROTATION_ROTATE_270 = 8
	XCB_RANDR_ROTATION_REFLECT_X = 16
	XCB_RANDR_ROTATION_REFLECT_Y = 32
end enum

type xcb_randr_screen_size_t
	width as ushort
	height as ushort
	mwidth as ushort
	mheight as ushort
end type

type xcb_randr_screen_size_iterator_t
	data as xcb_randr_screen_size_t ptr
	as long rem
	index as long
end type

type xcb_randr_refresh_rates_t
	nRates as ushort
end type

type xcb_randr_refresh_rates_iterator_t
	data as xcb_randr_refresh_rates_t ptr
	as long rem
	index as long
end type

type xcb_randr_query_version_cookie_t
	sequence as ulong
end type

const XCB_RANDR_QUERY_VERSION_ = 0

type xcb_randr_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
end type

type xcb_randr_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
	pad1(0 to 15) as ubyte
end type

type xcb_randr_set_config_t as long
enum
	XCB_RANDR_SET_CONFIG_SUCCESS = 0
	XCB_RANDR_SET_CONFIG_INVALID_CONFIG_TIME = 1
	XCB_RANDR_SET_CONFIG_INVALID_TIME = 2
	XCB_RANDR_SET_CONFIG_FAILED = 3
end enum

type xcb_randr_set_screen_config_cookie_t
	sequence as ulong
end type

const XCB_RANDR_SET_SCREEN_CONFIG_ = 2

type xcb_randr_set_screen_config_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	sizeID as ushort
	rotation as ushort
	rate as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_randr_set_screen_config_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	new_timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	root as xcb_window_t
	subpixel_order as ushort
	pad0(0 to 9) as ubyte
end type

type xcb_randr_notify_mask_t as long
enum
	XCB_RANDR_NOTIFY_MASK_SCREEN_CHANGE = 1
	XCB_RANDR_NOTIFY_MASK_CRTC_CHANGE = 2
	XCB_RANDR_NOTIFY_MASK_OUTPUT_CHANGE = 4
	XCB_RANDR_NOTIFY_MASK_OUTPUT_PROPERTY = 8
	XCB_RANDR_NOTIFY_MASK_PROVIDER_CHANGE = 16
	XCB_RANDR_NOTIFY_MASK_PROVIDER_PROPERTY = 32
	XCB_RANDR_NOTIFY_MASK_RESOURCE_CHANGE = 64
end enum

const XCB_RANDR_SELECT_INPUT_ = 4

type xcb_randr_select_input_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	enable as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_randr_get_screen_info_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_SCREEN_INFO_ = 5

type xcb_randr_get_screen_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_randr_get_screen_info_reply_t
	response_type as ubyte
	rotations as ubyte
	sequence as ushort
	length as ulong
	root as xcb_window_t
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	nSizes as ushort
	sizeID as ushort
	rotation as ushort
	rate as ushort
	nInfo as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_randr_get_screen_size_range_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_SCREEN_SIZE_RANGE_ = 6

type xcb_randr_get_screen_size_range_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_randr_get_screen_size_range_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	min_width as ushort
	min_height as ushort
	max_width as ushort
	max_height as ushort
	pad1(0 to 15) as ubyte
end type

const XCB_RANDR_SET_SCREEN_SIZE_ = 7

type xcb_randr_set_screen_size_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	width as ushort
	height as ushort
	mm_width as ulong
	mm_height as ulong
end type

type xcb_randr_mode_flag_t as long
enum
	XCB_RANDR_MODE_FLAG_HSYNC_POSITIVE = 1
	XCB_RANDR_MODE_FLAG_HSYNC_NEGATIVE = 2
	XCB_RANDR_MODE_FLAG_VSYNC_POSITIVE = 4
	XCB_RANDR_MODE_FLAG_VSYNC_NEGATIVE = 8
	XCB_RANDR_MODE_FLAG_INTERLACE = 16
	XCB_RANDR_MODE_FLAG_DOUBLE_SCAN = 32
	XCB_RANDR_MODE_FLAG_CSYNC = 64
	XCB_RANDR_MODE_FLAG_CSYNC_POSITIVE = 128
	XCB_RANDR_MODE_FLAG_CSYNC_NEGATIVE = 256
	XCB_RANDR_MODE_FLAG_HSKEW_PRESENT = 512
	XCB_RANDR_MODE_FLAG_BCAST = 1024
	XCB_RANDR_MODE_FLAG_PIXEL_MULTIPLEX = 2048
	XCB_RANDR_MODE_FLAG_DOUBLE_CLOCK = 4096
	XCB_RANDR_MODE_FLAG_HALVE_CLOCK = 8192
end enum

type xcb_randr_mode_info_t
	id as ulong
	width as ushort
	height as ushort
	dot_clock as ulong
	hsync_start as ushort
	hsync_end as ushort
	htotal as ushort
	hskew as ushort
	vsync_start as ushort
	vsync_end as ushort
	vtotal as ushort
	name_len as ushort
	mode_flags as ulong
end type

type xcb_randr_mode_info_iterator_t
	data as xcb_randr_mode_info_t ptr
	as long rem
	index as long
end type

type xcb_randr_get_screen_resources_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_SCREEN_RESOURCES_ = 8

type xcb_randr_get_screen_resources_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_randr_get_screen_resources_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	num_crtcs as ushort
	num_outputs as ushort
	num_modes as ushort
	names_len as ushort
	pad1(0 to 7) as ubyte
end type

type xcb_randr_connection_t as long
enum
	XCB_RANDR_CONNECTION_CONNECTED = 0
	XCB_RANDR_CONNECTION_DISCONNECTED = 1
	XCB_RANDR_CONNECTION_UNKNOWN = 2
end enum

type xcb_randr_get_output_info_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_OUTPUT_INFO_ = 9

type xcb_randr_get_output_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	config_timestamp as xcb_timestamp_t
end type

type xcb_randr_get_output_info_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	crtc as xcb_randr_crtc_t
	mm_width as ulong
	mm_height as ulong
	connection as ubyte
	subpixel_order as ubyte
	num_crtcs as ushort
	num_modes as ushort
	num_preferred as ushort
	num_clones as ushort
	name_len as ushort
end type

type xcb_randr_list_output_properties_cookie_t
	sequence as ulong
end type

const XCB_RANDR_LIST_OUTPUT_PROPERTIES_ = 10

type xcb_randr_list_output_properties_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
end type

type xcb_randr_list_output_properties_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_atoms as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_randr_query_output_property_cookie_t
	sequence as ulong
end type

const XCB_RANDR_QUERY_OUTPUT_PROPERTY_ = 11

type xcb_randr_query_output_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	property as xcb_atom_t
end type

type xcb_randr_query_output_property_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pending as ubyte
	range as ubyte
	immutable as ubyte
	pad1(0 to 20) as ubyte
end type

const XCB_RANDR_CONFIGURE_OUTPUT_PROPERTY_ = 12

type xcb_randr_configure_output_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	property as xcb_atom_t
	pending as ubyte
	range as ubyte
	pad0(0 to 1) as ubyte
end type

const XCB_RANDR_CHANGE_OUTPUT_PROPERTY_ = 13

type xcb_randr_change_output_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	property as xcb_atom_t
	as xcb_atom_t type
	format as ubyte
	mode as ubyte
	pad0(0 to 1) as ubyte
	num_units as ulong
end type

const XCB_RANDR_DELETE_OUTPUT_PROPERTY_ = 14

type xcb_randr_delete_output_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	property as xcb_atom_t
end type

type xcb_randr_get_output_property_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_OUTPUT_PROPERTY_ = 15

type xcb_randr_get_output_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	property as xcb_atom_t
	as xcb_atom_t type
	long_offset as ulong
	long_length as ulong
	_delete as ubyte
	pending as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_randr_get_output_property_reply_t
	response_type as ubyte
	format as ubyte
	sequence as ushort
	length as ulong
	as xcb_atom_t type
	bytes_after as ulong
	num_items as ulong
	pad0(0 to 11) as ubyte
end type

type xcb_randr_create_mode_cookie_t
	sequence as ulong
end type

const XCB_RANDR_CREATE_MODE_ = 16

type xcb_randr_create_mode_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	mode_info as xcb_randr_mode_info_t
end type

type xcb_randr_create_mode_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	mode as xcb_randr_mode_t
	pad1(0 to 19) as ubyte
end type

const XCB_RANDR_DESTROY_MODE_ = 17

type xcb_randr_destroy_mode_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	mode as xcb_randr_mode_t
end type

const XCB_RANDR_ADD_OUTPUT_MODE_ = 18

type xcb_randr_add_output_mode_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	mode as xcb_randr_mode_t
end type

const XCB_RANDR_DELETE_OUTPUT_MODE_ = 19

type xcb_randr_delete_output_mode_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	output as xcb_randr_output_t
	mode as xcb_randr_mode_t
end type

type xcb_randr_get_crtc_info_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_CRTC_INFO_ = 20

type xcb_randr_get_crtc_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
	config_timestamp as xcb_timestamp_t
end type

type xcb_randr_get_crtc_info_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	x as short
	y as short
	width as ushort
	height as ushort
	mode as xcb_randr_mode_t
	rotation as ushort
	rotations as ushort
	num_outputs as ushort
	num_possible_outputs as ushort
end type

type xcb_randr_set_crtc_config_cookie_t
	sequence as ulong
end type

const XCB_RANDR_SET_CRTC_CONFIG_ = 21

type xcb_randr_set_crtc_config_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	x as short
	y as short
	mode as xcb_randr_mode_t
	rotation as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_randr_set_crtc_config_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	pad0(0 to 19) as ubyte
end type

type xcb_randr_get_crtc_gamma_size_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_CRTC_GAMMA_SIZE_ = 22

type xcb_randr_get_crtc_gamma_size_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
end type

type xcb_randr_get_crtc_gamma_size_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	size as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_randr_get_crtc_gamma_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_CRTC_GAMMA_ = 23

type xcb_randr_get_crtc_gamma_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
end type

type xcb_randr_get_crtc_gamma_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	size as ushort
	pad1(0 to 21) as ubyte
end type

const XCB_RANDR_SET_CRTC_GAMMA_ = 24

type xcb_randr_set_crtc_gamma_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
	size as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_randr_get_screen_resources_current_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_SCREEN_RESOURCES_CURRENT_ = 25

type xcb_randr_get_screen_resources_current_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_randr_get_screen_resources_current_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	num_crtcs as ushort
	num_outputs as ushort
	num_modes as ushort
	names_len as ushort
	pad1(0 to 7) as ubyte
end type

type xcb_randr_transform_t as long
enum
	XCB_RANDR_TRANSFORM_UNIT = 1
	XCB_RANDR_TRANSFORM_SCALE_UP = 2
	XCB_RANDR_TRANSFORM_SCALE_DOWN = 4
	XCB_RANDR_TRANSFORM_PROJECTIVE = 8
end enum

const XCB_RANDR_SET_CRTC_TRANSFORM_ = 26

type xcb_randr_set_crtc_transform_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
	transform as xcb_render_transform_t
	filter_len as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_randr_get_crtc_transform_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_CRTC_TRANSFORM_ = 27

type xcb_randr_get_crtc_transform_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
end type

type xcb_randr_get_crtc_transform_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pending_transform as xcb_render_transform_t
	has_transforms as ubyte
	pad1(0 to 2) as ubyte
	current_transform as xcb_render_transform_t
	pad2(0 to 3) as ubyte
	pending_len as ushort
	pending_nparams as ushort
	current_len as ushort
	current_nparams as ushort
end type

type xcb_randr_get_panning_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_PANNING_ = 28

type xcb_randr_get_panning_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
end type

type xcb_randr_get_panning_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	left as ushort
	top as ushort
	width as ushort
	height as ushort
	track_left as ushort
	track_top as ushort
	track_width as ushort
	track_height as ushort
	border_left as short
	border_top as short
	border_right as short
	border_bottom as short
end type

type xcb_randr_set_panning_cookie_t
	sequence as ulong
end type

const XCB_RANDR_SET_PANNING_ = 29

type xcb_randr_set_panning_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	crtc as xcb_randr_crtc_t
	timestamp as xcb_timestamp_t
	left as ushort
	top as ushort
	width as ushort
	height as ushort
	track_left as ushort
	track_top as ushort
	track_width as ushort
	track_height as ushort
	border_left as short
	border_top as short
	border_right as short
	border_bottom as short
end type

type xcb_randr_set_panning_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
end type

const XCB_RANDR_SET_OUTPUT_PRIMARY_ = 30

type xcb_randr_set_output_primary_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
	output as xcb_randr_output_t
end type

type xcb_randr_get_output_primary_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_OUTPUT_PRIMARY_ = 31

type xcb_randr_get_output_primary_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_randr_get_output_primary_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	output as xcb_randr_output_t
end type

type xcb_randr_get_providers_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_PROVIDERS_ = 32

type xcb_randr_get_providers_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	window as xcb_window_t
end type

type xcb_randr_get_providers_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	num_providers as ushort
	pad1(0 to 17) as ubyte
end type

type xcb_randr_provider_capability_t as long
enum
	XCB_RANDR_PROVIDER_CAPABILITY_SOURCE_OUTPUT = 1
	XCB_RANDR_PROVIDER_CAPABILITY_SINK_OUTPUT = 2
	XCB_RANDR_PROVIDER_CAPABILITY_SOURCE_OFFLOAD = 4
	XCB_RANDR_PROVIDER_CAPABILITY_SINK_OFFLOAD = 8
end enum

type xcb_randr_get_provider_info_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_PROVIDER_INFO_ = 33

type xcb_randr_get_provider_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	config_timestamp as xcb_timestamp_t
end type

type xcb_randr_get_provider_info_reply_t
	response_type as ubyte
	status as ubyte
	sequence as ushort
	length as ulong
	timestamp as xcb_timestamp_t
	capabilities as ulong
	num_crtcs as ushort
	num_outputs as ushort
	num_associated_providers as ushort
	name_len as ushort
	pad0(0 to 7) as ubyte
end type

const XCB_RANDR_SET_PROVIDER_OFFLOAD_SINK_ = 34

type xcb_randr_set_provider_offload_sink_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	sink_provider as xcb_randr_provider_t
	config_timestamp as xcb_timestamp_t
end type

const XCB_RANDR_SET_PROVIDER_OUTPUT_SOURCE_ = 35

type xcb_randr_set_provider_output_source_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	source_provider as xcb_randr_provider_t
	config_timestamp as xcb_timestamp_t
end type

type xcb_randr_list_provider_properties_cookie_t
	sequence as ulong
end type

const XCB_RANDR_LIST_PROVIDER_PROPERTIES_ = 36

type xcb_randr_list_provider_properties_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
end type

type xcb_randr_list_provider_properties_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_atoms as ushort
	pad1(0 to 21) as ubyte
end type

type xcb_randr_query_provider_property_cookie_t
	sequence as ulong
end type

const XCB_RANDR_QUERY_PROVIDER_PROPERTY_ = 37

type xcb_randr_query_provider_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	property as xcb_atom_t
end type

type xcb_randr_query_provider_property_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pending as ubyte
	range as ubyte
	immutable as ubyte
	pad1(0 to 20) as ubyte
end type

const XCB_RANDR_CONFIGURE_PROVIDER_PROPERTY_ = 38

type xcb_randr_configure_provider_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	property as xcb_atom_t
	pending as ubyte
	range as ubyte
	pad0(0 to 1) as ubyte
end type

const XCB_RANDR_CHANGE_PROVIDER_PROPERTY_ = 39

type xcb_randr_change_provider_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	property as xcb_atom_t
	as xcb_atom_t type
	format as ubyte
	mode as ubyte
	pad0(0 to 1) as ubyte
	num_items as ulong
end type

const XCB_RANDR_DELETE_PROVIDER_PROPERTY_ = 40

type xcb_randr_delete_provider_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	property as xcb_atom_t
end type

type xcb_randr_get_provider_property_cookie_t
	sequence as ulong
end type

const XCB_RANDR_GET_PROVIDER_PROPERTY_ = 41

type xcb_randr_get_provider_property_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	provider as xcb_randr_provider_t
	property as xcb_atom_t
	as xcb_atom_t type
	long_offset as ulong
	long_length as ulong
	_delete as ubyte
	pending as ubyte
	pad0(0 to 1) as ubyte
end type

type xcb_randr_get_provider_property_reply_t
	response_type as ubyte
	format as ubyte
	sequence as ushort
	length as ulong
	as xcb_atom_t type
	bytes_after as ulong
	num_items as ulong
	pad0(0 to 11) as ubyte
end type

const XCB_RANDR_SCREEN_CHANGE_NOTIFY = 0

type xcb_randr_screen_change_notify_event_t
	response_type as ubyte
	rotation as ubyte
	sequence as ushort
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	root as xcb_window_t
	request_window as xcb_window_t
	sizeID as ushort
	subpixel_order as ushort
	width as ushort
	height as ushort
	mwidth as ushort
	mheight as ushort
end type

type xcb_randr_notify_t as long
enum
	XCB_RANDR_NOTIFY_CRTC_CHANGE = 0
	XCB_RANDR_NOTIFY_OUTPUT_CHANGE = 1
	XCB_RANDR_NOTIFY_OUTPUT_PROPERTY = 2
	XCB_RANDR_NOTIFY_PROVIDER_CHANGE = 3
	XCB_RANDR_NOTIFY_PROVIDER_PROPERTY = 4
	XCB_RANDR_NOTIFY_RESOURCE_CHANGE = 5
end enum

type xcb_randr_crtc_change_t
	timestamp as xcb_timestamp_t
	window as xcb_window_t
	crtc as xcb_randr_crtc_t
	mode as xcb_randr_mode_t
	rotation as ushort
	pad0(0 to 1) as ubyte
	x as short
	y as short
	width as ushort
	height as ushort
end type

type xcb_randr_crtc_change_iterator_t
	data as xcb_randr_crtc_change_t ptr
	as long rem
	index as long
end type

type xcb_randr_output_change_t
	timestamp as xcb_timestamp_t
	config_timestamp as xcb_timestamp_t
	window as xcb_window_t
	output as xcb_randr_output_t
	crtc as xcb_randr_crtc_t
	mode as xcb_randr_mode_t
	rotation as ushort
	connection as ubyte
	subpixel_order as ubyte
end type

type xcb_randr_output_change_iterator_t
	data as xcb_randr_output_change_t ptr
	as long rem
	index as long
end type

type xcb_randr_output_property_t
	window as xcb_window_t
	output as xcb_randr_output_t
	atom as xcb_atom_t
	timestamp as xcb_timestamp_t
	status as ubyte
	pad0(0 to 10) as ubyte
end type

type xcb_randr_output_property_iterator_t
	data as xcb_randr_output_property_t ptr
	as long rem
	index as long
end type

type xcb_randr_provider_change_t
	timestamp as xcb_timestamp_t
	window as xcb_window_t
	provider as xcb_randr_provider_t
	pad0(0 to 15) as ubyte
end type

type xcb_randr_provider_change_iterator_t
	data as xcb_randr_provider_change_t ptr
	as long rem
	index as long
end type

type xcb_randr_provider_property_t
	window as xcb_window_t
	provider as xcb_randr_provider_t
	atom as xcb_atom_t
	timestamp as xcb_timestamp_t
	state as ubyte
	pad0(0 to 10) as ubyte
end type

type xcb_randr_provider_property_iterator_t
	data as xcb_randr_provider_property_t ptr
	as long rem
	index as long
end type

type xcb_randr_resource_change_t
	timestamp as xcb_timestamp_t
	window as xcb_window_t
	pad0(0 to 19) as ubyte
end type

type xcb_randr_resource_change_iterator_t
	data as xcb_randr_resource_change_t ptr
	as long rem
	index as long
end type

union xcb_randr_notify_data_t
	cc as xcb_randr_crtc_change_t
	oc as xcb_randr_output_change_t
	op as xcb_randr_output_property_t
	pc as xcb_randr_provider_change_t
	pp as xcb_randr_provider_property_t
	rc as xcb_randr_resource_change_t
end union

type xcb_randr_notify_data_iterator_t
	data as xcb_randr_notify_data_t ptr
	as long rem
	index as long
end type

const XCB_RANDR_NOTIFY = 1

type xcb_randr_notify_event_t
	response_type as ubyte
	subCode as ubyte
	sequence as ushort
	u as xcb_randr_notify_data_t
end type

declare sub xcb_randr_mode_next(byval i as xcb_randr_mode_iterator_t ptr)
declare function xcb_randr_mode_end(byval i as xcb_randr_mode_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_crtc_next(byval i as xcb_randr_crtc_iterator_t ptr)
declare function xcb_randr_crtc_end(byval i as xcb_randr_crtc_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_output_next(byval i as xcb_randr_output_iterator_t ptr)
declare function xcb_randr_output_end(byval i as xcb_randr_output_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_provider_next(byval i as xcb_randr_provider_iterator_t ptr)
declare function xcb_randr_provider_end(byval i as xcb_randr_provider_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_screen_size_next(byval i as xcb_randr_screen_size_iterator_t ptr)
declare function xcb_randr_screen_size_end(byval i as xcb_randr_screen_size_iterator_t) as xcb_generic_iterator_t
declare function xcb_randr_refresh_rates_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_refresh_rates_rates(byval R as const xcb_randr_refresh_rates_t ptr) as ushort ptr
declare function xcb_randr_refresh_rates_rates_length(byval R as const xcb_randr_refresh_rates_t ptr) as long
declare function xcb_randr_refresh_rates_rates_end(byval R as const xcb_randr_refresh_rates_t ptr) as xcb_generic_iterator_t
declare sub xcb_randr_refresh_rates_next(byval i as xcb_randr_refresh_rates_iterator_t ptr)
declare function xcb_randr_refresh_rates_end(byval i as xcb_randr_refresh_rates_iterator_t) as xcb_generic_iterator_t
declare function xcb_randr_query_version(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_randr_query_version_cookie_t
declare function xcb_randr_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_randr_query_version_cookie_t
declare function xcb_randr_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_query_version_reply_t ptr
declare function xcb_randr_set_screen_config(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval timestamp as xcb_timestamp_t, byval config_timestamp as xcb_timestamp_t, byval sizeID as ushort, byval rotation as ushort, byval rate as ushort) as xcb_randr_set_screen_config_cookie_t
declare function xcb_randr_set_screen_config_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval timestamp as xcb_timestamp_t, byval config_timestamp as xcb_timestamp_t, byval sizeID as ushort, byval rotation as ushort, byval rate as ushort) as xcb_randr_set_screen_config_cookie_t
declare function xcb_randr_set_screen_config_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_set_screen_config_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_set_screen_config_reply_t ptr
declare function xcb_randr_select_input_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval enable as ushort) as xcb_void_cookie_t
declare function xcb_randr_select_input(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval enable as ushort) as xcb_void_cookie_t
declare function xcb_randr_get_screen_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_screen_info(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_info_cookie_t
declare function xcb_randr_get_screen_info_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_info_cookie_t
declare function xcb_randr_get_screen_info_sizes(byval R as const xcb_randr_get_screen_info_reply_t ptr) as xcb_randr_screen_size_t ptr
declare function xcb_randr_get_screen_info_sizes_length(byval R as const xcb_randr_get_screen_info_reply_t ptr) as long
declare function xcb_randr_get_screen_info_sizes_iterator(byval R as const xcb_randr_get_screen_info_reply_t ptr) as xcb_randr_screen_size_iterator_t
declare function xcb_randr_get_screen_info_rates_length(byval R as const xcb_randr_get_screen_info_reply_t ptr) as long
declare function xcb_randr_get_screen_info_rates_iterator(byval R as const xcb_randr_get_screen_info_reply_t ptr) as xcb_randr_refresh_rates_iterator_t
declare function xcb_randr_get_screen_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_screen_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_screen_info_reply_t ptr
declare function xcb_randr_get_screen_size_range(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_size_range_cookie_t
declare function xcb_randr_get_screen_size_range_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_size_range_cookie_t
declare function xcb_randr_get_screen_size_range_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_screen_size_range_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_screen_size_range_reply_t ptr
declare function xcb_randr_set_screen_size_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval width as ushort, byval height as ushort, byval mm_width as ulong, byval mm_height as ulong) as xcb_void_cookie_t
declare function xcb_randr_set_screen_size(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval width as ushort, byval height as ushort, byval mm_width as ulong, byval mm_height as ulong) as xcb_void_cookie_t
declare sub xcb_randr_mode_info_next(byval i as xcb_randr_mode_info_iterator_t ptr)
declare function xcb_randr_mode_info_end(byval i as xcb_randr_mode_info_iterator_t) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_screen_resources(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_resources_cookie_t
declare function xcb_randr_get_screen_resources_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_resources_cookie_t
declare function xcb_randr_get_screen_resources_crtcs(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_randr_crtc_t ptr
declare function xcb_randr_get_screen_resources_crtcs_length(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_crtcs_end(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_outputs(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_randr_output_t ptr
declare function xcb_randr_get_screen_resources_outputs_length(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_outputs_end(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_modes(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_randr_mode_info_t ptr
declare function xcb_randr_get_screen_resources_modes_length(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_modes_iterator(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_randr_mode_info_iterator_t
declare function xcb_randr_get_screen_resources_names(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as ubyte ptr
declare function xcb_randr_get_screen_resources_names_length(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_names_end(byval R as const xcb_randr_get_screen_resources_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_screen_resources_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_screen_resources_reply_t ptr
declare function xcb_randr_get_output_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_output_info(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval config_timestamp as xcb_timestamp_t) as xcb_randr_get_output_info_cookie_t
declare function xcb_randr_get_output_info_unchecked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval config_timestamp as xcb_timestamp_t) as xcb_randr_get_output_info_cookie_t
declare function xcb_randr_get_output_info_crtcs(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_randr_crtc_t ptr
declare function xcb_randr_get_output_info_crtcs_length(byval R as const xcb_randr_get_output_info_reply_t ptr) as long
declare function xcb_randr_get_output_info_crtcs_end(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_output_info_modes(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_randr_mode_t ptr
declare function xcb_randr_get_output_info_modes_length(byval R as const xcb_randr_get_output_info_reply_t ptr) as long
declare function xcb_randr_get_output_info_modes_end(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_output_info_clones(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_randr_output_t ptr
declare function xcb_randr_get_output_info_clones_length(byval R as const xcb_randr_get_output_info_reply_t ptr) as long
declare function xcb_randr_get_output_info_clones_end(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_output_info_name(byval R as const xcb_randr_get_output_info_reply_t ptr) as ubyte ptr
declare function xcb_randr_get_output_info_name_length(byval R as const xcb_randr_get_output_info_reply_t ptr) as long
declare function xcb_randr_get_output_info_name_end(byval R as const xcb_randr_get_output_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_output_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_output_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_output_info_reply_t ptr
declare function xcb_randr_list_output_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_list_output_properties(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t) as xcb_randr_list_output_properties_cookie_t
declare function xcb_randr_list_output_properties_unchecked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t) as xcb_randr_list_output_properties_cookie_t
declare function xcb_randr_list_output_properties_atoms(byval R as const xcb_randr_list_output_properties_reply_t ptr) as xcb_atom_t ptr
declare function xcb_randr_list_output_properties_atoms_length(byval R as const xcb_randr_list_output_properties_reply_t ptr) as long
declare function xcb_randr_list_output_properties_atoms_end(byval R as const xcb_randr_list_output_properties_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_list_output_properties_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_list_output_properties_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_list_output_properties_reply_t ptr
declare function xcb_randr_query_output_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_query_output_property(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t) as xcb_randr_query_output_property_cookie_t
declare function xcb_randr_query_output_property_unchecked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t) as xcb_randr_query_output_property_cookie_t
declare function xcb_randr_query_output_property_valid_values(byval R as const xcb_randr_query_output_property_reply_t ptr) as long ptr
declare function xcb_randr_query_output_property_valid_values_length(byval R as const xcb_randr_query_output_property_reply_t ptr) as long
declare function xcb_randr_query_output_property_valid_values_end(byval R as const xcb_randr_query_output_property_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_query_output_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_query_output_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_query_output_property_reply_t ptr
declare function xcb_randr_configure_output_property_sizeof(byval _buffer as const any ptr, byval values_len as ulong) as long
declare function xcb_randr_configure_output_property_checked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t, byval pending as ubyte, byval range as ubyte, byval values_len as ulong, byval values as const long ptr) as xcb_void_cookie_t
declare function xcb_randr_configure_output_property(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t, byval pending as ubyte, byval range as ubyte, byval values_len as ulong, byval values as const long ptr) as xcb_void_cookie_t
declare function xcb_randr_change_output_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_change_output_property_checked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval format as ubyte, byval mode as ubyte, byval num_units as ulong, byval data as const any ptr) as xcb_void_cookie_t
declare function xcb_randr_change_output_property(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval format as ubyte, byval mode as ubyte, byval num_units as ulong, byval data as const any ptr) as xcb_void_cookie_t
declare function xcb_randr_delete_output_property_checked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_randr_delete_output_property(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_randr_get_output_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_output_property(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval long_offset as ulong, byval long_length as ulong, byval _delete as ubyte, byval pending as ubyte) as xcb_randr_get_output_property_cookie_t
declare function xcb_randr_get_output_property_unchecked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval long_offset as ulong, byval long_length as ulong, byval _delete as ubyte, byval pending as ubyte) as xcb_randr_get_output_property_cookie_t
declare function xcb_randr_get_output_property_data(byval R as const xcb_randr_get_output_property_reply_t ptr) as ubyte ptr
declare function xcb_randr_get_output_property_data_length(byval R as const xcb_randr_get_output_property_reply_t ptr) as long
declare function xcb_randr_get_output_property_data_end(byval R as const xcb_randr_get_output_property_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_output_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_output_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_output_property_reply_t ptr
declare function xcb_randr_create_mode_sizeof(byval _buffer as const any ptr, byval name_len as ulong) as long
declare function xcb_randr_create_mode(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval mode_info as xcb_randr_mode_info_t, byval name_len as ulong, byval name as const zstring ptr) as xcb_randr_create_mode_cookie_t
declare function xcb_randr_create_mode_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval mode_info as xcb_randr_mode_info_t, byval name_len as ulong, byval name as const zstring ptr) as xcb_randr_create_mode_cookie_t
declare function xcb_randr_create_mode_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_create_mode_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_create_mode_reply_t ptr
declare function xcb_randr_destroy_mode_checked(byval c as xcb_connection_t ptr, byval mode as xcb_randr_mode_t) as xcb_void_cookie_t
declare function xcb_randr_destroy_mode(byval c as xcb_connection_t ptr, byval mode as xcb_randr_mode_t) as xcb_void_cookie_t
declare function xcb_randr_add_output_mode_checked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval mode as xcb_randr_mode_t) as xcb_void_cookie_t
declare function xcb_randr_add_output_mode(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval mode as xcb_randr_mode_t) as xcb_void_cookie_t
declare function xcb_randr_delete_output_mode_checked(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval mode as xcb_randr_mode_t) as xcb_void_cookie_t
declare function xcb_randr_delete_output_mode(byval c as xcb_connection_t ptr, byval output as xcb_randr_output_t, byval mode as xcb_randr_mode_t) as xcb_void_cookie_t
declare function xcb_randr_get_crtc_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_crtc_info(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval config_timestamp as xcb_timestamp_t) as xcb_randr_get_crtc_info_cookie_t
declare function xcb_randr_get_crtc_info_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval config_timestamp as xcb_timestamp_t) as xcb_randr_get_crtc_info_cookie_t
declare function xcb_randr_get_crtc_info_outputs(byval R as const xcb_randr_get_crtc_info_reply_t ptr) as xcb_randr_output_t ptr
declare function xcb_randr_get_crtc_info_outputs_length(byval R as const xcb_randr_get_crtc_info_reply_t ptr) as long
declare function xcb_randr_get_crtc_info_outputs_end(byval R as const xcb_randr_get_crtc_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_info_possible(byval R as const xcb_randr_get_crtc_info_reply_t ptr) as xcb_randr_output_t ptr
declare function xcb_randr_get_crtc_info_possible_length(byval R as const xcb_randr_get_crtc_info_reply_t ptr) as long
declare function xcb_randr_get_crtc_info_possible_end(byval R as const xcb_randr_get_crtc_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_crtc_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_crtc_info_reply_t ptr
declare function xcb_randr_set_crtc_config_sizeof(byval _buffer as const any ptr, byval outputs_len as ulong) as long
declare function xcb_randr_set_crtc_config(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval timestamp as xcb_timestamp_t, byval config_timestamp as xcb_timestamp_t, byval x as short, byval y as short, byval mode as xcb_randr_mode_t, byval rotation as ushort, byval outputs_len as ulong, byval outputs as const xcb_randr_output_t ptr) as xcb_randr_set_crtc_config_cookie_t
declare function xcb_randr_set_crtc_config_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval timestamp as xcb_timestamp_t, byval config_timestamp as xcb_timestamp_t, byval x as short, byval y as short, byval mode as xcb_randr_mode_t, byval rotation as ushort, byval outputs_len as ulong, byval outputs as const xcb_randr_output_t ptr) as xcb_randr_set_crtc_config_cookie_t
declare function xcb_randr_set_crtc_config_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_set_crtc_config_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_set_crtc_config_reply_t ptr
declare function xcb_randr_get_crtc_gamma_size(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_crtc_gamma_size_cookie_t
declare function xcb_randr_get_crtc_gamma_size_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_crtc_gamma_size_cookie_t
declare function xcb_randr_get_crtc_gamma_size_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_crtc_gamma_size_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_crtc_gamma_size_reply_t ptr
declare function xcb_randr_get_crtc_gamma_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_crtc_gamma(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_crtc_gamma_cookie_t
declare function xcb_randr_get_crtc_gamma_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_crtc_gamma_cookie_t
declare function xcb_randr_get_crtc_gamma_red(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as ushort ptr
declare function xcb_randr_get_crtc_gamma_red_length(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as long
declare function xcb_randr_get_crtc_gamma_red_end(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_gamma_green(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as ushort ptr
declare function xcb_randr_get_crtc_gamma_green_length(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as long
declare function xcb_randr_get_crtc_gamma_green_end(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_gamma_blue(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as ushort ptr
declare function xcb_randr_get_crtc_gamma_blue_length(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as long
declare function xcb_randr_get_crtc_gamma_blue_end(byval R as const xcb_randr_get_crtc_gamma_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_gamma_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_crtc_gamma_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_crtc_gamma_reply_t ptr
declare function xcb_randr_set_crtc_gamma_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_set_crtc_gamma_checked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval size as ushort, byval red as const ushort ptr, byval green as const ushort ptr, byval blue as const ushort ptr) as xcb_void_cookie_t
declare function xcb_randr_set_crtc_gamma(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval size as ushort, byval red as const ushort ptr, byval green as const ushort ptr, byval blue as const ushort ptr) as xcb_void_cookie_t
declare function xcb_randr_get_screen_resources_current_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_screen_resources_current(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_resources_current_cookie_t
declare function xcb_randr_get_screen_resources_current_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_screen_resources_current_cookie_t
declare function xcb_randr_get_screen_resources_current_crtcs(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_randr_crtc_t ptr
declare function xcb_randr_get_screen_resources_current_crtcs_length(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_current_crtcs_end(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_current_outputs(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_randr_output_t ptr
declare function xcb_randr_get_screen_resources_current_outputs_length(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_current_outputs_end(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_current_modes(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_randr_mode_info_t ptr
declare function xcb_randr_get_screen_resources_current_modes_length(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_current_modes_iterator(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_randr_mode_info_iterator_t
declare function xcb_randr_get_screen_resources_current_names(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as ubyte ptr
declare function xcb_randr_get_screen_resources_current_names_length(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as long
declare function xcb_randr_get_screen_resources_current_names_end(byval R as const xcb_randr_get_screen_resources_current_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_screen_resources_current_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_screen_resources_current_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_screen_resources_current_reply_t ptr
declare function xcb_randr_set_crtc_transform_sizeof(byval _buffer as const any ptr, byval filter_params_len as ulong) as long
declare function xcb_randr_set_crtc_transform_checked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval transform as xcb_render_transform_t, byval filter_len as ushort, byval filter_name as const zstring ptr, byval filter_params_len as ulong, byval filter_params as const xcb_render_fixed_t ptr) as xcb_void_cookie_t
declare function xcb_randr_set_crtc_transform(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval transform as xcb_render_transform_t, byval filter_len as ushort, byval filter_name as const zstring ptr, byval filter_params_len as ulong, byval filter_params as const xcb_render_fixed_t ptr) as xcb_void_cookie_t
declare function xcb_randr_get_crtc_transform_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_crtc_transform(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_crtc_transform_cookie_t
declare function xcb_randr_get_crtc_transform_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_crtc_transform_cookie_t
declare function xcb_randr_get_crtc_transform_pending_filter_name(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as zstring ptr
declare function xcb_randr_get_crtc_transform_pending_filter_name_length(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as long
declare function xcb_randr_get_crtc_transform_pending_filter_name_end(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_transform_pending_params(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as xcb_render_fixed_t ptr
declare function xcb_randr_get_crtc_transform_pending_params_length(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as long
declare function xcb_randr_get_crtc_transform_pending_params_end(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_transform_current_filter_name(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as zstring ptr
declare function xcb_randr_get_crtc_transform_current_filter_name_length(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as long
declare function xcb_randr_get_crtc_transform_current_filter_name_end(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_transform_current_params(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as xcb_render_fixed_t ptr
declare function xcb_randr_get_crtc_transform_current_params_length(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as long
declare function xcb_randr_get_crtc_transform_current_params_end(byval R as const xcb_randr_get_crtc_transform_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_crtc_transform_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_crtc_transform_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_crtc_transform_reply_t ptr
declare function xcb_randr_get_panning(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_panning_cookie_t
declare function xcb_randr_get_panning_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t) as xcb_randr_get_panning_cookie_t
declare function xcb_randr_get_panning_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_panning_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_panning_reply_t ptr
declare function xcb_randr_set_panning(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval timestamp as xcb_timestamp_t, byval left as ushort, byval top as ushort, byval width as ushort, byval height as ushort, byval track_left as ushort, byval track_top as ushort, byval track_width as ushort, byval track_height as ushort, byval border_left as short, byval border_top as short, byval border_right as short, byval border_bottom as short) as xcb_randr_set_panning_cookie_t
declare function xcb_randr_set_panning_unchecked(byval c as xcb_connection_t ptr, byval crtc as xcb_randr_crtc_t, byval timestamp as xcb_timestamp_t, byval left as ushort, byval top as ushort, byval width as ushort, byval height as ushort, byval track_left as ushort, byval track_top as ushort, byval track_width as ushort, byval track_height as ushort, byval border_left as short, byval border_top as short, byval border_right as short, byval border_bottom as short) as xcb_randr_set_panning_cookie_t
declare function xcb_randr_set_panning_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_set_panning_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_set_panning_reply_t ptr
declare function xcb_randr_set_output_primary_checked(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval output as xcb_randr_output_t) as xcb_void_cookie_t
declare function xcb_randr_set_output_primary(byval c as xcb_connection_t ptr, byval window as xcb_window_t, byval output as xcb_randr_output_t) as xcb_void_cookie_t
declare function xcb_randr_get_output_primary(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_output_primary_cookie_t
declare function xcb_randr_get_output_primary_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_output_primary_cookie_t
declare function xcb_randr_get_output_primary_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_output_primary_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_output_primary_reply_t ptr
declare function xcb_randr_get_providers_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_providers(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_providers_cookie_t
declare function xcb_randr_get_providers_unchecked(byval c as xcb_connection_t ptr, byval window as xcb_window_t) as xcb_randr_get_providers_cookie_t
declare function xcb_randr_get_providers_providers(byval R as const xcb_randr_get_providers_reply_t ptr) as xcb_randr_provider_t ptr
declare function xcb_randr_get_providers_providers_length(byval R as const xcb_randr_get_providers_reply_t ptr) as long
declare function xcb_randr_get_providers_providers_end(byval R as const xcb_randr_get_providers_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_providers_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_providers_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_providers_reply_t ptr
declare function xcb_randr_get_provider_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_provider_info(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval config_timestamp as xcb_timestamp_t) as xcb_randr_get_provider_info_cookie_t
declare function xcb_randr_get_provider_info_unchecked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval config_timestamp as xcb_timestamp_t) as xcb_randr_get_provider_info_cookie_t
declare function xcb_randr_get_provider_info_crtcs(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_randr_crtc_t ptr
declare function xcb_randr_get_provider_info_crtcs_length(byval R as const xcb_randr_get_provider_info_reply_t ptr) as long
declare function xcb_randr_get_provider_info_crtcs_end(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_provider_info_outputs(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_randr_output_t ptr
declare function xcb_randr_get_provider_info_outputs_length(byval R as const xcb_randr_get_provider_info_reply_t ptr) as long
declare function xcb_randr_get_provider_info_outputs_end(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_provider_info_associated_providers(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_randr_provider_t ptr
declare function xcb_randr_get_provider_info_associated_providers_length(byval R as const xcb_randr_get_provider_info_reply_t ptr) as long
declare function xcb_randr_get_provider_info_associated_providers_end(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_provider_info_associated_capability(byval R as const xcb_randr_get_provider_info_reply_t ptr) as ulong ptr
declare function xcb_randr_get_provider_info_associated_capability_length(byval R as const xcb_randr_get_provider_info_reply_t ptr) as long
declare function xcb_randr_get_provider_info_associated_capability_end(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_provider_info_name(byval R as const xcb_randr_get_provider_info_reply_t ptr) as zstring ptr
declare function xcb_randr_get_provider_info_name_length(byval R as const xcb_randr_get_provider_info_reply_t ptr) as long
declare function xcb_randr_get_provider_info_name_end(byval R as const xcb_randr_get_provider_info_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_provider_info_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_provider_info_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_provider_info_reply_t ptr
declare function xcb_randr_set_provider_offload_sink_checked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval sink_provider as xcb_randr_provider_t, byval config_timestamp as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_randr_set_provider_offload_sink(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval sink_provider as xcb_randr_provider_t, byval config_timestamp as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_randr_set_provider_output_source_checked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval source_provider as xcb_randr_provider_t, byval config_timestamp as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_randr_set_provider_output_source(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval source_provider as xcb_randr_provider_t, byval config_timestamp as xcb_timestamp_t) as xcb_void_cookie_t
declare function xcb_randr_list_provider_properties_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_list_provider_properties(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t) as xcb_randr_list_provider_properties_cookie_t
declare function xcb_randr_list_provider_properties_unchecked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t) as xcb_randr_list_provider_properties_cookie_t
declare function xcb_randr_list_provider_properties_atoms(byval R as const xcb_randr_list_provider_properties_reply_t ptr) as xcb_atom_t ptr
declare function xcb_randr_list_provider_properties_atoms_length(byval R as const xcb_randr_list_provider_properties_reply_t ptr) as long
declare function xcb_randr_list_provider_properties_atoms_end(byval R as const xcb_randr_list_provider_properties_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_list_provider_properties_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_list_provider_properties_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_list_provider_properties_reply_t ptr
declare function xcb_randr_query_provider_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_query_provider_property(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t) as xcb_randr_query_provider_property_cookie_t
declare function xcb_randr_query_provider_property_unchecked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t) as xcb_randr_query_provider_property_cookie_t
declare function xcb_randr_query_provider_property_valid_values(byval R as const xcb_randr_query_provider_property_reply_t ptr) as long ptr
declare function xcb_randr_query_provider_property_valid_values_length(byval R as const xcb_randr_query_provider_property_reply_t ptr) as long
declare function xcb_randr_query_provider_property_valid_values_end(byval R as const xcb_randr_query_provider_property_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_query_provider_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_query_provider_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_query_provider_property_reply_t ptr
declare function xcb_randr_configure_provider_property_sizeof(byval _buffer as const any ptr, byval values_len as ulong) as long
declare function xcb_randr_configure_provider_property_checked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t, byval pending as ubyte, byval range as ubyte, byval values_len as ulong, byval values as const long ptr) as xcb_void_cookie_t
declare function xcb_randr_configure_provider_property(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t, byval pending as ubyte, byval range as ubyte, byval values_len as ulong, byval values as const long ptr) as xcb_void_cookie_t
declare function xcb_randr_change_provider_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_change_provider_property_checked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval format as ubyte, byval mode as ubyte, byval num_items as ulong, byval data as const any ptr) as xcb_void_cookie_t
declare function xcb_randr_change_provider_property(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval format as ubyte, byval mode as ubyte, byval num_items as ulong, byval data as const any ptr) as xcb_void_cookie_t
declare function xcb_randr_delete_provider_property_checked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_randr_delete_provider_property(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t) as xcb_void_cookie_t
declare function xcb_randr_get_provider_property_sizeof(byval _buffer as const any ptr) as long
declare function xcb_randr_get_provider_property(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval long_offset as ulong, byval long_length as ulong, byval _delete as ubyte, byval pending as ubyte) as xcb_randr_get_provider_property_cookie_t
declare function xcb_randr_get_provider_property_unchecked(byval c as xcb_connection_t ptr, byval provider as xcb_randr_provider_t, byval property as xcb_atom_t, byval type as xcb_atom_t, byval long_offset as ulong, byval long_length as ulong, byval _delete as ubyte, byval pending as ubyte) as xcb_randr_get_provider_property_cookie_t
declare function xcb_randr_get_provider_property_data(byval R as const xcb_randr_get_provider_property_reply_t ptr) as any ptr
declare function xcb_randr_get_provider_property_data_length(byval R as const xcb_randr_get_provider_property_reply_t ptr) as long
declare function xcb_randr_get_provider_property_data_end(byval R as const xcb_randr_get_provider_property_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_randr_get_provider_property_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_randr_get_provider_property_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_randr_get_provider_property_reply_t ptr
declare sub xcb_randr_crtc_change_next(byval i as xcb_randr_crtc_change_iterator_t ptr)
declare function xcb_randr_crtc_change_end(byval i as xcb_randr_crtc_change_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_output_change_next(byval i as xcb_randr_output_change_iterator_t ptr)
declare function xcb_randr_output_change_end(byval i as xcb_randr_output_change_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_output_property_next(byval i as xcb_randr_output_property_iterator_t ptr)
declare function xcb_randr_output_property_end(byval i as xcb_randr_output_property_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_provider_change_next(byval i as xcb_randr_provider_change_iterator_t ptr)
declare function xcb_randr_provider_change_end(byval i as xcb_randr_provider_change_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_provider_property_next(byval i as xcb_randr_provider_property_iterator_t ptr)
declare function xcb_randr_provider_property_end(byval i as xcb_randr_provider_property_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_resource_change_next(byval i as xcb_randr_resource_change_iterator_t ptr)
declare function xcb_randr_resource_change_end(byval i as xcb_randr_resource_change_iterator_t) as xcb_generic_iterator_t
declare sub xcb_randr_notify_data_next(byval i as xcb_randr_notify_data_iterator_t ptr)
declare function xcb_randr_notify_data_end(byval i as xcb_randr_notify_data_iterator_t) as xcb_generic_iterator_t

end extern
