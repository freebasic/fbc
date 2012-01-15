''
''
'' art_rgb_svp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_rgb_svp_bi__
#define __art_rgb_svp_bi__

#include once "art_alphagamma.bi"
#include once "art_svp.bi"

declare sub art_rgb_svp_aa (byval svp as ArtSVP ptr, byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer, byval fg_color as art_u32, byval bg_color as art_u32, byval buf as art_u8 ptr, byval rowstride as integer, byval alphagamma as ArtAlphaGamma ptr)
declare sub art_rgb_svp_alpha (byval svp as ArtSVP ptr, byval x0 as integer, byval y0 as integer, byval x1 as integer, byval y1 as integer, byval rgba as art_u32, byval buf as art_u8 ptr, byval rowstride as integer, byval alphagamma as ArtAlphaGamma ptr)

#endif
