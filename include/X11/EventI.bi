''
''
'' EventI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __EventI_bi__
#define __EventI_bi__

type XtGrabList as _XtGrabRec ptr

type _XtEventRec
	next as XtEventTable
	mask as EventMask
	proc as XtEventHandler
	closure as XtPointer
	select:1 as uinteger
	has_type_specifier:1 as uinteger
	async:1 as uinteger
end type

type XtEventRec as _XtEventRec

type _XtGrabRec
	next as XtGrabList
	widget as Widget
	exclusive:1 as uinteger
	spring_loaded:1 as uinteger
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

declare sub _XtFreeEventTable cdecl alias "_XtFreeEventTable" (byval as XtEventTable ptr)
declare function _XtOnGrabList cdecl alias "_XtOnGrabList" (byval as Widget, byval as XtGrabRec ptr) as Boolean
declare sub _XtRemoveAllInputs cdecl alias "_XtRemoveAllInputs" (byval as XtAppContext)
declare sub _XtRefreshMapping cdecl alias "_XtRefreshMapping" (byval as XEvent ptr, byval as _XtBoolean)
declare sub _XtSendFocusEvent cdecl alias "_XtSendFocusEvent" (byval as Widget, byval as integer)
declare function _XtConvertTypeToMask cdecl alias "_XtConvertTypeToMask" (byval as integer) as EventMask
declare function _XtFindRemapWidget cdecl alias "_XtFindRemapWidget" (byval event as XEvent ptr, byval widget as Widget, byval mask as EventMask, byval pdi as XtPerDisplayInput) as Widget
declare sub _XtUngrabBadGrabs cdecl alias "_XtUngrabBadGrabs" (byval event as XEvent ptr, byval widget as Widget, byval mask as EventMask, byval pdi as XtPerDisplayInput)
declare sub _XtFillAncestorList cdecl alias "_XtFillAncestorList" (byval listPtr as Widget ptr ptr, byval maxElemsPtr as integer ptr, byval numElemsPtr as integer ptr, byval start as Widget, byval breakWidget as Widget)
extern XtAppPeekEvent_SkipTimer alias "XtAppPeekEvent_SkipTimer" as Boolean

#endif
