'' FreeBASIC binding for cairo-1.14.2

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
