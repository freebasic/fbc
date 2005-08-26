''
''
'' xsltutils -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xsltutils_bi__
#define __xsltutils_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxslt/xsltconfig.bi"
#include once "libxml/xpath.bi"
#include once "libxml/dict.bi"
#include once "libxml/xmlerror.bi"

declare function xsltGetNsProp cdecl alias "xsltGetNsProp" (byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as zstring ptr
declare function xsltGetCNsProp cdecl alias "xsltGetCNsProp" (byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as zstring ptr
declare function xsltGetUTF8Char cdecl alias "xsltGetUTF8Char" (byval utf as ubyte ptr, byval len as integer ptr) as integer

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


declare sub xsltDebugSetDefaultTrace cdecl alias "xsltDebugSetDefaultTrace" (byval val as xsltDebugTraceCodes)
declare function xsltDebugGetDefaultTrace cdecl alias "xsltDebugGetDefaultTrace" () as xsltDebugTraceCodes
declare sub xsltPrintErrorContext cdecl alias "xsltPrintErrorContext" (byval ctxt as xsltTransformContextPtr, byval style as xsltStylesheetPtr, byval node as xmlNodePtr)
declare sub xsltMessage cdecl alias "xsltMessage" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr)
declare sub xsltSetGenericErrorFunc cdecl alias "xsltSetGenericErrorFunc" (byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltSetGenericDebugFunc cdecl alias "xsltSetGenericDebugFunc" (byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltSetTransformErrorFunc cdecl alias "xsltSetTransformErrorFunc" (byval ctxt as xsltTransformContextPtr, byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xsltTransformError cdecl alias "xsltTransformError" (byval ctxt as xsltTransformContextPtr, byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval msg as zstring ptr, ...)
declare function xsltSetCtxtParseOptions cdecl alias "xsltSetCtxtParseOptions" (byval ctxt as xsltTransformContextPtr, byval options as integer) as integer
declare sub xsltDocumentSortFunction cdecl alias "xsltDocumentSortFunction" (byval list as xmlNodeSetPtr)
declare sub xsltSetSortFunc cdecl alias "xsltSetSortFunc" (byval handler as xsltSortFunc)
declare sub xsltSetCtxtSortFunc cdecl alias "xsltSetCtxtSortFunc" (byval ctxt as xsltTransformContextPtr, byval handler as xsltSortFunc)
declare sub xsltDefaultSortFunction cdecl alias "xsltDefaultSortFunction" (byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as integer)
declare sub xsltDoSortFunction cdecl alias "xsltDoSortFunction" (byval ctxt as xsltTransformContextPtr, byval sorts as xmlNodePtr ptr, byval nbsorts as integer)
declare function xsltComputeSortResult cdecl alias "xsltComputeSortResult" (byval ctxt as xsltTransformContextPtr, byval sort as xmlNodePtr) as xmlXPathObjectPtr ptr
declare function xsltSplitQName cdecl alias "xsltSplitQName" (byval dict as xmlDictPtr, byval name as zstring ptr, byval prefix as zstring ptr ptr) as zstring ptr
declare function xsltGetQNameURI cdecl alias "xsltGetQNameURI" (byval node as xmlNodePtr, byval name as zstring ptr ptr) as zstring ptr
declare function xsltGetQNameURI2 cdecl alias "xsltGetQNameURI2" (byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as zstring ptr ptr) as zstring ptr
declare function xsltSaveResultTo cdecl alias "xsltSaveResultTo" (byval buf as xmlOutputBufferPtr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltSaveResultToFilename cdecl alias "xsltSaveResultToFilename" (byval URI as zstring ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr, byval compression as integer) as integer
declare function xsltSaveResultToFile cdecl alias "xsltSaveResultToFile" (byval file as FILE ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltSaveResultToFd cdecl alias "xsltSaveResultToFd" (byval fd as integer, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltSaveResultToString cdecl alias "xsltSaveResultToString" (byval doc_txt_ptr as zstring ptr ptr, byval doc_txt_len as integer ptr, byval result as xmlDocPtr, byval style as xsltStylesheetPtr) as integer
declare function xsltXPathCompile cdecl alias "xsltXPathCompile" (byval style as xsltStylesheetPtr, byval str as zstring ptr) as xmlXPathCompExprPtr
declare sub xsltSaveProfiling cdecl alias "xsltSaveProfiling" (byval ctxt as xsltTransformContextPtr, byval output as FILE ptr)
declare function xsltGetProfileInformation cdecl alias "xsltGetProfileInformation" (byval ctxt as xsltTransformContextPtr) as xmlDocPtr
declare function xsltTimestamp cdecl alias "xsltTimestamp" () as integer
declare sub xsltCalibrateAdjust cdecl alias "xsltCalibrateAdjust" (byval delta as integer)

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

declare sub xsltSetDebuggerStatus cdecl alias "xsltSetDebuggerStatus" (byval value as integer)
declare function xsltGetDebuggerStatus cdecl alias "xsltGetDebuggerStatus" () as integer
declare function xsltSetDebuggerCallbacks cdecl alias "xsltSetDebuggerCallbacks" (byval no as integer, byval block as any ptr) as integer
declare function xslAddCall cdecl alias "xslAddCall" (byval templ as xsltTemplatePtr, byval source as xmlNodePtr) as integer
declare sub xslDropCall cdecl alias "xslDropCall" ()

#endif
