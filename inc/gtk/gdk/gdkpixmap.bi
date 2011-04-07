''
''
'' gdkpixmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkpixmap_bi__
#define __gdkpixmap_bi__

#include once "gdktypes.bi"
#include once "gdkdrawable.bi"

#define GDK_TYPE_PIXMAP (gdk_pixmap_get_type ())
#define GDK_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXMAP, GdkPixmap))
#define GDK_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXMAP, GdkPixmapObjectClass))
#define GDK_IS_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXMAP))
#define GDK_IS_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXMAP))
#define GDK_PIXMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXMAP, GdkPixmapObjectClass))
#define GDK_PIXMAP_OBJECT(object) (cast(GdkPixmapObject ptr, GDK_PIXMAP (object)))

type GdkPixmapObject as _GdkPixmapObject
type GdkPixmapObjectClass as _GdkPixmapObjectClass

type _GdkPixmapObject
	parent_instance as GdkDrawable
	impl as GdkDrawable ptr
	depth as gint
end type

type _GdkPixmapObjectClass
	parent_class as GdkDrawableClass
end type

declare function gdk_pixmap_get_type () as GType
declare function gdk_pixmap_new (byval drawable as GdkDrawable ptr, byval width as gint, byval height as gint, byval depth as gint) as GdkPixmap ptr
declare function gdk_bitmap_create_from_data (byval drawable as GdkDrawable ptr, byval data as zstring ptr, byval width as gint, byval height as gint) as GdkBitmap ptr
declare function gdk_pixmap_create_from_data (byval drawable as GdkDrawable ptr, byval data as zstring ptr, byval width as gint, byval height as gint, byval depth as gint, byval fg as GdkColor ptr, byval bg as GdkColor ptr) as GdkPixmap ptr
declare function gdk_pixmap_create_from_xpm (byval drawable as GdkDrawable ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval filename as zstring ptr) as GdkPixmap ptr
declare function gdk_pixmap_colormap_create_from_xpm (byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval filename as zstring ptr) as GdkPixmap ptr
declare function gdk_pixmap_create_from_xpm_d (byval drawable as GdkDrawable ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval data as zstring ptr ptr) as GdkPixmap ptr
declare function gdk_pixmap_colormap_create_from_xpm_d (byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval data as zstring ptr ptr) as GdkPixmap ptr
declare function gdk_pixmap_foreign_new (byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_lookup (byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_foreign_new_for_display (byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_lookup_for_display (byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkPixmap ptr

#define gdk_bitmap_ref gdk_drawable_ref
#define gdk_bitmap_unref gdk_drawable_unref
#define gdk_pixmap_ref gdk_drawable_ref
#define gdk_pixmap_unref gdk_drawable_unref

#endif
