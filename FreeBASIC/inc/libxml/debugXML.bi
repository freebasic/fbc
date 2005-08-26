''
''
'' debugXML -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __debugXML_bi__
#define __debugXML_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xpath.bi"

declare sub xmlDebugDumpString cdecl alias "xmlDebugDumpString" (byval output as FILE ptr, byval str as zstring ptr)
declare sub xmlDebugDumpAttr cdecl alias "xmlDebugDumpAttr" (byval output as FILE ptr, byval attr as xmlAttrPtr, byval depth as integer)
declare sub xmlDebugDumpAttrList cdecl alias "xmlDebugDumpAttrList" (byval output as FILE ptr, byval attr as xmlAttrPtr, byval depth as integer)
declare sub xmlDebugDumpOneNode cdecl alias "xmlDebugDumpOneNode" (byval output as FILE ptr, byval node as xmlNodePtr, byval depth as integer)
declare sub xmlDebugDumpNode cdecl alias "xmlDebugDumpNode" (byval output as FILE ptr, byval node as xmlNodePtr, byval depth as integer)
declare sub xmlDebugDumpNodeList cdecl alias "xmlDebugDumpNodeList" (byval output as FILE ptr, byval node as xmlNodePtr, byval depth as integer)
declare sub xmlDebugDumpDocumentHead cdecl alias "xmlDebugDumpDocumentHead" (byval output as FILE ptr, byval doc as xmlDocPtr)
declare sub xmlDebugDumpDocument cdecl alias "xmlDebugDumpDocument" (byval output as FILE ptr, byval doc as xmlDocPtr)
declare sub xmlDebugDumpDTD cdecl alias "xmlDebugDumpDTD" (byval output as FILE ptr, byval dtd as xmlDtdPtr)
declare sub xmlDebugDumpEntities cdecl alias "xmlDebugDumpEntities" (byval output as FILE ptr, byval doc as xmlDocPtr)
declare function xmlDebugCheckDocument cdecl alias "xmlDebugCheckDocument" (byval output as FILE ptr, byval doc as xmlDocPtr) as integer
declare sub xmlLsOneNode cdecl alias "xmlLsOneNode" (byval output as FILE ptr, byval node as xmlNodePtr)
declare function xmlLsCountNode cdecl alias "xmlLsCountNode" (byval node as xmlNodePtr) as integer
declare function xmlBoolToText cdecl alias "xmlBoolToText" (byval boolval as integer) as zstring ptr

type xmlShellReadlineFunc as byte ptr
type xmlShellCtxt as _xmlShellCtxt
type xmlShellCtxtPtr as xmlShellCtxt ptr

type _xmlShellCtxt
	filename as byte ptr
	doc as xmlDocPtr
	node as xmlNodePtr
	pctxt as xmlXPathContextPtr
	loaded as integer
	output as FILE ptr
	input as xmlShellReadlineFunc
end type

type xmlShellCmd as integer ptr

declare sub xmlShellPrintXPathError cdecl alias "xmlShellPrintXPathError" (byval errorType as integer, byval arg as zstring ptr)
declare sub xmlShellPrintXPathResult cdecl alias "xmlShellPrintXPathResult" (byval list as xmlXPathObjectPtr)
declare function xmlShellList cdecl alias "xmlShellList" (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellBase cdecl alias "xmlShellBase" (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellDir cdecl alias "xmlShellDir" (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellLoad cdecl alias "xmlShellLoad" (byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare sub xmlShellPrintNode cdecl alias "xmlShellPrintNode" (byval node as xmlNodePtr)
declare function xmlShellCat cdecl alias "xmlShellCat" (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellWrite cdecl alias "xmlShellWrite" (byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellSave cdecl alias "xmlShellSave" (byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellValidate cdecl alias "xmlShellValidate" (byval ctxt as xmlShellCtxtPtr, byval dtd as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellDu cdecl alias "xmlShellDu" (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval tree as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellPwd cdecl alias "xmlShellPwd" (byval ctxt as xmlShellCtxtPtr, byval buffer as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare sub xmlShell cdecl alias "xmlShell" (byval doc as xmlDocPtr, byval filename as zstring ptr, byval input as xmlShellReadlineFunc, byval output as FILE ptr)

#endif
