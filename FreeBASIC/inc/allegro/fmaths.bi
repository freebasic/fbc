''
''
'' allegro\fmaths -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_fmaths_bi__
#define __allegro_fmaths_bi__

#include once "allegro/base.bi"
#include once "allegro/fixed.bi"

declare function fixsqrt cdecl alias "fixsqrt" (byval x as fixed) as fixed
declare function fixhypot cdecl alias "fixhypot" (byval x as fixed, byval y as fixed) as fixed
declare function fixatan cdecl alias "fixatan" (byval x as fixed) as fixed
declare function fixatan2 cdecl alias "fixatan2" (byval y as fixed, byval x as fixed) as fixed

extern _AL_DLL _cos_tbl(0 to 255) alias "_cos_tbl" as fixed
extern _AL_DLL _tan_tbl(0 to 255) alias "_tan_tbl" as fixed
extern _AL_DLL _acos_tbl(0 to 255) alias "_acos_tbl" as fixed

#include once "allegro/inline/fmaths.bi"

#endif
