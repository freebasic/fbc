''
''
'' gdk-pixbuf-io -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_io_bi__
#define __gdk_pixbuf_io_bi__

#include once "gtk/glib.bi"
#include once "gtk/gmodule.bi"
#include once "gtk/gdk-pixbuf/gdk-pixbuf-core.bi"
#include once "gtk/gdk-pixbuf/gdk-pixbuf-animation.bi"

type GdkPixbufFormat as _GdkPixbufFormat

declare function gdk_pixbuf_get_formats cdecl alias "gdk_pixbuf_get_formats" () as GSList ptr
declare function gdk_pixbuf_format_get_name cdecl alias "gdk_pixbuf_format_get_name" (byval format as GdkPixbufFormat ptr) as gchar ptr
declare function gdk_pixbuf_format_get_description cdecl alias "gdk_pixbuf_format_get_description" (byval format as GdkPixbufFormat ptr) as gchar ptr
declare function gdk_pixbuf_format_get_mime_types cdecl alias "gdk_pixbuf_format_get_mime_types" (byval format as GdkPixbufFormat ptr) as gchar ptr ptr
declare function gdk_pixbuf_format_get_extensions cdecl alias "gdk_pixbuf_format_get_extensions" (byval format as GdkPixbufFormat ptr) as gchar ptr ptr
declare function gdk_pixbuf_format_is_writable cdecl alias "gdk_pixbuf_format_is_writable" (byval format as GdkPixbufFormat ptr) as gboolean
declare function gdk_pixbuf_format_is_scalable cdecl alias "gdk_pixbuf_format_is_scalable" (byval format as GdkPixbufFormat ptr) as gboolean
declare function gdk_pixbuf_format_is_disabled cdecl alias "gdk_pixbuf_format_is_disabled" (byval format as GdkPixbufFormat ptr) as gboolean
declare sub gdk_pixbuf_format_set_disabled cdecl alias "gdk_pixbuf_format_set_disabled" (byval format as GdkPixbufFormat ptr, byval disabled as gboolean)
declare function gdk_pixbuf_format_get_license cdecl alias "gdk_pixbuf_format_get_license" (byval format as GdkPixbufFormat ptr) as gchar ptr
declare function gdk_pixbuf_get_file_info cdecl alias "gdk_pixbuf_get_file_info" (byval filename as gchar ptr, byval width as gint ptr, byval height as gint ptr) as GdkPixbufFormat ptr

#endif
