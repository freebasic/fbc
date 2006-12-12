''
''
'' art_rgb_bitmap_affine -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_rgb_bitmap_affine_bi__
#define __art_rgb_bitmap_affine_bi__

#include once "art_filterlevel.bi"
#include once "art_alphagamma.bi"

declare sub art_rgb_bitmap_affine (byval dst as art_u8 ptr, byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer, byval dst_rowstride as integer, byval src as art_u8 ptr, byval src_width as integer, byval src_height as integer, byval src_rowstride as integer, byval rgba as art_u32, byval affine as double ptr, byval level as ArtFilterLevel, byval alphagamma as ArtAlphaGamma ptr)

#endif
