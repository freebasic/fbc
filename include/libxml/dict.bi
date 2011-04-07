''
''
'' dict -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_dict_bi__
#define __xml_dict_bi__

#include once "xmlversion.bi"
#include once "tree.bi"

#ifndef xmlDict
type xmlDict as any
type xmlDictPtr as xmlDict ptr
#endif

extern "c"
declare function xmlDictCreate () as xmlDictPtr
declare function xmlDictCreateSub (byval sub as xmlDictPtr) as xmlDictPtr
declare function xmlDictReference (byval dict as xmlDictPtr) as integer
declare sub xmlDictFree (byval dict as xmlDictPtr)
declare function xmlDictLookup (byval dict as xmlDictPtr, byval name as zstring ptr, byval len as integer) as zstring ptr
declare function xmlDictExists (byval dict as xmlDictPtr, byval name as zstring ptr, byval len as integer) as zstring ptr
declare function xmlDictQLookup (byval dict as xmlDictPtr, byval prefix as zstring ptr, byval name as zstring ptr) as zstring ptr
declare function xmlDictOwns (byval dict as xmlDictPtr, byval str as zstring ptr) as integer
declare function xmlDictSize (byval dict as xmlDictPtr) as integer
declare sub xmlDictCleanup ()
end extern

#endif
