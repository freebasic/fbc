''
''
'' pattern -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __pattern_bi__
#define __pattern_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/dict.bi"

type xmlPattern as _xmlPattern
type xmlPatternPtr as xmlPattern ptr

declare sub xmlFreePattern cdecl alias "xmlFreePattern" (byval comp as xmlPatternPtr)
declare sub xmlFreePatternList cdecl alias "xmlFreePatternList" (byval comp as xmlPatternPtr)
declare function xmlPatterncompile cdecl alias "xmlPatterncompile" (byval pattern as zstring ptr, byval dict as xmlDict ptr, byval flags as integer, byval namespaces as zstring ptr ptr) as xmlPatternPtr
declare function xmlPatternMatch cdecl alias "xmlPatternMatch" (byval comp as xmlPatternPtr, byval node as xmlNodePtr) as integer

#endif
