''
''
'' transform -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __transform_bi__
#define __transform_bi__

#include once "libxslt/xsltexports.bi"
#include once "libxslt/xsltInternals.bi"
#include once "libxml/parser.bi"
#include once "libxml/xmlIO.bi"

declare sub xsltSetXIncludeDefault cdecl alias "xsltSetXIncludeDefault" (byval xinclude as integer)
declare function xsltGetXIncludeDefault cdecl alias "xsltGetXIncludeDefault" () as integer
declare function xsltNewTransformContext cdecl alias "xsltNewTransformContext" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltTransformContextPtr
declare sub xsltFreeTransformContext cdecl alias "xsltFreeTransformContext" (byval ctxt as xsltTransformContextPtr)
declare function xsltApplyStylesheetUser cdecl alias "xsltApplyStylesheetUser" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as zstring ptr, byval profile as FILE ptr, byval userCtxt as xsltTransformContextPtr) as xmlDocPtr
declare sub xsltApplyStripSpaces cdecl alias "xsltApplyStripSpaces" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr)
declare function xsltApplyStylesheet cdecl alias "xsltApplyStylesheet" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr) as xmlDocPtr
declare function xsltProfileStylesheet cdecl alias "xsltProfileStylesheet" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as FILE ptr) as xmlDocPtr
declare function xsltRunStylesheet cdecl alias "xsltRunStylesheet" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as zstring ptr, byval SAX as xmlSAXHandlerPtr, byval IObuf as xmlOutputBufferPtr) as integer
declare function xsltRunStylesheetUser cdecl alias "xsltRunStylesheetUser" (byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as zstring ptr ptr, byval output as zstring ptr, byval SAX as xmlSAXHandlerPtr, byval IObuf as xmlOutputBufferPtr, byval profile as FILE ptr, byval userCtxt as xsltTransformContextPtr) as integer
declare sub xsltApplyOneTemplate cdecl alias "xsltApplyOneTemplate" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval list as xmlNodePtr, byval templ as xsltTemplatePtr, byval params as xsltStackElemPtr)
declare sub xsltDocumentElem cdecl alias "xsltDocumentElem" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltSort cdecl alias "xsltSort" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCopy cdecl alias "xsltCopy" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltText cdecl alias "xsltText" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltElement cdecl alias "xsltElement" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltComment cdecl alias "xsltComment" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltAttribute cdecl alias "xsltAttribute" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltProcessingInstruction cdecl alias "xsltProcessingInstruction" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCopyOf cdecl alias "xsltCopyOf" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltValueOf cdecl alias "xsltValueOf" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltNumber cdecl alias "xsltNumber" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltApplyImports cdecl alias "xsltApplyImports" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCallTemplate cdecl alias "xsltCallTemplate" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltApplyTemplates cdecl alias "xsltApplyTemplates" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltChoose cdecl alias "xsltChoose" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltIf cdecl alias "xsltIf" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltForEach cdecl alias "xsltForEach" (byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltRegisterAllElement cdecl alias "xsltRegisterAllElement" (byval ctxt as xsltTransformContextPtr)
declare function xsltCopyTextString cdecl alias "xsltCopyTextString" (byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval string as zstring ptr, byval noescape as integer) as xmlNodePtr
declare sub xslHandleDebugger cdecl alias "xslHandleDebugger" (byval cur as xmlNodePtr, byval node as xmlNodePtr, byval templ as xsltTemplatePtr, byval ctxt as xsltTransformContextPtr)

#endif
