''
''
'' gdk-pixbuf-transform -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_transform_bi__
#define __gdk_pixbuf_transform_bi__

#include once "gtk/glib.bi"
#include once "gdk-pixbuf-core.bi"

enum GdkInterpType
	GDK_INTERP_NEAREST
	GDK_INTERP_TILES
	GDK_INTERP_BILINEAR
	GDK_INTERP_HYPER
end enum


enum GdkPixbufRotation
	GDK_PIXBUF_ROTATE_NONE = 0
	GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE = 90
	GDK_PIXBUF_ROTATE_UPSIDEDOWN = 180
	GDK_PIXBUF_ROTATE_CLOCKWISE = 270
end enum


declare sub gdk_pixbuf_scale (byval src as GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval dest_x as integer, byval dest_y as integer, byval dest_width as integer, byval dest_height as integer, byval offset_x as double, byval offset_y as double, byval scale_x as double, byval scale_y as double, byval interp_type as GdkInterpType)
declare sub gdk_pixbuf_composite (byval src as GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval dest_x as integer, byval dest_y as integer, byval dest_width as integer, byval dest_height as integer, byval offset_x as double, byval offset_y as double, byval scale_x as double, byval scale_y as double, byval interp_type as GdkInterpType, byval overall_alpha as integer)
declare sub gdk_pixbuf_composite_color (byval src as GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval dest_x as integer, byval dest_y as integer, byval dest_width as integer, byval dest_height as integer, byval offset_x as double, byval offset_y as double, byval scale_x as double, byval scale_y as double, byval interp_type as GdkInterpType, byval overall_alpha as integer, byval check_x as integer, byval check_y as integer, byval check_size as integer, byval color1 as guint32, byval color2 as guint32)
declare function gdk_pixbuf_scale_simple (byval src as GdkPixbuf ptr, byval dest_width as integer, byval dest_height as integer, byval interp_type as GdkInterpType) as GdkPixbuf ptr
declare function gdk_pixbuf_composite_color_simple (byval src as GdkPixbuf ptr, byval dest_width as integer, byval dest_height as integer, byval interp_type as GdkInterpType, byval overall_alpha as integer, byval check_size as integer, byval color1 as guint32, byval color2 as guint32) as GdkPixbuf ptr
declare function gdk_pixbuf_rotate_simple (byval src as GdkPixbuf ptr, byval angle as GdkPixbufRotation) as GdkPixbuf ptr
declare function gdk_pixbuf_flip (byval src as GdkPixbuf ptr, byval horizontal as gboolean) as GdkPixbuf ptr

#endif
