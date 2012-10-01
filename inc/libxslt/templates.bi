''
''
'' templates -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_templates_bi__
#define __xslt_templates_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/xpath.bi"
#include once "libxml/xpathInternals.bi"

extern "c"
declare function xsltEvalXPathPredicate (byval ctxt as xsltTransformContextPtr, byval comp as xmlXPathCompExprPtr, byval nsList as xmlNsPtr ptr, byval nsNr as integer) as integer
declare function xsltEvalTemplateString (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval parent as xmlNodePtr) as zstring ptr
declare function xsltEvalAttrValueTemplate (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval name as zstring ptr, byval ns as zstring ptr) as zstring ptr
declare function xsltEvalStaticAttrValueTemplate (byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as zstring ptr, byval ns as zstring ptr, byval found as integer ptr) as zstring ptr
declare function xsltEvalXPathString (byval ctxt as xsltTransformContextPtr, byval comp as xmlXPathCompExprPtr) as zstring ptr
declare function xsltEvalXPathStringNs (byval ctxt as xsltTransformContextPtr, byval comp as xmlXPathCompExprPtr, byval nsNr as integer, byval nsList as xmlNsPtr ptr) as zstring ptr
declare function xsltTemplateProcess (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr) as xmlNodePtr ptr
declare function xsltAttrListTemplateProcess (byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xsltAttrTemplateProcess (byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval attr as xmlAttrPtr) as xmlAttrPtr
declare function xsltAttrTemplateValueProcess (byval ctxt as xsltTransformContextPtr, byval attr as zstring ptr) as zstring ptr
declare function xsltAttrTemplateValueProcessNode (byval ctxt as xsltTransformContextPtr, byval str as zstring ptr, byval node as xmlNodePtr) as zstring ptr
end extern

#endif
