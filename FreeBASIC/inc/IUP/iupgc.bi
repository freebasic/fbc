''
''
'' iupgc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __iupgc_bi__
#define __iupgc_bi__

declare sub IupGetColorOpen cdecl alias "IupGetColorOpen" ()
declare function IupGetColor cdecl alias "IupGetColor" (byval x as integer, byval y as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr) as integer

#endif
