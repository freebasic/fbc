''
''
'' gdkglconfig -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglconfig_bi__
#define __gdkglconfig_bi__

#include once "gtk/gdkgl/gdkgldefs.bi"
#include once "gtk/gdkgl/gdkgltypes.bi"
#include once "gtk/gdk/gdkwindow.bi"

enum GdkGLConfigMode
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

type _GdkGLConfig
	parent_instance as GObject
	layer_plane as gint
	n_aux_buffers as gint
	n_sample_buffers as gint
	is_rgba as guint
	is_double_buffered as guint
	as_single_mode as guint
	is_stereo as guint
	has_alpha as guint
	has_depth_buffer as guint
	has_stencil_buffer as guint
	has_accum_buffer as guint
end type

type _GdkGLConfigClass
	parent_class as GObjectClass
end type

declare function gdk_gl_config_get_type cdecl alias "gdk_gl_config_get_type" () as GType
declare function gdk_gl_config_new cdecl alias "gdk_gl_config_new" (byval attrib_list as integer ptr) as GdkGLConfig ptr
declare function gdk_gl_config_new_by_mode cdecl alias "gdk_gl_config_new_by_mode" (byval mode as GdkGLConfigMode) as GdkGLConfig ptr
declare function gdk_gl_config_get_screen cdecl alias "gdk_gl_config_get_screen" (byval glconfig as GdkGLConfig ptr) as GdkScreen ptr
declare function gdk_gl_config_get_attrib cdecl alias "gdk_gl_config_get_attrib" (byval glconfig as GdkGLConfig ptr, byval attribute as integer, byval value as integer ptr) as gboolean
declare function gdk_gl_config_get_colormap cdecl alias "gdk_gl_config_get_colormap" (byval glconfig as GdkGLConfig ptr) as GdkColormap ptr
declare function gdk_gl_config_get_visual cdecl alias "gdk_gl_config_get_visual" (byval glconfig as GdkGLConfig ptr) as GdkVisual ptr
declare function gdk_gl_config_get_depth cdecl alias "gdk_gl_config_get_depth" (byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_get_layer_plane cdecl alias "gdk_gl_config_get_layer_plane" (byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_get_n_aux_buffers cdecl alias "gdk_gl_config_get_n_aux_buffers" (byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_get_n_sample_buffers cdecl alias "gdk_gl_config_get_n_sample_buffers" (byval glconfig as GdkGLConfig ptr) as gint
declare function gdk_gl_config_is_rgba cdecl alias "gdk_gl_config_is_rgba" (byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_is_double_buffered cdecl alias "gdk_gl_config_is_double_buffered" (byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_is_stereo cdecl alias "gdk_gl_config_is_stereo" (byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_alpha cdecl alias "gdk_gl_config_has_alpha" (byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_depth_buffer cdecl alias "gdk_gl_config_has_depth_buffer" (byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_stencil_buffer cdecl alias "gdk_gl_config_has_stencil_buffer" (byval glconfig as GdkGLConfig ptr) as gboolean
declare function gdk_gl_config_has_accum_buffer cdecl alias "gdk_gl_config_has_accum_buffer" (byval glconfig as GdkGLConfig ptr) as gboolean

#endif
