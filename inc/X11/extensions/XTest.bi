''
''
'' XTest -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __XTest_bi__
#define __XTest_bi__

#define X_XTestGetVersion 0
#define X_XTestCompareCursor 1
#define X_XTestFakeInput 2
#define X_XTestGrabControl 3
#define XTestNumberEvents 0
#define XTestNumberErrors 0
#define XTestMajorVersion 2
#define XTestMinorVersion 2
#define XTestExtensionName "XTEST"

declare function XTestCompareCurrentCursorWithWindow cdecl alias "XTestCompareCurrentCursorWithWindow" (byval as Display ptr, byval as Window) as Bool
declare function XTestFakeKeyEvent cdecl alias "XTestFakeKeyEvent" (byval as Display ptr, byval as uinteger, byval as Bool, byval as uinteger) as integer
declare function XTestFakeButtonEvent cdecl alias "XTestFakeButtonEvent" (byval as Display ptr, byval as uinteger, byval as Bool, byval as uinteger) as integer
declare function XTestFakeMotionEvent cdecl alias "XTestFakeMotionEvent" (byval as Display ptr, byval as integer, byval as integer, byval as integer, byval as uinteger) as integer
declare function XTestFakeRelativeMotionEvent cdecl alias "XTestFakeRelativeMotionEvent" (byval as Display ptr, byval as integer, byval as integer, byval as uinteger) as integer
declare function XTestFakeDeviceKeyEvent cdecl alias "XTestFakeDeviceKeyEvent" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as Bool, byval as integer ptr, byval as integer, byval as uinteger) as integer
declare function XTestFakeDeviceButtonEvent cdecl alias "XTestFakeDeviceButtonEvent" (byval as Display ptr, byval as XDevice ptr, byval as uinteger, byval as Bool, byval as integer ptr, byval as integer, byval as uinteger) as integer
declare function XTestFakeProximityEvent cdecl alias "XTestFakeProximityEvent" (byval as Display ptr, byval as XDevice ptr, byval as Bool, byval as integer ptr, byval as integer, byval as uinteger) as integer
declare function XTestFakeDeviceMotionEvent cdecl alias "XTestFakeDeviceMotionEvent" (byval as Display ptr, byval as XDevice ptr, byval as Bool, byval as integer, byval as integer ptr, byval as integer, byval as uinteger) as integer
declare function XTestGrabControl cdecl alias "XTestGrabControl" (byval as Display ptr, byval as Bool) as integer
declare sub XTestSetGContextOfGC cdecl alias "XTestSetGContextOfGC" (byval as GC, byval as GContext)
declare sub XTestSetVisualIDOfVisual cdecl alias "XTestSetVisualIDOfVisual" (byval as Visual ptr, byval as VisualID)
declare function XTestDiscard cdecl alias "XTestDiscard" (byval as Display ptr) as Status

#endif
