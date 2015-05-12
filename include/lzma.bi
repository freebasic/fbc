'' liblzma (xz-utils)

#ifndef __LZMA_BI__
#define __LZMA_BI__

#inclib "lzma"

#include once "crt/stddef.bi"

#define UINT32_MAX 4294967295u
#define UINT64_MAX 18446744073709551615ull

extern "c"

''
'' lzma/version.h
''

#define LZMA_VERSION_MAJOR 5
#define LZMA_VERSION_MINOR 0
#define LZMA_VERSION_PATCH 2
#define LZMA_VERSION_STABILITY LZMA_VERSION_STABILITY_STABLE

#define LZMA_VERSION_STABILITY_ALPHA 0
#define LZMA_VERSION_STABILITY_BETA 1
#define LZMA_VERSION_STABILITY_STABLE 2

#define LZMA_VERSION _
        (LZMA_VERSION_MAJOR * 10000000u + _
         LZMA_VERSION_MINOR * 10000u + _
         LZMA_VERSION_PATCH * 10u + _
         LZMA_VERSION_STABILITY)

#if LZMA_VERSION_STABILITY = LZMA_VERSION_STABILITY_ALPHA
    #define LZMA_VERSION_STABILITY_STRING "alpha"
#elseif LZMA_VERSION_STABILITY = LZMA_VERSION_STABILITY_BETA
    #define LZMA_VERSION_STABILITY_STRING "beta"
#elseif LZMA_VERSION_STABILITY = LZMA_VERSION_STABILITY_STABLE
    #define LZMA_VERSION_STABILITY_STRING ""
#else
    #error "Incorrect LZMA_VERSION_STABILITY"
#endif

#define LZMA_VERSION_STRING_C(major, minor, patch, stability, commit) _
        #major "." #minor "." #patch stability commit

'' Note: naming conflict with lzma_version_string()
#define LZMA_VERSION_STRING_ _
        LZMA_VERSION_STRING_C(LZMA_VERSION_MAJOR, _
                              LZMA_VERSION_MINOR, _
                              LZMA_VERSION_PATCH, _
                              LZMA_VERSION_STABILITY_STRING, _
                              LZMA_VERSION_COMMIT)

declare function lzma_version_number() as uinteger
declare function lzma_version_string() as const zstring ptr

''
'' lzma/base.h
''

#define LZMA_TRUE 1
#define LZMA_FALSE 0
type lzma_bool as ubyte

enum lzma_reserved_enum
    LZMA_RESERVED_ENUM      = 0
end enum

enum lzma_ret
    LZMA_OK                 = 0
    LZMA_STREAM_END         = 1
    LZMA_NO_CHECK           = 2
    LZMA_UNSUPPORTED_CHECK  = 3
    LZMA_GET_CHECK_         = 4 '' Note: naming conflict with lzma_get_check()
    LZMA_MEM_ERROR          = 5
    LZMA_MEMLIMIT_ERROR     = 6
    LZMA_FORMAT_ERROR       = 7
    LZMA_OPTIONS_ERROR      = 8
    LZMA_DATA_ERROR         = 9
    LZMA_BUF_ERROR          = 10
    LZMA_PROG_ERROR         = 11
end enum

enum lzma_action
    LZMA_RUN = 0
    LZMA_SYNC_FLUSH = 1
    LZMA_FULL_FLUSH = 2
    LZMA_FINISH = 3
end enum

type lzma_allocator
    as function(byval as any ptr, byval as size_t, byval as size_t) as any ptr alloc
    as sub(byval as any ptr, byval as any ptr) free
    as any ptr opaque
end type

type lzma_internal as any

type lzma_stream
    as const ubyte ptr next_in
    as size_t avail_in
    as ulongint total_in
    as ubyte ptr next_out
    as size_t avail_out
    as ulongint total_out
    as lzma_allocator ptr allocator
    as lzma_internal ptr internal
    as any ptr reserved_ptr1
    as any ptr reserved_ptr2
    as any ptr reserved_ptr3
    as any ptr reserved_ptr4
    as ulongint reserved_int1
    as ulongint reserved_int2
    as size_t reserved_int3
    as size_t reserved_int4
    as lzma_reserved_enum reserved_enum1
    as lzma_reserved_enum reserved_enum2
end type

#define LZMA_STREAM_INIT _
    ( NULL, 0, 0, NULL, 0, 0, NULL, NULL, _
    NULL, NULL, NULL, NULL, 0, 0, 0, 0, _
    LZMA_RESERVED_ENUM, LZMA_RESERVED_ENUM )

declare function lzma_code(byval as lzma_stream ptr, byval as lzma_action) as lzma_ret
declare sub lzma_end(byval as lzma_stream ptr)
declare function lzma_memusage(byval as const lzma_stream ptr) as ulongint
declare function lzma_memlimit_get(byval as const lzma_stream ptr) as ulongint
declare function lzma_memlimit_set(byval as lzma_stream ptr, byval as ulongint)  as lzma_ret

''
'' lzma/vli.h
''

#define LZMA_VLI_MAX (UINT64_MAX \ 2)
#define LZMA_VLI_UNKNOWN UINT64_MAX
#define LZMA_VLI_BYTES_MAX 9
type lzma_vli as ulongint

#define lzma_vli_is_valid(vli) (((vli) <= LZMA_VLI_MAX) orelse ((vli) = LZMA_VLI_UNKNOWN))

declare function lzma_vli_encode _
    ( _
        byval as lzma_vli, _
        byval as size_t ptr, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_vli_decode _
    ( _
        byval as lzma_vli ptr, _
        byval as size_t ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_vli_size(byval as lzma_vli) as uinteger

''
'' lzma/check.h
''

enum lzma_check
    LZMA_CHECK_NONE     = 0
    LZMA_CHECK_CRC32    = 1
    LZMA_CHECK_CRC64    = 4
    LZMA_CHECK_SHA256   = 10
end enum

#define LZMA_CHECK_ID_MAX 15

declare function lzma_check_is_supported(byval as lzma_check) as lzma_bool
declare function lzma_check_size(byval as lzma_check) as uinteger

#define LZMA_CHECK_SIZE_MAX 64

declare function lzma_crc32(byval as const ubyte ptr, byval as size_t, byval as uinteger) as uinteger
declare function lzma_crc64(byval as const ubyte ptr, byval as size_t, byval as ulongint) as ulongint
declare function lzma_get_check(byval as const lzma_stream ptr) as lzma_check

''
'' lzma/filter.h
''

#define LZMA_FILTERS_MAX 4

type lzma_filter
    as lzma_vli id
    as any ptr options
end type

declare function lzma_filter_encoder_is_supported(byval as lzma_vli) as lzma_bool
declare function lzma_filter_decoder_is_supported(byval as lzma_vli) as lzma_bool
declare function lzma_filters_copy _
    ( _
        byval as const lzma_filter ptr, _
        byval as lzma_filter ptr, _
        byval as lzma_allocator ptr _
    ) as lzma_ret
declare function lzma_raw_encoder_memusage(byval as const lzma_filter ptr) as ulongint
declare function lzma_raw_decoder_memusage(byval as const lzma_filter ptr) as ulongint
declare function lzma_raw_encoder(byval as lzma_stream ptr, byval as const lzma_filter ptr) as lzma_ret
declare function lzma_raw_decoder(byval as lzma_stream ptr, byval as const lzma_filter ptr) as lzma_ret
declare function lzma_filters_update(byval as lzma_stream ptr, byval as const lzma_filter ptr) as lzma_ret
declare function lzma_raw_buffer_encode _
    ( _
        byval as const lzma_filter ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_raw_buffer_decode _
    ( _
        byval as const lzma_filter ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_properties_size(byval as uinteger ptr, byval as const lzma_filter ptr) as lzma_ret
declare function lzma_properties_encode(byval as const lzma_filter ptr, byval as ubyte ptr) as lzma_ret
declare function lzma_properties_decode _
    ( _
        byval as lzma_filter ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_filter_flags_size(byval as uinteger ptr, byval as const lzma_filter ptr) as lzma_ret
declare function lzma_filter_flags_encode _
    ( _
        byval as const lzma_filter ptr, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_filter_flags_decode _
    ( _
        byval as lzma_filter ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret

''
'' lzma/bcj.h
''

#define LZMA_FILTER_X86         &h04ull
#define LZMA_FILTER_POWERPC     &h05ull
#define LZMA_FILTER_IA64        &h06ull
#define LZMA_FILTER_ARM         &h07ull
#define LZMA_FILTER_ARMTHUMB    &h08ull
#define LZMA_FILTER_SPARC       &h09ull

type lzma_options_bcj
    as uinteger start_offset
end type

''
'' lzma/delta.h
''

#define LZMA_FILTER_DELTA       &h03ull

enum lzma_delta_type
    LZMA_DELTA_TYPE_BYTE
end enum

type lzma_options_delta
    as lzma_delta_type type
    as uinteger dist
    as uinteger reserved_int1
    as uinteger reserved_int2
    as uinteger reserved_int3
    as uinteger reserved_int4
    as any ptr reserved_ptr1
    as any ptr reserved_ptr2
end type

#define LZMA_DELTA_DIST_MIN 1
#define LZMA_DELTA_DIST_MAX 256

''
'' lzma/lzma.h
''

#define LZMA_FILTER_LZMA1       &h4000000000000001ull
#define LZMA_FILTER_LZMA2       &h21ull

enum lzma_match_finder
    LZMA_MF_HC3     = &h03
    LZMA_MF_HC4     = &h04
    LZMA_MF_BT2     = &h12
    LZMA_MF_BT3     = &h13
    LZMA_MF_BT4     = &h14
end enum

declare function lzma_mf_is_supported(byval as lzma_match_finder) as lzma_bool

enum lzma_mode
    LZMA_MODE_FAST = 1
    LZMA_MODE_NORMAL = 2
end enum

declare function lzma_mode_is_supported(byval as lzma_mode) as lzma_bool

type lzma_options_lzma
    as uinteger dict_size
    as const ubyte ptr preset_dict
    as uinteger preset_dict_size
    as uinteger lc
    as uinteger lp
    as uinteger pb
    as lzma_mode mode
    as uinteger nice_len
    as lzma_match_finder mf
    as uinteger depth
    as uinteger reserved_int1
    as uinteger reserved_int2
    as uinteger reserved_int3
    as uinteger reserved_int4
    as uinteger reserved_int5
    as uinteger reserved_int6
    as uinteger reserved_int7
    as uinteger reserved_int8
    as lzma_reserved_enum reserved_enum1
    as lzma_reserved_enum reserved_enum2
    as lzma_reserved_enum reserved_enum3
    as lzma_reserved_enum reserved_enum4
    as any ptr reserved_ptr1
    as any ptr reserved_ptr2
end type

#define LZMA_DICT_SIZE_MIN       4096u
#define LZMA_DICT_SIZE_DEFAULT   (1u shl 23)

#define LZMA_LCLP_MIN    0
#define LZMA_LCLP_MAX    4
#define LZMA_LC_DEFAULT  3

#define LZMA_LP_DEFAULT  0

#define LZMA_PB_MIN      0
#define LZMA_PB_MAX      4
#define LZMA_PB_DEFAULT  2

declare function lzma_lzma_preset(byval as lzma_options_lzma ptr, byval as uinteger) as lzma_bool

''
'' lzma/container.h
''

#define LZMA_PRESET_DEFAULT     6u
#define LZMA_PRESET_LEVEL_MASK  &h1Fu
#define LZMA_PRESET_EXTREME       (1u shl 31)

declare function lzma_easy_encoder_memusage(byval as uinteger) as ulongint
declare function lzma_easy_decoder_memusage(byval as uinteger) as ulongint
declare function lzma_easy_encoder _
    ( _
        byval as lzma_stream ptr, _
        byval as uinteger, _
        byval as lzma_check _
    ) as lzma_ret
declare function lzma_easy_buffer_encode _
    ( _
        byval as uinteger, _
        byval as lzma_check, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_stream_encoder _
    ( _
        byval as lzma_stream ptr, _
        byval as const lzma_filter ptr, _
        byval as lzma_check _
    ) as lzma_ret
declare function lzma_alone_encoder(byval as lzma_stream ptr, byval as const lzma_options_lzma ptr) as lzma_ret
declare function lzma_stream_buffer_bound(byval as size_t) as size_t
declare function lzma_stream_buffer_encode _
    ( _
        byval as lzma_filter ptr, _
        byval as lzma_check, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret

#define LZMA_TELL_NO_CHECK              &h01u
#define LZMA_TELL_UNSUPPORTED_CHECK     &h02u
#define LZMA_TELL_ANY_CHECK             &h04u
#define LZMA_CONCATENATED               &h08u

declare function lzma_stream_decoder _
    ( _
        byval as lzma_stream ptr, _
        byval as ulongint, _
        byval as uinteger _
    ) as lzma_ret
declare function lzma_auto_decoder _
    ( _
        byval as lzma_stream ptr, _
        byval as ulongint, _
        byval as uinteger _
    ) as lzma_ret
declare function lzma_alone_decoder(byval as lzma_stream ptr, byval as ulongint) as lzma_ret
declare function lzma_stream_buffer_decode _
    ( _
        byval as ulongint ptr, _
        byval as uinteger, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret

''
'' lzma/stream_flags.h
''

#define LZMA_STREAM_HEADER_SIZE 12

type lzma_stream_flags
    as uinteger version
    as lzma_vli backward_size
    as lzma_check check
    as lzma_reserved_enum reserved_enum1
    as lzma_reserved_enum reserved_enum2
    as lzma_reserved_enum reserved_enum3
    as lzma_reserved_enum reserved_enum4
    as lzma_bool reserved_bool1
    as lzma_bool reserved_bool2
    as lzma_bool reserved_bool3
    as lzma_bool reserved_bool4
    as lzma_bool reserved_bool5
    as lzma_bool reserved_bool6
    as lzma_bool reserved_bool7
    as lzma_bool reserved_bool8
    as uinteger reserved_int1
    as uinteger reserved_int2
end type

#define LZMA_BACKWARD_SIZE_MIN 4
#define LZMA_BACKWARD_SIZE_MAX (1ull shl 34)

declare function lzma_stream_header_encode(byval as const lzma_stream_flags ptr, byval as ubyte ptr) as lzma_ret
declare function lzma_stream_footer_encode(byval as const lzma_stream_flags ptr, byval as ubyte ptr) as lzma_ret
declare function lzma_stream_header_decode(byval as lzma_stream_flags ptr, byval as const ubyte ptr) as lzma_ret
declare function lzma_stream_footer_decode(byval as lzma_stream_flags ptr, byval as const ubyte ptr) as lzma_ret
declare function lzma_stream_flags_compare(byval as const lzma_stream_flags ptr, byval as const lzma_stream_flags ptr) as lzma_ret

''
'' lzma/block.h
''

type lzma_block
    as uinteger version
    as uinteger header_size
    as lzma_check check
    as lzma_vli compressed_size
    as lzma_vli uncompressed_size
    as lzma_filter ptr filters
    as ubyte raw_check(0 to (LZMA_CHECK_SIZE_MAX-1))
    as any ptr reserved_ptr1
    as any ptr reserved_ptr2
    as any ptr reserved_ptr3
    as uinteger reserved_int1
    as uinteger reserved_int2
    as lzma_vli reserved_int3
    as lzma_vli reserved_int4
    as lzma_vli reserved_int5
    as lzma_vli reserved_int6
    as lzma_vli reserved_int7
    as lzma_vli reserved_int8
    as lzma_reserved_enum reserved_enum1
    as lzma_reserved_enum reserved_enum2
    as lzma_reserved_enum reserved_enum3
    as lzma_reserved_enum reserved_enum4
    as lzma_bool reserved_bool1
    as lzma_bool reserved_bool2
    as lzma_bool reserved_bool3
    as lzma_bool reserved_bool4
    as lzma_bool reserved_bool5
    as lzma_bool reserved_bool6
    as lzma_bool reserved_bool7
    as lzma_bool reserved_bool8
end type

#define LZMA_BLOCK_HEADER_SIZE_MIN 8
#define LZMA_BLOCK_HEADER_SIZE_MAX 1024

#define lzma_block_header_size_decode(b) ((cuint(b) + 1) * 4)

declare function lzma_block_header_size(byval as lzma_block ptr) as lzma_ret
declare function lzma_block_header_encode(byval as const lzma_block ptr, byval as ubyte ptr) as lzma_ret
declare function lzma_block_header_decode _
    ( _
        byval as lzma_block ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr _
    ) as lzma_ret
declare function lzma_block_compressed_size(byval as lzma_block ptr, byval as lzma_vli) as lzma_ret
declare function lzma_block_unpadded_size(byval as const lzma_block ptr) as lzma_vli
declare function lzma_block_total_size(byval as const lzma_block ptr) as lzma_vli
declare function lzma_block_encoder(byval as lzma_stream ptr, byval as lzma_block ptr) as lzma_ret
declare function lzma_block_decoder(byval as lzma_stream ptr, byval as lzma_block ptr) as lzma_ret
declare function lzma_block_buffer_bound(byval as size_t) as size_t
declare function lzma_block_buffer_encode _
    ( _
        byval as lzma_block ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_block_buffer_decode _
    ( _
        byval as lzma_block ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret

''
'' lzma/index.h
''

type lzma_index as any

type lzma_index_iter_stream
    as const lzma_stream_flags ptr flags
    as const any ptr reserved_ptr1
    as const any ptr reserved_ptr2
    as const any ptr reserved_ptr3
    as lzma_vli number
    as lzma_vli block_count
    as lzma_vli compressed_offset
    as lzma_vli uncompressed_offset
    as lzma_vli compressed_size
    as lzma_vli uncompressed_size
    as lzma_vli padding
    as lzma_vli reserved_vli1
    as lzma_vli reserved_vli2
    as lzma_vli reserved_vli3
    as lzma_vli reserved_vli4
end type

type lzma_index_iter_block
    as lzma_vli number_in_file
    as lzma_vli compressed_file_offset
    as lzma_vli uncompressed_file_offset
    as lzma_vli number_in_stream
    as lzma_vli compressed_stream_offset
    as lzma_vli uncompressed_stream_offset
    as lzma_vli uncompressed_size

    as lzma_vli unpadded_size
    as lzma_vli total_size
    as lzma_vli reserved_vli1
    as lzma_vli reserved_vli2
    as lzma_vli reserved_vli3
    as lzma_vli reserved_vli4
    as const any ptr reserved_ptr1
    as const any ptr reserved_ptr2
    as const any ptr reserved_ptr3
    as const any ptr reserved_ptr4
end type

union lzma_index_iter_internal
    as const any ptr p
    as size_t s
    as lzma_vli v
end union

type lzma_index_iter
    as lzma_index_iter_stream   stream
    as lzma_index_iter_block    block
    as lzma_index_iter_internal internal(0 to (6-1))
end type

enum lzma_index_iter_mode
    LZMA_INDEX_ITER_ANY             = 0
    LZMA_INDEX_ITER_STREAM          = 1
    LZMA_INDEX_ITER_BLOCK           = 2
    LZMA_INDEX_ITER_NONEMPTY_BLOCK  = 3
end enum

declare function lzma_index_memusage(byval as lzma_vli, byval as lzma_vli) as ulongint
declare function lzma_index_memused(byval as const lzma_index ptr) as ulongint
declare function lzma_index_init(byval as lzma_allocator ptr) as lzma_index ptr
declare sub lzma_index_end(byval as lzma_index ptr, byval as lzma_allocator ptr)
declare function lzma_index_append _
    ( _
        byval as lzma_index ptr, _
        byval as lzma_allocator ptr, _
        byval as lzma_vli, _
        byval as lzma_vli _
    ) as lzma_ret
declare function lzma_index_stream_flags _
    ( _
        byval as lzma_index ptr, _
        byval as const lzma_stream_flags ptr _
    ) as lzma_ret
declare function lzma_index_checks(byval as const lzma_index ptr) as uinteger
declare function lzma_index_stream_padding(byval as lzma_index ptr, byval as lzma_vli) as lzma_ret
declare function lzma_index_stream_count(byval as const lzma_index ptr) as lzma_vli
declare function lzma_index_block_count(byval as const lzma_index ptr) as lzma_vli
declare function lzma_index_size(byval as const lzma_index ptr) as lzma_vli
declare function lzma_index_stream_size(byval as const lzma_index ptr) as lzma_vli
declare function lzma_index_total_size(byval as const lzma_index ptr) as lzma_vli
declare function lzma_index_file_size(byval as const lzma_index ptr) as lzma_vli
declare function lzma_index_uncompressed_size(byval as const lzma_index ptr) as lzma_vli
declare sub lzma_index_iter_init(byval as lzma_index_iter ptr, byval as const lzma_index ptr)
declare sub lzma_index_iter_rewind(byval as lzma_index_iter ptr)
declare function lzma_index_iter_next(byval as lzma_index_iter ptr, byval as lzma_index_iter_mode) as lzma_bool
declare function lzma_index_iter_locate(byval as lzma_index_iter ptr, byval as lzma_vli) as lzma_bool
declare function lzma_index_cat _
    ( _
        byval as lzma_index ptr, _
        byval as lzma_index ptr, _
        byval as lzma_allocator ptr _
    ) as lzma_ret
declare function lzma_index_dup _
    ( _
        byval as const lzma_index ptr, _
        byval as lzma_allocator ptr _
    ) as lzma_index ptr
declare function lzma_index_encoder _
    ( _
        byval as lzma_stream ptr, _
        byval as const lzma_index ptr _
    ) as lzma_ret
declare function lzma_index_decoder _
    ( _
        byval as lzma_stream ptr, _
        byval as lzma_index ptr ptr, _
        byval as ulongint _
    ) as lzma_ret
declare function lzma_index_buffer_encode _
    ( _
        byval as const lzma_index ptr, _
        byval as ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_index_buffer_decode _
    ( _
        byval as lzma_index ptr ptr, _
        byval as ulongint ptr, _
        byval as lzma_allocator ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret

''
'' lzma/index_hash.h
''

type lzma_index_hash as any

declare function lzma_index_hash_init(byval as lzma_index_hash ptr, byval as lzma_allocator ptr) as lzma_index_hash ptr
declare sub lzma_index_hash_end(byval as lzma_index_hash ptr, byval as lzma_allocator ptr)
declare function lzma_index_hash_append _
    ( _
        byval as lzma_index_hash ptr, _
        byval as lzma_vli, _
        byval as lzma_vli _
    ) as lzma_ret
declare function lzma_index_hash_decode _
    ( _
        byval as lzma_index_hash ptr, _
        byval as const ubyte ptr, _
        byval as size_t ptr, _
        byval as size_t _
    ) as lzma_ret
declare function lzma_index_hash_size(byval as const lzma_index_hash ptr) as lzma_vli

''
'' lzma/hardware.h
''

declare function lzma_physmem() as ulongint

end extern

#endif
