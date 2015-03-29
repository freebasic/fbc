#pragma once

#include once "cairo.bi"
#include once "crt/stdio.bi"

extern "C"

#define CAIRO_PS_H

type _cairo_ps_level as long
enum
	CAIRO_PS_LEVEL_2
	CAIRO_PS_LEVEL_3
end enum

type cairo_ps_level_t as _cairo_ps_level
declare function cairo_ps_surface_create(byval filename as const zstring ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare function cairo_ps_surface_create_for_stream(byval write_func as cairo_write_func_t, byval closure as any ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare sub cairo_ps_surface_restrict_to_level(byval surface as cairo_surface_t ptr, byval level as cairo_ps_level_t)
declare sub cairo_ps_get_levels(byval levels as const cairo_ps_level_t ptr ptr, byval num_levels as long ptr)
declare function cairo_ps_level_to_string(byval level as cairo_ps_level_t) as const zstring ptr
declare sub cairo_ps_surface_set_eps(byval surface as cairo_surface_t ptr, byval eps as cairo_bool_t)
declare function cairo_ps_surface_get_eps(byval surface as cairo_surface_t ptr) as cairo_bool_t
declare sub cairo_ps_surface_set_size(byval surface as cairo_surface_t ptr, byval width_in_points as double, byval height_in_points as double)
declare sub cairo_ps_surface_dsc_comment(byval surface as cairo_surface_t ptr, byval comment as const zstring ptr)
declare sub cairo_ps_surface_dsc_begin_setup(byval surface as cairo_surface_t ptr)
declare sub cairo_ps_surface_dsc_begin_page_setup(byval surface as cairo_surface_t ptr)

end extern
