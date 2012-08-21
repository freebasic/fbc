#ifndef QLZ_HEADER
#define QLZ_HEADER

#inclib "quicklz"

' Fast data compression library
' Copyright (C) 2006-2011 Lasse Mikkel Reinhold
' lar@quicklz.com
'
' QuickLZ can be used for free under the GPL 1, 2 or 3 license (where anything
' released into public must be open source) or under a commercial license if such
' has been acquired (see http:'www.quicklz.com/order.html). The commercial license
' does not cover derived or ported versions created by third parties under GPL.

' You can edit following user settings. Data must be decompressed with the same
' setting of QLZ_COMPRESSION_LEVEL and QLZ_STREAMING_BUFFER as it was compressed
' (see manual). If QLZ_STREAMING_BUFFER > 0, scratch buffers must be initially
' zeroed out (see manual). First #ifndef makes it possible to define settings from
' the outside like the compiler command line.

' 1.5.0 final

#ifndef QLZ_COMPRESSION_LEVEL

	' 1 gives fastest compression speed. 3 gives fastest decompression speed and best
	' compression ratio.
	#define QLZ_COMPRESSION_LEVEL 1
	'#define QLZ_COMPRESSION_LEVEL 2
	'#define QLZ_COMPRESSION_LEVEL 3

	' If > 0, zero out both states prior to first call to qlz_compress() or qlz_decompress()
	' and decompress packets in the same order as they were compressed
	#define QLZ_STREAMING_BUFFER 0
	'#define QLZ_STREAMING_BUFFER 100000
	'#define QLZ_STREAMING_BUFFER 1000000

	' Guarantees that decompression of corrupted data cannot crash. Decreases decompression
	' speed 10-20%. Compression speed not affected.
	'#define QLZ_MEMORY_SAFE
#endif

#define QLZ_VERSION_MAJOR 1
#define QLZ_VERSION_MINOR 5
#define QLZ_VERSION_REVISION 0

' Using size_t, memset() and memcpy()
#include "crt/string.bi"

' Verify compression level
#if QLZ_COMPRESSION_LEVEL <> 1 and QLZ_COMPRESSION_LEVEL <> 2 and QLZ_COMPRESSION_LEVEL <> 3
#error QLZ_COMPRESSION_LEVEL must be 1, 2 or 3
#endif

type ui32 as uinteger
type ui16 as ushort

' Decrease QLZ_POINTERS for level 3 to increase compression speed. Do not touch any other values!
#if QLZ_COMPRESSION_LEVEL = 1
#define QLZ_POINTERS 1
#define QLZ_HASH_VALUES 4096
#elseif QLZ_COMPRESSION_LEVEL = 2
#define QLZ_POINTERS 4
#define QLZ_HASH_VALUES 2048
#elseif QLZ_COMPRESSION_LEVEL = 3
#define QLZ_POINTERS 16
#define QLZ_HASH_VALUES 4096
#endif

' Detect if pointer size is 64-bit. It's not fatal if some 64-bit target is not detected because this is only for adding an optional 64-bit optimization.
#if __FB_64BIT__
	#define QLZ_PTR_64
#endif

' hash entry
type qlz_hash_compress
#if QLZ_COMPRESSION_LEVEL = 1
	cache as ui32
#if defined(QLZ_PTR_64) and QLZ_STREAMING_BUFFER = 0
	offset as uinteger
#else
	offset as const ubyte ptr
#endif
#else
	offset(0 to QLZ_POINTERS-1) as const ubyte ptr
#endif
end type

type qlz_hash_decompress
#if QLZ_COMPRESSION_LEVEL = 1
	offset as const ubyte ptr
#else
	offset(0 to QLZ_POINTERS-1) as const ubyte ptr
#endif
end type

' states
type qlz_state_compress
#if QLZ_STREAMING_BUFFER > 0
	stream_buffer(0 to QLZ_STREAMING_BUFFER-1) as ubyte
#endif
	stream_counter as size_t
	hash(0 to QLZ_HASH_VALUES-1) as qlz_hash_compress
	hash_counter(0 to QLZ_HASH_VALUES-1) as ubyte
end type

#if QLZ_COMPRESSION_LEVEL = 1 or QLZ_COMPRESSION_LEVEL = 2
	type qlz_state_decompress
#if QLZ_STREAMING_BUFFER > 0
		stream_buffer(0 to QLZ_STREAMING_BUFFER-1) as ubyte
#endif
		hash(0 to QLZ_HASH_VALUES-1) as qlz_hash_decompress
		hash_counter(0 to QLZ_HASH_VALUES-1) as ubyte
		stream_counter as size_t
	end type
#elseif QLZ_COMPRESSION_LEVEL = 3
	type qlz_state_decompress
#if QLZ_STREAMING_BUFFER > 0
		stream_buffer(0 to QLZ_STREAMING_BUFFER-1) as ubyte
#endif
#if QLZ_COMPRESSION_LEVEL <= 2
		hash(0 to QLZ_HASH_VALUES-1) as qlz_hash_decompress
#endif
		stream_counter as size_t
	end type
#endif

extern "C"

' Public functions of QuickLZ
declare function qlz_size_decompressed(byval source as const ubyte ptr) as size_t
declare function qlz_size_compressed(byval source as const ubyte ptr) as size_t
declare function qlz_compress(byval source as const any ptr, byval destination as const ubyte ptr, byval size as size_t, byval state as qlz_state_compress ptr) as size_t
declare function qlz_decompress(byval source as const ubyte ptr, byval destination as any ptr, byval state as qlz_state_decompress ptr) as size_t
declare function qlz_get_setting(byval setting as integer) as integer

end extern

#endif
