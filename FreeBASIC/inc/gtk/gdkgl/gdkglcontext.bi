''
''
'' gdkglcontext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglcontext_bi__
#define __gdkglcontext_bi__

#include once "gtk/gdkgl/gdkgldefs.bi"
#include once "gtk/gdkgl/gdkgltypes.bi"

type GdkGLContextClass as _GdkGLContextClass

type _GdkGLContext
	parent_instance as GObject
end type

type _GdkGLContextClass
	parent_class as GObjectClass
end type

declare function gdk_gl_context_get_type cdecl alias "gdk_gl_context_get_type" () as GType
declare function gdk_gl_context_new cdecl alias "gdk_gl_context_new" (byval gldrawable as GdkGLDrawable ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as integer) as GdkGLContext ptr
declare sub gdk_gl_context_destroy cdecl alias "gdk_gl_context_destroy" (byval glcontext as GdkGLContext ptr)
declare function gdk_gl_context_copy cdecl alias "gdk_gl_context_copy" (byval glcontext as GdkGLContext ptr, byval src as GdkGLContext ptr, byval mask as uinteger) as gboolean
declare function gdk_gl_context_get_gl_drawable cdecl alias "gdk_gl_context_get_gl_drawable" (byval glcontext as GdkGLContext ptr) as GdkGLDrawable ptr
declare function gdk_gl_context_get_gl_config cdecl alias "gdk_gl_context_get_gl_config" (byval glcontext as GdkGLContext ptr) as GdkGLConfig ptr
declare function gdk_gl_context_get_share_list cdecl alias "gdk_gl_context_get_share_list" (byval glcontext as GdkGLContext ptr) as GdkGLContext ptr
declare function gdk_gl_context_is_direct cdecl alias "gdk_gl_context_is_direct" (byval glcontext as GdkGLContext ptr) as gboolean
declare function gdk_gl_context_get_render_type cdecl alias "gdk_gl_context_get_render_type" (byval glcontext as GdkGLContext ptr) as integer
declare function gdk_gl_context_get_current cdecl alias "gdk_gl_context_get_current" () as GdkGLContext ptr

#endif
