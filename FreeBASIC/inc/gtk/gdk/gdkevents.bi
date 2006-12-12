''
''
'' gdkevents -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkevents_bi__
#define __gdkevents_bi__

#include once "gdkcolor.bi"
#include once "gdktypes.bi"
#include once "gdkdnd.bi"
#include once "gdkinput.bi"

#define GDK_TYPE_EVENT (gdk_event_get_type ())
#define GDK_PRIORITY_EVENTS (G_PRIORITY_DEFAULT)
#define GDK_PRIORITY_REDRAW (G_PRIORITY_HIGH_IDLE + 20)

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
type GdkEvent as _GdkEvent
type GdkEventFunc as sub cdecl(byval as GdkEvent ptr, byval as gpointer)
type GdkXEvent as any

enum GdkFilterReturn
	GDK_FILTER_CONTINUE
	GDK_FILTER_TRANSLATE
	GDK_FILTER_REMOVE
end enum

type GdkFilterFunc as function cdecl(byval as GdkXEvent ptr, byval as GdkEvent ptr, byval as gpointer) as GdkFilterReturn

enum GdkEventType
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
	GDK_NO_EXPOSE = 30
	GDK_SCROLL = 31
	GDK_WINDOW_STATE = 32
	GDK_SETTING = 33
	GDK_OWNER_CHANGE = 34
end enum


enum GdkEventMask
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


enum GdkVisibilityState
	GDK_VISIBILITY_UNOBSCURED
	GDK_VISIBILITY_PARTIAL
	GDK_VISIBILITY_FULLY_OBSCURED
end enum


enum GdkScrollDirection
	GDK_SCROLL_UP
	GDK_SCROLL_DOWN
	GDK_SCROLL_LEFT
	GDK_SCROLL_RIGHT
end enum


enum GdkNotifyType
	GDK_NOTIFY_ANCESTOR = 0
	GDK_NOTIFY_VIRTUAL = 1
	GDK_NOTIFY_INFERIOR = 2
	GDK_NOTIFY_NONLINEAR = 3
	GDK_NOTIFY_NONLINEAR_VIRTUAL = 4
	GDK_NOTIFY_UNKNOWN = 5
end enum


enum GdkCrossingMode
	GDK_CROSSING_NORMAL
	GDK_CROSSING_GRAB
	GDK_CROSSING_UNGRAB
end enum


enum GdkPropertyState
	GDK_PROPERTY_NEW_VALUE
	GDK_PROPERTY_DELETE_
end enum


enum GdkWindowState
	GDK_WINDOW_STATE_WITHDRAWN = 1 shl 0
	GDK_WINDOW_STATE_ICONIFIED = 1 shl 1
	GDK_WINDOW_STATE_MAXIMIZED = 1 shl 2
	GDK_WINDOW_STATE_STICKY = 1 shl 3
	GDK_WINDOW_STATE_FULLSCREEN = 1 shl 4
	GDK_WINDOW_STATE_ABOVE = 1 shl 5
	GDK_WINDOW_STATE_BELOW = 1 shl 6
end enum


enum GdkSettingAction
	GDK_SETTING_ACTION_NEW
	GDK_SETTING_ACTION_CHANGED
	GDK_SETTING_ACTION_DELETED
end enum


enum GdkOwnerChange
	GDK_OWNER_CHANGE_NEW_OWNER
	GDK_OWNER_CHANGE_DESTROY
	GDK_OWNER_CHANGE_CLOSE
end enum


type _GdkEventAny
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
end type

type _GdkEventExpose
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	area as GdkRectangle
	region as GdkRegion ptr
	count as gint
end type

type _GdkEventNoExpose
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
end type

type _GdkEventVisibility
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	state as GdkVisibilityState
end type

type _GdkEventMotion
	type as GdkEventType
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
	type as GdkEventType
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
	type as GdkEventType
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
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	state as guint
	keyval as guint
	length as gint
	string as zstring ptr
	hardware_keycode as guint16
	group as guint8
end type

type _GdkEventCrossing
	type as GdkEventType
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
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	in as gint16
end type

type _GdkEventConfigure
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	x as gint
	y as gint
	width as gint
	height as gint
end type

type _GdkEventProperty
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	atom as GdkAtom
	time as guint32
	state as guint
end type

type _GdkEventSelection
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	selection as GdkAtom
	target as GdkAtom
	property as GdkAtom
	time as guint32
	requestor as GdkNativeWindow
end type

type _GdkEventOwnerChange
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	owner as GdkNativeWindow
	reason as GdkOwnerChange
	selection as GdkAtom
	time as guint32
	selection_time as guint32
end type

type _GdkEventProximity
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	time as guint32
	device as GdkDevice ptr
end type

union _GdkEventClient_data
	b as zstring * 20
	s(0 to 10-1) as short
	l(0 to 5-1) as integer
end union

type _GdkEventClient
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	message_type as GdkAtom
	data_format as gushort
	data as _GdkEventClient_data
end type

type _GdkEventSetting
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	action as GdkSettingAction
	name as zstring ptr
end type

type _GdkEventWindowState
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	changed_mask as GdkWindowState
	new_window_state as GdkWindowState
end type

type _GdkEventDND
	type as GdkEventType
	window as GdkWindow ptr
	send_event as gint8
	context as GdkDragContext ptr
	time as guint32
	x_root as gshort
	y_root as gshort
end type

union _GdkEvent
	type as GdkEventType
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
end union

declare function gdk_event_get_type () as GType
declare function gdk_events_pending () as gboolean
declare function gdk_event_get () as GdkEvent ptr
declare function gdk_event_peek () as GdkEvent ptr
declare function gdk_event_get_graphics_expose (byval window as GdkWindow ptr) as GdkEvent ptr
declare sub gdk_event_put (byval event as GdkEvent ptr)
declare function gdk_event_new (byval type as GdkEventType) as GdkEvent ptr
declare function gdk_event_copy (byval event as GdkEvent ptr) as GdkEvent ptr
declare sub gdk_event_free (byval event as GdkEvent ptr)
declare function gdk_event_get_time (byval event as GdkEvent ptr) as guint32
declare function gdk_event_get_state (byval event as GdkEvent ptr, byval state as GdkModifierType ptr) as gboolean
declare function gdk_event_get_coords (byval event as GdkEvent ptr, byval x_win as gdouble ptr, byval y_win as gdouble ptr) as gboolean
declare function gdk_event_get_root_coords (byval event as GdkEvent ptr, byval x_root as gdouble ptr, byval y_root as gdouble ptr) as gboolean
declare function gdk_event_get_axis (byval event as GdkEvent ptr, byval axis_use as GdkAxisUse, byval value as gdouble ptr) as gboolean
declare sub gdk_event_handler_set (byval func as GdkEventFunc, byval data as gpointer, byval notify as GDestroyNotify)
declare sub gdk_event_set_screen (byval event as GdkEvent ptr, byval screen as GdkScreen ptr)
declare function gdk_event_get_screen (byval event as GdkEvent ptr) as GdkScreen ptr
declare sub gdk_set_show_events (byval show_events as gboolean)
declare function gdk_get_show_events () as gboolean
declare sub gdk_add_client_message_filter (byval message_type as GdkAtom, byval func as GdkFilterFunc, byval data as gpointer)
declare function gdk_setting_get (byval name as zstring ptr, byval value as GValue ptr) as gboolean

#endif
