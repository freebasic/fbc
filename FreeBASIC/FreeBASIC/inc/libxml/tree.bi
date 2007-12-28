''
''
'' tree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_tree_bi__
#define __xml_tree_bi__

#include once "xmlversion.bi"
#include once "xmlstring.bi"

type xmlParserInputBuffer as _xmlParserInputBuffer
type xmlParserInputBufferPtr as xmlParserInputBuffer ptr
type xmlOutputBuffer as _xmlOutputBuffer
type xmlOutputBufferPtr as xmlOutputBuffer ptr
type xmlParserInput as _xmlParserInput
type xmlParserInputPtr as xmlParserInput ptr
type xmlParserCtxt as _xmlParserCtxt
type xmlParserCtxtPtr as xmlParserCtxt ptr
type xmlSAXLocator as _xmlSAXLocator
type xmlSAXLocatorPtr as xmlSAXLocator ptr
type xmlSAXHandler as _xmlSAXHandler
type xmlSAXHandlerPtr as xmlSAXHandler ptr
type xmlEntity as _xmlEntity
type xmlEntityPtr as xmlEntity ptr
type xmlNode as _xmlNode
type xmlNodePtr as xmlNode ptr
type xmlNotation as _xmlNotation
type xmlNotationPtr as xmlNotation ptr
type xmlEnumeration as _xmlEnumeration
type xmlEnumerationPtr as xmlEnumeration ptr
type xmlAttribute as _xmlAttribute
type xmlAttributePtr as xmlAttribute ptr
type xmlElementContent as _xmlElementContent
type xmlElementContentPtr as xmlElementContent ptr
type xmlElement as _xmlElement
type xmlElementPtr as xmlElement ptr
type xmlNsType as xmlElementType
type xmlNs as _xmlNs
type xmlNsPtr as xmlNs ptr
type xmlDtd as _xmlDtd
type xmlDtdPtr as xmlDtd ptr
type xmlAttr as _xmlAttr
type xmlAttrPtr as xmlAttr ptr
type xmlID as _xmlID
type xmlIDPtr as xmlID ptr
type xmlRef as _xmlRef
type xmlRefPtr as xmlRef ptr
type xmlDoc as _xmlDoc
type xmlDocPtr as xmlDoc ptr
#ifndef xmlDict
type xmlDict as any
type xmlDictPtr as xmlDict ptr
#endif

#define BASE_BUFFER_SIZE 4096
#define XML_XML_NAMESPACE "http://www.w3.org/XML/1998/namespace"
#define XML_XML_ID "xml:id"

enum xmlElementType
	XML_ELEMENT_NODE = 1
	XML_ATTRIBUTE_NODE = 2
	XML_TEXT_NODE = 3
	XML_CDATA_SECTION_NODE = 4
	XML_ENTITY_REF_NODE = 5
	XML_ENTITY_NODE = 6
	XML_PI_NODE = 7
	XML_COMMENT_NODE = 8
	XML_DOCUMENT_NODE = 9
	XML_DOCUMENT_TYPE_NODE = 10
	XML_DOCUMENT_FRAG_NODE = 11
	XML_NOTATION_NODE = 12
	XML_HTML_DOCUMENT_NODE = 13
	XML_DTD_NODE = 14
	XML_ELEMENT_DECL = 15
	XML_ATTRIBUTE_DECL = 16
	XML_ENTITY_DECL = 17
	XML_NAMESPACE_DECL = 18
	XML_XINCLUDE_START = 19
	XML_XINCLUDE_END = 20
	XML_DOCB_DOCUMENT_NODE = 21
end enum

type _xmlNotation
	name as zstring ptr
	PublicID as zstring ptr
	SystemID as zstring ptr
end type

enum xmlAttributeType
	XML_ATTRIBUTE_CDATA = 1
	XML_ATTRIBUTE_ID
	XML_ATTRIBUTE_IDREF
	XML_ATTRIBUTE_IDREFS
	XML_ATTRIBUTE_ENTITY
	XML_ATTRIBUTE_ENTITIES
	XML_ATTRIBUTE_NMTOKEN
	XML_ATTRIBUTE_NMTOKENS
	XML_ATTRIBUTE_ENUMERATION
	XML_ATTRIBUTE_NOTATION
end enum


enum xmlAttributeDefault
	XML_ATTRIBUTE_NONE = 1
	XML_ATTRIBUTE_REQUIRED
	XML_ATTRIBUTE_IMPLIED
	XML_ATTRIBUTE_FIXED
end enum

type _xmlEnumeration
	next as _xmlEnumeration ptr
	name as zstring ptr
end type

type _xmlAttribute
	_private as any ptr
	type as xmlElementType
	name as zstring ptr
	children as xmlNode ptr
	last as xmlNode ptr
	parent as xmlDtd ptr
	next as xmlNode ptr
	prev as xmlNode ptr
	doc as xmlDoc ptr
	nexth as xmlAttribute ptr
	atype as xmlAttributeType
	def as xmlAttributeDefault
	defaultValue as zstring ptr
	tree as xmlEnumerationPtr
	prefix as zstring ptr
	elem as zstring ptr
end type

enum xmlElementContentType
	XML_ELEMENT_CONTENT_PCDATA = 1
	XML_ELEMENT_CONTENT_ELEMENT
	XML_ELEMENT_CONTENT_SEQ
	XML_ELEMENT_CONTENT_OR
end enum


enum xmlElementContentOccur
	XML_ELEMENT_CONTENT_ONCE = 1
	XML_ELEMENT_CONTENT_OPT
	XML_ELEMENT_CONTENT_MULT
	XML_ELEMENT_CONTENT_PLUS
end enum

type _xmlElementContent
	type as xmlElementContentType
	ocur as xmlElementContentOccur
	name as zstring ptr
	c1 as _xmlElementContent ptr
	c2 as _xmlElementContent ptr
	parent as _xmlElementContent ptr
	prefix as zstring ptr
end type

enum xmlElementTypeVal
	XML_ELEMENT_TYPE_UNDEFINED = 0
	XML_ELEMENT_TYPE_EMPTY = 1
	XML_ELEMENT_TYPE_ANY
	XML_ELEMENT_TYPE_MIXED
	XML_ELEMENT_TYPE_ELEMENT
end enum


#include once "xmlregexp.bi"

type _xmlElement
	_private as any ptr
	type as xmlElementType
	name as zstring ptr
	children as xmlNode ptr
	last as xmlNode ptr
	parent as xmlDtd ptr
	next as xmlNode ptr
	prev as xmlNode ptr
	doc as xmlDoc ptr
	etype as xmlElementTypeVal
	content as xmlElementContentPtr
	attributes as xmlAttributePtr
	prefix as zstring ptr
	contModel as xmlRegexpPtr
end type

type _xmlNs
	next as _xmlNs ptr
	type as xmlNsType
	href as zstring ptr
	prefix as zstring ptr
	_private as any ptr
end type

type _xmlDtd
	_private as any ptr
	type as xmlElementType
	name as zstring ptr
	children as xmlNode ptr
	last as xmlNode ptr
	parent as xmlDoc ptr
	next as xmlNode ptr
	prev as xmlNode ptr
	doc as xmlDoc ptr
	notations as any ptr
	elements as any ptr
	attributes as any ptr
	entities as any ptr
	ExternalID as zstring ptr
	SystemID as zstring ptr
	pentities as any ptr
end type

type _xmlAttr
	_private as any ptr
	type as xmlElementType
	name as zstring ptr
	children as xmlNode ptr
	last as xmlNode ptr
	parent as xmlNode ptr
	next as _xmlAttr ptr
	prev as _xmlAttr ptr
	doc as xmlDoc ptr
	ns as xmlNs ptr
	atype as xmlAttributeType
	psvi as any ptr
end type

type _xmlID
	next as _xmlID ptr
	value as zstring ptr
	attr as xmlAttrPtr
	name as zstring ptr
	lineno as integer
	doc as xmlDoc ptr
end type

type _xmlRef
	next as _xmlRef ptr
	value as zstring ptr
	attr as xmlAttrPtr
	name as zstring ptr
	lineno as integer
end type

enum xmlBufferAllocationScheme
	XML_BUFFER_ALLOC_DOUBLEIT
	XML_BUFFER_ALLOC_EXACT
	XML_BUFFER_ALLOC_IMMUTABLE
end enum

type xmlBuffer as _xmlBuffer
type xmlBufferPtr as xmlBuffer ptr

type _xmlBuffer
	content as zstring ptr
	use as uinteger
	size as uinteger
	alloc as xmlBufferAllocationScheme
end type

type _xmlNode
	_private as any ptr
	type as xmlElementType
	name as zstring ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlNode ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as xmlDoc ptr
	ns as xmlNs ptr
	content as zstring ptr
	properties as xmlAttr ptr
	nsDef as xmlNs ptr
	psvi as any ptr
	line as ushort
	extra as ushort
end type

type _xmlDoc
	_private as any ptr
	type as xmlElementType
	name as byte ptr
	children as xmlNode ptr
	last as xmlNode ptr
	parent as xmlNode ptr
	next as xmlNode ptr
	prev as xmlNode ptr
	doc as _xmlDoc ptr
	compression as integer
	standalone as integer
	intSubset as xmlDtd ptr
	extSubset as xmlDtd ptr
	oldNs as xmlNs ptr
	version as zstring ptr
	encoding as zstring ptr
	ids as any ptr
	refs as any ptr
	URL as zstring ptr
	charset as integer
	dict as xmlDict ptr
	psvi as any ptr
end type

extern "c"
declare function xmlValidateNCName (byval value as zstring ptr, byval space as integer) as integer
declare function xmlValidateQName (byval value as zstring ptr, byval space as integer) as integer
declare function xmlValidateName (byval value as zstring ptr, byval space as integer) as integer
declare function xmlValidateNMToken (byval value as zstring ptr, byval space as integer) as integer
declare function xmlBuildQName (byval ncname as zstring ptr, byval prefix as zstring ptr, byval memory as zstring ptr, byval len as integer) as zstring ptr
declare function xmlSplitQName2 (byval name as zstring ptr, byval prefix as zstring ptr ptr) as zstring ptr
declare function xmlSplitQName3 (byval name as zstring ptr, byval len as integer ptr) as zstring ptr
declare sub xmlSetBufferAllocationScheme (byval scheme as xmlBufferAllocationScheme)
declare function xmlGetBufferAllocationScheme () as xmlBufferAllocationScheme
declare function xmlBufferCreate () as xmlBufferPtr
declare function xmlBufferCreateSize (byval size as integer) as xmlBufferPtr
declare function xmlBufferCreateStatic (byval mem as any ptr, byval size as integer) as xmlBufferPtr
declare function xmlBufferResize (byval buf as xmlBufferPtr, byval size as uinteger) as integer
declare sub xmlBufferFree (byval buf as xmlBufferPtr)
declare function xmlBufferDump (byval file as FILE ptr, byval buf as xmlBufferPtr) as integer
declare function xmlBufferAdd (byval buf as xmlBufferPtr, byval str as zstring ptr, byval len as integer) as integer
declare function xmlBufferAddHead (byval buf as xmlBufferPtr, byval str as zstring ptr, byval len as integer) as integer
declare function xmlBufferCat (byval buf as xmlBufferPtr, byval str as zstring ptr) as integer
declare function xmlBufferCCat (byval buf as xmlBufferPtr, byval str as zstring ptr) as integer
declare function xmlBufferShrink (byval buf as xmlBufferPtr, byval len as uinteger) as integer
declare function xmlBufferGrow (byval buf as xmlBufferPtr, byval len as uinteger) as integer
declare sub xmlBufferEmpty (byval buf as xmlBufferPtr)
declare function xmlBufferContent (byval buf as xmlBufferPtr) as zstring ptr
declare sub xmlBufferSetAllocationScheme (byval buf as xmlBufferPtr, byval scheme as xmlBufferAllocationScheme)
declare function xmlBufferLength (byval buf as xmlBufferPtr) as integer
declare function xmlCreateIntSubset (byval doc as xmlDocPtr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr) as xmlDtdPtr
declare function xmlNewDtd (byval doc as xmlDocPtr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr) as xmlDtdPtr
declare function xmlGetIntSubset (byval doc as xmlDocPtr) as xmlDtdPtr
declare sub xmlFreeDtd (byval cur as xmlDtdPtr)
declare function xmlNewGlobalNs (byval doc as xmlDocPtr, byval href as zstring ptr, byval prefix as zstring ptr) as xmlNsPtr
declare function xmlNewNs (byval node as xmlNodePtr, byval href as zstring ptr, byval prefix as zstring ptr) as xmlNsPtr
declare sub xmlFreeNs (byval cur as xmlNsPtr)
declare sub xmlFreeNsList (byval cur as xmlNsPtr)
declare function xmlNewDoc (byval version as zstring ptr) as xmlDocPtr
declare sub xmlFreeDoc (byval cur as xmlDocPtr)
declare function xmlNewDocProp (byval doc as xmlDocPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlNewProp (byval node as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlNewNsProp (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlNewNsPropEatName (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare sub xmlFreePropList (byval cur as xmlAttrPtr)
declare sub xmlFreeProp (byval cur as xmlAttrPtr)
declare function xmlCopyProp (byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xmlCopyPropList (byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xmlCopyDtd (byval dtd as xmlDtdPtr) as xmlDtdPtr
declare function xmlCopyDoc (byval doc as xmlDocPtr, byval recursive as integer) as xmlDocPtr
declare function xmlNewDocNode (byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocNodeEatName (byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewNode (byval ns as xmlNsPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlNewNodeEatName (byval ns as xmlNsPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlNewChild (byval parent as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocText (byval doc as xmlDocPtr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewText (byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocPI (byval doc as xmlDocPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewPI (byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocTextLen (byval doc as xmlDocPtr, byval content as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNewTextLen (byval content as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNewDocComment (byval doc as xmlDocPtr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewComment (byval content as zstring ptr) as xmlNodePtr
declare function xmlNewCDataBlock (byval doc as xmlDocPtr, byval content as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNewCharRef (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlNewReference (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlCopyNode (byval node as xmlNodePtr, byval recursive as integer) as xmlNodePtr
declare function xmlDocCopyNode (byval node as xmlNodePtr, byval doc as xmlDocPtr, byval recursive as integer) as xmlNodePtr
declare function xmlDocCopyNodeList (byval doc as xmlDocPtr, byval node as xmlNodePtr) as xmlNodePtr
declare function xmlCopyNodeList (byval node as xmlNodePtr) as xmlNodePtr
declare function xmlNewTextChild (byval parent as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocRawNode (byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocFragment (byval doc as xmlDocPtr) as xmlNodePtr
declare function xmlGetLineNo (byval node as xmlNodePtr) as integer
declare function xmlGetNodePath (byval node as xmlNodePtr) as zstring ptr
declare function xmlDocGetRootElement (byval doc as xmlDocPtr) as xmlNodePtr
declare function xmlGetLastChild (byval parent as xmlNodePtr) as xmlNodePtr
declare function xmlNodeIsText (byval node as xmlNodePtr) as integer
declare function xmlIsBlankNode (byval node as xmlNodePtr) as integer
declare function xmlDocSetRootElement (byval doc as xmlDocPtr, byval root as xmlNodePtr) as xmlNodePtr
declare sub xmlNodeSetName (byval cur as xmlNodePtr, byval name as zstring ptr)
declare function xmlAddChild (byval parent as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlAddChildList (byval parent as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlReplaceNode (byval old as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlAddPrevSibling (byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare function xmlAddSibling (byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare function xmlAddNextSibling (byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare sub xmlUnlinkNode (byval cur as xmlNodePtr)
declare function xmlTextMerge (byval first as xmlNodePtr, byval second as xmlNodePtr) as xmlNodePtr
declare function xmlTextConcat (byval node as xmlNodePtr, byval content as zstring ptr, byval len as integer) as integer
declare sub xmlFreeNodeList (byval cur as xmlNodePtr)
declare sub xmlFreeNode (byval cur as xmlNodePtr)
declare sub xmlSetTreeDoc (byval tree as xmlNodePtr, byval doc as xmlDocPtr)
declare sub xmlSetListDoc (byval list as xmlNodePtr, byval doc as xmlDocPtr)
declare function xmlSearchNs (byval doc as xmlDocPtr, byval node as xmlNodePtr, byval nameSpace as zstring ptr) as xmlNsPtr
declare function xmlSearchNsByHref (byval doc as xmlDocPtr, byval node as xmlNodePtr, byval href as zstring ptr) as xmlNsPtr
declare function xmlGetNsList (byval doc as xmlDocPtr, byval node as xmlNodePtr) as xmlNsPtr ptr
declare sub xmlSetNs (byval node as xmlNodePtr, byval ns as xmlNsPtr)
declare function xmlCopyNamespace (byval cur as xmlNsPtr) as xmlNsPtr
declare function xmlCopyNamespaceList (byval cur as xmlNsPtr) as xmlNsPtr
declare function xmlSetProp (byval node as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlSetNsProp (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlGetNoNsProp (byval node as xmlNodePtr, byval name as zstring ptr) as zstring ptr
declare function xmlGetProp (byval node as xmlNodePtr, byval name as zstring ptr) as zstring ptr
declare function xmlHasProp (byval node as xmlNodePtr, byval name as zstring ptr) as xmlAttrPtr
declare function xmlHasNsProp (byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as xmlAttrPtr
declare function xmlGetNsProp (byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as zstring ptr
declare function xmlStringGetNodeList (byval doc as xmlDocPtr, byval value as zstring ptr) as xmlNodePtr
declare function xmlStringLenGetNodeList (byval doc as xmlDocPtr, byval value as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNodeListGetString (byval doc as xmlDocPtr, byval list as xmlNodePtr, byval inLine as integer) as zstring ptr
declare function xmlNodeListGetRawString (byval doc as xmlDocPtr, byval list as xmlNodePtr, byval inLine as integer) as zstring ptr
declare sub xmlNodeSetContent (byval cur as xmlNodePtr, byval content as zstring ptr)
declare sub xmlNodeSetContentLen (byval cur as xmlNodePtr, byval content as zstring ptr, byval len as integer)
declare sub xmlNodeAddContent (byval cur as xmlNodePtr, byval content as zstring ptr)
declare sub xmlNodeAddContentLen (byval cur as xmlNodePtr, byval content as zstring ptr, byval len as integer)
declare function xmlNodeGetContent (byval cur as xmlNodePtr) as zstring ptr
declare function xmlNodeBufGetContent (byval buffer as xmlBufferPtr, byval cur as xmlNodePtr) as integer
declare function xmlNodeGetLang (byval cur as xmlNodePtr) as zstring ptr
declare function xmlNodeGetSpacePreserve (byval cur as xmlNodePtr) as integer
declare sub xmlNodeSetLang (byval cur as xmlNodePtr, byval lang as zstring ptr)
declare sub xmlNodeSetSpacePreserve (byval cur as xmlNodePtr, byval val as integer)
declare function xmlNodeGetBase (byval doc as xmlDocPtr, byval cur as xmlNodePtr) as zstring ptr
declare sub xmlNodeSetBase (byval cur as xmlNodePtr, byval uri as zstring ptr)
declare function xmlRemoveProp (byval cur as xmlAttrPtr) as integer
declare function xmlUnsetNsProp (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr) as integer
declare function xmlUnsetProp (byval node as xmlNodePtr, byval name as zstring ptr) as integer
declare sub xmlBufferWriteCHAR (byval buf as xmlBufferPtr, byval string as zstring ptr)
''''''' declare sub xmlBufferWriteChar (byval buf as xmlBufferPtr, byval string as zstring ptr)
declare sub xmlBufferWriteQuotedString (byval buf as xmlBufferPtr, byval string as zstring ptr)
declare sub xmlAttrSerializeTxtContent (byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval attr as xmlAttrPtr, byval string as zstring ptr)
declare function xmlReconciliateNs (byval doc as xmlDocPtr, byval tree as xmlNodePtr) as integer
declare sub xmlDocDumpFormatMemory (byval cur as xmlDocPtr, byval mem as zstring ptr ptr, byval size as integer ptr, byval format as integer)
declare sub xmlDocDumpMemory (byval cur as xmlDocPtr, byval mem as zstring ptr ptr, byval size as integer ptr)
declare sub xmlDocDumpMemoryEnc (byval out_doc as xmlDocPtr, byval doc_txt_ptr as zstring ptr ptr, byval doc_txt_len as integer ptr, byval txt_encoding as zstring ptr)
declare sub xmlDocDumpFormatMemoryEnc (byval out_doc as xmlDocPtr, byval doc_txt_ptr as zstring ptr ptr, byval doc_txt_len as integer ptr, byval txt_encoding as zstring ptr, byval format as integer)
declare function xmlDocFormatDump (byval f as FILE ptr, byval cur as xmlDocPtr, byval format as integer) as integer
declare function xmlDocDump (byval f as FILE ptr, byval cur as xmlDocPtr) as integer
declare sub xmlElemDump (byval f as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr)
declare function xmlSaveFile (byval filename as zstring ptr, byval cur as xmlDocPtr) as integer
declare function xmlSaveFormatFile (byval filename as zstring ptr, byval cur as xmlDocPtr, byval format as integer) as integer
declare function xmlNodeDump (byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as integer, byval format as integer) as integer
declare function xmlSaveFileTo (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as zstring ptr) as integer
declare function xmlSaveFormatFileTo (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as zstring ptr, byval format as integer) as integer
declare sub xmlNodeDumpOutput (byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as integer, byval format as integer, byval encoding as zstring ptr)
declare function xmlSaveFormatFileEnc (byval filename as zstring ptr, byval cur as xmlDocPtr, byval encoding as zstring ptr, byval format as integer) as integer
declare function xmlSaveFileEnc (byval filename as zstring ptr, byval cur as xmlDocPtr, byval encoding as zstring ptr) as integer
declare function xmlIsXHTML (byval systemID as zstring ptr, byval publicID as zstring ptr) as integer
declare function xmlGetDocCompressMode (byval doc as xmlDocPtr) as integer
declare sub xmlSetDocCompressMode (byval doc as xmlDocPtr, byval mode as integer)
declare function xmlGetCompressMode () as integer
declare sub xmlSetCompressMode (byval mode as integer)
end extern

#include once "xmlmemory.bi"

#endif
