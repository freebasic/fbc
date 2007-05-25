'QuickLZ Fast Compression
'Translated headers for FreeBASIC by sir_mud @ www.aknerd.com
'QuickLZ only needs extra memory for compression.
'When compressing make the destination buffer (size_of_data + 36000)
'If using the packet compression, the buffer size is + 400
'Or just use the macros included here:

#inclib "quicklz"

extern "C"
declare function qlz_compress alias "qlz_compress" (source as any ptr, destination as ubyte ptr, size as uinteger) as uinteger
declare function qlz_decompress alias "qlz_decompress" ( source as ubyte ptr, destination as any ptr) as uinteger
declare function qlz_size_decompressed alias "qlz_size_decompressed" ( source as ubyte ptr ) as uinteger
declare function qlz_size_compressed alias "qlz_size_compressed" ( source as ubyte ptr ) as uinteger
declare function qlz_compress_packet alias "qlz_compress_packet" ( source as any ptr, destination as ubyte ptr, size as uinteger, buffer as ubyte ptr) as uinteger
declare function qlz_decompress_packet alias "qlz_decompress_packet" ( source as ubyte ptr, destination as any ptr, buffer as ubyte ptr) as uinteger
end extern

#define QLZ_BUFFER_SIZE(x) ((x) + 36000)
#define QLZ_PACKET_SIZE(x) ((x) + 400)
