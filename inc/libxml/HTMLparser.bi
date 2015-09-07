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

extern "C"

#define __HTML_PARSER_H__
type htmlParserCtxt as xmlParserCtxt
type htmlParserCtxtPtr as xmlParserCtxtPtr
type htmlParserNodeInfo as xmlParserNodeInfo
type htmlSAXHandler as xmlSAXHandler
type htmlSAXHandlerPtr as xmlSAXHandlerPtr
type htmlParserInput as xmlParserInput
type htmlParserInputPtr as xmlParserInputPtr
type htmlDocPtr as xmlDocPtr
type htmlNodePtr as xmlNodePtr
type htmlElemDesc as _htmlElemDesc
type htmlElemDescPtr as htmlElemDesc ptr

type _htmlElemDesc
	name as const zstring ptr
	startTag as byte
	endTag as byte
	saveEndTag as byte
	empty as byte
	depr as byte
	dtd as byte
	isinline as byte
	desc as const zstring ptr
	subelts as const zstring ptr ptr
	defaultsubelt as const zstring ptr
	attrs_opt as const zstring ptr ptr
	attrs_depr as const zstring ptr ptr
	attrs_req as const zstring ptr ptr
end type

type htmlEntityDesc as _htmlEntityDesc
type htmlEntityDescPtr as htmlEntityDesc ptr

type _htmlEntityDesc
	value as ulong
	name as const zstring ptr
	desc as const zstring ptr
end type

declare function htmlTagLookup(byval tag as const xmlChar ptr) as const htmlElemDesc ptr
declare function htmlEntityLookup(byval name as const xmlChar ptr) as const htmlEntityDesc ptr
declare function htmlEntityValueLookup(byval value as ulong) as const htmlEntityDesc ptr
declare function htmlIsAutoClosed(byval doc as htmlDocPtr, byval elem as htmlNodePtr) as long
declare function htmlAutoCloseTag(byval doc as htmlDocPtr, byval name as const xmlChar ptr, byval elem as htmlNodePtr) as long
declare function htmlParseEntityRef(byval ctxt as htmlParserCtxtPtr, byval str as const xmlChar ptr ptr) as const htmlEntityDesc ptr
declare function htmlParseCharRef(byval ctxt as htmlParserCtxtPtr) as long
declare sub htmlParseElement(byval ctxt as htmlParserCtxtPtr)
declare function htmlNewParserCtxt() as htmlParserCtxtPtr
declare function htmlCreateMemoryParserCtxt(byval buffer as const zstring ptr, byval size as long) as htmlParserCtxtPtr
declare function htmlParseDocument(byval ctxt as htmlParserCtxtPtr) as long
declare function htmlSAXParseDoc(byval cur as xmlChar ptr, byval encoding as const zstring ptr, byval sax as htmlSAXHandlerPtr, byval userData as any ptr) as htmlDocPtr
declare function htmlParseDoc(byval cur as xmlChar ptr, byval encoding as const zstring ptr) as htmlDocPtr
declare function htmlSAXParseFile(byval filename as const zstring ptr, byval encoding as const zstring ptr, byval sax as htmlSAXHandlerPtr, byval userData as any ptr) as htmlDocPtr
declare function htmlParseFile(byval filename as const zstring ptr, byval encoding as const zstring ptr) as htmlDocPtr
declare function UTF8ToHtml(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr) as long
declare function htmlEncodeEntities(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr, byval quoteChar as long) as long
declare function htmlIsScriptAttribute(byval name as const xmlChar ptr) as long
declare function htmlHandleOmittedElem(byval val as long) as long
declare function htmlCreatePushParserCtxt(byval sax as htmlSAXHandlerPtr, byval user_data as any ptr, byval chunk as const zstring ptr, byval size as long, byval filename as const zstring ptr, byval enc as xmlCharEncoding) as htmlParserCtxtPtr
declare function htmlParseChunk(byval ctxt as htmlParserCtxtPtr, byval chunk as const zstring ptr, byval size as long, byval terminate as long) as long
declare sub htmlFreeParserCtxt(byval ctxt as htmlParserCtxtPtr)

type htmlParserOption as long
enum
	HTML_PARSE_RECOVER = 1 shl 0
	HTML_PARSE_NODEFDTD = 1 shl 2
	HTML_PARSE_NOERROR = 1 shl 5
	HTML_PARSE_NOWARNING = 1 shl 6
	HTML_PARSE_PEDANTIC = 1 shl 7
	HTML_PARSE_NOBLANKS = 1 shl 8
	HTML_PARSE_NONET = 1 shl 11
	HTML_PARSE_NOIMPLIED = 1 shl 13
	HTML_PARSE_COMPACT = 1 shl 16
	HTML_PARSE_IGNORE_ENC = 1 shl 21
end enum

declare sub htmlCtxtReset(byval ctxt as htmlParserCtxtPtr)
declare function htmlCtxtUseOptions(byval ctxt as htmlParserCtxtPtr, byval options as long) as long
declare function htmlReadDoc(byval cur as const xmlChar ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlReadFile(byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlReadMemory(byval buffer as const zstring ptr, byval size as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlReadFd(byval fd as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlReadIO(byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlCtxtReadDoc(byval ctxt as xmlParserCtxtPtr, byval cur as const xmlChar ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlCtxtReadFile(byval ctxt as xmlParserCtxtPtr, byval filename as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlCtxtReadMemory(byval ctxt as xmlParserCtxtPtr, byval buffer as const zstring ptr, byval size as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlCtxtReadFd(byval ctxt as xmlParserCtxtPtr, byval fd as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr
declare function htmlCtxtReadIO(byval ctxt as xmlParserCtxtPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as htmlDocPtr

type htmlStatus as long
enum
	HTML_NA = 0
	HTML_INVALID = &h1
	HTML_DEPRECATED = &h2
	HTML_VALID = &h4
	HTML_REQUIRED = &hc
end enum

declare function htmlAttrAllowed(byval as const htmlElemDesc ptr, byval as const xmlChar ptr, byval as long) as htmlStatus
declare function htmlElementAllowedHere(byval as const htmlElemDesc ptr, byval as const xmlChar ptr) as long
declare function htmlElementStatusHere(byval as const htmlElemDesc ptr, byval as const htmlElemDesc ptr) as htmlStatus
declare function htmlNodeStatus(byval as const htmlNodePtr, byval as long) as htmlStatus

#define htmlDefaultSubelement(elt) elt->defaultsubelt
#define htmlElementAllowedHereDesc(parent, elt) htmlElementAllowedHere((parent), (elt)->name)
#define htmlRequiredAttrs(elt) (elt)->attrs_req

end extern
