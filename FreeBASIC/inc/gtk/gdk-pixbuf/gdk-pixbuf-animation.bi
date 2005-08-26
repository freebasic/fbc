''
''
'' gdk-pixbuf-animation -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdk_pixbuf_animation_bi__
#define __gdk_pixbuf_animation_bi__

#include once "gtk/glib.bi"
#include once "gtk/glib-object.bi"
#include once "gtk/gdk-pixbuf/gdk-pixbuf-core.bi"

type GdkPixbufAnimation as _GdkPixbufAnimation
type GdkPixbufAnimationIter as _GdkPixbufAnimationIter

declare function gdk_pixbuf_animation_get_type cdecl alias "gdk_pixbuf_animation_get_type" () as GType
declare function gdk_pixbuf_animation_new_from_file cdecl alias "gdk_pixbuf_animation_new_from_file" (byval filename as zstring ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
declare function gdk_pixbuf_animation_ref cdecl alias "gdk_pixbuf_animation_ref" (byval animation as GdkPixbufAnimation ptr) as GdkPixbufAnimation ptr
declare sub gdk_pixbuf_animation_unref cdecl alias "gdk_pixbuf_animation_unref" (byval animation as GdkPixbufAnimation ptr)
declare function gdk_pixbuf_animation_get_width cdecl alias "gdk_pixbuf_animation_get_width" (byval animation as GdkPixbufAnimation ptr) as integer
declare function gdk_pixbuf_animation_get_height cdecl alias "gdk_pixbuf_animation_get_height" (byval animation as GdkPixbufAnimation ptr) as integer
declare function gdk_pixbuf_animation_is_static_image cdecl alias "gdk_pixbuf_animation_is_static_image" (byval animation as GdkPixbufAnimation ptr) as gboolean
declare function gdk_pixbuf_animation_get_static_image cdecl alias "gdk_pixbuf_animation_get_static_image" (byval animation as GdkPixbufAnimation ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_animation_get_iter cdecl alias "gdk_pixbuf_animation_get_iter" (byval animation as GdkPixbufAnimation ptr, byval start_time as GTimeVal ptr) as GdkPixbufAnimationIter ptr
declare function gdk_pixbuf_animation_iter_get_type cdecl alias "gdk_pixbuf_animation_iter_get_type" () as GType
declare function gdk_pixbuf_animation_iter_get_delay_time cdecl alias "gdk_pixbuf_animation_iter_get_delay_time" (byval iter as GdkPixbufAnimationIter ptr) as integer
declare function gdk_pixbuf_animation_iter_get_pixbuf cdecl alias "gdk_pixbuf_animation_iter_get_pixbuf" (byval iter as GdkPixbufAnimationIter ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_animation_iter_on_currently_loading_frame cdecl alias "gdk_pixbuf_animation_iter_on_currently_loading_frame" (byval iter as GdkPixbufAnimationIter ptr) as gboolean
declare function gdk_pixbuf_animation_iter_advance cdecl alias "gdk_pixbuf_animation_iter_advance" (byval iter as GdkPixbufAnimationIter ptr, byval current_time as GTimeVal ptr) as gboolean

#endif
