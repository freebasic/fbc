''
''
'' art_rect_uta -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_rect_uta_bi__
#define __art_rect_uta_bi__

#include once "art_rect.bi"
#include once "art_uta.bi"

declare function art_rect_list_from_uta (byval uta as ArtUta ptr, byval max_width as integer, byval max_height as integer, byval p_nrects as integer ptr) as ArtIRect ptr

#endif
