''
''
'' allegro\3dmaths -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_3dmaths_bi__
#define __allegro_inline_3dmaths_bi__

#include once "allegro/fixed.bi"

declare function dot_product cdecl alias "dot_product" (byval x1 as fixed, byval y1 as fixed, byval z1 as fixed, byval x2 as fixed, byval y2 as fixed, byval z2 as fixed) as fixed
declare function dot_product_f cdecl alias "dot_product_f" (byval x1 as single, byval y1 as single, byval z1 as single, byval x2 as single, byval y2 as single, byval z2 as single) as single
declare sub persp_project cdecl alias "persp_project" (byval x as fixed, byval y as fixed, byval z as fixed, byval xout as fixed ptr, byval yout as fixed ptr)
declare sub persp_project_f cdecl alias "persp_project_f" (byval x as single, byval y as single, byval z as single, byval xout as single ptr, byval yout as single ptr)

#endif
