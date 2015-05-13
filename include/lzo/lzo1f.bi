#ifndef __lzo1f_bi__
#define __lzo1f_bi__

#include once "lzo/lzoconf.bi"

extern "C"

#define LZO1F_MEM_COMPRESS       (cast(lzo_uint32, 8192L * lzo_sizeof_dict_t))
#define LZO1F_MEM_DECOMPRESS     (0)

declare function lzo1f_decompress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1f_decompress_safe cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

declare function lzo1f_1_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1F_999_MEM_COMPRESS  (cast(lzo_uint32, 5 * 16384L * sizeof(short)))

declare function lzo1f_999_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

end extern

#endif
