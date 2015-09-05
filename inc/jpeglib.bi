'' FreeBASIC binding for jpeglib 6b, 7, 8, 9a
''
'' based on the C header files:
''   In plain English:
''
''   1. We don't promise that this software works.  (But if you find any bugs,
''      please let us know!)
''   2. You can use this software for whatever you want.  You don't have to pay us.
''   3. You may not pretend that you wrote this software.  If you use it in a
''      program, you must acknowledge somewhere in your documentation that
''      you've used the IJG code.
''
''   In legalese:
''
''   The authors make NO WARRANTY or representation, either express or implied,
''   with respect to this software, its quality, accuracy, merchantability, or
''   fitness for a particular purpose.  This software is provided "AS IS", and you,
''   its user, assume the entire risk as to its quality and accuracy.
''
''   This software is copyright (C) 1991-2014, Thomas G. Lane, Guido Vollbeding.
''   All Rights Reserved except as specified below.
''
''   Permission is hereby granted to use, copy, modify, and distribute this
''   software (or portions thereof) for any purpose, without fee, subject to these
''   conditions:
''   (1) If any part of the source code for this software is distributed, then this
''   README file must be included, with this copyright and no-warranty notice
''   unaltered; and any additions, deletions, or changes to the original files
''   must be clearly indicated in accompanying documentation.
''   (2) If only executable code is distributed, then the accompanying
''   documentation must state that "this software is based in part on the work of
''   the Independent JPEG Group".
''   (3) Permission for use of this software is granted only if the user accepts
''   full responsibility for any undesirable consequences; the authors accept
''   NO LIABILITY for damages of any kind.
''
''   These conditions apply to any software derived from or based on the IJG code,
''   not just to the unmodified library.  If you use our work, you ought to
''   acknowledge us.
''
''   Permission is NOT granted for the use of any IJG author's name or company name
''   in advertising or publicity relating to this software or products derived from
''   it.  This software may be referred to only as "the Independent JPEG Group's
''   software".
''
''   We specifically permit and encourage the use of this software as the basis of
''   commercial products, provided that all warranty or liability claims are
''   assumed by the product vendor.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

'' By default, the jpeglib 9 API is used, but __JPEGLIB_VER__ can be #defined to 6,
'' 7, 8 or 9 to select a specific version, should that be necessary to match the
'' version of the libjpeg binary. Background: Due to changes to fields of the
'' jpeg_compress_struct and jpeg_decompress_struct structures, the different
'' jpeglib versions are ABI incompatible.

'' Default to jpeglib 9
#ifndef __JPEGLIB_VER__
#define __JPEGLIB_VER__ 9
#endif

#inclib "jpeg"

#include once "crt/long.bi"
#include once "crt/stdio.bi"

'' The following symbols have been renamed:
''     typedef boolean => jpeg_boolean
''     constant TRUE => CTRUE

extern "C"

#define JPEGLIB_H
const BITS_IN_JSAMPLE = 8
const MAX_COMPONENTS = 10
type JSAMPLE as ubyte
#define GETJSAMPLE(value) clng(value)
const MAXJSAMPLE = 255
const CENTERJSAMPLE = 128
type JCOEF as short
type JOCTET as ubyte
#define GETJOCTET(value) (value)

type UINT8 as ubyte
type UINT16 as ushort
type INT16 as short
type INT32 as clong
type JDIMENSION as ulong
const JPEG_MAX_DIMENSION = cast(clong, 65500)

#if defined(__FB_WIN32__) and (__JPEGLIB_VER__ >= 8)
	type jpeg_boolean as ubyte
#else
	type jpeg_boolean as long
#endif

#ifndef CTRUE
	const CTRUE = 1
#endif
#ifndef TRUE
	const TRUE = 1
#endif
#ifndef FALSE
	const FALSE = 0
#endif

#if __JPEGLIB_VER__ = 6
	const JPEG_LIB_VERSION = 62
#elseif __JPEGLIB_VER__ = 7
	const JPEG_LIB_VERSION = 70
#elseif __JPEGLIB_VER__ = 8
	const JPEG_LIB_VERSION = 80
	const JPEG_LIB_VERSION_MAJOR = 8
	const JPEG_LIB_VERSION_MINOR = 4
#elseif __JPEGLIB_VER__ = 9
	const JPEG_LIB_VERSION = 90
	const JPEG_LIB_VERSION_MAJOR = 9
	const JPEG_LIB_VERSION_MINOR = 1
#else
	#error "unsupported __JPEGLIB_VER__ value (it may be one of 6,7,8,9)"
#endif

const DCTSIZE = 8
const DCTSIZE2 = 64
const NUM_QUANT_TBLS = 4
const NUM_HUFF_TBLS = 4
const NUM_ARITH_TBLS = 16
const MAX_COMPS_IN_SCAN = 4
const MAX_SAMP_FACTOR = 4
const C_MAX_BLOCKS_IN_MCU = 10
const D_MAX_BLOCKS_IN_MCU = 10

type JSAMPROW as JSAMPLE ptr
type JSAMPARRAY as JSAMPROW ptr
type JSAMPIMAGE as JSAMPARRAY ptr
type JBLOCKROW as JCOEF ptr
type JBLOCKARRAY as JBLOCKROW ptr
type JBLOCKIMAGE as JBLOCKARRAY ptr
type JCOEFPTR as JCOEF ptr

type JQUANT_TBL
	quantval(0 to 63) as UINT16
	sent_table as jpeg_boolean
end type

type JHUFF_TBL
	bits(0 to 16) as UINT8
	huffval(0 to 255) as UINT8
	sent_table as jpeg_boolean
end type

type jpeg_component_info
	component_id as long
	component_index as long
	h_samp_factor as long
	v_samp_factor as long
	quant_tbl_no as long
	dc_tbl_no as long
	ac_tbl_no as long
	width_in_blocks as JDIMENSION
	height_in_blocks as JDIMENSION

	#if __JPEGLIB_VER__ = 6
		DCT_scaled_size as long
	#else
		DCT_h_scaled_size as long
		DCT_v_scaled_size as long
	#endif

	downsampled_width as JDIMENSION
	downsampled_height as JDIMENSION
	component_needed as jpeg_boolean
	MCU_width as long
	MCU_height as long
	MCU_blocks as long
	MCU_sample_width as long
	last_col_width as long
	last_row_height as long
	quant_table as JQUANT_TBL ptr
	dct_table as any ptr
end type

type jpeg_scan_info
	comps_in_scan as long
	component_index(0 to 3) as long
	Ss as long
	Se as long
	Ah as long
	Al as long
end type

type jpeg_saved_marker_ptr as jpeg_marker_struct ptr

type jpeg_marker_struct
	next as jpeg_saved_marker_ptr
	marker as UINT8
	original_length as ulong
	data_length as ulong
	data as JOCTET ptr
end type

type J_COLOR_SPACE as long
enum
	JCS_UNKNOWN
	JCS_GRAYSCALE
	JCS_RGB
	JCS_YCbCr
	JCS_CMYK
	JCS_YCCK

	#if __JPEGLIB_VER__ = 9
		JCS_BG_RGB
		JCS_BG_YCC
	#endif
end enum

#if __JPEGLIB_VER__ = 9
	type J_COLOR_TRANSFORM as long
	enum
		JCT_NONE = 0
		JCT_SUBTRACT_GREEN = 1
	end enum
#endif

type J_DCT_METHOD as long
enum
	JDCT_ISLOW
	JDCT_IFAST
	JDCT_FLOAT
end enum

const JDCT_DEFAULT = JDCT_ISLOW
const JDCT_FASTEST = JDCT_IFAST

type J_DITHER_MODE as long
enum
	JDITHER_NONE
	JDITHER_ORDERED
	JDITHER_FS
end enum

type jpeg_error_mgr as jpeg_error_mgr_
type jpeg_memory_mgr as jpeg_memory_mgr_
type jpeg_progress_mgr as jpeg_progress_mgr_

type jpeg_common_struct
	err as jpeg_error_mgr ptr
	mem as jpeg_memory_mgr ptr
	progress as jpeg_progress_mgr ptr
	client_data as any ptr
	is_decompressor as jpeg_boolean
	global_state as long
end type

type j_common_ptr as jpeg_common_struct ptr
type j_compress_ptr as jpeg_compress_struct ptr
type j_decompress_ptr as jpeg_decompress_struct ptr
type jpeg_destination_mgr as jpeg_destination_mgr_
type jpeg_comp_master as jpeg_comp_master_
type jpeg_c_main_controller as jpeg_c_main_controller_
type jpeg_c_prep_controller as jpeg_c_prep_controller_
type jpeg_c_coef_controller as jpeg_c_coef_controller_
type jpeg_marker_writer as jpeg_marker_writer_
type jpeg_color_converter as jpeg_color_converter_
type jpeg_downsampler as jpeg_downsampler_
type jpeg_forward_dct as jpeg_forward_dct_
type jpeg_entropy_encoder as jpeg_entropy_encoder_

type jpeg_compress_struct
	err as jpeg_error_mgr ptr
	mem as jpeg_memory_mgr ptr
	progress as jpeg_progress_mgr ptr
	client_data as any ptr
	is_decompressor as jpeg_boolean
	global_state as long
	dest as jpeg_destination_mgr ptr
	image_width as JDIMENSION
	image_height as JDIMENSION
	input_components as long
	in_color_space as J_COLOR_SPACE
	input_gamma as double

	#if __JPEGLIB_VER__ >= 7
		scale_num as ulong
		scale_denom as ulong
		jpeg_width as JDIMENSION
		jpeg_height as JDIMENSION
	#endif

	data_precision as long
	num_components as long
	jpeg_color_space as J_COLOR_SPACE
	comp_info as jpeg_component_info ptr
	quant_tbl_ptrs(0 to 3) as JQUANT_TBL ptr

	#if __JPEGLIB_VER__ >= 7
		q_scale_factor(0 to 3) as long
	#endif

	dc_huff_tbl_ptrs(0 to 3) as JHUFF_TBL ptr
	ac_huff_tbl_ptrs(0 to 3) as JHUFF_TBL ptr
	arith_dc_L(0 to 15) as UINT8
	arith_dc_U(0 to 15) as UINT8
	arith_ac_K(0 to 15) as UINT8
	num_scans as long
	scan_info as const jpeg_scan_info ptr
	raw_data_in as jpeg_boolean
	arith_code as jpeg_boolean
	optimize_coding as jpeg_boolean
	CCIR601_sampling as jpeg_boolean

	#if __JPEGLIB_VER__ >= 7
		do_fancy_downsampling as jpeg_boolean
	#endif

	smoothing_factor as long
	dct_method as J_DCT_METHOD
	restart_interval as ulong
	restart_in_rows as long
	write_JFIF_header as jpeg_boolean
	JFIF_major_version as UINT8
	JFIF_minor_version as UINT8
	density_unit as UINT8
	X_density as UINT16
	Y_density as UINT16
	write_Adobe_marker as jpeg_boolean

	#if __JPEGLIB_VER__ = 9
		color_transform as J_COLOR_TRANSFORM
	#endif

	next_scanline as JDIMENSION
	progressive_mode as jpeg_boolean
	max_h_samp_factor as long
	max_v_samp_factor as long

	#if __JPEGLIB_VER__ >= 7
		min_DCT_h_scaled_size as long
		min_DCT_v_scaled_size as long
	#endif

	total_iMCU_rows as JDIMENSION
	comps_in_scan as long
	cur_comp_info(0 to 3) as jpeg_component_info ptr
	MCUs_per_row as JDIMENSION
	MCU_rows_in_scan as JDIMENSION
	blocks_in_MCU as long
	MCU_membership(0 to 9) as long
	Ss as long
	Se as long
	Ah as long
	Al as long

	#if __JPEGLIB_VER__ >= 8
		block_size as long
		natural_order as const long ptr
		lim_Se as long
	#endif

	master as jpeg_comp_master ptr
	main as jpeg_c_main_controller ptr
	prep as jpeg_c_prep_controller ptr
	coef as jpeg_c_coef_controller ptr
	marker as jpeg_marker_writer ptr
	cconvert as jpeg_color_converter ptr
	downsample as jpeg_downsampler ptr
	fdct as jpeg_forward_dct ptr
	entropy as jpeg_entropy_encoder ptr
	script_space as jpeg_scan_info ptr
	script_space_size as long
end type

type jpeg_source_mgr as jpeg_source_mgr_
type jpeg_decomp_master as jpeg_decomp_master_
type jpeg_d_main_controller as jpeg_d_main_controller_
type jpeg_d_coef_controller as jpeg_d_coef_controller_
type jpeg_d_post_controller as jpeg_d_post_controller_
type jpeg_input_controller as jpeg_input_controller_
type jpeg_marker_reader as jpeg_marker_reader_
type jpeg_entropy_decoder as jpeg_entropy_decoder_
type jpeg_inverse_dct as jpeg_inverse_dct_
type jpeg_upsampler as jpeg_upsampler_
type jpeg_color_deconverter as jpeg_color_deconverter_
type jpeg_color_quantizer as jpeg_color_quantizer_

type jpeg_decompress_struct
	err as jpeg_error_mgr ptr
	mem as jpeg_memory_mgr ptr
	progress as jpeg_progress_mgr ptr
	client_data as any ptr
	is_decompressor as jpeg_boolean
	global_state as long
	src as jpeg_source_mgr ptr
	image_width as JDIMENSION
	image_height as JDIMENSION
	num_components as long
	jpeg_color_space as J_COLOR_SPACE
	out_color_space as J_COLOR_SPACE
	scale_num as ulong
	scale_denom as ulong
	output_gamma as double
	buffered_image as jpeg_boolean
	raw_data_out as jpeg_boolean
	dct_method as J_DCT_METHOD
	do_fancy_upsampling as jpeg_boolean
	do_block_smoothing as jpeg_boolean
	quantize_colors as jpeg_boolean
	dither_mode as J_DITHER_MODE
	two_pass_quantize as jpeg_boolean
	desired_number_of_colors as long
	enable_1pass_quant as jpeg_boolean
	enable_external_quant as jpeg_boolean
	enable_2pass_quant as jpeg_boolean
	output_width as JDIMENSION
	output_height as JDIMENSION
	out_color_components as long
	output_components as long
	rec_outbuf_height as long
	actual_number_of_colors as long
	colormap as JSAMPARRAY
	output_scanline as JDIMENSION
	input_scan_number as long
	input_iMCU_row as JDIMENSION
	output_scan_number as long
	output_iMCU_row as JDIMENSION
	coef_bits as long ptr
	quant_tbl_ptrs(0 to 3) as JQUANT_TBL ptr
	dc_huff_tbl_ptrs(0 to 3) as JHUFF_TBL ptr
	ac_huff_tbl_ptrs(0 to 3) as JHUFF_TBL ptr
	data_precision as long
	comp_info as jpeg_component_info ptr

	#if __JPEGLIB_VER__ >= 8
		is_baseline as jpeg_boolean
	#endif

	progressive_mode as jpeg_boolean
	arith_code as jpeg_boolean
	arith_dc_L(0 to 15) as UINT8
	arith_dc_U(0 to 15) as UINT8
	arith_ac_K(0 to 15) as UINT8
	restart_interval as ulong
	saw_JFIF_marker as jpeg_boolean
	JFIF_major_version as UINT8
	JFIF_minor_version as UINT8
	density_unit as UINT8
	X_density as UINT16
	Y_density as UINT16
	saw_Adobe_marker as jpeg_boolean
	Adobe_transform as UINT8

	#if __JPEGLIB_VER__ = 9
		color_transform as J_COLOR_TRANSFORM
	#endif

	CCIR601_sampling as jpeg_boolean
	marker_list as jpeg_saved_marker_ptr
	max_h_samp_factor as long
	max_v_samp_factor as long

	#if __JPEGLIB_VER__ = 6
		min_DCT_scaled_size as long
	#else
		min_DCT_h_scaled_size as long
		min_DCT_v_scaled_size as long
	#endif

	total_iMCU_rows as JDIMENSION
	sample_range_limit as JSAMPLE ptr
	comps_in_scan as long
	cur_comp_info(0 to 3) as jpeg_component_info ptr
	MCUs_per_row as JDIMENSION
	MCU_rows_in_scan as JDIMENSION
	blocks_in_MCU as long
	MCU_membership(0 to 9) as long
	Ss as long
	Se as long
	Ah as long
	Al as long

	#if __JPEGLIB_VER__ >= 8
		block_size as long
		natural_order as const long ptr
		lim_Se as long
	#endif

	unread_marker as long
	master as jpeg_decomp_master ptr
	main as jpeg_d_main_controller ptr
	coef as jpeg_d_coef_controller ptr
	post as jpeg_d_post_controller ptr
	inputctl as jpeg_input_controller ptr
	marker as jpeg_marker_reader ptr
	entropy as jpeg_entropy_decoder ptr
	idct as jpeg_inverse_dct ptr
	upsample as jpeg_upsampler ptr
	cconvert as jpeg_color_deconverter ptr
	cquantize as jpeg_color_quantizer ptr
end type

union jpeg_error_mgr_msg_parm
	i(0 to 7) as long
	s as zstring * 80
end union

type jpeg_error_mgr_
	error_exit as sub(byval cinfo as j_common_ptr)
	emit_message as sub(byval cinfo as j_common_ptr, byval msg_level as long)
	output_message as sub(byval cinfo as j_common_ptr)
	format_message as sub(byval cinfo as j_common_ptr, byval buffer as zstring ptr)
	reset_error_mgr as sub(byval cinfo as j_common_ptr)
	msg_code as long
	msg_parm as jpeg_error_mgr_msg_parm
	trace_level as long
	num_warnings as clong
	jpeg_message_table as const zstring const ptr ptr
	last_jpeg_message as long
	addon_message_table as const zstring const ptr ptr
	first_addon_message as long
	last_addon_message as long
end type

const JMSG_LENGTH_MAX = 200
const JMSG_STR_PARM_MAX = 80

type jpeg_progress_mgr_
	progress_monitor as sub(byval cinfo as j_common_ptr)
	pass_counter as clong
	pass_limit as clong
	completed_passes as long
	total_passes as long
end type

type jpeg_destination_mgr_
	next_output_byte as JOCTET ptr
	free_in_buffer as uinteger
	init_destination as sub(byval cinfo as j_compress_ptr)
	empty_output_buffer as function(byval cinfo as j_compress_ptr) as jpeg_boolean
	term_destination as sub(byval cinfo as j_compress_ptr)
end type

type jpeg_source_mgr_
	next_input_byte as const JOCTET ptr
	bytes_in_buffer as uinteger
	init_source as sub(byval cinfo as j_decompress_ptr)
	fill_input_buffer as function(byval cinfo as j_decompress_ptr) as jpeg_boolean
	skip_input_data as sub(byval cinfo as j_decompress_ptr, byval num_bytes as clong)
	resync_to_restart as function(byval cinfo as j_decompress_ptr, byval desired as long) as jpeg_boolean
	term_source as sub(byval cinfo as j_decompress_ptr)
end type

const JPOOL_PERMANENT = 0
const JPOOL_IMAGE = 1
const JPOOL_NUMPOOLS = 2
type jvirt_sarray_ptr as jvirt_sarray_control ptr
type jvirt_barray_ptr as jvirt_barray_control ptr

type jpeg_memory_mgr_
	alloc_small as function(byval cinfo as j_common_ptr, byval pool_id as long, byval sizeofobject as uinteger) as any ptr
	alloc_large as function(byval cinfo as j_common_ptr, byval pool_id as long, byval sizeofobject as uinteger) as any ptr
	alloc_sarray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval samplesperrow as JDIMENSION, byval numrows as JDIMENSION) as JSAMPARRAY
	alloc_barray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval blocksperrow as JDIMENSION, byval numrows as JDIMENSION) as JBLOCKARRAY
	request_virt_sarray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval pre_zero as jpeg_boolean, byval samplesperrow as JDIMENSION, byval numrows as JDIMENSION, byval maxaccess as JDIMENSION) as jvirt_sarray_ptr
	request_virt_barray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval pre_zero as jpeg_boolean, byval blocksperrow as JDIMENSION, byval numrows as JDIMENSION, byval maxaccess as JDIMENSION) as jvirt_barray_ptr
	realize_virt_arrays as sub(byval cinfo as j_common_ptr)
	access_virt_sarray as function(byval cinfo as j_common_ptr, byval ptr as jvirt_sarray_ptr, byval start_row as JDIMENSION, byval num_rows as JDIMENSION, byval writable as jpeg_boolean) as JSAMPARRAY
	access_virt_barray as function(byval cinfo as j_common_ptr, byval ptr as jvirt_barray_ptr, byval start_row as JDIMENSION, byval num_rows as JDIMENSION, byval writable as jpeg_boolean) as JBLOCKARRAY
	free_pool as sub(byval cinfo as j_common_ptr, byval pool_id as long)
	self_destruct as sub(byval cinfo as j_common_ptr)
	max_memory_to_use as clong
	max_alloc_chunk as clong
end type

type jpeg_marker_parser_method as function(byval cinfo as j_decompress_ptr) as jpeg_boolean
declare function jpeg_std_error(byval err as jpeg_error_mgr ptr) as jpeg_error_mgr ptr
#define jpeg_create_compress(cinfo) jpeg_CreateCompress((cinfo), JPEG_LIB_VERSION, cuint(sizeof(jpeg_compress_struct)))
#define jpeg_create_decompress(cinfo) jpeg_CreateDecompress((cinfo), JPEG_LIB_VERSION, cuint(sizeof(jpeg_decompress_struct)))
declare sub jpeg_CreateCompress(byval cinfo as j_compress_ptr, byval version as long, byval structsize as uinteger)
declare sub jpeg_CreateDecompress(byval cinfo as j_decompress_ptr, byval version as long, byval structsize as uinteger)
declare sub jpeg_destroy_compress(byval cinfo as j_compress_ptr)
declare sub jpeg_destroy_decompress(byval cinfo as j_decompress_ptr)
declare sub jpeg_stdio_dest(byval cinfo as j_compress_ptr, byval outfile as FILE ptr)
declare sub jpeg_stdio_src(byval cinfo as j_decompress_ptr, byval infile as FILE ptr)

#if __JPEGLIB_VER__ >= 8
	declare sub jpeg_mem_dest(byval cinfo as j_compress_ptr, byval outbuffer as ubyte ptr ptr, byval outsize as culong ptr)
	declare sub jpeg_mem_src(byval cinfo as j_decompress_ptr, byval inbuffer as ubyte ptr, byval insize as culong)
#endif

declare sub jpeg_set_defaults(byval cinfo as j_compress_ptr)
declare sub jpeg_set_colorspace(byval cinfo as j_compress_ptr, byval colorspace as J_COLOR_SPACE)
declare sub jpeg_default_colorspace(byval cinfo as j_compress_ptr)
declare sub jpeg_set_quality(byval cinfo as j_compress_ptr, byval quality as long, byval force_baseline as jpeg_boolean)
declare sub jpeg_set_linear_quality(byval cinfo as j_compress_ptr, byval scale_factor as long, byval force_baseline as jpeg_boolean)

#if __JPEGLIB_VER__ >= 7
	declare sub jpeg_default_qtables(byval cinfo as j_compress_ptr, byval force_baseline as jpeg_boolean)
#endif

declare sub jpeg_add_quant_table(byval cinfo as j_compress_ptr, byval which_tbl as long, byval basic_table as const ulong ptr, byval scale_factor as long, byval force_baseline as jpeg_boolean)
declare function jpeg_quality_scaling(byval quality as long) as long
declare sub jpeg_simple_progression(byval cinfo as j_compress_ptr)
declare sub jpeg_suppress_tables(byval cinfo as j_compress_ptr, byval suppress as jpeg_boolean)
declare function jpeg_alloc_quant_table(byval cinfo as j_common_ptr) as JQUANT_TBL ptr
declare function jpeg_alloc_huff_table(byval cinfo as j_common_ptr) as JHUFF_TBL ptr
declare sub jpeg_start_compress(byval cinfo as j_compress_ptr, byval write_all_tables as jpeg_boolean)
declare function jpeg_write_scanlines(byval cinfo as j_compress_ptr, byval scanlines as JSAMPARRAY, byval num_lines as JDIMENSION) as JDIMENSION
declare sub jpeg_finish_compress(byval cinfo as j_compress_ptr)

#if __JPEGLIB_VER__ >= 7
	declare sub jpeg_calc_jpeg_dimensions(byval cinfo as j_compress_ptr)
#endif

declare function jpeg_write_raw_data(byval cinfo as j_compress_ptr, byval data as JSAMPIMAGE, byval num_lines as JDIMENSION) as JDIMENSION
declare sub jpeg_write_marker(byval cinfo as j_compress_ptr, byval marker as long, byval dataptr as const JOCTET ptr, byval datalen as ulong)
declare sub jpeg_write_m_header(byval cinfo as j_compress_ptr, byval marker as long, byval datalen as ulong)
declare sub jpeg_write_m_byte(byval cinfo as j_compress_ptr, byval val as long)
declare sub jpeg_write_tables(byval cinfo as j_compress_ptr)
declare function jpeg_read_header(byval cinfo as j_decompress_ptr, byval require_image as jpeg_boolean) as long

const JPEG_SUSPENDED = 0
const JPEG_HEADER_OK = 1
const JPEG_HEADER_TABLES_ONLY = 2

declare function jpeg_start_decompress(byval cinfo as j_decompress_ptr) as jpeg_boolean
declare function jpeg_read_scanlines(byval cinfo as j_decompress_ptr, byval scanlines as JSAMPARRAY, byval max_lines as JDIMENSION) as JDIMENSION
declare function jpeg_finish_decompress(byval cinfo as j_decompress_ptr) as jpeg_boolean
declare function jpeg_read_raw_data(byval cinfo as j_decompress_ptr, byval data as JSAMPIMAGE, byval max_lines as JDIMENSION) as JDIMENSION
declare function jpeg_has_multiple_scans(byval cinfo as j_decompress_ptr) as jpeg_boolean
declare function jpeg_start_output(byval cinfo as j_decompress_ptr, byval scan_number as long) as jpeg_boolean
declare function jpeg_finish_output(byval cinfo as j_decompress_ptr) as jpeg_boolean
declare function jpeg_input_complete(byval cinfo as j_decompress_ptr) as jpeg_boolean
declare sub jpeg_new_colormap(byval cinfo as j_decompress_ptr)
declare function jpeg_consume_input(byval cinfo as j_decompress_ptr) as long

const JPEG_REACHED_SOS = 1
const JPEG_REACHED_EOI = 2
const JPEG_ROW_COMPLETED = 3
const JPEG_SCAN_COMPLETED = 4

#if __JPEGLIB_VER__ >= 8
	declare sub jpeg_core_output_dimensions(byval cinfo as j_decompress_ptr)
#endif

declare sub jpeg_calc_output_dimensions(byval cinfo as j_decompress_ptr)
declare sub jpeg_save_markers(byval cinfo as j_decompress_ptr, byval marker_code as long, byval length_limit as ulong)
declare sub jpeg_set_marker_processor(byval cinfo as j_decompress_ptr, byval marker_code as long, byval routine as jpeg_marker_parser_method)
declare function jpeg_read_coefficients(byval cinfo as j_decompress_ptr) as jvirt_barray_ptr ptr
declare sub jpeg_write_coefficients(byval cinfo as j_compress_ptr, byval coef_arrays as jvirt_barray_ptr ptr)
declare sub jpeg_copy_critical_parameters(byval srcinfo as j_decompress_ptr, byval dstinfo as j_compress_ptr)
declare sub jpeg_abort_compress(byval cinfo as j_compress_ptr)
declare sub jpeg_abort_decompress(byval cinfo as j_decompress_ptr)
declare sub jpeg_abort(byval cinfo as j_common_ptr)
declare sub jpeg_destroy(byval cinfo as j_common_ptr)
declare function jpeg_resync_to_restart(byval cinfo as j_decompress_ptr, byval desired as long) as jpeg_boolean

const JPEG_RST0 = &hD0
const JPEG_EOI = &hD9
const JPEG_APP0 = &hE0
const JPEG_COM = &hFE

end extern
