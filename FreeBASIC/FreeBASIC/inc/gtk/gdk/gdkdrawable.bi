''
''
'' gdkdrawable -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkdrawable_bi__
#define __gdkdrawable_bi__

#include once "gtk/gdk/gdktypes.bi"
#include once "gtk/gdk/gdkgc.bi"
#include once "gtk/gdk/gdkrgb.bi"
#include once "gtk/gdk-pixbuf.bi"

#define GDK_TYPE_DRAWABLE (gdk_drawable_get_type ())
#define GDK_DRAWABLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DRAWABLE, GdkDrawable))
#define GDK_DRAWABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DRAWABLE, GdkDrawableClass))
#define GDK_IS_DRAWABLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DRAWABLE))
#define GDK_IS_DRAWABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DRAWABLE))
#define GDK_DRAWABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DRAWABLE, GdkDrawableClass))

type GdkDrawableClass as _GdkDrawableClass
type GdkTrapezoid as _GdkTrapezoid

type _GdkDrawable
	parent_instance as GObject
end type

type _GdkDrawableClass
	parent_class as GObjectClass
	create_gc as function cdecl(byval as GdkDrawable ptr, byval as GdkGCValues ptr, byval as GdkGCValuesMask) as GdkGC ptr
	draw_rectangle as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as gboolean, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_arc as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as gboolean, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_polygon as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as gboolean, byval as GdkPoint ptr, byval as gint)
	draw_text as sub cdecl(byval as GdkDrawable ptr, byval as GdkFont ptr, byval as GdkGC ptr, byval as gint, byval as gint, byval as zstring ptr, byval as gint)
	draw_text_wc as sub cdecl(byval as GdkDrawable ptr, byval as GdkFont ptr, byval as GdkGC ptr, byval as gint, byval as gint, byval as GdkWChar ptr, byval as gint)
	draw_drawable as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkDrawable ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint)
	draw_points as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkPoint ptr, byval as gint)
	draw_segments as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkSegment ptr, byval as gint)
	draw_lines as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkPoint ptr, byval as gint)
	draw_glyphs as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as PangoFont ptr, byval as gint, byval as gint, byval as PangoGlyphString ptr)
	draw_image as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkImage ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint)
	get_depth as function cdecl(byval as GdkDrawable ptr) as gint
	get_size as sub cdecl(byval as GdkDrawable ptr, byval as gint ptr, byval as gint ptr)
	set_colormap as sub cdecl(byval as GdkDrawable ptr, byval as GdkColormap ptr)
	get_colormap as function cdecl(byval as GdkDrawable ptr) as GdkColormap ptr
	get_visual as function cdecl(byval as GdkDrawable ptr) as GdkVisual ptr
	get_screen as function cdecl(byval as GdkDrawable ptr) as GdkScreen ptr
	get_image as function cdecl(byval as GdkDrawable ptr, byval as gint, byval as gint, byval as gint, byval as gint) as GdkImage ptr
	get_clip_region as function cdecl(byval as GdkDrawable ptr) as GdkRegion ptr
	get_visible_region as function cdecl(byval as GdkDrawable ptr) as GdkRegion ptr
	get_composite_drawable as function cdecl(byval as GdkDrawable ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint ptr, byval as gint ptr) as GdkDrawable ptr
	draw_pixbuf as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkPixbuf ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint, byval as GdkRgbDither, byval as gint, byval as gint)
	_copy_to_image as function cdecl(byval as GdkDrawable ptr, byval as GdkImage ptr, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint, byval as gint) as GdkImage ptr
	draw_glyphs_transformed as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as PangoMatrix ptr, byval as PangoFont ptr, byval as gint, byval as gint, byval as PangoGlyphString ptr)
	draw_trapezoids as sub cdecl(byval as GdkDrawable ptr, byval as GdkGC ptr, byval as GdkTrapezoid ptr, byval as gint)
	_gdk_reserved3 as sub cdecl()
	_gdk_reserved4 as sub cdecl()
	_gdk_reserved5 as sub cdecl()
	_gdk_reserved6 as sub cdecl()
	_gdk_reserved7 as sub cdecl()
	_gdk_reserved9 as sub cdecl()
	_gdk_reserved10 as sub cdecl()
	_gdk_reserved11 as sub cdecl()
	_gdk_reserved12 as sub cdecl()
	_gdk_reserved13 as sub cdecl()
	_gdk_reserved14 as sub cdecl()
	_gdk_reserved15 as sub cdecl()
	_gdk_reserved16 as sub cdecl()
end type

type _GdkTrapezoid
	y1 as double
	x11 as double
	x21 as double
	y2 as double
	x12 as double
	x22 as double
end type

declare function gdk_drawable_get_type () as GType
declare sub gdk_drawable_set_data (byval drawable as GdkDrawable ptr, byval key as zstring ptr, byval data as gpointer, byval destroy_func as GDestroyNotify)
declare function gdk_drawable_get_data (byval drawable as GdkDrawable ptr, byval key as zstring ptr) as gpointer
declare sub gdk_drawable_get_size (byval drawable as GdkDrawable ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gdk_drawable_set_colormap (byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr)
declare function gdk_drawable_get_colormap (byval drawable as GdkDrawable ptr) as GdkColormap ptr
declare function gdk_drawable_get_visual (byval drawable as GdkDrawable ptr) as GdkVisual ptr
declare function gdk_drawable_get_depth (byval drawable as GdkDrawable ptr) as gint
declare function gdk_drawable_get_screen (byval drawable as GdkDrawable ptr) as GdkScreen ptr
declare function gdk_drawable_get_display (byval drawable as GdkDrawable ptr) as GdkDisplay ptr
declare function gdk_drawable_ref (byval drawable as GdkDrawable ptr) as GdkDrawable ptr
declare sub gdk_drawable_unref (byval drawable as GdkDrawable ptr)
declare sub gdk_draw_point (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint)
declare sub gdk_draw_line (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x1_ as gint, byval y1_ as gint, byval x2_ as gint, byval y2_ as gint)
declare sub gdk_draw_rectangle (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_arc (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval angle1 as gint, byval angle2 as gint)
declare sub gdk_draw_polygon (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval points as GdkPoint ptr, byval npoints as gint)
declare sub gdk_draw_string (byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval string as zstring ptr)
declare sub gdk_draw_text (byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval text as zstring ptr, byval text_length as gint)
declare sub gdk_draw_text_wc (byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval text as GdkWChar ptr, byval text_length as gint)
declare sub gdk_draw_drawable (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src as GdkDrawable ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_image (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval image as GdkImage ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_points (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval points as GdkPoint ptr, byval npoints as gint)
declare sub gdk_draw_segments (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval segs as GdkSegment ptr, byval nsegs as gint)
declare sub gdk_draw_lines (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval points as GdkPoint ptr, byval npoints as gint)
declare sub gdk_draw_pixbuf (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval pixbuf as GdkPixbuf ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint, byval dither as GdkRgbDither, byval x_dither as gint, byval y_dither as gint)
declare sub gdk_draw_glyphs (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval font as PangoFont ptr, byval x as gint, byval y as gint, byval glyphs as PangoGlyphString ptr)
declare sub gdk_draw_layout_line (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval line as PangoLayoutLine ptr)
declare sub gdk_draw_layout (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gdk_draw_layout_line_with_colors (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval line as PangoLayoutLine ptr, byval foreground as GdkColor ptr, byval background as GdkColor ptr)
declare sub gdk_draw_layout_with_colors (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr, byval foreground as GdkColor ptr, byval background as GdkColor ptr)
declare sub gdk_draw_glyphs_transformed (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval matrix as PangoMatrix ptr, byval font as PangoFont ptr, byval x as gint, byval y as gint, byval glyphs as PangoGlyphString ptr)
declare sub gdk_draw_trapezoids (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval trapezoids as GdkTrapezoid ptr, byval n_trapezoids as gint)
declare function gdk_drawable_get_image (byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_drawable_copy_to_image (byval drawable as GdkDrawable ptr, byval image as GdkImage ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_drawable_get_clip_region (byval drawable as GdkDrawable ptr) as GdkRegion ptr
declare function gdk_drawable_get_visible_region (byval drawable as GdkDrawable ptr) as GdkRegion ptr
declare function gdk_draw_rectangle_alpha_libgtk_only (byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval color as GdkColor ptr, byval alpha as guint16) as gboolean

#define gdk_draw_pixmap gdk_draw_drawable
#define gdk_draw_bitmap gdk_draw_drawable

#endif
