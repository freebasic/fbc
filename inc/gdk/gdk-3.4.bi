' This is file gdk-3.4.bi
' (FreeBasic binding for GDK library - version 3.4.4)
'
' translated with help of h_2_bi.bas by
' Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net.
'
' Licence:
' (C) 2011-2012 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
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
'/* GDK - The GIMP Drawing Kit
 '* Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
 '*
 '* This library is free software; you can redistribute it and/or
 '* modify it under the terms of the GNU Lesser General Public
 '* License as published by the Free Software Foundation; either
 '* version 2 of the License, or (at your option) any later version.
 '*
 '* This library is distributed in the hope that it will be useful,
 '* but WITHOUT ANY WARRANTY; without even the implied warranty of
 '* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.   See the GNU
 '* Lesser General Public License for more details.
 '*
 '* You should have received a copy of the GNU Lesser General Public
 '* License along with this library. If not, see <http://www.gnu.org/licenses/>.
 '*/

'/*
 '* Modified by the GTK+ Team and others 1997-2000.  See the AUTHORS
 '* file for a list of people on the GTK+ Team.  See the ChangeLog
 '* files for a list of changes.  These files are distributed with
 '* GTK+ at ftp://ftp.gtk.org/pub/gtk/.
 '*/

#IFNDEF __GDK_TJF__
#DEFINE __GDK_TJF__

#IF NOT __FB_MIN_VERSION__(0, 20, 0)
  #ERROR fbc version must NOT be less than 0.20.0 to compile this header
#ENDIF

#IFDEF __FB_WIN32__
 #PRAGMA push(msbitfields)
 #DEFINE GDK_WINDOWING_WIN32
#ELSEIF NOT DEFINED(__FB_LINUX__)
 #ERROR "Platform not supported!"
#ELSE
 #DEFINE GDK_WINDOWING_X11
#ENDIF
#INCLIB "gdk-3"

EXTERN "C" ' (h_2_bi -P_oCD option)

#IFNDEF __GDK_H__
#DEFINE __GDK_H__
#DEFINE __GDK_H_INSIDE__

#IFNDEF __GDK_VERSION_MACROS_H__
#DEFINE __GDK_VERSION_MACROS_H__
#INCLUDE ONCE "glib.bi" '__HEADERS__: glib.h
#DEFINE GDK_MAJOR_VERSION (3)
#DEFINE GDK_MINOR_VERSION (4)
#DEFINE GDK_MICRO_VERSION (4)

#IFDEF GDK_DISABLE_DEPRECATION_WARNINGS
#DEFINE GDK_DEPRECATED
#DEFINE GDK_DEPRECATED_FOR(f)
#DEFINE GDK_UNAVAILABLE(maj,min)
#ELSE ' GDK_DISABLE_DEPRECATION_WARNINGS
#DEFINE GDK_DEPRECATED G_DEPRECATED
#DEFINE GDK_DEPRECATED_FOR(f) G_DEPRECATED_FOR(f)
#DEFINE GDK_UNAVAILABLE(maj,min) G_UNAVAILABLE(maj,min)
#ENDIF ' GDK_DISABLE_DEPRECATION_WARNINGS

#DEFINE GDK_VERSION_3_0 (G_ENCODE_VERSION (3, 0))
#DEFINE GDK_VERSION_3_2 (G_ENCODE_VERSION (3, 2))
#DEFINE GDK_VERSION_3_4 (G_ENCODE_VERSION (3, 4))

'#IF (GDK_MINOR_VERSION  MOD 2)
'#DEFINE GDK_VERSION_CUR_STABLE (G_ENCODE_VERSION (GDK_MAJOR_VERSION, GDK_MINOR_VERSION + 1))
'#ELSE ' (GDK_MINOR_VERS...
'#DEFINE GDK_VERSION_CUR_STABLE (G_ENCODE_VERSION (GDK_MAJOR_VERSION, GDK_MINOR_VERSION))
'#ENDIF ' (GDK_MINOR_VERS...

'#IF (GDK_MINOR_VERSION  MOD 2)
'#DEFINE GDK_VERSION_PREV_STABLE (G_ENCODE_VERSION (GDK_MAJOR_VERSION, GDK_MINOR_VERSION - 1))
'#ELSE ' (GDK_MINOR_VERS...
'#DEFINE GDK_VERSION_PREV_STABLE (G_ENCODE_VERSION (GDK_MAJOR_VERSION, GDK_MINOR_VERSION - 2))
'#ENDIF ' (GDK_MINOR_VERS...

'#IFNDEF GDK_VERSION_MIN_REQUIRED
'#DEFINE GDK_VERSION_MIN_REQUIRED (GDK_VERSION_PREV_STABLE)
'#ENDIF ' GDK_VERSION_MIN_REQUIRED

'#IFNDEF GDK_VERSION_MAX_ALLOWED
'#IF GDK_VERSION_MIN_REQUIRED  > GDK_VERSION_PREV_STABLE
'#DEFINE GDK_VERSION_MAX_ALLOWED GDK_VERSION_MIN_REQUIRED
'#ELSE ' GDK_VERSION_MIN...
'#DEFINE GDK_VERSION_MAX_ALLOWED GDK_VERSION_CUR_STABLE
'#ENDIF ' GDK_VERSION_MIN...
'#ENDIF ' GDK_VERSION_MAX_ALLOWED

'#IF GDK_VERSION_MAX_ALLOWED  < GDK_VERSION_MIN_REQUIRED
'#ERROR "GDK_VERSION_MAX_ALLOWED must be >= GDK_VERSION_MIN_REQUIRED"
'#ENDIF ' GDK_VERSION_MAX...

'#IF GDK_VERSION_MIN_REQUIRED  < GDK_VERSION_3_0
'#ERROR "GDK_VERSION_MIN_REQUIRED must be >= GDK_VERSION_3_0"
'#ENDIF ' GDK_VERSION_MIN...

'#IF GDK_VERSION_MIN_REQUIRED  >= GDK_VERSION_3_0
'#DEFINE GDK_DEPRECATED_IN_3_0 GDK_DEPRECATED
'#DEFINE GDK_DEPRECATED_IN_3_0_FOR(f) GDK_DEPRECATED_FOR(f)
'#ELSE ' GDK_VERSION_MIN...
'#DEFINE GDK_DEPRECATED_IN_3_0
'#DEFINE GDK_DEPRECATED_IN_3_0_FOR(f)
'#ENDIF ' GDK_VERSION_MIN...

'#IF GDK_VERSION_MAX_ALLOWED  < GDK_VERSION_3_0
'#DEFINE GDK_AVAILABLE_IN_3_0 GDK_UNAVAILABLE(3, 0)
'#ELSE ' GDK_VERSION_MAX...
'#DEFINE GDK_AVAILABLE_IN_3_0
'#ENDIF ' GDK_VERSION_MAX...

'#IF GDK_VERSION_MIN_REQUIRED  >= GDK_VERSION_3_2
'#DEFINE GDK_DEPRECATED_IN_3_2 GDK_DEPRECATED
'#DEFINE GDK_DEPRECATED_IN_3_2_FOR(f) GDK_DEPRECATED_FOR(f)
'#ELSE ' GDK_VERSION_MIN...
'#DEFINE GDK_DEPRECATED_IN_3_2
'#DEFINE GDK_DEPRECATED_IN_3_2_FOR(f)
'#ENDIF ' GDK_VERSION_MIN...

'#IF GDK_VERSION_MAX_ALLOWED  < GDK_VERSION_3_2
'#DEFINE GDK_AVAILABLE_IN_3_2 GDK_UNAVAILABLE(3, 2)
'#ELSE ' GDK_VERSION_MAX...
'#DEFINE GDK_AVAILABLE_IN_3_2
'#ENDIF ' GDK_VERSION_MAX...

'#IF GDK_VERSION_MIN_REQUIRED  >= GDK_VERSION_3_4
'#DEFINE GDK_DEPRECATED_IN_3_4 GDK_DEPRECATED
'#DEFINE GDK_DEPRECATED_IN_3_4_FOR(f) GDK_DEPRECATED_FOR(f)
'#ELSE ' GDK_VERSION_MIN...
'#DEFINE GDK_DEPRECATED_IN_3_4
'#DEFINE GDK_DEPRECATED_IN_3_4_FOR(f)
'#ENDIF ' GDK_VERSION_MIN...

'#IF GDK_VERSION_MAX_ALLOWED  < GDK_VERSION_3_4
'#DEFINE GDK_AVAILABLE_IN_3_4 GDK_UNAVAILABLE(3, 4)
'#ELSE ' GDK_VERSION_MAX...
'#DEFINE GDK_AVAILABLE_IN_3_4
'#ENDIF ' GDK_VERSION_MAX...
#ENDIF ' __GDK_VERSION_MACROS_H__

#IFNDEF __GDK_APP_LAUNCH_CONTEXT_H__
#DEFINE __GDK_APP_LAUNCH_CONTEXT_H__
#INCLUDE ONCE "gio/gio.bi" '__HEADERS__: gio/gio.h

#IFNDEF __GDK_TYPES_H__
#DEFINE __GDK_TYPES_H__

#INCLUDE ONCE "pango/pango.bi" '__HEADERS__: pango/pango.h
#INCLUDE ONCE "glib-object.bi" '__HEADERS__: glib-object.h
#INCLUDE ONCE "cairo/cairo.bi" '__HEADERS__: cairo.h

#DEFINE GDK_CURRENT_TIME 0L
#DEFINE GDK_PARENT_RELATIVE 1L

TYPE GdkPoint AS _GdkPoint
TYPE GdkRectangle AS cairo_rectangle_int_t
TYPE AS _GdkAtom PTR GdkAtom

#DEFINE GDK_ATOM_TO_POINTER(atom) (atom)
#DEFINE GDK_POINTER_TO_ATOM(ptr) (CAST(GdkAtom, (ptr)))
#DEFINE _GDK_MAKE_ATOM(val) (CAST(GdkAtom, GUINT_TO_POINTER(val)))
#DEFINE GDK_NONE _GDK_MAKE_ATOM (0)

TYPE GdkColor AS _GdkColor
TYPE GdkRGBA AS _GdkRGBA
TYPE GdkCursor AS _GdkCursor
TYPE GdkVisual AS _GdkVisual
TYPE GdkDevice AS _GdkDevice
TYPE GdkDragContext AS _GdkDragContext
TYPE GdkDisplayManager AS _GdkDisplayManager
TYPE GdkDeviceManager AS _GdkDeviceManager
TYPE GdkDisplay AS _GdkDisplay
TYPE GdkScreen AS _GdkScreen
TYPE GdkWindow AS _GdkWindow
TYPE GdkKeymap AS _GdkKeymap
TYPE GdkAppLaunchContext AS _GdkAppLaunchContext

ENUM GdkByteOrder
  GDK_LSB_FIRST
  GDK_MSB_FIRST
END ENUM

ENUM GdkModifierType
  GDK_SHIFT_MASK = 1  SHL 0
  GDK_LOCK_MASK = 1  SHL 1
  GDK_CONTROL_MASK = 1  SHL 2
  GDK_MOD1_MASK = 1  SHL 3
  GDK_MOD2_MASK = 1  SHL 4
  GDK_MOD3_MASK = 1  SHL 5
  GDK_MOD4_MASK = 1  SHL 6
  GDK_MOD5_MASK = 1  SHL 7
  GDK_BUTTON1_MASK = 1  SHL 8
  GDK_BUTTON2_MASK = 1  SHL 9
  GDK_BUTTON3_MASK = 1  SHL 10
  GDK_BUTTON4_MASK = 1  SHL 11
  GDK_BUTTON5_MASK = 1  SHL 12
  GDK_MODIFIER_RESERVED_13_MASK = 1  SHL 13
  GDK_MODIFIER_RESERVED_14_MASK = 1  SHL 14
  GDK_MODIFIER_RESERVED_15_MASK = 1  SHL 15
  GDK_MODIFIER_RESERVED_16_MASK = 1  SHL 16
  GDK_MODIFIER_RESERVED_17_MASK = 1  SHL 17
  GDK_MODIFIER_RESERVED_18_MASK = 1  SHL 18
  GDK_MODIFIER_RESERVED_19_MASK = 1  SHL 19
  GDK_MODIFIER_RESERVED_20_MASK = 1  SHL 20
  GDK_MODIFIER_RESERVED_21_MASK = 1  SHL 21
  GDK_MODIFIER_RESERVED_22_MASK = 1  SHL 22
  GDK_MODIFIER_RESERVED_23_MASK = 1  SHL 23
  GDK_MODIFIER_RESERVED_24_MASK = 1  SHL 24
  GDK_MODIFIER_RESERVED_25_MASK = 1  SHL 25
  GDK_SUPER_MASK = 1  SHL 26
  GDK_HYPER_MASK = 1  SHL 27
  GDK_META_MASK = 1  SHL 28
  GDK_MODIFIER_RESERVED_29_MASK = 1  SHL 29
  GDK_RELEASE_MASK = 1  SHL 30
  GDK_MODIFIER_MASK = &h5C001FFF
END ENUM

ENUM GdkModifierIntent
  GDK_MODIFIER_INTENT_PRIMARY_ACCELERATOR
  GDK_MODIFIER_INTENT_CONTEXT_MENU
  GDK_MODIFIER_INTENT_EXTEND_SELECTION
  GDK_MODIFIER_INTENT_MODIFY_SELECTION
  GDK_MODIFIER_INTENT_NO_TEXT_INPUT
  GDK_MODIFIER_INTENT_SHIFT_GROUP
END ENUM

ENUM GdkStatus
  GDK_OK = 0
  GDK_ERROR = -1
  GDK_ERROR_PARAM = -2
  GDK_ERROR_FILE = -3
  GDK_ERROR_MEM = -4
END ENUM

ENUM GdkGrabStatus
  GDK_GRAB_SUCCESS = 0
  GDK_GRAB_ALREADY_GRABBED = 1
  GDK_GRAB_INVALID_TIME = 2
  GDK_GRAB_NOT_VIEWABLE = 3
  GDK_GRAB_FROZEN = 4
END ENUM

ENUM GdkGrabOwnership
  GDK_OWNERSHIP_NONE
  GDK_OWNERSHIP_WINDOW
  GDK_OWNERSHIP_APPLICATION
END ENUM

ENUM GdkEventMask
  GDK_EXPOSURE_MASK = 1  SHL 1
  GDK_POINTER_MOTION_MASK = 1  SHL 2
  GDK_POINTER_MOTION_HINT_MASK = 1  SHL 3
  GDK_BUTTON_MOTION_MASK = 1  SHL 4
  GDK_BUTTON1_MOTION_MASK = 1  SHL 5
  GDK_BUTTON2_MOTION_MASK = 1  SHL 6
  GDK_BUTTON3_MOTION_MASK = 1  SHL 7
  GDK_BUTTON_PRESS_MASK = 1  SHL 8
  GDK_BUTTON_RELEASE_MASK = 1  SHL 9
  GDK_KEY_PRESS_MASK = 1  SHL 10
  GDK_KEY_RELEASE_MASK = 1  SHL 11
  GDK_ENTER_NOTIFY_MASK = 1  SHL 12
  GDK_LEAVE_NOTIFY_MASK = 1  SHL 13
  GDK_FOCUS_CHANGE_MASK = 1  SHL 14
  GDK_STRUCTURE_MASK = 1  SHL 15
  GDK_PROPERTY_CHANGE_MASK = 1  SHL 16
  GDK_VISIBILITY_NOTIFY_MASK = 1  SHL 17
  GDK_PROXIMITY_IN_MASK = 1  SHL 18
  GDK_PROXIMITY_OUT_MASK = 1  SHL 19
  GDK_SUBSTRUCTURE_MASK = 1  SHL 20
  GDK_SCROLL_MASK = 1  SHL 21
  GDK_TOUCH_MASK = 1  SHL 22
  GDK_SMOOTH_SCROLL_MASK = 1  SHL 23
  GDK_ALL_EVENTS_MASK = &hFFFFFE
END ENUM

TYPE _GdkPoint
  AS gint x
  AS gint y
END TYPE

#ENDIF ' __GDK_TYPES_H__

#IFNDEF __GDK_SCREEN_H__
#DEFINE __GDK_SCREEN_H__

#IFNDEF __GDK_DISPLAY_H__
#DEFINE __GDK_DISPLAY_H__

#IFNDEF __GDK_EVENTS_H__
#DEFINE __GDK_EVENTS_H__

#IFNDEF __GDK_COLOR_H__
#DEFINE __GDK_COLOR_H__

TYPE _GdkColor
  AS guint32 pixel
  AS guint16 red
  AS guint16 green
  AS guint16 blue
END TYPE

#DEFINE GDK_TYPE_COLOR (gdk_color_get_type ())

DECLARE FUNCTION gdk_color_get_type() AS GType
DECLARE FUNCTION gdk_color_copy(BYVAL AS CONST GdkColor PTR) AS GdkColor PTR
DECLARE SUB gdk_color_free(BYVAL AS GdkColor PTR)
DECLARE FUNCTION gdk_color_hash(BYVAL AS CONST GdkColor PTR) AS guint
DECLARE FUNCTION gdk_color_equal(BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR) AS gboolean
DECLARE FUNCTION gdk_color_parse(BYVAL AS CONST gchar PTR, BYVAL AS GdkColor PTR) AS gboolean
DECLARE FUNCTION gdk_color_to_string(BYVAL AS CONST GdkColor PTR) AS gchar PTR

#ENDIF ' __GDK_COLOR_H__

#IFNDEF __GDK_DND_H__
#DEFINE __GDK_DND_H__

#IFNDEF __GDK_DEVICE_H__
#DEFINE __GDK_DEVICE_H__

#DEFINE GDK_TYPE_DEVICE (gdk_device_get_type ())
#DEFINE GDK_DEVICE(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_DEVICE, GdkDevice))
#DEFINE GDK_IS_DEVICE(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_DEVICE))

TYPE GdkTimeCoord AS _GdkTimeCoord

ENUM GdkInputSource
  GDK_SOURCE_MOUSE
  GDK_SOURCE_PEN
  GDK_SOURCE_ERASER
  GDK_SOURCE_CURSOR
  GDK_SOURCE_KEYBOARD
  GDK_SOURCE_TOUCHSCREEN
  GDK_SOURCE_TOUCHPAD
END ENUM

ENUM GdkInputMode
  GDK_MODE_DISABLED
  GDK_MODE_SCREEN
  GDK_MODE_WINDOW
END ENUM

ENUM GdkAxisUse
  GDK_AXIS_IGNORE
  GDK_AXIS_X
  GDK_AXIS_Y
  GDK_AXIS_PRESSURE
  GDK_AXIS_XTILT
  GDK_AXIS_YTILT
  GDK_AXIS_WHEEL
  GDK_AXIS_LAST
END ENUM

ENUM GdkDeviceType
  GDK_DEVICE_TYPE_MASTER
  GDK_DEVICE_TYPE_SLAVE
  GDK_DEVICE_TYPE_FLOATING
END ENUM

#DEFINE GDK_MAX_TIMECOORD_AXES 128

TYPE _GdkTimeCoord
  AS guint32 time
  AS gdouble axes(GDK_MAX_TIMECOORD_AXES-1)
END TYPE

DECLARE FUNCTION gdk_device_get_type() AS GType
DECLARE FUNCTION gdk_device_get_name(BYVAL AS GdkDevice PTR) AS CONST gchar PTR
DECLARE FUNCTION gdk_device_get_has_cursor(BYVAL AS GdkDevice PTR) AS gboolean
DECLARE FUNCTION gdk_device_get_source(BYVAL AS GdkDevice PTR) AS GdkInputSource
DECLARE FUNCTION gdk_device_get_mode(BYVAL AS GdkDevice PTR) AS GdkInputMode
DECLARE FUNCTION gdk_device_set_mode(BYVAL AS GdkDevice PTR, BYVAL AS GdkInputMode) AS gboolean
DECLARE FUNCTION gdk_device_get_n_keys(BYVAL AS GdkDevice PTR) AS gint
DECLARE FUNCTION gdk_device_get_key(BYVAL AS GdkDevice PTR, BYVAL AS guint, BYVAL AS guint PTR, BYVAL AS GdkModifierType PTR) AS gboolean
DECLARE SUB gdk_device_set_key(BYVAL AS GdkDevice PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS GdkModifierType)
DECLARE FUNCTION gdk_device_get_axis_use(BYVAL AS GdkDevice PTR, BYVAL AS guint) AS GdkAxisUse
DECLARE SUB gdk_device_set_axis_use(BYVAL AS GdkDevice PTR, BYVAL AS guint, BYVAL AS GdkAxisUse)
DECLARE SUB gdk_device_get_state(BYVAL AS GdkDevice PTR, BYVAL AS GdkWindow PTR, BYVAL AS gdouble PTR, BYVAL AS GdkModifierType PTR)
DECLARE SUB gdk_device_get_position(BYVAL AS GdkDevice PTR, BYVAL AS GdkScreen PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_device_get_window_at_position(BYVAL AS GdkDevice PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_device_get_history(BYVAL AS GdkDevice PTR, BYVAL AS GdkWindow PTR, BYVAL AS guint32, BYVAL AS guint32, BYVAL AS GdkTimeCoord PTR PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gdk_device_free_history(BYVAL AS GdkTimeCoord PTR PTR, BYVAL AS gint)
DECLARE FUNCTION gdk_device_get_n_axes(BYVAL AS GdkDevice PTR) AS gint
DECLARE FUNCTION gdk_device_list_axes(BYVAL AS GdkDevice PTR) AS GList PTR
DECLARE FUNCTION gdk_device_get_axis_value(BYVAL AS GdkDevice PTR, BYVAL AS gdouble PTR, BYVAL AS GdkAtom, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_device_get_axis(BYVAL AS GdkDevice PTR, BYVAL AS gdouble PTR, BYVAL AS GdkAxisUse, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_device_get_display(BYVAL AS GdkDevice PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_device_get_associated_device(BYVAL AS GdkDevice PTR) AS GdkDevice PTR
DECLARE FUNCTION gdk_device_list_slave_devices(BYVAL AS GdkDevice PTR) AS GList PTR
DECLARE FUNCTION gdk_device_get_device_type(BYVAL AS GdkDevice PTR) AS GdkDeviceType
DECLARE FUNCTION gdk_device_grab(BYVAL AS GdkDevice PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkGrabOwnership, BYVAL AS gboolean, BYVAL AS GdkEventMask, BYVAL AS GdkCursor PTR, BYVAL AS guint32) AS GdkGrabStatus
DECLARE SUB gdk_device_ungrab(BYVAL AS GdkDevice PTR, BYVAL AS guint32)
DECLARE SUB gdk_device_warp(BYVAL AS GdkDevice PTR, BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gdk_device_grab_info_libgtk_only(BYVAL AS GdkDisplay PTR, BYVAL AS GdkDevice PTR, BYVAL AS GdkWindow PTR PTR, BYVAL AS gboolean PTR) AS gboolean

#ENDIF ' __GDK_DEVICE_H__

#DEFINE GDK_TYPE_DRAG_CONTEXT (gdk_drag_context_get_type ())
#DEFINE GDK_DRAG_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DRAG_CONTEXT, GdkDragContext))
#DEFINE GDK_IS_DRAG_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DRAG_CONTEXT))

ENUM GdkDragAction
  GDK_ACTION_DEFAULT = 1  SHL 0
  GDK_ACTION_COPY = 1  SHL 1
  GDK_ACTION_MOVE = 1  SHL 2
  GDK_ACTION_LINK = 1  SHL 3
  GDK_ACTION_PRIVATE = 1  SHL 4
  GDK_ACTION_ASK = 1  SHL 5
END ENUM

ENUM GdkDragProtocol
  GDK_DRAG_PROTO_NONE = 0
  GDK_DRAG_PROTO_MOTIF
  GDK_DRAG_PROTO_XDND
  GDK_DRAG_PROTO_ROOTWIN
  GDK_DRAG_PROTO_WIN32_DROPFILES
  GDK_DRAG_PROTO_OLE2
  GDK_DRAG_PROTO_LOCAL
END ENUM

DECLARE FUNCTION gdk_drag_context_get_type() AS GType
DECLARE SUB gdk_drag_context_set_device(BYVAL AS GdkDragContext PTR, BYVAL AS GdkDevice PTR)
DECLARE FUNCTION gdk_drag_context_get_device(BYVAL AS GdkDragContext PTR) AS GdkDevice PTR
DECLARE FUNCTION gdk_drag_context_list_targets(BYVAL AS GdkDragContext PTR) AS GList PTR
DECLARE FUNCTION gdk_drag_context_get_actions(BYVAL AS GdkDragContext PTR) AS GdkDragAction
DECLARE FUNCTION gdk_drag_context_get_suggested_action(BYVAL AS GdkDragContext PTR) AS GdkDragAction
DECLARE FUNCTION gdk_drag_context_get_selected_action(BYVAL AS GdkDragContext PTR) AS GdkDragAction
DECLARE FUNCTION gdk_drag_context_get_source_window(BYVAL AS GdkDragContext PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_drag_context_get_dest_window(BYVAL AS GdkDragContext PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_drag_context_get_protocol(BYVAL AS GdkDragContext PTR) AS GdkDragProtocol
DECLARE SUB gdk_drag_status(BYVAL AS GdkDragContext PTR, BYVAL AS GdkDragAction, BYVAL AS guint32)
DECLARE SUB gdk_drop_reply(BYVAL AS GdkDragContext PTR, BYVAL AS gboolean, BYVAL AS guint32)
DECLARE SUB gdk_drop_finish(BYVAL AS GdkDragContext PTR, BYVAL AS gboolean, BYVAL AS guint32)
DECLARE FUNCTION gdk_drag_get_selection(BYVAL AS GdkDragContext PTR) AS GdkAtom
DECLARE FUNCTION gdk_drag_begin(BYVAL AS GdkWindow PTR, BYVAL AS GList PTR) AS GdkDragContext PTR
DECLARE FUNCTION gdk_drag_begin_for_device(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR, BYVAL AS GList PTR) AS GdkDragContext PTR
DECLARE SUB gdk_drag_find_window_for_screen(BYVAL AS GdkDragContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkWindow PTR PTR, BYVAL AS GdkDragProtocol PTR)
DECLARE FUNCTION gdk_drag_motion(BYVAL AS GdkDragContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkDragProtocol, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkDragAction, BYVAL AS GdkDragAction, BYVAL AS guint32) AS gboolean
DECLARE SUB gdk_drag_drop(BYVAL AS GdkDragContext PTR, BYVAL AS guint32)
DECLARE SUB gdk_drag_abort(BYVAL AS GdkDragContext PTR, BYVAL AS guint32)
DECLARE FUNCTION gdk_drag_drop_succeeded(BYVAL AS GdkDragContext PTR) AS gboolean

#ENDIF ' __GDK_DND_H__

#DEFINE GDK_TYPE_EVENT (gdk_event_get_type ())
#DEFINE GDK_PRIORITY_EVENTS (G_PRIORITY_DEFAULT)
#DEFINE GDK_PRIORITY_REDRAW (G_PRIORITY_HIGH_IDLE + 20)
#DEFINE GDK_EVENT_PROPAGATE (FALSE)
#DEFINE GDK_EVENT_STOP (TRUE)
#DEFINE GDK_BUTTON_PRIMARY (1)
#DEFINE GDK_BUTTON_MIDDLE (2)
#DEFINE GDK_BUTTON_SECONDARY (3)

TYPE GdkEventAny AS _GdkEventAny
TYPE GdkEventExpose AS _GdkEventExpose
TYPE GdkEventVisibility AS _GdkEventVisibility
TYPE GdkEventMotion AS _GdkEventMotion
TYPE GdkEventButton AS _GdkEventButton
TYPE GdkEventTouch AS _GdkEventTouch
TYPE GdkEventScroll AS _GdkEventScroll
TYPE GdkEventKey AS _GdkEventKey
TYPE GdkEventFocus AS _GdkEventFocus
TYPE GdkEventCrossing AS _GdkEventCrossing
TYPE GdkEventConfigure AS _GdkEventConfigure
TYPE GdkEventProperty AS _GdkEventProperty
TYPE GdkEventSelection AS _GdkEventSelection
TYPE GdkEventOwnerChange AS _GdkEventOwnerChange
TYPE GdkEventProximity AS _GdkEventProximity
TYPE GdkEventDND AS _GdkEventDND
TYPE GdkEventWindowState AS _GdkEventWindowState
TYPE GdkEventSetting AS _GdkEventSetting
TYPE GdkEventGrabBroken AS _GdkEventGrabBroken
TYPE GdkEventSequence AS _GdkEventSequence
TYPE GdkEvent AS _GdkEvent
TYPE GdkEventFunc AS SUB(BYVAL AS GdkEvent PTR, BYVAL AS gpointer)
TYPE GdkXEvent AS ANY

ENUM GdkFilterReturn
  GDK_FILTER_CONTINUE
  GDK_FILTER_TRANSLATE
  GDK_FILTER_REMOVE
END ENUM

TYPE GdkFilterFunc AS FUNCTION(BYVAL AS GdkXEvent PTR, BYVAL AS GdkEvent PTR, BYVAL AS gpointer) AS GdkFilterReturn

ENUM GdkEventType
  GDK_NOTHING = -1
  GDK_DELETE = 0
  GDK_DESTROY = 1
  GDK_EXPOSE = 2
  GDK_MOTION_NOTIFY = 3
  GDK_BUTTON_PRESS = 4
  GDK_2BUTTON_PRESS = 5
  GDK_3BUTTON_PRESS = 6
  GDK_BUTTON_RELEASE = 7
  GDK_KEY_PRESS = 8
  GDK_KEY_RELEASE = 9
  GDK_ENTER_NOTIFY = 10
  GDK_LEAVE_NOTIFY = 11
  GDK_FOCUS_CHANGE = 12
  GDK_CONFIGURE = 13
  GDK_MAP = 14
  GDK_UNMAP = 15
  GDK_PROPERTY_NOTIFY = 16
  GDK_SELECTION_CLEAR = 17
  GDK_SELECTION_REQUEST = 18
  GDK_SELECTION_NOTIFY = 19
  GDK_PROXIMITY_IN = 20
  GDK_PROXIMITY_OUT = 21
  GDK_DRAG_ENTER = 22
  GDK_DRAG_LEAVE = 23
  GDK_DRAG_MOTION_ = 24
  GDK_DRAG_STATUS_ = 25
  GDK_DROP_START = 26
  GDK_DROP_FINISHED = 27
  GDK_CLIENT_EVENT = 28
  GDK_VISIBILITY_NOTIFY = 29
  GDK_SCROLL = 31
  GDK_WINDOW_STATE = 32
  GDK_SETTING = 33
  GDK_OWNER_CHANGE = 34
  GDK_GRAB_BROKEN = 35
  GDK_DAMAGE = 36
  GDK_TOUCH_BEGIN = 37
  GDK_TOUCH_UPDATE = 38
  GDK_TOUCH_END = 39
  GDK_TOUCH_CANCEL = 40
  GDK_EVENT_LAST
END ENUM

ENUM GdkVisibilityState
  GDK_VISIBILITY_UNOBSCURED
  GDK_VISIBILITY_PARTIAL
  GDK_VISIBILITY_FULLY_OBSCURED
END ENUM

ENUM GdkScrollDirection
  GDK_SCROLL_UP
  GDK_SCROLL_DOWN
  GDK_SCROLL_LEFT
  GDK_SCROLL_RIGHT
  GDK_SCROLL_SMOOTH
END ENUM

ENUM GdkNotifyType
  GDK_NOTIFY_ANCESTOR = 0
  GDK_NOTIFY_VIRTUAL = 1
  GDK_NOTIFY_INFERIOR = 2
  GDK_NOTIFY_NONLINEAR = 3
  GDK_NOTIFY_NONLINEAR_VIRTUAL = 4
  GDK_NOTIFY_UNKNOWN = 5
END ENUM

ENUM GdkCrossingMode
  GDK_CROSSING_NORMAL
  GDK_CROSSING_GRAB
  GDK_CROSSING_UNGRAB
  GDK_CROSSING_GTK_GRAB
  GDK_CROSSING_GTK_UNGRAB
  GDK_CROSSING_STATE_CHANGED
  GDK_CROSSING_TOUCH_BEGIN
  GDK_CROSSING_TOUCH_END
  GDK_CROSSING_DEVICE_SWITCH
END ENUM

ENUM GdkPropertyState
  GDK_PROPERTY_NEW_VALUE
  GDK_PROPERTY_DELETE_
END ENUM

ENUM GdkWindowState
  GDK_WINDOW_STATE_WITHDRAWN = 1  SHL 0
  GDK_WINDOW_STATE_ICONIFIED = 1  SHL 1
  GDK_WINDOW_STATE_MAXIMIZED = 1  SHL 2
  GDK_WINDOW_STATE_STICKY = 1  SHL 3
  GDK_WINDOW_STATE_FULLSCREEN = 1  SHL 4
  GDK_WINDOW_STATE_ABOVE = 1  SHL 5
  GDK_WINDOW_STATE_BELOW = 1  SHL 6
  GDK_WINDOW_STATE_FOCUSED = 1  SHL 7
END ENUM

ENUM GdkSettingAction
  GDK_SETTING_ACTION_NEW
  GDK_SETTING_ACTION_CHANGED
  GDK_SETTING_ACTION_DELETED
END ENUM

ENUM GdkOwnerChange
  GDK_OWNER_CHANGE_NEW_OWNER
  GDK_OWNER_CHANGE_DESTROY
  GDK_OWNER_CHANGE_CLOSE
END ENUM

TYPE _GdkEventAny
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
END TYPE

TYPE _GdkEventExpose
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkRectangle area
  AS cairo_region_t PTR region
  AS gint count
END TYPE

TYPE _GdkEventVisibility
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkVisibilityState state
END TYPE

TYPE _GdkEventMotion
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS guint32 time
  AS gdouble x
  AS gdouble y
  AS gdouble PTR axes
  AS guint state
  AS gint16 is_hint
  AS GdkDevice PTR device
  AS gdouble x_root, y_root
END TYPE

TYPE _GdkEventButton
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS guint32 time
  AS gdouble x
  AS gdouble y
  AS gdouble PTR axes
  AS guint state
  AS guint button
  AS GdkDevice PTR device
  AS gdouble x_root, y_root
END TYPE

TYPE _GdkEventTouch
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS guint32 time
  AS gdouble x
  AS gdouble y
  AS gdouble PTR axes
  AS guint state
  AS GdkEventSequence PTR sequence
  AS gboolean emulating_pointer
  AS GdkDevice PTR device
  AS gdouble x_root, y_root
END TYPE

TYPE _GdkEventScroll
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS guint32 time
  AS gdouble x
  AS gdouble y
  AS guint state
  AS GdkScrollDirection direction
  AS GdkDevice PTR device
  AS gdouble x_root, y_root
  AS gdouble delta_x
  AS gdouble delta_y
END TYPE

TYPE _GdkEventKey
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS guint32 time
  AS guint state
  AS guint keyval
  AS gint length
  AS gchar PTR string
  AS guint16 hardware_keycode
  AS guint8 group
  AS guint is_modifier : 1
END TYPE

TYPE _GdkEventCrossing
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkWindow PTR subwindow
  AS guint32 time
  AS gdouble x
  AS gdouble y
  AS gdouble x_root
  AS gdouble y_root
  AS GdkCrossingMode mode
  AS GdkNotifyType detail
  AS gboolean focus
  AS guint state
END TYPE

TYPE _GdkEventFocus
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS gint16 in
END TYPE

TYPE _GdkEventConfigure
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS gint x, y
  AS gint width
  AS gint height
END TYPE

TYPE _GdkEventProperty
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkAtom atom
  AS guint32 time
  AS guint state
END TYPE

TYPE _GdkEventSelection
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkAtom selection
  AS GdkAtom target
  AS GdkAtom property
  AS guint32 time
  AS GdkWindow PTR requestor
END TYPE

TYPE _GdkEventOwnerChange
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkWindow PTR owner
  AS GdkOwnerChange reason
  AS GdkAtom selection
  AS guint32 time
  AS guint32 selection_time
END TYPE

TYPE _GdkEventProximity
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS guint32 time
  AS GdkDevice PTR device
END TYPE

TYPE _GdkEventSetting
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkSettingAction action
  AS ZSTRING PTR name
END TYPE

TYPE _GdkEventWindowState
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkWindowState changed_mask
  AS GdkWindowState new_window_state
END TYPE

TYPE _GdkEventGrabBroken
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS gboolean keyboard
  AS gboolean implicit
  AS GdkWindow PTR grab_window
END TYPE

TYPE _GdkEventDND
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkDragContext PTR context
  AS guint32 time
  AS gshort x_root, y_root
END TYPE

UNION _GdkEvent
  AS GdkEventType type
  AS GdkEventAny any
  AS GdkEventExpose expose
  AS GdkEventVisibility visibility
  AS GdkEventMotion motion
  AS GdkEventButton button
  AS GdkEventTouch touch
  AS GdkEventScroll scroll
  AS GdkEventKey key
  AS GdkEventCrossing crossing
  AS GdkEventFocus focus_change
  AS GdkEventConfigure configure
  AS GdkEventProperty property
  AS GdkEventSelection selection
  AS GdkEventOwnerChange owner_change
  AS GdkEventProximity proximity
  AS GdkEventDND dnd
  AS GdkEventWindowState window_state
  AS GdkEventSetting setting
  AS GdkEventGrabBroken grab_broken
END UNION

DECLARE FUNCTION gdk_event_get_type() AS GType
DECLARE FUNCTION gdk_events_pending() AS gboolean
DECLARE FUNCTION gdk_event_get() AS GdkEvent PTR
DECLARE FUNCTION gdk_event_peek() AS GdkEvent PTR
DECLARE SUB gdk_event_put(BYVAL AS CONST GdkEvent PTR)
DECLARE FUNCTION gdk_event_new(BYVAL AS GdkEventType) AS GdkEvent PTR
DECLARE FUNCTION gdk_event_copy(BYVAL AS CONST GdkEvent PTR) AS GdkEvent PTR
DECLARE SUB gdk_event_free(BYVAL AS GdkEvent PTR)
DECLARE FUNCTION gdk_event_get_time(BYVAL AS CONST GdkEvent PTR) AS guint32
DECLARE FUNCTION gdk_event_get_state(BYVAL AS CONST GdkEvent PTR, BYVAL AS GdkModifierType PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_coords(BYVAL AS CONST GdkEvent PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_root_coords(BYVAL AS CONST GdkEvent PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_button(BYVAL AS CONST GdkEvent PTR, BYVAL AS guint PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_click_count(BYVAL AS CONST GdkEvent PTR, BYVAL AS guint PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_keyval(BYVAL AS CONST GdkEvent PTR, BYVAL AS guint PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_keycode(BYVAL AS CONST GdkEvent PTR, BYVAL AS guint16 PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_scroll_direction(BYVAL AS CONST GdkEvent PTR, BYVAL AS GdkScrollDirection PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_scroll_deltas(BYVAL AS CONST GdkEvent PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_axis(BYVAL AS CONST GdkEvent PTR, BYVAL AS GdkAxisUse, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB gdk_event_set_device(BYVAL AS GdkEvent PTR, BYVAL AS GdkDevice PTR)
DECLARE FUNCTION gdk_event_get_device(BYVAL AS CONST GdkEvent PTR) AS GdkDevice PTR
DECLARE SUB gdk_event_set_source_device(BYVAL AS GdkEvent PTR, BYVAL AS GdkDevice PTR)
DECLARE FUNCTION gdk_event_get_source_device(BYVAL AS CONST GdkEvent PTR) AS GdkDevice PTR
DECLARE SUB gdk_event_request_motions(BYVAL AS CONST GdkEventMotion PTR)
DECLARE FUNCTION gdk_event_triggers_context_menu(BYVAL AS CONST GdkEvent PTR) AS gboolean
DECLARE FUNCTION gdk_events_get_distance(BYVAL AS GdkEvent PTR, BYVAL AS GdkEvent PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_events_get_angle(BYVAL AS GdkEvent PTR, BYVAL AS GdkEvent PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_events_get_center(BYVAL AS GdkEvent PTR, BYVAL AS GdkEvent PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB gdk_event_handler_set(BYVAL AS GdkEventFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gdk_event_set_screen(BYVAL AS GdkEvent PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gdk_event_get_screen(BYVAL AS CONST GdkEvent PTR) AS GdkScreen PTR
DECLARE FUNCTION gdk_event_get_event_sequence(BYVAL AS CONST GdkEvent PTR) AS GdkEventSequence PTR
DECLARE SUB gdk_set_show_events(BYVAL AS gboolean)
DECLARE FUNCTION gdk_get_show_events() AS gboolean

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_setting_get(BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR) AS gboolean

#ENDIF ' GDK_MULTIHEAD_SAFE
#ENDIF ' __GDK_EVENTS_H__

#IFNDEF __GDK_DEVICE_MANAGER_H__
#DEFINE __GDK_DEVICE_MANAGER_H__

#DEFINE GDK_TYPE_DEVICE_MANAGER (gdk_device_manager_get_type ())
#DEFINE GDK_DEVICE_MANAGER(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_DEVICE_MANAGER, GdkDeviceManager))
#DEFINE GDK_IS_DEVICE_MANAGER(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_DEVICE_MANAGER))

DECLARE FUNCTION gdk_device_manager_get_type() AS GType
DECLARE FUNCTION gdk_device_manager_get_display(BYVAL AS GdkDeviceManager PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_device_manager_list_devices(BYVAL AS GdkDeviceManager PTR, BYVAL AS GdkDeviceType) AS GList PTR
DECLARE FUNCTION gdk_device_manager_get_client_pointer(BYVAL AS GdkDeviceManager PTR) AS GdkDevice PTR

#ENDIF ' __GDK_DEVICE_MANAGER_H__

#DEFINE GDK_TYPE_DISPLAY (gdk_display_get_type ())
#DEFINE GDK_DISPLAY(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY, GdkDisplay))
#DEFINE GDK_IS_DISPLAY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY))

#IFNDEF GDK_DISABLE_DEPRECATED
#DEFINE GDK_DISPLAY_OBJECT(object) GDK_DISPLAY(object)
#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_display_get_type() AS GType
DECLARE FUNCTION gdk_display_open(BYVAL AS CONST gchar PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_display_get_name(BYVAL AS GdkDisplay PTR) AS CONST gchar PTR
DECLARE FUNCTION gdk_display_get_n_screens(BYVAL AS GdkDisplay PTR) AS gint
DECLARE FUNCTION gdk_display_get_screen(BYVAL AS GdkDisplay PTR, BYVAL AS gint) AS GdkScreen PTR
DECLARE FUNCTION gdk_display_get_default_screen(BYVAL AS GdkDisplay PTR) AS GdkScreen PTR

#IFNDEF GDK_MULTIDEVICE_SAFE

DECLARE SUB gdk_display_pointer_ungrab(BYVAL AS GdkDisplay PTR, BYVAL AS guint32)
DECLARE SUB gdk_display_keyboard_ungrab(BYVAL AS GdkDisplay PTR, BYVAL AS guint32)
DECLARE FUNCTION gdk_display_pointer_is_grabbed(BYVAL AS GdkDisplay PTR) AS gboolean

#ENDIF ' GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_display_device_is_grabbed(BYVAL AS GdkDisplay PTR, BYVAL AS GdkDevice PTR) AS gboolean
DECLARE SUB gdk_display_beep(BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_display_sync(BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_display_flush(BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_display_close(BYVAL AS GdkDisplay PTR)
DECLARE FUNCTION gdk_display_is_closed(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_list_devices(BYVAL AS GdkDisplay PTR) AS GList PTR
DECLARE FUNCTION gdk_display_get_event(BYVAL AS GdkDisplay PTR) AS GdkEvent PTR
DECLARE FUNCTION gdk_display_peek_event(BYVAL AS GdkDisplay PTR) AS GdkEvent PTR
DECLARE SUB gdk_display_put_event(BYVAL AS GdkDisplay PTR, BYVAL AS CONST GdkEvent PTR)
DECLARE FUNCTION gdk_display_has_pending(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE SUB gdk_display_set_double_click_time(BYVAL AS GdkDisplay PTR, BYVAL AS guint)
DECLARE SUB gdk_display_set_double_click_distance(BYVAL AS GdkDisplay PTR, BYVAL AS guint)
DECLARE FUNCTION gdk_display_get_default() AS GdkDisplay PTR

#IFNDEF GDK_MULTIDEVICE_SAFE

DECLARE SUB gdk_display_get_pointer(BYVAL AS GdkDisplay PTR, BYVAL AS GdkScreen PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gdk_display_get_window_at_pointer(BYVAL AS GdkDisplay PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR
DECLARE SUB gdk_display_warp_pointer(BYVAL AS GdkDisplay PTR, BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint)

#ENDIF ' GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_display_open_default_libgtk_only() AS GdkDisplay PTR
DECLARE FUNCTION gdk_display_supports_cursor_alpha(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_supports_cursor_color(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_get_default_cursor_size(BYVAL AS GdkDisplay PTR) AS guint
DECLARE SUB gdk_display_get_maximal_cursor_size(BYVAL AS GdkDisplay PTR, BYVAL AS guint PTR, BYVAL AS guint PTR)
DECLARE FUNCTION gdk_display_get_default_group(BYVAL AS GdkDisplay PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_display_supports_selection_notification(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_request_selection_notification(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom) AS gboolean
DECLARE FUNCTION gdk_display_supports_clipboard_persistence(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE SUB gdk_display_store_clipboard(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR, BYVAL AS guint32, BYVAL AS CONST GdkAtom PTR, BYVAL AS gint)
DECLARE FUNCTION gdk_display_supports_shapes(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_supports_input_shapes(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_supports_composite(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE SUB gdk_display_notify_startup_complete(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR)
DECLARE FUNCTION gdk_display_get_device_manager(BYVAL AS GdkDisplay PTR) AS GdkDeviceManager PTR
DECLARE FUNCTION gdk_display_get_app_launch_context(BYVAL AS GdkDisplay PTR) AS GdkAppLaunchContext PTR

#ENDIF ' __GDK_DISPLAY_H__

#DEFINE GDK_TYPE_SCREEN (gdk_screen_get_type ())
#DEFINE GDK_SCREEN(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_SCREEN, GdkScreen))
#DEFINE GDK_IS_SCREEN(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_SCREEN))

DECLARE FUNCTION gdk_screen_get_type() AS GType
DECLARE FUNCTION gdk_screen_get_system_visual(BYVAL AS GdkScreen PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_screen_get_rgba_visual(BYVAL AS GdkScreen PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_screen_is_composited(BYVAL AS GdkScreen PTR) AS gboolean
DECLARE FUNCTION gdk_screen_get_root_window(BYVAL AS GdkScreen PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_screen_get_display(BYVAL AS GdkScreen PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_screen_get_number(BYVAL AS GdkScreen PTR) AS gint
DECLARE FUNCTION gdk_screen_get_width(BYVAL AS GdkScreen PTR) AS gint
DECLARE FUNCTION gdk_screen_get_height(BYVAL AS GdkScreen PTR) AS gint
DECLARE FUNCTION gdk_screen_get_width_mm(BYVAL AS GdkScreen PTR) AS gint
DECLARE FUNCTION gdk_screen_get_height_mm(BYVAL AS GdkScreen PTR) AS gint
DECLARE FUNCTION gdk_screen_list_visuals(BYVAL AS GdkScreen PTR) AS GList PTR
DECLARE FUNCTION gdk_screen_get_toplevel_windows(BYVAL AS GdkScreen PTR) AS GList PTR
DECLARE FUNCTION gdk_screen_make_display_name(BYVAL AS GdkScreen PTR) AS gchar PTR
DECLARE FUNCTION gdk_screen_get_n_monitors(BYVAL AS GdkScreen PTR) AS gint
DECLARE FUNCTION gdk_screen_get_primary_monitor(BYVAL AS GdkScreen PTR) AS gint
DECLARE SUB gdk_screen_get_monitor_geometry(BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS GdkRectangle PTR)
DECLARE SUB gdk_screen_get_monitor_workarea(BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gdk_screen_get_monitor_at_point(BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_at_window(BYVAL AS GdkScreen PTR, BYVAL AS GdkWindow PTR) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_width_mm(BYVAL AS GdkScreen PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_height_mm(BYVAL AS GdkScreen PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_plug_name(BYVAL AS GdkScreen PTR, BYVAL AS gint) AS gchar PTR
DECLARE FUNCTION gdk_screen_get_default() AS GdkScreen PTR
DECLARE FUNCTION gdk_screen_get_setting(BYVAL AS GdkScreen PTR, BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR) AS gboolean
DECLARE SUB gdk_screen_set_font_options(BYVAL AS GdkScreen PTR, BYVAL AS CONST cairo_font_options_t PTR)
DECLARE FUNCTION gdk_screen_get_font_options(BYVAL AS GdkScreen PTR) AS CONST cairo_font_options_t PTR
DECLARE SUB gdk_screen_set_resolution(BYVAL AS GdkScreen PTR, BYVAL AS gdouble)
DECLARE FUNCTION gdk_screen_get_resolution(BYVAL AS GdkScreen PTR) AS gdouble
DECLARE FUNCTION gdk_screen_get_active_window(BYVAL AS GdkScreen PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_screen_get_window_stack(BYVAL AS GdkScreen PTR) AS GList PTR

#ENDIF ' __GDK_SCREEN_H__

#DEFINE GDK_TYPE_APP_LAUNCH_CONTEXT (gdk_app_launch_context_get_type ())
#DEFINE GDK_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_CAST ((o), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContext))
#DEFINE GDK_IS_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_APP_LAUNCH_CONTEXT))

DECLARE FUNCTION gdk_app_launch_context_get_type() AS GType
DECLARE FUNCTION gdk_app_launch_context_new() AS GdkAppLaunchContext PTR
DECLARE SUB gdk_app_launch_context_set_display(BYVAL AS GdkAppLaunchContext PTR, BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_app_launch_context_set_screen(BYVAL AS GdkAppLaunchContext PTR, BYVAL AS GdkScreen PTR)
DECLARE SUB gdk_app_launch_context_set_desktop(BYVAL AS GdkAppLaunchContext PTR, BYVAL AS gint)
DECLARE SUB gdk_app_launch_context_set_timestamp(BYVAL AS GdkAppLaunchContext PTR, BYVAL AS guint32)
DECLARE SUB gdk_app_launch_context_set_icon(BYVAL AS GdkAppLaunchContext PTR, BYVAL AS GIcon PTR)
DECLARE SUB gdk_app_launch_context_set_icon_name(BYVAL AS GdkAppLaunchContext PTR, BYVAL AS CONST ZSTRING PTR)

#ENDIF ' __GDK_APP_LAUNCH_CONTEXT_H__

#IFNDEF __GDK_CAIRO_H__
#DEFINE __GDK_CAIRO_H__


#IFNDEF __GDK_RGBA_H__
#DEFINE __GDK_RGBA_H__

TYPE _GdkRGBA
  AS gdouble red
  AS gdouble green
  AS gdouble blue
  AS gdouble alpha
END TYPE

#DEFINE GDK_TYPE_RGBA (gdk_rgba_get_type ())

DECLARE FUNCTION gdk_rgba_get_type() AS GType
DECLARE FUNCTION gdk_rgba_copy(BYVAL AS CONST GdkRGBA PTR) AS GdkRGBA PTR
DECLARE SUB gdk_rgba_free(BYVAL AS GdkRGBA PTR)
DECLARE FUNCTION gdk_rgba_hash(BYVAL AS gconstpointer) AS guint
DECLARE FUNCTION gdk_rgba_equal(BYVAL AS gconstpointer, BYVAL AS gconstpointer) AS gboolean
DECLARE FUNCTION gdk_rgba_parse(BYVAL AS GdkRGBA PTR, BYVAL AS CONST gchar PTR) AS gboolean
DECLARE FUNCTION gdk_rgba_to_string(BYVAL AS CONST GdkRGBA PTR) AS gchar PTR

#ENDIF ' __GDK_RGBA_H__

#IFNDEF __GDK_PIXBUF_H__
#DEFINE __GDK_PIXBUF_H__

#INCLUDE ONCE "gdk-pixbuf/gdk-pixbuf.bi" '__HEADERS__: gdk-pixbuf/gdk-pixbuf.h

DECLARE FUNCTION gdk_pixbuf_get_from_window(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_get_from_surface(BYVAL AS cairo_surface_t PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkPixbuf PTR

#ENDIF ' __GDK_PIXBUF_H__

#INCLUDE ONCE "pango/pangocairo.bi" '__HEADERS__: pango/pangocairo.h

DECLARE FUNCTION gdk_cairo_create(BYVAL AS GdkWindow PTR) AS cairo_t PTR
DECLARE FUNCTION gdk_cairo_get_clip_rectangle(BYVAL AS cairo_t PTR, BYVAL AS GdkRectangle PTR) AS gboolean
DECLARE SUB gdk_cairo_set_source_rgba(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRGBA PTR)
DECLARE SUB gdk_cairo_set_source_pixbuf(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkPixbuf PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gdk_cairo_set_source_window(BYVAL AS cairo_t PTR, BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble)
DECLARE SUB gdk_cairo_rectangle(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gdk_cairo_region(BYVAL AS cairo_t PTR, BYVAL AS CONST cairo_region_t PTR)
DECLARE FUNCTION gdk_cairo_region_create_from_surface(BYVAL AS cairo_surface_t PTR) AS cairo_region_t PTR
DECLARE SUB gdk_cairo_set_source_color(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkColor PTR)

#ENDIF ' __GDK_CAIRO_H__

#IFNDEF __GDK_CURSOR_H__
#DEFINE __GDK_CURSOR_H__

#DEFINE GDK_TYPE_CURSOR (gdk_cursor_get_type ())
#DEFINE GDK_CURSOR(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_CURSOR, GdkCursor))
#DEFINE GDK_IS_CURSOR(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_CURSOR))

ENUM GdkCursorType
  GDK_X_CURSOR = 0
  GDK_ARROW = 2
  GDK_BASED_ARROW_DOWN = 4
  GDK_BASED_ARROW_UP = 6
  GDK_BOAT = 8
  GDK_BOGOSITY = 10
  GDK_BOTTOM_LEFT_CORNER = 12
  GDK_BOTTOM_RIGHT_CORNER = 14
  GDK_BOTTOM_SIDE = 16
  GDK_BOTTOM_TEE = 18
  GDK_BOX_SPIRAL = 20
  GDK_CENTER_PTR = 22
  GDK_CIRCLE = 24
  GDK_CLOCK = 26
  GDK_COFFEE_MUG = 28
  GDK_CROSS = 30
  GDK_CROSS_REVERSE = 32
  GDK_CROSSHAIR = 34
  GDK_DIAMOND_CROSS = 36
  GDK_DOT = 38
  GDK_DOTBOX = 40
  GDK_DOUBLE_ARROW = 42
  GDK_DRAFT_LARGE = 44
  GDK_DRAFT_SMALL = 46
  GDK_DRAPED_BOX = 48
  GDK_EXCHANGE = 50
  GDK_FLEUR = 52
  GDK_GOBBLER = 54
  GDK_GUMBY = 56
  GDK_HAND1 = 58
  GDK_HAND2 = 60
  GDK_HEART = 62
  GDK_ICON = 64
  GDK_IRON_CROSS = 66
  GDK_LEFT_PTR = 68
  GDK_LEFT_SIDE = 70
  GDK_LEFT_TEE = 72
  GDK_LEFTBUTTON = 74
  GDK_LL_ANGLE = 76
  GDK_LR_ANGLE = 78
  GDK_MAN = 80
  GDK_MIDDLEBUTTON = 82
  GDK_MOUSE = 84
  GDK_PENCIL = 86
  GDK_PIRATE = 88
  GDK_PLUS = 90
  GDK_QUESTION_ARROW = 92
  GDK_RIGHT_PTR = 94
  GDK_RIGHT_SIDE = 96
  GDK_RIGHT_TEE = 98
  GDK_RIGHTBUTTON = 100
  GDK_RTL_LOGO = 102
  GDK_SAILBOAT = 104
  GDK_SB_DOWN_ARROW = 106
  GDK_SB_H_DOUBLE_ARROW = 108
  GDK_SB_LEFT_ARROW = 110
  GDK_SB_RIGHT_ARROW = 112
  GDK_SB_UP_ARROW = 114
  GDK_SB_V_DOUBLE_ARROW = 116
  GDK_SHUTTLE = 118
  GDK_SIZING = 120
  GDK_SPIDER = 122
  GDK_SPRAYCAN = 124
  GDK_STAR = 126
  GDK_TARGET = 128
  GDK_TCROSS = 130
  GDK_TOP_LEFT_ARROW = 132
  GDK_TOP_LEFT_CORNER = 134
  GDK_TOP_RIGHT_CORNER = 136
  GDK_TOP_SIDE = 138
  GDK_TOP_TEE = 140
  GDK_TREK = 142
  GDK_UL_ANGLE = 144
  GDK_UMBRELLA = 146
  GDK_UR_ANGLE = 148
  GDK_WATCH = 150
  GDK_XTERM = 152
  GDK_LAST_CURSOR
  GDK_BLANK_CURSOR = -2
  GDK_CURSOR_IS_PIXMAP = -1
END ENUM

DECLARE FUNCTION gdk_cursor_get_type() AS GType
DECLARE FUNCTION gdk_cursor_new_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkCursorType) AS GdkCursor PTR

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_cursor_new(BYVAL AS GdkCursorType) AS GdkCursor PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_cursor_new_from_pixbuf(BYVAL AS GdkDisplay PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gint, BYVAL AS gint) AS GdkCursor PTR
DECLARE FUNCTION gdk_cursor_new_from_name(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR) AS GdkCursor PTR
DECLARE FUNCTION gdk_cursor_get_display(BYVAL AS GdkCursor PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_cursor_ref(BYVAL AS GdkCursor PTR) AS GdkCursor PTR
DECLARE SUB gdk_cursor_unref(BYVAL AS GdkCursor PTR)
DECLARE FUNCTION gdk_cursor_get_image(BYVAL AS GdkCursor PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_cursor_get_cursor_type(BYVAL AS GdkCursor PTR) AS GdkCursorType

#ENDIF ' __GDK_CURSOR_H__

#IFNDEF __GDK_DISPLAY_MANAGER_H__
#DEFINE __GDK_DISPLAY_MANAGER_H__

#DEFINE GDK_TYPE_DISPLAY_MANAGER (gdk_display_manager_get_type ())
#DEFINE GDK_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManager))
#DEFINE GDK_IS_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY_MANAGER))

DECLARE FUNCTION gdk_display_manager_get_type() AS GType
DECLARE FUNCTION gdk_display_manager_get() AS GdkDisplayManager PTR
DECLARE FUNCTION gdk_display_manager_get_default_display(BYVAL AS GdkDisplayManager PTR) AS GdkDisplay PTR
DECLARE SUB gdk_display_manager_set_default_display(BYVAL AS GdkDisplayManager PTR, BYVAL AS GdkDisplay PTR)
DECLARE FUNCTION gdk_display_manager_list_displays(BYVAL AS GdkDisplayManager PTR) AS GSList PTR
DECLARE FUNCTION gdk_display_manager_open_display(BYVAL AS GdkDisplayManager PTR, BYVAL AS CONST gchar PTR) AS GdkDisplay PTR

#ENDIF ' __GDK_DISPLAY_MANAGER_H__

#IFNDEF __GDK_ENUM_TYPES_H__
#DEFINE __GDK_ENUM_TYPES_H__

DECLARE FUNCTION gdk_cursor_type_get_type() AS GType
#DEFINE GDK_TYPE_CURSOR_TYPE (gdk_cursor_type_get_type ())
DECLARE FUNCTION gdk_input_source_get_type() AS GType
#DEFINE GDK_TYPE_INPUT_SOURCE (gdk_input_source_get_type ())
DECLARE FUNCTION gdk_input_mode_get_type() AS GType
#DEFINE GDK_TYPE_INPUT_MODE (gdk_input_mode_get_type ())
DECLARE FUNCTION gdk_axis_use_get_type() AS GType
#DEFINE GDK_TYPE_AXIS_USE (gdk_axis_use_get_type ())
DECLARE FUNCTION gdk_device_type_get_type() AS GType
#DEFINE GDK_TYPE_DEVICE_TYPE (gdk_device_type_get_type ())
DECLARE FUNCTION gdk_drag_action_get_type() AS GType
#DEFINE GDK_TYPE_DRAG_ACTION (gdk_drag_action_get_type ())
DECLARE FUNCTION gdk_drag_protocol_get_type() AS GType
#DEFINE GDK_TYPE_DRAG_PROTOCOL (gdk_drag_protocol_get_type ())
DECLARE FUNCTION gdk_filter_return_get_type() AS GType
#DEFINE GDK_TYPE_FILTER_RETURN (gdk_filter_return_get_type ())
DECLARE FUNCTION gdk_event_type_get_type() AS GType
#DEFINE GDK_TYPE_EVENT_TYPE (gdk_event_type_get_type ())
DECLARE FUNCTION gdk_visibility_state_get_type() AS GType
#DEFINE GDK_TYPE_VISIBILITY_STATE (gdk_visibility_state_get_type ())
DECLARE FUNCTION gdk_scroll_direction_get_type() AS GType
#DEFINE GDK_TYPE_SCROLL_DIRECTION (gdk_scroll_direction_get_type ())
DECLARE FUNCTION gdk_notify_type_get_type() AS GType
#DEFINE GDK_TYPE_NOTIFY_TYPE (gdk_notify_type_get_type ())
DECLARE FUNCTION gdk_crossing_mode_get_type() AS GType
#DEFINE GDK_TYPE_CROSSING_MODE (gdk_crossing_mode_get_type ())
DECLARE FUNCTION gdk_property_state_get_type() AS GType
#DEFINE GDK_TYPE_PROPERTY_STATE (gdk_property_state_get_type ())
DECLARE FUNCTION gdk_window_state_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_STATE (gdk_window_state_get_type ())
DECLARE FUNCTION gdk_setting_action_get_type() AS GType
#DEFINE GDK_TYPE_SETTING_ACTION (gdk_setting_action_get_type ())
DECLARE FUNCTION gdk_owner_change_get_type() AS GType
#DEFINE GDK_TYPE_OWNER_CHANGE (gdk_owner_change_get_type ())
DECLARE FUNCTION gdk_prop_mode_get_type() AS GType
#DEFINE GDK_TYPE_PROP_MODE (gdk_prop_mode_get_type ())
DECLARE FUNCTION gdk_byte_order_get_type() AS GType
#DEFINE GDK_TYPE_BYTE_ORDER (gdk_byte_order_get_type ())
DECLARE FUNCTION gdk_modifier_type_get_type() AS GType
#DEFINE GDK_TYPE_MODIFIER_TYPE (gdk_modifier_type_get_type ())
DECLARE FUNCTION gdk_modifier_intent_get_type() AS GType
#DEFINE GDK_TYPE_MODIFIER_INTENT (gdk_modifier_intent_get_type ())
DECLARE FUNCTION gdk_status_get_type() AS GType
#DEFINE GDK_TYPE_STATUS (gdk_status_get_type ())
DECLARE FUNCTION gdk_grab_status_get_type() AS GType
#DEFINE GDK_TYPE_GRAB_STATUS (gdk_grab_status_get_type ())
DECLARE FUNCTION gdk_grab_ownership_get_type() AS GType
#DEFINE GDK_TYPE_GRAB_OWNERSHIP (gdk_grab_ownership_get_type ())
DECLARE FUNCTION gdk_event_mask_get_type() AS GType
#DEFINE GDK_TYPE_EVENT_MASK (gdk_event_mask_get_type ())
DECLARE FUNCTION gdk_visual_type_get_type() AS GType
#DEFINE GDK_TYPE_VISUAL_TYPE (gdk_visual_type_get_type ())
DECLARE FUNCTION gdk_window_window_class_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_WINDOW_CLASS (gdk_window_window_class_get_type ())
DECLARE FUNCTION gdk_window_type_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_TYPE (gdk_window_type_get_type ())
DECLARE FUNCTION gdk_window_attributes_type_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_ATTRIBUTES_TYPE (gdk_window_attributes_type_get_type ())
DECLARE FUNCTION gdk_window_hints_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_HINTS (gdk_window_hints_get_type ())
DECLARE FUNCTION gdk_window_type_hint_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_TYPE_HINT (gdk_window_type_hint_get_type ())
DECLARE FUNCTION gdk_wm_decoration_get_type() AS GType
#DEFINE GDK_TYPE_WM_DECORATION (gdk_wm_decoration_get_type ())
DECLARE FUNCTION gdk_wm_function_get_type() AS GType
#DEFINE GDK_TYPE_WM_FUNCTION (gdk_wm_function_get_type ())
DECLARE FUNCTION gdk_gravity_get_type() AS GType
#DEFINE GDK_TYPE_GRAVITY (gdk_gravity_get_type ())
DECLARE FUNCTION gdk_window_edge_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_EDGE (gdk_window_edge_get_type ())

#ENDIF ' __GDK_ENUM_TYPES_H__

#IFNDEF __GDK_KEYS_H__
#DEFINE __GDK_KEYS_H__

TYPE GdkKeymapKey AS _GdkKeymapKey

TYPE _GdkKeymapKey
  AS guint keycode
  AS gint group
  AS gint level
END TYPE

#DEFINE GDK_TYPE_KEYMAP (gdk_keymap_get_type ())
#DEFINE GDK_KEYMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_KEYMAP, GdkKeymap))
#DEFINE GDK_IS_KEYMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_KEYMAP))

DECLARE FUNCTION gdk_keymap_get_type() AS GType

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_keymap_get_default() AS GdkKeymap PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_keymap_get_for_display(BYVAL AS GdkDisplay PTR) AS GdkKeymap PTR
DECLARE FUNCTION gdk_keymap_lookup_key(BYVAL AS GdkKeymap PTR, BYVAL AS CONST GdkKeymapKey PTR) AS guint
DECLARE FUNCTION gdk_keymap_translate_keyboard_state(BYVAL AS GdkKeymap PTR, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS gint, BYVAL AS guint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_entries_for_keyval(BYVAL AS GdkKeymap PTR, BYVAL AS guint, BYVAL AS GdkKeymapKey PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_entries_for_keycode(BYVAL AS GdkKeymap PTR, BYVAL AS guint, BYVAL AS GdkKeymapKey PTR PTR, BYVAL AS guint PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_direction(BYVAL AS GdkKeymap PTR) AS PangoDirection
DECLARE FUNCTION gdk_keymap_have_bidi_layouts(BYVAL AS GdkKeymap PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_caps_lock_state(BYVAL AS GdkKeymap PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_num_lock_state(BYVAL AS GdkKeymap PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_modifier_state(BYVAL AS GdkKeymap PTR) AS guint
DECLARE SUB gdk_keymap_add_virtual_modifiers(BYVAL AS GdkKeymap PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gdk_keymap_map_virtual_modifiers(BYVAL AS GdkKeymap PTR, BYVAL AS GdkModifierType PTR) AS gboolean
DECLARE FUNCTION gdk_keymap_get_modifier_mask(BYVAL AS GdkKeymap PTR, BYVAL AS GdkModifierIntent) AS GdkModifierType
DECLARE FUNCTION gdk_keyval_name(BYVAL AS guint) AS gchar PTR
DECLARE FUNCTION gdk_keyval_from_name(BYVAL AS CONST gchar PTR) AS guint
DECLARE SUB gdk_keyval_convert_case(BYVAL AS guint, BYVAL AS guint PTR, BYVAL AS guint PTR)
DECLARE FUNCTION gdk_keyval_to_upper(BYVAL AS guint) AS guint
DECLARE FUNCTION gdk_keyval_to_lower(BYVAL AS guint) AS guint
DECLARE FUNCTION gdk_keyval_is_upper(BYVAL AS guint) AS gboolean
DECLARE FUNCTION gdk_keyval_is_lower(BYVAL AS guint) AS gboolean
DECLARE FUNCTION gdk_keyval_to_unicode(BYVAL AS guint) AS guint32
DECLARE FUNCTION gdk_unicode_to_keyval(BYVAL AS guint32) AS guint

#ENDIF ' __GDK_KEYS_H__

#IFNDEF __GDK_KEYSYMS_H__
#DEFINE __GDK_KEYSYMS_H__
#DEFINE GDK_KEY_VoidSymbol &hFFFFFF
#DEFINE GDK_KEY_BackSpace &hFF08
#DEFINE GDK_KEY_Tab &hFF09
#DEFINE GDK_KEY_Linefeed &hFF0A
#DEFINE GDK_KEY_Clear &hFF0B
#DEFINE GDK_KEY_Return &hFF0D
#DEFINE GDK_KEY_Pause &hFF13
#DEFINE GDK_KEY_Scroll_Lock &hFF14
#DEFINE GDK_KEY_Sys_Req &hFF15
#DEFINE GDK_KEY_Escape &hFF1B
#DEFINE GDK_KEY_Delete &hFFFF
#DEFINE GDK_KEY_Multi_key &hFF20
#DEFINE GDK_KEY_Codeinput &hFF37
#DEFINE GDK_KEY_SingleCandidate &hFF3C
#DEFINE GDK_KEY_MultipleCandidate &hFF3D
#DEFINE GDK_KEY_PreviousCandidate &hFF3E
#DEFINE GDK_KEY_Kanji &hFF21
#DEFINE GDK_KEY_Muhenkan &hFF22
#DEFINE GDK_KEY_Henkan_Mode &hFF23
#DEFINE GDK_KEY_Henkan &hFF23
#DEFINE GDK_KEY_Romaji &hFF24
#DEFINE GDK_KEY_Hiragana &hFF25
#DEFINE GDK_KEY_Katakana &hFF26
#DEFINE GDK_KEY_Hiragana_Katakana &hFF27
#DEFINE GDK_KEY_Zenkaku &hFF28
#DEFINE GDK_KEY_Hankaku &hFF29
#DEFINE GDK_KEY_Zenkaku_Hankaku &hFF2A
#DEFINE GDK_KEY_Touroku &hFF2B
#DEFINE GDK_KEY_Massyo &hFF2C
#DEFINE GDK_KEY_Kana_Lock &hFF2D
#DEFINE GDK_KEY_Kana_Shift &hFF2E
#DEFINE GDK_KEY_Eisu_Shift &hFF2F
#DEFINE GDK_KEY_Eisu_toggle &hFF30
#DEFINE GDK_KEY_Kanji_Bangou &hFF37
#DEFINE GDK_KEY_Zen_Koho &hFF3D
#DEFINE GDK_KEY_Mae_Koho &hFF3E
#DEFINE GDK_KEY_Home &hFF50
#DEFINE GDK_KEY_Left &hFF51
#DEFINE GDK_KEY_Up &hFF52
#DEFINE GDK_KEY_Right &hFF53
#DEFINE GDK_KEY_Down &hFF54
#DEFINE GDK_KEY_Prior &hFF55
#DEFINE GDK_KEY_Page_Up &hFF55
#DEFINE GDK_KEY_Next &hFF56
#DEFINE GDK_KEY_Page_Down &hFF56
#DEFINE GDK_KEY_End &hFF57
#DEFINE GDK_KEY_Begin &hFF58
#DEFINE GDK_KEY_Select &hFF60
#DEFINE GDK_KEY_Print &hFF61
#DEFINE GDK_KEY_Execute &hFF62
#DEFINE GDK_KEY_Insert &hFF63
#DEFINE GDK_KEY_Undo &hFF65
#DEFINE GDK_KEY_Redo &hFF66
#DEFINE GDK_KEY_Menu &hFF67
#DEFINE GDK_KEY_Find &hFF68
#DEFINE GDK_KEY_Cancel &hFF69
#DEFINE GDK_KEY_Help &hFF6A
#DEFINE GDK_KEY_Break &hFF6B
#DEFINE GDK_KEY_Mode_switch &hFF7E
#DEFINE GDK_KEY_script_switch &hFF7E
#DEFINE GDK_KEY_Num_Lock &hFF7F
#DEFINE GDK_KEY_KP_Space &hFF80
#DEFINE GDK_KEY_KP_Tab &hFF89
#DEFINE GDK_KEY_KP_Enter &hFF8D
#DEFINE GDK_KEY_KP_F1 &hFF91
#DEFINE GDK_KEY_KP_F2 &hFF92
#DEFINE GDK_KEY_KP_F3 &hFF93
#DEFINE GDK_KEY_KP_F4 &hFF94
#DEFINE GDK_KEY_KP_Home &hFF95
#DEFINE GDK_KEY_KP_Left &hFF96
#DEFINE GDK_KEY_KP_Up &hFF97
#DEFINE GDK_KEY_KP_Right &hFF98
#DEFINE GDK_KEY_KP_Down &hFF99
#DEFINE GDK_KEY_KP_Prior &hFF9A
#DEFINE GDK_KEY_KP_Page_Up &hFF9A
#DEFINE GDK_KEY_KP_Next &hFF9B
#DEFINE GDK_KEY_KP_Page_Down &hFF9B
#DEFINE GDK_KEY_KP_End &hFF9C
#DEFINE GDK_KEY_KP_Begin &hFF9D
#DEFINE GDK_KEY_KP_Insert &hFF9E
#DEFINE GDK_KEY_KP_Delete &hFF9F
#DEFINE GDK_KEY_KP_Equal &hFFBD
#DEFINE GDK_KEY_KP_Multiply &hFFAA
#DEFINE GDK_KEY_KP_Add &hFFAB
#DEFINE GDK_KEY_KP_Separator &hFFAC
#DEFINE GDK_KEY_KP_Subtract &hFFAD
#DEFINE GDK_KEY_KP_Decimal &hFFAE
#DEFINE GDK_KEY_KP_Divide &hFFAF
#DEFINE GDK_KEY_KP_0 &hFFB0
#DEFINE GDK_KEY_KP_1 &hFFB1
#DEFINE GDK_KEY_KP_2 &hFFB2
#DEFINE GDK_KEY_KP_3 &hFFB3
#DEFINE GDK_KEY_KP_4 &hFFB4
#DEFINE GDK_KEY_KP_5 &hFFB5
#DEFINE GDK_KEY_KP_6 &hFFB6
#DEFINE GDK_KEY_KP_7 &hFFB7
#DEFINE GDK_KEY_KP_8 &hFFB8
#DEFINE GDK_KEY_KP_9 &hFFB9
#DEFINE GDK_KEY_F1 &hFFBE
#DEFINE GDK_KEY_F2 &hFFBF
#DEFINE GDK_KEY_F3 &hFFC0
#DEFINE GDK_KEY_F4 &hFFC1
#DEFINE GDK_KEY_F5 &hFFC2
#DEFINE GDK_KEY_F6 &hFFC3
#DEFINE GDK_KEY_F7 &hFFC4
#DEFINE GDK_KEY_F8 &hFFC5
#DEFINE GDK_KEY_F9 &hFFC6
#DEFINE GDK_KEY_F10 &hFFC7
#DEFINE GDK_KEY_F11 &hFFC8
#DEFINE GDK_KEY_L1 &hFFC8
#DEFINE GDK_KEY_F12 &hFFC9
#DEFINE GDK_KEY_L2 &hFFC9
#DEFINE GDK_KEY_F13 &hFFCA
#DEFINE GDK_KEY_L3 &hFFCA
#DEFINE GDK_KEY_F14 &hFFCB
#DEFINE GDK_KEY_L4 &hFFCB
#DEFINE GDK_KEY_F15 &hFFCC
#DEFINE GDK_KEY_L5 &hFFCC
#DEFINE GDK_KEY_F16 &hFFCD
#DEFINE GDK_KEY_L6 &hFFCD
#DEFINE GDK_KEY_F17 &hFFCE
#DEFINE GDK_KEY_L7 &hFFCE
#DEFINE GDK_KEY_F18 &hFFCF
#DEFINE GDK_KEY_L8 &hFFCF
#DEFINE GDK_KEY_F19 &hFFD0
#DEFINE GDK_KEY_L9 &hFFD0
#DEFINE GDK_KEY_F20 &hFFD1
#DEFINE GDK_KEY_L10 &hFFD1
#DEFINE GDK_KEY_F21 &hFFD2
#DEFINE GDK_KEY_R1 &hFFD2
#DEFINE GDK_KEY_F22 &hFFD3
#DEFINE GDK_KEY_R2 &hFFD3
#DEFINE GDK_KEY_F23 &hFFD4
#DEFINE GDK_KEY_R3 &hFFD4
#DEFINE GDK_KEY_F24 &hFFD5
#DEFINE GDK_KEY_R4 &hFFD5
#DEFINE GDK_KEY_F25 &hFFD6
#DEFINE GDK_KEY_R5 &hFFD6
#DEFINE GDK_KEY_F26 &hFFD7
#DEFINE GDK_KEY_R6 &hFFD7
#DEFINE GDK_KEY_F27 &hFFD8
#DEFINE GDK_KEY_R7 &hFFD8
#DEFINE GDK_KEY_F28 &hFFD9
#DEFINE GDK_KEY_R8 &hFFD9
#DEFINE GDK_KEY_F29 &hFFDA
#DEFINE GDK_KEY_R9 &hFFDA
#DEFINE GDK_KEY_F30 &hFFDB
#DEFINE GDK_KEY_R10 &hFFDB
#DEFINE GDK_KEY_F31 &hFFDC
#DEFINE GDK_KEY_R11 &hFFDC
#DEFINE GDK_KEY_F32 &hFFDD
#DEFINE GDK_KEY_R12 &hFFDD
#DEFINE GDK_KEY_F33 &hFFDE
#DEFINE GDK_KEY_R13 &hFFDE
#DEFINE GDK_KEY_F34 &hFFDF
#DEFINE GDK_KEY_R14 &hFFDF
#DEFINE GDK_KEY_F35 &hFFE0
#DEFINE GDK_KEY_R15 &hFFE0
#DEFINE GDK_KEY_Shift_L &hFFE1
#DEFINE GDK_KEY_Shift_R &hFFE2
#DEFINE GDK_KEY_Control_L &hFFE3
#DEFINE GDK_KEY_Control_R &hFFE4
#DEFINE GDK_KEY_Caps_Lock &hFFE5
#DEFINE GDK_KEY_Shift_Lock &hFFE6
#DEFINE GDK_KEY_Meta_L &hFFE7
#DEFINE GDK_KEY_Meta_R &hFFE8
#DEFINE GDK_KEY_Alt_L &hFFE9
#DEFINE GDK_KEY_Alt_R &hFFEA
#DEFINE GDK_KEY_Super_L &hFFEB
#DEFINE GDK_KEY_Super_R &hFFEC
#DEFINE GDK_KEY_Hyper_L &hFFED
#DEFINE GDK_KEY_Hyper_R &hFFEE
#DEFINE GDK_KEY_ISO_Lock &hFE01
#DEFINE GDK_KEY_ISO_Level2_Latch &hFE02
#DEFINE GDK_KEY_ISO_Level3_Shift &hFE03
#DEFINE GDK_KEY_ISO_Level3_Latch &hFE04
#DEFINE GDK_KEY_ISO_Level3_Lock &hFE05
#DEFINE GDK_KEY_ISO_Level5_Shift &hFE11
#DEFINE GDK_KEY_ISO_Level5_Latch &hFE12
#DEFINE GDK_KEY_ISO_Level5_Lock &hFE13
#DEFINE GDK_KEY_ISO_Group_Shift &hFF7E
#DEFINE GDK_KEY_ISO_Group_Latch &hFE06
#DEFINE GDK_KEY_ISO_Group_Lock &hFE07
#DEFINE GDK_KEY_ISO_Next_Group &hFE08
#DEFINE GDK_KEY_ISO_Next_Group_Lock &hFE09
#DEFINE GDK_KEY_ISO_Prev_Group &hFE0A
#DEFINE GDK_KEY_ISO_Prev_Group_Lock &hFE0B
#DEFINE GDK_KEY_ISO_First_Group &hFE0C
#DEFINE GDK_KEY_ISO_First_Group_Lock &hFE0D
#DEFINE GDK_KEY_ISO_Last_Group &hFE0E
#DEFINE GDK_KEY_ISO_Last_Group_Lock &hFE0F
#DEFINE GDK_KEY_ISO_Left_Tab &hFE20
#DEFINE GDK_KEY_ISO_Move_Line_Up &hFE21
#DEFINE GDK_KEY_ISO_Move_Line_Down &hFE22
#DEFINE GDK_KEY_ISO_Partial_Line_Up &hFE23
#DEFINE GDK_KEY_ISO_Partial_Line_Down &hFE24
#DEFINE GDK_KEY_ISO_Partial_Space_Left &hFE25
#DEFINE GDK_KEY_ISO_Partial_Space_Right &hFE26
#DEFINE GDK_KEY_ISO_Set_Margin_Left &hFE27
#DEFINE GDK_KEY_ISO_Set_Margin_Right &hFE28
#DEFINE GDK_KEY_ISO_Release_Margin_Left &hFE29
#DEFINE GDK_KEY_ISO_Release_Margin_Right &hFE2A
#DEFINE GDK_KEY_ISO_Release_Both_Margins &hFE2B
#DEFINE GDK_KEY_ISO_Fast_Cursor_Left &hFE2C
#DEFINE GDK_KEY_ISO_Fast_Cursor_Right &hFE2D
#DEFINE GDK_KEY_ISO_Fast_Cursor_Up &hFE2E
#DEFINE GDK_KEY_ISO_Fast_Cursor_Down &hFE2F
#DEFINE GDK_KEY_ISO_Continuous_Underline &hFE30
#DEFINE GDK_KEY_ISO_Discontinuous_Underline &hFE31
#DEFINE GDK_KEY_ISO_Emphasize &hFE32
#DEFINE GDK_KEY_ISO_Center_Object &hFE33
#DEFINE GDK_KEY_ISO_Enter &hFE34
#DEFINE GDK_KEY_dead_grave &hFE50
#DEFINE GDK_KEY_dead_acute &hFE51
#DEFINE GDK_KEY_dead_circumflex &hFE52
#DEFINE GDK_KEY_dead_tilde &hFE53
#DEFINE GDK_KEY_dead_perispomeni &hFE53
#DEFINE GDK_KEY_dead_macron &hFE54
#DEFINE GDK_KEY_dead_breve &hFE55
#DEFINE GDK_KEY_dead_abovedot &hFE56
#DEFINE GDK_KEY_dead_diaeresis &hFE57
#DEFINE GDK_KEY_dead_abovering &hFE58
#DEFINE GDK_KEY_dead_doubleacute &hFE59
#DEFINE GDK_KEY_dead_caron &hFE5A
#DEFINE GDK_KEY_dead_cedilla &hFE5B
#DEFINE GDK_KEY_dead_ogonek &hFE5C
#DEFINE GDK_KEY_dead_iota &hFE5D
#DEFINE GDK_KEY_dead_voiced_sound &hFE5E
#DEFINE GDK_KEY_dead_semivoiced_sound &hFE5F
#DEFINE GDK_KEY_dead_belowdot &hFE60
#DEFINE GDK_KEY_dead_hook &hFE61
#DEFINE GDK_KEY_dead_horn &hFE62
#DEFINE GDK_KEY_dead_stroke &hFE63
#DEFINE GDK_KEY_dead_abovecomma &hFE64
#DEFINE GDK_KEY_dead_psili &hFE64
#DEFINE GDK_KEY_dead_abovereversedcomma &hFE65
#DEFINE GDK_KEY_dead_dasia &hFE65
#DEFINE GDK_KEY_dead_doublegrave &hFE66
#DEFINE GDK_KEY_dead_belowring &hFE67
#DEFINE GDK_KEY_dead_belowmacron &hFE68
#DEFINE GDK_KEY_dead_belowcircumflex &hFE69
#DEFINE GDK_KEY_dead_belowtilde &hFE6A
#DEFINE GDK_KEY_dead_belowbreve &hFE6B
#DEFINE GDK_KEY_dead_belowdiaeresis &hFE6C
#DEFINE GDK_KEY_dead_invertedbreve &hFE6D
#DEFINE GDK_KEY_dead_belowcomma &hFE6E
#DEFINE GDK_KEY_dead_currency &hFE6F
#DEFINE GDK_KEY_dead_a &hFE80
#DEFINE GDK_KEY_dead_A_ &hFE81
#DEFINE GDK_KEY_dead_e &hFE82
#DEFINE GDK_KEY_dead_E_ &hFE83
#DEFINE GDK_KEY_dead_i &hFE84
#DEFINE GDK_KEY_dead_I_ &hFE85
#DEFINE GDK_KEY_dead_o &hFE86
#DEFINE GDK_KEY_dead_O_ &hFE87
#DEFINE GDK_KEY_dead_u &hFE88
#DEFINE GDK_KEY_dead_U_ &hFE89
#DEFINE GDK_KEY_dead_small_schwa &hFE8A
#DEFINE GDK_KEY_dead_capital_schwa &hFE8B
#DEFINE GDK_KEY_dead_greek &hFE8C
#DEFINE GDK_KEY_First_Virtual_Screen &hFED0
#DEFINE GDK_KEY_Prev_Virtual_Screen &hFED1
#DEFINE GDK_KEY_Next_Virtual_Screen &hFED2
#DEFINE GDK_KEY_Last_Virtual_Screen &hFED4
#DEFINE GDK_KEY_Terminate_Server &hFED5
#DEFINE GDK_KEY_AccessX_Enable &hFE70
#DEFINE GDK_KEY_AccessX_Feedback_Enable &hFE71
#DEFINE GDK_KEY_RepeatKeys_Enable &hFE72
#DEFINE GDK_KEY_SlowKeys_Enable &hFE73
#DEFINE GDK_KEY_BounceKeys_Enable &hFE74
#DEFINE GDK_KEY_StickyKeys_Enable &hFE75
#DEFINE GDK_KEY_MouseKeys_Enable &hFE76
#DEFINE GDK_KEY_MouseKeys_Accel_Enable &hFE77
#DEFINE GDK_KEY_Overlay1_Enable &hFE78
#DEFINE GDK_KEY_Overlay2_Enable &hFE79
#DEFINE GDK_KEY_AudibleBell_Enable &hFE7A
#DEFINE GDK_KEY_Pointer_Left &hFEE0
#DEFINE GDK_KEY_Pointer_Right &hFEE1
#DEFINE GDK_KEY_Pointer_Up &hFEE2
#DEFINE GDK_KEY_Pointer_Down &hFEE3
#DEFINE GDK_KEY_Pointer_UpLeft &hFEE4
#DEFINE GDK_KEY_Pointer_UpRight &hFEE5
#DEFINE GDK_KEY_Pointer_DownLeft &hFEE6
#DEFINE GDK_KEY_Pointer_DownRight &hFEE7
#DEFINE GDK_KEY_Pointer_Button_Dflt &hFEE8
#DEFINE GDK_KEY_Pointer_Button1 &hFEE9
#DEFINE GDK_KEY_Pointer_Button2 &hFEEA
#DEFINE GDK_KEY_Pointer_Button3 &hFEEB
#DEFINE GDK_KEY_Pointer_Button4 &hFEEC
#DEFINE GDK_KEY_Pointer_Button5 &hFEED
#DEFINE GDK_KEY_Pointer_DblClick_Dflt &hFEEE
#DEFINE GDK_KEY_Pointer_DblClick1 &hFEEF
#DEFINE GDK_KEY_Pointer_DblClick2 &hFEF0
#DEFINE GDK_KEY_Pointer_DblClick3 &hFEF1
#DEFINE GDK_KEY_Pointer_DblClick4 &hFEF2
#DEFINE GDK_KEY_Pointer_DblClick5 &hFEF3
#DEFINE GDK_KEY_Pointer_Drag_Dflt &hFEF4
#DEFINE GDK_KEY_Pointer_Drag1 &hFEF5
#DEFINE GDK_KEY_Pointer_Drag2 &hFEF6
#DEFINE GDK_KEY_Pointer_Drag3 &hFEF7
#DEFINE GDK_KEY_Pointer_Drag4 &hFEF8
#DEFINE GDK_KEY_Pointer_Drag5 &hFEFD
#DEFINE GDK_KEY_Pointer_EnableKeys &hFEF9
#DEFINE GDK_KEY_Pointer_Accelerate &hFEFA
#DEFINE GDK_KEY_Pointer_DfltBtnNext &hFEFB
#DEFINE GDK_KEY_Pointer_DfltBtnPrev &hFEFC
#DEFINE GDK_KEY_ch &hFEA0
#DEFINE GDK_KEY_Ch_ &hFEA1
#DEFINE GDK_KEY_CH__ &hFEA2
#DEFINE GDK_KEY_c_h &hFEA3
#DEFINE GDK_KEY_C_h_ &hFEA4
#DEFINE GDK_KEY_C_H__ &hFEA5
#DEFINE GDK_KEY_3270_Duplicate &hFD01
#DEFINE GDK_KEY_3270_FieldMark &hFD02
#DEFINE GDK_KEY_3270_Right2 &hFD03
#DEFINE GDK_KEY_3270_Left2 &hFD04
#DEFINE GDK_KEY_3270_BackTab &hFD05
#DEFINE GDK_KEY_3270_EraseEOF &hFD06
#DEFINE GDK_KEY_3270_EraseInput &hFD07
#DEFINE GDK_KEY_3270_Reset &hFD08
#DEFINE GDK_KEY_3270_Quit &hFD09
#DEFINE GDK_KEY_3270_PA1 &hFD0A
#DEFINE GDK_KEY_3270_PA2 &hFD0B
#DEFINE GDK_KEY_3270_PA3 &hFD0C
#DEFINE GDK_KEY_3270_Test &hFD0D
#DEFINE GDK_KEY_3270_Attn &hFD0E
#DEFINE GDK_KEY_3270_CursorBlink &hFD0F
#DEFINE GDK_KEY_3270_AltCursor &hFD10
#DEFINE GDK_KEY_3270_KeyClick &hFD11
#DEFINE GDK_KEY_3270_Jump &hFD12
#DEFINE GDK_KEY_3270_Ident &hFD13
#DEFINE GDK_KEY_3270_Rule &hFD14
#DEFINE GDK_KEY_3270_Copy &hFD15
#DEFINE GDK_KEY_3270_Play &hFD16
#DEFINE GDK_KEY_3270_Setup &hFD17
#DEFINE GDK_KEY_3270_Record &hFD18
#DEFINE GDK_KEY_3270_ChangeScreen &hFD19
#DEFINE GDK_KEY_3270_DeleteWord &hFD1A
#DEFINE GDK_KEY_3270_ExSelect &hFD1B
#DEFINE GDK_KEY_3270_CursorSelect &hFD1C
#DEFINE GDK_KEY_3270_PrintScreen &hFD1D
#DEFINE GDK_KEY_3270_Enter &hFD1E
#DEFINE GDK_KEY_space &h020
#DEFINE GDK_KEY_exclam &h021
#DEFINE GDK_KEY_quotedbl &h022
#DEFINE GDK_KEY_numbersign &h023
#DEFINE GDK_KEY_dollar &h024
#DEFINE GDK_KEY_percent &h025
#DEFINE GDK_KEY_ampersand &h026
#DEFINE GDK_KEY_apostrophe &h027
#DEFINE GDK_KEY_quoteright &h027
#DEFINE GDK_KEY_parenleft &h028
#DEFINE GDK_KEY_parenright &h029
#DEFINE GDK_KEY_asterisk &h02A
#DEFINE GDK_KEY_plus &h02B
#DEFINE GDK_KEY_comma &h02C
#DEFINE GDK_KEY_minus &h02D
#DEFINE GDK_KEY_period &h02E
#DEFINE GDK_KEY_slash &h02F
#DEFINE GDK_KEY_0 &h030
#DEFINE GDK_KEY_1 &h031
#DEFINE GDK_KEY_2 &h032
#DEFINE GDK_KEY_3 &h033
#DEFINE GDK_KEY_4 &h034
#DEFINE GDK_KEY_5 &h035
#DEFINE GDK_KEY_6 &h036
#DEFINE GDK_KEY_7 &h037
#DEFINE GDK_KEY_8 &h038
#DEFINE GDK_KEY_9 &h039
#DEFINE GDK_KEY_colon &h03A
#DEFINE GDK_KEY_semicolon &h03B
#DEFINE GDK_KEY_less &h03C
#DEFINE GDK_KEY_equal &h03D
#DEFINE GDK_KEY_greater &h03E
#DEFINE GDK_KEY_question &h03F
#DEFINE GDK_KEY_at &h040
#DEFINE GDK_KEY_A_ &h041
#DEFINE GDK_KEY_B_ &h042
#DEFINE GDK_KEY_C_ &h043
#DEFINE GDK_KEY_D_ &h044
#DEFINE GDK_KEY_E_ &h045
#DEFINE GDK_KEY_F_ &h046
#DEFINE GDK_KEY_G_ &h047
#DEFINE GDK_KEY_H_ &h048
#DEFINE GDK_KEY_I_ &h049
#DEFINE GDK_KEY_J_ &h04A
#DEFINE GDK_KEY_K_ &h04B
#DEFINE GDK_KEY_L_ &h04C
#DEFINE GDK_KEY_M_ &h04D
#DEFINE GDK_KEY_N_ &h04E
#DEFINE GDK_KEY_O_ &h04F
#DEFINE GDK_KEY_P_ &h050
#DEFINE GDK_KEY_Q_ &h051
#DEFINE GDK_KEY_R_ &h052
#DEFINE GDK_KEY_S_ &h053
#DEFINE GDK_KEY_T_ &h054
#DEFINE GDK_KEY_U_ &h055
#DEFINE GDK_KEY_V_ &h056
#DEFINE GDK_KEY_W_ &h057
#DEFINE GDK_KEY_X_ &h058
#DEFINE GDK_KEY_Y_ &h059
#DEFINE GDK_KEY_Z_ &h05A
#DEFINE GDK_KEY_bracketleft &h05B
#DEFINE GDK_KEY_backslash &h05C
#DEFINE GDK_KEY_bracketright &h05D
#DEFINE GDK_KEY_asciicircum &h05E
#DEFINE GDK_KEY_underscore &h05F
#DEFINE GDK_KEY_grave &h060
#DEFINE GDK_KEY_quoteleft &h060
#DEFINE GDK_KEY_a &h061
#DEFINE GDK_KEY_b &h062
#DEFINE GDK_KEY_c &h063
#DEFINE GDK_KEY_d &h064
#DEFINE GDK_KEY_e &h065
#DEFINE GDK_KEY_f &h066
#DEFINE GDK_KEY_g &h067
#DEFINE GDK_KEY_h &h068
#DEFINE GDK_KEY_i &h069
#DEFINE GDK_KEY_j &h06A
#DEFINE GDK_KEY_k &h06B
#DEFINE GDK_KEY_l &h06C
#DEFINE GDK_KEY_m &h06D
#DEFINE GDK_KEY_n &h06E
#DEFINE GDK_KEY_o &h06F
#DEFINE GDK_KEY_p &h070
#DEFINE GDK_KEY_q &h071
#DEFINE GDK_KEY_r &h072
#DEFINE GDK_KEY_s &h073
#DEFINE GDK_KEY_t &h074
#DEFINE GDK_KEY_u &h075
#DEFINE GDK_KEY_v &h076
#DEFINE GDK_KEY_w &h077
#DEFINE GDK_KEY_x &h078
#DEFINE GDK_KEY_y &h079
#DEFINE GDK_KEY_z &h07A
#DEFINE GDK_KEY_braceleft &h07B
#DEFINE GDK_KEY_bar &h07C
#DEFINE GDK_KEY_braceright &h07D
#DEFINE GDK_KEY_asciitilde &h07E
#DEFINE GDK_KEY_nobreakspace &h0A0
#DEFINE GDK_KEY_exclamdown &h0A1
#DEFINE GDK_KEY_cent &h0A2
#DEFINE GDK_KEY_sterling &h0A3
#DEFINE GDK_KEY_currency &h0A4
#DEFINE GDK_KEY_yen &h0A5
#DEFINE GDK_KEY_brokenbar &h0A6
#DEFINE GDK_KEY_section &h0A7
#DEFINE GDK_KEY_diaeresis &h0A8
#DEFINE GDK_KEY_copyright &h0A9
#DEFINE GDK_KEY_ordfeminine &h0AA
#DEFINE GDK_KEY_guillemotleft &h0AB
#DEFINE GDK_KEY_notsign &h0AC
#DEFINE GDK_KEY_hyphen &h0AD
#DEFINE GDK_KEY_registered &h0AE
#DEFINE GDK_KEY_macron &h0AF
#DEFINE GDK_KEY_degree &h0B0
#DEFINE GDK_KEY_plusminus &h0B1
#DEFINE GDK_KEY_twosuperior &h0B2
#DEFINE GDK_KEY_threesuperior &h0B3
#DEFINE GDK_KEY_acute &h0B4
#DEFINE GDK_KEY_mu &h0B5
#DEFINE GDK_KEY_paragraph &h0B6
#DEFINE GDK_KEY_periodcentered &h0B7
#DEFINE GDK_KEY_cedilla &h0B8
#DEFINE GDK_KEY_onesuperior &h0B9
#DEFINE GDK_KEY_masculine &h0BA
#DEFINE GDK_KEY_guillemotright &h0BB
#DEFINE GDK_KEY_onequarter &h0BC
#DEFINE GDK_KEY_onehalf &h0BD
#DEFINE GDK_KEY_threequarters &h0BE
#DEFINE GDK_KEY_questiondown &h0BF
#DEFINE GDK_KEY_Agrave_ &h0C0
#DEFINE GDK_KEY_Aacute_ &h0C1
#DEFINE GDK_KEY_Acircumflex_ &h0C2
#DEFINE GDK_KEY_Atilde_ &h0C3
#DEFINE GDK_KEY_Adiaeresis_ &h0C4
#DEFINE GDK_KEY_Aring_ &h0C5
#DEFINE GDK_KEY_AE_ &h0C6
#DEFINE GDK_KEY_Ccedilla_ &h0C7
#DEFINE GDK_KEY_Egrave_ &h0C8
#DEFINE GDK_KEY_Eacute_ &h0C9
#DEFINE GDK_KEY_Ecircumflex_ &h0CA
#DEFINE GDK_KEY_Ediaeresis_ &h0CB
#DEFINE GDK_KEY_Igrave_ &h0CC
#DEFINE GDK_KEY_Iacute_ &h0CD
#DEFINE GDK_KEY_Icircumflex_ &h0CE
#DEFINE GDK_KEY_Idiaeresis_ &h0CF
#DEFINE GDK_KEY_ETH_2 &h0D0
#DEFINE GDK_KEY_Eth_ &h0D0
#DEFINE GDK_KEY_Ntilde_ &h0D1
#DEFINE GDK_KEY_Ograve_ &h0D2
#DEFINE GDK_KEY_Oacute_ &h0D3
#DEFINE GDK_KEY_Ocircumflex_ &h0D4
#DEFINE GDK_KEY_Otilde_ &h0D5
#DEFINE GDK_KEY_Odiaeresis_ &h0D6
#DEFINE GDK_KEY_multiply &h0D7
#DEFINE GDK_KEY_Oslash_ &h0D8
#DEFINE GDK_KEY_Ooblique_ &h0D8
#DEFINE GDK_KEY_Ugrave_ &h0D9
#DEFINE GDK_KEY_Uacute_ &h0DA
#DEFINE GDK_KEY_Ucircumflex_ &h0DB
#DEFINE GDK_KEY_Udiaeresis_ &h0DC
#DEFINE GDK_KEY_Yacute_ &h0DD
#DEFINE GDK_KEY_THORN_2 &h0DE
#DEFINE GDK_KEY_Thorn_ &h0DE
#DEFINE GDK_KEY_ssharp &h0DF
#DEFINE GDK_KEY_agrave &h0E0
#DEFINE GDK_KEY_aacute &h0E1
#DEFINE GDK_KEY_acircumflex &h0E2
#DEFINE GDK_KEY_atilde &h0E3
#DEFINE GDK_KEY_adiaeresis &h0E4
#DEFINE GDK_KEY_aring &h0E5
#DEFINE GDK_KEY_ae &h0E6
#DEFINE GDK_KEY_ccedilla &h0E7
#DEFINE GDK_KEY_egrave &h0E8
#DEFINE GDK_KEY_eacute &h0E9
#DEFINE GDK_KEY_ecircumflex &h0EA
#DEFINE GDK_KEY_ediaeresis &h0EB
#DEFINE GDK_KEY_igrave &h0EC
#DEFINE GDK_KEY_iacute &h0ED
#DEFINE GDK_KEY_icircumflex &h0EE
#DEFINE GDK_KEY_idiaeresis &h0EF
#DEFINE GDK_KEY_eth &h0F0
#DEFINE GDK_KEY_ntilde &h0F1
#DEFINE GDK_KEY_ograve &h0F2
#DEFINE GDK_KEY_oacute &h0F3
#DEFINE GDK_KEY_ocircumflex &h0F4
#DEFINE GDK_KEY_otilde &h0F5
#DEFINE GDK_KEY_odiaeresis &h0F6
#DEFINE GDK_KEY_division &h0F7
#DEFINE GDK_KEY_oslash &h0F8
#DEFINE GDK_KEY_ooblique &h0F8
#DEFINE GDK_KEY_ugrave &h0F9
#DEFINE GDK_KEY_uacute &h0FA
#DEFINE GDK_KEY_ucircumflex &h0FB
#DEFINE GDK_KEY_udiaeresis &h0FC
#DEFINE GDK_KEY_yacute &h0FD
#DEFINE GDK_KEY_thorn &h0FE
#DEFINE GDK_KEY_ydiaeresis &h0FF
#DEFINE GDK_KEY_Aogonek_ &h1A1
#DEFINE GDK_KEY_breve &h1A2
#DEFINE GDK_KEY_Lstroke_ &h1A3
#DEFINE GDK_KEY_Lcaron_ &h1A5
#DEFINE GDK_KEY_Sacute_ &h1A6
#DEFINE GDK_KEY_Scaron_ &h1A9
#DEFINE GDK_KEY_Scedilla_ &h1AA
#DEFINE GDK_KEY_Tcaron_ &h1AB
#DEFINE GDK_KEY_Zacute_ &h1AC
#DEFINE GDK_KEY_Zcaron_ &h1AE
#DEFINE GDK_KEY_Zabovedot_ &h1AF
#DEFINE GDK_KEY_aogonek &h1B1
#DEFINE GDK_KEY_ogonek &h1B2
#DEFINE GDK_KEY_lstroke &h1B3
#DEFINE GDK_KEY_lcaron &h1B5
#DEFINE GDK_KEY_sacute &h1B6
#DEFINE GDK_KEY_caron &h1B7
#DEFINE GDK_KEY_scaron &h1B9
#DEFINE GDK_KEY_scedilla &h1BA
#DEFINE GDK_KEY_tcaron &h1BB
#DEFINE GDK_KEY_zacute &h1BC
#DEFINE GDK_KEY_doubleacute &h1BD
#DEFINE GDK_KEY_zcaron &h1BE
#DEFINE GDK_KEY_zabovedot &h1BF
#DEFINE GDK_KEY_Racute_ &h1C0
#DEFINE GDK_KEY_Abreve_ &h1C3
#DEFINE GDK_KEY_Lacute_ &h1C5
#DEFINE GDK_KEY_Cacute_ &h1C6
#DEFINE GDK_KEY_Ccaron_ &h1C8
#DEFINE GDK_KEY_Eogonek_ &h1CA
#DEFINE GDK_KEY_Ecaron_ &h1CC
#DEFINE GDK_KEY_Dcaron_ &h1CF
#DEFINE GDK_KEY_Dstroke_ &h1D0
#DEFINE GDK_KEY_Nacute_ &h1D1
#DEFINE GDK_KEY_Ncaron_ &h1D2
#DEFINE GDK_KEY_Odoubleacute_ &h1D5
#DEFINE GDK_KEY_Rcaron_ &h1D8
#DEFINE GDK_KEY_Uring_ &h1D9
#DEFINE GDK_KEY_Udoubleacute_ &h1DB
#DEFINE GDK_KEY_Tcedilla_ &h1DE
#DEFINE GDK_KEY_racute &h1E0
#DEFINE GDK_KEY_abreve &h1E3
#DEFINE GDK_KEY_lacute &h1E5
#DEFINE GDK_KEY_cacute &h1E6
#DEFINE GDK_KEY_ccaron &h1E8
#DEFINE GDK_KEY_eogonek &h1EA
#DEFINE GDK_KEY_ecaron &h1EC
#DEFINE GDK_KEY_dcaron &h1EF
#DEFINE GDK_KEY_dstroke &h1F0
#DEFINE GDK_KEY_nacute &h1F1
#DEFINE GDK_KEY_ncaron &h1F2
#DEFINE GDK_KEY_odoubleacute &h1F5
#DEFINE GDK_KEY_rcaron &h1F8
#DEFINE GDK_KEY_uring &h1F9
#DEFINE GDK_KEY_udoubleacute &h1FB
#DEFINE GDK_KEY_tcedilla &h1FE
#DEFINE GDK_KEY_abovedot &h1FF
#DEFINE GDK_KEY_Hstroke_ &h2A1
#DEFINE GDK_KEY_Hcircumflex_ &h2A6
#DEFINE GDK_KEY_Iabovedot &h2A9
#DEFINE GDK_KEY_Gbreve_ &h2AB
#DEFINE GDK_KEY_Jcircumflex_ &h2AC
#DEFINE GDK_KEY_hstroke &h2B1
#DEFINE GDK_KEY_hcircumflex &h2B6
#DEFINE GDK_KEY_idotless &h2B9
#DEFINE GDK_KEY_gbreve &h2BB
#DEFINE GDK_KEY_jcircumflex &h2BC
#DEFINE GDK_KEY_Cabovedot_ &h2C5
#DEFINE GDK_KEY_Ccircumflex_ &h2C6
#DEFINE GDK_KEY_Gabovedot_ &h2D5
#DEFINE GDK_KEY_Gcircumflex_ &h2D8
#DEFINE GDK_KEY_Ubreve_ &h2DD
#DEFINE GDK_KEY_Scircumflex_ &h2DE
#DEFINE GDK_KEY_cabovedot &h2E5
#DEFINE GDK_KEY_ccircumflex &h2E6
#DEFINE GDK_KEY_gabovedot &h2F5
#DEFINE GDK_KEY_gcircumflex &h2F8
#DEFINE GDK_KEY_ubreve &h2FD
#DEFINE GDK_KEY_scircumflex &h2FE
#DEFINE GDK_KEY_kra &h3A2
#DEFINE GDK_KEY_kappa &h3A2
#DEFINE GDK_KEY_Rcedilla_ &h3A3
#DEFINE GDK_KEY_Itilde_ &h3A5
#DEFINE GDK_KEY_Lcedilla_ &h3A6
#DEFINE GDK_KEY_Emacron_ &h3AA
#DEFINE GDK_KEY_Gcedilla_ &h3AB
#DEFINE GDK_KEY_Tslash_ &h3AC
#DEFINE GDK_KEY_rcedilla &h3B3
#DEFINE GDK_KEY_itilde &h3B5
#DEFINE GDK_KEY_lcedilla &h3B6
#DEFINE GDK_KEY_emacron &h3BA
#DEFINE GDK_KEY_gcedilla &h3BB
#DEFINE GDK_KEY_tslash &h3BC
#DEFINE GDK_KEY_ENG_ &h3BD
#DEFINE GDK_KEY_eng &h3BF
#DEFINE GDK_KEY_Amacron_ &h3C0
#DEFINE GDK_KEY_Iogonek_ &h3C7
#DEFINE GDK_KEY_Eabovedot_ &h3CC
#DEFINE GDK_KEY_Imacron_ &h3CF
#DEFINE GDK_KEY_Ncedilla_ &h3D1
#DEFINE GDK_KEY_Omacron_ &h3D2
#DEFINE GDK_KEY_Kcedilla_ &h3D3
#DEFINE GDK_KEY_Uogonek_ &h3D9
#DEFINE GDK_KEY_Utilde_ &h3DD
#DEFINE GDK_KEY_Umacron_ &h3DE
#DEFINE GDK_KEY_amacron &h3E0
#DEFINE GDK_KEY_iogonek &h3E7
#DEFINE GDK_KEY_eabovedot &h3EC
#DEFINE GDK_KEY_imacron &h3EF
#DEFINE GDK_KEY_ncedilla &h3F1
#DEFINE GDK_KEY_omacron &h3F2
#DEFINE GDK_KEY_kcedilla &h3F3
#DEFINE GDK_KEY_uogonek &h3F9
#DEFINE GDK_KEY_utilde &h3FD
#DEFINE GDK_KEY_umacron &h3FE
#DEFINE GDK_KEY_Wcircumflex_ &h1000174
#DEFINE GDK_KEY_wcircumflex &h1000175
#DEFINE GDK_KEY_Ycircumflex_ &h1000176
#DEFINE GDK_KEY_ycircumflex &h1000177
#DEFINE GDK_KEY_Babovedot_ &h1001E02
#DEFINE GDK_KEY_babovedot &h1001E03
#DEFINE GDK_KEY_Dabovedot_ &h1001E0A
#DEFINE GDK_KEY_dabovedot &h1001E0B
#DEFINE GDK_KEY_Fabovedot_ &h1001E1E
#DEFINE GDK_KEY_fabovedot &h1001E1F
#DEFINE GDK_KEY_Mabovedot_ &h1001E40
#DEFINE GDK_KEY_mabovedot &h1001E41
#DEFINE GDK_KEY_Pabovedot_ &h1001E56
#DEFINE GDK_KEY_pabovedot &h1001E57
#DEFINE GDK_KEY_Sabovedot_ &h1001E60
#DEFINE GDK_KEY_sabovedot &h1001E61
#DEFINE GDK_KEY_Tabovedot_ &h1001E6A
#DEFINE GDK_KEY_tabovedot &h1001E6B
#DEFINE GDK_KEY_Wgrave_ &h1001E80
#DEFINE GDK_KEY_wgrave &h1001E81
#DEFINE GDK_KEY_Wacute_ &h1001E82
#DEFINE GDK_KEY_wacute &h1001E83
#DEFINE GDK_KEY_Wdiaeresis_ &h1001E84
#DEFINE GDK_KEY_wdiaeresis &h1001E85
#DEFINE GDK_KEY_Ygrave_ &h1001EF2
#DEFINE GDK_KEY_ygrave &h1001EF3
#DEFINE GDK_KEY_OE_ &h13BC
#DEFINE GDK_KEY_oe &h13BD
#DEFINE GDK_KEY_Ydiaeresis_ &h13BE
#DEFINE GDK_KEY_overline &h47E
#DEFINE GDK_KEY_kana_fullstop &h4A1
#DEFINE GDK_KEY_kana_openingbracket &h4A2
#DEFINE GDK_KEY_kana_closingbracket &h4A3
#DEFINE GDK_KEY_kana_comma &h4A4
#DEFINE GDK_KEY_kana_conjunctive &h4A5
#DEFINE GDK_KEY_kana_middledot &h4A5
#DEFINE GDK_KEY_kana_WO &h4A6
#DEFINE GDK_KEY_kana_a &h4A7
#DEFINE GDK_KEY_kana_i &h4A8
#DEFINE GDK_KEY_kana_u &h4A9
#DEFINE GDK_KEY_kana_e &h4AA
#DEFINE GDK_KEY_kana_o &h4AB
#DEFINE GDK_KEY_kana_ya &h4AC
#DEFINE GDK_KEY_kana_yu &h4AD
#DEFINE GDK_KEY_kana_yo &h4AE
#DEFINE GDK_KEY_kana_tsu &h4AF
#DEFINE GDK_KEY_kana_tu &h4AF
#DEFINE GDK_KEY_prolongedsound &h4B0
#DEFINE GDK_KEY_kana_A_ &h4B1
#DEFINE GDK_KEY_kana_I_ &h4B2
#DEFINE GDK_KEY_kana_U_ &h4B3
#DEFINE GDK_KEY_kana_E_ &h4B4
#DEFINE GDK_KEY_kana_O_ &h4B5
#DEFINE GDK_KEY_kana_KA &h4B6
#DEFINE GDK_KEY_kana_KI &h4B7
#DEFINE GDK_KEY_kana_KU &h4B8
#DEFINE GDK_KEY_kana_KE &h4B9
#DEFINE GDK_KEY_kana_KO &h4BA
#DEFINE GDK_KEY_kana_SA &h4BB
#DEFINE GDK_KEY_kana_SHI &h4BC
#DEFINE GDK_KEY_kana_SU &h4BD
#DEFINE GDK_KEY_kana_SE &h4BE
#DEFINE GDK_KEY_kana_SO &h4BF
#DEFINE GDK_KEY_kana_TA &h4C0
#DEFINE GDK_KEY_kana_CHI &h4C1
#DEFINE GDK_KEY_kana_TI &h4C1
#DEFINE GDK_KEY_kana_TSU_ &h4C2
#DEFINE GDK_KEY_kana_TU_ &h4C2
#DEFINE GDK_KEY_kana_TE &h4C3
#DEFINE GDK_KEY_kana_TO &h4C4
#DEFINE GDK_KEY_kana_NA &h4C5
#DEFINE GDK_KEY_kana_NI &h4C6
#DEFINE GDK_KEY_kana_NU &h4C7
#DEFINE GDK_KEY_kana_NE &h4C8
#DEFINE GDK_KEY_kana_NO &h4C9
#DEFINE GDK_KEY_kana_HA &h4CA
#DEFINE GDK_KEY_kana_HI &h4CB
#DEFINE GDK_KEY_kana_FU &h4CC
#DEFINE GDK_KEY_kana_HU &h4CC
#DEFINE GDK_KEY_kana_HE &h4CD
#DEFINE GDK_KEY_kana_HO &h4CE
#DEFINE GDK_KEY_kana_MA &h4CF
#DEFINE GDK_KEY_kana_MI &h4D0
#DEFINE GDK_KEY_kana_MU &h4D1
#DEFINE GDK_KEY_kana_ME &h4D2
#DEFINE GDK_KEY_kana_MO &h4D3
#DEFINE GDK_KEY_kana_YA_ &h4D4
#DEFINE GDK_KEY_kana_YU_ &h4D5
#DEFINE GDK_KEY_kana_YO_ &h4D6
#DEFINE GDK_KEY_kana_RA &h4D7
#DEFINE GDK_KEY_kana_RI &h4D8
#DEFINE GDK_KEY_kana_RU &h4D9
#DEFINE GDK_KEY_kana_RE &h4DA
#DEFINE GDK_KEY_kana_RO &h4DB
#DEFINE GDK_KEY_kana_WA &h4DC
#DEFINE GDK_KEY_kana_N &h4DD
#DEFINE GDK_KEY_voicedsound &h4DE
#DEFINE GDK_KEY_semivoicedsound &h4DF
#DEFINE GDK_KEY_kana_switch &hFF7E
#DEFINE GDK_KEY_Farsi_0 &h10006F0
#DEFINE GDK_KEY_Farsi_1 &h10006F1
#DEFINE GDK_KEY_Farsi_2 &h10006F2
#DEFINE GDK_KEY_Farsi_3 &h10006F3
#DEFINE GDK_KEY_Farsi_4 &h10006F4
#DEFINE GDK_KEY_Farsi_5 &h10006F5
#DEFINE GDK_KEY_Farsi_6 &h10006F6
#DEFINE GDK_KEY_Farsi_7 &h10006F7
#DEFINE GDK_KEY_Farsi_8 &h10006F8
#DEFINE GDK_KEY_Farsi_9 &h10006F9
#DEFINE GDK_KEY_Arabic_percent &h100066A
#DEFINE GDK_KEY_Arabic_superscript_alef &h1000670
#DEFINE GDK_KEY_Arabic_tteh &h1000679
#DEFINE GDK_KEY_Arabic_peh &h100067E
#DEFINE GDK_KEY_Arabic_tcheh &h1000686
#DEFINE GDK_KEY_Arabic_ddal &h1000688
#DEFINE GDK_KEY_Arabic_rreh &h1000691
#DEFINE GDK_KEY_Arabic_comma &h5AC
#DEFINE GDK_KEY_Arabic_fullstop &h10006D4
#DEFINE GDK_KEY_Arabic_0 &h1000660
#DEFINE GDK_KEY_Arabic_1 &h1000661
#DEFINE GDK_KEY_Arabic_2 &h1000662
#DEFINE GDK_KEY_Arabic_3 &h1000663
#DEFINE GDK_KEY_Arabic_4 &h1000664
#DEFINE GDK_KEY_Arabic_5 &h1000665
#DEFINE GDK_KEY_Arabic_6 &h1000666
#DEFINE GDK_KEY_Arabic_7 &h1000667
#DEFINE GDK_KEY_Arabic_8 &h1000668
#DEFINE GDK_KEY_Arabic_9 &h1000669
#DEFINE GDK_KEY_Arabic_semicolon &h5BB
#DEFINE GDK_KEY_Arabic_question_mark &h5BF
#DEFINE GDK_KEY_Arabic_hamza &h5C1
#DEFINE GDK_KEY_Arabic_maddaonalef &h5C2
#DEFINE GDK_KEY_Arabic_hamzaonalef &h5C3
#DEFINE GDK_KEY_Arabic_hamzaonwaw &h5C4
#DEFINE GDK_KEY_Arabic_hamzaunderalef &h5C5
#DEFINE GDK_KEY_Arabic_hamzaonyeh &h5C6
#DEFINE GDK_KEY_Arabic_alef &h5C7
#DEFINE GDK_KEY_Arabic_beh &h5C8
#DEFINE GDK_KEY_Arabic_tehmarbuta &h5C9
#DEFINE GDK_KEY_Arabic_teh &h5CA
#DEFINE GDK_KEY_Arabic_theh &h5CB
#DEFINE GDK_KEY_Arabic_jeem &h5CC
#DEFINE GDK_KEY_Arabic_hah &h5CD
#DEFINE GDK_KEY_Arabic_khah &h5CE
#DEFINE GDK_KEY_Arabic_dal &h5CF
#DEFINE GDK_KEY_Arabic_thal &h5D0
#DEFINE GDK_KEY_Arabic_ra &h5D1
#DEFINE GDK_KEY_Arabic_zain &h5D2
#DEFINE GDK_KEY_Arabic_seen &h5D3
#DEFINE GDK_KEY_Arabic_sheen &h5D4
#DEFINE GDK_KEY_Arabic_sad &h5D5
#DEFINE GDK_KEY_Arabic_dad &h5D6
#DEFINE GDK_KEY_Arabic_tah &h5D7
#DEFINE GDK_KEY_Arabic_zah &h5D8
#DEFINE GDK_KEY_Arabic_ain &h5D9
#DEFINE GDK_KEY_Arabic_ghain &h5DA
#DEFINE GDK_KEY_Arabic_tatweel &h5E0
#DEFINE GDK_KEY_Arabic_feh &h5E1
#DEFINE GDK_KEY_Arabic_qaf &h5E2
#DEFINE GDK_KEY_Arabic_kaf &h5E3
#DEFINE GDK_KEY_Arabic_lam &h5E4
#DEFINE GDK_KEY_Arabic_meem &h5E5
#DEFINE GDK_KEY_Arabic_noon &h5E6
#DEFINE GDK_KEY_Arabic_ha &h5E7
#DEFINE GDK_KEY_Arabic_heh &h5E7
#DEFINE GDK_KEY_Arabic_waw &h5E8
#DEFINE GDK_KEY_Arabic_alefmaksura &h5E9
#DEFINE GDK_KEY_Arabic_yeh &h5EA
#DEFINE GDK_KEY_Arabic_fathatan &h5EB
#DEFINE GDK_KEY_Arabic_dammatan &h5EC
#DEFINE GDK_KEY_Arabic_kasratan &h5ED
#DEFINE GDK_KEY_Arabic_fatha &h5EE
#DEFINE GDK_KEY_Arabic_damma &h5EF
#DEFINE GDK_KEY_Arabic_kasra &h5F0
#DEFINE GDK_KEY_Arabic_shadda &h5F1
#DEFINE GDK_KEY_Arabic_sukun &h5F2
#DEFINE GDK_KEY_Arabic_madda_above &h1000653
#DEFINE GDK_KEY_Arabic_hamza_above &h1000654
#DEFINE GDK_KEY_Arabic_hamza_below &h1000655
#DEFINE GDK_KEY_Arabic_jeh &h1000698
#DEFINE GDK_KEY_Arabic_veh &h10006A4
#DEFINE GDK_KEY_Arabic_keheh &h10006A9
#DEFINE GDK_KEY_Arabic_gaf &h10006AF
#DEFINE GDK_KEY_Arabic_noon_ghunna &h10006BA
#DEFINE GDK_KEY_Arabic_heh_doachashmee &h10006BE
#DEFINE GDK_KEY_Farsi_yeh &h10006CC
#DEFINE GDK_KEY_Arabic_farsi_yeh &h10006CC
#DEFINE GDK_KEY_Arabic_yeh_baree &h10006D2
#DEFINE GDK_KEY_Arabic_heh_goal &h10006C1
#DEFINE GDK_KEY_Arabic_switch &hFF7E
#DEFINE GDK_KEY_Cyrillic_GHE_bar_ &h1000492
#DEFINE GDK_KEY_Cyrillic_ghe_bar &h1000493
#DEFINE GDK_KEY_Cyrillic_ZHE_descender_ &h1000496
#DEFINE GDK_KEY_Cyrillic_zhe_descender &h1000497
#DEFINE GDK_KEY_Cyrillic_KA_descender_ &h100049A
#DEFINE GDK_KEY_Cyrillic_ka_descender &h100049B
#DEFINE GDK_KEY_Cyrillic_KA_vertstroke_ &h100049C
#DEFINE GDK_KEY_Cyrillic_ka_vertstroke &h100049D
#DEFINE GDK_KEY_Cyrillic_EN_descender_ &h10004A2
#DEFINE GDK_KEY_Cyrillic_en_descender &h10004A3
#DEFINE GDK_KEY_Cyrillic_U_straight_ &h10004AE
#DEFINE GDK_KEY_Cyrillic_u_straight &h10004AF
#DEFINE GDK_KEY_Cyrillic_U_straight_bar_ &h10004B0
#DEFINE GDK_KEY_Cyrillic_u_straight_bar &h10004B1
#DEFINE GDK_KEY_Cyrillic_HA_descender_ &h10004B2
#DEFINE GDK_KEY_Cyrillic_ha_descender &h10004B3
#DEFINE GDK_KEY_Cyrillic_CHE_descender_ &h10004B6
#DEFINE GDK_KEY_Cyrillic_che_descender &h10004B7
#DEFINE GDK_KEY_Cyrillic_CHE_vertstroke_ &h10004B8
#DEFINE GDK_KEY_Cyrillic_che_vertstroke &h10004B9
#DEFINE GDK_KEY_Cyrillic_SHHA_ &h10004BA
#DEFINE GDK_KEY_Cyrillic_shha &h10004BB
#DEFINE GDK_KEY_Cyrillic_SCHWA_ &h10004D8
#DEFINE GDK_KEY_Cyrillic_schwa &h10004D9
#DEFINE GDK_KEY_Cyrillic_I_macron_ &h10004E2
#DEFINE GDK_KEY_Cyrillic_i_macron &h10004E3
#DEFINE GDK_KEY_Cyrillic_O_bar_ &h10004E8
#DEFINE GDK_KEY_Cyrillic_o_bar &h10004E9
#DEFINE GDK_KEY_Cyrillic_U_macron_ &h10004EE
#DEFINE GDK_KEY_Cyrillic_u_macron &h10004EF
#DEFINE GDK_KEY_Serbian_dje &h6A1
#DEFINE GDK_KEY_Macedonia_gje &h6A2
#DEFINE GDK_KEY_Cyrillic_io &h6A3
#DEFINE GDK_KEY_Ukrainian_ie &h6A4
#DEFINE GDK_KEY_Ukranian_je &h6A4
#DEFINE GDK_KEY_Macedonia_dse &h6A5
#DEFINE GDK_KEY_Ukrainian_i &h6A6
#DEFINE GDK_KEY_Ukranian_i &h6A6
#DEFINE GDK_KEY_Ukrainian_yi &h6A7
#DEFINE GDK_KEY_Ukranian_yi &h6A7
#DEFINE GDK_KEY_Cyrillic_je &h6A8
#DEFINE GDK_KEY_Serbian_je &h6A8
#DEFINE GDK_KEY_Cyrillic_lje &h6A9
#DEFINE GDK_KEY_Serbian_lje &h6A9
#DEFINE GDK_KEY_Cyrillic_nje &h6AA
#DEFINE GDK_KEY_Serbian_nje &h6AA
#DEFINE GDK_KEY_Serbian_tshe &h6AB
#DEFINE GDK_KEY_Macedonia_kje &h6AC
#DEFINE GDK_KEY_Ukrainian_ghe_with_upturn &h6AD
#DEFINE GDK_KEY_Byelorussian_shortu &h6AE
#DEFINE GDK_KEY_Cyrillic_dzhe &h6AF
#DEFINE GDK_KEY_Serbian_dze &h6AF
#DEFINE GDK_KEY_numerosign &h6B0
#DEFINE GDK_KEY_Serbian_DJE_ &h6B1
#DEFINE GDK_KEY_Macedonia_GJE_ &h6B2
#DEFINE GDK_KEY_Cyrillic_IO_ &h6B3
#DEFINE GDK_KEY_Ukrainian_IE_ &h6B4
#DEFINE GDK_KEY_Ukranian_JE_ &h6B4
#DEFINE GDK_KEY_Macedonia_DSE_ &h6B5
#DEFINE GDK_KEY_Ukrainian_I_ &h6B6
#DEFINE GDK_KEY_Ukranian_I_ &h6B6
#DEFINE GDK_KEY_Ukrainian_YI_ &h6B7
#DEFINE GDK_KEY_Ukranian_YI_ &h6B7
#DEFINE GDK_KEY_Cyrillic_JE_ &h6B8
#DEFINE GDK_KEY_Serbian_JE_ &h6B8
#DEFINE GDK_KEY_Cyrillic_LJE_ &h6B9
#DEFINE GDK_KEY_Serbian_LJE_ &h6B9
#DEFINE GDK_KEY_Cyrillic_NJE_ &h6BA
#DEFINE GDK_KEY_Serbian_NJE_ &h6BA
#DEFINE GDK_KEY_Serbian_TSHE_ &h6BB
#DEFINE GDK_KEY_Macedonia_KJE_ &h6BC
#DEFINE GDK_KEY_Ukrainian_GHE_WITH_UPTURN_ &h6BD
#DEFINE GDK_KEY_Byelorussian_SHORTU_ &h6BE
#DEFINE GDK_KEY_Cyrillic_DZHE_ &h6BF
#DEFINE GDK_KEY_Serbian_DZE_ &h6BF
#DEFINE GDK_KEY_Cyrillic_yu &h6C0
#DEFINE GDK_KEY_Cyrillic_a &h6C1
#DEFINE GDK_KEY_Cyrillic_be &h6C2
#DEFINE GDK_KEY_Cyrillic_tse &h6C3
#DEFINE GDK_KEY_Cyrillic_de &h6C4
#DEFINE GDK_KEY_Cyrillic_ie &h6C5
#DEFINE GDK_KEY_Cyrillic_ef &h6C6
#DEFINE GDK_KEY_Cyrillic_ghe &h6C7
#DEFINE GDK_KEY_Cyrillic_ha &h6C8
#DEFINE GDK_KEY_Cyrillic_i &h6C9
#DEFINE GDK_KEY_Cyrillic_shorti &h6CA
#DEFINE GDK_KEY_Cyrillic_ka &h6CB
#DEFINE GDK_KEY_Cyrillic_el &h6CC
#DEFINE GDK_KEY_Cyrillic_em &h6CD
#DEFINE GDK_KEY_Cyrillic_en &h6CE
#DEFINE GDK_KEY_Cyrillic_o &h6CF
#DEFINE GDK_KEY_Cyrillic_pe &h6D0
#DEFINE GDK_KEY_Cyrillic_ya &h6D1
#DEFINE GDK_KEY_Cyrillic_er &h6D2
#DEFINE GDK_KEY_Cyrillic_es &h6D3
#DEFINE GDK_KEY_Cyrillic_te &h6D4
#DEFINE GDK_KEY_Cyrillic_u &h6D5
#DEFINE GDK_KEY_Cyrillic_zhe &h6D6
#DEFINE GDK_KEY_Cyrillic_ve &h6D7
#DEFINE GDK_KEY_Cyrillic_softsign &h6D8
#DEFINE GDK_KEY_Cyrillic_yeru &h6D9
#DEFINE GDK_KEY_Cyrillic_ze &h6DA
#DEFINE GDK_KEY_Cyrillic_sha &h6DB
#DEFINE GDK_KEY_Cyrillic_e &h6DC
#DEFINE GDK_KEY_Cyrillic_shcha &h6DD
#DEFINE GDK_KEY_Cyrillic_che &h6DE
#DEFINE GDK_KEY_Cyrillic_hardsign &h6DF
#DEFINE GDK_KEY_Cyrillic_YU_ &h6E0
#DEFINE GDK_KEY_Cyrillic_A_ &h6E1
#DEFINE GDK_KEY_Cyrillic_BE_ &h6E2
#DEFINE GDK_KEY_Cyrillic_TSE_ &h6E3
#DEFINE GDK_KEY_Cyrillic_DE_ &h6E4
#DEFINE GDK_KEY_Cyrillic_IE_ &h6E5
#DEFINE GDK_KEY_Cyrillic_EF_ &h6E6
#DEFINE GDK_KEY_Cyrillic_GHE_ &h6E7
#DEFINE GDK_KEY_Cyrillic_HA_ &h6E8
#DEFINE GDK_KEY_Cyrillic_I_ &h6E9
#DEFINE GDK_KEY_Cyrillic_SHORTI_ &h6EA
#DEFINE GDK_KEY_Cyrillic_KA_ &h6EB
#DEFINE GDK_KEY_Cyrillic_EL_ &h6EC
#DEFINE GDK_KEY_Cyrillic_EM_ &h6ED
#DEFINE GDK_KEY_Cyrillic_EN_ &h6EE
#DEFINE GDK_KEY_Cyrillic_O_ &h6EF
#DEFINE GDK_KEY_Cyrillic_PE_ &h6F0
#DEFINE GDK_KEY_Cyrillic_YA_ &h6F1
#DEFINE GDK_KEY_Cyrillic_ER_ &h6F2
#DEFINE GDK_KEY_Cyrillic_ES_ &h6F3
#DEFINE GDK_KEY_Cyrillic_TE_ &h6F4
#DEFINE GDK_KEY_Cyrillic_U_ &h6F5
#DEFINE GDK_KEY_Cyrillic_ZHE_ &h6F6
#DEFINE GDK_KEY_Cyrillic_VE_ &h6F7
#DEFINE GDK_KEY_Cyrillic_SOFTSIGN_ &h6F8
#DEFINE GDK_KEY_Cyrillic_YERU_ &h6F9
#DEFINE GDK_KEY_Cyrillic_ZE_ &h6FA
#DEFINE GDK_KEY_Cyrillic_SHA_ &h6FB
#DEFINE GDK_KEY_Cyrillic_E_ &h6FC
#DEFINE GDK_KEY_Cyrillic_SHCHA_ &h6FD
#DEFINE GDK_KEY_Cyrillic_CHE_ &h6FE
#DEFINE GDK_KEY_Cyrillic_HARDSIGN_ &h6FF
#DEFINE GDK_KEY_Greek_ALPHAaccent_ &h7A1
#DEFINE GDK_KEY_Greek_EPSILONaccent_ &h7A2
#DEFINE GDK_KEY_Greek_ETAaccent_ &h7A3
#DEFINE GDK_KEY_Greek_IOTAaccent_ &h7A4
#DEFINE GDK_KEY_Greek_IOTAdieresis_ &h7A5
#DEFINE GDK_KEY_Greek_IOTAdiaeresis &h7A5
#DEFINE GDK_KEY_Greek_OMICRONaccent_ &h7A7
#DEFINE GDK_KEY_Greek_UPSILONaccent_ &h7A8
#DEFINE GDK_KEY_Greek_UPSILONdieresis_ &h7A9
#DEFINE GDK_KEY_Greek_OMEGAaccent_ &h7AB
#DEFINE GDK_KEY_Greek_accentdieresis &h7AE
#DEFINE GDK_KEY_Greek_horizbar &h7AF
#DEFINE GDK_KEY_Greek_alphaaccent &h7B1
#DEFINE GDK_KEY_Greek_epsilonaccent &h7B2
#DEFINE GDK_KEY_Greek_etaaccent &h7B3
#DEFINE GDK_KEY_Greek_iotaaccent &h7B4
#DEFINE GDK_KEY_Greek_iotadieresis &h7B5
#DEFINE GDK_KEY_Greek_iotaaccentdieresis &h7B6
#DEFINE GDK_KEY_Greek_omicronaccent &h7B7
#DEFINE GDK_KEY_Greek_upsilonaccent &h7B8
#DEFINE GDK_KEY_Greek_upsilondieresis &h7B9
#DEFINE GDK_KEY_Greek_upsilonaccentdieresis &h7BA
#DEFINE GDK_KEY_Greek_omegaaccent &h7BB
#DEFINE GDK_KEY_Greek_ALPHA_ &h7C1
#DEFINE GDK_KEY_Greek_BETA_ &h7C2
#DEFINE GDK_KEY_Greek_GAMMA_ &h7C3
#DEFINE GDK_KEY_Greek_DELTA_ &h7C4
#DEFINE GDK_KEY_Greek_EPSILON_ &h7C5
#DEFINE GDK_KEY_Greek_ZETA_ &h7C6
#DEFINE GDK_KEY_Greek_ETA_ &h7C7
#DEFINE GDK_KEY_Greek_THETA_ &h7C8
#DEFINE GDK_KEY_Greek_IOTA_ &h7C9
#DEFINE GDK_KEY_Greek_KAPPA_ &h7CA
#DEFINE GDK_KEY_Greek_LAMDA_ &h7CB
#DEFINE GDK_KEY_Greek_LAMBDA_ &h7CB
#DEFINE GDK_KEY_Greek_MU_ &h7CC
#DEFINE GDK_KEY_Greek_NU_ &h7CD
#DEFINE GDK_KEY_Greek_XI_ &h7CE
#DEFINE GDK_KEY_Greek_OMICRON_ &h7CF
#DEFINE GDK_KEY_Greek_PI_ &h7D0
#DEFINE GDK_KEY_Greek_RHO_ &h7D1
#DEFINE GDK_KEY_Greek_SIGMA_ &h7D2
#DEFINE GDK_KEY_Greek_TAU_ &h7D4
#DEFINE GDK_KEY_Greek_UPSILON_ &h7D5
#DEFINE GDK_KEY_Greek_PHI_ &h7D6
#DEFINE GDK_KEY_Greek_CHI_ &h7D7
#DEFINE GDK_KEY_Greek_PSI_ &h7D8
#DEFINE GDK_KEY_Greek_OMEGA_ &h7D9
#DEFINE GDK_KEY_Greek_alpha &h7E1
#DEFINE GDK_KEY_Greek_beta &h7E2
#DEFINE GDK_KEY_Greek_gamma &h7E3
#DEFINE GDK_KEY_Greek_delta &h7E4
#DEFINE GDK_KEY_Greek_epsilon &h7E5
#DEFINE GDK_KEY_Greek_zeta &h7E6
#DEFINE GDK_KEY_Greek_eta &h7E7
#DEFINE GDK_KEY_Greek_theta &h7E8
#DEFINE GDK_KEY_Greek_iota &h7E9
#DEFINE GDK_KEY_Greek_kappa &h7EA
#DEFINE GDK_KEY_Greek_lamda &h7EB
#DEFINE GDK_KEY_Greek_lambda &h7EB
#DEFINE GDK_KEY_Greek_mu &h7EC
#DEFINE GDK_KEY_Greek_nu &h7ED
#DEFINE GDK_KEY_Greek_xi &h7EE
#DEFINE GDK_KEY_Greek_omicron &h7EF
#DEFINE GDK_KEY_Greek_pi &h7F0
#DEFINE GDK_KEY_Greek_rho &h7F1
#DEFINE GDK_KEY_Greek_sigma &h7F2
#DEFINE GDK_KEY_Greek_finalsmallsigma &h7F3
#DEFINE GDK_KEY_Greek_tau &h7F4
#DEFINE GDK_KEY_Greek_upsilon &h7F5
#DEFINE GDK_KEY_Greek_phi &h7F6
#DEFINE GDK_KEY_Greek_chi &h7F7
#DEFINE GDK_KEY_Greek_psi &h7F8
#DEFINE GDK_KEY_Greek_omega &h7F9
#DEFINE GDK_KEY_Greek_switch &hFF7E
#DEFINE GDK_KEY_leftradical &h8A1
#DEFINE GDK_KEY_topleftradical &h8A2
#DEFINE GDK_KEY_horizconnector &h8A3
#DEFINE GDK_KEY_topintegral &h8A4
#DEFINE GDK_KEY_botintegral &h8A5
#DEFINE GDK_KEY_vertconnector &h8A6
#DEFINE GDK_KEY_topleftsqbracket &h8A7
#DEFINE GDK_KEY_botleftsqbracket &h8A8
#DEFINE GDK_KEY_toprightsqbracket &h8A9
#DEFINE GDK_KEY_botrightsqbracket &h8AA
#DEFINE GDK_KEY_topleftparens &h8AB
#DEFINE GDK_KEY_botleftparens &h8AC
#DEFINE GDK_KEY_toprightparens &h8AD
#DEFINE GDK_KEY_botrightparens &h8AE
#DEFINE GDK_KEY_leftmiddlecurlybrace &h8AF
#DEFINE GDK_KEY_rightmiddlecurlybrace &h8B0
#DEFINE GDK_KEY_topleftsummation &h8B1
#DEFINE GDK_KEY_botleftsummation &h8B2
#DEFINE GDK_KEY_topvertsummationconnector &h8B3
#DEFINE GDK_KEY_botvertsummationconnector &h8B4
#DEFINE GDK_KEY_toprightsummation &h8B5
#DEFINE GDK_KEY_botrightsummation &h8B6
#DEFINE GDK_KEY_rightmiddlesummation &h8B7
#DEFINE GDK_KEY_lessthanequal &h8BC
#DEFINE GDK_KEY_notequal &h8BD
#DEFINE GDK_KEY_greaterthanequal &h8BE
#DEFINE GDK_KEY_integral &h8BF
#DEFINE GDK_KEY_therefore &h8C0
#DEFINE GDK_KEY_variation &h8C1
#DEFINE GDK_KEY_infinity &h8C2
#DEFINE GDK_KEY_nabla &h8C5
#DEFINE GDK_KEY_approximate &h8C8
#DEFINE GDK_KEY_similarequal &h8C9
#DEFINE GDK_KEY_ifonlyif &h8CD
#DEFINE GDK_KEY_implies &h8CE
#DEFINE GDK_KEY_identical &h8CF
#DEFINE GDK_KEY_radical &h8D6
#DEFINE GDK_KEY_includedin &h8DA
#DEFINE GDK_KEY_includes &h8DB
#DEFINE GDK_KEY_intersection &h8DC
#DEFINE GDK_KEY_union &h8DD
#DEFINE GDK_KEY_logicaland &h8DE
#DEFINE GDK_KEY_logicalor &h8DF
#DEFINE GDK_KEY_partialderivative &h8EF
#DEFINE GDK_KEY_function &h8F6
#DEFINE GDK_KEY_leftarrow &h8FB
#DEFINE GDK_KEY_uparrow &h8FC
#DEFINE GDK_KEY_rightarrow &h8FD
#DEFINE GDK_KEY_downarrow &h8FE
#DEFINE GDK_KEY_blank &h9DF
#DEFINE GDK_KEY_soliddiamond &h9E0
#DEFINE GDK_KEY_checkerboard &h9E1
#DEFINE GDK_KEY_ht &h9E2
#DEFINE GDK_KEY_ff &h9E3
#DEFINE GDK_KEY_cr &h9E4
#DEFINE GDK_KEY_lf &h9E5
#DEFINE GDK_KEY_nl &h9E8
#DEFINE GDK_KEY_vt &h9E9
#DEFINE GDK_KEY_lowrightcorner &h9EA
#DEFINE GDK_KEY_uprightcorner &h9EB
#DEFINE GDK_KEY_upleftcorner &h9EC
#DEFINE GDK_KEY_lowleftcorner &h9ED
#DEFINE GDK_KEY_crossinglines &h9EE
#DEFINE GDK_KEY_horizlinescan1 &h9EF
#DEFINE GDK_KEY_horizlinescan3 &h9F0
#DEFINE GDK_KEY_horizlinescan5 &h9F1
#DEFINE GDK_KEY_horizlinescan7 &h9F2
#DEFINE GDK_KEY_horizlinescan9 &h9F3
#DEFINE GDK_KEY_leftt &h9F4
#DEFINE GDK_KEY_rightt &h9F5
#DEFINE GDK_KEY_bott &h9F6
#DEFINE GDK_KEY_topt &h9F7
#DEFINE GDK_KEY_vertbar &h9F8
#DEFINE GDK_KEY_emspace &hAA1
#DEFINE GDK_KEY_enspace &hAA2
#DEFINE GDK_KEY_em3space &hAA3
#DEFINE GDK_KEY_em4space &hAA4
#DEFINE GDK_KEY_digitspace &hAA5
#DEFINE GDK_KEY_punctspace &hAA6
#DEFINE GDK_KEY_thinspace &hAA7
#DEFINE GDK_KEY_hairspace &hAA8
#DEFINE GDK_KEY_emdash &hAA9
#DEFINE GDK_KEY_endash &hAAA
#DEFINE GDK_KEY_signifblank &hAAC
#DEFINE GDK_KEY_ellipsis &hAAE
#DEFINE GDK_KEY_doubbaselinedot &hAAF
#DEFINE GDK_KEY_onethird &hAB0
#DEFINE GDK_KEY_twothirds &hAB1
#DEFINE GDK_KEY_onefifth &hAB2
#DEFINE GDK_KEY_twofifths &hAB3
#DEFINE GDK_KEY_threefifths &hAB4
#DEFINE GDK_KEY_fourfifths &hAB5
#DEFINE GDK_KEY_onesixth &hAB6
#DEFINE GDK_KEY_fivesixths &hAB7
#DEFINE GDK_KEY_careof &hAB8
#DEFINE GDK_KEY_figdash &hABB
#DEFINE GDK_KEY_leftanglebracket &hABC
#DEFINE GDK_KEY_decimalpoint &hABD
#DEFINE GDK_KEY_rightanglebracket &hABE
#DEFINE GDK_KEY_marker &hABF
#DEFINE GDK_KEY_oneeighth &hAC3
#DEFINE GDK_KEY_threeeighths &hAC4
#DEFINE GDK_KEY_fiveeighths &hAC5
#DEFINE GDK_KEY_seveneighths &hAC6
#DEFINE GDK_KEY_trademark &hAC9
#DEFINE GDK_KEY_signaturemark &hACA
#DEFINE GDK_KEY_trademarkincircle &hACB
#DEFINE GDK_KEY_leftopentriangle &hACC
#DEFINE GDK_KEY_rightopentriangle &hACD
#DEFINE GDK_KEY_emopencircle &hACE
#DEFINE GDK_KEY_emopenrectangle &hACF
#DEFINE GDK_KEY_leftsinglequotemark &hAD0
#DEFINE GDK_KEY_rightsinglequotemark &hAD1
#DEFINE GDK_KEY_leftdoublequotemark &hAD2
#DEFINE GDK_KEY_rightdoublequotemark &hAD3
#DEFINE GDK_KEY_prescription &hAD4
#DEFINE GDK_KEY_permille &hAD5
#DEFINE GDK_KEY_minutes &hAD6
#DEFINE GDK_KEY_seconds &hAD7
#DEFINE GDK_KEY_latincross &hAD9
#DEFINE GDK_KEY_hexagram &hADA
#DEFINE GDK_KEY_filledrectbullet &hADB
#DEFINE GDK_KEY_filledlefttribullet &hADC
#DEFINE GDK_KEY_filledrighttribullet &hADD
#DEFINE GDK_KEY_emfilledcircle &hADE
#DEFINE GDK_KEY_emfilledrect &hADF
#DEFINE GDK_KEY_enopencircbullet &hAE0
#DEFINE GDK_KEY_enopensquarebullet &hAE1
#DEFINE GDK_KEY_openrectbullet &hAE2
#DEFINE GDK_KEY_opentribulletup &hAE3
#DEFINE GDK_KEY_opentribulletdown &hAE4
#DEFINE GDK_KEY_openstar &hAE5
#DEFINE GDK_KEY_enfilledcircbullet &hAE6
#DEFINE GDK_KEY_enfilledsqbullet &hAE7
#DEFINE GDK_KEY_filledtribulletup &hAE8
#DEFINE GDK_KEY_filledtribulletdown &hAE9
#DEFINE GDK_KEY_leftpointer &hAEA
#DEFINE GDK_KEY_rightpointer &hAEB
#DEFINE GDK_KEY_club &hAEC
#DEFINE GDK_KEY_diamond &hAED
#DEFINE GDK_KEY_heart &hAEE
#DEFINE GDK_KEY_maltesecross &hAF0
#DEFINE GDK_KEY_dagger &hAF1
#DEFINE GDK_KEY_doubledagger &hAF2
#DEFINE GDK_KEY_checkmark &hAF3
#DEFINE GDK_KEY_ballotcross &hAF4
#DEFINE GDK_KEY_musicalsharp &hAF5
#DEFINE GDK_KEY_musicalflat &hAF6
#DEFINE GDK_KEY_malesymbol &hAF7
#DEFINE GDK_KEY_femalesymbol &hAF8
#DEFINE GDK_KEY_telephone &hAF9
#DEFINE GDK_KEY_telephonerecorder &hAFA
#DEFINE GDK_KEY_phonographcopyright &hAFB
#DEFINE GDK_KEY_caret &hAFC
#DEFINE GDK_KEY_singlelowquotemark &hAFD
#DEFINE GDK_KEY_doublelowquotemark &hAFE
#DEFINE GDK_KEY_cursor &hAFF
#DEFINE GDK_KEY_leftcaret &hBA3
#DEFINE GDK_KEY_rightcaret &hBA6
#DEFINE GDK_KEY_downcaret &hBA8
#DEFINE GDK_KEY_upcaret &hBA9
#DEFINE GDK_KEY_overbar &hBC0
#DEFINE GDK_KEY_downtack &hBC2
#DEFINE GDK_KEY_upshoe &hBC3
#DEFINE GDK_KEY_downstile &hBC4
#DEFINE GDK_KEY_underbar &hBC6
#DEFINE GDK_KEY_jot &hBCA
#DEFINE GDK_KEY_quad &hBCC
#DEFINE GDK_KEY_uptack &hBCE
#DEFINE GDK_KEY_circle &hBCF
#DEFINE GDK_KEY_upstile &hBD3
#DEFINE GDK_KEY_downshoe &hBD6
#DEFINE GDK_KEY_rightshoe &hBD8
#DEFINE GDK_KEY_leftshoe &hBDA
#DEFINE GDK_KEY_lefttack &hBDC
#DEFINE GDK_KEY_righttack &hBFC
#DEFINE GDK_KEY_hebrew_doublelowline &hCDF
#DEFINE GDK_KEY_hebrew_aleph &hCE0
#DEFINE GDK_KEY_hebrew_bet &hCE1
#DEFINE GDK_KEY_hebrew_beth &hCE1
#DEFINE GDK_KEY_hebrew_gimel &hCE2
#DEFINE GDK_KEY_hebrew_gimmel &hCE2
#DEFINE GDK_KEY_hebrew_dalet &hCE3
#DEFINE GDK_KEY_hebrew_daleth &hCE3
#DEFINE GDK_KEY_hebrew_he &hCE4
#DEFINE GDK_KEY_hebrew_waw &hCE5
#DEFINE GDK_KEY_hebrew_zain &hCE6
#DEFINE GDK_KEY_hebrew_zayin &hCE6
#DEFINE GDK_KEY_hebrew_chet &hCE7
#DEFINE GDK_KEY_hebrew_het &hCE7
#DEFINE GDK_KEY_hebrew_tet &hCE8
#DEFINE GDK_KEY_hebrew_teth &hCE8
#DEFINE GDK_KEY_hebrew_yod &hCE9
#DEFINE GDK_KEY_hebrew_finalkaph &hCEA
#DEFINE GDK_KEY_hebrew_kaph &hCEB
#DEFINE GDK_KEY_hebrew_lamed &hCEC
#DEFINE GDK_KEY_hebrew_finalmem &hCED
#DEFINE GDK_KEY_hebrew_mem &hCEE
#DEFINE GDK_KEY_hebrew_finalnun &hCEF
#DEFINE GDK_KEY_hebrew_nun &hCF0
#DEFINE GDK_KEY_hebrew_samech &hCF1
#DEFINE GDK_KEY_hebrew_samekh &hCF1
#DEFINE GDK_KEY_hebrew_ayin &hCF2
#DEFINE GDK_KEY_hebrew_finalpe &hCF3
#DEFINE GDK_KEY_hebrew_pe &hCF4
#DEFINE GDK_KEY_hebrew_finalzade &hCF5
#DEFINE GDK_KEY_hebrew_finalzadi &hCF5
#DEFINE GDK_KEY_hebrew_zade &hCF6
#DEFINE GDK_KEY_hebrew_zadi &hCF6
#DEFINE GDK_KEY_hebrew_qoph &hCF7
#DEFINE GDK_KEY_hebrew_kuf &hCF7
#DEFINE GDK_KEY_hebrew_resh &hCF8
#DEFINE GDK_KEY_hebrew_shin &hCF9
#DEFINE GDK_KEY_hebrew_taw &hCFA
#DEFINE GDK_KEY_hebrew_taf &hCFA
#DEFINE GDK_KEY_Hebrew_switch &hFF7E
#DEFINE GDK_KEY_Thai_kokai &hDA1
#DEFINE GDK_KEY_Thai_khokhai &hDA2
#DEFINE GDK_KEY_Thai_khokhuat &hDA3
#DEFINE GDK_KEY_Thai_khokhwai &hDA4
#DEFINE GDK_KEY_Thai_khokhon &hDA5
#DEFINE GDK_KEY_Thai_khorakhang &hDA6
#DEFINE GDK_KEY_Thai_ngongu &hDA7
#DEFINE GDK_KEY_Thai_chochan &hDA8
#DEFINE GDK_KEY_Thai_choching &hDA9
#DEFINE GDK_KEY_Thai_chochang &hDAA
#DEFINE GDK_KEY_Thai_soso &hDAB
#DEFINE GDK_KEY_Thai_chochoe &hDAC
#DEFINE GDK_KEY_Thai_yoying &hDAD
#DEFINE GDK_KEY_Thai_dochada &hDAE
#DEFINE GDK_KEY_Thai_topatak &hDAF
#DEFINE GDK_KEY_Thai_thothan &hDB0
#DEFINE GDK_KEY_Thai_thonangmontho &hDB1
#DEFINE GDK_KEY_Thai_thophuthao &hDB2
#DEFINE GDK_KEY_Thai_nonen &hDB3
#DEFINE GDK_KEY_Thai_dodek &hDB4
#DEFINE GDK_KEY_Thai_totao &hDB5
#DEFINE GDK_KEY_Thai_thothung &hDB6
#DEFINE GDK_KEY_Thai_thothahan &hDB7
#DEFINE GDK_KEY_Thai_thothong &hDB8
#DEFINE GDK_KEY_Thai_nonu &hDB9
#DEFINE GDK_KEY_Thai_bobaimai &hDBA
#DEFINE GDK_KEY_Thai_popla &hDBB
#DEFINE GDK_KEY_Thai_phophung &hDBC
#DEFINE GDK_KEY_Thai_fofa &hDBD
#DEFINE GDK_KEY_Thai_phophan &hDBE
#DEFINE GDK_KEY_Thai_fofan &hDBF
#DEFINE GDK_KEY_Thai_phosamphao &hDC0
#DEFINE GDK_KEY_Thai_moma &hDC1
#DEFINE GDK_KEY_Thai_yoyak &hDC2
#DEFINE GDK_KEY_Thai_rorua &hDC3
#DEFINE GDK_KEY_Thai_ru &hDC4
#DEFINE GDK_KEY_Thai_loling &hDC5
#DEFINE GDK_KEY_Thai_lu &hDC6
#DEFINE GDK_KEY_Thai_wowaen &hDC7
#DEFINE GDK_KEY_Thai_sosala &hDC8
#DEFINE GDK_KEY_Thai_sorusi &hDC9
#DEFINE GDK_KEY_Thai_sosua &hDCA
#DEFINE GDK_KEY_Thai_hohip &hDCB
#DEFINE GDK_KEY_Thai_lochula &hDCC
#DEFINE GDK_KEY_Thai_oang &hDCD
#DEFINE GDK_KEY_Thai_honokhuk &hDCE
#DEFINE GDK_KEY_Thai_paiyannoi &hDCF
#DEFINE GDK_KEY_Thai_saraa &hDD0
#DEFINE GDK_KEY_Thai_maihanakat &hDD1
#DEFINE GDK_KEY_Thai_saraaa &hDD2
#DEFINE GDK_KEY_Thai_saraam &hDD3
#DEFINE GDK_KEY_Thai_sarai &hDD4
#DEFINE GDK_KEY_Thai_saraii &hDD5
#DEFINE GDK_KEY_Thai_saraue &hDD6
#DEFINE GDK_KEY_Thai_sarauee &hDD7
#DEFINE GDK_KEY_Thai_sarau &hDD8
#DEFINE GDK_KEY_Thai_sarauu &hDD9
#DEFINE GDK_KEY_Thai_phinthu &hDDA
#DEFINE GDK_KEY_Thai_maihanakat_maitho &hDDE
#DEFINE GDK_KEY_Thai_baht &hDDF
#DEFINE GDK_KEY_Thai_sarae &hDE0
#DEFINE GDK_KEY_Thai_saraae &hDE1
#DEFINE GDK_KEY_Thai_sarao &hDE2
#DEFINE GDK_KEY_Thai_saraaimaimuan &hDE3
#DEFINE GDK_KEY_Thai_saraaimaimalai &hDE4
#DEFINE GDK_KEY_Thai_lakkhangyao &hDE5
#DEFINE GDK_KEY_Thai_maiyamok &hDE6
#DEFINE GDK_KEY_Thai_maitaikhu &hDE7
#DEFINE GDK_KEY_Thai_maiek &hDE8
#DEFINE GDK_KEY_Thai_maitho &hDE9
#DEFINE GDK_KEY_Thai_maitri &hDEA
#DEFINE GDK_KEY_Thai_maichattawa &hDEB
#DEFINE GDK_KEY_Thai_thanthakhat &hDEC
#DEFINE GDK_KEY_Thai_nikhahit &hDED
#DEFINE GDK_KEY_Thai_leksun &hDF0
#DEFINE GDK_KEY_Thai_leknung &hDF1
#DEFINE GDK_KEY_Thai_leksong &hDF2
#DEFINE GDK_KEY_Thai_leksam &hDF3
#DEFINE GDK_KEY_Thai_leksi &hDF4
#DEFINE GDK_KEY_Thai_lekha &hDF5
#DEFINE GDK_KEY_Thai_lekhok &hDF6
#DEFINE GDK_KEY_Thai_lekchet &hDF7
#DEFINE GDK_KEY_Thai_lekpaet &hDF8
#DEFINE GDK_KEY_Thai_lekkao &hDF9
#DEFINE GDK_KEY_Hangul &hFF31
#DEFINE GDK_KEY_Hangul_Start &hFF32
#DEFINE GDK_KEY_Hangul_End &hFF33
#DEFINE GDK_KEY_Hangul_Hanja &hFF34
#DEFINE GDK_KEY_Hangul_Jamo &hFF35
#DEFINE GDK_KEY_Hangul_Romaja &hFF36
#DEFINE GDK_KEY_Hangul_Codeinput &hFF37
#DEFINE GDK_KEY_Hangul_Jeonja &hFF38
#DEFINE GDK_KEY_Hangul_Banja &hFF39
#DEFINE GDK_KEY_Hangul_PreHanja &hFF3A
#DEFINE GDK_KEY_Hangul_PostHanja &hFF3B
#DEFINE GDK_KEY_Hangul_SingleCandidate &hFF3C
#DEFINE GDK_KEY_Hangul_MultipleCandidate &hFF3D
#DEFINE GDK_KEY_Hangul_PreviousCandidate &hFF3E
#DEFINE GDK_KEY_Hangul_Special &hFF3F
#DEFINE GDK_KEY_Hangul_switch &hFF7E
#DEFINE GDK_KEY_Hangul_Kiyeog &hEA1
#DEFINE GDK_KEY_Hangul_SsangKiyeog &hEA2
#DEFINE GDK_KEY_Hangul_KiyeogSios &hEA3
#DEFINE GDK_KEY_Hangul_Nieun &hEA4
#DEFINE GDK_KEY_Hangul_NieunJieuj &hEA5
#DEFINE GDK_KEY_Hangul_NieunHieuh &hEA6
#DEFINE GDK_KEY_Hangul_Dikeud &hEA7
#DEFINE GDK_KEY_Hangul_SsangDikeud &hEA8
#DEFINE GDK_KEY_Hangul_Rieul &hEA9
#DEFINE GDK_KEY_Hangul_RieulKiyeog &hEAA
#DEFINE GDK_KEY_Hangul_RieulMieum &hEAB
#DEFINE GDK_KEY_Hangul_RieulPieub &hEAC
#DEFINE GDK_KEY_Hangul_RieulSios &hEAD
#DEFINE GDK_KEY_Hangul_RieulTieut &hEAE
#DEFINE GDK_KEY_Hangul_RieulPhieuf &hEAF
#DEFINE GDK_KEY_Hangul_RieulHieuh &hEB0
#DEFINE GDK_KEY_Hangul_Mieum &hEB1
#DEFINE GDK_KEY_Hangul_Pieub &hEB2
#DEFINE GDK_KEY_Hangul_SsangPieub &hEB3
#DEFINE GDK_KEY_Hangul_PieubSios &hEB4
#DEFINE GDK_KEY_Hangul_Sios &hEB5
#DEFINE GDK_KEY_Hangul_SsangSios &hEB6
#DEFINE GDK_KEY_Hangul_Ieung &hEB7
#DEFINE GDK_KEY_Hangul_Jieuj &hEB8
#DEFINE GDK_KEY_Hangul_SsangJieuj &hEB9
#DEFINE GDK_KEY_Hangul_Cieuc &hEBA
#DEFINE GDK_KEY_Hangul_Khieuq &hEBB
#DEFINE GDK_KEY_Hangul_Tieut &hEBC
#DEFINE GDK_KEY_Hangul_Phieuf &hEBD
#DEFINE GDK_KEY_Hangul_Hieuh &hEBE
#DEFINE GDK_KEY_Hangul_A &hEBF
#DEFINE GDK_KEY_Hangul_AE &hEC0
#DEFINE GDK_KEY_Hangul_YA &hEC1
#DEFINE GDK_KEY_Hangul_YAE &hEC2
#DEFINE GDK_KEY_Hangul_EO &hEC3
#DEFINE GDK_KEY_Hangul_E &hEC4
#DEFINE GDK_KEY_Hangul_YEO &hEC5
#DEFINE GDK_KEY_Hangul_YE &hEC6
#DEFINE GDK_KEY_Hangul_O &hEC7
#DEFINE GDK_KEY_Hangul_WA &hEC8
#DEFINE GDK_KEY_Hangul_WAE &hEC9
#DEFINE GDK_KEY_Hangul_OE &hECA
#DEFINE GDK_KEY_Hangul_YO &hECB
#DEFINE GDK_KEY_Hangul_U &hECC
#DEFINE GDK_KEY_Hangul_WEO &hECD
#DEFINE GDK_KEY_Hangul_WE &hECE
#DEFINE GDK_KEY_Hangul_WI &hECF
#DEFINE GDK_KEY_Hangul_YU &hED0
#DEFINE GDK_KEY_Hangul_EU &hED1
#DEFINE GDK_KEY_Hangul_YI &hED2
#DEFINE GDK_KEY_Hangul_I &hED3
#DEFINE GDK_KEY_Hangul_J_Kiyeog &hED4
#DEFINE GDK_KEY_Hangul_J_SsangKiyeog &hED5
#DEFINE GDK_KEY_Hangul_J_KiyeogSios &hED6
#DEFINE GDK_KEY_Hangul_J_Nieun &hED7
#DEFINE GDK_KEY_Hangul_J_NieunJieuj &hED8
#DEFINE GDK_KEY_Hangul_J_NieunHieuh &hED9
#DEFINE GDK_KEY_Hangul_J_Dikeud &hEDA
#DEFINE GDK_KEY_Hangul_J_Rieul &hEDB
#DEFINE GDK_KEY_Hangul_J_RieulKiyeog &hEDC
#DEFINE GDK_KEY_Hangul_J_RieulMieum &hEDD
#DEFINE GDK_KEY_Hangul_J_RieulPieub &hEDE
#DEFINE GDK_KEY_Hangul_J_RieulSios &hEDF
#DEFINE GDK_KEY_Hangul_J_RieulTieut &hEE0
#DEFINE GDK_KEY_Hangul_J_RieulPhieuf &hEE1
#DEFINE GDK_KEY_Hangul_J_RieulHieuh &hEE2
#DEFINE GDK_KEY_Hangul_J_Mieum &hEE3
#DEFINE GDK_KEY_Hangul_J_Pieub &hEE4
#DEFINE GDK_KEY_Hangul_J_PieubSios &hEE5
#DEFINE GDK_KEY_Hangul_J_Sios &hEE6
#DEFINE GDK_KEY_Hangul_J_SsangSios &hEE7
#DEFINE GDK_KEY_Hangul_J_Ieung &hEE8
#DEFINE GDK_KEY_Hangul_J_Jieuj &hEE9
#DEFINE GDK_KEY_Hangul_J_Cieuc &hEEA
#DEFINE GDK_KEY_Hangul_J_Khieuq &hEEB
#DEFINE GDK_KEY_Hangul_J_Tieut &hEEC
#DEFINE GDK_KEY_Hangul_J_Phieuf &hEED
#DEFINE GDK_KEY_Hangul_J_Hieuh &hEEE
#DEFINE GDK_KEY_Hangul_RieulYeorinHieuh &hEEF
#DEFINE GDK_KEY_Hangul_SunkyeongeumMieum &hEF0
#DEFINE GDK_KEY_Hangul_SunkyeongeumPieub &hEF1
#DEFINE GDK_KEY_Hangul_PanSios &hEF2
#DEFINE GDK_KEY_Hangul_KkogjiDalrinIeung &hEF3
#DEFINE GDK_KEY_Hangul_SunkyeongeumPhieuf &hEF4
#DEFINE GDK_KEY_Hangul_YeorinHieuh &hEF5
#DEFINE GDK_KEY_Hangul_AraeA &hEF6
#DEFINE GDK_KEY_Hangul_AraeAE &hEF7
#DEFINE GDK_KEY_Hangul_J_PanSios &hEF8
#DEFINE GDK_KEY_Hangul_J_KkogjiDalrinIeung &hEF9
#DEFINE GDK_KEY_Hangul_J_YeorinHieuh &hEFA
#DEFINE GDK_KEY_Korean_Won &hEFF
#DEFINE GDK_KEY_Armenian_ligature_ew &h1000587
#DEFINE GDK_KEY_Armenian_full_stop &h1000589
#DEFINE GDK_KEY_Armenian_verjaket &h1000589
#DEFINE GDK_KEY_Armenian_separation_mark &h100055D
#DEFINE GDK_KEY_Armenian_but &h100055D
#DEFINE GDK_KEY_Armenian_hyphen &h100058A
#DEFINE GDK_KEY_Armenian_yentamna &h100058A
#DEFINE GDK_KEY_Armenian_exclam &h100055C
#DEFINE GDK_KEY_Armenian_amanak &h100055C
#DEFINE GDK_KEY_Armenian_accent &h100055B
#DEFINE GDK_KEY_Armenian_shesht &h100055B
#DEFINE GDK_KEY_Armenian_question &h100055E
#DEFINE GDK_KEY_Armenian_paruyk &h100055E
#DEFINE GDK_KEY_Armenian_AYB_ &h1000531
#DEFINE GDK_KEY_Armenian_ayb &h1000561
#DEFINE GDK_KEY_Armenian_BEN_ &h1000532
#DEFINE GDK_KEY_Armenian_ben &h1000562
#DEFINE GDK_KEY_Armenian_GIM_ &h1000533
#DEFINE GDK_KEY_Armenian_gim &h1000563
#DEFINE GDK_KEY_Armenian_DA_ &h1000534
#DEFINE GDK_KEY_Armenian_da &h1000564
#DEFINE GDK_KEY_Armenian_YECH_ &h1000535
#DEFINE GDK_KEY_Armenian_yech &h1000565
#DEFINE GDK_KEY_Armenian_ZA_ &h1000536
#DEFINE GDK_KEY_Armenian_za &h1000566
#DEFINE GDK_KEY_Armenian_E_ &h1000537
#DEFINE GDK_KEY_Armenian_e &h1000567
#DEFINE GDK_KEY_Armenian_AT_ &h1000538
#DEFINE GDK_KEY_Armenian_at &h1000568
#DEFINE GDK_KEY_Armenian_TO_ &h1000539
#DEFINE GDK_KEY_Armenian_to &h1000569
#DEFINE GDK_KEY_Armenian_ZHE_ &h100053A
#DEFINE GDK_KEY_Armenian_zhe &h100056A
#DEFINE GDK_KEY_Armenian_INI_ &h100053B
#DEFINE GDK_KEY_Armenian_ini &h100056B
#DEFINE GDK_KEY_Armenian_LYUN_ &h100053C
#DEFINE GDK_KEY_Armenian_lyun &h100056C
#DEFINE GDK_KEY_Armenian_KHE_ &h100053D
#DEFINE GDK_KEY_Armenian_khe &h100056D
#DEFINE GDK_KEY_Armenian_TSA_ &h100053E
#DEFINE GDK_KEY_Armenian_tsa &h100056E
#DEFINE GDK_KEY_Armenian_KEN_ &h100053F
#DEFINE GDK_KEY_Armenian_ken &h100056F
#DEFINE GDK_KEY_Armenian_HO_ &h1000540
#DEFINE GDK_KEY_Armenian_ho &h1000570
#DEFINE GDK_KEY_Armenian_DZA_ &h1000541
#DEFINE GDK_KEY_Armenian_dza &h1000571
#DEFINE GDK_KEY_Armenian_GHAT_ &h1000542
#DEFINE GDK_KEY_Armenian_ghat &h1000572
#DEFINE GDK_KEY_Armenian_TCHE_ &h1000543
#DEFINE GDK_KEY_Armenian_tche &h1000573
#DEFINE GDK_KEY_Armenian_MEN_ &h1000544
#DEFINE GDK_KEY_Armenian_men &h1000574
#DEFINE GDK_KEY_Armenian_HI_ &h1000545
#DEFINE GDK_KEY_Armenian_hi &h1000575
#DEFINE GDK_KEY_Armenian_NU_ &h1000546
#DEFINE GDK_KEY_Armenian_nu &h1000576
#DEFINE GDK_KEY_Armenian_SHA_ &h1000547
#DEFINE GDK_KEY_Armenian_sha &h1000577
#DEFINE GDK_KEY_Armenian_VO_ &h1000548
#DEFINE GDK_KEY_Armenian_vo &h1000578
#DEFINE GDK_KEY_Armenian_CHA_ &h1000549
#DEFINE GDK_KEY_Armenian_cha &h1000579
#DEFINE GDK_KEY_Armenian_PE_ &h100054A
#DEFINE GDK_KEY_Armenian_pe &h100057A
#DEFINE GDK_KEY_Armenian_JE_ &h100054B
#DEFINE GDK_KEY_Armenian_je &h100057B
#DEFINE GDK_KEY_Armenian_RA_ &h100054C
#DEFINE GDK_KEY_Armenian_ra &h100057C
#DEFINE GDK_KEY_Armenian_SE_ &h100054D
#DEFINE GDK_KEY_Armenian_se &h100057D
#DEFINE GDK_KEY_Armenian_VEV_ &h100054E
#DEFINE GDK_KEY_Armenian_vev &h100057E
#DEFINE GDK_KEY_Armenian_TYUN_ &h100054F
#DEFINE GDK_KEY_Armenian_tyun &h100057F
#DEFINE GDK_KEY_Armenian_RE_ &h1000550
#DEFINE GDK_KEY_Armenian_re &h1000580
#DEFINE GDK_KEY_Armenian_TSO_ &h1000551
#DEFINE GDK_KEY_Armenian_tso &h1000581
#DEFINE GDK_KEY_Armenian_VYUN_ &h1000552
#DEFINE GDK_KEY_Armenian_vyun &h1000582
#DEFINE GDK_KEY_Armenian_PYUR_ &h1000553
#DEFINE GDK_KEY_Armenian_pyur &h1000583
#DEFINE GDK_KEY_Armenian_KE_ &h1000554
#DEFINE GDK_KEY_Armenian_ke &h1000584
#DEFINE GDK_KEY_Armenian_O_ &h1000555
#DEFINE GDK_KEY_Armenian_o &h1000585
#DEFINE GDK_KEY_Armenian_FE_ &h1000556
#DEFINE GDK_KEY_Armenian_fe &h1000586
#DEFINE GDK_KEY_Armenian_apostrophe &h100055A
#DEFINE GDK_KEY_Georgian_an &h10010D0
#DEFINE GDK_KEY_Georgian_ban &h10010D1
#DEFINE GDK_KEY_Georgian_gan &h10010D2
#DEFINE GDK_KEY_Georgian_don &h10010D3
#DEFINE GDK_KEY_Georgian_en &h10010D4
#DEFINE GDK_KEY_Georgian_vin &h10010D5
#DEFINE GDK_KEY_Georgian_zen &h10010D6
#DEFINE GDK_KEY_Georgian_tan &h10010D7
#DEFINE GDK_KEY_Georgian_in &h10010D8
#DEFINE GDK_KEY_Georgian_kan &h10010D9
#DEFINE GDK_KEY_Georgian_las &h10010DA
#DEFINE GDK_KEY_Georgian_man &h10010DB
#DEFINE GDK_KEY_Georgian_nar &h10010DC
#DEFINE GDK_KEY_Georgian_on &h10010DD
#DEFINE GDK_KEY_Georgian_par &h10010DE
#DEFINE GDK_KEY_Georgian_zhar &h10010DF
#DEFINE GDK_KEY_Georgian_rae &h10010E0
#DEFINE GDK_KEY_Georgian_san &h10010E1
#DEFINE GDK_KEY_Georgian_tar &h10010E2
#DEFINE GDK_KEY_Georgian_un &h10010E3
#DEFINE GDK_KEY_Georgian_phar &h10010E4
#DEFINE GDK_KEY_Georgian_khar &h10010E5
#DEFINE GDK_KEY_Georgian_ghan &h10010E6
#DEFINE GDK_KEY_Georgian_qar &h10010E7
#DEFINE GDK_KEY_Georgian_shin &h10010E8
#DEFINE GDK_KEY_Georgian_chin &h10010E9
#DEFINE GDK_KEY_Georgian_can &h10010EA
#DEFINE GDK_KEY_Georgian_jil &h10010EB
#DEFINE GDK_KEY_Georgian_cil &h10010EC
#DEFINE GDK_KEY_Georgian_char &h10010ED
#DEFINE GDK_KEY_Georgian_xan &h10010EE
#DEFINE GDK_KEY_Georgian_jhan &h10010EF
#DEFINE GDK_KEY_Georgian_hae &h10010F0
#DEFINE GDK_KEY_Georgian_he &h10010F1
#DEFINE GDK_KEY_Georgian_hie &h10010F2
#DEFINE GDK_KEY_Georgian_we &h10010F3
#DEFINE GDK_KEY_Georgian_har &h10010F4
#DEFINE GDK_KEY_Georgian_hoe &h10010F5
#DEFINE GDK_KEY_Georgian_fi &h10010F6
#DEFINE GDK_KEY_Xabovedot_ &h1001E8A
#DEFINE GDK_KEY_Ibreve_ &h100012C
#DEFINE GDK_KEY_Zstroke_ &h10001B5
#DEFINE GDK_KEY_Gcaron_ &h10001E6
#DEFINE GDK_KEY_Ocaron_ &h10001D1
#DEFINE GDK_KEY_Obarred_ &h100019F
#DEFINE GDK_KEY_xabovedot &h1001E8B
#DEFINE GDK_KEY_ibreve &h100012D
#DEFINE GDK_KEY_zstroke &h10001B6
#DEFINE GDK_KEY_gcaron &h10001E7
#DEFINE GDK_KEY_ocaron &h10001D2
#DEFINE GDK_KEY_obarred &h1000275
#DEFINE GDK_KEY_SCHWA_ &h100018F
#DEFINE GDK_KEY_schwa &h1000259
#DEFINE GDK_KEY_EZH &h10001B7
#DEFINE GDK_KEY_ezh_ &h1000292
#DEFINE GDK_KEY_Lbelowdot_ &h1001E36
#DEFINE GDK_KEY_lbelowdot &h1001E37
#DEFINE GDK_KEY_Abelowdot_ &h1001EA0
#DEFINE GDK_KEY_abelowdot &h1001EA1
#DEFINE GDK_KEY_Ahook_ &h1001EA2
#DEFINE GDK_KEY_ahook &h1001EA3
#DEFINE GDK_KEY_Acircumflexacute_ &h1001EA4
#DEFINE GDK_KEY_acircumflexacute &h1001EA5
#DEFINE GDK_KEY_Acircumflexgrave_ &h1001EA6
#DEFINE GDK_KEY_acircumflexgrave &h1001EA7
#DEFINE GDK_KEY_Acircumflexhook_ &h1001EA8
#DEFINE GDK_KEY_acircumflexhook &h1001EA9
#DEFINE GDK_KEY_Acircumflextilde_ &h1001EAA
#DEFINE GDK_KEY_acircumflextilde &h1001EAB
#DEFINE GDK_KEY_Acircumflexbelowdot_ &h1001EAC
#DEFINE GDK_KEY_acircumflexbelowdot &h1001EAD
#DEFINE GDK_KEY_Abreveacute_ &h1001EAE
#DEFINE GDK_KEY_abreveacute &h1001EAF
#DEFINE GDK_KEY_Abrevegrave_ &h1001EB0
#DEFINE GDK_KEY_abrevegrave &h1001EB1
#DEFINE GDK_KEY_Abrevehook_ &h1001EB2
#DEFINE GDK_KEY_abrevehook &h1001EB3
#DEFINE GDK_KEY_Abrevetilde_ &h1001EB4
#DEFINE GDK_KEY_abrevetilde &h1001EB5
#DEFINE GDK_KEY_Abrevebelowdot_ &h1001EB6
#DEFINE GDK_KEY_abrevebelowdot &h1001EB7
#DEFINE GDK_KEY_Ebelowdot_ &h1001EB8
#DEFINE GDK_KEY_ebelowdot &h1001EB9
#DEFINE GDK_KEY_Ehook_ &h1001EBA
#DEFINE GDK_KEY_ehook &h1001EBB
#DEFINE GDK_KEY_Etilde_ &h1001EBC
#DEFINE GDK_KEY_etilde &h1001EBD
#DEFINE GDK_KEY_Ecircumflexacute_ &h1001EBE
#DEFINE GDK_KEY_ecircumflexacute &h1001EBF
#DEFINE GDK_KEY_Ecircumflexgrave_ &h1001EC0
#DEFINE GDK_KEY_ecircumflexgrave &h1001EC1
#DEFINE GDK_KEY_Ecircumflexhook_ &h1001EC2
#DEFINE GDK_KEY_ecircumflexhook &h1001EC3
#DEFINE GDK_KEY_Ecircumflextilde_ &h1001EC4
#DEFINE GDK_KEY_ecircumflextilde &h1001EC5
#DEFINE GDK_KEY_Ecircumflexbelowdot_ &h1001EC6
#DEFINE GDK_KEY_ecircumflexbelowdot &h1001EC7
#DEFINE GDK_KEY_Ihook_ &h1001EC8
#DEFINE GDK_KEY_ihook &h1001EC9
#DEFINE GDK_KEY_Ibelowdot_ &h1001ECA
#DEFINE GDK_KEY_ibelowdot &h1001ECB
#DEFINE GDK_KEY_Obelowdot_ &h1001ECC
#DEFINE GDK_KEY_obelowdot &h1001ECD
#DEFINE GDK_KEY_Ohook_ &h1001ECE
#DEFINE GDK_KEY_ohook &h1001ECF
#DEFINE GDK_KEY_Ocircumflexacute_ &h1001ED0
#DEFINE GDK_KEY_ocircumflexacute &h1001ED1
#DEFINE GDK_KEY_Ocircumflexgrave_ &h1001ED2
#DEFINE GDK_KEY_ocircumflexgrave &h1001ED3
#DEFINE GDK_KEY_Ocircumflexhook_ &h1001ED4
#DEFINE GDK_KEY_ocircumflexhook &h1001ED5
#DEFINE GDK_KEY_Ocircumflextilde_ &h1001ED6
#DEFINE GDK_KEY_ocircumflextilde &h1001ED7
#DEFINE GDK_KEY_Ocircumflexbelowdot_ &h1001ED8
#DEFINE GDK_KEY_ocircumflexbelowdot &h1001ED9
#DEFINE GDK_KEY_Ohornacute_ &h1001EDA
#DEFINE GDK_KEY_ohornacute &h1001EDB
#DEFINE GDK_KEY_Ohorngrave_ &h1001EDC
#DEFINE GDK_KEY_ohorngrave &h1001EDD
#DEFINE GDK_KEY_Ohornhook_ &h1001EDE
#DEFINE GDK_KEY_ohornhook &h1001EDF
#DEFINE GDK_KEY_Ohorntilde_ &h1001EE0
#DEFINE GDK_KEY_ohorntilde &h1001EE1
#DEFINE GDK_KEY_Ohornbelowdot_ &h1001EE2
#DEFINE GDK_KEY_ohornbelowdot &h1001EE3
#DEFINE GDK_KEY_Ubelowdot_ &h1001EE4
#DEFINE GDK_KEY_ubelowdot &h1001EE5
#DEFINE GDK_KEY_Uhook_ &h1001EE6
#DEFINE GDK_KEY_uhook &h1001EE7
#DEFINE GDK_KEY_Uhornacute_ &h1001EE8
#DEFINE GDK_KEY_uhornacute &h1001EE9
#DEFINE GDK_KEY_Uhorngrave_ &h1001EEA
#DEFINE GDK_KEY_uhorngrave &h1001EEB
#DEFINE GDK_KEY_Uhornhook_ &h1001EEC
#DEFINE GDK_KEY_uhornhook &h1001EED
#DEFINE GDK_KEY_Uhorntilde_ &h1001EEE
#DEFINE GDK_KEY_uhorntilde &h1001EEF
#DEFINE GDK_KEY_Uhornbelowdot_ &h1001EF0
#DEFINE GDK_KEY_uhornbelowdot &h1001EF1
#DEFINE GDK_KEY_Ybelowdot_ &h1001EF4
#DEFINE GDK_KEY_ybelowdot &h1001EF5
#DEFINE GDK_KEY_Yhook_ &h1001EF6
#DEFINE GDK_KEY_yhook &h1001EF7
#DEFINE GDK_KEY_Ytilde_ &h1001EF8
#DEFINE GDK_KEY_ytilde &h1001EF9
#DEFINE GDK_KEY_Ohorn_ &h10001A0
#DEFINE GDK_KEY_ohorn &h10001A1
#DEFINE GDK_KEY_Uhorn_ &h10001AF
#DEFINE GDK_KEY_uhorn &h10001B0
#DEFINE GDK_KEY_EcuSign &h10020A0
#DEFINE GDK_KEY_ColonSign &h10020A1
#DEFINE GDK_KEY_CruzeiroSign &h10020A2
#DEFINE GDK_KEY_FFrancSign &h10020A3
#DEFINE GDK_KEY_LiraSign &h10020A4
#DEFINE GDK_KEY_MillSign &h10020A5
#DEFINE GDK_KEY_NairaSign &h10020A6
#DEFINE GDK_KEY_PesetaSign &h10020A7
#DEFINE GDK_KEY_RupeeSign &h10020A8
#DEFINE GDK_KEY_WonSign &h10020A9
#DEFINE GDK_KEY_NewSheqelSign &h10020AA
#DEFINE GDK_KEY_DongSign &h10020AB
#DEFINE GDK_KEY_EuroSign &h20AC
#DEFINE GDK_KEY_zerosuperior &h1002070
#DEFINE GDK_KEY_foursuperior &h1002074
#DEFINE GDK_KEY_fivesuperior &h1002075
#DEFINE GDK_KEY_sixsuperior &h1002076
#DEFINE GDK_KEY_sevensuperior &h1002077
#DEFINE GDK_KEY_eightsuperior &h1002078
#DEFINE GDK_KEY_ninesuperior &h1002079
#DEFINE GDK_KEY_zerosubscript &h1002080
#DEFINE GDK_KEY_onesubscript &h1002081
#DEFINE GDK_KEY_twosubscript &h1002082
#DEFINE GDK_KEY_threesubscript &h1002083
#DEFINE GDK_KEY_foursubscript &h1002084
#DEFINE GDK_KEY_fivesubscript &h1002085
#DEFINE GDK_KEY_sixsubscript &h1002086
#DEFINE GDK_KEY_sevensubscript &h1002087
#DEFINE GDK_KEY_eightsubscript &h1002088
#DEFINE GDK_KEY_ninesubscript &h1002089
#DEFINE GDK_KEY_partdifferential &h1002202
#DEFINE GDK_KEY_emptyset &h1002205
#DEFINE GDK_KEY_elementof &h1002208
#DEFINE GDK_KEY_notelementof &h1002209
#DEFINE GDK_KEY_containsas &h100220B
#DEFINE GDK_KEY_squareroot &h100221A
#DEFINE GDK_KEY_cuberoot &h100221B
#DEFINE GDK_KEY_fourthroot &h100221C
#DEFINE GDK_KEY_dintegral &h100222C
#DEFINE GDK_KEY_tintegral &h100222D
#DEFINE GDK_KEY_because &h1002235
#DEFINE GDK_KEY_approxeq &h1002248
#DEFINE GDK_KEY_notapproxeq &h1002247
#DEFINE GDK_KEY_notidentical &h1002262
#DEFINE GDK_KEY_stricteq &h1002263
#DEFINE GDK_KEY_braille_dot_1 &hFFF1
#DEFINE GDK_KEY_braille_dot_2 &hFFF2
#DEFINE GDK_KEY_braille_dot_3 &hFFF3
#DEFINE GDK_KEY_braille_dot_4 &hFFF4
#DEFINE GDK_KEY_braille_dot_5 &hFFF5
#DEFINE GDK_KEY_braille_dot_6 &hFFF6
#DEFINE GDK_KEY_braille_dot_7 &hFFF7
#DEFINE GDK_KEY_braille_dot_8 &hFFF8
#DEFINE GDK_KEY_braille_dot_9 &hFFF9
#DEFINE GDK_KEY_braille_dot_10 &hFFFA
#DEFINE GDK_KEY_braille_blank &h1002800
#DEFINE GDK_KEY_braille_dots_1 &h1002801
#DEFINE GDK_KEY_braille_dots_2 &h1002802
#DEFINE GDK_KEY_braille_dots_12 &h1002803
#DEFINE GDK_KEY_braille_dots_3 &h1002804
#DEFINE GDK_KEY_braille_dots_13 &h1002805
#DEFINE GDK_KEY_braille_dots_23 &h1002806
#DEFINE GDK_KEY_braille_dots_123 &h1002807
#DEFINE GDK_KEY_braille_dots_4 &h1002808
#DEFINE GDK_KEY_braille_dots_14 &h1002809
#DEFINE GDK_KEY_braille_dots_24 &h100280A
#DEFINE GDK_KEY_braille_dots_124 &h100280B
#DEFINE GDK_KEY_braille_dots_34 &h100280C
#DEFINE GDK_KEY_braille_dots_134 &h100280D
#DEFINE GDK_KEY_braille_dots_234 &h100280E
#DEFINE GDK_KEY_braille_dots_1234 &h100280F
#DEFINE GDK_KEY_braille_dots_5 &h1002810
#DEFINE GDK_KEY_braille_dots_15 &h1002811
#DEFINE GDK_KEY_braille_dots_25 &h1002812
#DEFINE GDK_KEY_braille_dots_125 &h1002813
#DEFINE GDK_KEY_braille_dots_35 &h1002814
#DEFINE GDK_KEY_braille_dots_135 &h1002815
#DEFINE GDK_KEY_braille_dots_235 &h1002816
#DEFINE GDK_KEY_braille_dots_1235 &h1002817
#DEFINE GDK_KEY_braille_dots_45 &h1002818
#DEFINE GDK_KEY_braille_dots_145 &h1002819
#DEFINE GDK_KEY_braille_dots_245 &h100281A
#DEFINE GDK_KEY_braille_dots_1245 &h100281B
#DEFINE GDK_KEY_braille_dots_345 &h100281C
#DEFINE GDK_KEY_braille_dots_1345 &h100281D
#DEFINE GDK_KEY_braille_dots_2345 &h100281E
#DEFINE GDK_KEY_braille_dots_12345 &h100281F
#DEFINE GDK_KEY_braille_dots_6 &h1002820
#DEFINE GDK_KEY_braille_dots_16 &h1002821
#DEFINE GDK_KEY_braille_dots_26 &h1002822
#DEFINE GDK_KEY_braille_dots_126 &h1002823
#DEFINE GDK_KEY_braille_dots_36 &h1002824
#DEFINE GDK_KEY_braille_dots_136 &h1002825
#DEFINE GDK_KEY_braille_dots_236 &h1002826
#DEFINE GDK_KEY_braille_dots_1236 &h1002827
#DEFINE GDK_KEY_braille_dots_46 &h1002828
#DEFINE GDK_KEY_braille_dots_146 &h1002829
#DEFINE GDK_KEY_braille_dots_246 &h100282A
#DEFINE GDK_KEY_braille_dots_1246 &h100282B
#DEFINE GDK_KEY_braille_dots_346 &h100282C
#DEFINE GDK_KEY_braille_dots_1346 &h100282D
#DEFINE GDK_KEY_braille_dots_2346 &h100282E
#DEFINE GDK_KEY_braille_dots_12346 &h100282F
#DEFINE GDK_KEY_braille_dots_56 &h1002830
#DEFINE GDK_KEY_braille_dots_156 &h1002831
#DEFINE GDK_KEY_braille_dots_256 &h1002832
#DEFINE GDK_KEY_braille_dots_1256 &h1002833
#DEFINE GDK_KEY_braille_dots_356 &h1002834
#DEFINE GDK_KEY_braille_dots_1356 &h1002835
#DEFINE GDK_KEY_braille_dots_2356 &h1002836
#DEFINE GDK_KEY_braille_dots_12356 &h1002837
#DEFINE GDK_KEY_braille_dots_456 &h1002838
#DEFINE GDK_KEY_braille_dots_1456 &h1002839
#DEFINE GDK_KEY_braille_dots_2456 &h100283A
#DEFINE GDK_KEY_braille_dots_12456 &h100283B
#DEFINE GDK_KEY_braille_dots_3456 &h100283C
#DEFINE GDK_KEY_braille_dots_13456 &h100283D
#DEFINE GDK_KEY_braille_dots_23456 &h100283E
#DEFINE GDK_KEY_braille_dots_123456 &h100283F
#DEFINE GDK_KEY_braille_dots_7 &h1002840
#DEFINE GDK_KEY_braille_dots_17 &h1002841
#DEFINE GDK_KEY_braille_dots_27 &h1002842
#DEFINE GDK_KEY_braille_dots_127 &h1002843
#DEFINE GDK_KEY_braille_dots_37 &h1002844
#DEFINE GDK_KEY_braille_dots_137 &h1002845
#DEFINE GDK_KEY_braille_dots_237 &h1002846
#DEFINE GDK_KEY_braille_dots_1237 &h1002847
#DEFINE GDK_KEY_braille_dots_47 &h1002848
#DEFINE GDK_KEY_braille_dots_147 &h1002849
#DEFINE GDK_KEY_braille_dots_247 &h100284A
#DEFINE GDK_KEY_braille_dots_1247 &h100284B
#DEFINE GDK_KEY_braille_dots_347 &h100284C
#DEFINE GDK_KEY_braille_dots_1347 &h100284D
#DEFINE GDK_KEY_braille_dots_2347 &h100284E
#DEFINE GDK_KEY_braille_dots_12347 &h100284F
#DEFINE GDK_KEY_braille_dots_57 &h1002850
#DEFINE GDK_KEY_braille_dots_157 &h1002851
#DEFINE GDK_KEY_braille_dots_257 &h1002852
#DEFINE GDK_KEY_braille_dots_1257 &h1002853
#DEFINE GDK_KEY_braille_dots_357 &h1002854
#DEFINE GDK_KEY_braille_dots_1357 &h1002855
#DEFINE GDK_KEY_braille_dots_2357 &h1002856
#DEFINE GDK_KEY_braille_dots_12357 &h1002857
#DEFINE GDK_KEY_braille_dots_457 &h1002858
#DEFINE GDK_KEY_braille_dots_1457 &h1002859
#DEFINE GDK_KEY_braille_dots_2457 &h100285A
#DEFINE GDK_KEY_braille_dots_12457 &h100285B
#DEFINE GDK_KEY_braille_dots_3457 &h100285C
#DEFINE GDK_KEY_braille_dots_13457 &h100285D
#DEFINE GDK_KEY_braille_dots_23457 &h100285E
#DEFINE GDK_KEY_braille_dots_123457 &h100285F
#DEFINE GDK_KEY_braille_dots_67 &h1002860
#DEFINE GDK_KEY_braille_dots_167 &h1002861
#DEFINE GDK_KEY_braille_dots_267 &h1002862
#DEFINE GDK_KEY_braille_dots_1267 &h1002863
#DEFINE GDK_KEY_braille_dots_367 &h1002864
#DEFINE GDK_KEY_braille_dots_1367 &h1002865
#DEFINE GDK_KEY_braille_dots_2367 &h1002866
#DEFINE GDK_KEY_braille_dots_12367 &h1002867
#DEFINE GDK_KEY_braille_dots_467 &h1002868
#DEFINE GDK_KEY_braille_dots_1467 &h1002869
#DEFINE GDK_KEY_braille_dots_2467 &h100286A
#DEFINE GDK_KEY_braille_dots_12467 &h100286B
#DEFINE GDK_KEY_braille_dots_3467 &h100286C
#DEFINE GDK_KEY_braille_dots_13467 &h100286D
#DEFINE GDK_KEY_braille_dots_23467 &h100286E
#DEFINE GDK_KEY_braille_dots_123467 &h100286F
#DEFINE GDK_KEY_braille_dots_567 &h1002870
#DEFINE GDK_KEY_braille_dots_1567 &h1002871
#DEFINE GDK_KEY_braille_dots_2567 &h1002872
#DEFINE GDK_KEY_braille_dots_12567 &h1002873
#DEFINE GDK_KEY_braille_dots_3567 &h1002874
#DEFINE GDK_KEY_braille_dots_13567 &h1002875
#DEFINE GDK_KEY_braille_dots_23567 &h1002876
#DEFINE GDK_KEY_braille_dots_123567 &h1002877
#DEFINE GDK_KEY_braille_dots_4567 &h1002878
#DEFINE GDK_KEY_braille_dots_14567 &h1002879
#DEFINE GDK_KEY_braille_dots_24567 &h100287A
#DEFINE GDK_KEY_braille_dots_124567 &h100287B
#DEFINE GDK_KEY_braille_dots_34567 &h100287C
#DEFINE GDK_KEY_braille_dots_134567 &h100287D
#DEFINE GDK_KEY_braille_dots_234567 &h100287E
#DEFINE GDK_KEY_braille_dots_1234567 &h100287F
#DEFINE GDK_KEY_braille_dots_8 &h1002880
#DEFINE GDK_KEY_braille_dots_18 &h1002881
#DEFINE GDK_KEY_braille_dots_28 &h1002882
#DEFINE GDK_KEY_braille_dots_128 &h1002883
#DEFINE GDK_KEY_braille_dots_38 &h1002884
#DEFINE GDK_KEY_braille_dots_138 &h1002885
#DEFINE GDK_KEY_braille_dots_238 &h1002886
#DEFINE GDK_KEY_braille_dots_1238 &h1002887
#DEFINE GDK_KEY_braille_dots_48 &h1002888
#DEFINE GDK_KEY_braille_dots_148 &h1002889
#DEFINE GDK_KEY_braille_dots_248 &h100288A
#DEFINE GDK_KEY_braille_dots_1248 &h100288B
#DEFINE GDK_KEY_braille_dots_348 &h100288C
#DEFINE GDK_KEY_braille_dots_1348 &h100288D
#DEFINE GDK_KEY_braille_dots_2348 &h100288E
#DEFINE GDK_KEY_braille_dots_12348 &h100288F
#DEFINE GDK_KEY_braille_dots_58 &h1002890
#DEFINE GDK_KEY_braille_dots_158 &h1002891
#DEFINE GDK_KEY_braille_dots_258 &h1002892
#DEFINE GDK_KEY_braille_dots_1258 &h1002893
#DEFINE GDK_KEY_braille_dots_358 &h1002894
#DEFINE GDK_KEY_braille_dots_1358 &h1002895
#DEFINE GDK_KEY_braille_dots_2358 &h1002896
#DEFINE GDK_KEY_braille_dots_12358 &h1002897
#DEFINE GDK_KEY_braille_dots_458 &h1002898
#DEFINE GDK_KEY_braille_dots_1458 &h1002899
#DEFINE GDK_KEY_braille_dots_2458 &h100289A
#DEFINE GDK_KEY_braille_dots_12458 &h100289B
#DEFINE GDK_KEY_braille_dots_3458 &h100289C
#DEFINE GDK_KEY_braille_dots_13458 &h100289D
#DEFINE GDK_KEY_braille_dots_23458 &h100289E
#DEFINE GDK_KEY_braille_dots_123458 &h100289F
#DEFINE GDK_KEY_braille_dots_68 &h10028A0
#DEFINE GDK_KEY_braille_dots_168 &h10028A1
#DEFINE GDK_KEY_braille_dots_268 &h10028A2
#DEFINE GDK_KEY_braille_dots_1268 &h10028A3
#DEFINE GDK_KEY_braille_dots_368 &h10028A4
#DEFINE GDK_KEY_braille_dots_1368 &h10028A5
#DEFINE GDK_KEY_braille_dots_2368 &h10028A6
#DEFINE GDK_KEY_braille_dots_12368 &h10028A7
#DEFINE GDK_KEY_braille_dots_468 &h10028A8
#DEFINE GDK_KEY_braille_dots_1468 &h10028A9
#DEFINE GDK_KEY_braille_dots_2468 &h10028AA
#DEFINE GDK_KEY_braille_dots_12468 &h10028AB
#DEFINE GDK_KEY_braille_dots_3468 &h10028AC
#DEFINE GDK_KEY_braille_dots_13468 &h10028AD
#DEFINE GDK_KEY_braille_dots_23468 &h10028AE
#DEFINE GDK_KEY_braille_dots_123468 &h10028AF
#DEFINE GDK_KEY_braille_dots_568 &h10028B0
#DEFINE GDK_KEY_braille_dots_1568 &h10028B1
#DEFINE GDK_KEY_braille_dots_2568 &h10028B2
#DEFINE GDK_KEY_braille_dots_12568 &h10028B3
#DEFINE GDK_KEY_braille_dots_3568 &h10028B4
#DEFINE GDK_KEY_braille_dots_13568 &h10028B5
#DEFINE GDK_KEY_braille_dots_23568 &h10028B6
#DEFINE GDK_KEY_braille_dots_123568 &h10028B7
#DEFINE GDK_KEY_braille_dots_4568 &h10028B8
#DEFINE GDK_KEY_braille_dots_14568 &h10028B9
#DEFINE GDK_KEY_braille_dots_24568 &h10028BA
#DEFINE GDK_KEY_braille_dots_124568 &h10028BB
#DEFINE GDK_KEY_braille_dots_34568 &h10028BC
#DEFINE GDK_KEY_braille_dots_134568 &h10028BD
#DEFINE GDK_KEY_braille_dots_234568 &h10028BE
#DEFINE GDK_KEY_braille_dots_1234568 &h10028BF
#DEFINE GDK_KEY_braille_dots_78 &h10028C0
#DEFINE GDK_KEY_braille_dots_178 &h10028C1
#DEFINE GDK_KEY_braille_dots_278 &h10028C2
#DEFINE GDK_KEY_braille_dots_1278 &h10028C3
#DEFINE GDK_KEY_braille_dots_378 &h10028C4
#DEFINE GDK_KEY_braille_dots_1378 &h10028C5
#DEFINE GDK_KEY_braille_dots_2378 &h10028C6
#DEFINE GDK_KEY_braille_dots_12378 &h10028C7
#DEFINE GDK_KEY_braille_dots_478 &h10028C8
#DEFINE GDK_KEY_braille_dots_1478 &h10028C9
#DEFINE GDK_KEY_braille_dots_2478 &h10028CA
#DEFINE GDK_KEY_braille_dots_12478 &h10028CB
#DEFINE GDK_KEY_braille_dots_3478 &h10028CC
#DEFINE GDK_KEY_braille_dots_13478 &h10028CD
#DEFINE GDK_KEY_braille_dots_23478 &h10028CE
#DEFINE GDK_KEY_braille_dots_123478 &h10028CF
#DEFINE GDK_KEY_braille_dots_578 &h10028D0
#DEFINE GDK_KEY_braille_dots_1578 &h10028D1
#DEFINE GDK_KEY_braille_dots_2578 &h10028D2
#DEFINE GDK_KEY_braille_dots_12578 &h10028D3
#DEFINE GDK_KEY_braille_dots_3578 &h10028D4
#DEFINE GDK_KEY_braille_dots_13578 &h10028D5
#DEFINE GDK_KEY_braille_dots_23578 &h10028D6
#DEFINE GDK_KEY_braille_dots_123578 &h10028D7
#DEFINE GDK_KEY_braille_dots_4578 &h10028D8
#DEFINE GDK_KEY_braille_dots_14578 &h10028D9
#DEFINE GDK_KEY_braille_dots_24578 &h10028DA
#DEFINE GDK_KEY_braille_dots_124578 &h10028DB
#DEFINE GDK_KEY_braille_dots_34578 &h10028DC
#DEFINE GDK_KEY_braille_dots_134578 &h10028DD
#DEFINE GDK_KEY_braille_dots_234578 &h10028DE
#DEFINE GDK_KEY_braille_dots_1234578 &h10028DF
#DEFINE GDK_KEY_braille_dots_678 &h10028E0
#DEFINE GDK_KEY_braille_dots_1678 &h10028E1
#DEFINE GDK_KEY_braille_dots_2678 &h10028E2
#DEFINE GDK_KEY_braille_dots_12678 &h10028E3
#DEFINE GDK_KEY_braille_dots_3678 &h10028E4
#DEFINE GDK_KEY_braille_dots_13678 &h10028E5
#DEFINE GDK_KEY_braille_dots_23678 &h10028E6
#DEFINE GDK_KEY_braille_dots_123678 &h10028E7
#DEFINE GDK_KEY_braille_dots_4678 &h10028E8
#DEFINE GDK_KEY_braille_dots_14678 &h10028E9
#DEFINE GDK_KEY_braille_dots_24678 &h10028EA
#DEFINE GDK_KEY_braille_dots_124678 &h10028EB
#DEFINE GDK_KEY_braille_dots_34678 &h10028EC
#DEFINE GDK_KEY_braille_dots_134678 &h10028ED
#DEFINE GDK_KEY_braille_dots_234678 &h10028EE
#DEFINE GDK_KEY_braille_dots_1234678 &h10028EF
#DEFINE GDK_KEY_braille_dots_5678 &h10028F0
#DEFINE GDK_KEY_braille_dots_15678 &h10028F1
#DEFINE GDK_KEY_braille_dots_25678 &h10028F2
#DEFINE GDK_KEY_braille_dots_125678 &h10028F3
#DEFINE GDK_KEY_braille_dots_35678 &h10028F4
#DEFINE GDK_KEY_braille_dots_135678 &h10028F5
#DEFINE GDK_KEY_braille_dots_235678 &h10028F6
#DEFINE GDK_KEY_braille_dots_1235678 &h10028F7
#DEFINE GDK_KEY_braille_dots_45678 &h10028F8
#DEFINE GDK_KEY_braille_dots_145678 &h10028F9
#DEFINE GDK_KEY_braille_dots_245678 &h10028FA
#DEFINE GDK_KEY_braille_dots_1245678 &h10028FB
#DEFINE GDK_KEY_braille_dots_345678 &h10028FC
#DEFINE GDK_KEY_braille_dots_1345678 &h10028FD
#DEFINE GDK_KEY_braille_dots_2345678 &h10028FE
#DEFINE GDK_KEY_braille_dots_12345678 &h10028FF
#DEFINE GDK_KEY_Sinh_ng &h1000D82
#DEFINE GDK_KEY_Sinh_h2 &h1000D83
#DEFINE GDK_KEY_Sinh_a &h1000D85
#DEFINE GDK_KEY_Sinh_aa &h1000D86
#DEFINE GDK_KEY_Sinh_ae &h1000D87
#DEFINE GDK_KEY_Sinh_aee &h1000D88
#DEFINE GDK_KEY_Sinh_i &h1000D89
#DEFINE GDK_KEY_Sinh_ii &h1000D8A
#DEFINE GDK_KEY_Sinh_u &h1000D8B
#DEFINE GDK_KEY_Sinh_uu &h1000D8C
#DEFINE GDK_KEY_Sinh_ri &h1000D8D
#DEFINE GDK_KEY_Sinh_rii &h1000D8E
#DEFINE GDK_KEY_Sinh_lu &h1000D8F
#DEFINE GDK_KEY_Sinh_luu &h1000D90
#DEFINE GDK_KEY_Sinh_e &h1000D91
#DEFINE GDK_KEY_Sinh_ee &h1000D92
#DEFINE GDK_KEY_Sinh_ai &h1000D93
#DEFINE GDK_KEY_Sinh_o &h1000D94
#DEFINE GDK_KEY_Sinh_oo &h1000D95
#DEFINE GDK_KEY_Sinh_au &h1000D96
#DEFINE GDK_KEY_Sinh_ka &h1000D9A
#DEFINE GDK_KEY_Sinh_kha &h1000D9B
#DEFINE GDK_KEY_Sinh_ga &h1000D9C
#DEFINE GDK_KEY_Sinh_gha &h1000D9D
#DEFINE GDK_KEY_Sinh_ng2 &h1000D9E
#DEFINE GDK_KEY_Sinh_nga &h1000D9F
#DEFINE GDK_KEY_Sinh_ca &h1000DA0
#DEFINE GDK_KEY_Sinh_cha &h1000DA1
#DEFINE GDK_KEY_Sinh_ja &h1000DA2
#DEFINE GDK_KEY_Sinh_jha &h1000DA3
#DEFINE GDK_KEY_Sinh_nya &h1000DA4
#DEFINE GDK_KEY_Sinh_jnya &h1000DA5
#DEFINE GDK_KEY_Sinh_nja &h1000DA6
#DEFINE GDK_KEY_Sinh_tta &h1000DA7
#DEFINE GDK_KEY_Sinh_ttha &h1000DA8
#DEFINE GDK_KEY_Sinh_dda &h1000DA9
#DEFINE GDK_KEY_Sinh_ddha &h1000DAA
#DEFINE GDK_KEY_Sinh_nna &h1000DAB
#DEFINE GDK_KEY_Sinh_ndda &h1000DAC
#DEFINE GDK_KEY_Sinh_tha &h1000DAD
#DEFINE GDK_KEY_Sinh_thha &h1000DAE
#DEFINE GDK_KEY_Sinh_dha &h1000DAF
#DEFINE GDK_KEY_Sinh_dhha &h1000DB0
#DEFINE GDK_KEY_Sinh_na &h1000DB1
#DEFINE GDK_KEY_Sinh_ndha &h1000DB3
#DEFINE GDK_KEY_Sinh_pa &h1000DB4
#DEFINE GDK_KEY_Sinh_pha &h1000DB5
#DEFINE GDK_KEY_Sinh_ba &h1000DB6
#DEFINE GDK_KEY_Sinh_bha &h1000DB7
#DEFINE GDK_KEY_Sinh_ma &h1000DB8
#DEFINE GDK_KEY_Sinh_mba &h1000DB9
#DEFINE GDK_KEY_Sinh_ya &h1000DBA
#DEFINE GDK_KEY_Sinh_ra &h1000DBB
#DEFINE GDK_KEY_Sinh_la &h1000DBD
#DEFINE GDK_KEY_Sinh_va &h1000DC0
#DEFINE GDK_KEY_Sinh_sha &h1000DC1
#DEFINE GDK_KEY_Sinh_ssha &h1000DC2
#DEFINE GDK_KEY_Sinh_sa &h1000DC3
#DEFINE GDK_KEY_Sinh_ha &h1000DC4
#DEFINE GDK_KEY_Sinh_lla &h1000DC5
#DEFINE GDK_KEY_Sinh_fa &h1000DC6
#DEFINE GDK_KEY_Sinh_al &h1000DCA
#DEFINE GDK_KEY_Sinh_aa2 &h1000DCF
#DEFINE GDK_KEY_Sinh_ae2 &h1000DD0
#DEFINE GDK_KEY_Sinh_aee2 &h1000DD1
#DEFINE GDK_KEY_Sinh_i2 &h1000DD2
#DEFINE GDK_KEY_Sinh_ii2 &h1000DD3
#DEFINE GDK_KEY_Sinh_u2 &h1000DD4
#DEFINE GDK_KEY_Sinh_uu2 &h1000DD6
#DEFINE GDK_KEY_Sinh_ru2 &h1000DD8
#DEFINE GDK_KEY_Sinh_e2 &h1000DD9
#DEFINE GDK_KEY_Sinh_ee2 &h1000DDA
#DEFINE GDK_KEY_Sinh_ai2 &h1000DDB
#DEFINE GDK_KEY_Sinh_o2 &h1000DDC
#DEFINE GDK_KEY_Sinh_oo2 &h1000DDD
#DEFINE GDK_KEY_Sinh_au2 &h1000DDE
#DEFINE GDK_KEY_Sinh_lu2 &h1000DDF
#DEFINE GDK_KEY_Sinh_ruu2 &h1000DF2
#DEFINE GDK_KEY_Sinh_luu2 &h1000DF3
#DEFINE GDK_KEY_Sinh_kunddaliya &h1000DF4
#DEFINE GDK_KEY_ModeLock &h1008FF01
#DEFINE GDK_KEY_MonBrightnessUp &h1008FF02
#DEFINE GDK_KEY_MonBrightnessDown &h1008FF03
#DEFINE GDK_KEY_KbdLightOnOff &h1008FF04
#DEFINE GDK_KEY_KbdBrightnessUp &h1008FF05
#DEFINE GDK_KEY_KbdBrightnessDown &h1008FF06
#DEFINE GDK_KEY_Standby &h1008FF10
#DEFINE GDK_KEY_AudioLowerVolume &h1008FF11
#DEFINE GDK_KEY_AudioMute &h1008FF12
#DEFINE GDK_KEY_AudioRaiseVolume &h1008FF13
#DEFINE GDK_KEY_AudioPlay &h1008FF14
#DEFINE GDK_KEY_AudioStop &h1008FF15
#DEFINE GDK_KEY_AudioPrev &h1008FF16
#DEFINE GDK_KEY_AudioNext &h1008FF17
#DEFINE GDK_KEY_HomePage &h1008FF18
#DEFINE GDK_KEY_Mail &h1008FF19
#DEFINE GDK_KEY_Start &h1008FF1A
#DEFINE GDK_KEY_Search &h1008FF1B
#DEFINE GDK_KEY_AudioRecord &h1008FF1C
#DEFINE GDK_KEY_Calculator &h1008FF1D
#DEFINE GDK_KEY_Memo &h1008FF1E
#DEFINE GDK_KEY_ToDoList &h1008FF1F
#DEFINE GDK_KEY_Calendar &h1008FF20
#DEFINE GDK_KEY_PowerDown &h1008FF21
#DEFINE GDK_KEY_ContrastAdjust &h1008FF22
#DEFINE GDK_KEY_RockerUp &h1008FF23
#DEFINE GDK_KEY_RockerDown &h1008FF24
#DEFINE GDK_KEY_RockerEnter &h1008FF25
#DEFINE GDK_KEY_Back &h1008FF26
#DEFINE GDK_KEY_Forward &h1008FF27
#DEFINE GDK_KEY_Stop &h1008FF28
#DEFINE GDK_KEY_Refresh &h1008FF29
#DEFINE GDK_KEY_PowerOff &h1008FF2A
#DEFINE GDK_KEY_WakeUp &h1008FF2B
#DEFINE GDK_KEY_Eject &h1008FF2C
#DEFINE GDK_KEY_ScreenSaver &h1008FF2D
#DEFINE GDK_KEY_WWW &h1008FF2E
#DEFINE GDK_KEY_Sleep &h1008FF2F
#DEFINE GDK_KEY_Favorites &h1008FF30
#DEFINE GDK_KEY_AudioPause &h1008FF31
#DEFINE GDK_KEY_AudioMedia &h1008FF32
#DEFINE GDK_KEY_MyComputer &h1008FF33
#DEFINE GDK_KEY_VendorHome &h1008FF34
#DEFINE GDK_KEY_LightBulb &h1008FF35
#DEFINE GDK_KEY_Shop &h1008FF36
#DEFINE GDK_KEY_History &h1008FF37
#DEFINE GDK_KEY_OpenURL &h1008FF38
#DEFINE GDK_KEY_AddFavorite &h1008FF39
#DEFINE GDK_KEY_HotLinks &h1008FF3A
#DEFINE GDK_KEY_BrightnessAdjust &h1008FF3B
#DEFINE GDK_KEY_Finance &h1008FF3C
#DEFINE GDK_KEY_Community &h1008FF3D
#DEFINE GDK_KEY_AudioRewind &h1008FF3E
#DEFINE GDK_KEY_BackForward &h1008FF3F
#DEFINE GDK_KEY_Launch0 &h1008FF40
#DEFINE GDK_KEY_Launch1 &h1008FF41
#DEFINE GDK_KEY_Launch2 &h1008FF42
#DEFINE GDK_KEY_Launch3 &h1008FF43
#DEFINE GDK_KEY_Launch4 &h1008FF44
#DEFINE GDK_KEY_Launch5 &h1008FF45
#DEFINE GDK_KEY_Launch6 &h1008FF46
#DEFINE GDK_KEY_Launch7 &h1008FF47
#DEFINE GDK_KEY_Launch8 &h1008FF48
#DEFINE GDK_KEY_Launch9 &h1008FF49
#DEFINE GDK_KEY_LaunchA &h1008FF4A
#DEFINE GDK_KEY_LaunchB &h1008FF4B
#DEFINE GDK_KEY_LaunchC &h1008FF4C
#DEFINE GDK_KEY_LaunchD &h1008FF4D
#DEFINE GDK_KEY_LaunchE &h1008FF4E
#DEFINE GDK_KEY_LaunchF &h1008FF4F
#DEFINE GDK_KEY_ApplicationLeft &h1008FF50
#DEFINE GDK_KEY_ApplicationRight &h1008FF51
#DEFINE GDK_KEY_Book &h1008FF52
#DEFINE GDK_KEY_CD &h1008FF53
#DEFINE GDK_KEY_WindowClear &h1008FF55
#DEFINE GDK_KEY_Close &h1008FF56
#DEFINE GDK_KEY_Copy &h1008FF57
#DEFINE GDK_KEY_Cut &h1008FF58
#DEFINE GDK_KEY_Display &h1008FF59
#DEFINE GDK_KEY_DOS &h1008FF5A
#DEFINE GDK_KEY_Documents &h1008FF5B
#DEFINE GDK_KEY_Excel &h1008FF5C
#DEFINE GDK_KEY_Explorer &h1008FF5D
#DEFINE GDK_KEY_Game &h1008FF5E
#DEFINE GDK_KEY_Go &h1008FF5F
#DEFINE GDK_KEY_iTouch &h1008FF60
#DEFINE GDK_KEY_LogOff &h1008FF61
#DEFINE GDK_KEY_Market &h1008FF62
#DEFINE GDK_KEY_Meeting &h1008FF63
#DEFINE GDK_KEY_MenuKB &h1008FF65
#DEFINE GDK_KEY_MenuPB &h1008FF66
#DEFINE GDK_KEY_MySites &h1008FF67
#DEFINE GDK_KEY_New &h1008FF68
#DEFINE GDK_KEY_News &h1008FF69
#DEFINE GDK_KEY_OfficeHome &h1008FF6A
#DEFINE GDK_KEY_Open &h1008FF6B
#DEFINE GDK_KEY_Option &h1008FF6C
#DEFINE GDK_KEY_Paste &h1008FF6D
#DEFINE GDK_KEY_Phone &h1008FF6E
#DEFINE GDK_KEY_Reply &h1008FF72
#DEFINE GDK_KEY_Reload &h1008FF73
#DEFINE GDK_KEY_RotateWindows &h1008FF74
#DEFINE GDK_KEY_RotationPB &h1008FF75
#DEFINE GDK_KEY_RotationKB &h1008FF76
#DEFINE GDK_KEY_Save &h1008FF77
#DEFINE GDK_KEY_ScrollUp &h1008FF78
#DEFINE GDK_KEY_ScrollDown &h1008FF79
#DEFINE GDK_KEY_ScrollClick &h1008FF7A
#DEFINE GDK_KEY_Send &h1008FF7B
#DEFINE GDK_KEY_Spell &h1008FF7C
#DEFINE GDK_KEY_SplitScreen &h1008FF7D
#DEFINE GDK_KEY_Support &h1008FF7E
#DEFINE GDK_KEY_TaskPane &h1008FF7F
#DEFINE GDK_KEY_Terminal &h1008FF80
#DEFINE GDK_KEY_Tools &h1008FF81
#DEFINE GDK_KEY_Travel &h1008FF82
#DEFINE GDK_KEY_UserPB &h1008FF84
#DEFINE GDK_KEY_User1KB &h1008FF85
#DEFINE GDK_KEY_User2KB &h1008FF86
#DEFINE GDK_KEY_Video &h1008FF87
#DEFINE GDK_KEY_WheelButton &h1008FF88
#DEFINE GDK_KEY_Word &h1008FF89
#DEFINE GDK_KEY_Xfer &h1008FF8A
#DEFINE GDK_KEY_ZoomIn &h1008FF8B
#DEFINE GDK_KEY_ZoomOut &h1008FF8C
#DEFINE GDK_KEY_Away &h1008FF8D
#DEFINE GDK_KEY_Messenger &h1008FF8E
#DEFINE GDK_KEY_WebCam &h1008FF8F
#DEFINE GDK_KEY_MailForward &h1008FF90
#DEFINE GDK_KEY_Pictures &h1008FF91
#DEFINE GDK_KEY_Music &h1008FF92
#DEFINE GDK_KEY_Battery &h1008FF93
#DEFINE GDK_KEY_Bluetooth &h1008FF94
#DEFINE GDK_KEY_WLAN &h1008FF95
#DEFINE GDK_KEY_UWB &h1008FF96
#DEFINE GDK_KEY_AudioForward &h1008FF97
#DEFINE GDK_KEY_AudioRepeat &h1008FF98
#DEFINE GDK_KEY_AudioRandomPlay &h1008FF99
#DEFINE GDK_KEY_Subtitle &h1008FF9A
#DEFINE GDK_KEY_AudioCycleTrack &h1008FF9B
#DEFINE GDK_KEY_CycleAngle &h1008FF9C
#DEFINE GDK_KEY_FrameBack &h1008FF9D
#DEFINE GDK_KEY_FrameForward &h1008FF9E
#DEFINE GDK_KEY_Time &h1008FF9F
#DEFINE GDK_KEY_SelectButton &h1008FFA0
#DEFINE GDK_KEY_View &h1008FFA1
#DEFINE GDK_KEY_TopMenu &h1008FFA2
#DEFINE GDK_KEY_Red &h1008FFA3
#DEFINE GDK_KEY_Green &h1008FFA4
#DEFINE GDK_KEY_Yellow &h1008FFA5
#DEFINE GDK_KEY_Blue &h1008FFA6
#DEFINE GDK_KEY_Suspend &h1008FFA7
#DEFINE GDK_KEY_Hibernate &h1008FFA8
#DEFINE GDK_KEY_TouchpadToggle &h1008FFA9
#DEFINE GDK_KEY_TouchpadOn &h1008FFB0
#DEFINE GDK_KEY_TouchpadOff &h1008FFB1
#DEFINE GDK_KEY_Switch_VT_1 &h1008FE01
#DEFINE GDK_KEY_Switch_VT_2 &h1008FE02
#DEFINE GDK_KEY_Switch_VT_3 &h1008FE03
#DEFINE GDK_KEY_Switch_VT_4 &h1008FE04
#DEFINE GDK_KEY_Switch_VT_5 &h1008FE05
#DEFINE GDK_KEY_Switch_VT_6 &h1008FE06
#DEFINE GDK_KEY_Switch_VT_7 &h1008FE07
#DEFINE GDK_KEY_Switch_VT_8 &h1008FE08
#DEFINE GDK_KEY_Switch_VT_9 &h1008FE09
#DEFINE GDK_KEY_Switch_VT_10 &h1008FE0A
#DEFINE GDK_KEY_Switch_VT_11 &h1008FE0B
#DEFINE GDK_KEY_Switch_VT_12 &h1008FE0C
#DEFINE GDK_KEY_Ungrab &h1008FE20
#DEFINE GDK_KEY_ClearGrab &h1008FE21
#DEFINE GDK_KEY_Next_VMode &h1008FE22
#DEFINE GDK_KEY_Prev_VMode &h1008FE23
#DEFINE GDK_KEY_LogWindowTree &h1008FE24
#DEFINE GDK_KEY_LogGrabInfo &h1008FE25
#ENDIF ' __GDK_KEYSYMS_H__

#IFNDEF __GDK_MAIN_H__
#DEFINE __GDK_MAIN_H__

#DEFINE GDK_PRIORITY_EVENTS (G_PRIORITY_DEFAULT)

DECLARE SUB gdk_parse_args(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR)
DECLARE SUB gdk_init(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR)
DECLARE FUNCTION gdk_init_check(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR) AS gboolean
DECLARE SUB gdk_add_option_entries_libgtk_only(BYVAL AS GOptionGroup PTR)
DECLARE SUB gdk_pre_parse_libgtk_only()
DECLARE FUNCTION gdk_get_program_class() AS CONST gchar PTR
DECLARE SUB gdk_set_program_class(BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_notify_startup_complete()
DECLARE SUB gdk_notify_startup_complete_with_id(BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_error_trap_push()
DECLARE FUNCTION gdk_error_trap_pop() AS gint
DECLARE SUB gdk_error_trap_pop_ignored()
DECLARE FUNCTION gdk_get_display_arg_name() AS CONST gchar PTR
DECLARE FUNCTION gdk_get_display() AS gchar PTR

#IFNDEF GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_pointer_grab(BYVAL AS GdkWindow PTR, BYVAL AS gboolean, BYVAL AS GdkEventMask, BYVAL AS GdkWindow PTR, BYVAL AS GdkCursor PTR, BYVAL AS guint32) AS GdkGrabStatus
DECLARE FUNCTION gdk_keyboard_grab(BYVAL AS GdkWindow PTR, BYVAL AS gboolean, BYVAL AS guint32) AS GdkGrabStatus

#ENDIF ' GDK_MULTIDEVICE_SAFE

#IFNDEF GDK_MULTIHEAD_SAFE
#IFNDEF GDK_MULTIDEVICE_SAFE

DECLARE SUB gdk_pointer_ungrab(BYVAL AS guint32)
DECLARE SUB gdk_keyboard_ungrab(BYVAL AS guint32)
DECLARE FUNCTION gdk_pointer_is_grabbed() AS gboolean

#ENDIF ' GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_screen_width() AS gint
DECLARE FUNCTION gdk_screen_height() AS gint
DECLARE FUNCTION gdk_screen_width_mm() AS gint
DECLARE FUNCTION gdk_screen_height_mm() AS gint
DECLARE SUB gdk_set_double_click_time(BYVAL AS guint)
DECLARE SUB gdk_beep()

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_flush()
DECLARE SUB gdk_disable_multidevice()

#ENDIF ' __GDK_MAIN_H__

#IFNDEF __GDK_PANGO_H__
#DEFINE __GDK_PANGO_H__

DECLARE FUNCTION gdk_pango_context_get_for_screen(BYVAL AS GdkScreen PTR) AS PangoContext PTR

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_pango_context_get() AS PangoContext PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_pango_layout_line_get_clip_region(BYVAL AS PangoLayoutLine PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gint PTR, BYVAL AS gint) AS cairo_region_t PTR
DECLARE FUNCTION gdk_pango_layout_get_clip_region(BYVAL AS PangoLayout PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gint PTR, BYVAL AS gint) AS cairo_region_t PTR

#ENDIF ' __GDK_PANGO_H__

#IFNDEF __GDK_PROPERTY_H__
#DEFINE __GDK_PROPERTY_H__

ENUM GdkPropMode
  GDK_PROP_MODE_REPLACE
  GDK_PROP_MODE_PREPEND
  GDK_PROP_MODE_APPEND
END ENUM

DECLARE FUNCTION gdk_atom_intern(BYVAL AS CONST gchar PTR, BYVAL AS gboolean) AS GdkAtom
DECLARE FUNCTION gdk_atom_intern_static_string(BYVAL AS CONST gchar PTR) AS GdkAtom
DECLARE FUNCTION gdk_atom_name(BYVAL AS GdkAtom) AS gchar PTR
DECLARE FUNCTION gdk_property_get(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS gulong, BYVAL AS gulong, BYVAL AS gint, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS guchar PTR PTR) AS gboolean
DECLARE SUB gdk_property_change(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS GdkPropMode, BYVAL AS CONST guchar PTR, BYVAL AS gint)
DECLARE SUB gdk_property_delete(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom)
DECLARE FUNCTION gdk_text_property_to_utf8_list_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gchar PTR PTR PTR) AS gint
DECLARE FUNCTION gdk_utf8_to_string_target(BYVAL AS CONST gchar PTR) AS gchar PTR

#ENDIF ' __GDK_PROPERTY_H__

#IFNDEF __GDK_RECTANGLE_H__
#DEFINE __GDK_RECTANGLE_H__

DECLARE FUNCTION gdk_rectangle_intersect(BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR) AS gboolean
DECLARE SUB gdk_rectangle_union(BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gdk_rectangle_get_type() AS GType

#DEFINE GDK_TYPE_RECTANGLE (gdk_rectangle_get_type ())
#ENDIF ' __GDK_RECTANGLE_H__

#IFNDEF __GDK_SELECTION_H__
#DEFINE __GDK_SELECTION_H__

#DEFINE GDK_SELECTION_PRIMARY _GDK_MAKE_ATOM (1)
#DEFINE GDK_SELECTION_SECONDARY _GDK_MAKE_ATOM (2)
#DEFINE GDK_SELECTION_CLIPBOARD _GDK_MAKE_ATOM (69)
#DEFINE GDK_TARGET_BITMAP _GDK_MAKE_ATOM (5)
#DEFINE GDK_TARGET_COLORMAP _GDK_MAKE_ATOM (7)
#DEFINE GDK_TARGET_DRAWABLE _GDK_MAKE_ATOM (17)
#DEFINE GDK_TARGET_PIXMAP _GDK_MAKE_ATOM (20)
#DEFINE GDK_TARGET_STRING _GDK_MAKE_ATOM (31)
#DEFINE GDK_SELECTION_TYPE_ATOM _GDK_MAKE_ATOM (4)
#DEFINE GDK_SELECTION_TYPE_BITMAP _GDK_MAKE_ATOM (5)
#DEFINE GDK_SELECTION_TYPE_COLORMAP _GDK_MAKE_ATOM (7)
#DEFINE GDK_SELECTION_TYPE_DRAWABLE _GDK_MAKE_ATOM (17)
#DEFINE GDK_SELECTION_TYPE_INTEGER _GDK_MAKE_ATOM (19)
#DEFINE GDK_SELECTION_TYPE_PIXMAP _GDK_MAKE_ATOM (20)
#DEFINE GDK_SELECTION_TYPE_WINDOW _GDK_MAKE_ATOM (33)
#DEFINE GDK_SELECTION_TYPE_STRING _GDK_MAKE_ATOM (31)

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_selection_owner_set(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS guint32, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gdk_selection_owner_get(BYVAL AS GdkAtom) AS GdkWindow PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_selection_owner_set_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS guint32, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gdk_selection_owner_get_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom) AS GdkWindow PTR
DECLARE SUB gdk_selection_convert(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32)
DECLARE FUNCTION gdk_selection_property_get(BYVAL AS GdkWindow PTR, BYVAL AS guchar PTR PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR) AS gint
DECLARE SUB gdk_selection_send_notify(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32)
DECLARE SUB gdk_selection_send_notify_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32)

#ENDIF ' __GDK_SELECTION_H__

#IFNDEF __GDK_TEST_UTILS_H__
#DEFINE __GDK_TEST_UTILS_H__

#IFNDEF __GDK_WINDOW_H__
#DEFINE __GDK_WINDOW_H__

TYPE GdkGeometry AS _GdkGeometry
TYPE GdkWindowAttr AS _GdkWindowAttr
TYPE GdkWindowRedirect AS _GdkWindowRedirect

ENUM GdkWindowWindowClass
  GDK_INPUT_OUTPUT
  GDK_INPUT_ONLY
END ENUM

ENUM GdkWindowType
  GDK_WINDOW_ROOT
  GDK_WINDOW_TOPLEVEL
  GDK_WINDOW_CHILD
  GDK_WINDOW_TEMP
  GDK_WINDOW_FOREIGN
  GDK_WINDOW_OFFSCREEN
END ENUM

ENUM GdkWindowAttributesType
  GDK_WA_TITLE = 1  SHL 1
  GDK_WA_X = 1  SHL 2
  GDK_WA_Y = 1  SHL 3
  GDK_WA_CURSOR = 1  SHL 4
  GDK_WA_VISUAL = 1  SHL 5
  GDK_WA_WMCLASS = 1  SHL 6
  GDK_WA_NOREDIR = 1  SHL 7
  GDK_WA_TYPE_HINT = 1  SHL 8
END ENUM

ENUM GdkWindowHints
  GDK_HINT_POS = 1  SHL 0
  GDK_HINT_MIN_SIZE = 1  SHL 1
  GDK_HINT_MAX_SIZE = 1  SHL 2
  GDK_HINT_BASE_SIZE = 1  SHL 3
  GDK_HINT_ASPECT = 1  SHL 4
  GDK_HINT_RESIZE_INC = 1  SHL 5
  GDK_HINT_WIN_GRAVITY = 1  SHL 6
  GDK_HINT_USER_POS = 1  SHL 7
  GDK_HINT_USER_SIZE = 1  SHL 8
END ENUM

ENUM GdkWindowTypeHint
  GDK_WINDOW_TYPE_HINT_NORMAL
  GDK_WINDOW_TYPE_HINT_DIALOG
  GDK_WINDOW_TYPE_HINT_MENU
  GDK_WINDOW_TYPE_HINT_TOOLBAR
  GDK_WINDOW_TYPE_HINT_SPLASHSCREEN
  GDK_WINDOW_TYPE_HINT_UTILITY
  GDK_WINDOW_TYPE_HINT_DOCK
  GDK_WINDOW_TYPE_HINT_DESKTOP
  GDK_WINDOW_TYPE_HINT_DROPDOWN_MENU
  GDK_WINDOW_TYPE_HINT_POPUP_MENU
  GDK_WINDOW_TYPE_HINT_TOOLTIP
  GDK_WINDOW_TYPE_HINT_NOTIFICATION
  GDK_WINDOW_TYPE_HINT_COMBO
  GDK_WINDOW_TYPE_HINT_DND
END ENUM

ENUM GdkWMDecoration
  GDK_DECOR_ALL = 1  SHL 0
  GDK_DECOR_BORDER = 1  SHL 1
  GDK_DECOR_RESIZEH = 1  SHL 2
  GDK_DECOR_TITLE = 1  SHL 3
  GDK_DECOR_MENU = 1  SHL 4
  GDK_DECOR_MINIMIZE = 1  SHL 5
  GDK_DECOR_MAXIMIZE = 1  SHL 6
END ENUM

ENUM GdkWMFunction
  GDK_FUNC_ALL = 1  SHL 0
  GDK_FUNC_RESIZE = 1  SHL 1
  GDK_FUNC_MOVE = 1  SHL 2
  GDK_FUNC_MINIMIZE = 1  SHL 3
  GDK_FUNC_MAXIMIZE = 1  SHL 4
  GDK_FUNC_CLOSE = 1  SHL 5
END ENUM

ENUM GdkGravity
  GDK_GRAVITY_NORTH_WEST = 1
  GDK_GRAVITY_NORTH
  GDK_GRAVITY_NORTH_EAST
  GDK_GRAVITY_WEST
  GDK_GRAVITY_CENTER
  GDK_GRAVITY_EAST
  GDK_GRAVITY_SOUTH_WEST
  GDK_GRAVITY_SOUTH
  GDK_GRAVITY_SOUTH_EAST
  GDK_GRAVITY_STATIC
END ENUM

ENUM GdkWindowEdge
  GDK_WINDOW_EDGE_NORTH_WEST
  GDK_WINDOW_EDGE_NORTH
  GDK_WINDOW_EDGE_NORTH_EAST
  GDK_WINDOW_EDGE_WEST
  GDK_WINDOW_EDGE_EAST
  GDK_WINDOW_EDGE_SOUTH_WEST
  GDK_WINDOW_EDGE_SOUTH
  GDK_WINDOW_EDGE_SOUTH_EAST
END ENUM

TYPE _GdkWindowAttr
  AS gchar PTR title
  AS gint event_mask
  AS gint x, y
  AS gint width
  AS gint height
  AS GdkWindowWindowClass wclass
  AS GdkVisual PTR visual
  AS GdkWindowType window_type
  AS GdkCursor PTR cursor
  AS gchar PTR wmclass_name
  AS gchar PTR wmclass_class
  AS gboolean override_redirect
  AS GdkWindowTypeHint type_hint
END TYPE

TYPE _GdkGeometry
  AS gint min_width
  AS gint min_height
  AS gint max_width
  AS gint max_height
  AS gint base_width
  AS gint base_height
  AS gint width_inc
  AS gint height_inc
  AS gdouble min_aspect
  AS gdouble max_aspect
  AS GdkGravity win_gravity
END TYPE

TYPE GdkWindowClass AS _GdkWindowClass

#DEFINE GDK_TYPE_WINDOW (gdk_window_get_type ())
#DEFINE GDK_WINDOW(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_WINDOW, GdkWindow))
#DEFINE GDK_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_WINDOW, GdkWindowClass))
#DEFINE GDK_IS_WINDOW(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_WINDOW))
#DEFINE GDK_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_WINDOW))
#DEFINE GDK_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_WINDOW, GdkWindowClass))

TYPE _GdkWindowClass
  AS GObjectClass parent_class
  pick_embedded_child AS FUNCTION(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble) AS GdkWindow PTR
  to_embedder AS SUB(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
  from_embedder AS SUB(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
  create_surface AS FUNCTION(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint) AS cairo_surface_t PTR
  _gdk_reserved1 AS SUB()
  _gdk_reserved2 AS SUB()
  _gdk_reserved3 AS SUB()
  _gdk_reserved4 AS SUB()
  _gdk_reserved5 AS SUB()
  _gdk_reserved6 AS SUB()
  _gdk_reserved7 AS SUB()
  _gdk_reserved8 AS SUB()
END TYPE

DECLARE FUNCTION gdk_window_get_type() AS GType
DECLARE FUNCTION gdk_window_new(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowAttr PTR, BYVAL AS gint) AS GdkWindow PTR
DECLARE SUB gdk_window_destroy(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_window_type(BYVAL AS GdkWindow PTR) AS GdkWindowType
DECLARE FUNCTION gdk_window_is_destroyed(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_get_visual(BYVAL AS GdkWindow PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_window_get_screen(BYVAL AS GdkWindow PTR) AS GdkScreen PTR
DECLARE FUNCTION gdk_window_get_display(BYVAL AS GdkWindow PTR) AS GdkDisplay PTR

#IFNDEF GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_window_at_pointer(BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR

#ENDIF ' GDK_MULTIDEVICE_SAFE

DECLARE SUB gdk_window_show(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_hide(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_withdraw(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_show_unraised(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_move(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_resize(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_move_resize(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_reparent(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_raise(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_lower(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_restack(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_focus(BYVAL AS GdkWindow PTR, BYVAL AS guint32)
DECLARE SUB gdk_window_set_user_data(BYVAL AS GdkWindow PTR, BYVAL AS gpointer)
DECLARE SUB gdk_window_set_override_redirect(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gdk_window_get_accept_focus(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_accept_focus(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gdk_window_get_focus_on_map(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_focus_on_map(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_add_filter(BYVAL AS GdkWindow PTR, BYVAL AS GdkFilterFunc, BYVAL AS gpointer)
DECLARE SUB gdk_window_remove_filter(BYVAL AS GdkWindow PTR, BYVAL AS GdkFilterFunc, BYVAL AS gpointer)
DECLARE SUB gdk_window_scroll(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_move_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST cairo_region_t PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gdk_window_ensure_native(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_shape_combine_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST cairo_region_t PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_set_child_shapes(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_composited(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_composited(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_merge_child_shapes(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_input_shape_combine_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST cairo_region_t PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_set_child_input_shapes(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_merge_child_input_shapes(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_is_visible(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_is_viewable(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_is_input_only(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_is_shaped(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_get_state(BYVAL AS GdkWindow PTR) AS GdkWindowState
DECLARE FUNCTION gdk_window_set_static_gravities(BYVAL AS GdkWindow PTR, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gdk_window_has_native(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_type_hint(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowTypeHint)
DECLARE FUNCTION gdk_window_get_type_hint(BYVAL AS GdkWindow PTR) AS GdkWindowTypeHint
DECLARE FUNCTION gdk_window_get_modal_hint(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_modal_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_skip_taskbar_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_skip_pager_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_urgency_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_geometry_hints(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkGeometry PTR, BYVAL AS GdkWindowHints)
DECLARE FUNCTION gdk_window_get_clip_region(BYVAL AS GdkWindow PTR) AS cairo_region_t PTR
DECLARE FUNCTION gdk_window_get_visible_region(BYVAL AS GdkWindow PTR) AS cairo_region_t PTR
DECLARE SUB gdk_window_begin_paint_rect(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gdk_window_begin_paint_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST cairo_region_t PTR)
DECLARE SUB gdk_window_end_paint(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_flush(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_set_title(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_role(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_startup_id(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_transient_for(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_set_background(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_window_set_background_rgba(BYVAL AS GdkWindow PTR, BYVAL AS GdkRGBA PTR)
DECLARE SUB gdk_window_set_background_pattern(BYVAL AS GdkWindow PTR, BYVAL AS cairo_pattern_t PTR)
DECLARE FUNCTION gdk_window_get_background_pattern(BYVAL AS GdkWindow PTR) AS cairo_pattern_t PTR
DECLARE SUB gdk_window_set_cursor(BYVAL AS GdkWindow PTR, BYVAL AS GdkCursor PTR)
DECLARE FUNCTION gdk_window_get_cursor(BYVAL AS GdkWindow PTR) AS GdkCursor PTR
DECLARE SUB gdk_window_set_device_cursor(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR, BYVAL AS GdkCursor PTR)
DECLARE FUNCTION gdk_window_get_device_cursor(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR) AS GdkCursor PTR
DECLARE SUB gdk_window_get_user_data(BYVAL AS GdkWindow PTR, BYVAL AS gpointer PTR)
DECLARE SUB gdk_window_get_geometry(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_window_get_width(BYVAL AS GdkWindow PTR) AS INTEGER
DECLARE FUNCTION gdk_window_get_height(BYVAL AS GdkWindow PTR) AS INTEGER
DECLARE SUB gdk_window_get_position(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_window_get_origin(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gint
DECLARE SUB gdk_window_get_root_coords(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_coords_to_parent(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB gdk_window_coords_from_parent(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB gdk_window_get_root_origin(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_get_frame_extents(BYVAL AS GdkWindow PTR, BYVAL AS GdkRectangle PTR)

#IFNDEF GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_window_get_pointer(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR) AS GdkWindow PTR

#ENDIF ' GDK_MULTIDEVICE_SAFE

DECLARE FUNCTION gdk_window_get_device_position(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_parent(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_toplevel(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_effective_parent(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_effective_toplevel(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_children(BYVAL AS GdkWindow PTR) AS GList PTR
DECLARE FUNCTION gdk_window_peek_children(BYVAL AS GdkWindow PTR) AS GList PTR
DECLARE FUNCTION gdk_window_get_events(BYVAL AS GdkWindow PTR) AS GdkEventMask
DECLARE SUB gdk_window_set_events(BYVAL AS GdkWindow PTR, BYVAL AS GdkEventMask)
DECLARE SUB gdk_window_set_device_events(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR, BYVAL AS GdkEventMask)
DECLARE FUNCTION gdk_window_get_device_events(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR) AS GdkEventMask
DECLARE SUB gdk_window_set_source_events(BYVAL AS GdkWindow PTR, BYVAL AS GdkInputSource, BYVAL AS GdkEventMask)
DECLARE FUNCTION gdk_window_get_source_events(BYVAL AS GdkWindow PTR, BYVAL AS GdkInputSource) AS GdkEventMask
DECLARE SUB gdk_window_set_icon_list(BYVAL AS GdkWindow PTR, BYVAL AS GList PTR)
DECLARE SUB gdk_window_set_icon_name(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_group(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_group(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE SUB gdk_window_set_decorations(BYVAL AS GdkWindow PTR, BYVAL AS GdkWMDecoration)
DECLARE FUNCTION gdk_window_get_decorations(BYVAL AS GdkWindow PTR, BYVAL AS GdkWMDecoration PTR) AS gboolean
DECLARE SUB gdk_window_set_functions(BYVAL AS GdkWindow PTR, BYVAL AS GdkWMFunction)
DECLARE FUNCTION gdk_window_create_similar_surface(BYVAL AS GdkWindow PTR, BYVAL AS cairo_content_t, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
DECLARE SUB gdk_window_beep(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_iconify(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_deiconify(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_stick(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_unstick(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_maximize(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_unmaximize(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_fullscreen(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_unfullscreen(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_set_keep_above(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_keep_below(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_opacity(BYVAL AS GdkWindow PTR, BYVAL AS gdouble)
DECLARE SUB gdk_window_register_dnd(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_drag_protocol(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR PTR) AS GdkDragProtocol
DECLARE SUB gdk_window_begin_resize_drag(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowEdge, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gdk_window_begin_resize_drag_for_device(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowEdge, BYVAL AS GdkDevice PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gdk_window_begin_move_drag(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gdk_window_begin_move_drag_for_device(BYVAL AS GdkWindow PTR, BYVAL AS GdkDevice PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gdk_window_invalidate_rect(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_invalidate_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST cairo_region_t PTR, BYVAL AS gboolean)

TYPE GdkWindowChildFunc AS FUNCTION(BYVAL AS GdkWindow PTR, BYVAL AS gpointer) AS gboolean

DECLARE SUB gdk_window_invalidate_maybe_recurse(BYVAL AS GdkWindow PTR, BYVAL AS CONST cairo_region_t PTR, BYVAL AS GdkWindowChildFunc, BYVAL AS gpointer)
DECLARE FUNCTION gdk_window_get_update_area(BYVAL AS GdkWindow PTR) AS cairo_region_t PTR
DECLARE SUB gdk_window_freeze_updates(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_thaw_updates(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_freeze_toplevel_updates_libgtk_only(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_thaw_toplevel_updates_libgtk_only(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_process_all_updates()
DECLARE SUB gdk_window_process_updates(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_debug_updates(BYVAL AS gboolean)
DECLARE SUB gdk_window_constrain_size(BYVAL AS GdkGeometry PTR, BYVAL AS guint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_enable_synchronized_configure(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_configure_finished(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_get_default_root_window() AS GdkWindow PTR
DECLARE FUNCTION gdk_offscreen_window_get_surface(BYVAL AS GdkWindow PTR) AS cairo_surface_t PTR
DECLARE SUB gdk_offscreen_window_set_embedder(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_offscreen_window_get_embedder(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE SUB gdk_window_geometry_changed(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_set_support_multidevice(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE FUNCTION gdk_window_get_support_multidevice(BYVAL AS GdkWindow PTR) AS gboolean

#ENDIF ' __GDK_WINDOW_H__

DECLARE SUB gdk_test_render_sync(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_test_simulate_key(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GdkEventType) AS gboolean
DECLARE FUNCTION gdk_test_simulate_button(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GdkEventType) AS gboolean

#ENDIF ' __GDK_TEST_UTILS_H__

#IFNDEF __GDK_THREADS_H__
#DEFINE __GDK_THREADS_H__

DECLARE SUB gdk_threads_init()
DECLARE SUB gdk_threads_enter()
DECLARE SUB gdk_threads_leave()
DECLARE SUB gdk_threads_set_lock_functions(BYVAL AS GCallback, BYVAL AS GCallback)
DECLARE FUNCTION gdk_threads_add_idle_full(BYVAL AS gint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION gdk_threads_add_idle(BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION gdk_threads_add_timeout_full(BYVAL AS gint, BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION gdk_threads_add_timeout(BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION gdk_threads_add_timeout_seconds_full(BYVAL AS gint, BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION gdk_threads_add_timeout_seconds(BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint

#DEFINE GDK_THREADS_ENTER_() gdk_threads_enter()
#DEFINE GDK_THREADS_LEAVE_() gdk_threads_leave()
#ENDIF ' __GDK_THREADS_H__

#IFNDEF __GDK_VISUAL_H__
#DEFINE __GDK_VISUAL_H__

#DEFINE GDK_TYPE_VISUAL (gdk_visual_get_type ())
#DEFINE GDK_VISUAL(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_VISUAL, GdkVisual))
#DEFINE GDK_IS_VISUAL(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_VISUAL))

ENUM GdkVisualType
  GDK_VISUAL_STATIC_GRAY
  GDK_VISUAL_GRAYSCALE
  GDK_VISUAL_STATIC_COLOR
  GDK_VISUAL_PSEUDO_COLOR
  GDK_VISUAL_TRUE_COLOR
  GDK_VISUAL_DIRECT_COLOR
END ENUM

DECLARE FUNCTION gdk_visual_get_type() AS GType

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_visual_get_best_depth() AS gint
DECLARE FUNCTION gdk_visual_get_best_type() AS GdkVisualType
DECLARE FUNCTION gdk_visual_get_system() AS GdkVisual PTR
DECLARE FUNCTION gdk_visual_get_best() AS GdkVisual PTR
DECLARE FUNCTION gdk_visual_get_best_with_depth(BYVAL AS gint) AS GdkVisual PTR
DECLARE FUNCTION gdk_visual_get_best_with_type(BYVAL AS GdkVisualType) AS GdkVisual PTR
DECLARE FUNCTION gdk_visual_get_best_with_both(BYVAL AS gint, BYVAL AS GdkVisualType) AS GdkVisual PTR
DECLARE SUB gdk_query_depths(BYVAL AS gint PTR PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_query_visual_types(BYVAL AS GdkVisualType PTR PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_list_visuals() AS GList PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_visual_get_screen(BYVAL AS GdkVisual PTR) AS GdkScreen PTR
DECLARE FUNCTION gdk_visual_get_visual_type(BYVAL AS GdkVisual PTR) AS GdkVisualType
DECLARE FUNCTION gdk_visual_get_depth(BYVAL AS GdkVisual PTR) AS gint
DECLARE FUNCTION gdk_visual_get_byte_order(BYVAL AS GdkVisual PTR) AS GdkByteOrder
DECLARE FUNCTION gdk_visual_get_colormap_size(BYVAL AS GdkVisual PTR) AS gint
DECLARE FUNCTION gdk_visual_get_bits_per_rgb(BYVAL AS GdkVisual PTR) AS gint
DECLARE SUB gdk_visual_get_red_pixel_details(BYVAL AS GdkVisual PTR, BYVAL AS guint32 PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_visual_get_green_pixel_details(BYVAL AS GdkVisual PTR, BYVAL AS guint32 PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_visual_get_blue_pixel_details(BYVAL AS GdkVisual PTR, BYVAL AS guint32 PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)

#ENDIF ' __GDK_VISUAL_H__

#UNDEF __GDK_H_INSIDE__
#ENDIF ' __GDK_H__

END EXTERN ' (h_2_bi -P_oCD option)

#IFDEF __FB_WIN32__
 #PRAGMA pop(msbitfields)
#ENDIF

#ENDIF ' __GDK_TJF__

' Translated at 12-08-19 16:11:25, by h_2_bi (version 0.2.2.1,
' released under GPLv3 by Thomas[ dot ]Freiherr{ at }gmx[ dot ]net)

'   Protocol: GDK-3.4.4.bi
' Parameters: GDK-3.4.4
'                                  Process time [s]: 1.299729920458049
'                                  Bytes translated: 167749
'                                      Maximum deep: 7
'                                SUB/FUNCTION names: 500
'                                mangled TYPE names: 0
'                                        files done: 28
' gtk+-3.4.4/gdk/gdk.h
' gtk+-3.4.4/gdk/gdkversionmacros.h
' gtk+-3.4.4/gdk/gdkapplaunchcontext.h
' gtk+-3.4.4/gdk/gdktypes.h
' gtk+-3.4.4/gdk/gdkscreen.h
' gtk+-3.4.4/gdk/gdkdisplay.h
' gtk+-3.4.4/gdk/gdkevents.h
' gtk+-3.4.4/gdk/gdkcolor.h
' gtk+-3.4.4/gdk/gdkdnd.h
' gtk+-3.4.4/gdk/gdkdevice.h
' gtk+-3.4.4/gdk/gdkdevicemanager.h
' gtk+-3.4.4/gdk/gdkcairo.h
' gtk+-3.4.4/gdk/gdkrgba.h
' gtk+-3.4.4/gdk/gdkpixbuf.h
' gtk+-3.4.4/gdk/gdkcursor.h
' gtk+-3.4.4/gdk/gdkdisplaymanager.h
' gtk+-3.4.4/gdk/gdkenumtypes.h
' gtk+-3.4.4/gdk/gdkkeys.h
' gtk+-3.4.4/gdk/gdkkeysyms.h
' gtk+-3.4.4/gdk/gdkmain.h
' gtk+-3.4.4/gdk/gdkpango.h
' gtk+-3.4.4/gdk/gdkproperty.h
' gtk+-3.4.4/gdk/gdkrectangle.h
' gtk+-3.4.4/gdk/gdkselection.h
' gtk+-3.4.4/gdk/gdktestutils.h
' gtk+-3.4.4/gdk/gdkwindow.h
' gtk+-3.4.4/gdk/gdkthreads.h
' gtk+-3.4.4/gdk/gdkvisual.h
'                                      files missed: 1
' gdk/gdkconfig.h
'                                       __FOLDERS__: 2
' gtk+-3.4.4/gdk/
' gtk+-3.4.4/
'                                        __MACROS__: 8
' 25: #define G_BEGIN_DECLS
' 25: #define G_END_DECLS
' 60: #define G_GNUC_CONST
' 5: #define GDK_AVAILABLE_IN_3_2
' 8: #define GDK_AVAILABLE_IN_3_4
' 18: #define GDK_DEPRECATED_IN_3_0_FOR(x)
' 2: #define GDK_DEPRECATED_IN_3_4_FOR(x)
' 1: #define G_GNUC_WARN_UNUSED_RESULT
'                                       __HEADERS__: 7
' 2: glib.h>glib.bi
' 1: gio/gio.h>gio/gio.bi
' 1: pango/pango.h>pango/pango.bi
' 2: glib-object.h>glib-object.bi
' 4: cairo.h>cairo.bi
' 2: gdk-pixbuf/gdk-pixbuf.h>gtk/gdk-pixbuf/gdk-pixbuf.bi
' 1: pango/pangocairo.h>pango/pangocairo.bi
'                                         __TYPES__: 0
'                                     __POST_REPS__: 347
' 1: GDK_DRAG_MOTION&
' 1: GDK_DRAG_STATUS&
' 1: GDK_KEY_dead_A&
' 1: GDK_KEY_dead_E&
' 1: GDK_KEY_dead_I&
' 1: GDK_KEY_dead_O&
' 1: GDK_KEY_dead_U&
' 1: GDK_KEY_A&
' 1: GDK_KEY_B&
' 1: GDK_KEY_C&
' 1: GDK_KEY_D&
' 1: GDK_KEY_E&
' 1: GDK_KEY_F&
' 1: GDK_KEY_G&
' 1: GDK_KEY_H&
' 1: GDK_KEY_I&
' 1: GDK_KEY_J&
' 1: GDK_KEY_K&
' 1: GDK_KEY_L&
' 1: GDK_KEY_M&
' 1: GDK_KEY_N&
' 1: GDK_KEY_O&
' 1: GDK_KEY_P&
' 1: GDK_KEY_Q&
' 1: GDK_KEY_R&
' 1: GDK_KEY_S&
' 1: GDK_KEY_T&
' 1: GDK_KEY_U&
' 1: GDK_KEY_V&
' 1: GDK_KEY_W&
' 1: GDK_KEY_X&
' 1: GDK_KEY_Y&
' 1: GDK_KEY_Z&
' 1: GDK_KEY_Agrave&
' 1: GDK_KEY_Aacute&
' 1: GDK_KEY_Acircumflex&
' 1: GDK_KEY_Atilde&
' 1: GDK_KEY_Adiaeresis&
' 1: GDK_KEY_Aring&
' 1: GDK_KEY_AE&
' 1: GDK_KEY_Ccedilla&
' 1: GDK_KEY_Egrave&
' 1: GDK_KEY_Eacute&
' 1: GDK_KEY_Ecircumflex&
' 1: GDK_KEY_Ediaeresis&
' 1: GDK_KEY_Igrave&
' 1: GDK_KEY_Iacute&
' 1: GDK_KEY_Icircumflex&
' 1: GDK_KEY_Idiaeresis&
' 1: GDK_KEY_ETH&_2
' 1: GDK_KEY_Eth&
' 1: GDK_KEY_Ntilde&
' 1: GDK_KEY_Ograve&
' 1: GDK_KEY_Oacute&
' 1: GDK_KEY_Ocircumflex&
' 1: GDK_KEY_Otilde&
' 1: GDK_KEY_Odiaeresis&
' 1: GDK_KEY_Oslash&
' 1: GDK_KEY_Ooblique&
' 1: GDK_KEY_Ugrave&
' 1: GDK_KEY_Uacute&
' 1: GDK_KEY_Ucircumflex&
' 1: GDK_KEY_Udiaeresis&
' 1: GDK_KEY_Yacute&
' 1: GDK_KEY_Thorn&
' 1: GDK_KEY_Aogonek&
' 1: GDK_KEY_Lstroke&
' 1: GDK_KEY_Lcaron&
' 1: GDK_KEY_Sacute&
' 1: GDK_KEY_Scaron&
' 1: GDK_KEY_Scedilla&
' 1: GDK_KEY_Tcaron&
' 1: GDK_KEY_Zacute&
' 1: GDK_KEY_Zcaron&
' 1: GDK_KEY_Zabovedot&
' 1: GDK_KEY_Racute&
' 1: GDK_KEY_Abreve&
' 1: GDK_KEY_Lacute&
' 1: GDK_KEY_Cacute&
' 1: GDK_KEY_Ccaron&
' 1: GDK_KEY_Eogonek&
' 1: GDK_KEY_Ecaron&
' 1: GDK_KEY_Dcaron&
' 1: GDK_KEY_THORN&_2
' 1: GDK_KEY_Dstroke&
' 1: GDK_KEY_Nacute&
' 1: GDK_KEY_Ncaron&
' 1: GDK_KEY_Odoubleacute&
' 1: GDK_KEY_Udoubleacute&
' 1: GDK_KEY_Rcaron&
' 1: GDK_KEY_Uring&
' 1: GDK_KEY_Tcedilla&
' 1: GDK_KEY_Hstroke&
' 1: GDK_KEY_Hcircumflex&
' 1: GDK_KEY_Gbreve&
' 1: GDK_KEY_Jcircumflex&
' 1: GDK_KEY_Cabovedot&
' 1: GDK_KEY_Ccircumflex&
' 1: GDK_KEY_Gabovedot&
' 1: GDK_KEY_Gcircumflex&
' 1: GDK_KEY_Ubreve&
' 1: GDK_KEY_Scircumflex&
' 1: GDK_KEY_Rcedilla&
' 1: GDK_KEY_Itilde&
' 1: GDK_KEY_Lcedilla&
' 1: GDK_KEY_Emacron&
' 1: GDK_KEY_Gcedilla&
' 1: GDK_KEY_Tslash&
' 1: GDK_KEY_ENG&
' 1: GDK_KEY_Amacron&
' 1: GDK_KEY_Iogonek&
' 1: GDK_KEY_Eabovedot&
' 1: GDK_KEY_Imacron&
' 1: GDK_KEY_Ncedilla&
' 1: GDK_KEY_Omacron&
' 1: GDK_KEY_Kcedilla&
' 1: GDK_KEY_Uogonek&
' 1: GDK_KEY_Utilde&
' 1: GDK_KEY_Umacron&
' 1: GDK_KEY_Babovedot&
' 1: GDK_KEY_Dabovedot&
' 1: GDK_KEY_Fabovedot&
' 1: GDK_KEY_Mabovedot&
' 1: GDK_KEY_Wgrave&
' 1: GDK_KEY_Pabovedot&
' 1: GDK_KEY_Wacute&
' 1: GDK_KEY_Ygrave&
' 1: GDK_KEY_Wdiaeresis&
' 1: GDK_KEY_Sabovedot&
' 1: GDK_KEY_Wcircumflex&
' 1: GDK_KEY_Tabovedot&
' 1: GDK_KEY_Ycircumflex&
' 1: GDK_KEY_OE&
' 1: GDK_KEY_Ydiaeresis&
' 1: GDK_KEY_kana_A&
' 1: GDK_KEY_kana_I&
' 1: GDK_KEY_kana_U&
' 1: GDK_KEY_kana_E&
' 1: GDK_KEY_kana_O&
' 1: GDK_KEY_kana_TSU&
' 1: GDK_KEY_kana_TU&
' 1: GDK_KEY_kana_YA&
' 1: GDK_KEY_kana_YU&
' 1: GDK_KEY_kana_YO&
' 1: GDK_KEY_Cyrillic_GHE_bar&
' 1: GDK_KEY_Cyrillic_ZHE_descender&
' 1: GDK_KEY_Cyrillic_KA_descender&
' 1: GDK_KEY_Cyrillic_KA_vertstroke&
' 1: GDK_KEY_Cyrillic_EN_descender&
' 1: GDK_KEY_Cyrillic_U_straight&
' 1: GDK_KEY_Cyrillic_U_straight_bar&
' 1: GDK_KEY_Cyrillic_HA_descender&
' 1: GDK_KEY_Cyrillic_CHE_descender&
' 1: GDK_KEY_Cyrillic_CHE_vertstroke&
' 1: GDK_KEY_Cyrillic_SHHA&
' 1: GDK_KEY_Cyrillic_SCHWA&
' 1: GDK_KEY_Cyrillic_I_macron&
' 1: GDK_KEY_Cyrillic_O_bar&
' 1: GDK_KEY_Cyrillic_U_macron&
' 1: GDK_KEY_Serbian_DJE&
' 1: GDK_KEY_Macedonia_GJE&
' 1: GDK_KEY_Cyrillic_IO&
' 1: GDK_KEY_Ukrainian_IE&
' 1: GDK_KEY_Ukranian_JE&
' 1: GDK_KEY_Macedonia_DSE&
' 1: GDK_KEY_Ukrainian_I&
' 1: GDK_KEY_Ukranian_I&
' 1: GDK_KEY_Ukrainian_YI&
' 1: GDK_KEY_Ukranian_YI&
' 1: GDK_KEY_Cyrillic_JE&
' 1: GDK_KEY_Serbian_JE&
' 1: GDK_KEY_Cyrillic_LJE&
' 1: GDK_KEY_Serbian_LJE&
' 1: GDK_KEY_Cyrillic_NJE&
' 1: GDK_KEY_Serbian_NJE&
' 1: GDK_KEY_Serbian_TSHE&
' 1: GDK_KEY_Macedonia_KJE&
' 1: GDK_KEY_Ukrainian_GHE_WITH_UPTURN&
' 1: GDK_KEY_Byelorussian_SHORTU&
' 1: GDK_KEY_Cyrillic_DZHE&
' 1: GDK_KEY_Serbian_DZE&
' 1: GDK_KEY_Cyrillic_YU&
' 1: GDK_KEY_Cyrillic_A&
' 1: GDK_KEY_Cyrillic_BE&
' 1: GDK_KEY_Cyrillic_TSE&
' 1: GDK_KEY_Cyrillic_DE&
' 1: GDK_KEY_Cyrillic_IE&
' 1: GDK_KEY_Cyrillic_EF&
' 1: GDK_KEY_Cyrillic_GHE&
' 1: GDK_KEY_Cyrillic_HA&
' 1: GDK_KEY_Cyrillic_I&
' 1: GDK_KEY_Cyrillic_SHORTI&
' 1: GDK_KEY_Cyrillic_KA&
' 1: GDK_KEY_Cyrillic_EL&
' 1: GDK_KEY_Cyrillic_EM&
' 1: GDK_KEY_Cyrillic_EN&
' 1: GDK_KEY_Cyrillic_O&
' 1: GDK_KEY_Cyrillic_PE&
' 1: GDK_KEY_Cyrillic_YA&
' 1: GDK_KEY_Cyrillic_ER&
' 1: GDK_KEY_Cyrillic_ES&
' 1: GDK_KEY_Cyrillic_TE&
' 1: GDK_KEY_Cyrillic_U&
' 1: GDK_KEY_Cyrillic_ZHE&
' 1: GDK_KEY_Cyrillic_VE&
' 1: GDK_KEY_Cyrillic_SOFTSIGN&
' 1: GDK_KEY_Cyrillic_YERU&
' 1: GDK_KEY_Cyrillic_ZE&
' 1: GDK_KEY_Cyrillic_SHA&
' 1: GDK_KEY_Cyrillic_E&
' 1: GDK_KEY_Cyrillic_SHCHA&
' 1: GDK_KEY_Cyrillic_CHE&
' 1: GDK_KEY_Cyrillic_HARDSIGN&
' 1: GDK_KEY_Greek_ALPHAaccent&
' 1: GDK_KEY_Greek_EPSILONaccent&
' 1: GDK_KEY_Greek_ETAaccent&
' 1: GDK_KEY_Greek_IOTAaccent&
' 1: GDK_KEY_Greek_IOTAdieresis&
' 1: GDK_KEY_Greek_OMICRONaccent&
' 1: GDK_KEY_Greek_UPSILONaccent&
' 1: GDK_KEY_Greek_UPSILONdieresis&
' 1: GDK_KEY_Greek_OMEGAaccent&
' 1: GDK_KEY_Greek_ALPHA&
' 1: GDK_KEY_Greek_BETA&
' 1: GDK_KEY_Greek_GAMMA&
' 1: GDK_KEY_Greek_DELTA&
' 1: GDK_KEY_Greek_EPSILON&
' 1: GDK_KEY_Greek_ZETA&
' 1: GDK_KEY_Greek_ETA&
' 1: GDK_KEY_Greek_THETA&
' 1: GDK_KEY_Greek_IOTA&
' 1: GDK_KEY_Greek_KAPPA&
' 1: GDK_KEY_Greek_LAMDA&
' 1: GDK_KEY_Greek_LAMBDA&
' 1: GDK_KEY_Greek_MU&
' 1: GDK_KEY_Greek_NU&
' 1: GDK_KEY_Greek_XI&
' 1: GDK_KEY_Greek_OMICRON&
' 1: GDK_KEY_Greek_PI&
' 1: GDK_KEY_Greek_RHO&
' 1: GDK_KEY_Greek_SIGMA&
' 1: GDK_KEY_Greek_TAU&
' 1: GDK_KEY_Greek_UPSILON&
' 1: GDK_KEY_Greek_PHI&
' 1: GDK_KEY_Greek_CHI&
' 1: GDK_KEY_Greek_PSI&
' 1: GDK_KEY_Greek_OMEGA&
' 1: GDK_KEY_Armenian_AYB&
' 1: GDK_KEY_Armenian_BEN&
' 1: GDK_KEY_Armenian_GIM&
' 1: GDK_KEY_Armenian_DA&
' 1: GDK_KEY_Armenian_YECH&
' 1: GDK_KEY_Armenian_ZA&
' 1: GDK_KEY_Armenian_E&
' 1: GDK_KEY_Armenian_AT&
' 1: GDK_KEY_Armenian_TO&
' 1: GDK_KEY_Armenian_ZHE&
' 1: GDK_KEY_Armenian_INI&
' 1: GDK_KEY_Armenian_LYUN&
' 1: GDK_KEY_Armenian_KHE&
' 1: GDK_KEY_Armenian_TSA&
' 1: GDK_KEY_Armenian_KEN&
' 1: GDK_KEY_Armenian_HO&
' 1: GDK_KEY_Armenian_DZA&
' 1: GDK_KEY_Armenian_GHAT&
' 1: GDK_KEY_Armenian_TCHE&
' 1: GDK_KEY_Armenian_MEN&
' 1: GDK_KEY_Armenian_HI&
' 1: GDK_KEY_Armenian_NU&
' 1: GDK_KEY_Armenian_SHA&
' 1: GDK_KEY_Armenian_VO&
' 1: GDK_KEY_Armenian_CHA&
' 1: GDK_KEY_Armenian_PE&
' 1: GDK_KEY_Armenian_JE&
' 1: GDK_KEY_Armenian_RA&
' 1: GDK_KEY_Armenian_SE&
' 1: GDK_KEY_Armenian_VEV&
' 1: GDK_KEY_Armenian_TYUN&
' 1: GDK_KEY_Armenian_RE&
' 1: GDK_KEY_Armenian_TSO&
' 1: GDK_KEY_Armenian_VYUN&
' 1: GDK_KEY_Armenian_PYUR&
' 1: GDK_KEY_Armenian_KE&
' 1: GDK_KEY_Armenian_O&
' 1: GDK_KEY_Armenian_FE&
' 1: GDK_KEY_Xabovedot&
' 1: GDK_KEY_Ibreve&
' 1: GDK_KEY_Zstroke&
' 1: GDK_KEY_Gcaron&
' 1: GDK_KEY_Ocaron&
' 1: GDK_KEY_Obarred&
' 1: GDK_KEY_SCHWA&
' 1: GDK_KEY_Lbelowdot&
' 1: GDK_KEY_Abelowdot&
' 1: GDK_KEY_Ahook&
' 1: GDK_KEY_Acircumflexacute&
' 1: GDK_KEY_Acircumflexgrave&
' 1: GDK_KEY_Acircumflexhook&
' 1: GDK_KEY_Acircumflextilde&
' 1: GDK_KEY_Acircumflexbelowdot&
' 1: GDK_KEY_Abreveacute&
' 1: GDK_KEY_Abrevegrave&
' 1: GDK_KEY_Abrevehook&
' 1: GDK_KEY_Abrevetilde&
' 1: GDK_KEY_Abrevebelowdot&
' 1: GDK_KEY_Ebelowdot&
' 1: GDK_KEY_Ehook&
' 1: GDK_KEY_Etilde&
' 1: GDK_KEY_Ecircumflexacute&
' 1: GDK_KEY_Ecircumflexgrave&
' 1: GDK_KEY_Ecircumflexhook&
' 1: GDK_KEY_Ecircumflextilde&
' 1: GDK_KEY_Ecircumflexbelowdot&
' 1: GDK_KEY_Ihook&
' 1: GDK_KEY_Ibelowdot&
' 1: GDK_KEY_Obelowdot&
' 1: GDK_KEY_Ohook&
' 1: GDK_KEY_Ocircumflexacute&
' 1: GDK_KEY_Ocircumflexgrave&
' 1: GDK_KEY_Ocircumflexhook&
' 1: GDK_KEY_Ocircumflextilde&
' 1: GDK_KEY_Ocircumflexbelowdot&
' 1: GDK_KEY_Ohornacute&
' 1: GDK_KEY_Ohorngrave&
' 1: GDK_KEY_Ohornhook&
' 1: GDK_KEY_Ohorntilde&
' 1: GDK_KEY_Ohornbelowdot&
' 1: GDK_KEY_Ubelowdot&
' 1: GDK_KEY_Uhook&
' 1: GDK_KEY_Uhornacute&
' 1: GDK_KEY_Uhorngrave&
' 1: GDK_KEY_Uhornhook&
' 1: GDK_KEY_Uhorntilde&
' 1: GDK_KEY_Uhornbelowdot&
' 1: GDK_KEY_Ybelowdot&
' 1: GDK_KEY_Yhook&
' 1: GDK_KEY_Ytilde&
' 1: GDK_KEY_Ohorn&
' 1: GDK_KEY_Uhorn&
' 1: GDK_PROPERTY_DELETE&
' 1: GDK_THREADS_ENTER&
' 1: GDK_THREADS_LEAVE&
' 1: GDK_KEY_Ch&
' 1: GDK_KEY_CH&__
' 1: GDK_KEY_C_h&
' 1: GDK_KEY_C_H&__
' 1: GDK_KEY_ezh&
