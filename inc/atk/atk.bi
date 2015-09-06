'' FreeBASIC binding for atk-2.16.0
''
'' based on the C header files:
''   ATK -  Accessibility Toolkit
''   Copyright 2001 Sun Microsystems Inc.
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Library General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Library General Public License for more details.
''
''   You should have received a copy of the GNU Library General Public
''   License along with this library; if not, write to the
''   Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
''   Boston, MA 02111-1301, USA.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "atk-1.0"

#include once "glib-object.bi"
#include once "glib.bi"

'' The following symbols have been renamed:
''     constant ATK_HYPERLINK_IS_INLINE => ATK_HYPERLINK_IS_INLINE_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __ATK_H__
#define __ATK_H_INSIDE__
#define __ATK_OBJECT_H__
#define __ATK_VERSION_H__
const ATK_MAJOR_VERSION = 2
const ATK_MINOR_VERSION = 16
const ATK_MICRO_VERSION = 0
const ATK_BINARY_AGE = 21610
const ATK_INTERFACE_AGE = 1
#define ATK_CHECK_VERSION(major, minor, micro) (((ATK_MAJOR_VERSION > (major)) orelse ((ATK_MAJOR_VERSION = (major)) andalso (ATK_MINOR_VERSION > (minor)))) orelse (((ATK_MAJOR_VERSION = (major)) andalso (ATK_MINOR_VERSION = (minor))) andalso (ATK_MICRO_VERSION >= (micro))))
#define ATK_VERSION_2_2 G_ENCODE_VERSION(2, 2)
#define ATK_VERSION_2_4 G_ENCODE_VERSION(2, 4)
#define ATK_VERSION_2_6 G_ENCODE_VERSION(2, 6)
#define ATK_VERSION_2_8 G_ENCODE_VERSION(2, 8)
#define ATK_VERSION_2_10 G_ENCODE_VERSION(2, 10)
#define ATK_VERSION_2_12 G_ENCODE_VERSION(2, 12)
#define ATK_VERSION_2_14 G_ENCODE_VERSION(2, 14)
#define ATK_VERSION_CUR_STABLE G_ENCODE_VERSION(ATK_MAJOR_VERSION, ATK_MINOR_VERSION)
#define ATK_VERSION_PREV_STABLE G_ENCODE_VERSION(ATK_MAJOR_VERSION, ATK_MINOR_VERSION - 2)
#define ATK_VERSION_MIN_REQUIRED ATK_VERSION_CUR_STABLE
#undef ATK_VERSION_MAX_ALLOWED
#define ATK_VERSION_MAX_ALLOWED ATK_VERSION_CUR_STABLE

declare function atk_get_major_version() as guint
declare function atk_get_minor_version() as guint
declare function atk_get_micro_version() as guint
declare function atk_get_binary_age() as guint
declare function atk_get_interface_age() as guint
#define __ATK_STATE_H__

type AtkStateType as long
enum
	ATK_STATE_INVALID
	ATK_STATE_ACTIVE
	ATK_STATE_ARMED
	ATK_STATE_BUSY
	ATK_STATE_CHECKED
	ATK_STATE_DEFUNCT
	ATK_STATE_EDITABLE
	ATK_STATE_ENABLED
	ATK_STATE_EXPANDABLE
	ATK_STATE_EXPANDED
	ATK_STATE_FOCUSABLE
	ATK_STATE_FOCUSED
	ATK_STATE_HORIZONTAL
	ATK_STATE_ICONIFIED
	ATK_STATE_MODAL
	ATK_STATE_MULTI_LINE
	ATK_STATE_MULTISELECTABLE
	ATK_STATE_OPAQUE
	ATK_STATE_PRESSED
	ATK_STATE_RESIZABLE
	ATK_STATE_SELECTABLE
	ATK_STATE_SELECTED
	ATK_STATE_SENSITIVE
	ATK_STATE_SHOWING
	ATK_STATE_SINGLE_LINE
	ATK_STATE_STALE
	ATK_STATE_TRANSIENT
	ATK_STATE_VERTICAL
	ATK_STATE_VISIBLE
	ATK_STATE_MANAGES_DESCENDANTS
	ATK_STATE_INDETERMINATE
	ATK_STATE_TRUNCATED
	ATK_STATE_REQUIRED
	ATK_STATE_INVALID_ENTRY
	ATK_STATE_SUPPORTS_AUTOCOMPLETION
	ATK_STATE_SELECTABLE_TEXT
	ATK_STATE_DEFAULT
	ATK_STATE_ANIMATED
	ATK_STATE_VISITED
	ATK_STATE_CHECKABLE
	ATK_STATE_HAS_POPUP
	ATK_STATE_HAS_TOOLTIP
	ATK_STATE_READ_ONLY
	ATK_STATE_LAST_DEFINED
end enum

type AtkState as guint64
declare function atk_state_type_register(byval name as const gchar ptr) as AtkStateType
declare function atk_state_type_get_name(byval type as AtkStateType) as const gchar ptr
declare function atk_state_type_for_name(byval name as const gchar ptr) as AtkStateType
#define __ATK_RELATION_TYPE_H__

type AtkRelationType as long
enum
	ATK_RELATION_NULL = 0
	ATK_RELATION_CONTROLLED_BY
	ATK_RELATION_CONTROLLER_FOR
	ATK_RELATION_LABEL_FOR
	ATK_RELATION_LABELLED_BY
	ATK_RELATION_MEMBER_OF
	ATK_RELATION_NODE_CHILD_OF
	ATK_RELATION_FLOWS_TO
	ATK_RELATION_FLOWS_FROM
	ATK_RELATION_SUBWINDOW_OF
	ATK_RELATION_EMBEDS
	ATK_RELATION_EMBEDDED_BY
	ATK_RELATION_POPUP_FOR
	ATK_RELATION_PARENT_WINDOW_OF
	ATK_RELATION_DESCRIBED_BY
	ATK_RELATION_DESCRIPTION_FOR
	ATK_RELATION_NODE_PARENT_OF
	ATK_RELATION_LAST_DEFINED
end enum

type AtkRole as long
enum
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
	ATK_ROLE_ENTRY
	ATK_ROLE_CHART
	ATK_ROLE_CAPTION
	ATK_ROLE_DOCUMENT_FRAME
	ATK_ROLE_HEADING
	ATK_ROLE_PAGE
	ATK_ROLE_SECTION
	ATK_ROLE_REDUNDANT_OBJECT
	ATK_ROLE_FORM
	ATK_ROLE_LINK
	ATK_ROLE_INPUT_METHOD_WINDOW
	ATK_ROLE_TABLE_ROW
	ATK_ROLE_TREE_ITEM
	ATK_ROLE_DOCUMENT_SPREADSHEET
	ATK_ROLE_DOCUMENT_PRESENTATION
	ATK_ROLE_DOCUMENT_TEXT
	ATK_ROLE_DOCUMENT_WEB
	ATK_ROLE_DOCUMENT_EMAIL
	ATK_ROLE_COMMENT
	ATK_ROLE_LIST_BOX
	ATK_ROLE_GROUPING
	ATK_ROLE_IMAGE_MAP
	ATK_ROLE_NOTIFICATION
	ATK_ROLE_INFO_BAR
	ATK_ROLE_LEVEL_BAR
	ATK_ROLE_TITLE_BAR
	ATK_ROLE_BLOCK_QUOTE
	ATK_ROLE_AUDIO
	ATK_ROLE_VIDEO
	ATK_ROLE_DEFINITION
	ATK_ROLE_ARTICLE
	ATK_ROLE_LANDMARK
	ATK_ROLE_LOG
	ATK_ROLE_MARQUEE
	ATK_ROLE_MATH
	ATK_ROLE_RATING
	ATK_ROLE_TIMER
	ATK_ROLE_DESCRIPTION_LIST
	ATK_ROLE_DESCRIPTION_TERM
	ATK_ROLE_DESCRIPTION_VALUE
	ATK_ROLE_STATIC
	ATK_ROLE_MATH_FRACTION
	ATK_ROLE_MATH_ROOT
	ATK_ROLE_SUBSCRIPT
	ATK_ROLE_SUPERSCRIPT
	ATK_ROLE_LAST_DEFINED
end enum

type AtkLayer as long
enum
	ATK_LAYER_INVALID
	ATK_LAYER_BACKGROUND
	ATK_LAYER_CANVAS
	ATK_LAYER_WIDGET
	ATK_LAYER_MDI
	ATK_LAYER_POPUP
	ATK_LAYER_OVERLAY
	ATK_LAYER_WINDOW
end enum

type AtkAttributeSet as GSList
type AtkAttribute as _AtkAttribute

type _AtkAttribute
	name as gchar ptr
	value as gchar ptr
end type

#define ATK_TYPE_OBJECT atk_object_get_type()
#define ATK_OBJECT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_OBJECT, AtkObject)
#define ATK_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_OBJECT, AtkObjectClass)
#define ATK_IS_OBJECT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_OBJECT)
#define ATK_IS_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_OBJECT)
#define ATK_OBJECT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_OBJECT, AtkObjectClass)
#define ATK_TYPE_IMPLEMENTOR atk_implementor_get_type()
#define ATK_IS_IMPLEMENTOR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_IMPLEMENTOR)
#define ATK_IMPLEMENTOR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_IMPLEMENTOR, AtkImplementor)
#define ATK_IMPLEMENTOR_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_IMPLEMENTOR, AtkImplementorIface)

type AtkImplementor as _AtkImplementor
type AtkImplementorIface as _AtkImplementorIface
type AtkObject as _AtkObject
type AtkObjectClass as _AtkObjectClass
type AtkRelationSet as _AtkRelationSet
type AtkStateSet as _AtkStateSet

type _AtkPropertyValues
	property_name as const gchar ptr
	old_value as GValue
	new_value as GValue
end type

type AtkPropertyValues as _AtkPropertyValues
type AtkFunction as function(byval user_data as gpointer) as gboolean
type AtkPropertyChangeHandler as sub(byval obj as AtkObject ptr, byval vals as AtkPropertyValues ptr)

type _AtkObject
	parent as GObject
	description as gchar ptr
	name as gchar ptr
	accessible_parent as AtkObject ptr
	role as AtkRole
	relation_set as AtkRelationSet ptr
	layer as AtkLayer
end type

type _AtkObjectClass
	parent as GObjectClass
	get_name as function(byval accessible as AtkObject ptr) as const gchar ptr
	get_description as function(byval accessible as AtkObject ptr) as const gchar ptr
	get_parent as function(byval accessible as AtkObject ptr) as AtkObject ptr
	get_n_children as function(byval accessible as AtkObject ptr) as gint
	ref_child as function(byval accessible as AtkObject ptr, byval i as gint) as AtkObject ptr
	get_index_in_parent as function(byval accessible as AtkObject ptr) as gint
	ref_relation_set as function(byval accessible as AtkObject ptr) as AtkRelationSet ptr
	get_role as function(byval accessible as AtkObject ptr) as AtkRole
	get_layer as function(byval accessible as AtkObject ptr) as AtkLayer
	get_mdi_zorder as function(byval accessible as AtkObject ptr) as gint
	ref_state_set as function(byval accessible as AtkObject ptr) as AtkStateSet ptr
	set_name as sub(byval accessible as AtkObject ptr, byval name as const gchar ptr)
	set_description as sub(byval accessible as AtkObject ptr, byval description as const gchar ptr)
	set_parent as sub(byval accessible as AtkObject ptr, byval parent as AtkObject ptr)
	set_role as sub(byval accessible as AtkObject ptr, byval role as AtkRole)
	connect_property_change_handler as function(byval accessible as AtkObject ptr, byval handler as AtkPropertyChangeHandler ptr) as guint
	remove_property_change_handler as sub(byval accessible as AtkObject ptr, byval handler_id as guint)
	initialize as sub(byval accessible as AtkObject ptr, byval data as gpointer)
	children_changed as sub(byval accessible as AtkObject ptr, byval change_index as guint, byval changed_child as gpointer)
	focus_event as sub(byval accessible as AtkObject ptr, byval focus_in as gboolean)
	property_change as sub(byval accessible as AtkObject ptr, byval values as AtkPropertyValues ptr)
	state_change as sub(byval accessible as AtkObject ptr, byval name as const gchar ptr, byval state_set as gboolean)
	visible_data_changed as sub(byval accessible as AtkObject ptr)
	active_descendant_changed as sub(byval accessible as AtkObject ptr, byval child as gpointer ptr)
	get_attributes as function(byval accessible as AtkObject ptr) as AtkAttributeSet ptr
	get_object_locale as function(byval accessible as AtkObject ptr) as const gchar ptr
	pad1 as AtkFunction
end type

declare function atk_object_get_type() as GType

type _AtkImplementorIface
	parent as GTypeInterface
	ref_accessible as function(byval implementor as AtkImplementor ptr) as AtkObject ptr
end type

declare function atk_implementor_get_type() as GType
declare function atk_implementor_ref_accessible(byval implementor as AtkImplementor ptr) as AtkObject ptr
declare function atk_object_get_name(byval accessible as AtkObject ptr) as const gchar ptr
declare function atk_object_get_description(byval accessible as AtkObject ptr) as const gchar ptr
declare function atk_object_get_parent(byval accessible as AtkObject ptr) as AtkObject ptr
declare function atk_object_peek_parent(byval accessible as AtkObject ptr) as AtkObject ptr
declare function atk_object_get_n_accessible_children(byval accessible as AtkObject ptr) as gint
declare function atk_object_ref_accessible_child(byval accessible as AtkObject ptr, byval i as gint) as AtkObject ptr
declare function atk_object_ref_relation_set(byval accessible as AtkObject ptr) as AtkRelationSet ptr
declare function atk_object_get_role(byval accessible as AtkObject ptr) as AtkRole
declare function atk_object_get_layer(byval accessible as AtkObject ptr) as AtkLayer
declare function atk_object_get_mdi_zorder(byval accessible as AtkObject ptr) as gint
declare function atk_object_get_attributes(byval accessible as AtkObject ptr) as AtkAttributeSet ptr
declare function atk_object_ref_state_set(byval accessible as AtkObject ptr) as AtkStateSet ptr
declare function atk_object_get_index_in_parent(byval accessible as AtkObject ptr) as gint
declare sub atk_object_set_name(byval accessible as AtkObject ptr, byval name as const gchar ptr)
declare sub atk_object_set_description(byval accessible as AtkObject ptr, byval description as const gchar ptr)
declare sub atk_object_set_parent(byval accessible as AtkObject ptr, byval parent as AtkObject ptr)
declare sub atk_object_set_role(byval accessible as AtkObject ptr, byval role as AtkRole)
declare function atk_object_connect_property_change_handler(byval accessible as AtkObject ptr, byval handler as AtkPropertyChangeHandler ptr) as guint
declare sub atk_object_remove_property_change_handler(byval accessible as AtkObject ptr, byval handler_id as guint)
declare sub atk_object_notify_state_change(byval accessible as AtkObject ptr, byval state as AtkState, byval value as gboolean)
declare sub atk_object_initialize(byval accessible as AtkObject ptr, byval data as gpointer)
declare function atk_role_get_name(byval role as AtkRole) as const gchar ptr
declare function atk_role_for_name(byval name as const gchar ptr) as AtkRole
declare function atk_object_add_relationship(byval object as AtkObject ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr) as gboolean
declare function atk_object_remove_relationship(byval object as AtkObject ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr) as gboolean
declare function atk_role_get_localized_name(byval role as AtkRole) as const gchar ptr
declare function atk_role_register(byval name as const gchar ptr) as AtkRole
declare function atk_object_get_object_locale(byval accessible as AtkObject ptr) as const gchar ptr

#define __ATK_ACTION_H__
#define ATK_TYPE_ACTION atk_action_get_type()
#define ATK_IS_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_ACTION)
#define ATK_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_ACTION, AtkAction)
#define ATK_ACTION_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_ACTION, AtkActionIface)
#define _TYPEDEF_ATK_ACTION_
type AtkAction as _AtkAction
type AtkActionIface as _AtkActionIface

type _AtkActionIface
	parent as GTypeInterface
	do_action as function(byval action as AtkAction ptr, byval i as gint) as gboolean
	get_n_actions as function(byval action as AtkAction ptr) as gint
	get_description as function(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
	get_name as function(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
	get_keybinding as function(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
	set_description as function(byval action as AtkAction ptr, byval i as gint, byval desc as const gchar ptr) as gboolean
	get_localized_name as function(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
end type

declare function atk_action_get_type() as GType
declare function atk_action_do_action(byval action as AtkAction ptr, byval i as gint) as gboolean
declare function atk_action_get_n_actions(byval action as AtkAction ptr) as gint
declare function atk_action_get_description(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
declare function atk_action_get_name(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
declare function atk_action_get_keybinding(byval action as AtkAction ptr, byval i as gint) as const gchar ptr
declare function atk_action_set_description(byval action as AtkAction ptr, byval i as gint, byval desc as const gchar ptr) as gboolean
declare function atk_action_get_localized_name(byval action as AtkAction ptr, byval i as gint) as const gchar ptr

#define __ATK_COMPONENT_H__
#define __ATK_UTIL_H__
#define ATK_TYPE_UTIL atk_util_get_type()
#define ATK_IS_UTIL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_UTIL)
#define ATK_UTIL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_UTIL, AtkUtil)
#define ATK_UTIL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_UTIL, AtkUtilClass)
#define ATK_IS_UTIL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_UTIL)
#define ATK_UTIL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_UTIL, AtkUtilClass)
#define _TYPEDEF_ATK_UTIL_

type AtkUtil as _AtkUtil
type AtkUtilClass as _AtkUtilClass
type AtkKeyEventStruct as _AtkKeyEventStruct
type AtkEventListener as sub(byval obj as AtkObject ptr)
type AtkEventListenerInit as sub()
type AtkKeySnoopFunc as function(byval event as AtkKeyEventStruct ptr, byval user_data as gpointer) as gint

type _AtkKeyEventStruct
	as gint type
	state as guint
	keyval as guint
	length as gint
	string as gchar ptr
	keycode as guint16
	timestamp as guint32
end type

type AtkKeyEventType as long
enum
	ATK_KEY_EVENT_PRESS
	ATK_KEY_EVENT_RELEASE
	ATK_KEY_EVENT_LAST_DEFINED
end enum

type _AtkUtil
	parent as GObject
end type

type _AtkUtilClass
	parent as GObjectClass
	add_global_event_listener as function(byval listener as GSignalEmissionHook, byval event_type as const gchar ptr) as guint
	remove_global_event_listener as sub(byval listener_id as guint)
	add_key_event_listener as function(byval listener as AtkKeySnoopFunc, byval data as gpointer) as guint
	remove_key_event_listener as sub(byval listener_id as guint)
	get_root as function() as AtkObject ptr
	get_toolkit_name as function() as const gchar ptr
	get_toolkit_version as function() as const gchar ptr
end type

declare function atk_util_get_type() as GType

type AtkCoordType as long
enum
	ATK_XY_SCREEN
	ATK_XY_WINDOW
end enum

declare function atk_add_focus_tracker(byval focus_tracker as AtkEventListener) as guint
declare sub atk_remove_focus_tracker(byval tracker_id as guint)
declare sub atk_focus_tracker_init(byval init as AtkEventListenerInit)
declare sub atk_focus_tracker_notify(byval object as AtkObject ptr)
declare function atk_add_global_event_listener(byval listener as GSignalEmissionHook, byval event_type as const gchar ptr) as guint
declare sub atk_remove_global_event_listener(byval listener_id as guint)
declare function atk_add_key_event_listener(byval listener as AtkKeySnoopFunc, byval data as gpointer) as guint
declare sub atk_remove_key_event_listener(byval listener_id as guint)
declare function atk_get_root() as AtkObject ptr
declare function atk_get_focus_object() as AtkObject ptr
declare function atk_get_toolkit_name() as const gchar ptr
declare function atk_get_toolkit_version() as const gchar ptr
declare function atk_get_version() as const gchar ptr
#define ATK_DEFINE_TYPE(TN, t_n, T_P) ATK_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, 0, )
#macro ATK_DEFINE_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
	_ATK_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, 0)
	scope
		_C_
	end scope
	_ATK_DEFINE_TYPE_EXTENDED_END()
#endmacro
#define ATK_DEFINE_ABSTRACT_TYPE(TN, t_n, T_P) ATK_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, )
#macro ATK_DEFINE_ABSTRACT_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
	_ATK_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT)
	scope
		_C_
	end scope
	_ATK_DEFINE_TYPE_EXTENDED_END()
#endmacro
#macro ATK_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, _f_, _C_)
	_ATK_DEFINE_TYPE_EXTENDED_BEGIN(TN, t_n, T_P, _f_)
	scope
		_C_
	end scope
	_ATK_DEFINE_TYPE_EXTENDED_END()
#endmacro
#macro _ATK_DEFINE_TYPE_EXTENDED_BEGIN(TypeName, type_name, TYPE, flags)
	extern "C"
		declare sub type_name##_init(byval self as TypeName ptr)
		declare sub type_name##_class_init(byval klass as TypeName##Class ptr)
		dim shared as gpointer type_name##_parent_class = NULL
		private sub type_name##_class_intern_init(byval klass as gpointer)
			type_name##_parent_class = g_type_class_peek_parent(klass)
			type_name##_class_init(cptr(TypeName##Class ptr, klass))
		end sub
		function type_name##_get_type() as GType
			static as gsize g_define_type_id__volatile = 0
			if g_once_init_enter(@g_define_type_id__volatile) then
				var derived_type = g_type_parent(TYPE)
				var factory = atk_registry_get_factory(atk_get_default_registry(), derived_type)
				var derived_atk_type = atk_object_factory_get_accessible_type(factory)
				dim as GTypeQuery query
				g_type_query(derived_atk_type, @query)
				var g_define_type_id = g_type_register_static_simple( _
					derived_atk_type, _
					g_intern_static_string(#TypeName), _
					query.class_size, _
					cast(GClassInitFunc, @type_name##_class_intern_init), _
					query.instance_size, _
					cast(GInstanceInitFunc, @type_name##_init), _
					cast(GTypeFlags, flags) _
				)
				scope
#endmacro
#macro _ATK_DEFINE_TYPE_EXTENDED_END()
				end scope
				g_once_init_leave(@g_define_type_id__volatile, g_define_type_id)
			end if
			return g_define_type_id__volatile
		end function
	end extern
#endmacro

#define ATK_TYPE_COMPONENT atk_component_get_type()
#define ATK_IS_COMPONENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_COMPONENT)
#define ATK_COMPONENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_COMPONENT, AtkComponent)
#define ATK_COMPONENT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_COMPONENT, AtkComponentIface)
#define _TYPEDEF_ATK_COMPONENT_

type AtkComponent as _AtkComponent
type AtkComponentIface as _AtkComponentIface
type AtkFocusHandler as sub(byval object as AtkObject ptr, byval focus_in as gboolean)
type AtkRectangle as _AtkRectangle

type _AtkRectangle
	x as gint
	y as gint
	width as gint
	height as gint
end type

declare function atk_rectangle_get_type() as GType
#define ATK_TYPE_RECTANGLE atk_rectangle_get_type()

type _AtkComponentIface
	parent as GTypeInterface
	add_focus_handler as function(byval component as AtkComponent ptr, byval handler as AtkFocusHandler) as guint
	contains as function(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval coord_type as AtkCoordType) as gboolean
	ref_accessible_at_point as function(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval coord_type as AtkCoordType) as AtkObject ptr
	get_extents as sub(byval component as AtkComponent ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval coord_type as AtkCoordType)
	get_position as sub(byval component as AtkComponent ptr, byval x as gint ptr, byval y as gint ptr, byval coord_type as AtkCoordType)
	get_size as sub(byval component as AtkComponent ptr, byval width as gint ptr, byval height as gint ptr)
	grab_focus as function(byval component as AtkComponent ptr) as gboolean
	remove_focus_handler as sub(byval component as AtkComponent ptr, byval handler_id as guint)
	set_extents as function(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval coord_type as AtkCoordType) as gboolean
	set_position as function(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval coord_type as AtkCoordType) as gboolean
	set_size as function(byval component as AtkComponent ptr, byval width as gint, byval height as gint) as gboolean
	get_layer as function(byval component as AtkComponent ptr) as AtkLayer
	get_mdi_zorder as function(byval component as AtkComponent ptr) as gint
	bounds_changed as sub(byval component as AtkComponent ptr, byval bounds as AtkRectangle ptr)
	get_alpha as function(byval component as AtkComponent ptr) as gdouble
end type

declare function atk_component_get_type() as GType
declare function atk_component_add_focus_handler(byval component as AtkComponent ptr, byval handler as AtkFocusHandler) as guint
declare function atk_component_contains(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval coord_type as AtkCoordType) as gboolean
declare function atk_component_ref_accessible_at_point(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval coord_type as AtkCoordType) as AtkObject ptr
declare sub atk_component_get_extents(byval component as AtkComponent ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval coord_type as AtkCoordType)
declare sub atk_component_get_position(byval component as AtkComponent ptr, byval x as gint ptr, byval y as gint ptr, byval coord_type as AtkCoordType)
declare sub atk_component_get_size(byval component as AtkComponent ptr, byval width as gint ptr, byval height as gint ptr)
declare function atk_component_get_layer(byval component as AtkComponent ptr) as AtkLayer
declare function atk_component_get_mdi_zorder(byval component as AtkComponent ptr) as gint
declare function atk_component_grab_focus(byval component as AtkComponent ptr) as gboolean
declare sub atk_component_remove_focus_handler(byval component as AtkComponent ptr, byval handler_id as guint)
declare function atk_component_set_extents(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval coord_type as AtkCoordType) as gboolean
declare function atk_component_set_position(byval component as AtkComponent ptr, byval x as gint, byval y as gint, byval coord_type as AtkCoordType) as gboolean
declare function atk_component_set_size(byval component as AtkComponent ptr, byval width as gint, byval height as gint) as gboolean
declare function atk_component_get_alpha(byval component as AtkComponent ptr) as gdouble

#define __ATK_DOCUMENT_H__
#define ATK_TYPE_DOCUMENT atk_document_get_type()
#define ATK_IS_DOCUMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_DOCUMENT)
#define ATK_DOCUMENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_DOCUMENT, AtkDocument)
#define ATK_DOCUMENT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_DOCUMENT, AtkDocumentIface)
#define _TYPEDEF_ATK_DOCUMENT_
type AtkDocument as _AtkDocument
type AtkDocumentIface as _AtkDocumentIface

type _AtkDocumentIface
	parent as GTypeInterface
	get_document_type as function(byval document as AtkDocument ptr) as const gchar ptr
	get_document as function(byval document as AtkDocument ptr) as gpointer
	get_document_locale as function(byval document as AtkDocument ptr) as const gchar ptr
	get_document_attributes as function(byval document as AtkDocument ptr) as AtkAttributeSet ptr
	get_document_attribute_value as function(byval document as AtkDocument ptr, byval attribute_name as const gchar ptr) as const gchar ptr
	set_document_attribute as function(byval document as AtkDocument ptr, byval attribute_name as const gchar ptr, byval attribute_value as const gchar ptr) as gboolean
	get_current_page_number as function(byval document as AtkDocument ptr) as gint
	get_page_count as function(byval document as AtkDocument ptr) as gint
end type

declare function atk_document_get_type() as GType
declare function atk_document_get_document_type(byval document as AtkDocument ptr) as const gchar ptr
declare function atk_document_get_document(byval document as AtkDocument ptr) as gpointer
declare function atk_document_get_locale(byval document as AtkDocument ptr) as const gchar ptr
declare function atk_document_get_attributes(byval document as AtkDocument ptr) as AtkAttributeSet ptr
declare function atk_document_get_attribute_value(byval document as AtkDocument ptr, byval attribute_name as const gchar ptr) as const gchar ptr
declare function atk_document_set_attribute_value(byval document as AtkDocument ptr, byval attribute_name as const gchar ptr, byval attribute_value as const gchar ptr) as gboolean
declare function atk_document_get_current_page_number(byval document as AtkDocument ptr) as gint
declare function atk_document_get_page_count(byval document as AtkDocument ptr) as gint
#define __ATK_EDITABLE_TEXT_H__
#define __ATK_TEXT_H__

type AtkTextAttribute as long
enum
	ATK_TEXT_ATTR_INVALID = 0
	ATK_TEXT_ATTR_LEFT_MARGIN
	ATK_TEXT_ATTR_RIGHT_MARGIN
	ATK_TEXT_ATTR_INDENT
	ATK_TEXT_ATTR_INVISIBLE
	ATK_TEXT_ATTR_EDITABLE
	ATK_TEXT_ATTR_PIXELS_ABOVE_LINES
	ATK_TEXT_ATTR_PIXELS_BELOW_LINES
	ATK_TEXT_ATTR_PIXELS_INSIDE_WRAP
	ATK_TEXT_ATTR_BG_FULL_HEIGHT
	ATK_TEXT_ATTR_RISE
	ATK_TEXT_ATTR_UNDERLINE
	ATK_TEXT_ATTR_STRIKETHROUGH
	ATK_TEXT_ATTR_SIZE
	ATK_TEXT_ATTR_SCALE
	ATK_TEXT_ATTR_WEIGHT
	ATK_TEXT_ATTR_LANGUAGE
	ATK_TEXT_ATTR_FAMILY_NAME
	ATK_TEXT_ATTR_BG_COLOR
	ATK_TEXT_ATTR_FG_COLOR
	ATK_TEXT_ATTR_BG_STIPPLE
	ATK_TEXT_ATTR_FG_STIPPLE
	ATK_TEXT_ATTR_WRAP_MODE
	ATK_TEXT_ATTR_DIRECTION
	ATK_TEXT_ATTR_JUSTIFICATION
	ATK_TEXT_ATTR_STRETCH
	ATK_TEXT_ATTR_VARIANT
	ATK_TEXT_ATTR_STYLE
	ATK_TEXT_ATTR_LAST_DEFINED
end enum

declare function atk_text_attribute_register(byval name as const gchar ptr) as AtkTextAttribute
#define ATK_TYPE_TEXT atk_text_get_type()
#define ATK_IS_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_TEXT)
#define ATK_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_TEXT, AtkText)
#define ATK_TEXT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_TEXT, AtkTextIface)
#define _TYPEDEF_ATK_TEXT_
type AtkText as _AtkText
type AtkTextIface as _AtkTextIface

type AtkTextBoundary as long
enum
	ATK_TEXT_BOUNDARY_CHAR
	ATK_TEXT_BOUNDARY_WORD_START
	ATK_TEXT_BOUNDARY_WORD_END
	ATK_TEXT_BOUNDARY_SENTENCE_START
	ATK_TEXT_BOUNDARY_SENTENCE_END
	ATK_TEXT_BOUNDARY_LINE_START
	ATK_TEXT_BOUNDARY_LINE_END
end enum

type AtkTextGranularity as long
enum
	ATK_TEXT_GRANULARITY_CHAR
	ATK_TEXT_GRANULARITY_WORD
	ATK_TEXT_GRANULARITY_SENTENCE
	ATK_TEXT_GRANULARITY_LINE
	ATK_TEXT_GRANULARITY_PARAGRAPH
end enum

type AtkTextRectangle as _AtkTextRectangle

type _AtkTextRectangle
	x as gint
	y as gint
	width as gint
	height as gint
end type

type AtkTextRange as _AtkTextRange

type _AtkTextRange
	bounds as AtkTextRectangle
	start_offset as gint
	end_offset as gint
	content as gchar ptr
end type

declare function atk_text_range_get_type() as GType

type AtkTextClipType as long
enum
	ATK_TEXT_CLIP_NONE
	ATK_TEXT_CLIP_MIN
	ATK_TEXT_CLIP_MAX
	ATK_TEXT_CLIP_BOTH
end enum

type _AtkTextIface
	parent as GTypeInterface
	get_text as function(byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint) as gchar ptr
	get_text_after_offset as function(byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
	get_text_at_offset as function(byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
	get_character_at_offset as function(byval text as AtkText ptr, byval offset as gint) as gunichar
	get_text_before_offset as function(byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
	get_caret_offset as function(byval text as AtkText ptr) as gint
	get_run_attributes as function(byval text as AtkText ptr, byval offset as gint, byval start_offset as gint ptr, byval end_offset as gint ptr) as AtkAttributeSet ptr
	get_default_attributes as function(byval text as AtkText ptr) as AtkAttributeSet ptr
	get_character_extents as sub(byval text as AtkText ptr, byval offset as gint, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval coords as AtkCoordType)
	get_character_count as function(byval text as AtkText ptr) as gint
	get_offset_at_point as function(byval text as AtkText ptr, byval x as gint, byval y as gint, byval coords as AtkCoordType) as gint
	get_n_selections as function(byval text as AtkText ptr) as gint
	get_selection as function(byval text as AtkText ptr, byval selection_num as gint, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
	add_selection as function(byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint) as gboolean
	remove_selection as function(byval text as AtkText ptr, byval selection_num as gint) as gboolean
	set_selection as function(byval text as AtkText ptr, byval selection_num as gint, byval start_offset as gint, byval end_offset as gint) as gboolean
	set_caret_offset as function(byval text as AtkText ptr, byval offset as gint) as gboolean
	text_changed as sub(byval text as AtkText ptr, byval position as gint, byval length as gint)
	text_caret_moved as sub(byval text as AtkText ptr, byval location as gint)
	text_selection_changed as sub(byval text as AtkText ptr)
	text_attributes_changed as sub(byval text as AtkText ptr)
	get_range_extents as sub(byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint, byval coord_type as AtkCoordType, byval rect as AtkTextRectangle ptr)
	get_bounded_ranges as function(byval text as AtkText ptr, byval rect as AtkTextRectangle ptr, byval coord_type as AtkCoordType, byval x_clip_type as AtkTextClipType, byval y_clip_type as AtkTextClipType) as AtkTextRange ptr ptr
	get_string_at_offset as function(byval text as AtkText ptr, byval offset as gint, byval granularity as AtkTextGranularity, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
end type

declare function atk_text_get_type() as GType
declare function atk_text_get_text(byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint) as gchar ptr
declare function atk_text_get_character_at_offset(byval text as AtkText ptr, byval offset as gint) as gunichar
declare function atk_text_get_text_after_offset(byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
declare function atk_text_get_text_at_offset(byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
declare function atk_text_get_text_before_offset(byval text as AtkText ptr, byval offset as gint, byval boundary_type as AtkTextBoundary, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
declare function atk_text_get_string_at_offset(byval text as AtkText ptr, byval offset as gint, byval granularity as AtkTextGranularity, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
declare function atk_text_get_caret_offset(byval text as AtkText ptr) as gint
declare sub atk_text_get_character_extents(byval text as AtkText ptr, byval offset as gint, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval coords as AtkCoordType)
declare function atk_text_get_run_attributes(byval text as AtkText ptr, byval offset as gint, byval start_offset as gint ptr, byval end_offset as gint ptr) as AtkAttributeSet ptr
declare function atk_text_get_default_attributes(byval text as AtkText ptr) as AtkAttributeSet ptr
declare function atk_text_get_character_count(byval text as AtkText ptr) as gint
declare function atk_text_get_offset_at_point(byval text as AtkText ptr, byval x as gint, byval y as gint, byval coords as AtkCoordType) as gint
declare function atk_text_get_n_selections(byval text as AtkText ptr) as gint
declare function atk_text_get_selection(byval text as AtkText ptr, byval selection_num as gint, byval start_offset as gint ptr, byval end_offset as gint ptr) as gchar ptr
declare function atk_text_add_selection(byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint) as gboolean
declare function atk_text_remove_selection(byval text as AtkText ptr, byval selection_num as gint) as gboolean
declare function atk_text_set_selection(byval text as AtkText ptr, byval selection_num as gint, byval start_offset as gint, byval end_offset as gint) as gboolean
declare function atk_text_set_caret_offset(byval text as AtkText ptr, byval offset as gint) as gboolean
declare sub atk_text_get_range_extents(byval text as AtkText ptr, byval start_offset as gint, byval end_offset as gint, byval coord_type as AtkCoordType, byval rect as AtkTextRectangle ptr)
declare function atk_text_get_bounded_ranges(byval text as AtkText ptr, byval rect as AtkTextRectangle ptr, byval coord_type as AtkCoordType, byval x_clip_type as AtkTextClipType, byval y_clip_type as AtkTextClipType) as AtkTextRange ptr ptr
declare sub atk_text_free_ranges(byval ranges as AtkTextRange ptr ptr)
declare sub atk_attribute_set_free(byval attrib_set as AtkAttributeSet ptr)
declare function atk_text_attribute_get_name(byval attr as AtkTextAttribute) as const gchar ptr
declare function atk_text_attribute_for_name(byval name as const gchar ptr) as AtkTextAttribute
declare function atk_text_attribute_get_value(byval attr as AtkTextAttribute, byval index_ as gint) as const gchar ptr

#define ATK_TYPE_EDITABLE_TEXT atk_editable_text_get_type()
#define ATK_IS_EDITABLE_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_EDITABLE_TEXT)
#define ATK_EDITABLE_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_EDITABLE_TEXT, AtkEditableText)
#define ATK_EDITABLE_TEXT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_EDITABLE_TEXT, AtkEditableTextIface)
#define _TYPEDEF_ATK_EDITABLE_TEXT_
type AtkEditableText as _AtkEditableText
type AtkEditableTextIface as _AtkEditableTextIface

type _AtkEditableTextIface
	parent_interface as GTypeInterface
	set_run_attributes as function(byval text as AtkEditableText ptr, byval attrib_set as AtkAttributeSet ptr, byval start_offset as gint, byval end_offset as gint) as gboolean
	set_text_contents as sub(byval text as AtkEditableText ptr, byval string as const gchar ptr)
	insert_text as sub(byval text as AtkEditableText ptr, byval string as const gchar ptr, byval length as gint, byval position as gint ptr)
	copy_text as sub(byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
	cut_text as sub(byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
	delete_text as sub(byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
	paste_text as sub(byval text as AtkEditableText ptr, byval position as gint)
end type

declare function atk_editable_text_get_type() as GType
declare function atk_editable_text_set_run_attributes(byval text as AtkEditableText ptr, byval attrib_set as AtkAttributeSet ptr, byval start_offset as gint, byval end_offset as gint) as gboolean
declare sub atk_editable_text_set_text_contents(byval text as AtkEditableText ptr, byval string as const gchar ptr)
declare sub atk_editable_text_insert_text(byval text as AtkEditableText ptr, byval string as const gchar ptr, byval length as gint, byval position as gint ptr)
declare sub atk_editable_text_copy_text(byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
declare sub atk_editable_text_cut_text(byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
declare sub atk_editable_text_delete_text(byval text as AtkEditableText ptr, byval start_pos as gint, byval end_pos as gint)
declare sub atk_editable_text_paste_text(byval text as AtkEditableText ptr, byval position as gint)
#define __ATK_ENUM_TYPES_H__
declare function atk_hyperlink_state_flags_get_type() as GType
#define ATK_TYPE_HYPERLINK_STATE_FLAGS atk_hyperlink_state_flags_get_type()
declare function atk_role_get_type() as GType
#define ATK_TYPE_ROLE atk_role_get_type()
declare function atk_layer_get_type() as GType
#define ATK_TYPE_LAYER atk_layer_get_type()
declare function atk_relation_type_get_type() as GType
#define ATK_TYPE_RELATION_TYPE atk_relation_type_get_type()
declare function atk_state_type_get_type() as GType
#define ATK_TYPE_STATE_TYPE atk_state_type_get_type()
declare function atk_text_attribute_get_type() as GType
#define ATK_TYPE_TEXT_ATTRIBUTE atk_text_attribute_get_type()
declare function atk_text_boundary_get_type() as GType
#define ATK_TYPE_TEXT_BOUNDARY atk_text_boundary_get_type()
declare function atk_text_granularity_get_type() as GType
#define ATK_TYPE_TEXT_GRANULARITY atk_text_granularity_get_type()
declare function atk_text_clip_type_get_type() as GType
#define ATK_TYPE_TEXT_CLIP_TYPE atk_text_clip_type_get_type()
declare function atk_key_event_type_get_type() as GType
#define ATK_TYPE_KEY_EVENT_TYPE atk_key_event_type_get_type()
declare function atk_coord_type_get_type() as GType
#define ATK_TYPE_COORD_TYPE atk_coord_type_get_type()
declare function atk_value_type_get_type() as GType

#define ATK_TYPE_VALUE_TYPE atk_value_type_get_type()
#define __ATK_GOBJECT_ACCESSIBLE_H__
#define ATK_TYPE_GOBJECT_ACCESSIBLE atk_gobject_accessible_get_type()
#define ATK_GOBJECT_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessible)
#define ATK_GOBJECT_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessibleClass)
#define ATK_IS_GOBJECT_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_GOBJECT_ACCESSIBLE)
#define ATK_IS_GOBJECT_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_GOBJECT_ACCESSIBLE)
#define ATK_GOBJECT_ACCESSIBLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessibleClass)
type AtkGObjectAccessible as _AtkGObjectAccessible
type AtkGObjectAccessibleClass as _AtkGObjectAccessibleClass

type _AtkGObjectAccessible
	parent as AtkObject
end type

declare function atk_gobject_accessible_get_type() as GType

type _AtkGObjectAccessibleClass
	parent_class as AtkObjectClass
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_gobject_accessible_for_object(byval obj as GObject ptr) as AtkObject ptr
declare function atk_gobject_accessible_get_object(byval obj as AtkGObjectAccessible ptr) as GObject ptr
#define __ATK_HYPERLINK_H__

type AtkHyperlinkStateFlags as long
enum
	ATK_HYPERLINK_IS_INLINE_ = 1 shl 0
end enum

#define ATK_TYPE_HYPERLINK atk_hyperlink_get_type()
#define ATK_HYPERLINK(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_HYPERLINK, AtkHyperlink)
#define ATK_HYPERLINK_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_HYPERLINK, AtkHyperlinkClass)
#define ATK_IS_HYPERLINK(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_HYPERLINK)
#define ATK_IS_HYPERLINK_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_HYPERLINK)
#define ATK_HYPERLINK_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_HYPERLINK, AtkHyperlinkClass)
type AtkHyperlink as _AtkHyperlink
type AtkHyperlinkClass as _AtkHyperlinkClass

type _AtkHyperlink
	parent as GObject
end type

type _AtkHyperlinkClass
	parent as GObjectClass
	get_uri as function(byval link_ as AtkHyperlink ptr, byval i as gint) as gchar ptr
	get_object as function(byval link_ as AtkHyperlink ptr, byval i as gint) as AtkObject ptr
	get_end_index as function(byval link_ as AtkHyperlink ptr) as gint
	get_start_index as function(byval link_ as AtkHyperlink ptr) as gint
	is_valid as function(byval link_ as AtkHyperlink ptr) as gboolean
	get_n_anchors as function(byval link_ as AtkHyperlink ptr) as gint
	link_state as function(byval link_ as AtkHyperlink ptr) as guint
	is_selected_link as function(byval link_ as AtkHyperlink ptr) as gboolean
	link_activated as sub(byval link_ as AtkHyperlink ptr)
	pad1 as AtkFunction
end type

declare function atk_hyperlink_get_type() as GType
declare function atk_hyperlink_get_uri(byval link_ as AtkHyperlink ptr, byval i as gint) as gchar ptr
declare function atk_hyperlink_get_object(byval link_ as AtkHyperlink ptr, byval i as gint) as AtkObject ptr
declare function atk_hyperlink_get_end_index(byval link_ as AtkHyperlink ptr) as gint
declare function atk_hyperlink_get_start_index(byval link_ as AtkHyperlink ptr) as gint
declare function atk_hyperlink_is_valid(byval link_ as AtkHyperlink ptr) as gboolean
declare function atk_hyperlink_is_inline(byval link_ as AtkHyperlink ptr) as gboolean
declare function atk_hyperlink_get_n_anchors(byval link_ as AtkHyperlink ptr) as gint
declare function atk_hyperlink_is_selected_link(byval link_ as AtkHyperlink ptr) as gboolean

#define __ATK_HYPERLINK_IMPL_H__
#define ATK_TYPE_HYPERLINK_IMPL atk_hyperlink_impl_get_type()
#define ATK_IS_HYPERLINK_IMPL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_HYPERLINK_IMPL)
#define ATK_HYPERLINK_IMPL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_HYPERLINK_IMPL, AtkHyperlinkImpl)
#define ATK_HYPERLINK_IMPL_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_HYPERLINK_IMPL, AtkHyperlinkImplIface)
#define _TYPEDEF_ATK_HYPERLINK_IMPL__
type AtkHyperlinkImpl as _AtkHyperlinkImpl
type AtkHyperlinkImplIface as _AtkHyperlinkImplIface

type _AtkHyperlinkImplIface
	parent as GTypeInterface
	get_hyperlink as function(byval impl as AtkHyperlinkImpl ptr) as AtkHyperlink ptr
end type

declare function atk_hyperlink_impl_get_type() as GType
declare function atk_hyperlink_impl_get_hyperlink(byval impl as AtkHyperlinkImpl ptr) as AtkHyperlink ptr
#define __ATK_HYPERTEXT_H__
#define ATK_TYPE_HYPERTEXT atk_hypertext_get_type()
#define ATK_IS_HYPERTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_HYPERTEXT)
#define ATK_HYPERTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_HYPERTEXT, AtkHypertext)
#define ATK_HYPERTEXT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_HYPERTEXT, AtkHypertextIface)
#define _TYPEDEF_ATK_HYPERTEXT_
type AtkHypertext as _AtkHypertext
type AtkHypertextIface as _AtkHypertextIface

type _AtkHypertextIface
	parent as GTypeInterface
	get_link as function(byval hypertext as AtkHypertext ptr, byval link_index as gint) as AtkHyperlink ptr
	get_n_links as function(byval hypertext as AtkHypertext ptr) as gint
	get_link_index as function(byval hypertext as AtkHypertext ptr, byval char_index as gint) as gint
	link_selected as sub(byval hypertext as AtkHypertext ptr, byval link_index as gint)
end type

declare function atk_hypertext_get_type() as GType
declare function atk_hypertext_get_link(byval hypertext as AtkHypertext ptr, byval link_index as gint) as AtkHyperlink ptr
declare function atk_hypertext_get_n_links(byval hypertext as AtkHypertext ptr) as gint
declare function atk_hypertext_get_link_index(byval hypertext as AtkHypertext ptr, byval char_index as gint) as gint

#define __ATK_IMAGE_H__
#define ATK_TYPE_IMAGE atk_image_get_type()
#define ATK_IS_IMAGE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_IMAGE)
#define ATK_IMAGE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_IMAGE, AtkImage)
#define ATK_IMAGE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_IMAGE, AtkImageIface)
#define _TYPEDEF_ATK_IMAGE_
type AtkImage as _AtkImage
type AtkImageIface as _AtkImageIface

type _AtkImageIface
	parent as GTypeInterface
	get_image_position as sub(byval image as AtkImage ptr, byval x as gint ptr, byval y as gint ptr, byval coord_type as AtkCoordType)
	get_image_description as function(byval image as AtkImage ptr) as const gchar ptr
	get_image_size as sub(byval image as AtkImage ptr, byval width as gint ptr, byval height as gint ptr)
	set_image_description as function(byval image as AtkImage ptr, byval description as const gchar ptr) as gboolean
	get_image_locale as function(byval image as AtkImage ptr) as const gchar ptr
end type

declare function atk_image_get_type() as GType
declare function atk_image_get_image_description(byval image as AtkImage ptr) as const gchar ptr
declare sub atk_image_get_image_size(byval image as AtkImage ptr, byval width as gint ptr, byval height as gint ptr)
declare function atk_image_set_image_description(byval image as AtkImage ptr, byval description as const gchar ptr) as gboolean
declare sub atk_image_get_image_position(byval image as AtkImage ptr, byval x as gint ptr, byval y as gint ptr, byval coord_type as AtkCoordType)
declare function atk_image_get_image_locale(byval image as AtkImage ptr) as const gchar ptr

#define __ATK_NO_OP_OBJECT_H__
#define ATK_TYPE_NO_OP_OBJECT atk_no_op_object_get_type()
#define ATK_NO_OP_OBJECT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObject)
#define ATK_NO_OP_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObjectClass)
#define ATK_IS_NO_OP_OBJECT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_NO_OP_OBJECT)
#define ATK_IS_NO_OP_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_NO_OP_OBJECT)
#define ATK_NO_OP_OBJECT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObjectClass)
type AtkNoOpObject as _AtkNoOpObject
type AtkNoOpObjectClass as _AtkNoOpObjectClass

type _AtkNoOpObject
	parent as AtkObject
end type

declare function atk_no_op_object_get_type() as GType

type _AtkNoOpObjectClass
	parent_class as AtkObjectClass
end type

declare function atk_no_op_object_new(byval obj as GObject ptr) as AtkObject ptr
#define __ATK_NO_OP_OBJECT_FACTORY_H__
#define __ATK_OBJECT_FACTORY_H__
#define ATK_TYPE_OBJECT_FACTORY atk_object_factory_get_type()
#define ATK_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactory)
#define ATK_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactoryClass)
#define ATK_IS_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_OBJECT_FACTORY)
#define ATK_IS_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_OBJECT_FACTORY)
#define ATK_OBJECT_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactoryClass)
type AtkObjectFactory as _AtkObjectFactory
type AtkObjectFactoryClass as _AtkObjectFactoryClass

type _AtkObjectFactory
	parent as GObject
end type

type _AtkObjectFactoryClass
	parent_class as GObjectClass
	create_accessible as function(byval obj as GObject ptr) as AtkObject ptr
	invalidate as sub(byval factory as AtkObjectFactory ptr)
	get_accessible_type as function() as GType
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_object_factory_get_type() as GType
declare function atk_object_factory_create_accessible(byval factory as AtkObjectFactory ptr, byval obj as GObject ptr) as AtkObject ptr
declare sub atk_object_factory_invalidate(byval factory as AtkObjectFactory ptr)
declare function atk_object_factory_get_accessible_type(byval factory as AtkObjectFactory ptr) as GType

#define ATK_TYPE_NO_OP_OBJECT_FACTORY atk_no_op_object_factory_get_type()
#define ATK_NO_OP_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactory)
#define ATK_NO_OP_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactoryClass)
#define ATK_IS_NO_OP_OBJECT_FACTORY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY)
#define ATK_IS_NO_OP_OBJECT_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_NO_OP_OBJECT_FACTORY)
#define ATK_NO_OP_OBJECT_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactoryClass)
type AtkNoOpObjectFactory as _AtkNoOpObjectFactory
type AtkNoOpObjectFactoryClass as _AtkNoOpObjectFactoryClass

type _AtkNoOpObjectFactory
	parent as AtkObjectFactory
end type

type _AtkNoOpObjectFactoryClass
	parent_class as AtkObjectFactoryClass
end type

declare function atk_no_op_object_factory_get_type() as GType
declare function atk_no_op_object_factory_new() as AtkObjectFactory ptr
#define __ATK_PLUG_H__
#define ATK_TYPE_PLUG atk_plug_get_type()
#define ATK_PLUG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_PLUG, AtkPlug)
#define ATK_IS_PLUG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_PLUG)
#define ATK_PLUG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_PLUG, AtkPlugClass)
#define ATK_IS_PLUG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_PLUG)
#define ATK_PLUG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_PLUG, AtkPlugClass)
type AtkPlug as _AtkPlug
type AtkPlugClass as _AtkPlugClass

type _AtkPlug
	parent as AtkObject
end type

declare function atk_plug_get_type() as GType

type _AtkPlugClass
	parent_class as AtkObjectClass
	get_object_id as function(byval obj as AtkPlug ptr) as gchar ptr
end type

declare function atk_plug_new() as AtkObject ptr
declare function atk_plug_get_id(byval plug as AtkPlug ptr) as gchar ptr
#define __ATK_RANGE_H__
#define ATK_TYPE_RANGE atk_range_get_type()
type AtkRange as _AtkRange
declare function atk_range_get_type() as GType
declare function atk_range_copy(byval src as AtkRange ptr) as AtkRange ptr
declare sub atk_range_free(byval range as AtkRange ptr)
declare function atk_range_get_lower_limit(byval range as AtkRange ptr) as gdouble
declare function atk_range_get_upper_limit(byval range as AtkRange ptr) as gdouble
declare function atk_range_get_description(byval range as AtkRange ptr) as const gchar ptr
declare function atk_range_new(byval lower_limit as gdouble, byval upper_limit as gdouble, byval description as const gchar ptr) as AtkRange ptr

#define __ATK_REGISTRY_H__
#define ATK_TYPE_REGISTRY atk_registry_get_type()
#define ATK_REGISTRY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_REGISTRY, AtkRegistry)
#define ATK_REGISTRY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_REGISTRY, AtkRegistryClass)
#define ATK_IS_REGISTRY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_REGISTRY)
#define ATK_IS_REGISTRY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_REGISTRY)
#define ATK_REGISTRY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_REGISTRY, AtkRegistryClass)

type _AtkRegistry
	parent as GObject
	factory_type_registry as GHashTable ptr
	factory_singleton_cache as GHashTable ptr
end type

type _AtkRegistryClass
	parent_class as GObjectClass
end type

type AtkRegistry as _AtkRegistry
type AtkRegistryClass as _AtkRegistryClass
declare function atk_registry_get_type() as GType
declare sub atk_registry_set_factory_type(byval registry as AtkRegistry ptr, byval type as GType, byval factory_type as GType)
declare function atk_registry_get_factory_type(byval registry as AtkRegistry ptr, byval type as GType) as GType
declare function atk_registry_get_factory(byval registry as AtkRegistry ptr, byval type as GType) as AtkObjectFactory ptr
declare function atk_get_default_registry() as AtkRegistry ptr

#define __ATK_RELATION_H__
#define ATK_TYPE_RELATION atk_relation_get_type()
#define ATK_RELATION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_RELATION, AtkRelation)
#define ATK_RELATION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_RELATION, AtkRelationClass)
#define ATK_IS_RELATION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_RELATION)
#define ATK_IS_RELATION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_RELATION)
#define ATK_RELATION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_RELATION, AtkRelationClass)
type AtkRelation as _AtkRelation
type AtkRelationClass as _AtkRelationClass

type _AtkRelation
	parent as GObject
	target as GPtrArray ptr
	relationship as AtkRelationType
end type

type _AtkRelationClass
	parent as GObjectClass
end type

declare function atk_relation_get_type() as GType
declare function atk_relation_type_register(byval name as const gchar ptr) as AtkRelationType
declare function atk_relation_type_get_name(byval type as AtkRelationType) as const gchar ptr
declare function atk_relation_type_for_name(byval name as const gchar ptr) as AtkRelationType
declare function atk_relation_new(byval targets as AtkObject ptr ptr, byval n_targets as gint, byval relationship as AtkRelationType) as AtkRelation ptr
declare function atk_relation_get_relation_type(byval relation as AtkRelation ptr) as AtkRelationType
declare function atk_relation_get_target(byval relation as AtkRelation ptr) as GPtrArray ptr
declare sub atk_relation_add_target(byval relation as AtkRelation ptr, byval target as AtkObject ptr)
declare function atk_relation_remove_target(byval relation as AtkRelation ptr, byval target as AtkObject ptr) as gboolean

#define __ATK_RELATION_SET_H__
#define ATK_TYPE_RELATION_SET atk_relation_set_get_type()
#define ATK_RELATION_SET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_RELATION_SET, AtkRelationSet)
#define ATK_RELATION_SET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_RELATION_SET, AtkRelationSetClass)
#define ATK_IS_RELATION_SET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_RELATION_SET)
#define ATK_IS_RELATION_SET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_RELATION_SET)
#define ATK_RELATION_SET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_RELATION_SET, AtkRelationSetClass)
type AtkRelationSetClass as _AtkRelationSetClass

type _AtkRelationSet
	parent as GObject
	relations as GPtrArray ptr
end type

type _AtkRelationSetClass
	parent as GObjectClass
	pad1 as AtkFunction
	pad2 as AtkFunction
end type

declare function atk_relation_set_get_type() as GType
declare function atk_relation_set_new() as AtkRelationSet ptr
declare function atk_relation_set_contains(byval set as AtkRelationSet ptr, byval relationship as AtkRelationType) as gboolean
declare function atk_relation_set_contains_target(byval set as AtkRelationSet ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr) as gboolean
declare sub atk_relation_set_remove(byval set as AtkRelationSet ptr, byval relation as AtkRelation ptr)
declare sub atk_relation_set_add(byval set as AtkRelationSet ptr, byval relation as AtkRelation ptr)
declare function atk_relation_set_get_n_relations(byval set as AtkRelationSet ptr) as gint
declare function atk_relation_set_get_relation(byval set as AtkRelationSet ptr, byval i as gint) as AtkRelation ptr
declare function atk_relation_set_get_relation_by_type(byval set as AtkRelationSet ptr, byval relationship as AtkRelationType) as AtkRelation ptr
declare sub atk_relation_set_add_relation_by_type(byval set as AtkRelationSet ptr, byval relationship as AtkRelationType, byval target as AtkObject ptr)

#define __ATK_SELECTION_H__
#define ATK_TYPE_SELECTION atk_selection_get_type()
#define ATK_IS_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_SELECTION)
#define ATK_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_SELECTION, AtkSelection)
#define ATK_SELECTION_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_SELECTION, AtkSelectionIface)
#define _TYPEDEF_ATK_SELECTION_
type AtkSelection as _AtkSelection
type AtkSelectionIface as _AtkSelectionIface

type _AtkSelectionIface
	parent as GTypeInterface
	add_selection as function(byval selection as AtkSelection ptr, byval i as gint) as gboolean
	clear_selection as function(byval selection as AtkSelection ptr) as gboolean
	ref_selection as function(byval selection as AtkSelection ptr, byval i as gint) as AtkObject ptr
	get_selection_count as function(byval selection as AtkSelection ptr) as gint
	is_child_selected as function(byval selection as AtkSelection ptr, byval i as gint) as gboolean
	remove_selection as function(byval selection as AtkSelection ptr, byval i as gint) as gboolean
	select_all_selection as function(byval selection as AtkSelection ptr) as gboolean
	selection_changed as sub(byval selection as AtkSelection ptr)
end type

declare function atk_selection_get_type() as GType
declare function atk_selection_add_selection(byval selection as AtkSelection ptr, byval i as gint) as gboolean
declare function atk_selection_clear_selection(byval selection as AtkSelection ptr) as gboolean
declare function atk_selection_ref_selection(byval selection as AtkSelection ptr, byval i as gint) as AtkObject ptr
declare function atk_selection_get_selection_count(byval selection as AtkSelection ptr) as gint
declare function atk_selection_is_child_selected(byval selection as AtkSelection ptr, byval i as gint) as gboolean
declare function atk_selection_remove_selection(byval selection as AtkSelection ptr, byval i as gint) as gboolean
declare function atk_selection_select_all_selection(byval selection as AtkSelection ptr) as gboolean

#define __ATK_SOCKET_H__
#define ATK_TYPE_SOCKET atk_socket_get_type()
#define ATK_SOCKET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_SOCKET, AtkSocket)
#define ATK_IS_SOCKET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_SOCKET)
#define ATK_SOCKET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_SOCKET, AtkSocketClass)
#define ATK_IS_SOCKET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_SOCKET)
#define ATK_SOCKET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_SOCKET, AtkSocketClass)
type AtkSocket as _AtkSocket
type AtkSocketClass as _AtkSocketClass

type _AtkSocket
	parent as AtkObject
	embedded_plug_id as gchar ptr
end type

declare function atk_socket_get_type() as GType

type _AtkSocketClass
	parent_class as AtkObjectClass
	embed as sub(byval obj as AtkSocket ptr, byval plug_id as gchar ptr)
end type

declare function atk_socket_new() as AtkObject ptr
declare sub atk_socket_embed(byval obj as AtkSocket ptr, byval plug_id as gchar ptr)
declare function atk_socket_is_occupied(byval obj as AtkSocket ptr) as gboolean

#define __ATK_STATE_SET_H__
#define ATK_TYPE_STATE_SET atk_state_set_get_type()
#define ATK_STATE_SET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_STATE_SET, AtkStateSet)
#define ATK_STATE_SET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_STATE_SET, AtkStateSetClass)
#define ATK_IS_STATE_SET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_STATE_SET)
#define ATK_IS_STATE_SET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_STATE_SET)
#define ATK_STATE_SET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_STATE_SET, AtkStateSetClass)
type AtkStateSetClass as _AtkStateSetClass

type _AtkStateSet
	parent as GObject
end type

type _AtkStateSetClass
	parent as GObjectClass
end type

declare function atk_state_set_get_type() as GType
declare function atk_state_set_new() as AtkStateSet ptr
declare function atk_state_set_is_empty(byval set as AtkStateSet ptr) as gboolean
declare function atk_state_set_add_state(byval set as AtkStateSet ptr, byval type as AtkStateType) as gboolean
declare sub atk_state_set_add_states(byval set as AtkStateSet ptr, byval types as AtkStateType ptr, byval n_types as gint)
declare sub atk_state_set_clear_states(byval set as AtkStateSet ptr)
declare function atk_state_set_contains_state(byval set as AtkStateSet ptr, byval type as AtkStateType) as gboolean
declare function atk_state_set_contains_states(byval set as AtkStateSet ptr, byval types as AtkStateType ptr, byval n_types as gint) as gboolean
declare function atk_state_set_remove_state(byval set as AtkStateSet ptr, byval type as AtkStateType) as gboolean
declare function atk_state_set_and_sets(byval set as AtkStateSet ptr, byval compare_set as AtkStateSet ptr) as AtkStateSet ptr
declare function atk_state_set_or_sets(byval set as AtkStateSet ptr, byval compare_set as AtkStateSet ptr) as AtkStateSet ptr
declare function atk_state_set_xor_sets(byval set as AtkStateSet ptr, byval compare_set as AtkStateSet ptr) as AtkStateSet ptr

#define __ATK_STREAMABLE_CONTENT_H__
#define ATK_TYPE_STREAMABLE_CONTENT atk_streamable_content_get_type()
#define ATK_IS_STREAMABLE_CONTENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_STREAMABLE_CONTENT)
#define ATK_STREAMABLE_CONTENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_STREAMABLE_CONTENT, AtkStreamableContent)
#define ATK_STREAMABLE_CONTENT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_STREAMABLE_CONTENT, AtkStreamableContentIface)
#define _TYPEDEF_ATK_STREAMABLE_CONTENT
type AtkStreamableContent as _AtkStreamableContent
type AtkStreamableContentIface as _AtkStreamableContentIface

type _AtkStreamableContentIface
	parent as GTypeInterface
	get_n_mime_types as function(byval streamable as AtkStreamableContent ptr) as gint
	get_mime_type as function(byval streamable as AtkStreamableContent ptr, byval i as gint) as const gchar ptr
	get_stream as function(byval streamable as AtkStreamableContent ptr, byval mime_type as const gchar ptr) as GIOChannel ptr
	get_uri as function(byval streamable as AtkStreamableContent ptr, byval mime_type as const gchar ptr) as const gchar ptr
	pad1 as AtkFunction
	pad2 as AtkFunction
	pad3 as AtkFunction
end type

declare function atk_streamable_content_get_type() as GType
declare function atk_streamable_content_get_n_mime_types(byval streamable as AtkStreamableContent ptr) as gint
declare function atk_streamable_content_get_mime_type(byval streamable as AtkStreamableContent ptr, byval i as gint) as const gchar ptr
declare function atk_streamable_content_get_stream(byval streamable as AtkStreamableContent ptr, byval mime_type as const gchar ptr) as GIOChannel ptr
declare function atk_streamable_content_get_uri(byval streamable as AtkStreamableContent ptr, byval mime_type as const gchar ptr) as const gchar ptr

#define __ATK_TABLE_H__
#define ATK_TYPE_TABLE atk_table_get_type()
#define ATK_IS_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_TABLE)
#define ATK_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_TABLE, AtkTable)
#define ATK_TABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_TABLE, AtkTableIface)
#define _TYPEDEF_ATK_TABLE_
type AtkTable as _AtkTable
type AtkTableIface as _AtkTableIface

type _AtkTableIface
	parent as GTypeInterface
	ref_at as function(byval table as AtkTable ptr, byval row as gint, byval column as gint) as AtkObject ptr
	get_index_at as function(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
	get_column_at_index as function(byval table as AtkTable ptr, byval index_ as gint) as gint
	get_row_at_index as function(byval table as AtkTable ptr, byval index_ as gint) as gint
	get_n_columns as function(byval table as AtkTable ptr) as gint
	get_n_rows as function(byval table as AtkTable ptr) as gint
	get_column_extent_at as function(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
	get_row_extent_at as function(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
	get_caption as function(byval table as AtkTable ptr) as AtkObject ptr
	get_column_description as function(byval table as AtkTable ptr, byval column as gint) as const gchar ptr
	get_column_header as function(byval table as AtkTable ptr, byval column as gint) as AtkObject ptr
	get_row_description as function(byval table as AtkTable ptr, byval row as gint) as const gchar ptr
	get_row_header as function(byval table as AtkTable ptr, byval row as gint) as AtkObject ptr
	get_summary as function(byval table as AtkTable ptr) as AtkObject ptr
	set_caption as sub(byval table as AtkTable ptr, byval caption as AtkObject ptr)
	set_column_description as sub(byval table as AtkTable ptr, byval column as gint, byval description as const gchar ptr)
	set_column_header as sub(byval table as AtkTable ptr, byval column as gint, byval header as AtkObject ptr)
	set_row_description as sub(byval table as AtkTable ptr, byval row as gint, byval description as const gchar ptr)
	set_row_header as sub(byval table as AtkTable ptr, byval row as gint, byval header as AtkObject ptr)
	set_summary as sub(byval table as AtkTable ptr, byval accessible as AtkObject ptr)
	get_selected_columns as function(byval table as AtkTable ptr, byval selected as gint ptr ptr) as gint
	get_selected_rows as function(byval table as AtkTable ptr, byval selected as gint ptr ptr) as gint
	is_column_selected as function(byval table as AtkTable ptr, byval column as gint) as gboolean
	is_row_selected as function(byval table as AtkTable ptr, byval row as gint) as gboolean
	is_selected as function(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gboolean
	add_row_selection as function(byval table as AtkTable ptr, byval row as gint) as gboolean
	remove_row_selection as function(byval table as AtkTable ptr, byval row as gint) as gboolean
	add_column_selection as function(byval table as AtkTable ptr, byval column as gint) as gboolean
	remove_column_selection as function(byval table as AtkTable ptr, byval column as gint) as gboolean
	row_inserted as sub(byval table as AtkTable ptr, byval row as gint, byval num_inserted as gint)
	column_inserted as sub(byval table as AtkTable ptr, byval column as gint, byval num_inserted as gint)
	row_deleted as sub(byval table as AtkTable ptr, byval row as gint, byval num_deleted as gint)
	column_deleted as sub(byval table as AtkTable ptr, byval column as gint, byval num_deleted as gint)
	row_reordered as sub(byval table as AtkTable ptr)
	column_reordered as sub(byval table as AtkTable ptr)
	model_changed as sub(byval table as AtkTable ptr)
end type

declare function atk_table_get_type() as GType
declare function atk_table_ref_at(byval table as AtkTable ptr, byval row as gint, byval column as gint) as AtkObject ptr
declare function atk_table_get_index_at(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
declare function atk_table_get_column_at_index(byval table as AtkTable ptr, byval index_ as gint) as gint
declare function atk_table_get_row_at_index(byval table as AtkTable ptr, byval index_ as gint) as gint
declare function atk_table_get_n_columns(byval table as AtkTable ptr) as gint
declare function atk_table_get_n_rows(byval table as AtkTable ptr) as gint
declare function atk_table_get_column_extent_at(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
declare function atk_table_get_row_extent_at(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gint
declare function atk_table_get_caption(byval table as AtkTable ptr) as AtkObject ptr
declare function atk_table_get_column_description(byval table as AtkTable ptr, byval column as gint) as const gchar ptr
declare function atk_table_get_column_header(byval table as AtkTable ptr, byval column as gint) as AtkObject ptr
declare function atk_table_get_row_description(byval table as AtkTable ptr, byval row as gint) as const gchar ptr
declare function atk_table_get_row_header(byval table as AtkTable ptr, byval row as gint) as AtkObject ptr
declare function atk_table_get_summary(byval table as AtkTable ptr) as AtkObject ptr
declare sub atk_table_set_caption(byval table as AtkTable ptr, byval caption as AtkObject ptr)
declare sub atk_table_set_column_description(byval table as AtkTable ptr, byval column as gint, byval description as const gchar ptr)
declare sub atk_table_set_column_header(byval table as AtkTable ptr, byval column as gint, byval header as AtkObject ptr)
declare sub atk_table_set_row_description(byval table as AtkTable ptr, byval row as gint, byval description as const gchar ptr)
declare sub atk_table_set_row_header(byval table as AtkTable ptr, byval row as gint, byval header as AtkObject ptr)
declare sub atk_table_set_summary(byval table as AtkTable ptr, byval accessible as AtkObject ptr)
declare function atk_table_get_selected_columns(byval table as AtkTable ptr, byval selected as gint ptr ptr) as gint
declare function atk_table_get_selected_rows(byval table as AtkTable ptr, byval selected as gint ptr ptr) as gint
declare function atk_table_is_column_selected(byval table as AtkTable ptr, byval column as gint) as gboolean
declare function atk_table_is_row_selected(byval table as AtkTable ptr, byval row as gint) as gboolean
declare function atk_table_is_selected(byval table as AtkTable ptr, byval row as gint, byval column as gint) as gboolean
declare function atk_table_add_row_selection(byval table as AtkTable ptr, byval row as gint) as gboolean
declare function atk_table_remove_row_selection(byval table as AtkTable ptr, byval row as gint) as gboolean
declare function atk_table_add_column_selection(byval table as AtkTable ptr, byval column as gint) as gboolean
declare function atk_table_remove_column_selection(byval table as AtkTable ptr, byval column as gint) as gboolean

#define __ATK_TABLE_CELL_H__
#define ATK_TYPE_TABLE_CELL atk_table_cell_get_type()
#define ATK_IS_TABLE_CELL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_TABLE_CELL)
#define ATK_TABLE_CELL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_TABLE_CELL, AtkTableCell)
#define ATK_TABLE_CELL_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_TABLE_CELL, AtkTableCellIface)
#define _TYPEDEF_ATK_TABLE_CELL_
type AtkTableCell as _AtkTableCell
type AtkTableCellIface as _AtkTableCellIface

type _AtkTableCellIface
	parent as GTypeInterface
	get_column_span as function(byval cell as AtkTableCell ptr) as gint
	get_column_header_cells as function(byval cell as AtkTableCell ptr) as GPtrArray ptr
	get_position as function(byval cell as AtkTableCell ptr, byval row as gint ptr, byval column as gint ptr) as gboolean
	get_row_span as function(byval cell as AtkTableCell ptr) as gint
	get_row_header_cells as function(byval cell as AtkTableCell ptr) as GPtrArray ptr
	get_row_column_span as function(byval cell as AtkTableCell ptr, byval row as gint ptr, byval column as gint ptr, byval row_span as gint ptr, byval column_span as gint ptr) as gboolean
	get_table as function(byval cell as AtkTableCell ptr) as AtkObject ptr
end type

declare function atk_table_cell_get_type() as GType
declare function atk_table_cell_get_column_span(byval cell as AtkTableCell ptr) as gint
declare function atk_table_cell_get_column_header_cells(byval cell as AtkTableCell ptr) as GPtrArray ptr
declare function atk_table_cell_get_position(byval cell as AtkTableCell ptr, byval row as gint ptr, byval column as gint ptr) as gboolean
declare function atk_table_cell_get_row_span(byval cell as AtkTableCell ptr) as gint
declare function atk_table_cell_get_row_header_cells(byval cell as AtkTableCell ptr) as GPtrArray ptr
declare function atk_table_cell_get_row_column_span(byval cell as AtkTableCell ptr, byval row as gint ptr, byval column as gint ptr, byval row_span as gint ptr, byval column_span as gint ptr) as gboolean
declare function atk_table_cell_get_table(byval cell as AtkTableCell ptr) as AtkObject ptr

#define __ATK_MISC_H__
#define ATK_TYPE_MISC atk_misc_get_type()
#define ATK_IS_MISC(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_MISC)
#define ATK_MISC(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_MISC, AtkMisc)
#define ATK_MISC_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), ATK_TYPE_MISC, AtkMiscClass)
#define ATK_IS_MISC_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), ATK_TYPE_MISC)
#define ATK_MISC_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), ATK_TYPE_MISC, AtkMiscClass)
#define _TYPEDEF_ATK_MISC_
type AtkMisc as _AtkMisc
type AtkMiscClass as _AtkMiscClass

type _AtkMisc
	parent as GObject
end type

#if (defined(__FB_WIN32__) and (not defined(ATK_STATIC_COMPILATION))) or defined(__FB_CYGWIN__)
	extern import atk_misc_instance as AtkMisc ptr
#else
	extern atk_misc_instance as AtkMisc ptr
#endif

type _AtkMiscClass
	parent as GObjectClass
	threads_enter as sub(byval misc as AtkMisc ptr)
	threads_leave as sub(byval misc as AtkMisc ptr)
	vfuncs(0 to 31) as gpointer
end type

declare function atk_misc_get_type() as GType
declare sub atk_misc_threads_enter(byval misc as AtkMisc ptr)
declare sub atk_misc_threads_leave(byval misc as AtkMisc ptr)
declare function atk_misc_get_instance() as const AtkMisc ptr

#define __ATK_VALUE_H__
#define ATK_TYPE_VALUE atk_value_get_type()
#define ATK_IS_VALUE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_VALUE)
#define ATK_VALUE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_VALUE, AtkValue)
#define ATK_VALUE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_VALUE, AtkValueIface)
#define _TYPEDEF_ATK_VALUE__
type AtkValue as _AtkValue
type AtkValueIface as _AtkValueIface

type AtkValueType as long
enum
	ATK_VALUE_VERY_WEAK
	ATK_VALUE_WEAK
	ATK_VALUE_ACCEPTABLE
	ATK_VALUE_STRONG
	ATK_VALUE_VERY_STRONG
	ATK_VALUE_VERY_LOW
	ATK_VALUE_LOW
	ATK_VALUE_MEDIUM
	ATK_VALUE_HIGH
	ATK_VALUE_VERY_HIGH
	ATK_VALUE_VERY_BAD
	ATK_VALUE_BAD
	ATK_VALUE_GOOD
	ATK_VALUE_VERY_GOOD
	ATK_VALUE_BEST
	ATK_VALUE_LAST_DEFINED
end enum

type _AtkValueIface
	parent as GTypeInterface
	get_current_value as sub(byval obj as AtkValue ptr, byval value as GValue ptr)
	get_maximum_value as sub(byval obj as AtkValue ptr, byval value as GValue ptr)
	get_minimum_value as sub(byval obj as AtkValue ptr, byval value as GValue ptr)
	set_current_value as function(byval obj as AtkValue ptr, byval value as const GValue ptr) as gboolean
	get_minimum_increment as sub(byval obj as AtkValue ptr, byval value as GValue ptr)
	get_value_and_text as sub(byval obj as AtkValue ptr, byval value as gdouble ptr, byval text as gchar ptr ptr)
	get_range as function(byval obj as AtkValue ptr) as AtkRange ptr
	get_increment as function(byval obj as AtkValue ptr) as gdouble
	get_sub_ranges as function(byval obj as AtkValue ptr) as GSList ptr
	set_value as sub(byval obj as AtkValue ptr, byval new_value as const gdouble)
end type

declare function atk_value_get_type() as GType
declare sub atk_value_get_current_value(byval obj as AtkValue ptr, byval value as GValue ptr)
declare sub atk_value_get_maximum_value(byval obj as AtkValue ptr, byval value as GValue ptr)
declare sub atk_value_get_minimum_value(byval obj as AtkValue ptr, byval value as GValue ptr)
declare function atk_value_set_current_value(byval obj as AtkValue ptr, byval value as const GValue ptr) as gboolean
declare sub atk_value_get_minimum_increment(byval obj as AtkValue ptr, byval value as GValue ptr)
declare sub atk_value_get_value_and_text(byval obj as AtkValue ptr, byval value as gdouble ptr, byval text as gchar ptr ptr)
declare function atk_value_get_range(byval obj as AtkValue ptr) as AtkRange ptr
declare function atk_value_get_increment(byval obj as AtkValue ptr) as gdouble
declare function atk_value_get_sub_ranges(byval obj as AtkValue ptr) as GSList ptr
declare sub atk_value_set_value(byval obj as AtkValue ptr, byval new_value as const gdouble)
declare function atk_value_type_get_name(byval value_type as AtkValueType) as const gchar ptr
declare function atk_value_type_get_localized_name(byval value_type as AtkValueType) as const gchar ptr

#define __ATK_WINDOW_H__
#define ATK_TYPE_WINDOW atk_window_get_type()
#define ATK_IS_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), ATK_TYPE_WINDOW)
#define ATK_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), ATK_TYPE_WINDOW, AtkWindow)
#define ATK_WINDOW_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), ATK_TYPE_WINDOW, AtkWindowIface)
type AtkWindow as _AtkWindow
type AtkWindowIface as _AtkWindowIface

type _AtkWindowIface
	parent as GTypeInterface
end type

declare function atk_window_get_type() as GType
#undef __ATK_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
