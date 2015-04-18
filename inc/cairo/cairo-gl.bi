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

#ifdef __FB_WIN32__
	#include once "windows.bi"
#endif

extern "C"

#define CAIRO_GL_H
declare function cairo_gl_surface_create(byval device as cairo_device_t ptr, byval content as cairo_content_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare function cairo_gl_surface_create_for_texture(byval abstract_device as cairo_device_t ptr, byval content as cairo_content_t, byval tex as ulong, byval width as long, byval height as long) as cairo_surface_t ptr
declare sub cairo_gl_surface_set_size(byval surface as cairo_surface_t ptr, byval width as long, byval height as long)
declare function cairo_gl_surface_get_width(byval abstract_surface as cairo_surface_t ptr) as long
declare function cairo_gl_surface_get_height(byval abstract_surface as cairo_surface_t ptr) as long
declare sub cairo_gl_surface_swapbuffers(byval surface as cairo_surface_t ptr)
declare sub cairo_gl_device_set_thread_aware(byval device as cairo_device_t ptr, byval thread_aware as cairo_bool_t)

#ifdef __FB_WIN32__
	declare function cairo_wgl_device_create(byval rc as HGLRC) as cairo_device_t ptr
	declare function cairo_wgl_device_get_context(byval device as cairo_device_t ptr) as HGLRC
	declare function cairo_gl_surface_create_for_dc(byval device as cairo_device_t ptr, byval dc as HDC, byval width as long, byval height as long) as cairo_surface_t ptr
#endif

end extern
