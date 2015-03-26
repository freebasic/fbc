#pragma once

#include once "X11/Intrinsic.bi"

extern "C"

#define _XtComposite_h
type CompositeWidgetClass as _CompositeClassRec ptr
type XtOrderProc as function(byval as Widget) as Cardinal
declare sub XtManageChildren(byval as WidgetList, byval as Cardinal)
declare sub XtManageChild(byval as Widget)
declare sub XtUnmanageChildren(byval as WidgetList, byval as Cardinal)
declare sub XtUnmanageChild(byval as Widget)
type XtDoChangeProc as sub(byval as Widget, byval as WidgetList, byval as Cardinal ptr, byval as WidgetList, byval as Cardinal ptr, byval as XtPointer)
declare sub XtChangeManagedSet(byval as WidgetList, byval as Cardinal, byval as XtDoChangeProc, byval as XtPointer, byval as WidgetList, byval as Cardinal)
extern compositeWidgetClass as WidgetClass

end extern
