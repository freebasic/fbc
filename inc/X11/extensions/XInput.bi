'' FreeBASIC binding for libXi-1.7.4
''
'' based on the C header files:
''   **********************************************************
''
''   Copyright 1989, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''   Copyright 1989 by Hewlett-Packard Company, Palo Alto, California.
''
''   			All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Hewlett-Packard not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   HEWLETT-PACKARD DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   HEWLETT-PACKARD BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *******************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "X11/Xlib.bi"
#include once "X11/extensions/XI.bi"

extern "C"

#define _XINPUT_H_
const _deviceKeyPress = 0
const _deviceKeyRelease = 1
const _deviceButtonPress = 0
const _deviceButtonRelease = 1
const _deviceMotionNotify = 0
const _deviceFocusIn = 0
const _deviceFocusOut = 1
const _proximityIn = 0
const _proximityOut = 1
const _deviceStateNotify = 0
const _deviceMappingNotify = 1
const _changeDeviceNotify = 2
const _propertyNotify = 6
#macro FindTypeAndClass(d, type, _class, classid, offset)
	scope
		dim _i as long
		dim _ip as XInputClassInfo ptr = cptr(XDevice ptr, d)->classes
		type = 0
		_class = 0
		while _i < cptr(XDevice ptr, d)->num_classes
			if _ip->input_class = classid then
				type = _ip->event_type_base + offset
				_class = (cptr(XDevice ptr, d)->device_id shl 8) or type
			end if
			_i += 1
			_ip += 1
		wend
	end scope
#endmacro
#define DeviceKeyPress(d, type, _class) FindTypeAndClass(d, type, _class, KeyClass, _deviceKeyPress)
#define DeviceKeyRelease(d, type, _class) FindTypeAndClass(d, type, _class, KeyClass, _deviceKeyRelease)
#define DeviceButtonPress(d, type, _class) FindTypeAndClass(d, type, _class, ButtonClass, _deviceButtonPress)
#define DeviceButtonRelease(d, type, _class) FindTypeAndClass(d, type, _class, ButtonClass, _deviceButtonRelease)
#define DeviceMotionNotify(d, type, _class) FindTypeAndClass(d, type, _class, ValuatorClass, _deviceMotionNotify)
#define DeviceFocusIn(d, type, _class) FindTypeAndClass(d, type, _class, FocusClass, _deviceFocusIn)
#define DeviceFocusOut(d, type, _class) FindTypeAndClass(d, type, _class, FocusClass, _deviceFocusOut)
#define ProximityIn(d, type, _class) FindTypeAndClass(d, type, _class, ProximityClass, _proximityIn)
#define ProximityOut(d, type, _class) FindTypeAndClass(d, type, _class, ProximityClass, _proximityOut)
#define DeviceStateNotify(d, type, _class) FindTypeAndClass(d, type, _class, OtherClass, _deviceStateNotify)
#define DeviceMappingNotify(d, type, _class) FindTypeAndClass(d, type, _class, OtherClass, _deviceMappingNotify)
#define ChangeDeviceNotify(d, type, _class) FindTypeAndClass(d, type, _class, OtherClass, _changeDeviceNotify)
#define DevicePropertyNotify(d, type, _class) FindTypeAndClass(d, type, _class, OtherClass, _propertyNotify)
#define DevicePointerMotionHint(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _devicePointerMotionHint : end scope
#define DeviceButton1Motion(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButton1Motion : end scope
#define DeviceButton2Motion(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButton2Motion : end scope
#define DeviceButton3Motion(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButton3Motion : end scope
#define DeviceButton4Motion(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButton4Motion : end scope
#define DeviceButton5Motion(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButton5Motion : end scope
#define DeviceButtonMotion(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButtonMotion : end scope
#define DeviceOwnerGrabButton(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceOwnerGrabButton : end scope
#define DeviceButtonPressGrab(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _deviceButtonGrab : end scope
#define NoExtensionEvent(d, type, _class) scope : _class = (cptr(XDevice ptr, d)->device_id shl 8) or _noExtensionEvent : end scope

declare function _XiGetDevicePresenceNotifyEvent(byval as Display ptr) as long
declare sub _xibaddevice(byval dpy as Display ptr, byval error as long ptr)
declare sub _xibadclass(byval dpy as Display ptr, byval error as long ptr)
declare sub _xibadevent(byval dpy as Display ptr, byval error as long ptr)
declare sub _xibadmode(byval dpy as Display ptr, byval error as long ptr)
declare sub _xidevicebusy(byval dpy as Display ptr, byval error as long ptr)

#macro DevicePresence(dpy, type, _class)
	scope
		type = _XiGetDevicePresenceNotifyEvent(dpy)
		_class = &h10000 or _devicePresence
	end scope
#endmacro
#define BadDevice(dpy, error) _xibaddevice(dpy, @error)
#define BadClass(dpy, error) _xibadclass(dpy, @error)
#define BadEvent(dpy, error) _xibadevent(dpy, @error)
#define BadMode(dpy, error) _xibadmode(dpy, @error)
#define DeviceBusy(dpy, error) _xidevicebusy(dpy, @error)
type XAnyClassPtr as _XAnyClassinfo ptr

type XDeviceKeyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	keycode as ulong
	same_screen as long
	device_state as ulong
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 5) as long
end type

type XDeviceKeyPressedEvent as XDeviceKeyEvent
type XDeviceKeyReleasedEvent as XDeviceKeyEvent

type XDeviceButtonEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	button as ulong
	same_screen as long
	device_state as ulong
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 5) as long
end type

type XDeviceButtonPressedEvent as XDeviceButtonEvent
type XDeviceButtonReleasedEvent as XDeviceButtonEvent

type XDeviceMotionEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	is_hint as byte
	same_screen as long
	device_state as ulong
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 5) as long
end type

type XDeviceFocusChangeEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	mode as long
	detail as long
	time as Time
end type

type XDeviceFocusInEvent as XDeviceFocusChangeEvent
type XDeviceFocusOutEvent as XDeviceFocusChangeEvent

type XProximityNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as long
	y as long
	x_root as long
	y_root as long
	state as ulong
	same_screen as long
	device_state as ulong
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 5) as long
end type

type XProximityInEvent as XProximityNotifyEvent
type XProximityOutEvent as XProximityNotifyEvent

type XInputClass
	class as ubyte
	length as ubyte
end type

type XDeviceStateNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	time as Time
	num_classes as long
	data as zstring * 64
end type

type XValuatorStatus
	class as ubyte
	length as ubyte
	num_valuators as ubyte
	mode as ubyte
	valuators(0 to 5) as long
end type

type XKeyStatus
	class as ubyte
	length as ubyte
	num_keys as short
	keys as zstring * 32
end type

type XButtonStatus
	class as ubyte
	length as ubyte
	num_buttons as short
	buttons as zstring * 32
end type

type XDeviceMappingEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	time as Time
	request as long
	first_keycode as long
	count as long
end type

type XChangeDeviceNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	deviceid as XID
	time as Time
	request as long
end type

type XDevicePresenceNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	time as Time
	devchange as long
	deviceid as XID
	control as XID
end type

type XDevicePropertyNotifyEvent
	as long type
	serial as culong
	send_event as long
	display as Display ptr
	window as Window
	time as Time
	deviceid as XID
	atom as XAtom
	state as long
end type

type XFeedbackState
	class as XID
	length as long
	id as XID
end type

type XKbdFeedbackState
	class as XID
	length as long
	id as XID
	click as long
	percent as long
	pitch as long
	duration as long
	led_mask as long
	global_auto_repeat as long
	auto_repeats as zstring * 32
end type

type XPtrFeedbackState
	class as XID
	length as long
	id as XID
	accelNum as long
	accelDenom as long
	threshold as long
end type

type XIntegerFeedbackState
	class as XID
	length as long
	id as XID
	resolution as long
	minVal as long
	maxVal as long
end type

type XStringFeedbackState
	class as XID
	length as long
	id as XID
	max_symbols as long
	num_syms_supported as long
	syms_supported as KeySym ptr
end type

type XBellFeedbackState
	class as XID
	length as long
	id as XID
	percent as long
	pitch as long
	duration as long
end type

type XLedFeedbackState
	class as XID
	length as long
	id as XID
	led_values as long
	led_mask as long
end type

type XFeedbackControl
	class as XID
	length as long
	id as XID
end type

type XPtrFeedbackControl
	class as XID
	length as long
	id as XID
	accelNum as long
	accelDenom as long
	threshold as long
end type

type XKbdFeedbackControl
	class as XID
	length as long
	id as XID
	click as long
	percent as long
	pitch as long
	duration as long
	led_mask as long
	led_value as long
	key as long
	auto_repeat_mode as long
end type

type XStringFeedbackControl
	class as XID
	length as long
	id as XID
	num_keysyms as long
	syms_to_display as KeySym ptr
end type

type XIntegerFeedbackControl
	class as XID
	length as long
	id as XID
	int_to_display as long
end type

type XBellFeedbackControl
	class as XID
	length as long
	id as XID
	percent as long
	pitch as long
	duration as long
end type

type XLedFeedbackControl
	class as XID
	length as long
	id as XID
	led_mask as long
	led_values as long
end type

type XDeviceControl
	control as XID
	length as long
end type

type XDeviceResolutionControl
	control as XID
	length as long
	first_valuator as long
	num_valuators as long
	resolutions as long ptr
end type

type XDeviceResolutionState
	control as XID
	length as long
	num_valuators as long
	resolutions as long ptr
	min_resolutions as long ptr
	max_resolutions as long ptr
end type

type XDeviceAbsCalibControl
	control as XID
	length as long
	min_x as long
	max_x as long
	min_y as long
	max_y as long
	flip_x as long
	flip_y as long
	rotation as long
	button_threshold as long
end type

type XDeviceAbsCalibState as XDeviceAbsCalibControl

type XDeviceAbsAreaControl
	control as XID
	length as long
	offset_x as long
	offset_y as long
	width as long
	height as long
	screen as long
	following as XID
end type

type XDeviceAbsAreaState as XDeviceAbsAreaControl

type XDeviceCoreControl
	control as XID
	length as long
	status as long
end type

type XDeviceCoreState
	control as XID
	length as long
	status as long
	iscore as long
end type

type XDeviceEnableControl
	control as XID
	length as long
	enable as long
end type

type XDeviceEnableState as XDeviceEnableControl

type _XAnyClassinfo
	class as XID
	length as long
end type

type XAnyClassInfo as _XAnyClassinfo
type XDeviceInfoPtr as _XDeviceInfo ptr

type _XDeviceInfo
	id as XID
	as XAtom type
	name as zstring ptr
	num_classes as long
	use as long
	inputclassinfo as XAnyClassPtr
end type

type XDeviceInfo as _XDeviceInfo
type XKeyInfoPtr as _XKeyInfo ptr

type _XKeyInfo
	class as XID
	length as long
	min_keycode as ushort
	max_keycode as ushort
	num_keys as ushort
end type

type XKeyInfo as _XKeyInfo
type XButtonInfoPtr as _XButtonInfo ptr

type _XButtonInfo
	class as XID
	length as long
	num_buttons as short
end type

type XButtonInfo as _XButtonInfo
type XAxisInfoPtr as _XAxisInfo ptr

type _XAxisInfo
	resolution as long
	min_value as long
	max_value as long
end type

type XAxisInfo as _XAxisInfo
type XValuatorInfoPtr as _XValuatorInfo ptr

type _XValuatorInfo
	class as XID
	length as long
	num_axes as ubyte
	mode as ubyte
	motion_buffer as culong
	axes as XAxisInfoPtr
end type

type XValuatorInfo as _XValuatorInfo

type XInputClassInfo
	input_class as ubyte
	event_type_base as ubyte
end type

type XDevice
	device_id as XID
	num_classes as long
	classes as XInputClassInfo ptr
end type

type XEventList
	event_type as XEventClass
	device as XID
end type

type XDeviceTimeCoord
	time as Time
	data as long ptr
end type

type XDeviceState
	device_id as XID
	num_classes as long
	data as XInputClass ptr
end type

type XValuatorState
	class as ubyte
	length as ubyte
	num_valuators as ubyte
	mode as ubyte
	valuators as long ptr
end type

type XKeyState
	class as ubyte
	length as ubyte
	num_keys as short
	keys as zstring * 32
end type

type XButtonState
	class as ubyte
	length as ubyte
	num_buttons as short
	buttons as zstring * 32
end type

declare function XChangeKeyboardDevice(byval as Display ptr, byval as XDevice ptr) as long
declare function XChangePointerDevice(byval as Display ptr, byval as XDevice ptr, byval as long, byval as long) as long
declare function XGrabDevice(byval as Display ptr, byval as XDevice ptr, byval as Window, byval as long, byval as long, byval as XEventClass ptr, byval as long, byval as long, byval as Time) as long
declare function XUngrabDevice(byval as Display ptr, byval as XDevice ptr, byval as Time) as long
declare function XGrabDeviceKey(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as ulong, byval as XDevice ptr, byval as Window, byval as long, byval as ulong, byval as XEventClass ptr, byval as long, byval as long) as long
declare function XUngrabDeviceKey(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as ulong, byval as XDevice ptr, byval as Window) as long
declare function XGrabDeviceButton(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as ulong, byval as XDevice ptr, byval as Window, byval as long, byval as ulong, byval as XEventClass ptr, byval as long, byval as long) as long
declare function XUngrabDeviceButton(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as ulong, byval as XDevice ptr, byval as Window) as long
declare function XAllowDeviceEvents(byval as Display ptr, byval as XDevice ptr, byval as long, byval as Time) as long
declare function XGetDeviceFocus(byval as Display ptr, byval as XDevice ptr, byval as Window ptr, byval as long ptr, byval as Time ptr) as long
declare function XSetDeviceFocus(byval as Display ptr, byval as XDevice ptr, byval as Window, byval as long, byval as Time) as long
declare function XGetFeedbackControl(byval as Display ptr, byval as XDevice ptr, byval as long ptr) as XFeedbackState ptr
declare sub XFreeFeedbackList(byval as XFeedbackState ptr)
declare function XChangeFeedbackControl(byval as Display ptr, byval as XDevice ptr, byval as culong, byval as XFeedbackControl ptr) as long
declare function XDeviceBell(byval as Display ptr, byval as XDevice ptr, byval as XID, byval as XID, byval as long) as long
declare function XGetDeviceKeyMapping(byval as Display ptr, byval as XDevice ptr, byval as KeyCode, byval as long, byval as long ptr) as KeySym ptr
declare function XChangeDeviceKeyMapping(byval as Display ptr, byval as XDevice ptr, byval as long, byval as long, byval as KeySym ptr, byval as long) as long
declare function XGetDeviceModifierMapping(byval as Display ptr, byval as XDevice ptr) as XModifierKeymap ptr
declare function XSetDeviceModifierMapping(byval as Display ptr, byval as XDevice ptr, byval as XModifierKeymap ptr) as long
declare function XSetDeviceButtonMapping(byval as Display ptr, byval as XDevice ptr, byval as ubyte ptr, byval as long) as long
declare function XGetDeviceButtonMapping(byval as Display ptr, byval as XDevice ptr, byval as ubyte ptr, byval as ulong) as long
declare function XQueryDeviceState(byval as Display ptr, byval as XDevice ptr) as XDeviceState ptr
declare sub XFreeDeviceState(byval as XDeviceState ptr)
declare function XGetExtensionVersion(byval as Display ptr, byval as const zstring ptr) as XExtensionVersion ptr
declare function XListInputDevices(byval as Display ptr, byval as long ptr) as XDeviceInfo ptr
declare sub XFreeDeviceList(byval as XDeviceInfo ptr)
declare function XOpenDevice(byval as Display ptr, byval as XID) as XDevice ptr
declare function XCloseDevice(byval as Display ptr, byval as XDevice ptr) as long
declare function XSetDeviceMode(byval as Display ptr, byval as XDevice ptr, byval as long) as long
declare function XSetDeviceValuators(byval as Display ptr, byval as XDevice ptr, byval as long ptr, byval as long, byval as long) as long
declare function XGetDeviceControl(byval as Display ptr, byval as XDevice ptr, byval as long) as XDeviceControl ptr
declare function XChangeDeviceControl(byval as Display ptr, byval as XDevice ptr, byval as long, byval as XDeviceControl ptr) as long
declare function XSelectExtensionEvent(byval as Display ptr, byval as Window, byval as XEventClass ptr, byval as long) as long
declare function XGetSelectedExtensionEvents(byval as Display ptr, byval as Window, byval as long ptr, byval as XEventClass ptr ptr, byval as long ptr, byval as XEventClass ptr ptr) as long
declare function XChangeDeviceDontPropagateList(byval as Display ptr, byval as Window, byval as long, byval as XEventClass ptr, byval as long) as long
declare function XGetDeviceDontPropagateList(byval as Display ptr, byval as Window, byval as long ptr) as XEventClass ptr
declare function XSendExtensionEvent(byval as Display ptr, byval as XDevice ptr, byval as Window, byval as long, byval as long, byval as XEventClass ptr, byval as XEvent ptr) as long
declare function XGetDeviceMotionEvents(byval as Display ptr, byval as XDevice ptr, byval as Time, byval as Time, byval as long ptr, byval as long ptr, byval as long ptr) as XDeviceTimeCoord ptr
declare sub XFreeDeviceMotionEvents(byval as XDeviceTimeCoord ptr)
declare sub XFreeDeviceControl(byval as XDeviceControl ptr)
declare function XListDeviceProperties(byval as Display ptr, byval as XDevice ptr, byval as long ptr) as XAtom ptr
declare sub XChangeDeviceProperty(byval as Display ptr, byval as XDevice ptr, byval as XAtom, byval as XAtom, byval as long, byval as long, byval as const ubyte ptr, byval as long)
declare sub XDeleteDeviceProperty(byval as Display ptr, byval as XDevice ptr, byval as XAtom)
declare function XGetDeviceProperty(byval as Display ptr, byval as XDevice ptr, byval as XAtom, byval as clong, byval as clong, byval as long, byval as XAtom, byval as XAtom ptr, byval as long ptr, byval as culong ptr, byval as culong ptr, byval as ubyte ptr ptr) as long

end extern
