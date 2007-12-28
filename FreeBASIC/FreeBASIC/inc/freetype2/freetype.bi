''
''
'' freetype -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __freetype_bi__
#define __freetype_bi__

#inclib "freetype"

#define FREETYPE_MAJOR 2
#define FREETYPE_MINOR 1
#define FREETYPE_PATCH 9

#include once "config/ftconfig.bi"
#include once "fterrors.bi"
#include once "fttypes.bi"

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

#define FT_ENC_TAG( value, a, b, c, d ) _
          value = ( ( cuint(a) shl 24 ) or ( cuint(b) shl 16 ) or ( cuint(c) shl  8 ) or cuint(d) )

enum  FT_Encoding_
    FT_ENC_TAG( FT_ENCODING_NONE, 0, 0, 0, 0 )

    FT_ENC_TAG( FT_ENCODING_MS_SYMBOL,  asc("s"), asc("y"), asc("m"), asc("b") )
    FT_ENC_TAG( FT_ENCODING_UNICODE,    asc("u"), asc("n"), asc("i"), asc("c") )

    FT_ENC_TAG( FT_ENCODING_SJIS,    asc("s"), asc("j"), asc("i"), asc("s") )
    FT_ENC_TAG( FT_ENCODING_GB2312,  asc("g"), asc("b"), asc(" "), asc(" ") )
    FT_ENC_TAG( FT_ENCODING_BIG5,    asc("b"), asc("i"), asc("g"), asc("5") )
    FT_ENC_TAG( FT_ENCODING_WANSUNG, asc("w"), asc("a"), asc("n"), asc("s") )
    FT_ENC_TAG( FT_ENCODING_JOHAB,   asc("j"), asc("o"), asc("h"), asc("a") )

    FT_ENCODING_MS_SJIS    = FT_ENCODING_SJIS
    FT_ENCODING_MS_GB2312  = FT_ENCODING_GB2312
    FT_ENCODING_MS_BIG5    = FT_ENCODING_BIG5
    FT_ENCODING_MS_WANSUNG = FT_ENCODING_WANSUNG
    FT_ENCODING_MS_JOHAB   = FT_ENCODING_JOHAB

    FT_ENC_TAG( FT_ENCODING_ADOBE_STANDARD, asc("A"), asc("D"), asc("O"), asc("B") )
    FT_ENC_TAG( FT_ENCODING_ADOBE_EXPERT,   asc("A"), asc("D"), asc("B"), asc("E") )
    FT_ENC_TAG( FT_ENCODING_ADOBE_CUSTOM,   asc("A"), asc("D"), asc("B"), asc("C") )
    FT_ENC_TAG( FT_ENCODING_ADOBE_LATIN_1,  asc("l"), asc("a"), asc("t"), asc("1") )

    FT_ENC_TAG( FT_ENCODING_OLD_LATIN_2, asc("l"), asc("a"), asc("t"), asc("2") )

    FT_ENC_TAG( FT_ENCODING_APPLE_ROMAN, asc("a"), asc("r"), asc("m"), asc("n") )
end enum

type FT_Encoding as FT_Encoding_

type FT_CharMap as FT_CharMapRec_ ptr

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

#define FT_FACE_FLAG_SCALABLE (1L shl 0)
#define FT_FACE_FLAG_FIXED_SIZES (1L shl 1)
#define FT_FACE_FLAG_FIXED_WIDTH (1L shl 2)
#define FT_FACE_FLAG_SFNT (1L shl 3)
#define FT_FACE_FLAG_HORIZONTAL (1L shl 4)
#define FT_FACE_FLAG_VERTICAL (1L shl 5)
#define FT_FACE_FLAG_KERNING (1L shl 6)
#define FT_FACE_FLAG_FAST_GLYPHS (1L shl 7)
#define FT_FACE_FLAG_MULTIPLE_MASTERS (1L shl 8)
#define FT_FACE_FLAG_GLYPH_NAMES (1L shl 9)
#define FT_FACE_FLAG_EXTERNAL_STREAM (1L shl 10)
#define FT_STYLE_FLAG_ITALIC (1 shl 0)
#define FT_STYLE_FLAG_BOLD (1 shl 1)

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
	control_len as integer
	lsb_delta as FT_Pos
	rsb_delta as FT_Pos
	other as any ptr
	internal as FT_Slot_Internal
end type

type FT_GlyphSlotRec as FT_GlyphSlotRec_

#define FT_OPEN_MEMORY &h1
#define FT_OPEN_STREAM &h2
#define FT_OPEN_PATHNAME &h4
#define FT_OPEN_DRIVER &h8
#define FT_OPEN_PARAMS &h10
#define ft_open_memory &h1
#define ft_open_stream &h2
#define ft_open_pathname &h4
#define ft_open_driver &h8
#define ft_open_params &h10

type FT_Parameter_
	tag as FT_ULong
	data as FT_Pointer
end type

type FT_Parameter as FT_Parameter_

type FT_Open_Args_
	flags as FT_UInt
	memory_base as FT_Byte ptr
	memory_size as FT_Long
	pathname as FT_String ptr
	stream as FT_Stream
	driver as FT_Module
	num_params as FT_Int
	params as FT_Parameter ptr
end type

type FT_Open_Args as FT_Open_Args_

#define FT_LOAD_DEFAULT &h0
#define FT_LOAD_NO_SCALE &h1
#define FT_LOAD_NO_HINTING &h2
#define FT_LOAD_RENDER &h4
#define FT_LOAD_NO_BITMAP &h8
#define FT_LOAD_VERTICAL_LAYOUT &h10
#define FT_LOAD_FORCE_AUTOHINT &h20
#define FT_LOAD_CROP_BITMAP &h40
#define FT_LOAD_PEDANTIC &h80
#define FT_LOAD_IGNORE_GLOBAL_ADVANCE_WIDTH &h200
#define FT_LOAD_NO_RECURSE &h400
#define FT_LOAD_IGNORE_TRANSFORM &h800
#define FT_LOAD_MONOCHROME &h1000
#define FT_LOAD_LINEAR_DESIGN &h2000
#define FT_LOAD_SBITS_ONLY &h4000
#define FT_LOAD_NO_AUTOHINT &h8000U

enum FT_Render_Mode_
	FT_RENDER_MODE_NORMAL = 0
	FT_RENDER_MODE_LIGHT
	FT_RENDER_MODE_MONO
	FT_RENDER_MODE_LCD
	FT_RENDER_MODE_LCD_V
	FT_RENDER_MODE_MAX
end enum

type FT_Render_Mode as FT_Render_Mode_

enum FT_Kerning_Mode_
	FT_KERNING_DEFAULT = 0
	FT_KERNING_UNFITTED
	FT_KERNING_UNSCALED
end enum

type FT_Kerning_Mode as FT_Kerning_Mode_

extern "c"
declare function FT_Init_FreeType (byval alibrary as FT_Library ptr) as FT_Error
declare sub FT_Library_Version (byval library as FT_Library, byval amajor as FT_Int ptr, byval aminor as FT_Int ptr, byval apatch as FT_Int ptr)
declare function FT_Done_FreeType (byval library as FT_Library) as FT_Error
declare function FT_New_Face (byval library as FT_Library, byval filepathname as zstring ptr, byval face_index as FT_Long, byval aface as FT_Face ptr) as FT_Error
declare function FT_New_Memory_Face (byval library as FT_Library, byval file_base as FT_Byte ptr, byval file_size as FT_Long, byval face_index as FT_Long, byval aface as FT_Face ptr) as FT_Error
declare function FT_Open_Face (byval library as FT_Library, byval args as FT_Open_Args ptr, byval face_index as FT_Long, byval aface as FT_Face ptr) as FT_Error
declare function FT_Attach_File (byval face as FT_Face, byval filepathname as zstring ptr) as FT_Error
declare function FT_Attach_Stream (byval face as FT_Face, byval parameters as FT_Open_Args ptr) as FT_Error
declare function FT_Done_Face (byval face as FT_Face) as FT_Error
declare function FT_Set_Char_Size (byval face as FT_Face, byval char_width as FT_F26Dot6, byval char_height as FT_F26Dot6, byval horz_resolution as FT_UInt, byval vert_resolution as FT_UInt) as FT_Error
declare function FT_Set_Pixel_Sizes (byval face as FT_Face, byval pixel_width as FT_UInt, byval pixel_height as FT_UInt) as FT_Error
declare function FT_Load_Glyph (byval face as FT_Face, byval glyph_index as FT_UInt, byval load_flags as FT_Int32) as FT_Error
declare function FT_Load_Char (byval face as FT_Face, byval char_code as FT_ULong, byval load_flags as FT_Int32) as FT_Error
declare sub FT_Set_Transform (byval face as FT_Face, byval matrix as FT_Matrix ptr, byval delta as FT_Vector ptr)
declare function FT_Render_Glyph (byval slot as FT_GlyphSlot, byval render_mode as FT_Render_Mode) as FT_Error
declare function FT_Get_Kerning (byval face as FT_Face, byval left_glyph as FT_UInt, byval right_glyph as FT_UInt, byval kern_mode as FT_UInt, byval akerning as FT_Vector ptr) as FT_Error
declare function FT_Get_Glyph_Name (byval face as FT_Face, byval glyph_index as FT_UInt, byval buffer as FT_Pointer, byval buffer_max as FT_UInt) as FT_Error
declare function FT_Get_Postscript_Name (byval face as FT_Face) as zstring ptr
declare function FT_Select_Charmap (byval face as FT_Face, byval encoding as FT_Encoding) as FT_Error
declare function FT_Set_Charmap (byval face as FT_Face, byval charmap as FT_CharMap) as FT_Error
declare function FT_Get_Charmap_Index (byval charmap as FT_CharMap) as FT_Int
declare function FT_Get_Char_Index (byval face as FT_Face, byval charcode as FT_ULong) as FT_UInt
declare function FT_Get_First_Char (byval face as FT_Face, byval agindex as FT_UInt ptr) as FT_ULong
declare function FT_Get_Next_Char (byval face as FT_Face, byval char_code as FT_ULong, byval agindex as FT_UInt ptr) as FT_ULong
declare function FT_Get_Name_Index (byval face as FT_Face, byval glyph_name as FT_String ptr) as FT_UInt
declare function FT_MulDiv (byval a as FT_Long, byval b as FT_Long, byval c as FT_Long) as FT_Long
declare function FT_MulFix (byval a as FT_Long, byval b as FT_Long) as FT_Long
declare function FT_DivFix (byval a as FT_Long, byval b as FT_Long) as FT_Long
declare function FT_RoundFix (byval a as FT_Fixed) as FT_Fixed
declare function FT_CeilFix (byval a as FT_Fixed) as FT_Fixed
declare function FT_FloorFix (byval a as FT_Fixed) as FT_Fixed
declare sub FT_Vector_Transform (byval vec as FT_Vector ptr, byval matrix as FT_Matrix ptr)
end extern

#endif
