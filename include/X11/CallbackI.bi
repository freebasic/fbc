''
''
'' CallbackI -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __CallbackI_bi__
#define __CallbackI_bi__

type CallbackTable as XrmResource ptr ptr

#define _XtCBCalling 1
#define _XtCBFreeAfterCalling 2

type _XtConditionProc as function cdecl(byval as XtPointer) as Boolean

declare sub _XtAddCallback cdecl alias "_XtAddCallback" (byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub _XtAddCallbackOnce cdecl alias "_XtAddCallbackOnce" (byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare function _XtCompileCallbackList cdecl alias "_XtCompileCallbackList" (byval as XtCallbackList) as InternalCallbackList
declare function _XtGetCallbackList cdecl alias "_XtGetCallbackList" (byval as InternalCallbackList ptr) as XtCallbackList
declare sub _XtRemoveAllCallbacks cdecl alias "_XtRemoveAllCallbacks" (byval as InternalCallbackList ptr)
declare sub _XtRemoveCallback cdecl alias "_XtRemoveCallback" (byval as InternalCallbackList ptr, byval as XtCallbackProc, byval as XtPointer)
declare sub _XtPeekCallback cdecl alias "_XtPeekCallback" (byval as Widget, byval as XtCallbackList, byval as XtCallbackProc ptr, byval as XtPointer ptr)
declare sub _XtCallConditionalCallbackList cdecl alias "_XtCallConditionalCallbackList" (byval as Widget, byval as XtCallbackList, byval as XtPointer, byval as _XtConditionProc)

#endif
