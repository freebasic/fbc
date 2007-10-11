''
''
'' cairo-ps -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cairo_ps_bi__
#define __cairo_ps_bi__

#include once "cairo.bi"

extern "c"

declare function cairo_ps_surface_create (byval filename as zstring ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare function cairo_ps_surface_create_for_stream (byval write_func as cairo_write_func_t, byval closure as any ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare sub cairo_ps_surface_set_size (byval surface as cairo_surface_t ptr, byval width_in_points as double, byval height_in_points as double)
declare sub cairo_ps_surface_dsc_comment (byval surface as cairo_surface_t ptr, byval comment as zstring ptr)
declare sub cairo_ps_surface_dsc_begin_setup (byval surface as cairo_surface_t ptr)
declare sub cairo_ps_surface_dsc_begin_page_setup (byval surface as cairo_surface_t ptr)

end extern

#endif
