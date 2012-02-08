' This is file gtk.bi
' (FreeBasic binding for GTK - The GIMP Toolkit version 3.2.2)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
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
'/* GTK - The GIMP Toolkit
 '* Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General Public
 '* License along with this library; if not, write to the
 '* Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 '* Boston, MA 02111-1307, USA.
 '*/

'/*
 '* Modified by the GTK+ Team and others 1997-2000.  See the AUTHORS
 '* file for a list of people on the GTK+ Team.  See the ChangeLog
 '* files for a list of changes.  These files are distributed with
 '* GTK+ at ftp://ftp.gtk.org/pub/gtk/.
 '*/

#IF NOT __FB_MIN_VERSION__(0, 20, 0)
  #ERROR fbc version must NOT be less than 0.20.0 to compile this header
#ENDIF

#IFDEF __FB_WIN32__
 #PRAGMA push(msbitfields)
#ELSEIF NOT DEFINED(__FB_UNIX__)
 #ERROR "Platform not supported!"
#ENDIF
#INCLIB "gtk-3"

EXTERN "C"

#IFNDEF __GTK_H__
#DEFINE __GTK_H__
#DEFINE __GTK_H_INSIDE__
#INCLUDE ONCE "gdk/gdk-3.0.bi"

#IFNDEF __GTK_ABOUT_DIALOG_H__
#DEFINE __GTK_ABOUT_DIALOG_H__

#IFNDEF __GTK_DIALOG_H__
#DEFINE __GTK_DIALOG_H__

#IFNDEF __GTK_WINDOW_H__
#DEFINE __GTK_WINDOW_H__

#IFNDEF __GTK_APPLICATION_H__
#DEFINE __GTK_APPLICATION_H__

#IFNDEF __GTK_ACTION_GROUP_H__
#DEFINE __GTK_ACTION_GROUP_H__

#IFNDEF __GTK_ACTION_H__
#DEFINE __GTK_ACTION_H__

#IFNDEF __GTK_WIDGET_H__
#DEFINE __GTK_WIDGET_H__

#IFNDEF __GTK_ACCEL_GROUP_H__
#DEFINE __GTK_ACCEL_GROUP_H__

#IFNDEF __GTK_ENUMS_H__
#DEFINE __GTK_ENUMS_H__
#INCLUDE ONCE "glib-object.bi"

ENUM GtkAlign
  GTK_ALIGN_FILL
  GTK_ALIGN_START
  GTK_ALIGN_END
  GTK_ALIGN_CENTER
END ENUM

ENUM GtkArrowPlacement
  GTK_ARROWS_BOTH
  GTK_ARROWS_START
  GTK_ARROWS_END
END ENUM

ENUM GtkArrowType
  GTK_ARROW_UP
  GTK_ARROW_DOWN
  GTK_ARROW_LEFT
  GTK_ARROW_RIGHT
  GTK_ARROW_NONE
END ENUM

ENUM GtkAttachOptions
  GTK_EXPAND = 1 SHL 0
  GTK_SHRINK = 1 SHL 1
  GTK_FILL = 1 SHL 2
END ENUM

ENUM GtkButtonBoxStyle
  GTK_BUTTONBOX_SPREAD = 1
  GTK_BUTTONBOX_EDGE
  GTK_BUTTONBOX_START
  GTK_BUTTONBOX_END
  GTK_BUTTONBOX_CENTER
END ENUM

ENUM GtkDeleteType
  GTK_DELETE_CHARS
  GTK_DELETE_WORD_ENDS
  GTK_DELETE_WORDS
  GTK_DELETE_DISPLAY_LINES
  GTK_DELETE_DISPLAY_LINE_ENDS
  GTK_DELETE_PARAGRAPH_ENDS
  GTK_DELETE_PARAGRAPHS
  GTK_DELETE_WHITESPACE
END ENUM

ENUM GtkDirectionType
  GTK_DIR_TAB_FORWARD
  GTK_DIR_TAB_BACKWARD
  GTK_DIR_UP
  GTK_DIR_DOWN
  GTK_DIR_LEFT
  GTK_DIR_RIGHT
END ENUM

ENUM GtkExpanderStyle
  GTK_EXPANDER_COLLAPSED
  GTK_EXPANDER_SEMI_COLLAPSED
  GTK_EXPANDER_SEMI_EXPANDED
  GTK_EXPANDER_EXPANDED
END ENUM

ENUM GtkIconSize
  GTK_ICON_SIZE_INVALID
  GTK_ICON_SIZE_MENU
  GTK_ICON_SIZE_SMALL_TOOLBAR
  GTK_ICON_SIZE_LARGE_TOOLBAR
  GTK_ICON_SIZE_BUTTON
  GTK_ICON_SIZE_DND
  GTK_ICON_SIZE_DIALOG
END ENUM

ENUM GtkSensitivityType
  GTK_SENSITIVITY_AUTO
  GTK_SENSITIVITY_ON
  GTK_SENSITIVITY_OFF
END ENUM

ENUM GtkTextDirection
  GTK_TEXT_DIR_NONE
  GTK_TEXT_DIR_LTR
  GTK_TEXT_DIR_RTL
END ENUM

ENUM GtkJustification
  GTK_JUSTIFY_LEFT
  GTK_JUSTIFY_RIGHT
  GTK_JUSTIFY_CENTER
  GTK_JUSTIFY_FILL
END ENUM

ENUM GtkMenuDirectionType
  GTK_MENU_DIR_PARENT
  GTK_MENU_DIR_CHILD
  GTK_MENU_DIR_NEXT
  GTK_MENU_DIR_PREV
END ENUM

ENUM GtkMessageType
  GTK_MESSAGE_INFO
  GTK_MESSAGE_WARNING
  GTK_MESSAGE_QUESTION
  GTK_MESSAGE_ERROR
  GTK_MESSAGE_OTHER
END ENUM

ENUM GtkMovementStep
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
END ENUM

ENUM GtkScrollStep
  GTK_SCROLL_STEPS
  GTK_SCROLL_PAGES
  GTK_SCROLL_ENDS
  GTK_SCROLL_HORIZONTAL_STEPS
  GTK_SCROLL_HORIZONTAL_PAGES
  GTK_SCROLL_HORIZONTAL_ENDS
END ENUM

ENUM GtkOrientation
  GTK_ORIENTATION_HORIZONTAL
  GTK_ORIENTATION_VERTICAL
END ENUM

ENUM GtkCornerType
  GTK_CORNER_TOP_LEFT
  GTK_CORNER_BOTTOM_LEFT
  GTK_CORNER_TOP_RIGHT
  GTK_CORNER_BOTTOM_RIGHT
END ENUM

ENUM GtkPackType
  GTK_PACK_START
  GTK_PACK_END
END ENUM

ENUM GtkPathPriorityType
  GTK_PATH_PRIO_LOWEST = 0
  GTK_PATH_PRIO_GTK = 4
  GTK_PATH_PRIO_APPLICATION = 8
  GTK_PATH_PRIO_THEME = 10
  GTK_PATH_PRIO_RC = 12
  GTK_PATH_PRIO_HIGHEST = 15
END ENUM

#DEFINE GTK_PATH_PRIO_MASK &h0F

ENUM GtkPathType
  GTK_PATH_WIDGET
  GTK_PATH_WIDGET_CLASS
  GTK_PATH_CLASS
END ENUM

ENUM GtkPolicyType
  GTK_POLICY_ALWAYS
  GTK_POLICY_AUTOMATIC
  GTK_POLICY_NEVER
END ENUM

ENUM GtkPositionType
  GTK_POS_LEFT
  GTK_POS_RIGHT
  GTK_POS_TOP
  GTK_POS_BOTTOM
END ENUM

ENUM GtkReliefStyle
  GTK_RELIEF_NORMAL
  GTK_RELIEF_HALF
  GTK_RELIEF_NONE
END ENUM

ENUM GtkResizeMode
  GTK_RESIZE_PARENT
  GTK_RESIZE_QUEUE
  GTK_RESIZE_IMMEDIATE
END ENUM

ENUM GtkScrollType
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
END ENUM

ENUM GtkSelectionMode
  GTK_SELECTION_NONE
  GTK_SELECTION_SINGLE
  GTK_SELECTION_BROWSE
  GTK_SELECTION_MULTIPLE
END ENUM

ENUM GtkShadowType
  GTK_SHADOW_NONE
  GTK_SHADOW_IN
  GTK_SHADOW_OUT
  GTK_SHADOW_ETCHED_IN
  GTK_SHADOW_ETCHED_OUT
END ENUM

ENUM GtkStateType
  GTK_STATE_NORMAL
  GTK_STATE_ACTIVE
  GTK_STATE_PRELIGHT
  GTK_STATE_SELECTED
  GTK_STATE_INSENSITIVE
  GTK_STATE_INCONSISTENT
  GTK_STATE_FOCUSED
END ENUM

ENUM GtkToolbarStyle
  GTK_TOOLBAR_ICONS
  GTK_TOOLBAR_TEXT
  GTK_TOOLBAR_BOTH
  GTK_TOOLBAR_BOTH_HORIZ
END ENUM

ENUM GtkWindowPosition
  GTK_WIN_POS_NONE
  GTK_WIN_POS_CENTER
  GTK_WIN_POS_MOUSE
  GTK_WIN_POS_CENTER_ALWAYS
  GTK_WIN_POS_CENTER_ON_PARENT
END ENUM

ENUM GtkWindowType
  GTK_WINDOW_TOPLEVEL
  GTK_WINDOW_POPUP
END ENUM

ENUM GtkWrapMode
  GTK_WRAP_NONE
  GTK_WRAP_CHAR
  GTK_WRAP_WORD
  GTK_WRAP_WORD_CHAR
END ENUM

ENUM GtkSortType
  GTK_SORT_ASCENDING
  GTK_SORT_DESCENDING
END ENUM

ENUM GtkIMPreeditStyle
  GTK_IM_PREEDIT_NOTHING
  GTK_IM_PREEDIT_CALLBACK
  GTK_IM_PREEDIT_NONE
END ENUM

ENUM GtkIMStatusStyle
  GTK_IM_STATUS_NOTHING
  GTK_IM_STATUS_CALLBACK
  GTK_IM_STATUS_NONE
END ENUM

ENUM GtkPackDirection
  GTK_PACK_DIRECTION_LTR
  GTK_PACK_DIRECTION_RTL
  GTK_PACK_DIRECTION_TTB
  GTK_PACK_DIRECTION_BTT
END ENUM

ENUM GtkPrintPages
  GTK_PRINT_PAGES_ALL
  GTK_PRINT_PAGES_CURRENT
  GTK_PRINT_PAGES_RANGES
  GTK_PRINT_PAGES_SELECTION
END ENUM

ENUM GtkPageSet
  GTK_PAGE_SET_ALL
  GTK_PAGE_SET_EVEN
  GTK_PAGE_SET_ODD
END ENUM

ENUM GtkNumberUpLayout
  GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_TOP_TO_BOTTOM
  GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_BOTTOM_TO_TOP
  GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_TOP_TO_BOTTOM
  GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_BOTTOM_TO_TOP
  GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_LEFT_TO_RIGHT
  GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_RIGHT_TO_LEFT
  GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_LEFT_TO_RIGHT
  GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_RIGHT_TO_LEFT
END ENUM

ENUM GtkPageOrientation
  GTK_PAGE_ORIENTATION_PORTRAIT
  GTK_PAGE_ORIENTATION_LANDSCAPE
  GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT
  GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE
END ENUM

ENUM GtkPrintQuality
  GTK_PRINT_QUALITY_LOW
  GTK_PRINT_QUALITY_NORMAL
  GTK_PRINT_QUALITY_HIGH
  GTK_PRINT_QUALITY_DRAFT
END ENUM

ENUM GtkPrintDuplex
  GTK_PRINT_DUPLEX_SIMPLEX
  GTK_PRINT_DUPLEX_HORIZONTAL
  GTK_PRINT_DUPLEX_VERTICAL
END ENUM

ENUM GtkUnit
  GTK_UNIT_PIXEL
  GTK_UNIT_POINTS
  GTK_UNIT_INCH
  GTK_UNIT_MM
END ENUM

ENUM GtkTreeViewGridLines
  GTK_TREE_VIEW_GRID_LINES_NONE
  GTK_TREE_VIEW_GRID_LINES_HORIZONTAL
  GTK_TREE_VIEW_GRID_LINES_VERTICAL
  GTK_TREE_VIEW_GRID_LINES_BOTH
END ENUM

ENUM GtkDragResult
  GTK_DRAG_RESULT_SUCCESS
  GTK_DRAG_RESULT_NO_TARGET
  GTK_DRAG_RESULT_USER_CANCELLED
  GTK_DRAG_RESULT_TIMEOUT_EXPIRED
  GTK_DRAG_RESULT_GRAB_BROKEN
  GTK_DRAG_RESULT_ERROR
END ENUM

ENUM GtkSizeRequestMode
  GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH = 0
  GTK_SIZE_REQUEST_WIDTH_FOR_HEIGHT
  GTK_SIZE_REQUEST_CONSTANT_SIZE
END ENUM

ENUM GtkScrollablePolicy
  GTK_SCROLL_MINIMUM = 0
  GTK_SCROLL_NATURAL
END ENUM

ENUM GtkStateFlags
  GTK_STATE_FLAG_NORMAL = 0
  GTK_STATE_FLAG_ACTIVE = 1 SHL 0
  GTK_STATE_FLAG_PRELIGHT = 1 SHL 1
  GTK_STATE_FLAG_SELECTED = 1 SHL 2
  GTK_STATE_FLAG_INSENSITIVE = 1 SHL 3
  GTK_STATE_FLAG_INCONSISTENT = 1 SHL 4
  GTK_STATE_FLAG_FOCUSED = 1 SHL 5
END ENUM

ENUM GtkRegionFlags
  GTK_REGION_EVEN = 1 SHL 0
  GTK_REGION_ODD = 1 SHL 1
  GTK_REGION_FIRST = 1 SHL 2
  GTK_REGION_LAST = 1 SHL 3
  GTK_REGION_SORTED = 1 SHL 5
END ENUM

ENUM GtkJunctionSides
  GTK_JUNCTION_NONE = 0
  GTK_JUNCTION_CORNER_TOPLEFT = 1 SHL 0
  GTK_JUNCTION_CORNER_TOPRIGHT = 1 SHL 1
  GTK_JUNCTION_CORNER_BOTTOMLEFT = 1 SHL 2
  GTK_JUNCTION_CORNER_BOTTOMRIGHT = 1 SHL 3
  GTK_JUNCTION_TOP = (GTK_JUNCTION_CORNER_TOPLEFT OR GTK_JUNCTION_CORNER_TOPRIGHT)
  GTK_JUNCTION_BOTTOM = (GTK_JUNCTION_CORNER_BOTTOMLEFT OR GTK_JUNCTION_CORNER_BOTTOMRIGHT)
  GTK_JUNCTION_LEFT = (GTK_JUNCTION_CORNER_TOPLEFT OR GTK_JUNCTION_CORNER_BOTTOMLEFT)
  GTK_JUNCTION_RIGHT = (GTK_JUNCTION_CORNER_TOPRIGHT OR GTK_JUNCTION_CORNER_BOTTOMRIGHT)
END ENUM

ENUM GtkBorderStyle
  GTK_BORDER_STYLE_NONE
  GTK_BORDER_STYLE_SOLID
  GTK_BORDER_STYLE_INSET
  GTK_BORDER_STYLE_OUTSET
END ENUM

#ENDIF ' __GTK_ENUMS_H__

#DEFINE GTK_TYPE_ACCEL_GROUP (gtk_accel_group_get_type ())
#DEFINE GTK_ACCEL_GROUP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ACCEL_GROUP, GtkAccelGroup))
#DEFINE GTK_ACCEL_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCEL_GROUP, GtkAccelGroupClass))
#DEFINE GTK_IS_ACCEL_GROUP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ACCEL_GROUP))
#DEFINE GTK_IS_ACCEL_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCEL_GROUP))
#DEFINE GTK_ACCEL_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCEL_GROUP, GtkAccelGroupClass))

ENUM GtkAccelFlags
  GTK_ACCEL_VISIBLE = 1 SHL 0
  GTK_ACCEL_LOCKED = 1 SHL 1
  GTK_ACCEL_MASK = &h07
END ENUM

TYPE GtkAccelGroup AS _GtkAccelGroup
TYPE GtkAccelGroupClass AS _GtkAccelGroupClass
TYPE GtkAccelGroupPrivate AS _GtkAccelGroupPrivate
TYPE GtkAccelKey AS _GtkAccelKey
TYPE GtkAccelGroupEntry AS _GtkAccelGroupEntry
TYPE GtkAccelGroupActivate AS FUNCTION(BYVAL AS GtkAccelGroup PTR, BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
TYPE GtkAccelGroupFindFunc AS FUNCTION(BYVAL AS GtkAccelKey PTR, BYVAL AS GClosure PTR, BYVAL AS gpointer) AS gboolean

TYPE _GtkAccelGroup
  AS GObject parent
  AS GtkAccelGroupPrivate PTR priv
END TYPE

TYPE _GtkAccelGroupClass
  AS GObjectClass parent_class
  accel_changed AS SUB(BYVAL AS GtkAccelGroup PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GClosure PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE _GtkAccelKey
  AS guint accel_key
  AS GdkModifierType accel_mods
  AS guint accel_flags : 16
END TYPE

DECLARE FUNCTION gtk_accel_group_get_type() AS GType
DECLARE FUNCTION gtk_accel_group_new() AS GtkAccelGroup PTR
DECLARE FUNCTION gtk_accel_group_get_is_locked(BYVAL AS GtkAccelGroup PTR) AS gboolean
DECLARE FUNCTION gtk_accel_group_get_modifier_mask(BYVAL AS GtkAccelGroup PTR) AS GdkModifierType
DECLARE SUB gtk_accel_group_lock(BYVAL AS GtkAccelGroup PTR)
DECLARE SUB gtk_accel_group_unlock(BYVAL AS GtkAccelGroup PTR)
DECLARE SUB gtk_accel_group_connect(BYVAL AS GtkAccelGroup PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GtkAccelFlags, BYVAL AS GClosure PTR)
DECLARE SUB gtk_accel_group_connect_by_path(BYVAL AS GtkAccelGroup PTR, BYVAL AS CONST gchar PTR, BYVAL AS GClosure PTR)
DECLARE FUNCTION gtk_accel_group_disconnect(BYVAL AS GtkAccelGroup PTR, BYVAL AS GClosure PTR) AS gboolean
DECLARE FUNCTION gtk_accel_group_disconnect_key(BYVAL AS GtkAccelGroup PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE FUNCTION gtk_accel_group_activate(BYVAL AS GtkAccelGroup PTR, BYVAL AS GQuark, BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE SUB _gtk_accel_group_attach(BYVAL AS GtkAccelGroup PTR, BYVAL AS GObject PTR)
DECLARE SUB _gtk_accel_group_detach(BYVAL AS GtkAccelGroup PTR, BYVAL AS GObject PTR)
DECLARE FUNCTION gtk_accel_groups_activate(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE FUNCTION gtk_accel_groups_from_object(BYVAL AS GObject PTR) AS GSList PTR
DECLARE FUNCTION gtk_accel_group_find(BYVAL AS GtkAccelGroup PTR, BYVAL AS GtkAccelGroupFindFunc, BYVAL AS gpointer) AS GtkAccelKey PTR
DECLARE FUNCTION gtk_accel_group_from_accel_closure(BYVAL AS GClosure PTR) AS GtkAccelGroup PTR
DECLARE FUNCTION gtk_accelerator_valid(BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE SUB gtk_accelerator_parse(BYVAL AS CONST gchar PTR, BYVAL AS guint PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gtk_accelerator_name(BYVAL AS guint, BYVAL AS GdkModifierType) AS gchar PTR
DECLARE FUNCTION gtk_accelerator_get_label(BYVAL AS guint, BYVAL AS GdkModifierType) AS gchar PTR
DECLARE SUB gtk_accelerator_set_default_mod_mask(BYVAL AS GdkModifierType)
DECLARE FUNCTION gtk_accelerator_get_default_mod_mask() AS GdkModifierType
DECLARE FUNCTION gtk_accel_group_query(BYVAL AS GtkAccelGroup PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS guint PTR) AS GtkAccelGroupEntry PTR
DECLARE SUB _gtk_accel_group_reconnect(BYVAL AS GtkAccelGroup PTR, BYVAL AS GQuark)
DECLARE FUNCTION _gtk_accel_group_get_accelerables(BYVAL AS GtkAccelGroup PTR) AS GSList PTR

TYPE _GtkAccelGroupEntry
  AS GtkAccelKey key
  AS GClosure PTR closure
  AS GQuark accel_path_quark
END TYPE

#ENDIF ' __GTK_ACCEL_GROUP_H__

#IFNDEF __GTK_ADJUSTMENT_H__
#DEFINE __GTK_ADJUSTMENT_H__

#DEFINE GTK_TYPE_ADJUSTMENT (gtk_adjustment_get_type ())
#DEFINE GTK_ADJUSTMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustment))
#DEFINE GTK_ADJUSTMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass))
#DEFINE GTK_IS_ADJUSTMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ADJUSTMENT))
#DEFINE GTK_IS_ADJUSTMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ADJUSTMENT))
#DEFINE GTK_ADJUSTMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass))

TYPE GtkAdjustment AS _GtkAdjustment
TYPE GtkAdjustmentPrivate AS _GtkAdjustmentPrivate
TYPE GtkAdjustmentClass AS _GtkAdjustmentClass

TYPE _GtkAdjustment
  AS GInitiallyUnowned parent_instance
  AS GtkAdjustmentPrivate PTR priv
END TYPE

TYPE _GtkAdjustmentClass
  AS GInitiallyUnownedClass parent_class
  changed AS SUB(BYVAL AS GtkAdjustment PTR)
  value_changed AS SUB(BYVAL AS GtkAdjustment PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_adjustment_get_type() AS GType
DECLARE FUNCTION gtk_adjustment_new(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkAdjustment PTR
DECLARE SUB gtk_adjustment_changed(BYVAL AS GtkAdjustment PTR)
DECLARE SUB gtk_adjustment_value_changed(BYVAL AS GtkAdjustment PTR)
DECLARE SUB gtk_adjustment_clamp_page(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_value(BYVAL AS GtkAdjustment PTR) AS gdouble
DECLARE SUB gtk_adjustment_set_value(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_lower(BYVAL AS GtkAdjustment PTR) AS gdouble
DECLARE SUB gtk_adjustment_set_lower(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_upper(BYVAL AS GtkAdjustment PTR) AS gdouble
DECLARE SUB gtk_adjustment_set_upper(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_step_increment(BYVAL AS GtkAdjustment PTR) AS gdouble
DECLARE SUB gtk_adjustment_set_step_increment(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_page_increment(BYVAL AS GtkAdjustment PTR) AS gdouble
DECLARE SUB gtk_adjustment_set_page_increment(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_page_size(BYVAL AS GtkAdjustment PTR) AS gdouble
DECLARE SUB gtk_adjustment_set_page_size(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble)
DECLARE SUB gtk_adjustment_configure(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION gtk_adjustment_get_minimum_increment(BYVAL AS GtkAdjustment PTR) AS gdouble

#ENDIF ' __GTK_ADJUSTMENT_H__

#IFNDEF __GTK_STYLE_H__
#DEFINE __GTK_STYLE_H__

#IFNDEF __GTK_WIDGET_PATH_H__
#DEFINE __GTK_WIDGET_PATH_H__

TYPE GtkWidgetPath AS _GtkWidgetPath
TYPE GtkWidget AS _GtkWidget

#DEFINE GTK_TYPE_WIDGET_PATH (gtk_widget_path_get_type ())

DECLARE FUNCTION gtk_widget_path_get_type() AS GType
DECLARE FUNCTION gtk_widget_path_new() AS GtkWidgetPath PTR
DECLARE FUNCTION gtk_widget_path_copy(BYVAL AS CONST GtkWidgetPath PTR) AS GtkWidgetPath PTR
DECLARE FUNCTION gtk_widget_path_ref(BYVAL AS GtkWidgetPath PTR) AS GtkWidgetPath PTR
DECLARE SUB gtk_widget_path_unref(BYVAL AS GtkWidgetPath PTR)
DECLARE SUB gtk_widget_path_free(BYVAL AS GtkWidgetPath PTR)
DECLARE FUNCTION gtk_widget_path_to_string(BYVAL AS CONST GtkWidgetPath PTR) AS ZSTRING PTR
DECLARE FUNCTION gtk_widget_path_length(BYVAL AS CONST GtkWidgetPath PTR) AS gint
DECLARE FUNCTION gtk_widget_path_append_type(BYVAL AS GtkWidgetPath PTR, BYVAL AS GType) AS gint
DECLARE SUB gtk_widget_path_prepend_type(BYVAL AS GtkWidgetPath PTR, BYVAL AS GType)
DECLARE FUNCTION gtk_widget_path_append_with_siblings(BYVAL AS GtkWidgetPath PTR, BYVAL AS GtkWidgetPath PTR, BYVAL AS guint) AS gint
DECLARE FUNCTION gtk_widget_path_append_for_widget(BYVAL AS GtkWidgetPath PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_widget_path_iter_get_object_type(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint) AS GType
DECLARE SUB gtk_widget_path_iter_set_object_type(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS GType)
DECLARE FUNCTION gtk_widget_path_iter_get_siblings(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint) AS CONST GtkWidgetPath PTR
DECLARE FUNCTION gtk_widget_path_iter_get_sibling_index(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint) AS guint
DECLARE FUNCTION gtk_widget_path_iter_get_name(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint) AS CONST gchar PTR
DECLARE SUB gtk_widget_path_iter_set_name(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_widget_path_iter_has_name(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_widget_path_iter_has_qname(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS GQuark) AS gboolean
DECLARE SUB gtk_widget_path_iter_add_class(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_widget_path_iter_remove_class(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_widget_path_iter_clear_classes(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_widget_path_iter_list_classes(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint) AS GSList PTR
DECLARE FUNCTION gtk_widget_path_iter_has_class(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_widget_path_iter_has_qclass(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS GQuark) AS gboolean
DECLARE SUB gtk_widget_path_iter_add_region(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GtkRegionFlags)
DECLARE SUB gtk_widget_path_iter_remove_region(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_widget_path_iter_clear_regions(BYVAL AS GtkWidgetPath PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_widget_path_iter_list_regions(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint) AS GSList PTR
DECLARE FUNCTION gtk_widget_path_iter_has_region(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GtkRegionFlags PTR) AS gboolean
DECLARE FUNCTION gtk_widget_path_iter_has_qregion(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS gint, BYVAL AS GQuark, BYVAL AS GtkRegionFlags PTR) AS gboolean
DECLARE FUNCTION gtk_widget_path_get_object_type(BYVAL AS CONST GtkWidgetPath PTR) AS GType
DECLARE FUNCTION gtk_widget_path_is_type(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS GType) AS gboolean
DECLARE FUNCTION gtk_widget_path_has_parent(BYVAL AS CONST GtkWidgetPath PTR, BYVAL AS GType) AS gboolean

#ENDIF ' __GTK_WIDGET_PATH_H__

#DEFINE GTK_TYPE_STYLE (gtk_style_get_type ())
#DEFINE GTK_STYLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_STYLE, GtkStyle))
#DEFINE GTK_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_STYLE, GtkStyleClass))
#DEFINE GTK_IS_STYLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_STYLE))
#DEFINE GTK_IS_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_STYLE))
#DEFINE GTK_STYLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_STYLE, GtkStyleClass))

TYPE GtkStyle AS _GtkStyle
TYPE GtkStyleClass AS _GtkStyleClass
TYPE GtkThemeEngine AS _GtkThemeEngine
TYPE GtkRcStyle AS _GtkRcStyle
TYPE GtkIconSet AS _GtkIconSet
TYPE GtkIconSource AS _GtkIconSource
TYPE GtkRcProperty AS _GtkRcProperty
TYPE GtkSettings AS _GtkSettings
TYPE GtkRcPropertyParser AS FUNCTION(BYVAL AS CONST GParamSpec PTR, BYVAL AS CONST GString PTR, BYVAL AS GValue PTR) AS gboolean

#DEFINE GTK_STYLE_ATTACHED(style) (GTK_STYLE (style)- >attach_count > 0)

TYPE _GtkStyle
  AS GObject parent_instance
  AS GdkColor fg(4)
  AS GdkColor bg(4)
  AS GdkColor light(4)
  AS GdkColor dark(4)
  AS GdkColor mid(4)
  AS GdkColor text(4)
  AS GdkColor base(4)
  AS GdkColor text_aa(4)
  AS GdkColor black
  AS GdkColor white
  AS PangoFontDescription PTR font_desc
  AS gint xthickness
  AS gint ythickness
  AS cairo_pattern_t PTR background(4)
  AS gint attach_count
  AS GdkVisual PTR visual
  AS PangoFontDescription PTR private_font_desc
  AS GtkRcStyle PTR rc_style
  AS GSList PTR styles
  AS GArray PTR property_cache
  AS GSList PTR icon_factories
END TYPE

TYPE _GtkStyleClass
  AS GObjectClass parent_class
  realize AS SUB(BYVAL AS GtkStyle PTR)
  unrealize AS SUB(BYVAL AS GtkStyle PTR)
  copy AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS GtkStyle PTR)
  clone AS FUNCTION(BYVAL AS GtkStyle PTR) AS GtkStyle PTR
  init_from_rc AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS GtkRcStyle PTR)
  set_background AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS GdkWindow PTR, BYVAL AS GtkStateType)
  render_icon AS FUNCTION(BYVAL AS GtkStyle PTR, BYVAL AS CONST GtkIconSource PTR, BYVAL AS GtkTextDirection, BYVAL AS GtkStateType, BYVAL AS GtkIconSize, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS GdkPixbuf PTR
  draw_hline AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_vline AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_shadow AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_arrow AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkArrowType, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_diamond AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_box AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_flat_box AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_check AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_option AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_tab AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_shadow_gap AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkPositionType, BYVAL AS gint, BYVAL AS gint)
  draw_box_gap AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkPositionType, BYVAL AS gint, BYVAL AS gint)
  draw_extension AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkPositionType)
  draw_focus AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_slider AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkOrientation)
  draw_handle AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkOrientation)
  draw_expander AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkExpanderStyle)
  draw_layout AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS gboolean, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoLayout PTR)
  draw_resize_grip AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkWindowEdge, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_spinner AS SUB(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
  _gtk_reserved9 AS SUB()
  _gtk_reserved10 AS SUB()
  _gtk_reserved11 AS SUB()
END TYPE

#IF NOT DEFINED(GTK_DISABLE_DEPRECATED) OR DEFINED(GTK_COMPILATION)

DECLARE FUNCTION gtk_style_get_type() AS GType
DECLARE FUNCTION gtk_style_new() AS GtkStyle PTR
DECLARE FUNCTION gtk_style_copy(BYVAL AS GtkStyle PTR) AS GtkStyle PTR
DECLARE FUNCTION gtk_style_attach(BYVAL AS GtkStyle PTR, BYVAL AS GdkWindow PTR) AS GtkStyle PTR
DECLARE SUB gtk_style_detach(BYVAL AS GtkStyle PTR)
DECLARE SUB gtk_style_set_background(BYVAL AS GtkStyle PTR, BYVAL AS GdkWindow PTR, BYVAL AS GtkStateType)
DECLARE SUB gtk_style_apply_default_background(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GdkWindow PTR, BYVAL AS GtkStateType, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_style_lookup_icon_set(BYVAL AS GtkStyle PTR, BYVAL AS CONST gchar PTR) AS GtkIconSet PTR
DECLARE FUNCTION gtk_style_lookup_color(BYVAL AS GtkStyle PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkColor PTR) AS gboolean
DECLARE FUNCTION gtk_style_render_icon(BYVAL AS GtkStyle PTR, BYVAL AS CONST GtkIconSource PTR, BYVAL AS GtkTextDirection, BYVAL AS GtkStateType, BYVAL AS GtkIconSize, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS GdkPixbuf PTR
DECLARE SUB gtk_paint_hline(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_vline(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_shadow(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_arrow(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkArrowType, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_diamond(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_box(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_flat_box(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_check(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_option(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_tab(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_shadow_gap(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkPositionType, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_box_gap(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkPositionType, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_extension(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkPositionType)
DECLARE SUB gtk_paint_focus(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_slider(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkOrientation)
DECLARE SUB gtk_paint_handle(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkShadowType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkOrientation)
DECLARE SUB gtk_paint_expander(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkExpanderStyle)
DECLARE SUB gtk_paint_layout(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS gboolean, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoLayout PTR)
DECLARE SUB gtk_paint_resize_grip(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkWindowEdge, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_paint_spinner(BYVAL AS GtkStyle PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkStateType, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_style_get_style_property(BYVAL AS GtkStyle PTR, BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB gtk_style_get_valist(BYVAL AS GtkStyle PTR, BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB gtk_style_get(BYVAL AS GtkStyle PTR, BYVAL AS GType, BYVAL AS CONST gchar PTR, ...)

#ENDIF ' NOT DEFINED(GTK...

DECLARE FUNCTION _gtk_style_new_for_path(BYVAL AS GdkScreen PTR, BYVAL AS GtkWidgetPath PTR) AS GtkStyle PTR
DECLARE SUB _gtk_style_shade(BYVAL AS CONST GdkColor PTR, BYVAL AS GdkColor PTR, BYVAL AS gdouble)
DECLARE SUB gtk_draw_insertion_cursor(BYVAL AS GtkWidget PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gboolean, BYVAL AS GtkTextDirection, BYVAL AS gboolean)
DECLARE FUNCTION gtk_style_has_context(BYVAL AS GtkStyle PTR) AS gboolean

#ENDIF ' __GTK_STYLE_H__

#IFNDEF __GTK_BORDER_H__
#DEFINE __GTK_BORDER_H__

TYPE GtkBorder AS _GtkBorder

#DEFINE GTK_TYPE_BORDER (gtk_border_get_type ())

TYPE _GtkBorder
  AS gint16 left
  AS gint16 right
  AS gint16 top
  AS gint16 bottom
END TYPE

DECLARE FUNCTION gtk_border_get_type() AS GType
DECLARE FUNCTION gtk_border_new() AS GtkBorder PTR
DECLARE FUNCTION gtk_border_copy(BYVAL AS CONST GtkBorder PTR) AS GtkBorder PTR
DECLARE SUB gtk_border_free(BYVAL AS GtkBorder PTR)

#ENDIF ' __GTK_BORDER_H__

#IFNDEF __GTK_SETTINGS_H__
#DEFINE __GTK_SETTINGS_H__

#IFNDEF __GTK_RC_H__
#DEFINE __GTK_RC_H__

TYPE GtkIconFactory AS _GtkIconFactory
TYPE GtkRcContext AS _GtkRcContext
TYPE GtkRcStyleClass AS _GtkRcStyleClass

#DEFINE GTK_TYPE_RC_STYLE (gtk_rc_style_get_type ())
#DEFINE GTK_RC_STYLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_RC_STYLE, GtkRcStyle))
#DEFINE GTK_RC_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RC_STYLE, GtkRcStyleClass))
#DEFINE GTK_IS_RC_STYLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_RC_STYLE))
#DEFINE GTK_IS_RC_STYLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RC_STYLE))
#DEFINE GTK_RC_STYLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RC_STYLE, GtkRcStyleClass))

ENUM GtkRcFlags
  GTK_RC_FG = 1 SHL 0
  GTK_RC_BG = 1 SHL 1
  GTK_RC_TEXT = 1 SHL 2
  GTK_RC_BASE = 1 SHL 3
END ENUM

TYPE _GtkRcStyle
  AS GObject parent_instance
  AS gchar PTR name
  AS gchar PTR bg_pixmap_name(4)
  AS PangoFontDescription PTR font_desc
  AS GtkRcFlags color_flags(4)
  AS GdkColor fg(4)
  AS GdkColor bg(4)
  AS GdkColor text(4)
  AS GdkColor base(4)
  AS gint xthickness
  AS gint ythickness
  AS GArray PTR rc_properties
  AS GSList PTR rc_style_lists
  AS GSList PTR icon_factories
  AS guint engine_specified : 1
END TYPE

TYPE _GtkRcStyleClass
  AS GObjectClass parent_class
  create_rc_style AS FUNCTION(BYVAL AS GtkRcStyle PTR) AS GtkRcStyle PTR
  parse AS FUNCTION(BYVAL AS GtkRcStyle PTR, BYVAL AS GtkSettings PTR, BYVAL AS GScanner PTR) AS guint
  merge AS SUB(BYVAL AS GtkRcStyle PTR, BYVAL AS GtkRcStyle PTR)
  create_style AS FUNCTION(BYVAL AS GtkRcStyle PTR) AS GtkStyle PTR
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION _gtk_rc_parse_widget_class_path(BYVAL AS CONST gchar PTR) AS GSList PTR
DECLARE SUB _gtk_rc_free_widget_class_path(BYVAL AS GSList PTR)
DECLARE FUNCTION _gtk_rc_match_widget_class(BYVAL AS GSList PTR, BYVAL AS gint, BYVAL AS gchar PTR, BYVAL AS gchar PTR) AS gboolean

#IF NOT DEFINED(GTK_DISABLE_DEPRECATED) OR DEFINED(GTK_COMPILATION)

DECLARE SUB gtk_rc_add_default_file(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_rc_set_default_files(BYVAL AS gchar PTR PTR)
DECLARE FUNCTION gtk_rc_get_default_files() AS gchar PTR PTR
DECLARE FUNCTION gtk_rc_get_style(BYVAL AS GtkWidget PTR) AS GtkStyle PTR
DECLARE FUNCTION gtk_rc_get_style_by_paths(BYVAL AS GtkSettings PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GType) AS GtkStyle PTR
DECLARE FUNCTION gtk_rc_reparse_all_for_settings(BYVAL AS GtkSettings PTR, BYVAL AS gboolean) AS gboolean
DECLARE SUB gtk_rc_reset_styles(BYVAL AS GtkSettings PTR)
DECLARE FUNCTION gtk_rc_find_pixmap_in_path(BYVAL AS GtkSettings PTR, BYVAL AS GScanner PTR, BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE SUB gtk_rc_parse(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_rc_parse_string(BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_rc_reparse_all() AS gboolean
DECLARE FUNCTION gtk_rc_style_get_type() AS GType
DECLARE FUNCTION gtk_rc_style_new() AS GtkRcStyle PTR
DECLARE FUNCTION gtk_rc_style_copy(BYVAL AS GtkRcStyle PTR) AS GtkRcStyle PTR
DECLARE FUNCTION gtk_rc_find_module_in_path(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE FUNCTION gtk_rc_get_theme_dir() AS gchar PTR
DECLARE FUNCTION gtk_rc_get_module_dir() AS gchar PTR
DECLARE FUNCTION gtk_rc_get_im_module_path() AS gchar PTR
DECLARE FUNCTION gtk_rc_get_im_module_file() AS gchar PTR

ENUM GtkRcTokenType
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
END ENUM

DECLARE FUNCTION gtk_rc_scanner_new() AS GScanner PTR
DECLARE FUNCTION gtk_rc_parse_color(BYVAL AS GScanner PTR, BYVAL AS GdkColor PTR) AS guint
DECLARE FUNCTION gtk_rc_parse_color_full(BYVAL AS GScanner PTR, BYVAL AS GtkRcStyle PTR, BYVAL AS GdkColor PTR) AS guint
DECLARE FUNCTION gtk_rc_parse_state(BYVAL AS GScanner PTR, BYVAL AS GtkStateType PTR) AS guint
DECLARE FUNCTION gtk_rc_parse_priority(BYVAL AS GScanner PTR, BYVAL AS GtkPathPriorityType PTR) AS guint

#ENDIF ' NOT DEFINED(GTK...

TYPE _GtkRcProperty
  AS GQuark type_name
  AS GQuark property_name
  AS gchar PTR origin
  AS GValue value
END TYPE

#ENDIF ' __GTK_RC_H__

#DEFINE GTK_TYPE_SETTINGS (gtk_settings_get_type ())
#DEFINE GTK_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SETTINGS, GtkSettings))
#DEFINE GTK_SETTINGS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SETTINGS, GtkSettingsClass))
#DEFINE GTK_IS_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SETTINGS))
#DEFINE GTK_IS_SETTINGS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SETTINGS))
#DEFINE GTK_SETTINGS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SETTINGS, GtkSettingsClass))

TYPE GtkSettingsPrivate AS _GtkSettingsPrivate
TYPE GtkSettingsClass AS _GtkSettingsClass
TYPE GtkSettingsValue AS _GtkSettingsValue

TYPE _GtkSettings
  AS GObject parent_instance
  AS GtkSettingsPrivate PTR priv
END TYPE

TYPE _GtkSettingsClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE _GtkSettingsValue
  AS gchar PTR origin
  AS GValue value
END TYPE

DECLARE FUNCTION gtk_settings_get_type() AS GType

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gtk_settings_get_default() AS GtkSettings PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gtk_settings_get_for_screen(BYVAL AS GdkScreen PTR) AS GtkSettings PTR
DECLARE SUB gtk_settings_install_property(BYVAL AS GParamSpec PTR)
DECLARE SUB gtk_settings_install_property_parser(BYVAL AS GParamSpec PTR, BYVAL AS GtkRcPropertyParser)
DECLARE FUNCTION gtk_rc_property_parse_color(BYVAL AS CONST GParamSpec PTR, BYVAL AS CONST GString PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION gtk_rc_property_parse_enum(BYVAL AS CONST GParamSpec PTR, BYVAL AS CONST GString PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION gtk_rc_property_parse_flags(BYVAL AS CONST GParamSpec PTR, BYVAL AS CONST GString PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION gtk_rc_property_parse_requisition(BYVAL AS CONST GParamSpec PTR, BYVAL AS CONST GString PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION gtk_rc_property_parse_border(BYVAL AS CONST GParamSpec PTR, BYVAL AS CONST GString PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE SUB gtk_settings_set_property_value(BYVAL AS GtkSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GtkSettingsValue PTR)
DECLARE SUB gtk_settings_set_string_property(BYVAL AS GtkSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_settings_set_long_property(BYVAL AS GtkSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS glong, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_settings_set_double_property(BYVAL AS GtkSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_SETTINGS_H__

#IFNDEF __GTK_STYLE_CONTEXT_H__
#DEFINE __GTK_STYLE_CONTEXT_H__

#IFNDEF __GTK_STYLE_PROVIDER_H__
#DEFINE __GTK_STYLE_PROVIDER_H__

#IFNDEF __GTK_ICON_FACTORY_H__
#DEFINE __GTK_ICON_FACTORY_H__

#DEFINE GTK_TYPE_ICON_FACTORY (gtk_icon_factory_get_type ())
#DEFINE GTK_ICON_FACTORY(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ICON_FACTORY, GtkIconFactory))
#DEFINE GTK_ICON_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass))
#DEFINE GTK_IS_ICON_FACTORY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ICON_FACTORY))
#DEFINE GTK_IS_ICON_FACTORY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ICON_FACTORY))
#DEFINE GTK_ICON_FACTORY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ICON_FACTORY, GtkIconFactoryClass))
#DEFINE GTK_TYPE_ICON_SET (gtk_icon_set_get_type ())
#DEFINE GTK_TYPE_ICON_SOURCE (gtk_icon_source_get_type ())

TYPE GtkIconFactoryPrivate AS _GtkIconFactoryPrivate
TYPE GtkIconFactoryClass AS _GtkIconFactoryClass

TYPE _GtkIconFactory
  AS GObject parent_instance
  AS GtkIconFactoryPrivate PTR priv
END TYPE

TYPE _GtkIconFactoryClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_icon_factory_get_type() AS GType
DECLARE FUNCTION gtk_icon_factory_new() AS GtkIconFactory PTR
DECLARE SUB gtk_icon_factory_add(BYVAL AS GtkIconFactory PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSet PTR)
DECLARE FUNCTION gtk_icon_factory_lookup(BYVAL AS GtkIconFactory PTR, BYVAL AS CONST gchar PTR) AS GtkIconSet PTR
DECLARE SUB gtk_icon_factory_add_default(BYVAL AS GtkIconFactory PTR)
DECLARE SUB gtk_icon_factory_remove_default(BYVAL AS GtkIconFactory PTR)
DECLARE FUNCTION gtk_icon_factory_lookup_default(BYVAL AS CONST gchar PTR) AS GtkIconSet PTR

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gtk_icon_size_lookup(BYVAL AS GtkIconSize, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gtk_icon_size_lookup_for_settings(BYVAL AS GtkSettings PTR, BYVAL AS GtkIconSize, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_icon_size_register(BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint) AS GtkIconSize
DECLARE SUB gtk_icon_size_register_alias(BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize)
DECLARE FUNCTION gtk_icon_size_from_name(BYVAL AS CONST gchar PTR) AS GtkIconSize
DECLARE FUNCTION gtk_icon_size_get_name(BYVAL AS GtkIconSize) AS CONST gchar PTR
DECLARE FUNCTION gtk_icon_set_get_type() AS GType
DECLARE FUNCTION gtk_icon_set_new() AS GtkIconSet PTR
DECLARE FUNCTION gtk_icon_set_new_from_pixbuf(BYVAL AS GdkPixbuf PTR) AS GtkIconSet PTR
DECLARE FUNCTION gtk_icon_set_ref(BYVAL AS GtkIconSet PTR) AS GtkIconSet PTR
DECLARE SUB gtk_icon_set_unref(BYVAL AS GtkIconSet PTR)
DECLARE FUNCTION gtk_icon_set_copy(BYVAL AS GtkIconSet PTR) AS GtkIconSet PTR

#IF NOT DEFINED (GTK_DISABLE_DEPRECATED) OR DEFINED (GTK_COMPILATION)

DECLARE FUNCTION gtk_icon_set_render_icon(BYVAL AS GtkIconSet PTR, BYVAL AS GtkStyle PTR, BYVAL AS GtkTextDirection, BYVAL AS GtkStateType, BYVAL AS GtkIconSize, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS GdkPixbuf PTR

#ENDIF ' NOT DEFINED (GT...

DECLARE SUB gtk_icon_set_add_source(BYVAL AS GtkIconSet PTR, BYVAL AS CONST GtkIconSource PTR)
DECLARE SUB gtk_icon_set_get_sizes(BYVAL AS GtkIconSet PTR, BYVAL AS GtkIconSize PTR PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_icon_source_get_type() AS GType
DECLARE FUNCTION gtk_icon_source_new() AS GtkIconSource PTR
DECLARE FUNCTION gtk_icon_source_copy(BYVAL AS CONST GtkIconSource PTR) AS GtkIconSource PTR
DECLARE SUB gtk_icon_source_free(BYVAL AS GtkIconSource PTR)
DECLARE SUB gtk_icon_source_set_filename(BYVAL AS GtkIconSource PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_icon_source_set_icon_name(BYVAL AS GtkIconSource PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_icon_source_set_pixbuf(BYVAL AS GtkIconSource PTR, BYVAL AS GdkPixbuf PTR)
DECLARE FUNCTION gtk_icon_source_get_filename(BYVAL AS CONST GtkIconSource PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_icon_source_get_icon_name(BYVAL AS CONST GtkIconSource PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_icon_source_get_pixbuf(BYVAL AS CONST GtkIconSource PTR) AS GdkPixbuf PTR
DECLARE SUB gtk_icon_source_set_direction_wildcarded(BYVAL AS GtkIconSource PTR, BYVAL AS gboolean)
DECLARE SUB gtk_icon_source_set_state_wildcarded(BYVAL AS GtkIconSource PTR, BYVAL AS gboolean)
DECLARE SUB gtk_icon_source_set_size_wildcarded(BYVAL AS GtkIconSource PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_icon_source_get_size_wildcarded(BYVAL AS CONST GtkIconSource PTR) AS gboolean
DECLARE FUNCTION gtk_icon_source_get_state_wildcarded(BYVAL AS CONST GtkIconSource PTR) AS gboolean
DECLARE FUNCTION gtk_icon_source_get_direction_wildcarded(BYVAL AS CONST GtkIconSource PTR) AS gboolean
DECLARE SUB gtk_icon_source_set_direction(BYVAL AS GtkIconSource PTR, BYVAL AS GtkTextDirection)
DECLARE SUB gtk_icon_source_set_state(BYVAL AS GtkIconSource PTR, BYVAL AS GtkStateType)
DECLARE SUB gtk_icon_source_set_size(BYVAL AS GtkIconSource PTR, BYVAL AS GtkIconSize)
DECLARE FUNCTION gtk_icon_source_get_direction(BYVAL AS CONST GtkIconSource PTR) AS GtkTextDirection
DECLARE FUNCTION gtk_icon_source_get_state(BYVAL AS CONST GtkIconSource PTR) AS GtkStateType
DECLARE FUNCTION gtk_icon_source_get_size(BYVAL AS CONST GtkIconSource PTR) AS GtkIconSize
DECLARE SUB _gtk_icon_set_invalidate_caches()
DECLARE FUNCTION _gtk_icon_factory_list_ids() AS GList PTR
DECLARE SUB _gtk_icon_factory_ensure_default_icons()

#ENDIF ' __GTK_ICON_FACTORY_H__

#IFNDEF __GTK_STYLE_PROPERTIES_H__
#DEFINE __GTK_STYLE_PROPERTIES_H__

#DEFINE GTK_TYPE_STYLE_PROPERTIES (gtk_style_properties_get_type ())
#DEFINE GTK_STYLE_PROPERTIES(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_STYLE_PROPERTIES, GtkStyleProperties))
#DEFINE GTK_STYLE_PROPERTIES_CLASS(c) (G_TYPE_CHECK_CLASS_CAST ((c), GTK_TYPE_STYLE_PROPERTIES, GtkStylePropertiesClass))
#DEFINE GTK_IS_STYLE_PROPERTIES(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_STYLE_PROPERTIES))
#DEFINE GTK_IS_STYLE_PROPERTIES_CLASS(c) (G_TYPE_CHECK_CLASS_TYPE ((c), GTK_TYPE_STYLE_PROPERTIES))
#DEFINE GTK_STYLE_PROPERTIES_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_STYLE_PROPERTIES, GtkStylePropertiesClass))

TYPE GtkStyleProperties AS _GtkStyleProperties
TYPE GtkStylePropertiesClass AS _GtkStylePropertiesClass
TYPE GtkSymbolicColor AS _GtkSymbolicColor
TYPE GtkGradient AS _GtkGradient

TYPE _GtkStyleProperties
  AS GObject parent_object
  AS gpointer priv
END TYPE

TYPE _GtkStylePropertiesClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE GtkStylePropertyParser AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR, BYVAL AS GError PTR PTR) AS gboolean

DECLARE FUNCTION gtk_style_properties_get_type() AS GType
DECLARE SUB gtk_style_properties_register_property(BYVAL AS GtkStylePropertyParser, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION gtk_style_properties_lookup_property(BYVAL AS CONST gchar PTR, BYVAL AS GtkStylePropertyParser, BYVAL AS GParamSpec PTR PTR) AS gboolean
DECLARE FUNCTION gtk_style_properties_new() AS GtkStyleProperties PTR
DECLARE SUB gtk_style_properties_map_color(BYVAL AS GtkStyleProperties PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkSymbolicColor PTR)
DECLARE FUNCTION gtk_style_properties_lookup_color(BYVAL AS GtkStyleProperties PTR, BYVAL AS CONST gchar PTR) AS GtkSymbolicColor PTR
DECLARE SUB gtk_style_properties_set_property(BYVAL AS GtkStyleProperties PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkStateFlags, BYVAL AS CONST GValue PTR)
DECLARE SUB gtk_style_properties_set_valist(BYVAL AS GtkStyleProperties PTR, BYVAL AS GtkStateFlags, BYVAL AS va_list)
DECLARE SUB gtk_style_properties_set(BYVAL AS GtkStyleProperties PTR, BYVAL AS GtkStateFlags, ...)
DECLARE FUNCTION gtk_style_properties_get_property(BYVAL AS GtkStyleProperties PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkStateFlags, BYVAL AS GValue PTR) AS gboolean
DECLARE SUB gtk_style_properties_get_valist(BYVAL AS GtkStyleProperties PTR, BYVAL AS GtkStateFlags, BYVAL AS va_list)
DECLARE SUB gtk_style_properties_get(BYVAL AS GtkStyleProperties PTR, BYVAL AS GtkStateFlags, ...)
DECLARE SUB gtk_style_properties_unset_property(BYVAL AS GtkStyleProperties PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkStateFlags)
DECLARE SUB gtk_style_properties_clear(BYVAL AS GtkStyleProperties PTR)
DECLARE SUB gtk_style_properties_merge(BYVAL AS GtkStyleProperties PTR, BYVAL AS CONST GtkStyleProperties PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_STYLE_PROPERTIES_H__

#DEFINE GTK_TYPE_STYLE_PROVIDER (gtk_style_provider_get_type ())
#DEFINE GTK_STYLE_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_STYLE_PROVIDER, GtkStyleProvider))
#DEFINE GTK_IS_STYLE_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_STYLE_PROVIDER))
#DEFINE GTK_STYLE_PROVIDER_GET_IFACE(o) (G_TYPE_INSTANCE_GET_INTERFACE ((o), GTK_TYPE_STYLE_PROVIDER, GtkStyleProviderIface))
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_FALLBACK 1
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_THEME 200
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_SETTINGS 400
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_APPLICATION 600
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_USER 800

TYPE GtkStyleProviderIface AS _GtkStyleProviderIface
TYPE GtkStyleProvider AS _GtkStyleProvider

TYPE _GtkStyleProviderIface
  AS GTypeInterface g_iface
  get_style AS FUNCTION(BYVAL AS GtkStyleProvider PTR, BYVAL AS GtkWidgetPath PTR) AS GtkStyleProperties PTR
  get_style_property AS FUNCTION(BYVAL AS GtkStyleProvider PTR, BYVAL AS GtkWidgetPath PTR, BYVAL AS GtkStateFlags, BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR) AS gboolean
  get_icon_factory AS FUNCTION(BYVAL AS GtkStyleProvider PTR, BYVAL AS GtkWidgetPath PTR) AS GtkIconFactory PTR
END TYPE

DECLARE FUNCTION gtk_style_provider_get_type() AS GType
DECLARE FUNCTION gtk_style_provider_get_style(BYVAL AS GtkStyleProvider PTR, BYVAL AS GtkWidgetPath PTR) AS GtkStyleProperties PTR
DECLARE FUNCTION gtk_style_provider_get_style_property(BYVAL AS GtkStyleProvider PTR, BYVAL AS GtkWidgetPath PTR, BYVAL AS GtkStateFlags, BYVAL AS GParamSpec PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE FUNCTION gtk_style_provider_get_icon_factory(BYVAL AS GtkStyleProvider PTR, BYVAL AS GtkWidgetPath PTR) AS GtkIconFactory PTR

#ENDIF ' __GTK_STYLE_PROVIDER_H__

#INCLUDE ONCE "atk/atk.bi"
#DEFINE GTK_TYPE_STYLE_CONTEXT (gtk_style_context_get_type ())
#DEFINE GTK_STYLE_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_STYLE_CONTEXT, GtkStyleContext))
#DEFINE GTK_STYLE_CONTEXT_CLASS(c) (G_TYPE_CHECK_CLASS_CAST ((c), GTK_TYPE_STYLE_CONTEXT, GtkStyleContextClass))
#DEFINE GTK_IS_STYLE_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_STYLE_CONTEXT))
#DEFINE GTK_IS_STYLE_CONTEXT_CLASS(c) (G_TYPE_CHECK_CLASS_TYPE ((c), GTK_TYPE_STYLE_CONTEXT))
#DEFINE GTK_STYLE_CONTEXT_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_STYLE_CONTEXT, GtkStyleContextClass))

TYPE GtkStyleContext AS _GtkStyleContext
TYPE GtkStyleContextClass AS _GtkStyleContextClass
TYPE GtkStyleContextPrivate AS _GtkStyleContextPrivate

TYPE _GtkStyleContext
  AS GObject parent_object
  AS GtkStyleContextPrivate PTR priv
END TYPE

TYPE _GtkStyleContextClass
  AS GObjectClass parent_class
  changed AS SUB(BYVAL AS GtkStyleContext PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

#DEFINE GTK_STYLE_PROPERTY_BACKGROUND_COLOR !"background-color"
#DEFINE GTK_STYLE_PROPERTY_COLOR !"color"
#DEFINE GTK_STYLE_PROPERTY_FONT !"font"
#DEFINE GTK_STYLE_PROPERTY_PADDING !"padding"
#DEFINE GTK_STYLE_PROPERTY_BORDER_WIDTH !"border-width"
#DEFINE GTK_STYLE_PROPERTY_MARGIN !"margin"
#DEFINE GTK_STYLE_PROPERTY_BORDER_RADIUS !"border-radius"
#DEFINE GTK_STYLE_PROPERTY_BORDER_STYLE !"border-style"
#DEFINE GTK_STYLE_PROPERTY_BORDER_COLOR !"border-color"
#DEFINE GTK_STYLE_PROPERTY_BACKGROUND_IMAGE !"background-image"
#DEFINE GTK_STYLE_CLASS_CELL !"cell"
#DEFINE GTK_STYLE_CLASS_ENTRY !"entry"
#DEFINE GTK_STYLE_CLASS_COMBOBOX_ENTRY !"combobox-entry"
#DEFINE GTK_STYLE_CLASS_BUTTON !"button"
#DEFINE GTK_STYLE_CLASS_CALENDAR !"calendar"
#DEFINE GTK_STYLE_CLASS_SLIDER !"slider"
#DEFINE GTK_STYLE_CLASS_BACKGROUND !"background"
#DEFINE GTK_STYLE_CLASS_RUBBERBAND !"rubberband"
#DEFINE GTK_STYLE_CLASS_TOOLTIP !"tooltip"
#DEFINE GTK_STYLE_CLASS_MENU !"menu"
#DEFINE GTK_STYLE_CLASS_MENUBAR !"menubar"
#DEFINE GTK_STYLE_CLASS_MENUITEM !"menuitem"
#DEFINE GTK_STYLE_CLASS_TOOLBAR !"toolbar"
#DEFINE GTK_STYLE_CLASS_PRIMARY_TOOLBAR !"primary-toolbar"
#DEFINE GTK_STYLE_CLASS_INLINE_TOOLBAR !"inline-toolbar"
#DEFINE GTK_STYLE_CLASS_RADIO !"radio"
#DEFINE GTK_STYLE_CLASS_CHECK !"check"
#DEFINE GTK_STYLE_CLASS_DEFAULT !"default"
#DEFINE GTK_STYLE_CLASS_TROUGH !"trough"
#DEFINE GTK_STYLE_CLASS_SCROLLBAR !"scrollbar"
#DEFINE GTK_STYLE_CLASS_SCALE !"scale"
#DEFINE GTK_STYLE_CLASS_SCALE_HAS_MARKS_ABOVE !"scale-has-marks-above"
#DEFINE GTK_STYLE_CLASS_SCALE_HAS_MARKS_BELOW !"scale-has-marks-below"
#DEFINE GTK_STYLE_CLASS_HEADER !"header"
#DEFINE GTK_STYLE_CLASS_ACCELERATOR !"accelerator"
#DEFINE GTK_STYLE_CLASS_RAISED !"raised"
#DEFINE GTK_STYLE_CLASS_GRIP !"grip"
#DEFINE GTK_STYLE_CLASS_DOCK !"dock"
#DEFINE GTK_STYLE_CLASS_PROGRESSBAR !"progressbar"
#DEFINE GTK_STYLE_CLASS_SPINNER !"spinner"
#DEFINE GTK_STYLE_CLASS_MARK !"mark"
#DEFINE GTK_STYLE_CLASS_EXPANDER !"expander"
#DEFINE GTK_STYLE_CLASS_SPINBUTTON !"spinbutton"
#DEFINE GTK_STYLE_CLASS_NOTEBOOK !"notebook"
#DEFINE GTK_STYLE_CLASS_VIEW !"view"
#DEFINE GTK_STYLE_CLASS_SIDEBAR !"sidebar"
#DEFINE GTK_STYLE_CLASS_IMAGE !"image"
#DEFINE GTK_STYLE_CLASS_HIGHLIGHT !"highlight"
#DEFINE GTK_STYLE_CLASS_FRAME !"frame"
#DEFINE GTK_STYLE_CLASS_DND !"dnd"
#DEFINE GTK_STYLE_CLASS_PANE_SEPARATOR !"pane-separator"
#DEFINE GTK_STYLE_CLASS_SEPARATOR !"separator"
#DEFINE GTK_STYLE_CLASS_INFO !"info"
#DEFINE GTK_STYLE_CLASS_WARNING !"warning"
#DEFINE GTK_STYLE_CLASS_QUESTION !"question"
#DEFINE GTK_STYLE_CLASS_ERROR !"error"
#DEFINE GTK_STYLE_CLASS_HORIZONTAL !"horizontal"
#DEFINE GTK_STYLE_CLASS_VERTICAL !"vertical"
#DEFINE GTK_STYLE_REGION_ROW !"row"
#DEFINE GTK_STYLE_REGION_COLUMN !"column"
#DEFINE GTK_STYLE_REGION_COLUMN_HEADER !"column-header"
#DEFINE GTK_STYLE_REGION_TAB !"tab"

DECLARE FUNCTION gtk_style_context_get_type() AS GType
DECLARE FUNCTION gtk_style_context_new() AS GtkStyleContext PTR
DECLARE SUB gtk_style_context_add_provider_for_screen(BYVAL AS GdkScreen PTR, BYVAL AS GtkStyleProvider PTR, BYVAL AS guint)
DECLARE SUB gtk_style_context_remove_provider_for_screen(BYVAL AS GdkScreen PTR, BYVAL AS GtkStyleProvider PTR)
DECLARE SUB gtk_style_context_add_provider(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStyleProvider PTR, BYVAL AS guint)
DECLARE SUB gtk_style_context_remove_provider(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStyleProvider PTR)
DECLARE SUB gtk_style_context_save(BYVAL AS GtkStyleContext PTR)
DECLARE SUB gtk_style_context_restore(BYVAL AS GtkStyleContext PTR)
DECLARE SUB gtk_style_context_get_property(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkStateFlags, BYVAL AS GValue PTR)
DECLARE SUB gtk_style_context_get_valist(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS va_list)
DECLARE SUB gtk_style_context_get(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, ...)
DECLARE SUB gtk_style_context_set_state(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags)
DECLARE FUNCTION gtk_style_context_get_state(BYVAL AS GtkStyleContext PTR) AS GtkStateFlags
DECLARE FUNCTION gtk_style_context_state_is_running(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateType, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB gtk_style_context_set_path(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkWidgetPath PTR)
DECLARE FUNCTION gtk_style_context_get_path(BYVAL AS GtkStyleContext PTR) AS CONST GtkWidgetPath PTR
DECLARE FUNCTION gtk_style_context_list_classes(BYVAL AS GtkStyleContext PTR) AS GList PTR
DECLARE SUB gtk_style_context_add_class(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_style_context_remove_class(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_style_context_has_class(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_style_context_list_regions(BYVAL AS GtkStyleContext PTR) AS GList PTR
DECLARE SUB gtk_style_context_add_region(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkRegionFlags)
DECLARE SUB gtk_style_context_remove_region(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_style_context_has_region(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkRegionFlags PTR) AS gboolean
DECLARE SUB gtk_style_context_get_style_property(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB gtk_style_context_get_style_valist(BYVAL AS GtkStyleContext PTR, BYVAL AS va_list)
DECLARE SUB gtk_style_context_get_style(BYVAL AS GtkStyleContext PTR, ...)
DECLARE FUNCTION gtk_style_context_lookup_icon_set(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR) AS GtkIconSet PTR
DECLARE FUNCTION gtk_icon_set_render_icon_pixbuf(BYVAL AS GtkIconSet PTR, BYVAL AS GtkStyleContext PTR, BYVAL AS GtkIconSize) AS GdkPixbuf PTR
DECLARE SUB gtk_style_context_set_screen(BYVAL AS GtkStyleContext PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gtk_style_context_get_screen(BYVAL AS GtkStyleContext PTR) AS GdkScreen PTR
DECLARE SUB gtk_style_context_set_direction(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkTextDirection)
DECLARE FUNCTION gtk_style_context_get_direction(BYVAL AS GtkStyleContext PTR) AS GtkTextDirection
DECLARE SUB gtk_style_context_set_junction_sides(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkJunctionSides)
DECLARE FUNCTION gtk_style_context_get_junction_sides(BYVAL AS GtkStyleContext PTR) AS GtkJunctionSides
DECLARE FUNCTION gtk_style_context_lookup_color(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkRGBA PTR) AS gboolean
DECLARE SUB gtk_style_context_notify_state_change(BYVAL AS GtkStyleContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS gpointer, BYVAL AS GtkStateType, BYVAL AS gboolean)
DECLARE SUB gtk_style_context_cancel_animations(BYVAL AS GtkStyleContext PTR, BYVAL AS gpointer)
DECLARE SUB gtk_style_context_scroll_animations(BYVAL AS GtkStyleContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_style_context_push_animatable_region(BYVAL AS GtkStyleContext PTR, BYVAL AS gpointer)
DECLARE SUB gtk_style_context_pop_animatable_region(BYVAL AS GtkStyleContext PTR)
DECLARE SUB gtk_style_context_get_color(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_style_context_get_background_color(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_style_context_get_border_color(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS GdkRGBA PTR)
DECLARE FUNCTION gtk_style_context_get_font(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags) AS CONST PangoFontDescription PTR
DECLARE SUB gtk_style_context_get_border(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS GtkBorder PTR)
DECLARE SUB gtk_style_context_get_padding(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS GtkBorder PTR)
DECLARE SUB gtk_style_context_get_margin(BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags, BYVAL AS GtkBorder PTR)
DECLARE SUB gtk_style_context_invalidate(BYVAL AS GtkStyleContext PTR)
DECLARE SUB gtk_style_context_reset_widgets(BYVAL AS GdkScreen PTR)
DECLARE SUB gtk_style_context_set_background(BYVAL AS GtkStyleContext PTR, BYVAL AS GdkWindow PTR)
DECLARE SUB gtk_render_check(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_option(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_arrow(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_background(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_frame(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_expander(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_focus(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_layout(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS PangoLayout PTR)
DECLARE SUB gtk_render_line(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_slider(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkOrientation)
DECLARE SUB gtk_render_frame_gap(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkPositionType, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_extension(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkPositionType)
DECLARE SUB gtk_render_handle(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_render_activity(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION gtk_render_icon_pixbuf(BYVAL AS GtkStyleContext PTR, BYVAL AS CONST GtkIconSource PTR, BYVAL AS GtkIconSize) AS GdkPixbuf PTR
DECLARE SUB gtk_render_icon(BYVAL AS GtkStyleContext PTR, BYVAL AS cairo_t PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE FUNCTION _gtk_style_context_get_attributes(BYVAL AS AtkAttributeSet PTR, BYVAL AS GtkStyleContext PTR, BYVAL AS GtkStateFlags) AS AtkAttributeSet PTR

#ENDIF ' __GTK_STYLE_CONTEXT_H__

ENUM GtkWidgetHelpType
  GTK_WIDGET_HELP_TOOLTIP
  GTK_WIDGET_HELP_WHATS_THIS
END ENUM

#DEFINE GTK_TYPE_WIDGET (gtk_widget_get_type ())
#DEFINE GTK_WIDGET(widget) (G_TYPE_CHECK_INSTANCE_CAST ((widget), GTK_TYPE_WIDGET, GtkWidget))
#DEFINE GTK_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WIDGET, GtkWidgetClass))
#DEFINE GTK_IS_WIDGET(widget) (G_TYPE_CHECK_INSTANCE_TYPE ((widget), GTK_TYPE_WIDGET))
#DEFINE GTK_IS_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WIDGET))
#DEFINE GTK_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WIDGET, GtkWidgetClass))
#DEFINE GTK_TYPE_REQUISITION (gtk_requisition_get_type ())

TYPE GtkRequisition AS _GtkRequisition
TYPE GtkSelectionData AS _GtkSelectionData
TYPE GtkWidgetPrivate AS _GtkWidgetPrivate
TYPE GtkWidgetClass AS _GtkWidgetClass
TYPE GtkWidgetClassPrivate AS _GtkWidgetClassPrivate
TYPE GtkWidgetAuxInfo AS _GtkWidgetAuxInfo
TYPE GtkClipboard AS _GtkClipboard
TYPE GtkTooltip AS _GtkTooltip
TYPE GtkWindow AS _GtkWindow
TYPE GtkAllocation AS GdkRectangle
TYPE GtkCallback AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gpointer)

TYPE _GtkRequisition
  AS gint width
  AS gint height
END TYPE

TYPE _GtkWidget
  AS GInitiallyUnowned parent_instance
  AS GtkWidgetPrivate PTR priv
END TYPE

TYPE _GtkWidgetClass
  AS GInitiallyUnownedClass parent_class
  AS guint activate_signal
  dispatch_child_properties_changed AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR PTR)
  destroy AS SUB(BYVAL AS GtkWidget PTR)
  show AS SUB(BYVAL AS GtkWidget PTR)
  show_all AS SUB(BYVAL AS GtkWidget PTR)
  hide AS SUB(BYVAL AS GtkWidget PTR)
  map AS SUB(BYVAL AS GtkWidget PTR)
  unmap AS SUB(BYVAL AS GtkWidget PTR)
  realize AS SUB(BYVAL AS GtkWidget PTR)
  unrealize AS SUB(BYVAL AS GtkWidget PTR)
  size_allocate AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkAllocation PTR)
  state_changed AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateType)
  state_flags_changed AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateFlags)
  parent_set AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
  hierarchy_changed AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
  style_set AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkStyle PTR)
  direction_changed AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkTextDirection)
  grab_notify AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
  child_notify AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GParamSpec PTR)
  draw_ AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS cairo_t PTR) AS gboolean
  get_request_mode AS FUNCTION(BYVAL AS GtkWidget PTR) AS GtkSizeRequestMode
  get_preferred_height AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_width_for_height AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_width AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_height_for_width AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  mnemonic_activate AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS gboolean) AS gboolean
  grab_focus AS SUB(BYVAL AS GtkWidget PTR)
  focus AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GtkDirectionType) AS gboolean
  move_focus AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkDirectionType)
  keynav_failed AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GtkDirectionType) AS gboolean
  event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR) AS gboolean
  button_press_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventButton PTR) AS gboolean
  button_release_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventButton PTR) AS gboolean
  scroll_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventScroll PTR) AS gboolean
  motion_notify_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventMotion PTR) AS gboolean
  delete_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventAny PTR) AS gboolean
  destroy_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventAny PTR) AS gboolean
  key_press_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventKey PTR) AS gboolean
  key_release_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventKey PTR) AS gboolean
  enter_notify_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventCrossing PTR) AS gboolean
  leave_notify_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventCrossing PTR) AS gboolean
  configure_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventConfigure PTR) AS gboolean
  focus_in_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventFocus PTR) AS gboolean
  focus_out_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventFocus PTR) AS gboolean
  map_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventAny PTR) AS gboolean
  unmap_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventAny PTR) AS gboolean
  property_notify_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventProperty PTR) AS gboolean
  selection_clear_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventSelection PTR) AS gboolean
  selection_request_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventSelection PTR) AS gboolean
  selection_notify_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventSelection PTR) AS gboolean
  proximity_in_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventProximity PTR) AS gboolean
  proximity_out_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventProximity PTR) AS gboolean
  visibility_notify_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventVisibility PTR) AS gboolean
  window_state_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventWindowState PTR) AS gboolean
  damage_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventExpose PTR) AS gboolean
  grab_broken_event AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventGrabBroken PTR) AS gboolean
  selection_get AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkSelectionData PTR, BYVAL AS guint, BYVAL AS guint)
  selection_received AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkSelectionData PTR, BYVAL AS guint)
  drag_begin AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR)
  drag_end AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR)
  drag_data_get AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS GtkSelectionData PTR, BYVAL AS guint, BYVAL AS guint)
  drag_data_delete AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR)
  drag_leave AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS guint)
  drag_motion AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint) AS gboolean
  drag_drop AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint) AS gboolean
  drag_data_received AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkSelectionData PTR, BYVAL AS guint, BYVAL AS guint)
  drag_failed AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS GtkDragResult) AS gboolean
  popup_menu AS FUNCTION(BYVAL AS GtkWidget PTR) AS gboolean
  show_help AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidgetHelpType) AS gboolean
  get_accessible AS FUNCTION(BYVAL AS GtkWidget PTR) AS AtkObject PTR
  screen_changed AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GdkScreen PTR)
  can_activate_accel AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS guint) AS gboolean
  composited_changed AS SUB(BYVAL AS GtkWidget PTR)
  query_tooltip AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gboolean, BYVAL AS GtkTooltip PTR) AS gboolean
  compute_expand AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS gboolean PTR, BYVAL AS gboolean PTR)
  adjust_size_request AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkOrientation, BYVAL AS gint PTR, BYVAL AS gint PTR)
  adjust_size_allocation AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkOrientation, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  style_updated AS SUB(BYVAL AS GtkWidget PTR)
  AS GtkWidgetClassPrivate PTR priv
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

TYPE _GtkWidgetAuxInfo
  AS gint width
  AS gint height
  AS guint halign : 4
  AS guint valign : 4
  AS GtkBorder margin
END TYPE

DECLARE FUNCTION gtk_widget_get_type() AS GType
DECLARE FUNCTION gtk_widget_new(BYVAL AS GType, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE SUB gtk_widget_destroy(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_destroyed(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR PTR)
DECLARE SUB gtk_widget_unparent(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_show(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_hide(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_show_now(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_show_all(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_no_show_all(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_no_show_all(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_map(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_unmap(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_realize(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_unrealize(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_draw(BYVAL AS GtkWidget PTR, BYVAL AS cairo_t PTR)
DECLARE SUB gtk_widget_queue_draw(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_queue_draw_area(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_widget_queue_draw_region(BYVAL AS GtkWidget PTR, BYVAL AS CONST cairo_region_t PTR)
DECLARE SUB gtk_widget_queue_resize(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_queue_resize_no_redraw(BYVAL AS GtkWidget PTR)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_widget_size_request(BYVAL AS GtkWidget PTR, BYVAL AS GtkRequisition PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_widget_size_allocate(BYVAL AS GtkWidget PTR, BYVAL AS GtkAllocation PTR)
DECLARE FUNCTION gtk_widget_get_request_mode(BYVAL AS GtkWidget PTR) AS GtkSizeRequestMode
DECLARE SUB gtk_widget_get_preferred_width(BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_widget_get_preferred_height_for_width(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_widget_get_preferred_height(BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_widget_get_preferred_width_for_height(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_widget_get_preferred_size(BYVAL AS GtkWidget PTR, BYVAL AS GtkRequisition PTR, BYVAL AS GtkRequisition PTR)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_widget_get_child_requisition(BYVAL AS GtkWidget PTR, BYVAL AS GtkRequisition PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_widget_add_accelerator(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkAccelGroup PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GtkAccelFlags)
DECLARE FUNCTION gtk_widget_remove_accelerator(BYVAL AS GtkWidget PTR, BYVAL AS GtkAccelGroup PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE SUB gtk_widget_set_accel_path(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE FUNCTION gtk_widget_list_accel_closures(BYVAL AS GtkWidget PTR) AS GList PTR
DECLARE FUNCTION gtk_widget_can_activate_accel(BYVAL AS GtkWidget PTR, BYVAL AS guint) AS gboolean
DECLARE FUNCTION gtk_widget_mnemonic_activate(BYVAL AS GtkWidget PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_widget_event(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR) AS gboolean
DECLARE FUNCTION gtk_widget_send_expose(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR) AS gint
DECLARE FUNCTION gtk_widget_send_focus_change(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR) AS gboolean
DECLARE FUNCTION gtk_widget_activate(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_reparent(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_widget_intersect(BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR) AS gboolean
DECLARE FUNCTION gtk_widget_region_intersect(BYVAL AS GtkWidget PTR, BYVAL AS CONST cairo_region_t PTR) AS cairo_region_t PTR
DECLARE SUB gtk_widget_freeze_child_notify(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_child_notify(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_widget_thaw_child_notify(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_can_focus(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_can_focus(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_has_focus(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_is_focus(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_has_visible_focus(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_grab_focus(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_can_default(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_can_default(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_has_default(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_grab_default(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_receives_default(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_receives_default(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_has_grab(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_device_is_shadowed(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR) AS gboolean
DECLARE SUB gtk_widget_set_name(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_widget_get_name(BYVAL AS GtkWidget PTR) AS CONST gchar PTR
DECLARE SUB gtk_widget_set_state(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateType)
DECLARE FUNCTION gtk_widget_get_state(BYVAL AS GtkWidget PTR) AS GtkStateType
DECLARE SUB gtk_widget_set_state_flags(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateFlags, BYVAL AS gboolean)
DECLARE SUB gtk_widget_unset_state_flags(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateFlags)
DECLARE FUNCTION gtk_widget_get_state_flags(BYVAL AS GtkWidget PTR) AS GtkStateFlags
DECLARE SUB gtk_widget_set_sensitive(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_sensitive(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_is_sensitive(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_visible(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_visible(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_has_window(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_has_window(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_is_toplevel(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_is_drawable(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_realized(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_realized(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_mapped(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_mapped(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_app_paintable(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_app_paintable(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_double_buffered(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_double_buffered(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_redraw_on_allocate(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE SUB gtk_widget_set_parent(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_widget_get_parent(BYVAL AS GtkWidget PTR) AS GtkWidget PTR
DECLARE SUB gtk_widget_set_parent_window(BYVAL AS GtkWidget PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gtk_widget_get_parent_window(BYVAL AS GtkWidget PTR) AS GdkWindow PTR
DECLARE SUB gtk_widget_set_child_visible(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_child_visible(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_window(BYVAL AS GtkWidget PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gtk_widget_get_window(BYVAL AS GtkWidget PTR) AS GdkWindow PTR
DECLARE FUNCTION gtk_widget_get_allocated_width(BYVAL AS GtkWidget PTR) AS INTEGER
DECLARE FUNCTION gtk_widget_get_allocated_height(BYVAL AS GtkWidget PTR) AS INTEGER
DECLARE SUB gtk_widget_get_allocation(BYVAL AS GtkWidget PTR, BYVAL AS GtkAllocation PTR)
DECLARE SUB gtk_widget_set_allocation(BYVAL AS GtkWidget PTR, BYVAL AS CONST GtkAllocation PTR)
DECLARE SUB gtk_widget_get_requisition(BYVAL AS GtkWidget PTR, BYVAL AS GtkRequisition PTR)
DECLARE FUNCTION gtk_widget_child_focus(BYVAL AS GtkWidget PTR, BYVAL AS GtkDirectionType) AS gboolean
DECLARE FUNCTION gtk_widget_keynav_failed(BYVAL AS GtkWidget PTR, BYVAL AS GtkDirectionType) AS gboolean
DECLARE SUB gtk_widget_error_bell(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_size_request(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_widget_get_size_request(BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_widget_set_events(BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE SUB gtk_widget_add_events(BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE SUB gtk_widget_set_device_events(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR, BYVAL AS GdkEventMask)
DECLARE SUB gtk_widget_add_device_events(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR, BYVAL AS GdkEventMask)
DECLARE SUB gtk_widget_set_device_enabled(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_device_enabled(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR) AS gboolean
DECLARE FUNCTION gtk_widget_get_toplevel(BYVAL AS GtkWidget PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_widget_get_ancestor(BYVAL AS GtkWidget PTR, BYVAL AS GType) AS GtkWidget PTR
DECLARE FUNCTION gtk_widget_get_visual(BYVAL AS GtkWidget PTR) AS GdkVisual PTR
DECLARE SUB gtk_widget_set_visual(BYVAL AS GtkWidget PTR, BYVAL AS GdkVisual PTR)
DECLARE FUNCTION gtk_widget_get_screen(BYVAL AS GtkWidget PTR) AS GdkScreen PTR
DECLARE FUNCTION gtk_widget_has_screen(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_get_display(BYVAL AS GtkWidget PTR) AS GdkDisplay PTR
DECLARE FUNCTION gtk_widget_get_root_window(BYVAL AS GtkWidget PTR) AS GdkWindow PTR
DECLARE FUNCTION gtk_widget_get_settings(BYVAL AS GtkWidget PTR) AS GtkSettings PTR
DECLARE FUNCTION gtk_widget_get_clipboard(BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom) AS GtkClipboard PTR
DECLARE FUNCTION gtk_widget_get_hexpand(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_hexpand(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_hexpand_set(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_hexpand_set(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_vexpand(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_vexpand(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_vexpand_set(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_vexpand_set(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE SUB gtk_widget_queue_compute_expand(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_widget_compute_expand(BYVAL AS GtkWidget PTR, BYVAL AS GtkOrientation) AS gboolean
DECLARE FUNCTION gtk_widget_get_support_multidevice(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_support_multidevice(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE SUB gtk_widget_class_set_accessible_type(BYVAL AS GtkWidgetClass PTR, BYVAL AS GType)
DECLARE SUB gtk_widget_class_set_accessible_role(BYVAL AS GtkWidgetClass PTR, BYVAL AS AtkRole)
DECLARE FUNCTION gtk_widget_get_accessible(BYVAL AS GtkWidget PTR) AS AtkObject PTR
DECLARE FUNCTION gtk_widget_get_halign(BYVAL AS GtkWidget PTR) AS GtkAlign
DECLARE SUB gtk_widget_set_halign(BYVAL AS GtkWidget PTR, BYVAL AS GtkAlign)
DECLARE FUNCTION gtk_widget_get_valign(BYVAL AS GtkWidget PTR) AS GtkAlign
DECLARE SUB gtk_widget_set_valign(BYVAL AS GtkWidget PTR, BYVAL AS GtkAlign)
DECLARE FUNCTION gtk_widget_get_margin_left(BYVAL AS GtkWidget PTR) AS gint
DECLARE SUB gtk_widget_set_margin_left(BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_widget_get_margin_right(BYVAL AS GtkWidget PTR) AS gint
DECLARE SUB gtk_widget_set_margin_right(BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_widget_get_margin_top(BYVAL AS GtkWidget PTR) AS gint
DECLARE SUB gtk_widget_set_margin_top(BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_widget_get_margin_bottom(BYVAL AS GtkWidget PTR) AS gint
DECLARE SUB gtk_widget_set_margin_bottom(BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_widget_get_events(BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_widget_get_device_events(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR) AS GdkEventMask
DECLARE SUB gtk_widget_get_pointer(BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_widget_is_ancestor(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_translate_coordinates(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_widget_hide_on_delete(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_override_color(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateFlags, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_widget_override_background_color(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateFlags, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_widget_override_font(BYVAL AS GtkWidget PTR, BYVAL AS CONST PangoFontDescription PTR)
DECLARE SUB gtk_widget_override_symbolic_color(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_widget_override_cursor(BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRGBA PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_widget_reset_style(BYVAL AS GtkWidget PTR)

#IF NOT DEFINED(GTK_DISABLE_DEPRECATED) OR DEFINED(GTK_COMPILATION)

DECLARE SUB gtk_widget_style_attach(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_widget_has_rc_style(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_set_style(BYVAL AS GtkWidget PTR, BYVAL AS GtkStyle PTR)
DECLARE SUB gtk_widget_ensure_style(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_widget_get_style(BYVAL AS GtkWidget PTR) AS GtkStyle PTR
DECLARE SUB gtk_widget_modify_style(BYVAL AS GtkWidget PTR, BYVAL AS GtkRcStyle PTR)
DECLARE FUNCTION gtk_widget_get_modifier_style(BYVAL AS GtkWidget PTR) AS GtkRcStyle PTR
DECLARE SUB gtk_widget_modify_fg(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateType, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_widget_modify_bg(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateType, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_widget_modify_text(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateType, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_widget_modify_base(BYVAL AS GtkWidget PTR, BYVAL AS GtkStateType, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_widget_modify_cursor(BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_widget_modify_font(BYVAL AS GtkWidget PTR, BYVAL AS PangoFontDescription PTR)
DECLARE SUB gtk_widget_reset_rc_styles(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_widget_get_default_style() AS GtkStyle PTR
DECLARE SUB gtk_widget_path(BYVAL AS GtkWidget PTR, BYVAL AS guint PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR)
DECLARE SUB gtk_widget_class_path(BYVAL AS GtkWidget PTR, BYVAL AS guint PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR)
DECLARE FUNCTION gtk_widget_render_icon(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize, BYVAL AS CONST gchar PTR) AS GdkPixbuf PTR

#ENDIF ' NOT DEFINED(GTK...

DECLARE FUNCTION gtk_widget_create_pango_context(BYVAL AS GtkWidget PTR) AS PangoContext PTR
DECLARE FUNCTION gtk_widget_get_pango_context(BYVAL AS GtkWidget PTR) AS PangoContext PTR
DECLARE FUNCTION gtk_widget_create_pango_layout(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS PangoLayout PTR
DECLARE FUNCTION gtk_widget_render_icon_pixbuf(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize) AS GdkPixbuf PTR
DECLARE SUB gtk_widget_set_composite_name(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_widget_get_composite_name(BYVAL AS GtkWidget PTR) AS gchar PTR
DECLARE SUB gtk_widget_push_composite_child()
DECLARE SUB gtk_widget_pop_composite_child()
DECLARE SUB gtk_widget_class_install_style_property(BYVAL AS GtkWidgetClass PTR, BYVAL AS GParamSpec PTR)
DECLARE SUB gtk_widget_class_install_style_property_parser(BYVAL AS GtkWidgetClass PTR, BYVAL AS GParamSpec PTR, BYVAL AS GtkRcPropertyParser)
DECLARE FUNCTION gtk_widget_class_find_style_property(BYVAL AS GtkWidgetClass PTR, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION gtk_widget_class_list_style_properties(BYVAL AS GtkWidgetClass PTR, BYVAL AS guint PTR) AS GParamSpec PTR PTR
DECLARE SUB gtk_widget_style_get_property(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB gtk_widget_style_get_valist(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB gtk_widget_style_get(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_widget_set_direction(BYVAL AS GtkWidget PTR, BYVAL AS GtkTextDirection)
DECLARE FUNCTION gtk_widget_get_direction(BYVAL AS GtkWidget PTR) AS GtkTextDirection
DECLARE SUB gtk_widget_set_default_direction(BYVAL AS GtkTextDirection)
DECLARE FUNCTION gtk_widget_get_default_direction() AS GtkTextDirection
DECLARE FUNCTION gtk_widget_is_composited(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_widget_shape_combine_region(BYVAL AS GtkWidget PTR, BYVAL AS cairo_region_t PTR)
DECLARE SUB gtk_widget_input_shape_combine_region(BYVAL AS GtkWidget PTR, BYVAL AS cairo_region_t PTR)
DECLARE FUNCTION gtk_widget_list_mnemonic_labels(BYVAL AS GtkWidget PTR) AS GList PTR
DECLARE SUB gtk_widget_add_mnemonic_label(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_remove_mnemonic_label(BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_tooltip_window(BYVAL AS GtkWidget PTR, BYVAL AS GtkWindow PTR)
DECLARE FUNCTION gtk_widget_get_tooltip_window(BYVAL AS GtkWidget PTR) AS GtkWindow PTR
DECLARE SUB gtk_widget_trigger_tooltip_query(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_widget_set_tooltip_text(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_widget_get_tooltip_text(BYVAL AS GtkWidget PTR) AS gchar PTR
DECLARE SUB gtk_widget_set_tooltip_markup(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_widget_get_tooltip_markup(BYVAL AS GtkWidget PTR) AS gchar PTR
DECLARE SUB gtk_widget_set_has_tooltip(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_widget_get_has_tooltip(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_cairo_should_draw_window(BYVAL AS cairo_t PTR, BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gtk_cairo_transform_to_window(BYVAL AS cairo_t PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gtk_requisition_get_type() AS GType
DECLARE FUNCTION gtk_requisition_new() AS GtkRequisition PTR
DECLARE FUNCTION gtk_requisition_copy(BYVAL AS CONST GtkRequisition PTR) AS GtkRequisition PTR
DECLARE SUB gtk_requisition_free(BYVAL AS GtkRequisition PTR)
DECLARE FUNCTION gtk_widget_in_destruction(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE FUNCTION gtk_widget_get_style_context(BYVAL AS GtkWidget PTR) AS GtkStyleContext PTR
DECLARE FUNCTION gtk_widget_get_path(BYVAL AS GtkWidget PTR) AS GtkWidgetPath PTR

#ENDIF ' __GTK_WIDGET_H__

#DEFINE GTK_TYPE_ACTION (gtk_action_get_type ())
#DEFINE GTK_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACTION, GtkAction))
#DEFINE GTK_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACTION, GtkActionClass))
#DEFINE GTK_IS_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACTION))
#DEFINE GTK_IS_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACTION))
#DEFINE GTK_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_ACTION, GtkActionClass))

TYPE GtkAction AS _GtkAction
TYPE GtkActionClass AS _GtkActionClass
TYPE GtkActionPrivate AS _GtkActionPrivate

TYPE _GtkAction
  AS GObject object
  AS GtkActionPrivate PTR private_data
END TYPE

TYPE _GtkActionClass
  AS GObjectClass parent_class
  activate AS SUB(BYVAL AS GtkAction PTR)
  AS GType menu_item_type
  AS GType toolbar_item_type
  create_menu_item AS FUNCTION(BYVAL AS GtkAction PTR) AS GtkWidget PTR
  create_tool_item AS FUNCTION(BYVAL AS GtkAction PTR) AS GtkWidget PTR
  connect_proxy AS SUB(BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
  disconnect_proxy AS SUB(BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
  create_menu AS FUNCTION(BYVAL AS GtkAction PTR) AS GtkWidget PTR
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_action_get_type() AS GType
DECLARE FUNCTION gtk_action_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GtkAction PTR
DECLARE FUNCTION gtk_action_get_name(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_action_is_sensitive(BYVAL AS GtkAction PTR) AS gboolean
DECLARE FUNCTION gtk_action_get_sensitive(BYVAL AS GtkAction PTR) AS gboolean
DECLARE SUB gtk_action_set_sensitive(BYVAL AS GtkAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_is_visible(BYVAL AS GtkAction PTR) AS gboolean
DECLARE FUNCTION gtk_action_get_visible(BYVAL AS GtkAction PTR) AS gboolean
DECLARE SUB gtk_action_set_visible(BYVAL AS GtkAction PTR, BYVAL AS gboolean)
DECLARE SUB gtk_action_activate(BYVAL AS GtkAction PTR)
DECLARE FUNCTION gtk_action_create_icon(BYVAL AS GtkAction PTR, BYVAL AS GtkIconSize) AS GtkWidget PTR
DECLARE FUNCTION gtk_action_create_menu_item(BYVAL AS GtkAction PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_action_create_tool_item(BYVAL AS GtkAction PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_action_create_menu(BYVAL AS GtkAction PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_action_get_proxies(BYVAL AS GtkAction PTR) AS GSList PTR
DECLARE SUB gtk_action_connect_accelerator(BYVAL AS GtkAction PTR)
DECLARE SUB gtk_action_disconnect_accelerator(BYVAL AS GtkAction PTR)
DECLARE FUNCTION gtk_action_get_accel_path(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_action_get_accel_closure(BYVAL AS GtkAction PTR) AS GClosure PTR
DECLARE SUB gtk_action_block_activate(BYVAL AS GtkAction PTR)
DECLARE SUB gtk_action_unblock_activate(BYVAL AS GtkAction PTR)
DECLARE SUB _gtk_action_add_to_proxy_list(BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_action_remove_from_proxy_list(BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_action_emit_activate(BYVAL AS GtkAction PTR)
DECLARE SUB gtk_action_set_accel_path(BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_action_set_accel_group(BYVAL AS GtkAction PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE SUB _gtk_action_sync_menu_visible(BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE SUB gtk_action_set_label(BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_action_get_label(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE SUB gtk_action_set_short_label(BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_action_get_short_label(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE SUB gtk_action_set_tooltip(BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_action_get_tooltip(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE SUB gtk_action_set_stock_id(BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_action_get_stock_id(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE SUB gtk_action_set_gicon(BYVAL AS GtkAction PTR, BYVAL AS GIcon PTR)
DECLARE FUNCTION gtk_action_get_gicon(BYVAL AS GtkAction PTR) AS GIcon PTR
DECLARE SUB gtk_action_set_icon_name(BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_action_get_icon_name(BYVAL AS GtkAction PTR) AS CONST gchar PTR
DECLARE SUB gtk_action_set_visible_horizontal(BYVAL AS GtkAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_get_visible_horizontal(BYVAL AS GtkAction PTR) AS gboolean
DECLARE SUB gtk_action_set_visible_vertical(BYVAL AS GtkAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_get_visible_vertical(BYVAL AS GtkAction PTR) AS gboolean
DECLARE SUB gtk_action_set_is_important(BYVAL AS GtkAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_get_is_important(BYVAL AS GtkAction PTR) AS gboolean
DECLARE SUB gtk_action_set_always_show_image(BYVAL AS GtkAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_get_always_show_image(BYVAL AS GtkAction PTR) AS gboolean

#ENDIF ' __GTK_ACTION_H__

#IFNDEF __GTK_STOCK_H__
#DEFINE __GTK_STOCK_H__

TYPE GtkTranslateFunc AS FUNCTION(BYVAL AS CONST gchar PTR, BYVAL AS gpointer) AS gchar PTR
TYPE GtkStockItem AS _GtkStockItem

TYPE _GtkStockItem
  AS gchar PTR stock_id
  AS gchar PTR label
  AS GdkModifierType modifier
  AS guint keyval
  AS gchar PTR translation_domain
END TYPE

DECLARE SUB gtk_stock_add_ ALIAS "gtk_stock_add"(BYVAL AS CONST GtkStockItem PTR, BYVAL AS guint)
DECLARE SUB gtk_stock_add_static(BYVAL AS CONST GtkStockItem PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_stock_lookup(BYVAL AS CONST gchar PTR, BYVAL AS GtkStockItem PTR) AS gboolean
DECLARE FUNCTION gtk_stock_list_ids() AS GSList PTR
DECLARE FUNCTION gtk_stock_item_copy(BYVAL AS CONST GtkStockItem PTR) AS GtkStockItem PTR
DECLARE SUB gtk_stock_item_free(BYVAL AS GtkStockItem PTR)
DECLARE SUB gtk_stock_set_translate_func(BYVAL AS CONST gchar PTR, BYVAL AS GtkTranslateFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)

#DEFINE GTK_STOCK_ABOUT !"gtk-about"
#DEFINE GTK_STOCK_ADD !"gtk-add"
#DEFINE GTK_STOCK_APPLY !"gtk-apply"
#DEFINE GTK_STOCK_BOLD !"gtk-bold"
#DEFINE GTK_STOCK_CANCEL !"gtk-cancel"
#DEFINE GTK_STOCK_CAPS_LOCK_WARNING !"gtk-caps-lock-warning"
#DEFINE GTK_STOCK_CDROM !"gtk-cdrom"
#DEFINE GTK_STOCK_CLEAR !"gtk-clear"
#DEFINE GTK_STOCK_CLOSE !"gtk-close"
#DEFINE GTK_STOCK_COLOR_PICKER !"gtk-color-picker"
#DEFINE GTK_STOCK_CONNECT !"gtk-connect"
#DEFINE GTK_STOCK_CONVERT !"gtk-convert"
#DEFINE GTK_STOCK_COPY !"gtk-copy"
#DEFINE GTK_STOCK_CUT !"gtk-cut"
#DEFINE GTK_STOCK_DELETE !"gtk-delete"
#DEFINE GTK_STOCK_DIALOG_AUTHENTICATION !"gtk-dialog-authentication"
#DEFINE GTK_STOCK_DIALOG_INFO !"gtk-dialog-info"
#DEFINE GTK_STOCK_DIALOG_WARNING !"gtk-dialog-warning"
#DEFINE GTK_STOCK_DIALOG_ERROR !"gtk-dialog-error"
#DEFINE GTK_STOCK_DIALOG_QUESTION !"gtk-dialog-question"
#DEFINE GTK_STOCK_DIRECTORY !"gtk-directory"
#DEFINE GTK_STOCK_DISCARD !"gtk-discard"
#DEFINE GTK_STOCK_DISCONNECT !"gtk-disconnect"
#DEFINE GTK_STOCK_DND !"gtk-dnd"
#DEFINE GTK_STOCK_DND_MULTIPLE !"gtk-dnd-multiple"
#DEFINE GTK_STOCK_EDIT !"gtk-edit"
#DEFINE GTK_STOCK_EXECUTE !"gtk-execute"
#DEFINE GTK_STOCK_FILE !"gtk-file"
#DEFINE GTK_STOCK_FIND !"gtk-find"
#DEFINE GTK_STOCK_FIND_AND_REPLACE !"gtk-find-and-replace"
#DEFINE GTK_STOCK_FLOPPY !"gtk-floppy"
#DEFINE GTK_STOCK_FULLSCREEN !"gtk-fullscreen"
#DEFINE GTK_STOCK_GOTO_BOTTOM !"gtk-goto-bottom"
#DEFINE GTK_STOCK_GOTO_FIRST !"gtk-goto-first"
#DEFINE GTK_STOCK_GOTO_LAST !"gtk-goto-last"
#DEFINE GTK_STOCK_GOTO_TOP !"gtk-goto-top"
#DEFINE GTK_STOCK_GO_BACK !"gtk-go-back"
#DEFINE GTK_STOCK_GO_DOWN !"gtk-go-down"
#DEFINE GTK_STOCK_GO_FORWARD !"gtk-go-forward"
#DEFINE GTK_STOCK_GO_UP !"gtk-go-up"
#DEFINE GTK_STOCK_HARDDISK !"gtk-harddisk"
#DEFINE GTK_STOCK_HELP !"gtk-help"
#DEFINE GTK_STOCK_HOME !"gtk-home"
#DEFINE GTK_STOCK_INDEX !"gtk-index"
#DEFINE GTK_STOCK_INDENT !"gtk-indent"
#DEFINE GTK_STOCK_INFO !"gtk-info"
#DEFINE GTK_STOCK_ITALIC !"gtk-italic"
#DEFINE GTK_STOCK_JUMP_TO !"gtk-jump-to"
#DEFINE GTK_STOCK_JUSTIFY_CENTER !"gtk-justify-center"
#DEFINE GTK_STOCK_JUSTIFY_FILL !"gtk-justify-fill"
#DEFINE GTK_STOCK_JUSTIFY_LEFT !"gtk-justify-left"
#DEFINE GTK_STOCK_JUSTIFY_RIGHT !"gtk-justify-right"
#DEFINE GTK_STOCK_LEAVE_FULLSCREEN !"gtk-leave-fullscreen"
#DEFINE GTK_STOCK_MISSING_IMAGE !"gtk-missing-image"
#DEFINE GTK_STOCK_MEDIA_FORWARD !"gtk-media-forward"
#DEFINE GTK_STOCK_MEDIA_NEXT !"gtk-media-next"
#DEFINE GTK_STOCK_MEDIA_PAUSE !"gtk-media-pause"
#DEFINE GTK_STOCK_MEDIA_PLAY !"gtk-media-play"
#DEFINE GTK_STOCK_MEDIA_PREVIOUS !"gtk-media-previous"
#DEFINE GTK_STOCK_MEDIA_RECORD !"gtk-media-record"
#DEFINE GTK_STOCK_MEDIA_REWIND !"gtk-media-rewind"
#DEFINE GTK_STOCK_MEDIA_STOP !"gtk-media-stop"
#DEFINE GTK_STOCK_NETWORK !"gtk-network"
#DEFINE GTK_STOCK_NEW !"gtk-new"
#DEFINE GTK_STOCK_NO !"gtk-no"
#DEFINE GTK_STOCK_OK !"gtk-ok"
#DEFINE GTK_STOCK_OPEN !"gtk-open"
#DEFINE GTK_STOCK_ORIENTATION_PORTRAIT !"gtk-orientation-portrait"
#DEFINE GTK_STOCK_ORIENTATION_LANDSCAPE !"gtk-orientation-landscape"
#DEFINE GTK_STOCK_ORIENTATION_REVERSE_LANDSCAPE !"gtk-orientation-reverse-landscape"
#DEFINE GTK_STOCK_ORIENTATION_REVERSE_PORTRAIT !"gtk-orientation-reverse-portrait"
#DEFINE GTK_STOCK_PAGE_SETUP !"gtk-page-setup"
#DEFINE GTK_STOCK_PASTE !"gtk-paste"
#DEFINE GTK_STOCK_PREFERENCES !"gtk-preferences"
#DEFINE GTK_STOCK_PRINT !"gtk-print"
#DEFINE GTK_STOCK_PRINT_ERROR !"gtk-print-error"
#DEFINE GTK_STOCK_PRINT_PAUSED !"gtk-print-paused"
#DEFINE GTK_STOCK_PRINT_PREVIEW !"gtk-print-preview"
#DEFINE GTK_STOCK_PRINT_REPORT !"gtk-print-report"
#DEFINE GTK_STOCK_PRINT_WARNING !"gtk-print-warning"
#DEFINE GTK_STOCK_PROPERTIES !"gtk-properties"
#DEFINE GTK_STOCK_QUIT !"gtk-quit"
#DEFINE GTK_STOCK_REDO !"gtk-redo"
#DEFINE GTK_STOCK_REFRESH !"gtk-refresh"
#DEFINE GTK_STOCK_REMOVE !"gtk-remove"
#DEFINE GTK_STOCK_REVERT_TO_SAVED !"gtk-revert-to-saved"
#DEFINE GTK_STOCK_SAVE !"gtk-save"
#DEFINE GTK_STOCK_SAVE_AS !"gtk-save-as"
#DEFINE GTK_STOCK_SELECT_ALL !"gtk-select-all"
#DEFINE GTK_STOCK_SELECT_COLOR !"gtk-select-color"
#DEFINE GTK_STOCK_SELECT_FONT !"gtk-select-font"
#DEFINE GTK_STOCK_SORT_ASCENDING !"gtk-sort-ascending"
#DEFINE GTK_STOCK_SORT_DESCENDING !"gtk-sort-descending"
#DEFINE GTK_STOCK_SPELL_CHECK !"gtk-spell-check"
#DEFINE GTK_STOCK_STOP !"gtk-stop"
#DEFINE GTK_STOCK_STRIKETHROUGH !"gtk-strikethrough"
#DEFINE GTK_STOCK_UNDELETE !"gtk-undelete"
#DEFINE GTK_STOCK_UNDERLINE !"gtk-underline"
#DEFINE GTK_STOCK_UNDO !"gtk-undo"
#DEFINE GTK_STOCK_UNINDENT !"gtk-unindent"
#DEFINE GTK_STOCK_YES !"gtk-yes"
#DEFINE GTK_STOCK_ZOOM_100 !"gtk-zoom-100"
#DEFINE GTK_STOCK_ZOOM_FIT !"gtk-zoom-fit"
#DEFINE GTK_STOCK_ZOOM_IN !"gtk-zoom-in"
#DEFINE GTK_STOCK_ZOOM_OUT !"gtk-zoom-out"
#ENDIF ' __GTK_STOCK_H__

#DEFINE GTK_TYPE_ACTION_GROUP (gtk_action_group_get_type ())
#DEFINE GTK_ACTION_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACTION_GROUP, GtkActionGroup))
#DEFINE GTK_ACTION_GROUP_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_ACTION_GROUP, GtkActionGroupClass))
#DEFINE GTK_IS_ACTION_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACTION_GROUP))
#DEFINE GTK_IS_ACTION_GROUP_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_ACTION_GROUP))
#DEFINE GTK_ACTION_GROUP_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_ACTION_GROUP, GtkActionGroupClass))

TYPE GtkActionGroup AS _GtkActionGroup
TYPE GtkActionGroupPrivate AS _GtkActionGroupPrivate
TYPE GtkActionGroupClass AS _GtkActionGroupClass
TYPE GtkActionEntry AS _GtkActionEntry
TYPE GtkToggleActionEntry AS _GtkToggleActionEntry
TYPE GtkRadioActionEntry AS _GtkRadioActionEntry

TYPE _GtkActionGroup
  AS GObject parent
  AS GtkActionGroupPrivate PTR priv
END TYPE

TYPE _GtkActionGroupClass
  AS GObjectClass parent_class
  get_action AS FUNCTION(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST gchar PTR) AS GtkAction PTR
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE _GtkActionEntry
  AS CONST gchar PTR name
  AS CONST gchar PTR stock_id
  AS CONST gchar PTR label
  AS CONST gchar PTR accelerator
  AS CONST gchar PTR tooltip
  AS GCallback callback
END TYPE

TYPE _GtkToggleActionEntry
  AS CONST gchar PTR name
  AS CONST gchar PTR stock_id
  AS CONST gchar PTR label
  AS CONST gchar PTR accelerator
  AS CONST gchar PTR tooltip
  AS GCallback callback
  AS gboolean is_active
END TYPE

TYPE _GtkRadioActionEntry
  AS CONST gchar PTR name
  AS CONST gchar PTR stock_id
  AS CONST gchar PTR label
  AS CONST gchar PTR accelerator
  AS CONST gchar PTR tooltip
  AS gint value
END TYPE

DECLARE FUNCTION gtk_action_group_get_type() AS GType
DECLARE FUNCTION gtk_action_group_new(BYVAL AS CONST gchar PTR) AS GtkActionGroup PTR
DECLARE FUNCTION gtk_action_group_get_name(BYVAL AS GtkActionGroup PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_action_group_get_sensitive(BYVAL AS GtkActionGroup PTR) AS gboolean
DECLARE SUB gtk_action_group_set_sensitive(BYVAL AS GtkActionGroup PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_group_get_visible(BYVAL AS GtkActionGroup PTR) AS gboolean
DECLARE SUB gtk_action_group_set_visible(BYVAL AS GtkActionGroup PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_action_group_get_action(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST gchar PTR) AS GtkAction PTR
DECLARE FUNCTION gtk_action_group_list_actions(BYVAL AS GtkActionGroup PTR) AS GList PTR
DECLARE SUB gtk_action_group_add_action(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR)
DECLARE SUB gtk_action_group_add_action_with_accel(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_action_group_remove_action(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR)
DECLARE SUB gtk_action_group_add_actions(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST GtkActionEntry PTR, BYVAL AS guint, BYVAL AS gpointer)
DECLARE SUB gtk_action_group_add_toggle_actions(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST GtkToggleActionEntry PTR, BYVAL AS guint, BYVAL AS gpointer)
DECLARE SUB gtk_action_group_add_radio_actions(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST GtkRadioActionEntry PTR, BYVAL AS guint, BYVAL AS gint, BYVAL AS GCallback, BYVAL AS gpointer)
DECLARE SUB gtk_action_group_add_actions_full(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST GtkActionEntry PTR, BYVAL AS guint, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_action_group_add_toggle_actions_full(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST GtkToggleActionEntry PTR, BYVAL AS guint, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_action_group_add_radio_actions_full(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST GtkRadioActionEntry PTR, BYVAL AS guint, BYVAL AS gint, BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_action_group_set_translate_func(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkTranslateFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_action_group_set_translation_domain(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_action_group_translate_string(BYVAL AS GtkActionGroup PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE SUB _gtk_action_group_emit_connect_proxy(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_action_group_emit_disconnect_proxy(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_action_group_emit_pre_activate(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR)
DECLARE SUB _gtk_action_group_emit_post_activate(BYVAL AS GtkActionGroup PTR, BYVAL AS GtkAction PTR)

#ENDIF ' __GTK_ACTION_GROUP_H__

#INCLUDE ONCE "gio/gio.bi"
#DEFINE GTK_TYPE_APPLICATION (gtk_application_get_type ())
#DEFINE GTK_APPLICATION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_APPLICATION, GtkApplication))
#DEFINE GTK_APPLICATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_APPLICATION, GtkApplicationClass))
#DEFINE GTK_IS_APPLICATION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_APPLICATION))
#DEFINE GTK_IS_APPLICATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_APPLICATION))
#DEFINE GTK_APPLICATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_APPLICATION, GtkApplicationClass))

TYPE GtkApplication AS _GtkApplication
TYPE GtkApplicationClass AS _GtkApplicationClass
TYPE GtkApplicationPrivate AS _GtkApplicationPrivate

TYPE _GtkApplication
  AS GApplication parent
  AS GtkApplicationPrivate PTR priv
END TYPE

TYPE _GtkApplicationClass
  AS GApplicationClass parent_class
  window_added AS SUB(BYVAL AS GtkApplication PTR, BYVAL AS GtkWindow PTR)
  window_removed AS SUB(BYVAL AS GtkApplication PTR, BYVAL AS GtkWindow PTR)
  AS gpointer padding(13)
END TYPE

DECLARE FUNCTION gtk_application_get_type() AS GType
DECLARE FUNCTION gtk_application_new(BYVAL AS CONST gchar PTR, BYVAL AS GApplicationFlags) AS GtkApplication PTR
DECLARE SUB gtk_application_add_window(BYVAL AS GtkApplication PTR, BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_application_remove_window(BYVAL AS GtkApplication PTR, BYVAL AS GtkWindow PTR)
DECLARE FUNCTION gtk_application_get_windows(BYVAL AS GtkApplication PTR) AS GList PTR

#ENDIF ' __GTK_APPLICATION_H__

#IFNDEF __GTK_BIN_H__
#DEFINE __GTK_BIN_H__

#IFNDEF __GTK_CONTAINER_H__
#DEFINE __GTK_CONTAINER_H__

#DEFINE GTK_TYPE_CONTAINER (gtk_container_get_type ())
#DEFINE GTK_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CONTAINER, GtkContainer))
#DEFINE GTK_CONTAINER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CONTAINER, GtkContainerClass))
#DEFINE GTK_IS_CONTAINER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CONTAINER))
#DEFINE GTK_IS_CONTAINER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CONTAINER))
#DEFINE GTK_CONTAINER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CONTAINER, GtkContainerClass))

TYPE GtkContainer AS _GtkContainer
TYPE GtkContainerPrivate AS _GtkContainerPrivate
TYPE GtkContainerClass AS _GtkContainerClass

TYPE _GtkContainer
  AS GtkWidget widget
  AS GtkContainerPrivate PTR priv
END TYPE

TYPE _GtkContainerClass
  AS GtkWidgetClass parent_class
  add_ AS SUB(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR)
  remove AS SUB(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR)
  check_resize AS SUB(BYVAL AS GtkContainer PTR)
  forall AS SUB(BYVAL AS GtkContainer PTR, BYVAL AS gboolean, BYVAL AS GtkCallback, BYVAL AS gpointer)
  set_focus_child AS SUB(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR)
  child_type AS FUNCTION(BYVAL AS GtkContainer PTR) AS GType
  composite_name AS FUNCTION(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR) AS gchar PTR
  set_child_property AS SUB(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS GParamSpec PTR)
  get_child_property AS SUB(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
  get_path_for_child AS FUNCTION(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR) AS GtkWidgetPath PTR
  AS UINTEGER _handle_border_width : 1
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_container_get_type() AS GType
DECLARE SUB gtk_container_set_border_width(BYVAL AS GtkContainer PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_container_get_border_width(BYVAL AS GtkContainer PTR) AS guint
DECLARE SUB gtk_container_add(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_container_remove(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_container_set_resize_mode(BYVAL AS GtkContainer PTR, BYVAL AS GtkResizeMode)
DECLARE FUNCTION gtk_container_get_resize_mode(BYVAL AS GtkContainer PTR) AS GtkResizeMode
DECLARE SUB gtk_container_check_resize(BYVAL AS GtkContainer PTR)
DECLARE SUB gtk_container_foreach(BYVAL AS GtkContainer PTR, BYVAL AS GtkCallback, BYVAL AS gpointer)
DECLARE FUNCTION gtk_container_get_children(BYVAL AS GtkContainer PTR) AS GList PTR
DECLARE SUB gtk_container_propagate_draw(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS cairo_t PTR)
DECLARE SUB gtk_container_set_focus_chain(BYVAL AS GtkContainer PTR, BYVAL AS GList PTR)
DECLARE FUNCTION gtk_container_get_focus_chain(BYVAL AS GtkContainer PTR, BYVAL AS GList PTR PTR) AS gboolean
DECLARE SUB gtk_container_unset_focus_chain(BYVAL AS GtkContainer PTR)

#DEFINE GTK_IS_RESIZE_CONTAINER(widget) (GTK_IS_CONTAINER (widget) ANDALSO _
                                        (gtk_container_get_resize_mode (GTK_CONTAINER (widget)) <> GTK_RESIZE_PARENT))

DECLARE SUB gtk_container_set_reallocate_redraws(BYVAL AS GtkContainer PTR, BYVAL AS gboolean)
DECLARE SUB gtk_container_set_focus_child(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_container_get_focus_child(BYVAL AS GtkContainer PTR) AS GtkWidget PTR
DECLARE SUB gtk_container_set_focus_vadjustment(BYVAL AS GtkContainer PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_container_get_focus_vadjustment(BYVAL AS GtkContainer PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_container_set_focus_hadjustment(BYVAL AS GtkContainer PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_container_get_focus_hadjustment(BYVAL AS GtkContainer PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_container_resize_children(BYVAL AS GtkContainer PTR)
DECLARE FUNCTION gtk_container_child_type(BYVAL AS GtkContainer PTR) AS GType
DECLARE SUB gtk_container_class_install_child_property(BYVAL AS GtkContainerClass PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION gtk_container_class_find_child_property(BYVAL AS GObjectClass PTR, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION gtk_container_class_list_child_properties(BYVAL AS GObjectClass PTR, BYVAL AS guint PTR) AS GParamSpec PTR PTR
DECLARE SUB gtk_container_add_with_properties(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_container_child_set(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_container_child_get(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_container_child_set_valist(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB gtk_container_child_get_valist(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB gtk_container_child_set_property(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
DECLARE SUB gtk_container_child_get_property(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB gtk_container_child_notify(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)

#DEFINE GTK_CONTAINER_WARN_INVALID_CHILD_PROPERTY_ID(object, property_id, pspec) _
    G_OBJECT_WARN_INVALID_PSPEC ((object), !"child property id", (property_id), (pspec))

DECLARE SUB gtk_container_forall(BYVAL AS GtkContainer PTR, BYVAL AS GtkCallback, BYVAL AS gpointer)
DECLARE SUB gtk_container_class_handle_border_width(BYVAL AS GtkContainerClass PTR)
DECLARE FUNCTION gtk_container_get_path_for_child(BYVAL AS GtkContainer PTR, BYVAL AS GtkWidget PTR) AS GtkWidgetPath PTR

#ENDIF ' __GTK_CONTAINER_H__

#DEFINE GTK_TYPE_BIN (gtk_bin_get_type ())
#DEFINE GTK_BIN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BIN, GtkBin))
#DEFINE GTK_BIN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BIN, GtkBinClass))
#DEFINE GTK_IS_BIN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BIN))
#DEFINE GTK_IS_BIN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BIN))
#DEFINE GTK_BIN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BIN, GtkBinClass))

TYPE GtkBin AS _GtkBin
TYPE GtkBinPrivate AS _GtkBinPrivate
TYPE GtkBinClass AS _GtkBinClass

TYPE _GtkBin
  AS GtkContainer container
  AS GtkBinPrivate PTR priv
END TYPE

TYPE _GtkBinClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_bin_get_type() AS GType
DECLARE FUNCTION gtk_bin_get_child(BYVAL AS GtkBin PTR) AS GtkWidget PTR
DECLARE SUB _gtk_bin_set_child(BYVAL AS GtkBin PTR, BYVAL AS GtkWidget PTR)

#ENDIF ' __GTK_BIN_H__

#DEFINE GTK_TYPE_WINDOW (gtk_window_get_type ())
#DEFINE GTK_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_WINDOW, GtkWindow))
#DEFINE GTK_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WINDOW, GtkWindowClass))
#DEFINE GTK_IS_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_WINDOW))
#DEFINE GTK_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WINDOW))
#DEFINE GTK_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WINDOW, GtkWindowClass))

TYPE GtkWindowPrivate AS _GtkWindowPrivate
TYPE GtkWindowClass AS _GtkWindowClass
TYPE GtkWindowGeometryInfo AS _GtkWindowGeometryInfo
TYPE GtkWindowGroup AS _GtkWindowGroup
TYPE GtkWindowGroupClass AS _GtkWindowGroupClass
TYPE GtkWindowGroupPrivate AS _GtkWindowGroupPrivate

TYPE _GtkWindow
  AS GtkBin bin
  AS GtkWindowPrivate PTR priv
END TYPE

TYPE _GtkWindowClass
  AS GtkBinClass parent_class
  set_focus AS SUB(BYVAL AS GtkWindow PTR, BYVAL AS GtkWidget PTR)
  activate_focus AS SUB(BYVAL AS GtkWindow PTR)
  activate_default AS SUB(BYVAL AS GtkWindow PTR)
  keys_changed AS SUB(BYVAL AS GtkWindow PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

#DEFINE GTK_TYPE_WINDOW_GROUP (gtk_window_group_get_type ())
#DEFINE GTK_WINDOW_GROUP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_WINDOW_GROUP, GtkWindowGroup))
#DEFINE GTK_WINDOW_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass))
#DEFINE GTK_IS_WINDOW_GROUP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_WINDOW_GROUP))
#DEFINE GTK_IS_WINDOW_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WINDOW_GROUP))
#DEFINE GTK_WINDOW_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass))

TYPE _GtkWindowGroup
  AS GObject parent_instance
  AS GtkWindowGroupPrivate PTR priv
END TYPE

TYPE _GtkWindowGroupClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_window_get_type() AS GType
DECLARE FUNCTION gtk_window_new(BYVAL AS GtkWindowType) AS GtkWidget PTR
DECLARE SUB gtk_window_set_title(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_window_get_title(BYVAL AS GtkWindow PTR) AS CONST gchar PTR
DECLARE SUB gtk_window_set_wmclass(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_window_set_role(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_window_set_startup_id(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_window_get_role(BYVAL AS GtkWindow PTR) AS CONST gchar PTR
DECLARE SUB gtk_window_add_accel_group(BYVAL AS GtkWindow PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE SUB gtk_window_remove_accel_group(BYVAL AS GtkWindow PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE SUB gtk_window_set_position(BYVAL AS GtkWindow PTR, BYVAL AS GtkWindowPosition)
DECLARE FUNCTION gtk_window_activate_focus(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_focus(BYVAL AS GtkWindow PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_window_get_focus(BYVAL AS GtkWindow PTR) AS GtkWidget PTR
DECLARE SUB gtk_window_set_default(BYVAL AS GtkWindow PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_window_get_default_widget(BYVAL AS GtkWindow PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_window_activate_default(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_transient_for(BYVAL AS GtkWindow PTR, BYVAL AS GtkWindow PTR)
DECLARE FUNCTION gtk_window_get_transient_for(BYVAL AS GtkWindow PTR) AS GtkWindow PTR
DECLARE SUB gtk_window_set_opacity(BYVAL AS GtkWindow PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_window_get_opacity(BYVAL AS GtkWindow PTR) AS gdouble
DECLARE SUB gtk_window_set_type_hint(BYVAL AS GtkWindow PTR, BYVAL AS GdkWindowTypeHint)
DECLARE FUNCTION gtk_window_get_type_hint(BYVAL AS GtkWindow PTR) AS GdkWindowTypeHint
DECLARE SUB gtk_window_set_skip_taskbar_hint(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_skip_taskbar_hint(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_skip_pager_hint(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_skip_pager_hint(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_urgency_hint(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_urgency_hint(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_accept_focus(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_accept_focus(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_focus_on_map(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_focus_on_map(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_destroy_with_parent(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_destroy_with_parent(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_mnemonics_visible(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_mnemonics_visible(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_focus_visible(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_focus_visible(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_resizable(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_resizable(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_gravity(BYVAL AS GtkWindow PTR, BYVAL AS GdkGravity)
DECLARE FUNCTION gtk_window_get_gravity(BYVAL AS GtkWindow PTR) AS GdkGravity
DECLARE SUB gtk_window_set_geometry_hints(BYVAL AS GtkWindow PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkGeometry PTR, BYVAL AS GdkWindowHints)
DECLARE SUB gtk_window_set_screen(BYVAL AS GtkWindow PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gtk_window_get_screen(BYVAL AS GtkWindow PTR) AS GdkScreen PTR
DECLARE FUNCTION gtk_window_is_active(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE FUNCTION gtk_window_has_toplevel_focus(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_decorated(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_decorated(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_deletable(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_deletable(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_set_icon_list(BYVAL AS GtkWindow PTR, BYVAL AS GList PTR)
DECLARE FUNCTION gtk_window_get_icon_list(BYVAL AS GtkWindow PTR) AS GList PTR
DECLARE SUB gtk_window_set_icon(BYVAL AS GtkWindow PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_window_set_icon_name(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_window_set_icon_from_file(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_window_get_icon(BYVAL AS GtkWindow PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_window_get_icon_name(BYVAL AS GtkWindow PTR) AS CONST gchar PTR
DECLARE SUB gtk_window_set_default_icon_list(BYVAL AS GList PTR)
DECLARE FUNCTION gtk_window_get_default_icon_list() AS GList PTR
DECLARE SUB gtk_window_set_default_icon(BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_window_set_default_icon_name(BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_window_get_default_icon_name() AS CONST gchar PTR
DECLARE FUNCTION gtk_window_set_default_icon_from_file(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB gtk_window_set_auto_startup_notification(BYVAL AS gboolean)
DECLARE SUB gtk_window_set_modal(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_modal(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE FUNCTION gtk_window_list_toplevels() AS GList PTR
DECLARE SUB gtk_window_set_has_user_ref_count(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gtk_window_add_mnemonic(BYVAL AS GtkWindow PTR, BYVAL AS guint, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_window_remove_mnemonic(BYVAL AS GtkWindow PTR, BYVAL AS guint, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_window_mnemonic_activate(BYVAL AS GtkWindow PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE SUB gtk_window_set_mnemonic_modifier(BYVAL AS GtkWindow PTR, BYVAL AS GdkModifierType)
DECLARE FUNCTION gtk_window_get_mnemonic_modifier(BYVAL AS GtkWindow PTR) AS GdkModifierType
DECLARE FUNCTION gtk_window_activate_key(BYVAL AS GtkWindow PTR, BYVAL AS GdkEventKey PTR) AS gboolean
DECLARE FUNCTION gtk_window_propagate_key_event(BYVAL AS GtkWindow PTR, BYVAL AS GdkEventKey PTR) AS gboolean
DECLARE SUB gtk_window_present(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_present_with_time(BYVAL AS GtkWindow PTR, BYVAL AS guint32)
DECLARE SUB gtk_window_iconify(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_deiconify(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_stick(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_unstick(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_maximize(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_unmaximize(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_fullscreen(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_unfullscreen(BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_set_keep_above(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gtk_window_set_keep_below(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gtk_window_begin_resize_drag(BYVAL AS GtkWindow PTR, BYVAL AS GdkWindowEdge, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gtk_window_begin_move_drag(BYVAL AS GtkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gtk_window_set_default_size(BYVAL AS GtkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_window_get_default_size(BYVAL AS GtkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_window_resize(BYVAL AS GtkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_window_get_size(BYVAL AS GtkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_window_move(BYVAL AS GtkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_window_get_position(BYVAL AS GtkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_window_parse_geometry(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE SUB gtk_window_set_default_geometry(BYVAL AS GtkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_window_resize_to_geometry(BYVAL AS GtkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_window_get_group(BYVAL AS GtkWindow PTR) AS GtkWindowGroup PTR
DECLARE FUNCTION gtk_window_has_group(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE SUB gtk_window_reshow_with_initial_size(BYVAL AS GtkWindow PTR)
DECLARE FUNCTION gtk_window_get_window_type(BYVAL AS GtkWindow PTR) AS GtkWindowType
DECLARE FUNCTION gtk_window_group_get_type() AS GType
DECLARE FUNCTION gtk_window_group_new() AS GtkWindowGroup PTR
DECLARE SUB gtk_window_group_add_window(BYVAL AS GtkWindowGroup PTR, BYVAL AS GtkWindow PTR)
DECLARE SUB gtk_window_group_remove_window(BYVAL AS GtkWindowGroup PTR, BYVAL AS GtkWindow PTR)
DECLARE FUNCTION gtk_window_group_list_windows(BYVAL AS GtkWindowGroup PTR) AS GList PTR
DECLARE FUNCTION gtk_window_group_get_current_grab(BYVAL AS GtkWindowGroup PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_window_group_get_current_device_grab(BYVAL AS GtkWindowGroup PTR, BYVAL AS GdkDevice PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_window_get_application(BYVAL AS GtkWindow PTR) AS GtkApplication PTR
DECLARE SUB gtk_window_set_application(BYVAL AS GtkWindow PTR, BYVAL AS GtkApplication PTR)
DECLARE SUB gtk_window_set_has_resize_grip(BYVAL AS GtkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_window_get_has_resize_grip(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE FUNCTION gtk_window_resize_grip_is_visible(BYVAL AS GtkWindow PTR) AS gboolean
DECLARE FUNCTION gtk_window_get_resize_grip_area(BYVAL AS GtkWindow PTR, BYVAL AS GdkRectangle PTR) AS gboolean

#ENDIF ' __GTK_WINDOW_H__

ENUM GtkDialogFlags
  GTK_DIALOG_MODAL = 1 SHL 0
  GTK_DIALOG_DESTROY_WITH_PARENT = 1 SHL 1
END ENUM

ENUM GtkResponseType
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
END ENUM

#DEFINE GTK_TYPE_DIALOG (gtk_dialog_get_type ())
#DEFINE GTK_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_DIALOG, GtkDialog))
#DEFINE GTK_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_DIALOG, GtkDialogClass))
#DEFINE GTK_IS_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_DIALOG))
#DEFINE GTK_IS_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_DIALOG))
#DEFINE GTK_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_DIALOG, GtkDialogClass))

TYPE GtkDialog AS _GtkDialog
TYPE GtkDialogPrivate AS _GtkDialogPrivate
TYPE GtkDialogClass AS _GtkDialogClass

TYPE _GtkDialog
  AS GtkWindow window
  AS GtkDialogPrivate PTR priv
END TYPE

TYPE _GtkDialogClass
  AS GtkWindowClass parent_class
  response AS SUB(BYVAL AS GtkDialog PTR, BYVAL AS gint)
  close_ AS SUB(BYVAL AS GtkDialog PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_dialog_get_type() AS GType
DECLARE FUNCTION gtk_dialog_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_dialog_new_with_buttons(BYVAL AS CONST gchar PTR, BYVAL AS GtkWindow PTR, BYVAL AS GtkDialogFlags, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE SUB gtk_dialog_add_action_widget(BYVAL AS GtkDialog PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_dialog_add_button(BYVAL AS GtkDialog PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS GtkWidget PTR
DECLARE SUB gtk_dialog_add_buttons(BYVAL AS GtkDialog PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_dialog_set_response_sensitive(BYVAL AS GtkDialog PTR, BYVAL AS gint, BYVAL AS gboolean)
DECLARE SUB gtk_dialog_set_default_response(BYVAL AS GtkDialog PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_dialog_get_widget_for_response(BYVAL AS GtkDialog PTR, BYVAL AS gint) AS GtkWidget PTR
DECLARE FUNCTION gtk_dialog_get_response_for_widget(BYVAL AS GtkDialog PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_alternative_dialog_button_order(BYVAL AS GdkScreen PTR) AS gboolean
DECLARE SUB gtk_dialog_set_alternative_button_order(BYVAL AS GtkDialog PTR, BYVAL AS gint, ...)
DECLARE SUB gtk_dialog_set_alternative_button_order_from_array(BYVAL AS GtkDialog PTR, BYVAL AS gint, BYVAL AS gint PTR)
DECLARE SUB gtk_dialog_response(BYVAL AS GtkDialog PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_dialog_run(BYVAL AS GtkDialog PTR) AS gint
DECLARE FUNCTION gtk_dialog_get_action_area(BYVAL AS GtkDialog PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_dialog_get_content_area(BYVAL AS GtkDialog PTR) AS GtkWidget PTR

#ENDIF ' __GTK_DIALOG_H__

#DEFINE GTK_TYPE_ABOUT_DIALOG (gtk_about_dialog_get_type ())
#DEFINE GTK_ABOUT_DIALOG(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialog))
#DEFINE GTK_ABOUT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass))
#DEFINE GTK_IS_ABOUT_DIALOG(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ABOUT_DIALOG))
#DEFINE GTK_IS_ABOUT_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ABOUT_DIALOG))
#DEFINE GTK_ABOUT_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialogClass))

TYPE GtkAboutDialog AS _GtkAboutDialog
TYPE GtkAboutDialogClass AS _GtkAboutDialogClass
TYPE GtkAboutDialogPrivate AS _GtkAboutDialogPrivate

ENUM GtkLicense
  GTK_LICENSE_UNKNOWN
  GTK_LICENSE_CUSTOM
  GTK_LICENSE_GPL_2_0
  GTK_LICENSE_GPL_3_0
  GTK_LICENSE_LGPL_2_1
  GTK_LICENSE_LGPL_3_0
  GTK_LICENSE_BSD
  GTK_LICENSE_MIT_X11
  GTK_LICENSE_ARTISTIC
END ENUM

TYPE _GtkAboutDialog
  AS GtkDialog parent_instance
  AS GtkAboutDialogPrivate PTR priv
END TYPE

TYPE _GtkAboutDialogClass
  AS GtkDialogClass parent_class
  activate_link AS FUNCTION(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_about_dialog_get_type() AS GType
DECLARE FUNCTION gtk_about_dialog_new() AS GtkWidget PTR
DECLARE SUB gtk_show_about_dialog(BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION gtk_about_dialog_get_program_name(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_program_name(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_version(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_version(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_copyright(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_copyright(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_comments(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_comments(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_license(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_license(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_about_dialog_set_license_type(BYVAL AS GtkAboutDialog PTR, BYVAL AS GtkLicense)
DECLARE FUNCTION gtk_about_dialog_get_license_type(BYVAL AS GtkAboutDialog PTR) AS GtkLicense
DECLARE FUNCTION gtk_about_dialog_get_wrap_license(BYVAL AS GtkAboutDialog PTR) AS gboolean
DECLARE SUB gtk_about_dialog_set_wrap_license(BYVAL AS GtkAboutDialog PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_about_dialog_get_website(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_website(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_website_label(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_website_label(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_authors(BYVAL AS GtkAboutDialog PTR) AS CONST gchar CONST PTR PTR
DECLARE SUB gtk_about_dialog_set_authors(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR PTR)
DECLARE FUNCTION gtk_about_dialog_get_documenters(BYVAL AS GtkAboutDialog PTR) AS CONST gchar CONST PTR PTR
DECLARE SUB gtk_about_dialog_set_documenters(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR PTR)
DECLARE FUNCTION gtk_about_dialog_get_artists(BYVAL AS GtkAboutDialog PTR) AS CONST gchar CONST PTR PTR
DECLARE SUB gtk_about_dialog_set_artists(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR PTR)
DECLARE FUNCTION gtk_about_dialog_get_translator_credits(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_translator_credits(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_about_dialog_get_logo(BYVAL AS GtkAboutDialog PTR) AS GdkPixbuf PTR
DECLARE SUB gtk_about_dialog_set_logo(BYVAL AS GtkAboutDialog PTR, BYVAL AS GdkPixbuf PTR)
DECLARE FUNCTION gtk_about_dialog_get_logo_icon_name(BYVAL AS GtkAboutDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_about_dialog_set_logo_icon_name(BYVAL AS GtkAboutDialog PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_ABOUT_DIALOG_H__

#IFNDEF __GTK_ACCEL_LABEL_H__
#DEFINE __GTK_ACCEL_LABEL_H__

#IFNDEF __GTK_LABEL_H__
#DEFINE __GTK_LABEL_H__

#IFNDEF __GTK_MISC_H__
#DEFINE __GTK_MISC_H__

#DEFINE GTK_TYPE_MISC (gtk_misc_get_type ())
#DEFINE GTK_MISC(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MISC, GtkMisc))
#DEFINE GTK_MISC_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MISC, GtkMiscClass))
#DEFINE GTK_IS_MISC(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MISC))
#DEFINE GTK_IS_MISC_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MISC))
#DEFINE GTK_MISC_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MISC, GtkMiscClass))

TYPE GtkMisc AS _GtkMisc
TYPE GtkMiscPrivate AS _GtkMiscPrivate
TYPE GtkMiscClass AS _GtkMiscClass

TYPE _GtkMisc
  AS GtkWidget widget
  AS GtkMiscPrivate PTR priv
END TYPE

TYPE _GtkMiscClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_misc_get_type() AS GType
DECLARE SUB gtk_misc_set_alignment(BYVAL AS GtkMisc PTR, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_misc_get_alignment(BYVAL AS GtkMisc PTR, BYVAL AS gfloat PTR, BYVAL AS gfloat PTR)
DECLARE SUB gtk_misc_set_padding(BYVAL AS GtkMisc PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_misc_get_padding(BYVAL AS GtkMisc PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)

#ENDIF ' __GTK_MISC_H__

#IFNDEF __GTK_MENU_H__
#DEFINE __GTK_MENU_H__

#IFNDEF __GTK_MENU_SHELL_H__
#DEFINE __GTK_MENU_SHELL_H__

#DEFINE GTK_TYPE_MENU_SHELL (gtk_menu_shell_get_type ())
#DEFINE GTK_MENU_SHELL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MENU_SHELL, GtkMenuShell))
#DEFINE GTK_MENU_SHELL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MENU_SHELL, GtkMenuShellClass))
#DEFINE GTK_IS_MENU_SHELL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MENU_SHELL))
#DEFINE GTK_IS_MENU_SHELL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MENU_SHELL))
#DEFINE GTK_MENU_SHELL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MENU_SHELL, GtkMenuShellClass))

TYPE GtkMenuShell AS _GtkMenuShell
TYPE GtkMenuShellClass AS _GtkMenuShellClass
TYPE GtkMenuShellPrivate AS _GtkMenuShellPrivate

TYPE _GtkMenuShell
  AS GtkContainer container
  AS GtkMenuShellPrivate PTR priv
END TYPE

TYPE _GtkMenuShellClass
  AS GtkContainerClass parent_class
  AS guint submenu_placement : 1
  deactivate AS SUB(BYVAL AS GtkMenuShell PTR)
  selection_done AS SUB(BYVAL AS GtkMenuShell PTR)
  move_current AS SUB(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkMenuDirectionType)
  activate_current AS SUB(BYVAL AS GtkMenuShell PTR, BYVAL AS gboolean)
  cancel AS SUB(BYVAL AS GtkMenuShell PTR)
  select_item AS SUB(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR)
  insert AS SUB(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
  get_popup_delay AS FUNCTION(BYVAL AS GtkMenuShell PTR) AS gint
  move_selected AS FUNCTION(BYVAL AS GtkMenuShell PTR, BYVAL AS gint) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_menu_shell_get_type() AS GType
DECLARE SUB gtk_menu_shell_append(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_menu_shell_prepend(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_menu_shell_insert(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE SUB gtk_menu_shell_deactivate(BYVAL AS GtkMenuShell PTR)
DECLARE SUB gtk_menu_shell_select_item(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_menu_shell_deselect(BYVAL AS GtkMenuShell PTR)
DECLARE SUB gtk_menu_shell_activate_item(BYVAL AS GtkMenuShell PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE SUB gtk_menu_shell_select_first(BYVAL AS GtkMenuShell PTR, BYVAL AS gboolean)
DECLARE SUB gtk_menu_shell_cancel(BYVAL AS GtkMenuShell PTR)
DECLARE FUNCTION gtk_menu_shell_get_take_focus(BYVAL AS GtkMenuShell PTR) AS gboolean
DECLARE SUB gtk_menu_shell_set_take_focus(BYVAL AS GtkMenuShell PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_menu_shell_get_selected_item(BYVAL AS GtkMenuShell PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_menu_shell_get_parent_shell(BYVAL AS GtkMenuShell PTR) AS GtkWidget PTR

#ENDIF ' __GTK_MENU_SHELL_H__

#DEFINE GTK_TYPE_MENU (gtk_menu_get_type ())
#DEFINE GTK_MENU(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MENU, GtkMenu))
#DEFINE GTK_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MENU, GtkMenuClass))
#DEFINE GTK_IS_MENU(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MENU))
#DEFINE GTK_IS_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MENU))
#DEFINE GTK_MENU_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MENU, GtkMenuClass))

TYPE GtkMenu AS _GtkMenu
TYPE GtkMenuClass AS _GtkMenuClass
TYPE GtkMenuPrivate AS _GtkMenuPrivate
TYPE GtkMenuPositionFunc AS SUB(BYVAL AS GtkMenu PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gboolean PTR, BYVAL AS gpointer)
TYPE GtkMenuDetachFunc AS SUB(BYVAL AS GtkWidget PTR, BYVAL AS GtkMenu PTR)

TYPE _GtkMenu
  AS GtkMenuShell menu_shell
  AS GtkMenuPrivate PTR priv
END TYPE

TYPE _GtkMenuClass
  AS GtkMenuShellClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_menu_get_type() AS GType
DECLARE FUNCTION gtk_menu_new() AS GtkWidget PTR
DECLARE SUB gtk_menu_popup(BYVAL AS GtkMenu PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkMenuPositionFunc, BYVAL AS gpointer, BYVAL AS guint, BYVAL AS guint32)
DECLARE SUB gtk_menu_popup_for_device(BYVAL AS GtkMenu PTR, BYVAL AS GdkDevice PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkMenuPositionFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS guint, BYVAL AS guint32)
DECLARE SUB gtk_menu_reposition(BYVAL AS GtkMenu PTR)
DECLARE SUB gtk_menu_popdown(BYVAL AS GtkMenu PTR)
DECLARE FUNCTION gtk_menu_get_active(BYVAL AS GtkMenu PTR) AS GtkWidget PTR
DECLARE SUB gtk_menu_set_active(BYVAL AS GtkMenu PTR, BYVAL AS guint)
DECLARE SUB gtk_menu_set_accel_group(BYVAL AS GtkMenu PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE FUNCTION gtk_menu_get_accel_group(BYVAL AS GtkMenu PTR) AS GtkAccelGroup PTR
DECLARE SUB gtk_menu_set_accel_path(BYVAL AS GtkMenu PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_menu_get_accel_path(BYVAL AS GtkMenu PTR) AS CONST gchar PTR
DECLARE SUB gtk_menu_attach_to_widget(BYVAL AS GtkMenu PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkMenuDetachFunc)
DECLARE SUB gtk_menu_detach(BYVAL AS GtkMenu PTR)
DECLARE FUNCTION gtk_menu_get_attach_widget(BYVAL AS GtkMenu PTR) AS GtkWidget PTR
DECLARE SUB gtk_menu_set_tearoff_state(BYVAL AS GtkMenu PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_menu_get_tearoff_state(BYVAL AS GtkMenu PTR) AS gboolean
DECLARE SUB gtk_menu_set_title(BYVAL AS GtkMenu PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_menu_get_title(BYVAL AS GtkMenu PTR) AS CONST gchar PTR
DECLARE SUB gtk_menu_reorder_child(BYVAL AS GtkMenu PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE SUB gtk_menu_set_screen(BYVAL AS GtkMenu PTR, BYVAL AS GdkScreen PTR)
DECLARE SUB gtk_menu_attach(BYVAL AS GtkMenu PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_menu_set_monitor(BYVAL AS GtkMenu PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_menu_get_monitor(BYVAL AS GtkMenu PTR) AS gint
DECLARE FUNCTION gtk_menu_get_for_attach_widget(BYVAL AS GtkWidget PTR) AS GList PTR
DECLARE SUB gtk_menu_set_reserve_toggle_size(BYVAL AS GtkMenu PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_menu_get_reserve_toggle_size(BYVAL AS GtkMenu PTR) AS gboolean

#ENDIF ' __GTK_MENU_H__

#DEFINE GTK_TYPE_LABEL (gtk_label_get_type ())
#DEFINE GTK_LABEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LABEL, GtkLabel))
#DEFINE GTK_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_LABEL, GtkLabelClass))
#DEFINE GTK_IS_LABEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LABEL))
#DEFINE GTK_IS_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LABEL))
#DEFINE GTK_LABEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_LABEL, GtkLabelClass))

TYPE GtkLabel AS _GtkLabel
TYPE GtkLabelPrivate AS _GtkLabelPrivate
TYPE GtkLabelClass AS _GtkLabelClass
TYPE GtkLabelSelectionInfo AS _GtkLabelSelectionInfo

TYPE _GtkLabel
  AS GtkMisc misc
  AS GtkLabelPrivate PTR priv
END TYPE

TYPE _GtkLabelClass
  AS GtkMiscClass parent_class
  move_cursor AS SUB(BYVAL AS GtkLabel PTR, BYVAL AS GtkMovementStep, BYVAL AS gint, BYVAL AS gboolean)
  copy_clipboard AS SUB(BYVAL AS GtkLabel PTR)
  populate_popup AS SUB(BYVAL AS GtkLabel PTR, BYVAL AS GtkMenu PTR)
  activate_link AS FUNCTION(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_label_get_type() AS GType
DECLARE FUNCTION gtk_label_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_label_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_label_set_text(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_label_get_text(BYVAL AS GtkLabel PTR) AS CONST gchar PTR
DECLARE SUB gtk_label_set_attributes(BYVAL AS GtkLabel PTR, BYVAL AS PangoAttrList PTR)
DECLARE FUNCTION gtk_label_get_attributes(BYVAL AS GtkLabel PTR) AS PangoAttrList PTR
DECLARE SUB gtk_label_set_label(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_label_get_label(BYVAL AS GtkLabel PTR) AS CONST gchar PTR
DECLARE SUB gtk_label_set_markup(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_label_set_use_markup(BYVAL AS GtkLabel PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_label_get_use_markup(BYVAL AS GtkLabel PTR) AS gboolean
DECLARE SUB gtk_label_set_use_underline(BYVAL AS GtkLabel PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_label_get_use_underline(BYVAL AS GtkLabel PTR) AS gboolean
DECLARE SUB gtk_label_set_markup_with_mnemonic(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_label_get_mnemonic_keyval(BYVAL AS GtkLabel PTR) AS guint
DECLARE SUB gtk_label_set_mnemonic_widget(BYVAL AS GtkLabel PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_label_get_mnemonic_widget(BYVAL AS GtkLabel PTR) AS GtkWidget PTR
DECLARE SUB gtk_label_set_text_with_mnemonic(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_label_set_justify(BYVAL AS GtkLabel PTR, BYVAL AS GtkJustification)
DECLARE FUNCTION gtk_label_get_justify(BYVAL AS GtkLabel PTR) AS GtkJustification
DECLARE SUB gtk_label_set_ellipsize(BYVAL AS GtkLabel PTR, BYVAL AS PangoEllipsizeMode)
DECLARE FUNCTION gtk_label_get_ellipsize(BYVAL AS GtkLabel PTR) AS PangoEllipsizeMode
DECLARE SUB gtk_label_set_width_chars(BYVAL AS GtkLabel PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_label_get_width_chars(BYVAL AS GtkLabel PTR) AS gint
DECLARE SUB gtk_label_set_max_width_chars(BYVAL AS GtkLabel PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_label_get_max_width_chars(BYVAL AS GtkLabel PTR) AS gint
DECLARE SUB gtk_label_set_pattern(BYVAL AS GtkLabel PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_label_set_line_wrap(BYVAL AS GtkLabel PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_label_get_line_wrap(BYVAL AS GtkLabel PTR) AS gboolean
DECLARE SUB gtk_label_set_line_wrap_mode(BYVAL AS GtkLabel PTR, BYVAL AS PangoWrapMode)
DECLARE FUNCTION gtk_label_get_line_wrap_mode(BYVAL AS GtkLabel PTR) AS PangoWrapMode
DECLARE SUB gtk_label_set_selectable(BYVAL AS GtkLabel PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_label_get_selectable(BYVAL AS GtkLabel PTR) AS gboolean
DECLARE SUB gtk_label_set_angle(BYVAL AS GtkLabel PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_label_get_angle(BYVAL AS GtkLabel PTR) AS gdouble
DECLARE SUB gtk_label_select_region(BYVAL AS GtkLabel PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_label_get_selection_bounds(BYVAL AS GtkLabel PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_label_get_layout(BYVAL AS GtkLabel PTR) AS PangoLayout PTR
DECLARE SUB gtk_label_get_layout_offsets(BYVAL AS GtkLabel PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_label_set_single_line_mode(BYVAL AS GtkLabel PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_label_get_single_line_mode(BYVAL AS GtkLabel PTR) AS gboolean
DECLARE FUNCTION gtk_label_get_current_uri(BYVAL AS GtkLabel PTR) AS CONST gchar PTR
DECLARE SUB gtk_label_set_track_visited_links(BYVAL AS GtkLabel PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_label_get_track_visited_links(BYVAL AS GtkLabel PTR) AS gboolean
DECLARE SUB _gtk_label_mnemonics_visible_apply_recursively(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION _gtk_label_get_cursor_position(BYVAL AS GtkLabel PTR) AS gint
DECLARE FUNCTION _gtk_label_get_selection_bound(BYVAL AS GtkLabel PTR) AS gint

#ENDIF ' __GTK_LABEL_H__

#DEFINE GTK_TYPE_ACCEL_LABEL (gtk_accel_label_get_type ())
#DEFINE GTK_ACCEL_LABEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACCEL_LABEL, GtkAccelLabel))
#DEFINE GTK_ACCEL_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCEL_LABEL, GtkAccelLabelClass))
#DEFINE GTK_IS_ACCEL_LABEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACCEL_LABEL))
#DEFINE GTK_IS_ACCEL_LABEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCEL_LABEL))
#DEFINE GTK_ACCEL_LABEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCEL_LABEL, GtkAccelLabelClass))

TYPE GtkAccelLabel AS _GtkAccelLabel
TYPE GtkAccelLabelClass AS _GtkAccelLabelClass
TYPE GtkAccelLabelPrivate AS _GtkAccelLabelPrivate

TYPE _GtkAccelLabel
  AS GtkLabel label
  AS GtkAccelLabelPrivate PTR priv
END TYPE

TYPE _GtkAccelLabelClass
  AS GtkLabelClass parent_class
  AS gchar PTR signal_quote1
  AS gchar PTR signal_quote2
  AS gchar PTR mod_name_shift
  AS gchar PTR mod_name_control
  AS gchar PTR mod_name_alt
  AS gchar PTR mod_separator
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_accel_label_get_type() AS GType
DECLARE FUNCTION gtk_accel_label_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_accel_label_get_accel_widget(BYVAL AS GtkAccelLabel PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_accel_label_get_accel_width(BYVAL AS GtkAccelLabel PTR) AS guint
DECLARE SUB gtk_accel_label_set_accel_widget(BYVAL AS GtkAccelLabel PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_accel_label_set_accel_closure(BYVAL AS GtkAccelLabel PTR, BYVAL AS GClosure PTR)
DECLARE FUNCTION gtk_accel_label_refetch(BYVAL AS GtkAccelLabel PTR) AS gboolean
DECLARE FUNCTION _gtk_accel_label_class_get_accelerator_label(BYVAL AS GtkAccelLabelClass PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gchar PTR

#ENDIF ' __GTK_ACCEL_LABEL_H__

#IFNDEF __GTK_ACCEL_MAP_H__
#DEFINE __GTK_ACCEL_MAP_H__

#DEFINE GTK_TYPE_ACCEL_MAP (gtk_accel_map_get_type ())
#DEFINE GTK_ACCEL_MAP(accel_map) (G_TYPE_CHECK_INSTANCE_CAST ((accel_map), GTK_TYPE_ACCEL_MAP, GtkAccelMap))
#DEFINE GTK_ACCEL_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCEL_MAP, GtkAccelMapClass))
#DEFINE GTK_IS_ACCEL_MAP(accel_map) (G_TYPE_CHECK_INSTANCE_TYPE ((accel_map), GTK_TYPE_ACCEL_MAP))
#DEFINE GTK_IS_ACCEL_MAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCEL_MAP))
#DEFINE GTK_ACCEL_MAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCEL_MAP, GtkAccelMapClass))

TYPE GtkAccelMap AS _GtkAccelMap
TYPE GtkAccelMapClass AS _GtkAccelMapClass
TYPE GtkAccelMapForeach AS SUB(BYVAL AS gpointer, BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS gboolean)

DECLARE SUB gtk_accel_map_add_entry(BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS GdkModifierType)
DECLARE FUNCTION gtk_accel_map_lookup_entry(BYVAL AS CONST gchar PTR, BYVAL AS GtkAccelKey PTR) AS gboolean
DECLARE FUNCTION gtk_accel_map_change_entry(BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS gboolean) AS gboolean
DECLARE SUB gtk_accel_map_load(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_accel_map_save(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_accel_map_foreach(BYVAL AS gpointer, BYVAL AS GtkAccelMapForeach)
DECLARE SUB gtk_accel_map_load_fd(BYVAL AS gint)
DECLARE SUB gtk_accel_map_load_scanner(BYVAL AS GScanner PTR)
DECLARE SUB gtk_accel_map_save_fd(BYVAL AS gint)
DECLARE SUB gtk_accel_map_lock_path(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_accel_map_unlock_path(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_accel_map_add_filter(BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_accel_map_foreach_unfiltered(BYVAL AS gpointer, BYVAL AS GtkAccelMapForeach)
DECLARE FUNCTION gtk_accel_map_get_type() AS GType
DECLARE FUNCTION gtk_accel_map_get() AS GtkAccelMap PTR
DECLARE SUB _gtk_accel_map_init()
DECLARE SUB _gtk_accel_map_add_group(BYVAL AS CONST gchar PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE SUB _gtk_accel_map_remove_group(BYVAL AS CONST gchar PTR, BYVAL AS GtkAccelGroup PTR)
DECLARE FUNCTION _gtk_accel_path_is_valid(BYVAL AS CONST gchar PTR) AS gboolean

#ENDIF ' __GTK_ACCEL_MAP_H__

#IFNDEF __GTK_ACCESSIBLE_H__
#DEFINE __GTK_ACCESSIBLE_H__

#DEFINE GTK_TYPE_ACCESSIBLE (gtk_accessible_get_type ())
#DEFINE GTK_ACCESSIBLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACCESSIBLE, GtkAccessible))
#DEFINE GTK_ACCESSIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass))
#DEFINE GTK_IS_ACCESSIBLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACCESSIBLE))
#DEFINE GTK_IS_ACCESSIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ACCESSIBLE))
#DEFINE GTK_ACCESSIBLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ACCESSIBLE, GtkAccessibleClass))

TYPE GtkAccessible AS _GtkAccessible
TYPE GtkAccessiblePrivate AS _GtkAccessiblePrivate
TYPE GtkAccessibleClass AS _GtkAccessibleClass

TYPE _GtkAccessible
  AS AtkObject parent
  AS GtkAccessiblePrivate PTR priv
END TYPE

TYPE _GtkAccessibleClass
  AS AtkObjectClass parent_class
  connect_widget_destroyed AS SUB(BYVAL AS GtkAccessible PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_accessible_get_type() AS GType
DECLARE SUB gtk_accessible_set_widget(BYVAL AS GtkAccessible PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_accessible_get_widget(BYVAL AS GtkAccessible PTR) AS GtkWidget PTR
DECLARE SUB gtk_accessible_connect_widget_destroyed(BYVAL AS GtkAccessible PTR)

#ENDIF ' __GTK_ACCESSIBLE_H__

#IFNDEF __GTK_ACTIVATABLE_H__
#DEFINE __GTK_ACTIVATABLE_H__

#DEFINE GTK_TYPE_ACTIVATABLE (gtk_activatable_get_type ())
#DEFINE GTK_ACTIVATABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACTIVATABLE, GtkActivatable))
#DEFINE GTK_ACTIVATABLE_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_ACTIVATABLE, GtkActivatableIface))
#DEFINE GTK_IS_ACTIVATABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACTIVATABLE))
#DEFINE GTK_ACTIVATABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_ACTIVATABLE, GtkActivatableIface))

TYPE GtkActivatable AS _GtkActivatable
TYPE GtkActivatableIface AS _GtkActivatableIface

TYPE _GtkActivatableIface
  AS GTypeInterface g_iface
  update AS SUB(BYVAL AS GtkActivatable PTR, BYVAL AS GtkAction PTR, BYVAL AS CONST gchar PTR)
  sync_action_properties AS SUB(BYVAL AS GtkActivatable PTR, BYVAL AS GtkAction PTR)
END TYPE

DECLARE FUNCTION gtk_activatable_get_type() AS GType
DECLARE SUB gtk_activatable_sync_action_properties(BYVAL AS GtkActivatable PTR, BYVAL AS GtkAction PTR)
DECLARE SUB gtk_activatable_set_related_action(BYVAL AS GtkActivatable PTR, BYVAL AS GtkAction PTR)
DECLARE FUNCTION gtk_activatable_get_related_action(BYVAL AS GtkActivatable PTR) AS GtkAction PTR
DECLARE SUB gtk_activatable_set_use_action_appearance(BYVAL AS GtkActivatable PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_activatable_get_use_action_appearance(BYVAL AS GtkActivatable PTR) AS gboolean
DECLARE SUB gtk_activatable_do_set_related_action(BYVAL AS GtkActivatable PTR, BYVAL AS GtkAction PTR)

#ENDIF ' __GTK_ACTIVATABLE_H__

#IFNDEF __GTK_ALIGNMENT_H__
#DEFINE __GTK_ALIGNMENT_H__

#DEFINE GTK_TYPE_ALIGNMENT (gtk_alignment_get_type ())
#DEFINE GTK_ALIGNMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ALIGNMENT, GtkAlignment))
#DEFINE GTK_ALIGNMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ALIGNMENT, GtkAlignmentClass))
#DEFINE GTK_IS_ALIGNMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ALIGNMENT))
#DEFINE GTK_IS_ALIGNMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ALIGNMENT))
#DEFINE GTK_ALIGNMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ALIGNMENT, GtkAlignmentClass))

TYPE GtkAlignment AS _GtkAlignment
TYPE GtkAlignmentPrivate AS _GtkAlignmentPrivate
TYPE GtkAlignmentClass AS _GtkAlignmentClass

TYPE _GtkAlignment
  AS GtkBin bin
  AS GtkAlignmentPrivate PTR priv
END TYPE

TYPE _GtkAlignmentClass
  AS GtkBinClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_alignment_get_type() AS GType
DECLARE FUNCTION gtk_alignment_new(BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat) AS GtkWidget PTR
DECLARE SUB gtk_alignment_set(BYVAL AS GtkAlignment PTR, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_alignment_set_padding(BYVAL AS GtkAlignment PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_alignment_get_padding(BYVAL AS GtkAlignment PTR, BYVAL AS guint PTR, BYVAL AS guint PTR, BYVAL AS guint PTR, BYVAL AS guint PTR)

#ENDIF ' __GTK_ALIGNMENT_H__

#IFNDEF __GTK_APP_CHOOSER_H__
#DEFINE __GTK_APP_CHOOSER_H__
#INCLUDE ONCE "glib.bi"

#DEFINE GTK_TYPE_APP_CHOOSER (gtk_app_chooser_get_type ())
#DEFINE GTK_APP_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_APP_CHOOSER, GtkAppChooser))
#DEFINE GTK_IS_APP_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_APP_CHOOSER))

TYPE GtkAppChooser AS _GtkAppChooser

DECLARE FUNCTION gtk_app_chooser_get_type() AS GType
DECLARE FUNCTION gtk_app_chooser_get_app_info(BYVAL AS GtkAppChooser PTR) AS GAppInfo PTR
DECLARE FUNCTION gtk_app_chooser_get_content_type(BYVAL AS GtkAppChooser PTR) AS gchar PTR
DECLARE SUB gtk_app_chooser_refresh(BYVAL AS GtkAppChooser PTR)

#ENDIF ' __GTK_APP_CHOOSER_H__

#IFNDEF __GTK_APP_CHOOSER_DIALOG_H__
#DEFINE __GTK_APP_CHOOSER_DIALOG_H__

#DEFINE GTK_TYPE_APP_CHOOSER_DIALOG (gtk_app_chooser_dialog_get_type ())
#DEFINE GTK_APP_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_APP_CHOOSER_DIALOG, GtkAppChooserDialog))
#DEFINE GTK_APP_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_APP_CHOOSER_DIALOG, GtkAppChooserDialogClass))
#DEFINE GTK_IS_APP_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_APP_CHOOSER_DIALOG))
#DEFINE GTK_IS_APP_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_APP_CHOOSER_DIALOG))
#DEFINE GTK_APP_CHOOSER_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_APP_CHOOSER_DIALOG, GtkAppChooserDialogClass))

TYPE GtkAppChooserDialog AS _GtkAppChooserDialog
TYPE GtkAppChooserDialogClass AS _GtkAppChooserDialogClass
TYPE GtkAppChooserDialogPrivate AS _GtkAppChooserDialogPrivate

TYPE _GtkAppChooserDialog
  AS GtkDialog parent
  AS GtkAppChooserDialogPrivate PTR priv
END TYPE

TYPE _GtkAppChooserDialogClass
  AS GtkDialogClass parent_class
  AS gpointer padding(15)
END TYPE

DECLARE FUNCTION gtk_app_chooser_dialog_get_type() AS GType
DECLARE FUNCTION gtk_app_chooser_dialog_new(BYVAL AS GtkWindow PTR, BYVAL AS GtkDialogFlags, BYVAL AS GFile PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_app_chooser_dialog_new_for_content_type(BYVAL AS GtkWindow PTR, BYVAL AS GtkDialogFlags, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_app_chooser_dialog_get_widget(BYVAL AS GtkAppChooserDialog PTR) AS GtkWidget PTR
DECLARE SUB gtk_app_chooser_dialog_set_heading(BYVAL AS GtkAppChooserDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_app_chooser_dialog_get_heading(BYVAL AS GtkAppChooserDialog PTR) AS CONST gchar PTR

#ENDIF ' __GTK_APP_CHOOSER_DIALOG_H__

#IFNDEF __GTK_APP_CHOOSER_WIDGET_H__
#DEFINE __GTK_APP_CHOOSER_WIDGET_H__

#IFNDEF __GTK_BOX_H__
#DEFINE __GTK_BOX_H__

#DEFINE GTK_TYPE_BOX (gtk_box_get_type ())
#DEFINE GTK_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BOX, GtkBox))
#DEFINE GTK_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BOX, GtkBoxClass))
#DEFINE GTK_IS_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BOX))
#DEFINE GTK_IS_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BOX))
#DEFINE GTK_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BOX, GtkBoxClass))

TYPE GtkBox AS _GtkBox
TYPE GtkBoxPrivate AS _GtkBoxPrivate
TYPE GtkBoxClass AS _GtkBoxClass

TYPE _GtkBox
  AS GtkContainer container
  AS GtkBoxPrivate PTR priv
END TYPE

TYPE _GtkBoxClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_box_get_type() AS GType
DECLARE FUNCTION gtk_box_new(BYVAL AS GtkOrientation, BYVAL AS gint) AS GtkWidget PTR
DECLARE SUB gtk_box_pack_start(BYVAL AS GtkBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS guint)
DECLARE SUB gtk_box_pack_end(BYVAL AS GtkBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS guint)
DECLARE SUB gtk_box_set_homogeneous(BYVAL AS GtkBox PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_box_get_homogeneous(BYVAL AS GtkBox PTR) AS gboolean
DECLARE SUB gtk_box_set_spacing(BYVAL AS GtkBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_box_get_spacing(BYVAL AS GtkBox PTR) AS gint
DECLARE SUB gtk_box_reorder_child(BYVAL AS GtkBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE SUB gtk_box_query_child_packing(BYVAL AS GtkBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean PTR, BYVAL AS gboolean PTR, BYVAL AS guint PTR, BYVAL AS GtkPackType PTR)
DECLARE SUB gtk_box_set_child_packing(BYVAL AS GtkBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS guint, BYVAL AS GtkPackType)
DECLARE SUB _gtk_box_set_old_defaults(BYVAL AS GtkBox PTR)
DECLARE FUNCTION _gtk_box_get_spacing_set(BYVAL AS GtkBox PTR) AS gboolean
DECLARE SUB _gtk_box_set_spacing_set(BYVAL AS GtkBox PTR, BYVAL AS gboolean)
DECLARE FUNCTION _gtk_box_get_children(BYVAL AS GtkBox PTR) AS GList PTR

#ENDIF ' __GTK_BOX_H__

#DEFINE GTK_TYPE_APP_CHOOSER_WIDGET (gtk_app_chooser_widget_get_type ())
#DEFINE GTK_APP_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_APP_CHOOSER_WIDGET, GtkAppChooserWidget))
#DEFINE GTK_APP_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_APP_CHOOSER_WIDGET, GtkAppChooserWidgetClass))
#DEFINE GTK_IS_APP_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_APP_CHOOSER_WIDGET))
#DEFINE GTK_IS_APP_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_APP_CHOOSER_WIDGET))
#DEFINE GTK_APP_CHOOSER_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_APP_CHOOSER_WIDGET, GtkAppChooserWidgetClass))

TYPE GtkAppChooserWidget AS _GtkAppChooserWidget
TYPE GtkAppChooserWidgetClass AS _GtkAppChooserWidgetClass
TYPE GtkAppChooserWidgetPrivate AS _GtkAppChooserWidgetPrivate

TYPE _GtkAppChooserWidget
  AS GtkBox parent
  AS GtkAppChooserWidgetPrivate PTR priv
END TYPE

TYPE _GtkAppChooserWidgetClass
  AS GtkBoxClass parent_class
  application_selected AS SUB(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS GAppInfo PTR)
  application_activated AS SUB(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS GAppInfo PTR)
  populate_popup AS SUB(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS GtkMenu PTR, BYVAL AS GAppInfo PTR)
  AS gpointer padding(15)
END TYPE

DECLARE FUNCTION gtk_app_chooser_widget_get_type() AS GType
DECLARE FUNCTION gtk_app_chooser_widget_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_app_chooser_widget_set_show_default(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_widget_get_show_default(BYVAL AS GtkAppChooserWidget PTR) AS gboolean
DECLARE SUB gtk_app_chooser_widget_set_show_recommended(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_widget_get_show_recommended(BYVAL AS GtkAppChooserWidget PTR) AS gboolean
DECLARE SUB gtk_app_chooser_widget_set_show_fallback(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_widget_get_show_fallback(BYVAL AS GtkAppChooserWidget PTR) AS gboolean
DECLARE SUB gtk_app_chooser_widget_set_show_other(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_widget_get_show_other(BYVAL AS GtkAppChooserWidget PTR) AS gboolean
DECLARE SUB gtk_app_chooser_widget_set_show_all(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_widget_get_show_all(BYVAL AS GtkAppChooserWidget PTR) AS gboolean
DECLARE SUB gtk_app_chooser_widget_set_default_text(BYVAL AS GtkAppChooserWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_app_chooser_widget_get_default_text(BYVAL AS GtkAppChooserWidget PTR) AS CONST gchar PTR

#ENDIF ' __GTK_APP_CHOOSER_WIDGET_H__

#IFNDEF __GTK_APP_CHOOSER_BUTTON_H__
#DEFINE __GTK_APP_CHOOSER_BUTTON_H__

#IFNDEF __GTK_COMBO_BOX_H__
#DEFINE __GTK_COMBO_BOX_H__

#IFNDEF __GTK_TREE_MODEL_H__
#DEFINE __GTK_TREE_MODEL_H__

#DEFINE GTK_TYPE_TREE_MODEL (gtk_tree_model_get_type ())
#DEFINE GTK_TREE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_MODEL, GtkTreeModel))
#DEFINE GTK_IS_TREE_MODEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_MODEL))
#DEFINE GTK_TREE_MODEL_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_MODEL, GtkTreeModelIface))
#DEFINE GTK_TYPE_TREE_ITER (gtk_tree_iter_get_type ())
#DEFINE GTK_TYPE_TREE_PATH (gtk_tree_path_get_type ())
#DEFINE GTK_TYPE_TREE_ROW_REFERENCE (gtk_tree_row_reference_get_type ())

TYPE GtkTreeIter AS _GtkTreeIter
TYPE GtkTreePath AS _GtkTreePath
TYPE GtkTreeRowReference AS _GtkTreeRowReference
TYPE GtkTreeModel AS _GtkTreeModel
TYPE GtkTreeModelIface AS _GtkTreeModelIface
TYPE GtkTreeModelForeachFunc AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer) AS gboolean

ENUM GtkTreeModelFlags
  GTK_TREE_MODEL_ITERS_PERSIST = 1 SHL 0
  GTK_TREE_MODEL_LIST_ONLY = 1 SHL 1
END ENUM

TYPE _GtkTreeIter
  AS gint stamp
  AS gpointer user_data
  AS gpointer user_data2
  AS gpointer user_data3
END TYPE

TYPE _GtkTreeModelIface
  AS GTypeInterface g_iface
  row_changed AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR)
  row_inserted AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR)
  row_has_child_toggled AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR)
  row_deleted AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR)
  rows_reordered AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint PTR)
  get_flags AS FUNCTION(BYVAL AS GtkTreeModel PTR) AS GtkTreeModelFlags
  get_n_columns AS FUNCTION(BYVAL AS GtkTreeModel PTR) AS gint
  get_column_type AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS gint) AS GType
  get_iter AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreePath PTR) AS gboolean
  get_path AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS GtkTreePath PTR
  get_value AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, BYVAL AS GValue PTR)
  iter_next AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  iter_previous AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  iter_children AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  iter_has_child AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  iter_n_children AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gint
  iter_nth_child AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint) AS gboolean
  iter_parent AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  ref_node AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR)
  unref_node AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR)
END TYPE

DECLARE FUNCTION gtk_tree_path_new() AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_path_new_from_string(BYVAL AS CONST gchar PTR) AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_path_new_from_indices(BYVAL AS gint, ...) AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_path_to_string(BYVAL AS GtkTreePath PTR) AS gchar PTR
DECLARE FUNCTION gtk_tree_path_new_first() AS GtkTreePath PTR
DECLARE SUB gtk_tree_path_append_index(BYVAL AS GtkTreePath PTR, BYVAL AS gint)
DECLARE SUB gtk_tree_path_prepend_index(BYVAL AS GtkTreePath PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_path_get_depth(BYVAL AS GtkTreePath PTR) AS gint
DECLARE FUNCTION gtk_tree_path_get_indices(BYVAL AS GtkTreePath PTR) AS gint PTR
DECLARE FUNCTION gtk_tree_path_get_indices_with_depth(BYVAL AS GtkTreePath PTR, BYVAL AS gint PTR) AS gint PTR
DECLARE SUB gtk_tree_path_free(BYVAL AS GtkTreePath PTR)
DECLARE FUNCTION gtk_tree_path_copy(BYVAL AS CONST GtkTreePath PTR) AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_path_get_type() AS GType
DECLARE FUNCTION gtk_tree_path_compare(BYVAL AS CONST GtkTreePath PTR, BYVAL AS CONST GtkTreePath PTR) AS gint
DECLARE SUB gtk_tree_path_next(BYVAL AS GtkTreePath PTR)
DECLARE FUNCTION gtk_tree_path_prev(BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_path_up(BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE SUB gtk_tree_path_down(BYVAL AS GtkTreePath PTR)
DECLARE FUNCTION gtk_tree_path_is_ancestor(BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_path_is_descendant(BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_row_reference_get_type() AS GType
DECLARE FUNCTION gtk_tree_row_reference_new(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR) AS GtkTreeRowReference PTR
DECLARE FUNCTION gtk_tree_row_reference_new_proxy(BYVAL AS GObject PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR) AS GtkTreeRowReference PTR
DECLARE FUNCTION gtk_tree_row_reference_get_path(BYVAL AS GtkTreeRowReference PTR) AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_row_reference_get_model(BYVAL AS GtkTreeRowReference PTR) AS GtkTreeModel PTR
DECLARE FUNCTION gtk_tree_row_reference_valid(BYVAL AS GtkTreeRowReference PTR) AS gboolean
DECLARE FUNCTION gtk_tree_row_reference_copy(BYVAL AS GtkTreeRowReference PTR) AS GtkTreeRowReference PTR
DECLARE SUB gtk_tree_row_reference_free(BYVAL AS GtkTreeRowReference PTR)
DECLARE SUB gtk_tree_row_reference_inserted(BYVAL AS GObject PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_row_reference_deleted(BYVAL AS GObject PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_row_reference_reordered(BYVAL AS GObject PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_tree_iter_copy(BYVAL AS GtkTreeIter PTR) AS GtkTreeIter PTR
DECLARE SUB gtk_tree_iter_free(BYVAL AS GtkTreeIter PTR)
DECLARE FUNCTION gtk_tree_iter_get_type() AS GType
DECLARE FUNCTION gtk_tree_model_get_type() AS GType
DECLARE FUNCTION gtk_tree_model_get_flags(BYVAL AS GtkTreeModel PTR) AS GtkTreeModelFlags
DECLARE FUNCTION gtk_tree_model_get_n_columns(BYVAL AS GtkTreeModel PTR) AS gint
DECLARE FUNCTION gtk_tree_model_get_column_type(BYVAL AS GtkTreeModel PTR, BYVAL AS gint) AS GType
DECLARE FUNCTION gtk_tree_model_get_iter(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_get_iter_from_string(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_get_string_from_iter(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gchar PTR
DECLARE FUNCTION gtk_tree_model_get_iter_first(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_get_path(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS GtkTreePath PTR
DECLARE SUB gtk_tree_model_get_value(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, BYVAL AS GValue PTR)
DECLARE FUNCTION gtk_tree_model_iter_previous(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_iter_next(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_iter_children(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_iter_has_child(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_iter_n_children(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gint
DECLARE FUNCTION gtk_tree_model_iter_nth_child(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_tree_model_iter_parent(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_tree_model_ref_node(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_model_unref_node(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_model_get(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, ...)
DECLARE SUB gtk_tree_model_get_valist(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS va_list)
DECLARE SUB gtk_tree_model_foreach(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeModelForeachFunc, BYVAL AS gpointer)
DECLARE SUB gtk_tree_model_row_changed(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_model_row_inserted(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_model_row_has_child_toggled(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_model_row_deleted(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_model_rows_reordered(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint PTR)

#ENDIF ' __GTK_TREE_MODEL_H__

#IFNDEF __GTK_TREE_VIEW_H__
#DEFINE __GTK_TREE_VIEW_H__

#IFNDEF __GTK_TREE_VIEW_COLUMN_H__
#DEFINE __GTK_TREE_VIEW_COLUMN_H__

#IFNDEF __GTK_CELL_RENDERER_H__
#DEFINE __GTK_CELL_RENDERER_H__

#IFNDEF __GTK_CELL_EDITABLE_H__
#DEFINE __GTK_CELL_EDITABLE_H__

#DEFINE GTK_TYPE_CELL_EDITABLE (gtk_cell_editable_get_type ())
#DEFINE GTK_CELL_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditable))
#DEFINE GTK_CELL_EDITABLE_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditableIface))
#DEFINE GTK_IS_CELL_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_EDITABLE))
#DEFINE GTK_CELL_EDITABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_CELL_EDITABLE, GtkCellEditableIface))

TYPE GtkCellEditable AS _GtkCellEditable
TYPE GtkCellEditableIface AS _GtkCellEditableIface

TYPE _GtkCellEditableIface
  AS GTypeInterface g_iface
  editing_done AS SUB(BYVAL AS GtkCellEditable PTR)
  remove_widget AS SUB(BYVAL AS GtkCellEditable PTR)
  start_editing AS SUB(BYVAL AS GtkCellEditable PTR, BYVAL AS GdkEvent PTR)
END TYPE

DECLARE FUNCTION gtk_cell_editable_get_type() AS GType
DECLARE SUB gtk_cell_editable_start_editing(BYVAL AS GtkCellEditable PTR, BYVAL AS GdkEvent PTR)
DECLARE SUB gtk_cell_editable_editing_done(BYVAL AS GtkCellEditable PTR)
DECLARE SUB gtk_cell_editable_remove_widget(BYVAL AS GtkCellEditable PTR)

#ENDIF ' __GTK_CELL_EDITABLE_H__

ENUM GtkCellRendererState
  GTK_CELL_RENDERER_SELECTED = 1 SHL 0
  GTK_CELL_RENDERER_PRELIT = 1 SHL 1
  GTK_CELL_RENDERER_INSENSITIVE = 1 SHL 2
  GTK_CELL_RENDERER_SORTED = 1 SHL 3
  GTK_CELL_RENDERER_FOCUSED = 1 SHL 4
END ENUM

ENUM GtkCellRendererMode
  GTK_CELL_RENDERER_MODE_INERT
  GTK_CELL_RENDERER_MODE_ACTIVATABLE
  GTK_CELL_RENDERER_MODE_EDITABLE
END ENUM

#DEFINE GTK_TYPE_CELL_RENDERER (gtk_cell_renderer_get_type ())
#DEFINE GTK_CELL_RENDERER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER, GtkCellRenderer))
#DEFINE GTK_CELL_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER, GtkCellRendererClass))
#DEFINE GTK_IS_CELL_RENDERER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER))
#DEFINE GTK_IS_CELL_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER))
#DEFINE GTK_CELL_RENDERER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER, GtkCellRendererClass))

TYPE GtkCellRenderer AS _GtkCellRenderer
TYPE GtkCellRendererPrivate AS _GtkCellRendererPrivate
TYPE GtkCellRendererClass AS _GtkCellRendererClass

TYPE _GtkCellRenderer
  AS GInitiallyUnowned parent_instance
  AS GtkCellRendererPrivate PTR priv
END TYPE

TYPE _GtkCellRendererClass
  AS GInitiallyUnownedClass parent_class
  get_request_mode AS FUNCTION(BYVAL AS GtkCellRenderer PTR) AS GtkSizeRequestMode
  get_preferred_width AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_height_for_width AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_height AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_width_for_height AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_aligned_area AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkCellRendererState, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR)
  get_size AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  render AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState)
  activate AS FUNCTION(BYVAL AS GtkCellRenderer PTR, BYVAL AS GdkEvent PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS gboolean
  start_editing AS FUNCTION(BYVAL AS GtkCellRenderer PTR, BYVAL AS GdkEvent PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS GtkCellEditable PTR
  editing_canceled AS SUB(BYVAL AS GtkCellRenderer PTR)
  editing_started AS SUB(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkCellEditable PTR, BYVAL AS CONST gchar PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_get_request_mode(BYVAL AS GtkCellRenderer PTR) AS GtkSizeRequestMode
DECLARE SUB gtk_cell_renderer_get_preferred_width(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_renderer_get_preferred_height_for_width(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_renderer_get_preferred_height(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_renderer_get_preferred_width_for_height(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_renderer_get_preferred_size(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkRequisition PTR, BYVAL AS GtkRequisition PTR)
DECLARE SUB gtk_cell_renderer_get_aligned_area(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkCellRendererState, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_cell_renderer_get_size(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_cell_renderer_render(BYVAL AS GtkCellRenderer PTR, BYVAL AS cairo_t PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState)
DECLARE FUNCTION gtk_cell_renderer_activate(BYVAL AS GtkCellRenderer PTR, BYVAL AS GdkEvent PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS gboolean
DECLARE FUNCTION gtk_cell_renderer_start_editing(BYVAL AS GtkCellRenderer PTR, BYVAL AS GdkEvent PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS GtkCellEditable PTR
DECLARE SUB gtk_cell_renderer_set_fixed_size(BYVAL AS GtkCellRenderer PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_cell_renderer_get_fixed_size(BYVAL AS GtkCellRenderer PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_renderer_set_alignment(BYVAL AS GtkCellRenderer PTR, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_cell_renderer_get_alignment(BYVAL AS GtkCellRenderer PTR, BYVAL AS gfloat PTR, BYVAL AS gfloat PTR)
DECLARE SUB gtk_cell_renderer_set_padding(BYVAL AS GtkCellRenderer PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_cell_renderer_get_padding(BYVAL AS GtkCellRenderer PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_renderer_set_visible(BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_renderer_get_visible(BYVAL AS GtkCellRenderer PTR) AS gboolean
DECLARE SUB gtk_cell_renderer_set_sensitive(BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_renderer_get_sensitive(BYVAL AS GtkCellRenderer PTR) AS gboolean
DECLARE FUNCTION gtk_cell_renderer_is_activatable(BYVAL AS GtkCellRenderer PTR) AS gboolean
DECLARE SUB gtk_cell_renderer_stop_editing(BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE SUB _gtk_cell_renderer_calc_offset(BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkTextDirection, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_cell_renderer_get_state(BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkCellRendererState) AS GtkStateFlags

#ENDIF ' __GTK_CELL_RENDERER_H__

#IFNDEF __GTK_TREE_SORTABLE_H__
#DEFINE __GTK_TREE_SORTABLE_H__

#DEFINE GTK_TYPE_TREE_SORTABLE (gtk_tree_sortable_get_type ())
#DEFINE GTK_TREE_SORTABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortable))
#DEFINE GTK_TREE_SORTABLE_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface))
#DEFINE GTK_IS_TREE_SORTABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_SORTABLE))
#DEFINE GTK_TREE_SORTABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_SORTABLE, GtkTreeSortableIface))

ENUM
  GTK_TREE_SORTABLE_DEFAULT_SORT_COLUMN_ID = -1
  GTK_TREE_SORTABLE_UNSORTED_SORT_COLUMN_ID = -2
END ENUM

TYPE GtkTreeSortable AS _GtkTreeSortable
TYPE GtkTreeSortableIface AS _GtkTreeSortableIface
TYPE GtkTreeIterCompareFunc AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer) AS gint

TYPE _GtkTreeSortableIface
  AS GTypeInterface g_iface
  sort_column_changed AS SUB(BYVAL AS GtkTreeSortable PTR)
  get_sort_column_id AS FUNCTION(BYVAL AS GtkTreeSortable PTR, BYVAL AS gint PTR, BYVAL AS GtkSortType PTR) AS gboolean
  set_sort_column_id AS SUB(BYVAL AS GtkTreeSortable PTR, BYVAL AS gint, BYVAL AS GtkSortType)
  set_sort_func AS SUB(BYVAL AS GtkTreeSortable PTR, BYVAL AS gint, BYVAL AS GtkTreeIterCompareFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
  set_default_sort_func AS SUB(BYVAL AS GtkTreeSortable PTR, BYVAL AS GtkTreeIterCompareFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
  has_default_sort_func AS FUNCTION(BYVAL AS GtkTreeSortable PTR) AS gboolean
END TYPE

DECLARE FUNCTION gtk_tree_sortable_get_type() AS GType
DECLARE SUB gtk_tree_sortable_sort_column_changed(BYVAL AS GtkTreeSortable PTR)
DECLARE FUNCTION gtk_tree_sortable_get_sort_column_id(BYVAL AS GtkTreeSortable PTR, BYVAL AS gint PTR, BYVAL AS GtkSortType PTR) AS gboolean
DECLARE SUB gtk_tree_sortable_set_sort_column_id(BYVAL AS GtkTreeSortable PTR, BYVAL AS gint, BYVAL AS GtkSortType)
DECLARE SUB gtk_tree_sortable_set_sort_func(BYVAL AS GtkTreeSortable PTR, BYVAL AS gint, BYVAL AS GtkTreeIterCompareFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_sortable_set_default_sort_func(BYVAL AS GtkTreeSortable PTR, BYVAL AS GtkTreeIterCompareFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_tree_sortable_has_default_sort_func(BYVAL AS GtkTreeSortable PTR) AS gboolean

#ENDIF ' __GTK_TREE_SORTABLE_H__

#IFNDEF __GTK_CELL_AREA_H__
#DEFINE __GTK_CELL_AREA_H__

#DEFINE GTK_TYPE_CELL_AREA (gtk_cell_area_get_type ())
#DEFINE GTK_CELL_AREA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_AREA, GtkCellArea))
#DEFINE GTK_CELL_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_AREA, GtkCellAreaClass))
#DEFINE GTK_IS_CELL_AREA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_AREA))
#DEFINE GTK_IS_CELL_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_AREA))
#DEFINE GTK_CELL_AREA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_AREA, GtkCellAreaClass))

TYPE GtkCellArea AS _GtkCellArea
TYPE GtkCellAreaClass AS _GtkCellAreaClass
TYPE GtkCellAreaPrivate AS _GtkCellAreaPrivate
TYPE GtkCellAreaContext AS _GtkCellAreaContext

#DEFINE GTK_CELL_AREA_WARN_INVALID_CELL_PROPERTY_ID(object, property_id, pspec) _
  G_OBJECT_WARN_INVALID_PSPEC ((object), !"cell property id", (property_id), (pspec))

TYPE GtkCellCallback AS FUNCTION(BYVAL AS GtkCellRenderer PTR, BYVAL AS gpointer) AS gboolean
TYPE GtkCellAllocCallback AS FUNCTION(BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gpointer) AS gboolean

TYPE _GtkCellArea
  AS GInitiallyUnowned parent_instance
  AS GtkCellAreaPrivate PTR priv
END TYPE

TYPE _GtkCellAreaClass
  AS GInitiallyUnownedClass parent_class
  add_ AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR)
  remove AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR)
  foreach AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellCallback, BYVAL AS gpointer)
  foreach_alloc AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellAllocCallback, BYVAL AS gpointer)
  event AS FUNCTION(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS gint
  render AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState, BYVAL AS gboolean)
  apply_attributes AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gboolean, BYVAL AS gboolean)
  create_context AS FUNCTION(BYVAL AS GtkCellArea PTR) AS GtkCellAreaContext PTR
  copy_context AS FUNCTION(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR) AS GtkCellAreaContext PTR
  get_request_mode AS FUNCTION(BYVAL AS GtkCellArea PTR) AS GtkSizeRequestMode
  get_preferred_width AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_height_for_width AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_height AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_width_for_height AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  set_cell_property AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS guint, BYVAL AS CONST GValue PTR, BYVAL AS GParamSpec PTR)
  get_cell_property AS SUB(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS guint, BYVAL AS GValue PTR, BYVAL AS GParamSpec PTR)
  focus AS FUNCTION(BYVAL AS GtkCellArea PTR, BYVAL AS GtkDirectionType) AS gboolean
  is_activatable AS FUNCTION(BYVAL AS GtkCellArea PTR) AS gboolean
  activate AS FUNCTION(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState, BYVAL AS gboolean) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_area_get_type() AS GType
DECLARE SUB gtk_cell_area_add(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE SUB gtk_cell_area_remove(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE FUNCTION gtk_cell_area_has_renderer(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR) AS gboolean
DECLARE SUB gtk_cell_area_foreach(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellCallback, BYVAL AS gpointer)
DECLARE SUB gtk_cell_area_foreach_alloc(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellAllocCallback, BYVAL AS gpointer)
DECLARE FUNCTION gtk_cell_area_event(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS gint
DECLARE SUB gtk_cell_area_render(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState, BYVAL AS gboolean)
DECLARE SUB gtk_cell_area_get_cell_allocation(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gtk_cell_area_get_cell_at_position(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRectangle PTR) AS GtkCellRenderer PTR
DECLARE FUNCTION gtk_cell_area_create_context(BYVAL AS GtkCellArea PTR) AS GtkCellAreaContext PTR
DECLARE FUNCTION gtk_cell_area_copy_context(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR) AS GtkCellAreaContext PTR
DECLARE FUNCTION gtk_cell_area_get_request_mode(BYVAL AS GtkCellArea PTR) AS GtkSizeRequestMode
DECLARE SUB gtk_cell_area_get_preferred_width(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_get_preferred_height_for_width(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_get_preferred_height(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_get_preferred_width_for_height(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_cell_area_get_current_path_string(BYVAL AS GtkCellArea PTR) AS CONST gchar PTR
DECLARE SUB gtk_cell_area_apply_attributes(BYVAL AS GtkCellArea PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE SUB gtk_cell_area_attribute_connect(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_cell_area_attribute_disconnect(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_cell_area_class_install_cell_property(BYVAL AS GtkCellAreaClass PTR, BYVAL AS guint, BYVAL AS GParamSpec PTR)
DECLARE FUNCTION gtk_cell_area_class_find_cell_property(BYVAL AS GtkCellAreaClass PTR, BYVAL AS CONST gchar PTR) AS GParamSpec PTR
DECLARE FUNCTION gtk_cell_area_class_list_cell_properties(BYVAL AS GtkCellAreaClass PTR, BYVAL AS guint PTR) AS GParamSpec PTR PTR
DECLARE SUB gtk_cell_area_add_with_properties(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_cell_area_cell_set(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_cell_area_cell_get(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_cell_area_cell_set_valist(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB gtk_cell_area_cell_get_valist(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS va_list)
DECLARE SUB gtk_cell_area_cell_set_property(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
DECLARE SUB gtk_cell_area_cell_get_property(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE FUNCTION gtk_cell_area_is_activatable(BYVAL AS GtkCellArea PTR) AS gboolean
DECLARE FUNCTION gtk_cell_area_activate(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_cell_area_focus(BYVAL AS GtkCellArea PTR, BYVAL AS GtkDirectionType) AS gboolean
DECLARE SUB gtk_cell_area_set_focus_cell(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE FUNCTION gtk_cell_area_get_focus_cell(BYVAL AS GtkCellArea PTR) AS GtkCellRenderer PTR
DECLARE SUB gtk_cell_area_add_focus_sibling(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE SUB gtk_cell_area_remove_focus_sibling(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE FUNCTION gtk_cell_area_is_focus_sibling(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkCellRenderer PTR) AS gboolean
DECLARE FUNCTION gtk_cell_area_get_focus_siblings(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR) AS CONST GList PTR
DECLARE FUNCTION gtk_cell_area_get_focus_from_sibling(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR) AS GtkCellRenderer PTR
DECLARE FUNCTION gtk_cell_area_get_edited_cell(BYVAL AS GtkCellArea PTR) AS GtkCellRenderer PTR
DECLARE FUNCTION gtk_cell_area_get_edit_widget(BYVAL AS GtkCellArea PTR) AS GtkCellEditable PTR
DECLARE FUNCTION gtk_cell_area_activate_cell(BYVAL AS GtkCellArea PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GdkEvent PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GtkCellRendererState) AS gboolean
DECLARE SUB gtk_cell_area_stop_editing(BYVAL AS GtkCellArea PTR, BYVAL AS gboolean)
DECLARE SUB gtk_cell_area_inner_cell_area(BYVAL AS GtkCellArea PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_cell_area_request_renderer(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkOrientation, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB _gtk_cell_area_set_cell_data_func_with_proxy(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify, BYVAL AS gpointer)

#ENDIF ' __GTK_CELL_AREA_H__

#DEFINE GTK_TYPE_TREE_VIEW_COLUMN (gtk_tree_view_column_get_type ())
#DEFINE GTK_TREE_VIEW_COLUMN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumn))
#DEFINE GTK_TREE_VIEW_COLUMN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass))
#DEFINE GTK_IS_TREE_VIEW_COLUMN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_VIEW_COLUMN))
#DEFINE GTK_IS_TREE_VIEW_COLUMN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_VIEW_COLUMN))
#DEFINE GTK_TREE_VIEW_COLUMN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_VIEW_COLUMN, GtkTreeViewColumnClass))

TYPE GtkTreeViewColumn AS _GtkTreeViewColumn
TYPE GtkTreeViewColumnClass AS _GtkTreeViewColumnClass
TYPE GtkTreeViewColumnPrivate AS _GtkTreeViewColumnPrivate

ENUM GtkTreeViewColumnSizing
  GTK_TREE_VIEW_COLUMN_GROW_ONLY
  GTK_TREE_VIEW_COLUMN_AUTOSIZE
  GTK_TREE_VIEW_COLUMN_FIXED
END ENUM

TYPE GtkTreeCellDataFunc AS SUB(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer)

TYPE _GtkTreeViewColumn
  AS GInitiallyUnowned parent_instance
  AS GtkTreeViewColumnPrivate PTR priv
END TYPE

TYPE _GtkTreeViewColumnClass
  AS GInitiallyUnownedClass parent_class
  clicked AS SUB(BYVAL AS GtkTreeViewColumn PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tree_view_column_get_type() AS GType
DECLARE FUNCTION gtk_tree_view_column_new() AS GtkTreeViewColumn PTR
DECLARE FUNCTION gtk_tree_view_column_new_with_area(BYVAL AS GtkCellArea PTR) AS GtkTreeViewColumn PTR
DECLARE FUNCTION gtk_tree_view_column_new_with_attributes(BYVAL AS CONST gchar PTR, BYVAL AS GtkCellRenderer PTR, ...) AS GtkTreeViewColumn PTR
DECLARE SUB gtk_tree_view_column_pack_start(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_column_pack_end(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_column_clear(BYVAL AS GtkTreeViewColumn PTR)
DECLARE SUB gtk_tree_view_column_add_attribute(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_tree_view_column_set_attributes(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, ...)
DECLARE SUB gtk_tree_view_column_set_cell_data_func(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkTreeCellDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_view_column_clear_attributes(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE SUB gtk_tree_view_column_set_spacing(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_column_get_spacing(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE SUB gtk_tree_view_column_set_visible(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_column_get_visible(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_set_resizable(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_column_get_resizable(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_set_sizing(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkTreeViewColumnSizing)
DECLARE FUNCTION gtk_tree_view_column_get_sizing(BYVAL AS GtkTreeViewColumn PTR) AS GtkTreeViewColumnSizing
DECLARE FUNCTION gtk_tree_view_column_get_x_offset(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE FUNCTION gtk_tree_view_column_get_width(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE FUNCTION gtk_tree_view_column_get_fixed_width(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE SUB gtk_tree_view_column_set_fixed_width(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gint)
DECLARE SUB gtk_tree_view_column_set_min_width(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_column_get_min_width(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE SUB gtk_tree_view_column_set_max_width(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_column_get_max_width(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE SUB gtk_tree_view_column_clicked(BYVAL AS GtkTreeViewColumn PTR)
DECLARE SUB gtk_tree_view_column_set_title(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_tree_view_column_get_title(BYVAL AS GtkTreeViewColumn PTR) AS CONST gchar PTR
DECLARE SUB gtk_tree_view_column_set_expand(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_column_get_expand(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_set_clickable(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_column_get_clickable(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_set_widget(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_tree_view_column_get_widget(BYVAL AS GtkTreeViewColumn PTR) AS GtkWidget PTR
DECLARE SUB gtk_tree_view_column_set_alignment(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gfloat)
DECLARE FUNCTION gtk_tree_view_column_get_alignment(BYVAL AS GtkTreeViewColumn PTR) AS gfloat
DECLARE SUB gtk_tree_view_column_set_reorderable(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_column_get_reorderable(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_set_sort_column_id(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_column_get_sort_column_id(BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE SUB gtk_tree_view_column_set_sort_indicator(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_column_get_sort_indicator(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_set_sort_order(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkSortType)
DECLARE FUNCTION gtk_tree_view_column_get_sort_order(BYVAL AS GtkTreeViewColumn PTR) AS GtkSortType
DECLARE SUB gtk_tree_view_column_cell_set_cell_data(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_column_cell_get_size(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_tree_view_column_cell_is_visible(BYVAL AS GtkTreeViewColumn PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_focus_cell(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE FUNCTION gtk_tree_view_column_cell_get_position(BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gtk_tree_view_column_queue_resize(BYVAL AS GtkTreeViewColumn PTR)
DECLARE FUNCTION gtk_tree_view_column_get_tree_view(BYVAL AS GtkTreeViewColumn PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_tree_view_column_get_button(BYVAL AS GtkTreeViewColumn PTR) AS GtkWidget PTR

#ENDIF ' __GTK_TREE_VIEW_COLUMN_H__

#IFNDEF __GTK_DND_H__
#DEFINE __GTK_DND_H__

#IFNDEF __GTK_SELECTION_H__
#DEFINE __GTK_SELECTION_H__

#IFNDEF __GTK_TEXT_ITER_H__
#DEFINE __GTK_TEXT_ITER_H__

#IFNDEF __GTK_TEXT_ATTRIBUTES_H__
#DEFINE __GTK_TEXT_ATTRIBUTES_H__

TYPE GtkTextAttributes AS _GtkTextAttributes

#DEFINE GTK_TYPE_TEXT_ATTRIBUTES (gtk_text_attributes_get_type ())

TYPE GtkTextAppearance AS _GtkTextAppearance

TYPE _GtkTextAppearance
  AS GdkColor bg_color
  AS GdkColor fg_color
  AS gint rise
  AS guint underline : 4
  AS guint strikethrough : 1
  AS guint draw_bg : 1
  AS guint inside_selection : 1
  AS guint is_text : 1
  AS GdkRGBA PTR rgba_(1)
#IF __SIZEOF_INT__ = __SIZEOF_POINTER__
  AS guint padding(1)
#ENDIF ' __SIZEOF_INT__ ...
END TYPE

TYPE _GtkTextAttributes
  AS guint refcount
  AS GtkTextAppearance appearance
  AS GtkJustification justification
  AS GtkTextDirection direction
  AS PangoFontDescription PTR font
  AS gdouble font_scale
  AS gint left_margin
  AS gint right_margin
  AS gint indent
  AS gint pixels_above_lines
  AS gint pixels_below_lines
  AS gint pixels_inside_wrap
  AS PangoTabArray PTR tabs
  AS GtkWrapMode wrap_mode
  AS PangoLanguage PTR language
  AS GdkColor PTR pg_bg_color
  AS guint invisible : 1
  AS guint bg_full_height : 1
  AS guint editable : 1
  AS GdkRGBA PTR pg_bg_rgba
  AS guint padding(2)
END TYPE

DECLARE FUNCTION gtk_text_attributes_new() AS GtkTextAttributes PTR
DECLARE FUNCTION gtk_text_attributes_copy(BYVAL AS GtkTextAttributes PTR) AS GtkTextAttributes PTR
DECLARE SUB gtk_text_attributes_copy_values(BYVAL AS GtkTextAttributes PTR, BYVAL AS GtkTextAttributes PTR)
DECLARE SUB gtk_text_attributes_unref(BYVAL AS GtkTextAttributes PTR)
DECLARE FUNCTION gtk_text_attributes_ref(BYVAL AS GtkTextAttributes PTR) AS GtkTextAttributes PTR
DECLARE FUNCTION gtk_text_attributes_get_type() AS GType

#ENDIF ' __GTK_TEXT_ATTRIBUTES_H__

#IFNDEF __GTK_TEXT_CHILD_H__
#DEFINE __GTK_TEXT_CHILD_H__

TYPE GtkTextChildAnchor AS _GtkTextChildAnchor
TYPE GtkTextChildAnchorClass AS _GtkTextChildAnchorClass

#DEFINE GTK_TYPE_TEXT_CHILD_ANCHOR (gtk_text_child_anchor_get_type ())
#DEFINE GTK_TEXT_CHILD_ANCHOR(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchor))
#DEFINE GTK_TEXT_CHILD_ANCHOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass))
#DEFINE GTK_IS_TEXT_CHILD_ANCHOR(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_TEXT_CHILD_ANCHOR))
#DEFINE GTK_IS_TEXT_CHILD_ANCHOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_CHILD_ANCHOR))
#DEFINE GTK_TEXT_CHILD_ANCHOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass))

TYPE _GtkTextChildAnchor
  AS GObject parent_instance
  AS gpointer segment
END TYPE

TYPE _GtkTextChildAnchorClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_text_child_anchor_get_type() AS GType
DECLARE FUNCTION gtk_text_child_anchor_new() AS GtkTextChildAnchor PTR
DECLARE FUNCTION gtk_text_child_anchor_get_widgets(BYVAL AS GtkTextChildAnchor PTR) AS GList PTR
DECLARE FUNCTION gtk_text_child_anchor_get_deleted(BYVAL AS GtkTextChildAnchor PTR) AS gboolean

#ENDIF ' __GTK_TEXT_CHILD_H__

#IFNDEF __GTK_TEXT_TAG_H__
#DEFINE __GTK_TEXT_TAG_H__

TYPE GtkTextIter AS _GtkTextIter
TYPE GtkTextTagTable AS _GtkTextTagTable

#DEFINE GTK_TYPE_TEXT_TAG (gtk_text_tag_get_type ())
#DEFINE GTK_TEXT_TAG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_TAG, GtkTextTag))
#DEFINE GTK_TEXT_TAG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_TAG, GtkTextTagClass))
#DEFINE GTK_IS_TEXT_TAG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_TAG))
#DEFINE GTK_IS_TEXT_TAG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_TAG))
#DEFINE GTK_TEXT_TAG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_TAG, GtkTextTagClass))

TYPE GtkTextTag AS _GtkTextTag
TYPE GtkTextTagPrivate AS _GtkTextTagPrivate
TYPE GtkTextTagClass AS _GtkTextTagClass

TYPE _GtkTextTag
  AS GObject parent_instance
  AS GtkTextTagPrivate PTR priv
END TYPE

TYPE _GtkTextTagClass
  AS GObjectClass parent_class
  event AS FUNCTION(BYVAL AS GtkTextTag PTR, BYVAL AS GObject PTR, BYVAL AS GdkEvent PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_text_tag_get_type() AS GType
DECLARE FUNCTION gtk_text_tag_new(BYVAL AS CONST gchar PTR) AS GtkTextTag PTR
DECLARE FUNCTION gtk_text_tag_get_priority(BYVAL AS GtkTextTag PTR) AS gint
DECLARE SUB gtk_text_tag_set_priority(BYVAL AS GtkTextTag PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_tag_event(BYVAL AS GtkTextTag PTR, BYVAL AS GObject PTR, BYVAL AS GdkEvent PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean

#ENDIF ' __GTK_TEXT_TAG_H__

ENUM GtkTextSearchFlags
  GTK_TEXT_SEARCH_VISIBLE_ONLY = 1 SHL 0
  GTK_TEXT_SEARCH_TEXT_ONLY = 1 SHL 1
  GTK_TEXT_SEARCH_CASE_INSENSITIVE = 1 SHL 2
END ENUM

TYPE GtkTextBuffer AS _GtkTextBuffer

#DEFINE GTK_TYPE_TEXT_ITER (gtk_text_iter_get_type ())

TYPE _GtkTextIter
  AS gpointer dummy1
  AS gpointer dummy2
  AS gint dummy3
  AS gint dummy4
  AS gint dummy5
  AS gint dummy6
  AS gint dummy7
  AS gint dummy8
  AS gpointer dummy9
  AS gpointer dummy10
  AS gint dummy11
  AS gint dummy12
  AS gint dummy13
  AS gpointer dummy14
END TYPE

DECLARE FUNCTION gtk_text_iter_get_buffer(BYVAL AS CONST GtkTextIter PTR) AS GtkTextBuffer PTR
DECLARE FUNCTION gtk_text_iter_copy(BYVAL AS CONST GtkTextIter PTR) AS GtkTextIter PTR
DECLARE SUB gtk_text_iter_free(BYVAL AS GtkTextIter PTR)
DECLARE SUB gtk_text_iter_assign(BYVAL AS GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE FUNCTION gtk_text_iter_get_type() AS GType
DECLARE FUNCTION gtk_text_iter_get_offset(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_line(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_line_offset(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_line_index(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_visible_line_offset(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_visible_line_index(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_char(BYVAL AS CONST GtkTextIter PTR) AS gunichar
DECLARE FUNCTION gtk_text_iter_get_slice(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gchar PTR
DECLARE FUNCTION gtk_text_iter_get_text(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gchar PTR
DECLARE FUNCTION gtk_text_iter_get_visible_slice(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gchar PTR
DECLARE FUNCTION gtk_text_iter_get_visible_text(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gchar PTR
DECLARE FUNCTION gtk_text_iter_get_pixbuf(BYVAL AS CONST GtkTextIter PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_text_iter_get_marks(BYVAL AS CONST GtkTextIter PTR) AS GSList PTR
DECLARE FUNCTION gtk_text_iter_get_child_anchor(BYVAL AS CONST GtkTextIter PTR) AS GtkTextChildAnchor PTR
DECLARE FUNCTION gtk_text_iter_get_toggled_tags(BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS GSList PTR
DECLARE FUNCTION gtk_text_iter_begins_tag(BYVAL AS CONST GtkTextIter PTR, BYVAL AS GtkTextTag PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_ends_tag(BYVAL AS CONST GtkTextIter PTR, BYVAL AS GtkTextTag PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_toggles_tag(BYVAL AS CONST GtkTextIter PTR, BYVAL AS GtkTextTag PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_has_tag(BYVAL AS CONST GtkTextIter PTR, BYVAL AS GtkTextTag PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_get_tags(BYVAL AS CONST GtkTextIter PTR) AS GSList PTR
DECLARE FUNCTION gtk_text_iter_editable(BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_text_iter_can_insert(BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_text_iter_starts_word(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_ends_word(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_inside_word(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_starts_sentence(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_ends_sentence(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_inside_sentence(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_starts_line(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_ends_line(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_is_cursor_position(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_get_chars_in_line(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_bytes_in_line(BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_get_attributes(BYVAL AS CONST GtkTextIter PTR, BYVAL AS GtkTextAttributes PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_get_language(BYVAL AS CONST GtkTextIter PTR) AS PangoLanguage PTR
DECLARE FUNCTION gtk_text_iter_is_end(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_is_start(BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_char(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_char(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_chars(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_chars(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_line(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_line(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_lines(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_lines(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_word_end(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_word_start(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_word_ends(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_word_starts(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_visible_line(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_visible_line(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_visible_lines(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_visible_lines(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_visible_word_end(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_visible_word_start(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_visible_word_ends(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_visible_word_starts(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_sentence_end(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_sentence_start(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_sentence_ends(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_sentence_starts(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_cursor_position(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_cursor_position(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_cursor_positions(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_cursor_positions(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_visible_cursor_position(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_visible_cursor_position(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_visible_cursor_positions(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_visible_cursor_positions(BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE SUB gtk_text_iter_set_offset(BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_iter_set_line(BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_iter_set_line_offset(BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_iter_set_line_index(BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_iter_forward_to_end(BYVAL AS GtkTextIter PTR)
DECLARE FUNCTION gtk_text_iter_forward_to_line_end(BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE SUB gtk_text_iter_set_visible_line_offset(BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_iter_set_visible_line_index(BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_iter_forward_to_tag_toggle(BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextTag PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_to_tag_toggle(BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextTag PTR) AS gboolean

TYPE GtkTextCharPredicate AS FUNCTION(BYVAL AS gunichar, BYVAL AS gpointer) AS gboolean

DECLARE FUNCTION gtk_text_iter_forward_find_char(BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextCharPredicate, BYVAL AS gpointer, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_find_char(BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextCharPredicate, BYVAL AS gpointer, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_forward_search(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkTextSearchFlags, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_backward_search(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkTextSearchFlags, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_equal(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_iter_compare(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gint
DECLARE FUNCTION gtk_text_iter_in_range(BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE SUB gtk_text_iter_order(BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)

#ENDIF ' __GTK_TEXT_ITER_H__

TYPE GtkTargetList AS _GtkTargetList
TYPE GtkTargetEntry AS _GtkTargetEntry

#DEFINE GTK_TYPE_SELECTION_DATA (gtk_selection_data_get_type ())
#DEFINE GTK_TYPE_TARGET_LIST (gtk_target_list_get_type ())

TYPE _GtkTargetEntry
  AS gchar PTR target
  AS guint flags
  AS guint info
END TYPE

DECLARE FUNCTION gtk_target_list_get_type() AS GType
DECLARE FUNCTION gtk_target_list_new(BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS guint) AS GtkTargetList PTR
DECLARE FUNCTION gtk_target_list_ref(BYVAL AS GtkTargetList PTR) AS GtkTargetList PTR
DECLARE SUB gtk_target_list_unref(BYVAL AS GtkTargetList PTR)
DECLARE SUB gtk_target_list_add(BYVAL AS GtkTargetList PTR, BYVAL AS GdkAtom, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_target_list_add_text_targets(BYVAL AS GtkTargetList PTR, BYVAL AS guint)
DECLARE SUB gtk_target_list_add_rich_text_targets(BYVAL AS GtkTargetList PTR, BYVAL AS guint, BYVAL AS gboolean, BYVAL AS GtkTextBuffer PTR)
DECLARE SUB gtk_target_list_add_image_targets(BYVAL AS GtkTargetList PTR, BYVAL AS guint, BYVAL AS gboolean)
DECLARE SUB gtk_target_list_add_uri_targets(BYVAL AS GtkTargetList PTR, BYVAL AS guint)
DECLARE SUB gtk_target_list_add_table(BYVAL AS GtkTargetList PTR, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS guint)
DECLARE SUB gtk_target_list_remove(BYVAL AS GtkTargetList PTR, BYVAL AS GdkAtom)
DECLARE FUNCTION gtk_target_list_find(BYVAL AS GtkTargetList PTR, BYVAL AS GdkAtom, BYVAL AS guint PTR) AS gboolean
DECLARE FUNCTION gtk_target_table_new_from_list(BYVAL AS GtkTargetList PTR, BYVAL AS gint PTR) AS GtkTargetEntry PTR
DECLARE SUB gtk_target_table_free(BYVAL AS GtkTargetEntry PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_selection_owner_set(BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom, BYVAL AS guint32) AS gboolean
DECLARE FUNCTION gtk_selection_owner_set_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom, BYVAL AS guint32) AS gboolean
DECLARE SUB gtk_selection_add_target(BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint)
DECLARE SUB gtk_selection_add_targets(BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS guint)
DECLARE SUB gtk_selection_clear_targets(BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom)
DECLARE FUNCTION gtk_selection_convert(BYVAL AS GtkWidget PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32) AS gboolean
DECLARE SUB gtk_selection_remove_all(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_selection_data_get_selection(BYVAL AS CONST GtkSelectionData PTR) AS GdkAtom
DECLARE FUNCTION gtk_selection_data_get_target(BYVAL AS CONST GtkSelectionData PTR) AS GdkAtom
DECLARE FUNCTION gtk_selection_data_get_data_type(BYVAL AS CONST GtkSelectionData PTR) AS GdkAtom
DECLARE FUNCTION gtk_selection_data_get_format(BYVAL AS CONST GtkSelectionData PTR) AS gint
DECLARE FUNCTION gtk_selection_data_get_data(BYVAL AS CONST GtkSelectionData PTR) AS CONST guchar PTR
DECLARE FUNCTION gtk_selection_data_get_length(BYVAL AS CONST GtkSelectionData PTR) AS gint
DECLARE FUNCTION gtk_selection_data_get_data_with_length(BYVAL AS CONST GtkSelectionData PTR, BYVAL AS gint PTR) AS CONST guchar PTR
DECLARE FUNCTION gtk_selection_data_get_display(BYVAL AS CONST GtkSelectionData PTR) AS GdkDisplay PTR
DECLARE SUB gtk_selection_data_set(BYVAL AS GtkSelectionData PTR, BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS CONST guchar PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_selection_data_set_text(BYVAL AS GtkSelectionData PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_selection_data_get_text(BYVAL AS CONST GtkSelectionData PTR) AS guchar PTR
DECLARE FUNCTION gtk_selection_data_set_pixbuf(BYVAL AS GtkSelectionData PTR, BYVAL AS GdkPixbuf PTR) AS gboolean
DECLARE FUNCTION gtk_selection_data_get_pixbuf(BYVAL AS CONST GtkSelectionData PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_selection_data_set_uris(BYVAL AS GtkSelectionData PTR, BYVAL AS gchar PTR PTR) AS gboolean
DECLARE FUNCTION gtk_selection_data_get_uris(BYVAL AS CONST GtkSelectionData PTR) AS gchar PTR PTR
DECLARE FUNCTION gtk_selection_data_get_targets(BYVAL AS CONST GtkSelectionData PTR, BYVAL AS GdkAtom PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_selection_data_targets_include_text(BYVAL AS CONST GtkSelectionData PTR) AS gboolean
DECLARE FUNCTION gtk_selection_data_targets_include_rich_text(BYVAL AS CONST GtkSelectionData PTR, BYVAL AS GtkTextBuffer PTR) AS gboolean
DECLARE FUNCTION gtk_selection_data_targets_include_image(BYVAL AS CONST GtkSelectionData PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_selection_data_targets_include_uri(BYVAL AS CONST GtkSelectionData PTR) AS gboolean
DECLARE FUNCTION gtk_targets_include_text(BYVAL AS GdkAtom PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_targets_include_rich_text(BYVAL AS GdkAtom PTR, BYVAL AS gint, BYVAL AS GtkTextBuffer PTR) AS gboolean
DECLARE FUNCTION gtk_targets_include_image(BYVAL AS GdkAtom PTR, BYVAL AS gint, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_targets_include_uri(BYVAL AS GdkAtom PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_selection_data_get_type() AS GType
DECLARE FUNCTION gtk_selection_data_copy(BYVAL AS CONST GtkSelectionData PTR) AS GtkSelectionData PTR
DECLARE SUB gtk_selection_data_free(BYVAL AS GtkSelectionData PTR)
DECLARE FUNCTION gtk_target_entry_get_type() AS GType
DECLARE FUNCTION gtk_target_entry_new(BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS guint) AS GtkTargetEntry PTR
DECLARE FUNCTION gtk_target_entry_copy(BYVAL AS GtkTargetEntry PTR) AS GtkTargetEntry PTR
DECLARE SUB gtk_target_entry_free(BYVAL AS GtkTargetEntry PTR)

#ENDIF ' __GTK_SELECTION_H__

ENUM GtkDestDefaults
  GTK_DEST_DEFAULT_MOTION = 1 SHL 0
  GTK_DEST_DEFAULT_HIGHLIGHT = 1 SHL 1
  GTK_DEST_DEFAULT_DROP = 1 SHL 2
  GTK_DEST_DEFAULT_ALL = &h07
END ENUM

ENUM GtkTargetFlags
  GTK_TARGET_SAME_APP = 1 SHL 0
  GTK_TARGET_SAME_WIDGET = 1 SHL 1
  GTK_TARGET_OTHER_APP = 1 SHL 2
  GTK_TARGET_OTHER_WIDGET = 1 SHL 3
END ENUM

DECLARE SUB gtk_drag_get_data(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS GdkAtom, BYVAL AS guint32)
DECLARE SUB gtk_drag_finish(BYVAL AS GdkDragContext PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS guint32)
DECLARE FUNCTION gtk_drag_get_source_widget(BYVAL AS GdkDragContext PTR) AS GtkWidget PTR
DECLARE SUB gtk_drag_highlight(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_unhighlight(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_dest_set(BYVAL AS GtkWidget PTR, BYVAL AS GtkDestDefaults, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint, BYVAL AS GdkDragAction)
DECLARE SUB gtk_drag_dest_set_proxy(BYVAL AS GtkWidget PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkDragProtocol, BYVAL AS gboolean)
DECLARE SUB gtk_drag_dest_unset(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_drag_dest_find_target(BYVAL AS GtkWidget PTR, BYVAL AS GdkDragContext PTR, BYVAL AS GtkTargetList PTR) AS GdkAtom
DECLARE FUNCTION gtk_drag_dest_get_target_list(BYVAL AS GtkWidget PTR) AS GtkTargetList PTR
DECLARE SUB gtk_drag_dest_set_target_list(BYVAL AS GtkWidget PTR, BYVAL AS GtkTargetList PTR)
DECLARE SUB gtk_drag_dest_add_text_targets(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_dest_add_image_targets(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_dest_add_uri_targets(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_dest_set_track_motion(BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_drag_dest_get_track_motion(BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_drag_source_set(BYVAL AS GtkWidget PTR, BYVAL AS GdkModifierType, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint, BYVAL AS GdkDragAction)
DECLARE SUB gtk_drag_source_unset(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_drag_source_get_target_list(BYVAL AS GtkWidget PTR) AS GtkTargetList PTR
DECLARE SUB gtk_drag_source_set_target_list(BYVAL AS GtkWidget PTR, BYVAL AS GtkTargetList PTR)
DECLARE SUB gtk_drag_source_add_text_targets(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_source_add_image_targets(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_source_add_uri_targets(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_drag_source_set_icon_pixbuf(BYVAL AS GtkWidget PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_drag_source_set_icon_stock(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_drag_source_set_icon_name(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_drag_source_set_icon_gicon(BYVAL AS GtkWidget PTR, BYVAL AS GIcon PTR)
DECLARE FUNCTION gtk_drag_begin(BYVAL AS GtkWidget PTR, BYVAL AS GtkTargetList PTR, BYVAL AS GdkDragAction, BYVAL AS gint, BYVAL AS GdkEvent PTR) AS GdkDragContext PTR
DECLARE SUB gtk_drag_set_icon_widget(BYVAL AS GdkDragContext PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_drag_set_icon_pixbuf(BYVAL AS GdkDragContext PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_drag_set_icon_stock(BYVAL AS GdkDragContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_drag_set_icon_surface(BYVAL AS GdkDragContext PTR, BYVAL AS cairo_surface_t PTR)
DECLARE SUB gtk_drag_set_icon_name(BYVAL AS GdkDragContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_drag_set_icon_gicon(BYVAL AS GdkDragContext PTR, BYVAL AS GIcon PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_drag_set_icon_default(BYVAL AS GdkDragContext PTR)
DECLARE FUNCTION gtk_drag_check_threshold(BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS gboolean
DECLARE SUB _gtk_drag_source_handle_event(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR)
DECLARE SUB _gtk_drag_dest_handle_event(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR)

#ENDIF ' __GTK_DND_H__

#IFNDEF __GTK_ENTRY_H__
#DEFINE __GTK_ENTRY_H__

#IFNDEF __GTK_EDITABLE_H__
#DEFINE __GTK_EDITABLE_H__

#DEFINE GTK_TYPE_EDITABLE (gtk_editable_get_type ())
#DEFINE GTK_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EDITABLE, GtkEditable))
#DEFINE GTK_IS_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EDITABLE))
#DEFINE GTK_EDITABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_EDITABLE, GtkEditableInterface))

TYPE GtkEditable AS _GtkEditable
TYPE GtkEditableInterface AS _GtkEditableInterface

TYPE _GtkEditableInterface
  AS GTypeInterface base_iface
  insert_text AS SUB(BYVAL AS GtkEditable PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR)
  delete_text AS SUB(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint)
  changed AS SUB(BYVAL AS GtkEditable PTR)
  do_insert_text AS SUB(BYVAL AS GtkEditable PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR)
  do_delete_text AS SUB(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint)
  get_chars AS FUNCTION(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint) AS gchar PTR
  set_selection_bounds AS SUB(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint)
  get_selection_bounds AS FUNCTION(BYVAL AS GtkEditable PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
  set_position AS SUB(BYVAL AS GtkEditable PTR, BYVAL AS gint)
  get_position AS FUNCTION(BYVAL AS GtkEditable PTR) AS gint
END TYPE

DECLARE FUNCTION gtk_editable_get_type() AS GType
DECLARE SUB gtk_editable_select_region(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_editable_get_selection_bounds(BYVAL AS GtkEditable PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gtk_editable_insert_text(BYVAL AS GtkEditable PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR)
DECLARE SUB gtk_editable_delete_text(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_editable_get_chars(BYVAL AS GtkEditable PTR, BYVAL AS gint, BYVAL AS gint) AS gchar PTR
DECLARE SUB gtk_editable_cut_clipboard(BYVAL AS GtkEditable PTR)
DECLARE SUB gtk_editable_copy_clipboard(BYVAL AS GtkEditable PTR)
DECLARE SUB gtk_editable_paste_clipboard(BYVAL AS GtkEditable PTR)
DECLARE SUB gtk_editable_delete_selection(BYVAL AS GtkEditable PTR)
DECLARE SUB gtk_editable_set_position(BYVAL AS GtkEditable PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_editable_get_position(BYVAL AS GtkEditable PTR) AS gint
DECLARE SUB gtk_editable_set_editable(BYVAL AS GtkEditable PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_editable_get_editable(BYVAL AS GtkEditable PTR) AS gboolean

#ENDIF ' __GTK_EDITABLE_H__

#IFNDEF __GTK_IM_CONTEXT_H__
#DEFINE __GTK_IM_CONTEXT_H__

#DEFINE GTK_TYPE_IM_CONTEXT (gtk_im_context_get_type ())
#DEFINE GTK_IM_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_CONTEXT, GtkIMContext))
#DEFINE GTK_IM_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_CONTEXT, GtkIMContextClass))
#DEFINE GTK_IS_IM_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_CONTEXT))
#DEFINE GTK_IS_IM_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_CONTEXT))
#DEFINE GTK_IM_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_CONTEXT, GtkIMContextClass))

TYPE GtkIMContext AS _GtkIMContext
TYPE GtkIMContextClass AS _GtkIMContextClass

TYPE _GtkIMContext
  AS GObject parent_instance
END TYPE

TYPE _GtkIMContextClass
  AS GObjectClass parent_class
  preedit_start AS SUB(BYVAL AS GtkIMContext PTR)
  preedit_end AS SUB(BYVAL AS GtkIMContext PTR)
  preedit_changed AS SUB(BYVAL AS GtkIMContext PTR)
  commit AS SUB(BYVAL AS GtkIMContext PTR, BYVAL AS CONST gchar PTR)
  retrieve_surrounding AS FUNCTION(BYVAL AS GtkIMContext PTR) AS gboolean
  delete_surrounding AS FUNCTION(BYVAL AS GtkIMContext PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean
  set_client_window AS SUB(BYVAL AS GtkIMContext PTR, BYVAL AS GdkWindow PTR)
  get_preedit_string AS SUB(BYVAL AS GtkIMContext PTR, BYVAL AS gchar PTR PTR, BYVAL AS PangoAttrList PTR PTR, BYVAL AS gint PTR)
  filter_keypress AS FUNCTION(BYVAL AS GtkIMContext PTR, BYVAL AS GdkEventKey PTR) AS gboolean
  focus_in AS SUB(BYVAL AS GtkIMContext PTR)
  focus_out AS SUB(BYVAL AS GtkIMContext PTR)
  reset_ AS SUB(BYVAL AS GtkIMContext PTR)
  set_cursor_location AS SUB(BYVAL AS GtkIMContext PTR, BYVAL AS GdkRectangle PTR)
  set_use_preedit AS SUB(BYVAL AS GtkIMContext PTR, BYVAL AS gboolean)
  set_surrounding AS SUB(BYVAL AS GtkIMContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint)
  get_surrounding AS FUNCTION(BYVAL AS GtkIMContext PTR, BYVAL AS gchar PTR PTR, BYVAL AS gint PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
END TYPE

DECLARE FUNCTION gtk_im_context_get_type() AS GType
DECLARE SUB gtk_im_context_set_client_window(BYVAL AS GtkIMContext PTR, BYVAL AS GdkWindow PTR)
DECLARE SUB gtk_im_context_get_preedit_string(BYVAL AS GtkIMContext PTR, BYVAL AS gchar PTR PTR, BYVAL AS PangoAttrList PTR PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_im_context_filter_keypress(BYVAL AS GtkIMContext PTR, BYVAL AS GdkEventKey PTR) AS gboolean
DECLARE SUB gtk_im_context_focus_in(BYVAL AS GtkIMContext PTR)
DECLARE SUB gtk_im_context_focus_out(BYVAL AS GtkIMContext PTR)
DECLARE SUB gtk_im_context_reset(BYVAL AS GtkIMContext PTR)
DECLARE SUB gtk_im_context_set_cursor_location(BYVAL AS GtkIMContext PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gtk_im_context_set_use_preedit(BYVAL AS GtkIMContext PTR, BYVAL AS gboolean)
DECLARE SUB gtk_im_context_set_surrounding(BYVAL AS GtkIMContext PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_im_context_get_surrounding(BYVAL AS GtkIMContext PTR, BYVAL AS gchar PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_im_context_delete_surrounding(BYVAL AS GtkIMContext PTR, BYVAL AS gint, BYVAL AS gint) AS gboolean

#ENDIF ' __GTK_IM_CONTEXT_H__

#IFNDEF __GTK_ENTRY_BUFFER_H__
#DEFINE __GTK_ENTRY_BUFFER_H__

#DEFINE GTK_ENTRY_BUFFER_MAX_SIZE G_MAXUSHORT
#DEFINE GTK_TYPE_ENTRY_BUFFER (gtk_entry_buffer_get_type ())
#DEFINE GTK_ENTRY_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ENTRY_BUFFER, GtkEntryBuffer))
#DEFINE GTK_ENTRY_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ENTRY_BUFFER, GtkEntryBufferClass))
#DEFINE GTK_IS_ENTRY_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ENTRY_BUFFER))
#DEFINE GTK_IS_ENTRY_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ENTRY_BUFFER))
#DEFINE GTK_ENTRY_BUFFER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ENTRY_BUFFER, GtkEntryBufferClass))

TYPE GtkEntryBuffer AS _GtkEntryBuffer
TYPE GtkEntryBufferClass AS _GtkEntryBufferClass
TYPE GtkEntryBufferPrivate AS _GtkEntryBufferPrivate

TYPE _GtkEntryBuffer
  AS GObject parent_instance
  AS GtkEntryBufferPrivate PTR priv
END TYPE

TYPE _GtkEntryBufferClass
  AS GObjectClass parent_class
  inserted_text AS SUB(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS guint)
  deleted_text AS SUB(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS guint)
  get_text AS FUNCTION(BYVAL AS GtkEntryBuffer PTR, BYVAL AS gsize PTR) AS CONST gchar PTR
  get_length AS FUNCTION(BYVAL AS GtkEntryBuffer PTR) AS guint
  insert_text AS FUNCTION(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS guint) AS guint
  delete_text AS FUNCTION(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS guint) AS guint
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_entry_buffer_get_type() AS GType
DECLARE FUNCTION gtk_entry_buffer_new(BYVAL AS CONST gchar PTR, BYVAL AS gint) AS GtkEntryBuffer PTR
DECLARE FUNCTION gtk_entry_buffer_get_bytes(BYVAL AS GtkEntryBuffer PTR) AS gsize
DECLARE FUNCTION gtk_entry_buffer_get_length(BYVAL AS GtkEntryBuffer PTR) AS guint
DECLARE FUNCTION gtk_entry_buffer_get_text(BYVAL AS GtkEntryBuffer PTR) AS CONST gchar PTR
DECLARE SUB gtk_entry_buffer_set_text(BYVAL AS GtkEntryBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_entry_buffer_set_max_length(BYVAL AS GtkEntryBuffer PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_entry_buffer_get_max_length(BYVAL AS GtkEntryBuffer PTR) AS gint
DECLARE FUNCTION gtk_entry_buffer_insert_text(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS guint
DECLARE FUNCTION gtk_entry_buffer_delete_text(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS gint) AS guint
DECLARE SUB gtk_entry_buffer_emit_inserted_text(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS guint)
DECLARE SUB gtk_entry_buffer_emit_deleted_text(BYVAL AS GtkEntryBuffer PTR, BYVAL AS guint, BYVAL AS guint)

#ENDIF ' __GTK_ENTRY_BUFFER_H__

#IFNDEF __GTK_ENTRY_COMPLETION_H__
#DEFINE __GTK_ENTRY_COMPLETION_H__

#IFNDEF __GTK_LIST_STORE_H__
#DEFINE __GTK_LIST_STORE_H__

#DEFINE GTK_TYPE_LIST_STORE (gtk_list_store_get_type ())
#DEFINE GTK_LIST_STORE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LIST_STORE, GtkListStore))
#DEFINE GTK_LIST_STORE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_LIST_STORE, GtkListStoreClass))
#DEFINE GTK_IS_LIST_STORE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LIST_STORE))
#DEFINE GTK_IS_LIST_STORE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LIST_STORE))
#DEFINE GTK_LIST_STORE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_LIST_STORE, GtkListStoreClass))

TYPE GtkListStore AS _GtkListStore
TYPE GtkListStorePrivate AS _GtkListStorePrivate
TYPE GtkListStoreClass AS _GtkListStoreClass

TYPE _GtkListStore
  AS GObject parent
  AS GtkListStorePrivate PTR priv
END TYPE

TYPE _GtkListStoreClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_list_store_get_type() AS GType
DECLARE FUNCTION gtk_list_store_new(BYVAL AS gint, ...) AS GtkListStore PTR
DECLARE FUNCTION gtk_list_store_newv(BYVAL AS gint, BYVAL AS GType PTR) AS GtkListStore PTR
DECLARE SUB gtk_list_store_set_column_types(BYVAL AS GtkListStore PTR, BYVAL AS gint, BYVAL AS GType PTR)
DECLARE SUB gtk_list_store_set_value(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, BYVAL AS GValue PTR)
DECLARE SUB gtk_list_store_set(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, ...)
DECLARE SUB gtk_list_store_set_valuesv(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint PTR, BYVAL AS GValue PTR, BYVAL AS gint)
DECLARE SUB gtk_list_store_set_valist(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS va_list)
DECLARE FUNCTION gtk_list_store_remove(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_list_store_insert(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint)
DECLARE SUB gtk_list_store_insert_before(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_list_store_insert_after(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_list_store_insert_with_values(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, ...)
DECLARE SUB gtk_list_store_insert_with_valuesv(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS GValue PTR, BYVAL AS gint)
DECLARE SUB gtk_list_store_prepend(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_list_store_append(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_list_store_clear(BYVAL AS GtkListStore PTR)
DECLARE FUNCTION gtk_list_store_iter_is_valid(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_list_store_reorder(BYVAL AS GtkListStore PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_list_store_swap(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_list_store_move_after(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_list_store_move_before(BYVAL AS GtkListStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)

#ENDIF ' __GTK_LIST_STORE_H__

#IFNDEF __GTK_TREE_MODEL_FILTER_H__
#DEFINE __GTK_TREE_MODEL_FILTER_H__

#DEFINE GTK_TYPE_TREE_MODEL_FILTER (gtk_tree_model_filter_get_type ())
#DEFINE GTK_TREE_MODEL_FILTER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilter))
#DEFINE GTK_TREE_MODEL_FILTER_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilterClass))
#DEFINE GTK_IS_TREE_MODEL_FILTER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_MODEL_FILTER))
#DEFINE GTK_IS_TREE_MODEL_FILTER_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_TREE_MODEL_FILTER))
#DEFINE GTK_TREE_MODEL_FILTER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_MODEL_FILTER, GtkTreeModelFilterClass))

TYPE GtkTreeModelFilterVisibleFunc AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer) AS gboolean
TYPE GtkTreeModelFilterModifyFunc AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GValue PTR, BYVAL AS gint, BYVAL AS gpointer)
TYPE GtkTreeModelFilter AS _GtkTreeModelFilter
TYPE GtkTreeModelFilterClass AS _GtkTreeModelFilterClass
TYPE GtkTreeModelFilterPrivate AS _GtkTreeModelFilterPrivate

TYPE _GtkTreeModelFilter
  AS GObject parent
  AS GtkTreeModelFilterPrivate PTR priv
END TYPE

TYPE _GtkTreeModelFilterClass
  AS GObjectClass parent_class
  visible AS FUNCTION(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  modify AS SUB(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GValue PTR, BYVAL AS gint)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tree_model_filter_get_type() AS GType
DECLARE FUNCTION gtk_tree_model_filter_new(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR) AS GtkTreeModel PTR
DECLARE SUB gtk_tree_model_filter_set_visible_func(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreeModelFilterVisibleFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_model_filter_set_modify_func(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS gint, BYVAL AS GType PTR, BYVAL AS GtkTreeModelFilterModifyFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_model_filter_set_visible_column(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_model_filter_get_model(BYVAL AS GtkTreeModelFilter PTR) AS GtkTreeModel PTR
DECLARE FUNCTION gtk_tree_model_filter_convert_child_iter_to_iter(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_tree_model_filter_convert_iter_to_child_iter(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE FUNCTION gtk_tree_model_filter_convert_child_path_to_path(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreePath PTR) AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_model_filter_convert_path_to_child_path(BYVAL AS GtkTreeModelFilter PTR, BYVAL AS GtkTreePath PTR) AS GtkTreePath PTR
DECLARE SUB gtk_tree_model_filter_refilter(BYVAL AS GtkTreeModelFilter PTR)
DECLARE SUB gtk_tree_model_filter_clear_cache(BYVAL AS GtkTreeModelFilter PTR)

#ENDIF ' __GTK_TREE_MODEL_FILTER_H__

#DEFINE GTK_TYPE_ENTRY_COMPLETION (gtk_entry_completion_get_type ())
#DEFINE GTK_ENTRY_COMPLETION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ENTRY_COMPLETION, GtkEntryCompletion))
#DEFINE GTK_ENTRY_COMPLETION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ENTRY_COMPLETION, GtkEntryCompletionClass))
#DEFINE GTK_IS_ENTRY_COMPLETION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ENTRY_COMPLETION))
#DEFINE GTK_IS_ENTRY_COMPLETION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ENTRY_COMPLETION))
#DEFINE GTK_ENTRY_COMPLETION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ENTRY_COMPLETION, GtkEntryCompletionClass))

TYPE GtkEntryCompletion AS _GtkEntryCompletion
TYPE GtkEntryCompletionClass AS _GtkEntryCompletionClass
TYPE GtkEntryCompletionPrivate AS _GtkEntryCompletionPrivate
TYPE GtkEntryCompletionMatchFunc AS FUNCTION(BYVAL AS GtkEntryCompletion PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer) AS gboolean

TYPE _GtkEntryCompletion
  AS GObject parent_instance
  AS GtkEntryCompletionPrivate PTR priv
END TYPE

TYPE _GtkEntryCompletionClass
  AS GObjectClass parent_class
  match_selected AS FUNCTION(BYVAL AS GtkEntryCompletion PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  action_activated AS SUB(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gint)
  insert_prefix AS FUNCTION(BYVAL AS GtkEntryCompletion PTR, BYVAL AS CONST gchar PTR) AS gboolean
  cursor_on_match AS FUNCTION(BYVAL AS GtkEntryCompletion PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
  _gtk_reserved0 AS SUB()
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
END TYPE

DECLARE FUNCTION gtk_entry_completion_get_type() AS GType
DECLARE FUNCTION gtk_entry_completion_new() AS GtkEntryCompletion PTR
DECLARE FUNCTION gtk_entry_completion_new_with_area(BYVAL AS GtkCellArea PTR) AS GtkEntryCompletion PTR
DECLARE FUNCTION gtk_entry_completion_get_entry(BYVAL AS GtkEntryCompletion PTR) AS GtkWidget PTR
DECLARE SUB gtk_entry_completion_set_model(BYVAL AS GtkEntryCompletion PTR, BYVAL AS GtkTreeModel PTR)
DECLARE FUNCTION gtk_entry_completion_get_model(BYVAL AS GtkEntryCompletion PTR) AS GtkTreeModel PTR
DECLARE SUB gtk_entry_completion_set_match_func(BYVAL AS GtkEntryCompletion PTR, BYVAL AS GtkEntryCompletionMatchFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_entry_completion_set_minimum_key_length(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_entry_completion_get_minimum_key_length(BYVAL AS GtkEntryCompletion PTR) AS gint
DECLARE SUB gtk_entry_completion_complete(BYVAL AS GtkEntryCompletion PTR)
DECLARE SUB gtk_entry_completion_insert_prefix(BYVAL AS GtkEntryCompletion PTR)
DECLARE SUB gtk_entry_completion_insert_action_text(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_entry_completion_insert_action_markup(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_entry_completion_delete_action(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gint)
DECLARE SUB gtk_entry_completion_set_inline_completion(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_completion_get_inline_completion(BYVAL AS GtkEntryCompletion PTR) AS gboolean
DECLARE SUB gtk_entry_completion_set_inline_selection(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_completion_get_inline_selection(BYVAL AS GtkEntryCompletion PTR) AS gboolean
DECLARE SUB gtk_entry_completion_set_popup_completion(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_completion_get_popup_completion(BYVAL AS GtkEntryCompletion PTR) AS gboolean
DECLARE SUB gtk_entry_completion_set_popup_set_width(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_completion_get_popup_set_width(BYVAL AS GtkEntryCompletion PTR) AS gboolean
DECLARE SUB gtk_entry_completion_set_popup_single_match(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_completion_get_popup_single_match(BYVAL AS GtkEntryCompletion PTR) AS gboolean
DECLARE FUNCTION gtk_entry_completion_get_completion_prefix(BYVAL AS GtkEntryCompletion PTR) AS CONST gchar PTR
DECLARE SUB gtk_entry_completion_set_text_column(BYVAL AS GtkEntryCompletion PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_entry_completion_get_text_column(BYVAL AS GtkEntryCompletion PTR) AS gint

#ENDIF ' __GTK_ENTRY_COMPLETION_H__

#IFNDEF __GTK_IMAGE_H__
#DEFINE __GTK_IMAGE_H__

#DEFINE GTK_TYPE_IMAGE (gtk_image_get_type ())
#DEFINE GTK_IMAGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IMAGE, GtkImage))
#DEFINE GTK_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IMAGE, GtkImageClass))
#DEFINE GTK_IS_IMAGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IMAGE))
#DEFINE GTK_IS_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IMAGE))
#DEFINE GTK_IMAGE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IMAGE, GtkImageClass))

TYPE GtkImage AS _GtkImage
TYPE GtkImagePrivate AS _GtkImagePrivate
TYPE GtkImageClass AS _GtkImageClass

ENUM GtkImageType
  GTK_IMAGE_EMPTY
  GTK_IMAGE_PIXBUF
  GTK_IMAGE_STOCK
  GTK_IMAGE_ICON_SET
  GTK_IMAGE_ANIMATION
  GTK_IMAGE_ICON_NAME
  GTK_IMAGE_GICON
END ENUM

TYPE _GtkImage
  AS GtkMisc misc
  AS GtkImagePrivate PTR priv
END TYPE

TYPE _GtkImageClass
  AS GtkMiscClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_image_get_type() AS GType
DECLARE FUNCTION gtk_image_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_file(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_pixbuf(BYVAL AS GdkPixbuf PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_stock(BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_icon_set(BYVAL AS GtkIconSet PTR, BYVAL AS GtkIconSize) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_animation(BYVAL AS GdkPixbufAnimation PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_icon_name(BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_new_from_gicon(BYVAL AS GIcon PTR, BYVAL AS GtkIconSize) AS GtkWidget PTR
DECLARE SUB gtk_image_clear(BYVAL AS GtkImage PTR)
DECLARE SUB gtk_image_set_from_file(BYVAL AS GtkImage PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_image_set_from_pixbuf(BYVAL AS GtkImage PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_image_set_from_stock(BYVAL AS GtkImage PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_image_set_from_icon_set(BYVAL AS GtkImage PTR, BYVAL AS GtkIconSet PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_image_set_from_animation(BYVAL AS GtkImage PTR, BYVAL AS GdkPixbufAnimation PTR)
DECLARE SUB gtk_image_set_from_icon_name(BYVAL AS GtkImage PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_image_set_from_gicon(BYVAL AS GtkImage PTR, BYVAL AS GIcon PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_image_set_pixel_size(BYVAL AS GtkImage PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_image_get_storage_type(BYVAL AS GtkImage PTR) AS GtkImageType
DECLARE FUNCTION gtk_image_get_pixbuf(BYVAL AS GtkImage PTR) AS GdkPixbuf PTR
DECLARE SUB gtk_image_get_stock(BYVAL AS GtkImage PTR, BYVAL AS gchar PTR PTR, BYVAL AS GtkIconSize PTR)
DECLARE SUB gtk_image_get_icon_set(BYVAL AS GtkImage PTR, BYVAL AS GtkIconSet PTR PTR, BYVAL AS GtkIconSize PTR)
DECLARE FUNCTION gtk_image_get_animation(BYVAL AS GtkImage PTR) AS GdkPixbufAnimation PTR
DECLARE SUB gtk_image_get_icon_name(BYVAL AS GtkImage PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS GtkIconSize PTR)
DECLARE SUB gtk_image_get_gicon(BYVAL AS GtkImage PTR, BYVAL AS GIcon PTR PTR, BYVAL AS GtkIconSize PTR)
DECLARE FUNCTION gtk_image_get_pixel_size(BYVAL AS GtkImage PTR) AS gint

#ENDIF ' __GTK_IMAGE_H__

#DEFINE GTK_TYPE_ENTRY (gtk_entry_get_type ())
#DEFINE GTK_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ENTRY, GtkEntry))
#DEFINE GTK_ENTRY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ENTRY, GtkEntryClass))
#DEFINE GTK_IS_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ENTRY))
#DEFINE GTK_IS_ENTRY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ENTRY))
#DEFINE GTK_ENTRY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ENTRY, GtkEntryClass))

ENUM GtkEntryIconPosition
  GTK_ENTRY_ICON_PRIMARY
  GTK_ENTRY_ICON_SECONDARY
END ENUM

TYPE GtkEntry AS _GtkEntry
TYPE GtkEntryPrivate AS _GtkEntryPrivate
TYPE GtkEntryClass AS _GtkEntryClass

TYPE _GtkEntry
  AS GtkWidget parent_instance
  AS GtkEntryPrivate PTR priv
END TYPE

TYPE _GtkEntryClass
  AS GtkWidgetClass parent_class
  populate_popup AS SUB(BYVAL AS GtkEntry PTR, BYVAL AS GtkMenu PTR)
  activate AS SUB(BYVAL AS GtkEntry PTR)
  move_cursor AS SUB(BYVAL AS GtkEntry PTR, BYVAL AS GtkMovementStep, BYVAL AS gint, BYVAL AS gboolean)
  insert_at_cursor AS SUB(BYVAL AS GtkEntry PTR, BYVAL AS CONST gchar PTR)
  delete_from_cursor AS SUB(BYVAL AS GtkEntry PTR, BYVAL AS GtkDeleteType, BYVAL AS gint)
  backspace AS SUB(BYVAL AS GtkEntry PTR)
  cut_clipboard AS SUB(BYVAL AS GtkEntry PTR)
  copy_clipboard AS SUB(BYVAL AS GtkEntry PTR)
  paste_clipboard AS SUB(BYVAL AS GtkEntry PTR)
  toggle_overwrite AS SUB(BYVAL AS GtkEntry PTR)
  get_text_area_size AS SUB(BYVAL AS GtkEntry PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_entry_get_type() AS GType
DECLARE FUNCTION gtk_entry_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_entry_new_with_buffer(BYVAL AS GtkEntryBuffer PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_entry_get_buffer(BYVAL AS GtkEntry PTR) AS GtkEntryBuffer PTR
DECLARE SUB gtk_entry_set_buffer(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryBuffer PTR)
DECLARE SUB gtk_entry_get_text_area(BYVAL AS GtkEntry PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_entry_set_visibility(BYVAL AS GtkEntry PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_get_visibility(BYVAL AS GtkEntry PTR) AS gboolean
DECLARE SUB gtk_entry_set_invisible_char(BYVAL AS GtkEntry PTR, BYVAL AS gunichar)
DECLARE FUNCTION gtk_entry_get_invisible_char(BYVAL AS GtkEntry PTR) AS gunichar
DECLARE SUB gtk_entry_unset_invisible_char(BYVAL AS GtkEntry PTR)
DECLARE SUB gtk_entry_set_has_frame(BYVAL AS GtkEntry PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_get_has_frame(BYVAL AS GtkEntry PTR) AS gboolean
DECLARE SUB gtk_entry_set_inner_border(BYVAL AS GtkEntry PTR, BYVAL AS CONST GtkBorder PTR)
DECLARE FUNCTION gtk_entry_get_inner_border(BYVAL AS GtkEntry PTR) AS CONST GtkBorder PTR
DECLARE SUB gtk_entry_set_overwrite_mode(BYVAL AS GtkEntry PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_get_overwrite_mode(BYVAL AS GtkEntry PTR) AS gboolean
DECLARE SUB gtk_entry_set_max_length(BYVAL AS GtkEntry PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_entry_get_max_length(BYVAL AS GtkEntry PTR) AS gint
DECLARE FUNCTION gtk_entry_get_text_length(BYVAL AS GtkEntry PTR) AS guint16
DECLARE SUB gtk_entry_set_activates_default(BYVAL AS GtkEntry PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_get_activates_default(BYVAL AS GtkEntry PTR) AS gboolean
DECLARE SUB gtk_entry_set_width_chars(BYVAL AS GtkEntry PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_entry_get_width_chars(BYVAL AS GtkEntry PTR) AS gint
DECLARE SUB gtk_entry_set_text(BYVAL AS GtkEntry PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_entry_get_text(BYVAL AS GtkEntry PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_entry_get_layout(BYVAL AS GtkEntry PTR) AS PangoLayout PTR
DECLARE SUB gtk_entry_get_layout_offsets(BYVAL AS GtkEntry PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_entry_set_alignment(BYVAL AS GtkEntry PTR, BYVAL AS gfloat)
DECLARE FUNCTION gtk_entry_get_alignment(BYVAL AS GtkEntry PTR) AS gfloat
DECLARE SUB gtk_entry_set_completion(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryCompletion PTR)
DECLARE FUNCTION gtk_entry_get_completion(BYVAL AS GtkEntry PTR) AS GtkEntryCompletion PTR
DECLARE FUNCTION gtk_entry_layout_index_to_text_index(BYVAL AS GtkEntry PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gtk_entry_text_index_to_layout_index(BYVAL AS GtkEntry PTR, BYVAL AS gint) AS gint
DECLARE SUB gtk_entry_set_cursor_hadjustment(BYVAL AS GtkEntry PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_entry_get_cursor_hadjustment(BYVAL AS GtkEntry PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_entry_set_progress_fraction(BYVAL AS GtkEntry PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_entry_get_progress_fraction(BYVAL AS GtkEntry PTR) AS gdouble
DECLARE SUB gtk_entry_set_progress_pulse_step(BYVAL AS GtkEntry PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_entry_get_progress_pulse_step(BYVAL AS GtkEntry PTR) AS gdouble
DECLARE SUB gtk_entry_progress_pulse(BYVAL AS GtkEntry PTR)
DECLARE FUNCTION gtk_entry_get_placeholder_text(BYVAL AS GtkEntry PTR) AS CONST gchar PTR
DECLARE SUB gtk_entry_set_placeholder_text(BYVAL AS GtkEntry PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_entry_set_icon_from_pixbuf(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_entry_set_icon_from_stock(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_entry_set_icon_from_icon_name(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_entry_set_icon_from_gicon(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS GIcon PTR)
DECLARE FUNCTION gtk_entry_get_icon_storage_type(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS GtkImageType
DECLARE FUNCTION gtk_entry_get_icon_pixbuf(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_entry_get_icon_stock(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS CONST gchar PTR
DECLARE FUNCTION gtk_entry_get_icon_name(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS CONST gchar PTR
DECLARE FUNCTION gtk_entry_get_icon_gicon(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS GIcon PTR
DECLARE SUB gtk_entry_set_icon_activatable(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_get_icon_activatable(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS gboolean
DECLARE SUB gtk_entry_set_icon_sensitive(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS gboolean)
DECLARE FUNCTION gtk_entry_get_icon_sensitive(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS gboolean
DECLARE FUNCTION gtk_entry_get_icon_at_pos(BYVAL AS GtkEntry PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE SUB gtk_entry_set_icon_tooltip_text(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_entry_get_icon_tooltip_text(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS gchar PTR
DECLARE SUB gtk_entry_set_icon_tooltip_markup(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_entry_get_icon_tooltip_markup(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition) AS gchar PTR
DECLARE SUB gtk_entry_set_icon_drag_source(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS GtkTargetList PTR, BYVAL AS GdkDragAction)
DECLARE FUNCTION gtk_entry_get_current_icon_drag_source(BYVAL AS GtkEntry PTR) AS gint
DECLARE SUB gtk_entry_get_icon_area(BYVAL AS GtkEntry PTR, BYVAL AS GtkEntryIconPosition, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gtk_entry_im_context_filter_keypress(BYVAL AS GtkEntry PTR, BYVAL AS GdkEventKey PTR) AS gboolean
DECLARE SUB gtk_entry_reset_im_context(BYVAL AS GtkEntry PTR)

#ENDIF ' __GTK_ENTRY_H__

ENUM GtkTreeViewDropPosition
  GTK_TREE_VIEW_DROP_BEFORE
  GTK_TREE_VIEW_DROP_AFTER
  GTK_TREE_VIEW_DROP_INTO_OR_BEFORE
  GTK_TREE_VIEW_DROP_INTO_OR_AFTER
END ENUM

#DEFINE GTK_TYPE_TREE_VIEW (gtk_tree_view_get_type ())
#DEFINE GTK_TREE_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_VIEW, GtkTreeView))
#DEFINE GTK_TREE_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_VIEW, GtkTreeViewClass))
#DEFINE GTK_IS_TREE_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_VIEW))
#DEFINE GTK_IS_TREE_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_VIEW))
#DEFINE GTK_TREE_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_VIEW, GtkTreeViewClass))

TYPE GtkTreeView AS _GtkTreeView
TYPE GtkTreeViewClass AS _GtkTreeViewClass
TYPE GtkTreeViewPrivate AS _GtkTreeViewPrivate
TYPE GtkTreeSelection AS _GtkTreeSelection
TYPE GtkTreeSelectionClass AS _GtkTreeSelectionClass

TYPE _GtkTreeView
  AS GtkContainer parent
  AS GtkTreeViewPrivate PTR priv
END TYPE

TYPE _GtkTreeViewClass
  AS GtkContainerClass parent_class
  row_activated AS SUB(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR)
  test_expand_row AS FUNCTION(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreePath PTR) AS gboolean
  test_collapse_row AS FUNCTION(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreePath PTR) AS gboolean
  row_expanded AS SUB(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreePath PTR)
  row_collapsed AS SUB(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreePath PTR)
  columns_changed AS SUB(BYVAL AS GtkTreeView PTR)
  cursor_changed AS SUB(BYVAL AS GtkTreeView PTR)
  move_cursor AS FUNCTION(BYVAL AS GtkTreeView PTR, BYVAL AS GtkMovementStep, BYVAL AS gint) AS gboolean
  select_all AS FUNCTION(BYVAL AS GtkTreeView PTR) AS gboolean
  unselect_all AS FUNCTION(BYVAL AS GtkTreeView PTR) AS gboolean
  select_cursor_row AS FUNCTION(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean) AS gboolean
  toggle_cursor_row AS FUNCTION(BYVAL AS GtkTreeView PTR) AS gboolean
  expand_collapse_cursor_row AS FUNCTION(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean) AS gboolean
  select_cursor_parent AS FUNCTION(BYVAL AS GtkTreeView PTR) AS gboolean
  start_interactive_search AS FUNCTION(BYVAL AS GtkTreeView PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

TYPE GtkTreeViewColumnDropFunc AS FUNCTION(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gpointer) AS gboolean
TYPE GtkTreeViewMappingFunc AS SUB(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS gpointer)
TYPE GtkTreeViewSearchEqualFunc AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer) AS gboolean
TYPE GtkTreeViewRowSeparatorFunc AS FUNCTION(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer) AS gboolean
TYPE GtkTreeViewSearchPositionFunc AS SUB(BYVAL AS GtkTreeView PTR, BYVAL AS GtkWidget PTR, BYVAL AS gpointer)

DECLARE FUNCTION gtk_tree_view_get_type() AS GType
DECLARE FUNCTION gtk_tree_view_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_tree_view_new_with_model(BYVAL AS GtkTreeModel PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_tree_view_get_model(BYVAL AS GtkTreeView PTR) AS GtkTreeModel PTR
DECLARE SUB gtk_tree_view_set_model(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeModel PTR)
DECLARE FUNCTION gtk_tree_view_get_selection(BYVAL AS GtkTreeView PTR) AS GtkTreeSelection PTR

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_tree_view_get_hadjustment(BYVAL AS GtkTreeView PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_tree_view_set_hadjustment(BYVAL AS GtkTreeView PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_tree_view_get_vadjustment(BYVAL AS GtkTreeView PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_tree_view_set_vadjustment(BYVAL AS GtkTreeView PTR, BYVAL AS GtkAdjustment PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_tree_view_get_headers_visible(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_headers_visible(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_columns_autosize(BYVAL AS GtkTreeView PTR)
DECLARE FUNCTION gtk_tree_view_get_headers_clickable(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_headers_clickable(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_set_rules_hint(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_rules_hint(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE FUNCTION gtk_tree_view_append_column(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE FUNCTION gtk_tree_view_remove_column(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumn PTR) AS gint
DECLARE FUNCTION gtk_tree_view_insert_column(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gtk_tree_view_insert_column_with_attributes(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GtkCellRenderer PTR, ...) AS gint
DECLARE FUNCTION gtk_tree_view_insert_column_with_data_func(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkTreeCellDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS gint
DECLARE FUNCTION gtk_tree_view_get_column(BYVAL AS GtkTreeView PTR, BYVAL AS gint) AS GtkTreeViewColumn PTR
DECLARE FUNCTION gtk_tree_view_get_columns(BYVAL AS GtkTreeView PTR) AS GList PTR
DECLARE SUB gtk_tree_view_move_column_after(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkTreeViewColumn PTR)
DECLARE SUB gtk_tree_view_set_expander_column(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumn PTR)
DECLARE FUNCTION gtk_tree_view_get_expander_column(BYVAL AS GtkTreeView PTR) AS GtkTreeViewColumn PTR
DECLARE SUB gtk_tree_view_set_column_drag_function(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewColumnDropFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_view_scroll_to_point(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_tree_view_scroll_to_cell(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_tree_view_row_activated(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR)
DECLARE SUB gtk_tree_view_expand_all(BYVAL AS GtkTreeView PTR)
DECLARE SUB gtk_tree_view_collapse_all(BYVAL AS GtkTreeView PTR)
DECLARE SUB gtk_tree_view_expand_to_path(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR)
DECLARE FUNCTION gtk_tree_view_expand_row(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_tree_view_collapse_row(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE SUB gtk_tree_view_map_expanded_rows(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewMappingFunc, BYVAL AS gpointer)
DECLARE FUNCTION gtk_tree_view_row_expanded(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_reorderable(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_reorderable(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_cursor(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_set_cursor_on_cell(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_get_cursor(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeViewColumn PTR PTR)
DECLARE FUNCTION gtk_tree_view_get_bin_window(BYVAL AS GtkTreeView PTR) AS GdkWindow PTR
DECLARE FUNCTION gtk_tree_view_get_path_at_pos(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeViewColumn PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gtk_tree_view_get_cell_area(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_tree_view_get_background_area(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_tree_view_get_visible_rect(BYVAL AS GtkTreeView PTR, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gtk_tree_view_get_visible_range(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreePath PTR PTR) AS gboolean
DECLARE FUNCTION gtk_tree_view_is_blank_at_pos(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeViewColumn PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gtk_tree_view_enable_model_drag_source(BYVAL AS GtkTreeView PTR, BYVAL AS GdkModifierType, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint, BYVAL AS GdkDragAction)
DECLARE SUB gtk_tree_view_enable_model_drag_dest(BYVAL AS GtkTreeView PTR, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint, BYVAL AS GdkDragAction)
DECLARE SUB gtk_tree_view_unset_rows_drag_source(BYVAL AS GtkTreeView PTR)
DECLARE SUB gtk_tree_view_unset_rows_drag_dest(BYVAL AS GtkTreeView PTR)
DECLARE SUB gtk_tree_view_set_drag_dest_row(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewDropPosition)
DECLARE SUB gtk_tree_view_get_drag_dest_row(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeViewDropPosition PTR)
DECLARE FUNCTION gtk_tree_view_get_dest_row_at_pos(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeViewDropPosition PTR) AS gboolean
DECLARE FUNCTION gtk_tree_view_create_row_drag_icon(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR) AS cairo_surface_t PTR
DECLARE SUB gtk_tree_view_set_enable_search(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_enable_search(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE FUNCTION gtk_tree_view_get_search_column(BYVAL AS GtkTreeView PTR) AS gint
DECLARE SUB gtk_tree_view_set_search_column(BYVAL AS GtkTreeView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_get_search_equal_func(BYVAL AS GtkTreeView PTR) AS GtkTreeViewSearchEqualFunc
DECLARE SUB gtk_tree_view_set_search_equal_func(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewSearchEqualFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_tree_view_get_search_entry(BYVAL AS GtkTreeView PTR) AS GtkEntry PTR
DECLARE SUB gtk_tree_view_set_search_entry(BYVAL AS GtkTreeView PTR, BYVAL AS GtkEntry PTR)
DECLARE FUNCTION gtk_tree_view_get_search_position_func(BYVAL AS GtkTreeView PTR) AS GtkTreeViewSearchPositionFunc
DECLARE SUB gtk_tree_view_set_search_position_func(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewSearchPositionFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_view_convert_widget_to_tree_coords(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_tree_view_convert_tree_to_widget_coords(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_tree_view_convert_widget_to_bin_window_coords(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_tree_view_convert_bin_window_to_widget_coords(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_tree_view_convert_tree_to_bin_window_coords(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_tree_view_convert_bin_window_to_tree_coords(BYVAL AS GtkTreeView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)

TYPE GtkTreeDestroyCountFunc AS SUB(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS gint, BYVAL AS gpointer)

DECLARE SUB gtk_tree_view_set_destroy_count_func(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeDestroyCountFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_tree_view_set_fixed_height_mode(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_fixed_height_mode(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_hover_selection(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_hover_selection(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_hover_expand(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_hover_expand(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_rubber_banding(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_rubber_banding(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE FUNCTION gtk_tree_view_is_rubber_banding_active(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE FUNCTION gtk_tree_view_get_row_separator_func(BYVAL AS GtkTreeView PTR) AS GtkTreeViewRowSeparatorFunc
DECLARE SUB gtk_tree_view_set_row_separator_func(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewRowSeparatorFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_tree_view_get_grid_lines(BYVAL AS GtkTreeView PTR) AS GtkTreeViewGridLines
DECLARE SUB gtk_tree_view_set_grid_lines(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTreeViewGridLines)
DECLARE FUNCTION gtk_tree_view_get_enable_tree_lines(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_enable_tree_lines(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tree_view_set_show_expanders(BYVAL AS GtkTreeView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tree_view_get_show_expanders(BYVAL AS GtkTreeView PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_level_indentation(BYVAL AS GtkTreeView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_get_level_indentation(BYVAL AS GtkTreeView PTR) AS gint
DECLARE SUB gtk_tree_view_set_tooltip_row(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTooltip PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_view_set_tooltip_cell(BYVAL AS GtkTreeView PTR, BYVAL AS GtkTooltip PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeViewColumn PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE FUNCTION gtk_tree_view_get_tooltip_context(BYVAL AS GtkTreeView PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gboolean, BYVAL AS GtkTreeModel PTR PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_tree_view_set_tooltip_column(BYVAL AS GtkTreeView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tree_view_get_tooltip_column(BYVAL AS GtkTreeView PTR) AS gint

#ENDIF ' __GTK_TREE_VIEW_H__

#DEFINE GTK_TYPE_COMBO_BOX (gtk_combo_box_get_type ())
#DEFINE GTK_COMBO_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COMBO_BOX, GtkComboBox))
#DEFINE GTK_COMBO_BOX_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_COMBO_BOX, GtkComboBoxClass))
#DEFINE GTK_IS_COMBO_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COMBO_BOX))
#DEFINE GTK_IS_COMBO_BOX_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_COMBO_BOX))
#DEFINE GTK_COMBO_BOX_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_COMBO_BOX, GtkComboBoxClass))

TYPE GtkComboBox AS _GtkComboBox
TYPE GtkComboBoxClass AS _GtkComboBoxClass
TYPE GtkComboBoxPrivate AS _GtkComboBoxPrivate

TYPE _GtkComboBox
  AS GtkBin parent_instance
  AS GtkComboBoxPrivate PTR priv
END TYPE

TYPE _GtkComboBoxClass
  AS GtkBinClass parent_class
  changed AS SUB(BYVAL AS GtkComboBox PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_combo_box_get_type() AS GType
DECLARE FUNCTION gtk_combo_box_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_new_with_area(BYVAL AS GtkCellArea PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_new_with_area_and_entry(BYVAL AS GtkCellArea PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_new_with_entry() AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_new_with_model(BYVAL AS GtkTreeModel PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_new_with_model_and_entry(BYVAL AS GtkTreeModel PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_get_wrap_width(BYVAL AS GtkComboBox PTR) AS gint
DECLARE SUB gtk_combo_box_set_wrap_width(BYVAL AS GtkComboBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_combo_box_get_row_span_column(BYVAL AS GtkComboBox PTR) AS gint
DECLARE SUB gtk_combo_box_set_row_span_column(BYVAL AS GtkComboBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_combo_box_get_column_span_column(BYVAL AS GtkComboBox PTR) AS gint
DECLARE SUB gtk_combo_box_set_column_span_column(BYVAL AS GtkComboBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_combo_box_get_add_tearoffs(BYVAL AS GtkComboBox PTR) AS gboolean
DECLARE SUB gtk_combo_box_set_add_tearoffs(BYVAL AS GtkComboBox PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_combo_box_get_title(BYVAL AS GtkComboBox PTR) AS CONST gchar PTR
DECLARE SUB gtk_combo_box_set_title(BYVAL AS GtkComboBox PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_combo_box_get_focus_on_click(BYVAL AS GtkComboBox PTR) AS gboolean
DECLARE SUB gtk_combo_box_set_focus_on_click(BYVAL AS GtkComboBox PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_combo_box_get_active(BYVAL AS GtkComboBox PTR) AS gint
DECLARE SUB gtk_combo_box_set_active(BYVAL AS GtkComboBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_combo_box_get_active_iter(BYVAL AS GtkComboBox PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_combo_box_set_active_iter(BYVAL AS GtkComboBox PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_combo_box_set_model(BYVAL AS GtkComboBox PTR, BYVAL AS GtkTreeModel PTR)
DECLARE FUNCTION gtk_combo_box_get_model(BYVAL AS GtkComboBox PTR) AS GtkTreeModel PTR
DECLARE FUNCTION gtk_combo_box_get_row_separator_func(BYVAL AS GtkComboBox PTR) AS GtkTreeViewRowSeparatorFunc
DECLARE SUB gtk_combo_box_set_row_separator_func(BYVAL AS GtkComboBox PTR, BYVAL AS GtkTreeViewRowSeparatorFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_combo_box_set_button_sensitivity(BYVAL AS GtkComboBox PTR, BYVAL AS GtkSensitivityType)
DECLARE FUNCTION gtk_combo_box_get_button_sensitivity(BYVAL AS GtkComboBox PTR) AS GtkSensitivityType
DECLARE FUNCTION gtk_combo_box_get_has_entry(BYVAL AS GtkComboBox PTR) AS gboolean
DECLARE SUB gtk_combo_box_set_entry_text_column(BYVAL AS GtkComboBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_combo_box_get_entry_text_column(BYVAL AS GtkComboBox PTR) AS gint
DECLARE SUB gtk_combo_box_set_popup_fixed_width(BYVAL AS GtkComboBox PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_combo_box_get_popup_fixed_width(BYVAL AS GtkComboBox PTR) AS gboolean
DECLARE SUB gtk_combo_box_popup(BYVAL AS GtkComboBox PTR)
DECLARE SUB gtk_combo_box_popup_for_device(BYVAL AS GtkComboBox PTR, BYVAL AS GdkDevice PTR)
DECLARE SUB gtk_combo_box_popdown(BYVAL AS GtkComboBox PTR)
DECLARE FUNCTION gtk_combo_box_get_popup_accessible(BYVAL AS GtkComboBox PTR) AS AtkObject PTR
DECLARE FUNCTION gtk_combo_box_get_id_column(BYVAL AS GtkComboBox PTR) AS gint
DECLARE SUB gtk_combo_box_set_id_column(BYVAL AS GtkComboBox PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_combo_box_get_active_id(BYVAL AS GtkComboBox PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_combo_box_set_active_id(BYVAL AS GtkComboBox PTR, BYVAL AS CONST gchar PTR) AS gboolean

#ENDIF ' __GTK_COMBO_BOX_H__

#DEFINE GTK_TYPE_APP_CHOOSER_BUTTON (gtk_app_chooser_button_get_type ())
#DEFINE GTK_APP_CHOOSER_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_APP_CHOOSER_BUTTON, GtkAppChooserButton))
#DEFINE GTK_APP_CHOOSER_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_APP_CHOOSER_BUTTON, GtkAppChooserButtonClass))
#DEFINE GTK_IS_APP_CHOOSER_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_APP_CHOOSER_BUTTON))
#DEFINE GTK_IS_APP_CHOOSER_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_APP_CHOOSER_BUTTON))
#DEFINE GTK_APP_CHOOSER_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_APP_CHOOSER_BUTTON, GtkAppChooserButtonClass))

TYPE GtkAppChooserButton AS _GtkAppChooserButton
TYPE GtkAppChooserButtonClass AS _GtkAppChooserButtonClass
TYPE GtkAppChooserButtonPrivate AS _GtkAppChooserButtonPrivate

TYPE _GtkAppChooserButton
  AS GtkComboBox parent
  AS GtkAppChooserButtonPrivate PTR priv
END TYPE

TYPE _GtkAppChooserButtonClass
  AS GtkComboBoxClass parent_class
  custom_item_activated AS SUB(BYVAL AS GtkAppChooserButton PTR, BYVAL AS CONST gchar PTR)
  AS gpointer padding(15)
END TYPE

DECLARE FUNCTION gtk_app_chooser_button_get_type() AS GType
DECLARE FUNCTION gtk_app_chooser_button_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_app_chooser_button_append_separator(BYVAL AS GtkAppChooserButton PTR)
DECLARE SUB gtk_app_chooser_button_append_custom_item(BYVAL AS GtkAppChooserButton PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GIcon PTR)
DECLARE SUB gtk_app_chooser_button_set_active_custom_item(BYVAL AS GtkAppChooserButton PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_app_chooser_button_set_show_dialog_item(BYVAL AS GtkAppChooserButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_button_get_show_dialog_item(BYVAL AS GtkAppChooserButton PTR) AS gboolean
DECLARE SUB gtk_app_chooser_button_set_heading(BYVAL AS GtkAppChooserButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_app_chooser_button_get_heading(BYVAL AS GtkAppChooserButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_app_chooser_button_set_show_default_item(BYVAL AS GtkAppChooserButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_app_chooser_button_get_show_default_item(BYVAL AS GtkAppChooserButton PTR) AS gboolean

#ENDIF ' __GTK_APP_CHOOSER_BUTTON_H__

#IFNDEF __GTK_ARROW_H__
#DEFINE __GTK_ARROW_H__

#DEFINE GTK_TYPE_ARROW (gtk_arrow_get_type ())
#DEFINE GTK_ARROW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ARROW, GtkArrow))
#DEFINE GTK_ARROW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ARROW, GtkArrowClass))
#DEFINE GTK_IS_ARROW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ARROW))
#DEFINE GTK_IS_ARROW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ARROW))
#DEFINE GTK_ARROW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ARROW, GtkArrowClass))

TYPE GtkArrow AS _GtkArrow
TYPE GtkArrowPrivate AS _GtkArrowPrivate
TYPE GtkArrowClass AS _GtkArrowClass

TYPE _GtkArrow
  AS GtkMisc misc
  AS GtkArrowPrivate PTR priv
END TYPE

TYPE _GtkArrowClass
  AS GtkMiscClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_arrow_get_type() AS GType
DECLARE FUNCTION gtk_arrow_new(BYVAL AS GtkArrowType, BYVAL AS GtkShadowType) AS GtkWidget PTR
DECLARE SUB gtk_arrow_set(BYVAL AS GtkArrow PTR, BYVAL AS GtkArrowType, BYVAL AS GtkShadowType)

#ENDIF ' __GTK_ARROW_H__

#IFNDEF __GTK_ASPECT_FRAME_H__
#DEFINE __GTK_ASPECT_FRAME_H__

#IFNDEF __GTK_FRAME_H__
#DEFINE __GTK_FRAME_H__

#DEFINE GTK_TYPE_FRAME (gtk_frame_get_type ())
#DEFINE GTK_FRAME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FRAME, GtkFrame))
#DEFINE GTK_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FRAME, GtkFrameClass))
#DEFINE GTK_IS_FRAME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FRAME))
#DEFINE GTK_IS_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FRAME))
#DEFINE GTK_FRAME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FRAME, GtkFrameClass))

TYPE GtkFrame AS _GtkFrame
TYPE GtkFramePrivate AS _GtkFramePrivate
TYPE GtkFrameClass AS _GtkFrameClass

TYPE _GtkFrame
  AS GtkBin bin
  AS GtkFramePrivate PTR priv
END TYPE

TYPE _GtkFrameClass
  AS GtkBinClass parent_class
  compute_child_allocation AS SUB(BYVAL AS GtkFrame PTR, BYVAL AS GtkAllocation PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_frame_get_type() AS GType
DECLARE FUNCTION gtk_frame_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_frame_set_label(BYVAL AS GtkFrame PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_frame_get_label(BYVAL AS GtkFrame PTR) AS CONST gchar PTR
DECLARE SUB gtk_frame_set_label_widget(BYVAL AS GtkFrame PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_frame_get_label_widget(BYVAL AS GtkFrame PTR) AS GtkWidget PTR
DECLARE SUB gtk_frame_set_label_align(BYVAL AS GtkFrame PTR, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_frame_get_label_align(BYVAL AS GtkFrame PTR, BYVAL AS gfloat PTR, BYVAL AS gfloat PTR)
DECLARE SUB gtk_frame_set_shadow_type(BYVAL AS GtkFrame PTR, BYVAL AS GtkShadowType)
DECLARE FUNCTION gtk_frame_get_shadow_type(BYVAL AS GtkFrame PTR) AS GtkShadowType

#ENDIF ' __GTK_FRAME_H__

#DEFINE GTK_TYPE_ASPECT_FRAME (gtk_aspect_frame_get_type ())
#DEFINE GTK_ASPECT_FRAME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrame))
#DEFINE GTK_ASPECT_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ASPECT_FRAME, GtkAspectFrameClass))
#DEFINE GTK_IS_ASPECT_FRAME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ASPECT_FRAME))
#DEFINE GTK_IS_ASPECT_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ASPECT_FRAME))
#DEFINE GTK_ASPECT_FRAME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrameClass))

TYPE GtkAspectFrame AS _GtkAspectFrame
TYPE GtkAspectFramePrivate AS _GtkAspectFramePrivate
TYPE GtkAspectFrameClass AS _GtkAspectFrameClass

TYPE _GtkAspectFrame
  AS GtkFrame frame
  AS GtkAspectFramePrivate PTR priv
END TYPE

TYPE _GtkAspectFrameClass
  AS GtkFrameClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_aspect_frame_get_type() AS GType
DECLARE FUNCTION gtk_aspect_frame_new(BYVAL AS CONST gchar PTR, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gboolean) AS GtkWidget PTR
DECLARE SUB gtk_aspect_frame_set(BYVAL AS GtkAspectFrame PTR, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gfloat, BYVAL AS gboolean)

#ENDIF ' __GTK_ASPECT_FRAME_H__

#IFNDEF __GTK_ASSISTANT_H__
#DEFINE __GTK_ASSISTANT_H__

#DEFINE GTK_TYPE_ASSISTANT (gtk_assistant_get_type ())
#DEFINE GTK_ASSISTANT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_ASSISTANT, GtkAssistant))
#DEFINE GTK_ASSISTANT_CLASS(c) (G_TYPE_CHECK_CLASS_CAST ((c), GTK_TYPE_ASSISTANT, GtkAssistantClass))
#DEFINE GTK_IS_ASSISTANT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_ASSISTANT))
#DEFINE GTK_IS_ASSISTANT_CLASS(c) (G_TYPE_CHECK_CLASS_TYPE ((c), GTK_TYPE_ASSISTANT))
#DEFINE GTK_ASSISTANT_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_ASSISTANT, GtkAssistantClass))

ENUM GtkAssistantPageType
  GTK_ASSISTANT_PAGE_CONTENT
  GTK_ASSISTANT_PAGE_INTRO
  GTK_ASSISTANT_PAGE_CONFIRM
  GTK_ASSISTANT_PAGE_SUMMARY
  GTK_ASSISTANT_PAGE_PROGRESS
  GTK_ASSISTANT_PAGE_CUSTOM
END ENUM

TYPE GtkAssistant AS _GtkAssistant
TYPE GtkAssistantPrivate AS _GtkAssistantPrivate
TYPE GtkAssistantClass AS _GtkAssistantClass

TYPE _GtkAssistant
  AS GtkWindow parent
  AS GtkAssistantPrivate PTR priv
END TYPE

TYPE _GtkAssistantClass
  AS GtkWindowClass parent_class
  prepare AS SUB(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR)
  apply AS SUB(BYVAL AS GtkAssistant PTR)
  close_ AS SUB(BYVAL AS GtkAssistant PTR)
  cancel AS SUB(BYVAL AS GtkAssistant PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
END TYPE

TYPE GtkAssistantPageFunc AS FUNCTION(BYVAL AS gint, BYVAL AS gpointer) AS gint

DECLARE FUNCTION gtk_assistant_get_type() AS GType
DECLARE FUNCTION gtk_assistant_new() AS GtkWidget PTR
DECLARE SUB gtk_assistant_next_page(BYVAL AS GtkAssistant PTR)
DECLARE SUB gtk_assistant_previous_page(BYVAL AS GtkAssistant PTR)
DECLARE FUNCTION gtk_assistant_get_current_page(BYVAL AS GtkAssistant PTR) AS gint
DECLARE SUB gtk_assistant_set_current_page(BYVAL AS GtkAssistant PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_assistant_get_n_pages(BYVAL AS GtkAssistant PTR) AS gint
DECLARE FUNCTION gtk_assistant_get_nth_page(BYVAL AS GtkAssistant PTR, BYVAL AS gint) AS GtkWidget PTR
DECLARE FUNCTION gtk_assistant_prepend_page(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_assistant_append_page(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_assistant_insert_page(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint) AS gint
DECLARE SUB gtk_assistant_remove_page(BYVAL AS GtkAssistant PTR, BYVAL AS gint)
DECLARE SUB gtk_assistant_set_forward_page_func(BYVAL AS GtkAssistant PTR, BYVAL AS GtkAssistantPageFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_assistant_set_page_type(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkAssistantPageType)
DECLARE FUNCTION gtk_assistant_get_page_type(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS GtkAssistantPageType
DECLARE SUB gtk_assistant_set_page_title(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_assistant_get_page_title(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS CONST gchar PTR

#IF NOT DEFINED (GTK_DISABLE_DEPRECATED) OR DEFINED (GTK_COMPILATION)

DECLARE SUB gtk_assistant_set_page_header_image(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkPixbuf PTR)
DECLARE FUNCTION gtk_assistant_get_page_header_image(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS GdkPixbuf PTR
DECLARE SUB gtk_assistant_set_page_side_image(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR, BYVAL AS GdkPixbuf PTR)
DECLARE FUNCTION gtk_assistant_get_page_side_image(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS GdkPixbuf PTR

#ENDIF ' NOT DEFINED (GT...

DECLARE SUB gtk_assistant_set_page_complete(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_assistant_get_page_complete(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_assistant_add_action_widget(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_assistant_remove_action_widget(BYVAL AS GtkAssistant PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_assistant_update_buttons_state(BYVAL AS GtkAssistant PTR)
DECLARE SUB gtk_assistant_commit(BYVAL AS GtkAssistant PTR)

#ENDIF ' __GTK_ASSISTANT_H__

#IFNDEF __GTK_BUTTON_BOX_H__
#DEFINE __GTK_BUTTON_BOX_H__

#DEFINE GTK_TYPE_BUTTON_BOX (gtk_button_box_get_type ())
#DEFINE GTK_BUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUTTON_BOX, GtkButtonBox))
#DEFINE GTK_BUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass))
#DEFINE GTK_IS_BUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUTTON_BOX))
#DEFINE GTK_IS_BUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BUTTON_BOX))
#DEFINE GTK_BUTTON_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BUTTON_BOX, GtkButtonBoxClass))

TYPE GtkButtonBox AS _GtkButtonBox
TYPE GtkButtonBoxPrivate AS _GtkButtonBoxPrivate
TYPE GtkButtonBoxClass AS _GtkButtonBoxClass

TYPE _GtkButtonBox
  AS GtkBox box
  AS GtkButtonBoxPrivate PTR priv
END TYPE

TYPE _GtkButtonBoxClass
  AS GtkBoxClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_button_box_get_type() AS GType
DECLARE FUNCTION gtk_button_box_new(BYVAL AS GtkOrientation) AS GtkWidget PTR
DECLARE FUNCTION gtk_button_box_get_layout(BYVAL AS GtkButtonBox PTR) AS GtkButtonBoxStyle
DECLARE SUB gtk_button_box_set_layout(BYVAL AS GtkButtonBox PTR, BYVAL AS GtkButtonBoxStyle)
DECLARE FUNCTION gtk_button_box_get_child_secondary(BYVAL AS GtkButtonBox PTR, BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_button_box_set_child_secondary(BYVAL AS GtkButtonBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_button_box_get_child_non_homogeneous(BYVAL AS GtkButtonBox PTR, BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_button_box_set_child_non_homogeneous(BYVAL AS GtkButtonBox PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_BUTTON_BOX_H__

#IFNDEF __GTK_BINDINGS_H__
#DEFINE __GTK_BINDINGS_H__

TYPE GtkBindingSet AS _GtkBindingSet
TYPE GtkBindingEntry AS _GtkBindingEntry
TYPE GtkBindingSignal AS _GtkBindingSignal
TYPE GtkBindingArg AS _GtkBindingArg

TYPE _GtkBindingSet
  AS gchar PTR set_name
  AS gint priority
  AS GSList PTR widget_path_pspecs
  AS GSList PTR widget_class_pspecs
  AS GSList PTR class_branch_pspecs
  AS GtkBindingEntry PTR entries
  AS GtkBindingEntry PTR current
  AS guint parsed : 1
END TYPE

TYPE _GtkBindingEntry
  AS guint keyval
  AS GdkModifierType modifiers
  AS GtkBindingSet PTR binding_set
  AS guint destroyed : 1
  AS guint in_emission : 1
  AS guint marks_unbound : 1
  AS GtkBindingEntry PTR set_next
  AS GtkBindingEntry PTR hash_next
  AS GtkBindingSignal PTR signals
END TYPE

UNION _GtkBindingArg_d
  AS glong long_data
  AS gdouble double_data
  AS gchar PTR string_data
END UNION

TYPE _GtkBindingArg
  AS GType arg_type
  AS _GtkBindingArg_d d
END TYPE

TYPE _GtkBindingSignal
  AS GtkBindingSignal PTR next
  AS gchar PTR signal_name
  AS guint n_args
  AS GtkBindingArg PTR args
END TYPE

DECLARE FUNCTION gtk_binding_set_new(BYVAL AS CONST gchar PTR) AS GtkBindingSet PTR
DECLARE FUNCTION gtk_binding_set_by_class(BYVAL AS gpointer) AS GtkBindingSet PTR
DECLARE FUNCTION gtk_binding_set_find(BYVAL AS CONST gchar PTR) AS GtkBindingSet PTR
DECLARE FUNCTION gtk_bindings_activate(BYVAL AS GObject PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE FUNCTION gtk_bindings_activate_event(BYVAL AS GObject PTR, BYVAL AS GdkEventKey PTR) AS gboolean
DECLARE FUNCTION gtk_binding_set_activate(BYVAL AS GtkBindingSet PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GObject PTR) AS gboolean
DECLARE SUB gtk_binding_entry_skip(BYVAL AS GtkBindingSet PTR, BYVAL AS guint, BYVAL AS GdkModifierType)
DECLARE SUB gtk_binding_entry_add_signal(BYVAL AS GtkBindingSet PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS CONST gchar PTR, BYVAL AS guint, ...)
DECLARE SUB gtk_binding_entry_add_signall(BYVAL AS GtkBindingSet PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS CONST gchar PTR, BYVAL AS GSList PTR)
DECLARE FUNCTION gtk_binding_entry_add_signal_from_string(BYVAL AS GtkBindingSet PTR, BYVAL AS CONST gchar PTR) AS GTokenType
DECLARE SUB gtk_binding_entry_remove(BYVAL AS GtkBindingSet PTR, BYVAL AS guint, BYVAL AS GdkModifierType)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_binding_set_add_path(BYVAL AS GtkBindingSet PTR, BYVAL AS GtkPathType, BYVAL AS CONST gchar PTR, BYVAL AS GtkPathPriorityType)

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_BINDINGS_H__

#IFNDEF __GTK_BUILDABLE_H__
#DEFINE __GTK_BUILDABLE_H__

#IFNDEF __GTK_BUILDER_H__
#DEFINE __GTK_BUILDER_H__

#DEFINE GTK_TYPE_BUILDER (gtk_builder_get_type ())
#DEFINE GTK_BUILDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUILDER, GtkBuilder))
#DEFINE GTK_BUILDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BUILDER, GtkBuilderClass))
#DEFINE GTK_IS_BUILDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUILDER))
#DEFINE GTK_IS_BUILDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BUILDER))
#DEFINE GTK_BUILDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BUILDER, GtkBuilderClass))
#DEFINE GTK_BUILDER_ERROR (gtk_builder_error_quark ())

TYPE GtkBuilder AS _GtkBuilder
TYPE GtkBuilderClass AS _GtkBuilderClass
TYPE GtkBuilderPrivate AS _GtkBuilderPrivate

ENUM GtkBuilderError
  GTK_BUILDER_ERROR_INVALID_TYPE_FUNCTION
  GTK_BUILDER_ERROR_UNHANDLED_TAG
  GTK_BUILDER_ERROR_MISSING_ATTRIBUTE
  GTK_BUILDER_ERROR_INVALID_ATTRIBUTE
  GTK_BUILDER_ERROR_INVALID_TAG
  GTK_BUILDER_ERROR_MISSING_PROPERTY_VALUE
  GTK_BUILDER_ERROR_INVALID_VALUE
  GTK_BUILDER_ERROR_VERSION_MISMATCH
  GTK_BUILDER_ERROR_DUPLICATE_ID
END ENUM

DECLARE FUNCTION gtk_builder_error_quark() AS GQuark

TYPE _GtkBuilder
  AS GObject parent_instance
  AS GtkBuilderPrivate PTR priv
END TYPE

TYPE _GtkBuilderClass
  AS GObjectClass parent_class
  get_type_from_name AS FUNCTION(BYVAL AS GtkBuilder PTR, BYVAL AS CONST ZSTRING PTR) AS GType
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

TYPE GtkBuilderConnectFunc AS SUB(BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GObject PTR, BYVAL AS GConnectFlags, BYVAL AS gpointer)

DECLARE FUNCTION gtk_builder_get_type() AS GType
DECLARE FUNCTION gtk_builder_new() AS GtkBuilder PTR
DECLARE FUNCTION gtk_builder_add_from_file(BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION gtk_builder_add_from_string(BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION gtk_builder_add_objects_from_file(BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION gtk_builder_add_objects_from_string(BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR, BYVAL AS gsize, BYVAL AS gchar PTR PTR, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION gtk_builder_get_object(BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR) AS GObject PTR
DECLARE FUNCTION gtk_builder_get_objects(BYVAL AS GtkBuilder PTR) AS GSList PTR
DECLARE SUB gtk_builder_connect_signals(BYVAL AS GtkBuilder PTR, BYVAL AS gpointer)
DECLARE SUB gtk_builder_connect_signals_full(BYVAL AS GtkBuilder PTR, BYVAL AS GtkBuilderConnectFunc, BYVAL AS gpointer)
DECLARE SUB gtk_builder_set_translation_domain(BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_builder_get_translation_domain(BYVAL AS GtkBuilder PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_builder_get_type_from_name(BYVAL AS GtkBuilder PTR, BYVAL AS CONST ZSTRING PTR) AS GType
DECLARE FUNCTION gtk_builder_value_from_string(BYVAL AS GtkBuilder PTR, BYVAL AS GParamSpec PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_builder_value_from_string_type(BYVAL AS GtkBuilder PTR, BYVAL AS GType, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR, BYVAL AS GError PTR PTR) AS gboolean

#DEFINE GTK_BUILDER_WARN_INVALID_CHILD_TYPE(object, type) _
  g_warning (!"'%s' is not a valid child type of '%s'", type, g_type_name (G_OBJECT_TYPE (object)))
#ENDIF ' __GTK_BUILDER_H__

#DEFINE GTK_TYPE_BUILDABLE (gtk_buildable_get_type ())
#DEFINE GTK_BUILDABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUILDABLE, GtkBuildable))
#DEFINE GTK_BUILDABLE_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_BUILDABLE, GtkBuildableIface))
#DEFINE GTK_IS_BUILDABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUILDABLE))
#DEFINE GTK_BUILDABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_BUILDABLE, GtkBuildableIface))

TYPE GtkBuildable AS _GtkBuildable
TYPE GtkBuildableIface AS _GtkBuildableIface

TYPE _GtkBuildableIface
  AS GTypeInterface g_iface
  set_name AS SUB(BYVAL AS GtkBuildable PTR, BYVAL AS CONST gchar PTR)
  get_name AS FUNCTION(BYVAL AS GtkBuildable PTR) AS CONST gchar PTR
  add_child AS SUB(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR)
  set_buildable_property AS SUB(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
  construct_child AS FUNCTION(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR) AS GObject PTR
  custom_tag_start AS FUNCTION(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMarkupParser PTR, BYVAL AS gpointer PTR) AS gboolean
  custom_tag_end AS SUB(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer PTR)
  custom_finished AS SUB(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
  parser_finished AS SUB(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR)
  get_internal_child AS FUNCTION(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR) AS GObject PTR
END TYPE

DECLARE FUNCTION gtk_buildable_get_type() AS GType
DECLARE SUB gtk_buildable_set_name(BYVAL AS GtkBuildable PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_buildable_get_name(BYVAL AS GtkBuildable PTR) AS CONST gchar PTR
DECLARE SUB gtk_buildable_add_child(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_buildable_set_buildable_property(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GValue PTR)
DECLARE FUNCTION gtk_buildable_construct_child(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR) AS GObject PTR
DECLARE FUNCTION gtk_buildable_custom_tag_start(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMarkupParser PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE SUB gtk_buildable_custom_tag_end(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer PTR)
DECLARE SUB gtk_buildable_custom_finished(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
DECLARE SUB gtk_buildable_parser_finished(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR)
DECLARE FUNCTION gtk_buildable_get_internal_child(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS CONST gchar PTR) AS GObject PTR

#ENDIF ' __GTK_BUILDABLE_H__

#IFNDEF __GTK_BUTTON_H__
#DEFINE __GTK_BUTTON_H__

#DEFINE GTK_TYPE_BUTTON (gtk_button_get_type ())
#DEFINE GTK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUTTON, GtkButton))
#DEFINE GTK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BUTTON, GtkButtonClass))
#DEFINE GTK_IS_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUTTON))
#DEFINE GTK_IS_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BUTTON))
#DEFINE GTK_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BUTTON, GtkButtonClass))

TYPE GtkButton AS _GtkButton
TYPE GtkButtonPrivate AS _GtkButtonPrivate
TYPE GtkButtonClass AS _GtkButtonClass

TYPE _GtkButton
  AS GtkBin bin
  AS GtkButtonPrivate PTR priv
END TYPE

TYPE _GtkButtonClass
  AS GtkBinClass parent_class
  pressed AS SUB(BYVAL AS GtkButton PTR)
  released AS SUB(BYVAL AS GtkButton PTR)
  clicked AS SUB(BYVAL AS GtkButton PTR)
  enter AS SUB(BYVAL AS GtkButton PTR)
  leave AS SUB(BYVAL AS GtkButton PTR)
  activate AS SUB(BYVAL AS GtkButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_button_get_type() AS GType
DECLARE FUNCTION gtk_button_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_button_new_with_label(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_button_new_from_stock(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_button_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_button_pressed(BYVAL AS GtkButton PTR)
DECLARE SUB gtk_button_released(BYVAL AS GtkButton PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_button_clicked(BYVAL AS GtkButton PTR)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_button_enter(BYVAL AS GtkButton PTR)
DECLARE SUB gtk_button_leave(BYVAL AS GtkButton PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_button_set_relief(BYVAL AS GtkButton PTR, BYVAL AS GtkReliefStyle)
DECLARE FUNCTION gtk_button_get_relief(BYVAL AS GtkButton PTR) AS GtkReliefStyle
DECLARE SUB gtk_button_set_label(BYVAL AS GtkButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_button_get_label(BYVAL AS GtkButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_button_set_use_underline(BYVAL AS GtkButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_button_get_use_underline(BYVAL AS GtkButton PTR) AS gboolean
DECLARE SUB gtk_button_set_use_stock(BYVAL AS GtkButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_button_get_use_stock(BYVAL AS GtkButton PTR) AS gboolean
DECLARE SUB gtk_button_set_focus_on_click(BYVAL AS GtkButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_button_get_focus_on_click(BYVAL AS GtkButton PTR) AS gboolean
DECLARE SUB gtk_button_set_alignment(BYVAL AS GtkButton PTR, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_button_get_alignment(BYVAL AS GtkButton PTR, BYVAL AS gfloat PTR, BYVAL AS gfloat PTR)
DECLARE SUB gtk_button_set_image(BYVAL AS GtkButton PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_button_get_image(BYVAL AS GtkButton PTR) AS GtkWidget PTR
DECLARE SUB gtk_button_set_image_position(BYVAL AS GtkButton PTR, BYVAL AS GtkPositionType)
DECLARE FUNCTION gtk_button_get_image_position(BYVAL AS GtkButton PTR) AS GtkPositionType
DECLARE FUNCTION gtk_button_get_event_window(BYVAL AS GtkButton PTR) AS GdkWindow PTR

#ENDIF ' __GTK_BUTTON_H__

#IFNDEF __GTK_CALENDAR_H__
#DEFINE __GTK_CALENDAR_H__

#DEFINE GTK_TYPE_CALENDAR (gtk_calendar_get_type ())
#DEFINE GTK_CALENDAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CALENDAR, GtkCalendar))
#DEFINE GTK_CALENDAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CALENDAR, GtkCalendarClass))
#DEFINE GTK_IS_CALENDAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CALENDAR))
#DEFINE GTK_IS_CALENDAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CALENDAR))
#DEFINE GTK_CALENDAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CALENDAR, GtkCalendarClass))

TYPE GtkCalendar AS _GtkCalendar
TYPE GtkCalendarClass AS _GtkCalendarClass
TYPE GtkCalendarPrivate AS _GtkCalendarPrivate

ENUM GtkCalendarDisplayOptions
  GTK_CALENDAR_SHOW_HEADING = 1 SHL 0
  GTK_CALENDAR_SHOW_DAY_NAMES = 1 SHL 1
  GTK_CALENDAR_NO_MONTH_CHANGE = 1 SHL 2
  GTK_CALENDAR_SHOW_WEEK_NUMBERS = 1 SHL 3
  GTK_CALENDAR_SHOW_DETAILS = 1 SHL 5
END ENUM

TYPE GtkCalendarDetailFunc AS FUNCTION(BYVAL AS GtkCalendar PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS gpointer) AS gchar PTR

TYPE _GtkCalendar
  AS GtkWidget widget
  AS GtkCalendarPrivate PTR priv
END TYPE

TYPE _GtkCalendarClass
  AS GtkWidgetClass parent_class
  month_changed AS SUB(BYVAL AS GtkCalendar PTR)
  day_selected AS SUB(BYVAL AS GtkCalendar PTR)
  day_selected_double_click AS SUB(BYVAL AS GtkCalendar PTR)
  prev_month AS SUB(BYVAL AS GtkCalendar PTR)
  next_month AS SUB(BYVAL AS GtkCalendar PTR)
  prev_year AS SUB(BYVAL AS GtkCalendar PTR)
  next_year AS SUB(BYVAL AS GtkCalendar PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_calendar_get_type() AS GType
DECLARE FUNCTION gtk_calendar_new() AS GtkWidget PTR
DECLARE SUB gtk_calendar_select_month(BYVAL AS GtkCalendar PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_calendar_select_day(BYVAL AS GtkCalendar PTR, BYVAL AS guint)
DECLARE SUB gtk_calendar_mark_day(BYVAL AS GtkCalendar PTR, BYVAL AS guint)
DECLARE SUB gtk_calendar_unmark_day(BYVAL AS GtkCalendar PTR, BYVAL AS guint)
DECLARE SUB gtk_calendar_clear_marks(BYVAL AS GtkCalendar PTR)
DECLARE SUB gtk_calendar_set_display_options(BYVAL AS GtkCalendar PTR, BYVAL AS GtkCalendarDisplayOptions)
DECLARE FUNCTION gtk_calendar_get_display_options(BYVAL AS GtkCalendar PTR) AS GtkCalendarDisplayOptions
DECLARE SUB gtk_calendar_get_date(BYVAL AS GtkCalendar PTR, BYVAL AS guint PTR, BYVAL AS guint PTR, BYVAL AS guint PTR)
DECLARE SUB gtk_calendar_set_detail_func(BYVAL AS GtkCalendar PTR, BYVAL AS GtkCalendarDetailFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_calendar_set_detail_width_chars(BYVAL AS GtkCalendar PTR, BYVAL AS gint)
DECLARE SUB gtk_calendar_set_detail_height_rows(BYVAL AS GtkCalendar PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_calendar_get_detail_width_chars(BYVAL AS GtkCalendar PTR) AS gint
DECLARE FUNCTION gtk_calendar_get_detail_height_rows(BYVAL AS GtkCalendar PTR) AS gint
DECLARE FUNCTION gtk_calendar_get_day_is_marked(BYVAL AS GtkCalendar PTR, BYVAL AS guint) AS gboolean

#ENDIF ' __GTK_CALENDAR_H__

#IFNDEF __GTK_CELL_AREA_BOX_H__
#DEFINE __GTK_CELL_AREA_BOX_H__

#DEFINE GTK_TYPE_CELL_AREA_BOX (gtk_cell_area_box_get_type ())
#DEFINE GTK_CELL_AREA_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_AREA_BOX, GtkCellAreaBox))
#DEFINE GTK_CELL_AREA_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_AREA_BOX, GtkCellAreaBoxClass))
#DEFINE GTK_IS_CELL_AREA_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_AREA_BOX))
#DEFINE GTK_IS_CELL_AREA_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_AREA_BOX))
#DEFINE GTK_CELL_AREA_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_AREA_BOX, GtkCellAreaBoxClass))

TYPE GtkCellAreaBox AS _GtkCellAreaBox
TYPE GtkCellAreaBoxClass AS _GtkCellAreaBoxClass
TYPE GtkCellAreaBoxPrivate AS _GtkCellAreaBoxPrivate

TYPE _GtkCellAreaBox
  AS GtkCellArea parent_instance
  AS GtkCellAreaBoxPrivate PTR priv
END TYPE

TYPE _GtkCellAreaBoxClass
  AS GtkCellAreaClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_area_box_get_type() AS GType
DECLARE FUNCTION gtk_cell_area_box_new() AS GtkCellArea PTR
DECLARE SUB gtk_cell_area_box_pack_start(BYVAL AS GtkCellAreaBox PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE SUB gtk_cell_area_box_pack_end(BYVAL AS GtkCellAreaBox PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_area_box_get_spacing(BYVAL AS GtkCellAreaBox PTR) AS gint
DECLARE SUB gtk_cell_area_box_set_spacing(BYVAL AS GtkCellAreaBox PTR, BYVAL AS gint)
DECLARE FUNCTION _gtk_cell_area_box_group_visible(BYVAL AS GtkCellAreaBox PTR, BYVAL AS gint) AS gboolean

#ENDIF ' __GTK_CELL_AREA_BOX_H__

#IFNDEF __GTK_CELL_AREA_CONTEXT_H__
#DEFINE __GTK_CELL_AREA_CONTEXT_H__

#DEFINE GTK_TYPE_CELL_AREA_CONTEXT (gtk_cell_area_context_get_type ())
#DEFINE GTK_CELL_AREA_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_AREA_CONTEXT, GtkCellAreaContext))
#DEFINE GTK_CELL_AREA_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_AREA_CONTEXT, GtkCellAreaContextClass))
#DEFINE GTK_IS_CELL_AREA_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_AREA_CONTEXT))
#DEFINE GTK_IS_CELL_AREA_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_AREA_CONTEXT))
#DEFINE GTK_CELL_AREA_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_AREA_CONTEXT, GtkCellAreaContextClass))

TYPE GtkCellAreaContextPrivate AS _GtkCellAreaContextPrivate
TYPE GtkCellAreaContextClass AS _GtkCellAreaContextClass

TYPE _GtkCellAreaContext
  AS GObject parent_instance
  AS GtkCellAreaContextPrivate PTR priv
END TYPE

TYPE _GtkCellAreaContextClass
  AS GObjectClass parent_class
  allocate_ AS SUB(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint)
  reset_ AS SUB(BYVAL AS GtkCellAreaContext PTR)
  get_preferred_height_for_width AS SUB(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  get_preferred_width_for_height AS SUB(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_area_context_get_type() AS GType
DECLARE FUNCTION gtk_cell_area_context_get_area(BYVAL AS GtkCellAreaContext PTR) AS GtkCellArea PTR
DECLARE SUB gtk_cell_area_context_allocate(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_cell_area_context_reset(BYVAL AS GtkCellAreaContext PTR)
DECLARE SUB gtk_cell_area_context_get_preferred_width(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_context_get_preferred_height(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_context_get_preferred_height_for_width(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_context_get_preferred_width_for_height(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_context_get_allocation(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_cell_area_context_push_preferred_width(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_cell_area_context_push_preferred_height(BYVAL AS GtkCellAreaContext PTR, BYVAL AS gint, BYVAL AS gint)

#ENDIF ' __GTK_CELL_AREA_CONTEXT_H__

#IFNDEF __GTK_CELL_LAYOUT_H__
#DEFINE __GTK_CELL_LAYOUT_H__

#DEFINE GTK_TYPE_CELL_LAYOUT (gtk_cell_layout_get_type ())
#DEFINE GTK_CELL_LAYOUT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_LAYOUT, GtkCellLayout))
#DEFINE GTK_IS_CELL_LAYOUT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_LAYOUT))
#DEFINE GTK_CELL_LAYOUT_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_CELL_LAYOUT, GtkCellLayoutIface))

TYPE GtkCellLayout AS _GtkCellLayout
TYPE GtkCellLayoutIface AS _GtkCellLayoutIface
TYPE GtkCellLayoutDataFunc AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer)

TYPE _GtkCellLayoutIface
  AS GTypeInterface g_iface
  pack_start AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
  pack_end AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
  clear_ AS SUB(BYVAL AS GtkCellLayout PTR)
  add_attribute AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
  set_cell_data_func AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkCellLayoutDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
  clear_attributes AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR)
  reorder AS SUB(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gint)
  get_cells AS FUNCTION(BYVAL AS GtkCellLayout PTR) AS GList PTR
  get_area AS FUNCTION(BYVAL AS GtkCellLayout PTR) AS GtkCellArea PTR
END TYPE

DECLARE FUNCTION gtk_cell_layout_get_type() AS GType
DECLARE SUB gtk_cell_layout_pack_start(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE SUB gtk_cell_layout_pack_end(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_layout_get_cells(BYVAL AS GtkCellLayout PTR) AS GList PTR
DECLARE SUB gtk_cell_layout_clear(BYVAL AS GtkCellLayout PTR)
DECLARE SUB gtk_cell_layout_set_attributes(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, ...)
DECLARE SUB gtk_cell_layout_add_attribute(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_cell_layout_set_cell_data_func(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS GtkCellLayoutDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gtk_cell_layout_clear_attributes(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE SUB gtk_cell_layout_reorder(BYVAL AS GtkCellLayout PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_cell_layout_get_area(BYVAL AS GtkCellLayout PTR) AS GtkCellArea PTR
DECLARE FUNCTION _gtk_cell_layout_buildable_custom_tag_start(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS GMarkupParser PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE FUNCTION _gtk_cell_layout_buildable_custom_tag_end(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer PTR) AS gboolean
DECLARE SUB _gtk_cell_layout_buildable_add_child(BYVAL AS GtkBuildable PTR, BYVAL AS GtkBuilder PTR, BYVAL AS GObject PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_CELL_LAYOUT_H__

#IFNDEF __GTK_CELL_RENDERER_ACCEL_H__
#DEFINE __GTK_CELL_RENDERER_ACCEL_H__

#IFNDEF __GTK_CELL_RENDERER_TEXT_H__
#DEFINE __GTK_CELL_RENDERER_TEXT_H__

#DEFINE GTK_TYPE_CELL_RENDERER_TEXT (gtk_cell_renderer_text_get_type ())
#DEFINE GTK_CELL_RENDERER_TEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_TEXT, GtkCellRendererText))
#DEFINE GTK_CELL_RENDERER_TEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_TEXT, GtkCellRendererTextClass))
#DEFINE GTK_IS_CELL_RENDERER_TEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_TEXT))
#DEFINE GTK_IS_CELL_RENDERER_TEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_TEXT))
#DEFINE GTK_CELL_RENDERER_TEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_TEXT, GtkCellRendererTextClass))

TYPE GtkCellRendererText AS _GtkCellRendererText
TYPE GtkCellRendererTextPrivate AS _GtkCellRendererTextPrivate
TYPE GtkCellRendererTextClass AS _GtkCellRendererTextClass

TYPE _GtkCellRendererText
  AS GtkCellRenderer parent
  AS GtkCellRendererTextPrivate PTR priv
END TYPE

TYPE _GtkCellRendererTextClass
  AS GtkCellRendererClass parent_class
  edited AS SUB(BYVAL AS GtkCellRendererText PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_text_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_text_new() AS GtkCellRenderer PTR
DECLARE SUB gtk_cell_renderer_text_set_fixed_height_from_font(BYVAL AS GtkCellRendererText PTR, BYVAL AS gint)

#ENDIF ' __GTK_CELL_RENDERER_TEXT_H__

#DEFINE GTK_TYPE_CELL_RENDERER_ACCEL (gtk_cell_renderer_accel_get_type ())
#DEFINE GTK_CELL_RENDERER_ACCEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_ACCEL, GtkCellRendererAccel))
#DEFINE GTK_CELL_RENDERER_ACCEL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_ACCEL, GtkCellRendererAccelClass))
#DEFINE GTK_IS_CELL_RENDERER_ACCEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_ACCEL))
#DEFINE GTK_IS_CELL_RENDERER_ACCEL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_ACCEL))
#DEFINE GTK_CELL_RENDERER_ACCEL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_ACCEL, GtkCellRendererAccelClass))

TYPE GtkCellRendererAccel AS _GtkCellRendererAccel
TYPE GtkCellRendererAccelPrivate AS _GtkCellRendererAccelPrivate
TYPE GtkCellRendererAccelClass AS _GtkCellRendererAccelClass

ENUM GtkCellRendererAccelMode
  GTK_CELL_RENDERER_ACCEL_MODE_GTK
  GTK_CELL_RENDERER_ACCEL_MODE_OTHER
END ENUM

TYPE _GtkCellRendererAccel
  AS GtkCellRendererText parent
  AS GtkCellRendererAccelPrivate PTR priv
END TYPE

TYPE _GtkCellRendererAccelClass
  AS GtkCellRendererTextClass parent_class
  accel_edited AS SUB(BYVAL AS GtkCellRendererAccel PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS guint)
  accel_cleared AS SUB(BYVAL AS GtkCellRendererAccel PTR, BYVAL AS CONST gchar PTR)
  _gtk_reserved0 AS SUB()
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_accel_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_accel_new() AS GtkCellRenderer PTR

#ENDIF ' __GTK_CELL_RENDERER_ACCEL_H__

#IFNDEF __GTK_CELL_RENDERER_COMBO_H__
#DEFINE __GTK_CELL_RENDERER_COMBO_H__

#DEFINE GTK_TYPE_CELL_RENDERER_COMBO (gtk_cell_renderer_combo_get_type ())
#DEFINE GTK_CELL_RENDERER_COMBO(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererCombo))
#DEFINE GTK_CELL_RENDERER_COMBO_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererComboClass))
#DEFINE GTK_IS_CELL_RENDERER_COMBO(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_COMBO))
#DEFINE GTK_IS_CELL_RENDERER_COMBO_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_COMBO))
#DEFINE GTK_CELL_RENDERER_COMBO_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_COMBO, GtkCellRendererTextClass))

TYPE GtkCellRendererCombo AS _GtkCellRendererCombo
TYPE GtkCellRendererComboPrivate AS _GtkCellRendererComboPrivate
TYPE GtkCellRendererComboClass AS _GtkCellRendererComboClass

TYPE _GtkCellRendererCombo
  AS GtkCellRendererText parent
  AS GtkCellRendererComboPrivate PTR priv
END TYPE

TYPE _GtkCellRendererComboClass
  AS GtkCellRendererTextClass parent
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_combo_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_combo_new() AS GtkCellRenderer PTR

#ENDIF ' __GTK_CELL_RENDERER_COMBO_H__

#IFNDEF __GTK_CELL_RENDERER_PIXBUF_H__
#DEFINE __GTK_CELL_RENDERER_PIXBUF_H__

#DEFINE GTK_TYPE_CELL_RENDERER_PIXBUF (gtk_cell_renderer_pixbuf_get_type ())
#DEFINE GTK_CELL_RENDERER_PIXBUF(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbuf))
#DEFINE GTK_CELL_RENDERER_PIXBUF_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbufClass))
#DEFINE GTK_IS_CELL_RENDERER_PIXBUF(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_PIXBUF))
#DEFINE GTK_IS_CELL_RENDERER_PIXBUF_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_PIXBUF))
#DEFINE GTK_CELL_RENDERER_PIXBUF_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_PIXBUF, GtkCellRendererPixbufClass))

TYPE GtkCellRendererPixbuf AS _GtkCellRendererPixbuf
TYPE GtkCellRendererPixbufPrivate AS _GtkCellRendererPixbufPrivate
TYPE GtkCellRendererPixbufClass AS _GtkCellRendererPixbufClass

TYPE _GtkCellRendererPixbuf
  AS GtkCellRenderer parent
  AS GtkCellRendererPixbufPrivate PTR priv
END TYPE

TYPE _GtkCellRendererPixbufClass
  AS GtkCellRendererClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_pixbuf_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_pixbuf_new() AS GtkCellRenderer PTR

#ENDIF ' __GTK_CELL_RENDERER_PIXBUF_H__

#IFNDEF __GTK_CELL_RENDERER_PROGRESS_H__
#DEFINE __GTK_CELL_RENDERER_PROGRESS_H__

#DEFINE GTK_TYPE_CELL_RENDERER_PROGRESS (gtk_cell_renderer_progress_get_type ())
#DEFINE GTK_CELL_RENDERER_PROGRESS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgress))
#DEFINE GTK_CELL_RENDERER_PROGRESS_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgressClass))
#DEFINE GTK_IS_CELL_RENDERER_PROGRESS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_PROGRESS))
#DEFINE GTK_IS_CELL_RENDERER_PROGRESS_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_PROGRESS))
#DEFINE GTK_CELL_RENDERER_PROGRESS_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_PROGRESS, GtkCellRendererProgressClass))

TYPE GtkCellRendererProgress AS _GtkCellRendererProgress
TYPE GtkCellRendererProgressClass AS _GtkCellRendererProgressClass
TYPE GtkCellRendererProgressPrivate AS _GtkCellRendererProgressPrivate

TYPE _GtkCellRendererProgress
  AS GtkCellRenderer parent_instance
  AS GtkCellRendererProgressPrivate PTR priv
END TYPE

TYPE _GtkCellRendererProgressClass
  AS GtkCellRendererClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_progress_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_progress_new() AS GtkCellRenderer PTR

#ENDIF ' __GTK_CELL_RENDERER_PROGRESS_H__

#IFNDEF __GTK_CELL_RENDERER_SPIN_H__
#DEFINE __GTK_CELL_RENDERER_SPIN_H__

#DEFINE GTK_TYPE_CELL_RENDERER_SPIN (gtk_cell_renderer_spin_get_type ())
#DEFINE GTK_CELL_RENDERER_SPIN(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_SPIN, GtkCellRendererSpin))
#DEFINE GTK_CELL_RENDERER_SPIN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_SPIN, GtkCellRendererSpinClass))
#DEFINE GTK_IS_CELL_RENDERER_SPIN(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_SPIN))
#DEFINE GTK_IS_CELL_RENDERER_SPIN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_SPIN))
#DEFINE GTK_CELL_RENDERER_SPIN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_SPIN, GtkCellRendererTextClass))

TYPE GtkCellRendererSpin AS _GtkCellRendererSpin
TYPE GtkCellRendererSpinClass AS _GtkCellRendererSpinClass
TYPE GtkCellRendererSpinPrivate AS _GtkCellRendererSpinPrivate

TYPE _GtkCellRendererSpin
  AS GtkCellRendererText parent
  AS GtkCellRendererSpinPrivate PTR priv
END TYPE

TYPE _GtkCellRendererSpinClass
  AS GtkCellRendererTextClass parent
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_spin_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_spin_new() AS GtkCellRenderer PTR

#ENDIF ' __GTK_CELL_RENDERER_SPIN_H__

#IFNDEF __GTK_CELL_RENDERER_SPINNER_H__
#DEFINE __GTK_CELL_RENDERER_SPINNER_H__

#DEFINE GTK_TYPE_CELL_RENDERER_SPINNER (gtk_cell_renderer_spinner_get_type ())
#DEFINE GTK_CELL_RENDERER_SPINNER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_SPINNER, GtkCellRendererSpinner))
#DEFINE GTK_CELL_RENDERER_SPINNER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_SPINNER, GtkCellRendererSpinnerClass))
#DEFINE GTK_IS_CELL_RENDERER_SPINNER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_SPINNER))
#DEFINE GTK_IS_CELL_RENDERER_SPINNER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_SPINNER))
#DEFINE GTK_CELL_RENDERER_SPINNER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_SPINNER, GtkCellRendererSpinnerClass))

TYPE GtkCellRendererSpinner AS _GtkCellRendererSpinner
TYPE GtkCellRendererSpinnerClass AS _GtkCellRendererSpinnerClass
TYPE GtkCellRendererSpinnerPrivate AS _GtkCellRendererSpinnerPrivate

TYPE _GtkCellRendererSpinner
  AS GtkCellRenderer parent
  AS GtkCellRendererSpinnerPrivate PTR priv
END TYPE

TYPE _GtkCellRendererSpinnerClass
  AS GtkCellRendererClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_spinner_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_spinner_new() AS GtkCellRenderer PTR

#ENDIF ' __GTK_CELL_RENDERER_SPINNER_H__

#IFNDEF __GTK_CELL_RENDERER_TOGGLE_H__
#DEFINE __GTK_CELL_RENDERER_TOGGLE_H__

#DEFINE GTK_TYPE_CELL_RENDERER_TOGGLE (gtk_cell_renderer_toggle_get_type ())
#DEFINE GTK_CELL_RENDERER_TOGGLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggle))
#DEFINE GTK_CELL_RENDERER_TOGGLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggleClass))
#DEFINE GTK_IS_CELL_RENDERER_TOGGLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_RENDERER_TOGGLE))
#DEFINE GTK_IS_CELL_RENDERER_TOGGLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CELL_RENDERER_TOGGLE))
#DEFINE GTK_CELL_RENDERER_TOGGLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CELL_RENDERER_TOGGLE, GtkCellRendererToggleClass))

TYPE GtkCellRendererToggle AS _GtkCellRendererToggle
TYPE GtkCellRendererTogglePrivate AS _GtkCellRendererTogglePrivate
TYPE GtkCellRendererToggleClass AS _GtkCellRendererToggleClass

TYPE _GtkCellRendererToggle
  AS GtkCellRenderer parent
  AS GtkCellRendererTogglePrivate PTR priv
END TYPE

TYPE _GtkCellRendererToggleClass
  AS GtkCellRendererClass parent_class
  toggled AS SUB(BYVAL AS GtkCellRendererToggle PTR, BYVAL AS CONST gchar PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_renderer_toggle_get_type() AS GType
DECLARE FUNCTION gtk_cell_renderer_toggle_new() AS GtkCellRenderer PTR
DECLARE FUNCTION gtk_cell_renderer_toggle_get_radio(BYVAL AS GtkCellRendererToggle PTR) AS gboolean
DECLARE SUB gtk_cell_renderer_toggle_set_radio(BYVAL AS GtkCellRendererToggle PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_renderer_toggle_get_active(BYVAL AS GtkCellRendererToggle PTR) AS gboolean
DECLARE SUB gtk_cell_renderer_toggle_set_active(BYVAL AS GtkCellRendererToggle PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_renderer_toggle_get_activatable(BYVAL AS GtkCellRendererToggle PTR) AS gboolean
DECLARE SUB gtk_cell_renderer_toggle_set_activatable(BYVAL AS GtkCellRendererToggle PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_CELL_RENDERER_TOGGLE_H__

#IFNDEF __GTK_CELL_VIEW_H__
#DEFINE __GTK_CELL_VIEW_H__

#DEFINE GTK_TYPE_CELL_VIEW (gtk_cell_view_get_type ())
#DEFINE GTK_CELL_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CELL_VIEW, GtkCellView))
#DEFINE GTK_CELL_VIEW_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_CELL_VIEW, GtkCellViewClass))
#DEFINE GTK_IS_CELL_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CELL_VIEW))
#DEFINE GTK_IS_CELL_VIEW_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_CELL_VIEW))
#DEFINE GTK_CELL_VIEW_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), GTK_TYPE_CELL_VIEW, GtkCellViewClass))

TYPE GtkCellView AS _GtkCellView
TYPE GtkCellViewClass AS _GtkCellViewClass
TYPE GtkCellViewPrivate AS _GtkCellViewPrivate

TYPE _GtkCellView
  AS GtkWidget parent_instance
  AS GtkCellViewPrivate PTR priv
END TYPE

TYPE _GtkCellViewClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_cell_view_get_type() AS GType
DECLARE FUNCTION gtk_cell_view_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_cell_view_new_with_context(BYVAL AS GtkCellArea PTR, BYVAL AS GtkCellAreaContext PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_cell_view_new_with_text(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_cell_view_new_with_markup(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_cell_view_new_with_pixbuf(BYVAL AS GdkPixbuf PTR) AS GtkWidget PTR
DECLARE SUB gtk_cell_view_set_model(BYVAL AS GtkCellView PTR, BYVAL AS GtkTreeModel PTR)
DECLARE FUNCTION gtk_cell_view_get_model(BYVAL AS GtkCellView PTR) AS GtkTreeModel PTR
DECLARE SUB gtk_cell_view_set_displayed_row(BYVAL AS GtkCellView PTR, BYVAL AS GtkTreePath PTR)
DECLARE FUNCTION gtk_cell_view_get_displayed_row(BYVAL AS GtkCellView PTR) AS GtkTreePath PTR
DECLARE SUB gtk_cell_view_set_background_color(BYVAL AS GtkCellView PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_cell_view_set_background_rgba(BYVAL AS GtkCellView PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE FUNCTION gtk_cell_view_get_draw_sensitive(BYVAL AS GtkCellView PTR) AS gboolean
DECLARE SUB gtk_cell_view_set_draw_sensitive(BYVAL AS GtkCellView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_cell_view_get_fit_model(BYVAL AS GtkCellView PTR) AS gboolean
DECLARE SUB gtk_cell_view_set_fit_model(BYVAL AS GtkCellView PTR, BYVAL AS gboolean)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_cell_view_get_size_of_row(BYVAL AS GtkCellView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkRequisition PTR) AS gboolean

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_CELL_VIEW_H__

#IFNDEF __GTK_CHECK_BUTTON_H__
#DEFINE __GTK_CHECK_BUTTON_H__

#IFNDEF __GTK_TOGGLE_BUTTON_H__
#DEFINE __GTK_TOGGLE_BUTTON_H__

#DEFINE GTK_TYPE_TOGGLE_BUTTON (gtk_toggle_button_get_type ())
#DEFINE GTK_TOGGLE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButton))
#DEFINE GTK_TOGGLE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass))
#DEFINE GTK_IS_TOGGLE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOGGLE_BUTTON))
#DEFINE GTK_IS_TOGGLE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOGGLE_BUTTON))
#DEFINE GTK_TOGGLE_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass))

TYPE GtkToggleButton AS _GtkToggleButton
TYPE GtkToggleButtonPrivate AS _GtkToggleButtonPrivate
TYPE GtkToggleButtonClass AS _GtkToggleButtonClass

TYPE _GtkToggleButton
  AS GtkButton button
  AS GtkToggleButtonPrivate PTR priv
END TYPE

TYPE _GtkToggleButtonClass
  AS GtkButtonClass parent_class
  toggled AS SUB(BYVAL AS GtkToggleButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_toggle_button_get_type() AS GType
DECLARE FUNCTION gtk_toggle_button_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_toggle_button_new_with_label(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_toggle_button_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_toggle_button_set_mode(BYVAL AS GtkToggleButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toggle_button_get_mode(BYVAL AS GtkToggleButton PTR) AS gboolean
DECLARE SUB gtk_toggle_button_set_active(BYVAL AS GtkToggleButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toggle_button_get_active(BYVAL AS GtkToggleButton PTR) AS gboolean
DECLARE SUB gtk_toggle_button_toggled(BYVAL AS GtkToggleButton PTR)
DECLARE SUB gtk_toggle_button_set_inconsistent(BYVAL AS GtkToggleButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toggle_button_get_inconsistent(BYVAL AS GtkToggleButton PTR) AS gboolean
DECLARE SUB _gtk_toggle_button_set_active(BYVAL AS GtkToggleButton PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_TOGGLE_BUTTON_H__

#DEFINE GTK_TYPE_CHECK_BUTTON (gtk_check_button_get_type ())
#DEFINE GTK_CHECK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CHECK_BUTTON, GtkCheckButton))
#DEFINE GTK_CHECK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CHECK_BUTTON, GtkCheckButtonClass))
#DEFINE GTK_IS_CHECK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CHECK_BUTTON))
#DEFINE GTK_IS_CHECK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CHECK_BUTTON))
#DEFINE GTK_CHECK_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CHECK_BUTTON, GtkCheckButtonClass))

TYPE GtkCheckButton AS _GtkCheckButton
TYPE GtkCheckButtonClass AS _GtkCheckButtonClass

TYPE _GtkCheckButton
  AS GtkToggleButton toggle_button
END TYPE

TYPE _GtkCheckButtonClass
  AS GtkToggleButtonClass parent_class
  draw_indicator AS SUB(BYVAL AS GtkCheckButton PTR, BYVAL AS cairo_t PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_check_button_get_type() AS GType
DECLARE FUNCTION gtk_check_button_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_check_button_new_with_label(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_check_button_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB _gtk_check_button_get_props(BYVAL AS GtkCheckButton PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)

#ENDIF ' __GTK_CHECK_BUTTON_H__

#IFNDEF __GTK_CHECK_MENU_ITEM_H__
#DEFINE __GTK_CHECK_MENU_ITEM_H__

#IFNDEF __GTK_MENU_ITEM_H__
#DEFINE __GTK_MENU_ITEM_H__

#DEFINE GTK_TYPE_MENU_ITEM (gtk_menu_item_get_type ())
#DEFINE GTK_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MENU_ITEM, GtkMenuItem))
#DEFINE GTK_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MENU_ITEM, GtkMenuItemClass))
#DEFINE GTK_IS_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MENU_ITEM))
#DEFINE GTK_IS_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MENU_ITEM))
#DEFINE GTK_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MENU_ITEM, GtkMenuItemClass))

TYPE GtkMenuItem AS _GtkMenuItem
TYPE GtkMenuItemClass AS _GtkMenuItemClass
TYPE GtkMenuItemPrivate AS _GtkMenuItemPrivate

TYPE _GtkMenuItem
  AS GtkBin bin
  AS GtkMenuItemPrivate PTR priv
END TYPE

TYPE _GtkMenuItemClass
  AS GtkBinClass parent_class
  AS guint hide_on_activate : 1
  activate AS SUB(BYVAL AS GtkMenuItem PTR)
  activate_item AS SUB(BYVAL AS GtkMenuItem PTR)
  toggle_size_request AS SUB(BYVAL AS GtkMenuItem PTR, BYVAL AS gint PTR)
  toggle_size_allocate AS SUB(BYVAL AS GtkMenuItem PTR, BYVAL AS gint)
  set_label AS SUB(BYVAL AS GtkMenuItem PTR, BYVAL AS CONST gchar PTR)
  get_label AS FUNCTION(BYVAL AS GtkMenuItem PTR) AS CONST gchar PTR
  select_ AS SUB(BYVAL AS GtkMenuItem PTR)
  deselect AS SUB(BYVAL AS GtkMenuItem PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_menu_item_get_type() AS GType
DECLARE FUNCTION gtk_menu_item_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_menu_item_new_with_label(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_menu_item_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_menu_item_set_submenu(BYVAL AS GtkMenuItem PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_menu_item_get_submenu(BYVAL AS GtkMenuItem PTR) AS GtkWidget PTR
DECLARE SUB gtk_menu_item_select(BYVAL AS GtkMenuItem PTR)
DECLARE SUB gtk_menu_item_deselect(BYVAL AS GtkMenuItem PTR)
DECLARE SUB gtk_menu_item_activate(BYVAL AS GtkMenuItem PTR)
DECLARE SUB gtk_menu_item_toggle_size_request(BYVAL AS GtkMenuItem PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_menu_item_toggle_size_allocate(BYVAL AS GtkMenuItem PTR, BYVAL AS gint)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_menu_item_set_right_justified(BYVAL AS GtkMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_menu_item_get_right_justified(BYVAL AS GtkMenuItem PTR) AS gboolean

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_menu_item_set_accel_path(BYVAL AS GtkMenuItem PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_menu_item_get_accel_path(BYVAL AS GtkMenuItem PTR) AS CONST gchar PTR
DECLARE SUB gtk_menu_item_set_label(BYVAL AS GtkMenuItem PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_menu_item_get_label(BYVAL AS GtkMenuItem PTR) AS CONST gchar PTR
DECLARE SUB gtk_menu_item_set_use_underline(BYVAL AS GtkMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_menu_item_get_use_underline(BYVAL AS GtkMenuItem PTR) AS gboolean
DECLARE SUB gtk_menu_item_set_reserve_indicator(BYVAL AS GtkMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_menu_item_get_reserve_indicator(BYVAL AS GtkMenuItem PTR) AS gboolean

#ENDIF ' __GTK_MENU_ITEM_H__

#DEFINE GTK_TYPE_CHECK_MENU_ITEM (gtk_check_menu_item_get_type ())
#DEFINE GTK_CHECK_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItem))
#DEFINE GTK_CHECK_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass))
#DEFINE GTK_IS_CHECK_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CHECK_MENU_ITEM))
#DEFINE GTK_IS_CHECK_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CHECK_MENU_ITEM))
#DEFINE GTK_CHECK_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CHECK_MENU_ITEM, GtkCheckMenuItemClass))

TYPE GtkCheckMenuItem AS _GtkCheckMenuItem
TYPE GtkCheckMenuItemPrivate AS _GtkCheckMenuItemPrivate
TYPE GtkCheckMenuItemClass AS _GtkCheckMenuItemClass

TYPE _GtkCheckMenuItem
  AS GtkMenuItem menu_item
  AS GtkCheckMenuItemPrivate PTR priv
END TYPE

TYPE _GtkCheckMenuItemClass
  AS GtkMenuItemClass parent_class
  toggled AS SUB(BYVAL AS GtkCheckMenuItem PTR)
  draw_indicator AS SUB(BYVAL AS GtkCheckMenuItem PTR, BYVAL AS cairo_t PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_check_menu_item_get_type() AS GType
DECLARE FUNCTION gtk_check_menu_item_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_check_menu_item_new_with_label(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_check_menu_item_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_check_menu_item_set_active(BYVAL AS GtkCheckMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_check_menu_item_get_active(BYVAL AS GtkCheckMenuItem PTR) AS gboolean
DECLARE SUB gtk_check_menu_item_toggled(BYVAL AS GtkCheckMenuItem PTR)
DECLARE SUB gtk_check_menu_item_set_inconsistent(BYVAL AS GtkCheckMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_check_menu_item_get_inconsistent(BYVAL AS GtkCheckMenuItem PTR) AS gboolean
DECLARE SUB gtk_check_menu_item_set_draw_as_radio(BYVAL AS GtkCheckMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_check_menu_item_get_draw_as_radio(BYVAL AS GtkCheckMenuItem PTR) AS gboolean
DECLARE SUB _gtk_check_menu_item_set_active(BYVAL AS GtkCheckMenuItem PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_CHECK_MENU_ITEM_H__

#IFNDEF __GTK_CLIPBOARD_H__
#DEFINE __GTK_CLIPBOARD_H__

#DEFINE GTK_TYPE_CLIPBOARD (gtk_clipboard_get_type ())
#DEFINE GTK_CLIPBOARD(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CLIPBOARD, GtkClipboard))
#DEFINE GTK_IS_CLIPBOARD(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CLIPBOARD))

TYPE GtkClipboardReceivedFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS GtkSelectionData PTR, BYVAL AS gpointer)
TYPE GtkClipboardTextReceivedFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
TYPE GtkClipboardRichTextReceivedFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS GdkAtom, BYVAL AS CONST guint8 PTR, BYVAL AS gsize, BYVAL AS gpointer)
TYPE GtkClipboardImageReceivedFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gpointer)
TYPE GtkClipboardURIReceivedFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS gchar PTR PTR, BYVAL AS gpointer)
TYPE GtkClipboardTargetsReceivedFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint, BYVAL AS gpointer)
TYPE GtkClipboardGetFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS GtkSelectionData PTR, BYVAL AS guint, BYVAL AS gpointer)
TYPE GtkClipboardClearFunc AS SUB(BYVAL AS GtkClipboard PTR, BYVAL AS gpointer)

DECLARE FUNCTION gtk_clipboard_get_type() AS GType
DECLARE FUNCTION gtk_clipboard_get_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom) AS GtkClipboard PTR

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gtk_clipboard_get(BYVAL AS GdkAtom) AS GtkClipboard PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gtk_clipboard_get_display(BYVAL AS GtkClipboard PTR) AS GdkDisplay PTR
DECLARE FUNCTION gtk_clipboard_set_with_data(BYVAL AS GtkClipboard PTR, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS guint, BYVAL AS GtkClipboardGetFunc, BYVAL AS GtkClipboardClearFunc, BYVAL AS gpointer) AS gboolean
DECLARE FUNCTION gtk_clipboard_set_with_owner(BYVAL AS GtkClipboard PTR, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS guint, BYVAL AS GtkClipboardGetFunc, BYVAL AS GtkClipboardClearFunc, BYVAL AS GObject PTR) AS gboolean
DECLARE FUNCTION gtk_clipboard_get_owner(BYVAL AS GtkClipboard PTR) AS GObject PTR
DECLARE SUB gtk_clipboard_clear(BYVAL AS GtkClipboard PTR)
DECLARE SUB gtk_clipboard_set_text(BYVAL AS GtkClipboard PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_clipboard_set_image(BYVAL AS GtkClipboard PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_clipboard_request_contents(BYVAL AS GtkClipboard PTR, BYVAL AS GdkAtom, BYVAL AS GtkClipboardReceivedFunc, BYVAL AS gpointer)
DECLARE SUB gtk_clipboard_request_text(BYVAL AS GtkClipboard PTR, BYVAL AS GtkClipboardTextReceivedFunc, BYVAL AS gpointer)
DECLARE SUB gtk_clipboard_request_rich_text(BYVAL AS GtkClipboard PTR, BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboardRichTextReceivedFunc, BYVAL AS gpointer)
DECLARE SUB gtk_clipboard_request_image(BYVAL AS GtkClipboard PTR, BYVAL AS GtkClipboardImageReceivedFunc, BYVAL AS gpointer)
DECLARE SUB gtk_clipboard_request_uris(BYVAL AS GtkClipboard PTR, BYVAL AS GtkClipboardURIReceivedFunc, BYVAL AS gpointer)
DECLARE SUB gtk_clipboard_request_targets(BYVAL AS GtkClipboard PTR, BYVAL AS GtkClipboardTargetsReceivedFunc, BYVAL AS gpointer)
DECLARE FUNCTION gtk_clipboard_wait_for_contents(BYVAL AS GtkClipboard PTR, BYVAL AS GdkAtom) AS GtkSelectionData PTR
DECLARE FUNCTION gtk_clipboard_wait_for_text(BYVAL AS GtkClipboard PTR) AS gchar PTR
DECLARE FUNCTION gtk_clipboard_wait_for_rich_text(BYVAL AS GtkClipboard PTR, BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom PTR, BYVAL AS gsize PTR) AS guint8 PTR
DECLARE FUNCTION gtk_clipboard_wait_for_image(BYVAL AS GtkClipboard PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_clipboard_wait_for_uris(BYVAL AS GtkClipboard PTR) AS gchar PTR PTR
DECLARE FUNCTION gtk_clipboard_wait_for_targets(BYVAL AS GtkClipboard PTR, BYVAL AS GdkAtom PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_clipboard_wait_is_text_available(BYVAL AS GtkClipboard PTR) AS gboolean
DECLARE FUNCTION gtk_clipboard_wait_is_rich_text_available(BYVAL AS GtkClipboard PTR, BYVAL AS GtkTextBuffer PTR) AS gboolean
DECLARE FUNCTION gtk_clipboard_wait_is_image_available(BYVAL AS GtkClipboard PTR) AS gboolean
DECLARE FUNCTION gtk_clipboard_wait_is_uris_available(BYVAL AS GtkClipboard PTR) AS gboolean
DECLARE FUNCTION gtk_clipboard_wait_is_target_available(BYVAL AS GtkClipboard PTR, BYVAL AS GdkAtom) AS gboolean
DECLARE SUB gtk_clipboard_set_can_store(BYVAL AS GtkClipboard PTR, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint)
DECLARE SUB gtk_clipboard_store(BYVAL AS GtkClipboard PTR)
DECLARE SUB _gtk_clipboard_handle_event(BYVAL AS GdkEventOwnerChange PTR)
DECLARE SUB _gtk_clipboard_store_all()

#ENDIF ' __GTK_CLIPBOARD_H__

#IFNDEF __GTK_COLOR_BUTTON_H__
#DEFINE __GTK_COLOR_BUTTON_H__

#DEFINE GTK_TYPE_COLOR_BUTTON (gtk_color_button_get_type ())
#DEFINE GTK_COLOR_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COLOR_BUTTON, GtkColorButton))
#DEFINE GTK_COLOR_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_COLOR_BUTTON, GtkColorButtonClass))
#DEFINE GTK_IS_COLOR_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COLOR_BUTTON))
#DEFINE GTK_IS_COLOR_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_COLOR_BUTTON))
#DEFINE GTK_COLOR_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_COLOR_BUTTON, GtkColorButtonClass))

TYPE GtkColorButton AS _GtkColorButton
TYPE GtkColorButtonClass AS _GtkColorButtonClass
TYPE GtkColorButtonPrivate AS _GtkColorButtonPrivate

TYPE _GtkColorButton
  AS GtkButton button
  AS GtkColorButtonPrivate PTR priv
END TYPE

TYPE _GtkColorButtonClass
  AS GtkButtonClass parent_class
  color_set AS SUB(BYVAL AS GtkColorButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_color_button_get_type() AS GType
DECLARE FUNCTION gtk_color_button_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_color_button_new_with_color(BYVAL AS CONST GdkColor PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_color_button_new_with_rgba(BYVAL AS CONST GdkRGBA PTR) AS GtkWidget PTR
DECLARE SUB gtk_color_button_set_color(BYVAL AS GtkColorButton PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_color_button_set_alpha(BYVAL AS GtkColorButton PTR, BYVAL AS guint16)
DECLARE SUB gtk_color_button_get_color(BYVAL AS GtkColorButton PTR, BYVAL AS GdkColor PTR)
DECLARE FUNCTION gtk_color_button_get_alpha(BYVAL AS GtkColorButton PTR) AS guint16
DECLARE SUB gtk_color_button_set_use_alpha(BYVAL AS GtkColorButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_color_button_get_use_alpha(BYVAL AS GtkColorButton PTR) AS gboolean
DECLARE SUB gtk_color_button_set_rgba(BYVAL AS GtkColorButton PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_color_button_get_rgba(BYVAL AS GtkColorButton PTR, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_color_button_set_title(BYVAL AS GtkColorButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_color_button_get_title(BYVAL AS GtkColorButton PTR) AS CONST gchar PTR

#ENDIF ' __GTK_COLOR_BUTTON_H__

#IFNDEF __GTK_COLOR_SELECTION_H__
#DEFINE __GTK_COLOR_SELECTION_H__

#DEFINE GTK_TYPE_COLOR_SELECTION (gtk_color_selection_get_type ())
#DEFINE GTK_COLOR_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelection))
#DEFINE GTK_COLOR_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass))
#DEFINE GTK_IS_COLOR_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COLOR_SELECTION))
#DEFINE GTK_IS_COLOR_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_COLOR_SELECTION))
#DEFINE GTK_COLOR_SELECTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_COLOR_SELECTION, GtkColorSelectionClass))

TYPE GtkColorSelection AS _GtkColorSelection
TYPE GtkColorSelectionPrivate AS _GtkColorSelectionPrivate
TYPE GtkColorSelectionClass AS _GtkColorSelectionClass
TYPE GtkColorSelectionChangePaletteFunc AS SUB(BYVAL AS CONST GdkColor PTR, BYVAL AS gint)
TYPE GtkColorSelectionChangePaletteWithScreenFunc AS SUB(BYVAL AS GdkScreen PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS gint)

TYPE _GtkColorSelection
  AS GtkBox parent_instance
  AS GtkColorSelectionPrivate PTR private_data
END TYPE

TYPE _GtkColorSelectionClass
  AS GtkBoxClass parent_class
  color_changed AS SUB(BYVAL AS GtkColorSelection PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_color_selection_get_type() AS GType
DECLARE FUNCTION gtk_color_selection_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_color_selection_get_has_opacity_control(BYVAL AS GtkColorSelection PTR) AS gboolean
DECLARE SUB gtk_color_selection_set_has_opacity_control(BYVAL AS GtkColorSelection PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_color_selection_get_has_palette(BYVAL AS GtkColorSelection PTR) AS gboolean
DECLARE SUB gtk_color_selection_set_has_palette(BYVAL AS GtkColorSelection PTR, BYVAL AS gboolean)
DECLARE SUB gtk_color_selection_set_current_color(BYVAL AS GtkColorSelection PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_color_selection_set_current_alpha(BYVAL AS GtkColorSelection PTR, BYVAL AS guint16)
DECLARE SUB gtk_color_selection_get_current_color(BYVAL AS GtkColorSelection PTR, BYVAL AS GdkColor PTR)
DECLARE FUNCTION gtk_color_selection_get_current_alpha(BYVAL AS GtkColorSelection PTR) AS guint16
DECLARE SUB gtk_color_selection_set_previous_color(BYVAL AS GtkColorSelection PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gtk_color_selection_set_previous_alpha(BYVAL AS GtkColorSelection PTR, BYVAL AS guint16)
DECLARE SUB gtk_color_selection_get_previous_color(BYVAL AS GtkColorSelection PTR, BYVAL AS GdkColor PTR)
DECLARE FUNCTION gtk_color_selection_get_previous_alpha(BYVAL AS GtkColorSelection PTR) AS guint16
DECLARE SUB gtk_color_selection_set_current_rgba(BYVAL AS GtkColorSelection PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_color_selection_get_current_rgba(BYVAL AS GtkColorSelection PTR, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_color_selection_set_previous_rgba(BYVAL AS GtkColorSelection PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gtk_color_selection_get_previous_rgba(BYVAL AS GtkColorSelection PTR, BYVAL AS GdkRGBA PTR)
DECLARE FUNCTION gtk_color_selection_is_adjusting(BYVAL AS GtkColorSelection PTR) AS gboolean
DECLARE FUNCTION gtk_color_selection_palette_from_string(BYVAL AS CONST gchar PTR, BYVAL AS GdkColor PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_color_selection_palette_to_string(BYVAL AS CONST GdkColor PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION gtk_color_selection_set_change_palette_with_screen_hook(BYVAL AS GtkColorSelectionChangePaletteWithScreenFunc) AS GtkColorSelectionChangePaletteWithScreenFunc

#ENDIF ' __GTK_COLOR_SELECTION_H__

#IFNDEF __GTK_COLOR_SELECTION_DIALOG_H__
#DEFINE __GTK_COLOR_SELECTION_DIALOG_H__

#DEFINE GTK_TYPE_COLOR_SELECTION_DIALOG (gtk_color_selection_dialog_get_type ())
#DEFINE GTK_COLOR_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialog))
#DEFINE GTK_COLOR_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass))
#DEFINE GTK_IS_COLOR_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COLOR_SELECTION_DIALOG))
#DEFINE GTK_IS_COLOR_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_COLOR_SELECTION_DIALOG))
#DEFINE GTK_COLOR_SELECTION_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_COLOR_SELECTION_DIALOG, GtkColorSelectionDialogClass))

TYPE GtkColorSelectionDialog AS _GtkColorSelectionDialog
TYPE GtkColorSelectionDialogPrivate AS _GtkColorSelectionDialogPrivate
TYPE GtkColorSelectionDialogClass AS _GtkColorSelectionDialogClass

TYPE _GtkColorSelectionDialog
  AS GtkDialog parent_instance
  AS GtkColorSelectionDialogPrivate PTR priv
END TYPE

TYPE _GtkColorSelectionDialogClass
  AS GtkDialogClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_color_selection_dialog_get_type() AS GType
DECLARE FUNCTION gtk_color_selection_dialog_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_color_selection_dialog_get_color_selection(BYVAL AS GtkColorSelectionDialog PTR) AS GtkWidget PTR

#ENDIF ' __GTK_COLOR_SELECTION_DIALOG_H__

#IFNDEF __GTK_COMBO_BOX_TEXT_H__
#DEFINE __GTK_COMBO_BOX_TEXT_H__

#DEFINE GTK_TYPE_COMBO_BOX_TEXT (gtk_combo_box_text_get_type ())
#DEFINE GTK_COMBO_BOX_TEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_COMBO_BOX_TEXT, GtkComboBoxText))
#DEFINE GTK_COMBO_BOX_TEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_COMBO_BOX_TEXT, GtkComboBoxTextClass))
#DEFINE GTK_IS_COMBO_BOX_TEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_COMBO_BOX_TEXT))
#DEFINE GTK_IS_COMBO_BOX_TEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_COMBO_BOX_TEXT))
#DEFINE GTK_COMBO_BOX_TEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_COMBO_BOX_TEXT, GtkComboBoxTextClass))

TYPE GtkComboBoxText AS _GtkComboBoxText
TYPE GtkComboBoxTextPrivate AS _GtkComboBoxTextPrivate
TYPE GtkComboBoxTextClass AS _GtkComboBoxTextClass

TYPE _GtkComboBoxText
  AS GtkComboBox parent_instance
  AS GtkComboBoxTextPrivate PTR priv
END TYPE

TYPE _GtkComboBoxTextClass
  AS GtkComboBoxClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_combo_box_text_get_type() AS GType
DECLARE FUNCTION gtk_combo_box_text_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_combo_box_text_new_with_entry() AS GtkWidget PTR
DECLARE SUB gtk_combo_box_text_append_text(BYVAL AS GtkComboBoxText PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_combo_box_text_insert_text(BYVAL AS GtkComboBoxText PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_combo_box_text_prepend_text(BYVAL AS GtkComboBoxText PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_combo_box_text_remove(BYVAL AS GtkComboBoxText PTR, BYVAL AS gint)
DECLARE SUB gtk_combo_box_text_remove_all(BYVAL AS GtkComboBoxText PTR)
DECLARE FUNCTION gtk_combo_box_text_get_active_text(BYVAL AS GtkComboBoxText PTR) AS gchar PTR
DECLARE SUB gtk_combo_box_text_insert(BYVAL AS GtkComboBoxText PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_combo_box_text_append(BYVAL AS GtkComboBoxText PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_combo_box_text_prepend(BYVAL AS GtkComboBoxText PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_COMBO_BOX_TEXT_H__

#IFNDEF __GTK_CSS_PROVIDER_H__
#DEFINE __GTK_CSS_PROVIDER_H__

#IFNDEF __GTK_CSS_SECTION_H__
#DEFINE __GTK_CSS_SECTION_H__

#DEFINE GTK_TYPE_CSS_SECTION (gtk_css_section_get_type ())

ENUM GtkCssSectionType
  GTK_CSS_SECTION_DOCUMENT
  GTK_CSS_SECTION_IMPORT
  GTK_CSS_SECTION_COLOR_DEFINITION
  GTK_CSS_SECTION_BINDING_SET
  GTK_CSS_SECTION_RULESET
  GTK_CSS_SECTION_SELECTOR
  GTK_CSS_SECTION_DECLARATION
  GTK_CSS_SECTION_VALUE
END ENUM

TYPE GtkCssSection AS _GtkCssSection

DECLARE FUNCTION gtk_css_section_get_type() AS GType
DECLARE FUNCTION gtk_css_section_ref(BYVAL AS GtkCssSection PTR) AS GtkCssSection PTR
DECLARE SUB gtk_css_section_unref(BYVAL AS GtkCssSection PTR)
DECLARE FUNCTION gtk_css_section_get_section_type(BYVAL AS CONST GtkCssSection PTR) AS GtkCssSectionType
DECLARE FUNCTION gtk_css_section_get_parent(BYVAL AS CONST GtkCssSection PTR) AS GtkCssSection PTR
DECLARE FUNCTION gtk_css_section_get_file(BYVAL AS CONST GtkCssSection PTR) AS GFile PTR
DECLARE FUNCTION gtk_css_section_get_start_line(BYVAL AS CONST GtkCssSection PTR) AS guint
DECLARE FUNCTION gtk_css_section_get_start_position(BYVAL AS CONST GtkCssSection PTR) AS guint
DECLARE FUNCTION gtk_css_section_get_end_line(BYVAL AS CONST GtkCssSection PTR) AS guint
DECLARE FUNCTION gtk_css_section_get_end_position(BYVAL AS CONST GtkCssSection PTR) AS guint

#ENDIF ' __GTK_CSS_SECTION_H__

#DEFINE GTK_TYPE_CSS_PROVIDER (gtk_css_provider_get_type ())
#DEFINE GTK_CSS_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_CSS_PROVIDER, GtkCssProvider))
#DEFINE GTK_CSS_PROVIDER_CLASS(c) (G_TYPE_CHECK_CLASS_CAST ((c), GTK_TYPE_CSS_PROVIDER, GtkCssProviderClass))
#DEFINE GTK_IS_CSS_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_CSS_PROVIDER))
#DEFINE GTK_IS_CSS_PROVIDER_CLASS(c) (G_TYPE_CHECK_CLASS_TYPE ((c), GTK_TYPE_CSS_PROVIDER))
#DEFINE GTK_CSS_PROVIDER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_CSS_PROVIDER, GtkCssProviderClass))
#DEFINE GTK_CSS_PROVIDER_ERROR (gtk_css_provider_error_quark ())

ENUM GtkCssProviderError
  GTK_CSS_PROVIDER_ERROR_FAILED
  GTK_CSS_PROVIDER_ERROR_SYNTAX
  GTK_CSS_PROVIDER_ERROR_IMPORT
  GTK_CSS_PROVIDER_ERROR_NAME
  GTK_CSS_PROVIDER_ERROR_DEPRECATED
  GTK_CSS_PROVIDER_ERROR_UNKNOWN_VALUE
END ENUM

DECLARE FUNCTION gtk_css_provider_error_quark() AS GQuark

TYPE GtkCssProvider AS _GtkCssProvider
TYPE GtkCssProviderClass AS _GtkCssProviderClass
TYPE GtkCssProviderPrivate AS _GtkCssProviderPrivate

TYPE _GtkCssProvider
  AS GObject parent_instance
  AS GtkCssProviderPrivate PTR priv
END TYPE

TYPE _GtkCssProviderClass
  AS GObjectClass parent_class
  parsing_error AS SUB(BYVAL AS GtkCssProvider PTR, BYVAL AS GtkCssSection PTR, BYVAL AS CONST GError PTR)
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_css_provider_get_type() AS GType
DECLARE FUNCTION gtk_css_provider_new() AS GtkCssProvider PTR
DECLARE FUNCTION gtk_css_provider_to_string(BYVAL AS GtkCssProvider PTR) AS ZSTRING PTR
DECLARE FUNCTION gtk_css_provider_load_from_data(BYVAL AS GtkCssProvider PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_css_provider_load_from_file(BYVAL AS GtkCssProvider PTR, BYVAL AS GFile PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_css_provider_load_from_path(BYVAL AS GtkCssProvider PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_css_provider_get_default() AS GtkCssProvider PTR
DECLARE FUNCTION gtk_css_provider_get_named(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GtkCssProvider PTR

#ENDIF ' __GTK_CSS_PROVIDER_H__

#IFNDEF __GTK_DEBUG_H__
#DEFINE __GTK_DEBUG_H__

ENUM GtkDebugFlag
  GTK_DEBUG_MISC = 1 SHL 0
  GTK_DEBUG_PLUGSOCKET = 1 SHL 1
  GTK_DEBUG_TEXT = 1 SHL 2
  GTK_DEBUG_TREE = 1 SHL 3
  GTK_DEBUG_UPDATES = 1 SHL 4
  GTK_DEBUG_KEYBINDINGS = 1 SHL 5
  GTK_DEBUG_MULTIHEAD = 1 SHL 6
  GTK_DEBUG_MODULES = 1 SHL 7
  GTK_DEBUG_GEOMETRY = 1 SHL 8
  GTK_DEBUG_ICONTHEME = 1 SHL 9
  GTK_DEBUG_PRINTING = 1 SHL 10
  GTK_DEBUG_BUILDER = 1 SHL 11
  GTK_DEBUG_SIZE_REQUEST = 1 SHL 12
END ENUM

#IFDEF G_ENABLE_DEBUG

#DEFINE GTK_NOTE(type,action) _
    IF (gtk_get_debug_flags () AND GTK_DEBUG_##type) THEN action

#ELSE ' G_ENABLE_DEBUG
#DEFINE GTK_NOTE(type, action)
#ENDIF ' G_ENABLE_DEBUG

DECLARE FUNCTION gtk_get_debug_flags() AS guint
DECLARE SUB gtk_set_debug_flags(BYVAL AS guint)

#ENDIF ' __GTK_DEBUG_H__

#IFNDEF __GTK_DRAWING_AREA_H__
#DEFINE __GTK_DRAWING_AREA_H__

#DEFINE GTK_TYPE_DRAWING_AREA (gtk_drawing_area_get_type ())
#DEFINE GTK_DRAWING_AREA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingArea))
#DEFINE GTK_DRAWING_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass))
#DEFINE GTK_IS_DRAWING_AREA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_DRAWING_AREA))
#DEFINE GTK_IS_DRAWING_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_DRAWING_AREA))
#DEFINE GTK_DRAWING_AREA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass))

TYPE GtkDrawingArea AS _GtkDrawingArea
TYPE GtkDrawingAreaClass AS _GtkDrawingAreaClass

TYPE _GtkDrawingArea
  AS GtkWidget widget
  AS gpointer dummy
END TYPE

TYPE _GtkDrawingAreaClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_drawing_area_get_type() AS GType
DECLARE FUNCTION gtk_drawing_area_new() AS GtkWidget PTR

#ENDIF ' __GTK_DRAWING_AREA_H__

#IFNDEF __GTK_EVENT_BOX_H__
#DEFINE __GTK_EVENT_BOX_H__

#DEFINE GTK_TYPE_EVENT_BOX (gtk_event_box_get_type ())
#DEFINE GTK_EVENT_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EVENT_BOX, GtkEventBox))
#DEFINE GTK_EVENT_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_EVENT_BOX, GtkEventBoxClass))
#DEFINE GTK_IS_EVENT_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EVENT_BOX))
#DEFINE GTK_IS_EVENT_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_EVENT_BOX))
#DEFINE GTK_EVENT_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_EVENT_BOX, GtkEventBoxClass))

TYPE GtkEventBox AS _GtkEventBox
TYPE GtkEventBoxClass AS _GtkEventBoxClass
TYPE GtkEventBoxPrivate AS _GtkEventBoxPrivate

TYPE _GtkEventBox
  AS GtkBin bin
  AS GtkEventBoxPrivate PTR priv
END TYPE

TYPE _GtkEventBoxClass
  AS GtkBinClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_event_box_get_type() AS GType
DECLARE FUNCTION gtk_event_box_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_event_box_get_visible_window(BYVAL AS GtkEventBox PTR) AS gboolean
DECLARE SUB gtk_event_box_set_visible_window(BYVAL AS GtkEventBox PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_event_box_get_above_child(BYVAL AS GtkEventBox PTR) AS gboolean
DECLARE SUB gtk_event_box_set_above_child(BYVAL AS GtkEventBox PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_EVENT_BOX_H__

#IFNDEF __GTK_EXPANDER_H__
#DEFINE __GTK_EXPANDER_H__

#DEFINE GTK_TYPE_EXPANDER (gtk_expander_get_type ())
#DEFINE GTK_EXPANDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EXPANDER, GtkExpander))
#DEFINE GTK_EXPANDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_EXPANDER, GtkExpanderClass))
#DEFINE GTK_IS_EXPANDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EXPANDER))
#DEFINE GTK_IS_EXPANDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_EXPANDER))
#DEFINE GTK_EXPANDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_EXPANDER, GtkExpanderClass))

TYPE GtkExpander AS _GtkExpander
TYPE GtkExpanderClass AS _GtkExpanderClass
TYPE GtkExpanderPrivate AS _GtkExpanderPrivate

TYPE _GtkExpander
  AS GtkBin bin
  AS GtkExpanderPrivate PTR priv
END TYPE

TYPE _GtkExpanderClass
  AS GtkBinClass parent_class
  activate AS SUB(BYVAL AS GtkExpander PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_expander_get_type() AS GType
DECLARE FUNCTION gtk_expander_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_expander_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_expander_set_expanded(BYVAL AS GtkExpander PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_expander_get_expanded(BYVAL AS GtkExpander PTR) AS gboolean
DECLARE SUB gtk_expander_set_spacing(BYVAL AS GtkExpander PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_expander_get_spacing(BYVAL AS GtkExpander PTR) AS gint
DECLARE SUB gtk_expander_set_label(BYVAL AS GtkExpander PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_expander_get_label(BYVAL AS GtkExpander PTR) AS CONST gchar PTR
DECLARE SUB gtk_expander_set_use_underline(BYVAL AS GtkExpander PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_expander_get_use_underline(BYVAL AS GtkExpander PTR) AS gboolean
DECLARE SUB gtk_expander_set_use_markup(BYVAL AS GtkExpander PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_expander_get_use_markup(BYVAL AS GtkExpander PTR) AS gboolean
DECLARE SUB gtk_expander_set_label_widget(BYVAL AS GtkExpander PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_expander_get_label_widget(BYVAL AS GtkExpander PTR) AS GtkWidget PTR
DECLARE SUB gtk_expander_set_label_fill(BYVAL AS GtkExpander PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_expander_get_label_fill(BYVAL AS GtkExpander PTR) AS gboolean
DECLARE SUB gtk_expander_set_resize_toplevel(BYVAL AS GtkExpander PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_expander_get_resize_toplevel(BYVAL AS GtkExpander PTR) AS gboolean

#ENDIF ' __GTK_EXPANDER_H__

#IFNDEF __GTK_FIXED_H__
#DEFINE __GTK_FIXED_H__

#DEFINE GTK_TYPE_FIXED (gtk_fixed_get_type ())
#DEFINE GTK_FIXED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FIXED, GtkFixed))
#DEFINE GTK_FIXED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FIXED, GtkFixedClass))
#DEFINE GTK_IS_FIXED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FIXED))
#DEFINE GTK_IS_FIXED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FIXED))
#DEFINE GTK_FIXED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FIXED, GtkFixedClass))

TYPE GtkFixed AS _GtkFixed
TYPE GtkFixedPrivate AS _GtkFixedPrivate
TYPE GtkFixedClass AS _GtkFixedClass
TYPE GtkFixedChild AS _GtkFixedChild

TYPE _GtkFixed
  AS GtkContainer container
  AS GtkFixedPrivate PTR priv
END TYPE

TYPE _GtkFixedClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE _GtkFixedChild
  AS GtkWidget PTR widget
  AS gint x
  AS gint y
END TYPE

DECLARE FUNCTION gtk_fixed_get_type() AS GType
DECLARE FUNCTION gtk_fixed_new() AS GtkWidget PTR
DECLARE SUB gtk_fixed_put(BYVAL AS GtkFixed PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_fixed_move(BYVAL AS GtkFixed PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)

#ENDIF ' __GTK_FIXED_H__

#IFNDEF __GTK_FILE_CHOOSER_H__
#DEFINE __GTK_FILE_CHOOSER_H__

#IFNDEF __GTK_FILE_FILTER_H__
#DEFINE __GTK_FILE_FILTER_H__

#DEFINE GTK_TYPE_FILE_FILTER (gtk_file_filter_get_type ())
#DEFINE GTK_FILE_FILTER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_FILTER, GtkFileFilter))
#DEFINE GTK_IS_FILE_FILTER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_FILTER))

TYPE GtkFileFilter AS _GtkFileFilter
TYPE GtkFileFilterInfo AS _GtkFileFilterInfo

ENUM GtkFileFilterFlags
  GTK_FILE_FILTER_FILENAME = 1 SHL 0
  GTK_FILE_FILTER_URI = 1 SHL 1
  GTK_FILE_FILTER_DISPLAY_NAME = 1 SHL 2
  GTK_FILE_FILTER_MIME_TYPE = 1 SHL 3
END ENUM

TYPE GtkFileFilterFunc AS FUNCTION(BYVAL AS CONST GtkFileFilterInfo PTR, BYVAL AS gpointer) AS gboolean

TYPE _GtkFileFilterInfo
  AS GtkFileFilterFlags contains
  AS CONST gchar PTR filename
  AS CONST gchar PTR uri
  AS CONST gchar PTR display_name
  AS CONST gchar PTR mime_type
END TYPE

DECLARE FUNCTION gtk_file_filter_get_type() AS GType
DECLARE FUNCTION gtk_file_filter_new() AS GtkFileFilter PTR
DECLARE SUB gtk_file_filter_set_name(BYVAL AS GtkFileFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_file_filter_get_name(BYVAL AS GtkFileFilter PTR) AS CONST gchar PTR
DECLARE SUB gtk_file_filter_add_mime_type(BYVAL AS GtkFileFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_file_filter_add_pattern(BYVAL AS GtkFileFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_file_filter_add_pixbuf_formats(BYVAL AS GtkFileFilter PTR)
DECLARE SUB gtk_file_filter_add_custom(BYVAL AS GtkFileFilter PTR, BYVAL AS GtkFileFilterFlags, BYVAL AS GtkFileFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_file_filter_get_needed(BYVAL AS GtkFileFilter PTR) AS GtkFileFilterFlags
DECLARE FUNCTION gtk_file_filter_filter(BYVAL AS GtkFileFilter PTR, BYVAL AS CONST GtkFileFilterInfo PTR) AS gboolean

#ENDIF ' __GTK_FILE_FILTER_H__

#DEFINE GTK_TYPE_FILE_CHOOSER (gtk_file_chooser_get_type ())
#DEFINE GTK_FILE_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_CHOOSER, GtkFileChooser))
#DEFINE GTK_IS_FILE_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_CHOOSER))

TYPE GtkFileChooser AS _GtkFileChooser

ENUM GtkFileChooserAction
  GTK_FILE_CHOOSER_ACTION_OPEN
  GTK_FILE_CHOOSER_ACTION_SAVE
  GTK_FILE_CHOOSER_ACTION_SELECT_FOLDER
  GTK_FILE_CHOOSER_ACTION_CREATE_FOLDER
END ENUM

ENUM GtkFileChooserConfirmation
  GTK_FILE_CHOOSER_CONFIRMATION_CONFIRM
  GTK_FILE_CHOOSER_CONFIRMATION_ACCEPT_FILENAME
  GTK_FILE_CHOOSER_CONFIRMATION_SELECT_AGAIN
END ENUM

DECLARE FUNCTION gtk_file_chooser_get_type() AS GType

#DEFINE GTK_FILE_CHOOSER_ERROR (gtk_file_chooser_error_quark ())

ENUM GtkFileChooserError
  GTK_FILE_CHOOSER_ERROR_NONEXISTENT
  GTK_FILE_CHOOSER_ERROR_BAD_FILENAME
  GTK_FILE_CHOOSER_ERROR_ALREADY_EXISTS
  GTK_FILE_CHOOSER_ERROR_INCOMPLETE_HOSTNAME
END ENUM

DECLARE FUNCTION gtk_file_chooser_error_quark() AS GQuark
DECLARE SUB gtk_file_chooser_set_action(BYVAL AS GtkFileChooser PTR, BYVAL AS GtkFileChooserAction)
DECLARE FUNCTION gtk_file_chooser_get_action(BYVAL AS GtkFileChooser PTR) AS GtkFileChooserAction
DECLARE SUB gtk_file_chooser_set_local_only(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_local_only(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE SUB gtk_file_chooser_set_select_multiple(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_select_multiple(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE SUB gtk_file_chooser_set_show_hidden(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_show_hidden(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE SUB gtk_file_chooser_set_do_overwrite_confirmation(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_do_overwrite_confirmation(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE SUB gtk_file_chooser_set_create_folders(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_create_folders(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE SUB gtk_file_chooser_set_current_name(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_file_chooser_get_filename(BYVAL AS GtkFileChooser PTR) AS gchar PTR
DECLARE FUNCTION gtk_file_chooser_set_filename(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_select_filename(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE SUB gtk_file_chooser_unselect_filename(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE SUB gtk_file_chooser_select_all(BYVAL AS GtkFileChooser PTR)
DECLARE SUB gtk_file_chooser_unselect_all(BYVAL AS GtkFileChooser PTR)
DECLARE FUNCTION gtk_file_chooser_get_filenames(BYVAL AS GtkFileChooser PTR) AS GSList PTR
DECLARE FUNCTION gtk_file_chooser_set_current_folder(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_get_current_folder(BYVAL AS GtkFileChooser PTR) AS gchar PTR
DECLARE FUNCTION gtk_file_chooser_get_uri(BYVAL AS GtkFileChooser PTR) AS gchar PTR
DECLARE FUNCTION gtk_file_chooser_set_uri(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_select_uri(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR) AS gboolean
DECLARE SUB gtk_file_chooser_unselect_uri(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR)
DECLARE FUNCTION gtk_file_chooser_get_uris(BYVAL AS GtkFileChooser PTR) AS GSList PTR
DECLARE FUNCTION gtk_file_chooser_set_current_folder_uri(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_get_current_folder_uri(BYVAL AS GtkFileChooser PTR) AS gchar PTR
DECLARE FUNCTION gtk_file_chooser_get_file(BYVAL AS GtkFileChooser PTR) AS GFile PTR
DECLARE FUNCTION gtk_file_chooser_set_file(BYVAL AS GtkFileChooser PTR, BYVAL AS GFile PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_select_file(BYVAL AS GtkFileChooser PTR, BYVAL AS GFile PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB gtk_file_chooser_unselect_file(BYVAL AS GtkFileChooser PTR, BYVAL AS GFile PTR)
DECLARE FUNCTION gtk_file_chooser_get_files(BYVAL AS GtkFileChooser PTR) AS GSList PTR
DECLARE FUNCTION gtk_file_chooser_set_current_folder_file(BYVAL AS GtkFileChooser PTR, BYVAL AS GFile PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_get_current_folder_file(BYVAL AS GtkFileChooser PTR) AS GFile PTR
DECLARE SUB gtk_file_chooser_set_preview_widget(BYVAL AS GtkFileChooser PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_file_chooser_get_preview_widget(BYVAL AS GtkFileChooser PTR) AS GtkWidget PTR
DECLARE SUB gtk_file_chooser_set_preview_widget_active(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_preview_widget_active(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE SUB gtk_file_chooser_set_use_preview_label(BYVAL AS GtkFileChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_file_chooser_get_use_preview_label(BYVAL AS GtkFileChooser PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_get_preview_filename(BYVAL AS GtkFileChooser PTR) AS ZSTRING PTR
DECLARE FUNCTION gtk_file_chooser_get_preview_uri(BYVAL AS GtkFileChooser PTR) AS ZSTRING PTR
DECLARE FUNCTION gtk_file_chooser_get_preview_file(BYVAL AS GtkFileChooser PTR) AS GFile PTR
DECLARE SUB gtk_file_chooser_set_extra_widget(BYVAL AS GtkFileChooser PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_file_chooser_get_extra_widget(BYVAL AS GtkFileChooser PTR) AS GtkWidget PTR
DECLARE SUB gtk_file_chooser_add_filter(BYVAL AS GtkFileChooser PTR, BYVAL AS GtkFileFilter PTR)
DECLARE SUB gtk_file_chooser_remove_filter(BYVAL AS GtkFileChooser PTR, BYVAL AS GtkFileFilter PTR)
DECLARE FUNCTION gtk_file_chooser_list_filters(BYVAL AS GtkFileChooser PTR) AS GSList PTR
DECLARE SUB gtk_file_chooser_set_filter(BYVAL AS GtkFileChooser PTR, BYVAL AS GtkFileFilter PTR)
DECLARE FUNCTION gtk_file_chooser_get_filter(BYVAL AS GtkFileChooser PTR) AS GtkFileFilter PTR
DECLARE FUNCTION gtk_file_chooser_add_shortcut_folder(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_remove_shortcut_folder(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_list_shortcut_folders(BYVAL AS GtkFileChooser PTR) AS GSList PTR
DECLARE FUNCTION gtk_file_chooser_add_shortcut_folder_uri(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_remove_shortcut_folder_uri(BYVAL AS GtkFileChooser PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_file_chooser_list_shortcut_folder_uris(BYVAL AS GtkFileChooser PTR) AS GSList PTR

#ENDIF ' __GTK_FILE_CHOOSER_H__

#IFNDEF __GTK_FILE_CHOOSER_BUTTON_H__
#DEFINE __GTK_FILE_CHOOSER_BUTTON_H__

#DEFINE GTK_TYPE_FILE_CHOOSER_BUTTON (gtk_file_chooser_button_get_type ())
#DEFINE GTK_FILE_CHOOSER_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButton))
#DEFINE GTK_FILE_CHOOSER_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButtonClass))
#DEFINE GTK_IS_FILE_CHOOSER_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_CHOOSER_BUTTON))
#DEFINE GTK_IS_FILE_CHOOSER_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_CHOOSER_BUTTON))
#DEFINE GTK_FILE_CHOOSER_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FILE_CHOOSER_BUTTON, GtkFileChooserButtonClass))

TYPE GtkFileChooserButton AS _GtkFileChooserButton
TYPE GtkFileChooserButtonPrivate AS _GtkFileChooserButtonPrivate
TYPE GtkFileChooserButtonClass AS _GtkFileChooserButtonClass

TYPE _GtkFileChooserButton
  AS GtkBox parent
  AS GtkFileChooserButtonPrivate PTR priv
END TYPE

TYPE _GtkFileChooserButtonClass
  AS GtkBoxClass parent_class
  file_set AS SUB(BYVAL AS GtkFileChooserButton PTR)
  __gtk_reserved1 AS SUB()
  __gtk_reserved2 AS SUB()
  __gtk_reserved3 AS SUB()
  __gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_file_chooser_button_get_type() AS GType
DECLARE FUNCTION gtk_file_chooser_button_new(BYVAL AS CONST gchar PTR, BYVAL AS GtkFileChooserAction) AS GtkWidget PTR
DECLARE FUNCTION gtk_file_chooser_button_new_with_dialog(BYVAL AS GtkWidget PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_file_chooser_button_get_title(BYVAL AS GtkFileChooserButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_file_chooser_button_set_title(BYVAL AS GtkFileChooserButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_file_chooser_button_get_width_chars(BYVAL AS GtkFileChooserButton PTR) AS gint
DECLARE SUB gtk_file_chooser_button_set_width_chars(BYVAL AS GtkFileChooserButton PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_file_chooser_button_get_focus_on_click(BYVAL AS GtkFileChooserButton PTR) AS gboolean
DECLARE SUB gtk_file_chooser_button_set_focus_on_click(BYVAL AS GtkFileChooserButton PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_FILE_CHOOSER_BUTTON_H__

#IFNDEF __GTK_FILE_CHOOSER_DIALOG_H__
#DEFINE __GTK_FILE_CHOOSER_DIALOG_H__

#DEFINE GTK_TYPE_FILE_CHOOSER_DIALOG (gtk_file_chooser_dialog_get_type ())
#DEFINE GTK_FILE_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialog))
#DEFINE GTK_FILE_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialogClass))
#DEFINE GTK_IS_FILE_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_CHOOSER_DIALOG))
#DEFINE GTK_IS_FILE_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_CHOOSER_DIALOG))
#DEFINE GTK_FILE_CHOOSER_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FILE_CHOOSER_DIALOG, GtkFileChooserDialogClass))

TYPE GtkFileChooserDialog AS _GtkFileChooserDialog
TYPE GtkFileChooserDialogPrivate AS _GtkFileChooserDialogPrivate
TYPE GtkFileChooserDialogClass AS _GtkFileChooserDialogClass

TYPE _GtkFileChooserDialog
  AS GtkDialog parent_instance
  AS GtkFileChooserDialogPrivate PTR priv
END TYPE

TYPE _GtkFileChooserDialogClass
  AS GtkDialogClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_file_chooser_dialog_get_type() AS GType
DECLARE FUNCTION gtk_file_chooser_dialog_new(BYVAL AS CONST gchar PTR, BYVAL AS GtkWindow PTR, BYVAL AS GtkFileChooserAction, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR

#ENDIF ' __GTK_FILE_CHOOSER_DIALOG_H__

#IFNDEF __GTK_FILE_CHOOSER_WIDGET_H__
#DEFINE __GTK_FILE_CHOOSER_WIDGET_H__

#DEFINE GTK_TYPE_FILE_CHOOSER_WIDGET (gtk_file_chooser_widget_get_type ())
#DEFINE GTK_FILE_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidget))
#DEFINE GTK_FILE_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidgetClass))
#DEFINE GTK_IS_FILE_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_CHOOSER_WIDGET))
#DEFINE GTK_IS_FILE_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FILE_CHOOSER_WIDGET))
#DEFINE GTK_FILE_CHOOSER_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FILE_CHOOSER_WIDGET, GtkFileChooserWidgetClass))

TYPE GtkFileChooserWidget AS _GtkFileChooserWidget
TYPE GtkFileChooserWidgetPrivate AS _GtkFileChooserWidgetPrivate
TYPE GtkFileChooserWidgetClass AS _GtkFileChooserWidgetClass

TYPE _GtkFileChooserWidget
  AS GtkBox parent_instance
  AS GtkFileChooserWidgetPrivate PTR priv
END TYPE

TYPE _GtkFileChooserWidgetClass
  AS GtkBoxClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_file_chooser_widget_get_type() AS GType
DECLARE FUNCTION gtk_file_chooser_widget_new(BYVAL AS GtkFileChooserAction) AS GtkWidget PTR

#ENDIF ' __GTK_FILE_CHOOSER_WIDGET_H__

#IFNDEF __GTK_FONT_BUTTON_H__
#DEFINE __GTK_FONT_BUTTON_H__

#DEFINE GTK_TYPE_FONT_BUTTON (gtk_font_button_get_type ())
#DEFINE GTK_FONT_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_BUTTON, GtkFontButton))
#DEFINE GTK_FONT_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_BUTTON, GtkFontButtonClass))
#DEFINE GTK_IS_FONT_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_BUTTON))
#DEFINE GTK_IS_FONT_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_BUTTON))
#DEFINE GTK_FONT_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_BUTTON, GtkFontButtonClass))

TYPE GtkFontButton AS _GtkFontButton
TYPE GtkFontButtonClass AS _GtkFontButtonClass
TYPE GtkFontButtonPrivate AS _GtkFontButtonPrivate

TYPE _GtkFontButton
  AS GtkButton button
  AS GtkFontButtonPrivate PTR priv
END TYPE

TYPE _GtkFontButtonClass
  AS GtkButtonClass parent_class
  font_set AS SUB(BYVAL AS GtkFontButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_font_button_get_type() AS GType
DECLARE FUNCTION gtk_font_button_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_font_button_new_with_font(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_button_get_title(BYVAL AS GtkFontButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_font_button_set_title(BYVAL AS GtkFontButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_font_button_get_use_font(BYVAL AS GtkFontButton PTR) AS gboolean
DECLARE SUB gtk_font_button_set_use_font(BYVAL AS GtkFontButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_font_button_get_use_size(BYVAL AS GtkFontButton PTR) AS gboolean
DECLARE SUB gtk_font_button_set_use_size(BYVAL AS GtkFontButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_font_button_get_font_name(BYVAL AS GtkFontButton PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_font_button_set_font_name(BYVAL AS GtkFontButton PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_font_button_get_show_style(BYVAL AS GtkFontButton PTR) AS gboolean
DECLARE SUB gtk_font_button_set_show_style(BYVAL AS GtkFontButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_font_button_get_show_size(BYVAL AS GtkFontButton PTR) AS gboolean
DECLARE SUB gtk_font_button_set_show_size(BYVAL AS GtkFontButton PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_FONT_BUTTON_H__

#IFNDEF __GTK_FONTSEL_H__
#DEFINE __GTK_FONTSEL_H__

#IFNDEF GTK_DISABLE_DEPRECATED
#DEFINE GTK_TYPE_FONT_SELECTION (gtk_font_selection_get_type ())
#DEFINE GTK_FONT_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_SELECTION, GtkFontSelection))
#DEFINE GTK_FONT_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_SELECTION, GtkFontSelectionClass))
#DEFINE GTK_IS_FONT_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_SELECTION))
#DEFINE GTK_IS_FONT_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_SELECTION))
#DEFINE GTK_FONT_SELECTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_SELECTION, GtkFontSelectionClass))
#DEFINE GTK_TYPE_FONT_SELECTION_DIALOG (gtk_font_selection_dialog_get_type ())
#DEFINE GTK_FONT_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialog))
#DEFINE GTK_FONT_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialogClass))
#DEFINE GTK_IS_FONT_SELECTION_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_SELECTION_DIALOG))
#DEFINE GTK_IS_FONT_SELECTION_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_SELECTION_DIALOG))
#DEFINE GTK_FONT_SELECTION_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_SELECTION_DIALOG, GtkFontSelectionDialogClass))

TYPE GtkFontSelection AS _GtkFontSelection
TYPE GtkFontSelectionPrivate AS _GtkFontSelectionPrivate
TYPE GtkFontSelectionClass AS _GtkFontSelectionClass
TYPE GtkFontSelectionDialog AS _GtkFontSelectionDialog
TYPE GtkFontSelectionDialogPrivate AS _GtkFontSelectionDialogPrivate
TYPE GtkFontSelectionDialogClass AS _GtkFontSelectionDialogClass

TYPE _GtkFontSelection
  AS GtkBox parent_instance
  AS GtkFontSelectionPrivate PTR priv
END TYPE

TYPE _GtkFontSelectionClass
  AS GtkBoxClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE _GtkFontSelectionDialog
  AS GtkDialog parent_instance
  AS GtkFontSelectionDialogPrivate PTR priv
END TYPE

TYPE _GtkFontSelectionDialogClass
  AS GtkDialogClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_font_selection_get_type() AS GType
DECLARE FUNCTION gtk_font_selection_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_get_family_list(BYVAL AS GtkFontSelection PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_get_face_list(BYVAL AS GtkFontSelection PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_get_size_entry(BYVAL AS GtkFontSelection PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_get_size_list(BYVAL AS GtkFontSelection PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_get_preview_entry(BYVAL AS GtkFontSelection PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_get_family(BYVAL AS GtkFontSelection PTR) AS PangoFontFamily PTR
DECLARE FUNCTION gtk_font_selection_get_face(BYVAL AS GtkFontSelection PTR) AS PangoFontFace PTR
DECLARE FUNCTION gtk_font_selection_get_size(BYVAL AS GtkFontSelection PTR) AS gint
DECLARE FUNCTION gtk_font_selection_get_font_name(BYVAL AS GtkFontSelection PTR) AS gchar PTR
DECLARE FUNCTION gtk_font_selection_set_font_name(BYVAL AS GtkFontSelection PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_font_selection_get_preview_text(BYVAL AS GtkFontSelection PTR) AS CONST gchar PTR
DECLARE SUB gtk_font_selection_set_preview_text(BYVAL AS GtkFontSelection PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_font_selection_dialog_get_type() AS GType
DECLARE FUNCTION gtk_font_selection_dialog_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_dialog_get_ok_button(BYVAL AS GtkFontSelectionDialog PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_dialog_get_cancel_button(BYVAL AS GtkFontSelectionDialog PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_dialog_get_font_selection(BYVAL AS GtkFontSelectionDialog PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_font_selection_dialog_get_font_name(BYVAL AS GtkFontSelectionDialog PTR) AS gchar PTR
DECLARE FUNCTION gtk_font_selection_dialog_set_font_name(BYVAL AS GtkFontSelectionDialog PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_font_selection_dialog_get_preview_text(BYVAL AS GtkFontSelectionDialog PTR) AS CONST gchar PTR
DECLARE SUB gtk_font_selection_dialog_set_preview_text(BYVAL AS GtkFontSelectionDialog PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_FONTSEL_H__

#IFNDEF __GTK_FONT_CHOOSER_H__
#DEFINE __GTK_FONT_CHOOSER_H__

TYPE GtkFontFilterFunc AS FUNCTION(BYVAL AS CONST PangoFontFamily PTR, BYVAL AS CONST PangoFontFace PTR, BYVAL AS gpointer) AS gboolean

#DEFINE GTK_TYPE_FONT_CHOOSER (gtk_font_chooser_get_type ())
#DEFINE GTK_FONT_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_CHOOSER, GtkFontChooser))
#DEFINE GTK_IS_FONT_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_CHOOSER))
#DEFINE GTK_FONT_CHOOSER_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_FONT_CHOOSER, GtkFontChooserIface))

TYPE GtkFontChooser AS _GtkFontChooser
TYPE GtkFontChooserIface AS _GtkFontChooserIface

TYPE _GtkFontChooserIface
  AS GTypeInterface base_iface
  get_font_family AS FUNCTION(BYVAL AS GtkFontChooser PTR) AS PangoFontFamily PTR
  get_font_face AS FUNCTION(BYVAL AS GtkFontChooser PTR) AS PangoFontFace PTR
  get_font_size AS FUNCTION(BYVAL AS GtkFontChooser PTR) AS gint
  set_filter_func AS SUB(BYVAL AS GtkFontChooser PTR, BYVAL AS GtkFontFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
  font_activated AS SUB(BYVAL AS GtkFontChooser PTR, BYVAL AS CONST gchar PTR)
  AS gpointer padding(11)
END TYPE

DECLARE FUNCTION gtk_font_chooser_get_type() AS GType
DECLARE FUNCTION gtk_font_chooser_get_font_family(BYVAL AS GtkFontChooser PTR) AS PangoFontFamily PTR
DECLARE FUNCTION gtk_font_chooser_get_font_face(BYVAL AS GtkFontChooser PTR) AS PangoFontFace PTR
DECLARE FUNCTION gtk_font_chooser_get_font_size(BYVAL AS GtkFontChooser PTR) AS gint
DECLARE FUNCTION gtk_font_chooser_get_font_desc(BYVAL AS GtkFontChooser PTR) AS PangoFontDescription PTR
DECLARE SUB gtk_font_chooser_set_font_desc(BYVAL AS GtkFontChooser PTR, BYVAL AS CONST PangoFontDescription PTR)
DECLARE FUNCTION gtk_font_chooser_get_font(BYVAL AS GtkFontChooser PTR) AS gchar PTR
DECLARE SUB gtk_font_chooser_set_font(BYVAL AS GtkFontChooser PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_font_chooser_get_preview_text(BYVAL AS GtkFontChooser PTR) AS gchar PTR
DECLARE SUB gtk_font_chooser_set_preview_text(BYVAL AS GtkFontChooser PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_font_chooser_get_show_preview_entry(BYVAL AS GtkFontChooser PTR) AS gboolean
DECLARE SUB gtk_font_chooser_set_show_preview_entry(BYVAL AS GtkFontChooser PTR, BYVAL AS gboolean)
DECLARE SUB gtk_font_chooser_set_filter_func(BYVAL AS GtkFontChooser PTR, BYVAL AS GtkFontFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)

#ENDIF ' __GTK_FONT_CHOOSER_H__

#IFNDEF __GTK_FONT_CHOOSER_DIALOG_H__
#DEFINE __GTK_FONT_CHOOSER_DIALOG_H__

#DEFINE GTK_TYPE_FONT_CHOOSER_DIALOG (gtk_font_chooser_dialog_get_type ())
#DEFINE GTK_FONT_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_CHOOSER_DIALOG, GtkFontChooserDialog))
#DEFINE GTK_FONT_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_CHOOSER_DIALOG, GtkFontChooserDialogClass))
#DEFINE GTK_IS_FONT_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_CHOOSER_DIALOG))
#DEFINE GTK_IS_FONT_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_CHOOSER_DIALOG))
#DEFINE GTK_FONT_CHOOSER_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_CHOOSER_DIALOG, GtkFontChooserDialogClass))

TYPE GtkFontChooserDialog AS _GtkFontChooserDialog
TYPE GtkFontChooserDialogPrivate AS _GtkFontChooserDialogPrivate
TYPE GtkFontChooserDialogClass AS _GtkFontChooserDialogClass

TYPE _GtkFontChooserDialog
  AS GtkDialog parent_instance
  AS GtkFontChooserDialogPrivate PTR priv
END TYPE

TYPE _GtkFontChooserDialogClass
  AS GtkDialogClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_font_chooser_dialog_get_type() AS GType
DECLARE FUNCTION gtk_font_chooser_dialog_new(BYVAL AS CONST gchar PTR, BYVAL AS GtkWindow PTR) AS GtkWidget PTR

#ENDIF ' __GTK_FONT_CHOOSER_DIALOG_H__
#IFNDEF __GTK_FONT_CHOOSER_WIDGET_H__
#DEFINE __GTK_FONT_CHOOSER_WIDGET_H__

#DEFINE GTK_TYPE_FONT_CHOOSER_WIDGET (gtk_font_chooser_widget_get_type ())
#DEFINE GTK_FONT_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FONT_CHOOSER_WIDGET, GtkFontChooserWidget))
#DEFINE GTK_FONT_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FONT_CHOOSER_WIDGET, GtkFontChooserWidgetClass))
#DEFINE GTK_IS_FONT_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FONT_CHOOSER_WIDGET))
#DEFINE GTK_IS_FONT_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FONT_CHOOSER_WIDGET))
#DEFINE GTK_FONT_CHOOSER_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FONT_CHOOSER_WIDGET, GtkFontChooserWidgetClass))

TYPE GtkFontChooserWidget AS _GtkFontChooserWidget
TYPE GtkFontChooserWidgetPrivate AS _GtkFontChooserWidgetPrivate
TYPE GtkFontChooserWidgetClass AS _GtkFontChooserWidgetClass

TYPE _GtkFontChooserWidget
  AS GtkBox parent_instance
  AS GtkFontChooserWidgetPrivate PTR priv
END TYPE

TYPE _GtkFontChooserWidgetClass
  AS GtkBoxClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_font_chooser_widget_get_type() AS GType
DECLARE FUNCTION gtk_font_chooser_widget_new() AS GtkWidget PTR

#ENDIF ' __GTK_FONT_CHOOSER_WIDGET_H__

#IFNDEF __GTK_GRADIENT_H__
#DEFINE __GTK_GRADIENT_H__

#IFNDEF __GTK_SYMBOLIC_COLOR_H__
#DEFINE __GTK_SYMBOLIC_COLOR_H__

#DEFINE GTK_TYPE_SYMBOLIC_COLOR (gtk_symbolic_color_get_type ())

DECLARE FUNCTION gtk_symbolic_color_get_type() AS GType
DECLARE FUNCTION gtk_symbolic_color_new_literal(BYVAL AS CONST GdkRGBA PTR) AS GtkSymbolicColor PTR
DECLARE FUNCTION gtk_symbolic_color_new_name(BYVAL AS CONST gchar PTR) AS GtkSymbolicColor PTR
DECLARE FUNCTION gtk_symbolic_color_new_shade(BYVAL AS GtkSymbolicColor PTR, BYVAL AS gdouble) AS GtkSymbolicColor PTR
DECLARE FUNCTION gtk_symbolic_color_new_alpha(BYVAL AS GtkSymbolicColor PTR, BYVAL AS gdouble) AS GtkSymbolicColor PTR
DECLARE FUNCTION gtk_symbolic_color_new_mix(BYVAL AS GtkSymbolicColor PTR, BYVAL AS GtkSymbolicColor PTR, BYVAL AS gdouble) AS GtkSymbolicColor PTR
DECLARE FUNCTION gtk_symbolic_color_ref(BYVAL AS GtkSymbolicColor PTR) AS GtkSymbolicColor PTR
DECLARE SUB gtk_symbolic_color_unref(BYVAL AS GtkSymbolicColor PTR)
DECLARE FUNCTION gtk_symbolic_color_to_string(BYVAL AS GtkSymbolicColor PTR) AS ZSTRING PTR
DECLARE FUNCTION gtk_symbolic_color_resolve(BYVAL AS GtkSymbolicColor PTR, BYVAL AS GtkStyleProperties PTR, BYVAL AS GdkRGBA PTR) AS gboolean

#ENDIF ' __GTK_SYMBOLIC_COLOR_H__

#DEFINE GTK_TYPE_GRADIENT (gtk_gradient_get_type ())

DECLARE FUNCTION gtk_gradient_get_type() AS GType
DECLARE FUNCTION gtk_gradient_new_linear(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkGradient PTR
DECLARE FUNCTION gtk_gradient_new_radial(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkGradient PTR
DECLARE SUB gtk_gradient_add_color_stop(BYVAL AS GtkGradient PTR, BYVAL AS gdouble, BYVAL AS GtkSymbolicColor PTR)
DECLARE FUNCTION gtk_gradient_ref(BYVAL AS GtkGradient PTR) AS GtkGradient PTR
DECLARE SUB gtk_gradient_unref(BYVAL AS GtkGradient PTR)
DECLARE FUNCTION gtk_gradient_resolve(BYVAL AS GtkGradient PTR, BYVAL AS GtkStyleProperties PTR, BYVAL AS cairo_pattern_t PTR PTR) AS gboolean
DECLARE FUNCTION gtk_gradient_to_string(BYVAL AS GtkGradient PTR) AS ZSTRING PTR

#ENDIF ' __GTK_GRADIENT_H__

#IFNDEF __GTK_GRID_H__
#DEFINE __GTK_GRID_H__

#DEFINE GTK_TYPE_GRID (gtk_grid_get_type ())
#DEFINE GTK_GRID(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_GRID, GtkGrid))
#DEFINE GTK_GRID_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_GRID, GtkGridClass))
#DEFINE GTK_IS_GRID(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_GRID))
#DEFINE GTK_IS_GRID_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_GRID))
#DEFINE GTK_GRID_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_GRID, GtkGridClass))

TYPE GtkGrid AS _GtkGrid
TYPE GtkGridPrivate AS _GtkGridPrivate
TYPE GtkGridClass AS _GtkGridClass

TYPE _GtkGrid
  AS GtkContainer container
  AS GtkGridPrivate PTR priv
END TYPE

TYPE _GtkGridClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_grid_get_type() AS GType
DECLARE FUNCTION gtk_grid_new() AS GtkWidget PTR
DECLARE SUB gtk_grid_attach(BYVAL AS GtkGrid PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_grid_attach_next_to(BYVAL AS GtkGrid PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkPositionType, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_grid_get_child_at(BYVAL AS GtkGrid PTR, BYVAL AS gint, BYVAL AS gint) AS GtkWidget PTR
DECLARE SUB gtk_grid_insert_row(BYVAL AS GtkGrid PTR, BYVAL AS gint)
DECLARE SUB gtk_grid_insert_column(BYVAL AS GtkGrid PTR, BYVAL AS gint)
DECLARE SUB gtk_grid_insert_next_to(BYVAL AS GtkGrid PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkPositionType)
DECLARE SUB gtk_grid_set_row_homogeneous(BYVAL AS GtkGrid PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_grid_get_row_homogeneous(BYVAL AS GtkGrid PTR) AS gboolean
DECLARE SUB gtk_grid_set_row_spacing(BYVAL AS GtkGrid PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_grid_get_row_spacing(BYVAL AS GtkGrid PTR) AS guint
DECLARE SUB gtk_grid_set_column_homogeneous(BYVAL AS GtkGrid PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_grid_get_column_homogeneous(BYVAL AS GtkGrid PTR) AS gboolean
DECLARE SUB gtk_grid_set_column_spacing(BYVAL AS GtkGrid PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_grid_get_column_spacing(BYVAL AS GtkGrid PTR) AS guint

#ENDIF ' __GTK_GRID_H__

#IFNDEF __GTK_HANDLE_BOX_H__
#DEFINE __GTK_HANDLE_BOX_H__

#DEFINE GTK_TYPE_HANDLE_BOX (gtk_handle_box_get_type ())
#DEFINE GTK_HANDLE_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HANDLE_BOX, GtkHandleBox))
#DEFINE GTK_HANDLE_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HANDLE_BOX, GtkHandleBoxClass))
#DEFINE GTK_IS_HANDLE_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HANDLE_BOX))
#DEFINE GTK_IS_HANDLE_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HANDLE_BOX))
#DEFINE GTK_HANDLE_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HANDLE_BOX, GtkHandleBoxClass))

TYPE GtkHandleBox AS _GtkHandleBox
TYPE GtkHandleBoxPrivate AS _GtkHandleBoxPrivate
TYPE GtkHandleBoxClass AS _GtkHandleBoxClass

TYPE _GtkHandleBox
  AS GtkBin bin
  AS GtkHandleBoxPrivate PTR priv
END TYPE

TYPE _GtkHandleBoxClass
  AS GtkBinClass parent_class
  child_attached AS SUB(BYVAL AS GtkHandleBox PTR, BYVAL AS GtkWidget PTR)
  child_detached AS SUB(BYVAL AS GtkHandleBox PTR, BYVAL AS GtkWidget PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_handle_box_get_type() AS GType
DECLARE FUNCTION gtk_handle_box_new() AS GtkWidget PTR
DECLARE SUB gtk_handle_box_set_shadow_type(BYVAL AS GtkHandleBox PTR, BYVAL AS GtkShadowType)
DECLARE FUNCTION gtk_handle_box_get_shadow_type(BYVAL AS GtkHandleBox PTR) AS GtkShadowType
DECLARE SUB gtk_handle_box_set_handle_position(BYVAL AS GtkHandleBox PTR, BYVAL AS GtkPositionType)
DECLARE FUNCTION gtk_handle_box_get_handle_position(BYVAL AS GtkHandleBox PTR) AS GtkPositionType
DECLARE SUB gtk_handle_box_set_snap_edge(BYVAL AS GtkHandleBox PTR, BYVAL AS GtkPositionType)
DECLARE FUNCTION gtk_handle_box_get_snap_edge(BYVAL AS GtkHandleBox PTR) AS GtkPositionType
DECLARE FUNCTION gtk_handle_box_get_child_detached(BYVAL AS GtkHandleBox PTR) AS gboolean

#ENDIF ' __GTK_HANDLE_BOX_H__

#IFNDEF __GTK_HBUTTON_BOX_H__
#DEFINE __GTK_HBUTTON_BOX_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#DEFINE GTK_TYPE_HBUTTON_BOX (gtk_hbutton_box_get_type ())
#DEFINE GTK_HBUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HBUTTON_BOX, GtkHButtonBox))
#DEFINE GTK_HBUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HBUTTON_BOX, GtkHButtonBoxClass))
#DEFINE GTK_IS_HBUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HBUTTON_BOX))
#DEFINE GTK_IS_HBUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HBUTTON_BOX))
#DEFINE GTK_HBUTTON_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HBUTTON_BOX, GtkHButtonBoxClass))

TYPE GtkHButtonBox AS _GtkHButtonBox
TYPE GtkHButtonBoxClass AS _GtkHButtonBoxClass

TYPE _GtkHButtonBox
  AS GtkButtonBox button_box
END TYPE

TYPE _GtkHButtonBoxClass
  AS GtkButtonBoxClass parent_class
END TYPE

DECLARE FUNCTION gtk_hbutton_box_get_type() AS GType
DECLARE FUNCTION gtk_hbutton_box_new() AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_HBUTTON_BOX_H__

#IFNDEF __GTK_HBOX_H__
#DEFINE __GTK_HBOX_H__

#IFNDEF GTK_DISABLE_DEPRECATED
#DEFINE GTK_TYPE_HBOX (gtk_hbox_get_type ())
#DEFINE GTK_HBOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HBOX, GtkHBox))
#DEFINE GTK_HBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HBOX, GtkHBoxClass))
#DEFINE GTK_IS_HBOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HBOX))
#DEFINE GTK_IS_HBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HBOX))
#DEFINE GTK_HBOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HBOX, GtkHBoxClass))

TYPE GtkHBox AS _GtkHBox
TYPE GtkHBoxClass AS _GtkHBoxClass

TYPE _GtkHBox
  AS GtkBox box
END TYPE

TYPE _GtkHBoxClass
  AS GtkBoxClass parent_class
END TYPE

DECLARE FUNCTION gtk_hbox_get_type() AS GType
DECLARE FUNCTION gtk_hbox_new(BYVAL AS gboolean, BYVAL AS gint) AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_HBOX_H__

#IFNDEF __GTK_HPANED_H__
#DEFINE __GTK_HPANED_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#IFNDEF __GTK_PANED_H__
#DEFINE __GTK_PANED_H__

#DEFINE GTK_TYPE_PANED (gtk_paned_get_type ())
#DEFINE GTK_PANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PANED, GtkPaned))
#DEFINE GTK_PANED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_PANED, GtkPanedClass))
#DEFINE GTK_IS_PANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PANED))
#DEFINE GTK_IS_PANED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PANED))
#DEFINE GTK_PANED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_PANED, GtkPanedClass))

TYPE GtkPaned AS _GtkPaned
TYPE GtkPanedClass AS _GtkPanedClass
TYPE GtkPanedPrivate AS _GtkPanedPrivate

TYPE _GtkPaned
  AS GtkContainer container
  AS GtkPanedPrivate PTR priv
END TYPE

TYPE _GtkPanedClass
  AS GtkContainerClass parent_class
  cycle_child_focus AS FUNCTION(BYVAL AS GtkPaned PTR, BYVAL AS gboolean) AS gboolean
  toggle_handle_focus AS FUNCTION(BYVAL AS GtkPaned PTR) AS gboolean
  move_handle AS FUNCTION(BYVAL AS GtkPaned PTR, BYVAL AS GtkScrollType) AS gboolean
  cycle_handle_focus AS FUNCTION(BYVAL AS GtkPaned PTR, BYVAL AS gboolean) AS gboolean
  accept_position AS FUNCTION(BYVAL AS GtkPaned PTR) AS gboolean
  cancel_position AS FUNCTION(BYVAL AS GtkPaned PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_paned_get_type() AS GType
DECLARE FUNCTION gtk_paned_new(BYVAL AS GtkOrientation) AS GtkWidget PTR
DECLARE SUB gtk_paned_add1(BYVAL AS GtkPaned PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_paned_add2(BYVAL AS GtkPaned PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_paned_pack1(BYVAL AS GtkPaned PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE SUB gtk_paned_pack2(BYVAL AS GtkPaned PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean, BYVAL AS gboolean)
DECLARE FUNCTION gtk_paned_get_position(BYVAL AS GtkPaned PTR) AS gint
DECLARE SUB gtk_paned_set_position(BYVAL AS GtkPaned PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_paned_get_child1(BYVAL AS GtkPaned PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_paned_get_child2(BYVAL AS GtkPaned PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_paned_get_handle_window(BYVAL AS GtkPaned PTR) AS GdkWindow PTR

#ENDIF ' __GTK_PANED_H__

#DEFINE GTK_TYPE_HPANED (gtk_hpaned_get_type ())
#DEFINE GTK_HPANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HPANED, GtkHPaned))
#DEFINE GTK_HPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HPANED, GtkHPanedClass))
#DEFINE GTK_IS_HPANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HPANED))
#DEFINE GTK_IS_HPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HPANED))
#DEFINE GTK_HPANED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HPANED, GtkHPanedClass))

TYPE GtkHPaned AS _GtkHPaned
TYPE GtkHPanedClass AS _GtkHPanedClass

TYPE _GtkHPaned
  AS GtkPaned paned
END TYPE

TYPE _GtkHPanedClass
  AS GtkPanedClass parent_class
END TYPE

DECLARE FUNCTION gtk_hpaned_get_type() AS GType
DECLARE FUNCTION gtk_hpaned_new() AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_HPANED_H__

#IFNDEF __GTK_HSCALE_H__
#DEFINE __GTK_HSCALE_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#IFNDEF __GTK_SCALE_H__
#DEFINE __GTK_SCALE_H__

#IFNDEF __GTK_RANGE_H__
#DEFINE __GTK_RANGE_H__

#DEFINE GTK_TYPE_RANGE (gtk_range_get_type ())
#DEFINE GTK_RANGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RANGE, GtkRange))
#DEFINE GTK_RANGE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RANGE, GtkRangeClass))
#DEFINE GTK_IS_RANGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RANGE))
#DEFINE GTK_IS_RANGE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RANGE))
#DEFINE GTK_RANGE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RANGE, GtkRangeClass))

TYPE GtkRange AS _GtkRange
TYPE GtkRangePrivate AS _GtkRangePrivate
TYPE GtkRangeClass AS _GtkRangeClass

TYPE _GtkRange
  AS GtkWidget widget
  AS GtkRangePrivate PTR priv
END TYPE

TYPE _GtkRangeClass
  AS GtkWidgetClass parent_class
  AS gchar PTR slider_detail
  AS gchar PTR stepper_detail
  value_changed AS SUB(BYVAL AS GtkRange PTR)
  adjust_bounds AS SUB(BYVAL AS GtkRange PTR, BYVAL AS gdouble)
  move_slider AS SUB(BYVAL AS GtkRange PTR, BYVAL AS GtkScrollType)
  get_range_border AS SUB(BYVAL AS GtkRange PTR, BYVAL AS GtkBorder PTR)
  change_value AS FUNCTION(BYVAL AS GtkRange PTR, BYVAL AS GtkScrollType, BYVAL AS gdouble) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_range_get_type() AS GType
DECLARE SUB gtk_range_set_adjustment(BYVAL AS GtkRange PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_range_get_adjustment(BYVAL AS GtkRange PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_range_set_inverted(BYVAL AS GtkRange PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_range_get_inverted(BYVAL AS GtkRange PTR) AS gboolean
DECLARE SUB gtk_range_set_flippable(BYVAL AS GtkRange PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_range_get_flippable(BYVAL AS GtkRange PTR) AS gboolean
DECLARE SUB gtk_range_set_slider_size_fixed(BYVAL AS GtkRange PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_range_get_slider_size_fixed(BYVAL AS GtkRange PTR) AS gboolean
DECLARE SUB gtk_range_set_min_slider_size(BYVAL AS GtkRange PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_range_get_min_slider_size(BYVAL AS GtkRange PTR) AS gint
DECLARE SUB gtk_range_get_range_rect(BYVAL AS GtkRange PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_range_get_slider_range(BYVAL AS GtkRange PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_range_set_lower_stepper_sensitivity(BYVAL AS GtkRange PTR, BYVAL AS GtkSensitivityType)
DECLARE FUNCTION gtk_range_get_lower_stepper_sensitivity(BYVAL AS GtkRange PTR) AS GtkSensitivityType
DECLARE SUB gtk_range_set_upper_stepper_sensitivity(BYVAL AS GtkRange PTR, BYVAL AS GtkSensitivityType)
DECLARE FUNCTION gtk_range_get_upper_stepper_sensitivity(BYVAL AS GtkRange PTR) AS GtkSensitivityType
DECLARE SUB gtk_range_set_increments(BYVAL AS GtkRange PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_range_set_range(BYVAL AS GtkRange PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_range_set_value(BYVAL AS GtkRange PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_range_get_value(BYVAL AS GtkRange PTR) AS gdouble
DECLARE SUB gtk_range_set_show_fill_level(BYVAL AS GtkRange PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_range_get_show_fill_level(BYVAL AS GtkRange PTR) AS gboolean
DECLARE SUB gtk_range_set_restrict_to_fill_level(BYVAL AS GtkRange PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_range_get_restrict_to_fill_level(BYVAL AS GtkRange PTR) AS gboolean
DECLARE SUB gtk_range_set_fill_level(BYVAL AS GtkRange PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_range_get_fill_level(BYVAL AS GtkRange PTR) AS gdouble
DECLARE SUB gtk_range_set_round_digits(BYVAL AS GtkRange PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_range_get_round_digits(BYVAL AS GtkRange PTR) AS gint
DECLARE FUNCTION _gtk_range_get_wheel_delta(BYVAL AS GtkRange PTR, BYVAL AS GdkScrollDirection) AS gdouble
DECLARE SUB _gtk_range_set_stop_values(BYVAL AS GtkRange PTR, BYVAL AS gdouble PTR, BYVAL AS gint)
DECLARE FUNCTION _gtk_range_get_stop_positions(BYVAL AS GtkRange PTR, BYVAL AS gint PTR PTR) AS gint
DECLARE SUB _gtk_range_set_steppers(BYVAL AS GtkRange PTR, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean)

#ENDIF ' __GTK_RANGE_H__

#DEFINE GTK_TYPE_SCALE (gtk_scale_get_type ())
#DEFINE GTK_SCALE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCALE, GtkScale))
#DEFINE GTK_SCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCALE, GtkScaleClass))
#DEFINE GTK_IS_SCALE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCALE))
#DEFINE GTK_IS_SCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCALE))
#DEFINE GTK_SCALE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCALE, GtkScaleClass))

TYPE GtkScale AS _GtkScale
TYPE GtkScalePrivate AS _GtkScalePrivate
TYPE GtkScaleClass AS _GtkScaleClass

TYPE _GtkScale
  AS GtkRange range
  AS GtkScalePrivate PTR priv
END TYPE

TYPE _GtkScaleClass
  AS GtkRangeClass parent_class
  format_value AS FUNCTION(BYVAL AS GtkScale PTR, BYVAL AS gdouble) AS gchar PTR
  draw_value AS SUB(BYVAL AS GtkScale PTR)
  get_layout_offsets AS SUB(BYVAL AS GtkScale PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_scale_get_type() AS GType
DECLARE FUNCTION gtk_scale_new(BYVAL AS GtkOrientation, BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_scale_new_with_range(BYVAL AS GtkOrientation, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkWidget PTR
DECLARE SUB gtk_scale_set_digits(BYVAL AS GtkScale PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_scale_get_digits(BYVAL AS GtkScale PTR) AS gint
DECLARE SUB gtk_scale_set_draw_value(BYVAL AS GtkScale PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_scale_get_draw_value(BYVAL AS GtkScale PTR) AS gboolean
DECLARE SUB gtk_scale_set_value_pos(BYVAL AS GtkScale PTR, BYVAL AS GtkPositionType)
DECLARE FUNCTION gtk_scale_get_value_pos(BYVAL AS GtkScale PTR) AS GtkPositionType
DECLARE FUNCTION gtk_scale_get_layout(BYVAL AS GtkScale PTR) AS PangoLayout PTR
DECLARE SUB gtk_scale_get_layout_offsets(BYVAL AS GtkScale PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_scale_add_mark(BYVAL AS GtkScale PTR, BYVAL AS gdouble, BYVAL AS GtkPositionType, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_scale_clear_marks(BYVAL AS GtkScale PTR)

#ENDIF ' __GTK_SCALE_H__

#DEFINE GTK_TYPE_HSCALE (gtk_hscale_get_type ())
#DEFINE GTK_HSCALE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSCALE, GtkHScale))
#DEFINE GTK_HSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSCALE, GtkHScaleClass))
#DEFINE GTK_IS_HSCALE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSCALE))
#DEFINE GTK_IS_HSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSCALE))
#DEFINE GTK_HSCALE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSCALE, GtkHScaleClass))

TYPE GtkHScale AS _GtkHScale
TYPE GtkHScaleClass AS _GtkHScaleClass

TYPE _GtkHScale
  AS GtkScale scale
END TYPE

TYPE _GtkHScaleClass
  AS GtkScaleClass parent_class
END TYPE

DECLARE FUNCTION gtk_hscale_get_type() AS GType
DECLARE FUNCTION gtk_hscale_new(BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_hscale_new_with_range(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_HSCALE_H__

#IFNDEF __GTK_HSCROLLBAR_H__
#DEFINE __GTK_HSCROLLBAR_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#IFNDEF __GTK_SCROLLBAR_H__
#DEFINE __GTK_SCROLLBAR_H__

#DEFINE GTK_TYPE_SCROLLBAR (gtk_scrollbar_get_type ())
#DEFINE GTK_SCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLBAR, GtkScrollbar))
#DEFINE GTK_SCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCROLLBAR, GtkScrollbarClass))
#DEFINE GTK_IS_SCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLBAR))
#DEFINE GTK_IS_SCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCROLLBAR))
#DEFINE GTK_SCROLLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCROLLBAR, GtkScrollbarClass))

TYPE GtkScrollbar AS _GtkScrollbar
TYPE GtkScrollbarClass AS _GtkScrollbarClass

TYPE _GtkScrollbar
  AS GtkRange range
END TYPE

TYPE _GtkScrollbarClass
  AS GtkRangeClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_scrollbar_get_type() AS GType
DECLARE FUNCTION gtk_scrollbar_new(BYVAL AS GtkOrientation, BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR

#ENDIF ' __GTK_SCROLLBAR_H__

#DEFINE GTK_TYPE_HSCROLLBAR (gtk_hscrollbar_get_type ())
#DEFINE GTK_HSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSCROLLBAR, GtkHScrollbar))
#DEFINE GTK_HSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSCROLLBAR, GtkHScrollbarClass))
#DEFINE GTK_IS_HSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSCROLLBAR))
#DEFINE GTK_IS_HSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSCROLLBAR))
#DEFINE GTK_HSCROLLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSCROLLBAR, GtkHScrollbarClass))

TYPE GtkHScrollbar AS _GtkHScrollbar
TYPE GtkHScrollbarClass AS _GtkHScrollbarClass

TYPE _GtkHScrollbar
  AS GtkScrollbar scrollbar
END TYPE

TYPE _GtkHScrollbarClass
  AS GtkScrollbarClass parent_class
END TYPE

DECLARE FUNCTION gtk_hscrollbar_get_type() AS GType
DECLARE FUNCTION gtk_hscrollbar_new(BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_HSCROLLBAR_H__

#IFNDEF __GTK_HSEPARATOR_H__
#DEFINE __GTK_HSEPARATOR_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#IFNDEF __GTK_SEPARATOR_H__
#DEFINE __GTK_SEPARATOR_H__

#DEFINE GTK_TYPE_SEPARATOR (gtk_separator_get_type ())
#DEFINE GTK_SEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR, GtkSeparator))
#DEFINE GTK_SEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SEPARATOR, GtkSeparatorClass))
#DEFINE GTK_IS_SEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR))
#DEFINE GTK_IS_SEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SEPARATOR))
#DEFINE GTK_SEPARATOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SEPARATOR, GtkSeparatorClass))

TYPE GtkSeparator AS _GtkSeparator
TYPE GtkSeparatorPrivate AS _GtkSeparatorPrivate
TYPE GtkSeparatorClass AS _GtkSeparatorClass

TYPE _GtkSeparator
  AS GtkWidget widget
  AS GtkSeparatorPrivate PTR priv
END TYPE

TYPE _GtkSeparatorClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_separator_get_type() AS GType
DECLARE FUNCTION gtk_separator_new(BYVAL AS GtkOrientation) AS GtkWidget PTR

#ENDIF ' __GTK_SEPARATOR_H__

#DEFINE GTK_TYPE_HSEPARATOR (gtk_hseparator_get_type ())
#DEFINE GTK_HSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSEPARATOR, GtkHSeparator))
#DEFINE GTK_HSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSEPARATOR, GtkHSeparatorClass))
#DEFINE GTK_IS_HSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSEPARATOR))
#DEFINE GTK_IS_HSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSEPARATOR))
#DEFINE GTK_HSEPARATOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSEPARATOR, GtkHSeparatorClass))

TYPE GtkHSeparator AS _GtkHSeparator
TYPE GtkHSeparatorClass AS _GtkHSeparatorClass

TYPE _GtkHSeparator
  AS GtkSeparator separator
END TYPE

TYPE _GtkHSeparatorClass
  AS GtkSeparatorClass parent_class
END TYPE

DECLARE FUNCTION gtk_hseparator_get_type() AS GType
DECLARE FUNCTION gtk_hseparator_new() AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_HSEPARATOR_H__

#IFNDEF __GTK_HSV_H__
#DEFINE __GTK_HSV_H__

#DEFINE GTK_TYPE_HSV (gtk_hsv_get_type ())
#DEFINE GTK_HSV(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HSV, GtkHSV))
#DEFINE GTK_HSV_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_HSV, GtkHSVClass))
#DEFINE GTK_IS_HSV(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HSV))
#DEFINE GTK_IS_HSV_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_HSV))
#DEFINE GTK_HSV_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_HSV, GtkHSVClass))

TYPE GtkHSV AS _GtkHSV
TYPE GtkHSVPrivate AS _GtkHSVPrivate
TYPE GtkHSVClass AS _GtkHSVClass

TYPE _GtkHSV
  AS GtkWidget parent_instance
  AS GtkHSVPrivate PTR priv
END TYPE

TYPE _GtkHSVClass
  AS GtkWidgetClass parent_class
  changed AS SUB(BYVAL AS GtkHSV PTR)
  move AS SUB(BYVAL AS GtkHSV PTR, BYVAL AS GtkDirectionType)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_hsv_get_type() AS GType
DECLARE FUNCTION gtk_hsv_new() AS GtkWidget PTR
DECLARE SUB gtk_hsv_set_color(BYVAL AS GtkHSV PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB gtk_hsv_get_color(BYVAL AS GtkHSV PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB gtk_hsv_set_metrics(BYVAL AS GtkHSV PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_hsv_get_metrics(BYVAL AS GtkHSV PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gtk_hsv_is_adjusting(BYVAL AS GtkHSV PTR) AS gboolean
DECLARE SUB gtk_hsv_to_rgb(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB gtk_rgb_to_hsv(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)

#ENDIF ' __GTK_HSV_H__

#IFNDEF __GTK_ICON_THEME_H__
#DEFINE __GTK_ICON_THEME_H__
#INCLUDE ONCE "gdk-pixbuf/gdk-pixbuf.bi"

#DEFINE GTK_TYPE_ICON_INFO (gtk_icon_info_get_type ())
#DEFINE GTK_TYPE_ICON_THEME (gtk_icon_theme_get_type ())
#DEFINE GTK_ICON_THEME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ICON_THEME, GtkIconTheme))
#DEFINE GTK_ICON_THEME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ICON_THEME, GtkIconThemeClass))
#DEFINE GTK_IS_ICON_THEME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ICON_THEME))
#DEFINE GTK_IS_ICON_THEME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ICON_THEME))
#DEFINE GTK_ICON_THEME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ICON_THEME, GtkIconThemeClass))

TYPE GtkIconInfo AS _GtkIconInfo
TYPE GtkIconTheme AS _GtkIconTheme
TYPE GtkIconThemeClass AS _GtkIconThemeClass
TYPE GtkIconThemePrivate AS _GtkIconThemePrivate

TYPE _GtkIconTheme
  AS GObject parent_instance
  AS GtkIconThemePrivate PTR priv
END TYPE

TYPE _GtkIconThemeClass
  AS GObjectClass parent_class
  changed AS SUB(BYVAL AS GtkIconTheme PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

ENUM GtkIconLookupFlags
  GTK_ICON_LOOKUP_NO_SVG = 1 SHL 0
  GTK_ICON_LOOKUP_FORCE_SVG = 1 SHL 1
  GTK_ICON_LOOKUP_USE_BUILTIN = 1 SHL 2
  GTK_ICON_LOOKUP_GENERIC_FALLBACK = 1 SHL 3
  GTK_ICON_LOOKUP_FORCE_SIZE = 1 SHL 4
END ENUM

#DEFINE GTK_ICON_THEME_ERROR gtk_icon_theme_error_quark ()

ENUM GtkIconThemeError
  GTK_ICON_THEME_NOT_FOUND
  GTK_ICON_THEME_FAILED
END ENUM

DECLARE FUNCTION gtk_icon_theme_error_quark() AS GQuark
DECLARE FUNCTION gtk_icon_theme_get_type() AS GType
DECLARE FUNCTION gtk_icon_theme_new() AS GtkIconTheme PTR
DECLARE FUNCTION gtk_icon_theme_get_default() AS GtkIconTheme PTR
DECLARE FUNCTION gtk_icon_theme_get_for_screen(BYVAL AS GdkScreen PTR) AS GtkIconTheme PTR
DECLARE SUB gtk_icon_theme_set_screen(BYVAL AS GtkIconTheme PTR, BYVAL AS GdkScreen PTR)
DECLARE SUB gtk_icon_theme_set_search_path(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS gint)
DECLARE SUB gtk_icon_theme_get_search_path(BYVAL AS GtkIconTheme PTR, BYVAL AS gchar PTR PTR PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_icon_theme_append_search_path(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_icon_theme_prepend_search_path(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_icon_theme_set_custom_theme(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_icon_theme_has_icon(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_icon_theme_get_icon_sizes(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR) AS gint PTR
DECLARE FUNCTION gtk_icon_theme_lookup_icon(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS GtkIconLookupFlags) AS GtkIconInfo PTR
DECLARE FUNCTION gtk_icon_theme_choose_icon(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS gint, BYVAL AS GtkIconLookupFlags) AS GtkIconInfo PTR
DECLARE FUNCTION gtk_icon_theme_load_icon(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS GtkIconLookupFlags, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_icon_theme_lookup_by_gicon(BYVAL AS GtkIconTheme PTR, BYVAL AS GIcon PTR, BYVAL AS gint, BYVAL AS GtkIconLookupFlags) AS GtkIconInfo PTR
DECLARE FUNCTION gtk_icon_theme_list_icons(BYVAL AS GtkIconTheme PTR, BYVAL AS CONST gchar PTR) AS GList PTR
DECLARE FUNCTION gtk_icon_theme_list_contexts(BYVAL AS GtkIconTheme PTR) AS GList PTR
DECLARE FUNCTION gtk_icon_theme_get_example_icon_name(BYVAL AS GtkIconTheme PTR) AS ZSTRING PTR
DECLARE FUNCTION gtk_icon_theme_rescan_if_needed(BYVAL AS GtkIconTheme PTR) AS gboolean
DECLARE SUB gtk_icon_theme_add_builtin_icon(BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS GdkPixbuf PTR)
DECLARE FUNCTION gtk_icon_info_get_type() AS GType
DECLARE FUNCTION gtk_icon_info_copy(BYVAL AS GtkIconInfo PTR) AS GtkIconInfo PTR
DECLARE SUB gtk_icon_info_free(BYVAL AS GtkIconInfo PTR)
DECLARE FUNCTION gtk_icon_info_new_for_pixbuf(BYVAL AS GtkIconTheme PTR, BYVAL AS GdkPixbuf PTR) AS GtkIconInfo PTR
DECLARE FUNCTION gtk_icon_info_get_base_size(BYVAL AS GtkIconInfo PTR) AS gint
DECLARE FUNCTION gtk_icon_info_get_filename(BYVAL AS GtkIconInfo PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_icon_info_get_builtin_pixbuf(BYVAL AS GtkIconInfo PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_icon_info_load_icon(BYVAL AS GtkIconInfo PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_icon_info_load_symbolic(BYVAL AS GtkIconInfo PTR, BYVAL AS CONST GdkRGBA PTR, BYVAL AS CONST GdkRGBA PTR, BYVAL AS CONST GdkRGBA PTR, BYVAL AS CONST GdkRGBA PTR, BYVAL AS gboolean PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_icon_info_load_symbolic_for_context(BYVAL AS GtkIconInfo PTR, BYVAL AS GtkStyleContext PTR, BYVAL AS gboolean PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_icon_info_load_symbolic_for_style(BYVAL AS GtkIconInfo PTR, BYVAL AS GtkStyle PTR, BYVAL AS GtkStateType, BYVAL AS gboolean PTR, BYVAL AS GError PTR PTR) AS GdkPixbuf PTR

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE SUB gtk_icon_info_set_raw_coordinates(BYVAL AS GtkIconInfo PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_icon_info_get_embedded_rect(BYVAL AS GtkIconInfo PTR, BYVAL AS GdkRectangle PTR) AS gboolean
DECLARE FUNCTION gtk_icon_info_get_attach_points(BYVAL AS GtkIconInfo PTR, BYVAL AS GdkPoint PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gtk_icon_info_get_display_name(BYVAL AS GtkIconInfo PTR) AS CONST gchar PTR
DECLARE SUB _gtk_icon_theme_check_reload(BYVAL AS GdkDisplay PTR)
DECLARE SUB _gtk_icon_theme_ensure_builtin_cache()

#ENDIF ' __GTK_ICON_THEME_H__

#IFNDEF __GTK_ICON_VIEW_H__
#DEFINE __GTK_ICON_VIEW_H__

#IFNDEF __GTK_TOOLTIP_H__
#DEFINE __GTK_TOOLTIP_H__

#DEFINE GTK_TYPE_TOOLTIP (gtk_tooltip_get_type ())
#DEFINE GTK_TOOLTIP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOLTIP, GtkTooltip))
#DEFINE GTK_IS_TOOLTIP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOLTIP))

DECLARE FUNCTION gtk_tooltip_get_type() AS GType
DECLARE SUB gtk_tooltip_set_markup(BYVAL AS GtkTooltip PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_tooltip_set_text(BYVAL AS GtkTooltip PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_tooltip_set_icon(BYVAL AS GtkTooltip PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_tooltip_set_icon_from_stock(BYVAL AS GtkTooltip PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_tooltip_set_icon_from_icon_name(BYVAL AS GtkTooltip PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_tooltip_set_icon_from_gicon(BYVAL AS GtkTooltip PTR, BYVAL AS GIcon PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_tooltip_set_custom(BYVAL AS GtkTooltip PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_tooltip_set_tip_area(BYVAL AS GtkTooltip PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gtk_tooltip_trigger_tooltip_query(BYVAL AS GdkDisplay PTR)
DECLARE SUB _gtk_tooltip_focus_in(BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_tooltip_focus_out(BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_tooltip_toggle_keyboard_mode(BYVAL AS GtkWidget PTR)
DECLARE SUB _gtk_tooltip_handle_event(BYVAL AS GdkEvent PTR)
DECLARE SUB _gtk_tooltip_hide(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION _gtk_widget_find_at_coords(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GtkWidget PTR

#ENDIF ' __GTK_TOOLTIP_H__

#DEFINE GTK_TYPE_ICON_VIEW (gtk_icon_view_get_type ())
#DEFINE GTK_ICON_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ICON_VIEW, GtkIconView))
#DEFINE GTK_ICON_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ICON_VIEW, GtkIconViewClass))
#DEFINE GTK_IS_ICON_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ICON_VIEW))
#DEFINE GTK_IS_ICON_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ICON_VIEW))
#DEFINE GTK_ICON_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ICON_VIEW, GtkIconViewClass))

TYPE GtkIconView AS _GtkIconView
TYPE GtkIconViewClass AS _GtkIconViewClass
TYPE GtkIconViewPrivate AS _GtkIconViewPrivate
TYPE GtkIconViewForeachFunc AS SUB(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS gpointer)

ENUM GtkIconViewDropPosition
  GTK_ICON_VIEW_NO_DROP
  GTK_ICON_VIEW_DROP_INTO
  GTK_ICON_VIEW_DROP_LEFT
  GTK_ICON_VIEW_DROP_RIGHT
  GTK_ICON_VIEW_DROP_ABOVE
  GTK_ICON_VIEW_DROP_BELOW
END ENUM

TYPE _GtkIconView
  AS GtkContainer parent
  AS GtkIconViewPrivate PTR priv
END TYPE

TYPE _GtkIconViewClass
  AS GtkContainerClass parent_class
  item_activated AS SUB(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR)
  selection_changed AS SUB(BYVAL AS GtkIconView PTR)
  select_all AS SUB(BYVAL AS GtkIconView PTR)
  unselect_all AS SUB(BYVAL AS GtkIconView PTR)
  select_cursor_item AS SUB(BYVAL AS GtkIconView PTR)
  toggle_cursor_item AS SUB(BYVAL AS GtkIconView PTR)
  move_cursor AS FUNCTION(BYVAL AS GtkIconView PTR, BYVAL AS GtkMovementStep, BYVAL AS gint) AS gboolean
  activate_cursor_item AS FUNCTION(BYVAL AS GtkIconView PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_icon_view_get_type() AS GType
DECLARE FUNCTION gtk_icon_view_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_icon_view_new_with_area(BYVAL AS GtkCellArea PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_icon_view_new_with_model(BYVAL AS GtkTreeModel PTR) AS GtkWidget PTR
DECLARE SUB gtk_icon_view_set_model(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreeModel PTR)
DECLARE FUNCTION gtk_icon_view_get_model(BYVAL AS GtkIconView PTR) AS GtkTreeModel PTR
DECLARE SUB gtk_icon_view_set_text_column(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_text_column(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_markup_column(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_markup_column(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_pixbuf_column(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_pixbuf_column(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_item_orientation(BYVAL AS GtkIconView PTR, BYVAL AS GtkOrientation)
DECLARE FUNCTION gtk_icon_view_get_item_orientation(BYVAL AS GtkIconView PTR) AS GtkOrientation
DECLARE SUB gtk_icon_view_set_columns(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_columns(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_item_width(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_item_width(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_spacing(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_spacing(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_row_spacing(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_row_spacing(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_column_spacing(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_column_spacing(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_margin(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_margin(BYVAL AS GtkIconView PTR) AS gint
DECLARE SUB gtk_icon_view_set_item_padding(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_item_padding(BYVAL AS GtkIconView PTR) AS gint
DECLARE FUNCTION gtk_icon_view_get_path_at_pos(BYVAL AS GtkIconView PTR, BYVAL AS gint, BYVAL AS gint) AS GtkTreePath PTR
DECLARE FUNCTION gtk_icon_view_get_item_at_pos(BYVAL AS GtkIconView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkCellRenderer PTR PTR) AS gboolean
DECLARE FUNCTION gtk_icon_view_get_visible_range(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreePath PTR PTR) AS gboolean
DECLARE SUB gtk_icon_view_selected_foreach(BYVAL AS GtkIconView PTR, BYVAL AS GtkIconViewForeachFunc, BYVAL AS gpointer)
DECLARE SUB gtk_icon_view_set_selection_mode(BYVAL AS GtkIconView PTR, BYVAL AS GtkSelectionMode)
DECLARE FUNCTION gtk_icon_view_get_selection_mode(BYVAL AS GtkIconView PTR) AS GtkSelectionMode
DECLARE SUB gtk_icon_view_select_path(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_icon_view_unselect_path(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR)
DECLARE FUNCTION gtk_icon_view_path_is_selected(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_icon_view_get_item_row(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR) AS gint
DECLARE FUNCTION gtk_icon_view_get_item_column(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR) AS gint
DECLARE FUNCTION gtk_icon_view_get_selected_items(BYVAL AS GtkIconView PTR) AS GList PTR
DECLARE SUB gtk_icon_view_select_all(BYVAL AS GtkIconView PTR)
DECLARE SUB gtk_icon_view_unselect_all(BYVAL AS GtkIconView PTR)
DECLARE SUB gtk_icon_view_item_activated(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_icon_view_set_cursor(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkCellRenderer PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_icon_view_get_cursor(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkCellRenderer PTR PTR) AS gboolean
DECLARE SUB gtk_icon_view_scroll_to_path(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS gboolean, BYVAL AS gfloat, BYVAL AS gfloat)
DECLARE SUB gtk_icon_view_enable_model_drag_source(BYVAL AS GtkIconView PTR, BYVAL AS GdkModifierType, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint, BYVAL AS GdkDragAction)
DECLARE SUB gtk_icon_view_enable_model_drag_dest(BYVAL AS GtkIconView PTR, BYVAL AS CONST GtkTargetEntry PTR, BYVAL AS gint, BYVAL AS GdkDragAction)
DECLARE SUB gtk_icon_view_unset_model_drag_source(BYVAL AS GtkIconView PTR)
DECLARE SUB gtk_icon_view_unset_model_drag_dest(BYVAL AS GtkIconView PTR)
DECLARE SUB gtk_icon_view_set_reorderable(BYVAL AS GtkIconView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_icon_view_get_reorderable(BYVAL AS GtkIconView PTR) AS gboolean
DECLARE SUB gtk_icon_view_set_drag_dest_item(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkIconViewDropPosition)
DECLARE SUB gtk_icon_view_get_drag_dest_item(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkIconViewDropPosition PTR)
DECLARE FUNCTION gtk_icon_view_get_dest_item_at_pos(BYVAL AS GtkIconView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkIconViewDropPosition PTR) AS gboolean
DECLARE FUNCTION gtk_icon_view_create_drag_icon(BYVAL AS GtkIconView PTR, BYVAL AS GtkTreePath PTR) AS cairo_surface_t PTR
DECLARE SUB gtk_icon_view_convert_widget_to_bin_window_coords(BYVAL AS GtkIconView PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_icon_view_set_tooltip_item(BYVAL AS GtkIconView PTR, BYVAL AS GtkTooltip PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_icon_view_set_tooltip_cell(BYVAL AS GtkIconView PTR, BYVAL AS GtkTooltip PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkCellRenderer PTR)
DECLARE FUNCTION gtk_icon_view_get_tooltip_context(BYVAL AS GtkIconView PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gboolean, BYVAL AS GtkTreeModel PTR PTR, BYVAL AS GtkTreePath PTR PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_icon_view_set_tooltip_column(BYVAL AS GtkIconView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_icon_view_get_tooltip_column(BYVAL AS GtkIconView PTR) AS gint

#ENDIF ' __GTK_ICON_VIEW_H__

#IFNDEF __GTK_IMAGE_MENU_ITEM_H__
#DEFINE __GTK_IMAGE_MENU_ITEM_H__

#DEFINE GTK_TYPE_IMAGE_MENU_ITEM (gtk_image_menu_item_get_type ())
#DEFINE GTK_IMAGE_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItem))
#DEFINE GTK_IMAGE_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass))
#DEFINE GTK_IS_IMAGE_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IMAGE_MENU_ITEM))
#DEFINE GTK_IS_IMAGE_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IMAGE_MENU_ITEM))
#DEFINE GTK_IMAGE_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IMAGE_MENU_ITEM, GtkImageMenuItemClass))

TYPE GtkImageMenuItem AS _GtkImageMenuItem
TYPE GtkImageMenuItemPrivate AS _GtkImageMenuItemPrivate
TYPE GtkImageMenuItemClass AS _GtkImageMenuItemClass

TYPE _GtkImageMenuItem
  AS GtkMenuItem menu_item
  AS GtkImageMenuItemPrivate PTR priv
END TYPE

TYPE _GtkImageMenuItemClass
  AS GtkMenuItemClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_image_menu_item_get_type() AS GType
DECLARE FUNCTION gtk_image_menu_item_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_image_menu_item_new_with_label(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_menu_item_new_with_mnemonic(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_image_menu_item_new_from_stock(BYVAL AS CONST gchar PTR, BYVAL AS GtkAccelGroup PTR) AS GtkWidget PTR
DECLARE SUB gtk_image_menu_item_set_always_show_image(BYVAL AS GtkImageMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_image_menu_item_get_always_show_image(BYVAL AS GtkImageMenuItem PTR) AS gboolean
DECLARE SUB gtk_image_menu_item_set_image(BYVAL AS GtkImageMenuItem PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_image_menu_item_get_image(BYVAL AS GtkImageMenuItem PTR) AS GtkWidget PTR
DECLARE SUB gtk_image_menu_item_set_use_stock(BYVAL AS GtkImageMenuItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_image_menu_item_get_use_stock(BYVAL AS GtkImageMenuItem PTR) AS gboolean
DECLARE SUB gtk_image_menu_item_set_accel_group(BYVAL AS GtkImageMenuItem PTR, BYVAL AS GtkAccelGroup PTR)

#ENDIF ' __GTK_IMAGE_MENU_ITEM_H__

#IFNDEF __GTK_IM_CONTEXT_SIMPLE_H__
#DEFINE __GTK_IM_CONTEXT_SIMPLE_H__

#DEFINE GTK_MAX_COMPOSE_LEN 7
#DEFINE GTK_TYPE_IM_CONTEXT_SIMPLE (gtk_im_context_simple_get_type ())
#DEFINE GTK_IM_CONTEXT_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimple))
#DEFINE GTK_IM_CONTEXT_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass))
#DEFINE GTK_IS_IM_CONTEXT_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_CONTEXT_SIMPLE))
#DEFINE GTK_IS_IM_CONTEXT_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_CONTEXT_SIMPLE))
#DEFINE GTK_IM_CONTEXT_SIMPLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass))

TYPE GtkIMContextSimple AS _GtkIMContextSimple
TYPE GtkIMContextSimplePrivate AS _GtkIMContextSimplePrivate
TYPE GtkIMContextSimpleClass AS _GtkIMContextSimpleClass

TYPE _GtkIMContextSimple
  AS GtkIMContext object
  AS GtkIMContextSimplePrivate PTR priv
END TYPE

TYPE _GtkIMContextSimpleClass
  AS GtkIMContextClass parent_class
END TYPE

DECLARE FUNCTION gtk_im_context_simple_get_type() AS GType
DECLARE FUNCTION gtk_im_context_simple_new() AS GtkIMContext PTR
DECLARE SUB gtk_im_context_simple_add_table(BYVAL AS GtkIMContextSimple PTR, BYVAL AS guint16 PTR, BYVAL AS gint, BYVAL AS gint)

#ENDIF ' __GTK_IM_CONTEXT_SIMPLE_H__

#IFNDEF __GTK_IM_MULTICONTEXT_H__
#DEFINE __GTK_IM_MULTICONTEXT_H__

#DEFINE GTK_TYPE_IM_MULTICONTEXT (gtk_im_multicontext_get_type ())
#DEFINE GTK_IM_MULTICONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontext))
#DEFINE GTK_IM_MULTICONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass))
#DEFINE GTK_IS_IM_MULTICONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_MULTICONTEXT))
#DEFINE GTK_IS_IM_MULTICONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_MULTICONTEXT))
#DEFINE GTK_IM_MULTICONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass))

TYPE GtkIMMulticontext AS _GtkIMMulticontext
TYPE GtkIMMulticontextClass AS _GtkIMMulticontextClass
TYPE GtkIMMulticontextPrivate AS _GtkIMMulticontextPrivate

TYPE _GtkIMMulticontext
  AS GtkIMContext object
  AS GtkIMMulticontextPrivate PTR priv
END TYPE

TYPE _GtkIMMulticontextClass
  AS GtkIMContextClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_im_multicontext_get_type() AS GType
DECLARE FUNCTION gtk_im_multicontext_new() AS GtkIMContext PTR
DECLARE SUB gtk_im_multicontext_append_menuitems(BYVAL AS GtkIMMulticontext PTR, BYVAL AS GtkMenuShell PTR)
DECLARE FUNCTION gtk_im_multicontext_get_context_id(BYVAL AS GtkIMMulticontext PTR) AS CONST ZSTRING PTR
DECLARE SUB gtk_im_multicontext_set_context_id(BYVAL AS GtkIMMulticontext PTR, BYVAL AS CONST ZSTRING PTR)

#ENDIF ' __GTK_IM_MULTICONTEXT_H__

#IFNDEF __GTK_INFO_BAR_H__
#DEFINE __GTK_INFO_BAR_H__

#DEFINE GTK_TYPE_INFO_BAR (gtk_info_bar_get_type())
#DEFINE GTK_INFO_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), GTK_TYPE_INFO_BAR, GtkInfoBar))
#DEFINE GTK_INFO_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST((klass), GTK_TYPE_INFO_BAR, GtkInfoBarClass))
#DEFINE GTK_IS_INFO_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE((obj), GTK_TYPE_INFO_BAR))
#DEFINE GTK_IS_INFO_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_INFO_BAR))
#DEFINE GTK_INFO_BAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_INFO_BAR, GtkInfoBarClass))

TYPE GtkInfoBarPrivate AS _GtkInfoBarPrivate
TYPE GtkInfoBarClass AS _GtkInfoBarClass
TYPE GtkInfoBar AS _GtkInfoBar

TYPE _GtkInfoBar
  AS GtkBox parent
  AS GtkInfoBarPrivate PTR priv
END TYPE

TYPE _GtkInfoBarClass
  AS GtkBoxClass parent_class
  response AS SUB(BYVAL AS GtkInfoBar PTR, BYVAL AS gint)
  close_ AS SUB(BYVAL AS GtkInfoBar PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_info_bar_get_type() AS GType
DECLARE FUNCTION gtk_info_bar_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_info_bar_new_with_buttons(BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE FUNCTION gtk_info_bar_get_action_area(BYVAL AS GtkInfoBar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_info_bar_get_content_area(BYVAL AS GtkInfoBar PTR) AS GtkWidget PTR
DECLARE SUB gtk_info_bar_add_action_widget(BYVAL AS GtkInfoBar PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_info_bar_add_button(BYVAL AS GtkInfoBar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS GtkWidget PTR
DECLARE SUB gtk_info_bar_add_buttons(BYVAL AS GtkInfoBar PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_info_bar_set_response_sensitive(BYVAL AS GtkInfoBar PTR, BYVAL AS gint, BYVAL AS gboolean)
DECLARE SUB gtk_info_bar_set_default_response(BYVAL AS GtkInfoBar PTR, BYVAL AS gint)
DECLARE SUB gtk_info_bar_response(BYVAL AS GtkInfoBar PTR, BYVAL AS gint)
DECLARE SUB gtk_info_bar_set_message_type(BYVAL AS GtkInfoBar PTR, BYVAL AS GtkMessageType)
DECLARE FUNCTION gtk_info_bar_get_message_type(BYVAL AS GtkInfoBar PTR) AS GtkMessageType

#ENDIF ' __GTK_INFO_BAR_H__

#IFNDEF __GTK_INVISIBLE_H__
#DEFINE __GTK_INVISIBLE_H__

#DEFINE GTK_TYPE_INVISIBLE (gtk_invisible_get_type ())
#DEFINE GTK_INVISIBLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_INVISIBLE, GtkInvisible))
#DEFINE GTK_INVISIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_INVISIBLE, GtkInvisibleClass))
#DEFINE GTK_IS_INVISIBLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_INVISIBLE))
#DEFINE GTK_IS_INVISIBLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_INVISIBLE))
#DEFINE GTK_INVISIBLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_INVISIBLE, GtkInvisibleClass))

TYPE GtkInvisible AS _GtkInvisible
TYPE GtkInvisiblePrivate AS _GtkInvisiblePrivate
TYPE GtkInvisibleClass AS _GtkInvisibleClass

TYPE _GtkInvisible
  AS GtkWidget widget
  AS GtkInvisiblePrivate PTR priv
END TYPE

TYPE _GtkInvisibleClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_invisible_get_type() AS GType
DECLARE FUNCTION gtk_invisible_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_invisible_new_for_screen(BYVAL AS GdkScreen PTR) AS GtkWidget PTR
DECLARE SUB gtk_invisible_set_screen(BYVAL AS GtkInvisible PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gtk_invisible_get_screen(BYVAL AS GtkInvisible PTR) AS GdkScreen PTR

#ENDIF ' __GTK_INVISIBLE_H__

#IFNDEF __GTK_LAYOUT_H__
#DEFINE __GTK_LAYOUT_H__

#DEFINE GTK_TYPE_LAYOUT (gtk_layout_get_type ())
#DEFINE GTK_LAYOUT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LAYOUT, GtkLayout))
#DEFINE GTK_LAYOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_LAYOUT, GtkLayoutClass))
#DEFINE GTK_IS_LAYOUT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LAYOUT))
#DEFINE GTK_IS_LAYOUT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LAYOUT))
#DEFINE GTK_LAYOUT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_LAYOUT, GtkLayoutClass))

TYPE GtkLayout AS _GtkLayout
TYPE GtkLayoutPrivate AS _GtkLayoutPrivate
TYPE GtkLayoutClass AS _GtkLayoutClass

TYPE _GtkLayout
  AS GtkContainer container
  AS GtkLayoutPrivate PTR priv
END TYPE

TYPE _GtkLayoutClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_layout_get_type() AS GType
DECLARE FUNCTION gtk_layout_new(BYVAL AS GtkAdjustment PTR, BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_layout_get_bin_window(BYVAL AS GtkLayout PTR) AS GdkWindow PTR
DECLARE SUB gtk_layout_put(BYVAL AS GtkLayout PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_layout_move(BYVAL AS GtkLayout PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_layout_set_size(BYVAL AS GtkLayout PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_layout_get_size(BYVAL AS GtkLayout PTR, BYVAL AS guint PTR, BYVAL AS guint PTR)

#IF NOT DEFINED (GTK_DISABLE_DEPRECATED) OR DEFINED (GTK_COMPILATION)

DECLARE FUNCTION gtk_layout_get_hadjustment(BYVAL AS GtkLayout PTR) AS GtkAdjustment PTR
DECLARE FUNCTION gtk_layout_get_vadjustment(BYVAL AS GtkLayout PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_layout_set_hadjustment(BYVAL AS GtkLayout PTR, BYVAL AS GtkAdjustment PTR)
DECLARE SUB gtk_layout_set_vadjustment(BYVAL AS GtkLayout PTR, BYVAL AS GtkAdjustment PTR)

#ENDIF ' NOT DEFINED (GT...
#ENDIF ' __GTK_LAYOUT_H__

#IFNDEF __GTK_LINK_BUTTON_H__
#DEFINE __GTK_LINK_BUTTON_H__

#DEFINE GTK_TYPE_LINK_BUTTON (gtk_link_button_get_type ())
#DEFINE GTK_LINK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LINK_BUTTON, GtkLinkButton))
#DEFINE GTK_IS_LINK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LINK_BUTTON))
#DEFINE GTK_LINK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_LINK_BUTTON, GtkLinkButtonClass))
#DEFINE GTK_IS_LINK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LINK_BUTTON))
#DEFINE GTK_LINK_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_LINK_BUTTON, GtkLinkButtonClass))

TYPE GtkLinkButton AS _GtkLinkButton
TYPE GtkLinkButtonClass AS _GtkLinkButtonClass
TYPE GtkLinkButtonPrivate AS _GtkLinkButtonPrivate

TYPE _GtkLinkButton
  AS GtkButton parent_instance
  AS GtkLinkButtonPrivate PTR priv
END TYPE

TYPE _GtkLinkButtonClass
  AS GtkButtonClass parent_class
  activate_link AS FUNCTION(BYVAL AS GtkLinkButton PTR) AS gboolean
  _gtk_padding1 AS SUB()
  _gtk_padding2 AS SUB()
  _gtk_padding3 AS SUB()
  _gtk_padding4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_link_button_get_type() AS GType
DECLARE FUNCTION gtk_link_button_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_link_button_new_with_label(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_link_button_get_uri(BYVAL AS GtkLinkButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_link_button_set_uri(BYVAL AS GtkLinkButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_link_button_get_visited(BYVAL AS GtkLinkButton PTR) AS gboolean
DECLARE SUB gtk_link_button_set_visited(BYVAL AS GtkLinkButton PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_LINK_BUTTON_H__

#IFNDEF __GTK_LOCK_BUTTON_H__
#DEFINE __GTK_LOCK_BUTTON_H__

#DEFINE GTK_TYPE_LOCK_BUTTON (gtk_lock_button_get_type ())
#DEFINE GTK_LOCK_BUTTON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_LOCK_BUTTON, GtkLockButton))
#DEFINE GTK_LOCK_BUTTON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_LOCK_BUTTON, GtkLockButtonClass))
#DEFINE GTK_IS_LOCK_BUTTON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_LOCK_BUTTON))
#DEFINE GTK_IS_LOCK_BUTTON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_LOCK_BUTTON))
#DEFINE GTK_LOCK_BUTTON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_LOCK_BUTTON, GtkLockButtonClass))

TYPE GtkLockButton AS _GtkLockButton
TYPE GtkLockButtonClass AS _GtkLockButtonClass
TYPE GtkLockButtonPrivate AS _GtkLockButtonPrivate

TYPE _GtkLockButton
  AS GtkButton parent
  AS GtkLockButtonPrivate PTR priv
END TYPE

TYPE _GtkLockButtonClass
  AS GtkButtonClass parent_class
  reserved0 AS SUB()
  reserved1 AS SUB()
  reserved2 AS SUB()
  reserved3 AS SUB()
  reserved4 AS SUB()
  reserved5 AS SUB()
  reserved6 AS SUB()
  reserved7 AS SUB()
END TYPE

DECLARE FUNCTION gtk_lock_button_get_type() AS GType
DECLARE FUNCTION gtk_lock_button_new(BYVAL AS GPermission PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_lock_button_get_permission(BYVAL AS GtkLockButton PTR) AS GPermission PTR
DECLARE SUB gtk_lock_button_set_permission(BYVAL AS GtkLockButton PTR, BYVAL AS GPermission PTR)

#ENDIF ' __GTK_LOCK_BUTTON_H__

#IFNDEF __GTK_MAIN_H__
#DEFINE __GTK_MAIN_H__

#DEFINE GTK_PRIORITY_RESIZE (G_PRIORITY_HIGH_IDLE + 10)

TYPE GtkKeySnoopFunc AS FUNCTION(BYVAL AS GtkWidget PTR, BYVAL AS GdkEventKey PTR, BYVAL AS gpointer) AS gint

DECLARE FUNCTION gtk_get_major_version() AS guint
DECLARE FUNCTION gtk_get_minor_version() AS guint
DECLARE FUNCTION gtk_get_micro_version() AS guint
DECLARE FUNCTION gtk_get_binary_age() AS guint
DECLARE FUNCTION gtk_get_interface_age() AS guint

#DEFINE gtk_major_version_ gtk_get_major_version ()
#DEFINE gtk_minor_version_ gtk_get_minor_version ()
#DEFINE gtk_micro_version_ gtk_get_micro_version ()
#DEFINE gtk_binary_age_ gtk_get_binary_age ()
#DEFINE gtk_interface_age_ gtk_get_interface_age ()

DECLARE FUNCTION gtk_check_version_ ALIAS "gtk_check_version"(BYVAL AS guint, BYVAL AS guint, BYVAL AS guint) AS CONST gchar PTR
DECLARE FUNCTION gtk_parse_args(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR) AS gboolean
DECLARE SUB gtk_init(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR)
DECLARE FUNCTION gtk_init_check(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR) AS gboolean
DECLARE FUNCTION gtk_init_with_args(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GOptionEntry PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_get_option_group(BYVAL AS gboolean) AS GOptionGroup PTR

#IFDEF G_OS_WIN32

DECLARE SUB gtk_init_abi_check(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR, BYVAL AS INTEGER, BYVAL AS size_t, BYVAL AS size_t)
DECLARE FUNCTION gtk_init_check_abi_check(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR, BYVAL AS INTEGER, BYVAL AS size_t, BYVAL AS size_t) AS gboolean

#UNDEF gtk_init
#DEFINE gtk_init(argc, argv) gtk_init_abi_check (argc, argv, 2, SIZEOF (GtkWindow), SIZEOF (GtkBox))
#UNDEF gtk_init_check
#DEFINE gtk_init_check(argc, argv) gtk_init_check_abi_check (argc, argv, 2, SIZEOF (GtkWindow), SIZEOF (GtkBox))
#ENDIF ' G_OS_WIN32

DECLARE SUB gtk_disable_setlocale()
DECLARE FUNCTION gtk_get_default_language() AS PangoLanguage PTR
DECLARE FUNCTION gtk_events_pending() AS gboolean
DECLARE SUB gtk_main_do_event(BYVAL AS GdkEvent PTR)
DECLARE SUB gtk_main()
DECLARE FUNCTION gtk_main_level() AS guint
DECLARE SUB gtk_main_quit()
DECLARE FUNCTION gtk_main_iteration() AS gboolean
DECLARE FUNCTION gtk_main_iteration_do(BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_true() AS gboolean
DECLARE FUNCTION gtk_false() AS gboolean
DECLARE SUB gtk_grab_add(BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_grab_get_current() AS GtkWidget PTR
DECLARE SUB gtk_grab_remove(BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_device_grab_add(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR, BYVAL AS gboolean)
DECLARE SUB gtk_device_grab_remove(BYVAL AS GtkWidget PTR, BYVAL AS GdkDevice PTR)
DECLARE FUNCTION gtk_key_snooper_install(BYVAL AS GtkKeySnoopFunc, BYVAL AS gpointer) AS guint
DECLARE SUB gtk_key_snooper_remove(BYVAL AS guint)
DECLARE FUNCTION gtk_get_current_event() AS GdkEvent PTR
DECLARE FUNCTION gtk_get_current_event_time() AS guint32
DECLARE FUNCTION gtk_get_current_event_state(BYVAL AS GdkModifierType PTR) AS gboolean
DECLARE FUNCTION gtk_get_current_event_device() AS GdkDevice PTR
DECLARE FUNCTION gtk_get_event_widget(BYVAL AS GdkEvent PTR) AS GtkWidget PTR
DECLARE SUB gtk_propagate_event(BYVAL AS GtkWidget PTR, BYVAL AS GdkEvent PTR)

#ENDIF ' __GTK_MAIN_H__

#IFNDEF __GTK_MENU_BAR_H__
#DEFINE __GTK_MENU_BAR_H__

#DEFINE GTK_TYPE_MENU_BAR (gtk_menu_bar_get_type ())
#DEFINE GTK_MENU_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MENU_BAR, GtkMenuBar))
#DEFINE GTK_MENU_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MENU_BAR, GtkMenuBarClass))
#DEFINE GTK_IS_MENU_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MENU_BAR))
#DEFINE GTK_IS_MENU_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MENU_BAR))
#DEFINE GTK_MENU_BAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MENU_BAR, GtkMenuBarClass))

TYPE GtkMenuBar AS _GtkMenuBar
TYPE GtkMenuBarPrivate AS _GtkMenuBarPrivate
TYPE GtkMenuBarClass AS _GtkMenuBarClass

TYPE _GtkMenuBar
  AS GtkMenuShell menu_shell
  AS GtkMenuBarPrivate PTR priv
END TYPE

TYPE _GtkMenuBarClass
  AS GtkMenuShellClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_menu_bar_get_type() AS GType
DECLARE FUNCTION gtk_menu_bar_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_menu_bar_get_pack_direction(BYVAL AS GtkMenuBar PTR) AS GtkPackDirection
DECLARE SUB gtk_menu_bar_set_pack_direction(BYVAL AS GtkMenuBar PTR, BYVAL AS GtkPackDirection)
DECLARE FUNCTION gtk_menu_bar_get_child_pack_direction(BYVAL AS GtkMenuBar PTR) AS GtkPackDirection
DECLARE SUB gtk_menu_bar_set_child_pack_direction(BYVAL AS GtkMenuBar PTR, BYVAL AS GtkPackDirection)
DECLARE SUB _gtk_menu_bar_cycle_focus(BYVAL AS GtkMenuBar PTR, BYVAL AS GtkDirectionType)

#ENDIF ' __GTK_MENU_BAR_H__

#IFNDEF __GTK_MENU_TOOL_BUTTON_H__
#DEFINE __GTK_MENU_TOOL_BUTTON_H__

#IFNDEF __GTK_TOOL_BUTTON_H__
#DEFINE __GTK_TOOL_BUTTON_H__

#IFNDEF __GTK_TOOL_ITEM_H__
#DEFINE __GTK_TOOL_ITEM_H__

#IFNDEF __GTK_SIZE_GROUP_H__
#DEFINE __GTK_SIZE_GROUP_H__

#DEFINE GTK_TYPE_SIZE_GROUP (gtk_size_group_get_type ())
#DEFINE GTK_SIZE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroup))
#DEFINE GTK_SIZE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass))
#DEFINE GTK_IS_SIZE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SIZE_GROUP))
#DEFINE GTK_IS_SIZE_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SIZE_GROUP))
#DEFINE GTK_SIZE_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroupClass))

TYPE GtkSizeGroup AS _GtkSizeGroup
TYPE GtkSizeGroupPrivate AS _GtkSizeGroupPrivate
TYPE GtkSizeGroupClass AS _GtkSizeGroupClass

TYPE _GtkSizeGroup
  AS GObject parent_instance
  AS GtkSizeGroupPrivate PTR priv
END TYPE

TYPE _GtkSizeGroupClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

ENUM GtkSizeGroupMode
  GTK_SIZE_GROUP_NONE
  GTK_SIZE_GROUP_HORIZONTAL
  GTK_SIZE_GROUP_VERTICAL
  GTK_SIZE_GROUP_BOTH
END ENUM

DECLARE FUNCTION gtk_size_group_get_type() AS GType
DECLARE FUNCTION gtk_size_group_new(BYVAL AS GtkSizeGroupMode) AS GtkSizeGroup PTR
DECLARE SUB gtk_size_group_set_mode(BYVAL AS GtkSizeGroup PTR, BYVAL AS GtkSizeGroupMode)
DECLARE FUNCTION gtk_size_group_get_mode(BYVAL AS GtkSizeGroup PTR) AS GtkSizeGroupMode
DECLARE SUB gtk_size_group_set_ignore_hidden(BYVAL AS GtkSizeGroup PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_size_group_get_ignore_hidden(BYVAL AS GtkSizeGroup PTR) AS gboolean
DECLARE SUB gtk_size_group_add_widget(BYVAL AS GtkSizeGroup PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_size_group_remove_widget(BYVAL AS GtkSizeGroup PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_size_group_get_widgets(BYVAL AS GtkSizeGroup PTR) AS GSList PTR

#ENDIF ' __GTK_SIZE_GROUP_H__

#DEFINE GTK_TYPE_TOOL_ITEM (gtk_tool_item_get_type ())
#DEFINE GTK_TOOL_ITEM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_TOOL_ITEM, GtkToolItem))
#DEFINE GTK_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOOL_ITEM, GtkToolItemClass))
#DEFINE GTK_IS_TOOL_ITEM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_TOOL_ITEM))
#DEFINE GTK_IS_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOOL_ITEM))
#DEFINE GTK_TOOL_ITEM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS((o), GTK_TYPE_TOOL_ITEM, GtkToolItemClass))

TYPE GtkToolItem AS _GtkToolItem
TYPE GtkToolItemClass AS _GtkToolItemClass
TYPE GtkToolItemPrivate AS _GtkToolItemPrivate

TYPE _GtkToolItem
  AS GtkBin parent
  AS GtkToolItemPrivate PTR priv
END TYPE

TYPE _GtkToolItemClass
  AS GtkBinClass parent_class
  create_menu_proxy AS FUNCTION(BYVAL AS GtkToolItem PTR) AS gboolean
  toolbar_reconfigured AS SUB(BYVAL AS GtkToolItem PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tool_item_get_type() AS GType
DECLARE FUNCTION gtk_tool_item_new() AS GtkToolItem PTR
DECLARE SUB gtk_tool_item_set_homogeneous(BYVAL AS GtkToolItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_item_get_homogeneous(BYVAL AS GtkToolItem PTR) AS gboolean
DECLARE SUB gtk_tool_item_set_expand(BYVAL AS GtkToolItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_item_get_expand(BYVAL AS GtkToolItem PTR) AS gboolean
DECLARE SUB gtk_tool_item_set_tooltip_text(BYVAL AS GtkToolItem PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_tool_item_set_tooltip_markup(BYVAL AS GtkToolItem PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_tool_item_set_use_drag_window(BYVAL AS GtkToolItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_item_get_use_drag_window(BYVAL AS GtkToolItem PTR) AS gboolean
DECLARE SUB gtk_tool_item_set_visible_horizontal(BYVAL AS GtkToolItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_item_get_visible_horizontal(BYVAL AS GtkToolItem PTR) AS gboolean
DECLARE SUB gtk_tool_item_set_visible_vertical(BYVAL AS GtkToolItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_item_get_visible_vertical(BYVAL AS GtkToolItem PTR) AS gboolean
DECLARE FUNCTION gtk_tool_item_get_is_important(BYVAL AS GtkToolItem PTR) AS gboolean
DECLARE SUB gtk_tool_item_set_is_important(BYVAL AS GtkToolItem PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_item_get_ellipsize_mode(BYVAL AS GtkToolItem PTR) AS PangoEllipsizeMode
DECLARE FUNCTION gtk_tool_item_get_icon_size(BYVAL AS GtkToolItem PTR) AS GtkIconSize
DECLARE FUNCTION gtk_tool_item_get_orientation(BYVAL AS GtkToolItem PTR) AS GtkOrientation
DECLARE FUNCTION gtk_tool_item_get_toolbar_style(BYVAL AS GtkToolItem PTR) AS GtkToolbarStyle
DECLARE FUNCTION gtk_tool_item_get_relief_style(BYVAL AS GtkToolItem PTR) AS GtkReliefStyle
DECLARE FUNCTION gtk_tool_item_get_text_alignment(BYVAL AS GtkToolItem PTR) AS gfloat
DECLARE FUNCTION gtk_tool_item_get_text_orientation(BYVAL AS GtkToolItem PTR) AS GtkOrientation
DECLARE FUNCTION gtk_tool_item_get_text_size_group(BYVAL AS GtkToolItem PTR) AS GtkSizeGroup PTR
DECLARE FUNCTION gtk_tool_item_retrieve_proxy_menu_item(BYVAL AS GtkToolItem PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_tool_item_get_proxy_menu_item(BYVAL AS GtkToolItem PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_tool_item_set_proxy_menu_item(BYVAL AS GtkToolItem PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_tool_item_rebuild_menu(BYVAL AS GtkToolItem PTR)
DECLARE SUB gtk_tool_item_toolbar_reconfigured(BYVAL AS GtkToolItem PTR)
DECLARE FUNCTION _gtk_tool_item_create_menu_proxy(BYVAL AS GtkToolItem PTR) AS gboolean

#ENDIF ' __GTK_TOOL_ITEM_H__

#DEFINE GTK_TYPE_TOOL_BUTTON (gtk_tool_button_get_type ())
#DEFINE GTK_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOL_BUTTON, GtkToolButton))
#DEFINE GTK_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOOL_BUTTON, GtkToolButtonClass))
#DEFINE GTK_IS_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOL_BUTTON))
#DEFINE GTK_IS_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOOL_BUTTON))
#DEFINE GTK_TOOL_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOOL_BUTTON, GtkToolButtonClass))

TYPE GtkToolButton AS _GtkToolButton
TYPE GtkToolButtonClass AS _GtkToolButtonClass
TYPE GtkToolButtonPrivate AS _GtkToolButtonPrivate

TYPE _GtkToolButton
  AS GtkToolItem parent
  AS GtkToolButtonPrivate PTR priv
END TYPE

TYPE _GtkToolButtonClass
  AS GtkToolItemClass parent_class
  AS GType button_type
  clicked AS SUB(BYVAL AS GtkToolButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tool_button_get_type() AS GType
DECLARE FUNCTION gtk_tool_button_new(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE FUNCTION gtk_tool_button_new_from_stock(BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE SUB gtk_tool_button_set_label(BYVAL AS GtkToolButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_tool_button_get_label(BYVAL AS GtkToolButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_tool_button_set_use_underline(BYVAL AS GtkToolButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_button_get_use_underline(BYVAL AS GtkToolButton PTR) AS gboolean
DECLARE SUB gtk_tool_button_set_stock_id(BYVAL AS GtkToolButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_tool_button_get_stock_id(BYVAL AS GtkToolButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_tool_button_set_icon_name(BYVAL AS GtkToolButton PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_tool_button_get_icon_name(BYVAL AS GtkToolButton PTR) AS CONST gchar PTR
DECLARE SUB gtk_tool_button_set_icon_widget(BYVAL AS GtkToolButton PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_tool_button_get_icon_widget(BYVAL AS GtkToolButton PTR) AS GtkWidget PTR
DECLARE SUB gtk_tool_button_set_label_widget(BYVAL AS GtkToolButton PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_tool_button_get_label_widget(BYVAL AS GtkToolButton PTR) AS GtkWidget PTR
DECLARE FUNCTION _gtk_tool_button_get_button(BYVAL AS GtkToolButton PTR) AS GtkWidget PTR

#ENDIF ' __GTK_TOOL_BUTTON_H__

#DEFINE GTK_TYPE_MENU_TOOL_BUTTON (gtk_menu_tool_button_get_type ())
#DEFINE GTK_MENU_TOOL_BUTTON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButton))
#DEFINE GTK_MENU_TOOL_BUTTON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButtonClass))
#DEFINE GTK_IS_MENU_TOOL_BUTTON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_MENU_TOOL_BUTTON))
#DEFINE GTK_IS_MENU_TOOL_BUTTON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_MENU_TOOL_BUTTON))
#DEFINE GTK_MENU_TOOL_BUTTON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_MENU_TOOL_BUTTON, GtkMenuToolButtonClass))

TYPE GtkMenuToolButtonClass AS _GtkMenuToolButtonClass
TYPE GtkMenuToolButton AS _GtkMenuToolButton
TYPE GtkMenuToolButtonPrivate AS _GtkMenuToolButtonPrivate

TYPE _GtkMenuToolButton
  AS GtkToolButton parent
  AS GtkMenuToolButtonPrivate PTR priv
END TYPE

TYPE _GtkMenuToolButtonClass
  AS GtkToolButtonClass parent_class
  show_menu AS SUB(BYVAL AS GtkMenuToolButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_menu_tool_button_get_type() AS GType
DECLARE FUNCTION gtk_menu_tool_button_new(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE FUNCTION gtk_menu_tool_button_new_from_stock(BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE SUB gtk_menu_tool_button_set_menu(BYVAL AS GtkMenuToolButton PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_menu_tool_button_get_menu(BYVAL AS GtkMenuToolButton PTR) AS GtkWidget PTR
DECLARE SUB gtk_menu_tool_button_set_arrow_tooltip_text(BYVAL AS GtkMenuToolButton PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_menu_tool_button_set_arrow_tooltip_markup(BYVAL AS GtkMenuToolButton PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_MENU_TOOL_BUTTON_H__

#IFNDEF __GTK_MESSAGE_DIALOG_H__
#DEFINE __GTK_MESSAGE_DIALOG_H__

#DEFINE GTK_TYPE_MESSAGE_DIALOG (gtk_message_dialog_get_type ())
#DEFINE GTK_MESSAGE_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialog))
#DEFINE GTK_MESSAGE_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialogClass))
#DEFINE GTK_IS_MESSAGE_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MESSAGE_DIALOG))
#DEFINE GTK_IS_MESSAGE_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_MESSAGE_DIALOG))
#DEFINE GTK_MESSAGE_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_MESSAGE_DIALOG, GtkMessageDialogClass))

TYPE GtkMessageDialog AS _GtkMessageDialog
TYPE GtkMessageDialogPrivate AS _GtkMessageDialogPrivate
TYPE GtkMessageDialogClass AS _GtkMessageDialogClass

TYPE _GtkMessageDialog
  AS GtkDialog parent_instance
  AS GtkMessageDialogPrivate PTR priv
END TYPE

TYPE _GtkMessageDialogClass
  AS GtkDialogClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

ENUM GtkButtonsType
  GTK_BUTTONS_NONE
  GTK_BUTTONS_OK
  GTK_BUTTONS_CLOSE
  GTK_BUTTONS_CANCEL
  GTK_BUTTONS_YES_NO
  GTK_BUTTONS_OK_CANCEL
END ENUM

DECLARE FUNCTION gtk_message_dialog_get_type() AS GType
DECLARE FUNCTION gtk_message_dialog_new(BYVAL AS GtkWindow PTR, BYVAL AS GtkDialogFlags, BYVAL AS GtkMessageType, BYVAL AS GtkButtonsType, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE FUNCTION gtk_message_dialog_new_with_markup(BYVAL AS GtkWindow PTR, BYVAL AS GtkDialogFlags, BYVAL AS GtkMessageType, BYVAL AS GtkButtonsType, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE SUB gtk_message_dialog_set_image(BYVAL AS GtkMessageDialog PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_message_dialog_get_image(BYVAL AS GtkMessageDialog PTR) AS GtkWidget PTR
DECLARE SUB gtk_message_dialog_set_markup(BYVAL AS GtkMessageDialog PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_message_dialog_format_secondary_text(BYVAL AS GtkMessageDialog PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_message_dialog_format_secondary_markup(BYVAL AS GtkMessageDialog PTR, BYVAL AS CONST gchar PTR, ...)
DECLARE FUNCTION gtk_message_dialog_get_message_area(BYVAL AS GtkMessageDialog PTR) AS GtkWidget PTR

#ENDIF ' __GTK_MESSAGE_DIALOG_H__

#IFNDEF __GTK_MODULES_H__
#DEFINE __GTK_MODULES_H__

TYPE GtkModuleInitFunc AS SUB(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR)
TYPE GtkModuleDisplayInitFunc AS SUB(BYVAL AS GdkDisplay PTR)

#ENDIF ' __GTK_MODULES_H__

#IFNDEF __GTK_MOUNT_OPERATION_H__
#DEFINE __GTK_MOUNT_OPERATION_H__
#DEFINE GTK_TYPE_MOUNT_OPERATION (gtk_mount_operation_get_type ())
#DEFINE GTK_MOUNT_OPERATION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_MOUNT_OPERATION, GtkMountOperation))
#DEFINE GTK_MOUNT_OPERATION_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_MOUNT_OPERATION, GtkMountOperationClass))
#DEFINE GTK_IS_MOUNT_OPERATION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_MOUNT_OPERATION))
#DEFINE GTK_IS_MOUNT_OPERATION_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_MOUNT_OPERATION))
#DEFINE GTK_MOUNT_OPERATION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_MOUNT_OPERATION, GtkMountOperationClass))

TYPE GtkMountOperation AS _GtkMountOperation
TYPE GtkMountOperationClass AS _GtkMountOperationClass
TYPE GtkMountOperationPrivate AS _GtkMountOperationPrivate

TYPE _GtkMountOperation
  AS GMountOperation parent_instance
  AS GtkMountOperationPrivate PTR priv
END TYPE

TYPE _GtkMountOperationClass
  AS GMountOperationClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_mount_operation_get_type() AS GType
DECLARE FUNCTION gtk_mount_operation_new(BYVAL AS GtkWindow PTR) AS GMountOperation PTR
DECLARE FUNCTION gtk_mount_operation_is_showing(BYVAL AS GtkMountOperation PTR) AS gboolean
DECLARE SUB gtk_mount_operation_set_parent(BYVAL AS GtkMountOperation PTR, BYVAL AS GtkWindow PTR)
DECLARE FUNCTION gtk_mount_operation_get_parent(BYVAL AS GtkMountOperation PTR) AS GtkWindow PTR
DECLARE SUB gtk_mount_operation_set_screen(BYVAL AS GtkMountOperation PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gtk_mount_operation_get_screen(BYVAL AS GtkMountOperation PTR) AS GdkScreen PTR

#ENDIF ' __GTK_MOUNT_OPERATION_H__

#IFNDEF __GTK_NOTEBOOK_H__
#DEFINE __GTK_NOTEBOOK_H__

#DEFINE GTK_TYPE_NOTEBOOK (gtk_notebook_get_type ())
#DEFINE GTK_NOTEBOOK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_NOTEBOOK, GtkNotebook))
#DEFINE GTK_NOTEBOOK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_NOTEBOOK, GtkNotebookClass))
#DEFINE GTK_IS_NOTEBOOK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_NOTEBOOK))
#DEFINE GTK_IS_NOTEBOOK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_NOTEBOOK))
#DEFINE GTK_NOTEBOOK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_NOTEBOOK, GtkNotebookClass))

ENUM GtkNotebookTab
  GTK_NOTEBOOK_TAB_FIRST
  GTK_NOTEBOOK_TAB_LAST
END ENUM

TYPE GtkNotebook AS _GtkNotebook
TYPE GtkNotebookPrivate AS _GtkNotebookPrivate
TYPE GtkNotebookClass AS _GtkNotebookClass

TYPE _GtkNotebook
  AS GtkContainer container
  AS GtkNotebookPrivate PTR priv
END TYPE

TYPE _GtkNotebookClass
  AS GtkContainerClass parent_class
  switch_page AS SUB(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint)
  select_page AS FUNCTION(BYVAL AS GtkNotebook PTR, BYVAL AS gboolean) AS gboolean
  focus_tab AS FUNCTION(BYVAL AS GtkNotebook PTR, BYVAL AS GtkNotebookTab) AS gboolean
  change_current_page AS FUNCTION(BYVAL AS GtkNotebook PTR, BYVAL AS gint) AS gboolean
  move_focus_out AS SUB(BYVAL AS GtkNotebook PTR, BYVAL AS GtkDirectionType)
  reorder_tab AS FUNCTION(BYVAL AS GtkNotebook PTR, BYVAL AS GtkDirectionType, BYVAL AS gboolean) AS gboolean
  insert_page AS FUNCTION(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint) AS gint
  create_window AS FUNCTION(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint) AS GtkNotebook PTR
  page_reordered AS SUB(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint)
  page_removed AS SUB(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint)
  page_added AS SUB(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_notebook_get_type() AS GType
DECLARE FUNCTION gtk_notebook_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_notebook_append_page(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_notebook_append_page_menu(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_notebook_prepend_page(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_notebook_prepend_page_menu(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE FUNCTION gtk_notebook_insert_page(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gtk_notebook_insert_page_menu(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint) AS gint
DECLARE SUB gtk_notebook_remove_page(BYVAL AS GtkNotebook PTR, BYVAL AS gint)
DECLARE SUB gtk_notebook_set_group_name(BYVAL AS GtkNotebook PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_notebook_get_group_name(BYVAL AS GtkNotebook PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_notebook_get_current_page(BYVAL AS GtkNotebook PTR) AS gint
DECLARE FUNCTION gtk_notebook_get_nth_page(BYVAL AS GtkNotebook PTR, BYVAL AS gint) AS GtkWidget PTR
DECLARE FUNCTION gtk_notebook_get_n_pages(BYVAL AS GtkNotebook PTR) AS gint
DECLARE FUNCTION gtk_notebook_page_num(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS gint
DECLARE SUB gtk_notebook_set_current_page(BYVAL AS GtkNotebook PTR, BYVAL AS gint)
DECLARE SUB gtk_notebook_next_page(BYVAL AS GtkNotebook PTR)
DECLARE SUB gtk_notebook_prev_page(BYVAL AS GtkNotebook PTR)
DECLARE SUB gtk_notebook_set_show_border(BYVAL AS GtkNotebook PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_notebook_get_show_border(BYVAL AS GtkNotebook PTR) AS gboolean
DECLARE SUB gtk_notebook_set_show_tabs(BYVAL AS GtkNotebook PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_notebook_get_show_tabs(BYVAL AS GtkNotebook PTR) AS gboolean
DECLARE SUB gtk_notebook_set_tab_pos(BYVAL AS GtkNotebook PTR, BYVAL AS GtkPositionType)
DECLARE FUNCTION gtk_notebook_get_tab_pos(BYVAL AS GtkNotebook PTR) AS GtkPositionType
DECLARE SUB gtk_notebook_set_scrollable(BYVAL AS GtkNotebook PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_notebook_get_scrollable(BYVAL AS GtkNotebook PTR) AS gboolean
DECLARE FUNCTION gtk_notebook_get_tab_hborder(BYVAL AS GtkNotebook PTR) AS guint16
DECLARE FUNCTION gtk_notebook_get_tab_vborder(BYVAL AS GtkNotebook PTR) AS guint16
DECLARE SUB gtk_notebook_popup_enable(BYVAL AS GtkNotebook PTR)
DECLARE SUB gtk_notebook_popup_disable(BYVAL AS GtkNotebook PTR)
DECLARE FUNCTION gtk_notebook_get_tab_label(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS GtkWidget PTR
DECLARE SUB gtk_notebook_set_tab_label(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_notebook_set_tab_label_text(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_notebook_get_tab_label_text(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_notebook_get_menu_label(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS GtkWidget PTR
DECLARE SUB gtk_notebook_set_menu_label(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_notebook_set_menu_label_text(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_notebook_get_menu_label_text(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS CONST gchar PTR
DECLARE SUB gtk_notebook_reorder_child(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_notebook_get_tab_reorderable(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_notebook_set_tab_reorderable(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_notebook_get_tab_detachable(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR) AS gboolean
DECLARE SUB gtk_notebook_set_tab_detachable(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_notebook_get_action_widget(BYVAL AS GtkNotebook PTR, BYVAL AS GtkPackType) AS GtkWidget PTR
DECLARE SUB gtk_notebook_set_action_widget(BYVAL AS GtkNotebook PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkPackType)

#ENDIF ' __GTK_NOTEBOOK_H__

#IFNDEF __GTK_NUMERABLE_ICON_H__
#DEFINE __GTK_NUMERABLE_ICON_H__

#DEFINE GTK_TYPE_NUMERABLE_ICON (gtk_numerable_icon_get_type ())
#DEFINE GTK_NUMERABLE_ICON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_NUMERABLE_ICON, GtkNumerableIcon))
#DEFINE GTK_NUMERABLE_ICON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_NUMERABLE_ICON, GtkNumerableIconClass))
#DEFINE GTK_IS_NUMERABLE_ICON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_NUMERABLE_ICON))
#DEFINE GTK_IS_NUMERABLE_ICON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_NUMERABLE_ICON))
#DEFINE GTK_NUMERABLE_ICON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_NUMERABLE_ICON, GtkNumerableIconClass))

TYPE GtkNumerableIcon AS _GtkNumerableIcon
TYPE GtkNumerableIconClass AS _GtkNumerableIconClass
TYPE GtkNumerableIconPrivate AS _GtkNumerableIconPrivate

TYPE _GtkNumerableIcon
  AS GEmblemedIcon parent
  AS GtkNumerableIconPrivate PTR priv
END TYPE

TYPE _GtkNumerableIconClass
  AS GEmblemedIconClass parent_class
  AS gpointer padding(15)
END TYPE

DECLARE FUNCTION gtk_numerable_icon_get_type() AS GType
DECLARE FUNCTION gtk_numerable_icon_new(BYVAL AS GIcon PTR) AS GIcon PTR
DECLARE FUNCTION gtk_numerable_icon_new_with_style_context(BYVAL AS GIcon PTR, BYVAL AS GtkStyleContext PTR) AS GIcon PTR
DECLARE FUNCTION gtk_numerable_icon_get_style_context(BYVAL AS GtkNumerableIcon PTR) AS GtkStyleContext PTR
DECLARE SUB gtk_numerable_icon_set_style_context(BYVAL AS GtkNumerableIcon PTR, BYVAL AS GtkStyleContext PTR)
DECLARE FUNCTION gtk_numerable_icon_get_count(BYVAL AS GtkNumerableIcon PTR) AS gint
DECLARE SUB gtk_numerable_icon_set_count(BYVAL AS GtkNumerableIcon PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_numerable_icon_get_label(BYVAL AS GtkNumerableIcon PTR) AS CONST gchar PTR
DECLARE SUB gtk_numerable_icon_set_label(BYVAL AS GtkNumerableIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_numerable_icon_set_background_gicon(BYVAL AS GtkNumerableIcon PTR, BYVAL AS GIcon PTR)
DECLARE FUNCTION gtk_numerable_icon_get_background_gicon(BYVAL AS GtkNumerableIcon PTR) AS GIcon PTR
DECLARE SUB gtk_numerable_icon_set_background_icon_name(BYVAL AS GtkNumerableIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_numerable_icon_get_background_icon_name(BYVAL AS GtkNumerableIcon PTR) AS CONST gchar PTR

#ENDIF ' __GTK_NUMERABLE_ICON_H__

#IFNDEF __GTK_OFFSCREEN_WINDOW_H__
#DEFINE __GTK_OFFSCREEN_WINDOW_H__

#DEFINE GTK_TYPE_OFFSCREEN_WINDOW (gtk_offscreen_window_get_type ())
#DEFINE GTK_OFFSCREEN_WINDOW(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_OFFSCREEN_WINDOW, GtkOffscreenWindow))
#DEFINE GTK_OFFSCREEN_WINDOW_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_OFFSCREEN_WINDOW, GtkOffscreenWindowClass))
#DEFINE GTK_IS_OFFSCREEN_WINDOW(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_OFFSCREEN_WINDOW))
#DEFINE GTK_IS_OFFSCREEN_WINDOW_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_OFFSCREEN_WINDOW))
#DEFINE GTK_OFFSCREEN_WINDOW_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_OFFSCREEN_WINDOW, GtkOffscreenWindowClass))

TYPE GtkOffscreenWindow AS _GtkOffscreenWindow
TYPE GtkOffscreenWindowClass AS _GtkOffscreenWindowClass

TYPE _GtkOffscreenWindow
  AS GtkWindow parent_object
END TYPE

TYPE _GtkOffscreenWindowClass
  AS GtkWindowClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_offscreen_window_get_type() AS GType
DECLARE FUNCTION gtk_offscreen_window_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_offscreen_window_get_surface(BYVAL AS GtkOffscreenWindow PTR) AS cairo_surface_t PTR
DECLARE FUNCTION gtk_offscreen_window_get_pixbuf(BYVAL AS GtkOffscreenWindow PTR) AS GdkPixbuf PTR

#ENDIF ' __GTK_OFFSCREEN_WINDOW_H__

#IFNDEF __GTK_ORIENTABLE_H__
#DEFINE __GTK_ORIENTABLE_H__

#DEFINE GTK_TYPE_ORIENTABLE (gtk_orientable_get_type ())
#DEFINE GTK_ORIENTABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ORIENTABLE, GtkOrientable))
#DEFINE GTK_ORIENTABLE_CLASS(vtable) (G_TYPE_CHECK_CLASS_CAST ((vtable), GTK_TYPE_ORIENTABLE, GtkOrientableIface))
#DEFINE GTK_IS_ORIENTABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ORIENTABLE))
#DEFINE GTK_IS_ORIENTABLE_CLASS(vtable) (G_TYPE_CHECK_CLASS_TYPE ((vtable), GTK_TYPE_ORIENTABLE))
#DEFINE GTK_ORIENTABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_ORIENTABLE, GtkOrientableIface))

TYPE GtkOrientable AS _GtkOrientable
TYPE GtkOrientableIface AS _GtkOrientableIface

TYPE _GtkOrientableIface
  AS GTypeInterface base_iface
END TYPE

DECLARE FUNCTION gtk_orientable_get_type() AS GType
DECLARE SUB gtk_orientable_set_orientation(BYVAL AS GtkOrientable PTR, BYVAL AS GtkOrientation)
DECLARE FUNCTION gtk_orientable_get_orientation(BYVAL AS GtkOrientable PTR) AS GtkOrientation

#ENDIF ' __GTK_ORIENTABLE_H__

#IFNDEF __GTK_OVERLAY_H__
#DEFINE __GTK_OVERLAY_H__

#DEFINE GTK_TYPE_OVERLAY (gtk_overlay_get_type ())
#DEFINE GTK_OVERLAY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_OVERLAY, GtkOverlay))
#DEFINE GTK_OVERLAY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_OVERLAY, GtkOverlayClass))
#DEFINE GTK_IS_OVERLAY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_OVERLAY))
#DEFINE GTK_IS_OVERLAY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_OVERLAY))
#DEFINE GTK_OVERLAY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_OVERLAY, GtkOverlayClass))

TYPE GtkOverlay AS _GtkOverlay
TYPE GtkOverlayClass AS _GtkOverlayClass
TYPE GtkOverlayPrivate AS _GtkOverlayPrivate

TYPE _GtkOverlay
  AS GtkBin parent
  AS GtkOverlayPrivate PTR priv
END TYPE

TYPE _GtkOverlayClass
  AS GtkBinClass parent_class
  get_child_position AS FUNCTION(BYVAL AS GtkOverlay PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkAllocation PTR) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_overlay_get_type() AS GType
DECLARE FUNCTION gtk_overlay_new() AS GtkWidget PTR
DECLARE SUB gtk_overlay_add_overlay(BYVAL AS GtkOverlay PTR, BYVAL AS GtkWidget PTR)

#ENDIF ' __GTK_OVERLAY_H__

#IFNDEF __GTK_PAGE_SETUP_H__
#DEFINE __GTK_PAGE_SETUP_H__

#IFNDEF __GTK_PAPER_SIZE_H__
#DEFINE __GTK_PAPER_SIZE_H__

TYPE GtkPaperSize AS _GtkPaperSize

#DEFINE GTK_TYPE_PAPER_SIZE (gtk_paper_size_get_type ())
#DEFINE GTK_PAPER_NAME_A3 !"iso_a3"
#DEFINE GTK_PAPER_NAME_A4 !"iso_a4"
#DEFINE GTK_PAPER_NAME_A5 !"iso_a5"
#DEFINE GTK_PAPER_NAME_B5 !"iso_b5"
#DEFINE GTK_PAPER_NAME_LETTER !"na_letter"
#DEFINE GTK_PAPER_NAME_EXECUTIVE !"na_executive"
#DEFINE GTK_PAPER_NAME_LEGAL !"na_legal"

DECLARE FUNCTION gtk_paper_size_get_type() AS GType
DECLARE FUNCTION gtk_paper_size_new(BYVAL AS CONST gchar PTR) AS GtkPaperSize PTR
DECLARE FUNCTION gtk_paper_size_new_from_ppd(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkPaperSize PTR
DECLARE FUNCTION gtk_paper_size_new_custom(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkUnit) AS GtkPaperSize PTR
DECLARE FUNCTION gtk_paper_size_copy(BYVAL AS GtkPaperSize PTR) AS GtkPaperSize PTR
DECLARE SUB gtk_paper_size_free(BYVAL AS GtkPaperSize PTR)
DECLARE FUNCTION gtk_paper_size_is_equal(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkPaperSize PTR) AS gboolean
DECLARE FUNCTION gtk_paper_size_get_paper_sizes(BYVAL AS gboolean) AS GList PTR
DECLARE FUNCTION gtk_paper_size_get_name(BYVAL AS GtkPaperSize PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_paper_size_get_display_name(BYVAL AS GtkPaperSize PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_paper_size_get_ppd_name(BYVAL AS GtkPaperSize PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_paper_size_get_width(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_paper_size_get_height(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_paper_size_is_custom(BYVAL AS GtkPaperSize PTR) AS gboolean
DECLARE SUB gtk_paper_size_set_size(BYVAL AS GtkPaperSize PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_paper_size_get_default_top_margin(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_paper_size_get_default_bottom_margin(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_paper_size_get_default_left_margin(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_paper_size_get_default_right_margin(BYVAL AS GtkPaperSize PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_paper_size_get_default() AS CONST gchar PTR
DECLARE FUNCTION gtk_paper_size_new_from_key_file(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GtkPaperSize PTR
DECLARE SUB gtk_paper_size_to_key_file(BYVAL AS GtkPaperSize PTR, BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_PAPER_SIZE_H__

TYPE GtkPageSetup AS _GtkPageSetup

#DEFINE GTK_TYPE_PAGE_SETUP (gtk_page_setup_get_type ())
#DEFINE GTK_PAGE_SETUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PAGE_SETUP, GtkPageSetup))
#DEFINE GTK_IS_PAGE_SETUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PAGE_SETUP))

DECLARE FUNCTION gtk_page_setup_get_type() AS GType
DECLARE FUNCTION gtk_page_setup_new() AS GtkPageSetup PTR
DECLARE FUNCTION gtk_page_setup_copy(BYVAL AS GtkPageSetup PTR) AS GtkPageSetup PTR
DECLARE FUNCTION gtk_page_setup_get_orientation(BYVAL AS GtkPageSetup PTR) AS GtkPageOrientation
DECLARE SUB gtk_page_setup_set_orientation(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkPageOrientation)
DECLARE FUNCTION gtk_page_setup_get_paper_size(BYVAL AS GtkPageSetup PTR) AS GtkPaperSize PTR
DECLARE SUB gtk_page_setup_set_paper_size(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkPaperSize PTR)
DECLARE FUNCTION gtk_page_setup_get_top_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_page_setup_set_top_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_page_setup_get_bottom_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_page_setup_set_bottom_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_page_setup_get_left_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_page_setup_set_left_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_page_setup_get_right_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_page_setup_set_right_margin(BYVAL AS GtkPageSetup PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE SUB gtk_page_setup_set_paper_size_and_default_margins(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkPaperSize PTR)
DECLARE FUNCTION gtk_page_setup_get_paper_width(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_page_setup_get_paper_height(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_page_setup_get_page_width(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_page_setup_get_page_height(BYVAL AS GtkPageSetup PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE FUNCTION gtk_page_setup_new_from_file(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GtkPageSetup PTR
DECLARE FUNCTION gtk_page_setup_load_file(BYVAL AS GtkPageSetup PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_page_setup_to_file(BYVAL AS GtkPageSetup PTR, BYVAL AS CONST ZSTRING PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_page_setup_new_from_key_file(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GtkPageSetup PTR
DECLARE FUNCTION gtk_page_setup_load_key_file(BYVAL AS GtkPageSetup PTR, BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB gtk_page_setup_to_key_file(BYVAL AS GtkPageSetup PTR, BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_PAGE_SETUP_H__

#IFNDEF __GTK_PRINT_CONTEXT_H__
#DEFINE __GTK_PRINT_CONTEXT_H__
#INCLUDE ONCE "pango/pango.bi"

TYPE GtkPrintContext AS _GtkPrintContext

#DEFINE GTK_TYPE_PRINT_CONTEXT (gtk_print_context_get_type ())
#DEFINE GTK_PRINT_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_CONTEXT, GtkPrintContext))
#DEFINE GTK_IS_PRINT_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_CONTEXT))

DECLARE FUNCTION gtk_print_context_get_type() AS GType
DECLARE FUNCTION gtk_print_context_get_cairo_context(BYVAL AS GtkPrintContext PTR) AS cairo_t PTR
DECLARE FUNCTION gtk_print_context_get_page_setup(BYVAL AS GtkPrintContext PTR) AS GtkPageSetup PTR
DECLARE FUNCTION gtk_print_context_get_width(BYVAL AS GtkPrintContext PTR) AS gdouble
DECLARE FUNCTION gtk_print_context_get_height(BYVAL AS GtkPrintContext PTR) AS gdouble
DECLARE FUNCTION gtk_print_context_get_dpi_x(BYVAL AS GtkPrintContext PTR) AS gdouble
DECLARE FUNCTION gtk_print_context_get_dpi_y(BYVAL AS GtkPrintContext PTR) AS gdouble
DECLARE FUNCTION gtk_print_context_get_hard_margins(BYVAL AS GtkPrintContext PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gtk_print_context_get_pango_fontmap(BYVAL AS GtkPrintContext PTR) AS PangoFontMap PTR
DECLARE FUNCTION gtk_print_context_create_pango_context(BYVAL AS GtkPrintContext PTR) AS PangoContext PTR
DECLARE FUNCTION gtk_print_context_create_pango_layout(BYVAL AS GtkPrintContext PTR) AS PangoLayout PTR
DECLARE SUB gtk_print_context_set_cairo_context(BYVAL AS GtkPrintContext PTR, BYVAL AS cairo_t PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)

#ENDIF ' __GTK_PRINT_CONTEXT_H__

#IFNDEF __GTK_PRINT_OPERATION_H__
#DEFINE __GTK_PRINT_OPERATION_H__
#INCLUDE ONCE "cairo/cairo.bi"

#IFNDEF __GTK_PRINT_SETTINGS_H__
#DEFINE __GTK_PRINT_SETTINGS_H__

TYPE GtkPrintSettings AS _GtkPrintSettings

#DEFINE GTK_TYPE_PRINT_SETTINGS (gtk_print_settings_get_type ())
#DEFINE GTK_PRINT_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_SETTINGS, GtkPrintSettings))
#DEFINE GTK_IS_PRINT_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_SETTINGS))

TYPE GtkPrintSettingsFunc AS SUB(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer)
TYPE GtkPageRange AS _GtkPageRange

TYPE _GtkPageRange
  AS gint start
  AS gint end
END TYPE

DECLARE FUNCTION gtk_print_settings_get_type() AS GType
DECLARE FUNCTION gtk_print_settings_new() AS GtkPrintSettings PTR
DECLARE FUNCTION gtk_print_settings_copy(BYVAL AS GtkPrintSettings PTR) AS GtkPrintSettings PTR
DECLARE FUNCTION gtk_print_settings_new_from_file(BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GtkPrintSettings PTR
DECLARE FUNCTION gtk_print_settings_load_file(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_print_settings_to_file(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_print_settings_new_from_key_file(BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GtkPrintSettings PTR
DECLARE FUNCTION gtk_print_settings_load_key_file(BYVAL AS GtkPrintSettings PTR, BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB gtk_print_settings_to_key_file(BYVAL AS GtkPrintSettings PTR, BYVAL AS GKeyFile PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_settings_has_key(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_print_settings_get(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_print_settings_unset(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_print_settings_foreach(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPrintSettingsFunc, BYVAL AS gpointer)
DECLARE FUNCTION gtk_print_settings_get_bool(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE SUB gtk_print_settings_set_bool(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_settings_get_double(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR) AS gdouble
DECLARE FUNCTION gtk_print_settings_get_double_with_default(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble) AS gdouble
DECLARE SUB gtk_print_settings_set_double(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_print_settings_get_length(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_print_settings_set_length(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_print_settings_get_int(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION gtk_print_settings_get_int_with_default(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gint
DECLARE SUB gtk_print_settings_set_int(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)

#DEFINE GTK_PRINT_SETTINGS_PRINTER !"printer"
#DEFINE GTK_PRINT_SETTINGS_ORIENTATION !"orientation"
#DEFINE GTK_PRINT_SETTINGS_PAPER_FORMAT !"paper-format"
#DEFINE GTK_PRINT_SETTINGS_PAPER_WIDTH !"paper-width"
#DEFINE GTK_PRINT_SETTINGS_PAPER_HEIGHT !"paper-height"
#DEFINE GTK_PRINT_SETTINGS_N_COPIES !"n-copies"
#DEFINE GTK_PRINT_SETTINGS_DEFAULT_SOURCE !"default-source"
#DEFINE GTK_PRINT_SETTINGS_QUALITY !"quality"
#DEFINE GTK_PRINT_SETTINGS_RESOLUTION !"resolution"
#DEFINE GTK_PRINT_SETTINGS_USE_COLOR !"use-color"
#DEFINE GTK_PRINT_SETTINGS_DUPLEX !"duplex"
#DEFINE GTK_PRINT_SETTINGS_COLLATE !"collate"
#DEFINE GTK_PRINT_SETTINGS_REVERSE !"reverse"
#DEFINE GTK_PRINT_SETTINGS_MEDIA_TYPE !"media-type"
#DEFINE GTK_PRINT_SETTINGS_DITHER !"dither"
#DEFINE GTK_PRINT_SETTINGS_SCALE !"scale"
#DEFINE GTK_PRINT_SETTINGS_PRINT_PAGES !"print-pages"
#DEFINE GTK_PRINT_SETTINGS_PAGE_RANGES !"page-ranges"
#DEFINE GTK_PRINT_SETTINGS_PAGE_SET !"page-set"
#DEFINE GTK_PRINT_SETTINGS_FINISHINGS !"finishings"
#DEFINE GTK_PRINT_SETTINGS_NUMBER_UP !"number-up"
#DEFINE GTK_PRINT_SETTINGS_NUMBER_UP_LAYOUT !"number-up-layout"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_BIN !"output-bin"
#DEFINE GTK_PRINT_SETTINGS_RESOLUTION_X !"resolution-x"
#DEFINE GTK_PRINT_SETTINGS_RESOLUTION_Y !"resolution-y"
#DEFINE GTK_PRINT_SETTINGS_PRINTER_LPI !"printer-lpi"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_FILE_FORMAT !"output-file-format"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_URI !"output-uri"
#DEFINE GTK_PRINT_SETTINGS_WIN32_DRIVER_VERSION !"win32-driver-version"
#DEFINE GTK_PRINT_SETTINGS_WIN32_DRIVER_EXTRA !"win32-driver-extra"

DECLARE FUNCTION gtk_print_settings_get_printer(BYVAL AS GtkPrintSettings PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set_printer(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_settings_get_orientation(BYVAL AS GtkPrintSettings PTR) AS GtkPageOrientation
DECLARE SUB gtk_print_settings_set_orientation(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPageOrientation)
DECLARE FUNCTION gtk_print_settings_get_paper_size(BYVAL AS GtkPrintSettings PTR) AS GtkPaperSize PTR
DECLARE SUB gtk_print_settings_set_paper_size(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPaperSize PTR)
DECLARE FUNCTION gtk_print_settings_get_paper_width(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_print_settings_set_paper_width(BYVAL AS GtkPrintSettings PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_print_settings_get_paper_height(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkUnit) AS gdouble
DECLARE SUB gtk_print_settings_set_paper_height(BYVAL AS GtkPrintSettings PTR, BYVAL AS gdouble, BYVAL AS GtkUnit)
DECLARE FUNCTION gtk_print_settings_get_use_color(BYVAL AS GtkPrintSettings PTR) AS gboolean
DECLARE SUB gtk_print_settings_set_use_color(BYVAL AS GtkPrintSettings PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_settings_get_collate(BYVAL AS GtkPrintSettings PTR) AS gboolean
DECLARE SUB gtk_print_settings_set_collate(BYVAL AS GtkPrintSettings PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_settings_get_reverse(BYVAL AS GtkPrintSettings PTR) AS gboolean
DECLARE SUB gtk_print_settings_set_reverse(BYVAL AS GtkPrintSettings PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_settings_get_duplex(BYVAL AS GtkPrintSettings PTR) AS GtkPrintDuplex
DECLARE SUB gtk_print_settings_set_duplex(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPrintDuplex)
DECLARE FUNCTION gtk_print_settings_get_quality(BYVAL AS GtkPrintSettings PTR) AS GtkPrintQuality
DECLARE SUB gtk_print_settings_set_quality(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPrintQuality)
DECLARE FUNCTION gtk_print_settings_get_n_copies(BYVAL AS GtkPrintSettings PTR) AS gint
DECLARE SUB gtk_print_settings_set_n_copies(BYVAL AS GtkPrintSettings PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_print_settings_get_number_up(BYVAL AS GtkPrintSettings PTR) AS gint
DECLARE SUB gtk_print_settings_set_number_up(BYVAL AS GtkPrintSettings PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_print_settings_get_number_up_layout(BYVAL AS GtkPrintSettings PTR) AS GtkNumberUpLayout
DECLARE SUB gtk_print_settings_set_number_up_layout(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkNumberUpLayout)
DECLARE FUNCTION gtk_print_settings_get_resolution(BYVAL AS GtkPrintSettings PTR) AS gint
DECLARE SUB gtk_print_settings_set_resolution(BYVAL AS GtkPrintSettings PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_print_settings_get_resolution_x(BYVAL AS GtkPrintSettings PTR) AS gint
DECLARE FUNCTION gtk_print_settings_get_resolution_y(BYVAL AS GtkPrintSettings PTR) AS gint
DECLARE SUB gtk_print_settings_set_resolution_xy(BYVAL AS GtkPrintSettings PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gtk_print_settings_get_printer_lpi(BYVAL AS GtkPrintSettings PTR) AS gdouble
DECLARE SUB gtk_print_settings_set_printer_lpi(BYVAL AS GtkPrintSettings PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_print_settings_get_scale(BYVAL AS GtkPrintSettings PTR) AS gdouble
DECLARE SUB gtk_print_settings_set_scale(BYVAL AS GtkPrintSettings PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_print_settings_get_print_pages(BYVAL AS GtkPrintSettings PTR) AS GtkPrintPages
DECLARE SUB gtk_print_settings_set_print_pages(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPrintPages)
DECLARE FUNCTION gtk_print_settings_get_page_ranges(BYVAL AS GtkPrintSettings PTR, BYVAL AS gint PTR) AS GtkPageRange PTR
DECLARE SUB gtk_print_settings_set_page_ranges(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPageRange PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_print_settings_get_page_set(BYVAL AS GtkPrintSettings PTR) AS GtkPageSet
DECLARE SUB gtk_print_settings_set_page_set(BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPageSet)
DECLARE FUNCTION gtk_print_settings_get_default_source(BYVAL AS GtkPrintSettings PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set_default_source(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_settings_get_media_type(BYVAL AS GtkPrintSettings PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set_media_type(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_settings_get_dither(BYVAL AS GtkPrintSettings PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set_dither(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_settings_get_finishings(BYVAL AS GtkPrintSettings PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set_finishings(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_settings_get_output_bin(BYVAL AS GtkPrintSettings PTR) AS CONST gchar PTR
DECLARE SUB gtk_print_settings_set_output_bin(BYVAL AS GtkPrintSettings PTR, BYVAL AS CONST gchar PTR)

#ENDIF ' __GTK_PRINT_SETTINGS_H__

#IFNDEF __GTK_PRINT_OPERATION_PREVIEW_H__
#DEFINE __GTK_PRINT_OPERATION_PREVIEW_H__

#DEFINE GTK_TYPE_PRINT_OPERATION_PREVIEW (gtk_print_operation_preview_get_type ())
#DEFINE GTK_PRINT_OPERATION_PREVIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW, GtkPrintOperationPreview))
#DEFINE GTK_IS_PRINT_OPERATION_PREVIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW))
#DEFINE GTK_PRINT_OPERATION_PREVIEW_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW, GtkPrintOperationPreviewIface))

TYPE GtkPrintOperationPreview AS _GtkPrintOperationPreview
TYPE GtkPrintOperationPreviewIface AS _GtkPrintOperationPreviewIface

TYPE _GtkPrintOperationPreviewIface
  AS GTypeInterface g_iface
  ready AS SUB(BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS GtkPrintContext PTR)
  got_page_size AS SUB(BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS GtkPrintContext PTR, BYVAL AS GtkPageSetup PTR)
  render_page AS SUB(BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS gint)
  is_selected AS FUNCTION(BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS gint) AS gboolean
  end_preview AS SUB(BYVAL AS GtkPrintOperationPreview PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_print_operation_preview_get_type() AS GType
DECLARE SUB gtk_print_operation_preview_render_page(BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS gint)
DECLARE SUB gtk_print_operation_preview_end_preview(BYVAL AS GtkPrintOperationPreview PTR)
DECLARE FUNCTION gtk_print_operation_preview_is_selected(BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS gint) AS gboolean

#ENDIF ' __GTK_PRINT_OPERATION_PREVIEW_H__

#DEFINE GTK_TYPE_PRINT_OPERATION (gtk_print_operation_get_type ())
#DEFINE GTK_PRINT_OPERATION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_OPERATION, GtkPrintOperation))
#DEFINE GTK_PRINT_OPERATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_PRINT_OPERATION, GtkPrintOperationClass))
#DEFINE GTK_IS_PRINT_OPERATION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_OPERATION))
#DEFINE GTK_IS_PRINT_OPERATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PRINT_OPERATION))
#DEFINE GTK_PRINT_OPERATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_PRINT_OPERATION, GtkPrintOperationClass))

TYPE GtkPrintOperationClass AS _GtkPrintOperationClass
TYPE GtkPrintOperationPrivate AS _GtkPrintOperationPrivate
TYPE GtkPrintOperation AS _GtkPrintOperation

ENUM GtkPrintStatus
  GTK_PRINT_STATUS_INITIAL
  GTK_PRINT_STATUS_PREPARING
  GTK_PRINT_STATUS_GENERATING_DATA
  GTK_PRINT_STATUS_SENDING_DATA
  GTK_PRINT_STATUS_PENDING
  GTK_PRINT_STATUS_PENDING_ISSUE
  GTK_PRINT_STATUS_PRINTING
  GTK_PRINT_STATUS_FINISHED
  GTK_PRINT_STATUS_FINISHED_ABORTED
END ENUM

ENUM GtkPrintOperationResult
  GTK_PRINT_OPERATION_RESULT_ERROR
  GTK_PRINT_OPERATION_RESULT_APPLY
  GTK_PRINT_OPERATION_RESULT_CANCEL
  GTK_PRINT_OPERATION_RESULT_IN_PROGRESS
END ENUM

ENUM GtkPrintOperationAction
  GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG
  GTK_PRINT_OPERATION_ACTION_PRINT
  GTK_PRINT_OPERATION_ACTION_PREVIEW
  GTK_PRINT_OPERATION_ACTION_EXPORT
END ENUM

TYPE _GtkPrintOperation
  AS GObject parent_instance
  AS GtkPrintOperationPrivate PTR priv
END TYPE

TYPE _GtkPrintOperationClass
  AS GObjectClass parent_class
  done AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintOperationResult)
  begin_print AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintContext PTR)
  paginate AS FUNCTION(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintContext PTR) AS gboolean
  request_page_setup AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintContext PTR, BYVAL AS gint, BYVAL AS GtkPageSetup PTR)
  draw_page AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintContext PTR, BYVAL AS gint)
  end_print AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintContext PTR)
  status_changed AS SUB(BYVAL AS GtkPrintOperation PTR)
  create_custom_widget AS FUNCTION(BYVAL AS GtkPrintOperation PTR) AS GtkWidget PTR
  custom_widget_apply AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkWidget PTR)
  preview AS FUNCTION(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintOperationPreview PTR, BYVAL AS GtkPrintContext PTR, BYVAL AS GtkWindow PTR) AS gboolean
  update_custom_widget AS SUB(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkPageSetup PTR, BYVAL AS GtkPrintSettings PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

#DEFINE GTK_PRINT_ERROR gtk_print_error_quark ()

ENUM GtkPrintError
  GTK_PRINT_ERROR_GENERAL
  GTK_PRINT_ERROR_INTERNAL_ERROR
  GTK_PRINT_ERROR_NOMEM
  GTK_PRINT_ERROR_INVALID_FILE
END ENUM

DECLARE FUNCTION gtk_print_error_quark() AS GQuark
DECLARE FUNCTION gtk_print_operation_get_type() AS GType
DECLARE FUNCTION gtk_print_operation_new() AS GtkPrintOperation PTR
DECLARE SUB gtk_print_operation_set_default_page_setup(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPageSetup PTR)
DECLARE FUNCTION gtk_print_operation_get_default_page_setup(BYVAL AS GtkPrintOperation PTR) AS GtkPageSetup PTR
DECLARE SUB gtk_print_operation_set_print_settings(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintSettings PTR)
DECLARE FUNCTION gtk_print_operation_get_print_settings(BYVAL AS GtkPrintOperation PTR) AS GtkPrintSettings PTR
DECLARE SUB gtk_print_operation_set_job_name(BYVAL AS GtkPrintOperation PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_print_operation_set_n_pages(BYVAL AS GtkPrintOperation PTR, BYVAL AS gint)
DECLARE SUB gtk_print_operation_set_current_page(BYVAL AS GtkPrintOperation PTR, BYVAL AS gint)
DECLARE SUB gtk_print_operation_set_use_full_page(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE SUB gtk_print_operation_set_unit(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkUnit)
DECLARE SUB gtk_print_operation_set_export_filename(BYVAL AS GtkPrintOperation PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_print_operation_set_track_print_status(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE SUB gtk_print_operation_set_show_progress(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE SUB gtk_print_operation_set_allow_async(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE SUB gtk_print_operation_set_custom_tab_label(BYVAL AS GtkPrintOperation PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_print_operation_run(BYVAL AS GtkPrintOperation PTR, BYVAL AS GtkPrintOperationAction, BYVAL AS GtkWindow PTR, BYVAL AS GError PTR PTR) AS GtkPrintOperationResult
DECLARE SUB gtk_print_operation_get_error(BYVAL AS GtkPrintOperation PTR, BYVAL AS GError PTR PTR)
DECLARE FUNCTION gtk_print_operation_get_status(BYVAL AS GtkPrintOperation PTR) AS GtkPrintStatus
DECLARE FUNCTION gtk_print_operation_get_status_string(BYVAL AS GtkPrintOperation PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_print_operation_is_finished(BYVAL AS GtkPrintOperation PTR) AS gboolean
DECLARE SUB gtk_print_operation_cancel(BYVAL AS GtkPrintOperation PTR)
DECLARE SUB gtk_print_operation_draw_page_finish(BYVAL AS GtkPrintOperation PTR)
DECLARE SUB gtk_print_operation_set_defer_drawing(BYVAL AS GtkPrintOperation PTR)
DECLARE SUB gtk_print_operation_set_support_selection(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_operation_get_support_selection(BYVAL AS GtkPrintOperation PTR) AS gboolean
DECLARE SUB gtk_print_operation_set_has_selection(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_operation_get_has_selection(BYVAL AS GtkPrintOperation PTR) AS gboolean
DECLARE SUB gtk_print_operation_set_embed_page_setup(BYVAL AS GtkPrintOperation PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_print_operation_get_embed_page_setup(BYVAL AS GtkPrintOperation PTR) AS gboolean
DECLARE FUNCTION gtk_print_operation_get_n_pages_to_print(BYVAL AS GtkPrintOperation PTR) AS gint
DECLARE FUNCTION gtk_print_run_page_setup_dialog(BYVAL AS GtkWindow PTR, BYVAL AS GtkPageSetup PTR, BYVAL AS GtkPrintSettings PTR) AS GtkPageSetup PTR

TYPE GtkPageSetupDoneFunc AS SUB(BYVAL AS GtkPageSetup PTR, BYVAL AS gpointer)

DECLARE SUB gtk_print_run_page_setup_dialog_async(BYVAL AS GtkWindow PTR, BYVAL AS GtkPageSetup PTR, BYVAL AS GtkPrintSettings PTR, BYVAL AS GtkPageSetupDoneFunc, BYVAL AS gpointer)

#ENDIF ' __GTK_PRINT_OPERATION_H__

#IFNDEF __GTK_PROGRESS_BAR_H__
#DEFINE __GTK_PROGRESS_BAR_H__

#DEFINE GTK_TYPE_PROGRESS_BAR (gtk_progress_bar_get_type ())
#DEFINE GTK_PROGRESS_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBar))
#DEFINE GTK_PROGRESS_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_PROGRESS_BAR, GtkProgressBarClass))
#DEFINE GTK_IS_PROGRESS_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PROGRESS_BAR))
#DEFINE GTK_IS_PROGRESS_BAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PROGRESS_BAR))
#DEFINE GTK_PROGRESS_BAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBarClass))

TYPE GtkProgressBar AS _GtkProgressBar
TYPE GtkProgressBarPrivate AS _GtkProgressBarPrivate
TYPE GtkProgressBarClass AS _GtkProgressBarClass

TYPE _GtkProgressBar
  AS GtkWidget parent
  AS GtkProgressBarPrivate PTR priv
END TYPE

TYPE _GtkProgressBarClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_progress_bar_get_type() AS GType
DECLARE FUNCTION gtk_progress_bar_new() AS GtkWidget PTR
DECLARE SUB gtk_progress_bar_pulse(BYVAL AS GtkProgressBar PTR)
DECLARE SUB gtk_progress_bar_set_text(BYVAL AS GtkProgressBar PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_progress_bar_set_fraction(BYVAL AS GtkProgressBar PTR, BYVAL AS gdouble)
DECLARE SUB gtk_progress_bar_set_pulse_step(BYVAL AS GtkProgressBar PTR, BYVAL AS gdouble)
DECLARE SUB gtk_progress_bar_set_inverted(BYVAL AS GtkProgressBar PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_progress_bar_get_text(BYVAL AS GtkProgressBar PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_progress_bar_get_fraction(BYVAL AS GtkProgressBar PTR) AS gdouble
DECLARE FUNCTION gtk_progress_bar_get_pulse_step(BYVAL AS GtkProgressBar PTR) AS gdouble
DECLARE FUNCTION gtk_progress_bar_get_inverted(BYVAL AS GtkProgressBar PTR) AS gboolean
DECLARE SUB gtk_progress_bar_set_ellipsize(BYVAL AS GtkProgressBar PTR, BYVAL AS PangoEllipsizeMode)
DECLARE FUNCTION gtk_progress_bar_get_ellipsize(BYVAL AS GtkProgressBar PTR) AS PangoEllipsizeMode
DECLARE SUB gtk_progress_bar_set_show_text(BYVAL AS GtkProgressBar PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_progress_bar_get_show_text(BYVAL AS GtkProgressBar PTR) AS gboolean

#ENDIF ' __GTK_PROGRESS_BAR_H__

#IFNDEF __GTK_RADIO_ACTION_H__
#DEFINE __GTK_RADIO_ACTION_H__

#IFNDEF __GTK_TOGGLE_ACTION_H__
#DEFINE __GTK_TOGGLE_ACTION_H__

#DEFINE GTK_TYPE_TOGGLE_ACTION (gtk_toggle_action_get_type ())
#DEFINE GTK_TOGGLE_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOGGLE_ACTION, GtkToggleAction))
#DEFINE GTK_TOGGLE_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOGGLE_ACTION, GtkToggleActionClass))
#DEFINE GTK_IS_TOGGLE_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOGGLE_ACTION))
#DEFINE GTK_IS_TOGGLE_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOGGLE_ACTION))
#DEFINE GTK_TOGGLE_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_ACTION, GtkToggleActionClass))

TYPE GtkToggleAction AS _GtkToggleAction
TYPE GtkToggleActionPrivate AS _GtkToggleActionPrivate
TYPE GtkToggleActionClass AS _GtkToggleActionClass

TYPE _GtkToggleAction
  AS GtkAction parent
  AS GtkToggleActionPrivate PTR private_data
END TYPE

TYPE _GtkToggleActionClass
  AS GtkActionClass parent_class
  toggled AS SUB(BYVAL AS GtkToggleAction PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_toggle_action_get_type() AS GType
DECLARE FUNCTION gtk_toggle_action_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GtkToggleAction PTR
DECLARE SUB gtk_toggle_action_toggled(BYVAL AS GtkToggleAction PTR)
DECLARE SUB gtk_toggle_action_set_active(BYVAL AS GtkToggleAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toggle_action_get_active(BYVAL AS GtkToggleAction PTR) AS gboolean
DECLARE SUB gtk_toggle_action_set_draw_as_radio(BYVAL AS GtkToggleAction PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toggle_action_get_draw_as_radio(BYVAL AS GtkToggleAction PTR) AS gboolean
DECLARE SUB _gtk_toggle_action_set_active(BYVAL AS GtkToggleAction PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_TOGGLE_ACTION_H__

#DEFINE GTK_TYPE_RADIO_ACTION (gtk_radio_action_get_type ())
#DEFINE GTK_RADIO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_ACTION, GtkRadioAction))
#DEFINE GTK_RADIO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_ACTION, GtkRadioActionClass))
#DEFINE GTK_IS_RADIO_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_ACTION))
#DEFINE GTK_IS_RADIO_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_ACTION))
#DEFINE GTK_RADIO_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_ACTION, GtkRadioActionClass))

TYPE GtkRadioAction AS _GtkRadioAction
TYPE GtkRadioActionPrivate AS _GtkRadioActionPrivate
TYPE GtkRadioActionClass AS _GtkRadioActionClass

TYPE _GtkRadioAction
  AS GtkToggleAction parent
  AS GtkRadioActionPrivate PTR private_data
END TYPE

TYPE _GtkRadioActionClass
  AS GtkToggleActionClass parent_class
  changed AS SUB(BYVAL AS GtkRadioAction PTR, BYVAL AS GtkRadioAction PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_radio_action_get_type() AS GType
DECLARE FUNCTION gtk_radio_action_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS GtkRadioAction PTR
DECLARE FUNCTION gtk_radio_action_get_group(BYVAL AS GtkRadioAction PTR) AS GSList PTR
DECLARE SUB gtk_radio_action_set_group(BYVAL AS GtkRadioAction PTR, BYVAL AS GSList PTR)
DECLARE SUB gtk_radio_action_join_group(BYVAL AS GtkRadioAction PTR, BYVAL AS GtkRadioAction PTR)
DECLARE FUNCTION gtk_radio_action_get_current_value(BYVAL AS GtkRadioAction PTR) AS gint
DECLARE SUB gtk_radio_action_set_current_value(BYVAL AS GtkRadioAction PTR, BYVAL AS gint)

#ENDIF ' __GTK_RADIO_ACTION_H__

#IFNDEF __GTK_RADIO_BUTTON_H__
#DEFINE __GTK_RADIO_BUTTON_H__

#DEFINE GTK_TYPE_RADIO_BUTTON (gtk_radio_button_get_type ())
#DEFINE GTK_RADIO_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButton))
#DEFINE GTK_RADIO_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass))
#DEFINE GTK_IS_RADIO_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_BUTTON))
#DEFINE GTK_IS_RADIO_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_BUTTON))
#DEFINE GTK_RADIO_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RADIO_BUTTON, GtkRadioButtonClass))

TYPE GtkRadioButton AS _GtkRadioButton
TYPE GtkRadioButtonPrivate AS _GtkRadioButtonPrivate
TYPE GtkRadioButtonClass AS _GtkRadioButtonClass

TYPE _GtkRadioButton
  AS GtkCheckButton check_button
  AS GtkRadioButtonPrivate PTR priv
END TYPE

TYPE _GtkRadioButtonClass
  AS GtkCheckButtonClass parent_class
  group_changed AS SUB(BYVAL AS GtkRadioButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_radio_button_get_type() AS GType
DECLARE FUNCTION gtk_radio_button_new(BYVAL AS GSList PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_button_new_from_widget(BYVAL AS GtkRadioButton PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_button_new_with_label(BYVAL AS GSList PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_button_new_with_label_from_widget(BYVAL AS GtkRadioButton PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_button_new_with_mnemonic(BYVAL AS GSList PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_button_new_with_mnemonic_from_widget(BYVAL AS GtkRadioButton PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_button_get_group(BYVAL AS GtkRadioButton PTR) AS GSList PTR
DECLARE SUB gtk_radio_button_set_group(BYVAL AS GtkRadioButton PTR, BYVAL AS GSList PTR)
DECLARE SUB gtk_radio_button_join_group(BYVAL AS GtkRadioButton PTR, BYVAL AS GtkRadioButton PTR)

#ENDIF ' __GTK_RADIO_BUTTON_H__

#IFNDEF __GTK_RADIO_MENU_ITEM_H__
#DEFINE __GTK_RADIO_MENU_ITEM_H__

#DEFINE GTK_TYPE_RADIO_MENU_ITEM (gtk_radio_menu_item_get_type ())
#DEFINE GTK_RADIO_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItem))
#DEFINE GTK_RADIO_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass))
#DEFINE GTK_IS_RADIO_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_MENU_ITEM))
#DEFINE GTK_IS_RADIO_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_MENU_ITEM))
#DEFINE GTK_RADIO_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RADIO_MENU_ITEM, GtkRadioMenuItemClass))

TYPE GtkRadioMenuItem AS _GtkRadioMenuItem
TYPE GtkRadioMenuItemPrivate AS _GtkRadioMenuItemPrivate
TYPE GtkRadioMenuItemClass AS _GtkRadioMenuItemClass

TYPE _GtkRadioMenuItem
  AS GtkCheckMenuItem check_menu_item
  AS GtkRadioMenuItemPrivate PTR priv
END TYPE

TYPE _GtkRadioMenuItemClass
  AS GtkCheckMenuItemClass parent_class
  group_changed AS SUB(BYVAL AS GtkRadioMenuItem PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_radio_menu_item_get_type() AS GType
DECLARE FUNCTION gtk_radio_menu_item_new(BYVAL AS GSList PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_menu_item_new_with_label(BYVAL AS GSList PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_menu_item_new_with_mnemonic(BYVAL AS GSList PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_menu_item_new_from_widget(BYVAL AS GtkRadioMenuItem PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_menu_item_new_with_mnemonic_from_widget(BYVAL AS GtkRadioMenuItem PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_menu_item_new_with_label_from_widget(BYVAL AS GtkRadioMenuItem PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_radio_menu_item_get_group(BYVAL AS GtkRadioMenuItem PTR) AS GSList PTR
DECLARE SUB gtk_radio_menu_item_set_group(BYVAL AS GtkRadioMenuItem PTR, BYVAL AS GSList PTR)

#ENDIF ' __GTK_RADIO_MENU_ITEM_H__

#IFNDEF __GTK_RADIO_TOOL_BUTTON_H__
#DEFINE __GTK_RADIO_TOOL_BUTTON_H__

#IFNDEF __GTK_TOGGLE_TOOL_BUTTON_H__
#DEFINE __GTK_TOGGLE_TOOL_BUTTON_H__

#DEFINE GTK_TYPE_TOGGLE_TOOL_BUTTON (gtk_toggle_tool_button_get_type ())
#DEFINE GTK_TOGGLE_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButton))
#DEFINE GTK_TOGGLE_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButtonClass))
#DEFINE GTK_IS_TOGGLE_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON))
#DEFINE GTK_IS_TOGGLE_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOGGLE_TOOL_BUTTON))
#DEFINE GTK_TOGGLE_TOOL_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_TOGGLE_TOOL_BUTTON, GtkToggleToolButtonClass))

TYPE GtkToggleToolButton AS _GtkToggleToolButton
TYPE GtkToggleToolButtonClass AS _GtkToggleToolButtonClass
TYPE GtkToggleToolButtonPrivate AS _GtkToggleToolButtonPrivate

TYPE _GtkToggleToolButton
  AS GtkToolButton parent
  AS GtkToggleToolButtonPrivate PTR priv
END TYPE

TYPE _GtkToggleToolButtonClass
  AS GtkToolButtonClass parent_class
  toggled AS SUB(BYVAL AS GtkToggleToolButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_toggle_tool_button_get_type() AS GType
DECLARE FUNCTION gtk_toggle_tool_button_new() AS GtkToolItem PTR
DECLARE FUNCTION gtk_toggle_tool_button_new_from_stock(BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE SUB gtk_toggle_tool_button_set_active(BYVAL AS GtkToggleToolButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toggle_tool_button_get_active(BYVAL AS GtkToggleToolButton PTR) AS gboolean

#ENDIF ' __GTK_TOGGLE_TOOL_BUTTON_H__

#DEFINE GTK_TYPE_RADIO_TOOL_BUTTON (gtk_radio_tool_button_get_type ())
#DEFINE GTK_RADIO_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButton))
#DEFINE GTK_RADIO_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButtonClass))
#DEFINE GTK_IS_RADIO_TOOL_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RADIO_TOOL_BUTTON))
#DEFINE GTK_IS_RADIO_TOOL_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RADIO_TOOL_BUTTON))
#DEFINE GTK_RADIO_TOOL_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_RADIO_TOOL_BUTTON, GtkRadioToolButtonClass))

TYPE GtkRadioToolButton AS _GtkRadioToolButton
TYPE GtkRadioToolButtonClass AS _GtkRadioToolButtonClass

TYPE _GtkRadioToolButton
  AS GtkToggleToolButton parent
END TYPE

TYPE _GtkRadioToolButtonClass
  AS GtkToggleToolButtonClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_radio_tool_button_get_type() AS GType
DECLARE FUNCTION gtk_radio_tool_button_new(BYVAL AS GSList PTR) AS GtkToolItem PTR
DECLARE FUNCTION gtk_radio_tool_button_new_from_stock(BYVAL AS GSList PTR, BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE FUNCTION gtk_radio_tool_button_new_from_widget(BYVAL AS GtkRadioToolButton PTR) AS GtkToolItem PTR
DECLARE FUNCTION gtk_radio_tool_button_new_with_stock_from_widget(BYVAL AS GtkRadioToolButton PTR, BYVAL AS CONST gchar PTR) AS GtkToolItem PTR
DECLARE FUNCTION gtk_radio_tool_button_get_group(BYVAL AS GtkRadioToolButton PTR) AS GSList PTR
DECLARE SUB gtk_radio_tool_button_set_group(BYVAL AS GtkRadioToolButton PTR, BYVAL AS GSList PTR)

#ENDIF ' __GTK_RADIO_TOOL_BUTTON_H__

#IFNDEF __GTK_RECENT_ACTION_H__
#DEFINE __GTK_RECENT_ACTION_H__

#IFNDEF __GTK_RECENT_MANAGER_H__
#DEFINE __GTK_RECENT_MANAGER_H__

#INCLUDE ONCE "crt/time.bi"
#DEFINE GTK_TYPE_RECENT_INFO (gtk_recent_info_get_type ())
#DEFINE GTK_TYPE_RECENT_MANAGER (gtk_recent_manager_get_type ())
#DEFINE GTK_RECENT_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_MANAGER, GtkRecentManager))
#DEFINE GTK_IS_RECENT_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_MANAGER))
#DEFINE GTK_RECENT_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RECENT_MANAGER, GtkRecentManagerClass))
#DEFINE GTK_IS_RECENT_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RECENT_MANAGER))
#DEFINE GTK_RECENT_MANAGER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RECENT_MANAGER, GtkRecentManagerClass))

TYPE GtkRecentInfo AS _GtkRecentInfo
TYPE GtkRecentData AS _GtkRecentData
TYPE GtkRecentManager AS _GtkRecentManager
TYPE GtkRecentManagerClass AS _GtkRecentManagerClass
TYPE GtkRecentManagerPrivate AS _GtkRecentManagerPrivate

TYPE _GtkRecentData
  AS gchar PTR display_name
  AS gchar PTR description
  AS gchar PTR mime_type
  AS gchar PTR app_name
  AS gchar PTR app_exec
  AS gchar PTR PTR groups
  AS gboolean is_private
END TYPE

TYPE _GtkRecentManager
  AS GObject parent_instance
  AS GtkRecentManagerPrivate PTR priv
END TYPE

TYPE _GtkRecentManagerClass
  AS GObjectClass parent_class
  changed AS SUB(BYVAL AS GtkRecentManager PTR)
  _gtk_recent1 AS SUB()
  _gtk_recent2 AS SUB()
  _gtk_recent3 AS SUB()
  _gtk_recent4 AS SUB()
END TYPE

ENUM GtkRecentManagerError
  GTK_RECENT_MANAGER_ERROR_NOT_FOUND
  GTK_RECENT_MANAGER_ERROR_INVALID_URI
  GTK_RECENT_MANAGER_ERROR_INVALID_ENCODING
  GTK_RECENT_MANAGER_ERROR_NOT_REGISTERED
  GTK_RECENT_MANAGER_ERROR_READ
  GTK_RECENT_MANAGER_ERROR_WRITE
  GTK_RECENT_MANAGER_ERROR_UNKNOWN
END ENUM

#DEFINE GTK_RECENT_MANAGER_ERROR (gtk_recent_manager_error_quark ())

DECLARE FUNCTION gtk_recent_manager_error_quark() AS GQuark
DECLARE FUNCTION gtk_recent_manager_get_type() AS GType
DECLARE FUNCTION gtk_recent_manager_new() AS GtkRecentManager PTR
DECLARE FUNCTION gtk_recent_manager_get_default() AS GtkRecentManager PTR
DECLARE FUNCTION gtk_recent_manager_add_item(BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_recent_manager_add_full(BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GtkRecentData PTR) AS gboolean
DECLARE FUNCTION gtk_recent_manager_remove_item(BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_recent_manager_lookup_item(BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GtkRecentInfo PTR
DECLARE FUNCTION gtk_recent_manager_has_item(BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_recent_manager_move_item(BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_recent_manager_get_items(BYVAL AS GtkRecentManager PTR) AS GList PTR
DECLARE FUNCTION gtk_recent_manager_purge_items(BYVAL AS GtkRecentManager PTR, BYVAL AS GError PTR PTR) AS gint
DECLARE FUNCTION gtk_recent_info_get_type() AS GType
DECLARE FUNCTION gtk_recent_info_ref(BYVAL AS GtkRecentInfo PTR) AS GtkRecentInfo PTR
DECLARE SUB gtk_recent_info_unref(BYVAL AS GtkRecentInfo PTR)
DECLARE FUNCTION gtk_recent_info_get_uri(BYVAL AS GtkRecentInfo PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_recent_info_get_display_name(BYVAL AS GtkRecentInfo PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_recent_info_get_description(BYVAL AS GtkRecentInfo PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_recent_info_get_mime_type(BYVAL AS GtkRecentInfo PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_recent_info_get_added(BYVAL AS GtkRecentInfo PTR) AS time_t
DECLARE FUNCTION gtk_recent_info_get_modified(BYVAL AS GtkRecentInfo PTR) AS time_t
DECLARE FUNCTION gtk_recent_info_get_visited(BYVAL AS GtkRecentInfo PTR) AS time_t
DECLARE FUNCTION gtk_recent_info_get_private_hint(BYVAL AS GtkRecentInfo PTR) AS gboolean
DECLARE FUNCTION gtk_recent_info_get_application_info(BYVAL AS GtkRecentInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR PTR, BYVAL AS guint PTR, BYVAL AS time_t PTR) AS gboolean
DECLARE FUNCTION gtk_recent_info_create_app_info(BYVAL AS GtkRecentInfo PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS GAppInfo PTR
DECLARE FUNCTION gtk_recent_info_get_applications(BYVAL AS GtkRecentInfo PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION gtk_recent_info_last_application(BYVAL AS GtkRecentInfo PTR) AS gchar PTR
DECLARE FUNCTION gtk_recent_info_has_application(BYVAL AS GtkRecentInfo PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_recent_info_get_groups(BYVAL AS GtkRecentInfo PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE FUNCTION gtk_recent_info_has_group(BYVAL AS GtkRecentInfo PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_recent_info_get_icon(BYVAL AS GtkRecentInfo PTR, BYVAL AS gint) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_recent_info_get_gicon(BYVAL AS GtkRecentInfo PTR) AS GIcon PTR
DECLARE FUNCTION gtk_recent_info_get_short_name(BYVAL AS GtkRecentInfo PTR) AS gchar PTR
DECLARE FUNCTION gtk_recent_info_get_uri_display(BYVAL AS GtkRecentInfo PTR) AS gchar PTR
DECLARE FUNCTION gtk_recent_info_get_age(BYVAL AS GtkRecentInfo PTR) AS gint
DECLARE FUNCTION gtk_recent_info_is_local(BYVAL AS GtkRecentInfo PTR) AS gboolean
DECLARE FUNCTION gtk_recent_info_exists(BYVAL AS GtkRecentInfo PTR) AS gboolean
DECLARE FUNCTION gtk_recent_info_match(BYVAL AS GtkRecentInfo PTR, BYVAL AS GtkRecentInfo PTR) AS gboolean
DECLARE SUB _gtk_recent_manager_sync()

#ENDIF ' __GTK_RECENT_MANAGER_H__

#DEFINE GTK_TYPE_RECENT_ACTION (gtk_recent_action_get_type ())
#DEFINE GTK_RECENT_ACTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_ACTION, GtkRecentAction))
#DEFINE GTK_IS_RECENT_ACTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_ACTION))
#DEFINE GTK_RECENT_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RECENT_ACTION, GtkRecentActionClass))
#DEFINE GTK_IS_RECENT_ACTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RECENT_ACTION))
#DEFINE GTK_RECENT_ACTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RECENT_ACTION, GtkRecentActionClass))

TYPE GtkRecentAction AS _GtkRecentAction
TYPE GtkRecentActionPrivate AS _GtkRecentActionPrivate
TYPE GtkRecentActionClass AS _GtkRecentActionClass

TYPE _GtkRecentAction
  AS GtkAction parent_instance
  AS GtkRecentActionPrivate PTR priv
END TYPE

TYPE _GtkRecentActionClass
  AS GtkActionClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_recent_action_get_type() AS GType
DECLARE FUNCTION gtk_recent_action_new(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GtkAction PTR
DECLARE FUNCTION gtk_recent_action_new_for_manager(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkRecentManager PTR) AS GtkAction PTR
DECLARE FUNCTION gtk_recent_action_get_show_numbers(BYVAL AS GtkRecentAction PTR) AS gboolean
DECLARE SUB gtk_recent_action_set_show_numbers(BYVAL AS GtkRecentAction PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_RECENT_ACTION_H__

#IFNDEF __GTK_RECENT_CHOOSER_H__
#DEFINE __GTK_RECENT_CHOOSER_H__

#IFNDEF __GTK_RECENT_FILTER_H__
#DEFINE __GTK_RECENT_FILTER_H__

#DEFINE GTK_TYPE_RECENT_FILTER (gtk_recent_filter_get_type ())
#DEFINE GTK_RECENT_FILTER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_FILTER, GtkRecentFilter))
#DEFINE GTK_IS_RECENT_FILTER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_FILTER))

TYPE GtkRecentFilter AS _GtkRecentFilter
TYPE GtkRecentFilterInfo AS _GtkRecentFilterInfo

ENUM GtkRecentFilterFlags
  GTK_RECENT_FILTER_URI = 1 SHL 0
  GTK_RECENT_FILTER_DISPLAY_NAME = 1 SHL 1
  GTK_RECENT_FILTER_MIME_TYPE = 1 SHL 2
  GTK_RECENT_FILTER_APPLICATION = 1 SHL 3
  GTK_RECENT_FILTER_GROUP = 1 SHL 4
  GTK_RECENT_FILTER_AGE = 1 SHL 5
END ENUM

TYPE GtkRecentFilterFunc AS FUNCTION(BYVAL AS CONST GtkRecentFilterInfo PTR, BYVAL AS gpointer) AS gboolean

TYPE _GtkRecentFilterInfo
  AS GtkRecentFilterFlags contains
  AS CONST gchar PTR uri
  AS CONST gchar PTR display_name
  AS CONST gchar PTR mime_type
  AS CONST gchar PTR PTR applications
  AS CONST gchar PTR PTR groups
  AS gint age
END TYPE

DECLARE FUNCTION gtk_recent_filter_get_type() AS GType
DECLARE FUNCTION gtk_recent_filter_new() AS GtkRecentFilter PTR
DECLARE SUB gtk_recent_filter_set_name(BYVAL AS GtkRecentFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_recent_filter_get_name(BYVAL AS GtkRecentFilter PTR) AS CONST gchar PTR
DECLARE SUB gtk_recent_filter_add_mime_type(BYVAL AS GtkRecentFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_recent_filter_add_pattern(BYVAL AS GtkRecentFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_recent_filter_add_pixbuf_formats(BYVAL AS GtkRecentFilter PTR)
DECLARE SUB gtk_recent_filter_add_application(BYVAL AS GtkRecentFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_recent_filter_add_group(BYVAL AS GtkRecentFilter PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_recent_filter_add_age(BYVAL AS GtkRecentFilter PTR, BYVAL AS gint)
DECLARE SUB gtk_recent_filter_add_custom(BYVAL AS GtkRecentFilter PTR, BYVAL AS GtkRecentFilterFlags, BYVAL AS GtkRecentFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_recent_filter_get_needed(BYVAL AS GtkRecentFilter PTR) AS GtkRecentFilterFlags
DECLARE FUNCTION gtk_recent_filter_filter(BYVAL AS GtkRecentFilter PTR, BYVAL AS CONST GtkRecentFilterInfo PTR) AS gboolean

#ENDIF ' __GTK_RECENT_FILTER_H__

#DEFINE GTK_TYPE_RECENT_CHOOSER (gtk_recent_chooser_get_type ())
#DEFINE GTK_RECENT_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_CHOOSER, GtkRecentChooser))
#DEFINE GTK_IS_RECENT_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_CHOOSER))
#DEFINE GTK_RECENT_CHOOSER_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_RECENT_CHOOSER, GtkRecentChooserIface))

ENUM GtkRecentSortType
  GTK_RECENT_SORT_NONE = 0
  GTK_RECENT_SORT_MRU
  GTK_RECENT_SORT_LRU
  GTK_RECENT_SORT_CUSTOM
END ENUM

TYPE GtkRecentSortFunc AS FUNCTION(BYVAL AS GtkRecentInfo PTR, BYVAL AS GtkRecentInfo PTR, BYVAL AS gpointer) AS gint
TYPE GtkRecentChooser AS _GtkRecentChooser
TYPE GtkRecentChooserIface AS _GtkRecentChooserIface

#DEFINE GTK_RECENT_CHOOSER_ERROR (gtk_recent_chooser_error_quark ())

ENUM GtkRecentChooserError
  GTK_RECENT_CHOOSER_ERROR_NOT_FOUND
  GTK_RECENT_CHOOSER_ERROR_INVALID_URI
END ENUM

DECLARE FUNCTION gtk_recent_chooser_error_quark() AS GQuark

TYPE _GtkRecentChooserIface
  AS GTypeInterface base_iface
  set_current_uri AS FUNCTION(BYVAL AS GtkRecentChooser PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
  get_current_uri AS FUNCTION(BYVAL AS GtkRecentChooser PTR) AS gchar PTR
  select_uri AS FUNCTION(BYVAL AS GtkRecentChooser PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
  unselect_uri AS SUB(BYVAL AS GtkRecentChooser PTR, BYVAL AS CONST gchar PTR)
  select_all AS SUB(BYVAL AS GtkRecentChooser PTR)
  unselect_all AS SUB(BYVAL AS GtkRecentChooser PTR)
  get_items AS FUNCTION(BYVAL AS GtkRecentChooser PTR) AS GList PTR
  get_recent_manager AS FUNCTION(BYVAL AS GtkRecentChooser PTR) AS GtkRecentManager PTR
  add_filter AS SUB(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentFilter PTR)
  remove_filter AS SUB(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentFilter PTR)
  list_filters AS FUNCTION(BYVAL AS GtkRecentChooser PTR) AS GSList PTR
  set_sort_func AS SUB(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentSortFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
  item_activated AS SUB(BYVAL AS GtkRecentChooser PTR)
  selection_changed AS SUB(BYVAL AS GtkRecentChooser PTR)
END TYPE

DECLARE FUNCTION gtk_recent_chooser_get_type() AS GType
DECLARE SUB gtk_recent_chooser_set_show_private(BYVAL AS GtkRecentChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_recent_chooser_get_show_private(BYVAL AS GtkRecentChooser PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_set_show_not_found(BYVAL AS GtkRecentChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_recent_chooser_get_show_not_found(BYVAL AS GtkRecentChooser PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_set_select_multiple(BYVAL AS GtkRecentChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_recent_chooser_get_select_multiple(BYVAL AS GtkRecentChooser PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_set_limit(BYVAL AS GtkRecentChooser PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_recent_chooser_get_limit(BYVAL AS GtkRecentChooser PTR) AS gint
DECLARE SUB gtk_recent_chooser_set_local_only(BYVAL AS GtkRecentChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_recent_chooser_get_local_only(BYVAL AS GtkRecentChooser PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_set_show_tips(BYVAL AS GtkRecentChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_recent_chooser_get_show_tips(BYVAL AS GtkRecentChooser PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_set_show_icons(BYVAL AS GtkRecentChooser PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_recent_chooser_get_show_icons(BYVAL AS GtkRecentChooser PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_set_sort_type(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentSortType)
DECLARE FUNCTION gtk_recent_chooser_get_sort_type(BYVAL AS GtkRecentChooser PTR) AS GtkRecentSortType
DECLARE SUB gtk_recent_chooser_set_sort_func(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentSortFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_recent_chooser_set_current_uri(BYVAL AS GtkRecentChooser PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gtk_recent_chooser_get_current_uri(BYVAL AS GtkRecentChooser PTR) AS gchar PTR
DECLARE FUNCTION gtk_recent_chooser_get_current_item(BYVAL AS GtkRecentChooser PTR) AS GtkRecentInfo PTR
DECLARE FUNCTION gtk_recent_chooser_select_uri(BYVAL AS GtkRecentChooser PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_unselect_uri(BYVAL AS GtkRecentChooser PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_recent_chooser_select_all(BYVAL AS GtkRecentChooser PTR)
DECLARE SUB gtk_recent_chooser_unselect_all(BYVAL AS GtkRecentChooser PTR)
DECLARE FUNCTION gtk_recent_chooser_get_items(BYVAL AS GtkRecentChooser PTR) AS GList PTR
DECLARE FUNCTION gtk_recent_chooser_get_uris(BYVAL AS GtkRecentChooser PTR, BYVAL AS gsize PTR) AS gchar PTR PTR
DECLARE SUB gtk_recent_chooser_add_filter(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentFilter PTR)
DECLARE SUB gtk_recent_chooser_remove_filter(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentFilter PTR)
DECLARE FUNCTION gtk_recent_chooser_list_filters(BYVAL AS GtkRecentChooser PTR) AS GSList PTR
DECLARE SUB gtk_recent_chooser_set_filter(BYVAL AS GtkRecentChooser PTR, BYVAL AS GtkRecentFilter PTR)
DECLARE FUNCTION gtk_recent_chooser_get_filter(BYVAL AS GtkRecentChooser PTR) AS GtkRecentFilter PTR

#ENDIF ' __GTK_RECENT_CHOOSER_H__

#IFNDEF __GTK_RECENT_CHOOSER_DIALOG_H__
#DEFINE __GTK_RECENT_CHOOSER_DIALOG_H__

#DEFINE GTK_TYPE_RECENT_CHOOSER_DIALOG (gtk_recent_chooser_dialog_get_type ())
#DEFINE GTK_RECENT_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_CHOOSER_DIALOG, GtkRecentChooserDialog))
#DEFINE GTK_IS_RECENT_CHOOSER_DIALOG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_CHOOSER_DIALOG))
#DEFINE GTK_RECENT_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RECENT_CHOOSER_DIALOG, GtkRecentChooserDialogClass))
#DEFINE GTK_IS_RECENT_CHOOSER_DIALOG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RECENT_CHOOSER_DIALOG))
#DEFINE GTK_RECENT_CHOOSER_DIALOG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RECENT_CHOOSER_DIALOG, GtkRecentChooserDialogClass))

TYPE GtkRecentChooserDialog AS _GtkRecentChooserDialog
TYPE GtkRecentChooserDialogClass AS _GtkRecentChooserDialogClass
TYPE GtkRecentChooserDialogPrivate AS _GtkRecentChooserDialogPrivate

TYPE _GtkRecentChooserDialog
  AS GtkDialog parent_instance
  AS GtkRecentChooserDialogPrivate PTR priv
END TYPE

TYPE _GtkRecentChooserDialogClass
  AS GtkDialogClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_recent_chooser_dialog_get_type() AS GType
DECLARE FUNCTION gtk_recent_chooser_dialog_new(BYVAL AS CONST gchar PTR, BYVAL AS GtkWindow PTR, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE FUNCTION gtk_recent_chooser_dialog_new_for_manager(BYVAL AS CONST gchar PTR, BYVAL AS GtkWindow PTR, BYVAL AS GtkRecentManager PTR, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR

#ENDIF ' __GTK_RECENT_CHOOSER_DIALOG_H__

#IFNDEF __GTK_RECENT_CHOOSER_MENU_H__
#DEFINE __GTK_RECENT_CHOOSER_MENU_H__

#DEFINE GTK_TYPE_RECENT_CHOOSER_MENU (gtk_recent_chooser_menu_get_type ())
#DEFINE GTK_RECENT_CHOOSER_MENU(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_CHOOSER_MENU, GtkRecentChooserMenu))
#DEFINE GTK_IS_RECENT_CHOOSER_MENU(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_CHOOSER_MENU))
#DEFINE GTK_RECENT_CHOOSER_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RECENT_CHOOSER_MENU, GtkRecentChooserMenuClass))
#DEFINE GTK_IS_RECENT_CHOOSER_MENU_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RECENT_CHOOSER_MENU))
#DEFINE GTK_RECENT_CHOOSER_MENU_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RECENT_CHOOSER_MENU, GtkRecentChooserMenuClass))

TYPE GtkRecentChooserMenu AS _GtkRecentChooserMenu
TYPE GtkRecentChooserMenuClass AS _GtkRecentChooserMenuClass
TYPE GtkRecentChooserMenuPrivate AS _GtkRecentChooserMenuPrivate

TYPE _GtkRecentChooserMenu
  AS GtkMenu parent_instance
  AS GtkRecentChooserMenuPrivate PTR priv
END TYPE

TYPE _GtkRecentChooserMenuClass
  AS GtkMenuClass parent_class
  gtk_recent1 AS SUB()
  gtk_recent2 AS SUB()
  gtk_recent3 AS SUB()
  gtk_recent4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_recent_chooser_menu_get_type() AS GType
DECLARE FUNCTION gtk_recent_chooser_menu_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_recent_chooser_menu_new_for_manager(BYVAL AS GtkRecentManager PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_recent_chooser_menu_get_show_numbers(BYVAL AS GtkRecentChooserMenu PTR) AS gboolean
DECLARE SUB gtk_recent_chooser_menu_set_show_numbers(BYVAL AS GtkRecentChooserMenu PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_RECENT_CHOOSER_MENU_H__

#IFNDEF __GTK_RECENT_CHOOSER_WIDGET_H__
#DEFINE __GTK_RECENT_CHOOSER_WIDGET_H__

#DEFINE GTK_TYPE_RECENT_CHOOSER_WIDGET (gtk_recent_chooser_widget_get_type ())
#DEFINE GTK_RECENT_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_CHOOSER_WIDGET, GtkRecentChooserWidget))
#DEFINE GTK_IS_RECENT_CHOOSER_WIDGET(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_CHOOSER_WIDGET))
#DEFINE GTK_RECENT_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RECENT_CHOOSER_WIDGET, GtkRecentChooserWidgetClass))
#DEFINE GTK_IS_RECENT_CHOOSER_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RECENT_CHOOSER_WIDGET))
#DEFINE GTK_RECENT_CHOOSER_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RECENT_CHOOSER_WIDGET, GtkRecentChooserWidgetClass))

TYPE GtkRecentChooserWidget AS _GtkRecentChooserWidget
TYPE GtkRecentChooserWidgetClass AS _GtkRecentChooserWidgetClass
TYPE GtkRecentChooserWidgetPrivate AS _GtkRecentChooserWidgetPrivate

TYPE _GtkRecentChooserWidget
  AS GtkBox parent_instance
  AS GtkRecentChooserWidgetPrivate PTR priv
END TYPE

TYPE _GtkRecentChooserWidgetClass
  AS GtkBoxClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_recent_chooser_widget_get_type() AS GType
DECLARE FUNCTION gtk_recent_chooser_widget_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_recent_chooser_widget_new_for_manager(BYVAL AS GtkRecentManager PTR) AS GtkWidget PTR

#ENDIF ' __GTK_RECENT_CHOOSER_WIDGET_H__

#IFNDEF __GTK_SCALE_BUTTON_H__
#DEFINE __GTK_SCALE_BUTTON_H__

#DEFINE GTK_TYPE_SCALE_BUTTON (gtk_scale_button_get_type ())
#DEFINE GTK_SCALE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCALE_BUTTON, GtkScaleButton))
#DEFINE GTK_SCALE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCALE_BUTTON, GtkScaleButtonClass))
#DEFINE GTK_IS_SCALE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCALE_BUTTON))
#DEFINE GTK_IS_SCALE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCALE_BUTTON))
#DEFINE GTK_SCALE_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCALE_BUTTON, GtkScaleButtonClass))

TYPE GtkScaleButton AS _GtkScaleButton
TYPE GtkScaleButtonClass AS _GtkScaleButtonClass
TYPE GtkScaleButtonPrivate AS _GtkScaleButtonPrivate

TYPE _GtkScaleButton
  AS GtkButton parent
  AS GtkScaleButtonPrivate PTR priv
END TYPE

TYPE _GtkScaleButtonClass
  AS GtkButtonClass parent_class
  value_changed AS SUB(BYVAL AS GtkScaleButton PTR, BYVAL AS gdouble)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_scale_button_get_type() AS GType
DECLARE FUNCTION gtk_scale_button_new(BYVAL AS GtkIconSize, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS CONST gchar PTR PTR) AS GtkWidget PTR
DECLARE SUB gtk_scale_button_set_icons(BYVAL AS GtkScaleButton PTR, BYVAL AS CONST gchar PTR PTR)
DECLARE FUNCTION gtk_scale_button_get_value(BYVAL AS GtkScaleButton PTR) AS gdouble
DECLARE SUB gtk_scale_button_set_value(BYVAL AS GtkScaleButton PTR, BYVAL AS gdouble)
DECLARE FUNCTION gtk_scale_button_get_adjustment(BYVAL AS GtkScaleButton PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_scale_button_set_adjustment(BYVAL AS GtkScaleButton PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_scale_button_get_plus_button(BYVAL AS GtkScaleButton PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_scale_button_get_minus_button(BYVAL AS GtkScaleButton PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_scale_button_get_popup(BYVAL AS GtkScaleButton PTR) AS GtkWidget PTR

#ENDIF ' __GTK_SCALE_BUTTON_H__

#IFNDEF __GTK_SCROLLABLE_H__
#DEFINE __GTK_SCROLLABLE_H__

#DEFINE GTK_TYPE_SCROLLABLE (gtk_scrollable_get_type ())
#DEFINE GTK_SCROLLABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLABLE, GtkScrollable))
#DEFINE GTK_IS_SCROLLABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLABLE))
#DEFINE GTK_SCROLLABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_SCROLLABLE, GtkScrollableInterface))

TYPE GtkScrollable AS _GtkScrollable
TYPE GtkScrollableInterface AS _GtkScrollableInterface

TYPE _GtkScrollableInterface
  AS GTypeInterface base_iface
END TYPE

DECLARE FUNCTION gtk_scrollable_get_type() AS GType
DECLARE FUNCTION gtk_scrollable_get_hadjustment(BYVAL AS GtkScrollable PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_scrollable_set_hadjustment(BYVAL AS GtkScrollable PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_scrollable_get_vadjustment(BYVAL AS GtkScrollable PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_scrollable_set_vadjustment(BYVAL AS GtkScrollable PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_scrollable_get_hscroll_policy(BYVAL AS GtkScrollable PTR) AS GtkScrollablePolicy
DECLARE SUB gtk_scrollable_set_hscroll_policy(BYVAL AS GtkScrollable PTR, BYVAL AS GtkScrollablePolicy)
DECLARE FUNCTION gtk_scrollable_get_vscroll_policy(BYVAL AS GtkScrollable PTR) AS GtkScrollablePolicy
DECLARE SUB gtk_scrollable_set_vscroll_policy(BYVAL AS GtkScrollable PTR, BYVAL AS GtkScrollablePolicy)

#ENDIF ' __GTK_SCROLLABLE_H__

#IFNDEF __GTK_SCROLLED_WINDOW_H__
#DEFINE __GTK_SCROLLED_WINDOW_H__

#DEFINE GTK_TYPE_SCROLLED_WINDOW (gtk_scrolled_window_get_type ())
#DEFINE GTK_SCROLLED_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindow))
#DEFINE GTK_SCROLLED_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass))
#DEFINE GTK_IS_SCROLLED_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLED_WINDOW))
#DEFINE GTK_IS_SCROLLED_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCROLLED_WINDOW))
#DEFINE GTK_SCROLLED_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindowClass))

TYPE GtkScrolledWindow AS _GtkScrolledWindow
TYPE GtkScrolledWindowPrivate AS _GtkScrolledWindowPrivate
TYPE GtkScrolledWindowClass AS _GtkScrolledWindowClass

TYPE _GtkScrolledWindow
  AS GtkBin container
  AS GtkScrolledWindowPrivate PTR priv
END TYPE

TYPE _GtkScrolledWindowClass
  AS GtkBinClass parent_class
  AS gint scrollbar_spacing
  scroll_child AS FUNCTION(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkScrollType, BYVAL AS gboolean) AS gboolean
  move_focus_out AS SUB(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkDirectionType)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_scrolled_window_get_type() AS GType
DECLARE FUNCTION gtk_scrolled_window_new(BYVAL AS GtkAdjustment PTR, BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR
DECLARE SUB gtk_scrolled_window_set_hadjustment(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkAdjustment PTR)
DECLARE SUB gtk_scrolled_window_set_vadjustment(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_scrolled_window_get_hadjustment(BYVAL AS GtkScrolledWindow PTR) AS GtkAdjustment PTR
DECLARE FUNCTION gtk_scrolled_window_get_vadjustment(BYVAL AS GtkScrolledWindow PTR) AS GtkAdjustment PTR
DECLARE FUNCTION gtk_scrolled_window_get_hscrollbar(BYVAL AS GtkScrolledWindow PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_scrolled_window_get_vscrollbar(BYVAL AS GtkScrolledWindow PTR) AS GtkWidget PTR
DECLARE SUB gtk_scrolled_window_set_policy(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkPolicyType, BYVAL AS GtkPolicyType)
DECLARE SUB gtk_scrolled_window_get_policy(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkPolicyType PTR, BYVAL AS GtkPolicyType PTR)
DECLARE SUB gtk_scrolled_window_set_placement(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkCornerType)
DECLARE SUB gtk_scrolled_window_unset_placement(BYVAL AS GtkScrolledWindow PTR)
DECLARE FUNCTION gtk_scrolled_window_get_placement(BYVAL AS GtkScrolledWindow PTR) AS GtkCornerType
DECLARE SUB gtk_scrolled_window_set_shadow_type(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkShadowType)
DECLARE FUNCTION gtk_scrolled_window_get_shadow_type(BYVAL AS GtkScrolledWindow PTR) AS GtkShadowType
DECLARE SUB gtk_scrolled_window_add_with_viewport(BYVAL AS GtkScrolledWindow PTR, BYVAL AS GtkWidget PTR)
DECLARE FUNCTION gtk_scrolled_window_get_min_content_width(BYVAL AS GtkScrolledWindow PTR) AS gint
DECLARE SUB gtk_scrolled_window_set_min_content_width(BYVAL AS GtkScrolledWindow PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_scrolled_window_get_min_content_height(BYVAL AS GtkScrolledWindow PTR) AS gint
DECLARE SUB gtk_scrolled_window_set_min_content_height(BYVAL AS GtkScrolledWindow PTR, BYVAL AS gint)
DECLARE FUNCTION _gtk_scrolled_window_get_scrollbar_spacing(BYVAL AS GtkScrolledWindow PTR) AS gint

#ENDIF ' __GTK_SCROLLED_WINDOW_H__

#IFNDEF __GTK_SEPARATOR_MENU_ITEM_H__
#DEFINE __GTK_SEPARATOR_MENU_ITEM_H__

#DEFINE GTK_TYPE_SEPARATOR_MENU_ITEM (gtk_separator_menu_item_get_type ())
#DEFINE GTK_SEPARATOR_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItem))
#DEFINE GTK_SEPARATOR_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItemClass))
#DEFINE GTK_IS_SEPARATOR_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR_MENU_ITEM))
#DEFINE GTK_IS_SEPARATOR_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SEPARATOR_MENU_ITEM))
#DEFINE GTK_SEPARATOR_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SEPARATOR_MENU_ITEM, GtkSeparatorMenuItemClass))

TYPE GtkSeparatorMenuItem AS _GtkSeparatorMenuItem
TYPE GtkSeparatorMenuItemClass AS _GtkSeparatorMenuItemClass

TYPE _GtkSeparatorMenuItem
  AS GtkMenuItem menu_item
END TYPE

TYPE _GtkSeparatorMenuItemClass
  AS GtkMenuItemClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_separator_menu_item_get_type() AS GType
DECLARE FUNCTION gtk_separator_menu_item_new() AS GtkWidget PTR

#ENDIF ' __GTK_SEPARATOR_MENU_ITEM_H__

#IFNDEF __GTK_SEPARATOR_TOOL_ITEM_H__
#DEFINE __GTK_SEPARATOR_TOOL_ITEM_H__

#DEFINE GTK_TYPE_SEPARATOR_TOOL_ITEM (gtk_separator_tool_item_get_type ())
#DEFINE GTK_SEPARATOR_TOOL_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItem))
#DEFINE GTK_SEPARATOR_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItemClass))
#DEFINE GTK_IS_SEPARATOR_TOOL_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM))
#DEFINE GTK_IS_SEPARATOR_TOOL_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SEPARATOR_TOOL_ITEM))
#DEFINE GTK_SEPARATOR_TOOL_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_SEPARATOR_TOOL_ITEM, GtkSeparatorToolItemClass))

TYPE GtkSeparatorToolItem AS _GtkSeparatorToolItem
TYPE GtkSeparatorToolItemClass AS _GtkSeparatorToolItemClass
TYPE GtkSeparatorToolItemPrivate AS _GtkSeparatorToolItemPrivate

TYPE _GtkSeparatorToolItem
  AS GtkToolItem parent
  AS GtkSeparatorToolItemPrivate PTR priv
END TYPE

TYPE _GtkSeparatorToolItemClass
  AS GtkToolItemClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_separator_tool_item_get_type() AS GType
DECLARE FUNCTION gtk_separator_tool_item_new() AS GtkToolItem PTR
DECLARE FUNCTION gtk_separator_tool_item_get_draw(BYVAL AS GtkSeparatorToolItem PTR) AS gboolean
DECLARE SUB gtk_separator_tool_item_set_draw(BYVAL AS GtkSeparatorToolItem PTR, BYVAL AS gboolean)

#ENDIF ' __GTK_SEPARATOR_TOOL_ITEM_H__

#IFNDEF __GTK_SHOW_H__
#DEFINE __GTK_SHOW_H__

DECLARE FUNCTION gtk_show_uri(BYVAL AS GdkScreen PTR, BYVAL AS CONST gchar PTR, BYVAL AS guint32, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __GTK_SHOW_H__

#IFNDEF __GTK_SIZE_REQUEST_H__
#DEFINE __GTK_SIZE_REQUEST_H__

TYPE GtkRequestedSize AS _GtkRequestedSize

TYPE _GtkRequestedSize
  AS gpointer data
  AS gint minimum_size
  AS gint natural_size
END TYPE

DECLARE FUNCTION gtk_distribute_natural_allocation(BYVAL AS gint, BYVAL AS guint, BYVAL AS GtkRequestedSize PTR) AS gint

#ENDIF ' __GTK_SIZE_REQUEST_H__

#IFNDEF __GTK_SPIN_BUTTON_H__
#DEFINE __GTK_SPIN_BUTTON_H__

#DEFINE GTK_TYPE_SPIN_BUTTON (gtk_spin_button_get_type ())
#DEFINE GTK_SPIN_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SPIN_BUTTON, GtkSpinButton))
#DEFINE GTK_SPIN_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SPIN_BUTTON, GtkSpinButtonClass))
#DEFINE GTK_IS_SPIN_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SPIN_BUTTON))
#DEFINE GTK_IS_SPIN_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SPIN_BUTTON))
#DEFINE GTK_SPIN_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SPIN_BUTTON, GtkSpinButtonClass))
#DEFINE GTK_INPUT_ERROR -1

ENUM GtkSpinButtonUpdatePolicy
  GTK_UPDATE_ALWAYS
  GTK_UPDATE_IF_VALID
END ENUM

ENUM GtkSpinType
  GTK_SPIN_STEP_FORWARD
  GTK_SPIN_STEP_BACKWARD
  GTK_SPIN_PAGE_FORWARD
  GTK_SPIN_PAGE_BACKWARD
  GTK_SPIN_HOME
  GTK_SPIN_END
  GTK_SPIN_USER_DEFINED
END ENUM

TYPE GtkSpinButton AS _GtkSpinButton
TYPE GtkSpinButtonPrivate AS _GtkSpinButtonPrivate
TYPE GtkSpinButtonClass AS _GtkSpinButtonClass

TYPE _GtkSpinButton
  AS GtkEntry entry
  AS GtkSpinButtonPrivate PTR priv
END TYPE

TYPE _GtkSpinButtonClass
  AS GtkEntryClass parent_class
  input_ AS FUNCTION(BYVAL AS GtkSpinButton PTR, BYVAL AS gdouble PTR) AS gint
  output_ AS FUNCTION(BYVAL AS GtkSpinButton PTR) AS gint
  value_changed AS SUB(BYVAL AS GtkSpinButton PTR)
  change_value AS SUB(BYVAL AS GtkSpinButton PTR, BYVAL AS GtkScrollType)
  wrapped AS SUB(BYVAL AS GtkSpinButton PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_spin_button_get_type() AS GType
DECLARE SUB gtk_spin_button_configure(BYVAL AS GtkSpinButton PTR, BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble, BYVAL AS guint)
DECLARE FUNCTION gtk_spin_button_new(BYVAL AS GtkAdjustment PTR, BYVAL AS gdouble, BYVAL AS guint) AS GtkWidget PTR
DECLARE FUNCTION gtk_spin_button_new_with_range(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkWidget PTR
DECLARE SUB gtk_spin_button_set_adjustment(BYVAL AS GtkSpinButton PTR, BYVAL AS GtkAdjustment PTR)
DECLARE FUNCTION gtk_spin_button_get_adjustment(BYVAL AS GtkSpinButton PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_spin_button_set_digits(BYVAL AS GtkSpinButton PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_spin_button_get_digits(BYVAL AS GtkSpinButton PTR) AS guint
DECLARE SUB gtk_spin_button_set_increments(BYVAL AS GtkSpinButton PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_spin_button_get_increments(BYVAL AS GtkSpinButton PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB gtk_spin_button_set_range(BYVAL AS GtkSpinButton PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_spin_button_get_range(BYVAL AS GtkSpinButton PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE FUNCTION gtk_spin_button_get_value(BYVAL AS GtkSpinButton PTR) AS gdouble
DECLARE FUNCTION gtk_spin_button_get_value_as_int(BYVAL AS GtkSpinButton PTR) AS gint
DECLARE SUB gtk_spin_button_set_value(BYVAL AS GtkSpinButton PTR, BYVAL AS gdouble)
DECLARE SUB gtk_spin_button_set_update_policy(BYVAL AS GtkSpinButton PTR, BYVAL AS GtkSpinButtonUpdatePolicy)
DECLARE FUNCTION gtk_spin_button_get_update_policy(BYVAL AS GtkSpinButton PTR) AS GtkSpinButtonUpdatePolicy
DECLARE SUB gtk_spin_button_set_numeric(BYVAL AS GtkSpinButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_spin_button_get_numeric(BYVAL AS GtkSpinButton PTR) AS gboolean
DECLARE SUB gtk_spin_button_spin(BYVAL AS GtkSpinButton PTR, BYVAL AS GtkSpinType, BYVAL AS gdouble)
DECLARE SUB gtk_spin_button_set_wrap(BYVAL AS GtkSpinButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_spin_button_get_wrap(BYVAL AS GtkSpinButton PTR) AS gboolean
DECLARE SUB gtk_spin_button_set_snap_to_ticks(BYVAL AS GtkSpinButton PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_spin_button_get_snap_to_ticks(BYVAL AS GtkSpinButton PTR) AS gboolean
DECLARE SUB gtk_spin_button_update(BYVAL AS GtkSpinButton PTR)
DECLARE FUNCTION _gtk_spin_button_get_panel(BYVAL AS GtkSpinButton PTR) AS GdkWindow PTR

#ENDIF ' __GTK_SPIN_BUTTON_H__

#IFNDEF __GTK_SPINNER_H__
#DEFINE __GTK_SPINNER_H__

#DEFINE GTK_TYPE_SPINNER (gtk_spinner_get_type ())
#DEFINE GTK_SPINNER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SPINNER, GtkSpinner))
#DEFINE GTK_SPINNER_CLASS(obj) (G_TYPE_CHECK_CLASS_CAST ((obj), GTK_TYPE_SPINNER, GtkSpinnerClass))
#DEFINE GTK_IS_SPINNER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SPINNER))
#DEFINE GTK_IS_SPINNER_CLASS(obj) (G_TYPE_CHECK_CLASS_TYPE ((obj), GTK_TYPE_SPINNER))
#DEFINE GTK_SPINNER_GET_CLASS (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SPINNER, GtkSpinnerClass))

TYPE GtkSpinner AS _GtkSpinner
TYPE GtkSpinnerClass AS _GtkSpinnerClass
TYPE GtkSpinnerPrivate AS _GtkSpinnerPrivate

TYPE _GtkSpinner
  AS GtkWidget parent
  AS GtkSpinnerPrivate PTR priv
END TYPE

TYPE _GtkSpinnerClass
  AS GtkWidgetClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_spinner_get_type() AS GType
DECLARE FUNCTION gtk_spinner_new() AS GtkWidget PTR
DECLARE SUB gtk_spinner_start(BYVAL AS GtkSpinner PTR)
DECLARE SUB gtk_spinner_stop(BYVAL AS GtkSpinner PTR)

#ENDIF ' __GTK_SPINNER_H__

#IFNDEF __GTK_STATUSBAR_H__
#DEFINE __GTK_STATUSBAR_H__

#DEFINE GTK_TYPE_STATUSBAR (gtk_statusbar_get_type ())
#DEFINE GTK_STATUSBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_STATUSBAR, GtkStatusbar))
#DEFINE GTK_STATUSBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_STATUSBAR, GtkStatusbarClass))
#DEFINE GTK_IS_STATUSBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_STATUSBAR))
#DEFINE GTK_IS_STATUSBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_STATUSBAR))
#DEFINE GTK_STATUSBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_STATUSBAR, GtkStatusbarClass))

TYPE GtkStatusbar AS _GtkStatusbar
TYPE GtkStatusbarPrivate AS _GtkStatusbarPrivate
TYPE GtkStatusbarClass AS _GtkStatusbarClass

TYPE _GtkStatusbar
  AS GtkBox parent_widget
  AS GtkStatusbarPrivate PTR priv
END TYPE

TYPE _GtkStatusbarClass
  AS GtkBoxClass parent_class
  AS gpointer reserved
  text_pushed AS SUB(BYVAL AS GtkStatusbar PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR)
  text_popped AS SUB(BYVAL AS GtkStatusbar PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_statusbar_get_type() AS GType
DECLARE FUNCTION gtk_statusbar_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_statusbar_get_context_id(BYVAL AS GtkStatusbar PTR, BYVAL AS CONST gchar PTR) AS guint
DECLARE FUNCTION gtk_statusbar_push(BYVAL AS GtkStatusbar PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR) AS guint
DECLARE SUB gtk_statusbar_pop(BYVAL AS GtkStatusbar PTR, BYVAL AS guint)
DECLARE SUB gtk_statusbar_remove(BYVAL AS GtkStatusbar PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_statusbar_remove_all(BYVAL AS GtkStatusbar PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_statusbar_get_message_area(BYVAL AS GtkStatusbar PTR) AS GtkWidget PTR

#ENDIF ' __GTK_STATUSBAR_H__

#IFNDEF __GTK_STATUS_ICON_H__
#DEFINE __GTK_STATUS_ICON_H__

#DEFINE GTK_TYPE_STATUS_ICON (gtk_status_icon_get_type ())
#DEFINE GTK_STATUS_ICON(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_STATUS_ICON, GtkStatusIcon))
#DEFINE GTK_STATUS_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_STATUS_ICON, GtkStatusIconClass))
#DEFINE GTK_IS_STATUS_ICON(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_STATUS_ICON))
#DEFINE GTK_IS_STATUS_ICON_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_STATUS_ICON))
#DEFINE GTK_STATUS_ICON_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_STATUS_ICON, GtkStatusIconClass))

TYPE GtkStatusIcon AS _GtkStatusIcon
TYPE GtkStatusIconClass AS _GtkStatusIconClass
TYPE GtkStatusIconPrivate AS _GtkStatusIconPrivate

TYPE _GtkStatusIcon
  AS GObject parent_instance
  AS GtkStatusIconPrivate PTR priv
END TYPE

TYPE _GtkStatusIconClass
  AS GObjectClass parent_class
  activate AS SUB(BYVAL AS GtkStatusIcon PTR)
  popup_menu AS SUB(BYVAL AS GtkStatusIcon PTR, BYVAL AS guint, BYVAL AS guint32)
  size_changed AS FUNCTION(BYVAL AS GtkStatusIcon PTR, BYVAL AS gint) AS gboolean
  button_press_event AS FUNCTION(BYVAL AS GtkStatusIcon PTR, BYVAL AS GdkEventButton PTR) AS gboolean
  button_release_event AS FUNCTION(BYVAL AS GtkStatusIcon PTR, BYVAL AS GdkEventButton PTR) AS gboolean
  scroll_event AS FUNCTION(BYVAL AS GtkStatusIcon PTR, BYVAL AS GdkEventScroll PTR) AS gboolean
  query_tooltip AS FUNCTION(BYVAL AS GtkStatusIcon PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gboolean, BYVAL AS GtkTooltip PTR) AS gboolean
  __gtk_reserved1 AS SUB()
  __gtk_reserved2 AS SUB()
  __gtk_reserved3 AS SUB()
  __gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_status_icon_get_type() AS GType
DECLARE FUNCTION gtk_status_icon_new() AS GtkStatusIcon PTR
DECLARE FUNCTION gtk_status_icon_new_from_pixbuf(BYVAL AS GdkPixbuf PTR) AS GtkStatusIcon PTR
DECLARE FUNCTION gtk_status_icon_new_from_file(BYVAL AS CONST gchar PTR) AS GtkStatusIcon PTR
DECLARE FUNCTION gtk_status_icon_new_from_stock(BYVAL AS CONST gchar PTR) AS GtkStatusIcon PTR
DECLARE FUNCTION gtk_status_icon_new_from_icon_name(BYVAL AS CONST gchar PTR) AS GtkStatusIcon PTR
DECLARE FUNCTION gtk_status_icon_new_from_gicon(BYVAL AS GIcon PTR) AS GtkStatusIcon PTR
DECLARE SUB gtk_status_icon_set_from_pixbuf(BYVAL AS GtkStatusIcon PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_status_icon_set_from_file(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_status_icon_set_from_stock(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_status_icon_set_from_icon_name(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_status_icon_set_from_gicon(BYVAL AS GtkStatusIcon PTR, BYVAL AS GIcon PTR)
DECLARE FUNCTION gtk_status_icon_get_storage_type(BYVAL AS GtkStatusIcon PTR) AS GtkImageType
DECLARE FUNCTION gtk_status_icon_get_pixbuf(BYVAL AS GtkStatusIcon PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gtk_status_icon_get_stock(BYVAL AS GtkStatusIcon PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_status_icon_get_icon_name(BYVAL AS GtkStatusIcon PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_status_icon_get_gicon(BYVAL AS GtkStatusIcon PTR) AS GIcon PTR
DECLARE FUNCTION gtk_status_icon_get_size(BYVAL AS GtkStatusIcon PTR) AS gint
DECLARE SUB gtk_status_icon_set_screen(BYVAL AS GtkStatusIcon PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gtk_status_icon_get_screen(BYVAL AS GtkStatusIcon PTR) AS GdkScreen PTR
DECLARE SUB gtk_status_icon_set_has_tooltip(BYVAL AS GtkStatusIcon PTR, BYVAL AS gboolean)
DECLARE SUB gtk_status_icon_set_tooltip_text(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_status_icon_set_tooltip_markup(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_status_icon_set_title(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_status_icon_get_title(BYVAL AS GtkStatusIcon PTR) AS CONST gchar PTR
DECLARE SUB gtk_status_icon_set_name(BYVAL AS GtkStatusIcon PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_status_icon_set_visible(BYVAL AS GtkStatusIcon PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_status_icon_get_visible(BYVAL AS GtkStatusIcon PTR) AS gboolean
DECLARE FUNCTION gtk_status_icon_is_embedded(BYVAL AS GtkStatusIcon PTR) AS gboolean
DECLARE SUB gtk_status_icon_position_menu(BYVAL AS GtkMenu PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gboolean PTR, BYVAL AS gpointer)
DECLARE FUNCTION gtk_status_icon_get_geometry(BYVAL AS GtkStatusIcon PTR, BYVAL AS GdkScreen PTR PTR, BYVAL AS GdkRectangle PTR, BYVAL AS GtkOrientation PTR) AS gboolean
DECLARE FUNCTION gtk_status_icon_get_has_tooltip(BYVAL AS GtkStatusIcon PTR) AS gboolean
DECLARE FUNCTION gtk_status_icon_get_tooltip_text(BYVAL AS GtkStatusIcon PTR) AS gchar PTR
DECLARE FUNCTION gtk_status_icon_get_tooltip_markup(BYVAL AS GtkStatusIcon PTR) AS gchar PTR
DECLARE FUNCTION gtk_status_icon_get_x11_window_id(BYVAL AS GtkStatusIcon PTR) AS guint32

#ENDIF ' __GTK_STATUS_ICON_H__

#IFNDEF __GTK_SWITCH_H__
#DEFINE __GTK_SWITCH_H__

#DEFINE GTK_TYPE_SWITCH (gtk_switch_get_type ())
#DEFINE GTK_SWITCH(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SWITCH, GtkSwitch))
#DEFINE GTK_IS_SWITCH(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SWITCH))
#DEFINE GTK_SWITCH_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SWITCH, GtkSwitchClass))
#DEFINE GTK_IS_SWITCH_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SWITCH))
#DEFINE GTK_SWITCH_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SWITCH, GtkSwitchClass))

TYPE GtkSwitch AS _GtkSwitch
TYPE GtkSwitchPrivate AS _GtkSwitchPrivate
TYPE GtkSwitchClass AS _GtkSwitchClass

TYPE _GtkSwitch
  AS GtkWidget parent_instance
  AS GtkSwitchPrivate PTR priv
END TYPE

TYPE _GtkSwitchClass
  AS GtkWidgetClass parent_class
  activate AS SUB(BYVAL AS GtkSwitch PTR)
  _switch_padding_1 AS SUB()
  _switch_padding_2 AS SUB()
  _switch_padding_3 AS SUB()
  _switch_padding_4 AS SUB()
  _switch_padding_5 AS SUB()
  _switch_padding_6 AS SUB()
END TYPE

DECLARE FUNCTION gtk_switch_get_type() AS GType
DECLARE FUNCTION gtk_switch_new() AS GtkWidget PTR
DECLARE SUB gtk_switch_set_active(BYVAL AS GtkSwitch PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_switch_get_active(BYVAL AS GtkSwitch PTR) AS gboolean

#ENDIF ' __GTK_SWITCH_H__

#IFNDEF __GTK_TABLE_H__
#DEFINE __GTK_TABLE_H__

#DEFINE GTK_TYPE_TABLE (gtk_table_get_type ())
#DEFINE GTK_TABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TABLE, GtkTable))
#DEFINE GTK_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TABLE, GtkTableClass))
#DEFINE GTK_IS_TABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TABLE))
#DEFINE GTK_IS_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TABLE))
#DEFINE GTK_TABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TABLE, GtkTableClass))

TYPE GtkTable AS _GtkTable
TYPE GtkTablePrivate AS _GtkTablePrivate
TYPE GtkTableClass AS _GtkTableClass
TYPE GtkTableChild AS _GtkTableChild
TYPE GtkTableRowCol AS _GtkTableRowCol

TYPE _GtkTable
  AS GtkContainer container
  AS GtkTablePrivate PTR priv
END TYPE

TYPE _GtkTableClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

TYPE _GtkTableChild
  AS GtkWidget PTR widget
  AS guint16 left_attach
  AS guint16 right_attach
  AS guint16 top_attach
  AS guint16 bottom_attach
  AS guint16 xpadding
  AS guint16 ypadding
  AS guint xexpand : 1
  AS guint yexpand : 1
  AS guint xshrink : 1
  AS guint yshrink : 1
  AS guint xfill : 1
  AS guint yfill : 1
END TYPE

TYPE _GtkTableRowCol
  AS guint16 requisition
  AS guint16 allocation
  AS guint16 spacing
  AS guint need_expand : 1
  AS guint need_shrink : 1
  AS guint expand : 1
  AS guint shrink : 1
  AS guint empty : 1
END TYPE

DECLARE FUNCTION gtk_table_get_type() AS GType
DECLARE FUNCTION gtk_table_new(BYVAL AS guint, BYVAL AS guint, BYVAL AS gboolean) AS GtkWidget PTR
DECLARE SUB gtk_table_resize(BYVAL AS GtkTable PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_table_attach(BYVAL AS GtkTable PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS GtkAttachOptions, BYVAL AS GtkAttachOptions, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_table_attach_defaults(BYVAL AS GtkTable PTR, BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint)
DECLARE SUB gtk_table_set_row_spacing(BYVAL AS GtkTable PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE FUNCTION gtk_table_get_row_spacing(BYVAL AS GtkTable PTR, BYVAL AS guint) AS guint
DECLARE SUB gtk_table_set_col_spacing(BYVAL AS GtkTable PTR, BYVAL AS guint, BYVAL AS guint)
DECLARE FUNCTION gtk_table_get_col_spacing(BYVAL AS GtkTable PTR, BYVAL AS guint) AS guint
DECLARE SUB gtk_table_set_row_spacings(BYVAL AS GtkTable PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_table_get_default_row_spacing(BYVAL AS GtkTable PTR) AS guint
DECLARE SUB gtk_table_set_col_spacings(BYVAL AS GtkTable PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_table_get_default_col_spacing(BYVAL AS GtkTable PTR) AS guint
DECLARE SUB gtk_table_set_homogeneous(BYVAL AS GtkTable PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_table_get_homogeneous(BYVAL AS GtkTable PTR) AS gboolean
DECLARE SUB gtk_table_get_size(BYVAL AS GtkTable PTR, BYVAL AS guint PTR, BYVAL AS guint PTR)

#ENDIF ' __GTK_TABLE_H__

#IFNDEF __GTK_TEAROFF_MENU_ITEM_H__
#DEFINE __GTK_TEAROFF_MENU_ITEM_H__

#DEFINE GTK_TYPE_TEAROFF_MENU_ITEM (gtk_tearoff_menu_item_get_type ())
#DEFINE GTK_TEAROFF_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItem))
#DEFINE GTK_TEAROFF_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItemClass))
#DEFINE GTK_IS_TEAROFF_MENU_ITEM(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEAROFF_MENU_ITEM))
#DEFINE GTK_IS_TEAROFF_MENU_ITEM_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEAROFF_MENU_ITEM))
#DEFINE GTK_TEAROFF_MENU_ITEM_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEAROFF_MENU_ITEM, GtkTearoffMenuItemClass))

TYPE GtkTearoffMenuItem AS _GtkTearoffMenuItem
TYPE GtkTearoffMenuItemPrivate AS _GtkTearoffMenuItemPrivate
TYPE GtkTearoffMenuItemClass AS _GtkTearoffMenuItemClass

TYPE _GtkTearoffMenuItem
  AS GtkMenuItem menu_item
  AS GtkTearoffMenuItemPrivate PTR priv
END TYPE

TYPE _GtkTearoffMenuItemClass
  AS GtkMenuItemClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tearoff_menu_item_get_type() AS GType
DECLARE FUNCTION gtk_tearoff_menu_item_new() AS GtkWidget PTR

#ENDIF ' __GTK_TEAROFF_MENU_ITEM_H__

#IFNDEF __GTK_TEXT_BUFFER_H__
#DEFINE __GTK_TEXT_BUFFER_H__

#IFNDEF __GTK_TEXT_TAG_TABLE_H__
#DEFINE __GTK_TEXT_TAG_TABLE_H__

TYPE GtkTextTagTableForeach AS SUB(BYVAL AS GtkTextTag PTR, BYVAL AS gpointer)

#DEFINE GTK_TYPE_TEXT_TAG_TABLE (gtk_text_tag_table_get_type ())
#DEFINE GTK_TEXT_TAG_TABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTable))
#DEFINE GTK_TEXT_TAG_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass))
#DEFINE GTK_IS_TEXT_TAG_TABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_TAG_TABLE))
#DEFINE GTK_IS_TEXT_TAG_TABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_TAG_TABLE))
#DEFINE GTK_TEXT_TAG_TABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTableClass))

TYPE GtkTextTagTablePrivate AS _GtkTextTagTablePrivate
TYPE GtkTextTagTableClass AS _GtkTextTagTableClass

TYPE _GtkTextTagTable
  AS GObject parent_instance
  AS GtkTextTagTablePrivate PTR priv
END TYPE

TYPE _GtkTextTagTableClass
  AS GObjectClass parent_class
  tag_changed AS SUB(BYVAL AS GtkTextTagTable PTR, BYVAL AS GtkTextTag PTR, BYVAL AS gboolean)
  tag_added AS SUB(BYVAL AS GtkTextTagTable PTR, BYVAL AS GtkTextTag PTR)
  tag_removed AS SUB(BYVAL AS GtkTextTagTable PTR, BYVAL AS GtkTextTag PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_text_tag_table_get_type() AS GType
DECLARE FUNCTION gtk_text_tag_table_new() AS GtkTextTagTable PTR
DECLARE SUB gtk_text_tag_table_add(BYVAL AS GtkTextTagTable PTR, BYVAL AS GtkTextTag PTR)
DECLARE SUB gtk_text_tag_table_remove(BYVAL AS GtkTextTagTable PTR, BYVAL AS GtkTextTag PTR)
DECLARE FUNCTION gtk_text_tag_table_lookup(BYVAL AS GtkTextTagTable PTR, BYVAL AS CONST gchar PTR) AS GtkTextTag PTR
DECLARE SUB gtk_text_tag_table_foreach(BYVAL AS GtkTextTagTable PTR, BYVAL AS GtkTextTagTableForeach, BYVAL AS gpointer)
DECLARE FUNCTION gtk_text_tag_table_get_size(BYVAL AS GtkTextTagTable PTR) AS gint
DECLARE SUB _gtk_text_tag_table_add_buffer(BYVAL AS GtkTextTagTable PTR, BYVAL AS gpointer)
DECLARE SUB _gtk_text_tag_table_remove_buffer(BYVAL AS GtkTextTagTable PTR, BYVAL AS gpointer)

#ENDIF ' __GTK_TEXT_TAG_TABLE_H__

#IFNDEF __GTK_TEXT_MARK_H__
#DEFINE __GTK_TEXT_MARK_H__

TYPE GtkTextMark AS _GtkTextMark
TYPE GtkTextMarkClass AS _GtkTextMarkClass

#DEFINE GTK_TYPE_TEXT_MARK (gtk_text_mark_get_type ())
#DEFINE GTK_TEXT_MARK(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_TEXT_MARK, GtkTextMark))
#DEFINE GTK_TEXT_MARK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_MARK, GtkTextMarkClass))
#DEFINE GTK_IS_TEXT_MARK(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_TEXT_MARK))
#DEFINE GTK_IS_TEXT_MARK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_MARK))
#DEFINE GTK_TEXT_MARK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_MARK, GtkTextMarkClass))

TYPE _GtkTextMark
  AS GObject parent_instance
  AS gpointer segment
END TYPE

TYPE _GtkTextMarkClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_text_mark_get_type() AS GType
DECLARE FUNCTION gtk_text_mark_new(BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS GtkTextMark PTR
DECLARE SUB gtk_text_mark_set_visible(BYVAL AS GtkTextMark PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_mark_get_visible(BYVAL AS GtkTextMark PTR) AS gboolean
DECLARE FUNCTION gtk_text_mark_get_name(BYVAL AS GtkTextMark PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_text_mark_get_deleted(BYVAL AS GtkTextMark PTR) AS gboolean
DECLARE FUNCTION gtk_text_mark_get_buffer(BYVAL AS GtkTextMark PTR) AS GtkTextBuffer PTR
DECLARE FUNCTION gtk_text_mark_get_left_gravity(BYVAL AS GtkTextMark PTR) AS gboolean

#ENDIF ' __GTK_TEXT_MARK_H__

ENUM GtkTextBufferTargetInfo
  GTK_TEXT_BUFFER_TARGET_INFO_BUFFER_CONTENTS = - 1
  GTK_TEXT_BUFFER_TARGET_INFO_RICH_TEXT = - 2
  GTK_TEXT_BUFFER_TARGET_INFO_TEXT = - 3
END ENUM

TYPE GtkTextBTree AS _GtkTextBTree

#DEFINE GTK_TYPE_TEXT_BUFFER (gtk_text_buffer_get_type ())
#DEFINE GTK_TEXT_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBuffer))
#DEFINE GTK_TEXT_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass))
#DEFINE GTK_IS_TEXT_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_BUFFER))
#DEFINE GTK_IS_TEXT_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_BUFFER))
#DEFINE GTK_TEXT_BUFFER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass))

TYPE GtkTextBufferPrivate AS _GtkTextBufferPrivate
TYPE GtkTextBufferClass AS _GtkTextBufferClass

TYPE _GtkTextBuffer
  AS GObject parent_instance
  AS GtkTextBufferPrivate PTR priv
END TYPE

TYPE _GtkTextBufferClass
  AS GObjectClass parent_class
  insert_text AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
  insert_pixbuf AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GdkPixbuf PTR)
  insert_child_anchor AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextChildAnchor PTR)
  delete_range AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)
  changed AS SUB(BYVAL AS GtkTextBuffer PTR)
  modified_changed AS SUB(BYVAL AS GtkTextBuffer PTR)
  mark_set AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS GtkTextMark PTR)
  mark_deleted AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextMark PTR)
  apply_tag AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextTag PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
  remove_tag AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextTag PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
  begin_user_action AS SUB(BYVAL AS GtkTextBuffer PTR)
  end_user_action AS SUB(BYVAL AS GtkTextBuffer PTR)
  paste_done AS SUB(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboard PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_text_buffer_get_type() AS GType
DECLARE FUNCTION gtk_text_buffer_new(BYVAL AS GtkTextTagTable PTR) AS GtkTextBuffer PTR
DECLARE FUNCTION gtk_text_buffer_get_line_count(BYVAL AS GtkTextBuffer PTR) AS gint
DECLARE FUNCTION gtk_text_buffer_get_char_count(BYVAL AS GtkTextBuffer PTR) AS gint
DECLARE FUNCTION gtk_text_buffer_get_tag_table(BYVAL AS GtkTextBuffer PTR) AS GtkTextTagTable PTR
DECLARE SUB gtk_text_buffer_set_text(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_text_buffer_insert(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gtk_text_buffer_insert_at_cursor(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_buffer_insert_interactive(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_text_buffer_insert_interactive_at_cursor(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gboolean) AS gboolean
DECLARE SUB gtk_text_buffer_insert_range(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE FUNCTION gtk_text_buffer_insert_range_interactive(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS gboolean
DECLARE SUB gtk_text_buffer_insert_with_tags(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS GtkTextTag PTR, ...)
DECLARE SUB gtk_text_buffer_insert_with_tags_by_name(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS CONST gchar PTR, ...)
DECLARE SUB gtk_text_buffer_delete(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)
DECLARE FUNCTION gtk_text_buffer_delete_interactive(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_text_buffer_backspace(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gboolean, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_text_buffer_get_text(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS gchar PTR
DECLARE FUNCTION gtk_text_buffer_get_slice(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS gchar PTR
DECLARE SUB gtk_text_buffer_insert_pixbuf(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GdkPixbuf PTR)
DECLARE SUB gtk_text_buffer_insert_child_anchor(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextChildAnchor PTR)
DECLARE FUNCTION gtk_text_buffer_create_child_anchor(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR) AS GtkTextChildAnchor PTR
DECLARE SUB gtk_text_buffer_add_mark(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextMark PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE FUNCTION gtk_text_buffer_create_mark(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gboolean) AS GtkTextMark PTR
DECLARE SUB gtk_text_buffer_move_mark(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextMark PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_delete_mark(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextMark PTR)
DECLARE FUNCTION gtk_text_buffer_get_mark(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR) AS GtkTextMark PTR
DECLARE SUB gtk_text_buffer_move_mark_by_name(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_delete_mark_by_name(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_text_buffer_get_insert(BYVAL AS GtkTextBuffer PTR) AS GtkTextMark PTR
DECLARE FUNCTION gtk_text_buffer_get_selection_bound(BYVAL AS GtkTextBuffer PTR) AS GtkTextMark PTR
DECLARE SUB gtk_text_buffer_place_cursor(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_select_range(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_apply_tag(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextTag PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_remove_tag(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextTag PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_apply_tag_by_name(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_remove_tag_by_name(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_remove_all_tags(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR)
DECLARE FUNCTION gtk_text_buffer_create_tag(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS GtkTextTag PTR
DECLARE SUB gtk_text_buffer_get_iter_at_line_offset(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_text_buffer_get_iter_at_line_index(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_text_buffer_get_iter_at_offset(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_buffer_get_iter_at_line(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint)
DECLARE SUB gtk_text_buffer_get_start_iter(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_get_end_iter(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_get_bounds(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)
DECLARE SUB gtk_text_buffer_get_iter_at_mark(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextMark PTR)
DECLARE SUB gtk_text_buffer_get_iter_at_child_anchor(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextChildAnchor PTR)
DECLARE FUNCTION gtk_text_buffer_get_modified(BYVAL AS GtkTextBuffer PTR) AS gboolean
DECLARE SUB gtk_text_buffer_set_modified(BYVAL AS GtkTextBuffer PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_buffer_get_has_selection(BYVAL AS GtkTextBuffer PTR) AS gboolean
DECLARE SUB gtk_text_buffer_add_selection_clipboard(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboard PTR)
DECLARE SUB gtk_text_buffer_remove_selection_clipboard(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboard PTR)
DECLARE SUB gtk_text_buffer_cut_clipboard(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboard PTR, BYVAL AS gboolean)
DECLARE SUB gtk_text_buffer_copy_clipboard(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboard PTR)
DECLARE SUB gtk_text_buffer_paste_clipboard(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkClipboard PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_buffer_get_selection_bounds(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_buffer_delete_selection(BYVAL AS GtkTextBuffer PTR, BYVAL AS gboolean, BYVAL AS gboolean) AS gboolean
DECLARE SUB gtk_text_buffer_begin_user_action(BYVAL AS GtkTextBuffer PTR)
DECLARE SUB gtk_text_buffer_end_user_action(BYVAL AS GtkTextBuffer PTR)
DECLARE FUNCTION gtk_text_buffer_get_copy_target_list(BYVAL AS GtkTextBuffer PTR) AS GtkTargetList PTR
DECLARE FUNCTION gtk_text_buffer_get_paste_target_list(BYVAL AS GtkTextBuffer PTR) AS GtkTargetList PTR
DECLARE SUB _gtk_text_buffer_spew(BYVAL AS GtkTextBuffer PTR)
DECLARE FUNCTION _gtk_text_buffer_get_btree(BYVAL AS GtkTextBuffer PTR) AS GtkTextBTree PTR
DECLARE FUNCTION _gtk_text_buffer_get_line_log_attrs(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gint PTR) AS CONST PangoLogAttr PTR
DECLARE SUB _gtk_text_buffer_notify_will_remove_tag(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextTag PTR)
DECLARE SUB _gtk_text_buffer_get_text_before(BYVAL AS GtkTextBuffer PTR, BYVAL AS AtkTextBoundary, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)
DECLARE SUB _gtk_text_buffer_get_text_at(BYVAL AS GtkTextBuffer PTR, BYVAL AS AtkTextBoundary, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)
DECLARE SUB _gtk_text_buffer_get_text_after(BYVAL AS GtkTextBuffer PTR, BYVAL AS AtkTextBoundary, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR, BYVAL AS GtkTextIter PTR)

#ENDIF ' __GTK_TEXT_BUFFER_H__

#IFNDEF __GTK_TEXT_BUFFER_RICH_TEXT_H__
#DEFINE __GTK_TEXT_BUFFER_RICH_TEXT_H__

TYPE GtkTextBufferSerializeFunc AS FUNCTION(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gsize PTR, BYVAL AS gpointer) AS guint8 PTR
TYPE GtkTextBufferDeserializeFunc AS FUNCTION(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextIter PTR, BYVAL AS CONST guint8 PTR, BYVAL AS gsize, BYVAL AS gboolean, BYVAL AS gpointer, BYVAL AS GError PTR PTR) AS gboolean

DECLARE FUNCTION gtk_text_buffer_register_serialize_format(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkTextBufferSerializeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GdkAtom
DECLARE FUNCTION gtk_text_buffer_register_serialize_tagset(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR) AS GdkAtom
DECLARE FUNCTION gtk_text_buffer_register_deserialize_format(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkTextBufferDeserializeFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GdkAtom
DECLARE FUNCTION gtk_text_buffer_register_deserialize_tagset(BYVAL AS GtkTextBuffer PTR, BYVAL AS CONST gchar PTR) AS GdkAtom
DECLARE SUB gtk_text_buffer_unregister_serialize_format(BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom)
DECLARE SUB gtk_text_buffer_unregister_deserialize_format(BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom)
DECLARE SUB gtk_text_buffer_deserialize_set_can_create_tags(BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_buffer_deserialize_get_can_create_tags(BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom) AS gboolean
DECLARE FUNCTION gtk_text_buffer_get_serialize_formats(BYVAL AS GtkTextBuffer PTR, BYVAL AS gint PTR) AS GdkAtom PTR
DECLARE FUNCTION gtk_text_buffer_get_deserialize_formats(BYVAL AS GtkTextBuffer PTR, BYVAL AS gint PTR) AS GdkAtom PTR
DECLARE FUNCTION gtk_text_buffer_serialize(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom, BYVAL AS CONST GtkTextIter PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gsize PTR) AS guint8 PTR
DECLARE FUNCTION gtk_text_buffer_deserialize(BYVAL AS GtkTextBuffer PTR, BYVAL AS GtkTextBuffer PTR, BYVAL AS GdkAtom, BYVAL AS GtkTextIter PTR, BYVAL AS CONST guint8 PTR, BYVAL AS gsize, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' __GTK_TEXT_BUFFER_RICH_TEXT_H__

#IFNDEF __GTK_TEXT_VIEW_H__
#DEFINE __GTK_TEXT_VIEW_H__

#DEFINE GTK_TYPE_TEXT_VIEW (gtk_text_view_get_type ())
#DEFINE GTK_TEXT_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_VIEW, GtkTextView))
#DEFINE GTK_TEXT_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_VIEW, GtkTextViewClass))
#DEFINE GTK_IS_TEXT_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_VIEW))
#DEFINE GTK_IS_TEXT_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_VIEW))
#DEFINE GTK_TEXT_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_VIEW, GtkTextViewClass))

ENUM GtkTextWindowType
  GTK_TEXT_WINDOW_PRIVATE
  GTK_TEXT_WINDOW_WIDGET
  GTK_TEXT_WINDOW_TEXT
  GTK_TEXT_WINDOW_LEFT
  GTK_TEXT_WINDOW_RIGHT
  GTK_TEXT_WINDOW_TOP
  GTK_TEXT_WINDOW_BOTTOM
END ENUM

#DEFINE GTK_TEXT_VIEW_PRIORITY_VALIDATE (GDK_PRIORITY_REDRAW + 5)

TYPE GtkTextView AS _GtkTextView
TYPE GtkTextViewPrivate AS _GtkTextViewPrivate
TYPE GtkTextViewClass AS _GtkTextViewClass

TYPE _GtkTextView
  AS GtkContainer parent_instance
  AS GtkTextViewPrivate PTR priv
END TYPE

TYPE _GtkTextViewClass
  AS GtkContainerClass parent_class
  populate_popup AS SUB(BYVAL AS GtkTextView PTR, BYVAL AS GtkMenu PTR)
  move_cursor AS SUB(BYVAL AS GtkTextView PTR, BYVAL AS GtkMovementStep, BYVAL AS gint, BYVAL AS gboolean)
  set_anchor AS SUB(BYVAL AS GtkTextView PTR)
  insert_at_cursor AS SUB(BYVAL AS GtkTextView PTR, BYVAL AS CONST gchar PTR)
  delete_from_cursor AS SUB(BYVAL AS GtkTextView PTR, BYVAL AS GtkDeleteType, BYVAL AS gint)
  backspace AS SUB(BYVAL AS GtkTextView PTR)
  cut_clipboard AS SUB(BYVAL AS GtkTextView PTR)
  copy_clipboard AS SUB(BYVAL AS GtkTextView PTR)
  paste_clipboard AS SUB(BYVAL AS GtkTextView PTR)
  toggle_overwrite AS SUB(BYVAL AS GtkTextView PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
  _gtk_reserved5 AS SUB()
  _gtk_reserved6 AS SUB()
  _gtk_reserved7 AS SUB()
  _gtk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gtk_text_view_get_type() AS GType
DECLARE FUNCTION gtk_text_view_new() AS GtkWidget PTR
DECLARE FUNCTION gtk_text_view_new_with_buffer(BYVAL AS GtkTextBuffer PTR) AS GtkWidget PTR
DECLARE SUB gtk_text_view_set_buffer(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextBuffer PTR)
DECLARE FUNCTION gtk_text_view_get_buffer(BYVAL AS GtkTextView PTR) AS GtkTextBuffer PTR
DECLARE FUNCTION gtk_text_view_scroll_to_iter(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gdouble, BYVAL AS gboolean, BYVAL AS gdouble, BYVAL AS gdouble) AS gboolean
DECLARE SUB gtk_text_view_scroll_to_mark(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextMark PTR, BYVAL AS gdouble, BYVAL AS gboolean, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gtk_text_view_scroll_mark_onscreen(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextMark PTR)
DECLARE FUNCTION gtk_text_view_move_mark_onscreen(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextMark PTR) AS gboolean
DECLARE FUNCTION gtk_text_view_place_cursor_onscreen(BYVAL AS GtkTextView PTR) AS gboolean
DECLARE SUB gtk_text_view_get_visible_rect(BYVAL AS GtkTextView PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_text_view_set_cursor_visible(BYVAL AS GtkTextView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_view_get_cursor_visible(BYVAL AS GtkTextView PTR) AS gboolean
DECLARE SUB gtk_text_view_get_cursor_locations(BYVAL AS GtkTextView PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS GdkRectangle PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_text_view_get_iter_location(BYVAL AS GtkTextView PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gtk_text_view_get_iter_at_location(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_text_view_get_iter_at_position(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_text_view_get_line_yrange(BYVAL AS GtkTextView PTR, BYVAL AS CONST GtkTextIter PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_text_view_get_line_at_y(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint, BYVAL AS gint PTR)
DECLARE SUB gtk_text_view_buffer_to_window_coords(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextWindowType, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_text_view_window_to_buffer_coords(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextWindowType, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_text_view_get_hadjustment(BYVAL AS GtkTextView PTR) AS GtkAdjustment PTR
DECLARE FUNCTION gtk_text_view_get_vadjustment(BYVAL AS GtkTextView PTR) AS GtkAdjustment PTR

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_text_view_get_window(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextWindowType) AS GdkWindow PTR
DECLARE FUNCTION gtk_text_view_get_window_type(BYVAL AS GtkTextView PTR, BYVAL AS GdkWindow PTR) AS GtkTextWindowType
DECLARE SUB gtk_text_view_set_border_window_size(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextWindowType, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_border_window_size(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextWindowType) AS gint
DECLARE FUNCTION gtk_text_view_forward_display_line(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_view_backward_display_line(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_view_forward_display_line_end(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_view_backward_display_line_start(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_view_starts_display_line(BYVAL AS GtkTextView PTR, BYVAL AS CONST GtkTextIter PTR) AS gboolean
DECLARE FUNCTION gtk_text_view_move_visually(BYVAL AS GtkTextView PTR, BYVAL AS GtkTextIter PTR, BYVAL AS gint) AS gboolean
DECLARE FUNCTION gtk_text_view_im_context_filter_keypress(BYVAL AS GtkTextView PTR, BYVAL AS GdkEventKey PTR) AS gboolean
DECLARE SUB gtk_text_view_reset_im_context(BYVAL AS GtkTextView PTR)
DECLARE SUB gtk_text_view_add_child_at_anchor(BYVAL AS GtkTextView PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkTextChildAnchor PTR)
DECLARE SUB gtk_text_view_add_child_in_window(BYVAL AS GtkTextView PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkTextWindowType, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_text_view_move_child(BYVAL AS GtkTextView PTR, BYVAL AS GtkWidget PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gtk_text_view_set_wrap_mode(BYVAL AS GtkTextView PTR, BYVAL AS GtkWrapMode)
DECLARE FUNCTION gtk_text_view_get_wrap_mode(BYVAL AS GtkTextView PTR) AS GtkWrapMode
DECLARE SUB gtk_text_view_set_editable(BYVAL AS GtkTextView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_view_get_editable(BYVAL AS GtkTextView PTR) AS gboolean
DECLARE SUB gtk_text_view_set_overwrite(BYVAL AS GtkTextView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_view_get_overwrite(BYVAL AS GtkTextView PTR) AS gboolean
DECLARE SUB gtk_text_view_set_accepts_tab(BYVAL AS GtkTextView PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_text_view_get_accepts_tab(BYVAL AS GtkTextView PTR) AS gboolean
DECLARE SUB gtk_text_view_set_pixels_above_lines(BYVAL AS GtkTextView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_pixels_above_lines(BYVAL AS GtkTextView PTR) AS gint
DECLARE SUB gtk_text_view_set_pixels_below_lines(BYVAL AS GtkTextView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_pixels_below_lines(BYVAL AS GtkTextView PTR) AS gint
DECLARE SUB gtk_text_view_set_pixels_inside_wrap(BYVAL AS GtkTextView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_pixels_inside_wrap(BYVAL AS GtkTextView PTR) AS gint
DECLARE SUB gtk_text_view_set_justification(BYVAL AS GtkTextView PTR, BYVAL AS GtkJustification)
DECLARE FUNCTION gtk_text_view_get_justification(BYVAL AS GtkTextView PTR) AS GtkJustification
DECLARE SUB gtk_text_view_set_left_margin(BYVAL AS GtkTextView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_left_margin(BYVAL AS GtkTextView PTR) AS gint
DECLARE SUB gtk_text_view_set_right_margin(BYVAL AS GtkTextView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_right_margin(BYVAL AS GtkTextView PTR) AS gint
DECLARE SUB gtk_text_view_set_indent(BYVAL AS GtkTextView PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_text_view_get_indent(BYVAL AS GtkTextView PTR) AS gint
DECLARE SUB gtk_text_view_set_tabs(BYVAL AS GtkTextView PTR, BYVAL AS PangoTabArray PTR)
DECLARE FUNCTION gtk_text_view_get_tabs(BYVAL AS GtkTextView PTR) AS PangoTabArray PTR
DECLARE FUNCTION gtk_text_view_get_default_attributes(BYVAL AS GtkTextView PTR) AS GtkTextAttributes PTR

#ENDIF ' __GTK_TEXT_VIEW_H__

#IFNDEF __GTK_THEMING_ENGINE_H__
#DEFINE __GTK_THEMING_ENGINE_H__

#DEFINE GTK_TYPE_THEMING_ENGINE (gtk_theming_engine_get_type ())
#DEFINE GTK_THEMING_ENGINE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_THEMING_ENGINE, GtkThemingEngine))
#DEFINE GTK_THEMING_ENGINE_CLASS(c) (G_TYPE_CHECK_CLASS_CAST ((c), GTK_TYPE_THEMING_ENGINE, GtkThemingEngineClass))
#DEFINE GTK_IS_THEMING_ENGINE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_THEMING_ENGINE))
#DEFINE GTK_IS_THEMING_ENGINE_CLASS(c) (G_TYPE_CHECK_CLASS_TYPE ((c), GTK_TYPE_THEMING_ENGINE))
#DEFINE GTK_THEMING_ENGINE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_THEMING_ENGINE, GtkThemingEngineClass))

TYPE GtkThemingEngine AS _GtkThemingEngine
TYPE GtkThemingEnginePrivate AS GtkThemingEnginePrivate_
TYPE GtkThemingEngineClass AS _GtkThemingEngineClass

TYPE _GtkThemingEngine
  AS GObject parent_object
  AS GtkThemingEnginePrivate PTR priv
END TYPE

TYPE _GtkThemingEngineClass
  AS GObjectClass parent_class
  render_line AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_background AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_frame AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_frame_gap AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkPositionType, BYVAL AS gdouble, BYVAL AS gdouble)
  render_extension AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkPositionType)
  render_check AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_option AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_arrow AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_expander AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_focus AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_layout AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS PangoLayout PTR)
  render_slider AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS GtkOrientation)
  render_handle AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_activity AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble)
  render_icon_pixbuf AS FUNCTION(BYVAL AS GtkThemingEngine PTR, BYVAL AS CONST GtkIconSource PTR, BYVAL AS GtkIconSize) AS GdkPixbuf PTR
  render_icon AS SUB(BYVAL AS GtkThemingEngine PTR, BYVAL AS cairo_t PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gdouble, BYVAL AS gdouble)
  AS gpointer padding(14)
END TYPE

DECLARE FUNCTION gtk_theming_engine_get_type() AS GType
DECLARE SUB _gtk_theming_engine_set_context(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStyleContext PTR)
DECLARE SUB gtk_theming_engine_register_property(BYVAL AS CONST gchar PTR, BYVAL AS GtkStylePropertyParser, BYVAL AS GParamSpec PTR)
DECLARE SUB gtk_theming_engine_get_property(BYVAL AS GtkThemingEngine PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkStateFlags, BYVAL AS GValue PTR)
DECLARE SUB gtk_theming_engine_get_valist(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS va_list)
DECLARE SUB gtk_theming_engine_get(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, ...)
DECLARE SUB gtk_theming_engine_get_style_property(BYVAL AS GtkThemingEngine PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR)
DECLARE SUB gtk_theming_engine_get_style_valist(BYVAL AS GtkThemingEngine PTR, BYVAL AS va_list)
DECLARE SUB gtk_theming_engine_get_style(BYVAL AS GtkThemingEngine PTR, ...)
DECLARE FUNCTION gtk_theming_engine_lookup_color(BYVAL AS GtkThemingEngine PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkRGBA PTR) AS gboolean
DECLARE FUNCTION gtk_theming_engine_get_path(BYVAL AS GtkThemingEngine PTR) AS CONST GtkWidgetPath PTR
DECLARE FUNCTION gtk_theming_engine_has_class(BYVAL AS GtkThemingEngine PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gtk_theming_engine_has_region(BYVAL AS GtkThemingEngine PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkRegionFlags PTR) AS gboolean
DECLARE FUNCTION gtk_theming_engine_get_state(BYVAL AS GtkThemingEngine PTR) AS GtkStateFlags
DECLARE FUNCTION gtk_theming_engine_state_is_running(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateType, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gtk_theming_engine_get_direction(BYVAL AS GtkThemingEngine PTR) AS GtkTextDirection
DECLARE FUNCTION gtk_theming_engine_get_junction_sides(BYVAL AS GtkThemingEngine PTR) AS GtkJunctionSides
DECLARE SUB gtk_theming_engine_get_color(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_theming_engine_get_background_color(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_theming_engine_get_border_color(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS GdkRGBA PTR)
DECLARE SUB gtk_theming_engine_get_border(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS GtkBorder PTR)
DECLARE SUB gtk_theming_engine_get_padding(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS GtkBorder PTR)
DECLARE SUB gtk_theming_engine_get_margin(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags, BYVAL AS GtkBorder PTR)
DECLARE FUNCTION gtk_theming_engine_get_font(BYVAL AS GtkThemingEngine PTR, BYVAL AS GtkStateFlags) AS CONST PangoFontDescription PTR
DECLARE FUNCTION gtk_theming_engine_load(BYVAL AS CONST gchar PTR) AS GtkThemingEngine PTR
DECLARE FUNCTION gtk_theming_engine_get_screen(BYVAL AS GtkThemingEngine PTR) AS GdkScreen PTR

#ENDIF ' __GTK_THEMING_ENGINE_H__

#IFNDEF __GTK_TOOLBAR_H__
#DEFINE __GTK_TOOLBAR_H__

#DEFINE GTK_TYPE_TOOLBAR (gtk_toolbar_get_type ())
#DEFINE GTK_TOOLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOLBAR, GtkToolbar))
#DEFINE GTK_TOOLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOOLBAR, GtkToolbarClass))
#DEFINE GTK_IS_TOOLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOLBAR))
#DEFINE GTK_IS_TOOLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOOLBAR))
#DEFINE GTK_TOOLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TOOLBAR, GtkToolbarClass))

ENUM GtkToolbarSpaceStyle
  GTK_TOOLBAR_SPACE_EMPTY
  GTK_TOOLBAR_SPACE_LINE
END ENUM

TYPE GtkToolbar AS _GtkToolbar
TYPE GtkToolbarPrivate AS _GtkToolbarPrivate
TYPE GtkToolbarClass AS _GtkToolbarClass

TYPE _GtkToolbar
  AS GtkContainer container
  AS GtkToolbarPrivate PTR priv
END TYPE

TYPE _GtkToolbarClass
  AS GtkContainerClass parent_class
  orientation_changed AS SUB(BYVAL AS GtkToolbar PTR, BYVAL AS GtkOrientation)
  style_changed AS SUB(BYVAL AS GtkToolbar PTR, BYVAL AS GtkToolbarStyle)
  popup_context_menu AS FUNCTION(BYVAL AS GtkToolbar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS gboolean
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_toolbar_get_type() AS GType
DECLARE FUNCTION gtk_toolbar_new() AS GtkWidget PTR
DECLARE SUB gtk_toolbar_insert(BYVAL AS GtkToolbar PTR, BYVAL AS GtkToolItem PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_toolbar_get_item_index(BYVAL AS GtkToolbar PTR, BYVAL AS GtkToolItem PTR) AS gint
DECLARE FUNCTION gtk_toolbar_get_n_items(BYVAL AS GtkToolbar PTR) AS gint
DECLARE FUNCTION gtk_toolbar_get_nth_item(BYVAL AS GtkToolbar PTR, BYVAL AS gint) AS GtkToolItem PTR
DECLARE FUNCTION gtk_toolbar_get_show_arrow(BYVAL AS GtkToolbar PTR) AS gboolean
DECLARE SUB gtk_toolbar_set_show_arrow(BYVAL AS GtkToolbar PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_toolbar_get_style(BYVAL AS GtkToolbar PTR) AS GtkToolbarStyle
DECLARE SUB gtk_toolbar_set_style(BYVAL AS GtkToolbar PTR, BYVAL AS GtkToolbarStyle)
DECLARE SUB gtk_toolbar_unset_style(BYVAL AS GtkToolbar PTR)
DECLARE FUNCTION gtk_toolbar_get_icon_size(BYVAL AS GtkToolbar PTR) AS GtkIconSize
DECLARE SUB gtk_toolbar_set_icon_size(BYVAL AS GtkToolbar PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_toolbar_unset_icon_size(BYVAL AS GtkToolbar PTR)
DECLARE FUNCTION gtk_toolbar_get_relief_style(BYVAL AS GtkToolbar PTR) AS GtkReliefStyle
DECLARE FUNCTION gtk_toolbar_get_drop_index(BYVAL AS GtkToolbar PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE SUB gtk_toolbar_set_drop_highlight_item(BYVAL AS GtkToolbar PTR, BYVAL AS GtkToolItem PTR, BYVAL AS gint)
DECLARE FUNCTION _gtk_toolbar_elide_underscores(BYVAL AS CONST gchar PTR) AS gchar PTR
DECLARE SUB _gtk_toolbar_paint_space_line(BYVAL AS GtkWidget PTR, BYVAL AS GtkToolbar PTR, BYVAL AS cairo_t PTR)
DECLARE FUNCTION _gtk_toolbar_get_default_space_size() AS gint

#ENDIF ' __GTK_TOOLBAR_H__

#IFNDEF __GTK_TOOL_ITEM_GROUP_H__
#DEFINE __GTK_TOOL_ITEM_GROUP_H__

#DEFINE GTK_TYPE_TOOL_ITEM_GROUP (gtk_tool_item_group_get_type ())
#DEFINE GTK_TOOL_ITEM_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST (obj, GTK_TYPE_TOOL_ITEM_GROUP, GtkToolItemGroup))
#DEFINE GTK_TOOL_ITEM_GROUP_CLASS(cls) (G_TYPE_CHECK_CLASS_CAST (cls, GTK_TYPE_TOOL_ITEM_GROUP, GtkToolItemGroupClass))
#DEFINE GTK_IS_TOOL_ITEM_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE (obj, GTK_TYPE_TOOL_ITEM_GROUP))
#DEFINE GTK_IS_TOOL_ITEM_GROUP_CLASS(obj) (G_TYPE_CHECK_CLASS_TYPE (obj, GTK_TYPE_TOOL_ITEM_GROUP))
#DEFINE GTK_TOOL_ITEM_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TOOL_ITEM_GROUP, GtkToolItemGroupClass))

TYPE GtkToolItemGroup AS _GtkToolItemGroup
TYPE GtkToolItemGroupClass AS _GtkToolItemGroupClass
TYPE GtkToolItemGroupPrivate AS _GtkToolItemGroupPrivate

TYPE _GtkToolItemGroup
  AS GtkContainer parent_instance
  AS GtkToolItemGroupPrivate PTR priv
END TYPE

TYPE _GtkToolItemGroupClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tool_item_group_get_type() AS GType
DECLARE FUNCTION gtk_tool_item_group_new(BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE SUB gtk_tool_item_group_set_label(BYVAL AS GtkToolItemGroup PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gtk_tool_item_group_set_label_widget(BYVAL AS GtkToolItemGroup PTR, BYVAL AS GtkWidget PTR)
DECLARE SUB gtk_tool_item_group_set_collapsed(BYVAL AS GtkToolItemGroup PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tool_item_group_set_ellipsize(BYVAL AS GtkToolItemGroup PTR, BYVAL AS PangoEllipsizeMode)
DECLARE SUB gtk_tool_item_group_set_header_relief(BYVAL AS GtkToolItemGroup PTR, BYVAL AS GtkReliefStyle)
DECLARE FUNCTION gtk_tool_item_group_get_label(BYVAL AS GtkToolItemGroup PTR) AS CONST gchar PTR
DECLARE FUNCTION gtk_tool_item_group_get_label_widget(BYVAL AS GtkToolItemGroup PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_tool_item_group_get_collapsed(BYVAL AS GtkToolItemGroup PTR) AS gboolean
DECLARE FUNCTION gtk_tool_item_group_get_ellipsize(BYVAL AS GtkToolItemGroup PTR) AS PangoEllipsizeMode
DECLARE FUNCTION gtk_tool_item_group_get_header_relief(BYVAL AS GtkToolItemGroup PTR) AS GtkReliefStyle
DECLARE SUB gtk_tool_item_group_insert(BYVAL AS GtkToolItemGroup PTR, BYVAL AS GtkToolItem PTR, BYVAL AS gint)
DECLARE SUB gtk_tool_item_group_set_item_position(BYVAL AS GtkToolItemGroup PTR, BYVAL AS GtkToolItem PTR, BYVAL AS gint)
DECLARE FUNCTION gtk_tool_item_group_get_item_position(BYVAL AS GtkToolItemGroup PTR, BYVAL AS GtkToolItem PTR) AS gint
DECLARE FUNCTION gtk_tool_item_group_get_n_items(BYVAL AS GtkToolItemGroup PTR) AS guint
DECLARE FUNCTION gtk_tool_item_group_get_nth_item(BYVAL AS GtkToolItemGroup PTR, BYVAL AS guint) AS GtkToolItem PTR
DECLARE FUNCTION gtk_tool_item_group_get_drop_item(BYVAL AS GtkToolItemGroup PTR, BYVAL AS gint, BYVAL AS gint) AS GtkToolItem PTR

#ENDIF ' __GTK_TOOL_ITEM_GROUP_H__

#IFNDEF __GTK_TOOL_PALETTE_H__
#DEFINE __GTK_TOOL_PALETTE_H__

#DEFINE GTK_TYPE_TOOL_PALETTE (gtk_tool_palette_get_type ())
#DEFINE GTK_TOOL_PALETTE(obj) (G_TYPE_CHECK_INSTANCE_CAST (obj, GTK_TYPE_TOOL_PALETTE, GtkToolPalette))
#DEFINE GTK_TOOL_PALETTE_CLASS(cls) (G_TYPE_CHECK_CLASS_CAST (cls, GTK_TYPE_TOOL_PALETTE, GtkToolPaletteClass))
#DEFINE GTK_IS_TOOL_PALETTE(obj) (G_TYPE_CHECK_INSTANCE_TYPE (obj, GTK_TYPE_TOOL_PALETTE))
#DEFINE GTK_IS_TOOL_PALETTE_CLASS(obj) (G_TYPE_CHECK_CLASS_TYPE (obj, GTK_TYPE_TOOL_PALETTE))
#DEFINE GTK_TOOL_PALETTE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TOOL_PALETTE, GtkToolPaletteClass))

TYPE GtkToolPalette AS _GtkToolPalette
TYPE GtkToolPaletteClass AS _GtkToolPaletteClass
TYPE GtkToolPalettePrivate AS _GtkToolPalettePrivate

ENUM GtkToolPaletteDragTargets
  GTK_TOOL_PALETTE_DRAG_ITEMS = (1 SHL 0)
  GTK_TOOL_PALETTE_DRAG_GROUPS = (1 SHL 1)
END ENUM

TYPE _GtkToolPalette
  AS GtkContainer parent_instance
  AS GtkToolPalettePrivate PTR priv
END TYPE

TYPE _GtkToolPaletteClass
  AS GtkContainerClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tool_palette_get_type() AS GType
DECLARE FUNCTION gtk_tool_palette_new() AS GtkWidget PTR
DECLARE SUB gtk_tool_palette_set_group_position(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolItemGroup PTR, BYVAL AS gint)
DECLARE SUB gtk_tool_palette_set_exclusive(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolItemGroup PTR, BYVAL AS gboolean)
DECLARE SUB gtk_tool_palette_set_expand(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolItemGroup PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_tool_palette_get_group_position(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolItemGroup PTR) AS gint
DECLARE FUNCTION gtk_tool_palette_get_exclusive(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolItemGroup PTR) AS gboolean
DECLARE FUNCTION gtk_tool_palette_get_expand(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolItemGroup PTR) AS gboolean
DECLARE SUB gtk_tool_palette_set_icon_size(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkIconSize)
DECLARE SUB gtk_tool_palette_unset_icon_size(BYVAL AS GtkToolPalette PTR)
DECLARE SUB gtk_tool_palette_set_style(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolbarStyle)
DECLARE SUB gtk_tool_palette_unset_style(BYVAL AS GtkToolPalette PTR)
DECLARE FUNCTION gtk_tool_palette_get_icon_size(BYVAL AS GtkToolPalette PTR) AS GtkIconSize
DECLARE FUNCTION gtk_tool_palette_get_style(BYVAL AS GtkToolPalette PTR) AS GtkToolbarStyle
DECLARE FUNCTION gtk_tool_palette_get_drop_item(BYVAL AS GtkToolPalette PTR, BYVAL AS gint, BYVAL AS gint) AS GtkToolItem PTR
DECLARE FUNCTION gtk_tool_palette_get_drop_group(BYVAL AS GtkToolPalette PTR, BYVAL AS gint, BYVAL AS gint) AS GtkToolItemGroup PTR
DECLARE FUNCTION gtk_tool_palette_get_drag_item(BYVAL AS GtkToolPalette PTR, BYVAL AS CONST GtkSelectionData PTR) AS GtkWidget PTR
DECLARE SUB gtk_tool_palette_set_drag_source(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkToolPaletteDragTargets)
DECLARE SUB gtk_tool_palette_add_drag_dest(BYVAL AS GtkToolPalette PTR, BYVAL AS GtkWidget PTR, BYVAL AS GtkDestDefaults, BYVAL AS GtkToolPaletteDragTargets, BYVAL AS GdkDragAction)

#IFNDEF GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_tool_palette_get_hadjustment(BYVAL AS GtkToolPalette PTR) AS GtkAdjustment PTR
DECLARE FUNCTION gtk_tool_palette_get_vadjustment(BYVAL AS GtkToolPalette PTR) AS GtkAdjustment PTR

#ENDIF ' GTK_DISABLE_DEPRECATED

DECLARE FUNCTION gtk_tool_palette_get_drag_target_item() AS CONST GtkTargetEntry PTR
DECLARE FUNCTION gtk_tool_palette_get_drag_target_group() AS CONST GtkTargetEntry PTR

#ENDIF ' __GTK_TOOL_PALETTE_H__

#IFNDEF __GTK_TOOL_SHELL_H__
#DEFINE __GTK_TOOL_SHELL_H__

#DEFINE GTK_TYPE_TOOL_SHELL (gtk_tool_shell_get_type ())
#DEFINE GTK_TOOL_SHELL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOL_SHELL, GtkToolShell))
#DEFINE GTK_IS_TOOL_SHELL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOL_SHELL))
#DEFINE GTK_TOOL_SHELL_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TOOL_SHELL, GtkToolShellIface))

TYPE GtkToolShell AS _GtkToolShell
TYPE GtkToolShellIface AS _GtkToolShellIface

TYPE _GtkToolShellIface
  AS GTypeInterface g_iface
  get_icon_size AS FUNCTION(BYVAL AS GtkToolShell PTR) AS GtkIconSize
  get_orientation AS FUNCTION(BYVAL AS GtkToolShell PTR) AS GtkOrientation
  get_style AS FUNCTION(BYVAL AS GtkToolShell PTR) AS GtkToolbarStyle
  get_relief_style AS FUNCTION(BYVAL AS GtkToolShell PTR) AS GtkReliefStyle
  rebuild_menu AS SUB(BYVAL AS GtkToolShell PTR)
  get_text_orientation AS FUNCTION(BYVAL AS GtkToolShell PTR) AS GtkOrientation
  get_text_alignment AS FUNCTION(BYVAL AS GtkToolShell PTR) AS gfloat
  get_ellipsize_mode AS FUNCTION(BYVAL AS GtkToolShell PTR) AS PangoEllipsizeMode
  get_text_size_group AS FUNCTION(BYVAL AS GtkToolShell PTR) AS GtkSizeGroup PTR
END TYPE

DECLARE FUNCTION gtk_tool_shell_get_type() AS GType
DECLARE FUNCTION gtk_tool_shell_get_icon_size(BYVAL AS GtkToolShell PTR) AS GtkIconSize
DECLARE FUNCTION gtk_tool_shell_get_orientation(BYVAL AS GtkToolShell PTR) AS GtkOrientation
DECLARE FUNCTION gtk_tool_shell_get_style(BYVAL AS GtkToolShell PTR) AS GtkToolbarStyle
DECLARE FUNCTION gtk_tool_shell_get_relief_style(BYVAL AS GtkToolShell PTR) AS GtkReliefStyle
DECLARE SUB gtk_tool_shell_rebuild_menu(BYVAL AS GtkToolShell PTR)
DECLARE FUNCTION gtk_tool_shell_get_text_orientation(BYVAL AS GtkToolShell PTR) AS GtkOrientation
DECLARE FUNCTION gtk_tool_shell_get_text_alignment(BYVAL AS GtkToolShell PTR) AS gfloat
DECLARE FUNCTION gtk_tool_shell_get_ellipsize_mode(BYVAL AS GtkToolShell PTR) AS PangoEllipsizeMode
DECLARE FUNCTION gtk_tool_shell_get_text_size_group(BYVAL AS GtkToolShell PTR) AS GtkSizeGroup PTR

#ENDIF ' __GTK_TOOL_SHELL_H__

#IFNDEF __GTK_TEST_UTILS_H__
#DEFINE __GTK_TEST_UTILS_H__

DECLARE SUB gtk_test_init(BYVAL AS INTEGER PTR, BYVAL AS ZSTRING PTR PTR PTR, ...)
DECLARE SUB gtk_test_register_all_types()
DECLARE FUNCTION gtk_test_list_all_types(BYVAL AS guint PTR) AS CONST GType PTR
DECLARE FUNCTION gtk_test_find_widget(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR, BYVAL AS GType) AS GtkWidget PTR
DECLARE FUNCTION gtk_test_create_widget(BYVAL AS GType, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE FUNCTION gtk_test_create_simple_window(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_test_display_button_window(BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, ...) AS GtkWidget PTR
DECLARE SUB gtk_test_slider_set_perc(BYVAL AS GtkWidget PTR, BYVAL AS DOUBLE)
DECLARE FUNCTION gtk_test_slider_get_value(BYVAL AS GtkWidget PTR) AS DOUBLE
DECLARE FUNCTION gtk_test_spin_button_click(BYVAL AS GtkSpinButton PTR, BYVAL AS guint, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gtk_test_widget_click(BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE FUNCTION gtk_test_widget_send_key(BYVAL AS GtkWidget PTR, BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
DECLARE SUB gtk_test_text_set(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gtk_test_text_get(BYVAL AS GtkWidget PTR) AS gchar PTR
DECLARE FUNCTION gtk_test_find_sibling(BYVAL AS GtkWidget PTR, BYVAL AS GType) AS GtkWidget PTR
DECLARE FUNCTION gtk_test_find_label(BYVAL AS GtkWidget PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR

#ENDIF ' __GTK_TEST_UTILS_H__

#IFNDEF __GTK_TREE_DND_H__
#DEFINE __GTK_TREE_DND_H__

#DEFINE GTK_TYPE_TREE_DRAG_SOURCE (gtk_tree_drag_source_get_type ())
#DEFINE GTK_TREE_DRAG_SOURCE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_DRAG_SOURCE, GtkTreeDragSource))
#DEFINE GTK_IS_TREE_DRAG_SOURCE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_DRAG_SOURCE))
#DEFINE GTK_TREE_DRAG_SOURCE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_DRAG_SOURCE, GtkTreeDragSourceIface))

TYPE GtkTreeDragSource AS _GtkTreeDragSource
TYPE GtkTreeDragSourceIface AS _GtkTreeDragSourceIface

TYPE _GtkTreeDragSourceIface
  AS GTypeInterface g_iface
  row_draggable AS FUNCTION(BYVAL AS GtkTreeDragSource PTR, BYVAL AS GtkTreePath PTR) AS gboolean
  drag_data_get AS FUNCTION(BYVAL AS GtkTreeDragSource PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkSelectionData PTR) AS gboolean
  drag_data_delete AS FUNCTION(BYVAL AS GtkTreeDragSource PTR, BYVAL AS GtkTreePath PTR) AS gboolean
END TYPE

DECLARE FUNCTION gtk_tree_drag_source_get_type() AS GType
DECLARE FUNCTION gtk_tree_drag_source_row_draggable(BYVAL AS GtkTreeDragSource PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_drag_source_drag_data_delete(BYVAL AS GtkTreeDragSource PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_drag_source_drag_data_get(BYVAL AS GtkTreeDragSource PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkSelectionData PTR) AS gboolean

#DEFINE GTK_TYPE_TREE_DRAG_DEST (gtk_tree_drag_dest_get_type ())
#DEFINE GTK_TREE_DRAG_DEST(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_DRAG_DEST, GtkTreeDragDest))
#DEFINE GTK_IS_TREE_DRAG_DEST(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_DRAG_DEST))
#DEFINE GTK_TREE_DRAG_DEST_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_TREE_DRAG_DEST, GtkTreeDragDestIface))

TYPE GtkTreeDragDest AS _GtkTreeDragDest
TYPE GtkTreeDragDestIface AS _GtkTreeDragDestIface

TYPE _GtkTreeDragDestIface
  AS GTypeInterface g_iface
  drag_data_received AS FUNCTION(BYVAL AS GtkTreeDragDest PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkSelectionData PTR) AS gboolean
  row_drop_possible AS FUNCTION(BYVAL AS GtkTreeDragDest PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkSelectionData PTR) AS gboolean
END TYPE

DECLARE FUNCTION gtk_tree_drag_dest_get_type() AS GType
DECLARE FUNCTION gtk_tree_drag_dest_drag_data_received(BYVAL AS GtkTreeDragDest PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkSelectionData PTR) AS gboolean
DECLARE FUNCTION gtk_tree_drag_dest_row_drop_possible(BYVAL AS GtkTreeDragDest PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkSelectionData PTR) AS gboolean
DECLARE FUNCTION gtk_tree_set_row_drag_data(BYVAL AS GtkSelectionData PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_get_row_drag_data(BYVAL AS GtkSelectionData PTR, BYVAL AS GtkTreeModel PTR PTR, BYVAL AS GtkTreePath PTR PTR) AS gboolean

#ENDIF ' __GTK_TREE_DND_H__

#IFNDEF __GTK_TREE_MODEL_SORT_H__
#DEFINE __GTK_TREE_MODEL_SORT_H__

#DEFINE GTK_TYPE_TREE_MODEL_SORT (gtk_tree_model_sort_get_type ())
#DEFINE GTK_TREE_MODEL_SORT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSort))
#DEFINE GTK_TREE_MODEL_SORT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSortClass))
#DEFINE GTK_IS_TREE_MODEL_SORT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_MODEL_SORT))
#DEFINE GTK_IS_TREE_MODEL_SORT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_MODEL_SORT))
#DEFINE GTK_TREE_MODEL_SORT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_MODEL_SORT, GtkTreeModelSortClass))

TYPE GtkTreeModelSort AS _GtkTreeModelSort
TYPE GtkTreeModelSortClass AS _GtkTreeModelSortClass
TYPE GtkTreeModelSortPrivate AS _GtkTreeModelSortPrivate

TYPE _GtkTreeModelSort
  AS GObject parent
  AS GtkTreeModelSortPrivate PTR priv
END TYPE

TYPE _GtkTreeModelSortClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tree_model_sort_get_type() AS GType
DECLARE FUNCTION gtk_tree_model_sort_new_with_model(BYVAL AS GtkTreeModel PTR) AS GtkTreeModel PTR
DECLARE FUNCTION gtk_tree_model_sort_get_model(BYVAL AS GtkTreeModelSort PTR) AS GtkTreeModel PTR
DECLARE FUNCTION gtk_tree_model_sort_convert_child_path_to_path(BYVAL AS GtkTreeModelSort PTR, BYVAL AS GtkTreePath PTR) AS GtkTreePath PTR
DECLARE FUNCTION gtk_tree_model_sort_convert_child_iter_to_iter(BYVAL AS GtkTreeModelSort PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_model_sort_convert_path_to_child_path(BYVAL AS GtkTreeModelSort PTR, BYVAL AS GtkTreePath PTR) AS GtkTreePath PTR
DECLARE SUB gtk_tree_model_sort_convert_iter_to_child_iter(BYVAL AS GtkTreeModelSort PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_model_sort_reset_default_sort_func(BYVAL AS GtkTreeModelSort PTR)
DECLARE SUB gtk_tree_model_sort_clear_cache(BYVAL AS GtkTreeModelSort PTR)
DECLARE FUNCTION gtk_tree_model_sort_iter_is_valid(BYVAL AS GtkTreeModelSort PTR, BYVAL AS GtkTreeIter PTR) AS gboolean

#ENDIF ' __GTK_TREE_MODEL_SORT_H__

#IFNDEF __GTK_TREE_SELECTION_H__
#DEFINE __GTK_TREE_SELECTION_H__

#DEFINE GTK_TYPE_TREE_SELECTION (gtk_tree_selection_get_type ())
#DEFINE GTK_TREE_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_SELECTION, GtkTreeSelection))
#DEFINE GTK_TREE_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_SELECTION, GtkTreeSelectionClass))
#DEFINE GTK_IS_TREE_SELECTION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_SELECTION))
#DEFINE GTK_IS_TREE_SELECTION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_SELECTION))
#DEFINE GTK_TREE_SELECTION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_SELECTION, GtkTreeSelectionClass))

TYPE GtkTreeSelectionPrivate AS _GtkTreeSelectionPrivate
TYPE GtkTreeSelectionFunc AS FUNCTION(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS gboolean, BYVAL AS gpointer) AS gboolean
TYPE GtkTreeSelectionForeachFunc AS SUB(BYVAL AS GtkTreeModel PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gpointer)

TYPE _GtkTreeSelection
  AS GObject parent
  AS GtkTreeSelectionPrivate PTR priv
END TYPE

TYPE _GtkTreeSelectionClass
  AS GObjectClass parent_class
  changed AS SUB(BYVAL AS GtkTreeSelection PTR)
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tree_selection_get_type() AS GType
DECLARE SUB gtk_tree_selection_set_mode(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkSelectionMode)
DECLARE FUNCTION gtk_tree_selection_get_mode(BYVAL AS GtkTreeSelection PTR) AS GtkSelectionMode
DECLARE SUB gtk_tree_selection_set_select_function(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeSelectionFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gtk_tree_selection_get_user_data(BYVAL AS GtkTreeSelection PTR) AS gpointer
DECLARE FUNCTION gtk_tree_selection_get_tree_view(BYVAL AS GtkTreeSelection PTR) AS GtkTreeView PTR
DECLARE FUNCTION gtk_tree_selection_get_select_function(BYVAL AS GtkTreeSelection PTR) AS GtkTreeSelectionFunc
DECLARE FUNCTION gtk_tree_selection_get_selected(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeModel PTR PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_selection_get_selected_rows(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeModel PTR PTR) AS GList PTR
DECLARE FUNCTION gtk_tree_selection_count_selected_rows(BYVAL AS GtkTreeSelection PTR) AS gint
DECLARE SUB gtk_tree_selection_selected_foreach(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeSelectionForeachFunc, BYVAL AS gpointer)
DECLARE SUB gtk_tree_selection_select_path(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_selection_unselect_path(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_selection_select_iter(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_selection_unselect_iter(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeIter PTR)
DECLARE FUNCTION gtk_tree_selection_path_is_selected(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreePath PTR) AS gboolean
DECLARE FUNCTION gtk_tree_selection_iter_is_selected(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_tree_selection_select_all(BYVAL AS GtkTreeSelection PTR)
DECLARE SUB gtk_tree_selection_unselect_all(BYVAL AS GtkTreeSelection PTR)
DECLARE SUB gtk_tree_selection_select_range(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreePath PTR)
DECLARE SUB gtk_tree_selection_unselect_range(BYVAL AS GtkTreeSelection PTR, BYVAL AS GtkTreePath PTR, BYVAL AS GtkTreePath PTR)

#ENDIF ' __GTK_TREE_SELECTION_H__

#IFNDEF __GTK_TREE_STORE_H__
#DEFINE __GTK_TREE_STORE_H__

#INCLUDE ONCE "crt/stdarg.bi"
#DEFINE GTK_TYPE_TREE_STORE (gtk_tree_store_get_type ())
#DEFINE GTK_TREE_STORE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TREE_STORE, GtkTreeStore))
#DEFINE GTK_TREE_STORE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TREE_STORE, GtkTreeStoreClass))
#DEFINE GTK_IS_TREE_STORE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TREE_STORE))
#DEFINE GTK_IS_TREE_STORE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TREE_STORE))
#DEFINE GTK_TREE_STORE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TREE_STORE, GtkTreeStoreClass))

TYPE GtkTreeStore AS _GtkTreeStore
TYPE GtkTreeStoreClass AS _GtkTreeStoreClass
TYPE GtkTreeStorePrivate AS _GtkTreeStorePrivate

TYPE _GtkTreeStore
  AS GObject parent
  AS GtkTreeStorePrivate PTR priv
END TYPE

TYPE _GtkTreeStoreClass
  AS GObjectClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_tree_store_get_type() AS GType
DECLARE FUNCTION gtk_tree_store_new(BYVAL AS gint, ...) AS GtkTreeStore PTR
DECLARE FUNCTION gtk_tree_store_newv(BYVAL AS gint, BYVAL AS GType PTR) AS GtkTreeStore PTR
DECLARE SUB gtk_tree_store_set_column_types(BYVAL AS GtkTreeStore PTR, BYVAL AS gint, BYVAL AS GType PTR)
DECLARE SUB gtk_tree_store_set_value(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, BYVAL AS GValue PTR)
DECLARE SUB gtk_tree_store_set(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, ...)
DECLARE SUB gtk_tree_store_set_valuesv(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint PTR, BYVAL AS GValue PTR, BYVAL AS gint)
DECLARE SUB gtk_tree_store_set_valist(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS va_list)
DECLARE FUNCTION gtk_tree_store_remove(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_tree_store_insert(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint)
DECLARE SUB gtk_tree_store_insert_before(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_store_insert_after(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_store_insert_with_values(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, ...)
DECLARE SUB gtk_tree_store_insert_with_valuesv(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS GValue PTR, BYVAL AS gint)
DECLARE SUB gtk_tree_store_prepend(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_store_append(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE FUNCTION gtk_tree_store_is_ancestor(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE FUNCTION gtk_tree_store_iter_depth(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR) AS gint
DECLARE SUB gtk_tree_store_clear(BYVAL AS GtkTreeStore PTR)
DECLARE FUNCTION gtk_tree_store_iter_is_valid(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR) AS gboolean
DECLARE SUB gtk_tree_store_reorder(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS gint PTR)
DECLARE SUB gtk_tree_store_swap(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_store_move_before(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)
DECLARE SUB gtk_tree_store_move_after(BYVAL AS GtkTreeStore PTR, BYVAL AS GtkTreeIter PTR, BYVAL AS GtkTreeIter PTR)

#ENDIF ' __GTK_TREE_STORE_H__

#IFNDEF __GTK_TYPE_BUILTINS_H__
#DEFINE __GTK_TYPE_BUILTINS_H__

DECLARE FUNCTION gtk_license_get_type() AS GType
#DEFINE GTK_TYPE_LICENSE (gtk_license_get_type ())
DECLARE FUNCTION gtk_accel_flags_get_type() AS GType
#DEFINE GTK_TYPE_ACCEL_FLAGS (gtk_accel_flags_get_type ())
DECLARE FUNCTION gtk_assistant_page_type_get_type() AS GType
#DEFINE GTK_TYPE_ASSISTANT_PAGE_TYPE (gtk_assistant_page_type_get_type ())
DECLARE FUNCTION gtk_builder_error_get_type() AS GType
#DEFINE GTK_TYPE_BUILDER_ERROR (gtk_builder_error_get_type ())
DECLARE FUNCTION gtk_calendar_display_options_get_type() AS GType
#DEFINE GTK_TYPE_CALENDAR_DISPLAY_OPTIONS (gtk_calendar_display_options_get_type ())
DECLARE FUNCTION gtk_cell_renderer_state_get_type() AS GType
#DEFINE GTK_TYPE_CELL_RENDERER_STATE (gtk_cell_renderer_state_get_type ())
DECLARE FUNCTION gtk_cell_renderer_mode_get_type() AS GType
#DEFINE GTK_TYPE_CELL_RENDERER_MODE (gtk_cell_renderer_mode_get_type ())
DECLARE FUNCTION gtk_cell_renderer_accel_mode_get_type() AS GType
#DEFINE GTK_TYPE_CELL_RENDERER_ACCEL_MODE (gtk_cell_renderer_accel_mode_get_type ())
DECLARE FUNCTION gtk_css_provider_error_get_type() AS GType
#DEFINE GTK_TYPE_CSS_PROVIDER_ERROR (gtk_css_provider_error_get_type ())
DECLARE FUNCTION gtk_css_section_type_get_type() AS GType
#DEFINE GTK_TYPE_CSS_SECTION_TYPE (gtk_css_section_type_get_type ())
DECLARE FUNCTION gtk_debug_flag_get_type() AS GType
#DEFINE GTK_TYPE_DEBUG_FLAG (gtk_debug_flag_get_type ())
DECLARE FUNCTION gtk_dialog_flags_get_type() AS GType
#DEFINE GTK_TYPE_DIALOG_FLAGS (gtk_dialog_flags_get_type ())
DECLARE FUNCTION gtk_response_type_get_type() AS GType
#DEFINE GTK_TYPE_RESPONSE_TYPE (gtk_response_type_get_type ())
DECLARE FUNCTION gtk_dest_defaults_get_type() AS GType
#DEFINE GTK_TYPE_DEST_DEFAULTS (gtk_dest_defaults_get_type ())
DECLARE FUNCTION gtk_target_flags_get_type() AS GType
#DEFINE GTK_TYPE_TARGET_FLAGS (gtk_target_flags_get_type ())
DECLARE FUNCTION gtk_entry_icon_position_get_type() AS GType
#DEFINE GTK_TYPE_ENTRY_ICON_POSITION (gtk_entry_icon_position_get_type ())
DECLARE FUNCTION gtk_align_get_type() AS GType
#DEFINE GTK_TYPE_ALIGN (gtk_align_get_type ())
DECLARE FUNCTION gtk_arrow_placement_get_type() AS GType
#DEFINE GTK_TYPE_ARROW_PLACEMENT (gtk_arrow_placement_get_type ())
DECLARE FUNCTION gtk_arrow_type_get_type() AS GType
#DEFINE GTK_TYPE_ARROW_TYPE (gtk_arrow_type_get_type ())
DECLARE FUNCTION gtk_attach_options_get_type() AS GType
#DEFINE GTK_TYPE_ATTACH_OPTIONS (gtk_attach_options_get_type ())
DECLARE FUNCTION gtk_button_box_style_get_type() AS GType
#DEFINE GTK_TYPE_BUTTON_BOX_STYLE (gtk_button_box_style_get_type ())
DECLARE FUNCTION gtk_delete_type_get_type() AS GType
#DEFINE GTK_TYPE_DELETE_TYPE (gtk_delete_type_get_type ())
DECLARE FUNCTION gtk_direction_type_get_type() AS GType
#DEFINE GTK_TYPE_DIRECTION_TYPE (gtk_direction_type_get_type ())
DECLARE FUNCTION gtk_expander_style_get_type() AS GType
#DEFINE GTK_TYPE_EXPANDER_STYLE (gtk_expander_style_get_type ())
DECLARE FUNCTION gtk_icon_size_get_type() AS GType
#DEFINE GTK_TYPE_ICON_SIZE (gtk_icon_size_get_type ())
DECLARE FUNCTION gtk_sensitivity_type_get_type() AS GType
#DEFINE GTK_TYPE_SENSITIVITY_TYPE (gtk_sensitivity_type_get_type ())
DECLARE FUNCTION gtk_text_direction_get_type() AS GType
#DEFINE GTK_TYPE_TEXT_DIRECTION (gtk_text_direction_get_type ())
DECLARE FUNCTION gtk_justification_get_type() AS GType
#DEFINE GTK_TYPE_JUSTIFICATION (gtk_justification_get_type ())
DECLARE FUNCTION gtk_menu_direction_type_get_type() AS GType
#DEFINE GTK_TYPE_MENU_DIRECTION_TYPE (gtk_menu_direction_type_get_type ())
DECLARE FUNCTION gtk_message_type_get_type() AS GType
#DEFINE GTK_TYPE_MESSAGE_TYPE (gtk_message_type_get_type ())
DECLARE FUNCTION gtk_movement_step_get_type() AS GType
#DEFINE GTK_TYPE_MOVEMENT_STEP (gtk_movement_step_get_type ())
DECLARE FUNCTION gtk_scroll_step_get_type() AS GType
#DEFINE GTK_TYPE_SCROLL_STEP (gtk_scroll_step_get_type ())
DECLARE FUNCTION gtk_orientation_get_type() AS GType
#DEFINE GTK_TYPE_ORIENTATION (gtk_orientation_get_type ())
DECLARE FUNCTION gtk_corner_type_get_type() AS GType
#DEFINE GTK_TYPE_CORNER_TYPE (gtk_corner_type_get_type ())
DECLARE FUNCTION gtk_pack_type_get_type() AS GType
#DEFINE GTK_TYPE_PACK_TYPE (gtk_pack_type_get_type ())
DECLARE FUNCTION gtk_path_priority_type_get_type() AS GType
#DEFINE GTK_TYPE_PATH_PRIORITY_TYPE (gtk_path_priority_type_get_type ())
DECLARE FUNCTION gtk_path_type_get_type() AS GType
#DEFINE GTK_TYPE_PATH_TYPE (gtk_path_type_get_type ())
DECLARE FUNCTION gtk_policy_type_get_type() AS GType
#DEFINE GTK_TYPE_POLICY_TYPE (gtk_policy_type_get_type ())
DECLARE FUNCTION gtk_position_type_get_type() AS GType
#DEFINE GTK_TYPE_POSITION_TYPE (gtk_position_type_get_type ())
DECLARE FUNCTION gtk_relief_style_get_type() AS GType
#DEFINE GTK_TYPE_RELIEF_STYLE (gtk_relief_style_get_type ())
DECLARE FUNCTION gtk_resize_mode_get_type() AS GType
#DEFINE GTK_TYPE_RESIZE_MODE (gtk_resize_mode_get_type ())
DECLARE FUNCTION gtk_scroll_type_get_type() AS GType
#DEFINE GTK_TYPE_SCROLL_TYPE (gtk_scroll_type_get_type ())
DECLARE FUNCTION gtk_selection_mode_get_type() AS GType
#DEFINE GTK_TYPE_SELECTION_MODE (gtk_selection_mode_get_type ())
DECLARE FUNCTION gtk_shadow_type_get_type() AS GType
#DEFINE GTK_TYPE_SHADOW_TYPE (gtk_shadow_type_get_type ())
DECLARE FUNCTION gtk_state_type_get_type() AS GType
#DEFINE GTK_TYPE_STATE_TYPE (gtk_state_type_get_type ())
DECLARE FUNCTION gtk_toolbar_style_get_type() AS GType
#DEFINE GTK_TYPE_TOOLBAR_STYLE (gtk_toolbar_style_get_type ())
DECLARE FUNCTION gtk_window_position_get_type() AS GType
#DEFINE GTK_TYPE_WINDOW_POSITION (gtk_window_position_get_type ())
DECLARE FUNCTION gtk_window_type_get_type() AS GType
#DEFINE GTK_TYPE_WINDOW_TYPE (gtk_window_type_get_type ())
DECLARE FUNCTION gtk_wrap_mode_get_type() AS GType
#DEFINE GTK_TYPE_WRAP_MODE (gtk_wrap_mode_get_type ())
DECLARE FUNCTION gtk_sort_type_get_type() AS GType
#DEFINE GTK_TYPE_SORT_TYPE (gtk_sort_type_get_type ())
DECLARE FUNCTION gtk_im_preedit_style_get_type() AS GType
#DEFINE GTK_TYPE_IM_PREEDIT_STYLE (gtk_im_preedit_style_get_type ())
DECLARE FUNCTION gtk_im_status_style_get_type() AS GType
#DEFINE GTK_TYPE_IM_STATUS_STYLE (gtk_im_status_style_get_type ())
DECLARE FUNCTION gtk_pack_direction_get_type() AS GType
#DEFINE GTK_TYPE_PACK_DIRECTION (gtk_pack_direction_get_type ())
DECLARE FUNCTION gtk_print_pages_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_PAGES (gtk_print_pages_get_type ())
DECLARE FUNCTION gtk_page_set_get_type() AS GType
#DEFINE GTK_TYPE_PAGE_SET (gtk_page_set_get_type ())
DECLARE FUNCTION gtk_number_up_layout_get_type() AS GType
#DEFINE GTK_TYPE_NUMBER_UP_LAYOUT (gtk_number_up_layout_get_type ())
DECLARE FUNCTION gtk_page_orientation_get_type() AS GType
#DEFINE GTK_TYPE_PAGE_ORIENTATION (gtk_page_orientation_get_type ())
DECLARE FUNCTION gtk_print_quality_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_QUALITY (gtk_print_quality_get_type ())
DECLARE FUNCTION gtk_print_duplex_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_DUPLEX (gtk_print_duplex_get_type ())
DECLARE FUNCTION gtk_unit_get_type() AS GType
#DEFINE GTK_TYPE_UNIT (gtk_unit_get_type ())
DECLARE FUNCTION gtk_tree_view_grid_lines_get_type() AS GType
#DEFINE GTK_TYPE_TREE_VIEW_GRID_LINES (gtk_tree_view_grid_lines_get_type ())
DECLARE FUNCTION gtk_drag_result_get_type() AS GType
#DEFINE GTK_TYPE_DRAG_RESULT (gtk_drag_result_get_type ())
DECLARE FUNCTION gtk_size_request_mode_get_type() AS GType
#DEFINE GTK_TYPE_SIZE_REQUEST_MODE (gtk_size_request_mode_get_type ())
DECLARE FUNCTION gtk_scrollable_policy_get_type() AS GType
#DEFINE GTK_TYPE_SCROLLABLE_POLICY (gtk_scrollable_policy_get_type ())
DECLARE FUNCTION gtk_state_flags_get_type() AS GType
#DEFINE GTK_TYPE_STATE_FLAGS (gtk_state_flags_get_type ())
DECLARE FUNCTION gtk_region_flags_get_type() AS GType
#DEFINE GTK_TYPE_REGION_FLAGS (gtk_region_flags_get_type ())
DECLARE FUNCTION gtk_junction_sides_get_type() AS GType
#DEFINE GTK_TYPE_JUNCTION_SIDES (gtk_junction_sides_get_type ())
DECLARE FUNCTION gtk_border_style_get_type() AS GType
#DEFINE GTK_TYPE_BORDER_STYLE (gtk_border_style_get_type ())
DECLARE FUNCTION gtk_file_chooser_action_get_type() AS GType
#DEFINE GTK_TYPE_FILE_CHOOSER_ACTION (gtk_file_chooser_action_get_type ())
DECLARE FUNCTION gtk_file_chooser_confirmation_get_type() AS GType
#DEFINE GTK_TYPE_FILE_CHOOSER_CONFIRMATION (gtk_file_chooser_confirmation_get_type ())
DECLARE FUNCTION gtk_file_chooser_error_get_type() AS GType
#DEFINE GTK_TYPE_FILE_CHOOSER_ERROR (gtk_file_chooser_error_get_type ())
DECLARE FUNCTION gtk_file_filter_flags_get_type() AS GType
#DEFINE GTK_TYPE_FILE_FILTER_FLAGS (gtk_file_filter_flags_get_type ())
DECLARE FUNCTION gtk_icon_lookup_flags_get_type() AS GType
#DEFINE GTK_TYPE_ICON_LOOKUP_FLAGS (gtk_icon_lookup_flags_get_type ())
DECLARE FUNCTION gtk_icon_theme_error_get_type() AS GType
#DEFINE GTK_TYPE_ICON_THEME_ERROR (gtk_icon_theme_error_get_type ())
DECLARE FUNCTION gtk_icon_view_drop_position_get_type() AS GType
#DEFINE GTK_TYPE_ICON_VIEW_DROP_POSITION (gtk_icon_view_drop_position_get_type ())
DECLARE FUNCTION gtk_image_type_get_type() AS GType
#DEFINE GTK_TYPE_IMAGE_TYPE (gtk_image_type_get_type ())
DECLARE FUNCTION gtk_buttons_type_get_type() AS GType
#DEFINE GTK_TYPE_BUTTONS_TYPE (gtk_buttons_type_get_type ())
DECLARE FUNCTION gtk_notebook_tab_get_type() AS GType
#DEFINE GTK_TYPE_NOTEBOOK_TAB (gtk_notebook_tab_get_type ())
DECLARE FUNCTION gtk_print_status_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_STATUS (gtk_print_status_get_type ())
DECLARE FUNCTION gtk_print_operation_result_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_OPERATION_RESULT (gtk_print_operation_result_get_type ())
DECLARE FUNCTION gtk_print_operation_action_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_OPERATION_ACTION (gtk_print_operation_action_get_type ())
DECLARE FUNCTION gtk_print_error_get_type() AS GType
#DEFINE GTK_TYPE_PRINT_ERROR (gtk_print_error_get_type ())
DECLARE FUNCTION gtk_rc_flags_get_type() AS GType
#DEFINE GTK_TYPE_RC_FLAGS (gtk_rc_flags_get_type ())
DECLARE FUNCTION gtk_rc_token_type_get_type() AS GType
#DEFINE GTK_TYPE_RC_TOKEN_TYPE (gtk_rc_token_type_get_type ())
DECLARE FUNCTION gtk_recent_sort_type_get_type() AS GType
#DEFINE GTK_TYPE_RECENT_SORT_TYPE (gtk_recent_sort_type_get_type ())
DECLARE FUNCTION gtk_recent_chooser_error_get_type() AS GType
#DEFINE GTK_TYPE_RECENT_CHOOSER_ERROR (gtk_recent_chooser_error_get_type ())
DECLARE FUNCTION gtk_recent_filter_flags_get_type() AS GType
#DEFINE GTK_TYPE_RECENT_FILTER_FLAGS (gtk_recent_filter_flags_get_type ())
DECLARE FUNCTION gtk_recent_manager_error_get_type() AS GType
#DEFINE GTK_TYPE_RECENT_MANAGER_ERROR (gtk_recent_manager_error_get_type ())
DECLARE FUNCTION gtk_size_group_mode_get_type() AS GType
#DEFINE GTK_TYPE_SIZE_GROUP_MODE (gtk_size_group_mode_get_type ())
DECLARE FUNCTION gtk_spin_button_update_policy_get_type() AS GType
#DEFINE GTK_TYPE_SPIN_BUTTON_UPDATE_POLICY (gtk_spin_button_update_policy_get_type ())
DECLARE FUNCTION gtk_spin_type_get_type() AS GType
#DEFINE GTK_TYPE_SPIN_TYPE (gtk_spin_type_get_type ())
DECLARE FUNCTION gtk_text_buffer_target_info_get_type() AS GType
#DEFINE GTK_TYPE_TEXT_BUFFER_TARGET_INFO (gtk_text_buffer_target_info_get_type ())
DECLARE FUNCTION gtk_text_search_flags_get_type() AS GType
#DEFINE GTK_TYPE_TEXT_SEARCH_FLAGS (gtk_text_search_flags_get_type ())
DECLARE FUNCTION gtk_text_window_type_get_type() AS GType
#DEFINE GTK_TYPE_TEXT_WINDOW_TYPE (gtk_text_window_type_get_type ())
DECLARE FUNCTION gtk_toolbar_space_style_get_type() AS GType
#DEFINE GTK_TYPE_TOOLBAR_SPACE_STYLE (gtk_toolbar_space_style_get_type ())
DECLARE FUNCTION gtk_tool_palette_drag_targets_get_type() AS GType
#DEFINE GTK_TYPE_TOOL_PALETTE_DRAG_TARGETS (gtk_tool_palette_drag_targets_get_type ())
DECLARE FUNCTION gtk_tree_model_flags_get_type() AS GType
#DEFINE GTK_TYPE_TREE_MODEL_FLAGS (gtk_tree_model_flags_get_type ())
DECLARE FUNCTION gtk_tree_view_drop_position_get_type() AS GType
#DEFINE GTK_TYPE_TREE_VIEW_DROP_POSITION (gtk_tree_view_drop_position_get_type ())
DECLARE FUNCTION gtk_tree_view_column_sizing_get_type() AS GType
#DEFINE GTK_TYPE_TREE_VIEW_COLUMN_SIZING (gtk_tree_view_column_sizing_get_type ())
DECLARE FUNCTION gtk_ui_manager_item_type_get_type() AS GType
#DEFINE GTK_TYPE_UI_MANAGER_ITEM_TYPE (gtk_ui_manager_item_type_get_type ())
DECLARE FUNCTION gtk_widget_help_type_get_type() AS GType
#DEFINE GTK_TYPE_WIDGET_HELP_TYPE (gtk_widget_help_type_get_type ())

#ENDIF ' __GTK_TYPE_BUILTINS_H__

#IFNDEF __GTK_UI_MANAGER_H__
#DEFINE __GTK_UI_MANAGER_H__

#DEFINE GTK_TYPE_UI_MANAGER (gtk_ui_manager_get_type ())
#DEFINE GTK_UI_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_UI_MANAGER, GtkUIManager))
#DEFINE GTK_UI_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_UI_MANAGER, GtkUIManagerClass))
#DEFINE GTK_IS_UI_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_UI_MANAGER))
#DEFINE GTK_IS_UI_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_UI_MANAGER))
#DEFINE GTK_UI_MANAGER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS((obj), GTK_TYPE_UI_MANAGER, GtkUIManagerClass))

TYPE GtkUIManager AS _GtkUIManager
TYPE GtkUIManagerClass AS _GtkUIManagerClass
TYPE GtkUIManagerPrivate AS _GtkUIManagerPrivate

TYPE _GtkUIManager
  AS GObject parent
  AS GtkUIManagerPrivate PTR private_data
END TYPE

TYPE _GtkUIManagerClass
  AS GObjectClass parent_class
  add_widget AS SUB(BYVAL AS GtkUIManager PTR, BYVAL AS GtkWidget PTR)
  actions_changed AS SUB(BYVAL AS GtkUIManager PTR)
  connect_proxy AS SUB(BYVAL AS GtkUIManager PTR, BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
  disconnect_proxy AS SUB(BYVAL AS GtkUIManager PTR, BYVAL AS GtkAction PTR, BYVAL AS GtkWidget PTR)
  pre_activate AS SUB(BYVAL AS GtkUIManager PTR, BYVAL AS GtkAction PTR)
  post_activate AS SUB(BYVAL AS GtkUIManager PTR, BYVAL AS GtkAction PTR)
  get_widget AS FUNCTION(BYVAL AS GtkUIManager PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
  get_action AS FUNCTION(BYVAL AS GtkUIManager PTR, BYVAL AS CONST gchar PTR) AS GtkAction PTR
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

ENUM GtkUIManagerItemType
  GTK_UI_MANAGER_AUTO = 0
  GTK_UI_MANAGER_MENUBAR = 1 SHL 0
  GTK_UI_MANAGER_MENU = 1 SHL 1
  GTK_UI_MANAGER_TOOLBAR = 1 SHL 2
  GTK_UI_MANAGER_PLACEHOLDER = 1 SHL 3
  GTK_UI_MANAGER_POPUP = 1 SHL 4
  GTK_UI_MANAGER_MENUITEM = 1 SHL 5
  GTK_UI_MANAGER_TOOLITEM = 1 SHL 6
  GTK_UI_MANAGER_SEPARATOR = 1 SHL 7
  GTK_UI_MANAGER_ACCELERATOR = 1 SHL 8
  GTK_UI_MANAGER_POPUP_WITH_ACCELS = 1 SHL 9
END ENUM

DECLARE FUNCTION gtk_ui_manager_get_type() AS GType
DECLARE FUNCTION gtk_ui_manager_new() AS GtkUIManager PTR
DECLARE SUB gtk_ui_manager_set_add_tearoffs(BYVAL AS GtkUIManager PTR, BYVAL AS gboolean)
DECLARE FUNCTION gtk_ui_manager_get_add_tearoffs(BYVAL AS GtkUIManager PTR) AS gboolean
DECLARE SUB gtk_ui_manager_insert_action_group(BYVAL AS GtkUIManager PTR, BYVAL AS GtkActionGroup PTR, BYVAL AS gint)
DECLARE SUB gtk_ui_manager_remove_action_group(BYVAL AS GtkUIManager PTR, BYVAL AS GtkActionGroup PTR)
DECLARE FUNCTION gtk_ui_manager_get_action_groups(BYVAL AS GtkUIManager PTR) AS GList PTR
DECLARE FUNCTION gtk_ui_manager_get_accel_group(BYVAL AS GtkUIManager PTR) AS GtkAccelGroup PTR
DECLARE FUNCTION gtk_ui_manager_get_widget(BYVAL AS GtkUIManager PTR, BYVAL AS CONST gchar PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_ui_manager_get_toplevels(BYVAL AS GtkUIManager PTR, BYVAL AS GtkUIManagerItemType) AS GSList PTR
DECLARE FUNCTION gtk_ui_manager_get_action(BYVAL AS GtkUIManager PTR, BYVAL AS CONST gchar PTR) AS GtkAction PTR
DECLARE FUNCTION gtk_ui_manager_add_ui_from_string(BYVAL AS GtkUIManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS gssize, BYVAL AS GError PTR PTR) AS guint
DECLARE FUNCTION gtk_ui_manager_add_ui_from_file(BYVAL AS GtkUIManager PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS guint
DECLARE SUB gtk_ui_manager_add_ui(BYVAL AS GtkUIManager PTR, BYVAL AS guint, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS CONST gchar PTR, BYVAL AS GtkUIManagerItemType, BYVAL AS gboolean)
DECLARE SUB gtk_ui_manager_remove_ui(BYVAL AS GtkUIManager PTR, BYVAL AS guint)
DECLARE FUNCTION gtk_ui_manager_get_ui(BYVAL AS GtkUIManager PTR) AS gchar PTR
DECLARE SUB gtk_ui_manager_ensure_update(BYVAL AS GtkUIManager PTR)
DECLARE FUNCTION gtk_ui_manager_new_merge_id(BYVAL AS GtkUIManager PTR) AS guint

#ENDIF ' __GTK_UI_MANAGER_H__

#IFNDEF __GTK_VBBOX_H__
#DEFINE __GTK_VBBOX_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#DEFINE GTK_TYPE_VBUTTON_BOX (gtk_vbutton_box_get_type ())
#DEFINE GTK_VBUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VBUTTON_BOX, GtkVButtonBox))
#DEFINE GTK_VBUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VBUTTON_BOX, GtkVButtonBoxClass))
#DEFINE GTK_IS_VBUTTON_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VBUTTON_BOX))
#DEFINE GTK_IS_VBUTTON_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VBUTTON_BOX))
#DEFINE GTK_VBUTTON_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VBUTTON_BOX, GtkVButtonBoxClass))

TYPE GtkVButtonBox AS _GtkVButtonBox
TYPE GtkVButtonBoxClass AS _GtkVButtonBoxClass

TYPE _GtkVButtonBox
  AS GtkButtonBox button_box
END TYPE

TYPE _GtkVButtonBoxClass
  AS GtkButtonBoxClass parent_class
END TYPE

DECLARE FUNCTION gtk_vbutton_box_get_type() AS GType
DECLARE FUNCTION gtk_vbutton_box_new() AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_VBBOX_H__

#IFNDEF __GTK_VBOX_H__
#DEFINE __GTK_VBOX_H__

#IFNDEF GTK_DISABLE_DEPRECATED
#DEFINE GTK_TYPE_VBOX (gtk_vbox_get_type ())
#DEFINE GTK_VBOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VBOX, GtkVBox))
#DEFINE GTK_VBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VBOX, GtkVBoxClass))
#DEFINE GTK_IS_VBOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VBOX))
#DEFINE GTK_IS_VBOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VBOX))
#DEFINE GTK_VBOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VBOX, GtkVBoxClass))

TYPE GtkVBox AS _GtkVBox
TYPE GtkVBoxClass AS _GtkVBoxClass

TYPE _GtkVBox
  AS GtkBox box
END TYPE

TYPE _GtkVBoxClass
  AS GtkBoxClass parent_class
END TYPE

DECLARE FUNCTION gtk_vbox_get_type() AS GType
DECLARE FUNCTION gtk_vbox_new(BYVAL AS gboolean, BYVAL AS gint) AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_VBOX_H__

#IFNDEF __GTK_VERSION_H__
#DEFINE __GTK_VERSION_H__
#DEFINE GTK_MAJOR_VERSION (3)
#DEFINE GTK_MINOR_VERSION (2)
#DEFINE GTK_MICRO_VERSION (2)
#DEFINE GTK_BINARY_AGE (202)
#DEFINE GTK_INTERFACE_AGE (2)
#DEFINE GTK_CHECK_VERSION(major,minor,micro) _
     (GTK_MAJOR_VERSION > (major) ORELSE _
     (GTK_MAJOR_VERSION = (major) ANDALSO GTK_MINOR_VERSION > (minor)) ORELSE _
     (GTK_MAJOR_VERSION = (major) ANDALSO GTK_MINOR_VERSION = (minor) ANDALSO _
      GTK_MICRO_VERSION >= (micro)))
#ENDIF ' __GTK_VERSION_H__

#IFNDEF __GTK_VIEWPORT_H__
#DEFINE __GTK_VIEWPORT_H__

#DEFINE GTK_TYPE_VIEWPORT (gtk_viewport_get_type ())
#DEFINE GTK_VIEWPORT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VIEWPORT, GtkViewport))
#DEFINE GTK_VIEWPORT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VIEWPORT, GtkViewportClass))
#DEFINE GTK_IS_VIEWPORT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VIEWPORT))
#DEFINE GTK_IS_VIEWPORT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VIEWPORT))
#DEFINE GTK_VIEWPORT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VIEWPORT, GtkViewportClass))

TYPE GtkViewport AS _GtkViewport
TYPE GtkViewportPrivate AS _GtkViewportPrivate
TYPE GtkViewportClass AS _GtkViewportClass

TYPE _GtkViewport
  AS GtkBin bin
  AS GtkViewportPrivate PTR priv
END TYPE

TYPE _GtkViewportClass
  AS GtkBinClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_viewport_get_type() AS GType
DECLARE FUNCTION gtk_viewport_new(BYVAL AS GtkAdjustment PTR, BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR

#IF NOT DEFINED (GTK_DISABLE_DEPRECATED) OR DEFINED (GTK_COMPILATION)

DECLARE FUNCTION gtk_viewport_get_hadjustment(BYVAL AS GtkViewport PTR) AS GtkAdjustment PTR
DECLARE FUNCTION gtk_viewport_get_vadjustment(BYVAL AS GtkViewport PTR) AS GtkAdjustment PTR
DECLARE SUB gtk_viewport_set_hadjustment(BYVAL AS GtkViewport PTR, BYVAL AS GtkAdjustment PTR)
DECLARE SUB gtk_viewport_set_vadjustment(BYVAL AS GtkViewport PTR, BYVAL AS GtkAdjustment PTR)

#ENDIF ' NOT DEFINED (GT...

DECLARE SUB gtk_viewport_set_shadow_type(BYVAL AS GtkViewport PTR, BYVAL AS GtkShadowType)
DECLARE FUNCTION gtk_viewport_get_shadow_type(BYVAL AS GtkViewport PTR) AS GtkShadowType
DECLARE FUNCTION gtk_viewport_get_bin_window(BYVAL AS GtkViewport PTR) AS GdkWindow PTR
DECLARE FUNCTION gtk_viewport_get_view_window(BYVAL AS GtkViewport PTR) AS GdkWindow PTR

#ENDIF ' __GTK_VIEWPORT_H__

#IFNDEF __GTK_VOLUME_BUTTON_H__
#DEFINE __GTK_VOLUME_BUTTON_H__

#DEFINE GTK_TYPE_VOLUME_BUTTON (gtk_volume_button_get_type ())
#DEFINE GTK_VOLUME_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VOLUME_BUTTON, GtkVolumeButton))
#DEFINE GTK_VOLUME_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VOLUME_BUTTON, GtkVolumeButtonClass))
#DEFINE GTK_IS_VOLUME_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VOLUME_BUTTON))
#DEFINE GTK_IS_VOLUME_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VOLUME_BUTTON))
#DEFINE GTK_VOLUME_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VOLUME_BUTTON, GtkVolumeButtonClass))

TYPE GtkVolumeButton AS _GtkVolumeButton
TYPE GtkVolumeButtonClass AS _GtkVolumeButtonClass

TYPE _GtkVolumeButton
  AS GtkScaleButton parent
END TYPE

TYPE _GtkVolumeButtonClass
  AS GtkScaleButtonClass parent_class
  _gtk_reserved1 AS SUB()
  _gtk_reserved2 AS SUB()
  _gtk_reserved3 AS SUB()
  _gtk_reserved4 AS SUB()
END TYPE

DECLARE FUNCTION gtk_volume_button_get_type() AS GType
DECLARE FUNCTION gtk_volume_button_new() AS GtkWidget PTR

#ENDIF ' __GTK_VOLUME_BUTTON_H__

#IFNDEF __GTK_VPANED_H__
#DEFINE __GTK_VPANED_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#DEFINE GTK_TYPE_VPANED (gtk_vpaned_get_type ())
#DEFINE GTK_VPANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VPANED, GtkVPaned))
#DEFINE GTK_VPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VPANED, GtkVPanedClass))
#DEFINE GTK_IS_VPANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VPANED))
#DEFINE GTK_IS_VPANED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VPANED))
#DEFINE GTK_VPANED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VPANED, GtkVPanedClass))

TYPE GtkVPaned AS _GtkVPaned
TYPE GtkVPanedClass AS _GtkVPanedClass

TYPE _GtkVPaned
  AS GtkPaned paned
END TYPE

TYPE _GtkVPanedClass
  AS GtkPanedClass parent_class
END TYPE

DECLARE FUNCTION gtk_vpaned_get_type() AS GType
DECLARE FUNCTION gtk_vpaned_new() AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_VPANED_H__

#IFNDEF __GTK_VSCALE_H__
#DEFINE __GTK_VSCALE_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#DEFINE GTK_TYPE_VSCALE (gtk_vscale_get_type ())
#DEFINE GTK_VSCALE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VSCALE, GtkVScale))
#DEFINE GTK_VSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VSCALE, GtkVScaleClass))
#DEFINE GTK_IS_VSCALE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VSCALE))
#DEFINE GTK_IS_VSCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VSCALE))
#DEFINE GTK_VSCALE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VSCALE, GtkVScaleClass))

TYPE GtkVScale AS _GtkVScale
TYPE GtkVScaleClass AS _GtkVScaleClass

TYPE _GtkVScale
  AS GtkScale scale
END TYPE

TYPE _GtkVScaleClass
  AS GtkScaleClass parent_class
END TYPE

DECLARE FUNCTION gtk_vscale_get_type() AS GType
DECLARE FUNCTION gtk_vscale_new(BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR
DECLARE FUNCTION gtk_vscale_new_with_range(BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble) AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_VSCALE_H__

#IFNDEF __GTK_VSCROLLBAR_H__
#DEFINE __GTK_VSCROLLBAR_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#DEFINE GTK_TYPE_VSCROLLBAR (gtk_vscrollbar_get_type ())
#DEFINE GTK_VSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VSCROLLBAR, GtkVScrollbar))
#DEFINE GTK_VSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VSCROLLBAR, GtkVScrollbarClass))
#DEFINE GTK_IS_VSCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VSCROLLBAR))
#DEFINE GTK_IS_VSCROLLBAR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VSCROLLBAR))
#DEFINE GTK_VSCROLLBAR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VSCROLLBAR, GtkVScrollbarClass))

TYPE GtkVScrollbar AS _GtkVScrollbar
TYPE GtkVScrollbarClass AS _GtkVScrollbarClass

TYPE _GtkVScrollbar
  AS GtkScrollbar scrollbar
END TYPE

TYPE _GtkVScrollbarClass
  AS GtkScrollbarClass parent_class
END TYPE

DECLARE FUNCTION gtk_vscrollbar_get_type() AS GType
DECLARE FUNCTION gtk_vscrollbar_new(BYVAL AS GtkAdjustment PTR) AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_VSCROLLBAR_H__

#IFNDEF __GTK_VSEPARATOR_H__
#DEFINE __GTK_VSEPARATOR_H__

#IFNDEF GTK_DISABLE_DEPRECATED

#DEFINE GTK_TYPE_VSEPARATOR (gtk_vseparator_get_type ())
#DEFINE GTK_VSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VSEPARATOR, GtkVSeparator))
#DEFINE GTK_VSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_VSEPARATOR, GtkVSeparatorClass))
#DEFINE GTK_IS_VSEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VSEPARATOR))
#DEFINE GTK_IS_VSEPARATOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_VSEPARATOR))
#DEFINE GTK_VSEPARATOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_VSEPARATOR, GtkVSeparatorClass))

TYPE GtkVSeparator AS _GtkVSeparator
TYPE GtkVSeparatorClass AS _GtkVSeparatorClass

TYPE _GtkVSeparator
  AS GtkSeparator separator
END TYPE

TYPE _GtkVSeparatorClass
  AS GtkSeparatorClass parent_class
END TYPE

DECLARE FUNCTION gtk_vseparator_get_type() AS GType
DECLARE FUNCTION gtk_vseparator_new() AS GtkWidget PTR

#ENDIF ' GTK_DISABLE_DEPRECATED
#ENDIF ' __GTK_VSEPARATOR_H__

#UNDEF __GTK_H_INSIDE__
#ENDIF ' __GTK_H__

END EXTERN

#IFDEF __FB_WIN32__
 #PRAGMA pop(msbitfields)
#ENDIF
