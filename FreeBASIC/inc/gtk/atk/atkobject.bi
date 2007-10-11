''
''
'' atkobject -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkobject_bi__
#define __atkobject_bi__

#include once "gtk/glib-object.bi"
#include once "atkstate.bi"
#include once "atkrelationtype.bi"

#define ATK_TYPE_OBJECT() atk_object_get_type ()
#define ATK_OBJECT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_OBJECT, AtkObject)
#define ATK_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_OBJECT, AtkObjectClass)
#define ATK_IS_OBJECT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_OBJECT)
#define ATK_IS_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_OBJECT))
#define ATK_OBJECT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_OBJECT, AtkObjectClass)

#define ATK_TYPE_IMPLEMENTOR() atk_implementor_get_type ()
#define ATK_IS_IMPLEMENTOR(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_IMPLEMENTOR)
#define ATK_IMPLEMENTOR(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_IMPLEMENTOR, AtkImplementor)
#define ATK_IMPLEMENTOR_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_IMPLEMENTOR, AtkImplementorIface)

enum AtkRole
	ATK_ROLE_INVALID = 0
	ATK_ROLE_ACCEL_LABEL
	ATK_ROLE_ALERT
	ATK_ROLE_ANIMATION
	ATK_ROLE_ARROW
	ATK_ROLE_CALENDAR
	ATK_ROLE_CANVAS
	ATK_ROLE_CHECK_BOX
	ATK_ROLE_CHECK_MENU_ITEM
	ATK_ROLE_COLOR_CHOOSER
	ATK_ROLE_COLUMN_HEADER
	ATK_ROLE_COMBO_BOX
	ATK_ROLE_DATE_EDITOR
	ATK_ROLE_DESKTOP_ICON
	ATK_ROLE_DESKTOP_FRAME
	ATK_ROLE_DIAL
	ATK_ROLE_DIALOG
	ATK_ROLE_DIRECTORY_PANE
	ATK_ROLE_DRAWING_AREA
	ATK_ROLE_FILE_CHOOSER
	ATK_ROLE_FILLER
	ATK_ROLE_FONT_CHOOSER
	ATK_ROLE_FRAME
	ATK_ROLE_GLASS_PANE
	ATK_ROLE_HTML_CONTAINER
	ATK_ROLE_ICON
	ATK_ROLE_IMAGE
	ATK_ROLE_INTERNAL_FRAME
	ATK_ROLE_LABEL
	ATK_ROLE_LAYERED_PANE
	ATK_ROLE_LIST
	ATK_ROLE_LIST_ITEM
	ATK_ROLE_MENU
	ATK_ROLE_MENU_BAR
	ATK_ROLE_MENU_ITEM
	ATK_ROLE_OPTION_PANE
	ATK_ROLE_PAGE_TAB
	ATK_ROLE_PAGE_TAB_LIST
	ATK_ROLE_PANEL
	ATK_ROLE_PASSWORD_TEXT
	ATK_ROLE_POPUP_MENU
	ATK_ROLE_PROGRESS_BAR
	ATK_ROLE_PUSH_BUTTON
	ATK_ROLE_RADIO_BUTTON
	ATK_ROLE_RADIO_MENU_ITEM
	ATK_ROLE_ROOT_PANE
	ATK_ROLE_ROW_HEADER
	ATK_ROLE_SCROLL_BAR
	ATK_ROLE_SCROLL_PANE
	ATK_ROLE_SEPARATOR
	ATK_ROLE_SLIDER
	ATK_ROLE_SPLIT_PANE
	ATK_ROLE_SPIN_BUTTON
	ATK_ROLE_STATUSBAR
	ATK_ROLE_TABLE
	ATK_ROLE_TABLE_CELL
	ATK_ROLE_TABLE_COLUMN_HEADER
	ATK_ROLE_TABLE_ROW_HEADER
	ATK_ROLE_TEAR_OFF_MENU_ITEM
	ATK_ROLE_TERMINAL
	ATK_ROLE_TEXT
	ATK_ROLE_TOGGLE_BUTTON
	ATK_ROLE_TOOL_BAR
	ATK_ROLE_TOOL_TIP
	ATK_ROLE_TREE
	ATK_ROLE_TREE_TABLE
	ATK_ROLE_UNKNOWN
	ATK_ROLE_VIEWPORT
	ATK_ROLE_WINDOW
	ATK_ROLE_HEADER
	ATK_ROLE_FOOTER
	ATK_ROLE_PARAGRAPH
	ATK_ROLE_RULER
	ATK_ROLE_APPLICATION
	ATK_ROLE_AUTOCOMPLETE
	ATK_ROLE_EDITBAR
	ATK_ROLE_EMBEDDED
	ATK_ROLE_LAST_DEFINED
end enum


declare function atk_role_register (byval name as zstring ptr) as AtkRole

enum AtkLayer
	ATK_LAYER_INVALID
	ATK_LAYER_BACKGROUND
	ATK_LAYER_CANVAS
	ATK_LAYER_WIDGET
	ATK_LAYER_MDI
	ATK_LAYER_POPUP
	ATK_LAYER_OVERLAY
	ATK_LAYER_WINDOW
end enum

type AtkImplementor as _AtkImplementor
type AtkImplementorIface as _AtkImplementorIface
type AtkObject as _AtkObject
type AtkObjectClass as _AtkObjectClass
type AtkRelationSet as _AtkRelationSet
type AtkStateSet as _AtkStateSet

type _AtkPropertyValues
	property_name as zstring ptr
	old_value as GValue
	new_value as GValue
end type

type AtkPropertyValues as _AtkPropertyValues
type AtkFunction as function cdecl(byval as gpointer) as gboolean
type AtkPropertyChangeHandler as sub cdecl(byval as AtkObject ptr, byval as AtkPropertyValues ptr)

type _AtkObject
	parent as GObject
	description as zstring ptr
	name as zstring ptr
	accessible_parent as AtkObject ptr
	role as AtkRole
	relation_set as AtkRelationSet ptr
	layer as AtkLayer
end type

type _AtkObjectClass
	parent as GObjectClass
	get_name as function cdecl(byval as AtkObject ptr) as gchar
	get_description as function cdecl(byval as AtkObject ptr) as gchar
	get_parent as function cdecl(byval as AtkObject ptr) as AtkObject
	get_n_children as function cdecl(byval as AtkObject ptr) as gint
	ref_child as function cdecl(byval as AtkObject ptr, byval as gint) as AtkObject ptr
	get_index_in_parent as function cdecl(byval as AtkObject ptr) as gint
	ref_relation_set as function cdecl(byval as AtkObject ptr) as AtkRelationSet ptr
	get_role as function cdecl(byval as AtkObject ptr) as AtkRole
	get_layer as function cdecl(byval as AtkObject ptr) as AtkLayer
	get_mdi_zorder as function cdecl(byval as AtkObject ptr) as gint
	ref_state_set as function cdecl(byval as AtkObject ptr) as AtkStateSet ptr
	set_name as sub cdecl(byval as AtkObject ptr, byval as zstring ptr)
	set_description as sub cdecl(byval as AtkObject ptr, byval as zstring ptr)
	set_parent as sub cdecl(byval as AtkObject ptr, byval as AtkObject ptr)
	set_role as sub cdecl(byval as AtkObject ptr, byval as AtkRole)
	connect_property_change_handler as function cdecl(byval as AtkObject ptr, byval as AtkPropertyChangeHandler ptr) as guint
	remove_property_change_handler as sub cdecl(byval as AtkObject ptr, byval as guint)
	initialize as sub cdecl(byval as AtkObject ptr, byval as gpointer)
	children_changed as sub cdecl(byval as AtkObject ptr, byval as guint, byval as gpointer)
	focus_event as sub cdecl(byval as AtkObject ptr, byval as gboolean)
	property_change as sub cdecl(byval as AtkObject ptr, byval as AtkPropertyValues ptr)
	state_change as sub cdecl(byval as AtkObject ptr, byval as zstring ptr, byval as gboolean)
	visible_data_changed as sub cdecl(byval as AtkObject ptr)
	active_descendant_changed as sub cdecl(byval as AtkObject ptr, byval as gpointer ptr)
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
end type

declare function atk_object_get_type () as GType

type _AtkImplementorIface
	parent as GTypeInterface
	ref_accessible as function cdecl(byval as AtkImplementor ptr) as AtkObject
end type

declare function atk_implementor_get_type () as GType
declare function atk_implementor_ref_accessible (byval implementor as AtkImplementor ptr) as AtkObject ptr
declare function atk_object_get_name (byval accessible as AtkObject ptr) as zstring ptr
declare function atk_object_get_description (byval accessible as AtkObject ptr) as zstring ptr
declare function atk_object_get_parent (byval accessible as AtkObject ptr) as AtkObject ptr
declare function atk_object_get_n_accessible_children (byval accessible as AtkObject ptr) as gint
declare function atk_object_ref_accessible_child (byval accessible as AtkObject ptr, byval i as gint) as AtkObject ptr
declare function atk_object_ref_relation_set (byval accessible as AtkObject ptr) as AtkRelationSet ptr
declare function atk_object_get_role (byval accessible as AtkObject ptr) as AtkRole
declare function atk_object_get_layer (byval accessible as AtkObject ptr) as AtkLayer
declare function atk_object_get_mdi_zorder (byval accessible as AtkObject ptr) as gint
declare function atk_object_ref_state_set (byval accessible as AtkObject ptr) as AtkStateSet ptr
declare function atk_object_get_index_in_parent (byval accessible as AtkObject ptr) as gint
declare sub atk_object_set_name (byval accessible as AtkObject ptr, byval name as zstring ptr)
declare sub atk_object_set_description (byval accessible as AtkObject ptr, byval description as zstring ptr)
declare sub atk_object_set_parent (byval accessible as AtkObject ptr, byval parent as AtkObject ptr)
declare sub atk_object_set_role (byval accessible as AtkObject ptr, byval role as AtkRole)
declare function atk_object_connect_property_change_handler (byval accessible as AtkObject ptr, byval handler as AtkPropertyChangeHandler ptr) as guint
declare sub atk_object_remove_property_change_handler (byval accessible as AtkObject ptr, byval handler_id as guint)
declare sub atk_object_notify_state_change (byval accessible as AtkObject ptr, byval state as AtkState, byval value as gboolean)
declare sub atk_object_initialize (byval accessible as AtkObject ptr, byval data as gpointer)
declare function atk_role_get_name (byval role as AtkRole) as zstring ptr
declare function atk_role_for_name (byval name as zstring ptr) as AtkRole
declare function atk_object_add_relationship (byval object as AtkObject ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr) as gboolean
declare function atk_object_remove_relationship (byval object as AtkObject ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr) as gboolean
declare function atk_role_get_localized_name (byval role as AtkRole) as zstring ptr

#endif
