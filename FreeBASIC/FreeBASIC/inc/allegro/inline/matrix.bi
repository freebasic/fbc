''
''
'' allegro\matrix -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_inline_matrix_bi__
#define __allegro_inline_matrix_bi__

declare sub apply_matrix cdecl alias "apply_matrix" (byval m as MATRIX ptr, byval x as fixed, byval y as fixed, byval z as fixed, byval xout as fixed ptr, byval yout as fixed ptr, byval zout as fixed ptr)

#endif
