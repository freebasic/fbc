''
''
'' gtkimcontext -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkimcontext_bi__
#define __gtkimcontext_bi__

#include once "gtk/gdk.bi"
#include once "gtkobject.bi"
#include once "gtk/pango.bi"

#define GTK_TYPE_IM_CONTEXT (gtk_im_context_get_type ())
#define GTK_IM_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_CONTEXT, GtkIMContext))
#define GTK_IM_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_CONTEXT, GtkIMContextClass))
#define GTK_IS_IM_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_CONTEXT))
#define GTK_IS_IM_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_CONTEXT))
#define GTK_IM_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_CONTEXT, GtkIMContextClass))

type GtkIMContext as _GtkIMContext
type GtkIMContextClass as _GtkIMContextClass

type _GtkIMContext
	parent_instance as GObject
end type

type _GtkIMContextClass
	parent_class as GtkObjectClass
	preedit_start as sub cdecl(byval as GtkIMContext ptr)
	preedit_end as sub cdecl(byval as GtkIMContext ptr)
	preedit_changed as sub cdecl(byval as GtkIMContext ptr)
	commit as sub cdecl(byval as GtkIMContext ptr, byval as zstring ptr)
	retrieve_surrounding as function cdecl(byval as GtkIMContext ptr) as gboolean
	delete_surrounding as function cdecl(byval as GtkIMContext ptr, byval as gint, byval as gint) as gboolean
	set_client_window as sub cdecl(byval as GtkIMContext ptr, byval as GdkWindow ptr)
	get_preedit_string as sub cdecl(byval as GtkIMContext ptr, byval as zstring ptr ptr, byval as PangoAttrList ptr ptr, byval as gint ptr)
	filter_keypress as function cdecl(byval as GtkIMContext ptr, byval as GdkEventKey ptr) as gboolean
	focus_in as sub cdecl(byval as GtkIMContext ptr)
	focus_out as sub cdecl(byval as GtkIMContext ptr)
	reset as sub cdecl(byval as GtkIMContext ptr)
	set_cursor_location as sub cdecl(byval as GtkIMContext ptr, byval as GdkRectangle ptr)
	set_use_preedit as sub cdecl(byval as GtkIMContext ptr, byval as gboolean)
	set_surrounding as sub cdecl(byval as GtkIMContext ptr, byval as zstring ptr, byval as gint, byval as gint)
	get_surrounding as function cdecl(byval as GtkIMContext ptr, byval as zstring ptr ptr, byval as gint ptr) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
	_gtk_reserved5 as sub cdecl()
	_gtk_reserved6 as sub cdecl()
end type

declare function gtk_im_context_get_type () as GType
declare sub gtk_im_context_set_client_window (byval context as GtkIMContext ptr, byval window as GdkWindow ptr)
declare sub gtk_im_context_get_preedit_string (byval context as GtkIMContext ptr, byval str as zstring ptr ptr, byval attrs as PangoAttrList ptr ptr, byval cursor_pos as gint ptr)
declare function gtk_im_context_filter_keypress (byval context as GtkIMContext ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_im_context_focus_in (byval context as GtkIMContext ptr)
declare sub gtk_im_context_focus_out (byval context as GtkIMContext ptr)
declare sub gtk_im_context_reset (byval context as GtkIMContext ptr)
declare sub gtk_im_context_set_cursor_location (byval context as GtkIMContext ptr, byval area as GdkRectangle ptr)
declare sub gtk_im_context_set_use_preedit (byval context as GtkIMContext ptr, byval use_preedit as gboolean)
declare sub gtk_im_context_set_surrounding (byval context as GtkIMContext ptr, byval text as zstring ptr, byval len as gint, byval cursor_index as gint)
declare function gtk_im_context_get_surrounding (byval context as GtkIMContext ptr, byval text as zstring ptr ptr, byval cursor_index as gint ptr) as gboolean
declare function gtk_im_context_delete_surrounding (byval context as GtkIMContext ptr, byval offset as gint, byval n_chars as gint) as gboolean

#endif
