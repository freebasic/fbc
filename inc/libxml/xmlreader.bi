''
''
'' xmlreader -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlreader_bi__
#define __xml_xmlreader_bi__

#include once "xmlversion.bi"
#include once "tree.bi"
#include once "xmlIO.bi"
#include once "relaxng.bi"

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

type xmlTextReaderLocatorPtr as any ptr
type xmlTextReaderErrorFunc as any ptr

extern "c"
declare function xmlNewTextReader (byval input as xmlParserInputBufferPtr, byval URI as zstring ptr) as xmlTextReaderPtr
declare function xmlNewTextReaderFilename (byval URI as zstring ptr) as xmlTextReaderPtr
declare sub xmlFreeTextReader (byval reader as xmlTextReaderPtr)
declare function xmlTextReaderRead (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderReadInnerXml (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderReadOuterXml (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderReadString (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderReadAttributeValue (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderAttributeCount (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderDepth (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderHasAttributes (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderHasValue (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsDefault (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsEmptyElement (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderNodeType (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderQuoteChar (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderReadState (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsNamespaceDecl (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderConstBaseUri (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderConstLocalName (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderConstName (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderConstNamespaceUri (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderConstPrefix (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderConstXmlLang (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderConstString (byval reader as xmlTextReaderPtr, byval str as zstring ptr) as zstring ptr
declare function xmlTextReaderConstValue (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderBaseUri (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderLocalName (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderName (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderNamespaceUri (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderPrefix (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderXmlLang (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderValue (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderClose (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderGetAttributeNo (byval reader as xmlTextReaderPtr, byval no as integer) as zstring ptr
declare function xmlTextReaderGetAttribute (byval reader as xmlTextReaderPtr, byval name as zstring ptr) as zstring ptr
declare function xmlTextReaderGetAttributeNs (byval reader as xmlTextReaderPtr, byval localName as zstring ptr, byval namespaceURI as zstring ptr) as zstring ptr
declare function xmlTextReaderGetRemainder (byval reader as xmlTextReaderPtr) as xmlParserInputBufferPtr
declare function xmlTextReaderLookupNamespace (byval reader as xmlTextReaderPtr, byval prefix as zstring ptr) as zstring ptr
declare function xmlTextReaderMoveToAttributeNo (byval reader as xmlTextReaderPtr, byval no as integer) as integer
declare function xmlTextReaderMoveToAttribute (byval reader as xmlTextReaderPtr, byval name as zstring ptr) as integer
declare function xmlTextReaderMoveToAttributeNs (byval reader as xmlTextReaderPtr, byval localName as zstring ptr, byval namespaceURI as zstring ptr) as integer
declare function xmlTextReaderMoveToFirstAttribute (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderMoveToNextAttribute (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderMoveToElement (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderNormalization (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderConstEncoding (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderSetParserProp (byval reader as xmlTextReaderPtr, byval prop as integer, byval value as integer) as integer
declare function xmlTextReaderGetParserProp (byval reader as xmlTextReaderPtr, byval prop as integer) as integer
declare function xmlTextReaderCurrentNode (byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderGetParserLineNumber (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderGetParserColumnNumber (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderPreserve (byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderPreservePattern (byval reader as xmlTextReaderPtr, byval pattern as zstring ptr, byval namespaces as zstring ptr ptr) as integer
declare function xmlTextReaderCurrentDoc (byval reader as xmlTextReaderPtr) as xmlDocPtr
declare function xmlTextReaderExpand (byval reader as xmlTextReaderPtr) as xmlNodePtr
declare function xmlTextReaderNext (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderNextSibling (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderIsValid (byval reader as xmlTextReaderPtr) as integer
declare function xmlTextReaderRelaxNGValidate (byval reader as xmlTextReaderPtr, byval rng as zstring ptr) as integer
declare function xmlTextReaderRelaxNGSetSchema (byval reader as xmlTextReaderPtr, byval schema as xmlRelaxNGPtr) as integer
declare function xmlTextReaderConstXmlVersion (byval reader as xmlTextReaderPtr) as zstring ptr
declare function xmlTextReaderStandalone (byval reader as xmlTextReaderPtr) as integer
declare function xmlReaderWalker (byval doc as xmlDocPtr) as xmlTextReaderPtr
declare function xmlReaderForDoc (byval cur as zstring ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForFile (byval filename as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForMemory (byval buffer as zstring ptr, byval size as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForFd (byval fd as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderForIO (byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlTextReaderPtr
declare function xmlReaderNewWalker (byval reader as xmlTextReaderPtr, byval doc as xmlDocPtr) as integer
declare function xmlReaderNewDoc (byval reader as xmlTextReaderPtr, byval cur as zstring ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as integer
declare function xmlReaderNewFile (byval reader as xmlTextReaderPtr, byval filename as zstring ptr, byval encoding as zstring ptr, byval options as integer) as integer
declare function xmlReaderNewMemory (byval reader as xmlTextReaderPtr, byval buffer as zstring ptr, byval size as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as integer
declare function xmlReaderNewFd (byval reader as xmlTextReaderPtr, byval fd as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as integer
declare function xmlReaderNewIO (byval reader as xmlTextReaderPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as integer
declare function xmlTextReaderLocatorLineNumber (byval locator as xmlTextReaderLocatorPtr) as integer
declare function xmlTextReaderLocatorBaseURI (byval locator as xmlTextReaderLocatorPtr) as zstring ptr
declare sub xmlTextReaderSetErrorHandler (byval reader as xmlTextReaderPtr, byval f as xmlTextReaderErrorFunc, byval arg as any ptr)
declare sub xmlTextReaderSetStructuredErrorHandler (byval reader as xmlTextReaderPtr, byval f as xmlStructuredErrorFunc, byval arg as any ptr)
declare sub xmlTextReaderGetErrorHandler (byval reader as xmlTextReaderPtr, byval f as xmlTextReaderErrorFunc ptr, byval arg as any ptr ptr)
end extern

#endif
