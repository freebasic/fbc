''
''
'' VendorP -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __VendorP_bi__
#define __VendorP_bi__

type _VendorShellClassRec
	core_class as CoreClassPart
	composite_class as CompositeClassPart
	shell_class as ShellClassPart
	wm_shell_class as WMShellClassPart
	vendor_shell_class as VendorShellClassPart
end type

type VendorShellClassRec as _VendorShellClassRec

type VendorShellPart
	vendor_specific as integer
end type

type VendorShellRec
	core as CorePart
	composite as CompositePart
	shell as ShellPart
	wm as WMShellPart
	vendor as VendorShellPart
end type

type VendorShellWidget as VendorShellRec ptr

#endif
