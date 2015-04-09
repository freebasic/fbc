'' FreeBASIC binding for libXt-1.1.4

#pragma once

extern "C"

type CallbackTable as XrmResource ptr ptr
const _XtCBCalling = 1
const _XtCBFreeAfterCalling = 2

type InternalCallbackRec
	count as ushort
	is_padded as byte
	call_state as byte

	#ifdef __FB_64BIT__
		align_pad as ulong
	#endif
end type

type InternalCallbackList as InternalCallbackRec ptr
type _XtConditionProc as function(byval as XtPointer) as byte
declare sub _XtAddCallback(byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub _XtAddCallbackOnce(byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare function _XtCompileCallbackList(byval as XtCallbackList) as InternalCallbackList
declare function _XtGetCallbackList(byval as InternalCallbackList ptr) as XtCallbackList
declare sub _XtRemoveAllCallbacks(byval as InternalCallbackList ptr)
declare sub _XtRemoveCallback(byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub _XtPeekCallback(byval as Widget, byval as XtCallbackList, byval as XtCallbackProc ptr, byval as XtPointer ptr)
declare sub _XtCallConditionalCallbackList(byval as Widget, byval as XtCallbackList, byval as XtPointer, byval as _XtConditionProc)

end extern
