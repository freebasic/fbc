''
''
'' art_uta_vpath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_uta_vpath_bi__
#define __art_uta_vpath_bi__

#include once "art_uta.bi"
#include once "art_vpath.bi"

declare function art_uta_from_vpath (byval vec as ArtVpath ptr) as ArtUta ptr
declare sub art_uta_add_line (byval uta as ArtUta ptr, byval x0 as double, byval y0 as double, byval x1 as double, byval y1 as double, byval rbuf as integer ptr, byval rbuf_rowstride as integer)

#endif
