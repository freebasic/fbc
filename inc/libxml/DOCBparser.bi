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
#include once "libxml/parser.bi"
#include once "libxml/parserInternals.bi"

extern "C"

#define __DOCB_PARSER_H__
type docbParserCtxt as xmlParserCtxt
type docbParserCtxtPtr as xmlParserCtxtPtr
type docbSAXHandler as xmlSAXHandler
type docbSAXHandlerPtr as xmlSAXHandlerPtr
type docbParserInput as xmlParserInput
type docbParserInputPtr as xmlParserInputPtr
type docbDocPtr as xmlDocPtr

declare function docbEncodeEntities(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr, byval quoteChar as long) as long
declare function docbSAXParseDoc(byval cur as xmlChar ptr, byval encoding as const zstring ptr, byval sax as docbSAXHandlerPtr, byval userData as any ptr) as docbDocPtr
declare function docbParseDoc(byval cur as xmlChar ptr, byval encoding as const zstring ptr) as docbDocPtr
declare function docbSAXParseFile(byval filename as const zstring ptr, byval encoding as const zstring ptr, byval sax as docbSAXHandlerPtr, byval userData as any ptr) as docbDocPtr
declare function docbParseFile(byval filename as const zstring ptr, byval encoding as const zstring ptr) as docbDocPtr
declare sub docbFreeParserCtxt(byval ctxt as docbParserCtxtPtr)
declare function docbCreatePushParserCtxt(byval sax as docbSAXHandlerPtr, byval user_data as any ptr, byval chunk as const zstring ptr, byval size as long, byval filename as const zstring ptr, byval enc as xmlCharEncoding) as docbParserCtxtPtr
declare function docbParseChunk(byval ctxt as docbParserCtxtPtr, byval chunk as const zstring ptr, byval size as long, byval terminate as long) as long
declare function docbCreateFileParserCtxt(byval filename as const zstring ptr, byval encoding as const zstring ptr) as docbParserCtxtPtr
declare function docbParseDocument(byval ctxt as docbParserCtxtPtr) as long

end extern
