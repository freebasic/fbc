''
''
'' functions -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __functions_bi__
#define __functions_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xpathInternals.bi"

declare function xsltXPathFunctionLookup cdecl alias "xsltXPathFunctionLookup" (byval ctxt as xmlXPathContextPtr, byval name as zstring ptr, byval ns_uri as zstring ptr) as xmlXPathFunction
declare sub xsltDocumentFunction cdecl alias "xsltDocumentFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltKeyFunction cdecl alias "xsltKeyFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltUnparsedEntityURIFunction cdecl alias "xsltUnparsedEntityURIFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltFormatNumberFunction cdecl alias "xsltFormatNumberFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltGenerateIdFunction cdecl alias "xsltGenerateIdFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltSystemPropertyFunction cdecl alias "xsltSystemPropertyFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltElementAvailableFunction cdecl alias "xsltElementAvailableFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltFunctionAvailableFunction cdecl alias "xsltFunctionAvailableFunction" (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltRegisterAllFunctions cdecl alias "xsltRegisterAllFunctions" (byval ctxt as xmlXPathContextPtr)

#endif
