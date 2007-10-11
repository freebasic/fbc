''
''
'' art_alphagamma -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_alphagamma_bi__
#define __art_alphagamma_bi__

#include once "art_misc.bi"

type ArtAlphaGamma as _ArtAlphaGamma

type _ArtAlphaGamma
	gamma as double
	invtable_size as integer
	table(0 to 256-1) as integer
	invtable(0 to 1-1) as art_u8
end type

declare function art_alphagamma_new (byval gamma as double) as ArtAlphaGamma ptr
declare sub art_alphagamma_free (byval alphagamma as ArtAlphaGamma ptr)

#endif
