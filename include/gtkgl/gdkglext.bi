' This is file gtkglext.bi
' (FreeBasic binding for GDK OpenGl extension version 1.2.0)
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
' This library is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'/* GdkGLExt - OpenGL Extension to GDK
 '* Copyright (C) 2002-2004  Naofumi Yasufuku
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2.1 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General Public
 '* License along with this library; if not, write to the Free Software
 '* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307  USA.
 '*/

#IFNDEF __GDK_H__
 #INCLUDE ONCE "gtk/gdk-2.24.bi"
#ENDIF

#IFDEF __FB_WIN32__
 #PRAGMA push(msbitfields)
 #INCLIB "gdkglext-win32-1.0"
#ELSEIF DEFINED(__FB_LINUX__)
 #INCLIB "gdkglext-x11-1.0"
#ENDIF

EXTERN "C"

#IFNDEF __GDK_GL_H__
#DEFINE __GDK_GL_H__

#IFNDEF __GDK_GL_DEFS_H__
#DEFINE __GDK_GL_DEFS_H__

#IFNDEF __GDK_GL_VERSION_H__
#DEFINE __GDK_GL_VERSION_H__

#DEFINE GDKGLEXT_MAJOR_VERSION (1)
#DEFINE GDKGLEXT_MINOR_VERSION (2)
#DEFINE GDKGLEXT_MICRO_VERSION (0)
#DEFINE GDKGLEXT_INTERFACE_AGE (0)
#DEFINE GDKGLEXT_BINARY_AGE (0)
#DEFINE GDKGLEXT_CHECK_VERSION(major, minor, micro) _
  (GDKGLEXT_MAJOR_VERSION > (major) ORELSE _
  (GDKGLEXT_MAJOR_VERSION = (major) ANDALSO GDKGLEXT_MINOR_VERSION > (minor)) ORELSE _
  (GDKGLEXT_MAJOR_VERSION = (major) ANDALSO GDKGLEXT_MINOR_VERSION = (minor) ANDALSO _
   GDKGLEXT_MICRO_VERSION >= (micro)))

EXTERN AS CONST guint gdkglext_major_version_FB ALIAS "gdkglext_major_version"
EXTERN AS CONST guint gdkglext_minor_version_FB ALIAS "gdkglext_minor_version"
EXTERN AS CONST guint gdkglext_micro_version_FB ALIAS "gdkglext_micro_version"
EXTERN AS CONST guint gdkglext_interface_age_FB ALIAS "gdkglext_interface_age"
EXTERN AS CONST guint gdkglext_binary_age_FB ALIAS "gdkglext_binary_age"

#ENDIF ' __GDK_GL_VERSION_H__

#IFNDEF __GDK_GL_TOKENS_H__
#DEFINE __GDK_GL_TOKENS_H__

#DEFINE GDK_GL_SUCCESS 0
#DEFINE GDK_GL_ATTRIB_LIST_NONE 0

ENUM GdkGLConfigAttrib
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
END ENUM

#DEFINE GDK_GL_DONT_CARE &hFFFFFFFF
#DEFINE GDK_GL_NONE &h8000

ENUM GdkGLConfigCaveat
  GDK_GL_CONFIG_CAVEAT_DONT_CARE = &hFFFFFFFF
  GDK_GL_CONFIG_CAVEAT_NONE = &h8000
  GDK_GL_SLOW_CONFIG = &h8001
  GDK_GL_NON_CONFORMANT_CONFIG = &h800D
END ENUM

ENUM GdkGLVisualType
  GDK_GL_VISUAL_TYPE_DONT_CARE = &hFFFFFFFF
  GDK_GL_TRUE_COLOR = &h8002
  GDK_GL_DIRECT_COLOR = &h8003
  GDK_GL_PSEUDO_COLOR = &h8004
  GDK_GL_STATIC_COLOR = &h8005
  GDK_GL_GRAY_SCALE = &h8006
  GDK_GL_STATIC_GRAY = &h8007
END ENUM

ENUM GdkGLTransparentType
  GDK_GL_TRANSPARENT_NONE = &h8000
  GDK_GL_TRANSPARENT_RGB = &h8008
  GDK_GL_TRANSPARENT_INDEX = &h8009
END ENUM

ENUM GdkGLDrawableTypeMask
  GDK_GL_WINDOW_BIT = 1 SHL 0
  GDK_GL_PIXMAP_BIT = 1 SHL 1
  GDK_GL_PBUFFER_BIT = 1 SHL 2
END ENUM

ENUM GdkGLRenderTypeMask
  GDK_GL_RGBA_BIT = 1 SHL 0
  GDK_GL_COLOR_INDEX_BIT = 1 SHL 1
END ENUM

ENUM GdkGLBufferMask
  GDK_GL_FRONT_LEFT_BUFFER_BIT = 1 SHL 0
  GDK_GL_FRONT_RIGHT_BUFFER_BIT = 1 SHL 1
  GDK_GL_BACK_LEFT_BUFFER_BIT = 1 SHL 2
  GDK_GL_BACK_RIGHT_BUFFER_BIT = 1 SHL 3
  GDK_GL_AUX_BUFFERS_BIT = 1 SHL 4
  GDK_GL_DEPTH_BUFFER_BIT = 1 SHL 5
  GDK_GL_STENCIL_BUFFER_BIT = 1 SHL 6
  GDK_GL_ACCUM_BUFFER_BIT = 1 SHL 7
END ENUM

ENUM GdkGLConfigError
  GDK_GL_BAD_SCREEN = 1
  GDK_GL_BAD_ATTRIBUTE = 2
  GDK_GL_NO_EXTENSION = 3
  GDK_GL_BAD_VISUAL = 4
  GDK_GL_BAD_CONTEXT = 5
  GDK_GL_BAD_VALUE = 6
  GDK_GL_BAD_ENUM = 7
END ENUM

ENUM GdkGLRenderType
  GDK_GL_RGBA_TYPE = &h8014
  GDK_GL_COLOR_INDEX_TYPE = &h8015
END ENUM

ENUM GdkGLDrawableAttrib
  GDK_GL_PRESERVED_CONTENTS = &h801B
  GDK_GL_LARGEST_PBUFFER = &h801C
  GDK_GL_WIDTH = &h801D
  GDK_GL_HEIGHT = &h801E
  GDK_GL_EVENT_MASK = &h801F
END ENUM

ENUM GdkGLPbufferAttrib
  GDK_GL_PBUFFER_PRESERVED_CONTENTS = &h801B
  GDK_GL_PBUFFER_LARGEST_PBUFFER = &h801C
  GDK_GL_PBUFFER_HEIGHT = &h8040
  GDK_GL_PBUFFER_WIDTH = &h8041
END ENUM

ENUM GdkGLEventMask
  GDK_GL_PBUFFER_CLOBBER_MASK = 1 SHL 27
END ENUM

ENUM GdkGLEventType
  GDK_GL_DAMAGED = &h8020
  GDK_GL_SAVED = &h8021
END ENUM

ENUM GdkGLDrawableType
  GDK_GL_WINDOW_FB = &h8022
  GDK_GL_PBUFFER = &h8023
END ENUM

#ENDIF ' __GDK_GL_TOKENS_H__

#IFNDEF __GDK_GL_TYPES_H__
#DEFINE __GDK_GL_TYPES_H__

TYPE GdkGLProc AS SUB()
TYPE GdkGLConfig AS _GdkGLConfig
TYPE GdkGLContext AS _GdkGLContext
TYPE GdkGLDrawable AS _GdkGLDrawable
TYPE GdkGLPixmap AS _GdkGLPixmap
TYPE GdkGLWindow AS _GdkGLWindow

#ENDIF ' __GDK_GL_TYPES_H__

#IFNDEF __GDK_GL_ENUM_TYPES_H__
#DEFINE __GDK_GL_ENUM_TYPES_H__

DECLARE FUNCTION gdk_gl_config_attrib_get_type() AS GType
#DEFINE GDK_TYPE_GL_CONFIG_ATTRIB (gdk_gl_config_attrib_get_type())
DECLARE FUNCTION gdk_gl_config_caveat_get_type() AS GType
#DEFINE GDK_TYPE_GL_CONFIG_CAVEAT (gdk_gl_config_caveat_get_type())
DECLARE FUNCTION gdk_gl_visual_type_get_type() AS GType
#DEFINE GDK_TYPE_GL_VISUAL_TYPE (gdk_gl_visual_type_get_type())
DECLARE FUNCTION gdk_gl_transparent_type_get_type() AS GType
#DEFINE GDK_TYPE_GL_TRANSPARENT_TYPE (gdk_gl_transparent_type_get_type())
DECLARE FUNCTION gdk_gl_drawable_type_mask_get_type() AS GType
#DEFINE GDK_TYPE_GL_DRAWABLE_TYPE_MASK (gdk_gl_drawable_type_mask_get_type())
DECLARE FUNCTION gdk_gl_render_type_mask_get_type() AS GType
#DEFINE GDK_TYPE_GL_RENDER_TYPE_MASK (gdk_gl_render_type_mask_get_type())
DECLARE FUNCTION gdk_gl_buffer_mask_get_type() AS GType
#DEFINE GDK_TYPE_GL_BUFFER_MASK (gdk_gl_buffer_mask_get_type())
DECLARE FUNCTION gdk_gl_config_error_get_type() AS GType
#DEFINE GDK_TYPE_GL_CONFIG_ERROR (gdk_gl_config_error_get_type())
DECLARE FUNCTION gdk_gl_render_type_get_type() AS GType
#DEFINE GDK_TYPE_GL_RENDER_TYPE (gdk_gl_render_type_get_type())
DECLARE FUNCTION gdk_gl_drawable_attrib_get_type() AS GType
#DEFINE GDK_TYPE_GL_DRAWABLE_ATTRIB (gdk_gl_drawable_attrib_get_type())
DECLARE FUNCTION gdk_gl_pbuffer_attrib_get_type() AS GType
#DEFINE GDK_TYPE_GL_PBUFFER_ATTRIB (gdk_gl_pbuffer_attrib_get_type())
DECLARE FUNCTION gdk_gl_event_mask_get_type() AS GType
#DEFINE GDK_TYPE_GL_EVENT_MASK (gdk_gl_event_mask_get_type())
DECLARE FUNCTION gdk_gl_event_type_get_type() AS GType
#DEFINE GDK_TYPE_GL_EVENT_TYPE (gdk_gl_event_type_get_type())
DECLARE FUNCTION gdk_gl_drawable_type_get_type() AS GType
#DEFINE GDK_TYPE_GL_DRAWABLE_TYPE (gdk_gl_drawable_type_get_type())
DECLARE FUNCTION gdk_gl_config_mode_get_type() AS GType
#DEFINE GDK_TYPE_GL_CONFIG_MODE (gdk_gl_config_mode_get_type())

#ENDIF ' __GDK_GL_ENUM_TYPES_H__

#IFNDEF __GDK_GL_INIT_H__
#DEFINE __GDK_GL_INIT_H__

DECLARE FUNCTION gdk_gl_parse_args(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR) AS gboolean
DECLARE FUNCTION gdk_gl_init_check(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR) AS gboolean
DECLARE SUB gdk_gl_init(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR)

#ENDIF ' __GDK_GL_INIT_H__

#IFNDEF __GDK_GL_QUERY_H__
#DEFINE __GDK_GL_QUERY_H__

#IFNDEF GDK_MULTIHEAD_SAFE
DECLARE FUNCTION gdk_gl_query_extension() AS gboolean
#ENDIF ' GDK_MULTIHEAD_SAFE

#IFDEF GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_query_extension_for_display(BYVAL AS GdkDisplay PTR) AS gboolean

#ENDIF ' GDKGLEXT_MULTIHEAD_SUPPORT

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_gl_query_version(BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR) AS gboolean

#ENDIF ' GDK_MULTIHEAD_SAFE

#IFDEF GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_query_version_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS INTEGER PTR, BYVAL AS INTEGER PTR) AS gboolean

#ENDIF ' GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_query_gl_extension(BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION gdk_gl_get_proc_address(BYVAL AS CONST ZSTRING PTR) AS GdkGLProc

#ENDIF ' __GDK_GL_QUERY_H__

#IFNDEF __GDK_GL_CONFIG_H__
#DEFINE __GDK_GL_CONFIG_H__

ENUM GdkGLConfigMode
  GDK_GL_MODE_RGB = 0
  GDK_GL_MODE_RGBA = 0
  GDK_GL_MODE_INDEX = 1 SHL 0
  GDK_GL_MODE_SINGLE = 0
  GDK_GL_MODE_DOUBLE = 1 SHL 1
  GDK_GL_MODE_STEREO = 1 SHL 2
  GDK_GL_MODE_ALPHA = 1 SHL 3
  GDK_GL_MODE_DEPTH = 1 SHL 4
  GDK_GL_MODE_STENCIL = 1 SHL 5
  GDK_GL_MODE_ACCUM = 1 SHL 6
  GDK_GL_MODE_MULTISAMPLE = 1 SHL 7
END ENUM

TYPE GdkGLConfigClass AS _GdkGLConfigClass

#DEFINE GDK_TYPE_GL_CONFIG (gdk_gl_config_get_type ())
#DEFINE GDK_GL_CONFIG(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_CONFIG, GdkGLConfig))
#DEFINE GDK_GL_CONFIG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_CONFIG, GdkGLConfigClass))
#DEFINE GDK_IS_GL_CONFIG(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_CONFIG))
#DEFINE GDK_IS_GL_CONFIG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_CONFIG))
#DEFINE GDK_GL_CONFIG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_CONFIG, GdkGLConfigClass))

TYPE _GdkGLConfig
  AS GObject parent_instance
  AS gint layer_plane
  AS gint n_aux_buffers
  AS gint n_sample_buffers
  AS guint is_rgba : 1
  AS guint is_double_buffered : 1
  AS guint as_single_mode : 1
  AS guint is_stereo : 1
  AS guint has_alpha : 1
  AS guint has_depth_buffer : 1
  AS guint has_stencil_buffer : 1
  AS guint has_accum_buffer : 1
END TYPE

TYPE _GdkGLConfigClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION gdk_gl_config_get_type() AS GType

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_gl_config_new(BYVAL AS CONST INTEGER PTR) AS GdkGLConfig PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

#IFDEF GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_config_new_for_screen(BYVAL AS GdkScreen PTR, BYVAL AS CONST INTEGER PTR) AS GdkGLConfig PTR

#ENDIF ' GDKGLEXT_MULTIHEAD_SUPPORT

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_gl_config_new_by_mode(BYVAL AS GdkGLConfigMode) AS GdkGLConfig PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

#IFDEF GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_config_new_by_mode_for_screen(BYVAL AS GdkScreen PTR, BYVAL AS GdkGLConfigMode) AS GdkGLConfig PTR

#ENDIF ' GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_config_get_screen(BYVAL AS GdkGLConfig PTR) AS GdkScreen PTR
DECLARE FUNCTION gdk_gl_config_get_attrib(BYVAL AS GdkGLConfig PTR, BYVAL AS INTEGER, BYVAL AS INTEGER PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_get_colormap(BYVAL AS GdkGLConfig PTR) AS GdkColormap PTR
DECLARE FUNCTION gdk_gl_config_get_visual(BYVAL AS GdkGLConfig PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_gl_config_get_depth(BYVAL AS GdkGLConfig PTR) AS gint
DECLARE FUNCTION gdk_gl_config_get_layer_plane(BYVAL AS GdkGLConfig PTR) AS gint
DECLARE FUNCTION gdk_gl_config_get_n_aux_buffers(BYVAL AS GdkGLConfig PTR) AS gint
DECLARE FUNCTION gdk_gl_config_get_n_sample_buffers(BYVAL AS GdkGLConfig PTR) AS gint
DECLARE FUNCTION gdk_gl_config_is_rgba(BYVAL AS GdkGLConfig PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_is_double_buffered(BYVAL AS GdkGLConfig PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_is_stereo(BYVAL AS GdkGLConfig PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_has_alpha(BYVAL AS GdkGLConfig PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_has_depth_buffer(BYVAL AS GdkGLConfig PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_has_stencil_buffer(BYVAL AS GdkGLConfig PTR) AS gboolean
DECLARE FUNCTION gdk_gl_config_has_accum_buffer(BYVAL AS GdkGLConfig PTR) AS gboolean

#ENDIF ' __GDK_GL_CONFIG_H__

#IFNDEF __GDK_GL_CONTEXT_H__
#DEFINE __GDK_GL_CONTEXT_H__

TYPE GdkGLContextClass AS _GdkGLContextClass

#DEFINE GDK_TYPE_GL_CONTEXT (gdk_gl_context_get_type ())
#DEFINE GDK_GL_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_CONTEXT, GdkGLContext))
#DEFINE GDK_GL_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_CONTEXT, GdkGLContextClass))
#DEFINE GDK_IS_GL_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_CONTEXT))
#DEFINE GDK_IS_GL_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_CONTEXT))
#DEFINE GDK_GL_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_CONTEXT, GdkGLContextClass))

TYPE _GdkGLContext
  AS GObject parent_instance
END TYPE

TYPE _GdkGLContextClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION gdk_gl_context_get_type() AS GType
DECLARE FUNCTION gdk_gl_context_new(BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLContext PTR, BYVAL AS gboolean, BYVAL AS INTEGER) AS GdkGLContext PTR
DECLARE SUB gdk_gl_context_destroy(BYVAL AS GdkGLContext PTR)
DECLARE FUNCTION gdk_gl_context_copy(BYVAL AS GdkGLContext PTR, BYVAL AS GdkGLContext PTR, BYVAL AS UINTEGER) AS gboolean
DECLARE FUNCTION gdk_gl_context_get_gl_drawable(BYVAL AS GdkGLContext PTR) AS GdkGLDrawable PTR
DECLARE FUNCTION gdk_gl_context_get_gl_config(BYVAL AS GdkGLContext PTR) AS GdkGLConfig PTR
DECLARE FUNCTION gdk_gl_context_get_share_list(BYVAL AS GdkGLContext PTR) AS GdkGLContext PTR
DECLARE FUNCTION gdk_gl_context_is_direct(BYVAL AS GdkGLContext PTR) AS gboolean
DECLARE FUNCTION gdk_gl_context_get_render_type(BYVAL AS GdkGLContext PTR) AS INTEGER
DECLARE FUNCTION gdk_gl_context_get_current() AS GdkGLContext PTR

#ENDIF ' __GDK_GL_CONTEXT_H__

#IFNDEF __GDK_GL_DRAWABLE_H__
#DEFINE __GDK_GL_DRAWABLE_H__

TYPE GdkGLDrawableClass AS _GdkGLDrawableClass

#DEFINE GDK_TYPE_GL_DRAWABLE (gdk_gl_drawable_get_type ())
#DEFINE GDK_GL_DRAWABLE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), GDK_TYPE_GL_DRAWABLE, GdkGLDrawable))
#DEFINE GDK_GL_DRAWABLE_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GDK_TYPE_GL_DRAWABLE, GdkGLDrawableClass))
#DEFINE GDK_IS_GL_DRAWABLE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), GDK_TYPE_GL_DRAWABLE))
#DEFINE GDK_IS_GL_DRAWABLE_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GDK_TYPE_GL_DRAWABLE))
#DEFINE GDK_GL_DRAWABLE_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GDK_TYPE_GL_DRAWABLE, GdkGLDrawableClass))

TYPE _GdkGLDrawableClass
  AS GTypeInterface base_iface
  AS FUNCTION(BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLContext PTR, BYVAL AS gboolean, BYVAL AS INTEGER) AS GdkGLContext PTR create_new_context
  AS FUNCTION(BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLContext PTR) AS gboolean make_context_current
  AS FUNCTION(BYVAL AS GdkGLDrawable PTR) AS gboolean is_double_buffered
  AS SUB(BYVAL AS GdkGLDrawable PTR) swap_buffers
  AS SUB(BYVAL AS GdkGLDrawable PTR) wait_gl
  AS SUB(BYVAL AS GdkGLDrawable PTR) wait_gdk
  AS FUNCTION(BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLContext PTR) AS gboolean gl_begin
  AS SUB(BYVAL AS GdkGLDrawable PTR) gl_end
  AS FUNCTION(BYVAL AS GdkGLDrawable PTR) AS GdkGLConfig PTR get_gl_config
  AS SUB(BYVAL AS GdkGLDrawable PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) get_size
END TYPE

DECLARE FUNCTION gdk_gl_drawable_get_type() AS GType
DECLARE FUNCTION gdk_gl_drawable_make_current(BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLContext PTR) AS gboolean
DECLARE FUNCTION gdk_gl_drawable_is_double_buffered(BYVAL AS GdkGLDrawable PTR) AS gboolean
DECLARE SUB gdk_gl_drawable_swap_buffers(BYVAL AS GdkGLDrawable PTR)
DECLARE SUB gdk_gl_drawable_wait_gl(BYVAL AS GdkGLDrawable PTR)
DECLARE SUB gdk_gl_drawable_wait_gdk(BYVAL AS GdkGLDrawable PTR)
DECLARE FUNCTION gdk_gl_drawable_gl_begin(BYVAL AS GdkGLDrawable PTR, BYVAL AS GdkGLContext PTR) AS gboolean
DECLARE SUB gdk_gl_drawable_gl_end(BYVAL AS GdkGLDrawable PTR)
DECLARE FUNCTION gdk_gl_drawable_get_gl_config(BYVAL AS GdkGLDrawable PTR) AS GdkGLConfig PTR
DECLARE SUB gdk_gl_drawable_get_size(BYVAL AS GdkGLDrawable PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_gl_drawable_get_current() AS GdkGLDrawable PTR

#ENDIF ' __GDK_GL_DRAWABLE_H__

#IFNDEF __GDK_GL_PIXMAP_H__
#DEFINE __GDK_GL_PIXMAP_H__

TYPE GdkGLPixmapClass AS _GdkGLPixmapClass

#DEFINE GDK_TYPE_GL_PIXMAP (gdk_gl_pixmap_get_type ())
#DEFINE GDK_GL_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_PIXMAP, GdkGLPixmap))
#DEFINE GDK_GL_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_PIXMAP, GdkGLPixmapClass))
#DEFINE GDK_IS_GL_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_PIXMAP))
#DEFINE GDK_IS_GL_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_PIXMAP))
#DEFINE GDK_GL_PIXMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_PIXMAP, GdkGLPixmapClass))

TYPE _GdkGLPixmap
  AS GdkDrawable parent_instance
  AS GdkDrawable PTR drawable
END TYPE

TYPE _GdkGLPixmapClass
  AS GdkDrawableClass parent_class
END TYPE

DECLARE FUNCTION gdk_gl_pixmap_get_type() AS GType
DECLARE FUNCTION gdk_gl_pixmap_new(BYVAL AS GdkGLConfig PTR, BYVAL AS GdkPixmap PTR, BYVAL AS CONST INTEGER PTR) AS GdkGLPixmap PTR
DECLARE SUB gdk_gl_pixmap_destroy(BYVAL AS GdkGLPixmap PTR)
DECLARE FUNCTION gdk_gl_pixmap_get_pixmap(BYVAL AS GdkGLPixmap PTR) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_set_gl_capability(BYVAL AS GdkPixmap PTR, BYVAL AS GdkGLConfig PTR, BYVAL AS CONST INTEGER PTR) AS GdkGLPixmap PTR
DECLARE SUB gdk_pixmap_unset_gl_capability(BYVAL AS GdkPixmap PTR)
DECLARE FUNCTION gdk_pixmap_is_gl_capable(BYVAL AS GdkPixmap PTR) AS gboolean
DECLARE FUNCTION gdk_pixmap_get_gl_pixmap(BYVAL AS GdkPixmap PTR) AS GdkGLPixmap PTR

#DEFINE gdk_pixmap_get_gl_drawable(pixmap) _
  GDK_GL_DRAWABLE (gdk_pixmap_get_gl_pixmap (pixmap))

#ENDIF ' __GDK_GL_PIXMAP_H__

#IFNDEF __GDK_GL_WINDOW_H__
#DEFINE __GDK_GL_WINDOW_H__

TYPE GdkGLWindowClass AS _GdkGLWindowClass

#DEFINE GDK_TYPE_GL_WINDOW (gdk_gl_window_get_type ())
#DEFINE GDK_GL_WINDOW(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GL_WINDOW, GdkGLWindow))
#DEFINE GDK_GL_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GL_WINDOW, GdkGLWindowClass))
#DEFINE GDK_IS_GL_WINDOW(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GL_WINDOW))
#DEFINE GDK_IS_GL_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GL_WINDOW))
#DEFINE GDK_GL_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GL_WINDOW, GdkGLWindowClass))

TYPE _GdkGLWindow
  AS GdkDrawable parent_instance
  AS GdkDrawable PTR drawable
END TYPE

TYPE _GdkGLWindowClass
  AS GdkDrawableClass parent_class
END TYPE

DECLARE FUNCTION gdk_gl_window_get_type() AS GType
DECLARE FUNCTION gdk_gl_window_new(BYVAL AS GdkGLConfig PTR, BYVAL AS GdkWindow PTR, BYVAL AS CONST INTEGER PTR) AS GdkGLWindow PTR
DECLARE SUB gdk_gl_window_destroy(BYVAL AS GdkGLWindow PTR)
DECLARE FUNCTION gdk_gl_window_get_window(BYVAL AS GdkGLWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_set_gl_capability(BYVAL AS GdkWindow PTR, BYVAL AS GdkGLConfig PTR, BYVAL AS CONST INTEGER PTR) AS GdkGLWindow PTR
DECLARE SUB gdk_window_unset_gl_capability(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_is_gl_capable(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_get_gl_window(BYVAL AS GdkWindow PTR) AS GdkGLWindow PTR

#DEFINE gdk_window_get_gl_drawable(window) _
  GDK_GL_DRAWABLE (gdk_window_get_gl_window (window))

#ENDIF ' __GDK_GL_WINDOW_H__

#IFNDEF __GDK_GL_FONT_H__
#DEFINE __GDK_GL_FONT_H__

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_gl_font_use_pango_font(BYVAL AS CONST PangoFontDescription PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS PangoFont PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

#IFDEF GDKGLEXT_MULTIHEAD_SUPPORT

DECLARE FUNCTION gdk_gl_font_use_pango_font_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS CONST PangoFontDescription PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS PangoFont PTR

#ENDIF ' GDKGLEXT_MULTIHEAD_SUPPORT
#ENDIF ' __GDK_GL_FONT_H__

#IFNDEF __GDK_GL_SHAPES_H__
#DEFINE __GDK_GL_SHAPES_H__

DECLARE SUB gdk_gl_draw_cube(BYVAL AS gboolean, BYVAL AS DOUBLE)
DECLARE SUB gdk_gl_draw_sphere(BYVAL AS gboolean, BYVAL AS DOUBLE, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB gdk_gl_draw_cone(BYVAL AS gboolean, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB gdk_gl_draw_torus(BYVAL AS gboolean, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB gdk_gl_draw_tetrahedron(BYVAL AS gboolean)
DECLARE SUB gdk_gl_draw_octahedron(BYVAL AS gboolean)
DECLARE SUB gdk_gl_draw_dodecahedron(BYVAL AS gboolean)
DECLARE SUB gdk_gl_draw_icosahedron(BYVAL AS gboolean)
DECLARE SUB gdk_gl_draw_teapot(BYVAL AS gboolean, BYVAL AS DOUBLE)

#ENDIF ' __GDK_GL_SHAPES_H__

#ENDIF ' __GDK_GL_H__

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
