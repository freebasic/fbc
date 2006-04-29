''
''
'' allegro\3dmaths -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __allegro_3dmaths_bi__
#define __allegro_3dmaths_bi__

#include once "allegro/base.bi"
#include once "allegro/fixed.bi"

declare function vector_length cdecl alias "vector_length" (byval x as fixed, byval y as fixed, byval z as fixed) as fixed
declare function vector_length_f cdecl alias "vector_length_f" (byval x as single, byval y as single, byval z as single) as single
declare sub normalize_vector cdecl alias "normalize_vector" (byval x as fixed ptr, byval y as fixed ptr, byval z as fixed ptr)
declare sub normalize_vector_f cdecl alias "normalize_vector_f" (byval x as single ptr, byval y as single ptr, byval z as single ptr)
declare sub cross_product cdecl alias "cross_product" (byval x1 as fixed, byval y1 as fixed, byval z1 as fixed, byval x2 as fixed, byval y2 as fixed, byval z2 as fixed, byval xout as fixed ptr, byval yout as fixed ptr, byval zout as fixed ptr)
declare sub cross_product_f cdecl alias "cross_product_f" (byval x1 as single, byval y1 as single, byval z1 as single, byval x2 as single, byval y2 as single, byval z2 as single, byval xout as single ptr, byval yout as single ptr, byval zout as single ptr)

extern _AL_DLL _persp_xscale alias "_persp_xscale" as fixed
extern _AL_DLL _persp_yscale alias "_persp_yscale" as fixed
extern _AL_DLL _persp_xoffset alias "_persp_xoffset" as fixed
extern _AL_DLL _persp_yoffset alias "_persp_yoffset" as fixed
extern _AL_DLL _persp_xscale_f alias "_persp_xscale_f" as single
extern _AL_DLL _persp_yscale_f alias "_persp_yscale_f" as single
extern _AL_DLL _persp_xoffset_f alias "_persp_xoffset_f" as single
extern _AL_DLL _persp_yoffset_f alias "_persp_yoffset_f" as single

declare sub set_projection_viewport cdecl alias "set_projection_viewport" (byval x as integer, byval y as integer, byval w as integer, byval h as integer)
declare sub quat_to_matrix cdecl alias "quat_to_matrix" (byval q as QUAT ptr, byval m as MATRIX_f ptr)
declare sub matrix_to_quat cdecl alias "matrix_to_quat" (byval m as MATRIX_f ptr, byval q as QUAT ptr)

#include once "allegro/inline/3dmaths.bi"

#endif
