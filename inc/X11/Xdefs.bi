''
''
'' Xdefs -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xdefs_bi__
#define __Xdefs_bi__

type Atom as uinteger
type Bool as integer
type pointer as any ptr
type ClientPtr as _Client ptr
type XID as uinteger
type Mask as uinteger
type FontPtr as _Font ptr
type Font as XID
type FSID as uinteger
type AccContext as FSID
type OSTimePtr as timeval ptr ptr
type BlockHandlerProcPtr as sub cdecl(byval as pointer, byval as OSTimePtr, byval as pointer)

#endif
