#ifndef __lzo1c_bi__
#define __lzo1c_bi__

#include once "lzo/lzoconf.bi"

extern "C"

#define LZO1C_MEM_COMPRESS      (cast(lzo_uint32, 16384L * lzo_sizeof_dict_t))
#define LZO1C_MEM_DECOMPRESS    (0)

#define LZO1C_BEST_SPEED             1
#define LZO1C_BEST_COMPRESSION       9
#define LZO1C_DEFAULT_COMPRESSION  (-1)

declare function lzo1c_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval compression_level as integer) as integer
declare function lzo1c_decompress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_decompress_safe cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

declare function lzo1c_1_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_2_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_3_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_4_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_5_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_6_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_7_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_8_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1c_9_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1C_99_MEM_COMPRESS   (cast(lzo_uint32, 65536L * lzo_sizeof_dict_t))

declare function lzo1c_99_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1C_999_MEM_COMPRESS  (cast(lzo_uint32, 5 * 16384L * sizeof(short)))

declare function lzo1c_999_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

end extern

#endif
