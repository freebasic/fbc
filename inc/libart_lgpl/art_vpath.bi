''
''
'' art_vpath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_vpath_bi__
#define __art_vpath_bi__

#include once "art_rect.bi"
#include once "art_pathcode.bi"

type ArtVpath as _ArtVpath

type _ArtVpath
	code as ArtPathcode
	x as double
	y as double
end type

declare sub art_vpath_add_point (byval p_vpath as ArtVpath ptr ptr, byval pn_points as integer ptr, byval pn_points_max as integer ptr, byval code as ArtPathcode, byval x as double, byval y as double)
declare function art_vpath_new_circle (byval x as double, byval y as double, byval r as double) as ArtVpath ptr
declare function art_vpath_affine_transform (byval src as ArtVpath ptr, byval matrix as double ptr) as ArtVpath ptr
declare sub art_vpath_bbox_drect (byval vec as ArtVpath ptr, byval drect as ArtDRect ptr)
declare sub art_vpath_bbox_irect (byval vec as ArtVpath ptr, byval irect as ArtIRect ptr)
declare function art_vpath_perturb (byval src as ArtVpath ptr) as ArtVpath ptr

#endif
