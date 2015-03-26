#pragma once

#include once "crt/long.bi"
#include once "X11/extensions/xtestext1const.bi"

extern "C"

#define _XTESTEXT1_H

type XTestInputActionEvent
	as long type
	display as Display ptr
	window as Window
	actions(0 to 27) as CARD8
end type

type XTestFakeAckEvent
	as long type
	display as Display ptr
	window as Window
end type

declare function XTestFakeInput(byval dpy as Display ptr, byval action_list_addr as zstring ptr, byval action_list_size as long, byval ack_flag as long) as long
declare function XTestGetInput(byval dpy as Display ptr, byval action_handling as long) as long
declare function XTestQueryInputSize(byval dpy as Display ptr, byval size_return as culong ptr) as long
declare function XTestPressKey(byval display as Display ptr, byval device_id as long, byval delay as culong, byval keycode as ulong, byval key_action as ulong) as long
declare function XTestPressButton(byval display as Display ptr, byval device_id as long, byval delay as culong, byval button_number as ulong, byval button_action as ulong) as long
declare function XTestMovePointer(byval display as Display ptr, byval device_id as long, byval delay as culong ptr, byval x as long ptr, byval y as long ptr, byval count as ulong) as long
declare function XTestFlush(byval display as Display ptr) as long
declare function XTestStopInput(byval dpy as Display ptr) as long
declare function XTestReset(byval dpy as Display ptr) as long

end extern
