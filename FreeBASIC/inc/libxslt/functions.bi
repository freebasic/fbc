''
''
'' functions -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_functions_bi__
#define __xslt_functions_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xpathInternals.bi"

extern "c"
declare function xsltXPathFunctionLookup (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathFunction
declare sub xsltDocumentFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltKeyFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltUnparsedEntityURIFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltFormatNumberFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltGenerateIdFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltSystemPropertyFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltElementAvailableFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltFunctionAvailableFunction (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltRegisterAllFunctions (byval ctxt as xmlXPathContextPtr)
end extern

#endif
