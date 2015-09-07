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

extern "C"

#define __XML_LINK_INCLUDE__
type xmlLink as _xmlLink
type xmlLinkPtr as xmlLink ptr
type xmlList as _xmlList
type xmlListPtr as xmlList ptr
type xmlListDeallocator as sub(byval lk as xmlLinkPtr)
type xmlListDataCompare as function(byval data0 as const any ptr, byval data1 as const any ptr) as long
type xmlListWalker as function(byval data as const any ptr, byval user as const any ptr) as long

declare function xmlListCreate(byval deallocator as xmlListDeallocator, byval compare as xmlListDataCompare) as xmlListPtr
declare sub xmlListDelete(byval l as xmlListPtr)
declare function xmlListSearch(byval l as xmlListPtr, byval data as any ptr) as any ptr
declare function xmlListReverseSearch(byval l as xmlListPtr, byval data as any ptr) as any ptr
declare function xmlListInsert(byval l as xmlListPtr, byval data as any ptr) as long
declare function xmlListAppend(byval l as xmlListPtr, byval data as any ptr) as long
declare function xmlListRemoveFirst(byval l as xmlListPtr, byval data as any ptr) as long
declare function xmlListRemoveLast(byval l as xmlListPtr, byval data as any ptr) as long
declare function xmlListRemoveAll(byval l as xmlListPtr, byval data as any ptr) as long
declare sub xmlListClear(byval l as xmlListPtr)
declare function xmlListEmpty(byval l as xmlListPtr) as long
declare function xmlListFront(byval l as xmlListPtr) as xmlLinkPtr
declare function xmlListEnd(byval l as xmlListPtr) as xmlLinkPtr
declare function xmlListSize(byval l as xmlListPtr) as long
declare sub xmlListPopFront(byval l as xmlListPtr)
declare sub xmlListPopBack(byval l as xmlListPtr)
declare function xmlListPushFront(byval l as xmlListPtr, byval data as any ptr) as long
declare function xmlListPushBack(byval l as xmlListPtr, byval data as any ptr) as long
declare sub xmlListReverse(byval l as xmlListPtr)
declare sub xmlListSort(byval l as xmlListPtr)
declare sub xmlListWalk(byval l as xmlListPtr, byval walker as xmlListWalker, byval user as const any ptr)
declare sub xmlListReverseWalk(byval l as xmlListPtr, byval walker as xmlListWalker, byval user as const any ptr)
declare sub xmlListMerge(byval l1 as xmlListPtr, byval l2 as xmlListPtr)
declare function xmlListDup(byval old as const xmlListPtr) as xmlListPtr
declare function xmlListCopy(byval cur as xmlListPtr, byval old as const xmlListPtr) as long
declare function xmlLinkGetData(byval lk as xmlLinkPtr) as any ptr

end extern
