''
''
'' dict -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __dict_bi__
#define __dict_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"

#ifndef xmlDict
type xmlDict as any
type xmlDictPtr as xmlDict ptr
#endif

declare function xmlDictCreate cdecl alias "xmlDictCreate" () as xmlDictPtr
declare function xmlDictCreateSub cdecl alias "xmlDictCreateSub" (byval sub as xmlDictPtr) as xmlDictPtr
declare function xmlDictReference cdecl alias "xmlDictReference" (byval dict as xmlDictPtr) as integer
declare sub xmlDictFree cdecl alias "xmlDictFree" (byval dict as xmlDictPtr)
declare function xmlDictLookup cdecl alias "xmlDictLookup" (byval dict as xmlDictPtr, byval name as string, byval len as integer) as zstring ptr
declare function xmlDictExists cdecl alias "xmlDictExists" (byval dict as xmlDictPtr, byval name as string, byval len as integer) as zstring ptr
declare function xmlDictQLookup cdecl alias "xmlDictQLookup" (byval dict as xmlDictPtr, byval prefix as string, byval name as string) as zstring ptr
declare function xmlDictOwns cdecl alias "xmlDictOwns" (byval dict as xmlDictPtr, byval str as string) as integer
declare function xmlDictSize cdecl alias "xmlDictSize" (byval dict as xmlDictPtr) as integer
declare sub xmlDictCleanup cdecl alias "xmlDictCleanup" ()

#endif
