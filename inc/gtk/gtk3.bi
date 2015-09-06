'' FreeBASIC binding for gtk+-3.16.6
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
''   License along with this library. If not, see <http://www.gnu.org/licenses/>.
''
'' translated to FreeBASIC by:
''   (C) 2011, 2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
''   Copyright © 2015 FreeBASIC development team

#pragma once

#inclib "gtk-3"

#include once "gdk/gdk3.bi"
#include once "glib-object.bi"
#include once "atk/atk.bi"
#include once "gio/gio.bi"
#include once "glib.bi"
#include once "gdk-pixbuf/gdk-pixbuf.bi"
#include once "pango/pango.bi"
#include once "cairo/cairo.bi"
#include once "crt/time.bi"
#include once "crt/stdarg.bi"

'' The following symbols have been renamed:
''     procedure gtk_check_version => gtk_check_version_
''     #ifdef __FB_WIN32__
''         procedure gtk_init => gtk_init_
''         procedure gtk_init_check => gtk_init_check_
''     #endif
''     #define GTK_STOCK_ADD => GTK_STOCK_ADD_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __GTK_H__
#define __GTK_H_INSIDE__
#define __GTK_ABOUT_DIALOG_H__
#define __GTK_DIALOG_H__
#define __GTK_WINDOW_H__
#define __GTK_APPLICATION_H__
#define __GTK_WIDGET_H__
#define __GTK_ACCEL_GROUP_H__
#define __GTK_ENUMS_H__

type GtkAlign as long
enum
	GTK_ALIGN_FILL
	GTK_ALIGN_START
	GTK_ALIGN_END
	GTK_ALIGN_CENTER
	GTK_ALIGN_BASELINE
end enum

type GtkArrowType as long
enum
	GTK_ARROW_UP
	GTK_ARROW_DOWN
	GTK_ARROW_LEFT
	GTK_ARROW_RIGHT
	GTK_ARROW_NONE
end enum

type GtkBaselinePosition as long
enum
	GTK_BASELINE_POSITION_TOP
	GTK_BASELINE_POSITION_CENTER
	GTK_BASELINE_POSITION_BOTTOM
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

type GtkPackType as long
enum
	GTK_PACK_START
	GTK_PACK_END
end enum

type GtkPositionType as long
enum
	GTK_POS_LEFT
	GTK_POS_RIGHT
	GTK_POS_TOP
	GTK_POS_BOTTOM
end enum

type GtkReliefStyle as long
enum
	GTK_RELIEF_NORMAL
	GTK_RELIEF_HALF
	GTK_RELIEF_NONE
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
	GTK_STATE_INCONSISTENT
	GTK_STATE_FOCUSED
end enum

type GtkToolbarStyle as long
enum
	GTK_TOOLBAR_ICONS
	GTK_TOOLBAR_TEXT
	GTK_TOOLBAR_BOTH
	GTK_TOOLBAR_BOTH_HORIZ
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
	GTK_UNIT_NONE
	GTK_UNIT_POINTS
	GTK_UNIT_INCH
	GTK_UNIT_MM
end enum

const GTK_UNIT_PIXEL = GTK_UNIT_NONE

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

type GtkSizeGroupMode as long
enum
	GTK_SIZE_GROUP_NONE
	GTK_SIZE_GROUP_HORIZONTAL
	GTK_SIZE_GROUP_VERTICAL
	GTK_SIZE_GROUP_BOTH
end enum

type GtkSizeRequestMode as long
enum
	GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH = 0
	GTK_SIZE_REQUEST_WIDTH_FOR_HEIGHT
	GTK_SIZE_REQUEST_CONSTANT_SIZE
end enum

type GtkScrollablePolicy as long
enum
	GTK_SCROLL_MINIMUM = 0
	GTK_SCROLL_NATURAL
end enum

type GtkStateFlags as long
enum
	GTK_STATE_FLAG_NORMAL = 0
	GTK_STATE_FLAG_ACTIVE = 1 shl 0
	GTK_STATE_FLAG_PRELIGHT = 1 shl 1
	GTK_STATE_FLAG_SELECTED = 1 shl 2
	GTK_STATE_FLAG_INSENSITIVE = 1 shl 3
	GTK_STATE_FLAG_INCONSISTENT = 1 shl 4
	GTK_STATE_FLAG_FOCUSED = 1 shl 5
	GTK_STATE_FLAG_BACKDROP = 1 shl 6
	GTK_STATE_FLAG_DIR_LTR = 1 shl 7
	GTK_STATE_FLAG_DIR_RTL = 1 shl 8
	GTK_STATE_FLAG_LINK = 1 shl 9
	GTK_STATE_FLAG_VISITED = 1 shl 10
	GTK_STATE_FLAG_CHECKED = 1 shl 11
end enum

type GtkRegionFlags as long
enum
	GTK_REGION_EVEN = 1 shl 0
	GTK_REGION_ODD = 1 shl 1
	GTK_REGION_FIRST = 1 shl 2
	GTK_REGION_LAST = 1 shl 3
	GTK_REGION_ONLY = 1 shl 4
	GTK_REGION_SORTED = 1 shl 5
end enum

type GtkJunctionSides as long
enum
	GTK_JUNCTION_NONE = 0
	GTK_JUNCTION_CORNER_TOPLEFT = 1 shl 0
	GTK_JUNCTION_CORNER_TOPRIGHT = 1 shl 1
	GTK_JUNCTION_CORNER_BOTTOMLEFT = 1 shl 2
	GTK_JUNCTION_CORNER_BOTTOMRIGHT = 1 shl 3
	GTK_JUNCTION_TOP = GTK_JUNCTION_CORNER_TOPLEFT or GTK_JUNCTION_CORNER_TOPRIGHT
	GTK_JUNCTION_BOTTOM = GTK_JUNCTION_CORNER_BOTTOMLEFT or GTK_JUNCTION_CORNER_BOTTOMRIGHT
	GTK_JUNCTION_LEFT = GTK_JUNCTION_CORNER_TOPLEFT or GTK_JUNCTION_CORNER_BOTTOMLEFT
	GTK_JUNCTION_RIGHT = GTK_JUNCTION_CORNER_TOPRIGHT or GTK_JUNCTION_CORNER_BOTTOMRIGHT
end enum

type GtkBorderStyle as long
enum
	GTK_BORDER_STYLE_NONE
	GTK_BORDER_STYLE_SOLID
	GTK_BORDER_STYLE_INSET
	GTK_BORDER_STYLE_OUTSET
	GTK_BORDER_STYLE_HIDDEN
	GTK_BORDER_STYLE_DOTTED
	GTK_BORDER_STYLE_DASHED
	GTK_BORDER_STYLE_DOUBLE
	GTK_BORDER_STYLE_GROOVE
	GTK_BORDER_STYLE_RIDGE
end enum

type GtkLevelBarMode as long
enum
	GTK_LEVEL_BAR_MODE_CONTINUOUS
	GTK_LEVEL_BAR_MODE_DISCRETE
end enum

type GtkInputPurpose as long
enum
	GTK_INPUT_PURPOSE_FREE_FORM
	GTK_INPUT_PURPOSE_ALPHA
	GTK_INPUT_PURPOSE_DIGITS
	GTK_INPUT_PURPOSE_NUMBER
	GTK_INPUT_PURPOSE_PHONE
	GTK_INPUT_PURPOSE_URL
	GTK_INPUT_PURPOSE_EMAIL
	GTK_INPUT_PURPOSE_NAME
	GTK_INPUT_PURPOSE_PASSWORD
	GTK_INPUT_PURPOSE_PIN
end enum

type GtkInputHints as long
enum
	GTK_INPUT_HINT_NONE = 0
	GTK_INPUT_HINT_SPELLCHECK = 1 shl 0
	GTK_INPUT_HINT_NO_SPELLCHECK = 1 shl 1
	GTK_INPUT_HINT_WORD_COMPLETION = 1 shl 2
	GTK_INPUT_HINT_LOWERCASE = 1 shl 3
	GTK_INPUT_HINT_UPPERCASE_CHARS = 1 shl 4
	GTK_INPUT_HINT_UPPERCASE_WORDS = 1 shl 5
	GTK_INPUT_HINT_UPPERCASE_SENTENCES = 1 shl 6
	GTK_INPUT_HINT_INHIBIT_OSK = 1 shl 7
end enum

type GtkPropagationPhase as long
enum
	GTK_PHASE_NONE
	GTK_PHASE_CAPTURE
	GTK_PHASE_BUBBLE
	GTK_PHASE_TARGET
end enum

type GtkEventSequenceState as long
enum
	GTK_EVENT_SEQUENCE_NONE
	GTK_EVENT_SEQUENCE_CLAIMED
	GTK_EVENT_SEQUENCE_DENIED
end enum

type GtkPanDirection as long
enum
	GTK_PAN_DIRECTION_LEFT
	GTK_PAN_DIRECTION_RIGHT
	GTK_PAN_DIRECTION_UP
	GTK_PAN_DIRECTION_DOWN
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
type GtkAccelGroupPrivate as _GtkAccelGroupPrivate
type GtkAccelKey as _GtkAccelKey
type GtkAccelGroupEntry as _GtkAccelGroupEntry
type GtkAccelGroupActivate as function(byval accel_group as GtkAccelGroup ptr, byval acceleratable as GObject ptr, byval keyval as guint, byval modifier as GdkModifierType) as gboolean
type GtkAccelGroupFindFunc as function(byval key as GtkAccelKey ptr, byval closure as GClosure ptr, byval data as gpointer) as gboolean

type _GtkAccelGroup
	parent as GObject
	priv as GtkAccelGroupPrivate ptr
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
declare sub gtk_accelerator_parse_with_keycode(byval accelerator as const gchar ptr, byval accelerator_key as guint ptr, byval accelerator_codes as guint ptr ptr, byval accelerator_mods as GdkModifierType ptr)
declare function gtk_accelerator_name(byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as gchar ptr
declare function gtk_accelerator_name_with_keycode(byval display as GdkDisplay ptr, byval accelerator_key as guint, byval keycode as guint, byval accelerator_mods as GdkModifierType) as gchar ptr
declare function gtk_accelerator_get_label(byval accelerator_key as guint, byval accelerator_mods as GdkModifierType) as gchar ptr
declare function gtk_accelerator_get_label_with_keycode(byval display as GdkDisplay ptr, byval accelerator_key as guint, byval keycode as guint, byval accelerator_mods as GdkModifierType) as gchar ptr
declare sub gtk_accelerator_set_default_mod_mask(byval default_mod_mask as GdkModifierType)
declare function gtk_accelerator_get_default_mod_mask() as GdkModifierType
declare function gtk_accel_group_query(byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval n_entries as guint ptr) as GtkAccelGroupEntry ptr

type _GtkAccelGroupEntry
	key as GtkAccelKey
	closure as GClosure ptr
	accel_path_quark as GQuark
end type

#define __GTK_BORDER_H__
type GtkBorder as _GtkBorder
#define GTK_TYPE_BORDER gtk_border_get_type()

type _GtkBorder
	left as gint16
	right as gint16
	top as gint16
	bottom as gint16
end type

declare function gtk_border_get_type() as GType
declare function gtk_border_new() as GtkBorder ptr
declare function gtk_border_copy(byval border_ as const GtkBorder ptr) as GtkBorder ptr
declare sub gtk_border_free(byval border_ as GtkBorder ptr)
#define __GTK_TYPES_H__

type GtkAdjustment as _GtkAdjustment
type GtkBuilder as _GtkBuilder
type GtkClipboard as _GtkClipboard
type GtkIconSet as _GtkIconSet
type GtkIconSource as _GtkIconSource
type GtkRcStyle as _GtkRcStyle
type GtkRequisition as _GtkRequisition
type GtkSelectionData as _GtkSelectionData
type GtkSettings as _GtkSettings
type GtkStyle as _GtkStyle
type GtkStyleContext as _GtkStyleContext
type GtkTooltip as _GtkTooltip
type GtkWidget as _GtkWidget
type GtkWidgetPath as _GtkWidgetPath
type GtkWindow as _GtkWindow
type GtkRcPropertyParser as function(byval pspec as const GParamSpec ptr, byval rc_string as const GString ptr, byval property_value as GValue ptr) as gboolean
type GtkBuilderConnectFunc as sub(byval builder as GtkBuilder ptr, byval object as GObject ptr, byval signal_name as const gchar ptr, byval handler_name as const gchar ptr, byval connect_object as GObject ptr, byval flags as GConnectFlags, byval user_data as gpointer)

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
#define GTK_TYPE_REQUISITION gtk_requisition_get_type()

type GtkWidgetPrivate as _GtkWidgetPrivate
type GtkWidgetClass as _GtkWidgetClass
type GtkWidgetClassPrivate as _GtkWidgetClassPrivate
type GtkWidgetAuxInfo as _GtkWidgetAuxInfo
type GtkAllocation as GdkRectangle
type GtkCallback as sub(byval widget as GtkWidget ptr, byval data as gpointer)
type GtkTickCallback as function(byval widget as GtkWidget ptr, byval frame_clock as GdkFrameClock ptr, byval user_data as gpointer) as gboolean

type _GtkRequisition
	width as gint
	height as gint
end type

type _GtkWidget
	parent_instance as GInitiallyUnowned
	priv as GtkWidgetPrivate ptr
end type

type _GtkWidgetClass
	parent_class as GInitiallyUnownedClass
	activate_signal as guint
	dispatch_child_properties_changed as sub(byval widget as GtkWidget ptr, byval n_pspecs as guint, byval pspecs as GParamSpec ptr ptr)
	destroy as sub(byval widget as GtkWidget ptr)
	show as sub(byval widget as GtkWidget ptr)
	show_all as sub(byval widget as GtkWidget ptr)
	hide as sub(byval widget as GtkWidget ptr)
	map as sub(byval widget as GtkWidget ptr)
	unmap as sub(byval widget as GtkWidget ptr)
	realize as sub(byval widget as GtkWidget ptr)
	unrealize as sub(byval widget as GtkWidget ptr)
	size_allocate as sub(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr)
	state_changed as sub(byval widget as GtkWidget ptr, byval previous_state as GtkStateType)
	state_flags_changed as sub(byval widget as GtkWidget ptr, byval previous_state_flags as GtkStateFlags)
	parent_set as sub(byval widget as GtkWidget ptr, byval previous_parent as GtkWidget ptr)
	hierarchy_changed as sub(byval widget as GtkWidget ptr, byval previous_toplevel as GtkWidget ptr)
	style_set as sub(byval widget as GtkWidget ptr, byval previous_style as GtkStyle ptr)
	direction_changed as sub(byval widget as GtkWidget ptr, byval previous_direction as GtkTextDirection)
	grab_notify as sub(byval widget as GtkWidget ptr, byval was_grabbed as gboolean)
	child_notify as sub(byval widget as GtkWidget ptr, byval child_property as GParamSpec ptr)
	draw as function(byval widget as GtkWidget ptr, byval cr as cairo_t ptr) as gboolean
	get_request_mode as function(byval widget as GtkWidget ptr) as GtkSizeRequestMode
	get_preferred_height as sub(byval widget as GtkWidget ptr, byval minimum_height as gint ptr, byval natural_height as gint ptr)
	get_preferred_width_for_height as sub(byval widget as GtkWidget ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
	get_preferred_width as sub(byval widget as GtkWidget ptr, byval minimum_width as gint ptr, byval natural_width as gint ptr)
	get_preferred_height_for_width as sub(byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
	mnemonic_activate as function(byval widget as GtkWidget ptr, byval group_cycling as gboolean) as gboolean
	grab_focus as sub(byval widget as GtkWidget ptr)
	focus as function(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
	move_focus as sub(byval widget as GtkWidget ptr, byval direction as GtkDirectionType)
	keynav_failed as function(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
	event as function(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gboolean
	button_press_event as function(byval widget as GtkWidget ptr, byval event as GdkEventButton ptr) as gboolean
	button_release_event as function(byval widget as GtkWidget ptr, byval event as GdkEventButton ptr) as gboolean
	scroll_event as function(byval widget as GtkWidget ptr, byval event as GdkEventScroll ptr) as gboolean
	motion_notify_event as function(byval widget as GtkWidget ptr, byval event as GdkEventMotion ptr) as gboolean
	delete_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
	destroy_event as function(byval widget as GtkWidget ptr, byval event as GdkEventAny ptr) as gboolean
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
	window_state_event as function(byval widget as GtkWidget ptr, byval event as GdkEventWindowState ptr) as gboolean
	damage_event as function(byval widget as GtkWidget ptr, byval event as GdkEventExpose ptr) as gboolean
	grab_broken_event as function(byval widget as GtkWidget ptr, byval event as GdkEventGrabBroken ptr) as gboolean
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
	drag_failed as function(byval widget as GtkWidget ptr, byval context as GdkDragContext ptr, byval result as GtkDragResult) as gboolean
	popup_menu as function(byval widget as GtkWidget ptr) as gboolean
	show_help as function(byval widget as GtkWidget ptr, byval help_type as GtkWidgetHelpType) as gboolean
	get_accessible as function(byval widget as GtkWidget ptr) as AtkObject ptr
	screen_changed as sub(byval widget as GtkWidget ptr, byval previous_screen as GdkScreen ptr)
	can_activate_accel as function(byval widget as GtkWidget ptr, byval signal_id as guint) as gboolean
	composited_changed as sub(byval widget as GtkWidget ptr)
	query_tooltip as function(byval widget as GtkWidget ptr, byval x as gint, byval y as gint, byval keyboard_tooltip as gboolean, byval tooltip as GtkTooltip ptr) as gboolean
	compute_expand as sub(byval widget as GtkWidget ptr, byval hexpand_p as gboolean ptr, byval vexpand_p as gboolean ptr)
	adjust_size_request as sub(byval widget as GtkWidget ptr, byval orientation as GtkOrientation, byval minimum_size as gint ptr, byval natural_size as gint ptr)
	adjust_size_allocation as sub(byval widget as GtkWidget ptr, byval orientation as GtkOrientation, byval minimum_size as gint ptr, byval natural_size as gint ptr, byval allocated_pos as gint ptr, byval allocated_size as gint ptr)
	style_updated as sub(byval widget as GtkWidget ptr)
	touch_event as function(byval widget as GtkWidget ptr, byval event as GdkEventTouch ptr) as gboolean
	get_preferred_height_and_baseline_for_width as sub(byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr, byval minimum_baseline as gint ptr, byval natural_baseline as gint ptr)
	adjust_baseline_request as sub(byval widget as GtkWidget ptr, byval minimum_baseline as gint ptr, byval natural_baseline as gint ptr)
	adjust_baseline_allocation as sub(byval widget as GtkWidget ptr, byval baseline as gint ptr)
	queue_draw_region as sub(byval widget as GtkWidget ptr, byval region as const cairo_region_t ptr)
	priv as GtkWidgetClassPrivate ptr
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
end type

type _GtkWidgetAuxInfo
	width as gint
	height as gint
	halign : 4 as guint
	valign : 4 as guint
	margin as GtkBorder
end type

declare function gtk_widget_get_type() as GType
declare function gtk_widget_new(byval type as GType, byval first_property_name as const gchar ptr, ...) as GtkWidget ptr
declare sub gtk_widget_destroy(byval widget as GtkWidget ptr)
declare sub gtk_widget_destroyed(byval widget as GtkWidget ptr, byval widget_pointer as GtkWidget ptr ptr)
declare sub gtk_widget_unparent(byval widget as GtkWidget ptr)
declare sub gtk_widget_show(byval widget as GtkWidget ptr)
declare sub gtk_widget_hide(byval widget as GtkWidget ptr)
declare sub gtk_widget_show_now(byval widget as GtkWidget ptr)
declare sub gtk_widget_show_all(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_no_show_all(byval widget as GtkWidget ptr, byval no_show_all as gboolean)
declare function gtk_widget_get_no_show_all(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_map(byval widget as GtkWidget ptr)
declare sub gtk_widget_unmap(byval widget as GtkWidget ptr)
declare sub gtk_widget_realize(byval widget as GtkWidget ptr)
declare sub gtk_widget_unrealize(byval widget as GtkWidget ptr)
declare sub gtk_widget_draw(byval widget as GtkWidget ptr, byval cr as cairo_t ptr)
declare sub gtk_widget_queue_draw(byval widget as GtkWidget ptr)
declare sub gtk_widget_queue_draw_area(byval widget as GtkWidget ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_widget_queue_draw_region(byval widget as GtkWidget ptr, byval region as const cairo_region_t ptr)
declare sub gtk_widget_queue_resize(byval widget as GtkWidget ptr)
declare sub gtk_widget_queue_resize_no_redraw(byval widget as GtkWidget ptr)
declare function gtk_widget_get_frame_clock(byval widget as GtkWidget ptr) as GdkFrameClock ptr
declare sub gtk_widget_size_request(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub gtk_widget_size_allocate(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr)
declare sub gtk_widget_size_allocate_with_baseline(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr, byval baseline as gint)
declare function gtk_widget_get_request_mode(byval widget as GtkWidget ptr) as GtkSizeRequestMode
declare sub gtk_widget_get_preferred_width(byval widget as GtkWidget ptr, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare sub gtk_widget_get_preferred_height_for_width(byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_widget_get_preferred_height(byval widget as GtkWidget ptr, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_widget_get_preferred_width_for_height(byval widget as GtkWidget ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare sub gtk_widget_get_preferred_height_and_baseline_for_width(byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr, byval minimum_baseline as gint ptr, byval natural_baseline as gint ptr)
declare sub gtk_widget_get_preferred_size(byval widget as GtkWidget ptr, byval minimum_size as GtkRequisition ptr, byval natural_size as GtkRequisition ptr)
declare sub gtk_widget_get_child_requisition(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare sub gtk_widget_add_accelerator(byval widget as GtkWidget ptr, byval accel_signal as const gchar ptr, byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType, byval accel_flags as GtkAccelFlags)
declare function gtk_widget_remove_accelerator(byval widget as GtkWidget ptr, byval accel_group as GtkAccelGroup ptr, byval accel_key as guint, byval accel_mods as GdkModifierType) as gboolean
declare sub gtk_widget_set_accel_path(byval widget as GtkWidget ptr, byval accel_path as const gchar ptr, byval accel_group as GtkAccelGroup ptr)
declare function gtk_widget_list_accel_closures(byval widget as GtkWidget ptr) as GList ptr
declare function gtk_widget_can_activate_accel(byval widget as GtkWidget ptr, byval signal_id as guint) as gboolean
declare function gtk_widget_mnemonic_activate(byval widget as GtkWidget ptr, byval group_cycling as gboolean) as gboolean
declare function gtk_widget_event(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gboolean
declare function gtk_widget_send_expose(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gint
declare function gtk_widget_send_focus_change(byval widget as GtkWidget ptr, byval event as GdkEvent ptr) as gboolean
declare function gtk_widget_activate(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_reparent(byval widget as GtkWidget ptr, byval new_parent as GtkWidget ptr)
declare function gtk_widget_intersect(byval widget as GtkWidget ptr, byval area as const GdkRectangle ptr, byval intersection as GdkRectangle ptr) as gboolean
declare function gtk_widget_region_intersect(byval widget as GtkWidget ptr, byval region as const cairo_region_t ptr) as cairo_region_t ptr
declare sub gtk_widget_freeze_child_notify(byval widget as GtkWidget ptr)
declare sub gtk_widget_child_notify(byval widget as GtkWidget ptr, byval child_property as const gchar ptr)
declare sub gtk_widget_thaw_child_notify(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_can_focus(byval widget as GtkWidget ptr, byval can_focus as gboolean)
declare function gtk_widget_get_can_focus(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_focus(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_focus(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_visible_focus(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_grab_focus(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_can_default(byval widget as GtkWidget ptr, byval can_default as gboolean)
declare function gtk_widget_get_can_default(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_default(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_grab_default(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_receives_default(byval widget as GtkWidget ptr, byval receives_default as gboolean)
declare function gtk_widget_get_receives_default(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_has_grab(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_device_is_shadowed(byval widget as GtkWidget ptr, byval device as GdkDevice ptr) as gboolean
declare sub gtk_widget_set_name(byval widget as GtkWidget ptr, byval name as const gchar ptr)
declare function gtk_widget_get_name(byval widget as GtkWidget ptr) as const gchar ptr
declare sub gtk_widget_set_state(byval widget as GtkWidget ptr, byval state as GtkStateType)
declare function gtk_widget_get_state(byval widget as GtkWidget ptr) as GtkStateType
declare sub gtk_widget_set_state_flags(byval widget as GtkWidget ptr, byval flags as GtkStateFlags, byval clear as gboolean)
declare sub gtk_widget_unset_state_flags(byval widget as GtkWidget ptr, byval flags as GtkStateFlags)
declare function gtk_widget_get_state_flags(byval widget as GtkWidget ptr) as GtkStateFlags
declare sub gtk_widget_set_sensitive(byval widget as GtkWidget ptr, byval sensitive as gboolean)
declare function gtk_widget_get_sensitive(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_sensitive(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_visible(byval widget as GtkWidget ptr, byval visible as gboolean)
declare function gtk_widget_get_visible(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_is_visible(byval widget as GtkWidget ptr) as gboolean
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
declare sub gtk_widget_register_window(byval widget as GtkWidget ptr, byval window as GdkWindow ptr)
declare sub gtk_widget_unregister_window(byval widget as GtkWidget ptr, byval window as GdkWindow ptr)
declare function gtk_widget_get_allocated_width(byval widget as GtkWidget ptr) as long
declare function gtk_widget_get_allocated_height(byval widget as GtkWidget ptr) as long
declare function gtk_widget_get_allocated_baseline(byval widget as GtkWidget ptr) as long
declare sub gtk_widget_get_allocation(byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr)
declare sub gtk_widget_set_allocation(byval widget as GtkWidget ptr, byval allocation as const GtkAllocation ptr)
declare sub gtk_widget_set_clip(byval widget as GtkWidget ptr, byval clip as const GtkAllocation ptr)
declare sub gtk_widget_get_clip(byval widget as GtkWidget ptr, byval clip as GtkAllocation ptr)
declare sub gtk_widget_get_requisition(byval widget as GtkWidget ptr, byval requisition as GtkRequisition ptr)
declare function gtk_widget_child_focus(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
declare function gtk_widget_keynav_failed(byval widget as GtkWidget ptr, byval direction as GtkDirectionType) as gboolean
declare sub gtk_widget_error_bell(byval widget as GtkWidget ptr)
declare sub gtk_widget_set_size_request(byval widget as GtkWidget ptr, byval width as gint, byval height as gint)
declare sub gtk_widget_get_size_request(byval widget as GtkWidget ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_widget_set_events(byval widget as GtkWidget ptr, byval events as gint)
declare sub gtk_widget_add_events(byval widget as GtkWidget ptr, byval events as gint)
declare sub gtk_widget_set_device_events(byval widget as GtkWidget ptr, byval device as GdkDevice ptr, byval events as GdkEventMask)
declare sub gtk_widget_add_device_events(byval widget as GtkWidget ptr, byval device as GdkDevice ptr, byval events as GdkEventMask)
declare sub gtk_widget_set_opacity(byval widget as GtkWidget ptr, byval opacity as double)
declare function gtk_widget_get_opacity(byval widget as GtkWidget ptr) as double
declare sub gtk_widget_set_device_enabled(byval widget as GtkWidget ptr, byval device as GdkDevice ptr, byval enabled as gboolean)
declare function gtk_widget_get_device_enabled(byval widget as GtkWidget ptr, byval device as GdkDevice ptr) as gboolean
declare function gtk_widget_get_toplevel(byval widget as GtkWidget ptr) as GtkWidget ptr
declare function gtk_widget_get_ancestor(byval widget as GtkWidget ptr, byval widget_type as GType) as GtkWidget ptr
declare function gtk_widget_get_visual(byval widget as GtkWidget ptr) as GdkVisual ptr
declare sub gtk_widget_set_visual(byval widget as GtkWidget ptr, byval visual as GdkVisual ptr)
declare function gtk_widget_get_screen(byval widget as GtkWidget ptr) as GdkScreen ptr
declare function gtk_widget_has_screen(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_get_scale_factor(byval widget as GtkWidget ptr) as gint
declare function gtk_widget_get_display(byval widget as GtkWidget ptr) as GdkDisplay ptr
declare function gtk_widget_get_root_window(byval widget as GtkWidget ptr) as GdkWindow ptr
declare function gtk_widget_get_settings(byval widget as GtkWidget ptr) as GtkSettings ptr
declare function gtk_widget_get_clipboard(byval widget as GtkWidget ptr, byval selection as GdkAtom) as GtkClipboard ptr
declare function gtk_widget_get_hexpand(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_hexpand(byval widget as GtkWidget ptr, byval expand as gboolean)
declare function gtk_widget_get_hexpand_set(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_hexpand_set(byval widget as GtkWidget ptr, byval set as gboolean)
declare function gtk_widget_get_vexpand(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_vexpand(byval widget as GtkWidget ptr, byval expand as gboolean)
declare function gtk_widget_get_vexpand_set(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_vexpand_set(byval widget as GtkWidget ptr, byval set as gboolean)
declare sub gtk_widget_queue_compute_expand(byval widget as GtkWidget ptr)
declare function gtk_widget_compute_expand(byval widget as GtkWidget ptr, byval orientation as GtkOrientation) as gboolean
declare function gtk_widget_get_support_multidevice(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_set_support_multidevice(byval widget as GtkWidget ptr, byval support_multidevice as gboolean)
declare sub gtk_widget_class_set_accessible_type(byval widget_class as GtkWidgetClass ptr, byval type as GType)
declare sub gtk_widget_class_set_accessible_role(byval widget_class as GtkWidgetClass ptr, byval role as AtkRole)
declare function gtk_widget_get_accessible(byval widget as GtkWidget ptr) as AtkObject ptr
declare function gtk_widget_get_halign(byval widget as GtkWidget ptr) as GtkAlign
declare sub gtk_widget_set_halign(byval widget as GtkWidget ptr, byval align as GtkAlign)
declare function gtk_widget_get_valign(byval widget as GtkWidget ptr) as GtkAlign
declare function gtk_widget_get_valign_with_baseline(byval widget as GtkWidget ptr) as GtkAlign
declare sub gtk_widget_set_valign(byval widget as GtkWidget ptr, byval align as GtkAlign)
declare function gtk_widget_get_margin_left(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_set_margin_left(byval widget as GtkWidget ptr, byval margin as gint)
declare function gtk_widget_get_margin_right(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_set_margin_right(byval widget as GtkWidget ptr, byval margin as gint)
declare function gtk_widget_get_margin_start(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_set_margin_start(byval widget as GtkWidget ptr, byval margin as gint)
declare function gtk_widget_get_margin_end(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_set_margin_end(byval widget as GtkWidget ptr, byval margin as gint)
declare function gtk_widget_get_margin_top(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_set_margin_top(byval widget as GtkWidget ptr, byval margin as gint)
declare function gtk_widget_get_margin_bottom(byval widget as GtkWidget ptr) as gint
declare sub gtk_widget_set_margin_bottom(byval widget as GtkWidget ptr, byval margin as gint)
declare function gtk_widget_get_events(byval widget as GtkWidget ptr) as gint
declare function gtk_widget_get_device_events(byval widget as GtkWidget ptr, byval device as GdkDevice ptr) as GdkEventMask
declare sub gtk_widget_get_pointer(byval widget as GtkWidget ptr, byval x as gint ptr, byval y as gint ptr)
declare function gtk_widget_is_ancestor(byval widget as GtkWidget ptr, byval ancestor as GtkWidget ptr) as gboolean
declare function gtk_widget_translate_coordinates(byval src_widget as GtkWidget ptr, byval dest_widget as GtkWidget ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint ptr, byval dest_y as gint ptr) as gboolean
declare function gtk_widget_hide_on_delete(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_override_color(byval widget as GtkWidget ptr, byval state as GtkStateFlags, byval color as const GdkRGBA ptr)
declare sub gtk_widget_override_background_color(byval widget as GtkWidget ptr, byval state as GtkStateFlags, byval color as const GdkRGBA ptr)
declare sub gtk_widget_override_font(byval widget as GtkWidget ptr, byval font_desc as const PangoFontDescription ptr)
declare sub gtk_widget_override_symbolic_color(byval widget as GtkWidget ptr, byval name as const gchar ptr, byval color as const GdkRGBA ptr)
declare sub gtk_widget_override_cursor(byval widget as GtkWidget ptr, byval cursor as const GdkRGBA ptr, byval secondary_cursor as const GdkRGBA ptr)
declare sub gtk_widget_reset_style(byval widget as GtkWidget ptr)
declare function gtk_widget_create_pango_context(byval widget as GtkWidget ptr) as PangoContext ptr
declare function gtk_widget_get_pango_context(byval widget as GtkWidget ptr) as PangoContext ptr
declare function gtk_widget_create_pango_layout(byval widget as GtkWidget ptr, byval text as const gchar ptr) as PangoLayout ptr
declare function gtk_widget_render_icon_pixbuf(byval widget as GtkWidget ptr, byval stock_id as const gchar ptr, byval size as GtkIconSize) as GdkPixbuf ptr
declare sub gtk_widget_set_composite_name(byval widget as GtkWidget ptr, byval name as const gchar ptr)
declare function gtk_widget_get_composite_name(byval widget as GtkWidget ptr) as gchar ptr
declare sub gtk_widget_push_composite_child()
declare sub gtk_widget_pop_composite_child()
declare sub gtk_widget_class_install_style_property(byval klass as GtkWidgetClass ptr, byval pspec as GParamSpec ptr)
declare sub gtk_widget_class_install_style_property_parser(byval klass as GtkWidgetClass ptr, byval pspec as GParamSpec ptr, byval parser as GtkRcPropertyParser)
declare function gtk_widget_class_find_style_property(byval klass as GtkWidgetClass ptr, byval property_name as const gchar ptr) as GParamSpec ptr
declare function gtk_widget_class_list_style_properties(byval klass as GtkWidgetClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub gtk_widget_style_get_property(byval widget as GtkWidget ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub gtk_widget_style_get_valist(byval widget as GtkWidget ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_widget_style_get(byval widget as GtkWidget ptr, byval first_property_name as const gchar ptr, ...)
declare sub gtk_widget_set_direction(byval widget as GtkWidget ptr, byval dir as GtkTextDirection)
declare function gtk_widget_get_direction(byval widget as GtkWidget ptr) as GtkTextDirection
declare sub gtk_widget_set_default_direction(byval dir as GtkTextDirection)
declare function gtk_widget_get_default_direction() as GtkTextDirection
declare function gtk_widget_is_composited(byval widget as GtkWidget ptr) as gboolean
declare sub gtk_widget_shape_combine_region(byval widget as GtkWidget ptr, byval region as cairo_region_t ptr)
declare sub gtk_widget_input_shape_combine_region(byval widget as GtkWidget ptr, byval region as cairo_region_t ptr)
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
declare function gtk_cairo_should_draw_window(byval cr as cairo_t ptr, byval window as GdkWindow ptr) as gboolean
declare sub gtk_cairo_transform_to_window(byval cr as cairo_t ptr, byval widget as GtkWidget ptr, byval window as GdkWindow ptr)
declare function gtk_requisition_get_type() as GType
declare function gtk_requisition_new() as GtkRequisition ptr
declare function gtk_requisition_copy(byval requisition as const GtkRequisition ptr) as GtkRequisition ptr
declare sub gtk_requisition_free(byval requisition as GtkRequisition ptr)
declare function gtk_widget_in_destruction(byval widget as GtkWidget ptr) as gboolean
declare function gtk_widget_get_style_context(byval widget as GtkWidget ptr) as GtkStyleContext ptr
declare function gtk_widget_get_path(byval widget as GtkWidget ptr) as GtkWidgetPath ptr
declare function gtk_widget_get_modifier_mask(byval widget as GtkWidget ptr, byval intent as GdkModifierIntent) as GdkModifierType
declare sub gtk_widget_insert_action_group(byval widget as GtkWidget ptr, byval name as const gchar ptr, byval group as GActionGroup ptr)
declare function gtk_widget_add_tick_callback(byval widget as GtkWidget ptr, byval callback as GtkTickCallback, byval user_data as gpointer, byval notify as GDestroyNotify) as guint
declare sub gtk_widget_remove_tick_callback(byval widget as GtkWidget ptr, byval id as guint)

#define gtk_widget_class_bind_template_callback(widget_class, callback) gtk_widget_class_bind_template_callback_full(GTK_WIDGET_CLASS(widget_class), #callback, G_CALLBACK(callback))
#define gtk_widget_class_bind_template_child(widget_class, TypeName, member_name) gtk_widget_class_bind_template_child_full(widget_class, #member_name, FALSE, G_STRUCT_OFFSET(TypeName, member_name))
#define gtk_widget_class_bind_template_child_internal(widget_class, TypeName, member_name) gtk_widget_class_bind_template_child_full(widget_class, #member_name, CTRUE, G_STRUCT_OFFSET(TypeName, member_name))
#define gtk_widget_class_bind_template_child_private(widget_class, TypeName, member_name) gtk_widget_class_bind_template_child_full(widget_class, #member_name, FALSE, G_PRIVATE_OFFSET(TypeName, member_name))
#define gtk_widget_class_bind_template_child_internal_private(widget_class, TypeName, member_name) gtk_widget_class_bind_template_child_full(widget_class, #member_name, CTRUE, G_PRIVATE_OFFSET(TypeName, member_name))

declare sub gtk_widget_init_template(byval widget as GtkWidget ptr)
declare function gtk_widget_get_template_child(byval widget as GtkWidget ptr, byval widget_type as GType, byval name as const gchar ptr) as GObject ptr
declare sub gtk_widget_class_set_template(byval widget_class as GtkWidgetClass ptr, byval template_bytes as GBytes ptr)
declare sub gtk_widget_class_set_template_from_resource(byval widget_class as GtkWidgetClass ptr, byval resource_name as const gchar ptr)
declare sub gtk_widget_class_bind_template_callback_full(byval widget_class as GtkWidgetClass ptr, byval callback_name as const gchar ptr, byval callback_symbol as GCallback)
declare sub gtk_widget_class_set_connect_func(byval widget_class as GtkWidgetClass ptr, byval connect_func as GtkBuilderConnectFunc, byval connect_data as gpointer, byval connect_data_destroy as GDestroyNotify)
declare sub gtk_widget_class_bind_template_child_full(byval widget_class as GtkWidgetClass ptr, byval name as const gchar ptr, byval internal_child as gboolean, byval struct_offset as gssize)
declare function gtk_widget_get_action_group(byval widget as GtkWidget ptr, byval prefix as const gchar ptr) as GActionGroup ptr
declare function gtk_widget_list_action_prefixes(byval widget as GtkWidget ptr) as const gchar ptr ptr

#define GTK_TYPE_APPLICATION gtk_application_get_type()
#define GTK_APPLICATION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_APPLICATION, GtkApplication)
#define GTK_APPLICATION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_APPLICATION, GtkApplicationClass)
#define GTK_IS_APPLICATION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_APPLICATION)
#define GTK_IS_APPLICATION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_APPLICATION)
#define GTK_APPLICATION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_APPLICATION, GtkApplicationClass)

type GtkApplication as _GtkApplication
type GtkApplicationClass as _GtkApplicationClass
type GtkApplicationPrivate as _GtkApplicationPrivate

type _GtkApplication
	parent as GApplication
	priv as GtkApplicationPrivate ptr
end type

type _GtkApplicationClass
	parent_class as GApplicationClass
	window_added as sub(byval application as GtkApplication ptr, byval window as GtkWindow ptr)
	window_removed as sub(byval application as GtkApplication ptr, byval window as GtkWindow ptr)
	padding(0 to 11) as gpointer
end type

declare function gtk_application_get_type() as GType
declare function gtk_application_new(byval application_id as const gchar ptr, byval flags as GApplicationFlags) as GtkApplication ptr
declare sub gtk_application_add_window(byval application as GtkApplication ptr, byval window as GtkWindow ptr)
declare sub gtk_application_remove_window(byval application as GtkApplication ptr, byval window as GtkWindow ptr)
declare function gtk_application_get_windows(byval application as GtkApplication ptr) as GList ptr
declare function gtk_application_get_app_menu(byval application as GtkApplication ptr) as GMenuModel ptr
declare sub gtk_application_set_app_menu(byval application as GtkApplication ptr, byval app_menu as GMenuModel ptr)
declare function gtk_application_get_menubar(byval application as GtkApplication ptr) as GMenuModel ptr
declare sub gtk_application_set_menubar(byval application as GtkApplication ptr, byval menubar as GMenuModel ptr)
declare sub gtk_application_add_accelerator(byval application as GtkApplication ptr, byval accelerator as const gchar ptr, byval action_name as const gchar ptr, byval parameter as GVariant ptr)
declare sub gtk_application_remove_accelerator(byval application as GtkApplication ptr, byval action_name as const gchar ptr, byval parameter as GVariant ptr)

type GtkApplicationInhibitFlags as long
enum
	GTK_APPLICATION_INHIBIT_LOGOUT = 1 shl 0
	GTK_APPLICATION_INHIBIT_SWITCH = 1 shl 1
	GTK_APPLICATION_INHIBIT_SUSPEND = 1 shl 2
	GTK_APPLICATION_INHIBIT_IDLE = 1 shl 3
end enum

declare function gtk_application_inhibit(byval application as GtkApplication ptr, byval window as GtkWindow ptr, byval flags as GtkApplicationInhibitFlags, byval reason as const gchar ptr) as guint
declare sub gtk_application_uninhibit(byval application as GtkApplication ptr, byval cookie as guint)
declare function gtk_application_is_inhibited(byval application as GtkApplication ptr, byval flags as GtkApplicationInhibitFlags) as gboolean
declare function gtk_application_get_window_by_id(byval application as GtkApplication ptr, byval id as guint) as GtkWindow ptr
declare function gtk_application_get_active_window(byval application as GtkApplication ptr) as GtkWindow ptr
declare function gtk_application_list_action_descriptions(byval application as GtkApplication ptr) as gchar ptr ptr
declare function gtk_application_get_accels_for_action(byval application as GtkApplication ptr, byval detailed_action_name as const gchar ptr) as gchar ptr ptr
declare function gtk_application_get_actions_for_accel(byval application as GtkApplication ptr, byval accel as const gchar ptr) as gchar ptr ptr
declare sub gtk_application_set_accels_for_action(byval application as GtkApplication ptr, byval detailed_action_name as const gchar ptr, byval accels as const gchar const ptr ptr)
declare function gtk_application_prefers_app_menu(byval application as GtkApplication ptr) as gboolean
declare function gtk_application_get_menu_by_id(byval application as GtkApplication ptr, byval id as const gchar ptr) as GMenu ptr

#define __GTK_BIN_H__
#define __GTK_CONTAINER_H__
#define GTK_TYPE_CONTAINER gtk_container_get_type()
#define GTK_CONTAINER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CONTAINER, GtkContainer)
#define GTK_CONTAINER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CONTAINER, GtkContainerClass)
#define GTK_IS_CONTAINER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CONTAINER)
#define GTK_IS_CONTAINER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CONTAINER)
#define GTK_CONTAINER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CONTAINER, GtkContainerClass)

type GtkContainer as _GtkContainer
type GtkContainerPrivate as _GtkContainerPrivate
type GtkContainerClass as _GtkContainerClass

type _GtkContainer
	widget as GtkWidget
	priv as GtkContainerPrivate ptr
end type

type _GtkContainerClass
	parent_class as GtkWidgetClass
	add as sub(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
	remove as sub(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
	check_resize as sub(byval container as GtkContainer ptr)
	forall as sub(byval container as GtkContainer ptr, byval include_internals as gboolean, byval callback as GtkCallback, byval callback_data as gpointer)
	set_focus_child as sub(byval container as GtkContainer ptr, byval child as GtkWidget ptr)
	child_type as function(byval container as GtkContainer ptr) as GType
	composite_name as function(byval container as GtkContainer ptr, byval child as GtkWidget ptr) as gchar ptr
	set_child_property as sub(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_id as guint, byval value as const GValue ptr, byval pspec as GParamSpec ptr)
	get_child_property as sub(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval property_id as guint, byval value as GValue ptr, byval pspec as GParamSpec ptr)
	get_path_for_child as function(byval container as GtkContainer ptr, byval child as GtkWidget ptr) as GtkWidgetPath ptr
	_handle_border_width : 1 as ulong
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

type GtkResizeMode as long
enum
	GTK_RESIZE_PARENT
	GTK_RESIZE_QUEUE
	GTK_RESIZE_IMMEDIATE
end enum

declare function gtk_container_get_type() as GType
declare sub gtk_container_set_border_width(byval container as GtkContainer ptr, byval border_width as guint)
declare function gtk_container_get_border_width(byval container as GtkContainer ptr) as guint
declare sub gtk_container_add(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
declare sub gtk_container_remove(byval container as GtkContainer ptr, byval widget as GtkWidget ptr)
declare sub gtk_container_set_resize_mode(byval container as GtkContainer ptr, byval resize_mode as GtkResizeMode)
declare function gtk_container_get_resize_mode(byval container as GtkContainer ptr) as GtkResizeMode
declare sub gtk_container_check_resize(byval container as GtkContainer ptr)
declare sub gtk_container_foreach(byval container as GtkContainer ptr, byval callback as GtkCallback, byval callback_data as gpointer)
declare function gtk_container_get_children(byval container as GtkContainer ptr) as GList ptr
declare sub gtk_container_propagate_draw(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval cr as cairo_t ptr)
declare sub gtk_container_set_focus_chain(byval container as GtkContainer ptr, byval focusable_widgets as GList ptr)
declare function gtk_container_get_focus_chain(byval container as GtkContainer ptr, byval focusable_widgets as GList ptr ptr) as gboolean
declare sub gtk_container_unset_focus_chain(byval container as GtkContainer ptr)
#define GTK_IS_RESIZE_CONTAINER(widget) (GTK_IS_CONTAINER(widget) andalso (gtk_container_get_resize_mode(GTK_CONTAINER(widget)) <> GTK_RESIZE_PARENT))
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
declare sub gtk_container_child_notify(byval container as GtkContainer ptr, byval child as GtkWidget ptr, byval child_property as const gchar ptr)
#define GTK_CONTAINER_WARN_INVALID_CHILD_PROPERTY_ID(object, property_id, pspec) G_OBJECT_WARN_INVALID_PSPEC((object), "child property", (property_id), (pspec))
declare sub gtk_container_forall(byval container as GtkContainer ptr, byval callback as GtkCallback, byval callback_data as gpointer)
declare sub gtk_container_class_handle_border_width(byval klass as GtkContainerClass ptr)
declare function gtk_container_get_path_for_child(byval container as GtkContainer ptr, byval child as GtkWidget ptr) as GtkWidgetPath ptr

#define GTK_TYPE_BIN gtk_bin_get_type()
#define GTK_BIN(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BIN, GtkBin)
#define GTK_BIN_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BIN, GtkBinClass)
#define GTK_IS_BIN(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BIN)
#define GTK_IS_BIN_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BIN)
#define GTK_BIN_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BIN, GtkBinClass)

type GtkBin as _GtkBin
type GtkBinPrivate as _GtkBinPrivate
type GtkBinClass as _GtkBinClass

type _GtkBin
	container as GtkContainer
	priv as GtkBinPrivate ptr
end type

type _GtkBinClass
	parent_class as GtkContainerClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_bin_get_type() as GType
declare function gtk_bin_get_child(byval bin as GtkBin ptr) as GtkWidget ptr
declare sub _gtk_bin_set_child(byval bin as GtkBin ptr, byval widget as GtkWidget ptr)

#define GTK_TYPE_WINDOW gtk_window_get_type()
#define GTK_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_WINDOW, GtkWindow)
#define GTK_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_WINDOW, GtkWindowClass)
#define GTK_IS_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_WINDOW)
#define GTK_IS_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_WINDOW)
#define GTK_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_WINDOW, GtkWindowClass)

type GtkWindowPrivate as _GtkWindowPrivate
type GtkWindowClass as _GtkWindowClass
type GtkWindowGeometryInfo as _GtkWindowGeometryInfo
type GtkWindowGroup as _GtkWindowGroup
type GtkWindowGroupClass as _GtkWindowGroupClass
type GtkWindowGroupPrivate as _GtkWindowGroupPrivate

type _GtkWindow
	bin as GtkBin
	priv as GtkWindowPrivate ptr
end type

type _GtkWindowClass
	parent_class as GtkBinClass
	set_focus as sub(byval window as GtkWindow ptr, byval focus as GtkWidget ptr)
	activate_focus as sub(byval window as GtkWindow ptr)
	activate_default as sub(byval window as GtkWindow ptr)
	keys_changed as sub(byval window as GtkWindow ptr)
	enable_debugging as function(byval window as GtkWindow ptr, byval toggle as gboolean) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

type GtkWindowType as long
enum
	GTK_WINDOW_TOPLEVEL
	GTK_WINDOW_POPUP
end enum

type GtkWindowPosition as long
enum
	GTK_WIN_POS_NONE
	GTK_WIN_POS_CENTER
	GTK_WIN_POS_MOUSE
	GTK_WIN_POS_CENTER_ALWAYS
	GTK_WIN_POS_CENTER_ON_PARENT
end enum

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
declare sub gtk_window_set_attached_to(byval window as GtkWindow ptr, byval attach_widget as GtkWidget ptr)
declare function gtk_window_get_attached_to(byval window as GtkWindow ptr) as GtkWidget ptr
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
declare sub gtk_window_set_hide_titlebar_when_maximized(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_hide_titlebar_when_maximized(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_mnemonics_visible(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_mnemonics_visible(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_focus_visible(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_focus_visible(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_resizable(byval window as GtkWindow ptr, byval resizable as gboolean)
declare function gtk_window_get_resizable(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_gravity(byval window as GtkWindow ptr, byval gravity as GdkGravity)
declare function gtk_window_get_gravity(byval window as GtkWindow ptr) as GdkGravity
declare sub gtk_window_set_geometry_hints(byval window as GtkWindow ptr, byval geometry_widget as GtkWidget ptr, byval geometry as GdkGeometry ptr, byval geom_mask as GdkWindowHints)
declare sub gtk_window_set_screen(byval window as GtkWindow ptr, byval screen as GdkScreen ptr)
declare function gtk_window_get_screen(byval window as GtkWindow ptr) as GdkScreen ptr
declare function gtk_window_is_active(byval window as GtkWindow ptr) as gboolean
declare function gtk_window_has_toplevel_focus(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_decorated(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_decorated(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_deletable(byval window as GtkWindow ptr, byval setting as gboolean)
declare function gtk_window_get_deletable(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_icon_list(byval window as GtkWindow ptr, byval list as GList ptr)
declare function gtk_window_get_icon_list(byval window as GtkWindow ptr) as GList ptr
declare sub gtk_window_set_icon(byval window as GtkWindow ptr, byval icon as GdkPixbuf ptr)
declare sub gtk_window_set_icon_name(byval window as GtkWindow ptr, byval name as const gchar ptr)
declare function gtk_window_set_icon_from_file(byval window as GtkWindow ptr, byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
declare function gtk_window_get_icon(byval window as GtkWindow ptr) as GdkPixbuf ptr
declare function gtk_window_get_icon_name(byval window as GtkWindow ptr) as const gchar ptr
declare sub gtk_window_set_default_icon_list(byval list as GList ptr)
declare function gtk_window_get_default_icon_list() as GList ptr
declare sub gtk_window_set_default_icon(byval icon as GdkPixbuf ptr)
declare sub gtk_window_set_default_icon_name(byval name as const gchar ptr)
declare function gtk_window_get_default_icon_name() as const gchar ptr
declare function gtk_window_set_default_icon_from_file(byval filename as const gchar ptr, byval err as GError ptr ptr) as gboolean
declare sub gtk_window_set_auto_startup_notification(byval setting as gboolean)
declare sub gtk_window_set_modal(byval window as GtkWindow ptr, byval modal as gboolean)
declare function gtk_window_get_modal(byval window as GtkWindow ptr) as gboolean
declare function gtk_window_list_toplevels() as GList ptr
declare sub gtk_window_set_has_user_ref_count(byval window as GtkWindow ptr, byval setting as gboolean)
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
declare sub gtk_window_close(byval window as GtkWindow ptr)
declare sub gtk_window_set_keep_above(byval window as GtkWindow ptr, byval setting as gboolean)
declare sub gtk_window_set_keep_below(byval window as GtkWindow ptr, byval setting as gboolean)
declare sub gtk_window_begin_resize_drag(byval window as GtkWindow ptr, byval edge as GdkWindowEdge, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gtk_window_begin_move_drag(byval window as GtkWindow ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gtk_window_set_default_size(byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_get_default_size(byval window as GtkWindow ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_window_resize(byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_get_size(byval window as GtkWindow ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_window_move(byval window as GtkWindow ptr, byval x as gint, byval y as gint)
declare sub gtk_window_get_position(byval window as GtkWindow ptr, byval root_x as gint ptr, byval root_y as gint ptr)
declare function gtk_window_parse_geometry(byval window as GtkWindow ptr, byval geometry as const gchar ptr) as gboolean
declare sub gtk_window_set_default_geometry(byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare sub gtk_window_resize_to_geometry(byval window as GtkWindow ptr, byval width as gint, byval height as gint)
declare function gtk_window_get_group(byval window as GtkWindow ptr) as GtkWindowGroup ptr
declare function gtk_window_has_group(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_reshow_with_initial_size(byval window as GtkWindow ptr)
declare function gtk_window_get_window_type(byval window as GtkWindow ptr) as GtkWindowType
declare function gtk_window_get_application(byval window as GtkWindow ptr) as GtkApplication ptr
declare sub gtk_window_set_application(byval window as GtkWindow ptr, byval application as GtkApplication ptr)
declare sub gtk_window_set_has_resize_grip(byval window as GtkWindow ptr, byval value as gboolean)
declare function gtk_window_get_has_resize_grip(byval window as GtkWindow ptr) as gboolean
declare function gtk_window_resize_grip_is_visible(byval window as GtkWindow ptr) as gboolean
declare function gtk_window_get_resize_grip_area(byval window as GtkWindow ptr, byval rect as GdkRectangle ptr) as gboolean
declare sub gtk_window_set_titlebar(byval window as GtkWindow ptr, byval titlebar as GtkWidget ptr)
declare function gtk_window_get_titlebar(byval window as GtkWindow ptr) as GtkWidget ptr
declare function gtk_window_is_maximized(byval window as GtkWindow ptr) as gboolean
declare sub gtk_window_set_interactive_debugging(byval enable as gboolean)

type GtkDialogFlags as long
enum
	GTK_DIALOG_MODAL = 1 shl 0
	GTK_DIALOG_DESTROY_WITH_PARENT = 1 shl 1
	GTK_DIALOG_USE_HEADER_BAR = 1 shl 2
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
type GtkDialogPrivate as _GtkDialogPrivate
type GtkDialogClass as _GtkDialogClass

type _GtkDialog
	window as GtkWindow
	priv as GtkDialogPrivate ptr
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
declare function gtk_alternative_dialog_button_order(byval screen as GdkScreen ptr) as gboolean
declare sub gtk_dialog_set_alternative_button_order(byval dialog as GtkDialog ptr, byval first_response_id as gint, ...)
declare sub gtk_dialog_set_alternative_button_order_from_array(byval dialog as GtkDialog ptr, byval n_params as gint, byval new_order as gint ptr)
declare sub gtk_dialog_response(byval dialog as GtkDialog ptr, byval response_id as gint)
declare function gtk_dialog_run(byval dialog as GtkDialog ptr) as gint
declare function gtk_dialog_get_action_area(byval dialog as GtkDialog ptr) as GtkWidget ptr
declare function gtk_dialog_get_content_area(byval dialog as GtkDialog ptr) as GtkWidget ptr
declare function gtk_dialog_get_header_bar(byval dialog as GtkDialog ptr) as GtkWidget ptr

#define GTK_TYPE_ABOUT_DIALOG gtk_about_dialog_get_type()
#define GTK_ABOUT_DIALOG(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialog)
#define GTK_ABOUT_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass)
#define GTK_IS_ABOUT_DIALOG(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_ABOUT_DIALOG)
#define GTK_IS_ABOUT_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ABOUT_DIALOG)
#define GTK_ABOUT_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass)

type GtkAboutDialog as _GtkAboutDialog
type GtkAboutDialogClass as _GtkAboutDialogClass
type GtkAboutDialogPrivate as _GtkAboutDialogPrivate

type GtkLicense as long
enum
	GTK_LICENSE_UNKNOWN
	GTK_LICENSE_CUSTOM
	GTK_LICENSE_GPL_2_0
	GTK_LICENSE_GPL_3_0
	GTK_LICENSE_LGPL_2_1
	GTK_LICENSE_LGPL_3_0
	GTK_LICENSE_BSD
	GTK_LICENSE_MIT_X11
	GTK_LICENSE_ARTISTIC
	GTK_LICENSE_GPL_2_0_ONLY
	GTK_LICENSE_GPL_3_0_ONLY
	GTK_LICENSE_LGPL_2_1_ONLY
	GTK_LICENSE_LGPL_3_0_ONLY
end enum

type _GtkAboutDialog
	parent_instance as GtkDialog
	priv as GtkAboutDialogPrivate ptr
end type

type _GtkAboutDialogClass
	parent_class as GtkDialogClass
	activate_link as function(byval dialog as GtkAboutDialog ptr, byval uri as const gchar ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_about_dialog_get_type() as GType
declare function gtk_about_dialog_new() as GtkWidget ptr
declare sub gtk_show_about_dialog(byval parent as GtkWindow ptr, byval first_property_name as const gchar ptr, ...)
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
declare sub gtk_about_dialog_set_license_type(byval about as GtkAboutDialog ptr, byval license_type as GtkLicense)
declare function gtk_about_dialog_get_license_type(byval about as GtkAboutDialog ptr) as GtkLicense
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
declare sub gtk_about_dialog_add_credit_section(byval about as GtkAboutDialog ptr, byval section_name as const gchar ptr, byval people as const gchar ptr ptr)

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
type GtkMiscPrivate as _GtkMiscPrivate
type GtkMiscClass as _GtkMiscClass

type _GtkMisc
	widget as GtkWidget
	priv as GtkMiscPrivate ptr
end type

type _GtkMiscClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_misc_get_type() as GType
declare sub gtk_misc_set_alignment(byval misc as GtkMisc ptr, byval xalign as gfloat, byval yalign as gfloat)
declare sub gtk_misc_get_alignment(byval misc as GtkMisc ptr, byval xalign as gfloat ptr, byval yalign as gfloat ptr)
declare sub gtk_misc_set_padding(byval misc as GtkMisc ptr, byval xpad as gint, byval ypad as gint)
declare sub gtk_misc_get_padding(byval misc as GtkMisc ptr, byval xpad as gint ptr, byval ypad as gint ptr)
declare sub _gtk_misc_get_padding_and_border(byval misc as GtkMisc ptr, byval border as GtkBorder ptr)

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
type GtkMenuShellPrivate as _GtkMenuShellPrivate

type _GtkMenuShell
	container as GtkContainer
	priv as GtkMenuShellPrivate ptr
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
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_menu_shell_cancel(byval menu_shell as GtkMenuShell ptr)
declare function gtk_menu_shell_get_take_focus(byval menu_shell as GtkMenuShell ptr) as gboolean
declare sub gtk_menu_shell_set_take_focus(byval menu_shell as GtkMenuShell ptr, byval take_focus as gboolean)
declare function gtk_menu_shell_get_selected_item(byval menu_shell as GtkMenuShell ptr) as GtkWidget ptr
declare function gtk_menu_shell_get_parent_shell(byval menu_shell as GtkMenuShell ptr) as GtkWidget ptr
declare sub gtk_menu_shell_bind_model(byval menu_shell as GtkMenuShell ptr, byval model as GMenuModel ptr, byval action_namespace as const gchar ptr, byval with_separators as gboolean)

#define GTK_TYPE_MENU gtk_menu_get_type()
#define GTK_MENU(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU, GtkMenu)
#define GTK_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU, GtkMenuClass)
#define GTK_IS_MENU(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU)
#define GTK_IS_MENU_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU)
#define GTK_MENU_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU, GtkMenuClass)

type GtkMenu as _GtkMenu
type GtkMenuClass as _GtkMenuClass
type GtkMenuPrivate as _GtkMenuPrivate

type GtkArrowPlacement as long
enum
	GTK_ARROWS_BOTH
	GTK_ARROWS_START
	GTK_ARROWS_END
end enum

type GtkMenuPositionFunc as sub(byval menu as GtkMenu ptr, byval x as gint ptr, byval y as gint ptr, byval push_in as gboolean ptr, byval user_data as gpointer)
type GtkMenuDetachFunc as sub(byval attach_widget as GtkWidget ptr, byval menu as GtkMenu ptr)

type _GtkMenu
	menu_shell as GtkMenuShell
	priv as GtkMenuPrivate ptr
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
declare function gtk_menu_new_from_model(byval model as GMenuModel ptr) as GtkWidget ptr
declare sub gtk_menu_popup(byval menu as GtkMenu ptr, byval parent_menu_shell as GtkWidget ptr, byval parent_menu_item as GtkWidget ptr, byval func as GtkMenuPositionFunc, byval data as gpointer, byval button as guint, byval activate_time as guint32)
declare sub gtk_menu_popup_for_device(byval menu as GtkMenu ptr, byval device as GdkDevice ptr, byval parent_menu_shell as GtkWidget ptr, byval parent_menu_item as GtkWidget ptr, byval func as GtkMenuPositionFunc, byval data as gpointer, byval destroy as GDestroyNotify, byval button as guint, byval activate_time as guint32)
declare sub gtk_menu_reposition(byval menu as GtkMenu ptr)
declare sub gtk_menu_popdown(byval menu as GtkMenu ptr)
declare function gtk_menu_get_active(byval menu as GtkMenu ptr) as GtkWidget ptr
declare sub gtk_menu_set_active(byval menu as GtkMenu ptr, byval index as guint)
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
declare sub gtk_menu_set_reserve_toggle_size(byval menu as GtkMenu ptr, byval reserve_toggle_size as gboolean)
declare function gtk_menu_get_reserve_toggle_size(byval menu as GtkMenu ptr) as gboolean

#define GTK_TYPE_LABEL gtk_label_get_type()
#define GTK_LABEL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LABEL, GtkLabel)
#define GTK_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LABEL, GtkLabelClass)
#define GTK_IS_LABEL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LABEL)
#define GTK_IS_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LABEL)
#define GTK_LABEL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LABEL, GtkLabelClass)

type GtkLabel as _GtkLabel
type GtkLabelPrivate as _GtkLabelPrivate
type GtkLabelClass as _GtkLabelClass
type GtkLabelSelectionInfo as _GtkLabelSelectionInfo

type _GtkLabel
	misc as GtkMisc
	priv as GtkLabelPrivate ptr
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
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
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
declare sub gtk_label_set_lines(byval label as GtkLabel ptr, byval lines as gint)
declare function gtk_label_get_lines(byval label as GtkLabel ptr) as gint
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
declare sub gtk_label_set_xalign(byval label as GtkLabel ptr, byval xalign as gfloat)
declare function gtk_label_get_xalign(byval label as GtkLabel ptr) as gfloat
declare sub gtk_label_set_yalign(byval label as GtkLabel ptr, byval yalign as gfloat)
declare function gtk_label_get_yalign(byval label as GtkLabel ptr) as gfloat

#define GTK_TYPE_ACCEL_LABEL gtk_accel_label_get_type()
#define GTK_ACCEL_LABEL(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACCEL_LABEL, GtkAccelLabel)
#define GTK_ACCEL_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACCEL_LABEL, GtkAccelLabelClass)
#define GTK_IS_ACCEL_LABEL(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACCEL_LABEL)
#define GTK_IS_ACCEL_LABEL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACCEL_LABEL)
#define GTK_ACCEL_LABEL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACCEL_LABEL, GtkAccelLabelClass)

type GtkAccelLabel as _GtkAccelLabel
type GtkAccelLabelClass as _GtkAccelLabelClass
type GtkAccelLabelPrivate as _GtkAccelLabelPrivate

type _GtkAccelLabel
	label as GtkLabel
	priv as GtkAccelLabelPrivate ptr
end type

type _GtkAccelLabelClass
	parent_class as GtkLabelClass
	signal_quote1 as gchar ptr
	signal_quote2 as gchar ptr
	mod_name_shift as gchar ptr
	mod_name_control as gchar ptr
	mod_name_alt as gchar ptr
	mod_separator as gchar ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_accel_label_get_type() as GType
declare function gtk_accel_label_new(byval string as const gchar ptr) as GtkWidget ptr
declare function gtk_accel_label_get_accel_widget(byval accel_label as GtkAccelLabel ptr) as GtkWidget ptr
declare function gtk_accel_label_get_accel_width(byval accel_label as GtkAccelLabel ptr) as guint
declare sub gtk_accel_label_set_accel_widget(byval accel_label as GtkAccelLabel ptr, byval accel_widget as GtkWidget ptr)
declare sub gtk_accel_label_set_accel_closure(byval accel_label as GtkAccelLabel ptr, byval accel_closure as GClosure ptr)
declare function gtk_accel_label_refetch(byval accel_label as GtkAccelLabel ptr) as gboolean
declare sub gtk_accel_label_set_accel(byval accel_label as GtkAccelLabel ptr, byval accelerator_key as guint, byval accelerator_mods as GdkModifierType)
declare sub gtk_accel_label_get_accel(byval accel_label as GtkAccelLabel ptr, byval accelerator_key as guint ptr, byval accelerator_mods as GdkModifierType ptr)
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
declare sub gtk_accel_map_load(byval file_name as const gchar ptr)
declare sub gtk_accel_map_save(byval file_name as const gchar ptr)
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

#define __GTK_ACCESSIBLE_H__
#define GTK_TYPE_ACCESSIBLE gtk_accessible_get_type()
#define GTK_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACCESSIBLE, GtkAccessible)
#define GTK_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass)
#define GTK_IS_ACCESSIBLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACCESSIBLE)
#define GTK_IS_ACCESSIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACCESSIBLE)
#define GTK_ACCESSIBLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass)

type GtkAccessible as _GtkAccessible
type GtkAccessiblePrivate as _GtkAccessiblePrivate
type GtkAccessibleClass as _GtkAccessibleClass

type _GtkAccessible
	parent as AtkObject
	priv as GtkAccessiblePrivate ptr
end type

type _GtkAccessibleClass
	parent_class as AtkObjectClass
	connect_widget_destroyed as sub(byval accessible as GtkAccessible ptr)
	widget_set as sub(byval accessible as GtkAccessible ptr)
	widget_unset as sub(byval accessible as GtkAccessible ptr)
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_accessible_get_type() as GType
declare sub gtk_accessible_set_widget(byval accessible as GtkAccessible ptr, byval widget as GtkWidget ptr)
declare function gtk_accessible_get_widget(byval accessible as GtkAccessible ptr) as GtkWidget ptr
declare sub gtk_accessible_connect_widget_destroyed(byval accessible as GtkAccessible ptr)

#define __GTK_ACTIONABLE_H__
#define GTK_TYPE_ACTIONABLE gtk_actionable_get_type()
#define GTK_ACTIONABLE(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), GTK_TYPE_ACTIONABLE, GtkActionable)
#define GTK_IS_ACTIONABLE(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), GTK_TYPE_ACTIONABLE)
#define GTK_ACTIONABLE_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_ACTIONABLE, GtkActionableInterface)
type GtkActionableInterface as _GtkActionableInterface
type GtkActionable as _GtkActionable

type _GtkActionableInterface
	g_iface as GTypeInterface
	get_action_name as function(byval actionable as GtkActionable ptr) as const gchar ptr
	set_action_name as sub(byval actionable as GtkActionable ptr, byval action_name as const gchar ptr)
	get_action_target_value as function(byval actionable as GtkActionable ptr) as GVariant ptr
	set_action_target_value as sub(byval actionable as GtkActionable ptr, byval target_value as GVariant ptr)
end type

declare function gtk_actionable_get_type() as GType
declare function gtk_actionable_get_action_name(byval actionable as GtkActionable ptr) as const gchar ptr
declare sub gtk_actionable_set_action_name(byval actionable as GtkActionable ptr, byval action_name as const gchar ptr)
declare function gtk_actionable_get_action_target_value(byval actionable as GtkActionable ptr) as GVariant ptr
declare sub gtk_actionable_set_action_target_value(byval actionable as GtkActionable ptr, byval target_value as GVariant ptr)
declare sub gtk_actionable_set_action_target(byval actionable as GtkActionable ptr, byval format_string as const gchar ptr, ...)
declare sub gtk_actionable_set_detailed_action_name(byval actionable as GtkActionable ptr, byval detailed_action_name as const gchar ptr)

#define __GTK_ACTION_BAR_H__
#define GTK_TYPE_ACTION_BAR gtk_action_bar_get_type()
#define GTK_ACTION_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ACTION_BAR, GtkActionBar)
#define GTK_ACTION_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ACTION_BAR, GtkActionBarClass)
#define GTK_IS_ACTION_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ACTION_BAR)
#define GTK_IS_ACTION_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ACTION_BAR)
#define GTK_ACTION_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACTION_BAR, GtkActionBarClass)

type GtkActionBar as _GtkActionBar
type GtkActionBarPrivate as _GtkActionBarPrivate
type GtkActionBarClass as _GtkActionBarClass

type _GtkActionBar
	bin as GtkBin
end type

type _GtkActionBarClass
	parent_class as GtkBinClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_action_bar_get_type() as GType
declare function gtk_action_bar_new() as GtkWidget ptr
declare function gtk_action_bar_get_center_widget(byval action_bar as GtkActionBar ptr) as GtkWidget ptr
declare sub gtk_action_bar_set_center_widget(byval action_bar as GtkActionBar ptr, byval center_widget as GtkWidget ptr)
declare sub gtk_action_bar_pack_start(byval action_bar as GtkActionBar ptr, byval child as GtkWidget ptr)
declare sub gtk_action_bar_pack_end(byval action_bar as GtkActionBar ptr, byval child as GtkWidget ptr)

#define __GTK_ADJUSTMENT_H__
#define GTK_TYPE_ADJUSTMENT gtk_adjustment_get_type()
#define GTK_ADJUSTMENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustment)
#define GTK_ADJUSTMENT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass)
#define GTK_IS_ADJUSTMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ADJUSTMENT)
#define GTK_IS_ADJUSTMENT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ADJUSTMENT)
#define GTK_ADJUSTMENT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass)
type GtkAdjustmentPrivate as _GtkAdjustmentPrivate
type GtkAdjustmentClass as _GtkAdjustmentClass

type _GtkAdjustment
	parent_instance as GInitiallyUnowned
	priv as GtkAdjustmentPrivate ptr
end type

type _GtkAdjustmentClass
	parent_class as GInitiallyUnownedClass
	changed as sub(byval adjustment as GtkAdjustment ptr)
	value_changed as sub(byval adjustment as GtkAdjustment ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_adjustment_get_type() as GType
declare function gtk_adjustment_new(byval value as gdouble, byval lower as gdouble, byval upper as gdouble, byval step_increment as gdouble, byval page_increment as gdouble, byval page_size as gdouble) as GtkAdjustment ptr
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
declare function gtk_adjustment_get_minimum_increment(byval adjustment as GtkAdjustment ptr) as gdouble

#define __GTK_APP_CHOOSER_H__
#define GTK_TYPE_APP_CHOOSER gtk_app_chooser_get_type()
#define GTK_APP_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_APP_CHOOSER, GtkAppChooser)
#define GTK_IS_APP_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_APP_CHOOSER)
type GtkAppChooser as _GtkAppChooser

declare function gtk_app_chooser_get_type() as GType
declare function gtk_app_chooser_get_app_info(byval self as GtkAppChooser ptr) as GAppInfo ptr
declare function gtk_app_chooser_get_content_type(byval self as GtkAppChooser ptr) as gchar ptr
declare sub gtk_app_chooser_refresh(byval self as GtkAppChooser ptr)

#define __GTK_APP_CHOOSER_DIALOG_H__
#define GTK_TYPE_APP_CHOOSER_DIALOG gtk_app_chooser_dialog_get_type()
#define GTK_APP_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_APP_CHOOSER_DIALOG, GtkAppChooserDialog)
#define GTK_APP_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_APP_CHOOSER_DIALOG, GtkAppChooserDialogClass)
#define GTK_IS_APP_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_APP_CHOOSER_DIALOG)
#define GTK_IS_APP_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_APP_CHOOSER_DIALOG)
#define GTK_APP_CHOOSER_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_APP_CHOOSER_DIALOG, GtkAppChooserDialogClass)

type GtkAppChooserDialog as _GtkAppChooserDialog
type GtkAppChooserDialogClass as _GtkAppChooserDialogClass
type GtkAppChooserDialogPrivate as _GtkAppChooserDialogPrivate

type _GtkAppChooserDialog
	parent as GtkDialog
	priv as GtkAppChooserDialogPrivate ptr
end type

type _GtkAppChooserDialogClass
	parent_class as GtkDialogClass
	padding(0 to 15) as gpointer
end type

declare function gtk_app_chooser_dialog_get_type() as GType
declare function gtk_app_chooser_dialog_new(byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval file as GFile ptr) as GtkWidget ptr
declare function gtk_app_chooser_dialog_new_for_content_type(byval parent as GtkWindow ptr, byval flags as GtkDialogFlags, byval content_type as const gchar ptr) as GtkWidget ptr
declare function gtk_app_chooser_dialog_get_widget(byval self as GtkAppChooserDialog ptr) as GtkWidget ptr
declare sub gtk_app_chooser_dialog_set_heading(byval self as GtkAppChooserDialog ptr, byval heading as const gchar ptr)
declare function gtk_app_chooser_dialog_get_heading(byval self as GtkAppChooserDialog ptr) as const gchar ptr

#define __GTK_APP_CHOOSER_WIDGET_H__
#define __GTK_BOX_H__
#define GTK_TYPE_BOX gtk_box_get_type()
#define GTK_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BOX, GtkBox)
#define GTK_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BOX, GtkBoxClass)
#define GTK_IS_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BOX)
#define GTK_IS_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BOX)
#define GTK_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BOX, GtkBoxClass)

type GtkBox as _GtkBox
type GtkBoxPrivate as _GtkBoxPrivate
type GtkBoxClass as _GtkBoxClass

type _GtkBox
	container as GtkContainer
	priv as GtkBoxPrivate ptr
end type

type _GtkBoxClass
	parent_class as GtkContainerClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_box_get_type() as GType
declare function gtk_box_new(byval orientation as GtkOrientation, byval spacing as gint) as GtkWidget ptr
declare sub gtk_box_pack_start(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_pack_end(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint)
declare sub gtk_box_set_homogeneous(byval box as GtkBox ptr, byval homogeneous as gboolean)
declare function gtk_box_get_homogeneous(byval box as GtkBox ptr) as gboolean
declare sub gtk_box_set_spacing(byval box as GtkBox ptr, byval spacing as gint)
declare function gtk_box_get_spacing(byval box as GtkBox ptr) as gint
declare sub gtk_box_set_baseline_position(byval box as GtkBox ptr, byval position as GtkBaselinePosition)
declare function gtk_box_get_baseline_position(byval box as GtkBox ptr) as GtkBaselinePosition
declare sub gtk_box_reorder_child(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval position as gint)
declare sub gtk_box_query_child_packing(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean ptr, byval fill as gboolean ptr, byval padding as guint ptr, byval pack_type as GtkPackType ptr)
declare sub gtk_box_set_child_packing(byval box as GtkBox ptr, byval child as GtkWidget ptr, byval expand as gboolean, byval fill as gboolean, byval padding as guint, byval pack_type as GtkPackType)
declare sub gtk_box_set_center_widget(byval box as GtkBox ptr, byval widget as GtkWidget ptr)
declare function gtk_box_get_center_widget(byval box as GtkBox ptr) as GtkWidget ptr

#define GTK_TYPE_APP_CHOOSER_WIDGET gtk_app_chooser_widget_get_type()
#define GTK_APP_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_APP_CHOOSER_WIDGET, GtkAppChooserWidget)
#define GTK_APP_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_APP_CHOOSER_WIDGET, GtkAppChooserWidgetClass)
#define GTK_IS_APP_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_APP_CHOOSER_WIDGET)
#define GTK_IS_APP_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_APP_CHOOSER_WIDGET)
#define GTK_APP_CHOOSER_WIDGET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_APP_CHOOSER_WIDGET, GtkAppChooserWidgetClass)

type GtkAppChooserWidget as _GtkAppChooserWidget
type GtkAppChooserWidgetClass as _GtkAppChooserWidgetClass
type GtkAppChooserWidgetPrivate as _GtkAppChooserWidgetPrivate

type _GtkAppChooserWidget
	parent as GtkBox
	priv as GtkAppChooserWidgetPrivate ptr
end type

type _GtkAppChooserWidgetClass
	parent_class as GtkBoxClass
	application_selected as sub(byval self as GtkAppChooserWidget ptr, byval app_info as GAppInfo ptr)
	application_activated as sub(byval self as GtkAppChooserWidget ptr, byval app_info as GAppInfo ptr)
	populate_popup as sub(byval self as GtkAppChooserWidget ptr, byval menu as GtkMenu ptr, byval app_info as GAppInfo ptr)
	padding(0 to 15) as gpointer
end type

declare function gtk_app_chooser_widget_get_type() as GType
declare function gtk_app_chooser_widget_new(byval content_type as const gchar ptr) as GtkWidget ptr
declare sub gtk_app_chooser_widget_set_show_default(byval self as GtkAppChooserWidget ptr, byval setting as gboolean)
declare function gtk_app_chooser_widget_get_show_default(byval self as GtkAppChooserWidget ptr) as gboolean
declare sub gtk_app_chooser_widget_set_show_recommended(byval self as GtkAppChooserWidget ptr, byval setting as gboolean)
declare function gtk_app_chooser_widget_get_show_recommended(byval self as GtkAppChooserWidget ptr) as gboolean
declare sub gtk_app_chooser_widget_set_show_fallback(byval self as GtkAppChooserWidget ptr, byval setting as gboolean)
declare function gtk_app_chooser_widget_get_show_fallback(byval self as GtkAppChooserWidget ptr) as gboolean
declare sub gtk_app_chooser_widget_set_show_other(byval self as GtkAppChooserWidget ptr, byval setting as gboolean)
declare function gtk_app_chooser_widget_get_show_other(byval self as GtkAppChooserWidget ptr) as gboolean
declare sub gtk_app_chooser_widget_set_show_all(byval self as GtkAppChooserWidget ptr, byval setting as gboolean)
declare function gtk_app_chooser_widget_get_show_all(byval self as GtkAppChooserWidget ptr) as gboolean
declare sub gtk_app_chooser_widget_set_default_text(byval self as GtkAppChooserWidget ptr, byval text as const gchar ptr)
declare function gtk_app_chooser_widget_get_default_text(byval self as GtkAppChooserWidget ptr) as const gchar ptr

#define __GTK_APP_CHOOSER_BUTTON_H__
#define __GTK_COMBO_BOX_H__
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
	iter_previous as function(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
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
declare function gtk_tree_path_new_from_indicesv(byval indices as gint ptr, byval length as gsize) as GtkTreePath ptr
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
declare function gtk_tree_model_iter_previous(byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
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
declare sub gtk_tree_model_row_changed(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_inserted(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_has_child_toggled(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr)
declare sub gtk_tree_model_row_deleted(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr)
declare sub gtk_tree_model_rows_reordered(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr)
declare sub gtk_tree_model_rows_reordered_with_length(byval tree_model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval new_order as gint ptr, byval length as gint)

#define __GTK_TREE_VIEW_H__
#define __GTK_TREE_VIEW_COLUMN_H__
#define __GTK_CELL_RENDERER_H__
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

type GtkCellRendererState as long
enum
	GTK_CELL_RENDERER_SELECTED = 1 shl 0
	GTK_CELL_RENDERER_PRELIT = 1 shl 1
	GTK_CELL_RENDERER_INSENSITIVE = 1 shl 2
	GTK_CELL_RENDERER_SORTED = 1 shl 3
	GTK_CELL_RENDERER_FOCUSED = 1 shl 4
	GTK_CELL_RENDERER_EXPANDABLE = 1 shl 5
	GTK_CELL_RENDERER_EXPANDED = 1 shl 6
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
type GtkCellRendererPrivate as _GtkCellRendererPrivate
type GtkCellRendererClass as _GtkCellRendererClass
type GtkCellRendererClassPrivate as _GtkCellRendererClassPrivate

type _GtkCellRenderer
	parent_instance as GInitiallyUnowned
	priv as GtkCellRendererPrivate ptr
end type

type _GtkCellRendererClass
	parent_class as GInitiallyUnownedClass
	get_request_mode as function(byval cell as GtkCellRenderer ptr) as GtkSizeRequestMode
	get_preferred_width as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval minimum_size as gint ptr, byval natural_size as gint ptr)
	get_preferred_height_for_width as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
	get_preferred_height as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval minimum_size as gint ptr, byval natural_size as gint ptr)
	get_preferred_width_for_height as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
	get_aligned_area as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval flags as GtkCellRendererState, byval cell_area as const GdkRectangle ptr, byval aligned_area as GdkRectangle ptr)
	get_size as sub(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
	render as sub(byval cell as GtkCellRenderer ptr, byval cr as cairo_t ptr, byval widget as GtkWidget ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState)
	activate as function(byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as const gchar ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as gboolean
	start_editing as function(byval cell as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval widget as GtkWidget ptr, byval path as const gchar ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as GtkCellEditable ptr
	editing_canceled as sub(byval cell as GtkCellRenderer ptr)
	editing_started as sub(byval cell as GtkCellRenderer ptr, byval editable as GtkCellEditable ptr, byval path as const gchar ptr)
	priv as GtkCellRendererClassPrivate ptr
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_renderer_get_type() as GType
declare function gtk_cell_renderer_get_request_mode(byval cell as GtkCellRenderer ptr) as GtkSizeRequestMode
declare sub gtk_cell_renderer_get_preferred_width(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval minimum_size as gint ptr, byval natural_size as gint ptr)
declare sub gtk_cell_renderer_get_preferred_height_for_width(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_cell_renderer_get_preferred_height(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval minimum_size as gint ptr, byval natural_size as gint ptr)
declare sub gtk_cell_renderer_get_preferred_width_for_height(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare sub gtk_cell_renderer_get_preferred_size(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval minimum_size as GtkRequisition ptr, byval natural_size as GtkRequisition ptr)
declare sub gtk_cell_renderer_get_aligned_area(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval flags as GtkCellRendererState, byval cell_area as const GdkRectangle ptr, byval aligned_area as GdkRectangle ptr)
declare sub gtk_cell_renderer_get_size(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval x_offset as gint ptr, byval y_offset as gint ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_cell_renderer_render(byval cell as GtkCellRenderer ptr, byval cr as cairo_t ptr, byval widget as GtkWidget ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState)
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
declare function gtk_cell_renderer_is_activatable(byval cell as GtkCellRenderer ptr) as gboolean
declare sub gtk_cell_renderer_stop_editing(byval cell as GtkCellRenderer ptr, byval canceled as gboolean)
declare sub _gtk_cell_renderer_calc_offset(byval cell as GtkCellRenderer ptr, byval cell_area as const GdkRectangle ptr, byval direction as GtkTextDirection, byval width as gint, byval height as gint, byval x_offset as gint ptr, byval y_offset as gint ptr)
declare function gtk_cell_renderer_get_state(byval cell as GtkCellRenderer ptr, byval widget as GtkWidget ptr, byval cell_state as GtkCellRendererState) as GtkStateFlags
declare sub gtk_cell_renderer_class_set_accessible_type(byval renderer_class as GtkCellRendererClass ptr, byval type as GType)
declare function _gtk_cell_renderer_get_accessible_type(byval renderer as GtkCellRenderer ptr) as GType

#define __GTK_TREE_SORTABLE_H__
#define GTK_TYPE_TREE_SORTABLE gtk_tree_sortable_get_type()
#define GTK_TREE_SORTABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortable)
#define GTK_TREE_SORTABLE_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface)
#define GTK_IS_TREE_SORTABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_SORTABLE)
#define GTK_TREE_SORTABLE_GET_IFACE(obj) G_TYPE_INSTANCE_GET_INTERFACE((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface)
const GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID = -1
const GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID = -2

type GtkTreeSortable as _GtkTreeSortable
type GtkTreeSortableIface as _GtkTreeSortableIface
type GtkTreeIterCompareFunc as function(byval model as GtkTreeModel ptr, byval a as GtkTreeIter ptr, byval b as GtkTreeIter ptr, byval user_data as gpointer) as gint

type _GtkTreeSortableIface
	g_iface as GTypeInterface
	sort_column_changed as sub(byval sortable as GtkTreeSortable ptr)
	get_sort_column_id as function(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint ptr, byval order as GtkSortType ptr) as gboolean
	set_sort_column_id as sub(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval order as GtkSortType)
	set_sort_func as sub(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
	set_default_sort_func as sub(byval sortable as GtkTreeSortable ptr, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
	has_default_sort_func as function(byval sortable as GtkTreeSortable ptr) as gboolean
end type

declare function gtk_tree_sortable_get_type() as GType
declare sub gtk_tree_sortable_sort_column_changed(byval sortable as GtkTreeSortable ptr)
declare function gtk_tree_sortable_get_sort_column_id(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint ptr, byval order as GtkSortType ptr) as gboolean
declare sub gtk_tree_sortable_set_sort_column_id(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval order as GtkSortType)
declare sub gtk_tree_sortable_set_sort_func(byval sortable as GtkTreeSortable ptr, byval sort_column_id as gint, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_tree_sortable_set_default_sort_func(byval sortable as GtkTreeSortable ptr, byval sort_func as GtkTreeIterCompareFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare function gtk_tree_sortable_has_default_sort_func(byval sortable as GtkTreeSortable ptr) as gboolean

#define __GTK_CELL_AREA_H__
#define GTK_TYPE_CELL_AREA gtk_cell_area_get_type()
#define GTK_CELL_AREA(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_AREA, GtkCellArea)
#define GTK_CELL_AREA_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_AREA, GtkCellAreaClass)
#define GTK_IS_CELL_AREA(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_AREA)
#define GTK_IS_CELL_AREA_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_AREA)
#define GTK_CELL_AREA_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_AREA, GtkCellAreaClass)

type GtkCellArea as _GtkCellArea
type GtkCellAreaClass as _GtkCellAreaClass
type GtkCellAreaPrivate as _GtkCellAreaPrivate
type GtkCellAreaContext as _GtkCellAreaContext
#define GTK_CELL_AREA_WARN_INVALID_CELL_PROPERTY_ID(object, property_id, pspec) G_OBJECT_WARN_INVALID_PSPEC((object), "cell property id", (property_id), (pspec))
type GtkCellCallback as function(byval renderer as GtkCellRenderer ptr, byval data as gpointer) as gboolean
type GtkCellAllocCallback as function(byval renderer as GtkCellRenderer ptr, byval cell_area as const GdkRectangle ptr, byval cell_background as const GdkRectangle ptr, byval data as gpointer) as gboolean

type _GtkCellArea
	parent_instance as GInitiallyUnowned
	priv as GtkCellAreaPrivate ptr
end type

type _GtkCellAreaClass
	parent_class as GInitiallyUnownedClass
	add as sub(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr)
	remove as sub(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr)
	foreach as sub(byval area as GtkCellArea ptr, byval callback as GtkCellCallback, byval callback_data as gpointer)
	foreach_alloc as sub(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval background_area as const GdkRectangle ptr, byval callback as GtkCellAllocCallback, byval callback_data as gpointer)
	event as function(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval event as GdkEvent ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as gint
	render as sub(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cr as cairo_t ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState, byval paint_focus as gboolean)
	apply_attributes as sub(byval area as GtkCellArea ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval is_expander as gboolean, byval is_expanded as gboolean)
	create_context as function(byval area as GtkCellArea ptr) as GtkCellAreaContext ptr
	copy_context as function(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr) as GtkCellAreaContext ptr
	get_request_mode as function(byval area as GtkCellArea ptr) as GtkSizeRequestMode
	get_preferred_width as sub(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval minimum_width as gint ptr, byval natural_width as gint ptr)
	get_preferred_height_for_width as sub(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
	get_preferred_height as sub(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval minimum_height as gint ptr, byval natural_height as gint ptr)
	get_preferred_width_for_height as sub(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
	set_cell_property as sub(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval property_id as guint, byval value as const GValue ptr, byval pspec as GParamSpec ptr)
	get_cell_property as sub(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval property_id as guint, byval value as GValue ptr, byval pspec as GParamSpec ptr)
	focus as function(byval area as GtkCellArea ptr, byval direction as GtkDirectionType) as gboolean
	is_activatable as function(byval area as GtkCellArea ptr) as gboolean
	activate as function(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState, byval edit_only as gboolean) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

declare function gtk_cell_area_get_type() as GType
declare sub gtk_cell_area_add(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr)
declare sub gtk_cell_area_remove(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr)
declare function gtk_cell_area_has_renderer(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr) as gboolean
declare sub gtk_cell_area_foreach(byval area as GtkCellArea ptr, byval callback as GtkCellCallback, byval callback_data as gpointer)
declare sub gtk_cell_area_foreach_alloc(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval background_area as const GdkRectangle ptr, byval callback as GtkCellAllocCallback, byval callback_data as gpointer)
declare function gtk_cell_area_event(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval event as GdkEvent ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as gint
declare sub gtk_cell_area_render(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cr as cairo_t ptr, byval background_area as const GdkRectangle ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState, byval paint_focus as gboolean)
declare sub gtk_cell_area_get_cell_allocation(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval renderer as GtkCellRenderer ptr, byval cell_area as const GdkRectangle ptr, byval allocation as GdkRectangle ptr)
declare function gtk_cell_area_get_cell_at_position(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval x as gint, byval y as gint, byval alloc_area as GdkRectangle ptr) as GtkCellRenderer ptr
declare function gtk_cell_area_create_context(byval area as GtkCellArea ptr) as GtkCellAreaContext ptr
declare function gtk_cell_area_copy_context(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr) as GtkCellAreaContext ptr
declare function gtk_cell_area_get_request_mode(byval area as GtkCellArea ptr) as GtkSizeRequestMode
declare sub gtk_cell_area_get_preferred_width(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare sub gtk_cell_area_get_preferred_height_for_width(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_cell_area_get_preferred_height(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_cell_area_get_preferred_width_for_height(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare function gtk_cell_area_get_current_path_string(byval area as GtkCellArea ptr) as const gchar ptr
declare sub gtk_cell_area_apply_attributes(byval area as GtkCellArea ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval is_expander as gboolean, byval is_expanded as gboolean)
declare sub gtk_cell_area_attribute_connect(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval attribute as const gchar ptr, byval column as gint)
declare sub gtk_cell_area_attribute_disconnect(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval attribute as const gchar ptr)
declare function gtk_cell_area_attribute_get_column(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval attribute as const gchar ptr) as gint
declare sub gtk_cell_area_class_install_cell_property(byval aclass as GtkCellAreaClass ptr, byval property_id as guint, byval pspec as GParamSpec ptr)
declare function gtk_cell_area_class_find_cell_property(byval aclass as GtkCellAreaClass ptr, byval property_name as const gchar ptr) as GParamSpec ptr
declare function gtk_cell_area_class_list_cell_properties(byval aclass as GtkCellAreaClass ptr, byval n_properties as guint ptr) as GParamSpec ptr ptr
declare sub gtk_cell_area_add_with_properties(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval first_prop_name as const gchar ptr, ...)
declare sub gtk_cell_area_cell_set(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval first_prop_name as const gchar ptr, ...)
declare sub gtk_cell_area_cell_get(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval first_prop_name as const gchar ptr, ...)
declare sub gtk_cell_area_cell_set_valist(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_cell_area_cell_get_valist(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_cell_area_cell_set_property(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval property_name as const gchar ptr, byval value as const GValue ptr)
declare sub gtk_cell_area_cell_get_property(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
declare function gtk_cell_area_is_activatable(byval area as GtkCellArea ptr) as gboolean
declare function gtk_cell_area_activate(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState, byval edit_only as gboolean) as gboolean
declare function gtk_cell_area_focus(byval area as GtkCellArea ptr, byval direction as GtkDirectionType) as gboolean
declare sub gtk_cell_area_set_focus_cell(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr)
declare function gtk_cell_area_get_focus_cell(byval area as GtkCellArea ptr) as GtkCellRenderer ptr
declare sub gtk_cell_area_add_focus_sibling(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval sibling as GtkCellRenderer ptr)
declare sub gtk_cell_area_remove_focus_sibling(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval sibling as GtkCellRenderer ptr)
declare function gtk_cell_area_is_focus_sibling(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval sibling as GtkCellRenderer ptr) as gboolean
declare function gtk_cell_area_get_focus_siblings(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr) as const GList ptr
declare function gtk_cell_area_get_focus_from_sibling(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr) as GtkCellRenderer ptr
declare function gtk_cell_area_get_edited_cell(byval area as GtkCellArea ptr) as GtkCellRenderer ptr
declare function gtk_cell_area_get_edit_widget(byval area as GtkCellArea ptr) as GtkCellEditable ptr
declare function gtk_cell_area_activate_cell(byval area as GtkCellArea ptr, byval widget as GtkWidget ptr, byval renderer as GtkCellRenderer ptr, byval event as GdkEvent ptr, byval cell_area as const GdkRectangle ptr, byval flags as GtkCellRendererState) as gboolean
declare sub gtk_cell_area_stop_editing(byval area as GtkCellArea ptr, byval canceled as gboolean)
declare sub gtk_cell_area_inner_cell_area(byval area as GtkCellArea ptr, byval widget as GtkWidget ptr, byval cell_area as const GdkRectangle ptr, byval inner_area as GdkRectangle ptr)
declare sub gtk_cell_area_request_renderer(byval area as GtkCellArea ptr, byval renderer as GtkCellRenderer ptr, byval orientation as GtkOrientation, byval widget as GtkWidget ptr, byval for_size as gint, byval minimum_size as gint ptr, byval natural_size as gint ptr)
declare sub _gtk_cell_area_set_cell_data_func_with_proxy(byval area as GtkCellArea ptr, byval cell as GtkCellRenderer ptr, byval func as GFunc, byval func_data as gpointer, byval destroy as GDestroyNotify, byval proxy as gpointer)

#define GTK_TYPE_TREE_VIEW_COLUMN gtk_tree_view_column_get_type()
#define GTK_TREE_VIEW_COLUMN(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumn)
#define GTK_TREE_VIEW_COLUMN_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass)
#define GTK_IS_TREE_VIEW_COLUMN(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TREE_VIEW_COLUMN)
#define GTK_IS_TREE_VIEW_COLUMN_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TREE_VIEW_COLUMN)
#define GTK_TREE_VIEW_COLUMN_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass)

type GtkTreeViewColumn as _GtkTreeViewColumn
type GtkTreeViewColumnClass as _GtkTreeViewColumnClass
type GtkTreeViewColumnPrivate as _GtkTreeViewColumnPrivate

type GtkTreeViewColumnSizing as long
enum
	GTK_TREE_VIEW_COLUMN_GROW_ONLY
	GTK_TREE_VIEW_COLUMN_AUTOSIZE
	GTK_TREE_VIEW_COLUMN_FIXED
end enum

type GtkTreeCellDataFunc as sub(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval tree_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval data as gpointer)

type _GtkTreeViewColumn
	parent_instance as GInitiallyUnowned
	priv as GtkTreeViewColumnPrivate ptr
end type

type _GtkTreeViewColumnClass
	parent_class as GInitiallyUnownedClass
	clicked as sub(byval tree_column as GtkTreeViewColumn ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_tree_view_column_get_type() as GType
declare function gtk_tree_view_column_new() as GtkTreeViewColumn ptr
declare function gtk_tree_view_column_new_with_area(byval area as GtkCellArea ptr) as GtkTreeViewColumn ptr
declare function gtk_tree_view_column_new_with_attributes(byval title as const gchar ptr, byval cell as GtkCellRenderer ptr, ...) as GtkTreeViewColumn ptr
declare sub gtk_tree_view_column_pack_start(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_tree_view_column_pack_end(byval tree_column as GtkTreeViewColumn ptr, byval cell as GtkCellRenderer ptr, byval expand as gboolean)
declare sub gtk_tree_view_column_clear(byval tree_column as GtkTreeViewColumn ptr)
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
declare function gtk_tree_view_column_get_x_offset(byval tree_column as GtkTreeViewColumn ptr) as gint
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
declare function gtk_tree_view_column_cell_get_position(byval tree_column as GtkTreeViewColumn ptr, byval cell_renderer as GtkCellRenderer ptr, byval x_offset as gint ptr, byval width as gint ptr) as gboolean
declare sub gtk_tree_view_column_queue_resize(byval tree_column as GtkTreeViewColumn ptr)
declare function gtk_tree_view_column_get_tree_view(byval tree_column as GtkTreeViewColumn ptr) as GtkWidget ptr
declare function gtk_tree_view_column_get_button(byval tree_column as GtkTreeViewColumn ptr) as GtkWidget ptr

#define __GTK_DND_H__
#define __GTK_SELECTION_H__
#define __GTK_TEXT_ITER_H__
#define __GTK_TEXT_ATTRIBUTES_H__
type GtkTextAttributes as _GtkTextAttributes
#define GTK_TYPE_TEXT_ATTRIBUTES gtk_text_attributes_get_type()
type GtkTextAppearance as _GtkTextAppearance

type _GtkTextAppearance
	bg_color as GdkColor
	fg_color as GdkColor
	rise as gint
	underline : 4 as guint
	strikethrough : 1 as guint
	draw_bg : 1 as guint
	inside_selection : 1 as guint
	is_text : 1 as guint
	rgba_(0 to 1) as GdkRGBA ptr

	#ifndef __FB_64BIT__
		padding(0 to 1) as guint
	#endif
end type

type _GtkTextAttributes
	refcount as guint
	appearance as GtkTextAppearance
	justification as GtkJustification
	direction as GtkTextDirection
	font as PangoFontDescription ptr
	font_scale as gdouble
	left_margin as gint
	right_margin as gint
	indent as gint
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
	no_fallback : 1 as guint
	pg_bg_rgba as GdkRGBA ptr
	letter_spacing as gint
	padding(0 to 1) as guint
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
#define __GTK_TEXT_TAG_H__
type GtkTextIter as _GtkTextIter
type GtkTextTagTable as _GtkTextTagTable

#define GTK_TYPE_TEXT_TAG gtk_text_tag_get_type()
#define GTK_TEXT_TAG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_TAG, GtkTextTag)
#define GTK_TEXT_TAG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_TAG, GtkTextTagClass)
#define GTK_IS_TEXT_TAG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_TAG)
#define GTK_IS_TEXT_TAG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_TAG)
#define GTK_TEXT_TAG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_TAG, GtkTextTagClass)

type GtkTextTag as _GtkTextTag
type GtkTextTagPrivate as _GtkTextTagPrivate
type GtkTextTagClass as _GtkTextTagClass

type _GtkTextTag
	parent_instance as GObject
	priv as GtkTextTagPrivate ptr
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

type GtkTextSearchFlags as long
enum
	GTK_TEXT_SEARCH_VISIBLE_ONLY = 1 shl 0
	GTK_TEXT_SEARCH_TEXT_ONLY = 1 shl 1
	GTK_TEXT_SEARCH_CASE_INSENSITIVE = 1 shl 2
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
declare sub gtk_text_iter_assign(byval iter as GtkTextIter ptr, byval other as const GtkTextIter ptr)
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
type GtkTargetPair as _GtkTargetPair

type _GtkTargetPair
	target as GdkAtom
	flags as guint
	info as guint
end type

type GtkTargetList as _GtkTargetList
type GtkTargetEntry as _GtkTargetEntry
#define GTK_TYPE_SELECTION_DATA gtk_selection_data_get_type()
#define GTK_TYPE_TARGET_LIST gtk_target_list_get_type()

type _GtkTargetEntry
	target as gchar ptr
	flags as guint
	info as guint
end type

declare function gtk_target_list_get_type() as GType
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
declare sub gtk_selection_remove_all(byval widget as GtkWidget ptr)
declare function gtk_selection_data_get_selection(byval selection_data as const GtkSelectionData ptr) as GdkAtom
declare function gtk_selection_data_get_target(byval selection_data as const GtkSelectionData ptr) as GdkAtom
declare function gtk_selection_data_get_data_type(byval selection_data as const GtkSelectionData ptr) as GdkAtom
declare function gtk_selection_data_get_format(byval selection_data as const GtkSelectionData ptr) as gint
declare function gtk_selection_data_get_data(byval selection_data as const GtkSelectionData ptr) as const guchar ptr
declare function gtk_selection_data_get_length(byval selection_data as const GtkSelectionData ptr) as gint
declare function gtk_selection_data_get_data_with_length(byval selection_data as const GtkSelectionData ptr, byval length as gint ptr) as const guchar ptr
declare function gtk_selection_data_get_display(byval selection_data as const GtkSelectionData ptr) as GdkDisplay ptr
declare sub gtk_selection_data_set(byval selection_data as GtkSelectionData ptr, byval type as GdkAtom, byval format as gint, byval data as const guchar ptr, byval length as gint)
declare function gtk_selection_data_set_text(byval selection_data as GtkSelectionData ptr, byval str as const gchar ptr, byval len as gint) as gboolean
declare function gtk_selection_data_get_text(byval selection_data as const GtkSelectionData ptr) as guchar ptr
declare function gtk_selection_data_set_pixbuf(byval selection_data as GtkSelectionData ptr, byval pixbuf as GdkPixbuf ptr) as gboolean
declare function gtk_selection_data_get_pixbuf(byval selection_data as const GtkSelectionData ptr) as GdkPixbuf ptr
declare function gtk_selection_data_set_uris(byval selection_data as GtkSelectionData ptr, byval uris as gchar ptr ptr) as gboolean
declare function gtk_selection_data_get_uris(byval selection_data as const GtkSelectionData ptr) as gchar ptr ptr
declare function gtk_selection_data_get_targets(byval selection_data as const GtkSelectionData ptr, byval targets as GdkAtom ptr ptr, byval n_atoms as gint ptr) as gboolean
declare function gtk_selection_data_targets_include_text(byval selection_data as const GtkSelectionData ptr) as gboolean
declare function gtk_selection_data_targets_include_rich_text(byval selection_data as const GtkSelectionData ptr, byval buffer as GtkTextBuffer ptr) as gboolean
declare function gtk_selection_data_targets_include_image(byval selection_data as const GtkSelectionData ptr, byval writable as gboolean) as gboolean
declare function gtk_selection_data_targets_include_uri(byval selection_data as const GtkSelectionData ptr) as gboolean
declare function gtk_targets_include_text(byval targets as GdkAtom ptr, byval n_targets as gint) as gboolean
declare function gtk_targets_include_rich_text(byval targets as GdkAtom ptr, byval n_targets as gint, byval buffer as GtkTextBuffer ptr) as gboolean
declare function gtk_targets_include_image(byval targets as GdkAtom ptr, byval n_targets as gint, byval writable as gboolean) as gboolean
declare function gtk_targets_include_uri(byval targets as GdkAtom ptr, byval n_targets as gint) as gboolean
declare function gtk_selection_data_get_type() as GType
declare function gtk_selection_data_copy(byval data as const GtkSelectionData ptr) as GtkSelectionData ptr
declare sub gtk_selection_data_free(byval data as GtkSelectionData ptr)
declare function gtk_target_entry_get_type() as GType
declare function gtk_target_entry_new(byval target as const gchar ptr, byval flags as guint, byval info as guint) as GtkTargetEntry ptr
declare function gtk_target_entry_copy(byval data as GtkTargetEntry ptr) as GtkTargetEntry ptr
declare sub gtk_target_entry_free(byval data as GtkTargetEntry ptr)

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
declare sub gtk_drag_source_set_icon_pixbuf(byval widget as GtkWidget ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_drag_source_set_icon_stock(byval widget as GtkWidget ptr, byval stock_id as const gchar ptr)
declare sub gtk_drag_source_set_icon_name(byval widget as GtkWidget ptr, byval icon_name as const gchar ptr)
declare sub gtk_drag_source_set_icon_gicon(byval widget as GtkWidget ptr, byval icon as GIcon ptr)
declare function gtk_drag_begin_with_coordinates(byval widget as GtkWidget ptr, byval targets as GtkTargetList ptr, byval actions as GdkDragAction, byval button as gint, byval event as GdkEvent ptr, byval x as gint, byval y as gint) as GdkDragContext ptr
declare function gtk_drag_begin(byval widget as GtkWidget ptr, byval targets as GtkTargetList ptr, byval actions as GdkDragAction, byval button as gint, byval event as GdkEvent ptr) as GdkDragContext ptr
declare sub gtk_drag_cancel(byval context as GdkDragContext ptr)
declare sub gtk_drag_set_icon_widget(byval context as GdkDragContext ptr, byval widget as GtkWidget ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_pixbuf(byval context as GdkDragContext ptr, byval pixbuf as GdkPixbuf ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_stock(byval context as GdkDragContext ptr, byval stock_id as const gchar ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_surface(byval context as GdkDragContext ptr, byval surface as cairo_surface_t ptr)
declare sub gtk_drag_set_icon_name(byval context as GdkDragContext ptr, byval icon_name as const gchar ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_gicon(byval context as GdkDragContext ptr, byval icon as GIcon ptr, byval hot_x as gint, byval hot_y as gint)
declare sub gtk_drag_set_icon_default(byval context as GdkDragContext ptr)
declare function gtk_drag_check_threshold(byval widget as GtkWidget ptr, byval start_x as gint, byval start_y as gint, byval current_x as gint, byval current_y as gint) as gboolean
declare sub _gtk_drag_source_handle_event(byval widget as GtkWidget ptr, byval event as GdkEvent ptr)
declare sub _gtk_drag_dest_handle_event(byval toplevel as GtkWidget ptr, byval event as GdkEvent ptr)

#define __GTK_ENTRY_H__
#define __GTK_EDITABLE_H__
#define GTK_TYPE_EDITABLE gtk_editable_get_type()
#define GTK_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_EDITABLE, GtkEditable)
#define GTK_IS_EDITABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_EDITABLE)
#define GTK_EDITABLE_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_EDITABLE, GtkEditableInterface)
type GtkEditable as _GtkEditable
type GtkEditableInterface as _GtkEditableInterface

type _GtkEditableInterface
	base_iface as GTypeInterface
	insert_text as sub(byval editable as GtkEditable ptr, byval new_text as const gchar ptr, byval new_text_length as gint, byval position as gint ptr)
	delete_text as sub(byval editable as GtkEditable ptr, byval start_pos as gint, byval end_pos as gint)
	changed as sub(byval editable as GtkEditable ptr)
	do_insert_text as sub(byval editable as GtkEditable ptr, byval new_text as const gchar ptr, byval new_text_length as gint, byval position as gint ptr)
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
	parent_class as GObjectClass
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
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
type GtkListStorePrivate as _GtkListStorePrivate
type GtkListStoreClass as _GtkListStoreClass

type _GtkListStore
	parent as GObject
	priv as GtkListStorePrivate ptr
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
	visible as function(byval self as GtkTreeModelFilter ptr, byval child_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr) as gboolean
	modify as sub(byval self as GtkTreeModelFilter ptr, byval child_model as GtkTreeModel ptr, byval iter as GtkTreeIter ptr, byval value as GValue ptr, byval column as gint)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
	no_matches as sub(byval completion as GtkEntryCompletion ptr)
	_gtk_reserved0 as sub()
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_entry_completion_get_type() as GType
declare function gtk_entry_completion_new() as GtkEntryCompletion ptr
declare function gtk_entry_completion_new_with_area(byval area as GtkCellArea ptr) as GtkEntryCompletion ptr
declare function gtk_entry_completion_get_entry(byval completion as GtkEntryCompletion ptr) as GtkWidget ptr
declare sub gtk_entry_completion_set_model(byval completion as GtkEntryCompletion ptr, byval model as GtkTreeModel ptr)
declare function gtk_entry_completion_get_model(byval completion as GtkEntryCompletion ptr) as GtkTreeModel ptr
declare sub gtk_entry_completion_set_match_func(byval completion as GtkEntryCompletion ptr, byval func as GtkEntryCompletionMatchFunc, byval func_data as gpointer, byval func_notify as GDestroyNotify)
declare sub gtk_entry_completion_set_minimum_key_length(byval completion as GtkEntryCompletion ptr, byval length as gint)
declare function gtk_entry_completion_get_minimum_key_length(byval completion as GtkEntryCompletion ptr) as gint
declare function gtk_entry_completion_compute_prefix(byval completion as GtkEntryCompletion ptr, byval key as const zstring ptr) as gchar ptr
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

#define __GTK_IMAGE_H__
#define GTK_TYPE_IMAGE gtk_image_get_type()
#define GTK_IMAGE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IMAGE, GtkImage)
#define GTK_IMAGE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IMAGE, GtkImageClass)
#define GTK_IS_IMAGE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IMAGE)
#define GTK_IS_IMAGE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IMAGE)
#define GTK_IMAGE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IMAGE, GtkImageClass)

type GtkImage as _GtkImage
type GtkImagePrivate as _GtkImagePrivate
type GtkImageClass as _GtkImageClass

type GtkImageType as long
enum
	GTK_IMAGE_EMPTY
	GTK_IMAGE_PIXBUF
	GTK_IMAGE_STOCK
	GTK_IMAGE_ICON_SET
	GTK_IMAGE_ANIMATION
	GTK_IMAGE_ICON_NAME
	GTK_IMAGE_GICON
	GTK_IMAGE_SURFACE
end enum

type _GtkImage
	misc as GtkMisc
	priv as GtkImagePrivate ptr
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
declare function gtk_image_new_from_file(byval filename as const gchar ptr) as GtkWidget ptr
declare function gtk_image_new_from_resource(byval resource_path as const gchar ptr) as GtkWidget ptr
declare function gtk_image_new_from_pixbuf(byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare function gtk_image_new_from_stock(byval stock_id as const gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_icon_set(byval icon_set as GtkIconSet ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_animation(byval animation as GdkPixbufAnimation ptr) as GtkWidget ptr
declare function gtk_image_new_from_icon_name(byval icon_name as const gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_gicon(byval icon as GIcon ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_image_new_from_surface(byval surface as cairo_surface_t ptr) as GtkWidget ptr
declare sub gtk_image_clear(byval image as GtkImage ptr)
declare sub gtk_image_set_from_file(byval image as GtkImage ptr, byval filename as const gchar ptr)
declare sub gtk_image_set_from_resource(byval image as GtkImage ptr, byval resource_path as const gchar ptr)
declare sub gtk_image_set_from_pixbuf(byval image as GtkImage ptr, byval pixbuf as GdkPixbuf ptr)
declare sub gtk_image_set_from_stock(byval image as GtkImage ptr, byval stock_id as const gchar ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_icon_set(byval image as GtkImage ptr, byval icon_set as GtkIconSet ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_animation(byval image as GtkImage ptr, byval animation as GdkPixbufAnimation ptr)
declare sub gtk_image_set_from_icon_name(byval image as GtkImage ptr, byval icon_name as const gchar ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_gicon(byval image as GtkImage ptr, byval icon as GIcon ptr, byval size as GtkIconSize)
declare sub gtk_image_set_from_surface(byval image as GtkImage ptr, byval surface as cairo_surface_t ptr)
declare sub gtk_image_set_pixel_size(byval image as GtkImage ptr, byval pixel_size as gint)
declare function gtk_image_get_storage_type(byval image as GtkImage ptr) as GtkImageType
declare function gtk_image_get_pixbuf(byval image as GtkImage ptr) as GdkPixbuf ptr
declare sub gtk_image_get_stock(byval image as GtkImage ptr, byval stock_id as gchar ptr ptr, byval size as GtkIconSize ptr)
declare sub gtk_image_get_icon_set(byval image as GtkImage ptr, byval icon_set as GtkIconSet ptr ptr, byval size as GtkIconSize ptr)
declare function gtk_image_get_animation(byval image as GtkImage ptr) as GdkPixbufAnimation ptr
declare sub gtk_image_get_icon_name(byval image as GtkImage ptr, byval icon_name as const gchar ptr ptr, byval size as GtkIconSize ptr)
declare sub gtk_image_get_gicon(byval image as GtkImage ptr, byval gicon as GIcon ptr ptr, byval size as GtkIconSize ptr)
declare function gtk_image_get_pixel_size(byval image as GtkImage ptr) as gint

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
type GtkEntryPrivate as _GtkEntryPrivate
type GtkEntryClass as _GtkEntryClass

type _GtkEntry
	parent_instance as GtkWidget
	priv as GtkEntryPrivate ptr
end type

type _GtkEntryClass
	parent_class as GtkWidgetClass
	populate_popup as sub(byval entry as GtkEntry ptr, byval popup as GtkWidget ptr)
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
	get_frame_size as sub(byval entry as GtkEntry ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
end type

declare function gtk_entry_get_type() as GType
declare function gtk_entry_new() as GtkWidget ptr
declare function gtk_entry_new_with_buffer(byval buffer as GtkEntryBuffer ptr) as GtkWidget ptr
declare function gtk_entry_get_buffer(byval entry as GtkEntry ptr) as GtkEntryBuffer ptr
declare sub gtk_entry_set_buffer(byval entry as GtkEntry ptr, byval buffer as GtkEntryBuffer ptr)
declare sub gtk_entry_get_text_area(byval entry as GtkEntry ptr, byval text_area as GdkRectangle ptr)
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
declare sub gtk_entry_set_max_width_chars(byval entry as GtkEntry ptr, byval n_chars as gint)
declare function gtk_entry_get_max_width_chars(byval entry as GtkEntry ptr) as gint
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
declare function gtk_entry_get_placeholder_text(byval entry as GtkEntry ptr) as const gchar ptr
declare sub gtk_entry_set_placeholder_text(byval entry as GtkEntry ptr, byval text as const gchar ptr)
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
declare sub gtk_entry_get_icon_area(byval entry as GtkEntry ptr, byval icon_pos as GtkEntryIconPosition, byval icon_area as GdkRectangle ptr)
declare function gtk_entry_im_context_filter_keypress(byval entry as GtkEntry ptr, byval event as GdkEventKey ptr) as gboolean
declare sub gtk_entry_reset_im_context(byval entry as GtkEntry ptr)
declare sub gtk_entry_set_input_purpose(byval entry as GtkEntry ptr, byval purpose as GtkInputPurpose)
declare function gtk_entry_get_input_purpose(byval entry as GtkEntry ptr) as GtkInputPurpose
declare sub gtk_entry_set_input_hints(byval entry as GtkEntry ptr, byval hints as GtkInputHints)
declare function gtk_entry_get_input_hints(byval entry as GtkEntry ptr) as GtkInputHints
declare sub gtk_entry_set_attributes(byval entry as GtkEntry ptr, byval attrs as PangoAttrList ptr)
declare function gtk_entry_get_attributes(byval entry as GtkEntry ptr) as PangoAttrList ptr
declare sub gtk_entry_set_tabs(byval entry as GtkEntry ptr, byval tabs as PangoTabArray ptr)
declare function gtk_entry_get_tabs(byval entry as GtkEntry ptr) as PangoTabArray ptr
declare sub gtk_entry_grab_focus_without_selecting(byval entry as GtkEntry ptr)

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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
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
declare function gtk_tree_view_get_activate_on_single_click(byval tree_view as GtkTreeView ptr) as gboolean
declare sub gtk_tree_view_set_activate_on_single_click(byval tree_view as GtkTreeView ptr, byval single as gboolean)
declare function gtk_tree_view_append_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_remove_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr) as gint
declare function gtk_tree_view_insert_column(byval tree_view as GtkTreeView ptr, byval column as GtkTreeViewColumn ptr, byval position as gint) as gint
declare function gtk_tree_view_insert_column_with_attributes(byval tree_view as GtkTreeView ptr, byval position as gint, byval title as const gchar ptr, byval cell as GtkCellRenderer ptr, ...) as gint
declare function gtk_tree_view_insert_column_with_data_func(byval tree_view as GtkTreeView ptr, byval position as gint, byval title as const gchar ptr, byval cell as GtkCellRenderer ptr, byval func as GtkTreeCellDataFunc, byval data as gpointer, byval dnotify as GDestroyNotify) as gint
declare function gtk_tree_view_get_n_columns(byval tree_view as GtkTreeView ptr) as guint
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
declare function gtk_tree_view_get_visible_range(byval tree_view as GtkTreeView ptr, byval start_path as GtkTreePath ptr ptr, byval end_path as GtkTreePath ptr ptr) as gboolean
declare function gtk_tree_view_is_blank_at_pos(byval tree_view as GtkTreeView ptr, byval x as gint, byval y as gint, byval path as GtkTreePath ptr ptr, byval column as GtkTreeViewColumn ptr ptr, byval cell_x as gint ptr, byval cell_y as gint ptr) as gboolean
declare sub gtk_tree_view_enable_model_drag_source(byval tree_view as GtkTreeView ptr, byval start_button_mask as GdkModifierType, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_tree_view_enable_model_drag_dest(byval tree_view as GtkTreeView ptr, byval targets as const GtkTargetEntry ptr, byval n_targets as gint, byval actions as GdkDragAction)
declare sub gtk_tree_view_unset_rows_drag_source(byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_unset_rows_drag_dest(byval tree_view as GtkTreeView ptr)
declare sub gtk_tree_view_set_drag_dest_row(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr, byval pos as GtkTreeViewDropPosition)
declare sub gtk_tree_view_get_drag_dest_row(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr ptr, byval pos as GtkTreeViewDropPosition ptr)
declare function gtk_tree_view_get_dest_row_at_pos(byval tree_view as GtkTreeView ptr, byval drag_x as gint, byval drag_y as gint, byval path as GtkTreePath ptr ptr, byval pos as GtkTreeViewDropPosition ptr) as gboolean
declare function gtk_tree_view_create_row_drag_icon(byval tree_view as GtkTreeView ptr, byval path as GtkTreePath ptr) as cairo_surface_t ptr
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
	format_entry_text as function(byval combo_box as GtkComboBox ptr, byval path as const gchar ptr) as gchar ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

declare function gtk_combo_box_get_type() as GType
declare function gtk_combo_box_new() as GtkWidget ptr
declare function gtk_combo_box_new_with_area(byval area as GtkCellArea ptr) as GtkWidget ptr
declare function gtk_combo_box_new_with_area_and_entry(byval area as GtkCellArea ptr) as GtkWidget ptr
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
declare sub gtk_combo_box_set_popup_fixed_width(byval combo_box as GtkComboBox ptr, byval fixed as gboolean)
declare function gtk_combo_box_get_popup_fixed_width(byval combo_box as GtkComboBox ptr) as gboolean
declare sub gtk_combo_box_popup(byval combo_box as GtkComboBox ptr)
declare sub gtk_combo_box_popup_for_device(byval combo_box as GtkComboBox ptr, byval device as GdkDevice ptr)
declare sub gtk_combo_box_popdown(byval combo_box as GtkComboBox ptr)
declare function gtk_combo_box_get_popup_accessible(byval combo_box as GtkComboBox ptr) as AtkObject ptr
declare function gtk_combo_box_get_id_column(byval combo_box as GtkComboBox ptr) as gint
declare sub gtk_combo_box_set_id_column(byval combo_box as GtkComboBox ptr, byval id_column as gint)
declare function gtk_combo_box_get_active_id(byval combo_box as GtkComboBox ptr) as const gchar ptr
declare function gtk_combo_box_set_active_id(byval combo_box as GtkComboBox ptr, byval active_id as const gchar ptr) as gboolean

#define GTK_TYPE_APP_CHOOSER_BUTTON gtk_app_chooser_button_get_type()
#define GTK_APP_CHOOSER_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_APP_CHOOSER_BUTTON, GtkAppChooserButton)
#define GTK_APP_CHOOSER_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_APP_CHOOSER_BUTTON, GtkAppChooserButtonClass)
#define GTK_IS_APP_CHOOSER_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_APP_CHOOSER_BUTTON)
#define GTK_IS_APP_CHOOSER_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_APP_CHOOSER_BUTTON)
#define GTK_APP_CHOOSER_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_APP_CHOOSER_BUTTON, GtkAppChooserButtonClass)

type GtkAppChooserButton as _GtkAppChooserButton
type GtkAppChooserButtonClass as _GtkAppChooserButtonClass
type GtkAppChooserButtonPrivate as _GtkAppChooserButtonPrivate

type _GtkAppChooserButton
	parent as GtkComboBox
	priv as GtkAppChooserButtonPrivate ptr
end type

type _GtkAppChooserButtonClass
	parent_class as GtkComboBoxClass
	custom_item_activated as sub(byval self as GtkAppChooserButton ptr, byval item_name as const gchar ptr)
	padding(0 to 15) as gpointer
end type

declare function gtk_app_chooser_button_get_type() as GType
declare function gtk_app_chooser_button_new(byval content_type as const gchar ptr) as GtkWidget ptr
declare sub gtk_app_chooser_button_append_separator(byval self as GtkAppChooserButton ptr)
declare sub gtk_app_chooser_button_append_custom_item(byval self as GtkAppChooserButton ptr, byval name as const gchar ptr, byval label as const gchar ptr, byval icon as GIcon ptr)
declare sub gtk_app_chooser_button_set_active_custom_item(byval self as GtkAppChooserButton ptr, byval name as const gchar ptr)
declare sub gtk_app_chooser_button_set_show_dialog_item(byval self as GtkAppChooserButton ptr, byval setting as gboolean)
declare function gtk_app_chooser_button_get_show_dialog_item(byval self as GtkAppChooserButton ptr) as gboolean
declare sub gtk_app_chooser_button_set_heading(byval self as GtkAppChooserButton ptr, byval heading as const gchar ptr)
declare function gtk_app_chooser_button_get_heading(byval self as GtkAppChooserButton ptr) as const gchar ptr
declare sub gtk_app_chooser_button_set_show_default_item(byval self as GtkAppChooserButton ptr, byval setting as gboolean)
declare function gtk_app_chooser_button_get_show_default_item(byval self as GtkAppChooserButton ptr) as gboolean

#define __GTK_APPLICATION_WINDOW_H__
#define GTK_TYPE_APPLICATION_WINDOW gtk_application_window_get_type()
#define GTK_APPLICATION_WINDOW(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), GTK_TYPE_APPLICATION_WINDOW, GtkApplicationWindow)
#define GTK_APPLICATION_WINDOW_CLASS(class) G_TYPE_CHECK_CLASS_CAST((class), GTK_TYPE_APPLICATION_WINDOW, GtkApplicationWindowClass)
#define GTK_IS_APPLICATION_WINDOW(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), GTK_TYPE_APPLICATION_WINDOW)
#define GTK_IS_APPLICATION_WINDOW_CLASS(class) G_TYPE_CHECK_CLASS_TYPE((class), GTK_TYPE_APPLICATION_WINDOW)
#define GTK_APPLICATION_WINDOW_GET_CLASS(inst) G_TYPE_INSTANCE_GET_CLASS((inst), GTK_TYPE_APPLICATION_WINDOW, GtkApplicationWindowClass)

type GtkApplicationWindowPrivate as _GtkApplicationWindowPrivate
type GtkApplicationWindowClass as _GtkApplicationWindowClass
type GtkApplicationWindow as _GtkApplicationWindow

type _GtkApplicationWindow
	parent_instance as GtkWindow
	priv as GtkApplicationWindowPrivate ptr
end type

type _GtkApplicationWindowClass
	parent_class as GtkWindowClass
	padding(0 to 13) as gpointer
end type

declare function gtk_application_window_get_type() as GType
declare function gtk_application_window_new(byval application as GtkApplication ptr) as GtkWidget ptr
declare sub gtk_application_window_set_show_menubar(byval window as GtkApplicationWindow ptr, byval show_menubar as gboolean)
declare function gtk_application_window_get_show_menubar(byval window as GtkApplicationWindow ptr) as gboolean
declare function gtk_application_window_get_id(byval window as GtkApplicationWindow ptr) as guint

#define __GTK_ASPECT_FRAME_H__
#define __GTK_FRAME_H__
#define GTK_TYPE_FRAME gtk_frame_get_type()
#define GTK_FRAME(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FRAME, GtkFrame)
#define GTK_FRAME_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FRAME, GtkFrameClass)
#define GTK_IS_FRAME(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FRAME)
#define GTK_IS_FRAME_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FRAME)
#define GTK_FRAME_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FRAME, GtkFrameClass)

type GtkFrame as _GtkFrame
type GtkFramePrivate as _GtkFramePrivate
type GtkFrameClass as _GtkFrameClass

type _GtkFrame
	bin as GtkBin
	priv as GtkFramePrivate ptr
end type

type _GtkFrameClass
	parent_class as GtkBinClass
	compute_child_allocation as sub(byval frame as GtkFrame ptr, byval allocation as GtkAllocation ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
type GtkAspectFramePrivate as _GtkAspectFramePrivate
type GtkAspectFrameClass as _GtkAspectFrameClass

type _GtkAspectFrame
	frame as GtkFrame
	priv as GtkAspectFramePrivate ptr
end type

type _GtkAspectFrameClass
	parent_class as GtkFrameClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
	GTK_ASSISTANT_PAGE_CUSTOM
end enum

type GtkAssistant as _GtkAssistant
type GtkAssistantPrivate as _GtkAssistantPrivate
type GtkAssistantClass as _GtkAssistantClass

type _GtkAssistant
	parent as GtkWindow
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
declare sub gtk_assistant_next_page(byval assistant as GtkAssistant ptr)
declare sub gtk_assistant_previous_page(byval assistant as GtkAssistant ptr)
declare function gtk_assistant_get_current_page(byval assistant as GtkAssistant ptr) as gint
declare sub gtk_assistant_set_current_page(byval assistant as GtkAssistant ptr, byval page_num as gint)
declare function gtk_assistant_get_n_pages(byval assistant as GtkAssistant ptr) as gint
declare function gtk_assistant_get_nth_page(byval assistant as GtkAssistant ptr, byval page_num as gint) as GtkWidget ptr
declare function gtk_assistant_prepend_page(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as gint
declare function gtk_assistant_append_page(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr) as gint
declare function gtk_assistant_insert_page(byval assistant as GtkAssistant ptr, byval page as GtkWidget ptr, byval position as gint) as gint
declare sub gtk_assistant_remove_page(byval assistant as GtkAssistant ptr, byval page_num as gint)
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
#define GTK_TYPE_BUTTON_BOX gtk_button_box_get_type()
#define GTK_BUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUTTON_BOX, GtkButtonBox)
#define GTK_BUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass)
#define GTK_IS_BUTTON_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUTTON_BOX)
#define GTK_IS_BUTTON_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BUTTON_BOX)
#define GTK_BUTTON_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass)

type GtkButtonBox as _GtkButtonBox
type GtkButtonBoxPrivate as _GtkButtonBoxPrivate
type GtkButtonBoxClass as _GtkButtonBoxClass

type _GtkButtonBox
	box as GtkBox
	priv as GtkButtonBoxPrivate ptr
end type

type _GtkButtonBoxClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type GtkButtonBoxStyle as long
enum
	GTK_BUTTONBOX_SPREAD = 1
	GTK_BUTTONBOX_EDGE
	GTK_BUTTONBOX_START
	GTK_BUTTONBOX_END
	GTK_BUTTONBOX_CENTER
	GTK_BUTTONBOX_EXPAND
end enum

declare function gtk_button_box_get_type() as GType
declare function gtk_button_box_new(byval orientation as GtkOrientation) as GtkWidget ptr
declare function gtk_button_box_get_layout(byval widget as GtkButtonBox ptr) as GtkButtonBoxStyle
declare sub gtk_button_box_set_layout(byval widget as GtkButtonBox ptr, byval layout_style as GtkButtonBoxStyle)
declare function gtk_button_box_get_child_secondary(byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_button_box_set_child_secondary(byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr, byval is_secondary as gboolean)
declare function gtk_button_box_get_child_non_homogeneous(byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_button_box_set_child_non_homogeneous(byval widget as GtkButtonBox ptr, byval child as GtkWidget ptr, byval non_homogeneous as gboolean)
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
declare function gtk_bindings_activate(byval object as GObject ptr, byval keyval as guint, byval modifiers as GdkModifierType) as gboolean
declare function gtk_bindings_activate_event(byval object as GObject ptr, byval event as GdkEventKey ptr) as gboolean
declare function gtk_binding_set_activate(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval object as GObject ptr) as gboolean
declare sub gtk_binding_entry_skip(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gtk_binding_entry_add_signal(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as const gchar ptr, byval n_args as guint, ...)
declare sub gtk_binding_entry_add_signall(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType, byval signal_name as const gchar ptr, byval binding_args as GSList ptr)
declare function gtk_binding_entry_add_signal_from_string(byval binding_set as GtkBindingSet ptr, byval signal_desc as const gchar ptr) as GTokenType
declare sub gtk_binding_entry_remove(byval binding_set as GtkBindingSet ptr, byval keyval as guint, byval modifiers as GdkModifierType)

#define __GTK_BUILDABLE_H__
#define __GTK_BUILDER_H__
#define GTK_TYPE_BUILDER gtk_builder_get_type()
#define GTK_BUILDER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUILDER, GtkBuilder)
#define GTK_BUILDER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BUILDER, GtkBuilderClass)
#define GTK_IS_BUILDER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUILDER)
#define GTK_IS_BUILDER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BUILDER)
#define GTK_BUILDER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BUILDER, GtkBuilderClass)
#define GTK_BUILDER_ERROR gtk_builder_error_quark()
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
	GTK_BUILDER_ERROR_OBJECT_TYPE_REFUSED
	GTK_BUILDER_ERROR_TEMPLATE_MISMATCH
	GTK_BUILDER_ERROR_INVALID_PROPERTY
	GTK_BUILDER_ERROR_INVALID_SIGNAL
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

declare function gtk_builder_get_type() as GType
declare function gtk_builder_new() as GtkBuilder ptr
declare function gtk_builder_add_from_file(byval builder as GtkBuilder ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_from_resource(byval builder as GtkBuilder ptr, byval resource_path as const gchar ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_from_string(byval builder as GtkBuilder ptr, byval buffer as const gchar ptr, byval length as gsize, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_objects_from_file(byval builder as GtkBuilder ptr, byval filename as const gchar ptr, byval object_ids as gchar ptr ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_objects_from_resource(byval builder as GtkBuilder ptr, byval resource_path as const gchar ptr, byval object_ids as gchar ptr ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_add_objects_from_string(byval builder as GtkBuilder ptr, byval buffer as const gchar ptr, byval length as gsize, byval object_ids as gchar ptr ptr, byval error as GError ptr ptr) as guint
declare function gtk_builder_get_object(byval builder as GtkBuilder ptr, byval name as const gchar ptr) as GObject ptr
declare function gtk_builder_get_objects(byval builder as GtkBuilder ptr) as GSList ptr
declare sub gtk_builder_expose_object(byval builder as GtkBuilder ptr, byval name as const gchar ptr, byval object as GObject ptr)
declare sub gtk_builder_connect_signals(byval builder as GtkBuilder ptr, byval user_data as gpointer)
declare sub gtk_builder_connect_signals_full(byval builder as GtkBuilder ptr, byval func as GtkBuilderConnectFunc, byval user_data as gpointer)
declare sub gtk_builder_set_translation_domain(byval builder as GtkBuilder ptr, byval domain as const gchar ptr)
declare function gtk_builder_get_translation_domain(byval builder as GtkBuilder ptr) as const gchar ptr
declare function gtk_builder_get_type_from_name(byval builder as GtkBuilder ptr, byval type_name as const zstring ptr) as GType
declare function gtk_builder_value_from_string(byval builder as GtkBuilder ptr, byval pspec as GParamSpec ptr, byval string as const gchar ptr, byval value as GValue ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_builder_value_from_string_type(byval builder as GtkBuilder ptr, byval type as GType, byval string as const gchar ptr, byval value as GValue ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_builder_new_from_file(byval filename as const gchar ptr) as GtkBuilder ptr
declare function gtk_builder_new_from_resource(byval resource_path as const gchar ptr) as GtkBuilder ptr
declare function gtk_builder_new_from_string(byval string as const gchar ptr, byval length as gssize) as GtkBuilder ptr
declare sub gtk_builder_add_callback_symbol(byval builder as GtkBuilder ptr, byval callback_name as const gchar ptr, byval callback_symbol as GCallback)
declare sub gtk_builder_add_callback_symbols(byval builder as GtkBuilder ptr, byval first_callback_name as const gchar ptr, byval first_callback_symbol as GCallback, ...)
declare function gtk_builder_lookup_callback_symbol(byval builder as GtkBuilder ptr, byval callback_name as const gchar ptr) as GCallback
declare sub gtk_builder_set_application(byval builder as GtkBuilder ptr, byval application as GtkApplication ptr)
declare function gtk_builder_get_application(byval builder as GtkBuilder ptr) as GtkApplication ptr

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
#define GTK_TYPE_BUTTON gtk_button_get_type()
#define GTK_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_BUTTON, GtkButton)
#define GTK_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_BUTTON, GtkButtonClass)
#define GTK_IS_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_BUTTON)
#define GTK_IS_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_BUTTON)
#define GTK_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_BUTTON, GtkButtonClass)

type GtkButton as _GtkButton
type GtkButtonPrivate as _GtkButtonPrivate
type GtkButtonClass as _GtkButtonClass

type _GtkButton
	bin as GtkBin
	priv as GtkButtonPrivate ptr
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
declare function gtk_button_new_from_icon_name(byval icon_name as const gchar ptr, byval size as GtkIconSize) as GtkWidget ptr
declare function gtk_button_new_from_stock(byval stock_id as const gchar ptr) as GtkWidget ptr
declare function gtk_button_new_with_mnemonic(byval label as const gchar ptr) as GtkWidget ptr
declare sub gtk_button_clicked(byval button as GtkButton ptr)
declare sub gtk_button_pressed(byval button as GtkButton ptr)
declare sub gtk_button_released(byval button as GtkButton ptr)
declare sub gtk_button_enter(byval button as GtkButton ptr)
declare sub gtk_button_leave(byval button as GtkButton ptr)
declare sub gtk_button_set_relief(byval button as GtkButton ptr, byval relief as GtkReliefStyle)
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
declare sub gtk_button_set_always_show_image(byval button as GtkButton ptr, byval always_show as gboolean)
declare function gtk_button_get_always_show_image(byval button as GtkButton ptr) as gboolean
declare function gtk_button_get_event_window(byval button as GtkButton ptr) as GdkWindow ptr

#define __GTK_CALENDAR_H__
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
	GTK_CALENDAR_SHOW_DETAILS = 1 shl 5
end enum

type GtkCalendarDetailFunc as function(byval calendar as GtkCalendar ptr, byval year as guint, byval month as guint, byval day as guint, byval user_data as gpointer) as gchar ptr

type _GtkCalendar
	widget as GtkWidget
	priv as GtkCalendarPrivate ptr
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_calendar_get_type() as GType
declare function gtk_calendar_new() as GtkWidget ptr
declare sub gtk_calendar_select_month(byval calendar as GtkCalendar ptr, byval month as guint, byval year as guint)
declare sub gtk_calendar_select_day(byval calendar as GtkCalendar ptr, byval day as guint)
declare sub gtk_calendar_mark_day(byval calendar as GtkCalendar ptr, byval day as guint)
declare sub gtk_calendar_unmark_day(byval calendar as GtkCalendar ptr, byval day as guint)
declare sub gtk_calendar_clear_marks(byval calendar as GtkCalendar ptr)
declare sub gtk_calendar_set_display_options(byval calendar as GtkCalendar ptr, byval flags as GtkCalendarDisplayOptions)
declare function gtk_calendar_get_display_options(byval calendar as GtkCalendar ptr) as GtkCalendarDisplayOptions
declare sub gtk_calendar_get_date(byval calendar as GtkCalendar ptr, byval year as guint ptr, byval month as guint ptr, byval day as guint ptr)
declare sub gtk_calendar_set_detail_func(byval calendar as GtkCalendar ptr, byval func as GtkCalendarDetailFunc, byval data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_calendar_set_detail_width_chars(byval calendar as GtkCalendar ptr, byval chars as gint)
declare sub gtk_calendar_set_detail_height_rows(byval calendar as GtkCalendar ptr, byval rows as gint)
declare function gtk_calendar_get_detail_width_chars(byval calendar as GtkCalendar ptr) as gint
declare function gtk_calendar_get_detail_height_rows(byval calendar as GtkCalendar ptr) as gint
declare function gtk_calendar_get_day_is_marked(byval calendar as GtkCalendar ptr, byval day as guint) as gboolean

#define __GTK_CELL_AREA_BOX_H__
#define GTK_TYPE_CELL_AREA_BOX gtk_cell_area_box_get_type()
#define GTK_CELL_AREA_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_AREA_BOX, GtkCellAreaBox)
#define GTK_CELL_AREA_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_AREA_BOX, GtkCellAreaBoxClass)
#define GTK_IS_CELL_AREA_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_AREA_BOX)
#define GTK_IS_CELL_AREA_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_AREA_BOX)
#define GTK_CELL_AREA_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_AREA_BOX, GtkCellAreaBoxClass)

type GtkCellAreaBox as _GtkCellAreaBox
type GtkCellAreaBoxClass as _GtkCellAreaBoxClass
type GtkCellAreaBoxPrivate as _GtkCellAreaBoxPrivate

type _GtkCellAreaBox
	parent_instance as GtkCellArea
	priv as GtkCellAreaBoxPrivate ptr
end type

type _GtkCellAreaBoxClass
	parent_class as GtkCellAreaClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_area_box_get_type() as GType
declare function gtk_cell_area_box_new() as GtkCellArea ptr
declare sub gtk_cell_area_box_pack_start(byval box as GtkCellAreaBox ptr, byval renderer as GtkCellRenderer ptr, byval expand as gboolean, byval align as gboolean, byval fixed as gboolean)
declare sub gtk_cell_area_box_pack_end(byval box as GtkCellAreaBox ptr, byval renderer as GtkCellRenderer ptr, byval expand as gboolean, byval align as gboolean, byval fixed as gboolean)
declare function gtk_cell_area_box_get_spacing(byval box as GtkCellAreaBox ptr) as gint
declare sub gtk_cell_area_box_set_spacing(byval box as GtkCellAreaBox ptr, byval spacing as gint)
declare function _gtk_cell_area_box_group_visible(byval box as GtkCellAreaBox ptr, byval group_idx as gint) as gboolean

#define __GTK_CELL_AREA_CONTEXT_H__
#define GTK_TYPE_CELL_AREA_CONTEXT gtk_cell_area_context_get_type()
#define GTK_CELL_AREA_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CELL_AREA_CONTEXT, GtkCellAreaContext)
#define GTK_CELL_AREA_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CELL_AREA_CONTEXT, GtkCellAreaContextClass)
#define GTK_IS_CELL_AREA_CONTEXT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CELL_AREA_CONTEXT)
#define GTK_IS_CELL_AREA_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CELL_AREA_CONTEXT)
#define GTK_CELL_AREA_CONTEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CELL_AREA_CONTEXT, GtkCellAreaContextClass)
type GtkCellAreaContextPrivate as _GtkCellAreaContextPrivate
type GtkCellAreaContextClass as _GtkCellAreaContextClass

type _GtkCellAreaContext
	parent_instance as GObject
	priv as GtkCellAreaContextPrivate ptr
end type

type _GtkCellAreaContextClass
	parent_class as GObjectClass
	allocate as sub(byval context as GtkCellAreaContext ptr, byval width as gint, byval height as gint)
	reset as sub(byval context as GtkCellAreaContext ptr)
	get_preferred_height_for_width as sub(byval context as GtkCellAreaContext ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
	get_preferred_width_for_height as sub(byval context as GtkCellAreaContext ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
end type

declare function gtk_cell_area_context_get_type() as GType
declare function gtk_cell_area_context_get_area(byval context as GtkCellAreaContext ptr) as GtkCellArea ptr
declare sub gtk_cell_area_context_allocate(byval context as GtkCellAreaContext ptr, byval width as gint, byval height as gint)
declare sub gtk_cell_area_context_reset(byval context as GtkCellAreaContext ptr)
declare sub gtk_cell_area_context_get_preferred_width(byval context as GtkCellAreaContext ptr, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare sub gtk_cell_area_context_get_preferred_height(byval context as GtkCellAreaContext ptr, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_cell_area_context_get_preferred_height_for_width(byval context as GtkCellAreaContext ptr, byval width as gint, byval minimum_height as gint ptr, byval natural_height as gint ptr)
declare sub gtk_cell_area_context_get_preferred_width_for_height(byval context as GtkCellAreaContext ptr, byval height as gint, byval minimum_width as gint ptr, byval natural_width as gint ptr)
declare sub gtk_cell_area_context_get_allocation(byval context as GtkCellAreaContext ptr, byval width as gint ptr, byval height as gint ptr)
declare sub gtk_cell_area_context_push_preferred_width(byval context as GtkCellAreaContext ptr, byval minimum_width as gint, byval natural_width as gint)
declare sub gtk_cell_area_context_push_preferred_height(byval context as GtkCellAreaContext ptr, byval minimum_height as gint, byval natural_height as gint)

#define __GTK_CELL_LAYOUT_H__
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
	get_area as function(byval cell_layout as GtkCellLayout ptr) as GtkCellArea ptr
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
declare function gtk_cell_layout_get_area(byval cell_layout as GtkCellLayout ptr) as GtkCellArea ptr
declare function _gtk_cell_layout_buildable_custom_tag_start(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval parser as GMarkupParser ptr, byval data as gpointer ptr) as gboolean
declare function _gtk_cell_layout_buildable_custom_tag_end(byval buildable as GtkBuildable ptr, byval builder as GtkBuilder ptr, byval child as GObject ptr, byval tagname as const gchar ptr, byval data as gpointer ptr) as gboolean
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
type GtkCellRendererTextPrivate as _GtkCellRendererTextPrivate
type GtkCellRendererTextClass as _GtkCellRendererTextClass

type _GtkCellRendererText
	parent as GtkCellRenderer
	priv as GtkCellRendererTextPrivate ptr
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
type GtkCellRendererAccelPrivate as _GtkCellRendererAccelPrivate
type GtkCellRendererAccelClass as _GtkCellRendererAccelClass

type GtkCellRendererAccelMode as long
enum
	GTK_CELL_RENDERER_ACCEL_MODE_GTK
	GTK_CELL_RENDERER_ACCEL_MODE_OTHER
end enum

type _GtkCellRendererAccel
	parent as GtkCellRendererText
	priv as GtkCellRendererAccelPrivate ptr
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
type GtkCellRendererComboPrivate as _GtkCellRendererComboPrivate
type GtkCellRendererComboClass as _GtkCellRendererComboClass

type _GtkCellRendererCombo
	parent as GtkCellRendererText
	priv as GtkCellRendererComboPrivate ptr
end type

type _GtkCellRendererComboClass
	parent as GtkCellRendererTextClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
type GtkCellRendererPixbufPrivate as _GtkCellRendererPixbufPrivate
type GtkCellRendererPixbufClass as _GtkCellRendererPixbufClass

type _GtkCellRendererPixbuf
	parent as GtkCellRenderer
	priv as GtkCellRendererPixbufPrivate ptr
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
	priv as GtkCellRendererSpinPrivate ptr
end type

type _GtkCellRendererSpinClass
	parent as GtkCellRendererTextClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
type GtkCellRendererTogglePrivate as _GtkCellRendererTogglePrivate
type GtkCellRendererToggleClass as _GtkCellRendererToggleClass

type _GtkCellRendererToggle
	parent as GtkCellRenderer
	priv as GtkCellRendererTogglePrivate ptr
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_cell_view_get_type() as GType
declare function gtk_cell_view_new() as GtkWidget ptr
declare function gtk_cell_view_new_with_context(byval area as GtkCellArea ptr, byval context as GtkCellAreaContext ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_text(byval text as const gchar ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_markup(byval markup as const gchar ptr) as GtkWidget ptr
declare function gtk_cell_view_new_with_pixbuf(byval pixbuf as GdkPixbuf ptr) as GtkWidget ptr
declare sub gtk_cell_view_set_model(byval cell_view as GtkCellView ptr, byval model as GtkTreeModel ptr)
declare function gtk_cell_view_get_model(byval cell_view as GtkCellView ptr) as GtkTreeModel ptr
declare sub gtk_cell_view_set_displayed_row(byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr)
declare function gtk_cell_view_get_displayed_row(byval cell_view as GtkCellView ptr) as GtkTreePath ptr
declare sub gtk_cell_view_set_background_rgba(byval cell_view as GtkCellView ptr, byval rgba_ as const GdkRGBA ptr)
declare function gtk_cell_view_get_draw_sensitive(byval cell_view as GtkCellView ptr) as gboolean
declare sub gtk_cell_view_set_draw_sensitive(byval cell_view as GtkCellView ptr, byval draw_sensitive as gboolean)
declare function gtk_cell_view_get_fit_model(byval cell_view as GtkCellView ptr) as gboolean
declare sub gtk_cell_view_set_fit_model(byval cell_view as GtkCellView ptr, byval fit_model as gboolean)
declare function gtk_cell_view_get_size_of_row(byval cell_view as GtkCellView ptr, byval path as GtkTreePath ptr, byval requisition as GtkRequisition ptr) as gboolean
declare sub gtk_cell_view_set_background_color(byval cell_view as GtkCellView ptr, byval color as const GdkColor ptr)

#define __GTK_CHECK_BUTTON_H__
#define __GTK_TOGGLE_BUTTON_H__
#define GTK_TYPE_TOGGLE_BUTTON gtk_toggle_button_get_type()
#define GTK_TOGGLE_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButton)
#define GTK_TOGGLE_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass)
#define GTK_IS_TOGGLE_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOGGLE_BUTTON)
#define GTK_IS_TOGGLE_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOGGLE_BUTTON)
#define GTK_TOGGLE_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass)

type GtkToggleButton as _GtkToggleButton
type GtkToggleButtonPrivate as _GtkToggleButtonPrivate
type GtkToggleButtonClass as _GtkToggleButtonClass

type _GtkToggleButton
	button as GtkButton
	priv as GtkToggleButtonPrivate ptr
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
	draw_indicator as sub(byval check_button as GtkCheckButton ptr, byval cr as cairo_t ptr)
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
#define GTK_TYPE_MENU_ITEM gtk_menu_item_get_type()
#define GTK_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU_ITEM, GtkMenuItem)
#define GTK_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU_ITEM, GtkMenuItemClass)
#define GTK_IS_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU_ITEM)
#define GTK_IS_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU_ITEM)
#define GTK_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU_ITEM, GtkMenuItemClass)

type GtkMenuItem as _GtkMenuItem
type GtkMenuItemClass as _GtkMenuItemClass
type GtkMenuItemPrivate as _GtkMenuItemPrivate

type _GtkMenuItem
	bin as GtkBin
	priv as GtkMenuItemPrivate ptr
end type

type _GtkMenuItemClass
	parent_class as GtkBinClass
	hide_on_activate : 1 as guint
	activate as sub(byval menu_item as GtkMenuItem ptr)
	activate_item as sub(byval menu_item as GtkMenuItem ptr)
	toggle_size_request as sub(byval menu_item as GtkMenuItem ptr, byval requisition as gint ptr)
	toggle_size_allocate as sub(byval menu_item as GtkMenuItem ptr, byval allocation as gint)
	set_label as sub(byval menu_item as GtkMenuItem ptr, byval label as const gchar ptr)
	get_label as function(byval menu_item as GtkMenuItem ptr) as const gchar ptr
	select as sub(byval menu_item as GtkMenuItem ptr)
	deselect as sub(byval menu_item as GtkMenuItem ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_menu_item_set_reserve_indicator(byval menu_item as GtkMenuItem ptr, byval reserve as gboolean)
declare function gtk_menu_item_get_reserve_indicator(byval menu_item as GtkMenuItem ptr) as gboolean

#define GTK_TYPE_CHECK_MENU_ITEM gtk_check_menu_item_get_type()
#define GTK_CHECK_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItem)
#define GTK_CHECK_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass)
#define GTK_IS_CHECK_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_CHECK_MENU_ITEM)
#define GTK_IS_CHECK_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_CHECK_MENU_ITEM)
#define GTK_CHECK_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass)

type GtkCheckMenuItem as _GtkCheckMenuItem
type GtkCheckMenuItemPrivate as _GtkCheckMenuItemPrivate
type GtkCheckMenuItemClass as _GtkCheckMenuItemClass

type _GtkCheckMenuItem
	menu_item as GtkMenuItem
	priv as GtkCheckMenuItemPrivate ptr
end type

type _GtkCheckMenuItemClass
	parent_class as GtkMenuItemClass
	toggled as sub(byval check_menu_item as GtkCheckMenuItem ptr)
	draw_indicator as sub(byval check_menu_item as GtkCheckMenuItem ptr, byval cr as cairo_t ptr)
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
declare sub _gtk_check_menu_item_set_active(byval check_menu_item as GtkCheckMenuItem ptr, byval is_active as gboolean)

#define __GTK_CLIPBOARD_H__
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
declare function gtk_clipboard_get_default(byval display as GdkDisplay ptr) as GtkClipboard ptr
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
declare function gtk_color_button_new_with_rgba(byval rgba_ as const GdkRGBA ptr) as GtkWidget ptr
declare sub gtk_color_button_set_title(byval button as GtkColorButton ptr, byval title as const gchar ptr)
declare function gtk_color_button_get_title(byval button as GtkColorButton ptr) as const gchar ptr
declare function gtk_color_button_new_with_color(byval color as const GdkColor ptr) as GtkWidget ptr
declare sub gtk_color_button_set_color(byval button as GtkColorButton ptr, byval color as const GdkColor ptr)
declare sub gtk_color_button_get_color(byval button as GtkColorButton ptr, byval color as GdkColor ptr)
declare sub gtk_color_button_set_alpha(byval button as GtkColorButton ptr, byval alpha as guint16)
declare function gtk_color_button_get_alpha(byval button as GtkColorButton ptr) as guint16
declare sub gtk_color_button_set_use_alpha(byval button as GtkColorButton ptr, byval use_alpha as gboolean)
declare function gtk_color_button_get_use_alpha(byval button as GtkColorButton ptr) as gboolean
declare sub gtk_color_button_set_rgba(byval button as GtkColorButton ptr, byval rgba_ as const GdkRGBA ptr)
declare sub gtk_color_button_get_rgba(byval button as GtkColorButton ptr, byval rgba_ as GdkRGBA ptr)

#define __GTK_COLOR_CHOOSER_H__
#define GTK_TYPE_COLOR_CHOOSER gtk_color_chooser_get_type()
#define GTK_COLOR_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_CHOOSER, GtkColorChooser)
#define GTK_IS_COLOR_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_CHOOSER)
#define GTK_COLOR_CHOOSER_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_COLOR_CHOOSER, GtkColorChooserInterface)
type GtkColorChooser as _GtkColorChooser
type GtkColorChooserInterface as _GtkColorChooserInterface

type _GtkColorChooserInterface
	base_interface as GTypeInterface
	get_rgba as sub(byval chooser as GtkColorChooser ptr, byval color as GdkRGBA ptr)
	set_rgba as sub(byval chooser as GtkColorChooser ptr, byval color as const GdkRGBA ptr)
	add_palette as sub(byval chooser as GtkColorChooser ptr, byval orientation as GtkOrientation, byval colors_per_line as gint, byval n_colors as gint, byval colors as GdkRGBA ptr)
	color_activated as sub(byval chooser as GtkColorChooser ptr, byval color as const GdkRGBA ptr)
	padding(0 to 11) as gpointer
end type

declare function gtk_color_chooser_get_type() as GType
declare sub gtk_color_chooser_get_rgba(byval chooser as GtkColorChooser ptr, byval color as GdkRGBA ptr)
declare sub gtk_color_chooser_set_rgba(byval chooser as GtkColorChooser ptr, byval color as const GdkRGBA ptr)
declare function gtk_color_chooser_get_use_alpha(byval chooser as GtkColorChooser ptr) as gboolean
declare sub gtk_color_chooser_set_use_alpha(byval chooser as GtkColorChooser ptr, byval use_alpha as gboolean)
declare sub gtk_color_chooser_add_palette(byval chooser as GtkColorChooser ptr, byval orientation as GtkOrientation, byval colors_per_line as gint, byval n_colors as gint, byval colors as GdkRGBA ptr)

#define __GTK_COLOR_CHOOSER_DIALOG_H__
#define GTK_TYPE_COLOR_CHOOSER_DIALOG gtk_color_chooser_dialog_get_type()
#define GTK_COLOR_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_CHOOSER_DIALOG, GtkColorChooserDialog)
#define GTK_COLOR_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_CHOOSER_DIALOG, GtkColorChooserDialogClass)
#define GTK_IS_COLOR_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_CHOOSER_DIALOG)
#define GTK_IS_COLOR_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_CHOOSER_DIALOG)
#define GTK_COLOR_CHOOSER_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_CHOOSER_DIALOG, GtkColorChooserDialogClass)

type GtkColorChooserDialog as _GtkColorChooserDialog
type GtkColorChooserDialogPrivate as _GtkColorChooserDialogPrivate
type GtkColorChooserDialogClass as _GtkColorChooserDialogClass

type _GtkColorChooserDialog
	parent_instance as GtkDialog
	priv as GtkColorChooserDialogPrivate ptr
end type

type _GtkColorChooserDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_color_chooser_dialog_get_type() as GType
declare function gtk_color_chooser_dialog_new(byval title as const gchar ptr, byval parent as GtkWindow ptr) as GtkWidget ptr
#define __GTK_COLOR_CHOOSER_WIDGET_H__
#define GTK_TYPE_COLOR_CHOOSER_WIDGET gtk_color_chooser_widget_get_type()
#define GTK_COLOR_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_CHOOSER_WIDGET, GtkColorChooserWidget)
#define GTK_COLOR_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_CHOOSER_WIDGET, GtkColorChooserWidgetClass)
#define GTK_IS_COLOR_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_CHOOSER_WIDGET)
#define GTK_IS_COLOR_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_CHOOSER_WIDGET)
#define GTK_COLOR_CHOOSER_WIDGET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_CHOOSER_WIDGET, GtkColorChooserWidgetClass)

type GtkColorChooserWidget as _GtkColorChooserWidget
type GtkColorChooserWidgetPrivate as _GtkColorChooserWidgetPrivate
type GtkColorChooserWidgetClass as _GtkColorChooserWidgetClass

type _GtkColorChooserWidget
	parent_instance as GtkBox
	priv as GtkColorChooserWidgetPrivate ptr
end type

type _GtkColorChooserWidgetClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

declare function gtk_color_chooser_widget_get_type() as GType
declare function gtk_color_chooser_widget_new() as GtkWidget ptr
#define __GTK_COLOR_UTILS_H__
declare sub gtk_hsv_to_rgb(byval h as gdouble, byval s as gdouble, byval v as gdouble, byval r as gdouble ptr, byval g as gdouble ptr, byval b as gdouble ptr)
declare sub gtk_rgb_to_hsv(byval r as gdouble, byval g as gdouble, byval b as gdouble, byval h as gdouble ptr, byval s as gdouble ptr, byval v as gdouble ptr)
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
declare sub gtk_combo_box_text_remove_all(byval combo_box as GtkComboBoxText ptr)
declare function gtk_combo_box_text_get_active_text(byval combo_box as GtkComboBoxText ptr) as gchar ptr
declare sub gtk_combo_box_text_insert(byval combo_box as GtkComboBoxText ptr, byval position as gint, byval id as const gchar ptr, byval text as const gchar ptr)
declare sub gtk_combo_box_text_append(byval combo_box as GtkComboBoxText ptr, byval id as const gchar ptr, byval text as const gchar ptr)
declare sub gtk_combo_box_text_prepend(byval combo_box as GtkComboBoxText ptr, byval id as const gchar ptr, byval text as const gchar ptr)

#define __GTK_CSS_PROVIDER_H__
#define __GTK_CSS_SECTION_H__
#define GTK_TYPE_CSS_SECTION gtk_css_section_get_type()

type GtkCssSectionType as long
enum
	GTK_CSS_SECTION_DOCUMENT
	GTK_CSS_SECTION_IMPORT
	GTK_CSS_SECTION_COLOR_DEFINITION
	GTK_CSS_SECTION_BINDING_SET
	GTK_CSS_SECTION_RULESET
	GTK_CSS_SECTION_SELECTOR
	GTK_CSS_SECTION_DECLARATION
	GTK_CSS_SECTION_VALUE
	GTK_CSS_SECTION_KEYFRAMES
end enum

type GtkCssSection as _GtkCssSection
declare function gtk_css_section_get_type() as GType
declare function gtk_css_section_ref(byval section as GtkCssSection ptr) as GtkCssSection ptr
declare sub gtk_css_section_unref(byval section as GtkCssSection ptr)
declare function gtk_css_section_get_section_type(byval section as const GtkCssSection ptr) as GtkCssSectionType
declare function gtk_css_section_get_parent(byval section as const GtkCssSection ptr) as GtkCssSection ptr
declare function gtk_css_section_get_file(byval section as const GtkCssSection ptr) as GFile ptr
declare function gtk_css_section_get_start_line(byval section as const GtkCssSection ptr) as guint
declare function gtk_css_section_get_start_position(byval section as const GtkCssSection ptr) as guint
declare function gtk_css_section_get_end_line(byval section as const GtkCssSection ptr) as guint
declare function gtk_css_section_get_end_position(byval section as const GtkCssSection ptr) as guint

#define GTK_TYPE_CSS_PROVIDER gtk_css_provider_get_type()
#define GTK_CSS_PROVIDER(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_CSS_PROVIDER, GtkCssProvider)
#define GTK_CSS_PROVIDER_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_CSS_PROVIDER, GtkCssProviderClass)
#define GTK_IS_CSS_PROVIDER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_CSS_PROVIDER)
#define GTK_IS_CSS_PROVIDER_CLASS(c) G_TYPE_CHECK_CLASS_TYPE((c), GTK_TYPE_CSS_PROVIDER)
#define GTK_CSS_PROVIDER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_CSS_PROVIDER, GtkCssProviderClass)
#define GTK_CSS_PROVIDER_ERROR gtk_css_provider_error_quark()

type GtkCssProviderError as long
enum
	GTK_CSS_PROVIDER_ERROR_FAILED
	GTK_CSS_PROVIDER_ERROR_SYNTAX
	GTK_CSS_PROVIDER_ERROR_IMPORT
	GTK_CSS_PROVIDER_ERROR_NAME
	GTK_CSS_PROVIDER_ERROR_DEPRECATED
	GTK_CSS_PROVIDER_ERROR_UNKNOWN_VALUE
end enum

declare function gtk_css_provider_error_quark() as GQuark
type GtkCssProvider as _GtkCssProvider
type GtkCssProviderClass as _GtkCssProviderClass
type GtkCssProviderPrivate as _GtkCssProviderPrivate

type _GtkCssProvider
	parent_instance as GObject
	priv as GtkCssProviderPrivate ptr
end type

type _GtkCssProviderClass
	parent_class as GObjectClass
	parsing_error as sub(byval provider as GtkCssProvider ptr, byval section as GtkCssSection ptr, byval error as const GError ptr)
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_css_provider_get_type() as GType
declare function gtk_css_provider_new() as GtkCssProvider ptr
declare function gtk_css_provider_to_string(byval provider as GtkCssProvider ptr) as zstring ptr
declare function gtk_css_provider_load_from_data(byval css_provider as GtkCssProvider ptr, byval data as const gchar ptr, byval length as gssize, byval error as GError ptr ptr) as gboolean
declare function gtk_css_provider_load_from_file(byval css_provider as GtkCssProvider ptr, byval file as GFile ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_css_provider_load_from_path(byval css_provider as GtkCssProvider ptr, byval path as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare sub gtk_css_provider_load_from_resource(byval css_provider as GtkCssProvider ptr, byval resource_path as const gchar ptr)
declare function gtk_css_provider_get_default() as GtkCssProvider ptr
declare function gtk_css_provider_get_named(byval name as const gchar ptr, byval variant as const gchar ptr) as GtkCssProvider ptr
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
	GTK_DEBUG_SIZE_REQUEST = 1 shl 12
	GTK_DEBUG_NO_CSS_CACHE = 1 shl 13
	GTK_DEBUG_BASELINES = 1 shl 14
	GTK_DEBUG_PIXEL_CACHE = 1 shl 15
	GTK_DEBUG_NO_PIXEL_CACHE = 1 shl 16
	GTK_DEBUG_INTERACTIVE = 1 shl 17
	GTK_DEBUG_TOUCHSCREEN = 1 shl 18
	GTK_DEBUG_ACTIONS = 1 shl 19
end enum

#define GTK_NOTE(type, action)
declare function gtk_get_debug_flags() as guint
declare sub gtk_set_debug_flags(byval flags as guint)
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
	dummy as gpointer
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
#define __GTK_EVENT_BOX_H__
#define GTK_TYPE_EVENT_BOX gtk_event_box_get_type()
#define GTK_EVENT_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_EVENT_BOX, GtkEventBox)
#define GTK_EVENT_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_EVENT_BOX, GtkEventBoxClass)
#define GTK_IS_EVENT_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_EVENT_BOX)
#define GTK_IS_EVENT_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_EVENT_BOX)
#define GTK_EVENT_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_EVENT_BOX, GtkEventBoxClass)

type GtkEventBox as _GtkEventBox
type GtkEventBoxClass as _GtkEventBoxClass
type GtkEventBoxPrivate as _GtkEventBoxPrivate

type _GtkEventBox
	bin as GtkBin
	priv as GtkEventBoxPrivate ptr
end type

type _GtkEventBoxClass
	parent_class as GtkBinClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_event_box_get_type() as GType
declare function gtk_event_box_new() as GtkWidget ptr
declare function gtk_event_box_get_visible_window(byval event_box as GtkEventBox ptr) as gboolean
declare sub gtk_event_box_set_visible_window(byval event_box as GtkEventBox ptr, byval visible_window as gboolean)
declare function gtk_event_box_get_above_child(byval event_box as GtkEventBox ptr) as gboolean
declare sub gtk_event_box_set_above_child(byval event_box as GtkEventBox ptr, byval above_child as gboolean)
#define __GTK_EVENT_CONTROLLER_H__
type GtkEventController as _GtkEventController
type GtkEventControllerClass as _GtkEventControllerClass

#define GTK_TYPE_EVENT_CONTROLLER gtk_event_controller_get_type()
#define GTK_EVENT_CONTROLLER(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_EVENT_CONTROLLER, GtkEventController)
#define GTK_EVENT_CONTROLLER_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_EVENT_CONTROLLER, GtkEventControllerClass)
#define GTK_IS_EVENT_CONTROLLER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_EVENT_CONTROLLER)
#define GTK_IS_EVENT_CONTROLLER_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_EVENT_CONTROLLER)
#define GTK_EVENT_CONTROLLER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_EVENT_CONTROLLER, GtkEventControllerClass)

declare function gtk_event_controller_get_type() as GType
declare function gtk_event_controller_get_widget(byval controller as GtkEventController ptr) as GtkWidget ptr
declare function gtk_event_controller_handle_event(byval controller as GtkEventController ptr, byval event as const GdkEvent ptr) as gboolean
declare sub gtk_event_controller_reset(byval controller as GtkEventController ptr)
declare function gtk_event_controller_get_propagation_phase(byval controller as GtkEventController ptr) as GtkPropagationPhase
declare sub gtk_event_controller_set_propagation_phase(byval controller as GtkEventController ptr, byval phase as GtkPropagationPhase)

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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_expander_set_resize_toplevel(byval expander as GtkExpander ptr, byval resize_toplevel as gboolean)
declare function gtk_expander_get_resize_toplevel(byval expander as GtkExpander ptr) as gboolean

#define __GTK_FIXED_H__
#define GTK_TYPE_FIXED gtk_fixed_get_type()
#define GTK_FIXED(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FIXED, GtkFixed)
#define GTK_FIXED_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FIXED, GtkFixedClass)
#define GTK_IS_FIXED(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FIXED)
#define GTK_IS_FIXED_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FIXED)
#define GTK_FIXED_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FIXED, GtkFixedClass)

type GtkFixed as _GtkFixed
type GtkFixedPrivate as _GtkFixedPrivate
type GtkFixedClass as _GtkFixedClass
type GtkFixedChild as _GtkFixedChild

type _GtkFixed
	container as GtkContainer
	priv as GtkFixedPrivate ptr
end type

type _GtkFixedClass
	parent_class as GtkContainerClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare function gtk_file_chooser_get_current_name(byval chooser as GtkFileChooser ptr) as gchar ptr
declare function gtk_file_chooser_get_filename(byval chooser as GtkFileChooser ptr) as gchar ptr
declare function gtk_file_chooser_set_filename(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
declare function gtk_file_chooser_select_filename(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr) as gboolean
declare sub gtk_file_chooser_unselect_filename(byval chooser as GtkFileChooser ptr, byval filename as const zstring ptr)
declare sub gtk_file_chooser_select_all(byval chooser as GtkFileChooser ptr)
declare sub gtk_file_chooser_unselect_all(byval chooser as GtkFileChooser ptr)
declare function gtk_file_chooser_get_filenames(byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_set_current_folder(byval chooser as GtkFileChooser ptr, byval filename as const gchar ptr) as gboolean
declare function gtk_file_chooser_get_current_folder(byval chooser as GtkFileChooser ptr) as gchar ptr
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
declare function gtk_file_chooser_get_preview_filename(byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_get_preview_uri(byval chooser as GtkFileChooser ptr) as zstring ptr
declare function gtk_file_chooser_get_preview_file(byval chooser as GtkFileChooser ptr) as GFile ptr
declare sub gtk_file_chooser_set_extra_widget(byval chooser as GtkFileChooser ptr, byval extra_widget as GtkWidget ptr)
declare function gtk_file_chooser_get_extra_widget(byval chooser as GtkFileChooser ptr) as GtkWidget ptr
declare sub gtk_file_chooser_add_filter(byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare sub gtk_file_chooser_remove_filter(byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare function gtk_file_chooser_list_filters(byval chooser as GtkFileChooser ptr) as GSList ptr
declare sub gtk_file_chooser_set_filter(byval chooser as GtkFileChooser ptr, byval filter as GtkFileFilter ptr)
declare function gtk_file_chooser_get_filter(byval chooser as GtkFileChooser ptr) as GtkFileFilter ptr
declare function gtk_file_chooser_add_shortcut_folder(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_remove_shortcut_folder(byval chooser as GtkFileChooser ptr, byval folder as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_list_shortcut_folders(byval chooser as GtkFileChooser ptr) as GSList ptr
declare function gtk_file_chooser_add_shortcut_folder_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_remove_shortcut_folder_uri(byval chooser as GtkFileChooser ptr, byval uri as const zstring ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_file_chooser_list_shortcut_folder_uris(byval chooser as GtkFileChooser ptr) as GSList ptr

#define __GTK_FILE_CHOOSER_BUTTON_H__
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
	parent as GtkBox
	priv as GtkFileChooserButtonPrivate ptr
end type

type _GtkFileChooserButtonClass
	parent_class as GtkBoxClass
	file_set as sub(byval fc as GtkFileChooserButton ptr)
	__gtk_reserved1 as any ptr
	__gtk_reserved2 as any ptr
	__gtk_reserved3 as any ptr
	__gtk_reserved4 as any ptr
end type

declare function gtk_file_chooser_button_get_type() as GType
declare function gtk_file_chooser_button_new(byval title as const gchar ptr, byval action as GtkFileChooserAction) as GtkWidget ptr
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_file_chooser_dialog_get_type() as GType
declare function gtk_file_chooser_dialog_new(byval title as const gchar ptr, byval parent as GtkWindow ptr, byval action as GtkFileChooserAction, byval first_button_text as const gchar ptr, ...) as GtkWidget ptr
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
	parent_instance as GtkBox
	priv as GtkFileChooserWidgetPrivate ptr
end type

type _GtkFileChooserWidgetClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_file_chooser_widget_get_type() as GType
declare function gtk_file_chooser_widget_new(byval action as GtkFileChooserAction) as GtkWidget ptr
#define __GTK_FLOW_BOX_H__
#define GTK_TYPE_FLOW_BOX gtk_flow_box_get_type()
#define GTK_FLOW_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FLOW_BOX, GtkFlowBox)
#define GTK_FLOW_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FLOW_BOX, GtkFlowBoxClass)
#define GTK_IS_FLOW_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FLOW_BOX)
#define GTK_IS_FLOW_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FLOW_BOX)
#define GTK_FLOW_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FLOW_BOX, GtkFlowBoxClass)

type GtkFlowBox as _GtkFlowBox
type GtkFlowBoxClass as _GtkFlowBoxClass
type GtkFlowBoxChild as _GtkFlowBoxChild
type GtkFlowBoxChildClass as _GtkFlowBoxChildClass

type _GtkFlowBox
	container as GtkContainer
end type

type _GtkFlowBoxClass
	parent_class as GtkContainerClass
	child_activated as sub(byval box as GtkFlowBox ptr, byval child as GtkFlowBoxChild ptr)
	selected_children_changed as sub(byval box as GtkFlowBox ptr)
	activate_cursor_child as sub(byval box as GtkFlowBox ptr)
	toggle_cursor_child as sub(byval box as GtkFlowBox ptr)
	move_cursor as sub(byval box as GtkFlowBox ptr, byval step as GtkMovementStep, byval count as gint)
	select_all as sub(byval box as GtkFlowBox ptr)
	unselect_all as sub(byval box as GtkFlowBox ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
end type

#define GTK_TYPE_FLOW_BOX_CHILD gtk_flow_box_child_get_type()
#define GTK_FLOW_BOX_CHILD(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FLOW_BOX_CHILD, GtkFlowBoxChild)
#define GTK_FLOW_BOX_CHILD_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FLOW_BOX_CHILD, GtkFlowBoxChildClass)
#define GTK_IS_FLOW_BOX_CHILD(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FLOW_BOX_CHILD)
#define GTK_IS_FLOW_BOX_CHILD_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FLOW_BOX_CHILD)
#define GTK_FLOW_BOX_CHILD_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), EG_TYPE_FLOW_BOX_CHILD, GtkFlowBoxChildClass)

type _GtkFlowBoxChild
	parent_instance as GtkBin
end type

type _GtkFlowBoxChildClass
	parent_class as GtkBinClass
	activate as sub(byval child as GtkFlowBoxChild ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

declare function gtk_flow_box_child_get_type() as GType
declare function gtk_flow_box_child_new() as GtkWidget ptr
declare function gtk_flow_box_child_get_index(byval child as GtkFlowBoxChild ptr) as gint
declare function gtk_flow_box_child_is_selected(byval child as GtkFlowBoxChild ptr) as gboolean
declare sub gtk_flow_box_child_changed(byval child as GtkFlowBoxChild ptr)
declare function gtk_flow_box_get_type() as GType
declare function gtk_flow_box_new() as GtkWidget ptr
declare sub gtk_flow_box_set_homogeneous(byval box as GtkFlowBox ptr, byval homogeneous as gboolean)
declare function gtk_flow_box_get_homogeneous(byval box as GtkFlowBox ptr) as gboolean
declare sub gtk_flow_box_set_row_spacing(byval box as GtkFlowBox ptr, byval spacing as guint)
declare function gtk_flow_box_get_row_spacing(byval box as GtkFlowBox ptr) as guint
declare sub gtk_flow_box_set_column_spacing(byval box as GtkFlowBox ptr, byval spacing as guint)
declare function gtk_flow_box_get_column_spacing(byval box as GtkFlowBox ptr) as guint
declare sub gtk_flow_box_set_min_children_per_line(byval box as GtkFlowBox ptr, byval n_children as guint)
declare function gtk_flow_box_get_min_children_per_line(byval box as GtkFlowBox ptr) as guint
declare sub gtk_flow_box_set_max_children_per_line(byval box as GtkFlowBox ptr, byval n_children as guint)
declare function gtk_flow_box_get_max_children_per_line(byval box as GtkFlowBox ptr) as guint
declare sub gtk_flow_box_set_activate_on_single_click(byval box as GtkFlowBox ptr, byval single as gboolean)
declare function gtk_flow_box_get_activate_on_single_click(byval box as GtkFlowBox ptr) as gboolean
declare sub gtk_flow_box_insert(byval box as GtkFlowBox ptr, byval widget as GtkWidget ptr, byval position as gint)
declare function gtk_flow_box_get_child_at_index(byval box as GtkFlowBox ptr, byval idx as gint) as GtkFlowBoxChild ptr
type GtkFlowBoxForeachFunc as sub(byval box as GtkFlowBox ptr, byval child as GtkFlowBoxChild ptr, byval user_data as gpointer)
declare sub gtk_flow_box_selected_foreach(byval box as GtkFlowBox ptr, byval func as GtkFlowBoxForeachFunc, byval data as gpointer)
declare function gtk_flow_box_get_selected_children(byval box as GtkFlowBox ptr) as GList ptr
declare sub gtk_flow_box_select_child(byval box as GtkFlowBox ptr, byval child as GtkFlowBoxChild ptr)
declare sub gtk_flow_box_unselect_child(byval box as GtkFlowBox ptr, byval child as GtkFlowBoxChild ptr)
declare sub gtk_flow_box_select_all(byval box as GtkFlowBox ptr)
declare sub gtk_flow_box_unselect_all(byval box as GtkFlowBox ptr)
declare sub gtk_flow_box_set_selection_mode(byval box as GtkFlowBox ptr, byval mode as GtkSelectionMode)
declare function gtk_flow_box_get_selection_mode(byval box as GtkFlowBox ptr) as GtkSelectionMode
declare sub gtk_flow_box_set_hadjustment(byval box as GtkFlowBox ptr, byval adjustment as GtkAdjustment ptr)
declare sub gtk_flow_box_set_vadjustment(byval box as GtkFlowBox ptr, byval adjustment as GtkAdjustment ptr)
type GtkFlowBoxFilterFunc as function(byval child as GtkFlowBoxChild ptr, byval user_data as gpointer) as gboolean
declare sub gtk_flow_box_set_filter_func(byval box as GtkFlowBox ptr, byval filter_func as GtkFlowBoxFilterFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_flow_box_invalidate_filter(byval box as GtkFlowBox ptr)
type GtkFlowBoxSortFunc as function(byval child1 as GtkFlowBoxChild ptr, byval child2 as GtkFlowBoxChild ptr, byval user_data as gpointer) as gint
declare sub gtk_flow_box_set_sort_func(byval box as GtkFlowBox ptr, byval sort_func as GtkFlowBoxSortFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_flow_box_invalidate_sort(byval box as GtkFlowBox ptr)

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
#define __GTK_FONT_CHOOSER_H__
type GtkFontFilterFunc as function(byval family as const PangoFontFamily ptr, byval face as const PangoFontFace ptr, byval data as gpointer) as gboolean

#define GTK_TYPE_FONT_CHOOSER gtk_font_chooser_get_type()
#define GTK_FONT_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FONT_CHOOSER, GtkFontChooser)
#define GTK_IS_FONT_CHOOSER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FONT_CHOOSER)
#define GTK_FONT_CHOOSER_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_FONT_CHOOSER, GtkFontChooserIface)
type GtkFontChooser as _GtkFontChooser
type GtkFontChooserIface as _GtkFontChooserIface

type _GtkFontChooserIface
	base_iface as GTypeInterface
	get_font_family as function(byval fontchooser as GtkFontChooser ptr) as PangoFontFamily ptr
	get_font_face as function(byval fontchooser as GtkFontChooser ptr) as PangoFontFace ptr
	get_font_size as function(byval fontchooser as GtkFontChooser ptr) as gint
	set_filter_func as sub(byval fontchooser as GtkFontChooser ptr, byval filter as GtkFontFilterFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
	font_activated as sub(byval chooser as GtkFontChooser ptr, byval fontname as const gchar ptr)
	padding(0 to 11) as gpointer
end type

declare function gtk_font_chooser_get_type() as GType
declare function gtk_font_chooser_get_font_family(byval fontchooser as GtkFontChooser ptr) as PangoFontFamily ptr
declare function gtk_font_chooser_get_font_face(byval fontchooser as GtkFontChooser ptr) as PangoFontFace ptr
declare function gtk_font_chooser_get_font_size(byval fontchooser as GtkFontChooser ptr) as gint
declare function gtk_font_chooser_get_font_desc(byval fontchooser as GtkFontChooser ptr) as PangoFontDescription ptr
declare sub gtk_font_chooser_set_font_desc(byval fontchooser as GtkFontChooser ptr, byval font_desc as const PangoFontDescription ptr)
declare function gtk_font_chooser_get_font(byval fontchooser as GtkFontChooser ptr) as gchar ptr
declare sub gtk_font_chooser_set_font(byval fontchooser as GtkFontChooser ptr, byval fontname as const gchar ptr)
declare function gtk_font_chooser_get_preview_text(byval fontchooser as GtkFontChooser ptr) as gchar ptr
declare sub gtk_font_chooser_set_preview_text(byval fontchooser as GtkFontChooser ptr, byval text as const gchar ptr)
declare function gtk_font_chooser_get_show_preview_entry(byval fontchooser as GtkFontChooser ptr) as gboolean
declare sub gtk_font_chooser_set_show_preview_entry(byval fontchooser as GtkFontChooser ptr, byval show_preview_entry as gboolean)
declare sub gtk_font_chooser_set_filter_func(byval fontchooser as GtkFontChooser ptr, byval filter as GtkFontFilterFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)

#define __GTK_FONT_CHOOSER_DIALOG_H__
#define GTK_TYPE_FONT_CHOOSER_DIALOG gtk_font_chooser_dialog_get_type()
#define GTK_FONT_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FONT_CHOOSER_DIALOG, GtkFontChooserDialog)
#define GTK_FONT_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FONT_CHOOSER_DIALOG, GtkFontChooserDialogClass)
#define GTK_IS_FONT_CHOOSER_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FONT_CHOOSER_DIALOG)
#define GTK_IS_FONT_CHOOSER_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FONT_CHOOSER_DIALOG)
#define GTK_FONT_CHOOSER_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FONT_CHOOSER_DIALOG, GtkFontChooserDialogClass)

type GtkFontChooserDialog as _GtkFontChooserDialog
type GtkFontChooserDialogPrivate as _GtkFontChooserDialogPrivate
type GtkFontChooserDialogClass as _GtkFontChooserDialogClass

type _GtkFontChooserDialog
	parent_instance as GtkDialog
	priv as GtkFontChooserDialogPrivate ptr
end type

type _GtkFontChooserDialogClass
	parent_class as GtkDialogClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_font_chooser_dialog_get_type() as GType
declare function gtk_font_chooser_dialog_new(byval title as const gchar ptr, byval parent as GtkWindow ptr) as GtkWidget ptr
#define __GTK_FONT_CHOOSER_WIDGET_H__
#define GTK_TYPE_FONT_CHOOSER_WIDGET gtk_font_chooser_widget_get_type()
#define GTK_FONT_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_FONT_CHOOSER_WIDGET, GtkFontChooserWidget)
#define GTK_FONT_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_FONT_CHOOSER_WIDGET, GtkFontChooserWidgetClass)
#define GTK_IS_FONT_CHOOSER_WIDGET(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_FONT_CHOOSER_WIDGET)
#define GTK_IS_FONT_CHOOSER_WIDGET_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_FONT_CHOOSER_WIDGET)
#define GTK_FONT_CHOOSER_WIDGET_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_FONT_CHOOSER_WIDGET, GtkFontChooserWidgetClass)

type GtkFontChooserWidget as _GtkFontChooserWidget
type GtkFontChooserWidgetPrivate as _GtkFontChooserWidgetPrivate
type GtkFontChooserWidgetClass as _GtkFontChooserWidgetClass

type _GtkFontChooserWidget
	parent_instance as GtkBox
	priv as GtkFontChooserWidgetPrivate ptr
end type

type _GtkFontChooserWidgetClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

declare function gtk_font_chooser_widget_get_type() as GType
declare function gtk_font_chooser_widget_new() as GtkWidget ptr
#define __GTK_GESTURE_H__
#define GTK_TYPE_GESTURE gtk_gesture_get_type()
#define GTK_GESTURE(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE, GtkGesture)
#define GTK_GESTURE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE, GtkGestureClass)
#define GTK_IS_GESTURE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE)
#define GTK_IS_GESTURE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE)
#define GTK_GESTURE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE, GtkGestureClass)
type GtkGesture as _GtkGesture
type GtkGestureClass as _GtkGestureClass

declare function gtk_gesture_get_type() as GType
declare function gtk_gesture_get_device(byval gesture as GtkGesture ptr) as GdkDevice ptr
declare function gtk_gesture_set_state(byval gesture as GtkGesture ptr, byval state as GtkEventSequenceState) as gboolean
declare function gtk_gesture_get_sequence_state(byval gesture as GtkGesture ptr, byval sequence as GdkEventSequence ptr) as GtkEventSequenceState
declare function gtk_gesture_set_sequence_state(byval gesture as GtkGesture ptr, byval sequence as GdkEventSequence ptr, byval state as GtkEventSequenceState) as gboolean
declare function gtk_gesture_get_sequences(byval gesture as GtkGesture ptr) as GList ptr
declare function gtk_gesture_get_last_updated_sequence(byval gesture as GtkGesture ptr) as GdkEventSequence ptr
declare function gtk_gesture_handles_sequence(byval gesture as GtkGesture ptr, byval sequence as GdkEventSequence ptr) as gboolean
declare function gtk_gesture_get_last_event(byval gesture as GtkGesture ptr, byval sequence as GdkEventSequence ptr) as const GdkEvent ptr
declare function gtk_gesture_get_point(byval gesture as GtkGesture ptr, byval sequence as GdkEventSequence ptr, byval x as gdouble ptr, byval y as gdouble ptr) as gboolean
declare function gtk_gesture_get_bounding_box(byval gesture as GtkGesture ptr, byval rect as GdkRectangle ptr) as gboolean
declare function gtk_gesture_get_bounding_box_center(byval gesture as GtkGesture ptr, byval x as gdouble ptr, byval y as gdouble ptr) as gboolean
declare function gtk_gesture_is_active(byval gesture as GtkGesture ptr) as gboolean
declare function gtk_gesture_is_recognized(byval gesture as GtkGesture ptr) as gboolean
declare function gtk_gesture_get_window(byval gesture as GtkGesture ptr) as GdkWindow ptr
declare sub gtk_gesture_set_window(byval gesture as GtkGesture ptr, byval window as GdkWindow ptr)
declare sub gtk_gesture_group(byval group_gesture as GtkGesture ptr, byval gesture as GtkGesture ptr)
declare sub gtk_gesture_ungroup(byval gesture as GtkGesture ptr)
declare function gtk_gesture_get_group(byval gesture as GtkGesture ptr) as GList ptr
declare function gtk_gesture_is_grouped_with(byval gesture as GtkGesture ptr, byval other as GtkGesture ptr) as gboolean

#define __GTK_GESTURE_DRAG_H__
#define __GTK_GESTURE_SINGLE_H__
#define GTK_TYPE_GESTURE_SINGLE gtk_gesture_single_get_type()
#define GTK_GESTURE_SINGLE(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_SINGLE, GtkGestureSingle)
#define GTK_GESTURE_SINGLE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_SINGLE, GtkGestureSingleClass)
#define GTK_IS_GESTURE_SINGLE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_SINGLE)
#define GTK_IS_GESTURE_SINGLE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_SINGLE)
#define GTK_GESTURE_SINGLE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_SINGLE, GtkGestureSingleClass)
type GtkGestureSingle as _GtkGestureSingle
type GtkGestureSingleClass as _GtkGestureSingleClass

declare function gtk_gesture_single_get_type() as GType
declare function gtk_gesture_single_get_touch_only(byval gesture as GtkGestureSingle ptr) as gboolean
declare sub gtk_gesture_single_set_touch_only(byval gesture as GtkGestureSingle ptr, byval touch_only as gboolean)
declare function gtk_gesture_single_get_exclusive(byval gesture as GtkGestureSingle ptr) as gboolean
declare sub gtk_gesture_single_set_exclusive(byval gesture as GtkGestureSingle ptr, byval exclusive as gboolean)
declare function gtk_gesture_single_get_button(byval gesture as GtkGestureSingle ptr) as guint
declare sub gtk_gesture_single_set_button(byval gesture as GtkGestureSingle ptr, byval button as guint)
declare function gtk_gesture_single_get_current_button(byval gesture as GtkGestureSingle ptr) as guint
declare function gtk_gesture_single_get_current_sequence(byval gesture as GtkGestureSingle ptr) as GdkEventSequence ptr

#define GTK_TYPE_GESTURE_DRAG gtk_gesture_drag_get_type()
#define GTK_GESTURE_DRAG(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_DRAG, GtkGestureDrag)
#define GTK_GESTURE_DRAG_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_DRAG, GtkGestureDragClass)
#define GTK_IS_GESTURE_DRAG(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_DRAG)
#define GTK_IS_GESTURE_DRAG_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_DRAG)
#define GTK_GESTURE_DRAG_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_DRAG, GtkGestureDragClass)
type GtkGestureDrag as _GtkGestureDrag
type GtkGestureDragClass as _GtkGestureDragClass

declare function gtk_gesture_drag_get_type() as GType
declare function gtk_gesture_drag_new(byval widget as GtkWidget ptr) as GtkGesture ptr
declare function gtk_gesture_drag_get_start_point(byval gesture as GtkGestureDrag ptr, byval x as gdouble ptr, byval y as gdouble ptr) as gboolean
declare function gtk_gesture_drag_get_offset(byval gesture as GtkGestureDrag ptr, byval x as gdouble ptr, byval y as gdouble ptr) as gboolean

#define __GTK_GESTURE_LONG_PRESS_H__
#define GTK_TYPE_GESTURE_LONG_PRESS gtk_gesture_long_press_get_type()
#define GTK_GESTURE_LONG_PRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_LONG_PRESS, GtkGestureLongPress)
#define GTK_GESTURE_LONG_PRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_LONG_PRESS, GtkGestureLongPressClass)
#define GTK_IS_GESTURE_LONG_PRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_LONG_PRESS)
#define GTK_IS_GESTURE_LONG_PRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_LONG_PRESS)
#define GTK_GESTURE_LONG_PRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_LONG_PRESS, GtkGestureLongPressClass)
type GtkGestureLongPress as _GtkGestureLongPress
type GtkGestureLongPressClass as _GtkGestureLongPressClass
declare function gtk_gesture_long_press_get_type() as GType
declare function gtk_gesture_long_press_new(byval widget as GtkWidget ptr) as GtkGesture ptr
#define __GTK_GESTURE_MULTI_PRESS_H__
#define GTK_TYPE_GESTURE_MULTI_PRESS gtk_gesture_multi_press_get_type()
#define GTK_GESTURE_MULTI_PRESS(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_MULTI_PRESS, GtkGestureMultiPress)
#define GTK_GESTURE_MULTI_PRESS_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_MULTI_PRESS, GtkGestureMultiPressClass)
#define GTK_IS_GESTURE_MULTI_PRESS(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_MULTI_PRESS)
#define GTK_IS_GESTURE_MULTI_PRESS_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_MULTI_PRESS)
#define GTK_GESTURE_MULTI_PRESS_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_MULTI_PRESS, GtkGestureMultiPressClass)
type GtkGestureMultiPress as _GtkGestureMultiPress
type GtkGestureMultiPressClass as _GtkGestureMultiPressClass

declare function gtk_gesture_multi_press_get_type() as GType
declare function gtk_gesture_multi_press_new(byval widget as GtkWidget ptr) as GtkGesture ptr
declare sub gtk_gesture_multi_press_set_area(byval gesture as GtkGestureMultiPress ptr, byval rect as const GdkRectangle ptr)
declare function gtk_gesture_multi_press_get_area(byval gesture as GtkGestureMultiPress ptr, byval rect as GdkRectangle ptr) as gboolean

#define __GTK_GESTURE_PAN_H__
#define GTK_TYPE_GESTURE_PAN gtk_gesture_pan_get_type()
#define GTK_GESTURE_PAN(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_PAN, GtkGesturePan)
#define GTK_GESTURE_PAN_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_PAN, GtkGesturePanClass)
#define GTK_IS_GESTURE_PAN(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_PAN)
#define GTK_IS_GESTURE_PAN_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_PAN)
#define GTK_GESTURE_PAN_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_PAN, GtkGesturePanClass)
type GtkGesturePan as _GtkGesturePan
type GtkGesturePanClass as _GtkGesturePanClass

declare function gtk_gesture_pan_get_type() as GType
declare function gtk_gesture_pan_new(byval widget as GtkWidget ptr, byval orientation as GtkOrientation) as GtkGesture ptr
declare function gtk_gesture_pan_get_orientation(byval gesture as GtkGesturePan ptr) as GtkOrientation
declare sub gtk_gesture_pan_set_orientation(byval gesture as GtkGesturePan ptr, byval orientation as GtkOrientation)

#define __GTK_GESTURE_ROTATE_H__
#define GTK_TYPE_GESTURE_ROTATE gtk_gesture_rotate_get_type()
#define GTK_GESTURE_ROTATE(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_ROTATE, GtkGestureRotate)
#define GTK_GESTURE_ROTATE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_ROTATE, GtkGestureRotateClass)
#define GTK_IS_GESTURE_ROTATE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_ROTATE)
#define GTK_IS_GESTURE_ROTATE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_ROTATE)
#define GTK_GESTURE_ROTATE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_ROTATE, GtkGestureRotateClass)
type GtkGestureRotate as _GtkGestureRotate
type GtkGestureRotateClass as _GtkGestureRotateClass

declare function gtk_gesture_rotate_get_type() as GType
declare function gtk_gesture_rotate_new(byval widget as GtkWidget ptr) as GtkGesture ptr
declare function gtk_gesture_rotate_get_angle_delta(byval gesture as GtkGestureRotate ptr) as gdouble

#define __GTK_GESTURE_SWIPE_H__
#define GTK_TYPE_GESTURE_SWIPE gtk_gesture_swipe_get_type()
#define GTK_GESTURE_SWIPE(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_SWIPE, GtkGestureSwipe)
#define GTK_GESTURE_SWIPE_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_SWIPE, GtkGestureSwipeClass)
#define GTK_IS_GESTURE_SWIPE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_SWIPE)
#define GTK_IS_GESTURE_SWIPE_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_SWIPE)
#define GTK_GESTURE_SWIPE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_SWIPE, GtkGestureSwipeClass)
type GtkGestureSwipe as _GtkGestureSwipe
type GtkGestureSwipeClass as _GtkGestureSwipeClass

declare function gtk_gesture_swipe_get_type() as GType
declare function gtk_gesture_swipe_new(byval widget as GtkWidget ptr) as GtkGesture ptr
declare function gtk_gesture_swipe_get_velocity(byval gesture as GtkGestureSwipe ptr, byval velocity_x as gdouble ptr, byval velocity_y as gdouble ptr) as gboolean

#define __GTK_GESTURE_ZOOM_H__
#define GTK_TYPE_GESTURE_ZOOM gtk_gesture_zoom_get_type()
#define GTK_GESTURE_ZOOM(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_GESTURE_ZOOM, GtkGestureZoom)
#define GTK_GESTURE_ZOOM_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_GESTURE_ZOOM, GtkGestureZoomClass)
#define GTK_IS_GESTURE_ZOOM(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_GESTURE_ZOOM)
#define GTK_IS_GESTURE_ZOOM_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_GESTURE_ZOOM)
#define GTK_GESTURE_ZOOM_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_GESTURE_ZOOM, GtkGestureZoomClass)
type GtkGestureZoom as _GtkGestureZoom
type GtkGestureZoomClass as _GtkGestureZoomClass

declare function gtk_gesture_zoom_get_type() as GType
declare function gtk_gesture_zoom_new(byval widget as GtkWidget ptr) as GtkGesture ptr
declare function gtk_gesture_zoom_get_scale_delta(byval gesture as GtkGestureZoom ptr) as gdouble

#define __GTK_GL_AREA_H__
#define GTK_TYPE_GL_AREA gtk_gl_area_get_type()
#define GTK_GL_AREA(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_GL_AREA, GtkGLArea)
#define GTK_IS_GL_AREA(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_GL_AREA)
#define GTK_GL_AREA_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_GL_AREA, GtkGLAreaClass)
#define GTK_IS_GL_AREA_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_GL_AREA)
#define GTK_GL_AREA_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_GL_AREA, GtkGLAreaClass)
type GtkGLArea as _GtkGLArea
type GtkGLAreaClass as _GtkGLAreaClass

type _GtkGLArea
	parent_instance as GtkWidget
end type

type _GtkGLAreaClass
	parent_class as GtkWidgetClass
	render as function(byval area as GtkGLArea ptr, byval context as GdkGLContext ptr) as gboolean
	resize as sub(byval area as GtkGLArea ptr, byval width as long, byval height as long)
	create_context as function(byval area as GtkGLArea ptr) as GdkGLContext ptr
	_padding(0 to 5) as gpointer
end type

declare function gtk_gl_area_get_type() as GType
declare function gtk_gl_area_new() as GtkWidget ptr
declare sub gtk_gl_area_set_required_version(byval area as GtkGLArea ptr, byval major as gint, byval minor as gint)
declare sub gtk_gl_area_get_required_version(byval area as GtkGLArea ptr, byval major as gint ptr, byval minor as gint ptr)
declare function gtk_gl_area_get_has_alpha(byval area as GtkGLArea ptr) as gboolean
declare sub gtk_gl_area_set_has_alpha(byval area as GtkGLArea ptr, byval has_alpha as gboolean)
declare function gtk_gl_area_get_has_depth_buffer(byval area as GtkGLArea ptr) as gboolean
declare sub gtk_gl_area_set_has_depth_buffer(byval area as GtkGLArea ptr, byval has_depth_buffer as gboolean)
declare function gtk_gl_area_get_has_stencil_buffer(byval area as GtkGLArea ptr) as gboolean
declare sub gtk_gl_area_set_has_stencil_buffer(byval area as GtkGLArea ptr, byval has_stencil_buffer as gboolean)
declare function gtk_gl_area_get_auto_render(byval area as GtkGLArea ptr) as gboolean
declare sub gtk_gl_area_set_auto_render(byval area as GtkGLArea ptr, byval auto_render as gboolean)
declare sub gtk_gl_area_queue_render(byval area as GtkGLArea ptr)
declare function gtk_gl_area_get_context(byval area as GtkGLArea ptr) as GdkGLContext ptr
declare sub gtk_gl_area_make_current(byval area as GtkGLArea ptr)
declare sub gtk_gl_area_attach_buffers(byval area as GtkGLArea ptr)
declare sub gtk_gl_area_set_error(byval area as GtkGLArea ptr, byval error as const GError ptr)
declare function gtk_gl_area_get_error(byval area as GtkGLArea ptr) as GError ptr

#define __GTK_GRID_H__
#define GTK_TYPE_GRID gtk_grid_get_type()
#define GTK_GRID(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_GRID, GtkGrid)
#define GTK_GRID_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_GRID, GtkGridClass)
#define GTK_IS_GRID(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_GRID)
#define GTK_IS_GRID_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_GRID)
#define GTK_GRID_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_GRID, GtkGridClass)

type GtkGrid as _GtkGrid
type GtkGridPrivate as _GtkGridPrivate
type GtkGridClass as _GtkGridClass

type _GtkGrid
	container as GtkContainer
	priv as GtkGridPrivate ptr
end type

type _GtkGridClass
	parent_class as GtkContainerClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

declare function gtk_grid_get_type() as GType
declare function gtk_grid_new() as GtkWidget ptr
declare sub gtk_grid_attach(byval grid as GtkGrid ptr, byval child as GtkWidget ptr, byval left as gint, byval top as gint, byval width as gint, byval height as gint)
declare sub gtk_grid_attach_next_to(byval grid as GtkGrid ptr, byval child as GtkWidget ptr, byval sibling as GtkWidget ptr, byval side as GtkPositionType, byval width as gint, byval height as gint)
declare function gtk_grid_get_child_at(byval grid as GtkGrid ptr, byval left as gint, byval top as gint) as GtkWidget ptr
declare sub gtk_grid_insert_row(byval grid as GtkGrid ptr, byval position as gint)
declare sub gtk_grid_insert_column(byval grid as GtkGrid ptr, byval position as gint)
declare sub gtk_grid_remove_row(byval grid as GtkGrid ptr, byval position as gint)
declare sub gtk_grid_remove_column(byval grid as GtkGrid ptr, byval position as gint)
declare sub gtk_grid_insert_next_to(byval grid as GtkGrid ptr, byval sibling as GtkWidget ptr, byval side as GtkPositionType)
declare sub gtk_grid_set_row_homogeneous(byval grid as GtkGrid ptr, byval homogeneous as gboolean)
declare function gtk_grid_get_row_homogeneous(byval grid as GtkGrid ptr) as gboolean
declare sub gtk_grid_set_row_spacing(byval grid as GtkGrid ptr, byval spacing as guint)
declare function gtk_grid_get_row_spacing(byval grid as GtkGrid ptr) as guint
declare sub gtk_grid_set_column_homogeneous(byval grid as GtkGrid ptr, byval homogeneous as gboolean)
declare function gtk_grid_get_column_homogeneous(byval grid as GtkGrid ptr) as gboolean
declare sub gtk_grid_set_column_spacing(byval grid as GtkGrid ptr, byval spacing as guint)
declare function gtk_grid_get_column_spacing(byval grid as GtkGrid ptr) as guint
declare sub gtk_grid_set_row_baseline_position(byval grid as GtkGrid ptr, byval row as gint, byval pos as GtkBaselinePosition)
declare function gtk_grid_get_row_baseline_position(byval grid as GtkGrid ptr, byval row as gint) as GtkBaselinePosition
declare sub gtk_grid_set_baseline_row(byval grid as GtkGrid ptr, byval row as gint)
declare function gtk_grid_get_baseline_row(byval grid as GtkGrid ptr) as gint

#define __GTK_HEADER_BAR_H__
#define GTK_TYPE_HEADER_BAR gtk_header_bar_get_type()
#define GTK_HEADER_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HEADER_BAR, GtkHeaderBar)
#define GTK_HEADER_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HEADER_BAR, GtkHeaderBarClass)
#define GTK_IS_HEADER_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HEADER_BAR)
#define GTK_IS_HEADER_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HEADER_BAR)
#define GTK_HEADER_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HEADER_BAR, GtkHeaderBarClass)

type GtkHeaderBar as _GtkHeaderBar
type GtkHeaderBarPrivate as _GtkHeaderBarPrivate
type GtkHeaderBarClass as _GtkHeaderBarClass

type _GtkHeaderBar
	container as GtkContainer
end type

type _GtkHeaderBarClass
	parent_class as GtkContainerClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_header_bar_get_type() as GType
declare function gtk_header_bar_new() as GtkWidget ptr
declare sub gtk_header_bar_set_title(byval bar as GtkHeaderBar ptr, byval title as const gchar ptr)
declare function gtk_header_bar_get_title(byval bar as GtkHeaderBar ptr) as const gchar ptr
declare sub gtk_header_bar_set_subtitle(byval bar as GtkHeaderBar ptr, byval subtitle as const gchar ptr)
declare function gtk_header_bar_get_subtitle(byval bar as GtkHeaderBar ptr) as const gchar ptr
declare sub gtk_header_bar_set_custom_title(byval bar as GtkHeaderBar ptr, byval title_widget as GtkWidget ptr)
declare function gtk_header_bar_get_custom_title(byval bar as GtkHeaderBar ptr) as GtkWidget ptr
declare sub gtk_header_bar_pack_start(byval bar as GtkHeaderBar ptr, byval child as GtkWidget ptr)
declare sub gtk_header_bar_pack_end(byval bar as GtkHeaderBar ptr, byval child as GtkWidget ptr)
declare function gtk_header_bar_get_show_close_button(byval bar as GtkHeaderBar ptr) as gboolean
declare sub gtk_header_bar_set_show_close_button(byval bar as GtkHeaderBar ptr, byval setting as gboolean)
declare sub gtk_header_bar_set_has_subtitle(byval bar as GtkHeaderBar ptr, byval setting as gboolean)
declare function gtk_header_bar_get_has_subtitle(byval bar as GtkHeaderBar ptr) as gboolean
declare sub gtk_header_bar_set_decoration_layout(byval bar as GtkHeaderBar ptr, byval layout as const gchar ptr)
declare function gtk_header_bar_get_decoration_layout(byval bar as GtkHeaderBar ptr) as const gchar ptr

#define __GTK_ICON_THEME_H__
#define __GTK_STYLE_CONTEXT_H__
#define __GTK_STYLE_PROVIDER_H__
#define __GTK_ICON_FACTORY_H__
#define GTK_TYPE_ICON_FACTORY gtk_icon_factory_get_type()
#define GTK_ICON_FACTORY(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_ICON_FACTORY, GtkIconFactory)
#define GTK_ICON_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass)
#define GTK_IS_ICON_FACTORY(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_ICON_FACTORY)
#define GTK_IS_ICON_FACTORY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ICON_FACTORY)
#define GTK_ICON_FACTORY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass)
#define GTK_TYPE_ICON_SET gtk_icon_set_get_type()
#define GTK_TYPE_ICON_SOURCE gtk_icon_source_get_type()

type GtkIconFactory as _GtkIconFactory
type GtkIconFactoryPrivate as _GtkIconFactoryPrivate
type GtkIconFactoryClass as _GtkIconFactoryClass

type _GtkIconFactory
	parent_instance as GObject
	priv as GtkIconFactoryPrivate ptr
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
declare function gtk_icon_set_render_icon(byval icon_set as GtkIconSet ptr, byval style as GtkStyle ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as const gchar ptr) as GdkPixbuf ptr
declare sub gtk_icon_set_add_source(byval icon_set as GtkIconSet ptr, byval source as const GtkIconSource ptr)
declare sub gtk_icon_set_get_sizes(byval icon_set as GtkIconSet ptr, byval sizes as GtkIconSize ptr ptr, byval n_sizes as gint ptr)
declare function gtk_icon_source_get_type() as GType
declare function gtk_icon_source_new() as GtkIconSource ptr
declare function gtk_icon_source_copy(byval source as const GtkIconSource ptr) as GtkIconSource ptr
declare sub gtk_icon_source_free(byval source as GtkIconSource ptr)
declare sub gtk_icon_source_set_filename(byval source as GtkIconSource ptr, byval filename as const gchar ptr)
declare sub gtk_icon_source_set_icon_name(byval source as GtkIconSource ptr, byval icon_name as const gchar ptr)
declare sub gtk_icon_source_set_pixbuf(byval source as GtkIconSource ptr, byval pixbuf as GdkPixbuf ptr)
declare function gtk_icon_source_get_filename(byval source as const GtkIconSource ptr) as const gchar ptr
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

#define __GTK_STYLE_PROPERTIES_H__
#define GTK_TYPE_STYLE_PROPERTIES gtk_style_properties_get_type()
#define GTK_STYLE_PROPERTIES(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_STYLE_PROPERTIES, GtkStyleProperties)
#define GTK_STYLE_PROPERTIES_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_STYLE_PROPERTIES, GtkStylePropertiesClass)
#define GTK_IS_STYLE_PROPERTIES(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_STYLE_PROPERTIES)
#define GTK_IS_STYLE_PROPERTIES_CLASS(c) G_TYPE_CHECK_CLASS_TYPE((c), GTK_TYPE_STYLE_PROPERTIES)
#define GTK_STYLE_PROPERTIES_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_STYLE_PROPERTIES, GtkStylePropertiesClass)

type GtkStyleProperties as _GtkStyleProperties
type GtkStylePropertiesClass as _GtkStylePropertiesClass
type GtkStylePropertiesPrivate as _GtkStylePropertiesPrivate
type GtkSymbolicColor as _GtkSymbolicColor
type GtkGradient as _GtkGradient

type _GtkStyleProperties
	parent_object as GObject
	priv as GtkStylePropertiesPrivate ptr
end type

type _GtkStylePropertiesClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type GtkStylePropertyParser as function(byval string as const gchar ptr, byval value as GValue ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_style_properties_get_type() as GType
declare sub gtk_style_properties_register_property(byval parse_func as GtkStylePropertyParser, byval pspec as GParamSpec ptr)
declare function gtk_style_properties_lookup_property(byval property_name as const gchar ptr, byval parse_func as GtkStylePropertyParser ptr, byval pspec as GParamSpec ptr ptr) as gboolean
declare function gtk_style_properties_new() as GtkStyleProperties ptr
declare sub gtk_style_properties_map_color(byval props as GtkStyleProperties ptr, byval name as const gchar ptr, byval color as GtkSymbolicColor ptr)
declare function gtk_style_properties_lookup_color(byval props as GtkStyleProperties ptr, byval name as const gchar ptr) as GtkSymbolicColor ptr
declare sub gtk_style_properties_set_property(byval props as GtkStyleProperties ptr, byval property as const gchar ptr, byval state as GtkStateFlags, byval value as const GValue ptr)
declare sub gtk_style_properties_set_valist(byval props as GtkStyleProperties ptr, byval state as GtkStateFlags, byval args as va_list)
declare sub gtk_style_properties_set(byval props as GtkStyleProperties ptr, byval state as GtkStateFlags, ...)
declare function gtk_style_properties_get_property(byval props as GtkStyleProperties ptr, byval property as const gchar ptr, byval state as GtkStateFlags, byval value as GValue ptr) as gboolean
declare sub gtk_style_properties_get_valist(byval props as GtkStyleProperties ptr, byval state as GtkStateFlags, byval args as va_list)
declare sub gtk_style_properties_get(byval props as GtkStyleProperties ptr, byval state as GtkStateFlags, ...)
declare sub gtk_style_properties_unset_property(byval props as GtkStyleProperties ptr, byval property as const gchar ptr, byval state as GtkStateFlags)
declare sub gtk_style_properties_clear(byval props as GtkStyleProperties ptr)
declare sub gtk_style_properties_merge(byval props as GtkStyleProperties ptr, byval props_to_merge as const GtkStyleProperties ptr, byval replace as gboolean)

#define GTK_TYPE_STYLE_PROVIDER gtk_style_provider_get_type()
#define GTK_STYLE_PROVIDER(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_STYLE_PROVIDER, GtkStyleProvider)
#define GTK_IS_STYLE_PROVIDER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_STYLE_PROVIDER)
#define GTK_STYLE_PROVIDER_GET_IFACE(o) G_TYPE_INSTANCE_GET_INTERFACE((o), GTK_TYPE_STYLE_PROVIDER, GtkStyleProviderIface)
const GTK_STYLE_PROVIDER_PRIORITY_FALLBACK = 1
const GTK_STYLE_PROVIDER_PRIORITY_THEME = 200
const GTK_STYLE_PROVIDER_PRIORITY_SETTINGS = 400
const GTK_STYLE_PROVIDER_PRIORITY_APPLICATION = 600
const GTK_STYLE_PROVIDER_PRIORITY_USER = 800
type GtkStyleProviderIface as _GtkStyleProviderIface
type GtkStyleProvider as _GtkStyleProvider

type _GtkStyleProviderIface
	g_iface as GTypeInterface
	get_style as function(byval provider as GtkStyleProvider ptr, byval path as GtkWidgetPath ptr) as GtkStyleProperties ptr
	get_style_property as function(byval provider as GtkStyleProvider ptr, byval path as GtkWidgetPath ptr, byval state as GtkStateFlags, byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
	get_icon_factory as function(byval provider as GtkStyleProvider ptr, byval path as GtkWidgetPath ptr) as GtkIconFactory ptr
end type

declare function gtk_style_provider_get_type() as GType
declare function gtk_style_provider_get_style(byval provider as GtkStyleProvider ptr, byval path as GtkWidgetPath ptr) as GtkStyleProperties ptr
declare function gtk_style_provider_get_style_property(byval provider as GtkStyleProvider ptr, byval path as GtkWidgetPath ptr, byval state as GtkStateFlags, byval pspec as GParamSpec ptr, byval value as GValue ptr) as gboolean
declare function gtk_style_provider_get_icon_factory(byval provider as GtkStyleProvider ptr, byval path as GtkWidgetPath ptr) as GtkIconFactory ptr

#define GTK_TYPE_STYLE_CONTEXT gtk_style_context_get_type()
#define GTK_STYLE_CONTEXT(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_STYLE_CONTEXT, GtkStyleContext)
#define GTK_STYLE_CONTEXT_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_STYLE_CONTEXT, GtkStyleContextClass)
#define GTK_IS_STYLE_CONTEXT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_STYLE_CONTEXT)
#define GTK_IS_STYLE_CONTEXT_CLASS(c) G_TYPE_CHECK_CLASS_TYPE((c), GTK_TYPE_STYLE_CONTEXT)
#define GTK_STYLE_CONTEXT_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_STYLE_CONTEXT, GtkStyleContextClass)
type GtkStyleContextClass as _GtkStyleContextClass
type GtkStyleContextPrivate as _GtkStyleContextPrivate

type _GtkStyleContext
	parent_object as GObject
	priv as GtkStyleContextPrivate ptr
end type

type _GtkStyleContextClass
	parent_class as GObjectClass
	changed as sub(byval context as GtkStyleContext ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

#define GTK_STYLE_PROPERTY_BACKGROUND_COLOR "background-color"
#define GTK_STYLE_PROPERTY_COLOR "color"
#define GTK_STYLE_PROPERTY_FONT "font"
#define GTK_STYLE_PROPERTY_PADDING "padding"
#define GTK_STYLE_PROPERTY_BORDER_WIDTH "border-width"
#define GTK_STYLE_PROPERTY_MARGIN "margin"
#define GTK_STYLE_PROPERTY_BORDER_RADIUS "border-radius"
#define GTK_STYLE_PROPERTY_BORDER_STYLE "border-style"
#define GTK_STYLE_PROPERTY_BORDER_COLOR "border-color"
#define GTK_STYLE_PROPERTY_BACKGROUND_IMAGE "background-image"
#define GTK_STYLE_CLASS_CELL "cell"
#define GTK_STYLE_CLASS_DIM_LABEL "dim-label"
#define GTK_STYLE_CLASS_ENTRY "entry"
#define GTK_STYLE_CLASS_LABEL "label"
#define GTK_STYLE_CLASS_COMBOBOX_ENTRY "combobox-entry"
#define GTK_STYLE_CLASS_BUTTON "button"
#define GTK_STYLE_CLASS_LIST "list"
#define GTK_STYLE_CLASS_LIST_ROW "list-row"
#define GTK_STYLE_CLASS_CALENDAR "calendar"
#define GTK_STYLE_CLASS_SLIDER "slider"
#define GTK_STYLE_CLASS_BACKGROUND "background"
#define GTK_STYLE_CLASS_RUBBERBAND "rubberband"
#define GTK_STYLE_CLASS_CSD "csd"
#define GTK_STYLE_CLASS_TOOLTIP "tooltip"
#define GTK_STYLE_CLASS_MENU "menu"
#define GTK_STYLE_CLASS_CONTEXT_MENU "context-menu"
#define GTK_STYLE_CLASS_TOUCH_SELECTION "touch-selection"
#define GTK_STYLE_CLASS_MENUBAR "menubar"
#define GTK_STYLE_CLASS_MENUITEM "menuitem"
#define GTK_STYLE_CLASS_TOOLBAR "toolbar"
#define GTK_STYLE_CLASS_PRIMARY_TOOLBAR "primary-toolbar"
#define GTK_STYLE_CLASS_INLINE_TOOLBAR "inline-toolbar"
#define GTK_STYLE_CLASS_STATUSBAR "statusbar"
#define GTK_STYLE_CLASS_RADIO "radio"
#define GTK_STYLE_CLASS_CHECK "check"
#define GTK_STYLE_CLASS_DEFAULT "default"
#define GTK_STYLE_CLASS_TROUGH "trough"
#define GTK_STYLE_CLASS_SCROLLBAR "scrollbar"
#define GTK_STYLE_CLASS_SCROLLBARS_JUNCTION "scrollbars-junction"
#define GTK_STYLE_CLASS_SCALE "scale"
#define GTK_STYLE_CLASS_SCALE_HAS_MARKS_ABOVE "scale-has-marks-above"
#define GTK_STYLE_CLASS_SCALE_HAS_MARKS_BELOW "scale-has-marks-below"
#define GTK_STYLE_CLASS_HEADER "header"
#define GTK_STYLE_CLASS_ACCELERATOR "accelerator"
#define GTK_STYLE_CLASS_RAISED "raised"
#define GTK_STYLE_CLASS_LINKED "linked"
#define GTK_STYLE_CLASS_GRIP "grip"
#define GTK_STYLE_CLASS_DOCK "dock"
#define GTK_STYLE_CLASS_PROGRESSBAR "progressbar"
#define GTK_STYLE_CLASS_SPINNER "spinner"
#define GTK_STYLE_CLASS_MARK "mark"
#define GTK_STYLE_CLASS_EXPANDER "expander"
#define GTK_STYLE_CLASS_SPINBUTTON "spinbutton"
#define GTK_STYLE_CLASS_NOTEBOOK "notebook"
#define GTK_STYLE_CLASS_VIEW "view"
#define GTK_STYLE_CLASS_SIDEBAR "sidebar"
#define GTK_STYLE_CLASS_IMAGE "image"
#define GTK_STYLE_CLASS_HIGHLIGHT "highlight"
#define GTK_STYLE_CLASS_FRAME "frame"
#define GTK_STYLE_CLASS_DND "dnd"
#define GTK_STYLE_CLASS_PANE_SEPARATOR "pane-separator"
#define GTK_STYLE_CLASS_SEPARATOR "separator"
#define GTK_STYLE_CLASS_INFO "info"
#define GTK_STYLE_CLASS_WARNING "warning"
#define GTK_STYLE_CLASS_QUESTION "question"
#define GTK_STYLE_CLASS_ERROR "error"
#define GTK_STYLE_CLASS_HORIZONTAL "horizontal"
#define GTK_STYLE_CLASS_VERTICAL "vertical"
#define GTK_STYLE_CLASS_TOP "top"
#define GTK_STYLE_CLASS_BOTTOM "bottom"
#define GTK_STYLE_CLASS_LEFT "left"
#define GTK_STYLE_CLASS_RIGHT "right"
#define GTK_STYLE_CLASS_PULSE "pulse"
#define GTK_STYLE_CLASS_ARROW "arrow"
#define GTK_STYLE_CLASS_OSD "osd"
#define GTK_STYLE_CLASS_LEVEL_BAR "level-bar"
#define GTK_STYLE_CLASS_CURSOR_HANDLE "cursor-handle"
#define GTK_STYLE_CLASS_INSERTION_CURSOR "insertion-cursor"
#define GTK_STYLE_CLASS_TITLEBAR "titlebar"
#define GTK_STYLE_CLASS_TITLE "title"
#define GTK_STYLE_CLASS_SUBTITLE "subtitle"
#define GTK_STYLE_CLASS_NEEDS_ATTENTION "needs-attention"
#define GTK_STYLE_CLASS_SUGGESTED_ACTION "suggested-action"
#define GTK_STYLE_CLASS_DESTRUCTIVE_ACTION "destructive-action"
#define GTK_STYLE_CLASS_POPOVER "popover"
#define GTK_STYLE_CLASS_POPUP "popup"
#define GTK_STYLE_CLASS_MESSAGE_DIALOG "message-dialog"
#define GTK_STYLE_CLASS_FLAT "flat"
#define GTK_STYLE_CLASS_READ_ONLY "read-only"
#define GTK_STYLE_CLASS_OVERSHOOT "overshoot"
#define GTK_STYLE_CLASS_UNDERSHOOT "undershoot"
#define GTK_STYLE_CLASS_PAPER "paper"
#define GTK_STYLE_CLASS_MONOSPACE "monospace"
#define GTK_STYLE_CLASS_WIDE "wide"
#define GTK_STYLE_REGION_ROW "row"
#define GTK_STYLE_REGION_COLUMN "column"
#define GTK_STYLE_REGION_COLUMN_HEADER "column-header"
#define GTK_STYLE_REGION_TAB "tab"

declare function gtk_style_context_get_type() as GType
declare function gtk_style_context_new() as GtkStyleContext ptr
declare sub gtk_style_context_add_provider_for_screen(byval screen as GdkScreen ptr, byval provider as GtkStyleProvider ptr, byval priority as guint)
declare sub gtk_style_context_remove_provider_for_screen(byval screen as GdkScreen ptr, byval provider as GtkStyleProvider ptr)
declare sub gtk_style_context_add_provider(byval context as GtkStyleContext ptr, byval provider as GtkStyleProvider ptr, byval priority as guint)
declare sub gtk_style_context_remove_provider(byval context as GtkStyleContext ptr, byval provider as GtkStyleProvider ptr)
declare sub gtk_style_context_save(byval context as GtkStyleContext ptr)
declare sub gtk_style_context_restore(byval context as GtkStyleContext ptr)
declare function gtk_style_context_get_section(byval context as GtkStyleContext ptr, byval property as const gchar ptr) as GtkCssSection ptr
declare sub gtk_style_context_get_property(byval context as GtkStyleContext ptr, byval property as const gchar ptr, byval state as GtkStateFlags, byval value as GValue ptr)
declare sub gtk_style_context_get_valist(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval args as va_list)
declare sub gtk_style_context_get(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, ...)
declare sub gtk_style_context_set_state(byval context as GtkStyleContext ptr, byval flags as GtkStateFlags)
declare function gtk_style_context_get_state(byval context as GtkStyleContext ptr) as GtkStateFlags
declare sub gtk_style_context_set_scale(byval context as GtkStyleContext ptr, byval scale as gint)
declare function gtk_style_context_get_scale(byval context as GtkStyleContext ptr) as gint
declare function gtk_style_context_state_is_running(byval context as GtkStyleContext ptr, byval state as GtkStateType, byval progress as gdouble ptr) as gboolean
declare sub gtk_style_context_set_path(byval context as GtkStyleContext ptr, byval path as GtkWidgetPath ptr)
declare function gtk_style_context_get_path(byval context as GtkStyleContext ptr) as const GtkWidgetPath ptr
declare sub gtk_style_context_set_parent(byval context as GtkStyleContext ptr, byval parent as GtkStyleContext ptr)
declare function gtk_style_context_get_parent(byval context as GtkStyleContext ptr) as GtkStyleContext ptr
declare function gtk_style_context_list_classes(byval context as GtkStyleContext ptr) as GList ptr
declare sub gtk_style_context_add_class(byval context as GtkStyleContext ptr, byval class_name as const gchar ptr)
declare sub gtk_style_context_remove_class(byval context as GtkStyleContext ptr, byval class_name as const gchar ptr)
declare function gtk_style_context_has_class(byval context as GtkStyleContext ptr, byval class_name as const gchar ptr) as gboolean
declare function gtk_style_context_list_regions(byval context as GtkStyleContext ptr) as GList ptr
declare sub gtk_style_context_add_region(byval context as GtkStyleContext ptr, byval region_name as const gchar ptr, byval flags as GtkRegionFlags)
declare sub gtk_style_context_remove_region(byval context as GtkStyleContext ptr, byval region_name as const gchar ptr)
declare function gtk_style_context_has_region(byval context as GtkStyleContext ptr, byval region_name as const gchar ptr, byval flags_return as GtkRegionFlags ptr) as gboolean
declare sub gtk_style_context_get_style_property(byval context as GtkStyleContext ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub gtk_style_context_get_style_valist(byval context as GtkStyleContext ptr, byval args as va_list)
declare sub gtk_style_context_get_style(byval context as GtkStyleContext ptr, ...)
declare function gtk_style_context_lookup_icon_set(byval context as GtkStyleContext ptr, byval stock_id as const gchar ptr) as GtkIconSet ptr
declare function gtk_icon_set_render_icon_pixbuf(byval icon_set as GtkIconSet ptr, byval context as GtkStyleContext ptr, byval size as GtkIconSize) as GdkPixbuf ptr
declare function gtk_icon_set_render_icon_surface(byval icon_set as GtkIconSet ptr, byval context as GtkStyleContext ptr, byval size as GtkIconSize, byval scale as long, byval for_window as GdkWindow ptr) as cairo_surface_t ptr
declare sub gtk_style_context_set_screen(byval context as GtkStyleContext ptr, byval screen as GdkScreen ptr)
declare function gtk_style_context_get_screen(byval context as GtkStyleContext ptr) as GdkScreen ptr
declare sub gtk_style_context_set_frame_clock(byval context as GtkStyleContext ptr, byval frame_clock as GdkFrameClock ptr)
declare function gtk_style_context_get_frame_clock(byval context as GtkStyleContext ptr) as GdkFrameClock ptr
declare sub gtk_style_context_set_direction(byval context as GtkStyleContext ptr, byval direction as GtkTextDirection)
declare function gtk_style_context_get_direction(byval context as GtkStyleContext ptr) as GtkTextDirection
declare sub gtk_style_context_set_junction_sides(byval context as GtkStyleContext ptr, byval sides as GtkJunctionSides)
declare function gtk_style_context_get_junction_sides(byval context as GtkStyleContext ptr) as GtkJunctionSides
declare function gtk_style_context_lookup_color(byval context as GtkStyleContext ptr, byval color_name as const gchar ptr, byval color as GdkRGBA ptr) as gboolean
declare sub gtk_style_context_notify_state_change(byval context as GtkStyleContext ptr, byval window as GdkWindow ptr, byval region_id as gpointer, byval state as GtkStateType, byval state_value as gboolean)
declare sub gtk_style_context_cancel_animations(byval context as GtkStyleContext ptr, byval region_id as gpointer)
declare sub gtk_style_context_scroll_animations(byval context as GtkStyleContext ptr, byval window as GdkWindow ptr, byval dx as gint, byval dy as gint)
declare sub gtk_style_context_push_animatable_region(byval context as GtkStyleContext ptr, byval region_id as gpointer)
declare sub gtk_style_context_pop_animatable_region(byval context as GtkStyleContext ptr)
declare sub gtk_style_context_get_color(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval color as GdkRGBA ptr)
declare sub gtk_style_context_get_background_color(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval color as GdkRGBA ptr)
declare sub gtk_style_context_get_border_color(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval color as GdkRGBA ptr)
declare function gtk_style_context_get_font(byval context as GtkStyleContext ptr, byval state as GtkStateFlags) as const PangoFontDescription ptr
declare sub gtk_style_context_get_border(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval border as GtkBorder ptr)
declare sub gtk_style_context_get_padding(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval padding as GtkBorder ptr)
declare sub gtk_style_context_get_margin(byval context as GtkStyleContext ptr, byval state as GtkStateFlags, byval margin as GtkBorder ptr)
declare sub gtk_style_context_invalidate(byval context as GtkStyleContext ptr)
declare sub gtk_style_context_reset_widgets(byval screen as GdkScreen ptr)
declare sub gtk_style_context_set_background(byval context as GtkStyleContext ptr, byval window as GdkWindow ptr)
declare sub gtk_render_insertion_cursor(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval layout as PangoLayout ptr, byval index as long, byval direction as PangoDirection)
declare sub gtk_draw_insertion_cursor(byval widget as GtkWidget ptr, byval cr as cairo_t ptr, byval location as const GdkRectangle ptr, byval is_primary as gboolean, byval direction as GtkTextDirection, byval draw_arrow as gboolean)

#define GTK_TYPE_ICON_INFO gtk_icon_info_get_type()
#define GTK_ICON_INFO(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ICON_INFO, GtkIconInfo)
#define GTK_ICON_INFO_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ICON_INFO, GtkIconInfoClass)
#define GTK_IS_ICON_INFO(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ICON_INFO)
#define GTK_IS_ICON_INFO_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ICON_INFO)
#define GTK_ICON_INFO_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ICON_INFO, GtkIconInfoClass)
#define GTK_TYPE_ICON_THEME gtk_icon_theme_get_type()
#define GTK_ICON_THEME(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ICON_THEME, GtkIconTheme)
#define GTK_ICON_THEME_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ICON_THEME, GtkIconThemeClass)
#define GTK_IS_ICON_THEME(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ICON_THEME)
#define GTK_IS_ICON_THEME_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ICON_THEME)
#define GTK_ICON_THEME_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ICON_THEME, GtkIconThemeClass)

type GtkIconInfo as _GtkIconInfo
type GtkIconInfoClass as _GtkIconInfoClass
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type GtkIconLookupFlags as long
enum
	GTK_ICON_LOOKUP_NO_SVG = 1 shl 0
	GTK_ICON_LOOKUP_FORCE_SVG = 1 shl 1
	GTK_ICON_LOOKUP_USE_BUILTIN = 1 shl 2
	GTK_ICON_LOOKUP_GENERIC_FALLBACK = 1 shl 3
	GTK_ICON_LOOKUP_FORCE_SIZE = 1 shl 4
	GTK_ICON_LOOKUP_FORCE_REGULAR = 1 shl 5
	GTK_ICON_LOOKUP_FORCE_SYMBOLIC = 1 shl 6
	GTK_ICON_LOOKUP_DIR_LTR = 1 shl 7
	GTK_ICON_LOOKUP_DIR_RTL = 1 shl 8
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
declare sub gtk_icon_theme_set_search_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr ptr, byval n_elements as gint)
declare sub gtk_icon_theme_get_search_path(byval icon_theme as GtkIconTheme ptr, byval path as gchar ptr ptr ptr, byval n_elements as gint ptr)
declare sub gtk_icon_theme_append_search_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
declare sub gtk_icon_theme_prepend_search_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
declare sub gtk_icon_theme_add_resource_path(byval icon_theme as GtkIconTheme ptr, byval path as const gchar ptr)
declare sub gtk_icon_theme_set_custom_theme(byval icon_theme as GtkIconTheme ptr, byval theme_name as const gchar ptr)
declare function gtk_icon_theme_has_icon(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr) as gboolean
declare function gtk_icon_theme_get_icon_sizes(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr) as gint ptr
declare function gtk_icon_theme_lookup_icon(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_lookup_icon_for_scale(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval scale as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_choose_icon(byval icon_theme as GtkIconTheme ptr, byval icon_names as const gchar ptr ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_choose_icon_for_scale(byval icon_theme as GtkIconTheme ptr, byval icon_names as const gchar ptr ptr, byval size as gint, byval scale as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_load_icon(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval flags as GtkIconLookupFlags, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_theme_load_icon_for_scale(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval scale as gint, byval flags as GtkIconLookupFlags, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_theme_load_surface(byval icon_theme as GtkIconTheme ptr, byval icon_name as const gchar ptr, byval size as gint, byval scale as gint, byval for_window as GdkWindow ptr, byval flags as GtkIconLookupFlags, byval error as GError ptr ptr) as cairo_surface_t ptr
declare function gtk_icon_theme_lookup_by_gicon(byval icon_theme as GtkIconTheme ptr, byval icon as GIcon ptr, byval size as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
declare function gtk_icon_theme_lookup_by_gicon_for_scale(byval icon_theme as GtkIconTheme ptr, byval icon as GIcon ptr, byval size as gint, byval scale as gint, byval flags as GtkIconLookupFlags) as GtkIconInfo ptr
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
declare function gtk_icon_info_get_base_scale(byval icon_info as GtkIconInfo ptr) as gint
declare function gtk_icon_info_get_filename(byval icon_info as GtkIconInfo ptr) as const gchar ptr
declare function gtk_icon_info_get_builtin_pixbuf(byval icon_info as GtkIconInfo ptr) as GdkPixbuf ptr
declare function gtk_icon_info_is_symbolic(byval icon_info as GtkIconInfo ptr) as gboolean
declare function gtk_icon_info_load_icon(byval icon_info as GtkIconInfo ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_info_load_surface(byval icon_info as GtkIconInfo ptr, byval for_window as GdkWindow ptr, byval error as GError ptr ptr) as cairo_surface_t ptr
declare sub gtk_icon_info_load_icon_async(byval icon_info as GtkIconInfo ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function gtk_icon_info_load_icon_finish(byval icon_info as GtkIconInfo ptr, byval res as GAsyncResult ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_info_load_symbolic(byval icon_info as GtkIconInfo ptr, byval fg as const GdkRGBA ptr, byval success_color as const GdkRGBA ptr, byval warning_color as const GdkRGBA ptr, byval error_color as const GdkRGBA ptr, byval was_symbolic as gboolean ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gtk_icon_info_load_symbolic_async(byval icon_info as GtkIconInfo ptr, byval fg as const GdkRGBA ptr, byval success_color as const GdkRGBA ptr, byval warning_color as const GdkRGBA ptr, byval error_color as const GdkRGBA ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function gtk_icon_info_load_symbolic_finish(byval icon_info as GtkIconInfo ptr, byval res as GAsyncResult ptr, byval was_symbolic as gboolean ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_info_load_symbolic_for_context(byval icon_info as GtkIconInfo ptr, byval context as GtkStyleContext ptr, byval was_symbolic as gboolean ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gtk_icon_info_load_symbolic_for_context_async(byval icon_info as GtkIconInfo ptr, byval context as GtkStyleContext ptr, byval cancellable as GCancellable ptr, byval callback as GAsyncReadyCallback, byval user_data as gpointer)
declare function gtk_icon_info_load_symbolic_for_context_finish(byval icon_info as GtkIconInfo ptr, byval res as GAsyncResult ptr, byval was_symbolic as gboolean ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare function gtk_icon_info_load_symbolic_for_style(byval icon_info as GtkIconInfo ptr, byval style as GtkStyle ptr, byval state as GtkStateType, byval was_symbolic as gboolean ptr, byval error as GError ptr ptr) as GdkPixbuf ptr
declare sub gtk_icon_info_set_raw_coordinates(byval icon_info as GtkIconInfo ptr, byval raw_coordinates as gboolean)
declare function gtk_icon_info_get_embedded_rect(byval icon_info as GtkIconInfo ptr, byval rectangle as GdkRectangle ptr) as gboolean
declare function gtk_icon_info_get_attach_points(byval icon_info as GtkIconInfo ptr, byval points as GdkPoint ptr ptr, byval n_points as gint ptr) as gboolean
declare function gtk_icon_info_get_display_name(byval icon_info as GtkIconInfo ptr) as const gchar ptr

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
	item_activated as sub(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr)
	selection_changed as sub(byval icon_view as GtkIconView ptr)
	select_all as sub(byval icon_view as GtkIconView ptr)
	unselect_all as sub(byval icon_view as GtkIconView ptr)
	select_cursor_item as sub(byval icon_view as GtkIconView ptr)
	toggle_cursor_item as sub(byval icon_view as GtkIconView ptr)
	move_cursor as function(byval icon_view as GtkIconView ptr, byval step as GtkMovementStep, byval count as gint) as gboolean
	activate_cursor_item as function(byval icon_view as GtkIconView ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_icon_view_get_type() as GType
declare function gtk_icon_view_new() as GtkWidget ptr
declare function gtk_icon_view_new_with_area(byval area as GtkCellArea ptr) as GtkWidget ptr
declare function gtk_icon_view_new_with_model(byval model as GtkTreeModel ptr) as GtkWidget ptr
declare sub gtk_icon_view_set_model(byval icon_view as GtkIconView ptr, byval model as GtkTreeModel ptr)
declare function gtk_icon_view_get_model(byval icon_view as GtkIconView ptr) as GtkTreeModel ptr
declare sub gtk_icon_view_set_text_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_text_column(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_markup_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_markup_column(byval icon_view as GtkIconView ptr) as gint
declare sub gtk_icon_view_set_pixbuf_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_pixbuf_column(byval icon_view as GtkIconView ptr) as gint
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
declare sub gtk_icon_view_set_activate_on_single_click(byval icon_view as GtkIconView ptr, byval single as gboolean)
declare function gtk_icon_view_get_activate_on_single_click(byval icon_view as GtkIconView ptr) as gboolean
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
declare function gtk_icon_view_create_drag_icon(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr) as cairo_surface_t ptr
declare sub gtk_icon_view_convert_widget_to_bin_window_coords(byval icon_view as GtkIconView ptr, byval wx as gint, byval wy as gint, byval bx as gint ptr, byval by as gint ptr)
declare function gtk_icon_view_get_cell_rect(byval icon_view as GtkIconView ptr, byval path as GtkTreePath ptr, byval cell as GtkCellRenderer ptr, byval rect as GdkRectangle ptr) as gboolean
declare sub gtk_icon_view_set_tooltip_item(byval icon_view as GtkIconView ptr, byval tooltip as GtkTooltip ptr, byval path as GtkTreePath ptr)
declare sub gtk_icon_view_set_tooltip_cell(byval icon_view as GtkIconView ptr, byval tooltip as GtkTooltip ptr, byval path as GtkTreePath ptr, byval cell as GtkCellRenderer ptr)
declare function gtk_icon_view_get_tooltip_context(byval icon_view as GtkIconView ptr, byval x as gint ptr, byval y as gint ptr, byval keyboard_tip as gboolean, byval model as GtkTreeModel ptr ptr, byval path as GtkTreePath ptr ptr, byval iter as GtkTreeIter ptr) as gboolean
declare sub gtk_icon_view_set_tooltip_column(byval icon_view as GtkIconView ptr, byval column as gint)
declare function gtk_icon_view_get_tooltip_column(byval icon_view as GtkIconView ptr) as gint
#define __GTK_IM_CONTEXT_INFO_H__
type GtkIMContextInfo as _GtkIMContextInfo

type _GtkIMContextInfo
	context_id as const gchar ptr
	context_name as const gchar ptr
	domain as const gchar ptr
	domain_dirname as const gchar ptr
	default_locales as const gchar ptr
end type

#define __GTK_IM_CONTEXT_SIMPLE_H__
const GTK_MAX_COMPOSE_LEN = 7
#define GTK_TYPE_IM_CONTEXT_SIMPLE gtk_im_context_simple_get_type()
#define GTK_IM_CONTEXT_SIMPLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimple)
#define GTK_IM_CONTEXT_SIMPLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass)
#define GTK_IS_IM_CONTEXT_SIMPLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IM_CONTEXT_SIMPLE)
#define GTK_IS_IM_CONTEXT_SIMPLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IM_CONTEXT_SIMPLE)
#define GTK_IM_CONTEXT_SIMPLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass)

type GtkIMContextSimple as _GtkIMContextSimple
type GtkIMContextSimplePrivate as _GtkIMContextSimplePrivate
type GtkIMContextSimpleClass as _GtkIMContextSimpleClass

type _GtkIMContextSimple
	object as GtkIMContext
	priv as GtkIMContextSimplePrivate ptr
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
	priv as GtkIMMulticontextPrivate ptr
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
	parent as GtkBox
	priv as GtkInfoBarPrivate ptr
end type

type _GtkInfoBarClass
	parent_class as GtkBoxClass
	response as sub(byval info_bar as GtkInfoBar ptr, byval response_id as gint)
	close as sub(byval info_bar as GtkInfoBar ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_info_bar_set_show_close_button(byval info_bar as GtkInfoBar ptr, byval setting as gboolean)
declare function gtk_info_bar_get_show_close_button(byval info_bar as GtkInfoBar ptr) as gboolean

#define __GTK_INVISIBLE_H__
#define GTK_TYPE_INVISIBLE gtk_invisible_get_type()
#define GTK_INVISIBLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_INVISIBLE, GtkInvisible)
#define GTK_INVISIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_INVISIBLE, GtkInvisibleClass)
#define GTK_IS_INVISIBLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_INVISIBLE)
#define GTK_IS_INVISIBLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_INVISIBLE)
#define GTK_INVISIBLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_INVISIBLE, GtkInvisibleClass)

type GtkInvisible as _GtkInvisible
type GtkInvisiblePrivate as _GtkInvisiblePrivate
type GtkInvisibleClass as _GtkInvisibleClass

type _GtkInvisible
	widget as GtkWidget
	priv as GtkInvisiblePrivate ptr
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
type GtkLayoutPrivate as _GtkLayoutPrivate
type GtkLayoutClass as _GtkLayoutClass

type _GtkLayout
	container as GtkContainer
	priv as GtkLayoutPrivate ptr
end type

type _GtkLayoutClass
	parent_class as GtkContainerClass
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

#define __GTK_LEVEL_BAR_H__
#define GTK_TYPE_LEVEL_BAR gtk_level_bar_get_type()
#define GTK_LEVEL_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LEVEL_BAR, GtkLevelBar)
#define GTK_LEVEL_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LEVEL_BAR, GtkLevelBarClass)
#define GTK_IS_LEVEL_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LEVEL_BAR)
#define GTK_IS_LEVEL_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LEVEL_BAR)
#define GTK_LEVEL_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LEVEL_BAR, GtkLevelBarClass)
#define GTK_LEVEL_BAR_OFFSET_LOW "low"
#define GTK_LEVEL_BAR_OFFSET_HIGH "high"

type GtkLevelBarClass as _GtkLevelBarClass
type GtkLevelBar as _GtkLevelBar
type GtkLevelBarPrivate as _GtkLevelBarPrivate

type _GtkLevelBar
	parent as GtkWidget
	priv as GtkLevelBarPrivate ptr
end type

type _GtkLevelBarClass
	parent_class as GtkWidgetClass
	offset_changed as sub(byval self as GtkLevelBar ptr, byval name as const gchar ptr)
	padding(0 to 15) as gpointer
end type

declare function gtk_level_bar_get_type() as GType
declare function gtk_level_bar_new() as GtkWidget ptr
declare function gtk_level_bar_new_for_interval(byval min_value as gdouble, byval max_value as gdouble) as GtkWidget ptr
declare sub gtk_level_bar_set_mode(byval self as GtkLevelBar ptr, byval mode as GtkLevelBarMode)
declare function gtk_level_bar_get_mode(byval self as GtkLevelBar ptr) as GtkLevelBarMode
declare sub gtk_level_bar_set_value(byval self as GtkLevelBar ptr, byval value as gdouble)
declare function gtk_level_bar_get_value(byval self as GtkLevelBar ptr) as gdouble
declare sub gtk_level_bar_set_min_value(byval self as GtkLevelBar ptr, byval value as gdouble)
declare function gtk_level_bar_get_min_value(byval self as GtkLevelBar ptr) as gdouble
declare sub gtk_level_bar_set_max_value(byval self as GtkLevelBar ptr, byval value as gdouble)
declare function gtk_level_bar_get_max_value(byval self as GtkLevelBar ptr) as gdouble
declare sub gtk_level_bar_set_inverted(byval self as GtkLevelBar ptr, byval inverted as gboolean)
declare function gtk_level_bar_get_inverted(byval self as GtkLevelBar ptr) as gboolean
declare sub gtk_level_bar_add_offset_value(byval self as GtkLevelBar ptr, byval name as const gchar ptr, byval value as gdouble)
declare sub gtk_level_bar_remove_offset_value(byval self as GtkLevelBar ptr, byval name as const gchar ptr)
declare function gtk_level_bar_get_offset_value(byval self as GtkLevelBar ptr, byval name as const gchar ptr, byval value as gdouble ptr) as gboolean

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

type _GtkLinkButton
	parent_instance as GtkButton
	priv as GtkLinkButtonPrivate ptr
end type

type _GtkLinkButtonClass
	parent_class as GtkButtonClass
	activate_link as function(byval button as GtkLinkButton ptr) as gboolean
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
declare function gtk_link_button_get_visited(byval link_button as GtkLinkButton ptr) as gboolean
declare sub gtk_link_button_set_visited(byval link_button as GtkLinkButton ptr, byval visited as gboolean)

#define __GTK_LIST_BOX_H__
#define GTK_TYPE_LIST_BOX gtk_list_box_get_type()
#define GTK_LIST_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LIST_BOX, GtkListBox)
#define GTK_LIST_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LIST_BOX, GtkListBoxClass)
#define GTK_IS_LIST_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LIST_BOX)
#define GTK_IS_LIST_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LIST_BOX)
#define GTK_LIST_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LIST_BOX, GtkListBoxClass)

type GtkListBox as _GtkListBox
type GtkListBoxClass as _GtkListBoxClass
type GtkListBoxRow as _GtkListBoxRow
type GtkListBoxRowClass as _GtkListBoxRowClass

type _GtkListBox
	parent_instance as GtkContainer
end type

type _GtkListBoxClass
	parent_class as GtkContainerClass
	row_selected as sub(byval box as GtkListBox ptr, byval row as GtkListBoxRow ptr)
	row_activated as sub(byval box as GtkListBox ptr, byval row as GtkListBoxRow ptr)
	activate_cursor_row as sub(byval box as GtkListBox ptr)
	toggle_cursor_row as sub(byval box as GtkListBox ptr)
	move_cursor as sub(byval box as GtkListBox ptr, byval step as GtkMovementStep, byval count as gint)
	selected_rows_changed as sub(byval box as GtkListBox ptr)
	select_all as sub(byval box as GtkListBox ptr)
	unselect_all as sub(byval box as GtkListBox ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
end type

#define GTK_TYPE_LIST_BOX_ROW gtk_list_box_row_get_type()
#define GTK_LIST_BOX_ROW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_LIST_BOX_ROW, GtkListBoxRow)
#define GTK_LIST_BOX_ROW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_LIST_BOX_ROW, GtkListBoxRowClass)
#define GTK_IS_LIST_BOX_ROW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_LIST_BOX_ROW)
#define GTK_IS_LIST_BOX_ROW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_LIST_BOX_ROW)
#define GTK_LIST_BOX_ROW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_LIST_BOX_ROW, GtkListBoxRowClass)

type _GtkListBoxRow
	parent_instance as GtkBin
end type

type _GtkListBoxRowClass
	parent_class as GtkBinClass
	activate as sub(byval row as GtkListBoxRow ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
end type

type GtkListBoxFilterFunc as function(byval row as GtkListBoxRow ptr, byval user_data as gpointer) as gboolean
type GtkListBoxSortFunc as function(byval row1 as GtkListBoxRow ptr, byval row2 as GtkListBoxRow ptr, byval user_data as gpointer) as gint
type GtkListBoxUpdateHeaderFunc as sub(byval row as GtkListBoxRow ptr, byval before as GtkListBoxRow ptr, byval user_data as gpointer)
type GtkListBoxCreateWidgetFunc as function(byval item as gpointer, byval user_data as gpointer) as GtkWidget ptr

declare function gtk_list_box_row_get_type() as GType
declare function gtk_list_box_row_new() as GtkWidget ptr
declare function gtk_list_box_row_get_header(byval row as GtkListBoxRow ptr) as GtkWidget ptr
declare sub gtk_list_box_row_set_header(byval row as GtkListBoxRow ptr, byval header as GtkWidget ptr)
declare function gtk_list_box_row_get_index(byval row as GtkListBoxRow ptr) as gint
declare sub gtk_list_box_row_changed(byval row as GtkListBoxRow ptr)
declare function gtk_list_box_row_is_selected(byval row as GtkListBoxRow ptr) as gboolean
declare sub gtk_list_box_row_set_selectable(byval row as GtkListBoxRow ptr, byval selectable as gboolean)
declare function gtk_list_box_row_get_selectable(byval row as GtkListBoxRow ptr) as gboolean
declare sub gtk_list_box_row_set_activatable(byval row as GtkListBoxRow ptr, byval activatable as gboolean)
declare function gtk_list_box_row_get_activatable(byval row as GtkListBoxRow ptr) as gboolean
declare function gtk_list_box_get_type() as GType
declare sub gtk_list_box_prepend(byval box as GtkListBox ptr, byval child as GtkWidget ptr)
declare sub gtk_list_box_insert(byval box as GtkListBox ptr, byval child as GtkWidget ptr, byval position as gint)
declare function gtk_list_box_get_selected_row(byval box as GtkListBox ptr) as GtkListBoxRow ptr
declare function gtk_list_box_get_row_at_index(byval box as GtkListBox ptr, byval index_ as gint) as GtkListBoxRow ptr
declare function gtk_list_box_get_row_at_y(byval box as GtkListBox ptr, byval y as gint) as GtkListBoxRow ptr
declare sub gtk_list_box_select_row(byval box as GtkListBox ptr, byval row as GtkListBoxRow ptr)
declare sub gtk_list_box_set_placeholder(byval box as GtkListBox ptr, byval placeholder as GtkWidget ptr)
declare sub gtk_list_box_set_adjustment(byval box as GtkListBox ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_list_box_get_adjustment(byval box as GtkListBox ptr) as GtkAdjustment ptr
type GtkListBoxForeachFunc as sub(byval box as GtkListBox ptr, byval row as GtkListBoxRow ptr, byval user_data as gpointer)
declare sub gtk_list_box_selected_foreach(byval box as GtkListBox ptr, byval func as GtkListBoxForeachFunc, byval data as gpointer)
declare function gtk_list_box_get_selected_rows(byval box as GtkListBox ptr) as GList ptr
declare sub gtk_list_box_unselect_row(byval box as GtkListBox ptr, byval row as GtkListBoxRow ptr)
declare sub gtk_list_box_select_all(byval box as GtkListBox ptr)
declare sub gtk_list_box_unselect_all(byval box as GtkListBox ptr)
declare sub gtk_list_box_set_selection_mode(byval box as GtkListBox ptr, byval mode as GtkSelectionMode)
declare function gtk_list_box_get_selection_mode(byval box as GtkListBox ptr) as GtkSelectionMode
declare sub gtk_list_box_set_filter_func(byval box as GtkListBox ptr, byval filter_func as GtkListBoxFilterFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_list_box_set_header_func(byval box as GtkListBox ptr, byval update_header as GtkListBoxUpdateHeaderFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_list_box_invalidate_filter(byval box as GtkListBox ptr)
declare sub gtk_list_box_invalidate_sort(byval box as GtkListBox ptr)
declare sub gtk_list_box_invalidate_headers(byval box as GtkListBox ptr)
declare sub gtk_list_box_set_sort_func(byval box as GtkListBox ptr, byval sort_func as GtkListBoxSortFunc, byval user_data as gpointer, byval destroy as GDestroyNotify)
declare sub gtk_list_box_set_activate_on_single_click(byval box as GtkListBox ptr, byval single as gboolean)
declare function gtk_list_box_get_activate_on_single_click(byval box as GtkListBox ptr) as gboolean
declare sub gtk_list_box_drag_unhighlight_row(byval box as GtkListBox ptr)
declare sub gtk_list_box_drag_highlight_row(byval box as GtkListBox ptr, byval row as GtkListBoxRow ptr)
declare function gtk_list_box_new() as GtkWidget ptr
declare sub gtk_list_box_bind_model(byval box as GtkListBox ptr, byval model as GListModel ptr, byval create_widget_func as GtkListBoxCreateWidgetFunc, byval user_data as gpointer, byval user_data_free_func as GDestroyNotify)

#define __GTK_LOCK_BUTTON_H__
#define GTK_TYPE_LOCK_BUTTON gtk_lock_button_get_type()
#define GTK_LOCK_BUTTON(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_LOCK_BUTTON, GtkLockButton)
#define GTK_LOCK_BUTTON_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GTK_LOCK_BUTTON, GtkLockButtonClass)
#define GTK_IS_LOCK_BUTTON(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_LOCK_BUTTON)
#define GTK_IS_LOCK_BUTTON_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GTK_TYPE_LOCK_BUTTON)
#define GTK_LOCK_BUTTON_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_LOCK_BUTTON, GtkLockButtonClass)

type GtkLockButton as _GtkLockButton
type GtkLockButtonClass as _GtkLockButtonClass
type GtkLockButtonPrivate as _GtkLockButtonPrivate

type _GtkLockButton
	parent as GtkButton
	priv as GtkLockButtonPrivate ptr
end type

type _GtkLockButtonClass
	parent_class as GtkButtonClass
	reserved0 as sub()
	reserved1 as sub()
	reserved2 as sub()
	reserved3 as sub()
	reserved4 as sub()
	reserved5 as sub()
	reserved6 as sub()
	reserved7 as sub()
end type

declare function gtk_lock_button_get_type() as GType
declare function gtk_lock_button_new(byval permission as GPermission ptr) as GtkWidget ptr
declare function gtk_lock_button_get_permission(byval button as GtkLockButton ptr) as GPermission ptr
declare sub gtk_lock_button_set_permission(byval button as GtkLockButton ptr, byval permission as GPermission ptr)
#define __GTK_MAIN_H__
const GTK_PRIORITY_RESIZE = G_PRIORITY_HIGH_IDLE + 10
type GtkKeySnoopFunc as function(byval grab_widget as GtkWidget ptr, byval event as GdkEventKey ptr, byval func_data as gpointer) as gint
declare function gtk_get_major_version() as guint
declare function gtk_get_minor_version() as guint
declare function gtk_get_micro_version() as guint
declare function gtk_get_binary_age() as guint
declare function gtk_get_interface_age() as guint
declare function gtk_check_version_ alias "gtk_check_version"(byval required_major as guint, byval required_minor as guint, byval required_micro as guint) as const gchar ptr
declare function gtk_parse_args(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean

#ifdef __FB_UNIX__
	declare sub gtk_init(byval argc as long ptr, byval argv as zstring ptr ptr ptr)
	declare function gtk_init_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
#else
	declare sub gtk_init_ alias "gtk_init"(byval argc as long ptr, byval argv as zstring ptr ptr ptr)
	declare function gtk_init_check_ alias "gtk_init_check"(byval argc as long ptr, byval argv as zstring ptr ptr ptr) as gboolean
#endif

declare function gtk_init_with_args(byval argc as gint ptr, byval argv as gchar ptr ptr ptr, byval parameter_string as const gchar ptr, byval entries as const GOptionEntry ptr, byval translation_domain as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_get_option_group(byval open_default_display as gboolean) as GOptionGroup ptr

#ifdef __FB_WIN32__
	declare sub gtk_init_abi_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr, byval num_checks as long, byval sizeof_GtkWindow as uinteger, byval sizeof_GtkBox as uinteger)
	declare function gtk_init_check_abi_check(byval argc as long ptr, byval argv as zstring ptr ptr ptr, byval num_checks as long, byval sizeof_GtkWindow as uinteger, byval sizeof_GtkBox as uinteger) as gboolean
	#define gtk_init(argc, argv) gtk_init_abi_check(argc, argv, 2, sizeof(GtkWindow), sizeof(GtkBox))
	#define gtk_init_check(argc, argv) gtk_init_check_abi_check(argc, argv, 2, sizeof(GtkWindow), sizeof(GtkBox))
#endif

declare sub gtk_disable_setlocale()
declare function gtk_get_default_language() as PangoLanguage ptr
declare function gtk_get_locale_direction() as GtkTextDirection
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
declare sub gtk_device_grab_add(byval widget as GtkWidget ptr, byval device as GdkDevice ptr, byval block_others as gboolean)
declare sub gtk_device_grab_remove(byval widget as GtkWidget ptr, byval device as GdkDevice ptr)
declare function gtk_key_snooper_install(byval snooper as GtkKeySnoopFunc, byval func_data as gpointer) as guint
declare sub gtk_key_snooper_remove(byval snooper_handler_id as guint)
declare function gtk_get_current_event() as GdkEvent ptr
declare function gtk_get_current_event_time() as guint32
declare function gtk_get_current_event_state(byval state as GdkModifierType ptr) as gboolean
declare function gtk_get_current_event_device() as GdkDevice ptr
declare function gtk_get_event_widget(byval event as GdkEvent ptr) as GtkWidget ptr
declare sub gtk_propagate_event(byval widget as GtkWidget ptr, byval event as GdkEvent ptr)

#define __GTK_MENU_BAR_H__
#define GTK_TYPE_MENU_BAR gtk_menu_bar_get_type()
#define GTK_MENU_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU_BAR, GtkMenuBar)
#define GTK_MENU_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU_BAR, GtkMenuBarClass)
#define GTK_IS_MENU_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU_BAR)
#define GTK_IS_MENU_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU_BAR)
#define GTK_MENU_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU_BAR, GtkMenuBarClass)

type GtkMenuBar as _GtkMenuBar
type GtkMenuBarPrivate as _GtkMenuBarPrivate
type GtkMenuBarClass as _GtkMenuBarClass

type _GtkMenuBar
	menu_shell as GtkMenuShell
	priv as GtkMenuBarPrivate ptr
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
declare function gtk_menu_bar_new_from_model(byval model as GMenuModel ptr) as GtkWidget ptr
declare function gtk_menu_bar_get_pack_direction(byval menubar as GtkMenuBar ptr) as GtkPackDirection
declare sub gtk_menu_bar_set_pack_direction(byval menubar as GtkMenuBar ptr, byval pack_dir as GtkPackDirection)
declare function gtk_menu_bar_get_child_pack_direction(byval menubar as GtkMenuBar ptr) as GtkPackDirection
declare sub gtk_menu_bar_set_child_pack_direction(byval menubar as GtkMenuBar ptr, byval child_pack_dir as GtkPackDirection)
declare sub _gtk_menu_bar_cycle_focus(byval menubar as GtkMenuBar ptr, byval dir as GtkDirectionType)
declare function _gtk_menu_bar_get_viewable_menu_bars(byval window as GtkWindow ptr) as GList ptr

#define __GTK_MENU_BUTTON_H__
#define __GTK_POPOVER_H__
#define GTK_TYPE_POPOVER gtk_popover_get_type()
#define GTK_POPOVER(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_POPOVER, GtkPopover)
#define GTK_POPOVER_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_POPOVER, GtkPopoverClass)
#define GTK_IS_POPOVER(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_POPOVER)
#define GTK_IS_POPOVER_CLASS(o) G_TYPE_CHECK_CLASS_TYPE((o), GTK_TYPE_POPOVER)
#define GTK_POPOVER_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_POPOVER, GtkPopoverClass)

type GtkPopover as _GtkPopover
type GtkPopoverClass as _GtkPopoverClass
type GtkPopoverPrivate as _GtkPopoverPrivate

type _GtkPopover
	parent_instance as GtkBin
	priv as GtkPopoverPrivate ptr
end type

type _GtkPopoverClass
	parent_class as GtkBinClass
	closed as sub(byval popover as GtkPopover ptr)
	reserved(0 to 9) as gpointer
end type

declare function gtk_popover_get_type() as GType
declare function gtk_popover_new(byval relative_to as GtkWidget ptr) as GtkWidget ptr
declare function gtk_popover_new_from_model(byval relative_to as GtkWidget ptr, byval model as GMenuModel ptr) as GtkWidget ptr
declare sub gtk_popover_set_relative_to(byval popover as GtkPopover ptr, byval relative_to as GtkWidget ptr)
declare function gtk_popover_get_relative_to(byval popover as GtkPopover ptr) as GtkWidget ptr
declare sub gtk_popover_set_pointing_to(byval popover as GtkPopover ptr, byval rect as const GdkRectangle ptr)
declare function gtk_popover_get_pointing_to(byval popover as GtkPopover ptr, byval rect as GdkRectangle ptr) as gboolean
declare sub gtk_popover_set_position(byval popover as GtkPopover ptr, byval position as GtkPositionType)
declare function gtk_popover_get_position(byval popover as GtkPopover ptr) as GtkPositionType
declare sub gtk_popover_set_modal(byval popover as GtkPopover ptr, byval modal as gboolean)
declare function gtk_popover_get_modal(byval popover as GtkPopover ptr) as gboolean
declare sub gtk_popover_bind_model(byval popover as GtkPopover ptr, byval model as GMenuModel ptr, byval action_namespace as const gchar ptr)
declare sub gtk_popover_set_transitions_enabled(byval popover as GtkPopover ptr, byval transitions_enabled as gboolean)
declare function gtk_popover_get_transitions_enabled(byval popover as GtkPopover ptr) as gboolean

#define GTK_TYPE_MENU_BUTTON gtk_menu_button_get_type()
#define GTK_MENU_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_MENU_BUTTON, GtkMenuButton)
#define GTK_MENU_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_MENU_BUTTON, GtkMenuButtonClass)
#define GTK_IS_MENU_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_MENU_BUTTON)
#define GTK_IS_MENU_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_MENU_BUTTON)
#define GTK_MENU_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_MENU_BUTTON, GtkMenuButtonClass)

type GtkMenuButton as _GtkMenuButton
type GtkMenuButtonClass as _GtkMenuButtonClass
type GtkMenuButtonPrivate as _GtkMenuButtonPrivate

type _GtkMenuButton
	parent as GtkToggleButton
	priv as GtkMenuButtonPrivate ptr
end type

type _GtkMenuButtonClass
	parent_class as GtkToggleButtonClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_menu_button_get_type() as GType
declare function gtk_menu_button_new() as GtkWidget ptr
declare sub gtk_menu_button_set_popup(byval menu_button as GtkMenuButton ptr, byval menu as GtkWidget ptr)
declare function gtk_menu_button_get_popup(byval menu_button as GtkMenuButton ptr) as GtkMenu ptr
declare sub gtk_menu_button_set_popover(byval menu_button as GtkMenuButton ptr, byval popover as GtkWidget ptr)
declare function gtk_menu_button_get_popover(byval menu_button as GtkMenuButton ptr) as GtkPopover ptr
declare sub gtk_menu_button_set_direction(byval menu_button as GtkMenuButton ptr, byval direction as GtkArrowType)
declare function gtk_menu_button_get_direction(byval menu_button as GtkMenuButton ptr) as GtkArrowType
declare sub gtk_menu_button_set_menu_model(byval menu_button as GtkMenuButton ptr, byval menu_model as GMenuModel ptr)
declare function gtk_menu_button_get_menu_model(byval menu_button as GtkMenuButton ptr) as GMenuModel ptr
declare sub gtk_menu_button_set_align_widget(byval menu_button as GtkMenuButton ptr, byval align_widget as GtkWidget ptr)
declare function gtk_menu_button_get_align_widget(byval menu_button as GtkMenuButton ptr) as GtkWidget ptr
declare sub gtk_menu_button_set_use_popover(byval menu_button as GtkMenuButton ptr, byval use_popover as gboolean)
declare function gtk_menu_button_get_use_popover(byval menu_button as GtkMenuButton ptr) as gboolean

#define __GTK_MENU_TOOL_BUTTON_H__
#define __GTK_TOOL_BUTTON_H__
#define __GTK_TOOL_ITEM_H__
#define __GTK_SIZE_GROUP_H__
#define GTK_TYPE_SIZE_GROUP gtk_size_group_get_type()
#define GTK_SIZE_GROUP(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroup)
#define GTK_SIZE_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass)
#define GTK_IS_SIZE_GROUP(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SIZE_GROUP)
#define GTK_IS_SIZE_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SIZE_GROUP)
#define GTK_SIZE_GROUP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass)

type GtkSizeGroup as _GtkSizeGroup
type GtkSizeGroupPrivate as _GtkSizeGroupPrivate
type GtkSizeGroupClass as _GtkSizeGroupClass

type _GtkSizeGroup
	parent_instance as GObject
	priv as GtkSizeGroupPrivate ptr
end type

type _GtkSizeGroupClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_size_group_get_type() as GType
declare function gtk_size_group_new(byval mode as GtkSizeGroupMode) as GtkSizeGroup ptr
declare sub gtk_size_group_set_mode(byval size_group as GtkSizeGroup ptr, byval mode as GtkSizeGroupMode)
declare function gtk_size_group_get_mode(byval size_group as GtkSizeGroup ptr) as GtkSizeGroupMode
declare sub gtk_size_group_set_ignore_hidden(byval size_group as GtkSizeGroup ptr, byval ignore_hidden as gboolean)
declare function gtk_size_group_get_ignore_hidden(byval size_group as GtkSizeGroup ptr) as gboolean
declare sub gtk_size_group_add_widget(byval size_group as GtkSizeGroup ptr, byval widget as GtkWidget ptr)
declare sub gtk_size_group_remove_widget(byval size_group as GtkSizeGroup ptr, byval widget as GtkWidget ptr)
declare function gtk_size_group_get_widgets(byval size_group as GtkSizeGroup ptr) as GSList ptr

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
type GtkMessageDialogPrivate as _GtkMessageDialogPrivate
type GtkMessageDialogClass as _GtkMessageDialogClass

type _GtkMessageDialog
	parent_instance as GtkDialog
	priv as GtkMessageDialogPrivate ptr
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

#define __GTK_MODEL_BUTTON_H__
#define GTK_TYPE_MODEL_BUTTON gtk_model_button_get_type()
#define GTK_MODEL_BUTTON(inst) G_TYPE_CHECK_INSTANCE_CAST((inst), GTK_TYPE_MODEL_BUTTON, GtkModelButton)
#define GTK_IS_MODEL_BUTTON(inst) G_TYPE_CHECK_INSTANCE_TYPE((inst), GTK_TYPE_MODEL_BUTTON)
type GtkModelButton as _GtkModelButton

type GtkButtonRole as long
enum
	GTK_BUTTON_ROLE_NORMAL
	GTK_BUTTON_ROLE_CHECK
	GTK_BUTTON_ROLE_RADIO
end enum

declare function gtk_model_button_get_type() as GType
declare function gtk_model_button_new() as GtkWidget ptr
#define __GTK_MODULES_H__
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
type GtkNotebookPrivate as _GtkNotebookPrivate
type GtkNotebookClass as _GtkNotebookClass

type _GtkNotebook
	container as GtkContainer
	priv as GtkNotebookPrivate ptr
end type

type _GtkNotebookClass
	parent_class as GtkContainerClass
	switch_page as sub(byval notebook as GtkNotebook ptr, byval page as GtkWidget ptr, byval page_num as guint)
	select_page as function(byval notebook as GtkNotebook ptr, byval move_focus as gboolean) as gboolean
	focus_tab as function(byval notebook as GtkNotebook ptr, byval type as GtkNotebookTab) as gboolean
	change_current_page as function(byval notebook as GtkNotebook ptr, byval offset as gint) as gboolean
	move_focus_out as sub(byval notebook as GtkNotebook ptr, byval direction as GtkDirectionType)
	reorder_tab as function(byval notebook as GtkNotebook ptr, byval direction as GtkDirectionType, byval move_to_last as gboolean) as gboolean
	insert_page as function(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr, byval position as gint) as gint
	create_window as function(byval notebook as GtkNotebook ptr, byval page as GtkWidget ptr, byval x as gint, byval y as gint) as GtkNotebook ptr
	page_reordered as sub(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval page_num as guint)
	page_removed as sub(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval page_num as guint)
	page_added as sub(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval page_num as guint)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

declare function gtk_notebook_get_type() as GType
declare function gtk_notebook_new() as GtkWidget ptr
declare function gtk_notebook_append_page(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr) as gint
declare function gtk_notebook_append_page_menu(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr) as gint
declare function gtk_notebook_prepend_page(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr) as gint
declare function gtk_notebook_prepend_page_menu(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr) as gint
declare function gtk_notebook_insert_page(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval position as gint) as gint
declare function gtk_notebook_insert_page_menu(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval tab_label as GtkWidget ptr, byval menu_label as GtkWidget ptr, byval position as gint) as gint
declare sub gtk_notebook_remove_page(byval notebook as GtkNotebook ptr, byval page_num as gint)
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
declare sub gtk_notebook_reorder_child(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval position as gint)
declare function gtk_notebook_get_tab_reorderable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_notebook_set_tab_reorderable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval reorderable as gboolean)
declare function gtk_notebook_get_tab_detachable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr) as gboolean
declare sub gtk_notebook_set_tab_detachable(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr, byval detachable as gboolean)
declare sub gtk_notebook_detach_tab(byval notebook as GtkNotebook ptr, byval child as GtkWidget ptr)
declare function gtk_notebook_get_action_widget(byval notebook as GtkNotebook ptr, byval pack_type as GtkPackType) as GtkWidget ptr
declare sub gtk_notebook_set_action_widget(byval notebook as GtkNotebook ptr, byval widget as GtkWidget ptr, byval pack_type as GtkPackType)

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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_offscreen_window_get_type() as GType
declare function gtk_offscreen_window_new() as GtkWidget ptr
declare function gtk_offscreen_window_get_surface(byval offscreen as GtkOffscreenWindow ptr) as cairo_surface_t ptr
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

#define __GTK_OVERLAY_H__
#define GTK_TYPE_OVERLAY gtk_overlay_get_type()
#define GTK_OVERLAY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_OVERLAY, GtkOverlay)
#define GTK_OVERLAY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_OVERLAY, GtkOverlayClass)
#define GTK_IS_OVERLAY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_OVERLAY)
#define GTK_IS_OVERLAY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_OVERLAY)
#define GTK_OVERLAY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_OVERLAY, GtkOverlayClass)

type GtkOverlay as _GtkOverlay
type GtkOverlayClass as _GtkOverlayClass
type GtkOverlayPrivate as _GtkOverlayPrivate

type _GtkOverlay
	parent as GtkBin
	priv as GtkOverlayPrivate ptr
end type

type _GtkOverlayClass
	parent_class as GtkBinClass
	get_child_position as function(byval overlay as GtkOverlay ptr, byval widget as GtkWidget ptr, byval allocation as GtkAllocation ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
	_gtk_reserved6 as sub()
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
end type

declare function gtk_overlay_get_type() as GType
declare function gtk_overlay_new() as GtkWidget ptr
declare sub gtk_overlay_add_overlay(byval overlay as GtkOverlay ptr, byval widget as GtkWidget ptr)
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
declare function gtk_paper_size_new_from_ipp(byval ipp_name as const gchar ptr, byval width as gdouble, byval height as gdouble) as GtkPaperSize ptr
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
declare function gtk_paper_size_is_ipp(byval size as GtkPaperSize ptr) as gboolean
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
	priv as GtkPanedPrivate ptr
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
declare function gtk_paned_new(byval orientation as GtkOrientation) as GtkWidget ptr
declare sub gtk_paned_add1(byval paned as GtkPaned ptr, byval child as GtkWidget ptr)
declare sub gtk_paned_add2(byval paned as GtkPaned ptr, byval child as GtkWidget ptr)
declare sub gtk_paned_pack1(byval paned as GtkPaned ptr, byval child as GtkWidget ptr, byval resize as gboolean, byval shrink as gboolean)
declare sub gtk_paned_pack2(byval paned as GtkPaned ptr, byval child as GtkWidget ptr, byval resize as gboolean, byval shrink as gboolean)
declare function gtk_paned_get_position(byval paned as GtkPaned ptr) as gint
declare sub gtk_paned_set_position(byval paned as GtkPaned ptr, byval position as gint)
declare function gtk_paned_get_child1(byval paned as GtkPaned ptr) as GtkWidget ptr
declare function gtk_paned_get_child2(byval paned as GtkPaned ptr) as GtkWidget ptr
declare function gtk_paned_get_handle_window(byval paned as GtkPaned ptr) as GdkWindow ptr
declare sub gtk_paned_set_wide_handle(byval paned as GtkPaned ptr, byval wide as gboolean)
declare function gtk_paned_get_wide_handle(byval paned as GtkPaned ptr) as gboolean

#define __GTK_PLACES_SIDEBAR_H__
#define GTK_TYPE_PLACES_SIDEBAR gtk_places_sidebar_get_type()
#define GTK_PLACES_SIDEBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PLACES_SIDEBAR, GtkPlacesSidebar)
#define GTK_PLACES_SIDEBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PLACES_SIDEBAR, GtkPlacesSidebarClass)
#define GTK_IS_PLACES_SIDEBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PLACES_SIDEBAR)
#define GTK_IS_PLACES_SIDEBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PLACES_SIDEBAR)
#define GTK_PLACES_SIDEBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PLACES_SIDEBAR, GtkPlacesSidebarClass)
type GtkPlacesSidebar as _GtkPlacesSidebar
type GtkPlacesSidebarClass as _GtkPlacesSidebarClass

type GtkPlacesOpenFlags as long
enum
	GTK_PLACES_OPEN_NORMAL = 1 shl 0
	GTK_PLACES_OPEN_NEW_TAB = 1 shl 1
	GTK_PLACES_OPEN_NEW_WINDOW = 1 shl 2
end enum

declare function gtk_places_sidebar_get_type() as GType
declare function gtk_places_sidebar_new() as GtkWidget ptr
declare function gtk_places_sidebar_get_open_flags(byval sidebar as GtkPlacesSidebar ptr) as GtkPlacesOpenFlags
declare sub gtk_places_sidebar_set_open_flags(byval sidebar as GtkPlacesSidebar ptr, byval flags as GtkPlacesOpenFlags)
declare function gtk_places_sidebar_get_location(byval sidebar as GtkPlacesSidebar ptr) as GFile ptr
declare sub gtk_places_sidebar_set_location(byval sidebar as GtkPlacesSidebar ptr, byval location as GFile ptr)
declare function gtk_places_sidebar_get_show_desktop(byval sidebar as GtkPlacesSidebar ptr) as gboolean
declare sub gtk_places_sidebar_set_show_desktop(byval sidebar as GtkPlacesSidebar ptr, byval show_desktop as gboolean)
declare function gtk_places_sidebar_get_show_connect_to_server(byval sidebar as GtkPlacesSidebar ptr) as gboolean
declare sub gtk_places_sidebar_set_show_connect_to_server(byval sidebar as GtkPlacesSidebar ptr, byval show_connect_to_server as gboolean)
declare function gtk_places_sidebar_get_show_enter_location(byval sidebar as GtkPlacesSidebar ptr) as gboolean
declare sub gtk_places_sidebar_set_show_enter_location(byval sidebar as GtkPlacesSidebar ptr, byval show_enter_location as gboolean)
declare sub gtk_places_sidebar_set_local_only(byval sidebar as GtkPlacesSidebar ptr, byval local_only as gboolean)
declare function gtk_places_sidebar_get_local_only(byval sidebar as GtkPlacesSidebar ptr) as gboolean
declare sub gtk_places_sidebar_add_shortcut(byval sidebar as GtkPlacesSidebar ptr, byval location as GFile ptr)
declare sub gtk_places_sidebar_remove_shortcut(byval sidebar as GtkPlacesSidebar ptr, byval location as GFile ptr)
declare function gtk_places_sidebar_list_shortcuts(byval sidebar as GtkPlacesSidebar ptr) as GSList ptr
declare function gtk_places_sidebar_get_nth_bookmark(byval sidebar as GtkPlacesSidebar ptr, byval n as gint) as GFile ptr

#define __GTK_POPOVER_MENU_H__
#define GTK_TYPE_POPOVER_MENU gtk_popover_menu_get_type()
#define GTK_POPOVER_MENU(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_POPOVER_MENU, GtkPopoverMenu)
#define GTK_POPOVER_MENU_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_POPOVER_MENU, GtkPopoverMenuClass)
#define GTK_IS_POPOVER_MENU(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_POPOVER_MENU)
#define GTK_IS_POPOVER_MENU_CLASS(o) G_TYPE_CHECK_CLASS_TYPE((o), GTK_TYPE_POPOVER_MENU)
#define GTK_POPOVER_MENU_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_POPOVER_MENU, GtkPopoverMenuClass)
type GtkPopoverMenu as _GtkPopoverMenu
type GtkPopoverMenuClass as _GtkPopoverMenuClass

type _GtkPopoverMenuClass
	parent_class as GtkPopoverClass
	reserved(0 to 9) as gpointer
end type

declare function gtk_popover_menu_get_type() as GType
declare function gtk_popover_menu_new() as GtkWidget ptr
declare sub gtk_popover_menu_open_submenu(byval popover as GtkPopoverMenu ptr, byval name as const gchar ptr)
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
#define GTK_PRINT_SETTINGS_OUTPUT_DIR "output-dir"
#define GTK_PRINT_SETTINGS_OUTPUT_BASENAME "output-basename"
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
	_gtk_reserved8 as sub()
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
	_gtk_reserved7 as sub()
	_gtk_reserved8 as sub()
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
#define GTK_TYPE_PROGRESS_BAR gtk_progress_bar_get_type()
#define GTK_PROGRESS_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBar)
#define GTK_PROGRESS_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_PROGRESS_BAR, GtkProgressBarClass)
#define GTK_IS_PROGRESS_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_PROGRESS_BAR)
#define GTK_IS_PROGRESS_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_PROGRESS_BAR)
#define GTK_PROGRESS_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBarClass)

type GtkProgressBar as _GtkProgressBar
type GtkProgressBarPrivate as _GtkProgressBarPrivate
type GtkProgressBarClass as _GtkProgressBarClass

type _GtkProgressBar
	parent as GtkWidget
	priv as GtkProgressBarPrivate ptr
end type

type _GtkProgressBarClass
	parent_class as GtkWidgetClass
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
declare sub gtk_progress_bar_set_inverted(byval pbar as GtkProgressBar ptr, byval inverted as gboolean)
declare function gtk_progress_bar_get_text(byval pbar as GtkProgressBar ptr) as const gchar ptr
declare function gtk_progress_bar_get_fraction(byval pbar as GtkProgressBar ptr) as gdouble
declare function gtk_progress_bar_get_pulse_step(byval pbar as GtkProgressBar ptr) as gdouble
declare function gtk_progress_bar_get_inverted(byval pbar as GtkProgressBar ptr) as gboolean
declare sub gtk_progress_bar_set_ellipsize(byval pbar as GtkProgressBar ptr, byval mode as PangoEllipsizeMode)
declare function gtk_progress_bar_get_ellipsize(byval pbar as GtkProgressBar ptr) as PangoEllipsizeMode
declare sub gtk_progress_bar_set_show_text(byval pbar as GtkProgressBar ptr, byval show_text as gboolean)
declare function gtk_progress_bar_get_show_text(byval pbar as GtkProgressBar ptr) as gboolean

#define __GTK_RADIO_BUTTON_H__
#define GTK_TYPE_RADIO_BUTTON gtk_radio_button_get_type()
#define GTK_RADIO_BUTTON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButton)
#define GTK_RADIO_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass)
#define GTK_IS_RADIO_BUTTON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RADIO_BUTTON)
#define GTK_IS_RADIO_BUTTON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RADIO_BUTTON)
#define GTK_RADIO_BUTTON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass)

type GtkRadioButton as _GtkRadioButton
type GtkRadioButtonPrivate as _GtkRadioButtonPrivate
type GtkRadioButtonClass as _GtkRadioButtonClass

type _GtkRadioButton
	check_button as GtkCheckButton
	priv as GtkRadioButtonPrivate ptr
end type

type _GtkRadioButtonClass
	parent_class as GtkCheckButtonClass
	group_changed as sub(byval radio_button as GtkRadioButton ptr)
	_gtk_reserved1 as sub()
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
declare sub gtk_radio_button_join_group(byval radio_button as GtkRadioButton ptr, byval group_source as GtkRadioButton ptr)

#define __GTK_RADIO_MENU_ITEM_H__
#define GTK_TYPE_RADIO_MENU_ITEM gtk_radio_menu_item_get_type()
#define GTK_RADIO_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItem)
#define GTK_RADIO_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass)
#define GTK_IS_RADIO_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RADIO_MENU_ITEM)
#define GTK_IS_RADIO_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RADIO_MENU_ITEM)
#define GTK_RADIO_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass)

type GtkRadioMenuItem as _GtkRadioMenuItem
type GtkRadioMenuItemPrivate as _GtkRadioMenuItemPrivate
type GtkRadioMenuItemClass as _GtkRadioMenuItemClass

type _GtkRadioMenuItem
	check_menu_item as GtkCheckMenuItem
	priv as GtkRadioMenuItemPrivate ptr
end type

type _GtkRadioMenuItemClass
	parent_class as GtkCheckMenuItemClass
	group_changed as sub(byval radio_menu_item as GtkRadioMenuItem ptr)
	_gtk_reserved1 as sub()
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

#define __GTK_RANGE_H__
#define GTK_TYPE_RANGE gtk_range_get_type()
#define GTK_RANGE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_RANGE, GtkRange)
#define GTK_RANGE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_RANGE, GtkRangeClass)
#define GTK_IS_RANGE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_RANGE)
#define GTK_IS_RANGE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_RANGE)
#define GTK_RANGE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RANGE, GtkRangeClass)

type GtkRange as _GtkRange
type GtkRangePrivate as _GtkRangePrivate
type GtkRangeClass as _GtkRangeClass

type _GtkRange
	widget as GtkWidget
	priv as GtkRangePrivate ptr
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
	_gtk_reserved4 as sub()
end type

declare function gtk_range_get_type() as GType
declare sub gtk_range_set_adjustment(byval range as GtkRange ptr, byval adjustment as GtkAdjustment ptr)
declare function gtk_range_get_adjustment(byval range as GtkRange ptr) as GtkAdjustment ptr
declare sub gtk_range_set_inverted(byval range as GtkRange ptr, byval setting as gboolean)
declare function gtk_range_get_inverted(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_flippable(byval range as GtkRange ptr, byval flippable as gboolean)
declare function gtk_range_get_flippable(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_slider_size_fixed(byval range as GtkRange ptr, byval size_fixed as gboolean)
declare function gtk_range_get_slider_size_fixed(byval range as GtkRange ptr) as gboolean
declare sub gtk_range_set_min_slider_size(byval range as GtkRange ptr, byval min_size as gint)
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

#define __GTK_RECENT_CHOOSER_H__
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
declare function gtk_recent_manager_add_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr) as gboolean
declare function gtk_recent_manager_add_full(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval recent_data as const GtkRecentData ptr) as gboolean
declare function gtk_recent_manager_remove_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
declare function gtk_recent_manager_lookup_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval error as GError ptr ptr) as GtkRecentInfo ptr
declare function gtk_recent_manager_has_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr) as gboolean
declare function gtk_recent_manager_move_item(byval manager as GtkRecentManager ptr, byval uri as const gchar ptr, byval new_uri as const gchar ptr, byval error as GError ptr ptr) as gboolean
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
declare function gtk_recent_info_create_app_info(byval info as GtkRecentInfo ptr, byval app_name as const gchar ptr, byval error as GError ptr ptr) as GAppInfo ptr
declare function gtk_recent_info_get_applications(byval info as GtkRecentInfo ptr, byval length as gsize ptr) as gchar ptr ptr
declare function gtk_recent_info_last_application(byval info as GtkRecentInfo ptr) as gchar ptr
declare function gtk_recent_info_has_application(byval info as GtkRecentInfo ptr, byval app_name as const gchar ptr) as gboolean
declare function gtk_recent_info_get_groups(byval info as GtkRecentInfo ptr, byval length as gsize ptr) as gchar ptr ptr
declare function gtk_recent_info_has_group(byval info as GtkRecentInfo ptr, byval group_name as const gchar ptr) as gboolean
declare function gtk_recent_info_get_icon(byval info as GtkRecentInfo ptr, byval size as gint) as GdkPixbuf ptr
declare function gtk_recent_info_get_gicon(byval info as GtkRecentInfo ptr) as GIcon ptr
declare function gtk_recent_info_get_short_name(byval info as GtkRecentInfo ptr) as gchar ptr
declare function gtk_recent_info_get_uri_display(byval info as GtkRecentInfo ptr) as gchar ptr
declare function gtk_recent_info_get_age(byval info as GtkRecentInfo ptr) as gint
declare function gtk_recent_info_is_local(byval info as GtkRecentInfo ptr) as gboolean
declare function gtk_recent_info_exists(byval info as GtkRecentInfo ptr) as gboolean
declare function gtk_recent_info_match(byval info_a as GtkRecentInfo ptr, byval info_b as GtkRecentInfo ptr) as gboolean
declare sub _gtk_recent_manager_sync()

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
	set_sort_func as sub(byval chooser as GtkRecentChooser ptr, byval sort_func as GtkRecentSortFunc, byval sort_data as gpointer, byval data_destroy as GDestroyNotify)
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
	parent_instance as GtkBox
	priv as GtkRecentChooserWidgetPrivate ptr
end type

type _GtkRecentChooserWidgetClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_recent_chooser_widget_get_type() as GType
declare function gtk_recent_chooser_widget_new() as GtkWidget ptr
declare function gtk_recent_chooser_widget_new_for_manager(byval manager as GtkRecentManager ptr) as GtkWidget ptr
#define __GTK_RENDER_H__
declare sub gtk_render_check(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_option(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_arrow(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval angle as gdouble, byval x as gdouble, byval y as gdouble, byval size as gdouble)
declare sub gtk_render_background(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_frame(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_expander(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_focus(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_layout(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval layout as PangoLayout ptr)
declare sub gtk_render_line(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x0 as gdouble, byval y0 as gdouble, byval x1 as gdouble, byval y1 as gdouble)
declare sub gtk_render_slider(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble, byval orientation as GtkOrientation)
declare sub gtk_render_frame_gap(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble, byval gap_side as GtkPositionType, byval xy0_gap as gdouble, byval xy1_gap as gdouble)
declare sub gtk_render_extension(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble, byval gap_side as GtkPositionType)
declare sub gtk_render_handle(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare sub gtk_render_activity(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
declare function gtk_render_icon_pixbuf(byval context as GtkStyleContext ptr, byval source as const GtkIconSource ptr, byval size as GtkIconSize) as GdkPixbuf ptr
declare sub gtk_render_icon(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval pixbuf as GdkPixbuf ptr, byval x as gdouble, byval y as gdouble)
declare sub gtk_render_icon_surface(byval context as GtkStyleContext ptr, byval cr as cairo_t ptr, byval surface as cairo_surface_t ptr, byval x as gdouble, byval y as gdouble)

#define __GTK_REVEALER_H__
#define GTK_TYPE_REVEALER gtk_revealer_get_type()
#define GTK_REVEALER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_REVEALER, GtkRevealer)
#define GTK_REVEALER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_REVEALER, GtkRevealerClass)
#define GTK_IS_REVEALER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_REVEALER)
#define GTK_IS_REVEALER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_REVEALER)
#define GTK_REVEALER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_REVEALER, GtkRevealerClass)
type GtkRevealer as _GtkRevealer
type GtkRevealerClass as _GtkRevealerClass

type GtkRevealerTransitionType as long
enum
	GTK_REVEALER_TRANSITION_TYPE_NONE
	GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
end enum

type _GtkRevealer
	parent_instance as GtkBin
end type

type _GtkRevealerClass
	parent_class as GtkBinClass
end type

declare function gtk_revealer_get_type() as GType
declare function gtk_revealer_new() as GtkWidget ptr
declare function gtk_revealer_get_reveal_child(byval revealer as GtkRevealer ptr) as gboolean
declare sub gtk_revealer_set_reveal_child(byval revealer as GtkRevealer ptr, byval reveal_child as gboolean)
declare function gtk_revealer_get_child_revealed(byval revealer as GtkRevealer ptr) as gboolean
declare function gtk_revealer_get_transition_duration(byval revealer as GtkRevealer ptr) as guint
declare sub gtk_revealer_set_transition_duration(byval revealer as GtkRevealer ptr, byval duration as guint)
declare sub gtk_revealer_set_transition_type(byval revealer as GtkRevealer ptr, byval transition as GtkRevealerTransitionType)
declare function gtk_revealer_get_transition_type(byval revealer as GtkRevealer ptr) as GtkRevealerTransitionType

#define __GTK_SCALE_H__
#define GTK_TYPE_SCALE gtk_scale_get_type()
#define GTK_SCALE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCALE, GtkScale)
#define GTK_SCALE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SCALE, GtkScaleClass)
#define GTK_IS_SCALE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCALE)
#define GTK_IS_SCALE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SCALE)
#define GTK_SCALE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SCALE, GtkScaleClass)

type GtkScale as _GtkScale
type GtkScalePrivate as _GtkScalePrivate
type GtkScaleClass as _GtkScaleClass

type _GtkScale
	range as GtkRange
	priv as GtkScalePrivate ptr
end type

type _GtkScaleClass
	parent_class as GtkRangeClass
	format_value as function(byval scale as GtkScale ptr, byval value as gdouble) as gchar ptr
	draw_value as sub(byval scale as GtkScale ptr)
	get_layout_offsets as sub(byval scale as GtkScale ptr, byval x as gint ptr, byval y as gint ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_scale_get_type() as GType
declare function gtk_scale_new(byval orientation as GtkOrientation, byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
declare function gtk_scale_new_with_range(byval orientation as GtkOrientation, byval min as gdouble, byval max as gdouble, byval step as gdouble) as GtkWidget ptr
declare sub gtk_scale_set_digits(byval scale as GtkScale ptr, byval digits as gint)
declare function gtk_scale_get_digits(byval scale as GtkScale ptr) as gint
declare sub gtk_scale_set_draw_value(byval scale as GtkScale ptr, byval draw_value as gboolean)
declare function gtk_scale_get_draw_value(byval scale as GtkScale ptr) as gboolean
declare sub gtk_scale_set_has_origin(byval scale as GtkScale ptr, byval has_origin as gboolean)
declare function gtk_scale_get_has_origin(byval scale as GtkScale ptr) as gboolean
declare sub gtk_scale_set_value_pos(byval scale as GtkScale ptr, byval pos as GtkPositionType)
declare function gtk_scale_get_value_pos(byval scale as GtkScale ptr) as GtkPositionType
declare function gtk_scale_get_layout(byval scale as GtkScale ptr) as PangoLayout ptr
declare sub gtk_scale_get_layout_offsets(byval scale as GtkScale ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gtk_scale_add_mark(byval scale as GtkScale ptr, byval value as gdouble, byval position as GtkPositionType, byval markup as const gchar ptr)
declare sub gtk_scale_clear_marks(byval scale as GtkScale ptr)

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

#define __GTK_SCROLLABLE_H__
#define GTK_TYPE_SCROLLABLE gtk_scrollable_get_type()
#define GTK_SCROLLABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCROLLABLE, GtkScrollable)
#define GTK_IS_SCROLLABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCROLLABLE)
#define GTK_SCROLLABLE_GET_IFACE(inst) G_TYPE_INSTANCE_GET_INTERFACE((inst), GTK_TYPE_SCROLLABLE, GtkScrollableInterface)
type GtkScrollable as _GtkScrollable
type GtkScrollableInterface as _GtkScrollableInterface

type _GtkScrollableInterface
	base_iface as GTypeInterface
	get_border as function(byval scrollable as GtkScrollable ptr, byval border as GtkBorder ptr) as gboolean
end type

declare function gtk_scrollable_get_type() as GType
declare function gtk_scrollable_get_hadjustment(byval scrollable as GtkScrollable ptr) as GtkAdjustment ptr
declare sub gtk_scrollable_set_hadjustment(byval scrollable as GtkScrollable ptr, byval hadjustment as GtkAdjustment ptr)
declare function gtk_scrollable_get_vadjustment(byval scrollable as GtkScrollable ptr) as GtkAdjustment ptr
declare sub gtk_scrollable_set_vadjustment(byval scrollable as GtkScrollable ptr, byval vadjustment as GtkAdjustment ptr)
declare function gtk_scrollable_get_hscroll_policy(byval scrollable as GtkScrollable ptr) as GtkScrollablePolicy
declare sub gtk_scrollable_set_hscroll_policy(byval scrollable as GtkScrollable ptr, byval policy as GtkScrollablePolicy)
declare function gtk_scrollable_get_vscroll_policy(byval scrollable as GtkScrollable ptr) as GtkScrollablePolicy
declare sub gtk_scrollable_set_vscroll_policy(byval scrollable as GtkScrollable ptr, byval policy as GtkScrollablePolicy)
declare function gtk_scrollable_get_border(byval scrollable as GtkScrollable ptr, byval border as GtkBorder ptr) as gboolean

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
declare function gtk_scrollbar_new(byval orientation as GtkOrientation, byval adjustment as GtkAdjustment ptr) as GtkWidget ptr
#define __GTK_SCROLLED_WINDOW_H__
#define GTK_TYPE_SCROLLED_WINDOW gtk_scrolled_window_get_type()
#define GTK_SCROLLED_WINDOW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindow)
#define GTK_SCROLLED_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass)
#define GTK_IS_SCROLLED_WINDOW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SCROLLED_WINDOW)
#define GTK_IS_SCROLLED_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SCROLLED_WINDOW)
#define GTK_SCROLLED_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass)

type GtkScrolledWindow as _GtkScrolledWindow
type GtkScrolledWindowPrivate as _GtkScrolledWindowPrivate
type GtkScrolledWindowClass as _GtkScrolledWindowClass

type _GtkScrolledWindow
	container as GtkBin
	priv as GtkScrolledWindowPrivate ptr
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

type GtkCornerType as long
enum
	GTK_CORNER_TOP_LEFT
	GTK_CORNER_BOTTOM_LEFT
	GTK_CORNER_TOP_RIGHT
	GTK_CORNER_BOTTOM_RIGHT
end enum

type GtkPolicyType as long
enum
	GTK_POLICY_ALWAYS
	GTK_POLICY_AUTOMATIC
	GTK_POLICY_NEVER
	GTK_POLICY_EXTERNAL
end enum

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
declare function gtk_scrolled_window_get_min_content_width(byval scrolled_window as GtkScrolledWindow ptr) as gint
declare sub gtk_scrolled_window_set_min_content_width(byval scrolled_window as GtkScrolledWindow ptr, byval width as gint)
declare function gtk_scrolled_window_get_min_content_height(byval scrolled_window as GtkScrolledWindow ptr) as gint
declare sub gtk_scrolled_window_set_min_content_height(byval scrolled_window as GtkScrolledWindow ptr, byval height as gint)
declare sub gtk_scrolled_window_set_kinetic_scrolling(byval scrolled_window as GtkScrolledWindow ptr, byval kinetic_scrolling as gboolean)
declare function gtk_scrolled_window_get_kinetic_scrolling(byval scrolled_window as GtkScrolledWindow ptr) as gboolean
declare sub gtk_scrolled_window_set_capture_button_press(byval scrolled_window as GtkScrolledWindow ptr, byval capture_button_press as gboolean)
declare function gtk_scrolled_window_get_capture_button_press(byval scrolled_window as GtkScrolledWindow ptr) as gboolean
declare sub gtk_scrolled_window_set_overlay_scrolling(byval scrolled_window as GtkScrolledWindow ptr, byval overlay_scrolling as gboolean)
declare function gtk_scrolled_window_get_overlay_scrolling(byval scrolled_window as GtkScrolledWindow ptr) as gboolean

#define __GTK_SEARCH_BAR_H__
#define GTK_TYPE_SEARCH_BAR gtk_search_bar_get_type()
#define GTK_SEARCH_BAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SEARCH_BAR, GtkSearchBar)
#define GTK_SEARCH_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SEARCH_BAR, GtkSearchBarClass)
#define GTK_IS_SEARCH_BAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SEARCH_BAR)
#define GTK_IS_SEARCH_BAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SEARCH_BAR)
#define GTK_SEARCH_BAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEARCH_BAR, GtkSearchBarClass)
type GtkSearchBar as _GtkSearchBar
type GtkSearchBarClass as _GtkSearchBarClass

type _GtkSearchBar
	parent as GtkBin
end type

type _GtkSearchBarClass
	parent_class as GtkBinClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_search_bar_get_type() as GType
declare function gtk_search_bar_new() as GtkWidget ptr
declare sub gtk_search_bar_connect_entry(byval bar as GtkSearchBar ptr, byval entry as GtkEntry ptr)
declare function gtk_search_bar_get_search_mode(byval bar as GtkSearchBar ptr) as gboolean
declare sub gtk_search_bar_set_search_mode(byval bar as GtkSearchBar ptr, byval search_mode as gboolean)
declare function gtk_search_bar_get_show_close_button(byval bar as GtkSearchBar ptr) as gboolean
declare sub gtk_search_bar_set_show_close_button(byval bar as GtkSearchBar ptr, byval visible as gboolean)
declare function gtk_search_bar_handle_event(byval bar as GtkSearchBar ptr, byval event as GdkEvent ptr) as gboolean

#define __GTK_SEARCH_ENTRY_H__
#define GTK_TYPE_SEARCH_ENTRY gtk_search_entry_get_type()
#define GTK_SEARCH_ENTRY(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SEARCH_ENTRY, GtkSearchEntry)
#define GTK_SEARCH_ENTRY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SEARCH_ENTRY, GtkSearchEntryClass)
#define GTK_IS_SEARCH_ENTRY(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SEARCH_ENTRY)
#define GTK_IS_SEARCH_ENTRY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SEARCH_ENTRY)
#define GTK_SEARCH_ENTRY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEARCH_ENTRY, GtkSearchEntryClass)
type GtkSearchEntry as _GtkSearchEntry
type GtkSearchEntryClass as _GtkSearchEntryClass

type _GtkSearchEntry
	parent as GtkEntry
end type

type _GtkSearchEntryClass
	parent_class as GtkEntryClass
	search_changed as sub(byval entry as GtkSearchEntry ptr)
	next_match as sub(byval entry as GtkSearchEntry ptr)
	previous_match as sub(byval entry as GtkSearchEntry ptr)
	stop_search as sub(byval entry as GtkSearchEntry ptr)
end type

declare function gtk_search_entry_get_type() as GType
declare function gtk_search_entry_new() as GtkWidget ptr
declare function gtk_search_entry_handle_event(byval entry as GtkSearchEntry ptr, byval event as GdkEvent ptr) as gboolean

#define __GTK_SEPARATOR_H__
#define GTK_TYPE_SEPARATOR gtk_separator_get_type()
#define GTK_SEPARATOR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SEPARATOR, GtkSeparator)
#define GTK_SEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SEPARATOR, GtkSeparatorClass)
#define GTK_IS_SEPARATOR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SEPARATOR)
#define GTK_IS_SEPARATOR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SEPARATOR)
#define GTK_SEPARATOR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEPARATOR, GtkSeparatorClass)

type GtkSeparator as _GtkSeparator
type GtkSeparatorPrivate as _GtkSeparatorPrivate
type GtkSeparatorClass as _GtkSeparatorClass

type _GtkSeparator
	widget as GtkWidget
	priv as GtkSeparatorPrivate ptr
end type

type _GtkSeparatorClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_separator_get_type() as GType
declare function gtk_separator_new(byval orientation as GtkOrientation) as GtkWidget ptr
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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

#define __GTK_SETTINGS_H__
#define GTK_TYPE_SETTINGS gtk_settings_get_type()
#define GTK_SETTINGS(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SETTINGS, GtkSettings)
#define GTK_SETTINGS_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SETTINGS, GtkSettingsClass)
#define GTK_IS_SETTINGS(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SETTINGS)
#define GTK_IS_SETTINGS_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SETTINGS)
#define GTK_SETTINGS_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SETTINGS, GtkSettingsClass)

type GtkSettingsPrivate as _GtkSettingsPrivate
type GtkSettingsClass as _GtkSettingsClass
type GtkSettingsValue as _GtkSettingsValue

type _GtkSettings
	parent_instance as GObject
	priv as GtkSettingsPrivate ptr
end type

type _GtkSettingsClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
#define __GTK_SHOW_H__
declare function gtk_show_uri(byval screen as GdkScreen ptr, byval uri as const gchar ptr, byval timestamp as guint32, byval error as GError ptr ptr) as gboolean

#define __GTK_STACK_SIDEBAR_H__
#define __GTK_STACK_H__
#define GTK_TYPE_STACK gtk_stack_get_type()
#define GTK_STACK(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_STACK, GtkStack)
#define GTK_STACK_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STACK, GtkStackClass)
#define GTK_IS_STACK(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_STACK)
#define GTK_IS_STACK_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STACK)
#define GTK_STACK_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STACK, GtkStackClass)
type GtkStack as _GtkStack
type GtkStackClass as _GtkStackClass

type GtkStackTransitionType as long
enum
	GTK_STACK_TRANSITION_TYPE_NONE
	GTK_STACK_TRANSITION_TYPE_CROSSFADE
	GTK_STACK_TRANSITION_TYPE_SLIDE_RIGHT
	GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT
	GTK_STACK_TRANSITION_TYPE_SLIDE_UP
	GTK_STACK_TRANSITION_TYPE_SLIDE_DOWN
	GTK_STACK_TRANSITION_TYPE_SLIDE_LEFT_RIGHT
	GTK_STACK_TRANSITION_TYPE_SLIDE_UP_DOWN
	GTK_STACK_TRANSITION_TYPE_OVER_UP
	GTK_STACK_TRANSITION_TYPE_OVER_DOWN
	GTK_STACK_TRANSITION_TYPE_OVER_LEFT
	GTK_STACK_TRANSITION_TYPE_OVER_RIGHT
	GTK_STACK_TRANSITION_TYPE_UNDER_UP
	GTK_STACK_TRANSITION_TYPE_UNDER_DOWN
	GTK_STACK_TRANSITION_TYPE_UNDER_LEFT
	GTK_STACK_TRANSITION_TYPE_UNDER_RIGHT
	GTK_STACK_TRANSITION_TYPE_OVER_UP_DOWN
	GTK_STACK_TRANSITION_TYPE_OVER_DOWN_UP
	GTK_STACK_TRANSITION_TYPE_OVER_LEFT_RIGHT
	GTK_STACK_TRANSITION_TYPE_OVER_RIGHT_LEFT
end enum

type _GtkStack
	parent_instance as GtkContainer
end type

type _GtkStackClass
	parent_class as GtkContainerClass
end type

declare function gtk_stack_get_type() as GType
declare function gtk_stack_new() as GtkWidget ptr
declare sub gtk_stack_add_named(byval stack as GtkStack ptr, byval child as GtkWidget ptr, byval name as const gchar ptr)
declare sub gtk_stack_add_titled(byval stack as GtkStack ptr, byval child as GtkWidget ptr, byval name as const gchar ptr, byval title as const gchar ptr)
declare function gtk_stack_get_child_by_name(byval stack as GtkStack ptr, byval name as const gchar ptr) as GtkWidget ptr
declare sub gtk_stack_set_visible_child(byval stack as GtkStack ptr, byval child as GtkWidget ptr)
declare function gtk_stack_get_visible_child(byval stack as GtkStack ptr) as GtkWidget ptr
declare sub gtk_stack_set_visible_child_name(byval stack as GtkStack ptr, byval name as const gchar ptr)
declare function gtk_stack_get_visible_child_name(byval stack as GtkStack ptr) as const gchar ptr
declare sub gtk_stack_set_visible_child_full(byval stack as GtkStack ptr, byval name as const gchar ptr, byval transition as GtkStackTransitionType)
declare sub gtk_stack_set_homogeneous(byval stack as GtkStack ptr, byval homogeneous as gboolean)
declare function gtk_stack_get_homogeneous(byval stack as GtkStack ptr) as gboolean
declare sub gtk_stack_set_hhomogeneous(byval stack as GtkStack ptr, byval hhomogeneous as gboolean)
declare function gtk_stack_get_hhomogeneous(byval stack as GtkStack ptr) as gboolean
declare sub gtk_stack_set_vhomogeneous(byval stack as GtkStack ptr, byval vhomogeneous as gboolean)
declare function gtk_stack_get_vhomogeneous(byval stack as GtkStack ptr) as gboolean
declare sub gtk_stack_set_transition_duration(byval stack as GtkStack ptr, byval duration as guint)
declare function gtk_stack_get_transition_duration(byval stack as GtkStack ptr) as guint
declare sub gtk_stack_set_transition_type(byval stack as GtkStack ptr, byval transition as GtkStackTransitionType)
declare function gtk_stack_get_transition_type(byval stack as GtkStack ptr) as GtkStackTransitionType
declare function gtk_stack_get_transition_running(byval stack as GtkStack ptr) as gboolean

#define GTK_TYPE_STACK_SIDEBAR gtk_stack_sidebar_get_type()
#define GTK_STACK_SIDEBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_STACK_SIDEBAR, GtkStackSidebar)
#define GTK_IS_STACK_SIDEBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_STACK_SIDEBAR)
#define GTK_STACK_SIDEBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STACK_SIDEBAR, GtkStackSidebarClass)
#define GTK_IS_STACK_SIDEBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STACK_SIDEBAR)
#define GTK_STACK_SIDEBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STACK_SIDEBAR, GtkStackSidebarClass)

type GtkStackSidebar as _GtkStackSidebar
type GtkStackSidebarPrivate as _GtkStackSidebarPrivate
type GtkStackSidebarClass as _GtkStackSidebarClass

type _GtkStackSidebar
	parent as GtkBin
end type

type _GtkStackSidebarClass
	parent_class as GtkBinClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_stack_sidebar_get_type() as GType
declare function gtk_stack_sidebar_new() as GtkWidget ptr
declare sub gtk_stack_sidebar_set_stack(byval sidebar as GtkStackSidebar ptr, byval stack as GtkStack ptr)
declare function gtk_stack_sidebar_get_stack(byval sidebar as GtkStackSidebar ptr) as GtkStack ptr
#define __GTK_SIZE_REQUEST_H__
type GtkRequestedSize as _GtkRequestedSize

type _GtkRequestedSize
	data as gpointer
	minimum_size as gint
	natural_size as gint
end type

declare function gtk_distribute_natural_allocation(byval extra_space as gint, byval n_requested_sizes as guint, byval sizes as GtkRequestedSize ptr) as gint
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
type GtkSpinButtonPrivate as _GtkSpinButtonPrivate
type GtkSpinButtonClass as _GtkSpinButtonClass

type _GtkSpinButton
	entry as GtkEntry
	priv as GtkSpinButtonPrivate ptr
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
	_gtk_reserved4 as sub()
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
declare sub _gtk_spin_button_get_panels(byval spin_button as GtkSpinButton ptr, byval down_panel as GdkWindow ptr ptr, byval up_panel as GdkWindow ptr ptr)

#define __GTK_SPINNER_H__
#define GTK_TYPE_SPINNER gtk_spinner_get_type()
#define GTK_SPINNER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SPINNER, GtkSpinner)
#define GTK_SPINNER_CLASS(obj) G_TYPE_CHECK_CLASS_CAST((obj), GTK_TYPE_SPINNER, GtkSpinnerClass)
#define GTK_IS_SPINNER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SPINNER)
#define GTK_IS_SPINNER_CLASS(obj) G_TYPE_CHECK_CLASS_TYPE((obj), GTK_TYPE_SPINNER)
#define GTK_SPINNER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SPINNER, GtkSpinnerClass)

type GtkSpinner as _GtkSpinner
type GtkSpinnerClass as _GtkSpinnerClass
type GtkSpinnerPrivate as _GtkSpinnerPrivate

type _GtkSpinner
	parent as GtkWidget
	priv as GtkSpinnerPrivate ptr
end type

type _GtkSpinnerClass
	parent_class as GtkWidgetClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_spinner_get_type() as GType
declare function gtk_spinner_new() as GtkWidget ptr
declare sub gtk_spinner_start(byval spinner as GtkSpinner ptr)
declare sub gtk_spinner_stop(byval spinner as GtkSpinner ptr)

#define __GTK_STACK_SWITCHER_H__
#define GTK_TYPE_STACK_SWITCHER gtk_stack_switcher_get_type()
#define GTK_STACK_SWITCHER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_STACK_SWITCHER, GtkStackSwitcher)
#define GTK_STACK_SWITCHER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STACK_SWITCHER, GtkStackSwitcherClass)
#define GTK_IS_STACK_SWITCHER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_STACK_SWITCHER)
#define GTK_IS_STACK_SWITCHER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STACK_SWITCHER)
#define GTK_STACK_SWITCHER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STACK_SWITCHER, GtkStackSwitcherClass)
type GtkStackSwitcher as _GtkStackSwitcher
type GtkStackSwitcherClass as _GtkStackSwitcherClass

type _GtkStackSwitcher
	widget as GtkBox
end type

type _GtkStackSwitcherClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_stack_switcher_get_type() as GType
declare function gtk_stack_switcher_new() as GtkWidget ptr
declare sub gtk_stack_switcher_set_stack(byval switcher as GtkStackSwitcher ptr, byval stack as GtkStack ptr)
declare function gtk_stack_switcher_get_stack(byval switcher as GtkStackSwitcher ptr) as GtkStack ptr

#define __GTK_STATUSBAR_H__
#define GTK_TYPE_STATUSBAR gtk_statusbar_get_type()
#define GTK_STATUSBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_STATUSBAR, GtkStatusbar)
#define GTK_STATUSBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STATUSBAR, GtkStatusbarClass)
#define GTK_IS_STATUSBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_STATUSBAR)
#define GTK_IS_STATUSBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STATUSBAR)
#define GTK_STATUSBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STATUSBAR, GtkStatusbarClass)

type GtkStatusbar as _GtkStatusbar
type GtkStatusbarPrivate as _GtkStatusbarPrivate
type GtkStatusbarClass as _GtkStatusbarClass

type _GtkStatusbar
	parent_widget as GtkBox
	priv as GtkStatusbarPrivate ptr
end type

type _GtkStatusbarClass
	parent_class as GtkBoxClass
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
declare function gtk_statusbar_get_message_area(byval statusbar as GtkStatusbar ptr) as GtkWidget ptr

#define __GTK_SWITCH_H__
#define GTK_TYPE_SWITCH gtk_switch_get_type()
#define GTK_SWITCH(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_SWITCH, GtkSwitch)
#define GTK_IS_SWITCH(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_SWITCH)
#define GTK_SWITCH_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_SWITCH, GtkSwitchClass)
#define GTK_IS_SWITCH_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_SWITCH)
#define GTK_SWITCH_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SWITCH, GtkSwitchClass)

type GtkSwitch as _GtkSwitch
type GtkSwitchPrivate as _GtkSwitchPrivate
type GtkSwitchClass as _GtkSwitchClass

type _GtkSwitch
	parent_instance as GtkWidget
	priv as GtkSwitchPrivate ptr
end type

type _GtkSwitchClass
	parent_class as GtkWidgetClass
	activate as sub(byval sw as GtkSwitch ptr)
	state_set as function(byval sw as GtkSwitch ptr, byval state as gboolean) as gboolean
	_switch_padding_1 as sub()
	_switch_padding_2 as sub()
	_switch_padding_3 as sub()
	_switch_padding_4 as sub()
	_switch_padding_5 as sub()
end type

declare function gtk_switch_get_type() as GType
declare function gtk_switch_new() as GtkWidget ptr
declare sub gtk_switch_set_active(byval sw as GtkSwitch ptr, byval is_active as gboolean)
declare function gtk_switch_get_active(byval sw as GtkSwitch ptr) as gboolean
declare sub gtk_switch_set_state(byval sw as GtkSwitch ptr, byval state as gboolean)
declare function gtk_switch_get_state(byval sw as GtkSwitch ptr) as gboolean
#define __GTK_TEXT_BUFFER_H__
#define __GTK_TEXT_TAG_TABLE_H__
type GtkTextTagTableForeach as sub(byval tag as GtkTextTag ptr, byval data as gpointer)

#define GTK_TYPE_TEXT_TAG_TABLE gtk_text_tag_table_get_type()
#define GTK_TEXT_TAG_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTable)
#define GTK_TEXT_TAG_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass)
#define GTK_IS_TEXT_TAG_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_TAG_TABLE)
#define GTK_IS_TEXT_TAG_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_TAG_TABLE)
#define GTK_TEXT_TAG_TABLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass)
type GtkTextTagTablePrivate as _GtkTextTagTablePrivate
type GtkTextTagTableClass as _GtkTextTagTableClass

type _GtkTextTagTable
	parent_instance as GObject
	priv as GtkTextTagTablePrivate ptr
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
declare function gtk_text_tag_table_add(byval table as GtkTextTagTable ptr, byval tag as GtkTextTag ptr) as gboolean
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
declare function gtk_text_mark_new(byval name as const gchar ptr, byval left_gravity as gboolean) as GtkTextMark ptr
declare sub gtk_text_mark_set_visible(byval mark as GtkTextMark ptr, byval setting as gboolean)
declare function gtk_text_mark_get_visible(byval mark as GtkTextMark ptr) as gboolean
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
#define GTK_TYPE_TEXT_BUFFER gtk_text_buffer_get_type()
#define GTK_TEXT_BUFFER(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBuffer)
#define GTK_TEXT_BUFFER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass)
#define GTK_IS_TEXT_BUFFER(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TEXT_BUFFER)
#define GTK_IS_TEXT_BUFFER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TEXT_BUFFER)
#define GTK_TEXT_BUFFER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass)
type GtkTextBufferPrivate as _GtkTextBufferPrivate
type GtkTextBufferClass as _GtkTextBufferClass

type _GtkTextBuffer
	parent_instance as GObject
	priv as GtkTextBufferPrivate ptr
end type

type _GtkTextBufferClass
	parent_class as GObjectClass
	insert_text as sub(byval buffer as GtkTextBuffer ptr, byval pos as GtkTextIter ptr, byval new_text as const gchar ptr, byval new_text_length as gint)
	insert_pixbuf as sub(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval pixbuf as GdkPixbuf ptr)
	insert_child_anchor as sub(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval anchor as GtkTextChildAnchor ptr)
	delete_range as sub(byval buffer as GtkTextBuffer ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
	changed as sub(byval buffer as GtkTextBuffer ptr)
	modified_changed as sub(byval buffer as GtkTextBuffer ptr)
	mark_set as sub(byval buffer as GtkTextBuffer ptr, byval location as const GtkTextIter ptr, byval mark as GtkTextMark ptr)
	mark_deleted as sub(byval buffer as GtkTextBuffer ptr, byval mark as GtkTextMark ptr)
	apply_tag as sub(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
	remove_tag as sub(byval buffer as GtkTextBuffer ptr, byval tag as GtkTextTag ptr, byval start as const GtkTextIter ptr, byval end as const GtkTextIter ptr)
	begin_user_action as sub(byval buffer as GtkTextBuffer ptr)
	end_user_action as sub(byval buffer as GtkTextBuffer ptr)
	paste_done as sub(byval buffer as GtkTextBuffer ptr, byval clipboard as GtkClipboard ptr)
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_text_buffer_insert_markup(byval buffer as GtkTextBuffer ptr, byval iter as GtkTextIter ptr, byval markup as const gchar ptr, byval len as gint)
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
declare sub _gtk_text_buffer_get_text_before(byval buffer as GtkTextBuffer ptr, byval boundary_type as AtkTextBoundary, byval position as GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub _gtk_text_buffer_get_text_at(byval buffer as GtkTextBuffer ptr, byval boundary_type as AtkTextBoundary, byval position as GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
declare sub _gtk_text_buffer_get_text_after(byval buffer as GtkTextBuffer ptr, byval boundary_type as AtkTextBoundary, byval position as GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr)
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

type GtkTextViewLayer as long
enum
	GTK_TEXT_VIEW_LAYER_BELOW
	GTK_TEXT_VIEW_LAYER_ABOVE
end enum

type GtkTextExtendSelection as long
enum
	GTK_TEXT_EXTEND_SELECTION_WORD
	GTK_TEXT_EXTEND_SELECTION_LINE
end enum

const GTK_TEXT_VIEW_PRIORITY_VALIDATE = GDK_PRIORITY_REDRAW + 5
type GtkTextView as _GtkTextView
type GtkTextViewPrivate as _GtkTextViewPrivate
type GtkTextViewClass as _GtkTextViewClass

type _GtkTextView
	parent_instance as GtkContainer
	priv as GtkTextViewPrivate ptr
end type

type _GtkTextViewClass
	parent_class as GtkContainerClass
	populate_popup as sub(byval text_view as GtkTextView ptr, byval popup as GtkWidget ptr)
	move_cursor as sub(byval text_view as GtkTextView ptr, byval step as GtkMovementStep, byval count as gint, byval extend_selection as gboolean)
	set_anchor as sub(byval text_view as GtkTextView ptr)
	insert_at_cursor as sub(byval text_view as GtkTextView ptr, byval str as const gchar ptr)
	delete_from_cursor as sub(byval text_view as GtkTextView ptr, byval type as GtkDeleteType, byval count as gint)
	backspace as sub(byval text_view as GtkTextView ptr)
	cut_clipboard as sub(byval text_view as GtkTextView ptr)
	copy_clipboard as sub(byval text_view as GtkTextView ptr)
	paste_clipboard as sub(byval text_view as GtkTextView ptr)
	toggle_overwrite as sub(byval text_view as GtkTextView ptr)
	create_buffer as function(byval text_view as GtkTextView ptr) as GtkTextBuffer ptr
	draw_layer as sub(byval text_view as GtkTextView ptr, byval layer as GtkTextViewLayer, byval cr as cairo_t ptr)
	extend_selection as function(byval text_view as GtkTextView ptr, byval granularity as GtkTextExtendSelection, byval location as const GtkTextIter ptr, byval start as GtkTextIter ptr, byval end as GtkTextIter ptr) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
	_gtk_reserved5 as sub()
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
declare sub gtk_text_view_get_cursor_locations(byval text_view as GtkTextView ptr, byval iter as const GtkTextIter ptr, byval strong as GdkRectangle ptr, byval weak as GdkRectangle ptr)
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
declare sub gtk_text_view_set_input_purpose(byval text_view as GtkTextView ptr, byval purpose as GtkInputPurpose)
declare function gtk_text_view_get_input_purpose(byval text_view as GtkTextView ptr) as GtkInputPurpose
declare sub gtk_text_view_set_input_hints(byval text_view as GtkTextView ptr, byval hints as GtkInputHints)
declare function gtk_text_view_get_input_hints(byval text_view as GtkTextView ptr) as GtkInputHints
declare sub gtk_text_view_set_monospace(byval text_view as GtkTextView ptr, byval monospace as gboolean)
declare function gtk_text_view_get_monospace(byval text_view as GtkTextView ptr) as gboolean

#define __GTK_TOOLBAR_H__
#define GTK_TYPE_TOOLBAR gtk_toolbar_get_type()
#define GTK_TOOLBAR(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TOOLBAR, GtkToolbar)
#define GTK_TOOLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TOOLBAR, GtkToolbarClass)
#define GTK_IS_TOOLBAR(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TOOLBAR)
#define GTK_IS_TOOLBAR_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TOOLBAR)
#define GTK_TOOLBAR_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOLBAR, GtkToolbarClass)

type GtkToolbarSpaceStyle as long
enum
	GTK_TOOLBAR_SPACE_EMPTY
	GTK_TOOLBAR_SPACE_LINE
end enum

type GtkToolbar as _GtkToolbar
type GtkToolbarPrivate as _GtkToolbarPrivate
type GtkToolbarClass as _GtkToolbarClass

type _GtkToolbar
	container as GtkContainer
	priv as GtkToolbarPrivate ptr
end type

type _GtkToolbarClass
	parent_class as GtkContainerClass
	orientation_changed as sub(byval toolbar as GtkToolbar ptr, byval orientation as GtkOrientation)
	style_changed as sub(byval toolbar as GtkToolbar ptr, byval style as GtkToolbarStyle)
	popup_context_menu as function(byval toolbar as GtkToolbar ptr, byval x as gint, byval y as gint, byval button_number as gint) as gboolean
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_test_widget_wait_for_draw(byval widget as GtkWidget ptr)
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
type GtkTreeModelSortPrivate as _GtkTreeModelSortPrivate

type _GtkTreeModelSort
	parent as GObject
	priv as GtkTreeModelSortPrivate ptr
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

type GtkTreeSelectionPrivate as _GtkTreeSelectionPrivate
type GtkTreeSelectionFunc as function(byval selection as GtkTreeSelection ptr, byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval path_currently_selected as gboolean, byval data as gpointer) as gboolean
type GtkTreeSelectionForeachFunc as sub(byval model as GtkTreeModel ptr, byval path as GtkTreePath ptr, byval iter as GtkTreeIter ptr, byval data as gpointer)

type _GtkTreeSelection
	parent as GObject
	priv as GtkTreeSelectionPrivate ptr
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
type GtkTreeStorePrivate as _GtkTreeStorePrivate

type _GtkTreeStore
	parent as GObject
	priv as GtkTreeStorePrivate ptr
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
#define __GTK_TYPE_BUILTINS_H__
declare function gtk_license_get_type() as GType
#define GTK_TYPE_LICENSE gtk_license_get_type()
declare function gtk_accel_flags_get_type() as GType
#define GTK_TYPE_ACCEL_FLAGS gtk_accel_flags_get_type()
declare function gtk_application_inhibit_flags_get_type() as GType
#define GTK_TYPE_APPLICATION_INHIBIT_FLAGS gtk_application_inhibit_flags_get_type()
declare function gtk_assistant_page_type_get_type() as GType
#define GTK_TYPE_ASSISTANT_PAGE_TYPE gtk_assistant_page_type_get_type()
declare function gtk_button_box_style_get_type() as GType
#define GTK_TYPE_BUTTON_BOX_STYLE gtk_button_box_style_get_type()
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
declare function gtk_resize_mode_get_type() as GType
#define GTK_TYPE_RESIZE_MODE gtk_resize_mode_get_type()
declare function gtk_css_provider_error_get_type() as GType
#define GTK_TYPE_CSS_PROVIDER_ERROR gtk_css_provider_error_get_type()
declare function gtk_css_section_type_get_type() as GType
#define GTK_TYPE_CSS_SECTION_TYPE gtk_css_section_type_get_type()
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
declare function gtk_align_get_type() as GType
#define GTK_TYPE_ALIGN gtk_align_get_type()
declare function gtk_arrow_type_get_type() as GType
#define GTK_TYPE_ARROW_TYPE gtk_arrow_type_get_type()
declare function gtk_baseline_position_get_type() as GType
#define GTK_TYPE_BASELINE_POSITION gtk_baseline_position_get_type()
declare function gtk_delete_type_get_type() as GType
#define GTK_TYPE_DELETE_TYPE gtk_delete_type_get_type()
declare function gtk_direction_type_get_type() as GType
#define GTK_TYPE_DIRECTION_TYPE gtk_direction_type_get_type()
declare function gtk_icon_size_get_type() as GType
#define GTK_TYPE_ICON_SIZE gtk_icon_size_get_type()
declare function gtk_sensitivity_type_get_type() as GType
#define GTK_TYPE_SENSITIVITY_TYPE gtk_sensitivity_type_get_type()
declare function gtk_text_direction_get_type() as GType
#define GTK_TYPE_TEXT_DIRECTION gtk_text_direction_get_type()
declare function gtk_justification_get_type() as GType
#define GTK_TYPE_JUSTIFICATION gtk_justification_get_type()
declare function gtk_menu_direction_type_get_type() as GType
#define GTK_TYPE_MENU_DIRECTION_TYPE gtk_menu_direction_type_get_type()
declare function gtk_message_type_get_type() as GType
#define GTK_TYPE_MESSAGE_TYPE gtk_message_type_get_type()
declare function gtk_movement_step_get_type() as GType
#define GTK_TYPE_MOVEMENT_STEP gtk_movement_step_get_type()
declare function gtk_scroll_step_get_type() as GType
#define GTK_TYPE_SCROLL_STEP gtk_scroll_step_get_type()
declare function gtk_orientation_get_type() as GType
#define GTK_TYPE_ORIENTATION gtk_orientation_get_type()
declare function gtk_pack_type_get_type() as GType
#define GTK_TYPE_PACK_TYPE gtk_pack_type_get_type()
declare function gtk_position_type_get_type() as GType
#define GTK_TYPE_POSITION_TYPE gtk_position_type_get_type()
declare function gtk_relief_style_get_type() as GType
#define GTK_TYPE_RELIEF_STYLE gtk_relief_style_get_type()
declare function gtk_scroll_type_get_type() as GType
#define GTK_TYPE_SCROLL_TYPE gtk_scroll_type_get_type()
declare function gtk_selection_mode_get_type() as GType
#define GTK_TYPE_SELECTION_MODE gtk_selection_mode_get_type()
declare function gtk_shadow_type_get_type() as GType
#define GTK_TYPE_SHADOW_TYPE gtk_shadow_type_get_type()
declare function gtk_state_type_get_type() as GType
#define GTK_TYPE_STATE_TYPE gtk_state_type_get_type()
declare function gtk_toolbar_style_get_type() as GType
#define GTK_TYPE_TOOLBAR_STYLE gtk_toolbar_style_get_type()
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
declare function gtk_size_group_mode_get_type() as GType
#define GTK_TYPE_SIZE_GROUP_MODE gtk_size_group_mode_get_type()
declare function gtk_size_request_mode_get_type() as GType
#define GTK_TYPE_SIZE_REQUEST_MODE gtk_size_request_mode_get_type()
declare function gtk_scrollable_policy_get_type() as GType
#define GTK_TYPE_SCROLLABLE_POLICY gtk_scrollable_policy_get_type()
declare function gtk_state_flags_get_type() as GType
#define GTK_TYPE_STATE_FLAGS gtk_state_flags_get_type()
declare function gtk_region_flags_get_type() as GType
#define GTK_TYPE_REGION_FLAGS gtk_region_flags_get_type()
declare function gtk_junction_sides_get_type() as GType
#define GTK_TYPE_JUNCTION_SIDES gtk_junction_sides_get_type()
declare function gtk_border_style_get_type() as GType
#define GTK_TYPE_BORDER_STYLE gtk_border_style_get_type()
declare function gtk_level_bar_mode_get_type() as GType
#define GTK_TYPE_LEVEL_BAR_MODE gtk_level_bar_mode_get_type()
declare function gtk_input_purpose_get_type() as GType
#define GTK_TYPE_INPUT_PURPOSE gtk_input_purpose_get_type()
declare function gtk_input_hints_get_type() as GType
#define GTK_TYPE_INPUT_HINTS gtk_input_hints_get_type()
declare function gtk_propagation_phase_get_type() as GType
#define GTK_TYPE_PROPAGATION_PHASE gtk_propagation_phase_get_type()
declare function gtk_event_sequence_state_get_type() as GType
#define GTK_TYPE_EVENT_SEQUENCE_STATE gtk_event_sequence_state_get_type()
declare function gtk_pan_direction_get_type() as GType
#define GTK_TYPE_PAN_DIRECTION gtk_pan_direction_get_type()
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
declare function gtk_arrow_placement_get_type() as GType
#define GTK_TYPE_ARROW_PLACEMENT gtk_arrow_placement_get_type()
declare function gtk_buttons_type_get_type() as GType
#define GTK_TYPE_BUTTONS_TYPE gtk_buttons_type_get_type()
declare function gtk_button_role_get_type() as GType
#define GTK_TYPE_BUTTON_ROLE gtk_button_role_get_type()
declare function gtk_notebook_tab_get_type() as GType
#define GTK_TYPE_NOTEBOOK_TAB gtk_notebook_tab_get_type()
declare function gtk_places_open_flags_get_type() as GType
#define GTK_TYPE_PLACES_OPEN_FLAGS gtk_places_open_flags_get_type()
declare function gtk_print_status_get_type() as GType
#define GTK_TYPE_PRINT_STATUS gtk_print_status_get_type()
declare function gtk_print_operation_result_get_type() as GType
#define GTK_TYPE_PRINT_OPERATION_RESULT gtk_print_operation_result_get_type()
declare function gtk_print_operation_action_get_type() as GType
#define GTK_TYPE_PRINT_OPERATION_ACTION gtk_print_operation_action_get_type()
declare function gtk_print_error_get_type() as GType
#define GTK_TYPE_PRINT_ERROR gtk_print_error_get_type()
declare function gtk_recent_sort_type_get_type() as GType
#define GTK_TYPE_RECENT_SORT_TYPE gtk_recent_sort_type_get_type()
declare function gtk_recent_chooser_error_get_type() as GType
#define GTK_TYPE_RECENT_CHOOSER_ERROR gtk_recent_chooser_error_get_type()
declare function gtk_recent_filter_flags_get_type() as GType
#define GTK_TYPE_RECENT_FILTER_FLAGS gtk_recent_filter_flags_get_type()
declare function gtk_recent_manager_error_get_type() as GType
#define GTK_TYPE_RECENT_MANAGER_ERROR gtk_recent_manager_error_get_type()
declare function gtk_revealer_transition_type_get_type() as GType
#define GTK_TYPE_REVEALER_TRANSITION_TYPE gtk_revealer_transition_type_get_type()
declare function gtk_corner_type_get_type() as GType
#define GTK_TYPE_CORNER_TYPE gtk_corner_type_get_type()
declare function gtk_policy_type_get_type() as GType
#define GTK_TYPE_POLICY_TYPE gtk_policy_type_get_type()
declare function gtk_spin_button_update_policy_get_type() as GType
#define GTK_TYPE_SPIN_BUTTON_UPDATE_POLICY gtk_spin_button_update_policy_get_type()
declare function gtk_spin_type_get_type() as GType
#define GTK_TYPE_SPIN_TYPE gtk_spin_type_get_type()
declare function gtk_stack_transition_type_get_type() as GType
#define GTK_TYPE_STACK_TRANSITION_TYPE gtk_stack_transition_type_get_type()
declare function gtk_text_buffer_target_info_get_type() as GType
#define GTK_TYPE_TEXT_BUFFER_TARGET_INFO gtk_text_buffer_target_info_get_type()
declare function gtk_text_search_flags_get_type() as GType
#define GTK_TYPE_TEXT_SEARCH_FLAGS gtk_text_search_flags_get_type()
declare function gtk_text_window_type_get_type() as GType
#define GTK_TYPE_TEXT_WINDOW_TYPE gtk_text_window_type_get_type()
declare function gtk_text_view_layer_get_type() as GType
#define GTK_TYPE_TEXT_VIEW_LAYER gtk_text_view_layer_get_type()
declare function gtk_text_extend_selection_get_type() as GType
#define GTK_TYPE_TEXT_EXTEND_SELECTION gtk_text_extend_selection_get_type()
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
declare function gtk_widget_help_type_get_type() as GType
#define GTK_TYPE_WIDGET_HELP_TYPE gtk_widget_help_type_get_type()
declare function gtk_window_type_get_type() as GType
#define GTK_TYPE_WINDOW_TYPE gtk_window_type_get_type()
declare function gtk_window_position_get_type() as GType
#define GTK_TYPE_WINDOW_POSITION gtk_window_position_get_type()
declare function gtk_rc_flags_get_type() as GType
#define GTK_TYPE_RC_FLAGS gtk_rc_flags_get_type()
declare function gtk_rc_token_type_get_type() as GType
#define GTK_TYPE_RC_TOKEN_TYPE gtk_rc_token_type_get_type()
declare function gtk_path_priority_type_get_type() as GType
#define GTK_TYPE_PATH_PRIORITY_TYPE gtk_path_priority_type_get_type()
declare function gtk_path_type_get_type() as GType
#define GTK_TYPE_PATH_TYPE gtk_path_type_get_type()
declare function gtk_expander_style_get_type() as GType
#define GTK_TYPE_EXPANDER_STYLE gtk_expander_style_get_type()
declare function gtk_attach_options_get_type() as GType
#define GTK_TYPE_ATTACH_OPTIONS gtk_attach_options_get_type()
declare function gtk_ui_manager_item_type_get_type() as GType

#define GTK_TYPE_UI_MANAGER_ITEM_TYPE gtk_ui_manager_item_type_get_type()
#define __GTK_VERSION_H__
const GTK_MAJOR_VERSION = 3
const GTK_MINOR_VERSION = 16
const GTK_MICRO_VERSION = 6
const GTK_BINARY_AGE = 1606
const GTK_INTERFACE_AGE = 6
#define GTK_CHECK_VERSION(major, minor, micro) (((GTK_MAJOR_VERSION > (major)) orelse ((GTK_MAJOR_VERSION = (major)) andalso (GTK_MINOR_VERSION > (minor)))) orelse (((GTK_MAJOR_VERSION = (major)) andalso (GTK_MINOR_VERSION = (minor))) andalso (GTK_MICRO_VERSION >= (micro))))
#define __GTK_VIEWPORT_H__
#define GTK_TYPE_VIEWPORT gtk_viewport_get_type()
#define GTK_VIEWPORT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_VIEWPORT, GtkViewport)
#define GTK_VIEWPORT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_VIEWPORT, GtkViewportClass)
#define GTK_IS_VIEWPORT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_VIEWPORT)
#define GTK_IS_VIEWPORT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_VIEWPORT)
#define GTK_VIEWPORT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_VIEWPORT, GtkViewportClass)

type GtkViewport as _GtkViewport
type GtkViewportPrivate as _GtkViewportPrivate
type GtkViewportClass as _GtkViewportClass

type _GtkViewport
	bin as GtkBin
	priv as GtkViewportPrivate ptr
end type

type _GtkViewportClass
	parent_class as GtkBinClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
#define __GTK_WIDGET_PATH_H__
#define GTK_TYPE_WIDGET_PATH gtk_widget_path_get_type()
declare function gtk_widget_path_get_type() as GType
declare function gtk_widget_path_new() as GtkWidgetPath ptr
declare function gtk_widget_path_copy(byval path as const GtkWidgetPath ptr) as GtkWidgetPath ptr
declare function gtk_widget_path_ref(byval path as GtkWidgetPath ptr) as GtkWidgetPath ptr
declare sub gtk_widget_path_unref(byval path as GtkWidgetPath ptr)
declare sub gtk_widget_path_free(byval path as GtkWidgetPath ptr)
declare function gtk_widget_path_to_string(byval path as const GtkWidgetPath ptr) as zstring ptr
declare function gtk_widget_path_length(byval path as const GtkWidgetPath ptr) as gint
declare function gtk_widget_path_append_type(byval path as GtkWidgetPath ptr, byval type as GType) as gint
declare sub gtk_widget_path_prepend_type(byval path as GtkWidgetPath ptr, byval type as GType)
declare function gtk_widget_path_append_with_siblings(byval path as GtkWidgetPath ptr, byval siblings as GtkWidgetPath ptr, byval sibling_index as guint) as gint
declare function gtk_widget_path_append_for_widget(byval path as GtkWidgetPath ptr, byval widget as GtkWidget ptr) as gint
declare function gtk_widget_path_iter_get_object_type(byval path as const GtkWidgetPath ptr, byval pos as gint) as GType
declare sub gtk_widget_path_iter_set_object_type(byval path as GtkWidgetPath ptr, byval pos as gint, byval type as GType)
declare function gtk_widget_path_iter_get_siblings(byval path as const GtkWidgetPath ptr, byval pos as gint) as const GtkWidgetPath ptr
declare function gtk_widget_path_iter_get_sibling_index(byval path as const GtkWidgetPath ptr, byval pos as gint) as guint
declare function gtk_widget_path_iter_get_name(byval path as const GtkWidgetPath ptr, byval pos as gint) as const gchar ptr
declare sub gtk_widget_path_iter_set_name(byval path as GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr)
declare function gtk_widget_path_iter_has_name(byval path as const GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr) as gboolean
declare function gtk_widget_path_iter_has_qname(byval path as const GtkWidgetPath ptr, byval pos as gint, byval qname as GQuark) as gboolean
declare function gtk_widget_path_iter_get_state(byval path as const GtkWidgetPath ptr, byval pos as gint) as GtkStateFlags
declare sub gtk_widget_path_iter_set_state(byval path as GtkWidgetPath ptr, byval pos as gint, byval state as GtkStateFlags)
declare sub gtk_widget_path_iter_add_class(byval path as GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr)
declare sub gtk_widget_path_iter_remove_class(byval path as GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr)
declare sub gtk_widget_path_iter_clear_classes(byval path as GtkWidgetPath ptr, byval pos as gint)
declare function gtk_widget_path_iter_list_classes(byval path as const GtkWidgetPath ptr, byval pos as gint) as GSList ptr
declare function gtk_widget_path_iter_has_class(byval path as const GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr) as gboolean
declare function gtk_widget_path_iter_has_qclass(byval path as const GtkWidgetPath ptr, byval pos as gint, byval qname as GQuark) as gboolean
declare sub gtk_widget_path_iter_add_region(byval path as GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr, byval flags as GtkRegionFlags)
declare sub gtk_widget_path_iter_remove_region(byval path as GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr)
declare sub gtk_widget_path_iter_clear_regions(byval path as GtkWidgetPath ptr, byval pos as gint)
declare function gtk_widget_path_iter_list_regions(byval path as const GtkWidgetPath ptr, byval pos as gint) as GSList ptr
declare function gtk_widget_path_iter_has_region(byval path as const GtkWidgetPath ptr, byval pos as gint, byval name as const gchar ptr, byval flags as GtkRegionFlags ptr) as gboolean
declare function gtk_widget_path_iter_has_qregion(byval path as const GtkWidgetPath ptr, byval pos as gint, byval qname as GQuark, byval flags as GtkRegionFlags ptr) as gboolean
declare function gtk_widget_path_get_object_type(byval path as const GtkWidgetPath ptr) as GType
declare function gtk_widget_path_is_type(byval path as const GtkWidgetPath ptr, byval type as GType) as gboolean
declare function gtk_widget_path_has_parent(byval path as const GtkWidgetPath ptr, byval type as GType) as gboolean

#define __GTK_WINDOW_GROUP_H__
#define GTK_TYPE_WINDOW_GROUP gtk_window_group_get_type()
#define GTK_WINDOW_GROUP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_WINDOW_GROUP, GtkWindowGroup)
#define GTK_WINDOW_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass)
#define GTK_IS_WINDOW_GROUP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_WINDOW_GROUP)
#define GTK_IS_WINDOW_GROUP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_WINDOW_GROUP)
#define GTK_WINDOW_GROUP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass)

type _GtkWindowGroup
	parent_instance as GObject
	priv as GtkWindowGroupPrivate ptr
end type

type _GtkWindowGroupClass
	parent_class as GObjectClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_window_group_get_type() as GType
declare function gtk_window_group_new() as GtkWindowGroup ptr
declare sub gtk_window_group_add_window(byval window_group as GtkWindowGroup ptr, byval window as GtkWindow ptr)
declare sub gtk_window_group_remove_window(byval window_group as GtkWindowGroup ptr, byval window as GtkWindow ptr)
declare function gtk_window_group_list_windows(byval window_group as GtkWindowGroup ptr) as GList ptr
declare function gtk_window_group_get_current_grab(byval window_group as GtkWindowGroup ptr) as GtkWidget ptr
declare function gtk_window_group_get_current_device_grab(byval window_group as GtkWindowGroup ptr, byval device as GdkDevice ptr) as GtkWidget ptr

#define __GTK_ARROW_H__
#define GTK_TYPE_ARROW gtk_arrow_get_type()
#define GTK_ARROW(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ARROW, GtkArrow)
#define GTK_ARROW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ARROW, GtkArrowClass)
#define GTK_IS_ARROW(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ARROW)
#define GTK_IS_ARROW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ARROW)
#define GTK_ARROW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ARROW, GtkArrowClass)

type GtkArrow as _GtkArrow
type GtkArrowPrivate as _GtkArrowPrivate
type GtkArrowClass as _GtkArrowClass

type _GtkArrow
	misc as GtkMisc
	priv as GtkArrowPrivate ptr
end type

type _GtkArrowClass
	parent_class as GtkMiscClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_arrow_get_type() as GType
declare function gtk_arrow_new(byval arrow_type as GtkArrowType, byval shadow_type as GtkShadowType) as GtkWidget ptr
declare sub gtk_arrow_set(byval arrow as GtkArrow ptr, byval arrow_type as GtkArrowType, byval shadow_type as GtkShadowType)

#define __GTK_ACTIVATABLE_H__
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
	_gtk_reserved1 as sub()
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
#define __GTK_ACTION_GROUP_H__
#define __GTK_STOCK_H__
type GtkTranslateFunc as function(byval path as const gchar ptr, byval func_data as gpointer) as gchar ptr
type GtkStockItem as _GtkStockItem

type _GtkStockItem
	stock_id as gchar ptr
	label as gchar ptr
	modifier as GdkModifierType
	keyval as guint
	translation_domain as gchar ptr
end type

declare sub gtk_stock_add(byval items as const GtkStockItem ptr, byval n_items as guint)
declare sub gtk_stock_add_static(byval items as const GtkStockItem ptr, byval n_items as guint)
declare function gtk_stock_lookup(byval stock_id as const gchar ptr, byval item as GtkStockItem ptr) as gboolean
declare function gtk_stock_list_ids() as GSList ptr
declare function gtk_stock_item_copy(byval item as const GtkStockItem ptr) as GtkStockItem ptr
declare sub gtk_stock_item_free(byval item as GtkStockItem ptr)
declare sub gtk_stock_set_translate_func(byval domain as const gchar ptr, byval func as GtkTranslateFunc, byval data as gpointer, byval notify as GDestroyNotify)
type GtkStock as zstring ptr

#define GTK_STOCK_ABOUT cast(GtkStock, @"gtk-about")
#define GTK_STOCK_ADD_ cast(GtkStock, @"gtk-add")
#define GTK_STOCK_APPLY cast(GtkStock, @"gtk-apply")
#define GTK_STOCK_BOLD cast(GtkStock, @"gtk-bold")
#define GTK_STOCK_CANCEL cast(GtkStock, @"gtk-cancel")
#define GTK_STOCK_CAPS_LOCK_WARNING cast(GtkStock, @"gtk-caps-lock-warning")
#define GTK_STOCK_CDROM cast(GtkStock, @"gtk-cdrom")
#define GTK_STOCK_CLEAR cast(GtkStock, @"gtk-clear")
#define GTK_STOCK_CLOSE cast(GtkStock, @"gtk-close")
#define GTK_STOCK_COLOR_PICKER cast(GtkStock, @"gtk-color-picker")
#define GTK_STOCK_CONNECT cast(GtkStock, @"gtk-connect")
#define GTK_STOCK_CONVERT cast(GtkStock, @"gtk-convert")
#define GTK_STOCK_COPY cast(GtkStock, @"gtk-copy")
#define GTK_STOCK_CUT cast(GtkStock, @"gtk-cut")
#define GTK_STOCK_DELETE cast(GtkStock, @"gtk-delete")
#define GTK_STOCK_DIALOG_AUTHENTICATION cast(GtkStock, @"gtk-dialog-authentication")
#define GTK_STOCK_DIALOG_INFO cast(GtkStock, @"gtk-dialog-info")
#define GTK_STOCK_DIALOG_WARNING cast(GtkStock, @"gtk-dialog-warning")
#define GTK_STOCK_DIALOG_ERROR cast(GtkStock, @"gtk-dialog-error")
#define GTK_STOCK_DIALOG_QUESTION cast(GtkStock, @"gtk-dialog-question")
#define GTK_STOCK_DIRECTORY cast(GtkStock, @"gtk-directory")
#define GTK_STOCK_DISCARD cast(GtkStock, @"gtk-discard")
#define GTK_STOCK_DISCONNECT cast(GtkStock, @"gtk-disconnect")
#define GTK_STOCK_DND cast(GtkStock, @"gtk-dnd")
#define GTK_STOCK_DND_MULTIPLE cast(GtkStock, @"gtk-dnd-multiple")
#define GTK_STOCK_EDIT cast(GtkStock, @"gtk-edit")
#define GTK_STOCK_EXECUTE cast(GtkStock, @"gtk-execute")
#define GTK_STOCK_FILE cast(GtkStock, @"gtk-file")
#define GTK_STOCK_FIND cast(GtkStock, @"gtk-find")
#define GTK_STOCK_FIND_AND_REPLACE cast(GtkStock, @"gtk-find-and-replace")
#define GTK_STOCK_FLOPPY cast(GtkStock, @"gtk-floppy")
#define GTK_STOCK_FULLSCREEN cast(GtkStock, @"gtk-fullscreen")
#define GTK_STOCK_GOTO_BOTTOM cast(GtkStock, @"gtk-goto-bottom")
#define GTK_STOCK_GOTO_FIRST cast(GtkStock, @"gtk-goto-first")
#define GTK_STOCK_GOTO_LAST cast(GtkStock, @"gtk-goto-last")
#define GTK_STOCK_GOTO_TOP cast(GtkStock, @"gtk-goto-top")
#define GTK_STOCK_GO_BACK cast(GtkStock, @"gtk-go-back")
#define GTK_STOCK_GO_DOWN cast(GtkStock, @"gtk-go-down")
#define GTK_STOCK_GO_FORWARD cast(GtkStock, @"gtk-go-forward")
#define GTK_STOCK_GO_UP cast(GtkStock, @"gtk-go-up")
#define GTK_STOCK_HARDDISK cast(GtkStock, @"gtk-harddisk")
#define GTK_STOCK_HELP cast(GtkStock, @"gtk-help")
#define GTK_STOCK_HOME cast(GtkStock, @"gtk-home")
#define GTK_STOCK_INDEX cast(GtkStock, @"gtk-index")
#define GTK_STOCK_INDENT cast(GtkStock, @"gtk-indent")
#define GTK_STOCK_INFO cast(GtkStock, @"gtk-info")
#define GTK_STOCK_ITALIC cast(GtkStock, @"gtk-italic")
#define GTK_STOCK_JUMP_TO cast(GtkStock, @"gtk-jump-to")
#define GTK_STOCK_JUSTIFY_CENTER cast(GtkStock, @"gtk-justify-center")
#define GTK_STOCK_JUSTIFY_FILL cast(GtkStock, @"gtk-justify-fill")
#define GTK_STOCK_JUSTIFY_LEFT cast(GtkStock, @"gtk-justify-left")
#define GTK_STOCK_JUSTIFY_RIGHT cast(GtkStock, @"gtk-justify-right")
#define GTK_STOCK_LEAVE_FULLSCREEN cast(GtkStock, @"gtk-leave-fullscreen")
#define GTK_STOCK_MISSING_IMAGE cast(GtkStock, @"gtk-missing-image")
#define GTK_STOCK_MEDIA_FORWARD cast(GtkStock, @"gtk-media-forward")
#define GTK_STOCK_MEDIA_NEXT cast(GtkStock, @"gtk-media-next")
#define GTK_STOCK_MEDIA_PAUSE cast(GtkStock, @"gtk-media-pause")
#define GTK_STOCK_MEDIA_PLAY cast(GtkStock, @"gtk-media-play")
#define GTK_STOCK_MEDIA_PREVIOUS cast(GtkStock, @"gtk-media-previous")
#define GTK_STOCK_MEDIA_RECORD cast(GtkStock, @"gtk-media-record")
#define GTK_STOCK_MEDIA_REWIND cast(GtkStock, @"gtk-media-rewind")
#define GTK_STOCK_MEDIA_STOP cast(GtkStock, @"gtk-media-stop")
#define GTK_STOCK_NETWORK cast(GtkStock, @"gtk-network")
#define GTK_STOCK_NEW cast(GtkStock, @"gtk-new")
#define GTK_STOCK_NO cast(GtkStock, @"gtk-no")
#define GTK_STOCK_OK cast(GtkStock, @"gtk-ok")
#define GTK_STOCK_OPEN cast(GtkStock, @"gtk-open")
#define GTK_STOCK_ORIENTATION_PORTRAIT cast(GtkStock, @"gtk-orientation-portrait")
#define GTK_STOCK_ORIENTATION_LANDSCAPE cast(GtkStock, @"gtk-orientation-landscape")
#define GTK_STOCK_ORIENTATION_REVERSE_LANDSCAPE cast(GtkStock, @"gtk-orientation-reverse-landscape")
#define GTK_STOCK_ORIENTATION_REVERSE_PORTRAIT cast(GtkStock, @"gtk-orientation-reverse-portrait")
#define GTK_STOCK_PAGE_SETUP cast(GtkStock, @"gtk-page-setup")
#define GTK_STOCK_PASTE cast(GtkStock, @"gtk-paste")
#define GTK_STOCK_PREFERENCES cast(GtkStock, @"gtk-preferences")
#define GTK_STOCK_PRINT cast(GtkStock, @"gtk-print")
#define GTK_STOCK_PRINT_ERROR cast(GtkStock, @"gtk-print-error")
#define GTK_STOCK_PRINT_PAUSED cast(GtkStock, @"gtk-print-paused")
#define GTK_STOCK_PRINT_PREVIEW cast(GtkStock, @"gtk-print-preview")
#define GTK_STOCK_PRINT_REPORT cast(GtkStock, @"gtk-print-report")
#define GTK_STOCK_PRINT_WARNING cast(GtkStock, @"gtk-print-warning")
#define GTK_STOCK_PROPERTIES cast(GtkStock, @"gtk-properties")
#define GTK_STOCK_QUIT cast(GtkStock, @"gtk-quit")
#define GTK_STOCK_REDO cast(GtkStock, @"gtk-redo")
#define GTK_STOCK_REFRESH cast(GtkStock, @"gtk-refresh")
#define GTK_STOCK_REMOVE cast(GtkStock, @"gtk-remove")
#define GTK_STOCK_REVERT_TO_SAVED cast(GtkStock, @"gtk-revert-to-saved")
#define GTK_STOCK_SAVE cast(GtkStock, @"gtk-save")
#define GTK_STOCK_SAVE_AS cast(GtkStock, @"gtk-save-as")
#define GTK_STOCK_SELECT_ALL cast(GtkStock, @"gtk-select-all")
#define GTK_STOCK_SELECT_COLOR cast(GtkStock, @"gtk-select-color")
#define GTK_STOCK_SELECT_FONT cast(GtkStock, @"gtk-select-font")
#define GTK_STOCK_SORT_ASCENDING cast(GtkStock, @"gtk-sort-ascending")
#define GTK_STOCK_SORT_DESCENDING cast(GtkStock, @"gtk-sort-descending")
#define GTK_STOCK_SPELL_CHECK cast(GtkStock, @"gtk-spell-check")
#define GTK_STOCK_STOP cast(GtkStock, @"gtk-stop")
#define GTK_STOCK_STRIKETHROUGH cast(GtkStock, @"gtk-strikethrough")
#define GTK_STOCK_UNDELETE cast(GtkStock, @"gtk-undelete")
#define GTK_STOCK_UNDERLINE cast(GtkStock, @"gtk-underline")
#define GTK_STOCK_UNDO cast(GtkStock, @"gtk-undo")
#define GTK_STOCK_UNINDENT cast(GtkStock, @"gtk-unindent")
#define GTK_STOCK_YES cast(GtkStock, @"gtk-yes")
#define GTK_STOCK_ZOOM_100 cast(GtkStock, @"gtk-zoom-100")
#define GTK_STOCK_ZOOM_FIT cast(GtkStock, @"gtk-zoom-fit")
#define GTK_STOCK_ZOOM_IN cast(GtkStock, @"gtk-zoom-in")
#define GTK_STOCK_ZOOM_OUT cast(GtkStock, @"gtk-zoom-out")
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
	priv as GtkActionGroupPrivate ptr
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
declare function gtk_action_group_get_accel_group(byval action_group as GtkActionGroup ptr) as GtkAccelGroup ptr
declare sub gtk_action_group_set_accel_group(byval action_group as GtkActionGroup ptr, byval accel_group as GtkAccelGroup ptr)
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

#define __GTK_ALIGNMENT_H__
#define GTK_TYPE_ALIGNMENT gtk_alignment_get_type()
#define GTK_ALIGNMENT(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_ALIGNMENT, GtkAlignment)
#define GTK_ALIGNMENT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_ALIGNMENT, GtkAlignmentClass)
#define GTK_IS_ALIGNMENT(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_ALIGNMENT)
#define GTK_IS_ALIGNMENT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_ALIGNMENT)
#define GTK_ALIGNMENT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ALIGNMENT, GtkAlignmentClass)

type GtkAlignment as _GtkAlignment
type GtkAlignmentPrivate as _GtkAlignmentPrivate
type GtkAlignmentClass as _GtkAlignmentClass

type _GtkAlignment
	bin as GtkBin
	priv as GtkAlignmentPrivate ptr
end type

type _GtkAlignmentClass
	parent_class as GtkBinClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_alignment_get_type() as GType
declare function gtk_alignment_new(byval xalign as gfloat, byval yalign as gfloat, byval xscale as gfloat, byval yscale as gfloat) as GtkWidget ptr
declare sub gtk_alignment_set(byval alignment as GtkAlignment ptr, byval xalign as gfloat, byval yalign as gfloat, byval xscale as gfloat, byval yscale as gfloat)
declare sub gtk_alignment_set_padding(byval alignment as GtkAlignment ptr, byval padding_top as guint, byval padding_bottom as guint, byval padding_left as guint, byval padding_right as guint)
declare sub gtk_alignment_get_padding(byval alignment as GtkAlignment ptr, byval padding_top as guint ptr, byval padding_bottom as guint ptr, byval padding_left as guint ptr, byval padding_right as guint ptr)

#define __GTK_COLOR_SELECTION_H__
#define GTK_TYPE_COLOR_SELECTION gtk_color_selection_get_type()
#define GTK_COLOR_SELECTION(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelection)
#define GTK_COLOR_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass)
#define GTK_IS_COLOR_SELECTION(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_SELECTION)
#define GTK_IS_COLOR_SELECTION_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_SELECTION)
#define GTK_COLOR_SELECTION_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass)

type GtkColorSelection as _GtkColorSelection
type GtkColorSelectionPrivate as _GtkColorSelectionPrivate
type GtkColorSelectionClass as _GtkColorSelectionClass
type GtkColorSelectionChangePaletteFunc as sub(byval colors as const GdkColor ptr, byval n_colors as gint)
type GtkColorSelectionChangePaletteWithScreenFunc as sub(byval screen as GdkScreen ptr, byval colors as const GdkColor ptr, byval n_colors as gint)

type _GtkColorSelection
	parent_instance as GtkBox
	private_data as GtkColorSelectionPrivate ptr
end type

type _GtkColorSelectionClass
	parent_class as GtkBoxClass
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
declare sub gtk_color_selection_set_current_alpha(byval colorsel as GtkColorSelection ptr, byval alpha as guint16)
declare function gtk_color_selection_get_current_alpha(byval colorsel as GtkColorSelection ptr) as guint16
declare sub gtk_color_selection_set_previous_alpha(byval colorsel as GtkColorSelection ptr, byval alpha as guint16)
declare function gtk_color_selection_get_previous_alpha(byval colorsel as GtkColorSelection ptr) as guint16
declare sub gtk_color_selection_set_current_rgba(byval colorsel as GtkColorSelection ptr, byval rgba_ as const GdkRGBA ptr)
declare sub gtk_color_selection_get_current_rgba(byval colorsel as GtkColorSelection ptr, byval rgba_ as GdkRGBA ptr)
declare sub gtk_color_selection_set_previous_rgba(byval colorsel as GtkColorSelection ptr, byval rgba_ as const GdkRGBA ptr)
declare sub gtk_color_selection_get_previous_rgba(byval colorsel as GtkColorSelection ptr, byval rgba_ as GdkRGBA ptr)
declare function gtk_color_selection_is_adjusting(byval colorsel as GtkColorSelection ptr) as gboolean
declare function gtk_color_selection_palette_from_string(byval str as const gchar ptr, byval colors as GdkColor ptr ptr, byval n_colors as gint ptr) as gboolean
declare function gtk_color_selection_palette_to_string(byval colors as const GdkColor ptr, byval n_colors as gint) as gchar ptr
declare function gtk_color_selection_set_change_palette_with_screen_hook(byval func as GtkColorSelectionChangePaletteWithScreenFunc) as GtkColorSelectionChangePaletteWithScreenFunc
declare sub gtk_color_selection_set_current_color(byval colorsel as GtkColorSelection ptr, byval color as const GdkColor ptr)
declare sub gtk_color_selection_get_current_color(byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)
declare sub gtk_color_selection_set_previous_color(byval colorsel as GtkColorSelection ptr, byval color as const GdkColor ptr)
declare sub gtk_color_selection_get_previous_color(byval colorsel as GtkColorSelection ptr, byval color as GdkColor ptr)

#define __GTK_COLOR_SELECTION_DIALOG_H__
#define GTK_TYPE_COLOR_SELECTION_DIALOG gtk_color_selection_dialog_get_type()
#define GTK_COLOR_SELECTION_DIALOG(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialog)
#define GTK_COLOR_SELECTION_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass)
#define GTK_IS_COLOR_SELECTION_DIALOG(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_COLOR_SELECTION_DIALOG)
#define GTK_IS_COLOR_SELECTION_DIALOG_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_COLOR_SELECTION_DIALOG)
#define GTK_COLOR_SELECTION_DIALOG_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass)

type GtkColorSelectionDialog as _GtkColorSelectionDialog
type GtkColorSelectionDialogPrivate as _GtkColorSelectionDialogPrivate
type GtkColorSelectionDialogClass as _GtkColorSelectionDialogClass

type _GtkColorSelectionDialog
	parent_instance as GtkDialog
	priv as GtkColorSelectionDialogPrivate ptr
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
type GtkFontSelectionPrivate as _GtkFontSelectionPrivate
type GtkFontSelectionClass as _GtkFontSelectionClass
type GtkFontSelectionDialog as _GtkFontSelectionDialog
type GtkFontSelectionDialogPrivate as _GtkFontSelectionDialogPrivate
type GtkFontSelectionDialogClass as _GtkFontSelectionDialogClass

type _GtkFontSelection
	parent_instance as GtkBox
	priv as GtkFontSelectionPrivate ptr
end type

type _GtkFontSelectionClass
	parent_class as GtkBoxClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

type _GtkFontSelectionDialog
	parent_instance as GtkDialog
	priv as GtkFontSelectionDialogPrivate ptr
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
declare function gtk_font_selection_set_font_name(byval fontsel as GtkFontSelection ptr, byval fontname as const gchar ptr) as gboolean
declare function gtk_font_selection_get_preview_text(byval fontsel as GtkFontSelection ptr) as const gchar ptr
declare sub gtk_font_selection_set_preview_text(byval fontsel as GtkFontSelection ptr, byval text as const gchar ptr)
declare function gtk_font_selection_dialog_get_type() as GType
declare function gtk_font_selection_dialog_new(byval title as const gchar ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_ok_button(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_cancel_button(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_font_selection(byval fsd as GtkFontSelectionDialog ptr) as GtkWidget ptr
declare function gtk_font_selection_dialog_get_font_name(byval fsd as GtkFontSelectionDialog ptr) as gchar ptr
declare function gtk_font_selection_dialog_set_font_name(byval fsd as GtkFontSelectionDialog ptr, byval fontname as const gchar ptr) as gboolean
declare function gtk_font_selection_dialog_get_preview_text(byval fsd as GtkFontSelectionDialog ptr) as const gchar ptr
declare sub gtk_font_selection_dialog_set_preview_text(byval fsd as GtkFontSelectionDialog ptr, byval text as const gchar ptr)

#define __GTK_GRADIENT_H__
#define __GTK_SYMBOLIC_COLOR_H__
#define GTK_TYPE_SYMBOLIC_COLOR gtk_symbolic_color_get_type()

declare function gtk_symbolic_color_get_type() as GType
declare function gtk_symbolic_color_new_literal(byval color as const GdkRGBA ptr) as GtkSymbolicColor ptr
declare function gtk_symbolic_color_new_name(byval name as const gchar ptr) as GtkSymbolicColor ptr
declare function gtk_symbolic_color_new_shade(byval color as GtkSymbolicColor ptr, byval factor as gdouble) as GtkSymbolicColor ptr
declare function gtk_symbolic_color_new_alpha(byval color as GtkSymbolicColor ptr, byval factor as gdouble) as GtkSymbolicColor ptr
declare function gtk_symbolic_color_new_mix(byval color1 as GtkSymbolicColor ptr, byval color2 as GtkSymbolicColor ptr, byval factor as gdouble) as GtkSymbolicColor ptr
declare function gtk_symbolic_color_new_win32(byval theme_class as const gchar ptr, byval id as gint) as GtkSymbolicColor ptr
declare function gtk_symbolic_color_ref(byval color as GtkSymbolicColor ptr) as GtkSymbolicColor ptr
declare sub gtk_symbolic_color_unref(byval color as GtkSymbolicColor ptr)
declare function gtk_symbolic_color_to_string(byval color as GtkSymbolicColor ptr) as zstring ptr
declare function gtk_symbolic_color_resolve(byval color as GtkSymbolicColor ptr, byval props as GtkStyleProperties ptr, byval resolved_color as GdkRGBA ptr) as gboolean
#define GTK_TYPE_GRADIENT gtk_gradient_get_type()
declare function gtk_gradient_get_type() as GType
declare function gtk_gradient_new_linear(byval x0 as gdouble, byval y0 as gdouble, byval x1 as gdouble, byval y1 as gdouble) as GtkGradient ptr
declare function gtk_gradient_new_radial(byval x0 as gdouble, byval y0 as gdouble, byval radius0 as gdouble, byval x1 as gdouble, byval y1 as gdouble, byval radius1 as gdouble) as GtkGradient ptr
declare sub gtk_gradient_add_color_stop(byval gradient as GtkGradient ptr, byval offset as gdouble, byval color as GtkSymbolicColor ptr)
declare function gtk_gradient_ref(byval gradient as GtkGradient ptr) as GtkGradient ptr
declare sub gtk_gradient_unref(byval gradient as GtkGradient ptr)
declare function gtk_gradient_resolve(byval gradient as GtkGradient ptr, byval props as GtkStyleProperties ptr, byval resolved_gradient as cairo_pattern_t ptr ptr) as gboolean
declare function gtk_gradient_resolve_for_context(byval gradient as GtkGradient ptr, byval context as GtkStyleContext ptr) as cairo_pattern_t ptr
declare function gtk_gradient_to_string(byval gradient as GtkGradient ptr) as zstring ptr

#define __GTK_HANDLE_BOX_H__
#define GTK_TYPE_HANDLE_BOX gtk_handle_box_get_type()
#define GTK_HANDLE_BOX(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HANDLE_BOX, GtkHandleBox)
#define GTK_HANDLE_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HANDLE_BOX, GtkHandleBoxClass)
#define GTK_IS_HANDLE_BOX(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HANDLE_BOX)
#define GTK_IS_HANDLE_BOX_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HANDLE_BOX)
#define GTK_HANDLE_BOX_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HANDLE_BOX, GtkHandleBoxClass)

type GtkHandleBox as _GtkHandleBox
type GtkHandleBoxPrivate as _GtkHandleBoxPrivate
type GtkHandleBoxClass as _GtkHandleBoxClass

type _GtkHandleBox
	bin as GtkBin
	priv as GtkHandleBoxPrivate ptr
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
#define __GTK_HPANED_H__
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
#define __GTK_HSV_H__
#define GTK_TYPE_HSV gtk_hsv_get_type()
#define GTK_HSV(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_HSV, GtkHSV)
#define GTK_HSV_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_HSV, GtkHSVClass)
#define GTK_IS_HSV(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_HSV)
#define GTK_IS_HSV_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_HSV)
#define GTK_HSV_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_HSV, GtkHSVClass)

type GtkHSV as _GtkHSV
type GtkHSVPrivate as _GtkHSVPrivate
type GtkHSVClass as _GtkHSVClass

type _GtkHSV
	parent_instance as GtkWidget
	priv as GtkHSVPrivate ptr
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

#define __GTK_HSCALE_H__
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
#define __GTK_IMAGE_MENU_ITEM_H__
#define GTK_TYPE_IMAGE_MENU_ITEM gtk_image_menu_item_get_type()
#define GTK_IMAGE_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItem)
#define GTK_IMAGE_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass)
#define GTK_IS_IMAGE_MENU_ITEM(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_IMAGE_MENU_ITEM)
#define GTK_IS_IMAGE_MENU_ITEM_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_IMAGE_MENU_ITEM)
#define GTK_IMAGE_MENU_ITEM_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass)

type GtkImageMenuItem as _GtkImageMenuItem
type GtkImageMenuItemPrivate as _GtkImageMenuItemPrivate
type GtkImageMenuItemClass as _GtkImageMenuItemClass

type _GtkImageMenuItem
	menu_item as GtkMenuItem
	priv as GtkImageMenuItemPrivate ptr
end type

type _GtkImageMenuItemClass
	parent_class as GtkMenuItemClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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

#define __GTK_NUMERABLE_ICON_H__
#define GTK_TYPE_NUMERABLE_ICON gtk_numerable_icon_get_type()
#define GTK_NUMERABLE_ICON(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_NUMERABLE_ICON, GtkNumerableIcon)
#define GTK_NUMERABLE_ICON_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_NUMERABLE_ICON, GtkNumerableIconClass)
#define GTK_IS_NUMERABLE_ICON(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_NUMERABLE_ICON)
#define GTK_IS_NUMERABLE_ICON_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_NUMERABLE_ICON)
#define GTK_NUMERABLE_ICON_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_NUMERABLE_ICON, GtkNumerableIconClass)

type GtkNumerableIcon as _GtkNumerableIcon
type GtkNumerableIconClass as _GtkNumerableIconClass
type GtkNumerableIconPrivate as _GtkNumerableIconPrivate

type _GtkNumerableIcon
	parent as GEmblemedIcon
	priv as GtkNumerableIconPrivate ptr
end type

type _GtkNumerableIconClass
	parent_class as GEmblemedIconClass
	padding(0 to 15) as gpointer
end type

declare function gtk_numerable_icon_get_type() as GType
declare function gtk_numerable_icon_new(byval base_icon as GIcon ptr) as GIcon ptr
declare function gtk_numerable_icon_new_with_style_context(byval base_icon as GIcon ptr, byval context as GtkStyleContext ptr) as GIcon ptr
declare function gtk_numerable_icon_get_style_context(byval self as GtkNumerableIcon ptr) as GtkStyleContext ptr
declare sub gtk_numerable_icon_set_style_context(byval self as GtkNumerableIcon ptr, byval style as GtkStyleContext ptr)
declare function gtk_numerable_icon_get_count(byval self as GtkNumerableIcon ptr) as gint
declare sub gtk_numerable_icon_set_count(byval self as GtkNumerableIcon ptr, byval count as gint)
declare function gtk_numerable_icon_get_label(byval self as GtkNumerableIcon ptr) as const gchar ptr
declare sub gtk_numerable_icon_set_label(byval self as GtkNumerableIcon ptr, byval label as const gchar ptr)
declare sub gtk_numerable_icon_set_background_gicon(byval self as GtkNumerableIcon ptr, byval icon as GIcon ptr)
declare function gtk_numerable_icon_get_background_gicon(byval self as GtkNumerableIcon ptr) as GIcon ptr
declare sub gtk_numerable_icon_set_background_icon_name(byval self as GtkNumerableIcon ptr, byval icon_name as const gchar ptr)
declare function gtk_numerable_icon_get_background_icon_name(byval self as GtkNumerableIcon ptr) as const gchar ptr

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
declare sub _gtk_toggle_action_set_active(byval toggle_action as GtkToggleAction ptr, byval is_active as gboolean)

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
declare sub gtk_radio_action_join_group(byval action as GtkRadioAction ptr, byval group_source as GtkRadioAction ptr)
declare function gtk_radio_action_get_current_value(byval action as GtkRadioAction ptr) as gint
declare sub gtk_radio_action_set_current_value(byval action as GtkRadioAction ptr, byval current_value as gint)
#define __GTK_RC_H__
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

declare function _gtk_rc_parse_widget_class_path(byval pattern as const gchar ptr) as GSList ptr
declare sub _gtk_rc_free_widget_class_path(byval list as GSList ptr)
declare function _gtk_rc_match_widget_class(byval list as GSList ptr, byval length as gint, byval path as gchar ptr, byval path_reversed as gchar ptr) as gboolean
declare sub gtk_rc_add_default_file(byval filename as const gchar ptr)
declare sub gtk_rc_set_default_files(byval filenames as gchar ptr ptr)
declare function gtk_rc_get_default_files() as gchar ptr ptr
declare function gtk_rc_get_style(byval widget as GtkWidget ptr) as GtkStyle ptr
declare function gtk_rc_get_style_by_paths(byval settings as GtkSettings ptr, byval widget_path as const zstring ptr, byval class_path as const zstring ptr, byval type as GType) as GtkStyle ptr
declare function gtk_rc_reparse_all_for_settings(byval settings as GtkSettings ptr, byval force_load as gboolean) as gboolean
declare sub gtk_rc_reset_styles(byval settings as GtkSettings ptr)
declare function gtk_rc_find_pixmap_in_path(byval settings as GtkSettings ptr, byval scanner as GScanner ptr, byval pixmap_file as const gchar ptr) as gchar ptr
declare sub gtk_rc_parse(byval filename as const gchar ptr)
declare sub gtk_rc_parse_string(byval rc_string as const gchar ptr)
declare function gtk_rc_reparse_all() as gboolean
declare function gtk_rc_style_get_type() as GType
declare function gtk_rc_style_new() as GtkRcStyle ptr
declare function gtk_rc_style_copy(byval orig as GtkRcStyle ptr) as GtkRcStyle ptr
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

declare sub gtk_binding_set_add_path(byval binding_set as GtkBindingSet ptr, byval path_type as GtkPathType, byval path_pattern as const gchar ptr, byval priority as GtkPathPriorityType)
#define __GTK_RECENT_ACTION_H__
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
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
end type

declare function gtk_recent_action_get_type() as GType
declare function gtk_recent_action_new(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr) as GtkAction ptr
declare function gtk_recent_action_new_for_manager(byval name as const gchar ptr, byval label as const gchar ptr, byval tooltip as const gchar ptr, byval stock_id as const gchar ptr, byval manager as GtkRecentManager ptr) as GtkAction ptr
declare function gtk_recent_action_get_show_numbers(byval action as GtkRecentAction ptr) as gboolean
declare sub gtk_recent_action_set_show_numbers(byval action as GtkRecentAction ptr, byval show_numbers as gboolean)

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
	__gtk_reserved3 as any ptr
	__gtk_reserved4 as any ptr
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
declare sub gtk_status_icon_set_has_tooltip(byval status_icon as GtkStatusIcon ptr, byval has_tooltip as gboolean)
declare sub gtk_status_icon_set_tooltip_text(byval status_icon as GtkStatusIcon ptr, byval text as const gchar ptr)
declare sub gtk_status_icon_set_tooltip_markup(byval status_icon as GtkStatusIcon ptr, byval markup as const gchar ptr)
declare sub gtk_status_icon_set_title(byval status_icon as GtkStatusIcon ptr, byval title as const gchar ptr)
declare function gtk_status_icon_get_title(byval status_icon as GtkStatusIcon ptr) as const gchar ptr
declare sub gtk_status_icon_set_name(byval status_icon as GtkStatusIcon ptr, byval name as const gchar ptr)
declare sub gtk_status_icon_set_visible(byval status_icon as GtkStatusIcon ptr, byval visible as gboolean)
declare function gtk_status_icon_get_visible(byval status_icon as GtkStatusIcon ptr) as gboolean
declare function gtk_status_icon_is_embedded(byval status_icon as GtkStatusIcon ptr) as gboolean
declare sub gtk_status_icon_position_menu(byval menu as GtkMenu ptr, byval x as gint ptr, byval y as gint ptr, byval push_in as gboolean ptr, byval user_data as gpointer)
declare function gtk_status_icon_get_geometry(byval status_icon as GtkStatusIcon ptr, byval screen as GdkScreen ptr ptr, byval area as GdkRectangle ptr, byval orientation as GtkOrientation ptr) as gboolean
declare function gtk_status_icon_get_has_tooltip(byval status_icon as GtkStatusIcon ptr) as gboolean
declare function gtk_status_icon_get_tooltip_text(byval status_icon as GtkStatusIcon ptr) as gchar ptr
declare function gtk_status_icon_get_tooltip_markup(byval status_icon as GtkStatusIcon ptr) as gchar ptr
declare function gtk_status_icon_get_x11_window_id(byval status_icon as GtkStatusIcon ptr) as guint32

#define __GTK_STYLE_H__
#define GTK_TYPE_STYLE gtk_style_get_type()
#define GTK_STYLE(object) G_TYPE_CHECK_INSTANCE_CAST((object), GTK_TYPE_STYLE, GtkStyle)
#define GTK_STYLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_STYLE, GtkStyleClass)
#define GTK_IS_STYLE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GTK_TYPE_STYLE)
#define GTK_IS_STYLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_STYLE)
#define GTK_STYLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_STYLE, GtkStyleClass)

type GtkStyleClass as _GtkStyleClass
type GtkThemeEngine as _GtkThemeEngine
type GtkRcProperty as _GtkRcProperty

type GtkExpanderStyle as long
enum
	GTK_EXPANDER_COLLAPSED
	GTK_EXPANDER_SEMI_COLLAPSED
	GTK_EXPANDER_SEMI_EXPANDED
	GTK_EXPANDER_EXPANDED
end enum

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
	background(0 to 4) as cairo_pattern_t ptr
	attach_count as gint
	visual as GdkVisual ptr
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
	draw_hline as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x1 as gint, byval x2 as gint, byval y as gint)
	draw_vline as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval y1_ as gint, byval y2_ as gint, byval x as gint)
	draw_shadow as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_arrow as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_diamond as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_box as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_flat_box as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_check as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_option as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_tab as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_shadow_gap as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
	draw_box_gap as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
	draw_extension as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
	draw_focus as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_slider as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
	draw_handle as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
	draw_expander as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
	draw_layout as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
	draw_resize_grip as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_spinner as sub(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval step as guint, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
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

declare function gtk_style_get_type() as GType
declare function gtk_style_new() as GtkStyle ptr
declare function gtk_style_copy(byval style as GtkStyle ptr) as GtkStyle ptr
declare function gtk_style_attach(byval style as GtkStyle ptr, byval window as GdkWindow ptr) as GtkStyle ptr
declare sub gtk_style_detach(byval style as GtkStyle ptr)
declare sub gtk_style_set_background(byval style as GtkStyle ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType)
declare sub gtk_style_apply_default_background(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval window as GdkWindow ptr, byval state_type as GtkStateType, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare function gtk_style_lookup_icon_set(byval style as GtkStyle ptr, byval stock_id as const gchar ptr) as GtkIconSet ptr
declare function gtk_style_lookup_color(byval style as GtkStyle ptr, byval color_name as const gchar ptr, byval color as GdkColor ptr) as gboolean
declare function gtk_style_render_icon(byval style as GtkStyle ptr, byval source as const GtkIconSource ptr, byval direction as GtkTextDirection, byval state as GtkStateType, byval size as GtkIconSize, byval widget as GtkWidget ptr, byval detail as const gchar ptr) as GdkPixbuf ptr
declare sub gtk_paint_hline(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x1 as gint, byval x2 as gint, byval y as gint)
declare sub gtk_paint_vline(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval y1_ as gint, byval y2_ as gint, byval x as gint)
declare sub gtk_paint_shadow(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_arrow(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval arrow_type as GtkArrowType, byval fill as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_diamond(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_box(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_flat_box(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_check(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_option(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_tab(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_shadow_gap(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_paint_box_gap(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType, byval gap_x as gint, byval gap_width as gint)
declare sub gtk_paint_extension(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval gap_side as GtkPositionType)
declare sub gtk_paint_focus(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_slider(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_paint_handle(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval shadow_type as GtkShadowType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval orientation as GtkOrientation)
declare sub gtk_paint_expander(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval expander_style as GtkExpanderStyle)
declare sub gtk_paint_layout(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval use_text as gboolean, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gtk_paint_resize_grip(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval edge as GdkWindowEdge, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_paint_spinner(byval style as GtkStyle ptr, byval cr as cairo_t ptr, byval state_type as GtkStateType, byval widget as GtkWidget ptr, byval detail as const gchar ptr, byval step as guint, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gtk_style_get_style_property(byval style as GtkStyle ptr, byval widget_type as GType, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub gtk_style_get_valist(byval style as GtkStyle ptr, byval widget_type as GType, byval first_property_name as const gchar ptr, byval var_args as va_list)
declare sub gtk_style_get(byval style as GtkStyle ptr, byval widget_type as GType, byval first_property_name as const gchar ptr, ...)
declare function _gtk_style_new_for_path(byval screen as GdkScreen ptr, byval path as GtkWidgetPath ptr) as GtkStyle ptr
declare sub _gtk_style_shade(byval a as const GdkColor ptr, byval b as GdkColor ptr, byval k as gdouble)
declare function gtk_style_has_context(byval style as GtkStyle ptr) as gboolean
declare sub gtk_widget_style_attach(byval widget as GtkWidget ptr)
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
declare sub gtk_widget_reset_rc_styles(byval widget as GtkWidget ptr)
declare function gtk_widget_get_default_style() as GtkStyle ptr
declare sub gtk_widget_path(byval widget as GtkWidget ptr, byval path_length as guint ptr, byval path as gchar ptr ptr, byval path_reversed as gchar ptr ptr)
declare sub gtk_widget_class_path(byval widget as GtkWidget ptr, byval path_length as guint ptr, byval path as gchar ptr ptr, byval path_reversed as gchar ptr ptr)
declare function gtk_widget_render_icon(byval widget as GtkWidget ptr, byval stock_id as const gchar ptr, byval size as GtkIconSize, byval detail as const gchar ptr) as GdkPixbuf ptr

#define __GTK_TABLE_H__
#define GTK_TYPE_TABLE gtk_table_get_type()
#define GTK_TABLE(obj) G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_TABLE, GtkTable)
#define GTK_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_TABLE, GtkTableClass)
#define GTK_IS_TABLE(obj) G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_TABLE)
#define GTK_IS_TABLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GTK_TYPE_TABLE)
#define GTK_TABLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TABLE, GtkTableClass)

type GtkTable as _GtkTable
type GtkTablePrivate as _GtkTablePrivate
type GtkTableClass as _GtkTableClass
type GtkTableChild as _GtkTableChild
type GtkTableRowCol as _GtkTableRowCol

type _GtkTable
	container as GtkContainer
	priv as GtkTablePrivate ptr
end type

type _GtkTableClass
	parent_class as GtkContainerClass
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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

type GtkAttachOptions as long
enum
	GTK_EXPAND = 1 shl 0
	GTK_SHRINK = 1 shl 1
	GTK_FILL = 1 shl 2
end enum

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
type GtkTearoffMenuItemPrivate as _GtkTearoffMenuItemPrivate
type GtkTearoffMenuItemClass as _GtkTearoffMenuItemClass

type _GtkTearoffMenuItem
	menu_item as GtkMenuItem
	priv as GtkTearoffMenuItemPrivate ptr
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
#define __GTK_THEMING_ENGINE_H__
#define GTK_TYPE_THEMING_ENGINE gtk_theming_engine_get_type()
#define GTK_THEMING_ENGINE(o) G_TYPE_CHECK_INSTANCE_CAST((o), GTK_TYPE_THEMING_ENGINE, GtkThemingEngine)
#define GTK_THEMING_ENGINE_CLASS(c) G_TYPE_CHECK_CLASS_CAST((c), GTK_TYPE_THEMING_ENGINE, GtkThemingEngineClass)
#define GTK_IS_THEMING_ENGINE(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GTK_TYPE_THEMING_ENGINE)
#define GTK_IS_THEMING_ENGINE_CLASS(c) G_TYPE_CHECK_CLASS_TYPE((c), GTK_TYPE_THEMING_ENGINE)
#define GTK_THEMING_ENGINE_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_THEMING_ENGINE, GtkThemingEngineClass)

type GtkThemingEngine as _GtkThemingEngine
type GtkThemingEngineClass as _GtkThemingEngineClass
type GtkThemingEnginePrivate as GtkThemingEnginePrivate_

type _GtkThemingEngine
	parent_object as GObject
	priv as GtkThemingEnginePrivate ptr
end type

type _GtkThemingEngineClass
	parent_class as GObjectClass
	render_line as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x0 as gdouble, byval y0 as gdouble, byval x1 as gdouble, byval y1 as gdouble)
	render_background as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_frame as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_frame_gap as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble, byval gap_side as GtkPositionType, byval xy0_gap as gdouble, byval xy1_gap as gdouble)
	render_extension as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble, byval gap_side as GtkPositionType)
	render_check as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_option as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_arrow as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval angle as gdouble, byval x as gdouble, byval y as gdouble, byval size as gdouble)
	render_expander as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_focus as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_layout as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval layout as PangoLayout ptr)
	render_slider as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble, byval orientation as GtkOrientation)
	render_handle as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_activity as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval x as gdouble, byval y as gdouble, byval width as gdouble, byval height as gdouble)
	render_icon_pixbuf as function(byval engine as GtkThemingEngine ptr, byval source as const GtkIconSource ptr, byval size as GtkIconSize) as GdkPixbuf ptr
	render_icon as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval pixbuf as GdkPixbuf ptr, byval x as gdouble, byval y as gdouble)
	render_icon_surface as sub(byval engine as GtkThemingEngine ptr, byval cr as cairo_t ptr, byval surface as cairo_surface_t ptr, byval x as gdouble, byval y as gdouble)
	padding(0 to 13) as gpointer
end type

declare function gtk_theming_engine_get_type() as GType
declare sub gtk_theming_engine_register_property(byval name_space as const gchar ptr, byval parse_func as GtkStylePropertyParser, byval pspec as GParamSpec ptr)
declare sub gtk_theming_engine_get_property(byval engine as GtkThemingEngine ptr, byval property as const gchar ptr, byval state as GtkStateFlags, byval value as GValue ptr)
declare sub gtk_theming_engine_get_valist(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval args as va_list)
declare sub gtk_theming_engine_get(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, ...)
declare sub gtk_theming_engine_get_style_property(byval engine as GtkThemingEngine ptr, byval property_name as const gchar ptr, byval value as GValue ptr)
declare sub gtk_theming_engine_get_style_valist(byval engine as GtkThemingEngine ptr, byval args as va_list)
declare sub gtk_theming_engine_get_style(byval engine as GtkThemingEngine ptr, ...)
declare function gtk_theming_engine_lookup_color(byval engine as GtkThemingEngine ptr, byval color_name as const gchar ptr, byval color as GdkRGBA ptr) as gboolean
declare function gtk_theming_engine_get_path(byval engine as GtkThemingEngine ptr) as const GtkWidgetPath ptr
declare function gtk_theming_engine_has_class(byval engine as GtkThemingEngine ptr, byval style_class as const gchar ptr) as gboolean
declare function gtk_theming_engine_has_region(byval engine as GtkThemingEngine ptr, byval style_region as const gchar ptr, byval flags as GtkRegionFlags ptr) as gboolean
declare function gtk_theming_engine_get_state(byval engine as GtkThemingEngine ptr) as GtkStateFlags
declare function gtk_theming_engine_state_is_running(byval engine as GtkThemingEngine ptr, byval state as GtkStateType, byval progress as gdouble ptr) as gboolean
declare function gtk_theming_engine_get_direction(byval engine as GtkThemingEngine ptr) as GtkTextDirection
declare function gtk_theming_engine_get_junction_sides(byval engine as GtkThemingEngine ptr) as GtkJunctionSides
declare sub gtk_theming_engine_get_color(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval color as GdkRGBA ptr)
declare sub gtk_theming_engine_get_background_color(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval color as GdkRGBA ptr)
declare sub gtk_theming_engine_get_border_color(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval color as GdkRGBA ptr)
declare sub gtk_theming_engine_get_border(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval border as GtkBorder ptr)
declare sub gtk_theming_engine_get_padding(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval padding as GtkBorder ptr)
declare sub gtk_theming_engine_get_margin(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags, byval margin as GtkBorder ptr)
declare function gtk_theming_engine_get_font(byval engine as GtkThemingEngine ptr, byval state as GtkStateFlags) as const PangoFontDescription ptr
declare function gtk_theming_engine_load(byval name as const gchar ptr) as GtkThemingEngine ptr
declare function gtk_theming_engine_get_screen(byval engine as GtkThemingEngine ptr) as GdkScreen ptr

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
	add_widget as sub(byval manager as GtkUIManager ptr, byval widget as GtkWidget ptr)
	actions_changed as sub(byval manager as GtkUIManager ptr)
	connect_proxy as sub(byval manager as GtkUIManager ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
	disconnect_proxy as sub(byval manager as GtkUIManager ptr, byval action as GtkAction ptr, byval proxy as GtkWidget ptr)
	pre_activate as sub(byval manager as GtkUIManager ptr, byval action as GtkAction ptr)
	post_activate as sub(byval manager as GtkUIManager ptr, byval action as GtkAction ptr)
	get_widget as function(byval manager as GtkUIManager ptr, byval path as const gchar ptr) as GtkWidget ptr
	get_action as function(byval manager as GtkUIManager ptr, byval path as const gchar ptr) as GtkAction ptr
	_gtk_reserved1 as sub()
	_gtk_reserved2 as sub()
	_gtk_reserved3 as sub()
	_gtk_reserved4 as sub()
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
declare sub gtk_ui_manager_set_add_tearoffs(byval manager as GtkUIManager ptr, byval add_tearoffs as gboolean)
declare function gtk_ui_manager_get_add_tearoffs(byval manager as GtkUIManager ptr) as gboolean
declare sub gtk_ui_manager_insert_action_group(byval manager as GtkUIManager ptr, byval action_group as GtkActionGroup ptr, byval pos as gint)
declare sub gtk_ui_manager_remove_action_group(byval manager as GtkUIManager ptr, byval action_group as GtkActionGroup ptr)
declare function gtk_ui_manager_get_action_groups(byval manager as GtkUIManager ptr) as GList ptr
declare function gtk_ui_manager_get_accel_group(byval manager as GtkUIManager ptr) as GtkAccelGroup ptr
declare function gtk_ui_manager_get_widget(byval manager as GtkUIManager ptr, byval path as const gchar ptr) as GtkWidget ptr
declare function gtk_ui_manager_get_toplevels(byval manager as GtkUIManager ptr, byval types as GtkUIManagerItemType) as GSList ptr
declare function gtk_ui_manager_get_action(byval manager as GtkUIManager ptr, byval path as const gchar ptr) as GtkAction ptr
declare function gtk_ui_manager_add_ui_from_string(byval manager as GtkUIManager ptr, byval buffer as const gchar ptr, byval length as gssize, byval error as GError ptr ptr) as guint
declare function gtk_ui_manager_add_ui_from_file(byval manager as GtkUIManager ptr, byval filename as const gchar ptr, byval error as GError ptr ptr) as guint
declare function gtk_ui_manager_add_ui_from_resource(byval manager as GtkUIManager ptr, byval resource_path as const gchar ptr, byval error as GError ptr ptr) as guint
declare sub gtk_ui_manager_add_ui(byval manager as GtkUIManager ptr, byval merge_id as guint, byval path as const gchar ptr, byval name as const gchar ptr, byval action as const gchar ptr, byval type as GtkUIManagerItemType, byval top as gboolean)
declare sub gtk_ui_manager_remove_ui(byval manager as GtkUIManager ptr, byval merge_id as guint)
declare function gtk_ui_manager_get_ui(byval manager as GtkUIManager ptr) as gchar ptr
declare sub gtk_ui_manager_ensure_update(byval manager as GtkUIManager ptr)
declare function gtk_ui_manager_new_merge_id(byval manager as GtkUIManager ptr) as guint

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
type GtkAboutDialog_autoptr as GtkAboutDialog ptr

private sub glib_autoptr_cleanup_GtkAboutDialog(byval _ptr as GtkAboutDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAccelGroup_autoptr as GtkAccelGroup ptr

private sub glib_autoptr_cleanup_GtkAccelGroup(byval _ptr as GtkAccelGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAccelLabel_autoptr as GtkAccelLabel ptr

private sub glib_autoptr_cleanup_GtkAccelLabel(byval _ptr as GtkAccelLabel ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAccelMap_autoptr as GtkAccelMap ptr

private sub glib_autoptr_cleanup_GtkAccelMap(byval _ptr as GtkAccelMap ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAccessible_autoptr as GtkAccessible ptr

private sub glib_autoptr_cleanup_GtkAccessible(byval _ptr as GtkAccessible ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkActionBar_autoptr as GtkActionBar ptr

private sub glib_autoptr_cleanup_GtkActionBar(byval _ptr as GtkActionBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkActionable_autoptr as GtkActionable ptr

private sub glib_autoptr_cleanup_GtkActionable(byval _ptr as GtkActionable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAdjustment_autoptr as GtkAdjustment ptr

private sub glib_autoptr_cleanup_GtkAdjustment(byval _ptr as GtkAdjustment ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAppChooser_autoptr as GtkAppChooser ptr

private sub glib_autoptr_cleanup_GtkAppChooser(byval _ptr as GtkAppChooser ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAppChooserButton_autoptr as GtkAppChooserButton ptr

private sub glib_autoptr_cleanup_GtkAppChooserButton(byval _ptr as GtkAppChooserButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAppChooserDialog_autoptr as GtkAppChooserDialog ptr

private sub glib_autoptr_cleanup_GtkAppChooserDialog(byval _ptr as GtkAppChooserDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAppChooserWidget_autoptr as GtkAppChooserWidget ptr

private sub glib_autoptr_cleanup_GtkAppChooserWidget(byval _ptr as GtkAppChooserWidget ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkApplication_autoptr as GtkApplication ptr

private sub glib_autoptr_cleanup_GtkApplication(byval _ptr as GtkApplication ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkApplicationWindow_autoptr as GtkApplicationWindow ptr

private sub glib_autoptr_cleanup_GtkApplicationWindow(byval _ptr as GtkApplicationWindow ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAspectFrame_autoptr as GtkAspectFrame ptr

private sub glib_autoptr_cleanup_GtkAspectFrame(byval _ptr as GtkAspectFrame ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkAssistant_autoptr as GtkAssistant ptr

private sub glib_autoptr_cleanup_GtkAssistant(byval _ptr as GtkAssistant ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkBin_autoptr as GtkBin ptr

private sub glib_autoptr_cleanup_GtkBin(byval _ptr as GtkBin ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkBox_autoptr as GtkBox ptr

private sub glib_autoptr_cleanup_GtkBox(byval _ptr as GtkBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkBuildable_autoptr as GtkBuildable ptr

private sub glib_autoptr_cleanup_GtkBuildable(byval _ptr as GtkBuildable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkBuilder_autoptr as GtkBuilder ptr

private sub glib_autoptr_cleanup_GtkBuilder(byval _ptr as GtkBuilder ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkButton_autoptr as GtkButton ptr

private sub glib_autoptr_cleanup_GtkButton(byval _ptr as GtkButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkButtonBox_autoptr as GtkButtonBox ptr

private sub glib_autoptr_cleanup_GtkButtonBox(byval _ptr as GtkButtonBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCalendar_autoptr as GtkCalendar ptr

private sub glib_autoptr_cleanup_GtkCalendar(byval _ptr as GtkCalendar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellArea_autoptr as GtkCellArea ptr

private sub glib_autoptr_cleanup_GtkCellArea(byval _ptr as GtkCellArea ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellAreaBox_autoptr as GtkCellAreaBox ptr

private sub glib_autoptr_cleanup_GtkCellAreaBox(byval _ptr as GtkCellAreaBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellAreaContext_autoptr as GtkCellAreaContext ptr

private sub glib_autoptr_cleanup_GtkCellAreaContext(byval _ptr as GtkCellAreaContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellEditable_autoptr as GtkCellEditable ptr

private sub glib_autoptr_cleanup_GtkCellEditable(byval _ptr as GtkCellEditable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellLayout_autoptr as GtkCellLayout ptr

private sub glib_autoptr_cleanup_GtkCellLayout(byval _ptr as GtkCellLayout ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRenderer_autoptr as GtkCellRenderer ptr

private sub glib_autoptr_cleanup_GtkCellRenderer(byval _ptr as GtkCellRenderer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererAccel_autoptr as GtkCellRendererAccel ptr

private sub glib_autoptr_cleanup_GtkCellRendererAccel(byval _ptr as GtkCellRendererAccel ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererCombo_autoptr as GtkCellRendererCombo ptr

private sub glib_autoptr_cleanup_GtkCellRendererCombo(byval _ptr as GtkCellRendererCombo ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererPixbuf_autoptr as GtkCellRendererPixbuf ptr

private sub glib_autoptr_cleanup_GtkCellRendererPixbuf(byval _ptr as GtkCellRendererPixbuf ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererProgress_autoptr as GtkCellRendererProgress ptr

private sub glib_autoptr_cleanup_GtkCellRendererProgress(byval _ptr as GtkCellRendererProgress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererSpin_autoptr as GtkCellRendererSpin ptr

private sub glib_autoptr_cleanup_GtkCellRendererSpin(byval _ptr as GtkCellRendererSpin ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererSpinner_autoptr as GtkCellRendererSpinner ptr

private sub glib_autoptr_cleanup_GtkCellRendererSpinner(byval _ptr as GtkCellRendererSpinner ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererText_autoptr as GtkCellRendererText ptr

private sub glib_autoptr_cleanup_GtkCellRendererText(byval _ptr as GtkCellRendererText ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellRendererToggle_autoptr as GtkCellRendererToggle ptr

private sub glib_autoptr_cleanup_GtkCellRendererToggle(byval _ptr as GtkCellRendererToggle ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCellView_autoptr as GtkCellView ptr

private sub glib_autoptr_cleanup_GtkCellView(byval _ptr as GtkCellView ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCheckButton_autoptr as GtkCheckButton ptr

private sub glib_autoptr_cleanup_GtkCheckButton(byval _ptr as GtkCheckButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCheckMenuItem_autoptr as GtkCheckMenuItem ptr

private sub glib_autoptr_cleanup_GtkCheckMenuItem(byval _ptr as GtkCheckMenuItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkClipboard_autoptr as GtkClipboard ptr

private sub glib_autoptr_cleanup_GtkClipboard(byval _ptr as GtkClipboard ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkColorButton_autoptr as GtkColorButton ptr

private sub glib_autoptr_cleanup_GtkColorButton(byval _ptr as GtkColorButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkColorChooser_autoptr as GtkColorChooser ptr

private sub glib_autoptr_cleanup_GtkColorChooser(byval _ptr as GtkColorChooser ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkColorChooserDialog_autoptr as GtkColorChooserDialog ptr

private sub glib_autoptr_cleanup_GtkColorChooserDialog(byval _ptr as GtkColorChooserDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkColorChooserWidget_autoptr as GtkColorChooserWidget ptr

private sub glib_autoptr_cleanup_GtkColorChooserWidget(byval _ptr as GtkColorChooserWidget ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkComboBox_autoptr as GtkComboBox ptr

private sub glib_autoptr_cleanup_GtkComboBox(byval _ptr as GtkComboBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkComboBoxText_autoptr as GtkComboBoxText ptr

private sub glib_autoptr_cleanup_GtkComboBoxText(byval _ptr as GtkComboBoxText ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkContainer_autoptr as GtkContainer ptr

private sub glib_autoptr_cleanup_GtkContainer(byval _ptr as GtkContainer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkCssProvider_autoptr as GtkCssProvider ptr

private sub glib_autoptr_cleanup_GtkCssProvider(byval _ptr as GtkCssProvider ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkDialog_autoptr as GtkDialog ptr

private sub glib_autoptr_cleanup_GtkDialog(byval _ptr as GtkDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkDrawingArea_autoptr as GtkDrawingArea ptr

private sub glib_autoptr_cleanup_GtkDrawingArea(byval _ptr as GtkDrawingArea ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkEditable_autoptr as GtkEditable ptr

private sub glib_autoptr_cleanup_GtkEditable(byval _ptr as GtkEditable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkEntry_autoptr as GtkEntry ptr

private sub glib_autoptr_cleanup_GtkEntry(byval _ptr as GtkEntry ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkEntryBuffer_autoptr as GtkEntryBuffer ptr

private sub glib_autoptr_cleanup_GtkEntryBuffer(byval _ptr as GtkEntryBuffer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkEntryCompletion_autoptr as GtkEntryCompletion ptr

private sub glib_autoptr_cleanup_GtkEntryCompletion(byval _ptr as GtkEntryCompletion ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkEventBox_autoptr as GtkEventBox ptr

private sub glib_autoptr_cleanup_GtkEventBox(byval _ptr as GtkEventBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkEventController_autoptr as GtkEventController ptr

private sub glib_autoptr_cleanup_GtkEventController(byval _ptr as GtkEventController ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkExpander_autoptr as GtkExpander ptr

private sub glib_autoptr_cleanup_GtkExpander(byval _ptr as GtkExpander ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFileChooserButton_autoptr as GtkFileChooserButton ptr

private sub glib_autoptr_cleanup_GtkFileChooserButton(byval _ptr as GtkFileChooserButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFileChooserDialog_autoptr as GtkFileChooserDialog ptr

private sub glib_autoptr_cleanup_GtkFileChooserDialog(byval _ptr as GtkFileChooserDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFileChooserWidget_autoptr as GtkFileChooserWidget ptr

private sub glib_autoptr_cleanup_GtkFileChooserWidget(byval _ptr as GtkFileChooserWidget ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFileFilter_autoptr as GtkFileFilter ptr

private sub glib_autoptr_cleanup_GtkFileFilter(byval _ptr as GtkFileFilter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFixed_autoptr as GtkFixed ptr

private sub glib_autoptr_cleanup_GtkFixed(byval _ptr as GtkFixed ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFlowBox_autoptr as GtkFlowBox ptr

private sub glib_autoptr_cleanup_GtkFlowBox(byval _ptr as GtkFlowBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFlowBoxChild_autoptr as GtkFlowBoxChild ptr

private sub glib_autoptr_cleanup_GtkFlowBoxChild(byval _ptr as GtkFlowBoxChild ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFontButton_autoptr as GtkFontButton ptr

private sub glib_autoptr_cleanup_GtkFontButton(byval _ptr as GtkFontButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFontChooser_autoptr as GtkFontChooser ptr

private sub glib_autoptr_cleanup_GtkFontChooser(byval _ptr as GtkFontChooser ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFontChooserDialog_autoptr as GtkFontChooserDialog ptr

private sub glib_autoptr_cleanup_GtkFontChooserDialog(byval _ptr as GtkFontChooserDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFontChooserWidget_autoptr as GtkFontChooserWidget ptr

private sub glib_autoptr_cleanup_GtkFontChooserWidget(byval _ptr as GtkFontChooserWidget ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkFrame_autoptr as GtkFrame ptr

private sub glib_autoptr_cleanup_GtkFrame(byval _ptr as GtkFrame ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGLArea_autoptr as GtkGLArea ptr

private sub glib_autoptr_cleanup_GtkGLArea(byval _ptr as GtkGLArea ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGesture_autoptr as GtkGesture ptr

private sub glib_autoptr_cleanup_GtkGesture(byval _ptr as GtkGesture ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureDrag_autoptr as GtkGestureDrag ptr

private sub glib_autoptr_cleanup_GtkGestureDrag(byval _ptr as GtkGestureDrag ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureLongPress_autoptr as GtkGestureLongPress ptr

private sub glib_autoptr_cleanup_GtkGestureLongPress(byval _ptr as GtkGestureLongPress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureMultiPress_autoptr as GtkGestureMultiPress ptr

private sub glib_autoptr_cleanup_GtkGestureMultiPress(byval _ptr as GtkGestureMultiPress ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGesturePan_autoptr as GtkGesturePan ptr

private sub glib_autoptr_cleanup_GtkGesturePan(byval _ptr as GtkGesturePan ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureRotate_autoptr as GtkGestureRotate ptr

private sub glib_autoptr_cleanup_GtkGestureRotate(byval _ptr as GtkGestureRotate ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureSingle_autoptr as GtkGestureSingle ptr

private sub glib_autoptr_cleanup_GtkGestureSingle(byval _ptr as GtkGestureSingle ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureSwipe_autoptr as GtkGestureSwipe ptr

private sub glib_autoptr_cleanup_GtkGestureSwipe(byval _ptr as GtkGestureSwipe ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGestureZoom_autoptr as GtkGestureZoom ptr

private sub glib_autoptr_cleanup_GtkGestureZoom(byval _ptr as GtkGestureZoom ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkGrid_autoptr as GtkGrid ptr

private sub glib_autoptr_cleanup_GtkGrid(byval _ptr as GtkGrid ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkHeaderBar_autoptr as GtkHeaderBar ptr

private sub glib_autoptr_cleanup_GtkHeaderBar(byval _ptr as GtkHeaderBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkIMContext_autoptr as GtkIMContext ptr

private sub glib_autoptr_cleanup_GtkIMContext(byval _ptr as GtkIMContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkIMContextSimple_autoptr as GtkIMContextSimple ptr

private sub glib_autoptr_cleanup_GtkIMContextSimple(byval _ptr as GtkIMContextSimple ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkIMMulticontext_autoptr as GtkIMMulticontext ptr

private sub glib_autoptr_cleanup_GtkIMMulticontext(byval _ptr as GtkIMMulticontext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkIconInfo_autoptr as GtkIconInfo ptr

private sub glib_autoptr_cleanup_GtkIconInfo(byval _ptr as GtkIconInfo ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkIconTheme_autoptr as GtkIconTheme ptr

private sub glib_autoptr_cleanup_GtkIconTheme(byval _ptr as GtkIconTheme ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkIconView_autoptr as GtkIconView ptr

private sub glib_autoptr_cleanup_GtkIconView(byval _ptr as GtkIconView ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkImage_autoptr as GtkImage ptr

private sub glib_autoptr_cleanup_GtkImage(byval _ptr as GtkImage ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkInfoBar_autoptr as GtkInfoBar ptr

private sub glib_autoptr_cleanup_GtkInfoBar(byval _ptr as GtkInfoBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkInvisible_autoptr as GtkInvisible ptr

private sub glib_autoptr_cleanup_GtkInvisible(byval _ptr as GtkInvisible ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkLabel_autoptr as GtkLabel ptr

private sub glib_autoptr_cleanup_GtkLabel(byval _ptr as GtkLabel ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkLayout_autoptr as GtkLayout ptr

private sub glib_autoptr_cleanup_GtkLayout(byval _ptr as GtkLayout ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkLevelBar_autoptr as GtkLevelBar ptr

private sub glib_autoptr_cleanup_GtkLevelBar(byval _ptr as GtkLevelBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkLinkButton_autoptr as GtkLinkButton ptr

private sub glib_autoptr_cleanup_GtkLinkButton(byval _ptr as GtkLinkButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkListBox_autoptr as GtkListBox ptr

private sub glib_autoptr_cleanup_GtkListBox(byval _ptr as GtkListBox ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkListBoxRow_autoptr as GtkListBoxRow ptr

private sub glib_autoptr_cleanup_GtkListBoxRow(byval _ptr as GtkListBoxRow ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkListStore_autoptr as GtkListStore ptr

private sub glib_autoptr_cleanup_GtkListStore(byval _ptr as GtkListStore ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkLockButton_autoptr as GtkLockButton ptr

private sub glib_autoptr_cleanup_GtkLockButton(byval _ptr as GtkLockButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMenu_autoptr as GtkMenu ptr

private sub glib_autoptr_cleanup_GtkMenu(byval _ptr as GtkMenu ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMenuBar_autoptr as GtkMenuBar ptr

private sub glib_autoptr_cleanup_GtkMenuBar(byval _ptr as GtkMenuBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMenuButton_autoptr as GtkMenuButton ptr

private sub glib_autoptr_cleanup_GtkMenuButton(byval _ptr as GtkMenuButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMenuItem_autoptr as GtkMenuItem ptr

private sub glib_autoptr_cleanup_GtkMenuItem(byval _ptr as GtkMenuItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMenuShell_autoptr as GtkMenuShell ptr

private sub glib_autoptr_cleanup_GtkMenuShell(byval _ptr as GtkMenuShell ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMenuToolButton_autoptr as GtkMenuToolButton ptr

private sub glib_autoptr_cleanup_GtkMenuToolButton(byval _ptr as GtkMenuToolButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMessageDialog_autoptr as GtkMessageDialog ptr

private sub glib_autoptr_cleanup_GtkMessageDialog(byval _ptr as GtkMessageDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkMountOperation_autoptr as GtkMountOperation ptr

private sub glib_autoptr_cleanup_GtkMountOperation(byval _ptr as GtkMountOperation ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkNotebook_autoptr as GtkNotebook ptr

private sub glib_autoptr_cleanup_GtkNotebook(byval _ptr as GtkNotebook ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkOffscreenWindow_autoptr as GtkOffscreenWindow ptr

private sub glib_autoptr_cleanup_GtkOffscreenWindow(byval _ptr as GtkOffscreenWindow ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkOrientable_autoptr as GtkOrientable ptr

private sub glib_autoptr_cleanup_GtkOrientable(byval _ptr as GtkOrientable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkOverlay_autoptr as GtkOverlay ptr

private sub glib_autoptr_cleanup_GtkOverlay(byval _ptr as GtkOverlay ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPageSetup_autoptr as GtkPageSetup ptr

private sub glib_autoptr_cleanup_GtkPageSetup(byval _ptr as GtkPageSetup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPaned_autoptr as GtkPaned ptr

private sub glib_autoptr_cleanup_GtkPaned(byval _ptr as GtkPaned ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPlacesSidebar_autoptr as GtkPlacesSidebar ptr

private sub glib_autoptr_cleanup_GtkPlacesSidebar(byval _ptr as GtkPlacesSidebar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPopover_autoptr as GtkPopover ptr

private sub glib_autoptr_cleanup_GtkPopover(byval _ptr as GtkPopover ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPopoverMenu_autoptr as GtkPopoverMenu ptr

private sub glib_autoptr_cleanup_GtkPopoverMenu(byval _ptr as GtkPopoverMenu ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPrintContext_autoptr as GtkPrintContext ptr

private sub glib_autoptr_cleanup_GtkPrintContext(byval _ptr as GtkPrintContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPrintOperation_autoptr as GtkPrintOperation ptr

private sub glib_autoptr_cleanup_GtkPrintOperation(byval _ptr as GtkPrintOperation ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPrintOperationPreview_autoptr as GtkPrintOperationPreview ptr

private sub glib_autoptr_cleanup_GtkPrintOperationPreview(byval _ptr as GtkPrintOperationPreview ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkPrintSettings_autoptr as GtkPrintSettings ptr

private sub glib_autoptr_cleanup_GtkPrintSettings(byval _ptr as GtkPrintSettings ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkProgressBar_autoptr as GtkProgressBar ptr

private sub glib_autoptr_cleanup_GtkProgressBar(byval _ptr as GtkProgressBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRadioButton_autoptr as GtkRadioButton ptr

private sub glib_autoptr_cleanup_GtkRadioButton(byval _ptr as GtkRadioButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRadioMenuItem_autoptr as GtkRadioMenuItem ptr

private sub glib_autoptr_cleanup_GtkRadioMenuItem(byval _ptr as GtkRadioMenuItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRadioToolButton_autoptr as GtkRadioToolButton ptr

private sub glib_autoptr_cleanup_GtkRadioToolButton(byval _ptr as GtkRadioToolButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRange_autoptr as GtkRange ptr

private sub glib_autoptr_cleanup_GtkRange(byval _ptr as GtkRange ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRcStyle_autoptr as GtkRcStyle ptr

private sub glib_autoptr_cleanup_GtkRcStyle(byval _ptr as GtkRcStyle ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRecentChooser_autoptr as GtkRecentChooser ptr

private sub glib_autoptr_cleanup_GtkRecentChooser(byval _ptr as GtkRecentChooser ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRecentChooserDialog_autoptr as GtkRecentChooserDialog ptr

private sub glib_autoptr_cleanup_GtkRecentChooserDialog(byval _ptr as GtkRecentChooserDialog ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRecentChooserMenu_autoptr as GtkRecentChooserMenu ptr

private sub glib_autoptr_cleanup_GtkRecentChooserMenu(byval _ptr as GtkRecentChooserMenu ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRecentChooserWidget_autoptr as GtkRecentChooserWidget ptr

private sub glib_autoptr_cleanup_GtkRecentChooserWidget(byval _ptr as GtkRecentChooserWidget ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRecentFilter_autoptr as GtkRecentFilter ptr

private sub glib_autoptr_cleanup_GtkRecentFilter(byval _ptr as GtkRecentFilter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRecentManager_autoptr as GtkRecentManager ptr

private sub glib_autoptr_cleanup_GtkRecentManager(byval _ptr as GtkRecentManager ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkRevealer_autoptr as GtkRevealer ptr

private sub glib_autoptr_cleanup_GtkRevealer(byval _ptr as GtkRevealer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkScale_autoptr as GtkScale ptr

private sub glib_autoptr_cleanup_GtkScale(byval _ptr as GtkScale ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkScaleButton_autoptr as GtkScaleButton ptr

private sub glib_autoptr_cleanup_GtkScaleButton(byval _ptr as GtkScaleButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkScrollable_autoptr as GtkScrollable ptr

private sub glib_autoptr_cleanup_GtkScrollable(byval _ptr as GtkScrollable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkScrollbar_autoptr as GtkScrollbar ptr

private sub glib_autoptr_cleanup_GtkScrollbar(byval _ptr as GtkScrollbar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkScrolledWindow_autoptr as GtkScrolledWindow ptr

private sub glib_autoptr_cleanup_GtkScrolledWindow(byval _ptr as GtkScrolledWindow ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSearchBar_autoptr as GtkSearchBar ptr

private sub glib_autoptr_cleanup_GtkSearchBar(byval _ptr as GtkSearchBar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSearchEntry_autoptr as GtkSearchEntry ptr

private sub glib_autoptr_cleanup_GtkSearchEntry(byval _ptr as GtkSearchEntry ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSeparator_autoptr as GtkSeparator ptr

private sub glib_autoptr_cleanup_GtkSeparator(byval _ptr as GtkSeparator ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSeparatorMenuItem_autoptr as GtkSeparatorMenuItem ptr

private sub glib_autoptr_cleanup_GtkSeparatorMenuItem(byval _ptr as GtkSeparatorMenuItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSeparatorToolItem_autoptr as GtkSeparatorToolItem ptr

private sub glib_autoptr_cleanup_GtkSeparatorToolItem(byval _ptr as GtkSeparatorToolItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSettings_autoptr as GtkSettings ptr

private sub glib_autoptr_cleanup_GtkSettings(byval _ptr as GtkSettings ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStackSidebar_autoptr as GtkStackSidebar ptr

private sub glib_autoptr_cleanup_GtkStackSidebar(byval _ptr as GtkStackSidebar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSizeGroup_autoptr as GtkSizeGroup ptr

private sub glib_autoptr_cleanup_GtkSizeGroup(byval _ptr as GtkSizeGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSpinButton_autoptr as GtkSpinButton ptr

private sub glib_autoptr_cleanup_GtkSpinButton(byval _ptr as GtkSpinButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSpinner_autoptr as GtkSpinner ptr

private sub glib_autoptr_cleanup_GtkSpinner(byval _ptr as GtkSpinner ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStack_autoptr as GtkStack ptr

private sub glib_autoptr_cleanup_GtkStack(byval _ptr as GtkStack ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStackSwitcher_autoptr as GtkStackSwitcher ptr

private sub glib_autoptr_cleanup_GtkStackSwitcher(byval _ptr as GtkStackSwitcher ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStatusbar_autoptr as GtkStatusbar ptr

private sub glib_autoptr_cleanup_GtkStatusbar(byval _ptr as GtkStatusbar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStyle_autoptr as GtkStyle ptr

private sub glib_autoptr_cleanup_GtkStyle(byval _ptr as GtkStyle ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStyleContext_autoptr as GtkStyleContext ptr

private sub glib_autoptr_cleanup_GtkStyleContext(byval _ptr as GtkStyleContext ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStyleProperties_autoptr as GtkStyleProperties ptr

private sub glib_autoptr_cleanup_GtkStyleProperties(byval _ptr as GtkStyleProperties ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkStyleProvider_autoptr as GtkStyleProvider ptr

private sub glib_autoptr_cleanup_GtkStyleProvider(byval _ptr as GtkStyleProvider ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkSwitch_autoptr as GtkSwitch ptr

private sub glib_autoptr_cleanup_GtkSwitch(byval _ptr as GtkSwitch ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTextBuffer_autoptr as GtkTextBuffer ptr

private sub glib_autoptr_cleanup_GtkTextBuffer(byval _ptr as GtkTextBuffer ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTextChildAnchor_autoptr as GtkTextChildAnchor ptr

private sub glib_autoptr_cleanup_GtkTextChildAnchor(byval _ptr as GtkTextChildAnchor ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTextMark_autoptr as GtkTextMark ptr

private sub glib_autoptr_cleanup_GtkTextMark(byval _ptr as GtkTextMark ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTextTag_autoptr as GtkTextTag ptr

private sub glib_autoptr_cleanup_GtkTextTag(byval _ptr as GtkTextTag ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTextTagTable_autoptr as GtkTextTagTable ptr

private sub glib_autoptr_cleanup_GtkTextTagTable(byval _ptr as GtkTextTagTable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTextView_autoptr as GtkTextView ptr

private sub glib_autoptr_cleanup_GtkTextView(byval _ptr as GtkTextView ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToggleButton_autoptr as GtkToggleButton ptr

private sub glib_autoptr_cleanup_GtkToggleButton(byval _ptr as GtkToggleButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToggleToolButton_autoptr as GtkToggleToolButton ptr

private sub glib_autoptr_cleanup_GtkToggleToolButton(byval _ptr as GtkToggleToolButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToolButton_autoptr as GtkToolButton ptr

private sub glib_autoptr_cleanup_GtkToolButton(byval _ptr as GtkToolButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToolItem_autoptr as GtkToolItem ptr

private sub glib_autoptr_cleanup_GtkToolItem(byval _ptr as GtkToolItem ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToolItemGroup_autoptr as GtkToolItemGroup ptr

private sub glib_autoptr_cleanup_GtkToolItemGroup(byval _ptr as GtkToolItemGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToolPalette_autoptr as GtkToolPalette ptr

private sub glib_autoptr_cleanup_GtkToolPalette(byval _ptr as GtkToolPalette ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToolShell_autoptr as GtkToolShell ptr

private sub glib_autoptr_cleanup_GtkToolShell(byval _ptr as GtkToolShell ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkToolbar_autoptr as GtkToolbar ptr

private sub glib_autoptr_cleanup_GtkToolbar(byval _ptr as GtkToolbar ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTooltip_autoptr as GtkTooltip ptr

private sub glib_autoptr_cleanup_GtkTooltip(byval _ptr as GtkTooltip ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeDragDest_autoptr as GtkTreeDragDest ptr

private sub glib_autoptr_cleanup_GtkTreeDragDest(byval _ptr as GtkTreeDragDest ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeDragSource_autoptr as GtkTreeDragSource ptr

private sub glib_autoptr_cleanup_GtkTreeDragSource(byval _ptr as GtkTreeDragSource ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeModel_autoptr as GtkTreeModel ptr

private sub glib_autoptr_cleanup_GtkTreeModel(byval _ptr as GtkTreeModel ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeModelFilter_autoptr as GtkTreeModelFilter ptr

private sub glib_autoptr_cleanup_GtkTreeModelFilter(byval _ptr as GtkTreeModelFilter ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeModelSort_autoptr as GtkTreeModelSort ptr

private sub glib_autoptr_cleanup_GtkTreeModelSort(byval _ptr as GtkTreeModelSort ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeSelection_autoptr as GtkTreeSelection ptr

private sub glib_autoptr_cleanup_GtkTreeSelection(byval _ptr as GtkTreeSelection ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeSortable_autoptr as GtkTreeSortable ptr

private sub glib_autoptr_cleanup_GtkTreeSortable(byval _ptr as GtkTreeSortable ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeStore_autoptr as GtkTreeStore ptr

private sub glib_autoptr_cleanup_GtkTreeStore(byval _ptr as GtkTreeStore ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeView_autoptr as GtkTreeView ptr

private sub glib_autoptr_cleanup_GtkTreeView(byval _ptr as GtkTreeView ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkTreeViewColumn_autoptr as GtkTreeViewColumn ptr

private sub glib_autoptr_cleanup_GtkTreeViewColumn(byval _ptr as GtkTreeViewColumn ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkViewport_autoptr as GtkViewport ptr

private sub glib_autoptr_cleanup_GtkViewport(byval _ptr as GtkViewport ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkVolumeButton_autoptr as GtkVolumeButton ptr

private sub glib_autoptr_cleanup_GtkVolumeButton(byval _ptr as GtkVolumeButton ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkWidget_autoptr as GtkWidget ptr

private sub glib_autoptr_cleanup_GtkWidget(byval _ptr as GtkWidget ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkWindow_autoptr as GtkWindow ptr

private sub glib_autoptr_cleanup_GtkWindow(byval _ptr as GtkWindow ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkWindowGroup_autoptr as GtkWindowGroup ptr

private sub glib_autoptr_cleanup_GtkWindowGroup(byval _ptr as GtkWindowGroup ptr ptr)
	if *_ptr then
		g_object_unref(*_ptr)
	end if
end sub

type GtkBorder_autoptr as GtkBorder ptr

private sub glib_autoptr_cleanup_GtkBorder(byval _ptr as GtkBorder ptr ptr)
	if *_ptr then
		gtk_border_free(*_ptr)
	end if
end sub

type GtkPaperSize_autoptr as GtkPaperSize ptr

private sub glib_autoptr_cleanup_GtkPaperSize(byval _ptr as GtkPaperSize ptr ptr)
	if *_ptr then
		gtk_paper_size_free(*_ptr)
	end if
end sub

type GtkRequisition_autoptr as GtkRequisition ptr

private sub glib_autoptr_cleanup_GtkRequisition(byval _ptr as GtkRequisition ptr ptr)
	if *_ptr then
		gtk_requisition_free(*_ptr)
	end if
end sub

type GtkSelectionData_autoptr as GtkSelectionData ptr

private sub glib_autoptr_cleanup_GtkSelectionData(byval _ptr as GtkSelectionData ptr ptr)
	if *_ptr then
		gtk_selection_data_free(*_ptr)
	end if
end sub

type GtkTargetList_autoptr as GtkTargetList ptr

private sub glib_autoptr_cleanup_GtkTargetList(byval _ptr as GtkTargetList ptr ptr)
	if *_ptr then
		gtk_target_list_unref(*_ptr)
	end if
end sub

type GtkTextAttributes_autoptr as GtkTextAttributes ptr

private sub glib_autoptr_cleanup_GtkTextAttributes(byval _ptr as GtkTextAttributes ptr ptr)
	if *_ptr then
		gtk_text_attributes_unref(*_ptr)
	end if
end sub

type GtkTextIter_autoptr as GtkTextIter ptr

private sub glib_autoptr_cleanup_GtkTextIter(byval _ptr as GtkTextIter ptr ptr)
	if *_ptr then
		gtk_text_iter_free(*_ptr)
	end if
end sub

type GtkTreeIter_autoptr as GtkTreeIter ptr

private sub glib_autoptr_cleanup_GtkTreeIter(byval _ptr as GtkTreeIter ptr ptr)
	if *_ptr then
		gtk_tree_iter_free(*_ptr)
	end if
end sub

type GtkTreeRowReference_autoptr as GtkTreeRowReference ptr

private sub glib_autoptr_cleanup_GtkTreeRowReference(byval _ptr as GtkTreeRowReference ptr ptr)
	if *_ptr then
		gtk_tree_row_reference_free(*_ptr)
	end if
end sub

type GtkWidgetPath_autoptr as GtkWidgetPath ptr

private sub glib_autoptr_cleanup_GtkWidgetPath(byval _ptr as GtkWidgetPath ptr ptr)
	if *_ptr then
		gtk_widget_path_unref(*_ptr)
	end if
end sub

#undef __GTK_H_INSIDE__

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
