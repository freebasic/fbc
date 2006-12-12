''
''
'' art_affine -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_affine_bi__
#define __art_affine_bi__

#include once "art_point.bi"

declare sub art_affine_point (byval dst as ArtPoint ptr, byval src as ArtPoint ptr, byval affine as double ptr)
declare sub art_affine_invert (byval dst_affine as double ptr, byval src_affine as double ptr)
declare sub art_affine_flip (byval dst_affine as double ptr, byval src_affine as double ptr, byval horz as integer, byval vert as integer)
declare sub art_affine_to_string (byval str as zstring ptr, byval src as double ptr)
declare sub art_affine_multiply (byval dst as double ptr, byval src1 as double ptr, byval src2 as double ptr)
declare sub art_affine_identity (byval dst as double ptr)
declare sub art_affine_scale (byval dst as double ptr, byval sx as double, byval sy as double)
declare sub art_affine_rotate (byval dst as double ptr, byval theta as double)
declare sub art_affine_shear (byval dst as double ptr, byval theta as double)
declare sub art_affine_translate (byval dst as double ptr, byval tx as double, byval ty as double)
declare function art_affine_expansion (byval src as double ptr) as double
declare function art_affine_rectilinear (byval src as double ptr) as integer
declare function art_affine_equal (byval matrix1 as double ptr, byval matrix2 as double ptr) as integer

#endif
