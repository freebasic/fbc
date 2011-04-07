''
''
'' gdk-pixbuf-core -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_core_bi__
#define __gdk_pixbuf_core_bi__

#include once "gtk/glib.bi"
#include once "gtk/glib-object.bi"

#define GDK_TYPE_PIXBUF (gdk_pixbuf_get_type ())
#define GDK_PIXBUF(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF, GdkPixbuf))
#define GDK_IS_PIXBUF(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF))

enum GdkPixbufAlphaMode
	GDK_PIXBUF_ALPHA_BILEVEL
	GDK_PIXBUF_ALPHA_FULL
end enum


enum GdkColorspace
	GDK_COLORSPACE_RGB
end enum

type GdkPixbuf as _GdkPixbuf
type GdkPixbufDestroyNotify as sub cdecl(byval as guchar ptr, byval as gpointer)

enum GdkPixbufError
	GDK_PIXBUF_ERROR_CORRUPT_IMAGE
	GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY
	GDK_PIXBUF_ERROR_BAD_OPTION
	GDK_PIXBUF_ERROR_UNKNOWN_TYPE
	GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION
	GDK_PIXBUF_ERROR_FAILED
end enum


declare function gdk_pixbuf_error_quark () as GQuark
declare function gdk_pixbuf_get_type () as GType
declare function gdk_pixbuf_ref (byval pixbuf as GdkPixbuf ptr) as GdkPixbuf ptr
declare sub gdk_pixbuf_unref (byval pixbuf as GdkPixbuf ptr)
declare function gdk_pixbuf_get_colorspace (byval pixbuf as GdkPixbuf ptr) as GdkColorspace
declare function gdk_pixbuf_get_n_channels (byval pixbuf as GdkPixbuf ptr) as integer
declare function gdk_pixbuf_get_has_alpha (byval pixbuf as GdkPixbuf ptr) as gboolean
declare function gdk_pixbuf_get_bits_per_sample (byval pixbuf as GdkPixbuf ptr) as integer
declare function gdk_pixbuf_get_pixels (byval pixbuf as GdkPixbuf ptr) as guchar ptr
declare function gdk_pixbuf_get_width (byval pixbuf as GdkPixbuf ptr) as integer
declare function gdk_pixbuf_get_height (byval pixbuf as GdkPixbuf ptr) as integer
declare function gdk_pixbuf_get_rowstride (byval pixbuf as GdkPixbuf ptr) as integer
declare function gdk_pixbuf_new (byval colorspace as GdkColorspace, byval has_alpha as gboolean, byval bits_per_sample as integer, byval width as integer, byval height as integer) as GdkPixbuf ptr
declare function gdk_pixbuf_copy (byval pixbuf as GdkPixbuf ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_subpixbuf (byval src_pixbuf as GdkPixbuf ptr, byval src_x as integer, byval src_y as integer, byval width as integer, byval height as integer) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_file (byval filename as zstring ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_file_at_size (byval filename as zstring ptr, byval width as integer, byval height as integer, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_file_at_scale (byval filename as zstring ptr, byval width as integer, byval height as integer, byval preserve_aspect_ratio as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_data (byval data as guchar ptr, byval colorspace as GdkColorspace, byval has_alpha as gboolean, byval bits_per_sample as integer, byval width as integer, byval height as integer, byval rowstride as integer, byval destroy_fn as GdkPixbufDestroyNotify, byval destroy_fn_data as gpointer) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_xpm_data (byval data as byte ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_inline (byval data_length as gint, byval data as guint8 ptr, byval copy_pixels as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gdk_pixbuf_fill (byval pixbuf as GdkPixbuf ptr, byval pixel as guint32)
declare function gdk_pixbuf_save (byval pixbuf as GdkPixbuf ptr, byval filename as zstring ptr, byval type as zstring ptr, byval error as GError ptr ptr, ...) as gboolean
declare function gdk_pixbuf_savev (byval pixbuf as GdkPixbuf ptr, byval filename as zstring ptr, byval type as zstring ptr, byval option_keys as byte ptr ptr, byval option_values as byte ptr ptr, byval error as GError ptr ptr) as gboolean

type GdkPixbufSaveFunc as function cdecl(byval as zstring ptr, byval as gsize, byval as GError ptr ptr, byval as gpointer) as gboolean

declare function gdk_pixbuf_save_to_callback (byval pixbuf as GdkPixbuf ptr, byval save_func as GdkPixbufSaveFunc, byval user_data as gpointer, byval type as zstring ptr, byval error as GError ptr ptr, ...) as gboolean
declare function gdk_pixbuf_save_to_callbackv (byval pixbuf as GdkPixbuf ptr, byval save_func as GdkPixbufSaveFunc, byval user_data as gpointer, byval type as zstring ptr, byval option_keys as byte ptr ptr, byval option_values as byte ptr ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_save_to_buffer (byval pixbuf as GdkPixbuf ptr, byval buffer as zstring ptr ptr, byval buffer_size as gsize ptr, byval type as zstring ptr, byval error as GError ptr ptr, ...) as gboolean
declare function gdk_pixbuf_save_to_bufferv (byval pixbuf as GdkPixbuf ptr, byval buffer as zstring ptr ptr, byval buffer_size as gsize ptr, byval type as zstring ptr, byval option_keys as byte ptr ptr, byval option_values as byte ptr ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_add_alpha (byval pixbuf as GdkPixbuf ptr, byval substitute_color as gboolean, byval r as guchar, byval g as guchar, byval b as guchar) as GdkPixbuf ptr
declare sub gdk_pixbuf_copy_area (byval src_pixbuf as GdkPixbuf ptr, byval src_x as integer, byval src_y as integer, byval width as integer, byval height as integer, byval dest_pixbuf as GdkPixbuf ptr, byval dest_x as integer, byval dest_y as integer)
declare sub gdk_pixbuf_saturate_and_pixelate (byval src as GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval saturation as gfloat, byval pixelate as gboolean)
declare function gdk_pixbuf_get_option (byval pixbuf as GdkPixbuf ptr, byval key as zstring ptr) as zstring ptr

#endif
