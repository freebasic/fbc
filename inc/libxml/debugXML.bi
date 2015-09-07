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

#include once "crt/stdio.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xpath.bi"

extern "C"

#define __DEBUG_XML__
declare sub xmlDebugDumpString(byval output as FILE ptr, byval str as const xmlChar ptr)
declare sub xmlDebugDumpAttr(byval output as FILE ptr, byval attr as xmlAttrPtr, byval depth as long)
declare sub xmlDebugDumpAttrList(byval output as FILE ptr, byval attr as xmlAttrPtr, byval depth as long)
declare sub xmlDebugDumpOneNode(byval output as FILE ptr, byval node as xmlNodePtr, byval depth as long)
declare sub xmlDebugDumpNode(byval output as FILE ptr, byval node as xmlNodePtr, byval depth as long)
declare sub xmlDebugDumpNodeList(byval output as FILE ptr, byval node as xmlNodePtr, byval depth as long)
declare sub xmlDebugDumpDocumentHead(byval output as FILE ptr, byval doc as xmlDocPtr)
declare sub xmlDebugDumpDocument(byval output as FILE ptr, byval doc as xmlDocPtr)
declare sub xmlDebugDumpDTD(byval output as FILE ptr, byval dtd as xmlDtdPtr)
declare sub xmlDebugDumpEntities(byval output as FILE ptr, byval doc as xmlDocPtr)
declare function xmlDebugCheckDocument(byval output as FILE ptr, byval doc as xmlDocPtr) as long
declare sub xmlLsOneNode(byval output as FILE ptr, byval node as xmlNodePtr)
declare function xmlLsCountNode(byval node as xmlNodePtr) as long
declare function xmlBoolToText(byval boolval as long) as const zstring ptr

type xmlShellReadlineFunc as function(byval prompt as zstring ptr) as zstring ptr
type xmlShellCtxt as _xmlShellCtxt
type xmlShellCtxtPtr as xmlShellCtxt ptr

type _xmlShellCtxt
	filename as zstring ptr
	doc as xmlDocPtr
	node as xmlNodePtr
	pctxt as xmlXPathContextPtr
	loaded as long
	output as FILE ptr
	input as xmlShellReadlineFunc
end type

type xmlShellCmd as function(byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare sub xmlShellPrintXPathError(byval errorType as long, byval arg as const zstring ptr)
declare sub xmlShellPrintXPathResult(byval list as xmlXPathObjectPtr)
declare function xmlShellList(byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellBase(byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellDir(byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellLoad(byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare sub xmlShellPrintNode(byval node as xmlNodePtr)
declare function xmlShellCat(byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellWrite(byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellSave(byval ctxt as xmlShellCtxtPtr, byval filename as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellValidate(byval ctxt as xmlShellCtxtPtr, byval dtd as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellDu(byval ctxt as xmlShellCtxtPtr, byval arg as zstring ptr, byval tree as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare function xmlShellPwd(byval ctxt as xmlShellCtxtPtr, byval buffer as zstring ptr, byval node as xmlNodePtr, byval node2 as xmlNodePtr) as long
declare sub xmlShell(byval doc as xmlDocPtr, byval filename as zstring ptr, byval input as xmlShellReadlineFunc, byval output as FILE ptr)

end extern
