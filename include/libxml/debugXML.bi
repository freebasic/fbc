''
''
'' debugXML -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_debugXML_bi__
#define __xml_debugXML_bi__

#include once "xmlversion.bi"
#include once "tree.bi"
#include once "xpath.bi"

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

extern "c"
declare sub xmlDebugDumpString (byval output as FILE ptr, byval str as zstring ptr)
declare sub xmlDebugDumpAttr (byval output as FILE ptr, byval attr as xmlAttrPtr, byval depth as integer)
declare sub xmlDebugDumpAttrList (byval output as FILE ptr, byval attr as xmlAttrPtr, byval depth as integer)
declare sub xmlDebugDumpOneNode (byval output as FILE ptr, byval node as xmlNodePtr, byval depth as integer)
declare sub xmlDebugDumpNode (byval output as FILE ptr, byval node as xmlNodePtr, byval depth as integer)
declare sub xmlDebugDumpNodeList (byval output as FILE ptr, byval node as xmlNodePtr, byval depth as integer)
declare sub xmlDebugDumpDocumentHead (byval output as FILE ptr, byval doc as xmlDocPtr)
declare sub xmlDebugDumpDocument (byval output as FILE ptr, byval doc as xmlDocPtr)
declare sub xmlDebugDumpDTD (byval output as FILE ptr, byval dtd as xmlDtdPtr)
declare sub xmlDebugDumpEntities (byval output as FILE ptr, byval doc as xmlDocPtr)
declare function xmlDebugCheckDocument (byval output as FILE ptr, byval doc as xmlDocPtr) as integer
declare sub xmlLsOneNode (byval output as FILE ptr, byval node as xmlNodePtr)
declare function xmlLsCountNode (byval node as xmlNodePtr) as integer
declare function xmlBoolToText (byval boolval as integer) as zstring ptr
declare sub xmlShellPrintXPathError (byval errorType as integer, byval arg as zstring ptr)
declare sub xmlShellPrintXPathResult (byval list as xmlXPathObjectPtr)
declare function xmlShellList (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellBase (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellDir (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellLoad (byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare sub xmlShellPrintNode (byval node as xmlNodePtr)
declare function xmlShellCat (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellWrite (byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellSave (byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellValidate (byval ctxt as xmlShellCtxtPtr, byval dtd as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellDu (byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval tree as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare function xmlShellPwd (byval ctxt as xmlShellCtxtPtr, byval buffer as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as integer
declare sub xmlShell (byval doc as xmlDocPtr, byval filename as zstring ptr, byval input as xmlShellReadlineFunc, byval output as FILE ptr)
end extern

#endif
