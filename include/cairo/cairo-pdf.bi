''
''
'' cairo-pdf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cairo_pdf_bi__
#define __cairo_pdf_bi__

#include once "cairo.bi"

extern "c"

declare function cairo_pdf_surface_create (byval filename as zstring ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare function cairo_pdf_surface_create_for_stream (byval write_func as cairo_write_func_t, byval closure as any ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare sub cairo_pdf_surface_set_size (byval surface as cairo_surface_t ptr, byval width_in_points as double, byval height_in_points as double)

end extern

#endif
