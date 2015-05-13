''
''
'' xsltutils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_xsltutils_bi__
#define __xslt_xsltutils_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "xsltconfig.bi"
#include once "libxml/xpath.bi"
#include once "libxml/dict.bi"
#include once "libxml/xmlerror.bi"

enum xsltDebugTraceCodes
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

#define XSLT_TIMESTAMP_TICS_PER_SEC 100000l

enum xsltDebugStatusCodes
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

type xsltHandleDebuggerCallback as sub cdecl(byval as xmlNodePtr, byval as xmlNodePtr, byval as xsltTemplatePtr, byval as xsltTransformContextPtr)
type xsltAddCallCallback as function cdecl(byval as xsltTemplatePtr, byval as xmlNodePtr) as integer
type xsltDropCallCallback as sub cdecl()

extern "c"
declare function xsltGetNsProp (byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as zstring ptr
declare function xsltGetCNsProp (byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as zstring ptr
declare function xsltGetUTF8Char (byval utf as ubyte ptr, byval len as integer ptr) as integer
declare sub xsltDebugSetDefaultTrace (byval val as xsltDebugTraceCodes)
declare function xsltDebugGetDefaultTrace () as xsltDebugTraceCodes
declare sub xsltPrintErrorContext (byval ctxt as xsltTransformContextPtr, byval style as xsltStylesheetPtr, byval node as xmlNodePtr)
declare sub xsltMessage (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr)
declare sub xsltSetGenericErrorFunc (byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltSetGenericDebugFunc (byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltSetTransformErrorFunc (byval ctxt as xsltTransformContextPtr, byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltTransformError (byval ctxt as xsltTransformContextPtr, byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval msg as zstring ptr, ...)
declare function xsltSetCtxtParseOptions (byval ctxt as xsltTransformContextPtr, byval options as integer) as integer
declare sub xsltDocumentSortFunction (byval list as xmlNodeSetPtr)
declare sub xsltSetSortFunc (byval handler as xsltSortFunc)
declare sub xsltSetCtxtSortFunc (byval ctxt as xsltTransformContextPtr, byval handler as xsltSortFunc)
declare sub xsltDefaultSortFunction (byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as integer)
declare sub xsltDoSortFunction (byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as integer)
declare function xsltComputeSortResult (byval ctxt as xsltTransformContextPtr, byval sort as xmlNodePtr) as xmlXPathObjectPtr ptr
declare function xsltSplitQName (byval dict as xmlDictPtr, byval name as zstring ptr, byval prefix as zstring ptr ptr) as zstring ptr
declare function xsltGetQNameURI (byval node as xmlNodePtr, byval name as zstring ptr ptr) as zstring ptr
declare function xsltGetQNameURI2 (byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as zstring ptr ptr) as zstring ptr
declare function xsltSaveResultTo (byval buf as xmlOutputBufferPtr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltSaveResultToFilename (byval URI as zstring ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr, byval compression as integer) as integer
declare function xsltSaveResultToFile (byval file as FILE ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltSaveResultToFd (byval fd as integer, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltSaveResultToString (byval doc_txt_ptr as zstring ptr ptr, byval doc_txt_len as integer ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltXPathCompile (byval style as xsltStylesheetPtr, byval str as zstring ptr) as xmlXPathCompExprPtr
declare sub xsltSaveProfiling (byval ctxt as xsltTransformContextPtr, byval output as FILE ptr)
declare function xsltGetProfileInformation (byval ctxt as xsltTransformContextPtr) as xmlDocPtr
declare function xsltTimestamp () as integer
declare sub xsltCalibrateAdjust (byval delta as integer)
declare sub xsltSetDebuggerStatus (byval value as integer)
declare function xsltGetDebuggerStatus () as integer
declare function xsltSetDebuggerCallbacks (byval no as integer, byval block as any ptr) as integer
declare function xslAddCall (byval templ as xsltTemplatePtr, byval source as xmlNodePtr) as integer
declare sub xslDropCall ()
end extern

#endif
