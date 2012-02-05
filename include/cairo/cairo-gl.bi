' This is file cairo-gl.bi
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

/' Cairo - a vector graphics library with display and print output
 *
 * Copyright © 2009 Eric Anholt
 * Copyright © 2009 Chris Wilson
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
 * The Initial Developer of the Original Code is Eric Anholt.
 '/

#IFNDEF CAIRO_GL_H
#DEFINE CAIRO_GL_H

#INCLUDE ONCE "cairo.bi"

EXTERN "C"

#IF CAIRO_HAS_GL_SURFACE

DECLARE FUNCTION cairo_gl_surface_create CDECL(BYVAL AS cairo_device_t PTR, BYVAL AS cairo_content_t, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE FUNCTION cairo_gl_surface_create_for_texture CDECL(BYVAL AS cairo_device_t PTR, BYVAL AS cairo_content_t, BYVAL AS UINTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE SUB cairo_gl_surface_set_size CDECL(BYVAL AS cairo_surface_t PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE FUNCTION cairo_gl_surface_get_width CDECL(BYVAL AS cairo_surface_t PTR) AS INTEGER
DECLARE FUNCTION cairo_gl_surface_get_height CDECL(BYVAL AS cairo_surface_t PTR) AS INTEGER
DECLARE SUB cairo_gl_surface_swapbuffers CDECL(BYVAL AS cairo_surface_t PTR)

#IF CAIRO_HAS_GLX_FUNCTIONS

#INCLUDE ONCE "GL/glx.bi"

DECLARE FUNCTION cairo_glx_device_create CDECL(BYVAL AS Display PTR, BYVAL AS GLXContext) AS cairo_device_t PTR
DECLARE FUNCTION cairo_glx_device_get_display CDECL(BYVAL AS cairo_device_t PTR) AS Display PTR
DECLARE FUNCTION cairo_glx_device_get_context CDECL(BYVAL AS cairo_device_t PTR) AS GLXContext
DECLARE FUNCTION cairo_gl_surface_create_for_window CDECL(BYVAL AS cairo_device_t PTR, BYVAL AS Window_FB, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR

#ENDIF ' CAIRO_HAS_GLX_FUNCTIONS

' #if CAIRO_HAS_WGL_FUNCTIONS
#IFDEF __FB_WIN32__

#INCLUDE ONCE "windows.bi"

DECLARE FUNCTION cairo_wgl_device_create CDECL(BYVAL AS HGLRC) AS cairo_device_t PTR
DECLARE FUNCTION cairo_wgl_device_get_context CDECL(BYVAL AS cairo_device_t PTR) AS HGLRC
DECLARE FUNCTION cairo_gl_surface_create_for_dc CDECL(BYVAL AS cairo_device_t PTR, BYVAL AS HDC, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR

#ENDIF ' __FB_WIN32__

#IF CAIRO_HAS_EGL_FUNCTIONS

#INCLUDE "EGL/egl.h"

DECLARE FUNCTION cairo_egl_device_create CDECL(BYVAL AS EGLDisplay, BYVAL AS EGLContext) AS cairo_device_t PTR
DECLARE FUNCTION cairo_gl_surface_create_for_egl CDECL(BYVAL AS cairo_device_t PTR, BYVAL AS EGLSurface, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR

#ENDIF ' CAIRO_HAS_EGL_FUNCTIONS

'' #else
#ELSE
#ERROR Cairo was not compiled with support for the GL backend
#ENDIF ' CAIRO_HAS_GL_SURFACE

END EXTERN

#ENDIF ' CAIRO_GL_H
