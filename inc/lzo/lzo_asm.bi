'' FreeBASIC binding for lzo-2.09
''
'' based on the C header files:
''   lzo_asm.h -- assembler prototypes for the LZO data compression library
''
''   This file is part of the LZO real-time data compression library.
''
''   Copyright (C) 1996-2015 Markus Franz Xaver Johannes Oberhumer
''   All Rights Reserved.
''
''   The LZO library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU General Public License as
''   published by the Free Software Foundation; either version 2 of
''   the License, or (at your option) any later version.
''
''   The LZO library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with the LZO library; see the file COPYING.
''   If not, write to the Free Software Foundation, Inc.,
''   51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
''
''   Markus F.X.J. Oberhumer
''   <markus@oberhumer.com>
''   http://www.oberhumer.com/opensource/lzo/
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "lzo/lzoconf.bi"

extern "C"

const __LZO_ASM_H_INCLUDED = 1
declare function lzo1c_decompress_asm(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1c_decompress_asm_safe(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1f_decompress_asm_fast(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1f_decompress_asm_fast_safe(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1x_decompress_asm(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1x_decompress_asm_safe(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1x_decompress_asm_fast(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1x_decompress_asm_fast_safe(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1y_decompress_asm(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1y_decompress_asm_safe(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1y_decompress_asm_fast(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long
declare function lzo1y_decompress_asm_fast_safe(byval src as const lzo_bytep, byval src_len as lzo_uint, byval dst as lzo_bytep, byval dst_len as lzo_uint ptr, byval wrkmem as lzo_voidp) as long

end extern
