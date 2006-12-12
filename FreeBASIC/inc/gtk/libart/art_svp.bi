''
''
'' art_svp -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_bi__
#define __art_svp_bi__

#include once "art_rect.bi"
#include once "art_point.bi"

type ArtSVP as _ArtSVP
type ArtSVPSeg as _ArtSVPSeg

type _ArtSVPSeg
	n_points as integer
	dir as integer
	bbox as ArtDRect
	points as ArtPoint ptr
end type

type _ArtSVP
	n_segs as integer
	segs(0 to 1-1) as ArtSVPSeg
end type

declare function art_svp_add_segment (byval p_vp as ArtSVP ptr ptr, byval pn_segs_max as integer ptr, byval pn_points_max as integer ptr ptr, byval n_points as integer, byval dir as integer, byval points as ArtPoint ptr, byval bbox as ArtDRect ptr) as integer
declare sub art_svp_free (byval svp as ArtSVP ptr)
declare function art_svp_seg_compare (byval s1 as any ptr, byval s2 as any ptr) as integer

#endif
