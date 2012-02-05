' This is file cairo-win32.bi
' (FreeBasic binding for cairo library version 1.10.2)
'
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
' Original license text:

/' cairo - a vector graphics library with display and print output
 *
 * Copyright © 2005 Red Hat, Inc
 *
 * This library is free software; you can redistribute it and/or
 * modify it either under the terms of the GNU Lesser General Public
 * License version 2.1 as published by the Free Software Foundation
 * (the "LGPL") or, at your option, under the terms of the Mozilla
 * Public License Version 1.1 (the "MPL"). If you do not alter this
 * notice, a recipient may use your version of this file under either
 * the MPL or the LGPL.
 *
 * You should have received a copy of the LGPL along with this library
 * in the file COPYING-LGPL-2.1; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Suite 500, Boston, MA 02110-1335, USA
 * You should have received a copy of the MPL along with this library
 * in the file COPYING-MPL-1.1
 *
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * This software is distributed on an "AS IS" basis, WITHOUT WARRANTY
 * OF ANY KIND, either express or implied. See the LGPL or the MPL for
 * the specific language governing rights and limitations.
 *
 * The Original Code is the cairo graphics library.
 *
 * The Initial Developer of the Original Code is Red Hat, Inc.
 *
 * Contributor(s):
 *  Owen Taylor <otaylor@redhat.com>
 '/

#IFNDEF _CAIRO_WIN32_H_
#DEFINE _CAIRO_WIN32_H_
#INCLUDE ONCE "cairo.bi"

EXTERN "C"

#IF CAIRO_HAS_WIN32_SURFACE
#INCLUDE ONCE "windows.bi"

DECLARE FUNCTION cairo_win32_surface_create CDECL(BYVAL AS HDC) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_win32_printing_surface_create CDECL(BYVAL AS HDC) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_win32_surface_create_with_ddb CDECL(BYVAL AS HDC, BYVAL AS cairo_format_t, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_win32_surface_create_with_dib CDECL(BYVAL AS cairo_format_t, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_win32_surface_get_dc CDECL(BYVAL AS cairo_surface_t PTR) AS HDC
DECLARE FUNCTION cairo_win32_surface_get_image CDECL(BYVAL AS cairo_surface_t PTR) AS cairo_surface_t PTR

#IF CAIRO_HAS_WIN32_FONT

DECLARE FUNCTION cairo_win32_font_face_create_for_logfontw CDECL(BYVAL AS LOGFONTW PTR) AS cairo_font_face_t PTR
DECLARE FUNCTION cairo_win32_font_face_create_for_hfont CDECL(BYVAL AS HFONT) AS cairo_font_face_t PTR
DECLARE FUNCTION cairo_win32_font_face_create_for_logfontw_hfont CDECL(BYVAL AS LOGFONTW PTR, BYVAL AS HFONT) AS cairo_font_face_t PTR
DECLARE FUNCTION cairo_win32_scaled_font_select_font CDECL(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS HDC) AS cairo_status_t
DECLARE SUB cairo_win32_scaled_font_done_font CDECL(BYVAL AS cairo_scaled_font_t PTR)
DECLARE FUNCTION cairo_win32_scaled_font_get_metrics_factor CDECL(BYVAL AS cairo_scaled_font_t PTR) AS DOUBLE
DECLARE SUB cairo_win32_scaled_font_get_logical_to_device CDECL(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_matrix_t PTR)
DECLARE SUB cairo_win32_scaled_font_get_device_to_logical CDECL(BYVAL AS cairo_scaled_font_t PTR, BYVAL AS cairo_matrix_t PTR)

#ENDIF

#ELSE
#ERROR Cairo was not compiled with support for the win32 backend
#ENDIF

END EXTERN

#ENDIF
