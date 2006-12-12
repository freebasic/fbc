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

#include once "gdktypes.bi"

#define GDK_TYPE_VISUAL (gdk_visual_get_type ())
#define GDK_VISUAL(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_VISUAL, GdkVisual))
#define GDK_VISUAL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_VISUAL, GdkVisualClass))
#define GDK_IS_VISUAL(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_VISUAL))
#define GDK_IS_VISUAL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_VISUAL))
#define GDK_VISUAL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_VISUAL, GdkVisualClass))

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

declare function gdk_visual_get_type () as GType
declare function gdk_visual_get_best_depth () as gint
declare function gdk_visual_get_best_type () as GdkVisualType
declare function gdk_visual_get_system () as GdkVisual ptr
declare function gdk_visual_get_best () as GdkVisual ptr
declare function gdk_visual_get_best_with_depth (byval depth as gint) as GdkVisual ptr
declare function gdk_visual_get_best_with_type (byval visual_type as GdkVisualType) as GdkVisual ptr
declare function gdk_visual_get_best_with_both (byval depth as gint, byval visual_type as GdkVisualType) as GdkVisual ptr
declare sub gdk_query_depths (byval depths as gint ptr ptr, byval count as gint ptr)
declare sub gdk_query_visual_types (byval visual_types as GdkVisualType ptr ptr, byval count as gint ptr)
declare function gdk_list_visuals () as GList ptr
declare function gdk_visual_get_screen (byval visual as GdkVisual ptr) as GdkScreen ptr

#define gdk_visual_ref(v) g_object_ref(v)
#define gdk_visual_unref(v) g_object_unref(v)

#endif
