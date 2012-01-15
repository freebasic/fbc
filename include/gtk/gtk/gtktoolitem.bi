''
''
'' gtktoolitem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktoolitem_bi__
#define __gtktoolitem_bi__

#include once "gtkbin.bi"
#include once "gtktooltips.bi"
#include once "gtkmenuitem.bi"

#define GTK_TYPE_TOOL_ITEM (gtk_tool_item_get_type ())
#define GTK_TOOL_ITEM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_TOOL_ITEM, GtkToolItem))
#define GTK_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOOL_ITEM, GtkToolItemClass))
#define GTK_IS_TOOL_ITEM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_TOOL_ITEM))
#define GTK_IS_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOOL_ITEM))
#define GTK_TOOL_ITEM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_TOOL_ITEM, GtkToolItemClass))

type GtkToolItem as _GtkToolItem
type GtkToolItemClass as _GtkToolItemClass
type GtkToolItemPrivate as _GtkToolItemPrivate

type _GtkToolItem
	parent as GtkBin
	priv as GtkToolItemPrivate ptr
end type

type _GtkToolItemClass
	parent_class as GtkBinClass
	create_menu_proxy as function cdecl(byval as GtkToolItem ptr) as gboolean
	toolbar_reconfigured as sub cdecl(byval as GtkToolItem ptr)
	set_tooltip as function cdecl(byval as GtkToolItem ptr, byval as GtkTooltips ptr, byval as zstring ptr, byval as zstring ptr) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
	_gtk_reserved4 as sub cdecl()
end type

declare function gtk_tool_item_get_type () as GType
declare function gtk_tool_item_new () as GtkToolItem ptr
declare sub gtk_tool_item_set_homogeneous (byval tool_item as GtkToolItem ptr, byval homogeneous as gboolean)
declare function gtk_tool_item_get_homogeneous (byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_expand (byval tool_item as GtkToolItem ptr, byval expand as gboolean)
declare function gtk_tool_item_get_expand (byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_tooltip (byval tool_item as GtkToolItem ptr, byval tooltips as GtkTooltips ptr, byval tip_text as zstring ptr, byval tip_private as zstring ptr)
declare sub gtk_tool_item_set_use_drag_window (byval toolitem as GtkToolItem ptr, byval use_drag_window as gboolean)
declare function gtk_tool_item_get_use_drag_window (byval toolitem as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_visible_horizontal (byval toolitem as GtkToolItem ptr, byval visible_horizontal as gboolean)
declare function gtk_tool_item_get_visible_horizontal (byval toolitem as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_visible_vertical (byval toolitem as GtkToolItem ptr, byval visible_vertical as gboolean)
declare function gtk_tool_item_get_visible_vertical (byval toolitem as GtkToolItem ptr) as gboolean
declare function gtk_tool_item_get_is_important (byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_is_important (byval tool_item as GtkToolItem ptr, byval is_important as gboolean)
declare function gtk_tool_item_get_icon_size (byval tool_item as GtkToolItem ptr) as GtkIconSize
declare function gtk_tool_item_get_orientation (byval tool_item as GtkToolItem ptr) as GtkOrientation
declare function gtk_tool_item_get_toolbar_style (byval tool_item as GtkToolItem ptr) as GtkToolbarStyle
declare function gtk_tool_item_get_relief_style (byval tool_item as GtkToolItem ptr) as GtkReliefStyle
declare function gtk_tool_item_retrieve_proxy_menu_item (byval tool_item as GtkToolItem ptr) as GtkWidget ptr
declare function gtk_tool_item_get_proxy_menu_item (byval tool_item as GtkToolItem ptr, byval menu_item_id as zstring ptr) as GtkWidget ptr
declare sub gtk_tool_item_set_proxy_menu_item (byval tool_item as GtkToolItem ptr, byval menu_item_id as zstring ptr, byval menu_item as GtkWidget ptr)
declare sub gtk_tool_item_rebuild_menu (byval tool_item as GtkToolItem ptr)
declare sub _gtk_tool_item_toolbar_reconfigured (byval tool_item as GtkToolItem ptr)

#endif
