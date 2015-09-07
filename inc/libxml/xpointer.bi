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
#include once "libxml/xpath.bi"

extern "C"

#define __XML_XPTR_H__
type xmlLocationSet as _xmlLocationSet
type xmlLocationSetPtr as xmlLocationSet ptr

type _xmlLocationSet
	locNr as long
	locMax as long
	locTab as xmlXPathObjectPtr ptr
end type

declare function xmlXPtrLocationSetCreate(byval val as xmlXPathObjectPtr) as xmlLocationSetPtr
declare sub xmlXPtrFreeLocationSet(byval obj as xmlLocationSetPtr)
declare function xmlXPtrLocationSetMerge(byval val1 as xmlLocationSetPtr, byval val2 as xmlLocationSetPtr) as xmlLocationSetPtr
declare function xmlXPtrNewRange(byval start as xmlNodePtr, byval startindex as long, byval end as xmlNodePtr, byval endindex as long) as xmlXPathObjectPtr
declare function xmlXPtrNewRangePoints(byval start as xmlXPathObjectPtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodePoint(byval start as xmlNodePtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangePointNode(byval start as xmlXPathObjectPtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodes(byval start as xmlNodePtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewLocationSetNodes(byval start as xmlNodePtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewLocationSetNodeSet(byval set as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodeObject(byval start as xmlNodePtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewCollapsedRange(byval start as xmlNodePtr) as xmlXPathObjectPtr
declare sub xmlXPtrLocationSetAdd(byval cur as xmlLocationSetPtr, byval val as xmlXPathObjectPtr)
declare function xmlXPtrWrapLocationSet(byval val as xmlLocationSetPtr) as xmlXPathObjectPtr
declare sub xmlXPtrLocationSetDel(byval cur as xmlLocationSetPtr, byval val as xmlXPathObjectPtr)
declare sub xmlXPtrLocationSetRemove(byval cur as xmlLocationSetPtr, byval val as long)
declare function xmlXPtrNewContext(byval doc as xmlDocPtr, byval here as xmlNodePtr, byval origin as xmlNodePtr) as xmlXPathContextPtr
declare function xmlXPtrEval(byval str as const xmlChar ptr, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare sub xmlXPtrRangeToFunction(byval ctxt as xmlXPathParserContextPtr, byval nargs as long)
declare function xmlXPtrBuildNodeList(byval obj as xmlXPathObjectPtr) as xmlNodePtr
declare sub xmlXPtrEvalRangePredicate(byval ctxt as xmlXPathParserContextPtr)

end extern
