#ifndef __lzo1a_bi__
#define __lzo1a_bi__

#include once "lzo/lzoconf.bi"

extern "C"

#define LZO1A_MEM_COMPRESS       (cast(lzo_uint32, 8192L * lzo_sizeof_dict_t))
#define LZO1A_MEM_DECOMPRESS     (0)

declare function lzo1a_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer
declare function lzo1a_decompress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

#define LZO1A_99_MEM_COMPRESS    (cast(lzo_uint32, 65536L * lzo_sizeof_dict_t))

declare function lzo1a_99_compress cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uintp, byval wrkmem as lzo_voidp) as integer

end extern

#endif
