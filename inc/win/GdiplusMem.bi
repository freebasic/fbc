''
''
'' GdiplusMem -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusMem_bi__
#define __win_GdiplusMem_bi__

extern "windows"

	declare function GdipAlloc (byval size as long) as any ptr
	declare sub GdipFree (byval ptr as any ptr)
	
end extern

#endif
