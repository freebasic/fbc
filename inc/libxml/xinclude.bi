'' FreeBASIC binding for libxml2-2.9.2
''
'' based on the C header files:
''    Copyright (C) 1998-2012 Daniel Veillard.  All Rights Reserved.
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
''   AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
''   LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
''   OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
''   THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"

extern "C"

#define __XML_XINCLUDE_H__
#define XINCLUDE_NS cptr(const xmlChar ptr, @"http://www.w3.org/2003/XInclude")
#define XINCLUDE_OLD_NS cptr(const xmlChar ptr, @"http://www.w3.org/2001/XInclude")
#define XINCLUDE_NODE cptr(const xmlChar ptr, @"include")
#define XINCLUDE_FALLBACK cptr(const xmlChar ptr, @"fallback")
#define XINCLUDE_HREF cptr(const xmlChar ptr, @"href")
#define XINCLUDE_PARSE cptr(const xmlChar ptr, @"parse")
#define XINCLUDE_PARSE_XML cptr(const xmlChar ptr, @"xml")
#define XINCLUDE_PARSE_TEXT cptr(const xmlChar ptr, @"text")
#define XINCLUDE_PARSE_ENCODING cptr(const xmlChar ptr, @"encoding")
#define XINCLUDE_PARSE_XPOINTER cptr(const xmlChar ptr, @"xpointer")
type xmlXIncludeCtxt as _xmlXIncludeCtxt
type xmlXIncludeCtxtPtr as xmlXIncludeCtxt ptr

declare function xmlXIncludeProcess(byval doc as xmlDocPtr) as long
declare function xmlXIncludeProcessFlags(byval doc as xmlDocPtr, byval flags as long) as long
declare function xmlXIncludeProcessFlagsData(byval doc as xmlDocPtr, byval flags as long, byval data as any ptr) as long
declare function xmlXIncludeProcessTreeFlagsData(byval tree as xmlNodePtr, byval flags as long, byval data as any ptr) as long
declare function xmlXIncludeProcessTree(byval tree as xmlNodePtr) as long
declare function xmlXIncludeProcessTreeFlags(byval tree as xmlNodePtr, byval flags as long) as long
declare function xmlXIncludeNewContext(byval doc as xmlDocPtr) as xmlXIncludeCtxtPtr
declare function xmlXIncludeSetFlags(byval ctxt as xmlXIncludeCtxtPtr, byval flags as long) as long
declare sub xmlXIncludeFreeContext(byval ctxt as xmlXIncludeCtxtPtr)
declare function xmlXIncludeProcessNode(byval ctxt as xmlXIncludeCtxtPtr, byval tree as xmlNodePtr) as long

end extern
