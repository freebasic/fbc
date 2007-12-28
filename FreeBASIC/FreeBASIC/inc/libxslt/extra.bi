''
''
'' extra -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_extra_bi__
#define __xslt_extra_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/xpath.bi"

extern "c"
declare sub xsltFunctionNodeSet (byval ctxt as xmlXPathParserContextPtr, byval nargs as integer)
declare sub xsltDebug (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltRegisterExtras (byval ctxt as xsltTransformContextPtr)
declare sub xsltRegisterAllExtras ()
end extern

#endif
