'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/dict.bi"

extern "C"

#define __XML_PATTERN_H__
type xmlPattern as _xmlPattern
type xmlPatternPtr as xmlPattern ptr

type xmlPatternFlags as long
enum
	XML_PATTERN_DEFAULT = 0
	XML_PATTERN_XPATH = 1 shl 0
	XML_PATTERN_XSSEL = 1 shl 1
	XML_PATTERN_XSFIELD = 1 shl 2
end enum

declare sub xmlFreePattern(byval comp as xmlPatternPtr)
declare sub xmlFreePatternList(byval comp as xmlPatternPtr)
declare function xmlPatterncompile(byval pattern as const xmlChar ptr, byval dict as xmlDict ptr, byval flags as long, byval namespaces as const xmlChar ptr ptr) as xmlPatternPtr
declare function xmlPatternMatch(byval comp as xmlPatternPtr, byval node as xmlNodePtr) as long
type xmlStreamCtxt as _xmlStreamCtxt
type xmlStreamCtxtPtr as xmlStreamCtxt ptr
declare function xmlPatternStreamable(byval comp as xmlPatternPtr) as long
declare function xmlPatternMaxDepth(byval comp as xmlPatternPtr) as long
declare function xmlPatternMinDepth(byval comp as xmlPatternPtr) as long
declare function xmlPatternFromRoot(byval comp as xmlPatternPtr) as long
declare function xmlPatternGetStreamCtxt(byval comp as xmlPatternPtr) as xmlStreamCtxtPtr
declare sub xmlFreeStreamCtxt(byval stream as xmlStreamCtxtPtr)
declare function xmlStreamPushNode(byval stream as xmlStreamCtxtPtr, byval name as const xmlChar ptr, byval ns as const xmlChar ptr, byval nodeType as long) as long
declare function xmlStreamPush(byval stream as xmlStreamCtxtPtr, byval name as const xmlChar ptr, byval ns as const xmlChar ptr) as long
declare function xmlStreamPushAttr(byval stream as xmlStreamCtxtPtr, byval name as const xmlChar ptr, byval ns as const xmlChar ptr) as long
declare function xmlStreamPop(byval stream as xmlStreamCtxtPtr) as long
declare function xmlStreamWantsAnyNode(byval stream as xmlStreamCtxtPtr) as long

end extern
