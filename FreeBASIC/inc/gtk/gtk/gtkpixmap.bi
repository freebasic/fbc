''
''
'' gtkpixmap -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkpixmap_bi__
#define __gtkpixmap_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkmisc.bi"

type GtkPixmap as _GtkPixmap
type GtkPixmapClass as _GtkPixmapClass

type _GtkPixmap
	misc as GtkMisc
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
	pixmap_insensitive as GdkPixmap ptr
	build_insensitive as guint
end type

type _GtkPixmapClass
	parent_class as GtkMiscClass
end type

declare function gtk_pixmap_get_type cdecl alias "gtk_pixmap_get_type" () as GtkType
declare function gtk_pixmap_new cdecl alias "gtk_pixmap_new" (byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr) as GtkWidget ptr
declare sub gtk_pixmap_set cdecl alias "gtk_pixmap_set" (byval pixmap as GtkPixmap ptr, byval val as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_pixmap_get cdecl alias "gtk_pixmap_get" (byval pixmap as GtkPixmap ptr, byval val as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr)
declare sub gtk_pixmap_set_build_insensitive cdecl alias "gtk_pixmap_set_build_insensitive" (byval pixmap as GtkPixmap ptr, byval build as gboolean)

#endif
