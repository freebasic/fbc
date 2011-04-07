''
''
'' gdkglpixmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglpixmap_bi__
#define __gdkglpixmap_bi__

#include once "gdkgldefs.bi"
#include once "gdkgltypes.bi"
#include once "gtk/gdk/gdkpixmap.bi"

#define GDK_TYPE_GL_PIXMAP (gdk_gl_pixmap_get_type ())
#define GDK_GL_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_PIXMAP, GdkGLPixmap))
#define GDK_GL_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_PIXMAP, GdkGLPixmapClass))
#define GDK_IS_GL_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_PIXMAP))
#define GDK_IS_GL_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_PIXMAP))
#define GDK_GL_PIXMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_PIXMAP, GdkGLPixmapClass))

type GdkGLPixmapClass as _GdkGLPixmapClass

type _GdkGLPixmap
	parent_instance as GdkDrawable
	drawable as GdkDrawable ptr
end type

type _GdkGLPixmapClass
	parent_class as GdkDrawableClass
end type

declare function gdk_gl_pixmap_get_type () as GType
declare function gdk_gl_pixmap_new (byval glconfig as GdkGLConfig ptr, byval pixmap as GdkPixmap ptr, byval attrib_list as integer ptr) as GdkGLPixmap ptr
declare sub gdk_gl_pixmap_destroy (byval glpixmap as GdkGLPixmap ptr)
declare function gdk_gl_pixmap_get_pixmap (byval glpixmap as GdkGLPixmap ptr) as GdkPixmap ptr
declare function gdk_pixmap_set_gl_capability (byval pixmap as GdkPixmap ptr, byval glconfig as GdkGLConfig ptr, byval attrib_list as integer ptr) as GdkGLPixmap ptr
declare sub gdk_pixmap_unset_gl_capability (byval pixmap as GdkPixmap ptr)
declare function gdk_pixmap_is_gl_capable (byval pixmap as GdkPixmap ptr) as gboolean
declare function gdk_pixmap_get_gl_pixmap (byval pixmap as GdkPixmap ptr) as GdkGLPixmap ptr

#endif
