''
''
'' art_rect -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_rect_bi__
#define __art_rect_bi__

type ArtDRect as _ArtDRect
type ArtIRect as _ArtIRect

type _ArtDRect
	x0 as double
	y0 as double
	x1 as double
	y1 as double
end type

type _ArtIRect
	x0 as integer
	y0 as integer
	x1 as integer
	y1 as integer
end type

declare sub art_irect_copy (byval dest as ArtIRect ptr, byval src as ArtIRect ptr)
declare sub art_irect_union (byval dest as ArtIRect ptr, byval src1 as ArtIRect ptr, byval src2 as ArtIRect ptr)
declare sub art_irect_intersect (byval dest as ArtIRect ptr, byval src1 as ArtIRect ptr, byval src2 as ArtIRect ptr)
declare function art_irect_empty (byval src as ArtIRect ptr) as integer
declare sub art_drect_copy (byval dest as ArtDRect ptr, byval src as ArtDRect ptr)
declare sub art_drect_union (byval dest as ArtDRect ptr, byval src1 as ArtDRect ptr, byval src2 as ArtDRect ptr)
declare sub art_drect_intersect (byval dest as ArtDRect ptr, byval src1 as ArtDRect ptr, byval src2 as ArtDRect ptr)
declare function art_drect_empty (byval src as ArtDRect ptr) as integer
declare sub art_drect_affine_transform (byval dst as ArtDRect ptr, byval src as ArtDRect ptr, byval matrix as double ptr)
declare sub art_drect_to_irect (byval dst as ArtIRect ptr, byval src as ArtDRect ptr)

#endif
