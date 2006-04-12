''
''
'' memory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __ode_memory_bi__
#define __ode_memory_bi__

#include once "ode/config.bi"

type dAllocFunction as any
type dReallocFunction as any
type dFreeFunction as any

declare sub dSetAllocHandler cdecl alias "dSetAllocHandler" (byval fn as dAllocFunction ptr)
declare sub dSetReallocHandler cdecl alias "dSetReallocHandler" (byval fn as dReallocFunction ptr)
declare sub dSetFreeHandler cdecl alias "dSetFreeHandler" (byval fn as dFreeFunction ptr)
declare function dGetAllocHandler cdecl alias "dGetAllocHandler" () as dAllocFunction ptr
declare function dGetReallocHandler cdecl alias "dGetReallocHandler" () as dReallocFunction ptr
declare function dGetFreeHandler cdecl alias "dGetFreeHandler" () as dFreeFunction ptr
declare function dAlloc cdecl alias "dAlloc" (byval size as integer) as any ptr
declare function dRealloc cdecl alias "dRealloc" (byval ptr as any ptr, byval oldsize as integer, byval newsize as integer) as any ptr
declare sub dFree cdecl alias "dFree" (byval ptr as any ptr, byval size as integer)

#endif
