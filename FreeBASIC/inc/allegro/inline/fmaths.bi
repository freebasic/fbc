''
''
'' allegro\fmaths -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_fmaths_bi__
#define __allegro_inline_fmaths_bi__

#define ALLEGRO_IMPORT_MATH_ASM
#include once "allegro/inline/asm.bi"
#undef ALLEGRO_IMPORT_MATH_ASM

declare function ftofix cdecl alias "ftofix" (byval x as double) as fixed
declare function fixtof cdecl alias "fixtof" (byval x as fixed) as double
declare function itofix cdecl alias "itofix" (byval x as integer) as fixed
declare function fixtoi cdecl alias "fixtoi" (byval x as fixed) as integer
declare function fixcos cdecl alias "fixcos" (byval x as fixed) as fixed
declare function fixsin cdecl alias "fixsin" (byval x as fixed) as fixed
declare function fixtan cdecl alias "fixtan" (byval x as fixed) as fixed
declare function fixacos cdecl alias "fixacos" (byval x as fixed) as fixed
declare function fixasin cdecl alias "fixasin" (byval x as fixed) as fixed

#endif
