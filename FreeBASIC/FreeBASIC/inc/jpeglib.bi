''
''
'' jpeglib -- JPEG Library - Copyright (C) 1991-1998, Thomas G. Lane.
''			  (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __jpeglib_bi__
#define __jpeglib_bi__

#inclib "jpeg"

#include once "crt/stdio.bi"

'' begin include from jmorecfg.bi
#define BITS_IN_JSAMPLE 8
#define MAX_COMPONENTS 10

type JSAMPLE as ubyte

#define MAXJSAMPLE 255
#define CENTERJSAMPLE 128

type JCOEF as short
type JOCTET as ubyte
type UINT8 as ubyte
type UINT16 as ushort
type INT16 as short
type JDIMENSION as uinteger

#ifdef __FB_WIN32__
type boolean as ubyte
#else
type boolean as integer
#endif

#define JPEG_MAX_DIMENSION 65500L
#define FALSE 0
#define TRUE 1
'' end include

#define JPEG_LIB_VERSION 62
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
type JBLOCK as JCOEF ptr
type JBLOCKROW as JBLOCK ptr
type JBLOCKARRAY as JBLOCKROW ptr
type JBLOCKIMAGE as JBLOCKARRAY ptr
type JCOEFPTR as JCOEF ptr

type JQUANT_TBL
	quantval(0 to 64-1) as UINT16
	sent_table as boolean
end type

type JHUFF_TBL
	bits(0 to 17-1) as UINT8
	huffval(0 to 256-1) as UINT8
	sent_table as boolean
end type

type jpeg_component_info
	component_id as integer
	component_index as integer
	h_samp_factor as integer
	v_samp_factor as integer
	quant_tbl_no as integer
	dc_tbl_no as integer
	ac_tbl_no as integer
	width_in_blocks as JDIMENSION
	height_in_blocks as JDIMENSION
	DCT_scaled_size as integer
	downsampled_width as JDIMENSION
	downsampled_height as JDIMENSION
	component_needed as boolean
	MCU_width as integer
	MCU_height as integer
	MCU_blocks as integer
	MCU_sample_width as integer
	last_col_width as integer
	last_row_height as integer
	quant_table as JQUANT_TBL ptr
	dct_table as any ptr
end type

type jpeg_scan_info
	comps_in_scan as integer
	component_index(0 to 4-1) as integer
	Ss as integer
	Se as integer
	Ah as integer
	Al as integer
end type

type jpeg_saved_marker_ptr as jpeg_marker_struct ptr

type jpeg_marker_struct
	next as jpeg_saved_marker_ptr
	marker as UINT8
	original_length as uinteger
	data_length as uinteger
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


enum J_DCT_METHOD
	JDCT_ISLOW
	JDCT_IFAST
	JDCT_FLOAT
end enum


enum J_DITHER_MODE
	JDITHER_NONE
	JDITHER_ORDERED
	JDITHER_FS
end enum

type jpeg_error_mgr_ as jpeg_error_mgr
type jpeg_memory_mgr_ as jpeg_memory_mgr
type jpeg_progress_mgr_ as jpeg_progress_mgr

type jpeg_common_struct
	err as jpeg_error_mgr_ ptr
	mem as jpeg_memory_mgr_ ptr
	progress as jpeg_progress_mgr_ ptr
	client_data as any ptr
	is_decompressor as boolean
	global_state as integer
end type

type j_common_ptr as jpeg_common_struct ptr
type j_compress_ptr as jpeg_compress_struct ptr
type j_decompress_ptr as jpeg_decompress_struct ptr

type jpeg_destination_mgr_ as jpeg_destination_mgr

type jpeg_comp_master as any
type jpeg_c_main_controller as any
type jpeg_c_prep_controller as any
type jpeg_c_coef_controller as any
type jpeg_marker_writer as any
type jpeg_color_converter as any
type jpeg_downsampler as any
type jpeg_forward_dct as any
type jpeg_entropy_encoder as any

type jpeg_compress_struct
	err as jpeg_error_mgr_ ptr
	mem as jpeg_memory_mgr_ ptr
	progress as jpeg_progress_mgr_ ptr
	client_data as any ptr
	is_decompressor as boolean
	global_state as integer
	dest as jpeg_destination_mgr_ ptr
	image_width as JDIMENSION
	image_height as JDIMENSION
	input_components as integer
	in_color_space as J_COLOR_SPACE
	input_gamma as double
	data_precision as integer
	num_components as integer
	jpeg_color_space as J_COLOR_SPACE
	comp_info as jpeg_component_info ptr
	quant_tbl_ptrs(0 to 4-1) as JQUANT_TBL ptr
	dc_huff_tbl_ptrs(0 to 4-1) as JHUFF_TBL ptr
	ac_huff_tbl_ptrs(0 to 4-1) as JHUFF_TBL ptr
	arith_dc_L(0 to 16-1) as UINT8
	arith_dc_U(0 to 16-1) as UINT8
	arith_ac_K(0 to 16-1) as UINT8
	num_scans as integer
	scan_info as jpeg_scan_info ptr
	raw_data_in as boolean
	arith_code as boolean
	optimize_coding as boolean
	CCIR601_sampling as boolean
	smoothing_factor as integer
	dct_method as J_DCT_METHOD
	restart_interval as uinteger
	restart_in_rows as integer
	write_JFIF_header as boolean
	JFIF_major_version as UINT8
	JFIF_minor_version as UINT8
	density_unit as UINT8
	X_density as UINT16
	Y_density as UINT16
	write_Adobe_marker as boolean
	next_scanline as JDIMENSION
	progressive_mode as boolean
	max_h_samp_factor as integer
	max_v_samp_factor as integer
	total_iMCU_rows as JDIMENSION
	comps_in_scan as integer
	cur_comp_info(0 to 4-1) as jpeg_component_info ptr
	MCUs_per_row as JDIMENSION
	MCU_rows_in_scan as JDIMENSION
	blocks_in_MCU as integer
	MCU_membership(0 to 10-1) as integer
	Ss as integer
	Se as integer
	Ah as integer
	Al as integer
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
	script_space_size as integer
end type

type jpeg_source_mgr_ as jpeg_source_mgr

type jpeg_decomp_master as any
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

type jpeg_decompress_struct
	err as jpeg_error_mgr_ ptr
	mem as jpeg_memory_mgr_ ptr
	progress as jpeg_progress_mgr_ ptr
	client_data as any ptr
	is_decompressor as boolean
	global_state as integer
	src as jpeg_source_mgr_ ptr
	image_width as JDIMENSION
	image_height as JDIMENSION
	num_components as integer
	jpeg_color_space as J_COLOR_SPACE
	out_color_space as J_COLOR_SPACE
	scale_num as uinteger
	scale_denom as uinteger
	output_gamma as double
	buffered_image as boolean
	raw_data_out as boolean
	dct_method as J_DCT_METHOD
	do_fancy_upsampling as boolean
	do_block_smoothing as boolean
	quantize_colors as boolean
	dither_mode as J_DITHER_MODE
	two_pass_quantize as boolean
	desired_number_of_colors as integer
	enable_1pass_quant as boolean
	enable_external_quant as boolean
	enable_2pass_quant as boolean
	output_width as JDIMENSION
	output_height as JDIMENSION
	out_color_components as integer
	output_components as integer
	rec_outbuf_height as integer
	actual_number_of_colors as integer
	colormap as JSAMPARRAY
	output_scanline as JDIMENSION
	input_scan_number as integer
	input_iMCU_row as JDIMENSION
	output_scan_number as integer
	output_iMCU_row as JDIMENSION
	coef_bits as integer ptr ptr
	quant_tbl_ptrs(0 to 4-1) as JQUANT_TBL ptr
	dc_huff_tbl_ptrs(0 to 4-1) as JHUFF_TBL ptr
	ac_huff_tbl_ptrs(0 to 4-1) as JHUFF_TBL ptr
	data_precision as integer
	comp_info as jpeg_component_info ptr
	progressive_mode as boolean
	arith_code as boolean
	arith_dc_L(0 to 16-1) as UINT8
	arith_dc_U(0 to 16-1) as UINT8
	arith_ac_K(0 to 16-1) as UINT8
	restart_interval as uinteger
	saw_JFIF_marker as boolean
	JFIF_major_version as UINT8
	JFIF_minor_version as UINT8
	density_unit as UINT8
	X_density as UINT16
	Y_density as UINT16
	saw_Adobe_marker as boolean
	Adobe_transform as UINT8
	CCIR601_sampling as boolean
	marker_list as jpeg_saved_marker_ptr
	max_h_samp_factor as integer
	max_v_samp_factor as integer
	min_DCT_scaled_size as integer
	total_iMCU_rows as JDIMENSION
	sample_range_limit as JSAMPLE ptr
	comps_in_scan as integer
	cur_comp_info(0 to 4-1) as jpeg_component_info ptr
	MCUs_per_row as JDIMENSION
	MCU_rows_in_scan as JDIMENSION
	blocks_in_MCU as integer
	MCU_membership(0 to 10-1) as integer
	Ss as integer
	Se as integer
	Ah as integer
	Al as integer
	unread_marker as integer
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
	i(0 to 8-1) as integer
	s as zstring * 80
end union

type jpeg_error_mgr
	error_exit as sub cdecl(byval as j_common_ptr)
	emit_message as sub cdecl(byval as j_common_ptr, byval as integer)
	output_message as sub cdecl(byval as j_common_ptr)
	format_message as sub cdecl(byval as j_common_ptr, byval as zstring ptr)
	JMSG_LENGTH_MAX as integer
	reset_error_mgr as sub cdecl(byval as j_common_ptr)
	msg_code as integer
	JMSG_STR_PARM_MAX as integer
	msg_parm as jpeg_error_mgr_msg_parm
	trace_level as integer
	num_warnings as integer
	jpeg_message_table as byte ptr ptr
	last_jpeg_message as integer
	addon_message_table as byte ptr ptr
	first_addon_message as integer
	last_addon_message as integer	
end type

#define JMSG_LENGTH_MAX 200
#define JMSG_STR_PARM_MAX 80

type jpeg_progress_mgr
	progress_monitor as sub cdecl(byval as j_common_ptr)
	pass_counter as integer
	pass_limit as integer
	completed_passes as integer
	total_passes as integer
end type

type jpeg_destination_mgr
	next_output_byte as JOCTET ptr
	free_in_buffer as integer
	init_destination as sub cdecl(byval as j_compress_ptr)
	empty_output_buffer as function cdecl(byval as j_compress_ptr) as boolean
	term_destination as sub cdecl(byval as j_compress_ptr)
end type

type jpeg_source_mgr
	next_input_byte as JOCTET ptr
	bytes_in_buffer as integer
	init_source as sub cdecl(byval as j_decompress_ptr)
	fill_input_buffer as function cdecl(byval as j_decompress_ptr) as boolean
	skip_input_data as sub cdecl(byval as j_decompress_ptr, byval as integer)
	resync_to_restart as function cdecl(byval as j_decompress_ptr, byval as integer) as boolean
	term_source as sub cdecl(byval as j_decompress_ptr)
end type

#define JPOOL_PERMANENT 0
#define JPOOL_IMAGE 1
#define JPOOL_NUMPOOLS 2

type jvirt_sarray_ptr as jvirt_sarray_control ptr
type jvirt_barray_ptr as jvirt_barray_control ptr

type jpeg_memory_mgr
	alloc_small as sub cdecl(byval as j_common_ptr, byval as integer, byval as integer)
	alloc_large as sub cdecl(byval as j_common_ptr, byval as integer, byval as integer)
	alloc_sarray as function cdecl(byval as j_common_ptr, byval as integer, byval as JDIMENSION, byval as JDIMENSION) as JSAMPARRAY
	alloc_barray as function cdecl(byval as j_common_ptr, byval as integer, byval as JDIMENSION, byval as JDIMENSION) as JBLOCKARRAY
	request_virt_sarray as function cdecl(byval as j_common_ptr, byval as integer, byval as boolean, byval as JDIMENSION, byval as JDIMENSION, byval as JDIMENSION) as jvirt_sarray_ptr
	request_virt_barray as function cdecl(byval as j_common_ptr, byval as integer, byval as boolean, byval as JDIMENSION, byval as JDIMENSION, byval as JDIMENSION) as jvirt_barray_ptr
	realize_virt_arrays as sub cdecl(byval as j_common_ptr)
	access_virt_sarray as function cdecl(byval as j_common_ptr, byval as jvirt_sarray_ptr, byval as JDIMENSION, byval as JDIMENSION, byval as boolean) as JSAMPARRAY
	access_virt_barray as function cdecl(byval as j_common_ptr, byval as jvirt_barray_ptr, byval as JDIMENSION, byval as JDIMENSION, byval as boolean) as JBLOCKARRAY
	free_pool as sub cdecl(byval as j_common_ptr, byval as integer)
	self_destruct as sub cdecl(byval as j_common_ptr)
	max_memory_to_use as integer
	max_alloc_chunk as integer
end type

type jpeg_marker_parser_method as function cdecl(byval as j_decompress_ptr) as boolean

#define jpeg_create_compress(cinfo) jpeg_CreateCompress( cinfo, JPEG_LIB_VERSION, len( jpeg_compress_struct ) )
#define jpeg_create_decompress(cinfo) jpeg_CreateDecompress( cinfo , JPEG_LIB_VERSION, len( jpeg_decompress_struct ) )

#define JPEG_SUSPENDED 0
#define JPEG_HEADER_OK 1
#define JPEG_HEADER_TABLES_ONLY 2

#define JPEG_REACHED_SOS 1
#define JPEG_REACHED_EOI 2
#define JPEG_ROW_COMPLETED 3
#define JPEG_SCAN_COMPLETED 4

#define JPEG_RST0 &hD0
#define JPEG_EOI &hD9
#define JPEG_APP0 &hE0
#define JPEG_COM &hFE

extern "c"
declare function jpeg_std_error (byval err as jpeg_error_mgr ptr) as jpeg_error_mgr ptr
declare sub jpeg_CreateCompress (byval cinfo as j_compress_ptr, byval version as integer, byval structsize as integer)
declare sub jpeg_CreateDecompress (byval cinfo as j_decompress_ptr, byval version as integer, byval structsize as integer)
declare sub jpeg_destroy_compress (byval cinfo as j_compress_ptr)
declare sub jpeg_destroy_decompress (byval cinfo as j_decompress_ptr)
declare sub jpeg_stdio_dest (byval cinfo as j_compress_ptr, byval outfile as FILE ptr)
declare sub jpeg_stdio_src (byval cinfo as j_decompress_ptr, byval infile as FILE ptr)
declare sub jpeg_set_defaults (byval cinfo as j_compress_ptr)
declare sub jpeg_set_colorspace (byval cinfo as j_compress_ptr, byval colorspace as J_COLOR_SPACE)
declare sub jpeg_default_colorspace (byval cinfo as j_compress_ptr)
declare sub jpeg_set_quality (byval cinfo as j_compress_ptr, byval quality as integer, byval force_baseline as boolean)
declare sub jpeg_set_linear_quality (byval cinfo as j_compress_ptr, byval scale_factor as integer, byval force_baseline as boolean)
declare sub jpeg_add_quant_table (byval cinfo as j_compress_ptr, byval which_tbl as integer, byval basic_table as uinteger ptr, byval scale_factor as integer, byval force_baseline as boolean)
declare function jpeg_quality_scaling (byval quality as integer) as integer
declare sub jpeg_simple_progression (byval cinfo as j_compress_ptr)
declare sub jpeg_suppress_tables (byval cinfo as j_compress_ptr, byval suppress as boolean)
declare function jpeg_alloc_quant_table (byval cinfo as j_common_ptr) as JQUANT_TBL ptr
declare function jpeg_alloc_huff_table (byval cinfo as j_common_ptr) as JHUFF_TBL ptr
declare sub jpeg_start_compress (byval cinfo as j_compress_ptr, byval write_all_tables as boolean)
declare function jpeg_write_scanlines (byval cinfo as j_compress_ptr, byval scanlines as JSAMPARRAY, byval num_lines as JDIMENSION) as JDIMENSION
declare sub jpeg_finish_compress (byval cinfo as j_compress_ptr)
declare function jpeg_write_raw_data (byval cinfo as j_compress_ptr, byval data as JSAMPIMAGE, byval num_lines as JDIMENSION) as JDIMENSION
declare sub jpeg_write_marker (byval cinfo as j_compress_ptr, byval marker as integer, byval dataptr as JOCTET ptr, byval datalen as uinteger)
declare sub jpeg_write_m_header (byval cinfo as j_compress_ptr, byval marker as integer, byval datalen as uinteger)
declare sub jpeg_write_m_byte (byval cinfo as j_compress_ptr, byval val as integer)
declare sub jpeg_write_tables (byval cinfo as j_compress_ptr)
declare function jpeg_read_header (byval cinfo as j_decompress_ptr, byval require_image as boolean) as integer
declare function jpeg_start_decompress (byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_read_scanlines (byval cinfo as j_decompress_ptr, byval scanlines as JSAMPARRAY, byval max_lines as JDIMENSION) as JDIMENSION
declare function jpeg_finish_decompress (byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_read_raw_data (byval cinfo as j_decompress_ptr, byval data as JSAMPIMAGE, byval max_lines as JDIMENSION) as JDIMENSION
declare function jpeg_has_multiple_scans (byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_start_output (byval cinfo as j_decompress_ptr, byval scan_number as integer) as boolean
declare function jpeg_finish_output (byval cinfo as j_decompress_ptr) as boolean
declare function jpeg_input_complete (byval cinfo as j_decompress_ptr) as boolean
declare sub jpeg_new_colormap (byval cinfo as j_decompress_ptr)
declare function jpeg_consume_input (byval cinfo as j_decompress_ptr) as integer
declare sub jpeg_calc_output_dimensions (byval cinfo as j_decompress_ptr)
declare sub jpeg_save_markers (byval cinfo as j_decompress_ptr, byval marker_code as integer, byval length_limit as uinteger)
declare sub jpeg_set_marker_processor (byval cinfo as j_decompress_ptr, byval marker_code as integer, byval routine as jpeg_marker_parser_method)
declare function jpeg_read_coefficients (byval cinfo as j_decompress_ptr) as jvirt_barray_ptr ptr
declare sub jpeg_write_coefficients (byval cinfo as j_compress_ptr, byval coef_arrays as jvirt_barray_ptr ptr)
declare sub jpeg_copy_critical_parameters (byval srcinfo as j_decompress_ptr, byval dstinfo as j_compress_ptr)
declare sub jpeg_abort_compress (byval cinfo as j_compress_ptr)
declare sub jpeg_abort_decompress (byval cinfo as j_decompress_ptr)
declare sub jpeg_abort (byval cinfo as j_common_ptr)
declare sub jpeg_destroy (byval cinfo as j_common_ptr)
declare function jpeg_resync_to_restart (byval cinfo as j_decompress_ptr, byval desired as integer) as boolean
end extern

#endif
