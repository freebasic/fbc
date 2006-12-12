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

#include once "gdktypes.bi"
#include once "gdkdisplay.bi"

#define GDK_TYPE_DISPLAY_MANAGER (gdk_display_manager_get_type ())
#define GDK_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManager))
#define GDK_DISPLAY_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManagerClass))
#define GDK_IS_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY_MANAGER))
#define GDK_IS_DISPLAY_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DISPLAY_MANAGER))
#define GDK_DISPLAY_MANAGER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManagerClass))

type GdkDisplayManager as _GdkDisplayManager
type GdkDisplayManagerClass as _GdkDisplayManagerClass

type _GdkDisplayManagerClass
	parent_class as GObjectClass
	display_opened as sub cdecl(byval as GdkDisplayManager ptr, byval as GdkDisplay ptr)
end type

declare function gdk_display_manager_get_type () as GType
declare function gdk_display_manager_get () as GdkDisplayManager ptr
declare function gdk_display_manager_get_default_display (byval display_manager as GdkDisplayManager ptr) as GdkDisplay ptr
declare sub gdk_display_manager_set_default_display (byval display_manager as GdkDisplayManager ptr, byval display as GdkDisplay ptr)
declare function gdk_display_manager_list_displays (byval display_manager as GdkDisplayManager ptr) as GSList ptr

#endif
