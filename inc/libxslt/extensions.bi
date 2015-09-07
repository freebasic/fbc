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
#include once "xsltexports.bi"
#include once "xsltInternals.bi"

extern "C"

#define __XML_XSLT_EXTENSION_H__
declare sub xsltInitGlobals()
type xsltStyleExtInitFunction as function(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr) as any ptr
type xsltStyleExtShutdownFunction as sub(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr, byval data as any ptr)
type xsltExtInitFunction as function(byval ctxt as xsltTransformContextPtr, byval URI as const xmlChar ptr) as any ptr
type xsltExtShutdownFunction as sub(byval ctxt as xsltTransformContextPtr, byval URI as const xmlChar ptr, byval data as any ptr)

declare function xsltRegisterExtModule(byval URI as const xmlChar ptr, byval initFunc as xsltExtInitFunction, byval shutdownFunc as xsltExtShutdownFunction) as long
declare function xsltRegisterExtModuleFull(byval URI as const xmlChar ptr, byval initFunc as xsltExtInitFunction, byval shutdownFunc as xsltExtShutdownFunction, byval styleInitFunc as xsltStyleExtInitFunction, byval styleShutdownFunc as xsltStyleExtShutdownFunction) as long
declare function xsltUnregisterExtModule(byval URI as const xmlChar ptr) as long
declare function xsltGetExtData(byval ctxt as xsltTransformContextPtr, byval URI as const xmlChar ptr) as any ptr
declare function xsltStyleGetExtData(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr) as any ptr
declare sub xsltShutdownCtxtExts(byval ctxt as xsltTransformContextPtr)
declare sub xsltShutdownExts(byval style as xsltStylesheetPtr)
declare function xsltXPathGetTransformContext(byval ctxt as xmlXPathParserContextPtr) as xsltTransformContextPtr
declare function xsltRegisterExtModuleFunction(byval name as const xmlChar ptr, byval URI as const xmlChar ptr, byval function as xmlXPathFunction) as long
declare function xsltExtModuleFunctionLookup(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as xmlXPathFunction
declare function xsltUnregisterExtModuleFunction(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as long
type xsltPreComputeFunction as function(byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction) as xsltElemPreCompPtr
declare function xsltNewElemPreComp(byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction) as xsltElemPreCompPtr
declare sub xsltInitElemPreComp(byval comp as xsltElemPreCompPtr, byval style as xsltStylesheetPtr, byval inst as xmlNodePtr, byval function as xsltTransformFunction, byval freeFunc as xsltElemPreCompDeallocator)
declare function xsltRegisterExtModuleElement(byval name as const xmlChar ptr, byval URI as const xmlChar ptr, byval precomp as xsltPreComputeFunction, byval transform as xsltTransformFunction) as long
declare function xsltExtElementLookup(byval ctxt as xsltTransformContextPtr, byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as xsltTransformFunction
declare function xsltExtModuleElementLookup(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as xsltTransformFunction
declare function xsltExtModuleElementPreComputeLookup(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as xsltPreComputeFunction
declare function xsltUnregisterExtModuleElement(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as long
type xsltTopLevelFunction as sub(byval style as xsltStylesheetPtr, byval inst as xmlNodePtr)
declare function xsltRegisterExtModuleTopLevel(byval name as const xmlChar ptr, byval URI as const xmlChar ptr, byval function as xsltTopLevelFunction) as long
declare function xsltExtModuleTopLevelLookup(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as xsltTopLevelFunction
declare function xsltUnregisterExtModuleTopLevel(byval name as const xmlChar ptr, byval URI as const xmlChar ptr) as long
declare function xsltRegisterExtFunction(byval ctxt as xsltTransformContextPtr, byval name as const xmlChar ptr, byval URI as const xmlChar ptr, byval function as xmlXPathFunction) as long
declare function xsltRegisterExtElement(byval ctxt as xsltTransformContextPtr, byval name as const xmlChar ptr, byval URI as const xmlChar ptr, byval function as xsltTransformFunction) as long
declare function xsltRegisterExtPrefix(byval style as xsltStylesheetPtr, byval prefix as const xmlChar ptr, byval URI as const xmlChar ptr) as long
declare function xsltCheckExtPrefix(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr) as long
declare function xsltCheckExtURI(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr) as long
declare function xsltInitCtxtExts(byval ctxt as xsltTransformContextPtr) as long
declare sub xsltFreeCtxtExts(byval ctxt as xsltTransformContextPtr)
declare sub xsltFreeExts(byval style as xsltStylesheetPtr)
declare function xsltPreComputeExtModuleElement(byval style as xsltStylesheetPtr, byval inst as xmlNodePtr) as xsltElemPreCompPtr
declare function xsltGetExtInfo(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr) as xmlHashTablePtr
declare sub xsltRegisterTestModule()
declare sub xsltDebugDumpExtensions(byval output as FILE ptr)

end extern
