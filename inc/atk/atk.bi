' This is file atk.bi
' (FreeBasic binding for ATK libray - version 2.4.0)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
'
' This library binding is free software; you can redistribute it
' and/or modify it under the terms of the GNU Lesser General Public
' License as published by the Free Software Foundation; either
' version 2 of the License, or (at your option) ANY later version.
'
' This binding is distributed in the hope that it will be useful,
' but WITHOUT ANY WARRANTY; without even the implied warranty of
' MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
' Lesser General Public License for more details, refer to:
' http://www.gnu.org/licenses/lgpl.html
'
'
' Original license text:
'
'/* ATK -  Accessibility Toolkit
 '* Copyright 2001 Sun Microsystems Inc.
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Library General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 '* Library General Public License for more details.
 '*
 '* You should have received a copy of the GNU Library General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

#IFDEF __FB_WIN32__
#PRAGMA push(msbitfields)
#ENDIF

#INCLIB "atk-1.0"

#INCLUDE ONCE "glib.bi"

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF __ATK_H__
#DEFINE __ATK_H__
#DEFINE __ATK_H_INSIDE__

#IFNDEF __ATK_OBJECT_H__
#DEFINE __ATK_OBJECT_H__
#INCLUDE ONCE "glib-object.bi" '__HEADERS__: glib-object.h

#IFNDEF __ATK_STATE_H__
#DEFINE __ATK_STATE_H__

ENUM AtkStateType
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
  ATK_STATE_LAST_DEFINED
END ENUM

TYPE AtkState AS guint64

DECLARE FUNCTION atk_state_type_register(BYVAL AS CONST gchar PTR) AS AtkStateType
DECLARE FUNCTION atk_state_type_get_name(BYVAL AS AtkStateType) AS CONST gchar PTR
DECLARE FUNCTION atk_state_type_for_name(BYVAL AS CONST gchar PTR) AS AtkStateType

#ENDIF ' __ATK_STATE_H__

#IFNDEF __ATK_RELATION_TYPE_H__
#DEFINE __ATK_RELATION_TYPE_H__
#INCLUDE ONCE "glib.bi" '__HEADERS__: glib.h

ENUM AtkRelationType
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
END ENUM

#ENDIF ' __ATK_RELATION_TYPE_H__

ENUM AtkRole
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
  ATK_ROLE_LAST_DEFINED
END ENUM

DECLARE FUNCTION atk_role_register(BYVAL AS CONST gchar PTR) AS AtkRole

ENUM AtkLayer
  ATK_LAYER_INVALID
  ATK_LAYER_BACKGROUND
  ATK_LAYER_CANVAS
  ATK_LAYER_WIDGET
  ATK_LAYER_MDI
  ATK_LAYER_POPUP
  ATK_LAYER_OVERLAY
  ATK_LAYER_WINDOW
END ENUM

TYPE AtkAttributeSet AS GSList
TYPE AtkAttribute AS _AtkAttribute

TYPE _AtkAttribute
  AS gchar PTR name
  AS gchar PTR value
END TYPE

#DEFINE ATK_TYPE_OBJECT (atk_object_get_type ())
#DEFINE ATK_OBJECT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_OBJECT, AtkObject))
#DEFINE ATK_OBJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_OBJECT, AtkObjectClass))
#DEFINE ATK_IS_OBJECT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_OBJECT))
#DEFINE ATK_IS_OBJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_OBJECT))
#DEFINE ATK_OBJECT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_OBJECT, AtkObjectClass))
#DEFINE ATK_TYPE_IMPLEMENTOR (atk_implementor_get_type ())
#DEFINE ATK_IS_IMPLEMENTOR(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_IMPLEMENTOR)
#DEFINE ATK_IMPLEMENTOR(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_IMPLEMENTOR, AtkImplementor)
#DEFINE ATK_IMPLEMENTOR_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_IMPLEMENTOR, AtkImplementorIface))

TYPE AtkImplementor AS _AtkImplementor
TYPE AtkImplementorIface AS _AtkImplementorIface
TYPE AtkObject AS _AtkObject
TYPE AtkObjectClass AS _AtkObjectClass
TYPE AtkRelationSet AS _AtkRelationSet
TYPE AtkStateSet AS _AtkStateSet

TYPE _AtkPropertyValues
  AS CONST gchar PTR property_name
  AS GValue old_value
  AS GValue new_value
END TYPE

TYPE AtkPropertyValues AS _AtkPropertyValues
TYPE AtkFunction AS FUNCTION(BYVAL AS gpointer) AS gboolean
TYPE AtkPropertyChangeHandler AS SUB(BYVAL AS AtkObject PTR, BYVAL AS AtkPropertyValues PTR)

TYPE _AtkObject
  AS GObject parent
  AS gchar PTR description
  AS gchar PTR name
  AS AtkObject PTR accessible_parent
  AS AtkRole role
  AS AtkRelationSet PTR relation_set
  AS AtkLayer layer
END TYPE

TYPE _AtkObjectClass
  AS GObjectClass parent
  get_name AS FUNCTION(BYVAL AS AtkObject PTR) AS CONST gchar PTR
  get_description AS FUNCTION(BYVAL AS AtkObject PTR) AS CONST gchar PTR
  get_parent AS FUNCTION(BYVAL AS AtkObject PTR) AS AtkObject PTR
  get_n_children AS FUNCTION(BYVAL AS AtkObject PTR) AS gint
  ref_child AS FUNCTION(BYVAL AS AtkObject PTR, BYVAL AS gint) AS AtkObject PTR
  get_index_in_parent AS FUNCTION(BYVAL AS AtkObject PTR) AS gint
  ref_relation_set AS FUNCTION(BYVAL AS AtkObject PTR) AS AtkRelationSet PTR
  get_role AS FUNCTION(BYVAL AS AtkObject PTR) AS AtkRole
  get_layer AS FUNCTION(BYVAL AS AtkObject PTR) AS AtkLayer
  get_mdi_zorder AS FUNCTION(BYVAL AS AtkObject PTR) AS gint
  ref_state_set AS FUNCTION(BYVAL AS AtkObject PTR) AS AtkStateSet PTR
  set_name AS SUB(BYVAL AS AtkObject PTR, BYVAL AS CONST gchar PTR)
  set_description AS SUB(BYVAL AS AtkObject PTR, BYVAL AS CONST gchar PTR)
  set_parent AS SUB(BYVAL AS AtkObject PTR, BYVAL AS AtkObject PTR)
  set_role AS SUB(BYVAL AS AtkObject PTR, BYVAL AS AtkRole)
  connect_property_change_handler AS FUNCTION(BYVAL AS AtkObject PTR, BYVAL AS AtkPropertyChangeHandler) AS guint
  remove_property_change_handler AS SUB(BYVAL AS AtkObject PTR, BYVAL AS guint)
  initialize AS SUB(BYVAL AS AtkObject PTR, BYVAL AS gpointer)
  children_changed AS SUB(BYVAL AS AtkObject PTR, BYVAL AS guint, BYVAL AS gpointer)
  focus_event AS SUB(BYVAL AS AtkObject PTR, BYVAL AS gboolean)
  property_change AS SUB(BYVAL AS AtkObject PTR, BYVAL AS AtkPropertyValues PTR)
  state_change AS SUB(BYVAL AS AtkObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
  visible_data_changed AS SUB(BYVAL AS AtkObject PTR)
  active_descendant_changed AS SUB(BYVAL AS AtkObject PTR, BYVAL AS gpointer PTR)
  get_attributes AS FUNCTION(BYVAL AS AtkObject PTR) AS AtkAttributeSet PTR
  AS AtkFunction pad1
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_object_get_type() AS GType

TYPE _AtkImplementorIface
  AS GTypeInterface parent
  ref_accessible AS FUNCTION(BYVAL AS AtkImplementor PTR) AS AtkObject PTR
END TYPE

DECLARE FUNCTION atk_implementor_get_type() AS GType
DECLARE FUNCTION atk_implementor_ref_accessible(BYVAL AS AtkImplementor PTR) AS AtkObject PTR
DECLARE FUNCTION atk_object_get_name(BYVAL AS AtkObject PTR) AS CONST gchar PTR
DECLARE FUNCTION atk_object_get_description(BYVAL AS AtkObject PTR) AS CONST gchar PTR
DECLARE FUNCTION atk_object_get_parent(BYVAL AS AtkObject PTR) AS AtkObject PTR
DECLARE FUNCTION atk_object_get_n_accessible_children(BYVAL AS AtkObject PTR) AS gint
DECLARE FUNCTION atk_object_ref_accessible_child(BYVAL AS AtkObject PTR, BYVAL AS gint) AS AtkObject PTR
DECLARE FUNCTION atk_object_ref_relation_set(BYVAL AS AtkObject PTR) AS AtkRelationSet PTR
DECLARE FUNCTION atk_object_get_role(BYVAL AS AtkObject PTR) AS AtkRole

#IFNDEF ATK_DISABLE_DEPRECATED

DECLARE FUNCTION atk_object_get_layer(BYVAL AS AtkObject PTR) AS AtkLayer
DECLARE FUNCTION atk_object_get_mdi_zorder(BYVAL AS AtkObject PTR) AS gint

#ENDIF ' ATK_DISABLE_DEPRECATED

DECLARE FUNCTION atk_object_get_attributes(BYVAL AS AtkObject PTR) AS AtkAttributeSet PTR
DECLARE FUNCTION atk_object_ref_state_set(BYVAL AS AtkObject PTR) AS AtkStateSet PTR
DECLARE FUNCTION atk_object_get_index_in_parent(BYVAL AS AtkObject PTR) AS gint
DECLARE SUB atk_object_set_name(BYVAL AS AtkObject PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB atk_object_set_description(BYVAL AS AtkObject PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB atk_object_set_parent(BYVAL AS AtkObject PTR, BYVAL AS AtkObject PTR)
DECLARE SUB atk_object_set_role(BYVAL AS AtkObject PTR, BYVAL AS AtkRole)
DECLARE FUNCTION atk_object_connect_property_change_handler(BYVAL AS AtkObject PTR, BYVAL AS AtkPropertyChangeHandler) AS guint
DECLARE SUB atk_object_remove_property_change_handler(BYVAL AS AtkObject PTR, BYVAL AS guint)
DECLARE SUB atk_object_notify_state_change(BYVAL AS AtkObject PTR, BYVAL AS AtkState, BYVAL AS gboolean)
DECLARE SUB atk_object_initialize(BYVAL AS AtkObject PTR, BYVAL AS gpointer)
DECLARE FUNCTION atk_role_get_name(BYVAL AS AtkRole) AS CONST gchar PTR
DECLARE FUNCTION atk_role_for_name(BYVAL AS CONST gchar PTR) AS AtkRole
DECLARE FUNCTION atk_object_add_relationship(BYVAL AS AtkObject PTR, BYVAL AS AtkRelationType, BYVAL AS AtkObject PTR) AS gboolean
DECLARE FUNCTION atk_object_remove_relationship(BYVAL AS AtkObject PTR, BYVAL AS AtkRelationType, BYVAL AS AtkObject PTR) AS gboolean
DECLARE FUNCTION atk_role_get_localized_name(BYVAL AS AtkRole) AS CONST gchar PTR

#ENDIF ' __ATK_OBJECT_H__

#IFNDEF __ATK_ACTION_H__
#DEFINE __ATK_ACTION_H__

#DEFINE ATK_TYPE_ACTION (atk_action_get_type ())
#DEFINE ATK_IS_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_ACTION)
#DEFINE ATK_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_ACTION, AtkAction)
#DEFINE ATK_ACTION_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_ACTION, AtkActionIface))

#IFNDEF _TYPEDEF_ATK_ACTION_
#DEFINE _TYPEDEF_ATK_ACTION_

TYPE AtkAction AS _AtkAction

#ENDIF ' _TYPEDEF_ATK_ACTION_

TYPE AtkActionIface AS _AtkActionIface

TYPE _AtkActionIface
  AS GTypeInterface parent
  do_action AS FUNCTION(BYVAL AS AtkAction PTR, BYVAL AS gint) AS gboolean
  get_n_actions AS FUNCTION(BYVAL AS AtkAction PTR) AS gint
  get_description AS FUNCTION(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
  get_name AS FUNCTION(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
  get_keybinding AS FUNCTION(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
  set_description AS FUNCTION(BYVAL AS AtkAction PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS gboolean
  get_localized_name AS FUNCTION(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_action_get_type() AS GType
DECLARE FUNCTION atk_action_do_action(BYVAL AS AtkAction PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_action_get_n_actions(BYVAL AS AtkAction PTR) AS gint
DECLARE FUNCTION atk_action_get_description(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION atk_action_get_name(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION atk_action_get_keybinding(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION atk_action_set_description(BYVAL AS AtkAction PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION atk_action_get_localized_name(BYVAL AS AtkAction PTR, BYVAL AS gint) AS CONST gchar PTR

#ENDIF ' __ATK_ACTION_H__

#IFNDEF __ATK_COMPONENT_H__
#DEFINE __ATK_COMPONENT_H__

#IFNDEF __ATK_UTIL_H__
#DEFINE __ATK_UTIL_H__

#DEFINE ATK_TYPE_UTIL (atk_util_get_type ())
#DEFINE ATK_IS_UTIL(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_UTIL)
#DEFINE ATK_UTIL(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_UTIL, AtkUtil)
#DEFINE ATK_UTIL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_UTIL, AtkUtilClass))
#DEFINE ATK_IS_UTIL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_UTIL))
#DEFINE ATK_UTIL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_UTIL, AtkUtilClass))

#IFNDEF _TYPEDEF_ATK_UTIL_
#DEFINE _TYPEDEF_ATK_UTIL_

TYPE AtkUtil AS _AtkUtil
TYPE AtkUtilClass AS _AtkUtilClass
TYPE AtkKeyEventStruct AS _AtkKeyEventStruct

#ENDIF ' _TYPEDEF_ATK_UTIL_

TYPE AtkEventListener AS SUB(BYVAL AS AtkObject PTR)
TYPE AtkEventListenerInit AS SUB()
TYPE AtkKeySnoopFunc AS FUNCTION(BYVAL AS AtkKeyEventStruct PTR, BYVAL AS gpointer) AS gint

TYPE _AtkKeyEventStruct
  AS gint type
  AS guint state
  AS guint keyval
  AS gint length
  AS gchar PTR string
  AS guint16 keycode
  AS guint32 timestamp
END TYPE

ENUM AtkKeyEventType
  ATK_KEY_EVENT_PRESS
  ATK_KEY_EVENT_RELEASE
  ATK_KEY_EVENT_LAST_DEFINED
END ENUM

TYPE _AtkUtil
  AS GObject parent
END TYPE

TYPE _AtkUtilClass
  AS GObjectClass parent
  add_global_event_listener AS FUNCTION(BYVAL AS GSignalEmissionHook, BYVAL AS CONST gchar PTR) AS guint
  remove_global_event_listener AS SUB(BYVAL AS guint)
  add_key_event_listener AS FUNCTION(BYVAL AS AtkKeySnoopFunc, BYVAL AS gpointer) AS guint
  remove_key_event_listener AS SUB(BYVAL AS guint)
  get_root AS FUNCTION() AS AtkObject PTR
  get_toolkit_name AS FUNCTION() AS CONST gchar PTR
  get_toolkit_version AS FUNCTION() AS CONST gchar PTR
END TYPE

DECLARE FUNCTION atk_util_get_type() AS GType

ENUM AtkCoordType
  ATK_XY_SCREEN
  ATK_XY_WINDOW
END ENUM

DECLARE FUNCTION atk_add_focus_tracker(BYVAL AS AtkEventListener) AS guint
DECLARE SUB atk_remove_focus_tracker(BYVAL AS guint)
DECLARE SUB atk_focus_tracker_init(BYVAL AS AtkEventListenerInit)
DECLARE SUB atk_focus_tracker_notify(BYVAL AS AtkObject PTR)
DECLARE FUNCTION atk_add_global_event_listener(BYVAL AS GSignalEmissionHook, BYVAL AS CONST gchar PTR) AS guint
DECLARE SUB atk_remove_global_event_listener(BYVAL AS guint)
DECLARE FUNCTION atk_add_key_event_listener(BYVAL AS AtkKeySnoopFunc, BYVAL AS gpointer) AS guint
DECLARE SUB atk_remove_key_event_listener(BYVAL AS guint)
DECLARE FUNCTION atk_get_root() AS AtkObject PTR
DECLARE FUNCTION atk_get_focus_object() AS AtkObject PTR
DECLARE FUNCTION atk_get_toolkit_name() AS CONST gchar PTR
DECLARE FUNCTION atk_get_toolkit_version() AS CONST gchar PTR
DECLARE FUNCTION atk_get_version() AS CONST gchar PTR

#DEFINE ATK_DEFINE_TYPE(TN, t_n, T_P) ATK_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, 0, )

#MACRO ATK_DEFINE_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
 _ATK_DEFINE_TYPE_EXTENDED_BEGIN (TN, t_n, T_P, 0)
 _C_
 _ATK_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#DEFINE ATK_DEFINE_ABSTRACT_TYPE(TN, t_n, T_P) ATK_DEFINE_TYPE_EXTENDED (TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT, )

#MACRO ATK_DEFINE_ABSTRACT_TYPE_WITH_CODE(TN, t_n, T_P, _C_)
 _ATK_DEFINE_TYPE_EXTENDED_BEGIN (TN, t_n, T_P, G_TYPE_FLAG_ABSTRACT)
 _C_
 _ATK_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#MACRO ATK_DEFINE_TYPE_EXTENDED(TN, t_n, T_P, _F_, _C_)
 _ATK_DEFINE_TYPE_EXTENDED_BEGIN (TN, t_n, T_P, _F_)
 _C_
 _ATK_DEFINE_TYPE_EXTENDED_END()
#ENDMACRO

#MACRO _ATK_DEFINE_TYPE_EXTENDED_BEGIN(TypeName, type_name, TYPE, flags)
 DECLARE SUB type_name##_init CDECL(BYVAL self AS TypeName PTR)
 DECLARE SUB type_name##_class_init CDECL(BYVAL klass AS TypeName##Class PTR)
 STATIC SHARED AS gpointer type_name##_parent_class = NULL
 SUB type_name##_class_intern_init CDECL(BYVAL klass AS gpointer) STATIC
   type_name##_parent_class = g_type_class_peek_parent (klass)
   type_name##_class_init (CAST(TypeName##Class PTR, klass))
 END SUB

 FUNCTION type_name##_get_type CDECL() AS GType
   STATIC AS gsize g_define_type_id__volatile = 0
   IF (g_once_init_enter (@g_define_type_id__volatile)) THEN
     DIM AS GTypeQuery query
     VAR derived_type = g_type_parent (TYPE)
     VAR factory = atk_registry_get_factory (atk_get_default_registry (), derived_type)
     VAR derived_atk_type = atk_object_factory_get_accessible_type (factory)
     g_type_query (derived_atk_type, @query)
     VAR g_define_type_id = _
           g_type_register_static_simple (derived_atk_type, _
                                          g_intern_static_string (#TypeName), _
                                          query.class_size, _
                                          CAST(GClassInitFunc, @type_name##_class_intern_init), _
                                          query.instance_size, _
                                          CAST(GInstanceInitFunc, @type_name##_init), _
                                          CAST(GTypeFlags, flags))
#ENDMACRO

#MACRO _ATK_DEFINE_TYPE_EXTENDED_END()
     g_once_init_leave (@g_define_type_id__volatile, g_define_type_id)
   END IF : RETURN g_define_type_id__volatile
 END FUNCTION
#ENDMACRO

#ENDIF ' __ATK_UTIL_H__

#DEFINE ATK_TYPE_COMPONENT (atk_component_get_type ())
#DEFINE ATK_IS_COMPONENT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_COMPONENT)
#DEFINE ATK_COMPONENT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_COMPONENT, AtkComponent)
#DEFINE ATK_COMPONENT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_COMPONENT, AtkComponentIface))

#IFNDEF _TYPEDEF_ATK_COMPONENT_
#DEFINE _TYPEDEF_ATK_COMPONENT_

TYPE AtkComponent AS _AtkComponent

#ENDIF ' _TYPEDEF_ATK_COMPONENT_

TYPE AtkComponentIface AS _AtkComponentIface
TYPE AtkFocusHandler AS SUB(BYVAL AS AtkObject PTR, BYVAL AS gboolean)
TYPE AtkRectangle AS _AtkRectangle

TYPE _AtkRectangle
  AS gint x
  AS gint y
  AS gint width
  AS gint height
END TYPE

DECLARE FUNCTION atk_rectangle_get_type() AS GType

#DEFINE ATK_TYPE_RECTANGLE (atk_rectangle_get_type ())

TYPE _AtkComponentIface
  AS GTypeInterface parent
  add_focus_handler AS FUNCTION(BYVAL AS AtkComponent PTR, BYVAL AS AtkFocusHandler) AS guint
  contains AS FUNCTION(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gboolean
  ref_accessible_at_point AS FUNCTION(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS AtkObject PTR
  get_extents AS SUB(BYVAL AS AtkComponent PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
  get_position AS SUB(BYVAL AS AtkComponent PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
  get_size AS SUB(BYVAL AS AtkComponent PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  grab_focus AS FUNCTION(BYVAL AS AtkComponent PTR) AS gboolean
  remove_focus_handler AS SUB(BYVAL AS AtkComponent PTR, BYVAL AS guint)
  set_extents AS FUNCTION(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gboolean
  set_position AS FUNCTION(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gboolean
  set_size AS FUNCTION(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
  get_layer AS FUNCTION(BYVAL AS AtkComponent PTR) AS AtkLayer
  get_mdi_zorder AS FUNCTION(BYVAL AS AtkComponent PTR) AS gint
  bounds_changed AS SUB(BYVAL AS AtkComponent PTR, BYVAL AS AtkRectangle PTR)
  get_alpha AS FUNCTION(BYVAL AS AtkComponent PTR) AS gdouble
END TYPE

DECLARE FUNCTION atk_component_get_type() AS GType
DECLARE FUNCTION atk_component_add_focus_handler(BYVAL AS AtkComponent PTR, BYVAL AS AtkFocusHandler) AS guint
DECLARE FUNCTION atk_component_contains(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gboolean
DECLARE FUNCTION atk_component_ref_accessible_at_point(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS AtkObject PTR
DECLARE SUB atk_component_get_extents(BYVAL AS AtkComponent PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
DECLARE SUB atk_component_get_position(BYVAL AS AtkComponent PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
DECLARE SUB atk_component_get_size(BYVAL AS AtkComponent PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION atk_component_get_layer(BYVAL AS AtkComponent PTR) AS AtkLayer
DECLARE FUNCTION atk_component_get_mdi_zorder(BYVAL AS AtkComponent PTR) AS gint
DECLARE FUNCTION atk_component_grab_focus(BYVAL AS AtkComponent PTR) AS gboolean
DECLARE SUB atk_component_remove_focus_handler(BYVAL AS AtkComponent PTR, BYVAL AS guint)
DECLARE FUNCTION atk_component_set_extents(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gboolean
DECLARE FUNCTION atk_component_set_position(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gboolean
DECLARE FUNCTION atk_component_set_size(BYVAL AS AtkComponent PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_component_get_alpha(BYVAL AS AtkComponent PTR) AS gdouble

#ENDIF ' __ATK_COMPONENT_H__

#IFNDEF __ATK_DOCUMENT_H__
#DEFINE __ATK_DOCUMENT_H__

#DEFINE ATK_TYPE_DOCUMENT (atk_document_get_type ())
#DEFINE ATK_IS_DOCUMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_DOCUMENT)
#DEFINE ATK_DOCUMENT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_DOCUMENT, AtkDocument)
#DEFINE ATK_DOCUMENT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_DOCUMENT, AtkDocumentIface))

#IFNDEF _TYPEDEF_ATK_DOCUMENT_
#DEFINE _TYPEDEF_ATK_DOCUMENT_

TYPE AtkDocument AS _AtkDocument

#ENDIF ' _TYPEDEF_ATK_DOCUMENT_

TYPE AtkDocumentIface AS _AtkDocumentIface

TYPE _AtkDocumentIface
  AS GTypeInterface parent
  get_document_type AS FUNCTION(BYVAL AS AtkDocument PTR) AS CONST gchar PTR
  get_document AS FUNCTION(BYVAL AS AtkDocument PTR) AS gpointer
  get_document_locale AS FUNCTION(BYVAL AS AtkDocument PTR) AS CONST gchar PTR
  get_document_attributes AS FUNCTION(BYVAL AS AtkDocument PTR) AS AtkAttributeSet PTR
  get_document_attribute_value AS FUNCTION(BYVAL AS AtkDocument PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
  set_document_attribute AS FUNCTION(BYVAL AS AtkDocument PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean
  AS AtkFunction pad1
  AS AtkFunction pad2
  AS AtkFunction pad3
  AS AtkFunction pad4
END TYPE

DECLARE FUNCTION atk_document_get_type() AS GType
DECLARE FUNCTION atk_document_get_document_type(BYVAL AS AtkDocument PTR) AS CONST gchar PTR
DECLARE FUNCTION atk_document_get_document(BYVAL AS AtkDocument PTR) AS gpointer
DECLARE FUNCTION atk_document_get_locale(BYVAL AS AtkDocument PTR) AS CONST gchar PTR
DECLARE FUNCTION atk_document_get_attributes(BYVAL AS AtkDocument PTR) AS AtkAttributeSet PTR
DECLARE FUNCTION atk_document_get_attribute_value(BYVAL AS AtkDocument PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE FUNCTION atk_document_set_attribute_value(BYVAL AS AtkDocument PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS gboolean

#ENDIF ' __ATK_DOCUMENT_H__

#IFNDEF __ATK_EDITABLE_TEXT_H__
#DEFINE __ATK_EDITABLE_TEXT_H__

#IFNDEF __ATK_TEXT_H__
#DEFINE __ATK_TEXT_H__

ENUM AtkTextAttribute
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
END ENUM

DECLARE FUNCTION atk_text_attribute_register(BYVAL AS CONST gchar PTR) AS AtkTextAttribute

#DEFINE ATK_TYPE_TEXT (atk_text_get_type ())
#DEFINE ATK_IS_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_TEXT)
#DEFINE ATK_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_TEXT, AtkText)
#DEFINE ATK_TEXT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_TEXT, AtkTextIface))

#IFNDEF _TYPEDEF_ATK_TEXT_
#DEFINE _TYPEDEF_ATK_TEXT_

TYPE AtkText AS _AtkText

#ENDIF ' _TYPEDEF_ATK_TEXT_

TYPE AtkTextIface AS _AtkTextIface

ENUM AtkTextBoundary
  ATK_TEXT_BOUNDARY_CHAR
  ATK_TEXT_BOUNDARY_WORD_START
  ATK_TEXT_BOUNDARY_WORD_END
  ATK_TEXT_BOUNDARY_SENTENCE_START
  ATK_TEXT_BOUNDARY_SENTENCE_END
  ATK_TEXT_BOUNDARY_LINE_START
  ATK_TEXT_BOUNDARY_LINE_END
END ENUM

TYPE AtkTextRectangle AS _AtkTextRectangle

TYPE _AtkTextRectangle
  AS gint x
  AS gint y
  AS gint width
  AS gint height
END TYPE

TYPE AtkTextRange AS _AtkTextRange

TYPE _AtkTextRange
  AS AtkTextRectangle bounds
  AS gint start_offset
  AS gint end_offset
  AS gchar PTR content
END TYPE

DECLARE FUNCTION atk_text_range_get_type() AS GType

ENUM AtkTextClipType
  ATK_TEXT_CLIP_NONE
  ATK_TEXT_CLIP_MIN
  ATK_TEXT_CLIP_MAX
  ATK_TEXT_CLIP_BOTH
END ENUM

TYPE _AtkTextIface
  AS GTypeInterface parent
  get_text AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint) AS gchar PTR
  get_text_after_offset AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS AtkTextBoundary, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
  get_text_at_offset AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS AtkTextBoundary, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
  get_character_at_offset AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint) AS gunichar
  get_text_before_offset AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS AtkTextBoundary, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
  get_caret_offset AS FUNCTION(BYVAL AS AtkText PTR) AS gint
  get_run_attributes AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS AtkAttributeSet PTR
  get_default_attributes AS FUNCTION(BYVAL AS AtkText PTR) AS AtkAttributeSet PTR
  get_character_extents AS SUB(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
  get_character_count AS FUNCTION(BYVAL AS AtkText PTR) AS gint
  get_offset_at_point AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gint
  get_n_selections AS FUNCTION(BYVAL AS AtkText PTR) AS gint
  get_selection AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
  add_selection AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
  remove_selection AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint) AS gboolean
  set_selection AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS gboolean
  set_caret_offset AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS gint) AS gboolean
  text_changed AS SUB(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint)
  text_caret_moved AS SUB(BYVAL AS AtkText PTR, BYVAL AS gint)
  text_selection_changed AS SUB(BYVAL AS AtkText PTR)
  text_attributes_changed AS SUB(BYVAL AS AtkText PTR)
  get_range_extents AS SUB(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType, BYVAL AS AtkTextRectangle PTR)
  get_bounded_ranges AS FUNCTION(BYVAL AS AtkText PTR, BYVAL AS AtkTextRectangle PTR, BYVAL AS AtkCoordType, BYVAL AS AtkTextClipType, BYVAL AS AtkTextClipType) AS AtkTextRange PTR PTR
  AS AtkFunction pad4
END TYPE

DECLARE FUNCTION atk_text_get_type() AS GType
DECLARE FUNCTION atk_text_get_text(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION atk_text_get_character_at_offset(BYVAL AS AtkText PTR, BYVAL AS gint) AS gunichar
DECLARE FUNCTION atk_text_get_text_after_offset(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS AtkTextBoundary, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
DECLARE FUNCTION atk_text_get_text_at_offset(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS AtkTextBoundary, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
DECLARE FUNCTION atk_text_get_text_before_offset(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS AtkTextBoundary, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
DECLARE FUNCTION atk_text_get_caret_offset(BYVAL AS AtkText PTR) AS gint
DECLARE SUB atk_text_get_character_extents(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
DECLARE FUNCTION atk_text_get_run_attributes(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS AtkAttributeSet PTR
DECLARE FUNCTION atk_text_get_default_attributes(BYVAL AS AtkText PTR) AS AtkAttributeSet PTR
DECLARE FUNCTION atk_text_get_character_count(BYVAL AS AtkText PTR) AS gint
DECLARE FUNCTION atk_text_get_offset_at_point(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType) AS gint
DECLARE FUNCTION atk_text_get_n_selections(BYVAL AS AtkText PTR) AS gint
DECLARE FUNCTION atk_text_get_selection(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gchar PTR
DECLARE FUNCTION atk_text_add_selection(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_text_remove_selection(BYVAL AS AtkText PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_text_set_selection(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_text_set_caret_offset(BYVAL AS AtkText PTR, BYVAL AS gint) AS gboolean
DECLARE SUB atk_text_get_range_extents(BYVAL AS AtkText PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS AtkCoordType, BYVAL AS AtkTextRectangle PTR)
DECLARE FUNCTION atk_text_get_bounded_ranges(BYVAL AS AtkText PTR, BYVAL AS AtkTextRectangle PTR, BYVAL AS AtkCoordType, BYVAL AS AtkTextClipType, BYVAL AS AtkTextClipType) AS AtkTextRange PTR PTR
DECLARE SUB atk_text_free_ranges(BYVAL AS AtkTextRange PTR PTR)
DECLARE SUB atk_attribute_set_free(BYVAL AS AtkAttributeSet PTR)
DECLARE FUNCTION atk_text_attribute_get_name(BYVAL AS AtkTextAttribute) AS CONST gchar PTR
DECLARE FUNCTION atk_text_attribute_for_name(BYVAL AS CONST gchar PTR) AS AtkTextAttribute
DECLARE FUNCTION atk_text_attribute_get_value(BYVAL AS AtkTextAttribute, BYVAL AS gint) AS CONST gchar PTR

#ENDIF ' __ATK_TEXT_H__

#DEFINE ATK_TYPE_EDITABLE_TEXT (atk_editable_text_get_type ())
#DEFINE ATK_IS_EDITABLE_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_EDITABLE_TEXT)
#DEFINE ATK_EDITABLE_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_EDITABLE_TEXT, AtkEditableText)
#DEFINE ATK_EDITABLE_TEXT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_EDITABLE_TEXT, AtkEditableTextIface))

#IFNDEF _TYPEDEF_ATK_EDITABLE_TEXT_
#DEFINE _TYPEDEF_ATK_EDITABLE_TEXT_

TYPE AtkEditableText AS _AtkEditableText

#ENDIF ' _TYPEDEF_ATK_EDITABLE_TEXT_

TYPE AtkEditableTextIface AS _AtkEditableTextIface

TYPE _AtkEditableTextIface
  AS GTypeInterface parent_interface
  set_run_attributes AS FUNCTION(BYVAL AS AtkEditableText PTR, BYVAL AS AtkAttributeSet PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
  set_text_contents AS SUB(BYVAL AS AtkEditableText PTR, BYVAL AS CONST gchar PTR)
  insert_text AS SUB(BYVAL AS AtkEditableText PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR)
  copy_text AS SUB(BYVAL AS AtkEditableText PTR, BYVAL AS gint, BYVAL AS gint)
  cut_text AS SUB(BYVAL AS AtkEditableText PTR, BYVAL AS gint, BYVAL AS gint)
  delete_text AS SUB(BYVAL AS AtkEditableText PTR, BYVAL AS gint, BYVAL AS gint)
  paste_text AS SUB(BYVAL AS AtkEditableText PTR, BYVAL AS gint)
  AS AtkFunction pad1
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_editable_text_get_type() AS GType
DECLARE FUNCTION atk_editable_text_set_run_attributes(BYVAL AS AtkEditableText PTR, BYVAL AS AtkAttributeSet PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE SUB atk_editable_text_set_text_contents(BYVAL AS AtkEditableText PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB atk_editable_text_insert_text(BYVAL AS AtkEditableText PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR)
DECLARE SUB atk_editable_text_copy_text(BYVAL AS AtkEditableText PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB atk_editable_text_cut_text(BYVAL AS AtkEditableText PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB atk_editable_text_delete_text(BYVAL AS AtkEditableText PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB atk_editable_text_paste_text(BYVAL AS AtkEditableText PTR, BYVAL AS gint)

#ENDIF ' __ATK_EDITABLE_TEXT_H__

#IFNDEF __ATK_GOBJECT_ACCESSIBLE_H__
#DEFINE __ATK_GOBJECT_ACCESSIBLE_H__

#DEFINE ATK_TYPE_GOBJECT_ACCESSIBLE (atk_gobject_accessible_get_type ())
#DEFINE ATK_GOBJECT_ACCESSIBLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessible))
#DEFINE ATK_GOBJECT_ACCESSIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessibleClass))
#DEFINE ATK_IS_GOBJECT_ACCESSIBLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_GOBJECT_ACCESSIBLE))
#DEFINE ATK_IS_GOBJECT_ACCESSIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_GOBJECT_ACCESSIBLE))
#DEFINE ATK_GOBJECT_ACCESSIBLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_GOBJECT_ACCESSIBLE, AtkGObjectAccessibleClass))

TYPE AtkGObjectAccessible AS _AtkGObjectAccessible
TYPE AtkGObjectAccessibleClass AS _AtkGObjectAccessibleClass

TYPE _AtkGObjectAccessible
  AS AtkObject parent
END TYPE

DECLARE FUNCTION atk_gobject_accessible_get_type() AS GType

TYPE _AtkGObjectAccessibleClass
  AS AtkObjectClass parent_class
  AS AtkFunction pad1
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_gobject_accessible_for_object(BYVAL AS GObject PTR) AS AtkObject PTR
DECLARE FUNCTION atk_gobject_accessible_get_object(BYVAL AS AtkGObjectAccessible PTR) AS GObject PTR

#ENDIF ' __ATK_GOBJECT_ACCESSIBLE_H__

#IFNDEF __ATK_HYPERLINK_H__
#DEFINE __ATK_HYPERLINK_H__

ENUM AtkHyperlinkStateFlags_
  ATK_HYPERLINK_IS_INLINE_ = 1 SHL 0
END ENUM

#DEFINE ATK_TYPE_HYPERLINK (atk_hyperlink_get_type ())
#DEFINE ATK_HYPERLINK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_HYPERLINK, AtkHyperlink))
#DEFINE ATK_HYPERLINK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_HYPERLINK, AtkHyperlinkClass))
#DEFINE ATK_IS_HYPERLINK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_HYPERLINK))
#DEFINE ATK_IS_HYPERLINK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_HYPERLINK))
#DEFINE ATK_HYPERLINK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_HYPERLINK, AtkHyperlinkClass))

TYPE AtkHyperlink AS _AtkHyperlink
TYPE AtkHyperlinkClass AS _AtkHyperlinkClass

TYPE _AtkHyperlink
  AS GObject parent
END TYPE

TYPE _AtkHyperlinkClass
  AS GObjectClass parent
  get_uri AS FUNCTION(BYVAL AS AtkHyperlink PTR, BYVAL AS gint) AS gchar PTR
  get_object AS FUNCTION(BYVAL AS AtkHyperlink PTR, BYVAL AS gint) AS AtkObject PTR
  get_end_index AS FUNCTION(BYVAL AS AtkHyperlink PTR) AS gint
  get_start_index AS FUNCTION(BYVAL AS AtkHyperlink PTR) AS gint
  is_valid AS FUNCTION(BYVAL AS AtkHyperlink PTR) AS gboolean
  get_n_anchors AS FUNCTION(BYVAL AS AtkHyperlink PTR) AS gint
  link_state AS FUNCTION(BYVAL AS AtkHyperlink PTR) AS guint
  is_selected_link AS FUNCTION(BYVAL AS AtkHyperlink PTR) AS gboolean
  link_activated AS SUB(BYVAL AS AtkHyperlink PTR)
  AS AtkFunction pad1
END TYPE

DECLARE FUNCTION atk_hyperlink_get_type() AS GType
DECLARE FUNCTION atk_hyperlink_get_uri(BYVAL AS AtkHyperlink PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION atk_hyperlink_get_object(BYVAL AS AtkHyperlink PTR, BYVAL AS gint) AS AtkObject PTR
DECLARE FUNCTION atk_hyperlink_get_end_index(BYVAL AS AtkHyperlink PTR) AS gint
DECLARE FUNCTION atk_hyperlink_get_start_index(BYVAL AS AtkHyperlink PTR) AS gint
DECLARE FUNCTION atk_hyperlink_is_valid(BYVAL AS AtkHyperlink PTR) AS gboolean
DECLARE FUNCTION atk_hyperlink_is_inline(BYVAL AS AtkHyperlink PTR) AS gboolean
DECLARE FUNCTION atk_hyperlink_get_n_anchors(BYVAL AS AtkHyperlink PTR) AS gint

#IFNDEF ATK_DISABLE_DEPRECATED

DECLARE FUNCTION atk_hyperlink_is_selected_link(BYVAL AS AtkHyperlink PTR) AS gboolean

#ENDIF ' ATK_DISABLE_DEPRECATED
#ENDIF ' __ATK_HYPERLINK_H__

#IFNDEF __ATK_HYPERLINK_IMPL_H__
#DEFINE __ATK_HYPERLINK_IMPL_H__

#DEFINE ATK_TYPE_HYPERLINK_IMPL (atk_hyperlink_impl_get_type ())
#DEFINE ATK_IS_HYPERLINK_IMPL(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_HYPERLINK_IMPL)
#DEFINE ATK_HYPERLINK_IMPL(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_HYPERLINK_IMPL, AtkHyperlinkImpl)
#DEFINE ATK_HYPERLINK_IMPL_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_HYPERLINK_IMPL, AtkHyperlinkImplIface)

#IFNDEF _TYPEDEF_ATK_HYPERLINK_IMPL_
#DEFINE _TYPEDEF_ATK_HYPERLINK_IMPL__

TYPE AtkHyperlinkImpl AS _AtkHyperlinkImpl

#ENDIF ' _TYPEDEF_ATK_HYPERLINK_IMPL_

TYPE AtkHyperlinkImplIface AS _AtkHyperlinkImplIface

TYPE _AtkHyperlinkImplIface
  AS GTypeInterface parent
  get_hyperlink AS FUNCTION(BYVAL AS AtkHyperlinkImpl PTR) AS AtkHyperlink PTR
  AS AtkFunction pad1
END TYPE

DECLARE FUNCTION atk_hyperlink_impl_get_type() AS GType
DECLARE FUNCTION atk_hyperlink_impl_get_hyperlink(BYVAL AS AtkHyperlinkImpl PTR) AS AtkHyperlink PTR

#ENDIF ' __ATK_HYPERLINK_IMPL_H__

#IFNDEF __ATK_HYPERTEXT_H__
#DEFINE __ATK_HYPERTEXT_H__

#DEFINE ATK_TYPE_HYPERTEXT (atk_hypertext_get_type ())
#DEFINE ATK_IS_HYPERTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_HYPERTEXT)
#DEFINE ATK_HYPERTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_HYPERTEXT, AtkHypertext)
#DEFINE ATK_HYPERTEXT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_HYPERTEXT, AtkHypertextIface))

#IFNDEF _TYPEDEF_ATK_HYPERTEXT_
#DEFINE _TYPEDEF_ATK_HYPERTEXT_

TYPE AtkHypertext AS _AtkHypertext

#ENDIF ' _TYPEDEF_ATK_HYPERTEXT_

TYPE AtkHypertextIface AS _AtkHypertextIface

TYPE _AtkHypertextIface
  AS GTypeInterface parent
  get_link AS FUNCTION(BYVAL AS AtkHypertext PTR, BYVAL AS gint) AS AtkHyperlink PTR
  get_n_links AS FUNCTION(BYVAL AS AtkHypertext PTR) AS gint
  get_link_index AS FUNCTION(BYVAL AS AtkHypertext PTR, BYVAL AS gint) AS gint
  link_selected AS SUB(BYVAL AS AtkHypertext PTR, BYVAL AS gint)
  AS AtkFunction pad1
  AS AtkFunction pad2
  AS AtkFunction pad3
END TYPE

DECLARE FUNCTION atk_hypertext_get_type() AS GType
DECLARE FUNCTION atk_hypertext_get_link(BYVAL AS AtkHypertext PTR, BYVAL AS gint) AS AtkHyperlink PTR
DECLARE FUNCTION atk_hypertext_get_n_links(BYVAL AS AtkHypertext PTR) AS gint
DECLARE FUNCTION atk_hypertext_get_link_index(BYVAL AS AtkHypertext PTR, BYVAL AS gint) AS gint

#ENDIF ' __ATK_HYPERTEXT_H__

#IFNDEF __ATK_IMAGE_H__
#DEFINE __ATK_IMAGE_H__

#DEFINE ATK_TYPE_IMAGE (atk_image_get_type ())
#DEFINE ATK_IS_IMAGE(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_IMAGE)
#DEFINE ATK_IMAGE(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_IMAGE, AtkImage)
#DEFINE ATK_IMAGE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_IMAGE, AtkImageIface))

#IFNDEF _TYPEDEF_ATK_IMAGE_
#DEFINE _TYPEDEF_ATK_IMAGE_

TYPE AtkImage AS _AtkImage

#ENDIF ' _TYPEDEF_ATK_IMAGE_

TYPE AtkImageIface AS _AtkImageIface

TYPE _AtkImageIface
  AS GTypeInterface parent
  get_image_position AS SUB(BYVAL AS AtkImage PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
  get_image_description AS FUNCTION(BYVAL AS AtkImage PTR) AS CONST gchar PTR
  get_image_size AS SUB(BYVAL AS AtkImage PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  set_image_description AS FUNCTION(BYVAL AS AtkImage PTR, BYVAL AS CONST gchar PTR) AS gboolean
  get_image_locale AS FUNCTION(BYVAL AS AtkImage PTR) AS CONST gchar PTR
  AS AtkFunction pad1
END TYPE

DECLARE FUNCTION atk_image_get_type() AS GType
DECLARE FUNCTION atk_image_get_image_description(BYVAL AS AtkImage PTR) AS CONST gchar PTR
DECLARE SUB atk_image_get_image_size(BYVAL AS AtkImage PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION atk_image_set_image_description(BYVAL AS AtkImage PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE SUB atk_image_get_image_position(BYVAL AS AtkImage PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS AtkCoordType)
DECLARE FUNCTION atk_image_get_image_locale(BYVAL AS AtkImage PTR) AS CONST gchar PTR

#ENDIF ' __ATK_IMAGE_H__

#IFNDEF __ATK_NO_OP_OBJECT_H__
#DEFINE __ATK_NO_OP_OBJECT_H__
#DEFINE ATK_TYPE_NO_OP_OBJECT (atk_no_op_object_get_type ())
#DEFINE ATK_NO_OP_OBJECT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObject))
#DEFINE ATK_NO_OP_OBJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObjectClass))
#DEFINE ATK_IS_NO_OP_OBJECT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_NO_OP_OBJECT))
#DEFINE ATK_IS_NO_OP_OBJECT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_NO_OP_OBJECT))
#DEFINE ATK_NO_OP_OBJECT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_NO_OP_OBJECT, AtkNoOpObjectClass))

TYPE AtkNoOpObject AS _AtkNoOpObject
TYPE AtkNoOpObjectClass AS _AtkNoOpObjectClass

TYPE _AtkNoOpObject
  AS AtkObject parent
END TYPE

DECLARE FUNCTION atk_no_op_object_get_type() AS GType

TYPE _AtkNoOpObjectClass
  AS AtkObjectClass parent_class
END TYPE

DECLARE FUNCTION atk_no_op_object_new(BYVAL AS GObject PTR) AS AtkObject PTR

#ENDIF ' __ATK_NO_OP_OBJECT_H__

#IFNDEF __ATK_NO_OP_OBJECT_FACTORY_H__
#DEFINE __ATK_NO_OP_OBJECT_FACTORY_H__

#IFNDEF __ATK_OBJECT_FACTORY_H__
#DEFINE __ATK_OBJECT_FACTORY_H__

#DEFINE ATK_TYPE_OBJECT_FACTORY (atk_object_factory_get_type ())
#DEFINE ATK_OBJECT_FACTORY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactory))
#DEFINE ATK_OBJECT_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactoryClass))
#DEFINE ATK_IS_OBJECT_FACTORY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_OBJECT_FACTORY))
#DEFINE ATK_IS_OBJECT_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_OBJECT_FACTORY))
#DEFINE ATK_OBJECT_FACTORY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_OBJECT_FACTORY, AtkObjectFactoryClass))

TYPE AtkObjectFactory AS _AtkObjectFactory
TYPE AtkObjectFactoryClass AS _AtkObjectFactoryClass

TYPE _AtkObjectFactory
  AS GObject parent
END TYPE

TYPE _AtkObjectFactoryClass
  AS GObjectClass parent_class
  create_accessible AS FUNCTION(BYVAL AS GObject PTR) AS AtkObject PTR
  invalidate AS SUB(BYVAL AS AtkObjectFactory PTR)
  get_accessible_type AS FUNCTION() AS GType
  AS AtkFunction pad1
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_object_factory_get_type() AS GType
DECLARE FUNCTION atk_object_factory_create_accessible(BYVAL AS AtkObjectFactory PTR, BYVAL AS GObject PTR) AS AtkObject PTR
DECLARE SUB atk_object_factory_invalidate(BYVAL AS AtkObjectFactory PTR)
DECLARE FUNCTION atk_object_factory_get_accessible_type(BYVAL AS AtkObjectFactory PTR) AS GType

#ENDIF ' __ATK_OBJECT_FACTORY_H__

#DEFINE ATK_TYPE_NO_OP_OBJECT_FACTORY (atk_no_op_object_factory_get_type ())
#DEFINE ATK_NO_OP_OBJECT_FACTORY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactory))
#DEFINE ATK_NO_OP_OBJECT_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactoryClass))
#DEFINE ATK_IS_NO_OP_OBJECT_FACTORY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_NO_OP_OBJECT_FACTORY))
#DEFINE ATK_IS_NO_OP_OBJECT_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_NO_OP_OBJECT_FACTORY))
#DEFINE ATK_NO_OP_OBJECT_FACTORY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ( (obj), ATK_TYPE_NO_OP_OBJECT_FACTORY, AtkNoOpObjectFactoryClass))

TYPE AtkNoOpObjectFactory AS _AtkNoOpObjectFactory
TYPE AtkNoOpObjectFactoryClass AS _AtkNoOpObjectFactoryClass

TYPE _AtkNoOpObjectFactory
  AS AtkObjectFactory parent
END TYPE

TYPE _AtkNoOpObjectFactoryClass
  AS AtkObjectFactoryClass parent_class
END TYPE

DECLARE FUNCTION atk_no_op_object_factory_get_type() AS GType
DECLARE FUNCTION atk_no_op_object_factory_new() AS AtkObjectFactory PTR

#ENDIF ' __ATK_NO_OP_OBJECT_FACTORY_H__

#IFNDEF __ATK_PLUG_H__
#DEFINE __ATK_PLUG_H__
#DEFINE ATK_TYPE_PLUG (atk_plug_get_type ())
#DEFINE ATK_PLUG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_PLUG, AtkPlug))
#DEFINE ATK_IS_PLUG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_PLUG))
#DEFINE ATK_PLUG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_PLUG, AtkPlugClass))
#DEFINE ATK_IS_PLUG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_PLUG))
#DEFINE ATK_PLUG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_PLUG, AtkPlugClass))

TYPE AtkPlug AS _AtkPlug
TYPE AtkPlugClass AS _AtkPlugClass

TYPE _AtkPlug
  AS AtkObject parent
END TYPE

DECLARE FUNCTION atk_plug_get_type() AS GType

TYPE _AtkPlugClass
  AS AtkObjectClass parent_class
  get_object_id AS FUNCTION(BYVAL AS AtkPlug PTR) AS gchar PTR
END TYPE

DECLARE FUNCTION atk_plug_new() AS AtkObject PTR
DECLARE FUNCTION atk_plug_get_id(BYVAL AS AtkPlug PTR) AS gchar PTR

#ENDIF ' __ATK_PLUG_H__

#IFNDEF __ATK_REGISTRY_H__
#DEFINE __ATK_REGISTRY_H__

#DEFINE ATK_TYPE_REGISTRY (atk_registry_get_type ())
#DEFINE ATK_REGISTRY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_REGISTRY, AtkRegistry))
#DEFINE ATK_REGISTRY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_REGISTRY, AtkRegistryClass))
#DEFINE ATK_IS_REGISTRY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_REGISTRY))
#DEFINE ATK_IS_REGISTRY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_REGISTRY))
#DEFINE ATK_REGISTRY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_REGISTRY, AtkRegistryClass))

TYPE _AtkRegistry
  AS GObject parent
  AS GHashTable PTR factory_type_registry
  AS GHashTable PTR factory_singleton_cache
END TYPE

TYPE _AtkRegistryClass
  AS GObjectClass parent_class
END TYPE

TYPE AtkRegistry AS _AtkRegistry
TYPE AtkRegistryClass AS _AtkRegistryClass

DECLARE FUNCTION atk_registry_get_type() AS GType
DECLARE SUB atk_registry_set_factory_type(BYVAL AS AtkRegistry PTR, BYVAL AS GType, BYVAL AS GType)
DECLARE FUNCTION atk_registry_get_factory_type(BYVAL AS AtkRegistry PTR, BYVAL AS GType) AS GType
DECLARE FUNCTION atk_registry_get_factory(BYVAL AS AtkRegistry PTR, BYVAL AS GType) AS AtkObjectFactory PTR
DECLARE FUNCTION atk_get_default_registry() AS AtkRegistry PTR

#ENDIF ' __ATK_REGISTRY_H__

#IFNDEF __ATK_RELATION_H__
#DEFINE __ATK_RELATION_H__

#DEFINE ATK_TYPE_RELATION (atk_relation_get_type ())
#DEFINE ATK_RELATION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_RELATION, AtkRelation))
#DEFINE ATK_RELATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_RELATION, AtkRelationClass))
#DEFINE ATK_IS_RELATION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_RELATION))
#DEFINE ATK_IS_RELATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_RELATION))
#DEFINE ATK_RELATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_RELATION, AtkRelationClass))

TYPE AtkRelation AS _AtkRelation
TYPE AtkRelationClass AS _AtkRelationClass

TYPE _AtkRelation
  AS GObject parent
  AS GPtrArray PTR target
  AS AtkRelationType relationship
END TYPE

TYPE _AtkRelationClass
  AS GObjectClass parent
END TYPE

DECLARE FUNCTION atk_relation_get_type() AS GType
DECLARE FUNCTION atk_relation_type_register(BYVAL AS CONST gchar PTR) AS AtkRelationType
DECLARE FUNCTION atk_relation_type_get_name(BYVAL AS AtkRelationType) AS CONST gchar PTR
DECLARE FUNCTION atk_relation_type_for_name(BYVAL AS CONST gchar PTR) AS AtkRelationType
DECLARE FUNCTION atk_relation_new(BYVAL AS AtkObject PTR PTR, BYVAL AS gint, BYVAL AS AtkRelationType) AS AtkRelation PTR
DECLARE FUNCTION atk_relation_get_relation_type(BYVAL AS AtkRelation PTR) AS AtkRelationType
DECLARE FUNCTION atk_relation_get_target(BYVAL AS AtkRelation PTR) AS GPtrArray PTR
DECLARE SUB atk_relation_add_target(BYVAL AS AtkRelation PTR, BYVAL AS AtkObject PTR)
DECLARE FUNCTION atk_relation_remove_target(BYVAL AS AtkRelation PTR, BYVAL AS AtkObject PTR) AS gboolean

#ENDIF ' __ATK_RELATION_H__

#IFNDEF __ATK_RELATION_SET_H__
#DEFINE __ATK_RELATION_SET_H__

#DEFINE ATK_TYPE_RELATION_SET (atk_relation_set_get_type ())
#DEFINE ATK_RELATION_SET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_RELATION_SET, AtkRelationSet))
#DEFINE ATK_RELATION_SET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_RELATION_SET, AtkRelationSetClass))
#DEFINE ATK_IS_RELATION_SET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_RELATION_SET))
#DEFINE ATK_IS_RELATION_SET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_RELATION_SET))
#DEFINE ATK_RELATION_SET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_RELATION_SET, AtkRelationSetClass))

TYPE AtkRelationSetClass AS _AtkRelationSetClass

TYPE _AtkRelationSet
  AS GObject parent
  AS GPtrArray PTR relations
END TYPE

TYPE _AtkRelationSetClass
  AS GObjectClass parent
  AS AtkFunction pad1
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_relation_set_get_type() AS GType
DECLARE FUNCTION atk_relation_set_new() AS AtkRelationSet PTR
DECLARE FUNCTION atk_relation_set_contains(BYVAL AS AtkRelationSet PTR, BYVAL AS AtkRelationType) AS gboolean
DECLARE SUB atk_relation_set_remove(BYVAL AS AtkRelationSet PTR, BYVAL AS AtkRelation PTR)
DECLARE SUB atk_relation_set_add(BYVAL AS AtkRelationSet PTR, BYVAL AS AtkRelation PTR)
DECLARE FUNCTION atk_relation_set_get_n_relations(BYVAL AS AtkRelationSet PTR) AS gint
DECLARE FUNCTION atk_relation_set_get_relation(BYVAL AS AtkRelationSet PTR, BYVAL AS gint) AS AtkRelation PTR
DECLARE FUNCTION atk_relation_set_get_relation_by_type(BYVAL AS AtkRelationSet PTR, BYVAL AS AtkRelationType) AS AtkRelation PTR
DECLARE SUB atk_relation_set_add_relation_by_type(BYVAL AS AtkRelationSet PTR, BYVAL AS AtkRelationType, BYVAL AS AtkObject PTR)

#ENDIF ' __ATK_RELATION_SET_H__

#IFNDEF __ATK_SELECTION_H__
#DEFINE __ATK_SELECTION_H__

#DEFINE ATK_TYPE_SELECTION (atk_selection_get_type ())
#DEFINE ATK_IS_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_SELECTION)
#DEFINE ATK_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_SELECTION, AtkSelection)
#DEFINE ATK_SELECTION_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_SELECTION, AtkSelectionIface))

#IFNDEF _TYPEDEF_ATK_SELECTION_
#DEFINE _TYPEDEF_ATK_SELECTION_

TYPE AtkSelection AS _AtkSelection

#ENDIF ' _TYPEDEF_ATK_SELECTION_

TYPE AtkSelectionIface AS _AtkSelectionIface

TYPE _AtkSelectionIface
  AS GTypeInterface parent
  add_selection AS FUNCTION(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS gboolean
  clear_selection AS FUNCTION(BYVAL AS AtkSelection PTR) AS gboolean
  ref_selection AS FUNCTION(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS AtkObject PTR
  get_selection_count AS FUNCTION(BYVAL AS AtkSelection PTR) AS gint
  is_child_selected AS FUNCTION(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS gboolean
  remove_selection AS FUNCTION(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS gboolean
  select_all_selection AS FUNCTION(BYVAL AS AtkSelection PTR) AS gboolean
  selection_changed AS SUB(BYVAL AS AtkSelection PTR)
  AS AtkFunction pad1
  AS AtkFunction pad2
END TYPE

DECLARE FUNCTION atk_selection_get_type() AS GType
DECLARE FUNCTION atk_selection_add_selection(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_selection_clear_selection(BYVAL AS AtkSelection PTR) AS gboolean
DECLARE FUNCTION atk_selection_ref_selection(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS AtkObject PTR
DECLARE FUNCTION atk_selection_get_selection_count(BYVAL AS AtkSelection PTR) AS gint
DECLARE FUNCTION atk_selection_is_child_selected(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_selection_remove_selection(BYVAL AS AtkSelection PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_selection_select_all_selection(BYVAL AS AtkSelection PTR) AS gboolean

#ENDIF ' __ATK_SELECTION_H__

#IFNDEF __ATK_SOCKET_H__
#DEFINE __ATK_SOCKET_H__
#DEFINE ATK_TYPE_SOCKET (atk_socket_get_type ())
#DEFINE ATK_SOCKET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_SOCKET, AtkSocket))
#DEFINE ATK_IS_SOCKET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_SOCKET))
#DEFINE ATK_SOCKET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_SOCKET, AtkSocketClass))
#DEFINE ATK_IS_SOCKET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_SOCKET))
#DEFINE ATK_SOCKET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_SOCKET, AtkSocketClass))

TYPE AtkSocket AS _AtkSocket
TYPE AtkSocketClass AS _AtkSocketClass

TYPE _AtkSocket
  AS AtkObject parent
  AS gchar PTR embedded_plug_id
END TYPE

DECLARE FUNCTION atk_socket_get_type() AS GType

TYPE _AtkSocketClass
  AS AtkObjectClass parent_class
  embed AS SUB(BYVAL AS AtkSocket PTR, BYVAL AS gchar PTR)
END TYPE

DECLARE FUNCTION atk_socket_new() AS AtkObject PTR
DECLARE SUB atk_socket_embed(BYVAL AS AtkSocket PTR, BYVAL AS gchar PTR)
DECLARE FUNCTION atk_socket_is_occupied(BYVAL AS AtkSocket PTR) AS gboolean

#ENDIF ' __ATK_SOCKET_H__

#IFNDEF __ATK_STATE_SET_H__
#DEFINE __ATK_STATE_SET_H__

#DEFINE ATK_TYPE_STATE_SET (atk_state_set_get_type ())
#DEFINE ATK_STATE_SET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_STATE_SET, AtkStateSet))
#DEFINE ATK_STATE_SET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_STATE_SET, AtkStateSetClass))
#DEFINE ATK_IS_STATE_SET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_STATE_SET))
#DEFINE ATK_IS_STATE_SET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_STATE_SET))
#DEFINE ATK_STATE_SET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_STATE_SET, AtkStateSetClass))

TYPE AtkStateSetClass AS _AtkStateSetClass

TYPE _AtkStateSet
  AS GObject parent
END TYPE

TYPE _AtkStateSetClass
  AS GObjectClass parent
END TYPE

DECLARE FUNCTION atk_state_set_get_type() AS GType
DECLARE FUNCTION atk_state_set_new() AS AtkStateSet PTR
DECLARE FUNCTION atk_state_set_is_empty(BYVAL AS AtkStateSet PTR) AS gboolean
DECLARE FUNCTION atk_state_set_add_state(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateType) AS gboolean
DECLARE SUB atk_state_set_add_states(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateType PTR, BYVAL AS gint)
DECLARE SUB atk_state_set_clear_states(BYVAL AS AtkStateSet PTR)
DECLARE FUNCTION atk_state_set_contains_state(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateType) AS gboolean
DECLARE FUNCTION atk_state_set_contains_states(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateType PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_state_set_remove_state(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateType) AS gboolean
DECLARE FUNCTION atk_state_set_and_sets(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateSet PTR) AS AtkStateSet PTR
DECLARE FUNCTION atk_state_set_or_sets(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateSet PTR) AS AtkStateSet PTR
DECLARE FUNCTION atk_state_set_xor_sets(BYVAL AS AtkStateSet PTR, BYVAL AS AtkStateSet PTR) AS AtkStateSet PTR

#ENDIF ' __ATK_STATE_SET_H__

#IFNDEF __ATK_STREAMABLE_CONTENT_H__
#DEFINE __ATK_STREAMABLE_CONTENT_H__

#DEFINE ATK_TYPE_STREAMABLE_CONTENT (atk_streamable_content_get_type ())
#DEFINE ATK_IS_STREAMABLE_CONTENT(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_STREAMABLE_CONTENT)
#DEFINE ATK_STREAMABLE_CONTENT(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_STREAMABLE_CONTENT, AtkStreamableContent)
#DEFINE ATK_STREAMABLE_CONTENT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_STREAMABLE_CONTENT, AtkStreamableContentIface))

#IFNDEF _TYPEDEF_ATK_STREAMABLE_CONTENT
#DEFINE _TYPEDEF_ATK_STREAMABLE_CONTENT

TYPE AtkStreamableContent AS _AtkStreamableContent

#ENDIF ' _TYPEDEF_ATK_STREAMABLE_CONTENT

TYPE AtkStreamableContentIface AS _AtkStreamableContentIface

TYPE _AtkStreamableContentIface
  AS GTypeInterface parent
  get_n_mime_types AS FUNCTION(BYVAL AS AtkStreamableContent PTR) AS gint
  get_mime_type AS FUNCTION(BYVAL AS AtkStreamableContent PTR, BYVAL AS gint) AS CONST gchar PTR
  get_stream AS FUNCTION(BYVAL AS AtkStreamableContent PTR, BYVAL AS CONST gchar PTR) AS GIOChannel PTR
  get_uri AS FUNCTION(BYVAL AS AtkStreamableContent PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
  AS AtkFunction pad1
  AS AtkFunction pad2
  AS AtkFunction pad3
END TYPE

DECLARE FUNCTION atk_streamable_content_get_type() AS GType
DECLARE FUNCTION atk_streamable_content_get_n_mime_types(BYVAL AS AtkStreamableContent PTR) AS gint
DECLARE FUNCTION atk_streamable_content_get_mime_type(BYVAL AS AtkStreamableContent PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION atk_streamable_content_get_stream(BYVAL AS AtkStreamableContent PTR, BYVAL AS CONST gchar PTR) AS GIOChannel PTR
DECLARE FUNCTION atk_streamable_content_get_uri(BYVAL AS AtkStreamableContent PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR

#ENDIF ' __ATK_STREAMABLE_CONTENT_H__

#IFNDEF __ATK_TABLE_H__
#DEFINE __ATK_TABLE_H__

#DEFINE ATK_TYPE_TABLE (atk_table_get_type ())
#DEFINE ATK_IS_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_TABLE)
#DEFINE ATK_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_TABLE, AtkTable)
#DEFINE ATK_TABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_TABLE, AtkTableIface))

#IFNDEF _TYPEDEF_ATK_TABLE_
#DEFINE _TYPEDEF_ATK_TABLE_

TYPE AtkTable AS _AtkTable

#ENDIF ' _TYPEDEF_ATK_TABLE_

TYPE AtkTableIface AS _AtkTableIface

TYPE _AtkTableIface
  AS GTypeInterface parent
  ref_at AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS AtkObject PTR
  get_index_at AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gint
  get_column_at_index AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gint
  get_row_at_index AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gint
  get_n_columns AS FUNCTION(BYVAL AS AtkTable PTR) AS gint
  get_n_rows AS FUNCTION(BYVAL AS AtkTable PTR) AS gint
  get_column_extent_at AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gint
  get_row_extent_at AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gint
  get_caption AS FUNCTION(BYVAL AS AtkTable PTR) AS AtkObject PTR
  get_column_description AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS CONST gchar PTR
  get_column_header AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS AtkObject PTR
  get_row_description AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS CONST gchar PTR
  get_row_header AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS AtkObject PTR
  get_summary AS FUNCTION(BYVAL AS AtkTable PTR) AS AtkObject PTR
  set_caption AS SUB(BYVAL AS AtkTable PTR, BYVAL AS AtkObject PTR)
  set_column_description AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
  set_column_header AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS AtkObject PTR)
  set_row_description AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
  set_row_header AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS AtkObject PTR)
  set_summary AS SUB(BYVAL AS AtkTable PTR, BYVAL AS AtkObject PTR)
  get_selected_columns AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint PTR PTR) AS gint
  get_selected_rows AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint PTR PTR) AS gint
  is_column_selected AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
  is_row_selected AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
  is_selected AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
  add_row_selection AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
  remove_row_selection AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
  add_column_selection AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
  remove_column_selection AS FUNCTION(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
  row_inserted AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint)
  column_inserted AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint)
  row_deleted AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint)
  column_deleted AS SUB(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint)
  row_reordered AS SUB(BYVAL AS AtkTable PTR)
  column_reordered AS SUB(BYVAL AS AtkTable PTR)
  model_changed AS SUB(BYVAL AS AtkTable PTR)
  AS AtkFunction pad1
  AS AtkFunction pad2
  AS AtkFunction pad3
  AS AtkFunction pad4
END TYPE

DECLARE FUNCTION atk_table_get_type() AS GType
DECLARE FUNCTION atk_table_ref_at(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS AtkObject PTR
DECLARE FUNCTION atk_table_get_index_at(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE FUNCTION atk_table_get_column_at_index(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION atk_table_get_row_at_index(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION atk_table_get_n_columns(BYVAL AS AtkTable PTR) AS gint
DECLARE FUNCTION atk_table_get_n_rows(BYVAL AS AtkTable PTR) AS gint
DECLARE FUNCTION atk_table_get_column_extent_at(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE FUNCTION atk_table_get_row_extent_at(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE FUNCTION atk_table_get_caption(BYVAL AS AtkTable PTR) AS AtkObject PTR
DECLARE FUNCTION atk_table_get_column_description(BYVAL AS AtkTable PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION atk_table_get_column_header(BYVAL AS AtkTable PTR, BYVAL AS gint) AS AtkObject PTR
DECLARE FUNCTION atk_table_get_row_description(BYVAL AS AtkTable PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE FUNCTION atk_table_get_row_header(BYVAL AS AtkTable PTR, BYVAL AS gint) AS AtkObject PTR
DECLARE FUNCTION atk_table_get_summary(BYVAL AS AtkTable PTR) AS AtkObject PTR
DECLARE SUB atk_table_set_caption(BYVAL AS AtkTable PTR, BYVAL AS AtkObject PTR)
DECLARE SUB atk_table_set_column_description(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB atk_table_set_column_header(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS AtkObject PTR)
DECLARE SUB atk_table_set_row_description(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB atk_table_set_row_header(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS AtkObject PTR)
DECLARE SUB atk_table_set_summary(BYVAL AS AtkTable PTR, BYVAL AS AtkObject PTR)
DECLARE FUNCTION atk_table_get_selected_columns(BYVAL AS AtkTable PTR, BYVAL AS gint PTR PTR) AS gint
DECLARE FUNCTION atk_table_get_selected_rows(BYVAL AS AtkTable PTR, BYVAL AS gint PTR PTR) AS gint
DECLARE FUNCTION atk_table_is_column_selected(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_table_is_row_selected(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_table_is_selected(BYVAL AS AtkTable PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_table_add_row_selection(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_table_remove_row_selection(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_table_add_column_selection(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION atk_table_remove_column_selection(BYVAL AS AtkTable PTR, BYVAL AS gint) AS gboolean

#ENDIF ' __ATK_TABLE_H__

#IFNDEF __ATK_MISC_H__
#DEFINE __ATK_MISC_H__

#DEFINE ATK_TYPE_MISC (atk_misc_get_type ())
#DEFINE ATK_IS_MISC(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_MISC)
#DEFINE ATK_MISC(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_MISC, AtkMisc)
#DEFINE ATK_MISC_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), ATK_TYPE_MISC, AtkMiscClass))
#DEFINE ATK_IS_MISC_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), ATK_TYPE_MISC))
#DEFINE ATK_MISC_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), ATK_TYPE_MISC, AtkMiscClass))

#IFNDEF _TYPEDEF_ATK_MISC_
#DEFINE _TYPEDEF_ATK_MISC_

TYPE AtkMisc AS _AtkMisc
TYPE AtkMiscClass AS _AtkMiscClass

#ENDIF ' _TYPEDEF_ATK_MISC_

TYPE _AtkMisc
  AS GObject parent
END TYPE

EXTERN AS AtkMisc PTR atk_misc_instance

TYPE _AtkMiscClass
  AS GObjectClass parent
  threads_enter AS SUB(BYVAL AS AtkMisc PTR)
  threads_leave AS SUB(BYVAL AS AtkMisc PTR)
  AS gpointer vfuncs(31)
END TYPE

DECLARE FUNCTION atk_misc_get_type() AS GType
DECLARE SUB atk_misc_threads_enter(BYVAL AS AtkMisc PTR)
DECLARE SUB atk_misc_threads_leave(BYVAL AS AtkMisc PTR)
DECLARE FUNCTION atk_misc_get_instance() AS CONST AtkMisc PTR

#ENDIF ' __ATK_MISC_H__

#IFNDEF __ATK_VALUE_H__
#DEFINE __ATK_VALUE_H__

#DEFINE ATK_TYPE_VALUE (atk_value_get_type ())
#DEFINE ATK_IS_VALUE(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_VALUE)
#DEFINE ATK_VALUE(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_VALUE, AtkValue)
#DEFINE ATK_VALUE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_VALUE, AtkValueIface))

#IFNDEF _TYPEDEF_ATK_VALUE_
#DEFINE _TYPEDEF_ATK_VALUE__

TYPE AtkValue AS _AtkValue

#ENDIF ' _TYPEDEF_ATK_VALUE_

TYPE AtkValueIface AS _AtkValueIface

TYPE _AtkValueIface
  AS GTypeInterface parent
  get_current_value AS SUB(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
  get_maximum_value AS SUB(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
  get_minimum_value AS SUB(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
  set_current_value AS FUNCTION(BYVAL AS AtkValue PTR, BYVAL AS CONST GValue PTR) AS gboolean
  get_minimum_increment AS SUB(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
  AS AtkFunction pad1
END TYPE

DECLARE FUNCTION atk_value_get_type() AS GType
DECLARE SUB atk_value_get_current_value(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
DECLARE SUB atk_value_get_maximum_value(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
DECLARE SUB atk_value_get_minimum_value(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)
DECLARE FUNCTION atk_value_set_current_value(BYVAL AS AtkValue PTR, BYVAL AS CONST GValue PTR) AS gboolean
DECLARE SUB atk_value_get_minimum_increment(BYVAL AS AtkValue PTR, BYVAL AS GValue PTR)

#ENDIF ' __ATK_VALUE_H__

#IFNDEF __ATK_WINDOW_H__
#DEFINE __ATK_WINDOW_H__

#DEFINE ATK_TYPE_WINDOW (atk_window_get_type ())
#DEFINE ATK_IS_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE ((obj), ATK_TYPE_WINDOW)
#DEFINE ATK_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST ((obj), ATK_TYPE_WINDOW, AtkWindow)
#DEFINE ATK_WINDOW_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), ATK_TYPE_WINDOW, AtkWindowIface))

TYPE AtkWindow AS _AtkWindow
TYPE AtkWindowIface AS _AtkWindowIface

TYPE _AtkWindowIface
  AS GTypeInterface parent
  AS gpointer _padding_dummy(15)
END TYPE

DECLARE FUNCTION atk_window_get_type() AS GType

#ENDIF ' __ATK_WINDOW_H__

#UNDEF __ATK_H_INSIDE__
#ENDIF ' __ATK_H__

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
#PRAGMA pop(msbitfields)
#ENDIF

' Translated at 12-07-24 11:47:18, by h_2_bi (version 0.2.2.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: ATK-2.4.0.bi
' Parameters: ATK-2.4.0
'                                  Process time [s]: 0.30014408682473
'                                  Bytes translated: 82165
'                                      Maximum deep: 3
'                                SUB/FUNCTION names: 246
'                                mangled TYPE names: 0
'                                        files done: 30
' atk-2.4.0/atk/atk.h
' atk-2.4.0/atk/atkobject.h
' atk-2.4.0/atk/atkstate.h
' atk-2.4.0/atk/atkrelationtype.h
' atk-2.4.0/atk/atkaction.h
' atk-2.4.0/atk/atkcomponent.h
' atk-2.4.0/atk/atkutil.h
' atk-2.4.0/atk/atkdocument.h
' atk-2.4.0/atk/atkeditabletext.h
' atk-2.4.0/atk/atktext.h
' atk-2.4.0/atk/atkgobjectaccessible.h
' atk-2.4.0/atk/atkhyperlink.h
' atk-2.4.0/atk/atkhyperlinkimpl.h
' atk-2.4.0/atk/atkhypertext.h
' atk-2.4.0/atk/atkimage.h
' atk-2.4.0/atk/atknoopobject.h
' atk-2.4.0/atk/atknoopobjectfactory.h
' atk-2.4.0/atk/atkobjectfactory.h
' atk-2.4.0/atk/atkplug.h
' atk-2.4.0/atk/atkregistry.h
' atk-2.4.0/atk/atkrelation.h
' atk-2.4.0/atk/atkrelationset.h
' atk-2.4.0/atk/atkselection.h
' atk-2.4.0/atk/atksocket.h
' atk-2.4.0/atk/atkstateset.h
' atk-2.4.0/atk/atkstreamablecontent.h
' atk-2.4.0/atk/atktable.h
' atk-2.4.0/atk/atkmisc.h
' atk-2.4.0/atk/atkvalue.h
' atk-2.4.0/atk/atkwindow.h
'                                      files missed: 0
'                                       __FOLDERS__: 2
' atk-2.4.0/atk/
' atk-2.4.0/
'                                        __MACROS__: 5
' 29: #define G_BEGIN_DECLS
' 29: #define G_END_DECLS
' 1: #define ATK_VAR extern
' 2: #define G_DEPRECATED_FOR(_T_)
' 1: #define G_DEPRECATED
'                                       __HEADERS__: 3
' 1: atk/atk.h>
' 1: glib.h>glib.bi
' 9: glib-object.h>glib-object.bi
'                                         __TYPES__: 0
'                                     __POST_REPS__: 2
' 1: AtkHyperlinkStateFlags&
' 1: ATK_HYPERLINK_IS_INLINE&
