''
''
'' gtkmenu -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmenu_bi__
#define __gtkmenu_bi__

#include once "gtk/gdk.bi"
#include once "gtkaccelgroup.bi"
#include once "gtkmenushell.bi"

#define GTK_TYPE_MENU			gtk_menu_get_type()
#define GTK_MENU(obj)			G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_MENU, GtkMenu)
#define GTK_MENU_CLASS(klass)	G_TYPE_CHECK_CLASS_CAST(klass, GTK_TYPE_MENU, GtkMenuClass)
#define GTK_IS_MENU(obj)		G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_MENU)
#define GTK_IS_MENU_CLASS(klass)	G_TYPE_CHECK_CLASS_TYPE(klass, GTK_TYPE_MENU)
#define GTK_MENU_GET_CLASS(obj)     G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_MENU, GtkMenuClass)

type GtkMenu as _GtkMenu
type GtkMenuClass as _GtkMenuClass
type GtkMenuPositionFunc as sub cdecl(byval as GtkMenu ptr, byval as gint ptr, byval as gint ptr, byval as gboolean ptr, byval as gpointer)
type GtkMenuDetachFunc as sub cdecl(byval as GtkWidget ptr, byval as GtkMenu ptr)

type _GtkMenu
	menu_shell as GtkMenuShell
	parent_menu_item as GtkWidget ptr
	old_active_menu_item as GtkWidget ptr
	accel_group as GtkAccelGroup ptr
	accel_path as zstring ptr
	position_func as GtkMenuPositionFunc
	position_func_data as gpointer
	toggle_size as guint
	toplevel as GtkWidget ptr
	tearoff_window as GtkWidget ptr
	tearoff_hbox as GtkWidget ptr
	tearoff_scrollbar as GtkWidget ptr
	tearoff_adjustment as GtkAdjustment ptr
	view_window as GdkWindow ptr
	bin_window as GdkWindow ptr
	scroll_offset as gint
	saved_scroll_offset as gint
	scroll_step as gint
	timeout_id as guint
	navigation_region as GdkRegion ptr
	navigation_timeout as guint
	needs_destruction_ref_count:1 as guint
	torn_off:1 as guint
	tearoff_active:1 as guint
	scroll_fast:1 as guint
	upper_arrow_visible:1 as guint
	lower_arrow_visible:1 as guint
	upper_arrow_prelight:1 as guint
	lower_arrow_prelight:1 as guint
end type

type _GtkMenuClass
	parent_class as GtkMenuShellClass
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_menu_get_type () as GType
declare function gtk_menu_new () as GtkWidget ptr
declare sub gtk_menu_popup (byval menu as GtkMenu ptr, byval parent_menu_shell as GtkWidget ptr, byval parent_menu_item as GtkWidget ptr, byval func as GtkMenuPositionFunc, byval data as gpointer, byval button as guint, byval activate_time as guint32)
declare sub gtk_menu_reposition (byval menu as GtkMenu ptr)
declare sub gtk_menu_popdown (byval menu as GtkMenu ptr)
declare function gtk_menu_get_active (byval menu as GtkMenu ptr) as GtkWidget ptr
declare sub gtk_menu_set_active (byval menu as GtkMenu ptr, byval index_ as guint)
declare sub gtk_menu_set_accel_group (byval menu as GtkMenu ptr, byval accel_group as GtkAccelGroup ptr)
declare function gtk_menu_get_accel_group (byval menu as GtkMenu ptr) as GtkAccelGroup ptr
declare sub gtk_menu_set_accel_path (byval menu as GtkMenu ptr, byval accel_path as zstring ptr)
declare sub gtk_menu_attach_to_widget (byval menu as GtkMenu ptr, byval attach_widget as GtkWidget ptr, byval detacher as GtkMenuDetachFunc)
declare sub gtk_menu_detach (byval menu as GtkMenu ptr)
declare function gtk_menu_get_attach_widget (byval menu as GtkMenu ptr) as GtkWidget ptr
declare sub gtk_menu_set_tearoff_state (byval menu as GtkMenu ptr, byval torn_off as gboolean)
declare function gtk_menu_get_tearoff_state (byval menu as GtkMenu ptr) as gboolean
declare sub gtk_menu_set_title (byval menu as GtkMenu ptr, byval title as zstring ptr)
declare function gtk_menu_get_title (byval menu as GtkMenu ptr) as zstring ptr
declare sub gtk_menu_reorder_child (byval menu as GtkMenu ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_menu_set_screen (byval menu as GtkMenu ptr, byval screen as GdkScreen ptr)
declare sub gtk_menu_attach (byval menu as GtkMenu ptr, byval child as GtkWidget ptr, byval left_attach as guint, byval right_attach as guint, byval top_attach as guint, byval bottom_attach as guint)
declare sub gtk_menu_set_monitor (byval menu as GtkMenu ptr, byval monitor_num as gint)
declare function gtk_menu_get_for_attach_widget (byval widget as GtkWidget ptr) as GList ptr

#define gtk_menu_append(menu,child)	gtk_menu_shell_append(cptr(GtkMenuShell ptr, menu), child)
#define gtk_menu_prepend(menu,child) gtk_menu_shell_prepend(cptr(GtkMenuShell ptr, menu), child)
#define gtk_menu_insert(menu,child,pos)	gtk_menu_shell_insert(cptr(GtkMenuShell ptr, menu), child, pos)

#endif
