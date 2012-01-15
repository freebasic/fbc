''
''
'' allegro\color -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_color_bi__
#define __allegro_inline_color_bi__

#include once "allegro/color.bi"

declare function makecol15 cdecl alias "makecol15" (byval r as integer, byval g as integer, byval b as integer) as integer
declare function makecol16 cdecl alias "makecol16" (byval r as integer, byval g as integer, byval b as integer) as integer
declare function makecol24 cdecl alias "makecol24" (byval r as integer, byval g as integer, byval b as integer) as integer
declare function makecol32 cdecl alias "makecol32" (byval r as integer, byval g as integer, byval b as integer) as integer
declare function makeacol32 cdecl alias "makeacol32" (byval r as integer, byval g as integer, byval b as integer, byval a as integer) as integer
declare function getr8 cdecl alias "getr8" (byval c as integer) as integer
declare function getg8 cdecl alias "getg8" (byval c as integer) as integer
declare function getb8 cdecl alias "getb8" (byval c as integer) as integer
declare function getr15 cdecl alias "getr15" (byval c as integer) as integer
declare function getg15 cdecl alias "getg15" (byval c as integer) as integer
declare function getb15 cdecl alias "getb15" (byval c as integer) as integer
declare function getr16 cdecl alias "getr16" (byval c as integer) as integer
declare function getg16 cdecl alias "getg16" (byval c as integer) as integer
declare function getb16 cdecl alias "getb16" (byval c as integer) as integer
declare function getr24 cdecl alias "getr24" (byval c as integer) as integer
declare function getg24 cdecl alias "getg24" (byval c as integer) as integer
declare function getb24 cdecl alias "getb24" (byval c as integer) as integer
declare function getr32 cdecl alias "getr32" (byval c as integer) as integer
declare function getg32 cdecl alias "getg32" (byval c as integer) as integer
declare function getb32 cdecl alias "getb32" (byval c as integer) as integer
declare function geta32 cdecl alias "geta32" (byval c as integer) as integer
#ifndef _set_color
declare sub _set_color cdecl alias "_set_color" (byval index as integer, byval p as RGB ptr)
#endif

#endif
