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
#include once "gtk/gtk/gtkwidget.bi"

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

declare function gtk_drawing_area_get_type cdecl alias "gtk_drawing_area_get_type" () as GType
declare function gtk_drawing_area_new cdecl alias "gtk_drawing_area_new" () as GtkWidget ptr
declare sub gtk_drawing_area_size cdecl alias "gtk_drawing_area_size" (byval darea as GtkDrawingArea ptr, byval width as gint, byval height as gint)

#endif
