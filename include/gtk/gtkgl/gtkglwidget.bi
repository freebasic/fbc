''
''
'' gtkglwidget -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkglwidget_bi__
#define __gtkglwidget_bi__

#include once "gtk/gdk.bi"
#include once "../gtkgl.bi"
#include once "gtk/gtk/gtkwidget.bi"

declare function gtk_widget_set_gl_capability (byval widget as GtkWidget ptr, byval glconfig as GdkGLConfig ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as integer) as gboolean
declare function gtk_widget_is_gl_capable (byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_get_gl_config (byval widget as GtkWidget ptr) as GdkGLConfig ptr
declare function gtk_widget_create_gl_context (byval widget as GtkWidget ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as integer) as GdkGLContext ptr
declare function gtk_widget_get_gl_context (byval widget as GtkWidget ptr) as GdkGLContext ptr
declare function gtk_widget_get_gl_window (byval widget as GtkWidget ptr) as GdkGLWindow ptr

#define gtk_widget_get_gl_drawable(w) GDK_GL_DRAWABLE(gtk_widget_get_gl_window(w))

#endif
