''
''
'' list -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_list_bi__
#define __xml_list_bi__

#include once "xmlversion.bi"

type xmlLink as _xmlLink
type xmlLinkPtr as xmlLink ptr
type xmlList as _xmlList
type xmlListPtr as xmlList ptr
type xmlListDeallocator as any ptr
type xmlListDataCompare as integer ptr
type xmlListWalker as integer ptr

extern "c"
declare function xmlListCreate (byval deallocator as xmlListDeallocator, byval compare as xmlListDataCompare) as xmlListPtr
declare sub xmlListDelete (byval l as xmlListPtr)
declare function xmlListSearch (byval l as xmlListPtr, byval data as any ptr) as any ptr
declare function xmlListReverseSearch (byval l as xmlListPtr, byval data as any ptr) as any ptr
declare function xmlListInsert (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListAppend (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListRemoveFirst (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListRemoveLast (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListRemoveAll (byval l as xmlListPtr, byval data as any ptr) as integer
declare sub xmlListClear (byval l as xmlListPtr)
declare function xmlListEmpty (byval l as xmlListPtr) as integer
declare function xmlListFront (byval l as xmlListPtr) as xmlLinkPtr
declare function xmlListEnd (byval l as xmlListPtr) as xmlLinkPtr
declare function xmlListSize (byval l as xmlListPtr) as integer
declare sub xmlListPopFront (byval l as xmlListPtr)
declare sub xmlListPopBack (byval l as xmlListPtr)
declare function xmlListPushFront (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListPushBack (byval l as xmlListPtr, byval data as any ptr) as integer
declare sub xmlListReverse (byval l as xmlListPtr)
declare sub xmlListSort (byval l as xmlListPtr)
declare sub xmlListWalk (byval l as xmlListPtr, byval walker as xmlListWalker, byval user as any ptr)
declare sub xmlListReverseWalk (byval l as xmlListPtr, byval walker as xmlListWalker, byval user as any ptr)
declare sub xmlListMerge (byval l1 as xmlListPtr, byval l2 as xmlListPtr)
declare function xmlListDup (byval old as xmlListPtr) as xmlListPtr
declare function xmlListCopy (byval cur as xmlListPtr, byval old as xmlListPtr) as integer
declare function xmlLinkGetData (byval lk as xmlLinkPtr) as any ptr
end extern

#endif
