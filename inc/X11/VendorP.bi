'' FreeBASIC binding for libXt-1.1.4

#pragma once

#include once "X11/Vendor.bi"

extern "C"

#define _XtVendorPrivate_h

type VendorShellClassPart
	extension as XtPointer
end type

type _VendorShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
	vendor_shell_class as VendorShellClassPart
end type

type VendorShellClassRec as _VendorShellClassRec
extern vendorShellClassRec as VendorShellClassRec

type VendorShellPart
	vendor_specific as long
end type

type VendorShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
	vendor as VendorShellPart
end type

type VendorShellWidget as VendorShellRec ptr

end extern
