#pragma once

#include once "crt/long.bi"
#include once "X11/Xfuncproto.bi"
#include once "X11/extensions/xtestconst.bi"
#include once "X11/extensions/XInput.bi"

extern "C"

#define _XTEST_H_
declare function XTestQueryExtension(byval as Display ptr, byval as long ptr, byval as long ptr, byval as long ptr, byval as long ptr) as long
declare function XTestCompareCursorWithWindow(byval as Display ptr, byval as Window, byval as Cursor) as long
declare function XTestCompareCurrentCursorWithWindow(byval as Display ptr, byval as Window) as long
declare function XTestFakeKeyEvent(byval as Display ptr, byval as ulong, byval as long, byval as culong) as long
declare function XTestFakeButtonEvent(byval as Display ptr, byval as ulong, byval as long, byval as culong) as long
declare function XTestFakeMotionEvent(byval as Display ptr, byval as long, byval as long, byval as long, byval as culong) as long
declare function XTestFakeRelativeMotionEvent(byval as Display ptr, byval as long, byval as long, byval as culong) as long
declare function XTestFakeDeviceKeyEvent(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestFakeDeviceButtonEvent(byval as Display ptr, byval as XDevice ptr, byval as ulong, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestFakeProximityEvent(byval as Display ptr, byval as XDevice ptr, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestFakeDeviceMotionEvent(byval as Display ptr, byval as XDevice ptr, byval as long, byval as long, byval as long ptr, byval as long, byval as culong) as long
declare function XTestGrabControl(byval as Display ptr, byval as long) as long
declare sub XTestSetGContextOfGC(byval as GC, byval as GContext)
declare sub XTestSetVisualIDOfVisual(byval as Visual ptr, byval as VisualID)
declare function XTestDiscard(byval as Display ptr) as long

end extern
