''
''
'' art_svp_ops -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_ops_bi__
#define __art_svp_ops_bi__

#include once "art_svp.bi"

declare function art_svp_union (byval svp1 as ArtSVP ptr, byval svp2 as ArtSVP ptr) as ArtSVP ptr
declare function art_svp_intersect (byval svp1 as ArtSVP ptr, byval svp2 as ArtSVP ptr) as ArtSVP ptr
declare function art_svp_diff (byval svp1 as ArtSVP ptr, byval svp2 as ArtSVP ptr) as ArtSVP ptr
declare function art_svp_minus (byval svp1 as ArtSVP ptr, byval svp2 as ArtSVP ptr) as ArtSVP ptr

#endif
