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

#include once "crt/long.bi"
#include once "libxml/tree.bi"
#include once "xsltexports.bi"

extern "C"

#define __XML_XSLT_NAMESPACES_H__
const UNDEFINED_DEFAULT_NS = cptr(const xmlChar ptr, -cast(clong, 1))
declare sub xsltNamespaceAlias(byval style as xsltStylesheetPtr, byval node as xmlNodePtr)
declare function xsltGetNamespace(byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval ns as xmlNsPtr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltGetPlainNamespace(byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval ns as xmlNsPtr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltGetSpecialNamespace(byval ctxt as xsltTransformContextPtr, byval cur as xmlNodePtr, byval URI as const xmlChar ptr, byval prefix as const xmlChar ptr, byval out as xmlNodePtr) as xmlNsPtr
declare function xsltCopyNamespace(byval ctxt as xsltTransformContextPtr, byval elem as xmlNodePtr, byval ns as xmlNsPtr) as xmlNsPtr
declare function xsltCopyNamespaceList(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval cur as xmlNsPtr) as xmlNsPtr
declare sub xsltFreeNamespaceAliasHashes(byval style as xsltStylesheetPtr)

end extern
