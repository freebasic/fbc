''
''
'' list -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_list_bi__
#define __xml_list_bi__

#include once "libxml/xmlversion.bi"

type xmlLink as _xmlLink
type xmlLinkPtr as xmlLink ptr
type xmlList as _xmlList
type xmlListPtr as xmlList ptr
type xmlListDeallocator as any ptr
type xmlListDataCompare as integer ptr
type xmlListWalker as integer ptr

declare function xmlListCreate cdecl alias "xmlListCreate" (byval deallocator as xmlListDeallocator, byval compare as xmlListDataCompare) as xmlListPtr
declare sub xmlListDelete cdecl alias "xmlListDelete" (byval l as xmlListPtr)
declare function xmlListSearch cdecl alias "xmlListSearch" (byval l as xmlListPtr, byval data as any ptr) as any ptr
declare function xmlListReverseSearch cdecl alias "xmlListReverseSearch" (byval l as xmlListPtr, byval data as any ptr) as any ptr
declare function xmlListInsert cdecl alias "xmlListInsert" (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListAppend cdecl alias "xmlListAppend" (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListRemoveFirst cdecl alias "xmlListRemoveFirst" (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListRemoveLast cdecl alias "xmlListRemoveLast" (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListRemoveAll cdecl alias "xmlListRemoveAll" (byval l as xmlListPtr, byval data as any ptr) as integer
declare sub xmlListClear cdecl alias "xmlListClear" (byval l as xmlListPtr)
declare function xmlListEmpty cdecl alias "xmlListEmpty" (byval l as xmlListPtr) as integer
declare function xmlListFront cdecl alias "xmlListFront" (byval l as xmlListPtr) as xmlLinkPtr
declare function xmlListEnd cdecl alias "xmlListEnd" (byval l as xmlListPtr) as xmlLinkPtr
declare function xmlListSize cdecl alias "xmlListSize" (byval l as xmlListPtr) as integer
declare sub xmlListPopFront cdecl alias "xmlListPopFront" (byval l as xmlListPtr)
declare sub xmlListPopBack cdecl alias "xmlListPopBack" (byval l as xmlListPtr)
declare function xmlListPushFront cdecl alias "xmlListPushFront" (byval l as xmlListPtr, byval data as any ptr) as integer
declare function xmlListPushBack cdecl alias "xmlListPushBack" (byval l as xmlListPtr, byval data as any ptr) as integer
declare sub xmlListReverse cdecl alias "xmlListReverse" (byval l as xmlListPtr)
declare sub xmlListSort cdecl alias "xmlListSort" (byval l as xmlListPtr)
declare sub xmlListWalk cdecl alias "xmlListWalk" (byval l as xmlListPtr, byval walker as xmlListWalker, byval user as any ptr)
declare sub xmlListReverseWalk cdecl alias "xmlListReverseWalk" (byval l as xmlListPtr, byval walker as xmlListWalker, byval user as any ptr)
declare sub xmlListMerge cdecl alias "xmlListMerge" (byval l1 as xmlListPtr, byval l2 as xmlListPtr)
declare function xmlListDup cdecl alias "xmlListDup" (byval old as xmlListPtr) as xmlListPtr
declare function xmlListCopy cdecl alias "xmlListCopy" (byval cur as xmlListPtr, byval old as xmlListPtr) as integer
declare function xmlLinkGetData cdecl alias "xmlLinkGetData" (byval lk as xmlLinkPtr) as any ptr

#endif
