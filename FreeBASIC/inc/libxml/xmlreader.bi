''
''
'' xmlreader -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xmlreader_bi__
#define __xmlreader_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/xmlIO.bi"
#include once "libxml/relaxng.bi"

enum xmlTextReaderMode
	XML_TEXTREADER_MODE_INITIAL = 0
	XML_TEXTREADER_MODE_INTERACTIVE = 1
	XML_TEXTREADER_MODE_ERROR = 2
	XML_TEXTREADER_MODE_EOF = 3
	XML_TEXTREADER_MODE_CLOSED = 4
	XML_TEXTREADER_MODE_READING = 5
end enum


enum xmlParserProperties
	XML_PARSER_LOADDTD = 1
	XML_PARSER_DEFAULTATTRS = 2
	XML_PARSER_VALIDATE = 3
	XML_PARSER_SUBST_ENTITIES = 4
end enum


enum xmlParserSeverities
	XML_PARSER_SEVERITY_VALIDITY_WARNING = 1
	XML_PARSER_SEVERITY_VALIDITY_ERROR = 2
	XML_PARSER_SEVERITY_WARNING = 3
	XML_PARSER_SEVERITY_ERROR = 4
end enum


enum xmlReaderTypes
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

declare function xmlNewTextReader cdecl alias "xmlNewTextReader" (byval input as xmlParserInputBufferPtr, byval URI as string) as xmlTextReaderPtr
declare function xmlNewTextReaderFilename cdecl alias "xmlNewTextReaderFilename" (byval URI as string) as xmlTextReaderPtr
declare sub xmlFreeTextReader cdecl alias "xmlFreeTextReader" (byval reader as xmlTextReaderPtr)
declare function xmlTextReaderRead cdecl alias "xmlTextReaderRead" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderReadInnerXml cdecl alias "xmlTextReaderReadInnerXml" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderReadOuterXml cdecl alias "xmlTextReaderReadOuterXml" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderReadString cdecl alias "xmlTextReaderReadString" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderReadAttributeValue cdecl alias "xmlTextReaderReadAttributeValue" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderAttributeCount cdecl alias "xmlTextReaderAttributeCount" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderDepth cdecl alias "xmlTextReaderDepth" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderHasAttributes cdecl alias "xmlTextReaderHasAttributes" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderHasValue cdecl alias "xmlTextReaderHasValue" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsDefault cdecl alias "xmlTextReaderIsDefault" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsEmptyElement cdecl alias "xmlTextReaderIsEmptyElement" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderNodeType cdecl alias "xmlTextReaderNodeType" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderQuoteChar cdecl alias "xmlTextReaderQuoteChar" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderReadState cdecl alias "xmlTextReaderReadState" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsNamespaceDecl cdecl alias "xmlTextReaderIsNamespaceDecl" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderConstBaseUri cdecl alias "xmlTextReaderConstBaseUri" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderConstLocalName cdecl alias "xmlTextReaderConstLocalName" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderConstName cdecl alias "xmlTextReaderConstName" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderConstNamespaceUri cdecl alias "xmlTextReaderConstNamespaceUri" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderConstPrefix cdecl alias "xmlTextReaderConstPrefix" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderConstXmlLang cdecl alias "xmlTextReaderConstXmlLang" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderConstString cdecl alias "xmlTextReaderConstString" (byval reader as xmlTextReaderPtr, byval str as xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderConstValue cdecl alias "xmlTextReaderConstValue" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderBaseUri cdecl alias "xmlTextReaderBaseUri" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderLocalName cdecl alias "xmlTextReaderLocalName" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderName cdecl alias "xmlTextReaderName" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderNamespaceUri cdecl alias "xmlTextReaderNamespaceUri" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderPrefix cdecl alias "xmlTextReaderPrefix" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderXmlLang cdecl alias "xmlTextReaderXmlLang" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderValue cdecl alias "xmlTextReaderValue" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderClose cdecl alias "xmlTextReaderClose" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderGetAttributeNo cdecl alias "xmlTextReaderGetAttributeNo" (byval reader as xmlTextReaderPtr, byval no as integer) as xmlChar ptr
declare function xmlTextReaderGetAttribute cdecl alias "xmlTextReaderGetAttribute" (byval reader as xmlTextReaderPtr, byval name as xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderGetAttributeNs cdecl alias "xmlTextReaderGetAttributeNs" (byval reader as xmlTextReaderPtr, byval localName as xmlChar ptr, byval namespaceURI as xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderGetRemainder cdecl alias "xmlTextReaderGetRemainder" (byval reader as xmlTextReaderPtr) as xmlParserInputBufferPtr
declare function xmlTextReaderLookupNamespace cdecl alias "xmlTextReaderLookupNamespace" (byval reader as xmlTextReaderPtr, byval prefix as xmlChar ptr) as xmlChar ptr
declare function xmlTextReaderMoveToAttributeNo cdecl alias "xmlTextReaderMoveToAttributeNo" (byval reader as xmlTextReaderPtr, byval no as integer) as integer
declare function xmlTextReaderMoveToAttribute cdecl alias "xmlTextReaderMoveToAttribute" (byval reader as xmlTextReaderPtr, byval name as xmlChar ptr) as integer
declare function xmlTextReaderMoveToAttributeNs cdecl alias "xmlTextReaderMoveToAttributeNs" (byval reader as xmlTextReaderPtr, byval localName as xmlChar ptr, byval namespaceURI as xmlChar ptr) as integer
declare function xmlTextReaderMoveToFirstAttribute cdecl alias "xmlTextReaderMoveToFirstAttribute" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderMoveToNextAttribute cdecl alias "xmlTextReaderMoveToNextAttribute" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderMoveToElement cdecl alias "xmlTextReaderMoveToElement" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderNormalization cdecl alias "xmlTextReaderNormalization" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderConstEncoding cdecl alias "xmlTextReaderConstEncoding" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderSetParserProp cdecl alias "xmlTextReaderSetParserProp" (byval reader as xmlTextReaderPtr, byval prop as integer, byval value as integer) as integer
declare function xmlTextReaderGetParserProp cdecl alias "xmlTextReaderGetParserProp" (byval reader as xmlTextReaderPtr, byval prop as integer) as integer
declare function xmlTextReaderCurrentNode cdecl alias "xmlTextReaderCurrentNode" (byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderGetParserLineNumber cdecl alias "xmlTextReaderGetParserLineNumber" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderGetParserColumnNumber cdecl alias "xmlTextReaderGetParserColumnNumber" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderPreserve cdecl alias "xmlTextReaderPreserve" (byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderPreservePattern cdecl alias "xmlTextReaderPreservePattern" (byval reader as xmlTextReaderPtr, byval pattern as xmlChar ptr, byval namespaces as xmlChar ptr ptr) as integer
declare function xmlTextReaderCurrentDoc cdecl alias "xmlTextReaderCurrentDoc" (byval reader as xmlTextReaderPtr) as xmlDocPtr
declare function xmlTextReaderExpand cdecl alias "xmlTextReaderExpand" (byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderNext cdecl alias "xmlTextReaderNext" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderNextSibling cdecl alias "xmlTextReaderNextSibling" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsValid cdecl alias "xmlTextReaderIsValid" (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderRelaxNGValidate cdecl alias "xmlTextReaderRelaxNGValidate" (byval reader as xmlTextReaderPtr, byval rng as string) as integer
declare function xmlTextReaderRelaxNGSetSchema cdecl alias "xmlTextReaderRelaxNGSetSchema" (byval reader as xmlTextReaderPtr, byval schema as xmlRelaxNGPtr) as integer
declare function xmlTextReaderConstXmlVersion cdecl alias "xmlTextReaderConstXmlVersion" (byval reader as xmlTextReaderPtr) as xmlChar ptr
declare function xmlTextReaderStandalone cdecl alias "xmlTextReaderStandalone" (byval reader as xmlTextReaderPtr) as integer
declare function xmlReaderWalker cdecl alias "xmlReaderWalker" (byval doc as xmlDocPtr) as xmlTextReaderPtr
declare function xmlReaderForDoc cdecl alias "xmlReaderForDoc" (byval cur as xmlChar ptr, byval URL as string, byval encoding as string, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForFile cdecl alias "xmlReaderForFile" (byval filename as string, byval encoding as string, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForMemory cdecl alias "xmlReaderForMemory" (byval buffer as string, byval size as integer, byval URL as string, byval encoding as string, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForFd cdecl alias "xmlReaderForFd" (byval fd as integer, byval URL as string, byval encoding as string, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForIO cdecl alias "xmlReaderForIO" (byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as string, byval encoding as string, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderNewWalker cdecl alias "xmlReaderNewWalker" (byval reader as xmlTextReaderPtr, byval doc as xmlDocPtr) as integer
declare function xmlReaderNewDoc cdecl alias "xmlReaderNewDoc" (byval reader as xmlTextReaderPtr, byval cur as xmlChar ptr, byval URL as string, byval encoding as string, byval options as integer) as integer
declare function xmlReaderNewFile cdecl alias "xmlReaderNewFile" (byval reader as xmlTextReaderPtr, byval filename as string, byval encoding as string, byval options as integer) as integer
declare function xmlReaderNewMemory cdecl alias "xmlReaderNewMemory" (byval reader as xmlTextReaderPtr, byval buffer as string, byval size as integer, byval URL as string, byval encoding as string, byval options as integer) as integer
declare function xmlReaderNewFd cdecl alias "xmlReaderNewFd" (byval reader as xmlTextReaderPtr, byval fd as integer, byval URL as string, byval encoding as string, byval options as integer) as integer
declare function xmlReaderNewIO cdecl alias "xmlReaderNewIO" (byval reader as xmlTextReaderPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as string, byval encoding as string, byval options as integer) as integer

type xmlTextReaderLocatorPtr as any ptr
type xmlTextReaderErrorFunc as any ptr

declare function xmlTextReaderLocatorLineNumber cdecl alias "xmlTextReaderLocatorLineNumber" (byval locator as xmlTextReaderLocatorPtr) as integer
declare function xmlTextReaderLocatorBaseURI cdecl alias "xmlTextReaderLocatorBaseURI" (byval locator as xmlTextReaderLocatorPtr) as xmlChar ptr
declare sub xmlTextReaderSetErrorHandler cdecl alias "xmlTextReaderSetErrorHandler" (byval reader as xmlTextReaderPtr, byval f as xmlTextReaderErrorFunc, byval arg as any ptr)
declare sub xmlTextReaderSetStructuredErrorHandler cdecl alias "xmlTextReaderSetStructuredErrorHandler" (byval reader as xmlTextReaderPtr, byval f as xmlStructuredErrorFunc, byval arg as any ptr)
declare sub xmlTextReaderGetErrorHandler cdecl alias "xmlTextReaderGetErrorHandler" (byval reader as xmlTextReaderPtr, byval f as xmlTextReaderErrorFunc ptr, byval arg as any ptr ptr)

#endif
