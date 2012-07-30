''
''
'' art_svp_wind -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_wind_bi__
#define __art_svp_wind_bi__

#include once "art_svp.bi"

enum ArtWindRule
	ART_WIND_RULE_NONZERO
	ART_WIND_RULE_INTERSECT
	ART_WIND_RULE_ODDEVEN
	ART_WIND_RULE_POSITIVE
end enum


declare function art_svp_uncross (byval vp as ArtSVP ptr) as ArtSVP ptr
declare function art_svp_rewind_uncrossed (byval vp as ArtSVP ptr, byval rule as ArtWindRule) as ArtSVP ptr

#endif
