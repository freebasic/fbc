''
''
'' Composite -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Composite_bi__
#define __Composite_bi__

type CompositeWidgetClass as _CompositeClassRec ptr
type XtOrderProc as function cdecl(byval as Widget) as Cardinal

declare sub XtManageChild cdecl alias "XtManageChild" (byval as Widget)
declare sub XtUnmanageChildren cdecl alias "XtUnmanageChildren" (byval as WidgetList, byval as Cardinal)
declare sub XtUnmanageChild cdecl alias "XtUnmanageChild" (byval as Widget)

type XtDoChangeProc as sub cdecl(byval as Widget, byval as WidgetList, byval as Cardinal ptr, byval as WidgetList, byval as Cardinal ptr, byval as XtPointer)

declare sub XtChangeManagedSet cdecl alias "XtChangeManagedSet" (byval as WidgetList, byval as Cardinal, byval as XtDoChangeProc, byval as XtPointer, byval as WidgetList, byval as Cardinal)

#endif
