' This is file gtkglext.bi
' (FreeBasic binding for GTK OpenGl extension version 1.2.0)
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
'/* GtkGLExt - OpenGL Extension to GTK+
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

#IFNDEF __GTK_H__
 #INCLUDE ONCE "gtk/gtk-2.24.bi"
#ENDIF

#IFNDEF __GDK_GL_H__
 #INCLUDE ONCE "gdkglext.bi"
#ENDIF

#IFDEF __FB_WIN32__
 #PRAGMA push(msbitfields)
 #INCLIB "gtkglext-win32-1.0"
#ELSEIF NOT DEFINED(__FB_LINUX__)
 #ERROR "Platform not supported!"
#ELSE
 #INCLIB "gtkglext-x11-1.0"
#ENDIF

EXTERN "C"

#IFNDEF __GTK_GL_H__
#DEFINE __GTK_GL_H__

#IFNDEF __GTK_GL_DEFS_H__
#DEFINE __GTK_GL_DEFS_H__

#ENDIF ' __GTK_GL_DEFS_H__

#IFNDEF __GTK_GL_VERSION_H__
#DEFINE __GTK_GL_VERSION_H__

#DEFINE GTKGLEXT_MAJOR_VERSION (1)
#DEFINE GTKGLEXT_MINOR_VERSION (2)
#DEFINE GTKGLEXT_MICRO_VERSION (0)
#DEFINE GTKGLEXT_INTERFACE_AGE (0)
#DEFINE GTKGLEXT_BINARY_AGE (0)
#DEFINE GTKGLEXT_CHECK_VERSION(major, minor, micro) _
  (GTKGLEXT_MAJOR_VERSION > (major) ORELSE _
  (GTKGLEXT_MAJOR_VERSION = (major) ANDALSO GTKGLEXT_MINOR_VERSION > (minor)) ORELSE _
  (GTKGLEXT_MAJOR_VERSION = (major) ANDALSO GTKGLEXT_MINOR_VERSION = (minor) ANDALSO _
   GTKGLEXT_MICRO_VERSION >= (micro)))

EXTERN AS CONST guint gtkglext_major_version_FB ALIAS "gtkglext_major_version"
EXTERN AS CONST guint gtkglext_minor_version_FB ALIAS "gtkglext_minor_version"
EXTERN AS CONST guint gtkglext_micro_version_FB ALIAS "gtkglext_micro_version"
EXTERN AS CONST guint gtkglext_interface_age_FB ALIAS "gtkglext_interface_age"
EXTERN AS CONST guint gtkglext_binary_age_FB ALIAS "gtkglext_binary_age"

#ENDIF ' __GTK_GL_VERSION_H__

#IFNDEF __GTK_GL_INIT_H__
#DEFINE __GTK_GL_INIT_H__

DECLARE FUNCTION gtk_gl_parse_args(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR) AS gboolean
DECLARE FUNCTION gtk_gl_init_check(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR) AS gboolean
DECLARE SUB gtk_gl_init(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR)

#ENDIF ' __GTK_GL_INIT_H__

#IFNDEF __GTK_GL_WIDGET_H__
#DEFINE __GTK_GL_WIDGET_H__

DECLARE FUNCTION gtk_widget_set_gl_capability(BYVAL AS GtkWidget PTR, BYVAL AS GdkGLConfig PTR, BYVAL AS GdkGLContext PTR, BYVAL AS gboolean, BYVAL AS INTEGER) AS gboolean
DECLARE FUNCTION gtk_widget_is_gl_capable(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_get_gl_config(BYVAL AS GtkWidget PTR) AS GdkGLConfig PTR
DECLARE FUNCTION gtk_widget_create_gl_context(BYVAL AS GtkWidget PTR, BYVAL AS GdkGLContext PTR, BYVAL AS gboolean, BYVAL AS INTEGER) AS GdkGLContext PTR
DECLARE FUNCTION gtk_widget_get_gl_context(BYVAL AS GtkWidget PTR) AS GdkGLContext PTR
DECLARE FUNCTION gtk_widget_get_gl_window(BYVAL AS GtkWidget PTR) AS GdkGLWindow PTR

#DEFINE gtk_widget_get_gl_drawable(widget) _
  GDK_GL_DRAWABLE (gtk_widget_get_gl_window (widget))

#ENDIF ' __GTK_GL_WIDGET_H__
#ENDIF ' __GTK_GL_H__

END EXTERN

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF
