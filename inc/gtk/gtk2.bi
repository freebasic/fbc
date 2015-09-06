'' FreeBASIC binding for gtk+-2.24.28
''
'' based on the C header files:
''   GTK - The GIMP Toolkit
''   Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
''   Lesser General Public License for more details.
''
''   You should have received a copy of the GNU Lesser General Public
''   License along with this library; if not, write to the
''   Free Software Foundation, Inc., 51 Franklin Street - Fifth Floor,
''   Boston, MA 02111-1301, USA.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef __FB_UNIX__
	#inclib "gtk-x11-2.0"
#else
	#inclib "gtk-win32-2.0"
#endif

#include once "gdk/gdk2.bi"
#include once "glib-object.bi"
#include once "glib.bi"
#include once "atk/atk.bi"
#include once "gio/gio.bi"
#include once "gdk-pixbuf/gdk-pixbuf.bi"
#include once "pango/pango.bi"
#include once "cairo/cairo.bi"
#include once "crt/time.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     procedure gtk_widget_has_focus => gtk_widget_has_focus_
''     procedure gtk_widget_has_default => gtk_widget_has_default_
''     procedure gtk_widget_has_grab => gtk_widget_has_grab_
''     procedure gtk_widget_is_sensitive => gtk_widget_is_sensitive_
''     variable gtk_major_version => gtk_major_version_
''     variable gtk_minor_version => gtk_minor_version_
''     variable gtk_micro_version => gtk_micro_version_
''     variable gtk_binary_age => gtk_binary_age_
''     variable gtk_interface_age => gtk_interface_age_
''     procedure gtk_check_version => gtk_check_version_
''     #ifdef __FB_WIN32__
''         procedure gtk_init => gtk_init_
''         procedure gtk_init_check => gtk_init_check_
''     #endif
''     procedure gtk_stock_add => gtk_stock_add_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __GTK_H__
#define __GTK_H_INSIDE__
#define __GTK_ABOUT_DIALOG_H__
#define __GTK_DIALOG_H__
#define __GTK_WINDOW_H__
#define __GTK_ACCEL_GROUP_H__
#define __GTK_ENUMS_H__

type GtkAnchorType as long
enum
	GTK_ANCHOR_CENTER
	GTK_ANCHOR_NORTH
	GTK_ANCHOR_NORTH_WEST
	GTK_ANCHOR_NORTH_EAST
	GTK_ANCHOR_SOUTH
	GTK_ANCHOR_SOUTH_WEST
	GTK_ANCHOR_SOUTH_EAST
	GTK_ANCHOR_WEST
	GTK_ANCHOR_EAST
	GTK_ANCHOR_N = GTK_ANCHOR_NORTH
	GTK_ANCHOR_NW = GTK_ANCHOR_NORTH_WEST
	GTK_ANCHOR_NE = GTK_ANCHOR_NORTH_EAST
	GTK_ANCHOR_S = GTK_ANCHOR_SOUTH
	GTK_ANCHOR_SW = GTK_ANCHOR_SOUTH_WEST
	GTK_ANCHOR_SE = GTK_ANCHOR_SOUTH_EAST
	GTK_ANCHOR_W = GTK_ANCHOR_WEST
	GTK_ANCHOR_E = GTK_ANCHOR_EAST
end enum

type GtkArrowPlacement as long
enum
	GTK_ARROWS_BOTH
	GTK_ARROWS_START
	GTK_ARROWS_END
end enum

type GtkArrowType as long
enum
	GTK_ARROW_UP
	GTK_ARROW_DOWN
	GTK_ARROW_LEFT
	GTK_ARROW_RIGHT
	GTK_ARROW_NONE
end enum

type GtkAttachOptions as long
enum
	GTK_EXPAND = 1 shl 0
	GTK_SHRINK = 1 shl 1
	GTK_FILL = 1 shl 2
end enum

type GtkButtonBoxStyle as long
enum
	GTK_BUTTONBOX_DEFAULT_STYLE
	GTK_BUTTONBOX_SPREAD
	GTK_BUTTONBOX_EDGE
	GTK_BUTTONBOX_START
	GTK_BUTTONBOX_END
	GTK_BUTTONBOX_CENTER
end enum

type GtkCurveType as long
enum
	GTK_CURVE_TYPE_LINEAR
	GTK_CURVE_TYPE_SPLINE
	GTK_CURVE_TYPE_FREE
end enum

type GtkDeleteType as long
enum
	GTK_DELETE_CHARS
	GTK_DELETE_WORD_ENDS
	GTK_DELETE_WORDS
	GTK_DELETE_DISPLAY_LINES
	GTK_DELETE_DISPLAY_LINE_ENDS
	GTK_DELETE_PARAGRAPH_ENDS
	GTK_DELETE_PARAGRAPHS
	GTK_DELETE_WHITESPACE
end enum

type GtkDirectionType as long
enum
	GTK_DIR_TAB_FORWARD
	GTK_DIR_TAB_BACKWARD
	GTK_DIR_UP
	GTK_DIR_DOWN
	GTK_DIR_LEFT
	GTK_DIR_RIGHT
end enum

type GtkExpanderStyle as long
enum
	GTK_EXPANDER_COLLAPSED
	GTK_EXPANDER_SEMI_COLLAPSED
	GTK_EXPANDER_SEMI_EXPANDED
	GTK_EXPANDER_EXPANDED
end enum

type GtkIconSize as long
enum
	GTK_ICON_SIZE_INVALID
	GTK_ICON_SIZE_MENU
	GTK_ICON_SIZE_SMALL_TOOLBAR
	GTK_ICON_SIZE_LARGE_TOOLBAR
	GTK_ICON_SIZE_BUTTON
	GTK_ICON_SIZE_DND
	GTK_ICON_SIZE_DIALOG
end enum

type GtkSensitivityType as long
enum
	GTK_SENSITIVITY_AUTO
	GTK_SENSITIVITY_ON
	GTK_SENSITIVITY_OFF
end enum

type GtkSideType as long
enum
	GTK_SIDE_TOP
	GTK_SIDE_BOTTOM
	GTK_SIDE_LEFT
	GTK_SIDE_RIGHT
end enum

type GtkTextDirection as long
enum
	GTK_TEXT_DIR_NONE
	GTK_TEXT_DIR_LTR
	GTK_TEXT_DIR_RTL
end enum

type GtkJustification as long
enum
	GTK_JUSTIFY_LEFT
	GTK_JUSTIFY_RIGHT
	GTK_JUSTIFY_CENTER
	GTK_JUSTIFY_FILL
end enum

type GtkMatchType as long
enum
	GTK_MATCH_ALL
	GTK_MATCH_ALL_TAIL
	GTK_MATCH_HEAD
	GTK_MATCH_TAIL
	GTK_MATCH_EXACT
	GTK_MATCH_LAST
end enum

type GtkMenuDirectionType as long
enum
	GTK_MENU_DIR_PARENT
	GTK_MENU_DIR_CHILD
	GTK_MENU_DIR_NEXT
	GTK_MENU_DIR_PREV
end enum

type GtkMessageType as long
enum
	GTK_MESSAGE_INFO
	GTK_MESSAGE_WARNING
	GTK_MESSAGE_QUESTION
	GTK_MESSAGE_ERROR
	GTK_MESSAGE_OTHER
end enum

type GtkMetricType as long
enum
	GTK_PIXELS
	GTK_INCHES
	GTK_CENTIMETERS
end enum

type GtkMovementStep as long
enum
	GTK_MOVEMENT_LOGICAL_POSITIONS
	GTK_MOVEMENT_VISUAL_POSITIONS
	GTK_MOVEMENT_WORDS
	GTK_MOVEMENT_DISPLAY_LINES
	GTK_MOVEMENT_DISPLAY_LINE_ENDS
	GTK_MOVEMENT_PARAGRAPHS
	GTK_MOVEMENT_PARAGRAPH_ENDS
	GTK_MOVEMENT_PAGES
	GTK_MOVEMENT_BUFFER_ENDS
	GTK_MOVEMENT_HORIZONTAL_PAGES
end enum

type GtkScrollStep as long
enum
	GTK_SCROLL_STEPS
	GTK_SCROLL_PAGES
	GTK_SCROLL_ENDS
	GTK_SCROLL_HORIZONTAL_STEPS
	GTK_SCROLL_HORIZONTAL_PAGES
	GTK_SCROLL_HORIZONTAL_ENDS
end enum

type GtkOrientation as long
enum
	GTK_ORIENTATION_HORIZONTAL
	GTK_ORIENTATION_VERTICAL
end enum

type GtkCornerType as long
enum
	GTK_CORNER_TOP_LEFT
	GTK_CORNER_BOTTOM_LEFT
	GTK_CORNER_TOP_RIGHT
	GTK_CORNER_BOTTOM_RIGHT
end enum

type GtkPackType as long
enum
	GTK_PACK_START
	GTK_PACK_END
end enum

type GtkPathPriorityType as long
enum
	GTK_PATH_PRIO_LOWEST = 0
	GTK_PATH_PRIO_GTK = 4
	GTK_PATH_PRIO_APPLICATION = 8
	GTK_PATH_PRIO_THEME = 10
	GTK_PATH_PRIO_RC = 12
	GTK_PATH_PRIO_HIGHEST = 15
end enum

const GTK_PATH_PRIO_MASK = &h0f

type GtkPathType as long
enum
	GTK_PATH_WIDGET
	GTK_PATH_WIDGET_CLASS
	GTK_PATH_CLASS
end enum

type GtkPolicyType as long
enum
	GTK_POLICY_ALWAYS
	GTK_POLICY_AUTOMATIC
	GTK_POLICY_NEVER
end enum

type GtkPositionType as long
enum
	GTK_POS_LEFT
	GTK_POS_RIGHT
	GTK_POS_TOP
	GTK_POS_BOTTOM
end enum

type GtkPreviewType as long
enum
	GTK_PREVIEW_COLOR
	GTK_PREVIEW_GRAYSCALE
end enum

type GtkReliefStyle as long
enum
	GTK_RELIEF_NORMAL
	GTK_RELIEF_HALF
	GTK_RELIEF_NONE
end enum

type GtkResizeMode as long
enum
	GTK_RESIZE_PARENT
	GTK_RESIZE_QUEUE
	GTK_RESIZE_IMMEDIATE
end enum

type GtkSignalRunType as long
enum
	GTK_RUN_FIRST = G_SIGNAL_RUN_FIRST
	GTK_RUN_LAST = G_SIGNAL_RUN_LAST
	GTK_RUN_BOTH = GTK_RUN_FIRST or GTK_RUN_LAST
	GTK_RUN_NO_RECURSE = G_SIGNAL_NO_RECURSE
	GTK_RUN_ACTION = G_SIGNAL_ACTION
	GTK_RUN_NO_HOOKS = G_SIGNAL_NO_HOOKS
end enum

type GtkScrollType as long
enum
	GTK_SCROLL_NONE
	GTK_SCROLL_JUMP
	GTK_SCROLL_STEP_BACKWARD
	GTK_SCROLL_STEP_FORWARD
	GTK_SCROLL_PAGE_BACKWARD
	GTK_SCROLL_PAGE_FORWARD
	GTK_SCROLL_STEP_UP
	GTK_SCROLL_STEP_DOWN
	GTK_SCROLL_PAGE_UP
	GTK_SCROLL_PAGE_DOWN
	GTK_SCROLL_STEP_LEFT
	GTK_SCROLL_STEP_RIGHT
	GTK_SCROLL_PAGE_LEFT
	GTK_SCROLL_PAGE_RIGHT
	GTK_SCROLL_START
	GTK_SCROLL_END
end enum

type GtkSelectionMode as long
enum
	GTK_SELECTION_NONE
	GTK_SELECTION_SINGLE
	GTK_SELECTION_BROWSE
	GTK_SELECTION_MULTIPLE
	GTK_SELECTION_EXTENDED = GTK_SELECTION_MULTIPLE
end enum

type GtkShadowType as long
enum
	GTK_SHADOW_NONE
	GTK_SHADOW_IN
	GTK_SHADOW_OUT
	GTK_SHADOW_ETCHED_IN
	GTK_SHADOW_ETCHED_OUT
end enum

type GtkStateType as long
enum
	GTK_STATE_NORMAL
	GTK_STATE_ACTIVE
	GTK_STATE_PRELIGHT
	GTK_STATE_SELECTED
	GTK_STATE_INSENSITIVE
end enum

type GtkSubmenuDirection as long
enum
	GTK_DIRECTION_LEFT
	GTK_DIRECTION_RIGHT
end enum

type GtkSubmenuPlacement as long
enum
	GTK_TOP_BOTTOM
	GTK_LEFT_RIGHT
end enum

type GtkToolbarStyle as long
enum
	GTK_TOOLBAR_ICONS
	GTK_TOOLBAR_TEXT
	GTK_TOOLBAR_BOTH
	GTK_TOOLBAR_BOTH_HORIZ
end enum

type GtkUpdateType as long
enum
	GTK_UPDATE_CONTINUOUS
	GTK_UPDATE_DISCONTINUOUS
	GTK_UPDATE_DELAYED
end enum

type GtkVisibility as long
enum
	GTK_VISIBILITY_NONE
	GTK_VISIBILITY_PARTIAL
	GTK_VISIBILITY_FULL
end enum

type GtkWindowPosition as long
enum
	GTK_WIN_POS_NONE
	GTK_WIN_POS_CENTER
	GTK_WIN_POS_MOUSE
	GTK_WIN_POS_CENTER_ALWAYS
	GTK_WIN_POS_CENTER_ON_PARENT
end enum

type GtkWindowType as long
enum
	GTK_WINDOW_TOPLEVEL
	GTK_WINDOW_POPUP
end enum

type GtkWrapMode as long
enum
	GTK_WRAP_NONE
	GTK_WRAP_CHAR
	GTK_WRAP_WORD
	GTK_WRAP_WORD_CHAR
end enum

type GtkSortType as long
enum
	GTK_SORT_ASCENDING
	GTK_SORT_DESCENDING
end enum

type GtkIMPreeditStyle as long
enum
	GTK_IM_PREEDIT_NOTHING
	GTK_IM_PREEDIT_CALLBACK
	GTK_IM_PREEDIT_NONE
end enum

type GtkIMStatusStyle as long
enum
	GTK_IM_STATUS_NOTHING
	GTK_IM_STATUS_CALLBACK
	GTK_IM_STATUS_NONE
end enum

type GtkPackDirection as long
enum
	GTK_PACK_DIRECTION_LTR
	GTK_PACK_DIRECTION_RTL
	GTK_PACK_DIRECTION_TTB
	GTK_PACK_DIRECTION_BTT
end enum

type GtkPrintPages as long
enum
	GTK_PRINT_PAGES_ALL
	GTK_PRINT_PAGES_CURRENT
	GTK_PRINT_PAGES_RANGES
	GTK_PRINT_PAGES_SELECTION
end enum

type GtkPageSet as long
enum
	GTK_PAGE_SET_ALL
	GTK_PAGE_SET_EVEN
	GTK_PAGE_SET_ODD
end enum

type GtkNumberUpLayout as long
enum
	GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_TOP_TO_BOTTOM
	GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_BOTTOM_TO_TOP
	GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_TOP_TO_BOTTOM
	GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_BOTTOM_TO_TOP
	GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_LEFT_TO_RIGHT
	GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_RIGHT_TO_LEFT
	GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_LEFT_TO_RIGHT
	GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_RIGHT_TO_LEFT
end enum

type GtkPageOrientation as long
enum
	GTK_PAGE_ORIENTATION_PORTRAIT
	GTK_PAGE_ORIENTATION_LANDSCAPE
	GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT
	GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE
end enum

type GtkPrintQuality as long
enum
	GTK_PRINT_QUALITY_LOW
	GTK_PRINT_QUALITY_NORMAL
	GTK_PRINT_QUALITY_HIGH
	GTK_PRINT_QUALITY_DRAFT
end enum

type GtkPrintDuplex as long
enum
	GTK_PRINT_DUPLEX_SIMPLEX
	GTK_PRINT_DUPLEX_HORIZONTAL
	GTK_PRINT_DUPLEX_VERTICAL
end enum

type GtkUnit as long
enum
	GTK_UNIT_PIXEL
	GTK_UNIT_POINTS
	GTK_UNIT_INCH
	GTK_UNIT_MM
end enum

type GtkTreeViewGridLines as long
enum
	GTK_TREE_VIEW_GRID_LINES_NONE
	GTK_TREE_VIEW_GRID_LINES_HORIZONTAL
	GTK_TREE_VIEW_GRID_LINES_VERTICAL
	GTK_TREE_VIEW_GRID_LINES_BOTH
end enum

type GtkDragResult as long
enum
	GTK_DRAG_RESULT_SUCCESS
	GTK_DRAG_RESULT_NO_TARGET
	GTK_DRAG_RESULT_USER_CANCELLED
	GTK_DRAG_RESULT_TIMEOUT_EXPIRED
	GTK_DRAG_RESULT_GRAB_BROKEN
	GTK_DRAG_RESULT_ERROR
end enum

#define GTK_TYPE_ACCEL_GROUP gtk_accel_group_get_type()
#define GTK_ACCEL_GROUP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_ACCEL_GROUP, GtkAccelGroup)
#define GTK_ACCEL_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACCEL_GROUP, GtkAccelGroupClass)
#define GTK_IS_ACCEL_GROUP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_ACCEL_GROUP)
#define GTK_IS_ACCEL_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACCEL_GROUP)
#define GTK_ACCEL_GROUP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACCEL_GROUP, GtkAccelGroupClass)

type GtkAccelFlags as long
enum
	GTK_ACCEL_VISIBLE = 1 shl 0
	GTK_ACCEL_LOCKED = 1 shl 1
	GTK_ACCEL_MASK = &h07
end enum

type GtkAccelGroup as _GtkAccelGroup
type GtkAccelGroupClass as _GtkAccelGroupClass
type GtkAccelKey as _GtkAccelKey
type GtkAccelGroupEntry as _GtkAccelGroupEntry
type GtkAccelGroupActivate as function(byval accel_group as GtkAccelGroup ptr, byval acceleratable as GObject ptr, byval keyval as guint, byval modifier as GdkModifierType) as gboolean
type GtkAccelGroupFindFunc as function(byval key as GtkAccelKey ptr, byval closure as GClosure ptr, byval data as gpointer) as gboolean

type _GtkAccelGroup
	parent as GObject
	lock_count as guint
	modifier_mask as GdkModifierType
	acceleratables as GSList ptr
	n_accels as guint
	priv_accels as GtkAccelGroupEntry ptr
end type

type _GtkAccelGroupClass
	parent_class as GObjectClass
	accel_changed as sub(byval accel_group as GtkAccelGroup ptr, byval keyval as guint, byval modifier as GdkModifierType, byval accel_closure as GClosure ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkAccelKey
	accel_key as guint
	accel_mods as GdkModifierType
	accel_flags : 16 as guint
end type

declare function gtk_accel_group_get_type() as GType
declare function gtk_accel_group_new() as GtkAccelGroup ptr
declare function gtk_accel_group_get_is_locked(byval accel_group as GtkAccelGroup ptr) as gboolean
declare function gtk_accel_group_get_modifier_mask(byval accel_group as GtkAccelGroup ptr) as GdkModifierType
declare sub gtk_accel_group_lock(byval accel_group as GtkAccelGroup ptr)
declare sub gtk_accel_group_unlock(byval accel_group as GtkAccelGroup ptr)
declare sub gtk_accel_group_connect(byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval accel_flags as GtkAccelFlags, byval closure as GClosure ptr)
declare sub gtk_accel_group_connect_by_path(byval accel_group as GtkAccelGroup ptr, byval accel_path as const gchar ptr, byval closure as GClosure ptr)
declare function gtk_accel_group_disconnect(byval accel_group as GtkAccelGroup ptr, byval closure as GClosure ptr) as gboolean
declare function gtk_accel_group_disconnect_key(byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare function gtk_accel_group_activate(byval accel_group as GtkAccelGroup ptr, byval accel_quark as GQuark, byval acceleratable as GObject ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare sub _gtk_accel_group_attach(byval accel_group as GtkAccelGroup ptr, byval object as GObject ptr)
declare sub _gtk_accel_group_detach(byval accel_group as GtkAccelGroup ptr, byval object as GObject ptr)
declare function gtk_accel_groups_activate(byval object as GObject ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare function gtk_accel_groups_from_object(byval object as GObject ptr) as GSList ptr
declare function gtk_accel_group_find(byval accel_group as GtkAccelGroup ptr, byval find_func as GtkAccelGroupFindFunc, byval data as gpointer) as GtkAccelKey ptr
declare function gtk_accel_group_from_accel_closure(byval closure as GClosure ptr) as GtkAccelGroup ptr
declare function gtk_accelerator_valid(byval keyval as guint, byval modifiers as GdkModifierType) as gboolean
declare sub gtk_accelerator_parse(byval accelerator as const gchar ptr, byval accelerator_key as guint ptr, byval accelerator_mods as GdkModifierType ptr)
declare function gtk_accelerator_name(byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as gchar ptr
declare function gtk_accelerator_get_label(byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as gchar ptr
declare sub gtk_accelerator_set_default_mod_mask(byval default_mod_mask as GdkModifierType)
declare function gtk_accelerator_get_default_mod_mask() as guint
declare function gtk_accel_group_query(byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval n_entries as guint ptr) as GtkAccelGroupEntry ptr
declare sub _gtk_accel_group_reconnect(byval accel_group as GtkAccelGroup ptr, byval accel_path_quark as GQuark)

type _GtkAccelGroupEntry
	key as GtkAccelKey
	closure as GClosure ptr
	accel_path_quark as GQuark
end type

declare function gtk_accel_group_ref alias "g_object_ref"(byval object as gpointer) as gpointer
declare sub gtk_accel_group_unref alias "g_object_unref"(byval object as gpointer)
#define __GTK_BIN_H__
#define __GTK_CONTAINER_H__
#define __GTK_WIDGET_H__
#define __GTK_OBJECT_H__
#define __GTK_TYPE_UTILS_H__
#define __GTK_TYPE_BUILTINS_H__
declare function gtk_accel_flags_get_type() as GType
#define GTK_TYPE_ACCEL_FLAGS gtk_accel_flags_get_type()
declare function gtk_assistant_page_type_get_type() as GType
#define GTK_TYPE_ASSISTANT_PAGE_TYPE gtk_assistant_page_type_get_type()
declare function gtk_builder_error_get_type() as GType
#define GTK_TYPE_BUILDER_ERROR gtk_builder_error_get_type()
declare function gtk_calendar_display_options_get_type() as GType
#define GTK_TYPE_CALENDAR_DISPLAY_OPTIONS gtk_calendar_display_options_get_type()
declare function gtk_cell_renderer_state_get_type() as GType
#define GTK_TYPE_CELL_RENDERER_STATE gtk_cell_renderer_state_get_type()
declare function gtk_cell_renderer_mode_get_type() as GType
#define GTK_TYPE_CELL_RENDERER_MODE gtk_cell_renderer_mode_get_type()
declare function gtk_cell_renderer_accel_mode_get_type() as GType
#define GTK_TYPE_CELL_RENDERER_ACCEL_MODE gtk_cell_renderer_accel_mode_get_type()
declare function gtk_debug_flag_get_type() as GType
#define GTK_TYPE_DEBUG_FLAG gtk_debug_flag_get_type()
declare function gtk_dialog_flags_get_type() as GType
#define GTK_TYPE_DIALOG_FLAGS gtk_dialog_flags_get_type()
declare function gtk_response_type_get_type() as GType
#define GTK_TYPE_RESPONSE_TYPE gtk_response_type_get_type()
declare function gtk_dest_defaults_get_type() as GType
#define GTK_TYPE_DEST_DEFAULTS gtk_dest_defaults_get_type()
declare function gtk_target_flags_get_type() as GType
#define GTK_TYPE_TARGET_FLAGS gtk_target_flags_get_type()
declare function gtk_entry_icon_position_get_type() as GType
#define GTK_TYPE_ENTRY_ICON_POSITION gtk_entry_icon_position_get_type()
declare function gtk_anchor_type_get_type() as GType
#define GTK_TYPE_ANCHOR_TYPE gtk_anchor_type_get_type()
declare function gtk_arrow_placement_get_type() as GType
#define GTK_TYPE_ARROW_PLACEMENT gtk_arrow_placement_get_type()
declare function gtk_arrow_type_get_type() as GType
#define GTK_TYPE_ARROW_TYPE gtk_arrow_type_get_type()
declare function gtk_attach_options_get_type() as GType
#define GTK_TYPE_ATTACH_OPTIONS gtk_attach_options_get_type()
declare function gtk_button_box_style_get_type() as GType
#define GTK_TYPE_BUTTON_BOX_STYLE gtk_button_box_style_get_type()
declare function gtk_curve_type_get_type() as GType
#define GTK_TYPE_CURVE_TYPE gtk_curve_type_get_type()
declare function gtk_delete_type_get_type() as GType
#define GTK_TYPE_DELETE_TYPE gtk_delete_type_get_type()
declare function gtk_direction_type_get_type() as GType
#define GTK_TYPE_DIRECTION_TYPE gtk_direction_type_get_type()
declare function gtk_expander_style_get_type() as GType
#define GTK_TYPE_EXPANDER_STYLE gtk_expander_style_get_type()
declare function gtk_icon_size_get_type() as GType
#define GTK_TYPE_ICON_SIZE gtk_icon_size_get_type()
declare function gtk_sensitivity_type_get_type() as GType
#define GTK_TYPE_SENSITIVITY_TYPE gtk_sensitivity_type_get_type()
declare function gtk_side_type_get_type() as GType
#define GTK_TYPE_SIDE_TYPE gtk_side_type_get_type()
declare function gtk_text_direction_get_type() as GType
#define GTK_TYPE_TEXT_DIRECTION gtk_text_direction_get_type()
declare function gtk_justification_get_type() as GType
#define GTK_TYPE_JUSTIFICATION gtk_justification_get_type()
declare function gtk_match_type_get_type() as GType
#define GTK_TYPE_MATCH_TYPE gtk_match_type_get_type()
declare function gtk_menu_direction_type_get_type() as GType
#define GTK_TYPE_MENU_DIRECTION_TYPE gtk_menu_direction_type_get_type()
declare function gtk_message_type_get_type() as GType
#define GTK_TYPE_MESSAGE_TYPE gtk_message_type_get_type()
declare function gtk_metric_type_get_type() as GType
#define GTK_TYPE_METRIC_TYPE gtk_metric_type_get_type()
declare function gtk_movement_step_get_type() as GType
#define GTK_TYPE_MOVEMENT_STEP gtk_movement_step_get_type()
declare function gtk_scroll_step_get_type() as GType
#define GTK_TYPE_SCROLL_STEP gtk_scroll_step_get_type()
declare function gtk_orientation_get_type() as GType
#define GTK_TYPE_ORIENTATION gtk_orientation_get_type()
declare function gtk_corner_type_get_type() as GType
#define GTK_TYPE_CORNER_TYPE gtk_corner_type_get_type()
declare function gtk_pack_type_get_type() as GType
#define GTK_TYPE_PACK_TYPE gtk_pack_type_get_type()
declare function gtk_path_priority_type_get_type() as GType
#define GTK_TYPE_PATH_PRIORITY_TYPE gtk_path_priority_type_get_type()
declare function gtk_path_type_get_type() as GType
#define GTK_TYPE_PATH_TYPE gtk_path_type_get_type()
declare function gtk_policy_type_get_type() as GType
#define GTK_TYPE_POLICY_TYPE gtk_policy_type_get_type()
declare function gtk_position_type_get_type() as GType
#define GTK_TYPE_POSITION_TYPE gtk_position_type_get_type()
declare function gtk_preview_type_get_type() as GType
#define GTK_TYPE_PREVIEW_TYPE gtk_preview_type_get_type()
declare function gtk_relief_style_get_type() as GType
#define GTK_TYPE_RELIEF_STYLE gtk_relief_style_get_type()
declare function gtk_resize_mode_get_type() as GType
#define GTK_TYPE_RESIZE_MODE gtk_resize_mode_get_type()
declare function gtk_signal_run_type_get_type() as GType
#define GTK_TYPE_SIGNAL_RUN_TYPE gtk_signal_run_type_get_type()
declare function gtk_scroll_type_get_type() as GType
#define GTK_TYPE_SCROLL_TYPE gtk_scroll_type_get_type()
declare function gtk_selection_mode_get_type() as GType
#define GTK_TYPE_SELECTION_MODE gtk_selection_mode_get_type()
declare function gtk_shadow_type_get_type() as GType
#define GTK_TYPE_SHADOW_TYPE gtk_shadow_type_get_type()
declare function gtk_state_type_get_type() as GType
#define GTK_TYPE_STATE_TYPE gtk_state_type_get_type()
declare function gtk_submenu_direction_get_type() as GType
#define GTK_TYPE_SUBMENU_DIRECTION gtk_submenu_direction_get_type()
declare function gtk_submenu_placement_get_type() as GType
#define GTK_TYPE_SUBMENU_PLACEMENT gtk_submenu_placement_get_type()
declare function gtk_toolbar_style_get_type() as GType
#define GTK_TYPE_TOOLBAR_STYLE gtk_toolbar_style_get_type()
declare function gtk_update_type_get_type() as GType
#define GTK_TYPE_UPDATE_TYPE gtk_update_type_get_type()
declare function gtk_visibility_get_type() as GType
#define GTK_TYPE_VISIBILITY gtk_visibility_get_type()
declare function gtk_window_position_get_type() as GType
#define GTK_TYPE_WINDOW_POSITION gtk_window_position_get_type()
declare function gtk_window_type_get_type() as GType
#define GTK_TYPE_WINDOW_TYPE gtk_window_type_get_type()
declare function gtk_wrap_mode_get_type() as GType
#define GTK_TYPE_WRAP_MODE gtk_wrap_mode_get_type()
declare function gtk_sort_type_get_type() as GType
#define GTK_TYPE_SORT_TYPE gtk_sort_type_get_type()
declare function gtk_im_preedit_style_get_type() as GType
#define GTK_TYPE_IM_PREEDIT_STYLE gtk_im_preedit_style_get_type()
declare function gtk_im_status_style_get_type() as GType
#define GTK_TYPE_IM_STATUS_STYLE gtk_im_status_style_get_type()
declare function gtk_pack_direction_get_type() as GType
#define GTK_TYPE_PACK_DIRECTION gtk_pack_direction_get_type()
declare function gtk_print_pages_get_type() as GType
#define GTK_TYPE_PRINT_PAGES gtk_print_pages_get_type()
declare function gtk_page_set_get_type() as GType
#define GTK_TYPE_PAGE_SET gtk_page_set_get_type()
declare function gtk_number_up_layout_get_type() as GType
#define GTK_TYPE_NUMBER_UP_LAYOUT gtk_number_up_layout_get_type()
declare function gtk_page_orientation_get_type() as GType
#define GTK_TYPE_PAGE_ORIENTATION gtk_page_orientation_get_type()
declare function gtk_print_quality_get_type() as GType
#define GTK_TYPE_PRINT_QUALITY gtk_print_quality_get_type()
declare function gtk_print_duplex_get_type() as GType
#define GTK_TYPE_PRINT_DUPLEX gtk_print_duplex_get_type()
declare function gtk_unit_get_type() as GType
#define GTK_TYPE_UNIT gtk_unit_get_type()
declare function gtk_tree_view_grid_lines_get_type() as GType
#define GTK_TYPE_TREE_VIEW_GRID_LINES gtk_tree_view_grid_lines_get_type()
declare function gtk_drag_result_get_type() as GType
#define GTK_TYPE_DRAG_RESULT gtk_drag_result_get_type()
declare function gtk_file_chooser_action_get_type() as GType
#define GTK_TYPE_FILE_CHOOSER_ACTION gtk_file_chooser_action_get_type()
declare function gtk_file_chooser_confirmation_get_type() as GType
#define GTK_TYPE_FILE_CHOOSER_CONFIRMATION gtk_file_chooser_confirmation_get_type()
declare function gtk_file_chooser_error_get_type() as GType
#define GTK_TYPE_FILE_CHOOSER_ERROR gtk_file_chooser_error_get_type()
declare function gtk_file_filter_flags_get_type() as GType
#define GTK_TYPE_FILE_FILTER_FLAGS gtk_file_filter_flags_get_type()
declare function gtk_icon_lookup_flags_get_type() as GType
#define GTK_TYPE_ICON_LOOKUP_FLAGS gtk_icon_lookup_flags_get_type()
declare function gtk_icon_theme_error_get_type() as GType
#define GTK_TYPE_ICON_THEME_ERROR gtk_icon_theme_error_get_type()
declare function gtk_icon_view_drop_position_get_type() as GType
#define GTK_TYPE_ICON_VIEW_DROP_POSITION gtk_icon_view_drop_position_get_type()
declare function gtk_image_type_get_type() as GType
#define GTK_TYPE_IMAGE_TYPE gtk_image_type_get_type()
declare function gtk_buttons_type_get_type() as GType
#define GTK_TYPE_BUTTONS_TYPE gtk_buttons_type_get_type()
declare function gtk_notebook_tab_get_type() as GType
#define GTK_TYPE_NOTEBOOK_TAB gtk_notebook_tab_get_type()
declare function gtk_object_flags_get_type() as GType
#define GTK_TYPE_OBJECT_FLAGS gtk_object_flags_get_type()
declare function gtk_arg_flags_get_type() as GType
#define GTK_TYPE_ARG_FLAGS gtk_arg_flags_get_type()
declare function gtk_print_status_get_type() as GType
#define GTK_TYPE_PRINT_STATUS gtk_print_status_get_type()
declare function gtk_print_operation_result_get_type() as GType
#define GTK_TYPE_PRINT_OPERATION_RESULT gtk_print_operation_result_get_type()
declare function gtk_print_operation_action_get_type() as GType
#define GTK_TYPE_PRINT_OPERATION_ACTION gtk_print_operation_action_get_type()
declare function gtk_print_error_get_type() as GType
#define GTK_TYPE_PRINT_ERROR gtk_print_error_get_type()
declare function gtk_private_flags_get_type() as GType
#define GTK_TYPE_PRIVATE_FLAGS gtk_private_flags_get_type()
declare function gtk_progress_bar_style_get_type() as GType
#define GTK_TYPE_PROGRESS_BAR_STYLE gtk_progress_bar_style_get_type()
declare function gtk_progress_bar_orientation_get_type() as GType
#define GTK_TYPE_PROGRESS_BAR_ORIENTATION gtk_progress_bar_orientation_get_type()
declare function gtk_rc_flags_get_type() as GType
#define GTK_TYPE_RC_FLAGS gtk_rc_flags_get_type()
declare function gtk_rc_token_type_get_type() as GType
#define GTK_TYPE_RC_TOKEN_TYPE gtk_rc_token_type_get_type()
declare function gtk_recent_sort_type_get_type() as GType
#define GTK_TYPE_RECENT_SORT_TYPE gtk_recent_sort_type_get_type()
declare function gtk_recent_chooser_error_get_type() as GType
#define GTK_TYPE_RECENT_CHOOSER_ERROR gtk_recent_chooser_error_get_type()
declare function gtk_recent_filter_flags_get_type() as GType
#define GTK_TYPE_RECENT_FILTER_FLAGS gtk_recent_filter_flags_get_type()
declare function gtk_recent_manager_error_get_type() as GType
#define GTK_TYPE_RECENT_MANAGER_ERROR gtk_recent_manager_error_get_type()
declare function gtk_size_group_mode_get_type() as GType
#define GTK_TYPE_SIZE_GROUP_MODE gtk_size_group_mode_get_type()
declare function gtk_spin_button_update_policy_get_type() as GType
#define GTK_TYPE_SPIN_BUTTON_UPDATE_POLICY gtk_spin_button_update_policy_get_type()
declare function gtk_spin_type_get_type() as GType
#define GTK_TYPE_SPIN_TYPE gtk_spin_type_get_type()
declare function gtk_text_buffer_target_info_get_type() as GType
#define GTK_TYPE_TEXT_BUFFER_TARGET_INFO gtk_text_buffer_target_info_get_type()
declare function gtk_text_search_flags_get_type() as GType
#define GTK_TYPE_TEXT_SEARCH_FLAGS gtk_text_search_flags_get_type()
declare function gtk_text_window_type_get_type() as GType
#define GTK_TYPE_TEXT_WINDOW_TYPE gtk_text_window_type_get_type()
declare function gtk_toolbar_child_type_get_type() as GType
#define GTK_TYPE_TOOLBAR_CHILD_TYPE gtk_toolbar_child_type_get_type()
declare function gtk_toolbar_space_style_get_type() as GType
#define GTK_TYPE_TOOLBAR_SPACE_STYLE gtk_toolbar_space_style_get_type()
declare function gtk_tool_palette_drag_targets_get_type() as GType
#define GTK_TYPE_TOOL_PALETTE_DRAG_TARGETS gtk_tool_palette_drag_targets_get_type()
declare function gtk_tree_model_flags_get_type() as GType
#define GTK_TYPE_TREE_MODEL_FLAGS gtk_tree_model_flags_get_type()
declare function gtk_tree_view_drop_position_get_type() as GType
#define GTK_TYPE_TREE_VIEW_DROP_POSITION gtk_tree_view_drop_position_get_type()
declare function gtk_tree_view_column_sizing_get_type() as GType
#define GTK_TYPE_TREE_VIEW_COLUMN_SIZING gtk_tree_view_column_sizing_get_type()
declare function gtk_ui_manager_item_type_get_type() as GType
#define GTK_TYPE_UI_MANAGER_ITEM_TYPE gtk_ui_manager_item_type_get_type()
declare function gtk_widget_flags_get_type() as GType
#define GTK_TYPE_WIDGET_FLAGS gtk_widget_flags_get_type()
declare function gtk_widget_help_type_get_type() as GType
#define GTK_TYPE_WIDGET_HELP_TYPE gtk_widget_help_type_get_type()
declare function gtk_tree_view_mode_get_type() as GType
#define GTK_TYPE_TREE_VIEW_MODE gtk_tree_view_mode_get_type()
declare function gtk_cell_type_get_type() as GType
#define GTK_TYPE_CELL_TYPE gtk_cell_type_get_type()
declare function gtk_clist_drag_pos_get_type() as GType
#define GTK_TYPE_CLIST_DRAG_POS gtk_clist_drag_pos_get_type()
declare function gtk_button_action_get_type() as GType
#define GTK_TYPE_BUTTON_ACTION gtk_button_action_get_type()
declare function gtk_ctree_pos_get_type() as GType
#define GTK_TYPE_CTREE_POS gtk_ctree_pos_get_type()
declare function gtk_ctree_line_style_get_type() as GType
#define GTK_TYPE_CTREE_LINE_STYLE gtk_ctree_line_style_get_type()
declare function gtk_ctree_expander_style_get_type() as GType
#define GTK_TYPE_CTREE_EXPANDER_STYLE gtk_ctree_expander_style_get_type()
declare function gtk_ctree_expansion_type_get_type() as GType
#define GTK_TYPE_CTREE_EXPANSION_TYPE gtk_ctree_expansion_type_get_type()
#define GTK_TYPE_IDENTIFIER gtk_identifier_get_type()
declare function gtk_identifier_get_type() as GType

type GtkArg as _GtkArg
type GtkObject as _GtkObject
type GtkFunction as function(byval data as gpointer) as gboolean
type GtkCallbackMarshal as sub(byval object as GtkObject ptr, byval data as gpointer, byval n_args as guint, byval args as GtkArg ptr)
type GtkTranslateFunc as function(byval path as const gchar ptr, byval func_data as gpointer) as gchar ptr

#define GTK_TYPE_INVALID G_TYPE_INVALID
#define GTK_TYPE_NONE G_TYPE_NONE
#define GTK_TYPE_ENUM G_TYPE_ENUM
#define GTK_TYPE_FLAGS G_TYPE_FLAGS
#define GTK_TYPE_CHAR G_TYPE_CHAR
#define GTK_TYPE_UCHAR G_TYPE_UCHAR
#define GTK_TYPE_BOOL G_TYPE_BOOLEAN
#define GTK_TYPE_INT G_TYPE_INT
#define GTK_TYPE_UINT G_TYPE_UINT
#define GTK_TYPE_LONG G_TYPE_LONG
#define GTK_TYPE_ULONG G_TYPE_ULONG
#define GTK_TYPE_FLOAT G_TYPE_FLOAT
#define GTK_TYPE_DOUBLE G_TYPE_DOUBLE
#define GTK_TYPE_STRING G_TYPE_STRING
#define GTK_TYPE_BOXED G_TYPE_BOXED
#define GTK_TYPE_POINTER G_TYPE_POINTER
type GtkFundamentalType as GType
#define GTK_CLASS_NAME(class) g_type_name(G_TYPE_FROM_CLASS(class))
#define GTK_CLASS_TYPE(class) G_TYPE_FROM_CLASS(class)
#define GTK_TYPE_IS_OBJECT(type) g_type_is_a((type), GTK_TYPE_OBJECT)
#define GTK_TYPE_FUNDAMENTAL_LAST (G_TYPE_LAST_RESERVED_FUNDAMENTAL - 1)
#define GTK_TYPE_FUNDAMENTAL_MAX G_TYPE_FUNDAMENTAL_MAX
#define GTK_FUNDAMENTAL_TYPE G_TYPE_FUNDAMENTAL
#define GTK_STRUCT_OFFSET G_STRUCT_OFFSET
#define GTK_CHECK_CAST G_TYPE_CHECK_INSTANCE_CAST
#define GTK_CHECK_CLASS_CAST G_TYPE_CHECK_CLASS_CAST
#define GTK_CHECK_GET_CLASS G_TYPE_INSTANCE_GET_CLASS
#define GTK_CHECK_TYPE G_TYPE_CHECK_INSTANCE_TYPE
#define GTK_CHECK_CLASS_TYPE G_TYPE_CHECK_CLASS_TYPE

type GtkType as GType
type GtkTypeObject as GTypeInstance
type GtkTypeClass as GTypeClass
type GtkClassInitFunc as GBaseInitFunc
type GtkObjectInitFunc as GInstanceInitFunc
type GtkSignalMarshaller as GSignalCMarshaller
type GtkDestroyNotify as sub(byval data as gpointer)
type GtkSignalFunc as sub()
#define GTK_SIGNAL_FUNC(f) G_CALLBACK(f)

type _GtkArg_d_signal_data
	f as GCallback
	d as gpointer
end type

union _GtkArg_d
	char_data as byte
	uchar_data as guchar
	bool_data as gboolean
	int_data as gint
	uint_data as guint
	long_data as glong
	ulong_data as gulong
	float_data as gfloat
	double_data as gdouble
	string_data as gchar ptr
	object_data as GtkObject ptr
	pointer_data as gpointer
	signal_data as _GtkArg_d_signal_data
end union

type _GtkArg
	as GType type
	name as gchar ptr
	d as _GtkArg_d
end type

#define GTK_VALUE_CHAR(a) (a).d.char_data
#define GTK_VALUE_UCHAR(a) (a).d.uchar_data
#define GTK_VALUE_BOOL(a) (a).d.bool_data
#define GTK_VALUE_INT(a) (a).d.int_data
#define GTK_VALUE_UINT(a) (a).d.uint_data
#define GTK_VALUE_LONG(a) (a).d.long_data
#define GTK_VALUE_ULONG(a) (a).d.ulong_data
#define GTK_VALUE_FLOAT(a) (a).d.float_data
#define GTK_VALUE_DOUBLE(a) (a).d.double_data
#define GTK_VALUE_STRING(a) (a).d.string_data
#define GTK_VALUE_ENUM(a) (a).d.int_data
#define GTK_VALUE_FLAGS(a) (a).d.uint_data
#define GTK_VALUE_BOXED(a) (a).d.pointer_data
#define GTK_VALUE_OBJECT(a) (a).d.object_data
#define GTK_VALUE_POINTER(a) (a).d.pointer_data
#define GTK_VALUE_SIGNAL(a) (a).d.signal_data
#define GTK_RETLOC_CHAR(a) cptr(gchar ptr, (a).d.pointer_data)
#define GTK_RETLOC_UCHAR(a) cptr(guchar ptr, (a).d.pointer_data)
#define GTK_RETLOC_BOOL(a) cptr(gboolean ptr, (a).d.pointer_data)
#define GTK_RETLOC_INT(a) cptr(gint ptr, (a).d.pointer_data)
#define GTK_RETLOC_UINT(a) cptr(guint ptr, (a).d.pointer_data)
#define GTK_RETLOC_LONG(a) cptr(glong ptr, (a).d.pointer_data)
#define GTK_RETLOC_ULONG(a) cptr(gulong ptr, (a).d.pointer_data)
#define GTK_RETLOC_FLOAT(a) cptr(gfloat ptr, (a).d.pointer_data)
#define GTK_RETLOC_DOUBLE(a) cptr(gdouble ptr, (a).d.pointer_data)
#define GTK_RETLOC_STRING(a) cptr(gchar ptr ptr, (a).d.pointer_data)
#define GTK_RETLOC_ENUM(a) cptr(gint ptr, (a).d.pointer_data)
#define GTK_RETLOC_FLAGS(a) cptr(guint ptr, (a).d.pointer_data)
#define GTK_RETLOC_BOXED(a) cptr(gpointer ptr, (a).d.pointer_data)
#define GTK_RETLOC_OBJECT(a) cptr(GtkObject ptr ptr, (a).d.pointer_data)
#define GTK_RETLOC_POINTER(a) cptr(gpointer ptr, (a).d.pointer_data)
type GtkTypeInfo as _GtkTypeInfo

type _GtkTypeInfo
	type_name as gchar ptr
	object_size as guint
	class_size as guint
	class_init_func as GtkClassInitFunc
	object_init_func as GtkObjectInitFunc
	reserved_1 as gpointer
	reserved_2 as gpointer
	base_class_init_func as GtkClassInitFunc
end type

declare sub gtk_type_init(byval debug_flags as GTypeDebugFlags)
declare function gtk_type_unique(byval parent_type as GtkType, byval gtkinfo as const GtkTypeInfo ptr) as GtkType
declare function gtk_type_class(byval type as GtkType) as gpointer
declare function gtk_type_new(byval type as GtkType) as gpointer

#define gtk_type_name(type) g_type_name(type)
#define gtk_type_from_name(name) g_type_from_name(name)
#define gtk_type_parent(type) g_type_parent(type)
#define gtk_type_is_a(type, is_a_type) g_type_is_a((type), (is_a_type))
type GtkEnumValue as GEnumValue
type GtkFlagValue as GFlagsValue

declare function gtk_type_enum_get_values(byval enum_type as GtkType) as GtkEnumValue ptr
declare function gtk_type_flags_get_values(byval flags_type as GtkType) as GtkFlagValue ptr
declare function gtk_type_enum_find_value(byval enum_type as GtkType, byval value_name as const gchar ptr) as GtkEnumValue ptr
declare function gtk_type_flags_find_value(byval flags_type as GtkType, byval value_name as const gchar ptr) as GtkFlagValue ptr
#define __GTK_DEBUG_H__

type GtkDebugFlag as long
enum
	GTK_DEBUG_MISC = 1 shl 0
	GTK_DEBUG_PLUGSOCKET = 1 shl 1
	GTK_DEBUG_TEXT = 1 shl 2
	GTK_DEBUG_TREE = 1 shl 3
	GTK_DEBUG_UPDATES = 1 shl 4
	GTK_DEBUG_KEYBINDINGS = 1 shl 5
	GTK_DEBUG_MULTIHEAD = 1 shl 6
	GTK_DEBUG_MODULES = 1 shl 7
	GTK_DEBUG_GEOMETRY = 1 shl 8
	GTK_DEBUG_ICONTHEME = 1 shl 9
	GTK_DEBUG_PRINTING = 1 shl 10
	GTK_DEBUG_BUILDER = 1 shl 11
end enum

#define GTK_NOTE(type, action)

#ifdef __FB_UNIX__
	extern gtk_debug_flags as guint
#else
	extern import gtk_debug_flags as guint
#endif

#define GTK_TYPE_OBJECT gtk_object_get_type()
#define GTK_OBJECT(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_OBJECT, GtkObject)
#define GTK_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_OBJECT, GtkObjectClass)
#define GTK_IS_OBJECT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_OBJECT)
#define GTK_IS_OBJECT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_OBJECT)
#define GTK_OBJECT_GET_CLASS(object) G_TYPE_INSTANCE_GET_CLASS((object), GTK_TYPE_OBJECT, GtkObjectClass)
#define GTK_OBJECT_TYPE G_OBJECT_TYPE
#define GTK_OBJECT_TYPE_NAME G_OBJECT_TYPE_NAME

type GtkObjectFlags as long
enum
	GTK_IN_DESTRUCTION = 1 shl 0
	GTK_FLOATING = 1 shl 1
	GTK_RESERVED_1 = 1 shl 2
	GTK_RESERVED_2 = 1 shl 3
end enum

#define GTK_OBJECT_FLAGS(obj) GTK_OBJECT(obj)->flags
#define GTK_OBJECT_FLOATING(obj) g_object_is_floating(obj)
#define GTK_OBJECT_SET_FLAGS(obj, flag) scope : GTK_OBJECT_FLAGS(obj) or= (flag) : end scope
#define GTK_OBJECT_UNSET_FLAGS(obj, flag) scope : GTK_OBJECT_FLAGS(obj) and= not (flag) : end scope
type GtkObjectClass as _GtkObjectClass

type _GtkObject
	parent_instance as GInitiallyUnowned
	flags as guint32
end type

type _GtkObjectClass
	parent_class as GInitiallyUnownedClass
	set_arg as sub(byval object as GtkObject ptr, byval arg as GtkArg ptr, byval arg_id as guint)
	get_arg as sub(byval object as GtkObject ptr, byval arg as GtkArg ptr, byval arg_id as guint)
	destroy as sub(byval object as GtkObject ptr)
end type

declare function gtk_object_get_type() as GType
declare sub gtk_object_sink(byval object as GtkObject ptr)
declare sub gtk_object_destroy(byval object as GtkObject ptr)
declare function gtk_object_new(byval type as GType, byval first_property_name as const gchar ptr, ...) as GtkObject ptr
declare function gtk_object_ref(byval object as GtkObject ptr) as GtkObject ptr
declare sub gtk_object_unref(byval object as GtkObject ptr)
declare sub gtk_object_weakref(byval object as GtkObject ptr, byval notify as GDestroyNotify, byval data as gpointer)
declare sub gtk_object_weakunref(byval object as GtkObject ptr, byval notify as GDestroyNotify, byval data as gpointer)
declare sub gtk_object_set_data(byval object as GtkObject ptr, byval key as const gchar ptr, byval data as gpointer)
declare sub gtk_object_set_data_full(byval object as GtkObject ptr, byval key as const gchar ptr, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_object_remove_data(byval object as GtkObject ptr, byval key as const gchar ptr)
declare function gtk_object_get_data(byval object as GtkObject ptr, byval key as const gchar ptr) as gpointer
declare sub gtk_object_remove_no_notify(byval object as GtkObject ptr, byval key as const gchar ptr)
declare sub gtk_object_set_user_data(byval object as GtkObject ptr, byval data as gpointer)
declare function gtk_object_get_user_data(byval object as GtkObject ptr) as gpointer
declare sub gtk_object_set_data_by_id(byval object as GtkObject ptr, byval data_id as GQuark, byval data as gpointer)
declare sub gtk_object_set_data_by_id_full(byval object as GtkObject ptr, byval data_id as GQuark, byval data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_object_get_data_by_id(byval object as GtkObject ptr, byval data_id as GQuark) as gpointer
declare sub gtk_object_remove_data_by_id(byval object as GtkObject ptr, byval data_id as GQuark)
declare sub gtk_object_remove_no_notify_by_id(byval object as GtkObject ptr, byval key_id as GQuark)
declare function gtk_object_data_try_key alias "g_quark_try_string"(byval string as const gchar ptr) as GQuark
declare function gtk_object_data_force_id alias "g_quark_from_string"(byval string as const gchar ptr) as GQuark

type GtkArgFlags as long
enum
	GTK_ARG_READABLE = G_PARAM_READABLE
	GTK_ARG_WRITABLE = G_PARAM_WRITABLE
	GTK_ARG_CONSTRUCT = G_PARAM_CONSTRUCT
	GTK_ARG_CONSTRUCT_ONLY = G_PARAM_CONSTRUCT_ONLY
	GTK_ARG_CHILD_ARG = 1 shl 4
end enum

const GTK_ARG_READWRITE = GTK_ARG_READABLE or GTK_ARG_WRITABLE
declare sub gtk_object_get(byval object as GtkObject ptr, byval first_property_name as const gchar ptr, ...)
declare sub gtk_object_set(byval object as GtkObject ptr, byval first_property_name as const gchar ptr, ...)
declare sub gtk_object_add_arg_type(byval arg_name as const gchar ptr, byval arg_type as GType, byval arg_flags as guint, byval arg_id as guint)

#define __GTK_ADJUSTMENT_H__
#define GTK_TYPE_ADJUSTMENT gtk_adjustment_get_type()
#define GTK_ADJUSTMENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustment)
#define GTK_ADJUSTMENT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass)
#define GTK_IS_ADJUSTMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ADJUSTMENT)
#define GTK_IS_ADJUSTMENT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ADJUSTMENT)
#define GTK_ADJUSTMENT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass)
type GtkAdjustment as _GtkAdjustment
type GtkAdjustmentClass as _GtkAdjustmentClass

type _GtkAdjustment
	parent_instance as GtkObject
	lower as gdouble
	upper as gdouble
	value as gdouble
	step_increment as gdouble
	page_increment as gdouble
	page_size as gdouble
end type

type _GtkAdjustmentClass
	parent_class as GtkObjectClass
	changed as sub(byval adjustment as GtkAdjustment ptr)
	value_changed as sub(byval adjustment as GtkAdjustment ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_adjustment_get_type() as GType
declare function gtk_adjustment_new(byval value as gdouble, byval lower as gdouble, byval upper as gdouble, byval step_increment as gdouble, byval page_increment as gdouble, byval page_size as gdouble) as GtkObject ptr
declare sub gtk_adjustment_changed(byval adjustment as GtkAdjustment ptr)
declare sub gtk_adjustment_value_changed(byval adjustment as GtkAdjustment ptr)
declare sub gtk_adjustment_clamp_page(byval adjustment as GtkAdjustment ptr, byval lower as gdouble, byval upper as gdouble)
declare function gtk_adjustment_get_value(byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_value(byval adjustment as GtkAdjustment ptr, byval value as gdouble)
declare function gtk_adjustment_get_lower(byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_lower(byval adjustment as GtkAdjustment ptr, byval lower as gdouble)
declare function gtk_adjustment_get_upper(byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_upper(byval adjustment as GtkAdjustment ptr, byval upper as gdouble)
declare function gtk_adjustment_get_step_increment(byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_step_increment(byval adjustment as GtkAdjustment ptr, byval step_increment as gdouble)
declare function gtk_adjustment_get_page_increment(byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_page_increment(byval adjustment as GtkAdjustment ptr, byval page_increment as gdouble)
declare function gtk_adjustment_get_page_size(byval adjustment as GtkAdjustment ptr) as gdouble
declare sub gtk_adjustment_set_page_size(byval adjustment as GtkAdjustment ptr, byval page_size as gdouble)
declare sub gtk_adjustment_configure(byval adjustment as GtkAdjustment ptr, byval value as gdouble, byval lower as gdouble, byval upper as gdouble, byval step_increment as gdouble, byval page_increment as gdouble, byval page_size as gdouble)

#define __GTK_STYLE_H__
#define GTK_TYPE_STYLE gtk_style_get_type()
#define GTK_STYLE(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_STYLE, GtkStyle)
#define GTK_STYLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STYLE, GtkStyleClass)
#define GTK_IS_STYLE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_STYLE)
#define GTK_IS_STYLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STYLE)
#define GTK_STYLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STYLE, GtkStyleClass)
#define GTK_TYPE_BORDER gtk_border_get_type()

type GtkBorder as _GtkBorder
type GtkStyle as _GtkStyle
type GtkStyleClass as _GtkStyleClass
type GtkThemeEngine as _GtkThemeEngine
type GtkRcStyle as _GtkRcStyle
type GtkIconSet as _GtkIconSet
type GtkIconSource as _GtkIconSource
type GtkRcProperty as _GtkRcProperty
type GtkSettings as _GtkSettings
type GtkRcPropertyParser as function(byval pspec as const GParamSpec ptr, byval rc_string as const GString ptr, byval property_value as GValue ptr) as gboolean
type GtkWidget as _GtkWidget
#define GTK_STYLE_ATTACHED(style) (GTK_STYLE(style)->attach_count > 0)

type _GtkStyle
	parent_instance as GObject
	fg(0 to 4) as GdkColor
	bg(0 to 4) as GdkColor
	light(0 to 4) as GdkColor
	dark(0 to 4) as GdkColor
	mid(0 to 4) as GdkColor
	text(0 to 4) as GdkColor
	base(0 to 4) as GdkColor
	text_aa(0 to 4) as GdkColor
	black as GdkColor
	white as GdkColor
	font_desc as PangoFontDescription ptr
	xthickness as gint
	ythickness as gint
	fg_gc(0 to 4) as GdkGC ptr
	bg_gc(0 to 4) as GdkGC ptr
	light_gc(0 to 4) as GdkGC ptr
	dark_gc(0 to 4) as GdkGC ptr
	mid_gc(0 to 4) as GdkGC ptr
	text_gc(0 to 4) as GdkGC ptr
	base_gc(0 to 4) as GdkGC ptr
	text_aa_gc(0 to 4) as GdkGC ptr
	black_gc as GdkGC ptr
	white_gc as GdkGC ptr
	bg_pixmap(0 to 4) as GdkPixmap ptr
	attach_count as gint
	depth as gint
	colormap as GdkColormap ptr
	private_font as GdkFont ptr
	private_font_desc as PangoFontDescription ptr
	rc_style as GtkRcStyle ptr
	styles as GSList ptr
	property_cache as GArray ptr
	icon_factories as GSList ptr
end type

type _GtkStyleClass
	parent_class as GObjectClass
	realize as sub(byval style as GtkStyle ptr)
	unrealize as sub(byval style as GtkStyle ptr)
	copy as sub(byval style as GtkStyle ptr, byval src as GtkStyle ptr)
	clone as function(byval style as GtkStyle ptr) as GtkStyle ptr
	init_from_rc as sub(byval style as GtkStyle ptr, byval rc_style as GtkRcStyle ptr)
	set_background as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType)
	render_icon as function(byval style as GtkStyle ptr, byval source as const GtkIconSource ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as const gchar ptr) as GdkPixbuf ptr
	draw_hline as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x1 as gint, byval x2 as gint, byval y as gint)
	draw_vline as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval y1_ as gint, byval y2_ as gint, byval x as gint)
	draw_shadow as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_polygon as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval point as GdkPoint ptr, byval npoints as gint, byval fill as gboolean)
	draw_arrow as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_diamond as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_string as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval string as const gchar ptr)
	draw_box as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_flat_box as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_check as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_option as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_tab as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_shadow_gap as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
	draw_box_gap as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
	draw_extension as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
	draw_focus as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_slider as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
	draw_handle as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
	draw_expander as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
	draw_layout as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
	draw_resize_grip as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_spinner as sub(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval step as guint, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
	_gtk_reserved9 as sub()
	_gtk_reserved10 as sub()
	_gtk_reserved11 as sub()
end type

type _GtkBorder
	left as gint
	right as gint
	top as gint
	bottom as gint
end type

declare function gtk_style_get_type() as GType
declare function gtk_style_new() as GtkStyle ptr
declare function gtk_style_copy(byval style as GtkStyle ptr) as GtkStyle ptr
declare function gtk_style_attach(byval style as GtkStyle ptr, byval window as GdkWindow ptr) as GtkStyle ptr
declare sub gtk_style_detach(byval style as GtkStyle ptr)
declare function gtk_style_ref(byval style as GtkStyle ptr) as GtkStyle ptr
declare sub gtk_style_unref(byval style as GtkStyle ptr)
declare function gtk_style_get_font(byval style as GtkStyle ptr) as GdkFont ptr
declare sub gtk_style_set_font(byval style as GtkStyle ptr, byval font as GdkFont ptr)
declare sub gtk_style_set_background(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType)
declare sub gtk_style_apply_default_background(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval set_bg as gboolean, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare function gtk_style_lookup_icon_set(byval style as GtkStyle ptr, byval stock_id as const gchar ptr) as GtkIconSet ptr
declare function gtk_style_lookup_color(byval style as GtkStyle ptr, byval color_name as const gchar ptr, byval color as GdkColor ptr) as gboolean
declare function gtk_style_render_icon(byval style as GtkStyle ptr, byval source as const GtkIconSource ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as const gchar ptr) as GdkPixbuf ptr
declare sub gtk_draw_hline(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x1 as gint, byval x2 as gint, byval y as gint)
declare sub gtk_draw_vline(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval y1_ as gint, byval y2_ as gint, byval x as gint)
declare sub gtk_draw_shadow(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_polygon(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval points as GdkPoint ptr, byval npoints as gint, byval fill as gboolean)
declare sub gtk_draw_arrow(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_diamond(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_box(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_flat_box(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_check(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_option(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_tab(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_shadow_gap(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_draw_box_gap(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_draw_extension(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
declare sub gtk_draw_focus(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_draw_slider(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_draw_handle(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_draw_expander(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
declare sub gtk_draw_layout(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gtk_draw_resize_grip(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_hline(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x1 as gint, byval x2 as gint, byval y as gint)
declare sub gtk_paint_vline(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval y1_ as gint, byval y2_ as gint, byval x as gint)
declare sub gtk_paint_shadow(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_polygon(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval points as const GdkPoint ptr, byval n_points as gint, byval fill as gboolean)
declare sub gtk_paint_arrow(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_diamond(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_box(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_flat_box(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_check(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_option(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_tab(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_shadow_gap(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_paint_box_gap(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_paint_extension(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
declare sub gtk_paint_focus(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_slider(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_paint_handle(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_paint_expander(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
declare sub gtk_paint_layout(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gtk_paint_resize_grip(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_spinner(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval step as guint, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare function gtk_border_get_type() as GType
declare function gtk_border_new() as GtkBorder ptr
declare function gtk_border_copy(byval border_ as const GtkBorder ptr) as GtkBorder ptr
declare sub gtk_border_free(byval border_ as GtkBorder ptr)
declare sub gtk_style_get_style_property(byval style as GtkStyle ptr, byval widget_type as GType, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub gtk_style_get_valist(byval style as GtkStyle ptr, byval widget_type as GType, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_style_get(byval style as GtkStyle ptr, byval widget_type as GType, byval first_property_name as const gchar ptr, ...)
declare function _gtk_style_peek_property_value(byval style as GtkStyle ptr, byval widget_type as GType, byval pspec as GParamSpec ptr, byval parser as GtkRcPropertyParser) as const GValue ptr
declare sub _gtk_style_init_for_settings(byval style as GtkStyle ptr, byval settings as GtkSettings ptr)
declare sub _gtk_style_shade(byval a as const GdkColor ptr, byval b as GdkColor ptr, byval k as gdouble)
#define gtk_style_apply_default_pixmap(s, gw, st, a, x, y, w, h) gtk_style_apply_default_background(s, gw, 1, st, a, x, y, w, h)
declare sub gtk_draw_string(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x as gint, byval y as gint, byval string as const gchar ptr)
declare sub gtk_paint_string(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval area as const GdkRectangle ptr, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval string as const gchar ptr)
declare sub gtk_draw_insertion_cursor(byval widget as GtkWidget ptr, byval drawable as GdkDrawable ptr, byval area as const GdkRectangle ptr, byval location as const GdkRectangle ptr, byval is_primary as gboolean, byval direction as GtkTextDirection, byval draw_arrow as gboolean)
declare function _gtk_widget_get_cursor_gc(byval widget as GtkWidget ptr) as GdkGC ptr
declare sub _gtk_widget_get_cursor_color(byval widget as GtkWidget ptr, byval color as GdkColor ptr)
#define __GTK_SETTINGS_H__
#define __GTK_RC_H__

type GtkIconFactory as _GtkIconFactory
type GtkRcContext as _GtkRcContext
type GtkRcStyleClass as _GtkRcStyleClass

#define GTK_TYPE_RC_STYLE gtk_rc_style_get_type()
#define GTK_RC_STYLE(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_RC_STYLE, GtkRcStyle)
#define GTK_RC_STYLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RC_STYLE, GtkRcStyleClass)
#define GTK_IS_RC_STYLE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_RC_STYLE)
#define GTK_IS_RC_STYLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RC_STYLE)
#define GTK_RC_STYLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RC_STYLE, GtkRcStyleClass)

type GtkRcFlags as long
enum
	GTK_RC_FG = 1 shl 0
	GTK_RC_BG = 1 shl 1
	GTK_RC_TEXT = 1 shl 2
	GTK_RC_BASE = 1 shl 3
end enum

type _GtkRcStyle
	parent_instance as GObject
	name as gchar ptr
	bg_pixmap_name(0 to 4) as gchar ptr
	font_desc as PangoFontDescription ptr
	color_flags(0 to 4) as GtkRcFlags
	fg(0 to 4) as GdkColor
	bg(0 to 4) as GdkColor
	text(0 to 4) as GdkColor
	base(0 to 4) as GdkColor
	xthickness as gint
	ythickness as gint
	rc_properties as GArray ptr
	rc_style_lists as GSList ptr
	icon_factories as GSList ptr
	engine_specified : 1 as guint
end type

type _GtkRcStyleClass
	parent_class as GObjectClass
	create_rc_style as function(byval rc_style as GtkRcStyle ptr) as GtkRcStyle ptr
	parse as function(byval rc_style as GtkRcStyle ptr, byval settings as GtkSettings ptr, byval scanner as GScanner ptr) as guint
	merge as sub(byval dest as GtkRcStyle ptr, byval src as GtkRcStyle ptr)
	create_style as function(byval rc_style as GtkRcStyle ptr) as GtkStyle ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare sub _gtk_rc_init()
declare function _gtk_rc_parse_widget_class_path(byval pattern as const gchar ptr) as GSList ptr
declare sub _gtk_rc_free_widget_class_path(byval list as GSList ptr)
declare function _gtk_rc_match_widget_class(byval list as GSList ptr, byval length as gint, byval path as gchar ptr, byval path_reversed as gchar ptr) as gboolean

#ifdef __FB_UNIX__
	declare sub gtk_rc_add_default_file(byval filename as const gchar ptr)
	declare sub gtk_rc_set_default_files(byval filenames as gchar ptr ptr)
#else
	declare sub gtk_rc_add_default_file_utf8(byval filename as const gchar ptr)
	declare sub gtk_rc_add_default_file alias "gtk_rc_add_default_file_utf8"(byval filename as const gchar ptr)
	declare sub gtk_rc_set_default_files_utf8(byval filenames as gchar ptr ptr)
	declare sub gtk_rc_set_default_files alias "gtk_rc_set_default_files_utf8"(byval filenames as gchar ptr ptr)
#endif

declare function gtk_rc_get_default_files() as gchar ptr ptr
declare function gtk_rc_get_style(byval widget as GtkWidget ptr) as GtkStyle ptr
declare function gtk_rc_get_style_by_paths(byval settings as GtkSettings ptr, byval widget_path as const zstring ptr, byval class_path as const zstring ptr, byval type as GType) as GtkStyle ptr
declare function gtk_rc_reparse_all_for_settings(byval settings as GtkSettings ptr, byval force_load as gboolean) as gboolean
declare sub gtk_rc_reset_styles(byval settings as GtkSettings ptr)
declare function gtk_rc_find_pixmap_in_path(byval settings as GtkSettings ptr, byval scanner as GScanner ptr, byval pixmap_file as const gchar ptr) as gchar ptr

#ifdef __FB_UNIX__
	declare sub gtk_rc_parse(byval filename as const gchar ptr)
#else
	declare sub gtk_rc_parse_utf8(byval filename as const gchar ptr)
	declare sub gtk_rc_parse alias "gtk_rc_parse_utf8"(byval filename as const gchar ptr)
#endif

declare sub gtk_rc_parse_string(byval rc_string as const gchar ptr)
declare function gtk_rc_reparse_all() as gboolean
declare sub gtk_rc_add_widget_name_style(byval rc_style as GtkRcStyle ptr, byval pattern as const gchar ptr)
declare sub gtk_rc_add_widget_class_style(byval rc_style as GtkRcStyle ptr, byval pattern as const gchar ptr)
declare sub gtk_rc_add_class_style(byval rc_style as GtkRcStyle ptr, byval pattern as const gchar ptr)
declare function gtk_rc_style_get_type() as GType
declare function gtk_rc_style_new() as GtkRcStyle ptr
declare function gtk_rc_style_copy(byval orig as GtkRcStyle ptr) as GtkRcStyle ptr
declare sub gtk_rc_style_ref(byval rc_style as GtkRcStyle ptr)
declare sub gtk_rc_style_unref(byval rc_style as GtkRcStyle ptr)
declare function gtk_rc_find_module_in_path(byval module_file as const gchar ptr) as gchar ptr
declare function gtk_rc_get_theme_dir() as gchar ptr
declare function gtk_rc_get_module_dir() as gchar ptr
declare function gtk_rc_get_im_module_path() as gchar ptr
declare function gtk_rc_get_im_module_file() as gchar ptr

type GtkRcTokenType as long
enum
	GTK_RC_TOKEN_INVALID = G_TOKEN_LAST
	GTK_RC_TOKEN_INCLUDE
	GTK_RC_TOKEN_NORMAL
	GTK_RC_TOKEN_ACTIVE
	GTK_RC_TOKEN_PRELIGHT
	GTK_RC_TOKEN_SELECTED
	GTK_RC_TOKEN_INSENSITIVE
	GTK_RC_TOKEN_FG
	GTK_RC_TOKEN_BG
	GTK_RC_TOKEN_TEXT
	GTK_RC_TOKEN_BASE
	GTK_RC_TOKEN_XTHICKNESS
	GTK_RC_TOKEN_YTHICKNESS
	GTK_RC_TOKEN_FONT
	GTK_RC_TOKEN_FONTSET
	GTK_RC_TOKEN_FONT_NAME
	GTK_RC_TOKEN_BG_PIXMAP
	GTK_RC_TOKEN_PIXMAP_PATH
	GTK_RC_TOKEN_STYLE
	GTK_RC_TOKEN_BINDING
	GTK_RC_TOKEN_BIND
	GTK_RC_TOKEN_WIDGET
	GTK_RC_TOKEN_WIDGET_CLASS
	GTK_RC_TOKEN_CLASS
	GTK_RC_TOKEN_LOWEST
	GTK_RC_TOKEN_GTK
	GTK_RC_TOKEN_APPLICATION
	GTK_RC_TOKEN_THEME
	GTK_RC_TOKEN_RC
	GTK_RC_TOKEN_HIGHEST
	GTK_RC_TOKEN_ENGINE
	GTK_RC_TOKEN_MODULE_PATH
	GTK_RC_TOKEN_IM_MODULE_PATH
	GTK_RC_TOKEN_IM_MODULE_FILE
	GTK_RC_TOKEN_STOCK
	GTK_RC_TOKEN_LTR
	GTK_RC_TOKEN_RTL
	GTK_RC_TOKEN_COLOR
	GTK_RC_TOKEN_UNBIND
	GTK_RC_TOKEN_LAST
end enum

declare function gtk_rc_scanner_new() as GScanner ptr
declare function gtk_rc_parse_color(byval scanner as GScanner ptr, byval color as GdkColor ptr) as guint
declare function gtk_rc_parse_color_full(byval scanner as GScanner ptr, byval style as GtkRcStyle ptr, byval color as GdkColor ptr) as guint
declare function gtk_rc_parse_state(byval scanner as GScanner ptr, byval state as GtkStateType ptr) as guint
declare function gtk_rc_parse_priority(byval scanner as GScanner ptr, byval priority as GtkPathPriorityType ptr) as guint

type _GtkRcProperty
	type_name as GQuark
	property_name as GQuark
	origin as gchar ptr
	value as GValue
end type

declare function _gtk_rc_style_lookup_rc_property(byval rc_style as GtkRcStyle ptr, byval type_name as GQuark, byval property_name as GQuark) as const GtkRcProperty ptr
declare sub _gtk_rc_style_set_rc_property(byval rc_style as GtkRcStyle ptr, byval property as GtkRcProperty ptr)
declare sub _gtk_rc_style_unset_rc_property(byval rc_style as GtkRcStyle ptr, byval type_name as GQuark, byval property_name as GQuark)
declare function _gtk_rc_style_get_color_hashes(byval rc_style as GtkRcStyle ptr) as GSList ptr
declare function _gtk_rc_context_get_default_font_name(byval settings as GtkSettings ptr) as const gchar ptr
declare sub _gtk_rc_context_destroy(byval settings as GtkSettings ptr)

#define GTK_TYPE_SETTINGS gtk_settings_get_type()
#define GTK_SETTINGS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SETTINGS, GtkSettings)
#define GTK_SETTINGS_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SETTINGS, GtkSettingsClass)
#define GTK_IS_SETTINGS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SETTINGS)
#define GTK_IS_SETTINGS_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SETTINGS)
#define GTK_SETTINGS_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SETTINGS, GtkSettingsClass)

type GtkSettingsClass as _GtkSettingsClass
type GtkSettingsValue as _GtkSettingsValue
type GtkSettingsPropertyValue as _GtkSettingsPropertyValue

type _GtkSettings
	parent_instance as GObject
	queued_settings as GData ptr
	property_values as GtkSettingsPropertyValue ptr
	rc_context as GtkRcContext ptr
	screen as GdkScreen ptr
end type

type _GtkSettingsClass
	parent_class as GObjectClass
end type

type _GtkSettingsValue
	origin as gchar ptr
	value as GValue
end type

declare function gtk_settings_get_type() as GType
declare function gtk_settings_get_default() as GtkSettings ptr
declare function gtk_settings_get_for_screen(byval screen as GdkScreen ptr) as GtkSettings ptr
declare sub gtk_settings_install_property(byval pspec as GParamSpec ptr)
declare sub gtk_settings_install_property_parser(byval pspec as GParamSpec ptr, byval parser as GtkRcPropertyParser)
declare function gtk_rc_property_parse_color(byval pspec as const GParamSpec ptr, byval gstring as const GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_enum(byval pspec as const GParamSpec ptr, byval gstring as const GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_flags(byval pspec as const GParamSpec ptr, byval gstring as const GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_requisition(byval pspec as const GParamSpec ptr, byval gstring as const GString ptr, byval property_value as GValue ptr) as gboolean
declare function gtk_rc_property_parse_border(byval pspec as const GParamSpec ptr, byval gstring as const GString ptr, byval property_value as GValue ptr) as gboolean
declare sub gtk_settings_set_property_value(byval settings as GtkSettings ptr, byval name as const gchar ptr, byval svalue as const GtkSettingsValue ptr)
declare sub gtk_settings_set_string_property(byval settings as GtkSettings ptr, byval name as const gchar ptr, byval v_string as const gchar ptr, byval origin as const gchar ptr)
declare sub gtk_settings_set_long_property(byval settings as GtkSettings ptr, byval name as const gchar ptr, byval v_long as glong, byval origin as const gchar ptr)
declare sub gtk_settings_set_double_property(byval settings as GtkSettings ptr, byval name as const gchar ptr, byval v_double as gdouble, byval origin as const gchar ptr)
declare sub _gtk_settings_set_property_value_from_rc(byval settings as GtkSettings ptr, byval name as const gchar ptr, byval svalue as const GtkSettingsValue ptr)
declare sub _gtk_settings_reset_rc_values(byval settings as GtkSettings ptr)
declare sub _gtk_settings_handle_event(byval event as GdkEventSetting ptr)
declare function _gtk_rc_property_parser_from_type(byval type as GType) as GtkRcPropertyParser
declare function _gtk_settings_parse_convert(byval parser as GtkRcPropertyParser, byval src_value as const GValue ptr, byval pspec as GParamSpec ptr, byval dest_value as GValue ptr) as gboolean

type GtkWidgetFlags as long
enum
	GTK_TOPLEVEL = 1 shl 4
	GTK_NO_WINDOW = 1 shl 5
	GTK_REALIZED = 1 shl 6
	GTK_MAPPED = 1 shl 7
	GTK_VISIBLE = 1 shl 8
	GTK_SENSITIVE = 1 shl 9
	GTK_PARENT_SENSITIVE = 1 shl 10
	GTK_CAN_FOCUS = 1 shl 11
	GTK_HAS_FOCUS = 1 shl 12
	GTK_CAN_DEFAULT = 1 shl 13
	GTK_HAS_DEFAULT = 1 shl 14
	GTK_HAS_GRAB = 1 shl 15
	GTK_RC_STYLE_ = 1 shl 16
	GTK_COMPOSITE_CHILD = 1 shl 17
	GTK_NO_REPARENT = 1 shl 18
	GTK_APP_PAINTABLE = 1 shl 19
	GTK_RECEIVES_DEFAULT = 1 shl 20
	GTK_DOUBLE_BUFFERED = 1 shl 21
	GTK_NO_SHOW_ALL = 1 shl 22
end enum

type GtkWidgetHelpType as long
enum
	GTK_WIDGET_HELP_TOOLTIP
	GTK_WIDGET_HELP_WHATS_THIS
end enum

#define GTK_TYPE_WIDGET gtk_widget_get_type()
#define GTK_WIDGET(widget) G_TYPE_CHECK_INSTANCE_CAST((widget), GTK_TYPE_WIDGET, GtkWidget)
#define GTK_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_WIDGET, GtkWidgetClass)
#define GTK_IS_WIDGET(widget) G_TYPE_CHECK_INSTANCE_TYPE((widget), GTK_TYPE_WIDGET)
#define GTK_IS_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_WIDGET)
#define GTK_WIDGET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_WIDGET, GtkWidgetClass)
#define GTK_WIDGET_TYPE(wid) GTK_OBJECT_TYPE(wid)
#define GTK_WIDGET_STATE(wid) GTK_WIDGET(wid)->state
#define GTK_WIDGET_SAVED_STATE(wid) GTK_WIDGET(wid)->saved_state
#define GTK_WIDGET_FLAGS(wid) GTK_OBJECT_FLAGS(wid)
#define GTK_WIDGET_TOPLEVEL(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_TOPLEVEL) <> 0)
#define GTK_WIDGET_NO_WINDOW(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_NO_WINDOW) <> 0)
#define GTK_WIDGET_REALIZED(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_REALIZED) <> 0)
#define GTK_WIDGET_MAPPED(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_MAPPED) <> 0)
#define GTK_WIDGET_VISIBLE(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_VISIBLE) <> 0)
#define GTK_WIDGET_DRAWABLE(wid) (GTK_WIDGET_VISIBLE(wid) andalso GTK_WIDGET_MAPPED(wid))
#define GTK_WIDGET_SENSITIVE(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_SENSITIVE) <> 0)
#define GTK_WIDGET_PARENT_SENSITIVE(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_PARENT_SENSITIVE) <> 0)
#define GTK_WIDGET_IS_SENSITIVE(wid) (GTK_WIDGET_SENSITIVE(wid) andalso GTK_WIDGET_PARENT_SENSITIVE(wid))
#define GTK_WIDGET_CAN_FOCUS(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_CAN_FOCUS) <> 0)
#define GTK_WIDGET_HAS_FOCUS(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_HAS_FOCUS) <> 0)
#define GTK_WIDGET_CAN_DEFAULT(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_CAN_DEFAULT) <> 0)
#define GTK_WIDGET_HAS_DEFAULT(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_HAS_DEFAULT) <> 0)
#define GTK_WIDGET_HAS_GRAB(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_HAS_GRAB) <> 0)
#define GTK_WIDGET_RC_STYLE(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_RC_STYLE) <> 0)
#define GTK_WIDGET_COMPOSITE_CHILD(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_COMPOSITE_CHILD) <> 0)
#define GTK_WIDGET_APP_PAINTABLE(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_APP_PAINTABLE) <> 0)
#define GTK_WIDGET_RECEIVES_DEFAULT(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_RECEIVES_DEFAULT) <> 0)
#define GTK_WIDGET_DOUBLE_BUFFERED(wid) ((GTK_WIDGET_FLAGS(wid) and GTK_DOUBLE_BUFFERED) <> 0)
#define GTK_WIDGET_SET_FLAGS(wid, flag) scope : GTK_WIDGET_FLAGS(wid) or= (flag) : end scope
#define GTK_WIDGET_UNSET_FLAGS(wid, flag) scope : GTK_WIDGET_FLAGS(wid) and= not (flag) : end scope
#define GTK_TYPE_REQUISITION gtk_requisition_get_type()

type GtkRequisition as _GtkRequisition
type GtkSelectionData as _GtkSelectionData
type GtkWidgetClass as _GtkWidgetClass
type GtkWidgetAuxInfo as _GtkWidgetAuxInfo
type GtkWidgetShapeInfo as _GtkWidgetShapeInfo
type GtkClipboard as _GtkClipboard
type GtkTooltip as _GtkTooltip
type GtkWindow as _GtkWindow
type GtkAllocation as GdkRectangle
type GtkCallback as sub(byval widget as GtkWidget ptr, byval data as gpointer)

type _GtkRequisition
	width as gint
	height as gint
end type

type _GtkWidget
	object as GtkObject
	private_flags as guint16
	state as guint8
	saved_state as guint8
	name as gchar ptr
	style as GtkStyle ptr
	requisition as GtkRequisition
	allocation as GtkAllocation
	window as GdkWindow ptr
	parent as GtkWidget ptr
end type

type _GtkWidgetClass
	parent_class as GtkObjectClass
	activate_signal as guint
	set_scroll_adjustments_signal as guint
	dispatch_child_properties_changed as sub(byval widget as GtkWidget ptr, byval n_pspecs as guint, byval pspecs as GParamSpec ptr ptr)
	show as sub(byval widget as GtkWidget ptr)
	show_all as sub(byval widget as GtkWidget ptr)
	hide as sub(byval widget as GtkWidget ptr)
	hide_all as sub(byval widget as GtkWidget ptr)
	map as sub(byval widget as GtkWidget ptr)
	unmap as sub(byval widget as GtkWidget ptr)
	realize as sub(byval widget as GtkWidget ptr)
	unrealize as sub(byval widget as GtkWidget ptr)
	size_request as sub(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
	size_allocate as sub(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr)
	state_changed as sub(byval widget as GtkWidget ptr, byval previous_state as GtkStateType)
	parent_set as sub(byval widget as GtkWidget ptr, byval previous_parent as GtkWidget ptr)
	hierarchy_changed as sub(byval widget as GtkWidget ptr, byval previous_toplevel as GtkWidget ptr)
	style_set as sub(byval widget as GtkWidget ptr, byval previous_style as GtkStyle ptr)
	direction_changed as sub(byval widget as GtkWidget ptr, byval previous_direction as GtkTextDirection)
	grab_notify as sub(byval widget as GtkWidget ptr, byval was_grabbed as gboolean)
	child_notify as sub(byval widget as GtkWidget ptr, byval pspec as GParamSpec ptr)
	mnemonic_activate as function(byval widget as GtkWidget ptr, byval group_cycling as gboolean) as gboolean
	grab_focus as sub(byval widget as GtkWidget ptr)
	focus as function(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
	event as function(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gboolean
	button_press_event as function(byval widget as GtkWidget ptr, byval event as GdkEventButton ptr) as gboolean
	button_release_event as function(byval widget as GtkWidget ptr, byval event as GdkEventButton ptr) as gboolean
	scroll_event as function(byval widget as GtkWidget ptr, byval event as GdkEventScroll ptr) as gboolean
	motion_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventMotion ptr) as gboolean
	delete_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
	destroy_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
	expose_event as function(byval widget as GtkWidget ptr, byval event as GdkEventExpose ptr) as gboolean
	key_press_event as function(byval widget as GtkWidget ptr, byval event as GdkEventKey ptr) as gboolean
	key_release_event as function(byval widget as GtkWidget ptr, byval event as GdkEventKey ptr) as gboolean
	enter_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventCrossing ptr) as gboolean
	leave_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventCrossing ptr) as gboolean
	configure_event as function(byval widget as GtkWidget ptr, byval event as GdkEventConfigure ptr) as gboolean
	focus_in_event as function(byval widget as GtkWidget ptr, byval event as GdkEventFocus ptr) as gboolean
	focus_out_event as function(byval widget as GtkWidget ptr, byval event as GdkEventFocus ptr) as gboolean
	map_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
	unmap_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
	property_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventProperty ptr) as gboolean
	selection_clear_event as function(byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
	selection_request_event as function(byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
	selection_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
	proximity_in_event as function(byval widget as GtkWidget ptr, byval event as GdkEventProximity ptr) as gboolean
	proximity_out_event as function(byval widget as GtkWidget ptr, byval event as GdkEventProximity ptr) as gboolean
	visibility_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventVisibility ptr) as gboolean
	client_event as function(byval widget as GtkWidget ptr, byval event as GdkEventClient ptr) as gboolean
	no_expose_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
	window_state_event as function(byval widget as GtkWidget ptr, byval event as GdkEventWindowState ptr) as gboolean
	selection_get as sub(byval widget as GtkWidget ptr, byval selection_data as GtkSelectionData ptr, byval info as guint, byval time_ as guint)
	selection_received as sub(byval widget as GtkWidget ptr, byval selection_data as GtkSelectionData ptr, byval time_ as guint)
	drag_begin as sub(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr)
	drag_end as sub(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr)
	drag_data_get as sub(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval selection_data as GtkSelectionData ptr, byval info as guint, byval time_ as guint)
	drag_data_delete as sub(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr)
	drag_leave as sub(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval time_ as guint)
	drag_motion as function(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval x as gint, byval y as gint, byval time_ as guint) as gboolean
	drag_drop as function(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval x as gint, byval y as gint, byval time_ as guint) as gboolean
	drag_data_received as sub(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval x as gint, byval y as gint, byval selection_data as GtkSelectionData ptr, byval info as guint, byval time_ as guint)
	popup_menu as function(byval widget as GtkWidget ptr) as gboolean
	show_help as function(byval widget as GtkWidget ptr, byval help_type as GtkWidgetHelpType) as gboolean
	get_accessible as function(byval widget as GtkWidget ptr) as AtkObject ptr
	screen_changed as sub(byval widget as GtkWidget ptr, byval previous_screen as GdkScreen ptr)
	can_activate_accel as function(byval widget as GtkWidget ptr, byval signal_id as guint) as gboolean
	grab_broken_event as function(byval widget as GtkWidget ptr, byval event as GdkEventGrabBroken ptr) as gboolean
	composited_changed as sub(byval widget as GtkWidget ptr)
	query_tooltip as function(byval widget as GtkWidget ptr, byval x as gint, byval y as gint, byval keyboard_tooltip as gboolean, byval tooltip as GtkTooltip ptr) as gboolean
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
end type

type _GtkWidgetAuxInfo
	x as gint
	y as gint
	width as gint
	height as gint
	x_set : 1 as guint
	y_set : 1 as guint
end type

type _GtkWidgetShapeInfo
	offset_x as gint16
	offset_y as gint16
	shape_mask as GdkBitmap ptr
end type

declare function gtk_widget_get_type() as GType
declare function gtk_widget_new(byval type as GType, byval first_property_name as const gchar ptr, ...) as GtkWidget ptr
declare sub gtk_widget_destroy(byval widget as GtkWidget ptr)
declare sub gtk_widget_destroyed(byval widget as GtkWidget ptr, byval widget_pointer as GtkWidget ptr ptr)
declare function gtk_widget_ref(byval widget as GtkWidget ptr) as GtkWidget ptr
declare sub gtk_widget_unref(byval widget as GtkWidget ptr)
declare sub gtk_widget_set(byval widget as GtkWidget ptr, byval first_property_name as const gchar ptr, ...)
declare sub gtk_widget_hide_all(byval widget as GtkWidget ptr)
declare sub gtk_widget_unparent(byval widget as GtkWidget ptr)
declare sub gtk_widget_show(byval widget as GtkWidget ptr)
declare sub gtk_widget_show_now(byval widget as GtkWidget ptr)
declare sub gtk_widget_hide(byval widget as GtkWidget ptr)
declare sub gtk_widget_show_all(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_no_show_all(byval widget as GtkWidget ptr, byval no_show_all as gboolean)
declare function gtk_widget_get_no_show_all(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_map(byval widget as GtkWidget ptr)
declare sub gtk_widget_unmap(byval widget as GtkWidget ptr)
declare sub gtk_widget_realize(byval widget as GtkWidget ptr)
declare sub gtk_widget_unrealize(byval widget as GtkWidget ptr)
declare sub gtk_widget_queue_draw(byval widget as GtkWidget ptr)
declare sub gtk_widget_queue_draw_area(byval widget as GtkWidget ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_widget_queue_clear(byval widget as GtkWidget ptr)
declare sub gtk_widget_queue_clear_area(byval widget as GtkWidget ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_widget_queue_resize(byval widget as GtkWidget ptr)
declare sub gtk_widget_queue_resize_no_redraw(byval widget as GtkWidget ptr)
declare sub gtk_widget_draw(byval widget as GtkWidget ptr, byval area as const GdkRectangle ptr)
declare sub gtk_widget_size_request(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub gtk_widget_size_allocate(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr)
declare sub gtk_widget_get_child_requisition(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub gtk_widget_add_accelerator(byval widget as GtkWidget ptr, byval accel_signal as const gchar ptr, byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval accel_flags as GtkAccelFlags)
declare function gtk_widget_remove_accelerator(byval widget as GtkWidget ptr, byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare sub gtk_widget_set_accel_path(byval widget as GtkWidget ptr, byval accel_path as const gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare function _gtk_widget_get_accel_path(byval widget as GtkWidget ptr, byval locked as gboolean ptr) as const gchar ptr
declare function gtk_widget_list_accel_closures(byval widget as GtkWidget ptr) as GList ptr
declare function gtk_widget_can_activate_accel(byval widget as GtkWidget ptr, byval signal_id as guint) as gboolean
declare function gtk_widget_mnemonic_activate(byval widget as GtkWidget ptr, byval group_cycling as gboolean) as gboolean
declare function gtk_widget_event(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gboolean
declare function gtk_widget_send_expose(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gint
declare function gtk_widget_send_focus_change(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gboolean
declare function gtk_widget_activate(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_set_scroll_adjustments(byval widget as GtkWidget ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as gboolean
declare sub gtk_widget_reparent(byval widget as GtkWidget ptr, byval new_parent as GtkWidget ptr)
declare function gtk_widget_intersect(byval widget as GtkWidget ptr, byval area as const GdkRectangle ptr, byval intersection as GdkRectangle ptr) as gboolean
declare function gtk_widget_region_intersect(byval widget as GtkWidget ptr, byval region as const GdkRegion ptr) as GdkRegion ptr
declare sub gtk_widget_freeze_child_notify(byval widget as GtkWidget ptr)
declare sub gtk_widget_child_notify(byval widget as GtkWidget ptr, byval child_property as const gchar ptr)
declare sub gtk_widget_thaw_child_notify(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_can_focus(byval widget as GtkWidget ptr, byval can_focus as gboolean)
declare function gtk_widget_get_can_focus(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_focus_ alias "gtk_widget_has_focus"(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_focus(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_grab_focus(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_can_default(byval widget as GtkWidget ptr, byval can_default as gboolean)
declare function gtk_widget_get_can_default(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_default_ alias "gtk_widget_has_default"(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_grab_default(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_receives_default(byval widget as GtkWidget ptr, byval receives_default as gboolean)
declare function gtk_widget_get_receives_default(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_grab_ alias "gtk_widget_has_grab"(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_name(byval widget as GtkWidget ptr, byval name as const gchar ptr)
declare function gtk_widget_get_name(byval widget as GtkWidget ptr) as const gchar ptr
declare sub gtk_widget_set_state(byval widget as GtkWidget ptr, byval state as GtkStateType)
declare function gtk_widget_get_state(byval widget as GtkWidget ptr) as GtkStateType
declare sub gtk_widget_set_sensitive(byval widget as GtkWidget ptr, byval sensitive as gboolean)
declare function gtk_widget_get_sensitive(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_sensitive_ alias "gtk_widget_is_sensitive"(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_visible(byval widget as GtkWidget ptr, byval visible as gboolean)
declare function gtk_widget_get_visible(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_has_window(byval widget as GtkWidget ptr, byval has_window as gboolean)
declare function gtk_widget_get_has_window(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_toplevel(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_drawable(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_realized(byval widget as GtkWidget ptr, byval realized as gboolean)
declare function gtk_widget_get_realized(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_mapped(byval widget as GtkWidget ptr, byval mapped as gboolean)
declare function gtk_widget_get_mapped(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_app_paintable(byval widget as GtkWidget ptr, byval app_paintable as gboolean)
declare function gtk_widget_get_app_paintable(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_double_buffered(byval widget as GtkWidget ptr, byval double_buffered as gboolean)
declare function gtk_widget_get_double_buffered(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_redraw_on_allocate(byval widget as GtkWidget ptr, byval redraw_on_allocate as gboolean)
declare sub gtk_widget_set_parent(byval widget as GtkWidget ptr, byval parent as GtkWidget ptr)
declare function gtk_widget_get_parent(byval widget as GtkWidget ptr) as GtkWidget ptr
declare sub gtk_widget_set_parent_window(byval widget as GtkWidget ptr, byval parent_window as GdkWindow ptr)
declare function gtk_widget_get_parent_window(byval widget as GtkWidget ptr) as GdkWindow ptr
declare sub gtk_widget_set_child_visible(byval widget as GtkWidget ptr, byval is_visible as gboolean)
declare function gtk_widget_get_child_visible(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_window(byval widget as GtkWidget ptr, byval window as GdkWindow ptr)
declare function gtk_widget_get_window(byval widget as GtkWidget ptr) as GdkWindow ptr
declare sub gtk_widget_get_allocation(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr)
declare sub gtk_widget_set_allocation(byval widget as GtkWidget ptr, byval allocation as const GtkAllocation ptr)
declare sub gtk_widget_get_requisition(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare function gtk_widget_child_focus(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
declare function gtk_widget_keynav_failed(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
declare sub gtk_widget_error_bell(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_size_request(byval widget as GtkWidget ptr, byval width as gint, byval height as gint)
declare sub gtk_widget_get_size_request(byval widget as GtkWidget ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_widget_set_uposition(byval widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_widget_set_usize(byval widget as GtkWidget ptr, byval width as gint, byval height as gint)
declare sub gtk_widget_set_events(byval widget as GtkWidget ptr, byval events as gint)
declare sub gtk_widget_add_events(byval widget as GtkWidget ptr, byval events as gint)
declare sub gtk_widget_set_extension_events(byval widget as GtkWidget ptr, byval mode as GdkExtensionMode)
declare function gtk_widget_get_extension_events(byval widget as GtkWidget ptr) as GdkExtensionMode
declare function gtk_widget_get_toplevel(byval widget as GtkWidget ptr) as GtkWidget ptr
declare function gtk_widget_get_ancestor(byval widget as GtkWidget ptr, byval widget_type as GType) as GtkWidget ptr
declare function gtk_widget_get_colormap(byval widget as GtkWidget ptr) as GdkColormap ptr
declare function gtk_widget_get_visual(byval widget as GtkWidget ptr) as GdkVisual ptr
declare function gtk_widget_get_screen(byval widget as GtkWidget ptr) as GdkScreen ptr
declare function gtk_widget_has_screen(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_get_display(byval widget as GtkWidget ptr) as GdkDisplay ptr
declare function gtk_widget_get_root_window(byval widget as GtkWidget ptr) as GdkWindow ptr
declare function gtk_widget_get_settings(byval widget as GtkWidget ptr) as GtkSettings ptr
declare function gtk_widget_get_clipboard(byval widget as GtkWidget ptr, byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_widget_get_snapshot(byval widget as GtkWidget ptr, byval clip_rect as GdkRectangle ptr) as GdkPixmap ptr

#define gtk_widget_set_visual(widget, visual) 0
#define gtk_widget_push_visual(visual) 0
#define gtk_widget_pop_visual() 0
#define gtk_widget_set_default_visual(visual) 0

declare function gtk_widget_get_accessible(byval widget as GtkWidget ptr) as AtkObject ptr
declare sub gtk_widget_set_colormap(byval widget as GtkWidget ptr, byval colormap as GdkColormap ptr)
declare function gtk_widget_get_events(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_get_pointer(byval widget as GtkWidget ptr, byval x as gint ptr, byval y as gint ptr)
declare function gtk_widget_is_ancestor(byval widget as GtkWidget ptr, byval ancestor as GtkWidget ptr) as gboolean
declare function gtk_widget_translate_coordinates(byval src_widget as GtkWidget ptr, byval dest_widget as GtkWidget ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint ptr, byval dest_y as gint ptr) as gboolean
declare function gtk_widget_hide_on_delete(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_style_attach(byval style as GtkWidget ptr)
declare function gtk_widget_has_rc_style(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_style(byval widget as GtkWidget ptr, byval style as GtkStyle ptr)
declare sub gtk_widget_ensure_style(byval widget as GtkWidget ptr)
declare function gtk_widget_get_style(byval widget as GtkWidget ptr) as GtkStyle ptr
declare sub gtk_widget_modify_style(byval widget as GtkWidget ptr, byval style as GtkRcStyle ptr)
declare function gtk_widget_get_modifier_style(byval widget as GtkWidget ptr) as GtkRcStyle ptr
declare sub gtk_widget_modify_fg(byval widget as GtkWidget ptr, byval state as GtkStateType, byval color as const GdkColor ptr)
declare sub gtk_widget_modify_bg(byval widget as GtkWidget ptr, byval state as GtkStateType, byval color as const GdkColor ptr)
declare sub gtk_widget_modify_text(byval widget as GtkWidget ptr, byval state as GtkStateType, byval color as const GdkColor ptr)
declare sub gtk_widget_modify_base(byval widget as GtkWidget ptr, byval state as GtkStateType, byval color as const GdkColor ptr)
declare sub gtk_widget_modify_cursor(byval widget as GtkWidget ptr, byval primary as const GdkColor ptr, byval secondary as const GdkColor ptr)
declare sub gtk_widget_modify_font(byval widget as GtkWidget ptr, byval font_desc as PangoFontDescription ptr)
#define gtk_widget_set_rc_style(widget) gtk_widget_set_style(widget, NULL)
#define gtk_widget_restore_default_style(widget) gtk_widget_set_style(widget, NULL)
declare function gtk_widget_create_pango_context(byval widget as GtkWidget ptr) as PangoContext ptr
declare function gtk_widget_get_pango_context(byval widget as GtkWidget ptr) as PangoContext ptr
declare function gtk_widget_create_pango_layout(byval widget as GtkWidget ptr, byval text as const gchar ptr) as PangoLayout ptr
declare function gtk_widget_render_icon(byval widget as GtkWidget ptr, byval stock_id as const gchar ptr, byval size as GtkIconSize, byval detail as const gchar ptr) as GdkPixbuf ptr
declare sub gtk_widget_set_composite_name(byval widget as GtkWidget ptr, byval name as const gchar ptr)
declare function gtk_widget_get_composite_name(byval widget as GtkWidget ptr) as gchar ptr
declare sub gtk_widget_reset_rc_styles(byval widget as GtkWidget ptr)
declare sub gtk_widget_push_colormap(byval cmap as GdkColormap ptr)
declare sub gtk_widget_push_composite_child()
declare sub gtk_widget_pop_composite_child()
declare sub gtk_widget_pop_colormap()
declare sub gtk_widget_class_install_style_property(byval klass as GtkWidgetClass ptr, byval pspec as GParamSpec ptr)
declare sub gtk_widget_class_install_style_property_parser(byval klass as GtkWidgetClass ptr, byval pspec as GParamSpec ptr, byval parser as GtkRcPropertyParser)
declare function gtk_widget_class_find_style_property(byval klass as GtkWidgetClass ptr, byval property_name as const gchar ptr) as GParamSpec ptr
declare function gtk_widget_class_list_style_properties(byval klass as GtkWidgetClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub gtk_widget_style_get_property(byval widget as GtkWidget ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub gtk_widget_style_get_valist(byval widget as GtkWidget ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_widget_style_get(byval widget as GtkWidget ptr, byval first_property_name as const gchar ptr, ...)
declare sub gtk_widget_set_default_colormap(byval colormap as GdkColormap ptr)
declare function gtk_widget_get_default_style() as GtkStyle ptr
declare function gtk_widget_get_default_colormap() as GdkColormap ptr
declare function gtk_widget_get_default_visual() as GdkVisual ptr
declare sub gtk_widget_set_direction(byval widget as GtkWidget ptr, byval dir as GtkTextDirection)
declare function gtk_widget_get_direction(byval widget as GtkWidget ptr) as GtkTextDirection
declare sub gtk_widget_set_default_direction(byval dir as GtkTextDirection)
declare function gtk_widget_get_default_direction() as GtkTextDirection
declare function gtk_widget_is_composited(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_shape_combine_mask(byval widget as GtkWidget ptr, byval shape_mask as GdkBitmap ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gtk_widget_input_shape_combine_mask(byval widget as GtkWidget ptr, byval shape_mask as GdkBitmap ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gtk_widget_reset_shapes(byval widget as GtkWidget ptr)
declare sub gtk_widget_path(byval widget as GtkWidget ptr, byval path_length as guint ptr, byval path as gchar ptr ptr, byval path_reversed as gchar ptr ptr)
declare sub gtk_widget_class_path(byval widget as GtkWidget ptr, byval path_length as guint ptr, byval path as gchar ptr ptr, byval path_reversed as gchar ptr ptr)
declare function gtk_widget_list_mnemonic_labels(byval widget as GtkWidget ptr) as GList ptr
declare sub gtk_widget_add_mnemonic_label(byval widget as GtkWidget ptr, byval label as GtkWidget ptr)
declare sub gtk_widget_remove_mnemonic_label(byval widget as GtkWidget ptr, byval label as GtkWidget ptr)
declare sub gtk_widget_set_tooltip_window(byval widget as GtkWidget ptr, byval custom_window as GtkWindow ptr)
declare function gtk_widget_get_tooltip_window(byval widget as GtkWidget ptr) as GtkWindow ptr
declare sub gtk_widget_trigger_tooltip_query(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_tooltip_text(byval widget as GtkWidget ptr, byval text as const gchar ptr)
declare function gtk_widget_get_tooltip_text(byval widget as GtkWidget ptr) as gchar ptr
declare sub gtk_widget_set_tooltip_markup(byval widget as GtkWidget ptr, byval markup as const gchar ptr)
declare function gtk_widget_get_tooltip_markup(byval widget as GtkWidget ptr) as gchar ptr
declare sub gtk_widget_set_has_tooltip(byval widget as GtkWidget ptr, byval has_tooltip as gboolean)
declare function gtk_widget_get_has_tooltip(byval widget as GtkWidget ptr) as gboolean
declare function gtk_requisition_get_type() as GType
declare function gtk_requisition_copy(byval requisition as const GtkRequisition ptr) as GtkRequisition ptr
declare sub gtk_requisition_free(byval requisition as GtkRequisition ptr)
declare sub _gtk_widget_set_has_default(byval widget as GtkWidget ptr, byval has_default as gboolean)
declare sub _gtk_widget_set_has_grab(byval widget as GtkWidget ptr, byval has_grab as gboolean)
declare sub _gtk_widget_set_is_toplevel(byval widget as GtkWidget ptr, byval is_toplevel as gboolean)
declare sub _gtk_widget_grab_notify(byval widget as GtkWidget ptr, byval was_grabbed as gboolean)
declare function _gtk_widget_get_aux_info(byval widget as GtkWidget ptr, byval create as gboolean) as GtkWidgetAuxInfo ptr
declare sub _gtk_widget_propagate_hierarchy_changed(byval widget as GtkWidget ptr, byval previous_toplevel as GtkWidget ptr)
declare sub _gtk_widget_propagate_screen_changed(byval widget as GtkWidget ptr, byval previous_screen as GdkScreen ptr)
declare sub _gtk_widget_propagate_composited_changed(byval widget as GtkWidget ptr)
declare sub _gtk_widget_set_pointer_window(byval widget as GtkWidget ptr, byval pointer_window as GdkWindow ptr)
declare function _gtk_widget_get_pointer_window(byval widget as GtkWidget ptr) as GdkWindow ptr
declare function _gtk_widget_is_pointer_widget(byval widget as GtkWidget ptr) as gboolean
declare sub _gtk_widget_synthesize_crossing(byval from as GtkWidget ptr, byval to as GtkWidget ptr, byval mode as GdkCrossingMode)
declare function _gtk_widget_peek_colormap() as GdkColormap ptr
declare sub _gtk_widget_buildable_finish_accelerator(byval widget as GtkWidget ptr, byval toplevel as GtkWidget ptr, byval user_data as gpointer)

#define GTK_TYPE_CONTAINER gtk_container_get_type()
#define GTK_CONTAINER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CONTAINER, GtkContainer)
#define GTK_CONTAINER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CONTAINER, GtkContainerClass)
#define GTK_IS_CONTAINER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CONTAINER)
#define GTK_IS_CONTAINER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CONTAINER)
#define GTK_CONTAINER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CONTAINER, GtkContainerClass)
#define GTK_IS_RESIZE_CONTAINER(widget) (GTK_IS_CONTAINER(widget) andalso (cptr(GtkContainer ptr, (widget))->resize_mode <> GTK_RESIZE_PARENT))
type GtkContainer as _GtkContainer
type GtkContainerClass as _GtkContainerClass

type _GtkContainer
	widget as GtkWidget
	focus_child as GtkWidget ptr
	border_width : 16 as guint
	need_resize : 1 as guint
	resize_mode : 2 as guint
	reallocate_redraws : 1 as guint
	has_focus_chain : 1 as guint
end type

type _GtkContainerClass
	parent_class as GtkWidgetClass
	add as sub(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
	remove as sub(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
	check_resize as sub(byval container as GtkContainer ptr)
	forall as sub(byval container as GtkContainer ptr, byval include_internals as gboolean, byval callback as GtkCallback, byval callback_data as gpointer)
	set_focus_child as sub(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
	child_type as function(byval container as GtkContainer ptr) as GType
	composite_name as function(byval container as GtkContainer ptr, byval child as GtkWidget ptr) as gchar ptr
	set_child_property as sub(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_id as guint, byval value as const GValue ptr, byval pspec as GParamSpec ptr)
	get_child_property as sub(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_id as guint, byval value as GValue ptr, byval pspec as GParamSpec ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_container_get_type() as GType
declare sub gtk_container_set_border_width(byval container as GtkContainer ptr, byval border_width as guint)
declare function gtk_container_get_border_width(byval container as GtkContainer ptr) as guint
declare sub gtk_container_add(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
declare sub gtk_container_remove(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
declare sub gtk_container_set_resize_mode(byval container as GtkContainer ptr, byval resize_mode as GtkResizeMode)
declare function gtk_container_get_resize_mode(byval container as GtkContainer ptr) as GtkResizeMode
declare sub gtk_container_check_resize(byval container as GtkContainer ptr)
declare sub gtk_container_foreach(byval container as GtkContainer ptr, byval callback as GtkCallback, byval callback_data as gpointer)
declare sub gtk_container_foreach_full(byval container as GtkContainer ptr, byval callback as GtkCallback, byval marshal as GtkCallbackMarshal, byval callback_data as gpointer, byval notify as GDestroyNotify)
declare function gtk_container_get_children(byval container as GtkContainer ptr) as GList ptr
declare function gtk_container_children alias "gtk_container_get_children"(byval container as GtkContainer ptr) as GList ptr
declare sub gtk_container_propagate_expose(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval event as GdkEventExpose ptr)
declare sub gtk_container_set_focus_chain(byval container as GtkContainer ptr, byval focusable_widgets as GList ptr)
declare function gtk_container_get_focus_chain(byval container as GtkContainer ptr, byval focusable_widgets as GList ptr ptr) as gboolean
declare sub gtk_container_unset_focus_chain(byval container as GtkContainer ptr)
declare sub gtk_container_set_reallocate_redraws(byval container as GtkContainer ptr, byval needs_redraws as gboolean)
declare sub gtk_container_set_focus_child(byval container as GtkContainer ptr, byval child as GtkWidget ptr)
declare function gtk_container_get_focus_child(byval container as GtkContainer ptr) as GtkWidget ptr
declare sub gtk_container_set_focus_vadjustment(byval container as GtkContainer ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_container_get_focus_vadjustment(byval container as GtkContainer ptr) as GtkAdjustment ptr
declare sub gtk_container_set_focus_hadjustment(byval container as GtkContainer ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_container_get_focus_hadjustment(byval container as GtkContainer ptr) as GtkAdjustment ptr
declare sub gtk_container_resize_children(byval container as GtkContainer ptr)
declare function gtk_container_child_type(byval container as GtkContainer ptr) as GType
declare sub gtk_container_class_install_child_property(byval cclass as GtkContainerClass ptr, byval property_id as guint, byval pspec as GParamSpec ptr)
declare function gtk_container_class_find_child_property(byval cclass as GObjectClass ptr, byval property_name as const gchar ptr) as GParamSpec ptr
declare function gtk_container_class_list_child_properties(byval cclass as GObjectClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub gtk_container_add_with_properties(byval container as GtkContainer ptr, byval widget as GtkWidget ptr, byval first_prop_name as const gchar ptr, ...)
declare sub gtk_container_child_set(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_prop_name as const gchar ptr, ...)
declare sub gtk_container_child_get(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_prop_name as const gchar ptr, ...)
declare sub gtk_container_child_set_valist(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_container_child_get_valist(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_container_child_set_property(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_name as const gchar ptr, byval value as const GValue ptr)
declare sub gtk_container_child_get_property(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
#define GTK_CONTAINER_WARN_INVALID_CHILD_PROPERTY_ID(object, property_id, pspec) G_OBJECT_WARN_INVALID_PSPEC((object), "child property id", (property_id), (pspec))
declare sub gtk_container_forall(byval container as GtkContainer ptr, byval callback as GtkCallback, byval callback_data as gpointer)
declare sub _gtk_container_queue_resize(byval container as GtkContainer ptr)
declare sub _gtk_container_clear_resize_widgets(byval container as GtkContainer ptr)
declare function _gtk_container_child_composite_name(byval container as GtkContainer ptr, byval child as GtkWidget ptr) as gchar ptr
declare sub _gtk_container_dequeue_resize_handler(byval container as GtkContainer ptr)
declare function _gtk_container_focus_sort(byval container as GtkContainer ptr, byval children as GList ptr, byval direction as GtkDirectionType, byval old_focus as GtkWidget ptr) as GList ptr
declare sub gtk_container_border_width alias "gtk_container_set_border_width"(byval container as GtkContainer ptr, byval border_width as guint)

#define GTK_TYPE_BIN gtk_bin_get_type()
#define GTK_BIN(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BIN, GtkBin)
#define GTK_BIN_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BIN, GtkBinClass)
#define GTK_IS_BIN(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BIN)
#define GTK_IS_BIN_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BIN)
#define GTK_BIN_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BIN, GtkBinClass)
type GtkBin as _GtkBin
type GtkBinClass as _GtkBinClass

type _GtkBin
	container as GtkContainer
	child as GtkWidget ptr
end type

type _GtkBinClass
	parent_class as GtkContainerClass
end type

declare function gtk_bin_get_type() as GType
declare function gtk_bin_get_child(byval bin as GtkBin ptr) as GtkWidget ptr
#define GTK_TYPE_WINDOW gtk_window_get_type()
#define GTK_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_WINDOW, GtkWindow)
#define GTK_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_WINDOW, GtkWindowClass)
#define GTK_IS_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_WINDOW)
#define GTK_IS_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_WINDOW)
#define GTK_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_WINDOW, GtkWindowClass)

type GtkWindowClass as _GtkWindowClass
type GtkWindowGeometryInfo as _GtkWindowGeometryInfo
type GtkWindowGroup as _GtkWindowGroup
type GtkWindowGroupClass as _GtkWindowGroupClass

type _GtkWindow
	bin as GtkBin
	title as gchar ptr
	wmclass_name as gchar ptr
	wmclass_class as gchar ptr
	wm_role as gchar ptr
	focus_widget as GtkWidget ptr
	default_widget as GtkWidget ptr
	transient_parent as GtkWindow ptr
	geometry_info as GtkWindowGeometryInfo ptr
	frame as GdkWindow ptr
	group as GtkWindowGroup ptr
	configure_request_count as guint16
	allow_shrink : 1 as guint
	allow_grow : 1 as guint
	configure_notify_received : 1 as guint
	need_default_position : 1 as guint
	need_default_size : 1 as guint
	position : 3 as guint
	as guint type : 4
	has_user_ref_count : 1 as guint
	has_focus : 1 as guint
	modal : 1 as guint
	destroy_with_parent : 1 as guint
	has_frame : 1 as guint
	iconify_initially : 1 as guint
	stick_initially : 1 as guint
	maximize_initially : 1 as guint
	decorated : 1 as guint
	type_hint : 3 as guint
	gravity : 5 as guint
	is_active : 1 as guint
	has_toplevel_focus : 1 as guint
	frame_left as guint
	frame_top as guint
	frame_right as guint
	frame_bottom as guint
	keys_changed_handler as guint
	mnemonic_modifier as GdkModifierType
	screen as GdkScreen ptr
end type

type _GtkWindowClass
	parent_class as GtkBinClass
	set_focus as sub(byval window as GtkWindow ptr, byval focus as GtkWidget ptr)
	frame_event as function(byval window as GtkWindow ptr, byval event as GdkEvent ptr) as gboolean
	activate_focus as sub(byval window as GtkWindow ptr)
	activate_default as sub(byval window as GtkWindow ptr)
	move_focus as sub(byval window as GtkWindow ptr, byval direction as GtkDirectionType)
	keys_changed as sub(byval window as GtkWindow ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

#define GTK_TYPE_WINDOW_GROUP gtk_window_group_get_type()
#define GTK_WINDOW_GROUP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_WINDOW_GROUP, GtkWindowGroup)
#define GTK_WINDOW_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass)
#define GTK_IS_WINDOW_GROUP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_WINDOW_GROUP)
#define GTK_IS_WINDOW_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_WINDOW_GROUP)
#define GTK_WINDOW_GROUP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass)

type _GtkWindowGroup
	parent_instance as GObject
	grabs as GSList ptr
end type

type _GtkWindowGroupClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_window_get_type() as GType
declare function gtk_window_new(byval type as GtkWindowType) as GtkWidget ptr
declare sub gtk_window_set_title(byval window as GtkWindow ptr, byval title as const gchar ptr)
declare function gtk_window_get_title(byval window as GtkWindow ptr) as const gchar ptr
declare sub gtk_window_set_wmclass(byval window as GtkWindow ptr, byval wmclass_name as const gchar ptr, byval wmclass_class as const gchar ptr)
declare sub gtk_window_set_role(byval window as GtkWindow ptr, byval role as const gchar ptr)
declare sub gtk_window_set_startup_id(byval window as GtkWindow ptr, byval startup_id as const gchar ptr)
declare function gtk_window_get_role(byval window as GtkWindow ptr) as const gchar ptr
declare sub gtk_window_add_accel_group(byval window as GtkWindow ptr, byval accel_group as GtkAccelGroup ptr)
declare sub gtk_window_remove_accel_group(byval window as GtkWindow ptr, byval accel_group as GtkAccelGroup ptr)
declare sub gtk_window_set_position(byval window as GtkWindow ptr, byval position as GtkWindowPosition)
declare function gtk_window_activate_focus(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_focus(byval window as GtkWindow ptr, byval focus as GtkWidget ptr)
declare function gtk_window_get_focus(byval window as GtkWindow ptr) as GtkWidget ptr
declare sub gtk_window_set_default(byval window as GtkWindow ptr, byval default_widget as GtkWidget ptr)
declare function gtk_window_get_default_widget(byval window as GtkWindow ptr) as GtkWidget ptr
declare function gtk_window_activate_default(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_transient_for(byval window as GtkWindow ptr, byval parent as GtkWindow ptr)
declare function gtk_window_get_transient_for(byval window as GtkWindow ptr) as GtkWindow ptr
declare sub gtk_window_set_opacity(byval window as GtkWindow ptr, byval opacity as gdouble)
declare function gtk_window_get_opacity(byval window as GtkWindow ptr) as gdouble
declare sub gtk_window_set_type_hint(byval window as GtkWindow ptr, byval hint as GdkWindowTypeHint)
declare function gtk_window_get_type_hint(byval window as GtkWindow ptr) as GdkWindowTypeHint
declare sub gtk_window_set_skip_taskbar_hint(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_skip_taskbar_hint(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_skip_pager_hint(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_skip_pager_hint(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_urgency_hint(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_urgency_hint(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_accept_focus(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_accept_focus(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_focus_on_map(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_focus_on_map(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_destroy_with_parent(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_destroy_with_parent(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_mnemonics_visible(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_mnemonics_visible(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_resizable(byval window as GtkWindow ptr, byval resizable as gboolean)
declare function gtk_window_get_resizable(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_gravity(byval window as GtkWindow ptr, byval gravity as GdkGravity)
declare function gtk_window_get_gravity(byval window as GtkWindow ptr) as GdkGravity
declare sub gtk_window_set_geometry_hints(byval window as GtkWindow ptr, byval geometry_widget as GtkWidget ptr, byval geometry as GdkGeometry ptr, byval geom_mask as GdkWindowHints)
declare sub gtk_window_set_screen(byval window as GtkWindow ptr, byval screen as GdkScreen ptr)
declare function gtk_window_get_screen(byval window as GtkWindow ptr) as GdkScreen ptr
declare function gtk_window_is_active(byval window as GtkWindow ptr) as gboolean
declare function gtk_window_has_toplevel_focus(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_has_frame(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_has_frame(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_frame_dimensions(byval window as GtkWindow ptr, byval left as gint, byval top as gint, byval right as gint, byval bottom as gint)
declare sub gtk_window_get_frame_dimensions(byval window as GtkWindow ptr, byval left as gint ptr, byval top as gint ptr, byval right as gint ptr, byval bottom as gint ptr)
declare sub gtk_window_set_decorated(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_decorated(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_deletable(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_deletable(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_icon_list(byval window as GtkWindow ptr, byval list as GList ptr)
declare function gtk_window_get_icon_list(byval window as GtkWindow ptr) as GList ptr
declare sub gtk_window_set_icon(byval window as GtkWindow ptr, byval icon as GdkPixbuf ptr)
declare sub gtk_window_set_icon_name(byval window as GtkWindow ptr, byval name as const gchar ptr)

#ifdef __FB_UNIX__
	declare function gtk_window_set_icon_from_file(byval window as GtkWindow ptr, byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
#else
	declare function gtk_window_set_icon_from_file_utf8(byval window as GtkWindow ptr, byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
	declare function gtk_window_set_icon_from_file alias "gtk_window_set_icon_from_file_utf8"(byval window as GtkWindow ptr, byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
#endif

declare function gtk_window_get_icon(byval window as GtkWindow ptr) as GdkPixbuf ptr
declare function gtk_window_get_icon_name(byval window as GtkWindow ptr) as const gchar ptr
declare sub gtk_window_set_default_icon_list(byval list as GList ptr)
declare function gtk_window_get_default_icon_list() as GList ptr
declare sub gtk_window_set_default_icon(byval icon as GdkPixbuf ptr)
declare sub gtk_window_set_default_icon_name(byval name as const gchar ptr)
declare function gtk_window_get_default_icon_name() as const gchar ptr

#ifdef __FB_UNIX__
	declare function gtk_window_set_default_icon_from_file(byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
#else
	declare function gtk_window_set_default_icon_from_file_utf8(byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
	declare function gtk_window_set_default_icon_from_file alias "gtk_window_set_default_icon_from_file_utf8"(byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
#endif

declare sub gtk_window_set_auto_startup_notification(byval setting as gboolean)
declare sub gtk_window_set_modal(byval window as GtkWindow ptr, byval modal as gboolean)
declare function gtk_window_get_modal(byval window as GtkWindow ptr) as gboolean
declare function gtk_window_list_toplevels() as GList ptr
declare sub gtk_window_add_mnemonic(byval window as GtkWindow ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare sub gtk_window_remove_mnemonic(byval window as GtkWindow ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare function gtk_window_mnemonic_activate(byval window as GtkWindow ptr, byval keyval as guint, byval modifier as GdkModifierType) as gboolean
declare sub gtk_window_set_mnemonic_modifier(byval window as GtkWindow ptr, byval modifier as GdkModifierType)
declare function gtk_window_get_mnemonic_modifier(byval window as GtkWindow ptr) as GdkModifierType
declare function gtk_window_activate_key(byval window as GtkWindow ptr, byval event as GdkEventKey ptr) as gboolean
declare function gtk_window_propagate_key_event(byval window as GtkWindow ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_window_present(byval window as GtkWindow ptr)
declare sub gtk_window_present_with_time(byval window as GtkWindow ptr, byval timestamp as guint32)
declare sub gtk_window_iconify(byval window as GtkWindow ptr)
declare sub gtk_window_deiconify(byval window as GtkWindow ptr)
declare sub gtk_window_stick(byval window as GtkWindow ptr)
declare sub gtk_window_unstick(byval window as GtkWindow ptr)
declare sub gtk_window_maximize(byval window as GtkWindow ptr)
declare sub gtk_window_unmaximize(byval window as GtkWindow ptr)
declare sub gtk_window_fullscreen(byval window as GtkWindow ptr)
declare sub gtk_window_unfullscreen(byval window as GtkWindow ptr)
declare sub gtk_window_set_keep_above(byval window as GtkWindow ptr, byval setting as gboolean)
declare sub gtk_window_set_keep_below(byval window as GtkWindow ptr, byval setting as gboolean)
declare sub gtk_window_begin_resize_drag(byval window as GtkWindow ptr, byval edge as GdkWindowEdge, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gtk_window_begin_move_drag(byval window as GtkWindow ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gtk_window_set_policy(byval window as GtkWindow ptr, byval allow_shrink as gint, byval allow_grow as gint, byval auto_shrink as gint)
declare sub gtk_window_position alias "gtk_window_set_position"(byval window as GtkWindow ptr, byval position as GtkWindowPosition)
declare sub gtk_window_set_default_size(byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_get_default_size(byval window as GtkWindow ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_window_resize(byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_get_size(byval window as GtkWindow ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_window_move(byval window as GtkWindow ptr, byval x as gint, byval y as gint)
declare sub gtk_window_get_position(byval window as GtkWindow ptr, byval root_x as gint ptr, byval root_y as gint ptr)
declare function gtk_window_parse_geometry(byval window as GtkWindow ptr, byval geometry as const gchar ptr) as gboolean
declare function gtk_window_get_group(byval window as GtkWindow ptr) as GtkWindowGroup ptr
declare function gtk_window_has_group(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_reshow_with_initial_size(byval window as GtkWindow ptr)
declare function gtk_window_get_window_type(byval window as GtkWindow ptr) as GtkWindowType
declare function gtk_window_group_get_type() as GType
declare function gtk_window_group_new() as GtkWindowGroup ptr
declare sub gtk_window_group_add_window(byval window_group as GtkWindowGroup ptr, byval window as GtkWindow ptr)
declare sub gtk_window_group_remove_window(byval window_group as GtkWindowGroup ptr, byval window as GtkWindow ptr)
declare function gtk_window_group_list_windows(byval window_group as GtkWindowGroup ptr) as GList ptr
declare sub _gtk_window_internal_set_focus(byval window as GtkWindow ptr, byval focus as GtkWidget ptr)
declare sub gtk_window_remove_embedded_xid(byval window as GtkWindow ptr, byval xid as GdkNativeWindow)
declare sub gtk_window_add_embedded_xid(byval window as GtkWindow ptr, byval xid as GdkNativeWindow)
declare sub _gtk_window_reposition(byval window as GtkWindow ptr, byval x as gint, byval y as gint)
declare sub _gtk_window_constrain_size(byval window as GtkWindow ptr, byval width as gint, byval height as gint, byval new_width as gint ptr, byval new_height as gint ptr)
declare function gtk_window_group_get_current_grab(byval window_group as GtkWindowGroup ptr) as GtkWidget ptr
declare sub _gtk_window_set_has_toplevel_focus(byval window as GtkWindow ptr, byval has_toplevel_focus as gboolean)
declare sub _gtk_window_unset_focus_and_default(byval window as GtkWindow ptr, byval widget as GtkWidget ptr)
declare sub _gtk_window_set_is_active(byval window as GtkWindow ptr, byval is_active as gboolean)
declare sub _gtk_window_set_is_toplevel(byval window as GtkWindow ptr, byval is_toplevel as gboolean)
type GtkWindowKeysForeachFunc as sub(byval window as GtkWindow ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval is_mnemonic as gboolean, byval data as gpointer)
declare sub _gtk_window_keys_foreach(byval window as GtkWindow ptr, byval func as GtkWindowKeysForeachFunc, byval func_data as gpointer)
declare function _gtk_window_query_nonaccels(byval window as GtkWindow ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean

type GtkDialogFlags as long
enum
	GTK_DIALOG_MODAL = 1 shl 0
	GTK_DIALOG_DESTROY_WITH_PARENT = 1 shl 1
	GTK_DIALOG_NO_SEPARATOR = 1 shl 2
end enum

type GtkResponseType as long
enum
	GTK_RESPONSE_NONE = -1
	GTK_RESPONSE_REJECT = -2
	GTK_RESPONSE_ACCEPT = -3
	GTK_RESPONSE_DELETE_EVENT = -4
	GTK_RESPONSE_OK = -5
	GTK_RESPONSE_CANCEL = -6
	GTK_RESPONSE_CLOSE = -7
	GTK_RESPONSE_YES = -8
	GTK_RESPONSE_NO = -9
	GTK_RESPONSE_APPLY = -10
	GTK_RESPONSE_HELP = -11
end enum

#define GTK_TYPE_DIALOG gtk_dialog_get_type()
#define GTK_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_DIALOG, GtkDialog)
#define GTK_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_DIALOG, GtkDialogClass)
#define GTK_IS_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_DIALOG)
#define GTK_IS_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_DIALOG)
#define GTK_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_DIALOG, GtkDialogClass)
type GtkDialog as _GtkDialog
type GtkDialogClass as _GtkDialogClass

type _GtkDialog
	window as GtkWindow
	vbox as GtkWidget ptr
	action_area as GtkWidget ptr
	separator as GtkWidget ptr
end type

type _GtkDialogClass
	parent_class as GtkWindowClass
	response as sub(byval dialog as GtkDialog ptr, byval response_id as gint)
	close as sub(byval dialog as GtkDialog ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_dialog_get_type() as GType
declare function gtk_dialog_new() as GtkWidget ptr
declare function gtk_dialog_new_with_buttons(byval title as const gchar ptr, byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval first_button_text as const gchar ptr, ...) as GtkWidget ptr
declare sub gtk_dialog_add_action_widget(byval dialog as GtkDialog ptr, byval child as GtkWidget ptr, byval response_id as gint)
declare function gtk_dialog_add_button(byval dialog as GtkDialog ptr, byval button_text as const gchar ptr, byval response_id as gint) as GtkWidget ptr
declare sub gtk_dialog_add_buttons(byval dialog as GtkDialog ptr, byval first_button_text as const gchar ptr, ...)
declare sub gtk_dialog_set_response_sensitive(byval dialog as GtkDialog ptr, byval response_id as gint, byval setting as gboolean)
declare sub gtk_dialog_set_default_response(byval dialog as GtkDialog ptr, byval response_id as gint)
declare function gtk_dialog_get_widget_for_response(byval dialog as GtkDialog ptr, byval response_id as gint) as GtkWidget ptr
declare function gtk_dialog_get_response_for_widget(byval dialog as GtkDialog ptr, byval widget as GtkWidget ptr) as gint
declare sub gtk_dialog_set_has_separator(byval dialog as GtkDialog ptr, byval setting as gboolean)
declare function gtk_dialog_get_has_separator(byval dialog as GtkDialog ptr) as gboolean
declare function gtk_alternative_dialog_button_order(byval screen as GdkScreen ptr) as gboolean
declare sub gtk_dialog_set_alternative_button_order(byval dialog as GtkDialog ptr, byval first_response_id as gint, ...)
declare sub gtk_dialog_set_alternative_button_order_from_array(byval dialog as GtkDialog ptr, byval n_params as gint, byval new_order as gint ptr)
declare sub gtk_dialog_response(byval dialog as GtkDialog ptr, byval response_id as gint)
declare function gtk_dialog_run(byval dialog as GtkDialog ptr) as gint
declare function gtk_dialog_get_action_area(byval dialog as GtkDialog ptr) as GtkWidget ptr
declare function gtk_dialog_get_content_area(byval dialog as GtkDialog ptr) as GtkWidget ptr
declare sub _gtk_dialog_set_ignore_separator(byval dialog as GtkDialog ptr, byval ignore_separator as gboolean)

#define GTK_TYPE_ABOUT_DIALOG gtk_about_dialog_get_type()
#define GTK_ABOUT_DIALOG(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialog)
#define GTK_ABOUT_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass)
#define GTK_IS_ABOUT_DIALOG(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_ABOUT_DIALOG)
#define GTK_IS_ABOUT_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ABOUT_DIALOG)
#define GTK_ABOUT_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass)
type GtkAboutDialog as _GtkAboutDialog
type GtkAboutDialogClass as _GtkAboutDialogClass

type _GtkAboutDialog
	parent_instance as GtkDialog
	private_data as gpointer
end type

type _GtkAboutDialogClass
	parent_class as GtkDialogClass
	activate_link as function(byval dialog as GtkAboutDialog ptr, byval uri as const gchar ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_about_dialog_get_type() as GType
declare function gtk_about_dialog_new() as GtkWidget ptr
declare sub gtk_show_about_dialog(byval parent as GtkWindow ptr, byval first_property_name as const gchar ptr, ...)
declare function gtk_about_dialog_get_name(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_name(byval about as GtkAboutDialog ptr, byval name as const gchar ptr)
declare function gtk_about_dialog_get_program_name(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_program_name(byval about as GtkAboutDialog ptr, byval name as const gchar ptr)
declare function gtk_about_dialog_get_version(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_version(byval about as GtkAboutDialog ptr, byval version as const gchar ptr)
declare function gtk_about_dialog_get_copyright(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_copyright(byval about as GtkAboutDialog ptr, byval copyright as const gchar ptr)
declare function gtk_about_dialog_get_comments(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_comments(byval about as GtkAboutDialog ptr, byval comments as const gchar ptr)
declare function gtk_about_dialog_get_license(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_license(byval about as GtkAboutDialog ptr, byval license as const gchar ptr)
declare function gtk_about_dialog_get_wrap_license(byval about as GtkAboutDialog ptr) as gboolean
declare sub gtk_about_dialog_set_wrap_license(byval about as GtkAboutDialog ptr, byval wrap_license as gboolean)
declare function gtk_about_dialog_get_website(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_website(byval about as GtkAboutDialog ptr, byval website as const gchar ptr)
declare function gtk_about_dialog_get_website_label(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_website_label(byval about as GtkAboutDialog ptr, byval website_label as const gchar ptr)
declare function gtk_about_dialog_get_authors(byval about as GtkAboutDialog ptr) as const gchar const ptr ptr
declare sub gtk_about_dialog_set_authors(byval about as GtkAboutDialog ptr, byval authors as const gchar ptr ptr)
declare function gtk_about_dialog_get_documenters(byval about as GtkAboutDialog ptr) as const gchar const ptr ptr
declare sub gtk_about_dialog_set_documenters(byval about as GtkAboutDialog ptr, byval documenters as const gchar ptr ptr)
declare function gtk_about_dialog_get_artists(byval about as GtkAboutDialog ptr) as const gchar const ptr ptr
declare sub gtk_about_dialog_set_artists(byval about as GtkAboutDialog ptr, byval artists as const gchar ptr ptr)
declare function gtk_about_dialog_get_translator_credits(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_translator_credits(byval about as GtkAboutDialog ptr, byval translator_credits as const gchar ptr)
declare function gtk_about_dialog_get_logo(byval about as GtkAboutDialog ptr) as GdkPixbuf ptr
declare sub gtk_about_dialog_set_logo(byval about as GtkAboutDialog ptr, byval logo as GdkPixbuf ptr)
declare function gtk_about_dialog_get_logo_icon_name(byval about as GtkAboutDialog ptr) as const gchar ptr
declare sub gtk_about_dialog_set_logo_icon_name(byval about as GtkAboutDialog ptr, byval icon_name as const gchar ptr)
type GtkAboutDialogActivateLinkFunc as sub(byval about as GtkAboutDialog ptr, byval link_ as const gchar ptr, byval data as gpointer)
declare function gtk_about_dialog_set_email_hook(byval func as GtkAboutDialogActivateLinkFunc, byval data as gpointer, byval destroy as GDestroyNotify) as GtkAboutDialogActivateLinkFunc
declare function gtk_about_dialog_set_url_hook(byval func as GtkAboutDialogActivateLinkFunc, byval data as gpointer, byval destroy as GDestroyNotify) as GtkAboutDialogActivateLinkFunc

#define __GTK_ACCEL_LABEL_H__
#define __GTK_LABEL_H__
#define __GTK_MISC_H__
#define GTK_TYPE_MISC gtk_misc_get_type()
#define GTK_MISC(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MISC, GtkMisc)
#define GTK_MISC_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MISC, GtkMiscClass)
#define GTK_IS_MISC(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MISC)
#define GTK_IS_MISC_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MISC)
#define GTK_MISC_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MISC, GtkMiscClass)
type GtkMisc as _GtkMisc
type GtkMiscClass as _GtkMiscClass

type _GtkMisc
	widget as GtkWidget
	xalign as gfloat
	yalign as gfloat
	xpad as guint16
	ypad as guint16
end type

type _GtkMiscClass
	parent_class as GtkWidgetClass
end type

declare function gtk_misc_get_type() as GType
declare sub gtk_misc_set_alignment(byval misc as GtkMisc ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_misc_get_alignment(byval misc as GtkMisc ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_misc_set_padding(byval misc as GtkMisc ptr, byval xpad as gint, byval ypad as gint)
declare sub gtk_misc_get_padding(byval misc as GtkMisc ptr, byval xpad as gint ptr, byval ypad as gint ptr)

#define __GTK_MENU_H__
#define __GTK_MENU_SHELL_H__
#define GTK_TYPE_MENU_SHELL gtk_menu_shell_get_type()
#define GTK_MENU_SHELL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU_SHELL, GtkMenuShell)
#define GTK_MENU_SHELL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU_SHELL, GtkMenuShellClass)
#define GTK_IS_MENU_SHELL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU_SHELL)
#define GTK_IS_MENU_SHELL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU_SHELL)
#define GTK_MENU_SHELL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU_SHELL, GtkMenuShellClass)
type GtkMenuShell as _GtkMenuShell
type GtkMenuShellClass as _GtkMenuShellClass

type _GtkMenuShell
	container as GtkContainer
	children as GList ptr
	active_menu_item as GtkWidget ptr
	parent_menu_shell as GtkWidget ptr
	button as guint
	activate_time as guint32
	active : 1 as guint
	have_grab : 1 as guint
	have_xgrab : 1 as guint
	ignore_leave : 1 as guint
	menu_flag : 1 as guint
	ignore_enter : 1 as guint
	keyboard_mode : 1 as guint
end type

type _GtkMenuShellClass
	parent_class as GtkContainerClass
	submenu_placement : 1 as guint
	deactivate as sub(byval menu_shell as GtkMenuShell ptr)
	selection_done as sub(byval menu_shell as GtkMenuShell ptr)
	move_current as sub(byval menu_shell as GtkMenuShell ptr, byval direction as GtkMenuDirectionType)
	activate_current as sub(byval menu_shell as GtkMenuShell ptr, byval force_hide as gboolean)
	cancel as sub(byval menu_shell as GtkMenuShell ptr)
	select_item as sub(byval menu_shell as GtkMenuShell ptr, byval menu_item as GtkWidget ptr)
	insert as sub(byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr, byval position as gint)
	get_popup_delay as function(byval menu_shell as GtkMenuShell ptr) as gint
	move_selected as function(byval menu_shell as GtkMenuShell ptr, byval distance as gint) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_menu_shell_get_type() as GType
declare sub gtk_menu_shell_append(byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr)
declare sub gtk_menu_shell_prepend(byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr)
declare sub gtk_menu_shell_insert(byval menu_shell as GtkMenuShell ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_menu_shell_deactivate(byval menu_shell as GtkMenuShell ptr)
declare sub gtk_menu_shell_select_item(byval menu_shell as GtkMenuShell ptr, byval menu_item as GtkWidget ptr)
declare sub gtk_menu_shell_deselect(byval menu_shell as GtkMenuShell ptr)
declare sub gtk_menu_shell_activate_item(byval menu_shell as GtkMenuShell ptr, byval menu_item as GtkWidget ptr, byval force_deactivate as gboolean)
declare sub gtk_menu_shell_select_first(byval menu_shell as GtkMenuShell ptr, byval search_sensitive as gboolean)
declare sub _gtk_menu_shell_select_last(byval menu_shell as GtkMenuShell ptr, byval search_sensitive as gboolean)
declare sub _gtk_menu_shell_activate(byval menu_shell as GtkMenuShell ptr)
declare function _gtk_menu_shell_get_popup_delay(byval menu_shell as GtkMenuShell ptr) as gint
declare sub gtk_menu_shell_cancel(byval menu_shell as GtkMenuShell ptr)
declare sub _gtk_menu_shell_add_mnemonic(byval menu_shell as GtkMenuShell ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare sub _gtk_menu_shell_remove_mnemonic(byval menu_shell as GtkMenuShell ptr, byval keyval as guint, byval target as GtkWidget ptr)
declare function gtk_menu_shell_get_take_focus(byval menu_shell as GtkMenuShell ptr) as gboolean
declare sub gtk_menu_shell_set_take_focus(byval menu_shell as GtkMenuShell ptr, byval take_focus as gboolean)
declare sub _gtk_menu_shell_update_mnemonics(byval menu_shell as GtkMenuShell ptr)
declare sub _gtk_menu_shell_set_keyboard_mode(byval menu_shell as GtkMenuShell ptr, byval keyboard_mode as gboolean)
declare function _gtk_menu_shell_get_keyboard_mode(byval menu_shell as GtkMenuShell ptr) as gboolean

#define GTK_TYPE_MENU gtk_menu_get_type()
#define GTK_MENU(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU, GtkMenu)
#define GTK_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU, GtkMenuClass)
#define GTK_IS_MENU(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU)
#define GTK_IS_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU)
#define GTK_MENU_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU, GtkMenuClass)

type GtkMenu as _GtkMenu
type GtkMenuClass as _GtkMenuClass
type GtkMenuPositionFunc as sub(byval menu as GtkMenu ptr, byval x as gint ptr, byval y as gint ptr, byval push_in as gboolean ptr, byval user_data as gpointer)
type GtkMenuDetachFunc as sub(byval attach_widget as GtkWidget ptr, byval menu as GtkMenu ptr)

type _GtkMenu
	menu_shell as GtkMenuShell
	parent_menu_item as GtkWidget ptr
	old_active_menu_item as GtkWidget ptr
	accel_group as GtkAccelGroup ptr
	accel_path as gchar ptr
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
	needs_destruction_ref_count : 1 as guint
	torn_off : 1 as guint
	tearoff_active : 1 as guint
	scroll_fast : 1 as guint
	upper_arrow_visible : 1 as guint
	lower_arrow_visible : 1 as guint
	upper_arrow_prelight : 1 as guint
	lower_arrow_prelight : 1 as guint
end type

type _GtkMenuClass
	parent_class as GtkMenuShellClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_menu_get_type() as GType
declare function gtk_menu_new() as GtkWidget ptr
declare sub gtk_menu_popup(byval menu as GtkMenu ptr, byval parent_menu_shell as GtkWidget ptr, byval parent_menu_item as GtkWidget ptr, byval func as GtkMenuPositionFunc, byval data as gpointer, byval button as guint, byval activate_time as guint32)
declare sub gtk_menu_reposition(byval menu as GtkMenu ptr)
declare sub gtk_menu_popdown(byval menu as GtkMenu ptr)
declare function gtk_menu_get_active(byval menu as GtkMenu ptr) as GtkWidget ptr
declare sub gtk_menu_set_active(byval menu as GtkMenu ptr, byval index_ as guint)
declare sub gtk_menu_set_accel_group(byval menu as GtkMenu ptr, byval accel_group as GtkAccelGroup ptr)
declare function gtk_menu_get_accel_group(byval menu as GtkMenu ptr) as GtkAccelGroup ptr
declare sub gtk_menu_set_accel_path(byval menu as GtkMenu ptr, byval accel_path as const gchar ptr)
declare function gtk_menu_get_accel_path(byval menu as GtkMenu ptr) as const gchar ptr
declare sub gtk_menu_attach_to_widget(byval menu as GtkMenu ptr, byval attach_widget as GtkWidget ptr, byval detacher as GtkMenuDetachFunc)
declare sub gtk_menu_detach(byval menu as GtkMenu ptr)
declare function gtk_menu_get_attach_widget(byval menu as GtkMenu ptr) as GtkWidget ptr
declare sub gtk_menu_set_tearoff_state(byval menu as GtkMenu ptr, byval torn_off as gboolean)
declare function gtk_menu_get_tearoff_state(byval menu as GtkMenu ptr) as gboolean
declare sub gtk_menu_set_title(byval menu as GtkMenu ptr, byval title as const gchar ptr)
declare function gtk_menu_get_title(byval menu as GtkMenu ptr) as const gchar ptr
declare sub gtk_menu_reorder_child(byval menu as GtkMenu ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_menu_set_screen(byval menu as GtkMenu ptr, byval screen as GdkScreen ptr)
declare sub gtk_menu_attach(byval menu as GtkMenu ptr, byval child as GtkWidget ptr, byval left_attach as guint, byval right_attach as guint, byval top_attach as guint, byval bottom_attach as guint)
declare sub gtk_menu_set_monitor(byval menu as GtkMenu ptr, byval monitor_num as gint)
declare function gtk_menu_get_monitor(byval menu as GtkMenu ptr) as gint
declare function gtk_menu_get_for_attach_widget(byval widget as GtkWidget ptr) as GList ptr

#define gtk_menu_append(menu, child) gtk_menu_shell_append(cptr(GtkMenuShell ptr, (menu)), (child))
#define gtk_menu_prepend(menu, child) gtk_menu_shell_prepend(cptr(GtkMenuShell ptr, (menu)), (child))
#define gtk_menu_insert(menu, child, pos) gtk_menu_shell_insert(cptr(GtkMenuShell ptr, (menu)), (child), (pos))
declare sub gtk_menu_set_reserve_toggle_size(byval menu as GtkMenu ptr, byval reserve_toggle_size as gboolean)
declare function gtk_menu_get_reserve_toggle_size(byval menu as GtkMenu ptr) as gboolean
#define GTK_TYPE_LABEL gtk_label_get_type()
#define GTK_LABEL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LABEL, GtkLabel)
#define GTK_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LABEL, GtkLabelClass)
#define GTK_IS_LABEL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LABEL)
#define GTK_IS_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LABEL)
#define GTK_LABEL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LABEL, GtkLabelClass)

type GtkLabel as _GtkLabel
type GtkLabelClass as _GtkLabelClass
type GtkLabelSelectionInfo as _GtkLabelSelectionInfo

type _GtkLabel
	misc as GtkMisc
	label as gchar ptr
	jtype : 2 as guint
	wrap : 1 as guint
	use_underline : 1 as guint
	use_markup : 1 as guint
	ellipsize : 3 as guint
	single_line_mode : 1 as guint
	have_transform : 1 as guint
	in_click : 1 as guint
	wrap_mode : 3 as guint
	pattern_set : 1 as guint
	track_links : 1 as guint
	mnemonic_keyval as guint
	text as gchar ptr
	attrs as PangoAttrList ptr
	effective_attrs as PangoAttrList ptr
	layout as PangoLayout ptr
	mnemonic_widget as GtkWidget ptr
	mnemonic_window as GtkWindow ptr
	select_info as GtkLabelSelectionInfo ptr
end type

type _GtkLabelClass
	parent_class as GtkMiscClass
	move_cursor as sub(byval label as GtkLabel ptr, byval step as GtkMovementStep, byval count as gint, byval extend_selection as gboolean)
	copy_clipboard as sub(byval label as GtkLabel ptr)
	populate_popup as sub(byval label as GtkLabel ptr, byval menu as GtkMenu ptr)
	activate_link as function(byval label as GtkLabel ptr, byval uri as const gchar ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_label_get_type() as GType
declare function gtk_label_new(byval str as const gchar ptr) as GtkWidget ptr
declare function gtk_label_new_with_mnemonic(byval str as const gchar ptr) as GtkWidget ptr
declare sub gtk_label_set_text(byval label as GtkLabel ptr, byval str as const gchar ptr)
declare function gtk_label_get_text(byval label as GtkLabel ptr) as const gchar ptr
declare sub gtk_label_set_attributes(byval label as GtkLabel ptr, byval attrs as PangoAttrList ptr)
declare function gtk_label_get_attributes(byval label as GtkLabel ptr) as PangoAttrList ptr
declare sub gtk_label_set_label(byval label as GtkLabel ptr, byval str as const gchar ptr)
declare function gtk_label_get_label(byval label as GtkLabel ptr) as const gchar ptr
declare sub gtk_label_set_markup(byval label as GtkLabel ptr, byval str as const gchar ptr)
declare sub gtk_label_set_use_markup(byval label as GtkLabel ptr, byval setting as gboolean)
declare function gtk_label_get_use_markup(byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_use_underline(byval label as GtkLabel ptr, byval setting as gboolean)
declare function gtk_label_get_use_underline(byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_markup_with_mnemonic(byval label as GtkLabel ptr, byval str as const gchar ptr)
declare function gtk_label_get_mnemonic_keyval(byval label as GtkLabel ptr) as guint
declare sub gtk_label_set_mnemonic_widget(byval label as GtkLabel ptr, byval widget as GtkWidget ptr)
declare function gtk_label_get_mnemonic_widget(byval label as GtkLabel ptr) as GtkWidget ptr
declare sub gtk_label_set_text_with_mnemonic(byval label as GtkLabel ptr, byval str as const gchar ptr)
declare sub gtk_label_set_justify(byval label as GtkLabel ptr, byval jtype as GtkJustification)
declare function gtk_label_get_justify(byval label as GtkLabel ptr) as GtkJustification
declare sub gtk_label_set_ellipsize(byval label as GtkLabel ptr, byval mode as PangoEllipsizeMode)
declare function gtk_label_get_ellipsize(byval label as GtkLabel ptr) as PangoEllipsizeMode
declare sub gtk_label_set_width_chars(byval label as GtkLabel ptr, byval n_chars as gint)
declare function gtk_label_get_width_chars(byval label as GtkLabel ptr) as gint
declare sub gtk_label_set_max_width_chars(byval label as GtkLabel ptr, byval n_chars as gint)
declare function gtk_label_get_max_width_chars(byval label as GtkLabel ptr) as gint
declare sub gtk_label_set_pattern(byval label as GtkLabel ptr, byval pattern as const gchar ptr)
declare sub gtk_label_set_line_wrap(byval label as GtkLabel ptr, byval wrap as gboolean)
declare function gtk_label_get_line_wrap(byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_line_wrap_mode(byval label as GtkLabel ptr, byval wrap_mode as PangoWrapMode)
declare function gtk_label_get_line_wrap_mode(byval label as GtkLabel ptr) as PangoWrapMode
declare sub gtk_label_set_selectable(byval label as GtkLabel ptr, byval setting as gboolean)
declare function gtk_label_get_selectable(byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set_angle(byval label as GtkLabel ptr, byval angle as gdouble)
declare function gtk_label_get_angle(byval label as GtkLabel ptr) as gdouble
declare sub gtk_label_select_region(byval label as GtkLabel ptr, byval start_offset as gint, byval end_offset as gint)
declare function gtk_label_get_selection_bounds(byval label as GtkLabel ptr, byval start as gint ptr, byval end as gint ptr) as gboolean
declare function gtk_label_get_layout(byval label as GtkLabel ptr) as PangoLayout ptr
declare sub gtk_label_get_layout_offsets(byval label as GtkLabel ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gtk_label_set_single_line_mode(byval label as GtkLabel ptr, byval single_line_mode as gboolean)
declare function gtk_label_get_single_line_mode(byval label as GtkLabel ptr) as gboolean
declare function gtk_label_get_current_uri(byval label as GtkLabel ptr) as const gchar ptr
declare sub gtk_label_set_track_visited_links(byval label as GtkLabel ptr, byval track_links as gboolean)
declare function gtk_label_get_track_visited_links(byval label as GtkLabel ptr) as gboolean
declare sub gtk_label_set alias "gtk_label_set_text"(byval label as GtkLabel ptr, byval str as const gchar ptr)
declare sub gtk_label_get(byval label as GtkLabel ptr, byval str as gchar ptr ptr)
declare function gtk_label_parse_uline(byval label as GtkLabel ptr, byval string as const gchar ptr) as guint
declare sub _gtk_label_mnemonics_visible_apply_recursively(byval widget as GtkWidget ptr, byval mnemonics_visible as gboolean)

#define GTK_TYPE_ACCEL_LABEL gtk_accel_label_get_type()
#define GTK_ACCEL_LABEL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACCEL_LABEL, GtkAccelLabel)
#define GTK_ACCEL_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACCEL_LABEL, GtkAccelLabelClass)
#define GTK_IS_ACCEL_LABEL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACCEL_LABEL)
#define GTK_IS_ACCEL_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACCEL_LABEL)
#define GTK_ACCEL_LABEL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACCEL_LABEL, GtkAccelLabelClass)
type GtkAccelLabel as _GtkAccelLabel
type GtkAccelLabelClass as _GtkAccelLabelClass

type _GtkAccelLabel
	label as GtkLabel
	gtk_reserved as guint
	accel_padding as guint
	accel_widget as GtkWidget ptr
	accel_closure as GClosure ptr
	accel_group as GtkAccelGroup ptr
	accel_string as gchar ptr
	accel_string_width as guint16
end type

type _GtkAccelLabelClass
	parent_class as GtkLabelClass
	signal_quote1 as gchar ptr
	signal_quote2 as gchar ptr
	mod_name_shift as gchar ptr
	mod_name_control as gchar ptr
	mod_name_alt as gchar ptr
	mod_separator as gchar ptr
	accel_seperator as gchar ptr
	latin1_to_char : 1 as guint
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_accel_label_get_type() as GType
declare function gtk_accel_label_new(byval string as const gchar ptr) as GtkWidget ptr
declare function gtk_accel_label_get_accel_widget(byval accel_label as GtkAccelLabel ptr) as GtkWidget ptr
declare function gtk_accel_label_get_accel_width(byval accel_label as GtkAccelLabel ptr) as guint
declare function gtk_accel_label_accelerator_width alias "gtk_accel_label_get_accel_width"(byval accel_label as GtkAccelLabel ptr) as guint
declare sub gtk_accel_label_set_accel_widget(byval accel_label as GtkAccelLabel ptr, byval accel_widget as GtkWidget ptr)
declare sub gtk_accel_label_set_accel_closure(byval accel_label as GtkAccelLabel ptr, byval accel_closure as GClosure ptr)
declare function gtk_accel_label_refetch(byval accel_label as GtkAccelLabel ptr) as gboolean
declare function _gtk_accel_label_class_get_accelerator_label(byval klass as GtkAccelLabelClass ptr, byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as gchar ptr

#define __GTK_ACCEL_MAP_H__
#define GTK_TYPE_ACCEL_MAP gtk_accel_map_get_type()
#define GTK_ACCEL_MAP(accel_map) G_TYPE_CHECK_INSTANCE_CAST((accel_map), GTK_TYPE_ACCEL_MAP, GtkAccelMap)
#define GTK_ACCEL_MAP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACCEL_MAP, GtkAccelMapClass)
#define GTK_IS_ACCEL_MAP(accel_map) G_TYPE_CHECK_INSTANCE_TYPE((accel_map), GTK_TYPE_ACCEL_MAP)
#define GTK_IS_ACCEL_MAP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACCEL_MAP)
#define GTK_ACCEL_MAP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACCEL_MAP, GtkAccelMapClass)

type GtkAccelMap as _GtkAccelMap
type GtkAccelMapClass as _GtkAccelMapClass
type GtkAccelMapForeach as sub(byval data as gpointer, byval accel_path as const gchar ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval changed as gboolean)

declare sub gtk_accel_map_add_entry(byval accel_path as const gchar ptr, byval accel_key as guint, byval accel_mods as GdkModifierType)
declare function gtk_accel_map_lookup_entry(byval accel_path as const gchar ptr, byval key as GtkAccelKey ptr) as gboolean
declare function gtk_accel_map_change_entry(byval accel_path as const gchar ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval replace as gboolean) as gboolean

#ifdef __FB_UNIX__
	declare sub gtk_accel_map_load(byval file_name as const gchar ptr)
	declare sub gtk_accel_map_save(byval file_name as const gchar ptr)
#else
	declare sub gtk_accel_map_load_utf8(byval file_name as const gchar ptr)
	declare sub gtk_accel_map_load alias "gtk_accel_map_load_utf8"(byval file_name as const gchar ptr)
	declare sub gtk_accel_map_save_utf8(byval file_name as const gchar ptr)
	declare sub gtk_accel_map_save alias "gtk_accel_map_save_utf8"(byval file_name as const gchar ptr)
#endif

declare sub gtk_accel_map_foreach(byval data as gpointer, byval foreach_func as GtkAccelMapForeach)
declare sub gtk_accel_map_load_fd(byval fd as gint)
declare sub gtk_accel_map_load_scanner(byval scanner as GScanner ptr)
declare sub gtk_accel_map_save_fd(byval fd as gint)
declare sub gtk_accel_map_lock_path(byval accel_path as const gchar ptr)
declare sub gtk_accel_map_unlock_path(byval accel_path as const gchar ptr)
declare sub gtk_accel_map_add_filter(byval filter_pattern as const gchar ptr)
declare sub gtk_accel_map_foreach_unfiltered(byval data as gpointer, byval foreach_func as GtkAccelMapForeach)
declare function gtk_accel_map_get_type() as GType
declare function gtk_accel_map_get() as GtkAccelMap ptr
declare sub _gtk_accel_map_init()
declare sub _gtk_accel_map_add_group(byval accel_path as const gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare sub _gtk_accel_map_remove_group(byval accel_path as const gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare function _gtk_accel_path_is_valid(byval accel_path as const gchar ptr) as gboolean

#define __GTK_ACCESSIBLE_H__
#define GTK_TYPE_ACCESSIBLE gtk_accessible_get_type()
#define GTK_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACCESSIBLE, GtkAccessible)
#define GTK_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass)
#define GTK_IS_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACCESSIBLE)
#define GTK_IS_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACCESSIBLE)
#define GTK_ACCESSIBLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass)
type GtkAccessible as _GtkAccessible
type GtkAccessibleClass as _GtkAccessibleClass

type _GtkAccessible
	parent as AtkObject
	widget as GtkWidget ptr
end type

type _GtkAccessibleClass
	parent_class as AtkObjectClass
	connect_widget_destroyed as sub(byval accessible as GtkAccessible ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_accessible_get_type() as GType
declare sub gtk_accessible_set_widget(byval accessible as GtkAccessible ptr, byval widget as GtkWidget ptr)
declare function gtk_accessible_get_widget(byval accessible as GtkAccessible ptr) as GtkWidget ptr
declare sub gtk_accessible_connect_widget_destroyed(byval accessible as GtkAccessible ptr)

#define __GTK_ACTION_H__
#define GTK_TYPE_ACTION gtk_action_get_type()
#define GTK_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACTION, GtkAction)
#define GTK_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACTION, GtkActionClass)
#define GTK_IS_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACTION)
#define GTK_IS_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACTION)
#define GTK_ACTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACTION, GtkActionClass)

type GtkAction as _GtkAction
type GtkActionClass as _GtkActionClass
type GtkActionPrivate as _GtkActionPrivate

type _GtkAction
	object as GObject
	private_data as GtkActionPrivate ptr
end type

type _GtkActionClass
	parent_class as GObjectClass
	activate as sub(byval action as GtkAction ptr)
	menu_item_type as GType
	toolbar_item_type as GType
	create_menu_item as function(byval action as GtkAction ptr) as GtkWidget ptr
	create_tool_item as function(byval action as GtkAction ptr) as GtkWidget ptr
	connect_proxy as sub(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
	disconnect_proxy as sub(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
	create_menu as function(byval action as GtkAction ptr) as GtkWidget ptr
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_action_get_type() as GType
declare function gtk_action_new(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr) as GtkAction ptr
declare function gtk_action_get_name(byval action as GtkAction ptr) as const gchar ptr
declare function gtk_action_is_sensitive(byval action as GtkAction ptr) as gboolean
declare function gtk_action_get_sensitive(byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_sensitive(byval action as GtkAction ptr, byval sensitive as gboolean)
declare function gtk_action_is_visible(byval action as GtkAction ptr) as gboolean
declare function gtk_action_get_visible(byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_visible(byval action as GtkAction ptr, byval visible as gboolean)
declare sub gtk_action_activate(byval action as GtkAction ptr)
declare function gtk_action_create_icon(byval action as GtkAction ptr, byval icon_size as GtkIconSize) as GtkWidget ptr
declare function gtk_action_create_menu_item(byval action as GtkAction ptr) as GtkWidget ptr
declare function gtk_action_create_tool_item(byval action as GtkAction ptr) as GtkWidget ptr
declare function gtk_action_create_menu(byval action as GtkAction ptr) as GtkWidget ptr
declare function gtk_action_get_proxies(byval action as GtkAction ptr) as GSList ptr
declare sub gtk_action_connect_accelerator(byval action as GtkAction ptr)
declare sub gtk_action_disconnect_accelerator(byval action as GtkAction ptr)
declare function gtk_action_get_accel_path(byval action as GtkAction ptr) as const gchar ptr
declare function gtk_action_get_accel_closure(byval action as GtkAction ptr) as GClosure ptr
declare function gtk_widget_get_action(byval widget as GtkWidget ptr) as GtkAction ptr
declare sub gtk_action_connect_proxy(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub gtk_action_disconnect_proxy(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub gtk_action_block_activate_from(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub gtk_action_unblock_activate_from(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub gtk_action_block_activate(byval action as GtkAction ptr)
declare sub gtk_action_unblock_activate(byval action as GtkAction ptr)
declare sub _gtk_action_add_to_proxy_list(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_remove_from_proxy_list(byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_emit_activate(byval action as GtkAction ptr)
declare sub gtk_action_set_accel_path(byval action as GtkAction ptr, byval accel_path as const gchar ptr)
declare sub gtk_action_set_accel_group(byval action as GtkAction ptr, byval accel_group as GtkAccelGroup ptr)
declare sub _gtk_action_sync_menu_visible(byval action as GtkAction ptr, byval proxy as GtkWidget ptr, byval empty as gboolean)
declare sub gtk_action_set_label(byval action as GtkAction ptr, byval label as const gchar ptr)
declare function gtk_action_get_label(byval action as GtkAction ptr) as const gchar ptr
declare sub gtk_action_set_short_label(byval action as GtkAction ptr, byval short_label as const gchar ptr)
declare function gtk_action_get_short_label(byval action as GtkAction ptr) as const gchar ptr
declare sub gtk_action_set_tooltip(byval action as GtkAction ptr, byval tooltip as const gchar ptr)
declare function gtk_action_get_tooltip(byval action as GtkAction ptr) as const gchar ptr
declare sub gtk_action_set_stock_id(byval action as GtkAction ptr, byval stock_id as const gchar ptr)
declare function gtk_action_get_stock_id(byval action as GtkAction ptr) as const gchar ptr
declare sub gtk_action_set_gicon(byval action as GtkAction ptr, byval icon as GIcon ptr)
declare function gtk_action_get_gicon(byval action as GtkAction ptr) as GIcon ptr
declare sub gtk_action_set_icon_name(byval action as GtkAction ptr, byval icon_name as const gchar ptr)
declare function gtk_action_get_icon_name(byval action as GtkAction ptr) as const gchar ptr
declare sub gtk_action_set_visible_horizontal(byval action as GtkAction ptr, byval visible_horizontal as gboolean)
declare function gtk_action_get_visible_horizontal(byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_visible_vertical(byval action as GtkAction ptr, byval visible_vertical as gboolean)
declare function gtk_action_get_visible_vertical(byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_is_important(byval action as GtkAction ptr, byval is_important as gboolean)
declare function gtk_action_get_is_important(byval action as GtkAction ptr) as gboolean
declare sub gtk_action_set_always_show_image(byval action as GtkAction ptr, byval always_show as gboolean)
declare function gtk_action_get_always_show_image(byval action as GtkAction ptr) as gboolean

#define __GTK_ACTION_GROUP_H__
#define GTK_TYPE_ACTION_GROUP gtk_action_group_get_type()
#define GTK_ACTION_GROUP(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACTION_GROUP, GtkActionGroup)
#define GTK_ACTION_GROUP_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_ACTION_GROUP, GtkActionGroupClass)
#define GTK_IS_ACTION_GROUP(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACTION_GROUP)
#define GTK_IS_ACTION_GROUP_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_ACTION_GROUP)
#define GTK_ACTION_GROUP_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), GTK_TYPE_ACTION_GROUP, GtkActionGroupClass)

type GtkActionGroup as _GtkActionGroup
type GtkActionGroupPrivate as _GtkActionGroupPrivate
type GtkActionGroupClass as _GtkActionGroupClass
type GtkActionEntry as _GtkActionEntry
type GtkToggleActionEntry as _GtkToggleActionEntry
type GtkRadioActionEntry as _GtkRadioActionEntry

type _GtkActionGroup
	parent as GObject
	private_data as GtkActionGroupPrivate ptr
end type

type _GtkActionGroupClass
	parent_class as GObjectClass
	get_action as function(byval action_group as GtkActionGroup ptr, byval action_name as const gchar ptr) as GtkAction ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkActionEntry
	name as const gchar ptr
	stock_id as const gchar ptr
	label as const gchar ptr
	accelerator as const gchar ptr
	tooltip as const gchar ptr
	callback as GCallback
end type

type _GtkToggleActionEntry
	name as const gchar ptr
	stock_id as const gchar ptr
	label as const gchar ptr
	accelerator as const gchar ptr
	tooltip as const gchar ptr
	callback as GCallback
	is_active as gboolean
end type

type _GtkRadioActionEntry
	name as const gchar ptr
	stock_id as const gchar ptr
	label as const gchar ptr
	accelerator as const gchar ptr
	tooltip as const gchar ptr
	value as gint
end type

declare function gtk_action_group_get_type() as GType
declare function gtk_action_group_new(byval name as const gchar ptr) as GtkActionGroup ptr
declare function gtk_action_group_get_name(byval action_group as GtkActionGroup ptr) as const gchar ptr
declare function gtk_action_group_get_sensitive(byval action_group as GtkActionGroup ptr) as gboolean
declare sub gtk_action_group_set_sensitive(byval action_group as GtkActionGroup ptr, byval sensitive as gboolean)
declare function gtk_action_group_get_visible(byval action_group as GtkActionGroup ptr) as gboolean
declare sub gtk_action_group_set_visible(byval action_group as GtkActionGroup ptr, byval visible as gboolean)
declare function gtk_action_group_get_action(byval action_group as GtkActionGroup ptr, byval action_name as const gchar ptr) as GtkAction ptr
declare function gtk_action_group_list_actions(byval action_group as GtkActionGroup ptr) as GList ptr
declare sub gtk_action_group_add_action(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)
declare sub gtk_action_group_add_action_with_accel(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr, byval accelerator as const gchar ptr)
declare sub gtk_action_group_remove_action(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)
declare sub gtk_action_group_add_actions(byval action_group as GtkActionGroup ptr, byval entries as const GtkActionEntry ptr, byval n_entries as guint, byval user_data as gpointer)
declare sub gtk_action_group_add_toggle_actions(byval action_group as GtkActionGroup ptr, byval entries as const GtkToggleActionEntry ptr, byval n_entries as guint, byval user_data as gpointer)
declare sub gtk_action_group_add_radio_actions(byval action_group as GtkActionGroup ptr, byval entries as const GtkRadioActionEntry ptr, byval n_entries as guint, byval value as gint, byval on_change as GCallback, byval user_data as gpointer)
declare sub gtk_action_group_add_actions_full(byval action_group as GtkActionGroup ptr, byval entries as const GtkActionEntry ptr, byval n_entries as guint, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_action_group_add_toggle_actions_full(byval action_group as GtkActionGroup ptr, byval entries as const GtkToggleActionEntry ptr, byval n_entries as guint, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_action_group_add_radio_actions_full(byval action_group as GtkActionGroup ptr, byval entries as const GtkRadioActionEntry ptr, byval n_entries as guint, byval value as gint, byval on_change as GCallback, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_action_group_set_translate_func(byval action_group as GtkActionGroup ptr, byval func as GtkTranslateFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub gtk_action_group_set_translation_domain(byval action_group as GtkActionGroup ptr, byval domain as const gchar ptr)
declare function gtk_action_group_translate_string(byval action_group as GtkActionGroup ptr, byval string as const gchar ptr) as const gchar ptr
declare sub _gtk_action_group_emit_connect_proxy(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_group_emit_disconnect_proxy(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
declare sub _gtk_action_group_emit_pre_activate(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)
declare sub _gtk_action_group_emit_post_activate(byval action_group as GtkActionGroup ptr, byval action as GtkAction ptr)

#define __GTK_ACTIVATABLE_H__
#define GTK_TYPE_ACTIVATABLE gtk_activatable_get_type()
#define GTK_ACTIVATABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACTIVATABLE, GtkActivatable)
#define GTK_ACTIVATABLE_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_TYPE_ACTIVATABLE, GtkActivatableIface)
#define GTK_IS_ACTIVATABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACTIVATABLE)
#define GTK_ACTIVATABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_ACTIVATABLE, GtkActivatableIface)
type GtkActivatable as _GtkActivatable
type GtkActivatableIface as _GtkActivatableIface

type _GtkActivatableIface
	g_iface as GTypeInterface
	update as sub(byval activatable as GtkActivatable ptr, byval action as GtkAction ptr, byval property_name as const gchar ptr)
	sync_action_properties as sub(byval activatable as GtkActivatable ptr, byval action as GtkAction ptr)
end type

declare function gtk_activatable_get_type() as GType
declare sub gtk_activatable_sync_action_properties(byval activatable as GtkActivatable ptr, byval action as GtkAction ptr)
declare sub gtk_activatable_set_related_action(byval activatable as GtkActivatable ptr, byval action as GtkAction ptr)
declare function gtk_activatable_get_related_action(byval activatable as GtkActivatable ptr) as GtkAction ptr
declare sub gtk_activatable_set_use_action_appearance(byval activatable as GtkActivatable ptr, byval use_appearance as gboolean)
declare function gtk_activatable_get_use_action_appearance(byval activatable as GtkActivatable ptr) as gboolean
declare sub gtk_activatable_do_set_related_action(byval activatable as GtkActivatable ptr, byval action as GtkAction ptr)

#define __GTK_ALIGNMENT_H__
#define GTK_TYPE_ALIGNMENT gtk_alignment_get_type()
#define GTK_ALIGNMENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ALIGNMENT, GtkAlignment)
#define GTK_ALIGNMENT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ALIGNMENT, GtkAlignmentClass)
#define GTK_IS_ALIGNMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ALIGNMENT)
#define GTK_IS_ALIGNMENT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ALIGNMENT)
#define GTK_ALIGNMENT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ALIGNMENT, GtkAlignmentClass)

type GtkAlignment as _GtkAlignment
type GtkAlignmentClass as _GtkAlignmentClass
type GtkAlignmentPrivate as _GtkAlignmentPrivate

type _GtkAlignment
	bin as GtkBin
	xalign as gfloat
	yalign as gfloat
	xscale as gfloat
	yscale as gfloat
end type

type _GtkAlignmentClass
	parent_class as GtkBinClass
end type

declare function gtk_alignment_get_type() as GType
declare function gtk_alignment_new(byval xalign as gfloat, byval yalign as gfloat, byval xscale as gfloat, byval yscale as gfloat) as GtkWidget ptr
declare sub gtk_alignment_set(byval alignment as GtkAlignment ptr, byval xalign as gfloat, byval yalign as gfloat, byval xscale as gfloat, byval yscale as gfloat)
declare sub gtk_alignment_set_padding(byval alignment as GtkAlignment ptr, byval padding_top as guint, byval padding_bottom as guint, byval padding_left as guint, byval padding_right as guint)
declare sub gtk_alignment_get_padding(byval alignment as GtkAlignment ptr, byval padding_top as guint ptr, byval padding_bottom as guint ptr, byval padding_left as guint ptr, byval padding_right as guint ptr)

#define __GTK_ARROW_H__
#define GTK_TYPE_ARROW gtk_arrow_get_type()
#define GTK_ARROW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ARROW, GtkArrow)
#define GTK_ARROW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ARROW, GtkArrowClass)
#define GTK_IS_ARROW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ARROW)
#define GTK_IS_ARROW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ARROW)
#define GTK_ARROW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ARROW, GtkArrowClass)
type GtkArrow as _GtkArrow
type GtkArrowClass as _GtkArrowClass

type _GtkArrow
	misc as GtkMisc
	arrow_type as gint16
	shadow_type as gint16
end type

type _GtkArrowClass
	parent_class as GtkMiscClass
end type

declare function gtk_arrow_get_type() as GType
declare function gtk_arrow_new(byval arrow_type as GtkArrowType, byval shadow_type as GtkShadowType) as GtkWidget ptr
declare sub gtk_arrow_set(byval arrow as GtkArrow ptr, byval arrow_type as GtkArrowType, byval shadow_type as GtkShadowType)

#define __GTK_ASPECT_FRAME_H__
#define __GTK_FRAME_H__
#define GTK_TYPE_FRAME gtk_frame_get_type()
#define GTK_FRAME(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FRAME, GtkFrame)
#define GTK_FRAME_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FRAME, GtkFrameClass)
#define GTK_IS_FRAME(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FRAME)
#define GTK_IS_FRAME_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FRAME)
#define GTK_FRAME_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FRAME, GtkFrameClass)
type GtkFrame as _GtkFrame
type GtkFrameClass as _GtkFrameClass

type _GtkFrame
	bin as GtkBin
	label_widget as GtkWidget ptr
	shadow_type as gint16
	label_xalign as gfloat
	label_yalign as gfloat
	child_allocation as GtkAllocation
end type

type _GtkFrameClass
	parent_class as GtkBinClass
	compute_child_allocation as sub(byval frame as GtkFrame ptr, byval allocation as GtkAllocation ptr)
end type

declare function gtk_frame_get_type() as GType
declare function gtk_frame_new(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_frame_set_label(byval frame as GtkFrame ptr, byval label as const gchar ptr)
declare function gtk_frame_get_label(byval frame as GtkFrame ptr) as const gchar ptr
declare sub gtk_frame_set_label_widget(byval frame as GtkFrame ptr, byval label_widget as GtkWidget ptr)
declare function gtk_frame_get_label_widget(byval frame as GtkFrame ptr) as GtkWidget ptr
declare sub gtk_frame_set_label_align(byval frame as GtkFrame ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_frame_get_label_align(byval frame as GtkFrame ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_frame_set_shadow_type(byval frame as GtkFrame ptr, byval type as GtkShadowType)
declare function gtk_frame_get_shadow_type(byval frame as GtkFrame ptr) as GtkShadowType

#define GTK_TYPE_ASPECT_FRAME gtk_aspect_frame_get_type()
#define GTK_ASPECT_FRAME(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrame)
#define GTK_ASPECT_FRAME_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ASPECT_FRAME, GtkAspectFrameClass)
#define GTK_IS_ASPECT_FRAME(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ASPECT_FRAME)
#define GTK_IS_ASPECT_FRAME_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ASPECT_FRAME)
#define GTK_ASPECT_FRAME_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrameClass)
type GtkAspectFrame as _GtkAspectFrame
type GtkAspectFrameClass as _GtkAspectFrameClass

type _GtkAspectFrame
	frame as GtkFrame
	xalign as gfloat
	yalign as gfloat
	ratio as gfloat
	obey_child as gboolean
	center_allocation as GtkAllocation
end type

type _GtkAspectFrameClass
	parent_class as GtkFrameClass
end type

declare function gtk_aspect_frame_get_type() as GType
declare function gtk_aspect_frame_new(byval label as const gchar ptr, byval xalign as gfloat, byval yalign as gfloat, byval ratio as gfloat, byval obey_child as gboolean) as GtkWidget ptr
declare sub gtk_aspect_frame_set(byval aspect_frame as GtkAspectFrame ptr, byval xalign as gfloat, byval yalign as gfloat, byval ratio as gfloat, byval obey_child as gboolean)

#define __GTK_ASSISTANT_H__
#define GTK_TYPE_ASSISTANT gtk_assistant_get_type()
#define GTK_ASSISTANT(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_ASSISTANT, GtkAssistant)
#define GTK_ASSISTANT_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_ASSISTANT, GtkAssistantClass)
#define GTK_IS_ASSISTANT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_ASSISTANT)
#define GTK_IS_ASSISTANT_CLASS(c) G_TYPE_CHECK_CLASS_TYPE((c), GTK_TYPE_ASSISTANT)
#define GTK_ASSISTANT_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_ASSISTANT, GtkAssistantClass)

type GtkAssistantPageType as long
enum
	GTK_ASSISTANT_PAGE_CONTENT
	GTK_ASSISTANT_PAGE_INTRO
	GTK_ASSISTANT_PAGE_CONFIRM
	GTK_ASSISTANT_PAGE_SUMMARY
	GTK_ASSISTANT_PAGE_PROGRESS
end enum

type GtkAssistant as _GtkAssistant
type GtkAssistantPrivate as _GtkAssistantPrivate
type GtkAssistantClass as _GtkAssistantClass

type _GtkAssistant
	parent as GtkWindow
	cancel as GtkWidget ptr
	forward as GtkWidget ptr
	back as GtkWidget ptr
	apply as GtkWidget ptr
	close as GtkWidget ptr
	last as GtkWidget ptr
	priv as GtkAssistantPrivate ptr
end type

type _GtkAssistantClass
	parent_class as GtkWindowClass
	prepare as sub(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr)
	apply as sub(byval assistant as GtkAssistant ptr)
	close as sub(byval assistant as GtkAssistant ptr)
	cancel as sub(byval assistant as GtkAssistant ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
end type

type GtkAssistantPageFunc as function(byval current_page as gint, byval data as gpointer) as gint
declare function gtk_assistant_get_type() as GType
declare function gtk_assistant_new() as GtkWidget ptr
declare function gtk_assistant_get_current_page(byval assistant as GtkAssistant ptr) as gint
declare sub gtk_assistant_set_current_page(byval assistant as GtkAssistant ptr, byval page_num as gint)
declare function gtk_assistant_get_n_pages(byval assistant as GtkAssistant ptr) as gint
declare function gtk_assistant_get_nth_page(byval assistant as GtkAssistant ptr, byval page_num as gint) as GtkWidget ptr
declare function gtk_assistant_prepend_page(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as gint
declare function gtk_assistant_append_page(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as gint
declare function gtk_assistant_insert_page(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval position as gint) as gint
declare sub gtk_assistant_set_forward_page_func(byval assistant as GtkAssistant ptr, byval page_func as GtkAssistantPageFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_assistant_set_page_type(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval type as GtkAssistantPageType)
declare function gtk_assistant_get_page_type(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as GtkAssistantPageType
declare sub gtk_assistant_set_page_title(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval title as const gchar ptr)
declare function gtk_assistant_get_page_title(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as const gchar ptr
declare sub gtk_assistant_set_page_header_image(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval pixbuf as GdkPixbuf ptr)
declare function gtk_assistant_get_page_header_image(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as GdkPixbuf ptr
declare sub gtk_assistant_set_page_side_image(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval pixbuf as GdkPixbuf ptr)
declare function gtk_assistant_get_page_side_image(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as GdkPixbuf ptr
declare sub gtk_assistant_set_page_complete(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval complete as gboolean)
declare function gtk_assistant_get_page_complete(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as gboolean
declare sub gtk_assistant_add_action_widget(byval assistant as GtkAssistant ptr, byval child as GtkWidget ptr)
declare sub gtk_assistant_remove_action_widget(byval assistant as GtkAssistant ptr, byval child as GtkWidget ptr)
declare sub gtk_assistant_update_buttons_state(byval assistant as GtkAssistant ptr)
declare sub gtk_assistant_commit(byval assistant as GtkAssistant ptr)

#define __GTK_BUTTON_BOX_H__
#define __GTK_BOX_H__
#define GTK_TYPE_BOX gtk_box_get_type()
#define GTK_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BOX, GtkBox)
#define GTK_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BOX, GtkBoxClass)
#define GTK_IS_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BOX)
#define GTK_IS_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BOX)
#define GTK_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BOX, GtkBoxClass)
type GtkBox as _GtkBox
type GtkBoxClass as _GtkBoxClass

type _GtkBox
	container as GtkContainer
	children as GList ptr
	spacing as gint16
	homogeneous : 1 as guint
end type

type _GtkBoxClass
	parent_class as GtkContainerClass
end type

type GtkBoxChild as _GtkBoxChild

type _GtkBoxChild
	widget as GtkWidget ptr
	padding as guint16
	expand : 1 as guint
	fill : 1 as guint
	pack : 1 as guint
	is_secondary : 1 as guint
end type

declare function gtk_box_get_type() as GType
declare function _gtk_box_new(byval orientation as GtkOrientation, byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr
declare sub gtk_box_pack_start(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_end(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_start_defaults(byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare sub gtk_box_pack_end_defaults(byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare sub gtk_box_set_homogeneous(byval box as GtkBox ptr, byval homogeneous as gboolean)
declare function gtk_box_get_homogeneous(byval box as GtkBox ptr) as gboolean
declare sub gtk_box_set_spacing(byval box as GtkBox ptr, byval spacing as gint)
declare function gtk_box_get_spacing(byval box as GtkBox ptr) as gint
declare sub gtk_box_reorder_child(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_box_query_child_packing(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean ptr, byval fill as gboolean ptr, byval padding as guint ptr, byval pack_type as GtkPackType ptr)
declare sub gtk_box_set_child_packing(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint, byval pack_type as GtkPackType)
declare sub _gtk_box_set_old_defaults(byval box as GtkBox ptr)
declare function _gtk_box_get_spacing_set(byval box as GtkBox ptr) as gboolean
declare sub _gtk_box_set_spacing_set(byval box as GtkBox ptr, byval spacing_set as gboolean)

#define GTK_TYPE_BUTTON_BOX gtk_button_box_get_type()
#define GTK_BUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUTTON_BOX, GtkButtonBox)
#define GTK_BUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass)
#define GTK_IS_BUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUTTON_BOX)
#define GTK_IS_BUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BUTTON_BOX)
#define GTK_BUTTON_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass)
const GTK_BUTTONBOX_DEFAULT = -1
type GtkButtonBox as _GtkButtonBox
type GtkButtonBoxClass as _GtkButtonBoxClass

type _GtkButtonBox
	box as GtkBox
	child_min_width as gint
	child_min_height as gint
	child_ipad_x as gint
	child_ipad_y as gint
	layout_style as GtkButtonBoxStyle
end type

type _GtkButtonBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_button_box_get_type() as GType
declare function gtk_button_box_get_layout(byval widget as GtkButtonBox ptr) as GtkButtonBoxStyle
declare sub gtk_button_box_set_layout(byval widget as GtkButtonBox ptr, byval layout_style as GtkButtonBoxStyle)
declare function gtk_button_box_get_child_secondary(byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_button_box_set_child_secondary(byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr, byval is_secondary as gboolean)
#define gtk_button_box_set_spacing(b, s) gtk_box_set_spacing(GTK_BOX(b), s)
#define gtk_button_box_get_spacing(b) gtk_box_get_spacing(GTK_BOX(b))
declare sub gtk_button_box_set_child_size(byval widget as GtkButtonBox ptr, byval min_width as gint, byval min_height as gint)
declare sub gtk_button_box_set_child_ipadding(byval widget as GtkButtonBox ptr, byval ipad_x as gint, byval ipad_y as gint)
declare sub gtk_button_box_get_child_size(byval widget as GtkButtonBox ptr, byval min_width as gint ptr, byval min_height as gint ptr)
declare sub gtk_button_box_get_child_ipadding(byval widget as GtkButtonBox ptr, byval ipad_x as gint ptr, byval ipad_y as gint ptr)
declare sub _gtk_button_box_child_requisition(byval widget as GtkWidget ptr, byval nvis_children as long ptr, byval nvis_secondaries as long ptr, byval width as long ptr, byval height as long ptr)
#define __GTK_BINDINGS_H__

type GtkBindingSet as _GtkBindingSet
type GtkBindingEntry as _GtkBindingEntry
type GtkBindingSignal as _GtkBindingSignal
type GtkBindingArg as _GtkBindingArg

type _GtkBindingSet
	set_name as gchar ptr
	priority as gint
	widget_path_pspecs as GSList ptr
	widget_class_pspecs as GSList ptr
	class_branch_pspecs as GSList ptr
	entries as GtkBindingEntry ptr
	current as GtkBindingEntry ptr
	parsed : 1 as guint
end type

type _GtkBindingEntry
	keyval as guint
	modifiers as GdkModifierType
	binding_set as GtkBindingSet ptr
	destroyed : 1 as guint
	in_emission : 1 as guint
	marks_unbound : 1 as guint
	set_next as GtkBindingEntry ptr
	hash_next as GtkBindingEntry ptr
	signals as GtkBindingSignal ptr
end type

union _GtkBindingArg_d
	long_data as glong
	double_data as gdouble
	string_data as gchar ptr
end union

type _GtkBindingArg
	arg_type as GType
	d as _GtkBindingArg_d
end type

type _GtkBindingSignal
	next as GtkBindingSignal ptr
	signal_name as gchar ptr
	n_args as guint
	args as GtkBindingArg ptr
end type

declare function gtk_binding_set_new(byval set_name as const gchar ptr) as GtkBindingSet ptr
declare function gtk_binding_set_by_class(byval object_class as gpointer) as GtkBindingSet ptr
declare function gtk_binding_set_find(byval set_name as const gchar ptr) as GtkBindingSet ptr
declare function gtk_bindings_activate(byval object as GtkObject ptr, byval keyval as guint, byval modifiers as GdkModifierType) as gboolean
declare function gtk_bindings_activate_event(byval object as GtkObject ptr, byval event as GdkEventKey ptr) as gboolean
declare function gtk_binding_set_activate(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval object as GtkObject ptr) as gboolean
declare sub gtk_binding_entry_clear(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gtk_binding_entry_add alias "gtk_binding_entry_clear"(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare function gtk_binding_parse_binding(byval scanner as GScanner ptr) as guint
declare sub gtk_binding_entry_skip(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gtk_binding_entry_add_signal(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as const gchar ptr, byval n_args as guint, ...)
declare sub gtk_binding_entry_add_signall(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as const gchar ptr, byval binding_args as GSList ptr)
declare sub gtk_binding_entry_remove(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gtk_binding_set_add_path(byval binding_set as GtkBindingSet ptr, byval path_type as GtkPathType, byval path_pattern as const gchar ptr, byval priority as GtkPathPriorityType)
declare function _gtk_binding_parse_binding(byval scanner as GScanner ptr) as guint
declare sub _gtk_binding_reset_parsed()
declare sub _gtk_binding_entry_add_signall(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as const gchar ptr, byval binding_args as GSList ptr)

#define __GTK_BUILDABLE_H__
#define __GTK_BUILDER_H__
#define GTK_TYPE_BUILDER gtk_builder_get_type()
#define GTK_BUILDER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUILDER, GtkBuilder)
#define GTK_BUILDER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BUILDER, GtkBuilderClass)
#define GTK_IS_BUILDER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUILDER)
#define GTK_IS_BUILDER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BUILDER)
#define GTK_BUILDER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BUILDER, GtkBuilderClass)
#define GTK_BUILDER_ERROR gtk_builder_error_quark()

type GtkBuilder as _GtkBuilder
type GtkBuilderClass as _GtkBuilderClass
type GtkBuilderPrivate as _GtkBuilderPrivate

type GtkBuilderError as long
enum
	GTK_BUILDER_ERROR_INVALID_TYPE_FUNCTION
	GTK_BUILDER_ERROR_UNHANDLED_TAG
	GTK_BUILDER_ERROR_MISSING_ATTRIBUTE
	GTK_BUILDER_ERROR_INVALID_ATTRIBUTE
	GTK_BUILDER_ERROR_INVALID_TAG
	GTK_BUILDER_ERROR_MISSING_PROPERTY_VALUE
	GTK_BUILDER_ERROR_INVALID_VALUE
	GTK_BUILDER_ERROR_VERSION_MISMATCH
	GTK_BUILDER_ERROR_DUPLICATE_ID
end enum

declare function gtk_builder_error_quark() as GQuark

type _GtkBuilder
	parent_instance as GObject
	priv as GtkBuilderPrivate ptr
end type

type _GtkBuilderClass
	parent_class as GObjectClass
	get_type_from_name as function(byval builder as GtkBuilder ptr, byval type_name as const zstring ptr) as GType
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

type GtkBuilderConnectFunc as sub(byval builder as GtkBuilder ptr, byval object as GObject ptr, byval signal_name as const gchar ptr, byval handler_name as const gchar ptr, byval connect_object as GObject ptr, byval flags as GConnectFlags, byval user_data as gpointer)
declare function gtk_builder_get_type() as GType
declare function gtk_builder_new() as GtkBuilder ptr
declare function gtk_builder_add_from_file(byval builder as GtkBuilder ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_from_string(byval builder as GtkBuilder ptr, byval buffer as const gchar ptr, byval length as gsize, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_objects_from_file(byval builder as GtkBuilder ptr, byval filename as const gchar ptr, byval object_ids as gchar ptr ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_objects_from_string(byval builder as GtkBuilder ptr, byval buffer as const gchar ptr, byval length as gsize, byval object_ids as gchar ptr ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_get_object(byval builder as GtkBuilder ptr, byval name as const gchar ptr) as GObject ptr
declare function gtk_builder_get_objects(byval builder as GtkBuilder ptr) as GSList ptr
declare sub gtk_builder_connect_signals(byval builder as GtkBuilder ptr, byval user_data as gpointer)
declare sub gtk_builder_connect_signals_full(byval builder as GtkBuilder ptr, byval func as GtkBuilderConnectFunc, byval user_data as gpointer)
declare sub gtk_builder_set_translation_domain(byval builder as GtkBuilder ptr, byval domain as const gchar ptr)
declare function gtk_builder_get_translation_domain(byval builder as GtkBuilder ptr) as const gchar ptr
declare function gtk_builder_get_type_from_name(byval builder as GtkBuilder ptr, byval type_name as const zstring ptr) as GType
declare function gtk_builder_value_from_string(byval builder as GtkBuilder ptr, byval pspec as GParamSpec ptr, byval string as const gchar ptr, byval value as GValue ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_builder_value_from_string_type(byval builder as GtkBuilder ptr, byval type as GType, byval string as const gchar ptr, byval value as GValue ptr, byval error as GError ptr ptr) as gboolean

#define GTK_BUILDER_WARN_INVALID_CHILD_TYPE(object, type) g_warning("'%s' is not a valid child type of '%s'", type, g_type_name(G_OBJECT_TYPE(object)))
#define GTK_TYPE_BUILDABLE gtk_buildable_get_type()
#define GTK_BUILDABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUILDABLE, GtkBuildable)
#define GTK_BUILDABLE_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_TYPE_BUILDABLE, GtkBuildableIface)
#define GTK_IS_BUILDABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUILDABLE)
#define GTK_BUILDABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_BUILDABLE, GtkBuildableIface)
type GtkBuildable as _GtkBuildable
type GtkBuildableIface as _GtkBuildableIface

type _GtkBuildableIface
	g_iface as GTypeInterface
	set_name as sub(byval buildable as GtkBuildable ptr, byval name as const gchar ptr)
	get_name as function(byval buildable as GtkBuildable ptr) as const gchar ptr
	add_child as sub(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval type as const gchar ptr)
	set_buildable_property as sub(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval name as const gchar ptr, byval value as const GValue ptr)
	construct_child as function(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval name as const gchar ptr) as GObject ptr
	custom_tag_start as function(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval parser as GMarkupParser ptr, byval data as gpointer ptr) as gboolean
	custom_tag_end as sub(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval data as gpointer ptr)
	custom_finished as sub(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval data as gpointer)
	parser_finished as sub(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr)
	get_internal_child as function(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval childname as const gchar ptr) as GObject ptr
end type

declare function gtk_buildable_get_type() as GType
declare sub gtk_buildable_set_name(byval buildable as GtkBuildable ptr, byval name as const gchar ptr)
declare function gtk_buildable_get_name(byval buildable as GtkBuildable ptr) as const gchar ptr
declare sub gtk_buildable_add_child(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval type as const gchar ptr)
declare sub gtk_buildable_set_buildable_property(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval name as const gchar ptr, byval value as const GValue ptr)
declare function gtk_buildable_construct_child(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval name as const gchar ptr) as GObject ptr
declare function gtk_buildable_custom_tag_start(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval parser as GMarkupParser ptr, byval data as gpointer ptr) as gboolean
declare sub gtk_buildable_custom_tag_end(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval data as gpointer ptr)
declare sub gtk_buildable_custom_finished(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval data as gpointer)
declare sub gtk_buildable_parser_finished(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr)
declare function gtk_buildable_get_internal_child(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval childname as const gchar ptr) as GObject ptr

#define __GTK_BUTTON_H__
#define __GTK_IMAGE_H__
#define GTK_TYPE_IMAGE gtk_image_get_type()
#define GTK_IMAGE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IMAGE, GtkImage)
#define GTK_IMAGE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IMAGE, GtkImageClass)
#define GTK_IS_IMAGE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IMAGE)
#define GTK_IS_IMAGE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IMAGE)
#define GTK_IMAGE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IMAGE, GtkImageClass)

type GtkImage as _GtkImage
type GtkImageClass as _GtkImageClass
type GtkImagePixmapData as _GtkImagePixmapData
type GtkImageImageData as _GtkImageImageData
type GtkImagePixbufData as _GtkImagePixbufData
type GtkImageStockData as _GtkImageStockData
type GtkImageIconSetData as _GtkImageIconSetData
type GtkImageAnimationData as _GtkImageAnimationData
type GtkImageIconNameData as _GtkImageIconNameData
type GtkImageGIconData as _GtkImageGIconData

type _GtkImagePixmapData
	pixmap as GdkPixmap ptr
end type

type _GtkImageImageData
	image as GdkImage ptr
end type

type _GtkImagePixbufData
	pixbuf as GdkPixbuf ptr
end type

type _GtkImageStockData
	stock_id as gchar ptr
end type

type _GtkImageIconSetData
	icon_set as GtkIconSet ptr
end type

type _GtkImageAnimationData
	anim as GdkPixbufAnimation ptr
	iter as GdkPixbufAnimationIter ptr
	frame_timeout as guint
end type

type _GtkImageIconNameData
	icon_name as gchar ptr
	pixbuf as GdkPixbuf ptr
	theme_change_id as guint
end type

type _GtkImageGIconData
	icon as GIcon ptr
	pixbuf as GdkPixbuf ptr
	theme_change_id as guint
end type

type GtkImageType as long
enum
	GTK_IMAGE_EMPTY
	GTK_IMAGE_PIXMAP
	GTK_IMAGE_IMAGE
	GTK_IMAGE_PIXBUF
	GTK_IMAGE_STOCK
	GTK_IMAGE_ICON_SET
	GTK_IMAGE_ANIMATION
	GTK_IMAGE_ICON_NAME
	GTK_IMAGE_GICON
end enum

union _GtkImage_data
	pixmap as GtkImagePixmapData
	image as GtkImageImageData
	pixbuf as GtkImagePixbufData
	stock as GtkImageStockData
	icon_set as GtkImageIconSetData
	anim as GtkImageAnimationData
	name as GtkImageIconNameData
	gicon as GtkImageGIconData
end union

type _GtkImage
	misc as GtkMisc
	storage_type as GtkImageType
	data as _GtkImage_data
	mask as GdkBitmap ptr
	icon_size as GtkIconSize
end type

type _GtkImageClass
	parent_class as GtkMiscClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_image_get_type() as GType
declare function gtk_image_new() as GtkWidget ptr
declare function gtk_image_new_from_pixmap(byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr) as GtkWidget ptr
declare function gtk_image_new_from_image(byval image as GdkImage ptr, byval mask as GdkBitmap ptr) as GtkWidget ptr

#ifdef __FB_UNIX__
	declare function gtk_image_new_from_file(byval filename as const gchar ptr) as GtkWidget ptr
#else
	declare function gtk_image_new_from_file_utf8(byval filename as const gchar ptr) as GtkWidget ptr
	declare function gtk_image_new_from_file alias "gtk_image_new_from_file_utf8"(byval filename as const gchar ptr) as GtkWidget ptr
#endif

declare function gtk_image_new_from_pixbuf(byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare function gtk_image_new_from_stock(byval stock_id as const gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_icon_set(byval icon_set as GtkIconSet ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_animation(byval animation as GdkPixbufAnimation ptr) as GtkWidget ptr
declare function gtk_image_new_from_icon_name(byval icon_name as const gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_gicon(byval icon as GIcon ptr, byval size as GtkIconSize) as GtkWidget ptr
declare sub gtk_image_clear(byval image as GtkImage ptr)
declare sub gtk_image_set_from_pixmap(byval image as GtkImage ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_image_set_from_image(byval image as GtkImage ptr, byval gdk_image as GdkImage ptr, byval mask as GdkBitmap ptr)

#ifdef __FB_UNIX__
	declare sub gtk_image_set_from_file(byval image as GtkImage ptr, byval filename as const gchar ptr)
#else
	declare sub gtk_image_set_from_file_utf8(byval image as GtkImage ptr, byval filename as const gchar ptr)
	declare sub gtk_image_set_from_file alias "gtk_image_set_from_file_utf8"(byval image as GtkImage ptr, byval filename as const gchar ptr)
#endif

declare sub gtk_image_set_from_pixbuf(byval image as GtkImage ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_image_set_from_stock(byval image as GtkImage ptr, byval stock_id as const gchar ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_icon_set(byval image as GtkImage ptr, byval icon_set as GtkIconSet ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_animation(byval image as GtkImage ptr, byval animation as GdkPixbufAnimation ptr)
declare sub gtk_image_set_from_icon_name(byval image as GtkImage ptr, byval icon_name as const gchar ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_gicon(byval image as GtkImage ptr, byval icon as GIcon ptr, byval size as GtkIconSize)
declare sub gtk_image_set_pixel_size(byval image as GtkImage ptr, byval pixel_size as gint)
declare function gtk_image_get_storage_type(byval image as GtkImage ptr) as GtkImageType
declare sub gtk_image_get_pixmap(byval image as GtkImage ptr, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr)
declare sub gtk_image_get_image(byval image as GtkImage ptr, byval gdk_image as GdkImage ptr ptr, byval mask as GdkBitmap ptr ptr)
declare function gtk_image_get_pixbuf(byval image as GtkImage ptr) as GdkPixbuf ptr
declare sub gtk_image_get_stock(byval image as GtkImage ptr, byval stock_id as gchar ptr ptr, byval size as GtkIconSize ptr)
declare sub gtk_image_get_icon_set(byval image as GtkImage ptr, byval icon_set as GtkIconSet ptr ptr, byval size as GtkIconSize ptr)
declare function gtk_image_get_animation(byval image as GtkImage ptr) as GdkPixbufAnimation ptr
declare sub gtk_image_get_icon_name(byval image as GtkImage ptr, byval icon_name as const gchar ptr ptr, byval size as GtkIconSize ptr)
declare sub gtk_image_get_gicon(byval image as GtkImage ptr, byval gicon as GIcon ptr ptr, byval size as GtkIconSize ptr)
declare function gtk_image_get_pixel_size(byval image as GtkImage ptr) as gint
declare sub gtk_image_set(byval image as GtkImage ptr, byval val as GdkImage ptr, byval mask as GdkBitmap ptr)
declare sub gtk_image_get(byval image as GtkImage ptr, byval val as GdkImage ptr ptr, byval mask as GdkBitmap ptr ptr)

#define GTK_TYPE_BUTTON gtk_button_get_type()
#define GTK_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUTTON, GtkButton)
#define GTK_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BUTTON, GtkButtonClass)
#define GTK_IS_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUTTON)
#define GTK_IS_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BUTTON)
#define GTK_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BUTTON, GtkButtonClass)
type GtkButton as _GtkButton
type GtkButtonClass as _GtkButtonClass

type _GtkButton
	bin as GtkBin
	event_window as GdkWindow ptr
	label_text as gchar ptr
	activate_timeout as guint
	constructed : 1 as guint
	in_button : 1 as guint
	button_down : 1 as guint
	relief : 2 as guint
	use_underline : 1 as guint
	use_stock : 1 as guint
	depressed : 1 as guint
	depress_on_activate : 1 as guint
	focus_on_click : 1 as guint
end type

type _GtkButtonClass
	parent_class as GtkBinClass
	pressed as sub(byval button as GtkButton ptr)
	released as sub(byval button as GtkButton ptr)
	clicked as sub(byval button as GtkButton ptr)
	enter as sub(byval button as GtkButton ptr)
	leave as sub(byval button as GtkButton ptr)
	activate as sub(byval button as GtkButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_button_get_type() as GType
declare function gtk_button_new() as GtkWidget ptr
declare function gtk_button_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_button_new_from_stock(byval stock_id as const gchar ptr) as GtkWidget ptr
declare function gtk_button_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_button_pressed(byval button as GtkButton ptr)
declare sub gtk_button_released(byval button as GtkButton ptr)
declare sub gtk_button_clicked(byval button as GtkButton ptr)
declare sub gtk_button_enter(byval button as GtkButton ptr)
declare sub gtk_button_leave(byval button as GtkButton ptr)
declare sub gtk_button_set_relief(byval button as GtkButton ptr, byval newstyle as GtkReliefStyle)
declare function gtk_button_get_relief(byval button as GtkButton ptr) as GtkReliefStyle
declare sub gtk_button_set_label(byval button as GtkButton ptr, byval label as const gchar ptr)
declare function gtk_button_get_label(byval button as GtkButton ptr) as const gchar ptr
declare sub gtk_button_set_use_underline(byval button as GtkButton ptr, byval use_underline as gboolean)
declare function gtk_button_get_use_underline(byval button as GtkButton ptr) as gboolean
declare sub gtk_button_set_use_stock(byval button as GtkButton ptr, byval use_stock as gboolean)
declare function gtk_button_get_use_stock(byval button as GtkButton ptr) as gboolean
declare sub gtk_button_set_focus_on_click(byval button as GtkButton ptr, byval focus_on_click as gboolean)
declare function gtk_button_get_focus_on_click(byval button as GtkButton ptr) as gboolean
declare sub gtk_button_set_alignment(byval button as GtkButton ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_button_get_alignment(byval button as GtkButton ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_button_set_image(byval button as GtkButton ptr, byval image as GtkWidget ptr)
declare function gtk_button_get_image(byval button as GtkButton ptr) as GtkWidget ptr
declare sub gtk_button_set_image_position(byval button as GtkButton ptr, byval position as GtkPositionType)
declare function gtk_button_get_image_position(byval button as GtkButton ptr) as GtkPositionType
declare function gtk_button_get_event_window(byval button as GtkButton ptr) as GdkWindow ptr
declare sub _gtk_button_set_depressed(byval button as GtkButton ptr, byval depressed as gboolean)
declare sub _gtk_button_paint(byval button as GtkButton ptr, byval area as const GdkRectangle ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval main_detail as const gchar ptr, byval default_detail as const gchar ptr)

#define __GTK_CALENDAR_H__
#define __GTK_SIGNAL_H__
#define __gtk_marshal_MARSHAL_H__

declare sub gtk_marshal_BOOLEAN__VOID(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOL__NONE alias "gtk_marshal_BOOLEAN__VOID"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOL__POINTER alias "gtk_marshal_BOOLEAN__POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_POINTER_INT_INT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOL__POINTER_POINTER_INT_INT alias "gtk_marshal_BOOLEAN__POINTER_POINTER_INT_INT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_INT_INT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOL__POINTER_INT_INT alias "gtk_marshal_BOOLEAN__POINTER_INT_INT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_INT_INT_UINT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOL__POINTER_INT_INT_UINT alias "gtk_marshal_BOOLEAN__POINTER_INT_INT_UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOLEAN__POINTER_STRING_STRING_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_BOOL__POINTER_STRING_STRING_POINTER alias "gtk_marshal_BOOLEAN__POINTER_STRING_STRING_POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_ENUM__ENUM(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_INT__POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_INT__POINTER_CHAR_CHAR(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__BOOLEAN alias "g_cclosure_marshal_VOID__BOOLEAN"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__BOOL alias "g_cclosure_marshal_VOID__BOOLEAN"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__BOXED alias "g_cclosure_marshal_VOID__BOXED"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__BOXED alias "g_cclosure_marshal_VOID__BOXED"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__ENUM alias "g_cclosure_marshal_VOID__ENUM"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__ENUM alias "g_cclosure_marshal_VOID__ENUM"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__ENUM_FLOAT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__ENUM_FLOAT alias "gtk_marshal_VOID__ENUM_FLOAT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__ENUM_FLOAT_BOOLEAN(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__ENUM_FLOAT_BOOL alias "gtk_marshal_VOID__ENUM_FLOAT_BOOLEAN"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__INT alias "g_cclosure_marshal_VOID__INT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__INT alias "g_cclosure_marshal_VOID__INT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__INT_INT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__INT_INT alias "gtk_marshal_VOID__INT_INT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__INT_INT_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__INT_INT_POINTER alias "gtk_marshal_VOID__INT_INT_POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__VOID alias "g_cclosure_marshal_VOID__VOID"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__NONE alias "g_cclosure_marshal_VOID__VOID"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__OBJECT alias "g_cclosure_marshal_VOID__OBJECT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__OBJECT alias "g_cclosure_marshal_VOID__OBJECT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER alias "g_cclosure_marshal_VOID__POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER alias "g_cclosure_marshal_VOID__POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_INT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_INT alias "gtk_marshal_VOID__POINTER_INT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_POINTER alias "gtk_marshal_VOID__POINTER_POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_POINTER_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_POINTER_POINTER alias "gtk_marshal_VOID__POINTER_POINTER_POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_STRING_STRING(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_STRING_STRING alias "gtk_marshal_VOID__POINTER_STRING_STRING"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_UINT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_UINT alias "gtk_marshal_VOID__POINTER_UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_UINT_ENUM(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_UINT_ENUM alias "gtk_marshal_VOID__POINTER_UINT_ENUM"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_POINTER_UINT_UINT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_POINTER_UINT_UINT alias "gtk_marshal_VOID__POINTER_POINTER_UINT_UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_INT_INT_POINTER_UINT_UINT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_INT_INT_POINTER_UINT_UINT alias "gtk_marshal_VOID__POINTER_INT_INT_POINTER_UINT_UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__POINTER_UINT_UINT(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__POINTER_UINT_UINT alias "gtk_marshal_VOID__POINTER_UINT_UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__STRING alias "g_cclosure_marshal_VOID__STRING"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__STRING alias "g_cclosure_marshal_VOID__STRING"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__STRING_INT_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__STRING_INT_POINTER alias "gtk_marshal_VOID__STRING_INT_POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT alias "g_cclosure_marshal_VOID__UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__UINT alias "g_cclosure_marshal_VOID__UINT"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT_POINTER_UINT_ENUM_ENUM_POINTER(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__UINT_POINTER_UINT_ENUM_ENUM_POINTER alias "gtk_marshal_VOID__UINT_POINTER_UINT_ENUM_ENUM_POINTER"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT_POINTER_UINT_UINT_ENUM(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__UINT_POINTER_UINT_UINT_ENUM alias "gtk_marshal_VOID__UINT_POINTER_UINT_UINT_ENUM"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_VOID__UINT_STRING(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_marshal_NONE__UINT_STRING alias "gtk_marshal_VOID__UINT_STRING"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)
declare sub gtk_signal_default_marshaller alias "g_cclosure_marshal_VOID__VOID"(byval closure as GClosure ptr, byval return_value as GValue ptr, byval n_param_values as guint, byval param_values as const GValue ptr, byval invocation_hint as gpointer, byval marshal_data as gpointer)

#define GTK_SIGNAL_OFFSET G_STRUCT_OFFSET
#define gtk_signal_lookup(name, object_type) g_signal_lookup((name), (object_type))
#define gtk_signal_name(signal_id) g_signal_name(signal_id)
#define gtk_signal_emit_stop(object, signal_id) g_signal_stop_emission((object), (signal_id), 0)
#define gtk_signal_connect(object, name, func, func_data) gtk_signal_connect_full((object), (name), (func), NULL, (func_data), NULL, 0, 0)
#define gtk_signal_connect_after(object, name, func, func_data) gtk_signal_connect_full((object), (name), (func), NULL, (func_data), NULL, 0, 1)
#define gtk_signal_connect_object(object, name, func, slot_object) gtk_signal_connect_full((object), (name), (func), NULL, (slot_object), NULL, 1, 0)
#define gtk_signal_connect_object_after(object, name, func, slot_object) gtk_signal_connect_full((object), (name), (func), NULL, (slot_object), NULL, 1, 1)
#define gtk_signal_disconnect(object, handler_id) g_signal_handler_disconnect((object), (handler_id))
#define gtk_signal_handler_block(object, handler_id) g_signal_handler_block((object), (handler_id))
#define gtk_signal_handler_unblock(object, handler_id) g_signal_handler_unblock((object), (handler_id))
#define gtk_signal_disconnect_by_func(object, func, data) gtk_signal_compat_matched((object), (func), (data), cast(GSignalMatchType, G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 0)
#define gtk_signal_disconnect_by_data(object, data) gtk_signal_compat_matched((object), 0, (data), G_SIGNAL_MATCH_DATA, 0)
#define gtk_signal_handler_block_by_func(object, func, data) gtk_signal_compat_matched((object), (func), (data), cast(GSignalMatchType, G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 1)
#define gtk_signal_handler_block_by_data(object, data) gtk_signal_compat_matched((object), 0, (data), G_SIGNAL_MATCH_DATA, 1)
#define gtk_signal_handler_unblock_by_func(object, func, data) gtk_signal_compat_matched((object), (func), (data), cast(GSignalMatchType, G_SIGNAL_MATCH_FUNC or G_SIGNAL_MATCH_DATA), 2)
#define gtk_signal_handler_unblock_by_data(object, data) gtk_signal_compat_matched((object), 0, (data), G_SIGNAL_MATCH_DATA, 2)
#define gtk_signal_handler_pending(object, signal_id, may_be_blocked) g_signal_has_handler_pending((object), (signal_id), 0, (may_be_blocked))
#define gtk_signal_handler_pending_by_func(object, signal_id, may_be_blocked, func, data) (g_signal_handler_find((object), cast(GSignalMatchType, ((G_SIGNAL_MATCH_ID or G_SIGNAL_MATCH_FUNC) or G_SIGNAL_MATCH_DATA) or iif((may_be_blocked), 0, G_SIGNAL_MATCH_UNBLOCKED)), (signal_id), 0, 0, (func), (data)) <> 0)

declare function gtk_signal_newv(byval name as const gchar ptr, byval signal_flags as GtkSignalRunType, byval object_type as GType, byval function_offset as guint, byval marshaller as GSignalCMarshaller, byval return_val as GType, byval n_args as guint, byval args as GType ptr) as guint
declare function gtk_signal_new(byval name as const gchar ptr, byval signal_flags as GtkSignalRunType, byval object_type as GType, byval function_offset as guint, byval marshaller as GSignalCMarshaller, byval return_val as GType, byval n_args as guint, ...) as guint
declare sub gtk_signal_emit_stop_by_name(byval object as GtkObject ptr, byval name as const gchar ptr)
declare sub gtk_signal_connect_object_while_alive(byval object as GtkObject ptr, byval name as const gchar ptr, byval func as GCallback, byval alive_object as GtkObject ptr)
declare sub gtk_signal_connect_while_alive(byval object as GtkObject ptr, byval name as const gchar ptr, byval func as GCallback, byval func_data as gpointer, byval alive_object as GtkObject ptr)
declare function gtk_signal_connect_full(byval object as GtkObject ptr, byval name as const gchar ptr, byval func as GCallback, byval unsupported as GtkCallbackMarshal, byval data as gpointer, byval destroy_func as GDestroyNotify, byval object_signal as gint, byval after as gint) as gulong
declare sub gtk_signal_emitv(byval object as GtkObject ptr, byval signal_id as guint, byval args as GtkArg ptr)
declare sub gtk_signal_emit(byval object as GtkObject ptr, byval signal_id as guint, ...)
declare sub gtk_signal_emit_by_name(byval object as GtkObject ptr, byval name as const gchar ptr, ...)
declare sub gtk_signal_emitv_by_name(byval object as GtkObject ptr, byval name as const gchar ptr, byval args as GtkArg ptr)
declare sub gtk_signal_compat_matched(byval object as GtkObject ptr, byval func as GCallback, byval data as gpointer, byval match as GSignalMatchType, byval action as guint)

#define GTK_TYPE_CALENDAR gtk_calendar_get_type()
#define GTK_CALENDAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CALENDAR, GtkCalendar)
#define GTK_CALENDAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CALENDAR, GtkCalendarClass)
#define GTK_IS_CALENDAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CALENDAR)
#define GTK_IS_CALENDAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CALENDAR)
#define GTK_CALENDAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CALENDAR, GtkCalendarClass)

type GtkCalendar as _GtkCalendar
type GtkCalendarClass as _GtkCalendarClass
type GtkCalendarPrivate as _GtkCalendarPrivate

type GtkCalendarDisplayOptions as long
enum
	GTK_CALENDAR_SHOW_HEADING = 1 shl 0
	GTK_CALENDAR_SHOW_DAY_NAMES = 1 shl 1
	GTK_CALENDAR_NO_MONTH_CHANGE = 1 shl 2
	GTK_CALENDAR_SHOW_WEEK_NUMBERS = 1 shl 3
	GTK_CALENDAR_WEEK_START_MONDAY = 1 shl 4
	GTK_CALENDAR_SHOW_DETAILS = 1 shl 5
end enum

type GtkCalendarDetailFunc as function(byval calendar as GtkCalendar ptr, byval year as guint, byval month as guint, byval day as guint, byval user_data as gpointer) as gchar ptr

type _GtkCalendar
	widget as GtkWidget
	header_style as GtkStyle ptr
	label_style as GtkStyle ptr
	month as gint
	year as gint
	selected_day as gint
	day_month(0 to 5, 0 to 6) as gint
	day(0 to 5, 0 to 6) as gint
	num_marked_dates as gint
	marked_date(0 to 30) as gint
	display_flags as GtkCalendarDisplayOptions
	marked_date_color(0 to 30) as GdkColor
	gc as GdkGC ptr
	xor_gc as GdkGC ptr
	focus_row as gint
	focus_col as gint
	highlight_row as gint
	highlight_col as gint
	priv as GtkCalendarPrivate ptr
	grow_space as zstring * 32
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkCalendarClass
	parent_class as GtkWidgetClass
	month_changed as sub(byval calendar as GtkCalendar ptr)
	day_selected as sub(byval calendar as GtkCalendar ptr)
	day_selected_double_click as sub(byval calendar as GtkCalendar ptr)
	prev_month as sub(byval calendar as GtkCalendar ptr)
	next_month as sub(byval calendar as GtkCalendar ptr)
	prev_year as sub(byval calendar as GtkCalendar ptr)
	next_year as sub(byval calendar as GtkCalendar ptr)
end type

declare function gtk_calendar_get_type() as GType
declare function gtk_calendar_new() as GtkWidget ptr
declare function gtk_calendar_select_month(byval calendar as GtkCalendar ptr, byval month as guint, byval year as guint) as gboolean
declare sub gtk_calendar_select_day(byval calendar as GtkCalendar ptr, byval day as guint)
declare function gtk_calendar_mark_day(byval calendar as GtkCalendar ptr, byval day as guint) as gboolean
declare function gtk_calendar_unmark_day(byval calendar as GtkCalendar ptr, byval day as guint) as gboolean
declare sub gtk_calendar_clear_marks(byval calendar as GtkCalendar ptr)
declare sub gtk_calendar_set_display_options(byval calendar as GtkCalendar ptr, byval flags as GtkCalendarDisplayOptions)
declare function gtk_calendar_get_display_options(byval calendar as GtkCalendar ptr) as GtkCalendarDisplayOptions
declare sub gtk_calendar_display_options(byval calendar as GtkCalendar ptr, byval flags as GtkCalendarDisplayOptions)
declare sub gtk_calendar_get_date(byval calendar as GtkCalendar ptr, byval year as guint ptr, byval month as guint ptr, byval day as guint ptr)
declare sub gtk_calendar_set_detail_func(byval calendar as GtkCalendar ptr, byval func as GtkCalendarDetailFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_calendar_set_detail_width_chars(byval calendar as GtkCalendar ptr, byval chars as gint)
declare sub gtk_calendar_set_detail_height_rows(byval calendar as GtkCalendar ptr, byval rows as gint)
declare function gtk_calendar_get_detail_width_chars(byval calendar as GtkCalendar ptr) as gint
declare function gtk_calendar_get_detail_height_rows(byval calendar as GtkCalendar ptr) as gint
declare sub gtk_calendar_freeze(byval calendar as GtkCalendar ptr)
declare sub gtk_calendar_thaw(byval calendar as GtkCalendar ptr)

#define __GTK_CELL_EDITABLE_H__
#define GTK_TYPE_CELL_EDITABLE gtk_cell_editable_get_type()
#define GTK_CELL_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditable)
#define GTK_CELL_EDITABLE_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditableIface)
#define GTK_IS_CELL_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_EDITABLE)
#define GTK_CELL_EDITABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditableIface)
type GtkCellEditable as _GtkCellEditable
type GtkCellEditableIface as _GtkCellEditableIface

type _GtkCellEditableIface
	g_iface as GTypeInterface
	editing_done as sub(byval cell_editable as GtkCellEditable ptr)
	remove_widget as sub(byval cell_editable as GtkCellEditable ptr)
	start_editing as sub(byval cell_editable as GtkCellEditable ptr, byval event as GdkEvent ptr)
end type

declare function gtk_cell_editable_get_type() as GType
declare sub gtk_cell_editable_start_editing(byval cell_editable as GtkCellEditable ptr, byval event as GdkEvent ptr)
declare sub gtk_cell_editable_editing_done(byval cell_editable as GtkCellEditable ptr)
declare sub gtk_cell_editable_remove_widget(byval cell_editable as GtkCellEditable ptr)
#define __GTK_CELL_LAYOUT_H__
#define __GTK_CELL_RENDERER_H__

type GtkCellRendererState as long
enum
	GTK_CELL_RENDERER_SELECTED = 1 shl 0
	GTK_CELL_RENDERER_PRELIT = 1 shl 1
	GTK_CELL_RENDERER_INSENSITIVE = 1 shl 2
	GTK_CELL_RENDERER_SORTED = 1 shl 3
	GTK_CELL_RENDERER_FOCUSED = 1 shl 4
end enum

type GtkCellRendererMode as long
enum
	GTK_CELL_RENDERER_MODE_INERT
	GTK_CELL_RENDERER_MODE_ACTIVATABLE
	GTK_CELL_RENDERER_MODE_EDITABLE
end enum

#define GTK_TYPE_CELL_RENDERER gtk_cell_renderer_get_type()
#define GTK_CELL_RENDERER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER, GtkCellRenderer)
#define GTK_CELL_RENDERER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER, GtkCellRendererClass)
#define GTK_IS_CELL_RENDERER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER)
#define GTK_IS_CELL_RENDERER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER)
#define GTK_CELL_RENDERER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER, GtkCellRendererClass)
type GtkCellRenderer as _GtkCellRenderer
type GtkCellRendererClass as _GtkCellRendererClass

type _GtkCellRenderer
	parent as GtkObject
	xalign as gfloat
	yalign as gfloat
	width as gint
	height as gint
	xpad as guint16
	ypad as guint16
	mode : 2 as guint
	visible : 1 as guint
	is_expander : 1 as guint
	is_expanded : 1 as guint
	cell_background_set : 1 as guint
	sensitive : 1 as guint
	editing : 1 as guint
end type

type _GtkCellRendererClass
	parent_class as GtkObjectClass
	get_size as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval cell_area as GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
	render as sub(byval cell as GtkCellRenderer ptr, byval window as GdkDrawable ptr, byval widget as GtkWidget ptr, byval background_area as GdkRectangle ptr, byval cell_area as GdkRectangle ptr, byval expose_area as GdkRectangle ptr, byval flags as GtkCellRendererState)
	activate as function(byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as const gchar ptr, byval background_area as GdkRectangle ptr, byval cell_area as GdkRectangle ptr, byval flags as GtkCellRendererState) as gboolean
	start_editing as function(byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as const gchar ptr, byval background_area as GdkRectangle ptr, byval cell_area as GdkRectangle ptr, byval flags as GtkCellRendererState) as GtkCellEditable ptr
	editing_canceled as sub(byval cell as GtkCellRenderer ptr)
	editing_started as sub(byval cell as GtkCellRenderer ptr, byval editable as GtkCellEditable ptr, byval path as const gchar ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_cell_renderer_get_type() as GType
declare sub gtk_cell_renderer_get_size(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_cell_renderer_render(byval cell as GtkCellRenderer ptr, byval window as GdkWindow ptr, byval widget as GtkWidget ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval expose_area as const GdkRectangle ptr, byval flags as GtkCellRendererState)
declare function gtk_cell_renderer_activate(byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as const gchar ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as gboolean
declare function gtk_cell_renderer_start_editing(byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as const gchar ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as GtkCellEditable ptr
declare sub gtk_cell_renderer_set_fixed_size(byval cell as GtkCellRenderer ptr, byval width as gint, byval height as gint)
declare sub gtk_cell_renderer_get_fixed_size(byval cell as GtkCellRenderer ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_cell_renderer_set_alignment(byval cell as GtkCellRenderer ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_cell_renderer_get_alignment(byval cell as GtkCellRenderer ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_cell_renderer_set_padding(byval cell as GtkCellRenderer ptr, byval xpad as gint, byval ypad as gint)
declare sub gtk_cell_renderer_get_padding(byval cell as GtkCellRenderer ptr, byval xpad as gint ptr, byval ypad as gint ptr)
declare sub gtk_cell_renderer_set_visible(byval cell as GtkCellRenderer ptr, byval visible as gboolean)
declare function gtk_cell_renderer_get_visible(byval cell as GtkCellRenderer ptr) as gboolean
declare sub gtk_cell_renderer_set_sensitive(byval cell as GtkCellRenderer ptr, byval sensitive as gboolean)
declare function gtk_cell_renderer_get_sensitive(byval cell as GtkCellRenderer ptr) as gboolean
declare sub gtk_cell_renderer_editing_canceled(byval cell as GtkCellRenderer ptr)
declare sub gtk_cell_renderer_stop_editing(byval cell as GtkCellRenderer ptr, byval canceled as gboolean)

#define __GTK_TREE_VIEW_COLUMN_H__
#define __GTK_TREE_MODEL_H__
#define GTK_TYPE_TREE_MODEL gtk_tree_model_get_type()
#define GTK_TREE_MODEL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_MODEL, GtkTreeModel)
#define GTK_IS_TREE_MODEL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_MODEL)
#define GTK_TREE_MODEL_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_TREE_MODEL, GtkTreeModelIface)
#define GTK_TYPE_TREE_ITER gtk_tree_iter_get_type()
#define GTK_TYPE_TREE_PATH gtk_tree_path_get_type()
#define GTK_TYPE_TREE_ROW_REFERENCE gtk_tree_row_reference_get_type()

type GtkTreeIter as _GtkTreeIter
type GtkTreePath as _GtkTreePath
type GtkTreeRowReference as _GtkTreeRowReference
type GtkTreeModel as _GtkTreeModel
type GtkTreeModelIface as _GtkTreeModelIface
type GtkTreeModelForeachFunc as function(byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval data as gpointer) as gboolean

type GtkTreeModelFlags as long
enum
	GTK_TREE_MODEL_ITERS_PERSIST = 1 shl 0
	GTK_TREE_MODEL_LIST_ONLY = 1 shl 1
end enum

type _GtkTreeIter
	stamp as gint
	user_data as gpointer
	user_data2 as gpointer
	user_data3 as gpointer
end type

type _GtkTreeModelIface
	g_iface as GTypeInterface
	row_changed as sub(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
	row_inserted as sub(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
	row_has_child_toggled as sub(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
	row_deleted as sub(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr)
	rows_reordered as sub(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr)
	get_flags as function(byval tree_model as GtkTreeModel ptr) as GtkTreeModelFlags
	get_n_columns as function(byval tree_model as GtkTreeModel ptr) as gint
	get_column_type as function(byval tree_model as GtkTreeModel ptr, byval index_ as gint) as GType
	get_iter as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr) as gboolean
	get_path as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as GtkTreePath ptr
	get_value as sub(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
	iter_next as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
	iter_children as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr) as gboolean
	iter_has_child as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
	iter_n_children as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gint
	iter_nth_child as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval n as gint) as gboolean
	iter_parent as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval child as GtkTreeIter ptr) as gboolean
	ref_node as sub(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr)
	unref_node as sub(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr)
end type

declare function gtk_tree_path_new() as GtkTreePath ptr
declare function gtk_tree_path_new_from_string(byval path as const gchar ptr) as GtkTreePath ptr
declare function gtk_tree_path_new_from_indices(byval first_index as gint, ...) as GtkTreePath ptr
declare function gtk_tree_path_to_string(byval path as GtkTreePath ptr) as gchar ptr
declare function gtk_tree_path_new_first() as GtkTreePath ptr
declare sub gtk_tree_path_append_index(byval path as GtkTreePath ptr, byval index_ as gint)
declare sub gtk_tree_path_prepend_index(byval path as GtkTreePath ptr, byval index_ as gint)
declare function gtk_tree_path_get_depth(byval path as GtkTreePath ptr) as gint
declare function gtk_tree_path_get_indices(byval path as GtkTreePath ptr) as gint ptr
declare function gtk_tree_path_get_indices_with_depth(byval path as GtkTreePath ptr, byval depth as gint ptr) as gint ptr
declare sub gtk_tree_path_free(byval path as GtkTreePath ptr)
declare function gtk_tree_path_copy(byval path as const GtkTreePath ptr) as GtkTreePath ptr
declare function gtk_tree_path_get_type() as GType
declare function gtk_tree_path_compare(byval a as const GtkTreePath ptr, byval b as const GtkTreePath ptr) as gint
declare sub gtk_tree_path_next(byval path as GtkTreePath ptr)
declare function gtk_tree_path_prev(byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_path_up(byval path as GtkTreePath ptr) as gboolean
declare sub gtk_tree_path_down(byval path as GtkTreePath ptr)
declare function gtk_tree_path_is_ancestor(byval path as GtkTreePath ptr, byval descendant as GtkTreePath ptr) as gboolean
declare function gtk_tree_path_is_descendant(byval path as GtkTreePath ptr, byval ancestor as GtkTreePath ptr) as gboolean
#define gtk_tree_path_new_root() gtk_tree_path_new_first()
declare function gtk_tree_row_reference_get_type() as GType
declare function gtk_tree_row_reference_new(byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr) as GtkTreeRowReference ptr
declare function gtk_tree_row_reference_new_proxy(byval proxy as GObject ptr, byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr) as GtkTreeRowReference ptr
declare function gtk_tree_row_reference_get_path(byval reference as GtkTreeRowReference ptr) as GtkTreePath ptr
declare function gtk_tree_row_reference_get_model(byval reference as GtkTreeRowReference ptr) as GtkTreeModel ptr
declare function gtk_tree_row_reference_valid(byval reference as GtkTreeRowReference ptr) as gboolean
declare function gtk_tree_row_reference_copy(byval reference as GtkTreeRowReference ptr) as GtkTreeRowReference ptr
declare sub gtk_tree_row_reference_free(byval reference as GtkTreeRowReference ptr)
declare sub gtk_tree_row_reference_inserted(byval proxy as GObject ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_row_reference_deleted(byval proxy as GObject ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_row_reference_reordered(byval proxy as GObject ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr)
declare function gtk_tree_iter_copy(byval iter as GtkTreeIter ptr) as GtkTreeIter ptr
declare sub gtk_tree_iter_free(byval iter as GtkTreeIter ptr)
declare function gtk_tree_iter_get_type() as GType
declare function gtk_tree_model_get_type() as GType
declare function gtk_tree_model_get_flags(byval tree_model as GtkTreeModel ptr) as GtkTreeModelFlags
declare function gtk_tree_model_get_n_columns(byval tree_model as GtkTreeModel ptr) as gint
declare function gtk_tree_model_get_column_type(byval tree_model as GtkTreeModel ptr, byval index_ as gint) as GType
declare function gtk_tree_model_get_iter(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_model_get_iter_from_string(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval path_string as const gchar ptr) as gboolean
declare function gtk_tree_model_get_string_from_iter(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gchar ptr
declare function gtk_tree_model_get_iter_first(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_get_path(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as GtkTreePath ptr
declare sub gtk_tree_model_get_value(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
declare function gtk_tree_model_iter_next(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_iter_children(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_iter_has_child(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_iter_n_children(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gint
declare function gtk_tree_model_iter_nth_child(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval n as gint) as gboolean
declare function gtk_tree_model_iter_parent(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval child as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_model_ref_node(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_unref_node(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_get(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, ...)
declare sub gtk_tree_model_get_valist(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval var_args as va_list)
declare sub gtk_tree_model_foreach(byval model as GtkTreeModel ptr, byval func as GtkTreeModelForeachFunc, byval user_data as gpointer)
#define gtk_tree_model_get_iter_root(tree_model, iter) gtk_tree_model_get_iter_first(tree_model, iter)
declare sub gtk_tree_model_row_changed(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_inserted(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_has_child_toggled(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_deleted(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_model_rows_reordered(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr)

#define __GTK_TREE_SORTABLE_H__
#define GTK_TYPE_TREE_SORTABLE gtk_tree_sortable_get_type()
#define GTK_TREE_SORTABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortable)
#define GTK_TREE_SORTABLE_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface)
#define GTK_IS_TREE_SORTABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_SORTABLE)
#define GTK_TREE_SORTABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface)

enum
	GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID = -1
	GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID = -2
end enum

type GtkTreeSortable as _GtkTreeSortable
type GtkTreeSortableIface as _GtkTreeSortableIface
type GtkTreeIterCompareFunc as function(byval model as GtkTreeModel ptr, byval a as GtkTreeIter ptr, byval b as GtkTreeIter ptr, byval user_data as gpointer) as gint

type _GtkTreeSortableIface
	g_iface as GTypeInterface
	sort_column_changed as sub(byval sortable as GtkTreeSortable ptr)
	get_sort_column_id as function(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint ptr, byval order as GtkSortType ptr) as gboolean
	set_sort_column_id as sub(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval order as GtkSortType)
	set_sort_func as sub(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval func as GtkTreeIterCompareFunc, byval data as gpointer, byval destroy as GDestroyNotify)
	set_default_sort_func as sub(byval sortable as GtkTreeSortable ptr, byval func as GtkTreeIterCompareFunc, byval data as gpointer, byval destroy as GDestroyNotify)
	has_default_sort_func as function(byval sortable as GtkTreeSortable ptr) as gboolean
end type

declare function gtk_tree_sortable_get_type() as GType
declare sub gtk_tree_sortable_sort_column_changed(byval sortable as GtkTreeSortable ptr)
declare function gtk_tree_sortable_get_sort_column_id(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint ptr, byval order as GtkSortType ptr) as gboolean
declare sub gtk_tree_sortable_set_sort_column_id(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval order as GtkSortType)
declare sub gtk_tree_sortable_set_sort_func(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_sortable_set_default_sort_func(byval sortable as GtkTreeSortable ptr, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_tree_sortable_has_default_sort_func(byval sortable as GtkTreeSortable ptr) as gboolean

#define GTK_TYPE_TREE_VIEW_COLUMN gtk_tree_view_column_get_type()
#define GTK_TREE_VIEW_COLUMN(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumn)
#define GTK_TREE_VIEW_COLUMN_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass)
#define GTK_IS_TREE_VIEW_COLUMN(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_VIEW_COLUMN)
#define GTK_IS_TREE_VIEW_COLUMN_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TREE_VIEW_COLUMN)
#define GTK_TREE_VIEW_COLUMN_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass)

type GtkTreeViewColumnSizing as long
enum
	GTK_TREE_VIEW_COLUMN_GROW_ONLY
	GTK_TREE_VIEW_COLUMN_AUTOSIZE
	GTK_TREE_VIEW_COLUMN_FIXED
end enum

type GtkTreeViewColumn as _GtkTreeViewColumn
type GtkTreeViewColumnClass as _GtkTreeViewColumnClass
type GtkTreeCellDataFunc as sub(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval data as gpointer)

type _GtkTreeViewColumn
	parent as GtkObject
	tree_view as GtkWidget ptr
	button as GtkWidget ptr
	child as GtkWidget ptr
	arrow as GtkWidget ptr
	alignment as GtkWidget ptr
	window as GdkWindow ptr
	editable_widget as GtkCellEditable ptr
	xalign as gfloat
	property_changed_signal as guint
	spacing as gint
	column_type as GtkTreeViewColumnSizing
	requested_width as gint
	button_request as gint
	resized_width as gint
	width as gint
	fixed_width as gint
	min_width as gint
	max_width as gint
	drag_x as gint
	drag_y as gint
	title as gchar ptr
	cell_list as GList ptr
	sort_clicked_signal as guint
	sort_column_changed_signal as guint
	sort_column_id as gint
	sort_order as GtkSortType
	visible : 1 as guint
	resizable : 1 as guint
	clickable : 1 as guint
	dirty : 1 as guint
	show_sort_indicator : 1 as guint
	maybe_reordered : 1 as guint
	reorderable : 1 as guint
	use_resized_width : 1 as guint
	expand : 1 as guint
end type

type _GtkTreeViewColumnClass
	parent_class as GtkObjectClass
	clicked as sub(byval tree_column as GtkTreeViewColumn ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tree_view_column_get_type() as GType
declare function gtk_tree_view_column_new() as GtkTreeViewColumn ptr
declare function gtk_tree_view_column_new_with_attributes(byval title as const gchar ptr, byval cell as GtkCellRenderer ptr, ...) as GtkTreeViewColumn ptr
declare sub gtk_tree_view_column_pack_start(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_tree_view_column_pack_end(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_tree_view_column_clear(byval tree_column as GtkTreeViewColumn ptr)
declare function gtk_tree_view_column_get_cell_renderers(byval tree_column as GtkTreeViewColumn ptr) as GList ptr
declare sub gtk_tree_view_column_add_attribute(byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval attribute as const gchar ptr, byval column as gint)
declare sub gtk_tree_view_column_set_attributes(byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, ...)
declare sub gtk_tree_view_column_set_cell_data_func(byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval func as GtkTreeCellDataFunc, byval func_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_view_column_clear_attributes(byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr)
declare sub gtk_tree_view_column_set_spacing(byval tree_column as GtkTreeViewColumn ptr, byval spacing as gint)
declare function gtk_tree_view_column_get_spacing(byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_visible(byval tree_column as GtkTreeViewColumn ptr, byval visible as gboolean)
declare function gtk_tree_view_column_get_visible(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_resizable(byval tree_column as GtkTreeViewColumn ptr, byval resizable as gboolean)
declare function gtk_tree_view_column_get_resizable(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_sizing(byval tree_column as GtkTreeViewColumn ptr, byval type as GtkTreeViewColumnSizing)
declare function gtk_tree_view_column_get_sizing(byval tree_column as GtkTreeViewColumn ptr) as GtkTreeViewColumnSizing
declare function gtk_tree_view_column_get_width(byval tree_column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_column_get_fixed_width(byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_fixed_width(byval tree_column as GtkTreeViewColumn ptr, byval fixed_width as gint)
declare sub gtk_tree_view_column_set_min_width(byval tree_column as GtkTreeViewColumn ptr, byval min_width as gint)
declare function gtk_tree_view_column_get_min_width(byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_max_width(byval tree_column as GtkTreeViewColumn ptr, byval max_width as gint)
declare function gtk_tree_view_column_get_max_width(byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_clicked(byval tree_column as GtkTreeViewColumn ptr)
declare sub gtk_tree_view_column_set_title(byval tree_column as GtkTreeViewColumn ptr, byval title as const gchar ptr)
declare function gtk_tree_view_column_get_title(byval tree_column as GtkTreeViewColumn ptr) as const gchar ptr
declare sub gtk_tree_view_column_set_expand(byval tree_column as GtkTreeViewColumn ptr, byval expand as gboolean)
declare function gtk_tree_view_column_get_expand(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_clickable(byval tree_column as GtkTreeViewColumn ptr, byval clickable as gboolean)
declare function gtk_tree_view_column_get_clickable(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_widget(byval tree_column as GtkTreeViewColumn ptr, byval widget as GtkWidget ptr)
declare function gtk_tree_view_column_get_widget(byval tree_column as GtkTreeViewColumn ptr) as GtkWidget ptr
declare sub gtk_tree_view_column_set_alignment(byval tree_column as GtkTreeViewColumn ptr, byval xalign as gfloat)
declare function gtk_tree_view_column_get_alignment(byval tree_column as GtkTreeViewColumn ptr) as gfloat
declare sub gtk_tree_view_column_set_reorderable(byval tree_column as GtkTreeViewColumn ptr, byval reorderable as gboolean)
declare function gtk_tree_view_column_get_reorderable(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_sort_column_id(byval tree_column as GtkTreeViewColumn ptr, byval sort_column_id as gint)
declare function gtk_tree_view_column_get_sort_column_id(byval tree_column as GtkTreeViewColumn ptr) as gint
declare sub gtk_tree_view_column_set_sort_indicator(byval tree_column as GtkTreeViewColumn ptr, byval setting as gboolean)
declare function gtk_tree_view_column_get_sort_indicator(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_set_sort_order(byval tree_column as GtkTreeViewColumn ptr, byval order as GtkSortType)
declare function gtk_tree_view_column_get_sort_order(byval tree_column as GtkTreeViewColumn ptr) as GtkSortType
declare sub gtk_tree_view_column_cell_set_cell_data(byval tree_column as GtkTreeViewColumn ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval is_expander as gboolean, byval is_expanded as gboolean)
declare sub gtk_tree_view_column_cell_get_size(byval tree_column as GtkTreeViewColumn ptr, byval cell_area as const GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
declare function gtk_tree_view_column_cell_is_visible(byval tree_column as GtkTreeViewColumn ptr) as gboolean
declare sub gtk_tree_view_column_focus_cell(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr)
declare function gtk_tree_view_column_cell_get_position(byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval start_pos as gint ptr, byval width as gint ptr) as gboolean
declare sub gtk_tree_view_column_queue_resize(byval tree_column as GtkTreeViewColumn ptr)
declare function gtk_tree_view_column_get_tree_view(byval tree_column as GtkTreeViewColumn ptr) as GtkWidget ptr

#define GTK_TYPE_CELL_LAYOUT gtk_cell_layout_get_type()
#define GTK_CELL_LAYOUT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_LAYOUT, GtkCellLayout)
#define GTK_IS_CELL_LAYOUT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_LAYOUT)
#define GTK_CELL_LAYOUT_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_CELL_LAYOUT, GtkCellLayoutIface)

type GtkCellLayout as _GtkCellLayout
type GtkCellLayoutIface as _GtkCellLayoutIface
type GtkCellLayoutDataFunc as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval data as gpointer)

type _GtkCellLayoutIface
	g_iface as GTypeInterface
	pack_start as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
	pack_end as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
	clear as sub(byval cell_layout as GtkCellLayout ptr)
	add_attribute as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval attribute as const gchar ptr, byval column as gint)
	set_cell_data_func as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval func as GtkCellLayoutDataFunc, byval func_data as gpointer, byval destroy as GDestroyNotify)
	clear_attributes as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr)
	reorder as sub(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval position as gint)
	get_cells as function(byval cell_layout as GtkCellLayout ptr) as GList ptr
end type

declare function gtk_cell_layout_get_type() as GType
declare sub gtk_cell_layout_pack_start(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_cell_layout_pack_end(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare function gtk_cell_layout_get_cells(byval cell_layout as GtkCellLayout ptr) as GList ptr
declare sub gtk_cell_layout_clear(byval cell_layout as GtkCellLayout ptr)
declare sub gtk_cell_layout_set_attributes(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, ...)
declare sub gtk_cell_layout_add_attribute(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval attribute as const gchar ptr, byval column as gint)
declare sub gtk_cell_layout_set_cell_data_func(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval func as GtkCellLayoutDataFunc, byval func_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_cell_layout_clear_attributes(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr)
declare sub gtk_cell_layout_reorder(byval cell_layout as GtkCellLayout ptr, byval cell as GtkCellRenderer ptr, byval position as gint)
declare function _gtk_cell_layout_buildable_custom_tag_start(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval parser as GMarkupParser ptr, byval data as gpointer ptr) as gboolean
declare sub _gtk_cell_layout_buildable_custom_tag_end(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval data as gpointer ptr)
declare sub _gtk_cell_layout_buildable_add_child(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval type as const gchar ptr)

#define __GTK_CELL_RENDERER_ACCEL_H__
#define __GTK_CELL_RENDERER_TEXT_H__
#define GTK_TYPE_CELL_RENDERER_TEXT gtk_cell_renderer_text_get_type()
#define GTK_CELL_RENDERER_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_TEXT, GtkCellRendererText)
#define GTK_CELL_RENDERER_TEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_TEXT, GtkCellRendererTextClass)
#define GTK_IS_CELL_RENDERER_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_TEXT)
#define GTK_IS_CELL_RENDERER_TEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_TEXT)
#define GTK_CELL_RENDERER_TEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_TEXT, GtkCellRendererTextClass)
type GtkCellRendererText as _GtkCellRendererText
type GtkCellRendererTextClass as _GtkCellRendererTextClass

type _GtkCellRendererText
	parent as GtkCellRenderer
	text as gchar ptr
	font as PangoFontDescription ptr
	font_scale as gdouble
	foreground as PangoColor
	background as PangoColor
	extra_attrs as PangoAttrList ptr
	underline_style as PangoUnderline
	rise as gint
	fixed_height_rows as gint
	strikethrough : 1 as guint
	editable : 1 as guint
	scale_set : 1 as guint
	foreground_set : 1 as guint
	background_set : 1 as guint
	underline_set : 1 as guint
	rise_set : 1 as guint
	strikethrough_set : 1 as guint
	editable_set : 1 as guint
	calc_fixed_height : 1 as guint
end type

type _GtkCellRendererTextClass
	parent_class as GtkCellRendererClass
	edited as sub(byval cell_renderer_text as GtkCellRendererText ptr, byval path as const gchar ptr, byval new_text as const gchar ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_text_get_type() as GType
declare function gtk_cell_renderer_text_new() as GtkCellRenderer ptr
declare sub gtk_cell_renderer_text_set_fixed_height_from_font(byval renderer as GtkCellRendererText ptr, byval number_of_rows as gint)

#define GTK_TYPE_CELL_RENDERER_ACCEL gtk_cell_renderer_accel_get_type()
#define GTK_CELL_RENDERER_ACCEL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_ACCEL, GtkCellRendererAccel)
#define GTK_CELL_RENDERER_ACCEL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_ACCEL, GtkCellRendererAccelClass)
#define GTK_IS_CELL_RENDERER_ACCEL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_ACCEL)
#define GTK_IS_CELL_RENDERER_ACCEL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_ACCEL)
#define GTK_CELL_RENDERER_ACCEL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_ACCEL, GtkCellRendererAccelClass)
type GtkCellRendererAccel as _GtkCellRendererAccel
type GtkCellRendererAccelClass as _GtkCellRendererAccelClass

type GtkCellRendererAccelMode as long
enum
	GTK_CELL_RENDERER_ACCEL_MODE_GTK
	GTK_CELL_RENDERER_ACCEL_MODE_OTHER
end enum

type _GtkCellRendererAccel
	parent as GtkCellRendererText
	accel_key as guint
	accel_mods as GdkModifierType
	keycode as guint
	accel_mode as GtkCellRendererAccelMode
	edit_widget as GtkWidget ptr
	grab_widget as GtkWidget ptr
	sizing_label as GtkWidget ptr
end type

type _GtkCellRendererAccelClass
	parent_class as GtkCellRendererTextClass
	accel_edited as sub(byval accel as GtkCellRendererAccel ptr, byval path_string as const gchar ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval hardware_keycode as guint)
	accel_cleared as sub(byval accel as GtkCellRendererAccel ptr, byval path_string as const gchar ptr)
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_accel_get_type() as GType
declare function gtk_cell_renderer_accel_new() as GtkCellRenderer ptr
#define __GTK_CELL_RENDERER_COMBO_H__
#define GTK_TYPE_CELL_RENDERER_COMBO gtk_cell_renderer_combo_get_type()
#define GTK_CELL_RENDERER_COMBO(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererCombo)
#define GTK_CELL_RENDERER_COMBO_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererComboClass)
#define GTK_IS_CELL_RENDERER_COMBO(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_COMBO)
#define GTK_IS_CELL_RENDERER_COMBO_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_COMBO)
#define GTK_CELL_RENDERER_COMBO_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererTextClass)
type GtkCellRendererCombo as _GtkCellRendererCombo
type GtkCellRendererComboClass as _GtkCellRendererComboClass

type _GtkCellRendererCombo
	parent as GtkCellRendererText
	model as GtkTreeModel ptr
	text_column as gint
	has_entry as gboolean
	focus_out_id as guint
end type

type _GtkCellRendererComboClass
	parent as GtkCellRendererTextClass
end type

declare function gtk_cell_renderer_combo_get_type() as GType
declare function gtk_cell_renderer_combo_new() as GtkCellRenderer ptr
#define __GTK_CELL_RENDERER_PIXBUF_H__
#define GTK_TYPE_CELL_RENDERER_PIXBUF gtk_cell_renderer_pixbuf_get_type()
#define GTK_CELL_RENDERER_PIXBUF(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbuf)
#define GTK_CELL_RENDERER_PIXBUF_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbufClass)
#define GTK_IS_CELL_RENDERER_PIXBUF(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_PIXBUF)
#define GTK_IS_CELL_RENDERER_PIXBUF_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_PIXBUF)
#define GTK_CELL_RENDERER_PIXBUF_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbufClass)
type GtkCellRendererPixbuf as _GtkCellRendererPixbuf
type GtkCellRendererPixbufClass as _GtkCellRendererPixbufClass

type _GtkCellRendererPixbuf
	parent as GtkCellRenderer
	pixbuf as GdkPixbuf ptr
	pixbuf_expander_open as GdkPixbuf ptr
	pixbuf_expander_closed as GdkPixbuf ptr
end type

type _GtkCellRendererPixbufClass
	parent_class as GtkCellRendererClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_pixbuf_get_type() as GType
declare function gtk_cell_renderer_pixbuf_new() as GtkCellRenderer ptr
#define __GTK_CELL_RENDERER_PROGRESS_H__
#define GTK_TYPE_CELL_RENDERER_PROGRESS gtk_cell_renderer_progress_get_type()
#define GTK_CELL_RENDERER_PROGRESS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgress)
#define GTK_CELL_RENDERER_PROGRESS_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgressClass)
#define GTK_IS_CELL_RENDERER_PROGRESS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_PROGRESS)
#define GTK_IS_CELL_RENDERER_PROGRESS_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_PROGRESS)
#define GTK_CELL_RENDERER_PROGRESS_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgressClass)

type GtkCellRendererProgress as _GtkCellRendererProgress
type GtkCellRendererProgressClass as _GtkCellRendererProgressClass
type GtkCellRendererProgressPrivate as _GtkCellRendererProgressPrivate

type _GtkCellRendererProgress
	parent_instance as GtkCellRenderer
	priv as GtkCellRendererProgressPrivate ptr
end type

type _GtkCellRendererProgressClass
	parent_class as GtkCellRendererClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_progress_get_type() as GType
declare function gtk_cell_renderer_progress_new() as GtkCellRenderer ptr
#define __GTK_CELL_RENDERER_SPIN_H__
#define GTK_TYPE_CELL_RENDERER_SPIN gtk_cell_renderer_spin_get_type()
#define GTK_CELL_RENDERER_SPIN(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_SPIN, GtkCellRendererSpin)
#define GTK_CELL_RENDERER_SPIN_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_SPIN, GtkCellRendererSpinClass)
#define GTK_IS_CELL_RENDERER_SPIN(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_SPIN)
#define GTK_IS_CELL_RENDERER_SPIN_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_SPIN)
#define GTK_CELL_RENDERER_SPIN_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_SPIN, GtkCellRendererTextClass)

type GtkCellRendererSpin as _GtkCellRendererSpin
type GtkCellRendererSpinClass as _GtkCellRendererSpinClass
type GtkCellRendererSpinPrivate as _GtkCellRendererSpinPrivate

type _GtkCellRendererSpin
	parent as GtkCellRendererText
end type

type _GtkCellRendererSpinClass
	parent as GtkCellRendererTextClass
end type

declare function gtk_cell_renderer_spin_get_type() as GType
declare function gtk_cell_renderer_spin_new() as GtkCellRenderer ptr
#define __GTK_CELL_RENDERER_SPINNER_H__
#define GTK_TYPE_CELL_RENDERER_SPINNER gtk_cell_renderer_spinner_get_type()
#define GTK_CELL_RENDERER_SPINNER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_SPINNER, GtkCellRendererSpinner)
#define GTK_CELL_RENDERER_SPINNER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_SPINNER, GtkCellRendererSpinnerClass)
#define GTK_IS_CELL_RENDERER_SPINNER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_SPINNER)
#define GTK_IS_CELL_RENDERER_SPINNER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_SPINNER)
#define GTK_CELL_RENDERER_SPINNER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_SPINNER, GtkCellRendererSpinnerClass)

type GtkCellRendererSpinner as _GtkCellRendererSpinner
type GtkCellRendererSpinnerClass as _GtkCellRendererSpinnerClass
type GtkCellRendererSpinnerPrivate as _GtkCellRendererSpinnerPrivate

type _GtkCellRendererSpinner
	parent as GtkCellRenderer
	priv as GtkCellRendererSpinnerPrivate ptr
end type

type _GtkCellRendererSpinnerClass
	parent_class as GtkCellRendererClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_spinner_get_type() as GType
declare function gtk_cell_renderer_spinner_new() as GtkCellRenderer ptr
#define __GTK_CELL_RENDERER_TOGGLE_H__
#define GTK_TYPE_CELL_RENDERER_TOGGLE gtk_cell_renderer_toggle_get_type()
#define GTK_CELL_RENDERER_TOGGLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggle)
#define GTK_CELL_RENDERER_TOGGLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggleClass)
#define GTK_IS_CELL_RENDERER_TOGGLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_RENDERER_TOGGLE)
#define GTK_IS_CELL_RENDERER_TOGGLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_RENDERER_TOGGLE)
#define GTK_CELL_RENDERER_TOGGLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggleClass)
type GtkCellRendererToggle as _GtkCellRendererToggle
type GtkCellRendererToggleClass as _GtkCellRendererToggleClass

type _GtkCellRendererToggle
	parent as GtkCellRenderer
	active : 1 as guint
	activatable : 1 as guint
	radio : 1 as guint
end type

type _GtkCellRendererToggleClass
	parent_class as GtkCellRendererClass
	toggled as sub(byval cell_renderer_toggle as GtkCellRendererToggle ptr, byval path as const gchar ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_toggle_get_type() as GType
declare function gtk_cell_renderer_toggle_new() as GtkCellRenderer ptr
declare function gtk_cell_renderer_toggle_get_radio(byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_radio(byval toggle as GtkCellRendererToggle ptr, byval radio as gboolean)
declare function gtk_cell_renderer_toggle_get_active(byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_active(byval toggle as GtkCellRendererToggle ptr, byval setting as gboolean)
declare function gtk_cell_renderer_toggle_get_activatable(byval toggle as GtkCellRendererToggle ptr) as gboolean
declare sub gtk_cell_renderer_toggle_set_activatable(byval toggle as GtkCellRendererToggle ptr, byval setting as gboolean)

#define __GTK_CELL_VIEW_H__
#define GTK_TYPE_CELL_VIEW gtk_cell_view_get_type()
#define GTK_CELL_VIEW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_VIEW, GtkCellView)
#define GTK_CELL_VIEW_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_CELL_VIEW, GtkCellViewClass)
#define GTK_IS_CELL_VIEW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_VIEW)
#define GTK_IS_CELL_VIEW_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_CELL_VIEW)
#define GTK_CELL_VIEW_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), GTK_TYPE_CELL_VIEW, GtkCellViewClass)

type GtkCellView as _GtkCellView
type GtkCellViewClass as _GtkCellViewClass
type GtkCellViewPrivate as _GtkCellViewPrivate

type _GtkCellView
	parent_instance as GtkWidget
	priv as GtkCellViewPrivate ptr
end type

type _GtkCellViewClass
	parent_class as GtkWidgetClass
end type

declare function gtk_cell_view_get_type() as GType
declare function gtk_cell_view_new() as GtkWidget ptr
declare function gtk_cell_view_new_with_text(byval text as const gchar ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_markup(byval markup as const gchar ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_pixbuf(byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare sub gtk_cell_view_set_model(byval cell_view as GtkCellView ptr, byval model as GtkTreeModel ptr)
declare function gtk_cell_view_get_model(byval cell_view as GtkCellView ptr) as GtkTreeModel ptr
declare sub gtk_cell_view_set_displayed_row(byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr)
declare function gtk_cell_view_get_displayed_row(byval cell_view as GtkCellView ptr) as GtkTreePath ptr
declare function gtk_cell_view_get_size_of_row(byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr, byval requisition as GtkRequisition ptr) as gboolean
declare sub gtk_cell_view_set_background_color(byval cell_view as GtkCellView ptr, byval color as const GdkColor ptr)
declare function gtk_cell_view_get_cell_renderers(byval cell_view as GtkCellView ptr) as GList ptr

#define __GTK_CHECK_BUTTON_H__
#define __GTK_TOGGLE_BUTTON_H__
#define GTK_TYPE_TOGGLE_BUTTON gtk_toggle_button_get_type()
#define GTK_TOGGLE_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButton)
#define GTK_TOGGLE_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass)
#define GTK_IS_TOGGLE_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOGGLE_BUTTON)
#define GTK_IS_TOGGLE_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOGGLE_BUTTON)
#define GTK_TOGGLE_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass)
type GtkToggleButton as _GtkToggleButton
type GtkToggleButtonClass as _GtkToggleButtonClass

type _GtkToggleButton
	button as GtkButton
	active : 1 as guint
	draw_indicator : 1 as guint
	inconsistent : 1 as guint
end type

type _GtkToggleButtonClass
	parent_class as GtkButtonClass
	toggled as sub(byval toggle_button as GtkToggleButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_toggle_button_get_type() as GType
declare function gtk_toggle_button_new() as GtkWidget ptr
declare function gtk_toggle_button_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_toggle_button_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_toggle_button_set_mode(byval toggle_button as GtkToggleButton ptr, byval draw_indicator as gboolean)
declare function gtk_toggle_button_get_mode(byval toggle_button as GtkToggleButton ptr) as gboolean
declare sub gtk_toggle_button_set_active(byval toggle_button as GtkToggleButton ptr, byval is_active as gboolean)
declare function gtk_toggle_button_get_active(byval toggle_button as GtkToggleButton ptr) as gboolean
declare sub gtk_toggle_button_toggled(byval toggle_button as GtkToggleButton ptr)
declare sub gtk_toggle_button_set_inconsistent(byval toggle_button as GtkToggleButton ptr, byval setting as gboolean)
declare function gtk_toggle_button_get_inconsistent(byval toggle_button as GtkToggleButton ptr) as gboolean
declare sub gtk_toggle_button_set_state alias "gtk_toggle_button_set_active"(byval toggle_button as GtkToggleButton ptr, byval is_active as gboolean)

#define GTK_TYPE_CHECK_BUTTON gtk_check_button_get_type()
#define GTK_CHECK_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CHECK_BUTTON, GtkCheckButton)
#define GTK_CHECK_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CHECK_BUTTON, GtkCheckButtonClass)
#define GTK_IS_CHECK_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CHECK_BUTTON)
#define GTK_IS_CHECK_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CHECK_BUTTON)
#define GTK_CHECK_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CHECK_BUTTON, GtkCheckButtonClass)
type GtkCheckButton as _GtkCheckButton
type GtkCheckButtonClass as _GtkCheckButtonClass

type _GtkCheckButton
	toggle_button as GtkToggleButton
end type

type _GtkCheckButtonClass
	parent_class as GtkToggleButtonClass
	draw_indicator as sub(byval check_button as GtkCheckButton ptr, byval area as GdkRectangle ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_check_button_get_type() as GType
declare function gtk_check_button_new() as GtkWidget ptr
declare function gtk_check_button_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_check_button_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub _gtk_check_button_get_props(byval check_button as GtkCheckButton ptr, byval indicator_size as gint ptr, byval indicator_spacing as gint ptr)

#define __GTK_CHECK_MENU_ITEM_H__
#define __GTK_MENU_ITEM_H__
#define __GTK_ITEM_H__
#define GTK_TYPE_ITEM gtk_item_get_type()
#define GTK_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ITEM, GtkItem)
#define GTK_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ITEM, GtkItemClass)
#define GTK_IS_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ITEM)
#define GTK_IS_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ITEM)
#define GTK_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ITEM, GtkItemClass)
type GtkItem as _GtkItem
type GtkItemClass as _GtkItemClass

type _GtkItem
	bin as GtkBin
end type

type _GtkItemClass
	parent_class as GtkBinClass
	select as sub(byval item as GtkItem ptr)
	deselect as sub(byval item as GtkItem ptr)
	toggle as sub(byval item as GtkItem ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_item_get_type() as GType
declare sub gtk_item_select(byval item as GtkItem ptr)
declare sub gtk_item_deselect(byval item as GtkItem ptr)
declare sub gtk_item_toggle(byval item as GtkItem ptr)

#define GTK_TYPE_MENU_ITEM gtk_menu_item_get_type()
#define GTK_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU_ITEM, GtkMenuItem)
#define GTK_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU_ITEM, GtkMenuItemClass)
#define GTK_IS_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU_ITEM)
#define GTK_IS_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU_ITEM)
#define GTK_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU_ITEM, GtkMenuItemClass)
type GtkMenuItem as _GtkMenuItem
type GtkMenuItemClass as _GtkMenuItemClass

type _GtkMenuItem
	item as GtkItem
	submenu as GtkWidget ptr
	event_window as GdkWindow ptr
	toggle_size as guint16
	accelerator_width as guint16
	accel_path as gchar ptr
	show_submenu_indicator : 1 as guint
	submenu_placement : 1 as guint
	submenu_direction : 1 as guint
	right_justify : 1 as guint
	timer_from_keypress : 1 as guint
	from_menubar : 1 as guint
	timer as guint
end type

type _GtkMenuItemClass
	parent_class as GtkItemClass
	hide_on_activate : 1 as guint
	activate as sub(byval menu_item as GtkMenuItem ptr)
	activate_item as sub(byval menu_item as GtkMenuItem ptr)
	toggle_size_request as sub(byval menu_item as GtkMenuItem ptr, byval requisition as gint ptr)
	toggle_size_allocate as sub(byval menu_item as GtkMenuItem ptr, byval allocation as gint)
	set_label as sub(byval menu_item as GtkMenuItem ptr, byval label as const gchar ptr)
	get_label as function(byval menu_item as GtkMenuItem ptr) as const gchar ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_menu_item_get_type() as GType
declare function gtk_menu_item_new() as GtkWidget ptr
declare function gtk_menu_item_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_menu_item_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_menu_item_set_submenu(byval menu_item as GtkMenuItem ptr, byval submenu as GtkWidget ptr)
declare function gtk_menu_item_get_submenu(byval menu_item as GtkMenuItem ptr) as GtkWidget ptr
declare sub gtk_menu_item_select(byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_deselect(byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_activate(byval menu_item as GtkMenuItem ptr)
declare sub gtk_menu_item_toggle_size_request(byval menu_item as GtkMenuItem ptr, byval requisition as gint ptr)
declare sub gtk_menu_item_toggle_size_allocate(byval menu_item as GtkMenuItem ptr, byval allocation as gint)
declare sub gtk_menu_item_set_right_justified(byval menu_item as GtkMenuItem ptr, byval right_justified as gboolean)
declare function gtk_menu_item_get_right_justified(byval menu_item as GtkMenuItem ptr) as gboolean
declare sub gtk_menu_item_set_accel_path(byval menu_item as GtkMenuItem ptr, byval accel_path as const gchar ptr)
declare function gtk_menu_item_get_accel_path(byval menu_item as GtkMenuItem ptr) as const gchar ptr
declare sub gtk_menu_item_set_label(byval menu_item as GtkMenuItem ptr, byval label as const gchar ptr)
declare function gtk_menu_item_get_label(byval menu_item as GtkMenuItem ptr) as const gchar ptr
declare sub gtk_menu_item_set_use_underline(byval menu_item as GtkMenuItem ptr, byval setting as gboolean)
declare function gtk_menu_item_get_use_underline(byval menu_item as GtkMenuItem ptr) as gboolean
declare sub _gtk_menu_item_refresh_accel_path(byval menu_item as GtkMenuItem ptr, byval prefix as const gchar ptr, byval accel_group as GtkAccelGroup ptr, byval group_changed as gboolean)
declare function _gtk_menu_item_is_selectable(byval menu_item as GtkWidget ptr) as gboolean
declare sub _gtk_menu_item_popup_submenu(byval menu_item as GtkWidget ptr, byval with_delay as gboolean)
declare sub _gtk_menu_item_popdown_submenu(byval menu_item as GtkWidget ptr)
declare sub gtk_menu_item_remove_submenu(byval menu_item as GtkMenuItem ptr)

#define gtk_menu_item_right_justify(menu_item) gtk_menu_item_set_right_justified((menu_item), CTRUE)
#define GTK_TYPE_CHECK_MENU_ITEM gtk_check_menu_item_get_type()
#define GTK_CHECK_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItem)
#define GTK_CHECK_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass)
#define GTK_IS_CHECK_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CHECK_MENU_ITEM)
#define GTK_IS_CHECK_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CHECK_MENU_ITEM)
#define GTK_CHECK_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass)
type GtkCheckMenuItem as _GtkCheckMenuItem
type GtkCheckMenuItemClass as _GtkCheckMenuItemClass

type _GtkCheckMenuItem
	menu_item as GtkMenuItem
	active : 1 as guint
	always_show_toggle : 1 as guint
	inconsistent : 1 as guint
	draw_as_radio : 1 as guint
end type

type _GtkCheckMenuItemClass
	parent_class as GtkMenuItemClass
	toggled as sub(byval check_menu_item as GtkCheckMenuItem ptr)
	draw_indicator as sub(byval check_menu_item as GtkCheckMenuItem ptr, byval area as GdkRectangle ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_check_menu_item_get_type() as GType
declare function gtk_check_menu_item_new() as GtkWidget ptr
declare function gtk_check_menu_item_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_check_menu_item_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_check_menu_item_set_active(byval check_menu_item as GtkCheckMenuItem ptr, byval is_active as gboolean)
declare function gtk_check_menu_item_get_active(byval check_menu_item as GtkCheckMenuItem ptr) as gboolean
declare sub gtk_check_menu_item_toggled(byval check_menu_item as GtkCheckMenuItem ptr)
declare sub gtk_check_menu_item_set_inconsistent(byval check_menu_item as GtkCheckMenuItem ptr, byval setting as gboolean)
declare function gtk_check_menu_item_get_inconsistent(byval check_menu_item as GtkCheckMenuItem ptr) as gboolean
declare sub gtk_check_menu_item_set_draw_as_radio(byval check_menu_item as GtkCheckMenuItem ptr, byval draw_as_radio as gboolean)
declare function gtk_check_menu_item_get_draw_as_radio(byval check_menu_item as GtkCheckMenuItem ptr) as gboolean
declare sub gtk_check_menu_item_set_show_toggle(byval menu_item as GtkCheckMenuItem ptr, byval always as gboolean)
declare sub gtk_check_menu_item_set_state alias "gtk_check_menu_item_set_active"(byval check_menu_item as GtkCheckMenuItem ptr, byval is_active as gboolean)

#define __GTK_CLIPBOARD_H__
#define __GTK_SELECTION_H__
#define __GTK_TEXT_ITER_H__
#define __GTK_TEXT_TAG_H__

type GtkTextIter as _GtkTextIter
type GtkTextTagTable as _GtkTextTagTable
type GtkTextAttributes as _GtkTextAttributes

#define GTK_TYPE_TEXT_TAG gtk_text_tag_get_type()
#define GTK_TEXT_TAG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_TAG, GtkTextTag)
#define GTK_TEXT_TAG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_TAG, GtkTextTagClass)
#define GTK_IS_TEXT_TAG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_TAG)
#define GTK_IS_TEXT_TAG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_TAG)
#define GTK_TEXT_TAG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_TAG, GtkTextTagClass)
#define GTK_TYPE_TEXT_ATTRIBUTES gtk_text_attributes_get_type()
type GtkTextTag as _GtkTextTag
type GtkTextTagClass as _GtkTextTagClass

type _GtkTextTag
	parent_instance as GObject
	table as GtkTextTagTable ptr
	name as zstring ptr
	priority as long
	values as GtkTextAttributes ptr
	bg_color_set : 1 as guint
	bg_stipple_set : 1 as guint
	fg_color_set : 1 as guint
	scale_set : 1 as guint
	fg_stipple_set : 1 as guint
	justification_set : 1 as guint
	left_margin_set : 1 as guint
	indent_set : 1 as guint
	rise_set : 1 as guint
	strikethrough_set : 1 as guint
	right_margin_set : 1 as guint
	pixels_above_lines_set : 1 as guint
	pixels_below_lines_set : 1 as guint
	pixels_inside_wrap_set : 1 as guint
	tabs_set : 1 as guint
	underline_set : 1 as guint
	wrap_mode_set : 1 as guint
	bg_full_height_set : 1 as guint
	invisible_set : 1 as guint
	editable_set : 1 as guint
	language_set : 1 as guint
	pg_bg_color_set : 1 as guint
	accumulative_margin : 1 as guint
	pad1 : 1 as guint
end type

type _GtkTextTagClass
	parent_class as GObjectClass
	event as function(byval tag as GtkTextTag ptr, byval event_object as GObject ptr, byval event as GdkEvent ptr, byval iter as const GtkTextIter ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_text_tag_get_type() as GType
declare function gtk_text_tag_new(byval name as const gchar ptr) as GtkTextTag ptr
declare function gtk_text_tag_get_priority(byval tag as GtkTextTag ptr) as gint
declare sub gtk_text_tag_set_priority(byval tag as GtkTextTag ptr, byval priority as gint)
declare function gtk_text_tag_event(byval tag as GtkTextTag ptr, byval event_object as GObject ptr, byval event as GdkEvent ptr, byval iter as const GtkTextIter ptr) as gboolean
type GtkTextAppearance as _GtkTextAppearance

type _GtkTextAppearance
	bg_color as GdkColor
	fg_color as GdkColor
	bg_stipple as GdkBitmap ptr
	fg_stipple as GdkBitmap ptr
	rise as gint
	padding1 as gpointer
	underline : 4 as guint
	strikethrough : 1 as guint
	draw_bg : 1 as guint
	inside_selection : 1 as guint
	is_text : 1 as guint
	pad1 : 1 as guint
	pad2 : 1 as guint
	pad3 : 1 as guint
	pad4 : 1 as guint
end type

type _GtkTextAttributes
	refcount as guint
	appearance as GtkTextAppearance
	justification as GtkJustification
	direction as GtkTextDirection
	font as PangoFontDescription ptr
	font_scale as gdouble
	left_margin as gint
	indent as gint
	right_margin as gint
	pixels_above_lines as gint
	pixels_below_lines as gint
	pixels_inside_wrap as gint
	tabs as PangoTabArray ptr
	wrap_mode as GtkWrapMode
	language as PangoLanguage ptr
	pg_bg_color as GdkColor ptr
	invisible : 1 as guint
	bg_full_height : 1 as guint
	editable : 1 as guint
	realized : 1 as guint
	pad1 : 1 as guint
	pad2 : 1 as guint
	pad3 : 1 as guint
	pad4 : 1 as guint
end type

declare function gtk_text_attributes_new() as GtkTextAttributes ptr
declare function gtk_text_attributes_copy(byval src as GtkTextAttributes ptr) as GtkTextAttributes ptr
declare sub gtk_text_attributes_copy_values(byval src as GtkTextAttributes ptr, byval dest as GtkTextAttributes ptr)
declare sub gtk_text_attributes_unref(byval values as GtkTextAttributes ptr)
declare function gtk_text_attributes_ref(byval values as GtkTextAttributes ptr) as GtkTextAttributes ptr
declare function gtk_text_attributes_get_type() as GType
#define __GTK_TEXT_CHILD_H__
type GtkTextChildAnchor as _GtkTextChildAnchor
type GtkTextChildAnchorClass as _GtkTextChildAnchorClass

#define GTK_TYPE_TEXT_CHILD_ANCHOR gtk_text_child_anchor_get_type()
#define GTK_TEXT_CHILD_ANCHOR(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchor)
#define GTK_TEXT_CHILD_ANCHOR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass)
#define GTK_IS_TEXT_CHILD_ANCHOR(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_TEXT_CHILD_ANCHOR)
#define GTK_IS_TEXT_CHILD_ANCHOR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_CHILD_ANCHOR)
#define GTK_TEXT_CHILD_ANCHOR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass)

type _GtkTextChildAnchor
	parent_instance as GObject
	segment as gpointer
end type

type _GtkTextChildAnchorClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_text_child_anchor_get_type() as GType
declare function gtk_text_child_anchor_new() as GtkTextChildAnchor ptr
declare function gtk_text_child_anchor_get_widgets(byval anchor as GtkTextChildAnchor ptr) as GList ptr
declare function gtk_text_child_anchor_get_deleted(byval anchor as GtkTextChildAnchor ptr) as gboolean

type GtkTextSearchFlags as long
enum
	GTK_TEXT_SEARCH_VISIBLE_ONLY = 1 shl 0
	GTK_TEXT_SEARCH_TEXT_ONLY = 1 shl 1
end enum

type GtkTextBuffer as _GtkTextBuffer
#define GTK_TYPE_TEXT_ITER gtk_text_iter_get_type()

type _GtkTextIter
	dummy1 as gpointer
	dummy2 as gpointer
	dummy3 as gint
	dummy4 as gint
	dummy5 as gint
	dummy6 as gint
	dummy7 as gint
	dummy8 as gint
	dummy9 as gpointer
	dummy10 as gpointer
	dummy11 as gint
	dummy12 as gint
	dummy13 as gint
	dummy14 as gpointer
end type

declare function gtk_text_iter_get_buffer(byval iter as const GtkTextIter ptr) as GtkTextBuffer ptr
declare function gtk_text_iter_copy(byval iter as const GtkTextIter ptr) as GtkTextIter ptr
declare sub gtk_text_iter_free(byval iter as GtkTextIter ptr)
declare function gtk_text_iter_get_type() as GType
declare function gtk_text_iter_get_offset(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_line(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_line_offset(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_line_index(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_visible_line_offset(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_visible_line_index(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_char(byval iter as const GtkTextIter ptr) as gunichar
declare function gtk_text_iter_get_slice(byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr) as gchar ptr
declare function gtk_text_iter_get_text(byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr) as gchar ptr
declare function gtk_text_iter_get_visible_slice(byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr) as gchar ptr
declare function gtk_text_iter_get_visible_text(byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr) as gchar ptr
declare function gtk_text_iter_get_pixbuf(byval iter as const GtkTextIter ptr) as GdkPixbuf ptr
declare function gtk_text_iter_get_marks(byval iter as const GtkTextIter ptr) as GSList ptr
declare function gtk_text_iter_get_child_anchor(byval iter as const GtkTextIter ptr) as GtkTextChildAnchor ptr
declare function gtk_text_iter_get_toggled_tags(byval iter as const GtkTextIter ptr, byval toggled_on as gboolean) as GSList ptr
declare function gtk_text_iter_begins_tag(byval iter as const GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_ends_tag(byval iter as const GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_toggles_tag(byval iter as const GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_has_tag(byval iter as const GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_get_tags(byval iter as const GtkTextIter ptr) as GSList ptr
declare function gtk_text_iter_editable(byval iter as const GtkTextIter ptr, byval default_setting as gboolean) as gboolean
declare function gtk_text_iter_can_insert(byval iter as const GtkTextIter ptr, byval default_editability as gboolean) as gboolean
declare function gtk_text_iter_starts_word(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_ends_word(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_inside_word(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_starts_sentence(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_ends_sentence(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_inside_sentence(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_starts_line(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_ends_line(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_is_cursor_position(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_get_chars_in_line(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_bytes_in_line(byval iter as const GtkTextIter ptr) as gint
declare function gtk_text_iter_get_attributes(byval iter as const GtkTextIter ptr, byval values as GtkTextAttributes ptr) as gboolean
declare function gtk_text_iter_get_language(byval iter as const GtkTextIter ptr) as PangoLanguage ptr
declare function gtk_text_iter_is_end(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_is_start(byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_char(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_char(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_chars(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_chars(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_line(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_line(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_lines(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_lines(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_word_end(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_word_start(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_word_ends(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_word_starts(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_visible_line(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_visible_line(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_visible_lines(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_visible_lines(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_visible_word_end(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_visible_word_start(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_visible_word_ends(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_visible_word_starts(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_sentence_end(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_sentence_start(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_sentence_ends(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_sentence_starts(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_cursor_position(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_cursor_position(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_cursor_positions(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_cursor_positions(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_forward_visible_cursor_position(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_visible_cursor_position(byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_visible_cursor_positions(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_iter_backward_visible_cursor_positions(byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare sub gtk_text_iter_set_offset(byval iter as GtkTextIter ptr, byval char_offset as gint)
declare sub gtk_text_iter_set_line(byval iter as GtkTextIter ptr, byval line_number as gint)
declare sub gtk_text_iter_set_line_offset(byval iter as GtkTextIter ptr, byval char_on_line as gint)
declare sub gtk_text_iter_set_line_index(byval iter as GtkTextIter ptr, byval byte_on_line as gint)
declare sub gtk_text_iter_forward_to_end(byval iter as GtkTextIter ptr)
declare function gtk_text_iter_forward_to_line_end(byval iter as GtkTextIter ptr) as gboolean
declare sub gtk_text_iter_set_visible_line_offset(byval iter as GtkTextIter ptr, byval char_on_line as gint)
declare sub gtk_text_iter_set_visible_line_index(byval iter as GtkTextIter ptr, byval byte_on_line as gint)
declare function gtk_text_iter_forward_to_tag_toggle(byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
declare function gtk_text_iter_backward_to_tag_toggle(byval iter as GtkTextIter ptr, byval tag as GtkTextTag ptr) as gboolean
type GtkTextCharPredicate as function(byval ch as gunichar, byval user_data as gpointer) as gboolean
declare function gtk_text_iter_forward_find_char(byval iter as GtkTextIter ptr, byval pred as GtkTextCharPredicate, byval user_data as gpointer, byval limit as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_find_char(byval iter as GtkTextIter ptr, byval pred as GtkTextCharPredicate, byval user_data as gpointer, byval limit as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_forward_search(byval iter as const GtkTextIter ptr, byval str as const gchar ptr, byval flags as GtkTextSearchFlags, byval match_start as GtkTextIter ptr, byval match_end as GtkTextIter ptr, byval limit as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_backward_search(byval iter as const GtkTextIter ptr, byval str as const gchar ptr, byval flags as GtkTextSearchFlags, byval match_start as GtkTextIter ptr, byval match_end as GtkTextIter ptr, byval limit as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_equal(byval lhs as const GtkTextIter ptr, byval rhs as const GtkTextIter ptr) as gboolean
declare function gtk_text_iter_compare(byval lhs as const GtkTextIter ptr, byval rhs as const GtkTextIter ptr) as gint
declare function gtk_text_iter_in_range(byval iter as const GtkTextIter ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr) as gboolean
declare sub gtk_text_iter_order(byval first as GtkTextIter ptr, byval second as GtkTextIter ptr)
type GtkTargetList as _GtkTargetList
type GtkTargetEntry as _GtkTargetEntry
#define GTK_TYPE_SELECTION_DATA gtk_selection_data_get_type()
#define GTK_TYPE_TARGET_LIST gtk_target_list_get_type()

type _GtkSelectionData
	selection as GdkAtom
	target as GdkAtom
	as GdkAtom type
	format as gint
	data as guchar ptr
	length as gint
	display as GdkDisplay ptr
end type

type _GtkTargetEntry
	target as gchar ptr
	flags as guint
	info as guint
end type

type GtkTargetPair as _GtkTargetPair

type _GtkTargetList
	list as GList ptr
	ref_count as guint
end type

type _GtkTargetPair
	target as GdkAtom
	flags as guint
	info as guint
end type

declare function gtk_target_list_new(byval targets as const GtkTargetEntry ptr, byval ntargets as guint) as GtkTargetList ptr
declare function gtk_target_list_ref(byval list as GtkTargetList ptr) as GtkTargetList ptr
declare sub gtk_target_list_unref(byval list as GtkTargetList ptr)
declare sub gtk_target_list_add(byval list as GtkTargetList ptr, byval target as GdkAtom, byval flags as guint, byval info as guint)
declare sub gtk_target_list_add_text_targets(byval list as GtkTargetList ptr, byval info as guint)
declare sub gtk_target_list_add_rich_text_targets(byval list as GtkTargetList ptr, byval info as guint, byval deserializable as gboolean, byval buffer as GtkTextBuffer ptr)
declare sub gtk_target_list_add_image_targets(byval list as GtkTargetList ptr, byval info as guint, byval writable as gboolean)
declare sub gtk_target_list_add_uri_targets(byval list as GtkTargetList ptr, byval info as guint)
declare sub gtk_target_list_add_table(byval list as GtkTargetList ptr, byval targets as const GtkTargetEntry ptr, byval ntargets as guint)
declare sub gtk_target_list_remove(byval list as GtkTargetList ptr, byval target as GdkAtom)
declare function gtk_target_list_find(byval list as GtkTargetList ptr, byval target as GdkAtom, byval info as guint ptr) as gboolean
declare function gtk_target_table_new_from_list(byval list as GtkTargetList ptr, byval n_targets as gint ptr) as GtkTargetEntry ptr
declare sub gtk_target_table_free(byval targets as GtkTargetEntry ptr, byval n_targets as gint)
declare function gtk_selection_owner_set(byval widget as GtkWidget ptr, byval selection as GdkAtom, byval time_ as guint32) as gboolean
declare function gtk_selection_owner_set_for_display(byval display as GdkDisplay ptr, byval widget as GtkWidget ptr, byval selection as GdkAtom, byval time_ as guint32) as gboolean
declare sub gtk_selection_add_target(byval widget as GtkWidget ptr, byval selection as GdkAtom, byval target as GdkAtom, byval info as guint)
declare sub gtk_selection_add_targets(byval widget as GtkWidget ptr, byval selection as GdkAtom, byval targets as const GtkTargetEntry ptr, byval ntargets as guint)
declare sub gtk_selection_clear_targets(byval widget as GtkWidget ptr, byval selection as GdkAtom)
declare function gtk_selection_convert(byval widget as GtkWidget ptr, byval selection as GdkAtom, byval target as GdkAtom, byval time_ as guint32) as gboolean
declare function gtk_selection_data_get_selection(byval selection_data as GtkSelectionData ptr) as GdkAtom
declare function gtk_selection_data_get_target(byval selection_data as GtkSelectionData ptr) as GdkAtom
declare function gtk_selection_data_get_data_type(byval selection_data as GtkSelectionData ptr) as GdkAtom
declare function gtk_selection_data_get_format(byval selection_data as GtkSelectionData ptr) as gint
declare function gtk_selection_data_get_data(byval selection_data as GtkSelectionData ptr) as const guchar ptr
declare function gtk_selection_data_get_length(byval selection_data as GtkSelectionData ptr) as gint
declare function gtk_selection_data_get_display(byval selection_data as GtkSelectionData ptr) as GdkDisplay ptr
declare sub gtk_selection_data_set(byval selection_data as GtkSelectionData ptr, byval type as GdkAtom, byval format as gint, byval data as const guchar ptr, byval length as gint)
declare function gtk_selection_data_set_text(byval selection_data as GtkSelectionData ptr, byval str as const gchar ptr, byval len as gint) as gboolean
declare function gtk_selection_data_get_text(byval selection_data as GtkSelectionData ptr) as guchar ptr
declare function gtk_selection_data_set_pixbuf(byval selection_data as GtkSelectionData ptr, byval pixbuf as GdkPixbuf ptr) as gboolean
declare function gtk_selection_data_get_pixbuf(byval selection_data as GtkSelectionData ptr) as GdkPixbuf ptr
declare function gtk_selection_data_set_uris(byval selection_data as GtkSelectionData ptr, byval uris as gchar ptr ptr) as gboolean
declare function gtk_selection_data_get_uris(byval selection_data as GtkSelectionData ptr) as gchar ptr ptr
declare function gtk_selection_data_get_targets(byval selection_data as GtkSelectionData ptr, byval targets as GdkAtom ptr ptr, byval n_atoms as gint ptr) as gboolean
declare function gtk_selection_data_targets_include_text(byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_selection_data_targets_include_rich_text(byval selection_data as GtkSelectionData ptr, byval buffer as GtkTextBuffer ptr) as gboolean
declare function gtk_selection_data_targets_include_image(byval selection_data as GtkSelectionData ptr, byval writable as gboolean) as gboolean
declare function gtk_selection_data_targets_include_uri(byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_targets_include_text(byval targets as GdkAtom ptr, byval n_targets as gint) as gboolean
declare function gtk_targets_include_rich_text(byval targets as GdkAtom ptr, byval n_targets as gint, byval buffer as GtkTextBuffer ptr) as gboolean
declare function gtk_targets_include_image(byval targets as GdkAtom ptr, byval n_targets as gint, byval writable as gboolean) as gboolean
declare function gtk_targets_include_uri(byval targets as GdkAtom ptr, byval n_targets as gint) as gboolean
declare sub gtk_selection_remove_all(byval widget as GtkWidget ptr)
declare function gtk_selection_clear(byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
declare function _gtk_selection_request(byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
declare function _gtk_selection_incr_event(byval window as GdkWindow ptr, byval event as GdkEventProperty ptr) as gboolean
declare function _gtk_selection_notify(byval widget as GtkWidget ptr, byval event as GdkEventSelection ptr) as gboolean
declare function _gtk_selection_property_notify(byval widget as GtkWidget ptr, byval event as GdkEventProperty ptr) as gboolean
declare function gtk_selection_data_get_type() as GType
declare function gtk_selection_data_copy(byval data as GtkSelectionData ptr) as GtkSelectionData ptr
declare sub gtk_selection_data_free(byval data as GtkSelectionData ptr)
declare function gtk_target_list_get_type() as GType

#define GTK_TYPE_CLIPBOARD gtk_clipboard_get_type()
#define GTK_CLIPBOARD(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CLIPBOARD, GtkClipboard)
#define GTK_IS_CLIPBOARD(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CLIPBOARD)

type GtkClipboardReceivedFunc as sub(byval clipboard as GtkClipboard ptr, byval selection_data as GtkSelectionData ptr, byval data as gpointer)
type GtkClipboardTextReceivedFunc as sub(byval clipboard as GtkClipboard ptr, byval text as const gchar ptr, byval data as gpointer)
type GtkClipboardRichTextReceivedFunc as sub(byval clipboard as GtkClipboard ptr, byval format as GdkAtom, byval text as const guint8 ptr, byval length as gsize, byval data as gpointer)
type GtkClipboardImageReceivedFunc as sub(byval clipboard as GtkClipboard ptr, byval pixbuf as GdkPixbuf ptr, byval data as gpointer)
type GtkClipboardURIReceivedFunc as sub(byval clipboard as GtkClipboard ptr, byval uris as gchar ptr ptr, byval data as gpointer)
type GtkClipboardTargetsReceivedFunc as sub(byval clipboard as GtkClipboard ptr, byval atoms as GdkAtom ptr, byval n_atoms as gint, byval data as gpointer)
type GtkClipboardGetFunc as sub(byval clipboard as GtkClipboard ptr, byval selection_data as GtkSelectionData ptr, byval info as guint, byval user_data_or_owner as gpointer)
type GtkClipboardClearFunc as sub(byval clipboard as GtkClipboard ptr, byval user_data_or_owner as gpointer)

declare function gtk_clipboard_get_type() as GType
declare function gtk_clipboard_get_for_display(byval display as GdkDisplay ptr, byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_clipboard_get(byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_clipboard_get_display(byval clipboard as GtkClipboard ptr) as GdkDisplay ptr
declare function gtk_clipboard_set_with_data(byval clipboard as GtkClipboard ptr, byval targets as const GtkTargetEntry ptr, byval n_targets as guint, byval get_func as GtkClipboardGetFunc, byval clear_func as GtkClipboardClearFunc, byval user_data as gpointer) as gboolean
declare function gtk_clipboard_set_with_owner(byval clipboard as GtkClipboard ptr, byval targets as const GtkTargetEntry ptr, byval n_targets as guint, byval get_func as GtkClipboardGetFunc, byval clear_func as GtkClipboardClearFunc, byval owner as GObject ptr) as gboolean
declare function gtk_clipboard_get_owner(byval clipboard as GtkClipboard ptr) as GObject ptr
declare sub gtk_clipboard_clear(byval clipboard as GtkClipboard ptr)
declare sub gtk_clipboard_set_text(byval clipboard as GtkClipboard ptr, byval text as const gchar ptr, byval len as gint)
declare sub gtk_clipboard_set_image(byval clipboard as GtkClipboard ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_clipboard_request_contents(byval clipboard as GtkClipboard ptr, byval target as GdkAtom, byval callback as GtkClipboardReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_text(byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardTextReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_rich_text(byval clipboard as GtkClipboard ptr, byval buffer as GtkTextBuffer ptr, byval callback as GtkClipboardRichTextReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_image(byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardImageReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_uris(byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardURIReceivedFunc, byval user_data as gpointer)
declare sub gtk_clipboard_request_targets(byval clipboard as GtkClipboard ptr, byval callback as GtkClipboardTargetsReceivedFunc, byval user_data as gpointer)
declare function gtk_clipboard_wait_for_contents(byval clipboard as GtkClipboard ptr, byval target as GdkAtom) as GtkSelectionData ptr
declare function gtk_clipboard_wait_for_text(byval clipboard as GtkClipboard ptr) as gchar ptr
declare function gtk_clipboard_wait_for_rich_text(byval clipboard as GtkClipboard ptr, byval buffer as GtkTextBuffer ptr, byval format as GdkAtom ptr, byval length as gsize ptr) as guint8 ptr
declare function gtk_clipboard_wait_for_image(byval clipboard as GtkClipboard ptr) as GdkPixbuf ptr
declare function gtk_clipboard_wait_for_uris(byval clipboard as GtkClipboard ptr) as gchar ptr ptr
declare function gtk_clipboard_wait_for_targets(byval clipboard as GtkClipboard ptr, byval targets as GdkAtom ptr ptr, byval n_targets as gint ptr) as gboolean
declare function gtk_clipboard_wait_is_text_available(byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_rich_text_available(byval clipboard as GtkClipboard ptr, byval buffer as GtkTextBuffer ptr) as gboolean
declare function gtk_clipboard_wait_is_image_available(byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_uris_available(byval clipboard as GtkClipboard ptr) as gboolean
declare function gtk_clipboard_wait_is_target_available(byval clipboard as GtkClipboard ptr, byval target as GdkAtom) as gboolean
declare sub gtk_clipboard_set_can_store(byval clipboard as GtkClipboard ptr, byval targets as const GtkTargetEntry ptr, byval n_targets as gint)
declare sub gtk_clipboard_store(byval clipboard as GtkClipboard ptr)
declare sub _gtk_clipboard_handle_event(byval event as GdkEventOwnerChange ptr)
declare sub _gtk_clipboard_store_all()

#define __GTK_COLOR_BUTTON_H__
#define GTK_TYPE_COLOR_BUTTON gtk_color_button_get_type()
#define GTK_COLOR_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_BUTTON, GtkColorButton)
#define GTK_COLOR_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_BUTTON, GtkColorButtonClass)
#define GTK_IS_COLOR_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_BUTTON)
#define GTK_IS_COLOR_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_BUTTON)
#define GTK_COLOR_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_BUTTON, GtkColorButtonClass)

type GtkColorButton as _GtkColorButton
type GtkColorButtonClass as _GtkColorButtonClass
type GtkColorButtonPrivate as _GtkColorButtonPrivate

type _GtkColorButton
	button as GtkButton
	priv as GtkColorButtonPrivate ptr
end type

type _GtkColorButtonClass
	parent_class as GtkButtonClass
	color_set as sub(byval cp as GtkColorButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_color_button_get_type() as GType
declare function gtk_color_button_new() as GtkWidget ptr
declare function gtk_color_button_new_with_color(byval color as const GdkColor ptr) as GtkWidget ptr
declare sub gtk_color_button_set_color(byval color_button as GtkColorButton ptr, byval color as const GdkColor ptr)
declare sub gtk_color_button_set_alpha(byval color_button as GtkColorButton ptr, byval alpha as guint16)
declare sub gtk_color_button_get_color(byval color_button as GtkColorButton ptr, byval color as GdkColor ptr)
declare function gtk_color_button_get_alpha(byval color_button as GtkColorButton ptr) as guint16
declare sub gtk_color_button_set_use_alpha(byval color_button as GtkColorButton ptr, byval use_alpha as gboolean)
declare function gtk_color_button_get_use_alpha(byval color_button as GtkColorButton ptr) as gboolean
declare sub gtk_color_button_set_title(byval color_button as GtkColorButton ptr, byval title as const gchar ptr)
declare function gtk_color_button_get_title(byval color_button as GtkColorButton ptr) as const gchar ptr

#define __GTK_COLOR_SELECTION_H__
#define __GTK_VBOX_H__
#define GTK_TYPE_VBOX gtk_vbox_get_type()
#define GTK_VBOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VBOX, GtkVBox)
#define GTK_VBOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VBOX, GtkVBoxClass)
#define GTK_IS_VBOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VBOX)
#define GTK_IS_VBOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VBOX)
#define GTK_VBOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VBOX, GtkVBoxClass)
type GtkVBox as _GtkVBox
type GtkVBoxClass as _GtkVBoxClass

type _GtkVBox
	box as GtkBox
end type

type _GtkVBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_vbox_get_type() as GType
declare function gtk_vbox_new(byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr
#define GTK_TYPE_COLOR_SELECTION gtk_color_selection_get_type()
#define GTK_COLOR_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelection)
#define GTK_COLOR_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass)
#define GTK_IS_COLOR_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_SELECTION)
#define GTK_IS_COLOR_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_SELECTION)
#define GTK_COLOR_SELECTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass)

type GtkColorSelection as _GtkColorSelection
type GtkColorSelectionClass as _GtkColorSelectionClass
type GtkColorSelectionChangePaletteFunc as sub(byval colors as const GdkColor ptr, byval n_colors as gint)
type GtkColorSelectionChangePaletteWithScreenFunc as sub(byval screen as GdkScreen ptr, byval colors as const GdkColor ptr, byval n_colors as gint)

type _GtkColorSelection
	parent_instance as GtkVBox
	private_data as gpointer
end type

type _GtkColorSelectionClass
	parent_class as GtkVBoxClass
	color_changed as sub(byval color_selection as GtkColorSelection ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_color_selection_get_type() as GType
declare function gtk_color_selection_new() as GtkWidget ptr
declare function gtk_color_selection_get_has_opacity_control(byval colorsel as GtkColorSelection ptr) as gboolean
declare sub gtk_color_selection_set_has_opacity_control(byval colorsel as GtkColorSelection ptr, byval has_opacity as gboolean)
declare function gtk_color_selection_get_has_palette(byval colorsel as GtkColorSelection ptr) as gboolean
declare sub gtk_color_selection_set_has_palette(byval colorsel as GtkColorSelection ptr, byval has_palette as gboolean)
declare sub gtk_color_selection_set_current_color(byval colorsel as GtkColorSelection ptr, byval color as const GdkColor ptr)
declare sub gtk_color_selection_set_current_alpha(byval colorsel as GtkColorSelection ptr, byval alpha as guint16)
declare sub gtk_color_selection_get_current_color(byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare function gtk_color_selection_get_current_alpha(byval colorsel as GtkColorSelection ptr) as guint16
declare sub gtk_color_selection_set_previous_color(byval colorsel as GtkColorSelection ptr, byval color as const GdkColor ptr)
declare sub gtk_color_selection_set_previous_alpha(byval colorsel as GtkColorSelection ptr, byval alpha as guint16)
declare sub gtk_color_selection_get_previous_color(byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare function gtk_color_selection_get_previous_alpha(byval colorsel as GtkColorSelection ptr) as guint16
declare function gtk_color_selection_is_adjusting(byval colorsel as GtkColorSelection ptr) as gboolean
declare function gtk_color_selection_palette_from_string(byval str as const gchar ptr, byval colors as GdkColor ptr ptr, byval n_colors as gint ptr) as gboolean
declare function gtk_color_selection_palette_to_string(byval colors as const GdkColor ptr, byval n_colors as gint) as gchar ptr
declare function gtk_color_selection_set_change_palette_hook(byval func as GtkColorSelectionChangePaletteFunc) as GtkColorSelectionChangePaletteFunc
declare function gtk_color_selection_set_change_palette_with_screen_hook(byval func as GtkColorSelectionChangePaletteWithScreenFunc) as GtkColorSelectionChangePaletteWithScreenFunc
declare sub gtk_color_selection_set_color(byval colorsel as GtkColorSelection ptr, byval color as gdouble ptr)
declare sub gtk_color_selection_get_color(byval colorsel as GtkColorSelection ptr, byval color as gdouble ptr)
declare sub gtk_color_selection_set_update_policy(byval colorsel as GtkColorSelection ptr, byval policy as GtkUpdateType)

#define __GTK_COLOR_SELECTION_DIALOG_H__
#define GTK_TYPE_COLOR_SELECTION_DIALOG gtk_color_selection_dialog_get_type()
#define GTK_COLOR_SELECTION_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialog)
#define GTK_COLOR_SELECTION_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass)
#define GTK_IS_COLOR_SELECTION_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_SELECTION_DIALOG)
#define GTK_IS_COLOR_SELECTION_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_SELECTION_DIALOG)
#define GTK_COLOR_SELECTION_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass)
type GtkColorSelectionDialog as _GtkColorSelectionDialog
type GtkColorSelectionDialogClass as _GtkColorSelectionDialogClass

type _GtkColorSelectionDialog
	parent_instance as GtkDialog
	colorsel as GtkWidget ptr
	ok_button as GtkWidget ptr
	cancel_button as GtkWidget ptr
	help_button as GtkWidget ptr
end type

type _GtkColorSelectionDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_color_selection_dialog_get_type() as GType
declare function gtk_color_selection_dialog_new(byval title as const gchar ptr) as GtkWidget ptr
declare function gtk_color_selection_dialog_get_color_selection(byval colorsel as GtkColorSelectionDialog ptr) as GtkWidget ptr

#define __GTK_COMBO_BOX_H__
#define __GTK_TREE_VIEW_H__
#define __GTK_DND_H__

type GtkDestDefaults as long
enum
	GTK_DEST_DEFAULT_MOTION = 1 shl 0
	GTK_DEST_DEFAULT_HIGHLIGHT = 1 shl 1
	GTK_DEST_DEFAULT_DROP = 1 shl 2
	GTK_DEST_DEFAULT_ALL = &h07
end enum

type GtkTargetFlags as long
enum
	GTK_TARGET_SAME_APP = 1 shl 0
	GTK_TARGET_SAME_WIDGET = 1 shl 1
	GTK_TARGET_OTHER_APP = 1 shl 2
	GTK_TARGET_OTHER_WIDGET = 1 shl 3
end enum

declare sub gtk_drag_get_data(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval target as GdkAtom, byval time_ as guint32)
declare sub gtk_drag_finish(byval context as GdkDragContext ptr, byval success as gboolean, byval del as gboolean, byval time_ as guint32)
declare function gtk_drag_get_source_widget(byval context as GdkDragContext ptr) as GtkWidget ptr
declare sub gtk_drag_highlight(byval widget as GtkWidget ptr)
declare sub gtk_drag_unhighlight(byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_set(byval widget as GtkWidget ptr, byval flags as GtkDestDefaults, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_drag_dest_set_proxy(byval widget as GtkWidget ptr, byval proxy_window as GdkWindow ptr, byval protocol as GdkDragProtocol, byval use_coordinates as gboolean)
declare sub gtk_drag_dest_unset(byval widget as GtkWidget ptr)
declare function gtk_drag_dest_find_target(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval target_list as GtkTargetList ptr) as GdkAtom
declare function gtk_drag_dest_get_target_list(byval widget as GtkWidget ptr) as GtkTargetList ptr
declare sub gtk_drag_dest_set_target_list(byval widget as GtkWidget ptr, byval target_list as GtkTargetList ptr)
declare sub gtk_drag_dest_add_text_targets(byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_add_image_targets(byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_add_uri_targets(byval widget as GtkWidget ptr)
declare sub gtk_drag_dest_set_track_motion(byval widget as GtkWidget ptr, byval track_motion as gboolean)
declare function gtk_drag_dest_get_track_motion(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_drag_source_set(byval widget as GtkWidget ptr, byval start_button_mask as GdkModifierType, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_drag_source_unset(byval widget as GtkWidget ptr)
declare function gtk_drag_source_get_target_list(byval widget as GtkWidget ptr) as GtkTargetList ptr
declare sub gtk_drag_source_set_target_list(byval widget as GtkWidget ptr, byval target_list as GtkTargetList ptr)
declare sub gtk_drag_source_add_text_targets(byval widget as GtkWidget ptr)
declare sub gtk_drag_source_add_image_targets(byval widget as GtkWidget ptr)
declare sub gtk_drag_source_add_uri_targets(byval widget as GtkWidget ptr)
declare sub gtk_drag_source_set_icon(byval widget as GtkWidget ptr, byval colormap as GdkColormap ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_drag_source_set_icon_pixbuf(byval widget as GtkWidget ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_drag_source_set_icon_stock(byval widget as GtkWidget ptr, byval stock_id as const gchar ptr)
declare sub gtk_drag_source_set_icon_name(byval widget as GtkWidget ptr, byval icon_name as const gchar ptr)
declare function gtk_drag_begin(byval widget as GtkWidget ptr, byval targets as GtkTargetList ptr, byval actions as GdkDragAction, byval button as gint, byval event as GdkEvent ptr) as GdkDragContext ptr
declare sub gtk_drag_set_icon_widget(byval context as GdkDragContext ptr, byval widget as GtkWidget ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_pixmap(byval context as GdkDragContext ptr, byval colormap as GdkColormap ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_pixbuf(byval context as GdkDragContext ptr, byval pixbuf as GdkPixbuf ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_stock(byval context as GdkDragContext ptr, byval stock_id as const gchar ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_name(byval context as GdkDragContext ptr, byval icon_name as const gchar ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_default(byval context as GdkDragContext ptr)
declare function gtk_drag_check_threshold(byval widget as GtkWidget ptr, byval start_x as gint, byval start_y as gint, byval current_x as gint, byval current_y as gint) as gboolean
declare sub _gtk_drag_source_handle_event(byval widget as GtkWidget ptr, byval event as GdkEvent ptr)
declare sub _gtk_drag_dest_handle_event(byval toplevel as GtkWidget ptr, byval event as GdkEvent ptr)
declare sub gtk_drag_set_default_icon(byval colormap as GdkColormap ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr, byval hot_x as gint, byval hot_y as gint)

#define __GTK_ENTRY_H__
#define __GTK_EDITABLE_H__
#define GTK_TYPE_EDITABLE gtk_editable_get_type()
#define GTK_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_EDITABLE, GtkEditable)
#define GTK_EDITABLE_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_EDITABLE, GtkEditableClass)
#define GTK_IS_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_EDITABLE)
#define GTK_IS_EDITABLE_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_EDITABLE)
#define GTK_EDITABLE_GET_CLASS(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_EDITABLE, GtkEditableClass)
type GtkEditable as _GtkEditable
type GtkEditableClass as _GtkEditableClass

type _GtkEditableClass
	base_iface as GTypeInterface
	insert_text as sub(byval editable as GtkEditable ptr, byval text as const gchar ptr, byval length as gint, byval position as gint ptr)
	delete_text as sub(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
	changed as sub(byval editable as GtkEditable ptr)
	do_insert_text as sub(byval editable as GtkEditable ptr, byval text as const gchar ptr, byval length as gint, byval position as gint ptr)
	do_delete_text as sub(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
	get_chars as function(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint) as gchar ptr
	set_selection_bounds as sub(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
	get_selection_bounds as function(byval editable as GtkEditable ptr, byval start_pos as gint ptr, byval end_pos as gint ptr) as gboolean
	set_position as sub(byval editable as GtkEditable ptr, byval position as gint)
	get_position as function(byval editable as GtkEditable ptr) as gint
end type

declare function gtk_editable_get_type() as GType
declare sub gtk_editable_select_region(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
declare function gtk_editable_get_selection_bounds(byval editable as GtkEditable ptr, byval start_pos as gint ptr, byval end_pos as gint ptr) as gboolean
declare sub gtk_editable_insert_text(byval editable as GtkEditable ptr, byval new_text as const gchar ptr, byval new_text_length as gint, byval position as gint ptr)
declare sub gtk_editable_delete_text(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
declare function gtk_editable_get_chars(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint) as gchar ptr
declare sub gtk_editable_cut_clipboard(byval editable as GtkEditable ptr)
declare sub gtk_editable_copy_clipboard(byval editable as GtkEditable ptr)
declare sub gtk_editable_paste_clipboard(byval editable as GtkEditable ptr)
declare sub gtk_editable_delete_selection(byval editable as GtkEditable ptr)
declare sub gtk_editable_set_position(byval editable as GtkEditable ptr, byval position as gint)
declare function gtk_editable_get_position(byval editable as GtkEditable ptr) as gint
declare sub gtk_editable_set_editable(byval editable as GtkEditable ptr, byval is_editable as gboolean)
declare function gtk_editable_get_editable(byval editable as GtkEditable ptr) as gboolean

#define __GTK_IM_CONTEXT_H__
#define GTK_TYPE_IM_CONTEXT gtk_im_context_get_type()
#define GTK_IM_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IM_CONTEXT, GtkIMContext)
#define GTK_IM_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IM_CONTEXT, GtkIMContextClass)
#define GTK_IS_IM_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IM_CONTEXT)
#define GTK_IS_IM_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IM_CONTEXT)
#define GTK_IM_CONTEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IM_CONTEXT, GtkIMContextClass)
type GtkIMContext as _GtkIMContext
type GtkIMContextClass as _GtkIMContextClass

type _GtkIMContext
	parent_instance as GObject
end type

type _GtkIMContextClass
	parent_class as GtkObjectClass
	preedit_start as sub(byval context as GtkIMContext ptr)
	preedit_end as sub(byval context as GtkIMContext ptr)
	preedit_changed as sub(byval context as GtkIMContext ptr)
	commit as sub(byval context as GtkIMContext ptr, byval str as const gchar ptr)
	retrieve_surrounding as function(byval context as GtkIMContext ptr) as gboolean
	delete_surrounding as function(byval context as GtkIMContext ptr, byval offset as gint, byval n_chars as gint) as gboolean
	set_client_window as sub(byval context as GtkIMContext ptr, byval window as GdkWindow ptr)
	get_preedit_string as sub(byval context as GtkIMContext ptr, byval str as gchar ptr ptr, byval attrs as PangoAttrList ptr ptr, byval cursor_pos as gint ptr)
	filter_keypress as function(byval context as GtkIMContext ptr, byval event as GdkEventKey ptr) as gboolean
	focus_in as sub(byval context as GtkIMContext ptr)
	focus_out as sub(byval context as GtkIMContext ptr)
	reset as sub(byval context as GtkIMContext ptr)
	set_cursor_location as sub(byval context as GtkIMContext ptr, byval area as GdkRectangle ptr)
	set_use_preedit as sub(byval context as GtkIMContext ptr, byval use_preedit as gboolean)
	set_surrounding as sub(byval context as GtkIMContext ptr, byval text as const gchar ptr, byval len as gint, byval cursor_index as gint)
	get_surrounding as function(byval context as GtkIMContext ptr, byval text as gchar ptr ptr, byval cursor_index as gint ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
end type

declare function gtk_im_context_get_type() as GType
declare sub gtk_im_context_set_client_window(byval context as GtkIMContext ptr, byval window as GdkWindow ptr)
declare sub gtk_im_context_get_preedit_string(byval context as GtkIMContext ptr, byval str as gchar ptr ptr, byval attrs as PangoAttrList ptr ptr, byval cursor_pos as gint ptr)
declare function gtk_im_context_filter_keypress(byval context as GtkIMContext ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_im_context_focus_in(byval context as GtkIMContext ptr)
declare sub gtk_im_context_focus_out(byval context as GtkIMContext ptr)
declare sub gtk_im_context_reset(byval context as GtkIMContext ptr)
declare sub gtk_im_context_set_cursor_location(byval context as GtkIMContext ptr, byval area as const GdkRectangle ptr)
declare sub gtk_im_context_set_use_preedit(byval context as GtkIMContext ptr, byval use_preedit as gboolean)
declare sub gtk_im_context_set_surrounding(byval context as GtkIMContext ptr, byval text as const gchar ptr, byval len as gint, byval cursor_index as gint)
declare function gtk_im_context_get_surrounding(byval context as GtkIMContext ptr, byval text as gchar ptr ptr, byval cursor_index as gint ptr) as gboolean
declare function gtk_im_context_delete_surrounding(byval context as GtkIMContext ptr, byval offset as gint, byval n_chars as gint) as gboolean

#define __GTK_ENTRY_BUFFER_H__
#define GTK_ENTRY_BUFFER_MAX_SIZE G_MAXUSHORT
#define GTK_TYPE_ENTRY_BUFFER gtk_entry_buffer_get_type()
#define GTK_ENTRY_BUFFER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ENTRY_BUFFER, GtkEntryBuffer)
#define GTK_ENTRY_BUFFER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ENTRY_BUFFER, GtkEntryBufferClass)
#define GTK_IS_ENTRY_BUFFER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ENTRY_BUFFER)
#define GTK_IS_ENTRY_BUFFER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ENTRY_BUFFER)
#define GTK_ENTRY_BUFFER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ENTRY_BUFFER, GtkEntryBufferClass)

type GtkEntryBuffer as _GtkEntryBuffer
type GtkEntryBufferClass as _GtkEntryBufferClass
type GtkEntryBufferPrivate as _GtkEntryBufferPrivate

type _GtkEntryBuffer
	parent_instance as GObject
	priv as GtkEntryBufferPrivate ptr
end type

type _GtkEntryBufferClass
	parent_class as GObjectClass
	inserted_text as sub(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval chars as const gchar ptr, byval n_chars as guint)
	deleted_text as sub(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval n_chars as guint)
	get_text as function(byval buffer as GtkEntryBuffer ptr, byval n_bytes as gsize ptr) as const gchar ptr
	get_length as function(byval buffer as GtkEntryBuffer ptr) as guint
	insert_text as function(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval chars as const gchar ptr, byval n_chars as guint) as guint
	delete_text as function(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval n_chars as guint) as guint
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
end type

declare function gtk_entry_buffer_get_type() as GType
declare function gtk_entry_buffer_new(byval initial_chars as const gchar ptr, byval n_initial_chars as gint) as GtkEntryBuffer ptr
declare function gtk_entry_buffer_get_bytes(byval buffer as GtkEntryBuffer ptr) as gsize
declare function gtk_entry_buffer_get_length(byval buffer as GtkEntryBuffer ptr) as guint
declare function gtk_entry_buffer_get_text(byval buffer as GtkEntryBuffer ptr) as const gchar ptr
declare sub gtk_entry_buffer_set_text(byval buffer as GtkEntryBuffer ptr, byval chars as const gchar ptr, byval n_chars as gint)
declare sub gtk_entry_buffer_set_max_length(byval buffer as GtkEntryBuffer ptr, byval max_length as gint)
declare function gtk_entry_buffer_get_max_length(byval buffer as GtkEntryBuffer ptr) as gint
declare function gtk_entry_buffer_insert_text(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval chars as const gchar ptr, byval n_chars as gint) as guint
declare function gtk_entry_buffer_delete_text(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval n_chars as gint) as guint
declare sub gtk_entry_buffer_emit_inserted_text(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval chars as const gchar ptr, byval n_chars as guint)
declare sub gtk_entry_buffer_emit_deleted_text(byval buffer as GtkEntryBuffer ptr, byval position as guint, byval n_chars as guint)

#define __GTK_ENTRY_COMPLETION_H__
#define __GTK_LIST_STORE_H__
#define GTK_TYPE_LIST_STORE gtk_list_store_get_type()
#define GTK_LIST_STORE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LIST_STORE, GtkListStore)
#define GTK_LIST_STORE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LIST_STORE, GtkListStoreClass)
#define GTK_IS_LIST_STORE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LIST_STORE)
#define GTK_IS_LIST_STORE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LIST_STORE)
#define GTK_LIST_STORE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LIST_STORE, GtkListStoreClass)
type GtkListStore as _GtkListStore
type GtkListStoreClass as _GtkListStoreClass

type _GtkListStore
	parent as GObject
	stamp as gint
	seq as gpointer
	_gtk_reserved1 as gpointer
	sort_list as GList ptr
	n_columns as gint
	sort_column_id as gint
	order as GtkSortType
	column_headers as GType ptr
	length as gint
	default_sort_func as GtkTreeIterCompareFunc
	default_sort_data as gpointer
	default_sort_destroy as GDestroyNotify
	columns_dirty : 1 as guint
end type

type _GtkListStoreClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_list_store_get_type() as GType
declare function gtk_list_store_new(byval n_columns as gint, ...) as GtkListStore ptr
declare function gtk_list_store_newv(byval n_columns as gint, byval types as GType ptr) as GtkListStore ptr
declare sub gtk_list_store_set_column_types(byval list_store as GtkListStore ptr, byval n_columns as gint, byval types as GType ptr)
declare sub gtk_list_store_set_value(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
declare sub gtk_list_store_set(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, ...)
declare sub gtk_list_store_set_valuesv(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval columns as gint ptr, byval values as GValue ptr, byval n_values as gint)
declare sub gtk_list_store_set_valist(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval var_args as va_list)
declare function gtk_list_store_remove(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_list_store_insert(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as gint)
declare sub gtk_list_store_insert_before(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_list_store_insert_after(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_list_store_insert_with_values(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as gint, ...)
declare sub gtk_list_store_insert_with_valuesv(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as gint, byval columns as gint ptr, byval values as GValue ptr, byval n_values as gint)
declare sub gtk_list_store_prepend(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_list_store_append(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_list_store_clear(byval list_store as GtkListStore ptr)
declare function gtk_list_store_iter_is_valid(byval list_store as GtkListStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_list_store_reorder(byval store as GtkListStore ptr, byval new_order as gint ptr)
declare sub gtk_list_store_swap(byval store as GtkListStore ptr, byval a as GtkTreeIter ptr, byval b as GtkTreeIter ptr)
declare sub gtk_list_store_move_after(byval store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)
declare sub gtk_list_store_move_before(byval store as GtkListStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)

#define __GTK_TREE_MODEL_FILTER_H__
#define GTK_TYPE_TREE_MODEL_FILTER gtk_tree_model_filter_get_type()
#define GTK_TREE_MODEL_FILTER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilter)
#define GTK_TREE_MODEL_FILTER_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilterClass)
#define GTK_IS_TREE_MODEL_FILTER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_MODEL_FILTER)
#define GTK_IS_TREE_MODEL_FILTER_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_TREE_MODEL_FILTER)
#define GTK_TREE_MODEL_FILTER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilterClass)

type GtkTreeModelFilterVisibleFunc as function(byval model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval data as gpointer) as gboolean
type GtkTreeModelFilterModifyFunc as sub(byval model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval value as GValue ptr, byval column as gint, byval data as gpointer)
type GtkTreeModelFilter as _GtkTreeModelFilter
type GtkTreeModelFilterClass as _GtkTreeModelFilterClass
type GtkTreeModelFilterPrivate as _GtkTreeModelFilterPrivate

type _GtkTreeModelFilter
	parent as GObject
	priv as GtkTreeModelFilterPrivate ptr
end type

type _GtkTreeModelFilterClass
	parent_class as GObjectClass
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_tree_model_filter_get_type() as GType
declare function gtk_tree_model_filter_new(byval child_model as GtkTreeModel ptr, byval root as GtkTreePath ptr) as GtkTreeModel ptr
declare sub gtk_tree_model_filter_set_visible_func(byval filter as GtkTreeModelFilter ptr, byval func as GtkTreeModelFilterVisibleFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_model_filter_set_modify_func(byval filter as GtkTreeModelFilter ptr, byval n_columns as gint, byval types as GType ptr, byval func as GtkTreeModelFilterModifyFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_model_filter_set_visible_column(byval filter as GtkTreeModelFilter ptr, byval column as gint)
declare function gtk_tree_model_filter_get_model(byval filter as GtkTreeModelFilter ptr) as GtkTreeModel ptr
declare function gtk_tree_model_filter_convert_child_iter_to_iter(byval filter as GtkTreeModelFilter ptr, byval filter_iter as GtkTreeIter ptr, byval child_iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_model_filter_convert_iter_to_child_iter(byval filter as GtkTreeModelFilter ptr, byval child_iter as GtkTreeIter ptr, byval filter_iter as GtkTreeIter ptr)
declare function gtk_tree_model_filter_convert_child_path_to_path(byval filter as GtkTreeModelFilter ptr, byval child_path as GtkTreePath ptr) as GtkTreePath ptr
declare function gtk_tree_model_filter_convert_path_to_child_path(byval filter as GtkTreeModelFilter ptr, byval filter_path as GtkTreePath ptr) as GtkTreePath ptr
declare sub gtk_tree_model_filter_refilter(byval filter as GtkTreeModelFilter ptr)
declare sub gtk_tree_model_filter_clear_cache(byval filter as GtkTreeModelFilter ptr)

#define GTK_TYPE_ENTRY_COMPLETION gtk_entry_completion_get_type()
#define GTK_ENTRY_COMPLETION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ENTRY_COMPLETION, GtkEntryCompletion)
#define GTK_ENTRY_COMPLETION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ENTRY_COMPLETION, GtkEntryCompletionClass)
#define GTK_IS_ENTRY_COMPLETION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ENTRY_COMPLETION)
#define GTK_IS_ENTRY_COMPLETION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ENTRY_COMPLETION)
#define GTK_ENTRY_COMPLETION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ENTRY_COMPLETION, GtkEntryCompletionClass)

type GtkEntryCompletion as _GtkEntryCompletion
type GtkEntryCompletionClass as _GtkEntryCompletionClass
type GtkEntryCompletionPrivate as _GtkEntryCompletionPrivate
type GtkEntryCompletionMatchFunc as function(byval completion as GtkEntryCompletion ptr, byval key as const gchar ptr, byval iter as GtkTreeIter ptr, byval user_data as gpointer) as gboolean

type _GtkEntryCompletion
	parent_instance as GObject
	priv as GtkEntryCompletionPrivate ptr
end type

type _GtkEntryCompletionClass
	parent_class as GObjectClass
	match_selected as function(byval completion as GtkEntryCompletion ptr, byval model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
	action_activated as sub(byval completion as GtkEntryCompletion ptr, byval index_ as gint)
	insert_prefix as function(byval completion as GtkEntryCompletion ptr, byval prefix as const gchar ptr) as gboolean
	cursor_on_match as function(byval completion as GtkEntryCompletion ptr, byval model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
end type

declare function gtk_entry_completion_get_type() as GType
declare function gtk_entry_completion_new() as GtkEntryCompletion ptr
declare function gtk_entry_completion_get_entry(byval completion as GtkEntryCompletion ptr) as GtkWidget ptr
declare sub gtk_entry_completion_set_model(byval completion as GtkEntryCompletion ptr, byval model as GtkTreeModel ptr)
declare function gtk_entry_completion_get_model(byval completion as GtkEntryCompletion ptr) as GtkTreeModel ptr
declare sub gtk_entry_completion_set_match_func(byval completion as GtkEntryCompletion ptr, byval func as GtkEntryCompletionMatchFunc, byval func_data as gpointer, byval func_notify as GDestroyNotify)
declare sub gtk_entry_completion_set_minimum_key_length(byval completion as GtkEntryCompletion ptr, byval length as gint)
declare function gtk_entry_completion_get_minimum_key_length(byval completion as GtkEntryCompletion ptr) as gint
declare sub gtk_entry_completion_complete(byval completion as GtkEntryCompletion ptr)
declare sub gtk_entry_completion_insert_prefix(byval completion as GtkEntryCompletion ptr)
declare sub gtk_entry_completion_insert_action_text(byval completion as GtkEntryCompletion ptr, byval index_ as gint, byval text as const gchar ptr)
declare sub gtk_entry_completion_insert_action_markup(byval completion as GtkEntryCompletion ptr, byval index_ as gint, byval markup as const gchar ptr)
declare sub gtk_entry_completion_delete_action(byval completion as GtkEntryCompletion ptr, byval index_ as gint)
declare sub gtk_entry_completion_set_inline_completion(byval completion as GtkEntryCompletion ptr, byval inline_completion as gboolean)
declare function gtk_entry_completion_get_inline_completion(byval completion as GtkEntryCompletion ptr) as gboolean
declare sub gtk_entry_completion_set_inline_selection(byval completion as GtkEntryCompletion ptr, byval inline_selection as gboolean)
declare function gtk_entry_completion_get_inline_selection(byval completion as GtkEntryCompletion ptr) as gboolean
declare sub gtk_entry_completion_set_popup_completion(byval completion as GtkEntryCompletion ptr, byval popup_completion as gboolean)
declare function gtk_entry_completion_get_popup_completion(byval completion as GtkEntryCompletion ptr) as gboolean
declare sub gtk_entry_completion_set_popup_set_width(byval completion as GtkEntryCompletion ptr, byval popup_set_width as gboolean)
declare function gtk_entry_completion_get_popup_set_width(byval completion as GtkEntryCompletion ptr) as gboolean
declare sub gtk_entry_completion_set_popup_single_match(byval completion as GtkEntryCompletion ptr, byval popup_single_match as gboolean)
declare function gtk_entry_completion_get_popup_single_match(byval completion as GtkEntryCompletion ptr) as gboolean
declare function gtk_entry_completion_get_completion_prefix(byval completion as GtkEntryCompletion ptr) as const gchar ptr
declare sub gtk_entry_completion_set_text_column(byval completion as GtkEntryCompletion ptr, byval column as gint)
declare function gtk_entry_completion_get_text_column(byval completion as GtkEntryCompletion ptr) as gint

#define GTK_TYPE_ENTRY gtk_entry_get_type()
#define GTK_ENTRY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ENTRY, GtkEntry)
#define GTK_ENTRY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ENTRY, GtkEntryClass)
#define GTK_IS_ENTRY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ENTRY)
#define GTK_IS_ENTRY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ENTRY)
#define GTK_ENTRY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ENTRY, GtkEntryClass)

type GtkEntryIconPosition as long
enum
	GTK_ENTRY_ICON_PRIMARY
	GTK_ENTRY_ICON_SECONDARY
end enum

type GtkEntry as _GtkEntry
type GtkEntryClass as _GtkEntryClass

type _GtkEntry
	widget as GtkWidget
	text as gchar ptr
	editable : 1 as guint
	visible : 1 as guint
	overwrite_mode : 1 as guint
	in_drag : 1 as guint
	text_length as guint16
	text_max_length as guint16
	text_area as GdkWindow ptr
	im_context as GtkIMContext ptr
	popup_menu as GtkWidget ptr
	current_pos as gint
	selection_bound as gint
	cached_layout as PangoLayout ptr
	cache_includes_preedit : 1 as guint
	need_im_reset : 1 as guint
	has_frame : 1 as guint
	activates_default : 1 as guint
	cursor_visible : 1 as guint
	in_click : 1 as guint
	is_cell_renderer : 1 as guint
	editing_canceled : 1 as guint
	mouse_cursor_obscured : 1 as guint
	select_words : 1 as guint
	select_lines : 1 as guint
	resolved_dir : 4 as guint
	truncate_multiline : 1 as guint
	button as guint
	blink_timeout as guint
	recompute_idle as guint
	scroll_offset as gint
	ascent as gint
	descent as gint
	x_text_size as guint16
	x_n_bytes as guint16
	preedit_length as guint16
	preedit_cursor as guint16
	dnd_position as gint
	drag_start_x as gint
	drag_start_y as gint
	invisible_char as gunichar
	width_chars as gint
end type

type _GtkEntryClass
	parent_class as GtkWidgetClass
	populate_popup as sub(byval entry as GtkEntry ptr, byval menu as GtkMenu ptr)
	activate as sub(byval entry as GtkEntry ptr)
	move_cursor as sub(byval entry as GtkEntry ptr, byval step as GtkMovementStep, byval count as gint, byval extend_selection as gboolean)
	insert_at_cursor as sub(byval entry as GtkEntry ptr, byval str as const gchar ptr)
	delete_from_cursor as sub(byval entry as GtkEntry ptr, byval type as GtkDeleteType, byval count as gint)
	backspace as sub(byval entry as GtkEntry ptr)
	cut_clipboard as sub(byval entry as GtkEntry ptr)
	copy_clipboard as sub(byval entry as GtkEntry ptr)
	paste_clipboard as sub(byval entry as GtkEntry ptr)
	toggle_overwrite as sub(byval entry as GtkEntry ptr)
	get_text_area_size as sub(byval entry as GtkEntry ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_entry_get_type() as GType
declare function gtk_entry_new() as GtkWidget ptr
declare function gtk_entry_new_with_buffer(byval buffer as GtkEntryBuffer ptr) as GtkWidget ptr
declare function gtk_entry_get_buffer(byval entry as GtkEntry ptr) as GtkEntryBuffer ptr
declare sub gtk_entry_set_buffer(byval entry as GtkEntry ptr, byval buffer as GtkEntryBuffer ptr)
declare function gtk_entry_get_text_window(byval entry as GtkEntry ptr) as GdkWindow ptr
declare sub gtk_entry_set_visibility(byval entry as GtkEntry ptr, byval visible as gboolean)
declare function gtk_entry_get_visibility(byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_invisible_char(byval entry as GtkEntry ptr, byval ch as gunichar)
declare function gtk_entry_get_invisible_char(byval entry as GtkEntry ptr) as gunichar
declare sub gtk_entry_unset_invisible_char(byval entry as GtkEntry ptr)
declare sub gtk_entry_set_has_frame(byval entry as GtkEntry ptr, byval setting as gboolean)
declare function gtk_entry_get_has_frame(byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_inner_border(byval entry as GtkEntry ptr, byval border as const GtkBorder ptr)
declare function gtk_entry_get_inner_border(byval entry as GtkEntry ptr) as const GtkBorder ptr
declare sub gtk_entry_set_overwrite_mode(byval entry as GtkEntry ptr, byval overwrite as gboolean)
declare function gtk_entry_get_overwrite_mode(byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_max_length(byval entry as GtkEntry ptr, byval max as gint)
declare function gtk_entry_get_max_length(byval entry as GtkEntry ptr) as gint
declare function gtk_entry_get_text_length(byval entry as GtkEntry ptr) as guint16
declare sub gtk_entry_set_activates_default(byval entry as GtkEntry ptr, byval setting as gboolean)
declare function gtk_entry_get_activates_default(byval entry as GtkEntry ptr) as gboolean
declare sub gtk_entry_set_width_chars(byval entry as GtkEntry ptr, byval n_chars as gint)
declare function gtk_entry_get_width_chars(byval entry as GtkEntry ptr) as gint
declare sub gtk_entry_set_text(byval entry as GtkEntry ptr, byval text as const gchar ptr)
declare function gtk_entry_get_text(byval entry as GtkEntry ptr) as const gchar ptr
declare function gtk_entry_get_layout(byval entry as GtkEntry ptr) as PangoLayout ptr
declare sub gtk_entry_get_layout_offsets(byval entry as GtkEntry ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gtk_entry_set_alignment(byval entry as GtkEntry ptr, byval xalign as gfloat)
declare function gtk_entry_get_alignment(byval entry as GtkEntry ptr) as gfloat
declare sub gtk_entry_set_completion(byval entry as GtkEntry ptr, byval completion as GtkEntryCompletion ptr)
declare function gtk_entry_get_completion(byval entry as GtkEntry ptr) as GtkEntryCompletion ptr
declare function gtk_entry_layout_index_to_text_index(byval entry as GtkEntry ptr, byval layout_index as gint) as gint
declare function gtk_entry_text_index_to_layout_index(byval entry as GtkEntry ptr, byval text_index as gint) as gint
declare sub gtk_entry_set_cursor_hadjustment(byval entry as GtkEntry ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_entry_get_cursor_hadjustment(byval entry as GtkEntry ptr) as GtkAdjustment ptr
declare sub gtk_entry_set_progress_fraction(byval entry as GtkEntry ptr, byval fraction as gdouble)
declare function gtk_entry_get_progress_fraction(byval entry as GtkEntry ptr) as gdouble
declare sub gtk_entry_set_progress_pulse_step(byval entry as GtkEntry ptr, byval fraction as gdouble)
declare function gtk_entry_get_progress_pulse_step(byval entry as GtkEntry ptr) as gdouble
declare sub gtk_entry_progress_pulse(byval entry as GtkEntry ptr)
declare sub gtk_entry_set_icon_from_pixbuf(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_entry_set_icon_from_stock(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval stock_id as const gchar ptr)
declare sub gtk_entry_set_icon_from_icon_name(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval icon_name as const gchar ptr)
declare sub gtk_entry_set_icon_from_gicon(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval icon as GIcon ptr)
declare function gtk_entry_get_icon_storage_type(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as GtkImageType
declare function gtk_entry_get_icon_pixbuf(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as GdkPixbuf ptr
declare function gtk_entry_get_icon_stock(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as const gchar ptr
declare function gtk_entry_get_icon_name(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as const gchar ptr
declare function gtk_entry_get_icon_gicon(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as GIcon ptr
declare sub gtk_entry_set_icon_activatable(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval activatable as gboolean)
declare function gtk_entry_get_icon_activatable(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as gboolean
declare sub gtk_entry_set_icon_sensitive(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval sensitive as gboolean)
declare function gtk_entry_get_icon_sensitive(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as gboolean
declare function gtk_entry_get_icon_at_pos(byval entry as GtkEntry ptr, byval x as gint, byval y as gint) as gint
declare sub gtk_entry_set_icon_tooltip_text(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval tooltip as const gchar ptr)
declare function gtk_entry_get_icon_tooltip_text(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as gchar ptr
declare sub gtk_entry_set_icon_tooltip_markup(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval tooltip as const gchar ptr)
declare function gtk_entry_get_icon_tooltip_markup(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as gchar ptr
declare sub gtk_entry_set_icon_drag_source(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval target_list as GtkTargetList ptr, byval actions as GdkDragAction)
declare function gtk_entry_get_current_icon_drag_source(byval entry as GtkEntry ptr) as gint
declare function gtk_entry_get_icon_window(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition) as GdkWindow ptr
declare function gtk_entry_im_context_filter_keypress(byval entry as GtkEntry ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_entry_reset_im_context(byval entry as GtkEntry ptr)
declare function gtk_entry_new_with_max_length(byval max as gint) as GtkWidget ptr
declare sub gtk_entry_append_text(byval entry as GtkEntry ptr, byval text as const gchar ptr)
declare sub gtk_entry_prepend_text(byval entry as GtkEntry ptr, byval text as const gchar ptr)
declare sub gtk_entry_set_position(byval entry as GtkEntry ptr, byval position as gint)
declare sub gtk_entry_select_region(byval entry as GtkEntry ptr, byval start as gint, byval end as gint)
declare sub gtk_entry_set_editable(byval entry as GtkEntry ptr, byval editable as gboolean)

type GtkTreeViewDropPosition as long
enum
	GTK_TREE_VIEW_DROP_BEFORE
	GTK_TREE_VIEW_DROP_AFTER
	GTK_TREE_VIEW_DROP_INTO_OR_BEFORE
	GTK_TREE_VIEW_DROP_INTO_OR_AFTER
end enum

#define GTK_TYPE_TREE_VIEW gtk_tree_view_get_type()
#define GTK_TREE_VIEW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_VIEW, GtkTreeView)
#define GTK_TREE_VIEW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TREE_VIEW, GtkTreeViewClass)
#define GTK_IS_TREE_VIEW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_VIEW)
#define GTK_IS_TREE_VIEW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TREE_VIEW)
#define GTK_TREE_VIEW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_VIEW, GtkTreeViewClass)

type GtkTreeView as _GtkTreeView
type GtkTreeViewClass as _GtkTreeViewClass
type GtkTreeViewPrivate as _GtkTreeViewPrivate
type GtkTreeSelection as _GtkTreeSelection
type GtkTreeSelectionClass as _GtkTreeSelectionClass

type _GtkTreeView
	parent as GtkContainer
	priv as GtkTreeViewPrivate ptr
end type

type _GtkTreeViewClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub(byval tree_view as GtkTreeView ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
	row_activated as sub(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr)
	test_expand_row as function(byval tree_view as GtkTreeView ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr) as gboolean
	test_collapse_row as function(byval tree_view as GtkTreeView ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr) as gboolean
	row_expanded as sub(byval tree_view as GtkTreeView ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr)
	row_collapsed as sub(byval tree_view as GtkTreeView ptr, byval iter as GtkTreeIter ptr, byval path as GtkTreePath ptr)
	columns_changed as sub(byval tree_view as GtkTreeView ptr)
	cursor_changed as sub(byval tree_view as GtkTreeView ptr)
	move_cursor as function(byval tree_view as GtkTreeView ptr, byval step as GtkMovementStep, byval count as gint) as gboolean
	select_all as function(byval tree_view as GtkTreeView ptr) as gboolean
	unselect_all as function(byval tree_view as GtkTreeView ptr) as gboolean
	select_cursor_row as function(byval tree_view as GtkTreeView ptr, byval start_editing as gboolean) as gboolean
	toggle_cursor_row as function(byval tree_view as GtkTreeView ptr) as gboolean
	expand_collapse_cursor_row as function(byval tree_view as GtkTreeView ptr, byval logical as gboolean, byval expand as gboolean, byval open_all as gboolean) as gboolean
	select_cursor_parent as function(byval tree_view as GtkTreeView ptr) as gboolean
	start_interactive_search as function(byval tree_view as GtkTreeView ptr) as gboolean
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type GtkTreeViewColumnDropFunc as function(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr, byval prev_column as GtkTreeViewColumn ptr, byval next_column as GtkTreeViewColumn ptr, byval data as gpointer) as gboolean
type GtkTreeViewMappingFunc as sub(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval user_data as gpointer)
type GtkTreeViewSearchEqualFunc as function(byval model as GtkTreeModel ptr, byval column as gint, byval key as const gchar ptr, byval iter as GtkTreeIter ptr, byval search_data as gpointer) as gboolean
type GtkTreeViewRowSeparatorFunc as function(byval model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval data as gpointer) as gboolean
type GtkTreeViewSearchPositionFunc as sub(byval tree_view as GtkTreeView ptr, byval search_dialog as GtkWidget ptr, byval user_data as gpointer)

declare function gtk_tree_view_get_type() as GType
declare function gtk_tree_view_new() as GtkWidget ptr
declare function gtk_tree_view_new_with_model(byval model as GtkTreeModel ptr) as GtkWidget ptr
declare function gtk_tree_view_get_model(byval tree_view as GtkTreeView ptr) as GtkTreeModel ptr
declare sub gtk_tree_view_set_model(byval tree_view as GtkTreeView ptr, byval model as GtkTreeModel ptr)
declare function gtk_tree_view_get_selection(byval tree_view as GtkTreeView ptr) as GtkTreeSelection ptr
declare function gtk_tree_view_get_hadjustment(byval tree_view as GtkTreeView ptr) as GtkAdjustment ptr
declare sub gtk_tree_view_set_hadjustment(byval tree_view as GtkTreeView ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_tree_view_get_vadjustment(byval tree_view as GtkTreeView ptr) as GtkAdjustment ptr
declare sub gtk_tree_view_set_vadjustment(byval tree_view as GtkTreeView ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_tree_view_get_headers_visible(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_headers_visible(byval tree_view as GtkTreeView ptr, byval headers_visible as gboolean)
declare sub gtk_tree_view_columns_autosize(byval tree_view as GtkTreeView ptr)
declare function gtk_tree_view_get_headers_clickable(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_headers_clickable(byval tree_view as GtkTreeView ptr, byval setting as gboolean)
declare sub gtk_tree_view_set_rules_hint(byval tree_view as GtkTreeView ptr, byval setting as gboolean)
declare function gtk_tree_view_get_rules_hint(byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_append_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_remove_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_insert_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr, byval position as gint) as gint
declare function gtk_tree_view_insert_column_with_attributes(byval tree_view as GtkTreeView ptr, byval position as gint, byval title as const gchar ptr, byval cell as GtkCellRenderer ptr, ...) as gint
declare function gtk_tree_view_insert_column_with_data_func(byval tree_view as GtkTreeView ptr, byval position as gint, byval title as const gchar ptr, byval cell as GtkCellRenderer ptr, byval func as GtkTreeCellDataFunc, byval data as gpointer, byval dnotify as GDestroyNotify) as gint
declare function gtk_tree_view_get_column(byval tree_view as GtkTreeView ptr, byval n as gint) as GtkTreeViewColumn ptr
declare function gtk_tree_view_get_columns(byval tree_view as GtkTreeView ptr) as GList ptr
declare sub gtk_tree_view_move_column_after(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr, byval base_column as GtkTreeViewColumn ptr)
declare sub gtk_tree_view_set_expander_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr)
declare function gtk_tree_view_get_expander_column(byval tree_view as GtkTreeView ptr) as GtkTreeViewColumn ptr
declare sub gtk_tree_view_set_column_drag_function(byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewColumnDropFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_view_scroll_to_point(byval tree_view as GtkTreeView ptr, byval tree_x as gint, byval tree_y as gint)
declare sub gtk_tree_view_scroll_to_cell(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval use_align as gboolean, byval row_align as gfloat, byval col_align as gfloat)
declare sub gtk_tree_view_row_activated(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr)
declare sub gtk_tree_view_expand_all(byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_collapse_all(byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_expand_to_path(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr)
declare function gtk_tree_view_expand_row(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval open_all as gboolean) as gboolean
declare function gtk_tree_view_collapse_row(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as gboolean
declare sub gtk_tree_view_map_expanded_rows(byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewMappingFunc, byval data as gpointer)
declare function gtk_tree_view_row_expanded(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as gboolean
declare sub gtk_tree_view_set_reorderable(byval tree_view as GtkTreeView ptr, byval reorderable as gboolean)
declare function gtk_tree_view_get_reorderable(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_cursor(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval focus_column as GtkTreeViewColumn ptr, byval start_editing as gboolean)
declare sub gtk_tree_view_set_cursor_on_cell(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval focus_column as GtkTreeViewColumn ptr, byval focus_cell as GtkCellRenderer ptr, byval start_editing as gboolean)
declare sub gtk_tree_view_get_cursor(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr ptr, byval focus_column as GtkTreeViewColumn ptr ptr)
declare function gtk_tree_view_get_bin_window(byval tree_view as GtkTreeView ptr) as GdkWindow ptr
declare function gtk_tree_view_get_path_at_pos(byval tree_view as GtkTreeView ptr, byval x as gint, byval y as gint, byval path as GtkTreePath ptr ptr, byval column as GtkTreeViewColumn ptr ptr, byval cell_x as gint ptr, byval cell_y as gint ptr) as gboolean
declare sub gtk_tree_view_get_cell_area(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval rect as GdkRectangle ptr)
declare sub gtk_tree_view_get_background_area(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval rect as GdkRectangle ptr)
declare sub gtk_tree_view_get_visible_rect(byval tree_view as GtkTreeView ptr, byval visible_rect as GdkRectangle ptr)
declare sub gtk_tree_view_widget_to_tree_coords(byval tree_view as GtkTreeView ptr, byval wx as gint, byval wy as gint, byval tx as gint ptr, byval ty as gint ptr)
declare sub gtk_tree_view_tree_to_widget_coords(byval tree_view as GtkTreeView ptr, byval tx as gint, byval ty as gint, byval wx as gint ptr, byval wy as gint ptr)
declare function gtk_tree_view_get_visible_range(byval tree_view as GtkTreeView ptr, byval start_path as GtkTreePath ptr ptr, byval end_path as GtkTreePath ptr ptr) as gboolean
declare sub gtk_tree_view_enable_model_drag_source(byval tree_view as GtkTreeView ptr, byval start_button_mask as GdkModifierType, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_tree_view_enable_model_drag_dest(byval tree_view as GtkTreeView ptr, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_tree_view_unset_rows_drag_source(byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_unset_rows_drag_dest(byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_set_drag_dest_row(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval pos as GtkTreeViewDropPosition)
declare sub gtk_tree_view_get_drag_dest_row(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr ptr, byval pos as GtkTreeViewDropPosition ptr)
declare function gtk_tree_view_get_dest_row_at_pos(byval tree_view as GtkTreeView ptr, byval drag_x as gint, byval drag_y as gint, byval path as GtkTreePath ptr ptr, byval pos as GtkTreeViewDropPosition ptr) as gboolean
declare function gtk_tree_view_create_row_drag_icon(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as GdkPixmap ptr
declare sub gtk_tree_view_set_enable_search(byval tree_view as GtkTreeView ptr, byval enable_search as gboolean)
declare function gtk_tree_view_get_enable_search(byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_get_search_column(byval tree_view as GtkTreeView ptr) as gint
declare sub gtk_tree_view_set_search_column(byval tree_view as GtkTreeView ptr, byval column as gint)
declare function gtk_tree_view_get_search_equal_func(byval tree_view as GtkTreeView ptr) as GtkTreeViewSearchEqualFunc
declare sub gtk_tree_view_set_search_equal_func(byval tree_view as GtkTreeView ptr, byval search_equal_func as GtkTreeViewSearchEqualFunc, byval search_user_data as gpointer, byval search_destroy as GDestroyNotify)
declare function gtk_tree_view_get_search_entry(byval tree_view as GtkTreeView ptr) as GtkEntry ptr
declare sub gtk_tree_view_set_search_entry(byval tree_view as GtkTreeView ptr, byval entry as GtkEntry ptr)
declare function gtk_tree_view_get_search_position_func(byval tree_view as GtkTreeView ptr) as GtkTreeViewSearchPositionFunc
declare sub gtk_tree_view_set_search_position_func(byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewSearchPositionFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_view_convert_widget_to_tree_coords(byval tree_view as GtkTreeView ptr, byval wx as gint, byval wy as gint, byval tx as gint ptr, byval ty as gint ptr)
declare sub gtk_tree_view_convert_tree_to_widget_coords(byval tree_view as GtkTreeView ptr, byval tx as gint, byval ty as gint, byval wx as gint ptr, byval wy as gint ptr)
declare sub gtk_tree_view_convert_widget_to_bin_window_coords(byval tree_view as GtkTreeView ptr, byval wx as gint, byval wy as gint, byval bx as gint ptr, byval by as gint ptr)
declare sub gtk_tree_view_convert_bin_window_to_widget_coords(byval tree_view as GtkTreeView ptr, byval bx as gint, byval by as gint, byval wx as gint ptr, byval wy as gint ptr)
declare sub gtk_tree_view_convert_tree_to_bin_window_coords(byval tree_view as GtkTreeView ptr, byval tx as gint, byval ty as gint, byval bx as gint ptr, byval by as gint ptr)
declare sub gtk_tree_view_convert_bin_window_to_tree_coords(byval tree_view as GtkTreeView ptr, byval bx as gint, byval by as gint, byval tx as gint ptr, byval ty as gint ptr)
type GtkTreeDestroyCountFunc as sub(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval children as gint, byval user_data as gpointer)
declare sub gtk_tree_view_set_destroy_count_func(byval tree_view as GtkTreeView ptr, byval func as GtkTreeDestroyCountFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_view_set_fixed_height_mode(byval tree_view as GtkTreeView ptr, byval enable as gboolean)
declare function gtk_tree_view_get_fixed_height_mode(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_hover_selection(byval tree_view as GtkTreeView ptr, byval hover as gboolean)
declare function gtk_tree_view_get_hover_selection(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_hover_expand(byval tree_view as GtkTreeView ptr, byval expand as gboolean)
declare function gtk_tree_view_get_hover_expand(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_rubber_banding(byval tree_view as GtkTreeView ptr, byval enable as gboolean)
declare function gtk_tree_view_get_rubber_banding(byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_is_rubber_banding_active(byval tree_view as GtkTreeView ptr) as gboolean
declare function gtk_tree_view_get_row_separator_func(byval tree_view as GtkTreeView ptr) as GtkTreeViewRowSeparatorFunc
declare sub gtk_tree_view_set_row_separator_func(byval tree_view as GtkTreeView ptr, byval func as GtkTreeViewRowSeparatorFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_tree_view_get_grid_lines(byval tree_view as GtkTreeView ptr) as GtkTreeViewGridLines
declare sub gtk_tree_view_set_grid_lines(byval tree_view as GtkTreeView ptr, byval grid_lines as GtkTreeViewGridLines)
declare function gtk_tree_view_get_enable_tree_lines(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_enable_tree_lines(byval tree_view as GtkTreeView ptr, byval enabled as gboolean)
declare sub gtk_tree_view_set_show_expanders(byval tree_view as GtkTreeView ptr, byval enabled as gboolean)
declare function gtk_tree_view_get_show_expanders(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_level_indentation(byval tree_view as GtkTreeView ptr, byval indentation as gint)
declare function gtk_tree_view_get_level_indentation(byval tree_view as GtkTreeView ptr) as gint
declare sub gtk_tree_view_set_tooltip_row(byval tree_view as GtkTreeView ptr, byval tooltip as GtkTooltip ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_view_set_tooltip_cell(byval tree_view as GtkTreeView ptr, byval tooltip as GtkTooltip ptr, byval path as GtkTreePath ptr, byval column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr)
declare function gtk_tree_view_get_tooltip_context(byval tree_view as GtkTreeView ptr, byval x as gint ptr, byval y as gint ptr, byval keyboard_tip as gboolean, byval model as GtkTreeModel ptr ptr, byval path as GtkTreePath ptr ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_view_set_tooltip_column(byval tree_view as GtkTreeView ptr, byval column as gint)
declare function gtk_tree_view_get_tooltip_column(byval tree_view as GtkTreeView ptr) as gint

#define GTK_TYPE_COMBO_BOX gtk_combo_box_get_type()
#define GTK_COMBO_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COMBO_BOX, GtkComboBox)
#define GTK_COMBO_BOX_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_COMBO_BOX, GtkComboBoxClass)
#define GTK_IS_COMBO_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COMBO_BOX)
#define GTK_IS_COMBO_BOX_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_COMBO_BOX)
#define GTK_COMBO_BOX_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), GTK_TYPE_COMBO_BOX, GtkComboBoxClass)

type GtkComboBox as _GtkComboBox
type GtkComboBoxClass as _GtkComboBoxClass
type GtkComboBoxPrivate as _GtkComboBoxPrivate

type _GtkComboBox
	parent_instance as GtkBin
	priv as GtkComboBoxPrivate ptr
end type

type _GtkComboBoxClass
	parent_class as GtkBinClass
	changed as sub(byval combo_box as GtkComboBox ptr)
	get_active_text as function(byval combo_box as GtkComboBox ptr) as gchar ptr
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_combo_box_get_type() as GType
declare function gtk_combo_box_new() as GtkWidget ptr
declare function gtk_combo_box_new_with_entry() as GtkWidget ptr
declare function gtk_combo_box_new_with_model(byval model as GtkTreeModel ptr) as GtkWidget ptr
declare function gtk_combo_box_new_with_model_and_entry(byval model as GtkTreeModel ptr) as GtkWidget ptr
declare function gtk_combo_box_get_wrap_width(byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_wrap_width(byval combo_box as GtkComboBox ptr, byval width as gint)
declare function gtk_combo_box_get_row_span_column(byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_row_span_column(byval combo_box as GtkComboBox ptr, byval row_span as gint)
declare function gtk_combo_box_get_column_span_column(byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_column_span_column(byval combo_box as GtkComboBox ptr, byval column_span as gint)
declare function gtk_combo_box_get_add_tearoffs(byval combo_box as GtkComboBox ptr) as gboolean
declare sub gtk_combo_box_set_add_tearoffs(byval combo_box as GtkComboBox ptr, byval add_tearoffs as gboolean)
declare function gtk_combo_box_get_title(byval combo_box as GtkComboBox ptr) as const gchar ptr
declare sub gtk_combo_box_set_title(byval combo_box as GtkComboBox ptr, byval title as const gchar ptr)
declare function gtk_combo_box_get_focus_on_click(byval combo as GtkComboBox ptr) as gboolean
declare sub gtk_combo_box_set_focus_on_click(byval combo as GtkComboBox ptr, byval focus_on_click as gboolean)
declare function gtk_combo_box_get_active(byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_active(byval combo_box as GtkComboBox ptr, byval index_ as gint)
declare function gtk_combo_box_get_active_iter(byval combo_box as GtkComboBox ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_combo_box_set_active_iter(byval combo_box as GtkComboBox ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_combo_box_set_model(byval combo_box as GtkComboBox ptr, byval model as GtkTreeModel ptr)
declare function gtk_combo_box_get_model(byval combo_box as GtkComboBox ptr) as GtkTreeModel ptr
declare function gtk_combo_box_get_row_separator_func(byval combo_box as GtkComboBox ptr) as GtkTreeViewRowSeparatorFunc
declare sub gtk_combo_box_set_row_separator_func(byval combo_box as GtkComboBox ptr, byval func as GtkTreeViewRowSeparatorFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_combo_box_set_button_sensitivity(byval combo_box as GtkComboBox ptr, byval sensitivity as GtkSensitivityType)
declare function gtk_combo_box_get_button_sensitivity(byval combo_box as GtkComboBox ptr) as GtkSensitivityType
declare function gtk_combo_box_get_has_entry(byval combo_box as GtkComboBox ptr) as gboolean
declare sub gtk_combo_box_set_entry_text_column(byval combo_box as GtkComboBox ptr, byval text_column as gint)
declare function gtk_combo_box_get_entry_text_column(byval combo_box as GtkComboBox ptr) as gint
declare function gtk_combo_box_new_text() as GtkWidget ptr
declare sub gtk_combo_box_append_text(byval combo_box as GtkComboBox ptr, byval text as const gchar ptr)
declare sub gtk_combo_box_insert_text(byval combo_box as GtkComboBox ptr, byval position as gint, byval text as const gchar ptr)
declare sub gtk_combo_box_prepend_text(byval combo_box as GtkComboBox ptr, byval text as const gchar ptr)
declare sub gtk_combo_box_remove_text(byval combo_box as GtkComboBox ptr, byval position as gint)
declare function gtk_combo_box_get_active_text(byval combo_box as GtkComboBox ptr) as gchar ptr
declare sub gtk_combo_box_popup(byval combo_box as GtkComboBox ptr)
declare sub gtk_combo_box_popdown(byval combo_box as GtkComboBox ptr)
declare function gtk_combo_box_get_popup_accessible(byval combo_box as GtkComboBox ptr) as AtkObject ptr

#define __GTK_COMBO_BOX_ENTRY_H__
#define GTK_TYPE_COMBO_BOX_ENTRY gtk_combo_box_entry_get_type()
#define GTK_COMBO_BOX_ENTRY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COMBO_BOX_ENTRY, GtkComboBoxEntry)
#define GTK_COMBO_BOX_ENTRY_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_COMBO_BOX_ENTRY, GtkComboBoxEntryClass)
#define GTK_IS_COMBO_BOX_ENTRY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COMBO_BOX_ENTRY)
#define GTK_IS_COMBO_BOX_ENTRY_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_COMBO_BOX_ENTRY)
#define GTK_COMBO_BOX_ENTRY_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), GTK_TYPE_COMBO_BOX_ENTRY, GtkComboBoxEntryClass)

type GtkComboBoxEntry as _GtkComboBoxEntry
type GtkComboBoxEntryClass as _GtkComboBoxEntryClass
type GtkComboBoxEntryPrivate as _GtkComboBoxEntryPrivate

type _GtkComboBoxEntry
	parent_instance as GtkComboBox
	priv as GtkComboBoxEntryPrivate ptr
end type

type _GtkComboBoxEntryClass
	parent_class as GtkComboBoxClass
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_combo_box_entry_get_type() as GType
declare function gtk_combo_box_entry_new() as GtkWidget ptr
declare function gtk_combo_box_entry_new_with_model(byval model as GtkTreeModel ptr, byval text_column as gint) as GtkWidget ptr
declare sub gtk_combo_box_entry_set_text_column(byval entry_box as GtkComboBoxEntry ptr, byval text_column as gint)
declare function gtk_combo_box_entry_get_text_column(byval entry_box as GtkComboBoxEntry ptr) as gint
declare function gtk_combo_box_entry_new_text() as GtkWidget ptr

#define __GTK_COMBO_BOX_TEXT_H__
#define GTK_TYPE_COMBO_BOX_TEXT gtk_combo_box_text_get_type()
#define GTK_COMBO_BOX_TEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COMBO_BOX_TEXT, GtkComboBoxText)
#define GTK_COMBO_BOX_TEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COMBO_BOX_TEXT, GtkComboBoxTextClass)
#define GTK_IS_COMBO_BOX_TEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COMBO_BOX_TEXT)
#define GTK_IS_COMBO_BOX_TEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COMBO_BOX_TEXT)
#define GTK_COMBO_BOX_TEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COMBO_BOX_TEXT, GtkComboBoxTextClass)

type GtkComboBoxText as _GtkComboBoxText
type GtkComboBoxTextPrivate as _GtkComboBoxTextPrivate
type GtkComboBoxTextClass as _GtkComboBoxTextClass

type _GtkComboBoxText
	parent_instance as GtkComboBox
	priv as GtkComboBoxTextPrivate ptr
end type

type _GtkComboBoxTextClass
	parent_class as GtkComboBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_combo_box_text_get_type() as GType
declare function gtk_combo_box_text_new() as GtkWidget ptr
declare function gtk_combo_box_text_new_with_entry() as GtkWidget ptr
declare sub gtk_combo_box_text_append_text(byval combo_box as GtkComboBoxText ptr, byval text as const gchar ptr)
declare sub gtk_combo_box_text_insert_text(byval combo_box as GtkComboBoxText ptr, byval position as gint, byval text as const gchar ptr)
declare sub gtk_combo_box_text_prepend_text(byval combo_box as GtkComboBoxText ptr, byval text as const gchar ptr)
declare sub gtk_combo_box_text_remove(byval combo_box as GtkComboBoxText ptr, byval position as gint)
declare function gtk_combo_box_text_get_active_text(byval combo_box as GtkComboBoxText ptr) as gchar ptr

#define __GTK_DRAWING_AREA_H__
#define GTK_TYPE_DRAWING_AREA gtk_drawing_area_get_type()
#define GTK_DRAWING_AREA(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingArea)
#define GTK_DRAWING_AREA_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass)
#define GTK_IS_DRAWING_AREA(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_DRAWING_AREA)
#define GTK_IS_DRAWING_AREA_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_DRAWING_AREA)
#define GTK_DRAWING_AREA_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass)
type GtkDrawingArea as _GtkDrawingArea
type GtkDrawingAreaClass as _GtkDrawingAreaClass

type _GtkDrawingArea
	widget as GtkWidget
	draw_data as gpointer
end type

type _GtkDrawingAreaClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_drawing_area_get_type() as GType
declare function gtk_drawing_area_new() as GtkWidget ptr
declare sub gtk_drawing_area_size(byval darea as GtkDrawingArea ptr, byval width as gint, byval height as gint)

#define __GTK_EVENT_BOX_H__
#define GTK_TYPE_EVENT_BOX gtk_event_box_get_type()
#define GTK_EVENT_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_EVENT_BOX, GtkEventBox)
#define GTK_EVENT_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_EVENT_BOX, GtkEventBoxClass)
#define GTK_IS_EVENT_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_EVENT_BOX)
#define GTK_IS_EVENT_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_EVENT_BOX)
#define GTK_EVENT_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_EVENT_BOX, GtkEventBoxClass)
type GtkEventBox as _GtkEventBox
type GtkEventBoxClass as _GtkEventBoxClass

type _GtkEventBox
	bin as GtkBin
end type

type _GtkEventBoxClass
	parent_class as GtkBinClass
end type

declare function gtk_event_box_get_type() as GType
declare function gtk_event_box_new() as GtkWidget ptr
declare function gtk_event_box_get_visible_window(byval event_box as GtkEventBox ptr) as gboolean
declare sub gtk_event_box_set_visible_window(byval event_box as GtkEventBox ptr, byval visible_window as gboolean)
declare function gtk_event_box_get_above_child(byval event_box as GtkEventBox ptr) as gboolean
declare sub gtk_event_box_set_above_child(byval event_box as GtkEventBox ptr, byval above_child as gboolean)

#define __GTK_EXPANDER_H__
#define GTK_TYPE_EXPANDER gtk_expander_get_type()
#define GTK_EXPANDER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_EXPANDER, GtkExpander)
#define GTK_EXPANDER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_EXPANDER, GtkExpanderClass)
#define GTK_IS_EXPANDER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_EXPANDER)
#define GTK_IS_EXPANDER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_EXPANDER)
#define GTK_EXPANDER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_EXPANDER, GtkExpanderClass)

type GtkExpander as _GtkExpander
type GtkExpanderClass as _GtkExpanderClass
type GtkExpanderPrivate as _GtkExpanderPrivate

type _GtkExpander
	bin as GtkBin
	priv as GtkExpanderPrivate ptr
end type

type _GtkExpanderClass
	parent_class as GtkBinClass
	activate as sub(byval expander as GtkExpander ptr)
end type

declare function gtk_expander_get_type() as GType
declare function gtk_expander_new(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_expander_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_expander_set_expanded(byval expander as GtkExpander ptr, byval expanded as gboolean)
declare function gtk_expander_get_expanded(byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_spacing(byval expander as GtkExpander ptr, byval spacing as gint)
declare function gtk_expander_get_spacing(byval expander as GtkExpander ptr) as gint
declare sub gtk_expander_set_label(byval expander as GtkExpander ptr, byval label as const gchar ptr)
declare function gtk_expander_get_label(byval expander as GtkExpander ptr) as const gchar ptr
declare sub gtk_expander_set_use_underline(byval expander as GtkExpander ptr, byval use_underline as gboolean)
declare function gtk_expander_get_use_underline(byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_use_markup(byval expander as GtkExpander ptr, byval use_markup as gboolean)
declare function gtk_expander_get_use_markup(byval expander as GtkExpander ptr) as gboolean
declare sub gtk_expander_set_label_widget(byval expander as GtkExpander ptr, byval label_widget as GtkWidget ptr)
declare function gtk_expander_get_label_widget(byval expander as GtkExpander ptr) as GtkWidget ptr
declare sub gtk_expander_set_label_fill(byval expander as GtkExpander ptr, byval label_fill as gboolean)
declare function gtk_expander_get_label_fill(byval expander as GtkExpander ptr) as gboolean

#define __GTK_FIXED_H__
#define GTK_TYPE_FIXED gtk_fixed_get_type()
#define GTK_FIXED(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FIXED, GtkFixed)
#define GTK_FIXED_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FIXED, GtkFixedClass)
#define GTK_IS_FIXED(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FIXED)
#define GTK_IS_FIXED_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FIXED)
#define GTK_FIXED_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FIXED, GtkFixedClass)

type GtkFixed as _GtkFixed
type GtkFixedClass as _GtkFixedClass
type GtkFixedChild as _GtkFixedChild

type _GtkFixed
	container as GtkContainer
	children as GList ptr
end type

type _GtkFixedClass
	parent_class as GtkContainerClass
end type

type _GtkFixedChild
	widget as GtkWidget ptr
	x as gint
	y as gint
end type

declare function gtk_fixed_get_type() as GType
declare function gtk_fixed_new() as GtkWidget ptr
declare sub gtk_fixed_put(byval fixed as GtkFixed ptr, byval widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_fixed_move(byval fixed as GtkFixed ptr, byval widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_fixed_set_has_window(byval fixed as GtkFixed ptr, byval has_window as gboolean)
declare function gtk_fixed_get_has_window(byval fixed as GtkFixed ptr) as gboolean

#define __GTK_FILE_CHOOSER_H__
#define __GTK_FILE_FILTER_H__
#define GTK_TYPE_FILE_FILTER gtk_file_filter_get_type()
#define GTK_FILE_FILTER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FILE_FILTER, GtkFileFilter)
#define GTK_IS_FILE_FILTER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FILE_FILTER)
type GtkFileFilter as _GtkFileFilter
type GtkFileFilterInfo as _GtkFileFilterInfo

type GtkFileFilterFlags as long
enum
	GTK_FILE_FILTER_FILENAME = 1 shl 0
	GTK_FILE_FILTER_URI = 1 shl 1
	GTK_FILE_FILTER_DISPLAY_NAME = 1 shl 2
	GTK_FILE_FILTER_MIME_TYPE = 1 shl 3
end enum

type GtkFileFilterFunc as function(byval filter_info as const GtkFileFilterInfo ptr, byval data as gpointer) as gboolean

type _GtkFileFilterInfo
	contains as GtkFileFilterFlags
	filename as const gchar ptr
	uri as const gchar ptr
	display_name as const gchar ptr
	mime_type as const gchar ptr
end type

declare function gtk_file_filter_get_type() as GType
declare function gtk_file_filter_new() as GtkFileFilter ptr
declare sub gtk_file_filter_set_name(byval filter as GtkFileFilter ptr, byval name as const gchar ptr)
declare function gtk_file_filter_get_name(byval filter as GtkFileFilter ptr) as const gchar ptr
declare sub gtk_file_filter_add_mime_type(byval filter as GtkFileFilter ptr, byval mime_type as const gchar ptr)
declare sub gtk_file_filter_add_pattern(byval filter as GtkFileFilter ptr, byval pattern as const gchar ptr)
declare sub gtk_file_filter_add_pixbuf_formats(byval filter as GtkFileFilter ptr)
declare sub gtk_file_filter_add_custom(byval filter as GtkFileFilter ptr, byval needed as GtkFileFilterFlags, byval func as GtkFileFilterFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare function gtk_file_filter_get_needed(byval filter as GtkFileFilter ptr) as GtkFileFilterFlags
declare function gtk_file_filter_filter(byval filter as GtkFileFilter ptr, byval filter_info as const GtkFileFilterInfo ptr) as gboolean

#define GTK_TYPE_FILE_CHOOSER gtk_file_chooser_get_type()
#define GTK_FILE_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FILE_CHOOSER, GtkFileChooser)
#define GTK_IS_FILE_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FILE_CHOOSER)
type GtkFileChooser as _GtkFileChooser

type GtkFileChooserAction as long
enum
	GTK_FILE_CHOOSER_ACTION_OPEN
	GTK_FILE_CHOOSER_ACTION_SAVE
	GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER
	GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER
end enum

type GtkFileChooserConfirmation as long
enum
	GTK_FILE_CHOOSER_CONFIRMATION_CONFIRM
	GTK_FILE_CHOOSER_CONFIRMATION_ACCEPT_FILENAME
	GTK_FILE_CHOOSER_CONFIRMATION_SELECT_AGAIN
end enum

declare function gtk_file_chooser_get_type() as GType
#define GTK_FILE_CHOOSER_ERROR gtk_file_chooser_error_quark()

type GtkFileChooserError as long
enum
	GTK_FILE_CHOOSER_ERROR_NONEXISTENT
	GTK_FILE_CHOOSER_ERROR_BAD_FILENAME
	GTK_FILE_CHOOSER_ERROR_ALREADY_EXISTS
	GTK_FILE_CHOOSER_ERROR_INCOMPLETE_HOSTNAME
end enum

declare function gtk_file_chooser_error_quark() as GQuark
declare sub gtk_file_chooser_set_action(byval chooser as GtkFileChooser ptr, byval action as GtkFileChooserAction)
declare function gtk_file_chooser_get_action(byval chooser as GtkFileChooser ptr) as GtkFileChooserAction
declare sub gtk_file_chooser_set_local_only(byval chooser as GtkFileChooser ptr, byval local_only as gboolean)
declare function gtk_file_chooser_get_local_only(byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_select_multiple(byval chooser as GtkFileChooser ptr, byval select_multiple as gboolean)
declare function gtk_file_chooser_get_select_multiple(byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_show_hidden(byval chooser as GtkFileChooser ptr, byval show_hidden as gboolean)
declare function gtk_file_chooser_get_show_hidden(byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_do_overwrite_confirmation(byval chooser as GtkFileChooser ptr, byval do_overwrite_confirmation as gboolean)
declare function gtk_file_chooser_get_do_overwrite_confirmation(byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_create_folders(byval chooser as GtkFileChooser ptr, byval create_folders as gboolean)
declare function gtk_file_chooser_get_create_folders(byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_current_name(byval chooser as GtkFileChooser ptr, byval name as const gchar ptr)

#ifdef __FB_UNIX__
	declare function gtk_file_chooser_get_filename(byval chooser as GtkFileChooser ptr) as gchar ptr
	declare function gtk_file_chooser_set_filename(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
	declare function gtk_file_chooser_select_filename(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
	declare sub gtk_file_chooser_unselect_filename(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr)
#else
	declare function gtk_file_chooser_get_filename_utf8(byval chooser as GtkFileChooser ptr) as gchar ptr
	declare function gtk_file_chooser_get_filename alias "gtk_file_chooser_get_filename_utf8"(byval chooser as GtkFileChooser ptr) as gchar ptr
	declare function gtk_file_chooser_set_filename_utf8(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
	declare function gtk_file_chooser_set_filename alias "gtk_file_chooser_set_filename_utf8"(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
	declare function gtk_file_chooser_select_filename_utf8(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
	declare function gtk_file_chooser_select_filename alias "gtk_file_chooser_select_filename_utf8"(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
	declare sub gtk_file_chooser_unselect_filename_utf8(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr)
	declare sub gtk_file_chooser_unselect_filename alias "gtk_file_chooser_unselect_filename_utf8"(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr)
#endif

declare sub gtk_file_chooser_select_all(byval chooser as GtkFileChooser ptr)
declare sub gtk_file_chooser_unselect_all(byval chooser as GtkFileChooser ptr)

#ifdef __FB_UNIX__
	declare function gtk_file_chooser_get_filenames(byval chooser as GtkFileChooser ptr) as GSList ptr
	declare function gtk_file_chooser_set_current_folder(byval chooser as GtkFileChooser ptr, byval filename as const gchar ptr) as gboolean
	declare function gtk_file_chooser_get_current_folder(byval chooser as GtkFileChooser ptr) as gchar ptr
#else
	declare function gtk_file_chooser_get_filenames_utf8(byval chooser as GtkFileChooser ptr) as GSList ptr
	declare function gtk_file_chooser_get_filenames alias "gtk_file_chooser_get_filenames_utf8"(byval chooser as GtkFileChooser ptr) as GSList ptr
	declare function gtk_file_chooser_set_current_folder_utf8(byval chooser as GtkFileChooser ptr, byval filename as const gchar ptr) as gboolean
	declare function gtk_file_chooser_set_current_folder alias "gtk_file_chooser_set_current_folder_utf8"(byval chooser as GtkFileChooser ptr, byval filename as const gchar ptr) as gboolean
	declare function gtk_file_chooser_get_current_folder_utf8(byval chooser as GtkFileChooser ptr) as gchar ptr
	declare function gtk_file_chooser_get_current_folder alias "gtk_file_chooser_get_current_folder_utf8"(byval chooser as GtkFileChooser ptr) as gchar ptr
#endif

declare function gtk_file_chooser_get_uri(byval chooser as GtkFileChooser ptr) as gchar ptr
declare function gtk_file_chooser_set_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr) as gboolean
declare function gtk_file_chooser_select_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr) as gboolean
declare sub gtk_file_chooser_unselect_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr)
declare function gtk_file_chooser_get_uris(byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_set_current_folder_uri(byval chooser as GtkFileChooser ptr, byval uri as const gchar ptr) as gboolean
declare function gtk_file_chooser_get_current_folder_uri(byval chooser as GtkFileChooser ptr) as gchar ptr
declare function gtk_file_chooser_get_file(byval chooser as GtkFileChooser ptr) as GFile ptr
declare function gtk_file_chooser_set_file(byval chooser as GtkFileChooser ptr, byval file as GFile ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_select_file(byval chooser as GtkFileChooser ptr, byval file as GFile ptr, byval error as GError ptr ptr) as gboolean
declare sub gtk_file_chooser_unselect_file(byval chooser as GtkFileChooser ptr, byval file as GFile ptr)
declare function gtk_file_chooser_get_files(byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_set_current_folder_file(byval chooser as GtkFileChooser ptr, byval file as GFile ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_get_current_folder_file(byval chooser as GtkFileChooser ptr) as GFile ptr
declare sub gtk_file_chooser_set_preview_widget(byval chooser as GtkFileChooser ptr, byval preview_widget as GtkWidget ptr)
declare function gtk_file_chooser_get_preview_widget(byval chooser as GtkFileChooser ptr) as GtkWidget ptr
declare sub gtk_file_chooser_set_preview_widget_active(byval chooser as GtkFileChooser ptr, byval active as gboolean)
declare function gtk_file_chooser_get_preview_widget_active(byval chooser as GtkFileChooser ptr) as gboolean
declare sub gtk_file_chooser_set_use_preview_label(byval chooser as GtkFileChooser ptr, byval use_label as gboolean)
declare function gtk_file_chooser_get_use_preview_label(byval chooser as GtkFileChooser ptr) as gboolean

#ifdef __FB_UNIX__
	declare function gtk_file_chooser_get_preview_filename(byval chooser as GtkFileChooser ptr) as zstring ptr
#else
	declare function gtk_file_chooser_get_preview_filename_utf8(byval chooser as GtkFileChooser ptr) as zstring ptr
	declare function gtk_file_chooser_get_preview_filename alias "gtk_file_chooser_get_preview_filename_utf8"(byval chooser as GtkFileChooser ptr) as zstring ptr
#endif

declare function gtk_file_chooser_get_preview_uri(byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_get_preview_file(byval chooser as GtkFileChooser ptr) as GFile ptr
declare sub gtk_file_chooser_set_extra_widget(byval chooser as GtkFileChooser ptr, byval extra_widget as GtkWidget ptr)
declare function gtk_file_chooser_get_extra_widget(byval chooser as GtkFileChooser ptr) as GtkWidget ptr
declare sub gtk_file_chooser_add_filter(byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare sub gtk_file_chooser_remove_filter(byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare function gtk_file_chooser_list_filters(byval chooser as GtkFileChooser ptr) as GSList ptr
declare sub gtk_file_chooser_set_filter(byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare function gtk_file_chooser_get_filter(byval chooser as GtkFileChooser ptr) as GtkFileFilter ptr

#ifdef __FB_UNIX__
	declare function gtk_file_chooser_add_shortcut_folder(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
	declare function gtk_file_chooser_remove_shortcut_folder(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
	declare function gtk_file_chooser_list_shortcut_folders(byval chooser as GtkFileChooser ptr) as GSList ptr
#else
	declare function gtk_file_chooser_add_shortcut_folder_utf8(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
	declare function gtk_file_chooser_add_shortcut_folder alias "gtk_file_chooser_add_shortcut_folder_utf8"(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
	declare function gtk_file_chooser_remove_shortcut_folder_utf8(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
	declare function gtk_file_chooser_remove_shortcut_folder alias "gtk_file_chooser_remove_shortcut_folder_utf8"(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
	declare function gtk_file_chooser_list_shortcut_folders_utf8(byval chooser as GtkFileChooser ptr) as GSList ptr
	declare function gtk_file_chooser_list_shortcut_folders alias "gtk_file_chooser_list_shortcut_folders_utf8"(byval chooser as GtkFileChooser ptr) as GSList ptr
#endif

declare function gtk_file_chooser_add_shortcut_folder_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_remove_shortcut_folder_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_list_shortcut_folder_uris(byval chooser as GtkFileChooser ptr) as GSList ptr

#define __GTK_FILE_CHOOSER_BUTTON_H__
#define __GTK_HBOX_H__
#define GTK_TYPE_HBOX gtk_hbox_get_type()
#define GTK_HBOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HBOX, GtkHBox)
#define GTK_HBOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HBOX, GtkHBoxClass)
#define GTK_IS_HBOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HBOX)
#define GTK_IS_HBOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HBOX)
#define GTK_HBOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HBOX, GtkHBoxClass)
type GtkHBox as _GtkHBox
type GtkHBoxClass as _GtkHBoxClass

type _GtkHBox
	box as GtkBox
end type

type _GtkHBoxClass
	parent_class as GtkBoxClass
end type

declare function gtk_hbox_get_type() as GType
declare function gtk_hbox_new(byval homogeneous as gboolean, byval spacing as gint) as GtkWidget ptr
#define GTK_TYPE_FILE_CHOOSER_BUTTON gtk_file_chooser_button_get_type()
#define GTK_FILE_CHOOSER_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButton)
#define GTK_FILE_CHOOSER_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButtonClass)
#define GTK_IS_FILE_CHOOSER_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FILE_CHOOSER_BUTTON)
#define GTK_IS_FILE_CHOOSER_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FILE_CHOOSER_BUTTON)
#define GTK_FILE_CHOOSER_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButtonClass)

type GtkFileChooserButton as _GtkFileChooserButton
type GtkFileChooserButtonPrivate as _GtkFileChooserButtonPrivate
type GtkFileChooserButtonClass as _GtkFileChooserButtonClass

type _GtkFileChooserButton
	parent as GtkHBox
	priv as GtkFileChooserButtonPrivate ptr
end type

type _GtkFileChooserButtonClass
	parent_class as GtkHBoxClass
	file_set as sub(byval fc as GtkFileChooserButton ptr)
	__gtk_reserved1 as any ptr
	__gtk_reserved2 as any ptr
	__gtk_reserved3 as any ptr
	__gtk_reserved4 as any ptr
	__gtk_reserved5 as any ptr
	__gtk_reserved6 as any ptr
	__gtk_reserved7 as any ptr
end type

declare function gtk_file_chooser_button_get_type() as GType
declare function gtk_file_chooser_button_new(byval title as const gchar ptr, byval action as GtkFileChooserAction) as GtkWidget ptr
declare function gtk_file_chooser_button_new_with_backend(byval title as const gchar ptr, byval action as GtkFileChooserAction, byval backend as const gchar ptr) as GtkWidget ptr
declare function gtk_file_chooser_button_new_with_dialog(byval dialog as GtkWidget ptr) as GtkWidget ptr
declare function gtk_file_chooser_button_get_title(byval button as GtkFileChooserButton ptr) as const gchar ptr
declare sub gtk_file_chooser_button_set_title(byval button as GtkFileChooserButton ptr, byval title as const gchar ptr)
declare function gtk_file_chooser_button_get_width_chars(byval button as GtkFileChooserButton ptr) as gint
declare sub gtk_file_chooser_button_set_width_chars(byval button as GtkFileChooserButton ptr, byval n_chars as gint)
declare function gtk_file_chooser_button_get_focus_on_click(byval button as GtkFileChooserButton ptr) as gboolean
declare sub gtk_file_chooser_button_set_focus_on_click(byval button as GtkFileChooserButton ptr, byval focus_on_click as gboolean)

#define __GTK_FILE_CHOOSER_DIALOG_H__
#define GTK_TYPE_FILE_CHOOSER_DIALOG gtk_file_chooser_dialog_get_type()
#define GTK_FILE_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialog)
#define GTK_FILE_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialogClass)
#define GTK_IS_FILE_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FILE_CHOOSER_DIALOG)
#define GTK_IS_FILE_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FILE_CHOOSER_DIALOG)
#define GTK_FILE_CHOOSER_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialogClass)

type GtkFileChooserDialog as _GtkFileChooserDialog
type GtkFileChooserDialogPrivate as _GtkFileChooserDialogPrivate
type GtkFileChooserDialogClass as _GtkFileChooserDialogClass

type _GtkFileChooserDialog
	parent_instance as GtkDialog
	priv as GtkFileChooserDialogPrivate ptr
end type

type _GtkFileChooserDialogClass
	parent_class as GtkDialogClass
end type

declare function gtk_file_chooser_dialog_get_type() as GType
declare function gtk_file_chooser_dialog_new(byval title as const gchar ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval first_button_text as const gchar ptr, ...) as GtkWidget ptr
declare function gtk_file_chooser_dialog_new_with_backend(byval title as const gchar ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval backend as const gchar ptr, byval first_button_text as const gchar ptr, ...) as GtkWidget ptr

#define __GTK_FILE_CHOOSER_WIDGET_H__
#define GTK_TYPE_FILE_CHOOSER_WIDGET gtk_file_chooser_widget_get_type()
#define GTK_FILE_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidget)
#define GTK_FILE_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidgetClass)
#define GTK_IS_FILE_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FILE_CHOOSER_WIDGET)
#define GTK_IS_FILE_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FILE_CHOOSER_WIDGET)
#define GTK_FILE_CHOOSER_WIDGET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidgetClass)

type GtkFileChooserWidget as _GtkFileChooserWidget
type GtkFileChooserWidgetPrivate as _GtkFileChooserWidgetPrivate
type GtkFileChooserWidgetClass as _GtkFileChooserWidgetClass

type _GtkFileChooserWidget
	parent_instance as GtkVBox
	priv as GtkFileChooserWidgetPrivate ptr
end type

type _GtkFileChooserWidgetClass
	parent_class as GtkVBoxClass
end type

declare function gtk_file_chooser_widget_get_type() as GType
declare function gtk_file_chooser_widget_new(byval action as GtkFileChooserAction) as GtkWidget ptr
declare function gtk_file_chooser_widget_new_with_backend(byval action as GtkFileChooserAction, byval backend as const gchar ptr) as GtkWidget ptr

#define __GTK_FONT_BUTTON_H__
#define GTK_TYPE_FONT_BUTTON gtk_font_button_get_type()
#define GTK_FONT_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FONT_BUTTON, GtkFontButton)
#define GTK_FONT_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FONT_BUTTON, GtkFontButtonClass)
#define GTK_IS_FONT_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FONT_BUTTON)
#define GTK_IS_FONT_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FONT_BUTTON)
#define GTK_FONT_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FONT_BUTTON, GtkFontButtonClass)

type GtkFontButton as _GtkFontButton
type GtkFontButtonClass as _GtkFontButtonClass
type GtkFontButtonPrivate as _GtkFontButtonPrivate

type _GtkFontButton
	button as GtkButton
	priv as GtkFontButtonPrivate ptr
end type

type _GtkFontButtonClass
	parent_class as GtkButtonClass
	font_set as sub(byval gfp as GtkFontButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_font_button_get_type() as GType
declare function gtk_font_button_new() as GtkWidget ptr
declare function gtk_font_button_new_with_font(byval fontname as const gchar ptr) as GtkWidget ptr
declare function gtk_font_button_get_title(byval font_button as GtkFontButton ptr) as const gchar ptr
declare sub gtk_font_button_set_title(byval font_button as GtkFontButton ptr, byval title as const gchar ptr)
declare function gtk_font_button_get_use_font(byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_use_font(byval font_button as GtkFontButton ptr, byval use_font as gboolean)
declare function gtk_font_button_get_use_size(byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_use_size(byval font_button as GtkFontButton ptr, byval use_size as gboolean)
declare function gtk_font_button_get_font_name(byval font_button as GtkFontButton ptr) as const gchar ptr
declare function gtk_font_button_set_font_name(byval font_button as GtkFontButton ptr, byval fontname as const gchar ptr) as gboolean
declare function gtk_font_button_get_show_style(byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_show_style(byval font_button as GtkFontButton ptr, byval show_style as gboolean)
declare function gtk_font_button_get_show_size(byval font_button as GtkFontButton ptr) as gboolean
declare sub gtk_font_button_set_show_size(byval font_button as GtkFontButton ptr, byval show_size as gboolean)

#define __GTK_FONTSEL_H__
#define GTK_TYPE_FONT_SELECTION gtk_font_selection_get_type()
#define GTK_FONT_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FONT_SELECTION, GtkFontSelection)
#define GTK_FONT_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FONT_SELECTION, GtkFontSelectionClass)
#define GTK_IS_FONT_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FONT_SELECTION)
#define GTK_IS_FONT_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FONT_SELECTION)
#define GTK_FONT_SELECTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FONT_SELECTION, GtkFontSelectionClass)
#define GTK_TYPE_FONT_SELECTION_DIALOG gtk_font_selection_dialog_get_type()
#define GTK_FONT_SELECTION_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialog)
#define GTK_FONT_SELECTION_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialogClass)
#define GTK_IS_FONT_SELECTION_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FONT_SELECTION_DIALOG)
#define GTK_IS_FONT_SELECTION_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FONT_SELECTION_DIALOG)
#define GTK_FONT_SELECTION_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialogClass)

type GtkFontSelection as _GtkFontSelection
type GtkFontSelectionClass as _GtkFontSelectionClass
type GtkFontSelectionDialog as _GtkFontSelectionDialog
type GtkFontSelectionDialogClass as _GtkFontSelectionDialogClass

type _GtkFontSelection
	parent_instance as GtkVBox
	font_entry as GtkWidget ptr
	family_list as GtkWidget ptr
	font_style_entry as GtkWidget ptr
	face_list as GtkWidget ptr
	size_entry as GtkWidget ptr
	size_list as GtkWidget ptr
	pixels_button as GtkWidget ptr
	points_button as GtkWidget ptr
	filter_button as GtkWidget ptr
	preview_entry as GtkWidget ptr
	family as PangoFontFamily ptr
	face as PangoFontFace ptr
	size as gint
	font as GdkFont ptr
end type

type _GtkFontSelectionClass
	parent_class as GtkVBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkFontSelectionDialog
	parent_instance as GtkDialog
	fontsel as GtkWidget ptr
	main_vbox as GtkWidget ptr
	action_area as GtkWidget ptr
	ok_button as GtkWidget ptr
	apply_button as GtkWidget ptr
	cancel_button as GtkWidget ptr
	dialog_width as gint
	auto_resize as gboolean
end type

type _GtkFontSelectionDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_font_selection_get_type() as GType
declare function gtk_font_selection_new() as GtkWidget ptr
declare function gtk_font_selection_get_family_list(byval fontsel as GtkFontSelection ptr) as GtkWidget ptr
declare function gtk_font_selection_get_face_list(byval fontsel as GtkFontSelection ptr) as GtkWidget ptr
declare function gtk_font_selection_get_size_entry(byval fontsel as GtkFontSelection ptr) as GtkWidget ptr
declare function gtk_font_selection_get_size_list(byval fontsel as GtkFontSelection ptr) as GtkWidget ptr
declare function gtk_font_selection_get_preview_entry(byval fontsel as GtkFontSelection ptr) as GtkWidget ptr
declare function gtk_font_selection_get_family(byval fontsel as GtkFontSelection ptr) as PangoFontFamily ptr
declare function gtk_font_selection_get_face(byval fontsel as GtkFontSelection ptr) as PangoFontFace ptr
declare function gtk_font_selection_get_size(byval fontsel as GtkFontSelection ptr) as gint
declare function gtk_font_selection_get_font_name(byval fontsel as GtkFontSelection ptr) as gchar ptr
declare function gtk_font_selection_get_font(byval fontsel as GtkFontSelection ptr) as GdkFont ptr
declare function gtk_font_selection_set_font_name(byval fontsel as GtkFontSelection ptr, byval fontname as const gchar ptr) as gboolean
declare function gtk_font_selection_get_preview_text(byval fontsel as GtkFontSelection ptr) as const gchar ptr
declare sub gtk_font_selection_set_preview_text(byval fontsel as GtkFontSelection ptr, byval text as const gchar ptr)
declare function gtk_font_selection_dialog_get_type() as GType
declare function gtk_font_selection_dialog_new(byval title as const gchar ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_ok_button(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_apply_button(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_cancel_button(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_font_selection(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_font_name(byval fsd as GtkFontSelectionDialog ptr) as gchar ptr
declare function gtk_font_selection_dialog_get_font(byval fsd as GtkFontSelectionDialog ptr) as GdkFont ptr
declare function gtk_font_selection_dialog_set_font_name(byval fsd as GtkFontSelectionDialog ptr, byval fontname as const gchar ptr) as gboolean
declare function gtk_font_selection_dialog_get_preview_text(byval fsd as GtkFontSelectionDialog ptr) as const gchar ptr
declare sub gtk_font_selection_dialog_set_preview_text(byval fsd as GtkFontSelectionDialog ptr, byval text as const gchar ptr)
#define __GTK_GC_H__
declare function gtk_gc_get(byval depth as gint, byval colormap as GdkColormap ptr, byval values as GdkGCValues ptr, byval values_mask as GdkGCValuesMask) as GdkGC ptr
declare sub gtk_gc_release(byval gc as GdkGC ptr)

#define __GTK_HANDLE_BOX_H__
#define GTK_TYPE_HANDLE_BOX gtk_handle_box_get_type()
#define GTK_HANDLE_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HANDLE_BOX, GtkHandleBox)
#define GTK_HANDLE_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HANDLE_BOX, GtkHandleBoxClass)
#define GTK_IS_HANDLE_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HANDLE_BOX)
#define GTK_IS_HANDLE_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HANDLE_BOX)
#define GTK_HANDLE_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HANDLE_BOX, GtkHandleBoxClass)
type GtkHandleBox as _GtkHandleBox
type GtkHandleBoxClass as _GtkHandleBoxClass

type _GtkHandleBox
	bin as GtkBin
	bin_window as GdkWindow ptr
	float_window as GdkWindow ptr
	shadow_type as GtkShadowType
	handle_position : 2 as guint
	float_window_mapped : 1 as guint
	child_detached : 1 as guint
	in_drag : 1 as guint
	shrink_on_detach : 1 as guint
	snap_edge : 3 as long
	deskoff_x as gint
	deskoff_y as gint
	attach_allocation as GtkAllocation
	float_allocation as GtkAllocation
end type

type _GtkHandleBoxClass
	parent_class as GtkBinClass
	child_attached as sub(byval handle_box as GtkHandleBox ptr, byval child as GtkWidget ptr)
	child_detached as sub(byval handle_box as GtkHandleBox ptr, byval child as GtkWidget ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_handle_box_get_type() as GType
declare function gtk_handle_box_new() as GtkWidget ptr
declare sub gtk_handle_box_set_shadow_type(byval handle_box as GtkHandleBox ptr, byval type as GtkShadowType)
declare function gtk_handle_box_get_shadow_type(byval handle_box as GtkHandleBox ptr) as GtkShadowType
declare sub gtk_handle_box_set_handle_position(byval handle_box as GtkHandleBox ptr, byval position as GtkPositionType)
declare function gtk_handle_box_get_handle_position(byval handle_box as GtkHandleBox ptr) as GtkPositionType
declare sub gtk_handle_box_set_snap_edge(byval handle_box as GtkHandleBox ptr, byval edge as GtkPositionType)
declare function gtk_handle_box_get_snap_edge(byval handle_box as GtkHandleBox ptr) as GtkPositionType
declare function gtk_handle_box_get_child_detached(byval handle_box as GtkHandleBox ptr) as gboolean

#define __GTK_HBUTTON_BOX_H__
#define GTK_TYPE_HBUTTON_BOX gtk_hbutton_box_get_type()
#define GTK_HBUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HBUTTON_BOX, GtkHButtonBox)
#define GTK_HBUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HBUTTON_BOX, GtkHButtonBoxClass)
#define GTK_IS_HBUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HBUTTON_BOX)
#define GTK_IS_HBUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HBUTTON_BOX)
#define GTK_HBUTTON_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HBUTTON_BOX, GtkHButtonBoxClass)
type GtkHButtonBox as _GtkHButtonBox
type GtkHButtonBoxClass as _GtkHButtonBoxClass

type _GtkHButtonBox
	button_box as GtkButtonBox
end type

type _GtkHButtonBoxClass
	parent_class as GtkButtonBoxClass
end type

declare function gtk_hbutton_box_get_type() as GType
declare function gtk_hbutton_box_new() as GtkWidget ptr
declare function gtk_hbutton_box_get_spacing_default() as gint
declare function gtk_hbutton_box_get_layout_default() as GtkButtonBoxStyle
declare sub gtk_hbutton_box_set_spacing_default(byval spacing as gint)
declare sub gtk_hbutton_box_set_layout_default(byval layout as GtkButtonBoxStyle)
declare function _gtk_hbutton_box_get_layout_default() as GtkButtonBoxStyle

#define __GTK_HPANED_H__
#define __GTK_PANED_H__
#define GTK_TYPE_PANED gtk_paned_get_type()
#define GTK_PANED(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PANED, GtkPaned)
#define GTK_PANED_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PANED, GtkPanedClass)
#define GTK_IS_PANED(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PANED)
#define GTK_IS_PANED_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PANED)
#define GTK_PANED_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PANED, GtkPanedClass)

type GtkPaned as _GtkPaned
type GtkPanedClass as _GtkPanedClass
type GtkPanedPrivate as _GtkPanedPrivate

type _GtkPaned
	container as GtkContainer
	child1 as GtkWidget ptr
	child2 as GtkWidget ptr
	handle as GdkWindow ptr
	xor_gc as GdkGC ptr
	cursor_type as GdkCursorType
	handle_pos as GdkRectangle
	child1_size as gint
	last_allocation as gint
	min_position as gint
	max_position as gint
	position_set : 1 as guint
	in_drag : 1 as guint
	child1_shrink : 1 as guint
	child1_resize : 1 as guint
	child2_shrink : 1 as guint
	child2_resize : 1 as guint
	orientation : 1 as guint
	in_recursion : 1 as guint
	handle_prelit : 1 as guint
	last_child1_focus as GtkWidget ptr
	last_child2_focus as GtkWidget ptr
	priv as GtkPanedPrivate ptr
	drag_pos as gint
	original_position as gint
end type

type _GtkPanedClass
	parent_class as GtkContainerClass
	cycle_child_focus as function(byval paned as GtkPaned ptr, byval reverse as gboolean) as gboolean
	toggle_handle_focus as function(byval paned as GtkPaned ptr) as gboolean
	move_handle as function(byval paned as GtkPaned ptr, byval scroll as GtkScrollType) as gboolean
	cycle_handle_focus as function(byval paned as GtkPaned ptr, byval reverse as gboolean) as gboolean
	accept_position as function(byval paned as GtkPaned ptr) as gboolean
	cancel_position as function(byval paned as GtkPaned ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_paned_get_type() as GType
declare sub gtk_paned_add1(byval paned as GtkPaned ptr, byval child as GtkWidget ptr)
declare sub gtk_paned_add2(byval paned as GtkPaned ptr, byval child as GtkWidget ptr)
declare sub gtk_paned_pack1(byval paned as GtkPaned ptr, byval child as GtkWidget ptr, byval resize as gboolean, byval shrink as gboolean)
declare sub gtk_paned_pack2(byval paned as GtkPaned ptr, byval child as GtkWidget ptr, byval resize as gboolean, byval shrink as gboolean)
declare function gtk_paned_get_position(byval paned as GtkPaned ptr) as gint
declare sub gtk_paned_set_position(byval paned as GtkPaned ptr, byval position as gint)
declare function gtk_paned_get_child1(byval paned as GtkPaned ptr) as GtkWidget ptr
declare function gtk_paned_get_child2(byval paned as GtkPaned ptr) as GtkWidget ptr
declare function gtk_paned_get_handle_window(byval paned as GtkPaned ptr) as GdkWindow ptr
declare sub gtk_paned_compute_position(byval paned as GtkPaned ptr, byval allocation as gint, byval child1_req as gint, byval child2_req as gint)

#define gtk_paned_gutter_size(p, s) 0
#define gtk_paned_set_gutter_size(p, s) 0
#define GTK_TYPE_HPANED gtk_hpaned_get_type()
#define GTK_HPANED(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HPANED, GtkHPaned)
#define GTK_HPANED_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HPANED, GtkHPanedClass)
#define GTK_IS_HPANED(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HPANED)
#define GTK_IS_HPANED_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HPANED)
#define GTK_HPANED_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HPANED, GtkHPanedClass)
type GtkHPaned as _GtkHPaned
type GtkHPanedClass as _GtkHPanedClass

type _GtkHPaned
	paned as GtkPaned
end type

type _GtkHPanedClass
	parent_class as GtkPanedClass
end type

declare function gtk_hpaned_get_type() as GType
declare function gtk_hpaned_new() as GtkWidget ptr
#define __GTK_HRULER_H__
#define __GTK_RULER_H__
#define GTK_TYPE_RULER gtk_ruler_get_type()
#define GTK_RULER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RULER, GtkRuler)
#define GTK_RULER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RULER, GtkRulerClass)
#define GTK_IS_RULER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RULER)
#define GTK_IS_RULER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RULER)
#define GTK_RULER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RULER, GtkRulerClass)

type GtkRuler as _GtkRuler
type GtkRulerClass as _GtkRulerClass
type GtkRulerMetric as _GtkRulerMetric

type _GtkRuler
	widget as GtkWidget
	backing_store as GdkPixmap ptr
	non_gr_exp_gc as GdkGC ptr
	metric as GtkRulerMetric ptr
	xsrc as gint
	ysrc as gint
	slider_size as gint
	lower as gdouble
	upper as gdouble
	position as gdouble
	max_size as gdouble
end type

type _GtkRulerClass
	parent_class as GtkWidgetClass
	draw_ticks as sub(byval ruler as GtkRuler ptr)
	draw_pos as sub(byval ruler as GtkRuler ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkRulerMetric
	metric_name as gchar ptr
	abbrev as gchar ptr
	pixels_per_unit as gdouble
	ruler_scale(0 to 9) as gdouble
	subdivide(0 to 4) as gint
end type

declare function gtk_ruler_get_type() as GType
declare sub gtk_ruler_set_metric(byval ruler as GtkRuler ptr, byval metric as GtkMetricType)
declare function gtk_ruler_get_metric(byval ruler as GtkRuler ptr) as GtkMetricType
declare sub gtk_ruler_set_range(byval ruler as GtkRuler ptr, byval lower as gdouble, byval upper as gdouble, byval position as gdouble, byval max_size as gdouble)
declare sub gtk_ruler_get_range(byval ruler as GtkRuler ptr, byval lower as gdouble ptr, byval upper as gdouble ptr, byval position as gdouble ptr, byval max_size as gdouble ptr)
declare sub gtk_ruler_draw_ticks(byval ruler as GtkRuler ptr)
declare sub gtk_ruler_draw_pos(byval ruler as GtkRuler ptr)

#define GTK_TYPE_HRULER gtk_hruler_get_type()
#define GTK_HRULER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HRULER, GtkHRuler)
#define GTK_HRULER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HRULER, GtkHRulerClass)
#define GTK_IS_HRULER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HRULER)
#define GTK_IS_HRULER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HRULER)
#define GTK_HRULER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HRULER, GtkHRulerClass)
type GtkHRuler as _GtkHRuler
type GtkHRulerClass as _GtkHRulerClass

type _GtkHRuler
	ruler as GtkRuler
end type

type _GtkHRulerClass
	parent_class as GtkRulerClass
end type

declare function gtk_hruler_get_type() as GType
declare function gtk_hruler_new() as GtkWidget ptr
#define __GTK_HSCALE_H__
#define __GTK_SCALE_H__
#define __GTK_RANGE_H__
#define GTK_TYPE_RANGE gtk_range_get_type()
#define GTK_RANGE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RANGE, GtkRange)
#define GTK_RANGE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RANGE, GtkRangeClass)
#define GTK_IS_RANGE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RANGE)
#define GTK_IS_RANGE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RANGE)
#define GTK_RANGE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RANGE, GtkRangeClass)

type GtkRangeLayout as _GtkRangeLayout
type GtkRangeStepTimer as _GtkRangeStepTimer
type GtkRange as _GtkRange
type GtkRangeClass as _GtkRangeClass

type _GtkRange
	widget as GtkWidget
	adjustment as GtkAdjustment ptr
	update_policy as GtkUpdateType
	inverted : 1 as guint
	flippable : 1 as guint
	has_stepper_a : 1 as guint
	has_stepper_b : 1 as guint
	has_stepper_c : 1 as guint
	has_stepper_d : 1 as guint
	need_recalc : 1 as guint
	slider_size_fixed : 1 as guint
	min_slider_size as gint
	orientation as GtkOrientation
	range_rect as GdkRectangle
	slider_start as gint
	slider_end as gint
	round_digits as gint
	trough_click_forward : 1 as guint
	update_pending : 1 as guint
	layout as GtkRangeLayout ptr
	timer as GtkRangeStepTimer ptr
	slide_initial_slider_position as gint
	slide_initial_coordinate as gint
	update_timeout_id as guint
	event_window as GdkWindow ptr
end type

type _GtkRangeClass
	parent_class as GtkWidgetClass
	slider_detail as gchar ptr
	stepper_detail as gchar ptr
	value_changed as sub(byval range as GtkRange ptr)
	adjust_bounds as sub(byval range as GtkRange ptr, byval new_value as gdouble)
	move_slider as sub(byval range as GtkRange ptr, byval scroll as GtkScrollType)
	get_range_border as sub(byval range as GtkRange ptr, byval border_ as GtkBorder ptr)
	change_value as function(byval range as GtkRange ptr, byval scroll as GtkScrollType, byval new_value as gdouble) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_range_get_type() as GType
declare sub gtk_range_set_update_policy(byval range as GtkRange ptr, byval policy as GtkUpdateType)
declare function gtk_range_get_update_policy(byval range as GtkRange ptr) as GtkUpdateType
declare sub gtk_range_set_adjustment(byval range as GtkRange ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_range_get_adjustment(byval range as GtkRange ptr) as GtkAdjustment ptr
declare sub gtk_range_set_inverted(byval range as GtkRange ptr, byval setting as gboolean)
declare function gtk_range_get_inverted(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_flippable(byval range as GtkRange ptr, byval flippable as gboolean)
declare function gtk_range_get_flippable(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_slider_size_fixed(byval range as GtkRange ptr, byval size_fixed as gboolean)
declare function gtk_range_get_slider_size_fixed(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_min_slider_size(byval range as GtkRange ptr, byval min_size as gboolean)
declare function gtk_range_get_min_slider_size(byval range as GtkRange ptr) as gint
declare sub gtk_range_get_range_rect(byval range as GtkRange ptr, byval range_rect as GdkRectangle ptr)
declare sub gtk_range_get_slider_range(byval range as GtkRange ptr, byval slider_start as gint ptr, byval slider_end as gint ptr)
declare sub gtk_range_set_lower_stepper_sensitivity(byval range as GtkRange ptr, byval sensitivity as GtkSensitivityType)
declare function gtk_range_get_lower_stepper_sensitivity(byval range as GtkRange ptr) as GtkSensitivityType
declare sub gtk_range_set_upper_stepper_sensitivity(byval range as GtkRange ptr, byval sensitivity as GtkSensitivityType)
declare function gtk_range_get_upper_stepper_sensitivity(byval range as GtkRange ptr) as GtkSensitivityType
declare sub gtk_range_set_increments(byval range as GtkRange ptr, byval step as gdouble, byval page as gdouble)
declare sub gtk_range_set_range(byval range as GtkRange ptr, byval min as gdouble, byval max as gdouble)
declare sub gtk_range_set_value(byval range as GtkRange ptr, byval value as gdouble)
declare function gtk_range_get_value(byval range as GtkRange ptr) as gdouble
declare sub gtk_range_set_show_fill_level(byval range as GtkRange ptr, byval show_fill_level as gboolean)
declare function gtk_range_get_show_fill_level(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_restrict_to_fill_level(byval range as GtkRange ptr, byval restrict_to_fill_level as gboolean)
declare function gtk_range_get_restrict_to_fill_level(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_fill_level(byval range as GtkRange ptr, byval fill_level as gdouble)
declare function gtk_range_get_fill_level(byval range as GtkRange ptr) as gdouble
declare sub gtk_range_set_round_digits(byval range as GtkRange ptr, byval round_digits as gint)
declare function gtk_range_get_round_digits(byval range as GtkRange ptr) as gint
declare function _gtk_range_get_wheel_delta(byval range as GtkRange ptr, byval direction as GdkScrollDirection) as gdouble
declare sub _gtk_range_set_stop_values(byval range as GtkRange ptr, byval values as gdouble ptr, byval n_values as gint)
declare function _gtk_range_get_stop_positions(byval range as GtkRange ptr, byval values as gint ptr ptr) as gint

#define GTK_TYPE_SCALE gtk_scale_get_type()
#define GTK_SCALE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCALE, GtkScale)
#define GTK_SCALE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SCALE, GtkScaleClass)
#define GTK_IS_SCALE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCALE)
#define GTK_IS_SCALE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SCALE)
#define GTK_SCALE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SCALE, GtkScaleClass)
type GtkScale as _GtkScale
type GtkScaleClass as _GtkScaleClass

type _GtkScale
	range as GtkRange
	digits as gint
	draw_value : 1 as guint
	value_pos : 2 as guint
end type

type _GtkScaleClass
	parent_class as GtkRangeClass
	format_value as function(byval scale as GtkScale ptr, byval value as gdouble) as gchar ptr
	draw_value as sub(byval scale as GtkScale ptr)
	get_layout_offsets as sub(byval scale as GtkScale ptr, byval x as gint ptr, byval y as gint ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_scale_get_type() as GType
declare sub gtk_scale_set_digits(byval scale as GtkScale ptr, byval digits as gint)
declare function gtk_scale_get_digits(byval scale as GtkScale ptr) as gint
declare sub gtk_scale_set_draw_value(byval scale as GtkScale ptr, byval draw_value as gboolean)
declare function gtk_scale_get_draw_value(byval scale as GtkScale ptr) as gboolean
declare sub gtk_scale_set_value_pos(byval scale as GtkScale ptr, byval pos as GtkPositionType)
declare function gtk_scale_get_value_pos(byval scale as GtkScale ptr) as GtkPositionType
declare function gtk_scale_get_layout(byval scale as GtkScale ptr) as PangoLayout ptr
declare sub gtk_scale_get_layout_offsets(byval scale as GtkScale ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gtk_scale_add_mark(byval scale as GtkScale ptr, byval value as gdouble, byval position as GtkPositionType, byval markup as const gchar ptr)
declare sub gtk_scale_clear_marks(byval scale as GtkScale ptr)
declare sub _gtk_scale_clear_layout(byval scale as GtkScale ptr)
declare sub _gtk_scale_get_value_size(byval scale as GtkScale ptr, byval width as gint ptr, byval height as gint ptr)
declare function _gtk_scale_format_value(byval scale as GtkScale ptr, byval value as gdouble) as gchar ptr

#define GTK_TYPE_HSCALE gtk_hscale_get_type()
#define GTK_HSCALE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HSCALE, GtkHScale)
#define GTK_HSCALE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HSCALE, GtkHScaleClass)
#define GTK_IS_HSCALE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HSCALE)
#define GTK_IS_HSCALE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HSCALE)
#define GTK_HSCALE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HSCALE, GtkHScaleClass)
type GtkHScale as _GtkHScale
type GtkHScaleClass as _GtkHScaleClass

type _GtkHScale
	scale as GtkScale
end type

type _GtkHScaleClass
	parent_class as GtkScaleClass
end type

declare function gtk_hscale_get_type() as GType
declare function gtk_hscale_new(byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_hscale_new_with_range(byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr

#define __GTK_HSCROLLBAR_H__
#define __GTK_SCROLLBAR_H__
#define GTK_TYPE_SCROLLBAR gtk_scrollbar_get_type()
#define GTK_SCROLLBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCROLLBAR, GtkScrollbar)
#define GTK_SCROLLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SCROLLBAR, GtkScrollbarClass)
#define GTK_IS_SCROLLBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCROLLBAR)
#define GTK_IS_SCROLLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SCROLLBAR)
#define GTK_SCROLLBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SCROLLBAR, GtkScrollbarClass)
type GtkScrollbar as _GtkScrollbar
type GtkScrollbarClass as _GtkScrollbarClass

type _GtkScrollbar
	range as GtkRange
end type

type _GtkScrollbarClass
	parent_class as GtkRangeClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_scrollbar_get_type() as GType
#define GTK_TYPE_HSCROLLBAR gtk_hscrollbar_get_type()
#define GTK_HSCROLLBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HSCROLLBAR, GtkHScrollbar)
#define GTK_HSCROLLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HSCROLLBAR, GtkHScrollbarClass)
#define GTK_IS_HSCROLLBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HSCROLLBAR)
#define GTK_IS_HSCROLLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HSCROLLBAR)
#define GTK_HSCROLLBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HSCROLLBAR, GtkHScrollbarClass)
type GtkHScrollbar as _GtkHScrollbar
type GtkHScrollbarClass as _GtkHScrollbarClass

type _GtkHScrollbar
	scrollbar as GtkScrollbar
end type

type _GtkHScrollbarClass
	parent_class as GtkScrollbarClass
end type

declare function gtk_hscrollbar_get_type() as GType
declare function gtk_hscrollbar_new(byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
#define __GTK_HSEPARATOR_H__
#define __GTK_SEPARATOR_H__
#define GTK_TYPE_SEPARATOR gtk_separator_get_type()
#define GTK_SEPARATOR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SEPARATOR, GtkSeparator)
#define GTK_SEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SEPARATOR, GtkSeparatorClass)
#define GTK_IS_SEPARATOR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SEPARATOR)
#define GTK_IS_SEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SEPARATOR)
#define GTK_SEPARATOR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEPARATOR, GtkSeparatorClass)
type GtkSeparator as _GtkSeparator
type GtkSeparatorClass as _GtkSeparatorClass

type _GtkSeparator
	widget as GtkWidget
end type

type _GtkSeparatorClass
	parent_class as GtkWidgetClass
end type

declare function gtk_separator_get_type() as GType
#define GTK_TYPE_HSEPARATOR gtk_hseparator_get_type()
#define GTK_HSEPARATOR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HSEPARATOR, GtkHSeparator)
#define GTK_HSEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HSEPARATOR, GtkHSeparatorClass)
#define GTK_IS_HSEPARATOR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HSEPARATOR)
#define GTK_IS_HSEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HSEPARATOR)
#define GTK_HSEPARATOR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HSEPARATOR, GtkHSeparatorClass)
type GtkHSeparator as _GtkHSeparator
type GtkHSeparatorClass as _GtkHSeparatorClass

type _GtkHSeparator
	separator as GtkSeparator
end type

type _GtkHSeparatorClass
	parent_class as GtkSeparatorClass
end type

declare function gtk_hseparator_get_type() as GType
declare function gtk_hseparator_new() as GtkWidget ptr
#define __GTK_HSV_H__
#define GTK_TYPE_HSV gtk_hsv_get_type()
#define GTK_HSV(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HSV, GtkHSV)
#define GTK_HSV_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HSV, GtkHSVClass)
#define GTK_IS_HSV(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HSV)
#define GTK_IS_HSV_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HSV)
#define GTK_HSV_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HSV, GtkHSVClass)
type GtkHSV as _GtkHSV
type GtkHSVClass as _GtkHSVClass

type _GtkHSV
	parent_instance as GtkWidget
	priv as gpointer
end type

type _GtkHSVClass
	parent_class as GtkWidgetClass
	changed as sub(byval hsv as GtkHSV ptr)
	move as sub(byval hsv as GtkHSV ptr, byval type as GtkDirectionType)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_hsv_get_type() as GType
declare function gtk_hsv_new() as GtkWidget ptr
declare sub gtk_hsv_set_color(byval hsv as GtkHSV ptr, byval h as double, byval s as double, byval v as double)
declare sub gtk_hsv_get_color(byval hsv as GtkHSV ptr, byval h as gdouble ptr, byval s as gdouble ptr, byval v as gdouble ptr)
declare sub gtk_hsv_set_metrics(byval hsv as GtkHSV ptr, byval size as gint, byval ring_width as gint)
declare sub gtk_hsv_get_metrics(byval hsv as GtkHSV ptr, byval size as gint ptr, byval ring_width as gint ptr)
declare function gtk_hsv_is_adjusting(byval hsv as GtkHSV ptr) as gboolean
declare sub gtk_hsv_to_rgb(byval h as gdouble, byval s as gdouble, byval v as gdouble, byval r as gdouble ptr, byval g as gdouble ptr, byval b as gdouble ptr)
declare sub gtk_rgb_to_hsv(byval r as gdouble, byval g as gdouble, byval b as gdouble, byval h as gdouble ptr, byval s as gdouble ptr, byval v as gdouble ptr)
#define __GTK_ICON_FACTORY_H__
type GtkIconFactoryClass as _GtkIconFactoryClass

#define GTK_TYPE_ICON_FACTORY gtk_icon_factory_get_type()
#define GTK_ICON_FACTORY(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_ICON_FACTORY, GtkIconFactory)
#define GTK_ICON_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass)
#define GTK_IS_ICON_FACTORY(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_ICON_FACTORY)
#define GTK_IS_ICON_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ICON_FACTORY)
#define GTK_ICON_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass)
#define GTK_TYPE_ICON_SET gtk_icon_set_get_type()
#define GTK_TYPE_ICON_SOURCE gtk_icon_source_get_type()

type _GtkIconFactory
	parent_instance as GObject
	icons as GHashTable ptr
end type

type _GtkIconFactoryClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_icon_factory_get_type() as GType
declare function gtk_icon_factory_new() as GtkIconFactory ptr
declare sub gtk_icon_factory_add(byval factory as GtkIconFactory ptr, byval stock_id as const gchar ptr, byval icon_set as GtkIconSet ptr)
declare function gtk_icon_factory_lookup(byval factory as GtkIconFactory ptr, byval stock_id as const gchar ptr) as GtkIconSet ptr
declare sub gtk_icon_factory_add_default(byval factory as GtkIconFactory ptr)
declare sub gtk_icon_factory_remove_default(byval factory as GtkIconFactory ptr)
declare function gtk_icon_factory_lookup_default(byval stock_id as const gchar ptr) as GtkIconSet ptr
declare function gtk_icon_size_lookup(byval size as GtkIconSize, byval width as gint ptr, byval height as gint ptr) as gboolean
declare function gtk_icon_size_lookup_for_settings(byval settings as GtkSettings ptr, byval size as GtkIconSize, byval width as gint ptr, byval height as gint ptr) as gboolean
declare function gtk_icon_size_register(byval name as const gchar ptr, byval width as gint, byval height as gint) as GtkIconSize
declare sub gtk_icon_size_register_alias(byval alias as const gchar ptr, byval target as GtkIconSize)
declare function gtk_icon_size_from_name(byval name as const gchar ptr) as GtkIconSize
declare function gtk_icon_size_get_name(byval size as GtkIconSize) as const gchar ptr
declare function gtk_icon_set_get_type() as GType
declare function gtk_icon_set_new() as GtkIconSet ptr
declare function gtk_icon_set_new_from_pixbuf(byval pixbuf as GdkPixbuf ptr) as GtkIconSet ptr
declare function gtk_icon_set_ref(byval icon_set as GtkIconSet ptr) as GtkIconSet ptr
declare sub gtk_icon_set_unref(byval icon_set as GtkIconSet ptr)
declare function gtk_icon_set_copy(byval icon_set as GtkIconSet ptr) as GtkIconSet ptr
declare function gtk_icon_set_render_icon(byval icon_set as GtkIconSet ptr, byval style as GtkStyle ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as const zstring ptr) as GdkPixbuf ptr
declare sub gtk_icon_set_add_source(byval icon_set as GtkIconSet ptr, byval source as const GtkIconSource ptr)
declare sub gtk_icon_set_get_sizes(byval icon_set as GtkIconSet ptr, byval sizes as GtkIconSize ptr ptr, byval n_sizes as gint ptr)
declare function gtk_icon_source_get_type() as GType
declare function gtk_icon_source_new() as GtkIconSource ptr
declare function gtk_icon_source_copy(byval source as const GtkIconSource ptr) as GtkIconSource ptr
declare sub gtk_icon_source_free(byval source as GtkIconSource ptr)

#ifdef __FB_UNIX__
	declare sub gtk_icon_source_set_filename(byval source as GtkIconSource ptr, byval filename as const gchar ptr)
#else
	declare sub gtk_icon_source_set_filename_utf8(byval source as GtkIconSource ptr, byval filename as const gchar ptr)
	declare sub gtk_icon_source_set_filename alias "gtk_icon_source_set_filename_utf8"(byval source as GtkIconSource ptr, byval filename as const gchar ptr)
#endif

declare sub gtk_icon_source_set_icon_name(byval source as GtkIconSource ptr, byval icon_name as const gchar ptr)
declare sub gtk_icon_source_set_pixbuf(byval source as GtkIconSource ptr, byval pixbuf as GdkPixbuf ptr)

#ifdef __FB_UNIX__
	declare function gtk_icon_source_get_filename(byval source as const GtkIconSource ptr) as const gchar ptr
#else
	declare function gtk_icon_source_get_filename_utf8(byval source as const GtkIconSource ptr) as const gchar ptr
	declare function gtk_icon_source_get_filename alias "gtk_icon_source_get_filename_utf8"(byval source as const GtkIconSource ptr) as const gchar ptr
#endif

declare function gtk_icon_source_get_icon_name(byval source as const GtkIconSource ptr) as const gchar ptr
declare function gtk_icon_source_get_pixbuf(byval source as const GtkIconSource ptr) as GdkPixbuf ptr
declare sub gtk_icon_source_set_direction_wildcarded(byval source as GtkIconSource ptr, byval setting as gboolean)
declare sub gtk_icon_source_set_state_wildcarded(byval source as GtkIconSource ptr, byval setting as gboolean)
declare sub gtk_icon_source_set_size_wildcarded(byval source as GtkIconSource ptr, byval setting as gboolean)
declare function gtk_icon_source_get_size_wildcarded(byval source as const GtkIconSource ptr) as gboolean
declare function gtk_icon_source_get_state_wildcarded(byval source as const GtkIconSource ptr) as gboolean
declare function gtk_icon_source_get_direction_wildcarded(byval source as const GtkIconSource ptr) as gboolean
declare sub gtk_icon_source_set_direction(byval source as GtkIconSource ptr, byval direction as GtkTextDirection)
declare sub gtk_icon_source_set_state(byval source as GtkIconSource ptr, byval state as GtkStateType)
declare sub gtk_icon_source_set_size(byval source as GtkIconSource ptr, byval size as GtkIconSize)
declare function gtk_icon_source_get_direction(byval source as const GtkIconSource ptr) as GtkTextDirection
declare function gtk_icon_source_get_state(byval source as const GtkIconSource ptr) as GtkStateType
declare function gtk_icon_source_get_size(byval source as const GtkIconSource ptr) as GtkIconSize
declare sub _gtk_icon_set_invalidate_caches()
declare function _gtk_icon_factory_list_ids() as GList ptr
declare sub _gtk_icon_factory_ensure_default_icons()

#define __GTK_ICON_THEME_H__
#define GTK_TYPE_ICON_INFO gtk_icon_info_get_type()
#define GTK_TYPE_ICON_THEME gtk_icon_theme_get_type()
#define GTK_ICON_THEME(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ICON_THEME, GtkIconTheme)
#define GTK_ICON_THEME_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ICON_THEME, GtkIconThemeClass)
#define GTK_IS_ICON_THEME(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ICON_THEME)
#define GTK_IS_ICON_THEME_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ICON_THEME)
#define GTK_ICON_THEME_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ICON_THEME, GtkIconThemeClass)

type GtkIconInfo as _GtkIconInfo
type GtkIconTheme as _GtkIconTheme
type GtkIconThemeClass as _GtkIconThemeClass
type GtkIconThemePrivate as _GtkIconThemePrivate

type _GtkIconTheme
	parent_instance as GObject
	priv as GtkIconThemePrivate ptr
end type

type _GtkIconThemeClass
	parent_class as GObjectClass
	changed as sub(byval icon_theme as GtkIconTheme ptr)
end type

type GtkIconLookupFlags as long
enum
	GTK_ICON_LOOKUP_NO_SVG = 1 shl 0
	GTK_ICON_LOOKUP_FORCE_SVG = 1 shl 1
	GTK_ICON_LOOKUP_USE_BUILTIN = 1 shl 2
	GTK_ICON_LOOKUP_GENERIC_FALLBACK = 1 shl 3
	GTK_ICON_LOOKUP_FORCE_SIZE = 1 shl 4
end enum

#define GTK_ICON_THEME_ERROR gtk_icon_theme_error_quark()

type GtkIconThemeError as long
enum
	GTK_ICON_THEME_NOT_FOUND
	GTK_ICON_THEME_FAILED
end enum

declare function gtk_icon_theme_error_quark() as GQuark
declare function gtk_icon_theme_get_type() as GType
declare function gtk_icon_theme_new() as GtkIconTheme ptr
declare function gtk_icon_theme_get_default() as GtkIconTheme ptr
declare function gtk_icon_theme_get_for_screen(byval screen as GdkScreen ptr) as GtkIconTheme ptr
declare sub gtk_icon_theme_set_screen(byval icon_theme as GtkIconTheme ptr, byval screen as GdkScreen ptr)

#ifdef __FB_UNIX__
	declare sub gtk_icon_theme_set_search_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr ptr, byval n_elements as gint)
	declare sub gtk_icon_theme_get_search_path(byval icon_theme as GtkIconTheme ptr, byval path as gchar ptr ptr ptr, byval n_elements as gint ptr)
	declare sub gtk_icon_theme_append_search_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
	declare sub gtk_icon_theme_prepend_search_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
#else
	declare sub gtk_icon_theme_set_search_path_utf8(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr ptr, byval n_elements as gint)
	declare sub gtk_icon_theme_set_search_path alias "gtk_icon_theme_set_search_path_utf8"(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr ptr, byval n_elements as gint)
	declare sub gtk_icon_theme_get_search_path_utf8(byval icon_theme as GtkIconTheme ptr, byval path as gchar ptr ptr ptr, byval n_elements as gint ptr)
	declare sub gtk_icon_theme_get_search_path alias "gtk_icon_theme_get_search_path_utf8"(byval icon_theme as GtkIconTheme ptr, byval path as gchar ptr ptr ptr, byval n_elements as gint ptr)
	declare sub gtk_icon_theme_append_search_path_utf8(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
	declare sub gtk_icon_theme_append_search_path alias "gtk_icon_theme_append_search_path_utf8"(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
	declare sub gtk_icon_theme_prepend_search_path_utf8(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
	declare sub gtk_icon_theme_prepend_search_path alias "gtk_icon_theme_prepend_search_path_utf8"(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
#endif

declare sub gtk_icon_theme_set_custom_theme(byval icon_theme as GtkIconTheme ptr, byval theme_name as const gchar ptr)
declare function gtk_icon_theme_has_icon(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr) as gboolean
declare function gtk_icon_theme_get_icon_sizes(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr) as gint ptr
declare function gtk_icon_theme_lookup_icon(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_choose_icon(byval icon_theme as GtkIconTheme ptr, byval icon_names as const gchar ptr ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_load_icon(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval flags as GtkIconLookupFlags, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_theme_lookup_by_gicon(byval icon_theme as GtkIconTheme ptr, byval icon as GIcon ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_list_icons(byval icon_theme as GtkIconTheme ptr, byval context as const gchar ptr) as GList ptr
declare function gtk_icon_theme_list_contexts(byval icon_theme as GtkIconTheme ptr) as GList ptr
declare function gtk_icon_theme_get_example_icon_name(byval icon_theme as GtkIconTheme ptr) as zstring ptr
declare function gtk_icon_theme_rescan_if_needed(byval icon_theme as GtkIconTheme ptr) as gboolean
declare sub gtk_icon_theme_add_builtin_icon(byval icon_name as const gchar ptr, byval size as gint, byval pixbuf as GdkPixbuf ptr)
declare function gtk_icon_info_get_type() as GType
declare function gtk_icon_info_copy(byval icon_info as GtkIconInfo ptr) as GtkIconInfo ptr
declare sub gtk_icon_info_free(byval icon_info as GtkIconInfo ptr)
declare function gtk_icon_info_new_for_pixbuf(byval icon_theme as GtkIconTheme ptr, byval pixbuf as GdkPixbuf ptr) as GtkIconInfo ptr
declare function gtk_icon_info_get_base_size(byval icon_info as GtkIconInfo ptr) as gint

#ifdef __FB_UNIX__
	declare function gtk_icon_info_get_filename(byval icon_info as GtkIconInfo ptr) as const gchar ptr
#else
	declare function gtk_icon_info_get_filename_utf8(byval icon_info as GtkIconInfo ptr) as const gchar ptr
	declare function gtk_icon_info_get_filename alias "gtk_icon_info_get_filename_utf8"(byval icon_info as GtkIconInfo ptr) as const gchar ptr
#endif

declare function gtk_icon_info_get_builtin_pixbuf(byval icon_info as GtkIconInfo ptr) as GdkPixbuf ptr
declare function gtk_icon_info_load_icon(byval icon_info as GtkIconInfo ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gtk_icon_info_set_raw_coordinates(byval icon_info as GtkIconInfo ptr, byval raw_coordinates as gboolean)
declare function gtk_icon_info_get_embedded_rect(byval icon_info as GtkIconInfo ptr, byval rectangle as GdkRectangle ptr) as gboolean
declare function gtk_icon_info_get_attach_points(byval icon_info as GtkIconInfo ptr, byval points as GdkPoint ptr ptr, byval n_points as gint ptr) as gboolean
declare function gtk_icon_info_get_display_name(byval icon_info as GtkIconInfo ptr) as const gchar ptr
declare sub _gtk_icon_theme_check_reload(byval display as GdkDisplay ptr)
declare sub _gtk_icon_theme_ensure_builtin_cache()

#define __GTK_ICON_VIEW_H__
#define __GTK_TOOLTIP_H__
#define GTK_TYPE_TOOLTIP gtk_tooltip_get_type()
#define GTK_TOOLTIP(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOOLTIP, GtkTooltip)
#define GTK_IS_TOOLTIP(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOOLTIP)

declare function gtk_tooltip_get_type() as GType
declare sub gtk_tooltip_set_markup(byval tooltip as GtkTooltip ptr, byval markup as const gchar ptr)
declare sub gtk_tooltip_set_text(byval tooltip as GtkTooltip ptr, byval text as const gchar ptr)
declare sub gtk_tooltip_set_icon(byval tooltip as GtkTooltip ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_tooltip_set_icon_from_stock(byval tooltip as GtkTooltip ptr, byval stock_id as const gchar ptr, byval size as GtkIconSize)
declare sub gtk_tooltip_set_icon_from_icon_name(byval tooltip as GtkTooltip ptr, byval icon_name as const gchar ptr, byval size as GtkIconSize)
declare sub gtk_tooltip_set_icon_from_gicon(byval tooltip as GtkTooltip ptr, byval gicon as GIcon ptr, byval size as GtkIconSize)
declare sub gtk_tooltip_set_custom(byval tooltip as GtkTooltip ptr, byval custom_widget as GtkWidget ptr)
declare sub gtk_tooltip_set_tip_area(byval tooltip as GtkTooltip ptr, byval rect as const GdkRectangle ptr)
declare sub gtk_tooltip_trigger_tooltip_query(byval display as GdkDisplay ptr)
declare sub _gtk_tooltip_focus_in(byval widget as GtkWidget ptr)
declare sub _gtk_tooltip_focus_out(byval widget as GtkWidget ptr)
declare sub _gtk_tooltip_toggle_keyboard_mode(byval widget as GtkWidget ptr)
declare sub _gtk_tooltip_handle_event(byval event as GdkEvent ptr)
declare sub _gtk_tooltip_hide(byval widget as GtkWidget ptr)
declare function _gtk_widget_find_at_coords(byval window as GdkWindow ptr, byval window_x as gint, byval window_y as gint, byval widget_x as gint ptr, byval widget_y as gint ptr) as GtkWidget ptr

#define GTK_TYPE_ICON_VIEW gtk_icon_view_get_type()
#define GTK_ICON_VIEW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ICON_VIEW, GtkIconView)
#define GTK_ICON_VIEW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ICON_VIEW, GtkIconViewClass)
#define GTK_IS_ICON_VIEW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ICON_VIEW)
#define GTK_IS_ICON_VIEW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ICON_VIEW)
#define GTK_ICON_VIEW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ICON_VIEW, GtkIconViewClass)

type GtkIconView as _GtkIconView
type GtkIconViewClass as _GtkIconViewClass
type GtkIconViewPrivate as _GtkIconViewPrivate
type GtkIconViewForeachFunc as sub(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr, byval data as gpointer)

type GtkIconViewDropPosition as long
enum
	GTK_ICON_VIEW_NO_DROP
	GTK_ICON_VIEW_DROP_INTO
	GTK_ICON_VIEW_DROP_LEFT
	GTK_ICON_VIEW_DROP_RIGHT
	GTK_ICON_VIEW_DROP_ABOVE
	GTK_ICON_VIEW_DROP_BELOW
end enum

type _GtkIconView
	parent as GtkContainer
	priv as GtkIconViewPrivate ptr
end type

type _GtkIconViewClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub(byval icon_view as GtkIconView ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
	item_activated as sub(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
	selection_changed as sub(byval icon_view as GtkIconView ptr)
	select_all as sub(byval icon_view as GtkIconView ptr)
	unselect_all as sub(byval icon_view as GtkIconView ptr)
	select_cursor_item as sub(byval icon_view as GtkIconView ptr)
	toggle_cursor_item as sub(byval icon_view as GtkIconView ptr)
	move_cursor as function(byval icon_view as GtkIconView ptr, byval step as GtkMovementStep, byval count as gint) as gboolean
	activate_cursor_item as function(byval icon_view as GtkIconView ptr) as gboolean
end type

declare function gtk_icon_view_get_type() as GType
declare function gtk_icon_view_new() as GtkWidget ptr
declare function gtk_icon_view_new_with_model(byval model as GtkTreeModel ptr) as GtkWidget ptr
declare sub gtk_icon_view_set_model(byval icon_view as GtkIconView ptr, byval model as GtkTreeModel ptr)
declare function gtk_icon_view_get_model(byval icon_view as GtkIconView ptr) as GtkTreeModel ptr
declare sub gtk_icon_view_set_text_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_text_column(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_markup_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_markup_column(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_pixbuf_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_pixbuf_column(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_orientation(byval icon_view as GtkIconView ptr, byval orientation as GtkOrientation)
declare function gtk_icon_view_get_orientation(byval icon_view as GtkIconView ptr) as GtkOrientation
declare sub gtk_icon_view_set_item_orientation(byval icon_view as GtkIconView ptr, byval orientation as GtkOrientation)
declare function gtk_icon_view_get_item_orientation(byval icon_view as GtkIconView ptr) as GtkOrientation
declare sub gtk_icon_view_set_columns(byval icon_view as GtkIconView ptr, byval columns as gint)
declare function gtk_icon_view_get_columns(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_item_width(byval icon_view as GtkIconView ptr, byval item_width as gint)
declare function gtk_icon_view_get_item_width(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_spacing(byval icon_view as GtkIconView ptr, byval spacing as gint)
declare function gtk_icon_view_get_spacing(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_row_spacing(byval icon_view as GtkIconView ptr, byval row_spacing as gint)
declare function gtk_icon_view_get_row_spacing(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_column_spacing(byval icon_view as GtkIconView ptr, byval column_spacing as gint)
declare function gtk_icon_view_get_column_spacing(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_margin(byval icon_view as GtkIconView ptr, byval margin as gint)
declare function gtk_icon_view_get_margin(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_item_padding(byval icon_view as GtkIconView ptr, byval item_padding as gint)
declare function gtk_icon_view_get_item_padding(byval icon_view as GtkIconView ptr) as gint
declare function gtk_icon_view_get_path_at_pos(byval icon_view as GtkIconView ptr, byval x as gint, byval y as gint) as GtkTreePath ptr
declare function gtk_icon_view_get_item_at_pos(byval icon_view as GtkIconView ptr, byval x as gint, byval y as gint, byval path as GtkTreePath ptr ptr, byval cell as GtkCellRenderer ptr ptr) as gboolean
declare function gtk_icon_view_get_visible_range(byval icon_view as GtkIconView ptr, byval start_path as GtkTreePath ptr ptr, byval end_path as GtkTreePath ptr ptr) as gboolean
declare sub gtk_icon_view_selected_foreach(byval icon_view as GtkIconView ptr, byval func as GtkIconViewForeachFunc, byval data as gpointer)
declare sub gtk_icon_view_set_selection_mode(byval icon_view as GtkIconView ptr, byval mode as GtkSelectionMode)
declare function gtk_icon_view_get_selection_mode(byval icon_view as GtkIconView ptr) as GtkSelectionMode
declare sub gtk_icon_view_select_path(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
declare sub gtk_icon_view_unselect_path(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
declare function gtk_icon_view_path_is_selected(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_icon_view_get_item_row(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr) as gint
declare function gtk_icon_view_get_item_column(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr) as gint
declare function gtk_icon_view_get_selected_items(byval icon_view as GtkIconView ptr) as GList ptr
declare sub gtk_icon_view_select_all(byval icon_view as GtkIconView ptr)
declare sub gtk_icon_view_unselect_all(byval icon_view as GtkIconView ptr)
declare sub gtk_icon_view_item_activated(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
declare sub gtk_icon_view_set_cursor(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr, byval cell as GtkCellRenderer ptr, byval start_editing as gboolean)
declare function gtk_icon_view_get_cursor(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr ptr, byval cell as GtkCellRenderer ptr ptr) as gboolean
declare sub gtk_icon_view_scroll_to_path(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr, byval use_align as gboolean, byval row_align as gfloat, byval col_align as gfloat)
declare sub gtk_icon_view_enable_model_drag_source(byval icon_view as GtkIconView ptr, byval start_button_mask as GdkModifierType, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_icon_view_enable_model_drag_dest(byval icon_view as GtkIconView ptr, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_icon_view_unset_model_drag_source(byval icon_view as GtkIconView ptr)
declare sub gtk_icon_view_unset_model_drag_dest(byval icon_view as GtkIconView ptr)
declare sub gtk_icon_view_set_reorderable(byval icon_view as GtkIconView ptr, byval reorderable as gboolean)
declare function gtk_icon_view_get_reorderable(byval icon_view as GtkIconView ptr) as gboolean
declare sub gtk_icon_view_set_drag_dest_item(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr, byval pos as GtkIconViewDropPosition)
declare sub gtk_icon_view_get_drag_dest_item(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr ptr, byval pos as GtkIconViewDropPosition ptr)
declare function gtk_icon_view_get_dest_item_at_pos(byval icon_view as GtkIconView ptr, byval drag_x as gint, byval drag_y as gint, byval path as GtkTreePath ptr ptr, byval pos as GtkIconViewDropPosition ptr) as gboolean
declare function gtk_icon_view_create_drag_icon(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr) as GdkPixmap ptr
declare sub gtk_icon_view_convert_widget_to_bin_window_coords(byval icon_view as GtkIconView ptr, byval wx as gint, byval wy as gint, byval bx as gint ptr, byval by as gint ptr)
declare sub gtk_icon_view_set_tooltip_item(byval icon_view as GtkIconView ptr, byval tooltip as GtkTooltip ptr, byval path as GtkTreePath ptr)
declare sub gtk_icon_view_set_tooltip_cell(byval icon_view as GtkIconView ptr, byval tooltip as GtkTooltip ptr, byval path as GtkTreePath ptr, byval cell as GtkCellRenderer ptr)
declare function gtk_icon_view_get_tooltip_context(byval icon_view as GtkIconView ptr, byval x as gint ptr, byval y as gint ptr, byval keyboard_tip as gboolean, byval model as GtkTreeModel ptr ptr, byval path as GtkTreePath ptr ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_icon_view_set_tooltip_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_tooltip_column(byval icon_view as GtkIconView ptr) as gint

#define __GTK_IMAGE_MENU_ITEM_H__
#define GTK_TYPE_IMAGE_MENU_ITEM gtk_image_menu_item_get_type()
#define GTK_IMAGE_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItem)
#define GTK_IMAGE_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass)
#define GTK_IS_IMAGE_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IMAGE_MENU_ITEM)
#define GTK_IS_IMAGE_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IMAGE_MENU_ITEM)
#define GTK_IMAGE_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass)
type GtkImageMenuItem as _GtkImageMenuItem
type GtkImageMenuItemClass as _GtkImageMenuItemClass

type _GtkImageMenuItem
	menu_item as GtkMenuItem
	image as GtkWidget ptr
end type

type _GtkImageMenuItemClass
	parent_class as GtkMenuItemClass
end type

declare function gtk_image_menu_item_get_type() as GType
declare function gtk_image_menu_item_new() as GtkWidget ptr
declare function gtk_image_menu_item_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_image_menu_item_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_image_menu_item_new_from_stock(byval stock_id as const gchar ptr, byval accel_group as GtkAccelGroup ptr) as GtkWidget ptr
declare sub gtk_image_menu_item_set_always_show_image(byval image_menu_item as GtkImageMenuItem ptr, byval always_show as gboolean)
declare function gtk_image_menu_item_get_always_show_image(byval image_menu_item as GtkImageMenuItem ptr) as gboolean
declare sub gtk_image_menu_item_set_image(byval image_menu_item as GtkImageMenuItem ptr, byval image as GtkWidget ptr)
declare function gtk_image_menu_item_get_image(byval image_menu_item as GtkImageMenuItem ptr) as GtkWidget ptr
declare sub gtk_image_menu_item_set_use_stock(byval image_menu_item as GtkImageMenuItem ptr, byval use_stock as gboolean)
declare function gtk_image_menu_item_get_use_stock(byval image_menu_item as GtkImageMenuItem ptr) as gboolean
declare sub gtk_image_menu_item_set_accel_group(byval image_menu_item as GtkImageMenuItem ptr, byval accel_group as GtkAccelGroup ptr)

#define __GTK_IM_CONTEXT_SIMPLE_H__
#define GTK_TYPE_IM_CONTEXT_SIMPLE gtk_im_context_simple_get_type()
#define GTK_IM_CONTEXT_SIMPLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimple)
#define GTK_IM_CONTEXT_SIMPLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass)
#define GTK_IS_IM_CONTEXT_SIMPLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IM_CONTEXT_SIMPLE)
#define GTK_IS_IM_CONTEXT_SIMPLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IM_CONTEXT_SIMPLE)
#define GTK_IM_CONTEXT_SIMPLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass)
type GtkIMContextSimple as _GtkIMContextSimple
type GtkIMContextSimpleClass as _GtkIMContextSimpleClass
const GTK_MAX_COMPOSE_LEN = 7

type _GtkIMContextSimple
	object as GtkIMContext
	tables as GSList ptr
	compose_buffer(0 to (7 + 1) - 1) as guint
	tentative_match as gunichar
	tentative_match_len as gint
	in_hex_sequence : 1 as guint
	modifiers_dropped : 1 as guint
end type

type _GtkIMContextSimpleClass
	parent_class as GtkIMContextClass
end type

declare function gtk_im_context_simple_get_type() as GType
declare function gtk_im_context_simple_new() as GtkIMContext ptr
declare sub gtk_im_context_simple_add_table(byval context_simple as GtkIMContextSimple ptr, byval data as guint16 ptr, byval max_seq_len as gint, byval n_seqs as gint)

#define __GTK_IM_MULTICONTEXT_H__
#define GTK_TYPE_IM_MULTICONTEXT gtk_im_multicontext_get_type()
#define GTK_IM_MULTICONTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontext)
#define GTK_IM_MULTICONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass)
#define GTK_IS_IM_MULTICONTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IM_MULTICONTEXT)
#define GTK_IS_IM_MULTICONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IM_MULTICONTEXT)
#define GTK_IM_MULTICONTEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass)

type GtkIMMulticontext as _GtkIMMulticontext
type GtkIMMulticontextClass as _GtkIMMulticontextClass
type GtkIMMulticontextPrivate as _GtkIMMulticontextPrivate

type _GtkIMMulticontext
	object as GtkIMContext
	slave as GtkIMContext ptr
	priv as GtkIMMulticontextPrivate ptr
	context_id as gchar ptr
end type

type _GtkIMMulticontextClass
	parent_class as GtkIMContextClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_im_multicontext_get_type() as GType
declare function gtk_im_multicontext_new() as GtkIMContext ptr
declare sub gtk_im_multicontext_append_menuitems(byval context as GtkIMMulticontext ptr, byval menushell as GtkMenuShell ptr)
declare function gtk_im_multicontext_get_context_id(byval context as GtkIMMulticontext ptr) as const zstring ptr
declare sub gtk_im_multicontext_set_context_id(byval context as GtkIMMulticontext ptr, byval context_id as const zstring ptr)

#define __GTK_INFO_BAR_H__
#define GTK_TYPE_INFO_BAR gtk_info_bar_get_type()
#define GTK_INFO_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_INFO_BAR, GtkInfoBar)
#define GTK_INFO_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_INFO_BAR, GtkInfoBarClass)
#define GTK_IS_INFO_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_INFO_BAR)
#define GTK_IS_INFO_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_INFO_BAR)
#define GTK_INFO_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_INFO_BAR, GtkInfoBarClass)

type GtkInfoBarPrivate as _GtkInfoBarPrivate
type GtkInfoBarClass as _GtkInfoBarClass
type GtkInfoBar as _GtkInfoBar

type _GtkInfoBar
	parent as GtkHBox
	priv as GtkInfoBarPrivate ptr
end type

type _GtkInfoBarClass
	parent_class as GtkHBoxClass
	response as sub(byval info_bar as GtkInfoBar ptr, byval response_id as gint)
	close as sub(byval info_bar as GtkInfoBar ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
end type

declare function gtk_info_bar_get_type() as GType
declare function gtk_info_bar_new() as GtkWidget ptr
declare function gtk_info_bar_new_with_buttons(byval first_button_text as const gchar ptr, ...) as GtkWidget ptr
declare function gtk_info_bar_get_action_area(byval info_bar as GtkInfoBar ptr) as GtkWidget ptr
declare function gtk_info_bar_get_content_area(byval info_bar as GtkInfoBar ptr) as GtkWidget ptr
declare sub gtk_info_bar_add_action_widget(byval info_bar as GtkInfoBar ptr, byval child as GtkWidget ptr, byval response_id as gint)
declare function gtk_info_bar_add_button(byval info_bar as GtkInfoBar ptr, byval button_text as const gchar ptr, byval response_id as gint) as GtkWidget ptr
declare sub gtk_info_bar_add_buttons(byval info_bar as GtkInfoBar ptr, byval first_button_text as const gchar ptr, ...)
declare sub gtk_info_bar_set_response_sensitive(byval info_bar as GtkInfoBar ptr, byval response_id as gint, byval setting as gboolean)
declare sub gtk_info_bar_set_default_response(byval info_bar as GtkInfoBar ptr, byval response_id as gint)
declare sub gtk_info_bar_response(byval info_bar as GtkInfoBar ptr, byval response_id as gint)
declare sub gtk_info_bar_set_message_type(byval info_bar as GtkInfoBar ptr, byval message_type as GtkMessageType)
declare function gtk_info_bar_get_message_type(byval info_bar as GtkInfoBar ptr) as GtkMessageType

#define __GTK_INVISIBLE_H__
#define GTK_TYPE_INVISIBLE gtk_invisible_get_type()
#define GTK_INVISIBLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_INVISIBLE, GtkInvisible)
#define GTK_INVISIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_INVISIBLE, GtkInvisibleClass)
#define GTK_IS_INVISIBLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_INVISIBLE)
#define GTK_IS_INVISIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_INVISIBLE)
#define GTK_INVISIBLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_INVISIBLE, GtkInvisibleClass)
type GtkInvisible as _GtkInvisible
type GtkInvisibleClass as _GtkInvisibleClass

type _GtkInvisible
	widget as GtkWidget
	has_user_ref_count as gboolean
	screen as GdkScreen ptr
end type

type _GtkInvisibleClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_invisible_get_type() as GType
declare function gtk_invisible_new() as GtkWidget ptr
declare function gtk_invisible_new_for_screen(byval screen as GdkScreen ptr) as GtkWidget ptr
declare sub gtk_invisible_set_screen(byval invisible as GtkInvisible ptr, byval screen as GdkScreen ptr)
declare function gtk_invisible_get_screen(byval invisible as GtkInvisible ptr) as GdkScreen ptr

#define __GTK_LAYOUT_H__
#define GTK_TYPE_LAYOUT gtk_layout_get_type()
#define GTK_LAYOUT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LAYOUT, GtkLayout)
#define GTK_LAYOUT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LAYOUT, GtkLayoutClass)
#define GTK_IS_LAYOUT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LAYOUT)
#define GTK_IS_LAYOUT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LAYOUT)
#define GTK_LAYOUT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LAYOUT, GtkLayoutClass)
type GtkLayout as _GtkLayout
type GtkLayoutClass as _GtkLayoutClass

type _GtkLayout
	container as GtkContainer
	children as GList ptr
	width as guint
	height as guint
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
	bin_window as GdkWindow ptr
	visibility as GdkVisibilityState
	scroll_x as gint
	scroll_y as gint
	freeze_count as guint
end type

type _GtkLayoutClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub(byval layout as GtkLayout ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_layout_get_type() as GType
declare function gtk_layout_new(byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_layout_get_bin_window(byval layout as GtkLayout ptr) as GdkWindow ptr
declare sub gtk_layout_put(byval layout as GtkLayout ptr, byval child_widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_layout_move(byval layout as GtkLayout ptr, byval child_widget as GtkWidget ptr, byval x as gint, byval y as gint)
declare sub gtk_layout_set_size(byval layout as GtkLayout ptr, byval width as guint, byval height as guint)
declare sub gtk_layout_get_size(byval layout as GtkLayout ptr, byval width as guint ptr, byval height as guint ptr)
declare function gtk_layout_get_hadjustment(byval layout as GtkLayout ptr) as GtkAdjustment ptr
declare function gtk_layout_get_vadjustment(byval layout as GtkLayout ptr) as GtkAdjustment ptr
declare sub gtk_layout_set_hadjustment(byval layout as GtkLayout ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_layout_set_vadjustment(byval layout as GtkLayout ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_layout_freeze(byval layout as GtkLayout ptr)
declare sub gtk_layout_thaw(byval layout as GtkLayout ptr)

#define __GTK_LINK_BUTTON_H__
#define GTK_TYPE_LINK_BUTTON gtk_link_button_get_type()
#define GTK_LINK_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LINK_BUTTON, GtkLinkButton)
#define GTK_IS_LINK_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LINK_BUTTON)
#define GTK_LINK_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LINK_BUTTON, GtkLinkButtonClass)
#define GTK_IS_LINK_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LINK_BUTTON)
#define GTK_LINK_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LINK_BUTTON, GtkLinkButtonClass)

type GtkLinkButton as _GtkLinkButton
type GtkLinkButtonClass as _GtkLinkButtonClass
type GtkLinkButtonPrivate as _GtkLinkButtonPrivate
type GtkLinkButtonUriFunc as sub(byval button as GtkLinkButton ptr, byval link_ as const gchar ptr, byval user_data as gpointer)

type _GtkLinkButton
	parent_instance as GtkButton
	priv as GtkLinkButtonPrivate ptr
end type

type _GtkLinkButtonClass
	parent_class as GtkButtonClass
	_gtk_padding1 as sub()
	_gtk_padding2 as sub()
	_gtk_padding3 as sub()
	_gtk_padding4 as sub()
end type

declare function gtk_link_button_get_type() as GType
declare function gtk_link_button_new(byval uri as const gchar ptr) as GtkWidget ptr
declare function gtk_link_button_new_with_label(byval uri as const gchar ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_link_button_get_uri(byval link_button as GtkLinkButton ptr) as const gchar ptr
declare sub gtk_link_button_set_uri(byval link_button as GtkLinkButton ptr, byval uri as const gchar ptr)
declare function gtk_link_button_set_uri_hook(byval func as GtkLinkButtonUriFunc, byval data as gpointer, byval destroy as GDestroyNotify) as GtkLinkButtonUriFunc
declare function gtk_link_button_get_visited(byval link_button as GtkLinkButton ptr) as gboolean
declare sub gtk_link_button_set_visited(byval link_button as GtkLinkButton ptr, byval visited as gboolean)

#define __GTK_MAIN_H__
const GTK_PRIORITY_RESIZE = G_PRIORITY_HIGH_IDLE + 10
const GTK_PRIORITY_REDRAW = G_PRIORITY_HIGH_IDLE + 20
const GTK_PRIORITY_HIGH = G_PRIORITY_HIGH
const GTK_PRIORITY_INTERNAL = GTK_PRIORITY_REDRAW
const GTK_PRIORITY_DEFAULT = G_PRIORITY_DEFAULT_IDLE
const GTK_PRIORITY_LOW = G_PRIORITY_LOW
type GtkKeySnoopFunc as function(byval grab_widget as GtkWidget ptr, byval event as GdkEventKey ptr, byval func_data as gpointer) as gint

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	extern import gtk_major_version_ alias "gtk_major_version" as const guint
	extern import gtk_minor_version_ alias "gtk_minor_version" as const guint
	extern import gtk_micro_version_ alias "gtk_micro_version" as const guint
	extern import gtk_binary_age_ alias "gtk_binary_age" as const guint
	extern import gtk_interface_age_ alias "gtk_interface_age" as const guint
#else
	extern gtk_major_version_ alias "gtk_major_version" as const guint
	extern gtk_minor_version_ alias "gtk_minor_version" as const guint
	extern gtk_micro_version_ alias "gtk_micro_version" as const guint
	extern gtk_binary_age_ alias "gtk_binary_age" as const guint
	extern gtk_interface_age_ alias "gtk_interface_age" as const guint
#endif

declare function gtk_check_version_ alias "gtk_check_version"(byval required_major as guint, byval required_minor as guint, byval required_micro as guint) as const gchar ptr
declare function gtk_parse_args(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean

#ifdef __FB_UNIX__
	declare sub gtk_init(byval argc as long ptr, byval argv as zstring ptr ptr ptr)
	declare function gtk_init_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
#else
	declare sub gtk_init_ alias "gtk_init"(byval argc as long ptr, byval argv as zstring ptr ptr ptr)
	declare function gtk_init_check_ alias "gtk_init_check"(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
#endif

declare function gtk_init_with_args(byval argc as long ptr, byval argv as zstring ptr ptr ptr, byval parameter_string as const zstring ptr, byval entries as GOptionEntry ptr, byval translation_domain as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_get_option_group(byval open_default_display as gboolean) as GOptionGroup ptr

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
	declare sub gtk_init_abi_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr, byval num_checks as long, byval sizeof_GtkWindow as uinteger, byval sizeof_GtkBox as uinteger)
	declare function gtk_init_check_abi_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr, byval num_checks as long, byval sizeof_GtkWindow as uinteger, byval sizeof_GtkBox as uinteger) as gboolean
	#define gtk_init(argc, argv) gtk_init_abi_check(argc, argv, 2, sizeof(GtkWindow), sizeof(GtkBox))
	#define gtk_init_check(argc, argv) gtk_init_check_abi_check(argc, argv, 2, sizeof(GtkWindow), sizeof(GtkBox))
#endif

declare sub gtk_exit(byval error_code as gint)
declare function gtk_set_locale() as gchar ptr
declare sub gtk_disable_setlocale()
declare function gtk_get_default_language() as PangoLanguage ptr
declare function gtk_events_pending() as gboolean
declare sub gtk_main_do_event(byval event as GdkEvent ptr)
declare sub gtk_main()
declare function gtk_main_level() as guint
declare sub gtk_main_quit()
declare function gtk_main_iteration() as gboolean
declare function gtk_main_iteration_do(byval blocking as gboolean) as gboolean
declare function gtk_true() as gboolean
declare function gtk_false() as gboolean
declare sub gtk_grab_add(byval widget as GtkWidget ptr)
declare function gtk_grab_get_current() as GtkWidget ptr
declare sub gtk_grab_remove(byval widget as GtkWidget ptr)
declare sub gtk_init_add(byval function as GtkFunction, byval data as gpointer)
declare sub gtk_quit_add_destroy(byval main_level as guint, byval object as GtkObject ptr)
declare function gtk_quit_add(byval main_level as guint, byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_quit_add_full(byval main_level as guint, byval function as GtkFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GDestroyNotify) as guint
declare sub gtk_quit_remove(byval quit_handler_id as guint)
declare sub gtk_quit_remove_by_data(byval data as gpointer)
declare function gtk_timeout_add(byval interval as guint32, byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_timeout_add_full(byval interval as guint32, byval function as GtkFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GDestroyNotify) as guint
declare sub gtk_timeout_remove(byval timeout_handler_id as guint)
declare function gtk_idle_add(byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_idle_add_priority(byval priority as gint, byval function as GtkFunction, byval data as gpointer) as guint
declare function gtk_idle_add_full(byval priority as gint, byval function as GtkFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GDestroyNotify) as guint
declare sub gtk_idle_remove(byval idle_handler_id as guint)
declare sub gtk_idle_remove_by_data(byval data as gpointer)
declare function gtk_input_add_full(byval source as gint, byval condition as GdkInputCondition, byval function as GdkInputFunction, byval marshal as GtkCallbackMarshal, byval data as gpointer, byval destroy as GDestroyNotify) as guint
declare sub gtk_input_remove(byval input_handler_id as guint)
declare function gtk_key_snooper_install(byval snooper as GtkKeySnoopFunc, byval func_data as gpointer) as guint
declare sub gtk_key_snooper_remove(byval snooper_handler_id as guint)
declare function gtk_get_current_event() as GdkEvent ptr
declare function gtk_get_current_event_time() as guint32
declare function gtk_get_current_event_state(byval state as GdkModifierType ptr) as gboolean
declare function gtk_get_event_widget(byval event as GdkEvent ptr) as GtkWidget ptr
declare sub gtk_propagate_event(byval widget as GtkWidget ptr, byval event as GdkEvent ptr)
declare function _gtk_boolean_handled_accumulator(byval ihint as GSignalInvocationHint ptr, byval return_accu as GValue ptr, byval handler_return as const GValue ptr, byval dummy as gpointer) as gboolean
declare function _gtk_get_lc_ctype() as gchar ptr
declare function _gtk_module_has_mixed_deps(byval module as GModule ptr) as gboolean

#define __GTK_MENU_BAR_H__
#define GTK_TYPE_MENU_BAR gtk_menu_bar_get_type()
#define GTK_MENU_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU_BAR, GtkMenuBar)
#define GTK_MENU_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU_BAR, GtkMenuBarClass)
#define GTK_IS_MENU_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU_BAR)
#define GTK_IS_MENU_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU_BAR)
#define GTK_MENU_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU_BAR, GtkMenuBarClass)
type GtkMenuBar as _GtkMenuBar
type GtkMenuBarClass as _GtkMenuBarClass

type _GtkMenuBar
	menu_shell as GtkMenuShell
end type

type _GtkMenuBarClass
	parent_class as GtkMenuShellClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_menu_bar_get_type() as GType
declare function gtk_menu_bar_new() as GtkWidget ptr
declare function gtk_menu_bar_get_pack_direction(byval menubar as GtkMenuBar ptr) as GtkPackDirection
declare sub gtk_menu_bar_set_pack_direction(byval menubar as GtkMenuBar ptr, byval pack_dir as GtkPackDirection)
declare function gtk_menu_bar_get_child_pack_direction(byval menubar as GtkMenuBar ptr) as GtkPackDirection
declare sub gtk_menu_bar_set_child_pack_direction(byval menubar as GtkMenuBar ptr, byval child_pack_dir as GtkPackDirection)

#define gtk_menu_bar_append(menu, child) gtk_menu_shell_append(cptr(GtkMenuShell ptr, (menu)), (child))
#define gtk_menu_bar_prepend(menu, child) gtk_menu_shell_prepend(cptr(GtkMenuShell ptr, (menu)), (child))
#define gtk_menu_bar_insert(menu, child, pos) gtk_menu_shell_insert(cptr(GtkMenuShell ptr, (menu)), (child), (pos))
declare sub _gtk_menu_bar_cycle_focus(byval menubar as GtkMenuBar ptr, byval dir as GtkDirectionType)
#define __GTK_MENU_TOOL_BUTTON_H__
#define __GTK_TOOL_BUTTON_H__
#define __GTK_TOOL_ITEM_H__
#define __GTK_TOOLTIPS_H__
#define GTK_TYPE_TOOLTIPS gtk_tooltips_get_type()
#define GTK_TOOLTIPS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOOLTIPS, GtkTooltips)
#define GTK_TOOLTIPS_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOOLTIPS, GtkTooltipsClass)
#define GTK_IS_TOOLTIPS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOOLTIPS)
#define GTK_IS_TOOLTIPS_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOOLTIPS)
#define GTK_TOOLTIPS_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOLTIPS, GtkTooltipsClass)

type GtkTooltips as _GtkTooltips
type GtkTooltipsClass as _GtkTooltipsClass
type GtkTooltipsData as _GtkTooltipsData

type _GtkTooltipsData
	tooltips as GtkTooltips ptr
	widget as GtkWidget ptr
	tip_text as gchar ptr
	tip_private as gchar ptr
end type

type _GtkTooltips
	parent_instance as GtkObject
	tip_window as GtkWidget ptr
	tip_label as GtkWidget ptr
	active_tips_data as GtkTooltipsData ptr
	tips_data_list as GList ptr
	delay : 30 as guint
	enabled : 1 as guint
	have_grab : 1 as guint
	use_sticky_delay : 1 as guint
	timer_tag as gint
	last_popdown as GTimeVal
end type

type _GtkTooltipsClass
	parent_class as GtkObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tooltips_get_type() as GType
declare function gtk_tooltips_new() as GtkTooltips ptr
declare sub gtk_tooltips_enable(byval tooltips as GtkTooltips ptr)
declare sub gtk_tooltips_disable(byval tooltips as GtkTooltips ptr)
declare sub gtk_tooltips_set_delay(byval tooltips as GtkTooltips ptr, byval delay as guint)
declare sub gtk_tooltips_set_tip(byval tooltips as GtkTooltips ptr, byval widget as GtkWidget ptr, byval tip_text as const gchar ptr, byval tip_private as const gchar ptr)
declare function gtk_tooltips_data_get(byval widget as GtkWidget ptr) as GtkTooltipsData ptr
declare sub gtk_tooltips_force_window(byval tooltips as GtkTooltips ptr)
declare function gtk_tooltips_get_info_from_tip_window(byval tip_window as GtkWindow ptr, byval tooltips as GtkTooltips ptr ptr, byval current_widget as GtkWidget ptr ptr) as gboolean

#define __GTK_SIZE_GROUP_H__
#define GTK_TYPE_SIZE_GROUP gtk_size_group_get_type()
#define GTK_SIZE_GROUP(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroup)
#define GTK_SIZE_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass)
#define GTK_IS_SIZE_GROUP(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SIZE_GROUP)
#define GTK_IS_SIZE_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SIZE_GROUP)
#define GTK_SIZE_GROUP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass)
type GtkSizeGroup as _GtkSizeGroup
type GtkSizeGroupClass as _GtkSizeGroupClass

type _GtkSizeGroup
	parent_instance as GObject
	widgets as GSList ptr
	mode as guint8
	have_width : 1 as guint
	have_height : 1 as guint
	ignore_hidden : 1 as guint
	requisition as GtkRequisition
end type

type _GtkSizeGroupClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type GtkSizeGroupMode as long
enum
	GTK_SIZE_GROUP_NONE
	GTK_SIZE_GROUP_HORIZONTAL
	GTK_SIZE_GROUP_VERTICAL
	GTK_SIZE_GROUP_BOTH
end enum

declare function gtk_size_group_get_type() as GType
declare function gtk_size_group_new(byval mode as GtkSizeGroupMode) as GtkSizeGroup ptr
declare sub gtk_size_group_set_mode(byval size_group as GtkSizeGroup ptr, byval mode as GtkSizeGroupMode)
declare function gtk_size_group_get_mode(byval size_group as GtkSizeGroup ptr) as GtkSizeGroupMode
declare sub gtk_size_group_set_ignore_hidden(byval size_group as GtkSizeGroup ptr, byval ignore_hidden as gboolean)
declare function gtk_size_group_get_ignore_hidden(byval size_group as GtkSizeGroup ptr) as gboolean
declare sub gtk_size_group_add_widget(byval size_group as GtkSizeGroup ptr, byval widget as GtkWidget ptr)
declare sub gtk_size_group_remove_widget(byval size_group as GtkSizeGroup ptr, byval widget as GtkWidget ptr)
declare function gtk_size_group_get_widgets(byval size_group as GtkSizeGroup ptr) as GSList ptr
declare sub _gtk_size_group_get_child_requisition(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub _gtk_size_group_compute_requisition(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub _gtk_size_group_queue_resize(byval widget as GtkWidget ptr)

#define GTK_TYPE_TOOL_ITEM gtk_tool_item_get_type()
#define GTK_TOOL_ITEM(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_TOOL_ITEM, GtkToolItem)
#define GTK_TOOL_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOOL_ITEM, GtkToolItemClass)
#define GTK_IS_TOOL_ITEM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_TOOL_ITEM)
#define GTK_IS_TOOL_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOOL_ITEM)
#define GTK_TOOL_ITEM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_TOOL_ITEM, GtkToolItemClass)

type GtkToolItem as _GtkToolItem
type GtkToolItemClass as _GtkToolItemClass
type GtkToolItemPrivate as _GtkToolItemPrivate

type _GtkToolItem
	parent as GtkBin
	priv as GtkToolItemPrivate ptr
end type

type _GtkToolItemClass
	parent_class as GtkBinClass
	create_menu_proxy as function(byval tool_item as GtkToolItem ptr) as gboolean
	toolbar_reconfigured as sub(byval tool_item as GtkToolItem ptr)
	set_tooltip as function(byval tool_item as GtkToolItem ptr, byval tooltips as GtkTooltips ptr, byval tip_text as const gchar ptr, byval tip_private as const gchar ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tool_item_get_type() as GType
declare function gtk_tool_item_new() as GtkToolItem ptr
declare sub gtk_tool_item_set_homogeneous(byval tool_item as GtkToolItem ptr, byval homogeneous as gboolean)
declare function gtk_tool_item_get_homogeneous(byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_expand(byval tool_item as GtkToolItem ptr, byval expand as gboolean)
declare function gtk_tool_item_get_expand(byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_tooltip(byval tool_item as GtkToolItem ptr, byval tooltips as GtkTooltips ptr, byval tip_text as const gchar ptr, byval tip_private as const gchar ptr)
declare sub gtk_tool_item_set_tooltip_text(byval tool_item as GtkToolItem ptr, byval text as const gchar ptr)
declare sub gtk_tool_item_set_tooltip_markup(byval tool_item as GtkToolItem ptr, byval markup as const gchar ptr)
declare sub gtk_tool_item_set_use_drag_window(byval tool_item as GtkToolItem ptr, byval use_drag_window as gboolean)
declare function gtk_tool_item_get_use_drag_window(byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_visible_horizontal(byval tool_item as GtkToolItem ptr, byval visible_horizontal as gboolean)
declare function gtk_tool_item_get_visible_horizontal(byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_visible_vertical(byval tool_item as GtkToolItem ptr, byval visible_vertical as gboolean)
declare function gtk_tool_item_get_visible_vertical(byval tool_item as GtkToolItem ptr) as gboolean
declare function gtk_tool_item_get_is_important(byval tool_item as GtkToolItem ptr) as gboolean
declare sub gtk_tool_item_set_is_important(byval tool_item as GtkToolItem ptr, byval is_important as gboolean)
declare function gtk_tool_item_get_ellipsize_mode(byval tool_item as GtkToolItem ptr) as PangoEllipsizeMode
declare function gtk_tool_item_get_icon_size(byval tool_item as GtkToolItem ptr) as GtkIconSize
declare function gtk_tool_item_get_orientation(byval tool_item as GtkToolItem ptr) as GtkOrientation
declare function gtk_tool_item_get_toolbar_style(byval tool_item as GtkToolItem ptr) as GtkToolbarStyle
declare function gtk_tool_item_get_relief_style(byval tool_item as GtkToolItem ptr) as GtkReliefStyle
declare function gtk_tool_item_get_text_alignment(byval tool_item as GtkToolItem ptr) as gfloat
declare function gtk_tool_item_get_text_orientation(byval tool_item as GtkToolItem ptr) as GtkOrientation
declare function gtk_tool_item_get_text_size_group(byval tool_item as GtkToolItem ptr) as GtkSizeGroup ptr
declare function gtk_tool_item_retrieve_proxy_menu_item(byval tool_item as GtkToolItem ptr) as GtkWidget ptr
declare function gtk_tool_item_get_proxy_menu_item(byval tool_item as GtkToolItem ptr, byval menu_item_id as const gchar ptr) as GtkWidget ptr
declare sub gtk_tool_item_set_proxy_menu_item(byval tool_item as GtkToolItem ptr, byval menu_item_id as const gchar ptr, byval menu_item as GtkWidget ptr)
declare sub gtk_tool_item_rebuild_menu(byval tool_item as GtkToolItem ptr)
declare sub gtk_tool_item_toolbar_reconfigured(byval tool_item as GtkToolItem ptr)
declare function _gtk_tool_item_create_menu_proxy(byval tool_item as GtkToolItem ptr) as gboolean

#define GTK_TYPE_TOOL_BUTTON gtk_tool_button_get_type()
#define GTK_TOOL_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOOL_BUTTON, GtkToolButton)
#define GTK_TOOL_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOOL_BUTTON, GtkToolButtonClass)
#define GTK_IS_TOOL_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOOL_BUTTON)
#define GTK_IS_TOOL_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOOL_BUTTON)
#define GTK_TOOL_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOL_BUTTON, GtkToolButtonClass)

type GtkToolButton as _GtkToolButton
type GtkToolButtonClass as _GtkToolButtonClass
type GtkToolButtonPrivate as _GtkToolButtonPrivate

type _GtkToolButton
	parent as GtkToolItem
	priv as GtkToolButtonPrivate ptr
end type

type _GtkToolButtonClass
	parent_class as GtkToolItemClass
	button_type as GType
	clicked as sub(byval tool_item as GtkToolButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tool_button_get_type() as GType
declare function gtk_tool_button_new(byval icon_widget as GtkWidget ptr, byval label as const gchar ptr) as GtkToolItem ptr
declare function gtk_tool_button_new_from_stock(byval stock_id as const gchar ptr) as GtkToolItem ptr
declare sub gtk_tool_button_set_label(byval button as GtkToolButton ptr, byval label as const gchar ptr)
declare function gtk_tool_button_get_label(byval button as GtkToolButton ptr) as const gchar ptr
declare sub gtk_tool_button_set_use_underline(byval button as GtkToolButton ptr, byval use_underline as gboolean)
declare function gtk_tool_button_get_use_underline(byval button as GtkToolButton ptr) as gboolean
declare sub gtk_tool_button_set_stock_id(byval button as GtkToolButton ptr, byval stock_id as const gchar ptr)
declare function gtk_tool_button_get_stock_id(byval button as GtkToolButton ptr) as const gchar ptr
declare sub gtk_tool_button_set_icon_name(byval button as GtkToolButton ptr, byval icon_name as const gchar ptr)
declare function gtk_tool_button_get_icon_name(byval button as GtkToolButton ptr) as const gchar ptr
declare sub gtk_tool_button_set_icon_widget(byval button as GtkToolButton ptr, byval icon_widget as GtkWidget ptr)
declare function gtk_tool_button_get_icon_widget(byval button as GtkToolButton ptr) as GtkWidget ptr
declare sub gtk_tool_button_set_label_widget(byval button as GtkToolButton ptr, byval label_widget as GtkWidget ptr)
declare function gtk_tool_button_get_label_widget(byval button as GtkToolButton ptr) as GtkWidget ptr
declare function _gtk_tool_button_get_button(byval button as GtkToolButton ptr) as GtkWidget ptr

#define GTK_TYPE_MENU_TOOL_BUTTON gtk_menu_tool_button_get_type()
#define GTK_MENU_TOOL_BUTTON(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButton)
#define GTK_MENU_TOOL_BUTTON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButtonClass)
#define GTK_IS_MENU_TOOL_BUTTON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_MENU_TOOL_BUTTON)
#define GTK_IS_MENU_TOOL_BUTTON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_MENU_TOOL_BUTTON)
#define GTK_MENU_TOOL_BUTTON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButtonClass)

type GtkMenuToolButtonClass as _GtkMenuToolButtonClass
type GtkMenuToolButton as _GtkMenuToolButton
type GtkMenuToolButtonPrivate as _GtkMenuToolButtonPrivate

type _GtkMenuToolButton
	parent as GtkToolButton
	priv as GtkMenuToolButtonPrivate ptr
end type

type _GtkMenuToolButtonClass
	parent_class as GtkToolButtonClass
	show_menu as sub(byval button as GtkMenuToolButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_menu_tool_button_get_type() as GType
declare function gtk_menu_tool_button_new(byval icon_widget as GtkWidget ptr, byval label as const gchar ptr) as GtkToolItem ptr
declare function gtk_menu_tool_button_new_from_stock(byval stock_id as const gchar ptr) as GtkToolItem ptr
declare sub gtk_menu_tool_button_set_menu(byval button as GtkMenuToolButton ptr, byval menu as GtkWidget ptr)
declare function gtk_menu_tool_button_get_menu(byval button as GtkMenuToolButton ptr) as GtkWidget ptr
declare sub gtk_menu_tool_button_set_arrow_tooltip(byval button as GtkMenuToolButton ptr, byval tooltips as GtkTooltips ptr, byval tip_text as const gchar ptr, byval tip_private as const gchar ptr)
declare sub gtk_menu_tool_button_set_arrow_tooltip_text(byval button as GtkMenuToolButton ptr, byval text as const gchar ptr)
declare sub gtk_menu_tool_button_set_arrow_tooltip_markup(byval button as GtkMenuToolButton ptr, byval markup as const gchar ptr)

#define __GTK_MESSAGE_DIALOG_H__
#define GTK_TYPE_MESSAGE_DIALOG gtk_message_dialog_get_type()
#define GTK_MESSAGE_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialog)
#define GTK_MESSAGE_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialogClass)
#define GTK_IS_MESSAGE_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MESSAGE_DIALOG)
#define GTK_IS_MESSAGE_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MESSAGE_DIALOG)
#define GTK_MESSAGE_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialogClass)
type GtkMessageDialog as _GtkMessageDialog
type GtkMessageDialogClass as _GtkMessageDialogClass

type _GtkMessageDialog
	parent_instance as GtkDialog
	image as GtkWidget ptr
	label as GtkWidget ptr
end type

type _GtkMessageDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type GtkButtonsType as long
enum
	GTK_BUTTONS_NONE
	GTK_BUTTONS_OK
	GTK_BUTTONS_CLOSE
	GTK_BUTTONS_CANCEL
	GTK_BUTTONS_YES_NO
	GTK_BUTTONS_OK_CANCEL
end enum

declare function gtk_message_dialog_get_type() as GType
declare function gtk_message_dialog_new(byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval type as GtkMessageType, byval buttons as GtkButtonsType, byval message_format as const gchar ptr, ...) as GtkWidget ptr
declare function gtk_message_dialog_new_with_markup(byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval type as GtkMessageType, byval buttons as GtkButtonsType, byval message_format as const gchar ptr, ...) as GtkWidget ptr
declare sub gtk_message_dialog_set_image(byval dialog as GtkMessageDialog ptr, byval image as GtkWidget ptr)
declare function gtk_message_dialog_get_image(byval dialog as GtkMessageDialog ptr) as GtkWidget ptr
declare sub gtk_message_dialog_set_markup(byval message_dialog as GtkMessageDialog ptr, byval str as const gchar ptr)
declare sub gtk_message_dialog_format_secondary_text(byval message_dialog as GtkMessageDialog ptr, byval message_format as const gchar ptr, ...)
declare sub gtk_message_dialog_format_secondary_markup(byval message_dialog as GtkMessageDialog ptr, byval message_format as const gchar ptr, ...)
declare function gtk_message_dialog_get_message_area(byval message_dialog as GtkMessageDialog ptr) as GtkWidget ptr
#define __GTK_MODULES_H__
declare function _gtk_find_module(byval name as const gchar ptr, byval type as const gchar ptr) as gchar ptr
declare function _gtk_get_module_path(byval type as const gchar ptr) as gchar ptr ptr
declare sub _gtk_modules_init(byval argc as gint ptr, byval argv as gchar ptr ptr ptr, byval gtk_modules_args as const gchar ptr)
declare sub _gtk_modules_settings_changed(byval settings as GtkSettings ptr, byval modules as const gchar ptr)
type GtkModuleInitFunc as sub(byval argc as gint ptr, byval argv as gchar ptr ptr ptr)
type GtkModuleDisplayInitFunc as sub(byval display as GdkDisplay ptr)

#define __GTK_MOUNT_OPERATION_H__
#define GTK_TYPE_MOUNT_OPERATION gtk_mount_operation_get_type()
#define GTK_MOUNT_OPERATION(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_MOUNT_OPERATION, GtkMountOperation)
#define GTK_MOUNT_OPERATION_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_MOUNT_OPERATION, GtkMountOperationClass)
#define GTK_IS_MOUNT_OPERATION(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_MOUNT_OPERATION)
#define GTK_IS_MOUNT_OPERATION_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_MOUNT_OPERATION)
#define GTK_MOUNT_OPERATION_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_MOUNT_OPERATION, GtkMountOperationClass)

type GtkMountOperation as _GtkMountOperation
type GtkMountOperationClass as _GtkMountOperationClass
type GtkMountOperationPrivate as _GtkMountOperationPrivate

type _GtkMountOperation
	parent_instance as GMountOperation
	priv as GtkMountOperationPrivate ptr
end type

type _GtkMountOperationClass
	parent_class as GMountOperationClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_mount_operation_get_type() as GType
declare function gtk_mount_operation_new(byval parent as GtkWindow ptr) as GMountOperation ptr
declare function gtk_mount_operation_is_showing(byval op as GtkMountOperation ptr) as gboolean
declare sub gtk_mount_operation_set_parent(byval op as GtkMountOperation ptr, byval parent as GtkWindow ptr)
declare function gtk_mount_operation_get_parent(byval op as GtkMountOperation ptr) as GtkWindow ptr
declare sub gtk_mount_operation_set_screen(byval op as GtkMountOperation ptr, byval screen as GdkScreen ptr)
declare function gtk_mount_operation_get_screen(byval op as GtkMountOperation ptr) as GdkScreen ptr

#define __GTK_NOTEBOOK_H__
#define GTK_TYPE_NOTEBOOK gtk_notebook_get_type()
#define GTK_NOTEBOOK(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_NOTEBOOK, GtkNotebook)
#define GTK_NOTEBOOK_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_NOTEBOOK, GtkNotebookClass)
#define GTK_IS_NOTEBOOK(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_NOTEBOOK)
#define GTK_IS_NOTEBOOK_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_NOTEBOOK)
#define GTK_NOTEBOOK_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_NOTEBOOK, GtkNotebookClass)

type GtkNotebookTab as long
enum
	GTK_NOTEBOOK_TAB_FIRST
	GTK_NOTEBOOK_TAB_LAST
end enum

type GtkNotebook as _GtkNotebook
type GtkNotebookClass as _GtkNotebookClass
type GtkNotebookPage as _GtkNotebookPage

type _GtkNotebook
	container as GtkContainer
	cur_page as GtkNotebookPage ptr
	children as GList ptr
	first_tab as GList ptr
	focus_tab as GList ptr
	menu as GtkWidget ptr
	event_window as GdkWindow ptr
	timer as guint32
	tab_hborder as guint16
	tab_vborder as guint16
	show_tabs : 1 as guint
	homogeneous : 1 as guint
	show_border : 1 as guint
	tab_pos : 2 as guint
	scrollable : 1 as guint
	in_child : 3 as guint
	click_child : 3 as guint
	button : 2 as guint
	need_timer : 1 as guint
	child_has_focus : 1 as guint
	have_visible_child : 1 as guint
	focus_out : 1 as guint
	has_before_previous : 1 as guint
	has_before_next : 1 as guint
	has_after_previous : 1 as guint
	has_after_next : 1 as guint
end type

type _GtkNotebookClass
	parent_class as GtkContainerClass
	switch_page as sub(byval notebook as GtkNotebook ptr, byval page as GtkNotebookPage ptr, byval page_num as guint)
	select_page as function(byval notebook as GtkNotebook ptr, byval move_focus as gboolean) as gboolean
	focus_tab as function(byval notebook as GtkNotebook ptr, byval type as GtkNotebookTab) as gboolean
	change_current_page as function(byval notebook as GtkNotebook ptr, byval offset as gint) as gboolean
	move_focus_out as sub(byval notebook as GtkNotebook ptr, byval direction as GtkDirectionType)
	reorder_tab as function(byval notebook as GtkNotebook ptr, byval direction as GtkDirectionType, byval move_to_last as gboolean) as gboolean
	insert_page as function(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr, byval position as gint) as gint
	create_window as function(byval notebook as GtkNotebook ptr, byval page as GtkWidget ptr, byval x as gint, byval y as gint) as GtkNotebook ptr
	_gtk_reserved1 as sub()
end type

type GtkNotebookWindowCreationFunc as function(byval source as GtkNotebook ptr, byval page as GtkWidget ptr, byval x as gint, byval y as gint, byval data as gpointer) as GtkNotebook ptr
declare function gtk_notebook_get_type() as GType
declare function gtk_notebook_new() as GtkWidget ptr
declare function gtk_notebook_append_page(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr) as gint
declare function gtk_notebook_append_page_menu(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr) as gint
declare function gtk_notebook_prepend_page(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr) as gint
declare function gtk_notebook_prepend_page_menu(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr) as gint
declare function gtk_notebook_insert_page(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval position as gint) as gint
declare function gtk_notebook_insert_page_menu(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr, byval position as gint) as gint
declare sub gtk_notebook_remove_page(byval notebook as GtkNotebook ptr, byval page_num as gint)
declare sub gtk_notebook_set_window_creation_hook(byval func as GtkNotebookWindowCreationFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_notebook_set_group_id(byval notebook as GtkNotebook ptr, byval group_id as gint)
declare function gtk_notebook_get_group_id(byval notebook as GtkNotebook ptr) as gint
declare sub gtk_notebook_set_group(byval notebook as GtkNotebook ptr, byval group as gpointer)
declare function gtk_notebook_get_group(byval notebook as GtkNotebook ptr) as gpointer
declare sub gtk_notebook_set_group_name(byval notebook as GtkNotebook ptr, byval group_name as const gchar ptr)
declare function gtk_notebook_get_group_name(byval notebook as GtkNotebook ptr) as const gchar ptr
declare function gtk_notebook_get_current_page(byval notebook as GtkNotebook ptr) as gint
declare function gtk_notebook_get_nth_page(byval notebook as GtkNotebook ptr, byval page_num as gint) as GtkWidget ptr
declare function gtk_notebook_get_n_pages(byval notebook as GtkNotebook ptr) as gint
declare function gtk_notebook_page_num(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as gint
declare sub gtk_notebook_set_current_page(byval notebook as GtkNotebook ptr, byval page_num as gint)
declare sub gtk_notebook_next_page(byval notebook as GtkNotebook ptr)
declare sub gtk_notebook_prev_page(byval notebook as GtkNotebook ptr)
declare sub gtk_notebook_set_show_border(byval notebook as GtkNotebook ptr, byval show_border as gboolean)
declare function gtk_notebook_get_show_border(byval notebook as GtkNotebook ptr) as gboolean
declare sub gtk_notebook_set_show_tabs(byval notebook as GtkNotebook ptr, byval show_tabs as gboolean)
declare function gtk_notebook_get_show_tabs(byval notebook as GtkNotebook ptr) as gboolean
declare sub gtk_notebook_set_tab_pos(byval notebook as GtkNotebook ptr, byval pos as GtkPositionType)
declare function gtk_notebook_get_tab_pos(byval notebook as GtkNotebook ptr) as GtkPositionType
declare sub gtk_notebook_set_homogeneous_tabs(byval notebook as GtkNotebook ptr, byval homogeneous as gboolean)
declare sub gtk_notebook_set_tab_border(byval notebook as GtkNotebook ptr, byval border_width as guint)
declare sub gtk_notebook_set_tab_hborder(byval notebook as GtkNotebook ptr, byval tab_hborder as guint)
declare sub gtk_notebook_set_tab_vborder(byval notebook as GtkNotebook ptr, byval tab_vborder as guint)
declare sub gtk_notebook_set_scrollable(byval notebook as GtkNotebook ptr, byval scrollable as gboolean)
declare function gtk_notebook_get_scrollable(byval notebook as GtkNotebook ptr) as gboolean
declare function gtk_notebook_get_tab_hborder(byval notebook as GtkNotebook ptr) as guint16
declare function gtk_notebook_get_tab_vborder(byval notebook as GtkNotebook ptr) as guint16
declare sub gtk_notebook_popup_enable(byval notebook as GtkNotebook ptr)
declare sub gtk_notebook_popup_disable(byval notebook as GtkNotebook ptr)
declare function gtk_notebook_get_tab_label(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as GtkWidget ptr
declare sub gtk_notebook_set_tab_label(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr)
declare sub gtk_notebook_set_tab_label_text(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_text as const gchar ptr)
declare function gtk_notebook_get_tab_label_text(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as const gchar ptr
declare function gtk_notebook_get_menu_label(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as GtkWidget ptr
declare sub gtk_notebook_set_menu_label(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval menu_label as GtkWidget ptr)
declare sub gtk_notebook_set_menu_label_text(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval menu_text as const gchar ptr)
declare function gtk_notebook_get_menu_label_text(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as const gchar ptr
declare sub gtk_notebook_query_tab_label_packing(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval expand as gboolean ptr, byval fill as gboolean ptr, byval pack_type as GtkPackType ptr)
declare sub gtk_notebook_set_tab_label_packing(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval pack_type as GtkPackType)
declare sub gtk_notebook_reorder_child(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval position as gint)
declare function gtk_notebook_get_tab_reorderable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_notebook_set_tab_reorderable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval reorderable as gboolean)
declare function gtk_notebook_get_tab_detachable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_notebook_set_tab_detachable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval detachable as gboolean)
declare function gtk_notebook_get_action_widget(byval notebook as GtkNotebook ptr, byval pack_type as GtkPackType) as GtkWidget ptr
declare sub gtk_notebook_set_action_widget(byval notebook as GtkNotebook ptr, byval widget as GtkWidget ptr, byval pack_type as GtkPackType)
declare function gtk_notebook_current_page alias "gtk_notebook_get_current_page"(byval notebook as GtkNotebook ptr) as gint
declare sub gtk_notebook_set_page alias "gtk_notebook_set_current_page"(byval notebook as GtkNotebook ptr, byval page_num as gint)

#define __GTK_OFFSCREEN_WINDOW_H__
#define GTK_TYPE_OFFSCREEN_WINDOW gtk_offscreen_window_get_type()
#define GTK_OFFSCREEN_WINDOW(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_OFFSCREEN_WINDOW, GtkOffscreenWindow)
#define GTK_OFFSCREEN_WINDOW_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_OFFSCREEN_WINDOW, GtkOffscreenWindowClass)
#define GTK_IS_OFFSCREEN_WINDOW(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_OFFSCREEN_WINDOW)
#define GTK_IS_OFFSCREEN_WINDOW_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_OFFSCREEN_WINDOW)
#define GTK_OFFSCREEN_WINDOW_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_OFFSCREEN_WINDOW, GtkOffscreenWindowClass)
type GtkOffscreenWindow as _GtkOffscreenWindow
type GtkOffscreenWindowClass as _GtkOffscreenWindowClass

type _GtkOffscreenWindow
	parent_object as GtkWindow
end type

type _GtkOffscreenWindowClass
	parent_class as GtkWindowClass
end type

declare function gtk_offscreen_window_get_type() as GType
declare function gtk_offscreen_window_new() as GtkWidget ptr
declare function gtk_offscreen_window_get_pixmap(byval offscreen as GtkOffscreenWindow ptr) as GdkPixmap ptr
declare function gtk_offscreen_window_get_pixbuf(byval offscreen as GtkOffscreenWindow ptr) as GdkPixbuf ptr

#define __GTK_ORIENTABLE_H__
#define GTK_TYPE_ORIENTABLE gtk_orientable_get_type()
#define GTK_ORIENTABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ORIENTABLE, GtkOrientable)
#define GTK_ORIENTABLE_CLASS(vtable) G_TYPE_CHECK_CLASS_CAST((vtable), GTK_TYPE_ORIENTABLE, GtkOrientableIface)
#define GTK_IS_ORIENTABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ORIENTABLE)
#define GTK_IS_ORIENTABLE_CLASS(vtable) G_TYPE_CHECK_CLASS_TYPE((vtable), GTK_TYPE_ORIENTABLE)
#define GTK_ORIENTABLE_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_ORIENTABLE, GtkOrientableIface)
type GtkOrientable as _GtkOrientable
type GtkOrientableIface as _GtkOrientableIface

type _GtkOrientableIface
	base_iface as GTypeInterface
end type

declare function gtk_orientable_get_type() as GType
declare sub gtk_orientable_set_orientation(byval orientable as GtkOrientable ptr, byval orientation as GtkOrientation)
declare function gtk_orientable_get_orientation(byval orientable as GtkOrientable ptr) as GtkOrientation
#define __GTK_PAGE_SETUP_H__
#define __GTK_PAPER_SIZE_H__
type GtkPaperSize as _GtkPaperSize

#define GTK_TYPE_PAPER_SIZE gtk_paper_size_get_type()
#define GTK_PAPER_NAME_A3 "iso_a3"
#define GTK_PAPER_NAME_A4 "iso_a4"
#define GTK_PAPER_NAME_A5 "iso_a5"
#define GTK_PAPER_NAME_B5 "iso_b5"
#define GTK_PAPER_NAME_LETTER "na_letter"
#define GTK_PAPER_NAME_EXECUTIVE "na_executive"
#define GTK_PAPER_NAME_LEGAL "na_legal"

declare function gtk_paper_size_get_type() as GType
declare function gtk_paper_size_new(byval name as const gchar ptr) as GtkPaperSize ptr
declare function gtk_paper_size_new_from_ppd(byval ppd_name as const gchar ptr, byval ppd_display_name as const gchar ptr, byval width as gdouble, byval height as gdouble) as GtkPaperSize ptr
declare function gtk_paper_size_new_custom(byval name as const gchar ptr, byval display_name as const gchar ptr, byval width as gdouble, byval height as gdouble, byval unit as GtkUnit) as GtkPaperSize ptr
declare function gtk_paper_size_copy(byval other as GtkPaperSize ptr) as GtkPaperSize ptr
declare sub gtk_paper_size_free(byval size as GtkPaperSize ptr)
declare function gtk_paper_size_is_equal(byval size1 as GtkPaperSize ptr, byval size2 as GtkPaperSize ptr) as gboolean
declare function gtk_paper_size_get_paper_sizes(byval include_custom as gboolean) as GList ptr
declare function gtk_paper_size_get_name(byval size as GtkPaperSize ptr) as const gchar ptr
declare function gtk_paper_size_get_display_name(byval size as GtkPaperSize ptr) as const gchar ptr
declare function gtk_paper_size_get_ppd_name(byval size as GtkPaperSize ptr) as const gchar ptr
declare function gtk_paper_size_get_width(byval size as GtkPaperSize ptr, byval unit as GtkUnit) as gdouble
declare function gtk_paper_size_get_height(byval size as GtkPaperSize ptr, byval unit as GtkUnit) as gdouble
declare function gtk_paper_size_is_custom(byval size as GtkPaperSize ptr) as gboolean
declare sub gtk_paper_size_set_size(byval size as GtkPaperSize ptr, byval width as gdouble, byval height as gdouble, byval unit as GtkUnit)
declare function gtk_paper_size_get_default_top_margin(byval size as GtkPaperSize ptr, byval unit as GtkUnit) as gdouble
declare function gtk_paper_size_get_default_bottom_margin(byval size as GtkPaperSize ptr, byval unit as GtkUnit) as gdouble
declare function gtk_paper_size_get_default_left_margin(byval size as GtkPaperSize ptr, byval unit as GtkUnit) as gdouble
declare function gtk_paper_size_get_default_right_margin(byval size as GtkPaperSize ptr, byval unit as GtkUnit) as gdouble
declare function gtk_paper_size_get_default() as const gchar ptr
declare function gtk_paper_size_new_from_key_file(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval error as GError ptr ptr) as GtkPaperSize ptr
declare sub gtk_paper_size_to_key_file(byval size as GtkPaperSize ptr, byval key_file as GKeyFile ptr, byval group_name as const gchar ptr)
type GtkPageSetup as _GtkPageSetup

#define GTK_TYPE_PAGE_SETUP gtk_page_setup_get_type()
#define GTK_PAGE_SETUP(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PAGE_SETUP, GtkPageSetup)
#define GTK_IS_PAGE_SETUP(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PAGE_SETUP)

declare function gtk_page_setup_get_type() as GType
declare function gtk_page_setup_new() as GtkPageSetup ptr
declare function gtk_page_setup_copy(byval other as GtkPageSetup ptr) as GtkPageSetup ptr
declare function gtk_page_setup_get_orientation(byval setup as GtkPageSetup ptr) as GtkPageOrientation
declare sub gtk_page_setup_set_orientation(byval setup as GtkPageSetup ptr, byval orientation as GtkPageOrientation)
declare function gtk_page_setup_get_paper_size(byval setup as GtkPageSetup ptr) as GtkPaperSize ptr
declare sub gtk_page_setup_set_paper_size(byval setup as GtkPageSetup ptr, byval size as GtkPaperSize ptr)
declare function gtk_page_setup_get_top_margin(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_page_setup_set_top_margin(byval setup as GtkPageSetup ptr, byval margin as gdouble, byval unit as GtkUnit)
declare function gtk_page_setup_get_bottom_margin(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_page_setup_set_bottom_margin(byval setup as GtkPageSetup ptr, byval margin as gdouble, byval unit as GtkUnit)
declare function gtk_page_setup_get_left_margin(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_page_setup_set_left_margin(byval setup as GtkPageSetup ptr, byval margin as gdouble, byval unit as GtkUnit)
declare function gtk_page_setup_get_right_margin(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_page_setup_set_right_margin(byval setup as GtkPageSetup ptr, byval margin as gdouble, byval unit as GtkUnit)
declare sub gtk_page_setup_set_paper_size_and_default_margins(byval setup as GtkPageSetup ptr, byval size as GtkPaperSize ptr)
declare function gtk_page_setup_get_paper_width(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare function gtk_page_setup_get_paper_height(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare function gtk_page_setup_get_page_width(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare function gtk_page_setup_get_page_height(byval setup as GtkPageSetup ptr, byval unit as GtkUnit) as gdouble
declare function gtk_page_setup_new_from_file(byval file_name as const gchar ptr, byval error as GError ptr ptr) as GtkPageSetup ptr
declare function gtk_page_setup_load_file(byval setup as GtkPageSetup ptr, byval file_name as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_page_setup_to_file(byval setup as GtkPageSetup ptr, byval file_name as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_page_setup_new_from_key_file(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval error as GError ptr ptr) as GtkPageSetup ptr
declare function gtk_page_setup_load_key_file(byval setup as GtkPageSetup ptr, byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub gtk_page_setup_to_key_file(byval setup as GtkPageSetup ptr, byval key_file as GKeyFile ptr, byval group_name as const gchar ptr)

#define __GTK_PLUG_H__
#define __GTK_SOCKET_H__
#define GTK_TYPE_SOCKET gtk_socket_get_type()
#define GTK_SOCKET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SOCKET, GtkSocket)
#define GTK_SOCKET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SOCKET, GtkSocketClass)
#define GTK_IS_SOCKET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SOCKET)
#define GTK_IS_SOCKET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SOCKET)
#define GTK_SOCKET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SOCKET, GtkSocketClass)
type GtkSocket as _GtkSocket
type GtkSocketClass as _GtkSocketClass

type _GtkSocket
	container as GtkContainer
	request_width as guint16
	request_height as guint16
	current_width as guint16
	current_height as guint16
	plug_window as GdkWindow ptr
	plug_widget as GtkWidget ptr
	xembed_version as gshort
	same_app : 1 as guint
	focus_in : 1 as guint
	have_size : 1 as guint
	need_map : 1 as guint
	is_mapped : 1 as guint
	active : 1 as guint
	accel_group as GtkAccelGroup ptr
	toplevel as GtkWidget ptr
end type

type _GtkSocketClass
	parent_class as GtkContainerClass
	plug_added as sub(byval socket_ as GtkSocket ptr)
	plug_removed as function(byval socket_ as GtkSocket ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_socket_get_type() as GType
declare function gtk_socket_new() as GtkWidget ptr
declare sub gtk_socket_add_id(byval socket_ as GtkSocket ptr, byval window_id as GdkNativeWindow)
declare function gtk_socket_get_id(byval socket_ as GtkSocket ptr) as GdkNativeWindow
declare function gtk_socket_get_plug_window(byval socket_ as GtkSocket ptr) as GdkWindow ptr
declare sub gtk_socket_steal(byval socket_ as GtkSocket ptr, byval wid as GdkNativeWindow)

#define GTK_TYPE_PLUG gtk_plug_get_type()
#define GTK_PLUG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PLUG, GtkPlug)
#define GTK_PLUG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PLUG, GtkPlugClass)
#define GTK_IS_PLUG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PLUG)
#define GTK_IS_PLUG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PLUG)
#define GTK_PLUG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PLUG, GtkPlugClass)
type GtkPlug as _GtkPlug
type GtkPlugClass as _GtkPlugClass

type _GtkPlug
	window as GtkWindow
	socket_window as GdkWindow ptr
	modality_window as GtkWidget ptr
	modality_group as GtkWindowGroup ptr
	grabbed_keys as GHashTable ptr
	same_app : 1 as guint
end type

type _GtkPlugClass
	parent_class as GtkWindowClass
	embedded as sub(byval plug as GtkPlug ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_plug_get_type() as GType
declare sub gtk_plug_construct(byval plug as GtkPlug ptr, byval socket_id as GdkNativeWindow)
declare function gtk_plug_new(byval socket_id as GdkNativeWindow) as GtkWidget ptr
declare sub gtk_plug_construct_for_display(byval plug as GtkPlug ptr, byval display as GdkDisplay ptr, byval socket_id as GdkNativeWindow)
declare function gtk_plug_new_for_display(byval display as GdkDisplay ptr, byval socket_id as GdkNativeWindow) as GtkWidget ptr
declare function gtk_plug_get_id(byval plug as GtkPlug ptr) as GdkNativeWindow
declare function gtk_plug_get_embedded(byval plug as GtkPlug ptr) as gboolean
declare function gtk_plug_get_socket_window(byval plug as GtkPlug ptr) as GdkWindow ptr
declare sub _gtk_plug_add_to_socket(byval plug as GtkPlug ptr, byval socket_ as GtkSocket ptr)
declare sub _gtk_plug_remove_from_socket(byval plug as GtkPlug ptr, byval socket_ as GtkSocket ptr)
#define __GTK_PRINT_CONTEXT_H__
type GtkPrintContext as _GtkPrintContext

#define GTK_TYPE_PRINT_CONTEXT gtk_print_context_get_type()
#define GTK_PRINT_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PRINT_CONTEXT, GtkPrintContext)
#define GTK_IS_PRINT_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PRINT_CONTEXT)

declare function gtk_print_context_get_type() as GType
declare function gtk_print_context_get_cairo_context(byval context as GtkPrintContext ptr) as cairo_t ptr
declare function gtk_print_context_get_page_setup(byval context as GtkPrintContext ptr) as GtkPageSetup ptr
declare function gtk_print_context_get_width(byval context as GtkPrintContext ptr) as gdouble
declare function gtk_print_context_get_height(byval context as GtkPrintContext ptr) as gdouble
declare function gtk_print_context_get_dpi_x(byval context as GtkPrintContext ptr) as gdouble
declare function gtk_print_context_get_dpi_y(byval context as GtkPrintContext ptr) as gdouble
declare function gtk_print_context_get_hard_margins(byval context as GtkPrintContext ptr, byval top as gdouble ptr, byval bottom as gdouble ptr, byval left as gdouble ptr, byval right as gdouble ptr) as gboolean
declare function gtk_print_context_get_pango_fontmap(byval context as GtkPrintContext ptr) as PangoFontMap ptr
declare function gtk_print_context_create_pango_context(byval context as GtkPrintContext ptr) as PangoContext ptr
declare function gtk_print_context_create_pango_layout(byval context as GtkPrintContext ptr) as PangoLayout ptr
declare sub gtk_print_context_set_cairo_context(byval context as GtkPrintContext ptr, byval cr as cairo_t ptr, byval dpi_x as double, byval dpi_y as double)
#define __GTK_PRINT_OPERATION_H__
#define __GTK_PRINT_SETTINGS_H__
type GtkPrintSettings as _GtkPrintSettings

#define GTK_TYPE_PRINT_SETTINGS gtk_print_settings_get_type()
#define GTK_PRINT_SETTINGS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PRINT_SETTINGS, GtkPrintSettings)
#define GTK_IS_PRINT_SETTINGS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PRINT_SETTINGS)
type GtkPrintSettingsFunc as sub(byval key as const gchar ptr, byval value as const gchar ptr, byval user_data as gpointer)
type GtkPageRange as _GtkPageRange

type _GtkPageRange
	start as gint
	as gint end
end type

declare function gtk_print_settings_get_type() as GType
declare function gtk_print_settings_new() as GtkPrintSettings ptr
declare function gtk_print_settings_copy(byval other as GtkPrintSettings ptr) as GtkPrintSettings ptr
declare function gtk_print_settings_new_from_file(byval file_name as const gchar ptr, byval error as GError ptr ptr) as GtkPrintSettings ptr
declare function gtk_print_settings_load_file(byval settings as GtkPrintSettings ptr, byval file_name as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_print_settings_to_file(byval settings as GtkPrintSettings ptr, byval file_name as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_print_settings_new_from_key_file(byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval error as GError ptr ptr) as GtkPrintSettings ptr
declare function gtk_print_settings_load_key_file(byval settings as GtkPrintSettings ptr, byval key_file as GKeyFile ptr, byval group_name as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub gtk_print_settings_to_key_file(byval settings as GtkPrintSettings ptr, byval key_file as GKeyFile ptr, byval group_name as const gchar ptr)
declare function gtk_print_settings_has_key(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr) as gboolean
declare function gtk_print_settings_get(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr) as const gchar ptr
declare sub gtk_print_settings_set(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval value as const gchar ptr)
declare sub gtk_print_settings_unset(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr)
declare sub gtk_print_settings_foreach(byval settings as GtkPrintSettings ptr, byval func as GtkPrintSettingsFunc, byval user_data as gpointer)
declare function gtk_print_settings_get_bool(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr) as gboolean
declare sub gtk_print_settings_set_bool(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval value as gboolean)
declare function gtk_print_settings_get_double(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr) as gdouble
declare function gtk_print_settings_get_double_with_default(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval def as gdouble) as gdouble
declare sub gtk_print_settings_set_double(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval value as gdouble)
declare function gtk_print_settings_get_length(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_print_settings_set_length(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval value as gdouble, byval unit as GtkUnit)
declare function gtk_print_settings_get_int(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr) as gint
declare function gtk_print_settings_get_int_with_default(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval def as gint) as gint
declare sub gtk_print_settings_set_int(byval settings as GtkPrintSettings ptr, byval key as const gchar ptr, byval value as gint)

#define GTK_PRINT_SETTINGS_PRINTER "printer"
#define GTK_PRINT_SETTINGS_ORIENTATION "orientation"
#define GTK_PRINT_SETTINGS_PAPER_FORMAT "paper-format"
#define GTK_PRINT_SETTINGS_PAPER_WIDTH "paper-width"
#define GTK_PRINT_SETTINGS_PAPER_HEIGHT "paper-height"
#define GTK_PRINT_SETTINGS_N_COPIES "n-copies"
#define GTK_PRINT_SETTINGS_DEFAULT_SOURCE "default-source"
#define GTK_PRINT_SETTINGS_QUALITY "quality"
#define GTK_PRINT_SETTINGS_RESOLUTION "resolution"
#define GTK_PRINT_SETTINGS_USE_COLOR "use-color"
#define GTK_PRINT_SETTINGS_DUPLEX "duplex"
#define GTK_PRINT_SETTINGS_COLLATE "collate"
#define GTK_PRINT_SETTINGS_REVERSE "reverse"
#define GTK_PRINT_SETTINGS_MEDIA_TYPE "media-type"
#define GTK_PRINT_SETTINGS_DITHER "dither"
#define GTK_PRINT_SETTINGS_SCALE "scale"
#define GTK_PRINT_SETTINGS_PRINT_PAGES "print-pages"
#define GTK_PRINT_SETTINGS_PAGE_RANGES "page-ranges"
#define GTK_PRINT_SETTINGS_PAGE_SET "page-set"
#define GTK_PRINT_SETTINGS_FINISHINGS "finishings"
#define GTK_PRINT_SETTINGS_NUMBER_UP "number-up"
#define GTK_PRINT_SETTINGS_NUMBER_UP_LAYOUT "number-up-layout"
#define GTK_PRINT_SETTINGS_OUTPUT_BIN "output-bin"
#define GTK_PRINT_SETTINGS_RESOLUTION_X "resolution-x"
#define GTK_PRINT_SETTINGS_RESOLUTION_Y "resolution-y"
#define GTK_PRINT_SETTINGS_PRINTER_LPI "printer-lpi"
#define GTK_PRINT_SETTINGS_OUTPUT_FILE_FORMAT "output-file-format"
#define GTK_PRINT_SETTINGS_OUTPUT_URI "output-uri"
#define GTK_PRINT_SETTINGS_WIN32_DRIVER_VERSION "win32-driver-version"
#define GTK_PRINT_SETTINGS_WIN32_DRIVER_EXTRA "win32-driver-extra"

declare function gtk_print_settings_get_printer(byval settings as GtkPrintSettings ptr) as const gchar ptr
declare sub gtk_print_settings_set_printer(byval settings as GtkPrintSettings ptr, byval printer as const gchar ptr)
declare function gtk_print_settings_get_orientation(byval settings as GtkPrintSettings ptr) as GtkPageOrientation
declare sub gtk_print_settings_set_orientation(byval settings as GtkPrintSettings ptr, byval orientation as GtkPageOrientation)
declare function gtk_print_settings_get_paper_size(byval settings as GtkPrintSettings ptr) as GtkPaperSize ptr
declare sub gtk_print_settings_set_paper_size(byval settings as GtkPrintSettings ptr, byval paper_size as GtkPaperSize ptr)
declare function gtk_print_settings_get_paper_width(byval settings as GtkPrintSettings ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_print_settings_set_paper_width(byval settings as GtkPrintSettings ptr, byval width as gdouble, byval unit as GtkUnit)
declare function gtk_print_settings_get_paper_height(byval settings as GtkPrintSettings ptr, byval unit as GtkUnit) as gdouble
declare sub gtk_print_settings_set_paper_height(byval settings as GtkPrintSettings ptr, byval height as gdouble, byval unit as GtkUnit)
declare function gtk_print_settings_get_use_color(byval settings as GtkPrintSettings ptr) as gboolean
declare sub gtk_print_settings_set_use_color(byval settings as GtkPrintSettings ptr, byval use_color as gboolean)
declare function gtk_print_settings_get_collate(byval settings as GtkPrintSettings ptr) as gboolean
declare sub gtk_print_settings_set_collate(byval settings as GtkPrintSettings ptr, byval collate as gboolean)
declare function gtk_print_settings_get_reverse(byval settings as GtkPrintSettings ptr) as gboolean
declare sub gtk_print_settings_set_reverse(byval settings as GtkPrintSettings ptr, byval reverse as gboolean)
declare function gtk_print_settings_get_duplex(byval settings as GtkPrintSettings ptr) as GtkPrintDuplex
declare sub gtk_print_settings_set_duplex(byval settings as GtkPrintSettings ptr, byval duplex as GtkPrintDuplex)
declare function gtk_print_settings_get_quality(byval settings as GtkPrintSettings ptr) as GtkPrintQuality
declare sub gtk_print_settings_set_quality(byval settings as GtkPrintSettings ptr, byval quality as GtkPrintQuality)
declare function gtk_print_settings_get_n_copies(byval settings as GtkPrintSettings ptr) as gint
declare sub gtk_print_settings_set_n_copies(byval settings as GtkPrintSettings ptr, byval num_copies as gint)
declare function gtk_print_settings_get_number_up(byval settings as GtkPrintSettings ptr) as gint
declare sub gtk_print_settings_set_number_up(byval settings as GtkPrintSettings ptr, byval number_up as gint)
declare function gtk_print_settings_get_number_up_layout(byval settings as GtkPrintSettings ptr) as GtkNumberUpLayout
declare sub gtk_print_settings_set_number_up_layout(byval settings as GtkPrintSettings ptr, byval number_up_layout as GtkNumberUpLayout)
declare function gtk_print_settings_get_resolution(byval settings as GtkPrintSettings ptr) as gint
declare sub gtk_print_settings_set_resolution(byval settings as GtkPrintSettings ptr, byval resolution as gint)
declare function gtk_print_settings_get_resolution_x(byval settings as GtkPrintSettings ptr) as gint
declare function gtk_print_settings_get_resolution_y(byval settings as GtkPrintSettings ptr) as gint
declare sub gtk_print_settings_set_resolution_xy(byval settings as GtkPrintSettings ptr, byval resolution_x as gint, byval resolution_y as gint)
declare function gtk_print_settings_get_printer_lpi(byval settings as GtkPrintSettings ptr) as gdouble
declare sub gtk_print_settings_set_printer_lpi(byval settings as GtkPrintSettings ptr, byval lpi as gdouble)
declare function gtk_print_settings_get_scale(byval settings as GtkPrintSettings ptr) as gdouble
declare sub gtk_print_settings_set_scale(byval settings as GtkPrintSettings ptr, byval scale as gdouble)
declare function gtk_print_settings_get_print_pages(byval settings as GtkPrintSettings ptr) as GtkPrintPages
declare sub gtk_print_settings_set_print_pages(byval settings as GtkPrintSettings ptr, byval pages as GtkPrintPages)
declare function gtk_print_settings_get_page_ranges(byval settings as GtkPrintSettings ptr, byval num_ranges as gint ptr) as GtkPageRange ptr
declare sub gtk_print_settings_set_page_ranges(byval settings as GtkPrintSettings ptr, byval page_ranges as GtkPageRange ptr, byval num_ranges as gint)
declare function gtk_print_settings_get_page_set(byval settings as GtkPrintSettings ptr) as GtkPageSet
declare sub gtk_print_settings_set_page_set(byval settings as GtkPrintSettings ptr, byval page_set as GtkPageSet)
declare function gtk_print_settings_get_default_source(byval settings as GtkPrintSettings ptr) as const gchar ptr
declare sub gtk_print_settings_set_default_source(byval settings as GtkPrintSettings ptr, byval default_source as const gchar ptr)
declare function gtk_print_settings_get_media_type(byval settings as GtkPrintSettings ptr) as const gchar ptr
declare sub gtk_print_settings_set_media_type(byval settings as GtkPrintSettings ptr, byval media_type as const gchar ptr)
declare function gtk_print_settings_get_dither(byval settings as GtkPrintSettings ptr) as const gchar ptr
declare sub gtk_print_settings_set_dither(byval settings as GtkPrintSettings ptr, byval dither as const gchar ptr)
declare function gtk_print_settings_get_finishings(byval settings as GtkPrintSettings ptr) as const gchar ptr
declare sub gtk_print_settings_set_finishings(byval settings as GtkPrintSettings ptr, byval finishings as const gchar ptr)
declare function gtk_print_settings_get_output_bin(byval settings as GtkPrintSettings ptr) as const gchar ptr
declare sub gtk_print_settings_set_output_bin(byval settings as GtkPrintSettings ptr, byval output_bin as const gchar ptr)

#define __GTK_PRINT_OPERATION_PREVIEW_H__
#define GTK_TYPE_PRINT_OPERATION_PREVIEW gtk_print_operation_preview_get_type()
#define GTK_PRINT_OPERATION_PREVIEW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW, GtkPrintOperationPreview)
#define GTK_IS_PRINT_OPERATION_PREVIEW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW)
#define GTK_PRINT_OPERATION_PREVIEW_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW, GtkPrintOperationPreviewIface)
type GtkPrintOperationPreview as _GtkPrintOperationPreview
type GtkPrintOperationPreviewIface as _GtkPrintOperationPreviewIface

type _GtkPrintOperationPreviewIface
	g_iface as GTypeInterface
	ready as sub(byval preview as GtkPrintOperationPreview ptr, byval context as GtkPrintContext ptr)
	got_page_size as sub(byval preview as GtkPrintOperationPreview ptr, byval context as GtkPrintContext ptr, byval page_setup as GtkPageSetup ptr)
	render_page as sub(byval preview as GtkPrintOperationPreview ptr, byval page_nr as gint)
	is_selected as function(byval preview as GtkPrintOperationPreview ptr, byval page_nr as gint) as gboolean
	end_preview as sub(byval preview as GtkPrintOperationPreview ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
end type

declare function gtk_print_operation_preview_get_type() as GType
declare sub gtk_print_operation_preview_render_page(byval preview as GtkPrintOperationPreview ptr, byval page_nr as gint)
declare sub gtk_print_operation_preview_end_preview(byval preview as GtkPrintOperationPreview ptr)
declare function gtk_print_operation_preview_is_selected(byval preview as GtkPrintOperationPreview ptr, byval page_nr as gint) as gboolean

#define GTK_TYPE_PRINT_OPERATION gtk_print_operation_get_type()
#define GTK_PRINT_OPERATION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PRINT_OPERATION, GtkPrintOperation)
#define GTK_PRINT_OPERATION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PRINT_OPERATION, GtkPrintOperationClass)
#define GTK_IS_PRINT_OPERATION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PRINT_OPERATION)
#define GTK_IS_PRINT_OPERATION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PRINT_OPERATION)
#define GTK_PRINT_OPERATION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PRINT_OPERATION, GtkPrintOperationClass)

type GtkPrintOperationClass as _GtkPrintOperationClass
type GtkPrintOperationPrivate as _GtkPrintOperationPrivate
type GtkPrintOperation as _GtkPrintOperation

type GtkPrintStatus as long
enum
	GTK_PRINT_STATUS_INITIAL
	GTK_PRINT_STATUS_PREPARING
	GTK_PRINT_STATUS_GENERATING_DATA
	GTK_PRINT_STATUS_SENDING_DATA
	GTK_PRINT_STATUS_PENDING
	GTK_PRINT_STATUS_PENDING_ISSUE
	GTK_PRINT_STATUS_PRINTING
	GTK_PRINT_STATUS_FINISHED
	GTK_PRINT_STATUS_FINISHED_ABORTED
end enum

type GtkPrintOperationResult as long
enum
	GTK_PRINT_OPERATION_RESULT_ERROR
	GTK_PRINT_OPERATION_RESULT_APPLY
	GTK_PRINT_OPERATION_RESULT_CANCEL
	GTK_PRINT_OPERATION_RESULT_IN_PROGRESS
end enum

type GtkPrintOperationAction as long
enum
	GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG
	GTK_PRINT_OPERATION_ACTION_PRINT
	GTK_PRINT_OPERATION_ACTION_PREVIEW
	GTK_PRINT_OPERATION_ACTION_EXPORT
end enum

type _GtkPrintOperation
	parent_instance as GObject
	priv as GtkPrintOperationPrivate ptr
end type

type _GtkPrintOperationClass
	parent_class as GObjectClass
	done as sub(byval operation as GtkPrintOperation ptr, byval result as GtkPrintOperationResult)
	begin_print as sub(byval operation as GtkPrintOperation ptr, byval context as GtkPrintContext ptr)
	paginate as function(byval operation as GtkPrintOperation ptr, byval context as GtkPrintContext ptr) as gboolean
	request_page_setup as sub(byval operation as GtkPrintOperation ptr, byval context as GtkPrintContext ptr, byval page_nr as gint, byval setup as GtkPageSetup ptr)
	draw_page as sub(byval operation as GtkPrintOperation ptr, byval context as GtkPrintContext ptr, byval page_nr as gint)
	end_print as sub(byval operation as GtkPrintOperation ptr, byval context as GtkPrintContext ptr)
	status_changed as sub(byval operation as GtkPrintOperation ptr)
	create_custom_widget as function(byval operation as GtkPrintOperation ptr) as GtkWidget ptr
	custom_widget_apply as sub(byval operation as GtkPrintOperation ptr, byval widget as GtkWidget ptr)
	preview as function(byval operation as GtkPrintOperation ptr, byval preview as GtkPrintOperationPreview ptr, byval context as GtkPrintContext ptr, byval parent as GtkWindow ptr) as gboolean
	update_custom_widget as sub(byval operation as GtkPrintOperation ptr, byval widget as GtkWidget ptr, byval setup as GtkPageSetup ptr, byval settings as GtkPrintSettings ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
end type

#define GTK_PRINT_ERROR gtk_print_error_quark()

type GtkPrintError as long
enum
	GTK_PRINT_ERROR_GENERAL
	GTK_PRINT_ERROR_INTERNAL_ERROR
	GTK_PRINT_ERROR_NOMEM
	GTK_PRINT_ERROR_INVALID_FILE
end enum

declare function gtk_print_error_quark() as GQuark
declare function gtk_print_operation_get_type() as GType
declare function gtk_print_operation_new() as GtkPrintOperation ptr
declare sub gtk_print_operation_set_default_page_setup(byval op as GtkPrintOperation ptr, byval default_page_setup as GtkPageSetup ptr)
declare function gtk_print_operation_get_default_page_setup(byval op as GtkPrintOperation ptr) as GtkPageSetup ptr
declare sub gtk_print_operation_set_print_settings(byval op as GtkPrintOperation ptr, byval print_settings as GtkPrintSettings ptr)
declare function gtk_print_operation_get_print_settings(byval op as GtkPrintOperation ptr) as GtkPrintSettings ptr
declare sub gtk_print_operation_set_job_name(byval op as GtkPrintOperation ptr, byval job_name as const gchar ptr)
declare sub gtk_print_operation_set_n_pages(byval op as GtkPrintOperation ptr, byval n_pages as gint)
declare sub gtk_print_operation_set_current_page(byval op as GtkPrintOperation ptr, byval current_page as gint)
declare sub gtk_print_operation_set_use_full_page(byval op as GtkPrintOperation ptr, byval full_page as gboolean)
declare sub gtk_print_operation_set_unit(byval op as GtkPrintOperation ptr, byval unit as GtkUnit)
declare sub gtk_print_operation_set_export_filename(byval op as GtkPrintOperation ptr, byval filename as const gchar ptr)
declare sub gtk_print_operation_set_track_print_status(byval op as GtkPrintOperation ptr, byval track_status as gboolean)
declare sub gtk_print_operation_set_show_progress(byval op as GtkPrintOperation ptr, byval show_progress as gboolean)
declare sub gtk_print_operation_set_allow_async(byval op as GtkPrintOperation ptr, byval allow_async as gboolean)
declare sub gtk_print_operation_set_custom_tab_label(byval op as GtkPrintOperation ptr, byval label as const gchar ptr)
declare function gtk_print_operation_run(byval op as GtkPrintOperation ptr, byval action as GtkPrintOperationAction, byval parent as GtkWindow ptr, byval error as GError ptr ptr) as GtkPrintOperationResult
declare sub gtk_print_operation_get_error(byval op as GtkPrintOperation ptr, byval error as GError ptr ptr)
declare function gtk_print_operation_get_status(byval op as GtkPrintOperation ptr) as GtkPrintStatus
declare function gtk_print_operation_get_status_string(byval op as GtkPrintOperation ptr) as const gchar ptr
declare function gtk_print_operation_is_finished(byval op as GtkPrintOperation ptr) as gboolean
declare sub gtk_print_operation_cancel(byval op as GtkPrintOperation ptr)
declare sub gtk_print_operation_draw_page_finish(byval op as GtkPrintOperation ptr)
declare sub gtk_print_operation_set_defer_drawing(byval op as GtkPrintOperation ptr)
declare sub gtk_print_operation_set_support_selection(byval op as GtkPrintOperation ptr, byval support_selection as gboolean)
declare function gtk_print_operation_get_support_selection(byval op as GtkPrintOperation ptr) as gboolean
declare sub gtk_print_operation_set_has_selection(byval op as GtkPrintOperation ptr, byval has_selection as gboolean)
declare function gtk_print_operation_get_has_selection(byval op as GtkPrintOperation ptr) as gboolean
declare sub gtk_print_operation_set_embed_page_setup(byval op as GtkPrintOperation ptr, byval embed as gboolean)
declare function gtk_print_operation_get_embed_page_setup(byval op as GtkPrintOperation ptr) as gboolean
declare function gtk_print_operation_get_n_pages_to_print(byval op as GtkPrintOperation ptr) as gint
declare function gtk_print_run_page_setup_dialog(byval parent as GtkWindow ptr, byval page_setup as GtkPageSetup ptr, byval settings as GtkPrintSettings ptr) as GtkPageSetup ptr
type GtkPageSetupDoneFunc as sub(byval page_setup as GtkPageSetup ptr, byval data as gpointer)
declare sub gtk_print_run_page_setup_dialog_async(byval parent as GtkWindow ptr, byval page_setup as GtkPageSetup ptr, byval settings as GtkPrintSettings ptr, byval done_cb as GtkPageSetupDoneFunc, byval data as gpointer)

#define __GTK_PROGRESS_BAR_H__
#define __GTK_PROGRESS_H__
#define GTK_TYPE_PROGRESS gtk_progress_get_type()
#define GTK_PROGRESS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PROGRESS, GtkProgress)
#define GTK_PROGRESS_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PROGRESS, GtkProgressClass)
#define GTK_IS_PROGRESS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PROGRESS)
#define GTK_IS_PROGRESS_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PROGRESS)
#define GTK_PROGRESS_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PROGRESS, GtkProgressClass)
type GtkProgress as _GtkProgress
type GtkProgressClass as _GtkProgressClass

type _GtkProgress
	widget as GtkWidget
	adjustment as GtkAdjustment ptr
	offscreen_pixmap as GdkPixmap ptr
	format as gchar ptr
	x_align as gfloat
	y_align as gfloat
	show_text : 1 as guint
	activity_mode : 1 as guint
	use_text_format : 1 as guint
end type

type _GtkProgressClass
	parent_class as GtkWidgetClass
	paint as sub(byval progress as GtkProgress ptr)
	update as sub(byval progress as GtkProgress ptr)
	act_mode_enter as sub(byval progress as GtkProgress ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_progress_get_type() as GType
declare sub gtk_progress_set_show_text(byval progress as GtkProgress ptr, byval show_text as gboolean)
declare sub gtk_progress_set_text_alignment(byval progress as GtkProgress ptr, byval x_align as gfloat, byval y_align as gfloat)
declare sub gtk_progress_set_format_string(byval progress as GtkProgress ptr, byval format as const gchar ptr)
declare sub gtk_progress_set_adjustment(byval progress as GtkProgress ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_progress_configure(byval progress as GtkProgress ptr, byval value as gdouble, byval min as gdouble, byval max as gdouble)
declare sub gtk_progress_set_percentage(byval progress as GtkProgress ptr, byval percentage as gdouble)
declare sub gtk_progress_set_value(byval progress as GtkProgress ptr, byval value as gdouble)
declare function gtk_progress_get_value(byval progress as GtkProgress ptr) as gdouble
declare sub gtk_progress_set_activity_mode(byval progress as GtkProgress ptr, byval activity_mode as gboolean)
declare function gtk_progress_get_current_text(byval progress as GtkProgress ptr) as gchar ptr
declare function gtk_progress_get_text_from_value(byval progress as GtkProgress ptr, byval value as gdouble) as gchar ptr
declare function gtk_progress_get_current_percentage(byval progress as GtkProgress ptr) as gdouble
declare function gtk_progress_get_percentage_from_value(byval progress as GtkProgress ptr, byval value as gdouble) as gdouble

#define GTK_TYPE_PROGRESS_BAR gtk_progress_bar_get_type()
#define GTK_PROGRESS_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBar)
#define GTK_PROGRESS_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PROGRESS_BAR, GtkProgressBarClass)
#define GTK_IS_PROGRESS_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PROGRESS_BAR)
#define GTK_IS_PROGRESS_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PROGRESS_BAR)
#define GTK_PROGRESS_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBarClass)
type GtkProgressBar as _GtkProgressBar
type GtkProgressBarClass as _GtkProgressBarClass

type GtkProgressBarStyle as long
enum
	GTK_PROGRESS_CONTINUOUS
	GTK_PROGRESS_DISCRETE
end enum

type GtkProgressBarOrientation as long
enum
	GTK_PROGRESS_LEFT_TO_RIGHT
	GTK_PROGRESS_RIGHT_TO_LEFT
	GTK_PROGRESS_BOTTOM_TO_TOP
	GTK_PROGRESS_TOP_TO_BOTTOM
end enum

type _GtkProgressBar
	progress as GtkProgress
	bar_style as GtkProgressBarStyle
	orientation as GtkProgressBarOrientation
	blocks as guint
	in_block as gint
	activity_pos as gint
	activity_step as guint
	activity_blocks as guint
	pulse_fraction as gdouble
	activity_dir : 1 as guint
	ellipsize : 3 as guint
	dirty : 1 as guint
end type

type _GtkProgressBarClass
	parent_class as GtkProgressClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_progress_bar_get_type() as GType
declare function gtk_progress_bar_new() as GtkWidget ptr
declare sub gtk_progress_bar_pulse(byval pbar as GtkProgressBar ptr)
declare sub gtk_progress_bar_set_text(byval pbar as GtkProgressBar ptr, byval text as const gchar ptr)
declare sub gtk_progress_bar_set_fraction(byval pbar as GtkProgressBar ptr, byval fraction as gdouble)
declare sub gtk_progress_bar_set_pulse_step(byval pbar as GtkProgressBar ptr, byval fraction as gdouble)
declare sub gtk_progress_bar_set_orientation(byval pbar as GtkProgressBar ptr, byval orientation as GtkProgressBarOrientation)
declare function gtk_progress_bar_get_text(byval pbar as GtkProgressBar ptr) as const gchar ptr
declare function gtk_progress_bar_get_fraction(byval pbar as GtkProgressBar ptr) as gdouble
declare function gtk_progress_bar_get_pulse_step(byval pbar as GtkProgressBar ptr) as gdouble
declare function gtk_progress_bar_get_orientation(byval pbar as GtkProgressBar ptr) as GtkProgressBarOrientation
declare sub gtk_progress_bar_set_ellipsize(byval pbar as GtkProgressBar ptr, byval mode as PangoEllipsizeMode)
declare function gtk_progress_bar_get_ellipsize(byval pbar as GtkProgressBar ptr) as PangoEllipsizeMode
declare function gtk_progress_bar_new_with_adjustment(byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare sub gtk_progress_bar_set_bar_style(byval pbar as GtkProgressBar ptr, byval style as GtkProgressBarStyle)
declare sub gtk_progress_bar_set_discrete_blocks(byval pbar as GtkProgressBar ptr, byval blocks as guint)
declare sub gtk_progress_bar_set_activity_step(byval pbar as GtkProgressBar ptr, byval step as guint)
declare sub gtk_progress_bar_set_activity_blocks(byval pbar as GtkProgressBar ptr, byval blocks as guint)
declare sub gtk_progress_bar_update(byval pbar as GtkProgressBar ptr, byval percentage as gdouble)

#define __GTK_RADIO_ACTION_H__
#define __GTK_TOGGLE_ACTION_H__
#define GTK_TYPE_TOGGLE_ACTION gtk_toggle_action_get_type()
#define GTK_TOGGLE_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOGGLE_ACTION, GtkToggleAction)
#define GTK_TOGGLE_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOGGLE_ACTION, GtkToggleActionClass)
#define GTK_IS_TOGGLE_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOGGLE_ACTION)
#define GTK_IS_TOGGLE_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOGGLE_ACTION)
#define GTK_TOGGLE_ACTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_ACTION, GtkToggleActionClass)

type GtkToggleAction as _GtkToggleAction
type GtkToggleActionPrivate as _GtkToggleActionPrivate
type GtkToggleActionClass as _GtkToggleActionClass

type _GtkToggleAction
	parent as GtkAction
	private_data as GtkToggleActionPrivate ptr
end type

type _GtkToggleActionClass
	parent_class as GtkActionClass
	toggled as sub(byval action as GtkToggleAction ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_toggle_action_get_type() as GType
declare function gtk_toggle_action_new(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr) as GtkToggleAction ptr
declare sub gtk_toggle_action_toggled(byval action as GtkToggleAction ptr)
declare sub gtk_toggle_action_set_active(byval action as GtkToggleAction ptr, byval is_active as gboolean)
declare function gtk_toggle_action_get_active(byval action as GtkToggleAction ptr) as gboolean
declare sub gtk_toggle_action_set_draw_as_radio(byval action as GtkToggleAction ptr, byval draw_as_radio as gboolean)
declare function gtk_toggle_action_get_draw_as_radio(byval action as GtkToggleAction ptr) as gboolean

#define GTK_TYPE_RADIO_ACTION gtk_radio_action_get_type()
#define GTK_RADIO_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RADIO_ACTION, GtkRadioAction)
#define GTK_RADIO_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RADIO_ACTION, GtkRadioActionClass)
#define GTK_IS_RADIO_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RADIO_ACTION)
#define GTK_IS_RADIO_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RADIO_ACTION)
#define GTK_RADIO_ACTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_ACTION, GtkRadioActionClass)

type GtkRadioAction as _GtkRadioAction
type GtkRadioActionPrivate as _GtkRadioActionPrivate
type GtkRadioActionClass as _GtkRadioActionClass

type _GtkRadioAction
	parent as GtkToggleAction
	private_data as GtkRadioActionPrivate ptr
end type

type _GtkRadioActionClass
	parent_class as GtkToggleActionClass
	changed as sub(byval action as GtkRadioAction ptr, byval current as GtkRadioAction ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_radio_action_get_type() as GType
declare function gtk_radio_action_new(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr, byval value as gint) as GtkRadioAction ptr
declare function gtk_radio_action_get_group(byval action as GtkRadioAction ptr) as GSList ptr
declare sub gtk_radio_action_set_group(byval action as GtkRadioAction ptr, byval group as GSList ptr)
declare function gtk_radio_action_get_current_value(byval action as GtkRadioAction ptr) as gint
declare sub gtk_radio_action_set_current_value(byval action as GtkRadioAction ptr, byval current_value as gint)

#define __GTK_RADIO_BUTTON_H__
#define GTK_TYPE_RADIO_BUTTON gtk_radio_button_get_type()
#define GTK_RADIO_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButton)
#define GTK_RADIO_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass)
#define GTK_IS_RADIO_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RADIO_BUTTON)
#define GTK_IS_RADIO_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RADIO_BUTTON)
#define GTK_RADIO_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass)
type GtkRadioButton as _GtkRadioButton
type GtkRadioButtonClass as _GtkRadioButtonClass

type _GtkRadioButton
	check_button as GtkCheckButton
	group as GSList ptr
end type

type _GtkRadioButtonClass
	parent_class as GtkCheckButtonClass
	group_changed as sub(byval radio_button as GtkRadioButton ptr)
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_radio_button_get_type() as GType
declare function gtk_radio_button_new(byval group as GSList ptr) as GtkWidget ptr
declare function gtk_radio_button_new_from_widget(byval radio_group_member as GtkRadioButton ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_label(byval group as GSList ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_label_from_widget(byval radio_group_member as GtkRadioButton ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_mnemonic(byval group as GSList ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_new_with_mnemonic_from_widget(byval radio_group_member as GtkRadioButton ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_button_get_group(byval radio_button as GtkRadioButton ptr) as GSList ptr
declare sub gtk_radio_button_set_group(byval radio_button as GtkRadioButton ptr, byval group as GSList ptr)
declare function gtk_radio_button_group alias "gtk_radio_button_get_group"(byval radio_button as GtkRadioButton ptr) as GSList ptr

#define __GTK_RADIO_MENU_ITEM_H__
#define GTK_TYPE_RADIO_MENU_ITEM gtk_radio_menu_item_get_type()
#define GTK_RADIO_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItem)
#define GTK_RADIO_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass)
#define GTK_IS_RADIO_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RADIO_MENU_ITEM)
#define GTK_IS_RADIO_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RADIO_MENU_ITEM)
#define GTK_RADIO_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass)
type GtkRadioMenuItem as _GtkRadioMenuItem
type GtkRadioMenuItemClass as _GtkRadioMenuItemClass

type _GtkRadioMenuItem
	check_menu_item as GtkCheckMenuItem
	group as GSList ptr
end type

type _GtkRadioMenuItemClass
	parent_class as GtkCheckMenuItemClass
	group_changed as sub(byval radio_menu_item as GtkRadioMenuItem ptr)
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_radio_menu_item_get_type() as GType
declare function gtk_radio_menu_item_new(byval group as GSList ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_label(byval group as GSList ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_mnemonic(byval group as GSList ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_from_widget(byval group as GtkRadioMenuItem ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_mnemonic_from_widget(byval group as GtkRadioMenuItem ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_new_with_label_from_widget(byval group as GtkRadioMenuItem ptr, byval label as const gchar ptr) as GtkWidget ptr
declare function gtk_radio_menu_item_get_group(byval radio_menu_item as GtkRadioMenuItem ptr) as GSList ptr
declare sub gtk_radio_menu_item_set_group(byval radio_menu_item as GtkRadioMenuItem ptr, byval group as GSList ptr)
declare function gtk_radio_menu_item_group alias "gtk_radio_menu_item_get_group"(byval radio_menu_item as GtkRadioMenuItem ptr) as GSList ptr

#define __GTK_RADIO_TOOL_BUTTON_H__
#define __GTK_TOGGLE_TOOL_BUTTON_H__
#define GTK_TYPE_TOGGLE_TOOL_BUTTON gtk_toggle_tool_button_get_type()
#define GTK_TOGGLE_TOOL_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButton)
#define GTK_TOGGLE_TOOL_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButtonClass)
#define GTK_IS_TOGGLE_TOOL_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON)
#define GTK_IS_TOGGLE_TOOL_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOGGLE_TOOL_BUTTON)
#define GTK_TOGGLE_TOOL_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButtonClass)

type GtkToggleToolButton as _GtkToggleToolButton
type GtkToggleToolButtonClass as _GtkToggleToolButtonClass
type GtkToggleToolButtonPrivate as _GtkToggleToolButtonPrivate

type _GtkToggleToolButton
	parent as GtkToolButton
	priv as GtkToggleToolButtonPrivate ptr
end type

type _GtkToggleToolButtonClass
	parent_class as GtkToolButtonClass
	toggled as sub(byval button as GtkToggleToolButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_toggle_tool_button_get_type() as GType
declare function gtk_toggle_tool_button_new() as GtkToolItem ptr
declare function gtk_toggle_tool_button_new_from_stock(byval stock_id as const gchar ptr) as GtkToolItem ptr
declare sub gtk_toggle_tool_button_set_active(byval button as GtkToggleToolButton ptr, byval is_active as gboolean)
declare function gtk_toggle_tool_button_get_active(byval button as GtkToggleToolButton ptr) as gboolean

#define GTK_TYPE_RADIO_TOOL_BUTTON gtk_radio_tool_button_get_type()
#define GTK_RADIO_TOOL_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButton)
#define GTK_RADIO_TOOL_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButtonClass)
#define GTK_IS_RADIO_TOOL_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RADIO_TOOL_BUTTON)
#define GTK_IS_RADIO_TOOL_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RADIO_TOOL_BUTTON)
#define GTK_RADIO_TOOL_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButtonClass)
type GtkRadioToolButton as _GtkRadioToolButton
type GtkRadioToolButtonClass as _GtkRadioToolButtonClass

type _GtkRadioToolButton
	parent as GtkToggleToolButton
end type

type _GtkRadioToolButtonClass
	parent_class as GtkToggleToolButtonClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_radio_tool_button_get_type() as GType
declare function gtk_radio_tool_button_new(byval group as GSList ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_new_from_stock(byval group as GSList ptr, byval stock_id as const gchar ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_new_from_widget(byval group as GtkRadioToolButton ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_new_with_stock_from_widget(byval group as GtkRadioToolButton ptr, byval stock_id as const gchar ptr) as GtkToolItem ptr
declare function gtk_radio_tool_button_get_group(byval button as GtkRadioToolButton ptr) as GSList ptr
declare sub gtk_radio_tool_button_set_group(byval button as GtkRadioToolButton ptr, byval group as GSList ptr)

#define __GTK_RECENT_ACTION_H__
#define __GTK_RECENT_MANAGER_H__
#define GTK_TYPE_RECENT_INFO gtk_recent_info_get_type()
#define GTK_TYPE_RECENT_MANAGER gtk_recent_manager_get_type()
#define GTK_RECENT_MANAGER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_MANAGER, GtkRecentManager)
#define GTK_IS_RECENT_MANAGER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_MANAGER)
#define GTK_RECENT_MANAGER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RECENT_MANAGER, GtkRecentManagerClass)
#define GTK_IS_RECENT_MANAGER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RECENT_MANAGER)
#define GTK_RECENT_MANAGER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RECENT_MANAGER, GtkRecentManagerClass)

type GtkRecentInfo as _GtkRecentInfo
type GtkRecentData as _GtkRecentData
type GtkRecentManager as _GtkRecentManager
type GtkRecentManagerClass as _GtkRecentManagerClass
type GtkRecentManagerPrivate as _GtkRecentManagerPrivate

type _GtkRecentData
	display_name as gchar ptr
	description as gchar ptr
	mime_type as gchar ptr
	app_name as gchar ptr
	app_exec as gchar ptr
	groups as gchar ptr ptr
	is_private as gboolean
end type

type _GtkRecentManager
	parent_instance as GObject
	priv as GtkRecentManagerPrivate ptr
end type

type _GtkRecentManagerClass
	parent_class as GObjectClass
	changed as sub(byval manager as GtkRecentManager ptr)
	_gtk_recent1 as sub()
	_gtk_recent2 as sub()
	_gtk_recent3 as sub()
	_gtk_recent4 as sub()
end type

type GtkRecentManagerError as long
enum
	GTK_RECENT_MANAGER_ERROR_NOT_FOUND
	GTK_RECENT_MANAGER_ERROR_INVALID_URI
	GTK_RECENT_MANAGER_ERROR_INVALID_ENCODING
	GTK_RECENT_MANAGER_ERROR_NOT_REGISTERED
	GTK_RECENT_MANAGER_ERROR_READ
	GTK_RECENT_MANAGER_ERROR_WRITE
	GTK_RECENT_MANAGER_ERROR_UNKNOWN
end enum

#define GTK_RECENT_MANAGER_ERROR gtk_recent_manager_error_quark()
declare function gtk_recent_manager_error_quark() as GQuark
declare function gtk_recent_manager_get_type() as GType
declare function gtk_recent_manager_new() as GtkRecentManager ptr
declare function gtk_recent_manager_get_default() as GtkRecentManager ptr
declare function gtk_recent_manager_get_for_screen(byval screen as GdkScreen ptr) as GtkRecentManager ptr
declare sub gtk_recent_manager_set_screen(byval manager as GtkRecentManager ptr, byval screen as GdkScreen ptr)
declare function gtk_recent_manager_add_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr) as gboolean
declare function gtk_recent_manager_add_full(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval recent_data as const GtkRecentData ptr) as gboolean
declare function gtk_recent_manager_remove_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_recent_manager_lookup_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as GtkRecentInfo ptr
declare function gtk_recent_manager_has_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr) as gboolean
declare function gtk_recent_manager_move_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval new_uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub gtk_recent_manager_set_limit(byval manager as GtkRecentManager ptr, byval limit as gint)
declare function gtk_recent_manager_get_limit(byval manager as GtkRecentManager ptr) as gint
declare function gtk_recent_manager_get_items(byval manager as GtkRecentManager ptr) as GList ptr
declare function gtk_recent_manager_purge_items(byval manager as GtkRecentManager ptr, byval error as GError ptr ptr) as gint
declare function gtk_recent_info_get_type() as GType
declare function gtk_recent_info_ref(byval info as GtkRecentInfo ptr) as GtkRecentInfo ptr
declare sub gtk_recent_info_unref(byval info as GtkRecentInfo ptr)
declare function gtk_recent_info_get_uri(byval info as GtkRecentInfo ptr) as const gchar ptr
declare function gtk_recent_info_get_display_name(byval info as GtkRecentInfo ptr) as const gchar ptr
declare function gtk_recent_info_get_description(byval info as GtkRecentInfo ptr) as const gchar ptr
declare function gtk_recent_info_get_mime_type(byval info as GtkRecentInfo ptr) as const gchar ptr
declare function gtk_recent_info_get_added(byval info as GtkRecentInfo ptr) as time_t
declare function gtk_recent_info_get_modified(byval info as GtkRecentInfo ptr) as time_t
declare function gtk_recent_info_get_visited(byval info as GtkRecentInfo ptr) as time_t
declare function gtk_recent_info_get_private_hint(byval info as GtkRecentInfo ptr) as gboolean
declare function gtk_recent_info_get_application_info(byval info as GtkRecentInfo ptr, byval app_name as const gchar ptr, byval app_exec as const gchar ptr ptr, byval count as guint ptr, byval time_ as time_t ptr) as gboolean
declare function gtk_recent_info_get_applications(byval info as GtkRecentInfo ptr, byval length as gsize ptr) as gchar ptr ptr
declare function gtk_recent_info_last_application(byval info as GtkRecentInfo ptr) as gchar ptr
declare function gtk_recent_info_has_application(byval info as GtkRecentInfo ptr, byval app_name as const gchar ptr) as gboolean
declare function gtk_recent_info_get_groups(byval info as GtkRecentInfo ptr, byval length as gsize ptr) as gchar ptr ptr
declare function gtk_recent_info_has_group(byval info as GtkRecentInfo ptr, byval group_name as const gchar ptr) as gboolean
declare function gtk_recent_info_get_icon(byval info as GtkRecentInfo ptr, byval size as gint) as GdkPixbuf ptr
declare function gtk_recent_info_get_short_name(byval info as GtkRecentInfo ptr) as gchar ptr
declare function gtk_recent_info_get_uri_display(byval info as GtkRecentInfo ptr) as gchar ptr
declare function gtk_recent_info_get_age(byval info as GtkRecentInfo ptr) as gint
declare function gtk_recent_info_is_local(byval info as GtkRecentInfo ptr) as gboolean
declare function gtk_recent_info_exists(byval info as GtkRecentInfo ptr) as gboolean
declare function gtk_recent_info_match(byval info_a as GtkRecentInfo ptr, byval info_b as GtkRecentInfo ptr) as gboolean
declare sub _gtk_recent_manager_sync()

#define GTK_TYPE_RECENT_ACTION gtk_recent_action_get_type()
#define GTK_RECENT_ACTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_ACTION, GtkRecentAction)
#define GTK_IS_RECENT_ACTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_ACTION)
#define GTK_RECENT_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RECENT_ACTION, GtkRecentActionClass)
#define GTK_IS_RECENT_ACTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RECENT_ACTION)
#define GTK_RECENT_ACTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RECENT_ACTION, GtkRecentActionClass)

type GtkRecentAction as _GtkRecentAction
type GtkRecentActionPrivate as _GtkRecentActionPrivate
type GtkRecentActionClass as _GtkRecentActionClass

type _GtkRecentAction
	parent_instance as GtkAction
	priv as GtkRecentActionPrivate ptr
end type

type _GtkRecentActionClass
	parent_class as GtkActionClass
end type

declare function gtk_recent_action_get_type() as GType
declare function gtk_recent_action_new(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr) as GtkAction ptr
declare function gtk_recent_action_new_for_manager(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr, byval manager as GtkRecentManager ptr) as GtkAction ptr
declare function gtk_recent_action_get_show_numbers(byval action as GtkRecentAction ptr) as gboolean
declare sub gtk_recent_action_set_show_numbers(byval action as GtkRecentAction ptr, byval show_numbers as gboolean)

#define __GTK_RECENT_CHOOSER_H__
#define __GTK_RECENT_FILTER_H__
#define GTK_TYPE_RECENT_FILTER gtk_recent_filter_get_type()
#define GTK_RECENT_FILTER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_FILTER, GtkRecentFilter)
#define GTK_IS_RECENT_FILTER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_FILTER)
type GtkRecentFilter as _GtkRecentFilter
type GtkRecentFilterInfo as _GtkRecentFilterInfo

type GtkRecentFilterFlags as long
enum
	GTK_RECENT_FILTER_URI = 1 shl 0
	GTK_RECENT_FILTER_DISPLAY_NAME = 1 shl 1
	GTK_RECENT_FILTER_MIME_TYPE = 1 shl 2
	GTK_RECENT_FILTER_APPLICATION = 1 shl 3
	GTK_RECENT_FILTER_GROUP = 1 shl 4
	GTK_RECENT_FILTER_AGE = 1 shl 5
end enum

type GtkRecentFilterFunc as function(byval filter_info as const GtkRecentFilterInfo ptr, byval user_data as gpointer) as gboolean

type _GtkRecentFilterInfo
	contains as GtkRecentFilterFlags
	uri as const gchar ptr
	display_name as const gchar ptr
	mime_type as const gchar ptr
	applications as const gchar ptr ptr
	groups as const gchar ptr ptr
	age as gint
end type

declare function gtk_recent_filter_get_type() as GType
declare function gtk_recent_filter_new() as GtkRecentFilter ptr
declare sub gtk_recent_filter_set_name(byval filter as GtkRecentFilter ptr, byval name as const gchar ptr)
declare function gtk_recent_filter_get_name(byval filter as GtkRecentFilter ptr) as const gchar ptr
declare sub gtk_recent_filter_add_mime_type(byval filter as GtkRecentFilter ptr, byval mime_type as const gchar ptr)
declare sub gtk_recent_filter_add_pattern(byval filter as GtkRecentFilter ptr, byval pattern as const gchar ptr)
declare sub gtk_recent_filter_add_pixbuf_formats(byval filter as GtkRecentFilter ptr)
declare sub gtk_recent_filter_add_application(byval filter as GtkRecentFilter ptr, byval application as const gchar ptr)
declare sub gtk_recent_filter_add_group(byval filter as GtkRecentFilter ptr, byval group as const gchar ptr)
declare sub gtk_recent_filter_add_age(byval filter as GtkRecentFilter ptr, byval days as gint)
declare sub gtk_recent_filter_add_custom(byval filter as GtkRecentFilter ptr, byval needed as GtkRecentFilterFlags, byval func as GtkRecentFilterFunc, byval data as gpointer, byval data_destroy as GDestroyNotify)
declare function gtk_recent_filter_get_needed(byval filter as GtkRecentFilter ptr) as GtkRecentFilterFlags
declare function gtk_recent_filter_filter(byval filter as GtkRecentFilter ptr, byval filter_info as const GtkRecentFilterInfo ptr) as gboolean

#define GTK_TYPE_RECENT_CHOOSER gtk_recent_chooser_get_type()
#define GTK_RECENT_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_CHOOSER, GtkRecentChooser)
#define GTK_IS_RECENT_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_CHOOSER)
#define GTK_RECENT_CHOOSER_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_RECENT_CHOOSER, GtkRecentChooserIface)

type GtkRecentSortType as long
enum
	GTK_RECENT_SORT_NONE = 0
	GTK_RECENT_SORT_MRU
	GTK_RECENT_SORT_LRU
	GTK_RECENT_SORT_CUSTOM
end enum

type GtkRecentSortFunc as function(byval a as GtkRecentInfo ptr, byval b as GtkRecentInfo ptr, byval user_data as gpointer) as gint
type GtkRecentChooser as _GtkRecentChooser
type GtkRecentChooserIface as _GtkRecentChooserIface
#define GTK_RECENT_CHOOSER_ERROR gtk_recent_chooser_error_quark()

type GtkRecentChooserError as long
enum
	GTK_RECENT_CHOOSER_ERROR_NOT_FOUND
	GTK_RECENT_CHOOSER_ERROR_INVALID_URI
end enum

declare function gtk_recent_chooser_error_quark() as GQuark

type _GtkRecentChooserIface
	base_iface as GTypeInterface
	set_current_uri as function(byval chooser as GtkRecentChooser ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
	get_current_uri as function(byval chooser as GtkRecentChooser ptr) as gchar ptr
	select_uri as function(byval chooser as GtkRecentChooser ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
	unselect_uri as sub(byval chooser as GtkRecentChooser ptr, byval uri as const gchar ptr)
	select_all as sub(byval chooser as GtkRecentChooser ptr)
	unselect_all as sub(byval chooser as GtkRecentChooser ptr)
	get_items as function(byval chooser as GtkRecentChooser ptr) as GList ptr
	get_recent_manager as function(byval chooser as GtkRecentChooser ptr) as GtkRecentManager ptr
	add_filter as sub(byval chooser as GtkRecentChooser ptr, byval filter as GtkRecentFilter ptr)
	remove_filter as sub(byval chooser as GtkRecentChooser ptr, byval filter as GtkRecentFilter ptr)
	list_filters as function(byval chooser as GtkRecentChooser ptr) as GSList ptr
	set_sort_func as sub(byval chooser as GtkRecentChooser ptr, byval sort_func as GtkRecentSortFunc, byval data as gpointer, byval destroy as GDestroyNotify)
	item_activated as sub(byval chooser as GtkRecentChooser ptr)
	selection_changed as sub(byval chooser as GtkRecentChooser ptr)
end type

declare function gtk_recent_chooser_get_type() as GType
declare sub gtk_recent_chooser_set_show_private(byval chooser as GtkRecentChooser ptr, byval show_private as gboolean)
declare function gtk_recent_chooser_get_show_private(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_show_not_found(byval chooser as GtkRecentChooser ptr, byval show_not_found as gboolean)
declare function gtk_recent_chooser_get_show_not_found(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_select_multiple(byval chooser as GtkRecentChooser ptr, byval select_multiple as gboolean)
declare function gtk_recent_chooser_get_select_multiple(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_limit(byval chooser as GtkRecentChooser ptr, byval limit as gint)
declare function gtk_recent_chooser_get_limit(byval chooser as GtkRecentChooser ptr) as gint
declare sub gtk_recent_chooser_set_local_only(byval chooser as GtkRecentChooser ptr, byval local_only as gboolean)
declare function gtk_recent_chooser_get_local_only(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_show_tips(byval chooser as GtkRecentChooser ptr, byval show_tips as gboolean)
declare function gtk_recent_chooser_get_show_tips(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_show_numbers(byval chooser as GtkRecentChooser ptr, byval show_numbers as gboolean)
declare function gtk_recent_chooser_get_show_numbers(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_show_icons(byval chooser as GtkRecentChooser ptr, byval show_icons as gboolean)
declare function gtk_recent_chooser_get_show_icons(byval chooser as GtkRecentChooser ptr) as gboolean
declare sub gtk_recent_chooser_set_sort_type(byval chooser as GtkRecentChooser ptr, byval sort_type as GtkRecentSortType)
declare function gtk_recent_chooser_get_sort_type(byval chooser as GtkRecentChooser ptr) as GtkRecentSortType
declare sub gtk_recent_chooser_set_sort_func(byval chooser as GtkRecentChooser ptr, byval sort_func as GtkRecentSortFunc, byval sort_data as gpointer, byval data_destroy as GDestroyNotify)
declare function gtk_recent_chooser_set_current_uri(byval chooser as GtkRecentChooser ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_recent_chooser_get_current_uri(byval chooser as GtkRecentChooser ptr) as gchar ptr
declare function gtk_recent_chooser_get_current_item(byval chooser as GtkRecentChooser ptr) as GtkRecentInfo ptr
declare function gtk_recent_chooser_select_uri(byval chooser as GtkRecentChooser ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub gtk_recent_chooser_unselect_uri(byval chooser as GtkRecentChooser ptr, byval uri as const gchar ptr)
declare sub gtk_recent_chooser_select_all(byval chooser as GtkRecentChooser ptr)
declare sub gtk_recent_chooser_unselect_all(byval chooser as GtkRecentChooser ptr)
declare function gtk_recent_chooser_get_items(byval chooser as GtkRecentChooser ptr) as GList ptr
declare function gtk_recent_chooser_get_uris(byval chooser as GtkRecentChooser ptr, byval length as gsize ptr) as gchar ptr ptr
declare sub gtk_recent_chooser_add_filter(byval chooser as GtkRecentChooser ptr, byval filter as GtkRecentFilter ptr)
declare sub gtk_recent_chooser_remove_filter(byval chooser as GtkRecentChooser ptr, byval filter as GtkRecentFilter ptr)
declare function gtk_recent_chooser_list_filters(byval chooser as GtkRecentChooser ptr) as GSList ptr
declare sub gtk_recent_chooser_set_filter(byval chooser as GtkRecentChooser ptr, byval filter as GtkRecentFilter ptr)
declare function gtk_recent_chooser_get_filter(byval chooser as GtkRecentChooser ptr) as GtkRecentFilter ptr

#define __GTK_RECENT_CHOOSER_DIALOG_H__
#define GTK_TYPE_RECENT_CHOOSER_DIALOG gtk_recent_chooser_dialog_get_type()
#define GTK_RECENT_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_CHOOSER_DIALOG, GtkRecentChooserDialog)
#define GTK_IS_RECENT_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_CHOOSER_DIALOG)
#define GTK_RECENT_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RECENT_CHOOSER_DIALOG, GtkRecentChooserDialogClass)
#define GTK_IS_RECENT_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RECENT_CHOOSER_DIALOG)
#define GTK_RECENT_CHOOSER_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RECENT_CHOOSER_DIALOG, GtkRecentChooserDialogClass)

type GtkRecentChooserDialog as _GtkRecentChooserDialog
type GtkRecentChooserDialogClass as _GtkRecentChooserDialogClass
type GtkRecentChooserDialogPrivate as _GtkRecentChooserDialogPrivate

type _GtkRecentChooserDialog
	parent_instance as GtkDialog
	priv as GtkRecentChooserDialogPrivate ptr
end type

type _GtkRecentChooserDialogClass
	parent_class as GtkDialogClass
end type

declare function gtk_recent_chooser_dialog_get_type() as GType
declare function gtk_recent_chooser_dialog_new(byval title as const gchar ptr, byval parent as GtkWindow ptr, byval first_button_text as const gchar ptr, ...) as GtkWidget ptr
declare function gtk_recent_chooser_dialog_new_for_manager(byval title as const gchar ptr, byval parent as GtkWindow ptr, byval manager as GtkRecentManager ptr, byval first_button_text as const gchar ptr, ...) as GtkWidget ptr

#define __GTK_RECENT_CHOOSER_MENU_H__
#define GTK_TYPE_RECENT_CHOOSER_MENU gtk_recent_chooser_menu_get_type()
#define GTK_RECENT_CHOOSER_MENU(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_CHOOSER_MENU, GtkRecentChooserMenu)
#define GTK_IS_RECENT_CHOOSER_MENU(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_CHOOSER_MENU)
#define GTK_RECENT_CHOOSER_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RECENT_CHOOSER_MENU, GtkRecentChooserMenuClass)
#define GTK_IS_RECENT_CHOOSER_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RECENT_CHOOSER_MENU)
#define GTK_RECENT_CHOOSER_MENU_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RECENT_CHOOSER_MENU, GtkRecentChooserMenuClass)

type GtkRecentChooserMenu as _GtkRecentChooserMenu
type GtkRecentChooserMenuClass as _GtkRecentChooserMenuClass
type GtkRecentChooserMenuPrivate as _GtkRecentChooserMenuPrivate

type _GtkRecentChooserMenu
	parent_instance as GtkMenu
	priv as GtkRecentChooserMenuPrivate ptr
end type

type _GtkRecentChooserMenuClass
	parent_class as GtkMenuClass
	gtk_recent1 as sub()
	gtk_recent2 as sub()
	gtk_recent3 as sub()
	gtk_recent4 as sub()
end type

declare function gtk_recent_chooser_menu_get_type() as GType
declare function gtk_recent_chooser_menu_new() as GtkWidget ptr
declare function gtk_recent_chooser_menu_new_for_manager(byval manager as GtkRecentManager ptr) as GtkWidget ptr
declare function gtk_recent_chooser_menu_get_show_numbers(byval menu as GtkRecentChooserMenu ptr) as gboolean
declare sub gtk_recent_chooser_menu_set_show_numbers(byval menu as GtkRecentChooserMenu ptr, byval show_numbers as gboolean)

#define __GTK_RECENT_CHOOSER_WIDGET_H__
#define GTK_TYPE_RECENT_CHOOSER_WIDGET gtk_recent_chooser_widget_get_type()
#define GTK_RECENT_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RECENT_CHOOSER_WIDGET, GtkRecentChooserWidget)
#define GTK_IS_RECENT_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RECENT_CHOOSER_WIDGET)
#define GTK_RECENT_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RECENT_CHOOSER_WIDGET, GtkRecentChooserWidgetClass)
#define GTK_IS_RECENT_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RECENT_CHOOSER_WIDGET)
#define GTK_RECENT_CHOOSER_WIDGET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RECENT_CHOOSER_WIDGET, GtkRecentChooserWidgetClass)

type GtkRecentChooserWidget as _GtkRecentChooserWidget
type GtkRecentChooserWidgetClass as _GtkRecentChooserWidgetClass
type GtkRecentChooserWidgetPrivate as _GtkRecentChooserWidgetPrivate

type _GtkRecentChooserWidget
	parent_instance as GtkVBox
	priv as GtkRecentChooserWidgetPrivate ptr
end type

type _GtkRecentChooserWidgetClass
	parent_class as GtkVBoxClass
end type

declare function gtk_recent_chooser_widget_get_type() as GType
declare function gtk_recent_chooser_widget_new() as GtkWidget ptr
declare function gtk_recent_chooser_widget_new_for_manager(byval manager as GtkRecentManager ptr) as GtkWidget ptr

#define __GTK_SCALE_BUTTON_H__
#define GTK_TYPE_SCALE_BUTTON gtk_scale_button_get_type()
#define GTK_SCALE_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCALE_BUTTON, GtkScaleButton)
#define GTK_SCALE_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SCALE_BUTTON, GtkScaleButtonClass)
#define GTK_IS_SCALE_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCALE_BUTTON)
#define GTK_IS_SCALE_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SCALE_BUTTON)
#define GTK_SCALE_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SCALE_BUTTON, GtkScaleButtonClass)

type GtkScaleButton as _GtkScaleButton
type GtkScaleButtonClass as _GtkScaleButtonClass
type GtkScaleButtonPrivate as _GtkScaleButtonPrivate

type _GtkScaleButton
	parent as GtkButton
	plus_button as GtkWidget ptr
	minus_button as GtkWidget ptr
	priv as GtkScaleButtonPrivate ptr
end type

type _GtkScaleButtonClass
	parent_class as GtkButtonClass
	value_changed as sub(byval button as GtkScaleButton ptr, byval value as gdouble)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_scale_button_get_type() as GType
declare function gtk_scale_button_new(byval size as GtkIconSize, byval min as gdouble, byval max as gdouble, byval step as gdouble, byval icons as const gchar ptr ptr) as GtkWidget ptr
declare sub gtk_scale_button_set_icons(byval button as GtkScaleButton ptr, byval icons as const gchar ptr ptr)
declare function gtk_scale_button_get_value(byval button as GtkScaleButton ptr) as gdouble
declare sub gtk_scale_button_set_value(byval button as GtkScaleButton ptr, byval value as gdouble)
declare function gtk_scale_button_get_adjustment(byval button as GtkScaleButton ptr) as GtkAdjustment ptr
declare sub gtk_scale_button_set_adjustment(byval button as GtkScaleButton ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_scale_button_get_plus_button(byval button as GtkScaleButton ptr) as GtkWidget ptr
declare function gtk_scale_button_get_minus_button(byval button as GtkScaleButton ptr) as GtkWidget ptr
declare function gtk_scale_button_get_popup(byval button as GtkScaleButton ptr) as GtkWidget ptr
declare function gtk_scale_button_get_orientation(byval button as GtkScaleButton ptr) as GtkOrientation
declare sub gtk_scale_button_set_orientation(byval button as GtkScaleButton ptr, byval orientation as GtkOrientation)

#define __GTK_SCROLLED_WINDOW_H__
#define __GTK_VSCROLLBAR_H__
#define GTK_TYPE_VSCROLLBAR gtk_vscrollbar_get_type()
#define GTK_VSCROLLBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VSCROLLBAR, GtkVScrollbar)
#define GTK_VSCROLLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VSCROLLBAR, GtkVScrollbarClass)
#define GTK_IS_VSCROLLBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VSCROLLBAR)
#define GTK_IS_VSCROLLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VSCROLLBAR)
#define GTK_VSCROLLBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VSCROLLBAR, GtkVScrollbarClass)
type GtkVScrollbar as _GtkVScrollbar
type GtkVScrollbarClass as _GtkVScrollbarClass

type _GtkVScrollbar
	scrollbar as GtkScrollbar
end type

type _GtkVScrollbarClass
	parent_class as GtkScrollbarClass
end type

declare function gtk_vscrollbar_get_type() as GType
declare function gtk_vscrollbar_new(byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
#define __GTK_VIEWPORT_H__
#define GTK_TYPE_VIEWPORT gtk_viewport_get_type()
#define GTK_VIEWPORT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VIEWPORT, GtkViewport)
#define GTK_VIEWPORT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VIEWPORT, GtkViewportClass)
#define GTK_IS_VIEWPORT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VIEWPORT)
#define GTK_IS_VIEWPORT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VIEWPORT)
#define GTK_VIEWPORT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VIEWPORT, GtkViewportClass)
type GtkViewport as _GtkViewport
type GtkViewportClass as _GtkViewportClass

type _GtkViewport
	bin as GtkBin
	shadow_type as GtkShadowType
	view_window as GdkWindow ptr
	bin_window as GdkWindow ptr
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
end type

type _GtkViewportClass
	parent_class as GtkBinClass
	set_scroll_adjustments as sub(byval viewport as GtkViewport ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
end type

declare function gtk_viewport_get_type() as GType
declare function gtk_viewport_new(byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_viewport_get_hadjustment(byval viewport as GtkViewport ptr) as GtkAdjustment ptr
declare function gtk_viewport_get_vadjustment(byval viewport as GtkViewport ptr) as GtkAdjustment ptr
declare sub gtk_viewport_set_hadjustment(byval viewport as GtkViewport ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_viewport_set_vadjustment(byval viewport as GtkViewport ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_viewport_set_shadow_type(byval viewport as GtkViewport ptr, byval type as GtkShadowType)
declare function gtk_viewport_get_shadow_type(byval viewport as GtkViewport ptr) as GtkShadowType
declare function gtk_viewport_get_bin_window(byval viewport as GtkViewport ptr) as GdkWindow ptr
declare function gtk_viewport_get_view_window(byval viewport as GtkViewport ptr) as GdkWindow ptr

#define GTK_TYPE_SCROLLED_WINDOW gtk_scrolled_window_get_type()
#define GTK_SCROLLED_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindow)
#define GTK_SCROLLED_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass)
#define GTK_IS_SCROLLED_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCROLLED_WINDOW)
#define GTK_IS_SCROLLED_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SCROLLED_WINDOW)
#define GTK_SCROLLED_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass)
type GtkScrolledWindow as _GtkScrolledWindow
type GtkScrolledWindowClass as _GtkScrolledWindowClass

type _GtkScrolledWindow
	container as GtkBin
	hscrollbar as GtkWidget ptr
	vscrollbar as GtkWidget ptr
	hscrollbar_policy : 2 as guint
	vscrollbar_policy : 2 as guint
	hscrollbar_visible : 1 as guint
	vscrollbar_visible : 1 as guint
	window_placement : 2 as guint
	focus_out : 1 as guint
	shadow_type as guint16
end type

type _GtkScrolledWindowClass
	parent_class as GtkBinClass
	scrollbar_spacing as gint
	scroll_child as function(byval scrolled_window as GtkScrolledWindow ptr, byval scroll as GtkScrollType, byval horizontal as gboolean) as gboolean
	move_focus_out as sub(byval scrolled_window as GtkScrolledWindow ptr, byval direction as GtkDirectionType)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_scrolled_window_get_type() as GType
declare function gtk_scrolled_window_new(byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr) as GtkWidget ptr
declare sub gtk_scrolled_window_set_hadjustment(byval scrolled_window as GtkScrolledWindow ptr, byval hadjustment as GtkAdjustment ptr)
declare sub gtk_scrolled_window_set_vadjustment(byval scrolled_window as GtkScrolledWindow ptr, byval vadjustment as GtkAdjustment ptr)
declare function gtk_scrolled_window_get_hadjustment(byval scrolled_window as GtkScrolledWindow ptr) as GtkAdjustment ptr
declare function gtk_scrolled_window_get_vadjustment(byval scrolled_window as GtkScrolledWindow ptr) as GtkAdjustment ptr
declare function gtk_scrolled_window_get_hscrollbar(byval scrolled_window as GtkScrolledWindow ptr) as GtkWidget ptr
declare function gtk_scrolled_window_get_vscrollbar(byval scrolled_window as GtkScrolledWindow ptr) as GtkWidget ptr
declare sub gtk_scrolled_window_set_policy(byval scrolled_window as GtkScrolledWindow ptr, byval hscrollbar_policy as GtkPolicyType, byval vscrollbar_policy as GtkPolicyType)
declare sub gtk_scrolled_window_get_policy(byval scrolled_window as GtkScrolledWindow ptr, byval hscrollbar_policy as GtkPolicyType ptr, byval vscrollbar_policy as GtkPolicyType ptr)
declare sub gtk_scrolled_window_set_placement(byval scrolled_window as GtkScrolledWindow ptr, byval window_placement as GtkCornerType)
declare sub gtk_scrolled_window_unset_placement(byval scrolled_window as GtkScrolledWindow ptr)
declare function gtk_scrolled_window_get_placement(byval scrolled_window as GtkScrolledWindow ptr) as GtkCornerType
declare sub gtk_scrolled_window_set_shadow_type(byval scrolled_window as GtkScrolledWindow ptr, byval type as GtkShadowType)
declare function gtk_scrolled_window_get_shadow_type(byval scrolled_window as GtkScrolledWindow ptr) as GtkShadowType
declare sub gtk_scrolled_window_add_with_viewport(byval scrolled_window as GtkScrolledWindow ptr, byval child as GtkWidget ptr)
declare function _gtk_scrolled_window_get_scrollbar_spacing(byval scrolled_window as GtkScrolledWindow ptr) as gint

#define __GTK_SEPARATOR_MENU_ITEM_H__
#define GTK_TYPE_SEPARATOR_MENU_ITEM gtk_separator_menu_item_get_type()
#define GTK_SEPARATOR_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItem)
#define GTK_SEPARATOR_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItemClass)
#define GTK_IS_SEPARATOR_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SEPARATOR_MENU_ITEM)
#define GTK_IS_SEPARATOR_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SEPARATOR_MENU_ITEM)
#define GTK_SEPARATOR_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItemClass)
type GtkSeparatorMenuItem as _GtkSeparatorMenuItem
type GtkSeparatorMenuItemClass as _GtkSeparatorMenuItemClass

type _GtkSeparatorMenuItem
	menu_item as GtkMenuItem
end type

type _GtkSeparatorMenuItemClass
	parent_class as GtkMenuItemClass
end type

declare function gtk_separator_menu_item_get_type() as GType
declare function gtk_separator_menu_item_new() as GtkWidget ptr
#define __GTK_SEPARATOR_TOOL_ITEM_H__
#define GTK_TYPE_SEPARATOR_TOOL_ITEM gtk_separator_tool_item_get_type()
#define GTK_SEPARATOR_TOOL_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItem)
#define GTK_SEPARATOR_TOOL_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItemClass)
#define GTK_IS_SEPARATOR_TOOL_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM)
#define GTK_IS_SEPARATOR_TOOL_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SEPARATOR_TOOL_ITEM)
#define GTK_SEPARATOR_TOOL_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItemClass)

type GtkSeparatorToolItem as _GtkSeparatorToolItem
type GtkSeparatorToolItemClass as _GtkSeparatorToolItemClass
type GtkSeparatorToolItemPrivate as _GtkSeparatorToolItemPrivate

type _GtkSeparatorToolItem
	parent as GtkToolItem
	priv as GtkSeparatorToolItemPrivate ptr
end type

type _GtkSeparatorToolItemClass
	parent_class as GtkToolItemClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_separator_tool_item_get_type() as GType
declare function gtk_separator_tool_item_new() as GtkToolItem ptr
declare function gtk_separator_tool_item_get_draw(byval item as GtkSeparatorToolItem ptr) as gboolean
declare sub gtk_separator_tool_item_set_draw(byval item as GtkSeparatorToolItem ptr, byval draw as gboolean)
#define __GTK_SHOW_H__
declare function gtk_show_uri(byval screen as GdkScreen ptr, byval uri as const gchar ptr, byval timestamp as guint32, byval error as GError ptr ptr) as gboolean

#define __GTK_SPIN_BUTTON_H__
#define GTK_TYPE_SPIN_BUTTON gtk_spin_button_get_type()
#define GTK_SPIN_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SPIN_BUTTON, GtkSpinButton)
#define GTK_SPIN_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SPIN_BUTTON, GtkSpinButtonClass)
#define GTK_IS_SPIN_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SPIN_BUTTON)
#define GTK_IS_SPIN_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SPIN_BUTTON)
#define GTK_SPIN_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SPIN_BUTTON, GtkSpinButtonClass)
const GTK_INPUT_ERROR = -1

type GtkSpinButtonUpdatePolicy as long
enum
	GTK_UPDATE_ALWAYS
	GTK_UPDATE_IF_VALID
end enum

type GtkSpinType as long
enum
	GTK_SPIN_STEP_FORWARD
	GTK_SPIN_STEP_BACKWARD
	GTK_SPIN_PAGE_FORWARD
	GTK_SPIN_PAGE_BACKWARD
	GTK_SPIN_HOME
	GTK_SPIN_END
	GTK_SPIN_USER_DEFINED
end enum

type GtkSpinButton as _GtkSpinButton
type GtkSpinButtonClass as _GtkSpinButtonClass

type _GtkSpinButton
	entry as GtkEntry
	adjustment as GtkAdjustment ptr
	panel as GdkWindow ptr
	timer as guint32
	climb_rate as gdouble
	timer_step as gdouble
	update_policy as GtkSpinButtonUpdatePolicy
	in_child : 2 as guint
	click_child : 2 as guint
	button : 2 as guint
	need_timer : 1 as guint
	timer_calls : 3 as guint
	digits : 10 as guint
	numeric : 1 as guint
	wrap : 1 as guint
	snap_to_ticks : 1 as guint
end type

type _GtkSpinButtonClass
	parent_class as GtkEntryClass
	input as function(byval spin_button as GtkSpinButton ptr, byval new_value as gdouble ptr) as gint
	output as function(byval spin_button as GtkSpinButton ptr) as gint
	value_changed as sub(byval spin_button as GtkSpinButton ptr)
	change_value as sub(byval spin_button as GtkSpinButton ptr, byval scroll as GtkScrollType)
	wrapped as sub(byval spin_button as GtkSpinButton ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_spin_button_get_type() as GType
declare sub gtk_spin_button_configure(byval spin_button as GtkSpinButton ptr, byval adjustment as GtkAdjustment ptr, byval climb_rate as gdouble, byval digits as guint)
declare function gtk_spin_button_new(byval adjustment as GtkAdjustment ptr, byval climb_rate as gdouble, byval digits as guint) as GtkWidget ptr
declare function gtk_spin_button_new_with_range(byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr
declare sub gtk_spin_button_set_adjustment(byval spin_button as GtkSpinButton ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_spin_button_get_adjustment(byval spin_button as GtkSpinButton ptr) as GtkAdjustment ptr
declare sub gtk_spin_button_set_digits(byval spin_button as GtkSpinButton ptr, byval digits as guint)
declare function gtk_spin_button_get_digits(byval spin_button as GtkSpinButton ptr) as guint
declare sub gtk_spin_button_set_increments(byval spin_button as GtkSpinButton ptr, byval step as gdouble, byval page as gdouble)
declare sub gtk_spin_button_get_increments(byval spin_button as GtkSpinButton ptr, byval step as gdouble ptr, byval page as gdouble ptr)
declare sub gtk_spin_button_set_range(byval spin_button as GtkSpinButton ptr, byval min as gdouble, byval max as gdouble)
declare sub gtk_spin_button_get_range(byval spin_button as GtkSpinButton ptr, byval min as gdouble ptr, byval max as gdouble ptr)
declare function gtk_spin_button_get_value(byval spin_button as GtkSpinButton ptr) as gdouble
declare function gtk_spin_button_get_value_as_int(byval spin_button as GtkSpinButton ptr) as gint
declare sub gtk_spin_button_set_value(byval spin_button as GtkSpinButton ptr, byval value as gdouble)
declare sub gtk_spin_button_set_update_policy(byval spin_button as GtkSpinButton ptr, byval policy as GtkSpinButtonUpdatePolicy)
declare function gtk_spin_button_get_update_policy(byval spin_button as GtkSpinButton ptr) as GtkSpinButtonUpdatePolicy
declare sub gtk_spin_button_set_numeric(byval spin_button as GtkSpinButton ptr, byval numeric as gboolean)
declare function gtk_spin_button_get_numeric(byval spin_button as GtkSpinButton ptr) as gboolean
declare sub gtk_spin_button_spin(byval spin_button as GtkSpinButton ptr, byval direction as GtkSpinType, byval increment as gdouble)
declare sub gtk_spin_button_set_wrap(byval spin_button as GtkSpinButton ptr, byval wrap as gboolean)
declare function gtk_spin_button_get_wrap(byval spin_button as GtkSpinButton ptr) as gboolean
declare sub gtk_spin_button_set_snap_to_ticks(byval spin_button as GtkSpinButton ptr, byval snap_to_ticks as gboolean)
declare function gtk_spin_button_get_snap_to_ticks(byval spin_button as GtkSpinButton ptr) as gboolean
declare sub gtk_spin_button_update(byval spin_button as GtkSpinButton ptr)
declare function gtk_spin_button_get_value_as_float alias "gtk_spin_button_get_value"(byval spin_button as GtkSpinButton ptr) as gdouble

#define __GTK_SPINNER_H__
#define GTK_TYPE_SPINNER gtk_spinner_get_type()
#define GTK_SPINNER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SPINNER, GtkSpinner)
#define GTK_SPINNER_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_SPINNER, GtkSpinnerClass)
#define GTK_IS_SPINNER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SPINNER)
#define GTK_IS_SPINNER_CLASS(obj) G_TYPE_CHECK_CLASS_TYPE((obj), GTK_TYPE_SPINNER)
#define GTK_SPINNER_GET_CLASS G_TYPE_INSTANCE_GET_CLASS(obj, GTK_TYPE_SPINNER, GtkSpinnerClass)

type GtkSpinner as _GtkSpinner
type GtkSpinnerClass as _GtkSpinnerClass
type GtkSpinnerPrivate as _GtkSpinnerPrivate

type _GtkSpinner
	parent as GtkDrawingArea
	priv as GtkSpinnerPrivate ptr
end type

type _GtkSpinnerClass
	parent_class as GtkDrawingAreaClass
end type

declare function gtk_spinner_get_type() as GType
declare function gtk_spinner_new() as GtkWidget ptr
declare sub gtk_spinner_start(byval spinner as GtkSpinner ptr)
declare sub gtk_spinner_stop(byval spinner as GtkSpinner ptr)

#define __GTK_STATUSBAR_H__
#define GTK_TYPE_STATUSBAR gtk_statusbar_get_type()
#define GTK_STATUSBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_STATUSBAR, GtkStatusbar)
#define GTK_STATUSBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STATUSBAR, GtkStatusbarClass)
#define GTK_IS_STATUSBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_STATUSBAR)
#define GTK_IS_STATUSBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STATUSBAR)
#define GTK_STATUSBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STATUSBAR, GtkStatusbarClass)
type GtkStatusbar as _GtkStatusbar
type GtkStatusbarClass as _GtkStatusbarClass

type _GtkStatusbar
	parent_widget as GtkHBox
	frame as GtkWidget ptr
	label as GtkWidget ptr
	messages as GSList ptr
	keys as GSList ptr
	seq_context_id as guint
	seq_message_id as guint
	grip_window as GdkWindow ptr
	has_resize_grip : 1 as guint
end type

type _GtkStatusbarClass
	parent_class as GtkHBoxClass
	reserved as gpointer
	text_pushed as sub(byval statusbar as GtkStatusbar ptr, byval context_id as guint, byval text as const gchar ptr)
	text_popped as sub(byval statusbar as GtkStatusbar ptr, byval context_id as guint, byval text as const gchar ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_statusbar_get_type() as GType
declare function gtk_statusbar_new() as GtkWidget ptr
declare function gtk_statusbar_get_context_id(byval statusbar as GtkStatusbar ptr, byval context_description as const gchar ptr) as guint
declare function gtk_statusbar_push(byval statusbar as GtkStatusbar ptr, byval context_id as guint, byval text as const gchar ptr) as guint
declare sub gtk_statusbar_pop(byval statusbar as GtkStatusbar ptr, byval context_id as guint)
declare sub gtk_statusbar_remove(byval statusbar as GtkStatusbar ptr, byval context_id as guint, byval message_id as guint)
declare sub gtk_statusbar_remove_all(byval statusbar as GtkStatusbar ptr, byval context_id as guint)
declare sub gtk_statusbar_set_has_resize_grip(byval statusbar as GtkStatusbar ptr, byval setting as gboolean)
declare function gtk_statusbar_get_has_resize_grip(byval statusbar as GtkStatusbar ptr) as gboolean
declare function gtk_statusbar_get_message_area(byval statusbar as GtkStatusbar ptr) as GtkWidget ptr

#define __GTK_STATUS_ICON_H__
#define GTK_TYPE_STATUS_ICON gtk_status_icon_get_type()
#define GTK_STATUS_ICON(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_STATUS_ICON, GtkStatusIcon)
#define GTK_STATUS_ICON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_STATUS_ICON, GtkStatusIconClass)
#define GTK_IS_STATUS_ICON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_STATUS_ICON)
#define GTK_IS_STATUS_ICON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_STATUS_ICON)
#define GTK_STATUS_ICON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_STATUS_ICON, GtkStatusIconClass)

type GtkStatusIcon as _GtkStatusIcon
type GtkStatusIconClass as _GtkStatusIconClass
type GtkStatusIconPrivate as _GtkStatusIconPrivate

type _GtkStatusIcon
	parent_instance as GObject
	priv as GtkStatusIconPrivate ptr
end type

type _GtkStatusIconClass
	parent_class as GObjectClass
	activate as sub(byval status_icon as GtkStatusIcon ptr)
	popup_menu as sub(byval status_icon as GtkStatusIcon ptr, byval button as guint, byval activate_time as guint32)
	size_changed as function(byval status_icon as GtkStatusIcon ptr, byval size as gint) as gboolean
	button_press_event as function(byval status_icon as GtkStatusIcon ptr, byval event as GdkEventButton ptr) as gboolean
	button_release_event as function(byval status_icon as GtkStatusIcon ptr, byval event as GdkEventButton ptr) as gboolean
	scroll_event as function(byval status_icon as GtkStatusIcon ptr, byval event as GdkEventScroll ptr) as gboolean
	query_tooltip as function(byval status_icon as GtkStatusIcon ptr, byval x as gint, byval y as gint, byval keyboard_mode as gboolean, byval tooltip as GtkTooltip ptr) as gboolean
	__gtk_reserved1 as any ptr
	__gtk_reserved2 as any ptr
end type

declare function gtk_status_icon_get_type() as GType
declare function gtk_status_icon_new() as GtkStatusIcon ptr
declare function gtk_status_icon_new_from_pixbuf(byval pixbuf as GdkPixbuf ptr) as GtkStatusIcon ptr
declare function gtk_status_icon_new_from_file(byval filename as const gchar ptr) as GtkStatusIcon ptr
declare function gtk_status_icon_new_from_stock(byval stock_id as const gchar ptr) as GtkStatusIcon ptr
declare function gtk_status_icon_new_from_icon_name(byval icon_name as const gchar ptr) as GtkStatusIcon ptr
declare function gtk_status_icon_new_from_gicon(byval icon as GIcon ptr) as GtkStatusIcon ptr
declare sub gtk_status_icon_set_from_pixbuf(byval status_icon as GtkStatusIcon ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_status_icon_set_from_file(byval status_icon as GtkStatusIcon ptr, byval filename as const gchar ptr)
declare sub gtk_status_icon_set_from_stock(byval status_icon as GtkStatusIcon ptr, byval stock_id as const gchar ptr)
declare sub gtk_status_icon_set_from_icon_name(byval status_icon as GtkStatusIcon ptr, byval icon_name as const gchar ptr)
declare sub gtk_status_icon_set_from_gicon(byval status_icon as GtkStatusIcon ptr, byval icon as GIcon ptr)
declare function gtk_status_icon_get_storage_type(byval status_icon as GtkStatusIcon ptr) as GtkImageType
declare function gtk_status_icon_get_pixbuf(byval status_icon as GtkStatusIcon ptr) as GdkPixbuf ptr
declare function gtk_status_icon_get_stock(byval status_icon as GtkStatusIcon ptr) as const gchar ptr
declare function gtk_status_icon_get_icon_name(byval status_icon as GtkStatusIcon ptr) as const gchar ptr
declare function gtk_status_icon_get_gicon(byval status_icon as GtkStatusIcon ptr) as GIcon ptr
declare function gtk_status_icon_get_size(byval status_icon as GtkStatusIcon ptr) as gint
declare sub gtk_status_icon_set_screen(byval status_icon as GtkStatusIcon ptr, byval screen as GdkScreen ptr)
declare function gtk_status_icon_get_screen(byval status_icon as GtkStatusIcon ptr) as GdkScreen ptr
declare sub gtk_status_icon_set_tooltip(byval status_icon as GtkStatusIcon ptr, byval tooltip_text as const gchar ptr)
declare sub gtk_status_icon_set_has_tooltip(byval status_icon as GtkStatusIcon ptr, byval has_tooltip as gboolean)
declare sub gtk_status_icon_set_tooltip_text(byval status_icon as GtkStatusIcon ptr, byval text as const gchar ptr)
declare sub gtk_status_icon_set_tooltip_markup(byval status_icon as GtkStatusIcon ptr, byval markup as const gchar ptr)
declare sub gtk_status_icon_set_title(byval status_icon as GtkStatusIcon ptr, byval title as const gchar ptr)
declare function gtk_status_icon_get_title(byval status_icon as GtkStatusIcon ptr) as const gchar ptr
declare sub gtk_status_icon_set_name(byval status_icon as GtkStatusIcon ptr, byval name as const gchar ptr)
declare sub gtk_status_icon_set_visible(byval status_icon as GtkStatusIcon ptr, byval visible as gboolean)
declare function gtk_status_icon_get_visible(byval status_icon as GtkStatusIcon ptr) as gboolean
declare sub gtk_status_icon_set_blinking(byval status_icon as GtkStatusIcon ptr, byval blinking as gboolean)
declare function gtk_status_icon_get_blinking(byval status_icon as GtkStatusIcon ptr) as gboolean
declare function gtk_status_icon_is_embedded(byval status_icon as GtkStatusIcon ptr) as gboolean
declare sub gtk_status_icon_position_menu(byval menu as GtkMenu ptr, byval x as gint ptr, byval y as gint ptr, byval push_in as gboolean ptr, byval user_data as gpointer)
declare function gtk_status_icon_get_geometry(byval status_icon as GtkStatusIcon ptr, byval screen as GdkScreen ptr ptr, byval area as GdkRectangle ptr, byval orientation as GtkOrientation ptr) as gboolean
declare function gtk_status_icon_get_has_tooltip(byval status_icon as GtkStatusIcon ptr) as gboolean
declare function gtk_status_icon_get_tooltip_text(byval status_icon as GtkStatusIcon ptr) as gchar ptr
declare function gtk_status_icon_get_tooltip_markup(byval status_icon as GtkStatusIcon ptr) as gchar ptr
declare function gtk_status_icon_get_x11_window_id(byval status_icon as GtkStatusIcon ptr) as guint32
#define __GTK_STOCK_H__
type GtkStockItem as _GtkStockItem

type _GtkStockItem
	stock_id as gchar ptr
	label as gchar ptr
	modifier as GdkModifierType
	keyval as guint
	translation_domain as gchar ptr
end type

declare sub gtk_stock_add_ alias "gtk_stock_add"(byval items as const GtkStockItem ptr, byval n_items as guint)
declare sub gtk_stock_add_static(byval items as const GtkStockItem ptr, byval n_items as guint)
declare function gtk_stock_lookup(byval stock_id as const gchar ptr, byval item as GtkStockItem ptr) as gboolean
declare function gtk_stock_list_ids() as GSList ptr
declare function gtk_stock_item_copy(byval item as const GtkStockItem ptr) as GtkStockItem ptr
declare sub gtk_stock_item_free(byval item as GtkStockItem ptr)
declare sub gtk_stock_set_translate_func(byval domain as const gchar ptr, byval func as GtkTranslateFunc, byval data as gpointer, byval notify as GDestroyNotify)

#define GTK_STOCK_ABOUT "gtk-about"
#define GTK_STOCK_ADD "gtk-add"
#define GTK_STOCK_APPLY "gtk-apply"
#define GTK_STOCK_BOLD "gtk-bold"
#define GTK_STOCK_CANCEL "gtk-cancel"
#define GTK_STOCK_CAPS_LOCK_WARNING "gtk-caps-lock-warning"
#define GTK_STOCK_CDROM "gtk-cdrom"
#define GTK_STOCK_CLEAR "gtk-clear"
#define GTK_STOCK_CLOSE "gtk-close"
#define GTK_STOCK_COLOR_PICKER "gtk-color-picker"
#define GTK_STOCK_CONNECT "gtk-connect"
#define GTK_STOCK_CONVERT "gtk-convert"
#define GTK_STOCK_COPY "gtk-copy"
#define GTK_STOCK_CUT "gtk-cut"
#define GTK_STOCK_DELETE "gtk-delete"
#define GTK_STOCK_DIALOG_AUTHENTICATION "gtk-dialog-authentication"
#define GTK_STOCK_DIALOG_INFO "gtk-dialog-info"
#define GTK_STOCK_DIALOG_WARNING "gtk-dialog-warning"
#define GTK_STOCK_DIALOG_ERROR "gtk-dialog-error"
#define GTK_STOCK_DIALOG_QUESTION "gtk-dialog-question"
#define GTK_STOCK_DIRECTORY "gtk-directory"
#define GTK_STOCK_DISCARD "gtk-discard"
#define GTK_STOCK_DISCONNECT "gtk-disconnect"
#define GTK_STOCK_DND "gtk-dnd"
#define GTK_STOCK_DND_MULTIPLE "gtk-dnd-multiple"
#define GTK_STOCK_EDIT "gtk-edit"
#define GTK_STOCK_EXECUTE "gtk-execute"
#define GTK_STOCK_FILE "gtk-file"
#define GTK_STOCK_FIND "gtk-find"
#define GTK_STOCK_FIND_AND_REPLACE "gtk-find-and-replace"
#define GTK_STOCK_FLOPPY "gtk-floppy"
#define GTK_STOCK_FULLSCREEN "gtk-fullscreen"
#define GTK_STOCK_GOTO_BOTTOM "gtk-goto-bottom"
#define GTK_STOCK_GOTO_FIRST "gtk-goto-first"
#define GTK_STOCK_GOTO_LAST "gtk-goto-last"
#define GTK_STOCK_GOTO_TOP "gtk-goto-top"
#define GTK_STOCK_GO_BACK "gtk-go-back"
#define GTK_STOCK_GO_DOWN "gtk-go-down"
#define GTK_STOCK_GO_FORWARD "gtk-go-forward"
#define GTK_STOCK_GO_UP "gtk-go-up"
#define GTK_STOCK_HARDDISK "gtk-harddisk"
#define GTK_STOCK_HELP "gtk-help"
#define GTK_STOCK_HOME "gtk-home"
#define GTK_STOCK_INDEX "gtk-index"
#define GTK_STOCK_INDENT "gtk-indent"
#define GTK_STOCK_INFO "gtk-info"
#define GTK_STOCK_ITALIC "gtk-italic"
#define GTK_STOCK_JUMP_TO "gtk-jump-to"
#define GTK_STOCK_JUSTIFY_CENTER "gtk-justify-center"
#define GTK_STOCK_JUSTIFY_FILL "gtk-justify-fill"
#define GTK_STOCK_JUSTIFY_LEFT "gtk-justify-left"
#define GTK_STOCK_JUSTIFY_RIGHT "gtk-justify-right"
#define GTK_STOCK_LEAVE_FULLSCREEN "gtk-leave-fullscreen"
#define GTK_STOCK_MISSING_IMAGE "gtk-missing-image"
#define GTK_STOCK_MEDIA_FORWARD "gtk-media-forward"
#define GTK_STOCK_MEDIA_NEXT "gtk-media-next"
#define GTK_STOCK_MEDIA_PAUSE "gtk-media-pause"
#define GTK_STOCK_MEDIA_PLAY "gtk-media-play"
#define GTK_STOCK_MEDIA_PREVIOUS "gtk-media-previous"
#define GTK_STOCK_MEDIA_RECORD "gtk-media-record"
#define GTK_STOCK_MEDIA_REWIND "gtk-media-rewind"
#define GTK_STOCK_MEDIA_STOP "gtk-media-stop"
#define GTK_STOCK_NETWORK "gtk-network"
#define GTK_STOCK_NEW "gtk-new"
#define GTK_STOCK_NO "gtk-no"
#define GTK_STOCK_OK "gtk-ok"
#define GTK_STOCK_OPEN "gtk-open"
#define GTK_STOCK_ORIENTATION_PORTRAIT "gtk-orientation-portrait"
#define GTK_STOCK_ORIENTATION_LANDSCAPE "gtk-orientation-landscape"
#define GTK_STOCK_ORIENTATION_REVERSE_LANDSCAPE "gtk-orientation-reverse-landscape"
#define GTK_STOCK_ORIENTATION_REVERSE_PORTRAIT "gtk-orientation-reverse-portrait"
#define GTK_STOCK_PAGE_SETUP "gtk-page-setup"
#define GTK_STOCK_PASTE "gtk-paste"
#define GTK_STOCK_PREFERENCES "gtk-preferences"
#define GTK_STOCK_PRINT "gtk-print"
#define GTK_STOCK_PRINT_ERROR "gtk-print-error"
#define GTK_STOCK_PRINT_PAUSED "gtk-print-paused"
#define GTK_STOCK_PRINT_PREVIEW "gtk-print-preview"
#define GTK_STOCK_PRINT_REPORT "gtk-print-report"
#define GTK_STOCK_PRINT_WARNING "gtk-print-warning"
#define GTK_STOCK_PROPERTIES "gtk-properties"
#define GTK_STOCK_QUIT "gtk-quit"
#define GTK_STOCK_REDO "gtk-redo"
#define GTK_STOCK_REFRESH "gtk-refresh"
#define GTK_STOCK_REMOVE "gtk-remove"
#define GTK_STOCK_REVERT_TO_SAVED "gtk-revert-to-saved"
#define GTK_STOCK_SAVE "gtk-save"
#define GTK_STOCK_SAVE_AS "gtk-save-as"
#define GTK_STOCK_SELECT_ALL "gtk-select-all"
#define GTK_STOCK_SELECT_COLOR "gtk-select-color"
#define GTK_STOCK_SELECT_FONT "gtk-select-font"
#define GTK_STOCK_SORT_ASCENDING "gtk-sort-ascending"
#define GTK_STOCK_SORT_DESCENDING "gtk-sort-descending"
#define GTK_STOCK_SPELL_CHECK "gtk-spell-check"
#define GTK_STOCK_STOP "gtk-stop"
#define GTK_STOCK_STRIKETHROUGH "gtk-strikethrough"
#define GTK_STOCK_UNDELETE "gtk-undelete"
#define GTK_STOCK_UNDERLINE "gtk-underline"
#define GTK_STOCK_UNDO "gtk-undo"
#define GTK_STOCK_UNINDENT "gtk-unindent"
#define GTK_STOCK_YES "gtk-yes"
#define GTK_STOCK_ZOOM_100 "gtk-zoom-100"
#define GTK_STOCK_ZOOM_FIT "gtk-zoom-fit"
#define GTK_STOCK_ZOOM_IN "gtk-zoom-in"
#define GTK_STOCK_ZOOM_OUT "gtk-zoom-out"
#define __GTK_TABLE_H__
#define GTK_TYPE_TABLE gtk_table_get_type()
#define GTK_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TABLE, GtkTable)
#define GTK_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TABLE, GtkTableClass)
#define GTK_IS_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TABLE)
#define GTK_IS_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TABLE)
#define GTK_TABLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TABLE, GtkTableClass)

type GtkTable as _GtkTable
type GtkTableClass as _GtkTableClass
type GtkTableChild as _GtkTableChild
type GtkTableRowCol as _GtkTableRowCol

type _GtkTable
	container as GtkContainer
	children as GList ptr
	rows as GtkTableRowCol ptr
	cols as GtkTableRowCol ptr
	nrows as guint16
	ncols as guint16
	column_spacing as guint16
	row_spacing as guint16
	homogeneous : 1 as guint
end type

type _GtkTableClass
	parent_class as GtkContainerClass
end type

type _GtkTableChild
	widget as GtkWidget ptr
	left_attach as guint16
	right_attach as guint16
	top_attach as guint16
	bottom_attach as guint16
	xpadding as guint16
	ypadding as guint16
	xexpand : 1 as guint
	yexpand : 1 as guint
	xshrink : 1 as guint
	yshrink : 1 as guint
	xfill : 1 as guint
	yfill : 1 as guint
end type

type _GtkTableRowCol
	requisition as guint16
	allocation as guint16
	spacing as guint16
	need_expand : 1 as guint
	need_shrink : 1 as guint
	expand : 1 as guint
	shrink : 1 as guint
	empty : 1 as guint
end type

declare function gtk_table_get_type() as GType
declare function gtk_table_new(byval rows as guint, byval columns as guint, byval homogeneous as gboolean) as GtkWidget ptr
declare sub gtk_table_resize(byval table as GtkTable ptr, byval rows as guint, byval columns as guint)
declare sub gtk_table_attach(byval table as GtkTable ptr, byval child as GtkWidget ptr, byval left_attach as guint, byval right_attach as guint, byval top_attach as guint, byval bottom_attach as guint, byval xoptions as GtkAttachOptions, byval yoptions as GtkAttachOptions, byval xpadding as guint, byval ypadding as guint)
declare sub gtk_table_attach_defaults(byval table as GtkTable ptr, byval widget as GtkWidget ptr, byval left_attach as guint, byval right_attach as guint, byval top_attach as guint, byval bottom_attach as guint)
declare sub gtk_table_set_row_spacing(byval table as GtkTable ptr, byval row as guint, byval spacing as guint)
declare function gtk_table_get_row_spacing(byval table as GtkTable ptr, byval row as guint) as guint
declare sub gtk_table_set_col_spacing(byval table as GtkTable ptr, byval column as guint, byval spacing as guint)
declare function gtk_table_get_col_spacing(byval table as GtkTable ptr, byval column as guint) as guint
declare sub gtk_table_set_row_spacings(byval table as GtkTable ptr, byval spacing as guint)
declare function gtk_table_get_default_row_spacing(byval table as GtkTable ptr) as guint
declare sub gtk_table_set_col_spacings(byval table as GtkTable ptr, byval spacing as guint)
declare function gtk_table_get_default_col_spacing(byval table as GtkTable ptr) as guint
declare sub gtk_table_set_homogeneous(byval table as GtkTable ptr, byval homogeneous as gboolean)
declare function gtk_table_get_homogeneous(byval table as GtkTable ptr) as gboolean
declare sub gtk_table_get_size(byval table as GtkTable ptr, byval rows as guint ptr, byval columns as guint ptr)

#define __GTK_TEAROFF_MENU_ITEM_H__
#define GTK_TYPE_TEAROFF_MENU_ITEM gtk_tearoff_menu_item_get_type()
#define GTK_TEAROFF_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItem)
#define GTK_TEAROFF_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItemClass)
#define GTK_IS_TEAROFF_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEAROFF_MENU_ITEM)
#define GTK_IS_TEAROFF_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEAROFF_MENU_ITEM)
#define GTK_TEAROFF_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItemClass)
type GtkTearoffMenuItem as _GtkTearoffMenuItem
type GtkTearoffMenuItemClass as _GtkTearoffMenuItemClass

type _GtkTearoffMenuItem
	menu_item as GtkMenuItem
	torn_off : 1 as guint
end type

type _GtkTearoffMenuItemClass
	parent_class as GtkMenuItemClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tearoff_menu_item_get_type() as GType
declare function gtk_tearoff_menu_item_new() as GtkWidget ptr
#define __GTK_TEXT_BUFFER_H__
#define __GTK_TEXT_TAG_TABLE_H__
type GtkTextTagTableForeach as sub(byval tag as GtkTextTag ptr, byval data as gpointer)
#define GTK_TYPE_TEXT_TAG_TABLE gtk_text_tag_table_get_type()
#define GTK_TEXT_TAG_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTable)
#define GTK_TEXT_TAG_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass)
#define GTK_IS_TEXT_TAG_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_TAG_TABLE)
#define GTK_IS_TEXT_TAG_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_TAG_TABLE)
#define GTK_TEXT_TAG_TABLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass)
type GtkTextTagTableClass as _GtkTextTagTableClass

type _GtkTextTagTable
	parent_instance as GObject
	hash as GHashTable ptr
	anonymous as GSList ptr
	anon_count as gint
	buffers as GSList ptr
end type

type _GtkTextTagTableClass
	parent_class as GObjectClass
	tag_changed as sub(byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr, byval size_changed as gboolean)
	tag_added as sub(byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr)
	tag_removed as sub(byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_text_tag_table_get_type() as GType
declare function gtk_text_tag_table_new() as GtkTextTagTable ptr
declare sub gtk_text_tag_table_add(byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr)
declare sub gtk_text_tag_table_remove(byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr)
declare function gtk_text_tag_table_lookup(byval table as GtkTextTagTable ptr, byval name as const gchar ptr) as GtkTextTag ptr
declare sub gtk_text_tag_table_foreach(byval table as GtkTextTagTable ptr, byval func as GtkTextTagTableForeach, byval data as gpointer)
declare function gtk_text_tag_table_get_size(byval table as GtkTextTagTable ptr) as gint
declare sub _gtk_text_tag_table_add_buffer(byval table as GtkTextTagTable ptr, byval buffer as gpointer)
declare sub _gtk_text_tag_table_remove_buffer(byval table as GtkTextTagTable ptr, byval buffer as gpointer)
#define __GTK_TEXT_MARK_H__
type GtkTextMark as _GtkTextMark
type GtkTextMarkClass as _GtkTextMarkClass

#define GTK_TYPE_TEXT_MARK gtk_text_mark_get_type()
#define GTK_TEXT_MARK(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_TEXT_MARK, GtkTextMark)
#define GTK_TEXT_MARK_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_MARK, GtkTextMarkClass)
#define GTK_IS_TEXT_MARK(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_TEXT_MARK)
#define GTK_IS_TEXT_MARK_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_MARK)
#define GTK_TEXT_MARK_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_MARK, GtkTextMarkClass)

type _GtkTextMark
	parent_instance as GObject
	segment as gpointer
end type

type _GtkTextMarkClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_text_mark_get_type() as GType
declare sub gtk_text_mark_set_visible(byval mark as GtkTextMark ptr, byval setting as gboolean)
declare function gtk_text_mark_get_visible(byval mark as GtkTextMark ptr) as gboolean
declare function gtk_text_mark_new(byval name as const gchar ptr, byval left_gravity as gboolean) as GtkTextMark ptr
declare function gtk_text_mark_get_name(byval mark as GtkTextMark ptr) as const gchar ptr
declare function gtk_text_mark_get_deleted(byval mark as GtkTextMark ptr) as gboolean
declare function gtk_text_mark_get_buffer(byval mark as GtkTextMark ptr) as GtkTextBuffer ptr
declare function gtk_text_mark_get_left_gravity(byval mark as GtkTextMark ptr) as gboolean

type GtkTextBufferTargetInfo as long
enum
	GTK_TEXT_BUFFER_TARGET_INFO_BUFFER_CONTENTS = -1
	GTK_TEXT_BUFFER_TARGET_INFO_RICH_TEXT = -2
	GTK_TEXT_BUFFER_TARGET_INFO_TEXT = -3
end enum

type GtkTextBTree as _GtkTextBTree
type GtkTextLogAttrCache as _GtkTextLogAttrCache
#define GTK_TYPE_TEXT_BUFFER gtk_text_buffer_get_type()
#define GTK_TEXT_BUFFER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBuffer)
#define GTK_TEXT_BUFFER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass)
#define GTK_IS_TEXT_BUFFER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_BUFFER)
#define GTK_IS_TEXT_BUFFER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_BUFFER)
#define GTK_TEXT_BUFFER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass)
type GtkTextBufferClass as _GtkTextBufferClass

type _GtkTextBuffer
	parent_instance as GObject
	tag_table as GtkTextTagTable ptr
	btree as GtkTextBTree ptr
	clipboard_contents_buffers as GSList ptr
	selection_clipboards as GSList ptr
	log_attr_cache as GtkTextLogAttrCache ptr
	user_action_count as guint
	modified : 1 as guint
	has_selection : 1 as guint
end type

type _GtkTextBufferClass
	parent_class as GObjectClass
	insert_text as sub(byval buffer as GtkTextBuffer ptr, byval pos as GtkTextIter ptr, byval text as const gchar ptr, byval length as gint)
	insert_pixbuf as sub(byval buffer as GtkTextBuffer ptr, byval pos as GtkTextIter ptr, byval pixbuf as GdkPixbuf ptr)
	insert_child_anchor as sub(byval buffer as GtkTextBuffer ptr, byval pos as GtkTextIter ptr, byval anchor as GtkTextChildAnchor ptr)
	delete_range as sub(byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
	changed as sub(byval buffer as GtkTextBuffer ptr)
	modified_changed as sub(byval buffer as GtkTextBuffer ptr)
	mark_set as sub(byval buffer as GtkTextBuffer ptr, byval location as const GtkTextIter ptr, byval mark as GtkTextMark ptr)
	mark_deleted as sub(byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr)
	apply_tag as sub(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start_char as const GtkTextIter ptr, byval end_char as const GtkTextIter ptr)
	remove_tag as sub(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start_char as const GtkTextIter ptr, byval end_char as const GtkTextIter ptr)
	begin_user_action as sub(byval buffer as GtkTextBuffer ptr)
	end_user_action as sub(byval buffer as GtkTextBuffer ptr)
	paste_done as sub(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
end type

declare function gtk_text_buffer_get_type() as GType
declare function gtk_text_buffer_new(byval table as GtkTextTagTable ptr) as GtkTextBuffer ptr
declare function gtk_text_buffer_get_line_count(byval buffer as GtkTextBuffer ptr) as gint
declare function gtk_text_buffer_get_char_count(byval buffer as GtkTextBuffer ptr) as gint
declare function gtk_text_buffer_get_tag_table(byval buffer as GtkTextBuffer ptr) as GtkTextTagTable ptr
declare sub gtk_text_buffer_set_text(byval buffer as GtkTextBuffer ptr, byval text as const gchar ptr, byval len as gint)
declare sub gtk_text_buffer_insert(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as const gchar ptr, byval len as gint)
declare sub gtk_text_buffer_insert_at_cursor(byval buffer as GtkTextBuffer ptr, byval text as const gchar ptr, byval len as gint)
declare function gtk_text_buffer_insert_interactive(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as const gchar ptr, byval len as gint, byval default_editable as gboolean) as gboolean
declare function gtk_text_buffer_insert_interactive_at_cursor(byval buffer as GtkTextBuffer ptr, byval text as const gchar ptr, byval len as gint, byval default_editable as gboolean) as gboolean
declare sub gtk_text_buffer_insert_range(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
declare function gtk_text_buffer_insert_range_interactive(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr, byval default_editable as gboolean) as gboolean
declare sub gtk_text_buffer_insert_with_tags(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as const gchar ptr, byval len as gint, byval first_tag as GtkTextTag ptr, ...)
declare sub gtk_text_buffer_insert_with_tags_by_name(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval text as const gchar ptr, byval len as gint, byval first_tag_name as const gchar ptr, ...)
declare sub gtk_text_buffer_delete(byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare function gtk_text_buffer_delete_interactive(byval buffer as GtkTextBuffer ptr, byval start_iter as GtkTextIter ptr, byval end_iter as GtkTextIter ptr, byval default_editable as gboolean) as gboolean
declare function gtk_text_buffer_backspace(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval interactive as gboolean, byval default_editable as gboolean) as gboolean
declare function gtk_text_buffer_get_text(byval buffer as GtkTextBuffer ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr, byval include_hidden_chars as gboolean) as gchar ptr
declare function gtk_text_buffer_get_slice(byval buffer as GtkTextBuffer ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr, byval include_hidden_chars as gboolean) as gchar ptr
declare sub gtk_text_buffer_insert_pixbuf(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_text_buffer_insert_child_anchor(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval anchor as GtkTextChildAnchor ptr)
declare function gtk_text_buffer_create_child_anchor(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr) as GtkTextChildAnchor ptr
declare sub gtk_text_buffer_add_mark(byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr, byval where as const GtkTextIter ptr)
declare function gtk_text_buffer_create_mark(byval buffer as GtkTextBuffer ptr, byval mark_name as const gchar ptr, byval where as const GtkTextIter ptr, byval left_gravity as gboolean) as GtkTextMark ptr
declare sub gtk_text_buffer_move_mark(byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr, byval where as const GtkTextIter ptr)
declare sub gtk_text_buffer_delete_mark(byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr)
declare function gtk_text_buffer_get_mark(byval buffer as GtkTextBuffer ptr, byval name as const gchar ptr) as GtkTextMark ptr
declare sub gtk_text_buffer_move_mark_by_name(byval buffer as GtkTextBuffer ptr, byval name as const gchar ptr, byval where as const GtkTextIter ptr)
declare sub gtk_text_buffer_delete_mark_by_name(byval buffer as GtkTextBuffer ptr, byval name as const gchar ptr)
declare function gtk_text_buffer_get_insert(byval buffer as GtkTextBuffer ptr) as GtkTextMark ptr
declare function gtk_text_buffer_get_selection_bound(byval buffer as GtkTextBuffer ptr) as GtkTextMark ptr
declare sub gtk_text_buffer_place_cursor(byval buffer as GtkTextBuffer ptr, byval where as const GtkTextIter ptr)
declare sub gtk_text_buffer_select_range(byval buffer as GtkTextBuffer ptr, byval ins as const GtkTextIter ptr, byval bound as const GtkTextIter ptr)
declare sub gtk_text_buffer_apply_tag(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
declare sub gtk_text_buffer_remove_tag(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
declare sub gtk_text_buffer_apply_tag_by_name(byval buffer as GtkTextBuffer ptr, byval name as const gchar ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
declare sub gtk_text_buffer_remove_tag_by_name(byval buffer as GtkTextBuffer ptr, byval name as const gchar ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
declare sub gtk_text_buffer_remove_all_tags(byval buffer as GtkTextBuffer ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
declare function gtk_text_buffer_create_tag(byval buffer as GtkTextBuffer ptr, byval tag_name as const gchar ptr, byval first_property_name as const gchar ptr, ...) as GtkTextTag ptr
declare sub gtk_text_buffer_get_iter_at_line_offset(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval line_number as gint, byval char_offset as gint)
declare sub gtk_text_buffer_get_iter_at_line_index(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval line_number as gint, byval byte_index as gint)
declare sub gtk_text_buffer_get_iter_at_offset(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval char_offset as gint)
declare sub gtk_text_buffer_get_iter_at_line(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval line_number as gint)
declare sub gtk_text_buffer_get_start_iter(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr)
declare sub gtk_text_buffer_get_end_iter(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr)
declare sub gtk_text_buffer_get_bounds(byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub gtk_text_buffer_get_iter_at_mark(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval mark as GtkTextMark ptr)
declare sub gtk_text_buffer_get_iter_at_child_anchor(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval anchor as GtkTextChildAnchor ptr)
declare function gtk_text_buffer_get_modified(byval buffer as GtkTextBuffer ptr) as gboolean
declare sub gtk_text_buffer_set_modified(byval buffer as GtkTextBuffer ptr, byval setting as gboolean)
declare function gtk_text_buffer_get_has_selection(byval buffer as GtkTextBuffer ptr) as gboolean
declare sub gtk_text_buffer_add_selection_clipboard(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
declare sub gtk_text_buffer_remove_selection_clipboard(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
declare sub gtk_text_buffer_cut_clipboard(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr, byval default_editable as gboolean)
declare sub gtk_text_buffer_copy_clipboard(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
declare sub gtk_text_buffer_paste_clipboard(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr, byval override_location as GtkTextIter ptr, byval default_editable as gboolean)
declare function gtk_text_buffer_get_selection_bounds(byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as gboolean
declare function gtk_text_buffer_delete_selection(byval buffer as GtkTextBuffer ptr, byval interactive as gboolean, byval default_editable as gboolean) as gboolean
declare sub gtk_text_buffer_begin_user_action(byval buffer as GtkTextBuffer ptr)
declare sub gtk_text_buffer_end_user_action(byval buffer as GtkTextBuffer ptr)
declare function gtk_text_buffer_get_copy_target_list(byval buffer as GtkTextBuffer ptr) as GtkTargetList ptr
declare function gtk_text_buffer_get_paste_target_list(byval buffer as GtkTextBuffer ptr) as GtkTargetList ptr
declare sub _gtk_text_buffer_spew(byval buffer as GtkTextBuffer ptr)
declare function _gtk_text_buffer_get_btree(byval buffer as GtkTextBuffer ptr) as GtkTextBTree ptr
declare function _gtk_text_buffer_get_line_log_attrs(byval buffer as GtkTextBuffer ptr, byval anywhere_in_line as const GtkTextIter ptr, byval char_len as gint ptr) as const PangoLogAttr ptr
declare sub _gtk_text_buffer_notify_will_remove_tag(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr)
#define __GTK_TEXT_BUFFER_RICH_TEXT_H__
type GtkTextBufferSerializeFunc as function(byval register_buffer as GtkTextBuffer ptr, byval content_buffer as GtkTextBuffer ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr, byval length as gsize ptr, byval user_data as gpointer) as guint8 ptr
type GtkTextBufferDeserializeFunc as function(byval register_buffer as GtkTextBuffer ptr, byval content_buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval data as const guint8 ptr, byval length as gsize, byval create_tags as gboolean, byval user_data as gpointer, byval error as GError ptr ptr) as gboolean
declare function gtk_text_buffer_register_serialize_format(byval buffer as GtkTextBuffer ptr, byval mime_type as const gchar ptr, byval function as GtkTextBufferSerializeFunc, byval user_data as gpointer, byval user_data_destroy as GDestroyNotify) as GdkAtom
declare function gtk_text_buffer_register_serialize_tagset(byval buffer as GtkTextBuffer ptr, byval tagset_name as const gchar ptr) as GdkAtom
declare function gtk_text_buffer_register_deserialize_format(byval buffer as GtkTextBuffer ptr, byval mime_type as const gchar ptr, byval function as GtkTextBufferDeserializeFunc, byval user_data as gpointer, byval user_data_destroy as GDestroyNotify) as GdkAtom
declare function gtk_text_buffer_register_deserialize_tagset(byval buffer as GtkTextBuffer ptr, byval tagset_name as const gchar ptr) as GdkAtom
declare sub gtk_text_buffer_unregister_serialize_format(byval buffer as GtkTextBuffer ptr, byval format as GdkAtom)
declare sub gtk_text_buffer_unregister_deserialize_format(byval buffer as GtkTextBuffer ptr, byval format as GdkAtom)
declare sub gtk_text_buffer_deserialize_set_can_create_tags(byval buffer as GtkTextBuffer ptr, byval format as GdkAtom, byval can_create_tags as gboolean)
declare function gtk_text_buffer_deserialize_get_can_create_tags(byval buffer as GtkTextBuffer ptr, byval format as GdkAtom) as gboolean
declare function gtk_text_buffer_get_serialize_formats(byval buffer as GtkTextBuffer ptr, byval n_formats as gint ptr) as GdkAtom ptr
declare function gtk_text_buffer_get_deserialize_formats(byval buffer as GtkTextBuffer ptr, byval n_formats as gint ptr) as GdkAtom ptr
declare function gtk_text_buffer_serialize(byval register_buffer as GtkTextBuffer ptr, byval content_buffer as GtkTextBuffer ptr, byval format as GdkAtom, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr, byval length as gsize ptr) as guint8 ptr
declare function gtk_text_buffer_deserialize(byval register_buffer as GtkTextBuffer ptr, byval content_buffer as GtkTextBuffer ptr, byval format as GdkAtom, byval iter as GtkTextIter ptr, byval data as const guint8 ptr, byval length as gsize, byval error as GError ptr ptr) as gboolean

#define __GTK_TEXT_VIEW_H__
#define GTK_TYPE_TEXT_VIEW gtk_text_view_get_type()
#define GTK_TEXT_VIEW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_VIEW, GtkTextView)
#define GTK_TEXT_VIEW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_VIEW, GtkTextViewClass)
#define GTK_IS_TEXT_VIEW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_VIEW)
#define GTK_IS_TEXT_VIEW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_VIEW)
#define GTK_TEXT_VIEW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_VIEW, GtkTextViewClass)

type GtkTextWindowType as long
enum
	GTK_TEXT_WINDOW_PRIVATE
	GTK_TEXT_WINDOW_WIDGET
	GTK_TEXT_WINDOW_TEXT
	GTK_TEXT_WINDOW_LEFT
	GTK_TEXT_WINDOW_RIGHT
	GTK_TEXT_WINDOW_TOP
	GTK_TEXT_WINDOW_BOTTOM
end enum

const GTK_TEXT_VIEW_PRIORITY_VALIDATE = GDK_PRIORITY_REDRAW + 5
type GtkTextView as _GtkTextView
type GtkTextViewClass as _GtkTextViewClass
type GtkTextWindow as _GtkTextWindow
type GtkTextPendingScroll as _GtkTextPendingScroll
type _GtkTextLayout as _GtkTextLayout_

type _GtkTextView
	parent_instance as GtkContainer
	layout as _GtkTextLayout ptr
	buffer as GtkTextBuffer ptr
	selection_drag_handler as guint
	scroll_timeout as guint
	pixels_above_lines as gint
	pixels_below_lines as gint
	pixels_inside_wrap as gint
	wrap_mode as GtkWrapMode
	justify as GtkJustification
	left_margin as gint
	right_margin as gint
	indent as gint
	tabs as PangoTabArray ptr
	editable : 1 as guint
	overwrite_mode : 1 as guint
	cursor_visible : 1 as guint
	need_im_reset : 1 as guint
	accepts_tab : 1 as guint
	width_changed : 1 as guint
	onscreen_validated : 1 as guint
	mouse_cursor_obscured : 1 as guint
	text_window as GtkTextWindow ptr
	left_window as GtkTextWindow ptr
	right_window as GtkTextWindow ptr
	top_window as GtkTextWindow ptr
	bottom_window as GtkTextWindow ptr
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
	xoffset as gint
	yoffset as gint
	width as gint
	height as gint
	virtual_cursor_x as gint
	virtual_cursor_y as gint
	first_para_mark as GtkTextMark ptr
	first_para_pixels as gint
	dnd_mark as GtkTextMark ptr
	blink_timeout as guint
	first_validate_idle as guint
	incremental_validate_idle as guint
	im_context as GtkIMContext ptr
	popup_menu as GtkWidget ptr
	drag_start_x as gint
	drag_start_y as gint
	children as GSList ptr
	pending_scroll as GtkTextPendingScroll ptr
	pending_place_cursor_button as gint
end type

type _GtkTextViewClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub(byval text_view as GtkTextView ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
	populate_popup as sub(byval text_view as GtkTextView ptr, byval menu as GtkMenu ptr)
	move_cursor as sub(byval text_view as GtkTextView ptr, byval step as GtkMovementStep, byval count as gint, byval extend_selection as gboolean)
	page_horizontally as sub(byval text_view as GtkTextView ptr, byval count as gint, byval extend_selection as gboolean)
	set_anchor as sub(byval text_view as GtkTextView ptr)
	insert_at_cursor as sub(byval text_view as GtkTextView ptr, byval str as const gchar ptr)
	delete_from_cursor as sub(byval text_view as GtkTextView ptr, byval type as GtkDeleteType, byval count as gint)
	backspace as sub(byval text_view as GtkTextView ptr)
	cut_clipboard as sub(byval text_view as GtkTextView ptr)
	copy_clipboard as sub(byval text_view as GtkTextView ptr)
	paste_clipboard as sub(byval text_view as GtkTextView ptr)
	toggle_overwrite as sub(byval text_view as GtkTextView ptr)
	move_focus as sub(byval text_view as GtkTextView ptr, byval direction as GtkDirectionType)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
end type

declare function gtk_text_view_get_type() as GType
declare function gtk_text_view_new() as GtkWidget ptr
declare function gtk_text_view_new_with_buffer(byval buffer as GtkTextBuffer ptr) as GtkWidget ptr
declare sub gtk_text_view_set_buffer(byval text_view as GtkTextView ptr, byval buffer as GtkTextBuffer ptr)
declare function gtk_text_view_get_buffer(byval text_view as GtkTextView ptr) as GtkTextBuffer ptr
declare function gtk_text_view_scroll_to_iter(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval within_margin as gdouble, byval use_align as gboolean, byval xalign as gdouble, byval yalign as gdouble) as gboolean
declare sub gtk_text_view_scroll_to_mark(byval text_view as GtkTextView ptr, byval mark as GtkTextMark ptr, byval within_margin as gdouble, byval use_align as gboolean, byval xalign as gdouble, byval yalign as gdouble)
declare sub gtk_text_view_scroll_mark_onscreen(byval text_view as GtkTextView ptr, byval mark as GtkTextMark ptr)
declare function gtk_text_view_move_mark_onscreen(byval text_view as GtkTextView ptr, byval mark as GtkTextMark ptr) as gboolean
declare function gtk_text_view_place_cursor_onscreen(byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_get_visible_rect(byval text_view as GtkTextView ptr, byval visible_rect as GdkRectangle ptr)
declare sub gtk_text_view_set_cursor_visible(byval text_view as GtkTextView ptr, byval setting as gboolean)
declare function gtk_text_view_get_cursor_visible(byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_get_iter_location(byval text_view as GtkTextView ptr, byval iter as const GtkTextIter ptr, byval location as GdkRectangle ptr)
declare sub gtk_text_view_get_iter_at_location(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval x as gint, byval y as gint)
declare sub gtk_text_view_get_iter_at_position(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval trailing as gint ptr, byval x as gint, byval y as gint)
declare sub gtk_text_view_get_line_yrange(byval text_view as GtkTextView ptr, byval iter as const GtkTextIter ptr, byval y as gint ptr, byval height as gint ptr)
declare sub gtk_text_view_get_line_at_y(byval text_view as GtkTextView ptr, byval target_iter as GtkTextIter ptr, byval y as gint, byval line_top as gint ptr)
declare sub gtk_text_view_buffer_to_window_coords(byval text_view as GtkTextView ptr, byval win as GtkTextWindowType, byval buffer_x as gint, byval buffer_y as gint, byval window_x as gint ptr, byval window_y as gint ptr)
declare sub gtk_text_view_window_to_buffer_coords(byval text_view as GtkTextView ptr, byval win as GtkTextWindowType, byval window_x as gint, byval window_y as gint, byval buffer_x as gint ptr, byval buffer_y as gint ptr)
declare function gtk_text_view_get_hadjustment(byval text_view as GtkTextView ptr) as GtkAdjustment ptr
declare function gtk_text_view_get_vadjustment(byval text_view as GtkTextView ptr) as GtkAdjustment ptr
declare function gtk_text_view_get_window(byval text_view as GtkTextView ptr, byval win as GtkTextWindowType) as GdkWindow ptr
declare function gtk_text_view_get_window_type(byval text_view as GtkTextView ptr, byval window as GdkWindow ptr) as GtkTextWindowType
declare sub gtk_text_view_set_border_window_size(byval text_view as GtkTextView ptr, byval type as GtkTextWindowType, byval size as gint)
declare function gtk_text_view_get_border_window_size(byval text_view as GtkTextView ptr, byval type as GtkTextWindowType) as gint
declare function gtk_text_view_forward_display_line(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_backward_display_line(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_forward_display_line_end(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_backward_display_line_start(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr) as gboolean
declare function gtk_text_view_starts_display_line(byval text_view as GtkTextView ptr, byval iter as const GtkTextIter ptr) as gboolean
declare function gtk_text_view_move_visually(byval text_view as GtkTextView ptr, byval iter as GtkTextIter ptr, byval count as gint) as gboolean
declare function gtk_text_view_im_context_filter_keypress(byval text_view as GtkTextView ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_text_view_reset_im_context(byval text_view as GtkTextView ptr)
declare sub gtk_text_view_add_child_at_anchor(byval text_view as GtkTextView ptr, byval child as GtkWidget ptr, byval anchor as GtkTextChildAnchor ptr)
declare sub gtk_text_view_add_child_in_window(byval text_view as GtkTextView ptr, byval child as GtkWidget ptr, byval which_window as GtkTextWindowType, byval xpos as gint, byval ypos as gint)
declare sub gtk_text_view_move_child(byval text_view as GtkTextView ptr, byval child as GtkWidget ptr, byval xpos as gint, byval ypos as gint)
declare sub gtk_text_view_set_wrap_mode(byval text_view as GtkTextView ptr, byval wrap_mode as GtkWrapMode)
declare function gtk_text_view_get_wrap_mode(byval text_view as GtkTextView ptr) as GtkWrapMode
declare sub gtk_text_view_set_editable(byval text_view as GtkTextView ptr, byval setting as gboolean)
declare function gtk_text_view_get_editable(byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_set_overwrite(byval text_view as GtkTextView ptr, byval overwrite as gboolean)
declare function gtk_text_view_get_overwrite(byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_set_accepts_tab(byval text_view as GtkTextView ptr, byval accepts_tab as gboolean)
declare function gtk_text_view_get_accepts_tab(byval text_view as GtkTextView ptr) as gboolean
declare sub gtk_text_view_set_pixels_above_lines(byval text_view as GtkTextView ptr, byval pixels_above_lines as gint)
declare function gtk_text_view_get_pixels_above_lines(byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_pixels_below_lines(byval text_view as GtkTextView ptr, byval pixels_below_lines as gint)
declare function gtk_text_view_get_pixels_below_lines(byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_pixels_inside_wrap(byval text_view as GtkTextView ptr, byval pixels_inside_wrap as gint)
declare function gtk_text_view_get_pixels_inside_wrap(byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_justification(byval text_view as GtkTextView ptr, byval justification as GtkJustification)
declare function gtk_text_view_get_justification(byval text_view as GtkTextView ptr) as GtkJustification
declare sub gtk_text_view_set_left_margin(byval text_view as GtkTextView ptr, byval left_margin as gint)
declare function gtk_text_view_get_left_margin(byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_right_margin(byval text_view as GtkTextView ptr, byval right_margin as gint)
declare function gtk_text_view_get_right_margin(byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_indent(byval text_view as GtkTextView ptr, byval indent as gint)
declare function gtk_text_view_get_indent(byval text_view as GtkTextView ptr) as gint
declare sub gtk_text_view_set_tabs(byval text_view as GtkTextView ptr, byval tabs as PangoTabArray ptr)
declare function gtk_text_view_get_tabs(byval text_view as GtkTextView ptr) as PangoTabArray ptr
declare function gtk_text_view_get_default_attributes(byval text_view as GtkTextView ptr) as GtkTextAttributes ptr

#define __GTK_TOOLBAR_H__
#define __GTK_PIXMAP_H__
#define GTK_TYPE_PIXMAP gtk_pixmap_get_type()
#define GTK_PIXMAP(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PIXMAP, GtkPixmap)
#define GTK_PIXMAP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PIXMAP, GtkPixmapClass)
#define GTK_IS_PIXMAP(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PIXMAP)
#define GTK_IS_PIXMAP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PIXMAP)
#define GTK_PIXMAP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PIXMAP, GtkPixmapClass)
type GtkPixmap as _GtkPixmap
type GtkPixmapClass as _GtkPixmapClass

type _GtkPixmap
	misc as GtkMisc
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
	pixmap_insensitive as GdkPixmap ptr
	build_insensitive : 1 as guint
end type

type _GtkPixmapClass
	parent_class as GtkMiscClass
end type

declare function gtk_pixmap_get_type() as GType
declare function gtk_pixmap_new(byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr) as GtkWidget ptr
declare sub gtk_pixmap_set(byval pixmap as GtkPixmap ptr, byval val as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_pixmap_get(byval pixmap as GtkPixmap ptr, byval val as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr)
declare sub gtk_pixmap_set_build_insensitive(byval pixmap as GtkPixmap ptr, byval build as gboolean)

#define GTK_TYPE_TOOLBAR gtk_toolbar_get_type()
#define GTK_TOOLBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOOLBAR, GtkToolbar)
#define GTK_TOOLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOOLBAR, GtkToolbarClass)
#define GTK_IS_TOOLBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOOLBAR)
#define GTK_IS_TOOLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOOLBAR)
#define GTK_TOOLBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOLBAR, GtkToolbarClass)

type GtkToolbarChildType as long
enum
	GTK_TOOLBAR_CHILD_SPACE
	GTK_TOOLBAR_CHILD_BUTTON
	GTK_TOOLBAR_CHILD_TOGGLEBUTTON
	GTK_TOOLBAR_CHILD_RADIOBUTTON
	GTK_TOOLBAR_CHILD_WIDGET
end enum

type GtkToolbarChild as _GtkToolbarChild

type _GtkToolbarChild
	as GtkToolbarChildType type
	widget as GtkWidget ptr
	icon as GtkWidget ptr
	label as GtkWidget ptr
end type

type GtkToolbarSpaceStyle as long
enum
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
	_gtk_reserved1 as guint
	_gtk_reserved2 as guint
	style_set : 1 as guint
	icon_size_set : 1 as guint
end type

type _GtkToolbarClass
	parent_class as GtkContainerClass
	orientation_changed as sub(byval toolbar as GtkToolbar ptr, byval orientation as GtkOrientation)
	style_changed as sub(byval toolbar as GtkToolbar ptr, byval style as GtkToolbarStyle)
	popup_context_menu as function(byval toolbar as GtkToolbar ptr, byval x as gint, byval y as gint, byval button_number as gint) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_toolbar_get_type() as GType
declare function gtk_toolbar_new() as GtkWidget ptr
declare sub gtk_toolbar_insert(byval toolbar as GtkToolbar ptr, byval item as GtkToolItem ptr, byval pos as gint)
declare function gtk_toolbar_get_item_index(byval toolbar as GtkToolbar ptr, byval item as GtkToolItem ptr) as gint
declare function gtk_toolbar_get_n_items(byval toolbar as GtkToolbar ptr) as gint
declare function gtk_toolbar_get_nth_item(byval toolbar as GtkToolbar ptr, byval n as gint) as GtkToolItem ptr
declare function gtk_toolbar_get_show_arrow(byval toolbar as GtkToolbar ptr) as gboolean
declare sub gtk_toolbar_set_show_arrow(byval toolbar as GtkToolbar ptr, byval show_arrow as gboolean)
declare function gtk_toolbar_get_style(byval toolbar as GtkToolbar ptr) as GtkToolbarStyle
declare sub gtk_toolbar_set_style(byval toolbar as GtkToolbar ptr, byval style as GtkToolbarStyle)
declare sub gtk_toolbar_unset_style(byval toolbar as GtkToolbar ptr)
declare function gtk_toolbar_get_icon_size(byval toolbar as GtkToolbar ptr) as GtkIconSize
declare sub gtk_toolbar_set_icon_size(byval toolbar as GtkToolbar ptr, byval icon_size as GtkIconSize)
declare sub gtk_toolbar_unset_icon_size(byval toolbar as GtkToolbar ptr)
declare function gtk_toolbar_get_relief_style(byval toolbar as GtkToolbar ptr) as GtkReliefStyle
declare function gtk_toolbar_get_drop_index(byval toolbar as GtkToolbar ptr, byval x as gint, byval y as gint) as gint
declare sub gtk_toolbar_set_drop_highlight_item(byval toolbar as GtkToolbar ptr, byval tool_item as GtkToolItem ptr, byval index_ as gint)
declare function _gtk_toolbar_elide_underscores(byval original as const gchar ptr) as gchar ptr
declare sub _gtk_toolbar_paint_space_line(byval widget as GtkWidget ptr, byval toolbar as GtkToolbar ptr, byval area as const GdkRectangle ptr, byval allocation as const GtkAllocation ptr)
declare function _gtk_toolbar_get_default_space_size() as gint
declare function gtk_toolbar_get_orientation(byval toolbar as GtkToolbar ptr) as GtkOrientation
declare sub gtk_toolbar_set_orientation(byval toolbar as GtkToolbar ptr, byval orientation as GtkOrientation)
declare function gtk_toolbar_get_tooltips(byval toolbar as GtkToolbar ptr) as gboolean
declare sub gtk_toolbar_set_tooltips(byval toolbar as GtkToolbar ptr, byval enable as gboolean)
declare function gtk_toolbar_append_item(byval toolbar as GtkToolbar ptr, byval text as const zstring ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval icon as GtkWidget ptr, byval callback as GCallback, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_prepend_item(byval toolbar as GtkToolbar ptr, byval text as const zstring ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval icon as GtkWidget ptr, byval callback as GCallback, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_insert_item(byval toolbar as GtkToolbar ptr, byval text as const zstring ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval icon as GtkWidget ptr, byval callback as GCallback, byval user_data as gpointer, byval position as gint) as GtkWidget ptr
declare function gtk_toolbar_insert_stock(byval toolbar as GtkToolbar ptr, byval stock_id as const gchar ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval callback as GCallback, byval user_data as gpointer, byval position as gint) as GtkWidget ptr
declare sub gtk_toolbar_append_space(byval toolbar as GtkToolbar ptr)
declare sub gtk_toolbar_prepend_space(byval toolbar as GtkToolbar ptr)
declare sub gtk_toolbar_insert_space(byval toolbar as GtkToolbar ptr, byval position as gint)
declare sub gtk_toolbar_remove_space(byval toolbar as GtkToolbar ptr, byval position as gint)
declare function gtk_toolbar_append_element(byval toolbar as GtkToolbar ptr, byval type as GtkToolbarChildType, byval widget as GtkWidget ptr, byval text as const zstring ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval icon as GtkWidget ptr, byval callback as GCallback, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_prepend_element(byval toolbar as GtkToolbar ptr, byval type as GtkToolbarChildType, byval widget as GtkWidget ptr, byval text as const zstring ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval icon as GtkWidget ptr, byval callback as GCallback, byval user_data as gpointer) as GtkWidget ptr
declare function gtk_toolbar_insert_element(byval toolbar as GtkToolbar ptr, byval type as GtkToolbarChildType, byval widget as GtkWidget ptr, byval text as const zstring ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval icon as GtkWidget ptr, byval callback as GCallback, byval user_data as gpointer, byval position as gint) as GtkWidget ptr
declare sub gtk_toolbar_append_widget(byval toolbar as GtkToolbar ptr, byval widget as GtkWidget ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr)
declare sub gtk_toolbar_prepend_widget(byval toolbar as GtkToolbar ptr, byval widget as GtkWidget ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr)
declare sub gtk_toolbar_insert_widget(byval toolbar as GtkToolbar ptr, byval widget as GtkWidget ptr, byval tooltip_text as const zstring ptr, byval tooltip_private_text as const zstring ptr, byval position as gint)

#define __GTK_TOOL_ITEM_GROUP_H__
#define GTK_TYPE_TOOL_ITEM_GROUP gtk_tool_item_group_get_type()
#define GTK_TOOL_ITEM_GROUP(obj) G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_TOOL_ITEM_GROUP, GtkToolItemGroup)
#define GTK_TOOL_ITEM_GROUP_CLASS(cls) G_TYPE_CHECK_CLASS_CAST(cls, GTK_TYPE_TOOL_ITEM_GROUP, GtkToolItemGroupClass)
#define GTK_IS_TOOL_ITEM_GROUP(obj) G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_TOOL_ITEM_GROUP)
#define GTK_IS_TOOL_ITEM_GROUP_CLASS(obj) G_TYPE_CHECK_CLASS_TYPE(obj, GTK_TYPE_TOOL_ITEM_GROUP)
#define GTK_TOOL_ITEM_GROUP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOL_ITEM_GROUP, GtkToolItemGroupClass)

type GtkToolItemGroup as _GtkToolItemGroup
type GtkToolItemGroupClass as _GtkToolItemGroupClass
type GtkToolItemGroupPrivate as _GtkToolItemGroupPrivate

type _GtkToolItemGroup
	parent_instance as GtkContainer
	priv as GtkToolItemGroupPrivate ptr
end type

type _GtkToolItemGroupClass
	parent_class as GtkContainerClass
end type

declare function gtk_tool_item_group_get_type() as GType
declare function gtk_tool_item_group_new(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_tool_item_group_set_label(byval group as GtkToolItemGroup ptr, byval label as const gchar ptr)
declare sub gtk_tool_item_group_set_label_widget(byval group as GtkToolItemGroup ptr, byval label_widget as GtkWidget ptr)
declare sub gtk_tool_item_group_set_collapsed(byval group as GtkToolItemGroup ptr, byval collapsed as gboolean)
declare sub gtk_tool_item_group_set_ellipsize(byval group as GtkToolItemGroup ptr, byval ellipsize as PangoEllipsizeMode)
declare sub gtk_tool_item_group_set_header_relief(byval group as GtkToolItemGroup ptr, byval style as GtkReliefStyle)
declare function gtk_tool_item_group_get_label(byval group as GtkToolItemGroup ptr) as const gchar ptr
declare function gtk_tool_item_group_get_label_widget(byval group as GtkToolItemGroup ptr) as GtkWidget ptr
declare function gtk_tool_item_group_get_collapsed(byval group as GtkToolItemGroup ptr) as gboolean
declare function gtk_tool_item_group_get_ellipsize(byval group as GtkToolItemGroup ptr) as PangoEllipsizeMode
declare function gtk_tool_item_group_get_header_relief(byval group as GtkToolItemGroup ptr) as GtkReliefStyle
declare sub gtk_tool_item_group_insert(byval group as GtkToolItemGroup ptr, byval item as GtkToolItem ptr, byval position as gint)
declare sub gtk_tool_item_group_set_item_position(byval group as GtkToolItemGroup ptr, byval item as GtkToolItem ptr, byval position as gint)
declare function gtk_tool_item_group_get_item_position(byval group as GtkToolItemGroup ptr, byval item as GtkToolItem ptr) as gint
declare function gtk_tool_item_group_get_n_items(byval group as GtkToolItemGroup ptr) as guint
declare function gtk_tool_item_group_get_nth_item(byval group as GtkToolItemGroup ptr, byval index as guint) as GtkToolItem ptr
declare function gtk_tool_item_group_get_drop_item(byval group as GtkToolItemGroup ptr, byval x as gint, byval y as gint) as GtkToolItem ptr

#define __GTK_TOOL_PALETTE_H__
#define GTK_TYPE_TOOL_PALETTE gtk_tool_palette_get_type()
#define GTK_TOOL_PALETTE(obj) G_TYPE_CHECK_INSTANCE_CAST(obj, GTK_TYPE_TOOL_PALETTE, GtkToolPalette)
#define GTK_TOOL_PALETTE_CLASS(cls) G_TYPE_CHECK_CLASS_CAST(cls, GTK_TYPE_TOOL_PALETTE, GtkToolPaletteClass)
#define GTK_IS_TOOL_PALETTE(obj) G_TYPE_CHECK_INSTANCE_TYPE(obj, GTK_TYPE_TOOL_PALETTE)
#define GTK_IS_TOOL_PALETTE_CLASS(obj) G_TYPE_CHECK_CLASS_TYPE(obj, GTK_TYPE_TOOL_PALETTE)
#define GTK_TOOL_PALETTE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOL_PALETTE, GtkToolPaletteClass)

type GtkToolPalette as _GtkToolPalette
type GtkToolPaletteClass as _GtkToolPaletteClass
type GtkToolPalettePrivate as _GtkToolPalettePrivate

type GtkToolPaletteDragTargets as long
enum
	GTK_TOOL_PALETTE_DRAG_ITEMS = 1 shl 0
	GTK_TOOL_PALETTE_DRAG_GROUPS = 1 shl 1
end enum

type _GtkToolPalette
	parent_instance as GtkContainer
	priv as GtkToolPalettePrivate ptr
end type

type _GtkToolPaletteClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub(byval widget as GtkWidget ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
end type

declare function gtk_tool_palette_get_type() as GType
declare function gtk_tool_palette_new() as GtkWidget ptr
declare sub gtk_tool_palette_set_group_position(byval palette as GtkToolPalette ptr, byval group as GtkToolItemGroup ptr, byval position as gint)
declare sub gtk_tool_palette_set_exclusive(byval palette as GtkToolPalette ptr, byval group as GtkToolItemGroup ptr, byval exclusive as gboolean)
declare sub gtk_tool_palette_set_expand(byval palette as GtkToolPalette ptr, byval group as GtkToolItemGroup ptr, byval expand as gboolean)
declare function gtk_tool_palette_get_group_position(byval palette as GtkToolPalette ptr, byval group as GtkToolItemGroup ptr) as gint
declare function gtk_tool_palette_get_exclusive(byval palette as GtkToolPalette ptr, byval group as GtkToolItemGroup ptr) as gboolean
declare function gtk_tool_palette_get_expand(byval palette as GtkToolPalette ptr, byval group as GtkToolItemGroup ptr) as gboolean
declare sub gtk_tool_palette_set_icon_size(byval palette as GtkToolPalette ptr, byval icon_size as GtkIconSize)
declare sub gtk_tool_palette_unset_icon_size(byval palette as GtkToolPalette ptr)
declare sub gtk_tool_palette_set_style(byval palette as GtkToolPalette ptr, byval style as GtkToolbarStyle)
declare sub gtk_tool_palette_unset_style(byval palette as GtkToolPalette ptr)
declare function gtk_tool_palette_get_icon_size(byval palette as GtkToolPalette ptr) as GtkIconSize
declare function gtk_tool_palette_get_style(byval palette as GtkToolPalette ptr) as GtkToolbarStyle
declare function gtk_tool_palette_get_drop_item(byval palette as GtkToolPalette ptr, byval x as gint, byval y as gint) as GtkToolItem ptr
declare function gtk_tool_palette_get_drop_group(byval palette as GtkToolPalette ptr, byval x as gint, byval y as gint) as GtkToolItemGroup ptr
declare function gtk_tool_palette_get_drag_item(byval palette as GtkToolPalette ptr, byval selection as const GtkSelectionData ptr) as GtkWidget ptr
declare sub gtk_tool_palette_set_drag_source(byval palette as GtkToolPalette ptr, byval targets as GtkToolPaletteDragTargets)
declare sub gtk_tool_palette_add_drag_dest(byval palette as GtkToolPalette ptr, byval widget as GtkWidget ptr, byval flags as GtkDestDefaults, byval targets as GtkToolPaletteDragTargets, byval actions as GdkDragAction)
declare function gtk_tool_palette_get_hadjustment(byval palette as GtkToolPalette ptr) as GtkAdjustment ptr
declare function gtk_tool_palette_get_vadjustment(byval palette as GtkToolPalette ptr) as GtkAdjustment ptr
declare function gtk_tool_palette_get_drag_target_item() as const GtkTargetEntry ptr
declare function gtk_tool_palette_get_drag_target_group() as const GtkTargetEntry ptr

#define __GTK_TOOL_SHELL_H__
#define GTK_TYPE_TOOL_SHELL gtk_tool_shell_get_type()
#define GTK_TOOL_SHELL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOOL_SHELL, GtkToolShell)
#define GTK_IS_TOOL_SHELL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOOL_SHELL)
#define GTK_TOOL_SHELL_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_TOOL_SHELL, GtkToolShellIface)
type GtkToolShell as _GtkToolShell
type GtkToolShellIface as _GtkToolShellIface

type _GtkToolShellIface
	g_iface as GTypeInterface
	get_icon_size as function(byval shell as GtkToolShell ptr) as GtkIconSize
	get_orientation as function(byval shell as GtkToolShell ptr) as GtkOrientation
	get_style as function(byval shell as GtkToolShell ptr) as GtkToolbarStyle
	get_relief_style as function(byval shell as GtkToolShell ptr) as GtkReliefStyle
	rebuild_menu as sub(byval shell as GtkToolShell ptr)
	get_text_orientation as function(byval shell as GtkToolShell ptr) as GtkOrientation
	get_text_alignment as function(byval shell as GtkToolShell ptr) as gfloat
	get_ellipsize_mode as function(byval shell as GtkToolShell ptr) as PangoEllipsizeMode
	get_text_size_group as function(byval shell as GtkToolShell ptr) as GtkSizeGroup ptr
end type

declare function gtk_tool_shell_get_type() as GType
declare function gtk_tool_shell_get_icon_size(byval shell as GtkToolShell ptr) as GtkIconSize
declare function gtk_tool_shell_get_orientation(byval shell as GtkToolShell ptr) as GtkOrientation
declare function gtk_tool_shell_get_style(byval shell as GtkToolShell ptr) as GtkToolbarStyle
declare function gtk_tool_shell_get_relief_style(byval shell as GtkToolShell ptr) as GtkReliefStyle
declare sub gtk_tool_shell_rebuild_menu(byval shell as GtkToolShell ptr)
declare function gtk_tool_shell_get_text_orientation(byval shell as GtkToolShell ptr) as GtkOrientation
declare function gtk_tool_shell_get_text_alignment(byval shell as GtkToolShell ptr) as gfloat
declare function gtk_tool_shell_get_ellipsize_mode(byval shell as GtkToolShell ptr) as PangoEllipsizeMode
declare function gtk_tool_shell_get_text_size_group(byval shell as GtkToolShell ptr) as GtkSizeGroup ptr
#define __GTK_TEST_UTILS_H__
declare sub gtk_test_init(byval argcp as long ptr, byval argvp as zstring ptr ptr ptr, ...)
declare sub gtk_test_register_all_types()
declare function gtk_test_list_all_types(byval n_types as guint ptr) as const GType ptr
declare function gtk_test_find_widget(byval widget as GtkWidget ptr, byval label_pattern as const gchar ptr, byval widget_type as GType) as GtkWidget ptr
declare function gtk_test_create_widget(byval widget_type as GType, byval first_property_name as const gchar ptr, ...) as GtkWidget ptr
declare function gtk_test_create_simple_window(byval window_title as const gchar ptr, byval dialog_text as const gchar ptr) as GtkWidget ptr
declare function gtk_test_display_button_window(byval window_title as const gchar ptr, byval dialog_text as const gchar ptr, ...) as GtkWidget ptr
declare sub gtk_test_slider_set_perc(byval widget as GtkWidget ptr, byval percentage as double)
declare function gtk_test_slider_get_value(byval widget as GtkWidget ptr) as double
declare function gtk_test_spin_button_click(byval spinner as GtkSpinButton ptr, byval button as guint, byval upwards as gboolean) as gboolean
declare function gtk_test_widget_click(byval widget as GtkWidget ptr, byval button as guint, byval modifiers as GdkModifierType) as gboolean
declare function gtk_test_widget_send_key(byval widget as GtkWidget ptr, byval keyval as guint, byval modifiers as GdkModifierType) as gboolean
declare sub gtk_test_text_set(byval widget as GtkWidget ptr, byval string as const gchar ptr)
declare function gtk_test_text_get(byval widget as GtkWidget ptr) as gchar ptr
declare function gtk_test_find_sibling(byval base_widget as GtkWidget ptr, byval widget_type as GType) as GtkWidget ptr
declare function gtk_test_find_label(byval widget as GtkWidget ptr, byval label_pattern as const gchar ptr) as GtkWidget ptr

#define __GTK_TREE_DND_H__
#define GTK_TYPE_TREE_DRAG_SOURCE gtk_tree_drag_source_get_type()
#define GTK_TREE_DRAG_SOURCE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_DRAG_SOURCE, GtkTreeDragSource)
#define GTK_IS_TREE_DRAG_SOURCE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_DRAG_SOURCE)
#define GTK_TREE_DRAG_SOURCE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_TREE_DRAG_SOURCE, GtkTreeDragSourceIface)
type GtkTreeDragSource as _GtkTreeDragSource
type GtkTreeDragSourceIface as _GtkTreeDragSourceIface

type _GtkTreeDragSourceIface
	g_iface as GTypeInterface
	row_draggable as function(byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr) as gboolean
	drag_data_get as function(byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
	drag_data_delete as function(byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr) as gboolean
end type

declare function gtk_tree_drag_source_get_type() as GType
declare function gtk_tree_drag_source_row_draggable(byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_drag_source_drag_data_delete(byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_drag_source_drag_data_get(byval drag_source as GtkTreeDragSource ptr, byval path as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean

#define GTK_TYPE_TREE_DRAG_DEST gtk_tree_drag_dest_get_type()
#define GTK_TREE_DRAG_DEST(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_DRAG_DEST, GtkTreeDragDest)
#define GTK_IS_TREE_DRAG_DEST(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_DRAG_DEST)
#define GTK_TREE_DRAG_DEST_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_TREE_DRAG_DEST, GtkTreeDragDestIface)
type GtkTreeDragDest as _GtkTreeDragDest
type GtkTreeDragDestIface as _GtkTreeDragDestIface

type _GtkTreeDragDestIface
	g_iface as GTypeInterface
	drag_data_received as function(byval drag_dest as GtkTreeDragDest ptr, byval dest as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
	row_drop_possible as function(byval drag_dest as GtkTreeDragDest ptr, byval dest_path as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
end type

declare function gtk_tree_drag_dest_get_type() as GType
declare function gtk_tree_drag_dest_drag_data_received(byval drag_dest as GtkTreeDragDest ptr, byval dest as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_tree_drag_dest_row_drop_possible(byval drag_dest as GtkTreeDragDest ptr, byval dest_path as GtkTreePath ptr, byval selection_data as GtkSelectionData ptr) as gboolean
declare function gtk_tree_set_row_drag_data(byval selection_data as GtkSelectionData ptr, byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_get_row_drag_data(byval selection_data as GtkSelectionData ptr, byval tree_model as GtkTreeModel ptr ptr, byval path as GtkTreePath ptr ptr) as gboolean

#define __GTK_TREE_MODEL_SORT_H__
#define GTK_TYPE_TREE_MODEL_SORT gtk_tree_model_sort_get_type()
#define GTK_TREE_MODEL_SORT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSort)
#define GTK_TREE_MODEL_SORT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSortClass)
#define GTK_IS_TREE_MODEL_SORT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_MODEL_SORT)
#define GTK_IS_TREE_MODEL_SORT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TREE_MODEL_SORT)
#define GTK_TREE_MODEL_SORT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSortClass)
type GtkTreeModelSort as _GtkTreeModelSort
type GtkTreeModelSortClass as _GtkTreeModelSortClass

type _GtkTreeModelSort
	parent as GObject
	root as gpointer
	stamp as gint
	child_flags as guint
	child_model as GtkTreeModel ptr
	zero_ref_count as gint
	sort_list as GList ptr
	sort_column_id as gint
	order as GtkSortType
	default_sort_func as GtkTreeIterCompareFunc
	default_sort_data as gpointer
	default_sort_destroy as GDestroyNotify
	changed_id as guint
	inserted_id as guint
	has_child_toggled_id as guint
	deleted_id as guint
	reordered_id as guint
end type

type _GtkTreeModelSortClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tree_model_sort_get_type() as GType
declare function gtk_tree_model_sort_new_with_model(byval child_model as GtkTreeModel ptr) as GtkTreeModel ptr
declare function gtk_tree_model_sort_get_model(byval tree_model as GtkTreeModelSort ptr) as GtkTreeModel ptr
declare function gtk_tree_model_sort_convert_child_path_to_path(byval tree_model_sort as GtkTreeModelSort ptr, byval child_path as GtkTreePath ptr) as GtkTreePath ptr
declare function gtk_tree_model_sort_convert_child_iter_to_iter(byval tree_model_sort as GtkTreeModelSort ptr, byval sort_iter as GtkTreeIter ptr, byval child_iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_model_sort_convert_path_to_child_path(byval tree_model_sort as GtkTreeModelSort ptr, byval sorted_path as GtkTreePath ptr) as GtkTreePath ptr
declare sub gtk_tree_model_sort_convert_iter_to_child_iter(byval tree_model_sort as GtkTreeModelSort ptr, byval child_iter as GtkTreeIter ptr, byval sorted_iter as GtkTreeIter ptr)
declare sub gtk_tree_model_sort_reset_default_sort_func(byval tree_model_sort as GtkTreeModelSort ptr)
declare sub gtk_tree_model_sort_clear_cache(byval tree_model_sort as GtkTreeModelSort ptr)
declare function gtk_tree_model_sort_iter_is_valid(byval tree_model_sort as GtkTreeModelSort ptr, byval iter as GtkTreeIter ptr) as gboolean

#define __GTK_TREE_SELECTION_H__
#define GTK_TYPE_TREE_SELECTION gtk_tree_selection_get_type()
#define GTK_TREE_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_SELECTION, GtkTreeSelection)
#define GTK_TREE_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TREE_SELECTION, GtkTreeSelectionClass)
#define GTK_IS_TREE_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_SELECTION)
#define GTK_IS_TREE_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TREE_SELECTION)
#define GTK_TREE_SELECTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_SELECTION, GtkTreeSelectionClass)
type GtkTreeSelectionFunc as function(byval selection as GtkTreeSelection ptr, byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval path_currently_selected as gboolean, byval data as gpointer) as gboolean
type GtkTreeSelectionForeachFunc as sub(byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval data as gpointer)

type _GtkTreeSelection
	parent as GObject
	tree_view as GtkTreeView ptr
	as GtkSelectionMode type
	user_func as GtkTreeSelectionFunc
	user_data as gpointer
	destroy as GDestroyNotify
end type

type _GtkTreeSelectionClass
	parent_class as GObjectClass
	changed as sub(byval selection as GtkTreeSelection ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tree_selection_get_type() as GType
declare sub gtk_tree_selection_set_mode(byval selection as GtkTreeSelection ptr, byval type as GtkSelectionMode)
declare function gtk_tree_selection_get_mode(byval selection as GtkTreeSelection ptr) as GtkSelectionMode
declare sub gtk_tree_selection_set_select_function(byval selection as GtkTreeSelection ptr, byval func as GtkTreeSelectionFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_tree_selection_get_user_data(byval selection as GtkTreeSelection ptr) as gpointer
declare function gtk_tree_selection_get_tree_view(byval selection as GtkTreeSelection ptr) as GtkTreeView ptr
declare function gtk_tree_selection_get_select_function(byval selection as GtkTreeSelection ptr) as GtkTreeSelectionFunc
declare function gtk_tree_selection_get_selected(byval selection as GtkTreeSelection ptr, byval model as GtkTreeModel ptr ptr, byval iter as GtkTreeIter ptr) as gboolean
declare function gtk_tree_selection_get_selected_rows(byval selection as GtkTreeSelection ptr, byval model as GtkTreeModel ptr ptr) as GList ptr
declare function gtk_tree_selection_count_selected_rows(byval selection as GtkTreeSelection ptr) as gint
declare sub gtk_tree_selection_selected_foreach(byval selection as GtkTreeSelection ptr, byval func as GtkTreeSelectionForeachFunc, byval data as gpointer)
declare sub gtk_tree_selection_select_path(byval selection as GtkTreeSelection ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_selection_unselect_path(byval selection as GtkTreeSelection ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_selection_select_iter(byval selection as GtkTreeSelection ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_selection_unselect_iter(byval selection as GtkTreeSelection ptr, byval iter as GtkTreeIter ptr)
declare function gtk_tree_selection_path_is_selected(byval selection as GtkTreeSelection ptr, byval path as GtkTreePath ptr) as gboolean
declare function gtk_tree_selection_iter_is_selected(byval selection as GtkTreeSelection ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_selection_select_all(byval selection as GtkTreeSelection ptr)
declare sub gtk_tree_selection_unselect_all(byval selection as GtkTreeSelection ptr)
declare sub gtk_tree_selection_select_range(byval selection as GtkTreeSelection ptr, byval start_path as GtkTreePath ptr, byval end_path as GtkTreePath ptr)
declare sub gtk_tree_selection_unselect_range(byval selection as GtkTreeSelection ptr, byval start_path as GtkTreePath ptr, byval end_path as GtkTreePath ptr)

#define __GTK_TREE_STORE_H__
#define GTK_TYPE_TREE_STORE gtk_tree_store_get_type()
#define GTK_TREE_STORE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_STORE, GtkTreeStore)
#define GTK_TREE_STORE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TREE_STORE, GtkTreeStoreClass)
#define GTK_IS_TREE_STORE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_STORE)
#define GTK_IS_TREE_STORE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TREE_STORE)
#define GTK_TREE_STORE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_STORE, GtkTreeStoreClass)
type GtkTreeStore as _GtkTreeStore
type GtkTreeStoreClass as _GtkTreeStoreClass

type _GtkTreeStore
	parent as GObject
	stamp as gint
	root as gpointer
	last as gpointer
	n_columns as gint
	sort_column_id as gint
	sort_list as GList ptr
	order as GtkSortType
	column_headers as GType ptr
	default_sort_func as GtkTreeIterCompareFunc
	default_sort_data as gpointer
	default_sort_destroy as GDestroyNotify
	columns_dirty : 1 as guint
end type

type _GtkTreeStoreClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tree_store_get_type() as GType
declare function gtk_tree_store_new(byval n_columns as gint, ...) as GtkTreeStore ptr
declare function gtk_tree_store_newv(byval n_columns as gint, byval types as GType ptr) as GtkTreeStore ptr
declare sub gtk_tree_store_set_column_types(byval tree_store as GtkTreeStore ptr, byval n_columns as gint, byval types as GType ptr)
declare sub gtk_tree_store_set_value(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval column as gint, byval value as GValue ptr)
declare sub gtk_tree_store_set(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, ...)
declare sub gtk_tree_store_set_valuesv(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval columns as gint ptr, byval values as GValue ptr, byval n_values as gint)
declare sub gtk_tree_store_set_valist(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval var_args as va_list)
declare function gtk_tree_store_remove(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_store_insert(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval position as gint)
declare sub gtk_tree_store_insert_before(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_tree_store_insert_after(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval sibling as GtkTreeIter ptr)
declare sub gtk_tree_store_insert_with_values(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval position as gint, ...)
declare sub gtk_tree_store_insert_with_valuesv(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr, byval position as gint, byval columns as gint ptr, byval values as GValue ptr, byval n_values as gint)
declare sub gtk_tree_store_prepend(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr)
declare sub gtk_tree_store_append(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval parent as GtkTreeIter ptr)
declare function gtk_tree_store_is_ancestor(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval descendant as GtkTreeIter ptr) as gboolean
declare function gtk_tree_store_iter_depth(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr) as gint
declare sub gtk_tree_store_clear(byval tree_store as GtkTreeStore ptr)
declare function gtk_tree_store_iter_is_valid(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_tree_store_reorder(byval tree_store as GtkTreeStore ptr, byval parent as GtkTreeIter ptr, byval new_order as gint ptr)
declare sub gtk_tree_store_swap(byval tree_store as GtkTreeStore ptr, byval a as GtkTreeIter ptr, byval b as GtkTreeIter ptr)
declare sub gtk_tree_store_move_before(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)
declare sub gtk_tree_store_move_after(byval tree_store as GtkTreeStore ptr, byval iter as GtkTreeIter ptr, byval position as GtkTreeIter ptr)

#define __GTK_UI_MANAGER_H__
#define GTK_TYPE_UI_MANAGER gtk_ui_manager_get_type()
#define GTK_UI_MANAGER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_UI_MANAGER, GtkUIManager)
#define GTK_UI_MANAGER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_UI_MANAGER, GtkUIManagerClass)
#define GTK_IS_UI_MANAGER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_UI_MANAGER)
#define GTK_IS_UI_MANAGER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_UI_MANAGER)
#define GTK_UI_MANAGER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_UI_MANAGER, GtkUIManagerClass)

type GtkUIManager as _GtkUIManager
type GtkUIManagerClass as _GtkUIManagerClass
type GtkUIManagerPrivate as _GtkUIManagerPrivate

type _GtkUIManager
	parent as GObject
	private_data as GtkUIManagerPrivate ptr
end type

type _GtkUIManagerClass
	parent_class as GObjectClass
	add_widget as sub(byval merge as GtkUIManager ptr, byval widget as GtkWidget ptr)
	actions_changed as sub(byval merge as GtkUIManager ptr)
	connect_proxy as sub(byval merge as GtkUIManager ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
	disconnect_proxy as sub(byval merge as GtkUIManager ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
	pre_activate as sub(byval merge as GtkUIManager ptr, byval action as GtkAction ptr)
	post_activate as sub(byval merge as GtkUIManager ptr, byval action as GtkAction ptr)
	get_widget as function(byval manager as GtkUIManager ptr, byval path as const gchar ptr) as GtkWidget ptr
	get_action as function(byval manager as GtkUIManager ptr, byval path as const gchar ptr) as GtkAction ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

type GtkUIManagerItemType as long
enum
	GTK_UI_MANAGER_AUTO = 0
	GTK_UI_MANAGER_MENUBAR = 1 shl 0
	GTK_UI_MANAGER_MENU = 1 shl 1
	GTK_UI_MANAGER_TOOLBAR = 1 shl 2
	GTK_UI_MANAGER_PLACEHOLDER = 1 shl 3
	GTK_UI_MANAGER_POPUP = 1 shl 4
	GTK_UI_MANAGER_MENUITEM = 1 shl 5
	GTK_UI_MANAGER_TOOLITEM = 1 shl 6
	GTK_UI_MANAGER_SEPARATOR = 1 shl 7
	GTK_UI_MANAGER_ACCELERATOR = 1 shl 8
	GTK_UI_MANAGER_POPUP_WITH_ACCELS = 1 shl 9
end enum

declare function gtk_ui_manager_get_type() as GType
declare function gtk_ui_manager_new() as GtkUIManager ptr
declare sub gtk_ui_manager_set_add_tearoffs(byval self as GtkUIManager ptr, byval add_tearoffs as gboolean)
declare function gtk_ui_manager_get_add_tearoffs(byval self as GtkUIManager ptr) as gboolean
declare sub gtk_ui_manager_insert_action_group(byval self as GtkUIManager ptr, byval action_group as GtkActionGroup ptr, byval pos as gint)
declare sub gtk_ui_manager_remove_action_group(byval self as GtkUIManager ptr, byval action_group as GtkActionGroup ptr)
declare function gtk_ui_manager_get_action_groups(byval self as GtkUIManager ptr) as GList ptr
declare function gtk_ui_manager_get_accel_group(byval self as GtkUIManager ptr) as GtkAccelGroup ptr
declare function gtk_ui_manager_get_widget(byval self as GtkUIManager ptr, byval path as const gchar ptr) as GtkWidget ptr
declare function gtk_ui_manager_get_toplevels(byval self as GtkUIManager ptr, byval types as GtkUIManagerItemType) as GSList ptr
declare function gtk_ui_manager_get_action(byval self as GtkUIManager ptr, byval path as const gchar ptr) as GtkAction ptr
declare function gtk_ui_manager_add_ui_from_string(byval self as GtkUIManager ptr, byval buffer as const gchar ptr, byval length as gssize, byval error as GError ptr ptr) as guint

#ifdef __FB_UNIX__
	declare function gtk_ui_manager_add_ui_from_file(byval self as GtkUIManager ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as guint
#else
	declare function gtk_ui_manager_add_ui_from_file_utf8(byval self as GtkUIManager ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as guint
	declare function gtk_ui_manager_add_ui_from_file alias "gtk_ui_manager_add_ui_from_file_utf8"(byval self as GtkUIManager ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as guint
#endif

declare sub gtk_ui_manager_add_ui(byval self as GtkUIManager ptr, byval merge_id as guint, byval path as const gchar ptr, byval name as const gchar ptr, byval action as const gchar ptr, byval type as GtkUIManagerItemType, byval top as gboolean)
declare sub gtk_ui_manager_remove_ui(byval self as GtkUIManager ptr, byval merge_id as guint)
declare function gtk_ui_manager_get_ui(byval self as GtkUIManager ptr) as gchar ptr
declare sub gtk_ui_manager_ensure_update(byval self as GtkUIManager ptr)
declare function gtk_ui_manager_new_merge_id(byval self as GtkUIManager ptr) as guint

#define __GTK_VBBOX_H__
#define GTK_TYPE_VBUTTON_BOX gtk_vbutton_box_get_type()
#define GTK_VBUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VBUTTON_BOX, GtkVButtonBox)
#define GTK_VBUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VBUTTON_BOX, GtkVButtonBoxClass)
#define GTK_IS_VBUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VBUTTON_BOX)
#define GTK_IS_VBUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VBUTTON_BOX)
#define GTK_VBUTTON_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VBUTTON_BOX, GtkVButtonBoxClass)
type GtkVButtonBox as _GtkVButtonBox
type GtkVButtonBoxClass as _GtkVButtonBoxClass

type _GtkVButtonBox
	button_box as GtkButtonBox
end type

type _GtkVButtonBoxClass
	parent_class as GtkButtonBoxClass
end type

declare function gtk_vbutton_box_get_type() as GType
declare function gtk_vbutton_box_new() as GtkWidget ptr
declare function gtk_vbutton_box_get_spacing_default() as gint
declare sub gtk_vbutton_box_set_spacing_default(byval spacing as gint)
declare function gtk_vbutton_box_get_layout_default() as GtkButtonBoxStyle
declare sub gtk_vbutton_box_set_layout_default(byval layout as GtkButtonBoxStyle)
declare function _gtk_vbutton_box_get_layout_default() as GtkButtonBoxStyle

#define __GTK_VERSION_H__
const GTK_MAJOR_VERSION = 2
const GTK_MINOR_VERSION = 24
const GTK_MICRO_VERSION = 28
const GTK_BINARY_AGE = 2428
const GTK_INTERFACE_AGE = 28
#define GTK_CHECK_VERSION(major, minor, micro) (((GTK_MAJOR_VERSION > (major)) orelse ((GTK_MAJOR_VERSION = (major)) andalso (GTK_MINOR_VERSION > (minor)))) orelse (((GTK_MAJOR_VERSION = (major)) andalso (GTK_MINOR_VERSION = (minor))) andalso (GTK_MICRO_VERSION >= (micro))))
#define __GTK_VOLUME_BUTTON_H__
#define GTK_TYPE_VOLUME_BUTTON gtk_volume_button_get_type()
#define GTK_VOLUME_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VOLUME_BUTTON, GtkVolumeButton)
#define GTK_VOLUME_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VOLUME_BUTTON, GtkVolumeButtonClass)
#define GTK_IS_VOLUME_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VOLUME_BUTTON)
#define GTK_IS_VOLUME_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VOLUME_BUTTON)
#define GTK_VOLUME_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VOLUME_BUTTON, GtkVolumeButtonClass)
type GtkVolumeButton as _GtkVolumeButton
type GtkVolumeButtonClass as _GtkVolumeButtonClass

type _GtkVolumeButton
	parent as GtkScaleButton
end type

type _GtkVolumeButtonClass
	parent_class as GtkScaleButtonClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_volume_button_get_type() as GType
declare function gtk_volume_button_new() as GtkWidget ptr
#define __GTK_VPANED_H__
#define GTK_TYPE_VPANED gtk_vpaned_get_type()
#define GTK_VPANED(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VPANED, GtkVPaned)
#define GTK_VPANED_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VPANED, GtkVPanedClass)
#define GTK_IS_VPANED(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VPANED)
#define GTK_IS_VPANED_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VPANED)
#define GTK_VPANED_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VPANED, GtkVPanedClass)
type GtkVPaned as _GtkVPaned
type GtkVPanedClass as _GtkVPanedClass

type _GtkVPaned
	paned as GtkPaned
end type

type _GtkVPanedClass
	parent_class as GtkPanedClass
end type

declare function gtk_vpaned_get_type() as GType
declare function gtk_vpaned_new() as GtkWidget ptr
#define __GTK_VRULER_H__
#define GTK_TYPE_VRULER gtk_vruler_get_type()
#define GTK_VRULER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VRULER, GtkVRuler)
#define GTK_VRULER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VRULER, GtkVRulerClass)
#define GTK_IS_VRULER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VRULER)
#define GTK_IS_VRULER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VRULER)
#define GTK_VRULER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VRULER, GtkVRulerClass)
type GtkVRuler as _GtkVRuler
type GtkVRulerClass as _GtkVRulerClass

type _GtkVRuler
	ruler as GtkRuler
end type

type _GtkVRulerClass
	parent_class as GtkRulerClass
end type

declare function gtk_vruler_get_type() as GType
declare function gtk_vruler_new() as GtkWidget ptr
#define __GTK_VSCALE_H__
#define GTK_TYPE_VSCALE gtk_vscale_get_type()
#define GTK_VSCALE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VSCALE, GtkVScale)
#define GTK_VSCALE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VSCALE, GtkVScaleClass)
#define GTK_IS_VSCALE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VSCALE)
#define GTK_IS_VSCALE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VSCALE)
#define GTK_VSCALE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VSCALE, GtkVScaleClass)
type GtkVScale as _GtkVScale
type GtkVScaleClass as _GtkVScaleClass

type _GtkVScale
	scale as GtkScale
end type

type _GtkVScaleClass
	parent_class as GtkScaleClass
end type

declare function gtk_vscale_get_type() as GType
declare function gtk_vscale_new(byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_vscale_new_with_range(byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr

#define __GTK_VSEPARATOR_H__
#define GTK_TYPE_VSEPARATOR gtk_vseparator_get_type()
#define GTK_VSEPARATOR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VSEPARATOR, GtkVSeparator)
#define GTK_VSEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VSEPARATOR, GtkVSeparatorClass)
#define GTK_IS_VSEPARATOR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VSEPARATOR)
#define GTK_IS_VSEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VSEPARATOR)
#define GTK_VSEPARATOR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VSEPARATOR, GtkVSeparatorClass)
type GtkVSeparator as _GtkVSeparator
type GtkVSeparatorClass as _GtkVSeparatorClass

type _GtkVSeparator
	separator as GtkSeparator
end type

type _GtkVSeparatorClass
	parent_class as GtkSeparatorClass
end type

declare function gtk_vseparator_get_type() as GType
declare function gtk_vseparator_new() as GtkWidget ptr
#define __GTK_CLIST_H__

enum
	GTK_CLIST_IN_DRAG_ = 1 shl 0
	GTK_CLIST_ROW_HEIGHT_SET_ = 1 shl 1
	GTK_CLIST_SHOW_TITLES_ = 1 shl 2
	GTK_CLIST_ADD_MODE_ = 1 shl 4
	GTK_CLIST_AUTO_SORT_ = 1 shl 5
	GTK_CLIST_AUTO_RESIZE_BLOCKED_ = 1 shl 6
	GTK_CLIST_REORDERABLE_ = 1 shl 7
	GTK_CLIST_USE_DRAG_ICONS_ = 1 shl 8
	GTK_CLIST_DRAW_DRAG_LINE_ = 1 shl 9
	GTK_CLIST_DRAW_DRAG_RECT_ = 1 shl 10
end enum

type GtkCellType as long
enum
	GTK_CELL_EMPTY_
	GTK_CELL_TEXT_
	GTK_CELL_PIXMAP_
	GTK_CELL_PIXTEXT_
	GTK_CELL_WIDGET_
end enum

type GtkCListDragPos as long
enum
	GTK_CLIST_DRAG_NONE
	GTK_CLIST_DRAG_BEFORE
	GTK_CLIST_DRAG_INTO
	GTK_CLIST_DRAG_AFTER
end enum

type GtkButtonAction as long
enum
	GTK_BUTTON_IGNORED = 0
	GTK_BUTTON_SELECTS = 1 shl 0
	GTK_BUTTON_DRAGS = 1 shl 1
	GTK_BUTTON_EXPANDS = 1 shl 2
end enum

#define GTK_TYPE_CLIST gtk_clist_get_type()
#define GTK_CLIST(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CLIST, GtkCList)
#define GTK_CLIST_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CLIST, GtkCListClass)
#define GTK_IS_CLIST(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CLIST)
#define GTK_IS_CLIST_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CLIST)
#define GTK_CLIST_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CLIST, GtkCListClass)
#define GTK_CLIST_FLAGS(clist) GTK_CLIST(clist)->flags
#define GTK_CLIST_SET_FLAG(clist, flag) scope : GTK_CLIST_FLAGS(clist) or= GTK_##flag : end scope
#define GTK_CLIST_UNSET_FLAG(clist, flag) scope : GTK_CLIST_FLAGS(clist) and= not GTK_##flag : end scope
#define GTK_CLIST_IN_DRAG(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_IN_DRAG)
#define GTK_CLIST_ROW_HEIGHT_SET(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_ROW_HEIGHT_SET)
#define GTK_CLIST_SHOW_TITLES(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_SHOW_TITLES)
#define GTK_CLIST_ADD_MODE(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_ADD_MODE)
#define GTK_CLIST_AUTO_SORT(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_AUTO_SORT)
#define GTK_CLIST_AUTO_RESIZE_BLOCKED(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_AUTO_RESIZE_BLOCKED)
#define GTK_CLIST_REORDERABLE(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_REORDERABLE)
#define GTK_CLIST_USE_DRAG_ICONS(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_USE_DRAG_ICONS)
#define GTK_CLIST_DRAW_DRAG_LINE(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_DRAW_DRAG_LINE)
#define GTK_CLIST_DRAW_DRAG_RECT(clist) (GTK_CLIST_FLAGS(clist) and GTK_CLIST_DRAW_DRAG_RECT)
#define GTK_CLIST_ROW(_glist_) cptr(GtkCListRow ptr, (_glist_)->data)
#define GTK_CELL_TEXT(cell) cptr(GtkCellText ptr, @(cell))
#define GTK_CELL_PIXMAP(cell) cptr(GtkCellPixmap ptr, @(cell))
#define GTK_CELL_PIXTEXT(cell) cptr(GtkCellPixText ptr, @(cell))
#define GTK_CELL_WIDGET(cell) cptr(GtkCellWidget ptr, @(cell))

type GtkCList as _GtkCList
type GtkCListClass as _GtkCListClass
type GtkCListColumn as _GtkCListColumn
type GtkCListRow as _GtkCListRow
type GtkCell as _GtkCell
type GtkCellText as _GtkCellText
type GtkCellPixmap as _GtkCellPixmap
type GtkCellPixText as _GtkCellPixText
type GtkCellWidget as _GtkCellWidget
type GtkCListCompareFunc as function(byval clist as GtkCList ptr, byval ptr1 as gconstpointer, byval ptr2 as gconstpointer) as gint
type GtkCListCellInfo as _GtkCListCellInfo
type GtkCListDestInfo as _GtkCListDestInfo

type _GtkCListCellInfo
	row as gint
	column as gint
end type

type _GtkCListDestInfo
	cell as GtkCListCellInfo
	insert_pos as GtkCListDragPos
end type

type _GtkCList
	container as GtkContainer
	flags as guint16
	reserved1 as gpointer
	reserved2 as gpointer
	freeze_count as guint
	internal_allocation as GdkRectangle
	rows as gint
	row_height as gint
	row_list as GList ptr
	row_list_end as GList ptr
	columns as gint
	column_title_area as GdkRectangle
	title_window as GdkWindow ptr
	column as GtkCListColumn ptr
	clist_window as GdkWindow ptr
	clist_window_width as gint
	clist_window_height as gint
	hoffset as gint
	voffset as gint
	shadow_type as GtkShadowType
	selection_mode as GtkSelectionMode
	selection as GList ptr
	selection_end as GList ptr
	undo_selection as GList ptr
	undo_unselection as GList ptr
	undo_anchor as gint
	button_actions(0 to 4) as guint8
	drag_button as guint8
	click_cell as GtkCListCellInfo
	hadjustment as GtkAdjustment ptr
	vadjustment as GtkAdjustment ptr
	xor_gc as GdkGC ptr
	fg_gc as GdkGC ptr
	bg_gc as GdkGC ptr
	cursor_drag as GdkCursor ptr
	x_drag as gint
	focus_row as gint
	focus_header_column as gint
	anchor as gint
	anchor_state as GtkStateType
	drag_pos as gint
	htimer as gint
	vtimer as gint
	sort_type as GtkSortType
	compare as GtkCListCompareFunc
	sort_column as gint
	drag_highlight_row as gint
	drag_highlight_pos as GtkCListDragPos
end type

type _GtkCListClass
	parent_class as GtkContainerClass
	set_scroll_adjustments as sub(byval clist as GtkCList ptr, byval hadjustment as GtkAdjustment ptr, byval vadjustment as GtkAdjustment ptr)
	refresh as sub(byval clist as GtkCList ptr)
	select_row as sub(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval event as GdkEvent ptr)
	unselect_row as sub(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval event as GdkEvent ptr)
	row_move as sub(byval clist as GtkCList ptr, byval source_row as gint, byval dest_row as gint)
	click_column as sub(byval clist as GtkCList ptr, byval column as gint)
	resize_column as sub(byval clist as GtkCList ptr, byval column as gint, byval width as gint)
	toggle_focus_row as sub(byval clist as GtkCList ptr)
	select_all as sub(byval clist as GtkCList ptr)
	unselect_all as sub(byval clist as GtkCList ptr)
	undo_selection as sub(byval clist as GtkCList ptr)
	start_selection as sub(byval clist as GtkCList ptr)
	end_selection as sub(byval clist as GtkCList ptr)
	extend_selection as sub(byval clist as GtkCList ptr, byval scroll_type as GtkScrollType, byval position as gfloat, byval auto_start_selection as gboolean)
	scroll_horizontal as sub(byval clist as GtkCList ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
	scroll_vertical as sub(byval clist as GtkCList ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
	toggle_add_mode as sub(byval clist as GtkCList ptr)
	abort_column_resize as sub(byval clist as GtkCList ptr)
	resync_selection as sub(byval clist as GtkCList ptr, byval event as GdkEvent ptr)
	selection_find as function(byval clist as GtkCList ptr, byval row_number as gint, byval row_list_element as GList ptr) as GList ptr
	draw_row as sub(byval clist as GtkCList ptr, byval area as GdkRectangle ptr, byval row as gint, byval clist_row as GtkCListRow ptr)
	draw_drag_highlight as sub(byval clist as GtkCList ptr, byval target_row as GtkCListRow ptr, byval target_row_number as gint, byval drag_pos as GtkCListDragPos)
	clear as sub(byval clist as GtkCList ptr)
	fake_unselect_all as sub(byval clist as GtkCList ptr, byval row as gint)
	sort_list as sub(byval clist as GtkCList ptr)
	insert_row as function(byval clist as GtkCList ptr, byval row as gint, byval text as gchar ptr ptr) as gint
	remove_row as sub(byval clist as GtkCList ptr, byval row as gint)
	set_cell_contents as sub(byval clist as GtkCList ptr, byval clist_row as GtkCListRow ptr, byval column as gint, byval type as GtkCellType, byval text as const gchar ptr, byval spacing as guint8, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
	cell_size_request as sub(byval clist as GtkCList ptr, byval clist_row as GtkCListRow ptr, byval column as gint, byval requisition as GtkRequisition ptr)
end type

type _GtkCListColumn
	title as gchar ptr
	area as GdkRectangle
	button as GtkWidget ptr
	window as GdkWindow ptr
	width as gint
	min_width as gint
	max_width as gint
	justification as GtkJustification
	visible : 1 as guint
	width_set : 1 as guint
	resizeable : 1 as guint
	auto_resize : 1 as guint
	button_passive : 1 as guint
end type

type _GtkCListRow
	cell as GtkCell ptr
	state as GtkStateType
	foreground as GdkColor
	background as GdkColor
	style as GtkStyle ptr
	data as gpointer
	destroy as GDestroyNotify
	fg_set : 1 as guint
	bg_set : 1 as guint
	selectable : 1 as guint
end type

type _GtkCellText
	as GtkCellType type
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	text as gchar ptr
end type

type _GtkCellPixmap
	as GtkCellType type
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

type _GtkCellPixText
	as GtkCellType type
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	text as gchar ptr
	spacing as guint8
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

type _GtkCellWidget
	as GtkCellType type
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	widget as GtkWidget ptr
end type

type _GtkCell_u_pm
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

type _GtkCell_u_pt
	text as gchar ptr
	spacing as guint8
	pixmap as GdkPixmap ptr
	mask as GdkBitmap ptr
end type

union _GtkCell_u
	text as gchar ptr
	pm as _GtkCell_u_pm
	pt as _GtkCell_u_pt
	widget as GtkWidget ptr
end union

type _GtkCell
	as GtkCellType type
	vertical as gint16
	horizontal as gint16
	style as GtkStyle ptr
	u as _GtkCell_u
end type

declare function gtk_clist_get_type() as GType
declare function gtk_clist_new(byval columns as gint) as GtkWidget ptr
declare function gtk_clist_new_with_titles(byval columns as gint, byval titles as gchar ptr ptr) as GtkWidget ptr
declare sub gtk_clist_set_hadjustment(byval clist as GtkCList ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_clist_set_vadjustment(byval clist as GtkCList ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_clist_get_hadjustment(byval clist as GtkCList ptr) as GtkAdjustment ptr
declare function gtk_clist_get_vadjustment(byval clist as GtkCList ptr) as GtkAdjustment ptr
declare sub gtk_clist_set_shadow_type(byval clist as GtkCList ptr, byval type as GtkShadowType)
declare sub gtk_clist_set_selection_mode(byval clist as GtkCList ptr, byval mode as GtkSelectionMode)
declare sub gtk_clist_set_reorderable(byval clist as GtkCList ptr, byval reorderable as gboolean)
declare sub gtk_clist_set_use_drag_icons(byval clist as GtkCList ptr, byval use_icons as gboolean)
declare sub gtk_clist_set_button_actions(byval clist as GtkCList ptr, byval button as guint, byval button_actions as guint8)
declare sub gtk_clist_freeze(byval clist as GtkCList ptr)
declare sub gtk_clist_thaw(byval clist as GtkCList ptr)
declare sub gtk_clist_column_titles_show(byval clist as GtkCList ptr)
declare sub gtk_clist_column_titles_hide(byval clist as GtkCList ptr)
declare sub gtk_clist_column_title_active(byval clist as GtkCList ptr, byval column as gint)
declare sub gtk_clist_column_title_passive(byval clist as GtkCList ptr, byval column as gint)
declare sub gtk_clist_column_titles_active(byval clist as GtkCList ptr)
declare sub gtk_clist_column_titles_passive(byval clist as GtkCList ptr)
declare sub gtk_clist_set_column_title(byval clist as GtkCList ptr, byval column as gint, byval title as const gchar ptr)
declare function gtk_clist_get_column_title(byval clist as GtkCList ptr, byval column as gint) as gchar ptr
declare sub gtk_clist_set_column_widget(byval clist as GtkCList ptr, byval column as gint, byval widget as GtkWidget ptr)
declare function gtk_clist_get_column_widget(byval clist as GtkCList ptr, byval column as gint) as GtkWidget ptr
declare sub gtk_clist_set_column_justification(byval clist as GtkCList ptr, byval column as gint, byval justification as GtkJustification)
declare sub gtk_clist_set_column_visibility(byval clist as GtkCList ptr, byval column as gint, byval visible as gboolean)
declare sub gtk_clist_set_column_resizeable(byval clist as GtkCList ptr, byval column as gint, byval resizeable as gboolean)
declare sub gtk_clist_set_column_auto_resize(byval clist as GtkCList ptr, byval column as gint, byval auto_resize as gboolean)
declare function gtk_clist_columns_autosize(byval clist as GtkCList ptr) as gint
declare function gtk_clist_optimal_column_width(byval clist as GtkCList ptr, byval column as gint) as gint
declare sub gtk_clist_set_column_width(byval clist as GtkCList ptr, byval column as gint, byval width as gint)
declare sub gtk_clist_set_column_min_width(byval clist as GtkCList ptr, byval column as gint, byval min_width as gint)
declare sub gtk_clist_set_column_max_width(byval clist as GtkCList ptr, byval column as gint, byval max_width as gint)
declare sub gtk_clist_set_row_height(byval clist as GtkCList ptr, byval height as guint)
declare sub gtk_clist_moveto(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval row_align as gfloat, byval col_align as gfloat)
declare function gtk_clist_row_is_visible(byval clist as GtkCList ptr, byval row as gint) as GtkVisibility
declare function gtk_clist_get_cell_type(byval clist as GtkCList ptr, byval row as gint, byval column as gint) as GtkCellType
declare sub gtk_clist_set_text(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as const gchar ptr)
declare function gtk_clist_get_text(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as gchar ptr ptr) as gint
declare sub gtk_clist_set_pixmap(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare function gtk_clist_get_pixmap(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gint
declare sub gtk_clist_set_pixtext(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as const gchar ptr, byval spacing as guint8, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare function gtk_clist_get_pixtext(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval text as gchar ptr ptr, byval spacing as guint8 ptr, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gint
declare sub gtk_clist_set_foreground(byval clist as GtkCList ptr, byval row as gint, byval color as const GdkColor ptr)
declare sub gtk_clist_set_background(byval clist as GtkCList ptr, byval row as gint, byval color as const GdkColor ptr)
declare sub gtk_clist_set_cell_style(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval style as GtkStyle ptr)
declare function gtk_clist_get_cell_style(byval clist as GtkCList ptr, byval row as gint, byval column as gint) as GtkStyle ptr
declare sub gtk_clist_set_row_style(byval clist as GtkCList ptr, byval row as gint, byval style as GtkStyle ptr)
declare function gtk_clist_get_row_style(byval clist as GtkCList ptr, byval row as gint) as GtkStyle ptr
declare sub gtk_clist_set_shift(byval clist as GtkCList ptr, byval row as gint, byval column as gint, byval vertical as gint, byval horizontal as gint)
declare sub gtk_clist_set_selectable(byval clist as GtkCList ptr, byval row as gint, byval selectable as gboolean)
declare function gtk_clist_get_selectable(byval clist as GtkCList ptr, byval row as gint) as gboolean
declare function gtk_clist_prepend(byval clist as GtkCList ptr, byval text as gchar ptr ptr) as gint
declare function gtk_clist_append(byval clist as GtkCList ptr, byval text as gchar ptr ptr) as gint
declare function gtk_clist_insert(byval clist as GtkCList ptr, byval row as gint, byval text as gchar ptr ptr) as gint
declare sub gtk_clist_remove(byval clist as GtkCList ptr, byval row as gint)
declare sub gtk_clist_set_row_data(byval clist as GtkCList ptr, byval row as gint, byval data as gpointer)
declare sub gtk_clist_set_row_data_full(byval clist as GtkCList ptr, byval row as gint, byval data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_clist_get_row_data(byval clist as GtkCList ptr, byval row as gint) as gpointer
declare function gtk_clist_find_row_from_data(byval clist as GtkCList ptr, byval data as gpointer) as gint
declare sub gtk_clist_select_row(byval clist as GtkCList ptr, byval row as gint, byval column as gint)
declare sub gtk_clist_unselect_row(byval clist as GtkCList ptr, byval row as gint, byval column as gint)
declare sub gtk_clist_undo_selection(byval clist as GtkCList ptr)
declare sub gtk_clist_clear(byval clist as GtkCList ptr)
declare function gtk_clist_get_selection_info(byval clist as GtkCList ptr, byval x as gint, byval y as gint, byval row as gint ptr, byval column as gint ptr) as gint
declare sub gtk_clist_select_all(byval clist as GtkCList ptr)
declare sub gtk_clist_unselect_all(byval clist as GtkCList ptr)
declare sub gtk_clist_swap_rows(byval clist as GtkCList ptr, byval row1 as gint, byval row2 as gint)
declare sub gtk_clist_row_move(byval clist as GtkCList ptr, byval source_row as gint, byval dest_row as gint)
declare sub gtk_clist_set_compare_func(byval clist as GtkCList ptr, byval cmp_func as GtkCListCompareFunc)
declare sub gtk_clist_set_sort_column(byval clist as GtkCList ptr, byval column as gint)
declare sub gtk_clist_set_sort_type(byval clist as GtkCList ptr, byval sort_type as GtkSortType)
declare sub gtk_clist_sort(byval clist as GtkCList ptr)
declare sub gtk_clist_set_auto_sort(byval clist as GtkCList ptr, byval auto_sort as gboolean)
declare function _gtk_clist_create_cell_layout(byval clist as GtkCList ptr, byval clist_row as GtkCListRow ptr, byval column as gint) as PangoLayout ptr

#define __GTK_SMART_COMBO_H__
#define GTK_TYPE_COMBO gtk_combo_get_type()
#define GTK_COMBO(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COMBO, GtkCombo)
#define GTK_COMBO_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COMBO, GtkComboClass)
#define GTK_IS_COMBO(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COMBO)
#define GTK_IS_COMBO_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COMBO)
#define GTK_COMBO_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COMBO, GtkComboClass)
type GtkCombo as _GtkCombo
type GtkComboClass as _GtkComboClass

type _GtkCombo
	hbox as GtkHBox
	entry as GtkWidget ptr
	button as GtkWidget ptr
	popup as GtkWidget ptr
	popwin as GtkWidget ptr
	list as GtkWidget ptr
	entry_change_id as guint
	list_change_id as guint
	value_in_list : 1 as guint
	ok_if_empty : 1 as guint
	case_sensitive : 1 as guint
	use_arrows : 1 as guint
	use_arrows_always : 1 as guint
	current_button as guint16
	activate_id as guint
end type

type _GtkComboClass
	parent_class as GtkHBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_combo_get_type() as GType
declare function gtk_combo_new() as GtkWidget ptr
declare sub gtk_combo_set_value_in_list(byval combo as GtkCombo ptr, byval val as gboolean, byval ok_if_empty as gboolean)
declare sub gtk_combo_set_use_arrows(byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_use_arrows_always(byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_case_sensitive(byval combo as GtkCombo ptr, byval val as gboolean)
declare sub gtk_combo_set_item_string(byval combo as GtkCombo ptr, byval item as GtkItem ptr, byval item_value as const gchar ptr)
declare sub gtk_combo_set_popdown_strings(byval combo as GtkCombo ptr, byval strings as GList ptr)
declare sub gtk_combo_disable_activate(byval combo as GtkCombo ptr)

#define __GTK_CTREE_H__
#define GTK_TYPE_CTREE gtk_ctree_get_type()
#define GTK_CTREE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CTREE, GtkCTree)
#define GTK_CTREE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CTREE, GtkCTreeClass)
#define GTK_IS_CTREE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CTREE)
#define GTK_IS_CTREE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CTREE)
#define GTK_CTREE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CTREE, GtkCTreeClass)
#define GTK_CTREE_ROW(_node_) cptr(GtkCTreeRow ptr, cptr(GList ptr, (_node_))->data)
#define GTK_CTREE_NODE(_node_) cptr(GtkCTreeNode ptr, (_node_))
#define GTK_CTREE_NODE_NEXT(_nnode_) cptr(GtkCTreeNode ptr, cptr(GList ptr, (_nnode_))->next)
#define GTK_CTREE_NODE_PREV(_pnode_) cptr(GtkCTreeNode ptr, cptr(GList ptr, (_pnode_))->prev)
#define GTK_CTREE_FUNC(_func_) cast(GtkCTreeFunc, (_func_))
#define GTK_TYPE_CTREE_NODE gtk_ctree_node_get_type()

type GtkCTreePos as long
enum
	GTK_CTREE_POS_BEFORE
	GTK_CTREE_POS_AS_CHILD
	GTK_CTREE_POS_AFTER
end enum

type GtkCTreeLineStyle as long
enum
	GTK_CTREE_LINES_NONE
	GTK_CTREE_LINES_SOLID
	GTK_CTREE_LINES_DOTTED
	GTK_CTREE_LINES_TABBED
end enum

type GtkCTreeExpanderStyle as long
enum
	GTK_CTREE_EXPANDER_NONE
	GTK_CTREE_EXPANDER_SQUARE
	GTK_CTREE_EXPANDER_TRIANGLE
	GTK_CTREE_EXPANDER_CIRCULAR
end enum

type GtkCTreeExpansionType as long
enum
	GTK_CTREE_EXPANSION_EXPAND
	GTK_CTREE_EXPANSION_EXPAND_RECURSIVE
	GTK_CTREE_EXPANSION_COLLAPSE
	GTK_CTREE_EXPANSION_COLLAPSE_RECURSIVE
	GTK_CTREE_EXPANSION_TOGGLE
	GTK_CTREE_EXPANSION_TOGGLE_RECURSIVE
end enum

type GtkCTree as _GtkCTree
type GtkCTreeClass as _GtkCTreeClass
type GtkCTreeRow as _GtkCTreeRow
type GtkCTreeNode as _GtkCTreeNode
type GtkCTreeFunc as sub(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer)
type GtkCTreeGNodeFunc as function(byval ctree as GtkCTree ptr, byval depth as guint, byval gnode as GNode ptr, byval cnode as GtkCTreeNode ptr, byval data as gpointer) as gboolean
type GtkCTreeCompareDragFunc as function(byval ctree as GtkCTree ptr, byval source_node as GtkCTreeNode ptr, byval new_parent as GtkCTreeNode ptr, byval new_sibling as GtkCTreeNode ptr) as gboolean

type _GtkCTree
	clist as GtkCList
	lines_gc as GdkGC ptr
	tree_indent as gint
	tree_spacing as gint
	tree_column as gint
	line_style : 2 as guint
	expander_style : 2 as guint
	show_stub : 1 as guint
	drag_compare as GtkCTreeCompareDragFunc
end type

type _GtkCTreeClass
	parent_class as GtkCListClass
	tree_select_row as sub(byval ctree as GtkCTree ptr, byval row as GtkCTreeNode ptr, byval column as gint)
	tree_unselect_row as sub(byval ctree as GtkCTree ptr, byval row as GtkCTreeNode ptr, byval column as gint)
	tree_expand as sub(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
	tree_collapse as sub(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
	tree_move as sub(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval new_parent as GtkCTreeNode ptr, byval new_sibling as GtkCTreeNode ptr)
	change_focus_row_expansion as sub(byval ctree as GtkCTree ptr, byval action as GtkCTreeExpansionType)
end type

type _GtkCTreeRow
	row as GtkCListRow
	parent as GtkCTreeNode ptr
	sibling as GtkCTreeNode ptr
	children as GtkCTreeNode ptr
	pixmap_closed as GdkPixmap ptr
	mask_closed as GdkBitmap ptr
	pixmap_opened as GdkPixmap ptr
	mask_opened as GdkBitmap ptr
	level as guint16
	is_leaf : 1 as guint
	expanded : 1 as guint
end type

type _GtkCTreeNode
	list as GList
end type

declare function gtk_ctree_get_type() as GType
declare function gtk_ctree_new_with_titles(byval columns as gint, byval tree_column as gint, byval titles as gchar ptr ptr) as GtkWidget ptr
declare function gtk_ctree_new(byval columns as gint, byval tree_column as gint) as GtkWidget ptr
declare function gtk_ctree_insert_node(byval ctree as GtkCTree ptr, byval parent as GtkCTreeNode ptr, byval sibling as GtkCTreeNode ptr, byval text as gchar ptr ptr, byval spacing as guint8, byval pixmap_closed as GdkPixmap ptr, byval mask_closed as GdkBitmap ptr, byval pixmap_opened as GdkPixmap ptr, byval mask_opened as GdkBitmap ptr, byval is_leaf as gboolean, byval expanded as gboolean) as GtkCTreeNode ptr
declare sub gtk_ctree_remove_node(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare function gtk_ctree_insert_gnode(byval ctree as GtkCTree ptr, byval parent as GtkCTreeNode ptr, byval sibling as GtkCTreeNode ptr, byval gnode as GNode ptr, byval func as GtkCTreeGNodeFunc, byval data as gpointer) as GtkCTreeNode ptr
declare function gtk_ctree_export_to_gnode(byval ctree as GtkCTree ptr, byval parent as GNode ptr, byval sibling as GNode ptr, byval node as GtkCTreeNode ptr, byval func as GtkCTreeGNodeFunc, byval data as gpointer) as GNode ptr
declare sub gtk_ctree_post_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval func as GtkCTreeFunc, byval data as gpointer)
declare sub gtk_ctree_post_recursive_to_depth(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint, byval func as GtkCTreeFunc, byval data as gpointer)
declare sub gtk_ctree_pre_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval func as GtkCTreeFunc, byval data as gpointer)
declare sub gtk_ctree_pre_recursive_to_depth(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint, byval func as GtkCTreeFunc, byval data as gpointer)
declare function gtk_ctree_is_viewable(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_last(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as GtkCTreeNode ptr
declare function gtk_ctree_find_node_ptr(byval ctree as GtkCTree ptr, byval ctree_row as GtkCTreeRow ptr) as GtkCTreeNode ptr
declare function gtk_ctree_node_nth(byval ctree as GtkCTree ptr, byval row as guint) as GtkCTreeNode ptr
declare function gtk_ctree_find(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval child as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_is_ancestor(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval child as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_find_by_row_data(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer) as GtkCTreeNode ptr
declare function gtk_ctree_find_all_by_row_data(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer) as GList ptr
declare function gtk_ctree_find_by_row_data_custom(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer, byval func as GCompareFunc) as GtkCTreeNode ptr
declare function gtk_ctree_find_all_by_row_data_custom(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer, byval func as GCompareFunc) as GList ptr
declare function gtk_ctree_is_hot_spot(byval ctree as GtkCTree ptr, byval x as gint, byval y as gint) as gboolean
declare sub gtk_ctree_move(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval new_parent as GtkCTreeNode ptr, byval new_sibling as GtkCTreeNode ptr)
declare sub gtk_ctree_expand(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_expand_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_expand_to_depth(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint)
declare sub gtk_ctree_collapse(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_collapse_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_collapse_to_depth(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval depth as gint)
declare sub gtk_ctree_toggle_expansion(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_toggle_expansion_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_select(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_select_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_unselect(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_unselect_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_real_select_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval state as gint)
declare sub gtk_ctree_node_set_text(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as const gchar ptr)
declare sub gtk_ctree_node_set_pixmap(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_ctree_node_set_pixtext(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as const gchar ptr, byval spacing as guint8, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gtk_ctree_set_node_info(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval text as const gchar ptr, byval spacing as guint8, byval pixmap_closed as GdkPixmap ptr, byval mask_closed as GdkBitmap ptr, byval pixmap_opened as GdkPixmap ptr, byval mask_opened as GdkBitmap ptr, byval is_leaf as gboolean, byval expanded as gboolean)
declare sub gtk_ctree_node_set_shift(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval vertical as gint, byval horizontal as gint)
declare sub gtk_ctree_node_set_selectable(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval selectable as gboolean)
declare function gtk_ctree_node_get_selectable(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as gboolean
declare function gtk_ctree_node_get_cell_type(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint) as GtkCellType
declare function gtk_ctree_node_get_text(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as gchar ptr ptr) as gboolean
declare function gtk_ctree_node_get_pixmap(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gboolean
declare function gtk_ctree_node_get_pixtext(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval text as gchar ptr ptr, byval spacing as guint8 ptr, byval pixmap as GdkPixmap ptr ptr, byval mask as GdkBitmap ptr ptr) as gboolean
declare function gtk_ctree_get_node_info(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval text as gchar ptr ptr, byval spacing as guint8 ptr, byval pixmap_closed as GdkPixmap ptr ptr, byval mask_closed as GdkBitmap ptr ptr, byval pixmap_opened as GdkPixmap ptr ptr, byval mask_opened as GdkBitmap ptr ptr, byval is_leaf as gboolean ptr, byval expanded as gboolean ptr) as gboolean
declare sub gtk_ctree_node_set_row_style(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval style as GtkStyle ptr)
declare function gtk_ctree_node_get_row_style(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as GtkStyle ptr
declare sub gtk_ctree_node_set_cell_style(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval style as GtkStyle ptr)
declare function gtk_ctree_node_get_cell_style(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint) as GtkStyle ptr
declare sub gtk_ctree_node_set_foreground(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval color as const GdkColor ptr)
declare sub gtk_ctree_node_set_background(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval color as const GdkColor ptr)
declare sub gtk_ctree_node_set_row_data(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer)
declare sub gtk_ctree_node_set_row_data_full(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_ctree_node_get_row_data(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as gpointer
declare sub gtk_ctree_node_moveto(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr, byval column as gint, byval row_align as gfloat, byval col_align as gfloat)
declare function gtk_ctree_node_is_visible(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr) as GtkVisibility
declare sub gtk_ctree_set_indent(byval ctree as GtkCTree ptr, byval indent as gint)
declare sub gtk_ctree_set_spacing(byval ctree as GtkCTree ptr, byval spacing as gint)
declare sub gtk_ctree_set_show_stub(byval ctree as GtkCTree ptr, byval show_stub as gboolean)
declare sub gtk_ctree_set_line_style(byval ctree as GtkCTree ptr, byval line_style as GtkCTreeLineStyle)
declare sub gtk_ctree_set_expander_style(byval ctree as GtkCTree ptr, byval expander_style as GtkCTreeExpanderStyle)
declare sub gtk_ctree_set_drag_compare_func(byval ctree as GtkCTree ptr, byval cmp_func as GtkCTreeCompareDragFunc)
declare sub gtk_ctree_sort_node(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
declare sub gtk_ctree_sort_recursive(byval ctree as GtkCTree ptr, byval node as GtkCTreeNode ptr)
#define gtk_ctree_set_reorderable(t, r) gtk_clist_set_reorderable(cptr(GtkCList ptr, (t)), (r))
declare function gtk_ctree_node_get_type() as GType

#define __GTK_CURVE_H__
#define GTK_TYPE_CURVE gtk_curve_get_type()
#define GTK_CURVE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CURVE, GtkCurve)
#define GTK_CURVE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CURVE, GtkCurveClass)
#define GTK_IS_CURVE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CURVE)
#define GTK_IS_CURVE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CURVE)
#define GTK_CURVE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CURVE, GtkCurveClass)
type GtkCurve as _GtkCurve
type GtkCurveClass as _GtkCurveClass

type _GtkCurve
	graph as GtkDrawingArea
	cursor_type as gint
	min_x as gfloat
	max_x as gfloat
	min_y as gfloat
	max_y as gfloat
	pixmap as GdkPixmap ptr
	curve_type as GtkCurveType
	height as gint
	grab_point as gint
	last as gint
	num_points as gint
	point as GdkPoint ptr
	num_ctlpoints as gint
	ctlpoint as gfloat ptr
end type

type _GtkCurveClass
	parent_class as GtkDrawingAreaClass
	curve_type_changed as sub(byval curve as GtkCurve ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_curve_get_type() as GType
declare function gtk_curve_new() as GtkWidget ptr
declare sub gtk_curve_reset(byval curve as GtkCurve ptr)
declare sub gtk_curve_set_gamma(byval curve as GtkCurve ptr, byval gamma_ as gfloat)
declare sub gtk_curve_set_range(byval curve as GtkCurve ptr, byval min_x as gfloat, byval max_x as gfloat, byval min_y as gfloat, byval max_y as gfloat)
declare sub gtk_curve_get_vector(byval curve as GtkCurve ptr, byval veclen as long, byval vector as gfloat ptr)
declare sub gtk_curve_set_vector(byval curve as GtkCurve ptr, byval veclen as long, byval vector as gfloat ptr)
declare sub gtk_curve_set_curve_type(byval curve as GtkCurve ptr, byval type as GtkCurveType)

#define __GTK_FILESEL_H__
#define GTK_TYPE_FILE_SELECTION gtk_file_selection_get_type()
#define GTK_FILE_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FILE_SELECTION, GtkFileSelection)
#define GTK_FILE_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FILE_SELECTION, GtkFileSelectionClass)
#define GTK_IS_FILE_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FILE_SELECTION)
#define GTK_IS_FILE_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FILE_SELECTION)
#define GTK_FILE_SELECTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FILE_SELECTION, GtkFileSelectionClass)
type GtkFileSelection as _GtkFileSelection
type GtkFileSelectionClass as _GtkFileSelectionClass

type _GtkFileSelection
	parent_instance as GtkDialog
	dir_list as GtkWidget ptr
	file_list as GtkWidget ptr
	selection_entry as GtkWidget ptr
	selection_text as GtkWidget ptr
	main_vbox as GtkWidget ptr
	ok_button as GtkWidget ptr
	cancel_button as GtkWidget ptr
	help_button as GtkWidget ptr
	history_pulldown as GtkWidget ptr
	history_menu as GtkWidget ptr
	history_list as GList ptr
	fileop_dialog as GtkWidget ptr
	fileop_entry as GtkWidget ptr
	fileop_file as gchar ptr
	cmpl_state as gpointer
	fileop_c_dir as GtkWidget ptr
	fileop_del_file as GtkWidget ptr
	fileop_ren_file as GtkWidget ptr
	button_area as GtkWidget ptr
	action_area as GtkWidget ptr
	selected_names as GPtrArray ptr
	last_selected as gchar ptr
end type

type _GtkFileSelectionClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_file_selection_get_type() as GType
declare function gtk_file_selection_new(byval title as const gchar ptr) as GtkWidget ptr

#ifdef __FB_UNIX__
	declare sub gtk_file_selection_set_filename(byval filesel as GtkFileSelection ptr, byval filename as const gchar ptr)
	declare function gtk_file_selection_get_filename(byval filesel as GtkFileSelection ptr) as const gchar ptr
#else
	declare sub gtk_file_selection_set_filename_utf8(byval filesel as GtkFileSelection ptr, byval filename as const gchar ptr)
	declare sub gtk_file_selection_set_filename alias "gtk_file_selection_set_filename_utf8"(byval filesel as GtkFileSelection ptr, byval filename as const gchar ptr)
	declare function gtk_file_selection_get_filename_utf8(byval filesel as GtkFileSelection ptr) as const gchar ptr
	declare function gtk_file_selection_get_filename alias "gtk_file_selection_get_filename_utf8"(byval filesel as GtkFileSelection ptr) as const gchar ptr
#endif

declare sub gtk_file_selection_complete(byval filesel as GtkFileSelection ptr, byval pattern as const gchar ptr)
declare sub gtk_file_selection_show_fileop_buttons(byval filesel as GtkFileSelection ptr)
declare sub gtk_file_selection_hide_fileop_buttons(byval filesel as GtkFileSelection ptr)

#ifdef __FB_UNIX__
	declare function gtk_file_selection_get_selections(byval filesel as GtkFileSelection ptr) as gchar ptr ptr
#else
	declare function gtk_file_selection_get_selections_utf8(byval filesel as GtkFileSelection ptr) as gchar ptr ptr
	declare function gtk_file_selection_get_selections alias "gtk_file_selection_get_selections_utf8"(byval filesel as GtkFileSelection ptr) as gchar ptr ptr
#endif

declare sub gtk_file_selection_set_select_multiple(byval filesel as GtkFileSelection ptr, byval select_multiple as gboolean)
declare function gtk_file_selection_get_select_multiple(byval filesel as GtkFileSelection ptr) as gboolean
#define __GTK_GAMMA_CURVE_H__
#define GTK_TYPE_GAMMA_CURVE gtk_gamma_curve_get_type()
#define GTK_GAMMA_CURVE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_GAMMA_CURVE, GtkGammaCurve)
#define GTK_GAMMA_CURVE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_GAMMA_CURVE, GtkGammaCurveClass)
#define GTK_IS_GAMMA_CURVE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_GAMMA_CURVE)
#define GTK_IS_GAMMA_CURVE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_GAMMA_CURVE)
#define GTK_GAMMA_CURVE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_GAMMA_CURVE, GtkGammaCurveClass)
type GtkGammaCurve as _GtkGammaCurve
type GtkGammaCurveClass as _GtkGammaCurveClass

type _GtkGammaCurve
	vbox as GtkVBox
	table as GtkWidget ptr
	curve as GtkWidget ptr
	button(0 to 4) as GtkWidget ptr
	gamma as gfloat
	gamma_dialog as GtkWidget ptr
	gamma_text as GtkWidget ptr
end type

type _GtkGammaCurveClass
	parent_class as GtkVBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_gamma_curve_get_type() as GType
declare function gtk_gamma_curve_new() as GtkWidget ptr
#define __GTK_INPUTDIALOG_H__
#define GTK_TYPE_INPUT_DIALOG gtk_input_dialog_get_type()
#define GTK_INPUT_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_INPUT_DIALOG, GtkInputDialog)
#define GTK_INPUT_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_INPUT_DIALOG, GtkInputDialogClass)
#define GTK_IS_INPUT_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_INPUT_DIALOG)
#define GTK_IS_INPUT_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_INPUT_DIALOG)
#define GTK_INPUT_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_INPUT_DIALOG, GtkInputDialogClass)
type GtkInputDialog as _GtkInputDialog
type GtkInputDialogClass as _GtkInputDialogClass

type _GtkInputDialog
	dialog as GtkDialog
	axis_list as GtkWidget ptr
	axis_listbox as GtkWidget ptr
	mode_optionmenu as GtkWidget ptr
	close_button as GtkWidget ptr
	save_button as GtkWidget ptr
	axis_items(0 to GDK_AXIS_LAST - 1) as GtkWidget ptr
	current_device as GdkDevice ptr
	keys_list as GtkWidget ptr
	keys_listbox as GtkWidget ptr
end type

type _GtkInputDialogClass
	parent_class as GtkDialogClass
	enable_device as sub(byval inputd as GtkInputDialog ptr, byval device as GdkDevice ptr)
	disable_device as sub(byval inputd as GtkInputDialog ptr, byval device as GdkDevice ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_input_dialog_get_type() as GType
declare function gtk_input_dialog_new() as GtkWidget ptr
#define __GTK_ITEM_FACTORY_H__
type GtkPrintFunc as sub(byval func_data as gpointer, byval str as const gchar ptr)
type GtkItemFactoryCallback as sub()
type GtkItemFactoryCallback1 as sub(byval callback_data as gpointer, byval callback_action as guint, byval widget as GtkWidget ptr)

#define GTK_TYPE_ITEM_FACTORY gtk_item_factory_get_type()
#define GTK_ITEM_FACTORY(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_ITEM_FACTORY, GtkItemFactory)
#define GTK_ITEM_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ITEM_FACTORY, GtkItemFactoryClass)
#define GTK_IS_ITEM_FACTORY(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_ITEM_FACTORY)
#define GTK_IS_ITEM_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ITEM_FACTORY)
#define GTK_ITEM_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ITEM_FACTORY, GtkItemFactoryClass)

type GtkItemFactory as _GtkItemFactory
type GtkItemFactoryClass as _GtkItemFactoryClass
type GtkItemFactoryEntry as _GtkItemFactoryEntry
type GtkItemFactoryItem as _GtkItemFactoryItem

type _GtkItemFactory
	object as GtkObject
	path as gchar ptr
	accel_group as GtkAccelGroup ptr
	widget as GtkWidget ptr
	items as GSList ptr
	translate_func as GtkTranslateFunc
	translate_data as gpointer
	translate_notify as GDestroyNotify
end type

type _GtkItemFactoryClass
	object_class as GtkObjectClass
	item_ht as GHashTable ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkItemFactoryEntry
	path as gchar ptr
	accelerator as gchar ptr
	callback as GtkItemFactoryCallback
	callback_action as guint
	item_type as gchar ptr
	extra_data as gconstpointer
end type

type _GtkItemFactoryItem
	path as gchar ptr
	widgets as GSList ptr
end type

declare function gtk_item_factory_get_type() as GType
declare function gtk_item_factory_new(byval container_type as GType, byval path as const gchar ptr, byval accel_group as GtkAccelGroup ptr) as GtkItemFactory ptr
declare sub gtk_item_factory_construct(byval ifactory as GtkItemFactory ptr, byval container_type as GType, byval path as const gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare sub gtk_item_factory_add_foreign(byval accel_widget as GtkWidget ptr, byval full_path as const gchar ptr, byval accel_group as GtkAccelGroup ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare function gtk_item_factory_from_widget(byval widget as GtkWidget ptr) as GtkItemFactory ptr
declare function gtk_item_factory_path_from_widget(byval widget as GtkWidget ptr) as const gchar ptr
declare function gtk_item_factory_get_item(byval ifactory as GtkItemFactory ptr, byval path as const gchar ptr) as GtkWidget ptr
declare function gtk_item_factory_get_widget(byval ifactory as GtkItemFactory ptr, byval path as const gchar ptr) as GtkWidget ptr
declare function gtk_item_factory_get_widget_by_action(byval ifactory as GtkItemFactory ptr, byval action as guint) as GtkWidget ptr
declare function gtk_item_factory_get_item_by_action(byval ifactory as GtkItemFactory ptr, byval action as guint) as GtkWidget ptr
declare sub gtk_item_factory_create_item(byval ifactory as GtkItemFactory ptr, byval entry as GtkItemFactoryEntry ptr, byval callback_data as gpointer, byval callback_type as guint)
declare sub gtk_item_factory_create_items(byval ifactory as GtkItemFactory ptr, byval n_entries as guint, byval entries as GtkItemFactoryEntry ptr, byval callback_data as gpointer)
declare sub gtk_item_factory_delete_item(byval ifactory as GtkItemFactory ptr, byval path as const gchar ptr)
declare sub gtk_item_factory_delete_entry(byval ifactory as GtkItemFactory ptr, byval entry as GtkItemFactoryEntry ptr)
declare sub gtk_item_factory_delete_entries(byval ifactory as GtkItemFactory ptr, byval n_entries as guint, byval entries as GtkItemFactoryEntry ptr)
declare sub gtk_item_factory_popup(byval ifactory as GtkItemFactory ptr, byval x as guint, byval y as guint, byval mouse_button as guint, byval time_ as guint32)
declare sub gtk_item_factory_popup_with_data(byval ifactory as GtkItemFactory ptr, byval popup_data as gpointer, byval destroy as GDestroyNotify, byval x as guint, byval y as guint, byval mouse_button as guint, byval time_ as guint32)
declare function gtk_item_factory_popup_data(byval ifactory as GtkItemFactory ptr) as gpointer
declare function gtk_item_factory_popup_data_from_widget(byval widget as GtkWidget ptr) as gpointer
declare sub gtk_item_factory_set_translate_func(byval ifactory as GtkItemFactory ptr, byval func as GtkTranslateFunc, byval data as gpointer, byval notify as GDestroyNotify)
type GtkMenuCallback as sub(byval widget as GtkWidget ptr, byval user_data as gpointer)

type GtkMenuEntry
	path as gchar ptr
	accelerator as gchar ptr
	callback as GtkMenuCallback
	callback_data as gpointer
	widget as GtkWidget ptr
end type

type GtkItemFactoryCallback2 as sub(byval widget as GtkWidget ptr, byval callback_data as gpointer, byval callback_action as guint)
declare sub gtk_item_factory_create_items_ac(byval ifactory as GtkItemFactory ptr, byval n_entries as guint, byval entries as GtkItemFactoryEntry ptr, byval callback_data as gpointer, byval callback_type as guint)
declare function gtk_item_factory_from_path(byval path as const gchar ptr) as GtkItemFactory ptr
declare sub gtk_item_factory_create_menu_entries(byval n_entries as guint, byval entries as GtkMenuEntry ptr)
declare sub gtk_item_factories_path_delete(byval ifactory_path as const gchar ptr, byval path as const gchar ptr)

#define __GTK_LIST_H__
#define GTK_TYPE_LIST gtk_list_get_type()
#define GTK_LIST(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LIST, GtkList)
#define GTK_LIST_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LIST, GtkListClass)
#define GTK_IS_LIST(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LIST)
#define GTK_IS_LIST_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LIST)
#define GTK_LIST_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LIST, GtkListClass)
type GtkList as _GtkList
type GtkListClass as _GtkListClass

type _GtkList
	container as GtkContainer
	children as GList ptr
	selection as GList ptr
	undo_selection as GList ptr
	undo_unselection as GList ptr
	last_focus_child as GtkWidget ptr
	undo_focus_child as GtkWidget ptr
	htimer as guint
	vtimer as guint
	anchor as gint
	drag_pos as gint
	anchor_state as GtkStateType
	selection_mode : 2 as guint
	drag_selection : 1 as guint
	add_mode : 1 as guint
end type

type _GtkListClass
	parent_class as GtkContainerClass
	selection_changed as sub(byval list as GtkList ptr)
	select_child as sub(byval list as GtkList ptr, byval child as GtkWidget ptr)
	unselect_child as sub(byval list as GtkList ptr, byval child as GtkWidget ptr)
end type

declare function gtk_list_get_type() as GType
declare function gtk_list_new() as GtkWidget ptr
declare sub gtk_list_insert_items(byval list as GtkList ptr, byval items as GList ptr, byval position as gint)
declare sub gtk_list_append_items(byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_prepend_items(byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_remove_items(byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_remove_items_no_unref(byval list as GtkList ptr, byval items as GList ptr)
declare sub gtk_list_clear_items(byval list as GtkList ptr, byval start as gint, byval end as gint)
declare sub gtk_list_select_item(byval list as GtkList ptr, byval item as gint)
declare sub gtk_list_unselect_item(byval list as GtkList ptr, byval item as gint)
declare sub gtk_list_select_child(byval list as GtkList ptr, byval child as GtkWidget ptr)
declare sub gtk_list_unselect_child(byval list as GtkList ptr, byval child as GtkWidget ptr)
declare function gtk_list_child_position(byval list as GtkList ptr, byval child as GtkWidget ptr) as gint
declare sub gtk_list_set_selection_mode(byval list as GtkList ptr, byval mode as GtkSelectionMode)
declare sub gtk_list_extend_selection(byval list as GtkList ptr, byval scroll_type as GtkScrollType, byval position as gfloat, byval auto_start_selection as gboolean)
declare sub gtk_list_start_selection(byval list as GtkList ptr)
declare sub gtk_list_end_selection(byval list as GtkList ptr)
declare sub gtk_list_select_all(byval list as GtkList ptr)
declare sub gtk_list_unselect_all(byval list as GtkList ptr)
declare sub gtk_list_scroll_horizontal(byval list as GtkList ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
declare sub gtk_list_scroll_vertical(byval list as GtkList ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
declare sub gtk_list_toggle_add_mode(byval list as GtkList ptr)
declare sub gtk_list_toggle_focus_row(byval list as GtkList ptr)
declare sub gtk_list_toggle_row(byval list as GtkList ptr, byval item as GtkWidget ptr)
declare sub gtk_list_undo_selection(byval list as GtkList ptr)
declare sub gtk_list_end_drag_selection(byval list as GtkList ptr)

#define __GTK_LIST_ITEM_H__
#define GTK_TYPE_LIST_ITEM gtk_list_item_get_type()
#define GTK_LIST_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LIST_ITEM, GtkListItem)
#define GTK_LIST_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LIST_ITEM, GtkListItemClass)
#define GTK_IS_LIST_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LIST_ITEM)
#define GTK_IS_LIST_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LIST_ITEM)
#define GTK_LIST_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LIST_ITEM, GtkListItemClass)
type GtkListItem as _GtkListItem
type GtkListItemClass as _GtkListItemClass

type _GtkListItem
	item as GtkItem
end type

type _GtkListItemClass
	parent_class as GtkItemClass
	toggle_focus_row as sub(byval list_item as GtkListItem ptr)
	select_all as sub(byval list_item as GtkListItem ptr)
	unselect_all as sub(byval list_item as GtkListItem ptr)
	undo_selection as sub(byval list_item as GtkListItem ptr)
	start_selection as sub(byval list_item as GtkListItem ptr)
	end_selection as sub(byval list_item as GtkListItem ptr)
	extend_selection as sub(byval list_item as GtkListItem ptr, byval scroll_type as GtkScrollType, byval position as gfloat, byval auto_start_selection as gboolean)
	scroll_horizontal as sub(byval list_item as GtkListItem ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
	scroll_vertical as sub(byval list_item as GtkListItem ptr, byval scroll_type as GtkScrollType, byval position as gfloat)
	toggle_add_mode as sub(byval list_item as GtkListItem ptr)
end type

declare function gtk_list_item_get_type() as GType
declare function gtk_list_item_new() as GtkWidget ptr
declare function gtk_list_item_new_with_label(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_list_item_select(byval list_item as GtkListItem ptr)
declare sub gtk_list_item_deselect(byval list_item as GtkListItem ptr)

#define __GTK_OLD_EDITABLE_H__
#define GTK_TYPE_OLD_EDITABLE gtk_old_editable_get_type()
#define GTK_OLD_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_OLD_EDITABLE, GtkOldEditable)
#define GTK_OLD_EDITABLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_OLD_EDITABLE, GtkOldEditableClass)
#define GTK_IS_OLD_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_OLD_EDITABLE)
#define GTK_IS_OLD_EDITABLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_OLD_EDITABLE)
#define GTK_OLD_EDITABLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_OLD_EDITABLE, GtkOldEditableClass)

type GtkOldEditable as _GtkOldEditable
type GtkOldEditableClass as _GtkOldEditableClass
type GtkTextFunction as sub(byval editable as GtkOldEditable ptr, byval time_ as guint32)

type _GtkOldEditable
	widget as GtkWidget
	current_pos as guint
	selection_start_pos as guint
	selection_end_pos as guint
	has_selection : 1 as guint
	editable : 1 as guint
	visible : 1 as guint
	clipboard_text as gchar ptr
end type

type _GtkOldEditableClass
	parent_class as GtkWidgetClass
	activate as sub(byval editable as GtkOldEditable ptr)
	set_editable as sub(byval editable as GtkOldEditable ptr, byval is_editable as gboolean)
	move_cursor as sub(byval editable as GtkOldEditable ptr, byval x as gint, byval y as gint)
	move_word as sub(byval editable as GtkOldEditable ptr, byval n as gint)
	move_page as sub(byval editable as GtkOldEditable ptr, byval x as gint, byval y as gint)
	move_to_row as sub(byval editable as GtkOldEditable ptr, byval row as gint)
	move_to_column as sub(byval editable as GtkOldEditable ptr, byval row as gint)
	kill_char as sub(byval editable as GtkOldEditable ptr, byval direction as gint)
	kill_word as sub(byval editable as GtkOldEditable ptr, byval direction as gint)
	kill_line as sub(byval editable as GtkOldEditable ptr, byval direction as gint)
	cut_clipboard as sub(byval editable as GtkOldEditable ptr)
	copy_clipboard as sub(byval editable as GtkOldEditable ptr)
	paste_clipboard as sub(byval editable as GtkOldEditable ptr)
	update_text as sub(byval editable as GtkOldEditable ptr, byval start_pos as gint, byval end_pos as gint)
	get_chars as function(byval editable as GtkOldEditable ptr, byval start_pos as gint, byval end_pos as gint) as gchar ptr
	set_selection as sub(byval editable as GtkOldEditable ptr, byval start_pos as gint, byval end_pos as gint)
	set_position as sub(byval editable as GtkOldEditable ptr, byval position as gint)
end type

declare function gtk_old_editable_get_type() as GType
declare sub gtk_old_editable_claim_selection(byval old_editable as GtkOldEditable ptr, byval claim as gboolean, byval time_ as guint32)
declare sub gtk_old_editable_changed(byval old_editable as GtkOldEditable ptr)

#define __GTK_OPTION_MENU_H__
#define GTK_TYPE_OPTION_MENU gtk_option_menu_get_type()
#define GTK_OPTION_MENU(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_OPTION_MENU, GtkOptionMenu)
#define GTK_OPTION_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_OPTION_MENU, GtkOptionMenuClass)
#define GTK_IS_OPTION_MENU(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_OPTION_MENU)
#define GTK_IS_OPTION_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_OPTION_MENU)
#define GTK_OPTION_MENU_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_OPTION_MENU, GtkOptionMenuClass)
type GtkOptionMenu as _GtkOptionMenu
type GtkOptionMenuClass as _GtkOptionMenuClass

type _GtkOptionMenu
	button as GtkButton
	menu as GtkWidget ptr
	menu_item as GtkWidget ptr
	width as guint16
	height as guint16
end type

type _GtkOptionMenuClass
	parent_class as GtkButtonClass
	changed as sub(byval option_menu as GtkOptionMenu ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_option_menu_get_type() as GType
declare function gtk_option_menu_new() as GtkWidget ptr
declare function gtk_option_menu_get_menu(byval option_menu as GtkOptionMenu ptr) as GtkWidget ptr
declare sub gtk_option_menu_set_menu(byval option_menu as GtkOptionMenu ptr, byval menu as GtkWidget ptr)
declare sub gtk_option_menu_remove_menu(byval option_menu as GtkOptionMenu ptr)
declare function gtk_option_menu_get_history(byval option_menu as GtkOptionMenu ptr) as gint
declare sub gtk_option_menu_set_history(byval option_menu as GtkOptionMenu ptr, byval index_ as guint)

#define __GTK_PREVIEW_H__
#define GTK_TYPE_PREVIEW gtk_preview_get_type()
#define GTK_PREVIEW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PREVIEW, GtkPreview)
#define GTK_PREVIEW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PREVIEW, GtkPreviewClass)
#define GTK_IS_PREVIEW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PREVIEW)
#define GTK_IS_PREVIEW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PREVIEW)
#define GTK_PREVIEW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PREVIEW, GtkPreviewClass)

type GtkPreview as _GtkPreview
type GtkPreviewInfo as _GtkPreviewInfo
type GtkDitherInfo as _GtkDitherInfo
type GtkPreviewClass as _GtkPreviewClass

type _GtkPreview
	widget as GtkWidget
	buffer as guchar ptr
	buffer_width as guint16
	buffer_height as guint16
	bpp as guint16
	rowstride as guint16
	dither as GdkRgbDither
	as guint type : 1
	expand : 1 as guint
end type

type _GtkPreviewInfo
	lookup as guchar ptr
	gamma as gdouble
end type

union _GtkDitherInfo
	s(0 to 1) as gushort
	c(0 to 3) as guchar
end union

type _GtkPreviewClass
	parent_class as GtkWidgetClass
	info as GtkPreviewInfo
end type

declare function gtk_preview_get_type() as GType
declare sub gtk_preview_uninit()
declare function gtk_preview_new(byval type as GtkPreviewType) as GtkWidget ptr
declare sub gtk_preview_size(byval preview as GtkPreview ptr, byval width as gint, byval height as gint)
declare sub gtk_preview_put(byval preview as GtkPreview ptr, byval window as GdkWindow ptr, byval gc as GdkGC ptr, byval srcx as gint, byval srcy as gint, byval destx as gint, byval desty as gint, byval width as gint, byval height as gint)
declare sub gtk_preview_draw_row(byval preview as GtkPreview ptr, byval data as guchar ptr, byval x as gint, byval y as gint, byval w as gint)
declare sub gtk_preview_set_expand(byval preview as GtkPreview ptr, byval expand as gboolean)
declare sub gtk_preview_set_gamma(byval gamma_ as double)
declare sub gtk_preview_set_color_cube(byval nred_shades as guint, byval ngreen_shades as guint, byval nblue_shades as guint, byval ngray_shades as guint)
declare sub gtk_preview_set_install_cmap(byval install_cmap as gint)
declare sub gtk_preview_set_reserved(byval nreserved as gint)
declare sub gtk_preview_set_dither(byval preview as GtkPreview ptr, byval dither as GdkRgbDither)
declare function gtk_preview_get_visual() as GdkVisual ptr
declare function gtk_preview_get_cmap() as GdkColormap ptr
declare function gtk_preview_get_info() as GtkPreviewInfo ptr
declare sub gtk_preview_reset()

#define __GTK_TIPS_QUERY_H__
#define GTK_TYPE_TIPS_QUERY gtk_tips_query_get_type()
#define GTK_TIPS_QUERY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TIPS_QUERY, GtkTipsQuery)
#define GTK_TIPS_QUERY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TIPS_QUERY, GtkTipsQueryClass)
#define GTK_IS_TIPS_QUERY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TIPS_QUERY)
#define GTK_IS_TIPS_QUERY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TIPS_QUERY)
#define GTK_TIPS_QUERY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TIPS_QUERY, GtkTipsQueryClass)
type GtkTipsQuery as _GtkTipsQuery
type GtkTipsQueryClass as _GtkTipsQueryClass

type _GtkTipsQuery
	label as GtkLabel
	emit_always : 1 as guint
	in_query : 1 as guint
	label_inactive as gchar ptr
	label_no_tip as gchar ptr
	caller as GtkWidget ptr
	last_crossed as GtkWidget ptr
	query_cursor as GdkCursor ptr
end type

type _GtkTipsQueryClass
	parent_class as GtkLabelClass
	start_query as sub(byval tips_query as GtkTipsQuery ptr)
	stop_query as sub(byval tips_query as GtkTipsQuery ptr)
	widget_entered as sub(byval tips_query as GtkTipsQuery ptr, byval widget as GtkWidget ptr, byval tip_text as const gchar ptr, byval tip_private as const gchar ptr)
	widget_selected as function(byval tips_query as GtkTipsQuery ptr, byval widget as GtkWidget ptr, byval tip_text as const gchar ptr, byval tip_private as const gchar ptr, byval event as GdkEventButton ptr) as gint
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tips_query_get_type() as GType
declare function gtk_tips_query_new() as GtkWidget ptr
declare sub gtk_tips_query_start_query(byval tips_query as GtkTipsQuery ptr)
declare sub gtk_tips_query_stop_query(byval tips_query as GtkTipsQuery ptr)
declare sub gtk_tips_query_set_caller(byval tips_query as GtkTipsQuery ptr, byval caller as GtkWidget ptr)
declare sub gtk_tips_query_set_labels(byval tips_query as GtkTipsQuery ptr, byval label_inactive as const gchar ptr, byval label_no_tip as const gchar ptr)
#undef __GTK_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
