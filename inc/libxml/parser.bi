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
#include once "crt/stdarg.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/dict.bi"
#include once "libxml/hash.bi"
#include once "libxml/valid.bi"
#include once "libxml/entities.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/xmlstring.bi"
#include once "libxml/encoding.bi"
#include once "libxml/xmlIO.bi"
#include once "libxml/globals.bi"

extern "C"

#define __XML_PARSER_H__
#define XML_DEFAULT_VERSION "1.0"
type xmlParserInputDeallocate as sub(byval str as xmlChar ptr)

type _xmlParserInput
	buf as xmlParserInputBufferPtr
	filename as const zstring ptr
	directory as const zstring ptr
	base as const xmlChar ptr
	cur as const xmlChar ptr
	as const xmlChar ptr end
	length as long
	line as long
	col as long
	consumed as culong
	free as xmlParserInputDeallocate
	encoding as const xmlChar ptr
	version as const xmlChar ptr
	standalone as long
	id as long
end type

type xmlParserNodeInfo as _xmlParserNodeInfo
type xmlParserNodeInfoPtr as xmlParserNodeInfo ptr

type _xmlParserNodeInfo
	node as const _xmlNode ptr
	begin_pos as culong
	begin_line as culong
	end_pos as culong
	end_line as culong
end type

type xmlParserNodeInfoSeq as _xmlParserNodeInfoSeq
type xmlParserNodeInfoSeqPtr as xmlParserNodeInfoSeq ptr

type _xmlParserNodeInfoSeq
	maximum as culong
	length as culong
	buffer as xmlParserNodeInfo ptr
end type

type xmlParserInputState as long
enum
	XML_PARSER_EOF = -1
	XML_PARSER_START = 0
	XML_PARSER_MISC
	XML_PARSER_PI
	XML_PARSER_DTD
	XML_PARSER_PROLOG
	XML_PARSER_COMMENT
	XML_PARSER_START_TAG
	XML_PARSER_CONTENT
	XML_PARSER_CDATA_SECTION
	XML_PARSER_END_TAG
	XML_PARSER_ENTITY_DECL
	XML_PARSER_ENTITY_VALUE
	XML_PARSER_ATTRIBUTE_VALUE
	XML_PARSER_SYSTEM_LITERAL
	XML_PARSER_EPILOG
	XML_PARSER_IGNORE
	XML_PARSER_PUBLIC_LITERAL
end enum

const XML_DETECT_IDS = 2
const XML_COMPLETE_ATTRS = 4
const XML_SKIP_IDS = 8

type xmlParserMode as long
enum
	XML_PARSE_UNKNOWN = 0
	XML_PARSE_DOM = 1
	XML_PARSE_SAX = 2
	XML_PARSE_PUSH_DOM = 3
	XML_PARSE_PUSH_SAX = 4
	XML_PARSE_READER = 5
end enum

type _xmlParserCtxt
	sax as _xmlSAXHandler ptr
	userData as any ptr
	myDoc as xmlDocPtr
	wellFormed as long
	replaceEntities as long
	version as const xmlChar ptr
	encoding as const xmlChar ptr
	standalone as long
	html as long
	input as xmlParserInputPtr
	inputNr as long
	inputMax as long
	inputTab as xmlParserInputPtr ptr
	node as xmlNodePtr
	nodeNr as long
	nodeMax as long
	nodeTab as xmlNodePtr ptr
	record_info as long
	node_seq as xmlParserNodeInfoSeq
	errNo_ as long
	hasExternalSubset as long
	hasPErefs as long
	external as long
	valid as long
	validate as long
	vctxt as xmlValidCtxt
	instate as xmlParserInputState
	token as long
	directory as zstring ptr
	name as const xmlChar ptr
	nameNr as long
	nameMax as long
	nameTab as const xmlChar ptr ptr
	nbChars as clong
	checkIndex as clong
	keepBlanks as long
	disableSAX as long
	inSubset as long
	intSubName as const xmlChar ptr
	extSubURI as xmlChar ptr
	extSubSystem as xmlChar ptr
	space as long ptr
	spaceNr as long
	spaceMax as long
	spaceTab as long ptr
	depth as long
	entity as xmlParserInputPtr
	charset as long
	nodelen as long
	nodemem as long
	pedantic as long
	_private as any ptr
	loadsubset as long
	linenumbers as long
	catalogs as any ptr
	recovery as long
	progressive as long
	dict as xmlDictPtr
	atts as const xmlChar ptr ptr
	maxatts as long
	docdict as long
	str_xml as const xmlChar ptr
	str_xmlns as const xmlChar ptr
	str_xml_ns as const xmlChar ptr
	sax2 as long
	nsNr as long
	nsMax as long
	nsTab as const xmlChar ptr ptr
	attallocs as long ptr
	pushTab as any ptr ptr
	attsDefault as xmlHashTablePtr
	attsSpecial as xmlHashTablePtr
	nsWellFormed as long
	options as long
	dictNames as long
	freeElemsNr as long
	freeElems as xmlNodePtr
	freeAttrsNr as long
	freeAttrs as xmlAttrPtr
	lastError as xmlError
	parseMode as xmlParserMode
	nbentities as culong
	sizeentities as culong
	nodeInfo as xmlParserNodeInfo ptr
	nodeInfoNr as long
	nodeInfoMax as long
	nodeInfoTab as xmlParserNodeInfo ptr
	input_id as long
	sizeentcopy as culong
end type

type _xmlSAXLocator
	getPublicId as function(byval ctx as any ptr) as const xmlChar ptr
	getSystemId as function(byval ctx as any ptr) as const xmlChar ptr
	getLineNumber as function(byval ctx as any ptr) as long
	getColumnNumber as function(byval ctx as any ptr) as long
end type

type resolveEntitySAXFunc as function(byval ctx as any ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr) as xmlParserInputPtr
type internalSubsetSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)
type externalSubsetSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)
type getEntitySAXFunc as function(byval ctx as any ptr, byval name as const xmlChar ptr) as xmlEntityPtr
type getParameterEntitySAXFunc as function(byval ctx as any ptr, byval name as const xmlChar ptr) as xmlEntityPtr
type entityDeclSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval type as long, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr, byval content as xmlChar ptr)
type notationDeclSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr)
type attributeDeclSAXFunc as sub(byval ctx as any ptr, byval elem as const xmlChar ptr, byval fullname as const xmlChar ptr, byval type as long, byval def as long, byval defaultValue as const xmlChar ptr, byval tree as xmlEnumerationPtr)
type elementDeclSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval type as long, byval content as xmlElementContentPtr)
type unparsedEntityDeclSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval publicId as const xmlChar ptr, byval systemId as const xmlChar ptr, byval notationName as const xmlChar ptr)
type setDocumentLocatorSAXFunc as sub(byval ctx as any ptr, byval loc as xmlSAXLocatorPtr)
type startDocumentSAXFunc as sub(byval ctx as any ptr)
type endDocumentSAXFunc as sub(byval ctx as any ptr)
type startElementSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval atts as const xmlChar ptr ptr)
type endElementSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr)
type attributeSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr, byval value as const xmlChar ptr)
type referenceSAXFunc as sub(byval ctx as any ptr, byval name as const xmlChar ptr)
type charactersSAXFunc as sub(byval ctx as any ptr, byval ch as const xmlChar ptr, byval len as long)
type ignorableWhitespaceSAXFunc as sub(byval ctx as any ptr, byval ch as const xmlChar ptr, byval len as long)
type processingInstructionSAXFunc as sub(byval ctx as any ptr, byval target as const xmlChar ptr, byval data as const xmlChar ptr)
type commentSAXFunc as sub(byval ctx as any ptr, byval value as const xmlChar ptr)
type cdataBlockSAXFunc as sub(byval ctx as any ptr, byval value as const xmlChar ptr, byval len as long)
type warningSAXFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type errorSAXFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type fatalErrorSAXFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type isStandaloneSAXFunc as function(byval ctx as any ptr) as long
type hasInternalSubsetSAXFunc as function(byval ctx as any ptr) as long
type hasExternalSubsetSAXFunc as function(byval ctx as any ptr) as long
const XML_SAX2_MAGIC = &hDEEDBEAF
type startElementNsSAX2Func as sub(byval ctx as any ptr, byval localname as const xmlChar ptr, byval prefix as const xmlChar ptr, byval URI as const xmlChar ptr, byval nb_namespaces as long, byval namespaces as const xmlChar ptr ptr, byval nb_attributes as long, byval nb_defaulted as long, byval attributes as const xmlChar ptr ptr)
type endElementNsSAX2Func as sub(byval ctx as any ptr, byval localname as const xmlChar ptr, byval prefix as const xmlChar ptr, byval URI as const xmlChar ptr)

type _xmlSAXHandler_
	internalSubset as internalSubsetSAXFunc
	isStandalone as isStandaloneSAXFunc
	hasInternalSubset as hasInternalSubsetSAXFunc
	hasExternalSubset as hasExternalSubsetSAXFunc
	resolveEntity as resolveEntitySAXFunc
	getEntity as getEntitySAXFunc
	entityDecl as entityDeclSAXFunc
	notationDecl as notationDeclSAXFunc
	attributeDecl as attributeDeclSAXFunc
	elementDecl as elementDeclSAXFunc
	unparsedEntityDecl as unparsedEntityDeclSAXFunc
	setDocumentLocator as setDocumentLocatorSAXFunc
	startDocument as startDocumentSAXFunc
	endDocument as endDocumentSAXFunc
	startElement as startElementSAXFunc
	endElement as endElementSAXFunc
	reference as referenceSAXFunc
	characters as charactersSAXFunc
	ignorableWhitespace as ignorableWhitespaceSAXFunc
	processingInstruction as processingInstructionSAXFunc
	comment as commentSAXFunc
	warning as warningSAXFunc
	error as errorSAXFunc
	fatalError as fatalErrorSAXFunc
	getParameterEntity as getParameterEntitySAXFunc
	cdataBlock as cdataBlockSAXFunc
	externalSubset as externalSubsetSAXFunc
	initialized as ulong
	_private as any ptr
	startElementNs as startElementNsSAX2Func
	endElementNs as endElementNsSAX2Func
	serror as xmlStructuredErrorFunc
end type

type xmlSAXHandlerV1 as _xmlSAXHandlerV1
type xmlSAXHandlerV1Ptr as xmlSAXHandlerV1 ptr

type _xmlSAXHandlerV1
	internalSubset as internalSubsetSAXFunc
	isStandalone as isStandaloneSAXFunc
	hasInternalSubset as hasInternalSubsetSAXFunc
	hasExternalSubset as hasExternalSubsetSAXFunc
	resolveEntity as resolveEntitySAXFunc
	getEntity as getEntitySAXFunc
	entityDecl as entityDeclSAXFunc
	notationDecl as notationDeclSAXFunc
	attributeDecl as attributeDeclSAXFunc
	elementDecl as elementDeclSAXFunc
	unparsedEntityDecl as unparsedEntityDeclSAXFunc
	setDocumentLocator as setDocumentLocatorSAXFunc
	startDocument as startDocumentSAXFunc
	endDocument as endDocumentSAXFunc
	startElement as startElementSAXFunc
	endElement as endElementSAXFunc
	reference as referenceSAXFunc
	characters as charactersSAXFunc
	ignorableWhitespace as ignorableWhitespaceSAXFunc
	processingInstruction as processingInstructionSAXFunc
	comment as commentSAXFunc
	warning as warningSAXFunc
	error as errorSAXFunc
	fatalError as fatalErrorSAXFunc
	getParameterEntity as getParameterEntitySAXFunc
	cdataBlock as cdataBlockSAXFunc
	externalSubset as externalSubsetSAXFunc
	initialized as ulong
end type

type xmlExternalEntityLoader as function(byval URL as const zstring ptr, byval ID as const zstring ptr, byval context as xmlParserCtxtPtr) as xmlParserInputPtr
declare sub xmlInitParser()
declare sub xmlCleanupParser()
declare function xmlParserInputRead(byval in as xmlParserInputPtr, byval len as long) as long
declare function xmlParserInputGrow(byval in as xmlParserInputPtr, byval len as long) as long
declare function xmlParseDoc(byval cur as const xmlChar ptr) as xmlDocPtr
declare function xmlParseFile(byval filename as const zstring ptr) as xmlDocPtr
declare function xmlParseMemory(byval buffer as const zstring ptr, byval size as long) as xmlDocPtr
declare function xmlSubstituteEntitiesDefault(byval val as long) as long
declare function xmlKeepBlanksDefault(byval val as long) as long
declare sub xmlStopParser(byval ctxt as xmlParserCtxtPtr)
declare function xmlPedanticParserDefault(byval val as long) as long
declare function xmlLineNumbersDefault(byval val as long) as long
declare function xmlRecoverDoc(byval cur as const xmlChar ptr) as xmlDocPtr
declare function xmlRecoverMemory(byval buffer as const zstring ptr, byval size as long) as xmlDocPtr
declare function xmlRecoverFile(byval filename as const zstring ptr) as xmlDocPtr
declare function xmlParseDocument(byval ctxt as xmlParserCtxtPtr) as long
declare function xmlParseExtParsedEnt(byval ctxt as xmlParserCtxtPtr) as long
declare function xmlSAXUserParseFile(byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval filename as const zstring ptr) as long
declare function xmlSAXUserParseMemory(byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval buffer as const zstring ptr, byval size as long) as long
declare function xmlSAXParseDoc(byval sax as xmlSAXHandlerPtr, byval cur as const xmlChar ptr, byval recovery as long) as xmlDocPtr
declare function xmlSAXParseMemory(byval sax as xmlSAXHandlerPtr, byval buffer as const zstring ptr, byval size as long, byval recovery as long) as xmlDocPtr
declare function xmlSAXParseMemoryWithData(byval sax as xmlSAXHandlerPtr, byval buffer as const zstring ptr, byval size as long, byval recovery as long, byval data as any ptr) as xmlDocPtr
declare function xmlSAXParseFile(byval sax as xmlSAXHandlerPtr, byval filename as const zstring ptr, byval recovery as long) as xmlDocPtr
declare function xmlSAXParseFileWithData(byval sax as xmlSAXHandlerPtr, byval filename as const zstring ptr, byval recovery as long, byval data as any ptr) as xmlDocPtr
declare function xmlSAXParseEntity(byval sax as xmlSAXHandlerPtr, byval filename as const zstring ptr) as xmlDocPtr
declare function xmlParseEntity(byval filename as const zstring ptr) as xmlDocPtr
declare function xmlSAXParseDTD(byval sax as xmlSAXHandlerPtr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr) as xmlDtdPtr
declare function xmlParseDTD(byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr) as xmlDtdPtr
declare function xmlIOParseDTD(byval sax as xmlSAXHandlerPtr, byval input as xmlParserInputBufferPtr, byval enc as xmlCharEncoding) as xmlDtdPtr
declare function xmlParseBalancedChunkMemory(byval doc as xmlDocPtr, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval depth as long, byval string as const xmlChar ptr, byval lst as xmlNodePtr ptr) as long
declare function xmlParseInNodeContext(byval node as xmlNodePtr, byval data as const zstring ptr, byval datalen as long, byval options as long, byval lst as xmlNodePtr ptr) as xmlParserErrors
declare function xmlParseBalancedChunkMemoryRecover(byval doc as xmlDocPtr, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval depth as long, byval string as const xmlChar ptr, byval lst as xmlNodePtr ptr, byval recover as long) as long
declare function xmlParseExternalEntity(byval doc as xmlDocPtr, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval depth as long, byval URL as const xmlChar ptr, byval ID as const xmlChar ptr, byval lst as xmlNodePtr ptr) as long
declare function xmlParseCtxtExternalEntity(byval ctx as xmlParserCtxtPtr, byval URL as const xmlChar ptr, byval ID as const xmlChar ptr, byval lst as xmlNodePtr ptr) as long
declare function xmlNewParserCtxt() as xmlParserCtxtPtr
declare function xmlInitParserCtxt(byval ctxt as xmlParserCtxtPtr) as long
declare sub xmlClearParserCtxt(byval ctxt as xmlParserCtxtPtr)
declare sub xmlFreeParserCtxt(byval ctxt as xmlParserCtxtPtr)
declare sub xmlSetupParserForBuffer(byval ctxt as xmlParserCtxtPtr, byval buffer as const xmlChar ptr, byval filename as const zstring ptr)
declare function xmlCreateDocParserCtxt(byval cur as const xmlChar ptr) as xmlParserCtxtPtr
declare function xmlGetFeaturesList(byval len as long ptr, byval result as const zstring ptr ptr) as long
declare function xmlGetFeature(byval ctxt as xmlParserCtxtPtr, byval name as const zstring ptr, byval result as any ptr) as long
declare function xmlSetFeature(byval ctxt as xmlParserCtxtPtr, byval name as const zstring ptr, byval value as any ptr) as long
declare function xmlCreatePushParserCtxt(byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval chunk as const zstring ptr, byval size as long, byval filename as const zstring ptr) as xmlParserCtxtPtr
declare function xmlParseChunk(byval ctxt as xmlParserCtxtPtr, byval chunk as const zstring ptr, byval size as long, byval terminate as long) as long
declare function xmlCreateIOParserCtxt(byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval enc as xmlCharEncoding) as xmlParserCtxtPtr
declare function xmlNewIOInputStream(byval ctxt as xmlParserCtxtPtr, byval input as xmlParserInputBufferPtr, byval enc as xmlCharEncoding) as xmlParserInputPtr
declare function xmlParserFindNodeInfo(byval ctxt as const xmlParserCtxtPtr, byval node as const xmlNodePtr) as const xmlParserNodeInfo ptr
declare sub xmlInitNodeInfoSeq(byval seq as xmlParserNodeInfoSeqPtr)
declare sub xmlClearNodeInfoSeq(byval seq as xmlParserNodeInfoSeqPtr)
declare function xmlParserFindNodeInfoIndex(byval seq as const xmlParserNodeInfoSeqPtr, byval node as const xmlNodePtr) as culong
declare sub xmlParserAddNodeInfo(byval ctxt as xmlParserCtxtPtr, byval info as const xmlParserNodeInfoPtr)
declare sub xmlSetExternalEntityLoader(byval f as xmlExternalEntityLoader)
declare function xmlGetExternalEntityLoader() as xmlExternalEntityLoader
declare function xmlLoadExternalEntity(byval URL as const zstring ptr, byval ID as const zstring ptr, byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function xmlByteConsumed(byval ctxt as xmlParserCtxtPtr) as clong

type xmlParserOption as long
enum
	XML_PARSE_RECOVER = 1 shl 0
	XML_PARSE_NOENT = 1 shl 1
	XML_PARSE_DTDLOAD = 1 shl 2
	XML_PARSE_DTDATTR = 1 shl 3
	XML_PARSE_DTDVALID = 1 shl 4
	XML_PARSE_NOERROR = 1 shl 5
	XML_PARSE_NOWARNING = 1 shl 6
	XML_PARSE_PEDANTIC = 1 shl 7
	XML_PARSE_NOBLANKS = 1 shl 8
	XML_PARSE_SAX1 = 1 shl 9
	XML_PARSE_XINCLUDE = 1 shl 10
	XML_PARSE_NONET = 1 shl 11
	XML_PARSE_NODICT = 1 shl 12
	XML_PARSE_NSCLEAN = 1 shl 13
	XML_PARSE_NOCDATA = 1 shl 14
	XML_PARSE_NOXINCNODE = 1 shl 15
	XML_PARSE_COMPACT = 1 shl 16
	XML_PARSE_OLD10 = 1 shl 17
	XML_PARSE_NOBASEFIX = 1 shl 18
	XML_PARSE_HUGE = 1 shl 19
	XML_PARSE_OLDSAX = 1 shl 20
	XML_PARSE_IGNORE_ENC = 1 shl 21
	XML_PARSE_BIG_LINES = 1 shl 22
end enum

declare sub xmlCtxtReset(byval ctxt as xmlParserCtxtPtr)
declare function xmlCtxtResetPush(byval ctxt as xmlParserCtxtPtr, byval chunk as const zstring ptr, byval size as long, byval filename as const zstring ptr, byval encoding as const zstring ptr) as long
declare function xmlCtxtUseOptions(byval ctxt as xmlParserCtxtPtr, byval options as long) as long
declare function xmlReadDoc(byval cur as const xmlChar ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlReadFile(byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlReadMemory(byval buffer as const zstring ptr, byval size as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlReadFd(byval fd as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlReadIO(byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlCtxtReadDoc(byval ctxt as xmlParserCtxtPtr, byval cur as const xmlChar ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlCtxtReadFile(byval ctxt as xmlParserCtxtPtr, byval filename as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlCtxtReadMemory(byval ctxt as xmlParserCtxtPtr, byval buffer as const zstring ptr, byval size as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlCtxtReadFd(byval ctxt as xmlParserCtxtPtr, byval fd as long, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr
declare function xmlCtxtReadIO(byval ctxt as xmlParserCtxtPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlDocPtr

type xmlFeature as long
enum
	XML_WITH_THREAD = 1
	XML_WITH_TREE = 2
	XML_WITH_OUTPUT = 3
	XML_WITH_PUSH = 4
	XML_WITH_READER = 5
	XML_WITH_PATTERN = 6
	XML_WITH_WRITER = 7
	XML_WITH_SAX1 = 8
	XML_WITH_FTP = 9
	XML_WITH_HTTP = 10
	XML_WITH_VALID = 11
	XML_WITH_HTML = 12
	XML_WITH_LEGACY = 13
	XML_WITH_C14N = 14
	XML_WITH_CATALOG = 15
	XML_WITH_XPATH = 16
	XML_WITH_XPTR = 17
	XML_WITH_XINCLUDE = 18
	XML_WITH_ICONV = 19
	XML_WITH_ISO8859X = 20
	XML_WITH_UNICODE = 21
	XML_WITH_REGEXP = 22
	XML_WITH_AUTOMATA = 23
	XML_WITH_EXPR = 24
	XML_WITH_SCHEMAS = 25
	XML_WITH_SCHEMATRON = 26
	XML_WITH_MODULES = 27
	XML_WITH_DEBUG = 28
	XML_WITH_DEBUG_MEM = 29
	XML_WITH_DEBUG_RUN = 30
	XML_WITH_ZLIB = 31
	XML_WITH_ICU = 32
	XML_WITH_LZMA = 33
	XML_WITH_NONE = 99999
end enum

declare function xmlHasFeature(byval feature as xmlFeature) as long

end extern
