''
''
'' art_svp_vpath -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __art_svp_vpath_bi__
#define __art_svp_vpath_bi__

#include once "gtk/libart/art_svp.bi"
#include once "gtk/libart/art_vpath.bi"

declare function art_svp_from_vpath cdecl alias "art_svp_from_vpath" (byval vpath as ArtVpath ptr) as ArtSVP ptr

#endif
