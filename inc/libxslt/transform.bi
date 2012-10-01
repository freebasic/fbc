''
''
'' transform -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xslt_transform_bi__
#define __xslt_transform_bi__

#include once "xsltexports.bi"
#include once "xsltInternals.bi"
#include once "libxml/parser.bi"
#include once "libxml/xmlIO.bi"

extern "c"
declare sub xsltSetXIncludeDefault (byval xinclude as integer)
declare function xsltGetXIncludeDefault () as integer
declare function xsltNewTransformContext (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltTransformContextPtr
declare sub xsltFreeTransformContext (byval ctxt as xsltTransformContextPtr)
declare function xsltApplyStylesheetUser (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as zstring ptr, byval profile as FILE ptr, byval userCtxt as xsltTransformContextPtr) as xmlDocPtr
declare sub xsltApplyStripSpaces (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr)
declare function xsltApplyStylesheet (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr) as xmlDocPtr
declare function xsltProfileStylesheet (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as FILE ptr) as xmlDocPtr
declare function xsltRunStylesheet (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as zstring ptr, byval SAX as xmlSAXHandlerPtr, byval IObuf as xmlOutputBufferPtr) as integer
declare function xsltRunStylesheetUser (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as zstring ptr, byval SAX as xmlSAXHandlerPtr, byval IObuf as xmlOutputBufferPtr, byval profile as FILE ptr, byval userCtxt as xsltTransformContextPtr) as integer
declare sub xsltApplyOneTemplate (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval list as xmlNodePtr, byval templ as xsltTemplatePtr, byval params as xsltStackElemPtr)
declare sub xsltDocumentElem (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltSort (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCopy (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltText (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltElement (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltComment (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltAttribute (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltProcessingInstruction (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCopyOf (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltValueOf (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltNumber (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltApplyImports (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCallTemplate (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltApplyTemplates (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltChoose (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltIf (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltForEach (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltRegisterAllElement (byval ctxt as xsltTransformContextPtr)
declare function xsltCopyTextString (byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval string as zstring ptr, byval noescape as integer) as xmlNodePtr
declare sub xslHandleDebugger (byval cur as xmlNodePtr, byval node as xmlNodePtr, byval templ as xsltTemplatePtr, byval ctxt as xsltTransformContextPtr)
end extern

#endif
