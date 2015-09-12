'' FreeBASIC binding for xz-5.2.1
''
'' based on the C header files:
''
''   \file        api/lzma.h
''   \brief       The public API of liblzma data compression library
''
''   liblzma is a public domain general-purpose data compression library with
''   a zlib-like API. The native file format is .xz, but also the old .lzma
''   format and raw (no headers) streams are supported. Multiple compression
''   algorithms (filters) are supported. Currently LZMA2 is the primary filter.
''
''   liblzma is part of XZ Utils <http://tukaani.org/xz/>. XZ Utils includes
''   a gzip-like command line tool named xz and some other tools. XZ Utils
''   is developed and maintained by Lasse Collin.
''
''   Major parts of liblzma are based on Igor Pavlov's public domain LZMA SDK
''   <http://7-zip.org/sdk.html>.
''
''   The SHA-256 implementation is based on the public domain code found from
''   7-Zip <http://7-zip.org/>, which has a modified version of the public
''   domain SHA-256 code found from Crypto++ <http://www.cryptopp.com/>.
''   The SHA-256 code in Crypto++ was written by Kevin Springle and Wei Dai.
''   Author: Lasse Collin
''
''   This file has been put into the public domain.
''   You can do whatever you want with this file.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "lzma"

#include once "crt/stddef.bi"
#include once "crt/limits.bi"
#include once "crt/stdint.bi"

'' The following symbols have been renamed:
''     #define LZMA_VERSION_STRING => LZMA_VERSION_STRING_
''     constant LZMA_GET_CHECK => LZMA_GET_CHECK_

extern "C"

#define LZMA_H
const LZMA_VERSION_MAJOR = 5
const LZMA_VERSION_MINOR = 2
const LZMA_VERSION_PATCH = 1
#define LZMA_VERSION_COMMIT ""
const LZMA_VERSION_STABILITY_ALPHA = 0
const LZMA_VERSION_STABILITY_BETA = 1
const LZMA_VERSION_STABILITY_STABLE = 2
const LZMA_VERSION_STABILITY = LZMA_VERSION_STABILITY_STABLE
#define LZMA_VERSION ((((LZMA_VERSION_MAJOR * UINT32_C(10000000)) + (LZMA_VERSION_MINOR * UINT32_C(10000))) + (LZMA_VERSION_PATCH * UINT32_C(10))) + LZMA_VERSION_STABILITY)
#define LZMA_VERSION_STABILITY_STRING ""
#define LZMA_VERSION_STRING_C_(major, minor, patch, stability, commit) #major "." #minor "." #patch stability commit
#define LZMA_VERSION_STRING_C(major, minor, patch, stability, commit) LZMA_VERSION_STRING_C_(major, minor, patch, stability, commit)
#define LZMA_VERSION_STRING_ LZMA_VERSION_STRING_C(LZMA_VERSION_MAJOR, LZMA_VERSION_MINOR, LZMA_VERSION_PATCH, LZMA_VERSION_STABILITY_STRING, LZMA_VERSION_COMMIT)
declare function lzma_version_number() as ulong
declare function lzma_version_string() as const zstring ptr
type lzma_bool as ubyte

type lzma_reserved_enum as long
enum
	LZMA_RESERVED_ENUM = 0
end enum

type lzma_ret as long
enum
	LZMA_OK = 0
	LZMA_STREAM_END = 1
	LZMA_NO_CHECK = 2
	LZMA_UNSUPPORTED_CHECK = 3
	LZMA_GET_CHECK_ = 4
	LZMA_MEM_ERROR = 5
	LZMA_MEMLIMIT_ERROR = 6
	LZMA_FORMAT_ERROR = 7
	LZMA_OPTIONS_ERROR = 8
	LZMA_DATA_ERROR = 9
	LZMA_BUF_ERROR = 10
	LZMA_PROG_ERROR = 11
end enum

type lzma_action as long
enum
	LZMA_RUN = 0
	LZMA_SYNC_FLUSH = 1
	LZMA_FULL_FLUSH = 2
	LZMA_FULL_BARRIER = 4
	LZMA_FINISH = 3
end enum

type lzma_allocator
	alloc as function(byval opaque as any ptr, byval nmemb as uinteger, byval size as uinteger) as any ptr
	free as sub(byval opaque as any ptr, byval ptr as any ptr)
	opaque as any ptr
end type

type lzma_internal as lzma_internal_s

type lzma_stream
	next_in as const ubyte ptr
	avail_in as uinteger
	total_in as ulongint
	next_out as ubyte ptr
	avail_out as uinteger
	total_out as ulongint
	allocator as const lzma_allocator ptr
	internal as lzma_internal ptr
	reserved_ptr1 as any ptr
	reserved_ptr2 as any ptr
	reserved_ptr3 as any ptr
	reserved_ptr4 as any ptr
	reserved_int1 as ulongint
	reserved_int2 as ulongint
	reserved_int3 as uinteger
	reserved_int4 as uinteger
	reserved_enum1 as lzma_reserved_enum
	reserved_enum2 as lzma_reserved_enum
end type

#define LZMA_STREAM_INIT (NULL, 0, 0, NULL, 0, 0, NULL, NULL, NULL, NULL, NULL, NULL, 0, 0, 0, 0, LZMA_RESERVED_ENUM, LZMA_RESERVED_ENUM)
declare function lzma_code(byval strm as lzma_stream ptr, byval action as lzma_action) as lzma_ret
declare sub lzma_end(byval strm as lzma_stream ptr)
declare sub lzma_get_progress(byval strm as lzma_stream ptr, byval progress_in as ulongint ptr, byval progress_out as ulongint ptr)
declare function lzma_memusage(byval strm as const lzma_stream ptr) as ulongint
declare function lzma_memlimit_get(byval strm as const lzma_stream ptr) as ulongint
declare function lzma_memlimit_set(byval strm as lzma_stream ptr, byval memlimit as ulongint) as lzma_ret

#define LZMA_VLI_MAX (UINT64_MAX / 2)
#define LZMA_VLI_UNKNOWN UINT64_MAX
const LZMA_VLI_BYTES_MAX = 9
#define LZMA_VLI_C(n) UINT64_C(n)
type lzma_vli as ulongint
#define lzma_vli_is_valid(vli) (((vli) <= LZMA_VLI_MAX) orelse ((vli) = LZMA_VLI_UNKNOWN))

declare function lzma_vli_encode(byval vli as lzma_vli, byval vli_pos as uinteger ptr, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_vli_decode(byval vli as lzma_vli ptr, byval vli_pos as uinteger ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger) as lzma_ret
declare function lzma_vli_size(byval vli as lzma_vli) as ulong

type lzma_check as long
enum
	LZMA_CHECK_NONE = 0
	LZMA_CHECK_CRC32 = 1
	LZMA_CHECK_CRC64 = 4
	LZMA_CHECK_SHA256 = 10
end enum

const LZMA_CHECK_ID_MAX = 15
declare function lzma_check_is_supported(byval check as lzma_check) as lzma_bool
declare function lzma_check_size(byval check as lzma_check) as ulong
const LZMA_CHECK_SIZE_MAX = 64
declare function lzma_crc32(byval buf as const ubyte ptr, byval size as uinteger, byval crc as ulong) as ulong
declare function lzma_crc64(byval buf as const ubyte ptr, byval size as uinteger, byval crc as ulongint) as ulongint
declare function lzma_get_check(byval strm as const lzma_stream ptr) as lzma_check
const LZMA_FILTERS_MAX = 4

type lzma_filter
	id as lzma_vli
	options as any ptr
end type

declare function lzma_filter_encoder_is_supported(byval id as lzma_vli) as lzma_bool
declare function lzma_filter_decoder_is_supported(byval id as lzma_vli) as lzma_bool
declare function lzma_filters_copy(byval src as const lzma_filter ptr, byval dest as lzma_filter ptr, byval allocator as const lzma_allocator ptr) as lzma_ret
declare function lzma_raw_encoder_memusage(byval filters as const lzma_filter ptr) as ulongint
declare function lzma_raw_decoder_memusage(byval filters as const lzma_filter ptr) as ulongint
declare function lzma_raw_encoder(byval strm as lzma_stream ptr, byval filters as const lzma_filter ptr) as lzma_ret
declare function lzma_raw_decoder(byval strm as lzma_stream ptr, byval filters as const lzma_filter ptr) as lzma_ret
declare function lzma_filters_update(byval strm as lzma_stream ptr, byval filters as const lzma_filter ptr) as lzma_ret
declare function lzma_raw_buffer_encode(byval filters as const lzma_filter ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_raw_buffer_decode(byval filters as const lzma_filter ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_properties_size(byval size as ulong ptr, byval filter as const lzma_filter ptr) as lzma_ret
declare function lzma_properties_encode(byval filter as const lzma_filter ptr, byval props as ubyte ptr) as lzma_ret
declare function lzma_properties_decode(byval filter as lzma_filter ptr, byval allocator as const lzma_allocator ptr, byval props as const ubyte ptr, byval props_size as uinteger) as lzma_ret
declare function lzma_filter_flags_size(byval size as ulong ptr, byval filter as const lzma_filter ptr) as lzma_ret
declare function lzma_filter_flags_encode(byval filter as const lzma_filter ptr, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_filter_flags_decode(byval filter as lzma_filter ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger) as lzma_ret

#define LZMA_FILTER_X86 LZMA_VLI_C(&h04)
#define LZMA_FILTER_POWERPC LZMA_VLI_C(&h05)
#define LZMA_FILTER_IA64 LZMA_VLI_C(&h06)
#define LZMA_FILTER_ARM LZMA_VLI_C(&h07)
#define LZMA_FILTER_ARMTHUMB LZMA_VLI_C(&h08)
#define LZMA_FILTER_SPARC LZMA_VLI_C(&h09)

type lzma_options_bcj
	start_offset as ulong
end type

#define LZMA_FILTER_DELTA LZMA_VLI_C(&h03)

type lzma_delta_type as long
enum
	LZMA_DELTA_TYPE_BYTE
end enum

type lzma_options_delta
	as lzma_delta_type type
	dist as ulong
	reserved_int1 as ulong
	reserved_int2 as ulong
	reserved_int3 as ulong
	reserved_int4 as ulong
	reserved_ptr1 as any ptr
	reserved_ptr2 as any ptr
end type

const LZMA_DELTA_DIST_MIN = 1
const LZMA_DELTA_DIST_MAX = 256
#define LZMA_FILTER_LZMA1 LZMA_VLI_C(&h4000000000000001)
#define LZMA_FILTER_LZMA2 LZMA_VLI_C(&h21)

type lzma_match_finder as long
enum
	LZMA_MF_HC3 = &h03
	LZMA_MF_HC4 = &h04
	LZMA_MF_BT2 = &h12
	LZMA_MF_BT3 = &h13
	LZMA_MF_BT4 = &h14
end enum

declare function lzma_mf_is_supported(byval match_finder as lzma_match_finder) as lzma_bool

type lzma_mode as long
enum
	LZMA_MODE_FAST = 1
	LZMA_MODE_NORMAL = 2
end enum

declare function lzma_mode_is_supported(byval mode as lzma_mode) as lzma_bool

type lzma_options_lzma
	dict_size as ulong
	preset_dict as const ubyte ptr
	preset_dict_size as ulong
	lc as ulong
	lp as ulong
	pb as ulong
	mode as lzma_mode
	nice_len as ulong
	mf as lzma_match_finder
	depth as ulong
	reserved_int1 as ulong
	reserved_int2 as ulong
	reserved_int3 as ulong
	reserved_int4 as ulong
	reserved_int5 as ulong
	reserved_int6 as ulong
	reserved_int7 as ulong
	reserved_int8 as ulong
	reserved_enum1 as lzma_reserved_enum
	reserved_enum2 as lzma_reserved_enum
	reserved_enum3 as lzma_reserved_enum
	reserved_enum4 as lzma_reserved_enum
	reserved_ptr1 as any ptr
	reserved_ptr2 as any ptr
end type

#define LZMA_DICT_SIZE_MIN UINT32_C(4096)
#define LZMA_DICT_SIZE_DEFAULT (UINT32_C(1) shl 23)
const LZMA_LCLP_MIN = 0
const LZMA_LCLP_MAX = 4
const LZMA_LC_DEFAULT = 3
const LZMA_LP_DEFAULT = 0
const LZMA_PB_MIN = 0
const LZMA_PB_MAX = 4
const LZMA_PB_DEFAULT = 2
declare function lzma_lzma_preset(byval options as lzma_options_lzma ptr, byval preset as ulong) as lzma_bool
#define LZMA_PRESET_DEFAULT UINT32_C(6)
#define LZMA_PRESET_LEVEL_MASK UINT32_C(&h1F)
#define LZMA_PRESET_EXTREME (UINT32_C(1) shl 31)

type lzma_mt
	flags as ulong
	threads as ulong
	block_size as ulongint
	timeout as ulong
	preset as ulong
	filters as const lzma_filter ptr
	check as lzma_check
	reserved_enum1 as lzma_reserved_enum
	reserved_enum2 as lzma_reserved_enum
	reserved_enum3 as lzma_reserved_enum
	reserved_int1 as ulong
	reserved_int2 as ulong
	reserved_int3 as ulong
	reserved_int4 as ulong
	reserved_int5 as ulongint
	reserved_int6 as ulongint
	reserved_int7 as ulongint
	reserved_int8 as ulongint
	reserved_ptr1 as any ptr
	reserved_ptr2 as any ptr
	reserved_ptr3 as any ptr
	reserved_ptr4 as any ptr
end type

declare function lzma_easy_encoder_memusage(byval preset as ulong) as ulongint
declare function lzma_easy_decoder_memusage(byval preset as ulong) as ulongint
declare function lzma_easy_encoder(byval strm as lzma_stream ptr, byval preset as ulong, byval check as lzma_check) as lzma_ret
declare function lzma_easy_buffer_encode(byval preset as ulong, byval check as lzma_check, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_stream_encoder(byval strm as lzma_stream ptr, byval filters as const lzma_filter ptr, byval check as lzma_check) as lzma_ret
declare function lzma_stream_encoder_mt_memusage(byval options as const lzma_mt ptr) as ulongint
declare function lzma_stream_encoder_mt(byval strm as lzma_stream ptr, byval options as const lzma_mt ptr) as lzma_ret
declare function lzma_alone_encoder(byval strm as lzma_stream ptr, byval options as const lzma_options_lzma ptr) as lzma_ret
declare function lzma_stream_buffer_bound(byval uncompressed_size as uinteger) as uinteger
declare function lzma_stream_buffer_encode(byval filters as lzma_filter ptr, byval check as lzma_check, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret

#define LZMA_TELL_NO_CHECK UINT32_C(&h01)
#define LZMA_TELL_UNSUPPORTED_CHECK UINT32_C(&h02)
#define LZMA_TELL_ANY_CHECK UINT32_C(&h04)
#define LZMA_IGNORE_CHECK UINT32_C(&h10)
#define LZMA_CONCATENATED UINT32_C(&h08)

declare function lzma_stream_decoder(byval strm as lzma_stream ptr, byval memlimit as ulongint, byval flags as ulong) as lzma_ret
declare function lzma_auto_decoder(byval strm as lzma_stream ptr, byval memlimit as ulongint, byval flags as ulong) as lzma_ret
declare function lzma_alone_decoder(byval strm as lzma_stream ptr, byval memlimit as ulongint) as lzma_ret
declare function lzma_stream_buffer_decode(byval memlimit as ulongint ptr, byval flags as ulong, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
const LZMA_STREAM_HEADER_SIZE = 12

type lzma_stream_flags
	version as ulong
	backward_size as lzma_vli
	check as lzma_check
	reserved_enum1 as lzma_reserved_enum
	reserved_enum2 as lzma_reserved_enum
	reserved_enum3 as lzma_reserved_enum
	reserved_enum4 as lzma_reserved_enum
	reserved_bool1 as lzma_bool
	reserved_bool2 as lzma_bool
	reserved_bool3 as lzma_bool
	reserved_bool4 as lzma_bool
	reserved_bool5 as lzma_bool
	reserved_bool6 as lzma_bool
	reserved_bool7 as lzma_bool
	reserved_bool8 as lzma_bool
	reserved_int1 as ulong
	reserved_int2 as ulong
end type

const LZMA_BACKWARD_SIZE_MIN = 4
#define LZMA_BACKWARD_SIZE_MAX (LZMA_VLI_C(1) shl 34)
declare function lzma_stream_header_encode(byval options as const lzma_stream_flags ptr, byval out as ubyte ptr) as lzma_ret
declare function lzma_stream_footer_encode(byval options as const lzma_stream_flags ptr, byval out as ubyte ptr) as lzma_ret
declare function lzma_stream_header_decode(byval options as lzma_stream_flags ptr, byval in as const ubyte ptr) as lzma_ret
declare function lzma_stream_footer_decode(byval options as lzma_stream_flags ptr, byval in as const ubyte ptr) as lzma_ret
declare function lzma_stream_flags_compare(byval a as const lzma_stream_flags ptr, byval b as const lzma_stream_flags ptr) as lzma_ret

type lzma_block
	version as ulong
	header_size as ulong
	check as lzma_check
	compressed_size as lzma_vli
	uncompressed_size as lzma_vli
	filters as lzma_filter ptr
	raw_check(0 to 63) as ubyte
	reserved_ptr1 as any ptr
	reserved_ptr2 as any ptr
	reserved_ptr3 as any ptr
	reserved_int1 as ulong
	reserved_int2 as ulong
	reserved_int3 as lzma_vli
	reserved_int4 as lzma_vli
	reserved_int5 as lzma_vli
	reserved_int6 as lzma_vli
	reserved_int7 as lzma_vli
	reserved_int8 as lzma_vli
	reserved_enum1 as lzma_reserved_enum
	reserved_enum2 as lzma_reserved_enum
	reserved_enum3 as lzma_reserved_enum
	reserved_enum4 as lzma_reserved_enum
	ignore_check as lzma_bool
	reserved_bool2 as lzma_bool
	reserved_bool3 as lzma_bool
	reserved_bool4 as lzma_bool
	reserved_bool5 as lzma_bool
	reserved_bool6 as lzma_bool
	reserved_bool7 as lzma_bool
	reserved_bool8 as lzma_bool
end type

const LZMA_BLOCK_HEADER_SIZE_MIN = 8
const LZMA_BLOCK_HEADER_SIZE_MAX = 1024
#define lzma_block_header_size_decode(b) culng(culng(culng(b) + 1) * 4)

declare function lzma_block_header_size(byval block as lzma_block ptr) as lzma_ret
declare function lzma_block_header_encode(byval block as const lzma_block ptr, byval out as ubyte ptr) as lzma_ret
declare function lzma_block_header_decode(byval block as lzma_block ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr) as lzma_ret
declare function lzma_block_compressed_size(byval block as lzma_block ptr, byval unpadded_size as lzma_vli) as lzma_ret
declare function lzma_block_unpadded_size(byval block as const lzma_block ptr) as lzma_vli
declare function lzma_block_total_size(byval block as const lzma_block ptr) as lzma_vli
declare function lzma_block_encoder(byval strm as lzma_stream ptr, byval block as lzma_block ptr) as lzma_ret
declare function lzma_block_decoder(byval strm as lzma_stream ptr, byval block as lzma_block ptr) as lzma_ret
declare function lzma_block_buffer_bound(byval uncompressed_size as uinteger) as uinteger
declare function lzma_block_buffer_encode(byval block as lzma_block ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_block_uncomp_encode(byval block as lzma_block ptr, byval in as const ubyte ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_block_buffer_decode(byval block as lzma_block ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
type lzma_index as lzma_index_s

type lzma_index_iter_stream
	flags as const lzma_stream_flags ptr
	reserved_ptr1 as const any ptr
	reserved_ptr2 as const any ptr
	reserved_ptr3 as const any ptr
	number as lzma_vli
	block_count as lzma_vli
	compressed_offset as lzma_vli
	uncompressed_offset as lzma_vli
	compressed_size as lzma_vli
	uncompressed_size as lzma_vli
	padding as lzma_vli
	reserved_vli1 as lzma_vli
	reserved_vli2 as lzma_vli
	reserved_vli3 as lzma_vli
	reserved_vli4 as lzma_vli
end type

type lzma_index_iter_block
	number_in_file as lzma_vli
	compressed_file_offset as lzma_vli
	uncompressed_file_offset as lzma_vli
	number_in_stream as lzma_vli
	compressed_stream_offset as lzma_vli
	uncompressed_stream_offset as lzma_vli
	uncompressed_size as lzma_vli
	unpadded_size as lzma_vli
	total_size as lzma_vli
	reserved_vli1 as lzma_vli
	reserved_vli2 as lzma_vli
	reserved_vli3 as lzma_vli
	reserved_vli4 as lzma_vli
	reserved_ptr1 as const any ptr
	reserved_ptr2 as const any ptr
	reserved_ptr3 as const any ptr
	reserved_ptr4 as const any ptr
end type

union lzma_index_iter_internal
	p as const any ptr
	s as uinteger
	v as lzma_vli
end union

type lzma_index_iter
	stream as lzma_index_iter_stream
	block as lzma_index_iter_block
	internal(0 to 5) as lzma_index_iter_internal
end type

type lzma_index_iter_mode as long
enum
	LZMA_INDEX_ITER_ANY = 0
	LZMA_INDEX_ITER_STREAM = 1
	LZMA_INDEX_ITER_BLOCK = 2
	LZMA_INDEX_ITER_NONEMPTY_BLOCK = 3
end enum

declare function lzma_index_memusage(byval streams as lzma_vli, byval blocks as lzma_vli) as ulongint
declare function lzma_index_memused(byval i as const lzma_index ptr) as ulongint
declare function lzma_index_init(byval allocator as const lzma_allocator ptr) as lzma_index ptr
declare sub lzma_index_end(byval i as lzma_index ptr, byval allocator as const lzma_allocator ptr)
declare function lzma_index_append(byval i as lzma_index ptr, byval allocator as const lzma_allocator ptr, byval unpadded_size as lzma_vli, byval uncompressed_size as lzma_vli) as lzma_ret
declare function lzma_index_stream_flags(byval i as lzma_index ptr, byval stream_flags as const lzma_stream_flags ptr) as lzma_ret
declare function lzma_index_checks(byval i as const lzma_index ptr) as ulong
declare function lzma_index_stream_padding(byval i as lzma_index ptr, byval stream_padding as lzma_vli) as lzma_ret
declare function lzma_index_stream_count(byval i as const lzma_index ptr) as lzma_vli
declare function lzma_index_block_count(byval i as const lzma_index ptr) as lzma_vli
declare function lzma_index_size(byval i as const lzma_index ptr) as lzma_vli
declare function lzma_index_stream_size(byval i as const lzma_index ptr) as lzma_vli
declare function lzma_index_total_size(byval i as const lzma_index ptr) as lzma_vli
declare function lzma_index_file_size(byval i as const lzma_index ptr) as lzma_vli
declare function lzma_index_uncompressed_size(byval i as const lzma_index ptr) as lzma_vli
declare sub lzma_index_iter_init(byval iter as lzma_index_iter ptr, byval i as const lzma_index ptr)
declare sub lzma_index_iter_rewind(byval iter as lzma_index_iter ptr)
declare function lzma_index_iter_next(byval iter as lzma_index_iter ptr, byval mode as lzma_index_iter_mode) as lzma_bool
declare function lzma_index_iter_locate(byval iter as lzma_index_iter ptr, byval target as lzma_vli) as lzma_bool
declare function lzma_index_cat(byval dest as lzma_index ptr, byval src as lzma_index ptr, byval allocator as const lzma_allocator ptr) as lzma_ret
declare function lzma_index_dup(byval i as const lzma_index ptr, byval allocator as const lzma_allocator ptr) as lzma_index ptr
declare function lzma_index_encoder(byval strm as lzma_stream ptr, byval i as const lzma_index ptr) as lzma_ret
declare function lzma_index_decoder(byval strm as lzma_stream ptr, byval i as lzma_index ptr ptr, byval memlimit as ulongint) as lzma_ret
declare function lzma_index_buffer_encode(byval i as const lzma_index ptr, byval out as ubyte ptr, byval out_pos as uinteger ptr, byval out_size as uinteger) as lzma_ret
declare function lzma_index_buffer_decode(byval i as lzma_index ptr ptr, byval memlimit as ulongint ptr, byval allocator as const lzma_allocator ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger) as lzma_ret
type lzma_index_hash as lzma_index_hash_s
declare function lzma_index_hash_init(byval index_hash as lzma_index_hash ptr, byval allocator as const lzma_allocator ptr) as lzma_index_hash ptr
declare sub lzma_index_hash_end(byval index_hash as lzma_index_hash ptr, byval allocator as const lzma_allocator ptr)
declare function lzma_index_hash_append(byval index_hash as lzma_index_hash ptr, byval unpadded_size as lzma_vli, byval uncompressed_size as lzma_vli) as lzma_ret
declare function lzma_index_hash_decode(byval index_hash as lzma_index_hash ptr, byval in as const ubyte ptr, byval in_pos as uinteger ptr, byval in_size as uinteger) as lzma_ret
declare function lzma_index_hash_size(byval index_hash as const lzma_index_hash ptr) as lzma_vli
declare function lzma_physmem() as ulongint
declare function lzma_cputhreads() as ulong

end extern
