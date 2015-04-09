'' FreeBASIC binding for cairo-1.14.2

#pragma once

#include once "cairo.bi"

extern "C"

#define CAIRO_PDF_H

type _cairo_pdf_version as long
enum
	CAIRO_PDF_VERSION_1_4
	CAIRO_PDF_VERSION_1_5
end enum

type cairo_pdf_version_t as _cairo_pdf_version
declare function cairo_pdf_surface_create(byval filename as const zstring ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare function cairo_pdf_surface_create_for_stream(byval write_func as cairo_write_func_t, byval closure as any ptr, byval width_in_points as double, byval height_in_points as double) as cairo_surface_t ptr
declare sub cairo_pdf_surface_restrict_to_version(byval surface as cairo_surface_t ptr, byval version as cairo_pdf_version_t)
declare sub cairo_pdf_get_versions(byval versions as const cairo_pdf_version_t ptr ptr, byval num_versions as long ptr)
declare function cairo_pdf_version_to_string(byval version as cairo_pdf_version_t) as const zstring ptr
declare sub cairo_pdf_surface_set_size(byval surface as cairo_surface_t ptr, byval width_in_points as double, byval height_in_points as double)

end extern
