''
''
'' gdkglwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglwindow_bi__
#define __gdkglwindow_bi__

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"
#include once "gtk/gdk/gdkwindow.bi"

#define GDK_TYPE_GL_WINDOW (gdk_gl_window_get_type ())
#define GDK_GL_WINDOW(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_WINDOW, GdkGLWindow))
#define GDK_GL_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_WINDOW, GdkGLWindowClass))
#define GDK_IS_GL_WINDOW(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_WINDOW))
#define GDK_IS_GL_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_WINDOW))
#define GDK_GL_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_WINDOW, GdkGLWindowClass))

type GdkGLWindowClass as _GdkGLWindowClass

type _GdkGLWindow
	parent_instance as GdkDrawable
	drawable as GdkDrawable ptr
end type

type _GdkGLWindowClass
	parent_class as GdkDrawableClass
end type

declare function gdk_gl_window_get_type () as GType
declare function gdk_gl_window_new (byval glconfig as GdkGLConfig ptr, byval window as GdkWindow ptr, byval attrib_list as integer ptr) as GdkGLWindow ptr
declare sub gdk_gl_window_destroy (byval glwindow as GdkGLWindow ptr)
declare function gdk_gl_window_get_window (byval glwindow as GdkGLWindow ptr) as GdkWindow ptr
declare function gdk_window_set_gl_capability (byval window as GdkWindow ptr, byval glconfig as GdkGLConfig ptr, byval attrib_list as integer ptr) as GdkGLWindow ptr
declare sub gdk_window_unset_gl_capability (byval window as GdkWindow ptr)
declare function gdk_window_is_gl_capable (byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_gl_window (byval window as GdkWindow ptr) as GdkGLWindow ptr

#endif
