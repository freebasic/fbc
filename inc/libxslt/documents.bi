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

#include once "libxml/tree.bi"
#include once "xsltexports.bi"
#include once "xsltInternals.bi"

extern "C"

#define __XML_XSLT_DOCUMENTS_H__
declare function xsltNewDocument(byval ctxt as xsltTransformContextPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare function xsltLoadDocument(byval ctxt as xsltTransformContextPtr, byval URI as const xmlChar ptr) as xsltDocumentPtr
declare function xsltFindDocument(byval ctxt as xsltTransformContextPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare sub xsltFreeDocuments(byval ctxt as xsltTransformContextPtr)
declare function xsltLoadStyleDocument(byval style as xsltStylesheetPtr, byval URI as const xmlChar ptr) as xsltDocumentPtr
declare function xsltNewStyleDocument(byval style as xsltStylesheetPtr, byval doc as xmlDocPtr) as xsltDocumentPtr
declare sub xsltFreeStyleDocuments(byval style as xsltStylesheetPtr)

type xsltLoadType as long
enum
	XSLT_LOAD_START = 0
	XSLT_LOAD_STYLESHEET = 1
	XSLT_LOAD_DOCUMENT = 2
end enum

type xsltDocLoaderFunc as function(byval URI as const xmlChar ptr, byval dict as xmlDictPtr, byval options as long, byval ctxt as any ptr, byval type as xsltLoadType) as xmlDocPtr
declare sub xsltSetLoaderFunc(byval f as xsltDocLoaderFunc)
extern xsltDocDefaultLoader as xsltDocLoaderFunc

end extern
