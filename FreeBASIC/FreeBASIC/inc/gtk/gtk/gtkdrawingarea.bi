''
''
'' gtkdrawingarea -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkdrawingarea_bi__
#define __gtkdrawingarea_bi__

#include once "gtk/gdk.bi"
#include once "gtkwidget.bi"

#define GTK_TYPE_DRAWING_AREA (gtk_drawing_area_get_type ())
#define GTK_DRAWING_AREA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingArea))
#define GTK_DRAWING_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass))
#define GTK_IS_DRAWING_AREA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_DRAWING_AREA))
#define GTK_IS_DRAWING_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_DRAWING_AREA))
#define GTK_DRAWING_AREA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass))

type GtkDrawingArea as _GtkDrawingArea
type GtkDrawingAreaClass as _GtkDrawingAreaClass

type _GtkDrawingArea
	widget as GtkWidget
	draw_data as gpointer
end type

type _GtkDrawingAreaClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_drawing_area_get_type () as GType
declare function gtk_drawing_area_new () as GtkWidget ptr
declare sub gtk_drawing_area_size (byval darea as GtkDrawingArea ptr, byval width as gint, byval height as gint)

#endif
