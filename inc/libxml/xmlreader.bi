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

#include once "crt/long.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xmlIO.bi"
#include once "libxml/relaxng.bi"
#include once "libxml/xmlschemas.bi"

extern "C"

#define __XML_XMLREADER_H__

type xmlParserSeverities as long
enum
	XML_PARSER_SEVERITY_VALIDITY_WARNING = 1
	XML_PARSER_SEVERITY_VALIDITY_ERROR = 2
	XML_PARSER_SEVERITY_WARNING = 3
	XML_PARSER_SEVERITY_ERROR = 4
end enum

type xmlTextReaderMode as long
enum
	XML_TEXTREADER_MODE_INITIAL = 0
	XML_TEXTREADER_MODE_INTERACTIVE = 1
	XML_TEXTREADER_MODE_ERROR = 2
	XML_TEXTREADER_MODE_EOF = 3
	XML_TEXTREADER_MODE_CLOSED = 4
	XML_TEXTREADER_MODE_READING = 5
end enum

type xmlParserProperties as long
enum
	XML_PARSER_LOADDTD = 1
	XML_PARSER_DEFAULTATTRS = 2
	XML_PARSER_VALIDATE = 3
	XML_PARSER_SUBST_ENTITIES = 4
end enum

type xmlReaderTypes as long
enum
	XML_READER_TYPE_NONE = 0
	XML_READER_TYPE_ELEMENT = 1
	XML_READER_TYPE_ATTRIBUTE = 2
	XML_READER_TYPE_TEXT = 3
	XML_READER_TYPE_CDATA = 4
	XML_READER_TYPE_ENTITY_REFERENCE = 5
	XML_READER_TYPE_ENTITY = 6
	XML_READER_TYPE_PROCESSING_INSTRUCTION = 7
	XML_READER_TYPE_COMMENT = 8
	XML_READER_TYPE_DOCUMENT = 9
	XML_READER_TYPE_DOCUMENT_TYPE = 10
	XML_READER_TYPE_DOCUMENT_FRAGMENT = 11
	XML_READER_TYPE_NOTATION = 12
	XML_READER_TYPE_WHITESPACE = 13
	XML_READER_TYPE_SIGNIFICANT_WHITESPACE = 14
	XML_READER_TYPE_END_ELEMENT = 15
	XML_READER_TYPE_END_ENTITY = 16
	XML_READER_TYPE_XML_DECLARATION = 17
end enum

type xmlTextReader as _xmlTextReader
type xmlTextReaderPtr as xmlTextReader ptr
declare function xmlNewTextReader(byval input as xmlParserInputBufferPtr, byval URI as const zstring ptr) as xmlTextReaderPtr
declare function xmlNewTextReaderFilename(byval URI as const zstring ptr) as xmlTextReaderPtr
declare sub xmlFreeTextReader(byval reader as xmlTextReaderPtr)
declare function xmlTextReaderSetup(byval reader as xmlTextReaderPtr, byval input as xmlParserInputBufferPtr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as long
declare function xmlTextReaderRead(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderReadInnerXml(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderReadOuterXml(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderReadString(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderReadAttributeValue(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderAttributeCount(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderDepth(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderHasAttributes(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderHasValue(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderIsDefault(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderIsEmptyElement(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderNodeType(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderQuoteChar(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderReadState(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderIsNamespaceDecl(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderConstBaseUri(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderConstLocalName(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderConstName(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderConstNamespaceUri(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderConstPrefix(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderConstXmlLang(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderConstString(byval reader as xmlTextReaderPtr, byval str as const xmlChar ptr) as const xmlChar ptr
declare function xmlTextReaderConstValue(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderBaseUri(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderLocalName(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderName(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderNamespaceUri(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderPrefix(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderXmlLang(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderValue(byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderClose(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderGetAttributeNo(byval reader as xmlTextReaderPtr, byval no as long) as xmlChar ptr
declare function xmlTextReaderGetAttribute(byval reader as xmlTextReaderPtr, byval name as const xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderGetAttributeNs(byval reader as xmlTextReaderPtr, byval localName as const xmlChar ptr, byval namespaceURI as const xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderGetRemainder(byval reader as xmlTextReaderPtr) as xmlParserInputBufferPtr
declare function xmlTextReaderLookupNamespace(byval reader as xmlTextReaderPtr, byval prefix as const xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderMoveToAttributeNo(byval reader as xmlTextReaderPtr, byval no as long) as long
declare function xmlTextReaderMoveToAttribute(byval reader as xmlTextReaderPtr, byval name as const xmlChar ptr) as long
declare function xmlTextReaderMoveToAttributeNs(byval reader as xmlTextReaderPtr, byval localName as const xmlChar ptr, byval namespaceURI as const xmlChar ptr) as long
declare function xmlTextReaderMoveToFirstAttribute(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderMoveToNextAttribute(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderMoveToElement(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderNormalization(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderConstEncoding(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderSetParserProp(byval reader as xmlTextReaderPtr, byval prop as long, byval value as long) as long
declare function xmlTextReaderGetParserProp(byval reader as xmlTextReaderPtr, byval prop as long) as long
declare function xmlTextReaderCurrentNode(byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderGetParserLineNumber(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderGetParserColumnNumber(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderPreserve(byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderPreservePattern(byval reader as xmlTextReaderPtr, byval pattern as const xmlChar ptr, byval namespaces as const xmlChar ptr ptr) as long
declare function xmlTextReaderCurrentDoc(byval reader as xmlTextReaderPtr) as xmlDocPtr
declare function xmlTextReaderExpand(byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderNext(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderNextSibling(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderIsValid(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderRelaxNGValidate(byval reader as xmlTextReaderPtr, byval rng as const zstring ptr) as long
declare function xmlTextReaderRelaxNGValidateCtxt(byval reader as xmlTextReaderPtr, byval ctxt as xmlRelaxNGValidCtxtPtr, byval options as long) as long
declare function xmlTextReaderRelaxNGSetSchema(byval reader as xmlTextReaderPtr, byval schema as xmlRelaxNGPtr) as long
declare function xmlTextReaderSchemaValidate(byval reader as xmlTextReaderPtr, byval xsd as const zstring ptr) as long
declare function xmlTextReaderSchemaValidateCtxt(byval reader as xmlTextReaderPtr, byval ctxt as xmlSchemaValidCtxtPtr, byval options as long) as long
declare function xmlTextReaderSetSchema(byval reader as xmlTextReaderPtr, byval schema as xmlSchemaPtr) as long
declare function xmlTextReaderConstXmlVersion(byval reader as xmlTextReaderPtr) as const xmlChar ptr
declare function xmlTextReaderStandalone(byval reader as xmlTextReaderPtr) as long
declare function xmlTextReaderByteConsumed(byval reader as xmlTextReaderPtr) as clong
declare function xmlReaderWalker(byval doc as xmlDocPtr) as xmlTextReaderPtr
declare function xmlReaderForDoc(byval cur as const xmlChar ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlTextReaderPtr
declare function xmlReaderForFile(byval filename as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlTextReaderPtr
declare function xmlReaderForMemory(byval buffer as const zstring ptr, byval size as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlTextReaderPtr
declare function xmlReaderForFd(byval fd as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlTextReaderPtr
declare function xmlReaderForIO(byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlTextReaderPtr
declare function xmlReaderNewWalker(byval reader as xmlTextReaderPtr, byval doc as xmlDocPtr) as long
declare function xmlReaderNewDoc(byval reader as xmlTextReaderPtr, byval cur as const xmlChar ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as long
declare function xmlReaderNewFile(byval reader as xmlTextReaderPtr, byval filename as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as long
declare function xmlReaderNewMemory(byval reader as xmlTextReaderPtr, byval buffer as const zstring ptr, byval size as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as long
declare function xmlReaderNewFd(byval reader as xmlTextReaderPtr, byval fd as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as long
declare function xmlReaderNewIO(byval reader as xmlTextReaderPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as long
type xmlTextReaderLocatorPtr as any ptr
type xmlTextReaderErrorFunc as sub(byval arg as any ptr, byval msg as const zstring ptr, byval severity as xmlParserSeverities, byval locator as xmlTextReaderLocatorPtr)
declare function xmlTextReaderLocatorLineNumber(byval locator as xmlTextReaderLocatorPtr) as long
declare function xmlTextReaderLocatorBaseURI(byval locator as xmlTextReaderLocatorPtr) as xmlChar ptr
declare sub xmlTextReaderSetErrorHandler(byval reader as xmlTextReaderPtr, byval f as xmlTextReaderErrorFunc, byval arg as any ptr)
declare sub xmlTextReaderSetStructuredErrorHandler(byval reader as xmlTextReaderPtr, byval f as xmlStructuredErrorFunc, byval arg as any ptr)
declare sub xmlTextReaderGetErrorHandler(byval reader as xmlTextReaderPtr, byval f as xmlTextReaderErrorFunc ptr, byval arg as any ptr ptr)

end extern
