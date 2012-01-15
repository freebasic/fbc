''
''
'' gdkpixbuf -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkpixbuf_bi__
#define __gdkpixbuf_bi__

#include once "gdktypes.bi"
#include once "gdkrgb.bi"
#include once "gtk/gdk-pixbuf.bi"

declare sub gdk_pixbuf_render_threshold_alpha (byval pixbuf as GdkPixbuf ptr, byval bitmap as GdkBitmap ptr, byval src_x as integer, byval src_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer, byval alpha_threshold as integer)
declare sub gdk_pixbuf_render_to_drawable (byval pixbuf as GdkPixbuf ptr, byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src_x as integer, byval src_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer, byval dither as GdkRgbDither, byval x_dither as integer, byval y_dither as integer)
declare sub gdk_pixbuf_render_to_drawable_alpha (byval pixbuf as GdkPixbuf ptr, byval drawable as GdkDrawable ptr, byval src_x as integer, byval src_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer, byval alpha_mode as GdkPixbufAlphaMode, byval alpha_threshold as integer, byval dither as GdkRgbDither, byval x_dither as integer, byval y_dither as integer)
declare sub gdk_pixbuf_render_pixmap_and_mask_for_colormap (byval pixbuf as GdkPixbuf ptr, byval colormap as GdkColormap ptr, byval pixmap_return as GdkPixmap ptr ptr, byval mask_return as GdkBitmap ptr ptr, byval alpha_threshold as integer)
declare sub gdk_pixbuf_render_pixmap_and_mask (byval pixbuf as GdkPixbuf ptr, byval pixmap_return as GdkPixmap ptr ptr, byval mask_return as GdkBitmap ptr ptr, byval alpha_threshold as integer)
declare function gdk_pixbuf_get_from_drawable (byval dest as GdkPixbuf ptr, byval src as GdkDrawable ptr, byval cmap as GdkColormap ptr, byval src_x as integer, byval src_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer) as GdkPixbuf ptr
declare function gdk_pixbuf_get_from_image (byval dest as GdkPixbuf ptr, byval src as GdkImage ptr, byval cmap as GdkColormap ptr, byval src_x as integer, byval src_y as integer, byval dest_x as integer, byval dest_y as integer, byval width as integer, byval height as integer) as GdkPixbuf ptr

#endif
