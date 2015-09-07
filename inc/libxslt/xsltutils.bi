'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Daniel Veillard.  All Rights Reserved.
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
''   DANIEL VEILLARD BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Daniel Veillard shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "libxslt/xsltconfig.bi"
#include once "crt/stdarg.bi"
#include once "libxml/xpath.bi"
#include once "libxml/dict.bi"
#include once "libxml/xmlerror.bi"
#include once "xsltexports.bi"
#include once "xsltInternals.bi"

extern "C"

#define __XML_XSLTUTILS_H__
#define XSLT_TODO xsltGenericError(xsltGenericErrorContext, !"Unimplemented block at %s:%d\n", __FILE__, __LINE__)
#define XSLT_STRANGE xsltGenericError(xsltGenericErrorContext, !"Internal error at %s:%d\n", __FILE__, __LINE__)
#define IS_XSLT_ELEM(n) (((((n) <> NULL) andalso ((n)->type = XML_ELEMENT_NODE)) andalso ((n)->ns <> NULL)) andalso xmlStrEqual((n)->ns->href, XSLT_NAMESPACE))
#define IS_XSLT_NAME(n, val) xmlStrEqual((n)->name, cptr(const xmlChar ptr, (val)))
#define IS_XSLT_REAL_NODE(n) (((n) <> NULL) andalso (((((((((n)->type = XML_ELEMENT_NODE) orelse ((n)->type = XML_TEXT_NODE)) orelse ((n)->type = XML_CDATA_SECTION_NODE)) orelse ((n)->type = XML_ATTRIBUTE_NODE)) orelse ((n)->type = XML_DOCUMENT_NODE)) orelse ((n)->type = XML_HTML_DOCUMENT_NODE)) orelse ((n)->type = XML_COMMENT_NODE)) orelse ((n)->type = XML_PI_NODE)))

declare function xsltGetNsProp(byval node as xmlNodePtr, byval name as const xmlChar ptr, byval nameSpace as const xmlChar ptr) as xmlChar ptr
declare function xsltGetCNsProp(byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as const xmlChar ptr, byval nameSpace as const xmlChar ptr) as const xmlChar ptr
declare function xsltGetUTF8Char(byval utf as const ubyte ptr, byval len as long ptr) as long

type xsltDebugTraceCodes as long
enum
	XSLT_TRACE_ALL = -1
	XSLT_TRACE_NONE = 0
	XSLT_TRACE_COPY_TEXT = 1 shl 0
	XSLT_TRACE_PROCESS_NODE = 1 shl 1
	XSLT_TRACE_APPLY_TEMPLATE = 1 shl 2
	XSLT_TRACE_COPY = 1 shl 3
	XSLT_TRACE_COMMENT = 1 shl 4
	XSLT_TRACE_PI = 1 shl 5
	XSLT_TRACE_COPY_OF = 1 shl 6
	XSLT_TRACE_VALUE_OF = 1 shl 7
	XSLT_TRACE_CALL_TEMPLATE = 1 shl 8
	XSLT_TRACE_APPLY_TEMPLATES = 1 shl 9
	XSLT_TRACE_CHOOSE = 1 shl 10
	XSLT_TRACE_IF = 1 shl 11
	XSLT_TRACE_FOR_EACH = 1 shl 12
	XSLT_TRACE_STRIP_SPACES = 1 shl 13
	XSLT_TRACE_TEMPLATES = 1 shl 14
	XSLT_TRACE_KEYS = 1 shl 15
	XSLT_TRACE_VARIABLES = 1 shl 16
end enum

#macro XSLT_TRACE(ctxt, code, call)
	if ctxt->traceCode andalso ((*ctxt->traceCode) and code) then
		call
	end if
#endmacro
declare sub xsltDebugSetDefaultTrace(byval val as xsltDebugTraceCodes)
declare function xsltDebugGetDefaultTrace() as xsltDebugTraceCodes
extern xsltGenericError as xmlGenericErrorFunc
extern xsltGenericErrorContext as any ptr
extern xsltGenericDebug as xmlGenericErrorFunc
extern xsltGenericDebugContext as any ptr

declare sub xsltPrintErrorContext(byval ctxt as xsltTransformContextPtr, byval style as xsltStylesheetPtr, byval node as xmlNodePtr)
declare sub xsltMessage(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr)
declare sub xsltSetGenericErrorFunc(byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltSetGenericDebugFunc(byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltSetTransformErrorFunc(byval ctxt as xsltTransformContextPtr, byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltTransformError(byval ctxt as xsltTransformContextPtr, byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval msg as const zstring ptr, ...)
declare function xsltSetCtxtParseOptions(byval ctxt as xsltTransformContextPtr, byval options as long) as long
declare sub xsltDocumentSortFunction(byval list as xmlNodeSetPtr)
declare sub xsltSetSortFunc(byval handler as xsltSortFunc)
declare sub xsltSetCtxtSortFunc(byval ctxt as xsltTransformContextPtr, byval handler as xsltSortFunc)
declare sub xsltDefaultSortFunction(byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as long)
declare sub xsltDoSortFunction(byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as long)
declare function xsltComputeSortResult(byval ctxt as xsltTransformContextPtr, byval sort as xmlNodePtr) as xmlXPathObjectPtr ptr
declare function xsltSplitQName(byval dict as xmlDictPtr, byval name as const xmlChar ptr, byval prefix as const xmlChar ptr ptr) as const xmlChar ptr
declare function xsltGetQNameURI(byval node as xmlNodePtr, byval name as xmlChar ptr ptr) as const xmlChar ptr
declare function xsltGetQNameURI2(byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as const xmlChar ptr ptr) as const xmlChar ptr
declare function xsltSaveResultTo(byval buf as xmlOutputBufferPtr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as long
declare function xsltSaveResultToFilename(byval URI as const zstring ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr, byval compression as long) as long
declare function xsltSaveResultToFile(byval file as FILE ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as long
declare function xsltSaveResultToFd(byval fd as long, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as long
declare function xsltSaveResultToString(byval doc_txt_ptr as xmlChar ptr ptr, byval doc_txt_len as long ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as long
declare function xsltXPathCompile(byval style as xsltStylesheetPtr, byval str as const xmlChar ptr) as xmlXPathCompExprPtr
declare function xsltXPathCompileFlags(byval style as xsltStylesheetPtr, byval str as const xmlChar ptr, byval flags as long) as xmlXPathCompExprPtr
declare sub xsltSaveProfiling(byval ctxt as xsltTransformContextPtr, byval output as FILE ptr)
declare function xsltGetProfileInformation(byval ctxt as xsltTransformContextPtr) as xmlDocPtr
declare function xsltTimestamp() as clong
declare sub xsltCalibrateAdjust(byval delta as clong)
const XSLT_TIMESTAMP_TICS_PER_SEC = cast(clong, 100000)

type xsltDebugStatusCodes as long
enum
	XSLT_DEBUG_NONE = 0
	XSLT_DEBUG_INIT
	XSLT_DEBUG_STEP
	XSLT_DEBUG_STEPOUT
	XSLT_DEBUG_NEXT
	XSLT_DEBUG_STOP
	XSLT_DEBUG_CONT
	XSLT_DEBUG_RUN
	XSLT_DEBUG_RUN_RESTART
	XSLT_DEBUG_QUIT
end enum

extern xslDebugStatus as long
type xsltHandleDebuggerCallback as sub(byval cur as xmlNodePtr, byval node as xmlNodePtr, byval templ as xsltTemplatePtr, byval ctxt as xsltTransformContextPtr)
type xsltAddCallCallback as function(byval templ as xsltTemplatePtr, byval source as xmlNodePtr) as long
type xsltDropCallCallback as sub()

declare sub xsltSetDebuggerStatus(byval value as long)
declare function xsltGetDebuggerStatus() as long
declare function xsltSetDebuggerCallbacks(byval no as long, byval block as any ptr) as long
declare function xslAddCall(byval templ as xsltTemplatePtr, byval source as xmlNodePtr) as long
declare sub xslDropCall()

end extern
