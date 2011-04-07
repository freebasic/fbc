#ifndef __lzoconf_bi__
#define __lzoconf_bi__

#inclib "lzo2"

#define LZO_VERSION_             &h2020
#define LZO_VERSION_STRING_      "2.02"
#define LZO_VERSION_DATE_        "Oct 17 2005"

#include "crt/limits.bi"
#include "crt/stddef.bi"

extern "C"

type lzo_uint as uinteger
type lzo_int as integer
#define LZO_UINT_MAX UINT_MAX
#define LZO_INT_MAX INT_MAX
#define LZO_INT_MIN INT_MIN

type lzo_uint32 as uinteger
type lzo_int32 as integer
#define LZO_UINT32_MAX UINT_MAX
#define LZO_INT32_MAX INT_MAX
#define LZO_INT32_MIN INT_MIN

#if (LZO_UINT_MAX >= LZO_UINT32_MAX)
#  define lzo_xint lzo_uint
#else
#  define lzo_xint lzo_uint32
#endif

type lzo_bytep as ubyte ptr
type lzo_charp as byte ptr
type lzo_voidp as any ptr
type lzo_shortp as short ptr
type lzo_ushortp as ushort ptr
type lzo_uint32p as lzo_uint32 ptr
type lzo_int32p as lzo_int32 ptr
type lzo_uintp as lzo_uint ptr
type lzo_intp as lzo_int ptr
type lzo_xintp as lzo_xint ptr
type lzo_voidpp as lzo_voidp ptr
type lzo_bytepp as lzo_bytep ptr

type lzo_bool as integer

type lzo_compress_t as function cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, _
                                       byval dst as lzo_bytep, byval dst_len as lzo_uintp, _
                                       byval wrkmem as lzo_voidp) as integer

type lzo_decompress_t as function cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, _
                                         byval dst as lzo_bytep, byval dst_len as lzo_uintp, _
                                         byval wrkmem as lzo_voidp) as integer

type lzo_optimize_t as function cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, _
                                       byval dst as lzo_bytep, byval dst_len as lzo_uintp, _
                                       byval wrkmem as lzo_voidp) as integer

type lzo_compress_dict_t as function cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, _
                                            byval dst as lzo_bytep, byval dst_len as lzo_uintp, _
                                            byval wrkmem as lzo_voidp, _
                                            byval dict as lzo_bytep, byval dict_len as lzo_uint) as integer

type lzo_decompress_dict_t as function cdecl (byval src as lzo_bytep, byval src_len as lzo_uint, _
                                              byval dst as lzo_bytep, byval dst_len as lzo_uintp, _
                                              byval wrkmem as lzo_voidp, _
                                              byval dict as lzo_bytep, byval dict_len as lzo_uint) as integer

type lzo_callback_t as lzo_callback_t_
type lzo_callback_p as lzo_callback_t ptr

type lzo_alloc_func_t as function cdecl (byval self as lzo_callback_p, byval items as lzo_uint, byval size as lzo_uint) as lzo_voidp
type lzo_free_func_t as sub cdecl (byval self as lzo_callback_p, byval p as lzo_voidp)

type lzo_progress_func_t as sub cdecl (byval as lzo_callback_p, byval as lzo_uint, byval as lzo_uint, byval as integer)

type lzo_callback_t_
	nalloc as lzo_alloc_func_t
	nfree as lzo_free_func_t
	
	nprogress as lzo_progress_func_t
	
	user1 as lzo_voidp
	user2 as lzo_xint
	user3 as lzo_xint
end type

const LZO_E_OK = 0
const LZO_E_ERROR = -1
const LZO_E_OUT_OF_MEMORY = -2
const LZO_E_NOT_COMPRESSIBLE = -3
const LZO_E_INPUT_OVERRUN = -4
const LZO_E_OUTPUT_OVERRUN = -5
const LZO_E_LOOKBEHIND_OVERRUN = -6
const LZO_E_EOF_NOT_FOUND = -7
const LZO_E_INPUT_NOT_CONSUMED = -8
const LZO_E_NOT_YET_IMPLEMENTED = -9

#ifndef lzo_sizeof_dict_t
#  define lzo_sizeof_dict_t     sizeof(lzo_bytep)
#endif

#define lzo_init() __lzo_init_v2(LZO_VERSION_,sizeof(short),sizeof(integer),sizeof(long),sizeof(lzo_uint32),sizeof(lzo_uint),lzo_sizeof_dict_t,sizeof(byte ptr),sizeof(lzo_voidp),sizeof(lzo_callback_t))

declare function __lzo_init_v2 cdecl (byval as uinteger, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer

declare function lzo_version cdecl () as uinteger
declare function lzo_version_string cdecl () as zstring ptr
declare function lzo_version_date cdecl () as zstring ptr
declare function _lzo_version_string cdecl () as lzo_charp
declare function _lzo_version_date cdecl () as lzo_charp

declare function lzo_memcmp cdecl (byval as lzo_voidp, byval as lzo_voidp, byval as lzo_uint) as integer
declare function lzo_memcpy cdecl (byval as lzo_voidp, byval as lzo_voidp, byval as lzo_uint) as lzo_voidp
declare function lzo_memmove cdecl (byval as lzo_voidp, byval as lzo_voidp, byval as lzo_uint) as lzo_voidp
declare function lzo_memset cdecl (byval as lzo_voidp, byval as integer, byval as lzo_uint) as lzo_voidp

declare function lzo_adler32 cdecl (byval _adler as lzo_uint32, byval _buf as lzo_bytep, byval _len as lzo_uint) as lzo_uint32
declare function lzo_crc32 cdecl (byval _c as lzo_uint32, byval _buf as lzo_bytep, byval _len as lzo_uint) as lzo_uint32
declare function lzo_get_crc32_table cdecl () as lzo_uint32p

declare function _lzo_config_check cdecl () as integer

union __lzo_pu_u
	p as lzo_bytep
	u as lzo_uint
end union
union __lzo_pu32_u
	p as lzo_bytep
	u as lzo_uint32
end union
union lzo_align_t
	vp as any ptr
	bp as lzo_bytep
	u32 as lzo_uint32
	l as long
end union

declare function __lzo_align_gap cdecl (byval as lzo_voidp, byval as lzo_uint) as uinteger
#define LZO_PTR_ALIGN_UP(_ptr,_size) ((_ptr) + (lzo_uint) __lzo_align_gap(cast(lzo_voidp, _ptr),cast(lzo_uint, _size)))

end extern

#endif

