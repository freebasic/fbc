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
#include once "gdk-pixbuf-core.bi"

#define GDK_TYPE_PIXBUF_ANIMATION (gdk_pixbuf_animation_get_type ())
#define GDK_PIXBUF_ANIMATION(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF_ANIMATION, GdkPixbufAnimation))
#define GDK_IS_PIXBUF_ANIMATION(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF_ANIMATION))

#define GDK_TYPE_PIXBUF_ANIMATION_ITER (gdk_pixbuf_animation_iter_get_type ())
#define GDK_PIXBUF_ANIMATION_ITER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIter))
#define GDK_IS_PIXBUF_ANIMATION_ITER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF_ANIMATION_ITER))

#define GDK_PIXBUF_ANIMATION_ITER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIterClass))
#define GDK_IS_PIXBUF_ANIMATION_ITER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXBUF_ANIMATION_ITER))
#define GDK_PIXBUF_ANIMATION_ITER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIterClass))

type GdkPixbufAnimation as _GdkPixbufAnimation
type GdkPixbufAnimationIter as _GdkPixbufAnimationIter

declare function gdk_pixbuf_animation_get_type () as GType
declare function gdk_pixbuf_animation_new_from_file (byval filename as zstring ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
declare function gdk_pixbuf_animation_ref (byval animation as GdkPixbufAnimation ptr) as GdkPixbufAnimation ptr
declare sub gdk_pixbuf_animation_unref (byval animation as GdkPixbufAnimation ptr)
declare function gdk_pixbuf_animation_get_width (byval animation as GdkPixbufAnimation ptr) as integer
declare function gdk_pixbuf_animation_get_height (byval animation as GdkPixbufAnimation ptr) as integer
declare function gdk_pixbuf_animation_is_static_image (byval animation as GdkPixbufAnimation ptr) as gboolean
declare function gdk_pixbuf_animation_get_static_image (byval animation as GdkPixbufAnimation ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_animation_get_iter (byval animation as GdkPixbufAnimation ptr, byval start_time as GTimeVal ptr) as GdkPixbufAnimationIter ptr
declare function gdk_pixbuf_animation_iter_get_type () as GType
declare function gdk_pixbuf_animation_iter_get_delay_time (byval iter as GdkPixbufAnimationIter ptr) as integer
declare function gdk_pixbuf_animation_iter_get_pixbuf (byval iter as GdkPixbufAnimationIter ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_animation_iter_on_currently_loading_frame (byval iter as GdkPixbufAnimationIter ptr) as gboolean
declare function gdk_pixbuf_animation_iter_advance (byval iter as GdkPixbufAnimationIter ptr, byval current_time as GTimeVal ptr) as gboolean

#endif
