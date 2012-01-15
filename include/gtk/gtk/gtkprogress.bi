''
''
'' gtkprogress -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkprogress_bi__
#define __gtkprogress_bi__

#include once "gtk/gdk.bi"
#include once "gtkwidget.bi"
#include once "gtkadjustment.bi"

#define GTK_TYPE_PROGRESS (gtk_progress_get_type ())
#define GTK_PROGRESS(obj) (GTK_CHECK_CAST ((obj), GTK_TYPE_PROGRESS, GtkProgress))
#define GTK_PROGRESS_CLASS(klass) (GTK_CHECK_CLASS_CAST ((klass), GTK_TYPE_PROGRESS, GtkProgressClass))
#define GTK_IS_PROGRESS(obj) (GTK_CHECK_TYPE ((obj), GTK_TYPE_PROGRESS))
#define GTK_IS_PROGRESS_CLASS(klass) (GTK_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PROGRESS))
#define GTK_PROGRESS_GET_CLASS(obj) (GTK_CHECK_GET_CLASS ((obj), GTK_TYPE_PROGRESS, GtkProgressClass))

type GtkProgress as _GtkProgress
type GtkProgressClass as _GtkProgressClass

type _GtkProgress
	widget as GtkWidget
	adjustment as GtkAdjustment ptr
	offscreen_pixmap as GdkPixmap ptr
	format as zstring ptr
	x_align as gfloat
	y_align as gfloat
	show_text:1 as guint
	activity_mode:1 as guint
	use_text_format:1 as guint
end type

type _GtkProgressClass
	parent_class as GtkWidgetClass
	paint as sub cdecl(byval as GtkProgress ptr)
	update as sub cdecl(byval as GtkProgress ptr)
	act_mode_enter as sub cdecl(byval as GtkProgress ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_progress_get_type () as GType
declare sub gtk_progress_set_show_text (byval progress as GtkProgress ptr, byval show_text as gboolean)
declare sub gtk_progress_set_text_alignment (byval progress as GtkProgress ptr, byval x_align as gfloat, byval y_align as gfloat)
declare sub gtk_progress_set_format_string (byval progress as GtkProgress ptr, byval format as zstring ptr)
declare sub gtk_progress_set_adjustment (byval progress as GtkProgress ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_progress_configure (byval progress as GtkProgress ptr, byval value as gdouble, byval min as gdouble, byval max as gdouble)
declare sub gtk_progress_set_percentage (byval progress as GtkProgress ptr, byval percentage as gdouble)
declare sub gtk_progress_set_value (byval progress as GtkProgress ptr, byval value as gdouble)
declare function gtk_progress_get_value (byval progress as GtkProgress ptr) as gdouble
declare sub gtk_progress_set_activity_mode (byval progress as GtkProgress ptr, byval activity_mode as gboolean)
declare function gtk_progress_get_current_text (byval progress as GtkProgress ptr) as zstring ptr
declare function gtk_progress_get_text_from_value (byval progress as GtkProgress ptr, byval value as gdouble) as zstring ptr
declare function gtk_progress_get_current_percentage (byval progress as GtkProgress ptr) as gdouble
declare function gtk_progress_get_percentage_from_value (byval progress as GtkProgress ptr, byval value as gdouble) as gdouble

#endif
