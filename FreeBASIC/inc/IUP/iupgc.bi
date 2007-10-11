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

extern "c"
declare sub IupGetColorOpen ()
declare function IupGetColor (byval x as integer, byval y as integer, byval r as ubyte ptr, byval g as ubyte ptr, byval b as ubyte ptr) as integer
end extern

#endif
