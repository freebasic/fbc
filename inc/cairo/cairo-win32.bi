'' FreeBASIC binding for cairo-1.14.2
''
'' based on the C header files:
''   cairo - a vector graphics library with display and print output
''
''   Copyright © 2002 University of Southern California
''   Copyright © 2005 Red Hat, Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it either under the terms of the GNU Lesser General Public
''   License version 2.1 as published by the Free Software Foundation
''   (the "LGPL") or, at your option, under the terms of the Mozilla
''   Public License Version 1.1 (the "MPL"). If you do not alter this
''   notice, a recipient may use your version of this file under either
''   the MPL or the LGPL.
''
''   You should have received a copy of the LGPL along with this library
''   in the file COPYING-LGPL-2.1; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
''   You should have received a copy of the MPL along with this library
''   in the file COPYING-MPL-1.1
''
''   The contents of this file are subject to the Mozilla Public License
''   Version 1.1 (the "License"); you may not use this file except in
''   compliance with the License. You may obtain a copy of the License at
''   http://www.mozilla.org/MPL/
''
''   This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
''   OF ANY KIND, either express or implied. See the LGPL or the MPL for
''   the specific language governing rights and limitations.
''
''   The Original Code is the cairo graphics library.
''
''   The Initial Developer of the Original Code is University of Southern
''   California.
''
''   Contributor(s):
''   Carl D. Worth <cworth@cworth.org>
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

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
