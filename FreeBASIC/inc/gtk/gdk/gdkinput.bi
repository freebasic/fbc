''
''
'' gdkinput -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __gdkinput_bi__
#define __gdkinput_bi__

#include once "gtk/gdk/gdktypes.bi"

type GdkDeviceKey as _GdkDeviceKey
type GdkDeviceAxis as _GdkDeviceAxis
type GdkDevice as _GdkDevice
type GdkDeviceClass as _GdkDeviceClass
type GdkTimeCoord as _GdkTimeCoord

enum GdkExtensionMode
	GDK_EXTENSION_EVENTS_NONE
	GDK_EXTENSION_EVENTS_ALL
	GDK_EXTENSION_EVENTS_CURSOR
end enum


enum GdkInputSource
	GDK_SOURCE_MOUSE
	GDK_SOURCE_PEN
	GDK_SOURCE_ERASER
	GDK_SOURCE_CURSOR
end enum


enum GdkInputMode
	GDK_MODE_DISABLED
	GDK_MODE_SCREEN
	GDK_MODE_WINDOW
end enum


enum GdkAxisUse
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
	name as zstring ptr
	source as GdkInputSource
	mode as GdkInputMode
	has_cursor as gboolean
	num_axes as gint
	axes as GdkDeviceAxis ptr
	num_keys as gint
	keys as GdkDeviceKey ptr
end type

#define GDK_MAX_TIMECOORD_AXES 128

type _GdkTimeCoord
	time as guint32
	axes(0 to 128-1) as gdouble ptr
end type

declare function gdk_device_get_type cdecl alias "gdk_device_get_type" () as GType
declare function gdk_devices_list cdecl alias "gdk_devices_list" () as GList ptr
declare sub gdk_device_set_source cdecl alias "gdk_device_set_source" (byval device as GdkDevice ptr, byval source as GdkInputSource)
declare function gdk_device_set_mode cdecl alias "gdk_device_set_mode" (byval device as GdkDevice ptr, byval mode as GdkInputMode) as gboolean
declare sub gdk_device_set_key cdecl alias "gdk_device_set_key" (byval device as GdkDevice ptr, byval index_ as guint, byval keyval as guint, byval modifiers as GdkModifierType)
declare sub gdk_device_set_axis_use cdecl alias "gdk_device_set_axis_use" (byval device as GdkDevice ptr, byval index_ as guint, byval use as GdkAxisUse)
declare sub gdk_device_get_state cdecl alias "gdk_device_get_state" (byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval axes as gdouble ptr, byval mask as GdkModifierType ptr)
declare function gdk_device_get_history cdecl alias "gdk_device_get_history" (byval device as GdkDevice ptr, byval window as GdkWindow ptr, byval start as guint32, byval stop as guint32, byval events as GdkTimeCoord ptr ptr ptr, byval n_events as gint ptr) as gboolean
declare sub gdk_device_free_history cdecl alias "gdk_device_free_history" (byval events as GdkTimeCoord ptr ptr, byval n_events as gint)
declare function gdk_device_get_axis cdecl alias "gdk_device_get_axis" (byval device as GdkDevice ptr, byval axes as gdouble ptr, byval use as GdkAxisUse, byval value as gdouble ptr) as gboolean
declare sub gdk_input_set_extension_events cdecl alias "gdk_input_set_extension_events" (byval window as GdkWindow ptr, byval mask as gint, byval mode as GdkExtensionMode)
declare function gdk_device_get_core_pointer cdecl alias "gdk_device_get_core_pointer" () as GdkDevice ptr

#endif
