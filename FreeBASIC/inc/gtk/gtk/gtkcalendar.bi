''
''
'' gtkcalendar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkcalendar_bi__
#define __gtkcalendar_bi__

#include once "gtk/gdk.bi"
#include once "gtkwidget.bi"
#include once "gtksignal.bi"

#define GTK_TYPE_CALENDAR (gtk_calendar_get_type ())
#define GTK_CALENDAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CALENDAR, GtkCalendar))
#define GTK_CALENDAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CALENDAR, GtkCalendarClass))
#define GTK_IS_CALENDAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CALENDAR))
#define GTK_IS_CALENDAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CALENDAR))
#define GTK_CALENDAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CALENDAR, GtkCalendarClass))

type GtkCalendar as _GtkCalendar
type GtkCalendarClass as _GtkCalendarClass

enum GtkCalendarDisplayOptions
	GTK_CALENDAR_SHOW_HEADING = 1 shl 0
	GTK_CALENDAR_SHOW_DAY_NAMES = 1 shl 1
	GTK_CALENDAR_NO_MONTH_CHANGE = 1 shl 2
	GTK_CALENDAR_SHOW_WEEK_NUMBERS = 1 shl 3
	GTK_CALENDAR_WEEK_START_MONDAY = 1 shl 4
end enum


type _GtkCalendar
	widget as GtkWidget
	header_style as GtkStyle ptr
	label_style as GtkStyle ptr
	month as gint
	year as gint
	selected_day as gint
	day_month(0 to 6-1, 0 to 7-1) as gint
	day(0 to 6-1, 0 to 7-1) as gint
	num_marked_dates as gint
	marked_date(0 to 31-1) as gint
	display_flags as GtkCalendarDisplayOptions
	marked_date_color(0 to 31-1) as GdkColor
	gc as GdkGC ptr
	xor_gc as GdkGC ptr
	focus_row as gint
	focus_col as gint
	highlight_row as gint
	highlight_col as gint
	private_data as gpointer
	grow_space(0 to 32-1) as gchar
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

type _GtkCalendarClass
	parent_class as GtkWidgetClass
	month_changed as sub cdecl(byval as GtkCalendar ptr)
	day_selected as sub cdecl(byval as GtkCalendar ptr)
	day_selected_double_click as sub cdecl(byval as GtkCalendar ptr)
	prev_month as sub cdecl(byval as GtkCalendar ptr)
	next_month as sub cdecl(byval as GtkCalendar ptr)
	prev_year as sub cdecl(byval as GtkCalendar ptr)
	next_year as sub cdecl(byval as GtkCalendar ptr)
end type

declare function gtk_calendar_get_type () as GType
declare function gtk_calendar_new () as GtkWidget ptr
declare function gtk_calendar_select_month (byval calendar as GtkCalendar ptr, byval month as guint, byval year as guint) as gboolean
declare sub gtk_calendar_select_day (byval calendar as GtkCalendar ptr, byval day as guint)
declare function gtk_calendar_mark_day (byval calendar as GtkCalendar ptr, byval day as guint) as gboolean
declare function gtk_calendar_unmark_day (byval calendar as GtkCalendar ptr, byval day as guint) as gboolean
declare sub gtk_calendar_clear_marks (byval calendar as GtkCalendar ptr)
declare sub gtk_calendar_set_display_options (byval calendar as GtkCalendar ptr, byval flags as GtkCalendarDisplayOptions)
declare function gtk_calendar_get_display_options (byval calendar as GtkCalendar ptr) as GtkCalendarDisplayOptions
declare sub gtk_calendar_display_options (byval calendar as GtkCalendar ptr, byval flags as GtkCalendarDisplayOptions)
declare sub gtk_calendar_get_date (byval calendar as GtkCalendar ptr, byval year as guint ptr, byval month as guint ptr, byval day as guint ptr)
declare sub gtk_calendar_freeze (byval calendar as GtkCalendar ptr)
declare sub gtk_calendar_thaw (byval calendar as GtkCalendar ptr)

#endif
