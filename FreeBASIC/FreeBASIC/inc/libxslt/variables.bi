''
''
'' variables -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_variables_bi__
#define __xslt_variables_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "functions.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xpathInternals.bi"

extern "c"
declare function xsltEvalGlobalVariables (byval ctxt as xsltTransformContextPtr) as integer
declare function xsltEvalUserParams (byval ctxt as xsltTransformContextPtr, byval params as byte ptr ptr) as integer
declare function xsltQuoteUserParams (byval ctxt as xsltTransformContextPtr, byval params as byte ptr ptr) as integer
declare function xsltEvalOneUserParam (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval value as zstring ptr) as integer
declare function xsltQuoteOneUserParam (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval value as zstring ptr) as integer
declare sub xsltParseGlobalVariable (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltParseGlobalParam (byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltParseStylesheetVariable (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr)
declare sub xsltParseStylesheetParam (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr)
declare function xsltParseStylesheetCallerParam (byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr) as xsltStackElemPtr
declare function xsltAddStackElemList (byval ctxt as xsltTransformContextPtr, byval elems as xsltStackElemPtr) as integer
declare sub xsltFreeGlobalVariables (byval ctxt as xsltTransformContextPtr)
declare function xsltVariableLookup (byval ctxt as xsltTransformContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathObjectPtr
declare function xsltXPathVariableLookup (byval ctxt as any ptr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathObjectPtr
end extern

#endif
