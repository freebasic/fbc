''
''
'' gtkdebug -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkdebug_bi__
#define __gtkdebug_bi__

#include once "gtk/glib.bi"

enum GtkDebugFlag
	GTK_DEBUG_MISC = 1 shl 0
	GTK_DEBUG_PLUGSOCKET = 1 shl 1
	GTK_DEBUG_TEXT = 1 shl 2
	GTK_DEBUG_TREE = 1 shl 3
	GTK_DEBUG_UPDATES = 1 shl 4
	GTK_DEBUG_KEYBINDINGS = 1 shl 5
	GTK_DEBUG_MULTIHEAD = 1 shl 6
	GTK_DEBUG_MODULES = 1 shl 7
	GTK_DEBUG_GEOMETRY = 1 shl 8
	GTK_DEBUG_ICONTHEME = 1 shl 9
end enum


#endif
