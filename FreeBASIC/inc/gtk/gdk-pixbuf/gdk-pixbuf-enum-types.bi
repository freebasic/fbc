''
''
'' gdk-pixbuf-enum-types -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_enum_types_bi__
#define __gdk_pixbuf_enum_types_bi__

#include once "gtk/glib-object.bi"

#define GDK_TYPE_PIXBUF_ALPHA_MODE gdk_pixbuf_alpha_mode_get_type()
#define GDK_TYPE_COLORSPACE gdk_colorspace_get_type()
#define GDK_TYPE_PIXBUF_ERROR gdk_pixbuf_error_get_type()
#define GDK_TYPE_INTERP_TYPE gdk_interp_type_get_type()
#define GDK_TYPE_PIXBUF_ROTATION gdk_pixbuf_rotation_get_type()

declare function gdk_pixbuf_alpha_mode_get_type () as GType
declare function gdk_colorspace_get_type () as GType
declare function gdk_pixbuf_error_get_type () as GType
declare function gdk_interp_type_get_type () as GType
declare function gdk_pixbuf_rotation_get_type () as GType

#endif
