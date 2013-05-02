' This is file gmodule.bi
' (FreeBasic binding for GLib:GModule library version 2.32.4)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011-2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
'
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
'/* GMODULE - GLIB wrapper code for dynamic module loading
 '* Copyright (C) 1998 Tim Janik
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

'/*
 '* Modified by the GLib Team and others 1997-2000.  See the AUTHORS
 '* file for a list of people on the GLib Team.  See the ChangeLog
 '* files for a list of changes.  These files are distributed with
 '* GLib at ftp://ftp.gtk.org/pub/gtk/.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "gmodule-2.0"

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF __GMODULE_H__
#DEFINE __GMODULE_H__
#INCLUDE ONCE "glib.bi" '__HEADERS__: glib.h
#DEFINE G_MODULE_IMPORT extern

#IFDEF G_PLATFORM_WIN32
#DEFINE G_MODULE_EXPORT __declspec(dllexport)
#ELSE ' G_PLATFORM_WIN32
#DEFINE G_MODULE_EXPORT
#ENDIF ' G_PLATFORM_WIN32

ENUM GModuleFlags
  G_MODULE_BIND_LAZY = 1  SHL 0
  G_MODULE_BIND_LOCAL = 1  SHL 1
  G_MODULE_BIND_MASK = &h03
END ENUM

TYPE GModule AS _GModule
TYPE GModuleCheckInit AS FUNCTION(BYVAL AS GModule PTR) AS CONST gchar PTR
TYPE GModuleUnload AS SUB(BYVAL AS GModule PTR)

#IFNDEF __GTK_DOC_IGNORE__
#IFDEF G_OS_WIN32
#DEFINE g_module_open g_module_open_utf8
#DEFINE g_module_name g_module_name_utf8
#ENDIF ' G_OS_WIN32
#ENDIF ' __GTK_DOC_IGNORE__

DECLARE FUNCTION g_module_supported() AS gboolean
DECLARE FUNCTION g_module_open(BYVAL AS CONST gchar PTR, BYVAL AS GModuleFlags) AS GModule PTR
DECLARE FUNCTION g_module_close(BYVAL AS GModule PTR) AS gboolean
DECLARE SUB g_module_make_resident(BYVAL AS GModule PTR)
DECLARE FUNCTION g_module_error() AS CONST gchar PTR
DECLARE FUNCTION g_module_symbol(BYVAL AS GModule PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE FUNCTION g_module_name(BYVAL AS GModule PTR) AS CONST gchar PTR
DECLARE FUNCTION g_module_build_path(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __GMODULE_H__

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF

' Translated at 12-08-18 18:29:01, by h_2_bi (version 0.2.2.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: GMODULE-2.32.4.bi
' Parameters: GMODULE-2.32.4
'                                  Process time [s]: 0.007307972875423729
'                                  Bytes translated: 1629
'                                      Maximum deep: 1
'                                SUB/FUNCTION names: 10
'                                mangled TYPE names: 0
'                                        files done: 1
' glib-2.32.4/gmodule/gmodule.h
'                                      files missed: 0
'                                       __FOLDERS__: 2
' glib-2.32.4/
' glib-2.32.4/gmodule/
'                                        __MACROS__: 3
' 1: #define G_BEGIN_DECLS
' 1: #define G_END_DECLS
' 1: #define G_GNUC_CONST
'                                       __HEADERS__: 1
' 1: gmodule.h>
'                                         __TYPES__: 0
'                                     __POST_REPS__: 0
