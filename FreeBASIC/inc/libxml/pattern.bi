''
''
'' pattern -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_pattern_bi__
#define __xml_pattern_bi__

#include once "xmlversion.bi"
#include once "tree.bi"
#include once "dict.bi"

type xmlPattern as _xmlPattern
type xmlPatternPtr as xmlPattern ptr

extern "c"
declare sub xmlFreePattern (byval comp as xmlPatternPtr)
declare sub xmlFreePatternList (byval comp as xmlPatternPtr)
declare function xmlPatterncompile (byval pattern as zstring ptr, byval dict as xmlDict ptr, byval flags as integer, byval namespaces as zstring ptr ptr) as xmlPatternPtr
declare function xmlPatternMatch (byval comp as xmlPatternPtr, byval node as xmlNodePtr) as integer
end extern

#endif
