''
''
'' xpointer -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xpointer_bi__
#define __xpointer_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xpath.bi"

type xmlLocationSet as _xmlLocationSet
type xmlLocationSetPtr as xmlLocationSet ptr

type _xmlLocationSet
	locNr as integer
	locMax as integer
	locTab as xmlXPathObjectPtr ptr
end type

declare function xmlXPtrLocationSetCreate cdecl alias "xmlXPtrLocationSetCreate" (byval val as xmlXPathObjectPtr) as xmlLocationSetPtr
declare sub xmlXPtrFreeLocationSet cdecl alias "xmlXPtrFreeLocationSet" (byval obj as xmlLocationSetPtr)
declare function xmlXPtrLocationSetMerge cdecl alias "xmlXPtrLocationSetMerge" (byval val1 as xmlLocationSetPtr, byval val2 as xmlLocationSetPtr) as xmlLocationSetPtr
declare function xmlXPtrNewRange cdecl alias "xmlXPtrNewRange" (byval start as xmlNodePtr, byval startindex as integer, byval end as xmlNodePtr, byval endindex as integer) as xmlXPathObjectPtr
declare function xmlXPtrNewRangePoints cdecl alias "xmlXPtrNewRangePoints" (byval start as xmlXPathObjectPtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodePoint cdecl alias "xmlXPtrNewRangeNodePoint" (byval start as xmlNodePtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangePointNode cdecl alias "xmlXPtrNewRangePointNode" (byval start as xmlXPathObjectPtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodes cdecl alias "xmlXPtrNewRangeNodes" (byval start as xmlNodePtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewLocationSetNodes cdecl alias "xmlXPtrNewLocationSetNodes" (byval start as xmlNodePtr, byval end as xmlNodePtr) as xmlXPathObjectPtr
declare function xmlXPtrNewLocationSetNodeSet cdecl alias "xmlXPtrNewLocationSetNodeSet" (byval set as xmlNodeSetPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewRangeNodeObject cdecl alias "xmlXPtrNewRangeNodeObject" (byval start as xmlNodePtr, byval end as xmlXPathObjectPtr) as xmlXPathObjectPtr
declare function xmlXPtrNewCollapsedRange cdecl alias "xmlXPtrNewCollapsedRange" (byval start as xmlNodePtr) as xmlXPathObjectPtr
declare sub xmlXPtrLocationSetAdd cdecl alias "xmlXPtrLocationSetAdd" (byval cur as xmlLocationSetPtr, byval val as xmlXPathObjectPtr)
declare function xmlXPtrWrapLocationSet cdecl alias "xmlXPtrWrapLocationSet" (byval val as xmlLocationSetPtr) as xmlXPathObjectPtr
declare sub xmlXPtrLocationSetDel cdecl alias "xmlXPtrLocationSetDel" (byval cur as xmlLocationSetPtr, byval val as xmlXPathObjectPtr)
declare sub xmlXPtrLocationSetRemove cdecl alias "xmlXPtrLocationSetRemove" (byval cur as xmlLocationSetPtr, byval val as integer)
declare function xmlXPtrNewContext cdecl alias "xmlXPtrNewContext" (byval doc as xmlDocPtr, byval here as xmlNodePtr, byval origin as xmlNodePtr) as xmlXPathContextPtr
declare function xmlXPtrEval cdecl alias "xmlXPtrEval" (byval str as string, byval ctx as xmlXPathContextPtr) as xmlXPathObjectPtr
declare sub xmlXPtrRangeToFunction cdecl alias "xmlXPtrRangeToFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare function xmlXPtrBuildNodeList cdecl alias "xmlXPtrBuildNodeList" (byval obj as xmlXPathObjectPtr) as xmlNodePtr
declare sub xmlXPtrEvalRangePredicate cdecl alias "xmlXPtrEvalRangePredicate" (byval ctxt as xmlXPathParserContextPtr)

#endif
