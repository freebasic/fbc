#pragma once

#include once "X11/Intrinsic.bi"

extern "C"

#define _XtCore_h
type CoreWidgetClass as _WidgetClassRec ptr
type CoreWidget as _WidgetRec ptr
extern coreWidgetClass as WidgetClass
extern widgetClass as WidgetClass

end extern
