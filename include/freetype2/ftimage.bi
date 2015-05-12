''
''
'' ftimage -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ftimage_bi__
#define __ftimage_bi__

type FT_Pos as integer

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

enum FT_Pixel_Mode_
	FT_PIXEL_MODE_NONE = 0
	FT_PIXEL_MODE_MONO
	FT_PIXEL_MODE_GRAY
	FT_PIXEL_MODE_GRAY2
	FT_PIXEL_MODE_GRAY4
	FT_PIXEL_MODE_LCD
	FT_PIXEL_MODE_LCD_V
	FT_PIXEL_MODE_MAX
end enum

type FT_Pixel_Mode as FT_Pixel_Mode_

type FT_Bitmap_
	rows as integer
	width as integer
	pitch as integer
	buffer as ubyte ptr
	num_grays as short
	pixel_mode as byte
	palette_mode as byte
	palette as any ptr
end type

type FT_Bitmap as FT_Bitmap_

type FT_Outline_
	n_contours as short
	n_points as short
	points as FT_Vector ptr
	tags as zstring ptr
	contours as short ptr
	flags as integer
end type

type FT_Outline as FT_Outline_

#define FT_OUTLINE_NONE &h0
#define FT_OUTLINE_OWNER &h1
#define FT_OUTLINE_EVEN_ODD_FILL &h2
#define FT_OUTLINE_REVERSE_FILL &h4
#define FT_OUTLINE_IGNORE_DROPOUTS &h8
#define FT_OUTLINE_HIGH_PRECISION &h100
#define FT_OUTLINE_SINGLE_PASS &h200
#define ft_outline_none &h0
#define ft_outline_owner &h1
#define ft_outline_even_odd_fill &h2
#define ft_outline_reverse_fill &h4
#define ft_outline_ignore_dropouts &h8
#define ft_outline_high_precision &h100
#define ft_outline_single_pass &h200
#define FT_CURVE_TAG_ON 1
#define FT_CURVE_TAG_CONIC 0
#define FT_CURVE_TAG_CUBIC 2
#define FT_CURVE_TAG_TOUCH_X 8
#define FT_CURVE_TAG_TOUCH_Y 16
#define FT_CURVE_TAG_TOUCH_BOTH (8 or 16)
#define FT_Curve_Tag_On 1
#define FT_Curve_Tag_Conic 0
#define FT_Curve_Tag_Cubic 2
#define FT_Curve_Tag_Touch_X 8
#define FT_Curve_Tag_Touch_Y 16

type FT_Outline_MoveToFunc as function cdecl(byval as FT_Vector ptr, byval as any ptr) as integer
type FT_Outline_LineToFunc as function cdecl(byval as FT_Vector ptr, byval as any ptr) as integer
type FT_Outline_ConicToFunc as function cdecl(byval as FT_Vector ptr, byval as FT_Vector ptr, byval as any ptr) as integer
type FT_Outline_CubicToFunc as function cdecl(byval as FT_Vector ptr, byval as FT_Vector ptr, byval as FT_Vector ptr, byval as any ptr) as integer

type FT_Outline_Funcs_
	move_to as FT_Outline_MoveToFunc
	line_to as FT_Outline_LineToFunc
	conic_to as FT_Outline_ConicToFunc
	cubic_to as FT_Outline_CubicToFunc
	shift as integer
	delta as FT_Pos
end type

type FT_Outline_Funcs as FT_Outline_Funcs_

#define FT_IMAGE_TAG( value, _x1, _x2, _x3, _x4 ) _
          value = ( (cuint(_x1) shl 24) or (cuint(_x2) shl 16) or (cuint(_x3) shl 8) or cuint(_x4))

enum FT_Glyph_Format_
    FT_IMAGE_TAG( FT_GLYPH_FORMAT_NONE, 0, 0, 0, 0 )

    FT_IMAGE_TAG( FT_GLYPH_FORMAT_COMPOSITE, asc("c"), asc("o"), asc("m"), asc("p") )
    FT_IMAGE_TAG( FT_GLYPH_FORMAT_BITMAP,    asc("b"), asc("i"), asc("t"), asc("s") )
    FT_IMAGE_TAG( FT_GLYPH_FORMAT_OUTLINE,   asc("o"), asc("u"), asc("t"), asc("l") )
    FT_IMAGE_TAG( FT_GLYPH_FORMAT_PLOTTER,   asc("p"), asc("l"), asc("o"), asc("t") )
end enum

type FT_Glyph_Format as FT_Glyph_Format_

type FT_Raster as FT_RasterRec_ ptr

type FT_Span_
	x as short
	len as ushort
	coverage as ubyte
end type

type FT_Span as FT_Span_
type FT_SpanFunc as sub cdecl(byval as integer, byval as integer, byval as FT_Span ptr, byval as any ptr)
type FT_Raster_BitTest_Func as function cdecl(byval as integer, byval as integer, byval as any ptr) as integer
type FT_Raster_BitSet_Func as sub cdecl(byval as integer, byval as integer, byval as any ptr)

#define FT_RASTER_FLAG_DEFAULT &h0
#define FT_RASTER_FLAG_AA &h1
#define FT_RASTER_FLAG_DIRECT &h2
#define FT_RASTER_FLAG_CLIP &h4
#define ft_raster_flag_default &h0
#define ft_raster_flag_aa &h1
#define ft_raster_flag_direct &h2
#define ft_raster_flag_clip &h4

type FT_Raster_Params_
	target as FT_Bitmap ptr
	source as any ptr
	flags as integer
	gray_spans as FT_SpanFunc
	black_spans as FT_SpanFunc
	bit_test as FT_Raster_BitTest_Func
	bit_set as FT_Raster_BitSet_Func
	user as any ptr
	clip_box as FT_BBox
end type

type FT_Raster_Params as FT_Raster_Params_
type FT_Raster_NewFunc as function cdecl(byval as any ptr, byval as FT_Raster ptr) as integer
type FT_Raster_DoneFunc as sub cdecl(byval as FT_Raster)
type FT_Raster_ResetFunc as sub cdecl(byval as FT_Raster, byval as ubyte ptr, byval as uinteger)
type FT_Raster_SetModeFunc as function cdecl(byval as FT_Raster, byval as uinteger, byval as any ptr) as integer
type FT_Raster_RenderFunc as function cdecl(byval as FT_Raster, byval as FT_Raster_Params ptr) as integer

type FT_Raster_Funcs_
	''glyph_format as FT_Glyph_Format
	raster_new as FT_Raster_NewFunc
	raster_reset as FT_Raster_ResetFunc
	raster_set_mode as FT_Raster_SetModeFunc
	raster_render as FT_Raster_RenderFunc
	raster_done as FT_Raster_DoneFunc
end type

type FT_Raster_Funcs as FT_Raster_Funcs_

#endif
