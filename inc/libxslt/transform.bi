'' FreeBASIC binding for libxslt-1.1.28
''
'' based on the C header files:
''    Copyright (C) 2001-2002 Daniel Veillard.  All Rights Reserved.
''
''   Permission is hereby granted, free of charge, to any person obtaining a copy
''   of this software and associated documentation files (the "Software"), to deal
''   in the Software without restriction, including without limitation the rights
''   to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
''   copies of the Software, and to permit persons to whom the Software is fur-
''   nished to do so, subject to the following conditions:
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FIT-
''   NESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   DANIEL VEILLARD BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
''   IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CON-
''   NECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of Daniel Veillard shall not
''   be used in advertising or otherwise to promote the sale, use or other deal-
''   ings in this Software without prior written authorization from him.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/parser.bi"
#include once "libxml/xmlIO.bi"
#include once "xsltexports.bi"
#include once "libxslt/xsltInternals.bi"

extern "C"

#define __XML_XSLT_TRANSFORM_H__
declare sub xsltSetXIncludeDefault(byval xinclude as long)
declare function xsltGetXIncludeDefault() as long
declare function xsltNewTransformContext(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltTransformContextPtr
declare sub xsltFreeTransformContext(byval ctxt as xsltTransformContextPtr)
declare function xsltApplyStylesheetUser(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as const zstring ptr ptr, byval output as const zstring ptr, byval profile as FILE ptr, byval userCtxt as xsltTransformContextPtr) as xmlDocPtr
declare sub xsltProcessOneNode(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval params as xsltStackElemPtr)
declare sub xsltApplyStripSpaces(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr)
declare function xsltApplyStylesheet(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as const zstring ptr ptr) as xmlDocPtr
declare function xsltProfileStylesheet(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as const zstring ptr ptr, byval output as FILE ptr) as xmlDocPtr
declare function xsltRunStylesheet(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as const zstring ptr ptr, byval output as const zstring ptr, byval SAX as xmlSAXHandlerPtr, byval IObuf as xmlOutputBufferPtr) as long
declare function xsltRunStylesheetUser(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr, byval params as const zstring ptr ptr, byval output as const zstring ptr, byval SAX as xmlSAXHandlerPtr, byval IObuf as xmlOutputBufferPtr, byval profile as FILE ptr, byval userCtxt as xsltTransformContextPtr) as long
declare sub xsltApplyOneTemplate(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval list as xmlNodePtr, byval templ as xsltTemplatePtr, byval params as xsltStackElemPtr)
declare sub xsltDocumentElem(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltSort(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCopy(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltText(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltElement(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltComment(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltAttribute(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltProcessingInstruction(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCopyOf(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltValueOf(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltNumber(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltApplyImports(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltCallTemplate(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltApplyTemplates(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltChoose(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltIf(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltForEach(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval inst as xmlNodePtr, byval comp as xsltStylePreCompPtr)
declare sub xsltRegisterAllElement(byval ctxt as xsltTransformContextPtr)
declare function xsltCopyTextString(byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval string as const xmlChar ptr, byval noescape as long) as xmlNodePtr
declare sub xsltLocalVariablePop(byval ctxt as xsltTransformContextPtr, byval limitNr as long, byval level as long)
declare function xsltLocalVariablePush(byval ctxt as xsltTransformContextPtr, byval variable as xsltStackElemPtr, byval level as long) as long
declare sub xslHandleDebugger(byval cur as xmlNodePtr, byval node as xmlNodePtr, byval templ as xsltTemplatePtr, byval ctxt as xsltTransformContextPtr)

end extern
