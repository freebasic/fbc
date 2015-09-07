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

#define __XML_SAX2_H__
declare function xmlSAX2GetPublicId(byval ctx as any ptr) as const xmlChar ptr
declare function xmlSAX2GetSystemId(byval ctx as any ptr) as const xmlChar ptr
declare sub xmlSAX2SetDocumentLocator(byval ctx as any ptr, byval loc as xmlSAXLocatorPtr)
declare function xmlSAX2GetLineNumber(byval ctx as any ptr) as long
declare function xmlSAX2GetColumnNumber(byval ctx as any ptr) as long
declare function xmlSAX2IsStandalone(byval ctx as any ptr) as long
declare function xmlSAX2HasInternalSubset(byval ctx as any ptr) as long
declare function xmlSAX2HasExternalSubset(byval ctx as any ptr) as long
declare sub xmlSAX2InternalSubset(byval ctx as any ptr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)
declare sub xmlSAX2ExternalSubset(byval ctx as any ptr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)
declare function xmlSAX2GetEntity(byval ctx as any ptr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function xmlSAX2GetParameterEntity(byval ctx as any ptr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function xmlSAX2ResolveEntity(byval ctx as any ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr) as xmlParserInputPtr
declare sub xmlSAX2EntityDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval type as long, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr, byval content as xmlChar ptr)
declare sub xmlSAX2AttributeDecl(byval ctx as any ptr, byval elem as const xmlChar ptr, byval fullname as const xmlChar ptr, byval type as long, byval def as long, byval defaultValue as const xmlChar ptr, byval tree as xmlEnumerationPtr)
declare sub xmlSAX2ElementDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval type as long, byval content as xmlElementContentPtr)
declare sub xmlSAX2NotationDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr)
declare sub xmlSAX2UnparsedEntityDecl(byval ctx as any ptr, byval name as const xmlChar ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr, byval notationName as const xmlChar ptr)
declare sub xmlSAX2StartDocument(byval ctx as any ptr)
declare sub xmlSAX2EndDocument(byval ctx as any ptr)
declare sub xmlSAX2StartElement(byval ctx as any ptr, byval fullname as const xmlChar ptr, byval atts as const xmlChar ptr ptr)
declare sub xmlSAX2EndElement(byval ctx as any ptr, byval name as const xmlChar ptr)
declare sub xmlSAX2StartElementNs(byval ctx as any ptr, byval localname as const xmlChar ptr, byval prefix as const xmlChar ptr, byval URI as const xmlChar ptr, byval nb_namespaces as long, byval namespaces as const xmlChar ptr ptr, byval nb_attributes as long, byval nb_defaulted as long, byval attributes as const xmlChar ptr ptr)
declare sub xmlSAX2EndElementNs(byval ctx as any ptr, byval localname as const xmlChar ptr, byval prefix as const xmlChar ptr, byval URI as const xmlChar ptr)
declare sub xmlSAX2Reference(byval ctx as any ptr, byval name as const xmlChar ptr)
declare sub xmlSAX2Characters(byval ctx as any ptr, byval ch as const xmlChar ptr, byval len as long)
declare sub xmlSAX2IgnorableWhitespace(byval ctx as any ptr, byval ch as const xmlChar ptr, byval len as long)
declare sub xmlSAX2ProcessingInstruction(byval ctx as any ptr, byval target as const xmlChar ptr, byval data as const xmlChar ptr)
declare sub xmlSAX2Comment(byval ctx as any ptr, byval value as const xmlChar ptr)
declare sub xmlSAX2CDataBlock(byval ctx as any ptr, byval value as const xmlChar ptr, byval len as long)
declare function xmlSAXDefaultVersion(byval version as long) as long
declare function xmlSAXVersion(byval hdlr as xmlSAXHandler ptr, byval version as long) as long
declare sub xmlSAX2InitDefaultSAXHandler(byval hdlr as xmlSAXHandler ptr, byval warning as long)
declare sub xmlSAX2InitHtmlDefaultSAXHandler(byval hdlr as xmlSAXHandler ptr)
declare sub htmlDefaultSAXHandlerInit()
declare sub xmlSAX2InitDocbDefaultSAXHandler(byval hdlr as xmlSAXHandler ptr)
declare sub docbDefaultSAXHandlerInit()
declare sub xmlDefaultSAXHandlerInit()

end extern
