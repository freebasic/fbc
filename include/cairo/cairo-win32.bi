''
''
'' cairo-win32 -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __cairo_win32_bi__
#define __cairo_win32_bi__

#include once "cairo.bi"
#include once "windows.bi"

extern "c"

declare function cairo_win32_surface_create (byval hdc as HDC) as cairo_surface_t ptr
declare function cairo_win32_surface_create_with_dib (byval format as cairo_format_t, byval width as integer, byval height as integer) as cairo_surface_t ptr
declare function cairo_win32_surface_get_dc (byval surface as cairo_surface_t ptr) as HDC
#ifdef UNICODE
declare function cairo_win32_font_face_create_for_logfontw (byval logfont as LOGFONTW ptr) as cairo_font_face_t ptr
#endif
declare function cairo_win32_font_face_create_for_hfont (byval font as HFONT) as cairo_font_face_t ptr
declare function cairo_win32_scaled_font_select_font (byval scaled_font as cairo_scaled_font_t ptr, byval hdc as HDC) as cairo_status_t
declare sub cairo_win32_scaled_font_done_font (byval scaled_font as cairo_scaled_font_t ptr)
declare function cairo_win32_scaled_font_get_metrics_factor (byval scaled_font as cairo_scaled_font_t ptr) as double

end extern

#endif
