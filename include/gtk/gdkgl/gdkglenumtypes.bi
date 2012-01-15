''
''
'' gdkglenumtypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkglenumtypes_bi__
#define __gdkglenumtypes_bi__

#include once "gtk/glib-object.bi"

#define GDK_TYPE_GL_CONFIG_ATTRIB (gdk_gl_config_attrib_get_type())
#define GDK_TYPE_GL_CONFIG_CAVEAT (gdk_gl_config_caveat_get_type())
#define GDK_TYPE_GL_VISUAL_TYPE (gdk_gl_visual_type_get_type())
#define GDK_TYPE_GL_TRANSPARENT_TYPE (gdk_gl_transparent_type_get_type())
#define GDK_TYPE_GL_DRAWABLE_TYPE_MASK (gdk_gl_drawable_type_mask_get_type())
#define GDK_TYPE_GL_RENDER_TYPE_MASK (gdk_gl_render_type_mask_get_type())
#define GDK_TYPE_GL_BUFFER_MASK (gdk_gl_buffer_mask_get_type())
#define GDK_TYPE_GL_CONFIG_ERROR (gdk_gl_config_error_get_type())
#define GDK_TYPE_GL_RENDER_TYPE (gdk_gl_render_type_get_type())
#define GDK_TYPE_GL_DRAWABLE_ATTRIB (gdk_gl_drawable_attrib_get_type())
#define GDK_TYPE_GL_PBUFFER_ATTRIB (gdk_gl_pbuffer_attrib_get_type())
#define GDK_TYPE_GL_EVENT_MASK (gdk_gl_event_mask_get_type())
#define GDK_TYPE_GL_EVENT_TYPE (gdk_gl_event_type_get_type())
#define GDK_TYPE_GL_DRAWABLE_TYPE (gdk_gl_drawable_type_get_type())
#define GDK_TYPE_GL_CONFIG_MODE (gdk_gl_config_mode_get_type())

declare function gdk_gl_config_attrib_get_type () as GType
declare function gdk_gl_config_caveat_get_type () as GType
declare function gdk_gl_visual_type_get_type () as GType
declare function gdk_gl_transparent_type_get_type () as GType
declare function gdk_gl_drawable_type_mask_get_type () as GType
declare function gdk_gl_render_type_mask_get_type () as GType
declare function gdk_gl_buffer_mask_get_type () as GType
declare function gdk_gl_config_error_get_type () as GType
declare function gdk_gl_render_type_get_type () as GType
declare function gdk_gl_drawable_attrib_get_type () as GType
declare function gdk_gl_pbuffer_attrib_get_type () as GType
declare function gdk_gl_event_mask_get_type () as GType
declare function gdk_gl_event_type_get_type () as GType
declare function gdk_gl_drawable_type_get_type () as GType
declare function gdk_gl_config_mode_get_type () as GType

#endif
