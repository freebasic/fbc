''
''
'' xpointer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xpointer_bi__
#define __xml_xpointer_bi__

#include once "xmlversion.bi"
#include once "tree.bi"
#include once "xpath.bi"

type xmlLocationSet as _xmlLocationSet
type xmlLocationSetPtr as xmlLocationSet ptr

type _xmlLocationSet
	locNr as integer
	locMax as integer
	locTab as xmlXPathObjectPtr ptr
end type

extern "c"
declare function xmlXPtrLocationSetCreate (byval val as xmlXPathObjectPtr) as xmlLocationSetPtr
declare sub xmlXPtrFreeLocationSet (byval obj as xmlLocationSetPtr)
declare function xmlXPtrLocationSetMerge (byval val1 as xmlLocationSetPtr, byval val2 as xmlLocationSetPtr) as xmlLocationSetPtr
declare function xmlXPtrNewRange (byval start as xmlNodePtr, byval startindex as integer, byval end as xmlNodePtr, byval endindex as integer) as xmlXPathObjectPtr
declare function xmlXPtrNewRangePoints (byval start as xmlXPathObjectPtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodePoint (byval start as xmlNodePtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangePointNode (byval start as xmlXPathObjectPtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodes (byval start as xmlNodePtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewLocationSetNodes (byval start as xmlNodePtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewLocationSetNodeSet (byval set as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodeObject (byval start as xmlNodePtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewCollapsedRange (byval start as xmlNodePtr) as xmlXPathObjectPtr
declare sub xmlXPtrLocationSetAdd (byval cur as xmlLocationSetPtr, byval val as xmlXPathObjectPtr)
declare function xmlXPtrWrapLocationSet (byval val as xmlLocationSetPtr) as xmlXPathObjectPtr
declare sub xmlXPtrLocationSetDel (byval cur as xmlLocationSetPtr, byval val as xmlXPathObjectPtr)
declare sub xmlXPtrLocationSetRemove (byval cur as xmlLocationSetPtr, byval val as integer)
declare function xmlXPtrNewContext (byval doc as xmlDocPtr, byval here as xmlNodePtr, byval origin as xmlNodePtr) as xmlXPathContextPtr
declare function xmlXPtrEval (byval str as zstring ptr, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare sub xmlXPtrRangeToFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare function xmlXPtrBuildNodeList (byval obj as xmlXPathObjectPtr) as xmlNodePtr
declare sub xmlXPtrEvalRangePredicate (byval ctxt as xmlXPathParserContextPtr)
end extern

#endif
