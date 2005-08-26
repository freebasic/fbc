''
''
'' variables -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __variables_bi__
#define __variables_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxslt/functions.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xpathInternals.bi"

declare function xsltEvalGlobalVariables cdecl alias "xsltEvalGlobalVariables" (byval ctxt as xsltTransformContextPtr) as integer
declare function xsltEvalUserParams cdecl alias "xsltEvalUserParams" (byval ctxt as xsltTransformContextPtr, byval params as byte ptr ptr) as integer
declare function xsltQuoteUserParams cdecl alias "xsltQuoteUserParams" (byval ctxt as xsltTransformContextPtr, byval params as byte ptr ptr) as integer
declare function xsltEvalOneUserParam cdecl alias "xsltEvalOneUserParam" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval value as zstring ptr) as integer
declare function xsltQuoteOneUserParam cdecl alias "xsltQuoteOneUserParam" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval value as zstring ptr) as integer
declare sub xsltParseGlobalVariable cdecl alias "xsltParseGlobalVariable" (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltParseGlobalParam cdecl alias "xsltParseGlobalParam" (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltParseStylesheetVariable cdecl alias "xsltParseStylesheetVariable" (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr)
declare sub xsltParseStylesheetParam cdecl alias "xsltParseStylesheetParam" (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr)
declare function xsltParseStylesheetCallerParam cdecl alias "xsltParseStylesheetCallerParam" (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr) as xsltStackElemPtr
declare function xsltAddStackElemList cdecl alias "xsltAddStackElemList" (byval ctxt as xsltTransformContextPtr, byval elems as xsltStackElemPtr) as integer
declare sub xsltFreeGlobalVariables cdecl alias "xsltFreeGlobalVariables" (byval ctxt as xsltTransformContextPtr)
declare function xsltVariableLookup cdecl alias "xsltVariableLookup" (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathObjectPtr
declare function xsltXPathVariableLookup cdecl alias "xsltXPathVariableLookup" (byval ctxt as any ptr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathObjectPtr

#endif
