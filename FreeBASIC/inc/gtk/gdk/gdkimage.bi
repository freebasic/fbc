''
''
'' gdkimage -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkimage_bi__
#define __gdkimage_bi__

#include once "gdktypes.bi"

#define GDK_TYPE_IMAGE (gdk_image_get_type ())
#define GDK_IMAGE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_IMAGE, GdkImage))
#define GDK_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_IMAGE, GdkImageClass))
#define GDK_IS_IMAGE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_IMAGE))
#define GDK_IS_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_IMAGE))
#define GDK_IMAGE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_IMAGE, GdkImageClass))

enum GdkImageType
	GDK_IMAGE_NORMAL
	GDK_IMAGE_SHARED
	GDK_IMAGE_FASTEST
end enum

type GdkImageClass as _GdkImageClass

type _GdkImage
	parent_instance as GObject
	type as GdkImageType
	visual as GdkVisual ptr
	byte_order as GdkByteOrder
	width as gint
	height as gint
	depth as guint16
	bpp as guint16
	bpl as guint16
	bits_per_pixel as guint16
	mem as gpointer
	colormap as GdkColormap ptr
	windowing_data as gpointer
end type

type _GdkImageClass
	parent_class as GObjectClass
end type

declare function gdk_image_get_type () as GType
declare function gdk_image_new (byval type as GdkImageType, byval visual as GdkVisual ptr, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_image_get (byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_image_ref (byval image as GdkImage ptr) as GdkImage ptr
declare sub gdk_image_unref (byval image as GdkImage ptr)
declare sub gdk_image_put_pixel (byval image as GdkImage ptr, byval x as gint, byval y as gint, byval pixel as guint32)
declare function gdk_image_get_pixel (byval image as GdkImage ptr, byval x as gint, byval y as gint) as guint32
declare sub gdk_image_set_colormap (byval image as GdkImage ptr, byval colormap as GdkColormap ptr)
declare function gdk_image_get_colormap (byval image as GdkImage ptr) as GdkColormap ptr

#define gdk_image_destroy gdk_image_unref

#endif
