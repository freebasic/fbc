''
''
'' art_svp_vpath_stroke -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_vpath_stroke_bi__
#define __art_svp_vpath_stroke_bi__

#include once "art_svp.bi"
#include once "art_vpath.bi"

enum ArtPathStrokeJoinType
	ART_PATH_STROKE_JOIN_MITER
	ART_PATH_STROKE_JOIN_ROUND
	ART_PATH_STROKE_JOIN_BEVEL
end enum


enum ArtPathStrokeCapType
	ART_PATH_STROKE_CAP_BUTT
	ART_PATH_STROKE_CAP_ROUND
	ART_PATH_STROKE_CAP_SQUARE
end enum


declare function art_svp_vpath_stroke (byval vpath as ArtVpath ptr, byval join as ArtPathStrokeJoinType, byval cap as ArtPathStrokeCapType, byval line_width as double, byval miter_limit as double, byval flatness as double) as ArtSVP ptr
declare function art_svp_vpath_stroke_raw (byval vpath as ArtVpath ptr, byval join as ArtPathStrokeJoinType, byval cap as ArtPathStrokeCapType, byval line_width as double, byval miter_limit as double, byval flatness as double) as ArtVpath ptr

#endif
