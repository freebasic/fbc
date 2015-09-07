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

#include once "xsltInternals.bi"
#include once "xsltexports.bi"

extern "C"

#define __XML_XSLT_PATTERN_H__
type xsltCompMatch as _xsltCompMatch
type xsltCompMatchPtr as xsltCompMatch ptr
declare function xsltCompilePattern(byval pattern as const xmlChar ptr, byval doc as xmlDocPtr, byval node as xmlNodePtr, byval style as xsltStylesheetPtr, byval runtime as xsltTransformContextPtr) as xsltCompMatchPtr
declare sub xsltFreeCompMatchList(byval comp as xsltCompMatchPtr)
declare function xsltTestCompMatchList(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval comp as xsltCompMatchPtr) as long
declare sub xsltNormalizeCompSteps(byval payload as any ptr, byval data as any ptr, byval name as const xmlChar ptr)
declare function xsltAddTemplate(byval style as xsltStylesheetPtr, byval cur as xsltTemplatePtr, byval mode as const xmlChar ptr, byval modeURI as const xmlChar ptr) as long
declare function xsltGetTemplate(byval ctxt as xsltTransformContextPtr, byval node as xmlNodePtr, byval style as xsltStylesheetPtr) as xsltTemplatePtr
declare sub xsltFreeTemplateHashes(byval style as xsltStylesheetPtr)
declare sub xsltCleanupTemplates(byval style as xsltStylesheetPtr)

end extern
