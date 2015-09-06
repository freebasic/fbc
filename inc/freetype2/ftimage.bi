'' FreeBASIC binding for freetype-2.6
''
'' based on the C header files:
''   /*    FreeType high-level API and common types (specification only).       */
''   /*                                                                         */
''   /*  Copyright 1996-2015 by                                                 */
''   /*  David Turner, Robert Wilhelm, and Werner Lemberg.                      */
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 2 of the License, or
''   (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"

extern "C"

#define __FTIMAGE_H__
type FT_Pos as clong

type FT_Vector_
	x as FT_Pos
	y as FT_Pos
end type

type FT_Vector as FT_Vector_

type FT_BBox_
	xMin as FT_Pos
	yMin as FT_Pos
	xMax as FT_Pos
	yMax as FT_Pos
end type

type FT_BBox as FT_BBox_

type FT_Pixel_Mode_ as long
enum
	FT_PIXEL_MODE_NONE = 0
	FT_PIXEL_MODE_MONO
	FT_PIXEL_MODE_GRAY
	FT_PIXEL_MODE_GRAY2
	FT_PIXEL_MODE_GRAY4
	FT_PIXEL_MODE_LCD
	FT_PIXEL_MODE_LCD_V
	FT_PIXEL_MODE_BGRA
	FT_PIXEL_MODE_MAX
end enum

type FT_Pixel_Mode as FT_Pixel_Mode_

type FT_Bitmap_
	rows as ulong
	width as ulong
	pitch as long
	buffer as ubyte ptr
	num_grays as ushort
	pixel_mode as ubyte
	palette_mode as ubyte
	palette as any ptr
end type

type FT_Bitmap as FT_Bitmap_

type FT_Outline_
	n_contours as short
	n_points as short
	points as FT_Vector ptr
	tags as zstring ptr
	contours as short ptr
	flags as long
end type

type FT_Outline as FT_Outline_
#define FT_OUTLINE_CONTOURS_MAX SHRT_MAX
#define FT_OUTLINE_POINTS_MAX SHRT_MAX
const FT_OUTLINE_NONE = &h0
const FT_OUTLINE_OWNER = &h1
const FT_OUTLINE_EVEN_ODD_FILL = &h2
const FT_OUTLINE_REVERSE_FILL = &h4
const FT_OUTLINE_IGNORE_DROPOUTS = &h8
const FT_OUTLINE_SMART_DROPOUTS = &h10
const FT_OUTLINE_INCLUDE_STUBS = &h20
const FT_OUTLINE_HIGH_PRECISION = &h100
const FT_OUTLINE_SINGLE_PASS = &h200
#define FT_CURVE_TAG(flag) (flag and 3)
const FT_CURVE_TAG_ON = 1
const FT_CURVE_TAG_CONIC = 0
const FT_CURVE_TAG_CUBIC = 2
const FT_CURVE_TAG_HAS_SCANMODE = 4
const FT_CURVE_TAG_TOUCH_X = 8
const FT_CURVE_TAG_TOUCH_Y = 16
const FT_CURVE_TAG_TOUCH_BOTH = FT_CURVE_TAG_TOUCH_X or FT_CURVE_TAG_TOUCH_Y

type FT_Outline_MoveToFunc as function(byval to as const FT_Vector ptr, byval user as any ptr) as long
type FT_Outline_MoveTo_Func as FT_Outline_MoveToFunc
type FT_Outline_LineToFunc as function(byval to as const FT_Vector ptr, byval user as any ptr) as long
type FT_Outline_LineTo_Func as FT_Outline_LineToFunc
type FT_Outline_ConicToFunc as function(byval control as const FT_Vector ptr, byval to as const FT_Vector ptr, byval user as any ptr) as long
type FT_Outline_ConicTo_Func as FT_Outline_ConicToFunc
type FT_Outline_CubicToFunc as function(byval control1 as const FT_Vector ptr, byval control2 as const FT_Vector ptr, byval to as const FT_Vector ptr, byval user as any ptr) as long
type FT_Outline_CubicTo_Func as FT_Outline_CubicToFunc

type FT_Outline_Funcs_
	move_to as FT_Outline_MoveToFunc
	line_to as FT_Outline_LineToFunc
	conic_to as FT_Outline_ConicToFunc
	cubic_to as FT_Outline_CubicToFunc
	shift as long
	delta as FT_Pos
end type

type FT_Outline_Funcs as FT_Outline_Funcs_

type FT_Glyph_Format_ as long
enum
	FT_GLYPH_FORMAT_NONE = (((cast(culong, 0) shl 24) or (cast(culong, 0) shl 16)) or (cast(culong, 0) shl 8)) or cast(culong, 0)
	FT_GLYPH_FORMAT_COMPOSITE = (((cast(culong, asc("c")) shl 24) or (cast(culong, asc("o")) shl 16)) or (cast(culong, asc("m")) shl 8)) or cast(culong, asc("p"))
	FT_GLYPH_FORMAT_BITMAP = (((cast(culong, asc("b")) shl 24) or (cast(culong, asc("i")) shl 16)) or (cast(culong, asc("t")) shl 8)) or cast(culong, asc("s"))
	FT_GLYPH_FORMAT_OUTLINE = (((cast(culong, asc("o")) shl 24) or (cast(culong, asc("u")) shl 16)) or (cast(culong, asc("t")) shl 8)) or cast(culong, asc("l"))
	FT_GLYPH_FORMAT_PLOTTER = (((cast(culong, asc("p")) shl 24) or (cast(culong, asc("l")) shl 16)) or (cast(culong, asc("o")) shl 8)) or cast(culong, asc("t"))
end enum

type FT_Glyph_Format as FT_Glyph_Format_
type FT_Raster as FT_RasterRec_ ptr

type FT_Span_
	x as short
	len as ushort
	coverage as ubyte
end type

type FT_Span as FT_Span_
type FT_SpanFunc as sub(byval y as long, byval count as long, byval spans as const FT_Span ptr, byval user as any ptr)
type FT_Raster_Span_Func as FT_SpanFunc
type FT_Raster_BitTest_Func as function(byval y as long, byval x as long, byval user as any ptr) as long
type FT_Raster_BitSet_Func as sub(byval y as long, byval x as long, byval user as any ptr)

const FT_RASTER_FLAG_DEFAULT = &h0
const FT_RASTER_FLAG_AA = &h1
const FT_RASTER_FLAG_DIRECT = &h2
const FT_RASTER_FLAG_CLIP = &h4

type FT_Raster_Params_
	target as const FT_Bitmap ptr
	source as const any ptr
	flags as long
	gray_spans as FT_SpanFunc
	black_spans as FT_SpanFunc
	bit_test as FT_Raster_BitTest_Func
	bit_set as FT_Raster_BitSet_Func
	user as any ptr
	clip_box as FT_BBox
end type

type FT_Raster_Params as FT_Raster_Params_
type FT_Raster_NewFunc as function(byval memory as any ptr, byval raster as FT_Raster ptr) as long
type FT_Raster_New_Func as FT_Raster_NewFunc
type FT_Raster_DoneFunc as sub(byval raster as FT_Raster)
type FT_Raster_Done_Func as FT_Raster_DoneFunc
type FT_Raster_ResetFunc as sub(byval raster as FT_Raster, byval pool_base as ubyte ptr, byval pool_size as culong)
type FT_Raster_Reset_Func as FT_Raster_ResetFunc
type FT_Raster_SetModeFunc as function(byval raster as FT_Raster, byval mode as culong, byval args as any ptr) as long
type FT_Raster_Set_Mode_Func as FT_Raster_SetModeFunc
type FT_Raster_RenderFunc as function(byval raster as FT_Raster, byval params as const FT_Raster_Params ptr) as long
type FT_Raster_Render_Func as FT_Raster_RenderFunc

type FT_Raster_Funcs_
	glyph_format as FT_Glyph_Format
	raster_new as FT_Raster_NewFunc
	raster_reset as FT_Raster_ResetFunc
	raster_set_mode as FT_Raster_SetModeFunc
	raster_render as FT_Raster_RenderFunc
	raster_done as FT_Raster_DoneFunc
end type

type FT_Raster_Funcs as FT_Raster_Funcs_

end extern
