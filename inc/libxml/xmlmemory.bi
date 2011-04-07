''
''
'' xmlmemory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlmemory_bi__
#define __xml_xmlmemory_bi__

#include once "xmlversion.bi"

type xmlFreeFunc as any ptr
type xmlMallocFunc as any ptr
type xmlReallocFunc as any ptr
type xmlStrdupFunc as byte ptr

extern "c"
declare function xmlMemSetup (byval freeFunc as xmlFreeFunc, byval mallocFunc as xmlMallocFunc, byval reallocFunc as xmlReallocFunc, byval strdupFunc as xmlStrdupFunc) as integer
declare function xmlMemGet (byval freeFunc as xmlFreeFunc ptr, byval mallocFunc as xmlMallocFunc ptr, byval reallocFunc as xmlReallocFunc ptr, byval strdupFunc as xmlStrdupFunc ptr) as integer
declare function xmlGcMemSetup (byval freeFunc as xmlFreeFunc, byval mallocFunc as xmlMallocFunc, byval mallocAtomicFunc as xmlMallocFunc, byval reallocFunc as xmlReallocFunc, byval strdupFunc as xmlStrdupFunc) as integer
declare function xmlGcMemGet (byval freeFunc as xmlFreeFunc ptr, byval mallocFunc as xmlMallocFunc ptr, byval mallocAtomicFunc as xmlMallocFunc ptr, byval reallocFunc as xmlReallocFunc ptr, byval strdupFunc as xmlStrdupFunc ptr) as integer
declare function xmlInitMemory () as integer
declare sub xmlCleanupMemory ()
declare function xmlMemUsed () as integer
declare function xmlMemBlocks () as integer
declare sub xmlMemDisplay (byval fp as FILE ptr)
declare sub xmlMemShow (byval fp as FILE ptr, byval nr as integer)
declare sub xmlMemoryDump ()
declare function xmlMemMalloc (byval size as integer) as any ptr
declare function xmlMemRealloc (byval ptr as any ptr, byval size as integer) as any ptr
declare sub xmlMemFree (byval ptr as any ptr)
declare function xmlMemoryStrdup (byval str as zstring ptr) as byte ptr
declare function xmlMallocLoc (byval size as integer, byval file as zstring ptr, byval line as integer) as any ptr
declare function xmlReallocLoc (byval ptr as any ptr, byval size as integer, byval file as zstring ptr, byval line as integer) as any ptr
declare function xmlMallocAtomicLoc (byval size as integer, byval file as zstring ptr, byval line as integer) as any ptr
declare function xmlMemStrdupLoc (byval str as zstring ptr, byval file as zstring ptr, byval line as integer) as byte ptr
end extern

#include once "threads.bi"
#include once "globals.bi"

#endif
