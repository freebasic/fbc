#ifndef __lzo1x_bi__
#define __lzo1x_bi__

#include once "lzo/lzoconf.bi"

extern "C"

#define LZO1X_MEM_COMPRESS      LZO1X_1_MEM_COMPRESS
#define LZO1X_MEM_DECOMPRESS    (0)
#define LZO1X_MEM_OPTIMIZE      (0)

declare function lzo1x_decompress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1x_decompress_safe cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1X_1_MEM_COMPRESS    (cast(lzo_uint32, 16384L * lzo_sizeof_dict_t))

declare function lzo1x_1_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1X_1_11_MEM_COMPRESS (cast(lzo_uint32, 2048L * lzo_sizeof_dict_t))

declare function lzo1x_1_11_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1X_1_12_MEM_COMPRESS (cast(lzo_uint32, 4096L * lzo_sizeof_dict_t))

declare function lzo1x_1_12_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1X_1_15_MEM_COMPRESS (cast(lzo_uint32, 32768L * lzo_sizeof_dict_t))

declare function lzo1x_1_15_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1X_999_MEM_COMPRESS  (cast(lzo_uint32, 14 * 16384L * sizeof(short)))

declare function lzo1x_999_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

declare function lzo1x_999_compress_dict cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval dict as lzo_bytep, byval dict_len as lzo_uint) as integer
                                   
declare function lzo1x_999_compress_level cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval dict as lzo_bytep, byval dict_len as lzo_uint, byval cb as lzo_callback_p, byval compression_level as integer) as integer

declare function lzo1x_999_compress_dict_safe cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval dict as lzo_bytep, byval dict_len as lzo_uint) as integer

declare function lzo1x_optimize cdecl  (byval in as lzo_bytep, byval in_len as lzo_uint, byval out_ as lzo_bytep, byval out_len as lzo_uintp, byval wrkmem as lzo_uintp) as integer

end extern

#endif
