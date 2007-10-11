''
''
'' gtkaction -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtkaction_bi__
#define __gtkaction_bi__

#include once "gtkwidget.bi"
#include once "gtk/glib-object.bi"

#define GTK_TYPE_ACTION (gtk_action_get_type ())
#define GTK_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACTION, GtkAction))
#define GTK_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACTION, GtkActionClass))
#define GTK_IS_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACTION))
#define GTK_IS_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACTION))
#define GTK_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACTION, GtkActionClass))

type GtkAction as _GtkAction
type GtkActionClass as _GtkActionClass
type GtkActionPrivate as _GtkActionPrivate

type _GtkAction
	object as GObject
	private_data as GtkActionPrivate ptr
end type

type _GtkActionClass
	parent_class as GObjectClass
	activate as sub cdecl(byval as GtkAction ptr)
	menu_item_type as GType
	toolbar_item_type as GType
	create_menu_item as function cdecl(byval as GtkAction ptr) as GtkWidget
	create_tool_item as function cdecl(byval as GtkAction ptr) as GtkWidget
	connect_proxy as sub cdecl(byval as GtkAction ptr, byval as GtkWidget ptr)
	disconnect_proxy as sub cdecl(byval as GtkAction ptr, byval as GtkWidget ptr)
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_action_get_type () as GType
declare function gtk_action_new (byval name as zstring ptr, byval label as zstring ptr, byval tooltip as zstring ptr, byval stock_id as zstring ptr) as GtkAction ptr
declare function gtk_action_get_name (byval action as GtkAction ptr) as zstring ptr
declare function gtk_action_is_sensitive (byval action as GtkAction ptr) as gboolean
declare function gtk_action_get_sensitive (byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_sensitive (byval action as GtkAction ptr, byval sensitive as gboolean)
declare function gtk_action_is_visible (byval action as GtkAction ptr) as gboolean
declare function gtk_action_get_visible (byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_visible (byval action as GtkAction ptr, byval visible as gboolean)
declare sub gtk_action_activate (byval action as GtkAction ptr)
declare function gtk_action_create_icon (byval action as GtkAction ptr, byval icon_size as GtkIconSize) as GtkWidget ptr
declare function gtk_action_create_menu_item (byval action as GtkAction ptr) as GtkWidget ptr
declare function gtk_action_create_tool_item (byval action as GtkAction ptr) as GtkWidget ptr
declare sub gtk_action_connect_proxy (byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub gtk_action_disconnect_proxy (byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare function gtk_action_get_proxies (byval action as GtkAction ptr) as GSList ptr
declare sub gtk_action_connect_accelerator (byval action as GtkAction ptr)
declare sub gtk_action_disconnect_accelerator (byval action as GtkAction ptr)
declare function gtk_action_get_accel_path (byval action as GtkAction ptr) as zstring ptr
declare sub gtk_action_block_activate_from (byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub gtk_action_unblock_activate_from (byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_emit_activate (byval action as GtkAction ptr)
declare sub gtk_action_set_accel_path (byval action as GtkAction ptr, byval accel_path as zstring ptr)
declare sub gtk_action_set_accel_group (byval action as GtkAction ptr, byval accel_group as GtkAccelGroup ptr)

#endif
