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

#include once "crt/limits.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"

extern "C"

#define __XML_DICT_H__
type xmlDict as _xmlDict
type xmlDictPtr as xmlDict ptr
declare function xmlInitializeDict() as long
declare function xmlDictCreate() as xmlDictPtr
declare function xmlDictSetLimit(byval dict as xmlDictPtr, byval limit as uinteger) as uinteger
declare function xmlDictGetUsage(byval dict as xmlDictPtr) as uinteger
declare function xmlDictCreateSub(byval sub as xmlDictPtr) as xmlDictPtr
declare function xmlDictReference(byval dict as xmlDictPtr) as long
declare sub xmlDictFree(byval dict as xmlDictPtr)
declare function xmlDictLookup(byval dict as xmlDictPtr, byval name as const xmlChar ptr, byval len as long) as const xmlChar ptr
declare function xmlDictExists(byval dict as xmlDictPtr, byval name as const xmlChar ptr, byval len as long) as const xmlChar ptr
declare function xmlDictQLookup(byval dict as xmlDictPtr, byval prefix as const xmlChar ptr, byval name as const xmlChar ptr) as const xmlChar ptr
declare function xmlDictOwns(byval dict as xmlDictPtr, byval str as const xmlChar ptr) as long
declare function xmlDictSize(byval dict as xmlDictPtr) as long
declare sub xmlDictCleanup()

end extern
