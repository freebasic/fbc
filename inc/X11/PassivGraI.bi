#pragma once

extern "C"

#define _PDI_h_

type XtGrabList as _XtGrabRec ptr

type XtServerGrabType as long
enum
	XtNoServerGrab
	XtPassiveServerGrab
	XtActiveServerGrab
	XtPseudoPassiveServerGrab
	XtPseudoActiveServerGrab
end enum

type _XtServerGrabRec
	next as _XtServerGrabRec ptr
	widget as Widget
	ownerEvents : 1 as ulong
	pointerMode : 1 as ulong
	keyboardMode : 1 as ulong
	hasExt : 1 as ulong
	confineToIsWidgetWin : 1 as ulong
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
#define GRABEXT(p) cast(XtServerGrabExtPtr, (p) + 1)

type _XtDeviceRec
	grab as XtServerGrabRec
	grabType as XtServerGrabType
end type

type XtDeviceRec as _XtDeviceRec
type XtDevice as _XtDeviceRec ptr
const XtMyAncestor = 0
const XtMyDescendant = 1
const XtMyCousin = 2
const XtMySelf = 3
const XtUnrelated = 4
type XtGeneology as zstring

type XtPerWidgetInputRec
	focusKid as Widget
	keyList as XtServerGrabPtr
	ptrList as XtServerGrabPtr
	queryEventDescendant as Widget
	map_handler_added : 1 as ulong
	realize_handler_added : 1 as ulong
	active_handler_added : 1 as ulong
	haveFocus : 1 as ulong
	focalPoint as byte
end type

type XtPerWidgetInput as XtPerWidgetInputRec ptr

type XtPerDisplayInputRec
	grabList as XtGrabList
	keyboard as XtDeviceRec
	pointer as XtDeviceRec
	activatingKey as KeyCode
	trace as Widget ptr
	traceDepth as long
	traceMax as long
	focusWidget as Widget
end type

type XtPerDisplayInput as XtPerDisplayInputRec ptr
#define IsServerGrab(g) ((g = XtPassiveServerGrab) orelse (g = XtActiveServerGrab))
#define IsAnyGrab(g) (((g = XtPassiveServerGrab) orelse (g = XtActiveServerGrab)) orelse (g = XtPseudoPassiveServerGrab))
#define IsEitherPassiveGrab(g) ((g = XtPassiveServerGrab) orelse (g = XtPseudoPassiveServerGrab))
#define IsPseudoGrab(g) (g = XtPseudoPassiveServerGrab)

declare sub _XtDestroyServerGrabs(byval as Widget, byval as XtPointer, byval as XtPointer)
declare function _XtGetPerWidgetInput(byval as Widget, byval as byte) as XtPerWidgetInput
declare function _XtCheckServerGrabsOnWidget(byval as XEvent ptr, byval as Widget, byval as byte) as XtServerGrabPtr
#define _XtGetGrabList(pdi) (@(pdi)->grabList)
declare sub _XtFreePerWidgetInput(byval as Widget, byval as XtPerWidgetInput)
declare function _XtProcessKeyboardEvent(byval as XKeyEvent ptr, byval as Widget, byval as XtPerDisplayInput) as Widget
declare function _XtProcessPointerEvent(byval as XButtonEvent ptr, byval as Widget, byval as XtPerDisplayInput) as Widget
declare sub _XtRegisterPassiveGrabs(byval as Widget)
declare sub _XtClearAncestorCache(byval as Widget)

end extern
