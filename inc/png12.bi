'' FreeBASIC binding for libpng-1.2.53
''
'' based on the C header files:
''   png.h - header file for PNG reference library
''
''   libpng version 1.2.53 - February 26, 2015
''   Copyright (c) 1998-2015 Glenn Randers-Pehrson
''   (Version 0.96 Copyright (c) 1996, 1997 Andreas Dilger)
''   (Version 0.88 Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.)
''
''   This code is released under the libpng license (See LICENSE, below)
''
''   Authors and maintainers:
''    libpng versions 0.71, May 1995, through 0.88, January 1996: Guy Schalnat
''    libpng versions 0.89c, June 1996, through 0.96, May 1997: Andreas Dilger
''    libpng versions 0.97, January 1998, through 1.2.53 - February 26, 2015: Glenn
''    See also "Contributing Authors", below.
''
''   COPYRIGHT NOTICE, DISCLAIMER, and LICENSE:
''
''   If you modify libpng you may insert additional notices immediately following
''   this sentence.
''
''   This code is released under the libpng license.
''
''   libpng versions 1.2.6, August 15, 2004, through 1.2.53, February 26, 2015, are
''   Copyright (c) 2004, 2006-2015 Glenn Randers-Pehrson, and are
''   distributed according to the same disclaimer and license as libpng-1.2.5
''   with the following individual added to the list of Contributing Authors:
''
''      Cosmin Truta
''
''   libpng versions 1.0.7, July 1, 2000, through 1.2.5, October 3, 2002, are
''   Copyright (c) 2000-2002 Glenn Randers-Pehrson, and are
''   distributed according to the same disclaimer and license as libpng-1.0.6
''   with the following individuals added to the list of Contributing Authors:
''
''      Simon-Pierre Cadieux
''      Eric S. Raymond
''      Gilles Vollant
''
''   and with the following additions to the disclaimer:
''
''      There is no warranty against interference with your enjoyment of the
''      library or against infringement.  There is no warranty that our
''      efforts or the library will fulfill any of your particular purposes
''      or needs.  This library is provided with all faults, and the entire
''      risk of satisfactory quality, performance, accuracy, and effort is with
''      the user.
''
''   libpng versions 0.97, January 1998, through 1.0.6, March 20, 2000, are
''   Copyright (c) 1998, 1999, 2000 Glenn Randers-Pehrson, and are
''   distributed according to the same disclaimer and license as libpng-0.96,
''   with the following individuals added to the list of Contributing Authors:
''
''      Tom Lane
''      Glenn Randers-Pehrson
''      Willem van Schaik
''
''   libpng versions 0.89, June 1996, through 0.96, May 1997, are
''   Copyright (c) 1996, 1997 Andreas Dilger
''   Distributed according to the same disclaimer and license as libpng-0.88,
''   with the following individuals added to the list of Contributing Authors:
''
''      John Bowler
''      Kevin Bracey
''      Sam Bushell
''      Magnus Holmgren
''      Greg Roelofs
''      Tom Tanner
''
''   libpng versions 0.5, May 1995, through 0.88, January 1996, are
''   Copyright (c) 1995, 1996 Guy Eric Schalnat, Group 42, Inc.
''
''   For the purposes of this copyright and license, "Contributing Authors"
''   is defined as the following set of individuals:
''
''      Andreas Dilger
''      Dave Martindale
''      Guy Eric Schalnat
''      Paul Schmidt
''      Tim Wegner
''
''   The PNG Reference Library is supplied "AS IS".  The Contributing Authors
''   and Group 42, Inc. disclaim all warranties, expressed or implied,
''   including, without limitation, the warranties of merchantability and of
''   fitness for any purpose.  The Contributing Authors and Group 42, Inc.
''   assume no liability for direct, indirect, incidental, special, exemplary,
''   or consequential damages, which may result from the use of the PNG
''   Reference Library, even if advised of the possibility of such damage.
''
''   Permission is hereby granted to use, copy, modify, and distribute this
''   source code, or portions hereof, for any purpose, without fee, subject
''   to the following restrictions:
''
''   1. The origin of this source code must not be misrepresented.
''
''   2. Altered versions must be plainly marked as such and
''   must not be misrepresented as being the original source.
''
''   3. This Copyright notice may not be removed or altered from
''      any source or altered source distribution.
''
''   The Contributing Authors and Group 42, Inc. specifically permit, without
''   fee, and encourage the use of this source code as a component to
''   supporting the PNG file format in commercial products.  If you use this
''   source code in a product, acknowledgment is not required but would be
''   appreciated.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "png"
#inclib "z"

#include once "crt/long.bi"
#include once "zlib.bi"
#include once "crt/stdio.bi"
#include once "crt/sys/types.bi"
#include once "crt/setjmp.bi"
#include once "crt/string.bi"
#include once "crt/time.bi"

'' The following symbols have been renamed:
''     constant PNG_LIBPNG_VER => PNG_LIBPNG_VER_
''     #define PNG_READ_TEXT_SUPPORTED => PNG_READ_TEXT_SUPPORTED_
''     #define PNG_TEXT_SUPPORTED => PNG_TEXT_SUPPORTED_
''     #define PNG_WRITE_TEXT_SUPPORTED => PNG_WRITE_TEXT_SUPPORTED_
''     procedure png_info_init => png_info_init_

extern "C"

#define PNG_H
#define PNG_LIBPNG_VER_STRING "1.2.53"
#define PNG_HEADER_VERSION_STRING !" libpng version 1.2.53 - February 26, 2015\n"
const PNG_LIBPNG_VER_SONUM = 0
const PNG_LIBPNG_VER_DLLNUM = 13
const PNG_LIBPNG_VER_MAJOR = 1
const PNG_LIBPNG_VER_MINOR = 2
const PNG_LIBPNG_VER_RELEASE = 53
const PNG_LIBPNG_VER_BUILD = 0
const PNG_LIBPNG_BUILD_ALPHA = 1
const PNG_LIBPNG_BUILD_BETA = 2
const PNG_LIBPNG_BUILD_RC = 3
const PNG_LIBPNG_BUILD_STABLE = 4
const PNG_LIBPNG_BUILD_RELEASE_STATUS_MASK = 7
const PNG_LIBPNG_BUILD_PATCH = 8
const PNG_LIBPNG_BUILD_PRIVATE = 16
const PNG_LIBPNG_BUILD_SPECIAL = 32
const PNG_LIBPNG_BUILD_BASE_TYPE = PNG_LIBPNG_BUILD_STABLE
const PNG_LIBPNG_VER_ = 10253
#define PNGCONF_H
#define PNG_1_2_X
const PNG_WARN_UNINITIALIZED_ROW = 1
const PNG_ZBUF_SIZE = 8192
#define PNG_READ_SUPPORTED
#define PNG_WRITE_SUPPORTED
#define PNG_WARNINGS_SUPPORTED
#define PNG_ERROR_TEXT_SUPPORTED
#define PNG_CHECK_cHRM_SUPPORTED
#define PNG_MNG_FEATURES_SUPPORTED
#define PNG_FLOATING_POINT_SUPPORTED

#ifdef __FB_CYGWIN__
	#define PNG_USE_DLL
	#define PNG_DLL
#endif

#define PNG_STDIO_SUPPORTED
#define PNG_CONSOLE_IO_SUPPORTED
#define PNG_SETJMP_SUPPORTED
#define PNG_NO_iTXt_SUPPORTED
#define PNG_NO_READ_iTXt
#define PNG_NO_WRITE_iTXt
#define PNG_FIXED_POINT_SUPPORTED
#define PNG_FREE_ME_SUPPORTED
#define PNG_READ_TRANSFORMS_SUPPORTED
#define PNG_READ_EXPAND_SUPPORTED
#define PNG_READ_SHIFT_SUPPORTED
#define PNG_READ_PACK_SUPPORTED
#define PNG_READ_BGR_SUPPORTED
#define PNG_READ_SWAP_SUPPORTED
#define PNG_READ_PACKSWAP_SUPPORTED
#define PNG_READ_INVERT_SUPPORTED
#define PNG_READ_DITHER_SUPPORTED
#define PNG_READ_BACKGROUND_SUPPORTED
#define PNG_READ_16_TO_8_SUPPORTED
#define PNG_READ_FILLER_SUPPORTED
#define PNG_READ_GAMMA_SUPPORTED
#define PNG_READ_GRAY_TO_RGB_SUPPORTED
#define PNG_READ_SWAP_ALPHA_SUPPORTED
#define PNG_READ_INVERT_ALPHA_SUPPORTED
#define PNG_READ_STRIP_ALPHA_SUPPORTED
#define PNG_READ_USER_TRANSFORM_SUPPORTED
#define PNG_READ_RGB_TO_GRAY_SUPPORTED
#define PNG_PROGRESSIVE_READ_SUPPORTED
#define PNG_READ_INTERLACING_SUPPORTED
#define PNG_SEQUENTIAL_READ_SUPPORTED
#define PNG_READ_INTERLACING_SUPPORTED
#define PNG_READ_COMPOSITE_NODIV_SUPPORTED
#define PNG_READ_EMPTY_PLTE_SUPPORTED
#define PNG_WRITE_TRANSFORMS_SUPPORTED
#define PNG_WRITE_SHIFT_SUPPORTED
#define PNG_WRITE_PACK_SUPPORTED
#define PNG_WRITE_BGR_SUPPORTED
#define PNG_WRITE_SWAP_SUPPORTED
#define PNG_WRITE_PACKSWAP_SUPPORTED
#define PNG_WRITE_INVERT_SUPPORTED
#define PNG_WRITE_FILLER_SUPPORTED
#define PNG_WRITE_SWAP_ALPHA_SUPPORTED
#define PNG_WRITE_INVERT_ALPHA_SUPPORTED
#define PNG_WRITE_USER_TRANSFORM_SUPPORTED
#define PNG_WRITE_INTERLACING_SUPPORTED
#define PNG_WRITE_WEIGHTED_FILTER_SUPPORTED
#define PNG_WRITE_FLUSH_SUPPORTED
#define PNG_WRITE_EMPTY_PLTE_SUPPORTED
#define PNG_ERROR_NUMBERS_SUPPORTED
#define PNG_USER_TRANSFORM_PTR_SUPPORTED
#define PNG_TIME_RFC1123_SUPPORTED
#define PNG_EASY_ACCESS_SUPPORTED
#define PNG_OPTIMIZED_CODE_SUPPORTED
#define PNG_ASSEMBLER_CODE_SUPPORTED

#ifdef __FB_DARWIN__
	#define PNG_NO_MMX_CODE
#else
	#define PNG_MMX_CODE_SUPPORTED
#endif

#define PNG_USER_MEM_SUPPORTED
#define PNG_SET_USER_LIMITS_SUPPORTED
#define PNG_USER_LIMITS_SUPPORTED
const PNG_USER_WIDTH_MAX = cast(clong, 1000000)
const PNG_USER_HEIGHT_MAX = cast(clong, 1000000)
const PNG_USER_CHUNK_CACHE_MAX = 32765
const PNG_USER_CHUNK_MALLOC_MAX = 8000000
const PNG_LITERAL_SHARP = &h23
const PNG_LITERAL_LEFT_SQUARE_BRACKET = &h5b
const PNG_LITERAL_RIGHT_SQUARE_BRACKET = &h5d
#define PNG_STRING_NEWLINE !"\n"
#define PNG_POINTER_INDEXING_SUPPORTED
#define PNG_READ_ANCILLARY_CHUNKS_SUPPORTED
#define PNG_WRITE_ANCILLARY_CHUNKS_SUPPORTED
#define PNG_READ_bKGD_SUPPORTED
#define PNG_bKGD_SUPPORTED
#define PNG_READ_cHRM_SUPPORTED
#define PNG_cHRM_SUPPORTED
#define PNG_READ_gAMA_SUPPORTED
#define PNG_gAMA_SUPPORTED
#define PNG_READ_hIST_SUPPORTED
#define PNG_hIST_SUPPORTED
#define PNG_READ_iCCP_SUPPORTED
#define PNG_iCCP_SUPPORTED
#define PNG_READ_oFFs_SUPPORTED
#define PNG_oFFs_SUPPORTED
#define PNG_READ_pCAL_SUPPORTED
#define PNG_pCAL_SUPPORTED
#define PNG_READ_sCAL_SUPPORTED
#define PNG_sCAL_SUPPORTED
#define PNG_READ_pHYs_SUPPORTED
#define PNG_pHYs_SUPPORTED
#define PNG_READ_sBIT_SUPPORTED
#define PNG_sBIT_SUPPORTED
#define PNG_READ_sPLT_SUPPORTED
#define PNG_sPLT_SUPPORTED
#define PNG_READ_sRGB_SUPPORTED
#define PNG_sRGB_SUPPORTED
#define PNG_READ_tEXt_SUPPORTED
#define PNG_tEXt_SUPPORTED
#define PNG_READ_tIME_SUPPORTED
#define PNG_tIME_SUPPORTED
#define PNG_READ_tRNS_SUPPORTED
#define PNG_tRNS_SUPPORTED
#define PNG_READ_zTXt_SUPPORTED
#define PNG_zTXt_SUPPORTED
#define PNG_READ_OPT_PLTE_SUPPORTED
#define PNG_READ_TEXT_SUPPORTED_
#define PNG_TEXT_SUPPORTED_
#define PNG_READ_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_READ_USER_CHUNKS_SUPPORTED
#define PNG_USER_CHUNKS_SUPPORTED
#define PNG_HANDLE_AS_UNKNOWN_SUPPORTED
#define PNG_WRITE_bKGD_SUPPORTED
#define PNG_WRITE_cHRM_SUPPORTED
#define PNG_WRITE_gAMA_SUPPORTED
#define PNG_WRITE_hIST_SUPPORTED
#define PNG_WRITE_iCCP_SUPPORTED
#define PNG_WRITE_oFFs_SUPPORTED
#define PNG_WRITE_pCAL_SUPPORTED
#define PNG_WRITE_sCAL_SUPPORTED
#define PNG_WRITE_pHYs_SUPPORTED
#define PNG_WRITE_sBIT_SUPPORTED
#define PNG_WRITE_sPLT_SUPPORTED
#define PNG_WRITE_sRGB_SUPPORTED
#define PNG_WRITE_tEXt_SUPPORTED
#define PNG_WRITE_tIME_SUPPORTED
#define PNG_WRITE_tRNS_SUPPORTED
#define PNG_WRITE_zTXt_SUPPORTED
#define PNG_WRITE_TEXT_SUPPORTED_
#define PNG_CONVERT_tIME_SUPPORTED
#define PNG_WRITE_FILTER_SUPPORTED
#define PNG_WRITE_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_INFO_IMAGE_SUPPORTED

type png_uint_32 as culong
type png_int_32 as clong
type png_uint_16 as ushort
type png_int_16 as short
type png_byte as ubyte
type png_size_t as uinteger
#define png_sizeof(x) sizeof(x)
type png_fixed_point as png_int_32
type png_voidp as any ptr
type png_bytep as png_byte ptr
type png_uint_32p as png_uint_32 ptr
type png_int_32p as png_int_32 ptr
type png_uint_16p as png_uint_16 ptr
type png_int_16p as png_int_16 ptr
type png_const_charp as const zstring ptr
type png_charp as zstring ptr
type png_fixed_point_p as png_fixed_point ptr
type png_FILE_p as FILE ptr
type png_doublep as double ptr
type png_bytepp as png_byte ptr ptr
type png_uint_32pp as png_uint_32 ptr ptr
type png_int_32pp as png_int_32 ptr ptr
type png_uint_16pp as png_uint_16 ptr ptr
type png_int_16pp as png_int_16 ptr ptr
type png_const_charpp as const zstring ptr ptr
type png_charpp as zstring ptr ptr
type png_fixed_point_pp as png_fixed_point ptr ptr
type png_doublepp as double ptr ptr
type png_charppp as zstring ptr ptr ptr
type png_zcharp as charf ptr
type png_zcharpp as charf ptr ptr
type png_zstreamp as z_stream ptr

#ifdef __FB_CYGWIN__
	#define PNG_USE_LOCAL_ARRAYS
#else
	#define PNG_USE_GLOBAL_ARRAYS
#endif

#define PNG_ABORT() abort()
#define png_jmpbuf(png_ptr) (@(png_ptr)->jmpbuf)
#define png_snprintf snprintf
#define png_snprintf2 snprintf
#define png_snprintf6 snprintf
#define png_strlen strlen
#define png_memcmp memcmp
#define png_memcpy memcpy
#define png_memset memset
const PNG_LIBPNG_BUILD_TYPE = PNG_LIBPNG_BUILD_BASE_TYPE
#define int_p_NULL NULL
#define png_bytep_NULL NULL
#define png_bytepp_NULL NULL
#define png_doublep_NULL NULL
#define png_error_ptr_NULL NULL
#define png_flush_ptr_NULL NULL
#define png_free_ptr_NULL NULL
#define png_infopp_NULL NULL
#define png_malloc_ptr_NULL NULL
#define png_read_status_ptr_NULL NULL
#define png_rw_ptr_NULL NULL
#define png_structp_NULL NULL
#define png_uint_16p_NULL NULL
#define png_voidp_NULL NULL
#define png_write_status_ptr_NULL NULL

#ifdef __FB_CYGWIN__
	#define png_libpng_ver png_get_header_ver(NULL)
#else
	extern png_libpng_ver as const zstring * 18
	extern png_pass_start(0 to 6) as const long
	extern png_pass_inc(0 to 6) as const long
	extern png_pass_ystart(0 to 6) as const long
	extern png_pass_yinc(0 to 6) as const long
	extern png_pass_mask(0 to 6) as const long
	extern png_pass_dsp_mask(0 to 6) as const long
#endif

type png_color_struct
	red as png_byte
	green as png_byte
	blue as png_byte
end type

type png_color as png_color_struct
type png_colorp as png_color ptr
type png_colorpp as png_color ptr ptr

type png_color_16_struct
	index as png_byte
	red as png_uint_16
	green as png_uint_16
	blue as png_uint_16
	gray as png_uint_16
end type

type png_color_16 as png_color_16_struct
type png_color_16p as png_color_16 ptr
type png_color_16pp as png_color_16 ptr ptr

type png_color_8_struct
	red as png_byte
	green as png_byte
	blue as png_byte
	gray as png_byte
	alpha as png_byte
end type

type png_color_8 as png_color_8_struct
type png_color_8p as png_color_8 ptr
type png_color_8pp as png_color_8 ptr ptr

type png_sPLT_entry_struct
	red as png_uint_16
	green as png_uint_16
	blue as png_uint_16
	alpha as png_uint_16
	frequency as png_uint_16
end type

type png_sPLT_entry as png_sPLT_entry_struct
type png_sPLT_entryp as png_sPLT_entry ptr
type png_sPLT_entrypp as png_sPLT_entry ptr ptr

type png_sPLT_struct
	name as png_charp
	depth as png_byte
	entries as png_sPLT_entryp
	nentries as png_int_32
end type

type png_sPLT_t as png_sPLT_struct
type png_sPLT_tp as png_sPLT_t ptr
type png_sPLT_tpp as png_sPLT_t ptr ptr

type png_text_struct
	compression as long
	key as png_charp
	text as png_charp
	text_length as png_size_t
end type

type png_text as png_text_struct
type png_textp as png_text ptr
type png_textpp as png_text ptr ptr

const PNG_TEXT_COMPRESSION_NONE_WR = -3
const PNG_TEXT_COMPRESSION_zTXt_WR = -2
const PNG_TEXT_COMPRESSION_NONE = -1
const PNG_TEXT_COMPRESSION_zTXt = 0
const PNG_ITXT_COMPRESSION_NONE = 1
const PNG_ITXT_COMPRESSION_zTXt = 2
const PNG_TEXT_COMPRESSION_LAST = 3

type png_time_struct
	year as png_uint_16
	month as png_byte
	day as png_byte
	hour as png_byte
	minute as png_byte
	second as png_byte
end type

type png_time as png_time_struct
type png_timep as png_time ptr
type png_timepp as png_time ptr ptr
const PNG_CHUNK_NAME_LENGTH = 5

type png_unknown_chunk_t
	name(0 to 4) as png_byte
	data as png_byte ptr
	size as png_size_t
	location as png_byte
end type

type png_unknown_chunk as png_unknown_chunk_t
type png_unknown_chunkp as png_unknown_chunk ptr
type png_unknown_chunkpp as png_unknown_chunk ptr ptr

type png_info_struct
	width as png_uint_32
	height as png_uint_32
	valid as png_uint_32
	rowbytes as png_uint_32
	palette as png_colorp
	num_palette as png_uint_16
	num_trans as png_uint_16
	bit_depth as png_byte
	color_type as png_byte
	compression_type as png_byte
	filter_type as png_byte
	interlace_type as png_byte
	channels as png_byte
	pixel_depth as png_byte
	spare_byte as png_byte
	signature(0 to 7) as png_byte
	gamma as single
	srgb_intent as png_byte
	num_text as long
	max_text as long
	text as png_textp
	mod_time as png_time
	sig_bit as png_color_8
	trans as png_bytep
	trans_values as png_color_16
	background as png_color_16
	x_offset as png_int_32
	y_offset as png_int_32
	offset_unit_type as png_byte
	x_pixels_per_unit as png_uint_32
	y_pixels_per_unit as png_uint_32
	phys_unit_type as png_byte
	hist as png_uint_16p
	x_white as single
	y_white as single
	x_red as single
	y_red as single
	x_green as single
	y_green as single
	x_blue as single
	y_blue as single
	pcal_purpose as png_charp
	pcal_X0 as png_int_32
	pcal_X1 as png_int_32
	pcal_units as png_charp
	pcal_params as png_charpp
	pcal_type as png_byte
	pcal_nparams as png_byte
	free_me as png_uint_32
	unknown_chunks as png_unknown_chunkp
	unknown_chunks_num as png_size_t
	iccp_name as png_charp
	iccp_profile as png_charp
	iccp_proflen as png_uint_32
	iccp_compression as png_byte
	splt_palettes as png_sPLT_tp
	splt_palettes_num as png_uint_32
	scal_unit as png_byte
	scal_pixel_width as double
	scal_pixel_height as double
	scal_s_width as png_charp
	scal_s_height as png_charp
	row_pointers as png_bytepp
	int_gamma as png_fixed_point
	int_x_white as png_fixed_point
	int_y_white as png_fixed_point
	int_x_red as png_fixed_point
	int_y_red as png_fixed_point
	int_x_green as png_fixed_point
	int_y_green as png_fixed_point
	int_x_blue as png_fixed_point
	int_y_blue as png_fixed_point
end type

type png_info as png_info_struct
type png_infop as png_info ptr
type png_infopp as png_info ptr ptr

const PNG_UINT_31_MAX = cast(png_uint_32, cast(clong, &h7fffffff))
const PNG_UINT_32_MAX = cast(png_uint_32, -1)
const PNG_SIZE_MAX = cast(png_size_t, -1)
const PNG_MAX_UINT = PNG_UINT_31_MAX
const PNG_COLOR_MASK_PALETTE = 1
const PNG_COLOR_MASK_COLOR = 2
const PNG_COLOR_MASK_ALPHA = 4
const PNG_COLOR_TYPE_GRAY = 0
const PNG_COLOR_TYPE_PALETTE = PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_PALETTE
const PNG_COLOR_TYPE_RGB = PNG_COLOR_MASK_COLOR
const PNG_COLOR_TYPE_RGB_ALPHA = PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_ALPHA
const PNG_COLOR_TYPE_GRAY_ALPHA = PNG_COLOR_MASK_ALPHA
const PNG_COLOR_TYPE_RGBA = PNG_COLOR_TYPE_RGB_ALPHA
const PNG_COLOR_TYPE_GA = PNG_COLOR_TYPE_GRAY_ALPHA
const PNG_COMPRESSION_TYPE_BASE = 0
const PNG_COMPRESSION_TYPE_DEFAULT = PNG_COMPRESSION_TYPE_BASE
const PNG_FILTER_TYPE_BASE = 0
const PNG_INTRAPIXEL_DIFFERENCING = 64
const PNG_FILTER_TYPE_DEFAULT = PNG_FILTER_TYPE_BASE
const PNG_INTERLACE_NONE = 0
const PNG_INTERLACE_ADAM7 = 1
const PNG_INTERLACE_LAST = 2
const PNG_OFFSET_PIXEL = 0
const PNG_OFFSET_MICROMETER = 1
const PNG_OFFSET_LAST = 2
const PNG_EQUATION_LINEAR = 0
const PNG_EQUATION_BASE_E = 1
const PNG_EQUATION_ARBITRARY = 2
const PNG_EQUATION_HYPERBOLIC = 3
const PNG_EQUATION_LAST = 4
const PNG_SCALE_UNKNOWN = 0
const PNG_SCALE_METER = 1
const PNG_SCALE_RADIAN = 2
const PNG_SCALE_LAST = 3
const PNG_RESOLUTION_UNKNOWN = 0
const PNG_RESOLUTION_METER = 1
const PNG_RESOLUTION_LAST = 2
const PNG_sRGB_INTENT_PERCEPTUAL = 0
const PNG_sRGB_INTENT_RELATIVE = 1
const PNG_sRGB_INTENT_SATURATION = 2
const PNG_sRGB_INTENT_ABSOLUTE = 3
const PNG_sRGB_INTENT_LAST = 4
const PNG_KEYWORD_MAX_LENGTH = 79
const PNG_MAX_PALETTE_LENGTH = 256
const PNG_INFO_gAMA = &h0001
const PNG_INFO_sBIT = &h0002
const PNG_INFO_cHRM = &h0004
const PNG_INFO_PLTE = &h0008
const PNG_INFO_tRNS = &h0010
const PNG_INFO_bKGD = &h0020
const PNG_INFO_hIST = &h0040
const PNG_INFO_pHYs = &h0080
const PNG_INFO_oFFs = &h0100
const PNG_INFO_tIME = &h0200
const PNG_INFO_pCAL = &h0400
const PNG_INFO_sRGB = &h0800
const PNG_INFO_iCCP = &h1000
const PNG_INFO_sPLT = &h2000
const PNG_INFO_sCAL = &h4000
const PNG_INFO_IDAT = cast(clong, &h8000)

type png_row_info_struct
	width as png_uint_32
	rowbytes as png_uint_32
	color_type as png_byte
	bit_depth as png_byte
	channels as png_byte
	pixel_depth as png_byte
end type

type png_row_info as png_row_info_struct
type png_row_infop as png_row_info ptr
type png_row_infopp as png_row_info ptr ptr
type png_struct as png_struct_def
type png_structp as png_struct ptr
type png_error_ptr as sub(byval as png_structp, byval as png_const_charp)
type png_rw_ptr as sub(byval as png_structp, byval as png_bytep, byval as png_size_t)
type png_flush_ptr as sub(byval as png_structp)
type png_read_status_ptr as sub(byval as png_structp, byval as png_uint_32, byval as long)
type png_write_status_ptr as sub(byval as png_structp, byval as png_uint_32, byval as long)
type png_progressive_info_ptr as sub(byval as png_structp, byval as png_infop)
type png_progressive_end_ptr as sub(byval as png_structp, byval as png_infop)
type png_progressive_row_ptr as sub(byval as png_structp, byval as png_bytep, byval as png_uint_32, byval as long)
type png_user_transform_ptr as sub(byval as png_structp, byval as png_row_infop, byval as png_bytep)
type png_user_chunk_ptr as function(byval as png_structp, byval as png_unknown_chunkp) as long
type png_unknown_chunk_ptr as sub(byval as png_structp)

const PNG_TRANSFORM_IDENTITY = &h0000
const PNG_TRANSFORM_STRIP_16 = &h0001
const PNG_TRANSFORM_STRIP_ALPHA = &h0002
const PNG_TRANSFORM_PACKING = &h0004
const PNG_TRANSFORM_PACKSWAP = &h0008
const PNG_TRANSFORM_EXPAND = &h0010
const PNG_TRANSFORM_INVERT_MONO = &h0020
const PNG_TRANSFORM_SHIFT = &h0040
const PNG_TRANSFORM_BGR = &h0080
const PNG_TRANSFORM_SWAP_ALPHA = &h0100
const PNG_TRANSFORM_SWAP_ENDIAN = &h0200
const PNG_TRANSFORM_INVERT_ALPHA = &h0400
const PNG_TRANSFORM_STRIP_FILLER = &h0800
const PNG_TRANSFORM_STRIP_FILLER_BEFORE = &h0800
const PNG_TRANSFORM_STRIP_FILLER_AFTER = &h1000
const PNG_TRANSFORM_GRAY_TO_RGB = &h2000
const PNG_FLAG_MNG_EMPTY_PLTE = &h01
const PNG_FLAG_MNG_FILTER_64 = &h04
const PNG_ALL_MNG_FEATURES = &h05
type png_malloc_ptr as function(byval as png_structp, byval as png_size_t) as png_voidp
type png_free_ptr as sub(byval as png_structp, byval as png_voidp)

type png_struct_def
	jmpbuf as jmp_buf
	error_fn as png_error_ptr
	warning_fn as png_error_ptr
	error_ptr as png_voidp
	write_data_fn as png_rw_ptr
	read_data_fn as png_rw_ptr
	io_ptr as png_voidp
	read_user_transform_fn as png_user_transform_ptr
	write_user_transform_fn as png_user_transform_ptr
	user_transform_ptr as png_voidp
	user_transform_depth as png_byte
	user_transform_channels as png_byte
	mode as png_uint_32
	flags as png_uint_32
	transformations as png_uint_32
	zstream as z_stream
	zbuf as png_bytep
	zbuf_size as png_size_t
	zlib_level as long
	zlib_method as long
	zlib_window_bits as long
	zlib_mem_level as long
	zlib_strategy as long
	width as png_uint_32
	height as png_uint_32
	num_rows as png_uint_32
	usr_width as png_uint_32
	rowbytes as png_uint_32
	user_chunk_cache_max as png_uint_32
	iwidth as png_uint_32
	row_number as png_uint_32
	prev_row as png_bytep
	row_buf as png_bytep
	sub_row as png_bytep
	up_row as png_bytep
	avg_row as png_bytep
	paeth_row as png_bytep
	row_info as png_row_info
	idat_size as png_uint_32
	crc as png_uint_32
	palette as png_colorp
	num_palette as png_uint_16
	num_trans as png_uint_16
	chunk_name(0 to 4) as png_byte
	compression as png_byte
	filter as png_byte
	interlaced as png_byte
	pass as png_byte
	do_filter as png_byte
	color_type as png_byte
	bit_depth as png_byte
	usr_bit_depth as png_byte
	pixel_depth as png_byte
	channels as png_byte
	usr_channels as png_byte
	sig_bytes as png_byte
	filler as png_uint_16
	background_gamma_type as png_byte
	background_gamma as single
	background as png_color_16
	background_1 as png_color_16
	output_flush_fn as png_flush_ptr
	flush_dist as png_uint_32
	flush_rows as png_uint_32
	gamma_shift as long
	gamma as single
	screen_gamma as single
	gamma_table as png_bytep
	gamma_from_1 as png_bytep
	gamma_to_1 as png_bytep
	gamma_16_table as png_uint_16pp
	gamma_16_from_1 as png_uint_16pp
	gamma_16_to_1 as png_uint_16pp
	sig_bit as png_color_8
	shift as png_color_8
	trans as png_bytep
	trans_values as png_color_16
	read_row_fn as png_read_status_ptr
	write_row_fn as png_write_status_ptr
	info_fn as png_progressive_info_ptr
	row_fn as png_progressive_row_ptr
	end_fn as png_progressive_end_ptr
	save_buffer_ptr as png_bytep
	save_buffer as png_bytep
	current_buffer_ptr as png_bytep
	current_buffer as png_bytep
	push_length as png_uint_32
	skip_length as png_uint_32
	save_buffer_size as png_size_t
	save_buffer_max as png_size_t
	buffer_size as png_size_t
	current_buffer_size as png_size_t
	process_mode as long
	cur_palette as long
	current_text_size as png_size_t
	current_text_left as png_size_t
	current_text as png_charp
	current_text_ptr as png_charp
	palette_lookup as png_bytep
	dither_index as png_bytep
	hist as png_uint_16p
	heuristic_method as png_byte
	num_prev_filters as png_byte
	prev_filters as png_bytep
	filter_weights as png_uint_16p
	inv_filter_weights as png_uint_16p
	filter_costs as png_uint_16p
	inv_filter_costs as png_uint_16p
	time_buffer as png_charp
	free_me as png_uint_32
	user_chunk_ptr as png_voidp
	read_user_chunk_fn as png_user_chunk_ptr
	num_chunk_list as long
	chunk_list as png_bytep
	rgb_to_gray_status as png_byte
	rgb_to_gray_red_coeff as png_uint_16
	rgb_to_gray_green_coeff as png_uint_16
	rgb_to_gray_blue_coeff as png_uint_16
	mng_features_permitted as png_uint_32
	int_gamma as png_fixed_point
	filter_type as png_byte

	#if defined(__FB_DOS__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
		mmx_bitdepth_threshold as png_byte
		mmx_rowbytes_threshold as png_uint_32
	#endif

	asm_flags as png_uint_32
	mem_ptr as png_voidp
	malloc_fn as png_malloc_ptr
	free_fn as png_free_ptr
	big_row_buf as png_bytep
	dither_sort as png_bytep
	index_to_palette as png_bytep
	palette_to_index as png_bytep
	compression_type as png_byte
	user_width_max as png_uint_32
	user_height_max as png_uint_32
	unknown_chunk as png_unknown_chunk
	old_big_row_buf_size as png_uint_32
	old_prev_row_size as png_uint_32
	chunkdata as png_charp
end type

type version_1_2_53 as png_structp
type png_structpp as png_struct ptr ptr
declare function png_access_version_number() as png_uint_32
declare sub png_set_sig_bytes(byval png_ptr as png_structp, byval num_bytes as long)
declare function png_sig_cmp(byval sig as png_bytep, byval start as png_size_t, byval num_to_check as png_size_t) as long
declare function png_check_sig(byval sig as png_bytep, byval num as long) as long
declare function png_create_read_struct(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr) as png_structp
declare function png_create_write_struct(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr) as png_structp
declare function png_get_compression_buffer_size(byval png_ptr as png_structp) as png_uint_32
declare sub png_set_compression_buffer_size(byval png_ptr as png_structp, byval size as png_uint_32)
declare function png_reset_zstream(byval png_ptr as png_structp) as long
declare function png_create_read_struct_2(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr, byval mem_ptr as png_voidp, byval malloc_fn as png_malloc_ptr, byval free_fn as png_free_ptr) as png_structp
declare function png_create_write_struct_2(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr, byval mem_ptr as png_voidp, byval malloc_fn as png_malloc_ptr, byval free_fn as png_free_ptr) as png_structp
declare sub png_write_chunk(byval png_ptr as png_structp, byval chunk_name as png_bytep, byval data as png_bytep, byval length as png_size_t)
declare sub png_write_chunk_start(byval png_ptr as png_structp, byval chunk_name as png_bytep, byval length as png_uint_32)
declare sub png_write_chunk_data(byval png_ptr as png_structp, byval data as png_bytep, byval length as png_size_t)
declare sub png_write_chunk_end(byval png_ptr as png_structp)
declare function png_create_info_struct(byval png_ptr as png_structp) as png_infop
declare sub png_info_init_ alias "png_info_init"(byval info_ptr as png_infop)
#undef png_info_init
#define png_info_init(info_ptr) png_info_init_3(@info_ptr, png_sizeof(png_info))
declare sub png_info_init_3(byval info_ptr as png_infopp, byval png_info_struct_size as png_size_t)
declare sub png_write_info_before_PLTE(byval png_ptr as png_structp, byval info_ptr as png_infop)
declare sub png_write_info(byval png_ptr as png_structp, byval info_ptr as png_infop)
declare sub png_read_info(byval png_ptr as png_structp, byval info_ptr as png_infop)
declare function png_convert_to_rfc1123(byval png_ptr as png_structp, byval ptime as png_timep) as png_charp
declare sub png_convert_from_struct_tm(byval ptime as png_timep, byval ttime as tm ptr)
declare sub png_convert_from_time_t(byval ptime as png_timep, byval ttime as time_t)
declare sub png_set_expand(byval png_ptr as png_structp)
declare sub png_set_expand_gray_1_2_4_to_8(byval png_ptr as png_structp)
declare sub png_set_palette_to_rgb(byval png_ptr as png_structp)
declare sub png_set_tRNS_to_alpha(byval png_ptr as png_structp)
declare sub png_set_gray_1_2_4_to_8(byval png_ptr as png_structp)
declare sub png_set_bgr(byval png_ptr as png_structp)
declare sub png_set_gray_to_rgb(byval png_ptr as png_structp)
declare sub png_set_rgb_to_gray(byval png_ptr as png_structp, byval error_action as long, byval red as double, byval green as double)
declare sub png_set_rgb_to_gray_fixed(byval png_ptr as png_structp, byval error_action as long, byval red as png_fixed_point, byval green as png_fixed_point)
declare function png_get_rgb_to_gray_status(byval png_ptr as png_structp) as png_byte
declare sub png_build_grayscale_palette(byval bit_depth as long, byval palette as png_colorp)
declare sub png_set_strip_alpha(byval png_ptr as png_structp)
declare sub png_set_swap_alpha(byval png_ptr as png_structp)
declare sub png_set_invert_alpha(byval png_ptr as png_structp)
declare sub png_set_filler(byval png_ptr as png_structp, byval filler as png_uint_32, byval flags as long)
const PNG_FILLER_BEFORE = 0
const PNG_FILLER_AFTER = 1
declare sub png_set_add_alpha(byval png_ptr as png_structp, byval filler as png_uint_32, byval flags as long)
declare sub png_set_swap(byval png_ptr as png_structp)
declare sub png_set_packing(byval png_ptr as png_structp)
declare sub png_set_packswap(byval png_ptr as png_structp)
declare sub png_set_shift(byval png_ptr as png_structp, byval true_bits as png_color_8p)
declare function png_set_interlace_handling(byval png_ptr as png_structp) as long
declare sub png_set_invert_mono(byval png_ptr as png_structp)
declare sub png_set_background(byval png_ptr as png_structp, byval background_color as png_color_16p, byval background_gamma_code as long, byval need_expand as long, byval background_gamma as double)

const PNG_BACKGROUND_GAMMA_UNKNOWN = 0
const PNG_BACKGROUND_GAMMA_SCREEN = 1
const PNG_BACKGROUND_GAMMA_FILE = 2
const PNG_BACKGROUND_GAMMA_UNIQUE = 3

declare sub png_set_strip_16(byval png_ptr as png_structp)
declare sub png_set_dither(byval png_ptr as png_structp, byval palette as png_colorp, byval num_palette as long, byval maximum_colors as long, byval histogram as png_uint_16p, byval full_dither as long)
declare sub png_set_gamma(byval png_ptr as png_structp, byval screen_gamma as double, byval default_file_gamma as double)
declare sub png_permit_empty_plte(byval png_ptr as png_structp, byval empty_plte_permitted as long)
declare sub png_set_flush(byval png_ptr as png_structp, byval nrows as long)
declare sub png_write_flush(byval png_ptr as png_structp)
declare sub png_start_read_image(byval png_ptr as png_structp)
declare sub png_read_update_info(byval png_ptr as png_structp, byval info_ptr as png_infop)
declare sub png_read_rows(byval png_ptr as png_structp, byval row as png_bytepp, byval display_row as png_bytepp, byval num_rows as png_uint_32)
declare sub png_read_row(byval png_ptr as png_structp, byval row as png_bytep, byval display_row as png_bytep)
declare sub png_read_image(byval png_ptr as png_structp, byval image as png_bytepp)
declare sub png_write_row(byval png_ptr as png_structp, byval row as png_bytep)
declare sub png_write_rows(byval png_ptr as png_structp, byval row as png_bytepp, byval num_rows as png_uint_32)
declare sub png_write_image(byval png_ptr as png_structp, byval image as png_bytepp)
declare sub png_write_end(byval png_ptr as png_structp, byval info_ptr as png_infop)
declare sub png_read_end(byval png_ptr as png_structp, byval info_ptr as png_infop)
declare sub png_destroy_info_struct(byval png_ptr as png_structp, byval info_ptr_ptr as png_infopp)
declare sub png_destroy_read_struct(byval png_ptr_ptr as png_structpp, byval info_ptr_ptr as png_infopp, byval end_info_ptr_ptr as png_infopp)
declare sub png_read_destroy(byval png_ptr as png_structp, byval info_ptr as png_infop, byval end_info_ptr as png_infop)
declare sub png_destroy_write_struct(byval png_ptr_ptr as png_structpp, byval info_ptr_ptr as png_infopp)
declare sub png_write_destroy(byval png_ptr as png_structp)
declare sub png_set_crc_action(byval png_ptr as png_structp, byval crit_action as long, byval ancil_action as long)

const PNG_CRC_DEFAULT = 0
const PNG_CRC_ERROR_QUIT = 1
const PNG_CRC_WARN_DISCARD = 2
const PNG_CRC_WARN_USE = 3
const PNG_CRC_QUIET_USE = 4
const PNG_CRC_NO_CHANGE = 5
declare sub png_set_filter(byval png_ptr as png_structp, byval method as long, byval filters as long)
const PNG_NO_FILTERS = &h00
const PNG_FILTER_NONE = &h08
const PNG_FILTER_SUB = &h10
const PNG_FILTER_UP = &h20
const PNG_FILTER_AVG = &h40
const PNG_FILTER_PAETH = &h80
const PNG_ALL_FILTERS = (((PNG_FILTER_NONE or PNG_FILTER_SUB) or PNG_FILTER_UP) or PNG_FILTER_AVG) or PNG_FILTER_PAETH
const PNG_FILTER_VALUE_NONE = 0
const PNG_FILTER_VALUE_SUB = 1
const PNG_FILTER_VALUE_UP = 2
const PNG_FILTER_VALUE_AVG = 3
const PNG_FILTER_VALUE_PAETH = 4
const PNG_FILTER_VALUE_LAST = 5
declare sub png_set_filter_heuristics(byval png_ptr as png_structp, byval heuristic_method as long, byval num_weights as long, byval filter_weights as png_doublep, byval filter_costs as png_doublep)
const PNG_FILTER_HEURISTIC_DEFAULT = 0
const PNG_FILTER_HEURISTIC_UNWEIGHTED = 1
const PNG_FILTER_HEURISTIC_WEIGHTED = 2
const PNG_FILTER_HEURISTIC_LAST = 3

declare sub png_set_compression_level(byval png_ptr as png_structp, byval level as long)
declare sub png_set_compression_mem_level(byval png_ptr as png_structp, byval mem_level as long)
declare sub png_set_compression_strategy(byval png_ptr as png_structp, byval strategy as long)
declare sub png_set_compression_window_bits(byval png_ptr as png_structp, byval window_bits as long)
declare sub png_set_compression_method(byval png_ptr as png_structp, byval method as long)
declare sub png_init_io(byval png_ptr as png_structp, byval fp as png_FILE_p)
declare sub png_set_error_fn(byval png_ptr as png_structp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warning_fn as png_error_ptr)
declare function png_get_error_ptr(byval png_ptr as png_structp) as png_voidp
declare sub png_set_write_fn(byval png_ptr as png_structp, byval io_ptr as png_voidp, byval write_data_fn as png_rw_ptr, byval output_flush_fn as png_flush_ptr)
declare sub png_set_read_fn(byval png_ptr as png_structp, byval io_ptr as png_voidp, byval read_data_fn as png_rw_ptr)
declare function png_get_io_ptr(byval png_ptr as png_structp) as png_voidp
declare sub png_set_read_status_fn(byval png_ptr as png_structp, byval read_row_fn as png_read_status_ptr)
declare sub png_set_write_status_fn(byval png_ptr as png_structp, byval write_row_fn as png_write_status_ptr)
declare sub png_set_mem_fn(byval png_ptr as png_structp, byval mem_ptr as png_voidp, byval malloc_fn as png_malloc_ptr, byval free_fn as png_free_ptr)
declare function png_get_mem_ptr(byval png_ptr as png_structp) as png_voidp
declare sub png_set_read_user_transform_fn(byval png_ptr as png_structp, byval read_user_transform_fn as png_user_transform_ptr)
declare sub png_set_write_user_transform_fn(byval png_ptr as png_structp, byval write_user_transform_fn as png_user_transform_ptr)
declare sub png_set_user_transform_info(byval png_ptr as png_structp, byval user_transform_ptr as png_voidp, byval user_transform_depth as long, byval user_transform_channels as long)
declare function png_get_user_transform_ptr(byval png_ptr as png_structp) as png_voidp
declare sub png_set_read_user_chunk_fn(byval png_ptr as png_structp, byval user_chunk_ptr as png_voidp, byval read_user_chunk_fn as png_user_chunk_ptr)
declare function png_get_user_chunk_ptr(byval png_ptr as png_structp) as png_voidp
declare sub png_set_progressive_read_fn(byval png_ptr as png_structp, byval progressive_ptr as png_voidp, byval info_fn as png_progressive_info_ptr, byval row_fn as png_progressive_row_ptr, byval end_fn as png_progressive_end_ptr)
declare function png_get_progressive_ptr(byval png_ptr as png_structp) as png_voidp
declare sub png_process_data(byval png_ptr as png_structp, byval info_ptr as png_infop, byval buffer as png_bytep, byval buffer_size as png_size_t)
declare sub png_progressive_combine_row(byval png_ptr as png_structp, byval old_row as png_bytep, byval new_row as png_bytep)
declare function png_malloc(byval png_ptr as png_structp, byval size as png_uint_32) as png_voidp
declare function png_malloc_warn(byval png_ptr as png_structp, byval size as png_uint_32) as png_voidp
declare sub png_free(byval png_ptr as png_structp, byval ptr as png_voidp)
declare sub png_free_data(byval png_ptr as png_structp, byval info_ptr as png_infop, byval free_me as png_uint_32, byval num as long)
declare sub png_data_freer(byval png_ptr as png_structp, byval info_ptr as png_infop, byval freer as long, byval mask as png_uint_32)

const PNG_DESTROY_WILL_FREE_DATA = 1
const PNG_SET_WILL_FREE_DATA = 1
const PNG_USER_WILL_FREE_DATA = 2
const PNG_FREE_HIST = &h0008
const PNG_FREE_ICCP = &h0010
const PNG_FREE_SPLT = &h0020
const PNG_FREE_ROWS = &h0040
const PNG_FREE_PCAL = &h0080
const PNG_FREE_SCAL = &h0100
const PNG_FREE_UNKN = &h0200
const PNG_FREE_LIST = &h0400
const PNG_FREE_PLTE = &h1000
const PNG_FREE_TRNS = &h2000
const PNG_FREE_TEXT = &h4000
const PNG_FREE_ALL = &h7fff
const PNG_FREE_MUL = &h4220

declare function png_malloc_default(byval png_ptr as png_structp, byval size as png_uint_32) as png_voidp
declare sub png_free_default(byval png_ptr as png_structp, byval ptr as png_voidp)
declare function png_memcpy_check(byval png_ptr as png_structp, byval s1 as png_voidp, byval s2 as png_voidp, byval size as png_uint_32) as png_voidp
declare function png_memset_check(byval png_ptr as png_structp, byval s1 as png_voidp, byval value as long, byval size as png_uint_32) as png_voidp
declare sub png_error(byval png_ptr as png_structp, byval error_message as png_const_charp)
declare sub png_benign_error alias "png_error"(byval png_ptr as png_structp, byval error_message as png_const_charp)
declare sub png_chunk_error(byval png_ptr as png_structp, byval error_message as png_const_charp)
declare sub png_chunk_benign_error alias "png_chunk_error"(byval png_ptr as png_structp, byval error_message as png_const_charp)
declare sub png_warning(byval png_ptr as png_structp, byval warning_message as png_const_charp)
declare sub png_chunk_warning(byval png_ptr as png_structp, byval warning_message as png_const_charp)
declare function png_get_valid(byval png_ptr as png_structp, byval info_ptr as png_infop, byval flag as png_uint_32) as png_uint_32
declare function png_get_rowbytes(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_uint_32
declare function png_get_rows(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_bytepp
declare sub png_set_rows(byval png_ptr as png_structp, byval info_ptr as png_infop, byval row_pointers as png_bytepp)
declare function png_get_channels(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_byte
declare function png_get_image_width(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_uint_32
declare function png_get_image_height(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_uint_32
declare function png_get_bit_depth(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_byte
declare function png_get_color_type(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_byte
declare function png_get_filter_type(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_byte
declare function png_get_interlace_type(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_byte
declare function png_get_compression_type(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_byte
declare function png_get_pixels_per_meter(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_uint_32
declare function png_get_x_pixels_per_meter(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_uint_32
declare function png_get_y_pixels_per_meter(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_uint_32
declare function png_get_pixel_aspect_ratio(byval png_ptr as png_structp, byval info_ptr as png_infop) as single
declare function png_get_x_offset_pixels(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_int_32
declare function png_get_y_offset_pixels(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_int_32
declare function png_get_x_offset_microns(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_int_32
declare function png_get_y_offset_microns(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_int_32
declare function png_get_signature(byval png_ptr as png_structp, byval info_ptr as png_infop) as png_bytep
declare function png_get_bKGD(byval png_ptr as png_structp, byval info_ptr as png_infop, byval background as png_color_16p ptr) as png_uint_32
declare sub png_set_bKGD(byval png_ptr as png_structp, byval info_ptr as png_infop, byval background as png_color_16p)
declare function png_get_cHRM(byval png_ptr as png_structp, byval info_ptr as png_infop, byval white_x as double ptr, byval white_y as double ptr, byval red_x as double ptr, byval red_y as double ptr, byval green_x as double ptr, byval green_y as double ptr, byval blue_x as double ptr, byval blue_y as double ptr) as png_uint_32
declare function png_get_cHRM_fixed(byval png_ptr as png_structp, byval info_ptr as png_infop, byval int_white_x as png_fixed_point ptr, byval int_white_y as png_fixed_point ptr, byval int_red_x as png_fixed_point ptr, byval int_red_y as png_fixed_point ptr, byval int_green_x as png_fixed_point ptr, byval int_green_y as png_fixed_point ptr, byval int_blue_x as png_fixed_point ptr, byval int_blue_y as png_fixed_point ptr) as png_uint_32
declare sub png_set_cHRM(byval png_ptr as png_structp, byval info_ptr as png_infop, byval white_x as double, byval white_y as double, byval red_x as double, byval red_y as double, byval green_x as double, byval green_y as double, byval blue_x as double, byval blue_y as double)
declare sub png_set_cHRM_fixed(byval png_ptr as png_structp, byval info_ptr as png_infop, byval int_white_x as png_fixed_point, byval int_white_y as png_fixed_point, byval int_red_x as png_fixed_point, byval int_red_y as png_fixed_point, byval int_green_x as png_fixed_point, byval int_green_y as png_fixed_point, byval int_blue_x as png_fixed_point, byval int_blue_y as png_fixed_point)
declare function png_get_gAMA(byval png_ptr as png_structp, byval info_ptr as png_infop, byval file_gamma as double ptr) as png_uint_32
declare function png_get_gAMA_fixed(byval png_ptr as png_structp, byval info_ptr as png_infop, byval int_file_gamma as png_fixed_point ptr) as png_uint_32
declare sub png_set_gAMA(byval png_ptr as png_structp, byval info_ptr as png_infop, byval file_gamma as double)
declare sub png_set_gAMA_fixed(byval png_ptr as png_structp, byval info_ptr as png_infop, byval int_file_gamma as png_fixed_point)
declare function png_get_hIST(byval png_ptr as png_structp, byval info_ptr as png_infop, byval hist as png_uint_16p ptr) as png_uint_32
declare sub png_set_hIST(byval png_ptr as png_structp, byval info_ptr as png_infop, byval hist as png_uint_16p)
declare function png_get_IHDR(byval png_ptr as png_structp, byval info_ptr as png_infop, byval width as png_uint_32 ptr, byval height as png_uint_32 ptr, byval bit_depth as long ptr, byval color_type as long ptr, byval interlace_method as long ptr, byval compression_method as long ptr, byval filter_method as long ptr) as png_uint_32
declare sub png_set_IHDR(byval png_ptr as png_structp, byval info_ptr as png_infop, byval width as png_uint_32, byval height as png_uint_32, byval bit_depth as long, byval color_type as long, byval interlace_method as long, byval compression_method as long, byval filter_method as long)
declare function png_get_oFFs(byval png_ptr as png_structp, byval info_ptr as png_infop, byval offset_x as png_int_32 ptr, byval offset_y as png_int_32 ptr, byval unit_type as long ptr) as png_uint_32
declare sub png_set_oFFs(byval png_ptr as png_structp, byval info_ptr as png_infop, byval offset_x as png_int_32, byval offset_y as png_int_32, byval unit_type as long)
declare function png_get_pCAL(byval png_ptr as png_structp, byval info_ptr as png_infop, byval purpose as png_charp ptr, byval X0 as png_int_32 ptr, byval X1 as png_int_32 ptr, byval type as long ptr, byval nparams as long ptr, byval units as png_charp ptr, byval params as png_charpp ptr) as png_uint_32
declare sub png_set_pCAL(byval png_ptr as png_structp, byval info_ptr as png_infop, byval purpose as png_charp, byval X0 as png_int_32, byval X1 as png_int_32, byval type as long, byval nparams as long, byval units as png_charp, byval params as png_charpp)
declare function png_get_pHYs(byval png_ptr as png_structp, byval info_ptr as png_infop, byval res_x as png_uint_32 ptr, byval res_y as png_uint_32 ptr, byval unit_type as long ptr) as png_uint_32
declare sub png_set_pHYs(byval png_ptr as png_structp, byval info_ptr as png_infop, byval res_x as png_uint_32, byval res_y as png_uint_32, byval unit_type as long)
declare function png_get_PLTE(byval png_ptr as png_structp, byval info_ptr as png_infop, byval palette as png_colorp ptr, byval num_palette as long ptr) as png_uint_32
declare sub png_set_PLTE(byval png_ptr as png_structp, byval info_ptr as png_infop, byval palette as png_colorp, byval num_palette as long)
declare function png_get_sBIT(byval png_ptr as png_structp, byval info_ptr as png_infop, byval sig_bit as png_color_8p ptr) as png_uint_32
declare sub png_set_sBIT(byval png_ptr as png_structp, byval info_ptr as png_infop, byval sig_bit as png_color_8p)
declare function png_get_sRGB(byval png_ptr as png_structp, byval info_ptr as png_infop, byval intent as long ptr) as png_uint_32
declare sub png_set_sRGB(byval png_ptr as png_structp, byval info_ptr as png_infop, byval intent as long)
declare sub png_set_sRGB_gAMA_and_cHRM(byval png_ptr as png_structp, byval info_ptr as png_infop, byval intent as long)
declare function png_get_iCCP(byval png_ptr as png_structp, byval info_ptr as png_infop, byval name as png_charpp, byval compression_type as long ptr, byval profile as png_charpp, byval proflen as png_uint_32 ptr) as png_uint_32
declare sub png_set_iCCP(byval png_ptr as png_structp, byval info_ptr as png_infop, byval name as png_charp, byval compression_type as long, byval profile as png_charp, byval proflen as png_uint_32)
declare function png_get_sPLT(byval png_ptr as png_structp, byval info_ptr as png_infop, byval entries as png_sPLT_tpp) as png_uint_32
declare sub png_set_sPLT(byval png_ptr as png_structp, byval info_ptr as png_infop, byval entries as png_sPLT_tp, byval nentries as long)
declare function png_get_text(byval png_ptr as png_structp, byval info_ptr as png_infop, byval text_ptr as png_textp ptr, byval num_text as long ptr) as png_uint_32
declare sub png_set_text(byval png_ptr as png_structp, byval info_ptr as png_infop, byval text_ptr as png_textp, byval num_text as long)
declare function png_get_tIME(byval png_ptr as png_structp, byval info_ptr as png_infop, byval mod_time as png_timep ptr) as png_uint_32
declare sub png_set_tIME(byval png_ptr as png_structp, byval info_ptr as png_infop, byval mod_time as png_timep)
declare function png_get_tRNS(byval png_ptr as png_structp, byval info_ptr as png_infop, byval trans as png_bytep ptr, byval num_trans as long ptr, byval trans_values as png_color_16p ptr) as png_uint_32
declare sub png_set_tRNS(byval png_ptr as png_structp, byval info_ptr as png_infop, byval trans as png_bytep, byval num_trans as long, byval trans_values as png_color_16p)
declare function png_get_sCAL(byval png_ptr as png_structp, byval info_ptr as png_infop, byval unit as long ptr, byval width as double ptr, byval height as double ptr) as png_uint_32
declare sub png_set_sCAL(byval png_ptr as png_structp, byval info_ptr as png_infop, byval unit as long, byval width as double, byval height as double)
declare sub png_set_keep_unknown_chunks(byval png_ptr as png_structp, byval keep as long, byval chunk_list as png_bytep, byval num_chunks as long)
declare function png_handle_as_unknown(byval png_ptr as png_structp, byval chunk_name as png_bytep) as long
declare sub png_set_unknown_chunks(byval png_ptr as png_structp, byval info_ptr as png_infop, byval unknowns as png_unknown_chunkp, byval num_unknowns as long)
declare sub png_set_unknown_chunk_location(byval png_ptr as png_structp, byval info_ptr as png_infop, byval chunk as long, byval location as long)
declare function png_get_unknown_chunks(byval png_ptr as png_structp, byval info_ptr as png_infop, byval entries as png_unknown_chunkpp) as png_uint_32
declare sub png_set_invalid(byval png_ptr as png_structp, byval info_ptr as png_infop, byval mask as long)
declare sub png_read_png(byval png_ptr as png_structp, byval info_ptr as png_infop, byval transforms as long, byval params as png_voidp)
declare sub png_write_png(byval png_ptr as png_structp, byval info_ptr as png_infop, byval transforms as long, byval params as png_voidp)

#define png_debug(l, m)
#define png_debug1(l, m, p1)
#define png_debug2(l, m, p1, p2)

declare function png_get_copyright(byval png_ptr as png_structp) as png_charp
declare function png_get_header_ver(byval png_ptr as png_structp) as png_charp
declare function png_get_header_version(byval png_ptr as png_structp) as png_charp
declare function png_get_libpng_ver(byval png_ptr as png_structp) as png_charp
declare function png_permit_mng_features(byval png_ptr as png_structp, byval mng_features_permitted as png_uint_32) as png_uint_32

const PNG_HANDLE_CHUNK_AS_DEFAULT = 0
const PNG_HANDLE_CHUNK_NEVER = 1
const PNG_HANDLE_CHUNK_IF_SAFE = 2
const PNG_HANDLE_CHUNK_ALWAYS = 3

#if defined(__FB_DOS__) or defined(__FB_WIN32__) or defined(__FB_CYGWIN__) or defined(__FB_LINUX__) or defined(__FB_FREEBSD__) or defined(__FB_OPENBSD__) or defined(__FB_NETBSD__)
	const PNG_ASM_FLAG_MMX_SUPPORT_COMPILED = &h01
	const PNG_ASM_FLAG_MMX_SUPPORT_IN_CPU = &h02
	const PNG_ASM_FLAG_MMX_READ_COMBINE_ROW = &h04
	const PNG_ASM_FLAG_MMX_READ_INTERLACE = &h08
	const PNG_ASM_FLAG_MMX_READ_FILTER_SUB = &h10
	const PNG_ASM_FLAG_MMX_READ_FILTER_UP = &h20
	const PNG_ASM_FLAG_MMX_READ_FILTER_AVG = &h40
	const PNG_ASM_FLAG_MMX_READ_FILTER_PAETH = &h80
	const PNG_ASM_FLAGS_INITIALIZED = &h80000000
	const PNG_MMX_READ_FLAGS = ((((PNG_ASM_FLAG_MMX_READ_COMBINE_ROW or PNG_ASM_FLAG_MMX_READ_INTERLACE) or PNG_ASM_FLAG_MMX_READ_FILTER_SUB) or PNG_ASM_FLAG_MMX_READ_FILTER_UP) or PNG_ASM_FLAG_MMX_READ_FILTER_AVG) or PNG_ASM_FLAG_MMX_READ_FILTER_PAETH
	const PNG_MMX_WRITE_FLAGS = 0
	const PNG_MMX_FLAGS = ((PNG_ASM_FLAG_MMX_SUPPORT_COMPILED or PNG_ASM_FLAG_MMX_SUPPORT_IN_CPU) or PNG_MMX_READ_FLAGS) or PNG_MMX_WRITE_FLAGS
	const PNG_SELECT_READ = 1
	const PNG_SELECT_WRITE = 2
#endif

declare function png_get_mmx_flagmask(byval flag_select as long, byval compilerID as long ptr) as png_uint_32
declare function png_get_asm_flagmask(byval flag_select as long) as png_uint_32
declare function png_get_asm_flags(byval png_ptr as png_structp) as png_uint_32
declare function png_get_mmx_bitdepth_threshold(byval png_ptr as png_structp) as png_byte
declare function png_get_mmx_rowbytes_threshold(byval png_ptr as png_structp) as png_uint_32
declare sub png_set_asm_flags(byval png_ptr as png_structp, byval asm_flags as png_uint_32)
declare sub png_set_mmx_thresholds(byval png_ptr as png_structp, byval mmx_bitdepth_threshold as png_byte, byval mmx_rowbytes_threshold as png_uint_32)
declare function png_mmx_support() as long
declare sub png_set_strip_error_numbers(byval png_ptr as png_structp, byval strip_mode as png_uint_32)
declare sub png_set_user_limits(byval png_ptr as png_structp, byval user_width_max as png_uint_32, byval user_height_max as png_uint_32)
declare function png_get_user_width_max(byval png_ptr as png_structp) as png_uint_32
declare function png_get_user_height_max(byval png_ptr as png_structp) as png_uint_32
#macro png_composite(composite, fg, alpha, bg)
	scope
		dim temp as png_uint_16 = cast(png_uint_16, ((cast(png_uint_16, (fg)) * cast(png_uint_16, (alpha))) + (cast(png_uint_16, (bg)) * cast(png_uint_16, 255 - cast(png_uint_16, (alpha))))) + cast(png_uint_16, 128))
		(composite) = cast(png_byte, (temp + (temp shr 8)) shr 8)
	end scope
#endmacro
#macro png_composite_16(composite, fg, alpha, bg)
	scope
		dim temp as png_uint_32 = cast(png_uint_32, ((cast(png_uint_32, (fg)) * cast(png_uint_32, (alpha))) + (cast(png_uint_32, (bg)) * cast(png_uint_32, cast(clong, 65535) - cast(png_uint_32, (alpha))))) + cast(png_uint_32, cast(clong, 32768)))
		(composite) = cast(png_uint_16, (temp + (temp shr 16)) shr 16)
	end scope
#endmacro
declare function png_get_uint_32(byval buf as png_bytep) as png_uint_32
declare function png_get_uint_16(byval buf as png_bytep) as png_uint_16
declare function png_get_int_32(byval buf as png_bytep) as png_int_32
declare function png_get_uint_31(byval png_ptr as png_structp, byval buf as png_bytep) as png_uint_32
declare sub png_save_uint_32(byval buf as png_bytep, byval i as png_uint_32)
declare sub png_save_int_32(byval buf as png_bytep, byval i as png_int_32)
declare sub png_save_uint_16(byval buf as png_bytep, byval i as ulong)

const PNG_HAVE_IHDR = &h01
const PNG_HAVE_PLTE = &h02
const PNG_HAVE_IDAT = &h04
const PNG_AFTER_IDAT = &h08
const PNG_HAVE_IEND = &h10

end extern
