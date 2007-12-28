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

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"

#define GDK_TYPE_GL_CONTEXT (gdk_gl_context_get_type ())
#define GDK_GL_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_CONTEXT, GdkGLContext))
#define GDK_GL_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_CONTEXT, GdkGLContextClass))
#define GDK_IS_GL_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_CONTEXT))
#define GDK_IS_GL_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_CONTEXT))
#define GDK_GL_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_CONTEXT, GdkGLContextClass))

type GdkGLContextClass as _GdkGLContextClass

type _GdkGLContext
	parent_instance as GObject
end type

type _GdkGLContextClass
	parent_class as GObjectClass
end type

declare function gdk_gl_context_get_type () as GType
declare function gdk_gl_context_new (byval gldrawable as GdkGLDrawable ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as integer) as GdkGLContext ptr
declare sub gdk_gl_context_destroy (byval glcontext as GdkGLContext ptr)
declare function gdk_gl_context_copy (byval glcontext as GdkGLContext ptr, byval src as GdkGLContext ptr, byval mask as uinteger) as gboolean
declare function gdk_gl_context_get_gl_drawable (byval glcontext as GdkGLContext ptr) as GdkGLDrawable ptr
declare function gdk_gl_context_get_gl_config (byval glcontext as GdkGLContext ptr) as GdkGLConfig ptr
declare function gdk_gl_context_get_share_list (byval glcontext as GdkGLContext ptr) as GdkGLContext ptr
declare function gdk_gl_context_is_direct (byval glcontext as GdkGLContext ptr) as gboolean
declare function gdk_gl_context_get_render_type (byval glcontext as GdkGLContext ptr) as integer
declare function gdk_gl_context_get_current () as GdkGLContext ptr

#endif
