''
''
'' gtktoolbar -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gtktoolbar_bi__
#define __gtktoolbar_bi__

#include once "gtk/gdk.bi"
#include once "gtk/gtk/gtkcontainer.bi"
#include once "gtk/gtk/gtkenums.bi"
#include once "gtk/gtk/gtktooltips.bi"
#include once "gtk/gtk/gtktoolitem.bi"
#include once "gtk/gtk/gtkpixmap.bi"
#include once "gtk/gtk/gtksignal.bi"

enum GtkToolbarChildType
	GTK_TOOLBAR_CHILD_SPACE
	GTK_TOOLBAR_CHILD_BUTTON
	GTK_TOOLBAR_CHILD_TOGGLEBUTTON
	GTK_TOOLBAR_CHILD_RADIOBUTTON
	GTK_TOOLBAR_CHILD_WIDGET
end enum

type GtkToolbarChild as _GtkToolbarChild

type _GtkToolbarChild
	type as GtkToolbarChildType
	widget as GtkWidget ptr
	icon as GtkWidget ptr
	label as GtkWidget ptr
end type

enum GtkToolbarSpaceStyle
	GTK_TOOLBAR_SPACE_EMPTY
	GTK_TOOLBAR_SPACE_LINE
end enum

type GtkToolbar as _GtkToolbar
type GtkToolbarClass as _GtkToolbarClass
type GtkToolbarPrivate as _GtkToolbarPrivate

type _GtkToolbar
	container as GtkContainer
	num_children as gint
	children as GList ptr
	orientation as GtkOrientation
	style as GtkToolbarStyle
	icon_size as GtkIconSize
	tooltips as GtkTooltips ptr
	button_maxw as gint
	button_maxh as gint
	style_set_connection as guint
	icon_size_connection as guint
	style_set as guint
	icon_size_set as guint
end type

type _GtkToolbarClass
	parent_class as GtkContainerClass
	orientation_changed as sub cdecl(byval as GtkToolbar ptr, byval as GtkOrientation)
	style_changed as sub cdecl(byval as GtkToolbar ptr, byval as GtkToolbarStyle)
	popup_context_menu as function cdecl(byval as GtkToolbar ptr, byval as gint, byval as gint, byval as gint) as gboolean
	_gtk_reserved1 as sub cdecl()
	_gtk_reserved2 as sub cdecl()
	_gtk_reserved3 as sub cdecl()
end type

declare function gtk_toolbar_get_type cdecl alias "gtk_toolbar_get_type" () as GType
declare function gtk_toolbar_new cdecl alias "gtk_toolbar_new" () as GtkWidget ptr
declare sub gtk_toolbar_insert cdecl alias "gtk_toolbar_insert" (byval toolbar as GtkToolbar ptr, byval item as GtkToolItem ptr, byval pos as gint)
declare function gtk_toolbar_get_item_index cdecl alias "gtk_toolbar_get_item_index" (byval toolbar as GtkToolbar ptr, byval item as GtkToolItem ptr) as gint
declare function gtk_toolbar_get_n_items cdecl alias "gtk_toolbar_get_n_items" (byval toolbar as GtkToolbar ptr) as gint
declare function gtk_toolbar_get_nth_item cdecl alias "gtk_toolbar_get_nth_item" (byval toolbar as GtkToolbar ptr, byval n as gint) as GtkToolItem ptr
declare function gtk_toolbar_get_show_arrow cdecl alias "gtk_toolbar_get_show_arrow" (byval toolbar as GtkToolbar ptr) as gboolean
declare sub gtk_toolbar_set_show_arrow cdecl alias "gtk_toolbar_set_show_arrow" (byval toolbar as GtkToolbar ptr, byval show_arrow as gboolean)
declare function gtk_toolbar_get_orientation cdecl alias "gtk_toolbar_get_orientation" (byval toolbar as GtkToolbar ptr) as GtkOrientation
declare sub gtk_toolbar_set_orientation cdecl alias "gtk_toolbar_set_orientation" (byval toolbar as GtkToolbar ptr, byval orientation as GtkOrientation)
declare function gtk_toolbar_get_tooltips cdecl alias "gtk_toolbar_get_tooltips" (byval toolbar as GtkToolbar ptr) as gboolean
declare sub gtk_toolbar_set_tooltips cdecl alias "gtk_toolbar_set_tooltips" (byval toolbar as GtkToolbar ptr, byval enable as gboolean)
declare function gtk_toolbar_get_style cdecl alias "gtk_toolbar_get_style" (byval toolbar as GtkToolbar ptr) as GtkToolbarStyle
declare sub gtk_toolbar_set_style cdecl alias "gtk_toolbar_set_style" (byval toolbar as GtkToolbar ptr, byval style as GtkToolbarStyle)
declare sub gtk_toolbar_unset_style cdecl alias "gtk_toolbar_unset_style" (byval toolbar as GtkToolbar ptr)
declare function gtk_toolbar_get_icon_size cdecl alias "gtk_toolbar_get_icon_size" (byval toolbar as GtkToolbar ptr) as GtkIconSize
declare function gtk_toolbar_get_relief_style cdecl alias "gtk_toolbar_get_relief_style" (byval toolbar as GtkToolbar ptr) as GtkReliefStyle
declare function gtk_toolbar_get_drop_index cdecl alias "gtk_toolbar_get_drop_index" (byval toolbar as GtkToolbar ptr, byval x as gint, byval y as gint) as gint
declare sub gtk_toolbar_set_drop_highlight_item cdecl alias "gtk_toolbar_set_drop_highlight_item" (byval toolbar as GtkToolbar ptr, byval tool_item as GtkToolItem ptr, byval index_ as gint)
declare function _gtk_toolbar_elide_underscores cdecl alias "_gtk_toolbar_elide_underscores" (byval original as string) as zstring ptr
declare sub _gtk_toolbar_paint_space_line cdecl alias "_gtk_toolbar_paint_space_line" (byval widget as GtkWidget ptr, byval toolbar as GtkToolbar ptr, byval area as GdkRectangle ptr, byval allocation as GtkAllocation ptr)
declare function _gtk_toolbar_get_default_space_size cdecl alias "_gtk_toolbar_get_default_space_size" () as gint
declare sub _gtk_toolbar_rebuild_menu cdecl alias "_gtk_toolbar_rebuild_menu" (byval toolbar as GtkToolbar ptr)
declare sub gtk_toolbar_set_icon_size cdecl alias "gtk_toolbar_set_icon_size" (byval toolbar as GtkToolbar ptr, byval icon_size as GtkIconSize)
declare sub gtk_toolbar_unset_icon_size cdecl alias "gtk_toolbar_unset_icon_size" (byval toolbar as GtkToolbar ptr)
declare function gtk_toolbar_append_item cdecl alias "gtk_toolbar_append_item" (byval toolbar as GtkToolbar ptr, byval text as string, byval tooltip_text as string, byval tooltip_private_text as string, byval icon as GtkWidget ptr, byval callback as GtkSignalFunc, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_prepend_item cdecl alias "gtk_toolbar_prepend_item" (byval toolbar as GtkToolbar ptr, byval text as string, byval tooltip_text as string, byval tooltip_private_text as string, byval icon as GtkWidget ptr, byval callback as GtkSignalFunc, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_insert_item cdecl alias "gtk_toolbar_insert_item" (byval toolbar as GtkToolbar ptr, byval text as string, byval tooltip_text as string, byval tooltip_private_text as string, byval icon as GtkWidget ptr, byval callback as GtkSignalFunc, byval user_data as gpointer, byval position as gint) as GtkWidget ptr
declare function gtk_toolbar_insert_stock cdecl alias "gtk_toolbar_insert_stock" (byval toolbar as GtkToolbar ptr, byval stock_id as string, byval tooltip_text as string, byval tooltip_private_text as string, byval callback as GtkSignalFunc, byval user_data as gpointer, byval position as gint) as GtkWidget ptr
declare sub gtk_toolbar_append_space cdecl alias "gtk_toolbar_append_space" (byval toolbar as GtkToolbar ptr)
declare sub gtk_toolbar_prepend_space cdecl alias "gtk_toolbar_prepend_space" (byval toolbar as GtkToolbar ptr)
declare sub gtk_toolbar_insert_space cdecl alias "gtk_toolbar_insert_space" (byval toolbar as GtkToolbar ptr, byval position as gint)
declare sub gtk_toolbar_remove_space cdecl alias "gtk_toolbar_remove_space" (byval toolbar as GtkToolbar ptr, byval position as gint)
declare function gtk_toolbar_append_element cdecl alias "gtk_toolbar_append_element" (byval toolbar as GtkToolbar ptr, byval type as GtkToolbarChildType, byval widget as GtkWidget ptr, byval text as string, byval tooltip_text as string, byval tooltip_private_text as string, byval icon as GtkWidget ptr, byval callback as GtkSignalFunc, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_prepend_element cdecl alias "gtk_toolbar_prepend_element" (byval toolbar as GtkToolbar ptr, byval type as GtkToolbarChildType, byval widget as GtkWidget ptr, byval text as string, byval tooltip_text as string, byval tooltip_private_text as string, byval icon as GtkWidget ptr, byval callback as GtkSignalFunc, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_insert_element cdecl alias "gtk_toolbar_insert_element" (byval toolbar as GtkToolbar ptr, byval type as GtkToolbarChildType, byval widget as GtkWidget ptr, byval text as string, byval tooltip_text as string, byval tooltip_private_text as string, byval icon as GtkWidget ptr, byval callback as GtkSignalFunc, byval user_data as gpointer, byval position as gint) as GtkWidget ptr
declare sub gtk_toolbar_append_widget cdecl alias "gtk_toolbar_append_widget" (byval toolbar as GtkToolbar ptr, byval widget as GtkWidget ptr, byval tooltip_text as string, byval tooltip_private_text as string)
declare sub gtk_toolbar_prepend_widget cdecl alias "gtk_toolbar_prepend_widget" (byval toolbar as GtkToolbar ptr, byval widget as GtkWidget ptr, byval tooltip_text as string, byval tooltip_private_text as string)
declare sub gtk_toolbar_insert_widget cdecl alias "gtk_toolbar_insert_widget" (byval toolbar as GtkToolbar ptr, byval widget as GtkWidget ptr, byval tooltip_text as string, byval tooltip_private_text as string, byval position as gint)

#endif
