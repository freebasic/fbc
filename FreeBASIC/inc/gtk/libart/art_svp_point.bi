''
''
'' art_svp_point -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_point_bi__
#define __art_svp_point_bi__

#include once "art_svp.bi"

declare function art_svp_point_wind (byval svp as ArtSVP ptr, byval x as double, byval y as double) as integer
declare function art_svp_point_dist (byval svp as ArtSVP ptr, byval x as double, byval y as double) as double

#endif
