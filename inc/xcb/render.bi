'' FreeBASIC binding for libxcb-1.11, xcb-proto-1.11
''
'' based on the C header files:
''   Copyright (C) 2002-2004 Carl D. Worth, Jamey Sharp, Bart Massey, Josh Triplett
''   All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person
''   obtaining a copy of this software and associated
''   documentation files (the "Software"), to deal in the
''   Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute,
''   sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so,
''   subject to the following conditions:
''
''   The above copyright notice and this permission notice shall
''   be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
''   KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
''   WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
''   PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS
''   BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
''   OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the names of the authors
''   or their institutions shall not be used in advertising or
''   otherwise to promote the sale, use or other dealings in this
''   Software without prior written authorization from the
''   authors.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "xcb.bi"
#include once "xproto.bi"
#include once "xcbext.bi"

'' The following symbols have been renamed:
''     constant XCB_RENDER_MAJOR_VERSION => XCB_RENDER_MAJOR_VERSION_
''     constant XCB_RENDER_MINOR_VERSION => XCB_RENDER_MINOR_VERSION_
''     constant XCB_RENDER_PICT_FORMAT => XCB_RENDER_PICT_FORMAT_
''     constant XCB_RENDER_PICTURE => XCB_RENDER_PICTURE_
''     constant XCB_RENDER_PICT_OP => XCB_RENDER_PICT_OP_
''     constant XCB_RENDER_GLYPH_SET => XCB_RENDER_GLYPH_SET_
''     constant XCB_RENDER_GLYPH => XCB_RENDER_GLYPH_
''     constant XCB_RENDER_QUERY_VERSION => XCB_RENDER_QUERY_VERSION_
''     constant XCB_RENDER_QUERY_PICT_FORMATS => XCB_RENDER_QUERY_PICT_FORMATS_
''     constant XCB_RENDER_QUERY_PICT_INDEX_VALUES => XCB_RENDER_QUERY_PICT_INDEX_VALUES_
''     constant XCB_RENDER_CREATE_PICTURE => XCB_RENDER_CREATE_PICTURE_
''     constant XCB_RENDER_CHANGE_PICTURE => XCB_RENDER_CHANGE_PICTURE_
''     constant XCB_RENDER_SET_PICTURE_CLIP_RECTANGLES => XCB_RENDER_SET_PICTURE_CLIP_RECTANGLES_
''     constant XCB_RENDER_FREE_PICTURE => XCB_RENDER_FREE_PICTURE_
''     constant XCB_RENDER_COMPOSITE => XCB_RENDER_COMPOSITE_
''     constant XCB_RENDER_TRAPEZOIDS => XCB_RENDER_TRAPEZOIDS_
''     constant XCB_RENDER_TRIANGLES => XCB_RENDER_TRIANGLES_
''     constant XCB_RENDER_TRI_STRIP => XCB_RENDER_TRI_STRIP_
''     constant XCB_RENDER_TRI_FAN => XCB_RENDER_TRI_FAN_
''     constant XCB_RENDER_CREATE_GLYPH_SET => XCB_RENDER_CREATE_GLYPH_SET_
''     constant XCB_RENDER_REFERENCE_GLYPH_SET => XCB_RENDER_REFERENCE_GLYPH_SET_
''     constant XCB_RENDER_FREE_GLYPH_SET => XCB_RENDER_FREE_GLYPH_SET_
''     constant XCB_RENDER_ADD_GLYPHS => XCB_RENDER_ADD_GLYPHS_
''     constant XCB_RENDER_FREE_GLYPHS => XCB_RENDER_FREE_GLYPHS_
''     constant XCB_RENDER_COMPOSITE_GLYPHS_8 => XCB_RENDER_COMPOSITE_GLYPHS_8_
''     constant XCB_RENDER_COMPOSITE_GLYPHS_16 => XCB_RENDER_COMPOSITE_GLYPHS_16_
''     constant XCB_RENDER_COMPOSITE_GLYPHS_32 => XCB_RENDER_COMPOSITE_GLYPHS_32_
''     constant XCB_RENDER_FILL_RECTANGLES => XCB_RENDER_FILL_RECTANGLES_
''     constant XCB_RENDER_CREATE_CURSOR => XCB_RENDER_CREATE_CURSOR_
''     constant XCB_RENDER_SET_PICTURE_TRANSFORM => XCB_RENDER_SET_PICTURE_TRANSFORM_
''     constant XCB_RENDER_QUERY_FILTERS => XCB_RENDER_QUERY_FILTERS_
''     constant XCB_RENDER_SET_PICTURE_FILTER => XCB_RENDER_SET_PICTURE_FILTER_
''     constant XCB_RENDER_CREATE_ANIM_CURSOR => XCB_RENDER_CREATE_ANIM_CURSOR_
''     constant XCB_RENDER_ADD_TRAPS => XCB_RENDER_ADD_TRAPS_
''     constant XCB_RENDER_CREATE_SOLID_FILL => XCB_RENDER_CREATE_SOLID_FILL_
''     constant XCB_RENDER_CREATE_LINEAR_GRADIENT => XCB_RENDER_CREATE_LINEAR_GRADIENT_
''     constant XCB_RENDER_CREATE_RADIAL_GRADIENT => XCB_RENDER_CREATE_RADIAL_GRADIENT_
''     constant XCB_RENDER_CREATE_CONICAL_GRADIENT => XCB_RENDER_CREATE_CONICAL_GRADIENT_

extern "C"

#define __RENDER_H
const XCB_RENDER_MAJOR_VERSION_ = 0
const XCB_RENDER_MINOR_VERSION_ = 11
extern xcb_render_id as xcb_extension_t

type xcb_render_pict_type_t as long
enum
	XCB_RENDER_PICT_TYPE_INDEXED = 0
	XCB_RENDER_PICT_TYPE_DIRECT = 1
end enum

type xcb_render_picture_enum_t as long
enum
	XCB_RENDER_PICTURE_NONE = 0
end enum

type xcb_render_pict_op_t as long
enum
	XCB_RENDER_PICT_OP_CLEAR = 0
	XCB_RENDER_PICT_OP_SRC = 1
	XCB_RENDER_PICT_OP_DST = 2
	XCB_RENDER_PICT_OP_OVER = 3
	XCB_RENDER_PICT_OP_OVER_REVERSE = 4
	XCB_RENDER_PICT_OP_IN = 5
	XCB_RENDER_PICT_OP_IN_REVERSE = 6
	XCB_RENDER_PICT_OP_OUT = 7
	XCB_RENDER_PICT_OP_OUT_REVERSE = 8
	XCB_RENDER_PICT_OP_ATOP = 9
	XCB_RENDER_PICT_OP_ATOP_REVERSE = 10
	XCB_RENDER_PICT_OP_XOR = 11
	XCB_RENDER_PICT_OP_ADD = 12
	XCB_RENDER_PICT_OP_SATURATE = 13
	XCB_RENDER_PICT_OP_DISJOINT_CLEAR = 16
	XCB_RENDER_PICT_OP_DISJOINT_SRC = 17
	XCB_RENDER_PICT_OP_DISJOINT_DST = 18
	XCB_RENDER_PICT_OP_DISJOINT_OVER = 19
	XCB_RENDER_PICT_OP_DISJOINT_OVER_REVERSE = 20
	XCB_RENDER_PICT_OP_DISJOINT_IN = 21
	XCB_RENDER_PICT_OP_DISJOINT_IN_REVERSE = 22
	XCB_RENDER_PICT_OP_DISJOINT_OUT = 23
	XCB_RENDER_PICT_OP_DISJOINT_OUT_REVERSE = 24
	XCB_RENDER_PICT_OP_DISJOINT_ATOP = 25
	XCB_RENDER_PICT_OP_DISJOINT_ATOP_REVERSE = 26
	XCB_RENDER_PICT_OP_DISJOINT_XOR = 27
	XCB_RENDER_PICT_OP_CONJOINT_CLEAR = 32
	XCB_RENDER_PICT_OP_CONJOINT_SRC = 33
	XCB_RENDER_PICT_OP_CONJOINT_DST = 34
	XCB_RENDER_PICT_OP_CONJOINT_OVER = 35
	XCB_RENDER_PICT_OP_CONJOINT_OVER_REVERSE = 36
	XCB_RENDER_PICT_OP_CONJOINT_IN = 37
	XCB_RENDER_PICT_OP_CONJOINT_IN_REVERSE = 38
	XCB_RENDER_PICT_OP_CONJOINT_OUT = 39
	XCB_RENDER_PICT_OP_CONJOINT_OUT_REVERSE = 40
	XCB_RENDER_PICT_OP_CONJOINT_ATOP = 41
	XCB_RENDER_PICT_OP_CONJOINT_ATOP_REVERSE = 42
	XCB_RENDER_PICT_OP_CONJOINT_XOR = 43
	XCB_RENDER_PICT_OP_MULTIPLY = 48
	XCB_RENDER_PICT_OP_SCREEN = 49
	XCB_RENDER_PICT_OP_OVERLAY = 50
	XCB_RENDER_PICT_OP_DARKEN = 51
	XCB_RENDER_PICT_OP_LIGHTEN = 52
	XCB_RENDER_PICT_OP_COLOR_DODGE = 53
	XCB_RENDER_PICT_OP_COLOR_BURN = 54
	XCB_RENDER_PICT_OP_HARD_LIGHT = 55
	XCB_RENDER_PICT_OP_SOFT_LIGHT = 56
	XCB_RENDER_PICT_OP_DIFFERENCE = 57
	XCB_RENDER_PICT_OP_EXCLUSION = 58
	XCB_RENDER_PICT_OP_HSL_HUE = 59
	XCB_RENDER_PICT_OP_HSL_SATURATION = 60
	XCB_RENDER_PICT_OP_HSL_COLOR = 61
	XCB_RENDER_PICT_OP_HSL_LUMINOSITY = 62
end enum

type xcb_render_poly_edge_t as long
enum
	XCB_RENDER_POLY_EDGE_SHARP = 0
	XCB_RENDER_POLY_EDGE_SMOOTH = 1
end enum

type xcb_render_poly_mode_t as long
enum
	XCB_RENDER_POLY_MODE_PRECISE = 0
	XCB_RENDER_POLY_MODE_IMPRECISE = 1
end enum

type xcb_render_cp_t as long
enum
	XCB_RENDER_CP_REPEAT = 1
	XCB_RENDER_CP_ALPHA_MAP = 2
	XCB_RENDER_CP_ALPHA_X_ORIGIN = 4
	XCB_RENDER_CP_ALPHA_Y_ORIGIN = 8
	XCB_RENDER_CP_CLIP_X_ORIGIN = 16
	XCB_RENDER_CP_CLIP_Y_ORIGIN = 32
	XCB_RENDER_CP_CLIP_MASK = 64
	XCB_RENDER_CP_GRAPHICS_EXPOSURE = 128
	XCB_RENDER_CP_SUBWINDOW_MODE = 256
	XCB_RENDER_CP_POLY_EDGE = 512
	XCB_RENDER_CP_POLY_MODE = 1024
	XCB_RENDER_CP_DITHER = 2048
	XCB_RENDER_CP_COMPONENT_ALPHA = 4096
end enum

type xcb_render_sub_pixel_t as long
enum
	XCB_RENDER_SUB_PIXEL_UNKNOWN = 0
	XCB_RENDER_SUB_PIXEL_HORIZONTAL_RGB = 1
	XCB_RENDER_SUB_PIXEL_HORIZONTAL_BGR = 2
	XCB_RENDER_SUB_PIXEL_VERTICAL_RGB = 3
	XCB_RENDER_SUB_PIXEL_VERTICAL_BGR = 4
	XCB_RENDER_SUB_PIXEL_NONE = 5
end enum

type xcb_render_repeat_t as long
enum
	XCB_RENDER_REPEAT_NONE = 0
	XCB_RENDER_REPEAT_NORMAL = 1
	XCB_RENDER_REPEAT_PAD = 2
	XCB_RENDER_REPEAT_REFLECT = 3
end enum

type xcb_render_glyph_t as ulong

type xcb_render_glyph_iterator_t
	data as xcb_render_glyph_t ptr
	as long rem
	index as long
end type

type xcb_render_glyphset_t as ulong

type xcb_render_glyphset_iterator_t
	data as xcb_render_glyphset_t ptr
	as long rem
	index as long
end type

type xcb_render_picture_t as ulong

type xcb_render_picture_iterator_t
	data as xcb_render_picture_t ptr
	as long rem
	index as long
end type

type xcb_render_pictformat_t as ulong

type xcb_render_pictformat_iterator_t
	data as xcb_render_pictformat_t ptr
	as long rem
	index as long
end type

type xcb_render_fixed_t as long

type xcb_render_fixed_iterator_t
	data as xcb_render_fixed_t ptr
	as long rem
	index as long
end type

const XCB_RENDER_PICT_FORMAT_ = 0

type xcb_render_pict_format_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RENDER_PICTURE_ = 1

type xcb_render_picture_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RENDER_PICT_OP_ = 2

type xcb_render_pict_op_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RENDER_GLYPH_SET_ = 3

type xcb_render_glyph_set_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

const XCB_RENDER_GLYPH_ = 4

type xcb_render_glyph_error_t
	response_type as ubyte
	error_code as ubyte
	sequence as ushort
end type

type xcb_render_directformat_t
	red_shift as ushort
	red_mask as ushort
	green_shift as ushort
	green_mask as ushort
	blue_shift as ushort
	blue_mask as ushort
	alpha_shift as ushort
	alpha_mask as ushort
end type

type xcb_render_directformat_iterator_t
	data as xcb_render_directformat_t ptr
	as long rem
	index as long
end type

type xcb_render_pictforminfo_t
	id as xcb_render_pictformat_t
	as ubyte type
	depth as ubyte
	pad0(0 to 1) as ubyte
	direct as xcb_render_directformat_t
	colormap as xcb_colormap_t
end type

type xcb_render_pictforminfo_iterator_t
	data as xcb_render_pictforminfo_t ptr
	as long rem
	index as long
end type

type xcb_render_pictvisual_t
	visual as xcb_visualid_t
	format as xcb_render_pictformat_t
end type

type xcb_render_pictvisual_iterator_t
	data as xcb_render_pictvisual_t ptr
	as long rem
	index as long
end type

type xcb_render_pictdepth_t
	depth as ubyte
	pad0 as ubyte
	num_visuals as ushort
	pad1(0 to 3) as ubyte
end type

type xcb_render_pictdepth_iterator_t
	data as xcb_render_pictdepth_t ptr
	as long rem
	index as long
end type

type xcb_render_pictscreen_t
	num_depths as ulong
	fallback as xcb_render_pictformat_t
end type

type xcb_render_pictscreen_iterator_t
	data as xcb_render_pictscreen_t ptr
	as long rem
	index as long
end type

type xcb_render_indexvalue_t
	pixel as ulong
	red as ushort
	green as ushort
	blue as ushort
	alpha as ushort
end type

type xcb_render_indexvalue_iterator_t
	data as xcb_render_indexvalue_t ptr
	as long rem
	index as long
end type

type xcb_render_color_t
	red as ushort
	green as ushort
	blue as ushort
	alpha as ushort
end type

type xcb_render_color_iterator_t
	data as xcb_render_color_t ptr
	as long rem
	index as long
end type

type xcb_render_pointfix_t
	x as xcb_render_fixed_t
	y as xcb_render_fixed_t
end type

type xcb_render_pointfix_iterator_t
	data as xcb_render_pointfix_t ptr
	as long rem
	index as long
end type

type xcb_render_linefix_t
	p1 as xcb_render_pointfix_t
	p2 as xcb_render_pointfix_t
end type

type xcb_render_linefix_iterator_t
	data as xcb_render_linefix_t ptr
	as long rem
	index as long
end type

type xcb_render_triangle_t
	p1 as xcb_render_pointfix_t
	p2 as xcb_render_pointfix_t
	p3 as xcb_render_pointfix_t
end type

type xcb_render_triangle_iterator_t
	data as xcb_render_triangle_t ptr
	as long rem
	index as long
end type

type xcb_render_trapezoid_t
	top as xcb_render_fixed_t
	bottom as xcb_render_fixed_t
	left as xcb_render_linefix_t
	right as xcb_render_linefix_t
end type

type xcb_render_trapezoid_iterator_t
	data as xcb_render_trapezoid_t ptr
	as long rem
	index as long
end type

type xcb_render_glyphinfo_t
	width as ushort
	height as ushort
	x as short
	y as short
	x_off as short
	y_off as short
end type

type xcb_render_glyphinfo_iterator_t
	data as xcb_render_glyphinfo_t ptr
	as long rem
	index as long
end type

type xcb_render_query_version_cookie_t
	sequence as ulong
end type

const XCB_RENDER_QUERY_VERSION_ = 0

type xcb_render_query_version_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	client_major_version as ulong
	client_minor_version as ulong
end type

type xcb_render_query_version_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	major_version as ulong
	minor_version as ulong
	pad1(0 to 15) as ubyte
end type

type xcb_render_query_pict_formats_cookie_t
	sequence as ulong
end type

const XCB_RENDER_QUERY_PICT_FORMATS_ = 1

type xcb_render_query_pict_formats_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
end type

type xcb_render_query_pict_formats_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_formats as ulong
	num_screens as ulong
	num_depths as ulong
	num_visuals as ulong
	num_subpixel as ulong
	pad1(0 to 3) as ubyte
end type

type xcb_render_query_pict_index_values_cookie_t
	sequence as ulong
end type

const XCB_RENDER_QUERY_PICT_INDEX_VALUES_ = 2

type xcb_render_query_pict_index_values_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	format as xcb_render_pictformat_t
end type

type xcb_render_query_pict_index_values_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_values as ulong
	pad1(0 to 19) as ubyte
end type

const XCB_RENDER_CREATE_PICTURE_ = 4

type xcb_render_create_picture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	pid as xcb_render_picture_t
	drawable as xcb_drawable_t
	format as xcb_render_pictformat_t
	value_mask as ulong
end type

const XCB_RENDER_CHANGE_PICTURE_ = 5

type xcb_render_change_picture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	value_mask as ulong
end type

const XCB_RENDER_SET_PICTURE_CLIP_RECTANGLES_ = 6

type xcb_render_set_picture_clip_rectangles_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	clip_x_origin as short
	clip_y_origin as short
end type

const XCB_RENDER_FREE_PICTURE_ = 7

type xcb_render_free_picture_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
end type

const XCB_RENDER_COMPOSITE_ = 8

type xcb_render_composite_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	mask as xcb_render_picture_t
	dst as xcb_render_picture_t
	src_x as short
	src_y as short
	mask_x as short
	mask_y as short
	dst_x as short
	dst_y as short
	width as ushort
	height as ushort
end type

const XCB_RENDER_TRAPEZOIDS_ = 10

type xcb_render_trapezoids_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_TRIANGLES_ = 11

type xcb_render_triangles_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_TRI_STRIP_ = 12

type xcb_render_tri_strip_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_TRI_FAN_ = 13

type xcb_render_tri_fan_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_CREATE_GLYPH_SET_ = 17

type xcb_render_create_glyph_set_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	gsid as xcb_render_glyphset_t
	format as xcb_render_pictformat_t
end type

const XCB_RENDER_REFERENCE_GLYPH_SET_ = 18

type xcb_render_reference_glyph_set_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	gsid as xcb_render_glyphset_t
	existing as xcb_render_glyphset_t
end type

const XCB_RENDER_FREE_GLYPH_SET_ = 19

type xcb_render_free_glyph_set_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	glyphset as xcb_render_glyphset_t
end type

const XCB_RENDER_ADD_GLYPHS_ = 20

type xcb_render_add_glyphs_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	glyphset as xcb_render_glyphset_t
	glyphs_len as ulong
end type

const XCB_RENDER_FREE_GLYPHS_ = 22

type xcb_render_free_glyphs_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	glyphset as xcb_render_glyphset_t
end type

const XCB_RENDER_COMPOSITE_GLYPHS_8_ = 23

type xcb_render_composite_glyphs_8_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	glyphset as xcb_render_glyphset_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_COMPOSITE_GLYPHS_16_ = 24

type xcb_render_composite_glyphs_16_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	glyphset as xcb_render_glyphset_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_COMPOSITE_GLYPHS_32_ = 25

type xcb_render_composite_glyphs_32_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	src as xcb_render_picture_t
	dst as xcb_render_picture_t
	mask_format as xcb_render_pictformat_t
	glyphset as xcb_render_glyphset_t
	src_x as short
	src_y as short
end type

const XCB_RENDER_FILL_RECTANGLES_ = 26

type xcb_render_fill_rectangles_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	op as ubyte
	pad0(0 to 2) as ubyte
	dst as xcb_render_picture_t
	color as xcb_render_color_t
end type

const XCB_RENDER_CREATE_CURSOR_ = 27

type xcb_render_create_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cid as xcb_cursor_t
	source as xcb_render_picture_t
	x as ushort
	y as ushort
end type

type xcb_render_transform_t
	matrix11 as xcb_render_fixed_t
	matrix12 as xcb_render_fixed_t
	matrix13 as xcb_render_fixed_t
	matrix21 as xcb_render_fixed_t
	matrix22 as xcb_render_fixed_t
	matrix23 as xcb_render_fixed_t
	matrix31 as xcb_render_fixed_t
	matrix32 as xcb_render_fixed_t
	matrix33 as xcb_render_fixed_t
end type

type xcb_render_transform_iterator_t
	data as xcb_render_transform_t ptr
	as long rem
	index as long
end type

const XCB_RENDER_SET_PICTURE_TRANSFORM_ = 28

type xcb_render_set_picture_transform_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	transform as xcb_render_transform_t
end type

type xcb_render_query_filters_cookie_t
	sequence as ulong
end type

const XCB_RENDER_QUERY_FILTERS_ = 29

type xcb_render_query_filters_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	drawable as xcb_drawable_t
end type

type xcb_render_query_filters_reply_t
	response_type as ubyte
	pad0 as ubyte
	sequence as ushort
	length as ulong
	num_aliases as ulong
	num_filters as ulong
	pad1(0 to 15) as ubyte
end type

const XCB_RENDER_SET_PICTURE_FILTER_ = 30

type xcb_render_set_picture_filter_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	filter_len as ushort
	pad0(0 to 1) as ubyte
end type

type xcb_render_animcursorelt_t
	cursor as xcb_cursor_t
	delay as ulong
end type

type xcb_render_animcursorelt_iterator_t
	data as xcb_render_animcursorelt_t ptr
	as long rem
	index as long
end type

const XCB_RENDER_CREATE_ANIM_CURSOR_ = 31

type xcb_render_create_anim_cursor_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	cid as xcb_cursor_t
end type

type xcb_render_spanfix_t
	l as xcb_render_fixed_t
	r as xcb_render_fixed_t
	y as xcb_render_fixed_t
end type

type xcb_render_spanfix_iterator_t
	data as xcb_render_spanfix_t ptr
	as long rem
	index as long
end type

type xcb_render_trap_t
	top as xcb_render_spanfix_t
	bot as xcb_render_spanfix_t
end type

type xcb_render_trap_iterator_t
	data as xcb_render_trap_t ptr
	as long rem
	index as long
end type

const XCB_RENDER_ADD_TRAPS_ = 32

type xcb_render_add_traps_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	x_off as short
	y_off as short
end type

const XCB_RENDER_CREATE_SOLID_FILL_ = 33

type xcb_render_create_solid_fill_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	color as xcb_render_color_t
end type

const XCB_RENDER_CREATE_LINEAR_GRADIENT_ = 34

type xcb_render_create_linear_gradient_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	p1 as xcb_render_pointfix_t
	p2 as xcb_render_pointfix_t
	num_stops as ulong
end type

const XCB_RENDER_CREATE_RADIAL_GRADIENT_ = 35

type xcb_render_create_radial_gradient_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	inner as xcb_render_pointfix_t
	outer as xcb_render_pointfix_t
	inner_radius as xcb_render_fixed_t
	outer_radius as xcb_render_fixed_t
	num_stops as ulong
end type

const XCB_RENDER_CREATE_CONICAL_GRADIENT_ = 36

type xcb_render_create_conical_gradient_request_t
	major_opcode as ubyte
	minor_opcode as ubyte
	length as ushort
	picture as xcb_render_picture_t
	center as xcb_render_pointfix_t
	angle as xcb_render_fixed_t
	num_stops as ulong
end type

declare sub xcb_render_glyph_next(byval i as xcb_render_glyph_iterator_t ptr)
declare function xcb_render_glyph_end(byval i as xcb_render_glyph_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_glyphset_next(byval i as xcb_render_glyphset_iterator_t ptr)
declare function xcb_render_glyphset_end(byval i as xcb_render_glyphset_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_picture_next(byval i as xcb_render_picture_iterator_t ptr)
declare function xcb_render_picture_end(byval i as xcb_render_picture_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_pictformat_next(byval i as xcb_render_pictformat_iterator_t ptr)
declare function xcb_render_pictformat_end(byval i as xcb_render_pictformat_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_fixed_next(byval i as xcb_render_fixed_iterator_t ptr)
declare function xcb_render_fixed_end(byval i as xcb_render_fixed_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_directformat_next(byval i as xcb_render_directformat_iterator_t ptr)
declare function xcb_render_directformat_end(byval i as xcb_render_directformat_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_pictforminfo_next(byval i as xcb_render_pictforminfo_iterator_t ptr)
declare function xcb_render_pictforminfo_end(byval i as xcb_render_pictforminfo_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_pictvisual_next(byval i as xcb_render_pictvisual_iterator_t ptr)
declare function xcb_render_pictvisual_end(byval i as xcb_render_pictvisual_iterator_t) as xcb_generic_iterator_t
declare function xcb_render_pictdepth_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_pictdepth_visuals(byval R as const xcb_render_pictdepth_t ptr) as xcb_render_pictvisual_t ptr
declare function xcb_render_pictdepth_visuals_length(byval R as const xcb_render_pictdepth_t ptr) as long
declare function xcb_render_pictdepth_visuals_iterator(byval R as const xcb_render_pictdepth_t ptr) as xcb_render_pictvisual_iterator_t
declare sub xcb_render_pictdepth_next(byval i as xcb_render_pictdepth_iterator_t ptr)
declare function xcb_render_pictdepth_end(byval i as xcb_render_pictdepth_iterator_t) as xcb_generic_iterator_t
declare function xcb_render_pictscreen_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_pictscreen_depths_length(byval R as const xcb_render_pictscreen_t ptr) as long
declare function xcb_render_pictscreen_depths_iterator(byval R as const xcb_render_pictscreen_t ptr) as xcb_render_pictdepth_iterator_t
declare sub xcb_render_pictscreen_next(byval i as xcb_render_pictscreen_iterator_t ptr)
declare function xcb_render_pictscreen_end(byval i as xcb_render_pictscreen_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_indexvalue_next(byval i as xcb_render_indexvalue_iterator_t ptr)
declare function xcb_render_indexvalue_end(byval i as xcb_render_indexvalue_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_color_next(byval i as xcb_render_color_iterator_t ptr)
declare function xcb_render_color_end(byval i as xcb_render_color_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_pointfix_next(byval i as xcb_render_pointfix_iterator_t ptr)
declare function xcb_render_pointfix_end(byval i as xcb_render_pointfix_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_linefix_next(byval i as xcb_render_linefix_iterator_t ptr)
declare function xcb_render_linefix_end(byval i as xcb_render_linefix_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_triangle_next(byval i as xcb_render_triangle_iterator_t ptr)
declare function xcb_render_triangle_end(byval i as xcb_render_triangle_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_trapezoid_next(byval i as xcb_render_trapezoid_iterator_t ptr)
declare function xcb_render_trapezoid_end(byval i as xcb_render_trapezoid_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_glyphinfo_next(byval i as xcb_render_glyphinfo_iterator_t ptr)
declare function xcb_render_glyphinfo_end(byval i as xcb_render_glyphinfo_iterator_t) as xcb_generic_iterator_t
declare function xcb_render_query_version(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_render_query_version_cookie_t
declare function xcb_render_query_version_unchecked(byval c as xcb_connection_t ptr, byval client_major_version as ulong, byval client_minor_version as ulong) as xcb_render_query_version_cookie_t
declare function xcb_render_query_version_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_render_query_version_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_render_query_version_reply_t ptr
declare function xcb_render_query_pict_formats_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_query_pict_formats(byval c as xcb_connection_t ptr) as xcb_render_query_pict_formats_cookie_t
declare function xcb_render_query_pict_formats_unchecked(byval c as xcb_connection_t ptr) as xcb_render_query_pict_formats_cookie_t
declare function xcb_render_query_pict_formats_formats(byval R as const xcb_render_query_pict_formats_reply_t ptr) as xcb_render_pictforminfo_t ptr
declare function xcb_render_query_pict_formats_formats_length(byval R as const xcb_render_query_pict_formats_reply_t ptr) as long
declare function xcb_render_query_pict_formats_formats_iterator(byval R as const xcb_render_query_pict_formats_reply_t ptr) as xcb_render_pictforminfo_iterator_t
declare function xcb_render_query_pict_formats_screens_length(byval R as const xcb_render_query_pict_formats_reply_t ptr) as long
declare function xcb_render_query_pict_formats_screens_iterator(byval R as const xcb_render_query_pict_formats_reply_t ptr) as xcb_render_pictscreen_iterator_t
declare function xcb_render_query_pict_formats_subpixels(byval R as const xcb_render_query_pict_formats_reply_t ptr) as ulong ptr
declare function xcb_render_query_pict_formats_subpixels_length(byval R as const xcb_render_query_pict_formats_reply_t ptr) as long
declare function xcb_render_query_pict_formats_subpixels_end(byval R as const xcb_render_query_pict_formats_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_render_query_pict_formats_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_render_query_pict_formats_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_render_query_pict_formats_reply_t ptr
declare function xcb_render_query_pict_index_values_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_query_pict_index_values(byval c as xcb_connection_t ptr, byval format as xcb_render_pictformat_t) as xcb_render_query_pict_index_values_cookie_t
declare function xcb_render_query_pict_index_values_unchecked(byval c as xcb_connection_t ptr, byval format as xcb_render_pictformat_t) as xcb_render_query_pict_index_values_cookie_t
declare function xcb_render_query_pict_index_values_values(byval R as const xcb_render_query_pict_index_values_reply_t ptr) as xcb_render_indexvalue_t ptr
declare function xcb_render_query_pict_index_values_values_length(byval R as const xcb_render_query_pict_index_values_reply_t ptr) as long
declare function xcb_render_query_pict_index_values_values_iterator(byval R as const xcb_render_query_pict_index_values_reply_t ptr) as xcb_render_indexvalue_iterator_t
declare function xcb_render_query_pict_index_values_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_render_query_pict_index_values_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_render_query_pict_index_values_reply_t ptr
declare function xcb_render_create_picture_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_create_picture_checked(byval c as xcb_connection_t ptr, byval pid as xcb_render_picture_t, byval drawable as xcb_drawable_t, byval format as xcb_render_pictformat_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_render_create_picture(byval c as xcb_connection_t ptr, byval pid as xcb_render_picture_t, byval drawable as xcb_drawable_t, byval format as xcb_render_pictformat_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_render_change_picture_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_change_picture_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_render_change_picture(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval value_mask as ulong, byval value_list as const ulong ptr) as xcb_void_cookie_t
declare function xcb_render_set_picture_clip_rectangles_sizeof(byval _buffer as const any ptr, byval rectangles_len as ulong) as long
declare function xcb_render_set_picture_clip_rectangles_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval clip_x_origin as short, byval clip_y_origin as short, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_render_set_picture_clip_rectangles(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval clip_x_origin as short, byval clip_y_origin as short, byval rectangles_len as ulong, byval rectangles as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_render_free_picture_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t) as xcb_void_cookie_t
declare function xcb_render_free_picture(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t) as xcb_void_cookie_t
declare function xcb_render_composite_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval mask as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval src_x as short, byval src_y as short, byval mask_x as short, byval mask_y as short, byval dst_x as short, byval dst_y as short, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_render_composite(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval mask as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval src_x as short, byval src_y as short, byval mask_x as short, byval mask_y as short, byval dst_x as short, byval dst_y as short, byval width as ushort, byval height as ushort) as xcb_void_cookie_t
declare function xcb_render_trapezoids_sizeof(byval _buffer as const any ptr, byval traps_len as ulong) as long
declare function xcb_render_trapezoids_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval traps_len as ulong, byval traps as const xcb_render_trapezoid_t ptr) as xcb_void_cookie_t
declare function xcb_render_trapezoids(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval traps_len as ulong, byval traps as const xcb_render_trapezoid_t ptr) as xcb_void_cookie_t
declare function xcb_render_triangles_sizeof(byval _buffer as const any ptr, byval triangles_len as ulong) as long
declare function xcb_render_triangles_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval triangles_len as ulong, byval triangles as const xcb_render_triangle_t ptr) as xcb_void_cookie_t
declare function xcb_render_triangles(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval triangles_len as ulong, byval triangles as const xcb_render_triangle_t ptr) as xcb_void_cookie_t
declare function xcb_render_tri_strip_sizeof(byval _buffer as const any ptr, byval points_len as ulong) as long
declare function xcb_render_tri_strip_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval points_len as ulong, byval points as const xcb_render_pointfix_t ptr) as xcb_void_cookie_t
declare function xcb_render_tri_strip(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval points_len as ulong, byval points as const xcb_render_pointfix_t ptr) as xcb_void_cookie_t
declare function xcb_render_tri_fan_sizeof(byval _buffer as const any ptr, byval points_len as ulong) as long
declare function xcb_render_tri_fan_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval points_len as ulong, byval points as const xcb_render_pointfix_t ptr) as xcb_void_cookie_t
declare function xcb_render_tri_fan(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval src_x as short, byval src_y as short, byval points_len as ulong, byval points as const xcb_render_pointfix_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_glyph_set_checked(byval c as xcb_connection_t ptr, byval gsid as xcb_render_glyphset_t, byval format as xcb_render_pictformat_t) as xcb_void_cookie_t
declare function xcb_render_create_glyph_set(byval c as xcb_connection_t ptr, byval gsid as xcb_render_glyphset_t, byval format as xcb_render_pictformat_t) as xcb_void_cookie_t
declare function xcb_render_reference_glyph_set_checked(byval c as xcb_connection_t ptr, byval gsid as xcb_render_glyphset_t, byval existing as xcb_render_glyphset_t) as xcb_void_cookie_t
declare function xcb_render_reference_glyph_set(byval c as xcb_connection_t ptr, byval gsid as xcb_render_glyphset_t, byval existing as xcb_render_glyphset_t) as xcb_void_cookie_t
declare function xcb_render_free_glyph_set_checked(byval c as xcb_connection_t ptr, byval glyphset as xcb_render_glyphset_t) as xcb_void_cookie_t
declare function xcb_render_free_glyph_set(byval c as xcb_connection_t ptr, byval glyphset as xcb_render_glyphset_t) as xcb_void_cookie_t
declare function xcb_render_add_glyphs_sizeof(byval _buffer as const any ptr, byval data_len as ulong) as long
declare function xcb_render_add_glyphs_checked(byval c as xcb_connection_t ptr, byval glyphset as xcb_render_glyphset_t, byval glyphs_len as ulong, byval glyphids as const ulong ptr, byval glyphs as const xcb_render_glyphinfo_t ptr, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_add_glyphs(byval c as xcb_connection_t ptr, byval glyphset as xcb_render_glyphset_t, byval glyphs_len as ulong, byval glyphids as const ulong ptr, byval glyphs as const xcb_render_glyphinfo_t ptr, byval data_len as ulong, byval data as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_free_glyphs_sizeof(byval _buffer as const any ptr, byval glyphs_len as ulong) as long
declare function xcb_render_free_glyphs_checked(byval c as xcb_connection_t ptr, byval glyphset as xcb_render_glyphset_t, byval glyphs_len as ulong, byval glyphs as const xcb_render_glyph_t ptr) as xcb_void_cookie_t
declare function xcb_render_free_glyphs(byval c as xcb_connection_t ptr, byval glyphset as xcb_render_glyphset_t, byval glyphs_len as ulong, byval glyphs as const xcb_render_glyph_t ptr) as xcb_void_cookie_t
declare function xcb_render_composite_glyphs_8_sizeof(byval _buffer as const any ptr, byval glyphcmds_len as ulong) as long
declare function xcb_render_composite_glyphs_8_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval glyphset as xcb_render_glyphset_t, byval src_x as short, byval src_y as short, byval glyphcmds_len as ulong, byval glyphcmds as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_composite_glyphs_8(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval glyphset as xcb_render_glyphset_t, byval src_x as short, byval src_y as short, byval glyphcmds_len as ulong, byval glyphcmds as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_composite_glyphs_16_sizeof(byval _buffer as const any ptr, byval glyphcmds_len as ulong) as long
declare function xcb_render_composite_glyphs_16_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval glyphset as xcb_render_glyphset_t, byval src_x as short, byval src_y as short, byval glyphcmds_len as ulong, byval glyphcmds as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_composite_glyphs_16(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval glyphset as xcb_render_glyphset_t, byval src_x as short, byval src_y as short, byval glyphcmds_len as ulong, byval glyphcmds as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_composite_glyphs_32_sizeof(byval _buffer as const any ptr, byval glyphcmds_len as ulong) as long
declare function xcb_render_composite_glyphs_32_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval glyphset as xcb_render_glyphset_t, byval src_x as short, byval src_y as short, byval glyphcmds_len as ulong, byval glyphcmds as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_composite_glyphs_32(byval c as xcb_connection_t ptr, byval op as ubyte, byval src as xcb_render_picture_t, byval dst as xcb_render_picture_t, byval mask_format as xcb_render_pictformat_t, byval glyphset as xcb_render_glyphset_t, byval src_x as short, byval src_y as short, byval glyphcmds_len as ulong, byval glyphcmds as const ubyte ptr) as xcb_void_cookie_t
declare function xcb_render_fill_rectangles_sizeof(byval _buffer as const any ptr, byval rects_len as ulong) as long
declare function xcb_render_fill_rectangles_checked(byval c as xcb_connection_t ptr, byval op as ubyte, byval dst as xcb_render_picture_t, byval color as xcb_render_color_t, byval rects_len as ulong, byval rects as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_render_fill_rectangles(byval c as xcb_connection_t ptr, byval op as ubyte, byval dst as xcb_render_picture_t, byval color as xcb_render_color_t, byval rects_len as ulong, byval rects as const xcb_rectangle_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_cursor_checked(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval source as xcb_render_picture_t, byval x as ushort, byval y as ushort) as xcb_void_cookie_t
declare function xcb_render_create_cursor(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval source as xcb_render_picture_t, byval x as ushort, byval y as ushort) as xcb_void_cookie_t
declare sub xcb_render_transform_next(byval i as xcb_render_transform_iterator_t ptr)
declare function xcb_render_transform_end(byval i as xcb_render_transform_iterator_t) as xcb_generic_iterator_t
declare function xcb_render_set_picture_transform_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval transform as xcb_render_transform_t) as xcb_void_cookie_t
declare function xcb_render_set_picture_transform(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval transform as xcb_render_transform_t) as xcb_void_cookie_t
declare function xcb_render_query_filters_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_query_filters(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_render_query_filters_cookie_t
declare function xcb_render_query_filters_unchecked(byval c as xcb_connection_t ptr, byval drawable as xcb_drawable_t) as xcb_render_query_filters_cookie_t
declare function xcb_render_query_filters_aliases(byval R as const xcb_render_query_filters_reply_t ptr) as ushort ptr
declare function xcb_render_query_filters_aliases_length(byval R as const xcb_render_query_filters_reply_t ptr) as long
declare function xcb_render_query_filters_aliases_end(byval R as const xcb_render_query_filters_reply_t ptr) as xcb_generic_iterator_t
declare function xcb_render_query_filters_filters_length(byval R as const xcb_render_query_filters_reply_t ptr) as long
declare function xcb_render_query_filters_filters_iterator(byval R as const xcb_render_query_filters_reply_t ptr) as xcb_str_iterator_t
declare function xcb_render_query_filters_reply(byval c as xcb_connection_t ptr, byval cookie as xcb_render_query_filters_cookie_t, byval e as xcb_generic_error_t ptr ptr) as xcb_render_query_filters_reply_t ptr
declare function xcb_render_set_picture_filter_sizeof(byval _buffer as const any ptr, byval values_len as ulong) as long
declare function xcb_render_set_picture_filter_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval filter_len as ushort, byval filter as const zstring ptr, byval values_len as ulong, byval values as const xcb_render_fixed_t ptr) as xcb_void_cookie_t
declare function xcb_render_set_picture_filter(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval filter_len as ushort, byval filter as const zstring ptr, byval values_len as ulong, byval values as const xcb_render_fixed_t ptr) as xcb_void_cookie_t
declare sub xcb_render_animcursorelt_next(byval i as xcb_render_animcursorelt_iterator_t ptr)
declare function xcb_render_animcursorelt_end(byval i as xcb_render_animcursorelt_iterator_t) as xcb_generic_iterator_t
declare function xcb_render_create_anim_cursor_sizeof(byval _buffer as const any ptr, byval cursors_len as ulong) as long
declare function xcb_render_create_anim_cursor_checked(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval cursors_len as ulong, byval cursors as const xcb_render_animcursorelt_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_anim_cursor(byval c as xcb_connection_t ptr, byval cid as xcb_cursor_t, byval cursors_len as ulong, byval cursors as const xcb_render_animcursorelt_t ptr) as xcb_void_cookie_t
declare sub xcb_render_spanfix_next(byval i as xcb_render_spanfix_iterator_t ptr)
declare function xcb_render_spanfix_end(byval i as xcb_render_spanfix_iterator_t) as xcb_generic_iterator_t
declare sub xcb_render_trap_next(byval i as xcb_render_trap_iterator_t ptr)
declare function xcb_render_trap_end(byval i as xcb_render_trap_iterator_t) as xcb_generic_iterator_t
declare function xcb_render_add_traps_sizeof(byval _buffer as const any ptr, byval traps_len as ulong) as long
declare function xcb_render_add_traps_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval x_off as short, byval y_off as short, byval traps_len as ulong, byval traps as const xcb_render_trap_t ptr) as xcb_void_cookie_t
declare function xcb_render_add_traps(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval x_off as short, byval y_off as short, byval traps_len as ulong, byval traps as const xcb_render_trap_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_solid_fill_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval color as xcb_render_color_t) as xcb_void_cookie_t
declare function xcb_render_create_solid_fill(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval color as xcb_render_color_t) as xcb_void_cookie_t
declare function xcb_render_create_linear_gradient_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_create_linear_gradient_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval p1 as xcb_render_pointfix_t, byval p2 as xcb_render_pointfix_t, byval num_stops as ulong, byval stops as const xcb_render_fixed_t ptr, byval colors as const xcb_render_color_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_linear_gradient(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval p1 as xcb_render_pointfix_t, byval p2 as xcb_render_pointfix_t, byval num_stops as ulong, byval stops as const xcb_render_fixed_t ptr, byval colors as const xcb_render_color_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_radial_gradient_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_create_radial_gradient_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval inner as xcb_render_pointfix_t, byval outer as xcb_render_pointfix_t, byval inner_radius as xcb_render_fixed_t, byval outer_radius as xcb_render_fixed_t, byval num_stops as ulong, byval stops as const xcb_render_fixed_t ptr, byval colors as const xcb_render_color_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_radial_gradient(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval inner as xcb_render_pointfix_t, byval outer as xcb_render_pointfix_t, byval inner_radius as xcb_render_fixed_t, byval outer_radius as xcb_render_fixed_t, byval num_stops as ulong, byval stops as const xcb_render_fixed_t ptr, byval colors as const xcb_render_color_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_conical_gradient_sizeof(byval _buffer as const any ptr) as long
declare function xcb_render_create_conical_gradient_checked(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval center as xcb_render_pointfix_t, byval angle as xcb_render_fixed_t, byval num_stops as ulong, byval stops as const xcb_render_fixed_t ptr, byval colors as const xcb_render_color_t ptr) as xcb_void_cookie_t
declare function xcb_render_create_conical_gradient(byval c as xcb_connection_t ptr, byval picture as xcb_render_picture_t, byval center as xcb_render_pointfix_t, byval angle as xcb_render_fixed_t, byval num_stops as ulong, byval stops as const xcb_render_fixed_t ptr, byval colors as const xcb_render_color_t ptr) as xcb_void_cookie_t

end extern
