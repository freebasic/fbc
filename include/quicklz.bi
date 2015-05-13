/'
QuickLZ 1.50 data compression library

Copyright (C) 2006-2007 Lasse Mikkel Reinhold
lar@quicklz.com

QuickLZ can be used for free under the GPL-1 or GPL-2 or GPL-3 license (where anything 
released into public must be open source) or under a commercial license if such 
has been acquired (see http://www.quicklz.com/order.html). The commercial license 
does not cover derived or ported versions created by third parties under GPL.

FreeBASIC Port note:
Use the qlz_get_setting function along with the QLZ_SETTINGS enum to interogate
the library version used for compile time constants and getting the size of the 
required state opaque objects for compress and decompress.
'/

#inclib "quicklz"

#define QLZ_VERSION_MAJOR 1
#define QLZ_VERSION_MINOR 5
#define QLZ_VERSION_REVISION 0

enum QLZ_SETTINGS
	QLZ_COMPRESSION_LEVEL = 0
	QLZ_COMPRESS_STATE_SIZE
	QLZ_DECOMPRESS_STATE_SIZE
	QLZ_STREAMING_BUFFER
	QLZ_MEMOMRY_SAFE
	QLZ_LIB_VERSION_MAJOR
	QLZ_LIB_VERSION_MINOR
	QLZ_LIB_VERSION_REVISION
end enum

extern "C"
declare function qlz_compress (byval source as any ptr, byval destination as ubyte ptr, byval size as uinteger, byval state as any ptr) as uinteger
declare function qlz_decompress ( byval source as ubyte ptr, byval destination as any ptr, bvyal state as any ptr) as uinteger
declare function qlz_size_decompressed ( byval source as ubyte ptr ) as uinteger
declare function qlz_size_compressed ( byval source as ubyte ptr ) as uinteger
declare function qlz_get_setting( byval setting as QLZ_SETTINGS ) as integer
end extern
