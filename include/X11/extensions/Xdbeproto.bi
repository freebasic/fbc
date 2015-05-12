''
''
'' Xdbeproto -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xdbeproto_bi__
#define __Xdbeproto_bi__

#define XdbeUndefined 0
#define XdbeBackground 1
#define XdbeUntouched 2
#define XdbeCopied 3

type XdbeVisualInfo
	visual as VisualID
	depth as integer
	perflevel as integer
end type

type XdbeScreenVisualInfo
	count as integer
	visinfo as XdbeVisualInfo ptr
end type

#endif
