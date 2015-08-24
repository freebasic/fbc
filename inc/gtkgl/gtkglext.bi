'' FreeBASIC binding for gtkglext-1.2.0
''
'' based on the C header files:
''   GtkGLExt - OpenGL Extension to GTK+
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
	#inclib "gtkglext-x11-1.0"
#else
	#inclib "gtkglext-win32-1.0"
#endif

#include once "gtkgl/gdkglext.bi"
#include once "glib.bi"
#include once "gtk/gtk2.bi"

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

'' The following symbols have been renamed:
''     variable gtkglext_major_version => gtkglext_major_version_
''     variable gtkglext_minor_version => gtkglext_minor_version_
''     variable gtkglext_micro_version => gtkglext_micro_version_
''     variable gtkglext_interface_age => gtkglext_interface_age_
''     variable gtkglext_binary_age => gtkglext_binary_age_

extern "C"

#define __GTK_GL_H__
#define __GTK_GL_DEFS_H__
#define __GTK_GL_VERSION_H__
const GTKGLEXT_MAJOR_VERSION = 1
const GTKGLEXT_MINOR_VERSION = 2
const GTKGLEXT_MICRO_VERSION = 0
const GTKGLEXT_INTERFACE_AGE = 0
const GTKGLEXT_BINARY_AGE = 0
#define GTKGLEXT_CHECK_VERSION(major, minor, micro) (((GTKGLEXT_MAJOR_VERSION > (major)) orelse ((GTKGLEXT_MAJOR_VERSION = (major)) andalso (GTKGLEXT_MINOR_VERSION > (minor)))) orelse (((GTKGLEXT_MAJOR_VERSION = (major)) andalso (GTKGLEXT_MINOR_VERSION = (minor))) andalso (GTKGLEXT_MICRO_VERSION >= (micro))))

#ifdef __FB_UNIX__
	extern gtkglext_major_version_ alias "gtkglext_major_version" as const guint
	extern gtkglext_minor_version_ alias "gtkglext_minor_version" as const guint
	extern gtkglext_micro_version_ alias "gtkglext_micro_version" as const guint
	extern gtkglext_interface_age_ alias "gtkglext_interface_age" as const guint
	extern gtkglext_binary_age_ alias "gtkglext_binary_age" as const guint
#else
	extern import gtkglext_major_version_ alias "gtkglext_major_version" as const guint
	extern import gtkglext_minor_version_ alias "gtkglext_minor_version" as const guint
	extern import gtkglext_micro_version_ alias "gtkglext_micro_version" as const guint
	extern import gtkglext_interface_age_ alias "gtkglext_interface_age" as const guint
	extern import gtkglext_binary_age_ alias "gtkglext_binary_age" as const guint
#endif

#define __GTK_GL_INIT_H__
declare function gtk_gl_parse_args(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
declare function gtk_gl_init_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
declare sub gtk_gl_init(byval argc as long ptr, byval argv as zstring ptr ptr ptr)
#define __GTK_GL_WIDGET_H__
declare function gtk_widget_set_gl_capability(byval widget as GtkWidget ptr, byval glconfig as GdkGLConfig ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as long) as gboolean
declare function gtk_widget_is_gl_capable(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_get_gl_config(byval widget as GtkWidget ptr) as GdkGLConfig ptr
declare function gtk_widget_create_gl_context(byval widget as GtkWidget ptr, byval share_list as GdkGLContext ptr, byval direct as gboolean, byval render_type as long) as GdkGLContext ptr
declare function gtk_widget_get_gl_context(byval widget as GtkWidget ptr) as GdkGLContext ptr
declare function gtk_widget_get_gl_window(byval widget as GtkWidget ptr) as GdkGLWindow ptr
#define gtk_widget_get_gl_drawable(widget) GDK_GL_DRAWABLE(gtk_widget_get_gl_window(widget))

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
