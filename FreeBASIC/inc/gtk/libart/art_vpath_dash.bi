''
''
'' art_vpath_dash -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_vpath_dash_bi__
#define __art_vpath_dash_bi__

#include once "art_vpath.bi"

type ArtVpathDash as _ArtVpathDash

type _ArtVpathDash
	offset as double
	n_dash as integer
	dash as double ptr
end type

declare function art_vpath_dash (byval vpath as ArtVpath ptr, byval dash as ArtVpathDash ptr) as ArtVpath ptr

#endif
