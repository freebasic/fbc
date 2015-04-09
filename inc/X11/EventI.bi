'' FreeBASIC binding for libXt-1.1.4

#pragma once

#include once "PassivGraI.bi"

extern "C"

#define _Event_h_
declare sub _XtEventInitialize()

type _XtEventRec
	next as XtEventTable
	mask as EventMask
	proc as XtEventHandler
	closure as XtPointer
	select : 1 as ulong
	has_type_specifier : 1 as ulong
	async : 1 as ulong
end type

type XtEventRec as _XtEventRec

type _XtGrabRec
	next as XtGrabList
	widget as Widget
	exclusive : 1 as ulong
	spring_loaded : 1 as ulong
end type

type XtGrabRec as _XtGrabRec

type _BlockHookRec
	next as _BlockHookRec ptr
	app as XtAppContext
	proc as XtBlockHookProc
	closure as XtPointer
end type

type BlockHookRec as _BlockHookRec
type BlockHook as _BlockHookRec ptr
declare sub _XtFreeEventTable(byval as XtEventTable ptr)
declare function _XtOnGrabList(byval as Widget, byval as XtGrabRec ptr) as byte
declare sub _XtRemoveAllInputs(byval as XtAppContext)
declare sub _XtRefreshMapping(byval as XEvent ptr, byval as byte)
declare sub _XtSendFocusEvent(byval as Widget, byval as long)
declare function _XtConvertTypeToMask(byval as long) as EventMask
declare function _XtFindRemapWidget(byval event as XEvent ptr, byval widget as Widget, byval mask as EventMask, byval pdi as XtPerDisplayInput) as Widget
declare sub _XtUngrabBadGrabs(byval event as XEvent ptr, byval widget as Widget, byval mask as EventMask, byval pdi as XtPerDisplayInput)
declare sub _XtFillAncestorList(byval listPtr as Widget ptr ptr, byval maxElemsPtr as long ptr, byval numElemsPtr as long ptr, byval start as Widget, byval breakWidget as Widget)
extern XtAppPeekEvent_SkipTimer as byte

end extern
