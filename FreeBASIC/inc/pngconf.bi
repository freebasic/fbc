''
''
'' pngconf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pngconf_bi__
#define __pngconf_bi__

#define PNG_ZBUF_SIZE 8192

#include once "crt/stdio.bi"
#include once "crt/sys/types.bi"
#include once "crt/setjmp.bi"
#include once "crt/string.bi"

#define PNG_USER_WIDTH_MAX 1000000L
#define PNG_USER_HEIGHT_MAX 1000000L

#include once "crt/time.bi"

type png_uint_32 as uinteger
type png_int_32 as integer
type png_uint_16 as ushort
type png_int_16 as short
type png_byte as ubyte
type png_size_t as size_t
type png_fixed_point as png_int_32
type png_voidp as any ptr
type png_bytep as png_byte ptr
type png_uint_32p as png_uint_32 ptr
type png_int_32p as png_int_32 ptr
type png_uint_16p as png_uint_16 ptr
type png_int_16p as png_int_16 ptr
type png_const_charp as byte ptr
type png_charp as byte ptr
type png_fixed_point_p as png_fixed_point ptr
type png_FILE_p as FILE ptr
type png_doublep as double ptr
type png_bytepp as png_byte ptr ptr
type png_uint_32pp as png_uint_32 ptr ptr
type png_int_32pp as png_int_32 ptr ptr
type png_uint_16pp as png_uint_16 ptr ptr
type png_int_16pp as png_int_16 ptr ptr
type png_const_charpp as byte ptr ptr
type png_charpp as byte ptr ptr
type png_fixed_point_pp as png_fixed_point ptr ptr
type png_doublepp as double ptr ptr
type png_charppp as byte ptr ptr ptr
type png_zcharp as charf ptr
type png_zcharpp as charf ptr ptr
type png_zstreamp as z_stream ptr

#endif
