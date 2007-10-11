''
''
'' gtktooltips -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktooltips_bi__
#define __gtktooltips_bi__

#include once "gtkwidget.bi"
#include once "gtkwindow.bi"

#define GTK_TYPE_TOOLTIPS (gtk_tooltips_get_type ())
#define GTK_TOOLTIPS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOLTIPS, GtkTooltips))
#define GTK_TOOLTIPS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOOLTIPS, GtkTooltipsClass))
#define GTK_IS_TOOLTIPS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOLTIPS))
#define GTK_IS_TOOLTIPS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOOLTIPS))
#define GTK_TOOLTIPS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TOOLTIPS, GtkTooltipsClass))

type GtkTooltips as _GtkTooltips
type GtkTooltipsClass as _GtkTooltipsClass
type GtkTooltipsData as _GtkTooltipsData

type _GtkTooltipsData
	tooltips as GtkTooltips ptr
	widget as GtkWidget ptr
	tip_text as zstring ptr
	tip_private as zstring ptr
end type

type _GtkTooltips
	parent_instance as GtkObject
	tip_window as GtkWidget ptr
	tip_label as GtkWidget ptr
	active_tips_data as GtkTooltipsData ptr
	tips_data_list as GList ptr
	delay:30 as guint
	enabled:1 as guint
	have_grab:1 as guint
	use_sticky_delay:1 as guint
	timer_tag as gint
	last_popdown as GTimeVal
end type

type _GtkTooltipsClass
	parent_class as GtkObjectClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tooltips_get_type () as GType
declare function gtk_tooltips_new () as GtkTooltips ptr
declare sub gtk_tooltips_enable (byval tooltips as GtkTooltips ptr)
declare sub gtk_tooltips_disable (byval tooltips as GtkTooltips ptr)
declare sub gtk_tooltips_set_delay (byval tooltips as GtkTooltips ptr, byval delay as guint)
declare sub gtk_tooltips_set_tip (byval tooltips as GtkTooltips ptr, byval widget as GtkWidget ptr, byval tip_text as zstring ptr, byval tip_private as zstring ptr)
declare function gtk_tooltips_data_get (byval widget as GtkWidget ptr) as GtkTooltipsData ptr
declare sub gtk_tooltips_force_window (byval tooltips as GtkTooltips ptr)
declare sub _gtk_tooltips_toggle_keyboard_mode (byval widget as GtkWidget ptr)
declare function gtk_tooltips_get_info_from_tip_window (byval tip_window as GtkWindow ptr, byval tooltips as GtkTooltips ptr ptr, byval current_widget as GtkWidget ptr ptr) as gboolean

#endif
