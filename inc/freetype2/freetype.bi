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

#inclib "freetype"

#include once "crt/long.bi"
#include once "config/ftconfig.bi"
#include once "fttypes.bi"
#include once "fterrors.bi"

extern "C"

#define __FREETYPE_H__

type FT_Glyph_Metrics_
	width as FT_Pos
	height as FT_Pos
	horiBearingX as FT_Pos
	horiBearingY as FT_Pos
	horiAdvance as FT_Pos
	vertBearingX as FT_Pos
	vertBearingY as FT_Pos
	vertAdvance as FT_Pos
end type

type FT_Glyph_Metrics as FT_Glyph_Metrics_

type FT_Bitmap_Size_
	height as FT_Short
	width as FT_Short
	size as FT_Pos
	x_ppem as FT_Pos
	y_ppem as FT_Pos
end type

type FT_Bitmap_Size as FT_Bitmap_Size_
type FT_Library as FT_LibraryRec_ ptr
type FT_Module as FT_ModuleRec_ ptr
type FT_Driver as FT_DriverRec_ ptr
type FT_Renderer as FT_RendererRec_ ptr
type FT_Face as FT_FaceRec_ ptr
type FT_Size as FT_SizeRec_ ptr
type FT_GlyphSlot as FT_GlyphSlotRec_ ptr
type FT_CharMap as FT_CharMapRec_ ptr

type FT_Encoding_ as long
enum
	FT_ENCODING_NONE = (((cast(FT_UInt32, 0) shl 24) or (cast(FT_UInt32, 0) shl 16)) or (cast(FT_UInt32, 0) shl 8)) or cast(FT_UInt32, 0)
	FT_ENCODING_MS_SYMBOL = (((cast(FT_UInt32, asc("s")) shl 24) or (cast(FT_UInt32, asc("y")) shl 16)) or (cast(FT_UInt32, asc("m")) shl 8)) or cast(FT_UInt32, asc("b"))
	FT_ENCODING_UNICODE = (((cast(FT_UInt32, asc("u")) shl 24) or (cast(FT_UInt32, asc("n")) shl 16)) or (cast(FT_UInt32, asc("i")) shl 8)) or cast(FT_UInt32, asc("c"))
	FT_ENCODING_SJIS = (((cast(FT_UInt32, asc("s")) shl 24) or (cast(FT_UInt32, asc("j")) shl 16)) or (cast(FT_UInt32, asc("i")) shl 8)) or cast(FT_UInt32, asc("s"))
	FT_ENCODING_GB2312 = (((cast(FT_UInt32, asc("g")) shl 24) or (cast(FT_UInt32, asc("b")) shl 16)) or (cast(FT_UInt32, asc(" ")) shl 8)) or cast(FT_UInt32, asc(" "))
	FT_ENCODING_BIG5 = (((cast(FT_UInt32, asc("b")) shl 24) or (cast(FT_UInt32, asc("i")) shl 16)) or (cast(FT_UInt32, asc("g")) shl 8)) or cast(FT_UInt32, asc("5"))
	FT_ENCODING_WANSUNG = (((cast(FT_UInt32, asc("w")) shl 24) or (cast(FT_UInt32, asc("a")) shl 16)) or (cast(FT_UInt32, asc("n")) shl 8)) or cast(FT_UInt32, asc("s"))
	FT_ENCODING_JOHAB = (((cast(FT_UInt32, asc("j")) shl 24) or (cast(FT_UInt32, asc("o")) shl 16)) or (cast(FT_UInt32, asc("h")) shl 8)) or cast(FT_UInt32, asc("a"))
	FT_ENCODING_MS_SJIS = FT_ENCODING_SJIS
	FT_ENCODING_MS_GB2312 = FT_ENCODING_GB2312
	FT_ENCODING_MS_BIG5 = FT_ENCODING_BIG5
	FT_ENCODING_MS_WANSUNG = FT_ENCODING_WANSUNG
	FT_ENCODING_MS_JOHAB = FT_ENCODING_JOHAB
	FT_ENCODING_ADOBE_STANDARD = (((cast(FT_UInt32, asc("A")) shl 24) or (cast(FT_UInt32, asc("D")) shl 16)) or (cast(FT_UInt32, asc("O")) shl 8)) or cast(FT_UInt32, asc("B"))
	FT_ENCODING_ADOBE_EXPERT = (((cast(FT_UInt32, asc("A")) shl 24) or (cast(FT_UInt32, asc("D")) shl 16)) or (cast(FT_UInt32, asc("B")) shl 8)) or cast(FT_UInt32, asc("E"))
	FT_ENCODING_ADOBE_CUSTOM = (((cast(FT_UInt32, asc("A")) shl 24) or (cast(FT_UInt32, asc("D")) shl 16)) or (cast(FT_UInt32, asc("B")) shl 8)) or cast(FT_UInt32, asc("C"))
	FT_ENCODING_ADOBE_LATIN_1 = (((cast(FT_UInt32, asc("l")) shl 24) or (cast(FT_UInt32, asc("a")) shl 16)) or (cast(FT_UInt32, asc("t")) shl 8)) or cast(FT_UInt32, asc("1"))
	FT_ENCODING_OLD_LATIN_2 = (((cast(FT_UInt32, asc("l")) shl 24) or (cast(FT_UInt32, asc("a")) shl 16)) or (cast(FT_UInt32, asc("t")) shl 8)) or cast(FT_UInt32, asc("2"))
	FT_ENCODING_APPLE_ROMAN = (((cast(FT_UInt32, asc("a")) shl 24) or (cast(FT_UInt32, asc("r")) shl 16)) or (cast(FT_UInt32, asc("m")) shl 8)) or cast(FT_UInt32, asc("n"))
end enum

type FT_Encoding as FT_Encoding_

type FT_CharMapRec_
	face as FT_Face
	encoding as FT_Encoding
	platform_id as FT_UShort
	encoding_id as FT_UShort
end type

type FT_CharMapRec as FT_CharMapRec_
type FT_Face_Internal as FT_Face_InternalRec_ ptr

type FT_FaceRec_
	num_faces as FT_Long
	face_index as FT_Long
	face_flags as FT_Long
	style_flags as FT_Long
	num_glyphs as FT_Long
	family_name as FT_String ptr
	style_name as FT_String ptr
	num_fixed_sizes as FT_Int
	available_sizes as FT_Bitmap_Size ptr
	num_charmaps as FT_Int
	charmaps as FT_CharMap ptr
	generic as FT_Generic
	bbox as FT_BBox
	units_per_EM as FT_UShort
	ascender as FT_Short
	descender as FT_Short
	height as FT_Short
	max_advance_width as FT_Short
	max_advance_height as FT_Short
	underline_position as FT_Short
	underline_thickness as FT_Short
	glyph as FT_GlyphSlot
	size as FT_Size
	charmap as FT_CharMap
	driver as FT_Driver
	memory as FT_Memory
	stream as FT_Stream
	sizes_list as FT_ListRec
	autohint as FT_Generic
	extensions as any ptr
	internal as FT_Face_Internal
end type

type FT_FaceRec as FT_FaceRec_
const FT_FACE_FLAG_SCALABLE = cast(clong, 1) shl 0
const FT_FACE_FLAG_FIXED_SIZES = cast(clong, 1) shl 1
const FT_FACE_FLAG_FIXED_WIDTH = cast(clong, 1) shl 2
const FT_FACE_FLAG_SFNT = cast(clong, 1) shl 3
const FT_FACE_FLAG_HORIZONTAL = cast(clong, 1) shl 4
const FT_FACE_FLAG_VERTICAL = cast(clong, 1) shl 5
const FT_FACE_FLAG_KERNING = cast(clong, 1) shl 6
const FT_FACE_FLAG_FAST_GLYPHS = cast(clong, 1) shl 7
const FT_FACE_FLAG_MULTIPLE_MASTERS = cast(clong, 1) shl 8
const FT_FACE_FLAG_GLYPH_NAMES = cast(clong, 1) shl 9
const FT_FACE_FLAG_EXTERNAL_STREAM = cast(clong, 1) shl 10
const FT_FACE_FLAG_HINTER = cast(clong, 1) shl 11
const FT_FACE_FLAG_CID_KEYED = cast(clong, 1) shl 12
const FT_FACE_FLAG_TRICKY = cast(clong, 1) shl 13
const FT_FACE_FLAG_COLOR = cast(clong, 1) shl 14
#define FT_HAS_HORIZONTAL(face) (face->face_flags and FT_FACE_FLAG_HORIZONTAL)
#define FT_HAS_VERTICAL(face) (face->face_flags and FT_FACE_FLAG_VERTICAL)
#define FT_HAS_KERNING(face) (face->face_flags and FT_FACE_FLAG_KERNING)
#define FT_IS_SCALABLE(face) (face->face_flags and FT_FACE_FLAG_SCALABLE)
#define FT_IS_SFNT(face) (face->face_flags and FT_FACE_FLAG_SFNT)
#define FT_IS_FIXED_WIDTH(face) (face->face_flags and FT_FACE_FLAG_FIXED_WIDTH)
#define FT_HAS_FIXED_SIZES(face) (face->face_flags and FT_FACE_FLAG_FIXED_SIZES)
#define FT_HAS_FAST_GLYPHS(face) 0
#define FT_HAS_GLYPH_NAMES(face) (face->face_flags and FT_FACE_FLAG_GLYPH_NAMES)
#define FT_HAS_MULTIPLE_MASTERS(face) (face->face_flags and FT_FACE_FLAG_MULTIPLE_MASTERS)
#define FT_IS_CID_KEYED(face) (face->face_flags and FT_FACE_FLAG_CID_KEYED)
#define FT_IS_TRICKY(face) (face->face_flags and FT_FACE_FLAG_TRICKY)
#define FT_HAS_COLOR(face) (face->face_flags and FT_FACE_FLAG_COLOR)
const FT_STYLE_FLAG_ITALIC = 1 shl 0
const FT_STYLE_FLAG_BOLD = 1 shl 1
type FT_Size_Internal as FT_Size_InternalRec_ ptr

type FT_Size_Metrics_
	x_ppem as FT_UShort
	y_ppem as FT_UShort
	x_scale as FT_Fixed
	y_scale as FT_Fixed
	ascender as FT_Pos
	descender as FT_Pos
	height as FT_Pos
	max_advance as FT_Pos
end type

type FT_Size_Metrics as FT_Size_Metrics_

type FT_SizeRec_
	face as FT_Face
	generic as FT_Generic
	metrics as FT_Size_Metrics
	internal as FT_Size_Internal
end type

type FT_SizeRec as FT_SizeRec_
type FT_SubGlyph as FT_SubGlyphRec_ ptr
type FT_Slot_Internal as FT_Slot_InternalRec_ ptr

type FT_GlyphSlotRec_
	library as FT_Library
	face as FT_Face
	next as FT_GlyphSlot
	reserved as FT_UInt
	generic as FT_Generic
	metrics as FT_Glyph_Metrics
	linearHoriAdvance as FT_Fixed
	linearVertAdvance as FT_Fixed
	advance as FT_Vector
	format as FT_Glyph_Format
	bitmap as FT_Bitmap
	bitmap_left as FT_Int
	bitmap_top as FT_Int
	outline as FT_Outline
	num_subglyphs as FT_UInt
	subglyphs as FT_SubGlyph
	control_data as any ptr
	control_len as clong
	lsb_delta as FT_Pos
	rsb_delta as FT_Pos
	other as any ptr
	internal as FT_Slot_Internal
end type

type FT_GlyphSlotRec as FT_GlyphSlotRec_
declare function FT_Init_FreeType(byval alibrary as FT_Library ptr) as FT_Error
declare function FT_Done_FreeType(byval library as FT_Library) as FT_Error
const FT_OPEN_MEMORY = &h1
const FT_OPEN_STREAM = &h2
const FT_OPEN_PATHNAME = &h4
const FT_OPEN_DRIVER = &h8
const FT_OPEN_PARAMS = &h10

type FT_Parameter_
	tag as FT_ULong
	data as FT_Pointer
end type

type FT_Parameter as FT_Parameter_

type FT_Open_Args_
	flags as FT_UInt
	memory_base as const FT_Byte ptr
	memory_size as FT_Long
	pathname as FT_String ptr
	stream as FT_Stream
	driver as FT_Module
	num_params as FT_Int
	params as FT_Parameter ptr
end type

type FT_Open_Args as FT_Open_Args_
declare function FT_New_Face(byval library as FT_Library, byval filepathname as const zstring ptr, byval face_index as FT_Long, byval aface as FT_Face ptr) as FT_Error
declare function FT_New_Memory_Face(byval library as FT_Library, byval file_base as const FT_Byte ptr, byval file_size as FT_Long, byval face_index as FT_Long, byval aface as FT_Face ptr) as FT_Error
declare function FT_Open_Face(byval library as FT_Library, byval args as const FT_Open_Args ptr, byval face_index as FT_Long, byval aface as FT_Face ptr) as FT_Error
declare function FT_Attach_File(byval face as FT_Face, byval filepathname as const zstring ptr) as FT_Error
declare function FT_Attach_Stream(byval face as FT_Face, byval parameters as FT_Open_Args ptr) as FT_Error
declare function FT_Reference_Face(byval face as FT_Face) as FT_Error
declare function FT_Done_Face(byval face as FT_Face) as FT_Error
declare function FT_Select_Size(byval face as FT_Face, byval strike_index as FT_Int) as FT_Error

type FT_Size_Request_Type_ as long
enum
	FT_SIZE_REQUEST_TYPE_NOMINAL
	FT_SIZE_REQUEST_TYPE_REAL_DIM
	FT_SIZE_REQUEST_TYPE_BBOX
	FT_SIZE_REQUEST_TYPE_CELL
	FT_SIZE_REQUEST_TYPE_SCALES
	FT_SIZE_REQUEST_TYPE_MAX
end enum

type FT_Size_Request_Type as FT_Size_Request_Type_

type FT_Size_RequestRec_
	as FT_Size_Request_Type type
	width as FT_Long
	height as FT_Long
	horiResolution as FT_UInt
	vertResolution as FT_UInt
end type

type FT_Size_RequestRec as FT_Size_RequestRec_
type FT_Size_Request as FT_Size_RequestRec_ ptr
declare function FT_Request_Size(byval face as FT_Face, byval req as FT_Size_Request) as FT_Error
declare function FT_Set_Char_Size(byval face as FT_Face, byval char_width as FT_F26Dot6, byval char_height as FT_F26Dot6, byval horz_resolution as FT_UInt, byval vert_resolution as FT_UInt) as FT_Error
declare function FT_Set_Pixel_Sizes(byval face as FT_Face, byval pixel_width as FT_UInt, byval pixel_height as FT_UInt) as FT_Error
declare function FT_Load_Glyph(byval face as FT_Face, byval glyph_index as FT_UInt, byval load_flags as FT_Int32) as FT_Error
declare function FT_Load_Char(byval face as FT_Face, byval char_code as FT_ULong, byval load_flags as FT_Int32) as FT_Error

const FT_LOAD_DEFAULT = &h0
const FT_LOAD_NO_SCALE = cast(clong, 1) shl 0
const FT_LOAD_NO_HINTING = cast(clong, 1) shl 1
const FT_LOAD_RENDER = cast(clong, 1) shl 2
const FT_LOAD_NO_BITMAP = cast(clong, 1) shl 3
const FT_LOAD_VERTICAL_LAYOUT = cast(clong, 1) shl 4
const FT_LOAD_FORCE_AUTOHINT = cast(clong, 1) shl 5
const FT_LOAD_CROP_BITMAP = cast(clong, 1) shl 6
const FT_LOAD_PEDANTIC = cast(clong, 1) shl 7
const FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH = cast(clong, 1) shl 9
const FT_LOAD_NO_RECURSE = cast(clong, 1) shl 10
const FT_LOAD_IGNORE_TRANSFORM = cast(clong, 1) shl 11
const FT_LOAD_MONOCHROME = cast(clong, 1) shl 12
const FT_LOAD_LINEAR_DESIGN = cast(clong, 1) shl 13
const FT_LOAD_NO_AUTOHINT = cast(clong, 1) shl 15
const FT_LOAD_COLOR = cast(clong, 1) shl 20
const FT_LOAD_ADVANCE_ONLY = cast(clong, 1) shl 8
const FT_LOAD_SBITS_ONLY = cast(clong, 1) shl 14
#define FT_LOAD_TARGET_(x) (cast(FT_Int32, (x) and 15) shl 16)
#define FT_LOAD_TARGET_NORMAL FT_LOAD_TARGET_(FT_RENDER_MODE_NORMAL)
#define FT_LOAD_TARGET_LIGHT FT_LOAD_TARGET_(FT_RENDER_MODE_LIGHT)
#define FT_LOAD_TARGET_MONO FT_LOAD_TARGET_(FT_RENDER_MODE_MONO)
#define FT_LOAD_TARGET_LCD FT_LOAD_TARGET_(FT_RENDER_MODE_LCD)
#define FT_LOAD_TARGET_LCD_V FT_LOAD_TARGET_(FT_RENDER_MODE_LCD_V)
#define FT_LOAD_TARGET_MODE(x) cast(FT_Render_Mode, ((x) shr 16) and 15)
declare sub FT_Set_Transform(byval face as FT_Face, byval matrix as FT_Matrix ptr, byval delta as FT_Vector ptr)

type FT_Render_Mode_ as long
enum
	FT_RENDER_MODE_NORMAL = 0
	FT_RENDER_MODE_LIGHT
	FT_RENDER_MODE_MONO
	FT_RENDER_MODE_LCD
	FT_RENDER_MODE_LCD_V
	FT_RENDER_MODE_MAX
end enum

type FT_Render_Mode as FT_Render_Mode_
declare function FT_Render_Glyph(byval slot as FT_GlyphSlot, byval render_mode as FT_Render_Mode) as FT_Error

type FT_Kerning_Mode_ as long
enum
	FT_KERNING_DEFAULT = 0
	FT_KERNING_UNFITTED
	FT_KERNING_UNSCALED
end enum

type FT_Kerning_Mode as FT_Kerning_Mode_
declare function FT_Get_Kerning(byval face as FT_Face, byval left_glyph as FT_UInt, byval right_glyph as FT_UInt, byval kern_mode as FT_UInt, byval akerning as FT_Vector ptr) as FT_Error
declare function FT_Get_Track_Kerning(byval face as FT_Face, byval point_size as FT_Fixed, byval degree as FT_Int, byval akerning as FT_Fixed ptr) as FT_Error
declare function FT_Get_Glyph_Name(byval face as FT_Face, byval glyph_index as FT_UInt, byval buffer as FT_Pointer, byval buffer_max as FT_UInt) as FT_Error
declare function FT_Get_Postscript_Name(byval face as FT_Face) as const zstring ptr
declare function FT_Select_Charmap(byval face as FT_Face, byval encoding as FT_Encoding) as FT_Error
declare function FT_Set_Charmap(byval face as FT_Face, byval charmap as FT_CharMap) as FT_Error
declare function FT_Get_Charmap_Index(byval charmap as FT_CharMap) as FT_Int
declare function FT_Get_Char_Index(byval face as FT_Face, byval charcode as FT_ULong) as FT_UInt
declare function FT_Get_First_Char(byval face as FT_Face, byval agindex as FT_UInt ptr) as FT_ULong
declare function FT_Get_Next_Char(byval face as FT_Face, byval char_code as FT_ULong, byval agindex as FT_UInt ptr) as FT_ULong
declare function FT_Get_Name_Index(byval face as FT_Face, byval glyph_name as FT_String ptr) as FT_UInt

const FT_SUBGLYPH_FLAG_ARGS_ARE_WORDS = 1
const FT_SUBGLYPH_FLAG_ARGS_ARE_XY_VALUES = 2
const FT_SUBGLYPH_FLAG_ROUND_XY_TO_GRID = 4
const FT_SUBGLYPH_FLAG_SCALE = 8
const FT_SUBGLYPH_FLAG_XY_SCALE = &h40
const FT_SUBGLYPH_FLAG_2X2 = &h80
const FT_SUBGLYPH_FLAG_USE_MY_METRICS = &h200
declare function FT_Get_SubGlyph_Info(byval glyph as FT_GlyphSlot, byval sub_index as FT_UInt, byval p_index as FT_Int ptr, byval p_flags as FT_UInt ptr, byval p_arg1 as FT_Int ptr, byval p_arg2 as FT_Int ptr, byval p_transform as FT_Matrix ptr) as FT_Error
const FT_FSTYPE_INSTALLABLE_EMBEDDING = &h0000
const FT_FSTYPE_RESTRICTED_LICENSE_EMBEDDING = &h0002
const FT_FSTYPE_PREVIEW_AND_PRINT_EMBEDDING = &h0004
const FT_FSTYPE_EDITABLE_EMBEDDING = &h0008
const FT_FSTYPE_NO_SUBSETTING = &h0100
const FT_FSTYPE_BITMAP_EMBEDDING_ONLY = &h0200

declare function FT_Get_FSType_Flags(byval face as FT_Face) as FT_UShort
declare function FT_Face_GetCharVariantIndex(byval face as FT_Face, byval charcode as FT_ULong, byval variantSelector as FT_ULong) as FT_UInt
declare function FT_Face_GetCharVariantIsDefault(byval face as FT_Face, byval charcode as FT_ULong, byval variantSelector as FT_ULong) as FT_Int
declare function FT_Face_GetVariantSelectors(byval face as FT_Face) as FT_UInt32 ptr
declare function FT_Face_GetVariantsOfChar(byval face as FT_Face, byval charcode as FT_ULong) as FT_UInt32 ptr
declare function FT_Face_GetCharsOfVariant(byval face as FT_Face, byval variantSelector as FT_ULong) as FT_UInt32 ptr
declare function FT_MulDiv(byval a as FT_Long, byval b as FT_Long, byval c as FT_Long) as FT_Long
declare function FT_MulFix(byval a as FT_Long, byval b as FT_Long) as FT_Long
declare function FT_DivFix(byval a as FT_Long, byval b as FT_Long) as FT_Long
declare function FT_RoundFix(byval a as FT_Fixed) as FT_Fixed
declare function FT_CeilFix(byval a as FT_Fixed) as FT_Fixed
declare function FT_FloorFix(byval a as FT_Fixed) as FT_Fixed
declare sub FT_Vector_Transform(byval vec as FT_Vector ptr, byval matrix as const FT_Matrix ptr)

const FREETYPE_MAJOR = 2
const FREETYPE_MINOR = 6
const FREETYPE_PATCH = 0

declare sub FT_Library_Version(byval library as FT_Library, byval amajor as FT_Int ptr, byval aminor as FT_Int ptr, byval apatch as FT_Int ptr)
declare function FT_Face_CheckTrueTypePatents(byval face as FT_Face) as FT_Bool
declare function FT_Face_SetUnpatentedHinting(byval face as FT_Face, byval value as FT_Bool) as FT_Bool

end extern
