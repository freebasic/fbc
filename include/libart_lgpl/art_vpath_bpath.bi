''
''
'' art_vpath_bpath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_vpath_bpath_bi__
#define __art_vpath_bpath_bi__

#include once "art_bpath.bi"
#include once "art_vpath.bi"

declare function art_bezier_to_vec (byval x0 as double, byval y0 as double, byval x1 as double, byval y1 as double, byval x2 as double, byval y2 as double, byval x3 as double, byval y3 as double, byval p as ArtPoint ptr, byval level as integer) as ArtPoint ptr
declare function art_bez_path_to_vec (byval bez as ArtBpath ptr, byval flatness as double) as ArtVpath ptr

#endif
