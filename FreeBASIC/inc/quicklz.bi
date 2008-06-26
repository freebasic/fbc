/'
QuickLZ 1.20 data compression library

Copyright (C) 2006-2007 Lasse Mikkel Reinhold
lar@quicklz.com

QuickLZ can be used for free under the GPL-1 or GPL-2 license (where anything 
released into public must be open source) or under a commercial license if such 
has been acquired (see http://www.quicklz.com/order.html). The commercial license 
does not cover derived or ported versions created by third parties under GPL.

Caution! qlz_compress expects the size of the destination buffer to be exactly 
"uncompressed size" + 36000 bytes or more and qlz_compress_packet expects 
"uncompressed size" + 400.

Translated headers for FreeBASIC by sir_mud @ www.aknerd.com
'/

#pragma once

#inclib "quicklz"

extern "C"
declare function qlz_compress alias "qlz_compress" (byval source as any ptr, byval destination as ubyte ptr, byval size as uinteger) as uinteger
declare function qlz_decompress alias "qlz_decompress" ( byval source as ubyte ptr, byval destination as any ptr) as uinteger
declare function qlz_size_decompressed alias "qlz_size_decompressed" ( byval source as ubyte ptr ) as uinteger
declare function qlz_size_compressed alias "qlz_size_compressed" ( byval source as ubyte ptr ) as uinteger
declare function qlz_compress_packet alias "qlz_compress_packet" ( byval source as any ptr, byval destination as ubyte ptr, byval size as uinteger, byval buffer as ubyte ptr) as uinteger
declare function qlz_decompress_packet alias "qlz_decompress_packet" ( byval source as ubyte ptr, byval destination as any ptr, byval buffer as ubyte ptr) as uinteger
end extern

#define QLZ_BUFFER_SIZE(x) ((x) + 36000)
#define QLZ_PACKET_SIZE(x) ((x) + 400)
