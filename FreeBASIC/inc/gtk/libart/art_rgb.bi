''
''
'' art_rgb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_rgb_bi__
#define __art_rgb_bi__

#include once "art_misc.bi"

declare sub art_rgb_fill_run (byval buf as art_u8 ptr, byval r as art_u8, byval g as art_u8, byval b as art_u8, byval n as integer)
declare sub art_rgb_run_alpha (byval buf as art_u8 ptr, byval r as art_u8, byval g as art_u8, byval b as art_u8, byval alpha as integer, byval n as integer)

#endif
