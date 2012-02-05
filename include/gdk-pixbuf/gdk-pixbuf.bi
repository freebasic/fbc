' This is file gdk-pixbuf.bi
' (FreeBasic binding for gdk-pixbuf library version 2.28.0)
'
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'
'/* GdkPixbuf library - Main header file
 '*
 '* Copyright (C) 1999 The Free Software Foundation
 '*
 '* Authors: Mark Crichton <crichton@gimp.org>
 '*          Miguel de Icaza <miguel@gnu.org>
 '*          Federico Mena-Quintero <federico@gimp.org>
 '*          Havoc Pennington <hp@redhat.com>
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "gdk_pixbuf-2.0"

EXTERN "C"

#IFNDEF GDK_PIXBUF_H
#DEFINE GDK_PIXBUF_H
#DEFINE GDK_PIXBUF_H_INSIDE
#INCLUDE ONCE "glib.bi"

#IFNDEF GDK_PIXBUF_FEATURES_H
#DEFINE GDK_PIXBUF_FEATURES_H 1
#DEFINE GDK_PIXBUF_MAJOR (2)
#DEFINE GDK_PIXBUF_MINOR (22)
#DEFINE GDK_PIXBUF_MICRO (1)
#DEFINE GDK_PIXBUF_VERSION !"2.22.1"

EXTERN AS CONST guint gdk_pixbuf_major_version
EXTERN AS CONST guint gdk_pixbuf_minor_version
EXTERN AS CONST guint gdk_pixbuf_micro_version
EXTERN AS CONST ZSTRING PTR gdk_pixbuf_version_FB ALIAS "gdk_pixbuf_version"

#ENDIF ' GDK_PIXBUF_FEATURES_H

#INCLUDE ONCE "glib-object.bi"

#IFNDEF GDK_PIXBUF_CORE_H
#DEFINE GDK_PIXBUF_CORE_H

#INCLUDE ONCE "gio/gio.bi"

ENUM GdkPixbufAlphaMode
  GDK_PIXBUF_ALPHA_BILEVEL
  GDK_PIXBUF_ALPHA_FULL
END ENUM

ENUM GdkColorspace
  GDK_COLORSPACE_RGB
END ENUM

TYPE GdkPixbuf AS _GdkPixbuf

#DEFINE GDK_TYPE_PIXBUF (gdk_pixbuf_get_type ())
#DEFINE GDK_PIXBUF(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF, GdkPixbuf))
#DEFINE GDK_IS_PIXBUF(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF))

TYPE GdkPixbufDestroyNotify AS SUB(BYVAL AS guchar PTR, BYVAL AS gpointer)

#DEFINE GDK_PIXBUF_ERROR gdk_pixbuf_error_quark ()

ENUM GdkPixbufError
  GDK_PIXBUF_ERROR_CORRUPT_IMAGE
  GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY
  GDK_PIXBUF_ERROR_BAD_OPTION
  GDK_PIXBUF_ERROR_UNKNOWN_TYPE
  GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION
  GDK_PIXBUF_ERROR_FAILED
END ENUM

DECLARE FUNCTION gdk_pixbuf_error_quark() AS GQuark
DECLARE FUNCTION gdk_pixbuf_get_type() AS GType

#IFNDEF GDK_PIXBUF_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_pixbuf_ref(BYVAL AS GdkPixbuf PTR) AS GdkPixbuf PTR
DECLARE SUB gdk_pixbuf_unref(BYVAL AS GdkPixbuf PTR)

#ENDIF ' GDK_PIXBUF_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_pixbuf_get_colorspace(BYVAL AS CONST GdkPixbuf PTR) AS GdkColorspace
DECLARE FUNCTION gdk_pixbuf_get_n_channels(BYVAL AS CONST GdkPixbuf PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_get_has_alpha(BYVAL AS CONST GdkPixbuf PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_get_bits_per_sample(BYVAL AS CONST GdkPixbuf PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_get_pixels(BYVAL AS CONST GdkPixbuf PTR) AS guchar PTR
DECLARE FUNCTION gdk_pixbuf_get_width(BYVAL AS CONST GdkPixbuf PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_get_height(BYVAL AS CONST GdkPixbuf PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_get_rowstride(BYVAL AS CONST GdkPixbuf PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_new(BYVAL AS GdkColorspace, BYVAL AS gboolean, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_copy(BYVAL AS CONST GdkPixbuf PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_subpixbuf(BYVAL AS GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS GdkPixbuf PTR

#IFDEF G_OS_WIN32
#DEFINE gdk_pixbuf_new_from_file gdk_pixbuf_new_from_file_utf8
#DEFINE gdk_pixbuf_new_from_file_at_size gdk_pixbuf_new_from_file_at_size_utf8
#DEFINE gdk_pixbuf_new_from_file_at_scale gdk_pixbuf_new_from_file_at_scale_utf8
#ENDIF ' G_OS_WIN32

DECLARE FUNCTION gdk_pixbuf_new_from_file(BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_from_file_at_size(BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_from_file_at_scale(BYVAL AS CONST ZSTRING PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_from_data(BYVAL AS CONST guchar PTR, BYVAL AS GdkColorspace, BYVAL AS gboolean, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GdkPixbufDestroyNotify, BYVAL AS gpointer) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_from_xpm_data(BYVAL AS CONST ZSTRING PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_from_inline(BYVAL AS gint, BYVAL AS CONST guint8 PTR, BYVAL AS gboolean, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE SUB gdk_pixbuf_fill(BYVAL AS GdkPixbuf PTR, BYVAL AS guint32)

#IFDEF G_OS_WIN32
#DEFINE gdk_pixbuf_save gdk_pixbuf_save_utf8
#DEFINE gdk_pixbuf_savev gdk_pixbuf_savev_utf8
#ENDIF ' G_OS_WIN32

DECLARE FUNCTION gdk_pixbuf_save(BYVAL AS GdkPixbuf PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR, ...) AS gboolean
DECLARE FUNCTION gdk_pixbuf_savev(BYVAL AS GdkPixbuf PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean

TYPE GdkPixbufSaveFunc AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR, BYVAL AS gpointer) AS gboolean

DECLARE FUNCTION gdk_pixbuf_save_to_callback(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkPixbufSaveFunc, BYVAL AS gpointer, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR, ...) AS gboolean
DECLARE FUNCTION gdk_pixbuf_save_to_callbackv(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkPixbufSaveFunc, BYVAL AS gpointer, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_save_to_buffer(BYVAL AS GdkPixbuf PTR, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR, ...) AS gboolean
DECLARE FUNCTION gdk_pixbuf_save_to_bufferv(BYVAL AS GdkPixbuf PTR, BYVAL AS gchar PTR PTR, BYVAL AS gsize PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS ZSTRING PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_new_from_stream(BYVAL AS GInputStream PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_new_from_stream_at_scale(BYVAL AS GInputStream PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gboolean, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_save_to_stream(BYVAL AS GdkPixbuf PTR, BYVAL AS GOutputStream PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GCancellable PTR, BYVAL AS GError PTR PTR, ...) AS gboolean
DECLARE FUNCTION gdk_pixbuf_add_alpha(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS gboolean, BYVAL AS guchar, BYVAL AS guchar, BYVAL AS guchar) AS GdkPixbuf PTR
DECLARE SUB gdk_pixbuf_copy_area(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB gdk_pixbuf_saturate_and_pixelate(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gfloat, BYVAL AS gboolean)
DECLARE FUNCTION gdk_pixbuf_apply_embedded_orientation(BYVAL AS GdkPixbuf PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_get_option(BYVAL AS GdkPixbuf PTR, BYVAL AS CONST gchar PTR) AS G_CONST_RETURN gchar PTR

#ENDIF ' GDK_PIXBUF_CORE_H

#IFNDEF GDK_PIXBUF_TRANSFORM_H
#DEFINE GDK_PIXBUF_TRANSFORM_H

ENUM GdkInterpType
  GDK_INTERP_NEAREST
  GDK_INTERP_TILES
  GDK_INTERP_BILINEAR
  GDK_INTERP_HYPER
END ENUM

ENUM GdkPixbufRotation
  GDK_PIXBUF_ROTATE_NONE = 0
  GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE = 90
  GDK_PIXBUF_ROTATE_UPSIDEDOWN = 180
  GDK_PIXBUF_ROTATE_CLOCKWISE = 270
END ENUM

DECLARE SUB gdk_pixbuf_scale(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS GdkInterpType)
DECLARE SUB gdk_pixbuf_composite(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS GdkInterpType, BYVAL AS INTEGER)
DECLARE SUB gdk_pixbuf_composite_color(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS GdkInterpType, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS guint32, BYVAL AS guint32)
DECLARE FUNCTION gdk_pixbuf_scale_simple(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GdkInterpType) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_composite_color_simple(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GdkInterpType, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS guint32, BYVAL AS guint32) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_rotate_simple(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS GdkPixbufRotation) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_flip(BYVAL AS CONST GdkPixbuf PTR, BYVAL AS gboolean) AS GdkPixbuf PTR

#ENDIF ' GDK_PIXBUF_TRANSFORM_H

#IFNDEF GDK_PIXBUF_ANIMATION_H
#DEFINE GDK_PIXBUF_ANIMATION_H

TYPE GdkPixbufAnimation AS _GdkPixbufAnimation
TYPE GdkPixbufAnimationIter AS _GdkPixbufAnimationIter

#DEFINE GDK_TYPE_PIXBUF_ANIMATION (gdk_pixbuf_animation_get_type ())
#DEFINE GDK_PIXBUF_ANIMATION(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF_ANIMATION, GdkPixbufAnimation))
#DEFINE GDK_IS_PIXBUF_ANIMATION(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF_ANIMATION))
#DEFINE GDK_TYPE_PIXBUF_ANIMATION_ITER (gdk_pixbuf_animation_iter_get_type ())
#DEFINE GDK_PIXBUF_ANIMATION_ITER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIter))
#DEFINE GDK_IS_PIXBUF_ANIMATION_ITER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF_ANIMATION_ITER))

DECLARE FUNCTION gdk_pixbuf_animation_get_type() AS GType

#IFDEF G_OS_WIN32
#DEFINE gdk_pixbuf_animation_new_from_file gdk_pixbuf_animation_new_from_file_utf8
#ENDIF ' G_OS_WIN32

DECLARE FUNCTION gdk_pixbuf_animation_new_from_file(BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS GdkPixbufAnimation PTR

#IFNDEF GDK_PIXBUF_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_pixbuf_animation_ref(BYVAL AS GdkPixbufAnimation PTR) AS GdkPixbufAnimation PTR
DECLARE SUB gdk_pixbuf_animation_unref(BYVAL AS GdkPixbufAnimation PTR)

#ENDIF ' GDK_PIXBUF_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_pixbuf_animation_get_width(BYVAL AS GdkPixbufAnimation PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_animation_get_height(BYVAL AS GdkPixbufAnimation PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_animation_is_static_image(BYVAL AS GdkPixbufAnimation PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_animation_get_static_image(BYVAL AS GdkPixbufAnimation PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_animation_get_iter(BYVAL AS GdkPixbufAnimation PTR, BYVAL AS CONST GTimeVal PTR) AS GdkPixbufAnimationIter PTR
DECLARE FUNCTION gdk_pixbuf_animation_iter_get_type() AS GType
DECLARE FUNCTION gdk_pixbuf_animation_iter_get_delay_time(BYVAL AS GdkPixbufAnimationIter PTR) AS INTEGER
DECLARE FUNCTION gdk_pixbuf_animation_iter_get_pixbuf(BYVAL AS GdkPixbufAnimationIter PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_animation_iter_on_currently_loading_frame(BYVAL AS GdkPixbufAnimationIter PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_animation_iter_advance(BYVAL AS GdkPixbufAnimationIter PTR, BYVAL AS CONST GTimeVal PTR) AS gboolean

#IFDEF GDK_PIXBUF_ENABLE_BACKEND

TYPE GdkPixbufAnimationClass AS _GdkPixbufAnimationClass

#DEFINE GDK_PIXBUF_ANIMATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXBUF_ANIMATION, GdkPixbufAnimationClass))
#DEFINE GDK_IS_PIXBUF_ANIMATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXBUF_ANIMATION))
#DEFINE GDK_PIXBUF_ANIMATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXBUF_ANIMATION, GdkPixbufAnimationClass))

TYPE _GdkPixbufAnimation
  AS GObject parent_instance
END TYPE

TYPE _GdkPixbufAnimationClass
  AS GObjectClass parent_class
  is_static_image AS FUNCTION(BYVAL AS GdkPixbufAnimation PTR) AS gboolean
  get_static_image AS FUNCTION(BYVAL AS GdkPixbufAnimation PTR) AS GdkPixbuf PTR
  get_size AS SUB(BYVAL AS GdkPixbufAnimation PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR)
  get_iter AS FUNCTION(BYVAL AS GdkPixbufAnimation PTR, BYVAL AS CONST GTimeVal PTR) AS GdkPixbufAnimationIter PTR
END TYPE

TYPE GdkPixbufAnimationIterClass AS _GdkPixbufAnimationIterClass

#DEFINE GDK_PIXBUF_ANIMATION_ITER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIterClass))
#DEFINE GDK_IS_PIXBUF_ANIMATION_ITER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXBUF_ANIMATION_ITER))
#DEFINE GDK_PIXBUF_ANIMATION_ITER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIterClass))

TYPE _GdkPixbufAnimationIter
  AS GObject parent_instance
END TYPE

TYPE _GdkPixbufAnimationIterClass
  AS GObjectClass parent_class
  get_delay_time AS FUNCTION(BYVAL AS GdkPixbufAnimationIter PTR) AS INTEGER
  get_pixbuf AS FUNCTION(BYVAL AS GdkPixbufAnimationIter PTR) AS GdkPixbuf PTR
  on_currently_loading_frame AS FUNCTION(BYVAL AS GdkPixbufAnimationIter PTR) AS gboolean
  advance AS FUNCTION(BYVAL AS GdkPixbufAnimationIter PTR, BYVAL AS CONST GTimeVal PTR) AS gboolean
END TYPE

DECLARE FUNCTION gdk_pixbuf_non_anim_get_type() AS GType
DECLARE FUNCTION gdk_pixbuf_non_anim_new(BYVAL AS GdkPixbuf PTR) AS GdkPixbufAnimation PTR

#ENDIF ' GDK_PIXBUF_ENABLE_BACKEND
#ENDIF ' GDK_PIXBUF_ANIMATION_H

#IFNDEF GDK_PIXBUF_SIMPLE_ANIM_H
#DEFINE GDK_PIXBUF_SIMPLE_ANIM_H

TYPE GdkPixbufSimpleAnim AS _GdkPixbufSimpleAnim
TYPE GdkPixbufSimpleAnimClass AS _GdkPixbufSimpleAnimClass

#DEFINE GDK_TYPE_PIXBUF_SIMPLE_ANIM (gdk_pixbuf_simple_anim_get_type ())
#DEFINE GDK_PIXBUF_SIMPLE_ANIM(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXBUF_SIMPLE_ANIM, GdkPixbufSimpleAnim))
#DEFINE GDK_IS_PIXBUF_SIMPLE_ANIM(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXBUF_SIMPLE_ANIM))
#DEFINE GDK_PIXBUF_SIMPLE_ANIM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXBUF_SIMPLE_ANIM, GdkPixbufSimpleAnimClass))
#DEFINE GDK_IS_PIXBUF_SIMPLE_ANIM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXBUF_SIMPLE_ANIM))
#DEFINE GDK_PIXBUF_SIMPLE_ANIM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXBUF_SIMPLE_ANIM, GdkPixbufSimpleAnimClass))

DECLARE FUNCTION gdk_pixbuf_simple_anim_get_type() AS GType
DECLARE FUNCTION gdk_pixbuf_simple_anim_iter_get_type() AS GType
DECLARE FUNCTION gdk_pixbuf_simple_anim_new(BYVAL AS gint, BYVAL AS gint, BYVAL AS gfloat) AS GdkPixbufSimpleAnim PTR
DECLARE SUB gdk_pixbuf_simple_anim_add_frame(BYVAL AS GdkPixbufSimpleAnim PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gdk_pixbuf_simple_anim_set_loop(BYVAL AS GdkPixbufSimpleAnim PTR, BYVAL AS gboolean)
DECLARE FUNCTION gdk_pixbuf_simple_anim_get_loop(BYVAL AS GdkPixbufSimpleAnim PTR) AS gboolean

#ENDIF ' GDK_PIXBUF_SIMPLE_ANIM_H

#IFNDEF GDK_PIXBUF_IO_H
#DEFINE GDK_PIXBUF_IO_H
#INCLUDE ONCE "crt/stdio.bi"

#INCLUDE ONCE "gmodule.bi"

TYPE GdkPixbufFormat AS _GdkPixbufFormat

DECLARE FUNCTION gdk_pixbuf_format_get_type() AS GType
DECLARE FUNCTION gdk_pixbuf_get_formats() AS GSList PTR
DECLARE FUNCTION gdk_pixbuf_format_get_name(BYVAL AS GdkPixbufFormat PTR) AS gchar PTR
DECLARE FUNCTION gdk_pixbuf_format_get_description(BYVAL AS GdkPixbufFormat PTR) AS gchar PTR
DECLARE FUNCTION gdk_pixbuf_format_get_mime_types(BYVAL AS GdkPixbufFormat PTR) AS gchar PTR PTR
DECLARE FUNCTION gdk_pixbuf_format_get_extensions(BYVAL AS GdkPixbufFormat PTR) AS gchar PTR PTR
DECLARE FUNCTION gdk_pixbuf_format_is_writable(BYVAL AS GdkPixbufFormat PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_format_is_scalable(BYVAL AS GdkPixbufFormat PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_format_is_disabled(BYVAL AS GdkPixbufFormat PTR) AS gboolean
DECLARE SUB gdk_pixbuf_format_set_disabled(BYVAL AS GdkPixbufFormat PTR, BYVAL AS gboolean)
DECLARE FUNCTION gdk_pixbuf_format_get_license(BYVAL AS GdkPixbufFormat PTR) AS gchar PTR
DECLARE FUNCTION gdk_pixbuf_get_file_info(BYVAL AS CONST gchar PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkPixbufFormat PTR
DECLARE FUNCTION gdk_pixbuf_format_copy(BYVAL AS CONST GdkPixbufFormat PTR) AS GdkPixbufFormat PTR
DECLARE SUB gdk_pixbuf_format_free(BYVAL AS GdkPixbufFormat PTR)

#IFDEF GDK_PIXBUF_ENABLE_BACKEND

TYPE GdkPixbufModuleSizeFunc AS SUB(BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gpointer)
TYPE GdkPixbufModulePreparedFunc AS SUB(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkPixbufAnimation PTR, BYVAL AS gpointer)
TYPE GdkPixbufModuleUpdatedFunc AS SUB(BYVAL AS GdkPixbuf PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS gpointer)
TYPE GdkPixbufModulePattern AS _GdkPixbufModulePattern

TYPE _GdkPixbufModulePattern
  AS ZSTRING PTR prefix
  AS ZSTRING PTR mask
  AS INTEGER relevance
END TYPE

TYPE GdkPixbufModule AS _GdkPixbufModule

TYPE _GdkPixbufModule
  AS ZSTRING PTR module_name
  AS ZSTRING PTR module_path
  AS GModule PTR module
  AS GdkPixbufFormat PTR info
  load AS FUNCTION(BYVAL AS FILE PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
  load_xpm_data AS FUNCTION(BYVAL AS CONST ZSTRING PTR PTR) AS GdkPixbuf PTR
  begin_load AS FUNCTION(BYVAL AS GdkPixbufModuleSizeFunc, BYVAL AS GdkPixbufModulePreparedFunc, BYVAL AS GdkPixbufModuleUpdatedFunc, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gpointer
  stop_load AS FUNCTION(BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean
  load_increment AS FUNCTION(BYVAL AS gpointer, BYVAL AS CONST guchar PTR, BYVAL AS guint, BYVAL AS GError PTR PTR) AS gboolean
  load_animation AS FUNCTION(BYVAL AS FILE PTR, BYVAL AS GError PTR PTR) AS GdkPixbufAnimation PTR
  save AS FUNCTION(BYVAL AS FILE PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
  save_to_callback AS FUNCTION(BYVAL AS GdkPixbufSaveFunc, BYVAL AS gpointer, BYVAL AS GdkPixbuf PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS gboolean
  _reserved1 AS SUB()
  _reserved2 AS SUB()
  _reserved3 AS SUB()
  _reserved4 AS SUB()
  _reserved5 AS SUB()
END TYPE

TYPE GdkPixbufModuleFillVtableFunc AS SUB(BYVAL AS GdkPixbufModule PTR)
TYPE GdkPixbufModuleFillInfoFunc AS SUB(BYVAL AS GdkPixbufFormat PTR)

DECLARE FUNCTION gdk_pixbuf_set_option(BYVAL AS GdkPixbuf PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean

ENUM GdkPixbufFormatFlags
  GDK_PIXBUF_FORMAT_WRITABLE = 1 SHL 0
  GDK_PIXBUF_FORMAT_SCALABLE = 1 SHL 1
  GDK_PIXBUF_FORMAT_THREADSAFE = 1 SHL 2
END ENUM

TYPE _GdkPixbufFormat
  AS gchar PTR name
  AS GdkPixbufModulePattern PTR signature
  AS gchar PTR domain
  AS gchar PTR description
  AS gchar PTR PTR mime_types
  AS gchar PTR PTR extensions
  AS guint32 flags
  AS gboolean disabled
  AS gchar PTR license
END TYPE

#ENDIF ' GDK_PIXBUF_ENABLE_BACKEND
#ENDIF ' GDK_PIXBUF_IO_H

#IFNDEF GDK_PIXBUF_LOADER_H
#DEFINE GDK_PIXBUF_LOADER_H

#DEFINE GDK_TYPE_PIXBUF_LOADER (gdk_pixbuf_loader_get_type ())
#DEFINE GDK_PIXBUF_LOADER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoader))
#DEFINE GDK_PIXBUF_LOADER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoaderClass))
#DEFINE GDK_IS_PIXBUF_LOADER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GDK_TYPE_PIXBUF_LOADER))
#DEFINE GDK_IS_PIXBUF_LOADER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXBUF_LOADER))
#DEFINE GDK_PIXBUF_LOADER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoaderClass))

TYPE GdkPixbufLoader AS _GdkPixbufLoader

TYPE _GdkPixbufLoader
  AS GObject parent_instance
  AS gpointer priv
END TYPE

TYPE GdkPixbufLoaderClass AS _GdkPixbufLoaderClass

TYPE _GdkPixbufLoaderClass
  AS GObjectClass parent_class
  size_prepared AS SUB(BYVAL AS GdkPixbufLoader PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
  area_prepared AS SUB(BYVAL AS GdkPixbufLoader PTR)
  area_updated AS SUB(BYVAL AS GdkPixbufLoader PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)
  closed AS SUB(BYVAL AS GdkPixbufLoader PTR)
END TYPE

DECLARE FUNCTION gdk_pixbuf_loader_get_type() AS GType
DECLARE FUNCTION gdk_pixbuf_loader_new() AS GdkPixbufLoader PTR
DECLARE FUNCTION gdk_pixbuf_loader_new_with_type(BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS GdkPixbufLoader PTR
DECLARE FUNCTION gdk_pixbuf_loader_new_with_mime_type(BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS GdkPixbufLoader PTR
DECLARE SUB gdk_pixbuf_loader_set_size(BYVAL AS GdkPixbufLoader PTR, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE FUNCTION gdk_pixbuf_loader_write(BYVAL AS GdkPixbufLoader PTR, BYVAL AS CONST guchar PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_loader_get_pixbuf(BYVAL AS GdkPixbufLoader PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_loader_get_animation(BYVAL AS GdkPixbufLoader PTR) AS GdkPixbufAnimation PTR
DECLARE FUNCTION gdk_pixbuf_loader_close(BYVAL AS GdkPixbufLoader PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gdk_pixbuf_loader_get_format(BYVAL AS GdkPixbufLoader PTR) AS GdkPixbufFormat PTR

#ENDIF ' GDK_PIXBUF_LOADER_H

#IFNDEF __GDK_PIXBUF_ENUM_TYPES_H__
#DEFINE __GDK_PIXBUF_ENUM_TYPES_H__

DECLARE FUNCTION gdk_pixbuf_alpha_mode_get_type() AS GType
#DEFINE GDK_TYPE_PIXBUF_ALPHA_MODE (gdk_pixbuf_alpha_mode_get_type ())
DECLARE FUNCTION gdk_colorspace_get_type() AS GType
#DEFINE GDK_TYPE_COLORSPACE (gdk_colorspace_get_type ())
DECLARE FUNCTION gdk_pixbuf_error_get_type() AS GType
#DEFINE GDK_TYPE_PIXBUF_ERROR (gdk_pixbuf_error_get_type ())
DECLARE FUNCTION gdk_interp_type_get_type() AS GType
#DEFINE GDK_TYPE_INTERP_TYPE (gdk_interp_type_get_type ())
DECLARE FUNCTION gdk_pixbuf_rotation_get_type() AS GType
#DEFINE GDK_TYPE_PIXBUF_ROTATION (gdk_pixbuf_rotation_get_type ())
#ENDIF ' __GDK_PIXBUF_ENUM_TYPES_H__

#UNDEF GDK_PIXBUF_H_INSIDE
#ENDIF ' GDK_PIXBUF_H

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
