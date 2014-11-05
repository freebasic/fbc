#pragma once
#inclib "png"
#inclib "z"

#include once "crt/long.bi"
#include once "crt/limits.bi"
#include once "crt/stddef.bi"
#include once "crt/stdio.bi"
#include once "crt/setjmp.bi"
#include once "crt/time.bi"

'' The following symbols have been renamed:
''     #define PNG_READ_tEXt_SUPPORTED => PNG_READ_tEXt_SUPPORTED_
''     #define PNG_WRITE_tEXt_SUPPORTED => PNG_WRITE_tEXt_SUPPORTED_
''     #define PNG_tEXt_SUPPORTED => PNG_tEXt_SUPPORTED_
''     #define png_libpng_ver => png_libpng_ver_
''     #define PNG_get_uint_32 => PNG_get_uint_32_
''     #define PNG_get_uint_16 => PNG_get_uint_16_
''     #define PNG_get_int_32 => PNG_get_int_32_
''     #define png_get_uint_32 => png_get_uint_32__
''     #define png_get_uint_16 => png_get_uint_16__
''     #define png_get_int_32 => png_get_int_32__

extern "C"

type png_control as png_control_

#define PNG_H
#define PNG_LIBPNG_VER_STRING "1.6.14"
#define PNG_HEADER_VERSION_STRING !" libpng version 1.6.14 - October 23, 2014\n"
#define PNG_LIBPNG_VER_SONUM 16
#define PNG_LIBPNG_VER_DLLNUM 16
#define PNG_LIBPNG_VER_MAJOR 1
#define PNG_LIBPNG_VER_MINOR 6
#define PNG_LIBPNG_VER_RELEASE 14
#define PNG_LIBPNG_VER_BUILD 0
#define PNG_LIBPNG_BUILD_ALPHA 1
#define PNG_LIBPNG_BUILD_BETA 2
#define PNG_LIBPNG_BUILD_RC 3
#define PNG_LIBPNG_BUILD_STABLE 4
#define PNG_LIBPNG_BUILD_RELEASE_STATUS_MASK 7
#define PNG_LIBPNG_BUILD_PATCH 8
#define PNG_LIBPNG_BUILD_PRIVATE 16
#define PNG_LIBPNG_BUILD_SPECIAL 32
#define PNG_LIBPNG_BUILD_BASE_TYPE PNG_LIBPNG_BUILD_STABLE
#define PNG_LIBPNG_VER 10614
#define PNGLCONF_H
#define PNG_16BIT_SUPPORTED
#define PNG_ALIGNED_MEMORY_SUPPORTED
#define PNG_BENIGN_ERRORS_SUPPORTED
#define PNG_BENIGN_READ_ERRORS_SUPPORTED
#define PNG_BUILD_GRAYSCALE_PALETTE_SUPPORTED
#define PNG_CHECK_FOR_INVALID_INDEX_SUPPORTED
#define PNG_COLORSPACE_SUPPORTED
#define PNG_CONSOLE_IO_SUPPORTED
#define PNG_CONVERT_tIME_SUPPORTED
#define PNG_EASY_ACCESS_SUPPORTED
#define PNG_ERROR_TEXT_SUPPORTED
#define PNG_FIXED_POINT_SUPPORTED
#define PNG_FLOATING_ARITHMETIC_SUPPORTED
#define PNG_FLOATING_POINT_SUPPORTED
#define PNG_FORMAT_AFIRST_SUPPORTED
#define PNG_FORMAT_BGR_SUPPORTED
#define PNG_GAMMA_SUPPORTED
#define PNG_GET_PALETTE_MAX_SUPPORTED
#define PNG_HANDLE_AS_UNKNOWN_SUPPORTED
#define PNG_INCH_CONVERSIONS_SUPPORTED
#define PNG_INFO_IMAGE_SUPPORTED
#define PNG_IO_STATE_SUPPORTED
#define PNG_MNG_FEATURES_SUPPORTED
#define PNG_POINTER_INDEXING_SUPPORTED
#define PNG_PROGRESSIVE_READ_SUPPORTED
#define PNG_READ_16BIT_SUPPORTED
#define PNG_READ_ALPHA_MODE_SUPPORTED
#define PNG_READ_ANCILLARY_CHUNKS_SUPPORTED
#define PNG_READ_BACKGROUND_SUPPORTED
#define PNG_READ_BGR_SUPPORTED
#define PNG_READ_CHECK_FOR_INVALID_INDEX_SUPPORTED
#define PNG_READ_COMPOSITE_NODIV_SUPPORTED
#define PNG_READ_COMPRESSED_TEXT_SUPPORTED
#define PNG_READ_EXPAND_16_SUPPORTED
#define PNG_READ_EXPAND_SUPPORTED
#define PNG_READ_FILLER_SUPPORTED
#define PNG_READ_GAMMA_SUPPORTED
#define PNG_READ_GET_PALETTE_MAX_SUPPORTED
#define PNG_READ_GRAY_TO_RGB_SUPPORTED
#define PNG_READ_INTERLACING_SUPPORTED
#define PNG_READ_INT_FUNCTIONS_SUPPORTED
#define PNG_READ_INVERT_ALPHA_SUPPORTED
#define PNG_READ_INVERT_SUPPORTED
#define PNG_READ_OPT_PLTE_SUPPORTED
#define PNG_READ_PACKSWAP_SUPPORTED
#define PNG_READ_PACK_SUPPORTED
#define PNG_READ_QUANTIZE_SUPPORTED
#define PNG_READ_RGB_TO_GRAY_SUPPORTED
#define PNG_READ_SCALE_16_TO_8_SUPPORTED
#define PNG_READ_SHIFT_SUPPORTED
#define PNG_READ_STRIP_16_TO_8_SUPPORTED
#define PNG_READ_STRIP_ALPHA_SUPPORTED
#define PNG_READ_SUPPORTED
#define PNG_READ_SWAP_ALPHA_SUPPORTED
#define PNG_READ_SWAP_SUPPORTED
#define PNG_READ_TEXT_SUPPORTED
#define PNG_READ_TRANSFORMS_SUPPORTED
#define PNG_READ_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_READ_USER_CHUNKS_SUPPORTED
#define PNG_READ_USER_TRANSFORM_SUPPORTED
#define PNG_READ_bKGD_SUPPORTED
#define PNG_READ_cHRM_SUPPORTED
#define PNG_READ_gAMA_SUPPORTED
#define PNG_READ_hIST_SUPPORTED
#define PNG_READ_iCCP_SUPPORTED
#define PNG_READ_iTXt_SUPPORTED
#define PNG_READ_oFFs_SUPPORTED
#define PNG_READ_pCAL_SUPPORTED
#define PNG_READ_pHYs_SUPPORTED
#define PNG_READ_sBIT_SUPPORTED
#define PNG_READ_sCAL_SUPPORTED
#define PNG_READ_sPLT_SUPPORTED
#define PNG_READ_sRGB_SUPPORTED
#define PNG_READ_tEXt_SUPPORTED_
#define PNG_READ_tIME_SUPPORTED
#define PNG_READ_tRNS_SUPPORTED
#define PNG_READ_zTXt_SUPPORTED
#define PNG_SAVE_INT_32_SUPPORTED
#define PNG_SAVE_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_SEQUENTIAL_READ_SUPPORTED
#define PNG_SETJMP_SUPPORTED
#define PNG_SET_CHUNK_CACHE_LIMIT_SUPPORTED
#define PNG_SET_CHUNK_MALLOC_LIMIT_SUPPORTED
#define PNG_SET_OPTION_SUPPORTED
#define PNG_SET_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_SET_USER_LIMITS_SUPPORTED
#define PNG_SIMPLIFIED_READ_AFIRST_SUPPORTED
#define PNG_SIMPLIFIED_READ_BGR_SUPPORTED
#define PNG_SIMPLIFIED_READ_SUPPORTED
#define PNG_SIMPLIFIED_WRITE_AFIRST_SUPPORTED
#define PNG_SIMPLIFIED_WRITE_BGR_SUPPORTED
#define PNG_SIMPLIFIED_WRITE_SUPPORTED
#define PNG_STDIO_SUPPORTED
#define PNG_STORE_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_TEXT_SUPPORTED
#define PNG_TIME_RFC1123_SUPPORTED
#define PNG_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_USER_CHUNKS_SUPPORTED
#define PNG_USER_LIMITS_SUPPORTED
#define PNG_USER_MEM_SUPPORTED
#define PNG_USER_TRANSFORM_INFO_SUPPORTED
#define PNG_USER_TRANSFORM_PTR_SUPPORTED
#define PNG_WARNINGS_SUPPORTED
#define PNG_WRITE_16BIT_SUPPORTED
#define PNG_WRITE_ANCILLARY_CHUNKS_SUPPORTED
#define PNG_WRITE_BGR_SUPPORTED
#define PNG_WRITE_CHECK_FOR_INVALID_INDEX_SUPPORTED
#define PNG_WRITE_COMPRESSED_TEXT_SUPPORTED
#define PNG_WRITE_CUSTOMIZE_ZTXT_COMPRESSION_SUPPORTED
#define PNG_WRITE_FILLER_SUPPORTED
#define PNG_WRITE_FILTER_SUPPORTED
#define PNG_WRITE_FLUSH_SUPPORTED
#define PNG_WRITE_GET_PALETTE_MAX_SUPPORTED
#define PNG_WRITE_INTERLACING_SUPPORTED
#define PNG_WRITE_INT_FUNCTIONS_SUPPORTED
#define PNG_WRITE_INVERT_ALPHA_SUPPORTED
#define PNG_WRITE_INVERT_SUPPORTED
#define PNG_WRITE_OPTIMIZE_CMF_SUPPORTED
#define PNG_WRITE_PACKSWAP_SUPPORTED
#define PNG_WRITE_PACK_SUPPORTED
#define PNG_WRITE_SHIFT_SUPPORTED
#define PNG_WRITE_SUPPORTED
#define PNG_WRITE_SWAP_ALPHA_SUPPORTED
#define PNG_WRITE_SWAP_SUPPORTED
#define PNG_WRITE_TEXT_SUPPORTED
#define PNG_WRITE_TRANSFORMS_SUPPORTED
#define PNG_WRITE_UNKNOWN_CHUNKS_SUPPORTED
#define PNG_WRITE_USER_TRANSFORM_SUPPORTED
#define PNG_WRITE_WEIGHTED_FILTER_SUPPORTED
#define PNG_WRITE_bKGD_SUPPORTED
#define PNG_WRITE_cHRM_SUPPORTED
#define PNG_WRITE_gAMA_SUPPORTED
#define PNG_WRITE_hIST_SUPPORTED
#define PNG_WRITE_iCCP_SUPPORTED
#define PNG_WRITE_iTXt_SUPPORTED
#define PNG_WRITE_oFFs_SUPPORTED
#define PNG_WRITE_pCAL_SUPPORTED
#define PNG_WRITE_pHYs_SUPPORTED
#define PNG_WRITE_sBIT_SUPPORTED
#define PNG_WRITE_sCAL_SUPPORTED
#define PNG_WRITE_sPLT_SUPPORTED
#define PNG_WRITE_sRGB_SUPPORTED
#define PNG_WRITE_tEXt_SUPPORTED_
#define PNG_WRITE_tIME_SUPPORTED
#define PNG_WRITE_tRNS_SUPPORTED
#define PNG_WRITE_zTXt_SUPPORTED
#define PNG_bKGD_SUPPORTED
#define PNG_cHRM_SUPPORTED
#define PNG_gAMA_SUPPORTED
#define PNG_hIST_SUPPORTED
#define PNG_iCCP_SUPPORTED
#define PNG_iTXt_SUPPORTED
#define PNG_oFFs_SUPPORTED
#define PNG_pCAL_SUPPORTED
#define PNG_pHYs_SUPPORTED
#define PNG_sBIT_SUPPORTED
#define PNG_sCAL_SUPPORTED
#define PNG_sPLT_SUPPORTED
#define PNG_sRGB_SUPPORTED
#define PNG_tEXt_SUPPORTED_
#define PNG_tIME_SUPPORTED
#define PNG_tRNS_SUPPORTED
#define PNG_zTXt_SUPPORTED
#define PNG_API_RULE 0
#define PNG_COST_SHIFT 3
#define PNG_DEFAULT_READ_MACROS 1
#define PNG_GAMMA_THRESHOLD_FIXED 5000
#define PNG_IDAT_READ_SIZE PNG_ZBUF_SIZE
#define PNG_INFLATE_BUF_SIZE 1024
#define PNG_MAX_GAMMA_8 11
#define PNG_QUANTIZE_BLUE_BITS 5
#define PNG_QUANTIZE_GREEN_BITS 5
#define PNG_QUANTIZE_RED_BITS 5
#define PNG_TEXT_Z_DEFAULT_COMPRESSION (-1)
#define PNG_TEXT_Z_DEFAULT_STRATEGY 0
#define PNG_WEIGHT_SHIFT 8
#define PNG_ZBUF_SIZE 8192
#define PNG_ZLIB_VERNUM 0
#define PNG_Z_DEFAULT_COMPRESSION (-1)
#define PNG_Z_DEFAULT_NOFILTER_STRATEGY 0
#define PNG_Z_DEFAULT_STRATEGY 1
#define PNG_sCAL_PRECISION 5
#define PNG_sRGB_PROFILE_CHECKS 2
#define PNGCONF_H
#define PNG_USE_READ_MACROS

type png_byte as ubyte
type png_int_16 as short
type png_uint_16 as ushort
type png_int_32 as long
type png_uint_32 as ulong
type png_size_t as uinteger
type png_ptrdiff_t as integer
type png_alloc_size_t as png_size_t
type png_fixed_point as png_int_32
type png_voidp as any ptr
type png_const_voidp as const any ptr
type png_bytep as png_byte ptr
type png_const_bytep as const png_byte ptr
type png_uint_32p as png_uint_32 ptr
type png_const_uint_32p as const png_uint_32 ptr
type png_int_32p as png_int_32 ptr
type png_const_int_32p as const png_int_32 ptr
type png_uint_16p as png_uint_16 ptr
type png_const_uint_16p as const png_uint_16 ptr
type png_int_16p as png_int_16 ptr
type png_const_int_16p as const png_int_16 ptr
type png_charp as zstring ptr
type png_const_charp as const zstring ptr
type png_fixed_point_p as png_fixed_point ptr
type png_const_fixed_point_p as const png_fixed_point ptr
type png_size_tp as png_size_t ptr
type png_const_size_tp as const png_size_t ptr
type png_FILE_p as FILE ptr
type png_doublep as double ptr
type png_const_doublep as const double ptr
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

#define PNG_LIBPNG_BUILD_TYPE PNG_LIBPNG_BUILD_BASE_TYPE
#define png_libpng_ver_ png_get_header_ver(NULL)

type png_libpng_version_1_6_14 as zstring ptr
type png_struct as png_struct_def
type png_const_structp as const png_struct ptr
type png_structp as png_struct ptr
type png_structpp as png_struct ptr ptr
type png_info as png_info_def
type png_infop as png_info ptr
type png_const_infop as const png_info ptr
type png_infopp as png_info ptr ptr
type png_structrp as png_struct ptr
type png_const_structrp as const png_struct ptr
type png_inforp as png_info ptr
type png_const_inforp as const png_info ptr

type png_color_struct
	red as png_byte
	green as png_byte
	blue as png_byte
end type

type png_color as png_color_struct
type png_colorp as png_color ptr
type png_const_colorp as const png_color ptr
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
type png_const_color_16p as const png_color_16 ptr
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
type png_const_color_8p as const png_color_8 ptr
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
type png_const_sPLT_entryp as const png_sPLT_entry ptr
type png_sPLT_entrypp as png_sPLT_entry ptr ptr

type png_sPLT_struct
	name as png_charp
	depth as png_byte
	entries as png_sPLT_entryp
	nentries as png_int_32
end type

type png_sPLT_t as png_sPLT_struct
type png_sPLT_tp as png_sPLT_t ptr
type png_const_sPLT_tp as const png_sPLT_t ptr
type png_sPLT_tpp as png_sPLT_t ptr ptr

type png_text_struct
	compression as long
	key as png_charp
	text as png_charp
	text_length as png_size_t
	itxt_length as png_size_t
	lang as png_charp
	lang_key as png_charp
end type

type png_text as png_text_struct
type png_textp as png_text ptr
type png_const_textp as const png_text ptr
type png_textpp as png_text ptr ptr

#define PNG_TEXT_COMPRESSION_NONE_WR (-3)
#define PNG_TEXT_COMPRESSION_zTXt_WR (-2)
#define PNG_TEXT_COMPRESSION_NONE (-1)
#define PNG_TEXT_COMPRESSION_zTXt 0
#define PNG_ITXT_COMPRESSION_NONE 1
#define PNG_ITXT_COMPRESSION_zTXt 2
#define PNG_TEXT_COMPRESSION_LAST 3

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
type png_const_timep as const png_time ptr
type png_timepp as png_time ptr ptr

type png_unknown_chunk_t
	name(0 to 4) as png_byte
	data as png_byte ptr
	size as png_size_t
	location as png_byte
end type

type png_unknown_chunk as png_unknown_chunk_t
type png_unknown_chunkp as png_unknown_chunk ptr
type png_const_unknown_chunkp as const png_unknown_chunk ptr
type png_unknown_chunkpp as png_unknown_chunk ptr ptr

#define PNG_HAVE_IHDR &h01
#define PNG_HAVE_PLTE &h02
#define PNG_AFTER_IDAT &h08
#define PNG_UINT_31_MAX cast(png_uint_32, cast(clong, &h7fffffff))
#define PNG_UINT_32_MAX cast(png_uint_32, -1)
#define PNG_SIZE_MAX cast(png_size_t, -1)
#define PNG_FP_1 100000
#define PNG_FP_HALF 50000
#define PNG_FP_MAX cast(png_fixed_point, cast(clong, &h7fffffff))
#define PNG_FP_MIN (-PNG_FP_MAX)
#define PNG_COLOR_MASK_PALETTE 1
#define PNG_COLOR_MASK_COLOR 2
#define PNG_COLOR_MASK_ALPHA 4
#define PNG_COLOR_TYPE_GRAY 0
#define PNG_COLOR_TYPE_PALETTE (PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_PALETTE)
#define PNG_COLOR_TYPE_RGB PNG_COLOR_MASK_COLOR
#define PNG_COLOR_TYPE_RGB_ALPHA (PNG_COLOR_MASK_COLOR or PNG_COLOR_MASK_ALPHA)
#define PNG_COLOR_TYPE_GRAY_ALPHA PNG_COLOR_MASK_ALPHA
#define PNG_COLOR_TYPE_RGBA PNG_COLOR_TYPE_RGB_ALPHA
#define PNG_COLOR_TYPE_GA PNG_COLOR_TYPE_GRAY_ALPHA
#define PNG_COMPRESSION_TYPE_BASE 0
#define PNG_COMPRESSION_TYPE_DEFAULT PNG_COMPRESSION_TYPE_BASE
#define PNG_FILTER_TYPE_BASE 0
#define PNG_INTRAPIXEL_DIFFERENCING 64
#define PNG_FILTER_TYPE_DEFAULT PNG_FILTER_TYPE_BASE
#define PNG_INTERLACE_NONE 0
#define PNG_INTERLACE_ADAM7 1
#define PNG_INTERLACE_LAST 2
#define PNG_OFFSET_PIXEL 0
#define PNG_OFFSET_MICROMETER 1
#define PNG_OFFSET_LAST 2
#define PNG_EQUATION_LINEAR 0
#define PNG_EQUATION_BASE_E 1
#define PNG_EQUATION_ARBITRARY 2
#define PNG_EQUATION_HYPERBOLIC 3
#define PNG_EQUATION_LAST 4
#define PNG_SCALE_UNKNOWN 0
#define PNG_SCALE_METER 1
#define PNG_SCALE_RADIAN 2
#define PNG_SCALE_LAST 3
#define PNG_RESOLUTION_UNKNOWN 0
#define PNG_RESOLUTION_METER 1
#define PNG_RESOLUTION_LAST 2
#define PNG_sRGB_INTENT_PERCEPTUAL 0
#define PNG_sRGB_INTENT_RELATIVE 1
#define PNG_sRGB_INTENT_SATURATION 2
#define PNG_sRGB_INTENT_ABSOLUTE 3
#define PNG_sRGB_INTENT_LAST 4
#define PNG_KEYWORD_MAX_LENGTH 79
#define PNG_MAX_PALETTE_LENGTH 256
#define PNG_INFO_gAMA &h0001
#define PNG_INFO_sBIT &h0002
#define PNG_INFO_cHRM &h0004
#define PNG_INFO_PLTE &h0008
#define PNG_INFO_tRNS &h0010
#define PNG_INFO_bKGD &h0020
#define PNG_INFO_hIST &h0040
#define PNG_INFO_pHYs &h0080
#define PNG_INFO_oFFs &h0100
#define PNG_INFO_tIME &h0200
#define PNG_INFO_pCAL &h0400
#define PNG_INFO_sRGB &h0800
#define PNG_INFO_iCCP &h1000
#define PNG_INFO_sPLT &h2000
#define PNG_INFO_sCAL &h4000
#define PNG_INFO_IDAT &h8000

type png_row_info_struct
	width as png_uint_32
	rowbytes as png_size_t
	color_type as png_byte
	bit_depth as png_byte
	channels as png_byte
	pixel_depth as png_byte
end type

type png_row_info as png_row_info_struct
type png_row_infop as png_row_info ptr
type png_row_infopp as png_row_info ptr ptr
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
type png_longjmp_ptr as sub(byval as jmp_buf ptr, byval as long)

#define PNG_TRANSFORM_IDENTITY &h0000
#define PNG_TRANSFORM_STRIP_16 &h0001
#define PNG_TRANSFORM_STRIP_ALPHA &h0002
#define PNG_TRANSFORM_PACKING &h0004
#define PNG_TRANSFORM_PACKSWAP &h0008
#define PNG_TRANSFORM_EXPAND &h0010
#define PNG_TRANSFORM_INVERT_MONO &h0020
#define PNG_TRANSFORM_SHIFT &h0040
#define PNG_TRANSFORM_BGR &h0080
#define PNG_TRANSFORM_SWAP_ALPHA &h0100
#define PNG_TRANSFORM_SWAP_ENDIAN &h0200
#define PNG_TRANSFORM_INVERT_ALPHA &h0400
#define PNG_TRANSFORM_STRIP_FILLER &h0800
#define PNG_TRANSFORM_STRIP_FILLER_BEFORE PNG_TRANSFORM_STRIP_FILLER
#define PNG_TRANSFORM_STRIP_FILLER_AFTER &h1000
#define PNG_TRANSFORM_GRAY_TO_RGB &h2000
#define PNG_TRANSFORM_EXPAND_16 &h4000
#define PNG_TRANSFORM_SCALE_16 &h8000
#define PNG_FLAG_MNG_EMPTY_PLTE &h01
#define PNG_FLAG_MNG_FILTER_64 &h04
#define PNG_ALL_MNG_FEATURES &h05

type png_malloc_ptr as function(byval as png_structp, byval as png_alloc_size_t) as png_voidp
type png_free_ptr as sub(byval as png_structp, byval as png_voidp)

declare function png_access_version_number() as png_uint_32
declare sub png_set_sig_bytes(byval png_ptr as png_structrp, byval num_bytes as long)
declare function png_sig_cmp(byval sig as png_const_bytep, byval start as png_size_t, byval num_to_check as png_size_t) as long

#define png_check_sig(sig, n) (png_sig_cmp((sig), 0, (n)) = 0)

declare function png_create_read_struct(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr) as png_structp
declare function png_create_write_struct(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr) as png_structp
declare function png_get_compression_buffer_size(byval png_ptr as png_const_structrp) as png_size_t
declare sub png_set_compression_buffer_size(byval png_ptr as png_structrp, byval size as png_size_t)
declare function png_set_longjmp_fn(byval png_ptr as png_structrp, byval longjmp_fn as png_longjmp_ptr, byval jmp_buf_size as uinteger) as jmp_buf ptr

#define png_jmpbuf(png_ptr) png_set_longjmp_fn((png_ptr), @longjmp, sizeof(jmp_buf))

declare sub png_longjmp(byval png_ptr as png_const_structrp, byval val_ as long)
declare function png_reset_zstream(byval png_ptr as png_structrp) as long
declare function png_create_read_struct_2(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr, byval mem_ptr as png_voidp, byval malloc_fn as png_malloc_ptr, byval free_fn as png_free_ptr) as png_structp
declare function png_create_write_struct_2(byval user_png_ver as png_const_charp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warn_fn as png_error_ptr, byval mem_ptr as png_voidp, byval malloc_fn as png_malloc_ptr, byval free_fn as png_free_ptr) as png_structp
declare sub png_write_sig(byval png_ptr as png_structrp)
declare sub png_write_chunk(byval png_ptr as png_structrp, byval chunk_name as png_const_bytep, byval data_ as png_const_bytep, byval length as png_size_t)
declare sub png_write_chunk_start(byval png_ptr as png_structrp, byval chunk_name as png_const_bytep, byval length as png_uint_32)
declare sub png_write_chunk_data(byval png_ptr as png_structrp, byval data_ as png_const_bytep, byval length as png_size_t)
declare sub png_write_chunk_end(byval png_ptr as png_structrp)
declare function png_create_info_struct(byval png_ptr as png_const_structrp) as png_infop
declare sub png_info_init_3(byval info_ptr as png_infopp, byval png_info_struct_size as png_size_t)
declare sub png_write_info_before_PLTE(byval png_ptr as png_structrp, byval info_ptr as png_const_inforp)
declare sub png_write_info(byval png_ptr as png_structrp, byval info_ptr as png_const_inforp)
declare sub png_read_info(byval png_ptr as png_structrp, byval info_ptr as png_inforp)
declare function png_convert_to_rfc1123(byval png_ptr as png_structrp, byval ptime as png_const_timep) as png_const_charp
declare function png_convert_to_rfc1123_buffer(byval out_ as zstring ptr, byval ptime as png_const_timep) as long
declare sub png_convert_from_struct_tm(byval ptime as png_timep, byval ttime as const tm ptr)
declare sub png_convert_from_time_t(byval ptime as png_timep, byval ttime as time_t)
declare sub png_set_expand(byval png_ptr as png_structrp)
declare sub png_set_expand_gray_1_2_4_to_8(byval png_ptr as png_structrp)
declare sub png_set_palette_to_rgb(byval png_ptr as png_structrp)
declare sub png_set_tRNS_to_alpha(byval png_ptr as png_structrp)
declare sub png_set_expand_16(byval png_ptr as png_structrp)
declare sub png_set_bgr(byval png_ptr as png_structrp)
declare sub png_set_gray_to_rgb(byval png_ptr as png_structrp)

#define PNG_ERROR_ACTION_NONE 1
#define PNG_ERROR_ACTION_WARN 2
#define PNG_ERROR_ACTION_ERROR 3
#define PNG_RGB_TO_GRAY_DEFAULT (-1)

declare sub png_set_rgb_to_gray(byval png_ptr as png_structrp, byval error_action as long, byval red as double, byval green as double)
declare sub png_set_rgb_to_gray_fixed(byval png_ptr as png_structrp, byval error_action as long, byval red as png_fixed_point, byval green as png_fixed_point)
declare function png_get_rgb_to_gray_status(byval png_ptr as png_const_structrp) as png_byte
declare sub png_build_grayscale_palette(byval bit_depth as long, byval palette_ as png_colorp)

#define PNG_ALPHA_PNG 0
#define PNG_ALPHA_STANDARD 1
#define PNG_ALPHA_ASSOCIATED 1
#define PNG_ALPHA_PREMULTIPLIED 1
#define PNG_ALPHA_OPTIMIZED 2
#define PNG_ALPHA_BROKEN 3

declare sub png_set_alpha_mode(byval png_ptr as png_structrp, byval mode as long, byval output_gamma as double)
declare sub png_set_alpha_mode_fixed(byval png_ptr as png_structrp, byval mode as long, byval output_gamma as png_fixed_point)

#define PNG_DEFAULT_sRGB (-1)
#define PNG_GAMMA_MAC_18 (-2)
#define PNG_GAMMA_sRGB 220000
#define PNG_GAMMA_LINEAR PNG_FP_1

declare sub png_set_strip_alpha(byval png_ptr as png_structrp)
declare sub png_set_swap_alpha(byval png_ptr as png_structrp)
declare sub png_set_invert_alpha(byval png_ptr as png_structrp)
declare sub png_set_filler(byval png_ptr as png_structrp, byval filler as png_uint_32, byval flags as long)

#define PNG_FILLER_BEFORE 0
#define PNG_FILLER_AFTER 1

declare sub png_set_add_alpha(byval png_ptr as png_structrp, byval filler as png_uint_32, byval flags as long)
declare sub png_set_swap(byval png_ptr as png_structrp)
declare sub png_set_packing(byval png_ptr as png_structrp)
declare sub png_set_packswap(byval png_ptr as png_structrp)
declare sub png_set_shift(byval png_ptr as png_structrp, byval true_bits as png_const_color_8p)
declare function png_set_interlace_handling(byval png_ptr as png_structrp) as long
declare sub png_set_invert_mono(byval png_ptr as png_structrp)
declare sub png_set_background(byval png_ptr as png_structrp, byval background_color as png_const_color_16p, byval background_gamma_code as long, byval need_expand as long, byval background_gamma as double)
declare sub png_set_background_fixed(byval png_ptr as png_structrp, byval background_color as png_const_color_16p, byval background_gamma_code as long, byval need_expand as long, byval background_gamma as png_fixed_point)

#define PNG_BACKGROUND_GAMMA_UNKNOWN 0
#define PNG_BACKGROUND_GAMMA_SCREEN 1
#define PNG_BACKGROUND_GAMMA_FILE 2
#define PNG_BACKGROUND_GAMMA_UNIQUE 3

declare sub png_set_scale_16(byval png_ptr as png_structrp)

#define PNG_READ_16_TO_8 SUPPORTED

declare sub png_set_strip_16(byval png_ptr as png_structrp)
declare sub png_set_quantize(byval png_ptr as png_structrp, byval palette_ as png_colorp, byval num_palette as long, byval maximum_colors as long, byval histogram as png_const_uint_16p, byval full_quantize as long)

#define PNG_GAMMA_THRESHOLD (PNG_GAMMA_THRESHOLD_FIXED * .00001)

declare sub png_set_gamma(byval png_ptr as png_structrp, byval screen_gamma as double, byval override_file_gamma as double)
declare sub png_set_gamma_fixed(byval png_ptr as png_structrp, byval screen_gamma as png_fixed_point, byval override_file_gamma as png_fixed_point)
declare sub png_set_flush(byval png_ptr as png_structrp, byval nrows as long)
declare sub png_write_flush(byval png_ptr as png_structrp)
declare sub png_start_read_image(byval png_ptr as png_structrp)
declare sub png_read_update_info(byval png_ptr as png_structrp, byval info_ptr as png_inforp)
declare sub png_read_rows(byval png_ptr as png_structrp, byval row as png_bytepp, byval display_row as png_bytepp, byval num_rows as png_uint_32)
declare sub png_read_row(byval png_ptr as png_structrp, byval row as png_bytep, byval display_row as png_bytep)
declare sub png_read_image(byval png_ptr as png_structrp, byval image as png_bytepp)
declare sub png_write_row(byval png_ptr as png_structrp, byval row as png_const_bytep)
declare sub png_write_rows(byval png_ptr as png_structrp, byval row as png_bytepp, byval num_rows as png_uint_32)
declare sub png_write_image(byval png_ptr as png_structrp, byval image as png_bytepp)
declare sub png_write_end(byval png_ptr as png_structrp, byval info_ptr as png_inforp)
declare sub png_read_end(byval png_ptr as png_structrp, byval info_ptr as png_inforp)
declare sub png_destroy_info_struct(byval png_ptr as png_const_structrp, byval info_ptr_ptr as png_infopp)
declare sub png_destroy_read_struct(byval png_ptr_ptr as png_structpp, byval info_ptr_ptr as png_infopp, byval end_info_ptr_ptr as png_infopp)
declare sub png_destroy_write_struct(byval png_ptr_ptr as png_structpp, byval info_ptr_ptr as png_infopp)
declare sub png_set_crc_action(byval png_ptr as png_structrp, byval crit_action as long, byval ancil_action as long)

#define PNG_CRC_DEFAULT 0
#define PNG_CRC_ERROR_QUIT 1
#define PNG_CRC_WARN_DISCARD 2
#define PNG_CRC_WARN_USE 3
#define PNG_CRC_QUIET_USE 4
#define PNG_CRC_NO_CHANGE 5

declare sub png_set_filter(byval png_ptr as png_structrp, byval method as long, byval filters as long)

#define PNG_NO_FILTERS &h00
#define PNG_FILTER_NONE &h08
#define PNG_FILTER_SUB &h10
#define PNG_FILTER_UP &h20
#define PNG_FILTER_AVG &h40
#define PNG_FILTER_PAETH &h80
#define PNG_ALL_FILTERS ((((PNG_FILTER_NONE or PNG_FILTER_SUB) or PNG_FILTER_UP) or PNG_FILTER_AVG) or PNG_FILTER_PAETH)
#define PNG_FILTER_VALUE_NONE 0
#define PNG_FILTER_VALUE_SUB 1
#define PNG_FILTER_VALUE_UP 2
#define PNG_FILTER_VALUE_AVG 3
#define PNG_FILTER_VALUE_PAETH 4
#define PNG_FILTER_VALUE_LAST 5

declare sub png_set_filter_heuristics(byval png_ptr as png_structrp, byval heuristic_method as long, byval num_weights as long, byval filter_weights as png_const_doublep, byval filter_costs as png_const_doublep)
declare sub png_set_filter_heuristics_fixed(byval png_ptr as png_structrp, byval heuristic_method as long, byval num_weights as long, byval filter_weights as png_const_fixed_point_p, byval filter_costs as png_const_fixed_point_p)

#define PNG_FILTER_HEURISTIC_DEFAULT 0
#define PNG_FILTER_HEURISTIC_UNWEIGHTED 1
#define PNG_FILTER_HEURISTIC_WEIGHTED 2
#define PNG_FILTER_HEURISTIC_LAST 3

declare sub png_set_compression_level(byval png_ptr as png_structrp, byval level as long)
declare sub png_set_compression_mem_level(byval png_ptr as png_structrp, byval mem_level as long)
declare sub png_set_compression_strategy(byval png_ptr as png_structrp, byval strategy as long)
declare sub png_set_compression_window_bits(byval png_ptr as png_structrp, byval window_bits as long)
declare sub png_set_compression_method(byval png_ptr as png_structrp, byval method as long)
declare sub png_set_text_compression_level(byval png_ptr as png_structrp, byval level as long)
declare sub png_set_text_compression_mem_level(byval png_ptr as png_structrp, byval mem_level as long)
declare sub png_set_text_compression_strategy(byval png_ptr as png_structrp, byval strategy as long)
declare sub png_set_text_compression_window_bits(byval png_ptr as png_structrp, byval window_bits as long)
declare sub png_set_text_compression_method(byval png_ptr as png_structrp, byval method as long)
declare sub png_init_io(byval png_ptr as png_structrp, byval fp as png_FILE_p)
declare sub png_set_error_fn(byval png_ptr as png_structrp, byval error_ptr as png_voidp, byval error_fn as png_error_ptr, byval warning_fn as png_error_ptr)
declare function png_get_error_ptr(byval png_ptr as png_const_structrp) as png_voidp
declare sub png_set_write_fn(byval png_ptr as png_structrp, byval io_ptr as png_voidp, byval write_data_fn as png_rw_ptr, byval output_flush_fn as png_flush_ptr)
declare sub png_set_read_fn(byval png_ptr as png_structrp, byval io_ptr as png_voidp, byval read_data_fn as png_rw_ptr)
declare function png_get_io_ptr(byval png_ptr as png_const_structrp) as png_voidp
declare sub png_set_read_status_fn(byval png_ptr as png_structrp, byval read_row_fn as png_read_status_ptr)
declare sub png_set_write_status_fn(byval png_ptr as png_structrp, byval write_row_fn as png_write_status_ptr)
declare sub png_set_mem_fn(byval png_ptr as png_structrp, byval mem_ptr as png_voidp, byval malloc_fn as png_malloc_ptr, byval free_fn as png_free_ptr)
declare function png_get_mem_ptr(byval png_ptr as png_const_structrp) as png_voidp
declare sub png_set_read_user_transform_fn(byval png_ptr as png_structrp, byval read_user_transform_fn as png_user_transform_ptr)
declare sub png_set_write_user_transform_fn(byval png_ptr as png_structrp, byval write_user_transform_fn as png_user_transform_ptr)
declare sub png_set_user_transform_info(byval png_ptr as png_structrp, byval user_transform_ptr as png_voidp, byval user_transform_depth as long, byval user_transform_channels as long)
declare function png_get_user_transform_ptr(byval png_ptr as png_const_structrp) as png_voidp
declare function png_get_current_row_number(byval as png_const_structrp) as png_uint_32
declare function png_get_current_pass_number(byval as png_const_structrp) as png_byte
declare sub png_set_read_user_chunk_fn(byval png_ptr as png_structrp, byval user_chunk_ptr as png_voidp, byval read_user_chunk_fn as png_user_chunk_ptr)
declare function png_get_user_chunk_ptr(byval png_ptr as png_const_structrp) as png_voidp
declare sub png_set_progressive_read_fn(byval png_ptr as png_structrp, byval progressive_ptr as png_voidp, byval info_fn as png_progressive_info_ptr, byval row_fn as png_progressive_row_ptr, byval end_fn as png_progressive_end_ptr)
declare function png_get_progressive_ptr(byval png_ptr as png_const_structrp) as png_voidp
declare sub png_process_data(byval png_ptr as png_structrp, byval info_ptr as png_inforp, byval buffer as png_bytep, byval buffer_size as png_size_t)
declare function png_process_data_pause(byval as png_structrp, byval save as long) as png_size_t
declare function png_process_data_skip(byval as png_structrp) as png_uint_32
declare sub png_progressive_combine_row(byval png_ptr as png_const_structrp, byval old_row as png_bytep, byval new_row as png_const_bytep)
declare function png_malloc(byval png_ptr as png_const_structrp, byval size as png_alloc_size_t) as png_voidp
declare function png_calloc(byval png_ptr as png_const_structrp, byval size as png_alloc_size_t) as png_voidp
declare function png_malloc_warn(byval png_ptr as png_const_structrp, byval size as png_alloc_size_t) as png_voidp
declare sub png_free(byval png_ptr as png_const_structrp, byval ptr_ as png_voidp)
declare sub png_free_data(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval free_me as png_uint_32, byval num as long)
declare sub png_data_freer(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval freer as long, byval mask as png_uint_32)

#define PNG_DESTROY_WILL_FREE_DATA 1
#define PNG_SET_WILL_FREE_DATA 1
#define PNG_USER_WILL_FREE_DATA 2
#define PNG_FREE_HIST &h0008
#define PNG_FREE_ICCP &h0010
#define PNG_FREE_SPLT &h0020
#define PNG_FREE_ROWS &h0040
#define PNG_FREE_PCAL &h0080
#define PNG_FREE_SCAL &h0100
#define PNG_FREE_UNKN &h0200
#define PNG_FREE_PLTE &h1000
#define PNG_FREE_TRNS &h2000
#define PNG_FREE_TEXT &h4000
#define PNG_FREE_ALL &h7fff
#define PNG_FREE_MUL &h4220

declare function png_malloc_default(byval png_ptr as png_const_structrp, byval size as png_alloc_size_t) as png_voidp
declare sub png_free_default(byval png_ptr as png_const_structrp, byval ptr_ as png_voidp)
declare sub png_error(byval png_ptr as png_const_structrp, byval error_message as png_const_charp)
declare sub png_chunk_error(byval png_ptr as png_const_structrp, byval error_message as png_const_charp)
declare sub png_warning(byval png_ptr as png_const_structrp, byval warning_message as png_const_charp)
declare sub png_chunk_warning(byval png_ptr as png_const_structrp, byval warning_message as png_const_charp)
declare sub png_benign_error(byval png_ptr as png_const_structrp, byval warning_message as png_const_charp)
declare sub png_chunk_benign_error(byval png_ptr as png_const_structrp, byval warning_message as png_const_charp)
declare sub png_set_benign_errors(byval png_ptr as png_structrp, byval allowed as long)
declare function png_get_valid(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval flag as png_uint_32) as png_uint_32
declare function png_get_rowbytes(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_size_t
declare function png_get_rows(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_bytepp
declare sub png_set_rows(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval row_pointers as png_bytepp)
declare function png_get_channels(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_byte
declare function png_get_image_width(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_image_height(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_bit_depth(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_byte
declare function png_get_color_type(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_byte
declare function png_get_filter_type(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_byte
declare function png_get_interlace_type(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_byte
declare function png_get_compression_type(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_byte
declare function png_get_pixels_per_meter(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_x_pixels_per_meter(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_y_pixels_per_meter(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_pixel_aspect_ratio(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as single
declare function png_get_pixel_aspect_ratio_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_fixed_point
declare function png_get_x_offset_pixels(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_int_32
declare function png_get_y_offset_pixels(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_int_32
declare function png_get_x_offset_microns(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_int_32
declare function png_get_y_offset_microns(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_int_32
declare function png_get_signature(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_const_bytep
declare function png_get_bKGD(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval background as png_color_16p ptr) as png_uint_32
declare sub png_set_bKGD(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval background as png_const_color_16p)
declare function png_get_cHRM(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval white_x as double ptr, byval white_y as double ptr, byval red_x as double ptr, byval red_y as double ptr, byval green_x as double ptr, byval green_y as double ptr, byval blue_x as double ptr, byval blue_y as double ptr) as png_uint_32
declare function png_get_cHRM_XYZ(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval red_X as double ptr, byval red_Y as double ptr, byval red_Z as double ptr, byval green_X as double ptr, byval green_Y as double ptr, byval green_Z as double ptr, byval blue_X as double ptr, byval blue_Y as double ptr, byval blue_Z as double ptr) as png_uint_32
declare function png_get_cHRM_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval int_white_x as png_fixed_point ptr, byval int_white_y as png_fixed_point ptr, byval int_red_x as png_fixed_point ptr, byval int_red_y as png_fixed_point ptr, byval int_green_x as png_fixed_point ptr, byval int_green_y as png_fixed_point ptr, byval int_blue_x as png_fixed_point ptr, byval int_blue_y as png_fixed_point ptr) as png_uint_32
declare function png_get_cHRM_XYZ_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval int_red_X as png_fixed_point ptr, byval int_red_Y as png_fixed_point ptr, byval int_red_Z as png_fixed_point ptr, byval int_green_X as png_fixed_point ptr, byval int_green_Y as png_fixed_point ptr, byval int_green_Z as png_fixed_point ptr, byval int_blue_X as png_fixed_point ptr, byval int_blue_Y as png_fixed_point ptr, byval int_blue_Z as png_fixed_point ptr) as png_uint_32
declare sub png_set_cHRM(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval white_x as double, byval white_y as double, byval red_x as double, byval red_y as double, byval green_x as double, byval green_y as double, byval blue_x as double, byval blue_y as double)
declare sub png_set_cHRM_XYZ(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval red_X as double, byval red_Y as double, byval red_Z as double, byval green_X as double, byval green_Y as double, byval green_Z as double, byval blue_X as double, byval blue_Y as double, byval blue_Z as double)
declare sub png_set_cHRM_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval int_white_x as png_fixed_point, byval int_white_y as png_fixed_point, byval int_red_x as png_fixed_point, byval int_red_y as png_fixed_point, byval int_green_x as png_fixed_point, byval int_green_y as png_fixed_point, byval int_blue_x as png_fixed_point, byval int_blue_y as png_fixed_point)
declare sub png_set_cHRM_XYZ_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval int_red_X as png_fixed_point, byval int_red_Y as png_fixed_point, byval int_red_Z as png_fixed_point, byval int_green_X as png_fixed_point, byval int_green_Y as png_fixed_point, byval int_green_Z as png_fixed_point, byval int_blue_X as png_fixed_point, byval int_blue_Y as png_fixed_point, byval int_blue_Z as png_fixed_point)
declare function png_get_gAMA(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval file_gamma as double ptr) as png_uint_32
declare function png_get_gAMA_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval int_file_gamma as png_fixed_point ptr) as png_uint_32
declare sub png_set_gAMA(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval file_gamma as double)
declare sub png_set_gAMA_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval int_file_gamma as png_fixed_point)
declare function png_get_hIST(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval hist as png_uint_16p ptr) as png_uint_32
declare sub png_set_hIST(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval hist as png_const_uint_16p)
declare function png_get_IHDR(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval width_ as png_uint_32 ptr, byval height as png_uint_32 ptr, byval bit_depth as long ptr, byval color_type as long ptr, byval interlace_method as long ptr, byval compression_method as long ptr, byval filter_method as long ptr) as png_uint_32
declare sub png_set_IHDR(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval width_ as png_uint_32, byval height as png_uint_32, byval bit_depth as long, byval color_type as long, byval interlace_method as long, byval compression_method as long, byval filter_method as long)
declare function png_get_oFFs(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval offset_x as png_int_32 ptr, byval offset_y as png_int_32 ptr, byval unit_type as long ptr) as png_uint_32
declare sub png_set_oFFs(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval offset_x as png_int_32, byval offset_y as png_int_32, byval unit_type as long)
declare function png_get_pCAL(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval purpose as png_charp ptr, byval X0 as png_int_32 ptr, byval X1 as png_int_32 ptr, byval type_ as long ptr, byval nparams as long ptr, byval units as png_charp ptr, byval params as png_charpp ptr) as png_uint_32
declare sub png_set_pCAL(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval purpose as png_const_charp, byval X0 as png_int_32, byval X1 as png_int_32, byval type_ as long, byval nparams as long, byval units as png_const_charp, byval params as png_charpp)
declare function png_get_pHYs(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval res_x as png_uint_32 ptr, byval res_y as png_uint_32 ptr, byval unit_type as long ptr) as png_uint_32
declare sub png_set_pHYs(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval res_x as png_uint_32, byval res_y as png_uint_32, byval unit_type as long)
declare function png_get_PLTE(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval palette_ as png_colorp ptr, byval num_palette as long ptr) as png_uint_32
declare sub png_set_PLTE(byval png_ptr as png_structrp, byval info_ptr as png_inforp, byval palette_ as png_const_colorp, byval num_palette as long)
declare function png_get_sBIT(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval sig_bit as png_color_8p ptr) as png_uint_32
declare sub png_set_sBIT(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval sig_bit as png_const_color_8p)
declare function png_get_sRGB(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval file_srgb_intent as long ptr) as png_uint_32
declare sub png_set_sRGB(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval srgb_intent as long)
declare sub png_set_sRGB_gAMA_and_cHRM(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval srgb_intent as long)
declare function png_get_iCCP(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval name_ as png_charpp, byval compression_type as long ptr, byval profile as png_bytepp, byval proflen as png_uint_32 ptr) as png_uint_32
declare sub png_set_iCCP(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval name_ as png_const_charp, byval compression_type as long, byval profile as png_const_bytep, byval proflen as png_uint_32)
declare function png_get_sPLT(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval entries as png_sPLT_tpp) as long
declare sub png_set_sPLT(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval entries as png_const_sPLT_tp, byval nentries as long)
declare function png_get_text(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval text_ptr as png_textp ptr, byval num_text as long ptr) as long
declare sub png_set_text(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval text_ptr as png_const_textp, byval num_text as long)
declare function png_get_tIME(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval mod_time as png_timep ptr) as png_uint_32
declare sub png_set_tIME(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval mod_time as png_const_timep)
declare function png_get_tRNS(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval trans_alpha as png_bytep ptr, byval num_trans as long ptr, byval trans_color as png_color_16p ptr) as png_uint_32
declare sub png_set_tRNS(byval png_ptr as png_structrp, byval info_ptr as png_inforp, byval trans_alpha as png_const_bytep, byval num_trans as long, byval trans_color as png_const_color_16p)
declare function png_get_sCAL(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval unit as long ptr, byval width_ as double ptr, byval height as double ptr) as png_uint_32
declare function png_get_sCAL_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval unit as long ptr, byval width_ as png_fixed_point ptr, byval height as png_fixed_point ptr) as png_uint_32
declare function png_get_sCAL_s(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval unit as long ptr, byval swidth as png_charpp, byval sheight as png_charpp) as png_uint_32
declare sub png_set_sCAL(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval unit as long, byval width_ as double, byval height as double)
declare sub png_set_sCAL_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval unit as long, byval width_ as png_fixed_point, byval height as png_fixed_point)
declare sub png_set_sCAL_s(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval unit as long, byval swidth as png_const_charp, byval sheight as png_const_charp)
declare sub png_set_keep_unknown_chunks(byval png_ptr as png_structrp, byval keep as long, byval chunk_list as png_const_bytep, byval num_chunks as long)
declare function png_handle_as_unknown(byval png_ptr as png_const_structrp, byval chunk_name as png_const_bytep) as long
declare sub png_set_unknown_chunks(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval unknowns as png_const_unknown_chunkp, byval num_unknowns as long)
declare sub png_set_unknown_chunk_location(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval chunk as long, byval location as long)
declare function png_get_unknown_chunks(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval entries as png_unknown_chunkpp) as long
declare sub png_set_invalid(byval png_ptr as png_const_structrp, byval info_ptr as png_inforp, byval mask as long)
declare sub png_read_png(byval png_ptr as png_structrp, byval info_ptr as png_inforp, byval transforms as long, byval params as png_voidp)
declare sub png_write_png(byval png_ptr as png_structrp, byval info_ptr as png_inforp, byval transforms as long, byval params as png_voidp)
declare function png_get_copyright(byval png_ptr as png_const_structrp) as png_const_charp
declare function png_get_header_ver(byval png_ptr as png_const_structrp) as png_const_charp
declare function png_get_header_version(byval png_ptr as png_const_structrp) as png_const_charp
declare function png_get_libpng_ver(byval png_ptr as png_const_structrp) as png_const_charp
declare function png_permit_mng_features(byval png_ptr as png_structrp, byval mng_features_permitted as png_uint_32) as png_uint_32

#define PNG_HANDLE_CHUNK_AS_DEFAULT 0
#define PNG_HANDLE_CHUNK_NEVER 1
#define PNG_HANDLE_CHUNK_IF_SAFE 2
#define PNG_HANDLE_CHUNK_ALWAYS 3
#define PNG_HANDLE_CHUNK_LAST 4

declare sub png_set_user_limits(byval png_ptr as png_structrp, byval user_width_max as png_uint_32, byval user_height_max as png_uint_32)
declare function png_get_user_width_max(byval png_ptr as png_const_structrp) as png_uint_32
declare function png_get_user_height_max(byval png_ptr as png_const_structrp) as png_uint_32
declare sub png_set_chunk_cache_max(byval png_ptr as png_structrp, byval user_chunk_cache_max as png_uint_32)
declare function png_get_chunk_cache_max(byval png_ptr as png_const_structrp) as png_uint_32
declare sub png_set_chunk_malloc_max(byval png_ptr as png_structrp, byval user_chunk_cache_max as png_alloc_size_t)
declare function png_get_chunk_malloc_max(byval png_ptr as png_const_structrp) as png_alloc_size_t
declare function png_get_pixels_per_inch(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_x_pixels_per_inch(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_y_pixels_per_inch(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_uint_32
declare function png_get_x_offset_inches(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as single
declare function png_get_x_offset_inches_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_fixed_point
declare function png_get_y_offset_inches(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as single
declare function png_get_y_offset_inches_fixed(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp) as png_fixed_point
declare function png_get_pHYs_dpi(byval png_ptr as png_const_structrp, byval info_ptr as png_const_inforp, byval res_x as png_uint_32 ptr, byval res_y as png_uint_32 ptr, byval unit_type as long ptr) as png_uint_32
declare function png_get_io_state(byval png_ptr as png_const_structrp) as png_uint_32
declare function png_get_io_chunk_type(byval png_ptr as png_const_structrp) as png_uint_32

#define PNG_IO_NONE &h0000
#define PNG_IO_READING &h0001
#define PNG_IO_WRITING &h0002
#define PNG_IO_SIGNATURE &h0010
#define PNG_IO_CHUNK_HDR &h0020
#define PNG_IO_CHUNK_DATA &h0040
#define PNG_IO_CHUNK_CRC &h0080
#define PNG_IO_MASK_OP &h000f
#define PNG_IO_MASK_LOC &h00f0
#define PNG_INTERLACE_ADAM7_PASSES 7
#define PNG_PASS_START_ROW(pass) (((1 and (not (pass))) shl (3 - ((pass) shr 1))) and 7)
#define PNG_PASS_START_COL(pass) (((1 and (pass)) shl (3 - (((pass) + 1) shr 1))) and 7)
#define PNG_PASS_ROW_OFFSET(pass) iif((pass) > 2, 8 shr (((pass) - 1) shr 1), 8)
#define PNG_PASS_COL_OFFSET(pass) (1 shl ((7 - (pass)) shr 1))
#define PNG_PASS_ROW_SHIFT(pass) iif((pass) > 2, (8 - (pass)) shr 1, 3)
#define PNG_PASS_COL_SHIFT(pass) iif((pass) > 1, (7 - (pass)) shr 1, 3)
#define PNG_PASS_ROWS(height, pass) (((height) + (((1 shl PNG_PASS_ROW_SHIFT(pass)) - 1) - PNG_PASS_START_ROW(pass))) shr PNG_PASS_ROW_SHIFT(pass))
#define PNG_PASS_COLS(width, pass) (((width) + (((1 shl PNG_PASS_COL_SHIFT(pass)) - 1) - PNG_PASS_START_COL(pass))) shr PNG_PASS_COL_SHIFT(pass))
#define PNG_ROW_FROM_PASS_ROW(y_in, pass) (((y_in) shl PNG_PASS_ROW_SHIFT(pass)) + PNG_PASS_START_ROW(pass))
#define PNG_COL_FROM_PASS_COL(x_in, pass) (((x_in) shl PNG_PASS_COL_SHIFT(pass)) + PNG_PASS_START_COL(pass))
#define PNG_PASS_MASK(pass, off) (((&h110145AF shr (((7 - (off)) - (pass)) shl 2)) and &hF) or ((&h01145AF0 shr (((7 - (off)) - (pass)) shl 2)) and &hF0))
#define PNG_ROW_IN_INTERLACE_PASS(y, pass) ((PNG_PASS_MASK(pass, 0) shr ((y) and 7)) and 1)
#define PNG_COL_IN_INTERLACE_PASS(x, pass) ((PNG_PASS_MASK(pass, 1) shr ((x) and 7)) and 1)
#macro png_composite(composite, fg, alpha, bg)
	scope
		dim temp as png_uint_16 = cast(png_uint_16, cast(png_uint_16, (fg) * cast(png_uint_16, (alpha) + cast(png_uint_16, (bg) * cast(png_uint_16, (255 - cast(png_uint_16, (alpha))) + 128)))))
		(composite) = cast(png_byte, ((temp + (temp shr 8)) shr 8))
	end scope
#endmacro
#macro png_composite_16(composite, fg, alpha, bg)
	scope
		dim temp as png_uint_32 = cast(png_uint_32, cast(png_uint_32, (fg) * cast(png_uint_32, (alpha) + cast(png_uint_32, ((bg) * (65535 - cast(png_uint_32, (alpha)))) + 32768))))
		(composite) = cast(png_uint_16, ((temp + (temp shr 16)) shr 16))
	end scope
#endmacro

declare function png_get_uint_32(byval buf as png_const_bytep) as png_uint_32
declare function png_get_uint_16(byval buf as png_const_bytep) as png_uint_16
declare function png_get_int_32(byval buf as png_const_bytep) as png_int_32
declare function png_get_uint_31(byval png_ptr as png_const_structrp, byval buf as png_const_bytep) as png_uint_32
declare sub png_save_uint_32(byval buf as png_bytep, byval i as png_uint_32)
declare sub png_save_int_32(byval buf as png_bytep, byval i as png_int_32)
declare sub png_save_uint_16(byval buf as png_bytep, byval i as ulong)

#define PNG_get_uint_32_(buf) (((cast(png_uint_32, (*(buf)) shl 24) + cast(png_uint_32, (*((buf) + 1)) shl 16)) + cast(png_uint_32, (*((buf) + 2)) shl 8)) + cast(png_uint_32, *((buf) + 3)))
#define PNG_get_uint_16_(buf) cast(png_uint_16, culng((*(buf)) shl 8) + culng(*((buf) + 1)))
#define PNG_get_int_32_(buf) cast(png_int_32, iif((*(buf)) and &h80, -cast(png_int_32, (png_get_uint_32__(buf) xor cast(clong, &hffffffff)) + 1), cast(png_int_32, png_get_uint_32__(buf))))
#define png_get_uint_32__(buf) PNG_get_uint_32_(buf)
#define png_get_uint_16__(buf) PNG_get_uint_16_(buf)
#define png_get_int_32__(buf) PNG_get_int_32_(buf)
#define PNG_IMAGE_VERSION 1

type png_controlp as png_control ptr

#define PNG_IMAGE_WARNING 1
#define PNG_IMAGE_ERROR 2
#define PNG_IMAGE_FAILED(png_cntrl) (((png_cntrl).warning_or_error and &h03) > 1)

type png_image
	opaque as png_controlp
	version as png_uint_32
	width as png_uint_32
	height as png_uint_32
	format as png_uint_32
	flags as png_uint_32
	colormap_entries as png_uint_32
	warning_or_error as png_uint_32
	message as zstring * 64
end type

type png_imagep as png_image ptr

#define PNG_FORMAT_FLAG_ALPHA &h01
#define PNG_FORMAT_FLAG_COLOR &h02
#define PNG_FORMAT_FLAG_LINEAR &h04
#define PNG_FORMAT_FLAG_COLORMAP &h08
#define PNG_FORMAT_FLAG_BGR &h10
#define PNG_FORMAT_FLAG_AFIRST &h20
#define PNG_FORMAT_GRAY 0
#define PNG_FORMAT_GA PNG_FORMAT_FLAG_ALPHA
#define PNG_FORMAT_AG (PNG_FORMAT_GA or PNG_FORMAT_FLAG_AFIRST)
#define PNG_FORMAT_RGB PNG_FORMAT_FLAG_COLOR
#define PNG_FORMAT_BGR (PNG_FORMAT_FLAG_COLOR or PNG_FORMAT_FLAG_BGR)
#define PNG_FORMAT_RGBA (PNG_FORMAT_RGB or PNG_FORMAT_FLAG_ALPHA)
#define PNG_FORMAT_ARGB (PNG_FORMAT_RGBA or PNG_FORMAT_FLAG_AFIRST)
#define PNG_FORMAT_BGRA (PNG_FORMAT_BGR or PNG_FORMAT_FLAG_ALPHA)
#define PNG_FORMAT_ABGR (PNG_FORMAT_BGRA or PNG_FORMAT_FLAG_AFIRST)
#define PNG_FORMAT_LINEAR_Y PNG_FORMAT_FLAG_LINEAR
#define PNG_FORMAT_LINEAR_Y_ALPHA (PNG_FORMAT_FLAG_LINEAR or PNG_FORMAT_FLAG_ALPHA)
#define PNG_FORMAT_LINEAR_RGB (PNG_FORMAT_FLAG_LINEAR or PNG_FORMAT_FLAG_COLOR)
#define PNG_FORMAT_LINEAR_RGB_ALPHA ((PNG_FORMAT_FLAG_LINEAR or PNG_FORMAT_FLAG_COLOR) or PNG_FORMAT_FLAG_ALPHA)
#define PNG_FORMAT_RGB_COLORMAP (PNG_FORMAT_RGB or PNG_FORMAT_FLAG_COLORMAP)
#define PNG_FORMAT_BGR_COLORMAP (PNG_FORMAT_BGR or PNG_FORMAT_FLAG_COLORMAP)
#define PNG_FORMAT_RGBA_COLORMAP (PNG_FORMAT_RGBA or PNG_FORMAT_FLAG_COLORMAP)
#define PNG_FORMAT_ARGB_COLORMAP (PNG_FORMAT_ARGB or PNG_FORMAT_FLAG_COLORMAP)
#define PNG_FORMAT_BGRA_COLORMAP (PNG_FORMAT_BGRA or PNG_FORMAT_FLAG_COLORMAP)
#define PNG_FORMAT_ABGR_COLORMAP (PNG_FORMAT_ABGR or PNG_FORMAT_FLAG_COLORMAP)
#define PNG_IMAGE_SAMPLE_CHANNELS(fmt) (((fmt) and (PNG_FORMAT_FLAG_COLOR or PNG_FORMAT_FLAG_ALPHA)) + 1)
#define PNG_IMAGE_SAMPLE_COMPONENT_SIZE(fmt) ((((fmt) and PNG_FORMAT_FLAG_LINEAR) shr 2) + 1)
#define PNG_IMAGE_SAMPLE_SIZE(fmt) (PNG_IMAGE_SAMPLE_CHANNELS(fmt) * PNG_IMAGE_SAMPLE_COMPONENT_SIZE(fmt))
#define PNG_IMAGE_MAXIMUM_COLORMAP_COMPONENTS(fmt) (PNG_IMAGE_SAMPLE_CHANNELS(fmt) * 256)
#define PNG_IMAGE_PIXEL_(test, fmt) iif((fmt) and PNG_FORMAT_FLAG_COLORMAP, 1, test(fmt))
#define PNG_IMAGE_PIXEL_CHANNELS(fmt) PNG_IMAGE_PIXEL_(PNG_IMAGE_SAMPLE_CHANNELS, fmt)
#define PNG_IMAGE_PIXEL_COMPONENT_SIZE(fmt) PNG_IMAGE_PIXEL_(PNG_IMAGE_SAMPLE_COMPONENT_SIZE, fmt)
#define PNG_IMAGE_PIXEL_SIZE(fmt) PNG_IMAGE_PIXEL_(PNG_IMAGE_SAMPLE_SIZE, fmt)
#define PNG_IMAGE_ROW_STRIDE(image) (PNG_IMAGE_PIXEL_CHANNELS((image).format) * (image).width)
#define PNG_IMAGE_BUFFER_SIZE(image, row_stride) ((PNG_IMAGE_PIXEL_COMPONENT_SIZE((image).format) * (image).height) * (row_stride))
#define PNG_IMAGE_SIZE(image) PNG_IMAGE_BUFFER_SIZE(image, PNG_IMAGE_ROW_STRIDE(image))
#define PNG_IMAGE_COLORMAP_SIZE(image) (PNG_IMAGE_SAMPLE_SIZE((image).format) * (image).colormap_entries)
#define PNG_IMAGE_FLAG_COLORSPACE_NOT_sRGB &h01
#define PNG_IMAGE_FLAG_FAST &h02
#define PNG_IMAGE_FLAG_16BIT_sRGB &h04

declare function png_image_begin_read_from_file(byval image as png_imagep, byval file_name as const zstring ptr) as long
declare function png_image_begin_read_from_stdio(byval image as png_imagep, byval file as FILE ptr) as long
declare function png_image_begin_read_from_memory(byval image as png_imagep, byval memory as png_const_voidp, byval size as png_size_t) as long
declare function png_image_finish_read(byval image as png_imagep, byval background as png_const_colorp, byval buffer as any ptr, byval row_stride as png_int_32, byval colormap as any ptr) as long
declare sub png_image_free(byval image as png_imagep)
declare function png_image_write_to_file(byval image as png_imagep, byval file as const zstring ptr, byval convert_to_8bit as long, byval buffer as const any ptr, byval row_stride as png_int_32, byval colormap as const any ptr) as long
declare function png_image_write_to_stdio(byval image as png_imagep, byval file as FILE ptr, byval convert_to_8_bit as long, byval buffer as const any ptr, byval row_stride as png_int_32, byval colormap as const any ptr) as long
declare sub png_set_check_for_invalid_index(byval png_ptr as png_structrp, byval allowed as long)
declare function png_get_palette_max(byval png_ptr as png_const_structp, byval info_ptr as png_const_infop) as long

#define PNG_MAXIMUM_INFLATE_WINDOW 2
#define PNG_SKIP_sRGB_CHECK_PROFILE 4
#define PNG_OPTION_NEXT 6
#define PNG_OPTION_UNSET 0
#define PNG_OPTION_INVALID 1
#define PNG_OPTION_OFF 2
#define PNG_OPTION_ON 3

declare function png_set_option(byval png_ptr as png_structrp, byval option_ as long, byval onoff as long) as long

end extern
