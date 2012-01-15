''
''
'' gdkrgb -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkrgb_bi__
#define __gdkrgb_bi__

#include once "gdktypes.bi"

type GdkRgbCmap as _GdkRgbCmap

type _GdkRgbCmap
	colors(0 to 256-1) as guint32
	n_colors as gint
	info_list as GSList ptr
end type

declare sub gdk_rgb_init ()
declare function gdk_rgb_xpixel_from_rgb (byval rgb_ as guint32) as gulong
declare sub gdk_rgb_gc_set_foreground (byval gc as GdkGC ptr, byval rgb_ as guint32)
declare sub gdk_rgb_gc_set_background (byval gc as GdkGC ptr, byval rgb_ as guint32)
declare sub gdk_rgb_find_color (byval colormap as GdkColormap ptr, byval color as GdkColor ptr)

enum GdkRgbDither
	GDK_RGB_DITHER_NONE
	GDK_RGB_DITHER_NORMAL
	GDK_RGB_DITHER_MAX
end enum


declare sub gdk_draw_rgb_image (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval rgb_buf as guchar ptr, byval rowstride as gint)
declare sub gdk_draw_rgb_image_dithalign (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval rgb_buf as guchar ptr, byval rowstride as gint, byval xdith as gint, byval ydith as gint)
declare sub gdk_draw_rgb_32_image (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as guchar ptr, byval rowstride as gint)
declare sub gdk_draw_rgb_32_image_dithalign (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as guchar ptr, byval rowstride as gint, byval xdith as gint, byval ydith as gint)
declare sub gdk_draw_gray_image (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as guchar ptr, byval rowstride as gint)
declare sub gdk_draw_indexed_image (byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as guchar ptr, byval rowstride as gint, byval cmap as GdkRgbCmap ptr)
declare function gdk_rgb_cmap_new (byval colors as guint32 ptr, byval n_colors as gint) as GdkRgbCmap ptr
declare sub gdk_rgb_cmap_free (byval cmap as GdkRgbCmap ptr)
declare sub gdk_rgb_set_verbose (byval verbose as gboolean)
declare sub gdk_rgb_set_install (byval install as gboolean)
declare sub gdk_rgb_set_min_colors (byval min_colors as gint)
declare function gdk_rgb_get_colormap () as GdkColormap ptr
declare function gdk_rgb_get_visual () as GdkVisual ptr
declare function gdk_rgb_ditherable () as gboolean
declare function gdk_rgb_colormap_ditherable (byval cmap as GdkColormap ptr) as gboolean

#define gdk_rgb_get_cmap gdk_rgb_get_colormap

#endif
