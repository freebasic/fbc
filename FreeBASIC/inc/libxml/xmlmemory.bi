''
''
'' xmlmemory -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xmlmemory_bi__
#define __xmlmemory_bi__

#include once "libxml/xmlversion.bi"

type xmlFreeFunc as any ptr
type xmlMallocFunc as any ptr
type xmlReallocFunc as any ptr
type xmlStrdupFunc as byte ptr

declare function xmlMemSetup cdecl alias "xmlMemSetup" (byval freeFunc as xmlFreeFunc, byval mallocFunc as xmlMallocFunc, byval reallocFunc as xmlReallocFunc, byval strdupFunc as xmlStrdupFunc) as integer
declare function xmlMemGet cdecl alias "xmlMemGet" (byval freeFunc as xmlFreeFunc ptr, byval mallocFunc as xmlMallocFunc ptr, byval reallocFunc as xmlReallocFunc ptr, byval strdupFunc as xmlStrdupFunc ptr) as integer
declare function xmlGcMemSetup cdecl alias "xmlGcMemSetup" (byval freeFunc as xmlFreeFunc, byval mallocFunc as xmlMallocFunc, byval mallocAtomicFunc as xmlMallocFunc, byval reallocFunc as xmlReallocFunc, byval strdupFunc as xmlStrdupFunc) as integer
declare function xmlGcMemGet cdecl alias "xmlGcMemGet" (byval freeFunc as xmlFreeFunc ptr, byval mallocFunc as xmlMallocFunc ptr, byval mallocAtomicFunc as xmlMallocFunc ptr, byval reallocFunc as xmlReallocFunc ptr, byval strdupFunc as xmlStrdupFunc ptr) as integer
declare function xmlInitMemory cdecl alias "xmlInitMemory" () as integer
declare sub xmlCleanupMemory cdecl alias "xmlCleanupMemory" ()
declare function xmlMemUsed cdecl alias "xmlMemUsed" () as integer
declare function xmlMemBlocks cdecl alias "xmlMemBlocks" () as integer
declare sub xmlMemDisplay cdecl alias "xmlMemDisplay" (byval fp as FILE ptr)
declare sub xmlMemShow cdecl alias "xmlMemShow" (byval fp as FILE ptr, byval nr as integer)
declare sub xmlMemoryDump cdecl alias "xmlMemoryDump" ()
declare function xmlMemMalloc cdecl alias "xmlMemMalloc" (byval size as integer) as any ptr
declare function xmlMemRealloc cdecl alias "xmlMemRealloc" (byval ptr as any ptr, byval size as integer) as any ptr
declare sub xmlMemFree cdecl alias "xmlMemFree" (byval ptr as any ptr)
declare function xmlMemoryStrdup cdecl alias "xmlMemoryStrdup" (byval str as string) as byte ptr
declare function xmlMallocLoc cdecl alias "xmlMallocLoc" (byval size as integer, byval file as string, byval line as integer) as any ptr
declare function xmlReallocLoc cdecl alias "xmlReallocLoc" (byval ptr as any ptr, byval size as integer, byval file as string, byval line as integer) as any ptr
declare function xmlMallocAtomicLoc cdecl alias "xmlMallocAtomicLoc" (byval size as integer, byval file as string, byval line as integer) as any ptr
declare function xmlMemStrdupLoc cdecl alias "xmlMemStrdupLoc" (byval str as string, byval file as string, byval line as integer) as byte ptr

#include once "libxml/threads.bi"
#include once "libxml/globals.bi"

#endif
