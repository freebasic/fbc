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

#include once "libxml/xpath.bi"
#include once "libxml/xpathInternals.bi"
#include once "xsltexports.bi"
#include once "xsltInternals.bi"

extern "C"

#define __XML_XSLT_TEMPLATES_H__
declare function xsltEvalXPathPredicate(byval ctxt as xsltTransformContextPtr, byval comp as xmlXPathCompExprPtr, byval nsList as xmlNsPtr ptr, byval nsNr as long) as long
declare function xsltEvalTemplateString(byval ctxt as xsltTransformContextPtr, byval contextNode as xmlNodePtr, byval inst as xmlNodePtr) as xmlChar ptr
declare function xsltEvalAttrValueTemplate(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval name as const xmlChar ptr, byval ns as const xmlChar ptr) as xmlChar ptr
declare function xsltEvalStaticAttrValueTemplate(byval style as xsltStylesheetPtr, byval node as xmlNodePtr, byval name as const xmlChar ptr, byval ns as const xmlChar ptr, byval found as long ptr) as const xmlChar ptr
declare function xsltEvalXPathString(byval ctxt as xsltTransformContextPtr, byval comp as xmlXPathCompExprPtr) as xmlChar ptr
declare function xsltEvalXPathStringNs(byval ctxt as xsltTransformContextPtr, byval comp as xmlXPathCompExprPtr, byval nsNr as long, byval nsList as xmlNsPtr ptr) as xmlChar ptr
declare function xsltTemplateProcess(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr) as xmlNodePtr ptr
declare function xsltAttrListTemplateProcess(byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xsltAttrTemplateProcess(byval ctxt as xsltTransformContextPtr, byval target as xmlNodePtr, byval attr as xmlAttrPtr) as xmlAttrPtr
declare function xsltAttrTemplateValueProcess(byval ctxt as xsltTransformContextPtr, byval attr as const xmlChar ptr) as xmlChar ptr
declare function xsltAttrTemplateValueProcessNode(byval ctxt as xsltTransformContextPtr, byval str as const xmlChar ptr, byval node as xmlNodePtr) as xmlChar ptr

end extern
