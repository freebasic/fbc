''
''
'' gtkscrolledwindow -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkscrolledwindow_bi__
#define __gtkscrolledwindow_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkhscrollbar.bi"
#include once "gtk/gtk/gtkvscrollbar.bi"
#include once "gtk/gtk/gtkviewport.bi"

type GtkScrolledWindow as _GtkScrolledWindow
type GtkScrolledWindowClass as _GtkScrolledWindowClass

type _GtkScrolledWindow
	container as GtkBin
	hscrollbar as GtkWidget ptr
	vscrollbar as GtkWidget ptr
	''!!!FIXME!!! bit-fields support is needed
	union
		hscrollbar_policy as guint
		vscrollbar_policy as guint
		hscrollbar_visible as guint
		vscrollbar_visible as guint
		window_placement as guint
		focus_out as guint
	end union
	shadow_type as guint16
end type

type _GtkScrolledWindowClass
	parent_class as GtkBinClass
	scrollbar_spacing as gint
	scroll_child as sub cdecl(byval as GtkScrolledWindow ptr, byval as GtkScrollType, byval as gboolean)
	move_focus_out as sub cdecl(byval as GtkScrolledWindow ptr, byval as GtkDirectionType)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_scrolled_window_get_type cdecl alias "gtk_scrolled_window_get_type" () as GType
declare function gtk_scrolled_window_new cdecl alias "gtk_scrolled_window_new" (byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare sub gtk_scrolled_window_set_hadjustment cdecl alias "gtk_scrolled_window_set_hadjustment" (byval scrolled_window as GtkScrolledWindow ptr, byval hadjustment as GtkAdjustment ptr)
declare sub gtk_scrolled_window_set_vadjustment cdecl alias "gtk_scrolled_window_set_vadjustment" (byval scrolled_window as GtkScrolledWindow ptr, byval hadjustment as GtkAdjustment ptr)
declare function gtk_scrolled_window_get_hadjustment cdecl alias "gtk_scrolled_window_get_hadjustment" (byval scrolled_window as GtkScrolledWindow ptr) as GtkAdjustment ptr
declare function gtk_scrolled_window_get_vadjustment cdecl alias "gtk_scrolled_window_get_vadjustment" (byval scrolled_window as GtkScrolledWindow ptr) as GtkAdjustment ptr
declare sub gtk_scrolled_window_set_policy cdecl alias "gtk_scrolled_window_set_policy" (byval scrolled_window as GtkScrolledWindow ptr, byval hscrollbar_policy as GtkPolicyType, byval vscrollbar_policy as GtkPolicyType)
declare sub gtk_scrolled_window_get_policy cdecl alias "gtk_scrolled_window_get_policy" (byval scrolled_window as GtkScrolledWindow ptr, byval hscrollbar_policy as GtkPolicyType ptr, byval vscrollbar_policy as GtkPolicyType ptr)
declare sub gtk_scrolled_window_set_placement cdecl alias "gtk_scrolled_window_set_placement" (byval scrolled_window as GtkScrolledWindow ptr, byval window_placement as GtkCornerType)
declare function gtk_scrolled_window_get_placement cdecl alias "gtk_scrolled_window_get_placement" (byval scrolled_window as GtkScrolledWindow ptr) as GtkCornerType
declare sub gtk_scrolled_window_set_shadow_type cdecl alias "gtk_scrolled_window_set_shadow_type" (byval scrolled_window as GtkScrolledWindow ptr, byval type as GtkShadowType)
declare function gtk_scrolled_window_get_shadow_type cdecl alias "gtk_scrolled_window_get_shadow_type" (byval scrolled_window as GtkScrolledWindow ptr) as GtkShadowType
declare sub gtk_scrolled_window_add_with_viewport cdecl alias "gtk_scrolled_window_add_with_viewport" (byval scrolled_window as GtkScrolledWindow ptr, byval child as GtkWidget ptr)
declare function _gtk_scrolled_window_get_scrollbar_spacing cdecl alias "_gtk_scrolled_window_get_scrollbar_spacing" (byval scrolled_window as GtkScrolledWindow ptr) as gint

#endif
