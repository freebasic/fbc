'' FreeBASIC binding for cairo-1.14.2

#pragma once

#include once "cairo.bi"
#include once "windows.bi"

extern "C"

#define _CAIRO_WIN32_H_
declare function cairo_win32_surface_create(byval hdc as HDC) as cairo_surface_t ptr
declare function cairo_win32_printing_surface_create(byval hdc as HDC) as cairo_surface_t ptr
declare function cairo_win32_surface_create_with_ddb(byval hdc as HDC, byval format as cairo_format_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function cairo_win32_surface_create_with_dib(byval format as cairo_format_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function cairo_win32_surface_get_dc(byval surface as cairo_surface_t ptr) as HDC
declare function cairo_win32_surface_get_image(byval surface as cairo_surface_t ptr) as cairo_surface_t ptr
declare function cairo_win32_font_face_create_for_logfontw(byval logfont as LOGFONTW ptr) as cairo_font_face_t ptr
declare function cairo_win32_font_face_create_for_hfont(byval font as HFONT) as cairo_font_face_t ptr
declare function cairo_win32_font_face_create_for_logfontw_hfont(byval logfont as LOGFONTW ptr, byval font as HFONT) as cairo_font_face_t ptr
declare function cairo_win32_scaled_font_select_font(byval scaled_font as cairo_scaled_font_t ptr, byval hdc as HDC) as cairo_status_t
declare sub cairo_win32_scaled_font_done_font(byval scaled_font as cairo_scaled_font_t ptr)
declare function cairo_win32_scaled_font_get_metrics_factor(byval scaled_font as cairo_scaled_font_t ptr) as double
declare sub cairo_win32_scaled_font_get_logical_to_device(byval scaled_font as cairo_scaled_font_t ptr, byval logical_to_device as cairo_matrix_t ptr)
declare sub cairo_win32_scaled_font_get_device_to_logical(byval scaled_font as cairo_scaled_font_t ptr, byval device_to_logical as cairo_matrix_t ptr)

end extern
