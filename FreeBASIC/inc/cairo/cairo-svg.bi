''
''
'' cairo-svg -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cairo_svg_bi__
#define __cairo_svg_bi__

#include once "cairo.bi"

enum cairo_svg_version_t
	CAIRO_SVG_VERSION_1_1
	CAIRO_SVG_VERSION_1_2
end enum

extern "c"

declare function cairo_svg_surface_create (byval filename as zstring ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare function cairo_svg_surface_create_for_stream (byval write_func as cairo_write_func_t, byval closure as any ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare sub cairo_svg_surface_restrict_to_version (byval surface as cairo_surface_t ptr, byval version as cairo_svg_version_t)
declare sub cairo_svg_get_versions (byval versions as cairo_svg_version_t ptr ptr, byval num_versions as integer ptr)
declare function cairo_svg_version_to_string (byval version as cairo_svg_version_t) as zstring ptr

end extern

#endif
