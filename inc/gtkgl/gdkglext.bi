'' FreeBASIC binding for gtkglext-1.2.0
''
'' based on the C header files:
''   GdkGLExt - OpenGL Extension to GDK
''   Copyright (C) 2002-2004  Naofumi Yasufuku
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2.1 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02111-1301  USA.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "gdkglext-x11-1.0"
#else
	#inclib "gdkglext-win32-1.0"
#endif

#include once "crt/long.bi"
#include once "glib.bi"
#include once "glib-object.bi"
#include once "gdk/gdk2.bi"

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

'' The following symbols have been renamed:
''     variable gdkglext_major_version => gdkglext_major_version_
''     variable gdkglext_minor_version => gdkglext_minor_version_
''     variable gdkglext_micro_version => gdkglext_micro_version_
''     variable gdkglext_interface_age => gdkglext_interface_age_
''     variable gdkglext_binary_age => gdkglext_binary_age_

extern "C"

#define __GDK_GL_H__
#define __GDK_GL_DEFS_H__
#define __GDK_GL_VERSION_H__
const GDKGLEXT_MAJOR_VERSION = 1
const GDKGLEXT_MINOR_VERSION = 2
const GDKGLEXT_MICRO_VERSION = 0
const GDKGLEXT_INTERFACE_AGE = 0
const GDKGLEXT_BINARY_AGE = 0
#define GDKGLEXT_CHECK_VERSION(major, minor, micro) (((GDKGLEXT_MAJOR_VERSION > (major)) orelse ((GDKGLEXT_MAJOR_VERSION = (major)) andalso (GDKGLEXT_MINOR_VERSION > (minor)))) orelse (((GDKGLEXT_MAJOR_VERSION = (major)) andalso (GDKGLEXT_MINOR_VERSION = (minor))) andalso (GDKGLEXT_MICRO_VERSION >= (micro))))

#ifdef __FB_UNIX__
	extern gdkglext_major_version_ alias "gdkglext_major_version" as const guint
	extern gdkglext_minor_version_ alias "gdkglext_minor_version" as const guint
	extern gdkglext_micro_version_ alias "gdkglext_micro_version" as const guint
	extern gdkglext_interface_age_ alias "gdkglext_interface_age" as const guint
	extern gdkglext_binary_age_ alias "gdkglext_binary_age" as const guint
#else
	extern import gdkglext_major_version_ alias "gdkglext_major_version" as const guint
	extern import gdkglext_minor_version_ alias "gdkglext_minor_version" as const guint
	extern import gdkglext_micro_version_ alias "gdkglext_micro_version" as const guint
	extern import gdkglext_interface_age_ alias "gdkglext_interface_age" as const guint
	extern import gdkglext_binary_age_ alias "gdkglext_binary_age" as const guint
#endif

#define __GDK_GL_TOKENS_H__
const GDK_GL_SUCCESS = 0
const GDK_GL_ATTRIB_LIST_NONE = 0

type GdkGLConfigAttrib as long
enum
	GDK_GL_USE_GL = 1
	GDK_GL_BUFFER_SIZE = 2
	GDK_GL_LEVEL = 3
	GDK_GL_RGBA = 4
	GDK_GL_DOUBLEBUFFER = 5
	GDK_GL_STEREO = 6
	GDK_GL_AUX_BUFFERS = 7
	GDK_GL_RED_SIZE = 8
	GDK_GL_GREEN_SIZE = 9
	GDK_GL_BLUE_SIZE = 10
	GDK_GL_ALPHA_SIZE = 11
	GDK_GL_DEPTH_SIZE = 12
	GDK_GL_STENCIL_SIZE = 13
	GDK_GL_ACCUM_RED_SIZE = 14
	GDK_GL_ACCUM_GREEN_SIZE = 15
	GDK_GL_ACCUM_BLUE_SIZE = 16
	GDK_GL_ACCUM_ALPHA_SIZE = 17
	GDK_GL_CONFIG_CAVEAT = &h20
	GDK_GL_X_VISUAL_TYPE = &h22
	GDK_GL_TRANSPARENT_TYPE = &h23
	GDK_GL_TRANSPARENT_INDEX_VALUE = &h24
	GDK_GL_TRANSPARENT_RED_VALUE = &h25
	GDK_GL_TRANSPARENT_GREEN_VALUE = &h26
	GDK_GL_TRANSPARENT_BLUE_VALUE = &h27
	GDK_GL_TRANSPARENT_ALPHA_VALUE = &h28
	GDK_GL_DRAWABLE_TYPE = &h8010
	GDK_GL_RENDER_TYPE = &h8011
	GDK_GL_X_RENDERABLE = &h8012
	GDK_GL_FBCONFIG_ID = &h8013
	GDK_GL_MAX_PBUFFER_WIDTH = &h8016
	GDK_GL_MAX_PBUFFER_HEIGHT = &h8017
	GDK_GL_MAX_PBUFFER_PIXELS = &h8018
	GDK_GL_VISUAL_ID = &h800B
	GDK_GL_SCREEN = &h800C
	GDK_GL_SAMPLE_BUFFERS = 100000
	GDK_GL_SAMPLES = 100001
end enum

const GDK_GL_DONT_CARE = &hFFFFFFFF
const GDK_GL_NONE = &h8000

type GdkGLConfigCaveat as long
enum
	GDK_GL_CONFIG_CAVEAT_DONT_CARE = &hFFFFFFFF
	GDK_GL_CONFIG_CAVEAT_NONE = &h8000
	GDK_GL_SLOW_CONFIG = &h8001
	GDK_GL_NON_CONFORMANT_CONFIG = &h800D
end enum

type GdkGLVisualType as long
enum
	GDK_GL_VISUAL_TYPE_DONT_CARE = &hFFFFFFFF
	GDK_GL_TRUE_COLOR = &h8002
	GDK_GL_DIRECT_COLOR = &h8003
	GDK_GL_PSEUDO_COLOR = &h8004
	GDK_GL_STATIC_COLOR = &h8005
	GDK_GL_GRAY_SCALE = &h8006
	GDK_GL_STATIC_GRAY = &h8007
end enum

type GdkGLTransparentType as long
enum
	GDK_GL_TRANSPARENT_NONE = &h8000
	GDK_GL_TRANSPARENT_RGB = &h8008
	GDK_GL_TRANSPARENT_INDEX = &h8009
end enum

type GdkGLDrawableTypeMask as long
enum
	GDK_GL_WINDOW_BIT = 1 shl 0
	GDK_GL_PIXMAP_BIT = 1 shl 1
	GDK_GL_PBUFFER_BIT = 1 shl 2
end enum

type GdkGLRenderTypeMask as long
enum
	GDK_GL_RGBA_BIT = 1 shl 0
	GDK_GL_COLOR_INDEX_BIT = 1 shl 1
end enum

type GdkGLBufferMask as long
enum
	GDK_GL_FRONT_LEFT_BUFFER_BIT = 1 shl 0
	GDK_GL_FRONT_RIGHT_BUFFER_BIT = 1 shl 1
	GDK_GL_BACK_LEFT_BUFFER_BIT = 1 shl 2
	GDK_GL_BACK_RIGHT_BUFFER_BIT = 1 shl 3
	GDK_GL_AUX_BUFFERS_BIT = 1 shl 4
	GDK_GL_DEPTH_BUFFER_BIT = 1 shl 5
	GDK_GL_STENCIL_BUFFER_BIT = 1 shl 6
	GDK_GL_ACCUM_BUFFER_BIT = 1 shl 7
end enum

type GdkGLConfigError as long
enum
	GDK_GL_BAD_SCREEN = 1
	GDK_GL_BAD_ATTRIBUTE = 2
	GDK_GL_NO_EXTENSION = 3
	GDK_GL_BAD_VISUAL = 4
	GDK_GL_BAD_CONTEXT = 5
	GDK_GL_BAD_VALUE = 6
	GDK_GL_BAD_ENUM = 7
end enum

type GdkGLRenderType as long
enum
	GDK_GL_RGBA_TYPE = &h8014
	GDK_GL_COLOR_INDEX_TYPE = &h8015
end enum

type GdkGLDrawableAttrib as long
enum
	GDK_GL_PRESERVED_CONTENTS = &h801B
	GDK_GL_LARGEST_PBUFFER = &h801C
	GDK_GL_WIDTH = &h801D
	GDK_GL_HEIGHT = &h801E
	GDK_GL_EVENT_MASK = &h801F
end enum

type GdkGLPbufferAttrib as long
enum
	GDK_GL_PBUFFER_PRESERVED_CONTENTS = &h801B
	GDK_GL_PBUFFER_LARGEST_PBUFFER = &h801C
	GDK_GL_PBUFFER_HEIGHT = &h8040
	GDK_GL_PBUFFER_WIDTH = &h8041
end enum

type GdkGLEventMask as long
enum
	GDK_GL_PBUFFER_CLOBBER_MASK = 1 shl 27
end enum

type GdkGLEventType as long
enum
	GDK_GL_DAMAGED = &h8020
	GDK_GL_SAVED = &h8021
end enum

type GdkGLDrawableType as long
enum
	GDK_GL_WINDOW_ = &h8022
	GDK_GL_PBUFFER = &h8023
end enum

#define __GDK_GL_TYPES_H__
type GdkGLProc as sub()
type GdkGLConfig as _GdkGLConfig
type GdkGLContext as _GdkGLContext
type GdkGLDrawable as _GdkGLDrawable
type GdkGLPixmap as _GdkGLPixmap
type GdkGLWindow as _GdkGLWindow
#define __GDK_GL_ENUM_TYPES_H__
declare function gdk_gl_config_attrib_get_type() as GType
#define GDK_TYPE_GL_CONFIG_ATTRIB gdk_gl_config_attrib_get_type()
declare function gdk_gl_config_caveat_get_type() as GType
#define GDK_TYPE_GL_CONFIG_CAVEAT gdk_gl_config_caveat_get_type()
declare function gdk_gl_visual_type_get_type() as GType
#define GDK_TYPE_GL_VISUAL_TYPE gdk_gl_visual_type_get_type()
declare function gdk_gl_transparent_type_get_type() as GType
#define GDK_TYPE_GL_TRANSPARENT_TYPE gdk_gl_transparent_type_get_type()
declare function gdk_gl_drawable_type_mask_get_type() as GType
#define GDK_TYPE_GL_DRAWABLE_TYPE_MASK gdk_gl_drawable_type_mask_get_type()
declare function gdk_gl_render_type_mask_get_type() as GType
#define GDK_TYPE_GL_RENDER_TYPE_MASK gdk_gl_render_type_mask_get_type()
declare function gdk_gl_buffer_mask_get_type() as GType
#define GDK_TYPE_GL_BUFFER_MASK gdk_gl_buffer_mask_get_type()
declare function gdk_gl_config_error_get_type() as GType
#define GDK_TYPE_GL_CONFIG_ERROR gdk_gl_config_error_get_type()
declare function gdk_gl_render_type_get_type() as GType
#define GDK_TYPE_GL_RENDER_TYPE gdk_gl_render_type_get_type()
declare function gdk_gl_drawable_attrib_get_type() as GType
#define GDK_TYPE_GL_DRAWABLE_ATTRIB gdk_gl_drawable_attrib_get_type()
declare function gdk_gl_pbuffer_attrib_get_type() as GType
#define GDK_TYPE_GL_PBUFFER_ATTRIB gdk_gl_pbuffer_attrib_get_type()
declare function gdk_gl_event_mask_get_type() as GType
#define GDK_TYPE_GL_EVENT_MASK gdk_gl_event_mask_get_type()
declare function gdk_gl_event_type_get_type() as GType
#define GDK_TYPE_GL_EVENT_TYPE gdk_gl_event_type_get_type()
declare function gdk_gl_drawable_type_get_type() as GType
#define GDK_TYPE_GL_DRAWABLE_TYPE gdk_gl_drawable_type_get_type()
declare function gdk_gl_config_mode_get_type() as GType
#define GDK_TYPE_GL_CONFIG_MODE gdk_gl_config_mode_get_type()
#define __GDK_GL_INIT_H__

declare function gdk_gl_parse_args(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
declare function gdk_gl_init_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
declare sub gdk_gl_init(byval argc as long ptr, byval argv as zstring ptr ptr ptr)
#define __GDK_GL_QUERY_H__
declare function gdk_gl_query_extension() as gboolean
declare function gdk_gl_query_extension_for_display(byval display as GdkDisplay ptr) as gboolean
declare function gdk_gl_query_version(byval major as long ptr, byval minor as long ptr) as gboolean
declare function gdk_gl_query_version_for_display(byval display as GdkDisplay ptr, byval major as long ptr, byval minor as long ptr) as gboolean
declare function gdk_gl_query_gl_extension(byval extension as const zstring ptr) as gboolean
declare function gdk_gl_get_proc_address(byval proc_name as const zstring ptr) as GdkGLProc
#define __GDK_GL_CONFIG_H__

type GdkGLConfigMode as long
enum
	GDK_GL_MODE_RGB = 0
	GDK_GL_MODE_RGBA = 0
	GDK_GL_MODE_INDEX = 1 shl 0
	GDK_GL_MODE_SINGLE = 0
	GDK_GL_MODE_DOUBLE = 1 shl 1
	GDK_GL_MODE_STEREO = 1 shl 2
	GDK_GL_MODE_ALPHA = 1 shl 3
	GDK_GL_MODE_DEPTH = 1 shl 4
	GDK_GL_MODE_STENCIL = 1 shl 5
	GDK_GL_MODE_ACCUM = 1 shl 6
	GDK_GL_MODE_MULTISAMPLE = 1 shl 7
end enum

type GdkGLConfigClass as _GdkGLConfigClass
#define GDK_TYPE_GL_CONFIG gdk_gl_config_get_type()
#define GDK_GL_CONFIG(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_GL_CONFIG, GdkGLConfig)
#define GDK_GL_CONFIG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_GL_CONFIG, GdkGLConfigClass)
#define GDK_IS_GL_CONFIG(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_GL_CONFIG)
#define GDK_IS_GL_CONFIG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_GL_CONFIG)
#define GDK_GL_CONFIG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_GL_CONFIG, GdkGLConfigClass)

type _GdkGLConfig
	parent_instance as GObject
	layer_plane as gint
	n_aux_buffers as gint
	n_sample_buffers as gint
	is_rgba : 1 as guint
	is_double_buffered : 1 as guint
	as_single_mode : 1 as guint
	is_stereo : 1 as guint
	has_alpha : 1 as guint
	has_depth_buffer : 1 as guint
	has_stencil_buffer : 1 as guint
	has_accum_buffer : 1 as guint
end type

type _GdkGLConfigClass
	parent_class as GObjectClass
end type

declare function gdk_gl_config_get_type() as GType
declare function gdk_gl_config_new(byval attrib_list as const long ptr) as GdkGLConfig ptr
declare function gdk_gl_config_new_for_screen(byval screen as GdkScreen ptr, byval attrib_list as const long ptr) as GdkGLConfig ptr
declare function gdk_gl_config_new_by_mode(byval mode as GdkGLConfigMode) as GdkGLConfig ptr
declare function gdk_gl_config_new_by_mode_for_screen(byval screen as GdkScreen ptr, byval mode as GdkGLConfigMode) as GdkGLConfig ptr
declare function gdk_gl_config_get_screen(byval glconfig as GdkGLConfig ptr) as GdkScreen ptr
declare function gdk_gl_config_get_attrib(byval glconfig as GdkGLConfig ptr, byval attribute as long, byval value as long ptr) as gboolean
declare function gdk_gl_config_get_colormap(byval glconfig as GdkGLConfig ptr) as GdkColormap ptr
declare function gdk_gl_config_get_visual(byval glconfig as GdkGLConfig ptr) as GdkVisual ptr
declare function gdk_gl_config_get_depth(byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_get_layer_plane(byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_get_n_aux_buffers(byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_get_n_sample_buffers(byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_is_rgba(byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_is_double_buffered(byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_is_stereo(byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_alpha(byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_depth_buffer(byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_stencil_buffer(byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_accum_buffer(byval glconfig as GdkGLConfig ptr) as gboolean
#define __GDK_GL_CONTEXT_H__
type GdkGLContextClass as _GdkGLContextClass

#define GDK_TYPE_GL_CONTEXT gdk_gl_context_get_type()
#define GDK_GL_CONTEXT(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_GL_CONTEXT, GdkGLContext)
#define GDK_GL_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_GL_CONTEXT, GdkGLContextClass)
#define GDK_IS_GL_CONTEXT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_GL_CONTEXT)
#define GDK_IS_GL_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_GL_CONTEXT)
#define GDK_GL_CONTEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_GL_CONTEXT, GdkGLContextClass)

type _GdkGLContext
	parent_instance as GObject
end type

type _GdkGLContextClass
	parent_class as GObjectClass
end type

declare function gdk_gl_context_get_type() as GType
declare function gdk_gl_context_new(byval gldrawable as GdkGLDrawable ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as long) as GdkGLContext ptr
declare sub gdk_gl_context_destroy(byval glcontext as GdkGLContext ptr)
declare function gdk_gl_context_copy(byval glcontext as GdkGLContext ptr, byval src as GdkGLContext ptr, byval mask as culong) as gboolean
declare function gdk_gl_context_get_gl_drawable(byval glcontext as GdkGLContext ptr) as GdkGLDrawable ptr
declare function gdk_gl_context_get_gl_config(byval glcontext as GdkGLContext ptr) as GdkGLConfig ptr
declare function gdk_gl_context_get_share_list(byval glcontext as GdkGLContext ptr) as GdkGLContext ptr
declare function gdk_gl_context_is_direct(byval glcontext as GdkGLContext ptr) as gboolean
declare function gdk_gl_context_get_render_type(byval glcontext as GdkGLContext ptr) as long
declare function gdk_gl_context_get_current() as GdkGLContext ptr
#define __GDK_GL_DRAWABLE_H__
type GdkGLDrawableClass as _GdkGLDrawableClass

#define GDK_TYPE_GL_DRAWABLE gdk_gl_drawable_get_type()
#define GDK_GL_DRAWABLE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), GDK_TYPE_GL_DRAWABLE, GdkGLDrawable)
#define GDK_GL_DRAWABLE_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GDK_TYPE_GL_DRAWABLE, GdkGLDrawableClass)
#define GDK_IS_GL_DRAWABLE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), GDK_TYPE_GL_DRAWABLE)
#define GDK_IS_GL_DRAWABLE_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GDK_TYPE_GL_DRAWABLE)
#define GDK_GL_DRAWABLE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GDK_TYPE_GL_DRAWABLE, GdkGLDrawableClass)

type _GdkGLDrawableClass
	base_iface as GTypeInterface
	create_new_context as function(byval gldrawable as GdkGLDrawable ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as long) as GdkGLContext ptr
	make_context_current as function(byval draw as GdkGLDrawable ptr, byval read as GdkGLDrawable ptr, byval glcontext as GdkGLContext ptr) as gboolean
	is_double_buffered as function(byval gldrawable as GdkGLDrawable ptr) as gboolean
	swap_buffers as sub(byval gldrawable as GdkGLDrawable ptr)
	wait_gl as sub(byval gldrawable as GdkGLDrawable ptr)
	wait_gdk as sub(byval gldrawable as GdkGLDrawable ptr)
	gl_begin as function(byval draw as GdkGLDrawable ptr, byval read as GdkGLDrawable ptr, byval glcontext as GdkGLContext ptr) as gboolean
	gl_end as sub(byval gldrawable as GdkGLDrawable ptr)
	get_gl_config as function(byval gldrawable as GdkGLDrawable ptr) as GdkGLConfig ptr
	get_size as sub(byval gldrawable as GdkGLDrawable ptr, byval width as gint ptr, byval height as gint ptr)
end type

declare function gdk_gl_drawable_get_type() as GType
declare function gdk_gl_drawable_make_current(byval gldrawable as GdkGLDrawable ptr, byval glcontext as GdkGLContext ptr) as gboolean
declare function gdk_gl_drawable_is_double_buffered(byval gldrawable as GdkGLDrawable ptr) as gboolean
declare sub gdk_gl_drawable_swap_buffers(byval gldrawable as GdkGLDrawable ptr)
declare sub gdk_gl_drawable_wait_gl(byval gldrawable as GdkGLDrawable ptr)
declare sub gdk_gl_drawable_wait_gdk(byval gldrawable as GdkGLDrawable ptr)
declare function gdk_gl_drawable_gl_begin(byval gldrawable as GdkGLDrawable ptr, byval glcontext as GdkGLContext ptr) as gboolean
declare sub gdk_gl_drawable_gl_end(byval gldrawable as GdkGLDrawable ptr)
declare function gdk_gl_drawable_get_gl_config(byval gldrawable as GdkGLDrawable ptr) as GdkGLConfig ptr
declare sub gdk_gl_drawable_get_size(byval gldrawable as GdkGLDrawable ptr, byval width as gint ptr, byval height as gint ptr)
declare function gdk_gl_drawable_get_current() as GdkGLDrawable ptr
#define __GDK_GL_PIXMAP_H__
type GdkGLPixmapClass as _GdkGLPixmapClass

#define GDK_TYPE_GL_PIXMAP gdk_gl_pixmap_get_type()
#define GDK_GL_PIXMAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_GL_PIXMAP, GdkGLPixmap)
#define GDK_GL_PIXMAP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_GL_PIXMAP, GdkGLPixmapClass)
#define GDK_IS_GL_PIXMAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_GL_PIXMAP)
#define GDK_IS_GL_PIXMAP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_GL_PIXMAP)
#define GDK_GL_PIXMAP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_GL_PIXMAP, GdkGLPixmapClass)

type _GdkGLPixmap
	parent_instance as GdkDrawable
	drawable as GdkDrawable ptr
end type

type _GdkGLPixmapClass
	parent_class as GdkDrawableClass
end type

declare function gdk_gl_pixmap_get_type() as GType
declare function gdk_gl_pixmap_new(byval glconfig as GdkGLConfig ptr, byval pixmap as GdkPixmap ptr, byval attrib_list as const long ptr) as GdkGLPixmap ptr
declare sub gdk_gl_pixmap_destroy(byval glpixmap as GdkGLPixmap ptr)
declare function gdk_gl_pixmap_get_pixmap(byval glpixmap as GdkGLPixmap ptr) as GdkPixmap ptr
declare function gdk_pixmap_set_gl_capability(byval pixmap as GdkPixmap ptr, byval glconfig as GdkGLConfig ptr, byval attrib_list as const long ptr) as GdkGLPixmap ptr
declare sub gdk_pixmap_unset_gl_capability(byval pixmap as GdkPixmap ptr)
declare function gdk_pixmap_is_gl_capable(byval pixmap as GdkPixmap ptr) as gboolean
declare function gdk_pixmap_get_gl_pixmap(byval pixmap as GdkPixmap ptr) as GdkGLPixmap ptr
#define gdk_pixmap_get_gl_drawable(pixmap) GDK_GL_DRAWABLE(gdk_pixmap_get_gl_pixmap(pixmap))
#define __GDK_GL_WINDOW_H__
type GdkGLWindowClass as _GdkGLWindowClass

#define GDK_TYPE_GL_WINDOW gdk_gl_window_get_type()
#define GDK_GL_WINDOW(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_GL_WINDOW, GdkGLWindow)
#define GDK_GL_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_GL_WINDOW, GdkGLWindowClass)
#define GDK_IS_GL_WINDOW(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_GL_WINDOW)
#define GDK_IS_GL_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_GL_WINDOW)
#define GDK_GL_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_GL_WINDOW, GdkGLWindowClass)

type _GdkGLWindow
	parent_instance as GdkDrawable
	drawable as GdkDrawable ptr
end type

type _GdkGLWindowClass
	parent_class as GdkDrawableClass
end type

declare function gdk_gl_window_get_type() as GType
declare function gdk_gl_window_new(byval glconfig as GdkGLConfig ptr, byval window as GdkWindow ptr, byval attrib_list as const long ptr) as GdkGLWindow ptr
declare sub gdk_gl_window_destroy(byval glwindow as GdkGLWindow ptr)
declare function gdk_gl_window_get_window(byval glwindow as GdkGLWindow ptr) as GdkWindow ptr
declare function gdk_window_set_gl_capability(byval window as GdkWindow ptr, byval glconfig as GdkGLConfig ptr, byval attrib_list as const long ptr) as GdkGLWindow ptr
declare sub gdk_window_unset_gl_capability(byval window as GdkWindow ptr)
declare function gdk_window_is_gl_capable(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_gl_window(byval window as GdkWindow ptr) as GdkGLWindow ptr
#define gdk_window_get_gl_drawable(window) GDK_GL_DRAWABLE(gdk_window_get_gl_window(window))
#define __GDK_GL_FONT_H__
declare function gdk_gl_font_use_pango_font(byval font_desc as const PangoFontDescription ptr, byval first as long, byval count as long, byval list_base as long) as PangoFont ptr
declare function gdk_gl_font_use_pango_font_for_display(byval display as GdkDisplay ptr, byval font_desc as const PangoFontDescription ptr, byval first as long, byval count as long, byval list_base as long) as PangoFont ptr
#define __GDK_GL_SHAPES_H__
declare sub gdk_gl_draw_cube(byval solid as gboolean, byval size as double)
declare sub gdk_gl_draw_sphere(byval solid as gboolean, byval radius as double, byval slices as long, byval stacks as long)
declare sub gdk_gl_draw_cone(byval solid as gboolean, byval base as double, byval height as double, byval slices as long, byval stacks as long)
declare sub gdk_gl_draw_torus(byval solid as gboolean, byval inner_radius as double, byval outer_radius as double, byval nsides as long, byval rings as long)
declare sub gdk_gl_draw_tetrahedron(byval solid as gboolean)
declare sub gdk_gl_draw_octahedron(byval solid as gboolean)
declare sub gdk_gl_draw_dodecahedron(byval solid as gboolean)
declare sub gdk_gl_draw_icosahedron(byval solid as gboolean)
declare sub gdk_gl_draw_teapot(byval solid as gboolean, byval scale as double)

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
