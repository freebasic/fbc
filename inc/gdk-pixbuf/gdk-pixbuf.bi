'' FreeBASIC binding for gdk-pixbuf-2.30.8
''
'' based on the C header files:
''   GdkPixbuf library - Main header file
''
''   Copyright (C) 1999 The Free Software Foundation
''
''   Authors: Mark Crichton <crichton@gimp.org>
''            Miguel de Icaza <miguel@gnu.org>
''            Federico Mena-Quintero <federico@gimp.org>
''            Havoc Pennington <hp@redhat.com>
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gdk_pixbuf-2.0"

#include once "glib.bi"
#include once "glib-object.bi"
#include once "gio/gio.bi"
#include once "crt/stdio.bi"
#include once "gmodule.bi"

'' The following symbols have been renamed:
''     #define GDK_PIXBUF_VERSION => GDK_PIXBUF_VERSION_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define GDK_PIXBUF_H
#define GDK_PIXBUF_H_INSIDE
const GDK_PIXBUF_FEATURES_H = 1
const GDK_PIXBUF_MAJOR = 2
const GDK_PIXBUF_MINOR = 30
const GDK_PIXBUF_MICRO = 8
#define GDK_PIXBUF_VERSION_ "2.30.8"

#if (defined(__FB_WIN32__) and (not defined(GDK_PIXBUF_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import gdk_pixbuf_major_version as const guint
	extern import gdk_pixbuf_minor_version as const guint
	extern import gdk_pixbuf_micro_version as const guint
	extern import gdk_pixbuf_version as const zstring ptr
#else
	extern gdk_pixbuf_major_version as const guint
	extern gdk_pixbuf_minor_version as const guint
	extern gdk_pixbuf_micro_version as const guint
	extern gdk_pixbuf_version as const zstring ptr
#endif

#define GDK_PIXBUF_CORE_H

type GdkPixbufAlphaMode as long
enum
	GDK_PIXBUF_ALPHA_BILEVEL
	GDK_PIXBUF_ALPHA_FULL
end enum

type GdkColorspace as long
enum
	GDK_COLORSPACE_RGB
end enum

type GdkPixbuf as _GdkPixbuf
#define GDK_TYPE_PIXBUF gdk_pixbuf_get_type()
#define GDK_PIXBUF(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_PIXBUF, GdkPixbuf)
#define GDK_IS_PIXBUF(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_PIXBUF)
type GdkPixbufDestroyNotify as sub(byval pixels as guchar ptr, byval data as gpointer)
#define GDK_PIXBUF_ERROR gdk_pixbuf_error_quark()

type GdkPixbufError as long
enum
	GDK_PIXBUF_ERROR_CORRUPT_IMAGE
	GDK_PIXBUF_ERROR_INSUFFICIENT_MEMORY
	GDK_PIXBUF_ERROR_BAD_OPTION
	GDK_PIXBUF_ERROR_UNKNOWN_TYPE
	GDK_PIXBUF_ERROR_UNSUPPORTED_OPERATION
	GDK_PIXBUF_ERROR_FAILED
end enum

declare function gdk_pixbuf_error_quark() as GQuark
declare function gdk_pixbuf_get_type() as GType
declare function gdk_pixbuf_ref(byval pixbuf as GdkPixbuf ptr) as GdkPixbuf ptr
declare sub gdk_pixbuf_unref(byval pixbuf as GdkPixbuf ptr)
declare function gdk_pixbuf_get_colorspace(byval pixbuf as const GdkPixbuf ptr) as GdkColorspace
declare function gdk_pixbuf_get_n_channels(byval pixbuf as const GdkPixbuf ptr) as long
declare function gdk_pixbuf_get_has_alpha(byval pixbuf as const GdkPixbuf ptr) as gboolean
declare function gdk_pixbuf_get_bits_per_sample(byval pixbuf as const GdkPixbuf ptr) as long
declare function gdk_pixbuf_get_pixels(byval pixbuf as const GdkPixbuf ptr) as guchar ptr
declare function gdk_pixbuf_get_width(byval pixbuf as const GdkPixbuf ptr) as long
declare function gdk_pixbuf_get_height(byval pixbuf as const GdkPixbuf ptr) as long
declare function gdk_pixbuf_get_rowstride(byval pixbuf as const GdkPixbuf ptr) as long
declare function gdk_pixbuf_get_byte_length(byval pixbuf as const GdkPixbuf ptr) as gsize
declare function gdk_pixbuf_get_pixels_with_length(byval pixbuf as const GdkPixbuf ptr, byval length as guint ptr) as guchar ptr
declare function gdk_pixbuf_new(byval colorspace as GdkColorspace, byval has_alpha as gboolean, byval bits_per_sample as long, byval width as long, byval height as long) as GdkPixbuf ptr
declare function gdk_pixbuf_copy(byval pixbuf as const GdkPixbuf ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_subpixbuf(byval src_pixbuf as GdkPixbuf ptr, byval src_x as long, byval src_y as long, byval width as long, byval height as long) as GdkPixbuf ptr

#ifdef __FB_UNIX__
	declare function gdk_pixbuf_new_from_file(byval filename as const zstring ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file_at_size(byval filename as const zstring ptr, byval width as long, byval height as long, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file_at_scale(byval filename as const zstring ptr, byval width as long, byval height as long, byval preserve_aspect_ratio as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
#else
	declare function gdk_pixbuf_new_from_file_utf8(byval filename as const zstring ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file alias "gdk_pixbuf_new_from_file_utf8"(byval filename as const zstring ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file_at_size_utf8(byval filename as const zstring ptr, byval width as long, byval height as long, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file_at_size alias "gdk_pixbuf_new_from_file_at_size_utf8"(byval filename as const zstring ptr, byval width as long, byval height as long, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file_at_scale_utf8(byval filename as const zstring ptr, byval width as long, byval height as long, byval preserve_aspect_ratio as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
	declare function gdk_pixbuf_new_from_file_at_scale alias "gdk_pixbuf_new_from_file_at_scale_utf8"(byval filename as const zstring ptr, byval width as long, byval height as long, byval preserve_aspect_ratio as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
#endif

declare function gdk_pixbuf_new_from_resource(byval resource_path as const zstring ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_resource_at_scale(byval resource_path as const zstring ptr, byval width as long, byval height as long, byval preserve_aspect_ratio as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_data(byval data as const guchar ptr, byval colorspace as GdkColorspace, byval has_alpha as gboolean, byval bits_per_sample as long, byval width as long, byval height as long, byval rowstride as long, byval destroy_fn as GdkPixbufDestroyNotify, byval destroy_fn_data as gpointer) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_xpm_data(byval data as const zstring ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_inline(byval data_length as gint, byval data as const guint8 ptr, byval copy_pixels as gboolean, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gdk_pixbuf_fill(byval pixbuf as GdkPixbuf ptr, byval pixel as guint32)

#ifdef __FB_UNIX__
	declare function gdk_pixbuf_save(byval pixbuf as GdkPixbuf ptr, byval filename as const zstring ptr, byval type as const zstring ptr, byval error as GError ptr ptr, ...) as gboolean
	declare function gdk_pixbuf_savev(byval pixbuf as GdkPixbuf ptr, byval filename as const zstring ptr, byval type as const zstring ptr, byval option_keys as zstring ptr ptr, byval option_values as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
#else
	declare function gdk_pixbuf_save_utf8(byval pixbuf as GdkPixbuf ptr, byval filename as const zstring ptr, byval type as const zstring ptr, byval error as GError ptr ptr, ...) as gboolean
	declare function gdk_pixbuf_save alias "gdk_pixbuf_save_utf8"(byval pixbuf as GdkPixbuf ptr, byval filename as const zstring ptr, byval type as const zstring ptr, byval error as GError ptr ptr, ...) as gboolean
	declare function gdk_pixbuf_savev_utf8(byval pixbuf as GdkPixbuf ptr, byval filename as const zstring ptr, byval type as const zstring ptr, byval option_keys as zstring ptr ptr, byval option_values as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
	declare function gdk_pixbuf_savev alias "gdk_pixbuf_savev_utf8"(byval pixbuf as GdkPixbuf ptr, byval filename as const zstring ptr, byval type as const zstring ptr, byval option_keys as zstring ptr ptr, byval option_values as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
#endif

type GdkPixbufSaveFunc as function(byval buf as const gchar ptr, byval count as gsize, byval error as GError ptr ptr, byval data as gpointer) as gboolean
declare function gdk_pixbuf_save_to_callback(byval pixbuf as GdkPixbuf ptr, byval save_func as GdkPixbufSaveFunc, byval user_data as gpointer, byval type as const zstring ptr, byval error as GError ptr ptr, ...) as gboolean
declare function gdk_pixbuf_save_to_callbackv(byval pixbuf as GdkPixbuf ptr, byval save_func as GdkPixbufSaveFunc, byval user_data as gpointer, byval type as const zstring ptr, byval option_keys as zstring ptr ptr, byval option_values as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_save_to_buffer(byval pixbuf as GdkPixbuf ptr, byval buffer as gchar ptr ptr, byval buffer_size as gsize ptr, byval type as const zstring ptr, byval error as GError ptr ptr, ...) as gboolean
declare function gdk_pixbuf_save_to_bufferv(byval pixbuf as GdkPixbuf ptr, byval buffer as gchar ptr ptr, byval buffer_size as gsize ptr, byval type as const zstring ptr, byval option_keys as zstring ptr ptr, byval option_values as zstring ptr ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_new_from_stream(byval stream as GInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gdk_pixbuf_new_from_stream_async(byval stream as GInputStream ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function gdk_pixbuf_new_from_stream_finish(byval async_result as GAsyncResult ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_new_from_stream_at_scale(byval stream as GInputStream ptr, byval width as gint, byval height as gint, byval preserve_aspect_ratio as gboolean, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gdk_pixbuf_new_from_stream_at_scale_async(byval stream as GInputStream ptr, byval width as gint, byval height as gint, byval preserve_aspect_ratio as gboolean, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function gdk_pixbuf_save_to_stream(byval pixbuf as GdkPixbuf ptr, byval stream as GOutputStream ptr, byval type as const zstring ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr, ...) as gboolean
declare sub gdk_pixbuf_save_to_stream_async(byval pixbuf as GdkPixbuf ptr, byval stream as GOutputStream ptr, byval type as const gchar ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer, ...)
declare function gdk_pixbuf_save_to_stream_finish(byval async_result as GAsyncResult ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_add_alpha(byval pixbuf as const GdkPixbuf ptr, byval substitute_color as gboolean, byval r as guchar, byval g as guchar, byval b as guchar) as GdkPixbuf ptr
declare sub gdk_pixbuf_copy_area(byval src_pixbuf as const GdkPixbuf ptr, byval src_x as long, byval src_y as long, byval width as long, byval height as long, byval dest_pixbuf as GdkPixbuf ptr, byval dest_x as long, byval dest_y as long)
declare sub gdk_pixbuf_saturate_and_pixelate(byval src as const GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval saturation as gfloat, byval pixelate as gboolean)
declare function gdk_pixbuf_apply_embedded_orientation(byval src as GdkPixbuf ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_get_option(byval pixbuf as GdkPixbuf ptr, byval key as const gchar ptr) as const gchar ptr
#define GDK_PIXBUF_TRANSFORM_H

type GdkInterpType as long
enum
	GDK_INTERP_NEAREST
	GDK_INTERP_TILES
	GDK_INTERP_BILINEAR
	GDK_INTERP_HYPER
end enum

type GdkPixbufRotation as long
enum
	GDK_PIXBUF_ROTATE_NONE = 0
	GDK_PIXBUF_ROTATE_COUNTERCLOCKWISE = 90
	GDK_PIXBUF_ROTATE_UPSIDEDOWN = 180
	GDK_PIXBUF_ROTATE_CLOCKWISE = 270
end enum

declare sub gdk_pixbuf_scale(byval src as const GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval dest_x as long, byval dest_y as long, byval dest_width as long, byval dest_height as long, byval offset_x as double, byval offset_y as double, byval scale_x as double, byval scale_y as double, byval interp_type as GdkInterpType)
declare sub gdk_pixbuf_composite(byval src as const GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval dest_x as long, byval dest_y as long, byval dest_width as long, byval dest_height as long, byval offset_x as double, byval offset_y as double, byval scale_x as double, byval scale_y as double, byval interp_type as GdkInterpType, byval overall_alpha as long)
declare sub gdk_pixbuf_composite_color(byval src as const GdkPixbuf ptr, byval dest as GdkPixbuf ptr, byval dest_x as long, byval dest_y as long, byval dest_width as long, byval dest_height as long, byval offset_x as double, byval offset_y as double, byval scale_x as double, byval scale_y as double, byval interp_type as GdkInterpType, byval overall_alpha as long, byval check_x as long, byval check_y as long, byval check_size as long, byval color1 as guint32, byval color2 as guint32)
declare function gdk_pixbuf_scale_simple(byval src as const GdkPixbuf ptr, byval dest_width as long, byval dest_height as long, byval interp_type as GdkInterpType) as GdkPixbuf ptr
declare function gdk_pixbuf_composite_color_simple(byval src as const GdkPixbuf ptr, byval dest_width as long, byval dest_height as long, byval interp_type as GdkInterpType, byval overall_alpha as long, byval check_size as long, byval color1 as guint32, byval color2 as guint32) as GdkPixbuf ptr
declare function gdk_pixbuf_rotate_simple(byval src as const GdkPixbuf ptr, byval angle as GdkPixbufRotation) as GdkPixbuf ptr
declare function gdk_pixbuf_flip(byval src as const GdkPixbuf ptr, byval horizontal as gboolean) as GdkPixbuf ptr
#define GDK_PIXBUF_ANIMATION_H
type GdkPixbufAnimation as _GdkPixbufAnimation
type GdkPixbufAnimationIter as _GdkPixbufAnimationIter

#define GDK_TYPE_PIXBUF_ANIMATION gdk_pixbuf_animation_get_type()
#define GDK_PIXBUF_ANIMATION(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_PIXBUF_ANIMATION, GdkPixbufAnimation)
#define GDK_IS_PIXBUF_ANIMATION(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_PIXBUF_ANIMATION)
#define GDK_TYPE_PIXBUF_ANIMATION_ITER gdk_pixbuf_animation_iter_get_type()
#define GDK_PIXBUF_ANIMATION_ITER(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_PIXBUF_ANIMATION_ITER, GdkPixbufAnimationIter)
#define GDK_IS_PIXBUF_ANIMATION_ITER(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_PIXBUF_ANIMATION_ITER)
declare function gdk_pixbuf_animation_get_type() as GType

#ifdef __FB_UNIX__
	declare function gdk_pixbuf_animation_new_from_file(byval filename as const zstring ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
#else
	declare function gdk_pixbuf_animation_new_from_file_utf8(byval filename as const zstring ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
	declare function gdk_pixbuf_animation_new_from_file alias "gdk_pixbuf_animation_new_from_file_utf8"(byval filename as const zstring ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
#endif

declare function gdk_pixbuf_animation_new_from_stream(byval stream as GInputStream ptr, byval cancellable as GCancellable ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
declare sub gdk_pixbuf_animation_new_from_stream_async(byval stream as GInputStream ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function gdk_pixbuf_animation_new_from_stream_finish(byval async_result as GAsyncResult ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
declare function gdk_pixbuf_animation_new_from_resource(byval resource_path as const zstring ptr, byval error as GError ptr ptr) as GdkPixbufAnimation ptr
declare function gdk_pixbuf_animation_ref(byval animation as GdkPixbufAnimation ptr) as GdkPixbufAnimation ptr
declare sub gdk_pixbuf_animation_unref(byval animation as GdkPixbufAnimation ptr)
declare function gdk_pixbuf_animation_get_width(byval animation as GdkPixbufAnimation ptr) as long
declare function gdk_pixbuf_animation_get_height(byval animation as GdkPixbufAnimation ptr) as long
declare function gdk_pixbuf_animation_is_static_image(byval animation as GdkPixbufAnimation ptr) as gboolean
declare function gdk_pixbuf_animation_get_static_image(byval animation as GdkPixbufAnimation ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_animation_get_iter(byval animation as GdkPixbufAnimation ptr, byval start_time as const GTimeVal ptr) as GdkPixbufAnimationIter ptr
declare function gdk_pixbuf_animation_iter_get_type() as GType
declare function gdk_pixbuf_animation_iter_get_delay_time(byval iter as GdkPixbufAnimationIter ptr) as long
declare function gdk_pixbuf_animation_iter_get_pixbuf(byval iter as GdkPixbufAnimationIter ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_animation_iter_on_currently_loading_frame(byval iter as GdkPixbufAnimationIter ptr) as gboolean
declare function gdk_pixbuf_animation_iter_advance(byval iter as GdkPixbufAnimationIter ptr, byval current_time as const GTimeVal ptr) as gboolean
#define GDK_PIXBUF_SIMPLE_ANIM_H
type GdkPixbufSimpleAnim as _GdkPixbufSimpleAnim
type GdkPixbufSimpleAnimClass as _GdkPixbufSimpleAnimClass

#define GDK_TYPE_PIXBUF_SIMPLE_ANIM gdk_pixbuf_simple_anim_get_type()
#define GDK_PIXBUF_SIMPLE_ANIM(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_PIXBUF_SIMPLE_ANIM, GdkPixbufSimpleAnim)
#define GDK_IS_PIXBUF_SIMPLE_ANIM(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_PIXBUF_SIMPLE_ANIM)
#define GDK_PIXBUF_SIMPLE_ANIM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_PIXBUF_SIMPLE_ANIM, GdkPixbufSimpleAnimClass)
#define GDK_IS_PIXBUF_SIMPLE_ANIM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_PIXBUF_SIMPLE_ANIM)
#define GDK_PIXBUF_SIMPLE_ANIM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_PIXBUF_SIMPLE_ANIM, GdkPixbufSimpleAnimClass)

declare function gdk_pixbuf_simple_anim_get_type() as GType
declare function gdk_pixbuf_simple_anim_iter_get_type() as GType
declare function gdk_pixbuf_simple_anim_new(byval width as gint, byval height as gint, byval rate as gfloat) as GdkPixbufSimpleAnim ptr
declare sub gdk_pixbuf_simple_anim_add_frame(byval animation as GdkPixbufSimpleAnim ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gdk_pixbuf_simple_anim_set_loop(byval animation as GdkPixbufSimpleAnim ptr, byval loop as gboolean)
declare function gdk_pixbuf_simple_anim_get_loop(byval animation as GdkPixbufSimpleAnim ptr) as gboolean
#define GDK_PIXBUF_IO_H
type GdkPixbufFormat as _GdkPixbufFormat
declare function gdk_pixbuf_format_get_type() as GType
declare function gdk_pixbuf_get_formats() as GSList ptr
declare function gdk_pixbuf_format_get_name(byval format as GdkPixbufFormat ptr) as gchar ptr
declare function gdk_pixbuf_format_get_description(byval format as GdkPixbufFormat ptr) as gchar ptr
declare function gdk_pixbuf_format_get_mime_types(byval format as GdkPixbufFormat ptr) as gchar ptr ptr
declare function gdk_pixbuf_format_get_extensions(byval format as GdkPixbufFormat ptr) as gchar ptr ptr
declare function gdk_pixbuf_format_is_writable(byval format as GdkPixbufFormat ptr) as gboolean
declare function gdk_pixbuf_format_is_scalable(byval format as GdkPixbufFormat ptr) as gboolean
declare function gdk_pixbuf_format_is_disabled(byval format as GdkPixbufFormat ptr) as gboolean
declare sub gdk_pixbuf_format_set_disabled(byval format as GdkPixbufFormat ptr, byval disabled as gboolean)
declare function gdk_pixbuf_format_get_license(byval format as GdkPixbufFormat ptr) as gchar ptr
declare function gdk_pixbuf_get_file_info(byval filename as const gchar ptr, byval width as gint ptr, byval height as gint ptr) as GdkPixbufFormat ptr
declare function gdk_pixbuf_format_copy(byval format as const GdkPixbufFormat ptr) as GdkPixbufFormat ptr
declare sub gdk_pixbuf_format_free(byval format as GdkPixbufFormat ptr)

#define GDK_PIXBUF_LOADER_H
#define GDK_TYPE_PIXBUF_LOADER gdk_pixbuf_loader_get_type()
#define GDK_PIXBUF_LOADER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoader)
#define GDK_PIXBUF_LOADER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoaderClass)
#define GDK_IS_PIXBUF_LOADER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GDK_TYPE_PIXBUF_LOADER)
#define GDK_IS_PIXBUF_LOADER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_PIXBUF_LOADER)
#define GDK_PIXBUF_LOADER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_PIXBUF_LOADER, GdkPixbufLoaderClass)
type GdkPixbufLoader as _GdkPixbufLoader

type _GdkPixbufLoader
	parent_instance as GObject
	priv as gpointer
end type

type GdkPixbufLoaderClass as _GdkPixbufLoaderClass

type _GdkPixbufLoaderClass
	parent_class as GObjectClass
	size_prepared as sub(byval loader as GdkPixbufLoader ptr, byval width as long, byval height as long)
	area_prepared as sub(byval loader as GdkPixbufLoader ptr)
	area_updated as sub(byval loader as GdkPixbufLoader ptr, byval x as long, byval y as long, byval width as long, byval height as long)
	closed as sub(byval loader as GdkPixbufLoader ptr)
end type

declare function gdk_pixbuf_loader_get_type() as GType
declare function gdk_pixbuf_loader_new() as GdkPixbufLoader ptr
declare function gdk_pixbuf_loader_new_with_type(byval image_type as const zstring ptr, byval error as GError ptr ptr) as GdkPixbufLoader ptr
declare function gdk_pixbuf_loader_new_with_mime_type(byval mime_type as const zstring ptr, byval error as GError ptr ptr) as GdkPixbufLoader ptr
declare sub gdk_pixbuf_loader_set_size(byval loader as GdkPixbufLoader ptr, byval width as long, byval height as long)
declare function gdk_pixbuf_loader_write(byval loader as GdkPixbufLoader ptr, byval buf as const guchar ptr, byval count as gsize, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_loader_write_bytes(byval loader as GdkPixbufLoader ptr, byval buffer as GBytes ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_loader_get_pixbuf(byval loader as GdkPixbufLoader ptr) as GdkPixbuf ptr
declare function gdk_pixbuf_loader_get_animation(byval loader as GdkPixbufLoader ptr) as GdkPixbufAnimation ptr
declare function gdk_pixbuf_loader_close(byval loader as GdkPixbufLoader ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_pixbuf_loader_get_format(byval loader as GdkPixbufLoader ptr) as GdkPixbufFormat ptr
#define __GDK_PIXBUF_ENUM_TYPES_H__
declare function gdk_pixbuf_alpha_mode_get_type() as GType
#define GDK_TYPE_PIXBUF_ALPHA_MODE gdk_pixbuf_alpha_mode_get_type()
declare function gdk_colorspace_get_type() as GType
#define GDK_TYPE_COLORSPACE gdk_colorspace_get_type()
declare function gdk_pixbuf_error_get_type() as GType
#define GDK_TYPE_PIXBUF_ERROR gdk_pixbuf_error_get_type()
declare function gdk_interp_type_get_type() as GType
#define GDK_TYPE_INTERP_TYPE gdk_interp_type_get_type()
declare function gdk_pixbuf_rotation_get_type() as GType
#define GDK_TYPE_PIXBUF_ROTATION gdk_pixbuf_rotation_get_type()
#undef GDK_PIXBUF_H_INSIDE

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
