''
''
'' gdkgc -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkgc_bi__
#define __gdkgc_bi__

#include once "gdkcolor.bi"
#include once "gdktypes.bi"

#define GDK_TYPE_GC (gdk_gc_get_type ())
#define GDK_GC(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GC, GdkGC))
#define GDK_GC_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GC, GdkGCClass))
#define GDK_IS_GC(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GC))
#define GDK_IS_GC_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GC))
#define GDK_GC_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GC, GdkGCClass))

type GdkGCValues as _GdkGCValues
type GdkGCClass as _GdkGCClass

enum GdkCapStyle
	GDK_CAP_NOT_LAST
	GDK_CAP_BUTT
	GDK_CAP_ROUND
	GDK_CAP_PROJECTING
end enum


enum GdkFill
	GDK_SOLID
	GDK_TILED
	GDK_STIPPLED
	GDK_OPAQUE_STIPPLED
end enum


enum GdkFunction
	GDK_COPY
	GDK_INVERT
	GDK_XOR
	GDK_CLEAR
	GDK_AND
	GDK_AND_REVERSE
	GDK_AND_INVERT
	GDK_NOOP
	GDK_OR
	GDK_EQUIV
	GDK_OR_REVERSE
	GDK_COPY_INVERT
	GDK_OR_INVERT
	GDK_NAND
	GDK_NOR
	GDK_SET
end enum


enum GdkJoinStyle
	GDK_JOIN_MITER
	GDK_JOIN_ROUND
	GDK_JOIN_BEVEL
end enum


enum GdkLineStyle
	GDK_LINE_SOLID
	GDK_LINE_ON_OFF_DASH
	GDK_LINE_DOUBLE_DASH
end enum


enum GdkSubwindowMode
	GDK_CLIP_BY_CHILDREN = 0
	GDK_INCLUDE_INFERIORS = 1
end enum


enum GdkGCValuesMask
	GDK_GC_FOREGROUND = 1 shl 0
	GDK_GC_BACKGROUND = 1 shl 1
	GDK_GC_FONT = 1 shl 2
	GDK_GC_FUNCTION = 1 shl 3
	GDK_GC_FILL = 1 shl 4
	GDK_GC_TILE = 1 shl 5
	GDK_GC_STIPPLE = 1 shl 6
	GDK_GC_CLIP_MASK = 1 shl 7
	GDK_GC_SUBWINDOW = 1 shl 8
	GDK_GC_TS_X_ORIGIN = 1 shl 9
	GDK_GC_TS_Y_ORIGIN = 1 shl 10
	GDK_GC_CLIP_X_ORIGIN = 1 shl 11
	GDK_GC_CLIP_Y_ORIGIN = 1 shl 12
	GDK_GC_EXPOSURES = 1 shl 13
	GDK_GC_LINE_WIDTH = 1 shl 14
	GDK_GC_LINE_STYLE = 1 shl 15
	GDK_GC_CAP_STYLE = 1 shl 16
	GDK_GC_JOIN_STYLE = 1 shl 17
end enum


type _GdkGCValues
	foreground as GdkColor
	background as GdkColor
	font as GdkFont ptr
	function as GdkFunction
	fill as GdkFill
	tile as GdkPixmap ptr
	stipple as GdkPixmap ptr
	clip_mask as GdkPixmap ptr
	subwindow_mode as GdkSubwindowMode
	ts_x_origin as gint
	ts_y_origin as gint
	clip_x_origin as gint
	clip_y_origin as gint
	graphics_exposures as gint
	line_width as gint
	line_style as GdkLineStyle
	cap_style as GdkCapStyle
	join_style as GdkJoinStyle
end type

type _GdkGC
	parent_instance as GObject
	clip_x_origin as gint
	clip_y_origin as gint
	ts_x_origin as gint
	ts_y_origin as gint
	colormap as GdkColormap ptr
end type

type _GdkGCClass
	parent_class as GObjectClass
	get_values as sub cdecl(byval as GdkGC ptr, byval as GdkGCValues ptr)
	set_values as sub cdecl(byval as GdkGC ptr, byval as GdkGCValues ptr, byval as GdkGCValuesMask)
	set_dashes as sub cdecl(byval as GdkGC ptr, byval as gint, byval as gint8 ptr, byval as gint)
	_gdk_reserved1 as sub cdecl()
	_gdk_reserved2 as sub cdecl()
	_gdk_reserved3 as sub cdecl()
	_gdk_reserved4 as sub cdecl()
end type

declare function gdk_gc_get_type () as GType
declare function gdk_gc_new (byval drawable as GdkDrawable ptr) as GdkGC ptr
declare function gdk_gc_new_with_values (byval drawable as GdkDrawable ptr, byval values as GdkGCValues ptr, byval values_mask as GdkGCValuesMask) as GdkGC ptr
declare function gdk_gc_ref (byval gc as GdkGC ptr) as GdkGC ptr
declare sub gdk_gc_unref (byval gc as GdkGC ptr)
declare sub gdk_gc_get_values (byval gc as GdkGC ptr, byval values as GdkGCValues ptr)
declare sub gdk_gc_set_values (byval gc as GdkGC ptr, byval values as GdkGCValues ptr, byval values_mask as GdkGCValuesMask)
declare sub gdk_gc_set_foreground (byval gc as GdkGC ptr, byval color as GdkColor ptr)
declare sub gdk_gc_set_background (byval gc as GdkGC ptr, byval color as GdkColor ptr)
declare sub gdk_gc_set_font (byval gc as GdkGC ptr, byval font as GdkFont ptr)
declare sub gdk_gc_set_function (byval gc as GdkGC ptr, byval function as GdkFunction)
declare sub gdk_gc_set_fill (byval gc as GdkGC ptr, byval fill as GdkFill)
declare sub gdk_gc_set_tile (byval gc as GdkGC ptr, byval tile as GdkPixmap ptr)
declare sub gdk_gc_set_stipple (byval gc as GdkGC ptr, byval stipple as GdkPixmap ptr)
declare sub gdk_gc_set_ts_origin (byval gc as GdkGC ptr, byval x as gint, byval y as gint)
declare sub gdk_gc_set_clip_origin (byval gc as GdkGC ptr, byval x as gint, byval y as gint)
declare sub gdk_gc_set_clip_mask (byval gc as GdkGC ptr, byval mask as GdkBitmap ptr)
declare sub gdk_gc_set_clip_rectangle (byval gc as GdkGC ptr, byval rectangle as GdkRectangle ptr)
declare sub gdk_gc_set_clip_region (byval gc as GdkGC ptr, byval region as GdkRegion ptr)
declare sub gdk_gc_set_subwindow (byval gc as GdkGC ptr, byval mode as GdkSubwindowMode)
declare sub gdk_gc_set_exposures (byval gc as GdkGC ptr, byval exposures as gboolean)
declare sub gdk_gc_set_line_attributes (byval gc as GdkGC ptr, byval line_width as gint, byval line_style as GdkLineStyle, byval cap_style as GdkCapStyle, byval join_style as GdkJoinStyle)
declare sub gdk_gc_set_dashes (byval gc as GdkGC ptr, byval dash_offset as gint, byval dash_list as gint8 ptr, byval n as gint)
declare sub gdk_gc_offset (byval gc as GdkGC ptr, byval x_offset as gint, byval y_offset as gint)
declare sub gdk_gc_copy (byval dst_gc as GdkGC ptr, byval src_gc as GdkGC ptr)
declare sub gdk_gc_set_colormap (byval gc as GdkGC ptr, byval colormap as GdkColormap ptr)
declare function gdk_gc_get_colormap (byval gc as GdkGC ptr) as GdkColormap ptr
declare sub gdk_gc_set_rgb_fg_color (byval gc as GdkGC ptr, byval color as GdkColor ptr)
declare sub gdk_gc_set_rgb_bg_color (byval gc as GdkGC ptr, byval color as GdkColor ptr)
declare function gdk_gc_get_screen (byval gc as GdkGC ptr) as GdkScreen ptr

#define gdk_gc_destroy gdk_gc_unref

#endif
