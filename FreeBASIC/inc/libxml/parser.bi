''
''
'' parser -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_parser_bi__
#define __xml_parser_bi__

#include once "xmlversion.bi"
#include once "tree.bi"
#include once "dict.bi"
#include once "hash.bi"
#include once "valid.bi"
#include once "entities.bi"
#include once "xmlerror.bi"
#include once "xmlstring.bi"

#define XML_DEFAULT_VERSION "1.0"

type xmlParserInputDeallocate as any ptr

type _xmlParserInput
	buf as xmlParserInputBufferPtr
	filename as byte ptr
	directory as byte ptr
	base as zstring ptr
	cur as zstring ptr
	end as zstring ptr
	length as integer
	line as integer
	col as integer
	consumed as uinteger
	free as xmlParserInputDeallocate
	encoding as zstring ptr
	version as zstring ptr
	standalone as integer
	id as integer
end type

type xmlParserNodeInfo as _xmlParserNodeInfo
type xmlParserNodeInfoPtr as xmlParserNodeInfo ptr

type _xmlParserNodeInfo
	node as _xmlNode ptr
	begin_pos as uinteger
	begin_line as uinteger
	end_pos as uinteger
	end_line as uinteger
end type

type xmlParserNodeInfoSeq as _xmlParserNodeInfoSeq
type xmlParserNodeInfoSeqPtr as xmlParserNodeInfoSeq ptr

type _xmlParserNodeInfoSeq
	maximum as uinteger
	length as uinteger
	buffer as xmlParserNodeInfo ptr
end type

enum xmlParserInputState
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


#define XML_DETECT_IDS 2
#define XML_COMPLETE_ATTRS 4
#define XML_SKIP_IDS 8

enum xmlParserMode
	XML_PARSE_UNKNOWN = 0
	XML_PARSE_DOM = 1
	XML_PARSE_SAX = 2
	XML_PARSE_PUSH_DOM = 3
	XML_PARSE_PUSH_SAX = 4
	XML_PARSE_READER = 5
end enum


type _xmlParserCtxt
	sax as xmlSAXHandler ptr
	userData as any ptr
	myDoc as xmlDocPtr
	wellFormed as integer
	replaceEntities as integer
	version as zstring ptr
	encoding as zstring ptr
	standalone as integer
	html as integer
	input as xmlParserInputPtr
	inputNr as integer
	inputMax as integer
	inputTab as xmlParserInputPtr ptr
	node as xmlNodePtr
	nodeNr as integer
	nodeMax as integer
	nodeTab as xmlNodePtr ptr
	record_info as integer
	node_seq as xmlParserNodeInfoSeq
	errNo_ as integer
	hasExternalSubset as integer
	hasPErefs as integer
	external as integer
	valid as integer
	validate as integer
	vctxt as xmlValidCtxt
	instate as xmlParserInputState
	token as integer
	directory as byte ptr
	name as zstring ptr
	nameNr as integer
	nameMax as integer
	nameTab as zstring ptr ptr
	nbChars as integer
	checkIndex as integer
	keepBlanks as integer
	disableSAX as integer
	inSubset as integer
	intSubName as zstring ptr
	extSubURI as zstring ptr
	extSubSystem as zstring ptr
	space as integer ptr
	spaceNr as integer
	spaceMax as integer
	spaceTab as integer ptr
	depth as integer
	entity as xmlParserInputPtr
	charset as integer
	nodelen as integer
	nodemem as integer
	pedantic as integer
	_private as any ptr
	loadsubset as integer
	linenumbers as integer
	catalogs as any ptr
	recovery as integer
	progressive as integer
	dict as xmlDictPtr
	atts as zstring ptr ptr
	maxatts as integer
	docdict as integer
	str_xml as zstring ptr
	str_xmlns as zstring ptr
	str_xml_ns as zstring ptr
	sax2 as integer
	nsNr as integer
	nsMax as integer
	nsTab as zstring ptr ptr
	attallocs as integer ptr
	pushTab as any ptr ptr
	attsDefault as xmlHashTablePtr
	attsSpecial as xmlHashTablePtr
	nsWellFormed as integer
	options as integer
	dictNames as integer
	freeElemsNr as integer
	freeElems as xmlNodePtr
	freeAttrsNr as integer
	freeAttrs as xmlAttrPtr
	lastError as xmlError
	parseMode as xmlParserMode
end type

type _xmlSAXLocator
	getPublicId as function(byval as any ptr) as xmlChar
	getSystemId as function(byval as any ptr) as xmlChar
	getLineNumber as function(byval as any ptr) as integer
	getColumnNumber as function(byval as any ptr) as integer
end type

type resolveEntitySAXFunc as xmlParserInputPtr ptr
type internalSubsetSAXFunc as any ptr
type externalSubsetSAXFunc as any ptr
type getEntitySAXFunc as xmlEntityPtr ptr
type getParameterEntitySAXFunc as xmlEntityPtr ptr
type entityDeclSAXFunc as any ptr
type notationDeclSAXFunc as any ptr
type attributeDeclSAXFunc as any ptr
type elementDeclSAXFunc as any ptr
type unparsedEntityDeclSAXFunc as any ptr
type setDocumentLocatorSAXFunc as any ptr
type startDocumentSAXFunc as any ptr
type endDocumentSAXFunc as any ptr
type startElementSAXFunc as any ptr
type endElementSAXFunc as any ptr
type attributeSAXFunc as any ptr
type referenceSAXFunc as any ptr
type charactersSAXFunc as any ptr
type ignorableWhitespaceSAXFunc as any ptr
type processingInstructionSAXFunc as any ptr
type commentSAXFunc as any ptr
type cdataBlockSAXFunc as any ptr
type warningSAXFunc as any ptr
type errorSAXFunc as any ptr
type fatalErrorSAXFunc as any ptr
type isStandaloneSAXFunc as integer ptr
type hasInternalSubsetSAXFunc as integer ptr
type hasExternalSubsetSAXFunc as integer ptr

#define XML_SAX2_MAGIC &hDEEDBEAF

type startElementNsSAX2Func as any ptr
type endElementNsSAX2Func as any ptr

type _xmlSAXHandler
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
	initialized as uinteger
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
	initialized as uinteger
end type

type xmlExternalEntityLoader as xmlParserInputPtr ptr

#include once "encoding.bi"
#include once "xmlIO.bi"
#include once "globals.bi"

enum xmlParserOption
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
end enum

extern "c"
declare sub xmlInitParser ()
declare sub xmlCleanupParser ()
declare function xmlParserInputRead (byval in as xmlParserInputPtr, byval len as integer) as integer
declare function xmlParserInputGrow (byval in as xmlParserInputPtr, byval len as integer) as integer
declare function xmlParseDoc (byval cur as zstring ptr) as xmlDocPtr
declare function xmlParseFile (byval filename as zstring ptr) as xmlDocPtr
declare function xmlParseMemory (byval buffer as zstring ptr, byval size as integer) as xmlDocPtr
declare function xmlSubstituteEntitiesDefault (byval val as integer) as integer
declare function xmlKeepBlanksDefault (byval val as integer) as integer
declare sub xmlStopParser (byval ctxt as xmlParserCtxtPtr)
declare function xmlPedanticParserDefault (byval val as integer) as integer
declare function xmlLineNumbersDefault (byval val as integer) as integer
declare function xmlRecoverDoc (byval cur as zstring ptr) as xmlDocPtr
declare function xmlRecoverMemory (byval buffer as zstring ptr, byval size as integer) as xmlDocPtr
declare function xmlRecoverFile (byval filename as zstring ptr) as xmlDocPtr
declare function xmlParseDocument (byval ctxt as xmlParserCtxtPtr) as integer
declare function xmlParseExtParsedEnt (byval ctxt as xmlParserCtxtPtr) as integer
declare function xmlSAXUserParseFile (byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval filename as zstring ptr) as integer
declare function xmlSAXUserParseMemory (byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval buffer as zstring ptr, byval size as integer) as integer
declare function xmlSAXParseDoc (byval sax as xmlSAXHandlerPtr, byval cur as zstring ptr, byval recovery as integer) as xmlDocPtr
declare function xmlSAXParseMemory (byval sax as xmlSAXHandlerPtr, byval buffer as zstring ptr, byval size as integer, byval recovery as integer) as xmlDocPtr
declare function xmlSAXParseMemoryWithData (byval sax as xmlSAXHandlerPtr, byval buffer as zstring ptr, byval size as integer, byval recovery as integer, byval data as any ptr) as xmlDocPtr
declare function xmlSAXParseFile (byval sax as xmlSAXHandlerPtr, byval filename as zstring ptr, byval recovery as integer) as xmlDocPtr
declare function xmlSAXParseFileWithData (byval sax as xmlSAXHandlerPtr, byval filename as zstring ptr, byval recovery as integer, byval data as any ptr) as xmlDocPtr
declare function xmlSAXParseEntity (byval sax as xmlSAXHandlerPtr, byval filename as zstring ptr) as xmlDocPtr
declare function xmlParseEntity (byval filename as zstring ptr) as xmlDocPtr
declare function xmlSAXParseDTD (byval sax as xmlSAXHandlerPtr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr) as xmlDtdPtr
declare function xmlParseDTD (byval ExternalID as zstring ptr, byval SystemID as zstring ptr) as xmlDtdPtr
declare function xmlIOParseDTD (byval sax as xmlSAXHandlerPtr, byval input as xmlParserInputBufferPtr, byval enc as xmlCharEncoding) as xmlDtdPtr
declare function xmlParseBalancedChunkMemory (byval doc as xmlDocPtr, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval depth as integer, byval string as zstring ptr, byval lst as xmlNodePtr ptr) as integer
declare function xmlParseInNodeContext (byval node as xmlNodePtr, byval data as zstring ptr, byval datalen as integer, byval options as integer, byval lst as xmlNodePtr ptr) as xmlParserErrors
declare function xmlParseBalancedChunkMemoryRecover (byval doc as xmlDocPtr, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval depth as integer, byval string as zstring ptr, byval lst as xmlNodePtr ptr, byval recover as integer) as integer
declare function xmlParseExternalEntity (byval doc as xmlDocPtr, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval depth as integer, byval URL as zstring ptr, byval ID as zstring ptr, byval lst as xmlNodePtr ptr) as integer
declare function xmlParseCtxtExternalEntity (byval ctx as xmlParserCtxtPtr, byval URL as zstring ptr, byval ID as zstring ptr, byval lst as xmlNodePtr ptr) as integer
declare function xmlNewParserCtxt () as xmlParserCtxtPtr
declare function xmlInitParserCtxt (byval ctxt as xmlParserCtxtPtr) as integer
declare sub xmlClearParserCtxt (byval ctxt as xmlParserCtxtPtr)
declare sub xmlFreeParserCtxt (byval ctxt as xmlParserCtxtPtr)
declare sub xmlSetupParserForBuffer (byval ctxt as xmlParserCtxtPtr, byval buffer as zstring ptr, byval filename as zstring ptr)
declare function xmlCreateDocParserCtxt (byval cur as zstring ptr) as xmlParserCtxtPtr
declare function xmlGetFeaturesList (byval len as integer ptr, byval result as byte ptr ptr) as integer
declare function xmlGetFeature (byval ctxt as xmlParserCtxtPtr, byval name as zstring ptr, byval result as any ptr) as integer
declare function xmlSetFeature (byval ctxt as xmlParserCtxtPtr, byval name as zstring ptr, byval value as any ptr) as integer
declare function xmlCreatePushParserCtxt (byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval chunk as zstring ptr, byval size as integer, byval filename as zstring ptr) as xmlParserCtxtPtr
declare function xmlParseChunk (byval ctxt as xmlParserCtxtPtr, byval chunk as zstring ptr, byval size as integer, byval terminate as integer) as integer
declare function xmlCreateIOParserCtxt (byval sax as xmlSAXHandlerPtr, byval user_data as any ptr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval enc as xmlCharEncoding) as xmlParserCtxtPtr
declare function xmlNewIOInputStream (byval ctxt as xmlParserCtxtPtr, byval input as xmlParserInputBufferPtr, byval enc as xmlCharEncoding) as xmlParserInputPtr
declare function xmlParserFindNodeInfo (byval ctxt as xmlParserCtxtPtr, byval node as xmlNodePtr) as xmlParserNodeInfo ptr
declare sub xmlInitNodeInfoSeq (byval seq as xmlParserNodeInfoSeqPtr)
declare sub xmlClearNodeInfoSeq (byval seq as xmlParserNodeInfoSeqPtr)
declare function xmlParserFindNodeInfoIndex (byval seq as xmlParserNodeInfoSeqPtr, byval node as xmlNodePtr) as uinteger
declare sub xmlParserAddNodeInfo (byval ctxt as xmlParserCtxtPtr, byval info as xmlParserNodeInfoPtr)
declare sub xmlSetExternalEntityLoader (byval f as xmlExternalEntityLoader)
declare function xmlGetExternalEntityLoader () as xmlExternalEntityLoader
declare function xmlLoadExternalEntity (byval URL as zstring ptr, byval ID as zstring ptr, byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function xmlByteConsumed (byval ctxt as xmlParserCtxtPtr) as integer
declare sub xmlCtxtReset (byval ctxt as xmlParserCtxtPtr)
declare function xmlCtxtResetPush (byval ctxt as xmlParserCtxtPtr, byval chunk as zstring ptr, byval size as integer, byval filename as zstring ptr, byval encoding as zstring ptr) as integer
declare function xmlCtxtUseOptions (byval ctxt as xmlParserCtxtPtr, byval options as integer) as integer
declare function xmlReadDoc (byval cur as zstring ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlReadFile (byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlReadMemory (byval buffer as zstring ptr, byval size as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlReadFd (byval fd as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlReadIO (byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlCtxtReadDoc (byval ctxt as xmlParserCtxtPtr, byval cur as zstring ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlCtxtReadFile (byval ctxt as xmlParserCtxtPtr, byval filename as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlCtxtReadMemory (byval ctxt as xmlParserCtxtPtr, byval buffer as zstring ptr, byval size as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlCtxtReadFd (byval ctxt as xmlParserCtxtPtr, byval fd as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
declare function xmlCtxtReadIO (byval ctxt as xmlParserCtxtPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as xmlDocPtr
end extern

#endif
