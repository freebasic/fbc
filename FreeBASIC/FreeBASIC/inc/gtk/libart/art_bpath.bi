''
''
'' art_bpath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_bpath_bi__
#define __art_bpath_bi__

#include once "art_misc.bi"
#include once "art_point.bi"
#include once "art_pathcode.bi"

type ArtBpath as _ArtBpath

type _ArtBpath
	code as ArtPathcode
	x1 as double
	y1 as double
	x2 as double
	y2 as double
	x3 as double
	y3 as double
end type

declare function art_bpath_affine_transform (byval src as ArtBpath ptr, byval matrix as double ptr) as ArtBpath ptr

#endif
