''
''
'' gtkscale -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkscale_bi__
#define __gtkscale_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkrange.bi"

type GtkScale as _GtkScale
type GtkScaleClass as _GtkScaleClass

type _GtkScale
	range as GtkRange
	digits as gint
	draw_value as guint
	value_pos as guint
end type

type _GtkScaleClass
	parent_class as GtkRangeClass
	format_value as function cdecl(byval as GtkScale ptr, byval as gdouble) as gchar
	draw_value as sub cdecl(byval as GtkScale ptr)
	get_layout_offsets as sub cdecl(byval as GtkScale ptr, byval as gint ptr, byval as gint ptr)
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_scale_get_type cdecl alias "gtk_scale_get_type" () as GType
declare sub gtk_scale_set_digits cdecl alias "gtk_scale_set_digits" (byval scale as GtkScale ptr, byval digits as gint)
declare function gtk_scale_get_digits cdecl alias "gtk_scale_get_digits" (byval scale as GtkScale ptr) as gint
declare sub gtk_scale_set_draw_value cdecl alias "gtk_scale_set_draw_value" (byval scale as GtkScale ptr, byval draw_value as gboolean)
declare function gtk_scale_get_draw_value cdecl alias "gtk_scale_get_draw_value" (byval scale as GtkScale ptr) as gboolean
declare sub gtk_scale_set_value_pos cdecl alias "gtk_scale_set_value_pos" (byval scale as GtkScale ptr, byval pos as GtkPositionType)
declare function gtk_scale_get_value_pos cdecl alias "gtk_scale_get_value_pos" (byval scale as GtkScale ptr) as GtkPositionType
declare function gtk_scale_get_layout cdecl alias "gtk_scale_get_layout" (byval scale as GtkScale ptr) as PangoLayout ptr
declare sub gtk_scale_get_layout_offsets cdecl alias "gtk_scale_get_layout_offsets" (byval scale as GtkScale ptr, byval x as gint ptr, byval y as gint ptr)
declare sub _gtk_scale_clear_layout cdecl alias "_gtk_scale_clear_layout" (byval scale as GtkScale ptr)
declare sub _gtk_scale_get_value_size cdecl alias "_gtk_scale_get_value_size" (byval scale as GtkScale ptr, byval width as gint ptr, byval height as gint ptr)
declare function _gtk_scale_format_value cdecl alias "_gtk_scale_format_value" (byval scale as GtkScale ptr, byval value as gdouble) as zstring ptr

#endif
