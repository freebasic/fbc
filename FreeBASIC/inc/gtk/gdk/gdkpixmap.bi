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

#include once "gtk/gdk/gdktypes.bi"
#include once "gtk/gdk/gdkdrawable.bi"

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

declare function gdk_pixmap_get_type cdecl alias "gdk_pixmap_get_type" () as GType
declare function gdk_pixmap_new cdecl alias "gdk_pixmap_new" (byval drawable as GdkDrawable ptr, byval width as gint, byval height as gint, byval depth as gint) as GdkPixmap ptr
declare function gdk_bitmap_create_from_data cdecl alias "gdk_bitmap_create_from_data" (byval drawable as GdkDrawable ptr, byval data as string, byval width as gint, byval height as gint) as GdkBitmap ptr
declare function gdk_pixmap_create_from_data cdecl alias "gdk_pixmap_create_from_data" (byval drawable as GdkDrawable ptr, byval data as string, byval width as gint, byval height as gint, byval depth as gint, byval fg as GdkColor ptr, byval bg as GdkColor ptr) as GdkPixmap ptr
declare function gdk_pixmap_create_from_xpm cdecl alias "gdk_pixmap_create_from_xpm" (byval drawable as GdkDrawable ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval filename as string) as GdkPixmap ptr
declare function gdk_pixmap_colormap_create_from_xpm cdecl alias "gdk_pixmap_colormap_create_from_xpm" (byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval filename as string) as GdkPixmap ptr
declare function gdk_pixmap_create_from_xpm_d cdecl alias "gdk_pixmap_create_from_xpm_d" (byval drawable as GdkDrawable ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval data as zstring ptr ptr) as GdkPixmap ptr
declare function gdk_pixmap_colormap_create_from_xpm_d cdecl alias "gdk_pixmap_colormap_create_from_xpm_d" (byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as GdkColor ptr, byval data as zstring ptr ptr) as GdkPixmap ptr
declare function gdk_pixmap_foreign_new cdecl alias "gdk_pixmap_foreign_new" (byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_lookup cdecl alias "gdk_pixmap_lookup" (byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_foreign_new_for_display cdecl alias "gdk_pixmap_foreign_new_for_display" (byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_lookup_for_display cdecl alias "gdk_pixmap_lookup_for_display" (byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkPixmap ptr

#endif
