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

#include once "crt/stdio.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/HTMLparser.bi"

extern "C"

#define __HTML_TREE_H__
const HTML_TEXT_NODE = XML_TEXT_NODE
const HTML_ENTITY_REF_NODE = XML_ENTITY_REF_NODE
const HTML_COMMENT_NODE = XML_COMMENT_NODE
const HTML_PRESERVE_NODE = XML_CDATA_SECTION_NODE
const HTML_PI_NODE = XML_PI_NODE

declare function htmlNewDoc(byval URI as const xmlChar ptr, byval ExternalID as const xmlChar ptr) as htmlDocPtr
declare function htmlNewDocNoDtD(byval URI as const xmlChar ptr, byval ExternalID as const xmlChar ptr) as htmlDocPtr
declare function htmlGetMetaEncoding(byval doc as htmlDocPtr) as const xmlChar ptr
declare function htmlSetMetaEncoding(byval doc as htmlDocPtr, byval encoding as const xmlChar ptr) as long
declare sub htmlDocDumpMemory(byval cur as xmlDocPtr, byval mem as xmlChar ptr ptr, byval size as long ptr)
declare sub htmlDocDumpMemoryFormat(byval cur as xmlDocPtr, byval mem as xmlChar ptr ptr, byval size as long ptr, byval format as long)
declare function htmlDocDump(byval f as FILE ptr, byval cur as xmlDocPtr) as long
declare function htmlSaveFile(byval filename as const zstring ptr, byval cur as xmlDocPtr) as long
declare function htmlNodeDump(byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr) as long
declare sub htmlNodeDumpFile(byval out as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr)
declare function htmlNodeDumpFileFormat(byval out as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as const zstring ptr, byval format as long) as long
declare function htmlSaveFileEnc(byval filename as const zstring ptr, byval cur as xmlDocPtr, byval encoding as const zstring ptr) as long
declare function htmlSaveFileFormat(byval filename as const zstring ptr, byval cur as xmlDocPtr, byval encoding as const zstring ptr, byval format as long) as long
declare sub htmlNodeDumpFormatOutput(byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as const zstring ptr, byval format as long)
declare sub htmlDocContentDumpOutput(byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as const zstring ptr)
declare sub htmlDocContentDumpFormatOutput(byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as const zstring ptr, byval format as long)
declare sub htmlNodeDumpOutput(byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval encoding as const zstring ptr)
declare function htmlIsBooleanAttr(byval name as const xmlChar ptr) as long

end extern
