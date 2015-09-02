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
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_GLX_RENDER => XCB_GLX_RENDER_
''     constant XCB_GLX_RENDER_LARGE => XCB_GLX_RENDER_LARGE_
''     constant XCB_GLX_CREATE_CONTEXT => XCB_GLX_CREATE_CONTEXT_
''     constant XCB_GLX_DESTROY_CONTEXT => XCB_GLX_DESTROY_CONTEXT_
''     constant XCB_GLX_MAKE_CURRENT => XCB_GLX_MAKE_CURRENT_
''     constant XCB_GLX_IS_DIRECT => XCB_GLX_IS_DIRECT_
''     constant XCB_GLX_QUERY_VERSION => XCB_GLX_QUERY_VERSION_
''     constant XCB_GLX_WAIT_GL => XCB_GLX_WAIT_GL_
''     constant XCB_GLX_WAIT_X => XCB_GLX_WAIT_X_
''     constant XCB_GLX_COPY_CONTEXT => XCB_GLX_COPY_CONTEXT_
''     constant XCB_GLX_SWAP_BUFFERS => XCB_GLX_SWAP_BUFFERS_
''     constant XCB_GLX_USE_X_FONT => XCB_GLX_USE_X_FONT_
''     constant XCB_GLX_CREATE_GLX_PIXMAP => XCB_GLX_CREATE_GLX_PIXMAP_
''     constant XCB_GLX_GET_VISUAL_CONFIGS => XCB_GLX_GET_VISUAL_CONFIGS_
''     constant XCB_GLX_DESTROY_GLX_PIXMAP => XCB_GLX_DESTROY_GLX_PIXMAP_
''     constant XCB_GLX_VENDOR_PRIVATE => XCB_GLX_VENDOR_PRIVATE_
''     constant XCB_GLX_VENDOR_PRIVATE_WITH_REPLY => XCB_GLX_VENDOR_PRIVATE_WITH_REPLY_
''     constant XCB_GLX_QUERY_EXTENSIONS_STRING => XCB_GLX_QUERY_EXTENSIONS_STRING_
''     constant XCB_GLX_QUERY_SERVER_STRING => XCB_GLX_QUERY_SERVER_STRING_
''     constant XCB_GLX_CLIENT_INFO => XCB_GLX_CLIENT_INFO_
''     constant XCB_GLX_GET_FB_CONFIGS => XCB_GLX_GET_FB_CONFIGS_
''     constant XCB_GLX_CREATE_PIXMAP => XCB_GLX_CREATE_PIXMAP_
''     constant XCB_GLX_DESTROY_PIXMAP => XCB_GLX_DESTROY_PIXMAP_
''     constant XCB_GLX_CREATE_NEW_CONTEXT => XCB_GLX_CREATE_NEW_CONTEXT_
''     constant XCB_GLX_QUERY_CONTEXT => XCB_GLX_QUERY_CONTEXT_
''     constant XCB_GLX_MAKE_CONTEXT_CURRENT => XCB_GLX_MAKE_CONTEXT_CURRENT_
''     constant XCB_GLX_CREATE_PBUFFER => XCB_GLX_CREATE_PBUFFER_
''     constant XCB_GLX_DESTROY_PBUFFER => XCB_GLX_DESTROY_PBUFFER_
''     constant XCB_GLX_GET_DRAWABLE_ATTRIBUTES => XCB_GLX_GET_DRAWABLE_ATTRIBUTES_
''     constant XCB_GLX_CHANGE_DRAWABLE_ATTRIBUTES => XCB_GLX_CHANGE_DRAWABLE_ATTRIBUTES_
''     constant XCB_GLX_CREATE_WINDOW => XCB_GLX_CREATE_WINDOW_
''     constant XCB_GLX_DELETE_WINDOW => XCB_GLX_DELETE_WINDOW_
''     constant XCB_GLX_SET_CLIENT_INFO_ARB => XCB_GLX_SET_CLIENT_INFO_ARB_
''     constant XCB_GLX_CREATE_CONTEXT_ATTRIBS_ARB => XCB_GLX_CREATE_CONTEXT_ATTRIBS_ARB_
''     constant XCB_GLX_SET_CLIENT_INFO_2ARB => XCB_GLX_SET_CLIENT_INFO_2ARB_
''     constant XCB_GLX_NEW_LIST => XCB_GLX_NEW_LIST_
''     constant XCB_GLX_END_LIST => XCB_GLX_END_LIST_
''     constant XCB_GLX_DELETE_LISTS => XCB_GLX_DELETE_LISTS_
''     constant XCB_GLX_GEN_LISTS => XCB_GLX_GEN_LISTS_
''     constant XCB_GLX_FEEDBACK_BUFFER => XCB_GLX_FEEDBACK_BUFFER_
''     constant XCB_GLX_SELECT_BUFFER => XCB_GLX_SELECT_BUFFER_
''     constant XCB_GLX_RENDER_MODE => XCB_GLX_RENDER_MODE_
''     constant XCB_GLX_FINISH => XCB_GLX_FINISH_
''     constant XCB_GLX_PIXEL_STOREF => XCB_GLX_PIXEL_STOREF_
''     constant XCB_GLX_PIXEL_STOREI => XCB_GLX_PIXEL_STOREI_
''     constant XCB_GLX_READ_PIXELS => XCB_GLX_READ_PIXELS_
''     constant XCB_GLX_GET_BOOLEANV => XCB_GLX_GET_BOOLEANV_
''     constant XCB_GLX_GET_CLIP_PLANE => XCB_GLX_GET_CLIP_PLANE_
''     constant XCB_GLX_GET_DOUBLEV => XCB_GLX_GET_DOUBLEV_
''     constant XCB_GLX_GET_ERROR => XCB_GLX_GET_ERROR_
''     constant XCB_GLX_GET_FLOATV => XCB_GLX_GET_FLOATV_
''     constant XCB_GLX_GET_INTEGERV => XCB_GLX_GET_INTEGERV_
''     constant XCB_GLX_GET_LIGHTFV => XCB_GLX_GET_LIGHTFV_
''     constant XCB_GLX_GET_LIGHTIV => XCB_GLX_GET_LIGHTIV_
''     constant XCB_GLX_GET_MAPDV => XCB_GLX_GET_MAPDV_
''     constant XCB_GLX_GET_MAPFV => XCB_GLX_GET_MAPFV_
''     constant XCB_GLX_GET_MAPIV => XCB_GLX_GET_MAPIV_
''     constant XCB_GLX_GET_MATERIALFV => XCB_GLX_GET_MATERIALFV_
''     constant XCB_GLX_GET_MATERIALIV => XCB_GLX_GET_MATERIALIV_
''     constant XCB_GLX_GET_PIXEL_MAPFV => XCB_GLX_GET_PIXEL_MAPFV_
''     constant XCB_GLX_GET_PIXEL_MAPUIV => XCB_GLX_GET_PIXEL_MAPUIV_
''     constant XCB_GLX_GET_PIXEL_MAPUSV => XCB_GLX_GET_PIXEL_MAPUSV_
''     constant XCB_GLX_GET_POLYGON_STIPPLE => XCB_GLX_GET_POLYGON_STIPPLE_
''     constant XCB_GLX_GET_STRING => XCB_GLX_GET_STRING_
''     constant XCB_GLX_GET_TEX_ENVFV => XCB_GLX_GET_TEX_ENVFV_
''     constant XCB_GLX_GET_TEX_ENVIV => XCB_GLX_GET_TEX_ENVIV_
''     constant XCB_GLX_GET_TEX_GENDV => XCB_GLX_GET_TEX_GENDV_
''     constant XCB_GLX_GET_TEX_GENFV => XCB_GLX_GET_TEX_GENFV_
''     constant XCB_GLX_GET_TEX_GENIV => XCB_GLX_GET_TEX_GENIV_
''     constant XCB_GLX_GET_TEX_IMAGE => XCB_GLX_GET_TEX_IMAGE_
''     constant XCB_GLX_GET_TEX_PARAMETERFV => XCB_GLX_GET_TEX_PARAMETERFV_
''     constant XCB_GLX_GET_TEX_PARAMETERIV => XCB_GLX_GET_TEX_PARAMETERIV_
''     constant XCB_GLX_GET_TEX_LEVEL_PARAMETERFV => XCB_GLX_GET_TEX_LEVEL_PARAMETERFV_
''     constant XCB_GLX_GET_TEX_LEVEL_PARAMETERIV => XCB_GLX_GET_TEX_LEVEL_PARAMETERIV_
''     constant XCB_GLX_IS_LIST => XCB_GLX_IS_LIST_
''     constant XCB_GLX_FLUSH => XCB_GLX_FLUSH_
''     constant XCB_GLX_ARE_TEXTURES_RESIDENT => XCB_GLX_ARE_TEXTURES_RESIDENT_
''     constant XCB_GLX_DELETE_TEXTURES => XCB_GLX_DELETE_TEXTURES_
''     constant XCB_GLX_GEN_TEXTURES => XCB_GLX_GEN_TEXTURES_
''     constant XCB_GLX_IS_TEXTURE => XCB_GLX_IS_TEXTURE_
''     constant XCB_GLX_GET_COLOR_TABLE => XCB_GLX_GET_COLOR_TABLE_
''     constant XCB_GLX_GET_COLOR_TABLE_PARAMETERFV => XCB_GLX_GET_COLOR_TABLE_PARAMETERFV_
''     constant XCB_GLX_GET_COLOR_TABLE_PARAMETERIV => XCB_GLX_GET_COLOR_TABLE_PARAMETERIV_
''     constant XCB_GLX_GET_CONVOLUTION_FILTER => XCB_GLX_GET_CONVOLUTION_FILTER_
''     constant XCB_GLX_GET_CONVOLUTION_PARAMETERFV => XCB_GLX_GET_CONVOLUTION_PARAMETERFV_
''     constant XCB_GLX_GET_CONVOLUTION_PARAMETERIV => XCB_GLX_GET_CONVOLUTION_PARAMETERIV_
''     constant XCB_GLX_GET_SEPARABLE_FILTER => XCB_GLX_GET_SEPARABLE_FILTER_
''     constant XCB_GLX_GET_HISTOGRAM => XCB_GLX_GET_HISTOGRAM_
''     constant XCB_GLX_GET_HISTOGRAM_PARAMETERFV => XCB_GLX_GET_HISTOGRAM_PARAMETERFV_
''     constant XCB_GLX_GET_HISTOGRAM_PARAMETERIV => XCB_GLX_GET_HISTOGRAM_PARAMETERIV_
''     constant XCB_GLX_GET_MINMAX => XCB_GLX_GET_MINMAX_
''     constant XCB_GLX_GET_MINMAX_PARAMETERFV => XCB_GLX_GET_MINMAX_PARAMETERFV_
''     constant XCB_GLX_GET_MINMAX_PARAMETERIV => XCB_GLX_GET_MINMAX_PARAMETERIV_
''     constant XCB_GLX_GET_COMPRESSED_TEX_IMAGE_ARB => XCB_GLX_GET_COMPRESSED_TEX_IMAGE_ARB_
''     constant XCB_GLX_DELETE_QUERIES_ARB => XCB_GLX_DELETE_QUERIES_ARB_
''     constant XCB_GLX_GEN_QUERIES_ARB => XCB_GLX_GEN_QUERIES_ARB_
''     constant XCB_GLX_IS_QUERY_ARB => XCB_GLX_IS_QUERY_ARB_
''     constant XCB_GLX_GET_QUERYIV_ARB => XCB_GLX_GET_QUERYIV_ARB_
''     constant XCB_GLX_GET_QUERY_OBJECTIV_ARB => XCB_GLX_GET_QUERY_OBJECTIV_ARB_
''     constant XCB_GLX_GET_QUERY_OBJECTUIV_ARB => XCB_GLX_GET_QUERY_OBJECTUIV_ARB_

extern "C"

#define __GLX_H
const XCB_GLX_MAJOR_VERSION = 1
const XCB_GLX_MINOR_VERSION = 4
extern xcb_glx_id as xcb_extension_t
type xcb_glx_pixmap_t as ulong

type xcb_glx_pixmap_iterator_t
	data as xcb_glx_pixmap_t ptr
	as long rem
	index as long
end type

type xcb_glx_context_t as ulong

type xcb_glx_context_iterator_t
	data as xcb_glx_context_t ptr
	as long rem
	index as long
end type

type xcb_glx_pbuffer_t as ulong

type xcb_glx_pbuffer_iterator_t
	data as xcb_glx_pbuffer_t ptr
	as long rem
	index as long
end type

type xcb_glx_window_t as ulong

type xcb_glx_window_iterator_t
	data as xcb_glx_window_t ptr
	as long rem
	index as long
end type

type xcb_glx_fbconfig_t as ulong

type xcb_glx_fbconfig_iterator_t
	data as xcb_glx_fbconfig_t ptr
	as long rem
	index as long
end type

type xcb_glx_drawable_t as ulong

type xcb_glx_drawable_iterator_t
	data as xcb_glx_drawable_t ptr
	as long rem
	index as long
end type

type xcb_glx_float32_t as single

type xcb_glx_float32_iterator_t
	data as xcb_glx_float32_t ptr
	as long rem
	index as long
end type

type xcb_glx_float64_t as double

type xcb_glx_float64_iterator_t
	data as xcb_glx_float64_t ptr
	as long rem
	index as long
end type

type xcb_glx_bool32_t as ulong

type xcb_glx_bool32_iterator_t
	data as xcb_glx_bool32_t ptr
	as long rem
	index as long
end type

type xcb_glx_context_tag_t as ulong

type xcb_glx_context_tag_iterator_t
	data as xcb_glx_context_tag_t ptr
	as long rem
	index as long
end type

const XCB_GLX_GENERIC = -1

type xcb_glx_generic_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
	bad_value as ulong
	minor_opcode as ushort
	major_opcode as ubyte
	pad0(0 to 20) as ubyte
end type

const XCB_GLX_BAD_CONTEXT = 0
type xcb_glx_bad_context_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_CONTEXT_STATE = 1
type xcb_glx_bad_context_state_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_DRAWABLE = 2
type xcb_glx_bad_drawable_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_PIXMAP = 3
type xcb_glx_bad_pixmap_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_CONTEXT_TAG = 4
type xcb_glx_bad_context_tag_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_CURRENT_WINDOW = 5
type xcb_glx_bad_current_window_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_RENDER_REQUEST = 6
type xcb_glx_bad_render_request_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_LARGE_REQUEST = 7
type xcb_glx_bad_large_request_error_t as xcb_glx_generic_error_t
const XCB_GLX_UNSUPPORTED_PRIVATE_REQUEST = 8
type xcb_glx_unsupported_private_request_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_FB_CONFIG = 9
type xcb_glx_bad_fb_config_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_PBUFFER = 10
type xcb_glx_bad_pbuffer_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_CURRENT_DRAWABLE = 11
type xcb_glx_bad_current_drawable_error_t as xcb_glx_generic_error_t
const XCB_GLX_BAD_WINDOW = 12
type xcb_glx_bad_window_error_t as xcb_glx_generic_error_t
const XCB_GLX_GLX_BAD_PROFILE_ARB = 13
type xcb_glx_glx_bad_profile_arb_error_t as xcb_glx_generic_error_t
const XCB_GLX_PBUFFER_CLOBBER = 0

type xcb_glx_pbuffer_clobber_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event_type as ushort
	draw_type as ushort
	drawable as xcb_glx_drawable_t
	b_mask as ulong
	aux_buffer as ushort
	x as ushort
	y as ushort
	width as ushort
	height as ushort
	count as ushort
	pad1(0 to 3) as ubyte
end type

const XCB_GLX_BUFFER_SWAP_COMPLETE = 1

type xcb_glx_buffer_swap_complete_event_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	event_type as ushort
	pad1(0 to 1) as ubyte
	drawable as xcb_glx_drawable_t
	ust_hi as ulong
	ust_lo as ulong
	msc_hi as ulong
	msc_lo as ulong
	sbc as ulong
end type

type xcb_glx_pbcet_t as long
enum
	XCB_GLX_PBCET_DAMAGED = 32791
	XCB_GLX_PBCET_SAVED = 32792
end enum

type xcb_glx_pbcdt_t as long
enum
	XCB_GLX_PBCDT_WINDOW = 32793
	XCB_GLX_PBCDT_PBUFFER = 32794
end enum

const XCB_GLX_RENDER_ = 1

type xcb_glx_render_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

const XCB_GLX_RENDER_LARGE_ = 2

type xcb_glx_render_large_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	request_num as ushort
	request_total as ushort
	data_len as ulong
end type

const XCB_GLX_CREATE_CONTEXT_ = 3

type xcb_glx_create_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_glx_context_t
	visual as xcb_visualid_t
	screen as ulong
	share_list as xcb_glx_context_t
	is_direct as ubyte
	pad0(0 to 2) as ubyte
end type

const XCB_GLX_DESTROY_CONTEXT_ = 4

type xcb_glx_destroy_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_glx_context_t
end type

type xcb_glx_make_current_cookie_t
	sequence as ulong
end type

const XCB_GLX_MAKE_CURRENT_ = 5

type xcb_glx_make_current_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_glx_drawable_t
	context as xcb_glx_context_t
	old_context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_make_current_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_tag as xcb_glx_context_tag_t
	pad1(0 to 19) as ubyte
end type

type xcb_glx_is_direct_cookie_t
	sequence as ulong
end type

const XCB_GLX_IS_DIRECT_ = 6

type xcb_glx_is_direct_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_glx_context_t
end type

type xcb_glx_is_direct_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	is_direct as ubyte
	pad1(0 to 22) as ubyte
end type

type xcb_glx_query_version_cookie_t
	sequence as ulong
end type

const XCB_GLX_QUERY_VERSION_ = 7

type xcb_glx_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
end type

type xcb_glx_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
	pad1(0 to 15) as ubyte
end type

const XCB_GLX_WAIT_GL_ = 8

type xcb_glx_wait_gl_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

const XCB_GLX_WAIT_X_ = 9

type xcb_glx_wait_x_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

const XCB_GLX_COPY_CONTEXT_ = 10

type xcb_glx_copy_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	src as xcb_glx_context_t
	dest as xcb_glx_context_t
	mask as ulong
	src_context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_gc_t as long
enum
	XCB_GLX_GC_GL_CURRENT_BIT = 1
	XCB_GLX_GC_GL_POINT_BIT = 2
	XCB_GLX_GC_GL_LINE_BIT = 4
	XCB_GLX_GC_GL_POLYGON_BIT = 8
	XCB_GLX_GC_GL_POLYGON_STIPPLE_BIT = 16
	XCB_GLX_GC_GL_PIXEL_MODE_BIT = 32
	XCB_GLX_GC_GL_LIGHTING_BIT = 64
	XCB_GLX_GC_GL_FOG_BIT = 128
	XCB_GLX_GC_GL_DEPTH_BUFFER_BIT = 256
	XCB_GLX_GC_GL_ACCUM_BUFFER_BIT = 512
	XCB_GLX_GC_GL_STENCIL_BUFFER_BIT = 1024
	XCB_GLX_GC_GL_VIEWPORT_BIT = 2048
	XCB_GLX_GC_GL_TRANSFORM_BIT = 4096
	XCB_GLX_GC_GL_ENABLE_BIT = 8192
	XCB_GLX_GC_GL_COLOR_BUFFER_BIT = 16384
	XCB_GLX_GC_GL_HINT_BIT = 32768
	XCB_GLX_GC_GL_EVAL_BIT = 65536
	XCB_GLX_GC_GL_LIST_BIT = 131072
	XCB_GLX_GC_GL_TEXTURE_BIT = 262144
	XCB_GLX_GC_GL_SCISSOR_BIT = 524288
	XCB_GLX_GC_GL_ALL_ATTRIB_BITS = 16777215
end enum

const XCB_GLX_SWAP_BUFFERS_ = 11

type xcb_glx_swap_buffers_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	drawable as xcb_glx_drawable_t
end type

const XCB_GLX_USE_X_FONT_ = 12

type xcb_glx_use_x_font_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	font as xcb_font_t
	first as ulong
	count as ulong
	list_base as ulong
end type

const XCB_GLX_CREATE_GLX_PIXMAP_ = 13

type xcb_glx_create_glx_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	visual as xcb_visualid_t
	pixmap as xcb_pixmap_t
	glx_pixmap as xcb_glx_pixmap_t
end type

type xcb_glx_get_visual_configs_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_VISUAL_CONFIGS_ = 14

type xcb_glx_get_visual_configs_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_glx_get_visual_configs_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_visuals as ulong
	num_properties as ulong
	pad1(0 to 15) as ubyte
end type

const XCB_GLX_DESTROY_GLX_PIXMAP_ = 15

type xcb_glx_destroy_glx_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	glx_pixmap as xcb_glx_pixmap_t
end type

const XCB_GLX_VENDOR_PRIVATE_ = 16

type xcb_glx_vendor_private_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	vendor_code as ulong
	context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_vendor_private_with_reply_cookie_t
	sequence as ulong
end type

const XCB_GLX_VENDOR_PRIVATE_WITH_REPLY_ = 17

type xcb_glx_vendor_private_with_reply_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	vendor_code as ulong
	context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_vendor_private_with_reply_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	retval as ulong
	data1(0 to 23) as ubyte
end type

type xcb_glx_query_extensions_string_cookie_t
	sequence as ulong
end type

const XCB_GLX_QUERY_EXTENSIONS_STRING_ = 18

type xcb_glx_query_extensions_string_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_glx_query_extensions_string_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	pad2(0 to 15) as ubyte
end type

type xcb_glx_query_server_string_cookie_t
	sequence as ulong
end type

const XCB_GLX_QUERY_SERVER_STRING_ = 19

type xcb_glx_query_server_string_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	name as ulong
end type

type xcb_glx_query_server_string_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	str_len as ulong
	pad2(0 to 15) as ubyte
end type

const XCB_GLX_CLIENT_INFO_ = 20

type xcb_glx_client_info_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
	str_len as ulong
end type

type xcb_glx_get_fb_configs_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_FB_CONFIGS_ = 21

type xcb_glx_get_fb_configs_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
end type

type xcb_glx_get_fb_configs_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_FB_configs as ulong
	num_properties as ulong
	pad1(0 to 15) as ubyte
end type

const XCB_GLX_CREATE_PIXMAP_ = 22

type xcb_glx_create_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	fbconfig as xcb_glx_fbconfig_t
	pixmap as xcb_pixmap_t
	glx_pixmap as xcb_glx_pixmap_t
	num_attribs as ulong
end type

const XCB_GLX_DESTROY_PIXMAP_ = 23

type xcb_glx_destroy_pixmap_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	glx_pixmap as xcb_glx_pixmap_t
end type

const XCB_GLX_CREATE_NEW_CONTEXT_ = 24

type xcb_glx_create_new_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_glx_context_t
	fbconfig as xcb_glx_fbconfig_t
	screen as ulong
	render_type as ulong
	share_list as xcb_glx_context_t
	is_direct as ubyte
	pad0(0 to 2) as ubyte
end type

type xcb_glx_query_context_cookie_t
	sequence as ulong
end type

const XCB_GLX_QUERY_CONTEXT_ = 25

type xcb_glx_query_context_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_glx_context_t
end type

type xcb_glx_query_context_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_attribs as ulong
	pad1(0 to 19) as ubyte
end type

type xcb_glx_make_context_current_cookie_t
	sequence as ulong
end type

const XCB_GLX_MAKE_CONTEXT_CURRENT_ = 26

type xcb_glx_make_context_current_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	old_context_tag as xcb_glx_context_tag_t
	drawable as xcb_glx_drawable_t
	read_drawable as xcb_glx_drawable_t
	context as xcb_glx_context_t
end type

type xcb_glx_make_context_current_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	context_tag as xcb_glx_context_tag_t
	pad1(0 to 19) as ubyte
end type

const XCB_GLX_CREATE_PBUFFER_ = 27

type xcb_glx_create_pbuffer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	fbconfig as xcb_glx_fbconfig_t
	pbuffer as xcb_glx_pbuffer_t
	num_attribs as ulong
end type

const XCB_GLX_DESTROY_PBUFFER_ = 28

type xcb_glx_destroy_pbuffer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	pbuffer as xcb_glx_pbuffer_t
end type

type xcb_glx_get_drawable_attributes_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_DRAWABLE_ATTRIBUTES_ = 29

type xcb_glx_get_drawable_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_glx_drawable_t
end type

type xcb_glx_get_drawable_attributes_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_attribs as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_GLX_CHANGE_DRAWABLE_ATTRIBUTES_ = 30

type xcb_glx_change_drawable_attributes_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_glx_drawable_t
	num_attribs as ulong
end type

const XCB_GLX_CREATE_WINDOW_ = 31

type xcb_glx_create_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	screen as ulong
	fbconfig as xcb_glx_fbconfig_t
	window as xcb_window_t
	glx_window as xcb_glx_window_t
	num_attribs as ulong
end type

const XCB_GLX_DELETE_WINDOW_ = 32

type xcb_glx_delete_window_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	glxwindow as xcb_glx_window_t
end type

const XCB_GLX_SET_CLIENT_INFO_ARB_ = 33

type xcb_glx_set_client_info_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
	num_versions as ulong
	gl_str_len as ulong
	glx_str_len as ulong
end type

const XCB_GLX_CREATE_CONTEXT_ATTRIBS_ARB_ = 34

type xcb_glx_create_context_attribs_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context as xcb_glx_context_t
	fbconfig as xcb_glx_fbconfig_t
	screen as ulong
	share_list as xcb_glx_context_t
	is_direct as ubyte
	pad0(0 to 2) as ubyte
	num_attribs as ulong
end type

const XCB_GLX_SET_CLIENT_INFO_2ARB_ = 35

type xcb_glx_set_client_info_2arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	major_version as ulong
	minor_version as ulong
	num_versions as ulong
	gl_str_len as ulong
	glx_str_len as ulong
end type

const XCB_GLX_NEW_LIST_ = 101

type xcb_glx_new_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	list as ulong
	mode as ulong
end type

const XCB_GLX_END_LIST_ = 102

type xcb_glx_end_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

const XCB_GLX_DELETE_LISTS_ = 103

type xcb_glx_delete_lists_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	list as ulong
	range as long
end type

type xcb_glx_gen_lists_cookie_t
	sequence as ulong
end type

const XCB_GLX_GEN_LISTS_ = 104

type xcb_glx_gen_lists_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	range as long
end type

type xcb_glx_gen_lists_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ret_val as ulong
end type

const XCB_GLX_FEEDBACK_BUFFER_ = 105

type xcb_glx_feedback_buffer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	size as long
	as long type
end type

const XCB_GLX_SELECT_BUFFER_ = 106

type xcb_glx_select_buffer_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	size as long
end type

type xcb_glx_render_mode_cookie_t
	sequence as ulong
end type

const XCB_GLX_RENDER_MODE_ = 107

type xcb_glx_render_mode_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	mode as ulong
end type

type xcb_glx_render_mode_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ret_val as ulong
	n as ulong
	new_mode as ulong
	pad1(0 to 11) as ubyte
end type

type xcb_glx_rm_t as long
enum
	XCB_GLX_RM_GL_RENDER = 7168
	XCB_GLX_RM_GL_FEEDBACK = 7169
	XCB_GLX_RM_GL_SELECT = 7170
end enum

type xcb_glx_finish_cookie_t
	sequence as ulong
end type

const XCB_GLX_FINISH_ = 108

type xcb_glx_finish_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_finish_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
end type

const XCB_GLX_PIXEL_STOREF_ = 109

type xcb_glx_pixel_storef_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	pname as ulong
	datum as xcb_glx_float32_t
end type

const XCB_GLX_PIXEL_STOREI_ = 110

type xcb_glx_pixel_storei_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	pname as ulong
	datum as long
end type

type xcb_glx_read_pixels_cookie_t
	sequence as ulong
end type

const XCB_GLX_READ_PIXELS_ = 111

type xcb_glx_read_pixels_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	x as long
	y as long
	width as long
	height as long
	format as ulong
	as ulong type
	swap_bytes as ubyte
	lsb_first as ubyte
end type

type xcb_glx_read_pixels_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_glx_get_booleanv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_BOOLEANV_ = 112

type xcb_glx_get_booleanv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	pname as long
end type

type xcb_glx_get_booleanv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as ubyte
	pad2(0 to 14) as ubyte
end type

type xcb_glx_get_clip_plane_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_CLIP_PLANE_ = 113

type xcb_glx_get_clip_plane_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	plane as long
end type

type xcb_glx_get_clip_plane_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_glx_get_doublev_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_DOUBLEV_ = 114

type xcb_glx_get_doublev_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	pname as ulong
end type

type xcb_glx_get_doublev_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float64_t
	pad2(0 to 7) as ubyte
end type

type xcb_glx_get_error_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_ERROR_ = 115

type xcb_glx_get_error_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_get_error_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	error as long
end type

type xcb_glx_get_floatv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_FLOATV_ = 116

type xcb_glx_get_floatv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	pname as ulong
end type

type xcb_glx_get_floatv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_integerv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_INTEGERV_ = 117

type xcb_glx_get_integerv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	pname as ulong
end type

type xcb_glx_get_integerv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_lightfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_LIGHTFV_ = 118

type xcb_glx_get_lightfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	light as ulong
	pname as ulong
end type

type xcb_glx_get_lightfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_lightiv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_LIGHTIV_ = 119

type xcb_glx_get_lightiv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	light as ulong
	pname as ulong
end type

type xcb_glx_get_lightiv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_mapdv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MAPDV_ = 120

type xcb_glx_get_mapdv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	query as ulong
end type

type xcb_glx_get_mapdv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float64_t
	pad2(0 to 7) as ubyte
end type

type xcb_glx_get_mapfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MAPFV_ = 121

type xcb_glx_get_mapfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	query as ulong
end type

type xcb_glx_get_mapfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_mapiv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MAPIV_ = 122

type xcb_glx_get_mapiv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	query as ulong
end type

type xcb_glx_get_mapiv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_materialfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MATERIALFV_ = 123

type xcb_glx_get_materialfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	face as ulong
	pname as ulong
end type

type xcb_glx_get_materialfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_materialiv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MATERIALIV_ = 124

type xcb_glx_get_materialiv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	face as ulong
	pname as ulong
end type

type xcb_glx_get_materialiv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_pixel_mapfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_PIXEL_MAPFV_ = 125

type xcb_glx_get_pixel_mapfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	map as ulong
end type

type xcb_glx_get_pixel_mapfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_pixel_mapuiv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_PIXEL_MAPUIV_ = 126

type xcb_glx_get_pixel_mapuiv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	map as ulong
end type

type xcb_glx_get_pixel_mapuiv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as ulong
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_pixel_mapusv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_PIXEL_MAPUSV_ = 127

type xcb_glx_get_pixel_mapusv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	map as ulong
end type

type xcb_glx_get_pixel_mapusv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as ushort
	pad2(0 to 15) as ubyte
end type

type xcb_glx_get_polygon_stipple_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_POLYGON_STIPPLE_ = 128

type xcb_glx_get_polygon_stipple_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	lsb_first as ubyte
end type

type xcb_glx_get_polygon_stipple_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_glx_get_string_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_STRING_ = 129

type xcb_glx_get_string_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	name as ulong
end type

type xcb_glx_get_string_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	pad2(0 to 15) as ubyte
end type

type xcb_glx_get_tex_envfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_ENVFV_ = 130

type xcb_glx_get_tex_envfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_tex_envfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_enviv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_ENVIV_ = 131

type xcb_glx_get_tex_enviv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_tex_enviv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_gendv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_GENDV_ = 132

type xcb_glx_get_tex_gendv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	coord as ulong
	pname as ulong
end type

type xcb_glx_get_tex_gendv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float64_t
	pad2(0 to 7) as ubyte
end type

type xcb_glx_get_tex_genfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_GENFV_ = 133

type xcb_glx_get_tex_genfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	coord as ulong
	pname as ulong
end type

type xcb_glx_get_tex_genfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_geniv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_GENIV_ = 134

type xcb_glx_get_tex_geniv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	coord as ulong
	pname as ulong
end type

type xcb_glx_get_tex_geniv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_image_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_IMAGE_ = 135

type xcb_glx_get_tex_image_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	level as long
	format as ulong
	as ulong type
	swap_bytes as ubyte
end type

type xcb_glx_get_tex_image_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 7) as ubyte
	width as long
	height as long
	depth as long
	pad2(0 to 3) as ubyte
end type

type xcb_glx_get_tex_parameterfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_PARAMETERFV_ = 136

type xcb_glx_get_tex_parameterfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_tex_parameterfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_parameteriv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_PARAMETERIV_ = 137

type xcb_glx_get_tex_parameteriv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_tex_parameteriv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_level_parameterfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_LEVEL_PARAMETERFV_ = 138

type xcb_glx_get_tex_level_parameterfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	level as long
	pname as ulong
end type

type xcb_glx_get_tex_level_parameterfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_tex_level_parameteriv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_TEX_LEVEL_PARAMETERIV_ = 139

type xcb_glx_get_tex_level_parameteriv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	level as long
	pname as ulong
end type

type xcb_glx_get_tex_level_parameteriv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_is_list_cookie_t
	sequence as ulong
end type

const XCB_GLX_IS_LIST_ = 141

type xcb_glx_is_list_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	list as ulong
end type

type xcb_glx_is_list_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ret_val as xcb_glx_bool32_t
end type

const XCB_GLX_FLUSH_ = 142

type xcb_glx_flush_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
end type

type xcb_glx_are_textures_resident_cookie_t
	sequence as ulong
end type

const XCB_GLX_ARE_TEXTURES_RESIDENT_ = 143

type xcb_glx_are_textures_resident_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	n as long
end type

type xcb_glx_are_textures_resident_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ret_val as xcb_glx_bool32_t
	pad1(0 to 19) as ubyte
end type

const XCB_GLX_DELETE_TEXTURES_ = 144

type xcb_glx_delete_textures_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	n as long
end type

type xcb_glx_gen_textures_cookie_t
	sequence as ulong
end type

const XCB_GLX_GEN_TEXTURES_ = 145

type xcb_glx_gen_textures_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	n as long
end type

type xcb_glx_gen_textures_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_glx_is_texture_cookie_t
	sequence as ulong
end type

const XCB_GLX_IS_TEXTURE_ = 146

type xcb_glx_is_texture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	texture as ulong
end type

type xcb_glx_is_texture_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ret_val as xcb_glx_bool32_t
end type

type xcb_glx_get_color_table_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_COLOR_TABLE_ = 147

type xcb_glx_get_color_table_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	format as ulong
	as ulong type
	swap_bytes as ubyte
end type

type xcb_glx_get_color_table_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 7) as ubyte
	width as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_color_table_parameterfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_COLOR_TABLE_PARAMETERFV_ = 148

type xcb_glx_get_color_table_parameterfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_color_table_parameterfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_color_table_parameteriv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_COLOR_TABLE_PARAMETERIV_ = 149

type xcb_glx_get_color_table_parameteriv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_color_table_parameteriv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_convolution_filter_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_CONVOLUTION_FILTER_ = 150

type xcb_glx_get_convolution_filter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	format as ulong
	as ulong type
	swap_bytes as ubyte
end type

type xcb_glx_get_convolution_filter_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 7) as ubyte
	width as long
	height as long
	pad2(0 to 7) as ubyte
end type

type xcb_glx_get_convolution_parameterfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_CONVOLUTION_PARAMETERFV_ = 151

type xcb_glx_get_convolution_parameterfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_convolution_parameterfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_convolution_parameteriv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_CONVOLUTION_PARAMETERIV_ = 152

type xcb_glx_get_convolution_parameteriv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_convolution_parameteriv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_separable_filter_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_SEPARABLE_FILTER_ = 153

type xcb_glx_get_separable_filter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	format as ulong
	as ulong type
	swap_bytes as ubyte
end type

type xcb_glx_get_separable_filter_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 7) as ubyte
	row_w as long
	col_h as long
	pad2(0 to 7) as ubyte
end type

type xcb_glx_get_histogram_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_HISTOGRAM_ = 154

type xcb_glx_get_histogram_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	format as ulong
	as ulong type
	swap_bytes as ubyte
	reset as ubyte
end type

type xcb_glx_get_histogram_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 7) as ubyte
	width as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_histogram_parameterfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_HISTOGRAM_PARAMETERFV_ = 155

type xcb_glx_get_histogram_parameterfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_histogram_parameterfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_histogram_parameteriv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_HISTOGRAM_PARAMETERIV_ = 156

type xcb_glx_get_histogram_parameteriv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_histogram_parameteriv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_minmax_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MINMAX_ = 157

type xcb_glx_get_minmax_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	format as ulong
	as ulong type
	swap_bytes as ubyte
	reset as ubyte
end type

type xcb_glx_get_minmax_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_glx_get_minmax_parameterfv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MINMAX_PARAMETERFV_ = 158

type xcb_glx_get_minmax_parameterfv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_minmax_parameterfv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as xcb_glx_float32_t
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_minmax_parameteriv_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_MINMAX_PARAMETERIV_ = 159

type xcb_glx_get_minmax_parameteriv_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_minmax_parameteriv_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_compressed_tex_image_arb_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_COMPRESSED_TEX_IMAGE_ARB_ = 160

type xcb_glx_get_compressed_tex_image_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	level as long
end type

type xcb_glx_get_compressed_tex_image_arb_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 7) as ubyte
	size as long
	pad2(0 to 11) as ubyte
end type

const XCB_GLX_DELETE_QUERIES_ARB_ = 161

type xcb_glx_delete_queries_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	n as long
end type

type xcb_glx_gen_queries_arb_cookie_t
	sequence as ulong
end type

const XCB_GLX_GEN_QUERIES_ARB_ = 162

type xcb_glx_gen_queries_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	n as long
end type

type xcb_glx_gen_queries_arb_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 23) as ubyte
end type

type xcb_glx_is_query_arb_cookie_t
	sequence as ulong
end type

const XCB_GLX_IS_QUERY_ARB_ = 163

type xcb_glx_is_query_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	id as ulong
end type

type xcb_glx_is_query_arb_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	ret_val as xcb_glx_bool32_t
end type

type xcb_glx_get_queryiv_arb_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_QUERYIV_ARB_ = 164

type xcb_glx_get_queryiv_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	target as ulong
	pname as ulong
end type

type xcb_glx_get_queryiv_arb_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_query_objectiv_arb_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_QUERY_OBJECTIV_ARB_ = 165

type xcb_glx_get_query_objectiv_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	id as ulong
	pname as ulong
end type

type xcb_glx_get_query_objectiv_arb_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as long
	pad2(0 to 11) as ubyte
end type

type xcb_glx_get_query_objectuiv_arb_cookie_t
	sequence as ulong
end type

const XCB_GLX_GET_QUERY_OBJECTUIV_ARB_ = 166

type xcb_glx_get_query_objectuiv_arb_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	context_tag as xcb_glx_context_tag_t
	id as ulong
	pname as ulong
end type

type xcb_glx_get_query_objectuiv_arb_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	pad1(0 to 3) as ubyte
	n as ulong
	datum as ulong
	pad2(0 to 11) as ubyte
end type

declare sub xcb_glx_pixmap_next(byval i as xcb_glx_pixmap_iterator_t ptr)
declare function xcb_glx_pixmap_end(byval i as xcb_glx_pixmap_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_context_next(byval i as xcb_glx_context_iterator_t ptr)
declare function xcb_glx_context_end(byval i as xcb_glx_context_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_pbuffer_next(byval i as xcb_glx_pbuffer_iterator_t ptr)
declare function xcb_glx_pbuffer_end(byval i as xcb_glx_pbuffer_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_window_next(byval i as xcb_glx_window_iterator_t ptr)
declare function xcb_glx_window_end(byval i as xcb_glx_window_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_fbconfig_next(byval i as xcb_glx_fbconfig_iterator_t ptr)
declare function xcb_glx_fbconfig_end(byval i as xcb_glx_fbconfig_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_drawable_next(byval i as xcb_glx_drawable_iterator_t ptr)
declare function xcb_glx_drawable_end(byval i as xcb_glx_drawable_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_float32_next(byval i as xcb_glx_float32_iterator_t ptr)
declare function xcb_glx_float32_end(byval i as xcb_glx_float32_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_float64_next(byval i as xcb_glx_float64_iterator_t ptr)
declare function xcb_glx_float64_end(byval i as xcb_glx_float64_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_bool32_next(byval i as xcb_glx_bool32_iterator_t ptr)
declare function xcb_glx_bool32_end(byval i as xcb_glx_bool32_iterator_t) as xcb_generic_iterator_t
declare sub xcb_glx_context_tag_next(byval i as xcb_glx_context_tag_iterator_t ptr)
declare function xcb_glx_context_tag_end(byval i as xcb_glx_context_tag_iterator_t) as xcb_generic_iterator_t
declare function xcb_glx_render_sizeof(byval _buffer as const any ptr, byval data_len as ulong) as long
declare function xcb_glx_render_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_glx_render(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_glx_render_large_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_render_large_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval request_num as ushort, byval request_total as ushort, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_glx_render_large(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval request_num as ushort, byval request_total as ushort, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_glx_create_context_checked(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t, byval visual as xcb_visualid_t, byval screen as ulong, byval share_list as xcb_glx_context_t, byval is_direct as ubyte) as xcb_void_cookie_t
declare function xcb_glx_create_context(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t, byval visual as xcb_visualid_t, byval screen as ulong, byval share_list as xcb_glx_context_t, byval is_direct as ubyte) as xcb_void_cookie_t
declare function xcb_glx_destroy_context_checked(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t) as xcb_void_cookie_t
declare function xcb_glx_destroy_context(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t) as xcb_void_cookie_t
declare function xcb_glx_make_current(byval c as xcb_connection_t ptr, byval drawable as xcb_glx_drawable_t, byval context as xcb_glx_context_t, byval old_context_tag as xcb_glx_context_tag_t) as xcb_glx_make_current_cookie_t
declare function xcb_glx_make_current_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_glx_drawable_t, byval context as xcb_glx_context_t, byval old_context_tag as xcb_glx_context_tag_t) as xcb_glx_make_current_cookie_t
declare function xcb_glx_make_current_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_make_current_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_make_current_reply_t ptr
declare function xcb_glx_is_direct(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t) as xcb_glx_is_direct_cookie_t
declare function xcb_glx_is_direct_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t) as xcb_glx_is_direct_cookie_t
declare function xcb_glx_is_direct_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_is_direct_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_is_direct_reply_t ptr
declare function xcb_glx_query_version(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_glx_query_version_cookie_t
declare function xcb_glx_query_version_unchecked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong) as xcb_glx_query_version_cookie_t
declare function xcb_glx_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_query_version_reply_t ptr
declare function xcb_glx_wait_gl_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_wait_gl(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_wait_x_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_wait_x(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_copy_context_checked(byval c as xcb_connection_t ptr, byval src as xcb_glx_context_t, byval dest as xcb_glx_context_t, byval mask as ulong, byval src_context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_copy_context(byval c as xcb_connection_t ptr, byval src as xcb_glx_context_t, byval dest as xcb_glx_context_t, byval mask as ulong, byval src_context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_swap_buffers_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval drawable as xcb_glx_drawable_t) as xcb_void_cookie_t
declare function xcb_glx_swap_buffers(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval drawable as xcb_glx_drawable_t) as xcb_void_cookie_t
declare function xcb_glx_use_x_font_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval font as xcb_font_t, byval first as ulong, byval count as ulong, byval list_base as ulong) as xcb_void_cookie_t
declare function xcb_glx_use_x_font(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval font as xcb_font_t, byval first as ulong, byval count as ulong, byval list_base as ulong) as xcb_void_cookie_t
declare function xcb_glx_create_glx_pixmap_checked(byval c as xcb_connection_t ptr, byval screen as ulong, byval visual as xcb_visualid_t, byval pixmap as xcb_pixmap_t, byval glx_pixmap as xcb_glx_pixmap_t) as xcb_void_cookie_t
declare function xcb_glx_create_glx_pixmap(byval c as xcb_connection_t ptr, byval screen as ulong, byval visual as xcb_visualid_t, byval pixmap as xcb_pixmap_t, byval glx_pixmap as xcb_glx_pixmap_t) as xcb_void_cookie_t
declare function xcb_glx_get_visual_configs_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_visual_configs(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_glx_get_visual_configs_cookie_t
declare function xcb_glx_get_visual_configs_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_glx_get_visual_configs_cookie_t
declare function xcb_glx_get_visual_configs_property_list(byval R as const xcb_glx_get_visual_configs_reply_t ptr) as ulong ptr
declare function xcb_glx_get_visual_configs_property_list_length(byval R as const xcb_glx_get_visual_configs_reply_t ptr) as long
declare function xcb_glx_get_visual_configs_property_list_end(byval R as const xcb_glx_get_visual_configs_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_visual_configs_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_visual_configs_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_visual_configs_reply_t ptr
declare function xcb_glx_destroy_glx_pixmap_checked(byval c as xcb_connection_t ptr, byval glx_pixmap as xcb_glx_pixmap_t) as xcb_void_cookie_t
declare function xcb_glx_destroy_glx_pixmap(byval c as xcb_connection_t ptr, byval glx_pixmap as xcb_glx_pixmap_t) as xcb_void_cookie_t
declare function xcb_glx_vendor_private_sizeof(byval _buffer as const any ptr, byval data_len as ulong) as long
declare function xcb_glx_vendor_private_checked(byval c as xcb_connection_t ptr, byval vendor_code as ulong, byval context_tag as xcb_glx_context_tag_t, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_glx_vendor_private(byval c as xcb_connection_t ptr, byval vendor_code as ulong, byval context_tag as xcb_glx_context_tag_t, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_glx_vendor_private_with_reply_sizeof(byval _buffer as const any ptr, byval data_len as ulong) as long
declare function xcb_glx_vendor_private_with_reply(byval c as xcb_connection_t ptr, byval vendor_code as ulong, byval context_tag as xcb_glx_context_tag_t, byval data_len as ulong, byval data as const ubyte ptr) as xcb_glx_vendor_private_with_reply_cookie_t
declare function xcb_glx_vendor_private_with_reply_unchecked(byval c as xcb_connection_t ptr, byval vendor_code as ulong, byval context_tag as xcb_glx_context_tag_t, byval data_len as ulong, byval data as const ubyte ptr) as xcb_glx_vendor_private_with_reply_cookie_t
declare function xcb_glx_vendor_private_with_reply_data_2(byval R as const xcb_glx_vendor_private_with_reply_reply_t ptr) as ubyte ptr
declare function xcb_glx_vendor_private_with_reply_data_2_length(byval R as const xcb_glx_vendor_private_with_reply_reply_t ptr) as long
declare function xcb_glx_vendor_private_with_reply_data_2_end(byval R as const xcb_glx_vendor_private_with_reply_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_vendor_private_with_reply_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_vendor_private_with_reply_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_vendor_private_with_reply_reply_t ptr
declare function xcb_glx_query_extensions_string(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_glx_query_extensions_string_cookie_t
declare function xcb_glx_query_extensions_string_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_glx_query_extensions_string_cookie_t
declare function xcb_glx_query_extensions_string_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_query_extensions_string_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_query_extensions_string_reply_t ptr
declare function xcb_glx_query_server_string_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_query_server_string(byval c as xcb_connection_t ptr, byval screen as ulong, byval name as ulong) as xcb_glx_query_server_string_cookie_t
declare function xcb_glx_query_server_string_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong, byval name as ulong) as xcb_glx_query_server_string_cookie_t
declare function xcb_glx_query_server_string_string(byval R as const xcb_glx_query_server_string_reply_t ptr) as zstring ptr
declare function xcb_glx_query_server_string_string_length(byval R as const xcb_glx_query_server_string_reply_t ptr) as long
declare function xcb_glx_query_server_string_string_end(byval R as const xcb_glx_query_server_string_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_query_server_string_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_query_server_string_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_query_server_string_reply_t ptr
declare function xcb_glx_client_info_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_client_info_checked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong, byval str_len as ulong, byval string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_glx_client_info(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong, byval str_len as ulong, byval string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_glx_get_fb_configs_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_fb_configs(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_glx_get_fb_configs_cookie_t
declare function xcb_glx_get_fb_configs_unchecked(byval c as xcb_connection_t ptr, byval screen as ulong) as xcb_glx_get_fb_configs_cookie_t
declare function xcb_glx_get_fb_configs_property_list(byval R as const xcb_glx_get_fb_configs_reply_t ptr) as ulong ptr
declare function xcb_glx_get_fb_configs_property_list_length(byval R as const xcb_glx_get_fb_configs_reply_t ptr) as long
declare function xcb_glx_get_fb_configs_property_list_end(byval R as const xcb_glx_get_fb_configs_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_fb_configs_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_fb_configs_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_fb_configs_reply_t ptr
declare function xcb_glx_create_pixmap_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_create_pixmap_checked(byval c as xcb_connection_t ptr, byval screen as ulong, byval fbconfig as xcb_glx_fbconfig_t, byval pixmap as xcb_pixmap_t, byval glx_pixmap as xcb_glx_pixmap_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_create_pixmap(byval c as xcb_connection_t ptr, byval screen as ulong, byval fbconfig as xcb_glx_fbconfig_t, byval pixmap as xcb_pixmap_t, byval glx_pixmap as xcb_glx_pixmap_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_destroy_pixmap_checked(byval c as xcb_connection_t ptr, byval glx_pixmap as xcb_glx_pixmap_t) as xcb_void_cookie_t
declare function xcb_glx_destroy_pixmap(byval c as xcb_connection_t ptr, byval glx_pixmap as xcb_glx_pixmap_t) as xcb_void_cookie_t
declare function xcb_glx_create_new_context_checked(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t, byval fbconfig as xcb_glx_fbconfig_t, byval screen as ulong, byval render_type as ulong, byval share_list as xcb_glx_context_t, byval is_direct as ubyte) as xcb_void_cookie_t
declare function xcb_glx_create_new_context(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t, byval fbconfig as xcb_glx_fbconfig_t, byval screen as ulong, byval render_type as ulong, byval share_list as xcb_glx_context_t, byval is_direct as ubyte) as xcb_void_cookie_t
declare function xcb_glx_query_context_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_query_context(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t) as xcb_glx_query_context_cookie_t
declare function xcb_glx_query_context_unchecked(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t) as xcb_glx_query_context_cookie_t
declare function xcb_glx_query_context_attribs(byval R as const xcb_glx_query_context_reply_t ptr) as ulong ptr
declare function xcb_glx_query_context_attribs_length(byval R as const xcb_glx_query_context_reply_t ptr) as long
declare function xcb_glx_query_context_attribs_end(byval R as const xcb_glx_query_context_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_query_context_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_query_context_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_query_context_reply_t ptr
declare function xcb_glx_make_context_current(byval c as xcb_connection_t ptr, byval old_context_tag as xcb_glx_context_tag_t, byval drawable as xcb_glx_drawable_t, byval read_drawable as xcb_glx_drawable_t, byval context as xcb_glx_context_t) as xcb_glx_make_context_current_cookie_t
declare function xcb_glx_make_context_current_unchecked(byval c as xcb_connection_t ptr, byval old_context_tag as xcb_glx_context_tag_t, byval drawable as xcb_glx_drawable_t, byval read_drawable as xcb_glx_drawable_t, byval context as xcb_glx_context_t) as xcb_glx_make_context_current_cookie_t
declare function xcb_glx_make_context_current_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_make_context_current_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_make_context_current_reply_t ptr
declare function xcb_glx_create_pbuffer_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_create_pbuffer_checked(byval c as xcb_connection_t ptr, byval screen as ulong, byval fbconfig as xcb_glx_fbconfig_t, byval pbuffer as xcb_glx_pbuffer_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_create_pbuffer(byval c as xcb_connection_t ptr, byval screen as ulong, byval fbconfig as xcb_glx_fbconfig_t, byval pbuffer as xcb_glx_pbuffer_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_destroy_pbuffer_checked(byval c as xcb_connection_t ptr, byval pbuffer as xcb_glx_pbuffer_t) as xcb_void_cookie_t
declare function xcb_glx_destroy_pbuffer(byval c as xcb_connection_t ptr, byval pbuffer as xcb_glx_pbuffer_t) as xcb_void_cookie_t
declare function xcb_glx_get_drawable_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_drawable_attributes(byval c as xcb_connection_t ptr, byval drawable as xcb_glx_drawable_t) as xcb_glx_get_drawable_attributes_cookie_t
declare function xcb_glx_get_drawable_attributes_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_glx_drawable_t) as xcb_glx_get_drawable_attributes_cookie_t
declare function xcb_glx_get_drawable_attributes_attribs(byval R as const xcb_glx_get_drawable_attributes_reply_t ptr) as ulong ptr
declare function xcb_glx_get_drawable_attributes_attribs_length(byval R as const xcb_glx_get_drawable_attributes_reply_t ptr) as long
declare function xcb_glx_get_drawable_attributes_attribs_end(byval R as const xcb_glx_get_drawable_attributes_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_drawable_attributes_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_drawable_attributes_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_drawable_attributes_reply_t ptr
declare function xcb_glx_change_drawable_attributes_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_change_drawable_attributes_checked(byval c as xcb_connection_t ptr, byval drawable as xcb_glx_drawable_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_change_drawable_attributes(byval c as xcb_connection_t ptr, byval drawable as xcb_glx_drawable_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_create_window_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_create_window_checked(byval c as xcb_connection_t ptr, byval screen as ulong, byval fbconfig as xcb_glx_fbconfig_t, byval window as xcb_window_t, byval glx_window as xcb_glx_window_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_create_window(byval c as xcb_connection_t ptr, byval screen as ulong, byval fbconfig as xcb_glx_fbconfig_t, byval window as xcb_window_t, byval glx_window as xcb_glx_window_t, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_delete_window_checked(byval c as xcb_connection_t ptr, byval glxwindow as xcb_glx_window_t) as xcb_void_cookie_t
declare function xcb_glx_delete_window(byval c as xcb_connection_t ptr, byval glxwindow as xcb_glx_window_t) as xcb_void_cookie_t
declare function xcb_glx_set_client_info_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_set_client_info_arb_checked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong, byval num_versions as ulong, byval gl_str_len as ulong, byval glx_str_len as ulong, byval gl_versions as const ulong ptr, byval gl_extension_string as const zstring ptr, byval glx_extension_string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_glx_set_client_info_arb(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong, byval num_versions as ulong, byval gl_str_len as ulong, byval glx_str_len as ulong, byval gl_versions as const ulong ptr, byval gl_extension_string as const zstring ptr, byval glx_extension_string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_glx_create_context_attribs_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_create_context_attribs_arb_checked(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t, byval fbconfig as xcb_glx_fbconfig_t, byval screen as ulong, byval share_list as xcb_glx_context_t, byval is_direct as ubyte, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_create_context_attribs_arb(byval c as xcb_connection_t ptr, byval context as xcb_glx_context_t, byval fbconfig as xcb_glx_fbconfig_t, byval screen as ulong, byval share_list as xcb_glx_context_t, byval is_direct as ubyte, byval num_attribs as ulong, byval attribs as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_set_client_info_2arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_set_client_info_2arb_checked(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong, byval num_versions as ulong, byval gl_str_len as ulong, byval glx_str_len as ulong, byval gl_versions as const ulong ptr, byval gl_extension_string as const zstring ptr, byval glx_extension_string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_glx_set_client_info_2arb(byval c as xcb_connection_t ptr, byval major_version as ulong, byval minor_version as ulong, byval num_versions as ulong, byval gl_str_len as ulong, byval glx_str_len as ulong, byval gl_versions as const ulong ptr, byval gl_extension_string as const zstring ptr, byval glx_extension_string as const zstring ptr) as xcb_void_cookie_t
declare function xcb_glx_new_list_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval list as ulong, byval mode as ulong) as xcb_void_cookie_t
declare function xcb_glx_new_list(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval list as ulong, byval mode as ulong) as xcb_void_cookie_t
declare function xcb_glx_end_list_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_end_list(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_delete_lists_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval list as ulong, byval range as long) as xcb_void_cookie_t
declare function xcb_glx_delete_lists(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval list as ulong, byval range as long) as xcb_void_cookie_t
declare function xcb_glx_gen_lists(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval range as long) as xcb_glx_gen_lists_cookie_t
declare function xcb_glx_gen_lists_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval range as long) as xcb_glx_gen_lists_cookie_t
declare function xcb_glx_gen_lists_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_gen_lists_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_gen_lists_reply_t ptr
declare function xcb_glx_feedback_buffer_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval size as long, byval type as long) as xcb_void_cookie_t
declare function xcb_glx_feedback_buffer(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval size as long, byval type as long) as xcb_void_cookie_t
declare function xcb_glx_select_buffer_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval size as long) as xcb_void_cookie_t
declare function xcb_glx_select_buffer(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval size as long) as xcb_void_cookie_t
declare function xcb_glx_render_mode_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_render_mode(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval mode as ulong) as xcb_glx_render_mode_cookie_t
declare function xcb_glx_render_mode_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval mode as ulong) as xcb_glx_render_mode_cookie_t
declare function xcb_glx_render_mode_data(byval R as const xcb_glx_render_mode_reply_t ptr) as ulong ptr
declare function xcb_glx_render_mode_data_length(byval R as const xcb_glx_render_mode_reply_t ptr) as long
declare function xcb_glx_render_mode_data_end(byval R as const xcb_glx_render_mode_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_render_mode_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_render_mode_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_render_mode_reply_t ptr
declare function xcb_glx_finish(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_glx_finish_cookie_t
declare function xcb_glx_finish_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_glx_finish_cookie_t
declare function xcb_glx_finish_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_finish_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_finish_reply_t ptr
declare function xcb_glx_pixel_storef_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong, byval datum as xcb_glx_float32_t) as xcb_void_cookie_t
declare function xcb_glx_pixel_storef(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong, byval datum as xcb_glx_float32_t) as xcb_void_cookie_t
declare function xcb_glx_pixel_storei_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong, byval datum as long) as xcb_void_cookie_t
declare function xcb_glx_pixel_storei(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong, byval datum as long) as xcb_void_cookie_t
declare function xcb_glx_read_pixels_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_read_pixels(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval x as long, byval y as long, byval width as long, byval height as long, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte, byval lsb_first as ubyte) as xcb_glx_read_pixels_cookie_t
declare function xcb_glx_read_pixels_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval x as long, byval y as long, byval width as long, byval height as long, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte, byval lsb_first as ubyte) as xcb_glx_read_pixels_cookie_t
declare function xcb_glx_read_pixels_data(byval R as const xcb_glx_read_pixels_reply_t ptr) as ubyte ptr
declare function xcb_glx_read_pixels_data_length(byval R as const xcb_glx_read_pixels_reply_t ptr) as long
declare function xcb_glx_read_pixels_data_end(byval R as const xcb_glx_read_pixels_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_read_pixels_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_read_pixels_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_read_pixels_reply_t ptr
declare function xcb_glx_get_booleanv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_booleanv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as long) as xcb_glx_get_booleanv_cookie_t
declare function xcb_glx_get_booleanv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as long) as xcb_glx_get_booleanv_cookie_t
declare function xcb_glx_get_booleanv_data(byval R as const xcb_glx_get_booleanv_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_booleanv_data_length(byval R as const xcb_glx_get_booleanv_reply_t ptr) as long
declare function xcb_glx_get_booleanv_data_end(byval R as const xcb_glx_get_booleanv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_booleanv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_booleanv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_booleanv_reply_t ptr
declare function xcb_glx_get_clip_plane_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_clip_plane(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval plane as long) as xcb_glx_get_clip_plane_cookie_t
declare function xcb_glx_get_clip_plane_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval plane as long) as xcb_glx_get_clip_plane_cookie_t
declare function xcb_glx_get_clip_plane_data(byval R as const xcb_glx_get_clip_plane_reply_t ptr) as xcb_glx_float64_t ptr
declare function xcb_glx_get_clip_plane_data_length(byval R as const xcb_glx_get_clip_plane_reply_t ptr) as long
declare function xcb_glx_get_clip_plane_data_end(byval R as const xcb_glx_get_clip_plane_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_clip_plane_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_clip_plane_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_clip_plane_reply_t ptr
declare function xcb_glx_get_doublev_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_doublev(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong) as xcb_glx_get_doublev_cookie_t
declare function xcb_glx_get_doublev_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong) as xcb_glx_get_doublev_cookie_t
declare function xcb_glx_get_doublev_data(byval R as const xcb_glx_get_doublev_reply_t ptr) as xcb_glx_float64_t ptr
declare function xcb_glx_get_doublev_data_length(byval R as const xcb_glx_get_doublev_reply_t ptr) as long
declare function xcb_glx_get_doublev_data_end(byval R as const xcb_glx_get_doublev_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_doublev_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_doublev_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_doublev_reply_t ptr
declare function xcb_glx_get_error(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_glx_get_error_cookie_t
declare function xcb_glx_get_error_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_glx_get_error_cookie_t
declare function xcb_glx_get_error_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_error_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_error_reply_t ptr
declare function xcb_glx_get_floatv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_floatv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong) as xcb_glx_get_floatv_cookie_t
declare function xcb_glx_get_floatv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong) as xcb_glx_get_floatv_cookie_t
declare function xcb_glx_get_floatv_data(byval R as const xcb_glx_get_floatv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_floatv_data_length(byval R as const xcb_glx_get_floatv_reply_t ptr) as long
declare function xcb_glx_get_floatv_data_end(byval R as const xcb_glx_get_floatv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_floatv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_floatv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_floatv_reply_t ptr
declare function xcb_glx_get_integerv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_integerv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong) as xcb_glx_get_integerv_cookie_t
declare function xcb_glx_get_integerv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval pname as ulong) as xcb_glx_get_integerv_cookie_t
declare function xcb_glx_get_integerv_data(byval R as const xcb_glx_get_integerv_reply_t ptr) as long ptr
declare function xcb_glx_get_integerv_data_length(byval R as const xcb_glx_get_integerv_reply_t ptr) as long
declare function xcb_glx_get_integerv_data_end(byval R as const xcb_glx_get_integerv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_integerv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_integerv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_integerv_reply_t ptr
declare function xcb_glx_get_lightfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_lightfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval light as ulong, byval pname as ulong) as xcb_glx_get_lightfv_cookie_t
declare function xcb_glx_get_lightfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval light as ulong, byval pname as ulong) as xcb_glx_get_lightfv_cookie_t
declare function xcb_glx_get_lightfv_data(byval R as const xcb_glx_get_lightfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_lightfv_data_length(byval R as const xcb_glx_get_lightfv_reply_t ptr) as long
declare function xcb_glx_get_lightfv_data_end(byval R as const xcb_glx_get_lightfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_lightfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_lightfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_lightfv_reply_t ptr
declare function xcb_glx_get_lightiv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_lightiv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval light as ulong, byval pname as ulong) as xcb_glx_get_lightiv_cookie_t
declare function xcb_glx_get_lightiv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval light as ulong, byval pname as ulong) as xcb_glx_get_lightiv_cookie_t
declare function xcb_glx_get_lightiv_data(byval R as const xcb_glx_get_lightiv_reply_t ptr) as long ptr
declare function xcb_glx_get_lightiv_data_length(byval R as const xcb_glx_get_lightiv_reply_t ptr) as long
declare function xcb_glx_get_lightiv_data_end(byval R as const xcb_glx_get_lightiv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_lightiv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_lightiv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_lightiv_reply_t ptr
declare function xcb_glx_get_mapdv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_mapdv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval query as ulong) as xcb_glx_get_mapdv_cookie_t
declare function xcb_glx_get_mapdv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval query as ulong) as xcb_glx_get_mapdv_cookie_t
declare function xcb_glx_get_mapdv_data(byval R as const xcb_glx_get_mapdv_reply_t ptr) as xcb_glx_float64_t ptr
declare function xcb_glx_get_mapdv_data_length(byval R as const xcb_glx_get_mapdv_reply_t ptr) as long
declare function xcb_glx_get_mapdv_data_end(byval R as const xcb_glx_get_mapdv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_mapdv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_mapdv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_mapdv_reply_t ptr
declare function xcb_glx_get_mapfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_mapfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval query as ulong) as xcb_glx_get_mapfv_cookie_t
declare function xcb_glx_get_mapfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval query as ulong) as xcb_glx_get_mapfv_cookie_t
declare function xcb_glx_get_mapfv_data(byval R as const xcb_glx_get_mapfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_mapfv_data_length(byval R as const xcb_glx_get_mapfv_reply_t ptr) as long
declare function xcb_glx_get_mapfv_data_end(byval R as const xcb_glx_get_mapfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_mapfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_mapfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_mapfv_reply_t ptr
declare function xcb_glx_get_mapiv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_mapiv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval query as ulong) as xcb_glx_get_mapiv_cookie_t
declare function xcb_glx_get_mapiv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval query as ulong) as xcb_glx_get_mapiv_cookie_t
declare function xcb_glx_get_mapiv_data(byval R as const xcb_glx_get_mapiv_reply_t ptr) as long ptr
declare function xcb_glx_get_mapiv_data_length(byval R as const xcb_glx_get_mapiv_reply_t ptr) as long
declare function xcb_glx_get_mapiv_data_end(byval R as const xcb_glx_get_mapiv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_mapiv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_mapiv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_mapiv_reply_t ptr
declare function xcb_glx_get_materialfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_materialfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval face as ulong, byval pname as ulong) as xcb_glx_get_materialfv_cookie_t
declare function xcb_glx_get_materialfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval face as ulong, byval pname as ulong) as xcb_glx_get_materialfv_cookie_t
declare function xcb_glx_get_materialfv_data(byval R as const xcb_glx_get_materialfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_materialfv_data_length(byval R as const xcb_glx_get_materialfv_reply_t ptr) as long
declare function xcb_glx_get_materialfv_data_end(byval R as const xcb_glx_get_materialfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_materialfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_materialfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_materialfv_reply_t ptr
declare function xcb_glx_get_materialiv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_materialiv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval face as ulong, byval pname as ulong) as xcb_glx_get_materialiv_cookie_t
declare function xcb_glx_get_materialiv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval face as ulong, byval pname as ulong) as xcb_glx_get_materialiv_cookie_t
declare function xcb_glx_get_materialiv_data(byval R as const xcb_glx_get_materialiv_reply_t ptr) as long ptr
declare function xcb_glx_get_materialiv_data_length(byval R as const xcb_glx_get_materialiv_reply_t ptr) as long
declare function xcb_glx_get_materialiv_data_end(byval R as const xcb_glx_get_materialiv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_materialiv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_materialiv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_materialiv_reply_t ptr
declare function xcb_glx_get_pixel_mapfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_pixel_mapfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval map as ulong) as xcb_glx_get_pixel_mapfv_cookie_t
declare function xcb_glx_get_pixel_mapfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval map as ulong) as xcb_glx_get_pixel_mapfv_cookie_t
declare function xcb_glx_get_pixel_mapfv_data(byval R as const xcb_glx_get_pixel_mapfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_pixel_mapfv_data_length(byval R as const xcb_glx_get_pixel_mapfv_reply_t ptr) as long
declare function xcb_glx_get_pixel_mapfv_data_end(byval R as const xcb_glx_get_pixel_mapfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_pixel_mapfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_pixel_mapfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_pixel_mapfv_reply_t ptr
declare function xcb_glx_get_pixel_mapuiv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_pixel_mapuiv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval map as ulong) as xcb_glx_get_pixel_mapuiv_cookie_t
declare function xcb_glx_get_pixel_mapuiv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval map as ulong) as xcb_glx_get_pixel_mapuiv_cookie_t
declare function xcb_glx_get_pixel_mapuiv_data(byval R as const xcb_glx_get_pixel_mapuiv_reply_t ptr) as ulong ptr
declare function xcb_glx_get_pixel_mapuiv_data_length(byval R as const xcb_glx_get_pixel_mapuiv_reply_t ptr) as long
declare function xcb_glx_get_pixel_mapuiv_data_end(byval R as const xcb_glx_get_pixel_mapuiv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_pixel_mapuiv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_pixel_mapuiv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_pixel_mapuiv_reply_t ptr
declare function xcb_glx_get_pixel_mapusv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_pixel_mapusv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval map as ulong) as xcb_glx_get_pixel_mapusv_cookie_t
declare function xcb_glx_get_pixel_mapusv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval map as ulong) as xcb_glx_get_pixel_mapusv_cookie_t
declare function xcb_glx_get_pixel_mapusv_data(byval R as const xcb_glx_get_pixel_mapusv_reply_t ptr) as ushort ptr
declare function xcb_glx_get_pixel_mapusv_data_length(byval R as const xcb_glx_get_pixel_mapusv_reply_t ptr) as long
declare function xcb_glx_get_pixel_mapusv_data_end(byval R as const xcb_glx_get_pixel_mapusv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_pixel_mapusv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_pixel_mapusv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_pixel_mapusv_reply_t ptr
declare function xcb_glx_get_polygon_stipple_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_polygon_stipple(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval lsb_first as ubyte) as xcb_glx_get_polygon_stipple_cookie_t
declare function xcb_glx_get_polygon_stipple_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval lsb_first as ubyte) as xcb_glx_get_polygon_stipple_cookie_t
declare function xcb_glx_get_polygon_stipple_data(byval R as const xcb_glx_get_polygon_stipple_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_polygon_stipple_data_length(byval R as const xcb_glx_get_polygon_stipple_reply_t ptr) as long
declare function xcb_glx_get_polygon_stipple_data_end(byval R as const xcb_glx_get_polygon_stipple_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_polygon_stipple_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_polygon_stipple_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_polygon_stipple_reply_t ptr
declare function xcb_glx_get_string_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_string(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval name as ulong) as xcb_glx_get_string_cookie_t
declare function xcb_glx_get_string_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval name as ulong) as xcb_glx_get_string_cookie_t
declare function xcb_glx_get_string_string(byval R as const xcb_glx_get_string_reply_t ptr) as zstring ptr
declare function xcb_glx_get_string_string_length(byval R as const xcb_glx_get_string_reply_t ptr) as long
declare function xcb_glx_get_string_string_end(byval R as const xcb_glx_get_string_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_string_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_string_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_string_reply_t ptr
declare function xcb_glx_get_tex_envfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_envfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_envfv_cookie_t
declare function xcb_glx_get_tex_envfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_envfv_cookie_t
declare function xcb_glx_get_tex_envfv_data(byval R as const xcb_glx_get_tex_envfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_tex_envfv_data_length(byval R as const xcb_glx_get_tex_envfv_reply_t ptr) as long
declare function xcb_glx_get_tex_envfv_data_end(byval R as const xcb_glx_get_tex_envfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_envfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_envfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_envfv_reply_t ptr
declare function xcb_glx_get_tex_enviv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_enviv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_enviv_cookie_t
declare function xcb_glx_get_tex_enviv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_enviv_cookie_t
declare function xcb_glx_get_tex_enviv_data(byval R as const xcb_glx_get_tex_enviv_reply_t ptr) as long ptr
declare function xcb_glx_get_tex_enviv_data_length(byval R as const xcb_glx_get_tex_enviv_reply_t ptr) as long
declare function xcb_glx_get_tex_enviv_data_end(byval R as const xcb_glx_get_tex_enviv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_enviv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_enviv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_enviv_reply_t ptr
declare function xcb_glx_get_tex_gendv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_gendv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval coord as ulong, byval pname as ulong) as xcb_glx_get_tex_gendv_cookie_t
declare function xcb_glx_get_tex_gendv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval coord as ulong, byval pname as ulong) as xcb_glx_get_tex_gendv_cookie_t
declare function xcb_glx_get_tex_gendv_data(byval R as const xcb_glx_get_tex_gendv_reply_t ptr) as xcb_glx_float64_t ptr
declare function xcb_glx_get_tex_gendv_data_length(byval R as const xcb_glx_get_tex_gendv_reply_t ptr) as long
declare function xcb_glx_get_tex_gendv_data_end(byval R as const xcb_glx_get_tex_gendv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_gendv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_gendv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_gendv_reply_t ptr
declare function xcb_glx_get_tex_genfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_genfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval coord as ulong, byval pname as ulong) as xcb_glx_get_tex_genfv_cookie_t
declare function xcb_glx_get_tex_genfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval coord as ulong, byval pname as ulong) as xcb_glx_get_tex_genfv_cookie_t
declare function xcb_glx_get_tex_genfv_data(byval R as const xcb_glx_get_tex_genfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_tex_genfv_data_length(byval R as const xcb_glx_get_tex_genfv_reply_t ptr) as long
declare function xcb_glx_get_tex_genfv_data_end(byval R as const xcb_glx_get_tex_genfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_genfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_genfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_genfv_reply_t ptr
declare function xcb_glx_get_tex_geniv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_geniv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval coord as ulong, byval pname as ulong) as xcb_glx_get_tex_geniv_cookie_t
declare function xcb_glx_get_tex_geniv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval coord as ulong, byval pname as ulong) as xcb_glx_get_tex_geniv_cookie_t
declare function xcb_glx_get_tex_geniv_data(byval R as const xcb_glx_get_tex_geniv_reply_t ptr) as long ptr
declare function xcb_glx_get_tex_geniv_data_length(byval R as const xcb_glx_get_tex_geniv_reply_t ptr) as long
declare function xcb_glx_get_tex_geniv_data_end(byval R as const xcb_glx_get_tex_geniv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_geniv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_geniv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_geniv_reply_t ptr
declare function xcb_glx_get_tex_image_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_image(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_tex_image_cookie_t
declare function xcb_glx_get_tex_image_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_tex_image_cookie_t
declare function xcb_glx_get_tex_image_data(byval R as const xcb_glx_get_tex_image_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_tex_image_data_length(byval R as const xcb_glx_get_tex_image_reply_t ptr) as long
declare function xcb_glx_get_tex_image_data_end(byval R as const xcb_glx_get_tex_image_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_image_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_image_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_image_reply_t ptr
declare function xcb_glx_get_tex_parameterfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_parameterfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_parameterfv_cookie_t
declare function xcb_glx_get_tex_parameterfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_parameterfv_cookie_t
declare function xcb_glx_get_tex_parameterfv_data(byval R as const xcb_glx_get_tex_parameterfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_tex_parameterfv_data_length(byval R as const xcb_glx_get_tex_parameterfv_reply_t ptr) as long
declare function xcb_glx_get_tex_parameterfv_data_end(byval R as const xcb_glx_get_tex_parameterfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_parameterfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_parameterfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_parameterfv_reply_t ptr
declare function xcb_glx_get_tex_parameteriv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_parameteriv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_parameteriv_cookie_t
declare function xcb_glx_get_tex_parameteriv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_tex_parameteriv_cookie_t
declare function xcb_glx_get_tex_parameteriv_data(byval R as const xcb_glx_get_tex_parameteriv_reply_t ptr) as long ptr
declare function xcb_glx_get_tex_parameteriv_data_length(byval R as const xcb_glx_get_tex_parameteriv_reply_t ptr) as long
declare function xcb_glx_get_tex_parameteriv_data_end(byval R as const xcb_glx_get_tex_parameteriv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_parameteriv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_parameteriv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_parameteriv_reply_t ptr
declare function xcb_glx_get_tex_level_parameterfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_level_parameterfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long, byval pname as ulong) as xcb_glx_get_tex_level_parameterfv_cookie_t
declare function xcb_glx_get_tex_level_parameterfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long, byval pname as ulong) as xcb_glx_get_tex_level_parameterfv_cookie_t
declare function xcb_glx_get_tex_level_parameterfv_data(byval R as const xcb_glx_get_tex_level_parameterfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_tex_level_parameterfv_data_length(byval R as const xcb_glx_get_tex_level_parameterfv_reply_t ptr) as long
declare function xcb_glx_get_tex_level_parameterfv_data_end(byval R as const xcb_glx_get_tex_level_parameterfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_level_parameterfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_level_parameterfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_level_parameterfv_reply_t ptr
declare function xcb_glx_get_tex_level_parameteriv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_tex_level_parameteriv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long, byval pname as ulong) as xcb_glx_get_tex_level_parameteriv_cookie_t
declare function xcb_glx_get_tex_level_parameteriv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long, byval pname as ulong) as xcb_glx_get_tex_level_parameteriv_cookie_t
declare function xcb_glx_get_tex_level_parameteriv_data(byval R as const xcb_glx_get_tex_level_parameteriv_reply_t ptr) as long ptr
declare function xcb_glx_get_tex_level_parameteriv_data_length(byval R as const xcb_glx_get_tex_level_parameteriv_reply_t ptr) as long
declare function xcb_glx_get_tex_level_parameteriv_data_end(byval R as const xcb_glx_get_tex_level_parameteriv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_tex_level_parameteriv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_tex_level_parameteriv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_tex_level_parameteriv_reply_t ptr
declare function xcb_glx_is_list(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval list as ulong) as xcb_glx_is_list_cookie_t
declare function xcb_glx_is_list_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval list as ulong) as xcb_glx_is_list_cookie_t
declare function xcb_glx_is_list_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_is_list_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_is_list_reply_t ptr
declare function xcb_glx_flush_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_flush(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t) as xcb_void_cookie_t
declare function xcb_glx_are_textures_resident_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_are_textures_resident(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long, byval textures as const ulong ptr) as xcb_glx_are_textures_resident_cookie_t
declare function xcb_glx_are_textures_resident_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long, byval textures as const ulong ptr) as xcb_glx_are_textures_resident_cookie_t
declare function xcb_glx_are_textures_resident_data(byval R as const xcb_glx_are_textures_resident_reply_t ptr) as ubyte ptr
declare function xcb_glx_are_textures_resident_data_length(byval R as const xcb_glx_are_textures_resident_reply_t ptr) as long
declare function xcb_glx_are_textures_resident_data_end(byval R as const xcb_glx_are_textures_resident_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_are_textures_resident_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_are_textures_resident_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_are_textures_resident_reply_t ptr
declare function xcb_glx_delete_textures_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_delete_textures_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long, byval textures as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_delete_textures(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long, byval textures as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_gen_textures_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_gen_textures(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long) as xcb_glx_gen_textures_cookie_t
declare function xcb_glx_gen_textures_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long) as xcb_glx_gen_textures_cookie_t
declare function xcb_glx_gen_textures_data(byval R as const xcb_glx_gen_textures_reply_t ptr) as ulong ptr
declare function xcb_glx_gen_textures_data_length(byval R as const xcb_glx_gen_textures_reply_t ptr) as long
declare function xcb_glx_gen_textures_data_end(byval R as const xcb_glx_gen_textures_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_gen_textures_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_gen_textures_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_gen_textures_reply_t ptr
declare function xcb_glx_is_texture(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval texture as ulong) as xcb_glx_is_texture_cookie_t
declare function xcb_glx_is_texture_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval texture as ulong) as xcb_glx_is_texture_cookie_t
declare function xcb_glx_is_texture_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_is_texture_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_is_texture_reply_t ptr
declare function xcb_glx_get_color_table_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_color_table(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_color_table_cookie_t
declare function xcb_glx_get_color_table_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_color_table_cookie_t
declare function xcb_glx_get_color_table_data(byval R as const xcb_glx_get_color_table_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_color_table_data_length(byval R as const xcb_glx_get_color_table_reply_t ptr) as long
declare function xcb_glx_get_color_table_data_end(byval R as const xcb_glx_get_color_table_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_color_table_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_color_table_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_color_table_reply_t ptr
declare function xcb_glx_get_color_table_parameterfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_color_table_parameterfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_color_table_parameterfv_cookie_t
declare function xcb_glx_get_color_table_parameterfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_color_table_parameterfv_cookie_t
declare function xcb_glx_get_color_table_parameterfv_data(byval R as const xcb_glx_get_color_table_parameterfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_color_table_parameterfv_data_length(byval R as const xcb_glx_get_color_table_parameterfv_reply_t ptr) as long
declare function xcb_glx_get_color_table_parameterfv_data_end(byval R as const xcb_glx_get_color_table_parameterfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_color_table_parameterfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_color_table_parameterfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_color_table_parameterfv_reply_t ptr
declare function xcb_glx_get_color_table_parameteriv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_color_table_parameteriv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_color_table_parameteriv_cookie_t
declare function xcb_glx_get_color_table_parameteriv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_color_table_parameteriv_cookie_t
declare function xcb_glx_get_color_table_parameteriv_data(byval R as const xcb_glx_get_color_table_parameteriv_reply_t ptr) as long ptr
declare function xcb_glx_get_color_table_parameteriv_data_length(byval R as const xcb_glx_get_color_table_parameteriv_reply_t ptr) as long
declare function xcb_glx_get_color_table_parameteriv_data_end(byval R as const xcb_glx_get_color_table_parameteriv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_color_table_parameteriv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_color_table_parameteriv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_color_table_parameteriv_reply_t ptr
declare function xcb_glx_get_convolution_filter_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_convolution_filter(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_convolution_filter_cookie_t
declare function xcb_glx_get_convolution_filter_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_convolution_filter_cookie_t
declare function xcb_glx_get_convolution_filter_data(byval R as const xcb_glx_get_convolution_filter_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_convolution_filter_data_length(byval R as const xcb_glx_get_convolution_filter_reply_t ptr) as long
declare function xcb_glx_get_convolution_filter_data_end(byval R as const xcb_glx_get_convolution_filter_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_convolution_filter_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_convolution_filter_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_convolution_filter_reply_t ptr
declare function xcb_glx_get_convolution_parameterfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_convolution_parameterfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_convolution_parameterfv_cookie_t
declare function xcb_glx_get_convolution_parameterfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_convolution_parameterfv_cookie_t
declare function xcb_glx_get_convolution_parameterfv_data(byval R as const xcb_glx_get_convolution_parameterfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_convolution_parameterfv_data_length(byval R as const xcb_glx_get_convolution_parameterfv_reply_t ptr) as long
declare function xcb_glx_get_convolution_parameterfv_data_end(byval R as const xcb_glx_get_convolution_parameterfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_convolution_parameterfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_convolution_parameterfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_convolution_parameterfv_reply_t ptr
declare function xcb_glx_get_convolution_parameteriv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_convolution_parameteriv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_convolution_parameteriv_cookie_t
declare function xcb_glx_get_convolution_parameteriv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_convolution_parameteriv_cookie_t
declare function xcb_glx_get_convolution_parameteriv_data(byval R as const xcb_glx_get_convolution_parameteriv_reply_t ptr) as long ptr
declare function xcb_glx_get_convolution_parameteriv_data_length(byval R as const xcb_glx_get_convolution_parameteriv_reply_t ptr) as long
declare function xcb_glx_get_convolution_parameteriv_data_end(byval R as const xcb_glx_get_convolution_parameteriv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_convolution_parameteriv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_convolution_parameteriv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_convolution_parameteriv_reply_t ptr
declare function xcb_glx_get_separable_filter_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_separable_filter(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_separable_filter_cookie_t
declare function xcb_glx_get_separable_filter_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte) as xcb_glx_get_separable_filter_cookie_t
declare function xcb_glx_get_separable_filter_rows_and_cols(byval R as const xcb_glx_get_separable_filter_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_separable_filter_rows_and_cols_length(byval R as const xcb_glx_get_separable_filter_reply_t ptr) as long
declare function xcb_glx_get_separable_filter_rows_and_cols_end(byval R as const xcb_glx_get_separable_filter_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_separable_filter_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_separable_filter_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_separable_filter_reply_t ptr
declare function xcb_glx_get_histogram_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_histogram(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte, byval reset as ubyte) as xcb_glx_get_histogram_cookie_t
declare function xcb_glx_get_histogram_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte, byval reset as ubyte) as xcb_glx_get_histogram_cookie_t
declare function xcb_glx_get_histogram_data(byval R as const xcb_glx_get_histogram_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_histogram_data_length(byval R as const xcb_glx_get_histogram_reply_t ptr) as long
declare function xcb_glx_get_histogram_data_end(byval R as const xcb_glx_get_histogram_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_histogram_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_histogram_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_histogram_reply_t ptr
declare function xcb_glx_get_histogram_parameterfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_histogram_parameterfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_histogram_parameterfv_cookie_t
declare function xcb_glx_get_histogram_parameterfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_histogram_parameterfv_cookie_t
declare function xcb_glx_get_histogram_parameterfv_data(byval R as const xcb_glx_get_histogram_parameterfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_histogram_parameterfv_data_length(byval R as const xcb_glx_get_histogram_parameterfv_reply_t ptr) as long
declare function xcb_glx_get_histogram_parameterfv_data_end(byval R as const xcb_glx_get_histogram_parameterfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_histogram_parameterfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_histogram_parameterfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_histogram_parameterfv_reply_t ptr
declare function xcb_glx_get_histogram_parameteriv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_histogram_parameteriv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_histogram_parameteriv_cookie_t
declare function xcb_glx_get_histogram_parameteriv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_histogram_parameteriv_cookie_t
declare function xcb_glx_get_histogram_parameteriv_data(byval R as const xcb_glx_get_histogram_parameteriv_reply_t ptr) as long ptr
declare function xcb_glx_get_histogram_parameteriv_data_length(byval R as const xcb_glx_get_histogram_parameteriv_reply_t ptr) as long
declare function xcb_glx_get_histogram_parameteriv_data_end(byval R as const xcb_glx_get_histogram_parameteriv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_histogram_parameteriv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_histogram_parameteriv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_histogram_parameteriv_reply_t ptr
declare function xcb_glx_get_minmax_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_minmax(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte, byval reset as ubyte) as xcb_glx_get_minmax_cookie_t
declare function xcb_glx_get_minmax_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval format as ulong, byval type as ulong, byval swap_bytes as ubyte, byval reset as ubyte) as xcb_glx_get_minmax_cookie_t
declare function xcb_glx_get_minmax_data(byval R as const xcb_glx_get_minmax_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_minmax_data_length(byval R as const xcb_glx_get_minmax_reply_t ptr) as long
declare function xcb_glx_get_minmax_data_end(byval R as const xcb_glx_get_minmax_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_minmax_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_minmax_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_minmax_reply_t ptr
declare function xcb_glx_get_minmax_parameterfv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_minmax_parameterfv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_minmax_parameterfv_cookie_t
declare function xcb_glx_get_minmax_parameterfv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_minmax_parameterfv_cookie_t
declare function xcb_glx_get_minmax_parameterfv_data(byval R as const xcb_glx_get_minmax_parameterfv_reply_t ptr) as xcb_glx_float32_t ptr
declare function xcb_glx_get_minmax_parameterfv_data_length(byval R as const xcb_glx_get_minmax_parameterfv_reply_t ptr) as long
declare function xcb_glx_get_minmax_parameterfv_data_end(byval R as const xcb_glx_get_minmax_parameterfv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_minmax_parameterfv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_minmax_parameterfv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_minmax_parameterfv_reply_t ptr
declare function xcb_glx_get_minmax_parameteriv_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_minmax_parameteriv(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_minmax_parameteriv_cookie_t
declare function xcb_glx_get_minmax_parameteriv_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_minmax_parameteriv_cookie_t
declare function xcb_glx_get_minmax_parameteriv_data(byval R as const xcb_glx_get_minmax_parameteriv_reply_t ptr) as long ptr
declare function xcb_glx_get_minmax_parameteriv_data_length(byval R as const xcb_glx_get_minmax_parameteriv_reply_t ptr) as long
declare function xcb_glx_get_minmax_parameteriv_data_end(byval R as const xcb_glx_get_minmax_parameteriv_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_minmax_parameteriv_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_minmax_parameteriv_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_minmax_parameteriv_reply_t ptr
declare function xcb_glx_get_compressed_tex_image_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_compressed_tex_image_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long) as xcb_glx_get_compressed_tex_image_arb_cookie_t
declare function xcb_glx_get_compressed_tex_image_arb_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval level as long) as xcb_glx_get_compressed_tex_image_arb_cookie_t
declare function xcb_glx_get_compressed_tex_image_arb_data(byval R as const xcb_glx_get_compressed_tex_image_arb_reply_t ptr) as ubyte ptr
declare function xcb_glx_get_compressed_tex_image_arb_data_length(byval R as const xcb_glx_get_compressed_tex_image_arb_reply_t ptr) as long
declare function xcb_glx_get_compressed_tex_image_arb_data_end(byval R as const xcb_glx_get_compressed_tex_image_arb_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_compressed_tex_image_arb_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_compressed_tex_image_arb_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_compressed_tex_image_arb_reply_t ptr
declare function xcb_glx_delete_queries_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_delete_queries_arb_checked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long, byval ids as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_delete_queries_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long, byval ids as const ulong ptr) as xcb_void_cookie_t
declare function xcb_glx_gen_queries_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_gen_queries_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long) as xcb_glx_gen_queries_arb_cookie_t
declare function xcb_glx_gen_queries_arb_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval n as long) as xcb_glx_gen_queries_arb_cookie_t
declare function xcb_glx_gen_queries_arb_data(byval R as const xcb_glx_gen_queries_arb_reply_t ptr) as ulong ptr
declare function xcb_glx_gen_queries_arb_data_length(byval R as const xcb_glx_gen_queries_arb_reply_t ptr) as long
declare function xcb_glx_gen_queries_arb_data_end(byval R as const xcb_glx_gen_queries_arb_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_gen_queries_arb_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_gen_queries_arb_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_gen_queries_arb_reply_t ptr
declare function xcb_glx_is_query_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval id as ulong) as xcb_glx_is_query_arb_cookie_t
declare function xcb_glx_is_query_arb_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval id as ulong) as xcb_glx_is_query_arb_cookie_t
declare function xcb_glx_is_query_arb_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_is_query_arb_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_is_query_arb_reply_t ptr
declare function xcb_glx_get_queryiv_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_queryiv_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_queryiv_arb_cookie_t
declare function xcb_glx_get_queryiv_arb_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval target as ulong, byval pname as ulong) as xcb_glx_get_queryiv_arb_cookie_t
declare function xcb_glx_get_queryiv_arb_data(byval R as const xcb_glx_get_queryiv_arb_reply_t ptr) as long ptr
declare function xcb_glx_get_queryiv_arb_data_length(byval R as const xcb_glx_get_queryiv_arb_reply_t ptr) as long
declare function xcb_glx_get_queryiv_arb_data_end(byval R as const xcb_glx_get_queryiv_arb_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_queryiv_arb_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_queryiv_arb_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_queryiv_arb_reply_t ptr
declare function xcb_glx_get_query_objectiv_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_query_objectiv_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval id as ulong, byval pname as ulong) as xcb_glx_get_query_objectiv_arb_cookie_t
declare function xcb_glx_get_query_objectiv_arb_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval id as ulong, byval pname as ulong) as xcb_glx_get_query_objectiv_arb_cookie_t
declare function xcb_glx_get_query_objectiv_arb_data(byval R as const xcb_glx_get_query_objectiv_arb_reply_t ptr) as long ptr
declare function xcb_glx_get_query_objectiv_arb_data_length(byval R as const xcb_glx_get_query_objectiv_arb_reply_t ptr) as long
declare function xcb_glx_get_query_objectiv_arb_data_end(byval R as const xcb_glx_get_query_objectiv_arb_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_query_objectiv_arb_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_query_objectiv_arb_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_query_objectiv_arb_reply_t ptr
declare function xcb_glx_get_query_objectuiv_arb_sizeof(byval _buffer as const any ptr) as long
declare function xcb_glx_get_query_objectuiv_arb(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval id as ulong, byval pname as ulong) as xcb_glx_get_query_objectuiv_arb_cookie_t
declare function xcb_glx_get_query_objectuiv_arb_unchecked(byval c as xcb_connection_t ptr, byval context_tag as xcb_glx_context_tag_t, byval id as ulong, byval pname as ulong) as xcb_glx_get_query_objectuiv_arb_cookie_t
declare function xcb_glx_get_query_objectuiv_arb_data(byval R as const xcb_glx_get_query_objectuiv_arb_reply_t ptr) as ulong ptr
declare function xcb_glx_get_query_objectuiv_arb_data_length(byval R as const xcb_glx_get_query_objectuiv_arb_reply_t ptr) as long
declare function xcb_glx_get_query_objectuiv_arb_data_end(byval R as const xcb_glx_get_query_objectuiv_arb_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_glx_get_query_objectuiv_arb_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_glx_get_query_objectuiv_arb_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_glx_get_query_objectuiv_arb_reply_t ptr

end extern
