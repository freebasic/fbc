''
''
'' XInput -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XInput_bi__
#define __XInput_bi__

#define _deviceKeyPress 0
#define _deviceKeyRelease 1
#define _deviceButtonPress 0
#define _deviceButtonRelease 1
#define _deviceMotionNotify 0
#define _deviceFocusIn 0
#define _deviceFocusOut 1
#define _proximityIn 0
#define _proximityOut 1
#define _deviceStateNotify 0
#define _deviceMappingNotify 1
#define _changeDeviceNotify 2
#define _propertyNotify 6

declare function _XiGetDevicePresenceNotifyEvent cdecl alias "_XiGetDevicePresenceNotifyEvent" (byval as Display ptr) as integer

type XDeviceKeyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	keycode as uinteger
	same_screen as Bool
	device_state as uinteger
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 6-1) as integer
end type

type XDeviceKeyPressedEvent as XDeviceKeyEvent
type XDeviceKeyReleasedEvent as XDeviceKeyEvent

type XDeviceButtonEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	button as uinteger
	same_screen as Bool
	device_state as uinteger
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 6-1) as integer
end type

type XDeviceButtonPressedEvent as XDeviceButtonEvent
type XDeviceButtonReleasedEvent as XDeviceButtonEvent

type XDeviceMotionEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	is_hint as byte
	same_screen as Bool
	device_state as uinteger
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 6-1) as integer
end type

type XDeviceFocusChangeEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	mode as integer
	detail as integer
	time as Time
end type

type XDeviceFocusInEvent as XDeviceFocusChangeEvent
type XDeviceFocusOutEvent as XDeviceFocusChangeEvent

type XProximityNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	root as Window
	subwindow as Window
	time as Time
	x as integer
	y as integer
	x_root as integer
	y_root as integer
	state as uinteger
	same_screen as Bool
	device_state as uinteger
	axes_count as ubyte
	first_axis as ubyte
	axis_data(0 to 6-1) as integer
end type

type XProximityInEvent as XProximityNotifyEvent
type XProximityOutEvent as XProximityNotifyEvent

type XInputClass
	class as ubyte
	length as ubyte
end type

type XDeviceStateNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	time as Time
	num_classes as integer
	data as zstring * 64
end type

type XValuatorStatus
	class as ubyte
	length as ubyte
	num_valuators as ubyte
	mode as ubyte
	valuators(0 to 6-1) as integer
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
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	time as Time
	request as integer
	first_keycode as integer
	count as integer
end type

type XChangeDeviceNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	deviceid as XID
	time as Time
	request as integer
end type

type XDevicePresenceNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	time as Time
	devchange as Bool
	deviceid as XID
	control as XID
end type

type XDevicePropertyNotifyEvent
	type as integer
	serial as uinteger
	send_event as Bool
	display as Display ptr
	window as Window
	time as Time
	deviceid as XID
	atom as Atom
	state as integer
end type

type XFeedbackState
	class as XID
	length as integer
	id as XID
end type

type XKbdFeedbackState
	class as XID
	length as integer
	id as XID
	click as integer
	percent as integer
	pitch as integer
	duration as integer
	led_mask as integer
	global_auto_repeat as integer
	auto_repeats as zstring * 32
end type

type XPtrFeedbackState
	class as XID
	length as integer
	id as XID
	accelNum as integer
	accelDenom as integer
	threshold as integer
end type

type XIntegerFeedbackState
	class as XID
	length as integer
	id as XID
	resolution as integer
	minVal as integer
	maxVal as integer
end type

type XStringFeedbackState
	class as XID
	length as integer
	id as XID
	max_symbols as integer
	num_syms_supported as integer
	syms_supported as KeySym ptr
end type

type XBellFeedbackState
	class as XID
	length as integer
	id as XID
	percent as integer
	pitch as integer
	duration as integer
end type

type XLedFeedbackState
	class as XID
	length as integer
	id as XID
	led_values as integer
	led_mask as integer
end type

type XFeedbackControl
	class as XID
	length as integer
	id as XID
end type

type XPtrFeedbackControl
	class as XID
	length as integer
	id as XID
	accelNum as integer
	accelDenom as integer
	threshold as integer
end type

type XKbdFeedbackControl
	class as XID
	length as integer
	id as XID
	click as integer
	percent as integer
	pitch as integer
	duration as integer
	led_mask as integer
	led_value as integer
	key as integer
	auto_repeat_mode as integer
end type

type XStringFeedbackControl
	class as XID
	length as integer
	id as XID
	num_keysyms as integer
	syms_to_display as KeySym ptr
end type

type XIntegerFeedbackControl
	class as XID
	length as integer
	id as XID
	int_to_display as integer
end type

type XBellFeedbackControl
	class as XID
	length as integer
	id as XID
	percent as integer
	pitch as integer
	duration as integer
end type

type XLedFeedbackControl
	class as XID
	length as integer
	id as XID
	led_mask as integer
	led_values as integer
end type

type XDeviceControl
	control as XID
	length as integer
end type

type XDeviceResolutionControl
	control as XID
	length as integer
	first_valuator as integer
	num_valuators as integer
	resolutions as integer ptr
end type

type XDeviceResolutionState
	control as XID
	length as integer
	num_valuators as integer
	resolutions as integer ptr
	min_resolutions as integer ptr
	max_resolutions as integer ptr
end type

type XDeviceAbsCalibControl
	control as XID
	length as integer
	min_x as integer
	max_x as integer
	min_y as integer
	max_y as integer
	flip_x as integer
	flip_y as integer
	rotation as integer
	button_threshold as integer
end type

type XDeviceAbsCalibState as XDeviceAbsCalibControl

type XDeviceAbsAreaControl
	control as XID
	length as integer
	offset_x as integer
	offset_y as integer
	width as integer
	height as integer
	screen as integer
	following as XID
end type

type XDeviceAbsAreaState as XDeviceAbsAreaControl

type XDeviceCoreControl
	control as XID
	length as integer
	status as integer
end type

type XDeviceCoreState
	control as XID
	length as integer
	status as integer
	iscore as integer
end type

type XDeviceEnableControl
	control as XID
	length as integer
	enable as integer
end type

type XDeviceEnableState as XDeviceEnableControl
type XAnyClassPtr as _XAnyClassinfo ptr

type _XAnyClassinfo
	class as XID
	length as integer
end type

type XAnyClassInfo as _XAnyClassinfo
type XDeviceInfoPtr as _XDeviceInfo ptr

type _XDeviceInfo
	id as XID
	type as Atom
	name as zstring ptr
	num_classes as integer
	use as integer
	inputclassinfo as XAnyClassPtr
end type

type XDeviceInfo as _XDeviceInfo
type XKeyInfoPtr as _XKeyInfo ptr

type _XKeyInfo
	class as XID
	length as integer
	min_keycode as ushort
	max_keycode as ushort
	num_keys as ushort
end type

type XKeyInfo as _XKeyInfo
type XButtonInfoPtr as _XButtonInfo ptr

type _XButtonInfo
	class as XID
	length as integer
	num_buttons as short
end type

type XButtonInfo as _XButtonInfo
type XAxisInfoPtr as _XAxisInfo ptr

type _XAxisInfo
	resolution as integer
	min_value as integer
	max_value as integer
end type

type XAxisInfo as _XAxisInfo
type XValuatorInfoPtr as _XValuatorInfo ptr

type _XValuatorInfo
	class as XID
	length as integer
	num_axes as ubyte
	mode as ubyte
	motion_buffer as uinteger
	axes as XAxisInfoPtr
end type

type XValuatorInfo as _XValuatorInfo

type XInputClassInfo
	input_class as ubyte
	event_type_base as ubyte
end type

type XDevice
	device_id as XID
	num_classes as integer
	classes as XInputClassInfo ptr
end type

type XEventList
	event_type as XEventClass
	device as XID
end type

type XDeviceTimeCoord
	time as Time
	data as integer ptr
end type

type XDeviceState
	device_id as XID
	num_classes as integer
	data as XInputClass ptr
end type

type XValuatorState
	class as ubyte
	length as ubyte
	num_valuators as ubyte
	mode as ubyte
	valuators as integer ptr
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

declare function XChangePointerDevice cdecl alias "XChangePointerDevice" (byval as Display ptr, byval as XDevice ptr, byval as integer, byval as integer) as integer
declare function XGrabDevice cdecl alias "XGrabDevice" (byval as Display ptr, byval as XDevice ptr, byval as Window, byval as Bool, byval as integer, byval as XEventClass ptr, byval as integer, byval as integer, byval as Time) as integer
declare function XUngrabDevice cdecl alias "XUngrabDevice" (byval as Display ptr, byval as XDevice ptr, byval as Time) as integer
declare function XGrabDeviceKey cdecl alias "XGrabDeviceKey" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as uinteger, byval as XDevice ptr, byval as Window, byval as Bool, byval as uinteger, byval as XEventClass ptr, byval as integer, byval as integer) as integer
declare function XUngrabDeviceKey cdecl alias "XUngrabDeviceKey" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as uinteger, byval as XDevice ptr, byval as Window) as integer
declare function XGrabDeviceButton cdecl alias "XGrabDeviceButton" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as uinteger, byval as XDevice ptr, byval as Window, byval as Bool, byval as uinteger, byval as XEventClass ptr, byval as integer, byval as integer) as integer
declare function XUngrabDeviceButton cdecl alias "XUngrabDeviceButton" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as uinteger, byval as XDevice ptr, byval as Window) as integer
declare function XAllowDeviceEvents cdecl alias "XAllowDeviceEvents" (byval as Display ptr, byval as XDevice ptr, byval as integer, byval as Time) as integer
declare function XGetDeviceFocus cdecl alias "XGetDeviceFocus" (byval as Display ptr, byval as XDevice ptr, byval as Window ptr, byval as integer ptr, byval as Time ptr) as integer
declare function XSetDeviceFocus cdecl alias "XSetDeviceFocus" (byval as Display ptr, byval as XDevice ptr, byval as Window, byval as integer, byval as Time) as integer
declare function XGetFeedbackControl cdecl alias "XGetFeedbackControl" (byval as Display ptr, byval as XDevice ptr, byval as integer ptr) as XFeedbackState ptr
declare sub XFreeFeedbackList cdecl alias "XFreeFeedbackList" (byval as XFeedbackState ptr)
declare function XChangeFeedbackControl cdecl alias "XChangeFeedbackControl" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as XFeedbackControl ptr) as integer
declare function XDeviceBell cdecl alias "XDeviceBell" (byval as Display ptr, byval as XDevice ptr, byval as XID, byval as XID, byval as integer) as integer
declare function XGetDeviceKeyMapping cdecl alias "XGetDeviceKeyMapping" (byval as Display ptr, byval as XDevice ptr, byval as KeyCode, byval as integer, byval as integer ptr) as KeySym ptr
declare function XChangeDeviceKeyMapping cdecl alias "XChangeDeviceKeyMapping" (byval as Display ptr, byval as XDevice ptr, byval as integer, byval as integer, byval as KeySym ptr, byval as integer) as integer
declare function XGetDeviceModifierMapping cdecl alias "XGetDeviceModifierMapping" (byval as Display ptr, byval as XDevice ptr) as XModifierKeymap ptr
declare function XSetDeviceModifierMapping cdecl alias "XSetDeviceModifierMapping" (byval as Display ptr, byval as XDevice ptr, byval as XModifierKeymap ptr) as integer
declare function XSetDeviceButtonMapping cdecl alias "XSetDeviceButtonMapping" (byval as Display ptr, byval as XDevice ptr, byval as ubyte ptr, byval as integer) as integer
declare function XGetDeviceButtonMapping cdecl alias "XGetDeviceButtonMapping" (byval as Display ptr, byval as XDevice ptr, byval as ubyte ptr, byval as uinteger) as integer
declare function XQueryDeviceState cdecl alias "XQueryDeviceState" (byval as Display ptr, byval as XDevice ptr) as XDeviceState ptr
declare sub XFreeDeviceState cdecl alias "XFreeDeviceState" (byval as XDeviceState ptr)
declare function XListInputDevices cdecl alias "XListInputDevices" (byval as Display ptr, byval as integer ptr) as XDeviceInfo ptr
declare sub XFreeDeviceList cdecl alias "XFreeDeviceList" (byval as XDeviceInfo ptr)
declare function XOpenDevice cdecl alias "XOpenDevice" (byval as Display ptr, byval as XID) as XDevice ptr
declare function XCloseDevice cdecl alias "XCloseDevice" (byval as Display ptr, byval as XDevice ptr) as integer
declare function XSetDeviceMode cdecl alias "XSetDeviceMode" (byval as Display ptr, byval as XDevice ptr, byval as integer) as integer
declare function XSetDeviceValuators cdecl alias "XSetDeviceValuators" (byval as Display ptr, byval as XDevice ptr, byval as integer ptr, byval as integer, byval as integer) as integer
declare function XGetDeviceControl cdecl alias "XGetDeviceControl" (byval as Display ptr, byval as XDevice ptr, byval as integer) as XDeviceControl ptr
declare function XChangeDeviceControl cdecl alias "XChangeDeviceControl" (byval as Display ptr, byval as XDevice ptr, byval as integer, byval as XDeviceControl ptr) as integer
declare function XSelectExtensionEvent cdecl alias "XSelectExtensionEvent" (byval as Display ptr, byval as Window, byval as XEventClass ptr, byval as integer) as integer
declare function XGetSelectedExtensionEvents cdecl alias "XGetSelectedExtensionEvents" (byval as Display ptr, byval as Window, byval as integer ptr, byval as XEventClass ptr ptr, byval as integer ptr, byval as XEventClass ptr ptr) as integer
declare function XChangeDeviceDontPropagateList cdecl alias "XChangeDeviceDontPropagateList" (byval as Display ptr, byval as Window, byval as integer, byval as XEventClass ptr, byval as integer) as integer
declare function XGetDeviceDontPropagateList cdecl alias "XGetDeviceDontPropagateList" (byval as Display ptr, byval as Window, byval as integer ptr) as XEventClass ptr
declare function XSendExtensionEvent cdecl alias "XSendExtensionEvent" (byval as Display ptr, byval as XDevice ptr, byval as Window, byval as Bool, byval as integer, byval as XEventClass ptr, byval as XEvent ptr) as Status
declare function XGetDeviceMotionEvents cdecl alias "XGetDeviceMotionEvents" (byval as Display ptr, byval as XDevice ptr, byval as Time, byval as Time, byval as integer ptr, byval as integer ptr, byval as integer ptr) as XDeviceTimeCoord ptr
declare sub XFreeDeviceMotionEvents cdecl alias "XFreeDeviceMotionEvents" (byval as XDeviceTimeCoord ptr)
declare sub XFreeDeviceControl cdecl alias "XFreeDeviceControl" (byval as XDeviceControl ptr)

type XIPropertyInfo
	pending as Bool
	range as Bool
	immutable as Bool
	fromClient as Bool
	num_values as integer
	values as integer ptr
end type

declare function XListDeviceProperties cdecl alias "XListDeviceProperties" (byval as Display ptr, byval as XDevice ptr, byval as integer ptr) as Atom ptr
declare sub XDeleteDeviceProperty cdecl alias "XDeleteDeviceProperty" (byval as Display ptr, byval as XDevice ptr, byval as Atom)
declare function XGetDeviceProperty cdecl alias "XGetDeviceProperty" (byval as Display ptr, byval as XDevice ptr, byval as Atom, byval as integer, byval as integer, byval as Bool, byval as Atom, byval as Atom ptr, byval as integer ptr, byval as uinteger ptr, byval as uinteger ptr, byval as ubyte ptr ptr) as Status

#endif
