#ifndef __lzo1z_bi__
#define __lzo1z_bi__

#include once "lzo/lzoconf.bi"

extern "C"

#define LZO1Z_MEM_COMPRESS      (cast(lzo_uint32, 16384L * lzo_sizeof_dict_t))
#define LZO1Z_MEM_DECOMPRESS    (0)
#define LZO1Z_MEM_OPTIMIZE      (0)

declare function lzo1z_decompress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1z_decompress_safe cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#if 0
declare function lzo1z_1_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
#endif

#define LZO1Z_999_MEM_COMPRESS  ((lzo_uint32) (14 * 16384L * sizeof(short)))

declare function lzo1z_999_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

declare function lzo1z_999_compress_dict cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval dict as lzo_bytep, byval dict_len as lzo_uint) as integer
                                   
declare function lzo1z_999_compress_level cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval dict as lzo_bytep, byval dict_len as lzo_uint, byval cb as lzo_callback_p, byval compression_level as integer) as integer

declare function lzo1z_999_compress_dict_safe cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp, byval dict as lzo_bytep, byval dict_len as lzo_uint) as integer

#if 0
declare function lzo1z_optimize cdecl  (byval in as lzo_bytep, byval in_len as lzo_uint, byval out_ as lzo_bytep, byval out_len as lzo_uintp, byval wrkmem as lzo_uintp) as integer
#endif

end extern

#endif
