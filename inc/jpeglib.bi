'' jpeglib 6b (6.2), 7.0, 8.4, 9
''
'' By default, the jpeglib 9 API is used, but __JPEGLIB_VER__ can be #defined to 6,
'' 7, 8 or 9 to select a specific version, should that be necessary to match the
'' version of the libjpeg binary. Background: Due to changes to fields of the
'' jpeg_compress_struct and jpeg_decompress_struct structures, the different
'' jpeglib versions are ABI incompatible.

'' Default to jpeglib 9
#ifndef __JPEGLIB_VER__
#define __JPEGLIB_VER__ 9
#endif

#pragma once
#inclib "jpeg"

#include once "crt/stdio.bi"

extern "C"

#define BITS_IN_JSAMPLE 8
#define MAX_COMPONENTS 10

type JSAMPLE as ubyte
#define GETJSAMPLE(value) clng(value)
#define MAXJSAMPLE 255
#define CENTERJSAMPLE 128

type JCOEF as short
type JOCTET as ubyte
#define GETJOCTET(value) (value)
type UINT8 as ubyte
type UINT16 as ushort
type INT16 as short
type INT32 as long
type JDIMENSION as ulong
#define JPEG_MAX_DIMENSION 65500L

#ifdef __FB_WIN32__
type boolean as ubyte
#else
type boolean as long
#endif

#if __JPEGLIB_VER__ = 6
	#define JPEG_LIB_VERSION 62
#elseif __JPEGLIB_VER__ = 7
	#define JPEG_LIB_VERSION  70
#elseif __JPEGLIB_VER__ = 8
	#define JPEG_LIB_VERSION 80
	#define JPEG_LIB_VERSION_MAJOR 8
	#define JPEG_LIB_VERSION_MINOR 4
#elseif __JPEGLIB_VER__ = 9
	#define JPEG_LIB_VERSION 90
	#define JPEG_LIB_VERSION_MAJOR 9
	#define JPEG_LIB_VERSION_MINOR 0
#else
	#error "unsupported __JPEGLIB_VER__ value (it may be one of 6,7,8,9)"
#endif

#define DCTSIZE 8
#define DCTSIZE2 64
#define NUM_QUANT_TBLS 4
#define NUM_HUFF_TBLS 4
#define NUM_ARITH_TBLS 16
#define MAX_COMPS_IN_SCAN 4
#define MAX_SAMP_FACTOR 4
#define C_MAX_BLOCKS_IN_MCU 10
#define D_MAX_BLOCKS_IN_MCU 10

type JSAMPROW as JSAMPLE ptr
type JSAMPARRAY as JSAMPROW ptr
type JSAMPIMAGE as JSAMPARRAY ptr
type JBLOCK as JCOEF
type JBLOCKROW as JBLOCK ptr
type JBLOCKARRAY as JBLOCKROW ptr
type JBLOCKIMAGE as JBLOCKARRAY ptr
type JCOEFPTR as JCOEF ptr

type JQUANT_TBL
	quantval(0 to DCTSIZE2-1) as UINT16
	sent_table as boolean
end type

type JHUFF_TBL
	bits(0 to 16) as UINT8
	huffval(0 to 255) as UINT8
	sent_table as boolean
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
#if __JPEGLIB_VER__ <= 6
	DCT_scaled_size as long
#else
	DCT_h_scaled_size as long
	DCT_v_scaled_size as long
#endif
	downsampled_width as JDIMENSION
	downsampled_height as JDIMENSION
	component_needed as boolean
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
	component_index(0 to MAX_COMPS_IN_SCAN-1) as long
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

enum J_COLOR_SPACE
	JCS_UNKNOWN
	JCS_GRAYSCALE
	JCS_RGB
	JCS_YCbCr
	JCS_CMYK
	JCS_YCCK
end enum

#if __JPEGLIB_VER__ >= 9
enum J_COLOR_TRANSFORM
	JCT_NONE           = 0
	JCT_SUBTRACT_GREEN = 1
end enum
#endif

enum J_DCT_METHOD
	JDCT_ISLOW
	JDCT_IFAST
	JDCT_FLOAT
end enum

#ifndef JDCT_DEFAULT
#define JDCT_DEFAULT JDCT_ISLOW
#endif
#ifndef JDCT_FASTEST
#define JDCT_FASTEST JDCT_IFAST
#endif

enum J_DITHER_MODE
	JDITHER_NONE
	JDITHER_ORDERED
	JDITHER_FS
end enum

type jpeg_error_mgr as jpeg_error_mgr_
type jpeg_memory_mgr as jpeg_memory_mgr_
type jpeg_progress_mgr as jpeg_progress_mgr_
type jpeg_destination_mgr as jpeg_destination_mgr_
type jpeg_comp_master as any
type jpeg_c_main_controller as any
type jpeg_c_prep_controller as any
type jpeg_c_coef_controller as any
type jpeg_marker_writer as any
type jpeg_color_converter as any
type jpeg_downsampler as any
type jpeg_source_mgr as jpeg_source_mgr_
type jpeg_forward_dct as any
type jpeg_decomp_master as any
type jpeg_entropy_encoder as any
type jpeg_d_main_controller as any
type jpeg_d_coef_controller as any
type jpeg_d_post_controller as any
type jpeg_input_controller as any
type jpeg_marker_reader as any
type jpeg_entropy_decoder as any
type jpeg_inverse_dct as any
type jpeg_upsampler as any
type jpeg_color_deconverter as any
type jpeg_color_quantizer as any

type jpeg_common_struct
	err as jpeg_error_mgr ptr
	mem as jpeg_memory_mgr ptr
	progress as jpeg_progress_mgr ptr
	client_data as any ptr
	is_decompressor as boolean
	global_state as long
end type

type j_common_ptr as jpeg_common_struct ptr
type j_compress_ptr as jpeg_compress_struct ptr
type j_decompress_ptr as jpeg_decompress_struct ptr

type jpeg_compress_struct
	err as jpeg_error_mgr ptr
	mem as jpeg_memory_mgr ptr
	progress as jpeg_progress_mgr ptr
	client_data as any ptr
	is_decompressor as boolean
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
	quant_tbl_ptrs(0 to NUM_QUANT_TBLS-1) as JQUANT_TBL ptr
#if __JPEGLIB_VER__ >= 7
	q_scale_factor(0 to NUM_QUANT_TBLS-1) as long
#endif
	dc_huff_tbl_ptrs(0 to NUM_HUFF_TBLS-1) as JHUFF_TBL ptr
	ac_huff_tbl_ptrs(0 to NUM_HUFF_TBLS-1) as JHUFF_TBL ptr
	arith_dc_L(0 to NUM_ARITH_TBLS-1) as UINT8
	arith_dc_U(0 to NUM_ARITH_TBLS-1) as UINT8
	arith_ac_K(0 to NUM_ARITH_TBLS-1) as UINT8
	num_scans as long
	scan_info as const jpeg_scan_info ptr
	raw_data_in as boolean
	arith_code as boolean
	optimize_coding as boolean
	CCIR601_sampling as boolean
#if __JPEGLIB_VER__ >= 7
	do_fancy_downsampling as boolean
#endif
	smoothing_factor as long
	dct_method as J_DCT_METHOD
	restart_interval as ulong
	restart_in_rows as long
	write_JFIF_header as boolean
	JFIF_major_version as UINT8
	JFIF_minor_version as UINT8
	density_unit as UINT8
	X_density as UINT16
	Y_density as UINT16
	write_Adobe_marker as boolean
#if __JPEGLIB_VER__ >= 9
	color_transform as J_COLOR_TRANSFORM
#endif
	next_scanline as JDIMENSION
	progressive_mode as boolean
	max_h_samp_factor as long
	max_v_samp_factor as long
#if __JPEGLIB_VER__ >= 7
	min_DCT_h_scaled_size as long
	min_DCT_v_scaled_size as long
#endif
	total_iMCU_rows as JDIMENSION
	comps_in_scan as long
	cur_comp_info(0 to MAX_COMPS_IN_SCAN-1) as jpeg_component_info ptr
	MCUs_per_row as JDIMENSION
	MCU_rows_in_scan as JDIMENSION
	blocks_in_MCU as long
	MCU_membership(0 to C_MAX_BLOCKS_IN_MCU-1) as long
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

type jpeg_decompress_struct
	err as jpeg_error_mgr ptr
	mem as jpeg_memory_mgr ptr
	progress as jpeg_progress_mgr ptr
	client_data as any ptr
	is_decompressor as boolean
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
	buffered_image as boolean
	raw_data_out as boolean
	dct_method as J_DCT_METHOD
	do_fancy_upsampling as boolean
	do_block_smoothing as boolean
	quantize_colors as boolean
	dither_mode as J_DITHER_MODE
	two_pass_quantize as boolean
	desired_number_of_colors as long
	enable_1pass_quant as boolean
	enable_external_quant as boolean
	enable_2pass_quant as boolean
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
	quant_tbl_ptrs(0 to NUM_QUANT_TBLS-1) as JQUANT_TBL ptr
	dc_huff_tbl_ptrs(0 to NUM_HUFF_TBLS-1) as JHUFF_TBL ptr
	ac_huff_tbl_ptrs(0 to NUM_HUFF_TBLS-1) as JHUFF_TBL ptr
	data_precision as long
	comp_info as jpeg_component_info ptr
#if __JPEGLIB_VER__ >= 8
	is_baseline as boolean
#endif
	progressive_mode as boolean
	arith_code as boolean
	arith_dc_L(0 to NUM_ARITH_TBLS-1) as UINT8
	arith_dc_U(0 to NUM_ARITH_TBLS-1) as UINT8
	arith_ac_K(0 to NUM_ARITH_TBLS-1) as UINT8
	restart_interval as ulong
	saw_JFIF_marker as boolean
	JFIF_major_version as UINT8
	JFIF_minor_version as UINT8
	density_unit as UINT8
	X_density as UINT16
	Y_density as UINT16
	saw_Adobe_marker as boolean
	Adobe_transform as UINT8
#if __JPEGLIB_VER__ >= 9
	color_transform as J_COLOR_TRANSFORM
#endif
	CCIR601_sampling as boolean
	marker_list as jpeg_saved_marker_ptr
	max_h_samp_factor as long
	max_v_samp_factor as long
#if __JPEGLIB_VER__ <= 6
	min_DCT_scaled_size as long
#else
	min_DCT_h_scaled_size as long
	min_DCT_v_scaled_size as long
#endif
	total_iMCU_rows as JDIMENSION
	sample_range_limit as JSAMPLE ptr
	comps_in_scan as long
	cur_comp_info(0 to MAX_COMPS_IN_SCAN-1) as jpeg_component_info ptr
	MCUs_per_row as JDIMENSION
	MCU_rows_in_scan as JDIMENSION
	blocks_in_MCU as long
	MCU_membership(0 to D_MAX_BLOCKS_IN_MCU-1) as long
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

#define JMSG_LENGTH_MAX 200
#define JMSG_STR_PARM_MAX 80

union jpeg_error_mgr_msg_parm
	i(0 to 7) as long
	s as zstring * JMSG_STR_PARM_MAX
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
	num_warnings as long
	jpeg_message_table as const zstring const ptr ptr
	last_jpeg_message as long
	addon_message_table as const zstring const ptr ptr
	first_addon_message as long
	last_addon_message as long
end type

type jpeg_progress_mgr_
	progress_monitor as sub(byval cinfo as j_common_ptr)
	pass_counter as long
	pass_limit as long
	completed_passes as long
	total_passes as long
end type

type jpeg_destination_mgr_
	next_output_byte as JOCTET ptr
	free_in_buffer as integer
	init_destination as sub(byval cinfo as j_compress_ptr)
	empty_output_buffer as function(byval cinfo as j_compress_ptr) as boolean
	term_destination as sub(byval cinfo as j_compress_ptr)
end type

type jpeg_source_mgr_
	next_input_byte as const JOCTET ptr
	bytes_in_buffer as uinteger
	init_source as sub(byval cinfo as j_decompress_ptr)
	fill_input_buffer as function(byval cinfo as j_decompress_ptr) as boolean
	skip_input_data as sub(byval cinfo as j_decompress_ptr, byval num_bytes as long)
	resync_to_restart as function(byval cinfo as j_decompress_ptr, byval desired as long) as boolean
	term_source as sub(byval cinfo as j_decompress_ptr)
end type

#define JPOOL_PERMANENT 0
#define JPOOL_IMAGE 1
#define JPOOL_NUMPOOLS 2

type jvirt_sarray_ptr as jvirt_sarray_control ptr
type jvirt_barray_ptr as jvirt_barray_control ptr

type jpeg_memory_mgr_
	alloc_small as function(byval cinfo as j_common_ptr, byval pool_id as long, byval sizeofobject as uinteger) as any ptr
	alloc_large as function(byval cinfo as j_common_ptr, byval pool_id as long, byval sizeofobject as uinteger) as any ptr
	alloc_sarray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval samplesperrow as JDIMENSION, byval numrows as JDIMENSION) as JSAMPARRAY
	alloc_barray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval blocksperrow as JDIMENSION, byval numrows as JDIMENSION) as JBLOCKARRAY
	request_virt_sarray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval pre_zero as boolean, byval samplesperrow as JDIMENSION, byval numrows as JDIMENSION, byval maxaccess as JDIMENSION) as jvirt_sarray_ptr
	request_virt_barray as function(byval cinfo as j_common_ptr, byval pool_id as long, byval pre_zero as boolean, byval blocksperrow as JDIMENSION, byval numrows as JDIMENSION, byval maxaccess as JDIMENSION) as jvirt_barray_ptr
	realize_virt_arrays as sub(byval cinfo as j_common_ptr)
	access_virt_sarray as function(byval cinfo as j_common_ptr, byval ptr as jvirt_sarray_ptr, byval start_row as JDIMENSION, byval num_rows as JDIMENSION, byval writable as boolean) as JSAMPARRAY
	access_virt_barray as function(byval cinfo as j_common_ptr, byval ptr as jvirt_barray_ptr, byval start_row as JDIMENSION, byval num_rows as JDIMENSION, byval writable as boolean) as JBLOCKARRAY
	free_pool as sub(byval cinfo as j_common_ptr, byval pool_id as long)
	self_destruct as sub(byval cinfo as j_common_ptr)
	max_memory_to_use as long
	max_alloc_chunk as long
end type

type jpeg_marker_parser_method as function(byval cinfo as j_decompress_ptr) as boolean

declare function jpeg_std_error(byval err as jpeg_error_mgr ptr) as jpeg_error_mgr ptr

#define jpeg_create_compress(cinfo) jpeg_CreateCompress((cinfo), JPEG_LIB_VERSION, sizeof(jpeg_compress_struct))
#define jpeg_create_decompress(cinfo) jpeg_CreateDecompress((cinfo), JPEG_LIB_VERSION, sizeof(jpeg_decompress_struct))
declare sub jpeg_CreateCompress(byval cinfo as j_compress_ptr, byval version as long, byval structsize as uinteger)
declare sub jpeg_CreateDecompress(byval cinfo as j_decompress_ptr, byval version as long, byval structsize as uinteger)
declare sub jpeg_destroy_compress(byval cinfo as j_compress_ptr)
declare sub jpeg_destroy_decompress(byval cinfo as j_decompress_ptr)
declare sub jpeg_stdio_dest(byval cinfo as j_compress_ptr, byval outfile as FILE ptr)
declare sub jpeg_stdio_src(byval cinfo as j_decompress_ptr, byval infile as FILE ptr)
#if __JPEGLIB_VER__ >= 8
declare sub jpeg_mem_dest(byval cinfo as j_compress_ptr, byval outbuffer as ubyte ptr ptr, byval outsize as ulong ptr)
declare sub jpeg_mem_src(byval cinfo as j_decompress_ptr, byval inbuffer as ubyte ptr, byval insize as ulong)
#endif
declare sub jpeg_set_defaults(byval cinfo as j_compress_ptr)
declare sub jpeg_set_colorspace(byval cinfo as j_compress_ptr, byval colorspace as J_COLOR_SPACE)
declare sub jpeg_default_colorspace(byval cinfo as j_compress_ptr)
declare sub jpeg_set_quality(byval cinfo as j_compress_ptr, byval quality as long, byval force_baseline as boolean)
declare sub jpeg_set_linear_quality(byval cinfo as j_compress_ptr, byval scale_factor as long, byval force_baseline as boolean)
#if __JPEGLIB_VER__ >= 7
declare sub jpeg_default_qtables(byval cinfo as j_compress_ptr, byval force_baseline as boolean)
#endif
declare sub jpeg_add_quant_table(byval cinfo as j_compress_ptr, byval which_tbl as long, byval basic_table as const ulong ptr, byval scale_factor as long, byval force_baseline as boolean)
declare function jpeg_quality_scaling(byval quality as long) as long
declare sub jpeg_simple_progression(byval cinfo as j_compress_ptr)
declare sub jpeg_suppress_tables(byval cinfo as j_compress_ptr, byval suppress as boolean)
declare function jpeg_alloc_quant_table(byval cinfo as j_common_ptr) as JQUANT_TBL ptr
declare function jpeg_alloc_huff_table(byval cinfo as j_common_ptr) as JHUFF_TBL ptr
declare sub jpeg_start_compress(byval cinfo as j_compress_ptr, byval write_all_tables as boolean)
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
declare function jpeg_read_header(byval cinfo as j_decompress_ptr, byval require_image as boolean) as long

#define JPEG_SUSPENDED 0
#define JPEG_HEADER_OK 1
#define JPEG_HEADER_TABLES_ONLY 2

declare function jpeg_start_decompress(byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_read_scanlines(byval cinfo as j_decompress_ptr, byval scanlines as JSAMPARRAY, byval max_lines as JDIMENSION) as JDIMENSION
declare function jpeg_finish_decompress(byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_read_raw_data(byval cinfo as j_decompress_ptr, byval data as JSAMPIMAGE, byval max_lines as JDIMENSION) as JDIMENSION
declare function jpeg_has_multiple_scans(byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_start_output(byval cinfo as j_decompress_ptr, byval scan_number as long) as boolean
declare function jpeg_finish_output(byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_input_complete(byval cinfo as j_decompress_ptr) as boolean
declare sub jpeg_new_colormap(byval cinfo as j_decompress_ptr)
declare function jpeg_consume_input(byval cinfo as j_decompress_ptr) as long

#define JPEG_REACHED_SOS 1
#define JPEG_REACHED_EOI 2
#define JPEG_ROW_COMPLETED 3
#define JPEG_SCAN_COMPLETED 4

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
declare function jpeg_resync_to_restart(byval cinfo as j_decompress_ptr, byval desired as long) as boolean

#define JPEG_RST0 &hD0
#define JPEG_EOI &hD9
#define JPEG_APP0 &hE0
#define JPEG_COM &hFE

end extern
