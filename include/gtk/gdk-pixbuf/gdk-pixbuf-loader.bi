''
''
'' gdk-pixbuf-loader -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_loader_bi__
#define __gdk_pixbuf_loader_bi__

#include once "gtk/glib.bi"
#include once "gtk/glib-object.bi"
#include once "gdk-pixbuf-core.bi"
#include once "gdk-pixbuf-animation.bi"
#include once "gdk-pixbuf-io.bi"

#define GDK_TYPE_PIXBUF_LOADER (gdk_pixbuf_loader_get_type ())
#define GDK_PIXBUF_LOADER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoader))
#define GDK_PIXBUF_LOADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoaderClass))
#define GDK_IS_PIXBUF_LOADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_PIXBUF_LOADER))
#define GDK_IS_PIXBUF_LOADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXBUF_LOADER))
#define GDK_PIXBUF_LOADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoaderClass))

type GdkPixbufLoader as _GdkPixbufLoader

type _GdkPixbufLoader
	parent_instance as GObject
	priv as gpointer
end type

type GdkPixbufLoaderClass as _GdkPixbufLoaderClass

type _GdkPixbufLoaderClass
	parent_class as GObjectClass
	size_prepared as sub cdecl(byval as GdkPixbufLoader ptr, byval as integer, byval as integer)
	area_prepared as sub cdecl(byval as GdkPixbufLoader ptr)
	area_updated as sub cdecl(byval as GdkPixbufLoader ptr, byval as integer, byval as integer, byval as integer, byval as integer)
	closed as sub cdecl(byval as GdkPixbufLoader ptr)
end type

declare function gdk_pixbuf_loader_get_type () as GType
declare function gdk_pixbuf_loader_new () as GdkPixbufLoader ptr
declare function gdk_pixbuf_loader_new_with_type (byval image_type as zstring ptr, byval error as GError ptr ptr) as GdkPixbufLoader ptr
declare function gdk_pixbuf_loader_new_with_mime_type (byval mime_type as zstring ptr, byval error as GError ptr ptr) as GdkPixbufLoader ptr
declare sub gdk_pixbuf_loader_set_size (byval loader as GdkPixbufLoader ptr, byval width as integer, byval height as integer)
declare function gdk_pixbuf_loader_write (byval loader as GdkPixbufLoader ptr, byval buf as guchar ptr, byval count as gsize, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_loader_get_pixbuf (byval loader as GdkPixbufLoader ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_loader_get_animation (byval loader as GdkPixbufLoader ptr) as GdkPixbufAnimation ptr
declare function gdk_pixbuf_loader_close (byval loader as GdkPixbufLoader ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_loader_get_format (byval loader as GdkPixbufLoader ptr) as GdkPixbufFormat ptr

#endif
