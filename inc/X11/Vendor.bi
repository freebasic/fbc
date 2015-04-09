'' FreeBASIC binding for libXt-1.1.4

#pragma once

#include once "X11/Intrinsic.bi"

extern "C"

#define _XtVendor_h
type VendorShellWidgetClass as _VendorShellClassRec ptr
extern vendorShellWidgetClass as WidgetClass

end extern
