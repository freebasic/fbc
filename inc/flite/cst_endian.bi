''
''
'' cst_endian -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cst_endian_bi__
#define __cst_endian_bi__
extern cst_endian_loc alias "cst_endian_loc" as integer

#define BYTE_ORDER_BIG "10"
#define BYTE_ORDER_LITTLE "01"

declare sub swap_bytes_short cdecl alias "swap_bytes_short" (byval b as short ptr, byval n as integer)
declare sub swapdouble cdecl alias "swapdouble" (byval d as double ptr)
declare sub swapfloat cdecl alias "swapfloat" (byval f as single ptr)

#endif
