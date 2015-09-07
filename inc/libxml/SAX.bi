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
#include once "crt/stdlib.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/parser.bi"
#include once "libxml/xlink.bi"

extern "C"

#define __XML_SAX_H__
declare function getPublicId(byval ctx as any ptr) as const xmlChar ptr
declare function getSystemId(byval ctx as any ptr) as const xmlChar ptr
declare sub setDocumentLocator(byval ctx as any ptr, byval loc as xmlSAXLocatorPtr)
declare function getLineNumber(byval ctx as any ptr) as long
declare function getColumnNumber(byval ctx as any ptr) as long
declare function isStandalone(byval ctx as any ptr) as long
declare function hasInternalSubset(byval ctx as any ptr) as long
declare function hasExternalSubset(byval ctx as any ptr) as long
declare sub internalSubset(byval ctx as any ptr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)
declare sub externalSubset(byval ctx as any ptr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)
declare function getEntity(byval ctx as any ptr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function getParameterEntity(byval ctx as any ptr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function resolveEntity(byval ctx as any ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr) as xmlParserInputPtr
declare sub entityDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval type as long, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr, byval content as xmlChar ptr)
declare sub attributeDecl(byval ctx as any ptr, byval elem as const xmlChar ptr, byval fullname as const xmlChar ptr, byval type as long, byval def as long, byval defaultValue as const xmlChar ptr, byval tree as xmlEnumerationPtr)
declare sub elementDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval type as long, byval content as xmlElementContentPtr)
declare sub notationDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr)
declare sub unparsedEntityDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr, byval notationName as const xmlChar ptr)
declare sub startDocument(byval ctx as any ptr)
declare sub endDocument(byval ctx as any ptr)
declare sub attribute(byval ctx as any ptr, byval fullname as const xmlChar ptr, byval value as const xmlChar ptr)
declare sub startElement(byval ctx as any ptr, byval fullname as const xmlChar ptr, byval atts as const xmlChar ptr ptr)
declare sub endElement(byval ctx as any ptr, byval name as const xmlChar ptr)
declare sub reference(byval ctx as any ptr, byval name as const xmlChar ptr)
declare sub characters(byval ctx as any ptr, byval ch as const xmlChar ptr, byval len as long)
declare sub ignorableWhitespace(byval ctx as any ptr, byval ch as const xmlChar ptr, byval len as long)
declare sub processingInstruction(byval ctx as any ptr, byval target as const xmlChar ptr, byval data as const xmlChar ptr)
declare sub globalNamespace(byval ctx as any ptr, byval href as const xmlChar ptr, byval prefix as const xmlChar ptr)
declare sub setNamespace(byval ctx as any ptr, byval name as const xmlChar ptr)
declare function getNamespace(byval ctx as any ptr) as xmlNsPtr
declare function checkNamespace(byval ctx as any ptr, byval nameSpace as xmlChar ptr) as long
declare sub namespaceDecl(byval ctx as any ptr, byval href as const xmlChar ptr, byval prefix as const xmlChar ptr)
declare sub comment(byval ctx as any ptr, byval value as const xmlChar ptr)
declare sub cdataBlock(byval ctx as any ptr, byval value as const xmlChar ptr, byval len as long)
declare sub initxmlDefaultSAXHandler(byval hdlr as xmlSAXHandlerV1 ptr, byval warning as long)
declare sub inithtmlDefaultSAXHandler(byval hdlr as xmlSAXHandlerV1 ptr)
declare sub initdocbDefaultSAXHandler(byval hdlr as xmlSAXHandlerV1 ptr)

end extern
