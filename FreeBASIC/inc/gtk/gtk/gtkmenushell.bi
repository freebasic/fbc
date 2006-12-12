''
''
'' gtkmenushell -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkmenushell_bi__
#define __gtkmenushell_bi__

#include once "gtk/gdk.bi"
#include once "gtkcontainer.bi"

#define	GTK_TYPE_MENU_SHELL (gtk_menu_shell_get_type ())
#define GTK_MENU_SHELL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MENU_SHELL, GtkMenuShell))
#define GTK_MENU_SHELL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MENU_SHELL, GtkMenuShellClass))
#define GTK_IS_MENU_SHELL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MENU_SHELL))
#define GTK_IS_MENU_SHELL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MENU_SHELL))
#define GTK_MENU_SHELL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MENU_SHELL, GtkMenuShellClass))

type GtkMenuShell as _GtkMenuShell
type GtkMenuShellClass as _GtkMenuShellClass

type _GtkMenuShell
	container as GtkContainer
	children as GList ptr
	active_menu_item as GtkWidget ptr
	parent_menu_shell as GtkWidget ptr
	button as guint
	activate_time as guint32
	active:1 as guint
	have_grab:1 as guint
	have_xgrab:1 as guint
	ignore_leave:1 as guint
	menu_flag:1 as guint
	ignore_enter:1 as guint
end type

type _GtkMenuShellClass
	parent_class as GtkContainerClass
	submenu_placement as guint
	deactivate as sub cdecl(byval as GtkMenuShell ptr)
	selection_done as sub cdecl(byval as GtkMenuShell ptr)
	move_current as sub cdecl(byval as GtkMenuShell ptr, byval as GtkMenuDirectionType)
	activate_current as sub cdecl(byval as GtkMenuShell ptr, byval as gboolean)
	cancel as sub cdecl(byval as GtkMenuShell ptr)
	select_item as sub cdecl(byval as GtkMenuShell ptr, byval as GtkWidget ptr)
	insert as sub cdecl(byval as GtkMenuShell ptr, byval as GtkWidget ptr, byval as gint)
	get_popup_delay as function cdecl(byval as GtkMenuShell ptr) as gint
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_menu_shell_get_type () as GType
declare sub gtk_menu_shell_append (byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr)
declare sub gtk_menu_shell_prepend (byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr)
declare sub gtk_menu_shell_insert (byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_menu_shell_deactivate (byval menu_shell as GtkMenuShell ptr)
declare sub gtk_menu_shell_select_item (byval menu_shell as GtkMenuShell ptr, byval menu_item as GtkWidget ptr)
declare sub gtk_menu_shell_deselect (byval menu_shell as GtkMenuShell ptr)
declare sub gtk_menu_shell_activate_item (byval menu_shell as GtkMenuShell ptr, byval menu_item as GtkWidget ptr, byval force_deactivate as gboolean)
declare sub gtk_menu_shell_select_first (byval menu_shell as GtkMenuShell ptr, byval search_sensitive as gboolean)
declare sub _gtk_menu_shell_select_last (byval menu_shell as GtkMenuShell ptr, byval search_sensitive as gboolean)
declare sub _gtk_menu_shell_activate (byval menu_shell as GtkMenuShell ptr)
declare function _gtk_menu_shell_get_popup_delay (byval menu_shell as GtkMenuShell ptr) as gint
declare sub gtk_menu_shell_cancel (byval menu_shell as GtkMenuShell ptr)
declare sub _gtk_menu_shell_add_mnemonic (byval menu_shell as GtkMenuShell ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare sub _gtk_menu_shell_remove_mnemonic (byval menu_shell as GtkMenuShell ptr, byval keyval as guint, byval target as GtkWidget ptr)

#endif
