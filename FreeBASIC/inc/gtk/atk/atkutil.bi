''
''
'' atkutil -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __atkutil_bi__
#define __atkutil_bi__

#include once "gtk/atk/atkobject.bi"

type AtkUtil as _AtkUtil
type AtkUtilClass as _AtkUtilClass
type AtkKeyEventStruct as _AtkKeyEventStruct
type AtkEventListener as sub cdecl(byval as AtkObject ptr)
type AtkEventListenerInit as sub cdecl()
type AtkKeySnoopFunc as function cdecl(byval as AtkKeyEventStruct ptr, byval as gpointer) as gint

type _AtkKeyEventStruct
	type as gint
	state as guint
	keyval as guint
	length as gint
	string as gchar ptr
	keycode as guint16
	timestamp as guint32
end type

enum AtkKeyEventType
	ATK_KEY_EVENT_PRESS
	ATK_KEY_EVENT_RELEASE
	ATK_KEY_EVENT_LAST_DEFINED
end enum


type _AtkUtil
	parent as GObject
end type

type _AtkUtilClass
	parent as GObjectClass
	add_global_event_listener as function cdecl(byval as GSignalEmissionHook, byval as gchar ptr) as guint
	remove_global_event_listener as sub cdecl(byval as guint)
	add_key_event_listener as function cdecl(byval as AtkKeySnoopFunc, byval as gpointer) as guint
	remove_key_event_listener as sub cdecl(byval as guint)
	get_root as function cdecl() as AtkObject
	get_toolkit_name as function cdecl() as gchar
	get_toolkit_version as function cdecl() as gchar
end type

declare function atk_util_get_type cdecl alias "atk_util_get_type" () as GType

enum AtkCoordType
	ATK_XY_SCREEN
	ATK_XY_WINDOW
end enum


declare function atk_add_focus_tracker cdecl alias "atk_add_focus_tracker" (byval focus_tracker as AtkEventListener) as guint
declare sub atk_remove_focus_tracker cdecl alias "atk_remove_focus_tracker" (byval tracker_id as guint)
declare sub atk_focus_tracker_init cdecl alias "atk_focus_tracker_init" (byval add_function as AtkEventListenerInit)
declare sub atk_focus_tracker_notify cdecl alias "atk_focus_tracker_notify" (byval object as AtkObject ptr)
declare function atk_add_global_event_listener cdecl alias "atk_add_global_event_listener" (byval listener as GSignalEmissionHook, byval event_type as gchar ptr) as guint
declare sub atk_remove_global_event_listener cdecl alias "atk_remove_global_event_listener" (byval listener_id as guint)
declare function atk_add_key_event_listener cdecl alias "atk_add_key_event_listener" (byval listener as AtkKeySnoopFunc, byval data as gpointer) as guint
declare sub atk_remove_key_event_listener cdecl alias "atk_remove_key_event_listener" (byval listener_id as guint)
declare function atk_get_root cdecl alias "atk_get_root" () as AtkObject ptr
declare function atk_get_focus_object cdecl alias "atk_get_focus_object" () as AtkObject ptr
declare function atk_get_toolkit_name cdecl alias "atk_get_toolkit_name" () as gchar ptr
declare function atk_get_toolkit_version cdecl alias "atk_get_toolkit_version" () as gchar ptr

#endif
