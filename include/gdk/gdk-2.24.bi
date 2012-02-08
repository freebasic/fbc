' This is file gdk-2.24.bi
' (FreeBasic binding for gdk library version 2.24.6)
'
' (C) 2011 Thomas[ dot ]Freiherr[ at ]gmx[ dot ]net
' translated with help of h_2_bi.bas
' (http://www.freebasic-portal.de/downloads/ressourcencompiler/h2bi-bas-134.html)
'
' Licence:
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
 #DEFINE G_OS_WIN32
 #DEFINE G_PLATFORM_WIN32
 #PRAGMA push(msbitfields)
 #INCLIB "gdk-win32-2.0"
#ELSEIF NOT DEFINED(__FB_LINUX__)
 #ERROR "Platform not supported!"
#ELSE
 #DEFINE G_OS_UNIX
 #INCLIB "gdk-x11-2.0"
#ENDIF

EXTERN "C"

#IFNDEF __GDK_H__
#DEFINE __GDK_H__
#DEFINE __GDK_H_INSIDE__

#IFNDEF __GDK_APP_LAUNCH_CONTEXT_H__
#DEFINE __GDK_APP_LAUNCH_CONTEXT_H__
#INCLUDE ONCE "gio/gio.bi"

#IFNDEF __GDK_SCREEN_H__
#DEFINE __GDK_SCREEN_H__
#INCLUDE ONCE "cairo/cairo.bi"

#IFNDEF __GDK_TYPES_H__
#DEFINE __GDK_TYPES_H__
#INCLUDE ONCE "glib.bi"
#INCLUDE ONCE "pango/pango.bi"
#INCLUDE ONCE "glib-object.bi"

#DEFINE GDK_CURRENT_TIME 0L
#DEFINE GDK_PARENT_RELATIVE 1L

TYPE GdkPoint AS _GdkPoint
TYPE GdkRectangle AS _GdkRectangle
TYPE GdkSegment AS _GdkSegment
TYPE GdkSpan AS _GdkSpan
TYPE GdkWChar AS guint32
TYPE GdkAtom AS _GdkAtom PTR

#DEFINE GDK_ATOM_TO_POINTER(atom) (atom)
#DEFINE GDK_POINTER_TO_ATOM(ptr) ((GdkAtom)(ptr))

#IFDEF GDK_NATIVE_WINDOW_POINTER
#DEFINE GDK_GPOINTER_TO_NATIVE_WINDOW(p) ((GdkNativeWindow) (p))
#ELSE ' GDK_NATIVE_WINDOW_POINTER
#DEFINE GDK_GPOINTER_TO_NATIVE_WINDOW(p) GPOINTER_TO_UINT(p)
#ENDIF ' GDK_NATIVE_WINDOW_POINTER

#DEFINE _GDK_MAKE_ATOM(val) ((GdkAtom)GUINT_TO_POINTER(val))
#DEFINE GDK_NONE _GDK_MAKE_ATOM (0)

#IFDEF GDK_NATIVE_WINDOW_POINTER

TYPE GdkNativeWindow AS gpointer

#ELSE ' GDK_NATIVE_WINDOW_POINTER

TYPE GdkNativeWindow AS guint32

#ENDIF ' GDK_NATIVE_WINDOW_POINTER

TYPE GdkColor AS _GdkColor
TYPE GdkColormap AS _GdkColormap
TYPE GdkCursor AS _GdkCursor
TYPE GdkFont AS _GdkFont
TYPE GdkGC AS _GdkGC
TYPE GdkImage AS _GdkImage
TYPE GdkRegion AS _GdkRegion
TYPE GdkVisual AS _GdkVisual
TYPE GdkDrawable AS _GdkDrawable
TYPE GdkBitmap AS _GdkDrawable
TYPE GdkPixmap AS _GdkDrawable
TYPE GdkWindow AS _GdkDrawable
TYPE GdkDisplay AS _GdkDisplay
TYPE GdkScreen AS _GdkScreen

ENUM GdkByteOrder
  GDK_LSB_FIRST
  GDK_MSB_FIRST
END ENUM

ENUM GdkModifierType
  GDK_SHIFT_MASK = 1 SHL 0
  GDK_LOCK_MASK = 1 SHL 1
  GDK_CONTROL_MASK = 1 SHL 2
  GDK_MOD1_MASK = 1 SHL 3
  GDK_MOD2_MASK = 1 SHL 4
  GDK_MOD3_MASK = 1 SHL 5
  GDK_MOD4_MASK = 1 SHL 6
  GDK_MOD5_MASK = 1 SHL 7
  GDK_BUTTON1_MASK = 1 SHL 8
  GDK_BUTTON2_MASK = 1 SHL 9
  GDK_BUTTON3_MASK = 1 SHL 10
  GDK_BUTTON4_MASK = 1 SHL 11
  GDK_BUTTON5_MASK = 1 SHL 12
  GDK_SUPER_MASK = 1 SHL 26
  GDK_HYPER_MASK = 1 SHL 27
  GDK_META_MASK = 1 SHL 28
  GDK_RELEASE_MASK = 1 SHL 30
  GDK_MODIFIER_MASK = &h5C001FFF
END ENUM

ENUM GdkInputCondition
  GDK_INPUT_READ = 1 SHL 0
  GDK_INPUT_WRITE = 1 SHL 1
  GDK_INPUT_EXCEPTION = 1 SHL 2
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

TYPE GdkInputFunction AS SUB(BYVAL AS gpointer, BYVAL AS gint, BYVAL AS GdkInputCondition)

#IFNDEF GDK_DISABLE_DEPRECATED

TYPE GdkDestroyNotify AS SUB(BYVAL AS gpointer)

#ENDIF ' GDK_DISABLE_DEPRECATED

TYPE _GdkPoint
  AS gint x
  AS gint y
END TYPE

TYPE _GdkRectangle
  AS gint x
  AS gint y
  AS gint width
  AS gint height
END TYPE

TYPE _GdkSegment
  AS gint x1
  AS gint y1
  AS gint x2
  AS gint y2
END TYPE

TYPE _GdkSpan
  AS gint x
  AS gint y
  AS gint width
END TYPE

#ENDIF ' __GDK_TYPES_H__

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

TYPE GdkColormapClass AS _GdkColormapClass

#DEFINE GDK_TYPE_COLORMAP (gdk_colormap_get_type ())
#DEFINE GDK_COLORMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_COLORMAP, GdkColormap))
#DEFINE GDK_COLORMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_COLORMAP, GdkColormapClass))
#DEFINE GDK_IS_COLORMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_COLORMAP))
#DEFINE GDK_IS_COLORMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_COLORMAP))
#DEFINE GDK_COLORMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_COLORMAP, GdkColormapClass))
#DEFINE GDK_TYPE_COLOR (gdk_color_get_type ())

TYPE _GdkColormap
  AS GObject parent_instance
  AS gint size
  AS GdkColor PTR colors
  AS GdkVisual PTR visual
  AS gpointer windowing_data
END TYPE

TYPE _GdkColormapClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION gdk_colormap_get_type() AS GType
DECLARE FUNCTION gdk_colormap_new(BYVAL AS GdkVisual PTR, BYVAL AS gboolean) AS GdkColormap PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_colormap_ref(BYVAL AS GdkColormap PTR) AS GdkColormap PTR
DECLARE SUB gdk_colormap_unref(BYVAL AS GdkColormap PTR)

#ENDIF ' GDK_DISABLE_DEPRECATED

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_colormap_get_system() AS GdkColormap PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_colormap_get_screen(BYVAL AS GdkColormap PTR) AS GdkScreen PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_colormap_get_system_size() AS gint

#ENDIF ' GDK_DISABLE_DEPRECATED

#IF NOT DEFINED (GDK_DISABLE_DEPRECATED) OR DEFINED (GDK_COMPILATION)

DECLARE SUB gdk_colormap_change(BYVAL AS GdkColormap PTR, BYVAL AS gint)

#ENDIF ' NOT DEFINED (GD...

DECLARE FUNCTION gdk_colormap_alloc_colors(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR, BYVAL AS gint, BYVAL AS gboolean, BYVAL AS gboolean, BYVAL AS gboolean PTR) AS gint
DECLARE FUNCTION gdk_colormap_alloc_color(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR, BYVAL AS gboolean, BYVAL AS gboolean) AS gboolean
DECLARE SUB gdk_colormap_free_colors(BYVAL AS GdkColormap PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS gint)
DECLARE SUB gdk_colormap_query_color(BYVAL AS GdkColormap PTR, BYVAL AS gulong, BYVAL AS GdkColor PTR)
DECLARE FUNCTION gdk_colormap_get_visual(BYVAL AS GdkColormap PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_color_copy(BYVAL AS CONST GdkColor PTR) AS GdkColor PTR
DECLARE SUB gdk_color_free(BYVAL AS GdkColor PTR)
DECLARE FUNCTION gdk_color_parse(BYVAL AS CONST gchar PTR, BYVAL AS GdkColor PTR) AS gboolean
DECLARE FUNCTION gdk_color_hash(BYVAL AS CONST GdkColor PTR) AS guint
DECLARE FUNCTION gdk_color_equal(BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR) AS gboolean
DECLARE FUNCTION gdk_color_to_string(BYVAL AS CONST GdkColor PTR) AS gchar PTR
DECLARE FUNCTION gdk_color_get_type() AS GType

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_colors_store(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR, BYVAL AS gint)
DECLARE FUNCTION gdk_color_white(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR) AS gint
DECLARE FUNCTION gdk_color_black(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR) AS gint
DECLARE FUNCTION gdk_color_alloc(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR) AS gint
DECLARE FUNCTION gdk_color_change(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR) AS gint

#ENDIF ' GDK_DISABLE_DEPRECATED

#IF NOT DEFINED (GDK_DISABLE_DEPRECATED) OR DEFINED (GDK_COMPILATION)

DECLARE FUNCTION gdk_colors_alloc(BYVAL AS GdkColormap PTR, BYVAL AS gboolean, BYVAL AS gulong PTR, BYVAL AS gint, BYVAL AS gulong PTR, BYVAL AS gint) AS gint
DECLARE SUB gdk_colors_free(BYVAL AS GdkColormap PTR, BYVAL AS gulong PTR, BYVAL AS gint, BYVAL AS gulong)

#ENDIF ' NOT DEFINED (GD...
#ENDIF ' __GDK_COLOR_H__

#IFNDEF __GDK_DND_H__
#DEFINE __GDK_DND_H__

TYPE GdkDragContext AS _GdkDragContext

ENUM GdkDragAction
  GDK_ACTION_DEFAULT = 1 SHL 0
  GDK_ACTION_COPY = 1 SHL 1
  GDK_ACTION_MOVE = 1 SHL 2
  GDK_ACTION_LINK = 1 SHL 3
  GDK_ACTION_PRIVATE = 1 SHL 4
  GDK_ACTION_ASK = 1 SHL 5
END ENUM

ENUM GdkDragProtocol
  GDK_DRAG_PROTO_MOTIF
  GDK_DRAG_PROTO_XDND
  GDK_DRAG_PROTO_ROOTWIN
  GDK_DRAG_PROTO_NONE
  GDK_DRAG_PROTO_WIN32_DROPFILES
  GDK_DRAG_PROTO_OLE2
  GDK_DRAG_PROTO_LOCAL
END ENUM

TYPE GdkDragContextClass AS _GdkDragContextClass

#DEFINE GDK_TYPE_DRAG_CONTEXT (gdk_drag_context_get_type ())
#DEFINE GDK_DRAG_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DRAG_CONTEXT, GdkDragContext))
#DEFINE GDK_DRAG_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DRAG_CONTEXT, GdkDragContextClass))
#DEFINE GDK_IS_DRAG_CONTEXT(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DRAG_CONTEXT))
#DEFINE GDK_IS_DRAG_CONTEXT_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DRAG_CONTEXT))
#DEFINE GDK_DRAG_CONTEXT_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DRAG_CONTEXT, GdkDragContextClass))

TYPE _GdkDragContext
  AS GObject parent_instance
  AS GdkDragProtocol protocol
  AS gboolean is_source
  AS GdkWindow PTR source_window
  AS GdkWindow PTR dest_window
  AS GList PTR targets
  AS GdkDragAction actions
  AS GdkDragAction suggested_action
  AS GdkDragAction action
  AS guint32 start_time
  AS gpointer windowing_data
END TYPE

TYPE _GdkDragContextClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION gdk_drag_context_get_type() AS GType

#IF NOT DEFINED (GDK_DISABLE_DEPRECATED) OR DEFINED (GDK_COMPILATION)

DECLARE FUNCTION gdk_drag_context_new() AS GdkDragContext PTR

#ENDIF ' NOT DEFINED (GD...

DECLARE FUNCTION gdk_drag_context_list_targets(BYVAL AS GdkDragContext PTR) AS GList PTR
DECLARE FUNCTION gdk_drag_context_get_actions(BYVAL AS GdkDragContext PTR) AS GdkDragAction
DECLARE FUNCTION gdk_drag_context_get_suggested_action(BYVAL AS GdkDragContext PTR) AS GdkDragAction
DECLARE FUNCTION gdk_drag_context_get_selected_action(BYVAL AS GdkDragContext PTR) AS GdkDragAction
DECLARE FUNCTION gdk_drag_context_get_source_window(BYVAL AS GdkDragContext PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_drag_context_get_dest_window(BYVAL AS GdkDragContext PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_drag_context_get_protocol(BYVAL AS GdkDragContext PTR) AS GdkDragProtocol

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_drag_context_ref(BYVAL AS GdkDragContext PTR)
DECLARE SUB gdk_drag_context_unref(BYVAL AS GdkDragContext PTR)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_drag_status_ ALIAS "gdk_drag_status"(BYVAL AS GdkDragContext PTR, BYVAL AS GdkDragAction, BYVAL AS guint32)
DECLARE SUB gdk_drop_reply(BYVAL AS GdkDragContext PTR, BYVAL AS gboolean, BYVAL AS guint32)
DECLARE SUB gdk_drop_finish(BYVAL AS GdkDragContext PTR, BYVAL AS gboolean, BYVAL AS guint32)
DECLARE FUNCTION gdk_drag_get_selection(BYVAL AS GdkDragContext PTR) AS GdkAtom
DECLARE FUNCTION gdk_drag_begin(BYVAL AS GdkWindow PTR, BYVAL AS GList PTR) AS GdkDragContext PTR
DECLARE FUNCTION gdk_drag_get_protocol_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkNativeWindow, BYVAL AS GdkDragProtocol PTR) AS GdkNativeWindow
DECLARE SUB gdk_drag_find_window_for_screen(BYVAL AS GdkDragContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkWindow PTR PTR, BYVAL AS GdkDragProtocol PTR)

#IFNDEF GDK_MULTIHEAD_SAFE
#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_drag_get_protocol(BYVAL AS GdkNativeWindow, BYVAL AS GdkDragProtocol PTR) AS GdkNativeWindow
DECLARE SUB gdk_drag_find_window(BYVAL AS GdkDragContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkWindow PTR PTR, BYVAL AS GdkDragProtocol PTR)

#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_drag_motion_ ALIAS "gdk_drag_motion"(BYVAL AS GdkDragContext PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkDragProtocol, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkDragAction, BYVAL AS GdkDragAction, BYVAL AS guint32) AS gboolean
DECLARE SUB gdk_drag_drop(BYVAL AS GdkDragContext PTR, BYVAL AS guint32)
DECLARE SUB gdk_drag_abort(BYVAL AS GdkDragContext PTR, BYVAL AS guint32)
DECLARE FUNCTION gdk_drag_drop_succeeded(BYVAL AS GdkDragContext PTR) AS gboolean

#ENDIF ' __GDK_DND_H__

#IFNDEF __GDK_INPUT_H__
#DEFINE __GDK_INPUT_H__

#DEFINE GDK_TYPE_DEVICE (gdk_device_get_type ())
#DEFINE GDK_DEVICE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DEVICE, GdkDevice))
#DEFINE GDK_DEVICE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DEVICE, GdkDeviceClass))
#DEFINE GDK_IS_DEVICE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DEVICE))
#DEFINE GDK_IS_DEVICE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DEVICE))
#DEFINE GDK_DEVICE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DEVICE, GdkDeviceClass))

TYPE GdkDeviceKey AS _GdkDeviceKey
TYPE GdkDeviceAxis AS _GdkDeviceAxis
TYPE GdkDevice AS _GdkDevice
TYPE GdkDeviceClass AS _GdkDeviceClass
TYPE GdkTimeCoord AS _GdkTimeCoord

ENUM GdkExtensionMode
  GDK_EXTENSION_EVENTS_NONE
  GDK_EXTENSION_EVENTS_ALL
  GDK_EXTENSION_EVENTS_CURSOR
END ENUM

ENUM GdkInputSource
  GDK_SOURCE_MOUSE
  GDK_SOURCE_PEN
  GDK_SOURCE_ERASER
  GDK_SOURCE_CURSOR
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

TYPE _GdkDeviceKey
  AS guint keyval
  AS GdkModifierType modifiers
END TYPE

TYPE _GdkDeviceAxis
  AS GdkAxisUse use
  AS gdouble min
  AS gdouble max
END TYPE

TYPE _GdkDevice
  AS GObject parent_instance
  AS gchar PTR name
  AS GdkInputSource source
  AS GdkInputMode mode
  AS gboolean has_cursor
  AS gint num_axes
  AS GdkDeviceAxis PTR axes
  AS gint num_keys
  AS GdkDeviceKey PTR keys
END TYPE

#DEFINE GDK_MAX_TIMECOORD_AXES 128

TYPE _GdkTimeCoord
  AS guint32 time
  AS gdouble axes(GDK_MAX_TIMECOORD_AXES-1)
END TYPE

DECLARE FUNCTION gdk_device_get_type() AS GType

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_devices_list() AS GList PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_device_get_name(BYVAL AS GdkDevice PTR) AS CONST gchar PTR

DECLARE FUNCTION gdk_device_get_source(BYVAL AS GdkDevice PTR) AS GdkInputSource
DECLARE FUNCTION gdk_device_get_mode(BYVAL AS GdkDevice PTR) AS GdkInputMode
DECLARE FUNCTION gdk_device_get_has_cursor(BYVAL AS GdkDevice PTR) AS gboolean
DECLARE SUB gdk_device_get_key(BYVAL AS GdkDevice PTR, BYVAL AS guint, BYVAL AS guint PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gdk_device_get_axis_use(BYVAL AS GdkDevice PTR, BYVAL AS guint) AS GdkAxisUse
DECLARE FUNCTION gdk_device_get_n_keys(BYVAL AS GdkDevice PTR) AS gint
DECLARE FUNCTION gdk_device_get_n_axes(BYVAL AS GdkDevice PTR) AS gint
DECLARE SUB gdk_device_set_source(BYVAL AS GdkDevice PTR, BYVAL AS GdkInputSource)
DECLARE FUNCTION gdk_device_set_mode(BYVAL AS GdkDevice PTR, BYVAL AS GdkInputMode) AS gboolean
DECLARE SUB gdk_device_set_key(BYVAL AS GdkDevice PTR, BYVAL AS guint, BYVAL AS guint, BYVAL AS GdkModifierType)
DECLARE SUB gdk_device_set_axis_use(BYVAL AS GdkDevice PTR, BYVAL AS guint, BYVAL AS GdkAxisUse)
DECLARE SUB gdk_device_get_state(BYVAL AS GdkDevice PTR, BYVAL AS GdkWindow PTR, BYVAL AS gdouble PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gdk_device_get_history(BYVAL AS GdkDevice PTR, BYVAL AS GdkWindow PTR, BYVAL AS guint32, BYVAL AS guint32, BYVAL AS GdkTimeCoord PTR PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gdk_device_free_history(BYVAL AS GdkTimeCoord PTR PTR, BYVAL AS gint)
DECLARE FUNCTION gdk_device_get_axis(BYVAL AS GdkDevice PTR, BYVAL AS gdouble PTR, BYVAL AS GdkAxisUse, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB gdk_input_set_extension_events(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS GdkExtensionMode)

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_device_get_core_pointer() AS GdkDevice PTR

#ENDIF ' GDK_MULTIHEAD_SAFE
#ENDIF ' __GDK_INPUT_H__

#DEFINE GDK_TYPE_EVENT (gdk_event_get_type ())
#DEFINE GDK_PRIORITY_EVENTS (G_PRIORITY_DEFAULT)
#DEFINE GDK_PRIORITY_REDRAW (G_PRIORITY_HIGH_IDLE + 20)

TYPE GdkEventAny AS _GdkEventAny
TYPE GdkEventExpose AS _GdkEventExpose
TYPE GdkEventNoExpose AS _GdkEventNoExpose
TYPE GdkEventVisibility AS _GdkEventVisibility
TYPE GdkEventMotion AS _GdkEventMotion
TYPE GdkEventButton AS _GdkEventButton
TYPE GdkEventScroll AS _GdkEventScroll
TYPE GdkEventKey AS _GdkEventKey
TYPE GdkEventFocus AS _GdkEventFocus
TYPE GdkEventCrossing AS _GdkEventCrossing
TYPE GdkEventConfigure AS _GdkEventConfigure
TYPE GdkEventProperty AS _GdkEventProperty
TYPE GdkEventSelection AS _GdkEventSelection
TYPE GdkEventOwnerChange AS _GdkEventOwnerChange
TYPE GdkEventProximity AS _GdkEventProximity
TYPE GdkEventClient AS _GdkEventClient
TYPE GdkEventDND AS _GdkEventDND
TYPE GdkEventWindowState AS _GdkEventWindowState
TYPE GdkEventSetting AS _GdkEventSetting
TYPE GdkEventGrabBroken AS _GdkEventGrabBroken
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
  GDK_DRAG_MOTION = 24
  GDK_DRAG_STATUS = 25
  GDK_DROP_START = 26
  GDK_DROP_FINISHED = 27
  GDK_CLIENT_EVENT = 28
  GDK_VISIBILITY_NOTIFY = 29
  GDK_NO_EXPOSE = 30
  GDK_SCROLL = 31
  GDK_WINDOW_STATE = 32
  GDK_SETTING = 33
  GDK_OWNER_CHANGE = 34
  GDK_GRAB_BROKEN = 35
  GDK_DAMAGE = 36
  GDK_EVENT_LAST
END ENUM

ENUM GdkEventMask
  GDK_EXPOSURE_MASK = 1 SHL 1
  GDK_POINTER_MOTION_MASK = 1 SHL 2
  GDK_POINTER_MOTION_HINT_MASK = 1 SHL 3
  GDK_BUTTON_MOTION_MASK = 1 SHL 4
  GDK_BUTTON1_MOTION_MASK = 1 SHL 5
  GDK_BUTTON2_MOTION_MASK = 1 SHL 6
  GDK_BUTTON3_MOTION_MASK = 1 SHL 7
  GDK_BUTTON_PRESS_MASK = 1 SHL 8
  GDK_BUTTON_RELEASE_MASK = 1 SHL 9
  GDK_KEY_PRESS_MASK = 1 SHL 10
  GDK_KEY_RELEASE_MASK = 1 SHL 11
  GDK_ENTER_NOTIFY_MASK = 1 SHL 12
  GDK_LEAVE_NOTIFY_MASK = 1 SHL 13
  GDK_FOCUS_CHANGE_MASK = 1 SHL 14
  GDK_STRUCTURE_MASK = 1 SHL 15
  GDK_PROPERTY_CHANGE_MASK = 1 SHL 16
  GDK_VISIBILITY_NOTIFY_MASK = 1 SHL 17
  GDK_PROXIMITY_IN_MASK = 1 SHL 18
  GDK_PROXIMITY_OUT_MASK = 1 SHL 19
  GDK_SUBSTRUCTURE_MASK = 1 SHL 20
  GDK_SCROLL_MASK = 1 SHL 21
  GDK_ALL_EVENTS_MASK = &h3FFFFE
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
END ENUM

ENUM GdkPropertyState
  GDK_PROPERTY_NEW_VALUE
  GDK_PROPERTY_DELETE
END ENUM

ENUM GdkWindowState
  GDK_WINDOW_STATE_WITHDRAWN = 1 SHL 0
  GDK_WINDOW_STATE_ICONIFIED = 1 SHL 1
  GDK_WINDOW_STATE_MAXIMIZED = 1 SHL 2
  GDK_WINDOW_STATE_STICKY = 1 SHL 3
  GDK_WINDOW_STATE_FULLSCREEN = 1 SHL 4
  GDK_WINDOW_STATE_ABOVE = 1 SHL 5
  GDK_WINDOW_STATE_BELOW = 1 SHL 6
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
  AS GdkRegion PTR region
  AS gint count
END TYPE

TYPE _GdkEventNoExpose
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
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
  AS GdkNativeWindow requestor
END TYPE

TYPE _GdkEventOwnerChange
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkNativeWindow owner
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

UNION _GdkEventClient_data
  AS ZSTRING*20 b
  AS SHORT s(9)
  AS INTEGER l(4)
END UNION

TYPE _GdkEventClient
  AS GdkEventType type
  AS GdkWindow PTR window
  AS gint8 send_event
  AS GdkAtom message_type
  AS gushort data_format
  AS _GdkEventClient_data data
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
  AS GdkEventNoExpose no_expose
  AS GdkEventVisibility visibility
  AS GdkEventMotion motion
  AS GdkEventButton button
  AS GdkEventScroll scroll
  AS GdkEventKey key
  AS GdkEventCrossing crossing
  AS GdkEventFocus focus_change
  AS GdkEventConfigure configure
  AS GdkEventProperty property
  AS GdkEventSelection selection
  AS GdkEventOwnerChange owner_change
  AS GdkEventProximity proximity
  AS GdkEventClient client
  AS GdkEventDND dnd
  AS GdkEventWindowState window_state
  AS GdkEventSetting setting
  AS GdkEventGrabBroken grab_broken
END UNION

DECLARE FUNCTION gdk_event_get_type() AS GType
DECLARE FUNCTION gdk_events_pending() AS gboolean
DECLARE FUNCTION gdk_event_get() AS GdkEvent PTR
DECLARE FUNCTION gdk_event_peek() AS GdkEvent PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_event_get_graphics_expose(BYVAL AS GdkWindow PTR) AS GdkEvent PTR

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_event_put(BYVAL AS CONST GdkEvent PTR)
DECLARE FUNCTION gdk_event_new(BYVAL AS GdkEventType) AS GdkEvent PTR
DECLARE FUNCTION gdk_event_copy(BYVAL AS CONST GdkEvent PTR) AS GdkEvent PTR
DECLARE SUB gdk_event_free(BYVAL AS GdkEvent PTR)
DECLARE FUNCTION gdk_event_get_time(BYVAL AS CONST GdkEvent PTR) AS guint32
DECLARE FUNCTION gdk_event_get_state(BYVAL AS CONST GdkEvent PTR, BYVAL AS GdkModifierType PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_coords(BYVAL AS CONST GdkEvent PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_root_coords(BYVAL AS CONST GdkEvent PTR, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR) AS gboolean
DECLARE FUNCTION gdk_event_get_axis(BYVAL AS CONST GdkEvent PTR, BYVAL AS GdkAxisUse, BYVAL AS gdouble PTR) AS gboolean
DECLARE SUB gdk_event_request_motions(BYVAL AS CONST GdkEventMotion PTR)
DECLARE SUB gdk_event_handler_set(BYVAL AS GdkEventFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE SUB gdk_event_set_screen(BYVAL AS GdkEvent PTR, BYVAL AS GdkScreen PTR)
DECLARE FUNCTION gdk_event_get_screen(BYVAL AS CONST GdkEvent PTR) AS GdkScreen PTR
DECLARE SUB gdk_set_show_events(BYVAL AS gboolean)
DECLARE FUNCTION gdk_get_show_events() AS gboolean

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_add_client_message_filter(BYVAL AS GdkAtom, BYVAL AS GdkFilterFunc, BYVAL AS gpointer)
DECLARE FUNCTION gdk_setting_get(BYVAL AS CONST gchar PTR, BYVAL AS GValue PTR) AS gboolean

#ENDIF ' GDK_MULTIHEAD_SAFE
#ENDIF ' __GDK_EVENTS_H__

TYPE GdkDisplayClass AS _GdkDisplayClass
TYPE GdkDisplayPointerHooks AS _GdkDisplayPointerHooks

#DEFINE GDK_TYPE_DISPLAY (gdk_display_get_type ())
#DEFINE GDK_DISPLAY_OBJECT(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY, GdkDisplay))
#DEFINE GDK_DISPLAY_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DISPLAY, GdkDisplayClass))
#DEFINE GDK_IS_DISPLAY(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY))
#DEFINE GDK_IS_DISPLAY_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DISPLAY))
#DEFINE GDK_DISPLAY_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DISPLAY, GdkDisplayClass))

TYPE GdkKeyboardGrabInfo
  AS GdkWindow PTR window
  AS GdkWindow PTR native_window
  AS gulong serial
  AS gboolean owner_events
  AS guint32 time
END TYPE

TYPE GdkPointerWindowInfo
  AS GdkWindow PTR toplevel_under_pointer
  AS GdkWindow PTR window_under_pointer
  AS gdouble toplevel_x, toplevel_y
  AS guint32 state
  AS guint32 button
  AS gulong motion_hint_serial
END TYPE

TYPE _GdkDisplay
  AS GObject parent_instance
  AS GList PTR queued_events
  AS GList PTR queued_tail
  AS guint32 button_click_time(1)
  AS GdkWindow PTR button_window(1)
  AS gint button_number(1)
  AS guint double_click_time
  AS GdkDevice PTR core_pointer
  AS CONST GdkDisplayPointerHooks PTR pointer_hooks
  AS guint closed : 1
  AS guint ignore_core_events : 1
  AS guint double_click_distance
  AS gint button_x(1)
  AS gint button_y(1)
  AS GList PTR pointer_grabs
  AS GdkKeyboardGrabInfo keyboard_grab
  AS GdkPointerWindowInfo pointer_info
  AS guint32 last_event_time
END TYPE

TYPE _GdkDisplayClass
  AS GObjectClass parent_class
  get_display_name AS FUNCTION(BYVAL AS GdkDisplay PTR) AS CONST gchar PTR
  get_n_screens AS FUNCTION(BYVAL AS GdkDisplay PTR) AS gint
  get_screen AS FUNCTION(BYVAL AS GdkDisplay PTR, BYVAL AS gint) AS GdkScreen PTR
  get_default_screen AS FUNCTION(BYVAL AS GdkDisplay PTR) AS GdkScreen PTR
  closed AS SUB(BYVAL AS GdkDisplay PTR, BYVAL AS gboolean)
END TYPE

TYPE _GdkDisplayPointerHooks
  get_pointer AS SUB(BYVAL AS GdkDisplay PTR, BYVAL AS GdkScreen PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR)
  window_get_pointer AS FUNCTION(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR) AS GdkWindow PTR
  window_at_pointer AS FUNCTION(BYVAL AS GdkDisplay PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR
END TYPE

DECLARE FUNCTION gdk_display_get_type() AS GType
DECLARE FUNCTION gdk_display_open(BYVAL AS CONST gchar PTR) AS GdkDisplay PTR

DECLARE FUNCTION gdk_display_get_name(BYVAL AS GdkDisplay PTR) AS CONST gchar PTR

DECLARE FUNCTION gdk_display_get_n_screens(BYVAL AS GdkDisplay PTR) AS gint
DECLARE FUNCTION gdk_display_get_screen(BYVAL AS GdkDisplay PTR, BYVAL AS gint) AS GdkScreen PTR
DECLARE FUNCTION gdk_display_get_default_screen(BYVAL AS GdkDisplay PTR) AS GdkScreen PTR
DECLARE SUB gdk_display_pointer_ungrab(BYVAL AS GdkDisplay PTR, BYVAL AS guint32)
DECLARE SUB gdk_display_keyboard_ungrab(BYVAL AS GdkDisplay PTR, BYVAL AS guint32)
DECLARE FUNCTION gdk_display_pointer_is_grabbed(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE SUB gdk_display_beep(BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_display_sync(BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_display_flush(BYVAL AS GdkDisplay PTR)
DECLARE SUB gdk_display_close(BYVAL AS GdkDisplay PTR)
DECLARE FUNCTION gdk_display_is_closed(BYVAL AS GdkDisplay PTR) AS gboolean
DECLARE FUNCTION gdk_display_list_devices(BYVAL AS GdkDisplay PTR) AS GList PTR
DECLARE FUNCTION gdk_display_get_event(BYVAL AS GdkDisplay PTR) AS GdkEvent PTR
DECLARE FUNCTION gdk_display_peek_event(BYVAL AS GdkDisplay PTR) AS GdkEvent PTR
DECLARE SUB gdk_display_put_event(BYVAL AS GdkDisplay PTR, BYVAL AS CONST GdkEvent PTR)
DECLARE SUB gdk_display_add_client_message_filter(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom, BYVAL AS GdkFilterFunc, BYVAL AS gpointer)
DECLARE SUB gdk_display_set_double_click_time(BYVAL AS GdkDisplay PTR, BYVAL AS guint)
DECLARE SUB gdk_display_set_double_click_distance(BYVAL AS GdkDisplay PTR, BYVAL AS guint)
DECLARE FUNCTION gdk_display_get_default() AS GdkDisplay PTR
DECLARE FUNCTION gdk_display_get_core_pointer(BYVAL AS GdkDisplay PTR) AS GdkDevice PTR
DECLARE SUB gdk_display_get_pointer(BYVAL AS GdkDisplay PTR, BYVAL AS GdkScreen PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gdk_display_get_window_at_pointer(BYVAL AS GdkDisplay PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR
DECLARE SUB gdk_display_warp_pointer(BYVAL AS GdkDisplay PTR, BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint)

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_display_set_pointer_hooks(BYVAL AS GdkDisplay PTR, BYVAL AS CONST GdkDisplayPointerHooks PTR) AS GdkDisplayPointerHooks PTR

#ENDIF ' GDK_DISABLE_DEPRECATED

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

#ENDIF ' __GDK_DISPLAY_H__

TYPE GdkScreenClass AS _GdkScreenClass

#DEFINE GDK_TYPE_SCREEN (gdk_screen_get_type ())
#DEFINE GDK_SCREEN(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_SCREEN, GdkScreen))
#DEFINE GDK_SCREEN_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_SCREEN, GdkScreenClass))
#DEFINE GDK_IS_SCREEN(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_SCREEN))
#DEFINE GDK_IS_SCREEN_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_SCREEN))
#DEFINE GDK_SCREEN_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_SCREEN, GdkScreenClass))

TYPE _GdkScreen
  AS GObject parent_instance
  AS guint closed : 1
  AS GdkGC PTR normal_gcs(31)
  AS GdkGC PTR exposure_gcs(31)
  AS GdkGC PTR subwindow_gcs(31)
  AS cairo_font_options_t PTR font_options
  AS DOUBLE resolution
END TYPE

TYPE _GdkScreenClass
  AS GObjectClass parent_class
  size_changed AS SUB(BYVAL AS GdkScreen PTR)
  composited_changed AS SUB(BYVAL AS GdkScreen PTR)
  monitors_changed AS SUB(BYVAL AS GdkScreen PTR)
END TYPE

DECLARE FUNCTION gdk_screen_get_type() AS GType
DECLARE FUNCTION gdk_screen_get_default_colormap(BYVAL AS GdkScreen PTR) AS GdkColormap PTR
DECLARE SUB gdk_screen_set_default_colormap(BYVAL AS GdkScreen PTR, BYVAL AS GdkColormap PTR)
DECLARE FUNCTION gdk_screen_get_system_colormap(BYVAL AS GdkScreen PTR) AS GdkColormap PTR
DECLARE FUNCTION gdk_screen_get_system_visual(BYVAL AS GdkScreen PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_screen_get_rgb_colormap(BYVAL AS GdkScreen PTR) AS GdkColormap PTR
DECLARE FUNCTION gdk_screen_get_rgb_visual(BYVAL AS GdkScreen PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_screen_get_rgba_colormap(BYVAL AS GdkScreen PTR) AS GdkColormap PTR
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
DECLARE FUNCTION gdk_screen_get_monitor_at_point(BYVAL AS GdkScreen PTR, BYVAL AS gint, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_at_window(BYVAL AS GdkScreen PTR, BYVAL AS GdkWindow PTR) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_width_mm(BYVAL AS GdkScreen PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_height_mm(BYVAL AS GdkScreen PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_screen_get_monitor_plug_name(BYVAL AS GdkScreen PTR, BYVAL AS gint) AS gchar PTR
DECLARE SUB gdk_screen_broadcast_client_message(BYVAL AS GdkScreen PTR, BYVAL AS GdkEvent PTR)
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
#DEFINE GDK_APP_LAUNCH_CONTEXT_CLASS(k) (G_TYPE_CHECK_CLASS_CAST((k), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContextClass))
#DEFINE GDK_IS_APP_LAUNCH_CONTEXT(o) (G_TYPE_CHECK_INSTANCE_TYPE ((o), GDK_TYPE_APP_LAUNCH_CONTEXT))
#DEFINE GDK_IS_APP_LAUNCH_CONTEXT_CLASS(k) (G_TYPE_CHECK_CLASS_TYPE ((k), GDK_TYPE_APP_LAUNCH_CONTEXT))
#DEFINE GDK_APP_LAUNCH_CONTEXT_GET_CLASS(o) (G_TYPE_INSTANCE_GET_CLASS ((o), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContextClass))

TYPE GdkAppLaunchContext AS _GdkAppLaunchContext
TYPE GdkAppLaunchContextClass AS _GdkAppLaunchContextClass
TYPE GdkAppLaunchContextPrivate AS _GdkAppLaunchContextPrivate

TYPE _GdkAppLaunchContext
  AS GAppLaunchContext parent_instance
  AS GdkAppLaunchContextPrivate PTR priv
END TYPE

TYPE _GdkAppLaunchContextClass
  AS GAppLaunchContextClass parent_class
END TYPE

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

#IFNDEF __GDK_PIXBUF_H__
#DEFINE __GDK_PIXBUF_H__

#IFNDEF __GDK_RGB_H__
#DEFINE __GDK_RGB_H__

TYPE GdkRgbCmap AS _GdkRgbCmap

ENUM GdkRgbDither
  GDK_RGB_DITHER_NONE
  GDK_RGB_DITHER_NORMAL
  GDK_RGB_DITHER_MAX
END ENUM

#IFNDEF GDK_DISABLE_DEPRECATED

TYPE _GdkRgbCmap
  AS guint32 colors(255)
  AS gint n_colors
  AS GSList PTR info_list
END TYPE

DECLARE SUB gdk_rgb_init()
DECLARE FUNCTION gdk_rgb_xpixel_from_rgb(BYVAL AS guint32) AS gulong
DECLARE SUB gdk_rgb_gc_set_foreground(BYVAL AS GdkGC PTR, BYVAL AS guint32)
DECLARE SUB gdk_rgb_gc_set_background(BYVAL AS GdkGC PTR, BYVAL AS guint32)

#DEFINE gdk_rgb_get_cmap gdk_rgb_get_colormap

DECLARE SUB gdk_rgb_find_color(BYVAL AS GdkColormap PTR, BYVAL AS GdkColor PTR)
DECLARE SUB gdk_draw_rgb_image(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS CONST guchar PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_rgb_image_dithalign(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_rgb_32_image(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS CONST guchar PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_rgb_32_image_dithalign(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_gray_image(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS CONST guchar PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_indexed_image(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS GdkRgbCmap PTR)
DECLARE FUNCTION gdk_rgb_cmap_new(BYVAL AS guint32 PTR, BYVAL AS gint) AS GdkRgbCmap PTR
DECLARE SUB gdk_rgb_cmap_free(BYVAL AS GdkRgbCmap PTR)
DECLARE SUB gdk_rgb_set_verbose(BYVAL AS gboolean)
DECLARE SUB gdk_rgb_set_install(BYVAL AS gboolean)
DECLARE SUB gdk_rgb_set_min_colors(BYVAL AS gint)

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_rgb_get_colormap() AS GdkColormap PTR
DECLARE FUNCTION gdk_rgb_get_visual() AS GdkVisual PTR
DECLARE FUNCTION gdk_rgb_ditherable() AS gboolean
DECLARE FUNCTION gdk_rgb_colormap_ditherable(BYVAL AS GdkColormap PTR) AS gboolean

#ENDIF ' GDK_MULTIHEAD_SAFE
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_RGB_H__

#INCLUDE ONCE "gdk-pixbuf/gdk-pixbuf.bi"

DECLARE SUB gdk_pixbuf_render_threshold_alpha(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkBitmap PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER)

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_pixbuf_render_to_drawable(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GdkRgbDither, BYVAL AS INTEGER, BYVAL AS INTEGER)
DECLARE SUB gdk_pixbuf_render_to_drawable_alpha(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkDrawable PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS GdkPixbufAlphaMode, BYVAL AS INTEGER, BYVAL AS GdkRgbDither, BYVAL AS INTEGER, BYVAL AS INTEGER)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_pixbuf_render_pixmap_and_mask_for_colormap(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkColormap PTR, BYVAL AS GdkPixmap PTR PTR, BYVAL AS GdkBitmap PTR PTR, BYVAL AS INTEGER)

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_pixbuf_render_pixmap_and_mask(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkPixmap PTR PTR, BYVAL AS GdkBitmap PTR PTR, BYVAL AS INTEGER)

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_pixbuf_get_from_drawable(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkDrawable PTR, BYVAL AS GdkColormap PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_pixbuf_get_from_image(BYVAL AS GdkPixbuf PTR, BYVAL AS GdkImage PTR, BYVAL AS GdkColormap PTR, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER, BYVAL AS INTEGER) AS GdkPixbuf PTR

#ENDIF ' __GDK_PIXBUF_H__

#INCLUDE ONCE "pango/pangocairo.bi"

DECLARE FUNCTION gdk_cairo_create(BYVAL AS GdkDrawable PTR) AS cairo_t PTR
DECLARE SUB gdk_cairo_reset_clip(BYVAL AS cairo_t PTR, BYVAL AS GdkDrawable PTR)
DECLARE SUB gdk_cairo_set_source_color(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_cairo_set_source_pixbuf(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkPixbuf PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB gdk_cairo_set_source_pixmap(BYVAL AS cairo_t PTR, BYVAL AS GdkPixmap PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB gdk_cairo_set_source_window(BYVAL AS cairo_t PTR, BYVAL AS GdkWindow PTR, BYVAL AS DOUBLE, BYVAL AS DOUBLE)
DECLARE SUB gdk_cairo_rectangle(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gdk_cairo_region(BYVAL AS cairo_t PTR, BYVAL AS CONST GdkRegion PTR)

#ENDIF ' __GDK_CAIRO_H__

#IFNDEF __GDK_CURSOR_H__
#DEFINE __GDK_CURSOR_H__

#DEFINE GDK_TYPE_CURSOR (gdk_cursor_get_type ())

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

TYPE _GdkCursor
  AS GdkCursorType type
  AS guint ref_count
END TYPE

DECLARE FUNCTION gdk_cursor_get_type() AS GType
DECLARE FUNCTION gdk_cursor_new_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkCursorType) AS GdkCursor PTR

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_cursor_new(BYVAL AS GdkCursorType) AS GdkCursor PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_cursor_new_from_pixmap(BYVAL AS GdkPixmap PTR, BYVAL AS GdkPixmap PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS gint, BYVAL AS gint) AS GdkCursor PTR
DECLARE FUNCTION gdk_cursor_new_from_pixbuf(BYVAL AS GdkDisplay PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gint, BYVAL AS gint) AS GdkCursor PTR
DECLARE FUNCTION gdk_cursor_get_display(BYVAL AS GdkCursor PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_cursor_ref(BYVAL AS GdkCursor PTR) AS GdkCursor PTR
DECLARE SUB gdk_cursor_unref(BYVAL AS GdkCursor PTR)
DECLARE FUNCTION gdk_cursor_new_from_name(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR) AS GdkCursor PTR
DECLARE FUNCTION gdk_cursor_get_image(BYVAL AS GdkCursor PTR) AS GdkPixbuf PTR
DECLARE FUNCTION gdk_cursor_get_cursor_type(BYVAL AS GdkCursor PTR) AS GdkCursorType

#IFNDEF GDK_DISABLE_DEPRECATED
#DEFINE gdk_cursor_destroy gdk_cursor_unref
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_CURSOR_H__

#IFNDEF __GDK_DISPLAY_MANAGER_H__
#DEFINE __GDK_DISPLAY_MANAGER_H__

TYPE GdkDisplayManager AS _GdkDisplayManager
TYPE GdkDisplayManagerClass AS _GdkDisplayManagerClass

#DEFINE GDK_TYPE_DISPLAY_MANAGER (gdk_display_manager_get_type ())
#DEFINE GDK_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManager))
#DEFINE GDK_DISPLAY_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManagerClass))
#DEFINE GDK_IS_DISPLAY_MANAGER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DISPLAY_MANAGER))
#DEFINE GDK_IS_DISPLAY_MANAGER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DISPLAY_MANAGER))
#DEFINE GDK_DISPLAY_MANAGER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManagerClass))

TYPE _GdkDisplayManagerClass
  AS GObjectClass parent_class
  display_opened AS SUB(BYVAL AS GdkDisplayManager PTR, BYVAL AS GdkDisplay PTR)
END TYPE

DECLARE FUNCTION gdk_display_manager_get_type() AS GType
DECLARE FUNCTION gdk_display_manager_get() AS GdkDisplayManager PTR
DECLARE FUNCTION gdk_display_manager_get_default_display(BYVAL AS GdkDisplayManager PTR) AS GdkDisplay PTR
DECLARE SUB gdk_display_manager_set_default_display(BYVAL AS GdkDisplayManager PTR, BYVAL AS GdkDisplay PTR)
DECLARE FUNCTION gdk_display_manager_list_displays(BYVAL AS GdkDisplayManager PTR) AS GSList PTR

#ENDIF ' __GDK_DISPLAY_MANAGER_H__

#IFNDEF __GDK_DRAWABLE_H__
#DEFINE __GDK_DRAWABLE_H__

#IFNDEF __GDK_GC_H__
#DEFINE __GDK_GC_H__

TYPE GdkGCValues AS _GdkGCValues
TYPE GdkGCClass AS _GdkGCClass

ENUM GdkCapStyle
  GDK_CAP_NOT_LAST
  GDK_CAP_BUTT
  GDK_CAP_ROUND
  GDK_CAP_PROJECTING
END ENUM

ENUM GdkFill
  GDK_SOLID
  GDK_TILED
  GDK_STIPPLED
  GDK_OPAQUE_STIPPLED
END ENUM

ENUM GdkFunction
  GDK_COPY
  GDK_INVERT
  GDK_XOR
  GDK_CLEAR
  GDK_AND
  GDK_AND_REVERSE
  GDK_AND_INVERT
  GDK_NOOP
  GDK_OR
  GDK_EQUIV
  GDK_OR_REVERSE
  GDK_COPY_INVERT
  GDK_OR_INVERT
  GDK_NAND
  GDK_NOR
  GDK_SET
END ENUM

ENUM GdkJoinStyle
  GDK_JOIN_MITER
  GDK_JOIN_ROUND
  GDK_JOIN_BEVEL
END ENUM

ENUM GdkLineStyle
  GDK_LINE_SOLID
  GDK_LINE_ON_OFF_DASH
  GDK_LINE_DOUBLE_DASH
END ENUM

ENUM GdkSubwindowMode
  GDK_CLIP_BY_CHILDREN = 0
  GDK_INCLUDE_INFERIORS = 1
END ENUM

ENUM GdkGCValuesMask
  GDK_GC_FOREGROUND = 1 SHL 0
  GDK_GC_BACKGROUND = 1 SHL 1
  GDK_GC_FONT = 1 SHL 2
  GDK_GC_FUNCTION = 1 SHL 3
  GDK_GC_FILL = 1 SHL 4
  GDK_GC_TILE = 1 SHL 5
  GDK_GC_STIPPLE = 1 SHL 6
  GDK_GC_CLIP_MASK = 1 SHL 7
  GDK_GC_SUBWINDOW = 1 SHL 8
  GDK_GC_TS_X_ORIGIN = 1 SHL 9
  GDK_GC_TS_Y_ORIGIN = 1 SHL 10
  GDK_GC_CLIP_X_ORIGIN = 1 SHL 11
  GDK_GC_CLIP_Y_ORIGIN = 1 SHL 12
  GDK_GC_EXPOSURES = 1 SHL 13
  GDK_GC_LINE_WIDTH = 1 SHL 14
  GDK_GC_LINE_STYLE = 1 SHL 15
  GDK_GC_CAP_STYLE = 1 SHL 16
  GDK_GC_JOIN_STYLE = 1 SHL 17
END ENUM

TYPE _GdkGCValues
  AS GdkColor foreground
  AS GdkColor background
  AS GdkFont PTR font
  AS GdkFunction function
  AS GdkFill fill
  AS GdkPixmap PTR tile
  AS GdkPixmap PTR stipple
  AS GdkPixmap PTR clip_mask
  AS GdkSubwindowMode subwindow_mode
  AS gint ts_x_origin
  AS gint ts_y_origin
  AS gint clip_x_origin
  AS gint clip_y_origin
  AS gint graphics_exposures
  AS gint line_width
  AS GdkLineStyle line_style
  AS GdkCapStyle cap_style
  AS GdkJoinStyle join_style
END TYPE

#DEFINE GDK_TYPE_GC (gdk_gc_get_type ())
#DEFINE GDK_GC(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_GC, GdkGC))
#DEFINE GDK_GC_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_GC, GdkGCClass))
#DEFINE GDK_IS_GC(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_GC))
#DEFINE GDK_IS_GC_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_GC))
#DEFINE GDK_GC_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_GC, GdkGCClass))

TYPE _GdkGC
  AS GObject parent_instance
  AS gint clip_x_origin
  AS gint clip_y_origin
  AS gint ts_x_origin
  AS gint ts_y_origin
  AS GdkColormap PTR colormap
END TYPE

TYPE _GdkGCClass
  AS GObjectClass parent_class
  get_values AS SUB(BYVAL AS GdkGC PTR, BYVAL AS GdkGCValues PTR)
  set_values AS SUB(BYVAL AS GdkGC PTR, BYVAL AS GdkGCValues PTR, BYVAL AS GdkGCValuesMask)
  set_dashes AS SUB(BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint8 PTR, BYVAL AS gint PTR)
  _gdk_reserved1 AS SUB()
  _gdk_reserved2 AS SUB()
  _gdk_reserved3 AS SUB()
  _gdk_reserved4 AS SUB()
END TYPE

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_gc_get_type() AS GType
DECLARE FUNCTION gdk_gc_new(BYVAL AS GdkDrawable PTR) AS GdkGC PTR
DECLARE FUNCTION gdk_gc_new_with_values(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGCValues PTR, BYVAL AS GdkGCValuesMask) AS GdkGC PTR
DECLARE FUNCTION gdk_gc_ref(BYVAL AS GdkGC PTR) AS GdkGC PTR
DECLARE SUB gdk_gc_unref(BYVAL AS GdkGC PTR)
DECLARE SUB gdk_gc_get_values(BYVAL AS GdkGC PTR, BYVAL AS GdkGCValues PTR)
DECLARE SUB gdk_gc_set_values(BYVAL AS GdkGC PTR, BYVAL AS GdkGCValues PTR, BYVAL AS GdkGCValuesMask)
DECLARE SUB gdk_gc_set_foreground(BYVAL AS GdkGC PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_gc_set_background(BYVAL AS GdkGC PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_gc_set_font(BYVAL AS GdkGC PTR, BYVAL AS GdkFont PTR)
DECLARE SUB gdk_gc_set_function(BYVAL AS GdkGC PTR, BYVAL AS GdkFunction)
DECLARE SUB gdk_gc_set_fill(BYVAL AS GdkGC PTR, BYVAL AS GdkFill)
DECLARE SUB gdk_gc_set_tile(BYVAL AS GdkGC PTR, BYVAL AS GdkPixmap PTR)
DECLARE SUB gdk_gc_set_stipple(BYVAL AS GdkGC PTR, BYVAL AS GdkPixmap PTR)
DECLARE SUB gdk_gc_set_ts_origin(BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_gc_set_clip_origin(BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_gc_set_clip_mask(BYVAL AS GdkGC PTR, BYVAL AS GdkBitmap PTR)
DECLARE SUB gdk_gc_set_clip_rectangle(BYVAL AS GdkGC PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gdk_gc_set_clip_region(BYVAL AS GdkGC PTR, BYVAL AS CONST GdkRegion PTR)
DECLARE SUB gdk_gc_set_subwindow(BYVAL AS GdkGC PTR, BYVAL AS GdkSubwindowMode)
DECLARE SUB gdk_gc_set_exposures(BYVAL AS GdkGC PTR, BYVAL AS gboolean)
DECLARE SUB gdk_gc_set_line_attributes(BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS GdkLineStyle, BYVAL AS GdkCapStyle, BYVAL AS GdkJoinStyle)
DECLARE SUB gdk_gc_set_dashes(BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint8 PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_gc_offset(BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_gc_copy(BYVAL AS GdkGC PTR, BYVAL AS GdkGC PTR)
DECLARE SUB gdk_gc_set_colormap(BYVAL AS GdkGC PTR, BYVAL AS GdkColormap PTR)
DECLARE FUNCTION gdk_gc_get_colormap(BYVAL AS GdkGC PTR) AS GdkColormap PTR
DECLARE SUB gdk_gc_set_rgb_fg_color(BYVAL AS GdkGC PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_gc_set_rgb_bg_color(BYVAL AS GdkGC PTR, BYVAL AS CONST GdkColor PTR)
DECLARE FUNCTION gdk_gc_get_screen(BYVAL AS GdkGC PTR) AS GdkScreen PTR

#DEFINE gdk_gc_destroy g_object_unref
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_GC_H__

TYPE GdkDrawableClass AS _GdkDrawableClass
TYPE GdkTrapezoid AS _GdkTrapezoid

#DEFINE GDK_TYPE_DRAWABLE (gdk_drawable_get_type ())
#DEFINE GDK_DRAWABLE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_DRAWABLE, GdkDrawable))
#DEFINE GDK_DRAWABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_DRAWABLE, GdkDrawableClass))
#DEFINE GDK_IS_DRAWABLE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_DRAWABLE))
#DEFINE GDK_IS_DRAWABLE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_DRAWABLE))
#DEFINE GDK_DRAWABLE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_DRAWABLE, GdkDrawableClass))

TYPE _GdkDrawable
  AS GObject parent_instance
END TYPE

TYPE _GdkDrawableClass
  AS GObjectClass parent_class
  create_gc AS FUNCTION(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGCValues PTR, BYVAL AS GdkGCValuesMask) AS GdkGC PTR
  draw_rectangle AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_arc AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_polygon AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gboolean, BYVAL AS GdkPoint PTR, BYVAL AS gint)
  draw_text AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkFont PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS gint)
  draw_text_wc AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkFont PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST GdkWChar PTR, BYVAL AS gint)
  draw_drawable AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  draw_points AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkPoint PTR, BYVAL AS gint)
  draw_segments AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkSegment PTR, BYVAL AS gint)
  draw_lines AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkPoint PTR, BYVAL AS gint)
  draw_glyphs AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS PangoFont PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoGlyphString PTR)
  draw_image AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkImage PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
  get_depth AS FUNCTION(BYVAL AS GdkDrawable PTR) AS gint
  get_size AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
  set_colormap AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkColormap PTR)
  get_colormap AS FUNCTION(BYVAL AS GdkDrawable PTR) AS GdkColormap PTR
  get_visual AS FUNCTION(BYVAL AS GdkDrawable PTR) AS GdkVisual PTR
  get_screen AS FUNCTION(BYVAL AS GdkDrawable PTR) AS GdkScreen PTR
  get_image AS FUNCTION(BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR
  get_clip_region AS FUNCTION(BYVAL AS GdkDrawable PTR) AS GdkRegion PTR
  get_visible_region AS FUNCTION(BYVAL AS GdkDrawable PTR) AS GdkRegion PTR
  get_composite_drawable AS FUNCTION(BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkDrawable PTR
  draw_pixbuf AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkPixbuf PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS gint, BYVAL AS gint)
  _copy_to_image AS FUNCTION(BYVAL AS GdkDrawable PTR, BYVAL AS GdkImage PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR
  draw_glyphs_transformed AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS PangoMatrix PTR, BYVAL AS PangoFont PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoGlyphString PTR)
  draw_trapezoids AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkTrapezoid PTR, BYVAL AS gint)
  ref_cairo_surface AS FUNCTION(BYVAL AS GdkDrawable PTR) AS cairo_surface_t PTR
  get_source_drawable AS FUNCTION(BYVAL AS GdkDrawable PTR) AS GdkDrawable PTR
  set_cairo_clip AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS cairo_t PTR)
  create_cairo_surface AS FUNCTION(BYVAL AS GdkDrawable PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS cairo_surface_t PTR
  draw_drawable_with_src AS SUB(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkDrawable PTR)
  _gdk_reserved7 AS SUB()
  _gdk_reserved9 AS SUB()
  _gdk_reserved10 AS SUB()
  _gdk_reserved11 AS SUB()
  _gdk_reserved12 AS SUB()
  _gdk_reserved13 AS SUB()
  _gdk_reserved14 AS SUB()
  _gdk_reserved15 AS SUB()
END TYPE

TYPE _GdkTrapezoid
  AS DOUBLE y1, x11, x21, y2, x12, x22
END TYPE

DECLARE FUNCTION gdk_drawable_get_type() AS GType

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_drawable_set_data(BYVAL AS GdkDrawable PTR, BYVAL AS CONST gchar PTR, BYVAL AS gpointer, BYVAL AS GDestroyNotify)
DECLARE FUNCTION gdk_drawable_get_data(BYVAL AS GdkDrawable PTR, BYVAL AS CONST gchar PTR) AS gpointer

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_drawable_set_colormap(BYVAL AS GdkDrawable PTR, BYVAL AS GdkColormap PTR)
DECLARE FUNCTION gdk_drawable_get_colormap(BYVAL AS GdkDrawable PTR) AS GdkColormap PTR
DECLARE FUNCTION gdk_drawable_get_depth(BYVAL AS GdkDrawable PTR) AS gint

#IF NOT DEFINED (GDK_DISABLE_DEPRECATED)

DECLARE SUB gdk_drawable_get_size(BYVAL AS GdkDrawable PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_drawable_get_visual(BYVAL AS GdkDrawable PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_drawable_get_screen(BYVAL AS GdkDrawable PTR) AS GdkScreen PTR
DECLARE FUNCTION gdk_drawable_get_display(BYVAL AS GdkDrawable PTR) AS GdkDisplay PTR

#ENDIF ' NOT DEFINED (GD...

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_drawable_ref(BYVAL AS GdkDrawable PTR) AS GdkDrawable PTR
DECLARE SUB gdk_drawable_unref(BYVAL AS GdkDrawable PTR)

#ENDIF ' GDK_DISABLE_DEPRECATED

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_draw_point(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_line(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_rectangle(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_arc(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gboolean, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_polygon(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gboolean, BYVAL AS CONST GdkPoint PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_string(BYVAL AS GdkDrawable PTR, BYVAL AS GdkFont PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_draw_text(BYVAL AS GdkDrawable PTR, BYVAL AS GdkFont PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gchar PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_text_wc(BYVAL AS GdkDrawable PTR, BYVAL AS GdkFont PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST GdkWChar PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_drawable(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_image(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS GdkImage PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_points(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS CONST GdkPoint PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_segments(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS CONST GdkSegment PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_lines(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS CONST GdkPoint PTR, BYVAL AS gint)
DECLARE SUB gdk_draw_pixbuf(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS CONST GdkPixbuf PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS GdkRgbDither, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_draw_glyphs(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS PangoFont PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoGlyphString PTR)
DECLARE SUB gdk_draw_layout_line(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoLayoutLine PTR)
DECLARE SUB gdk_draw_layout(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoLayout PTR)
DECLARE SUB gdk_draw_layout_line_with_colors(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoLayoutLine PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_draw_layout_with_colors(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoLayout PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_draw_glyphs_transformed(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS CONST PangoMatrix PTR, BYVAL AS PangoFont PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS PangoGlyphString PTR)
DECLARE SUB gdk_draw_trapezoids(BYVAL AS GdkDrawable PTR, BYVAL AS GdkGC PTR, BYVAL AS CONST GdkTrapezoid PTR, BYVAL AS gint)

#DEFINE gdk_draw_pixmap gdk_draw_drawable
#DEFINE gdk_draw_bitmap gdk_draw_drawable

DECLARE FUNCTION gdk_drawable_get_image(BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR
DECLARE FUNCTION gdk_drawable_copy_to_image(BYVAL AS GdkDrawable PTR, BYVAL AS GdkImage PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_drawable_get_clip_region(BYVAL AS GdkDrawable PTR) AS GdkRegion PTR
DECLARE FUNCTION gdk_drawable_get_visible_region(BYVAL AS GdkDrawable PTR) AS GdkRegion PTR

#ENDIF ' __GDK_DRAWABLE_H__

#IFNDEF __GDK_ENUM_TYPES_H__
#DEFINE __GDK_ENUM_TYPES_H__

DECLARE FUNCTION gdk_cursor_type_get_type() AS GType
#DEFINE GDK_TYPE_CURSOR_TYPE (gdk_cursor_type_get_type ())
DECLARE FUNCTION gdk_drag_action_get_type() AS GType
#DEFINE GDK_TYPE_DRAG_ACTION (gdk_drag_action_get_type ())
DECLARE FUNCTION gdk_drag_protocol_get_type() AS GType
#DEFINE GDK_TYPE_DRAG_PROTOCOL (gdk_drag_protocol_get_type ())
DECLARE FUNCTION gdk_filter_return_get_type() AS GType
#DEFINE GDK_TYPE_FILTER_RETURN (gdk_filter_return_get_type ())
DECLARE FUNCTION gdk_event_type_get_type() AS GType
#DEFINE GDK_TYPE_EVENT_TYPE (gdk_event_type_get_type ())
DECLARE FUNCTION gdk_event_mask_get_type() AS GType
#DEFINE GDK_TYPE_EVENT_MASK (gdk_event_mask_get_type ())
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
DECLARE FUNCTION gdk_font_type_get_type() AS GType
#DEFINE GDK_TYPE_FONT_TYPE (gdk_font_type_get_type ())
DECLARE FUNCTION gdk_cap_style_get_type() AS GType
#DEFINE GDK_TYPE_CAP_STYLE (gdk_cap_style_get_type ())
DECLARE FUNCTION gdk_fill_get_type() AS GType
#DEFINE GDK_TYPE_FILL (gdk_fill_get_type ())
DECLARE FUNCTION gdk_function_get_type() AS GType
#DEFINE GDK_TYPE_FUNCTION (gdk_function_get_type ())
DECLARE FUNCTION gdk_join_style_get_type() AS GType
#DEFINE GDK_TYPE_JOIN_STYLE (gdk_join_style_get_type ())
DECLARE FUNCTION gdk_line_style_get_type() AS GType
#DEFINE GDK_TYPE_LINE_STYLE (gdk_line_style_get_type ())
DECLARE FUNCTION gdk_subwindow_mode_get_type() AS GType
#DEFINE GDK_TYPE_SUBWINDOW_MODE (gdk_subwindow_mode_get_type ())
DECLARE FUNCTION gdk_gc_values_mask_get_type() AS GType
#DEFINE GDK_TYPE_GC_VALUES_MASK (gdk_gc_values_mask_get_type ())
DECLARE FUNCTION gdk_image_type_get_type() AS GType
#DEFINE GDK_TYPE_IMAGE_TYPE (gdk_image_type_get_type ())
DECLARE FUNCTION gdk_extension_mode_get_type() AS GType
#DEFINE GDK_TYPE_EXTENSION_MODE (gdk_extension_mode_get_type ())
DECLARE FUNCTION gdk_input_source_get_type() AS GType
#DEFINE GDK_TYPE_INPUT_SOURCE (gdk_input_source_get_type ())
DECLARE FUNCTION gdk_input_mode_get_type() AS GType
#DEFINE GDK_TYPE_INPUT_MODE (gdk_input_mode_get_type ())
DECLARE FUNCTION gdk_axis_use_get_type() AS GType
#DEFINE GDK_TYPE_AXIS_USE (gdk_axis_use_get_type ())
DECLARE FUNCTION gdk_prop_mode_get_type() AS GType
#DEFINE GDK_TYPE_PROP_MODE (gdk_prop_mode_get_type ())
DECLARE FUNCTION gdk_fill_rule_get_type() AS GType
#DEFINE GDK_TYPE_FILL_RULE (gdk_fill_rule_get_type ())
DECLARE FUNCTION gdk_overlap_type_get_type() AS GType
#DEFINE GDK_TYPE_OVERLAP_TYPE (gdk_overlap_type_get_type ())
DECLARE FUNCTION gdk_rgb_dither_get_type() AS GType
#DEFINE GDK_TYPE_RGB_DITHER (gdk_rgb_dither_get_type ())
DECLARE FUNCTION gdk_byte_order_get_type() AS GType
#DEFINE GDK_TYPE_BYTE_ORDER (gdk_byte_order_get_type ())
DECLARE FUNCTION gdk_modifier_type_get_type() AS GType
#DEFINE GDK_TYPE_MODIFIER_TYPE (gdk_modifier_type_get_type ())
DECLARE FUNCTION gdk_input_condition_get_type() AS GType
#DEFINE GDK_TYPE_INPUT_CONDITION (gdk_input_condition_get_type ())
DECLARE FUNCTION gdk_status_get_type() AS GType
#DEFINE GDK_TYPE_STATUS (gdk_status_get_type ())
DECLARE FUNCTION gdk_grab_status_get_type() AS GType
#DEFINE GDK_TYPE_GRAB_STATUS (gdk_grab_status_get_type ())
DECLARE FUNCTION gdk_visual_type_get_type() AS GType
#DEFINE GDK_TYPE_VISUAL_TYPE (gdk_visual_type_get_type ())
DECLARE FUNCTION gdk_window_class_get_type() AS GType
#DEFINE GDK_TYPE_WINDOW_CLASS (gdk_window_class_get_type ())
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

#IF NOT DEFINED(GDK_DISABLE_DEPRECATED) OR DEFINED(GDK_COMPILATION)
#IFNDEF __GDK_FONT_H__
#DEFINE __GDK_FONT_H__

#DEFINE GDK_TYPE_FONT gdk_font_get_type ()

ENUM GdkFontType
  GDK_FONT_FONT
  GDK_FONT_FONTSET
END ENUM

TYPE _GdkFont
  AS GdkFontType type
  AS gint ascent
  AS gint descent
END TYPE

DECLARE FUNCTION gdk_font_get_type() AS GType
DECLARE FUNCTION gdk_font_ref(BYVAL AS GdkFont PTR) AS GdkFont PTR
DECLARE SUB gdk_font_unref(BYVAL AS GdkFont PTR)
DECLARE FUNCTION gdk_font_id(BYVAL AS CONST GdkFont PTR) AS gint
DECLARE FUNCTION gdk_font_equal(BYVAL AS CONST GdkFont PTR, BYVAL AS CONST GdkFont PTR) AS gboolean
DECLARE FUNCTION gdk_font_load_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR) AS GdkFont PTR
DECLARE FUNCTION gdk_fontset_load_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR) AS GdkFont PTR
DECLARE FUNCTION gdk_font_from_description_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS PangoFontDescription PTR) AS GdkFont PTR

#IFNDEF GDK_DISABLE_DEPRECATED
#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_font_load(BYVAL AS CONST gchar PTR) AS GdkFont PTR
DECLARE FUNCTION gdk_fontset_load(BYVAL AS CONST gchar PTR) AS GdkFont PTR
DECLARE FUNCTION gdk_font_from_description(BYVAL AS PangoFontDescription PTR) AS GdkFont PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_string_width(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION gdk_text_width(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_text_width_wc(BYVAL AS GdkFont PTR, BYVAL AS CONST GdkWChar PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_char_width(BYVAL AS GdkFont PTR, BYVAL AS BYTE) AS gint
DECLARE FUNCTION gdk_char_width_wc(BYVAL AS GdkFont PTR, BYVAL AS GdkWChar) AS gint
DECLARE FUNCTION gdk_string_measure(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION gdk_text_measure(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_char_measure(BYVAL AS GdkFont PTR, BYVAL AS BYTE) AS gint
DECLARE FUNCTION gdk_string_height(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR) AS gint
DECLARE FUNCTION gdk_text_height(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gint
DECLARE FUNCTION gdk_char_height(BYVAL AS GdkFont PTR, BYVAL AS BYTE) AS gint
DECLARE SUB gdk_text_extents(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_text_extents_wc(BYVAL AS GdkFont PTR, BYVAL AS CONST GdkWChar PTR, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_string_extents(BYVAL AS GdkFont PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_font_get_display(BYVAL AS GdkFont PTR) AS GdkDisplay PTR

#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_FONT_H__
#ENDIF ' NOT DEFINED(GDK...

#IFNDEF __GDK_IMAGE_H__
#DEFINE __GDK_IMAGE_H__

ENUM GdkImageType
  GDK_IMAGE_NORMAL
  GDK_IMAGE_SHARED
  GDK_IMAGE_FASTEST
END ENUM

TYPE GdkImageClass AS _GdkImageClass

#DEFINE GDK_TYPE_IMAGE (gdk_image_get_type ())
#DEFINE GDK_IMAGE(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_IMAGE, GdkImage))
#DEFINE GDK_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_IMAGE, GdkImageClass))
#DEFINE GDK_IS_IMAGE(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_IMAGE))
#DEFINE GDK_IS_IMAGE_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_IMAGE))
#DEFINE GDK_IMAGE_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_IMAGE, GdkImageClass))

TYPE _GdkImage
  AS GObject parent_instance
  AS GdkImageType type
  AS GdkVisual PTR visual
  AS GdkByteOrder byte_order
  AS gint width
  AS gint height
  AS guint16 depth
  AS guint16 bpp
  AS guint16 bpl
  AS guint16 bits_per_pixel
  AS gpointer mem
  AS GdkColormap PTR colormap
  AS gpointer windowing_data
END TYPE

TYPE _GdkImageClass
  AS GObjectClass parent_class
END TYPE

DECLARE FUNCTION gdk_image_get_type() AS GType

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_image_new(BYVAL AS GdkImageType, BYVAL AS GdkVisual PTR, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR
DECLARE FUNCTION gdk_image_get(BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR
DECLARE FUNCTION gdk_image_ref(BYVAL AS GdkImage PTR) AS GdkImage PTR
DECLARE SUB gdk_image_unref(BYVAL AS GdkImage PTR)
DECLARE SUB gdk_image_put_pixel(BYVAL AS GdkImage PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE FUNCTION gdk_image_get_pixel(BYVAL AS GdkImage PTR, BYVAL AS gint, BYVAL AS gint) AS guint32
DECLARE SUB gdk_image_set_colormap(BYVAL AS GdkImage PTR, BYVAL AS GdkColormap PTR)
DECLARE FUNCTION gdk_image_get_colormap(BYVAL AS GdkImage PTR) AS GdkColormap PTR
DECLARE FUNCTION gdk_image_get_image_type(BYVAL AS GdkImage PTR) AS GdkImageType
DECLARE FUNCTION gdk_image_get_visual(BYVAL AS GdkImage PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_image_get_byte_order(BYVAL AS GdkImage PTR) AS GdkByteOrder
DECLARE FUNCTION gdk_image_get_width(BYVAL AS GdkImage PTR) AS gint
DECLARE FUNCTION gdk_image_get_height(BYVAL AS GdkImage PTR) AS gint
DECLARE FUNCTION gdk_image_get_depth(BYVAL AS GdkImage PTR) AS guint16
DECLARE FUNCTION gdk_image_get_bytes_per_pixel(BYVAL AS GdkImage PTR) AS guint16
DECLARE FUNCTION gdk_image_get_bytes_per_line(BYVAL AS GdkImage PTR) AS guint16
DECLARE FUNCTION gdk_image_get_bits_per_pixel(BYVAL AS GdkImage PTR) AS guint16
DECLARE FUNCTION gdk_image_get_pixels(BYVAL AS GdkImage PTR) AS gpointer

#IFDEF GDK_ENABLE_BROKEN

DECLARE FUNCTION gdk_image_new_bitmap(BYVAL AS GdkVisual PTR, BYVAL AS gpointer, BYVAL AS gint, BYVAL AS gint) AS GdkImage PTR

#ENDIF ' GDK_ENABLE_BROKEN

#DEFINE gdk_image_destroy g_object_unref
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_IMAGE_H__

#IFNDEF __GDK_KEYS_H__
#DEFINE __GDK_KEYS_H__

TYPE GdkKeymapKey AS _GdkKeymapKey

TYPE _GdkKeymapKey
  AS guint keycode
  AS gint group
  AS gint level
END TYPE

TYPE GdkKeymap AS _GdkKeymap
TYPE GdkKeymapClass AS _GdkKeymapClass

#DEFINE GDK_TYPE_KEYMAP (gdk_keymap_get_type ())
#DEFINE GDK_KEYMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_KEYMAP, GdkKeymap))
#DEFINE GDK_KEYMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_KEYMAP, GdkKeymapClass))
#DEFINE GDK_IS_KEYMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_KEYMAP))
#DEFINE GDK_IS_KEYMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_KEYMAP))
#DEFINE GDK_KEYMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_KEYMAP, GdkKeymapClass))

TYPE _GdkKeymap
  AS GObject parent_instance
  AS GdkDisplay PTR display
END TYPE

TYPE _GdkKeymapClass
  AS GObjectClass parent_class
  direction_changed AS SUB(BYVAL AS GdkKeymap PTR)
  keys_changed AS SUB(BYVAL AS GdkKeymap PTR)
  state_changed AS SUB(BYVAL AS GdkKeymap PTR)
END TYPE

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
DECLARE SUB gdk_keymap_add_virtual_modifiers(BYVAL AS GdkKeymap PTR, BYVAL AS GdkModifierType PTR)
DECLARE FUNCTION gdk_keymap_map_virtual_modifiers(BYVAL AS GdkKeymap PTR, BYVAL AS GdkModifierType PTR) AS gboolean
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

#IFNDEF __GDK_PANGO_H__
#DEFINE __GDK_PANGO_H__

TYPE GdkPangoRenderer AS _GdkPangoRenderer
TYPE GdkPangoRendererClass AS _GdkPangoRendererClass
TYPE GdkPangoRendererPrivate AS _GdkPangoRendererPrivate

#DEFINE GDK_TYPE_PANGO_RENDERER (gdk_pango_renderer_get_type())
#DEFINE GDK_PANGO_RENDERER(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PANGO_RENDERER, GdkPangoRenderer))
#DEFINE GDK_IS_PANGO_RENDERER(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PANGO_RENDERER))
#DEFINE GDK_PANGO_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PANGO_RENDERER, GdkPangoRendererClass))
#DEFINE GDK_IS_PANGO_RENDERER_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PANGO_RENDERER))
#DEFINE GDK_PANGO_RENDERER_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PANGO_RENDERER, GdkPangoRendererClass))

TYPE _GdkPangoRenderer
  AS PangoRenderer parent_instance
  AS GdkPangoRendererPrivate PTR priv
END TYPE

TYPE _GdkPangoRendererClass
  AS PangoRendererClass parent_class
END TYPE

DECLARE FUNCTION gdk_pango_renderer_get_type() AS GType
DECLARE FUNCTION gdk_pango_renderer_new(BYVAL AS GdkScreen PTR) AS PangoRenderer PTR
DECLARE FUNCTION gdk_pango_renderer_get_default(BYVAL AS GdkScreen PTR) AS PangoRenderer PTR
DECLARE SUB gdk_pango_renderer_set_drawable(BYVAL AS GdkPangoRenderer PTR, BYVAL AS GdkDrawable PTR)
DECLARE SUB gdk_pango_renderer_set_gc(BYVAL AS GdkPangoRenderer PTR, BYVAL AS GdkGC PTR)
DECLARE SUB gdk_pango_renderer_set_stipple(BYVAL AS GdkPangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS GdkBitmap PTR)
DECLARE SUB gdk_pango_renderer_set_override_color(BYVAL AS GdkPangoRenderer PTR, BYVAL AS PangoRenderPart, BYVAL AS CONST GdkColor PTR)
DECLARE FUNCTION gdk_pango_context_get_for_screen(BYVAL AS GdkScreen PTR) AS PangoContext PTR

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_pango_context_get() AS PangoContext PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_pango_context_set_colormap(BYVAL AS PangoContext PTR, BYVAL AS GdkColormap PTR)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_pango_layout_line_get_clip_region(BYVAL AS PangoLayoutLine PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gint PTR, BYVAL AS gint) AS GdkRegion PTR
DECLARE FUNCTION gdk_pango_layout_get_clip_region(BYVAL AS PangoLayout PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST gint PTR, BYVAL AS gint) AS GdkRegion PTR

TYPE GdkPangoAttrStipple AS _GdkPangoAttrStipple
TYPE GdkPangoAttrEmbossed AS _GdkPangoAttrEmbossed
TYPE GdkPangoAttrEmbossColor AS _GdkPangoAttrEmbossColor

TYPE _GdkPangoAttrStipple
  AS PangoAttribute attr
  AS GdkBitmap PTR stipple
END TYPE

TYPE _GdkPangoAttrEmbossed
  AS PangoAttribute attr
  AS gboolean embossed
END TYPE

TYPE _GdkPangoAttrEmbossColor
  AS PangoAttribute attr
  AS PangoColor color
END TYPE

DECLARE FUNCTION gdk_pango_attr_stipple_new(BYVAL AS GdkBitmap PTR) AS PangoAttribute PTR
DECLARE FUNCTION gdk_pango_attr_embossed_new(BYVAL AS gboolean) AS PangoAttribute PTR
DECLARE FUNCTION gdk_pango_attr_emboss_color_new(BYVAL AS CONST GdkColor PTR) AS PangoAttribute PTR

#ENDIF ' __GDK_PANGO_H__

#IFNDEF __GDK_PIXMAP_H__
#DEFINE __GDK_PIXMAP_H__

TYPE GdkPixmapObject AS _GdkPixmapObject
TYPE GdkPixmapObjectClass AS _GdkPixmapObjectClass

#DEFINE GDK_TYPE_PIXMAP (gdk_pixmap_get_type ())
#DEFINE GDK_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_PIXMAP, GdkPixmap))
#DEFINE GDK_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_PIXMAP, GdkPixmapObjectClass))
#DEFINE GDK_IS_PIXMAP(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_PIXMAP))
#DEFINE GDK_IS_PIXMAP_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_PIXMAP))
#DEFINE GDK_PIXMAP_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_PIXMAP, GdkPixmapObjectClass))
#DEFINE GDK_PIXMAP_OBJECT(object) ((GdkPixmapObject *) GDK_PIXMAP (object))

TYPE _GdkPixmapObject
  AS GdkDrawable parent_instance
  AS GdkDrawable PTR impl
  AS gint depth
END TYPE

TYPE _GdkPixmapObjectClass
  AS GdkDrawableClass parent_class
END TYPE

DECLARE FUNCTION gdk_pixmap_get_type() AS GType
DECLARE FUNCTION gdk_pixmap_new(BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkPixmap PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_bitmap_create_from_data(BYVAL AS GdkDrawable PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint) AS GdkBitmap PTR
DECLARE FUNCTION gdk_pixmap_create_from_data(BYVAL AS GdkDrawable PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST GdkColor PTR) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_create_from_xpm(BYVAL AS GdkDrawable PTR, BYVAL AS GdkBitmap PTR PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST gchar PTR) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_colormap_create_from_xpm(BYVAL AS GdkDrawable PTR, BYVAL AS GdkColormap PTR, BYVAL AS GdkBitmap PTR PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS CONST gchar PTR) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_create_from_xpm_d(BYVAL AS GdkDrawable PTR, BYVAL AS GdkBitmap PTR PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS gchar PTR PTR) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_colormap_create_from_xpm_d(BYVAL AS GdkDrawable PTR, BYVAL AS GdkColormap PTR, BYVAL AS GdkBitmap PTR PTR, BYVAL AS CONST GdkColor PTR, BYVAL AS gchar PTR PTR) AS GdkPixmap PTR

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_pixmap_get_size(BYVAL AS GdkPixmap PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_pixmap_foreign_new(BYVAL AS GdkNativeWindow) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_lookup(BYVAL AS GdkNativeWindow) AS GdkPixmap PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_pixmap_foreign_new_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkNativeWindow) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_lookup_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkNativeWindow) AS GdkPixmap PTR
DECLARE FUNCTION gdk_pixmap_foreign_new_for_screen(BYVAL AS GdkScreen PTR, BYVAL AS GdkNativeWindow, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint) AS GdkPixmap PTR

#IFNDEF GDK_DISABLE_DEPRECATED
#DEFINE gdk_bitmap_ref g_object_ref
#DEFINE gdk_bitmap_unref g_object_unref
#DEFINE gdk_pixmap_ref g_object_ref
#DEFINE gdk_pixmap_unref g_object_unref
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_PIXMAP_H__

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
DECLARE SUB gdk_property_delete_ ALIAS "gdk_property_delete"(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom)

#IFNDEF GDK_MULTIHEAD_SAFE
#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_text_property_to_text_list(BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gchar PTR PTR PTR) AS gint
DECLARE FUNCTION gdk_utf8_to_compound_text(BYVAL AS CONST gchar PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR, BYVAL AS guchar PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE FUNCTION gdk_string_to_compound_text(BYVAL AS CONST gchar PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR, BYVAL AS guchar PTR PTR, BYVAL AS gint PTR) AS gint
DECLARE FUNCTION gdk_text_property_to_utf8_list(BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gchar PTR PTR PTR) AS gint

#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_text_property_to_utf8_list_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gchar PTR PTR PTR) AS gint
DECLARE FUNCTION gdk_utf8_to_string_target(BYVAL AS CONST gchar PTR) AS gchar PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_text_property_to_text_list_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom, BYVAL AS gint, BYVAL AS CONST guchar PTR, BYVAL AS gint, BYVAL AS gchar PTR PTR PTR) AS gint
DECLARE FUNCTION gdk_string_to_compound_text_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR, BYVAL AS guchar PTR PTR, BYVAL AS gint PTR) AS gint
DECLARE FUNCTION gdk_utf8_to_compound_text_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS CONST gchar PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR, BYVAL AS guchar PTR PTR, BYVAL AS gint PTR) AS gboolean
DECLARE SUB gdk_free_text_list(BYVAL AS gchar PTR PTR)
DECLARE SUB gdk_free_compound_text(BYVAL AS guchar PTR)

#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_PROPERTY_H__

#IFNDEF __GDK_REGION_H__
#DEFINE __GDK_REGION_H__

#IFNDEF GDK_DISABLE_DEPRECATED

ENUM GdkFillRule
  GDK_EVEN_ODD_RULE
  GDK_WINDING_RULE
END ENUM

#ENDIF ' GDK_DISABLE_DEPRECATED

ENUM GdkOverlapType
  GDK_OVERLAP_RECTANGLE_IN
  GDK_OVERLAP_RECTANGLE_OUT
  GDK_OVERLAP_RECTANGLE_PART
END ENUM

#IFNDEF GDK_DISABLE_DEPRECATED

TYPE GdkSpanFunc AS SUB(BYVAL AS GdkSpan PTR, BYVAL AS gpointer)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_region_new() AS GdkRegion PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_region_polygon(BYVAL AS CONST GdkPoint PTR, BYVAL AS gint, BYVAL AS GdkFillRule) AS GdkRegion PTR

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_region_copy(BYVAL AS CONST GdkRegion PTR) AS GdkRegion PTR
DECLARE FUNCTION gdk_region_rectangle(BYVAL AS CONST GdkRectangle PTR) AS GdkRegion PTR
DECLARE SUB gdk_region_destroy(BYVAL AS GdkRegion PTR)
DECLARE SUB gdk_region_get_clipbox(BYVAL AS CONST GdkRegion PTR, BYVAL AS GdkRectangle PTR)
DECLARE SUB gdk_region_get_rectangles(BYVAL AS CONST GdkRegion PTR, BYVAL AS GdkRectangle PTR PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_region_empty(BYVAL AS CONST GdkRegion PTR) AS gboolean
DECLARE FUNCTION gdk_region_equal(BYVAL AS CONST GdkRegion PTR, BYVAL AS CONST GdkRegion PTR) AS gboolean

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_region_rect_equal(BYVAL AS CONST GdkRegion PTR, BYVAL AS CONST GdkRectangle PTR) AS gboolean

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_region_point_in(BYVAL AS CONST GdkRegion PTR, BYVAL AS INTEGER, BYVAL AS INTEGER) AS gboolean
DECLARE FUNCTION gdk_region_rect_in(BYVAL AS CONST GdkRegion PTR, BYVAL AS CONST GdkRectangle PTR) AS GdkOverlapType
DECLARE SUB gdk_region_offset(BYVAL AS GdkRegion PTR, BYVAL AS gint, BYVAL AS gint)

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_region_shrink(BYVAL AS GdkRegion PTR, BYVAL AS gint, BYVAL AS gint)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_region_union_with_rect(BYVAL AS GdkRegion PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gdk_region_intersect(BYVAL AS GdkRegion PTR, BYVAL AS CONST GdkRegion PTR)
DECLARE SUB gdk_region_union(BYVAL AS GdkRegion PTR, BYVAL AS CONST GdkRegion PTR)
DECLARE SUB gdk_region_subtract(BYVAL AS GdkRegion PTR, BYVAL AS CONST GdkRegion PTR)
DECLARE SUB gdk_region_xor(BYVAL AS GdkRegion PTR, BYVAL AS CONST GdkRegion PTR)

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_region_spans_intersect_foreach(BYVAL AS GdkRegion PTR, BYVAL AS CONST GdkSpan PTR, BYVAL AS INTEGER, BYVAL AS gboolean, BYVAL AS GdkSpanFunc, BYVAL AS gpointer)

#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_REGION_H__

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

#IFNDEF GDK_DISABLE_DEPRECATED

TYPE GdkSelection AS GdkAtom
TYPE GdkTarget AS GdkAtom
TYPE GdkSelectionType AS GdkAtom

#ENDIF ' GDK_DISABLE_DEPRECATED

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_selection_owner_set(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS guint32, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gdk_selection_owner_get(BYVAL AS GdkAtom) AS GdkWindow PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_selection_owner_set_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS guint32, BYVAL AS gboolean) AS gboolean
DECLARE FUNCTION gdk_selection_owner_get_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkAtom) AS GdkWindow PTR
DECLARE SUB gdk_selection_convert(BYVAL AS GdkWindow PTR, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32)
DECLARE FUNCTION gdk_selection_property_get(BYVAL AS GdkWindow PTR, BYVAL AS guchar PTR PTR, BYVAL AS GdkAtom PTR, BYVAL AS gint PTR) AS gint

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_selection_send_notify(BYVAL AS GdkNativeWindow, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32)

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_selection_send_notify_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkNativeWindow, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS GdkAtom, BYVAL AS guint32)

#ENDIF ' __GDK_SELECTION_H__

#IFNDEF __GDK_SPAWN_H__
#DEFINE __GDK_SPAWN_H__

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_spawn_on_screen(BYVAL AS GdkScreen PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GSpawnFlags, BYVAL AS GSpawnChildSetupFunc, BYVAL AS gpointer, BYVAL AS gint PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gdk_spawn_on_screen_with_pipes(BYVAL AS GdkScreen PTR, BYVAL AS CONST gchar PTR, BYVAL AS gchar PTR PTR, BYVAL AS gchar PTR PTR, BYVAL AS GSpawnFlags, BYVAL AS GSpawnChildSetupFunc, BYVAL AS gpointer, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GError PTR PTR) AS gboolean
DECLARE FUNCTION gdk_spawn_command_line_on_screen(BYVAL AS GdkScreen PTR, BYVAL AS CONST gchar PTR, BYVAL AS GError PTR PTR) AS gboolean

#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_SPAWN_H__

#IFNDEF __GDK_TEST_UTILS_H__
#DEFINE __GDK_TEST_UTILS_H__

#IFNDEF __GDK_WINDOW_H__
#DEFINE __GDK_WINDOW_H__

TYPE GdkGeometry AS _GdkGeometry
TYPE GdkWindowAttr AS _GdkWindowAttr
TYPE GdkPointerHooks AS _GdkPointerHooks
TYPE GdkWindowRedirect AS _GdkWindowRedirect

ENUM GdkWindowClass
  GDK_INPUT_OUTPUT
  GDK_INPUT_ONLY
END ENUM

ENUM GdkWindowType
  GDK_WINDOW_ROOT
  GDK_WINDOW_TOPLEVEL
  GDK_WINDOW_CHILD
  GDK_WINDOW_DIALOG
  GDK_WINDOW_TEMP
  GDK_WINDOW_FOREIGN
  GDK_WINDOW_OFFSCREEN
END ENUM

ENUM GdkWindowAttributesType
  GDK_WA_TITLE = 1 SHL 1
  GDK_WA_X = 1 SHL 2
  GDK_WA_Y = 1 SHL 3
  GDK_WA_CURSOR = 1 SHL 4
  GDK_WA_COLORMAP = 1 SHL 5
  GDK_WA_VISUAL = 1 SHL 6
  GDK_WA_WMCLASS = 1 SHL 7
  GDK_WA_NOREDIR = 1 SHL 8
  GDK_WA_TYPE_HINT = 1 SHL 9
END ENUM

ENUM GdkWindowHints
  GDK_HINT_POS = 1 SHL 0
  GDK_HINT_MIN_SIZE = 1 SHL 1
  GDK_HINT_MAX_SIZE = 1 SHL 2
  GDK_HINT_BASE_SIZE = 1 SHL 3
  GDK_HINT_ASPECT = 1 SHL 4
  GDK_HINT_RESIZE_INC = 1 SHL 5
  GDK_HINT_WIN_GRAVITY = 1 SHL 6
  GDK_HINT_USER_POS = 1 SHL 7
  GDK_HINT_USER_SIZE = 1 SHL 8
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
  GDK_DECOR_ALL = 1 SHL 0
  GDK_DECOR_BORDER = 1 SHL 1
  GDK_DECOR_RESIZEH = 1 SHL 2
  GDK_DECOR_TITLE = 1 SHL 3
  GDK_DECOR_MENU = 1 SHL 4
  GDK_DECOR_MINIMIZE = 1 SHL 5
  GDK_DECOR_MAXIMIZE = 1 SHL 6
END ENUM

ENUM GdkWMFunction
  GDK_FUNC_ALL = 1 SHL 0
  GDK_FUNC_RESIZE = 1 SHL 1
  GDK_FUNC_MOVE = 1 SHL 2
  GDK_FUNC_MINIMIZE = 1 SHL 3
  GDK_FUNC_MAXIMIZE = 1 SHL 4
  GDK_FUNC_CLOSE = 1 SHL 5
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
  AS GdkWindowClass wclass
  AS GdkVisual PTR visual
  AS GdkColormap PTR colormap
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

TYPE _GdkPointerHooks
  get_pointer AS FUNCTION(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR) AS GdkWindow PTR
  window_at_pointer AS FUNCTION(BYVAL AS GdkScreen PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR
END TYPE

TYPE GdkWindowObject AS _GdkWindowObject
TYPE GdkWindowObjectClass AS _GdkWindowObjectClass

#DEFINE GDK_TYPE_WINDOW (gdk_window_object_get_type ())
#DEFINE GDK_WINDOW(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_WINDOW, GdkWindow))
#DEFINE GDK_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_WINDOW, GdkWindowObjectClass))
#DEFINE GDK_IS_WINDOW(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_WINDOW))
#DEFINE GDK_IS_WINDOW_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_WINDOW))
#DEFINE GDK_WINDOW_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_WINDOW, GdkWindowObjectClass))

#IFNDEF GDK_DISABLE_DEPRECATED
#DEFINE GDK_WINDOW_OBJECT(object) ((GdkWindowObject *) GDK_WINDOW (object))

#IFNDEF GDK_COMPILATION

TYPE _GdkWindowObject
  AS GdkDrawable parent_instance
  AS GdkDrawable PTR impl
  AS GdkWindowObject PTR parent
  AS gpointer user_data
  AS gint x
  AS gint y
  AS gint extension_events
  AS GList PTR filters
  AS GList PTR children
  AS GdkColor bg_color
  AS GdkPixmap PTR bg_pixmap
  AS GSList PTR paint_stack
  AS GdkRegion PTR update_area
  AS guint update_freeze_count
  AS guint8 window_type
  AS guint8 depth
  AS guint8 resize_count
  AS GdkWindowState state
  AS guint guffaw_gravity : 1
  AS guint input_only : 1
  AS guint modal_hint : 1
  AS guint composited : 1
  AS guint destroyed : 2
  AS guint accept_focus : 1
  AS guint focus_on_map : 1
  AS guint shaped : 1
  AS GdkEventMask event_mask
  AS guint update_and_descendants_freeze_count
  AS GdkWindowRedirect PTR redirect
END TYPE

#ENDIF ' GDK_COMPILATION
#ENDIF ' GDK_DISABLE_DEPRECATED

TYPE _GdkWindowObjectClass
  AS GdkDrawableClass parent_class
END TYPE

DECLARE FUNCTION gdk_window_object_get_type() AS GType
DECLARE FUNCTION gdk_window_new(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowAttr PTR, BYVAL AS gint) AS GdkWindow PTR
DECLARE SUB gdk_window_destroy(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_window_type(BYVAL AS GdkWindow PTR) AS GdkWindowType
DECLARE FUNCTION gdk_window_is_destroyed(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_get_screen(BYVAL AS GdkWindow PTR) AS GdkScreen PTR
DECLARE FUNCTION gdk_window_get_display(BYVAL AS GdkWindow PTR) AS GdkDisplay PTR
DECLARE FUNCTION gdk_window_get_visual(BYVAL AS GdkWindow PTR) AS GdkVisual PTR
DECLARE FUNCTION gdk_window_get_width(BYVAL AS GdkWindow PTR) AS INTEGER
DECLARE FUNCTION gdk_window_get_height(BYVAL AS GdkWindow PTR) AS INTEGER
DECLARE FUNCTION gdk_window_at_pointer(BYVAL AS gint PTR, BYVAL AS gint PTR) AS GdkWindow PTR
DECLARE SUB gdk_window_show(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_hide(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_withdraw(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_show_unraised(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_move(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_resize(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_move_resize(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_reparent(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_clear(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_clear_area(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_clear_area_e(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
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
DECLARE SUB gdk_window_move_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRegion PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE FUNCTION gdk_window_ensure_native(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_shape_combine_mask(BYVAL AS GdkWindow PTR, BYVAL AS GdkBitmap PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_shape_combine_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRegion PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_set_child_shapes(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_composited(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_composited(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_merge_child_shapes(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_input_shape_combine_mask(BYVAL AS GdkWindow PTR, BYVAL AS GdkBitmap PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_input_shape_combine_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRegion PTR, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_set_child_input_shapes(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_merge_child_input_shapes(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_is_visible(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_is_viewable(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_is_input_only(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_is_shaped(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE FUNCTION gdk_window_get_state(BYVAL AS GdkWindow PTR) AS GdkWindowState
DECLARE FUNCTION gdk_window_set_static_gravities(BYVAL AS GdkWindow PTR, BYVAL AS gboolean) AS gboolean

#IF NOT DEFINED(GDK_DISABLE_DEPRECATED) OR DEFINED(GDK_COMPILATION)
#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_window_foreign_new(BYVAL AS GdkNativeWindow) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_lookup(BYVAL AS GdkNativeWindow) AS GdkWindow PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_window_foreign_new_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkNativeWindow) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_lookup_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkNativeWindow) AS GdkWindow PTR

#ENDIF ' NOT DEFINED(GDK...

DECLARE FUNCTION gdk_window_has_native(BYVAL AS GdkWindow PTR) AS gboolean

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_window_set_hints(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_window_set_type_hint(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowTypeHint)
DECLARE FUNCTION gdk_window_get_type_hint(BYVAL AS GdkWindow PTR) AS GdkWindowTypeHint
DECLARE FUNCTION gdk_window_get_modal_hint(BYVAL AS GdkWindow PTR) AS gboolean
DECLARE SUB gdk_window_set_modal_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_skip_taskbar_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_skip_pager_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_urgency_hint(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_geometry_hints(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkGeometry PTR, BYVAL AS GdkWindowHints)

#IF NOT DEFINED(GDK_DISABLE_DEPRECATED) OR DEFINED(GDK_COMPILATION)

DECLARE SUB gdk_set_sm_client_id(BYVAL AS CONST gchar PTR)

#ENDIF ' NOT DEFINED(GDK...

DECLARE SUB gdk_window_begin_paint_rect(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRectangle PTR)
DECLARE SUB gdk_window_begin_paint_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRegion PTR)
DECLARE SUB gdk_window_end_paint(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_flush(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_set_title(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_role(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_startup_id(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_transient_for(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_set_background(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkColor PTR)
DECLARE SUB gdk_window_set_back_pixmap(BYVAL AS GdkWindow PTR, BYVAL AS GdkPixmap PTR, BYVAL AS gboolean)
DECLARE FUNCTION gdk_window_get_background_pattern(BYVAL AS GdkWindow PTR) AS cairo_pattern_t PTR
DECLARE SUB gdk_window_set_cursor(BYVAL AS GdkWindow PTR, BYVAL AS GdkCursor PTR)
DECLARE FUNCTION gdk_window_get_cursor(BYVAL AS GdkWindow PTR) AS GdkCursor PTR
DECLARE SUB gdk_window_get_user_data(BYVAL AS GdkWindow PTR, BYVAL AS gpointer PTR)
DECLARE SUB gdk_window_get_geometry(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_get_position(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE FUNCTION gdk_window_get_origin(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gint
DECLARE SUB gdk_window_get_root_coords(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_coords_to_parent(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)
DECLARE SUB gdk_window_coords_from_parent(BYVAL AS GdkWindow PTR, BYVAL AS gdouble, BYVAL AS gdouble, BYVAL AS gdouble PTR, BYVAL AS gdouble PTR)

#IF NOT DEFINED (GDK_DISABLE_DEPRECATED) OR DEFINED (GDK_COMPILATION)

DECLARE FUNCTION gdk_window_get_deskrelative_origin(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR) AS gboolean

#ENDIF ' NOT DEFINED (GD...

DECLARE SUB gdk_window_get_root_origin(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_get_frame_extents(BYVAL AS GdkWindow PTR, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gdk_window_get_pointer(BYVAL AS GdkWindow PTR, BYVAL AS gint PTR, BYVAL AS gint PTR, BYVAL AS GdkModifierType PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_parent(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_toplevel(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_effective_parent(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_effective_toplevel(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE FUNCTION gdk_window_get_children(BYVAL AS GdkWindow PTR) AS GList PTR
DECLARE FUNCTION gdk_window_peek_children(BYVAL AS GdkWindow PTR) AS GList PTR
DECLARE FUNCTION gdk_window_get_events(BYVAL AS GdkWindow PTR) AS GdkEventMask
DECLARE SUB gdk_window_set_events(BYVAL AS GdkWindow PTR, BYVAL AS GdkEventMask)
DECLARE SUB gdk_window_set_icon_list(BYVAL AS GdkWindow PTR, BYVAL AS GList PTR)
DECLARE SUB gdk_window_set_icon(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR, BYVAL AS GdkPixmap PTR, BYVAL AS GdkBitmap PTR)
DECLARE SUB gdk_window_set_icon_name(BYVAL AS GdkWindow PTR, BYVAL AS CONST gchar PTR)
DECLARE SUB gdk_window_set_group(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_window_get_group(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE SUB gdk_window_set_decorations(BYVAL AS GdkWindow PTR, BYVAL AS GdkWMDecoration)
DECLARE FUNCTION gdk_window_get_decorations(BYVAL AS GdkWindow PTR, BYVAL AS GdkWMDecoration PTR) AS gboolean
DECLARE SUB gdk_window_set_functions(BYVAL AS GdkWindow PTR, BYVAL AS GdkWMFunction)

#IF NOT DEFINED(GDK_MULTIHEAD_SAFE) AND NOT DEFINED(GDK_DISABLE_DEPRECATED)

DECLARE FUNCTION gdk_window_get_toplevels() AS GList PTR

#ENDIF ' NOT DEFINED(GDK...

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
DECLARE SUB gdk_window_begin_resize_drag(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindowEdge, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gdk_window_begin_move_drag(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint32)
DECLARE SUB gdk_window_invalidate_rect(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_invalidate_region(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRegion PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_invalidate_maybe_recurse(BYVAL AS GdkWindow PTR, BYVAL AS CONST GdkRegion PTR, BYVAL AS FUNCTION(BYVAL AS GdkWindow PTR, BYVAL AS gpointer) AS gboolean, BYVAL AS gpointer)
DECLARE FUNCTION gdk_window_get_update_area(BYVAL AS GdkWindow PTR) AS GdkRegion PTR
DECLARE SUB gdk_window_freeze_updates(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_thaw_updates(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_freeze_toplevel_updates_libgtk_only(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_thaw_toplevel_updates_libgtk_only(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_process_all_updates()
DECLARE SUB gdk_window_process_updates(BYVAL AS GdkWindow PTR, BYVAL AS gboolean)
DECLARE SUB gdk_window_set_debug_updates(BYVAL AS gboolean)
DECLARE SUB gdk_window_constrain_size(BYVAL AS GdkGeometry PTR, BYVAL AS guint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_get_internal_paint_info(BYVAL AS GdkWindow PTR, BYVAL AS GdkDrawable PTR PTR, BYVAL AS gint PTR, BYVAL AS gint PTR)
DECLARE SUB gdk_window_enable_synchronized_configure(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_configure_finished(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_get_default_root_window() AS GdkWindow PTR
DECLARE FUNCTION gdk_offscreen_window_get_pixmap(BYVAL AS GdkWindow PTR) AS GdkPixmap PTR
DECLARE SUB gdk_offscreen_window_set_embedder(BYVAL AS GdkWindow PTR, BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_offscreen_window_get_embedder(BYVAL AS GdkWindow PTR) AS GdkWindow PTR
DECLARE SUB gdk_window_geometry_changed(BYVAL AS GdkWindow PTR)
DECLARE SUB gdk_window_redirect_to_drawable(BYVAL AS GdkWindow PTR, BYVAL AS GdkDrawable PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint, BYVAL AS gint)
DECLARE SUB gdk_window_remove_redirection(BYVAL AS GdkWindow PTR)

#IFNDEF GDK_DISABLE_DEPRECATED
#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_set_pointer_hooks(BYVAL AS CONST GdkPointerHooks PTR) AS GdkPointerHooks PTR

#ENDIF ' GDK_MULTIHEAD_SAFE

#DEFINE GDK_ROOT_PARENT() (gdk_get_default_root_window ())
#DEFINE gdk_window_get_size gdk_drawable_get_size
#DEFINE gdk_window_get_type gdk_window_get_window_type
#DEFINE gdk_window_get_colormap gdk_drawable_get_colormap
#DEFINE gdk_window_set_colormap gdk_drawable_set_colormap
#DEFINE gdk_window_ref g_object_ref
#DEFINE gdk_window_unref g_object_unref
#DEFINE gdk_window_copy_area(drawable,gc,x,y,source_drawable,source_x,source_y,width,height) _
   gdk_draw_pixmap(drawable,gc,source_drawable,source_x,source_y,x,y,width,height)
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_WINDOW_H__

DECLARE SUB gdk_test_render_sync(BYVAL AS GdkWindow PTR)
DECLARE FUNCTION gdk_test_simulate_key(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GdkEventType) AS gboolean
DECLARE FUNCTION gdk_test_simulate_button(BYVAL AS GdkWindow PTR, BYVAL AS gint, BYVAL AS gint, BYVAL AS guint, BYVAL AS GdkModifierType, BYVAL AS GdkEventType) AS gboolean

#ENDIF ' __GDK_TEST_UTILS_H__

#IFNDEF __GDK_VISUAL_H__
#DEFINE __GDK_VISUAL_H__

#DEFINE GDK_TYPE_VISUAL (gdk_visual_get_type ())
#DEFINE GDK_VISUAL(object) (G_TYPE_CHECK_INSTANCE_CAST ((object), GDK_TYPE_VISUAL, GdkVisual))
#DEFINE GDK_VISUAL_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), GDK_TYPE_VISUAL, GdkVisualClass))
#DEFINE GDK_IS_VISUAL(object) (G_TYPE_CHECK_INSTANCE_TYPE ((object), GDK_TYPE_VISUAL))
#DEFINE GDK_IS_VISUAL_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), GDK_TYPE_VISUAL))
#DEFINE GDK_VISUAL_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), GDK_TYPE_VISUAL, GdkVisualClass))

TYPE GdkVisualClass AS _GdkVisualClass

ENUM GdkVisualType
  GDK_VISUAL_STATIC_GRAY
  GDK_VISUAL_GRAYSCALE
  GDK_VISUAL_STATIC_COLOR
  GDK_VISUAL_PSEUDO_COLOR
  GDK_VISUAL_TRUE_COLOR
  GDK_VISUAL_DIRECT_COLOR
END ENUM

TYPE _GdkVisual
  AS GObject parent_instance
  AS GdkVisualType type
  AS gint depth
  AS GdkByteOrder byte_order
  AS gint colormap_size
  AS gint bits_per_rgb
  AS guint32 red_mask
  AS gint red_shift
  AS gint red_prec
  AS guint32 green_mask
  AS gint green_shift
  AS gint green_prec
  AS guint32 blue_mask
  AS gint blue_shift
  AS gint blue_prec
END TYPE

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

#IFNDEF GDK_DISABLE_DEPRECATED
#DEFINE gdk_visual_ref(v) g_object_ref(v)
#DEFINE gdk_visual_unref(v) g_object_unref(v)
#ENDIF ' GDK_DISABLE_DEPRECATED
#ENDIF ' __GDK_VISUAL_H__

#UNDEF __GDK_H_INSIDE__
#DEFINE GDK_PRIORITY_EVENTS (G_PRIORITY_DEFAULT)

DECLARE SUB gdk_parse_args(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR)
DECLARE SUB gdk_init(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR)
DECLARE FUNCTION gdk_init_check(BYVAL AS gint PTR, BYVAL AS gchar PTR PTR PTR) AS gboolean
DECLARE SUB gdk_add_option_entries_libgtk_only(BYVAL AS GOptionGroup PTR)
DECLARE SUB gdk_pre_parse_libgtk_only()

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_exit(BYVAL AS gint)
DECLARE FUNCTION gdk_set_locale() AS gchar PTR

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_get_program_class() AS CONST ZSTRING PTR

DECLARE SUB gdk_set_program_class(BYVAL AS CONST ZSTRING PTR)
DECLARE SUB gdk_error_trap_push()
DECLARE FUNCTION gdk_error_trap_pop() AS gint

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE SUB gdk_set_use_xshm(BYVAL AS gboolean)
DECLARE FUNCTION gdk_get_use_xshm() AS gboolean

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_get_display() AS gchar PTR

DECLARE FUNCTION gdk_get_display_arg_name() AS CONST gchar PTR

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_input_add_full(BYVAL AS gint, BYVAL AS GdkInputCondition, BYVAL AS GdkInputFunction, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS gint
DECLARE FUNCTION gdk_input_add(BYVAL AS gint, BYVAL AS GdkInputCondition, BYVAL AS GdkInputFunction, BYVAL AS gpointer) AS gint
DECLARE SUB gdk_input_remove(BYVAL AS gint)

#ENDIF ' GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_pointer_grab(BYVAL AS GdkWindow PTR, BYVAL AS gboolean, BYVAL AS GdkEventMask, BYVAL AS GdkWindow PTR, BYVAL AS GdkCursor PTR, BYVAL AS guint32) AS GdkGrabStatus
DECLARE FUNCTION gdk_keyboard_grab(BYVAL AS GdkWindow PTR, BYVAL AS gboolean, BYVAL AS guint32) AS GdkGrabStatus
DECLARE FUNCTION gdk_pointer_grab_info_libgtk_only(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR PTR, BYVAL AS gboolean PTR) AS gboolean
DECLARE FUNCTION gdk_keyboard_grab_info_libgtk_only(BYVAL AS GdkDisplay PTR, BYVAL AS GdkWindow PTR PTR, BYVAL AS gboolean PTR) AS gboolean

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_pointer_ungrab(BYVAL AS guint32)
DECLARE SUB gdk_keyboard_ungrab(BYVAL AS guint32)
DECLARE FUNCTION gdk_pointer_is_grabbed() AS gboolean
DECLARE FUNCTION gdk_screen_width() AS gint
DECLARE FUNCTION gdk_screen_height() AS gint
DECLARE FUNCTION gdk_screen_width_mm() AS gint
DECLARE FUNCTION gdk_screen_height_mm() AS gint
DECLARE SUB gdk_beep()

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_flush()

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE SUB gdk_set_double_click_time(BYVAL AS guint)

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_rectangle_intersect(BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR) AS gboolean
DECLARE SUB gdk_rectangle_union(BYVAL AS CONST GdkRectangle PTR, BYVAL AS CONST GdkRectangle PTR, BYVAL AS GdkRectangle PTR)
DECLARE FUNCTION gdk_rectangle_get_type() AS GType

#DEFINE GDK_TYPE_RECTANGLE (gdk_rectangle_get_type ())

#IFNDEF GDK_DISABLE_DEPRECATED

DECLARE FUNCTION gdk_wcstombs(BYVAL AS CONST GdkWChar PTR) AS gchar PTR
DECLARE FUNCTION gdk_mbstowcs(BYVAL AS GdkWChar PTR, BYVAL AS CONST gchar PTR, BYVAL AS gint) AS gint

#ENDIF ' GDK_DISABLE_DEPRECATED

#IFNDEF GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_event_send_client_message(BYVAL AS GdkEvent PTR, BYVAL AS GdkNativeWindow) AS gboolean
DECLARE SUB gdk_event_send_clientmessage_toall(BYVAL AS GdkEvent PTR)

#ENDIF ' GDK_MULTIHEAD_SAFE

DECLARE FUNCTION gdk_event_send_client_message_for_display(BYVAL AS GdkDisplay PTR, BYVAL AS GdkEvent PTR, BYVAL AS GdkNativeWindow) AS gboolean
DECLARE SUB gdk_notify_startup_complete()
DECLARE SUB gdk_notify_startup_complete_with_id(BYVAL AS CONST gchar PTR)

#IF NOT DEFINED (GDK_DISABLE_DEPRECATED) OR DEFINED (GDK_COMPILATION)

EXTERN AS GMutex PTR gdk_threads_mutex

#ENDIF ' NOT DEFINED (GD...

EXTERN AS GCallback gdk_threads_lock
EXTERN AS GCallback gdk_threads_unlock

DECLARE SUB gdk_threads_enter_ ALIAS "gdk_threads_enter"()
DECLARE SUB gdk_threads_leave_ ALIAS "gdk_threads_leave"()
DECLARE SUB gdk_threads_init()
DECLARE SUB gdk_threads_set_lock_functions(BYVAL AS GCallback, BYVAL AS GCallback)
DECLARE FUNCTION gdk_threads_add_idle_full(BYVAL AS gint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION gdk_threads_add_idle(BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION gdk_threads_add_timeout_full(BYVAL AS gint, BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION gdk_threads_add_timeout(BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint
DECLARE FUNCTION gdk_threads_add_timeout_seconds_full(BYVAL AS gint, BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer, BYVAL AS GDestroyNotify) AS guint
DECLARE FUNCTION gdk_threads_add_timeout_seconds(BYVAL AS guint, BYVAL AS GSourceFunc, BYVAL AS gpointer) AS guint

#IFDEF G_THREADS_ENABLED

#MACRO GDK_THREADS_ENTER()
  IF (gdk_threads_lock) THEN
    gdk_threads_lock()
  END IF
#ENDMACRO

#MACRO GDK_THREADS_LEAVE()
  IF (gdk_threads_unlock) THEN
    gdk_threads_unlock()
  END IF
#ENDMACRO

#ELSE ' G_THREADS_ENABLED
#DEFINE GDK_THREADS_ENTER()
#DEFINE GDK_THREADS_LEAVE()
#ENDIF ' G_THREADS_ENABLED
#ENDIF ' __GDK_H__

END EXTERN

#IFDEF __FB_WIN32__
 #PRAGMA pop(msbitfields)
#ENDIF
