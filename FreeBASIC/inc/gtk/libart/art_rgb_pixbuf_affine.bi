''
''
'' art_rgb_pixbuf_affine -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_rgb_pixbuf_affine_bi__
#define __art_rgb_pixbuf_affine_bi__

#include once "art_filterlevel.bi"
#include once "art_alphagamma.bi"
#include once "art_pixbuf.bi"

declare sub art_rgb_pixbuf_affine (byval dst as art_u8 ptr, byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer, byval dst_rowstride as integer, byval pixbuf as ArtPixBuf ptr, byval affine as double ptr, byval level as ArtFilterLevel, byval alphagamma as ArtAlphaGamma ptr)

#endif
