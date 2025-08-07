'' FreeBASIC binding for gtk4 (v4.17.4)
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
''   License along with this library. If not, see <http:
''
'' translated to FreeBASIC by:
''   Ahmad Khalifa

#pragma once

#inclib "gtk-4"

extern "C"
#include once "cairo/cairo.bi" '__headers__: cairo.h
#include once "crt/time.bi" '__headers__: time.h
#include once "gdk/gdk4.bi"
#include once "gdk-pixbuf/gdk-pixbuf.bi" '__headers__: gdk-pixbuf/gdk-pixbuf.h
#include once "gio/gio.bi" '__headers__: gio/gio.h
#include once "glib.bi" '__headers__: glib.h
#include once "glib-object.bi" '__headers__: glib-object.h
#include once "graphene.bi"
#include once "pango/pango.bi" '__headers__: pango/pango.h

Type GskBlendMode AS LONG
Type GskColorStop AS _GskColorStop
Type GskFillRule AS LONG
Type GskGLShader AS _GskGLShader
Type GskMaskMode AS LONG
Type GskPath as _GskPath
Type GskRenderer AS _GskRenderer
Type GskRenderNode AS _GskRenderNode
Type GskRoundedRect AS _GskRoundedRect
Type GskScalingFilter AS LONG
Type GskShadow AS _GskShadow
Type GskStroke AS _GskStroke
Type GskTransform AS _GskTransform


Enum GtkCssParserError_
	GTK_CSS_PARSER_ERROR_FAILED
	GTK_CSS_PARSER_ERROR_SYNTAX
	GTK_CSS_PARSER_ERROR_IMPORT
	GTK_CSS_PARSER_ERROR_NAME
	GTK_CSS_PARSER_ERROR_UNKNOWN_VALUE
End Enum
Type AS LONG GtkCssParserError

Enum GtkCssParserWarning_
	GTK_CSS_PARSER_WARNING_DEPRECATED
	GTK_CSS_PARSER_WARNING_SYNTAX
	GTK_CSS_PARSER_WARNING_UNIMPLEMENTED
End Enum
Type AS LONG GtkCssParserWarning


Declare Function gtk_css_parser_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CSS_PARSER_ERROR (gtk_css_parser_error_get_type ())
Declare Function gtk_css_parser_warning_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CSS_PARSER_WARNING (gtk_css_parser_warning_get_type ())
#DEFINE GTK_CSS_PARSER_ERROR (gtk_css_parser_error_quark ())
Declare Function gtk_css_parser_error_quark CDECL() AS GQuark
#DEFINE GTK_CSS_PARSER_WARNING (gtk_css_parser_warning_quark ())
Declare Function gtk_css_parser_warning_quark CDECL() AS GQuark

Type GtkCssLocation AS _GtkCssLocation

Type _GtkCssLocation
	AS gsize bytes
	AS gsize chars
	AS gsize lines
	AS gsize line_bytes
	AS gsize line_chars
End Type



#DEFINE GTK_TYPE_CSS_SECTION (gtk_css_section_get_type ())

Type GtkCssSection AS _GtkCssSection

Declare Function gtk_css_section_get_type CDECL() AS GType
Declare Function gtk_css_section_new CDECL(BYVAL AS GFile Ptr, BYVAL AS Const GtkCssLocation Ptr, BYVAL AS Const GtkCssLocation Ptr) AS GtkCssSection Ptr
Declare Function gtk_css_section_new_with_bytes CDECL(BYVAL AS GFile Ptr, BYVAL AS GBytes Ptr, BYVAL AS Const GtkCssLocation Ptr, BYVAL AS Const GtkCssLocation Ptr) AS GtkCssSection Ptr
Declare Function gtk_css_section_ref CDECL(BYVAL AS GtkCssSection Ptr) AS GtkCssSection Ptr
Declare SUB gtk_css_section_unref CDECL(BYVAL AS GtkCssSection Ptr)
Declare SUB gtk_css_section_print CDECL(BYVAL AS Const GtkCssSection Ptr, BYVAL AS GString Ptr)
Declare Function gtk_css_section_to_string CDECL(BYVAL AS Const GtkCssSection Ptr) AS ZSTRING Ptr
Declare Function gtk_css_section_get_parent CDECL(BYVAL AS Const GtkCssSection Ptr) AS GtkCssSection Ptr
Declare Function gtk_css_section_get_file CDECL(BYVAL AS Const GtkCssSection Ptr) AS GFile Ptr
Declare Function gtk_css_section_get_bytes CDECL(BYVAL AS Const GtkCssSection Ptr) AS GBytes Ptr
Declare Function gtk_css_section_get_start_location CDECL(BYVAL AS Const GtkCssSection Ptr) AS Const GtkCssLocation Ptr
Declare Function gtk_css_section_get_end_location CDECL(BYVAL AS Const GtkCssSection Ptr) AS Const GtkCssLocation Ptr

Enum GtkAlign_
	GTK_ALIGN_FILL
	GTK_ALIGN_START
	GTK_ALIGN_END
	GTK_ALIGN_CENTER
	GTK_ALIGN_BASELINE_FILL
	GTK_ALIGN_BASELINE = GTK_ALIGN_CENTER + 1
	GTK_ALIGN_BASELINE_CENTER
End Enum
Type AS LONG GtkAlign

Enum GtkArrowType_
	GTK_ARROW_UP
	GTK_ARROW_DOWN
	GTK_ARROW_LEFT
	GTK_ARROW_RIGHT
	GTK_ARROW_NONE
End Enum
Type AS LONG GtkArrowType

Enum GtkBaselinePosition_
	GTK_BASELINE_POSITION_TOP
	GTK_BASELINE_POSITION_CENTER
	GTK_BASELINE_POSITION_BOTTOM
End Enum
Type AS LONG GtkBaselinePosition

Enum GtkContentFit_
	GTK_CONTENT_FIT_FILL
	GTK_CONTENT_FIT_CONTAIN
	GTK_CONTENT_FIT_COVER
	GTK_CONTENT_FIT_SCALE_DOWN
End Enum
Type AS LONG GtkContentFit

Enum GtkDeleteType_
	GTK_DELETE_CHARS
	GTK_DELETE_WORD_ENDS
	GTK_DELETE_WORDS
	GTK_DELETE_DISPLAY_LINES
	GTK_DELETE_DISPLAY_LINE_ENDS
	GTK_DELETE_PARAGRAPH_ENDS
	GTK_DELETE_PARAGRAPHS
	GTK_DELETE_WHITESPACE
End Enum
Type AS LONG GtkDeleteType

Enum GtkDirectionType_
	GTK_DIR_TAB_FORWARD
	GTK_DIR_TAB_BACKWARD
	GTK_DIR_UP
	GTK_DIR_DOWN
	GTK_DIR_LEFT
	GTK_DIR_RIGHT
End Enum
Type AS LONG GtkDirectionType

Enum GtkIconSize_
	GTK_ICON_SIZE_INHERIT
	GTK_ICON_SIZE_NORMAL
	GTK_ICON_SIZE_LARGE
End Enum
Type AS LONG GtkIconSize

Enum GtkSensitivityType_
	GTK_SENSITIVITY_AUTO
	GTK_SENSITIVITY_ON
	GTK_SENSITIVITY_OFF
End Enum
Type AS LONG GtkSensitivityType

Enum GtkTextDirection_
	GTK_TEXT_DIR_NONE
	GTK_TEXT_DIR_LTR
	GTK_TEXT_DIR_RTL
End Enum
Type AS LONG GtkTextDirection

Enum GtkJustification_
	GTK_JUSTIFY_LEFT
	GTK_JUSTIFY_RIGHT
	GTK_JUSTIFY_CENTER
	GTK_JUSTIFY_FILL
End Enum
Type AS LONG GtkJustification

Enum GtkListTabBehavior_
	GTK_LIST_TAB_ALL
	GTK_LIST_TAB_ITEM
	GTK_LIST_TAB_CELL
End Enum
Type AS LONG GtkListTabBehavior

Enum GtkListScrollFlags_
	GTK_LIST_SCROLL_NONE = 0
	GTK_LIST_SCROLL_FOCUS = 1  SHL 0
	GTK_LIST_SCROLL_SELECT = 1  SHL 1
End Enum
Type AS LONG GtkListScrollFlags

Enum GtkMessageType_
	GTK_MESSAGE_INFO
	GTK_MESSAGE_WARNING
	GTK_MESSAGE_QUESTION
	GTK_MESSAGE_ERROR
	GTK_MESSAGE_OTHER
End Enum
Type AS LONG GtkMessageType

Enum GtkMovementStep_
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
End Enum
Type AS LONG GtkMovementStep

Enum GtkNaturalWrapMode_
	GTK_NATURAL_WRAP_INHERIT
	GTK_NATURAL_WRAP_NONE
	GTK_NATURAL_WRAP_WORD
End Enum
Type AS LONG GtkNaturalWrapMode

Enum GtkScrollStep_
	GTK_SCROLL_STEPS
	GTK_SCROLL_PAGES
	GTK_SCROLL_ENDS
	GTK_SCROLL_HORIZONTAL_STEPS
	GTK_SCROLL_HORIZONTAL_PAGES
	GTK_SCROLL_HORIZONTAL_ENDS
End Enum
Type AS LONG GtkScrollStep

Enum GtkOrientation_
	GTK_ORIENTATION_HORIZONTAL
	GTK_ORIENTATION_VERTICAL
End Enum
Type AS LONG GtkOrientation

Enum GtkOverflow_
	GTK_OVERFLOW_VISIBLE
	GTK_OVERFLOW_HIDDEN
End Enum
Type AS LONG GtkOverflow

Enum GtkPackType_
	GTK_PACK_START
	GTK_PACK_END
End Enum
Type AS LONG GtkPackType

Enum GtkPositionType_
	GTK_POS_LEFT
	GTK_POS_RIGHT
	GTK_POS_TOP
	GTK_POS_BOTTOM
End Enum
Type AS LONG GtkPositionType

Enum GtkScrollType_
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
End Enum
Type AS LONG GtkScrollType

Enum GtkSelectionMode_
	GTK_SELECTION_NONE
	GTK_SELECTION_SINGLE
	GTK_SELECTION_BROWSE
	GTK_SELECTION_MULTIPLE
End Enum
Type AS LONG GtkSelectionMode

Enum GtkWrapMode_
	GTK_WRAP_NONE
	GTK_WRAP_CHAR
	GTK_WRAP_WORD
	GTK_WRAP_WORD_CHAR
End Enum
Type AS LONG GtkWrapMode

Enum GtkSortType_
	GTK_SORT_ASCENDING
	GTK_SORT_DESCENDING
End Enum
Type AS LONG GtkSortType

Enum GtkPrintPages_
	GTK_PRINT_PAGES_ALL
	GTK_PRINT_PAGES_CURRENT
	GTK_PRINT_PAGES_RANGES
	GTK_PRINT_PAGES_SELECTION
End Enum
Type AS LONG GtkPrintPages

Enum GtkPageSet_
	GTK_PAGE_SET_ALL
	GTK_PAGE_SET_EVEN
	GTK_PAGE_SET_ODD
End Enum
Type AS LONG GtkPageSet

Enum GtkNumberUpLayout_
	GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_TOP_TO_BOTTOM
	GTK_NUMBER_UP_LAYOUT_LEFT_TO_RIGHT_BOTTOM_TO_TOP
	GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_TOP_TO_BOTTOM
	GTK_NUMBER_UP_LAYOUT_RIGHT_TO_LEFT_BOTTOM_TO_TOP
	GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_LEFT_TO_RIGHT
	GTK_NUMBER_UP_LAYOUT_TOP_TO_BOTTOM_RIGHT_TO_LEFT
	GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_LEFT_TO_RIGHT
	GTK_NUMBER_UP_LAYOUT_BOTTOM_TO_TOP_RIGHT_TO_LEFT
End Enum
Type AS LONG GtkNumberUpLayout

Enum GtkOrdering_
	GTK_ORDERING_SMALLER = -1
	GTK_ORDERING_EQUAL = 0
	GTK_ORDERING_LARGER = 1
End Enum
Type AS LONG GtkOrdering


Declare Function gtk_ordering_from_cmpfunc CDECL(BYVAL AS LONG) AS GtkOrdering

Enum GtkPageOrientation_
	GTK_PAGE_ORIENTATION_PORTRAIT
	GTK_PAGE_ORIENTATION_LANDSCAPE
	GTK_PAGE_ORIENTATION_REVERSE_PORTRAIT
	GTK_PAGE_ORIENTATION_REVERSE_LANDSCAPE
End Enum
Type AS LONG GtkPageOrientation

Enum GtkPrintQuality_
	GTK_PRINT_QUALITY_LOW
	GTK_PRINT_QUALITY_NORMAL
	GTK_PRINT_QUALITY_HIGH
	GTK_PRINT_QUALITY_DRAFT
End Enum
Type AS LONG GtkPrintQuality

Enum GtkPrintDuplex_
	GTK_PRINT_DUPLEX_SIMPLEX
	GTK_PRINT_DUPLEX_HORIZONTAL
	GTK_PRINT_DUPLEX_VERTICAL
End Enum
Type AS LONG GtkPrintDuplex

Enum GtkUnit_
	GTK_UNIT_NONE
	GTK_UNIT_POINTS
	GTK_UNIT_INCH
	GTK_UNIT_MM
End Enum
Type AS LONG GtkUnit

#DEFINE GTK_UNIT_PIXEL GTK_UNIT_NONE

Enum GtkTreeViewGridLines_
	GTK_TREE_VIEW_GRID_LINES_NONE
	GTK_TREE_VIEW_GRID_LINES_HORIZONTAL
	GTK_TREE_VIEW_GRID_LINES_VERTICAL
	GTK_TREE_VIEW_GRID_LINES_BOTH
End Enum
Type AS LONG GtkTreeViewGridLines

Enum GtkSizeGroupMode_
	GTK_SIZE_GROUP_NONE
	GTK_SIZE_GROUP_HORIZONTAL
	GTK_SIZE_GROUP_VERTICAL
	GTK_SIZE_GROUP_BOTH
End Enum
Type AS LONG GtkSizeGroupMode

Enum GtkSizeRequestMode_
	GTK_SIZE_REQUEST_HEIGHT_FOR_WIDTH = 0
	GTK_SIZE_REQUEST_WIDTH_FOR_HEIGHT
	GTK_SIZE_REQUEST_CONSTANT_SIZE
End Enum
Type AS LONG GtkSizeRequestMode

Enum GtkScrollablePolicy_
	GTK_SCROLL_MINIMUM = 0
	GTK_SCROLL_NATURAL
End Enum
Type AS LONG GtkScrollablePolicy

Enum GtkStateFlags_
	GTK_STATE_FLAG_NORMAL = 0
	GTK_STATE_FLAG_ACTIVE = 1  SHL 0
	GTK_STATE_FLAG_PRELIGHT = 1  SHL 1
	GTK_STATE_FLAG_SELECTED = 1  SHL 2
	GTK_STATE_FLAG_INSENSITIVE = 1  SHL 3
	GTK_STATE_FLAG_INCONSISTENT = 1  SHL 4
	GTK_STATE_FLAG_FOCUSED = 1  SHL 5
	GTK_STATE_FLAG_BACKDROP = 1  SHL 6
	GTK_STATE_FLAG_DIR_LTR = 1  SHL 7
	GTK_STATE_FLAG_DIR_RTL = 1  SHL 8
	GTK_STATE_FLAG_LINK = 1  SHL 9
	GTK_STATE_FLAG_VISITED = 1  SHL 10
	GTK_STATE_FLAG_CHECKED = 1  SHL 11
	GTK_STATE_FLAG_DROP_ACTIVE = 1  SHL 12
	GTK_STATE_FLAG_FOCUS_VISIBLE = 1  SHL 13
	GTK_STATE_FLAG_FOCUS_WITHIN = 1  SHL 14
End Enum
Type AS LONG GtkStateFlags

Enum GtkBorderStyle_
	GTK_BORDER_STYLE_NONE
	GTK_BORDER_STYLE_HIDDEN
	GTK_BORDER_STYLE_SOLID
	GTK_BORDER_STYLE_INSET
	GTK_BORDER_STYLE_OUTSET
	GTK_BORDER_STYLE_DOTTED
	GTK_BORDER_STYLE_DASHED
	GTK_BORDER_STYLE_DOUBLE
	GTK_BORDER_STYLE_GROOVE
	GTK_BORDER_STYLE_RIDGE
End Enum
Type AS LONG GtkBorderStyle

Enum GtkLevelBarMode_
	GTK_LEVEL_BAR_MODE_CONTINUOUS
	GTK_LEVEL_BAR_MODE_DISCRETE
End Enum
Type AS LONG GtkLevelBarMode

Enum GtkInputPurpose_
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
	GTK_INPUT_PURPOSE_TERMINAL
End Enum
Type AS LONG GtkInputPurpose

Enum GtkInputHints_
	GTK_INPUT_HINT_NONE = 0
	GTK_INPUT_HINT_SPELLCHECK = 1  SHL 0
	GTK_INPUT_HINT_NO_SPELLCHECK = 1  SHL 1
	GTK_INPUT_HINT_WORD_COMPLETION = 1  SHL 2
	GTK_INPUT_HINT_LOWERCASE = 1  SHL 3
	GTK_INPUT_HINT_UPPERCASE_CHARS = 1  SHL 4
	GTK_INPUT_HINT_UPPERCASE_WORDS = 1  SHL 5
	GTK_INPUT_HINT_UPPERCASE_SENTENCES = 1  SHL 6
	GTK_INPUT_HINT_INHIBIT_OSK = 1  SHL 7
	GTK_INPUT_HINT_VERTICAL_WRITING = 1  SHL 8
	GTK_INPUT_HINT_EMOJI = 1  SHL 9
	GTK_INPUT_HINT_NO_EMOJI = 1  SHL 10
	GTK_INPUT_HINT_PRIVATE = 1  SHL 11
End Enum
Type AS LONG GtkInputHints

Enum GtkPropagationPhase_
	GTK_PHASE_NONE
	GTK_PHASE_CAPTURE
	GTK_PHASE_BUBBLE
	GTK_PHASE_TARGET
End Enum
Type AS LONG GtkPropagationPhase

Enum GtkPropagationLimit_
	GTK_LIMIT_NONE
	GTK_LIMIT_SAME_NATIVE
End Enum
Type AS LONG GtkPropagationLimit

Enum GtkEventSequenceState_
	GTK_EVENT_SEQUENCE_NONE
	GTK_EVENT_SEQUENCE_CLAIMED
	GTK_EVENT_SEQUENCE_DENIED
End Enum
Type AS LONG GtkEventSequenceState

Enum GtkPanDirection_
	GTK_PAN_DIRECTION_LEFT
	GTK_PAN_DIRECTION_RIGHT
	GTK_PAN_DIRECTION_UP
	GTK_PAN_DIRECTION_DOWN
End Enum
Type AS LONG GtkPanDirection

Enum GtkShortcutScope_
	GTK_SHORTCUT_SCOPE_LOCAL
	GTK_SHORTCUT_SCOPE_MANAGED
	GTK_SHORTCUT_SCOPE_GLOBAL
End Enum
Type AS LONG GtkShortcutScope

Enum GtkPickFlags_
	GTK_PICK_DEFAULT = 0
	GTK_PICK_INSENSITIVE = 1  SHL 0
	GTK_PICK_NON_TARGETABLE = 1  SHL 1
End Enum
Type AS LONG GtkPickFlags

Enum GtkConstraintRelation_
	GTK_CONSTRAINT_RELATION_LE = -1
	GTK_CONSTRAINT_RELATION_EQ = 0
	GTK_CONSTRAINT_RELATION_GE = 1
End Enum
Type AS LONG GtkConstraintRelation

Enum GtkConstraintStrength_
	GTK_CONSTRAINT_STRENGTH_REQUIRED = 1001001000
	GTK_CONSTRAINT_STRENGTH_STRONG = 1000000000
	GTK_CONSTRAINT_STRENGTH_MEDIUM = 1000
	GTK_CONSTRAINT_STRENGTH_WEAK = 1
End Enum
Type AS LONG GtkConstraintStrength

Enum GtkConstraintAttribute_
	GTK_CONSTRAINT_ATTRIBUTE_NONE
	GTK_CONSTRAINT_ATTRIBUTE_LEFT
	GTK_CONSTRAINT_ATTRIBUTE_RIGHT
	GTK_CONSTRAINT_ATTRIBUTE_TOP
	GTK_CONSTRAINT_ATTRIBUTE_BOTTOM
	GTK_CONSTRAINT_ATTRIBUTE_START
	GTK_CONSTRAINT_ATTRIBUTE_END
	GTK_CONSTRAINT_ATTRIBUTE_WIDTH
	GTK_CONSTRAINT_ATTRIBUTE_HEIGHT
	GTK_CONSTRAINT_ATTRIBUTE_CENTER_X
	GTK_CONSTRAINT_ATTRIBUTE_CENTER_Y
	GTK_CONSTRAINT_ATTRIBUTE_BASELINE
End Enum
Type AS LONG GtkConstraintAttribute

Enum GtkConstraintVflParserError_
	GTK_CONSTRAINT_VFL_PARSER_ERROR_INVALID_SYMBOL
	GTK_CONSTRAINT_VFL_PARSER_ERROR_INVALID_ATTRIBUTE
	GTK_CONSTRAINT_VFL_PARSER_ERROR_INVALID_VIEW
	GTK_CONSTRAINT_VFL_PARSER_ERROR_INVALID_METRIC
	GTK_CONSTRAINT_VFL_PARSER_ERROR_INVALID_PRIORITY
	GTK_CONSTRAINT_VFL_PARSER_ERROR_INVALID_RELATION
End Enum
Type AS LONG GtkConstraintVflParserError

Enum GtkSystemSetting_
	GTK_SYSTEM_SETTING_DPI
	GTK_SYSTEM_SETTING_FONT_NAME
	GTK_SYSTEM_SETTING_FONT_CONFIG
	GTK_SYSTEM_SETTING_DISPLAY
	GTK_SYSTEM_SETTING_ICON_THEME
End Enum
Type AS LONG GtkSystemSetting

Enum GtkSymbolicColor_
	GTK_SYMBOLIC_COLOR_FOREGROUND = 0
	GTK_SYMBOLIC_COLOR_ERROR = 1
	GTK_SYMBOLIC_COLOR_WARNING = 2
	GTK_SYMBOLIC_COLOR_SUCCESS = 3
End Enum
Type AS LONG GtkSymbolicColor

Enum GtkAccessibleRole_
	GTK_ACCESSIBLE_ROLE_ALERT
	GTK_ACCESSIBLE_ROLE_ALERT_DIALOG
	GTK_ACCESSIBLE_ROLE_BANNER
	GTK_ACCESSIBLE_ROLE_BUTTON
	GTK_ACCESSIBLE_ROLE_CAPTION
	GTK_ACCESSIBLE_ROLE_CELL
	GTK_ACCESSIBLE_ROLE_CHECKBOX
	GTK_ACCESSIBLE_ROLE_COLUMN_HEADER
	GTK_ACCESSIBLE_ROLE_COMBO_BOX
	GTK_ACCESSIBLE_ROLE_COMMAND
	GTK_ACCESSIBLE_ROLE_COMPOSITE
	GTK_ACCESSIBLE_ROLE_DIALOG
	GTK_ACCESSIBLE_ROLE_DOCUMENT
	GTK_ACCESSIBLE_ROLE_FEED
	GTK_ACCESSIBLE_ROLE_FORM
	GTK_ACCESSIBLE_ROLE_GENERIC
	GTK_ACCESSIBLE_ROLE_GRID
	GTK_ACCESSIBLE_ROLE_GRID_CELL
	GTK_ACCESSIBLE_ROLE_GROUP
	GTK_ACCESSIBLE_ROLE_HEADING
	GTK_ACCESSIBLE_ROLE_IMG
	GTK_ACCESSIBLE_ROLE_INPUT
	GTK_ACCESSIBLE_ROLE_LABEL
	GTK_ACCESSIBLE_ROLE_LANDMARK
	GTK_ACCESSIBLE_ROLE_LEGEND
	GTK_ACCESSIBLE_ROLE_LINK
	GTK_ACCESSIBLE_ROLE_LIST
	GTK_ACCESSIBLE_ROLE_LIST_BOX
	GTK_ACCESSIBLE_ROLE_LIST_ITEM
	GTK_ACCESSIBLE_ROLE_LOG
	GTK_ACCESSIBLE_ROLE_MAIN
	GTK_ACCESSIBLE_ROLE_MARQUEE
	GTK_ACCESSIBLE_ROLE_MATH
	GTK_ACCESSIBLE_ROLE_METER
	GTK_ACCESSIBLE_ROLE_MENU
	GTK_ACCESSIBLE_ROLE_MENU_BAR
	GTK_ACCESSIBLE_ROLE_MENU_ITEM
	GTK_ACCESSIBLE_ROLE_MENU_ITEM_CHECKBOX
	GTK_ACCESSIBLE_ROLE_MENU_ITEM_RADIO
	GTK_ACCESSIBLE_ROLE_NAVIGATION
	GTK_ACCESSIBLE_ROLE_NONE
	GTK_ACCESSIBLE_ROLE_NOTE
	GTK_ACCESSIBLE_ROLE_OPTION
	GTK_ACCESSIBLE_ROLE_PRESENTATION
	GTK_ACCESSIBLE_ROLE_PROGRESS_BAR
	GTK_ACCESSIBLE_ROLE_RADIO
	GTK_ACCESSIBLE_ROLE_RADIO_GROUP
	GTK_ACCESSIBLE_ROLE_RANGE
	GTK_ACCESSIBLE_ROLE_REGION
	GTK_ACCESSIBLE_ROLE_ROW
	GTK_ACCESSIBLE_ROLE_ROW_GROUP
	GTK_ACCESSIBLE_ROLE_ROW_HEADER
	GTK_ACCESSIBLE_ROLE_SCROLLBAR
	GTK_ACCESSIBLE_ROLE_SEARCH
	GTK_ACCESSIBLE_ROLE_SEARCH_BOX
	GTK_ACCESSIBLE_ROLE_SECTION
	GTK_ACCESSIBLE_ROLE_SECTION_HEAD
	GTK_ACCESSIBLE_ROLE_SELECT
	GTK_ACCESSIBLE_ROLE_SEPARATOR
	GTK_ACCESSIBLE_ROLE_SLIDER
	GTK_ACCESSIBLE_ROLE_SPIN_BUTTON
	GTK_ACCESSIBLE_ROLE_STATUS
	GTK_ACCESSIBLE_ROLE_STRUCTURE
	GTK_ACCESSIBLE_ROLE_SWITCH
	GTK_ACCESSIBLE_ROLE_TAB
	GTK_ACCESSIBLE_ROLE_TABLE
	GTK_ACCESSIBLE_ROLE_TAB_LIST
	GTK_ACCESSIBLE_ROLE_TAB_PANEL
	GTK_ACCESSIBLE_ROLE_TEXT_BOX
	GTK_ACCESSIBLE_ROLE_TIME
	GTK_ACCESSIBLE_ROLE_TIMER
	GTK_ACCESSIBLE_ROLE_TOOLBAR
	GTK_ACCESSIBLE_ROLE_TOOLTIP
	GTK_ACCESSIBLE_ROLE_TREE
	GTK_ACCESSIBLE_ROLE_TREE_GRID
	GTK_ACCESSIBLE_ROLE_TREE_ITEM
	GTK_ACCESSIBLE_ROLE_WIDGET
	GTK_ACCESSIBLE_ROLE_WINDOW
	GTK_ACCESSIBLE_ROLE_TOGGLE_BUTTON
	GTK_ACCESSIBLE_ROLE_APPLICATION
	GTK_ACCESSIBLE_ROLE_PARAGRAPH
	GTK_ACCESSIBLE_ROLE_BLOCK_QUOTE
	GTK_ACCESSIBLE_ROLE_ARTICLE
	GTK_ACCESSIBLE_ROLE_COMMENT
	GTK_ACCESSIBLE_ROLE_TERMINAL
End Enum
Type AS LONG GtkAccessibleRole

Enum GtkAccessibleState_
	GTK_ACCESSIBLE_STATE_BUSY
	GTK_ACCESSIBLE_STATE_CHECKED
	GTK_ACCESSIBLE_STATE_DISABLED
	GTK_ACCESSIBLE_STATE_EXPANDED
	GTK_ACCESSIBLE_STATE_HIDDEN
	GTK_ACCESSIBLE_STATE_INVALID
	GTK_ACCESSIBLE_STATE_PRESSED
	GTK_ACCESSIBLE_STATE_SELECTED
	GTK_ACCESSIBLE_STATE_VISITED
End Enum
Type AS LONG GtkAccessibleState

#DEFINE GTK_ACCESSIBLE_VALUE_UNDEFINED (-1)

Enum GtkAccessibleProperty_
	GTK_ACCESSIBLE_PROPERTY_AUTOCOMPLETE
	GTK_ACCESSIBLE_PROPERTY_DESCRIPTION
	GTK_ACCESSIBLE_PROPERTY_HAS_POPUP
	GTK_ACCESSIBLE_PROPERTY_KEY_SHORTCUTS
	GTK_ACCESSIBLE_PROPERTY_LABEL
	GTK_ACCESSIBLE_PROPERTY_LEVEL
	GTK_ACCESSIBLE_PROPERTY_MODAL
	GTK_ACCESSIBLE_PROPERTY_MULTI_LINE
	GTK_ACCESSIBLE_PROPERTY_MULTI_SELECTABLE
	GTK_ACCESSIBLE_PROPERTY_ORIENTATION
	GTK_ACCESSIBLE_PROPERTY_PLACEHOLDER
	GTK_ACCESSIBLE_PROPERTY_READ_ONLY
	GTK_ACCESSIBLE_PROPERTY_REQUIRED
	GTK_ACCESSIBLE_PROPERTY_ROLE_DESCRIPTION
	GTK_ACCESSIBLE_PROPERTY_SORT
	GTK_ACCESSIBLE_PROPERTY_VALUE_MAX
	GTK_ACCESSIBLE_PROPERTY_VALUE_MIN
	GTK_ACCESSIBLE_PROPERTY_VALUE_NOW
	GTK_ACCESSIBLE_PROPERTY_VALUE_TEXT
	GTK_ACCESSIBLE_PROPERTY_HELP_TEXT
End Enum
Type AS LONG GtkAccessibleProperty

Enum GtkAccessibleRelation_
	GTK_ACCESSIBLE_RELATION_ACTIVE_DESCENDANT
	GTK_ACCESSIBLE_RELATION_COL_COUNT
	GTK_ACCESSIBLE_RELATION_COL_INDEX
	GTK_ACCESSIBLE_RELATION_COL_INDEX_TEXT
	GTK_ACCESSIBLE_RELATION_COL_SPAN
	GTK_ACCESSIBLE_RELATION_CONTROLS
	GTK_ACCESSIBLE_RELATION_DESCRIBED_BY
	GTK_ACCESSIBLE_RELATION_DETAILS
	GTK_ACCESSIBLE_RELATION_ERROR_MESSAGE
	GTK_ACCESSIBLE_RELATION_FLOW_TO
	GTK_ACCESSIBLE_RELATION_LABELLED_BY
	GTK_ACCESSIBLE_RELATION_OWNS
	GTK_ACCESSIBLE_RELATION_POS_IN_SET
	GTK_ACCESSIBLE_RELATION_ROW_COUNT
	GTK_ACCESSIBLE_RELATION_ROW_INDEX
	GTK_ACCESSIBLE_RELATION_ROW_INDEX_TEXT
	GTK_ACCESSIBLE_RELATION_ROW_SPAN
	GTK_ACCESSIBLE_RELATION_SET_SIZE
	GTK_ACCESSIBLE_RELATION_LABEL_FOR
	GTK_ACCESSIBLE_RELATION_DESCRIPTION_FOR
	GTK_ACCESSIBLE_RELATION_CONTROLLED_BY
	GTK_ACCESSIBLE_RELATION_DETAILS_FOR
	GTK_ACCESSIBLE_RELATION_ERROR_MESSAGE_FOR
	GTK_ACCESSIBLE_RELATION_FLOW_FROM
End Enum
Type AS LONG GtkAccessibleRelation

Enum GtkAccessibleTristate_
	GTK_ACCESSIBLE_TRISTATE_FALSE
	GTK_ACCESSIBLE_TRISTATE_TRUE
	GTK_ACCESSIBLE_TRISTATE_MIXED
End Enum
Type AS LONG GtkAccessibleTristate

Enum GtkAccessibleInvalidState_
	GTK_ACCESSIBLE_INVALID_FALSE
	GTK_ACCESSIBLE_INVALID_TRUE
	GTK_ACCESSIBLE_INVALID_GRAMMAR
	GTK_ACCESSIBLE_INVALID_SPELLING
End Enum
Type AS LONG GtkAccessibleInvalidState

Enum GtkAccessibleAutocomplete_
	GTK_ACCESSIBLE_AUTOCOMPLETE_NONE
	GTK_ACCESSIBLE_AUTOCOMPLETE_INLINE
	GTK_ACCESSIBLE_AUTOCOMPLETE_LIST
	GTK_ACCESSIBLE_AUTOCOMPLETE_BOTH
End Enum
Type AS LONG GtkAccessibleAutocomplete

Enum GtkAccessibleSort_
	GTK_ACCESSIBLE_SORT_NONE
	GTK_ACCESSIBLE_SORT_ASCENDING
	GTK_ACCESSIBLE_SORT_DESCENDING
	GTK_ACCESSIBLE_SORT_OTHER
End Enum
Type AS LONG GtkAccessibleSort

Enum GtkAccessibleAnnouncementPriority_
	GTK_ACCESSIBLE_ANNOUNCEMENT_PRIORITY_LOW
	GTK_ACCESSIBLE_ANNOUNCEMENT_PRIORITY_MEDIUM
	GTK_ACCESSIBLE_ANNOUNCEMENT_PRIORITY_HIGH
End Enum
Type AS LONG GtkAccessibleAnnouncementPriority

Enum GtkPopoverMenuFlags_
	GTK_POPOVER_MENU_SLIDING = 0
	GTK_POPOVER_MENU_NESTED = 1  SHL 0
End Enum
Type AS LONG GtkPopoverMenuFlags

Enum GtkFontRendering_
	GTK_FONT_RENDERING_AUTOMATIC
	GTK_FONT_RENDERING_MANUAL
End Enum
Type AS LONG GtkFontRendering

Enum GtkTextBufferNotifyFlags_
	GTK_TEXT_BUFFER_NOTIFY_BEFORE_INSERT = 1  SHL 0
	GTK_TEXT_BUFFER_NOTIFY_AFTER_INSERT = 1  SHL 1
	GTK_TEXT_BUFFER_NOTIFY_BEFORE_DELETE = 1  SHL 2
	GTK_TEXT_BUFFER_NOTIFY_AFTER_DELETE = 1  SHL 3
End Enum
Type AS LONG GtkTextBufferNotifyFlags


Type GtkAdjustment AS _GtkAdjustment
Type GtkATContext AS _GtkATContext
Type GtkBitset AS _GtkBitset
Type GtkBuilder AS _GtkBuilder
Type GtkBuilderScope AS _GtkBuilderScope
Type GtkCssStyleChange AS _GtkCssStyleChange
Type GtkEventController AS _GtkEventController
Type GtkGesture AS _GtkGesture
Type GtkLayoutManager AS _GtkLayoutManager
Type GtkListItem AS _GtkListItem
Type GtkListItemFactory AS _GtkListItemFactory
Type GtkNative AS _GtkNative
Type GtkRequisition AS _GtkRequisition
Type GtkRoot AS _GtkRoot
Type GtkScrollInfo AS _GtkScrollInfo
Type GtkSettings AS _GtkSettings
Type GtkShortcut AS _GtkShortcut
Type GtkShortcutAction AS _GtkShortcutAction
Type GtkShortcutTrigger AS _GtkShortcutTrigger
Type GtkSnapshot AS GdkSnapshot
Type GtkStyleContext AS _GtkStyleContext
Type GtkTooltip AS _GtkTooltip
Type GtkWidget AS _GtkWidget
Type GtkWindow AS _GtkWindow

#DEFINE GTK_INVALID_LIST_POSITION (CAST(guint, &hFFFFFFFF))

#DEFINE GTK_TYPE_SHORTCUT (gtk_shortcut_get_type ())

Type GtkShortcut AS _GtkShortcut
Declare Function gtk_shortcut_new CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GtkShortcutAction Ptr) AS GtkShortcut Ptr
Declare Function gtk_shortcut_new_with_arguments CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GtkShortcutAction Ptr, BYVAL AS Const ZSTRING Ptr, ...) AS GtkShortcut Ptr
Declare Function gtk_shortcut_get_trigger CDECL(BYVAL AS GtkShortcut Ptr) AS GtkShortcutTrigger Ptr
Declare SUB gtk_shortcut_set_trigger CDECL(BYVAL AS GtkShortcut Ptr, BYVAL AS GtkShortcutTrigger Ptr)
Declare Function gtk_shortcut_get_action CDECL(BYVAL AS GtkShortcut Ptr) AS GtkShortcutAction Ptr
Declare SUB gtk_shortcut_set_action CDECL(BYVAL AS GtkShortcut Ptr, BYVAL AS GtkShortcutAction Ptr)
Declare Function gtk_shortcut_get_arguments CDECL(BYVAL AS GtkShortcut Ptr) AS GVariant Ptr
Declare SUB gtk_shortcut_set_arguments CDECL(BYVAL AS GtkShortcut Ptr, BYVAL AS GVariant Ptr)

#DEFINE GTK_TYPE_SHORTCUT_ACTION (gtk_shortcut_action_get_type ())

Type GtkShortcutFunc AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GVariant Ptr, BYVAL AS gpointer) AS gboolean

Enum GtkShortcutActionFlags_
	GTK_SHORTCUT_ACTION_EXCLUSIVE = 1  SHL 0
End Enum
Type AS LONG GtkShortcutActionFlags

Type GtkShortcutAction AS _GtkShortcutAction
Declare Function gtk_shortcut_action_to_string CDECL(BYVAL AS GtkShortcutAction Ptr) AS ZSTRING Ptr
Declare Function gtk_shortcut_action_parse_string CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkShortcutAction Ptr
Declare SUB gtk_shortcut_action_print CDECL(BYVAL AS GtkShortcutAction Ptr, BYVAL AS GString Ptr)
Declare Function gtk_shortcut_action_activate CDECL(BYVAL AS GtkShortcutAction Ptr, BYVAL AS GtkShortcutActionFlags, BYVAL AS GtkWidget Ptr, BYVAL AS GVariant Ptr) AS gboolean

#DEFINE GTK_TYPE_NOTHING_ACTION (gtk_nothing_action_get_type())
Type GtkNothingAction AS _GtkNothingAction
Declare Function gtk_nothing_action_get CDECL() AS GtkShortcutAction Ptr

#DEFINE GTK_TYPE_CALLBACK_ACTION (gtk_callback_action_get_type())
Type GtkCallbackAction AS _GtkCallbackAction
Declare Function gtk_callback_action_new CDECL(BYVAL AS GtkShortcutFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GtkShortcutAction Ptr

#DEFINE GTK_TYPE_MNEMONIC_ACTION (gtk_mnemonic_action_get_type())
Type GtkMnemonicAction AS _GtkMnemonicAction
Declare Function gtk_mnemonic_action_get CDECL() AS GtkShortcutAction Ptr

#DEFINE GTK_TYPE_ACTIVATE_ACTION (gtk_activate_action_get_type())
Type GtkActivateAction AS _GtkActivateAction
Declare Function gtk_activate_action_get CDECL() AS GtkShortcutAction Ptr

#DEFINE GTK_TYPE_SIGNAL_ACTION (gtk_signal_action_get_type())
Type GtkSignalAction AS _GtkSignalAction
Declare Function gtk_signal_action_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkShortcutAction Ptr
Declare Function gtk_signal_action_get_signal_name CDECL(BYVAL AS GtkSignalAction Ptr) AS Const ZSTRING Ptr

#DEFINE GTK_TYPE_NAMED_ACTION (gtk_named_action_get_type())
Type GtkNamedAction AS _GtkNamedAction
Declare Function gtk_named_action_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkShortcutAction Ptr
Declare Function gtk_named_action_get_action_name CDECL(BYVAL AS GtkNamedAction Ptr) AS Const ZSTRING Ptr


#DEFINE GTK_TYPE_WIDGET (gtk_widget_get_type ())
#DEFINE GTK_WIDGET(widget) (G_TYPE_CHECK_INSTANCE_CAST ((widget), GTK_TYPE_WIDGET, GtkWidget))
#DEFINE GTK_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WIDGET, GtkWidgetClass))
#DEFINE GTK_IS_WIDGET(widget) (G_TYPE_CHECK_INSTANCE_TYPE ((widget), GTK_TYPE_WIDGET))
#DEFINE GTK_IS_WIDGET_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WIDGET))
#DEFINE GTK_WIDGET_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WIDGET, GtkWidgetClass))
#DEFINE GTK_TYPE_REQUISITION (gtk_requisition_get_type ())

Type GtkWidgetPrivate AS _GtkWidgetPrivate
Type GtkWidgetClass AS _GtkWidgetClass
Type GtkWidgetClassPrivate AS _GtkWidgetClassPrivate
Type GtkAllocation AS GdkRectangle
Type GtkTickCallback AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GdkFrameClock Ptr, BYVAL AS gpointer) AS gboolean

Type _GtkRequisition
	AS LONG width
	AS LONG height
End Type

Type _GtkWidget
	AS GInitiallyUnowned parent_instance
	AS GtkWidgetPrivate Ptr priv
End Type

Type _GtkWidgetClass
	AS GInitiallyUnownedClass parent_class
	show AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	hide AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	map AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	unmap AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	realize AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	unrealize AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	root AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	unroot AS SUB CDECL(BYVAL AS GtkWidget Ptr)
	size_allocate AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
	state_flags_changed AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkStateFlags)
	direction_changed AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkTextDirection)
	get_request_mode AS Function CDECL(BYVAL AS GtkWidget Ptr) AS GtkSizeRequestMode
	measure AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
	mnemonic_activate AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean) AS gboolean
	grab_focus AS Function CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
	focus AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkDirectionType) AS gboolean
	set_focus_child AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
	move_focus AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkDirectionType)
	keynav_failed AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkDirectionType) AS gboolean
	query_tooltip AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS gboolean, BYVAL AS GtkTooltip Ptr) AS gboolean
	compute_expand AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean Ptr, BYVAL AS gboolean Ptr)
	css_changed AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkCssStyleChange Ptr)
	system_setting_changed AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkSystemSetting)
	snapshot AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkSnapshot Ptr)
	contains AS Function CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS gboolean
	AS GtkWidgetClassPrivate Ptr priv
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_widget_get_type CDECL() AS GType
Declare SUB gtk_widget_unparent CDECL(BYVAL AS GtkWidget Ptr)


Declare SUB gtk_widget_map CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_unmap CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_realize CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_unrealize CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_queue_draw CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_queue_resize CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_queue_allocate CDECL(BYVAL AS GtkWidget Ptr)
Declare Function gtk_widget_get_frame_clock CDECL(BYVAL AS GtkWidget Ptr) AS GdkFrameClock Ptr
Declare SUB gtk_widget_size_allocate CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const GtkAllocation Ptr, BYVAL AS LONG)
Declare SUB gtk_widget_allocate CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GskTransform Ptr)
Declare Function gtk_widget_get_request_mode CDECL(BYVAL AS GtkWidget Ptr) AS GtkSizeRequestMode
Declare SUB gtk_widget_measure CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_widget_get_preferred_size CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkRequisition Ptr, BYVAL AS GtkRequisition Ptr)
Declare SUB gtk_widget_set_layout_manager CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkLayoutManager Ptr)
Declare Function gtk_widget_get_layout_manager CDECL(BYVAL AS GtkWidget Ptr) AS GtkLayoutManager Ptr
Declare SUB gtk_widget_class_set_layout_manager_type CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS GType)
Declare Function gtk_widget_class_get_layout_manager_type CDECL(BYVAL AS GtkWidgetClass Ptr) AS GType
Declare SUB gtk_widget_class_add_binding CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GtkShortcutFunc, BYVAL AS Const ZSTRING Ptr, ...)
Declare SUB gtk_widget_class_add_binding_signal CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, ...)
Declare SUB gtk_widget_class_add_binding_action CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, ...)
Declare SUB gtk_widget_class_add_shortcut CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS GtkShortcut Ptr)
Declare SUB gtk_widget_class_set_activate_signal CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS guint)
Declare SUB gtk_widget_class_set_activate_signal_from_name CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_class_get_activate_signal CDECL(BYVAL AS GtkWidgetClass Ptr) AS guint
Declare Function gtk_widget_mnemonic_activate CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean) AS gboolean
Declare Function gtk_widget_activate CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_can_focus CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_can_focus CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_focusable CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_focusable CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_has_focus CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_is_focus CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_has_visible_focus CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_grab_focus CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_focus_on_click CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_focus_on_click CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_can_target CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_can_target CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_has_default CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_receives_default CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_receives_default CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_name CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_get_name CDECL(BYVAL AS GtkWidget Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_widget_set_state_flags CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkStateFlags, BYVAL AS gboolean)
Declare SUB gtk_widget_unset_state_flags CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkStateFlags)
Declare Function gtk_widget_get_state_flags CDECL(BYVAL AS GtkWidget Ptr) AS GtkStateFlags
Declare SUB gtk_widget_set_sensitive CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_sensitive CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_is_sensitive CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_visible CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_visible CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_is_visible CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_is_drawable CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_get_realized CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_get_mapped CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_parent CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_widget_get_parent CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare Function gtk_widget_get_root CDECL(BYVAL AS GtkWidget Ptr) AS GtkRoot Ptr
Declare Function gtk_widget_get_native CDECL(BYVAL AS GtkWidget Ptr) AS GtkNative Ptr
Declare SUB gtk_widget_set_child_visible CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_child_visible CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_compute_transform CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS graphene_matrix_t Ptr) AS gboolean
Declare Function gtk_widget_compute_bounds CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS graphene_rect_t Ptr) AS gboolean
Declare Function gtk_widget_compute_point CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS graphene_point_t Ptr) AS gboolean
Declare Function gtk_widget_get_width CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare Function gtk_widget_get_height CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare Function gtk_widget_get_baseline CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare Function gtk_widget_get_size CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation) AS LONG
Declare Function gtk_widget_child_focus CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkDirectionType) AS gboolean
Declare Function gtk_widget_keynav_failed CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkDirectionType) AS gboolean
Declare SUB gtk_widget_error_bell CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_set_size_request CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_widget_get_size_request CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_widget_set_opacity CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE)
Declare Function gtk_widget_get_opacity CDECL(BYVAL AS GtkWidget Ptr) AS DOUBLE
Declare SUB gtk_widget_set_overflow CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkOverflow)
Declare Function gtk_widget_get_overflow CDECL(BYVAL AS GtkWidget Ptr) AS GtkOverflow
Declare Function gtk_widget_get_ancestor CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GType) AS GtkWidget Ptr
Declare Function gtk_widget_get_scale_factor CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare Function gtk_widget_get_display CDECL(BYVAL AS GtkWidget Ptr) AS GdkDisplay Ptr
Declare Function gtk_widget_get_settings CDECL(BYVAL AS GtkWidget Ptr) AS GtkSettings Ptr
Declare Function gtk_widget_get_clipboard CDECL(BYVAL AS GtkWidget Ptr) AS GdkClipboard Ptr
Declare Function gtk_widget_get_primary_clipboard CDECL(BYVAL AS GtkWidget Ptr) AS GdkClipboard Ptr
Declare Function gtk_widget_get_hexpand CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_hexpand CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_hexpand_set CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_hexpand_set CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_vexpand CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_vexpand CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_vexpand_set CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_set_vexpand_set CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_compute_expand CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation) AS gboolean
Declare Function gtk_widget_get_halign CDECL(BYVAL AS GtkWidget Ptr) AS GtkAlign
Declare SUB gtk_widget_set_halign CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkAlign)
Declare Function gtk_widget_get_valign CDECL(BYVAL AS GtkWidget Ptr) AS GtkAlign
Declare SUB gtk_widget_set_valign CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkAlign)
Declare Function gtk_widget_get_margin_start CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare SUB gtk_widget_set_margin_start CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare Function gtk_widget_get_margin_end CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare SUB gtk_widget_set_margin_end CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare Function gtk_widget_get_margin_top CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare SUB gtk_widget_set_margin_top CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare Function gtk_widget_get_margin_bottom CDECL(BYVAL AS GtkWidget Ptr) AS LONG
Declare SUB gtk_widget_set_margin_bottom CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare Function gtk_widget_is_ancestor CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_contains CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS gboolean
Declare Function gtk_widget_pick CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS GtkPickFlags) AS GtkWidget Ptr
Declare SUB gtk_widget_add_controller CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkEventController Ptr)
Declare SUB gtk_widget_remove_controller CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkEventController Ptr)
Declare Function gtk_widget_create_pango_context CDECL(BYVAL AS GtkWidget Ptr) AS PangoContext Ptr
Declare Function gtk_widget_get_pango_context CDECL(BYVAL AS GtkWidget Ptr) AS PangoContext Ptr
Declare Function gtk_widget_create_pango_layout CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr) AS PangoLayout Ptr
Declare SUB gtk_widget_set_direction CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkTextDirection)
Declare Function gtk_widget_get_direction CDECL(BYVAL AS GtkWidget Ptr) AS GtkTextDirection
Declare SUB gtk_widget_set_default_direction CDECL(BYVAL AS GtkTextDirection)
Declare Function gtk_widget_get_default_direction CDECL() AS GtkTextDirection
Declare SUB gtk_widget_set_cursor CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GdkCursor Ptr)
Declare SUB gtk_widget_set_cursor_from_name CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_get_cursor CDECL(BYVAL AS GtkWidget Ptr) AS GdkCursor Ptr
Declare Function gtk_widget_list_mnemonic_labels CDECL(BYVAL AS GtkWidget Ptr) AS GList Ptr
Declare SUB gtk_widget_add_mnemonic_label CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_remove_mnemonic_label CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_trigger_tooltip_query CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_set_tooltip_text CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_get_tooltip_text CDECL(BYVAL AS GtkWidget Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_widget_set_tooltip_markup CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_get_tooltip_markup CDECL(BYVAL AS GtkWidget Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_widget_set_has_tooltip CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_widget_get_has_tooltip CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_requisition_get_type CDECL() AS GType
Declare Function gtk_requisition_new CDECL() AS GtkRequisition Ptr
Declare Function gtk_requisition_copy CDECL(BYVAL AS Const GtkRequisition Ptr) AS GtkRequisition Ptr
Declare SUB gtk_requisition_free CDECL(BYVAL AS GtkRequisition Ptr)
Declare Function gtk_widget_in_destruction CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_widget_class_set_css_name CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_class_get_css_name CDECL(BYVAL AS GtkWidgetClass Ptr) AS Const ZSTRING Ptr
Declare Function gtk_widget_add_tick_callback CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkTickCallback, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
Declare SUB gtk_widget_remove_tick_callback CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS guint)

#DEFINE gtk_widget_class_bind_template_callback(widget_class, callback) _
  gtk_widget_class_bind_template_callback_full (GTK_WIDGET_CLASS (widget_class), _
                                                #callback, _
                                                G_CALLBACK (callback))
#DEFINE gtk_widget_class_bind_template_child(widget_class, TypeName, member_name) _
  gtk_widget_class_bind_template_child_full (widget_class, _
                                             #member_name, _
                                             FALSE, _
                                             G_STRUCT_OFFSET (TypeName, member_name))
#DEFINE gtk_widget_class_bind_template_child_internal(widget_class, TypeName, member_name) _
  gtk_widget_class_bind_template_child_full (widget_class, _
                                             #member_name, _
                                             TRUE, _
                                             G_STRUCT_OFFSET (TypeName, member_name))
#DEFINE gtk_widget_class_bind_template_child_private(widget_class, TypeName, member_name) _
  gtk_widget_class_bind_template_child_full (widget_class, _
                                             #member_name, _
                                             FALSE, _
                                             G_PRIVATE_OFFSET (TypeName, member_name))
#DEFINE gtk_widget_class_bind_template_child_internal_private(widget_class, TypeName, member_name) _
  gtk_widget_class_bind_template_child_full (widget_class, _
                                             #member_name, _
                                             TRUE, _
                                             G_PRIVATE_OFFSET (TypeName, member_name))

Declare SUB gtk_widget_init_template CDECL(BYVAL AS GtkWidget Ptr)
Declare Function gtk_widget_get_template_child CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GType, BYVAL AS Const ZSTRING Ptr) AS GObject Ptr
Declare SUB gtk_widget_dispose_template CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GType)
Declare SUB gtk_widget_class_set_template CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS GBytes Ptr)
Declare SUB gtk_widget_class_set_template_from_resource CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_widget_class_bind_template_callback_full CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GCallback)
Declare SUB gtk_widget_class_set_template_scope CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS GtkBuilderScope Ptr)
Declare SUB gtk_widget_class_bind_template_child_full CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gboolean, BYVAL AS gssize)
Declare SUB gtk_widget_insert_action_group CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GActionGroup Ptr)
Declare Function gtk_widget_activate_action CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, ...) AS gboolean
Declare Function gtk_widget_activate_action_variant CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GVariant Ptr) AS gboolean
Declare SUB gtk_widget_activate_default CDECL(BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_set_font_map CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS PangoFontMap Ptr)
Declare Function gtk_widget_get_font_map CDECL(BYVAL AS GtkWidget Ptr) AS PangoFontMap Ptr
Declare Function gtk_widget_get_first_child CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare Function gtk_widget_get_last_child CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare Function gtk_widget_get_next_sibling CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare Function gtk_widget_get_prev_sibling CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare Function gtk_widget_observe_children CDECL(BYVAL AS GtkWidget Ptr) AS GListModel Ptr
Declare Function gtk_widget_observe_controllers CDECL(BYVAL AS GtkWidget Ptr) AS GListModel Ptr
Declare SUB gtk_widget_insert_after CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_insert_before CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_widget_set_focus_child CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_widget_get_focus_child CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare SUB gtk_widget_snapshot_child CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkSnapshot Ptr)
Declare Function gtk_widget_should_layout CDECL(BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_widget_get_css_name CDECL(BYVAL AS GtkWidget Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_widget_add_css_class CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_widget_remove_css_class CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_has_css_class CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_widget_get_css_classes CDECL(BYVAL AS GtkWidget Ptr) AS ZSTRING Ptr Ptr
Declare SUB gtk_widget_set_css_classes CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr Ptr)
Declare SUB gtk_widget_get_color CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GdkRGBA Ptr)
Type GtkWidgetActionActivateFunc AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GVariant Ptr)
Declare SUB gtk_widget_class_install_action CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkWidgetActionActivateFunc)
Declare SUB gtk_widget_class_install_property_action CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_widget_class_query_action CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS guint, BYVAL AS GType Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS Const GVariantType Ptr Ptr, BYVAL AS Const ZSTRING Ptr Ptr) AS gboolean
Declare SUB gtk_widget_action_set_enabled CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gboolean)
Declare SUB gtk_widget_class_set_accessible_role CDECL(BYVAL AS GtkWidgetClass Ptr, BYVAL AS GtkAccessibleRole)
Declare Function gtk_widget_class_get_accessible_role CDECL(BYVAL AS GtkWidgetClass Ptr) AS GtkAccessibleRole

#DEFINE GTK_TYPE_APPLICATION (gtk_application_get_type ())
#DEFINE GTK_APPLICATION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_APPLICATION, GtkApplication))
#DEFINE GTK_APPLICATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_APPLICATION, GtkApplicationClass))
#DEFINE GTK_IS_APPLICATION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_APPLICATION))
#DEFINE GTK_IS_APPLICATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_APPLICATION))
#DEFINE GTK_APPLICATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_APPLICATION, GtkApplicationClass))

Type GtkApplication AS _GtkApplication
Type GtkApplicationClass AS _GtkApplicationClass

Type _GtkApplication
	AS GApplication parent_instance
End Type

Type _GtkApplicationClass
	AS GApplicationClass parent_class
	window_added AS SUB CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS GtkWindow Ptr)
	window_removed AS SUB CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS GtkWindow Ptr)
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_application_get_type CDECL() AS GType
Declare Function gtk_application_new CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GApplicationFlags) AS GtkApplication Ptr
Declare SUB gtk_application_add_window CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS GtkWindow Ptr)
Declare SUB gtk_application_remove_window CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS GtkWindow Ptr)
Declare Function gtk_application_get_windows CDECL(BYVAL AS GtkApplication Ptr) AS GList Ptr
Declare Function gtk_application_get_menubar CDECL(BYVAL AS GtkApplication Ptr) AS GMenuModel Ptr
Declare SUB gtk_application_set_menubar CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS GMenuModel Ptr)

Enum GtkApplicationInhibitFlags_
	GTK_APPLICATION_INHIBIT_LOGOUT = (1  SHL 0)
	GTK_APPLICATION_INHIBIT_SWITCH = (1  SHL 1)
	GTK_APPLICATION_INHIBIT_SUSPEND = (1  SHL 2)
	GTK_APPLICATION_INHIBIT_IDLE = (1  SHL 3)
End Enum
Type AS LONG GtkApplicationInhibitFlags

Declare Function gtk_application_inhibit CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GtkApplicationInhibitFlags, BYVAL AS Const ZSTRING Ptr) AS guint
Declare SUB gtk_application_uninhibit CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS guint)
Declare Function gtk_application_get_window_by_id CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS guint) AS GtkWindow Ptr
Declare Function gtk_application_get_active_window CDECL(BYVAL AS GtkApplication Ptr) AS GtkWindow Ptr
Declare Function gtk_application_list_action_descriptions CDECL(BYVAL AS GtkApplication Ptr) AS ZSTRING Ptr Ptr
Declare Function gtk_application_get_accels_for_action CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS Const ZSTRING Ptr) AS ZSTRING Ptr Ptr
Declare Function gtk_application_get_actions_for_accel CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS Const ZSTRING Ptr) AS ZSTRING Ptr Ptr
Declare SUB gtk_application_set_accels_for_action CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Const Ptr Ptr)
Declare Function gtk_application_get_menu_by_id CDECL(BYVAL AS GtkApplication Ptr, BYVAL AS Const ZSTRING Ptr) AS GMenu Ptr

Declare Function gtk_accelerator_valid CDECL(BYVAL AS guint, BYVAL AS GdkModifierType) AS gboolean
Declare Function gtk_accelerator_parse CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS guint Ptr, BYVAL AS GdkModifierType Ptr) AS gboolean
Declare Function gtk_accelerator_parse_with_keycode CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GdkDisplay Ptr, BYVAL AS guint Ptr, BYVAL AS guint Ptr Ptr, BYVAL AS GdkModifierType Ptr) AS gboolean
Declare Function gtk_accelerator_name CDECL(BYVAL AS guint, BYVAL AS GdkModifierType) AS ZSTRING Ptr
Declare Function gtk_accelerator_name_with_keycode CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS GdkModifierType) AS ZSTRING Ptr
Declare Function gtk_accelerator_get_label CDECL(BYVAL AS guint, BYVAL AS GdkModifierType) AS ZSTRING Ptr
Declare Function gtk_accelerator_get_label_with_keycode CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS GdkModifierType) AS ZSTRING Ptr
Declare Function gtk_accelerator_get_default_mod_mask CDECL() AS GdkModifierType

#DEFINE GTK_TYPE_WINDOW (gtk_window_get_type ())
#DEFINE GTK_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_WINDOW, GtkWindow))
#DEFINE GTK_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WINDOW, GtkWindowClass))
#DEFINE GTK_IS_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_WINDOW))
#DEFINE GTK_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WINDOW))
#DEFINE GTK_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WINDOW, GtkWindowClass))

Type GtkWindowClass AS _GtkWindowClass
Type GtkWindowGroup AS _GtkWindowGroup
Type GtkWindowGroupClass AS _GtkWindowGroupClass
Type GtkWindowGroupPrivate AS _GtkWindowGroupPrivate

Type _GtkWindow
	AS GtkWidget parent_instance
End Type

Type _GtkWindowClass
	AS GtkWidgetClass parent_class
	activate_focus AS SUB CDECL(BYVAL AS GtkWindow Ptr)
	activate_default AS SUB CDECL(BYVAL AS GtkWindow Ptr)
	keys_changed AS SUB CDECL(BYVAL AS GtkWindow Ptr)
	enable_debugging AS Function CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean) AS gboolean
	close_request AS Function CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_window_get_type CDECL() AS GType
Declare Function gtk_window_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_window_set_title CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_window_get_title CDECL(BYVAL AS GtkWindow Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_window_set_startup_id CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_window_set_focus CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_window_get_focus CDECL(BYVAL AS GtkWindow Ptr) AS GtkWidget Ptr
Declare SUB gtk_window_set_default_widget CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_window_get_default_widget CDECL(BYVAL AS GtkWindow Ptr) AS GtkWidget Ptr
Declare SUB gtk_window_set_transient_for CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkWindow Ptr)
Declare Function gtk_window_get_transient_for CDECL(BYVAL AS GtkWindow Ptr) AS GtkWindow Ptr
Declare SUB gtk_window_set_destroy_with_parent CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_destroy_with_parent CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_hide_on_close CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_hide_on_close CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_mnemonics_visible CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_mnemonics_visible CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_focus_visible CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_focus_visible CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_resizable CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_resizable CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_display CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GdkDisplay Ptr)
Declare Function gtk_window_is_active CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_decorated CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_decorated CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_deletable CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_deletable CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_set_icon_name CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_window_get_icon_name CDECL(BYVAL AS GtkWindow Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_window_set_default_icon_name CDECL(BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_window_get_default_icon_name CDECL() AS Const ZSTRING Ptr
Declare SUB gtk_window_set_auto_startup_notification CDECL(BYVAL AS gboolean)
Declare SUB gtk_window_set_modal CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_modal CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare Function gtk_window_get_toplevels CDECL() AS GListModel Ptr
Declare Function gtk_window_list_toplevels CDECL() AS GList Ptr
Declare SUB gtk_window_present CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_minimize CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_unminimize CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_maximize CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_unmaximize CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_fullscreen CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_unfullscreen CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_fullscreen_on_monitor CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GdkMonitor Ptr)
Declare SUB gtk_window_close CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_set_default_size CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_window_get_default_size CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Function gtk_window_get_group CDECL(BYVAL AS GtkWindow Ptr) AS GtkWindowGroup Ptr
Declare Function gtk_window_has_group CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare Function gtk_window_get_application CDECL(BYVAL AS GtkWindow Ptr) AS GtkApplication Ptr
Declare SUB gtk_window_set_application CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkApplication Ptr)
Declare SUB gtk_window_set_child CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_window_get_child CDECL(BYVAL AS GtkWindow Ptr) AS GtkWidget Ptr
Declare SUB gtk_window_set_titlebar CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_window_get_titlebar CDECL(BYVAL AS GtkWindow Ptr) AS GtkWidget Ptr
Declare Function gtk_window_is_maximized CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare Function gtk_window_is_fullscreen CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare Function gtk_window_is_suspended CDECL(BYVAL AS GtkWindow Ptr) AS gboolean
Declare SUB gtk_window_destroy CDECL(BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_set_interactive_debugging CDECL(BYVAL AS gboolean)
Declare SUB gtk_window_set_handle_menubar_accel CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_window_get_handle_menubar_accel CDECL(BYVAL AS GtkWindow Ptr) AS gboolean

#DEFINE GTK_TYPE_ABOUT_DIALOG (gtk_about_dialog_get_type ())
#DEFINE GTK_ABOUT_DIALOG(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_ABOUT_DIALOG, GtkAboutDialog))
#DEFINE GTK_IS_ABOUT_DIALOG(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_ABOUT_DIALOG))

Type GtkAboutDialog AS _GtkAboutDialog

Enum GtkLicense_
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
	GTK_LICENSE_AGPL_3_0
	GTK_LICENSE_AGPL_3_0_ONLY
	GTK_LICENSE_BSD_3
	GTK_LICENSE_APACHE_2_0
	GTK_LICENSE_MPL_2_0
	GTK_LICENSE_0BSD
End Enum
Type AS LONG GtkLicense

Declare Function gtk_about_dialog_get_type CDECL() AS GType
Declare Function gtk_about_dialog_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_show_about_dialog CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS Const ZSTRING Ptr, ...)
Declare Function gtk_about_dialog_get_program_name CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_program_name CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_version CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_version CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_copyright CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_copyright CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_comments CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_comments CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_license CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_license CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_about_dialog_set_license_type CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS GtkLicense)
Declare Function gtk_about_dialog_get_license_type CDECL(BYVAL AS GtkAboutDialog Ptr) AS GtkLicense
Declare Function gtk_about_dialog_get_wrap_license CDECL(BYVAL AS GtkAboutDialog Ptr) AS gboolean
Declare SUB gtk_about_dialog_set_wrap_license CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_about_dialog_get_system_information CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_system_information CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_website CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_website CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_website_label CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_website_label CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_authors CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Const Ptr Ptr
Declare SUB gtk_about_dialog_set_authors CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr Ptr)
Declare Function gtk_about_dialog_get_documenters CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Const Ptr Ptr
Declare SUB gtk_about_dialog_set_documenters CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr Ptr)
Declare Function gtk_about_dialog_get_artists CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Const Ptr Ptr
Declare SUB gtk_about_dialog_set_artists CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr Ptr)
Declare Function gtk_about_dialog_get_translator_credits CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_translator_credits CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_about_dialog_get_logo CDECL(BYVAL AS GtkAboutDialog Ptr) AS GdkPaintable Ptr
Declare SUB gtk_about_dialog_set_logo CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS GdkPaintable Ptr)
Declare Function gtk_about_dialog_get_logo_icon_name CDECL(BYVAL AS GtkAboutDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_about_dialog_set_logo_icon_name CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_about_dialog_add_credit_section CDECL(BYVAL AS GtkAboutDialog Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr Ptr)


#DEFINE GTK_TYPE_ACCESSIBLE (gtk_accessible_get_type())

Type GtkAccessible AS _GtkAccessible

Enum GtkAccessiblePlatformState_
	GTK_ACCESSIBLE_PLATFORM_STATE_FOCUSABLE
	GTK_ACCESSIBLE_PLATFORM_STATE_FOCUSED
	GTK_ACCESSIBLE_PLATFORM_STATE_ACTIVE
End Enum
Type AS LONG GtkAccessiblePlatformState

Type _GtkAccessibleInterface
	AS GTypeInterface g_iface
	get_at_context AS Function CDECL(BYVAL AS GtkAccessible Ptr) AS GtkATContext Ptr
	get_platform_state AS Function CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessiblePlatformState) AS gboolean
	get_accessible_parent AS Function CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessible Ptr
	get_first_accessible_child AS Function CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessible Ptr
	get_next_accessible_sibling AS Function CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessible Ptr
	get_bounds AS Function CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
End Type

Type GtkAccessibleList AS _GtkAccessibleList

Declare Function gtk_accessible_get_at_context CDECL(BYVAL AS GtkAccessible Ptr) AS GtkATContext Ptr
Declare Function gtk_accessible_get_platform_state CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessiblePlatformState) AS gboolean
Declare Function gtk_accessible_get_accessible_parent CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessible Ptr
Declare SUB gtk_accessible_set_accessible_parent CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessible Ptr)
Declare Function gtk_accessible_get_first_accessible_child CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessible Ptr
Declare Function gtk_accessible_get_next_accessible_sibling CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessible Ptr
Declare SUB gtk_accessible_update_next_accessible_sibling CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessible Ptr)
Declare Function gtk_accessible_get_bounds CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
Declare Function gtk_accessible_get_accessible_role CDECL(BYVAL AS GtkAccessible Ptr) AS GtkAccessibleRole
Declare SUB gtk_accessible_update_state CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleState, ...)
Declare SUB gtk_accessible_update_property CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleProperty, ...)
Declare SUB gtk_accessible_update_relation CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleRelation, ...)
Declare SUB gtk_accessible_update_state_value CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS LONG, BYVAL AS GtkAccessibleState Ptr, BYVAL AS Const GValue Ptr)
Declare SUB gtk_accessible_update_property_value CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS LONG, BYVAL AS GtkAccessibleProperty Ptr, BYVAL AS Const GValue Ptr)
Declare SUB gtk_accessible_update_relation_value CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS LONG, BYVAL AS GtkAccessibleRelation Ptr, BYVAL AS Const GValue Ptr)
Declare SUB gtk_accessible_reset_state CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleState)
Declare SUB gtk_accessible_reset_property CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleProperty)
Declare SUB gtk_accessible_reset_relation CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleRelation)
Declare SUB gtk_accessible_state_init_value CDECL(BYVAL AS GtkAccessibleState, BYVAL AS GValue Ptr)
Declare SUB gtk_accessible_property_init_value CDECL(BYVAL AS GtkAccessibleProperty, BYVAL AS GValue Ptr)
Declare SUB gtk_accessible_relation_init_value CDECL(BYVAL AS GtkAccessibleRelation, BYVAL AS GValue Ptr)

#DEFINE GTK_ACCESSIBLE_LIST (gtk_accessible_list_get_type())

Declare Function gtk_accessible_list_get_type CDECL() AS GType
Declare Function gtk_accessible_list_get_objects CDECL(BYVAL AS GtkAccessibleList Ptr) AS GList Ptr
Declare Function gtk_accessible_list_new_from_list CDECL(BYVAL AS GList Ptr) AS GtkAccessibleList Ptr
Declare Function gtk_accessible_list_new_from_array CDECL(BYVAL AS GtkAccessible Ptr Ptr, BYVAL AS gsize) AS GtkAccessibleList Ptr
Declare SUB gtk_accessible_announce CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkAccessibleAnnouncementPriority)


Type GtkAccessibleRange AS _GtkAccessibleRange

Type _GtkAccessibleRangeInterface
	AS GTypeInterface g_iface
	set_current_value AS Function CDECL(BYVAL AS GtkAccessibleRange Ptr, BYVAL AS DOUBLE) AS gboolean
End Type

#DEFINE GTK_TYPE_ACCESSIBLE_TEXT (gtk_accessible_text_get_type ())
Type GtkAccessibleText AS _GtkAccessibleText

Type GtkAccessibleTextRange
	AS gsize start
	AS gsize length
End Type

Enum GtkAccessibleTextGranularity_
	GTK_ACCESSIBLE_TEXT_GRANULARITY_CHARACTER
	GTK_ACCESSIBLE_TEXT_GRANULARITY_WORD
	GTK_ACCESSIBLE_TEXT_GRANULARITY_SENTENCE
	GTK_ACCESSIBLE_TEXT_GRANULARITY_LINE
	GTK_ACCESSIBLE_TEXT_GRANULARITY_PARAGRAPH
End Enum
Type AS LONG GtkAccessibleTextGranularity

Enum GtkAccessibleTextContentChange_
	GTK_ACCESSIBLE_TEXT_CONTENT_CHANGE_INSERT
	GTK_ACCESSIBLE_TEXT_CONTENT_CHANGE_REMOVE
End Enum
Type AS LONG GtkAccessibleTextContentChange

Type _GtkAccessibleTextInterface
	AS GTypeInterface g_iface
	get_contents AS Function CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS ULONG, BYVAL AS ULONG) AS GBytes Ptr
	get_contents_at AS Function CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS ULONG, BYVAL AS GtkAccessibleTextGranularity, BYVAL AS ULONG Ptr, BYVAL AS ULONG Ptr) AS GBytes Ptr
	get_caret_position AS Function CDECL(BYVAL AS GtkAccessibleText Ptr) AS ULONG
	get_selection AS Function CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS gsize Ptr, BYVAL AS GtkAccessibleTextRange Ptr Ptr) AS gboolean
	get_attributes AS Function CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS ULONG, BYVAL AS gsize Ptr, BYVAL AS GtkAccessibleTextRange Ptr Ptr, BYVAL AS ZSTRING Ptr Ptr Ptr, BYVAL AS ZSTRING Ptr Ptr Ptr) AS gboolean
	get_default_attributes AS SUB CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS ZSTRING Ptr Ptr Ptr, BYVAL AS ZSTRING Ptr Ptr Ptr)
	get_extents AS Function CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS ULONG, BYVAL AS ULONG, BYVAL AS graphene_rect_t Ptr) AS gboolean
	get_offset AS Function CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS ULONG Ptr) AS gboolean
End Type

Declare SUB gtk_accessible_text_update_caret_position CDECL(BYVAL AS GtkAccessibleText Ptr)
Declare SUB gtk_accessible_text_update_selection_bound CDECL(BYVAL AS GtkAccessibleText Ptr)
Declare SUB gtk_accessible_text_update_contents CDECL(BYVAL AS GtkAccessibleText Ptr, BYVAL AS GtkAccessibleTextContentChange, BYVAL AS ULONG, BYVAL AS ULONG)

#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_FAMILY @!"family-name"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STYLE @!"style"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_WEIGHT @!"weight"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT @!"variant"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH @!"stretch"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_SIZE @!"size"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_FOREGROUND @!"fg-color"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_BACKGROUND @!"bg-color"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_UNDERLINE @!"underline"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_OVERLINE @!"overline"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRIKETHROUGH @!"strikethrough"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STYLE_NORMAL @!"normal"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STYLE_OBLIQUE @!"oblique"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STYLE_ITALIC @!"italic"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT_SMALL_CAPS @!"small-caps"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT_ALL_SMALL_CAPS @!"all-small-caps"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT_PETITE_CAPS @!"petite-caps"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT_ALL_PETITE_CAPS @!"all-petite-caps"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT_UNICASE @!"unicase"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_VARIANT_TITLE_CAPS @!"title-caps"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_ULTRA_CONDENSED @!"ultra_condensed"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_EXTRA_CONDENSED @!"extra_condensed"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_CONDENSED @!"condensed"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_SEMI_CONDENSED @!"semi_condensed"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_NORMAL @!"normal"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_SEMI_EXPANDED @!"semi_expanded"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_EXPANDED @!"expanded"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_EXTRA_EXPANDED @!"extra_expanded"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_STRETCH_ULTRA_EXPANDED @!"ultra_expanded"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_UNDERLINE_NONE @!"none"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_UNDERLINE_SINGLE @!"single"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_UNDERLINE_DOUBLE @!"double"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_UNDERLINE_ERROR @!"error"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_OVERLINE_NONE @!"none"
#DEFINE GTK_ACCESSIBLE_ATTRIBUTE_OVERLINE_SINGLE @!"single"

#DEFINE GTK_TYPE_ACTIONABLE (gtk_actionable_get_type ())
#DEFINE GTK_ACTIONABLE(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                             GTK_TYPE_ACTIONABLE, GtkActionable))
#DEFINE GTK_IS_ACTIONABLE(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                             GTK_TYPE_ACTIONABLE))
#DEFINE GTK_ACTIONABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), _
                                                             GTK_TYPE_ACTIONABLE, GtkActionableInterface))

Type GtkActionableInterface AS _GtkActionableInterface
Type GtkActionable AS _GtkActionable

Type _GtkActionableInterface
	AS GTypeInterface g_iface
	get_action_name AS Function CDECL(BYVAL AS GtkActionable Ptr) AS Const ZSTRING Ptr
	set_action_name AS SUB CDECL(BYVAL AS GtkActionable Ptr, BYVAL AS Const ZSTRING Ptr)
	get_action_target_value AS Function CDECL(BYVAL AS GtkActionable Ptr) AS GVariant Ptr
	set_action_target_value AS SUB CDECL(BYVAL AS GtkActionable Ptr, BYVAL AS GVariant Ptr)
End Type

Declare Function gtk_actionable_get_type CDECL() AS GType
Declare Function gtk_actionable_get_action_name CDECL(BYVAL AS GtkActionable Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_actionable_set_action_name CDECL(BYVAL AS GtkActionable Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_actionable_get_action_target_value CDECL(BYVAL AS GtkActionable Ptr) AS GVariant Ptr
Declare SUB gtk_actionable_set_action_target_value CDECL(BYVAL AS GtkActionable Ptr, BYVAL AS GVariant Ptr)
Declare SUB gtk_actionable_set_action_target CDECL(BYVAL AS GtkActionable Ptr, BYVAL AS Const ZSTRING Ptr, ...)
Declare SUB gtk_actionable_set_detailed_action_name CDECL(BYVAL AS GtkActionable Ptr, BYVAL AS Const ZSTRING Ptr)


#DEFINE GTK_TYPE_ACTION_BAR (gtk_action_bar_get_type ())
#DEFINE GTK_ACTION_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ACTION_BAR, GtkActionBar))
#DEFINE GTK_IS_ACTION_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ACTION_BAR))

Type GtkActionBar AS _GtkActionBar

Declare Function gtk_action_bar_get_type CDECL() AS GType
Declare Function gtk_action_bar_new CDECL() AS GtkWidget Ptr
Declare Function gtk_action_bar_get_center_widget CDECL(BYVAL AS GtkActionBar Ptr) AS GtkWidget Ptr
Declare SUB gtk_action_bar_set_center_widget CDECL(BYVAL AS GtkActionBar Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_action_bar_pack_start CDECL(BYVAL AS GtkActionBar Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_action_bar_pack_end CDECL(BYVAL AS GtkActionBar Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_action_bar_remove CDECL(BYVAL AS GtkActionBar Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_action_bar_set_revealed CDECL(BYVAL AS GtkActionBar Ptr, BYVAL AS gboolean)
Declare Function gtk_action_bar_get_revealed CDECL(BYVAL AS GtkActionBar Ptr) AS gboolean


#DEFINE GTK_TYPE_ADJUSTMENT (gtk_adjustment_get_type ())
#DEFINE GTK_ADJUSTMENT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustment))
#DEFINE GTK_ADJUSTMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass))
#DEFINE GTK_IS_ADJUSTMENT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ADJUSTMENT))
#DEFINE GTK_IS_ADJUSTMENT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ADJUSTMENT))
#DEFINE GTK_ADJUSTMENT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ADJUSTMENT, GtkAdjustmentClass))

Type GtkAdjustmentClass AS _GtkAdjustmentClass

Type _GtkAdjustment
	AS GInitiallyUnowned parent_instance
End Type

Type _GtkAdjustmentClass
	AS GInitiallyUnownedClass parent_class
	changed AS SUB CDECL(BYVAL AS GtkAdjustment Ptr)
	value_changed AS SUB CDECL(BYVAL AS GtkAdjustment Ptr)
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type

Declare Function gtk_adjustment_get_type CDECL() AS GType
Declare Function gtk_adjustment_new CDECL(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GtkAdjustment Ptr
Declare SUB gtk_adjustment_clamp_page CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_value CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE
Declare SUB gtk_adjustment_set_value CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_lower CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE
Declare SUB gtk_adjustment_set_lower CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_upper CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE
Declare SUB gtk_adjustment_set_upper CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_step_increment CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE
Declare SUB gtk_adjustment_set_step_increment CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_page_increment CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE
Declare SUB gtk_adjustment_set_page_increment CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_page_size CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE
Declare SUB gtk_adjustment_set_page_size CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_adjustment_configure CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare Function gtk_adjustment_get_minimum_increment CDECL(BYVAL AS GtkAdjustment Ptr) AS DOUBLE


#DEFINE GTK_TYPE_ALERT_DIALOG (gtk_alert_dialog_get_type ())

Type GtkAlertDialog AS _GtkAlertDialog
Declare Function gtk_alert_dialog_new CDECL(BYVAL AS Const ZSTRING Ptr, ...) AS GtkAlertDialog Const Ptr
Declare Function gtk_alert_dialog_get_modal CDECL(BYVAL AS GtkAlertDialog Ptr) AS gboolean
Declare SUB gtk_alert_dialog_set_modal CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_alert_dialog_get_message CDECL(BYVAL AS GtkAlertDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_alert_dialog_set_message CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_alert_dialog_get_detail CDECL(BYVAL AS GtkAlertDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_alert_dialog_set_detail CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_alert_dialog_get_buttons CDECL(BYVAL AS GtkAlertDialog Ptr) AS Const ZSTRING Const Ptr Ptr
Declare SUB gtk_alert_dialog_set_buttons CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS Const ZSTRING Const Ptr Ptr)
Declare Function gtk_alert_dialog_get_cancel_button CDECL(BYVAL AS GtkAlertDialog Ptr) AS LONG
Declare SUB gtk_alert_dialog_set_cancel_button CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS LONG)
Declare Function gtk_alert_dialog_get_default_button CDECL(BYVAL AS GtkAlertDialog Ptr) AS LONG
Declare SUB gtk_alert_dialog_set_default_button CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS LONG)
Declare SUB gtk_alert_dialog_choose CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_alert_dialog_choose_finish CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS LONG
Declare SUB gtk_alert_dialog_show CDECL(BYVAL AS GtkAlertDialog Ptr, BYVAL AS GtkWindow Ptr)


#DEFINE GTK_TYPE_APPLICATION_WINDOW (gtk_application_window_get_type ())
#DEFINE GTK_APPLICATION_WINDOW(inst) (G_TYPE_CHECK_INSTANCE_CAST ((inst), _
                                                GTK_TYPE_APPLICATION_WINDOW, GtkApplicationWindow))
#DEFINE GTK_APPLICATION_WINDOW_CLASS(class) (G_TYPE_CHECK_CLASS_CAST ((class), _
                                                GTK_TYPE_APPLICATION_WINDOW, GtkApplicationWindowClass))
#DEFINE GTK_IS_APPLICATION_WINDOW(inst) (G_TYPE_CHECK_INSTANCE_TYPE ((inst), _
                                                GTK_TYPE_APPLICATION_WINDOW))
#DEFINE GTK_IS_APPLICATION_WINDOW_CLASS(class) (G_TYPE_CHECK_CLASS_TYPE ((class), _
                                                GTK_TYPE_APPLICATION_WINDOW))
#DEFINE GTK_APPLICATION_WINDOW_GET_CLASS(inst) (G_TYPE_INSTANCE_GET_CLASS ((inst), _
                                                GTK_TYPE_APPLICATION_WINDOW, GtkApplicationWindowClass))

Type GtkApplicationWindowClass AS _GtkApplicationWindowClass
Type GtkApplicationWindow AS _GtkApplicationWindow

Type _GtkApplicationWindow
	AS GtkWindow parent_instance
End Type

Type _GtkApplicationWindowClass
	AS GtkWindowClass parent_class
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_application_window_get_type CDECL() AS GType
Declare Function gtk_application_window_new CDECL(BYVAL AS GtkApplication Ptr) AS GtkWidget Ptr
Declare SUB gtk_application_window_set_show_menubar CDECL(BYVAL AS GtkApplicationWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_application_window_get_show_menubar CDECL(BYVAL AS GtkApplicationWindow Ptr) AS gboolean
Declare Function gtk_application_window_get_id CDECL(BYVAL AS GtkApplicationWindow Ptr) AS guint


#DEFINE GTK_TYPE_ASPECT_FRAME (gtk_aspect_frame_get_type ())
#DEFINE GTK_ASPECT_FRAME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ASPECT_FRAME, GtkAspectFrame))
#DEFINE GTK_IS_ASPECT_FRAME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ASPECT_FRAME))

Type GtkAspectFrame AS _GtkAspectFrame

Declare Function gtk_aspect_frame_get_type CDECL() AS GType
Declare Function gtk_aspect_frame_new CDECL(BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS gboolean) AS GtkWidget Ptr
Declare SUB gtk_aspect_frame_set_xalign CDECL(BYVAL AS GtkAspectFrame Ptr, BYVAL AS SINGLE)
Declare Function gtk_aspect_frame_get_xalign CDECL(BYVAL AS GtkAspectFrame Ptr) AS SINGLE
Declare SUB gtk_aspect_frame_set_yalign CDECL(BYVAL AS GtkAspectFrame Ptr, BYVAL AS SINGLE)
Declare Function gtk_aspect_frame_get_yalign CDECL(BYVAL AS GtkAspectFrame Ptr) AS SINGLE
Declare SUB gtk_aspect_frame_set_ratio CDECL(BYVAL AS GtkAspectFrame Ptr, BYVAL AS SINGLE)
Declare Function gtk_aspect_frame_get_ratio CDECL(BYVAL AS GtkAspectFrame Ptr) AS SINGLE
Declare SUB gtk_aspect_frame_set_obey_child CDECL(BYVAL AS GtkAspectFrame Ptr, BYVAL AS gboolean)
Declare Function gtk_aspect_frame_get_obey_child CDECL(BYVAL AS GtkAspectFrame Ptr) AS gboolean
Declare SUB gtk_aspect_frame_set_child CDECL(BYVAL AS GtkAspectFrame Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_aspect_frame_get_child CDECL(BYVAL AS GtkAspectFrame Ptr) AS GtkWidget Ptr


#DEFINE GTK_TYPE_AT_CONTEXT (gtk_at_context_get_type())

Type GtkATContext AS _GtkATContext
Declare Function gtk_at_context_get_accessible CDECL(BYVAL AS GtkATContext Ptr) AS GtkAccessible Ptr
Declare Function gtk_at_context_get_accessible_role CDECL(BYVAL AS GtkATContext Ptr) AS GtkAccessibleRole
Declare Function gtk_at_context_create CDECL(BYVAL AS GtkAccessibleRole, BYVAL AS GtkAccessible Ptr, BYVAL AS GdkDisplay Ptr) AS GtkATContext Ptr


#DEFINE GTK_TYPE_LAYOUT_CHILD (gtk_layout_child_get_type())
Type GtkLayoutChild AS _GtkLayoutChild
Type GtkLayoutChildClass AS _GtkLayoutChildClass

Type _GtkLayoutChildClass
	AS GObjectClass parent_class
End Type

Declare Function gtk_layout_child_get_layout_manager CDECL(BYVAL AS GtkLayoutChild Ptr) AS GtkLayoutManager Ptr
Declare Function gtk_layout_child_get_child_widget CDECL(BYVAL AS GtkLayoutChild Ptr) AS GtkWidget Ptr


#DEFINE GTK_TYPE_LAYOUT_MANAGER (gtk_layout_manager_get_type ())
Type GtkLayoutManager AS _GtkLayoutManager
Type GtkLayoutManagerClass AS _GtkLayoutManagerClass

Type _GtkLayoutManagerClass
	AS GObjectClass parent_class
	get_request_mode AS Function CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr) AS GtkSizeRequestMode
	measure AS SUB CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
	allocate_ AS SUB CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
	AS GType layout_child_type
	create_layout_child AS Function CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget) AS GtkLayoutChild Ptr
	root AS SUB CDECL(BYVAL AS GtkLayoutManager Ptr)
	unroot AS SUB CDECL(BYVAL AS GtkLayoutManager Ptr)
	AS gpointer _padding(0 TO 16-1)
End Type

Declare SUB gtk_layout_manager_measure CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_layout_manager_allocate CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_layout_manager_get_request_mode CDECL(BYVAL AS GtkLayoutManager Ptr) AS GtkSizeRequestMode
Declare Function gtk_layout_manager_get_widget CDECL(BYVAL AS GtkLayoutManager Ptr) AS GtkWidget Ptr
Declare SUB gtk_layout_manager_layout_changed CDECL(BYVAL AS GtkLayoutManager Ptr)
Declare Function gtk_layout_manager_get_layout_child CDECL(BYVAL AS GtkLayoutManager Ptr, BYVAL AS GtkWidget Ptr) AS GtkLayoutChild Ptr

#DEFINE GTK_TYPE_BIN_LAYOUT (gtk_bin_layout_get_type ())
Type GtkBinLayout AS _GtkBinLayout
Declare Function gtk_bin_layout_new CDECL() AS GtkLayoutManager Ptr


#DEFINE GTK_TYPE_BITSET (gtk_bitset_get_type ())

Declare Function gtk_bitset_get_type CDECL() AS GType
Declare Function gtk_bitset_ref CDECL(BYVAL AS GtkBitset Ptr) AS GtkBitset Ptr
Declare SUB gtk_bitset_unref CDECL(BYVAL AS GtkBitset Ptr)
Declare Function gtk_bitset_contains CDECL(BYVAL AS Const GtkBitset Ptr, BYVAL AS guint) AS gboolean
Declare Function gtk_bitset_is_empty CDECL(BYVAL AS Const GtkBitset Ptr) AS gboolean
Declare Function gtk_bitset_equals CDECL(BYVAL AS Const GtkBitset Ptr, BYVAL AS Const GtkBitset Ptr) AS gboolean
Declare Function gtk_bitset_get_size CDECL(BYVAL AS Const GtkBitset Ptr) AS guint64
Declare Function gtk_bitset_get_size_in_range CDECL(BYVAL AS Const GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint) AS guint64
Declare Function gtk_bitset_get_nth CDECL(BYVAL AS Const GtkBitset Ptr, BYVAL AS guint) AS guint
Declare Function gtk_bitset_get_minimum CDECL(BYVAL AS Const GtkBitset Ptr) AS guint
Declare Function gtk_bitset_get_maximum CDECL(BYVAL AS Const GtkBitset Ptr) AS guint
Declare Function gtk_bitset_new_empty CDECL() AS GtkBitset Ptr
Declare Function gtk_bitset_copy CDECL(BYVAL AS Const GtkBitset Ptr) AS GtkBitset Ptr
Declare Function gtk_bitset_new_range CDECL(BYVAL AS guint, BYVAL AS guint) AS GtkBitset Ptr
Declare SUB gtk_bitset_remove_all CDECL(BYVAL AS GtkBitset Ptr)
Declare Function gtk_bitset_add CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint) AS gboolean
Declare Function gtk_bitset_remove CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint) AS gboolean
Declare SUB gtk_bitset_add_range CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint)
Declare SUB gtk_bitset_remove_range CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint)
Declare SUB gtk_bitset_add_range_closed CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint)
Declare SUB gtk_bitset_remove_range_closed CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint)
Declare SUB gtk_bitset_add_rectangle CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint)
Declare SUB gtk_bitset_remove_rectangle CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint)
Declare SUB gtk_bitset_union CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS Const GtkBitset Ptr)
Declare SUB gtk_bitset_intersect CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS Const GtkBitset Ptr)
Declare SUB gtk_bitset_subtract CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS Const GtkBitset Ptr)
Declare SUB gtk_bitset_difference CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS Const GtkBitset Ptr)
Declare SUB gtk_bitset_shift_left CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint)
Declare SUB gtk_bitset_shift_right CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint)
Declare SUB gtk_bitset_splice CDECL(BYVAL AS GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS guint)

Type GtkBitsetIter AS _GtkBitsetIter

Type _GtkBitsetIter
	AS gpointer private_data(0 TO 10-1)
End Type

Declare Function gtk_bitset_iter_get_type CDECL() AS GType
Declare Function gtk_bitset_iter_init_first CDECL(BYVAL AS GtkBitsetIter Ptr, BYVAL AS Const GtkBitset Ptr, BYVAL AS guint Ptr) AS gboolean
Declare Function gtk_bitset_iter_init_last CDECL(BYVAL AS GtkBitsetIter Ptr, BYVAL AS Const GtkBitset Ptr, BYVAL AS guint Ptr) AS gboolean
Declare Function gtk_bitset_iter_init_at CDECL(BYVAL AS GtkBitsetIter Ptr, BYVAL AS Const GtkBitset Ptr, BYVAL AS guint, BYVAL AS guint Ptr) AS gboolean
Declare Function gtk_bitset_iter_next CDECL(BYVAL AS GtkBitsetIter Ptr, BYVAL AS guint Ptr) AS gboolean
Declare Function gtk_bitset_iter_previous CDECL(BYVAL AS GtkBitsetIter Ptr, BYVAL AS guint Ptr) AS gboolean
Declare Function gtk_bitset_iter_get_value CDECL(BYVAL AS Const GtkBitsetIter Ptr) AS guint
Declare Function gtk_bitset_iter_is_valid CDECL(BYVAL AS Const GtkBitsetIter Ptr) AS gboolean


#DEFINE GTK_TYPE_BOOKMARK_LIST (gtk_bookmark_list_get_type ())
Type GtkBookmarkList AS _GtkBookmarkList
Declare Function gtk_bookmark_list_new CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkBookmarkList Ptr
Declare Function gtk_bookmark_list_get_filename CDECL(BYVAL AS GtkBookmarkList Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_bookmark_list_set_attributes CDECL(BYVAL AS GtkBookmarkList Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_bookmark_list_get_attributes CDECL(BYVAL AS GtkBookmarkList Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_bookmark_list_set_io_priority CDECL(BYVAL AS GtkBookmarkList Ptr, BYVAL AS LONG)
Declare Function gtk_bookmark_list_get_io_priority CDECL(BYVAL AS GtkBookmarkList Ptr) AS LONG
Declare Function gtk_bookmark_list_is_loading CDECL(BYVAL AS GtkBookmarkList Ptr) AS gboolean


#DEFINE GTK_TYPE_EXPRESSION (gtk_expression_get_type ())
#DEFINE GTK_TYPE_EXPRESSION_WATCH (gtk_expression_watch_get_type())
#DEFINE GTK_IS_EXPRESSION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EXPRESSION))
#DEFINE GTK_EXPRESSION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EXPRESSION, GtkExpression))
Type GtkExpression AS _GtkExpression
Type GtkExpressionWatch AS _GtkExpressionWatch
Type GtkExpressionNotify AS SUB CDECL(BYVAL AS gpointer)
Declare Function gtk_expression_get_type CDECL() AS GType
Declare Function gtk_expression_ref CDECL(BYVAL AS GtkExpression Ptr) AS GtkExpression Ptr
Declare SUB gtk_expression_unref CDECL(BYVAL AS GtkExpression Ptr)
Declare Function gtk_expression_get_value_type CDECL(BYVAL AS GtkExpression Ptr) AS GType
Declare Function gtk_expression_is_static CDECL(BYVAL AS GtkExpression Ptr) AS gboolean
Declare Function gtk_expression_evaluate CDECL(BYVAL AS GtkExpression Ptr, BYVAL AS gpointer, BYVAL AS GValue Ptr) AS gboolean
Declare Function gtk_expression_watch CDECL(BYVAL AS GtkExpression Ptr, BYVAL AS gpointer, BYVAL AS GtkExpressionNotify, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GtkExpressionWatch Ptr
Declare Function gtk_expression_bind CDECL(BYVAL AS GtkExpression Ptr, BYVAL AS gpointer, BYVAL AS Const ZSTRING Ptr, BYVAL AS gpointer) AS GtkExpressionWatch Ptr
Declare Function gtk_expression_watch_get_type CDECL() AS GType
Declare Function gtk_expression_watch_ref CDECL(BYVAL AS GtkExpressionWatch Ptr) AS GtkExpressionWatch Ptr
Declare SUB gtk_expression_watch_unref CDECL(BYVAL AS GtkExpressionWatch Ptr)
Declare Function gtk_expression_watch_evaluate CDECL(BYVAL AS GtkExpressionWatch Ptr, BYVAL AS GValue Ptr) AS gboolean
Declare SUB gtk_expression_watch_unwatch CDECL(BYVAL AS GtkExpressionWatch Ptr)

#DEFINE GTK_TYPE_PROPERTY_EXPRESSION (gtk_property_expression_get_type())
Type GtkPropertyExpression AS _GtkPropertyExpression
Declare Function gtk_property_expression_get_type CDECL() AS GType
Declare Function gtk_property_expression_new CDECL(BYVAL AS GType, BYVAL AS GtkExpression Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkExpression Ptr
Declare Function gtk_property_expression_new_for_pspec CDECL(BYVAL AS GtkExpression Ptr, BYVAL AS GParamSpec Ptr) AS GtkExpression Ptr
Declare Function gtk_property_expression_get_expression CDECL(BYVAL AS GtkExpression Ptr) AS GtkExpression Ptr
Declare Function gtk_property_expression_get_pspec CDECL(BYVAL AS GtkExpression Ptr) AS GParamSpec Ptr

#DEFINE GTK_TYPE_CONSTANT_EXPRESSION (gtk_constant_expression_get_type())
Type GtkConstantExpression AS _GtkConstantExpression
Declare Function gtk_constant_expression_get_type CDECL() AS GType
Declare Function gtk_constant_expression_new CDECL(BYVAL AS GType, ...) AS GtkExpression Ptr
Declare Function gtk_constant_expression_new_for_value CDECL(BYVAL AS Const GValue Ptr) AS GtkExpression Ptr
Declare Function gtk_constant_expression_get_value CDECL(BYVAL AS GtkExpression Ptr) AS Const GValue Ptr

#DEFINE GTK_TYPE_OBJECT_EXPRESSION (gtk_object_expression_get_type())
Type GtkObjectExpression AS _GtkObjectExpression
Declare Function gtk_object_expression_get_type CDECL() AS GType
Declare Function gtk_object_expression_new CDECL(BYVAL AS GObject Ptr) AS GtkExpression Ptr
Declare Function gtk_object_expression_get_object CDECL(BYVAL AS GtkExpression Ptr) AS GObject Ptr

#DEFINE GTK_TYPE_CLOSURE_EXPRESSION (gtk_closure_expression_get_type())
Type GtkClosureExpression AS _GtkClosureExpression
Declare Function gtk_closure_expression_get_type CDECL() AS GType
Declare Function gtk_closure_expression_new CDECL(BYVAL AS GType, BYVAL AS GClosure Ptr, BYVAL AS guint, BYVAL AS GtkExpression Ptr Ptr) AS GtkExpression Ptr

#DEFINE GTK_TYPE_CCLOSURE_EXPRESSION (gtk_cclosure_expression_get_type())
Type GtkCClosureExpression AS _GtkCClosureExpression
Declare Function gtk_cclosure_expression_get_type CDECL() AS GType
Declare Function gtk_cclosure_expression_new CDECL(BYVAL AS GType, BYVAL AS GClosureMarshal, BYVAL AS guint, BYVAL AS GtkExpression Ptr Ptr, BYVAL AS GCallback, BYVAL AS gpointer, BYVAL AS GClosureNotify) AS GtkExpression Ptr

#DEFINE GTK_VALUE_HOLDS_EXPRESSION(value) (G_VALUE_HOLDS ((value), GTK_TYPE_EXPRESSION))
Declare SUB gtk_value_set_expression CDECL(BYVAL AS GValue Ptr, BYVAL AS GtkExpression Ptr)
Declare SUB gtk_value_take_expression CDECL(BYVAL AS GValue Ptr, BYVAL AS GtkExpression Ptr)
Declare Function gtk_value_get_expression CDECL(BYVAL AS Const GValue Ptr) AS GtkExpression Ptr
Declare Function gtk_value_dup_expression CDECL(BYVAL AS Const GValue Ptr) AS GtkExpression Ptr

#DEFINE GTK_TYPE_PARAM_SPEC_EXPRESSION (gtk_param_expression_get_type())
#DEFINE GTK_IS_PARAM_SPEC_EXPRESSION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PARAM_SPEC_EXPRESSION))
Type GtkParamSpecExpression
	AS GParamSpec parent_instance
End Type
Declare Function gtk_param_expression_get_type CDECL() AS GType
Declare Function gtk_param_spec_expression CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GParamFlags) AS GParamSpec Ptr


Enum GtkFilterMatch_
	GTK_FILTER_MATCH_SOME = 0
	GTK_FILTER_MATCH_NONE
	GTK_FILTER_MATCH_ALL
End Enum
Type AS LONG GtkFilterMatch

Enum GtkFilterChange_
	GTK_FILTER_CHANGE_DIFFERENT = 0
	GTK_FILTER_CHANGE_LESS_STRICT
	GTK_FILTER_CHANGE_MORE_STRICT
End Enum
Type AS LONG GtkFilterChange

#DEFINE GTK_TYPE_FILTER (gtk_filter_get_type ())

Type GtkFilter AS _GtkFilter
Type GtkFilterClass AS _GtkFilterClass
Type _GtkFilterClass
	AS GObjectClass parent_class
	match AS Function CDECL(BYVAL AS GtkFilter Ptr, BYVAL AS gpointer) AS gboolean
	get_strictness AS Function CDECL(BYVAL AS GtkFilter Ptr) AS GtkFilterMatch
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
	_gtk_reserved5 AS SUB CDECL()
	_gtk_reserved6 AS SUB CDECL()
	_gtk_reserved7 AS SUB CDECL()
	_gtk_reserved8 AS SUB CDECL()
End Type

Declare Function gtk_filter_match CDECL(BYVAL AS GtkFilter Ptr, BYVAL AS gpointer) AS gboolean
Declare Function gtk_filter_get_strictness CDECL(BYVAL AS GtkFilter Ptr) AS GtkFilterMatch
Declare SUB gtk_filter_changed CDECL(BYVAL AS GtkFilter Ptr, BYVAL AS GtkFilterChange)


#DEFINE GTK_TYPE_BOOL_FILTER (gtk_bool_filter_get_type ())
Type GtkBoolFilter AS _GtkBoolFilter
Declare Function gtk_bool_filter_new CDECL(BYVAL AS GtkExpression Ptr) AS GtkBoolFilter Ptr
Declare Function gtk_bool_filter_get_expression CDECL(BYVAL AS GtkBoolFilter Ptr) AS GtkExpression Ptr
Declare SUB gtk_bool_filter_set_expression CDECL(BYVAL AS GtkBoolFilter Ptr, BYVAL AS GtkExpression Ptr)
Declare Function gtk_bool_filter_get_invert CDECL(BYVAL AS GtkBoolFilter Ptr) AS gboolean
Declare SUB gtk_bool_filter_set_invert CDECL(BYVAL AS GtkBoolFilter Ptr, BYVAL AS gboolean)


Type GtkBorder AS _GtkBorder
#DEFINE GTK_TYPE_BORDER (gtk_border_get_type ())
Type _GtkBorder
	AS gint16 left
	AS gint16 right
	AS gint16 top
	AS gint16 bottom
End Type
Declare Function gtk_border_get_type CDECL() AS GType
Declare Function gtk_border_new CDECL() AS GtkBorder Ptr
Declare Function gtk_border_copy CDECL(BYVAL AS Const GtkBorder Ptr) AS GtkBorder Ptr
Declare SUB gtk_border_free CDECL(BYVAL AS GtkBorder Ptr)


#DEFINE GTK_TYPE_BOX_LAYOUT (gtk_box_layout_get_type())
Type GtkBoxLayout AS _GtkBoxLayout
Declare Function gtk_box_layout_new CDECL(BYVAL AS GtkOrientation) AS GtkLayoutManager Ptr
Declare SUB gtk_box_layout_set_homogeneous CDECL(BYVAL AS GtkBoxLayout Ptr, BYVAL AS gboolean)
Declare Function gtk_box_layout_get_homogeneous CDECL(BYVAL AS GtkBoxLayout Ptr) AS gboolean
Declare SUB gtk_box_layout_set_spacing CDECL(BYVAL AS GtkBoxLayout Ptr, BYVAL AS guint)
Declare Function gtk_box_layout_get_spacing CDECL(BYVAL AS GtkBoxLayout Ptr) AS guint
Declare SUB gtk_box_layout_set_baseline_position CDECL(BYVAL AS GtkBoxLayout Ptr, BYVAL AS GtkBaselinePosition)
Declare Function gtk_box_layout_get_baseline_position CDECL(BYVAL AS GtkBoxLayout Ptr) AS GtkBaselinePosition
Declare SUB gtk_box_layout_set_baseline_child CDECL(BYVAL AS GtkBoxLayout Ptr, BYVAL AS LONG)
Declare Function gtk_box_layout_get_baseline_child CDECL(BYVAL AS GtkBoxLayout Ptr) AS LONG


#DEFINE GTK_TYPE_BOX (gtk_box_get_type ())
#DEFINE GTK_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BOX, GtkBox))
#DEFINE GTK_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BOX, GtkBoxClass))
#DEFINE GTK_IS_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BOX))
#DEFINE GTK_IS_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BOX))
#DEFINE GTK_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BOX, GtkBoxClass))

Type GtkBox AS _GtkBox
Type GtkBoxClass AS _GtkBoxClass

Type _GtkBox
	AS GtkWidget parent_instance
End Type

Type _GtkBoxClass
	AS GtkWidgetClass parent_class
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_box_get_type CDECL() AS GType
Declare Function gtk_box_new CDECL(BYVAL AS GtkOrientation, BYVAL AS LONG) AS GtkWidget Ptr
Declare SUB gtk_box_set_homogeneous CDECL(BYVAL AS GtkBox Ptr, BYVAL AS gboolean)
Declare Function gtk_box_get_homogeneous CDECL(BYVAL AS GtkBox Ptr) AS gboolean
Declare SUB gtk_box_set_spacing CDECL(BYVAL AS GtkBox Ptr, BYVAL AS LONG)
Declare Function gtk_box_get_spacing CDECL(BYVAL AS GtkBox Ptr) AS LONG
Declare SUB gtk_box_set_baseline_position CDECL(BYVAL AS GtkBox Ptr, BYVAL AS GtkBaselinePosition)
Declare Function gtk_box_get_baseline_position CDECL(BYVAL AS GtkBox Ptr) AS GtkBaselinePosition
Declare SUB gtk_box_set_baseline_child CDECL(BYVAL AS GtkBox Ptr, BYVAL AS LONG)
Declare Function gtk_box_get_baseline_child CDECL(BYVAL AS GtkBox Ptr) AS LONG
Declare SUB gtk_box_append CDECL(BYVAL AS GtkBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_box_prepend CDECL(BYVAL AS GtkBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_box_remove CDECL(BYVAL AS GtkBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_box_insert_child_after CDECL(BYVAL AS GtkBox Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget)
Declare SUB gtk_box_reorder_child_after CDECL(BYVAL AS GtkBox Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget)

#DEFINE GTK_TYPE_BUILDER_SCOPE (gtk_builder_scope_get_type ())
Type GtkBuilderScope AS _GtkBuilderScope
Enum GtkBuilderClosureFlags_
	GTK_BUILDER_CLOSURE_SWAPPED = (1  SHL 0)
End Enum
Type AS LONG GtkBuilderClosureFlags

Type _GtkBuilderScopeInterface
	AS GTypeInterface g_iface
	get_type_from_name AS Function CDECL(BYVAL AS GtkBuilderScope Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr) AS GType
	get_type_from_function AS Function CDECL(BYVAL AS GtkBuilderScope Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr) AS GType
	create_closure AS Function CDECL(BYVAL AS GtkBuilderScope Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkBuilderClosureFlags, BYVAL AS GObject Ptr, BYVAL AS GError Ptr Ptr) AS GClosure Ptr
End Type

Type _GtkBuilderCScopeClass
	AS GObjectClass parent_class
End Type

#DEFINE GTK_TYPE_BUILDER_CSCOPE (gtk_builder_cscope_get_type ())
Type GtkBuilderCScope AS _GtkBuilderCScope
Type GtkBuilderCScopeClass AS _GtkBuilderCScopeClass
Declare Function gtk_builder_cscope_new CDECL() AS GtkBuilderScope Ptr
Declare SUB gtk_builder_cscope_add_callback_symbol CDECL(BYVAL AS GtkBuilderCScope Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GCallback)
Declare SUB gtk_builder_cscope_add_callback_symbols CDECL(BYVAL AS GtkBuilderCScope Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GCallback, ...)

#DEFINE gtk_builder_cscope_add_callback(scope, callback) _
  gtk_builder_cscope_add_callback_symbol (GTK_BUILDER_CSCOPE (scope), #callback, G_CALLBACK (callback))
Declare Function gtk_builder_cscope_lookup_callback_symbol CDECL(BYVAL AS GtkBuilderCScope Ptr, BYVAL AS Const ZSTRING Ptr) AS GCallback

#DEFINE GTK_TYPE_BUILDER (gtk_builder_get_type ())
#DEFINE GTK_BUILDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUILDER, GtkBuilder))
#DEFINE GTK_BUILDER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BUILDER, GtkBuilderClass))
#DEFINE GTK_IS_BUILDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUILDER))
#DEFINE GTK_IS_BUILDER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BUILDER))
#DEFINE GTK_BUILDER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BUILDER, GtkBuilderClass))
#DEFINE GTK_BUILDER_ERROR (gtk_builder_error_quark ())

Type GtkBuilderClass AS _GtkBuilderClass

Enum GtkBuilderError_
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
	GTK_BUILDER_ERROR_INVALID_ID
	GTK_BUILDER_ERROR_INVALID_FUNCTION
End Enum
Type AS LONG GtkBuilderError

Declare Function gtk_builder_error_quark CDECL() AS GQuark
Declare Function gtk_builder_get_type CDECL() AS GType
Declare Function gtk_builder_new CDECL() AS GtkBuilder Ptr
Declare Function gtk_builder_add_from_file CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_add_from_resource CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_add_from_string CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gssize, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_add_objects_from_file CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_add_objects_from_resource CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_add_objects_from_string CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gssize, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_get_object CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr) AS GObject Ptr
Declare Function gtk_builder_get_objects CDECL(BYVAL AS GtkBuilder Ptr) AS GSList Ptr
Declare SUB gtk_builder_expose_object CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GObject Ptr)
Declare Function gtk_builder_get_current_object CDECL(BYVAL AS GtkBuilder Ptr) AS GObject Ptr
Declare SUB gtk_builder_set_current_object CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS GObject Ptr)
Declare SUB gtk_builder_set_translation_domain CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_builder_get_translation_domain CDECL(BYVAL AS GtkBuilder Ptr) AS Const ZSTRING Ptr
Declare Function gtk_builder_get_scope CDECL(BYVAL AS GtkBuilder Ptr) AS GtkBuilderScope Ptr
Declare SUB gtk_builder_set_scope CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS GtkBuilderScope Ptr)
Declare Function gtk_builder_get_type_from_name CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr) AS GType
Declare Function gtk_builder_value_from_string CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS GParamSpec Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GValue Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_value_from_string_type CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS GType, BYVAL AS Const ZSTRING Ptr, BYVAL AS GValue Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_builder_new_from_file CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkBuilder Ptr
Declare Function gtk_builder_new_from_resource CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkBuilder Ptr
Declare Function gtk_builder_new_from_string CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS gssize) AS GtkBuilder Ptr
Declare Function gtk_builder_create_closure CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkBuilderClosureFlags, BYVAL AS GObject Ptr, BYVAL AS GError Ptr Ptr) AS GClosure Ptr

#DEFINE GTK_BUILDER_WARN_INVALID_CHILD_TYPE(object, type) _
  g_warning (@!"'%s' is not a valid child type of '%s'", type, g_type_name (G_OBJECT_TYPE (object)))

Declare Function gtk_builder_extend_with_template CDECL(BYVAL AS GtkBuilder Ptr, BYVAL AS GObject Ptr, BYVAL AS GType, BYVAL AS Const ZSTRING Ptr, BYVAL AS gssize, BYVAL AS GError Ptr Ptr) AS gboolean

#DEFINE GTK_TYPE_BUILDABLE (gtk_buildable_get_type ())
#DEFINE GTK_BUILDABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUILDABLE, GtkBuildable))
#DEFINE GTK_IS_BUILDABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUILDABLE))
#DEFINE GTK_BUILDABLE_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_BUILDABLE, GtkBuildableIface))
Type GtkBuildable AS _GtkBuildable
Type GtkBuildableIface AS _GtkBuildableIface
Type GtkBuildableParseContext AS _GtkBuildableParseContext
Type GtkBuildableParser AS _GtkBuildableParser
Type _GtkBuildableParser
	start_element AS SUB CDECL(BYVAL AS GtkBuildableParseContext Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS gpointer, BYVAL AS GError Ptr Ptr)
	end_element AS SUB CDECL(BYVAL AS GtkBuildableParseContext Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gpointer, BYVAL AS GError Ptr Ptr)
	text AS SUB CDECL(BYVAL AS GtkBuildableParseContext Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gsize, BYVAL AS gpointer, BYVAL AS GError Ptr Ptr)
	error_ AS SUB CDECL(BYVAL AS GtkBuildableParseContext Ptr, BYVAL AS GError Ptr, BYVAL AS gpointer)
	AS gpointer padding(0 TO 4-1)
End Type

Type _GtkBuildableIface
	AS GTypeInterface g_iface
	set_id AS SUB CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS Const ZSTRING Ptr)
	get_id AS Function CDECL(BYVAL AS GtkBuildable Ptr) AS Const ZSTRING Ptr
	add_child AS SUB CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS GObject Ptr, BYVAL AS Const ZSTRING Ptr)
	set_buildable_property AS SUB CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GValue Ptr)
	construct_child AS Function CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr) AS GObject Ptr
	custom_tag_start AS Function CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS GObject Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkBuildableParser Ptr, BYVAL AS gpointer Ptr) AS gboolean
	custom_tag_end AS SUB CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS GObject Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gpointer)
	custom_finished AS SUB CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS GObject Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gpointer)
	parser_finished AS SUB CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr)
	get_internal_child AS Function CDECL(BYVAL AS GtkBuildable Ptr, BYVAL AS GtkBuilder Ptr, BYVAL AS Const ZSTRING Ptr) AS GObject Ptr
End Type

Declare Function gtk_buildable_get_type CDECL() AS GType
Declare Function gtk_buildable_get_buildable_id CDECL(BYVAL AS GtkBuildable Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_buildable_parse_context_push CDECL(BYVAL AS GtkBuildableParseContext Ptr, BYVAL AS Const GtkBuildableParser Ptr, BYVAL AS gpointer)
Declare Function gtk_buildable_parse_context_pop CDECL(BYVAL AS GtkBuildableParseContext Ptr) AS gpointer
Declare Function gtk_buildable_parse_context_get_element CDECL(BYVAL AS GtkBuildableParseContext Ptr) AS Const ZSTRING Ptr
Declare Function gtk_buildable_parse_context_get_element_stack CDECL(BYVAL AS GtkBuildableParseContext Ptr) AS GPtrArray Ptr
Declare SUB gtk_buildable_parse_context_get_position CDECL(BYVAL AS GtkBuildableParseContext Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)

Type GtkListItemFactoryClass AS _GtkListItemFactoryClass
#DEFINE GTK_TYPE_LIST_ITEM_FACTORY (gtk_list_item_factory_get_type ())
#DEFINE GTK_LIST_ITEM_FACTORY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_LIST_ITEM_FACTORY, GtkListItemFactory))
#DEFINE GTK_LIST_ITEM_FACTORY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_LIST_ITEM_FACTORY, GtkListItemFactoryClass))
#DEFINE GTK_IS_LIST_ITEM_FACTORY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_LIST_ITEM_FACTORY))
#DEFINE GTK_IS_LIST_ITEM_FACTORY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_LIST_ITEM_FACTORY))
#DEFINE GTK_LIST_ITEM_FACTORY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_LIST_ITEM_FACTORY, GtkListItemFactoryClass))
Declare Function gtk_list_item_factory_get_type CDECL() AS GType
#DEFINE GTK_TYPE_BUILDER_LIST_ITEM_FACTORY (gtk_builder_list_item_factory_get_type ())
#DEFINE GTK_BUILDER_LIST_ITEM_FACTORY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_BUILDER_LIST_ITEM_FACTORY, GtkBuilderListItemFactory))
#DEFINE GTK_BUILDER_LIST_ITEM_FACTORY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_BUILDER_LIST_ITEM_FACTORY, GtkBuilderListItemFactoryClass))
#DEFINE GTK_IS_BUILDER_LIST_ITEM_FACTORY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_BUILDER_LIST_ITEM_FACTORY))
#DEFINE GTK_IS_BUILDER_LIST_ITEM_FACTORY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_BUILDER_LIST_ITEM_FACTORY))
#DEFINE GTK_BUILDER_LIST_ITEM_FACTORY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_BUILDER_LIST_ITEM_FACTORY, GtkBuilderListItemFactoryClass))
Type GtkBuilderListItemFactory AS _GtkBuilderListItemFactory
Type GtkBuilderListItemFactoryClass AS _GtkBuilderListItemFactoryClass
Declare Function gtk_builder_list_item_factory_get_type CDECL() AS GType
Declare Function gtk_builder_list_item_factory_new_from_bytes CDECL(BYVAL AS GtkBuilderScope Ptr, BYVAL AS GBytes Ptr) AS GtkListItemFactory Ptr
Declare Function gtk_builder_list_item_factory_new_from_resource CDECL(BYVAL AS GtkBuilderScope Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkListItemFactory Ptr
Declare Function gtk_builder_list_item_factory_get_bytes CDECL(BYVAL AS GtkBuilderListItemFactory Ptr) AS GBytes Ptr
Declare Function gtk_builder_list_item_factory_get_resource CDECL(BYVAL AS GtkBuilderListItemFactory Ptr) AS Const ZSTRING Ptr
Declare Function gtk_builder_list_item_factory_get_scope CDECL(BYVAL AS GtkBuilderListItemFactory Ptr) AS GtkBuilderScope Ptr

#DEFINE GTK_TYPE_BUTTON (gtk_button_get_type ())
#DEFINE GTK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_BUTTON, GtkButton))
#DEFINE GTK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_BUTTON, GtkButtonClass))
#DEFINE GTK_IS_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_BUTTON))
#DEFINE GTK_IS_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_BUTTON))
#DEFINE GTK_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_BUTTON, GtkButtonClass))

Type GtkButton AS _GtkButton
Type GtkButtonPrivate AS _GtkButtonPrivate
Type GtkButtonClass AS _GtkButtonClass

Type _GtkButton
	AS GtkWidget parent_instance
End Type

Type _GtkButtonClass
	AS GtkWidgetClass parent_class
	clicked AS SUB CDECL(BYVAL AS GtkButton Ptr)
	activate AS SUB CDECL(BYVAL AS GtkButton Ptr)
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_button_get_type CDECL() AS GType
Declare Function gtk_button_new CDECL() AS GtkWidget Ptr
Declare Function gtk_button_new_with_label CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_button_new_from_icon_name CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_button_new_with_mnemonic CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_button_set_has_frame CDECL(BYVAL AS GtkButton Ptr, BYVAL AS gboolean)
Declare Function gtk_button_get_has_frame CDECL(BYVAL AS GtkButton Ptr) AS gboolean
Declare SUB gtk_button_set_label CDECL(BYVAL AS GtkButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_button_get_label CDECL(BYVAL AS GtkButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_button_set_use_underline CDECL(BYVAL AS GtkButton Ptr, BYVAL AS gboolean)
Declare Function gtk_button_get_use_underline CDECL(BYVAL AS GtkButton Ptr) AS gboolean
Declare SUB gtk_button_set_icon_name CDECL(BYVAL AS GtkButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_button_get_icon_name CDECL(BYVAL AS GtkButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_button_set_child CDECL(BYVAL AS GtkButton Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_button_get_child CDECL(BYVAL AS GtkButton Ptr) AS GtkWidget Ptr
Declare SUB gtk_button_set_can_shrink CDECL(BYVAL AS GtkButton Ptr, BYVAL AS gboolean)
Declare Function gtk_button_get_can_shrink CDECL(BYVAL AS GtkButton Ptr) AS gboolean


#DEFINE GTK_TYPE_CALENDAR (gtk_calendar_get_type ())
#DEFINE GTK_CALENDAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CALENDAR, GtkCalendar))
#DEFINE GTK_IS_CALENDAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CALENDAR))

Type GtkCalendar AS _GtkCalendar

Declare Function gtk_calendar_get_type CDECL() AS GType
Declare Function gtk_calendar_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_calendar_select_day CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS GDateTime Ptr)
Declare SUB gtk_calendar_mark_day CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS guint)
Declare SUB gtk_calendar_unmark_day CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS guint)
Declare SUB gtk_calendar_clear_marks CDECL(BYVAL AS GtkCalendar Ptr)
Declare SUB gtk_calendar_set_show_week_numbers CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS gboolean)
Declare Function gtk_calendar_get_show_week_numbers CDECL(BYVAL AS GtkCalendar Ptr) AS gboolean
Declare SUB gtk_calendar_set_show_heading CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS gboolean)
Declare Function gtk_calendar_get_show_heading CDECL(BYVAL AS GtkCalendar Ptr) AS gboolean
Declare SUB gtk_calendar_set_show_day_names CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS gboolean)
Declare Function gtk_calendar_get_show_day_names CDECL(BYVAL AS GtkCalendar Ptr) AS gboolean
Declare SUB gtk_calendar_set_day CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS LONG)
Declare Function gtk_calendar_get_day CDECL(BYVAL AS GtkCalendar Ptr) AS LONG
Declare SUB gtk_calendar_set_month CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS LONG)
Declare Function gtk_calendar_get_month CDECL(BYVAL AS GtkCalendar Ptr) AS LONG
Declare SUB gtk_calendar_set_year CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS LONG)
Declare Function gtk_calendar_get_year CDECL(BYVAL AS GtkCalendar Ptr) AS LONG
Declare Function gtk_calendar_get_date CDECL(BYVAL AS GtkCalendar Ptr) AS GDateTime Ptr
Declare Function gtk_calendar_get_day_is_marked CDECL(BYVAL AS GtkCalendar Ptr, BYVAL AS guint) AS gboolean

#DEFINE GTK_TYPE_CENTER_BOX (gtk_center_box_get_type ())
#DEFINE GTK_CENTER_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CENTER_BOX, GtkCenterBox))
#DEFINE GTK_CENTER_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CENTER_BOX, GtkCenterBoxClass))
#DEFINE GTK_IS_CENTER_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CENTER_BOX))
#DEFINE GTK_IS_CENTER_BOX_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CENTER_BOX))
#DEFINE GTK_CENTER_BOX_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CENTER_BOX, GtkCenterBoxClass))

Type GtkCenterBox AS _GtkCenterBox
Type GtkCenterBoxClass AS _GtkCenterBoxClass

Declare Function gtk_center_box_get_type CDECL() AS GType
Declare Function gtk_center_box_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_center_box_set_start_widget CDECL(BYVAL AS GtkCenterBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_center_box_set_center_widget CDECL(BYVAL AS GtkCenterBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_center_box_set_end_widget CDECL(BYVAL AS GtkCenterBox Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_center_box_get_start_widget CDECL(BYVAL AS GtkCenterBox Ptr) AS GtkWidget Ptr
Declare Function gtk_center_box_get_center_widget CDECL(BYVAL AS GtkCenterBox Ptr) AS GtkWidget Ptr
Declare Function gtk_center_box_get_end_widget CDECL(BYVAL AS GtkCenterBox Ptr) AS GtkWidget Ptr
Declare SUB gtk_center_box_set_baseline_position CDECL(BYVAL AS GtkCenterBox Ptr, BYVAL AS GtkBaselinePosition)
Declare Function gtk_center_box_get_baseline_position CDECL(BYVAL AS GtkCenterBox Ptr) AS GtkBaselinePosition
Declare SUB gtk_center_box_set_shrink_center_last CDECL(BYVAL AS GtkCenterBox Ptr, BYVAL AS gboolean)
Declare Function gtk_center_box_get_shrink_center_last CDECL(BYVAL AS GtkCenterBox Ptr) AS gboolean


#DEFINE GTK_TYPE_CENTER_LAYOUT (gtk_center_layout_get_type ())

Type GtkCenterLayout AS _GtkCenterLayout
Declare Function gtk_center_layout_new CDECL() AS GtkLayoutManager Ptr
Declare SUB gtk_center_layout_set_orientation CDECL(BYVAL AS GtkCenterLayout Ptr, BYVAL AS GtkOrientation)
Declare Function gtk_center_layout_get_orientation CDECL(BYVAL AS GtkCenterLayout Ptr) AS GtkOrientation
Declare SUB gtk_center_layout_set_baseline_position CDECL(BYVAL AS GtkCenterLayout Ptr, BYVAL AS GtkBaselinePosition)
Declare Function gtk_center_layout_get_baseline_position CDECL(BYVAL AS GtkCenterLayout Ptr) AS GtkBaselinePosition
Declare SUB gtk_center_layout_set_start_widget CDECL(BYVAL AS GtkCenterLayout Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_center_layout_get_start_widget CDECL(BYVAL AS GtkCenterLayout Ptr) AS GtkWidget Ptr
Declare SUB gtk_center_layout_set_center_widget CDECL(BYVAL AS GtkCenterLayout Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_center_layout_get_center_widget CDECL(BYVAL AS GtkCenterLayout Ptr) AS GtkWidget Ptr
Declare SUB gtk_center_layout_set_end_widget CDECL(BYVAL AS GtkCenterLayout Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_center_layout_get_end_widget CDECL(BYVAL AS GtkCenterLayout Ptr) AS GtkWidget Ptr
Declare SUB gtk_center_layout_set_shrink_center_last CDECL(BYVAL AS GtkCenterLayout Ptr, BYVAL AS gboolean)
Declare Function gtk_center_layout_get_shrink_center_last CDECL(BYVAL AS GtkCenterLayout Ptr) AS gboolean


#DEFINE GTK_TYPE_TOGGLE_BUTTON (gtk_toggle_button_get_type ())
#DEFINE GTK_TOGGLE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButton))
#DEFINE GTK_TOGGLE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass))
#DEFINE GTK_IS_TOGGLE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOGGLE_BUTTON))
#DEFINE GTK_IS_TOGGLE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TOGGLE_BUTTON))
#DEFINE GTK_TOGGLE_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TOGGLE_BUTTON, GtkToggleButtonClass))

Type GtkToggleButton AS _GtkToggleButton
Type GtkToggleButtonClass AS _GtkToggleButtonClass

Type _GtkToggleButton
	AS GtkButton button
End Type

Type _GtkToggleButtonClass
	AS GtkButtonClass parent_class
	toggled AS SUB CDECL(BYVAL AS GtkToggleButton Ptr)
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_toggle_button_get_type CDECL() AS GType
Declare Function gtk_toggle_button_new CDECL() AS GtkWidget Ptr
Declare Function gtk_toggle_button_new_with_label CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_toggle_button_new_with_mnemonic CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_toggle_button_set_active CDECL(BYVAL AS GtkToggleButton Ptr, BYVAL AS gboolean)
Declare Function gtk_toggle_button_get_active CDECL(BYVAL AS GtkToggleButton Ptr) AS gboolean
Declare SUB gtk_toggle_button_set_group CDECL(BYVAL AS GtkToggleButton Ptr, BYVAL AS GtkToggleButton Ptr)


#DEFINE GTK_TYPE_CHECK_BUTTON (gtk_check_button_get_type ())
#DEFINE GTK_CHECK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_CHECK_BUTTON, GtkCheckButton))
#DEFINE GTK_CHECK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_CHECK_BUTTON, GtkCheckButtonClass))
#DEFINE GTK_IS_CHECK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_CHECK_BUTTON))
#DEFINE GTK_IS_CHECK_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_CHECK_BUTTON))
#DEFINE GTK_CHECK_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_CHECK_BUTTON, GtkCheckButtonClass))

Type GtkCheckButton AS _GtkCheckButton
Type GtkCheckButtonClass AS _GtkCheckButtonClass

Type _GtkCheckButton
	AS GtkWidget parent_instance
End Type

Type _GtkCheckButtonClass
	AS GtkWidgetClass parent_class
	toggled AS SUB CDECL(BYVAL AS GtkCheckButton Ptr)
	activate AS SUB CDECL(BYVAL AS GtkCheckButton Ptr)
	AS gpointer padding(0 TO 7-1)
End Type

Declare Function gtk_check_button_get_type CDECL() AS GType
Declare Function gtk_check_button_new CDECL() AS GtkWidget Ptr
Declare Function gtk_check_button_new_with_label CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_check_button_new_with_mnemonic CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_check_button_set_inconsistent CDECL(BYVAL AS GtkCheckButton Ptr, BYVAL AS gboolean)
Declare Function gtk_check_button_get_inconsistent CDECL(BYVAL AS GtkCheckButton Ptr) AS gboolean
Declare Function gtk_check_button_get_active CDECL(BYVAL AS GtkCheckButton Ptr) AS gboolean
Declare SUB gtk_check_button_set_active CDECL(BYVAL AS GtkCheckButton Ptr, BYVAL AS gboolean)
Declare Function gtk_check_button_get_label CDECL(BYVAL AS GtkCheckButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_check_button_set_label CDECL(BYVAL AS GtkCheckButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_check_button_set_group CDECL(BYVAL AS GtkCheckButton Ptr, BYVAL AS GtkCheckButton Ptr)
Declare Function gtk_check_button_get_use_underline CDECL(BYVAL AS GtkCheckButton Ptr) AS gboolean
Declare SUB gtk_check_button_set_use_underline CDECL(BYVAL AS GtkCheckButton Ptr, BYVAL AS gboolean)
Declare Function gtk_check_button_get_child CDECL(BYVAL AS GtkCheckButton Ptr) AS GtkWidget Ptr
Declare SUB gtk_check_button_set_child CDECL(BYVAL AS GtkCheckButton Ptr, BYVAL AS GtkWidget Ptr)

#DEFINE GTK_TYPE_COLOR_DIALOG (gtk_color_dialog_get_type ())

Type GtkColorDialog AS _GtkColorDialog
Declare Function gtk_color_dialog_new CDECL() AS GtkColorDialog Ptr
Declare Function gtk_color_dialog_get_title CDECL(BYVAL AS GtkColorDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_color_dialog_set_title CDECL(BYVAL AS GtkColorDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_color_dialog_get_modal CDECL(BYVAL AS GtkColorDialog Ptr) AS gboolean
Declare SUB gtk_color_dialog_set_modal CDECL(BYVAL AS GtkColorDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_color_dialog_get_with_alpha CDECL(BYVAL AS GtkColorDialog Ptr) AS gboolean
Declare SUB gtk_color_dialog_set_with_alpha CDECL(BYVAL AS GtkColorDialog Ptr, BYVAL AS gboolean)
Declare SUB gtk_color_dialog_choose_rgba CDECL(BYVAL AS GtkColorDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS Const GdkRGBA Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_color_dialog_choose_rgba_finish CDECL(BYVAL AS GtkColorDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GdkRGBA Ptr

#DEFINE GTK_TYPE_COLOR_DIALOG_BUTTON (gtk_color_dialog_button_get_type ())

Type GtkColorDialogButton AS _GtkColorDialogButton
Declare Function gtk_color_dialog_button_new CDECL(BYVAL AS GtkColorDialog Ptr) AS GtkWidget Ptr
Declare Function gtk_color_dialog_button_get_dialog CDECL(BYVAL AS GtkColorDialogButton Ptr) AS GtkColorDialog Ptr
Declare SUB gtk_color_dialog_button_set_dialog CDECL(BYVAL AS GtkColorDialogButton Ptr, BYVAL AS GtkColorDialog Ptr)
Declare Function gtk_color_dialog_button_get_rgba CDECL(BYVAL AS GtkColorDialogButton Ptr) AS Const GdkRGBA Ptr
Declare SUB gtk_color_dialog_button_set_rgba CDECL(BYVAL AS GtkColorDialogButton Ptr, BYVAL AS Const GdkRGBA Ptr)

Declare SUB gtk_hsv_to_rgb CDECL(BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE Ptr, BYVAL AS SINGLE Ptr, BYVAL AS SINGLE Ptr)
Declare SUB gtk_rgb_to_hsv CDECL(BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE Ptr, BYVAL AS SINGLE Ptr, BYVAL AS SINGLE Ptr)


Enum GtkSorterOrder_
	GTK_SORTER_ORDER_PARTIAL
	GTK_SORTER_ORDER_NONE
	GTK_SORTER_ORDER_TOTAL
End Enum
Type AS LONG GtkSorterOrder

Enum GtkSorterChange_
	GTK_SORTER_CHANGE_DIFFERENT
	GTK_SORTER_CHANGE_INVERTED
	GTK_SORTER_CHANGE_LESS_STRICT
	GTK_SORTER_CHANGE_MORE_STRICT
End Enum
Type AS LONG GtkSorterChange

#DEFINE GTK_TYPE_SORTER (gtk_sorter_get_type ())

Type GtkSorter AS _GtkSorter
Type GtkSorterClass AS _GtkSorterClass

Type _GtkSorterClass
	AS GObjectClass parent_class
	compare AS Function CDECL(BYVAL AS GtkSorter Ptr, BYVAL AS gpointer, BYVAL AS gpointer) AS GtkOrdering
	get_order AS Function CDECL(BYVAL AS GtkSorter Ptr) AS GtkSorterOrder
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
	_gtk_reserved5 AS SUB CDECL()
	_gtk_reserved6 AS SUB CDECL()
	_gtk_reserved7 AS SUB CDECL()
	_gtk_reserved8 AS SUB CDECL()
End Type

Declare Function gtk_sorter_compare CDECL(BYVAL AS GtkSorter Ptr, BYVAL AS gpointer, BYVAL AS gpointer) AS GtkOrdering
Declare Function gtk_sorter_get_order CDECL(BYVAL AS GtkSorter Ptr) AS GtkSorterOrder
Declare SUB gtk_sorter_changed CDECL(BYVAL AS GtkSorter Ptr, BYVAL AS GtkSorterChange)


#DEFINE GTK_TYPE_SORT_LIST_MODEL (gtk_sort_list_model_get_type ())
Type GtkSortListModel AS _GtkSortListModel
Declare Function gtk_sort_list_model_new CDECL(BYVAL AS GListModel Ptr, BYVAL AS GtkSorter Ptr) AS GtkSortListModel Ptr
Declare SUB gtk_sort_list_model_set_sorter CDECL(BYVAL AS GtkSortListModel Ptr, BYVAL AS GtkSorter Ptr)
Declare Function gtk_sort_list_model_get_sorter CDECL(BYVAL AS GtkSortListModel Ptr) AS GtkSorter Ptr
Declare SUB gtk_sort_list_model_set_section_sorter CDECL(BYVAL AS GtkSortListModel Ptr, BYVAL AS GtkSorter Ptr)
Declare Function gtk_sort_list_model_get_section_sorter CDECL(BYVAL AS GtkSortListModel Ptr) AS GtkSorter Ptr
Declare SUB gtk_sort_list_model_set_model CDECL(BYVAL AS GtkSortListModel Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_sort_list_model_get_model CDECL(BYVAL AS GtkSortListModel Ptr) AS GListModel Ptr
Declare SUB gtk_sort_list_model_set_incremental CDECL(BYVAL AS GtkSortListModel Ptr, BYVAL AS gboolean)
Declare Function gtk_sort_list_model_get_incremental CDECL(BYVAL AS GtkSortListModel Ptr) AS gboolean
Declare Function gtk_sort_list_model_get_pending CDECL(BYVAL AS GtkSortListModel Ptr) AS guint


#DEFINE GTK_TYPE_SELECTION_MODEL (gtk_selection_model_get_type ())

Type GtkSelectionModel AS _GtkSelectionModel

Type _GtkSelectionModelInterface
	AS GTypeInterface g_iface
	is_selected AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint) AS gboolean
	get_selection_in_range AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint) AS GtkBitset Ptr
	select_item AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS gboolean) AS gboolean
	unselect_item AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint) AS gboolean
	select_range AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS gboolean) AS gboolean
	unselect_range AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint) AS gboolean
	select_all AS Function CDECL(BYVAL AS GtkSelectionModel Ptr) AS gboolean
	unselect_all AS Function CDECL(BYVAL AS GtkSelectionModel Ptr) AS gboolean
	set_selection AS Function CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS GtkBitset Ptr, BYVAL AS GtkBitset Ptr) AS gboolean
End Type

Declare Function gtk_selection_model_is_selected CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint) AS gboolean
Declare Function gtk_selection_model_get_selection CDECL(BYVAL AS GtkSelectionModel Ptr) AS GtkBitset Ptr
Declare Function gtk_selection_model_get_selection_in_range CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint) AS GtkBitset Ptr
Declare Function gtk_selection_model_select_item CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS gboolean) AS gboolean
Declare Function gtk_selection_model_unselect_item CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint) AS gboolean
Declare Function gtk_selection_model_select_range CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS gboolean) AS gboolean
Declare Function gtk_selection_model_unselect_range CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint) AS gboolean
Declare Function gtk_selection_model_select_all CDECL(BYVAL AS GtkSelectionModel Ptr) AS gboolean
Declare Function gtk_selection_model_unselect_all CDECL(BYVAL AS GtkSelectionModel Ptr) AS gboolean
Declare Function gtk_selection_model_set_selection CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS GtkBitset Ptr, BYVAL AS GtkBitset Ptr) AS gboolean
Declare SUB gtk_selection_model_selection_changed CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS guint, BYVAL AS guint)


#DEFINE GTK_TYPE_COLUMN_VIEW (gtk_column_view_get_type ())
#DEFINE GTK_COLUMN_VIEW(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_COLUMN_VIEW, GtkColumnView))
#DEFINE GTK_COLUMN_VIEW_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_COLUMN_VIEW, GtkColumnViewClass))
#DEFINE GTK_IS_COLUMN_VIEW(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_COLUMN_VIEW))
#DEFINE GTK_IS_COLUMN_VIEW_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_COLUMN_VIEW))
#DEFINE GTK_COLUMN_VIEW_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_COLUMN_VIEW, GtkColumnViewClass))

Type GtkColumnView AS _GtkColumnView
Type GtkColumnViewClass AS _GtkColumnViewClass
Type GtkColumnViewColumn AS _GtkColumnViewColumn
Declare Function gtk_column_view_get_type CDECL() AS GType
Declare Function gtk_column_view_new CDECL(BYVAL AS GtkSelectionModel Ptr) AS GtkWidget Ptr
Declare Function gtk_column_view_get_columns CDECL(BYVAL AS GtkColumnView Ptr) AS GListModel Ptr
Declare SUB gtk_column_view_append_column CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkColumnViewColumn Ptr)
Declare SUB gtk_column_view_remove_column CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkColumnViewColumn Ptr)
Declare SUB gtk_column_view_insert_column CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS guint, BYVAL AS GtkColumnViewColumn Ptr)
Declare Function gtk_column_view_get_model CDECL(BYVAL AS GtkColumnView Ptr) AS GtkSelectionModel Ptr
Declare SUB gtk_column_view_set_model CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkSelectionModel Ptr)
Declare Function gtk_column_view_get_show_row_separators CDECL(BYVAL AS GtkColumnView Ptr) AS gboolean
Declare SUB gtk_column_view_set_show_row_separators CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_get_show_column_separators CDECL(BYVAL AS GtkColumnView Ptr) AS gboolean
Declare SUB gtk_column_view_set_show_column_separators CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_get_sorter CDECL(BYVAL AS GtkColumnView Ptr) AS GtkSorter Ptr
Declare SUB gtk_column_view_sort_by_column CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS GtkSortType)
Declare SUB gtk_column_view_set_single_click_activate CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_get_single_click_activate CDECL(BYVAL AS GtkColumnView Ptr) AS gboolean
Declare SUB gtk_column_view_set_reorderable CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_get_reorderable CDECL(BYVAL AS GtkColumnView Ptr) AS gboolean
Declare SUB gtk_column_view_set_enable_rubberband CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_get_enable_rubberband CDECL(BYVAL AS GtkColumnView Ptr) AS gboolean
Declare SUB gtk_column_view_set_tab_behavior CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkListTabBehavior)
Declare Function gtk_column_view_get_tab_behavior CDECL(BYVAL AS GtkColumnView Ptr) AS GtkListTabBehavior
Declare SUB gtk_column_view_set_row_factory CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_column_view_get_row_factory CDECL(BYVAL AS GtkColumnView Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_column_view_set_header_factory CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_column_view_get_header_factory CDECL(BYVAL AS GtkColumnView Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_column_view_scroll_to CDECL(BYVAL AS GtkColumnView Ptr, BYVAL AS guint, BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS GtkListScrollFlags, BYVAL AS GtkScrollInfo Ptr)


#DEFINE GTK_TYPE_LIST_ITEM (gtk_list_item_get_type ())

Type GtkListItem AS _GtkListItem
Declare Function gtk_list_item_get_item CDECL(BYVAL AS GtkListItem Ptr) AS gpointer
Declare Function gtk_list_item_get_position CDECL(BYVAL AS GtkListItem Ptr) AS guint
Declare Function gtk_list_item_get_selected CDECL(BYVAL AS GtkListItem Ptr) AS gboolean
Declare Function gtk_list_item_get_selectable CDECL(BYVAL AS GtkListItem Ptr) AS gboolean
Declare SUB gtk_list_item_set_selectable CDECL(BYVAL AS GtkListItem Ptr, BYVAL AS gboolean)
Declare Function gtk_list_item_get_activatable CDECL(BYVAL AS GtkListItem Ptr) AS gboolean
Declare SUB gtk_list_item_set_activatable CDECL(BYVAL AS GtkListItem Ptr, BYVAL AS gboolean)
Declare Function gtk_list_item_get_focusable CDECL(BYVAL AS GtkListItem Ptr) AS gboolean
Declare SUB gtk_list_item_set_focusable CDECL(BYVAL AS GtkListItem Ptr, BYVAL AS gboolean)
Declare SUB gtk_list_item_set_child CDECL(BYVAL AS GtkListItem Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_list_item_get_child CDECL(BYVAL AS GtkListItem Ptr) AS GtkWidget Ptr
Declare SUB gtk_list_item_set_accessible_description CDECL(BYVAL AS GtkListItem Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_list_item_get_accessible_description CDECL(BYVAL AS GtkListItem Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_list_item_set_accessible_label CDECL(BYVAL AS GtkListItem Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_list_item_get_accessible_label CDECL(BYVAL AS GtkListItem Ptr) AS Const ZSTRING Ptr

#DEFINE GTK_TYPE_COLUMN_VIEW_CELL (gtk_column_view_cell_get_type ())
Type GtkColumnViewCell AS _GtkColumnViewCell
Declare Function gtk_column_view_cell_get_item CDECL(BYVAL AS GtkColumnViewCell Ptr) AS gpointer
Declare Function gtk_column_view_cell_get_position CDECL(BYVAL AS GtkColumnViewCell Ptr) AS guint
Declare Function gtk_column_view_cell_get_selected CDECL(BYVAL AS GtkColumnViewCell Ptr) AS gboolean
Declare Function gtk_column_view_cell_get_focusable CDECL(BYVAL AS GtkColumnViewCell Ptr) AS gboolean
Declare SUB gtk_column_view_cell_set_focusable CDECL(BYVAL AS GtkColumnViewCell Ptr, BYVAL AS gboolean)
Declare SUB gtk_column_view_cell_set_child CDECL(BYVAL AS GtkColumnViewCell Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_column_view_cell_get_child CDECL(BYVAL AS GtkColumnViewCell Ptr) AS GtkWidget Ptr






#DEFINE GTK_TYPE_COLUMN_VIEW_COLUMN (gtk_column_view_column_get_type ())
#DEFINE GTK_COLUMN_VIEW_COLUMN(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_COLUMN_VIEW_COLUMN, GtkColumnViewColumn))
#DEFINE GTK_COLUMN_VIEW_COLUMN_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_COLUMN_VIEW_COLUMN, GtkColumnViewColumnClass))
#DEFINE GTK_IS_COLUMN_VIEW_COLUMN(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_COLUMN_VIEW_COLUMN))
#DEFINE GTK_IS_COLUMN_VIEW_COLUMN_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_COLUMN_VIEW_COLUMN))
#DEFINE GTK_COLUMN_VIEW_COLUMN_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_COLUMN_VIEW_COLUMN, GtkColumnViewColumnClass))
Type GtkColumnViewColumnClass AS _GtkColumnViewColumnClass
Declare Function gtk_column_view_column_get_type CDECL() AS GType
Declare Function gtk_column_view_column_new CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkListItemFactory Ptr) AS GtkColumnViewColumn Ptr
Declare Function gtk_column_view_column_get_column_view CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS GtkColumnView Ptr
Declare SUB gtk_column_view_column_set_factory CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_column_view_column_get_factory CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_column_view_column_set_title CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_column_view_column_get_title CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_column_view_column_set_sorter CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS GtkSorter Ptr)
Declare Function gtk_column_view_column_get_sorter CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS GtkSorter Ptr
Declare SUB gtk_column_view_column_set_visible CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_column_get_visible CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS gboolean
Declare SUB gtk_column_view_column_set_header_menu CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_column_view_column_get_header_menu CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS GMenuModel Ptr
Declare SUB gtk_column_view_column_set_fixed_width CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS LONG)
Declare Function gtk_column_view_column_get_fixed_width CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS LONG
Declare SUB gtk_column_view_column_set_resizable CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_column_get_resizable CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS gboolean
Declare SUB gtk_column_view_column_set_expand CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_column_get_expand CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS gboolean
Declare SUB gtk_column_view_column_set_id CDECL(BYVAL AS GtkColumnViewColumn Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_column_view_column_get_id CDECL(BYVAL AS GtkColumnViewColumn Ptr) AS Const ZSTRING Ptr


#DEFINE GTK_TYPE_COLUMN_VIEW_ROW (gtk_column_view_row_get_type ())
Type GtkColumnViewRow AS _GtkColumnViewRow
Declare Function gtk_column_view_row_get_item CDECL(BYVAL AS GtkColumnViewRow Ptr) AS gpointer
Declare Function gtk_column_view_row_get_position CDECL(BYVAL AS GtkColumnViewRow Ptr) AS guint
Declare Function gtk_column_view_row_get_selected CDECL(BYVAL AS GtkColumnViewRow Ptr) AS gboolean
Declare Function gtk_column_view_row_get_selectable CDECL(BYVAL AS GtkColumnViewRow Ptr) AS gboolean
Declare SUB gtk_column_view_row_set_selectable CDECL(BYVAL AS GtkColumnViewRow Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_row_get_activatable CDECL(BYVAL AS GtkColumnViewRow Ptr) AS gboolean
Declare SUB gtk_column_view_row_set_activatable CDECL(BYVAL AS GtkColumnViewRow Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_row_get_focusable CDECL(BYVAL AS GtkColumnViewRow Ptr) AS gboolean
Declare SUB gtk_column_view_row_set_focusable CDECL(BYVAL AS GtkColumnViewRow Ptr, BYVAL AS gboolean)
Declare Function gtk_column_view_row_get_accessible_description CDECL(BYVAL AS GtkColumnViewRow Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_column_view_row_set_accessible_description CDECL(BYVAL AS GtkColumnViewRow Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_column_view_row_get_accessible_label CDECL(BYVAL AS GtkColumnViewRow Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_column_view_row_set_accessible_label CDECL(BYVAL AS GtkColumnViewRow Ptr, BYVAL AS Const ZSTRING Ptr)


#DEFINE GTK_TYPE_COLUMN_VIEW_SORTER (gtk_column_view_sorter_get_type ())
Type GtkColumnViewSorter AS _GtkColumnViewSorter
Declare Function gtk_column_view_sorter_get_primary_sort_column CDECL(BYVAL AS GtkColumnViewSorter Ptr) AS GtkColumnViewColumn Ptr
Declare Function gtk_column_view_sorter_get_primary_sort_order CDECL(BYVAL AS GtkColumnViewSorter Ptr) AS GtkSortType
Declare Function gtk_column_view_sorter_get_n_sort_columns CDECL(BYVAL AS GtkColumnViewSorter Ptr) AS guint
Declare Function gtk_column_view_sorter_get_nth_sort_column CDECL(BYVAL AS GtkColumnViewSorter Ptr, BYVAL AS guint, BYVAL AS GtkSortType Ptr) AS GtkColumnViewColumn Ptr

#DEFINE GTK_ACCESSIBILITY_ATSPI
Type GtkConstraintTarget AS _GtkConstraintTarget
#DEFINE GTK_TYPE_CONSTRAINT_TARGET (gtk_constraint_target_get_type ())
Type GtkConstraintTarget AS _GtkConstraintTarget
#DEFINE GTK_TYPE_CONSTRAINT (gtk_constraint_get_type ())
Type GtkConstraint AS _GtkConstraint
Declare Function gtk_constraint_new CDECL(BYVAL AS gpointer, BYVAL AS GtkConstraintAttribute, BYVAL AS GtkConstraintRelation, BYVAL AS gpointer, BYVAL AS GtkConstraintAttribute, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS LONG) AS GtkConstraint Ptr
Declare Function gtk_constraint_new_constant CDECL(BYVAL AS gpointer, BYVAL AS GtkConstraintAttribute, BYVAL AS GtkConstraintRelation, BYVAL AS DOUBLE, BYVAL AS LONG) AS GtkConstraint Ptr
Declare Function gtk_constraint_get_target CDECL(BYVAL AS GtkConstraint Ptr) AS GtkConstraintTarget Ptr
Declare Function gtk_constraint_get_target_attribute CDECL(BYVAL AS GtkConstraint Ptr) AS GtkConstraintAttribute
Declare Function gtk_constraint_get_source CDECL(BYVAL AS GtkConstraint Ptr) AS GtkConstraintTarget Ptr
Declare Function gtk_constraint_get_source_attribute CDECL(BYVAL AS GtkConstraint Ptr) AS GtkConstraintAttribute
Declare Function gtk_constraint_get_relation CDECL(BYVAL AS GtkConstraint Ptr) AS GtkConstraintRelation
Declare Function gtk_constraint_get_multiplier CDECL(BYVAL AS GtkConstraint Ptr) AS DOUBLE
Declare Function gtk_constraint_get_constant CDECL(BYVAL AS GtkConstraint Ptr) AS DOUBLE
Declare Function gtk_constraint_get_strength CDECL(BYVAL AS GtkConstraint Ptr) AS LONG
Declare Function gtk_constraint_is_required CDECL(BYVAL AS GtkConstraint Ptr) AS gboolean
Declare Function gtk_constraint_is_attached CDECL(BYVAL AS GtkConstraint Ptr) AS gboolean
Declare Function gtk_constraint_is_constant CDECL(BYVAL AS GtkConstraint Ptr) AS gboolean


Declare Function gtk_assistant_page_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ASSISTANT_PAGE_TYPE (gtk_assistant_page_type_get_type ())
Declare Function gtk_cell_renderer_state_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CELL_RENDERER_STATE (gtk_cell_renderer_state_get_type ())
Declare Function gtk_cell_renderer_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CELL_RENDERER_MODE (gtk_cell_renderer_mode_get_type ())
Declare Function gtk_cell_renderer_accel_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CELL_RENDERER_ACCEL_MODE (gtk_cell_renderer_accel_mode_get_type ())
Declare Function gtk_dialog_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_DIALOG_FLAGS (gtk_dialog_flags_get_type ())
Declare Function gtk_response_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_RESPONSE_TYPE (gtk_response_type_get_type ())
Declare Function gtk_file_chooser_action_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FILE_CHOOSER_ACTION (gtk_file_chooser_action_get_type ())
Declare Function gtk_file_chooser_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FILE_CHOOSER_ERROR (gtk_file_chooser_error_get_type ())
Declare Function gtk_font_chooser_level_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FONT_CHOOSER_LEVEL (gtk_font_chooser_level_get_type ())
Declare Function gtk_icon_view_drop_position_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ICON_VIEW_DROP_POSITION (gtk_icon_view_drop_position_get_type ())
Declare Function gtk_buttons_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_BUTTONS_TYPE (gtk_buttons_type_get_type ())
Declare Function gtk_shortcut_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SHORTCUT_TYPE (gtk_shortcut_type_get_type ())
Declare Function gtk_style_context_print_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_STYLE_CONTEXT_PRINT_FLAGS (gtk_style_context_print_flags_get_type ())
Declare Function gtk_tree_model_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TREE_MODEL_FLAGS (gtk_tree_model_flags_get_type ())
Declare Function gtk_tree_view_drop_position_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TREE_VIEW_DROP_POSITION (gtk_tree_view_drop_position_get_type ())
Declare Function gtk_tree_view_column_sizing_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TREE_VIEW_COLUMN_SIZING (gtk_tree_view_column_sizing_get_type ())
Declare Function gtk_license_get_type CDECL() AS GType
#DEFINE GTK_TYPE_LICENSE (gtk_license_get_type ())
Declare Function gtk_accessible_platform_state_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_PLATFORM_STATE (gtk_accessible_platform_state_get_type ())
Declare Function gtk_accessible_text_granularity_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_TEXT_GRANULARITY (gtk_accessible_text_granularity_get_type ())
Declare Function gtk_accessible_text_content_change_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_TEXT_CONTENT_CHANGE (gtk_accessible_text_content_change_get_type ())
Declare Function gtk_application_inhibit_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_APPLICATION_INHIBIT_FLAGS (gtk_application_inhibit_flags_get_type ())
Declare Function gtk_builder_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_BUILDER_ERROR (gtk_builder_error_get_type ())
Declare Function gtk_builder_closure_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_BUILDER_CLOSURE_FLAGS (gtk_builder_closure_flags_get_type ())
Declare Function gtk_debug_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_DEBUG_FLAGS (gtk_debug_flags_get_type ())
Declare Function gtk_dialog_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_DIALOG_ERROR (gtk_dialog_error_get_type ())
Declare Function gtk_editable_properties_get_type CDECL() AS GType
#DEFINE GTK_TYPE_EDITABLE_PROPERTIES (gtk_editable_properties_get_type ())
Declare Function gtk_entry_icon_position_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ENTRY_ICON_POSITION (gtk_entry_icon_position_get_type ())
Declare Function gtk_align_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ALIGN (gtk_align_get_type ())
Declare Function gtk_arrow_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ARROW_TYPE (gtk_arrow_type_get_type ())
Declare Function gtk_baseline_position_get_type CDECL() AS GType
#DEFINE GTK_TYPE_BASELINE_POSITION (gtk_baseline_position_get_type ())
Declare Function gtk_content_fit_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CONTENT_FIT (gtk_content_fit_get_type ())
Declare Function gtk_delete_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_DELETE_TYPE (gtk_delete_type_get_type ())
Declare Function gtk_direction_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_DIRECTION_TYPE (gtk_direction_type_get_type ())
Declare Function gtk_icon_size_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ICON_SIZE (gtk_icon_size_get_type ())
Declare Function gtk_sensitivity_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SENSITIVITY_TYPE (gtk_sensitivity_type_get_type ())
Declare Function gtk_text_direction_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TEXT_DIRECTION (gtk_text_direction_get_type ())
Declare Function gtk_justification_get_type CDECL() AS GType
#DEFINE GTK_TYPE_JUSTIFICATION (gtk_justification_get_type ())
Declare Function gtk_list_tab_behavior_get_type CDECL() AS GType
#DEFINE GTK_TYPE_LIST_TAB_BEHAVIOR (gtk_list_tab_behavior_get_type ())
Declare Function gtk_list_scroll_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_LIST_SCROLL_FLAGS (gtk_list_scroll_flags_get_type ())
Declare Function gtk_message_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_MESSAGE_TYPE (gtk_message_type_get_type ())
Declare Function gtk_movement_step_get_type CDECL() AS GType
#DEFINE GTK_TYPE_MOVEMENT_STEP (gtk_movement_step_get_type ())
Declare Function gtk_natural_wrap_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_NATURAL_WRAP_MODE (gtk_natural_wrap_mode_get_type ())
Declare Function gtk_scroll_step_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SCROLL_STEP (gtk_scroll_step_get_type ())
Declare Function gtk_orientation_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ORIENTATION (gtk_orientation_get_type ())
Declare Function gtk_overflow_get_type CDECL() AS GType
#DEFINE GTK_TYPE_OVERFLOW (gtk_overflow_get_type ())
Declare Function gtk_pack_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PACK_TYPE (gtk_pack_type_get_type ())
Declare Function gtk_position_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_POSITION_TYPE (gtk_position_type_get_type ())
Declare Function gtk_scroll_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SCROLL_TYPE (gtk_scroll_type_get_type ())
Declare Function gtk_selection_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SELECTION_MODE (gtk_selection_mode_get_type ())
Declare Function gtk_wrap_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_WRAP_MODE (gtk_wrap_mode_get_type ())
Declare Function gtk_sort_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SORT_TYPE (gtk_sort_type_get_type ())
Declare Function gtk_print_pages_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_PAGES (gtk_print_pages_get_type ())
Declare Function gtk_page_set_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PAGE_SET (gtk_page_set_get_type ())
Declare Function gtk_number_up_layout_get_type CDECL() AS GType
#DEFINE GTK_TYPE_NUMBER_UP_LAYOUT (gtk_number_up_layout_get_type ())
Declare Function gtk_ordering_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ORDERING (gtk_ordering_get_type ())
Declare Function gtk_page_orientation_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PAGE_ORIENTATION (gtk_page_orientation_get_type ())
Declare Function gtk_print_quality_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_QUALITY (gtk_print_quality_get_type ())
Declare Function gtk_print_duplex_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_DUPLEX (gtk_print_duplex_get_type ())
Declare Function gtk_unit_get_type CDECL() AS GType
#DEFINE GTK_TYPE_UNIT (gtk_unit_get_type ())
Declare Function gtk_tree_view_grid_lines_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TREE_VIEW_GRID_LINES (gtk_tree_view_grid_lines_get_type ())
Declare Function gtk_size_group_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SIZE_GROUP_MODE (gtk_size_group_mode_get_type ())
Declare Function gtk_size_request_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SIZE_REQUEST_MODE (gtk_size_request_mode_get_type ())
Declare Function gtk_scrollable_policy_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SCROLLABLE_POLICY (gtk_scrollable_policy_get_type ())
Declare Function gtk_state_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_STATE_FLAGS (gtk_state_flags_get_type ())
Declare Function gtk_border_style_get_type CDECL() AS GType
#DEFINE GTK_TYPE_BORDER_STYLE (gtk_border_style_get_type ())
Declare Function gtk_level_bar_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_LEVEL_BAR_MODE (gtk_level_bar_mode_get_type ())
Declare Function gtk_input_purpose_get_type CDECL() AS GType
#DEFINE GTK_TYPE_INPUT_PURPOSE (gtk_input_purpose_get_type ())
Declare Function gtk_input_hints_get_type CDECL() AS GType
#DEFINE GTK_TYPE_INPUT_HINTS (gtk_input_hints_get_type ())
Declare Function gtk_propagation_phase_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PROPAGATION_PHASE (gtk_propagation_phase_get_type ())
Declare Function gtk_propagation_limit_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PROPAGATION_LIMIT (gtk_propagation_limit_get_type ())
Declare Function gtk_event_sequence_state_get_type CDECL() AS GType
#DEFINE GTK_TYPE_EVENT_SEQUENCE_STATE (gtk_event_sequence_state_get_type ())
Declare Function gtk_pan_direction_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PAN_DIRECTION (gtk_pan_direction_get_type ())
Declare Function gtk_shortcut_scope_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SHORTCUT_SCOPE (gtk_shortcut_scope_get_type ())
Declare Function gtk_pick_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PICK_FLAGS (gtk_pick_flags_get_type ())
Declare Function gtk_constraint_relation_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CONSTRAINT_RELATION (gtk_constraint_relation_get_type ())
Declare Function gtk_constraint_strength_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CONSTRAINT_STRENGTH (gtk_constraint_strength_get_type ())
Declare Function gtk_constraint_attribute_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CONSTRAINT_ATTRIBUTE (gtk_constraint_attribute_get_type ())
Declare Function gtk_constraint_vfl_parser_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CONSTRAINT_VFL_PARSER_ERROR (gtk_constraint_vfl_parser_error_get_type ())
Declare Function gtk_system_setting_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SYSTEM_SETTING (gtk_system_setting_get_type ())
Declare Function gtk_symbolic_color_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SYMBOLIC_COLOR (gtk_symbolic_color_get_type ())
Declare Function gtk_accessible_role_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_ROLE (gtk_accessible_role_get_type ())
Declare Function gtk_accessible_state_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_STATE (gtk_accessible_state_get_type ())
Declare Function gtk_accessible_property_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_PROPERTY (gtk_accessible_property_get_type ())
Declare Function gtk_accessible_relation_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_RELATION (gtk_accessible_relation_get_type ())
Declare Function gtk_accessible_tristate_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_TRISTATE (gtk_accessible_tristate_get_type ())
Declare Function gtk_accessible_invalid_state_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_INVALID_STATE (gtk_accessible_invalid_state_get_type ())
Declare Function gtk_accessible_autocomplete_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_AUTOCOMPLETE (gtk_accessible_autocomplete_get_type ())
Declare Function gtk_accessible_sort_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_SORT (gtk_accessible_sort_get_type ())
Declare Function gtk_accessible_announcement_priority_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ACCESSIBLE_ANNOUNCEMENT_PRIORITY (gtk_accessible_announcement_priority_get_type ())
Declare Function gtk_popover_menu_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_POPOVER_MENU_FLAGS (gtk_popover_menu_flags_get_type ())
Declare Function gtk_font_rendering_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FONT_RENDERING (gtk_font_rendering_get_type ())
Declare Function gtk_text_buffer_notify_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TEXT_BUFFER_NOTIFY_FLAGS (gtk_text_buffer_notify_flags_get_type ())
Declare Function gtk_event_controller_scroll_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_EVENT_CONTROLLER_SCROLL_FLAGS (gtk_event_controller_scroll_flags_get_type ())
Declare Function gtk_filter_match_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FILTER_MATCH (gtk_filter_match_get_type ())
Declare Function gtk_filter_change_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FILTER_CHANGE (gtk_filter_change_get_type ())
Declare Function gtk_font_level_get_type CDECL() AS GType
#DEFINE GTK_TYPE_FONT_LEVEL (gtk_font_level_get_type ())
Declare Function gtk_graphics_offload_enabled_get_type CDECL() AS GType
#DEFINE GTK_TYPE_GRAPHICS_OFFLOAD_ENABLED (gtk_graphics_offload_enabled_get_type ())
Declare Function gtk_icon_lookup_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ICON_LOOKUP_FLAGS (gtk_icon_lookup_flags_get_type ())
Declare Function gtk_icon_theme_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_ICON_THEME_ERROR (gtk_icon_theme_error_get_type ())
Declare Function gtk_image_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_IMAGE_TYPE (gtk_image_type_get_type ())
Declare Function gtk_inscription_overflow_get_type CDECL() AS GType
#DEFINE GTK_TYPE_INSCRIPTION_OVERFLOW (gtk_inscription_overflow_get_type ())
Declare Function gtk_notebook_tab_get_type CDECL() AS GType
#DEFINE GTK_TYPE_NOTEBOOK_TAB (gtk_notebook_tab_get_type ())
Declare Function gtk_pad_action_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PAD_ACTION_TYPE (gtk_pad_action_type_get_type ())
Declare Function gtk_recent_manager_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_RECENT_MANAGER_ERROR (gtk_recent_manager_error_get_type ())
Declare Function gtk_revealer_transition_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_REVEALER_TRANSITION_TYPE (gtk_revealer_transition_type_get_type ())
Declare Function gtk_corner_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_CORNER_TYPE (gtk_corner_type_get_type ())
Declare Function gtk_policy_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_POLICY_TYPE (gtk_policy_type_get_type ())
Declare Function gtk_shortcut_action_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SHORTCUT_ACTION_FLAGS (gtk_shortcut_action_flags_get_type ())
Declare Function gtk_sorter_order_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SORTER_ORDER (gtk_sorter_order_get_type ())
Declare Function gtk_sorter_change_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SORTER_CHANGE (gtk_sorter_change_get_type ())
Declare Function gtk_spin_button_update_policy_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SPIN_BUTTON_UPDATE_POLICY (gtk_spin_button_update_policy_get_type ())
Declare Function gtk_spin_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_SPIN_TYPE (gtk_spin_type_get_type ())
Declare Function gtk_stack_transition_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_STACK_TRANSITION_TYPE (gtk_stack_transition_type_get_type ())
Declare Function gtk_string_filter_match_mode_get_type CDECL() AS GType
#DEFINE GTK_TYPE_STRING_FILTER_MATCH_MODE (gtk_string_filter_match_mode_get_type ())
Declare Function gtk_collation_get_type CDECL() AS GType
#DEFINE GTK_TYPE_COLLATION (gtk_collation_get_type ())
Declare Function gtk_text_search_flags_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TEXT_SEARCH_FLAGS (gtk_text_search_flags_get_type ())
Declare Function gtk_text_window_type_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TEXT_WINDOW_TYPE (gtk_text_window_type_get_type ())
Declare Function gtk_text_view_layer_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TEXT_VIEW_LAYER (gtk_text_view_layer_get_type ())
Declare Function gtk_text_extend_selection_get_type CDECL() AS GType
#DEFINE GTK_TYPE_TEXT_EXTEND_SELECTION (gtk_text_extend_selection_get_type ())
Declare Function gtk_print_status_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_STATUS (gtk_print_status_get_type ())
Declare Function gtk_print_operation_result_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_OPERATION_RESULT (gtk_print_operation_result_get_type ())
Declare Function gtk_print_operation_action_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_OPERATION_ACTION (gtk_print_operation_action_get_type ())
Declare Function gtk_print_error_get_type CDECL() AS GType
#DEFINE GTK_TYPE_PRINT_ERROR (gtk_print_error_get_type ())

#DEFINE GTK_TYPE_CONSTRAINT_GUIDE (gtk_constraint_guide_get_type ())
Type GtkConstraintGuide AS _GtkConstraintGuide
Declare Function gtk_constraint_guide_new CDECL() AS GtkConstraintGuide Ptr
Declare SUB gtk_constraint_guide_set_min_size CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_constraint_guide_get_min_size CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_constraint_guide_set_nat_size CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_constraint_guide_get_nat_size CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_constraint_guide_set_max_size CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_constraint_guide_get_max_size CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Function gtk_constraint_guide_get_strength CDECL(BYVAL AS GtkConstraintGuide Ptr) AS GtkConstraintStrength
Declare SUB gtk_constraint_guide_set_strength CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS GtkConstraintStrength)
Declare SUB gtk_constraint_guide_set_name CDECL(BYVAL AS GtkConstraintGuide Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_constraint_guide_get_name CDECL(BYVAL AS GtkConstraintGuide Ptr) AS Const ZSTRING Ptr

#DEFINE GTK_TYPE_CONSTRAINT_LAYOUT (gtk_constraint_layout_get_type ())
#DEFINE GTK_TYPE_CONSTRAINT_LAYOUT_CHILD (gtk_constraint_layout_child_get_type ())
#DEFINE GTK_CONSTRAINT_VFL_PARSER_ERROR (gtk_constraint_vfl_parser_error_quark ())
Type GtkConstraintLayoutChild AS _GtkConstraintLayoutChild
Type GtkConstraintLayout AS _GtkConstraintLayout
Declare Function gtk_constraint_vfl_parser_error_quark CDECL() AS GQuark
Declare Function gtk_constraint_layout_new CDECL() AS GtkLayoutManager Ptr
Declare SUB gtk_constraint_layout_add_constraint CDECL(BYVAL AS GtkConstraintLayout Ptr, BYVAL AS GtkConstraint Ptr)
Declare SUB gtk_constraint_layout_remove_constraint CDECL(BYVAL AS GtkConstraintLayout Ptr, BYVAL AS GtkConstraint Ptr)
Declare SUB gtk_constraint_layout_add_guide CDECL(BYVAL AS GtkConstraintLayout Ptr, BYVAL AS GtkConstraintGuide Ptr)
Declare SUB gtk_constraint_layout_remove_guide CDECL(BYVAL AS GtkConstraintLayout Ptr, BYVAL AS GtkConstraintGuide Ptr)
Declare SUB gtk_constraint_layout_remove_all_constraints CDECL(BYVAL AS GtkConstraintLayout Ptr)
Declare Function gtk_constraint_layout_add_constraints_from_description CDECL(BYVAL AS GtkConstraintLayout Ptr, BYVAL AS Const ZSTRING Const Ptr Ptr, BYVAL AS gsize, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GError Ptr Ptr, BYVAL AS Const ZSTRING Ptr, ...) AS GList Ptr
Declare Function gtk_constraint_layout_add_constraints_from_descriptionv CDECL(BYVAL AS GtkConstraintLayout Ptr, BYVAL AS Const ZSTRING Const Ptr Ptr, BYVAL AS gsize, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GHashTable Ptr, BYVAL AS GError Ptr Ptr) AS GList Ptr
Declare Function gtk_constraint_layout_observe_constraints CDECL(BYVAL AS GtkConstraintLayout Ptr) AS GListModel Ptr
Declare Function gtk_constraint_layout_observe_guides CDECL(BYVAL AS GtkConstraintLayout Ptr) AS GListModel Ptr

#DEFINE GTK_TYPE_CSS_PROVIDER (gtk_css_provider_get_type ())
#DEFINE GTK_CSS_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_CSS_PROVIDER, GtkCssProvider))
#DEFINE GTK_IS_CSS_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_CSS_PROVIDER))
Type GtkCssProvider AS _GtkCssProvider
Type GtkCssProviderClass AS _GtkCssProviderClass
Type GtkCssProviderPrivate AS _GtkCssProviderPrivate
Type _GtkCssProvider
	AS GObject parent_instance
End Type
Declare Function gtk_css_provider_get_type CDECL() AS GType
Declare Function gtk_css_provider_new CDECL() AS GtkCssProvider Ptr
Declare Function gtk_css_provider_to_string CDECL(BYVAL AS GtkCssProvider Ptr) AS ZSTRING Ptr
Declare SUB gtk_css_provider_load_from_string CDECL(BYVAL AS GtkCssProvider Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_css_provider_load_from_bytes CDECL(BYVAL AS GtkCssProvider Ptr, BYVAL AS GBytes Ptr)
Declare SUB gtk_css_provider_load_from_file CDECL(BYVAL AS GtkCssProvider Ptr, BYVAL AS GFile Ptr)
Declare SUB gtk_css_provider_load_from_path CDECL(BYVAL AS GtkCssProvider Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_css_provider_load_from_resource CDECL(BYVAL AS GtkCssProvider Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_css_provider_load_named CDECL(BYVAL AS GtkCssProvider Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr)


#DEFINE GTK_TYPE_CUSTOM_LAYOUT (gtk_custom_layout_get_type ())
Type GtkCustomRequestModeFunc AS Function CDECL(BYVAL AS GtkWidget Ptr) AS GtkSizeRequestMode
Type GtkCustomMeasureFunc AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS GtkOrientation, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Type GtkCustomAllocateFunc AS SUB CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
Type GtkCustomLayout AS _GtkCustomLayout
Declare Function gtk_custom_layout_new CDECL(BYVAL AS GtkCustomRequestModeFunc, BYVAL AS GtkCustomMeasureFunc, BYVAL AS GtkCustomAllocateFunc) AS GtkLayoutManager Ptr

#DEFINE GTK_TYPE_CUSTOM_SORTER (gtk_custom_sorter_get_type ())

Type GtkCustomSorter AS _GtkCustomSorter
Declare Function gtk_custom_sorter_new CDECL(BYVAL AS GCompareDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GtkCustomSorter Ptr
Declare SUB gtk_custom_sorter_set_sort_func CDECL(BYVAL AS GtkCustomSorter Ptr, BYVAL AS GCompareDataFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)

Enum GtkDebugFlags_
	GTK_DEBUG_TEXT = 1  SHL 0
	GTK_DEBUG_TREE = 1  SHL 1
	GTK_DEBUG_KEYBINDINGS = 1  SHL 2
	GTK_DEBUG_MODULES = 1  SHL 3
	GTK_DEBUG_GEOMETRY = 1  SHL 4
	GTK_DEBUG_ICONTHEME = 1  SHL 5
	GTK_DEBUG_PRINTING = 1  SHL 6
	GTK_DEBUG_BUILDER_TRACE = 1  SHL 7
	GTK_DEBUG_SIZE_REQUEST = 1  SHL 8
	GTK_DEBUG_NO_CSS_CACHE = 1  SHL 9
	GTK_DEBUG_INTERACTIVE = 1  SHL 10
	GTK_DEBUG_ACTIONS = 1  SHL 12
	GTK_DEBUG_LAYOUT = 1  SHL 13
	GTK_DEBUG_SNAPSHOT = 1  SHL 14
	GTK_DEBUG_CONSTRAINTS = 1  SHL 15
	GTK_DEBUG_BUILDER_OBJECTS = 1  SHL 16
	GTK_DEBUG_A11Y = 1  SHL 17
	GTK_DEBUG_ICONFALLBACK = 1  SHL 18
	GTK_DEBUG_INVERT_TEXT_DIR = 1  SHL 19
	GTK_DEBUG_CSS = 1  SHL 20
	GTK_DEBUG_BUILDER = 1  SHL 21
End Enum
Type AS LONG GtkDebugFlags

#DEFINE GTK_DEBUG_CHECK(type) G_UNLIKELY (gtk_get_debug_flags ()  AND  GTK_DEBUG_##type)

Declare Function gtk_get_debug_flags CDECL() AS GtkDebugFlags
Declare SUB gtk_set_debug_flags CDECL(BYVAL AS GtkDebugFlags)

#DEFINE GTK_DIALOG_ERROR (gtk_dialog_error_quark ())

Enum GtkDialogError_
	GTK_DIALOG_ERROR_FAILED
	GTK_DIALOG_ERROR_CANCELLED
	GTK_DIALOG_ERROR_DISMISSED
End Enum
Type AS LONG GtkDialogError

Declare Function gtk_dialog_error_quark CDECL() AS GQuark

#DEFINE GTK_TYPE_DIRECTORY_LIST (gtk_directory_list_get_type ())
Type GtkDirectoryList AS _GtkDirectoryList
Declare Function gtk_directory_list_new CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GFile Ptr) AS GtkDirectoryList Ptr
Declare SUB gtk_directory_list_set_file CDECL(BYVAL AS GtkDirectoryList Ptr, BYVAL AS GFile Ptr)
Declare Function gtk_directory_list_get_file CDECL(BYVAL AS GtkDirectoryList Ptr) AS GFile Ptr
Declare SUB gtk_directory_list_set_attributes CDECL(BYVAL AS GtkDirectoryList Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_directory_list_get_attributes CDECL(BYVAL AS GtkDirectoryList Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_directory_list_set_io_priority CDECL(BYVAL AS GtkDirectoryList Ptr, BYVAL AS LONG)
Declare Function gtk_directory_list_get_io_priority CDECL(BYVAL AS GtkDirectoryList Ptr) AS LONG
Declare Function gtk_directory_list_is_loading CDECL(BYVAL AS GtkDirectoryList Ptr) AS gboolean
Declare Function gtk_directory_list_get_error CDECL(BYVAL AS GtkDirectoryList Ptr) AS Const GError Ptr
Declare SUB gtk_directory_list_set_monitored CDECL(BYVAL AS GtkDirectoryList Ptr, BYVAL AS gboolean)
Declare Function gtk_directory_list_get_monitored CDECL(BYVAL AS GtkDirectoryList Ptr) AS gboolean




#DEFINE GTK_TYPE_DRAG_ICON (gtk_drag_icon_get_type ())
Type GtkDragIcon AS _GtkDragIcon
Declare Function gtk_drag_icon_get_for_drag CDECL(BYVAL AS GdkDrag Ptr) AS GtkWidget Ptr
Declare SUB gtk_drag_icon_set_child CDECL(BYVAL AS GtkDragIcon Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_drag_icon_get_child CDECL(BYVAL AS GtkDragIcon Ptr) AS GtkWidget Ptr
Declare SUB gtk_drag_icon_set_from_paintable CDECL(BYVAL AS GdkDrag Ptr, BYVAL AS GdkPaintable Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_drag_icon_create_widget_for_value CDECL(BYVAL AS Const GValue Ptr) AS GtkWidget Ptr

#DEFINE GTK_TYPE_DRAG_SOURCE (gtk_drag_source_get_type ())
#DEFINE GTK_DRAG_SOURCE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_DRAG_SOURCE, GtkDragSource))
#DEFINE GTK_DRAG_SOURCE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_DRAG_SOURCE, GtkDragSourceClass))
#DEFINE GTK_IS_DRAG_SOURCE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_DRAG_SOURCE))
#DEFINE GTK_IS_DRAG_SOURCE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_DRAG_SOURCE))
#DEFINE GTK_DRAG_SOURCE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_DRAG_SOURCE, GtkDragSourceClass))
Type GtkDragSource AS _GtkDragSource
Type GtkDragSourceClass AS _GtkDragSourceClass
Declare Function gtk_drag_source_get_type CDECL() AS GType
Declare Function gtk_drag_source_new CDECL() AS GtkDragSource Ptr
Declare SUB gtk_drag_source_set_content CDECL(BYVAL AS GtkDragSource Ptr, BYVAL AS GdkContentProvider Ptr)
Declare Function gtk_drag_source_get_content CDECL(BYVAL AS GtkDragSource Ptr) AS GdkContentProvider Ptr
Declare SUB gtk_drag_source_set_actions CDECL(BYVAL AS GtkDragSource Ptr, BYVAL AS GdkDragAction)
Declare Function gtk_drag_source_get_actions CDECL(BYVAL AS GtkDragSource Ptr) AS GdkDragAction
Declare SUB gtk_drag_source_set_icon CDECL(BYVAL AS GtkDragSource Ptr, BYVAL AS GdkPaintable Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_drag_source_drag_cancel CDECL(BYVAL AS GtkDragSource Ptr)
Declare Function gtk_drag_source_get_drag CDECL(BYVAL AS GtkDragSource Ptr) AS GdkDrag Ptr
Declare Function gtk_drag_check_threshold CDECL(BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG) AS gboolean

#DEFINE GTK_TYPE_DRAWING_AREA (gtk_drawing_area_get_type ())
#DEFINE GTK_DRAWING_AREA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingArea))
#DEFINE GTK_DRAWING_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass))
#DEFINE GTK_IS_DRAWING_AREA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_DRAWING_AREA))
#DEFINE GTK_IS_DRAWING_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_DRAWING_AREA))
#DEFINE GTK_DRAWING_AREA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_DRAWING_AREA, GtkDrawingAreaClass))

Type GtkDrawingArea AS _GtkDrawingArea
Type GtkDrawingAreaClass AS _GtkDrawingAreaClass
Type GtkDrawingAreaDrawFunc AS SUB CDECL(BYVAL AS GtkDrawingArea Ptr, BYVAL AS cairo_t Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS gpointer)

Type _GtkDrawingArea
	AS GtkWidget widget
End Type

Type _GtkDrawingAreaClass
	AS GtkWidgetClass parent_class
	resize AS SUB CDECL(BYVAL AS GtkDrawingArea Ptr, BYVAL AS LONG, BYVAL AS LONG)
	AS gpointer padding(0 TO 8-1)
End Type

Declare Function gtk_drawing_area_get_type CDECL() AS GType
Declare Function gtk_drawing_area_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_drawing_area_set_content_width CDECL(BYVAL AS GtkDrawingArea Ptr, BYVAL AS LONG)
Declare Function gtk_drawing_area_get_content_width CDECL(BYVAL AS GtkDrawingArea Ptr) AS LONG
Declare SUB gtk_drawing_area_set_content_height CDECL(BYVAL AS GtkDrawingArea Ptr, BYVAL AS LONG)
Declare Function gtk_drawing_area_get_content_height CDECL(BYVAL AS GtkDrawingArea Ptr) AS LONG
Declare SUB gtk_drawing_area_set_draw_func CDECL(BYVAL AS GtkDrawingArea Ptr, BYVAL AS GtkDrawingAreaDrawFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)

Type GtkEventControllerClass AS _GtkEventControllerClass
#DEFINE GTK_TYPE_EVENT_CONTROLLER (gtk_event_controller_get_type ())
#DEFINE GTK_EVENT_CONTROLLER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_EVENT_CONTROLLER, GtkEventController))
#DEFINE GTK_EVENT_CONTROLLER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_EVENT_CONTROLLER, GtkEventControllerClass))
#DEFINE GTK_IS_EVENT_CONTROLLER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_EVENT_CONTROLLER))
#DEFINE GTK_IS_EVENT_CONTROLLER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_EVENT_CONTROLLER))
#DEFINE GTK_EVENT_CONTROLLER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_EVENT_CONTROLLER, GtkEventControllerClass))
Declare Function gtk_event_controller_get_type CDECL() AS GType
Declare Function gtk_event_controller_get_widget CDECL(BYVAL AS GtkEventController Ptr) AS GtkWidget Ptr
Declare SUB gtk_event_controller_reset CDECL(BYVAL AS GtkEventController Ptr)
Declare Function gtk_event_controller_get_propagation_phase CDECL(BYVAL AS GtkEventController Ptr) AS GtkPropagationPhase
Declare SUB gtk_event_controller_set_propagation_phase CDECL(BYVAL AS GtkEventController Ptr, BYVAL AS GtkPropagationPhase)
Declare Function gtk_event_controller_get_propagation_limit CDECL(BYVAL AS GtkEventController Ptr) AS GtkPropagationLimit
Declare SUB gtk_event_controller_set_propagation_limit CDECL(BYVAL AS GtkEventController Ptr, BYVAL AS GtkPropagationLimit)
Declare Function gtk_event_controller_get_name CDECL(BYVAL AS GtkEventController Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_event_controller_set_name CDECL(BYVAL AS GtkEventController Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_event_controller_set_static_name CDECL(BYVAL AS GtkEventController Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_event_controller_get_current_event CDECL(BYVAL AS GtkEventController Ptr) AS GdkEvent Ptr
Declare Function gtk_event_controller_get_current_event_time CDECL(BYVAL AS GtkEventController Ptr) AS guint32
Declare Function gtk_event_controller_get_current_event_device CDECL(BYVAL AS GtkEventController Ptr) AS GdkDevice Ptr
Declare Function gtk_event_controller_get_current_event_state CDECL(BYVAL AS GtkEventController Ptr) AS GdkModifierType

#DEFINE GTK_TYPE_DROP_CONTROLLER_MOTION (gtk_drop_controller_motion_get_type ())
#DEFINE GTK_DROP_CONTROLLER_MOTION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_DROP_CONTROLLER_MOTION, GtkDropControllerMotion))
#DEFINE GTK_DROP_CONTROLLER_MOTION_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_DROP_CONTROLLER_MOTION, GtkDropControllerMotionClass))
#DEFINE GTK_IS_DROP_CONTROLLER_MOTION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_DROP_CONTROLLER_MOTION))
#DEFINE GTK_IS_DROP_CONTROLLER_MOTION_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_DROP_CONTROLLER_MOTION))
#DEFINE GTK_DROP_CONTROLLER_MOTION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_DROP_CONTROLLER_MOTION, GtkDropControllerMotionClass))
Type GtkDropControllerMotion AS _GtkDropControllerMotion
Type GtkDropControllerMotionClass AS _GtkDropControllerMotionClass
Declare Function gtk_drop_controller_motion_get_type CDECL() AS GType
Declare Function gtk_drop_controller_motion_new CDECL() AS GtkEventController Ptr
Declare Function gtk_drop_controller_motion_contains_pointer CDECL(BYVAL AS GtkDropControllerMotion Ptr) AS gboolean
Declare Function gtk_drop_controller_motion_get_drop CDECL(BYVAL AS GtkDropControllerMotion Ptr) AS GdkDrop Ptr
Declare Function gtk_drop_controller_motion_is_pointer CDECL(BYVAL AS GtkDropControllerMotion Ptr) AS gboolean



Type GtkDropTarget AS _GtkDropTarget
#DEFINE GTK_TYPE_DROP_TARGET (gtk_drop_target_get_type ())
#DEFINE GTK_DROP_TARGET(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_DROP_TARGET, GtkDropTarget))
#DEFINE GTK_DROP_TARGET_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_DROP_TARGET, GtkDropTargetClass))
#DEFINE GTK_IS_DROP_TARGET(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_DROP_TARGET))
#DEFINE GTK_IS_DROP_TARGET_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_DROP_TARGET))
#DEFINE GTK_DROP_TARGET_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_DROP_TARGET, GtkDropTargetClass))
Type GtkDropTargetClass AS _GtkDropTargetClass
Declare Function gtk_drop_target_get_type CDECL() AS GType
Declare Function gtk_drop_target_new CDECL(BYVAL AS GType, BYVAL AS GdkDragAction) AS GtkDropTarget Ptr
Declare SUB gtk_drop_target_set_gtypes CDECL(BYVAL AS GtkDropTarget Ptr, BYVAL AS GType Ptr, BYVAL AS gsize)
Declare Function gtk_drop_target_get_gtypes CDECL(BYVAL AS GtkDropTarget Ptr, BYVAL AS gsize Ptr) AS Const GType Ptr
Declare Function gtk_drop_target_get_formats CDECL(BYVAL AS GtkDropTarget Ptr) AS GdkContentFormats Ptr
Declare SUB gtk_drop_target_set_actions CDECL(BYVAL AS GtkDropTarget Ptr, BYVAL AS GdkDragAction)
Declare Function gtk_drop_target_get_actions CDECL(BYVAL AS GtkDropTarget Ptr) AS GdkDragAction
Declare SUB gtk_drop_target_set_preload CDECL(BYVAL AS GtkDropTarget Ptr, BYVAL AS gboolean)
Declare Function gtk_drop_target_get_preload CDECL(BYVAL AS GtkDropTarget Ptr) AS gboolean
Declare Function gtk_drop_target_get_current_drop CDECL(BYVAL AS GtkDropTarget Ptr) AS GdkDrop Ptr
Declare Function gtk_drop_target_get_value CDECL(BYVAL AS GtkDropTarget Ptr) AS Const GValue Ptr
Declare SUB gtk_drop_target_reject CDECL(BYVAL AS GtkDropTarget Ptr)


Type GtkDropTargetAsync AS _GtkDropTargetAsync
Type GtkDropTargetAsyncClass AS _GtkDropTargetAsyncClass
#DEFINE GTK_TYPE_DROP_TARGET_ASYNC (gtk_drop_target_async_get_type ())
#DEFINE GTK_DROP_TARGET_ASYNC(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_DROP_TARGET_ASYNC, GtkDropTargetAsync))
#DEFINE GTK_DROP_TARGET_ASYNC_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_DROP_TARGET_ASYNC, GtkDropTargetAsyncClass))
#DEFINE GTK_IS_DROP_TARGET_ASYNC(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_DROP_TARGET_ASYNC))
#DEFINE GTK_IS_DROP_TARGET_ASYNC_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_DROP_TARGET_ASYNC))
#DEFINE GTK_DROP_TARGET_ASYNC_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_DROP_TARGET_ASYNC, GtkDropTargetAsyncClass))
Declare Function gtk_drop_target_async_get_type CDECL() AS GType
Declare Function gtk_drop_target_async_new CDECL(BYVAL AS GdkContentFormats Ptr, BYVAL AS GdkDragAction) AS GtkDropTargetAsync Ptr
Declare SUB gtk_drop_target_async_set_formats CDECL(BYVAL AS GtkDropTargetAsync Ptr, BYVAL AS GdkContentFormats Ptr)
Declare Function gtk_drop_target_async_get_formats CDECL(BYVAL AS GtkDropTargetAsync Ptr) AS GdkContentFormats Ptr
Declare SUB gtk_drop_target_async_set_actions CDECL(BYVAL AS GtkDropTargetAsync Ptr, BYVAL AS GdkDragAction)
Declare Function gtk_drop_target_async_get_actions CDECL(BYVAL AS GtkDropTargetAsync Ptr) AS GdkDragAction
Declare SUB gtk_drop_target_async_reject_drop CDECL(BYVAL AS GtkDropTargetAsync Ptr, BYVAL AS GdkDrop Ptr)


Enum GtkStringFilterMatchMode_
	GTK_STRING_FILTER_MATCH_MODE_EXACT
	GTK_STRING_FILTER_MATCH_MODE_SUBSTRING
	GTK_STRING_FILTER_MATCH_MODE_PREFIX
End Enum
Type AS LONG GtkStringFilterMatchMode

#DEFINE GTK_TYPE_STRING_FILTER (gtk_string_filter_get_type ())
Type GtkStringFilter AS _GtkStringFilter
Declare Function gtk_string_filter_new CDECL(BYVAL AS GtkExpression Ptr) AS GtkStringFilter Ptr
Declare Function gtk_string_filter_get_search CDECL(BYVAL AS GtkStringFilter Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_string_filter_set_search CDECL(BYVAL AS GtkStringFilter Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_string_filter_get_expression CDECL(BYVAL AS GtkStringFilter Ptr) AS GtkExpression Ptr
Declare SUB gtk_string_filter_set_expression CDECL(BYVAL AS GtkStringFilter Ptr, BYVAL AS GtkExpression Ptr)
Declare Function gtk_string_filter_get_ignore_case CDECL(BYVAL AS GtkStringFilter Ptr) AS gboolean
Declare SUB gtk_string_filter_set_ignore_case CDECL(BYVAL AS GtkStringFilter Ptr, BYVAL AS gboolean)
Declare Function gtk_string_filter_get_match_mode CDECL(BYVAL AS GtkStringFilter Ptr) AS GtkStringFilterMatchMode
Declare SUB gtk_string_filter_set_match_mode CDECL(BYVAL AS GtkStringFilter Ptr, BYVAL AS GtkStringFilterMatchMode)

#DEFINE GTK_TYPE_DROP_DOWN (gtk_drop_down_get_type ())
Type GtkDropDown AS _GtkDropDown
Declare Function gtk_drop_down_new CDECL(BYVAL AS GListModel Ptr, BYVAL AS GtkExpression Ptr) AS GtkWidget Ptr
Declare Function gtk_drop_down_new_from_strings CDECL(BYVAL AS Const ZSTRING Const Ptr Ptr) AS GtkWidget Ptr
Declare SUB gtk_drop_down_set_model CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_drop_down_get_model CDECL(BYVAL AS GtkDropDown Ptr) AS GListModel Ptr
Declare SUB gtk_drop_down_set_selected CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS guint)
Declare Function gtk_drop_down_get_selected CDECL(BYVAL AS GtkDropDown Ptr) AS guint
Declare Function gtk_drop_down_get_selected_item CDECL(BYVAL AS GtkDropDown Ptr) AS gpointer
Declare SUB gtk_drop_down_set_factory CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_drop_down_get_factory CDECL(BYVAL AS GtkDropDown Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_drop_down_set_list_factory CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_drop_down_get_list_factory CDECL(BYVAL AS GtkDropDown Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_drop_down_set_header_factory CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_drop_down_get_header_factory CDECL(BYVAL AS GtkDropDown Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_drop_down_set_expression CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS GtkExpression Ptr)
Declare Function gtk_drop_down_get_expression CDECL(BYVAL AS GtkDropDown Ptr) AS GtkExpression Ptr
Declare SUB gtk_drop_down_set_enable_search CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS gboolean)
Declare Function gtk_drop_down_get_enable_search CDECL(BYVAL AS GtkDropDown Ptr) AS gboolean
Declare SUB gtk_drop_down_set_show_arrow CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS gboolean)
Declare Function gtk_drop_down_get_show_arrow CDECL(BYVAL AS GtkDropDown Ptr) AS gboolean
Declare SUB gtk_drop_down_set_search_match_mode CDECL(BYVAL AS GtkDropDown Ptr, BYVAL AS GtkStringFilterMatchMode)
Declare Function gtk_drop_down_get_search_match_mode CDECL(BYVAL AS GtkDropDown Ptr) AS GtkStringFilterMatchMode

#DEFINE GTK_TYPE_EDITABLE (gtk_editable_get_type ())
#DEFINE GTK_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EDITABLE, GtkEditable))
#DEFINE GTK_IS_EDITABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EDITABLE))
#DEFINE GTK_EDITABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_EDITABLE, GtkEditableInterface))
Type GtkEditable AS _GtkEditable
Type GtkEditableInterface AS _GtkEditableInterface
Type _GtkEditableInterface
	AS GTypeInterface base_iface
	insert_text AS SUB CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS LONG Ptr)
	delete_text AS SUB CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG, BYVAL AS LONG)
	changed AS SUB CDECL(BYVAL AS GtkEditable Ptr)
	get_text AS Function CDECL(BYVAL AS GtkEditable Ptr) AS Const ZSTRING Ptr
	do_insert_text AS SUB CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS LONG Ptr)
	do_delete_text AS SUB CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG, BYVAL AS LONG)
	get_selection_bounds AS Function CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
	set_selection_bounds AS SUB CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG, BYVAL AS LONG)
	get_delegate AS Function CDECL(BYVAL AS GtkEditable Ptr) AS GtkEditable Ptr
End Type
Declare Function gtk_editable_get_type CDECL() AS GType
Declare Function gtk_editable_get_text CDECL(BYVAL AS GtkEditable Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_editable_set_text CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_editable_get_chars CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG, BYVAL AS LONG) AS ZSTRING Ptr
Declare SUB gtk_editable_insert_text CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS LONG Ptr)
Declare SUB gtk_editable_delete_text CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_editable_get_selection_bounds CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
Declare SUB gtk_editable_delete_selection CDECL(BYVAL AS GtkEditable Ptr)
Declare SUB gtk_editable_select_region CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_editable_set_position CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG)
Declare Function gtk_editable_get_position CDECL(BYVAL AS GtkEditable Ptr) AS LONG
Declare Function gtk_editable_get_editable CDECL(BYVAL AS GtkEditable Ptr) AS gboolean
Declare SUB gtk_editable_set_editable CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS gboolean)
Declare Function gtk_editable_get_alignment CDECL(BYVAL AS GtkEditable Ptr) AS SINGLE
Declare SUB gtk_editable_set_alignment CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS SINGLE)
Declare Function gtk_editable_get_width_chars CDECL(BYVAL AS GtkEditable Ptr) AS LONG
Declare SUB gtk_editable_set_width_chars CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG)
Declare Function gtk_editable_get_max_width_chars CDECL(BYVAL AS GtkEditable Ptr) AS LONG
Declare SUB gtk_editable_set_max_width_chars CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS LONG)
Declare Function gtk_editable_get_enable_undo CDECL(BYVAL AS GtkEditable Ptr) AS gboolean
Declare SUB gtk_editable_set_enable_undo CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS gboolean)
Enum GtkEditableProperties_
	GTK_EDITABLE_PROP_TEXT
	GTK_EDITABLE_PROP_CURSOR_POSITION
	GTK_EDITABLE_PROP_SELECTION_BOUND
	GTK_EDITABLE_PROP_EDITABLE
	GTK_EDITABLE_PROP_WIDTH_CHARS
	GTK_EDITABLE_PROP_MAX_WIDTH_CHARS
	GTK_EDITABLE_PROP_XALIGN
	GTK_EDITABLE_PROP_ENABLE_UNDO
	GTK_EDITABLE_NUM_PROPERTIES
End Enum
Type AS LONG GtkEditableProperties
Declare Function gtk_editable_install_properties CDECL(BYVAL AS GObjectClass Ptr, BYVAL AS guint) AS guint
Declare Function gtk_editable_get_delegate CDECL(BYVAL AS GtkEditable Ptr) AS GtkEditable Ptr
Declare SUB gtk_editable_init_delegate CDECL(BYVAL AS GtkEditable Ptr)
Declare SUB gtk_editable_finish_delegate CDECL(BYVAL AS GtkEditable Ptr)
Declare Function gtk_editable_delegate_set_property CDECL(BYVAL AS GObject Ptr, BYVAL AS guint, BYVAL AS Const GValue Ptr, BYVAL AS GParamSpec Ptr) AS gboolean
Declare Function gtk_editable_delegate_get_property CDECL(BYVAL AS GObject Ptr, BYVAL AS guint, BYVAL AS GValue Ptr, BYVAL AS GParamSpec Ptr) AS gboolean
Declare Function gtk_editable_delegate_get_accessible_platform_state CDECL(BYVAL AS GtkEditable Ptr, BYVAL AS GtkAccessiblePlatformState) AS gboolean

#DEFINE GTK_TYPE_EDITABLE_LABEL (gtk_editable_label_get_type ())
Type GtkEditableLabel AS _GtkEditableLabel
Declare Function gtk_editable_label_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_editable_label_get_editing CDECL(BYVAL AS GtkEditableLabel Ptr) AS gboolean
Declare SUB gtk_editable_label_start_editing CDECL(BYVAL AS GtkEditableLabel Ptr)
Declare SUB gtk_editable_label_stop_editing CDECL(BYVAL AS GtkEditableLabel Ptr, BYVAL AS gboolean)


#DEFINE GTK_TYPE_EMOJI_CHOOSER (gtk_emoji_chooser_get_type ())
#DEFINE GTK_EMOJI_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EMOJI_CHOOSER, GtkEmojiChooser))
#DEFINE GTK_EMOJI_CHOOSER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_EMOJI_CHOOSER, GtkEmojiChooserClass))
#DEFINE GTK_IS_EMOJI_CHOOSER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EMOJI_CHOOSER))
#DEFINE GTK_IS_EMOJI_CHOOSER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_EMOJI_CHOOSER))
#DEFINE GTK_EMOJI_CHOOSER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_EMOJI_CHOOSER, GtkEmojiChooserClass))
Type GtkEmojiChooser AS _GtkEmojiChooser
Type GtkEmojiChooserClass AS _GtkEmojiChooserClass
Declare Function gtk_emoji_chooser_get_type CDECL() AS GType
Declare Function gtk_emoji_chooser_new CDECL() AS GtkWidget Ptr

#DEFINE GTK_TYPE_IM_CONTEXT (gtk_im_context_get_type ())
#DEFINE GTK_IM_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_CONTEXT, GtkIMContext))
#DEFINE GTK_IM_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_CONTEXT, GtkIMContextClass))
#DEFINE GTK_IS_IM_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_CONTEXT))
#DEFINE GTK_IS_IM_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_CONTEXT))
#DEFINE GTK_IM_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_CONTEXT, GtkIMContextClass))
Type GtkIMContext AS _GtkIMContext
Type GtkIMContextClass AS _GtkIMContextClass
Type _GtkIMContext
	AS GObject parent_instance
End Type
Type _GtkIMContextClass
	AS GObjectClass parent_class
	preedit_start AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	preedit_end AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	preedit_changed AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	commit AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS Const ZSTRING Ptr)
	retrieve_surrounding AS Function CDECL(BYVAL AS GtkIMContext Ptr) AS gboolean
	delete_surrounding AS Function CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
	set_client_widget AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GtkWidget Ptr)
	get_preedit_string AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS ZSTRING Ptr Ptr, BYVAL AS PangoAttrList Ptr Ptr, BYVAL AS LONG Ptr)
	filter_keypress AS Function CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GdkEvent Ptr) AS gboolean
	focus_in AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	focus_out AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	reset_ AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	set_cursor_location AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GdkRectangle Ptr)
	set_use_preedit AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS gboolean)
	set_surrounding AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS LONG)
	get_surrounding AS Function CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS ZSTRING Ptr Ptr, BYVAL AS LONG Ptr) AS gboolean
	set_surrounding_with_selection AS SUB CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
	get_surrounding_with_selection AS Function CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS ZSTRING Ptr Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
	activate_osk AS SUB CDECL(BYVAL AS GtkIMContext Ptr)
	activate_osk_with_event AS Function CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GdkEvent Ptr) AS gboolean
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare Function gtk_im_context_get_type CDECL() AS GType
Declare SUB gtk_im_context_set_client_widget CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_im_context_get_preedit_string CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS ZSTRING Ptr Ptr, BYVAL AS PangoAttrList Ptr Ptr, BYVAL AS LONG Ptr)
Declare Function gtk_im_context_filter_keypress CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GdkEvent Ptr) AS gboolean
Declare Function gtk_im_context_filter_key CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS gboolean, BYVAL AS GdkSurface Ptr, BYVAL AS GdkDevice Ptr, BYVAL AS guint32, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS LONG) AS gboolean
Declare SUB gtk_im_context_focus_in CDECL(BYVAL AS GtkIMContext Ptr)
Declare SUB gtk_im_context_focus_out CDECL(BYVAL AS GtkIMContext Ptr)
Declare SUB gtk_im_context_reset CDECL(BYVAL AS GtkIMContext Ptr)
Declare SUB gtk_im_context_set_cursor_location CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS Const GdkRectangle Ptr)
Declare SUB gtk_im_context_set_use_preedit CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS gboolean)
Declare SUB gtk_im_context_set_surrounding_with_selection CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_im_context_get_surrounding_with_selection CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS ZSTRING Ptr Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
Declare Function gtk_im_context_delete_surrounding CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
Declare Function gtk_im_context_activate_osk CDECL(BYVAL AS GtkIMContext Ptr, BYVAL AS GdkEvent Ptr) AS gboolean

#DEFINE GTK_ENTRY_BUFFER_MAX_SIZE G_MAXUSHORT
#DEFINE GTK_TYPE_ENTRY_BUFFER (gtk_entry_buffer_get_type ())
#DEFINE GTK_ENTRY_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ENTRY_BUFFER, GtkEntryBuffer))
#DEFINE GTK_ENTRY_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ENTRY_BUFFER, GtkEntryBufferClass))
#DEFINE GTK_IS_ENTRY_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ENTRY_BUFFER))
#DEFINE GTK_IS_ENTRY_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ENTRY_BUFFER))
#DEFINE GTK_ENTRY_BUFFER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ENTRY_BUFFER, GtkEntryBufferClass))
Type GtkEntryBuffer AS _GtkEntryBuffer
Type GtkEntryBufferClass AS _GtkEntryBufferClass
Type _GtkEntryBuffer
	AS GObject parent_instance
End Type
Type _GtkEntryBufferClass
	AS GObjectClass parent_class
	inserted_text AS SUB CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS Const ZSTRING Ptr, BYVAL AS guint)
	deleted_text AS SUB CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS guint)
	get_text AS Function CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS gsize Ptr) AS Const ZSTRING Ptr
	get_length AS Function CDECL(BYVAL AS GtkEntryBuffer Ptr) AS guint
	insert_text AS Function CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS Const ZSTRING Ptr, BYVAL AS guint) AS guint
	delete_text AS Function CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS guint) AS guint
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
	_gtk_reserved5 AS SUB CDECL()
	_gtk_reserved6 AS SUB CDECL()
	_gtk_reserved7 AS SUB CDECL()
	_gtk_reserved8 AS SUB CDECL()
End Type
Declare Function gtk_entry_buffer_get_type CDECL() AS GType
Declare Function gtk_entry_buffer_new CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG) AS GtkEntryBuffer Ptr
Declare Function gtk_entry_buffer_get_bytes CDECL(BYVAL AS GtkEntryBuffer Ptr) AS gsize
Declare Function gtk_entry_buffer_get_length CDECL(BYVAL AS GtkEntryBuffer Ptr) AS guint
Declare Function gtk_entry_buffer_get_text CDECL(BYVAL AS GtkEntryBuffer Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_entry_buffer_set_text CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
Declare SUB gtk_entry_buffer_set_max_length CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS LONG)
Declare Function gtk_entry_buffer_get_max_length CDECL(BYVAL AS GtkEntryBuffer Ptr) AS LONG
Declare Function gtk_entry_buffer_insert_text CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG) AS guint
Declare Function gtk_entry_buffer_delete_text CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS LONG) AS guint
Declare SUB gtk_entry_buffer_emit_inserted_text CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS Const ZSTRING Ptr, BYVAL AS guint)
Declare SUB gtk_entry_buffer_emit_deleted_text CDECL(BYVAL AS GtkEntryBuffer Ptr, BYVAL AS guint, BYVAL AS guint)


#DEFINE GTK_TYPE_IMAGE (gtk_image_get_type ())
#DEFINE GTK_IMAGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IMAGE, GtkImage))
#DEFINE GTK_IS_IMAGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IMAGE))
Type GtkImage AS _GtkImage
Enum GtkImageType_
	GTK_IMAGE_EMPTY
	GTK_IMAGE_ICON_NAME
	GTK_IMAGE_GICON
	GTK_IMAGE_PAINTABLE
End Enum
Type AS LONG GtkImageType
Declare Function gtk_image_get_type CDECL() AS GType
Declare Function gtk_image_new CDECL() AS GtkWidget Ptr
Declare Function gtk_image_new_from_file CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_image_new_from_resource CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_image_new_from_paintable CDECL(BYVAL AS GdkPaintable Ptr) AS GtkWidget Ptr
Declare Function gtk_image_new_from_icon_name CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_image_new_from_gicon CDECL(BYVAL AS GIcon Ptr) AS GtkWidget Ptr
Declare SUB gtk_image_clear CDECL(BYVAL AS GtkImage Ptr)
Declare SUB gtk_image_set_from_file CDECL(BYVAL AS GtkImage Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_image_set_from_resource CDECL(BYVAL AS GtkImage Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_image_set_from_paintable CDECL(BYVAL AS GtkImage Ptr, BYVAL AS GdkPaintable Ptr)
Declare SUB gtk_image_set_from_icon_name CDECL(BYVAL AS GtkImage Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_image_set_from_gicon CDECL(BYVAL AS GtkImage Ptr, BYVAL AS GIcon Ptr)
Declare SUB gtk_image_set_pixel_size CDECL(BYVAL AS GtkImage Ptr, BYVAL AS LONG)
Declare SUB gtk_image_set_icon_size CDECL(BYVAL AS GtkImage Ptr, BYVAL AS GtkIconSize)
Declare Function gtk_image_get_storage_type CDECL(BYVAL AS GtkImage Ptr) AS GtkImageType
Declare Function gtk_image_get_paintable CDECL(BYVAL AS GtkImage Ptr) AS GdkPaintable Ptr
Declare Function gtk_image_get_icon_name CDECL(BYVAL AS GtkImage Ptr) AS Const ZSTRING Ptr
Declare Function gtk_image_get_gicon CDECL(BYVAL AS GtkImage Ptr) AS GIcon Ptr
Declare Function gtk_image_get_pixel_size CDECL(BYVAL AS GtkImage Ptr) AS LONG
Declare Function gtk_image_get_icon_size CDECL(BYVAL AS GtkImage Ptr) AS GtkIconSize

#DEFINE GTK_TYPE_ENTRY (gtk_entry_get_type ())
#DEFINE GTK_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ENTRY, GtkEntry))
#DEFINE GTK_ENTRY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_ENTRY, GtkEntryClass))
#DEFINE GTK_IS_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ENTRY))
#DEFINE GTK_IS_ENTRY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_ENTRY))
#DEFINE GTK_ENTRY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_ENTRY, GtkEntryClass))
Enum GtkEntryIconPosition_
	GTK_ENTRY_ICON_PRIMARY
	GTK_ENTRY_ICON_SECONDARY
End Enum
Type AS LONG GtkEntryIconPosition
Type GtkEntry AS _GtkEntry
Type GtkEntryClass AS _GtkEntryClass
Type _GtkEntry
	AS GtkWidget parent_instance
End Type
Type _GtkEntryClass
	AS GtkWidgetClass parent_class
	activate AS SUB CDECL(BYVAL AS GtkEntry Ptr)
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_entry_get_type CDECL() AS GType
Declare Function gtk_entry_new CDECL() AS GtkWidget Ptr
Declare Function gtk_entry_new_with_buffer CDECL(BYVAL AS GtkEntryBuffer Ptr) AS GtkWidget Ptr
Declare Function gtk_entry_get_buffer CDECL(BYVAL AS GtkEntry Ptr) AS GtkEntryBuffer Ptr
Declare SUB gtk_entry_set_buffer CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryBuffer Ptr)
Declare SUB gtk_entry_set_visibility CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS gboolean)
Declare Function gtk_entry_get_visibility CDECL(BYVAL AS GtkEntry Ptr) AS gboolean
Declare SUB gtk_entry_set_invisible_char CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS gunichar)
Declare Function gtk_entry_get_invisible_char CDECL(BYVAL AS GtkEntry Ptr) AS gunichar
Declare SUB gtk_entry_unset_invisible_char CDECL(BYVAL AS GtkEntry Ptr)
Declare SUB gtk_entry_set_has_frame CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS gboolean)
Declare Function gtk_entry_get_has_frame CDECL(BYVAL AS GtkEntry Ptr) AS gboolean
Declare SUB gtk_entry_set_overwrite_mode CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS gboolean)
Declare Function gtk_entry_get_overwrite_mode CDECL(BYVAL AS GtkEntry Ptr) AS gboolean
Declare SUB gtk_entry_set_max_length CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS LONG)
Declare Function gtk_entry_get_max_length CDECL(BYVAL AS GtkEntry Ptr) AS LONG
Declare Function gtk_entry_get_text_length CDECL(BYVAL AS GtkEntry Ptr) AS guint16
Declare SUB gtk_entry_set_activates_default CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS gboolean)
Declare Function gtk_entry_get_activates_default CDECL(BYVAL AS GtkEntry Ptr) AS gboolean
Declare SUB gtk_entry_set_alignment CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS SINGLE)
Declare Function gtk_entry_get_alignment CDECL(BYVAL AS GtkEntry Ptr) AS SINGLE
Declare SUB gtk_entry_set_progress_fraction CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS DOUBLE)
Declare Function gtk_entry_get_progress_fraction CDECL(BYVAL AS GtkEntry Ptr) AS DOUBLE
Declare SUB gtk_entry_set_progress_pulse_step CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS DOUBLE)
Declare Function gtk_entry_get_progress_pulse_step CDECL(BYVAL AS GtkEntry Ptr) AS DOUBLE
Declare SUB gtk_entry_progress_pulse CDECL(BYVAL AS GtkEntry Ptr)
Declare Function gtk_entry_get_placeholder_text CDECL(BYVAL AS GtkEntry Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_entry_set_placeholder_text CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_entry_set_icon_from_paintable CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS GdkPaintable Ptr)
Declare SUB gtk_entry_set_icon_from_icon_name CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_entry_set_icon_from_gicon CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS GIcon Ptr)
Declare Function gtk_entry_get_icon_storage_type CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS GtkImageType
Declare Function gtk_entry_get_icon_paintable CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS GdkPaintable Ptr
Declare Function gtk_entry_get_icon_name CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS Const ZSTRING Ptr
Declare Function gtk_entry_get_icon_gicon CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS GIcon Ptr
Declare SUB gtk_entry_set_icon_activatable CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS gboolean)
Declare Function gtk_entry_get_icon_activatable CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS gboolean
Declare SUB gtk_entry_set_icon_sensitive CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS gboolean)
Declare Function gtk_entry_get_icon_sensitive CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS gboolean
Declare Function gtk_entry_get_icon_at_pos CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS LONG, BYVAL AS LONG) AS LONG
Declare SUB gtk_entry_set_icon_tooltip_text CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_entry_get_icon_tooltip_text CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS ZSTRING Ptr
Declare SUB gtk_entry_set_icon_tooltip_markup CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_entry_get_icon_tooltip_markup CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition) AS ZSTRING Ptr
Declare SUB gtk_entry_set_icon_drag_source CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS GdkContentProvider Ptr, BYVAL AS GdkDragAction)
Declare Function gtk_entry_get_current_icon_drag_source CDECL(BYVAL AS GtkEntry Ptr) AS LONG
Declare SUB gtk_entry_get_icon_area CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkEntryIconPosition, BYVAL AS GdkRectangle Ptr)
Declare SUB gtk_entry_reset_im_context CDECL(BYVAL AS GtkEntry Ptr)
Declare SUB gtk_entry_set_input_purpose CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkInputPurpose)
Declare Function gtk_entry_get_input_purpose CDECL(BYVAL AS GtkEntry Ptr) AS GtkInputPurpose
Declare SUB gtk_entry_set_input_hints CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GtkInputHints)
Declare Function gtk_entry_get_input_hints CDECL(BYVAL AS GtkEntry Ptr) AS GtkInputHints
Declare SUB gtk_entry_set_attributes CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS PangoAttrList Ptr)
Declare Function gtk_entry_get_attributes CDECL(BYVAL AS GtkEntry Ptr) AS PangoAttrList Ptr
Declare SUB gtk_entry_set_tabs CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS PangoTabArray Ptr)
Declare Function gtk_entry_get_tabs CDECL(BYVAL AS GtkEntry Ptr) AS PangoTabArray Ptr
Declare Function gtk_entry_grab_focus_without_selecting CDECL(BYVAL AS GtkEntry Ptr) AS gboolean
Declare SUB gtk_entry_set_extra_menu CDECL(BYVAL AS GtkEntry Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_entry_get_extra_menu CDECL(BYVAL AS GtkEntry Ptr) AS GMenuModel Ptr


#DEFINE GTK_TYPE_EVENT_CONTROLLER_FOCUS (gtk_event_controller_focus_get_type ())
#DEFINE GTK_EVENT_CONTROLLER_FOCUS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_EVENT_CONTROLLER_FOCUS, GtkEventControllerFocus))
#DEFINE GTK_EVENT_CONTROLLER_FOCUS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_EVENT_CONTROLLER_FOCUS, GtkEventControllerFocusClass))
#DEFINE GTK_IS_EVENT_CONTROLLER_FOCUS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_EVENT_CONTROLLER_FOCUS))
#DEFINE GTK_IS_EVENT_CONTROLLER_FOCUS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_EVENT_CONTROLLER_FOCUS))
#DEFINE GTK_EVENT_CONTROLLER_FOCUS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_EVENT_CONTROLLER_FOCUS, GtkEventControllerFocusClass))
Type GtkEventControllerFocus AS _GtkEventControllerFocus
Type GtkEventControllerFocusClass AS _GtkEventControllerFocusClass
Declare Function gtk_event_controller_focus_get_type CDECL() AS GType
Declare Function gtk_event_controller_focus_new CDECL() AS GtkEventController Ptr
Declare Function gtk_event_controller_focus_contains_focus CDECL(BYVAL AS GtkEventControllerFocus Ptr) AS gboolean
Declare Function gtk_event_controller_focus_is_focus CDECL(BYVAL AS GtkEventControllerFocus Ptr) AS gboolean


#DEFINE GTK_TYPE_EVENT_CONTROLLER_KEY (gtk_event_controller_key_get_type ())
#DEFINE GTK_EVENT_CONTROLLER_KEY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_EVENT_CONTROLLER_KEY, GtkEventControllerKey))
#DEFINE GTK_EVENT_CONTROLLER_KEY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_EVENT_CONTROLLER_KEY, GtkEventControllerKeyClass))
#DEFINE GTK_IS_EVENT_CONTROLLER_KEY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_EVENT_CONTROLLER_KEY))
#DEFINE GTK_IS_EVENT_CONTROLLER_KEY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_EVENT_CONTROLLER_KEY))
#DEFINE GTK_EVENT_CONTROLLER_KEY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_EVENT_CONTROLLER_KEY, GtkEventControllerKeyClass))
Type GtkEventControllerKey AS _GtkEventControllerKey
Type GtkEventControllerKeyClass AS _GtkEventControllerKeyClass
Declare Function gtk_event_controller_key_get_type CDECL() AS GType
Declare Function gtk_event_controller_key_new CDECL() AS GtkEventController Ptr
Declare SUB gtk_event_controller_key_set_im_context CDECL(BYVAL AS GtkEventControllerKey Ptr, BYVAL AS GtkIMContext Ptr)
Declare Function gtk_event_controller_key_get_im_context CDECL(BYVAL AS GtkEventControllerKey Ptr) AS GtkIMContext Ptr
Declare Function gtk_event_controller_key_forward CDECL(BYVAL AS GtkEventControllerKey Ptr, BYVAL AS GtkWidget Ptr) AS gboolean
Declare Function gtk_event_controller_key_get_group CDECL(BYVAL AS GtkEventControllerKey Ptr) AS guint

#DEFINE GTK_TYPE_EVENT_CONTROLLER_LEGACY (gtk_event_controller_legacy_get_type ())
#DEFINE GTK_EVENT_CONTROLLER_LEGACY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_EVENT_CONTROLLER_LEGACY, GtkEventControllerLegacy))
#DEFINE GTK_EVENT_CONTROLLER_LEGACY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_EVENT_CONTROLLER_LEGACY, GtkEventControllerLegacyClass))
#DEFINE GTK_IS_EVENT_CONTROLLER_LEGACY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_EVENT_CONTROLLER_LEGACY))
#DEFINE GTK_IS_EVENT_CONTROLLER_LEGACY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_EVENT_CONTROLLER_LEGACY))
#DEFINE GTK_EVENT_CONTROLLER_LEGACY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_EVENT_CONTROLLER_LEGACY, GtkEventControllerLegacyClass))
Type GtkEventControllerLegacy AS _GtkEventControllerLegacy
Type GtkEventControllerLegacyClass AS _GtkEventControllerLegacyClass
Declare Function gtk_event_controller_legacy_get_type CDECL() AS GType
Declare Function gtk_event_controller_legacy_new CDECL() AS GtkEventController Ptr

#DEFINE GTK_TYPE_EVENT_CONTROLLER_MOTION (gtk_event_controller_motion_get_type ())
#DEFINE GTK_EVENT_CONTROLLER_MOTION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_EVENT_CONTROLLER_MOTION, GtkEventControllerMotion))
#DEFINE GTK_EVENT_CONTROLLER_MOTION_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_EVENT_CONTROLLER_MOTION, GtkEventControllerMotionClass))
#DEFINE GTK_IS_EVENT_CONTROLLER_MOTION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_EVENT_CONTROLLER_MOTION))
#DEFINE GTK_IS_EVENT_CONTROLLER_MOTION_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_EVENT_CONTROLLER_MOTION))
#DEFINE GTK_EVENT_CONTROLLER_MOTION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_EVENT_CONTROLLER_MOTION, GtkEventControllerMotionClass))
Type GtkEventControllerMotion AS _GtkEventControllerMotion
Type GtkEventControllerMotionClass AS _GtkEventControllerMotionClass
Declare Function gtk_event_controller_motion_get_type CDECL() AS GType
Declare Function gtk_event_controller_motion_new CDECL() AS GtkEventController Ptr
Declare Function gtk_event_controller_motion_contains_pointer CDECL(BYVAL AS GtkEventControllerMotion Ptr) AS gboolean
Declare Function gtk_event_controller_motion_is_pointer CDECL(BYVAL AS GtkEventControllerMotion Ptr) AS gboolean

#DEFINE GTK_TYPE_EVENT_CONTROLLER_SCROLL (gtk_event_controller_scroll_get_type ())
#DEFINE GTK_EVENT_CONTROLLER_SCROLL(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_EVENT_CONTROLLER_SCROLL, GtkEventControllerScroll))
#DEFINE GTK_EVENT_CONTROLLER_SCROLL_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_EVENT_CONTROLLER_SCROLL, GtkEventControllerScrollClass))
#DEFINE GTK_IS_EVENT_CONTROLLER_SCROLL(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_EVENT_CONTROLLER_SCROLL))
#DEFINE GTK_IS_EVENT_CONTROLLER_SCROLL_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_EVENT_CONTROLLER_SCROLL))
#DEFINE GTK_EVENT_CONTROLLER_SCROLL_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_EVENT_CONTROLLER_SCROLL, GtkEventControllerScrollClass))
Type GtkEventControllerScroll AS _GtkEventControllerScroll
Type GtkEventControllerScrollClass AS _GtkEventControllerScrollClass
Enum GtkEventControllerScrollFlags_
	GTK_EVENT_CONTROLLER_SCROLL_NONE = 0
	GTK_EVENT_CONTROLLER_SCROLL_VERTICAL = 1  SHL 0
	GTK_EVENT_CONTROLLER_SCROLL_HORIZONTAL = 1  SHL 1
	GTK_EVENT_CONTROLLER_SCROLL_DISCRETE = 1  SHL 2
	GTK_EVENT_CONTROLLER_SCROLL_KINETIC = 1  SHL 3
	GTK_EVENT_CONTROLLER_SCROLL_BOTH_AXES = (GTK_EVENT_CONTROLLER_SCROLL_VERTICAL  OR  GTK_EVENT_CONTROLLER_SCROLL_HORIZONTAL)
End Enum
Type AS LONG GtkEventControllerScrollFlags
Declare Function gtk_event_controller_scroll_get_type CDECL() AS GType
Declare Function gtk_event_controller_scroll_new CDECL(BYVAL AS GtkEventControllerScrollFlags) AS GtkEventController Ptr
Declare SUB gtk_event_controller_scroll_set_flags CDECL(BYVAL AS GtkEventControllerScroll Ptr, BYVAL AS GtkEventControllerScrollFlags)
Declare Function gtk_event_controller_scroll_get_flags CDECL(BYVAL AS GtkEventControllerScroll Ptr) AS GtkEventControllerScrollFlags
Declare Function gtk_event_controller_scroll_get_unit CDECL(BYVAL AS GtkEventControllerScroll Ptr) AS GdkScrollUnit

#DEFINE GTK_TYPE_EXPANDER (gtk_expander_get_type ())
#DEFINE GTK_EXPANDER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_EXPANDER, GtkExpander))
#DEFINE GTK_IS_EXPANDER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_EXPANDER))
Type GtkExpander AS _GtkExpander
Declare Function gtk_expander_get_type CDECL() AS GType
Declare Function gtk_expander_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_expander_new_with_mnemonic CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_expander_set_expanded CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS gboolean)
Declare Function gtk_expander_get_expanded CDECL(BYVAL AS GtkExpander Ptr) AS gboolean
Declare SUB gtk_expander_set_label CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_expander_get_label CDECL(BYVAL AS GtkExpander Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_expander_set_use_underline CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS gboolean)
Declare Function gtk_expander_get_use_underline CDECL(BYVAL AS GtkExpander Ptr) AS gboolean
Declare SUB gtk_expander_set_use_markup CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS gboolean)
Declare Function gtk_expander_get_use_markup CDECL(BYVAL AS GtkExpander Ptr) AS gboolean
Declare SUB gtk_expander_set_label_widget CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_expander_get_label_widget CDECL(BYVAL AS GtkExpander Ptr) AS GtkWidget Ptr
Declare SUB gtk_expander_set_resize_toplevel CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS gboolean)
Declare Function gtk_expander_get_resize_toplevel CDECL(BYVAL AS GtkExpander Ptr) AS gboolean
Declare SUB gtk_expander_set_child CDECL(BYVAL AS GtkExpander Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_expander_get_child CDECL(BYVAL AS GtkExpander Ptr) AS GtkWidget Ptr

#DEFINE GTK_TYPE_FIXED (gtk_fixed_get_type ())
#DEFINE GTK_FIXED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FIXED, GtkFixed))
#DEFINE GTK_FIXED_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FIXED, GtkFixedClass))
#DEFINE GTK_IS_FIXED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FIXED))
#DEFINE GTK_IS_FIXED_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FIXED))
#DEFINE GTK_FIXED_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FIXED, GtkFixedClass))
Type GtkFixed AS _GtkFixed
Type GtkFixedClass AS _GtkFixedClass
Type _GtkFixed
	AS GtkWidget parent_instance
End Type
Type _GtkFixedClass
	AS GtkWidgetClass parent_class
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_fixed_get_type CDECL() AS GType
Declare Function gtk_fixed_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_fixed_put CDECL(BYVAL AS GtkFixed Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_fixed_remove CDECL(BYVAL AS GtkFixed Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_fixed_move CDECL(BYVAL AS GtkFixed Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_fixed_get_child_position CDECL(BYVAL AS GtkFixed Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare SUB gtk_fixed_set_child_transform CDECL(BYVAL AS GtkFixed Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GskTransform Ptr)
Declare Function gtk_fixed_get_child_transform CDECL(BYVAL AS GtkFixed Ptr, BYVAL AS GtkWidget Ptr) AS GskTransform Ptr

#DEFINE GTK_TYPE_FIXED_LAYOUT (gtk_fixed_layout_get_type ())
#DEFINE GTK_TYPE_FIXED_LAYOUT_CHILD (gtk_fixed_layout_child_get_type ())
Type GtkFixedLayout AS _GtkFixedLayout
Declare Function gtk_fixed_layout_new CDECL() AS GtkLayoutManager Ptr
Type GtkFixedLayoutChild AS _GtkFixedLayoutChild
Declare SUB gtk_fixed_layout_child_set_transform CDECL(BYVAL AS GtkFixedLayoutChild Ptr, BYVAL AS GskTransform Ptr)
Declare Function gtk_fixed_layout_child_get_transform CDECL(BYVAL AS GtkFixedLayoutChild Ptr) AS GskTransform Ptr

#DEFINE GTK_TYPE_FILE_FILTER (gtk_file_filter_get_type ())
#DEFINE GTK_FILE_FILTER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FILE_FILTER, GtkFileFilter))
#DEFINE GTK_IS_FILE_FILTER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FILE_FILTER))
Type GtkFileFilter AS _GtkFileFilter
Declare Function gtk_file_filter_get_type CDECL() AS GType
Declare Function gtk_file_filter_new CDECL() AS GtkFileFilter Ptr
Declare SUB gtk_file_filter_set_name CDECL(BYVAL AS GtkFileFilter Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_file_filter_get_name CDECL(BYVAL AS GtkFileFilter Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_file_filter_add_mime_type CDECL(BYVAL AS GtkFileFilter Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_file_filter_add_pattern CDECL(BYVAL AS GtkFileFilter Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_file_filter_add_suffix CDECL(BYVAL AS GtkFileFilter Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_file_filter_add_pixbuf_formats CDECL(BYVAL AS GtkFileFilter Ptr)
Declare Function gtk_file_filter_get_attributes CDECL(BYVAL AS GtkFileFilter Ptr) AS Const ZSTRING Ptr Ptr
Declare Function gtk_file_filter_to_gvariant CDECL(BYVAL AS GtkFileFilter Ptr) AS GVariant Ptr
Declare Function gtk_file_filter_new_from_gvariant CDECL(BYVAL AS GVariant Ptr) AS GtkFileFilter Ptr


#DEFINE GTK_TYPE_FILE_DIALOG (gtk_file_dialog_get_type ())
Type GtkFileDialog AS _GtkFileDialog
Declare Function gtk_file_dialog_new CDECL() AS GtkFileDialog Ptr
Declare Function gtk_file_dialog_get_title CDECL(BYVAL AS GtkFileDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_file_dialog_set_title CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_file_dialog_get_modal CDECL(BYVAL AS GtkFileDialog Ptr) AS gboolean
Declare SUB gtk_file_dialog_set_modal CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_file_dialog_get_filters CDECL(BYVAL AS GtkFileDialog Ptr) AS GListModel Ptr
Declare SUB gtk_file_dialog_set_filters CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_file_dialog_get_default_filter CDECL(BYVAL AS GtkFileDialog Ptr) AS GtkFileFilter Ptr
Declare SUB gtk_file_dialog_set_default_filter CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkFileFilter Ptr)
Declare Function gtk_file_dialog_get_initial_folder CDECL(BYVAL AS GtkFileDialog Ptr) AS GFile Ptr
Declare SUB gtk_file_dialog_set_initial_folder CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GFile Ptr)
Declare Function gtk_file_dialog_get_initial_name CDECL(BYVAL AS GtkFileDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_file_dialog_set_initial_name CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_file_dialog_get_initial_file CDECL(BYVAL AS GtkFileDialog Ptr) AS GFile Ptr
Declare SUB gtk_file_dialog_set_initial_file CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GFile Ptr)
Declare Function gtk_file_dialog_get_accept_label CDECL(BYVAL AS GtkFileDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_file_dialog_set_accept_label CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_file_dialog_open CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_open_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GFile Ptr
Declare SUB gtk_file_dialog_select_folder CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_select_folder_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GFile Ptr
Declare SUB gtk_file_dialog_save CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_save_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GFile Ptr
Declare SUB gtk_file_dialog_open_multiple CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_open_multiple_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GListModel Ptr
Declare SUB gtk_file_dialog_select_multiple_folders CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_select_multiple_folders_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GListModel Ptr
Declare SUB gtk_file_dialog_open_text_file CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_open_text_file_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS GFile Ptr
Declare SUB gtk_file_dialog_open_multiple_text_files CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_open_multiple_text_files_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS GListModel Ptr
Declare SUB gtk_file_dialog_save_text_file CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_dialog_save_text_file_finish CDECL(BYVAL AS GtkFileDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS GError Ptr Ptr) AS GFile Ptr

#DEFINE GTK_TYPE_FILE_LAUNCHER (gtk_file_launcher_get_type ())
Type GtkFileLauncher AS _GtkFileLauncher
Declare Function gtk_file_launcher_new CDECL(BYVAL AS GFile Ptr) AS GtkFileLauncher Ptr
Declare Function gtk_file_launcher_get_file CDECL(BYVAL AS GtkFileLauncher Ptr) AS GFile Ptr
Declare SUB gtk_file_launcher_set_file CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS GFile Ptr)
Declare Function gtk_file_launcher_get_always_ask CDECL(BYVAL AS GtkFileLauncher Ptr) AS gboolean
Declare SUB gtk_file_launcher_set_always_ask CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS gboolean)
Declare Function gtk_file_launcher_get_writable CDECL(BYVAL AS GtkFileLauncher Ptr) AS gboolean
Declare SUB gtk_file_launcher_set_writable CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS gboolean)
Declare SUB gtk_file_launcher_launch CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_launcher_launch_finish CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare SUB gtk_file_launcher_open_containing_folder CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_file_launcher_open_containing_folder_finish CDECL(BYVAL AS GtkFileLauncher Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean


#DEFINE GTK_TYPE_FILTER_LIST_MODEL (gtk_filter_list_model_get_type ())
Type GtkFilterListModel AS _GtkFilterListModel
Declare Function gtk_filter_list_model_new CDECL(BYVAL AS GListModel Ptr, BYVAL AS GtkFilter Ptr) AS GtkFilterListModel Ptr
Declare SUB gtk_filter_list_model_set_filter CDECL(BYVAL AS GtkFilterListModel Ptr, BYVAL AS GtkFilter Ptr)
Declare Function gtk_filter_list_model_get_filter CDECL(BYVAL AS GtkFilterListModel Ptr) AS GtkFilter Ptr
Declare SUB gtk_filter_list_model_set_model CDECL(BYVAL AS GtkFilterListModel Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_filter_list_model_get_model CDECL(BYVAL AS GtkFilterListModel Ptr) AS GListModel Ptr
Declare SUB gtk_filter_list_model_set_incremental CDECL(BYVAL AS GtkFilterListModel Ptr, BYVAL AS gboolean)
Declare Function gtk_filter_list_model_get_incremental CDECL(BYVAL AS GtkFilterListModel Ptr) AS gboolean
Declare Function gtk_filter_list_model_get_pending CDECL(BYVAL AS GtkFilterListModel Ptr) AS guint

Type GtkCustomFilterFunc AS Function CDECL(BYVAL AS gpointer, BYVAL AS gpointer) AS gboolean
#DEFINE GTK_TYPE_CUSTOM_FILTER (gtk_custom_filter_get_type ())
Type GtkCustomFilter AS _GtkCustomFilter
Declare Function gtk_custom_filter_new CDECL(BYVAL AS GtkCustomFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GtkCustomFilter Ptr
Declare SUB gtk_custom_filter_set_filter_func CDECL(BYVAL AS GtkCustomFilter Ptr, BYVAL AS GtkCustomFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)


#DEFINE GTK_TYPE_FLATTEN_LIST_MODEL (gtk_flatten_list_model_get_type ())
Type GtkFlattenListModel AS _GtkFlattenListModel
Declare Function gtk_flatten_list_model_new CDECL(BYVAL AS GListModel Ptr) AS GtkFlattenListModel Ptr
Declare SUB gtk_flatten_list_model_set_model CDECL(BYVAL AS GtkFlattenListModel Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_flatten_list_model_get_model CDECL(BYVAL AS GtkFlattenListModel Ptr) AS GListModel Ptr
Declare Function gtk_flatten_list_model_get_model_for_item CDECL(BYVAL AS GtkFlattenListModel Ptr, BYVAL AS guint) AS GListModel Ptr

#DEFINE GTK_TYPE_FLOW_BOX (gtk_flow_box_get_type ())
#DEFINE GTK_FLOW_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FLOW_BOX, GtkFlowBox))
#DEFINE GTK_IS_FLOW_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FLOW_BOX))
Type GtkFlowBox AS _GtkFlowBox
Type GtkFlowBoxChild AS _GtkFlowBoxChild
Type GtkFlowBoxChildClass AS _GtkFlowBoxChildClass
#DEFINE GTK_TYPE_FLOW_BOX_CHILD (gtk_flow_box_child_get_type ())
#DEFINE GTK_FLOW_BOX_CHILD(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FLOW_BOX_CHILD, GtkFlowBoxChild))
#DEFINE GTK_FLOW_BOX_CHILD_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FLOW_BOX_CHILD, GtkFlowBoxChildClass))
#DEFINE GTK_IS_FLOW_BOX_CHILD(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FLOW_BOX_CHILD))
#DEFINE GTK_IS_FLOW_BOX_CHILD_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FLOW_BOX_CHILD))
#DEFINE GTK_FLOW_BOX_CHILD_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EG_TYPE_FLOW_BOX_CHILD, GtkFlowBoxChildClass))
Type _GtkFlowBoxChild
	AS GtkWidget parent_instance
End Type
Type _GtkFlowBoxChildClass
	AS GtkWidgetClass parent_class
	activate AS SUB CDECL(BYVAL AS GtkFlowBoxChild Ptr)
	AS gpointer padding(0 TO 8-1)
End Type
Type GtkFlowBoxCreateWidgetFunc AS Function CDECL(BYVAL AS gpointer, BYVAL AS gpointer) AS GtkWidget Ptr
Declare Function gtk_flow_box_child_get_type CDECL() AS GType
Declare Function gtk_flow_box_child_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_flow_box_child_set_child CDECL(BYVAL AS GtkFlowBoxChild Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_flow_box_child_get_child CDECL(BYVAL AS GtkFlowBoxChild Ptr) AS GtkWidget Ptr
Declare Function gtk_flow_box_child_get_index CDECL(BYVAL AS GtkFlowBoxChild Ptr) AS LONG
Declare Function gtk_flow_box_child_is_selected CDECL(BYVAL AS GtkFlowBoxChild Ptr) AS gboolean
Declare SUB gtk_flow_box_child_changed CDECL(BYVAL AS GtkFlowBoxChild Ptr)
Declare Function gtk_flow_box_get_type CDECL() AS GType
Declare Function gtk_flow_box_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_flow_box_bind_model CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GListModel Ptr, BYVAL AS GtkFlowBoxCreateWidgetFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_flow_box_set_homogeneous CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS gboolean)
Declare Function gtk_flow_box_get_homogeneous CDECL(BYVAL AS GtkFlowBox Ptr) AS gboolean
Declare SUB gtk_flow_box_set_row_spacing CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS guint)
Declare Function gtk_flow_box_get_row_spacing CDECL(BYVAL AS GtkFlowBox Ptr) AS guint
Declare SUB gtk_flow_box_set_column_spacing CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS guint)
Declare Function gtk_flow_box_get_column_spacing CDECL(BYVAL AS GtkFlowBox Ptr) AS guint
Declare SUB gtk_flow_box_set_min_children_per_line CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS guint)
Declare Function gtk_flow_box_get_min_children_per_line CDECL(BYVAL AS GtkFlowBox Ptr) AS guint
Declare SUB gtk_flow_box_set_max_children_per_line CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS guint)
Declare Function gtk_flow_box_get_max_children_per_line CDECL(BYVAL AS GtkFlowBox Ptr) AS guint
Declare SUB gtk_flow_box_set_activate_on_single_click CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS gboolean)
Declare Function gtk_flow_box_get_activate_on_single_click CDECL(BYVAL AS GtkFlowBox Ptr) AS gboolean
Declare SUB gtk_flow_box_prepend CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_flow_box_append CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_flow_box_insert CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare SUB gtk_flow_box_remove CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_flow_box_remove_all CDECL(BYVAL AS GtkFlowBox Ptr)
Declare Function gtk_flow_box_get_child_at_index CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS LONG) AS GtkFlowBoxChild Ptr
Declare Function gtk_flow_box_get_child_at_pos CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS LONG, BYVAL AS LONG) AS GtkFlowBoxChild Ptr
Type GtkFlowBoxForeachFunc AS SUB CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkFlowBoxChild Ptr, BYVAL AS gpointer)
Declare SUB gtk_flow_box_selected_foreach CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkFlowBoxForeachFunc, BYVAL AS gpointer)
Declare Function gtk_flow_box_get_selected_children CDECL(BYVAL AS GtkFlowBox Ptr) AS GList Ptr
Declare SUB gtk_flow_box_select_child CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkFlowBoxChild Ptr)
Declare SUB gtk_flow_box_unselect_child CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkFlowBoxChild Ptr)
Declare SUB gtk_flow_box_select_all CDECL(BYVAL AS GtkFlowBox Ptr)
Declare SUB gtk_flow_box_unselect_all CDECL(BYVAL AS GtkFlowBox Ptr)
Declare SUB gtk_flow_box_set_selection_mode CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkSelectionMode)
Declare Function gtk_flow_box_get_selection_mode CDECL(BYVAL AS GtkFlowBox Ptr) AS GtkSelectionMode
Declare SUB gtk_flow_box_set_hadjustment CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkAdjustment Ptr)
Declare SUB gtk_flow_box_set_vadjustment CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkAdjustment Ptr)
Type GtkFlowBoxFilterFunc AS Function CDECL(BYVAL AS GtkFlowBoxChild Ptr, BYVAL AS gpointer) AS gboolean
Declare SUB gtk_flow_box_set_filter_func CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkFlowBoxFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_flow_box_invalidate_filter CDECL(BYVAL AS GtkFlowBox Ptr)
Type GtkFlowBoxSortFunc AS Function CDECL(BYVAL AS GtkFlowBoxChild Ptr, BYVAL AS GtkFlowBoxChild Ptr, BYVAL AS gpointer) AS LONG
Declare SUB gtk_flow_box_set_sort_func CDECL(BYVAL AS GtkFlowBox Ptr, BYVAL AS GtkFlowBoxSortFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_flow_box_invalidate_sort CDECL(BYVAL AS GtkFlowBox Ptr)


#DEFINE GTK_TYPE_FONT_DIALOG (gtk_font_dialog_get_type ())
Type GtkFontDialog AS _GtkFontDialog
Declare Function gtk_font_dialog_new CDECL() AS GtkFontDialog Ptr
Declare Function gtk_font_dialog_get_title CDECL(BYVAL AS GtkFontDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_font_dialog_set_title CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_font_dialog_get_modal CDECL(BYVAL AS GtkFontDialog Ptr) AS gboolean
Declare SUB gtk_font_dialog_set_modal CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_font_dialog_get_language CDECL(BYVAL AS GtkFontDialog Ptr) AS PangoLanguage Ptr
Declare SUB gtk_font_dialog_set_language CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS PangoLanguage Ptr)
Declare Function gtk_font_dialog_get_font_map CDECL(BYVAL AS GtkFontDialog Ptr) AS PangoFontMap Ptr
Declare SUB gtk_font_dialog_set_font_map CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS PangoFontMap Ptr)
Declare Function gtk_font_dialog_get_filter CDECL(BYVAL AS GtkFontDialog Ptr) AS GtkFilter Ptr
Declare SUB gtk_font_dialog_set_filter CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GtkFilter Ptr)
Declare SUB gtk_font_dialog_choose_family CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS PangoFontFamily Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_font_dialog_choose_family_finish CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS PangoFontFamily Ptr
Declare SUB gtk_font_dialog_choose_face CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS PangoFontFace Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_font_dialog_choose_face_finish CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS PangoFontFace Ptr
Declare SUB gtk_font_dialog_choose_font CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS PangoFontDescription Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_font_dialog_choose_font_finish CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS PangoFontDescription Ptr
Declare SUB gtk_font_dialog_choose_font_and_features CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS PangoFontDescription Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_font_dialog_choose_font_and_features_finish CDECL(BYVAL AS GtkFontDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS PangoFontDescription Ptr Ptr, BYVAL AS ZSTRING Ptr Ptr, BYVAL AS PangoLanguage Ptr Ptr, BYVAL AS GError Ptr Ptr) AS gboolean


#DEFINE GTK_TYPE_FONT_DIALOG_BUTTON (gtk_font_dialog_button_get_type ())
Type GtkFontDialogButton AS _GtkFontDialogButton
Declare Function gtk_font_dialog_button_new CDECL(BYVAL AS GtkFontDialog Ptr) AS GtkWidget Ptr
Declare Function gtk_font_dialog_button_get_dialog CDECL(BYVAL AS GtkFontDialogButton Ptr) AS GtkFontDialog Ptr
Declare SUB gtk_font_dialog_button_set_dialog CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS GtkFontDialog Ptr)
Enum GtkFontLevel_
	GTK_FONT_LEVEL_FAMILY
	GTK_FONT_LEVEL_FACE
	GTK_FONT_LEVEL_FONT
	GTK_FONT_LEVEL_FEATURES
End Enum
Type AS LONG GtkFontLevel
Declare Function gtk_font_dialog_button_get_level CDECL(BYVAL AS GtkFontDialogButton Ptr) AS GtkFontLevel
Declare SUB gtk_font_dialog_button_set_level CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS GtkFontLevel)
Declare Function gtk_font_dialog_button_get_font_desc CDECL(BYVAL AS GtkFontDialogButton Ptr) AS PangoFontDescription Ptr
Declare SUB gtk_font_dialog_button_set_font_desc CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS Const PangoFontDescription Ptr)
Declare Function gtk_font_dialog_button_get_font_features CDECL(BYVAL AS GtkFontDialogButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_font_dialog_button_set_font_features CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_font_dialog_button_get_language CDECL(BYVAL AS GtkFontDialogButton Ptr) AS PangoLanguage Ptr
Declare SUB gtk_font_dialog_button_set_language CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS PangoLanguage Ptr)
Declare Function gtk_font_dialog_button_get_use_font CDECL(BYVAL AS GtkFontDialogButton Ptr) AS gboolean
Declare SUB gtk_font_dialog_button_set_use_font CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS gboolean)
Declare Function gtk_font_dialog_button_get_use_size CDECL(BYVAL AS GtkFontDialogButton Ptr) AS gboolean
Declare SUB gtk_font_dialog_button_set_use_size CDECL(BYVAL AS GtkFontDialogButton Ptr, BYVAL AS gboolean)


#DEFINE GTK_TYPE_FRAME (gtk_frame_get_type ())
#DEFINE GTK_FRAME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_FRAME, GtkFrame))
#DEFINE GTK_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_FRAME, GtkFrameClass))
#DEFINE GTK_IS_FRAME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_FRAME))
#DEFINE GTK_IS_FRAME_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_FRAME))
#DEFINE GTK_FRAME_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_FRAME, GtkFrameClass))
Type GtkFrame AS _GtkFrame
Type GtkFrameClass AS _GtkFrameClass
Type _GtkFrame
	AS GtkWidget parent_instance
End Type
Type _GtkFrameClass
	AS GtkWidgetClass parent_class
	compute_child_allocation AS SUB CDECL(BYVAL AS GtkFrame Ptr, BYVAL AS GtkAllocation Ptr)
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_frame_get_type CDECL() AS GType
Declare Function gtk_frame_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_frame_set_label CDECL(BYVAL AS GtkFrame Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_frame_get_label CDECL(BYVAL AS GtkFrame Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_frame_set_label_widget CDECL(BYVAL AS GtkFrame Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_frame_get_label_widget CDECL(BYVAL AS GtkFrame Ptr) AS GtkWidget Ptr
Declare SUB gtk_frame_set_label_align CDECL(BYVAL AS GtkFrame Ptr, BYVAL AS SINGLE)
Declare Function gtk_frame_get_label_align CDECL(BYVAL AS GtkFrame Ptr) AS SINGLE
Declare SUB gtk_frame_set_child CDECL(BYVAL AS GtkFrame Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_frame_get_child CDECL(BYVAL AS GtkFrame Ptr) AS GtkWidget Ptr

#DEFINE GTK_TYPE_GESTURE (gtk_gesture_get_type ())
#DEFINE GTK_GESTURE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE, GtkGesture))
#DEFINE GTK_GESTURE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE, GtkGestureClass))
#DEFINE GTK_IS_GESTURE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE))
#DEFINE GTK_IS_GESTURE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE))
#DEFINE GTK_GESTURE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE, GtkGestureClass))
Type GtkGestureClass AS _GtkGestureClass
Declare Function gtk_gesture_get_type CDECL() AS GType
Declare Function gtk_gesture_get_device CDECL(BYVAL AS GtkGesture Ptr) AS GdkDevice Ptr
Declare Function gtk_gesture_set_state CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GtkEventSequenceState) AS gboolean
Declare Function gtk_gesture_get_sequence_state CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GdkEventSequence Ptr) AS GtkEventSequenceState
Declare Function gtk_gesture_get_sequences CDECL(BYVAL AS GtkGesture Ptr) AS GList Ptr
Declare Function gtk_gesture_get_last_updated_sequence CDECL(BYVAL AS GtkGesture Ptr) AS GdkEventSequence Ptr
Declare Function gtk_gesture_handles_sequence CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GdkEventSequence Ptr) AS gboolean
Declare Function gtk_gesture_get_last_event CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GdkEventSequence Ptr) AS GdkEvent Ptr
Declare Function gtk_gesture_get_point CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GdkEventSequence Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gtk_gesture_get_bounding_box CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GdkRectangle Ptr) AS gboolean
Declare Function gtk_gesture_get_bounding_box_center CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gtk_gesture_is_active CDECL(BYVAL AS GtkGesture Ptr) AS gboolean
Declare Function gtk_gesture_is_recognized CDECL(BYVAL AS GtkGesture Ptr) AS gboolean
Declare SUB gtk_gesture_group CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GtkGesture Ptr)
Declare SUB gtk_gesture_ungroup CDECL(BYVAL AS GtkGesture Ptr)
Declare Function gtk_gesture_get_group CDECL(BYVAL AS GtkGesture Ptr) AS GList Ptr
Declare Function gtk_gesture_is_grouped_with CDECL(BYVAL AS GtkGesture Ptr, BYVAL AS GtkGesture Ptr) AS gboolean

#DEFINE GTK_TYPE_GESTURE_SINGLE (gtk_gesture_single_get_type ())
#DEFINE GTK_GESTURE_SINGLE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_SINGLE, GtkGestureSingle))
#DEFINE GTK_GESTURE_SINGLE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_SINGLE, GtkGestureSingleClass))
#DEFINE GTK_IS_GESTURE_SINGLE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_SINGLE))
#DEFINE GTK_IS_GESTURE_SINGLE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_SINGLE))
#DEFINE GTK_GESTURE_SINGLE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_SINGLE, GtkGestureSingleClass))
Type GtkGestureSingle AS _GtkGestureSingle
Type GtkGestureSingleClass AS _GtkGestureSingleClass
Declare Function gtk_gesture_single_get_type CDECL() AS GType
Declare Function gtk_gesture_single_get_touch_only CDECL(BYVAL AS GtkGestureSingle Ptr) AS gboolean
Declare SUB gtk_gesture_single_set_touch_only CDECL(BYVAL AS GtkGestureSingle Ptr, BYVAL AS gboolean)
Declare Function gtk_gesture_single_get_exclusive CDECL(BYVAL AS GtkGestureSingle Ptr) AS gboolean
Declare SUB gtk_gesture_single_set_exclusive CDECL(BYVAL AS GtkGestureSingle Ptr, BYVAL AS gboolean)
Declare Function gtk_gesture_single_get_button CDECL(BYVAL AS GtkGestureSingle Ptr) AS guint
Declare SUB gtk_gesture_single_set_button CDECL(BYVAL AS GtkGestureSingle Ptr, BYVAL AS guint)
Declare Function gtk_gesture_single_get_current_button CDECL(BYVAL AS GtkGestureSingle Ptr) AS guint
Declare Function gtk_gesture_single_get_current_sequence CDECL(BYVAL AS GtkGestureSingle Ptr) AS GdkEventSequence Ptr

#DEFINE GTK_TYPE_GESTURE_CLICK (gtk_gesture_click_get_type ())
#DEFINE GTK_GESTURE_CLICK(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_CLICK, GtkGestureClick))
#DEFINE GTK_GESTURE_CLICK_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_CLICK, GtkGestureClickClass))
#DEFINE GTK_IS_GESTURE_CLICK(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_CLICK))
#DEFINE GTK_IS_GESTURE_CLICK_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_CLICK))
#DEFINE GTK_GESTURE_CLICK_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_CLICK, GtkGestureClickClass))
Type GtkGestureClick AS _GtkGestureClick
Type GtkGestureClickClass AS _GtkGestureClickClass
Declare Function gtk_gesture_click_get_type CDECL() AS GType
Declare Function gtk_gesture_click_new CDECL() AS GtkGesture Ptr

#DEFINE GTK_TYPE_GESTURE_DRAG (gtk_gesture_drag_get_type ())
#DEFINE GTK_GESTURE_DRAG(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_DRAG, GtkGestureDrag))
#DEFINE GTK_GESTURE_DRAG_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_DRAG, GtkGestureDragClass))
#DEFINE GTK_IS_GESTURE_DRAG(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_DRAG))
#DEFINE GTK_IS_GESTURE_DRAG_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_DRAG))
#DEFINE GTK_GESTURE_DRAG_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_DRAG, GtkGestureDragClass))
Type GtkGestureDrag AS _GtkGestureDrag
Type GtkGestureDragClass AS _GtkGestureDragClass
Declare Function gtk_gesture_drag_get_type CDECL() AS GType
Declare Function gtk_gesture_drag_new CDECL() AS GtkGesture Ptr
Declare Function gtk_gesture_drag_get_start_point CDECL(BYVAL AS GtkGestureDrag Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gtk_gesture_drag_get_offset CDECL(BYVAL AS GtkGestureDrag Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean


#DEFINE GTK_TYPE_GESTURE_LONG_PRESS (gtk_gesture_long_press_get_type ())
#DEFINE GTK_GESTURE_LONG_PRESS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_LONG_PRESS, GtkGestureLongPress))
#DEFINE GTK_GESTURE_LONG_PRESS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_LONG_PRESS, GtkGestureLongPressClass))
#DEFINE GTK_IS_GESTURE_LONG_PRESS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_LONG_PRESS))
#DEFINE GTK_IS_GESTURE_LONG_PRESS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_LONG_PRESS))
#DEFINE GTK_GESTURE_LONG_PRESS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_LONG_PRESS, GtkGestureLongPressClass))
Type GtkGestureLongPress AS _GtkGestureLongPress
Type GtkGestureLongPressClass AS _GtkGestureLongPressClass
Declare Function gtk_gesture_long_press_get_type CDECL() AS GType
Declare Function gtk_gesture_long_press_new CDECL() AS GtkGesture Ptr
Declare SUB gtk_gesture_long_press_set_delay_factor CDECL(BYVAL AS GtkGestureLongPress Ptr, BYVAL AS DOUBLE)
Declare Function gtk_gesture_long_press_get_delay_factor CDECL(BYVAL AS GtkGestureLongPress Ptr) AS DOUBLE

#DEFINE GTK_TYPE_GESTURE_PAN (gtk_gesture_pan_get_type ())
#DEFINE GTK_GESTURE_PAN(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_PAN, GtkGesturePan))
#DEFINE GTK_GESTURE_PAN_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_PAN, GtkGesturePanClass))
#DEFINE GTK_IS_GESTURE_PAN(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_PAN))
#DEFINE GTK_IS_GESTURE_PAN_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_PAN))
#DEFINE GTK_GESTURE_PAN_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_PAN, GtkGesturePanClass))
Type GtkGesturePan AS _GtkGesturePan
Type GtkGesturePanClass AS _GtkGesturePanClass
Declare Function gtk_gesture_pan_get_type CDECL() AS GType
Declare Function gtk_gesture_pan_new CDECL(BYVAL AS GtkOrientation) AS GtkGesture Ptr
Declare Function gtk_gesture_pan_get_orientation CDECL(BYVAL AS GtkGesturePan Ptr) AS GtkOrientation
Declare SUB gtk_gesture_pan_set_orientation CDECL(BYVAL AS GtkGesturePan Ptr, BYVAL AS GtkOrientation)


#DEFINE GTK_TYPE_GESTURE_ROTATE (gtk_gesture_rotate_get_type ())
#DEFINE GTK_GESTURE_ROTATE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_ROTATE, GtkGestureRotate))
#DEFINE GTK_GESTURE_ROTATE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_ROTATE, GtkGestureRotateClass))
#DEFINE GTK_IS_GESTURE_ROTATE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_ROTATE))
#DEFINE GTK_IS_GESTURE_ROTATE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_ROTATE))
#DEFINE GTK_GESTURE_ROTATE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_ROTATE, GtkGestureRotateClass))
Type GtkGestureRotate AS _GtkGestureRotate
Type GtkGestureRotateClass AS _GtkGestureRotateClass
Declare Function gtk_gesture_rotate_get_type CDECL() AS GType
Declare Function gtk_gesture_rotate_new CDECL() AS GtkGesture Ptr
Declare Function gtk_gesture_rotate_get_angle_delta CDECL(BYVAL AS GtkGestureRotate Ptr) AS DOUBLE

#DEFINE GTK_TYPE_GESTURE_STYLUS (gtk_gesture_stylus_get_type ())
#DEFINE GTK_GESTURE_STYLUS(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_STYLUS, GtkGestureStylus))
#DEFINE GTK_GESTURE_STYLUS_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_STYLUS, GtkGestureStylusClass))
#DEFINE GTK_IS_GESTURE_STYLUS(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_STYLUS))
#DEFINE GTK_IS_GESTURE_STYLUS_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_STYLUS))
#DEFINE GTK_GESTURE_STYLUS_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_STYLUS, GtkGestureStylusClass))
Type GtkGestureStylus AS _GtkGestureStylus
Type GtkGestureStylusClass AS _GtkGestureStylusClass
Declare Function gtk_gesture_stylus_get_type CDECL() AS GType
Declare Function gtk_gesture_stylus_new CDECL() AS GtkGesture Ptr
Declare Function gtk_gesture_stylus_get_stylus_only CDECL(BYVAL AS GtkGestureStylus Ptr) AS gboolean
Declare SUB gtk_gesture_stylus_set_stylus_only CDECL(BYVAL AS GtkGestureStylus Ptr, BYVAL AS gboolean)
Declare Function gtk_gesture_stylus_get_axis CDECL(BYVAL AS GtkGestureStylus Ptr, BYVAL AS GdkAxisUse, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gtk_gesture_stylus_get_axes CDECL(BYVAL AS GtkGestureStylus Ptr, BYVAL AS GdkAxisUse Ptr, BYVAL AS DOUBLE Ptr Ptr) AS gboolean
Declare Function gtk_gesture_stylus_get_backlog CDECL(BYVAL AS GtkGestureStylus Ptr, BYVAL AS GdkTimeCoord Ptr Ptr, BYVAL AS guint Ptr) AS gboolean
Declare Function gtk_gesture_stylus_get_device_tool CDECL(BYVAL AS GtkGestureStylus Ptr) AS GdkDeviceTool Ptr


#DEFINE GTK_TYPE_GESTURE_SWIPE (gtk_gesture_swipe_get_type ())
#DEFINE GTK_GESTURE_SWIPE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_SWIPE, GtkGestureSwipe))
#DEFINE GTK_GESTURE_SWIPE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_SWIPE, GtkGestureSwipeClass))
#DEFINE GTK_IS_GESTURE_SWIPE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_SWIPE))
#DEFINE GTK_IS_GESTURE_SWIPE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_SWIPE))
#DEFINE GTK_GESTURE_SWIPE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_SWIPE, GtkGestureSwipeClass))
Type GtkGestureSwipe AS _GtkGestureSwipe
Type GtkGestureSwipeClass AS _GtkGestureSwipeClass
Declare Function gtk_gesture_swipe_get_type CDECL() AS GType
Declare Function gtk_gesture_swipe_new CDECL() AS GtkGesture Ptr
Declare Function gtk_gesture_swipe_get_velocity CDECL(BYVAL AS GtkGestureSwipe Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean

#DEFINE GTK_TYPE_GESTURE_ZOOM (gtk_gesture_zoom_get_type ())
#DEFINE GTK_GESTURE_ZOOM(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GESTURE_ZOOM, GtkGestureZoom))
#DEFINE GTK_GESTURE_ZOOM_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GESTURE_ZOOM, GtkGestureZoomClass))
#DEFINE GTK_IS_GESTURE_ZOOM(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GESTURE_ZOOM))
#DEFINE GTK_IS_GESTURE_ZOOM_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GESTURE_ZOOM))
#DEFINE GTK_GESTURE_ZOOM_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GESTURE_ZOOM, GtkGestureZoomClass))
Type GtkGestureZoom AS _GtkGestureZoom
Type GtkGestureZoomClass AS _GtkGestureZoomClass
Declare Function gtk_gesture_zoom_get_type CDECL() AS GType
Declare Function gtk_gesture_zoom_new CDECL() AS GtkGesture Ptr
Declare Function gtk_gesture_zoom_get_scale_delta CDECL(BYVAL AS GtkGestureZoom Ptr) AS DOUBLE


#DEFINE GTK_TYPE_GL_AREA (gtk_gl_area_get_type ())
#DEFINE GTK_GL_AREA(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_GL_AREA, GtkGLArea))
#DEFINE GTK_IS_GL_AREA(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_GL_AREA))
#DEFINE GTK_GL_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_GL_AREA, GtkGLAreaClass))
#DEFINE GTK_IS_GL_AREA_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_GL_AREA))
#DEFINE GTK_GL_AREA_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_GL_AREA, GtkGLAreaClass))
Type GtkGLArea AS _GtkGLArea
Type GtkGLAreaClass AS _GtkGLAreaClass
Type _GtkGLArea
	AS GtkWidget parent_instance
End Type
Type _GtkGLAreaClass
	AS GtkWidgetClass parent_class
	render AS Function CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS GdkGLContext Ptr) AS gboolean
	resize AS SUB CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS LONG, BYVAL AS LONG)
	create_context AS Function CDECL(BYVAL AS GtkGLArea Ptr) AS GdkGLContext Ptr
	AS gpointer _padding(0 TO 8-1)
End Type
Declare Function gtk_gl_area_get_type CDECL() AS GType
Declare Function gtk_gl_area_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_gl_area_set_allowed_apis CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS GdkGLAPI)
Declare Function gtk_gl_area_get_allowed_apis CDECL(BYVAL AS GtkGLArea Ptr) AS GdkGLAPI
Declare Function gtk_gl_area_get_api CDECL(BYVAL AS GtkGLArea Ptr) AS GdkGLAPI
Declare SUB gtk_gl_area_set_required_version CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_gl_area_get_required_version CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Function gtk_gl_area_get_has_depth_buffer CDECL(BYVAL AS GtkGLArea Ptr) AS gboolean
Declare SUB gtk_gl_area_set_has_depth_buffer CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS gboolean)
Declare Function gtk_gl_area_get_has_stencil_buffer CDECL(BYVAL AS GtkGLArea Ptr) AS gboolean
Declare SUB gtk_gl_area_set_has_stencil_buffer CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS gboolean)
Declare Function gtk_gl_area_get_auto_render CDECL(BYVAL AS GtkGLArea Ptr) AS gboolean
Declare SUB gtk_gl_area_set_auto_render CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS gboolean)
Declare SUB gtk_gl_area_queue_render CDECL(BYVAL AS GtkGLArea Ptr)
Declare Function gtk_gl_area_get_context CDECL(BYVAL AS GtkGLArea Ptr) AS GdkGLContext Ptr
Declare SUB gtk_gl_area_make_current CDECL(BYVAL AS GtkGLArea Ptr)
Declare SUB gtk_gl_area_attach_buffers CDECL(BYVAL AS GtkGLArea Ptr)
Declare SUB gtk_gl_area_set_error CDECL(BYVAL AS GtkGLArea Ptr, BYVAL AS Const GError Ptr)
Declare Function gtk_gl_area_get_error CDECL(BYVAL AS GtkGLArea Ptr) AS GError Ptr


#DEFINE GTK_TYPE_GRAPHICS_OFFLOAD (gtk_graphics_offload_get_type ())

Type GtkGraphicsOffload AS _GtkGraphicsOffload
Declare Function gtk_graphics_offload_new CDECL(BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare SUB gtk_graphics_offload_set_child CDECL(BYVAL AS GtkGraphicsOffload Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_graphics_offload_get_child CDECL(BYVAL AS GtkGraphicsOffload Ptr) AS GtkWidget Ptr
Enum GtkGraphicsOffloadEnabled_
	GTK_GRAPHICS_OFFLOAD_ENABLED
	GTK_GRAPHICS_OFFLOAD_DISABLED
End Enum
Type AS LONG GtkGraphicsOffloadEnabled
Declare SUB gtk_graphics_offload_set_enabled CDECL(BYVAL AS GtkGraphicsOffload Ptr, BYVAL AS GtkGraphicsOffloadEnabled)
Declare Function gtk_graphics_offload_get_enabled CDECL(BYVAL AS GtkGraphicsOffload Ptr) AS GtkGraphicsOffloadEnabled
Declare SUB gtk_graphics_offload_set_black_background CDECL(BYVAL AS GtkGraphicsOffload Ptr, BYVAL AS gboolean)
Declare Function gtk_graphics_offload_get_black_background CDECL(BYVAL AS GtkGraphicsOffload Ptr) AS gboolean

#DEFINE GTK_TYPE_GRID (gtk_grid_get_type ())
#DEFINE GTK_GRID(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_GRID, GtkGrid))
#DEFINE GTK_GRID_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_GRID, GtkGridClass))
#DEFINE GTK_IS_GRID(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_GRID))
#DEFINE GTK_IS_GRID_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_GRID))
#DEFINE GTK_GRID_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_GRID, GtkGridClass))
Type GtkGrid AS _GtkGrid
Type GtkGridClass AS _GtkGridClass
Type _GtkGrid
	AS GtkWidget parent_instance
End Type
Type _GtkGridClass
	AS GtkWidgetClass parent_class
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_grid_get_type CDECL() AS GType
Declare Function gtk_grid_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_grid_attach CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_grid_attach_next_to CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget, BYVAL AS GtkPositionType, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_grid_get_child_at CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG, BYVAL AS LONG) AS GtkWidget Ptr
Declare SUB gtk_grid_remove CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_grid_insert_row CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG)
Declare SUB gtk_grid_insert_column CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG)
Declare SUB gtk_grid_remove_row CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG)
Declare SUB gtk_grid_remove_column CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG)
Declare SUB gtk_grid_insert_next_to CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkPositionType)
Declare SUB gtk_grid_set_row_homogeneous CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS gboolean)
Declare Function gtk_grid_get_row_homogeneous CDECL(BYVAL AS GtkGrid Ptr) AS gboolean
Declare SUB gtk_grid_set_row_spacing CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS guint)
Declare Function gtk_grid_get_row_spacing CDECL(BYVAL AS GtkGrid Ptr) AS guint
Declare SUB gtk_grid_set_column_homogeneous CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS gboolean)
Declare Function gtk_grid_get_column_homogeneous CDECL(BYVAL AS GtkGrid Ptr) AS gboolean
Declare SUB gtk_grid_set_column_spacing CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS guint)
Declare Function gtk_grid_get_column_spacing CDECL(BYVAL AS GtkGrid Ptr) AS guint
Declare SUB gtk_grid_set_row_baseline_position CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG, BYVAL AS GtkBaselinePosition)
Declare Function gtk_grid_get_row_baseline_position CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG) AS GtkBaselinePosition
Declare SUB gtk_grid_set_baseline_row CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS LONG)
Declare Function gtk_grid_get_baseline_row CDECL(BYVAL AS GtkGrid Ptr) AS LONG
Declare SUB gtk_grid_query_child CDECL(BYVAL AS GtkGrid Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)


#DEFINE GTK_TYPE_GRID_LAYOUT (gtk_grid_layout_get_type ())
#DEFINE GTK_TYPE_GRID_LAYOUT_CHILD (gtk_grid_layout_child_get_type ())
Type GtkGridLayout AS _GtkGridLayout
Declare Function gtk_grid_layout_new CDECL() AS GtkLayoutManager Ptr
Declare SUB gtk_grid_layout_set_row_homogeneous CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS gboolean)
Declare Function gtk_grid_layout_get_row_homogeneous CDECL(BYVAL AS GtkGridLayout Ptr) AS gboolean
Declare SUB gtk_grid_layout_set_row_spacing CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS guint)
Declare Function gtk_grid_layout_get_row_spacing CDECL(BYVAL AS GtkGridLayout Ptr) AS guint
Declare SUB gtk_grid_layout_set_column_homogeneous CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS gboolean)
Declare Function gtk_grid_layout_get_column_homogeneous CDECL(BYVAL AS GtkGridLayout Ptr) AS gboolean
Declare SUB gtk_grid_layout_set_column_spacing CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS guint)
Declare Function gtk_grid_layout_get_column_spacing CDECL(BYVAL AS GtkGridLayout Ptr) AS guint
Declare SUB gtk_grid_layout_set_row_baseline_position CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS LONG, BYVAL AS GtkBaselinePosition)
Declare Function gtk_grid_layout_get_row_baseline_position CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS LONG) AS GtkBaselinePosition
Declare SUB gtk_grid_layout_set_baseline_row CDECL(BYVAL AS GtkGridLayout Ptr, BYVAL AS LONG)
Declare Function gtk_grid_layout_get_baseline_row CDECL(BYVAL AS GtkGridLayout Ptr) AS LONG
Type GtkGridLayoutChild AS _GtkGridLayoutChild
Declare SUB gtk_grid_layout_child_set_row CDECL(BYVAL AS GtkGridLayoutChild Ptr, BYVAL AS LONG)
Declare Function gtk_grid_layout_child_get_row CDECL(BYVAL AS GtkGridLayoutChild Ptr) AS LONG
Declare SUB gtk_grid_layout_child_set_column CDECL(BYVAL AS GtkGridLayoutChild Ptr, BYVAL AS LONG)
Declare Function gtk_grid_layout_child_get_column CDECL(BYVAL AS GtkGridLayoutChild Ptr) AS LONG
Declare SUB gtk_grid_layout_child_set_column_span CDECL(BYVAL AS GtkGridLayoutChild Ptr, BYVAL AS LONG)
Declare Function gtk_grid_layout_child_get_column_span CDECL(BYVAL AS GtkGridLayoutChild Ptr) AS LONG
Declare SUB gtk_grid_layout_child_set_row_span CDECL(BYVAL AS GtkGridLayoutChild Ptr, BYVAL AS LONG)
Declare Function gtk_grid_layout_child_get_row_span CDECL(BYVAL AS GtkGridLayoutChild Ptr) AS LONG

#DEFINE GTK_TYPE_LIST_BASE (gtk_list_base_get_type ())
#DEFINE GTK_LIST_BASE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_LIST_BASE, GtkListBase))
#DEFINE GTK_LIST_BASE_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_LIST_BASE, GtkListBaseClass))
#DEFINE GTK_IS_LIST_BASE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_LIST_BASE))
#DEFINE GTK_IS_LIST_BASE_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_LIST_BASE))
#DEFINE GTK_LIST_BASE_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_LIST_BASE, GtkListBaseClass))
Type GtkListBase AS _GtkListBase
Type GtkListBaseClass AS _GtkListBaseClass
Declare Function gtk_list_base_get_type CDECL() AS GType


#DEFINE GTK_TYPE_GRID_VIEW (gtk_grid_view_get_type ())
#DEFINE GTK_GRID_VIEW(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_GRID_VIEW, GtkGridView))
#DEFINE GTK_GRID_VIEW_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_GRID_VIEW, GtkGridViewClass))
#DEFINE GTK_IS_GRID_VIEW(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_GRID_VIEW))
#DEFINE GTK_IS_GRID_VIEW_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_GRID_VIEW))
#DEFINE GTK_GRID_VIEW_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_GRID_VIEW, GtkGridViewClass))
Type GtkGridView AS _GtkGridView
Type GtkGridViewClass AS _GtkGridViewClass
Declare Function gtk_grid_view_get_type CDECL() AS GType
Declare Function gtk_grid_view_new CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS GtkListItemFactory Ptr) AS GtkWidget Ptr
Declare Function gtk_grid_view_get_model CDECL(BYVAL AS GtkGridView Ptr) AS GtkSelectionModel Ptr
Declare SUB gtk_grid_view_set_model CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS GtkSelectionModel Ptr)
Declare SUB gtk_grid_view_set_factory CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_grid_view_get_factory CDECL(BYVAL AS GtkGridView Ptr) AS GtkListItemFactory Ptr
Declare Function gtk_grid_view_get_min_columns CDECL(BYVAL AS GtkGridView Ptr) AS guint
Declare SUB gtk_grid_view_set_min_columns CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS guint)
Declare Function gtk_grid_view_get_max_columns CDECL(BYVAL AS GtkGridView Ptr) AS guint
Declare SUB gtk_grid_view_set_max_columns CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS guint)
Declare SUB gtk_grid_view_set_enable_rubberband CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS gboolean)
Declare Function gtk_grid_view_get_enable_rubberband CDECL(BYVAL AS GtkGridView Ptr) AS gboolean
Declare SUB gtk_grid_view_set_tab_behavior CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS GtkListTabBehavior)
Declare Function gtk_grid_view_get_tab_behavior CDECL(BYVAL AS GtkGridView Ptr) AS GtkListTabBehavior
Declare SUB gtk_grid_view_set_single_click_activate CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS gboolean)
Declare Function gtk_grid_view_get_single_click_activate CDECL(BYVAL AS GtkGridView Ptr) AS gboolean
Declare SUB gtk_grid_view_scroll_to CDECL(BYVAL AS GtkGridView Ptr, BYVAL AS guint, BYVAL AS GtkListScrollFlags, BYVAL AS GtkScrollInfo Ptr)


#DEFINE GTK_TYPE_HEADER_BAR (gtk_header_bar_get_type ())
#DEFINE GTK_HEADER_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_HEADER_BAR, GtkHeaderBar))
#DEFINE GTK_IS_HEADER_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_HEADER_BAR))
Type GtkHeaderBar AS _GtkHeaderBar
Declare Function gtk_header_bar_get_type CDECL() AS GType
Declare Function gtk_header_bar_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_header_bar_set_title_widget CDECL(BYVAL AS GtkHeaderBar Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_header_bar_get_title_widget CDECL(BYVAL AS GtkHeaderBar Ptr) AS GtkWidget Ptr
Declare SUB gtk_header_bar_pack_start CDECL(BYVAL AS GtkHeaderBar Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_header_bar_pack_end CDECL(BYVAL AS GtkHeaderBar Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_header_bar_remove CDECL(BYVAL AS GtkHeaderBar Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_header_bar_get_show_title_buttons CDECL(BYVAL AS GtkHeaderBar Ptr) AS gboolean
Declare SUB gtk_header_bar_set_show_title_buttons CDECL(BYVAL AS GtkHeaderBar Ptr, BYVAL AS gboolean)
Declare SUB gtk_header_bar_set_decoration_layout CDECL(BYVAL AS GtkHeaderBar Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_header_bar_get_decoration_layout CDECL(BYVAL AS GtkHeaderBar Ptr) AS Const ZSTRING Ptr


#DEFINE GTK_TYPE_ICON_PAINTABLE (gtk_icon_paintable_get_type ())
#DEFINE GTK_ICON_PAINTABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ICON_PAINTABLE, GtkIconPaintable))
#DEFINE GTK_IS_ICON_PAINTABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ICON_PAINTABLE))
#DEFINE GTK_TYPE_ICON_THEME (gtk_icon_theme_get_type ())
#DEFINE GTK_ICON_THEME(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ICON_THEME, GtkIconTheme))
#DEFINE GTK_IS_ICON_THEME(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ICON_THEME))
Type GtkIconPaintable AS _GtkIconPaintable
Type GtkIconTheme AS _GtkIconTheme
Enum GtkIconLookupFlags_
	GTK_ICON_LOOKUP_NONE = 0
	GTK_ICON_LOOKUP_FORCE_REGULAR = 1  SHL 0
	GTK_ICON_LOOKUP_FORCE_SYMBOLIC = 1  SHL 1
	GTK_ICON_LOOKUP_PRELOAD = 1  SHL 2
End Enum
Type AS LONG GtkIconLookupFlags

#DEFINE GTK_ICON_THEME_ERROR gtk_icon_theme_error_quark ()
Enum GtkIconThemeError_
	GTK_ICON_THEME_NOT_FOUND
	GTK_ICON_THEME_FAILED
End Enum
Type AS LONG GtkIconThemeError
Declare Function gtk_icon_theme_error_quark CDECL() AS GQuark
Declare Function gtk_icon_theme_get_type CDECL() AS GType
Declare Function gtk_icon_theme_new CDECL() AS GtkIconTheme Ptr
Declare Function gtk_icon_theme_get_for_display CDECL(BYVAL AS GdkDisplay Ptr) AS GtkIconTheme Ptr
Declare Function gtk_icon_theme_get_display CDECL(BYVAL AS GtkIconTheme Ptr) AS GdkDisplay Ptr
Declare SUB gtk_icon_theme_set_search_path CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Const Ptr Ptr)
Declare Function gtk_icon_theme_get_search_path CDECL(BYVAL AS GtkIconTheme Ptr) AS ZSTRING Ptr Ptr
Declare SUB gtk_icon_theme_add_search_path CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_icon_theme_set_resource_path CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Const Ptr Ptr)
Declare Function gtk_icon_theme_get_resource_path CDECL(BYVAL AS GtkIconTheme Ptr) AS ZSTRING Ptr Ptr
Declare SUB gtk_icon_theme_add_resource_path CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_icon_theme_set_theme_name CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_icon_theme_get_theme_name CDECL(BYVAL AS GtkIconTheme Ptr) AS ZSTRING Ptr
Declare Function gtk_icon_theme_has_icon CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_icon_theme_has_gicon CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS GIcon Ptr) AS gboolean
Declare Function gtk_icon_theme_get_icon_sizes CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Ptr) AS LONG Ptr
Declare Function gtk_icon_theme_lookup_icon CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GtkTextDirection, BYVAL AS GtkIconLookupFlags) AS GtkIconPaintable Ptr
Declare Function gtk_icon_theme_lookup_by_gicon CDECL(BYVAL AS GtkIconTheme Ptr, BYVAL AS GIcon Ptr, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS GtkTextDirection, BYVAL AS GtkIconLookupFlags) AS GtkIconPaintable Ptr
Declare Function gtk_icon_paintable_new_for_file CDECL(BYVAL AS GFile Ptr, BYVAL AS LONG, BYVAL AS LONG) AS GtkIconPaintable Ptr
Declare Function gtk_icon_theme_get_icon_names CDECL(BYVAL AS GtkIconTheme Ptr) AS ZSTRING Ptr Ptr
Declare Function gtk_icon_paintable_get_type CDECL() AS GType
Declare Function gtk_icon_paintable_get_file CDECL(BYVAL AS GtkIconPaintable Ptr) AS GFile Ptr
Declare Function gtk_icon_paintable_get_icon_name CDECL(BYVAL AS GtkIconPaintable Ptr) AS Const ZSTRING Ptr
Declare Function gtk_icon_paintable_is_symbolic CDECL(BYVAL AS GtkIconPaintable Ptr) AS gboolean


#DEFINE GTK_MAX_COMPOSE_LEN 7
#DEFINE GTK_TYPE_IM_CONTEXT_SIMPLE (gtk_im_context_simple_get_type ())
#DEFINE GTK_IM_CONTEXT_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimple))
#DEFINE GTK_IM_CONTEXT_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass))
#DEFINE GTK_IS_IM_CONTEXT_SIMPLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_CONTEXT_SIMPLE))
#DEFINE GTK_IS_IM_CONTEXT_SIMPLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_CONTEXT_SIMPLE))
#DEFINE GTK_IM_CONTEXT_SIMPLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_CONTEXT_SIMPLE, GtkIMContextSimpleClass))

Type GtkIMContextSimple AS _GtkIMContextSimple
Type GtkIMContextSimplePrivate AS _GtkIMContextSimplePrivate
Type GtkIMContextSimpleClass AS _GtkIMContextSimpleClass

Type _GtkIMContextSimple
	AS GtkIMContext object
	AS GtkIMContextSimplePrivate Ptr priv
End Type

Type _GtkIMContextSimpleClass
	AS GtkIMContextClass parent_class
End Type

Declare Function gtk_im_context_simple_get_type CDECL() AS GType
Declare Function gtk_im_context_simple_new CDECL() AS GtkIMContext Ptr
Declare SUB gtk_im_context_simple_add_compose_file CDECL(BYVAL AS GtkIMContextSimple Ptr, BYVAL AS Const ZSTRING Ptr)


#DEFINE GTK_TYPE_IM_MULTICONTEXT (gtk_im_multicontext_get_type ())
#DEFINE GTK_IM_MULTICONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontext))
#DEFINE GTK_IM_MULTICONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass))
#DEFINE GTK_IS_IM_MULTICONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_IM_MULTICONTEXT))
#DEFINE GTK_IS_IM_MULTICONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_IM_MULTICONTEXT))
#DEFINE GTK_IM_MULTICONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_IM_MULTICONTEXT, GtkIMMulticontextClass))

Type GtkIMMulticontext AS _GtkIMMulticontext
Type GtkIMMulticontextClass AS _GtkIMMulticontextClass
Type GtkIMMulticontextPrivate AS _GtkIMMulticontextPrivate

Type _GtkIMMulticontext
	AS GtkIMContext object
	AS GtkIMMulticontextPrivate Ptr priv
End Type

Type _GtkIMMulticontextClass
	AS GtkIMContextClass parent_class
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type

Declare Function gtk_im_multicontext_get_type CDECL() AS GType
Declare Function gtk_im_multicontext_new CDECL() AS GtkIMContext Ptr
Declare Function gtk_im_multicontext_get_context_id CDECL(BYVAL AS GtkIMMulticontext Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_im_multicontext_set_context_id CDECL(BYVAL AS GtkIMMulticontext Ptr, BYVAL AS Const ZSTRING Ptr)


#DEFINE GTK_TYPE_INSCRIPTION (gtk_inscription_get_type ())

Enum GtkInscriptionOverflow_
	GTK_INSCRIPTION_OVERFLOW_CLIP
	GTK_INSCRIPTION_OVERFLOW_ELLIPSIZE_START
	GTK_INSCRIPTION_OVERFLOW_ELLIPSIZE_MIDDLE
	GTK_INSCRIPTION_OVERFLOW_ELLIPSIZE_END
End Enum
Type AS LONG GtkInscriptionOverflow

Type GtkInscription AS _GtkInscription
Declare Function gtk_inscription_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_inscription_get_text CDECL(BYVAL AS GtkInscription Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_inscription_set_text CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_inscription_get_attributes CDECL(BYVAL AS GtkInscription Ptr) AS PangoAttrList Ptr
Declare SUB gtk_inscription_set_attributes CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS PangoAttrList Ptr)
Declare SUB gtk_inscription_set_markup CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_inscription_get_text_overflow CDECL(BYVAL AS GtkInscription Ptr) AS GtkInscriptionOverflow
Declare SUB gtk_inscription_set_text_overflow CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS GtkInscriptionOverflow)
Declare Function gtk_inscription_get_wrap_mode CDECL(BYVAL AS GtkInscription Ptr) AS PangoWrapMode
Declare SUB gtk_inscription_set_wrap_mode CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS PangoWrapMode)
Declare Function gtk_inscription_get_min_chars CDECL(BYVAL AS GtkInscription Ptr) AS guint
Declare SUB gtk_inscription_set_min_chars CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS guint)
Declare Function gtk_inscription_get_nat_chars CDECL(BYVAL AS GtkInscription Ptr) AS guint
Declare SUB gtk_inscription_set_nat_chars CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS guint)
Declare Function gtk_inscription_get_min_lines CDECL(BYVAL AS GtkInscription Ptr) AS guint
Declare SUB gtk_inscription_set_min_lines CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS guint)
Declare Function gtk_inscription_get_nat_lines CDECL(BYVAL AS GtkInscription Ptr) AS guint
Declare SUB gtk_inscription_set_nat_lines CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS guint)
Declare Function gtk_inscription_get_xalign CDECL(BYVAL AS GtkInscription Ptr) AS SINGLE
Declare SUB gtk_inscription_set_xalign CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS SINGLE)
Declare Function gtk_inscription_get_yalign CDECL(BYVAL AS GtkInscription Ptr) AS SINGLE
Declare SUB gtk_inscription_set_yalign CDECL(BYVAL AS GtkInscription Ptr, BYVAL AS SINGLE)

#DEFINE GTK_TYPE_LABEL (gtk_label_get_type ())
#DEFINE GTK_LABEL(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LABEL, GtkLabel))
#DEFINE GTK_IS_LABEL(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LABEL))
Type GtkLabel AS _GtkLabel
Declare Function gtk_label_get_type CDECL() AS GType
Declare Function gtk_label_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_label_new_with_mnemonic CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_label_set_text CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_label_get_text CDECL(BYVAL AS GtkLabel Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_label_set_attributes CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS PangoAttrList Ptr)
Declare Function gtk_label_get_attributes CDECL(BYVAL AS GtkLabel Ptr) AS PangoAttrList Ptr
Declare SUB gtk_label_set_label CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_label_get_label CDECL(BYVAL AS GtkLabel Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_label_set_markup CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_label_set_use_markup CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS gboolean)
Declare Function gtk_label_get_use_markup CDECL(BYVAL AS GtkLabel Ptr) AS gboolean
Declare SUB gtk_label_set_use_underline CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS gboolean)
Declare Function gtk_label_get_use_underline CDECL(BYVAL AS GtkLabel Ptr) AS gboolean
Declare SUB gtk_label_set_markup_with_mnemonic CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_label_get_mnemonic_keyval CDECL(BYVAL AS GtkLabel Ptr) AS guint
Declare SUB gtk_label_set_mnemonic_widget CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_label_get_mnemonic_widget CDECL(BYVAL AS GtkLabel Ptr) AS GtkWidget Ptr
Declare SUB gtk_label_set_text_with_mnemonic CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_label_set_justify CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS GtkJustification)
Declare Function gtk_label_get_justify CDECL(BYVAL AS GtkLabel Ptr) AS GtkJustification
Declare SUB gtk_label_set_ellipsize CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS PangoEllipsizeMode)
Declare Function gtk_label_get_ellipsize CDECL(BYVAL AS GtkLabel Ptr) AS PangoEllipsizeMode
Declare SUB gtk_label_set_width_chars CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS LONG)
Declare Function gtk_label_get_width_chars CDECL(BYVAL AS GtkLabel Ptr) AS LONG
Declare SUB gtk_label_set_max_width_chars CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS LONG)
Declare Function gtk_label_get_max_width_chars CDECL(BYVAL AS GtkLabel Ptr) AS LONG
Declare SUB gtk_label_set_lines CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS LONG)
Declare Function gtk_label_get_lines CDECL(BYVAL AS GtkLabel Ptr) AS LONG
Declare SUB gtk_label_set_wrap CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS gboolean)
Declare Function gtk_label_get_wrap CDECL(BYVAL AS GtkLabel Ptr) AS gboolean
Declare SUB gtk_label_set_wrap_mode CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS PangoWrapMode)
Declare Function gtk_label_get_wrap_mode CDECL(BYVAL AS GtkLabel Ptr) AS PangoWrapMode
Declare SUB gtk_label_set_natural_wrap_mode CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS GtkNaturalWrapMode)
Declare Function gtk_label_get_natural_wrap_mode CDECL(BYVAL AS GtkLabel Ptr) AS GtkNaturalWrapMode
Declare SUB gtk_label_set_selectable CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS gboolean)
Declare Function gtk_label_get_selectable CDECL(BYVAL AS GtkLabel Ptr) AS gboolean
Declare SUB gtk_label_select_region CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_label_get_selection_bounds CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr) AS gboolean
Declare Function gtk_label_get_layout CDECL(BYVAL AS GtkLabel Ptr) AS PangoLayout Ptr
Declare SUB gtk_label_get_layout_offsets CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_label_set_single_line_mode CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS gboolean)
Declare Function gtk_label_get_single_line_mode CDECL(BYVAL AS GtkLabel Ptr) AS gboolean
Declare Function gtk_label_get_current_uri CDECL(BYVAL AS GtkLabel Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_label_set_xalign CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS SINGLE)
Declare Function gtk_label_get_xalign CDECL(BYVAL AS GtkLabel Ptr) AS SINGLE
Declare SUB gtk_label_set_yalign CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS SINGLE)
Declare Function gtk_label_get_yalign CDECL(BYVAL AS GtkLabel Ptr) AS SINGLE
Declare SUB gtk_label_set_extra_menu CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_label_get_extra_menu CDECL(BYVAL AS GtkLabel Ptr) AS GMenuModel Ptr
Declare SUB gtk_label_set_tabs CDECL(BYVAL AS GtkLabel Ptr, BYVAL AS PangoTabArray Ptr)
Declare Function gtk_label_get_tabs CDECL(BYVAL AS GtkLabel Ptr) AS PangoTabArray Ptr


#DEFINE GTK_TYPE_LEVEL_BAR (gtk_level_bar_get_type ())
#DEFINE GTK_LEVEL_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LEVEL_BAR, GtkLevelBar))
#DEFINE GTK_IS_LEVEL_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LEVEL_BAR))
#DEFINE GTK_LEVEL_BAR_OFFSET_LOW @!"low"
#DEFINE GTK_LEVEL_BAR_OFFSET_HIGH @!"high"
#DEFINE GTK_LEVEL_BAR_OFFSET_FULL @!"full"
Type GtkLevelBar AS _GtkLevelBar
Declare Function gtk_level_bar_get_type CDECL() AS GType
Declare Function gtk_level_bar_new CDECL() AS GtkWidget Ptr
Declare Function gtk_level_bar_new_for_interval CDECL(BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GtkWidget Ptr
Declare SUB gtk_level_bar_set_mode CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS GtkLevelBarMode)
Declare Function gtk_level_bar_get_mode CDECL(BYVAL AS GtkLevelBar Ptr) AS GtkLevelBarMode
Declare SUB gtk_level_bar_set_value CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS DOUBLE)
Declare Function gtk_level_bar_get_value CDECL(BYVAL AS GtkLevelBar Ptr) AS DOUBLE
Declare SUB gtk_level_bar_set_min_value CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS DOUBLE)
Declare Function gtk_level_bar_get_min_value CDECL(BYVAL AS GtkLevelBar Ptr) AS DOUBLE
Declare SUB gtk_level_bar_set_max_value CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS DOUBLE)
Declare Function gtk_level_bar_get_max_value CDECL(BYVAL AS GtkLevelBar Ptr) AS DOUBLE
Declare SUB gtk_level_bar_set_inverted CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS gboolean)
Declare Function gtk_level_bar_get_inverted CDECL(BYVAL AS GtkLevelBar Ptr) AS gboolean
Declare SUB gtk_level_bar_add_offset_value CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_level_bar_remove_offset_value CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_level_bar_get_offset_value CDECL(BYVAL AS GtkLevelBar Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE Ptr) AS gboolean


#DEFINE GTK_TYPE_LINK_BUTTON (gtk_link_button_get_type ())
#DEFINE GTK_LINK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LINK_BUTTON, GtkLinkButton))
#DEFINE GTK_IS_LINK_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LINK_BUTTON))
Type GtkLinkButton AS _GtkLinkButton
Declare Function gtk_link_button_get_type CDECL() AS GType
Declare Function gtk_link_button_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_link_button_new_with_label CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_link_button_get_uri CDECL(BYVAL AS GtkLinkButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_link_button_set_uri CDECL(BYVAL AS GtkLinkButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_link_button_get_visited CDECL(BYVAL AS GtkLinkButton Ptr) AS gboolean
Declare SUB gtk_link_button_set_visited CDECL(BYVAL AS GtkLinkButton Ptr, BYVAL AS gboolean)

#DEFINE GTK_TYPE_LIST_BOX (gtk_list_box_get_type ())
#DEFINE GTK_LIST_BOX(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LIST_BOX, GtkListBox))
#DEFINE GTK_IS_LIST_BOX(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LIST_BOX))
Type GtkListBox AS _GtkListBox
Type GtkListBoxRow AS _GtkListBoxRow
Type GtkListBoxRowClass AS _GtkListBoxRowClass

#DEFINE GTK_TYPE_LIST_BOX_ROW (gtk_list_box_row_get_type ())
#DEFINE GTK_LIST_BOX_ROW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_LIST_BOX_ROW, GtkListBoxRow))
#DEFINE GTK_LIST_BOX_ROW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_LIST_BOX_ROW, GtkListBoxRowClass))
#DEFINE GTK_IS_LIST_BOX_ROW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_LIST_BOX_ROW))
#DEFINE GTK_IS_LIST_BOX_ROW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_LIST_BOX_ROW))
#DEFINE GTK_LIST_BOX_ROW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_LIST_BOX_ROW, GtkListBoxRowClass))
Type _GtkListBoxRow
	AS GtkWidget parent_instance
End Type
Type _GtkListBoxRowClass
	AS GtkWidgetClass parent_class
	activate AS SUB CDECL(BYVAL AS GtkListBoxRow Ptr)
	AS gpointer padding(0 TO 8-1)
End Type
Type GtkListBoxFilterFunc AS Function CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS gpointer) AS gboolean
Type GtkListBoxSortFunc AS Function CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS GtkListBoxRow Ptr, BYVAL AS gpointer) AS LONG
Type GtkListBoxUpdateHeaderFunc AS SUB CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS GtkListBoxRow Ptr, BYVAL AS gpointer)
Type GtkListBoxCreateWidgetFunc AS Function CDECL(BYVAL AS gpointer, BYVAL AS gpointer) AS GtkWidget Ptr
Declare Function gtk_list_box_row_get_type CDECL() AS GType
Declare Function gtk_list_box_row_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_list_box_row_set_child CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_list_box_row_get_child CDECL(BYVAL AS GtkListBoxRow Ptr) AS GtkWidget Ptr
Declare Function gtk_list_box_row_get_header CDECL(BYVAL AS GtkListBoxRow Ptr) AS GtkWidget Ptr
Declare SUB gtk_list_box_row_set_header CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_list_box_row_get_index CDECL(BYVAL AS GtkListBoxRow Ptr) AS LONG
Declare SUB gtk_list_box_row_changed CDECL(BYVAL AS GtkListBoxRow Ptr)
Declare Function gtk_list_box_row_is_selected CDECL(BYVAL AS GtkListBoxRow Ptr) AS gboolean
Declare SUB gtk_list_box_row_set_selectable CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS gboolean)
Declare Function gtk_list_box_row_get_selectable CDECL(BYVAL AS GtkListBoxRow Ptr) AS gboolean
Declare SUB gtk_list_box_row_set_activatable CDECL(BYVAL AS GtkListBoxRow Ptr, BYVAL AS gboolean)
Declare Function gtk_list_box_row_get_activatable CDECL(BYVAL AS GtkListBoxRow Ptr) AS gboolean
Declare Function gtk_list_box_get_type CDECL() AS GType
Declare SUB gtk_list_box_prepend CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_list_box_append CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_list_box_insert CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare SUB gtk_list_box_remove CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_list_box_remove_all CDECL(BYVAL AS GtkListBox Ptr)
Declare Function gtk_list_box_get_selected_row CDECL(BYVAL AS GtkListBox Ptr) AS GtkListBoxRow Ptr
Declare Function gtk_list_box_get_row_at_index CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS LONG) AS GtkListBoxRow Ptr
Declare Function gtk_list_box_get_row_at_y CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS LONG) AS GtkListBoxRow Ptr
Declare SUB gtk_list_box_select_row CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxRow Ptr)
Declare SUB gtk_list_box_set_placeholder CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_list_box_set_adjustment CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_list_box_get_adjustment CDECL(BYVAL AS GtkListBox Ptr) AS GtkAdjustment Ptr
Type GtkListBoxForeachFunc AS SUB CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxRow Ptr, BYVAL AS gpointer)
Declare SUB gtk_list_box_selected_foreach CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxForeachFunc, BYVAL AS gpointer)
Declare Function gtk_list_box_get_selected_rows CDECL(BYVAL AS GtkListBox Ptr) AS GList Ptr
Declare SUB gtk_list_box_unselect_row CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxRow Ptr)
Declare SUB gtk_list_box_select_all CDECL(BYVAL AS GtkListBox Ptr)
Declare SUB gtk_list_box_unselect_all CDECL(BYVAL AS GtkListBox Ptr)
Declare SUB gtk_list_box_set_selection_mode CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkSelectionMode)
Declare Function gtk_list_box_get_selection_mode CDECL(BYVAL AS GtkListBox Ptr) AS GtkSelectionMode
Declare SUB gtk_list_box_set_filter_func CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxFilterFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_list_box_set_header_func CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxUpdateHeaderFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_list_box_invalidate_filter CDECL(BYVAL AS GtkListBox Ptr)
Declare SUB gtk_list_box_invalidate_sort CDECL(BYVAL AS GtkListBox Ptr)
Declare SUB gtk_list_box_invalidate_headers CDECL(BYVAL AS GtkListBox Ptr)
Declare SUB gtk_list_box_set_sort_func CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxSortFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_list_box_set_activate_on_single_click CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS gboolean)
Declare Function gtk_list_box_get_activate_on_single_click CDECL(BYVAL AS GtkListBox Ptr) AS gboolean
Declare SUB gtk_list_box_drag_unhighlight_row CDECL(BYVAL AS GtkListBox Ptr)
Declare SUB gtk_list_box_drag_highlight_row CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListBoxRow Ptr)
Declare Function gtk_list_box_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_list_box_bind_model CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GListModel Ptr, BYVAL AS GtkListBoxCreateWidgetFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_list_box_set_show_separators CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS gboolean)
Declare Function gtk_list_box_get_show_separators CDECL(BYVAL AS GtkListBox Ptr) AS gboolean
Declare SUB gtk_list_box_set_tab_behavior CDECL(BYVAL AS GtkListBox Ptr, BYVAL AS GtkListTabBehavior)
Declare Function gtk_list_box_get_tab_behavior CDECL(BYVAL AS GtkListBox Ptr) AS GtkListTabBehavior

#DEFINE GTK_TYPE_LIST_HEADER (gtk_list_header_get_type ())
Type GtkListHeader AS _GtkListHeader
Declare Function gtk_list_header_get_item CDECL(BYVAL AS GtkListHeader Ptr) AS gpointer
Declare Function gtk_list_header_get_start CDECL(BYVAL AS GtkListHeader Ptr) AS guint
Declare Function gtk_list_header_get_end CDECL(BYVAL AS GtkListHeader Ptr) AS guint
Declare Function gtk_list_header_get_n_items CDECL(BYVAL AS GtkListHeader Ptr) AS guint
Declare SUB gtk_list_header_set_child CDECL(BYVAL AS GtkListHeader Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_list_header_get_child CDECL(BYVAL AS GtkListHeader Ptr) AS GtkWidget Ptr


#DEFINE GTK_TYPE_LIST_VIEW (gtk_list_view_get_type ())
#DEFINE GTK_LIST_VIEW(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_LIST_VIEW, GtkListView))
#DEFINE GTK_LIST_VIEW_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_LIST_VIEW, GtkListViewClass))
#DEFINE GTK_IS_LIST_VIEW(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_LIST_VIEW))
#DEFINE GTK_IS_LIST_VIEW_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_LIST_VIEW))
#DEFINE GTK_LIST_VIEW_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_LIST_VIEW, GtkListViewClass))
Type GtkListView AS _GtkListView
Type GtkListViewClass AS _GtkListViewClass
Declare Function gtk_list_view_get_type CDECL() AS GType
Declare Function gtk_list_view_new CDECL(BYVAL AS GtkSelectionModel Ptr, BYVAL AS GtkListItemFactory Ptr) AS GtkWidget Ptr
Declare Function gtk_list_view_get_model CDECL(BYVAL AS GtkListView Ptr) AS GtkSelectionModel Ptr
Declare SUB gtk_list_view_set_model CDECL(BYVAL AS GtkListView Ptr, BYVAL AS GtkSelectionModel Ptr)
Declare SUB gtk_list_view_set_factory CDECL(BYVAL AS GtkListView Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_list_view_get_factory CDECL(BYVAL AS GtkListView Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_list_view_set_header_factory CDECL(BYVAL AS GtkListView Ptr, BYVAL AS GtkListItemFactory Ptr)
Declare Function gtk_list_view_get_header_factory CDECL(BYVAL AS GtkListView Ptr) AS GtkListItemFactory Ptr
Declare SUB gtk_list_view_set_show_separators CDECL(BYVAL AS GtkListView Ptr, BYVAL AS gboolean)
Declare Function gtk_list_view_get_show_separators CDECL(BYVAL AS GtkListView Ptr) AS gboolean
Declare SUB gtk_list_view_set_single_click_activate CDECL(BYVAL AS GtkListView Ptr, BYVAL AS gboolean)
Declare Function gtk_list_view_get_single_click_activate CDECL(BYVAL AS GtkListView Ptr) AS gboolean
Declare SUB gtk_list_view_set_enable_rubberband CDECL(BYVAL AS GtkListView Ptr, BYVAL AS gboolean)
Declare Function gtk_list_view_get_enable_rubberband CDECL(BYVAL AS GtkListView Ptr) AS gboolean
Declare SUB gtk_list_view_set_tab_behavior CDECL(BYVAL AS GtkListView Ptr, BYVAL AS GtkListTabBehavior)
Declare Function gtk_list_view_get_tab_behavior CDECL(BYVAL AS GtkListView Ptr) AS GtkListTabBehavior
Declare SUB gtk_list_view_scroll_to CDECL(BYVAL AS GtkListView Ptr, BYVAL AS guint, BYVAL AS GtkListScrollFlags, BYVAL AS GtkScrollInfo Ptr)


#DEFINE GTK_PRIORITY_RESIZE (G_PRIORITY_HIGH_IDLE + 10)
Declare SUB gtk_init CDECL()
Declare Function gtk_init_check CDECL() AS gboolean
Declare Function gtk_is_initialized CDECL() AS gboolean
Declare SUB gtk_init_abi_check CDECL(BYVAL AS LONG, BYVAL AS size_t, BYVAL AS size_t)
Declare Function gtk_init_check_abi_check CDECL(BYVAL AS LONG, BYVAL AS size_t, BYVAL AS size_t) AS gboolean

Declare SUB gtk_disable_setlocale CDECL()
Declare SUB gtk_disable_portals CDECL()
Declare Function gtk_get_default_language CDECL() AS PangoLanguage Ptr
Declare Function gtk_get_locale_direction CDECL() AS GtkTextDirection

#DEFINE GTK_TYPE_MAP_LIST_MODEL (gtk_map_list_model_get_type ())
Type GtkMapListModel AS _GtkMapListModel
Type GtkMapListModelMapFunc AS Function CDECL(BYVAL AS gpointer, BYVAL AS gpointer) AS gpointer
Declare Function gtk_map_list_model_new CDECL(BYVAL AS GListModel Ptr, BYVAL AS GtkMapListModelMapFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GtkMapListModel Ptr
Declare SUB gtk_map_list_model_set_map_func CDECL(BYVAL AS GtkMapListModel Ptr, BYVAL AS GtkMapListModelMapFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_map_list_model_set_model CDECL(BYVAL AS GtkMapListModel Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_map_list_model_get_model CDECL(BYVAL AS GtkMapListModel Ptr) AS GListModel Ptr
Declare Function gtk_map_list_model_has_map CDECL(BYVAL AS GtkMapListModel Ptr) AS gboolean

#DEFINE GTK_TYPE_MEDIA_STREAM (gtk_media_stream_get_type ())
Type GtkMediaStream AS _GtkMediaStream
Type GtkMediaStreamClass AS _GtkMediaStreamClass
Type _GtkMediaStreamClass
	AS GObjectClass parent_class
	play AS Function CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
	pause AS SUB CDECL(BYVAL AS GtkMediaStream Ptr)
	seek_ AS SUB CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gint64)
	update_audio AS SUB CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gboolean, BYVAL AS DOUBLE)
	realize AS SUB CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS GdkSurface Ptr)
	unrealize AS SUB CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS GdkSurface Ptr)
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
	_gtk_reserved5 AS SUB CDECL()
	_gtk_reserved6 AS SUB CDECL()
	_gtk_reserved7 AS SUB CDECL()
	_gtk_reserved8 AS SUB CDECL()
End Type

Declare Function gtk_media_stream_is_prepared CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare Function gtk_media_stream_get_error CDECL(BYVAL AS GtkMediaStream Ptr) AS Const GError Ptr
Declare Function gtk_media_stream_has_audio CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare Function gtk_media_stream_has_video CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare SUB gtk_media_stream_play CDECL(BYVAL AS GtkMediaStream Ptr)
Declare SUB gtk_media_stream_pause CDECL(BYVAL AS GtkMediaStream Ptr)
Declare Function gtk_media_stream_get_playing CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare SUB gtk_media_stream_set_playing CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gboolean)
Declare Function gtk_media_stream_get_ended CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare Function gtk_media_stream_get_timestamp CDECL(BYVAL AS GtkMediaStream Ptr) AS gint64
Declare Function gtk_media_stream_get_duration CDECL(BYVAL AS GtkMediaStream Ptr) AS gint64
Declare Function gtk_media_stream_is_seekable CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare Function gtk_media_stream_is_seeking CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare SUB gtk_media_stream_seek CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gint64)
Declare Function gtk_media_stream_get_loop CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare SUB gtk_media_stream_set_loop CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gboolean)
Declare Function gtk_media_stream_get_muted CDECL(BYVAL AS GtkMediaStream Ptr) AS gboolean
Declare SUB gtk_media_stream_set_muted CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gboolean)
Declare Function gtk_media_stream_get_volume CDECL(BYVAL AS GtkMediaStream Ptr) AS DOUBLE
Declare SUB gtk_media_stream_set_volume CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_media_stream_realize CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS GdkSurface Ptr)
Declare SUB gtk_media_stream_unrealize CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS GdkSurface Ptr)
Declare SUB gtk_media_stream_stream_prepared CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gint64)
Declare SUB gtk_media_stream_stream_unprepared CDECL(BYVAL AS GtkMediaStream Ptr)
Declare SUB gtk_media_stream_update CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS gint64)
Declare SUB gtk_media_stream_stream_ended CDECL(BYVAL AS GtkMediaStream Ptr)
Declare SUB gtk_media_stream_seek_success CDECL(BYVAL AS GtkMediaStream Ptr)
Declare SUB gtk_media_stream_seek_failed CDECL(BYVAL AS GtkMediaStream Ptr)
Declare SUB gtk_media_stream_gerror CDECL(BYVAL AS GtkMediaStream Ptr, BYVAL AS GError Ptr)

#DEFINE GTK_TYPE_MEDIA_CONTROLS (gtk_media_controls_get_type ())
Type GtkMediaControls AS _GtkMediaControls
Declare Function gtk_media_controls_new CDECL(BYVAL AS GtkMediaStream Ptr) AS GtkWidget Ptr
Declare Function gtk_media_controls_get_media_stream CDECL(BYVAL AS GtkMediaControls Ptr) AS GtkMediaStream Ptr
Declare SUB gtk_media_controls_set_media_stream CDECL(BYVAL AS GtkMediaControls Ptr, BYVAL AS GtkMediaStream Ptr)

#DEFINE GTK_MEDIA_FILE_EXTENSION_POINT_NAME @!"gtk-media-file"
#DEFINE GTK_TYPE_MEDIA_FILE (gtk_media_file_get_type ())
Type GtkMediaFile AS _GtkMediaFile
Type GtkMediaFileClass AS _GtkMediaFileClass
Type _GtkMediaFileClass
	AS GtkMediaStreamClass parent_class
	open_ AS SUB CDECL(BYVAL AS GtkMediaFile Ptr)
	close_ AS SUB CDECL(BYVAL AS GtkMediaFile Ptr)
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare Function gtk_media_file_new CDECL() AS GtkMediaStream Ptr
Declare Function gtk_media_file_new_for_filename CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkMediaStream Ptr
Declare Function gtk_media_file_new_for_resource CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkMediaStream Ptr
Declare Function gtk_media_file_new_for_file CDECL(BYVAL AS GFile Ptr) AS GtkMediaStream Ptr
Declare Function gtk_media_file_new_for_input_stream CDECL(BYVAL AS GInputStream Ptr) AS GtkMediaStream Ptr
Declare SUB gtk_media_file_clear CDECL(BYVAL AS GtkMediaFile Ptr)
Declare SUB gtk_media_file_set_filename CDECL(BYVAL AS GtkMediaFile Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_media_file_set_resource CDECL(BYVAL AS GtkMediaFile Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_media_file_set_file CDECL(BYVAL AS GtkMediaFile Ptr, BYVAL AS GFile Ptr)
Declare Function gtk_media_file_get_file CDECL(BYVAL AS GtkMediaFile Ptr) AS GFile Ptr
Declare SUB gtk_media_file_set_input_stream CDECL(BYVAL AS GtkMediaFile Ptr, BYVAL AS GInputStream Ptr)
Declare Function gtk_media_file_get_input_stream CDECL(BYVAL AS GtkMediaFile Ptr) AS GInputStream Ptr


#DEFINE GTK_TYPE_POPOVER (gtk_popover_get_type ())
#DEFINE GTK_POPOVER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_POPOVER, GtkPopover))
#DEFINE GTK_POPOVER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_POPOVER, GtkPopoverClass))
#DEFINE GTK_IS_POPOVER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_POPOVER))
#DEFINE GTK_IS_POPOVER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_POPOVER))
#DEFINE GTK_POPOVER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_POPOVER, GtkPopoverClass))
Type GtkPopover AS _GtkPopover
Type GtkPopoverClass AS _GtkPopoverClass
Type _GtkPopover
	AS GtkWidget parent
End Type
Type _GtkPopoverClass
	AS GtkWidgetClass parent_class
	closed AS SUB CDECL(BYVAL AS GtkPopover Ptr)
	activate_default AS SUB CDECL(BYVAL AS GtkPopover Ptr)
	AS gpointer reserved(0 TO 8-1)
End Type
Declare Function gtk_popover_get_type CDECL() AS GType
Declare Function gtk_popover_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_popover_set_child CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_popover_get_child CDECL(BYVAL AS GtkPopover Ptr) AS GtkWidget Ptr
Declare SUB gtk_popover_set_pointing_to CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS Const GdkRectangle Ptr)
Declare Function gtk_popover_get_pointing_to CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS GdkRectangle Ptr) AS gboolean
Declare SUB gtk_popover_set_position CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS GtkPositionType)
Declare Function gtk_popover_get_position CDECL(BYVAL AS GtkPopover Ptr) AS GtkPositionType
Declare SUB gtk_popover_set_autohide CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS gboolean)
Declare Function gtk_popover_get_autohide CDECL(BYVAL AS GtkPopover Ptr) AS gboolean
Declare SUB gtk_popover_set_has_arrow CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS gboolean)
Declare Function gtk_popover_get_has_arrow CDECL(BYVAL AS GtkPopover Ptr) AS gboolean
Declare SUB gtk_popover_set_mnemonics_visible CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS gboolean)
Declare Function gtk_popover_get_mnemonics_visible CDECL(BYVAL AS GtkPopover Ptr) AS gboolean
Declare SUB gtk_popover_popup CDECL(BYVAL AS GtkPopover Ptr)
Declare SUB gtk_popover_popdown CDECL(BYVAL AS GtkPopover Ptr)
Declare SUB gtk_popover_set_offset CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_popover_get_offset CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_popover_set_cascade_popdown CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS gboolean)
Declare Function gtk_popover_get_cascade_popdown CDECL(BYVAL AS GtkPopover Ptr) AS gboolean
Declare SUB gtk_popover_set_default_widget CDECL(BYVAL AS GtkPopover Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_popover_present CDECL(BYVAL AS GtkPopover Ptr)

#DEFINE GTK_TYPE_MENU_BUTTON (gtk_menu_button_get_type ())
#DEFINE GTK_MENU_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_MENU_BUTTON, GtkMenuButton))
#DEFINE GTK_IS_MENU_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_MENU_BUTTON))
Type GtkMenuButton AS _GtkMenuButton
Type GtkMenuButtonCreatePopupFunc AS SUB CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gpointer)
Declare Function gtk_menu_button_get_type CDECL() AS GType
Declare Function gtk_menu_button_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_menu_button_set_popover CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_menu_button_get_popover CDECL(BYVAL AS GtkMenuButton Ptr) AS GtkPopover Ptr
Declare SUB gtk_menu_button_set_direction CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS GtkArrowType)
Declare Function gtk_menu_button_get_direction CDECL(BYVAL AS GtkMenuButton Ptr) AS GtkArrowType
Declare SUB gtk_menu_button_set_menu_model CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_menu_button_get_menu_model CDECL(BYVAL AS GtkMenuButton Ptr) AS GMenuModel Ptr
Declare SUB gtk_menu_button_set_icon_name CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_menu_button_get_icon_name CDECL(BYVAL AS GtkMenuButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_menu_button_set_always_show_arrow CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gboolean)
Declare Function gtk_menu_button_get_always_show_arrow CDECL(BYVAL AS GtkMenuButton Ptr) AS gboolean
Declare SUB gtk_menu_button_set_label CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_menu_button_get_label CDECL(BYVAL AS GtkMenuButton Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_menu_button_set_use_underline CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gboolean)
Declare Function gtk_menu_button_get_use_underline CDECL(BYVAL AS GtkMenuButton Ptr) AS gboolean
Declare SUB gtk_menu_button_set_has_frame CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gboolean)
Declare Function gtk_menu_button_get_has_frame CDECL(BYVAL AS GtkMenuButton Ptr) AS gboolean
Declare SUB gtk_menu_button_popup CDECL(BYVAL AS GtkMenuButton Ptr)
Declare SUB gtk_menu_button_popdown CDECL(BYVAL AS GtkMenuButton Ptr)
Declare SUB gtk_menu_button_set_create_popup_func CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS GtkMenuButtonCreatePopupFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
Declare SUB gtk_menu_button_set_primary CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gboolean)
Declare Function gtk_menu_button_get_primary CDECL(BYVAL AS GtkMenuButton Ptr) AS gboolean
Declare SUB gtk_menu_button_set_child CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_menu_button_get_child CDECL(BYVAL AS GtkMenuButton Ptr) AS GtkWidget Ptr
Declare SUB gtk_menu_button_set_active CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gboolean)
Declare Function gtk_menu_button_get_active CDECL(BYVAL AS GtkMenuButton Ptr) AS gboolean
Declare SUB gtk_menu_button_set_can_shrink CDECL(BYVAL AS GtkMenuButton Ptr, BYVAL AS gboolean)
Declare Function gtk_menu_button_get_can_shrink CDECL(BYVAL AS GtkMenuButton Ptr) AS gboolean


#DEFINE GTK_TYPE_MOUNT_OPERATION (gtk_mount_operation_get_type ())
#DEFINE GTK_MOUNT_OPERATION(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_MOUNT_OPERATION, GtkMountOperation))
#DEFINE GTK_MOUNT_OPERATION_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), GTK_TYPE_MOUNT_OPERATION, GtkMountOperationClass))
#DEFINE GTK_IS_MOUNT_OPERATION(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_MOUNT_OPERATION))
#DEFINE GTK_IS_MOUNT_OPERATION_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_MOUNT_OPERATION))
#DEFINE GTK_MOUNT_OPERATION_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_MOUNT_OPERATION, GtkMountOperationClass))

Type GtkMountOperation AS _GtkMountOperation
Type GtkMountOperationClass AS _GtkMountOperationClass
Type GtkMountOperationPrivate AS _GtkMountOperationPrivate
Type _GtkMountOperation
	AS GMountOperation parent_instance
	AS GtkMountOperationPrivate Ptr priv
End Type
Type _GtkMountOperationClass
	AS GMountOperationClass parent_class
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare Function gtk_mount_operation_get_type CDECL() AS GType
Declare Function gtk_mount_operation_new CDECL(BYVAL AS GtkWindow Ptr) AS GMountOperation Ptr
Declare Function gtk_mount_operation_is_showing CDECL(BYVAL AS GtkMountOperation Ptr) AS gboolean
Declare SUB gtk_mount_operation_set_parent CDECL(BYVAL AS GtkMountOperation Ptr, BYVAL AS GtkWindow Ptr)
Declare Function gtk_mount_operation_get_parent CDECL(BYVAL AS GtkMountOperation Ptr) AS GtkWindow
Declare SUB gtk_mount_operation_set_display CDECL(BYVAL AS GtkMountOperation Ptr, BYVAL AS GdkDisplay Ptr)
Declare Function gtk_mount_operation_get_display CDECL(BYVAL AS GtkMountOperation Ptr) AS GdkDisplay Ptr


#DEFINE GTK_TYPE_MULTI_FILTER (gtk_multi_filter_get_type ())
Type GtkMultiFilter AS _GtkMultiFilter
Declare SUB gtk_multi_filter_append CDECL(BYVAL AS GtkMultiFilter Ptr, BYVAL AS GtkFilter Ptr)
Declare SUB gtk_multi_filter_remove CDECL(BYVAL AS GtkMultiFilter Ptr, BYVAL AS guint)

#DEFINE GTK_TYPE_ANY_FILTER (gtk_any_filter_get_type ())
Type GtkAnyFilter AS _GtkAnyFilter
Declare Function gtk_any_filter_new CDECL() AS GtkAnyFilter Ptr

#DEFINE GTK_TYPE_EVERY_FILTER (gtk_every_filter_get_type ())
Type GtkEveryFilter AS _GtkEveryFilter
Declare Function gtk_every_filter_new CDECL() AS GtkEveryFilter Ptr

#DEFINE GTK_TYPE_MULTI_SELECTION (gtk_multi_selection_get_type ())
Type GtkMultiSelection AS _GtkMultiSelection
Declare Function gtk_multi_selection_new CDECL(BYVAL AS GListModel Ptr) AS GtkMultiSelection Ptr
Declare Function gtk_multi_selection_get_model CDECL(BYVAL AS GtkMultiSelection Ptr) AS GListModel Ptr
Declare SUB gtk_multi_selection_set_model CDECL(BYVAL AS GtkMultiSelection Ptr, BYVAL AS GListModel Ptr)

#DEFINE GTK_TYPE_MULTI_SORTER (gtk_multi_sorter_get_type ())
Type GtkMultiSorter AS _GtkMultiSorter
Declare Function gtk_multi_sorter_new CDECL() AS GtkMultiSorter Ptr
Declare SUB gtk_multi_sorter_append CDECL(BYVAL AS GtkMultiSorter Ptr, BYVAL AS GtkSorter Ptr)
Declare SUB gtk_multi_sorter_remove CDECL(BYVAL AS GtkMultiSorter Ptr, BYVAL AS guint)

#DEFINE GTK_TYPE_NATIVE (gtk_native_get_type ())
Type GtkNative AS _GtkNative
Declare SUB gtk_native_realize CDECL(BYVAL AS GtkNative Ptr)
Declare SUB gtk_native_unrealize CDECL(BYVAL AS GtkNative Ptr)
Declare Function gtk_native_get_for_surface CDECL(BYVAL AS GdkSurface Ptr) AS GtkNative Ptr
Declare Function gtk_native_get_surface CDECL(BYVAL AS GtkNative Ptr) AS GdkSurface Ptr
Declare Function gtk_native_get_renderer CDECL(BYVAL AS GtkNative Ptr) AS GskRenderer Ptr
Declare SUB gtk_native_get_surface_transform CDECL(BYVAL AS GtkNative Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)

#DEFINE GTK_TYPE_NATIVE_DIALOG (gtk_native_dialog_get_type ())
Type GtkNativeDialog AS _GtkNativeDialog
Type GtkNativeDialogClass AS _GtkNativeDialogClass
Type _GtkNativeDialogClass
	AS GObjectClass parent_class
	response AS SUB CDECL(BYVAL AS GtkNativeDialog Ptr, BYVAL AS LONG)
	show AS SUB CDECL(BYVAL AS GtkNativeDialog Ptr)
	hide AS SUB CDECL(BYVAL AS GtkNativeDialog Ptr)
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare SUB gtk_native_dialog_show CDECL(BYVAL AS GtkNativeDialog Ptr)
Declare SUB gtk_native_dialog_hide CDECL(BYVAL AS GtkNativeDialog Ptr)
Declare SUB gtk_native_dialog_destroy CDECL(BYVAL AS GtkNativeDialog Ptr)
Declare Function gtk_native_dialog_get_visible CDECL(BYVAL AS GtkNativeDialog Ptr) AS gboolean
Declare SUB gtk_native_dialog_set_modal CDECL(BYVAL AS GtkNativeDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_native_dialog_get_modal CDECL(BYVAL AS GtkNativeDialog Ptr) AS gboolean
Declare SUB gtk_native_dialog_set_title CDECL(BYVAL AS GtkNativeDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_native_dialog_get_title CDECL(BYVAL AS GtkNativeDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_native_dialog_set_transient_for CDECL(BYVAL AS GtkNativeDialog Ptr, BYVAL AS GtkWindow Ptr)
Declare Function gtk_native_dialog_get_transient_for CDECL(BYVAL AS GtkNativeDialog Ptr) AS GtkWindow

#DEFINE GTK_TYPE_NO_SELECTION (gtk_no_selection_get_type ())
Type GtkNoSelection AS _GtkNoSelection
Declare Function gtk_no_selection_new CDECL(BYVAL AS GListModel Ptr) AS GtkNoSelection Ptr
Declare Function gtk_no_selection_get_model CDECL(BYVAL AS GtkNoSelection Ptr) AS GListModel Ptr
Declare SUB gtk_no_selection_set_model CDECL(BYVAL AS GtkNoSelection Ptr, BYVAL AS GListModel Ptr)

#DEFINE GTK_TYPE_NOTEBOOK (gtk_notebook_get_type ())
#DEFINE GTK_NOTEBOOK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_NOTEBOOK, GtkNotebook))
#DEFINE GTK_IS_NOTEBOOK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_NOTEBOOK))
#DEFINE GTK_TYPE_NOTEBOOK_PAGE (gtk_notebook_page_get_type ())
#DEFINE GTK_NOTEBOOK_PAGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_NOTEBOOK_PAGE, GtkNotebookPage))
#DEFINE GTK_IS_NOTEBOOK_PAGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_NOTEBOOK_PAGE))
Type GtkNotebookPage AS _GtkNotebookPage
Enum GtkNotebookTab_
	GTK_NOTEBOOK_TAB_FIRST
	GTK_NOTEBOOK_TAB_LAST
End Enum
Type AS LONG GtkNotebookTab
Type GtkNotebook AS _GtkNotebook
Declare Function gtk_notebook_get_type CDECL() AS GType
Declare Function gtk_notebook_new CDECL() AS GtkWidget Ptr
Declare Function gtk_notebook_append_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget) AS LONG
Declare Function gtk_notebook_append_page_menu CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget, BYVAL AS GtkWidget) AS LONG
Declare Function gtk_notebook_prepend_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget) AS LONG
Declare Function gtk_notebook_prepend_page_menu CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget, BYVAL AS GtkWidget) AS LONG
Declare Function gtk_notebook_insert_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget, BYVAL AS LONG) AS LONG
Declare Function gtk_notebook_insert_page_menu CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget, BYVAL AS GtkWidget, BYVAL AS LONG) AS LONG
Declare SUB gtk_notebook_remove_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS LONG)
Declare SUB gtk_notebook_set_group_name CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_notebook_get_group_name CDECL(BYVAL AS GtkNotebook Ptr) AS Const ZSTRING Ptr
Declare Function gtk_notebook_get_current_page CDECL(BYVAL AS GtkNotebook Ptr) AS LONG
Declare Function gtk_notebook_get_nth_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS LONG) AS GtkWidget Ptr
Declare Function gtk_notebook_get_n_pages CDECL(BYVAL AS GtkNotebook Ptr) AS LONG
Declare Function gtk_notebook_page_num CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS LONG
Declare SUB gtk_notebook_set_current_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS LONG)
Declare SUB gtk_notebook_next_page CDECL(BYVAL AS GtkNotebook Ptr)
Declare SUB gtk_notebook_prev_page CDECL(BYVAL AS GtkNotebook Ptr)
Declare SUB gtk_notebook_set_show_border CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS gboolean)
Declare Function gtk_notebook_get_show_border CDECL(BYVAL AS GtkNotebook Ptr) AS gboolean
Declare SUB gtk_notebook_set_show_tabs CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS gboolean)
Declare Function gtk_notebook_get_show_tabs CDECL(BYVAL AS GtkNotebook Ptr) AS gboolean
Declare SUB gtk_notebook_set_tab_pos CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkPositionType)
Declare Function gtk_notebook_get_tab_pos CDECL(BYVAL AS GtkNotebook Ptr) AS GtkPositionType
Declare SUB gtk_notebook_set_scrollable CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS gboolean)
Declare Function gtk_notebook_get_scrollable CDECL(BYVAL AS GtkNotebook Ptr) AS gboolean
Declare SUB gtk_notebook_popup_enable CDECL(BYVAL AS GtkNotebook Ptr)
Declare SUB gtk_notebook_popup_disable CDECL(BYVAL AS GtkNotebook Ptr)
Declare Function gtk_notebook_get_tab_label CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare SUB gtk_notebook_set_tab_label CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget)
Declare SUB gtk_notebook_set_tab_label_text CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_notebook_get_tab_label_text CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS Const ZSTRING Ptr
Declare Function gtk_notebook_get_menu_label CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS GtkWidget Ptr
Declare SUB gtk_notebook_set_menu_label CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkWidget)
Declare SUB gtk_notebook_set_menu_label_text CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_notebook_get_menu_label_text CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_notebook_reorder_child CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG)
Declare Function gtk_notebook_get_tab_reorderable CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_notebook_set_tab_reorderable CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_notebook_get_tab_detachable CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_notebook_set_tab_detachable CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare SUB gtk_notebook_detach_tab CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_notebook_get_action_widget CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkPackType) AS GtkWidget Ptr
Declare SUB gtk_notebook_set_action_widget CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkPackType)
Declare Function gtk_notebook_page_get_type CDECL() AS GType
Declare Function gtk_notebook_get_page CDECL(BYVAL AS GtkNotebook Ptr, BYVAL AS GtkWidget Ptr) AS GtkNotebookPage Ptr
Declare Function gtk_notebook_page_get_child CDECL(BYVAL AS GtkNotebookPage Ptr) AS GtkWidget Ptr
Declare Function gtk_notebook_get_pages CDECL(BYVAL AS GtkNotebook Ptr) AS GListModel Ptr

#DEFINE GTK_TYPE_NUMERIC_SORTER (gtk_numeric_sorter_get_type ())
Type GtkNumericSorter AS _GtkNumericSorter
Declare Function gtk_numeric_sorter_new CDECL(BYVAL AS GtkExpression Ptr) AS GtkNumericSorter Ptr
Declare Function gtk_numeric_sorter_get_expression CDECL(BYVAL AS GtkNumericSorter Ptr) AS GtkExpression Ptr
Declare SUB gtk_numeric_sorter_set_expression CDECL(BYVAL AS GtkNumericSorter Ptr, BYVAL AS GtkExpression Ptr)
Declare Function gtk_numeric_sorter_get_sort_order CDECL(BYVAL AS GtkNumericSorter Ptr) AS GtkSortType
Declare SUB gtk_numeric_sorter_set_sort_order CDECL(BYVAL AS GtkNumericSorter Ptr, BYVAL AS GtkSortType)

#DEFINE GTK_TYPE_ORIENTABLE (gtk_orientable_get_type ())
#DEFINE GTK_ORIENTABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_ORIENTABLE, GtkOrientable))
#DEFINE GTK_IS_ORIENTABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_ORIENTABLE))
#DEFINE GTK_ORIENTABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_ORIENTABLE, GtkOrientableIface))
Type GtkOrientable AS _GtkOrientable
Type GtkOrientableIface AS _GtkOrientableIface
Type _GtkOrientableIface
	AS GTypeInterface base_iface
End Type
Declare Function gtk_orientable_get_type CDECL() AS GType
Declare SUB gtk_orientable_set_orientation CDECL(BYVAL AS GtkOrientable Ptr, BYVAL AS GtkOrientation)
Declare Function gtk_orientable_get_orientation CDECL(BYVAL AS GtkOrientable Ptr) AS GtkOrientation

#DEFINE GTK_TYPE_OVERLAY (gtk_overlay_get_type ())
#DEFINE GTK_OVERLAY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_OVERLAY, GtkOverlay))
#DEFINE GTK_IS_OVERLAY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_OVERLAY))
Type GtkOverlay AS _GtkOverlay
Declare Function gtk_overlay_get_type CDECL() AS GType
Declare Function gtk_overlay_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_overlay_add_overlay CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_overlay_remove_overlay CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_overlay_set_child CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_overlay_get_child CDECL(BYVAL AS GtkOverlay Ptr) AS GtkWidget Ptr
Declare Function gtk_overlay_get_measure_overlay CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_overlay_set_measure_overlay CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)
Declare Function gtk_overlay_get_clip_overlay CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr) AS gboolean
Declare SUB gtk_overlay_set_clip_overlay CDECL(BYVAL AS GtkOverlay Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS gboolean)

#DEFINE GTK_TYPE_OVERLAY_LAYOUT (gtk_overlay_layout_get_type ())
#DEFINE GTK_TYPE_OVERLAY_LAYOUT_CHILD (gtk_overlay_layout_child_get_type ())
Type GtkOverlayLayout AS _GtkOverlayLayout
Declare Function gtk_overlay_layout_new CDECL() AS GtkLayoutManager Ptr
Type GtkOverlayLayoutChild AS _GtkOverlayLayoutChild
Declare SUB gtk_overlay_layout_child_set_measure CDECL(BYVAL AS GtkOverlayLayoutChild Ptr, BYVAL AS gboolean)
Declare Function gtk_overlay_layout_child_get_measure CDECL(BYVAL AS GtkOverlayLayoutChild Ptr) AS gboolean
Declare SUB gtk_overlay_layout_child_set_clip_overlay CDECL(BYVAL AS GtkOverlayLayoutChild Ptr, BYVAL AS gboolean)
Declare Function gtk_overlay_layout_child_get_clip_overlay CDECL(BYVAL AS GtkOverlayLayoutChild Ptr) AS gboolean

#DEFINE GTK_TYPE_PAD_CONTROLLER (gtk_pad_controller_get_type ())
#DEFINE GTK_PAD_CONTROLLER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_PAD_CONTROLLER, GtkPadController))
#DEFINE GTK_PAD_CONTROLLER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_PAD_CONTROLLER, GtkPadControllerClass))
#DEFINE GTK_IS_PAD_CONTROLLER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_PAD_CONTROLLER))
#DEFINE GTK_IS_PAD_CONTROLLER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_PAD_CONTROLLER))
#DEFINE GTK_PAD_CONTROLLER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_PAD_CONTROLLER, GtkPadControllerClass))
Type GtkPadController AS _GtkPadController
Type GtkPadControllerClass AS _GtkPadControllerClass
Type GtkPadActionEntry AS _GtkPadActionEntry
Enum GtkPadActionType_
	GTK_PAD_ACTION_BUTTON
	GTK_PAD_ACTION_RING
	GTK_PAD_ACTION_STRIP
End Enum
Type AS LONG GtkPadActionType
Type _GtkPadActionEntry
	AS GtkPadActionType type
	AS LONG index
	AS LONG mode
	AS Const ZSTRING Ptr label
	AS Const ZSTRING Ptr action_name
End Type
Declare Function gtk_pad_controller_get_type CDECL() AS GType
Declare Function gtk_pad_controller_new CDECL(BYVAL AS GActionGroup Ptr, BYVAL AS GdkDevice Ptr) AS GtkPadController Ptr
Declare SUB gtk_pad_controller_set_action_entries CDECL(BYVAL AS GtkPadController Ptr, BYVAL AS Const GtkPadActionEntry Ptr, BYVAL AS LONG)
Declare SUB gtk_pad_controller_set_action CDECL(BYVAL AS GtkPadController Ptr, BYVAL AS GtkPadActionType, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr)

Type GtkPaperSize AS _GtkPaperSize
#DEFINE GTK_TYPE_PAPER_SIZE (gtk_paper_size_get_type ())
#DEFINE GTK_PAPER_NAME_A3 @!"iso_a3"
#DEFINE GTK_PAPER_NAME_A4 @!"iso_a4"
#DEFINE GTK_PAPER_NAME_A5 @!"iso_a5"
#DEFINE GTK_PAPER_NAME_B5 @!"iso_b5"
#DEFINE GTK_PAPER_NAME_LETTER @!"na_letter"
#DEFINE GTK_PAPER_NAME_EXECUTIVE @!"na_executive"
#DEFINE GTK_PAPER_NAME_LEGAL @!"na_legal"
Declare Function gtk_paper_size_get_type CDECL() AS GType
Declare Function gtk_paper_size_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkPaperSize Ptr
Declare Function gtk_paper_size_new_from_ppd CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GtkPaperSize Ptr
Declare Function gtk_paper_size_new_from_ipp CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GtkPaperSize Ptr
Declare Function gtk_paper_size_new_custom CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS GtkUnit) AS GtkPaperSize Ptr
Declare Function gtk_paper_size_copy CDECL(BYVAL AS GtkPaperSize Ptr) AS GtkPaperSize Ptr
Declare SUB gtk_paper_size_free CDECL(BYVAL AS GtkPaperSize Ptr)
Declare Function gtk_paper_size_is_equal CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkPaperSize Ptr) AS gboolean
Declare Function gtk_paper_size_get_paper_sizes CDECL(BYVAL AS gboolean) AS GList Ptr
Declare Function gtk_paper_size_get_name CDECL(BYVAL AS GtkPaperSize Ptr) AS Const ZSTRING Ptr
Declare Function gtk_paper_size_get_display_name CDECL(BYVAL AS GtkPaperSize Ptr) AS Const ZSTRING Ptr
Declare Function gtk_paper_size_get_ppd_name CDECL(BYVAL AS GtkPaperSize Ptr) AS Const ZSTRING Ptr
Declare Function gtk_paper_size_get_width CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_paper_size_get_height CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_paper_size_is_custom CDECL(BYVAL AS GtkPaperSize Ptr) AS gboolean
Declare Function gtk_paper_size_is_ipp CDECL(BYVAL AS GtkPaperSize Ptr) AS gboolean
Declare SUB gtk_paper_size_set_size CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_paper_size_get_default_top_margin CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_paper_size_get_default_bottom_margin CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_paper_size_get_default_left_margin CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_paper_size_get_default_right_margin CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_paper_size_get_default CDECL() AS Const ZSTRING Ptr
Declare Function gtk_paper_size_new_from_key_file CDECL(BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GtkPaperSize Ptr
Declare SUB gtk_paper_size_to_key_file CDECL(BYVAL AS GtkPaperSize Ptr, BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_paper_size_new_from_gvariant CDECL(BYVAL AS GVariant Ptr) AS GtkPaperSize Ptr
Declare Function gtk_paper_size_to_gvariant CDECL(BYVAL AS GtkPaperSize Ptr) AS GVariant Ptr

Type GtkPageSetup AS _GtkPageSetup
#DEFINE GTK_TYPE_PAGE_SETUP (gtk_page_setup_get_type ())
#DEFINE GTK_PAGE_SETUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PAGE_SETUP, GtkPageSetup))
#DEFINE GTK_IS_PAGE_SETUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PAGE_SETUP))
Declare Function gtk_page_setup_get_type CDECL() AS GType
Declare Function gtk_page_setup_new CDECL() AS GtkPageSetup Ptr
Declare Function gtk_page_setup_copy CDECL(BYVAL AS GtkPageSetup Ptr) AS GtkPageSetup Ptr
Declare Function gtk_page_setup_get_orientation CDECL(BYVAL AS GtkPageSetup Ptr) AS GtkPageOrientation
Declare SUB gtk_page_setup_set_orientation CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkPageOrientation)
Declare Function gtk_page_setup_get_paper_size CDECL(BYVAL AS GtkPageSetup Ptr) AS GtkPaperSize Ptr
Declare SUB gtk_page_setup_set_paper_size CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkPaperSize Ptr)
Declare Function gtk_page_setup_get_top_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_page_setup_set_top_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_page_setup_get_bottom_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_page_setup_set_bottom_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_page_setup_get_left_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_page_setup_set_left_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_page_setup_get_right_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_page_setup_set_right_margin CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare SUB gtk_page_setup_set_paper_size_and_default_margins CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkPaperSize Ptr)
Declare Function gtk_page_setup_get_paper_width CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_page_setup_get_paper_height CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_page_setup_get_page_width CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_page_setup_get_page_height CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare Function gtk_page_setup_new_from_file CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GtkPageSetup Ptr
Declare Function gtk_page_setup_load_file CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_page_setup_to_file CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_page_setup_new_from_key_file CDECL(BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GtkPageSetup Ptr
Declare Function gtk_page_setup_load_key_file CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare SUB gtk_page_setup_to_key_file CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_page_setup_to_gvariant CDECL(BYVAL AS GtkPageSetup Ptr) AS GVariant Ptr
Declare Function gtk_page_setup_new_from_gvariant CDECL(BYVAL AS GVariant Ptr) AS GtkPageSetup Ptr

#DEFINE GTK_TYPE_PANED (gtk_paned_get_type ())
#DEFINE GTK_PANED(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PANED, GtkPaned))
#DEFINE GTK_IS_PANED(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PANED))
Type GtkPaned AS _GtkPaned
Declare Function gtk_paned_get_type CDECL() AS GType
Declare Function gtk_paned_new CDECL(BYVAL AS GtkOrientation) AS GtkWidget Ptr
Declare SUB gtk_paned_set_start_child CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_paned_get_start_child CDECL(BYVAL AS GtkPaned Ptr) AS GtkWidget Ptr
Declare SUB gtk_paned_set_resize_start_child CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS gboolean)
Declare Function gtk_paned_get_resize_start_child CDECL(BYVAL AS GtkPaned Ptr) AS gboolean
Declare SUB gtk_paned_set_end_child CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_paned_get_end_child CDECL(BYVAL AS GtkPaned Ptr) AS GtkWidget Ptr
Declare SUB gtk_paned_set_shrink_start_child CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS gboolean)
Declare Function gtk_paned_get_shrink_start_child CDECL(BYVAL AS GtkPaned Ptr) AS gboolean
Declare SUB gtk_paned_set_resize_end_child CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS gboolean)
Declare Function gtk_paned_get_resize_end_child CDECL(BYVAL AS GtkPaned Ptr) AS gboolean
Declare SUB gtk_paned_set_shrink_end_child CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS gboolean)
Declare Function gtk_paned_get_shrink_end_child CDECL(BYVAL AS GtkPaned Ptr) AS gboolean
Declare Function gtk_paned_get_position CDECL(BYVAL AS GtkPaned Ptr) AS LONG
Declare SUB gtk_paned_set_position CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS LONG)
Declare SUB gtk_paned_set_wide_handle CDECL(BYVAL AS GtkPaned Ptr, BYVAL AS gboolean)
Declare Function gtk_paned_get_wide_handle CDECL(BYVAL AS GtkPaned Ptr) AS gboolean

#DEFINE GTK_TYPE_PASSWORD_ENTRY (gtk_password_entry_get_type ())
#DEFINE GTK_PASSWORD_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PASSWORD_ENTRY, GtkPasswordEntry))
#DEFINE GTK_IS_PASSWORD_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PASSWORD_ENTRY))
Type GtkPasswordEntry AS _GtkPasswordEntry
Type GtkPasswordEntryClass AS _GtkPasswordEntryClass
Declare Function gtk_password_entry_get_type CDECL() AS GType
Declare Function gtk_password_entry_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_password_entry_set_show_peek_icon CDECL(BYVAL AS GtkPasswordEntry Ptr, BYVAL AS gboolean)
Declare Function gtk_password_entry_get_show_peek_icon CDECL(BYVAL AS GtkPasswordEntry Ptr) AS gboolean
Declare SUB gtk_password_entry_set_extra_menu CDECL(BYVAL AS GtkPasswordEntry Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_password_entry_get_extra_menu CDECL(BYVAL AS GtkPasswordEntry Ptr) AS GMenuModel Ptr

#DEFINE GTK_TYPE_PASSWORD_ENTRY_BUFFER (gtk_password_entry_buffer_get_type())
Type GtkPasswordEntryBuffer AS _GtkPasswordEntryBuffer
Declare Function gtk_password_entry_buffer_new CDECL() AS GtkEntryBuffer Ptr

#DEFINE GTK_TYPE_PICTURE (gtk_picture_get_type ())
Type GtkPicture AS _GtkPicture
Declare Function gtk_picture_new CDECL() AS GtkWidget Ptr
Declare Function gtk_picture_new_for_paintable CDECL(BYVAL AS GdkPaintable Ptr) AS GtkWidget Ptr
Declare Function gtk_picture_new_for_file CDECL(BYVAL AS GFile Ptr) AS GtkWidget Ptr
Declare Function gtk_picture_new_for_filename CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_picture_new_for_resource CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_picture_set_paintable CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS GdkPaintable Ptr)
Declare Function gtk_picture_get_paintable CDECL(BYVAL AS GtkPicture Ptr) AS GdkPaintable Ptr
Declare SUB gtk_picture_set_file CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS GFile Ptr)
Declare Function gtk_picture_get_file CDECL(BYVAL AS GtkPicture Ptr) AS GFile Ptr
Declare SUB gtk_picture_set_filename CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_picture_set_resource CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_picture_set_can_shrink CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS gboolean)
Declare Function gtk_picture_get_can_shrink CDECL(BYVAL AS GtkPicture Ptr) AS gboolean
Declare SUB gtk_picture_set_content_fit CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS GtkContentFit)
Declare Function gtk_picture_get_content_fit CDECL(BYVAL AS GtkPicture Ptr) AS GtkContentFit
Declare SUB gtk_picture_set_alternative_text CDECL(BYVAL AS GtkPicture Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_picture_get_alternative_text CDECL(BYVAL AS GtkPicture Ptr) AS Const ZSTRING Ptr

#DEFINE GTK_TYPE_POPOVER_MENU (gtk_popover_menu_get_type ())
#DEFINE GTK_POPOVER_MENU(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_POPOVER_MENU, GtkPopoverMenu))
#DEFINE GTK_IS_POPOVER_MENU(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_POPOVER_MENU))
Type GtkPopoverMenu AS _GtkPopoverMenu
Declare Function gtk_popover_menu_get_type CDECL() AS GType
Declare Function gtk_popover_menu_new_from_model CDECL(BYVAL AS GMenuModel Ptr) AS GtkWidget Ptr
Declare Function gtk_popover_menu_new_from_model_full CDECL(BYVAL AS GMenuModel Ptr, BYVAL AS GtkPopoverMenuFlags) AS GtkWidget Ptr
Declare SUB gtk_popover_menu_set_menu_model CDECL(BYVAL AS GtkPopoverMenu Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_popover_menu_get_menu_model CDECL(BYVAL AS GtkPopoverMenu Ptr) AS GMenuModel Ptr
Declare SUB gtk_popover_menu_set_flags CDECL(BYVAL AS GtkPopoverMenu Ptr, BYVAL AS GtkPopoverMenuFlags)
Declare Function gtk_popover_menu_get_flags CDECL(BYVAL AS GtkPopoverMenu Ptr) AS GtkPopoverMenuFlags
Declare Function gtk_popover_menu_add_child CDECL(BYVAL AS GtkPopoverMenu Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_popover_menu_remove_child CDECL(BYVAL AS GtkPopoverMenu Ptr, BYVAL AS GtkWidget Ptr) AS gboolean

#DEFINE GTK_TYPE_POPOVER_MENU_BAR (gtk_popover_menu_bar_get_type ())
#DEFINE GTK_POPOVER_MENU_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_POPOVER_MENU_BAR, GtkPopoverMenuBar))
#DEFINE GTK_IS_POPOVER_MENU_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_POPOVER_MENU_BAR))
Type GtkPopoverMenuBar AS _GtkPopoverMenuBar
Declare Function gtk_popover_menu_bar_get_type CDECL() AS GType
Declare Function gtk_popover_menu_bar_new_from_model CDECL(BYVAL AS GMenuModel Ptr) AS GtkWidget Ptr
Declare SUB gtk_popover_menu_bar_set_menu_model CDECL(BYVAL AS GtkPopoverMenuBar Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_popover_menu_bar_get_menu_model CDECL(BYVAL AS GtkPopoverMenuBar Ptr) AS GMenuModel Ptr
Declare Function gtk_popover_menu_bar_add_child CDECL(BYVAL AS GtkPopoverMenuBar Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_popover_menu_bar_remove_child CDECL(BYVAL AS GtkPopoverMenuBar Ptr, BYVAL AS GtkWidget Ptr) AS gboolean

Type GtkPrintSettings AS _GtkPrintSettings
#DEFINE GTK_TYPE_PRINT_SETTINGS (gtk_print_settings_get_type ())
#DEFINE GTK_PRINT_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_SETTINGS, GtkPrintSettings))
#DEFINE GTK_IS_PRINT_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_SETTINGS))
Type GtkPrintSettingsFunc AS SUB CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gpointer)
Type GtkPageRange AS _GtkPageRange
Type _GtkPageRange
	AS LONG start
	AS LONG end
End Type
Declare Function gtk_print_settings_get_type CDECL() AS GType
Declare Function gtk_print_settings_new CDECL() AS GtkPrintSettings Ptr
Declare Function gtk_print_settings_copy CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPrintSettings Ptr
Declare Function gtk_print_settings_new_from_file CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GtkPrintSettings Ptr
Declare Function gtk_print_settings_load_file CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_print_settings_to_file CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_print_settings_new_from_key_file CDECL(BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GtkPrintSettings Ptr
Declare Function gtk_print_settings_load_key_file CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare SUB gtk_print_settings_to_key_file CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GKeyFile Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_has_key CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_print_settings_get CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_print_settings_unset CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_print_settings_foreach CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPrintSettingsFunc, BYVAL AS gpointer)
Declare Function gtk_print_settings_get_bool CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare SUB gtk_print_settings_set_bool CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS gboolean)
Declare Function gtk_print_settings_get_double CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr) AS DOUBLE
Declare Function gtk_print_settings_get_double_with_default CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE) AS DOUBLE
Declare SUB gtk_print_settings_set_double CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE)
Declare Function gtk_print_settings_get_length CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_print_settings_set_length CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_print_settings_get_int CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr) AS LONG
Declare Function gtk_print_settings_get_int_with_default CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG) AS LONG
Declare SUB gtk_print_settings_set_int CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
#DEFINE GTK_PRINT_SETTINGS_PRINTER @!"printer"
#DEFINE GTK_PRINT_SETTINGS_ORIENTATION @!"orientation"
#DEFINE GTK_PRINT_SETTINGS_PAPER_FORMAT @!"paper-format"
#DEFINE GTK_PRINT_SETTINGS_PAPER_WIDTH @!"paper-width"
#DEFINE GTK_PRINT_SETTINGS_PAPER_HEIGHT @!"paper-height"
#DEFINE GTK_PRINT_SETTINGS_N_COPIES @!"n-copies"
#DEFINE GTK_PRINT_SETTINGS_DEFAULT_SOURCE @!"default-source"
#DEFINE GTK_PRINT_SETTINGS_QUALITY @!"quality"
#DEFINE GTK_PRINT_SETTINGS_RESOLUTION @!"resolution"
#DEFINE GTK_PRINT_SETTINGS_USE_COLOR @!"use-color"
#DEFINE GTK_PRINT_SETTINGS_DUPLEX @!"duplex"
#DEFINE GTK_PRINT_SETTINGS_COLLATE @!"collate"
#DEFINE GTK_PRINT_SETTINGS_REVERSE @!"reverse"
#DEFINE GTK_PRINT_SETTINGS_MEDIA_TYPE @!"media-type"
#DEFINE GTK_PRINT_SETTINGS_DITHER @!"dither"
#DEFINE GTK_PRINT_SETTINGS_SCALE @!"scale"
#DEFINE GTK_PRINT_SETTINGS_PRINT_PAGES @!"print-pages"
#DEFINE GTK_PRINT_SETTINGS_PAGE_RANGES @!"page-ranges"
#DEFINE GTK_PRINT_SETTINGS_PAGE_SET @!"page-set"
#DEFINE GTK_PRINT_SETTINGS_FINISHINGS @!"finishings"
#DEFINE GTK_PRINT_SETTINGS_NUMBER_UP @!"number-up"
#DEFINE GTK_PRINT_SETTINGS_NUMBER_UP_LAYOUT @!"number-up-layout"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_BIN @!"output-bin"
#DEFINE GTK_PRINT_SETTINGS_RESOLUTION_X @!"resolution-x"
#DEFINE GTK_PRINT_SETTINGS_RESOLUTION_Y @!"resolution-y"
#DEFINE GTK_PRINT_SETTINGS_PRINTER_LPI @!"printer-lpi"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_DIR @!"output-dir"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_BASENAME @!"output-basename"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_FILE_FORMAT @!"output-file-format"
#DEFINE GTK_PRINT_SETTINGS_OUTPUT_URI @!"output-uri"
#DEFINE GTK_PRINT_SETTINGS_WIN32_DRIVER_VERSION @!"win32-driver-version"
#DEFINE GTK_PRINT_SETTINGS_WIN32_DRIVER_EXTRA @!"win32-driver-extra"
Declare Function gtk_print_settings_get_printer CDECL(BYVAL AS GtkPrintSettings Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set_printer CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_get_orientation CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPageOrientation
Declare SUB gtk_print_settings_set_orientation CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPageOrientation)
Declare Function gtk_print_settings_get_paper_size CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPaperSize Ptr
Declare SUB gtk_print_settings_set_paper_size CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPaperSize Ptr)
Declare Function gtk_print_settings_get_paper_width CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_print_settings_set_paper_width CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_print_settings_get_paper_height CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkUnit) AS DOUBLE
Declare SUB gtk_print_settings_set_paper_height CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS DOUBLE, BYVAL AS GtkUnit)
Declare Function gtk_print_settings_get_use_color CDECL(BYVAL AS GtkPrintSettings Ptr) AS gboolean
Declare SUB gtk_print_settings_set_use_color CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS gboolean)
Declare Function gtk_print_settings_get_collate CDECL(BYVAL AS GtkPrintSettings Ptr) AS gboolean
Declare SUB gtk_print_settings_set_collate CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS gboolean)
Declare Function gtk_print_settings_get_reverse CDECL(BYVAL AS GtkPrintSettings Ptr) AS gboolean
Declare SUB gtk_print_settings_set_reverse CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS gboolean)
Declare Function gtk_print_settings_get_duplex CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPrintDuplex
Declare SUB gtk_print_settings_set_duplex CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPrintDuplex)
Declare Function gtk_print_settings_get_quality CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPrintQuality
Declare SUB gtk_print_settings_set_quality CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPrintQuality)
Declare Function gtk_print_settings_get_n_copies CDECL(BYVAL AS GtkPrintSettings Ptr) AS LONG
Declare SUB gtk_print_settings_set_n_copies CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS LONG)
Declare Function gtk_print_settings_get_number_up CDECL(BYVAL AS GtkPrintSettings Ptr) AS LONG
Declare SUB gtk_print_settings_set_number_up CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS LONG)
Declare Function gtk_print_settings_get_number_up_layout CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkNumberUpLayout
Declare SUB gtk_print_settings_set_number_up_layout CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkNumberUpLayout)
Declare Function gtk_print_settings_get_resolution CDECL(BYVAL AS GtkPrintSettings Ptr) AS LONG
Declare SUB gtk_print_settings_set_resolution CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS LONG)
Declare Function gtk_print_settings_get_resolution_x CDECL(BYVAL AS GtkPrintSettings Ptr) AS LONG
Declare Function gtk_print_settings_get_resolution_y CDECL(BYVAL AS GtkPrintSettings Ptr) AS LONG
Declare SUB gtk_print_settings_set_resolution_xy CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare Function gtk_print_settings_get_printer_lpi CDECL(BYVAL AS GtkPrintSettings Ptr) AS DOUBLE
Declare SUB gtk_print_settings_set_printer_lpi CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS DOUBLE)
Declare Function gtk_print_settings_get_scale CDECL(BYVAL AS GtkPrintSettings Ptr) AS DOUBLE
Declare SUB gtk_print_settings_set_scale CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS DOUBLE)
Declare Function gtk_print_settings_get_print_pages CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPrintPages
Declare SUB gtk_print_settings_set_print_pages CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPrintPages)
Declare Function gtk_print_settings_get_page_ranges CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS LONG Ptr) AS GtkPageRange Ptr
Declare SUB gtk_print_settings_set_page_ranges CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPageRange Ptr, BYVAL AS LONG)
Declare Function gtk_print_settings_get_page_set CDECL(BYVAL AS GtkPrintSettings Ptr) AS GtkPageSet
Declare SUB gtk_print_settings_set_page_set CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPageSet)
Declare Function gtk_print_settings_get_default_source CDECL(BYVAL AS GtkPrintSettings Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set_default_source CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_get_media_type CDECL(BYVAL AS GtkPrintSettings Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set_media_type CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_get_dither CDECL(BYVAL AS GtkPrintSettings Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set_dither CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_get_finishings CDECL(BYVAL AS GtkPrintSettings Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set_finishings CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_get_output_bin CDECL(BYVAL AS GtkPrintSettings Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_settings_set_output_bin CDECL(BYVAL AS GtkPrintSettings Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_settings_to_gvariant CDECL(BYVAL AS GtkPrintSettings Ptr) AS GVariant Ptr
Declare Function gtk_print_settings_new_from_gvariant CDECL(BYVAL AS GVariant Ptr) AS GtkPrintSettings Ptr

Type GtkPrintSetup AS _GtkPrintSetup
#DEFINE GTK_TYPE_PRINT_SETUP (gtk_print_setup_get_type ())
Declare Function gtk_print_setup_get_type CDECL() AS GType
Declare Function gtk_print_setup_ref CDECL(BYVAL AS GtkPrintSetup Ptr) AS GtkPrintSetup Ptr
Declare SUB gtk_print_setup_unref CDECL(BYVAL AS GtkPrintSetup Ptr)
Declare Function gtk_print_setup_get_print_settings CDECL(BYVAL AS GtkPrintSetup Ptr) AS GtkPrintSettings Ptr
Declare Function gtk_print_setup_get_page_setup CDECL(BYVAL AS GtkPrintSetup Ptr) AS GtkPageSetup Ptr

#DEFINE GTK_TYPE_PRINT_DIALOG (gtk_print_dialog_get_type ())
Type GtkPrintDialog AS _GtkPrintDialog
Declare Function gtk_print_dialog_new CDECL() AS GtkPrintDialog Ptr
Declare Function gtk_print_dialog_get_title CDECL(BYVAL AS GtkPrintDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_dialog_set_title CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_dialog_get_accept_label CDECL(BYVAL AS GtkPrintDialog Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_print_dialog_set_accept_label CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_dialog_get_modal CDECL(BYVAL AS GtkPrintDialog Ptr) AS gboolean
Declare SUB gtk_print_dialog_set_modal CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS gboolean)
Declare Function gtk_print_dialog_get_page_setup CDECL(BYVAL AS GtkPrintDialog Ptr) AS GtkPageSetup Ptr
Declare SUB gtk_print_dialog_set_page_setup CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GtkPageSetup Ptr)
Declare Function gtk_print_dialog_get_print_settings CDECL(BYVAL AS GtkPrintDialog Ptr) AS GtkPrintSettings Ptr
Declare SUB gtk_print_dialog_set_print_settings CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GtkPrintSettings Ptr)
Declare SUB gtk_print_dialog_setup CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_print_dialog_setup_finish CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GtkPrintSetup Ptr
Declare SUB gtk_print_dialog_print CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GtkPrintSetup Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_print_dialog_print_finish CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS GOutputStream Ptr
Declare SUB gtk_print_dialog_print_file CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GtkPrintSetup Ptr, BYVAL AS GFile Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_print_dialog_print_file_finish CDECL(BYVAL AS GtkPrintDialog Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean

Type GtkPrintContext AS _GtkPrintContext
#DEFINE GTK_TYPE_PRINT_CONTEXT (gtk_print_context_get_type ())
#DEFINE GTK_PRINT_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_CONTEXT, GtkPrintContext))
#DEFINE GTK_IS_PRINT_CONTEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_CONTEXT))
Declare Function gtk_print_context_get_type CDECL() AS GType
Declare Function gtk_print_context_get_cairo_context CDECL(BYVAL AS GtkPrintContext Ptr) AS cairo_t Ptr
Declare Function gtk_print_context_get_page_setup CDECL(BYVAL AS GtkPrintContext Ptr) AS GtkPageSetup Ptr
Declare Function gtk_print_context_get_width CDECL(BYVAL AS GtkPrintContext Ptr) AS DOUBLE
Declare Function gtk_print_context_get_height CDECL(BYVAL AS GtkPrintContext Ptr) AS DOUBLE
Declare Function gtk_print_context_get_dpi_x CDECL(BYVAL AS GtkPrintContext Ptr) AS DOUBLE
Declare Function gtk_print_context_get_dpi_y CDECL(BYVAL AS GtkPrintContext Ptr) AS DOUBLE
Declare Function gtk_print_context_get_hard_margins CDECL(BYVAL AS GtkPrintContext Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr) AS gboolean
Declare Function gtk_print_context_get_pango_fontmap CDECL(BYVAL AS GtkPrintContext Ptr) AS PangoFontMap Ptr
Declare Function gtk_print_context_create_pango_context CDECL(BYVAL AS GtkPrintContext Ptr) AS PangoContext Ptr
Declare Function gtk_print_context_create_pango_layout CDECL(BYVAL AS GtkPrintContext Ptr) AS PangoLayout Ptr
Declare SUB gtk_print_context_set_cairo_context CDECL(BYVAL AS GtkPrintContext Ptr, BYVAL AS cairo_t Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)

#DEFINE GTK_TYPE_PRINT_OPERATION_PREVIEW (gtk_print_operation_preview_get_type ())
#DEFINE GTK_PRINT_OPERATION_PREVIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW, GtkPrintOperationPreview))
#DEFINE GTK_IS_PRINT_OPERATION_PREVIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW))
#DEFINE GTK_PRINT_OPERATION_PREVIEW_GET_IFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE ((obj), GTK_TYPE_PRINT_OPERATION_PREVIEW, GtkPrintOperationPreviewIface))
Type GtkPrintOperationPreview AS _GtkPrintOperationPreview
Type GtkPrintOperationPreviewIface AS _GtkPrintOperationPreviewIface
Type _GtkPrintOperationPreviewIface
	AS GTypeInterface g_iface
	ready AS SUB CDECL(BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS GtkPrintContext Ptr)
	got_page_size AS SUB CDECL(BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS GtkPrintContext Ptr, BYVAL AS GtkPageSetup Ptr)
	render_page AS SUB CDECL(BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS LONG)
	is_selected AS Function CDECL(BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS LONG) AS gboolean
	end_preview AS SUB CDECL(BYVAL AS GtkPrintOperationPreview Ptr)
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
	_gtk_reserved5 AS SUB CDECL()
	_gtk_reserved6 AS SUB CDECL()
	_gtk_reserved7 AS SUB CDECL()
	_gtk_reserved8 AS SUB CDECL()
End Type
Declare Function gtk_print_operation_preview_get_type CDECL() AS GType
Declare SUB gtk_print_operation_preview_render_page CDECL(BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS LONG)
Declare SUB gtk_print_operation_preview_end_preview CDECL(BYVAL AS GtkPrintOperationPreview Ptr)
Declare Function gtk_print_operation_preview_is_selected CDECL(BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS LONG) AS gboolean

#DEFINE GTK_TYPE_PRINT_OPERATION (gtk_print_operation_get_type ())
#DEFINE GTK_PRINT_OPERATION(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PRINT_OPERATION, GtkPrintOperation))
#DEFINE GTK_PRINT_OPERATION_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_PRINT_OPERATION, GtkPrintOperationClass))
#DEFINE GTK_IS_PRINT_OPERATION(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PRINT_OPERATION))
#DEFINE GTK_IS_PRINT_OPERATION_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_PRINT_OPERATION))
#DEFINE GTK_PRINT_OPERATION_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_PRINT_OPERATION, GtkPrintOperationClass))
Type GtkPrintOperationClass AS _GtkPrintOperationClass
Type GtkPrintOperationPrivate AS _GtkPrintOperationPrivate
Type GtkPrintOperation AS _GtkPrintOperation
Enum GtkPrintStatus_
	GTK_PRINT_STATUS_INITIAL
	GTK_PRINT_STATUS_PREPARING
	GTK_PRINT_STATUS_GENERATING_DATA
	GTK_PRINT_STATUS_SENDING_DATA
	GTK_PRINT_STATUS_PENDING
	GTK_PRINT_STATUS_PENDING_ISSUE
	GTK_PRINT_STATUS_PRINTING
	GTK_PRINT_STATUS_FINISHED
	GTK_PRINT_STATUS_FINISHED_ABORTED
End Enum
Type AS LONG GtkPrintStatus
Enum GtkPrintOperationResult_
	GTK_PRINT_OPERATION_RESULT_ERROR
	GTK_PRINT_OPERATION_RESULT_APPLY
	GTK_PRINT_OPERATION_RESULT_CANCEL
	GTK_PRINT_OPERATION_RESULT_IN_PROGRESS
End Enum
Type AS LONG GtkPrintOperationResult
Enum GtkPrintOperationAction_
	GTK_PRINT_OPERATION_ACTION_PRINT_DIALOG
	GTK_PRINT_OPERATION_ACTION_PRINT
	GTK_PRINT_OPERATION_ACTION_PREVIEW
	GTK_PRINT_OPERATION_ACTION_EXPORT
End Enum
Type AS LONG GtkPrintOperationAction
Type _GtkPrintOperation
	AS GObject parent_instance
	AS GtkPrintOperationPrivate Ptr priv
End Type
Type _GtkPrintOperationClass
	AS GObjectClass parent_class
	done AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintOperationResult)
	begin_print AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintContext Ptr)
	paginate AS Function CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintContext Ptr) AS gboolean
	request_page_setup AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintContext Ptr, BYVAL AS LONG, BYVAL AS GtkPageSetup Ptr)
	draw_page AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintContext Ptr, BYVAL AS LONG)
	end_print AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintContext Ptr)
	status_changed AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr)
	create_custom_widget AS Function CDECL(BYVAL AS GtkPrintOperation Ptr) AS GtkWidget Ptr
	custom_widget_apply AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkWidget Ptr)
	preview AS Function CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintOperationPreview Ptr, BYVAL AS GtkPrintContext Ptr, BYVAL AS GtkWindow Ptr) AS gboolean
	update_custom_widget AS SUB CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkPrintSettings Ptr)
	AS gpointer padding(0 TO 8-1)
End Type

#DEFINE GTK_PRINT_ERROR gtk_print_error_quark ()
Enum GtkPrintError_
	GTK_PRINT_ERROR_GENERAL
	GTK_PRINT_ERROR_INTERNAL_ERROR
	GTK_PRINT_ERROR_NOMEM
	GTK_PRINT_ERROR_INVALID_FILE
End Enum
Type AS LONG GtkPrintError
Declare Function gtk_print_error_quark CDECL() AS GQuark
Declare Function gtk_print_operation_get_type CDECL() AS GType
Declare Function gtk_print_operation_new CDECL() AS GtkPrintOperation Ptr
Declare SUB gtk_print_operation_set_default_page_setup CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPageSetup Ptr)
Declare Function gtk_print_operation_get_default_page_setup CDECL(BYVAL AS GtkPrintOperation Ptr) AS GtkPageSetup Ptr
Declare SUB gtk_print_operation_set_print_settings CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintSettings Ptr)
Declare Function gtk_print_operation_get_print_settings CDECL(BYVAL AS GtkPrintOperation Ptr) AS GtkPrintSettings Ptr
Declare SUB gtk_print_operation_set_job_name CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_print_operation_set_n_pages CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS LONG)
Declare SUB gtk_print_operation_set_current_page CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS LONG)
Declare SUB gtk_print_operation_set_use_full_page CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare SUB gtk_print_operation_set_unit CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkUnit)
Declare SUB gtk_print_operation_set_export_filename CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_print_operation_set_track_print_status CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare SUB gtk_print_operation_set_show_progress CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare SUB gtk_print_operation_set_allow_async CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare SUB gtk_print_operation_set_custom_tab_label CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_print_operation_run CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GtkPrintOperationAction, BYVAL AS GtkWindow Ptr, BYVAL AS GError Ptr Ptr) AS GtkPrintOperationResult
Declare SUB gtk_print_operation_get_error CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS GError Ptr Ptr)
Declare Function gtk_print_operation_get_status CDECL(BYVAL AS GtkPrintOperation Ptr) AS GtkPrintStatus
Declare Function gtk_print_operation_get_status_string CDECL(BYVAL AS GtkPrintOperation Ptr) AS Const ZSTRING Ptr
Declare Function gtk_print_operation_is_finished CDECL(BYVAL AS GtkPrintOperation Ptr) AS gboolean
Declare SUB gtk_print_operation_cancel CDECL(BYVAL AS GtkPrintOperation Ptr)
Declare SUB gtk_print_operation_draw_page_finish CDECL(BYVAL AS GtkPrintOperation Ptr)
Declare SUB gtk_print_operation_set_defer_drawing CDECL(BYVAL AS GtkPrintOperation Ptr)
Declare SUB gtk_print_operation_set_support_selection CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare Function gtk_print_operation_get_support_selection CDECL(BYVAL AS GtkPrintOperation Ptr) AS gboolean
Declare SUB gtk_print_operation_set_has_selection CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare Function gtk_print_operation_get_has_selection CDECL(BYVAL AS GtkPrintOperation Ptr) AS gboolean
Declare SUB gtk_print_operation_set_embed_page_setup CDECL(BYVAL AS GtkPrintOperation Ptr, BYVAL AS gboolean)
Declare Function gtk_print_operation_get_embed_page_setup CDECL(BYVAL AS GtkPrintOperation Ptr) AS gboolean
Declare Function gtk_print_operation_get_n_pages_to_print CDECL(BYVAL AS GtkPrintOperation Ptr) AS LONG
Declare Function gtk_print_run_page_setup_dialog CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkPrintSettings Ptr) AS GtkPageSetup Ptr
Type GtkPageSetupDoneFunc AS SUB CDECL(BYVAL AS GtkPageSetup Ptr, BYVAL AS gpointer)
Declare SUB gtk_print_run_page_setup_dialog_async CDECL(BYVAL AS GtkWindow Ptr, BYVAL AS GtkPageSetup Ptr, BYVAL AS GtkPrintSettings Ptr, BYVAL AS GtkPageSetupDoneFunc, BYVAL AS gpointer)


#DEFINE GTK_TYPE_PROGRESS_BAR (gtk_progress_bar_get_type ())
#DEFINE GTK_PROGRESS_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_PROGRESS_BAR, GtkProgressBar))
#DEFINE GTK_IS_PROGRESS_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_PROGRESS_BAR))
Type GtkProgressBar AS _GtkProgressBar
Declare Function gtk_progress_bar_get_type CDECL() AS GType
Declare Function gtk_progress_bar_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_progress_bar_pulse CDECL(BYVAL AS GtkProgressBar Ptr)
Declare SUB gtk_progress_bar_set_text CDECL(BYVAL AS GtkProgressBar Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_progress_bar_set_fraction CDECL(BYVAL AS GtkProgressBar Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_progress_bar_set_pulse_step CDECL(BYVAL AS GtkProgressBar Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_progress_bar_set_inverted CDECL(BYVAL AS GtkProgressBar Ptr, BYVAL AS gboolean)
Declare Function gtk_progress_bar_get_text CDECL(BYVAL AS GtkProgressBar Ptr) AS Const ZSTRING Ptr
Declare Function gtk_progress_bar_get_fraction CDECL(BYVAL AS GtkProgressBar Ptr) AS DOUBLE
Declare Function gtk_progress_bar_get_pulse_step CDECL(BYVAL AS GtkProgressBar Ptr) AS DOUBLE
Declare Function gtk_progress_bar_get_inverted CDECL(BYVAL AS GtkProgressBar Ptr) AS gboolean
Declare SUB gtk_progress_bar_set_ellipsize CDECL(BYVAL AS GtkProgressBar Ptr, BYVAL AS PangoEllipsizeMode)
Declare Function gtk_progress_bar_get_ellipsize CDECL(BYVAL AS GtkProgressBar Ptr) AS PangoEllipsizeMode
Declare SUB gtk_progress_bar_set_show_text CDECL(BYVAL AS GtkProgressBar Ptr, BYVAL AS gboolean)
Declare Function gtk_progress_bar_get_show_text CDECL(BYVAL AS GtkProgressBar Ptr) AS gboolean


#DEFINE GTK_TYPE_RANGE (gtk_range_get_type ())
#DEFINE GTK_RANGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RANGE, GtkRange))
#DEFINE GTK_RANGE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RANGE, GtkRangeClass))
#DEFINE GTK_IS_RANGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RANGE))
#DEFINE GTK_IS_RANGE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RANGE))
#DEFINE GTK_RANGE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RANGE, GtkRangeClass))
Type GtkRange AS _GtkRange
Type GtkRangeClass AS _GtkRangeClass
Type _GtkRange
	AS GtkWidget parent_instance
End Type
Type _GtkRangeClass
	AS GtkWidgetClass parent_class
	value_changed AS SUB CDECL(BYVAL AS GtkRange Ptr)
	adjust_bounds AS SUB CDECL(BYVAL AS GtkRange Ptr, BYVAL AS DOUBLE)
	move_slider AS SUB CDECL(BYVAL AS GtkRange Ptr, BYVAL AS GtkScrollType)
	get_range_border AS SUB CDECL(BYVAL AS GtkRange Ptr, BYVAL AS GtkBorder Ptr)
	change_value AS Function CDECL(BYVAL AS GtkRange Ptr, BYVAL AS GtkScrollType, BYVAL AS DOUBLE) AS gboolean
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_range_get_type CDECL() AS GType
Declare SUB gtk_range_set_adjustment CDECL(BYVAL AS GtkRange Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_range_get_adjustment CDECL(BYVAL AS GtkRange Ptr) AS GtkAdjustment Ptr
Declare SUB gtk_range_set_inverted CDECL(BYVAL AS GtkRange Ptr, BYVAL AS gboolean)
Declare Function gtk_range_get_inverted CDECL(BYVAL AS GtkRange Ptr) AS gboolean
Declare SUB gtk_range_set_flippable CDECL(BYVAL AS GtkRange Ptr, BYVAL AS gboolean)
Declare Function gtk_range_get_flippable CDECL(BYVAL AS GtkRange Ptr) AS gboolean
Declare SUB gtk_range_set_slider_size_fixed CDECL(BYVAL AS GtkRange Ptr, BYVAL AS gboolean)
Declare Function gtk_range_get_slider_size_fixed CDECL(BYVAL AS GtkRange Ptr) AS gboolean
Declare SUB gtk_range_get_range_rect CDECL(BYVAL AS GtkRange Ptr, BYVAL AS GdkRectangle Ptr)
Declare SUB gtk_range_get_slider_range CDECL(BYVAL AS GtkRange Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_range_set_increments CDECL(BYVAL AS GtkRange Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_range_set_range CDECL(BYVAL AS GtkRange Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_range_set_value CDECL(BYVAL AS GtkRange Ptr, BYVAL AS DOUBLE)
Declare Function gtk_range_get_value CDECL(BYVAL AS GtkRange Ptr) AS DOUBLE
Declare SUB gtk_range_set_show_fill_level CDECL(BYVAL AS GtkRange Ptr, BYVAL AS gboolean)
Declare Function gtk_range_get_show_fill_level CDECL(BYVAL AS GtkRange Ptr) AS gboolean
Declare SUB gtk_range_set_restrict_to_fill_level CDECL(BYVAL AS GtkRange Ptr, BYVAL AS gboolean)
Declare Function gtk_range_get_restrict_to_fill_level CDECL(BYVAL AS GtkRange Ptr) AS gboolean
Declare SUB gtk_range_set_fill_level CDECL(BYVAL AS GtkRange Ptr, BYVAL AS DOUBLE)
Declare Function gtk_range_get_fill_level CDECL(BYVAL AS GtkRange Ptr) AS DOUBLE
Declare SUB gtk_range_set_round_digits CDECL(BYVAL AS GtkRange Ptr, BYVAL AS LONG)
Declare Function gtk_range_get_round_digits CDECL(BYVAL AS GtkRange Ptr) AS LONG


#DEFINE GTK_TYPE_RECENT_INFO (gtk_recent_info_get_type ())
#DEFINE GTK_TYPE_RECENT_MANAGER (gtk_recent_manager_get_type ())
#DEFINE GTK_RECENT_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_RECENT_MANAGER, GtkRecentManager))
#DEFINE GTK_IS_RECENT_MANAGER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_RECENT_MANAGER))
#DEFINE GTK_RECENT_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_RECENT_MANAGER, GtkRecentManagerClass))
#DEFINE GTK_IS_RECENT_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_RECENT_MANAGER))
#DEFINE GTK_RECENT_MANAGER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_RECENT_MANAGER, GtkRecentManagerClass))
Type GtkRecentInfo AS _GtkRecentInfo
Type GtkRecentData AS _GtkRecentData
Type GtkRecentManager AS _GtkRecentManager
Type GtkRecentManagerClass AS _GtkRecentManagerClass
Type GtkRecentManagerPrivate AS _GtkRecentManagerPrivate
Type _GtkRecentData
	AS ZSTRING Ptr display_name
	AS ZSTRING Ptr description
	AS ZSTRING Ptr mime_type
	AS ZSTRING Ptr app_name
	AS ZSTRING Ptr app_exec
	AS ZSTRING Ptr Ptr groups
	AS gboolean is_private
End Type
Type _GtkRecentManager
	AS GObject parent_instance
	AS GtkRecentManagerPrivate Ptr priv
End Type
Type _GtkRecentManagerClass
	AS GObjectClass parent_class
	changed AS SUB CDECL(BYVAL AS GtkRecentManager Ptr)
	_gtk_recent1 AS SUB CDECL()
	_gtk_recent2 AS SUB CDECL()
	_gtk_recent3 AS SUB CDECL()
	_gtk_recent4 AS SUB CDECL()
End Type
Enum GtkRecentManagerError_
	GTK_RECENT_MANAGER_ERROR_NOT_FOUND
	GTK_RECENT_MANAGER_ERROR_INVALID_URI
	GTK_RECENT_MANAGER_ERROR_INVALID_ENCODING
	GTK_RECENT_MANAGER_ERROR_NOT_REGISTERED
	GTK_RECENT_MANAGER_ERROR_READ
	GTK_RECENT_MANAGER_ERROR_WRITE
	GTK_RECENT_MANAGER_ERROR_UNKNOWN
End Enum
Type AS LONG GtkRecentManagerError
#DEFINE GTK_RECENT_MANAGER_ERROR (gtk_recent_manager_error_quark ())
Declare Function gtk_recent_manager_error_quark CDECL() AS GQuark
Declare Function gtk_recent_manager_get_type CDECL() AS GType
Declare Function gtk_recent_manager_new CDECL() AS GtkRecentManager Ptr
Declare Function gtk_recent_manager_get_default CDECL() AS GtkRecentManager Ptr
Declare Function gtk_recent_manager_add_item CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_recent_manager_add_full CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GtkRecentData Ptr) AS gboolean
Declare Function gtk_recent_manager_remove_item CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_recent_manager_lookup_item CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GtkRecentInfo Ptr
Declare Function gtk_recent_manager_has_item CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_recent_manager_move_item CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS gboolean
Declare Function gtk_recent_manager_get_items CDECL(BYVAL AS GtkRecentManager Ptr) AS GList Ptr
Declare Function gtk_recent_manager_purge_items CDECL(BYVAL AS GtkRecentManager Ptr, BYVAL AS GError Ptr Ptr) AS LONG
Declare Function gtk_recent_info_get_type CDECL() AS GType
Declare Function gtk_recent_info_ref CDECL(BYVAL AS GtkRecentInfo Ptr) AS GtkRecentInfo Ptr
Declare SUB gtk_recent_info_unref CDECL(BYVAL AS GtkRecentInfo Ptr)
Declare Function gtk_recent_info_get_uri CDECL(BYVAL AS GtkRecentInfo Ptr) AS Const ZSTRING Ptr
Declare Function gtk_recent_info_get_display_name CDECL(BYVAL AS GtkRecentInfo Ptr) AS Const ZSTRING Ptr
Declare Function gtk_recent_info_get_description CDECL(BYVAL AS GtkRecentInfo Ptr) AS Const ZSTRING Ptr
Declare Function gtk_recent_info_get_mime_type CDECL(BYVAL AS GtkRecentInfo Ptr) AS Const ZSTRING Ptr
Declare Function gtk_recent_info_get_added CDECL(BYVAL AS GtkRecentInfo Ptr) AS GDateTime Ptr
Declare Function gtk_recent_info_get_modified CDECL(BYVAL AS GtkRecentInfo Ptr) AS GDateTime Ptr
Declare Function gtk_recent_info_get_visited CDECL(BYVAL AS GtkRecentInfo Ptr) AS GDateTime Ptr
Declare Function gtk_recent_info_get_private_hint CDECL(BYVAL AS GtkRecentInfo Ptr) AS gboolean
Declare Function gtk_recent_info_get_application_info CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr Ptr, BYVAL AS guint Ptr, BYVAL AS GDateTime Ptr Ptr) AS gboolean
Declare Function gtk_recent_info_create_app_info CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GError Ptr Ptr) AS GAppInfo Ptr
Declare Function gtk_recent_info_get_applications CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS gsize Ptr) AS ZSTRING Ptr Ptr
Declare Function gtk_recent_info_last_application CDECL(BYVAL AS GtkRecentInfo Ptr) AS ZSTRING Ptr
Declare Function gtk_recent_info_has_application CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_recent_info_get_groups CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS gsize Ptr) AS ZSTRING Ptr Ptr
Declare Function gtk_recent_info_has_group CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS Const ZSTRING Ptr) AS gboolean
Declare Function gtk_recent_info_get_gicon CDECL(BYVAL AS GtkRecentInfo Ptr) AS GIcon Ptr
Declare Function gtk_recent_info_get_short_name CDECL(BYVAL AS GtkRecentInfo Ptr) AS ZSTRING Ptr
Declare Function gtk_recent_info_get_uri_display CDECL(BYVAL AS GtkRecentInfo Ptr) AS ZSTRING Ptr
Declare Function gtk_recent_info_get_age CDECL(BYVAL AS GtkRecentInfo Ptr) AS LONG
Declare Function gtk_recent_info_is_local CDECL(BYVAL AS GtkRecentInfo Ptr) AS gboolean
Declare Function gtk_recent_info_exists CDECL(BYVAL AS GtkRecentInfo Ptr) AS gboolean
Declare Function gtk_recent_info_match CDECL(BYVAL AS GtkRecentInfo Ptr, BYVAL AS GtkRecentInfo Ptr) AS gboolean
Declare SUB _gtk_recent_manager_sync CDECL()

#DEFINE GTK_TYPE_REVEALER (gtk_revealer_get_type ())
#DEFINE GTK_REVEALER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_REVEALER, GtkRevealer))
#DEFINE GTK_IS_REVEALER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_REVEALER))
Type GtkRevealer AS _GtkRevealer
Enum GtkRevealerTransitionType_
	GTK_REVEALER_TRANSITION_TYPE_NONE
	GTK_REVEALER_TRANSITION_TYPE_CROSSFADE
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_RIGHT
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_LEFT
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_UP
	GTK_REVEALER_TRANSITION_TYPE_SLIDE_DOWN
	GTK_REVEALER_TRANSITION_TYPE_SWING_RIGHT
	GTK_REVEALER_TRANSITION_TYPE_SWING_LEFT
	GTK_REVEALER_TRANSITION_TYPE_SWING_UP
	GTK_REVEALER_TRANSITION_TYPE_SWING_DOWN
End Enum
Type AS LONG GtkRevealerTransitionType
Declare Function gtk_revealer_get_type CDECL() AS GType
Declare Function gtk_revealer_new CDECL() AS GtkWidget Ptr
Declare Function gtk_revealer_get_reveal_child CDECL(BYVAL AS GtkRevealer Ptr) AS gboolean
Declare SUB gtk_revealer_set_reveal_child CDECL(BYVAL AS GtkRevealer Ptr, BYVAL AS gboolean)
Declare Function gtk_revealer_get_child_revealed CDECL(BYVAL AS GtkRevealer Ptr) AS gboolean
Declare Function gtk_revealer_get_transition_duration CDECL(BYVAL AS GtkRevealer Ptr) AS guint
Declare SUB gtk_revealer_set_transition_duration CDECL(BYVAL AS GtkRevealer Ptr, BYVAL AS guint)
Declare SUB gtk_revealer_set_transition_type CDECL(BYVAL AS GtkRevealer Ptr, BYVAL AS GtkRevealerTransitionType)
Declare Function gtk_revealer_get_transition_type CDECL(BYVAL AS GtkRevealer Ptr) AS GtkRevealerTransitionType
Declare SUB gtk_revealer_set_child CDECL(BYVAL AS GtkRevealer Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_revealer_get_child CDECL(BYVAL AS GtkRevealer Ptr) AS GtkWidget Ptr


#DEFINE GTK_TYPE_ROOT (gtk_root_get_type ())
Type GtkRoot AS _GtkRoot
Declare Function gtk_root_get_display CDECL(BYVAL AS GtkRoot Ptr) AS GdkDisplay Ptr
Declare SUB gtk_root_set_focus CDECL(BYVAL AS GtkRoot Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_root_get_focus CDECL(BYVAL AS GtkRoot Ptr) AS GtkWidget Ptr


#DEFINE GTK_TYPE_SCALE (gtk_scale_get_type ())
#DEFINE GTK_SCALE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCALE, GtkScale))
#DEFINE GTK_SCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCALE, GtkScaleClass))
#DEFINE GTK_IS_SCALE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCALE))
#DEFINE GTK_IS_SCALE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCALE))
#DEFINE GTK_SCALE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCALE, GtkScaleClass))
Type GtkScale AS _GtkScale
Type GtkScaleClass AS _GtkScaleClass
Type _GtkScale
	AS GtkRange parent_instance
End Type
Type _GtkScaleClass
	AS GtkRangeClass parent_class
	get_layout_offsets AS SUB CDECL(BYVAL AS GtkScale Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
	AS gpointer padding(0 TO 8-1)
End Type
Type GtkScaleFormatValueFunc AS Function CDECL(BYVAL AS GtkScale Ptr, BYVAL AS DOUBLE, BYVAL AS gpointer) AS ZSTRING Ptr
Declare Function gtk_scale_get_type CDECL() AS GType
Declare Function gtk_scale_new CDECL(BYVAL AS GtkOrientation, BYVAL AS GtkAdjustment Ptr) AS GtkWidget Ptr
Declare Function gtk_scale_new_with_range CDECL(BYVAL AS GtkOrientation, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GtkWidget Ptr
Declare SUB gtk_scale_set_digits CDECL(BYVAL AS GtkScale Ptr, BYVAL AS LONG)
Declare Function gtk_scale_get_digits CDECL(BYVAL AS GtkScale Ptr) AS LONG
Declare SUB gtk_scale_set_draw_value CDECL(BYVAL AS GtkScale Ptr, BYVAL AS gboolean)
Declare Function gtk_scale_get_draw_value CDECL(BYVAL AS GtkScale Ptr) AS gboolean
Declare SUB gtk_scale_set_has_origin CDECL(BYVAL AS GtkScale Ptr, BYVAL AS gboolean)
Declare Function gtk_scale_get_has_origin CDECL(BYVAL AS GtkScale Ptr) AS gboolean
Declare SUB gtk_scale_set_value_pos CDECL(BYVAL AS GtkScale Ptr, BYVAL AS GtkPositionType)
Declare Function gtk_scale_get_value_pos CDECL(BYVAL AS GtkScale Ptr) AS GtkPositionType
Declare Function gtk_scale_get_layout CDECL(BYVAL AS GtkScale Ptr) AS PangoLayout Ptr
Declare SUB gtk_scale_get_layout_offsets CDECL(BYVAL AS GtkScale Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_scale_add_mark CDECL(BYVAL AS GtkScale Ptr, BYVAL AS DOUBLE, BYVAL AS GtkPositionType, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_scale_clear_marks CDECL(BYVAL AS GtkScale Ptr)
Declare SUB gtk_scale_set_format_value_func CDECL(BYVAL AS GtkScale Ptr, BYVAL AS GtkScaleFormatValueFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)

#DEFINE GTK_TYPE_SCALE_BUTTON (gtk_scale_button_get_type ())
#DEFINE GTK_SCALE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCALE_BUTTON, GtkScaleButton))
#DEFINE GTK_SCALE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_SCALE_BUTTON, GtkScaleButtonClass))
#DEFINE GTK_IS_SCALE_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCALE_BUTTON))
#DEFINE GTK_IS_SCALE_BUTTON_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_SCALE_BUTTON))
#DEFINE GTK_SCALE_BUTTON_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_SCALE_BUTTON, GtkScaleButtonClass))
Type GtkScaleButton AS _GtkScaleButton
Type GtkScaleButtonClass AS _GtkScaleButtonClass
Type _GtkScaleButton
	AS GtkWidget parent_instance
End Type
Type _GtkScaleButtonClass
	AS GtkWidgetClass parent_class
	value_changed AS SUB CDECL(BYVAL AS GtkScaleButton Ptr, BYVAL AS DOUBLE)
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_scale_button_get_type CDECL() AS GType
Declare Function gtk_scale_button_new CDECL(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS Const ZSTRING Ptr Ptr) AS GtkWidget Ptr
Declare SUB gtk_scale_button_set_icons CDECL(BYVAL AS GtkScaleButton Ptr, BYVAL AS Const ZSTRING Ptr Ptr)
Declare Function gtk_scale_button_get_value CDECL(BYVAL AS GtkScaleButton Ptr) AS DOUBLE
Declare SUB gtk_scale_button_set_value CDECL(BYVAL AS GtkScaleButton Ptr, BYVAL AS DOUBLE)
Declare Function gtk_scale_button_get_adjustment CDECL(BYVAL AS GtkScaleButton Ptr) AS GtkAdjustment Ptr
Declare SUB gtk_scale_button_set_adjustment CDECL(BYVAL AS GtkScaleButton Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_scale_button_get_plus_button CDECL(BYVAL AS GtkScaleButton Ptr) AS GtkWidget Ptr
Declare Function gtk_scale_button_get_minus_button CDECL(BYVAL AS GtkScaleButton Ptr) AS GtkWidget Ptr
Declare Function gtk_scale_button_get_popup CDECL(BYVAL AS GtkScaleButton Ptr) AS GtkWidget Ptr
Declare Function gtk_scale_button_get_active CDECL(BYVAL AS GtkScaleButton Ptr) AS gboolean
Declare Function gtk_scale_button_get_has_frame CDECL(BYVAL AS GtkScaleButton Ptr) AS gboolean
Declare SUB gtk_scale_button_set_has_frame CDECL(BYVAL AS GtkScaleButton Ptr, BYVAL AS gboolean)

#DEFINE GTK_TYPE_SCROLLABLE (gtk_scrollable_get_type ())
#DEFINE GTK_SCROLLABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLABLE, GtkScrollable))
#DEFINE GTK_IS_SCROLLABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLABLE))
#DEFINE GTK_SCROLLABLE_GET_IFACE(inst) (G_TYPE_INSTANCE_GET_INTERFACE ((inst), GTK_TYPE_SCROLLABLE, GtkScrollableInterface))
Type GtkScrollable AS _GtkScrollable
Type GtkScrollableInterface AS _GtkScrollableInterface
Type _GtkScrollableInterface
	AS GTypeInterface base_iface
	get_border AS Function CDECL(BYVAL AS GtkScrollable Ptr, BYVAL AS GtkBorder Ptr) AS gboolean
End Type
Declare Function gtk_scrollable_get_type CDECL() AS GType
Declare Function gtk_scrollable_get_hadjustment CDECL(BYVAL AS GtkScrollable Ptr) AS GtkAdjustment Ptr
Declare SUB gtk_scrollable_set_hadjustment CDECL(BYVAL AS GtkScrollable Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_scrollable_get_vadjustment CDECL(BYVAL AS GtkScrollable Ptr) AS GtkAdjustment Ptr
Declare SUB gtk_scrollable_set_vadjustment CDECL(BYVAL AS GtkScrollable Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_scrollable_get_hscroll_policy CDECL(BYVAL AS GtkScrollable Ptr) AS GtkScrollablePolicy
Declare SUB gtk_scrollable_set_hscroll_policy CDECL(BYVAL AS GtkScrollable Ptr, BYVAL AS GtkScrollablePolicy)
Declare Function gtk_scrollable_get_vscroll_policy CDECL(BYVAL AS GtkScrollable Ptr) AS GtkScrollablePolicy
Declare SUB gtk_scrollable_set_vscroll_policy CDECL(BYVAL AS GtkScrollable Ptr, BYVAL AS GtkScrollablePolicy)
Declare Function gtk_scrollable_get_border CDECL(BYVAL AS GtkScrollable Ptr, BYVAL AS GtkBorder Ptr) AS gboolean

#DEFINE GTK_TYPE_SCROLLBAR (gtk_scrollbar_get_type ())
#DEFINE GTK_SCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLBAR, GtkScrollbar))
#DEFINE GTK_IS_SCROLLBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLBAR))
Type GtkScrollbar AS _GtkScrollbar
Declare Function gtk_scrollbar_get_type CDECL() AS GType
Declare Function gtk_scrollbar_new CDECL(BYVAL AS GtkOrientation, BYVAL AS GtkAdjustment Ptr) AS GtkWidget Ptr
Declare SUB gtk_scrollbar_set_adjustment CDECL(BYVAL AS GtkScrollbar Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_scrollbar_get_adjustment CDECL(BYVAL AS GtkScrollbar Ptr) AS GtkAdjustment Ptr

#DEFINE GTK_TYPE_SCROLL_INFO (gtk_scroll_info_get_type ())
Declare Function gtk_scroll_info_get_type CDECL() AS GType
Declare Function gtk_scroll_info_new CDECL() AS GtkScrollInfo Ptr
Declare Function gtk_scroll_info_ref CDECL(BYVAL AS GtkScrollInfo Ptr) AS GtkScrollInfo Ptr
Declare SUB gtk_scroll_info_unref CDECL(BYVAL AS GtkScrollInfo Ptr)
Declare SUB gtk_scroll_info_set_enable_horizontal CDECL(BYVAL AS GtkScrollInfo Ptr, BYVAL AS gboolean)
Declare Function gtk_scroll_info_get_enable_horizontal CDECL(BYVAL AS GtkScrollInfo Ptr) AS gboolean
Declare SUB gtk_scroll_info_set_enable_vertical CDECL(BYVAL AS GtkScrollInfo Ptr, BYVAL AS gboolean)
Declare Function gtk_scroll_info_get_enable_vertical CDECL(BYVAL AS GtkScrollInfo Ptr) AS gboolean

#DEFINE GTK_TYPE_SCROLLED_WINDOW (gtk_scrolled_window_get_type ())
#DEFINE GTK_SCROLLED_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SCROLLED_WINDOW, GtkScrolledWindow))
#DEFINE GTK_IS_SCROLLED_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SCROLLED_WINDOW))
Type GtkScrolledWindow AS _GtkScrolledWindow
Enum GtkCornerType_
	GTK_CORNER_TOP_LEFT
	GTK_CORNER_BOTTOM_LEFT
	GTK_CORNER_TOP_RIGHT
	GTK_CORNER_BOTTOM_RIGHT
End Enum
Type AS LONG GtkCornerType
Enum GtkPolicyType_
	GTK_POLICY_ALWAYS
	GTK_POLICY_AUTOMATIC
	GTK_POLICY_NEVER
	GTK_POLICY_EXTERNAL
End Enum
Type AS LONG GtkPolicyType
Declare Function gtk_scrolled_window_get_type CDECL() AS GType
Declare Function gtk_scrolled_window_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_scrolled_window_set_hadjustment CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS GtkAdjustment Ptr)
Declare SUB gtk_scrolled_window_set_vadjustment CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_scrolled_window_get_hadjustment CDECL(BYVAL AS GtkScrolledWindow Ptr) AS GtkAdjustment Ptr
Declare Function gtk_scrolled_window_get_vadjustment CDECL(BYVAL AS GtkScrolledWindow Ptr) AS GtkAdjustment Ptr
Declare Function gtk_scrolled_window_get_hscrollbar CDECL(BYVAL AS GtkScrolledWindow Ptr) AS GtkWidget Ptr
Declare Function gtk_scrolled_window_get_vscrollbar CDECL(BYVAL AS GtkScrolledWindow Ptr) AS GtkWidget Ptr
Declare SUB gtk_scrolled_window_set_policy CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS GtkPolicyType, BYVAL AS GtkPolicyType)
Declare SUB gtk_scrolled_window_get_policy CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS GtkPolicyType Ptr, BYVAL AS GtkPolicyType Ptr)
Declare SUB gtk_scrolled_window_set_placement CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS GtkCornerType)
Declare SUB gtk_scrolled_window_unset_placement CDECL(BYVAL AS GtkScrolledWindow Ptr)
Declare Function gtk_scrolled_window_get_placement CDECL(BYVAL AS GtkScrolledWindow Ptr) AS GtkCornerType
Declare SUB gtk_scrolled_window_set_has_frame CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_scrolled_window_get_has_frame CDECL(BYVAL AS GtkScrolledWindow Ptr) AS gboolean
Declare Function gtk_scrolled_window_get_min_content_width CDECL(BYVAL AS GtkScrolledWindow Ptr) AS LONG
Declare SUB gtk_scrolled_window_set_min_content_width CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS LONG)
Declare Function gtk_scrolled_window_get_min_content_height CDECL(BYVAL AS GtkScrolledWindow Ptr) AS LONG
Declare SUB gtk_scrolled_window_set_min_content_height CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS LONG)
Declare SUB gtk_scrolled_window_set_kinetic_scrolling CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_scrolled_window_get_kinetic_scrolling CDECL(BYVAL AS GtkScrolledWindow Ptr) AS gboolean
Declare SUB gtk_scrolled_window_set_overlay_scrolling CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_scrolled_window_get_overlay_scrolling CDECL(BYVAL AS GtkScrolledWindow Ptr) AS gboolean
Declare SUB gtk_scrolled_window_set_max_content_width CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS LONG)
Declare Function gtk_scrolled_window_get_max_content_width CDECL(BYVAL AS GtkScrolledWindow Ptr) AS LONG
Declare SUB gtk_scrolled_window_set_max_content_height CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS LONG)
Declare Function gtk_scrolled_window_get_max_content_height CDECL(BYVAL AS GtkScrolledWindow Ptr) AS LONG
Declare SUB gtk_scrolled_window_set_propagate_natural_width CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_scrolled_window_get_propagate_natural_width CDECL(BYVAL AS GtkScrolledWindow Ptr) AS gboolean
Declare SUB gtk_scrolled_window_set_propagate_natural_height CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS gboolean)
Declare Function gtk_scrolled_window_get_propagate_natural_height CDECL(BYVAL AS GtkScrolledWindow Ptr) AS gboolean
Declare SUB gtk_scrolled_window_set_child CDECL(BYVAL AS GtkScrolledWindow Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_scrolled_window_get_child CDECL(BYVAL AS GtkScrolledWindow Ptr) AS GtkWidget Ptr


#DEFINE GTK_TYPE_SEARCH_BAR (gtk_search_bar_get_type ())
#DEFINE GTK_SEARCH_BAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEARCH_BAR, GtkSearchBar))
#DEFINE GTK_IS_SEARCH_BAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEARCH_BAR))
Type GtkSearchBar AS _GtkSearchBar
Declare Function gtk_search_bar_get_type CDECL() AS GType
Declare Function gtk_search_bar_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_search_bar_connect_entry CDECL(BYVAL AS GtkSearchBar Ptr, BYVAL AS GtkEditable Ptr)
Declare Function gtk_search_bar_get_search_mode CDECL(BYVAL AS GtkSearchBar Ptr) AS gboolean
Declare SUB gtk_search_bar_set_search_mode CDECL(BYVAL AS GtkSearchBar Ptr, BYVAL AS gboolean)
Declare Function gtk_search_bar_get_show_close_button CDECL(BYVAL AS GtkSearchBar Ptr) AS gboolean
Declare SUB gtk_search_bar_set_show_close_button CDECL(BYVAL AS GtkSearchBar Ptr, BYVAL AS gboolean)
Declare SUB gtk_search_bar_set_key_capture_widget CDECL(BYVAL AS GtkSearchBar Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_search_bar_get_key_capture_widget CDECL(BYVAL AS GtkSearchBar Ptr) AS GtkWidget Ptr
Declare SUB gtk_search_bar_set_child CDECL(BYVAL AS GtkSearchBar Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_search_bar_get_child CDECL(BYVAL AS GtkSearchBar Ptr) AS GtkWidget Ptr

#DEFINE GTK_TYPE_SEARCH_ENTRY (gtk_search_entry_get_type ())
#DEFINE GTK_SEARCH_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEARCH_ENTRY, GtkSearchEntry))
#DEFINE GTK_IS_SEARCH_ENTRY(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEARCH_ENTRY))
Type GtkSearchEntry AS _GtkSearchEntry
Declare Function gtk_search_entry_get_type CDECL() AS GType
Declare Function gtk_search_entry_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_search_entry_set_key_capture_widget CDECL(BYVAL AS GtkSearchEntry Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_search_entry_get_key_capture_widget CDECL(BYVAL AS GtkSearchEntry Ptr) AS GtkWidget Ptr
Declare SUB gtk_search_entry_set_search_delay CDECL(BYVAL AS GtkSearchEntry Ptr, BYVAL AS guint)
Declare Function gtk_search_entry_get_search_delay CDECL(BYVAL AS GtkSearchEntry Ptr) AS guint
Declare SUB gtk_search_entry_set_placeholder_text CDECL(BYVAL AS GtkSearchEntry Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_search_entry_get_placeholder_text CDECL(BYVAL AS GtkSearchEntry Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_search_entry_set_input_purpose CDECL(BYVAL AS GtkSearchEntry Ptr, BYVAL AS GtkInputPurpose)
Declare Function gtk_search_entry_get_input_purpose CDECL(BYVAL AS GtkSearchEntry Ptr) AS GtkInputPurpose
Declare SUB gtk_search_entry_set_input_hints CDECL(BYVAL AS GtkSearchEntry Ptr, BYVAL AS GtkInputHints)
Declare Function gtk_search_entry_get_input_hints CDECL(BYVAL AS GtkSearchEntry Ptr) AS GtkInputHints

#DEFINE GTK_TYPE_SECTION_MODEL (gtk_section_model_get_type ())
Type GtkSectionModel AS _GtkSectionModel
Type _GtkSectionModelInterface
	AS GTypeInterface g_iface
	get_section AS SUB CDECL(BYVAL AS GtkSectionModel Ptr, BYVAL AS guint, BYVAL AS guint Ptr, BYVAL AS guint Ptr)
End Type
Declare SUB gtk_section_model_get_section CDECL(BYVAL AS GtkSectionModel Ptr, BYVAL AS guint, BYVAL AS guint Ptr, BYVAL AS guint Ptr)
Declare SUB gtk_section_model_sections_changed CDECL(BYVAL AS GtkSectionModel Ptr, BYVAL AS guint, BYVAL AS guint)


#DEFINE GTK_TYPE_SELECTION_FILTER_MODEL (gtk_selection_filter_model_get_type ())
Type GtkSelectionFilterModel AS _GtkSelectionFilterModel
Declare Function gtk_selection_filter_model_new CDECL(BYVAL AS GtkSelectionModel Ptr) AS GtkSelectionFilterModel Ptr
Declare SUB gtk_selection_filter_model_set_model CDECL(BYVAL AS GtkSelectionFilterModel Ptr, BYVAL AS GtkSelectionModel Ptr)
Declare Function gtk_selection_filter_model_get_model CDECL(BYVAL AS GtkSelectionFilterModel Ptr) AS GtkSelectionModel Ptr

#DEFINE GTK_TYPE_SEPARATOR (gtk_separator_get_type ())
#DEFINE GTK_SEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SEPARATOR, GtkSeparator))
#DEFINE GTK_IS_SEPARATOR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SEPARATOR))
Type GtkSeparator AS _GtkSeparator
Declare Function gtk_separator_get_type CDECL() AS GType
Declare Function gtk_separator_new CDECL(BYVAL AS GtkOrientation) AS GtkWidget Ptr

#DEFINE GTK_TYPE_SETTINGS (gtk_settings_get_type ())
#DEFINE GTK_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SETTINGS, GtkSettings))
#DEFINE GTK_IS_SETTINGS(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SETTINGS))

Declare Function gtk_settings_get_type CDECL() AS GType
Declare Function gtk_settings_get_default CDECL() AS GtkSettings Ptr
Declare Function gtk_settings_get_for_display CDECL(BYVAL AS GdkDisplay Ptr) AS GtkSettings Ptr
Declare SUB gtk_settings_reset_property CDECL(BYVAL AS GtkSettings Ptr, BYVAL AS Const ZSTRING Ptr)

#DEFINE GTK_TYPE_SHORTCUT_CONTROLLER (gtk_shortcut_controller_get_type ())
#DEFINE GTK_SHORTCUT_CONTROLLER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_SHORTCUT_CONTROLLER, GtkShortcutController))
#DEFINE GTK_SHORTCUT_CONTROLLER_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_SHORTCUT_CONTROLLER, GtkShortcutControllerClass))
#DEFINE GTK_IS_SHORTCUT_CONTROLLER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_SHORTCUT_CONTROLLER))
#DEFINE GTK_IS_SHORTCUT_CONTROLLER_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_SHORTCUT_CONTROLLER))
#DEFINE GTK_SHORTCUT_CONTROLLER_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_SHORTCUT_CONTROLLER, GtkShortcutControllerClass))
Type GtkShortcutController AS _GtkShortcutController
Type GtkShortcutControllerClass AS _GtkShortcutControllerClass
Declare Function gtk_shortcut_controller_get_type CDECL() AS GType
Declare Function gtk_shortcut_controller_new CDECL() AS GtkEventController Ptr
Declare Function gtk_shortcut_controller_new_for_model CDECL(BYVAL AS GListModel Ptr) AS GtkEventController Ptr
Declare SUB gtk_shortcut_controller_set_mnemonics_modifiers CDECL(BYVAL AS GtkShortcutController Ptr, BYVAL AS GdkModifierType)
Declare Function gtk_shortcut_controller_get_mnemonics_modifiers CDECL(BYVAL AS GtkShortcutController Ptr) AS GdkModifierType
Declare SUB gtk_shortcut_controller_set_scope CDECL(BYVAL AS GtkShortcutController Ptr, BYVAL AS GtkShortcutScope)
Declare Function gtk_shortcut_controller_get_scope CDECL(BYVAL AS GtkShortcutController Ptr) AS GtkShortcutScope
Declare SUB gtk_shortcut_controller_add_shortcut CDECL(BYVAL AS GtkShortcutController Ptr, BYVAL AS GtkShortcut Ptr)
Declare SUB gtk_shortcut_controller_remove_shortcut CDECL(BYVAL AS GtkShortcutController Ptr, BYVAL AS GtkShortcut Ptr)


#DEFINE GTK_TYPE_SHORTCUT_MANAGER (gtk_shortcut_manager_get_type ())
Type GtkShortcutManager AS _GtkShortcutManager
Type _GtkShortcutManagerInterface
	AS GTypeInterface g_iface
	add_controller AS SUB CDECL(BYVAL AS GtkShortcutManager Ptr, BYVAL AS GtkShortcutController Ptr)
	remove_controller AS SUB CDECL(BYVAL AS GtkShortcutManager Ptr, BYVAL AS GtkShortcutController Ptr)
End Type


#DEFINE GTK_TYPE_SHORTCUT_TRIGGER (gtk_shortcut_trigger_get_type ())
Type GtkShortcutTrigger AS _GtkShortcutTrigger
Declare Function gtk_shortcut_trigger_parse_string CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkShortcutTrigger Ptr
Declare Function gtk_shortcut_trigger_to_string CDECL(BYVAL AS GtkShortcutTrigger Ptr) AS ZSTRING Ptr
Declare SUB gtk_shortcut_trigger_print CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GString Ptr)
Declare Function gtk_shortcut_trigger_to_label CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GdkDisplay Ptr) AS ZSTRING Ptr
Declare Function gtk_shortcut_trigger_print_label CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GdkDisplay Ptr, BYVAL AS GString Ptr) AS gboolean
Declare Function gtk_shortcut_trigger_hash CDECL(BYVAL AS gconstpointer) AS guint
Declare Function gtk_shortcut_trigger_equal CDECL(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
Declare Function gtk_shortcut_trigger_compare CDECL(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS LONG
Declare Function gtk_shortcut_trigger_trigger CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GdkEvent Ptr, BYVAL AS gboolean) AS GdkKeyMatch

#DEFINE GTK_TYPE_NEVER_TRIGGER (gtk_never_trigger_get_type())
Type GtkNeverTrigger AS _GtkNeverTrigger
Declare Function gtk_never_trigger_get CDECL() AS GtkShortcutTrigger Ptr

#DEFINE GTK_TYPE_KEYVAL_TRIGGER (gtk_keyval_trigger_get_type())
Type GtkKeyvalTrigger AS _GtkKeyvalTrigger
Declare Function gtk_keyval_trigger_new CDECL(BYVAL AS guint, BYVAL AS GdkModifierType) AS GtkShortcutTrigger Ptr
Declare Function gtk_keyval_trigger_get_modifiers CDECL(BYVAL AS GtkKeyvalTrigger Ptr) AS GdkModifierType
Declare Function gtk_keyval_trigger_get_keyval CDECL(BYVAL AS GtkKeyvalTrigger Ptr) AS guint

#DEFINE GTK_TYPE_MNEMONIC_TRIGGER (gtk_mnemonic_trigger_get_type())
Type GtkMnemonicTrigger AS _GtkMnemonicTrigger
Declare Function gtk_mnemonic_trigger_new CDECL(BYVAL AS guint) AS GtkShortcutTrigger Ptr
Declare Function gtk_mnemonic_trigger_get_keyval CDECL(BYVAL AS GtkMnemonicTrigger Ptr) AS guint

#DEFINE GTK_TYPE_ALTERNATIVE_TRIGGER (gtk_alternative_trigger_get_type())
Type GtkAlternativeTrigger AS _GtkAlternativeTrigger
Declare Function gtk_alternative_trigger_new CDECL(BYVAL AS GtkShortcutTrigger Ptr, BYVAL AS GtkShortcutTrigger Ptr) AS GtkShortcutTrigger Ptr
Declare Function gtk_alternative_trigger_get_first CDECL(BYVAL AS GtkAlternativeTrigger Ptr) AS GtkShortcutTrigger Ptr
Declare Function gtk_alternative_trigger_get_second CDECL(BYVAL AS GtkAlternativeTrigger Ptr) AS GtkShortcutTrigger Ptr

#DEFINE GTK_TYPE_SIGNAL_LIST_ITEM_FACTORY (gtk_signal_list_item_factory_get_type ())
#DEFINE GTK_SIGNAL_LIST_ITEM_FACTORY(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_SIGNAL_LIST_ITEM_FACTORY, GtkSignalListItemFactory))
#DEFINE GTK_SIGNAL_LIST_ITEM_FACTORY_CLASS(k) (G_TYPE_CHECK_CLASS_CAST ((k), GTK_TYPE_SIGNAL_LIST_ITEM_FACTORY, GtkSignalListItemFactoryClass))
#DEFINE GTK_IS_SIGNAL_LIST_ITEM_FACTORY(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_SIGNAL_LIST_ITEM_FACTORY))
#DEFINE GTK_IS_SIGNAL_LIST_ITEM_FACTORY_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GTK_TYPE_SIGNAL_LIST_ITEM_FACTORY))
#DEFINE GTK_SIGNAL_LIST_ITEM_FACTORY_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GTK_TYPE_SIGNAL_LIST_ITEM_FACTORY, GtkSignalListItemFactoryClass))
Type GtkSignalListItemFactory AS _GtkSignalListItemFactory
Type GtkSignalListItemFactoryClass AS _GtkSignalListItemFactoryClass
Declare Function gtk_signal_list_item_factory_get_type CDECL() AS GType
Declare Function gtk_signal_list_item_factory_new CDECL() AS GtkListItemFactory Ptr

#DEFINE GTK_TYPE_SINGLE_SELECTION (gtk_single_selection_get_type ())
Type GtkSingleSelection AS _GtkSingleSelection
Declare Function gtk_single_selection_new CDECL(BYVAL AS GListModel Ptr) AS GtkSingleSelection Ptr
Declare Function gtk_single_selection_get_model CDECL(BYVAL AS GtkSingleSelection Ptr) AS GListModel Ptr
Declare SUB gtk_single_selection_set_model CDECL(BYVAL AS GtkSingleSelection Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_single_selection_get_selected CDECL(BYVAL AS GtkSingleSelection Ptr) AS guint
Declare SUB gtk_single_selection_set_selected CDECL(BYVAL AS GtkSingleSelection Ptr, BYVAL AS guint)
Declare Function gtk_single_selection_get_selected_item CDECL(BYVAL AS GtkSingleSelection Ptr) AS gpointer
Declare Function gtk_single_selection_get_autoselect CDECL(BYVAL AS GtkSingleSelection Ptr) AS gboolean
Declare SUB gtk_single_selection_set_autoselect CDECL(BYVAL AS GtkSingleSelection Ptr, BYVAL AS gboolean)
Declare Function gtk_single_selection_get_can_unselect CDECL(BYVAL AS GtkSingleSelection Ptr) AS gboolean
Declare SUB gtk_single_selection_set_can_unselect CDECL(BYVAL AS GtkSingleSelection Ptr, BYVAL AS gboolean)

#DEFINE GTK_TYPE_SLICE_LIST_MODEL (gtk_slice_list_model_get_type ())
Type GtkSliceListModel AS _GtkSliceListModel
Declare Function gtk_slice_list_model_new CDECL(BYVAL AS GListModel Ptr, BYVAL AS guint, BYVAL AS guint) AS GtkSliceListModel Ptr
Declare SUB gtk_slice_list_model_set_model CDECL(BYVAL AS GtkSliceListModel Ptr, BYVAL AS GListModel Ptr)
Declare Function gtk_slice_list_model_get_model CDECL(BYVAL AS GtkSliceListModel Ptr) AS GListModel Ptr
Declare SUB gtk_slice_list_model_set_offset CDECL(BYVAL AS GtkSliceListModel Ptr, BYVAL AS guint)
Declare Function gtk_slice_list_model_get_offset CDECL(BYVAL AS GtkSliceListModel Ptr) AS guint
Declare SUB gtk_slice_list_model_set_size CDECL(BYVAL AS GtkSliceListModel Ptr, BYVAL AS guint)
Declare Function gtk_slice_list_model_get_size CDECL(BYVAL AS GtkSliceListModel Ptr) AS guint

Type GtkSnapshotClass AS _GtkSnapshotClass
#DEFINE GTK_TYPE_SNAPSHOT (gtk_snapshot_get_type ())
#DEFINE GTK_SNAPSHOT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SNAPSHOT, GtkSnapshot))
#DEFINE GTK_IS_SNAPSHOT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SNAPSHOT))
Declare Function gtk_snapshot_get_type CDECL() AS GType
Declare Function gtk_snapshot_new CDECL() AS GtkSnapshot Ptr
Declare Function gtk_snapshot_free_to_node CDECL(BYVAL AS GtkSnapshot Ptr) AS GskRenderNode Ptr
Declare Function gtk_snapshot_free_to_paintable CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_size_t Ptr) AS GdkPaintable Ptr
Declare Function gtk_snapshot_to_node CDECL(BYVAL AS GtkSnapshot Ptr) AS GskRenderNode Ptr
Declare Function gtk_snapshot_to_paintable CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_size_t Ptr) AS GdkPaintable Ptr
Declare SUB GtkSnapshot CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const ZSTRING Ptr, ...) '??? macro expansion
Declare SUB gtk_snapshot_push_opacity CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_snapshot_push_blur CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_snapshot_push_color_matrix CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_matrix_t Ptr, BYVAL AS Const graphene_vec4_t Ptr)
Declare SUB gtk_snapshot_push_repeat CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_rect_t Ptr)
Declare SUB gtk_snapshot_push_clip CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr)
Declare SUB gtk_snapshot_push_rounded_clip CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const GskRoundedRect Ptr)
Declare SUB gtk_snapshot_push_fill CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskPath Ptr, BYVAL AS GskFillRule)
Declare SUB gtk_snapshot_push_stroke CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskPath Ptr, BYVAL AS Const GskStroke Ptr)
Declare SUB gtk_snapshot_push_shadow CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const GskShadow Ptr, BYVAL AS gsize)
Declare SUB gtk_snapshot_push_blend CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskBlendMode)
Declare SUB gtk_snapshot_push_mask CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskMaskMode)
Declare SUB gtk_snapshot_push_cross_fade CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_snapshot_pop CDECL(BYVAL AS GtkSnapshot Ptr)
Declare SUB gtk_snapshot_save CDECL(BYVAL AS GtkSnapshot Ptr)
Declare SUB gtk_snapshot_restore CDECL(BYVAL AS GtkSnapshot Ptr)
Declare SUB gtk_snapshot_transform CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskTransform Ptr)
Declare SUB gtk_snapshot_transform_matrix CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_matrix_t Ptr)
Declare SUB gtk_snapshot_translate CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_point_t Ptr)
Declare SUB gtk_snapshot_translate_3d CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_point3d_t Ptr)
Declare SUB gtk_snapshot_rotate CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS SINGLE)
Declare SUB gtk_snapshot_rotate_3d CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS SINGLE, BYVAL AS Const graphene_vec3_t Ptr)
Declare SUB gtk_snapshot_scale CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE)
Declare SUB gtk_snapshot_scale_3d CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE)
Declare SUB gtk_snapshot_perspective CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS SINGLE)
Declare SUB gtk_snapshot_append_node CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskRenderNode Ptr)
Declare Function gtk_snapshot_append_cairo CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr) AS cairo_t Ptr
Declare SUB gtk_snapshot_append_texture CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GdkTexture Ptr, BYVAL AS Const graphene_rect_t Ptr)
Declare SUB gtk_snapshot_append_scaled_texture CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GdkTexture Ptr, BYVAL AS GskScalingFilter, BYVAL AS Const graphene_rect_t Ptr)
Declare SUB gtk_snapshot_append_color CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const GdkRGBA Ptr, BYVAL AS Const graphene_rect_t Ptr)
Declare SUB gtk_snapshot_append_linear_gradient CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const GskColorStop Ptr, BYVAL AS gsize)
Declare SUB gtk_snapshot_append_repeating_linear_gradient CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS Const GskColorStop Ptr, BYVAL AS gsize)
Declare SUB gtk_snapshot_append_radial_gradient CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS Const GskColorStop Ptr, BYVAL AS gsize)
Declare SUB gtk_snapshot_append_repeating_radial_gradient CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS Const GskColorStop Ptr, BYVAL AS gsize)
Declare SUB gtk_snapshot_append_conic_gradient CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const graphene_rect_t Ptr, BYVAL AS Const graphene_point_t Ptr, BYVAL AS SINGLE, BYVAL AS Const GskColorStop Ptr, BYVAL AS gsize)
Declare SUB gtk_snapshot_append_border CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const GskRoundedRect Ptr, BYVAL AS Const SINGLE Ptr, BYVAL AS Const GdkRGBA Ptr)
Declare SUB gtk_snapshot_append_inset_shadow CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const GskRoundedRect Ptr, BYVAL AS Const GdkRGBA Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE)
Declare SUB gtk_snapshot_append_outset_shadow CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS Const GskRoundedRect Ptr, BYVAL AS Const GdkRGBA Ptr, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE, BYVAL AS SINGLE)
Declare SUB gtk_snapshot_append_layout CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS PangoLayout Ptr, BYVAL AS Const GdkRGBA Ptr)
Declare SUB gtk_snapshot_append_fill CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskPath Ptr, BYVAL AS GskFillRule, BYVAL AS Const GdkRGBA Ptr)
Declare SUB gtk_snapshot_append_stroke CDECL(BYVAL AS GtkSnapshot Ptr, BYVAL AS GskPath Ptr, BYVAL AS Const GskStroke Ptr, BYVAL AS Const GdkRGBA Ptr)

#DEFINE GTK_TYPE_STACK (gtk_stack_get_type ())
#DEFINE GTK_STACK(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_STACK, GtkStack))
#DEFINE GTK_IS_STACK(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_STACK))
Type GtkStack AS _GtkStack

#DEFINE GTK_TYPE_STACK_PAGE (gtk_stack_page_get_type ())
#DEFINE GTK_STACK_PAGE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_STACK_PAGE, GtkStackPage))
#DEFINE GTK_IS_STACK_PAGE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_STACK_PAGE))
Type GtkStackPage AS _GtkStackPage
Enum GtkStackTransitionType_
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
	GTK_STACK_TRANSITION_TYPE_ROTATE_LEFT
	GTK_STACK_TRANSITION_TYPE_ROTATE_RIGHT
	GTK_STACK_TRANSITION_TYPE_ROTATE_LEFT_RIGHT
End Enum
Type AS LONG GtkStackTransitionType
Declare Function gtk_stack_page_get_type CDECL() AS GType
Declare Function gtk_stack_page_get_child CDECL(BYVAL AS GtkStackPage Ptr) AS GtkWidget Ptr
Declare Function gtk_stack_page_get_visible CDECL(BYVAL AS GtkStackPage Ptr) AS gboolean
Declare SUB gtk_stack_page_set_visible CDECL(BYVAL AS GtkStackPage Ptr, BYVAL AS gboolean)
Declare Function gtk_stack_page_get_needs_attention CDECL(BYVAL AS GtkStackPage Ptr) AS gboolean
Declare SUB gtk_stack_page_set_needs_attention CDECL(BYVAL AS GtkStackPage Ptr, BYVAL AS gboolean)
Declare Function gtk_stack_page_get_use_underline CDECL(BYVAL AS GtkStackPage Ptr) AS gboolean
Declare SUB gtk_stack_page_set_use_underline CDECL(BYVAL AS GtkStackPage Ptr, BYVAL AS gboolean)
Declare Function gtk_stack_page_get_name CDECL(BYVAL AS GtkStackPage Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_stack_page_set_name CDECL(BYVAL AS GtkStackPage Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_stack_page_get_title CDECL(BYVAL AS GtkStackPage Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_stack_page_set_title CDECL(BYVAL AS GtkStackPage Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_stack_page_get_icon_name CDECL(BYVAL AS GtkStackPage Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_stack_page_set_icon_name CDECL(BYVAL AS GtkStackPage Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_stack_get_type CDECL() AS GType
Declare Function gtk_stack_new CDECL() AS GtkWidget Ptr
Declare Function gtk_stack_add_child CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkWidget Ptr) AS GtkStackPage Ptr
Declare Function gtk_stack_add_named CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkStackPage Ptr
Declare Function gtk_stack_add_titled CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkStackPage Ptr
Declare SUB gtk_stack_remove CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_stack_get_page CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkWidget Ptr) AS GtkStackPage Ptr
Declare Function gtk_stack_get_child_by_name CDECL(BYVAL AS GtkStack Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare SUB gtk_stack_set_visible_child CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_stack_get_visible_child CDECL(BYVAL AS GtkStack Ptr) AS GtkWidget Ptr
Declare SUB gtk_stack_set_visible_child_name CDECL(BYVAL AS GtkStack Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_stack_get_visible_child_name CDECL(BYVAL AS GtkStack Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_stack_set_visible_child_full CDECL(BYVAL AS GtkStack Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkStackTransitionType)
Declare SUB gtk_stack_set_hhomogeneous CDECL(BYVAL AS GtkStack Ptr, BYVAL AS gboolean)
Declare Function gtk_stack_get_hhomogeneous CDECL(BYVAL AS GtkStack Ptr) AS gboolean
Declare SUB gtk_stack_set_vhomogeneous CDECL(BYVAL AS GtkStack Ptr, BYVAL AS gboolean)
Declare Function gtk_stack_get_vhomogeneous CDECL(BYVAL AS GtkStack Ptr) AS gboolean
Declare SUB gtk_stack_set_transition_duration CDECL(BYVAL AS GtkStack Ptr, BYVAL AS guint)
Declare Function gtk_stack_get_transition_duration CDECL(BYVAL AS GtkStack Ptr) AS guint
Declare SUB gtk_stack_set_transition_type CDECL(BYVAL AS GtkStack Ptr, BYVAL AS GtkStackTransitionType)
Declare Function gtk_stack_get_transition_type CDECL(BYVAL AS GtkStack Ptr) AS GtkStackTransitionType
Declare Function gtk_stack_get_transition_running CDECL(BYVAL AS GtkStack Ptr) AS gboolean
Declare SUB gtk_stack_set_interpolate_size CDECL(BYVAL AS GtkStack Ptr, BYVAL AS gboolean)
Declare Function gtk_stack_get_interpolate_size CDECL(BYVAL AS GtkStack Ptr) AS gboolean
Declare Function gtk_stack_get_pages CDECL(BYVAL AS GtkStack Ptr) AS GtkSelectionModel Ptr

#DEFINE GTK_TYPE_STACK_SIDEBAR (gtk_stack_sidebar_get_type ())
#DEFINE GTK_STACK_SIDEBAR(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_STACK_SIDEBAR, GtkStackSidebar))
#DEFINE GTK_IS_STACK_SIDEBAR(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_STACK_SIDEBAR))
Type GtkStackSidebar AS _GtkStackSidebar
Declare Function gtk_stack_sidebar_get_type CDECL() AS GType
Declare Function gtk_stack_sidebar_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_stack_sidebar_set_stack CDECL(BYVAL AS GtkStackSidebar Ptr, BYVAL AS GtkStack Ptr)
Declare Function gtk_stack_sidebar_get_stack CDECL(BYVAL AS GtkStackSidebar Ptr) AS GtkStack Ptr


#DEFINE GTK_TYPE_SIZE_GROUP (gtk_size_group_get_type ())
#DEFINE GTK_SIZE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SIZE_GROUP, GtkSizeGroup))
#DEFINE GTK_IS_SIZE_GROUP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SIZE_GROUP))
Type GtkSizeGroup AS _GtkSizeGroup
Type _GtkSizeGroup
	AS GObject parent_instance
End Type
Declare Function gtk_size_group_get_type CDECL() AS GType
Declare Function gtk_size_group_new CDECL(BYVAL AS GtkSizeGroupMode) AS GtkSizeGroup Ptr
Declare SUB gtk_size_group_set_mode CDECL(BYVAL AS GtkSizeGroup Ptr, BYVAL AS GtkSizeGroupMode)
Declare Function gtk_size_group_get_mode CDECL(BYVAL AS GtkSizeGroup Ptr) AS GtkSizeGroupMode
Declare SUB gtk_size_group_add_widget CDECL(BYVAL AS GtkSizeGroup Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_size_group_remove_widget CDECL(BYVAL AS GtkSizeGroup Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_size_group_get_widgets CDECL(BYVAL AS GtkSizeGroup Ptr) AS GSList Ptr


Type GtkRequestedSize AS _GtkRequestedSize
Type _GtkRequestedSize
	AS gpointer data
	AS LONG minimum_size
	AS LONG natural_size
End Type
Declare Function gtk_distribute_natural_allocation CDECL(BYVAL AS LONG, BYVAL AS guint, BYVAL AS GtkRequestedSize Ptr) AS LONG


#DEFINE GTK_TYPE_SPIN_BUTTON (gtk_spin_button_get_type ())
#DEFINE GTK_SPIN_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SPIN_BUTTON, GtkSpinButton))
#DEFINE GTK_IS_SPIN_BUTTON(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SPIN_BUTTON))
#DEFINE GTK_INPUT_ERROR -1

Enum GtkSpinButtonUpdatePolicy_
	GTK_UPDATE_ALWAYS
	GTK_UPDATE_IF_VALID
End Enum
Type AS LONG GtkSpinButtonUpdatePolicy

Enum GtkSpinType_
	GTK_SPIN_STEP_FORWARD
	GTK_SPIN_STEP_BACKWARD
	GTK_SPIN_PAGE_FORWARD
	GTK_SPIN_PAGE_BACKWARD
	GTK_SPIN_HOME
	GTK_SPIN_END
	GTK_SPIN_USER_DEFINED
End Enum
Type AS LONG GtkSpinType
Type GtkSpinButton AS _GtkSpinButton
Declare Function gtk_spin_button_get_type CDECL() AS GType
Declare SUB gtk_spin_button_configure CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE, BYVAL AS guint)
Declare Function gtk_spin_button_new CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS DOUBLE, BYVAL AS guint) AS GtkWidget Ptr
Declare Function gtk_spin_button_new_with_range CDECL(BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS GtkWidget Ptr
Declare SUB gtk_spin_button_set_activates_default CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS gboolean)
Declare Function gtk_spin_button_get_activates_default CDECL(BYVAL AS GtkSpinButton Ptr) AS gboolean
Declare SUB gtk_spin_button_set_adjustment CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS GtkAdjustment Ptr)
Declare Function gtk_spin_button_get_adjustment CDECL(BYVAL AS GtkSpinButton Ptr) AS GtkAdjustment Ptr
Declare SUB gtk_spin_button_set_digits CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS guint)
Declare Function gtk_spin_button_get_digits CDECL(BYVAL AS GtkSpinButton Ptr) AS guint
Declare SUB gtk_spin_button_set_increments CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_spin_button_get_increments CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare SUB gtk_spin_button_set_range CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_spin_button_get_range CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare Function gtk_spin_button_get_value CDECL(BYVAL AS GtkSpinButton Ptr) AS DOUBLE
Declare Function gtk_spin_button_get_value_as_int CDECL(BYVAL AS GtkSpinButton Ptr) AS LONG
Declare SUB gtk_spin_button_set_value CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS DOUBLE)
Declare SUB gtk_spin_button_set_update_policy CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS GtkSpinButtonUpdatePolicy)
Declare Function gtk_spin_button_get_update_policy CDECL(BYVAL AS GtkSpinButton Ptr) AS GtkSpinButtonUpdatePolicy
Declare SUB gtk_spin_button_set_numeric CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS gboolean)
Declare Function gtk_spin_button_get_numeric CDECL(BYVAL AS GtkSpinButton Ptr) AS gboolean
Declare SUB gtk_spin_button_spin CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS GtkSpinType, BYVAL AS DOUBLE)
Declare SUB gtk_spin_button_set_wrap CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS gboolean)
Declare Function gtk_spin_button_get_wrap CDECL(BYVAL AS GtkSpinButton Ptr) AS gboolean
Declare SUB gtk_spin_button_set_snap_to_ticks CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS gboolean)
Declare Function gtk_spin_button_get_snap_to_ticks CDECL(BYVAL AS GtkSpinButton Ptr) AS gboolean
Declare SUB gtk_spin_button_set_climb_rate CDECL(BYVAL AS GtkSpinButton Ptr, BYVAL AS DOUBLE)
Declare Function gtk_spin_button_get_climb_rate CDECL(BYVAL AS GtkSpinButton Ptr) AS DOUBLE
Declare SUB gtk_spin_button_update CDECL(BYVAL AS GtkSpinButton Ptr)


#DEFINE GTK_TYPE_SPINNER (gtk_spinner_get_type ())
#DEFINE GTK_SPINNER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SPINNER, GtkSpinner))
#DEFINE GTK_IS_SPINNER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SPINNER))
Type GtkSpinner AS _GtkSpinner
Declare Function gtk_spinner_get_type CDECL() AS GType
Declare Function gtk_spinner_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_spinner_start CDECL(BYVAL AS GtkSpinner Ptr)
Declare SUB gtk_spinner_stop CDECL(BYVAL AS GtkSpinner Ptr)
Declare SUB gtk_spinner_set_spinning CDECL(BYVAL AS GtkSpinner Ptr, BYVAL AS gboolean)
Declare Function gtk_spinner_get_spinning CDECL(BYVAL AS GtkSpinner Ptr) AS gboolean


#DEFINE GTK_TYPE_STACK_SWITCHER (gtk_stack_switcher_get_type ())
#DEFINE GTK_STACK_SWITCHER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_STACK_SWITCHER, GtkStackSwitcher))
#DEFINE GTK_IS_STACK_SWITCHER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_STACK_SWITCHER))
Type GtkStackSwitcher AS _GtkStackSwitcher
Declare Function gtk_stack_switcher_get_type CDECL() AS GType
Declare Function gtk_stack_switcher_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_stack_switcher_set_stack CDECL(BYVAL AS GtkStackSwitcher Ptr, BYVAL AS GtkStack Ptr)
Declare Function gtk_stack_switcher_get_stack CDECL(BYVAL AS GtkStackSwitcher Ptr) AS GtkStack Ptr


#DEFINE GTK_TYPE_STRING_OBJECT (gtk_string_object_get_type ())
Type GtkStringObject AS _GtkStringObject
Declare Function gtk_string_object_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkStringObject Ptr
Declare Function gtk_string_object_get_string CDECL(BYVAL AS GtkStringObject Ptr) AS Const ZSTRING Ptr
#DEFINE GTK_TYPE_STRING_LIST (gtk_string_list_get_type ())
Type GtkStringList AS _GtkStringList
Declare Function gtk_string_list_new CDECL(BYVAL AS Const ZSTRING Const Ptr Ptr) AS GtkStringList Ptr
Declare SUB gtk_string_list_append CDECL(BYVAL AS GtkStringList Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_string_list_take CDECL(BYVAL AS GtkStringList Ptr, BYVAL AS ZSTRING Ptr)
Declare SUB gtk_string_list_remove CDECL(BYVAL AS GtkStringList Ptr, BYVAL AS guint)
Declare SUB gtk_string_list_splice CDECL(BYVAL AS GtkStringList Ptr, BYVAL AS guint, BYVAL AS guint, BYVAL AS Const ZSTRING Const Ptr Ptr)
Declare Function gtk_string_list_get_string CDECL(BYVAL AS GtkStringList Ptr, BYVAL AS guint) AS Const ZSTRING Ptr
Declare Function gtk_string_list_find CDECL(BYVAL AS GtkStringList Ptr, BYVAL AS Const ZSTRING Ptr) AS guint


#DEFINE GTK_TYPE_STRING_SORTER (gtk_string_sorter_get_type ())
Type GtkStringSorter AS _GtkStringSorter
Declare Function gtk_string_sorter_new CDECL(BYVAL AS GtkExpression Ptr) AS GtkStringSorter Ptr
Declare Function gtk_string_sorter_get_expression CDECL(BYVAL AS GtkStringSorter Ptr) AS GtkExpression Ptr
Declare SUB gtk_string_sorter_set_expression CDECL(BYVAL AS GtkStringSorter Ptr, BYVAL AS GtkExpression Ptr)
Declare Function gtk_string_sorter_get_ignore_case CDECL(BYVAL AS GtkStringSorter Ptr) AS gboolean
Declare SUB gtk_string_sorter_set_ignore_case CDECL(BYVAL AS GtkStringSorter Ptr, BYVAL AS gboolean)
Enum GtkCollation_
	GTK_COLLATION_NONE
	GTK_COLLATION_UNICODE
	GTK_COLLATION_FILENAME
End Enum
Type AS LONG GtkCollation
Declare SUB gtk_string_sorter_set_collation CDECL(BYVAL AS GtkStringSorter Ptr, BYVAL AS GtkCollation)
Declare Function gtk_string_sorter_get_collation CDECL(BYVAL AS GtkStringSorter Ptr) AS GtkCollation


#DEFINE GTK_TYPE_STYLE_PROVIDER (gtk_style_provider_get_type ())
#DEFINE GTK_STYLE_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GTK_TYPE_STYLE_PROVIDER, GtkStyleProvider))
#DEFINE GTK_IS_STYLE_PROVIDER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GTK_TYPE_STYLE_PROVIDER))
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_FALLBACK 1
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_THEME 200
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_SETTINGS 400
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_APPLICATION 600
#DEFINE GTK_STYLE_PROVIDER_PRIORITY_USER 800
Type GtkStyleProvider AS _GtkStyleProvider
Declare Function gtk_style_provider_get_type CDECL() AS GType
Declare SUB gtk_style_context_add_provider_for_display CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS GtkStyleProvider Ptr, BYVAL AS guint)
Declare SUB gtk_style_context_remove_provider_for_display CDECL(BYVAL AS GdkDisplay Ptr, BYVAL AS GtkStyleProvider Ptr)


#DEFINE GTK_TYPE_SWITCH (gtk_switch_get_type ())
#DEFINE GTK_SWITCH(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_SWITCH, GtkSwitch))
#DEFINE GTK_IS_SWITCH(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_SWITCH))
Type GtkSwitch AS _GtkSwitch
Declare Function gtk_switch_get_type CDECL() AS GType
Declare Function gtk_switch_new CDECL() AS GtkWidget Ptr
Declare SUB gtk_switch_set_active CDECL(BYVAL AS GtkSwitch Ptr, BYVAL AS gboolean)
Declare Function gtk_switch_get_active CDECL(BYVAL AS GtkSwitch Ptr) AS gboolean
Declare SUB gtk_switch_set_state CDECL(BYVAL AS GtkSwitch Ptr, BYVAL AS gboolean)
Declare Function gtk_switch_get_state CDECL(BYVAL AS GtkSwitch Ptr) AS gboolean


#DEFINE GTK_TYPE_SYMBOLIC_PAINTABLE (gtk_symbolic_paintable_get_type ())
Type GtkSymbolicPaintable AS _GtkSymbolicPaintable
Type _GtkSymbolicPaintableInterface
	AS GTypeInterface g_iface
	snapshot_symbolic AS SUB CDECL(BYVAL AS GtkSymbolicPaintable Ptr, BYVAL AS GdkSnapshot Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS Const GdkRGBA Ptr, BYVAL AS gsize)
End Type
Declare SUB gtk_symbolic_paintable_snapshot_symbolic CDECL(BYVAL AS GtkSymbolicPaintable Ptr, BYVAL AS GdkSnapshot Ptr, BYVAL AS DOUBLE, BYVAL AS DOUBLE, BYVAL AS Const GdkRGBA Ptr, BYVAL AS gsize)


#DEFINE GTK_TYPE_TEXT (gtk_text_get_type ())
#DEFINE GTK_TEXT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT, GtkText))
#DEFINE GTK_IS_TEXT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT))
Type GtkText AS _GtkText
Type _GtkText
	AS GtkWidget parent_instance
End Type
Declare Function gtk_text_get_type CDECL() AS GType
Declare Function gtk_text_new CDECL() AS GtkWidget Ptr
Declare Function gtk_text_new_with_buffer CDECL(BYVAL AS GtkEntryBuffer Ptr) AS GtkWidget Ptr
Declare Function gtk_text_get_buffer CDECL(BYVAL AS GtkText Ptr) AS GtkEntryBuffer Ptr
Declare SUB gtk_text_set_buffer CDECL(BYVAL AS GtkText Ptr, BYVAL AS GtkEntryBuffer Ptr)
Declare SUB gtk_text_set_visibility CDECL(BYVAL AS GtkText Ptr, BYVAL AS gboolean)
Declare Function gtk_text_get_visibility CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare SUB gtk_text_set_invisible_char CDECL(BYVAL AS GtkText Ptr, BYVAL AS gunichar)
Declare Function gtk_text_get_invisible_char CDECL(BYVAL AS GtkText Ptr) AS gunichar
Declare SUB gtk_text_unset_invisible_char CDECL(BYVAL AS GtkText Ptr)
Declare SUB gtk_text_set_overwrite_mode CDECL(BYVAL AS GtkText Ptr, BYVAL AS gboolean)
Declare Function gtk_text_get_overwrite_mode CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare SUB gtk_text_set_max_length CDECL(BYVAL AS GtkText Ptr, BYVAL AS LONG)
Declare Function gtk_text_get_max_length CDECL(BYVAL AS GtkText Ptr) AS LONG
Declare Function gtk_text_get_text_length CDECL(BYVAL AS GtkText Ptr) AS guint16
Declare SUB gtk_text_set_activates_default CDECL(BYVAL AS GtkText Ptr, BYVAL AS gboolean)
Declare Function gtk_text_get_activates_default CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare Function gtk_text_get_placeholder_text CDECL(BYVAL AS GtkText Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_text_set_placeholder_text CDECL(BYVAL AS GtkText Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_text_set_input_purpose CDECL(BYVAL AS GtkText Ptr, BYVAL AS GtkInputPurpose)
Declare Function gtk_text_get_input_purpose CDECL(BYVAL AS GtkText Ptr) AS GtkInputPurpose
Declare SUB gtk_text_set_input_hints CDECL(BYVAL AS GtkText Ptr, BYVAL AS GtkInputHints)
Declare Function gtk_text_get_input_hints CDECL(BYVAL AS GtkText Ptr) AS GtkInputHints
Declare SUB gtk_text_set_attributes CDECL(BYVAL AS GtkText Ptr, BYVAL AS PangoAttrList Ptr)
Declare Function gtk_text_get_attributes CDECL(BYVAL AS GtkText Ptr) AS PangoAttrList Ptr
Declare SUB gtk_text_set_tabs CDECL(BYVAL AS GtkText Ptr, BYVAL AS PangoTabArray Ptr)
Declare Function gtk_text_get_tabs CDECL(BYVAL AS GtkText Ptr) AS PangoTabArray Ptr
Declare Function gtk_text_grab_focus_without_selecting CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare SUB gtk_text_set_extra_menu CDECL(BYVAL AS GtkText Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_text_get_extra_menu CDECL(BYVAL AS GtkText Ptr) AS GMenuModel Ptr
Declare SUB gtk_text_set_enable_emoji_completion CDECL(BYVAL AS GtkText Ptr, BYVAL AS gboolean)
Declare Function gtk_text_get_enable_emoji_completion CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare SUB gtk_text_set_propagate_text_width CDECL(BYVAL AS GtkText Ptr, BYVAL AS gboolean)
Declare Function gtk_text_get_propagate_text_width CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare SUB gtk_text_set_truncate_multiline CDECL(BYVAL AS GtkText Ptr, BYVAL AS gboolean)
Declare Function gtk_text_get_truncate_multiline CDECL(BYVAL AS GtkText Ptr) AS gboolean
Declare SUB gtk_text_compute_cursor_extents CDECL(BYVAL AS GtkText Ptr, BYVAL AS gsize, BYVAL AS graphene_rect_t Ptr, BYVAL AS graphene_rect_t Ptr)

Type GtkTextIter AS _GtkTextIter
Type GtkTextTagTable AS _GtkTextTagTable

#DEFINE GTK_TYPE_TEXT_TAG (gtk_text_tag_get_type ())
#DEFINE GTK_TEXT_TAG(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_TAG, GtkTextTag))
#DEFINE GTK_TEXT_TAG_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_TAG, GtkTextTagClass))
#DEFINE GTK_IS_TEXT_TAG(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_TAG))
#DEFINE GTK_IS_TEXT_TAG_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_TAG))
#DEFINE GTK_TEXT_TAG_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_TAG, GtkTextTagClass))
Type GtkTextTag AS _GtkTextTag
Type GtkTextTagPrivate AS _GtkTextTagPrivate
Type GtkTextTagClass AS _GtkTextTagClass
Type _GtkTextTag
	AS GObject parent_instance
	AS GtkTextTagPrivate Ptr priv
End Type
Type _GtkTextTagClass
	AS GObjectClass parent_class
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_text_tag_get_type CDECL() AS GType
Declare Function gtk_text_tag_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkTextTag Ptr
Declare Function gtk_text_tag_get_priority CDECL(BYVAL AS GtkTextTag Ptr) AS LONG
Declare SUB gtk_text_tag_set_priority CDECL(BYVAL AS GtkTextTag Ptr, BYVAL AS LONG)
Declare SUB gtk_text_tag_changed CDECL(BYVAL AS GtkTextTag Ptr, BYVAL AS gboolean)

Type GtkTextTagTableForeach AS SUB CDECL(BYVAL AS GtkTextTag Ptr, BYVAL AS gpointer)
#DEFINE GTK_TYPE_TEXT_TAG_TABLE (gtk_text_tag_table_get_type ())
#DEFINE GTK_TEXT_TAG_TABLE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_TAG_TABLE, GtkTextTagTable))
#DEFINE GTK_IS_TEXT_TAG_TABLE(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_TAG_TABLE))
Declare Function gtk_text_tag_table_get_type CDECL() AS GType
Declare Function gtk_text_tag_table_new CDECL() AS GtkTextTagTable Ptr
Declare Function gtk_text_tag_table_add CDECL(BYVAL AS GtkTextTagTable Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Declare SUB gtk_text_tag_table_remove CDECL(BYVAL AS GtkTextTagTable Ptr, BYVAL AS GtkTextTag Ptr)
Declare Function gtk_text_tag_table_lookup CDECL(BYVAL AS GtkTextTagTable Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkTextTag Ptr
Declare SUB gtk_text_tag_table_foreach CDECL(BYVAL AS GtkTextTagTable Ptr, BYVAL AS GtkTextTagTableForeach, BYVAL AS gpointer)
Declare Function gtk_text_tag_table_get_size CDECL(BYVAL AS GtkTextTagTable Ptr) AS LONG


Type GtkTextChildAnchor AS _GtkTextChildAnchor
Type GtkTextChildAnchorClass AS _GtkTextChildAnchorClass
#DEFINE GTK_TYPE_TEXT_CHILD_ANCHOR (gtk_text_child_anchor_get_type ())
#DEFINE GTK_TEXT_CHILD_ANCHOR(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchor))
#DEFINE GTK_TEXT_CHILD_ANCHOR_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass))
#DEFINE GTK_IS_TEXT_CHILD_ANCHOR(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_TEXT_CHILD_ANCHOR))
#DEFINE GTK_IS_TEXT_CHILD_ANCHOR_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_CHILD_ANCHOR))
#DEFINE GTK_TEXT_CHILD_ANCHOR_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_CHILD_ANCHOR, GtkTextChildAnchorClass))
Type _GtkTextChildAnchor
	AS GObject parent_instance
	AS gpointer segment
End Type
Type _GtkTextChildAnchorClass
	AS GObjectClass parent_class
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare Function gtk_text_child_anchor_get_type CDECL() AS GType
Declare Function gtk_text_child_anchor_new CDECL() AS GtkTextChildAnchor Ptr
Declare Function gtk_text_child_anchor_new_with_replacement CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkTextChildAnchor Ptr
Declare Function gtk_text_child_anchor_get_widgets CDECL(BYVAL AS GtkTextChildAnchor Ptr, BYVAL AS guint Ptr) AS GtkWidget Ptr
Declare Function gtk_text_child_anchor_get_deleted CDECL(BYVAL AS GtkTextChildAnchor Ptr) AS gboolean

Enum GtkTextSearchFlags_
	GTK_TEXT_SEARCH_VISIBLE_ONLY = 1  SHL 0
	GTK_TEXT_SEARCH_TEXT_ONLY = 1  SHL 1
	GTK_TEXT_SEARCH_CASE_INSENSITIVE = 1  SHL 2
End Enum
Type AS LONG GtkTextSearchFlags
Type GtkTextBuffer AS _GtkTextBuffer

#DEFINE GTK_TYPE_TEXT_ITER (gtk_text_iter_get_type ())
Type _GtkTextIter
	AS gpointer dummy1
	AS gpointer dummy2
	AS LONG dummy3
	AS LONG dummy4
	AS LONG dummy5
	AS LONG dummy6
	AS LONG dummy7
	AS LONG dummy8
	AS gpointer dummy9
	AS gpointer dummy10
	AS LONG dummy11
	AS LONG dummy12
	AS LONG dummy13
	AS gpointer dummy14
End Type

Declare Function gtk_text_iter_get_buffer CDECL(BYVAL AS Const GtkTextIter Ptr) AS GtkTextBuffer Ptr
Declare Function gtk_text_iter_copy CDECL(BYVAL AS Const GtkTextIter Ptr) AS GtkTextIter Ptr
Declare SUB gtk_text_iter_free CDECL(BYVAL AS GtkTextIter Ptr)
Declare SUB gtk_text_iter_assign CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare Function gtk_text_iter_get_type CDECL() AS GType
Declare Function gtk_text_iter_get_offset CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_line CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_line_offset CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_line_index CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_visible_line_offset CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_visible_line_index CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_char CDECL(BYVAL AS Const GtkTextIter Ptr) AS gunichar
Declare Function gtk_text_iter_get_slice CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS ZSTRING Ptr
Declare Function gtk_text_iter_get_text CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS ZSTRING Ptr
Declare Function gtk_text_iter_get_visible_slice CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS ZSTRING Ptr
Declare Function gtk_text_iter_get_visible_text CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS ZSTRING Ptr
Declare Function gtk_text_iter_get_paintable CDECL(BYVAL AS Const GtkTextIter Ptr) AS GdkPaintable Ptr
Declare Function gtk_text_iter_get_marks CDECL(BYVAL AS Const GtkTextIter Ptr) AS GSList Ptr
Declare Function gtk_text_iter_get_child_anchor CDECL(BYVAL AS Const GtkTextIter Ptr) AS GtkTextChildAnchor Ptr
Declare Function gtk_text_iter_get_toggled_tags CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS GSList Ptr
Declare Function gtk_text_iter_starts_tag CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Declare Function gtk_text_iter_ends_tag CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Declare Function gtk_text_iter_toggles_tag CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Declare Function gtk_text_iter_has_tag CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Declare Function gtk_text_iter_get_tags CDECL(BYVAL AS Const GtkTextIter Ptr) AS GSList Ptr
Declare Function gtk_text_iter_editable CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS gboolean
Declare Function gtk_text_iter_can_insert CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS gboolean
Declare Function gtk_text_iter_starts_word CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_ends_word CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_inside_word CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_starts_sentence CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_ends_sentence CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_inside_sentence CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_starts_line CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_ends_line CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_is_cursor_position CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_get_chars_in_line CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_bytes_in_line CDECL(BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_get_language CDECL(BYVAL AS Const GtkTextIter Ptr) AS PangoLanguage Ptr
Declare Function gtk_text_iter_is_end CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_is_start CDECL(BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_char CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_char CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_chars CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_chars CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_line CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_line CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_lines CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_lines CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_word_end CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_word_start CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_word_ends CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_word_starts CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_visible_line CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_visible_line CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_visible_lines CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_visible_lines CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_visible_word_end CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_visible_word_start CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_visible_word_ends CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_visible_word_starts CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_sentence_end CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_sentence_start CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_sentence_ends CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_sentence_starts CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_cursor_position CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_cursor_position CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_cursor_positions CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_cursor_positions CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_forward_visible_cursor_position CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_visible_cursor_position CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_visible_cursor_positions CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_iter_backward_visible_cursor_positions CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare SUB gtk_text_iter_set_offset CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare SUB gtk_text_iter_set_line CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare SUB gtk_text_iter_set_line_offset CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare SUB gtk_text_iter_set_line_index CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare SUB gtk_text_iter_forward_to_end CDECL(BYVAL AS GtkTextIter Ptr)
Declare Function gtk_text_iter_forward_to_line_end CDECL(BYVAL AS GtkTextIter Ptr) AS gboolean
Declare SUB gtk_text_iter_set_visible_line_offset CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare SUB gtk_text_iter_set_visible_line_index CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare Function gtk_text_iter_forward_to_tag_toggle CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Declare Function gtk_text_iter_backward_to_tag_toggle CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextTag Ptr) AS gboolean
Type GtkTextCharPredicate AS Function CDECL(BYVAL AS gunichar, BYVAL AS gpointer) AS gboolean
Declare Function gtk_text_iter_forward_find_char CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextCharPredicate, BYVAL AS gpointer, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_find_char CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextCharPredicate, BYVAL AS gpointer, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_forward_search CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkTextSearchFlags, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_backward_search CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkTextSearchFlags, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_equal CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_iter_compare CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS LONG
Declare Function gtk_text_iter_in_range CDECL(BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare SUB gtk_text_iter_order CDECL(BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr)

Type GtkTextMark AS _GtkTextMark
Type GtkTextMarkClass AS _GtkTextMarkClass

#DEFINE GTK_TYPE_TEXT_MARK (gtk_text_mark_get_type ())
#DEFINE GTK_TEXT_MARK(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_TEXT_MARK, GtkTextMark))
#DEFINE GTK_TEXT_MARK_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_MARK, GtkTextMarkClass))
#DEFINE GTK_IS_TEXT_MARK(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_TEXT_MARK))
#DEFINE GTK_IS_TEXT_MARK_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_MARK))
#DEFINE GTK_TEXT_MARK_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_MARK, GtkTextMarkClass))
Type _GtkTextMark
	AS GObject parent_instance
	AS gpointer segment
End Type
Type _GtkTextMarkClass
	AS GObjectClass parent_class
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_text_mark_get_type CDECL() AS GType
Declare Function gtk_text_mark_new CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS gboolean) AS GtkTextMark Ptr
Declare SUB gtk_text_mark_set_visible CDECL(BYVAL AS GtkTextMark Ptr, BYVAL AS gboolean)
Declare Function gtk_text_mark_get_visible CDECL(BYVAL AS GtkTextMark Ptr) AS gboolean
Declare Function gtk_text_mark_get_name CDECL(BYVAL AS GtkTextMark Ptr) AS Const ZSTRING Ptr
Declare Function gtk_text_mark_get_deleted CDECL(BYVAL AS GtkTextMark Ptr) AS gboolean
Declare Function gtk_text_mark_get_buffer CDECL(BYVAL AS GtkTextMark Ptr) AS GtkTextBuffer Ptr
Declare Function gtk_text_mark_get_left_gravity CDECL(BYVAL AS GtkTextMark Ptr) AS gboolean


#DEFINE GTK_TYPE_TEXT_BUFFER (gtk_text_buffer_get_type ())
#DEFINE GTK_TEXT_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBuffer))
#DEFINE GTK_TEXT_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass))
#DEFINE GTK_IS_TEXT_BUFFER(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_BUFFER))
#DEFINE GTK_IS_TEXT_BUFFER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_BUFFER))
#DEFINE GTK_TEXT_BUFFER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_BUFFER, GtkTextBufferClass))
Type GtkTextBufferPrivate AS _GtkTextBufferPrivate
Type GtkTextBufferClass AS _GtkTextBufferClass
Type _GtkTextBuffer
	AS GObject parent_instance
	AS GtkTextBufferPrivate Ptr priv
End Type
Type GtkTextBufferCommitNotify AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextBufferNotifyFlags, BYVAL AS guint, BYVAL AS guint, BYVAL AS gpointer)
Type _GtkTextBufferClass
	AS GObjectClass parent_class
	insert_text AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
	insert_paintable AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GdkPaintable Ptr)
	insert_child_anchor AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextChildAnchor Ptr)
	delete_range AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr)
	changed AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr)
	modified_changed AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr)
	mark_set AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS GtkTextMark Ptr)
	mark_deleted AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextMark Ptr)
	apply_tag AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextTag Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
	remove_tag AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextTag Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
	begin_user_action AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr)
	end_user_action AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr)
	paste_done AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GdkClipboard Ptr)
	undo AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr)
	redo AS SUB CDECL(BYVAL AS GtkTextBuffer Ptr)
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare Function gtk_text_buffer_get_type CDECL() AS GType
Declare Function gtk_text_buffer_new CDECL(BYVAL AS GtkTextTagTable Ptr) AS GtkTextBuffer Ptr
Declare Function gtk_text_buffer_get_line_count CDECL(BYVAL AS GtkTextBuffer Ptr) AS LONG
Declare Function gtk_text_buffer_get_char_count CDECL(BYVAL AS GtkTextBuffer Ptr) AS LONG
Declare Function gtk_text_buffer_get_tag_table CDECL(BYVAL AS GtkTextBuffer Ptr) AS GtkTextTagTable Ptr
Declare SUB gtk_text_buffer_set_text CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
Declare SUB gtk_text_buffer_insert CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
Declare SUB gtk_text_buffer_insert_at_cursor CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
Declare Function gtk_text_buffer_insert_interactive CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS gboolean) AS gboolean
Declare Function gtk_text_buffer_insert_interactive_at_cursor CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS gboolean) AS gboolean
Declare SUB gtk_text_buffer_insert_range CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare Function gtk_text_buffer_insert_range_interactive CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS gboolean
Declare SUB gtk_text_buffer_insert_with_tags CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS GtkTextTag Ptr, ...)
Declare SUB gtk_text_buffer_insert_with_tags_by_name CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS Const ZSTRING Ptr, ...)
Declare SUB gtk_text_buffer_insert_markup CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG)
Declare SUB gtk_text_buffer_delete CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr)
Declare Function gtk_text_buffer_delete_interactive CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS gboolean) AS gboolean
Declare Function gtk_text_buffer_backspace CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS gboolean, BYVAL AS gboolean) AS gboolean
Declare Function gtk_text_buffer_get_text CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS ZSTRING Ptr
Declare Function gtk_text_buffer_get_slice CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS ZSTRING Ptr
Declare SUB gtk_text_buffer_insert_paintable CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GdkPaintable Ptr)
Declare SUB gtk_text_buffer_insert_child_anchor CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextChildAnchor Ptr)
Declare Function gtk_text_buffer_create_child_anchor CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr) AS GtkTextChildAnchor Ptr
Declare SUB gtk_text_buffer_add_mark CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextMark Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare Function gtk_text_buffer_create_mark CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS gboolean) AS GtkTextMark Ptr
Declare SUB gtk_text_buffer_move_mark CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextMark Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_delete_mark CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextMark Ptr)
Declare Function gtk_text_buffer_get_mark CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr) AS GtkTextMark Ptr
Declare SUB gtk_text_buffer_move_mark_by_name CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_delete_mark_by_name CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_text_buffer_get_insert CDECL(BYVAL AS GtkTextBuffer Ptr) AS GtkTextMark Ptr
Declare Function gtk_text_buffer_get_selection_bound CDECL(BYVAL AS GtkTextBuffer Ptr) AS GtkTextMark Ptr
Declare SUB gtk_text_buffer_place_cursor CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_select_range CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_apply_tag CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextTag Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_remove_tag CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextTag Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_apply_tag_by_name CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_remove_tag_by_name CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare SUB gtk_text_buffer_remove_all_tags CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS Const GtkTextIter Ptr)
Declare Function gtk_text_buffer_create_tag CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, ...) AS GtkTextTag Ptr
Declare Function gtk_text_buffer_get_iter_at_line_offset CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_buffer_get_iter_at_line_index CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
Declare SUB gtk_text_buffer_get_iter_at_offset CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG)
Declare Function gtk_text_buffer_get_iter_at_line CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare SUB gtk_text_buffer_get_start_iter CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr)
Declare SUB gtk_text_buffer_get_end_iter CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr)
Declare SUB gtk_text_buffer_get_bounds CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr)
Declare SUB gtk_text_buffer_get_iter_at_mark CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextMark Ptr)
Declare SUB gtk_text_buffer_get_iter_at_child_anchor CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextChildAnchor Ptr)
Declare Function gtk_text_buffer_get_modified CDECL(BYVAL AS GtkTextBuffer Ptr) AS gboolean
Declare SUB gtk_text_buffer_set_modified CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS gboolean)
Declare Function gtk_text_buffer_get_has_selection CDECL(BYVAL AS GtkTextBuffer Ptr) AS gboolean
Declare SUB gtk_text_buffer_add_selection_clipboard CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GdkClipboard Ptr)
Declare SUB gtk_text_buffer_remove_selection_clipboard CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GdkClipboard Ptr)
Declare SUB gtk_text_buffer_cut_clipboard CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GdkClipboard Ptr, BYVAL AS gboolean)
Declare SUB gtk_text_buffer_copy_clipboard CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GdkClipboard Ptr)
Declare SUB gtk_text_buffer_paste_clipboard CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GdkClipboard Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS gboolean)
Declare Function gtk_text_buffer_get_selection_bounds CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_buffer_delete_selection CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS gboolean, BYVAL AS gboolean) AS gboolean
Declare Function gtk_text_buffer_get_selection_content CDECL(BYVAL AS GtkTextBuffer Ptr) AS GdkContentProvider Ptr
Declare Function gtk_text_buffer_get_can_undo CDECL(BYVAL AS GtkTextBuffer Ptr) AS gboolean
Declare Function gtk_text_buffer_get_can_redo CDECL(BYVAL AS GtkTextBuffer Ptr) AS gboolean
Declare Function gtk_text_buffer_get_enable_undo CDECL(BYVAL AS GtkTextBuffer Ptr) AS gboolean
Declare SUB gtk_text_buffer_set_enable_undo CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS gboolean)
Declare Function gtk_text_buffer_get_max_undo_levels CDECL(BYVAL AS GtkTextBuffer Ptr) AS guint
Declare SUB gtk_text_buffer_set_max_undo_levels CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS guint)
Declare SUB gtk_text_buffer_undo CDECL(BYVAL AS GtkTextBuffer Ptr)
Declare SUB gtk_text_buffer_redo CDECL(BYVAL AS GtkTextBuffer Ptr)
Declare SUB gtk_text_buffer_begin_irreversible_action CDECL(BYVAL AS GtkTextBuffer Ptr)
Declare SUB gtk_text_buffer_end_irreversible_action CDECL(BYVAL AS GtkTextBuffer Ptr)
Declare SUB gtk_text_buffer_begin_user_action CDECL(BYVAL AS GtkTextBuffer Ptr)
Declare SUB gtk_text_buffer_end_user_action CDECL(BYVAL AS GtkTextBuffer Ptr)
Declare Function gtk_text_buffer_add_commit_notify CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS GtkTextBufferNotifyFlags, BYVAL AS GtkTextBufferCommitNotify, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
Declare SUB gtk_text_buffer_remove_commit_notify CDECL(BYVAL AS GtkTextBuffer Ptr, BYVAL AS guint)


#DEFINE GTK_TYPE_TEXT_VIEW (gtk_text_view_get_type ())
#DEFINE GTK_TEXT_VIEW(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TEXT_VIEW, GtkTextView))
#DEFINE GTK_TEXT_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_TEXT_VIEW, GtkTextViewClass))
#DEFINE GTK_IS_TEXT_VIEW(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TEXT_VIEW))
#DEFINE GTK_IS_TEXT_VIEW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_TEXT_VIEW))
#DEFINE GTK_TEXT_VIEW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_TEXT_VIEW, GtkTextViewClass))
Enum GtkTextWindowType_
	GTK_TEXT_WINDOW_WIDGET = 1
	GTK_TEXT_WINDOW_TEXT
	GTK_TEXT_WINDOW_LEFT
	GTK_TEXT_WINDOW_RIGHT
	GTK_TEXT_WINDOW_TOP
	GTK_TEXT_WINDOW_BOTTOM
End Enum
Type AS LONG GtkTextWindowType
Enum GtkTextViewLayer_
	GTK_TEXT_VIEW_LAYER_BELOW_TEXT
	GTK_TEXT_VIEW_LAYER_ABOVE_TEXT
End Enum
Type AS LONG GtkTextViewLayer
Enum GtkTextExtendSelection_
	GTK_TEXT_EXTEND_SELECTION_WORD
	GTK_TEXT_EXTEND_SELECTION_LINE
End Enum
Type AS LONG GtkTextExtendSelection

#DEFINE GTK_TEXT_VIEW_PRIORITY_VALIDATE (GDK_PRIORITY_REDRAW + 5)
Type GtkTextView AS _GtkTextView
Type GtkTextViewPrivate AS _GtkTextViewPrivate
Type GtkTextViewClass AS _GtkTextViewClass
Type _GtkTextView
	AS GtkWidget parent_instance
	AS GtkTextViewPrivate Ptr priv
End Type
Type _GtkTextViewClass
	AS GtkWidgetClass parent_class
	move_cursor AS SUB CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkMovementStep, BYVAL AS LONG, BYVAL AS gboolean)
	set_anchor AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	insert_at_cursor AS SUB CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS Const ZSTRING Ptr)
	delete_from_cursor AS SUB CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkDeleteType, BYVAL AS LONG)
	backspace AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	cut_clipboard AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	copy_clipboard AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	paste_clipboard AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	toggle_overwrite AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	create_buffer AS Function CDECL(BYVAL AS GtkTextView Ptr) AS GtkTextBuffer Ptr
	snapshot_layer AS SUB CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextViewLayer, BYVAL AS GtkSnapshot Ptr)
	extend_selection AS Function CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextExtendSelection, BYVAL AS Const GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS GtkTextIter Ptr) AS gboolean
	insert_emoji AS SUB CDECL(BYVAL AS GtkTextView Ptr)
	AS gpointer padding(0 TO 8-1)
End Type
Declare Function gtk_text_view_get_type CDECL() AS GType
Declare Function gtk_text_view_new CDECL() AS GtkWidget Ptr
Declare Function gtk_text_view_new_with_buffer CDECL(BYVAL AS GtkTextBuffer Ptr) AS GtkWidget Ptr
Declare SUB gtk_text_view_set_buffer CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextBuffer Ptr)
Declare Function gtk_text_view_get_buffer CDECL(BYVAL AS GtkTextView Ptr) AS GtkTextBuffer Ptr
Declare Function gtk_text_view_scroll_to_iter CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS DOUBLE, BYVAL AS gboolean, BYVAL AS DOUBLE, BYVAL AS DOUBLE) AS gboolean
Declare SUB gtk_text_view_scroll_to_mark CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextMark Ptr, BYVAL AS DOUBLE, BYVAL AS gboolean, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
Declare SUB gtk_text_view_scroll_mark_onscreen CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextMark Ptr)
Declare Function gtk_text_view_move_mark_onscreen CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextMark Ptr) AS gboolean
Declare Function gtk_text_view_place_cursor_onscreen CDECL(BYVAL AS GtkTextView Ptr) AS gboolean
Declare SUB gtk_text_view_get_visible_rect CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GdkRectangle Ptr)
Declare SUB gtk_text_view_get_visible_offset CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS DOUBLE Ptr, BYVAL AS DOUBLE Ptr)
Declare SUB gtk_text_view_set_cursor_visible CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS gboolean)
Declare Function gtk_text_view_get_cursor_visible CDECL(BYVAL AS GtkTextView Ptr) AS gboolean
Declare SUB gtk_text_view_reset_cursor_blink CDECL(BYVAL AS GtkTextView Ptr)
Declare SUB gtk_text_view_get_cursor_locations CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS GdkRectangle Ptr, BYVAL AS GdkRectangle Ptr)
Declare SUB gtk_text_view_get_iter_location CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS GdkRectangle Ptr)
Declare Function gtk_text_view_get_iter_at_location CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_view_get_iter_at_position CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG, BYVAL AS LONG) AS gboolean
Declare SUB gtk_text_view_get_line_yrange CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS Const GtkTextIter Ptr, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_text_view_get_line_at_y CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG, BYVAL AS LONG Ptr)
Declare SUB gtk_text_view_buffer_to_window_coords CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextWindowType, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare SUB gtk_text_view_window_to_buffer_coords CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextWindowType, BYVAL AS LONG, BYVAL AS LONG, BYVAL AS LONG Ptr, BYVAL AS LONG Ptr)
Declare Function gtk_text_view_forward_display_line CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_view_backward_display_line CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_view_forward_display_line_end CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_view_backward_display_line_start CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_view_starts_display_line CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS Const GtkTextIter Ptr) AS gboolean
Declare Function gtk_text_view_move_visually CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextIter Ptr, BYVAL AS LONG) AS gboolean
Declare Function gtk_text_view_im_context_filter_keypress CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GdkEvent Ptr) AS gboolean
Declare SUB gtk_text_view_reset_im_context CDECL(BYVAL AS GtkTextView Ptr)
Declare Function gtk_text_view_get_gutter CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextWindowType) AS GtkWidget Ptr
Declare SUB gtk_text_view_set_gutter CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkTextWindowType, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_text_view_add_child_at_anchor CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkTextChildAnchor Ptr)
Declare SUB gtk_text_view_add_overlay CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_text_view_move_overlay CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS LONG, BYVAL AS LONG)
Declare SUB gtk_text_view_remove CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_text_view_set_wrap_mode CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkWrapMode)
Declare Function gtk_text_view_get_wrap_mode CDECL(BYVAL AS GtkTextView Ptr) AS GtkWrapMode
Declare SUB gtk_text_view_set_editable CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS gboolean)
Declare Function gtk_text_view_get_editable CDECL(BYVAL AS GtkTextView Ptr) AS gboolean
Declare SUB gtk_text_view_set_overwrite CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS gboolean)
Declare Function gtk_text_view_get_overwrite CDECL(BYVAL AS GtkTextView Ptr) AS gboolean
Declare SUB gtk_text_view_set_accepts_tab CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS gboolean)
Declare Function gtk_text_view_get_accepts_tab CDECL(BYVAL AS GtkTextView Ptr) AS gboolean
Declare SUB gtk_text_view_set_pixels_above_lines CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_pixels_above_lines CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_pixels_below_lines CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_pixels_below_lines CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_pixels_inside_wrap CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_pixels_inside_wrap CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_justification CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkJustification)
Declare Function gtk_text_view_get_justification CDECL(BYVAL AS GtkTextView Ptr) AS GtkJustification
Declare SUB gtk_text_view_set_left_margin CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_left_margin CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_right_margin CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_right_margin CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_top_margin CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_top_margin CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_bottom_margin CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_bottom_margin CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_indent CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS LONG)
Declare Function gtk_text_view_get_indent CDECL(BYVAL AS GtkTextView Ptr) AS LONG
Declare SUB gtk_text_view_set_tabs CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS PangoTabArray Ptr)
Declare Function gtk_text_view_get_tabs CDECL(BYVAL AS GtkTextView Ptr) AS PangoTabArray Ptr
Declare SUB gtk_text_view_set_input_purpose CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkInputPurpose)
Declare Function gtk_text_view_get_input_purpose CDECL(BYVAL AS GtkTextView Ptr) AS GtkInputPurpose
Declare SUB gtk_text_view_set_input_hints CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GtkInputHints)
Declare Function gtk_text_view_get_input_hints CDECL(BYVAL AS GtkTextView Ptr) AS GtkInputHints
Declare SUB gtk_text_view_set_monospace CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS gboolean)
Declare Function gtk_text_view_get_monospace CDECL(BYVAL AS GtkTextView Ptr) AS gboolean
Declare SUB gtk_text_view_set_extra_menu CDECL(BYVAL AS GtkTextView Ptr, BYVAL AS GMenuModel Ptr)
Declare Function gtk_text_view_get_extra_menu CDECL(BYVAL AS GtkTextView Ptr) AS GMenuModel Ptr
Declare Function gtk_text_view_get_rtl_context CDECL(BYVAL AS GtkTextView Ptr) AS PangoContext Ptr
Declare Function gtk_text_view_get_ltr_context CDECL(BYVAL AS GtkTextView Ptr) AS PangoContext Ptr

#DEFINE GTK_TYPE_TOOLTIP (gtk_tooltip_get_type ())
#DEFINE GTK_TOOLTIP(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_TOOLTIP, GtkTooltip))
#DEFINE GTK_IS_TOOLTIP(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_TOOLTIP))
Declare Function gtk_tooltip_get_type CDECL() AS GType
Declare SUB gtk_tooltip_set_markup CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_tooltip_set_text CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_tooltip_set_icon CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS GdkPaintable Ptr)
Declare SUB gtk_tooltip_set_icon_from_icon_name CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_tooltip_set_icon_from_gicon CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS GIcon Ptr)
Declare SUB gtk_tooltip_set_custom CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS GtkWidget Ptr)
Declare SUB gtk_tooltip_set_tip_area CDECL(BYVAL AS GtkTooltip Ptr, BYVAL AS Const GdkRectangle Ptr)


Declare Function gtk_test_accessible_has_role CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleRole) AS gboolean
Declare Function gtk_test_accessible_has_property CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleProperty) AS gboolean
Declare Function gtk_test_accessible_has_relation CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleRelation) AS gboolean
Declare Function gtk_test_accessible_has_state CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleState) AS gboolean
Declare Function gtk_test_accessible_check_property CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleProperty, ...) AS ZSTRING Ptr
Declare Function gtk_test_accessible_check_relation CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleRelation, ...) AS ZSTRING Ptr
Declare Function gtk_test_accessible_check_state CDECL(BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleState, ...) AS ZSTRING Ptr
Declare SUB gtk_test_accessible_assertion_message_role CDECL(BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS LONG, BYVAL AS Const ZSTRING Ptr, BYVAL AS Const ZSTRING Ptr, BYVAL AS GtkAccessible Ptr, BYVAL AS GtkAccessibleRole, BYVAL AS GtkAccessibleRole)

Declare SUB gtk_test_init CDECL(BYVAL AS LONG Ptr, BYVAL AS ZSTRING Ptr Ptr Ptr, ...)
Declare SUB gtk_test_register_all_types CDECL()
Declare Function gtk_test_list_all_types CDECL(BYVAL AS guint Ptr) AS Const GType Ptr
Declare SUB gtk_test_widget_wait_for_draw CDECL(BYVAL AS GtkWidget Ptr)


#DEFINE GTK_TYPE_TREE_LIST_MODEL (gtk_tree_list_model_get_type ())
#DEFINE GTK_TYPE_TREE_LIST_ROW (gtk_tree_list_row_get_type ())

Type GtkTreeListModel AS _GtkTreeListModel
Type GtkTreeListRow AS _GtkTreeListRow
Type GtkTreeListModelCreateModelFunc AS Function CDECL(BYVAL AS gpointer, BYVAL AS gpointer) AS GListModel Ptr
Declare Function gtk_tree_list_model_new CDECL(BYVAL AS GListModel Ptr, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS GtkTreeListModelCreateModelFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS GtkTreeListModel Ptr
Declare Function gtk_tree_list_model_get_model CDECL(BYVAL AS GtkTreeListModel Ptr) AS GListModel Ptr
Declare Function gtk_tree_list_model_get_passthrough CDECL(BYVAL AS GtkTreeListModel Ptr) AS gboolean
Declare SUB gtk_tree_list_model_set_autoexpand CDECL(BYVAL AS GtkTreeListModel Ptr, BYVAL AS gboolean)
Declare Function gtk_tree_list_model_get_autoexpand CDECL(BYVAL AS GtkTreeListModel Ptr) AS gboolean
Declare Function gtk_tree_list_model_get_child_row CDECL(BYVAL AS GtkTreeListModel Ptr, BYVAL AS guint) AS GtkTreeListRow Ptr
Declare Function gtk_tree_list_model_get_row CDECL(BYVAL AS GtkTreeListModel Ptr, BYVAL AS guint) AS GtkTreeListRow Ptr
Declare Function gtk_tree_list_row_get_item CDECL(BYVAL AS GtkTreeListRow Ptr) AS gpointer
Declare SUB gtk_tree_list_row_set_expanded CDECL(BYVAL AS GtkTreeListRow Ptr, BYVAL AS gboolean)
Declare Function gtk_tree_list_row_get_expanded CDECL(BYVAL AS GtkTreeListRow Ptr) AS gboolean
Declare Function gtk_tree_list_row_is_expandable CDECL(BYVAL AS GtkTreeListRow Ptr) AS gboolean
Declare Function gtk_tree_list_row_get_position CDECL(BYVAL AS GtkTreeListRow Ptr) AS guint
Declare Function gtk_tree_list_row_get_depth CDECL(BYVAL AS GtkTreeListRow Ptr) AS guint
Declare Function gtk_tree_list_row_get_children CDECL(BYVAL AS GtkTreeListRow Ptr) AS GListModel Ptr
Declare Function gtk_tree_list_row_get_parent CDECL(BYVAL AS GtkTreeListRow Ptr) AS GtkTreeListRow Ptr
Declare Function gtk_tree_list_row_get_child_row CDECL(BYVAL AS GtkTreeListRow Ptr, BYVAL AS guint) AS GtkTreeListRow Ptr

#DEFINE GTK_TYPE_TREE_EXPANDER (gtk_tree_expander_get_type ())
Type GtkTreeExpander AS _GtkTreeExpander
Declare Function gtk_tree_expander_new CDECL() AS GtkWidget Ptr
Declare Function gtk_tree_expander_get_child CDECL(BYVAL AS GtkTreeExpander Ptr) AS GtkWidget Ptr
Declare SUB gtk_tree_expander_set_child CDECL(BYVAL AS GtkTreeExpander Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_tree_expander_get_item CDECL(BYVAL AS GtkTreeExpander Ptr) AS gpointer
Declare Function gtk_tree_expander_get_list_row CDECL(BYVAL AS GtkTreeExpander Ptr) AS GtkTreeListRow Ptr
Declare SUB gtk_tree_expander_set_list_row CDECL(BYVAL AS GtkTreeExpander Ptr, BYVAL AS GtkTreeListRow Ptr)
Declare Function gtk_tree_expander_get_indent_for_depth CDECL(BYVAL AS GtkTreeExpander Ptr) AS gboolean
Declare SUB gtk_tree_expander_set_indent_for_depth CDECL(BYVAL AS GtkTreeExpander Ptr, BYVAL AS gboolean)
Declare Function gtk_tree_expander_get_indent_for_icon CDECL(BYVAL AS GtkTreeExpander Ptr) AS gboolean
Declare SUB gtk_tree_expander_set_indent_for_icon CDECL(BYVAL AS GtkTreeExpander Ptr, BYVAL AS gboolean)
Declare Function gtk_tree_expander_get_hide_expander CDECL(BYVAL AS GtkTreeExpander Ptr) AS gboolean
Declare SUB gtk_tree_expander_set_hide_expander CDECL(BYVAL AS GtkTreeExpander Ptr, BYVAL AS gboolean)


#DEFINE GTK_TYPE_TREE_LIST_ROW_SORTER (gtk_tree_list_row_sorter_get_type ())

Type GtkTreeListRowSorter AS _GtkTreeListRowSorter
Declare Function gtk_tree_list_row_sorter_new CDECL(BYVAL AS GtkSorter Ptr) AS GtkTreeListRowSorter Ptr
Declare Function gtk_tree_list_row_sorter_get_sorter CDECL(BYVAL AS GtkTreeListRowSorter Ptr) AS GtkSorter Ptr
Declare SUB gtk_tree_list_row_sorter_set_sorter CDECL(BYVAL AS GtkTreeListRowSorter Ptr, BYVAL AS GtkSorter Ptr)


#DEFINE GTK_TYPE_URI_LAUNCHER (gtk_uri_launcher_get_type ())
Type GtkUriLauncher AS _GtkUriLauncher
Declare Function gtk_uri_launcher_new CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkUriLauncher Ptr
Declare Function gtk_uri_launcher_get_uri CDECL(BYVAL AS GtkUriLauncher Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_uri_launcher_set_uri CDECL(BYVAL AS GtkUriLauncher Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_uri_launcher_launch CDECL(BYVAL AS GtkUriLauncher Ptr, BYVAL AS GtkWindow Ptr, BYVAL AS GCancellable Ptr, BYVAL AS GAsyncReadyCallback, BYVAL AS gpointer)
Declare Function gtk_uri_launcher_launch_finish CDECL(BYVAL AS GtkUriLauncher Ptr, BYVAL AS GAsyncResult Ptr, BYVAL AS GError Ptr Ptr) AS gboolean

#DEFINE GTK_MAJOR_VERSION (4)
#DEFINE GTK_MINOR_VERSION (17)
#DEFINE GTK_MICRO_VERSION (4)
#DEFINE GTK_BINARY_AGE (1704)
#DEFINE GTK_INTERFACE_AGE (0)
Declare Function gtk_get_major_version CDECL() AS guint
Declare Function gtk_get_minor_version CDECL() AS guint
Declare Function gtk_get_micro_version CDECL() AS guint
Declare Function gtk_get_binary_age CDECL() AS guint
Declare Function gtk_get_interface_age CDECL() AS guint
Declare Function gtk_check_version CDECL(BYVAL AS guint, BYVAL AS guint, BYVAL AS guint) AS Const ZSTRING Ptr

#DEFINE GTK_TYPE_VIDEO (gtk_video_get_type ())
Type GtkVideo AS _GtkVideo
Declare Function gtk_video_new CDECL() AS GtkWidget Ptr
Declare Function gtk_video_new_for_media_stream CDECL(BYVAL AS GtkMediaStream Ptr) AS GtkWidget Ptr
Declare Function gtk_video_new_for_file CDECL(BYVAL AS GFile Ptr) AS GtkWidget Ptr
Declare Function gtk_video_new_for_filename CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_video_new_for_resource CDECL(BYVAL AS Const ZSTRING Ptr) AS GtkWidget Ptr
Declare Function gtk_video_get_media_stream CDECL(BYVAL AS GtkVideo Ptr) AS GtkMediaStream Ptr
Declare SUB gtk_video_set_media_stream CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS GtkMediaStream Ptr)
Declare Function gtk_video_get_file CDECL(BYVAL AS GtkVideo Ptr) AS GFile Ptr
Declare SUB gtk_video_set_file CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS GFile Ptr)
Declare SUB gtk_video_set_filename CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS Const ZSTRING Ptr)
Declare SUB gtk_video_set_resource CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_video_get_autoplay CDECL(BYVAL AS GtkVideo Ptr) AS gboolean
Declare SUB gtk_video_set_autoplay CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS gboolean)
Declare Function gtk_video_get_loop CDECL(BYVAL AS GtkVideo Ptr) AS gboolean
Declare SUB gtk_video_set_loop CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS gboolean)
Declare Function gtk_video_get_graphics_offload CDECL(BYVAL AS GtkVideo Ptr) AS GtkGraphicsOffloadEnabled
Declare SUB gtk_video_set_graphics_offload CDECL(BYVAL AS GtkVideo Ptr, BYVAL AS GtkGraphicsOffloadEnabled)


#DEFINE GTK_TYPE_VIEWPORT (gtk_viewport_get_type ())
#DEFINE GTK_VIEWPORT(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), GTK_TYPE_VIEWPORT, GtkViewport))
#DEFINE GTK_IS_VIEWPORT(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), GTK_TYPE_VIEWPORT))
Type GtkViewport AS _GtkViewport
Declare Function gtk_viewport_get_type CDECL() AS GType
Declare Function gtk_viewport_new CDECL(BYVAL AS GtkAdjustment Ptr, BYVAL AS GtkAdjustment Ptr) AS GtkWidget Ptr
Declare Function gtk_viewport_get_scroll_to_focus CDECL(BYVAL AS GtkViewport Ptr) AS gboolean
Declare SUB gtk_viewport_set_scroll_to_focus CDECL(BYVAL AS GtkViewport Ptr, BYVAL AS gboolean)
Declare SUB gtk_viewport_set_child CDECL(BYVAL AS GtkViewport Ptr, BYVAL AS GtkWidget Ptr)
Declare Function gtk_viewport_get_child CDECL(BYVAL AS GtkViewport Ptr) AS GtkWidget Ptr
Declare SUB gtk_viewport_scroll_to CDECL(BYVAL AS GtkViewport Ptr, BYVAL AS GtkWidget Ptr, BYVAL AS GtkScrollInfo Ptr)



#DEFINE GTK_TYPE_WIDGET_PAINTABLE (gtk_widget_paintable_get_type ())
Type GtkWidgetPaintable AS _GtkWidgetPaintable
Declare Function gtk_widget_paintable_new CDECL(BYVAL AS GtkWidget Ptr) AS GdkPaintable Ptr
Declare Function gtk_widget_paintable_get_widget CDECL(BYVAL AS GtkWidgetPaintable Ptr) AS GtkWidget Ptr
Declare SUB gtk_widget_paintable_set_widget CDECL(BYVAL AS GtkWidgetPaintable Ptr, BYVAL AS GtkWidget Ptr)

#DEFINE GTK_TYPE_WINDOW_CONTROLS (gtk_window_controls_get_type ())
Type GtkWindowControls AS _GtkWindowControls
Declare Function gtk_window_controls_new CDECL(BYVAL AS GtkPackType) AS GtkWidget Ptr
Declare Function gtk_window_controls_get_side CDECL(BYVAL AS GtkWindowControls Ptr) AS GtkPackType
Declare SUB gtk_window_controls_set_side CDECL(BYVAL AS GtkWindowControls Ptr, BYVAL AS GtkPackType)
Declare Function gtk_window_controls_get_decoration_layout CDECL(BYVAL AS GtkWindowControls Ptr) AS Const ZSTRING Ptr
Declare SUB gtk_window_controls_set_decoration_layout CDECL(BYVAL AS GtkWindowControls Ptr, BYVAL AS Const ZSTRING Ptr)
Declare Function gtk_window_controls_get_empty CDECL(BYVAL AS GtkWindowControls Ptr) AS gboolean

#DEFINE GTK_TYPE_WINDOW_GROUP (gtk_window_group_get_type ())
#DEFINE GTK_WINDOW_GROUP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GTK_TYPE_WINDOW_GROUP, GtkWindowGroup))
#DEFINE GTK_WINDOW_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass))
#DEFINE GTK_IS_WINDOW_GROUP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GTK_TYPE_WINDOW_GROUP))
#DEFINE GTK_IS_WINDOW_GROUP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GTK_TYPE_WINDOW_GROUP))
#DEFINE GTK_WINDOW_GROUP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GTK_TYPE_WINDOW_GROUP, GtkWindowGroupClass))
Type _GtkWindowGroup
	AS GObject parent_instance
	AS GtkWindowGroupPrivate Ptr priv
End Type
Type _GtkWindowGroupClass
	AS GObjectClass parent_class
	_gtk_reserved1 AS SUB CDECL()
	_gtk_reserved2 AS SUB CDECL()
	_gtk_reserved3 AS SUB CDECL()
	_gtk_reserved4 AS SUB CDECL()
End Type
Declare Function gtk_window_group_get_type CDECL() AS GType
Declare Function gtk_window_group_new CDECL() AS GtkWindowGroup Ptr
Declare SUB gtk_window_group_add_window CDECL(BYVAL AS GtkWindowGroup Ptr, BYVAL AS GtkWindow Ptr)
Declare SUB gtk_window_group_remove_window CDECL(BYVAL AS GtkWindowGroup Ptr, BYVAL AS GtkWindow Ptr)
Declare Function gtk_window_group_list_windows CDECL(BYVAL AS GtkWindowGroup Ptr) AS GList Ptr


#DEFINE GTK_TYPE_WINDOW_HANDLE (gtk_window_handle_get_type ())
Type GtkWindowHandle AS _GtkWindowHandle
Declare Function gtk_window_handle_new CDECL() AS GtkWidget Ptr
Declare Function gtk_window_handle_get_child CDECL(BYVAL AS GtkWindowHandle Ptr) AS GtkWidget Ptr
Declare SUB gtk_window_handle_set_child CDECL(BYVAL AS GtkWindowHandle Ptr, BYVAL AS GtkWidget Ptr)

end extern
