''
''
'' gdkvisual -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkvisual_bi__
#define __gdkvisual_bi__

#include once "gtk/gdk/gdktypes.bi"

type GdkVisualClass as _GdkVisualClass

enum GdkVisualType
	GDK_VISUAL_STATIC_GRAY
	GDK_VISUAL_GRAYSCALE
	GDK_VISUAL_STATIC_COLOR
	GDK_VISUAL_PSEUDO_COLOR
	GDK_VISUAL_TRUE_COLOR
	GDK_VISUAL_DIRECT_COLOR
end enum


type _GdkVisual
	parent_instance as GObject
	type as GdkVisualType
	depth as gint
	byte_order as GdkByteOrder
	colormap_size as gint
	bits_per_rgb as gint
	red_mask as guint32
	red_shift as gint
	red_prec as gint
	green_mask as guint32
	green_shift as gint
	green_prec as gint
	blue_mask as guint32
	blue_shift as gint
	blue_prec as gint
end type

declare function gdk_visual_get_type cdecl alias "gdk_visual_get_type" () as GType
declare function gdk_visual_get_best_depth cdecl alias "gdk_visual_get_best_depth" () as gint
declare function gdk_visual_get_best_type cdecl alias "gdk_visual_get_best_type" () as GdkVisualType
declare function gdk_visual_get_system cdecl alias "gdk_visual_get_system" () as GdkVisual ptr
declare function gdk_visual_get_best cdecl alias "gdk_visual_get_best" () as GdkVisual ptr
declare function gdk_visual_get_best_with_depth cdecl alias "gdk_visual_get_best_with_depth" (byval depth as gint) as GdkVisual ptr
declare function gdk_visual_get_best_with_type cdecl alias "gdk_visual_get_best_with_type" (byval visual_type as GdkVisualType) as GdkVisual ptr
declare function gdk_visual_get_best_with_both cdecl alias "gdk_visual_get_best_with_both" (byval depth as gint, byval visual_type as GdkVisualType) as GdkVisual ptr
declare sub gdk_query_depths cdecl alias "gdk_query_depths" (byval depths as gint ptr ptr, byval count as gint ptr)
declare sub gdk_query_visual_types cdecl alias "gdk_query_visual_types" (byval visual_types as GdkVisualType ptr ptr, byval count as gint ptr)
declare function gdk_list_visuals cdecl alias "gdk_list_visuals" () as GList ptr
declare function gdk_visual_get_screen cdecl alias "gdk_visual_get_screen" (byval visual as GdkVisual ptr) as GdkScreen ptr

#endif
