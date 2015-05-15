'' FreeBASIC binding for libXi-1.7.4
''
'' based on the C header files:
''   Copyright © 2009 Red Hat, Inc.
''
''   Permission is hereby granted, free of charge, to any person obtaining a
''   copy of this software and associated documentation files (the "Software"),
''   to deal in the Software without restriction, including without limitation
''   the rights to use, copy, modify, merge, publish, distribute, sublicense,
''   and/or sell copies of the Software, and to permit persons to whom the
''   Software is furnished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice (including the next
''   paragraph) shall be included in all copies or substantial portions of the
''   Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
''   THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
''   FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
''   DEALINGS IN THE SOFTWARE.
''
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/extensions/XI2.bi"
#include once "X11/extensions/Xge.bi"
#include once "X11/extensions/Xfixes.bi"

extern "C"

#define _XINPUT2_H_

type XIAddMasterInfo
	as long type
	name as zstring ptr
	send_core as long
	enable as long
end type

type XIRemoveMasterInfo
	as long type
	deviceid as long
	return_mode as long
	return_pointer as long
	return_keyboard as long
end type

type XIAttachSlaveInfo
	as long type
	deviceid as long
	new_master as long
end type

type XIDetachSlaveInfo
	as long type
	deviceid as long
end type

union XIAnyHierarchyChangeInfo
	as long type
	add as XIAddMasterInfo
	remove as XIRemoveMasterInfo
	attach as XIAttachSlaveInfo
	detach as XIDetachSlaveInfo
end union

type XIModifierState
	base as long
	latched as long
	locked as long
	effective as long
end type

type XIGroupState as XIModifierState

type XIButtonState
	mask_len as long
	mask as ubyte ptr
end type

type XIValuatorState
	mask_len as long
	mask as ubyte ptr
	values as double ptr
end type

type XIEventMask
	deviceid as long
	mask_len as long
	mask as ubyte ptr
end type

type XIAnyClassInfo
	as long type
	sourceid as long
end type

type XIButtonClassInfo
	as long type
	sourceid as long
	num_buttons as long
	labels as XAtom ptr
	state as XIButtonState
end type

type XIKeyClassInfo
	as long type
	sourceid as long
	num_keycodes as long
	keycodes as long ptr
end type

type XIValuatorClassInfo
	as long type
	sourceid as long
	number as long
	label as XAtom
	min as double
	max as double
	value as double
	resolution as long
	mode as long
end type

type XIScrollClassInfo
	as long type
	sourceid as long
	number as long
	scroll_type as long
	increment as double
	flags as long
end type

type XITouchClassInfo
	as long type
	sourceid as long
	mode as long
	num_touches as long
end type

type XIDeviceInfo
	deviceid as long
	name as zstring ptr
	use as long
	attachment as long
	enabled as long
	num_classes as long
	classes as XIAnyClassInfo ptr ptr
end type

type XIGrabModifiers
	modifiers as long
	status as long
end type

type BarrierEventID as ulong

type XIBarrierReleasePointerInfo
	deviceid as long
	barrier as PointerBarrier
	eventid as BarrierEventID
end type

type XIEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
end type

type XIHierarchyInfo
	deviceid as long
	attachment as long
	use as long
	enabled as long
	flags as long
end type

type XIHierarchyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	flags as long
	num_info as long
	info as XIHierarchyInfo ptr
end type

type XIDeviceChangedEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	sourceid as long
	reason as long
	num_classes as long
	classes as XIAnyClassInfo ptr ptr
end type

type XIDeviceEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	sourceid as long
	detail as long
	root as Window
	event as Window
	child as Window
	root_x as double
	root_y as double
	event_x as double
	event_y as double
	flags as long
	buttons as XIButtonState
	valuators as XIValuatorState
	mods as XIModifierState
	group as XIGroupState
end type

type XIRawEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	sourceid as long
	detail as long
	flags as long
	valuators as XIValuatorState
	raw_values as double ptr
end type

type XIEnterEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	sourceid as long
	detail as long
	root as Window
	event as Window
	child as Window
	root_x as double
	root_y as double
	event_x as double
	event_y as double
	mode as long
	focus as long
	same_screen as long
	buttons as XIButtonState
	mods as XIModifierState
	group as XIGroupState
end type

type XILeaveEvent as XIEnterEvent
type XIFocusInEvent as XIEnterEvent
type XIFocusOutEvent as XIEnterEvent

type XIPropertyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	property as XAtom
	what as long
end type

type XITouchOwnershipEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	sourceid as long
	touchid as ulong
	root as Window
	event as Window
	child as Window
	flags as long
end type

type XIBarrierEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	extension as long
	evtype as long
	time as Time
	deviceid as long
	sourceid as long
	event as Window
	root as Window
	root_x as double
	root_y as double
	dx as double
	dy as double
	dtime as long
	flags as long
	barrier as PointerBarrier
	eventid as BarrierEventID
end type

declare function XIQueryPointer(byval display as Display ptr, byval deviceid as long, byval win as Window, byval root as Window ptr, byval child as Window ptr, byval root_x as double ptr, byval root_y as double ptr, byval win_x as double ptr, byval win_y as double ptr, byval buttons as XIButtonState ptr, byval mods as XIModifierState ptr, byval group as XIGroupState ptr) as long
declare function XIWarpPointer(byval display as Display ptr, byval deviceid as long, byval src_win as Window, byval dst_win as Window, byval src_x as double, byval src_y as double, byval src_width as ulong, byval src_height as ulong, byval dst_x as double, byval dst_y as double) as long
declare function XIDefineCursor(byval display as Display ptr, byval deviceid as long, byval win as Window, byval cursor as Cursor) as long
declare function XIUndefineCursor(byval display as Display ptr, byval deviceid as long, byval win as Window) as long
declare function XIChangeHierarchy(byval display as Display ptr, byval changes as XIAnyHierarchyChangeInfo ptr, byval num_changes as long) as long
declare function XISetClientPointer(byval dpy as Display ptr, byval win as Window, byval deviceid as long) as long
declare function XIGetClientPointer(byval dpy as Display ptr, byval win as Window, byval deviceid as long ptr) as long
declare function XISelectEvents(byval dpy as Display ptr, byval win as Window, byval masks as XIEventMask ptr, byval num_masks as long) as long
declare function XIGetSelectedEvents(byval dpy as Display ptr, byval win as Window, byval num_masks_return as long ptr) as XIEventMask ptr
declare function XIQueryVersion(byval dpy as Display ptr, byval major_version_inout as long ptr, byval minor_version_inout as long ptr) as long
declare function XIQueryDevice(byval dpy as Display ptr, byval deviceid as long, byval ndevices_return as long ptr) as XIDeviceInfo ptr
declare function XISetFocus(byval dpy as Display ptr, byval deviceid as long, byval focus as Window, byval time as Time) as long
declare function XIGetFocus(byval dpy as Display ptr, byval deviceid as long, byval focus_return as Window ptr) as long
declare function XIGrabDevice(byval dpy as Display ptr, byval deviceid as long, byval grab_window as Window, byval time as Time, byval cursor as Cursor, byval grab_mode as long, byval paired_device_mode as long, byval owner_events as long, byval mask as XIEventMask ptr) as long
declare function XIUngrabDevice(byval dpy as Display ptr, byval deviceid as long, byval time as Time) as long
declare function XIAllowEvents(byval display as Display ptr, byval deviceid as long, byval event_mode as long, byval time as Time) as long
declare function XIAllowTouchEvents(byval display as Display ptr, byval deviceid as long, byval touchid as ulong, byval grab_window as Window, byval event_mode as long) as long
declare function XIGrabButton(byval display as Display ptr, byval deviceid as long, byval button as long, byval grab_window as Window, byval cursor as Cursor, byval grab_mode as long, byval paired_device_mode as long, byval owner_events as long, byval mask as XIEventMask ptr, byval num_modifiers as long, byval modifiers_inout as XIGrabModifiers ptr) as long
declare function XIGrabKeycode(byval display as Display ptr, byval deviceid as long, byval keycode as long, byval grab_window as Window, byval grab_mode as long, byval paired_device_mode as long, byval owner_events as long, byval mask as XIEventMask ptr, byval num_modifiers as long, byval modifiers_inout as XIGrabModifiers ptr) as long
declare function XIGrabEnter(byval display as Display ptr, byval deviceid as long, byval grab_window as Window, byval cursor as Cursor, byval grab_mode as long, byval paired_device_mode as long, byval owner_events as long, byval mask as XIEventMask ptr, byval num_modifiers as long, byval modifiers_inout as XIGrabModifiers ptr) as long
declare function XIGrabFocusIn(byval display as Display ptr, byval deviceid as long, byval grab_window as Window, byval grab_mode as long, byval paired_device_mode as long, byval owner_events as long, byval mask as XIEventMask ptr, byval num_modifiers as long, byval modifiers_inout as XIGrabModifiers ptr) as long
declare function XIGrabTouchBegin(byval display as Display ptr, byval deviceid as long, byval grab_window as Window, byval owner_events as long, byval mask as XIEventMask ptr, byval num_modifiers as long, byval modifiers_inout as XIGrabModifiers ptr) as long
declare function XIUngrabButton(byval display as Display ptr, byval deviceid as long, byval button as long, byval grab_window as Window, byval num_modifiers as long, byval modifiers as XIGrabModifiers ptr) as long
declare function XIUngrabKeycode(byval display as Display ptr, byval deviceid as long, byval keycode as long, byval grab_window as Window, byval num_modifiers as long, byval modifiers as XIGrabModifiers ptr) as long
declare function XIUngrabEnter(byval display as Display ptr, byval deviceid as long, byval grab_window as Window, byval num_modifiers as long, byval modifiers as XIGrabModifiers ptr) as long
declare function XIUngrabFocusIn(byval display as Display ptr, byval deviceid as long, byval grab_window as Window, byval num_modifiers as long, byval modifiers as XIGrabModifiers ptr) as long
declare function XIUngrabTouchBegin(byval display as Display ptr, byval deviceid as long, byval grab_window as Window, byval num_modifiers as long, byval modifiers as XIGrabModifiers ptr) as long
declare function XIListProperties(byval display as Display ptr, byval deviceid as long, byval num_props_return as long ptr) as XAtom ptr
declare sub XIChangeProperty(byval display as Display ptr, byval deviceid as long, byval property as XAtom, byval type as XAtom, byval format as long, byval mode as long, byval data as ubyte ptr, byval num_items as long)
declare sub XIDeleteProperty(byval display as Display ptr, byval deviceid as long, byval property as XAtom)
declare function XIGetProperty(byval display as Display ptr, byval deviceid as long, byval property as XAtom, byval offset as clong, byval length as clong, byval delete_property as long, byval type as XAtom, byval type_return as XAtom ptr, byval format_return as long ptr, byval num_items_return as culong ptr, byval bytes_after_return as culong ptr, byval data as ubyte ptr ptr) as long
declare sub XIBarrierReleasePointers(byval display as Display ptr, byval barriers as XIBarrierReleasePointerInfo ptr, byval num_barriers as long)
declare sub XIBarrierReleasePointer(byval display as Display ptr, byval deviceid as long, byval barrier as PointerBarrier, byval eventid as BarrierEventID)
declare sub XIFreeDeviceInfo(byval info as XIDeviceInfo ptr)

end extern
