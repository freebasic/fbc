''
''
'' gdkdisplaymanager -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkdisplaymanager_bi__
#define __gdkdisplaymanager_bi__

#include once "gtk/gdk/gdktypes.bi"
#include once "gtk/gdk/gdkdisplay.bi"

type GdkDisplayManager as _GdkDisplayManager
type GdkDisplayManagerClass as _GdkDisplayManagerClass

type _GdkDisplayManagerClass
	parent_class as GObjectClass
	display_opened as sub cdecl(byval as GdkDisplayManager ptr, byval as GdkDisplay ptr)
end type

declare function gdk_display_manager_get_type cdecl alias "gdk_display_manager_get_type" () as GType
declare function gdk_display_manager_get cdecl alias "gdk_display_manager_get" () as GdkDisplayManager ptr
declare function gdk_display_manager_get_default_display cdecl alias "gdk_display_manager_get_default_display" (byval display_manager as GdkDisplayManager ptr) as GdkDisplay ptr
declare sub gdk_display_manager_set_default_display cdecl alias "gdk_display_manager_set_default_display" (byval display_manager as GdkDisplayManager ptr, byval display as GdkDisplay ptr)
declare function gdk_display_manager_list_displays cdecl alias "gdk_display_manager_list_displays" (byval display_manager as GdkDisplayManager ptr) as GSList ptr

#endif
