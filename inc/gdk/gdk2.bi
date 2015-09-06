'' FreeBASIC binding for gtk+-2.24.28
''
'' based on the C header files:
''   GDK - The GIMP Drawing Kit
''   Copyright (C) 1995-1997 Peter Mattis, Spencer Kimball and Josh MacDonald
''
''   This library is free software; you can redistribute it and/or
''   modify it under the terms of the GNU Lesser General Public
''   License as published by the Free Software Foundation; either
''   version 2 of the License, or (at your option) any later version.
''
''   This library is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
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
	#inclib "gdk-x11-2.0"
#else
	#inclib "gdk-win32-2.0"
#endif

#include once "crt/long.bi"
#include once "gio/gio.bi"
#include once "cairo/cairo.bi"
#include once "glib.bi"
#include once "pango/pango.bi"
#include once "glib-object.bi"
#include once "gdk-pixbuf/gdk-pixbuf.bi"
#include once "pango/pangocairo.bi"

'' The following symbols have been renamed:
''     procedure gdk_drag_status => gdk_drag_status_
''     procedure gdk_drag_motion => gdk_drag_motion_
''     procedure gdk_property_delete => gdk_property_delete_
''     procedure gdk_threads_enter => gdk_threads_enter_
''     procedure gdk_threads_leave => gdk_threads_leave_

#ifdef __FB_WIN32__
#pragma push(msbitfields)
#endif

extern "C"

#define __GDK_H__
#define __GDK_H_INSIDE__
#define __GDK_APP_LAUNCH_CONTEXT_H__
#define __GDK_SCREEN_H__
#define __GDK_TYPES_H__
const GDK_CURRENT_TIME = cast(clong, 0)
const GDK_PARENT_RELATIVE = cast(clong, 1)

type GdkPoint as _GdkPoint
type GdkRectangle as _GdkRectangle
type GdkSegment as _GdkSegment
type GdkSpan as _GdkSpan
type GdkWChar as guint32
type GdkAtom as _GdkAtom ptr
#define GDK_ATOM_TO_POINTER(atom) (atom)
#define GDK_POINTER_TO_ATOM(ptr) cast(GdkAtom, (ptr))

#ifdef __FB_UNIX__
	#define GDK_GPOINTER_TO_NATIVE_WINDOW(p) GPOINTER_TO_UINT(p)
#else
	#define GDK_GPOINTER_TO_NATIVE_WINDOW(p) cast(GdkNativeWindow, (p))
#endif

#define _GDK_MAKE_ATOM(val) cast(GdkAtom, GUINT_TO_POINTER(val))
#define GDK_NONE _GDK_MAKE_ATOM(0)

#ifdef __FB_UNIX__
	type GdkNativeWindow as guint32
#else
	type GdkNativeWindow as gpointer
#endif

type GdkColor as _GdkColor
type GdkColormap as _GdkColormap
type GdkCursor as _GdkCursor
type GdkFont as _GdkFont
type GdkGC as _GdkGC
type GdkImage as _GdkImage
type GdkRegion as _GdkRegion
type GdkVisual as _GdkVisual
type GdkDrawable as _GdkDrawable
type GdkBitmap as _GdkDrawable
type GdkPixmap as _GdkDrawable
type GdkWindow as _GdkDrawable
type GdkDisplay as _GdkDisplay
type GdkScreen as _GdkScreen

type GdkByteOrder as long
enum
	GDK_LSB_FIRST
	GDK_MSB_FIRST
end enum

type GdkModifierType as long
enum
	GDK_SHIFT_MASK = 1 shl 0
	GDK_LOCK_MASK = 1 shl 1
	GDK_CONTROL_MASK = 1 shl 2
	GDK_MOD1_MASK = 1 shl 3
	GDK_MOD2_MASK = 1 shl 4
	GDK_MOD3_MASK = 1 shl 5
	GDK_MOD4_MASK = 1 shl 6
	GDK_MOD5_MASK = 1 shl 7
	GDK_BUTTON1_MASK = 1 shl 8
	GDK_BUTTON2_MASK = 1 shl 9
	GDK_BUTTON3_MASK = 1 shl 10
	GDK_BUTTON4_MASK = 1 shl 11
	GDK_BUTTON5_MASK = 1 shl 12
	GDK_SUPER_MASK = 1 shl 26
	GDK_HYPER_MASK = 1 shl 27
	GDK_META_MASK = 1 shl 28
	GDK_RELEASE_MASK = 1 shl 30
	GDK_MODIFIER_MASK = &h5c001fff
end enum

type GdkInputCondition as long
enum
	GDK_INPUT_READ = 1 shl 0
	GDK_INPUT_WRITE = 1 shl 1
	GDK_INPUT_EXCEPTION = 1 shl 2
end enum

type GdkStatus as long
enum
	GDK_OK = 0
	GDK_ERROR = -1
	GDK_ERROR_PARAM = -2
	GDK_ERROR_FILE = -3
	GDK_ERROR_MEM = -4
end enum

type GdkGrabStatus as long
enum
	GDK_GRAB_SUCCESS = 0
	GDK_GRAB_ALREADY_GRABBED = 1
	GDK_GRAB_INVALID_TIME = 2
	GDK_GRAB_NOT_VIEWABLE = 3
	GDK_GRAB_FROZEN = 4
end enum

type GdkInputFunction as sub(byval data as gpointer, byval source as gint, byval condition as GdkInputCondition)
type GdkDestroyNotify as sub(byval data as gpointer)

type _GdkPoint
	x as gint
	y as gint
end type

type _GdkRectangle
	x as gint
	y as gint
	width as gint
	height as gint
end type

type _GdkSegment
	x1 as gint
	y1 as gint
	x2 as gint
	y2 as gint
end type

type _GdkSpan
	x as gint
	y as gint
	width as gint
end type

#define __GDK_DISPLAY_H__
#define __GDK_EVENTS_H__
#define __GDK_COLOR_H__

type _GdkColor
	pixel as guint32
	red as guint16
	green as guint16
	blue as guint16
end type

type GdkColormapClass as _GdkColormapClass
#define GDK_TYPE_COLORMAP gdk_colormap_get_type()
#define GDK_COLORMAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_COLORMAP, GdkColormap)
#define GDK_COLORMAP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_COLORMAP, GdkColormapClass)
#define GDK_IS_COLORMAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_COLORMAP)
#define GDK_IS_COLORMAP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_COLORMAP)
#define GDK_COLORMAP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_COLORMAP, GdkColormapClass)
#define GDK_TYPE_COLOR gdk_color_get_type()

type _GdkColormap
	parent_instance as GObject
	size as gint
	colors as GdkColor ptr
	visual as GdkVisual ptr
	windowing_data as gpointer
end type

type _GdkColormapClass
	parent_class as GObjectClass
end type

declare function gdk_colormap_get_type() as GType
declare function gdk_colormap_new(byval visual as GdkVisual ptr, byval allocate as gboolean) as GdkColormap ptr
declare function gdk_colormap_ref(byval cmap as GdkColormap ptr) as GdkColormap ptr
declare sub gdk_colormap_unref(byval cmap as GdkColormap ptr)
declare function gdk_colormap_get_system() as GdkColormap ptr
declare function gdk_colormap_get_screen(byval cmap as GdkColormap ptr) as GdkScreen ptr
declare function gdk_colormap_get_system_size() as gint
declare sub gdk_colormap_change(byval colormap as GdkColormap ptr, byval ncolors as gint)
declare function gdk_colormap_alloc_colors(byval colormap as GdkColormap ptr, byval colors as GdkColor ptr, byval n_colors as gint, byval writeable as gboolean, byval best_match as gboolean, byval success as gboolean ptr) as gint
declare function gdk_colormap_alloc_color(byval colormap as GdkColormap ptr, byval color as GdkColor ptr, byval writeable as gboolean, byval best_match as gboolean) as gboolean
declare sub gdk_colormap_free_colors(byval colormap as GdkColormap ptr, byval colors as const GdkColor ptr, byval n_colors as gint)
declare sub gdk_colormap_query_color(byval colormap as GdkColormap ptr, byval pixel as gulong, byval result as GdkColor ptr)
declare function gdk_colormap_get_visual(byval colormap as GdkColormap ptr) as GdkVisual ptr
declare function gdk_color_copy(byval color as const GdkColor ptr) as GdkColor ptr
declare sub gdk_color_free(byval color as GdkColor ptr)
declare function gdk_color_parse(byval spec as const gchar ptr, byval color as GdkColor ptr) as gboolean
declare function gdk_color_hash(byval colora as const GdkColor ptr) as guint
declare function gdk_color_equal(byval colora as const GdkColor ptr, byval colorb as const GdkColor ptr) as gboolean
declare function gdk_color_to_string(byval color as const GdkColor ptr) as gchar ptr
declare function gdk_color_get_type() as GType
declare sub gdk_colors_store(byval colormap as GdkColormap ptr, byval colors as GdkColor ptr, byval ncolors as gint)
declare function gdk_color_white(byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_black(byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_alloc(byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_color_change(byval colormap as GdkColormap ptr, byval color as GdkColor ptr) as gint
declare function gdk_colors_alloc(byval colormap as GdkColormap ptr, byval contiguous as gboolean, byval planes as gulong ptr, byval nplanes as gint, byval pixels as gulong ptr, byval npixels as gint) as gint
declare sub gdk_colors_free(byval colormap as GdkColormap ptr, byval pixels as gulong ptr, byval npixels as gint, byval planes as gulong)
#define __GDK_DND_H__
type GdkDragContext as _GdkDragContext

type GdkDragAction as long
enum
	GDK_ACTION_DEFAULT = 1 shl 0
	GDK_ACTION_COPY = 1 shl 1
	GDK_ACTION_MOVE = 1 shl 2
	GDK_ACTION_LINK = 1 shl 3
	GDK_ACTION_PRIVATE = 1 shl 4
	GDK_ACTION_ASK = 1 shl 5
end enum

type GdkDragProtocol as long
enum
	GDK_DRAG_PROTO_MOTIF
	GDK_DRAG_PROTO_XDND
	GDK_DRAG_PROTO_ROOTWIN
	GDK_DRAG_PROTO_NONE
	GDK_DRAG_PROTO_WIN32_DROPFILES
	GDK_DRAG_PROTO_OLE2
	GDK_DRAG_PROTO_LOCAL
end enum

type GdkDragContextClass as _GdkDragContextClass
#define GDK_TYPE_DRAG_CONTEXT gdk_drag_context_get_type()
#define GDK_DRAG_CONTEXT(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DRAG_CONTEXT, GdkDragContext)
#define GDK_DRAG_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_DRAG_CONTEXT, GdkDragContextClass)
#define GDK_IS_DRAG_CONTEXT(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DRAG_CONTEXT)
#define GDK_IS_DRAG_CONTEXT_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_DRAG_CONTEXT)
#define GDK_DRAG_CONTEXT_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_DRAG_CONTEXT, GdkDragContextClass)

type _GdkDragContext
	parent_instance as GObject
	protocol as GdkDragProtocol
	is_source as gboolean
	source_window as GdkWindow ptr
	dest_window as GdkWindow ptr
	targets as GList ptr
	actions as GdkDragAction
	suggested_action as GdkDragAction
	action as GdkDragAction
	start_time as guint32
	windowing_data as gpointer
end type

type _GdkDragContextClass
	parent_class as GObjectClass
end type

declare function gdk_drag_context_get_type() as GType
declare function gdk_drag_context_new() as GdkDragContext ptr
declare function gdk_drag_context_list_targets(byval context as GdkDragContext ptr) as GList ptr
declare function gdk_drag_context_get_actions(byval context as GdkDragContext ptr) as GdkDragAction
declare function gdk_drag_context_get_suggested_action(byval context as GdkDragContext ptr) as GdkDragAction
declare function gdk_drag_context_get_selected_action(byval context as GdkDragContext ptr) as GdkDragAction
declare function gdk_drag_context_get_source_window(byval context as GdkDragContext ptr) as GdkWindow ptr
declare function gdk_drag_context_get_dest_window(byval context as GdkDragContext ptr) as GdkWindow ptr
declare function gdk_drag_context_get_protocol(byval context as GdkDragContext ptr) as GdkDragProtocol
declare sub gdk_drag_context_ref(byval context as GdkDragContext ptr)
declare sub gdk_drag_context_unref(byval context as GdkDragContext ptr)
declare sub gdk_drag_status_ alias "gdk_drag_status"(byval context as GdkDragContext ptr, byval action as GdkDragAction, byval time_ as guint32)
declare sub gdk_drop_reply(byval context as GdkDragContext ptr, byval ok as gboolean, byval time_ as guint32)
declare sub gdk_drop_finish(byval context as GdkDragContext ptr, byval success as gboolean, byval time_ as guint32)
declare function gdk_drag_get_selection(byval context as GdkDragContext ptr) as GdkAtom
declare function gdk_drag_begin(byval window as GdkWindow ptr, byval targets as GList ptr) as GdkDragContext ptr
declare function gdk_drag_get_protocol_for_display(byval display as GdkDisplay ptr, byval xid as GdkNativeWindow, byval protocol as GdkDragProtocol ptr) as GdkNativeWindow
declare sub gdk_drag_find_window_for_screen(byval context as GdkDragContext ptr, byval drag_window as GdkWindow ptr, byval screen as GdkScreen ptr, byval x_root as gint, byval y_root as gint, byval dest_window as GdkWindow ptr ptr, byval protocol as GdkDragProtocol ptr)
declare function gdk_drag_get_protocol(byval xid as GdkNativeWindow, byval protocol as GdkDragProtocol ptr) as GdkNativeWindow
declare sub gdk_drag_find_window(byval context as GdkDragContext ptr, byval drag_window as GdkWindow ptr, byval x_root as gint, byval y_root as gint, byval dest_window as GdkWindow ptr ptr, byval protocol as GdkDragProtocol ptr)
declare function gdk_drag_motion_ alias "gdk_drag_motion"(byval context as GdkDragContext ptr, byval dest_window as GdkWindow ptr, byval protocol as GdkDragProtocol, byval x_root as gint, byval y_root as gint, byval suggested_action as GdkDragAction, byval possible_actions as GdkDragAction, byval time_ as guint32) as gboolean
declare sub gdk_drag_drop(byval context as GdkDragContext ptr, byval time_ as guint32)
declare sub gdk_drag_abort(byval context as GdkDragContext ptr, byval time_ as guint32)
declare function gdk_drag_drop_succeeded(byval context as GdkDragContext ptr) as gboolean

#define __GDK_INPUT_H__
#define GDK_TYPE_DEVICE gdk_device_get_type()
#define GDK_DEVICE(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DEVICE, GdkDevice)
#define GDK_DEVICE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_DEVICE, GdkDeviceClass)
#define GDK_IS_DEVICE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DEVICE)
#define GDK_IS_DEVICE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_DEVICE)
#define GDK_DEVICE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_DEVICE, GdkDeviceClass)

type GdkDeviceKey as _GdkDeviceKey
type GdkDeviceAxis as _GdkDeviceAxis
type GdkDevice as _GdkDevice
type GdkDeviceClass as _GdkDeviceClass
type GdkTimeCoord as _GdkTimeCoord

type GdkExtensionMode as long
enum
	GDK_EXTENSION_EVENTS_NONE
	GDK_EXTENSION_EVENTS_ALL
	GDK_EXTENSION_EVENTS_CURSOR
end enum

type GdkInputSource as long
enum
	GDK_SOURCE_MOUSE
	GDK_SOURCE_PEN
	GDK_SOURCE_ERASER
	GDK_SOURCE_CURSOR
end enum

type GdkInputMode as long
enum
	GDK_MODE_DISABLED
	GDK_MODE_SCREEN
	GDK_MODE_WINDOW
end enum

type GdkAxisUse as long
enum
	GDK_AXIS_IGNORE
	GDK_AXIS_X
	GDK_AXIS_Y
	GDK_AXIS_PRESSURE
	GDK_AXIS_XTILT
	GDK_AXIS_YTILT
	GDK_AXIS_WHEEL
	GDK_AXIS_LAST
end enum

type _GdkDeviceKey
	keyval as guint
	modifiers as GdkModifierType
end type

type _GdkDeviceAxis
	use as GdkAxisUse
	min as gdouble
	max as gdouble
end type

type _GdkDevice
	parent_instance as GObject
	name as gchar ptr
	source as GdkInputSource
	mode as GdkInputMode
	has_cursor as gboolean
	num_axes as gint
	axes as GdkDeviceAxis ptr
	num_keys as gint
	keys as GdkDeviceKey ptr
end type

const GDK_MAX_TIMECOORD_AXES = 128

type _GdkTimeCoord
	time as guint32
	axes(0 to 127) as gdouble
end type

declare function gdk_device_get_type() as GType
declare function gdk_devices_list() as GList ptr
declare function gdk_device_get_name(byval device as GdkDevice ptr) as const gchar ptr
declare function gdk_device_get_source(byval device as GdkDevice ptr) as GdkInputSource
declare function gdk_device_get_mode(byval device as GdkDevice ptr) as GdkInputMode
declare function gdk_device_get_has_cursor(byval device as GdkDevice ptr) as gboolean
declare sub gdk_device_get_key(byval device as GdkDevice ptr, byval index as guint, byval keyval as guint ptr, byval modifiers as GdkModifierType ptr)
declare function gdk_device_get_axis_use(byval device as GdkDevice ptr, byval index as guint) as GdkAxisUse
declare function gdk_device_get_n_keys(byval device as GdkDevice ptr) as gint
declare function gdk_device_get_n_axes(byval device as GdkDevice ptr) as gint
declare sub gdk_device_set_source(byval device as GdkDevice ptr, byval source as GdkInputSource)
declare function gdk_device_set_mode(byval device as GdkDevice ptr, byval mode as GdkInputMode) as gboolean
declare sub gdk_device_set_key(byval device as GdkDevice ptr, byval index_ as guint, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gdk_device_set_axis_use(byval device as GdkDevice ptr, byval index_ as guint, byval use as GdkAxisUse)
declare sub gdk_device_get_state(byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval axes as gdouble ptr, byval mask as GdkModifierType ptr)
declare function gdk_device_get_history(byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval start as guint32, byval stop as guint32, byval events as GdkTimeCoord ptr ptr ptr, byval n_events as gint ptr) as gboolean
declare sub gdk_device_free_history(byval events as GdkTimeCoord ptr ptr, byval n_events as gint)
declare function gdk_device_get_axis(byval device as GdkDevice ptr, byval axes as gdouble ptr, byval use as GdkAxisUse, byval value as gdouble ptr) as gboolean
declare sub gdk_input_set_extension_events(byval window as GdkWindow ptr, byval mask as gint, byval mode as GdkExtensionMode)
declare function gdk_device_get_core_pointer() as GdkDevice ptr

#define GDK_TYPE_EVENT gdk_event_get_type()
const GDK_PRIORITY_EVENTS = G_PRIORITY_DEFAULT
const GDK_PRIORITY_REDRAW = G_PRIORITY_HIGH_IDLE + 20

type GdkEventAny as _GdkEventAny
type GdkEventExpose as _GdkEventExpose
type GdkEventNoExpose as _GdkEventNoExpose
type GdkEventVisibility as _GdkEventVisibility
type GdkEventMotion as _GdkEventMotion
type GdkEventButton as _GdkEventButton
type GdkEventScroll as _GdkEventScroll
type GdkEventKey as _GdkEventKey
type GdkEventFocus as _GdkEventFocus
type GdkEventCrossing as _GdkEventCrossing
type GdkEventConfigure as _GdkEventConfigure
type GdkEventProperty as _GdkEventProperty
type GdkEventSelection as _GdkEventSelection
type GdkEventOwnerChange as _GdkEventOwnerChange
type GdkEventProximity as _GdkEventProximity
type GdkEventClient as _GdkEventClient
type GdkEventDND as _GdkEventDND
type GdkEventWindowState as _GdkEventWindowState
type GdkEventSetting as _GdkEventSetting
type GdkEventGrabBroken as _GdkEventGrabBroken
type GdkEvent as _GdkEvent
type GdkEventFunc as sub(byval event as GdkEvent ptr, byval data as gpointer)
type GdkXEvent as any

type GdkFilterReturn as long
enum
	GDK_FILTER_CONTINUE
	GDK_FILTER_TRANSLATE
	GDK_FILTER_REMOVE
end enum

type GdkFilterFunc as function(byval xevent as GdkXEvent ptr, byval event as GdkEvent ptr, byval data as gpointer) as GdkFilterReturn

type GdkEventType as long
enum
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
end enum

type GdkEventMask as long
enum
	GDK_EXPOSURE_MASK = 1 shl 1
	GDK_POINTER_MOTION_MASK = 1 shl 2
	GDK_POINTER_MOTION_HINT_MASK = 1 shl 3
	GDK_BUTTON_MOTION_MASK = 1 shl 4
	GDK_BUTTON1_MOTION_MASK = 1 shl 5
	GDK_BUTTON2_MOTION_MASK = 1 shl 6
	GDK_BUTTON3_MOTION_MASK = 1 shl 7
	GDK_BUTTON_PRESS_MASK = 1 shl 8
	GDK_BUTTON_RELEASE_MASK = 1 shl 9
	GDK_KEY_PRESS_MASK = 1 shl 10
	GDK_KEY_RELEASE_MASK = 1 shl 11
	GDK_ENTER_NOTIFY_MASK = 1 shl 12
	GDK_LEAVE_NOTIFY_MASK = 1 shl 13
	GDK_FOCUS_CHANGE_MASK = 1 shl 14
	GDK_STRUCTURE_MASK = 1 shl 15
	GDK_PROPERTY_CHANGE_MASK = 1 shl 16
	GDK_VISIBILITY_NOTIFY_MASK = 1 shl 17
	GDK_PROXIMITY_IN_MASK = 1 shl 18
	GDK_PROXIMITY_OUT_MASK = 1 shl 19
	GDK_SUBSTRUCTURE_MASK = 1 shl 20
	GDK_SCROLL_MASK = 1 shl 21
	GDK_ALL_EVENTS_MASK = &h3FFFFE
end enum

type GdkVisibilityState as long
enum
	GDK_VISIBILITY_UNOBSCURED
	GDK_VISIBILITY_PARTIAL
	GDK_VISIBILITY_FULLY_OBSCURED
end enum

type GdkScrollDirection as long
enum
	GDK_SCROLL_UP
	GDK_SCROLL_DOWN
	GDK_SCROLL_LEFT
	GDK_SCROLL_RIGHT
end enum

type GdkNotifyType as long
enum
	GDK_NOTIFY_ANCESTOR = 0
	GDK_NOTIFY_VIRTUAL = 1
	GDK_NOTIFY_INFERIOR = 2
	GDK_NOTIFY_NONLINEAR = 3
	GDK_NOTIFY_NONLINEAR_VIRTUAL = 4
	GDK_NOTIFY_UNKNOWN = 5
end enum

type GdkCrossingMode as long
enum
	GDK_CROSSING_NORMAL
	GDK_CROSSING_GRAB
	GDK_CROSSING_UNGRAB
	GDK_CROSSING_GTK_GRAB
	GDK_CROSSING_GTK_UNGRAB
	GDK_CROSSING_STATE_CHANGED
end enum

type GdkPropertyState as long
enum
	GDK_PROPERTY_NEW_VALUE
	GDK_PROPERTY_DELETE
end enum

type GdkWindowState as long
enum
	GDK_WINDOW_STATE_WITHDRAWN = 1 shl 0
	GDK_WINDOW_STATE_ICONIFIED = 1 shl 1
	GDK_WINDOW_STATE_MAXIMIZED = 1 shl 2
	GDK_WINDOW_STATE_STICKY = 1 shl 3
	GDK_WINDOW_STATE_FULLSCREEN = 1 shl 4
	GDK_WINDOW_STATE_ABOVE = 1 shl 5
	GDK_WINDOW_STATE_BELOW = 1 shl 6
end enum

type GdkSettingAction as long
enum
	GDK_SETTING_ACTION_NEW
	GDK_SETTING_ACTION_CHANGED
	GDK_SETTING_ACTION_DELETED
end enum

type GdkOwnerChange as long
enum
	GDK_OWNER_CHANGE_NEW_OWNER
	GDK_OWNER_CHANGE_DESTROY
	GDK_OWNER_CHANGE_CLOSE
end enum

type _GdkEventAny
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
end type

type _GdkEventExpose
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	area as GdkRectangle
	region as GdkRegion ptr
	count as gint
end type

type _GdkEventNoExpose
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
end type

type _GdkEventVisibility
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	state as GdkVisibilityState
end type

type _GdkEventMotion
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	axes as gdouble ptr
	state as guint
	is_hint as gint16
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
end type

type _GdkEventButton
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	axes as gdouble ptr
	state as guint
	button as guint
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
end type

type _GdkEventScroll
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	x as gdouble
	y as gdouble
	state as guint
	direction as GdkScrollDirection
	device as GdkDevice ptr
	x_root as gdouble
	y_root as gdouble
end type

type _GdkEventKey
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	state as guint
	keyval as guint
	length as gint
	string as gchar ptr
	hardware_keycode as guint16
	group as guint8
	is_modifier : 1 as guint
end type

type _GdkEventCrossing
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	subwindow as GdkWindow ptr
	time as guint32
	x as gdouble
	y as gdouble
	x_root as gdouble
	y_root as gdouble
	mode as GdkCrossingMode
	detail as GdkNotifyType
	focus as gboolean
	state as guint
end type

type _GdkEventFocus
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	in as gint16
end type

type _GdkEventConfigure
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	x as gint
	y as gint
	width as gint
	height as gint
end type

type _GdkEventProperty
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	atom as GdkAtom
	time as guint32
	state as guint
end type

type _GdkEventSelection
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	selection as GdkAtom
	target as GdkAtom
	property as GdkAtom
	time as guint32
	requestor as GdkNativeWindow
end type

type _GdkEventOwnerChange
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	owner as GdkNativeWindow
	reason as GdkOwnerChange
	selection as GdkAtom
	time as guint32
	selection_time as guint32
end type

type _GdkEventProximity
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	device as GdkDevice ptr
end type

union _GdkEventClient_data
	b as zstring * 20
	s(0 to 9) as short
	l(0 to 4) as clong
end union

type _GdkEventClient
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	message_type as GdkAtom
	data_format as gushort
	data as _GdkEventClient_data
end type

type _GdkEventSetting
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	action as GdkSettingAction
	name as zstring ptr
end type

type _GdkEventWindowState
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	changed_mask as GdkWindowState
	new_window_state as GdkWindowState
end type

type _GdkEventGrabBroken
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	keyboard as gboolean
	implicit as gboolean
	grab_window as GdkWindow ptr
end type

type _GdkEventDND
	as GdkEventType type
	window as GdkWindow ptr
	send_event as gint8
	context as GdkDragContext ptr
	time as guint32
	x_root as gshort
	y_root as gshort
end type

union _GdkEvent
	as GdkEventType type
	any as GdkEventAny
	expose as GdkEventExpose
	no_expose as GdkEventNoExpose
	visibility as GdkEventVisibility
	motion as GdkEventMotion
	button as GdkEventButton
	scroll as GdkEventScroll
	key as GdkEventKey
	crossing as GdkEventCrossing
	focus_change as GdkEventFocus
	configure as GdkEventConfigure
	property as GdkEventProperty
	selection as GdkEventSelection
	owner_change as GdkEventOwnerChange
	proximity as GdkEventProximity
	client as GdkEventClient
	dnd as GdkEventDND
	window_state as GdkEventWindowState
	setting as GdkEventSetting
	grab_broken as GdkEventGrabBroken
end union

declare function gdk_event_get_type() as GType
declare function gdk_events_pending() as gboolean
declare function gdk_event_get() as GdkEvent ptr
declare function gdk_event_peek() as GdkEvent ptr
declare function gdk_event_get_graphics_expose(byval window as GdkWindow ptr) as GdkEvent ptr
declare sub gdk_event_put(byval event as const GdkEvent ptr)
declare function gdk_event_new(byval type as GdkEventType) as GdkEvent ptr
declare function gdk_event_copy(byval event as const GdkEvent ptr) as GdkEvent ptr
declare sub gdk_event_free(byval event as GdkEvent ptr)
declare function gdk_event_get_time(byval event as const GdkEvent ptr) as guint32
declare function gdk_event_get_state(byval event as const GdkEvent ptr, byval state as GdkModifierType ptr) as gboolean
declare function gdk_event_get_coords(byval event as const GdkEvent ptr, byval x_win as gdouble ptr, byval y_win as gdouble ptr) as gboolean
declare function gdk_event_get_root_coords(byval event as const GdkEvent ptr, byval x_root as gdouble ptr, byval y_root as gdouble ptr) as gboolean
declare function gdk_event_get_axis(byval event as const GdkEvent ptr, byval axis_use as GdkAxisUse, byval value as gdouble ptr) as gboolean
declare sub gdk_event_request_motions(byval event as const GdkEventMotion ptr)
declare sub gdk_event_handler_set(byval func as GdkEventFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub gdk_event_set_screen(byval event as GdkEvent ptr, byval screen as GdkScreen ptr)
declare function gdk_event_get_screen(byval event as const GdkEvent ptr) as GdkScreen ptr
declare sub gdk_set_show_events(byval show_events as gboolean)
declare function gdk_get_show_events() as gboolean
declare sub gdk_add_client_message_filter(byval message_type as GdkAtom, byval func as GdkFilterFunc, byval data as gpointer)
declare function gdk_setting_get(byval name as const gchar ptr, byval value as GValue ptr) as gboolean
type GdkDisplayClass as _GdkDisplayClass
type GdkDisplayPointerHooks as _GdkDisplayPointerHooks

#define GDK_TYPE_DISPLAY gdk_display_get_type()
#define GDK_DISPLAY_OBJECT(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DISPLAY, GdkDisplay)
#define GDK_DISPLAY_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_DISPLAY, GdkDisplayClass)
#define GDK_IS_DISPLAY(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DISPLAY)
#define GDK_IS_DISPLAY_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_DISPLAY)
#define GDK_DISPLAY_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_DISPLAY, GdkDisplayClass)

type GdkKeyboardGrabInfo
	window as GdkWindow ptr
	native_window as GdkWindow ptr
	serial as gulong
	owner_events as gboolean
	time as guint32
end type

type GdkPointerWindowInfo
	toplevel_under_pointer as GdkWindow ptr
	window_under_pointer as GdkWindow ptr
	toplevel_x as gdouble
	toplevel_y as gdouble
	state as guint32
	button as guint32
	motion_hint_serial as gulong
end type

type _GdkDisplay
	parent_instance as GObject
	queued_events as GList ptr
	queued_tail as GList ptr
	button_click_time(0 to 1) as guint32
	button_window(0 to 1) as GdkWindow ptr
	button_number(0 to 1) as gint
	double_click_time as guint
	core_pointer as GdkDevice ptr
	pointer_hooks as const GdkDisplayPointerHooks ptr
	closed : 1 as guint
	ignore_core_events : 1 as guint
	double_click_distance as guint
	button_x(0 to 1) as gint
	button_y(0 to 1) as gint
	pointer_grabs as GList ptr
	keyboard_grab as GdkKeyboardGrabInfo
	pointer_info as GdkPointerWindowInfo
	last_event_time as guint32
end type

type _GdkDisplayClass
	parent_class as GObjectClass
	get_display_name as function(byval display as GdkDisplay ptr) as const gchar ptr
	get_n_screens as function(byval display as GdkDisplay ptr) as gint
	get_screen as function(byval display as GdkDisplay ptr, byval screen_num as gint) as GdkScreen ptr
	get_default_screen as function(byval display as GdkDisplay ptr) as GdkScreen ptr
	closed as sub(byval display as GdkDisplay ptr, byval is_error as gboolean)
end type

type _GdkDisplayPointerHooks
	get_pointer as sub(byval display as GdkDisplay ptr, byval screen as GdkScreen ptr ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr)
	window_get_pointer as function(byval display as GdkDisplay ptr, byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
	window_at_pointer as function(byval display as GdkDisplay ptr, byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
end type

declare function gdk_display_get_type() as GType
declare function gdk_display_open(byval display_name as const gchar ptr) as GdkDisplay ptr
declare function gdk_display_get_name(byval display as GdkDisplay ptr) as const gchar ptr
declare function gdk_display_get_n_screens(byval display as GdkDisplay ptr) as gint
declare function gdk_display_get_screen(byval display as GdkDisplay ptr, byval screen_num as gint) as GdkScreen ptr
declare function gdk_display_get_default_screen(byval display as GdkDisplay ptr) as GdkScreen ptr
declare sub gdk_display_pointer_ungrab(byval display as GdkDisplay ptr, byval time_ as guint32)
declare sub gdk_display_keyboard_ungrab(byval display as GdkDisplay ptr, byval time_ as guint32)
declare function gdk_display_pointer_is_grabbed(byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_beep(byval display as GdkDisplay ptr)
declare sub gdk_display_sync(byval display as GdkDisplay ptr)
declare sub gdk_display_flush(byval display as GdkDisplay ptr)
declare sub gdk_display_close(byval display as GdkDisplay ptr)
declare function gdk_display_is_closed(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_list_devices(byval display as GdkDisplay ptr) as GList ptr
declare function gdk_display_get_event(byval display as GdkDisplay ptr) as GdkEvent ptr
declare function gdk_display_peek_event(byval display as GdkDisplay ptr) as GdkEvent ptr
declare sub gdk_display_put_event(byval display as GdkDisplay ptr, byval event as const GdkEvent ptr)
declare sub gdk_display_add_client_message_filter(byval display as GdkDisplay ptr, byval message_type as GdkAtom, byval func as GdkFilterFunc, byval data as gpointer)
declare sub gdk_display_set_double_click_time(byval display as GdkDisplay ptr, byval msec as guint)
declare sub gdk_display_set_double_click_distance(byval display as GdkDisplay ptr, byval distance as guint)
declare function gdk_display_get_default() as GdkDisplay ptr
declare function gdk_display_get_core_pointer(byval display as GdkDisplay ptr) as GdkDevice ptr
declare sub gdk_display_get_pointer(byval display as GdkDisplay ptr, byval screen as GdkScreen ptr ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr)
declare function gdk_display_get_window_at_pointer(byval display as GdkDisplay ptr, byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare sub gdk_display_warp_pointer(byval display as GdkDisplay ptr, byval screen as GdkScreen ptr, byval x as gint, byval y as gint)
declare function gdk_display_set_pointer_hooks(byval display as GdkDisplay ptr, byval new_hooks as const GdkDisplayPointerHooks ptr) as GdkDisplayPointerHooks ptr
declare function gdk_display_open_default_libgtk_only() as GdkDisplay ptr
declare function gdk_display_supports_cursor_alpha(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_cursor_color(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_get_default_cursor_size(byval display as GdkDisplay ptr) as guint
declare sub gdk_display_get_maximal_cursor_size(byval display as GdkDisplay ptr, byval width as guint ptr, byval height as guint ptr)
declare function gdk_display_get_default_group(byval display as GdkDisplay ptr) as GdkWindow ptr
declare function gdk_display_supports_selection_notification(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_request_selection_notification(byval display as GdkDisplay ptr, byval selection as GdkAtom) as gboolean
declare function gdk_display_supports_clipboard_persistence(byval display as GdkDisplay ptr) as gboolean
declare sub gdk_display_store_clipboard(byval display as GdkDisplay ptr, byval clipboard_window as GdkWindow ptr, byval time_ as guint32, byval targets as const GdkAtom ptr, byval n_targets as gint)
declare function gdk_display_supports_shapes(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_input_shapes(byval display as GdkDisplay ptr) as gboolean
declare function gdk_display_supports_composite(byval display as GdkDisplay ptr) as gboolean
type GdkScreenClass as _GdkScreenClass

#define GDK_TYPE_SCREEN gdk_screen_get_type()
#define GDK_SCREEN(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_SCREEN, GdkScreen)
#define GDK_SCREEN_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_SCREEN, GdkScreenClass)
#define GDK_IS_SCREEN(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_SCREEN)
#define GDK_IS_SCREEN_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_SCREEN)
#define GDK_SCREEN_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_SCREEN, GdkScreenClass)

type _GdkScreen
	parent_instance as GObject
	closed : 1 as guint
	normal_gcs(0 to 31) as GdkGC ptr
	exposure_gcs(0 to 31) as GdkGC ptr
	subwindow_gcs(0 to 31) as GdkGC ptr
	font_options as cairo_font_options_t ptr
	resolution as double
end type

type _GdkScreenClass
	parent_class as GObjectClass
	size_changed as sub(byval screen as GdkScreen ptr)
	composited_changed as sub(byval screen as GdkScreen ptr)
	monitors_changed as sub(byval screen as GdkScreen ptr)
end type

declare function gdk_screen_get_type() as GType
declare function gdk_screen_get_default_colormap(byval screen as GdkScreen ptr) as GdkColormap ptr
declare sub gdk_screen_set_default_colormap(byval screen as GdkScreen ptr, byval colormap as GdkColormap ptr)
declare function gdk_screen_get_system_colormap(byval screen as GdkScreen ptr) as GdkColormap ptr
declare function gdk_screen_get_system_visual(byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_get_rgb_colormap(byval screen as GdkScreen ptr) as GdkColormap ptr
declare function gdk_screen_get_rgb_visual(byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_get_rgba_colormap(byval screen as GdkScreen ptr) as GdkColormap ptr
declare function gdk_screen_get_rgba_visual(byval screen as GdkScreen ptr) as GdkVisual ptr
declare function gdk_screen_is_composited(byval screen as GdkScreen ptr) as gboolean
declare function gdk_screen_get_root_window(byval screen as GdkScreen ptr) as GdkWindow ptr
declare function gdk_screen_get_display(byval screen as GdkScreen ptr) as GdkDisplay ptr
declare function gdk_screen_get_number(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_width(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_height(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_width_mm(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_height_mm(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_list_visuals(byval screen as GdkScreen ptr) as GList ptr
declare function gdk_screen_get_toplevel_windows(byval screen as GdkScreen ptr) as GList ptr
declare function gdk_screen_make_display_name(byval screen as GdkScreen ptr) as gchar ptr
declare function gdk_screen_get_n_monitors(byval screen as GdkScreen ptr) as gint
declare function gdk_screen_get_primary_monitor(byval screen as GdkScreen ptr) as gint
declare sub gdk_screen_get_monitor_geometry(byval screen as GdkScreen ptr, byval monitor_num as gint, byval dest as GdkRectangle ptr)
declare function gdk_screen_get_monitor_at_point(byval screen as GdkScreen ptr, byval x as gint, byval y as gint) as gint
declare function gdk_screen_get_monitor_at_window(byval screen as GdkScreen ptr, byval window as GdkWindow ptr) as gint
declare function gdk_screen_get_monitor_width_mm(byval screen as GdkScreen ptr, byval monitor_num as gint) as gint
declare function gdk_screen_get_monitor_height_mm(byval screen as GdkScreen ptr, byval monitor_num as gint) as gint
declare function gdk_screen_get_monitor_plug_name(byval screen as GdkScreen ptr, byval monitor_num as gint) as gchar ptr
declare sub gdk_screen_broadcast_client_message(byval screen as GdkScreen ptr, byval event as GdkEvent ptr)
declare function gdk_screen_get_default() as GdkScreen ptr
declare function gdk_screen_get_setting(byval screen as GdkScreen ptr, byval name as const gchar ptr, byval value as GValue ptr) as gboolean
declare sub gdk_screen_set_font_options(byval screen as GdkScreen ptr, byval options as const cairo_font_options_t ptr)
declare function gdk_screen_get_font_options(byval screen as GdkScreen ptr) as const cairo_font_options_t ptr
declare sub gdk_screen_set_resolution(byval screen as GdkScreen ptr, byval dpi as gdouble)
declare function gdk_screen_get_resolution(byval screen as GdkScreen ptr) as gdouble
declare function gdk_screen_get_active_window(byval screen as GdkScreen ptr) as GdkWindow ptr
declare function gdk_screen_get_window_stack(byval screen as GdkScreen ptr) as GList ptr

#define GDK_TYPE_APP_LAUNCH_CONTEXT gdk_app_launch_context_get_type()
#define GDK_APP_LAUNCH_CONTEXT(o) G_TYPE_CHECK_INSTANCE_CAST((o), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContext)
#define GDK_APP_LAUNCH_CONTEXT_CLASS(k) G_TYPE_CHECK_CLASS_CAST((k), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContextClass)
#define GDK_IS_APP_LAUNCH_CONTEXT(o) G_TYPE_CHECK_INSTANCE_TYPE((o), GDK_TYPE_APP_LAUNCH_CONTEXT)
#define GDK_IS_APP_LAUNCH_CONTEXT_CLASS(k) G_TYPE_CHECK_CLASS_TYPE((k), GDK_TYPE_APP_LAUNCH_CONTEXT)
#define GDK_APP_LAUNCH_CONTEXT_GET_CLASS(o) G_TYPE_INSTANCE_GET_CLASS((o), GDK_TYPE_APP_LAUNCH_CONTEXT, GdkAppLaunchContextClass)
type GdkAppLaunchContextPrivate as GdkAppLaunchContextPrivate_

type GdkAppLaunchContext
	parent_instance as GAppLaunchContext
	priv as GdkAppLaunchContextPrivate ptr
end type

type GdkAppLaunchContextClass
	parent_class as GAppLaunchContextClass
end type

declare function gdk_app_launch_context_get_type() as GType
declare function gdk_app_launch_context_new() as GdkAppLaunchContext ptr
declare sub gdk_app_launch_context_set_display(byval context as GdkAppLaunchContext ptr, byval display as GdkDisplay ptr)
declare sub gdk_app_launch_context_set_screen(byval context as GdkAppLaunchContext ptr, byval screen as GdkScreen ptr)
declare sub gdk_app_launch_context_set_desktop(byval context as GdkAppLaunchContext ptr, byval desktop as gint)
declare sub gdk_app_launch_context_set_timestamp(byval context as GdkAppLaunchContext ptr, byval timestamp as guint32)
declare sub gdk_app_launch_context_set_icon(byval context as GdkAppLaunchContext ptr, byval icon as GIcon ptr)
declare sub gdk_app_launch_context_set_icon_name(byval context as GdkAppLaunchContext ptr, byval icon_name as const zstring ptr)

#define __GDK_CAIRO_H__
#define __GDK_PIXBUF_H__
#define __GDK_RGB_H__
type GdkRgbCmap as _GdkRgbCmap

type GdkRgbDither as long
enum
	GDK_RGB_DITHER_NONE
	GDK_RGB_DITHER_NORMAL
	GDK_RGB_DITHER_MAX
end enum

type _GdkRgbCmap
	colors(0 to 255) as guint32
	n_colors as gint
	info_list as GSList ptr
end type

declare sub gdk_rgb_init()
declare function gdk_rgb_xpixel_from_rgb(byval rgb as guint32) as gulong
declare sub gdk_rgb_gc_set_foreground(byval gc as GdkGC ptr, byval rgb as guint32)
declare sub gdk_rgb_gc_set_background(byval gc as GdkGC ptr, byval rgb as guint32)
declare sub gdk_rgb_find_color(byval colormap as GdkColormap ptr, byval color as GdkColor ptr)
declare sub gdk_draw_rgb_image(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval rgb_buf as const guchar ptr, byval rowstride as gint)
declare sub gdk_draw_rgb_image_dithalign(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval rgb_buf as const guchar ptr, byval rowstride as gint, byval xdith as gint, byval ydith as gint)
declare sub gdk_draw_rgb_32_image(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as const guchar ptr, byval rowstride as gint)
declare sub gdk_draw_rgb_32_image_dithalign(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as const guchar ptr, byval rowstride as gint, byval xdith as gint, byval ydith as gint)
declare sub gdk_draw_gray_image(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as const guchar ptr, byval rowstride as gint)
declare sub gdk_draw_indexed_image(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval dith as GdkRgbDither, byval buf as const guchar ptr, byval rowstride as gint, byval cmap as GdkRgbCmap ptr)
declare function gdk_rgb_cmap_new(byval colors as guint32 ptr, byval n_colors as gint) as GdkRgbCmap ptr
declare sub gdk_rgb_cmap_free(byval cmap as GdkRgbCmap ptr)
declare sub gdk_rgb_set_verbose(byval verbose as gboolean)
declare sub gdk_rgb_set_install(byval install as gboolean)
declare sub gdk_rgb_set_min_colors(byval min_colors as gint)
declare function gdk_rgb_get_colormap() as GdkColormap ptr
declare function gdk_rgb_get_cmap alias "gdk_rgb_get_colormap"() as GdkColormap ptr
declare function gdk_rgb_get_visual() as GdkVisual ptr
declare function gdk_rgb_ditherable() as gboolean
declare function gdk_rgb_colormap_ditherable(byval cmap as GdkColormap ptr) as gboolean
declare sub gdk_pixbuf_render_threshold_alpha(byval pixbuf as GdkPixbuf ptr, byval bitmap as GdkBitmap ptr, byval src_x as long, byval src_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long, byval alpha_threshold as long)
declare sub gdk_pixbuf_render_to_drawable(byval pixbuf as GdkPixbuf ptr, byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src_x as long, byval src_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long, byval dither as GdkRgbDither, byval x_dither as long, byval y_dither as long)
declare sub gdk_pixbuf_render_to_drawable_alpha(byval pixbuf as GdkPixbuf ptr, byval drawable as GdkDrawable ptr, byval src_x as long, byval src_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long, byval alpha_mode as GdkPixbufAlphaMode, byval alpha_threshold as long, byval dither as GdkRgbDither, byval x_dither as long, byval y_dither as long)
declare sub gdk_pixbuf_render_pixmap_and_mask_for_colormap(byval pixbuf as GdkPixbuf ptr, byval colormap as GdkColormap ptr, byval pixmap_return as GdkPixmap ptr ptr, byval mask_return as GdkBitmap ptr ptr, byval alpha_threshold as long)
declare sub gdk_pixbuf_render_pixmap_and_mask(byval pixbuf as GdkPixbuf ptr, byval pixmap_return as GdkPixmap ptr ptr, byval mask_return as GdkBitmap ptr ptr, byval alpha_threshold as long)
declare function gdk_pixbuf_get_from_drawable(byval dest as GdkPixbuf ptr, byval src as GdkDrawable ptr, byval cmap as GdkColormap ptr, byval src_x as long, byval src_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long) as GdkPixbuf ptr
declare function gdk_pixbuf_get_from_image(byval dest as GdkPixbuf ptr, byval src as GdkImage ptr, byval cmap as GdkColormap ptr, byval src_x as long, byval src_y as long, byval dest_x as long, byval dest_y as long, byval width as long, byval height as long) as GdkPixbuf ptr
declare function gdk_cairo_create(byval drawable as GdkDrawable ptr) as cairo_t ptr
declare sub gdk_cairo_reset_clip(byval cr as cairo_t ptr, byval drawable as GdkDrawable ptr)
declare sub gdk_cairo_set_source_color(byval cr as cairo_t ptr, byval color as const GdkColor ptr)
declare sub gdk_cairo_set_source_pixbuf(byval cr as cairo_t ptr, byval pixbuf as const GdkPixbuf ptr, byval pixbuf_x as double, byval pixbuf_y as double)
declare sub gdk_cairo_set_source_pixmap(byval cr as cairo_t ptr, byval pixmap as GdkPixmap ptr, byval pixmap_x as double, byval pixmap_y as double)
declare sub gdk_cairo_set_source_window(byval cr as cairo_t ptr, byval window as GdkWindow ptr, byval x as double, byval y as double)
declare sub gdk_cairo_rectangle(byval cr as cairo_t ptr, byval rectangle as const GdkRectangle ptr)
declare sub gdk_cairo_region(byval cr as cairo_t ptr, byval region as const GdkRegion ptr)
#define __GDK_CURSOR_H__
#define GDK_TYPE_CURSOR gdk_cursor_get_type()

type GdkCursorType as long
enum
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
end enum

type _GdkCursor
	as GdkCursorType type
	ref_count as guint
end type

declare function gdk_cursor_get_type() as GType
declare function gdk_cursor_new_for_display(byval display as GdkDisplay ptr, byval cursor_type as GdkCursorType) as GdkCursor ptr
declare function gdk_cursor_new(byval cursor_type as GdkCursorType) as GdkCursor ptr
declare function gdk_cursor_new_from_pixmap(byval source as GdkPixmap ptr, byval mask as GdkPixmap ptr, byval fg as const GdkColor ptr, byval bg as const GdkColor ptr, byval x as gint, byval y as gint) as GdkCursor ptr
declare function gdk_cursor_new_from_pixbuf(byval display as GdkDisplay ptr, byval pixbuf as GdkPixbuf ptr, byval x as gint, byval y as gint) as GdkCursor ptr
declare function gdk_cursor_get_display(byval cursor as GdkCursor ptr) as GdkDisplay ptr
declare function gdk_cursor_ref(byval cursor as GdkCursor ptr) as GdkCursor ptr
declare sub gdk_cursor_unref(byval cursor as GdkCursor ptr)
declare function gdk_cursor_new_from_name(byval display as GdkDisplay ptr, byval name as const gchar ptr) as GdkCursor ptr
declare function gdk_cursor_get_image(byval cursor as GdkCursor ptr) as GdkPixbuf ptr
declare function gdk_cursor_get_cursor_type(byval cursor as GdkCursor ptr) as GdkCursorType
declare sub gdk_cursor_destroy alias "gdk_cursor_unref"(byval cursor as GdkCursor ptr)
#define __GDK_DISPLAY_MANAGER_H__
type GdkDisplayManager as _GdkDisplayManager
type GdkDisplayManagerClass as _GdkDisplayManagerClass

#define GDK_TYPE_DISPLAY_MANAGER gdk_display_manager_get_type()
#define GDK_DISPLAY_MANAGER(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManager)
#define GDK_DISPLAY_MANAGER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManagerClass)
#define GDK_IS_DISPLAY_MANAGER(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DISPLAY_MANAGER)
#define GDK_IS_DISPLAY_MANAGER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_DISPLAY_MANAGER)
#define GDK_DISPLAY_MANAGER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_DISPLAY_MANAGER, GdkDisplayManagerClass)

type _GdkDisplayManagerClass
	parent_class as GObjectClass
	display_opened as sub(byval display_manager as GdkDisplayManager ptr, byval display as GdkDisplay ptr)
end type

declare function gdk_display_manager_get_type() as GType
declare function gdk_display_manager_get() as GdkDisplayManager ptr
declare function gdk_display_manager_get_default_display(byval display_manager as GdkDisplayManager ptr) as GdkDisplay ptr
declare sub gdk_display_manager_set_default_display(byval display_manager as GdkDisplayManager ptr, byval display as GdkDisplay ptr)
declare function gdk_display_manager_list_displays(byval display_manager as GdkDisplayManager ptr) as GSList ptr
#define __GDK_DRAWABLE_H__
#define __GDK_GC_H__
type GdkGCValues as _GdkGCValues
type GdkGCClass as _GdkGCClass

type GdkCapStyle as long
enum
	GDK_CAP_NOT_LAST
	GDK_CAP_BUTT
	GDK_CAP_ROUND
	GDK_CAP_PROJECTING
end enum

type GdkFill as long
enum
	GDK_SOLID
	GDK_TILED
	GDK_STIPPLED
	GDK_OPAQUE_STIPPLED
end enum

type GdkFunction as long
enum
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
end enum

type GdkJoinStyle as long
enum
	GDK_JOIN_MITER
	GDK_JOIN_ROUND
	GDK_JOIN_BEVEL
end enum

type GdkLineStyle as long
enum
	GDK_LINE_SOLID
	GDK_LINE_ON_OFF_DASH
	GDK_LINE_DOUBLE_DASH
end enum

type GdkSubwindowMode as long
enum
	GDK_CLIP_BY_CHILDREN = 0
	GDK_INCLUDE_INFERIORS = 1
end enum

type GdkGCValuesMask as long
enum
	GDK_GC_FOREGROUND = 1 shl 0
	GDK_GC_BACKGROUND = 1 shl 1
	GDK_GC_FONT = 1 shl 2
	GDK_GC_FUNCTION = 1 shl 3
	GDK_GC_FILL = 1 shl 4
	GDK_GC_TILE = 1 shl 5
	GDK_GC_STIPPLE = 1 shl 6
	GDK_GC_CLIP_MASK = 1 shl 7
	GDK_GC_SUBWINDOW = 1 shl 8
	GDK_GC_TS_X_ORIGIN = 1 shl 9
	GDK_GC_TS_Y_ORIGIN = 1 shl 10
	GDK_GC_CLIP_X_ORIGIN = 1 shl 11
	GDK_GC_CLIP_Y_ORIGIN = 1 shl 12
	GDK_GC_EXPOSURES = 1 shl 13
	GDK_GC_LINE_WIDTH = 1 shl 14
	GDK_GC_LINE_STYLE = 1 shl 15
	GDK_GC_CAP_STYLE = 1 shl 16
	GDK_GC_JOIN_STYLE = 1 shl 17
end enum

type _GdkGCValues
	foreground as GdkColor
	background as GdkColor
	font as GdkFont ptr
	function as GdkFunction
	fill as GdkFill
	tile as GdkPixmap ptr
	stipple as GdkPixmap ptr
	clip_mask as GdkPixmap ptr
	subwindow_mode as GdkSubwindowMode
	ts_x_origin as gint
	ts_y_origin as gint
	clip_x_origin as gint
	clip_y_origin as gint
	graphics_exposures as gint
	line_width as gint
	line_style as GdkLineStyle
	cap_style as GdkCapStyle
	join_style as GdkJoinStyle
end type

#define GDK_TYPE_GC gdk_gc_get_type()
#define GDK_GC(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_GC, GdkGC)
#define GDK_GC_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_GC, GdkGCClass)
#define GDK_IS_GC(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_GC)
#define GDK_IS_GC_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_GC)
#define GDK_GC_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_GC, GdkGCClass)

type _GdkGC
	parent_instance as GObject
	clip_x_origin as gint
	clip_y_origin as gint
	ts_x_origin as gint
	ts_y_origin as gint
	colormap as GdkColormap ptr
end type

type _GdkGCClass
	parent_class as GObjectClass
	get_values as sub(byval gc as GdkGC ptr, byval values as GdkGCValues ptr)
	set_values as sub(byval gc as GdkGC ptr, byval values as GdkGCValues ptr, byval mask as GdkGCValuesMask)
	set_dashes as sub(byval gc as GdkGC ptr, byval dash_offset as gint, byval dash_list as gint8 ptr, byval n as gint)
	_gdk_reserved1 as sub()
	_gdk_reserved2 as sub()
	_gdk_reserved3 as sub()
	_gdk_reserved4 as sub()
end type

declare function gdk_gc_get_type() as GType
declare function gdk_gc_new(byval drawable as GdkDrawable ptr) as GdkGC ptr
declare function gdk_gc_new_with_values(byval drawable as GdkDrawable ptr, byval values as GdkGCValues ptr, byval values_mask as GdkGCValuesMask) as GdkGC ptr
declare function gdk_gc_ref(byval gc as GdkGC ptr) as GdkGC ptr
declare sub gdk_gc_unref(byval gc as GdkGC ptr)
declare sub gdk_gc_get_values(byval gc as GdkGC ptr, byval values as GdkGCValues ptr)
declare sub gdk_gc_set_values(byval gc as GdkGC ptr, byval values as GdkGCValues ptr, byval values_mask as GdkGCValuesMask)
declare sub gdk_gc_set_foreground(byval gc as GdkGC ptr, byval color as const GdkColor ptr)
declare sub gdk_gc_set_background(byval gc as GdkGC ptr, byval color as const GdkColor ptr)
declare sub gdk_gc_set_font(byval gc as GdkGC ptr, byval font as GdkFont ptr)
declare sub gdk_gc_set_function(byval gc as GdkGC ptr, byval function as GdkFunction)
declare sub gdk_gc_set_fill(byval gc as GdkGC ptr, byval fill as GdkFill)
declare sub gdk_gc_set_tile(byval gc as GdkGC ptr, byval tile as GdkPixmap ptr)
declare sub gdk_gc_set_stipple(byval gc as GdkGC ptr, byval stipple as GdkPixmap ptr)
declare sub gdk_gc_set_ts_origin(byval gc as GdkGC ptr, byval x as gint, byval y as gint)
declare sub gdk_gc_set_clip_origin(byval gc as GdkGC ptr, byval x as gint, byval y as gint)
declare sub gdk_gc_set_clip_mask(byval gc as GdkGC ptr, byval mask as GdkBitmap ptr)
declare sub gdk_gc_set_clip_rectangle(byval gc as GdkGC ptr, byval rectangle as const GdkRectangle ptr)
declare sub gdk_gc_set_clip_region(byval gc as GdkGC ptr, byval region as const GdkRegion ptr)
declare sub gdk_gc_set_subwindow(byval gc as GdkGC ptr, byval mode as GdkSubwindowMode)
declare sub gdk_gc_set_exposures(byval gc as GdkGC ptr, byval exposures as gboolean)
declare sub gdk_gc_set_line_attributes(byval gc as GdkGC ptr, byval line_width as gint, byval line_style as GdkLineStyle, byval cap_style as GdkCapStyle, byval join_style as GdkJoinStyle)
declare sub gdk_gc_set_dashes(byval gc as GdkGC ptr, byval dash_offset as gint, byval dash_list as gint8 ptr, byval n as gint)
declare sub gdk_gc_offset(byval gc as GdkGC ptr, byval x_offset as gint, byval y_offset as gint)
declare sub gdk_gc_copy(byval dst_gc as GdkGC ptr, byval src_gc as GdkGC ptr)
declare sub gdk_gc_set_colormap(byval gc as GdkGC ptr, byval colormap as GdkColormap ptr)
declare function gdk_gc_get_colormap(byval gc as GdkGC ptr) as GdkColormap ptr
declare sub gdk_gc_set_rgb_fg_color(byval gc as GdkGC ptr, byval color as const GdkColor ptr)
declare sub gdk_gc_set_rgb_bg_color(byval gc as GdkGC ptr, byval color as const GdkColor ptr)
declare function gdk_gc_get_screen(byval gc as GdkGC ptr) as GdkScreen ptr
declare sub gdk_gc_destroy alias "g_object_unref"(byval object as gpointer)
type GdkDrawableClass as _GdkDrawableClass
type GdkTrapezoid as _GdkTrapezoid

#define GDK_TYPE_DRAWABLE gdk_drawable_get_type()
#define GDK_DRAWABLE(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_DRAWABLE, GdkDrawable)
#define GDK_DRAWABLE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_DRAWABLE, GdkDrawableClass)
#define GDK_IS_DRAWABLE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_DRAWABLE)
#define GDK_IS_DRAWABLE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_DRAWABLE)
#define GDK_DRAWABLE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_DRAWABLE, GdkDrawableClass)

type _GdkDrawable
	parent_instance as GObject
end type

type _GdkDrawableClass
	parent_class as GObjectClass
	create_gc as function(byval drawable as GdkDrawable ptr, byval values as GdkGCValues ptr, byval mask as GdkGCValuesMask) as GdkGC ptr
	draw_rectangle as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
	draw_arc as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval angle1 as gint, byval angle2 as gint)
	draw_polygon as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval points as GdkPoint ptr, byval npoints as gint)
	draw_text as sub(byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval text as const gchar ptr, byval text_length as gint)
	draw_text_wc as sub(byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval text as const GdkWChar ptr, byval text_length as gint)
	draw_drawable as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src as GdkDrawable ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
	draw_points as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval points as GdkPoint ptr, byval npoints as gint)
	draw_segments as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval segs as GdkSegment ptr, byval nsegs as gint)
	draw_lines as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval points as GdkPoint ptr, byval npoints as gint)
	draw_glyphs as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval font as PangoFont ptr, byval x as gint, byval y as gint, byval glyphs as PangoGlyphString ptr)
	draw_image as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval image as GdkImage ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
	get_depth as function(byval drawable as GdkDrawable ptr) as gint
	get_size as sub(byval drawable as GdkDrawable ptr, byval width as gint ptr, byval height as gint ptr)
	set_colormap as sub(byval drawable as GdkDrawable ptr, byval cmap as GdkColormap ptr)
	get_colormap as function(byval drawable as GdkDrawable ptr) as GdkColormap ptr
	get_visual as function(byval drawable as GdkDrawable ptr) as GdkVisual ptr
	get_screen as function(byval drawable as GdkDrawable ptr) as GdkScreen ptr
	get_image as function(byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint) as GdkImage ptr
	get_clip_region as function(byval drawable as GdkDrawable ptr) as GdkRegion ptr
	get_visible_region as function(byval drawable as GdkDrawable ptr) as GdkRegion ptr
	get_composite_drawable as function(byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval composite_x_offset as gint ptr, byval composite_y_offset as gint ptr) as GdkDrawable ptr
	draw_pixbuf as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval pixbuf as GdkPixbuf ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint, byval dither as GdkRgbDither, byval x_dither as gint, byval y_dither as gint)
	_copy_to_image as function(byval drawable as GdkDrawable ptr, byval image as GdkImage ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint) as GdkImage ptr
	draw_glyphs_transformed as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval matrix as PangoMatrix ptr, byval font as PangoFont ptr, byval x as gint, byval y as gint, byval glyphs as PangoGlyphString ptr)
	draw_trapezoids as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval trapezoids as GdkTrapezoid ptr, byval n_trapezoids as gint)
	ref_cairo_surface as function(byval drawable as GdkDrawable ptr) as cairo_surface_t ptr
	get_source_drawable as function(byval drawable as GdkDrawable ptr) as GdkDrawable ptr
	set_cairo_clip as sub(byval drawable as GdkDrawable ptr, byval cr as cairo_t ptr)
	create_cairo_surface as function(byval drawable as GdkDrawable ptr, byval width as long, byval height as long) as cairo_surface_t ptr
	draw_drawable_with_src as sub(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src as GdkDrawable ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint, byval original_src as GdkDrawable ptr)
	_gdk_reserved7 as sub()
	_gdk_reserved9 as sub()
	_gdk_reserved10 as sub()
	_gdk_reserved11 as sub()
	_gdk_reserved12 as sub()
	_gdk_reserved13 as sub()
	_gdk_reserved14 as sub()
	_gdk_reserved15 as sub()
end type

type _GdkTrapezoid
	y1 as double
	x11 as double
	x21 as double
	y2 as double
	x12 as double
	x22 as double
end type

declare function gdk_drawable_get_type() as GType
declare sub gdk_drawable_set_data(byval drawable as GdkDrawable ptr, byval key as const gchar ptr, byval data as gpointer, byval destroy_func as GDestroyNotify)
declare function gdk_drawable_get_data(byval drawable as GdkDrawable ptr, byval key as const gchar ptr) as gpointer
declare sub gdk_drawable_set_colormap(byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr)
declare function gdk_drawable_get_colormap(byval drawable as GdkDrawable ptr) as GdkColormap ptr
declare function gdk_drawable_get_depth(byval drawable as GdkDrawable ptr) as gint
declare sub gdk_drawable_get_size(byval drawable as GdkDrawable ptr, byval width as gint ptr, byval height as gint ptr)
declare function gdk_drawable_get_visual(byval drawable as GdkDrawable ptr) as GdkVisual ptr
declare function gdk_drawable_get_screen(byval drawable as GdkDrawable ptr) as GdkScreen ptr
declare function gdk_drawable_get_display(byval drawable as GdkDrawable ptr) as GdkDisplay ptr
declare function gdk_drawable_ref(byval drawable as GdkDrawable ptr) as GdkDrawable ptr
declare sub gdk_drawable_unref(byval drawable as GdkDrawable ptr)
declare sub gdk_draw_point(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint)
declare sub gdk_draw_line(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x1_ as gint, byval y1_ as gint, byval x2_ as gint, byval y2_ as gint)
declare sub gdk_draw_rectangle(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_arc(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval x as gint, byval y as gint, byval width as gint, byval height as gint, byval angle1 as gint, byval angle2 as gint)
declare sub gdk_draw_polygon(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval filled as gboolean, byval points as const GdkPoint ptr, byval n_points as gint)
declare sub gdk_draw_string(byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval string as const gchar ptr)
declare sub gdk_draw_text(byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval text as const gchar ptr, byval text_length as gint)
declare sub gdk_draw_text_wc(byval drawable as GdkDrawable ptr, byval font as GdkFont ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval text as const GdkWChar ptr, byval text_length as gint)
declare sub gdk_draw_drawable(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src as GdkDrawable ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_image(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval image as GdkImage ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_points(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval points as const GdkPoint ptr, byval n_points as gint)
declare sub gdk_draw_segments(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval segs as const GdkSegment ptr, byval n_segs as gint)
declare sub gdk_draw_lines(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval points as const GdkPoint ptr, byval n_points as gint)
declare sub gdk_draw_pixbuf(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval pixbuf as const GdkPixbuf ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint, byval dither as GdkRgbDither, byval x_dither as gint, byval y_dither as gint)
declare sub gdk_draw_glyphs(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval font as PangoFont ptr, byval x as gint, byval y as gint, byval glyphs as PangoGlyphString ptr)
declare sub gdk_draw_layout_line(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval line as PangoLayoutLine ptr)
declare sub gdk_draw_layout(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr)
declare sub gdk_draw_layout_line_with_colors(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval line as PangoLayoutLine ptr, byval foreground as const GdkColor ptr, byval background as const GdkColor ptr)
declare sub gdk_draw_layout_with_colors(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval x as gint, byval y as gint, byval layout as PangoLayout ptr, byval foreground as const GdkColor ptr, byval background as const GdkColor ptr)
declare sub gdk_draw_glyphs_transformed(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval matrix as const PangoMatrix ptr, byval font as PangoFont ptr, byval x as gint, byval y as gint, byval glyphs as PangoGlyphString ptr)
declare sub gdk_draw_trapezoids(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval trapezoids as const GdkTrapezoid ptr, byval n_trapezoids as gint)
declare sub gdk_draw_pixmap alias "gdk_draw_drawable"(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src as GdkDrawable ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
declare sub gdk_draw_bitmap alias "gdk_draw_drawable"(byval drawable as GdkDrawable ptr, byval gc as GdkGC ptr, byval src as GdkDrawable ptr, byval xsrc as gint, byval ysrc as gint, byval xdest as gint, byval ydest as gint, byval width as gint, byval height as gint)
declare function gdk_drawable_get_image(byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_drawable_copy_to_image(byval drawable as GdkDrawable ptr, byval image as GdkImage ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_drawable_get_clip_region(byval drawable as GdkDrawable ptr) as GdkRegion ptr
declare function gdk_drawable_get_visible_region(byval drawable as GdkDrawable ptr) as GdkRegion ptr
#define __GDK_ENUM_TYPES_H__
declare function gdk_cursor_type_get_type() as GType
#define GDK_TYPE_CURSOR_TYPE gdk_cursor_type_get_type()
declare function gdk_drag_action_get_type() as GType
#define GDK_TYPE_DRAG_ACTION gdk_drag_action_get_type()
declare function gdk_drag_protocol_get_type() as GType
#define GDK_TYPE_DRAG_PROTOCOL gdk_drag_protocol_get_type()
declare function gdk_filter_return_get_type() as GType
#define GDK_TYPE_FILTER_RETURN gdk_filter_return_get_type()
declare function gdk_event_type_get_type() as GType
#define GDK_TYPE_EVENT_TYPE gdk_event_type_get_type()
declare function gdk_event_mask_get_type() as GType
#define GDK_TYPE_EVENT_MASK gdk_event_mask_get_type()
declare function gdk_visibility_state_get_type() as GType
#define GDK_TYPE_VISIBILITY_STATE gdk_visibility_state_get_type()
declare function gdk_scroll_direction_get_type() as GType
#define GDK_TYPE_SCROLL_DIRECTION gdk_scroll_direction_get_type()
declare function gdk_notify_type_get_type() as GType
#define GDK_TYPE_NOTIFY_TYPE gdk_notify_type_get_type()
declare function gdk_crossing_mode_get_type() as GType
#define GDK_TYPE_CROSSING_MODE gdk_crossing_mode_get_type()
declare function gdk_property_state_get_type() as GType
#define GDK_TYPE_PROPERTY_STATE gdk_property_state_get_type()
declare function gdk_window_state_get_type() as GType
#define GDK_TYPE_WINDOW_STATE gdk_window_state_get_type()
declare function gdk_setting_action_get_type() as GType
#define GDK_TYPE_SETTING_ACTION gdk_setting_action_get_type()
declare function gdk_owner_change_get_type() as GType
#define GDK_TYPE_OWNER_CHANGE gdk_owner_change_get_type()
declare function gdk_font_type_get_type() as GType
#define GDK_TYPE_FONT_TYPE gdk_font_type_get_type()
declare function gdk_cap_style_get_type() as GType
#define GDK_TYPE_CAP_STYLE gdk_cap_style_get_type()
declare function gdk_fill_get_type() as GType
#define GDK_TYPE_FILL gdk_fill_get_type()
declare function gdk_function_get_type() as GType
#define GDK_TYPE_FUNCTION gdk_function_get_type()
declare function gdk_join_style_get_type() as GType
#define GDK_TYPE_JOIN_STYLE gdk_join_style_get_type()
declare function gdk_line_style_get_type() as GType
#define GDK_TYPE_LINE_STYLE gdk_line_style_get_type()
declare function gdk_subwindow_mode_get_type() as GType
#define GDK_TYPE_SUBWINDOW_MODE gdk_subwindow_mode_get_type()
declare function gdk_gc_values_mask_get_type() as GType
#define GDK_TYPE_GC_VALUES_MASK gdk_gc_values_mask_get_type()
declare function gdk_image_type_get_type() as GType
#define GDK_TYPE_IMAGE_TYPE gdk_image_type_get_type()
declare function gdk_extension_mode_get_type() as GType
#define GDK_TYPE_EXTENSION_MODE gdk_extension_mode_get_type()
declare function gdk_input_source_get_type() as GType
#define GDK_TYPE_INPUT_SOURCE gdk_input_source_get_type()
declare function gdk_input_mode_get_type() as GType
#define GDK_TYPE_INPUT_MODE gdk_input_mode_get_type()
declare function gdk_axis_use_get_type() as GType
#define GDK_TYPE_AXIS_USE gdk_axis_use_get_type()
declare function gdk_prop_mode_get_type() as GType
#define GDK_TYPE_PROP_MODE gdk_prop_mode_get_type()
declare function gdk_fill_rule_get_type() as GType
#define GDK_TYPE_FILL_RULE gdk_fill_rule_get_type()
declare function gdk_overlap_type_get_type() as GType
#define GDK_TYPE_OVERLAP_TYPE gdk_overlap_type_get_type()
declare function gdk_rgb_dither_get_type() as GType
#define GDK_TYPE_RGB_DITHER gdk_rgb_dither_get_type()
declare function gdk_byte_order_get_type() as GType
#define GDK_TYPE_BYTE_ORDER gdk_byte_order_get_type()
declare function gdk_modifier_type_get_type() as GType
#define GDK_TYPE_MODIFIER_TYPE gdk_modifier_type_get_type()
declare function gdk_input_condition_get_type() as GType
#define GDK_TYPE_INPUT_CONDITION gdk_input_condition_get_type()
declare function gdk_status_get_type() as GType
#define GDK_TYPE_STATUS gdk_status_get_type()
declare function gdk_grab_status_get_type() as GType
#define GDK_TYPE_GRAB_STATUS gdk_grab_status_get_type()
declare function gdk_visual_type_get_type() as GType
#define GDK_TYPE_VISUAL_TYPE gdk_visual_type_get_type()
declare function gdk_window_class_get_type() as GType
#define GDK_TYPE_WINDOW_CLASS gdk_window_class_get_type()
declare function gdk_window_type_get_type() as GType
#define GDK_TYPE_WINDOW_TYPE gdk_window_type_get_type()
declare function gdk_window_attributes_type_get_type() as GType
#define GDK_TYPE_WINDOW_ATTRIBUTES_TYPE gdk_window_attributes_type_get_type()
declare function gdk_window_hints_get_type() as GType
#define GDK_TYPE_WINDOW_HINTS gdk_window_hints_get_type()
declare function gdk_window_type_hint_get_type() as GType
#define GDK_TYPE_WINDOW_TYPE_HINT gdk_window_type_hint_get_type()
declare function gdk_wm_decoration_get_type() as GType
#define GDK_TYPE_WM_DECORATION gdk_wm_decoration_get_type()
declare function gdk_wm_function_get_type() as GType
#define GDK_TYPE_WM_FUNCTION gdk_wm_function_get_type()
declare function gdk_gravity_get_type() as GType
#define GDK_TYPE_GRAVITY gdk_gravity_get_type()
declare function gdk_window_edge_get_type() as GType

#define GDK_TYPE_WINDOW_EDGE gdk_window_edge_get_type()
#define __GDK_FONT_H__
#define GDK_TYPE_FONT gdk_font_get_type()

type GdkFontType as long
enum
	GDK_FONT_FONT
	GDK_FONT_FONTSET
end enum

type _GdkFont
	as GdkFontType type
	ascent as gint
	descent as gint
end type

declare function gdk_font_get_type() as GType
declare function gdk_font_ref(byval font as GdkFont ptr) as GdkFont ptr
declare sub gdk_font_unref(byval font as GdkFont ptr)
declare function gdk_font_id(byval font as const GdkFont ptr) as gint
declare function gdk_font_equal(byval fonta as const GdkFont ptr, byval fontb as const GdkFont ptr) as gboolean
declare function gdk_font_load_for_display(byval display as GdkDisplay ptr, byval font_name as const gchar ptr) as GdkFont ptr
declare function gdk_fontset_load_for_display(byval display as GdkDisplay ptr, byval fontset_name as const gchar ptr) as GdkFont ptr
declare function gdk_font_from_description_for_display(byval display as GdkDisplay ptr, byval font_desc as PangoFontDescription ptr) as GdkFont ptr
declare function gdk_font_load(byval font_name as const gchar ptr) as GdkFont ptr
declare function gdk_fontset_load(byval fontset_name as const gchar ptr) as GdkFont ptr
declare function gdk_font_from_description(byval font_desc as PangoFontDescription ptr) as GdkFont ptr
declare function gdk_string_width(byval font as GdkFont ptr, byval string as const gchar ptr) as gint
declare function gdk_text_width(byval font as GdkFont ptr, byval text as const gchar ptr, byval text_length as gint) as gint
declare function gdk_text_width_wc(byval font as GdkFont ptr, byval text as const GdkWChar ptr, byval text_length as gint) as gint
declare function gdk_char_width(byval font as GdkFont ptr, byval character as byte) as gint
declare function gdk_char_width_wc(byval font as GdkFont ptr, byval character as GdkWChar) as gint
declare function gdk_string_measure(byval font as GdkFont ptr, byval string as const gchar ptr) as gint
declare function gdk_text_measure(byval font as GdkFont ptr, byval text as const gchar ptr, byval text_length as gint) as gint
declare function gdk_char_measure(byval font as GdkFont ptr, byval character as byte) as gint
declare function gdk_string_height(byval font as GdkFont ptr, byval string as const gchar ptr) as gint
declare function gdk_text_height(byval font as GdkFont ptr, byval text as const gchar ptr, byval text_length as gint) as gint
declare function gdk_char_height(byval font as GdkFont ptr, byval character as byte) as gint
declare sub gdk_text_extents(byval font as GdkFont ptr, byval text as const gchar ptr, byval text_length as gint, byval lbearing as gint ptr, byval rbearing as gint ptr, byval width as gint ptr, byval ascent as gint ptr, byval descent as gint ptr)
declare sub gdk_text_extents_wc(byval font as GdkFont ptr, byval text as const GdkWChar ptr, byval text_length as gint, byval lbearing as gint ptr, byval rbearing as gint ptr, byval width as gint ptr, byval ascent as gint ptr, byval descent as gint ptr)
declare sub gdk_string_extents(byval font as GdkFont ptr, byval string as const gchar ptr, byval lbearing as gint ptr, byval rbearing as gint ptr, byval width as gint ptr, byval ascent as gint ptr, byval descent as gint ptr)
declare function gdk_font_get_display(byval font as GdkFont ptr) as GdkDisplay ptr
#define __GDK_IMAGE_H__

type GdkImageType as long
enum
	GDK_IMAGE_NORMAL
	GDK_IMAGE_SHARED
	GDK_IMAGE_FASTEST
end enum

type GdkImageClass as _GdkImageClass
#define GDK_TYPE_IMAGE gdk_image_get_type()
#define GDK_IMAGE(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_IMAGE, GdkImage)
#define GDK_IMAGE_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_IMAGE, GdkImageClass)
#define GDK_IS_IMAGE(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_IMAGE)
#define GDK_IS_IMAGE_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_IMAGE)
#define GDK_IMAGE_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_IMAGE, GdkImageClass)

type _GdkImage
	parent_instance as GObject
	as GdkImageType type
	visual as GdkVisual ptr
	byte_order as GdkByteOrder
	width as gint
	height as gint
	depth as guint16
	bpp as guint16
	bpl as guint16
	bits_per_pixel as guint16
	mem as gpointer
	colormap as GdkColormap ptr
	windowing_data as gpointer
end type

type _GdkImageClass
	parent_class as GObjectClass
end type

declare function gdk_image_get_type() as GType
declare function gdk_image_new(byval type as GdkImageType, byval visual as GdkVisual ptr, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_image_get(byval drawable as GdkDrawable ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint) as GdkImage ptr
declare function gdk_image_ref(byval image as GdkImage ptr) as GdkImage ptr
declare sub gdk_image_unref(byval image as GdkImage ptr)
declare sub gdk_image_put_pixel(byval image as GdkImage ptr, byval x as gint, byval y as gint, byval pixel as guint32)
declare function gdk_image_get_pixel(byval image as GdkImage ptr, byval x as gint, byval y as gint) as guint32
declare sub gdk_image_set_colormap(byval image as GdkImage ptr, byval colormap as GdkColormap ptr)
declare function gdk_image_get_colormap(byval image as GdkImage ptr) as GdkColormap ptr
declare function gdk_image_get_image_type(byval image as GdkImage ptr) as GdkImageType
declare function gdk_image_get_visual(byval image as GdkImage ptr) as GdkVisual ptr
declare function gdk_image_get_byte_order(byval image as GdkImage ptr) as GdkByteOrder
declare function gdk_image_get_width(byval image as GdkImage ptr) as gint
declare function gdk_image_get_height(byval image as GdkImage ptr) as gint
declare function gdk_image_get_depth(byval image as GdkImage ptr) as guint16
declare function gdk_image_get_bytes_per_pixel(byval image as GdkImage ptr) as guint16
declare function gdk_image_get_bytes_per_line(byval image as GdkImage ptr) as guint16
declare function gdk_image_get_bits_per_pixel(byval image as GdkImage ptr) as guint16
declare function gdk_image_get_pixels(byval image as GdkImage ptr) as gpointer
declare sub gdk_image_destroy alias "g_object_unref"(byval object as gpointer)
#define __GDK_KEYS_H__
type GdkKeymapKey as _GdkKeymapKey

type _GdkKeymapKey
	keycode as guint
	group as gint
	level as gint
end type

type GdkKeymap as _GdkKeymap
type GdkKeymapClass as _GdkKeymapClass
#define GDK_TYPE_KEYMAP gdk_keymap_get_type()
#define GDK_KEYMAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_KEYMAP, GdkKeymap)
#define GDK_KEYMAP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_KEYMAP, GdkKeymapClass)
#define GDK_IS_KEYMAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_KEYMAP)
#define GDK_IS_KEYMAP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_KEYMAP)
#define GDK_KEYMAP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_KEYMAP, GdkKeymapClass)

type _GdkKeymap
	parent_instance as GObject
	display as GdkDisplay ptr
end type

type _GdkKeymapClass
	parent_class as GObjectClass
	direction_changed as sub(byval keymap as GdkKeymap ptr)
	keys_changed as sub(byval keymap as GdkKeymap ptr)
	state_changed as sub(byval keymap as GdkKeymap ptr)
end type

declare function gdk_keymap_get_type() as GType
declare function gdk_keymap_get_default() as GdkKeymap ptr
declare function gdk_keymap_get_for_display(byval display as GdkDisplay ptr) as GdkKeymap ptr
declare function gdk_keymap_lookup_key(byval keymap as GdkKeymap ptr, byval key as const GdkKeymapKey ptr) as guint
declare function gdk_keymap_translate_keyboard_state(byval keymap as GdkKeymap ptr, byval hardware_keycode as guint, byval state as GdkModifierType, byval group as gint, byval keyval as guint ptr, byval effective_group as gint ptr, byval level as gint ptr, byval consumed_modifiers as GdkModifierType ptr) as gboolean
declare function gdk_keymap_get_entries_for_keyval(byval keymap as GdkKeymap ptr, byval keyval as guint, byval keys as GdkKeymapKey ptr ptr, byval n_keys as gint ptr) as gboolean
declare function gdk_keymap_get_entries_for_keycode(byval keymap as GdkKeymap ptr, byval hardware_keycode as guint, byval keys as GdkKeymapKey ptr ptr, byval keyvals as guint ptr ptr, byval n_entries as gint ptr) as gboolean
declare function gdk_keymap_get_direction(byval keymap as GdkKeymap ptr) as PangoDirection
declare function gdk_keymap_have_bidi_layouts(byval keymap as GdkKeymap ptr) as gboolean
declare function gdk_keymap_get_caps_lock_state(byval keymap as GdkKeymap ptr) as gboolean
declare sub gdk_keymap_add_virtual_modifiers(byval keymap as GdkKeymap ptr, byval state as GdkModifierType ptr)
declare function gdk_keymap_map_virtual_modifiers(byval keymap as GdkKeymap ptr, byval state as GdkModifierType ptr) as gboolean
declare function gdk_keyval_name(byval keyval as guint) as gchar ptr
declare function gdk_keyval_from_name(byval keyval_name as const gchar ptr) as guint
declare sub gdk_keyval_convert_case(byval symbol as guint, byval lower as guint ptr, byval upper as guint ptr)
declare function gdk_keyval_to_upper(byval keyval as guint) as guint
declare function gdk_keyval_to_lower(byval keyval as guint) as guint
declare function gdk_keyval_is_upper(byval keyval as guint) as gboolean
declare function gdk_keyval_is_lower(byval keyval as guint) as gboolean
declare function gdk_keyval_to_unicode(byval keyval as guint) as guint32
declare function gdk_unicode_to_keyval(byval wc as guint32) as guint
#define __GDK_PANGO_H__

type GdkPangoRenderer as _GdkPangoRenderer
type GdkPangoRendererClass as _GdkPangoRendererClass
type GdkPangoRendererPrivate as _GdkPangoRendererPrivate

#define GDK_TYPE_PANGO_RENDERER gdk_pango_renderer_get_type()
#define GDK_PANGO_RENDERER(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_PANGO_RENDERER, GdkPangoRenderer)
#define GDK_IS_PANGO_RENDERER(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_PANGO_RENDERER)
#define GDK_PANGO_RENDERER_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_PANGO_RENDERER, GdkPangoRendererClass)
#define GDK_IS_PANGO_RENDERER_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_PANGO_RENDERER)
#define GDK_PANGO_RENDERER_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_PANGO_RENDERER, GdkPangoRendererClass)

type _GdkPangoRenderer
	parent_instance as PangoRenderer
	priv as GdkPangoRendererPrivate ptr
end type

type _GdkPangoRendererClass
	parent_class as PangoRendererClass
end type

declare function gdk_pango_renderer_get_type() as GType
declare function gdk_pango_renderer_new(byval screen as GdkScreen ptr) as PangoRenderer ptr
declare function gdk_pango_renderer_get_default(byval screen as GdkScreen ptr) as PangoRenderer ptr
declare sub gdk_pango_renderer_set_drawable(byval gdk_renderer as GdkPangoRenderer ptr, byval drawable as GdkDrawable ptr)
declare sub gdk_pango_renderer_set_gc(byval gdk_renderer as GdkPangoRenderer ptr, byval gc as GdkGC ptr)
declare sub gdk_pango_renderer_set_stipple(byval gdk_renderer as GdkPangoRenderer ptr, byval part as PangoRenderPart, byval stipple as GdkBitmap ptr)
declare sub gdk_pango_renderer_set_override_color(byval gdk_renderer as GdkPangoRenderer ptr, byval part as PangoRenderPart, byval color as const GdkColor ptr)
declare function gdk_pango_context_get_for_screen(byval screen as GdkScreen ptr) as PangoContext ptr
declare function gdk_pango_context_get() as PangoContext ptr
declare sub gdk_pango_context_set_colormap(byval context as PangoContext ptr, byval colormap as GdkColormap ptr)
declare function gdk_pango_layout_line_get_clip_region(byval line as PangoLayoutLine ptr, byval x_origin as gint, byval y_origin as gint, byval index_ranges as const gint ptr, byval n_ranges as gint) as GdkRegion ptr
declare function gdk_pango_layout_get_clip_region(byval layout as PangoLayout ptr, byval x_origin as gint, byval y_origin as gint, byval index_ranges as const gint ptr, byval n_ranges as gint) as GdkRegion ptr

type GdkPangoAttrStipple as _GdkPangoAttrStipple
type GdkPangoAttrEmbossed as _GdkPangoAttrEmbossed
type GdkPangoAttrEmbossColor as _GdkPangoAttrEmbossColor

type _GdkPangoAttrStipple
	attr as PangoAttribute
	stipple as GdkBitmap ptr
end type

type _GdkPangoAttrEmbossed
	attr as PangoAttribute
	embossed as gboolean
end type

type _GdkPangoAttrEmbossColor
	attr as PangoAttribute
	color as PangoColor
end type

declare function gdk_pango_attr_stipple_new(byval stipple as GdkBitmap ptr) as PangoAttribute ptr
declare function gdk_pango_attr_embossed_new(byval embossed as gboolean) as PangoAttribute ptr
declare function gdk_pango_attr_emboss_color_new(byval color as const GdkColor ptr) as PangoAttribute ptr
#define __GDK_PIXMAP_H__
type GdkPixmapObject as _GdkPixmapObject
type GdkPixmapObjectClass as _GdkPixmapObjectClass

#define GDK_TYPE_PIXMAP gdk_pixmap_get_type()
#define GDK_PIXMAP(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_PIXMAP, GdkPixmap)
#define GDK_PIXMAP_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_PIXMAP, GdkPixmapObjectClass)
#define GDK_IS_PIXMAP(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_PIXMAP)
#define GDK_IS_PIXMAP_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_PIXMAP)
#define GDK_PIXMAP_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_PIXMAP, GdkPixmapObjectClass)
#define GDK_PIXMAP_OBJECT(object) cptr(GdkPixmapObject ptr, GDK_PIXMAP(object))

type _GdkPixmapObject
	parent_instance as GdkDrawable
	impl as GdkDrawable ptr
	depth as gint
end type

type _GdkPixmapObjectClass
	parent_class as GdkDrawableClass
end type

declare function gdk_pixmap_get_type() as GType
declare function gdk_pixmap_new(byval drawable as GdkDrawable ptr, byval width as gint, byval height as gint, byval depth as gint) as GdkPixmap ptr
declare function gdk_bitmap_create_from_data(byval drawable as GdkDrawable ptr, byval data as const gchar ptr, byval width as gint, byval height as gint) as GdkBitmap ptr
declare function gdk_pixmap_create_from_data(byval drawable as GdkDrawable ptr, byval data as const gchar ptr, byval width as gint, byval height as gint, byval depth as gint, byval fg as const GdkColor ptr, byval bg as const GdkColor ptr) as GdkPixmap ptr
declare function gdk_pixmap_create_from_xpm(byval drawable as GdkDrawable ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as const GdkColor ptr, byval filename as const gchar ptr) as GdkPixmap ptr
declare function gdk_pixmap_colormap_create_from_xpm(byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as const GdkColor ptr, byval filename as const gchar ptr) as GdkPixmap ptr
declare function gdk_pixmap_create_from_xpm_d(byval drawable as GdkDrawable ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as const GdkColor ptr, byval data as gchar ptr ptr) as GdkPixmap ptr
declare function gdk_pixmap_colormap_create_from_xpm_d(byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr, byval mask as GdkBitmap ptr ptr, byval transparent_color as const GdkColor ptr, byval data as gchar ptr ptr) as GdkPixmap ptr
declare sub gdk_pixmap_get_size(byval pixmap as GdkPixmap ptr, byval width as gint ptr, byval height as gint ptr)
declare function gdk_pixmap_foreign_new(byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_lookup(byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_foreign_new_for_display(byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_lookup_for_display(byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkPixmap ptr
declare function gdk_pixmap_foreign_new_for_screen(byval screen as GdkScreen ptr, byval anid as GdkNativeWindow, byval width as gint, byval height as gint, byval depth as gint) as GdkPixmap ptr
declare function gdk_bitmap_ref alias "g_object_ref"(byval object as gpointer) as gpointer
declare sub gdk_bitmap_unref alias "g_object_unref"(byval object as gpointer)
declare function gdk_pixmap_ref alias "g_object_ref"(byval object as gpointer) as gpointer
declare sub gdk_pixmap_unref alias "g_object_unref"(byval object as gpointer)
#define __GDK_PROPERTY_H__

type GdkPropMode as long
enum
	GDK_PROP_MODE_REPLACE
	GDK_PROP_MODE_PREPEND
	GDK_PROP_MODE_APPEND
end enum

declare function gdk_atom_intern(byval atom_name as const gchar ptr, byval only_if_exists as gboolean) as GdkAtom
declare function gdk_atom_intern_static_string(byval atom_name as const gchar ptr) as GdkAtom
declare function gdk_atom_name(byval atom as GdkAtom) as gchar ptr
declare function gdk_property_get(byval window as GdkWindow ptr, byval property as GdkAtom, byval type as GdkAtom, byval offset as gulong, byval length as gulong, byval pdelete as gint, byval actual_property_type as GdkAtom ptr, byval actual_format as gint ptr, byval actual_length as gint ptr, byval data as guchar ptr ptr) as gboolean
declare sub gdk_property_change(byval window as GdkWindow ptr, byval property as GdkAtom, byval type as GdkAtom, byval format as gint, byval mode as GdkPropMode, byval data as const guchar ptr, byval nelements as gint)
declare sub gdk_property_delete_ alias "gdk_property_delete"(byval window as GdkWindow ptr, byval property as GdkAtom)
declare function gdk_text_property_to_text_list(byval encoding as GdkAtom, byval format as gint, byval text as const guchar ptr, byval length as gint, byval list as gchar ptr ptr ptr) as gint
declare function gdk_utf8_to_compound_text(byval str as const gchar ptr, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gboolean
declare function gdk_string_to_compound_text(byval str as const gchar ptr, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gint
declare function gdk_text_property_to_utf8_list(byval encoding as GdkAtom, byval format as gint, byval text as const guchar ptr, byval length as gint, byval list as gchar ptr ptr ptr) as gint
declare function gdk_text_property_to_utf8_list_for_display(byval display as GdkDisplay ptr, byval encoding as GdkAtom, byval format as gint, byval text as const guchar ptr, byval length as gint, byval list as gchar ptr ptr ptr) as gint
declare function gdk_utf8_to_string_target(byval str as const gchar ptr) as gchar ptr
declare function gdk_text_property_to_text_list_for_display(byval display as GdkDisplay ptr, byval encoding as GdkAtom, byval format as gint, byval text as const guchar ptr, byval length as gint, byval list as gchar ptr ptr ptr) as gint
declare function gdk_string_to_compound_text_for_display(byval display as GdkDisplay ptr, byval str as const gchar ptr, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gint
declare function gdk_utf8_to_compound_text_for_display(byval display as GdkDisplay ptr, byval str as const gchar ptr, byval encoding as GdkAtom ptr, byval format as gint ptr, byval ctext as guchar ptr ptr, byval length as gint ptr) as gboolean
declare sub gdk_free_text_list(byval list as gchar ptr ptr)
declare sub gdk_free_compound_text(byval ctext as guchar ptr)
#define __GDK_REGION_H__

type GdkFillRule as long
enum
	GDK_EVEN_ODD_RULE
	GDK_WINDING_RULE
end enum

type GdkOverlapType as long
enum
	GDK_OVERLAP_RECTANGLE_IN
	GDK_OVERLAP_RECTANGLE_OUT
	GDK_OVERLAP_RECTANGLE_PART
end enum

type GdkSpanFunc as sub(byval span as GdkSpan ptr, byval data as gpointer)
declare function gdk_region_new() as GdkRegion ptr
declare function gdk_region_polygon(byval points as const GdkPoint ptr, byval n_points as gint, byval fill_rule as GdkFillRule) as GdkRegion ptr
declare function gdk_region_copy(byval region as const GdkRegion ptr) as GdkRegion ptr
declare function gdk_region_rectangle(byval rectangle as const GdkRectangle ptr) as GdkRegion ptr
declare sub gdk_region_destroy(byval region as GdkRegion ptr)
declare sub gdk_region_get_clipbox(byval region as const GdkRegion ptr, byval rectangle as GdkRectangle ptr)
declare sub gdk_region_get_rectangles(byval region as const GdkRegion ptr, byval rectangles as GdkRectangle ptr ptr, byval n_rectangles as gint ptr)
declare function gdk_region_empty(byval region as const GdkRegion ptr) as gboolean
declare function gdk_region_equal(byval region1 as const GdkRegion ptr, byval region2 as const GdkRegion ptr) as gboolean
declare function gdk_region_rect_equal(byval region as const GdkRegion ptr, byval rectangle as const GdkRectangle ptr) as gboolean
declare function gdk_region_point_in(byval region as const GdkRegion ptr, byval x as long, byval y as long) as gboolean
declare function gdk_region_rect_in(byval region as const GdkRegion ptr, byval rectangle as const GdkRectangle ptr) as GdkOverlapType
declare sub gdk_region_offset(byval region as GdkRegion ptr, byval dx as gint, byval dy as gint)
declare sub gdk_region_shrink(byval region as GdkRegion ptr, byval dx as gint, byval dy as gint)
declare sub gdk_region_union_with_rect(byval region as GdkRegion ptr, byval rect as const GdkRectangle ptr)
declare sub gdk_region_intersect(byval source1 as GdkRegion ptr, byval source2 as const GdkRegion ptr)
declare sub gdk_region_union(byval source1 as GdkRegion ptr, byval source2 as const GdkRegion ptr)
declare sub gdk_region_subtract(byval source1 as GdkRegion ptr, byval source2 as const GdkRegion ptr)
declare sub gdk_region_xor(byval source1 as GdkRegion ptr, byval source2 as const GdkRegion ptr)
declare sub gdk_region_spans_intersect_foreach(byval region as GdkRegion ptr, byval spans as const GdkSpan ptr, byval n_spans as long, byval sorted as gboolean, byval function as GdkSpanFunc, byval data as gpointer)

#define __GDK_SELECTION_H__
#define GDK_SELECTION_PRIMARY _GDK_MAKE_ATOM(1)
#define GDK_SELECTION_SECONDARY _GDK_MAKE_ATOM(2)
#define GDK_SELECTION_CLIPBOARD _GDK_MAKE_ATOM(69)
#define GDK_TARGET_BITMAP _GDK_MAKE_ATOM(5)
#define GDK_TARGET_COLORMAP _GDK_MAKE_ATOM(7)
#define GDK_TARGET_DRAWABLE _GDK_MAKE_ATOM(17)
#define GDK_TARGET_PIXMAP _GDK_MAKE_ATOM(20)
#define GDK_TARGET_STRING _GDK_MAKE_ATOM(31)
#define GDK_SELECTION_TYPE_ATOM _GDK_MAKE_ATOM(4)
#define GDK_SELECTION_TYPE_BITMAP _GDK_MAKE_ATOM(5)
#define GDK_SELECTION_TYPE_COLORMAP _GDK_MAKE_ATOM(7)
#define GDK_SELECTION_TYPE_DRAWABLE _GDK_MAKE_ATOM(17)
#define GDK_SELECTION_TYPE_INTEGER _GDK_MAKE_ATOM(19)
#define GDK_SELECTION_TYPE_PIXMAP _GDK_MAKE_ATOM(20)
#define GDK_SELECTION_TYPE_WINDOW _GDK_MAKE_ATOM(33)
#define GDK_SELECTION_TYPE_STRING _GDK_MAKE_ATOM(31)

type GdkSelection as GdkAtom
type GdkTarget as GdkAtom
type GdkSelectionType as GdkAtom

declare function gdk_selection_owner_set(byval owner as GdkWindow ptr, byval selection as GdkAtom, byval time_ as guint32, byval send_event as gboolean) as gboolean
declare function gdk_selection_owner_get(byval selection as GdkAtom) as GdkWindow ptr
declare function gdk_selection_owner_set_for_display(byval display as GdkDisplay ptr, byval owner as GdkWindow ptr, byval selection as GdkAtom, byval time_ as guint32, byval send_event as gboolean) as gboolean
declare function gdk_selection_owner_get_for_display(byval display as GdkDisplay ptr, byval selection as GdkAtom) as GdkWindow ptr
declare sub gdk_selection_convert(byval requestor as GdkWindow ptr, byval selection as GdkAtom, byval target as GdkAtom, byval time_ as guint32)
declare function gdk_selection_property_get(byval requestor as GdkWindow ptr, byval data as guchar ptr ptr, byval prop_type as GdkAtom ptr, byval prop_format as gint ptr) as gint
declare sub gdk_selection_send_notify(byval requestor as GdkNativeWindow, byval selection as GdkAtom, byval target as GdkAtom, byval property as GdkAtom, byval time_ as guint32)
declare sub gdk_selection_send_notify_for_display(byval display as GdkDisplay ptr, byval requestor as GdkNativeWindow, byval selection as GdkAtom, byval target as GdkAtom, byval property as GdkAtom, byval time_ as guint32)
#define __GDK_SPAWN_H__
declare function gdk_spawn_on_screen(byval screen as GdkScreen ptr, byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as gint ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_spawn_on_screen_with_pipes(byval screen as GdkScreen ptr, byval working_directory as const gchar ptr, byval argv as gchar ptr ptr, byval envp as gchar ptr ptr, byval flags as GSpawnFlags, byval child_setup as GSpawnChildSetupFunc, byval user_data as gpointer, byval child_pid as gint ptr, byval standard_input as gint ptr, byval standard_output as gint ptr, byval standard_error as gint ptr, byval error as GError ptr ptr) as gboolean
declare function gdk_spawn_command_line_on_screen(byval screen as GdkScreen ptr, byval command_line as const gchar ptr, byval error as GError ptr ptr) as gboolean
#define __GDK_TEST_UTILS_H__
#define __GDK_WINDOW_H__

type GdkGeometry as _GdkGeometry
type GdkWindowAttr as _GdkWindowAttr
type GdkPointerHooks as _GdkPointerHooks
type GdkWindowRedirect as _GdkWindowRedirect

type GdkWindowClass as long
enum
	GDK_INPUT_OUTPUT
	GDK_INPUT_ONLY
end enum

type GdkWindowType as long
enum
	GDK_WINDOW_ROOT
	GDK_WINDOW_TOPLEVEL
	GDK_WINDOW_CHILD
	GDK_WINDOW_DIALOG
	GDK_WINDOW_TEMP
	GDK_WINDOW_FOREIGN
	GDK_WINDOW_OFFSCREEN
end enum

type GdkWindowAttributesType as long
enum
	GDK_WA_TITLE = 1 shl 1
	GDK_WA_X = 1 shl 2
	GDK_WA_Y = 1 shl 3
	GDK_WA_CURSOR = 1 shl 4
	GDK_WA_COLORMAP = 1 shl 5
	GDK_WA_VISUAL = 1 shl 6
	GDK_WA_WMCLASS = 1 shl 7
	GDK_WA_NOREDIR = 1 shl 8
	GDK_WA_TYPE_HINT = 1 shl 9
end enum

type GdkWindowHints as long
enum
	GDK_HINT_POS = 1 shl 0
	GDK_HINT_MIN_SIZE = 1 shl 1
	GDK_HINT_MAX_SIZE = 1 shl 2
	GDK_HINT_BASE_SIZE = 1 shl 3
	GDK_HINT_ASPECT = 1 shl 4
	GDK_HINT_RESIZE_INC = 1 shl 5
	GDK_HINT_WIN_GRAVITY = 1 shl 6
	GDK_HINT_USER_POS = 1 shl 7
	GDK_HINT_USER_SIZE = 1 shl 8
end enum

type GdkWindowTypeHint as long
enum
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
end enum

type GdkWMDecoration as long
enum
	GDK_DECOR_ALL = 1 shl 0
	GDK_DECOR_BORDER = 1 shl 1
	GDK_DECOR_RESIZEH = 1 shl 2
	GDK_DECOR_TITLE = 1 shl 3
	GDK_DECOR_MENU = 1 shl 4
	GDK_DECOR_MINIMIZE = 1 shl 5
	GDK_DECOR_MAXIMIZE = 1 shl 6
end enum

type GdkWMFunction as long
enum
	GDK_FUNC_ALL = 1 shl 0
	GDK_FUNC_RESIZE = 1 shl 1
	GDK_FUNC_MOVE = 1 shl 2
	GDK_FUNC_MINIMIZE = 1 shl 3
	GDK_FUNC_MAXIMIZE = 1 shl 4
	GDK_FUNC_CLOSE = 1 shl 5
end enum

type GdkGravity as long
enum
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
end enum

type GdkWindowEdge as long
enum
	GDK_WINDOW_EDGE_NORTH_WEST
	GDK_WINDOW_EDGE_NORTH
	GDK_WINDOW_EDGE_NORTH_EAST
	GDK_WINDOW_EDGE_WEST
	GDK_WINDOW_EDGE_EAST
	GDK_WINDOW_EDGE_SOUTH_WEST
	GDK_WINDOW_EDGE_SOUTH
	GDK_WINDOW_EDGE_SOUTH_EAST
end enum

type _GdkWindowAttr
	title as gchar ptr
	event_mask as gint
	x as gint
	y as gint
	width as gint
	height as gint
	wclass as GdkWindowClass
	visual as GdkVisual ptr
	colormap as GdkColormap ptr
	window_type as GdkWindowType
	cursor as GdkCursor ptr
	wmclass_name as gchar ptr
	wmclass_class as gchar ptr
	override_redirect as gboolean
	type_hint as GdkWindowTypeHint
end type

type _GdkGeometry
	min_width as gint
	min_height as gint
	max_width as gint
	max_height as gint
	base_width as gint
	base_height as gint
	width_inc as gint
	height_inc as gint
	min_aspect as gdouble
	max_aspect as gdouble
	win_gravity as GdkGravity
end type

type _GdkPointerHooks
	get_pointer as function(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
	window_at_pointer as function(byval screen as GdkScreen ptr, byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
end type

type GdkWindowObject as _GdkWindowObject
type GdkWindowObjectClass as _GdkWindowObjectClass
#define GDK_TYPE_WINDOW gdk_window_object_get_type()
#define GDK_WINDOW(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_WINDOW, GdkWindow)
#define GDK_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_WINDOW, GdkWindowObjectClass)
#define GDK_IS_WINDOW(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_WINDOW)
#define GDK_IS_WINDOW_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_WINDOW)
#define GDK_WINDOW_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_WINDOW, GdkWindowObjectClass)
#define GDK_WINDOW_OBJECT(object) cptr(GdkWindowObject ptr, GDK_WINDOW(object))

type _GdkWindowObject
	parent_instance as GdkDrawable
	impl as GdkDrawable ptr
	parent as GdkWindowObject ptr
	user_data as gpointer
	x as gint
	y as gint
	extension_events as gint
	filters as GList ptr
	children as GList ptr
	bg_color as GdkColor
	bg_pixmap as GdkPixmap ptr
	paint_stack as GSList ptr
	update_area as GdkRegion ptr
	update_freeze_count as guint
	window_type as guint8
	depth as guint8
	resize_count as guint8
	state as GdkWindowState
	guffaw_gravity : 1 as guint
	input_only : 1 as guint
	modal_hint : 1 as guint
	composited : 1 as guint
	destroyed : 2 as guint
	accept_focus : 1 as guint
	focus_on_map : 1 as guint
	shaped : 1 as guint
	event_mask as GdkEventMask
	update_and_descendants_freeze_count as guint
	redirect as GdkWindowRedirect ptr
end type

type _GdkWindowObjectClass
	parent_class as GdkDrawableClass
end type

declare function gdk_window_object_get_type() as GType
declare function gdk_window_new(byval parent as GdkWindow ptr, byval attributes as GdkWindowAttr ptr, byval attributes_mask as gint) as GdkWindow ptr
declare sub gdk_window_destroy(byval window as GdkWindow ptr)
declare function gdk_window_get_window_type(byval window as GdkWindow ptr) as GdkWindowType
declare function gdk_window_is_destroyed(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_screen(byval window as GdkWindow ptr) as GdkScreen ptr
declare function gdk_window_get_display(byval window as GdkWindow ptr) as GdkDisplay ptr
declare function gdk_window_get_visual(byval window as GdkWindow ptr) as GdkVisual ptr
declare function gdk_window_get_width(byval window as GdkWindow ptr) as long
declare function gdk_window_get_height(byval window as GdkWindow ptr) as long
declare function gdk_window_at_pointer(byval win_x as gint ptr, byval win_y as gint ptr) as GdkWindow ptr
declare sub gdk_window_show(byval window as GdkWindow ptr)
declare sub gdk_window_hide(byval window as GdkWindow ptr)
declare sub gdk_window_withdraw(byval window as GdkWindow ptr)
declare sub gdk_window_show_unraised(byval window as GdkWindow ptr)
declare sub gdk_window_move(byval window as GdkWindow ptr, byval x as gint, byval y as gint)
declare sub gdk_window_resize(byval window as GdkWindow ptr, byval width as gint, byval height as gint)
declare sub gdk_window_move_resize(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_reparent(byval window as GdkWindow ptr, byval new_parent as GdkWindow ptr, byval x as gint, byval y as gint)
declare sub gdk_window_clear(byval window as GdkWindow ptr)
declare sub gdk_window_clear_area(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_clear_area_e(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_raise(byval window as GdkWindow ptr)
declare sub gdk_window_lower(byval window as GdkWindow ptr)
declare sub gdk_window_restack(byval window as GdkWindow ptr, byval sibling as GdkWindow ptr, byval above as gboolean)
declare sub gdk_window_focus(byval window as GdkWindow ptr, byval timestamp as guint32)
declare sub gdk_window_set_user_data(byval window as GdkWindow ptr, byval user_data as gpointer)
declare sub gdk_window_set_override_redirect(byval window as GdkWindow ptr, byval override_redirect as gboolean)
declare function gdk_window_get_accept_focus(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_accept_focus(byval window as GdkWindow ptr, byval accept_focus as gboolean)
declare function gdk_window_get_focus_on_map(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_focus_on_map(byval window as GdkWindow ptr, byval focus_on_map as gboolean)
declare sub gdk_window_add_filter(byval window as GdkWindow ptr, byval function as GdkFilterFunc, byval data as gpointer)
declare sub gdk_window_remove_filter(byval window as GdkWindow ptr, byval function as GdkFilterFunc, byval data as gpointer)
declare sub gdk_window_scroll(byval window as GdkWindow ptr, byval dx as gint, byval dy as gint)
declare sub gdk_window_move_region(byval window as GdkWindow ptr, byval region as const GdkRegion ptr, byval dx as gint, byval dy as gint)
declare function gdk_window_ensure_native(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_shape_combine_mask(byval window as GdkWindow ptr, byval mask as GdkBitmap ptr, byval x as gint, byval y as gint)
declare sub gdk_window_shape_combine_region(byval window as GdkWindow ptr, byval shape_region as const GdkRegion ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gdk_window_set_child_shapes(byval window as GdkWindow ptr)
declare function gdk_window_get_composited(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_composited(byval window as GdkWindow ptr, byval composited as gboolean)
declare sub gdk_window_merge_child_shapes(byval window as GdkWindow ptr)
declare sub gdk_window_input_shape_combine_mask(byval window as GdkWindow ptr, byval mask as GdkBitmap ptr, byval x as gint, byval y as gint)
declare sub gdk_window_input_shape_combine_region(byval window as GdkWindow ptr, byval shape_region as const GdkRegion ptr, byval offset_x as gint, byval offset_y as gint)
declare sub gdk_window_set_child_input_shapes(byval window as GdkWindow ptr)
declare sub gdk_window_merge_child_input_shapes(byval window as GdkWindow ptr)
declare function gdk_window_is_visible(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_viewable(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_input_only(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_is_shaped(byval window as GdkWindow ptr) as gboolean
declare function gdk_window_get_state(byval window as GdkWindow ptr) as GdkWindowState
declare function gdk_window_set_static_gravities(byval window as GdkWindow ptr, byval use_static as gboolean) as gboolean
declare function gdk_window_foreign_new(byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_lookup(byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_foreign_new_for_display(byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_lookup_for_display(byval display as GdkDisplay ptr, byval anid as GdkNativeWindow) as GdkWindow ptr
declare function gdk_window_has_native(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_hints(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval min_width as gint, byval min_height as gint, byval max_width as gint, byval max_height as gint, byval flags as gint)
declare sub gdk_window_set_type_hint(byval window as GdkWindow ptr, byval hint as GdkWindowTypeHint)
declare function gdk_window_get_type_hint(byval window as GdkWindow ptr) as GdkWindowTypeHint
declare function gdk_window_get_modal_hint(byval window as GdkWindow ptr) as gboolean
declare sub gdk_window_set_modal_hint(byval window as GdkWindow ptr, byval modal as gboolean)
declare sub gdk_window_set_skip_taskbar_hint(byval window as GdkWindow ptr, byval skips_taskbar as gboolean)
declare sub gdk_window_set_skip_pager_hint(byval window as GdkWindow ptr, byval skips_pager as gboolean)
declare sub gdk_window_set_urgency_hint(byval window as GdkWindow ptr, byval urgent as gboolean)
declare sub gdk_window_set_geometry_hints(byval window as GdkWindow ptr, byval geometry as const GdkGeometry ptr, byval geom_mask as GdkWindowHints)
declare sub gdk_set_sm_client_id(byval sm_client_id as const gchar ptr)
declare sub gdk_window_begin_paint_rect(byval window as GdkWindow ptr, byval rectangle as const GdkRectangle ptr)
declare sub gdk_window_begin_paint_region(byval window as GdkWindow ptr, byval region as const GdkRegion ptr)
declare sub gdk_window_end_paint(byval window as GdkWindow ptr)
declare sub gdk_window_flush(byval window as GdkWindow ptr)
declare sub gdk_window_set_title(byval window as GdkWindow ptr, byval title as const gchar ptr)
declare sub gdk_window_set_role(byval window as GdkWindow ptr, byval role as const gchar ptr)
declare sub gdk_window_set_startup_id(byval window as GdkWindow ptr, byval startup_id as const gchar ptr)
declare sub gdk_window_set_transient_for(byval window as GdkWindow ptr, byval parent as GdkWindow ptr)
declare sub gdk_window_set_background(byval window as GdkWindow ptr, byval color as const GdkColor ptr)
declare sub gdk_window_set_back_pixmap(byval window as GdkWindow ptr, byval pixmap as GdkPixmap ptr, byval parent_relative as gboolean)
declare function gdk_window_get_background_pattern(byval window as GdkWindow ptr) as cairo_pattern_t ptr
declare sub gdk_window_set_cursor(byval window as GdkWindow ptr, byval cursor as GdkCursor ptr)
declare function gdk_window_get_cursor(byval window as GdkWindow ptr) as GdkCursor ptr
declare sub gdk_window_get_user_data(byval window as GdkWindow ptr, byval data as gpointer ptr)
declare sub gdk_window_get_geometry(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval width as gint ptr, byval height as gint ptr, byval depth as gint ptr)
declare sub gdk_window_get_position(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr)
declare function gdk_window_get_origin(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr) as gint
declare sub gdk_window_get_root_coords(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval root_x as gint ptr, byval root_y as gint ptr)
declare sub gdk_window_coords_to_parent(byval window as GdkWindow ptr, byval x as gdouble, byval y as gdouble, byval parent_x as gdouble ptr, byval parent_y as gdouble ptr)
declare sub gdk_window_coords_from_parent(byval window as GdkWindow ptr, byval parent_x as gdouble, byval parent_y as gdouble, byval x as gdouble ptr, byval y as gdouble ptr)
declare function gdk_window_get_deskrelative_origin(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr) as gboolean
declare sub gdk_window_get_root_origin(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr)
declare sub gdk_window_get_frame_extents(byval window as GdkWindow ptr, byval rect as GdkRectangle ptr)
declare function gdk_window_get_pointer(byval window as GdkWindow ptr, byval x as gint ptr, byval y as gint ptr, byval mask as GdkModifierType ptr) as GdkWindow ptr
declare function gdk_window_get_parent(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_toplevel(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_effective_parent(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_effective_toplevel(byval window as GdkWindow ptr) as GdkWindow ptr
declare function gdk_window_get_children(byval window as GdkWindow ptr) as GList ptr
declare function gdk_window_peek_children(byval window as GdkWindow ptr) as GList ptr
declare function gdk_window_get_events(byval window as GdkWindow ptr) as GdkEventMask
declare sub gdk_window_set_events(byval window as GdkWindow ptr, byval event_mask as GdkEventMask)
declare sub gdk_window_set_icon_list(byval window as GdkWindow ptr, byval pixbufs as GList ptr)
declare sub gdk_window_set_icon(byval window as GdkWindow ptr, byval icon_window as GdkWindow ptr, byval pixmap as GdkPixmap ptr, byval mask as GdkBitmap ptr)
declare sub gdk_window_set_icon_name(byval window as GdkWindow ptr, byval name as const gchar ptr)
declare sub gdk_window_set_group(byval window as GdkWindow ptr, byval leader as GdkWindow ptr)
declare function gdk_window_get_group(byval window as GdkWindow ptr) as GdkWindow ptr
declare sub gdk_window_set_decorations(byval window as GdkWindow ptr, byval decorations as GdkWMDecoration)
declare function gdk_window_get_decorations(byval window as GdkWindow ptr, byval decorations as GdkWMDecoration ptr) as gboolean
declare sub gdk_window_set_functions(byval window as GdkWindow ptr, byval functions as GdkWMFunction)
declare function gdk_window_get_toplevels() as GList ptr
declare function gdk_window_create_similar_surface(byval window as GdkWindow ptr, byval content as cairo_content_t, byval width as long, byval height as long) as cairo_surface_t ptr
declare sub gdk_window_beep(byval window as GdkWindow ptr)
declare sub gdk_window_iconify(byval window as GdkWindow ptr)
declare sub gdk_window_deiconify(byval window as GdkWindow ptr)
declare sub gdk_window_stick(byval window as GdkWindow ptr)
declare sub gdk_window_unstick(byval window as GdkWindow ptr)
declare sub gdk_window_maximize(byval window as GdkWindow ptr)
declare sub gdk_window_unmaximize(byval window as GdkWindow ptr)
declare sub gdk_window_fullscreen(byval window as GdkWindow ptr)
declare sub gdk_window_unfullscreen(byval window as GdkWindow ptr)
declare sub gdk_window_set_keep_above(byval window as GdkWindow ptr, byval setting as gboolean)
declare sub gdk_window_set_keep_below(byval window as GdkWindow ptr, byval setting as gboolean)
declare sub gdk_window_set_opacity(byval window as GdkWindow ptr, byval opacity as gdouble)
declare sub gdk_window_register_dnd(byval window as GdkWindow ptr)
declare sub gdk_window_begin_resize_drag(byval window as GdkWindow ptr, byval edge as GdkWindowEdge, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_begin_move_drag(byval window as GdkWindow ptr, byval button as gint, byval root_x as gint, byval root_y as gint, byval timestamp as guint32)
declare sub gdk_window_invalidate_rect(byval window as GdkWindow ptr, byval rect as const GdkRectangle ptr, byval invalidate_children as gboolean)
declare sub gdk_window_invalidate_region(byval window as GdkWindow ptr, byval region as const GdkRegion ptr, byval invalidate_children as gboolean)
declare sub gdk_window_invalidate_maybe_recurse(byval window as GdkWindow ptr, byval region as const GdkRegion ptr, byval child_func as function(byval as GdkWindow ptr, byval as gpointer) as gboolean, byval user_data as gpointer)
declare function gdk_window_get_update_area(byval window as GdkWindow ptr) as GdkRegion ptr
declare sub gdk_window_freeze_updates(byval window as GdkWindow ptr)
declare sub gdk_window_thaw_updates(byval window as GdkWindow ptr)
declare sub gdk_window_freeze_toplevel_updates_libgtk_only(byval window as GdkWindow ptr)
declare sub gdk_window_thaw_toplevel_updates_libgtk_only(byval window as GdkWindow ptr)
declare sub gdk_window_process_all_updates()
declare sub gdk_window_process_updates(byval window as GdkWindow ptr, byval update_children as gboolean)
declare sub gdk_window_set_debug_updates(byval setting as gboolean)
declare sub gdk_window_constrain_size(byval geometry as GdkGeometry ptr, byval flags as guint, byval width as gint, byval height as gint, byval new_width as gint ptr, byval new_height as gint ptr)
declare sub gdk_window_get_internal_paint_info(byval window as GdkWindow ptr, byval real_drawable as GdkDrawable ptr ptr, byval x_offset as gint ptr, byval y_offset as gint ptr)
declare sub gdk_window_enable_synchronized_configure(byval window as GdkWindow ptr)
declare sub gdk_window_configure_finished(byval window as GdkWindow ptr)
declare function gdk_get_default_root_window() as GdkWindow ptr
declare function gdk_offscreen_window_get_pixmap(byval window as GdkWindow ptr) as GdkPixmap ptr
declare sub gdk_offscreen_window_set_embedder(byval window as GdkWindow ptr, byval embedder as GdkWindow ptr)
declare function gdk_offscreen_window_get_embedder(byval window as GdkWindow ptr) as GdkWindow ptr
declare sub gdk_window_geometry_changed(byval window as GdkWindow ptr)
declare sub gdk_window_redirect_to_drawable(byval window as GdkWindow ptr, byval drawable as GdkDrawable ptr, byval src_x as gint, byval src_y as gint, byval dest_x as gint, byval dest_y as gint, byval width as gint, byval height as gint)
declare sub gdk_window_remove_redirection(byval window as GdkWindow ptr)
declare function gdk_set_pointer_hooks(byval new_hooks as const GdkPointerHooks ptr) as GdkPointerHooks ptr
#define GDK_ROOT_PARENT() gdk_get_default_root_window()
declare sub gdk_window_get_size alias "gdk_drawable_get_size"(byval drawable as GdkDrawable ptr, byval width as gint ptr, byval height as gint ptr)
declare function gdk_window_get_type alias "gdk_window_get_window_type"(byval window as GdkWindow ptr) as GdkWindowType
declare function gdk_window_get_colormap alias "gdk_drawable_get_colormap"(byval drawable as GdkDrawable ptr) as GdkColormap ptr
declare sub gdk_window_set_colormap alias "gdk_drawable_set_colormap"(byval drawable as GdkDrawable ptr, byval colormap as GdkColormap ptr)
declare function gdk_window_ref alias "g_object_ref"(byval object as gpointer) as gpointer
declare sub gdk_window_unref alias "g_object_unref"(byval object as gpointer)
#define gdk_window_copy_area(drawable, gc, x, y, source_drawable, source_x, source_y, width, height) gdk_draw_pixmap(drawable, gc, source_drawable, source_x, source_y, x, y, width, height)
declare sub gdk_test_render_sync(byval window as GdkWindow ptr)
declare function gdk_test_simulate_key(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval keyval as guint, byval modifiers as GdkModifierType, byval key_pressrelease as GdkEventType) as gboolean
declare function gdk_test_simulate_button(byval window as GdkWindow ptr, byval x as gint, byval y as gint, byval button as guint, byval modifiers as GdkModifierType, byval button_pressrelease as GdkEventType) as gboolean

#define __GDK_VISUAL_H__
#define GDK_TYPE_VISUAL gdk_visual_get_type()
#define GDK_VISUAL(object) G_TYPE_CHECK_INSTANCE_CAST((object), GDK_TYPE_VISUAL, GdkVisual)
#define GDK_VISUAL_CLASS(klass) G_TYPE_CHECK_CLASS_CAST((klass), GDK_TYPE_VISUAL, GdkVisualClass)
#define GDK_IS_VISUAL(object) G_TYPE_CHECK_INSTANCE_TYPE((object), GDK_TYPE_VISUAL)
#define GDK_IS_VISUAL_CLASS(klass) G_TYPE_CHECK_CLASS_TYPE((klass), GDK_TYPE_VISUAL)
#define GDK_VISUAL_GET_CLASS(obj) G_TYPE_INSTANCE_GET_CLASS((obj), GDK_TYPE_VISUAL, GdkVisualClass)
type GdkVisualClass as _GdkVisualClass

type GdkVisualType as long
enum
	GDK_VISUAL_STATIC_GRAY
	GDK_VISUAL_GRAYSCALE
	GDK_VISUAL_STATIC_COLOR
	GDK_VISUAL_PSEUDO_COLOR
	GDK_VISUAL_TRUE_COLOR
	GDK_VISUAL_DIRECT_COLOR
end enum

type _GdkVisual
	parent_instance as GObject
	as GdkVisualType type
	depth as gint
	byte_order as GdkByteOrder
	colormap_size as gint
	bits_per_rgb as gint
	red_mask as guint32
	red_shift as gint
	red_prec as gint
	green_mask as guint32
	green_shift as gint
	green_prec as gint
	blue_mask as guint32
	blue_shift as gint
	blue_prec as gint
end type

declare function gdk_visual_get_type() as GType
declare function gdk_visual_get_best_depth() as gint
declare function gdk_visual_get_best_type() as GdkVisualType
declare function gdk_visual_get_system() as GdkVisual ptr
declare function gdk_visual_get_best() as GdkVisual ptr
declare function gdk_visual_get_best_with_depth(byval depth as gint) as GdkVisual ptr
declare function gdk_visual_get_best_with_type(byval visual_type as GdkVisualType) as GdkVisual ptr
declare function gdk_visual_get_best_with_both(byval depth as gint, byval visual_type as GdkVisualType) as GdkVisual ptr
declare sub gdk_query_depths(byval depths as gint ptr ptr, byval count as gint ptr)
declare sub gdk_query_visual_types(byval visual_types as GdkVisualType ptr ptr, byval count as gint ptr)
declare function gdk_list_visuals() as GList ptr
declare function gdk_visual_get_screen(byval visual as GdkVisual ptr) as GdkScreen ptr
declare function gdk_visual_get_visual_type(byval visual as GdkVisual ptr) as GdkVisualType
declare function gdk_visual_get_depth(byval visual as GdkVisual ptr) as gint
declare function gdk_visual_get_byte_order(byval visual as GdkVisual ptr) as GdkByteOrder
declare function gdk_visual_get_colormap_size(byval visual as GdkVisual ptr) as gint
declare function gdk_visual_get_bits_per_rgb(byval visual as GdkVisual ptr) as gint
declare sub gdk_visual_get_red_pixel_details(byval visual as GdkVisual ptr, byval mask as guint32 ptr, byval shift as gint ptr, byval precision as gint ptr)
declare sub gdk_visual_get_green_pixel_details(byval visual as GdkVisual ptr, byval mask as guint32 ptr, byval shift as gint ptr, byval precision as gint ptr)
declare sub gdk_visual_get_blue_pixel_details(byval visual as GdkVisual ptr, byval mask as guint32 ptr, byval shift as gint ptr, byval precision as gint ptr)
#define gdk_visual_ref(v) g_object_ref(v)
#define gdk_visual_unref(v) g_object_unref(v)
#undef __GDK_H_INSIDE__
const GDK_PRIORITY_EVENTS = G_PRIORITY_DEFAULT
declare sub gdk_parse_args(byval argc as gint ptr, byval argv as gchar ptr ptr ptr)
declare sub gdk_init(byval argc as gint ptr, byval argv as gchar ptr ptr ptr)
declare function gdk_init_check(byval argc as gint ptr, byval argv as gchar ptr ptr ptr) as gboolean
declare sub gdk_add_option_entries_libgtk_only(byval group as GOptionGroup ptr)
declare sub gdk_pre_parse_libgtk_only()
declare sub gdk_exit(byval error_code as gint)
declare function gdk_set_locale() as gchar ptr
declare function gdk_get_program_class() as const zstring ptr
declare sub gdk_set_program_class(byval program_class as const zstring ptr)
declare sub gdk_error_trap_push()
declare function gdk_error_trap_pop() as gint
declare sub gdk_set_use_xshm(byval use_xshm as gboolean)
declare function gdk_get_use_xshm() as gboolean
declare function gdk_get_display() as gchar ptr
declare function gdk_get_display_arg_name() as const gchar ptr
declare function gdk_input_add_full(byval source as gint, byval condition as GdkInputCondition, byval function as GdkInputFunction, byval data as gpointer, byval destroy as GDestroyNotify) as gint
declare function gdk_input_add(byval source as gint, byval condition as GdkInputCondition, byval function as GdkInputFunction, byval data as gpointer) as gint
declare sub gdk_input_remove(byval tag as gint)
declare function gdk_pointer_grab(byval window as GdkWindow ptr, byval owner_events as gboolean, byval event_mask as GdkEventMask, byval confine_to as GdkWindow ptr, byval cursor as GdkCursor ptr, byval time_ as guint32) as GdkGrabStatus
declare function gdk_keyboard_grab(byval window as GdkWindow ptr, byval owner_events as gboolean, byval time_ as guint32) as GdkGrabStatus
declare function gdk_pointer_grab_info_libgtk_only(byval display as GdkDisplay ptr, byval grab_window as GdkWindow ptr ptr, byval owner_events as gboolean ptr) as gboolean
declare function gdk_keyboard_grab_info_libgtk_only(byval display as GdkDisplay ptr, byval grab_window as GdkWindow ptr ptr, byval owner_events as gboolean ptr) as gboolean
declare sub gdk_pointer_ungrab(byval time_ as guint32)
declare sub gdk_keyboard_ungrab(byval time_ as guint32)
declare function gdk_pointer_is_grabbed() as gboolean
declare function gdk_screen_width() as gint
declare function gdk_screen_height() as gint
declare function gdk_screen_width_mm() as gint
declare function gdk_screen_height_mm() as gint
declare sub gdk_beep()
declare sub gdk_flush()
declare sub gdk_set_double_click_time(byval msec as guint)
declare function gdk_rectangle_intersect(byval src1 as const GdkRectangle ptr, byval src2 as const GdkRectangle ptr, byval dest as GdkRectangle ptr) as gboolean
declare sub gdk_rectangle_union(byval src1 as const GdkRectangle ptr, byval src2 as const GdkRectangle ptr, byval dest as GdkRectangle ptr)
declare function gdk_rectangle_get_type() as GType
#define GDK_TYPE_RECTANGLE gdk_rectangle_get_type()
declare function gdk_wcstombs(byval src as const GdkWChar ptr) as gchar ptr
declare function gdk_mbstowcs(byval dest as GdkWChar ptr, byval src as const gchar ptr, byval dest_max as gint) as gint
declare function gdk_event_send_client_message(byval event as GdkEvent ptr, byval winid as GdkNativeWindow) as gboolean
declare sub gdk_event_send_clientmessage_toall(byval event as GdkEvent ptr)
declare function gdk_event_send_client_message_for_display(byval display as GdkDisplay ptr, byval event as GdkEvent ptr, byval winid as GdkNativeWindow) as gboolean
declare sub gdk_notify_startup_complete()
declare sub gdk_notify_startup_complete_with_id(byval startup_id as const gchar ptr)

#ifdef __FB_UNIX__
	extern gdk_threads_mutex as GMutex ptr
	extern gdk_threads_lock as GCallback
	extern gdk_threads_unlock as GCallback
#else
	extern import gdk_threads_mutex as GMutex ptr
	extern import gdk_threads_lock as GCallback
	extern import gdk_threads_unlock as GCallback
#endif

declare sub gdk_threads_enter_ alias "gdk_threads_enter"()
declare sub gdk_threads_leave_ alias "gdk_threads_leave"()
declare sub gdk_threads_init()
declare sub gdk_threads_set_lock_functions(byval enter_fn as GCallback, byval leave_fn as GCallback)
declare function gdk_threads_add_idle_full(byval priority as gint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function gdk_threads_add_idle(byval function as GSourceFunc, byval data as gpointer) as guint
declare function gdk_threads_add_timeout_full(byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function gdk_threads_add_timeout(byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint
declare function gdk_threads_add_timeout_seconds_full(byval priority as gint, byval interval as guint, byval function as GSourceFunc, byval data as gpointer, byval notify as GDestroyNotify) as guint
declare function gdk_threads_add_timeout_seconds(byval interval as guint, byval function as GSourceFunc, byval data as gpointer) as guint
#macro GDK_THREADS_ENTER()
	if gdk_threads_lock then
		gdk_threads_lock()
	end if
#endmacro
#macro GDK_THREADS_LEAVE()
	if gdk_threads_unlock then
		gdk_threads_unlock()
	end if
#endmacro

end extern

#ifdef __FB_WIN32__
#pragma pop(msbitfields)
#endif
