''
''
'' gdkgldrawable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkgldrawable_bi__
#define __gdkgldrawable_bi__

#include once "gtk/gdkgl/gdkgldefs.bi"
#include once "gtk/gdkgl/gdkgltypes.bi"

type GdkGLDrawableClass as _GdkGLDrawableClass

type _GdkGLDrawableClass
	base_iface as GTypeInterface
	create_new_context as function cdecl(byval as GdkGLDrawable ptr, byval as GdkGLContext ptr, byval as gboolean, byval as integer) as GdkGLContext ptr
	make_context_current as function cdecl(byval as GdkGLDrawable ptr, byval as GdkGLDrawable ptr, byval as GdkGLContext ptr) as gboolean
	is_double_buffered as function cdecl(byval as GdkGLDrawable ptr) as gboolean
	swap_buffers as sub cdecl(byval as GdkGLDrawable ptr)
	wait_gl as sub cdecl(byval as GdkGLDrawable ptr)
	wait_gdk as sub cdecl(byval as GdkGLDrawable ptr)
	gl_begin as function cdecl(byval as GdkGLDrawable ptr, byval as GdkGLDrawable ptr, byval as GdkGLContext ptr) as gboolean
	gl_end as sub cdecl(byval as GdkGLDrawable ptr)
	get_gl_config as function cdecl(byval as GdkGLDrawable ptr) as GdkGLConfig
	get_size as sub cdecl(byval as GdkGLDrawable ptr, byval as gint ptr, byval as gint ptr)
end type

declare function gdk_gl_drawable_get_type cdecl alias "gdk_gl_drawable_get_type" () as GType
declare function gdk_gl_drawable_make_current cdecl alias "gdk_gl_drawable_make_current" (byval gldrawable as GdkGLDrawable ptr, byval glcontext as GdkGLContext ptr) as gboolean
declare function gdk_gl_drawable_is_double_buffered cdecl alias "gdk_gl_drawable_is_double_buffered" (byval gldrawable as GdkGLDrawable ptr) as gboolean
declare sub gdk_gl_drawable_swap_buffers cdecl alias "gdk_gl_drawable_swap_buffers" (byval gldrawable as GdkGLDrawable ptr)
declare sub gdk_gl_drawable_wait_gl cdecl alias "gdk_gl_drawable_wait_gl" (byval gldrawable as GdkGLDrawable ptr)
declare sub gdk_gl_drawable_wait_gdk cdecl alias "gdk_gl_drawable_wait_gdk" (byval gldrawable as GdkGLDrawable ptr)
declare function gdk_gl_drawable_gl_begin cdecl alias "gdk_gl_drawable_gl_begin" (byval gldrawable as GdkGLDrawable ptr, byval glcontext as GdkGLContext ptr) as gboolean
declare sub gdk_gl_drawable_gl_end cdecl alias "gdk_gl_drawable_gl_end" (byval gldrawable as GdkGLDrawable ptr)
declare function gdk_gl_drawable_get_gl_config cdecl alias "gdk_gl_drawable_get_gl_config" (byval gldrawable as GdkGLDrawable ptr) as GdkGLConfig ptr
declare sub gdk_gl_drawable_get_size cdecl alias "gdk_gl_drawable_get_size" (byval gldrawable as GdkGLDrawable ptr, byval width as gint ptr, byval height as gint ptr)
declare function gdk_gl_drawable_get_current cdecl alias "gdk_gl_drawable_get_current" () as GdkGLDrawable ptr

#endif
