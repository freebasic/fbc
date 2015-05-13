''
''
'' PassivGraI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __PassivGraI_bi__
#define __PassivGraI_bi__

type _XtServerGrabRec
	next as _XtServerGrabRec ptr
	widget as Widget
	ownerEvents:1 as uinteger
	pointerMode:1 as uinteger
	keyboardMode:1 as uinteger
	hasExt:1 as uinteger
	confineToIsWidgetWin:1 as uinteger
	keybut as KeyCode
	modifiers as ushort
	eventMask as ushort
end type

type XtServerGrabRec as _XtServerGrabRec
type XtServerGrabPtr as _XtServerGrabRec ptr

type _XtGrabExtRec
	pKeyButMask as Mask ptr
	pModifiersMask as Mask ptr
	confineTo as Window
	cursor as Cursor
end type

type XtServerGrabExtRec as _XtGrabExtRec
type XtServerGrabExtPtr as _XtGrabExtRec ptr

type _XtDeviceRec
	grab as XtServerGrabRec
	grabType as XtServerGrabType
end type

type XtDeviceRec as _XtDeviceRec
type XtDevice as _XtDeviceRec ptr

#define XtMyAncestor 0
#define XtMyDescendant 1
#define XtMyCousin 2
#define XtMySelf 3
#define XtUnrelated 4

type XtGeneology as byte

type XtPerWidgetInputRec
	focusKid as Widget
	keyList as XtServerGrabPtr
	ptrList as XtServerGrabPtr
	queryEventDescendant as Widget
	map_handler_added:1 as uinteger
	realize_handler_added:1 as uinteger
	active_handler_added:1 as uinteger
	haveFocus:1 as uinteger
	focalPoint as XtGeneology
end type

type XtPerWidgetInput as XtPerWidgetInputRec ptr

type XtPerDisplayInputRec
	grabList as XtGrabList
	keyboard as XtDeviceRec
	pointer as XtDeviceRec
	activatingKey as KeyCode
	trace as Widget ptr
	traceDepth as integer
	traceMax as integer
	focusWidget as Widget
end type

type XtPerDisplayInputRec as any
type XtPerDisplayInput as XtPerDisplayInputRec ptr

declare sub _XtDestroyServerGrabs cdecl alias "_XtDestroyServerGrabs" (byval as Widget, byval as XtPointer, byval as XtPointer)
declare function _XtGetPerWidgetInput cdecl alias "_XtGetPerWidgetInput" (byval as Widget, byval as _XtBoolean) as XtPerWidgetInput
declare function _XtCheckServerGrabsOnWidget cdecl alias "_XtCheckServerGrabsOnWidget" (byval as XEvent ptr, byval as Widget, byval as _XtBoolean) as XtServerGrabPtr
declare sub _XtFreePerWidgetInput cdecl alias "_XtFreePerWidgetInput" (byval as Widget, byval as XtPerWidgetInput)
declare function _XtProcessKeyboardEvent cdecl alias "_XtProcessKeyboardEvent" (byval as XKeyEvent ptr, byval as Widget, byval as XtPerDisplayInput) as Widget
declare function _XtProcessPointerEvent cdecl alias "_XtProcessPointerEvent" (byval as XButtonEvent ptr, byval as Widget, byval as XtPerDisplayInput) as Widget
declare sub _XtRegisterPassiveGrabs cdecl alias "_XtRegisterPassiveGrabs" (byval as Widget)
declare sub _XtClearAncestorCache cdecl alias "_XtClearAncestorCache" (byval as Widget)

#endif
