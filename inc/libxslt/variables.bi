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
#include once "functions.bi"

extern "C"

#define __XML_XSLT_VARIABLES_H__
#macro XSLT_REGISTER_VARIABLE_LOOKUP(ctxt)
	scope
		xmlXPathRegisterVariableLookup((ctxt)->xpathCtxt, @xsltXPathVariableLookup, cptr(any ptr, (ctxt)))
		xsltRegisterAllFunctions((ctxt)->xpathCtxt)
		xsltRegisterAllElement(ctxt)
		(ctxt)->xpathCtxt->extra = ctxt
	end scope
#endmacro
declare function xsltEvalGlobalVariables(byval ctxt as xsltTransformContextPtr) as long
declare function xsltEvalUserParams(byval ctxt as xsltTransformContextPtr, byval params as const zstring ptr ptr) as long
declare function xsltQuoteUserParams(byval ctxt as xsltTransformContextPtr, byval params as const zstring ptr ptr) as long
declare function xsltEvalOneUserParam(byval ctxt as xsltTransformContextPtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as long
declare function xsltQuoteOneUserParam(byval ctxt as xsltTransformContextPtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as long
declare sub xsltParseGlobalVariable(byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltParseGlobalParam(byval style as xsltStylesheetPtr, byval cur as xmlNodePtr)
declare sub xsltParseStylesheetVariable(byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr)
declare sub xsltParseStylesheetParam(byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr)
declare function xsltParseStylesheetCallerParam(byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr) as xsltStackElemPtr
declare function xsltAddStackElemList(byval ctxt as xsltTransformContextPtr, byval elems as xsltStackElemPtr) as long
declare sub xsltFreeGlobalVariables(byval ctxt as xsltTransformContextPtr)
declare function xsltVariableLookup(byval ctxt as xsltTransformContextPtr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as xmlXPathObjectPtr
declare function xsltXPathVariableLookup(byval ctxt as any ptr, byval name as const xmlChar ptr, byval ns_uri as const xmlChar ptr) as xmlXPathObjectPtr

end extern
