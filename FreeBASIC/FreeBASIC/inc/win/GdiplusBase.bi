''
''
'' GdiplusBase -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __win_GdiplusBase_bi__
#define __win_GdiplusBase_bi__

/'
type GdiplusBase
	declare operator GdiplusBase.delete(byval in_pVoid as any ptr)
	declare operator GdiplusBase.new(byval in_size as long) as any ptr
	declare operator GdiplusBase.delete[](byval in_pVoid as any ptr)
	declare operator GdiplusBase.new[](byval in_size as long) as any ptr
end type

private operator GdiplusBase.delete(byval in_pVoid as any ptr)
    GdipFree(in_pVoid)
end operator    
    
private operator GdiplusBase.new(byval in_size as long) as any ptr
    return GdipAlloc(in_size)
end operator    
    
private operator GdiplusBase.delete[](byval in_pVoid as any ptr)
    GdipFree(in_pVoid)
end operator
    
private operator GdiplusBase.new[](byval in_size as long) as any ptr
	return GdipAlloc(in_size)
end operator
'/

#endif
