''
''
'' tree -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __tree_bi__
#define __tree_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlstring.bi"

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


#include once "libxml/xmlregexp.bi"

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

declare function xmlValidateNCName cdecl alias "xmlValidateNCName" (byval value as zstring ptr, byval space as integer) as integer
declare function xmlValidateQName cdecl alias "xmlValidateQName" (byval value as zstring ptr, byval space as integer) as integer
declare function xmlValidateName cdecl alias "xmlValidateName" (byval value as zstring ptr, byval space as integer) as integer
declare function xmlValidateNMToken cdecl alias "xmlValidateNMToken" (byval value as zstring ptr, byval space as integer) as integer
declare function xmlBuildQName cdecl alias "xmlBuildQName" (byval ncname as zstring ptr, byval prefix as zstring ptr, byval memory as zstring ptr, byval len as integer) as zstring ptr
declare function xmlSplitQName2 cdecl alias "xmlSplitQName2" (byval name as zstring ptr, byval prefix as zstring ptr ptr) as zstring ptr
declare function xmlSplitQName3 cdecl alias "xmlSplitQName3" (byval name as zstring ptr, byval len as integer ptr) as zstring ptr
declare sub xmlSetBufferAllocationScheme cdecl alias "xmlSetBufferAllocationScheme" (byval scheme as xmlBufferAllocationScheme)
declare function xmlGetBufferAllocationScheme cdecl alias "xmlGetBufferAllocationScheme" () as xmlBufferAllocationScheme
declare function xmlBufferCreate cdecl alias "xmlBufferCreate" () as xmlBufferPtr
declare function xmlBufferCreateSize cdecl alias "xmlBufferCreateSize" (byval size as integer) as xmlBufferPtr
declare function xmlBufferCreateStatic cdecl alias "xmlBufferCreateStatic" (byval mem as any ptr, byval size as integer) as xmlBufferPtr
declare function xmlBufferResize cdecl alias "xmlBufferResize" (byval buf as xmlBufferPtr, byval size as uinteger) as integer
declare sub xmlBufferFree cdecl alias "xmlBufferFree" (byval buf as xmlBufferPtr)
declare function xmlBufferDump cdecl alias "xmlBufferDump" (byval file as FILE ptr, byval buf as xmlBufferPtr) as integer
declare function xmlBufferAdd cdecl alias "xmlBufferAdd" (byval buf as xmlBufferPtr, byval str as zstring ptr, byval len as integer) as integer
declare function xmlBufferAddHead cdecl alias "xmlBufferAddHead" (byval buf as xmlBufferPtr, byval str as zstring ptr, byval len as integer) as integer
declare function xmlBufferCat cdecl alias "xmlBufferCat" (byval buf as xmlBufferPtr, byval str as zstring ptr) as integer
declare function xmlBufferCCat cdecl alias "xmlBufferCCat" (byval buf as xmlBufferPtr, byval str as zstring ptr) as integer
declare function xmlBufferShrink cdecl alias "xmlBufferShrink" (byval buf as xmlBufferPtr, byval len as uinteger) as integer
declare function xmlBufferGrow cdecl alias "xmlBufferGrow" (byval buf as xmlBufferPtr, byval len as uinteger) as integer
declare sub xmlBufferEmpty cdecl alias "xmlBufferEmpty" (byval buf as xmlBufferPtr)
declare function xmlBufferContent cdecl alias "xmlBufferContent" (byval buf as xmlBufferPtr) as zstring ptr
declare sub xmlBufferSetAllocationScheme cdecl alias "xmlBufferSetAllocationScheme" (byval buf as xmlBufferPtr, byval scheme as xmlBufferAllocationScheme)
declare function xmlBufferLength cdecl alias "xmlBufferLength" (byval buf as xmlBufferPtr) as integer
declare function xmlCreateIntSubset cdecl alias "xmlCreateIntSubset" (byval doc as xmlDocPtr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr) as xmlDtdPtr
declare function xmlNewDtd cdecl alias "xmlNewDtd" (byval doc as xmlDocPtr, byval name as zstring ptr, byval ExternalID as zstring ptr, byval SystemID as zstring ptr) as xmlDtdPtr
declare function xmlGetIntSubset cdecl alias "xmlGetIntSubset" (byval doc as xmlDocPtr) as xmlDtdPtr
declare sub xmlFreeDtd cdecl alias "xmlFreeDtd" (byval cur as xmlDtdPtr)
declare function xmlNewGlobalNs cdecl alias "xmlNewGlobalNs" (byval doc as xmlDocPtr, byval href as zstring ptr, byval prefix as zstring ptr) as xmlNsPtr
declare function xmlNewNs cdecl alias "xmlNewNs" (byval node as xmlNodePtr, byval href as zstring ptr, byval prefix as zstring ptr) as xmlNsPtr
declare sub xmlFreeNs cdecl alias "xmlFreeNs" (byval cur as xmlNsPtr)
declare sub xmlFreeNsList cdecl alias "xmlFreeNsList" (byval cur as xmlNsPtr)
declare function xmlNewDoc cdecl alias "xmlNewDoc" (byval version as zstring ptr) as xmlDocPtr
declare sub xmlFreeDoc cdecl alias "xmlFreeDoc" (byval cur as xmlDocPtr)
declare function xmlNewDocProp cdecl alias "xmlNewDocProp" (byval doc as xmlDocPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlNewProp cdecl alias "xmlNewProp" (byval node as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlNewNsProp cdecl alias "xmlNewNsProp" (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlNewNsPropEatName cdecl alias "xmlNewNsPropEatName" (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare sub xmlFreePropList cdecl alias "xmlFreePropList" (byval cur as xmlAttrPtr)
declare sub xmlFreeProp cdecl alias "xmlFreeProp" (byval cur as xmlAttrPtr)
declare function xmlCopyProp cdecl alias "xmlCopyProp" (byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xmlCopyPropList cdecl alias "xmlCopyPropList" (byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xmlCopyDtd cdecl alias "xmlCopyDtd" (byval dtd as xmlDtdPtr) as xmlDtdPtr
declare function xmlCopyDoc cdecl alias "xmlCopyDoc" (byval doc as xmlDocPtr, byval recursive as integer) as xmlDocPtr
declare function xmlNewDocNode cdecl alias "xmlNewDocNode" (byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocNodeEatName cdecl alias "xmlNewDocNodeEatName" (byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewNode cdecl alias "xmlNewNode" (byval ns as xmlNsPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlNewNodeEatName cdecl alias "xmlNewNodeEatName" (byval ns as xmlNsPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlNewChild cdecl alias "xmlNewChild" (byval parent as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocText cdecl alias "xmlNewDocText" (byval doc as xmlDocPtr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewText cdecl alias "xmlNewText" (byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocPI cdecl alias "xmlNewDocPI" (byval doc as xmlDocPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewPI cdecl alias "xmlNewPI" (byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocTextLen cdecl alias "xmlNewDocTextLen" (byval doc as xmlDocPtr, byval content as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNewTextLen cdecl alias "xmlNewTextLen" (byval content as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNewDocComment cdecl alias "xmlNewDocComment" (byval doc as xmlDocPtr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewComment cdecl alias "xmlNewComment" (byval content as zstring ptr) as xmlNodePtr
declare function xmlNewCDataBlock cdecl alias "xmlNewCDataBlock" (byval doc as xmlDocPtr, byval content as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNewCharRef cdecl alias "xmlNewCharRef" (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlNewReference cdecl alias "xmlNewReference" (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlNodePtr
declare function xmlCopyNode cdecl alias "xmlCopyNode" (byval node as xmlNodePtr, byval recursive as integer) as xmlNodePtr
declare function xmlDocCopyNode cdecl alias "xmlDocCopyNode" (byval node as xmlNodePtr, byval doc as xmlDocPtr, byval recursive as integer) as xmlNodePtr
declare function xmlDocCopyNodeList cdecl alias "xmlDocCopyNodeList" (byval doc as xmlDocPtr, byval node as xmlNodePtr) as xmlNodePtr
declare function xmlCopyNodeList cdecl alias "xmlCopyNodeList" (byval node as xmlNodePtr) as xmlNodePtr
declare function xmlNewTextChild cdecl alias "xmlNewTextChild" (byval parent as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocRawNode cdecl alias "xmlNewDocRawNode" (byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval content as zstring ptr) as xmlNodePtr
declare function xmlNewDocFragment cdecl alias "xmlNewDocFragment" (byval doc as xmlDocPtr) as xmlNodePtr
declare function xmlGetLineNo cdecl alias "xmlGetLineNo" (byval node as xmlNodePtr) as integer
declare function xmlGetNodePath cdecl alias "xmlGetNodePath" (byval node as xmlNodePtr) as zstring ptr
declare function xmlDocGetRootElement cdecl alias "xmlDocGetRootElement" (byval doc as xmlDocPtr) as xmlNodePtr
declare function xmlGetLastChild cdecl alias "xmlGetLastChild" (byval parent as xmlNodePtr) as xmlNodePtr
declare function xmlNodeIsText cdecl alias "xmlNodeIsText" (byval node as xmlNodePtr) as integer
declare function xmlIsBlankNode cdecl alias "xmlIsBlankNode" (byval node as xmlNodePtr) as integer
declare function xmlDocSetRootElement cdecl alias "xmlDocSetRootElement" (byval doc as xmlDocPtr, byval root as xmlNodePtr) as xmlNodePtr
declare sub xmlNodeSetName cdecl alias "xmlNodeSetName" (byval cur as xmlNodePtr, byval name as zstring ptr)
declare function xmlAddChild cdecl alias "xmlAddChild" (byval parent as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlAddChildList cdecl alias "xmlAddChildList" (byval parent as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlReplaceNode cdecl alias "xmlReplaceNode" (byval old as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlAddPrevSibling cdecl alias "xmlAddPrevSibling" (byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare function xmlAddSibling cdecl alias "xmlAddSibling" (byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare function xmlAddNextSibling cdecl alias "xmlAddNextSibling" (byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare sub xmlUnlinkNode cdecl alias "xmlUnlinkNode" (byval cur as xmlNodePtr)
declare function xmlTextMerge cdecl alias "xmlTextMerge" (byval first as xmlNodePtr, byval second as xmlNodePtr) as xmlNodePtr
declare function xmlTextConcat cdecl alias "xmlTextConcat" (byval node as xmlNodePtr, byval content as zstring ptr, byval len as integer) as integer
declare sub xmlFreeNodeList cdecl alias "xmlFreeNodeList" (byval cur as xmlNodePtr)
declare sub xmlFreeNode cdecl alias "xmlFreeNode" (byval cur as xmlNodePtr)
declare sub xmlSetTreeDoc cdecl alias "xmlSetTreeDoc" (byval tree as xmlNodePtr, byval doc as xmlDocPtr)
declare sub xmlSetListDoc cdecl alias "xmlSetListDoc" (byval list as xmlNodePtr, byval doc as xmlDocPtr)
declare function xmlSearchNs cdecl alias "xmlSearchNs" (byval doc as xmlDocPtr, byval node as xmlNodePtr, byval nameSpace as zstring ptr) as xmlNsPtr
declare function xmlSearchNsByHref cdecl alias "xmlSearchNsByHref" (byval doc as xmlDocPtr, byval node as xmlNodePtr, byval href as zstring ptr) as xmlNsPtr
declare function xmlGetNsList cdecl alias "xmlGetNsList" (byval doc as xmlDocPtr, byval node as xmlNodePtr) as xmlNsPtr ptr
declare sub xmlSetNs cdecl alias "xmlSetNs" (byval node as xmlNodePtr, byval ns as xmlNsPtr)
declare function xmlCopyNamespace cdecl alias "xmlCopyNamespace" (byval cur as xmlNsPtr) as xmlNsPtr
declare function xmlCopyNamespaceList cdecl alias "xmlCopyNamespaceList" (byval cur as xmlNsPtr) as xmlNsPtr
declare function xmlSetProp cdecl alias "xmlSetProp" (byval node as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlSetNsProp cdecl alias "xmlSetNsProp" (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr, byval value as zstring ptr) as xmlAttrPtr
declare function xmlGetNoNsProp cdecl alias "xmlGetNoNsProp" (byval node as xmlNodePtr, byval name as zstring ptr) as zstring ptr
declare function xmlGetProp cdecl alias "xmlGetProp" (byval node as xmlNodePtr, byval name as zstring ptr) as zstring ptr
declare function xmlHasProp cdecl alias "xmlHasProp" (byval node as xmlNodePtr, byval name as zstring ptr) as xmlAttrPtr
declare function xmlHasNsProp cdecl alias "xmlHasNsProp" (byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as xmlAttrPtr
declare function xmlGetNsProp cdecl alias "xmlGetNsProp" (byval node as xmlNodePtr, byval name as zstring ptr, byval nameSpace as zstring ptr) as zstring ptr
declare function xmlStringGetNodeList cdecl alias "xmlStringGetNodeList" (byval doc as xmlDocPtr, byval value as zstring ptr) as xmlNodePtr
declare function xmlStringLenGetNodeList cdecl alias "xmlStringLenGetNodeList" (byval doc as xmlDocPtr, byval value as zstring ptr, byval len as integer) as xmlNodePtr
declare function xmlNodeListGetString cdecl alias "xmlNodeListGetString" (byval doc as xmlDocPtr, byval list as xmlNodePtr, byval inLine as integer) as zstring ptr
declare function xmlNodeListGetRawString cdecl alias "xmlNodeListGetRawString" (byval doc as xmlDocPtr, byval list as xmlNodePtr, byval inLine as integer) as zstring ptr
declare sub xmlNodeSetContent cdecl alias "xmlNodeSetContent" (byval cur as xmlNodePtr, byval content as zstring ptr)
declare sub xmlNodeSetContentLen cdecl alias "xmlNodeSetContentLen" (byval cur as xmlNodePtr, byval content as zstring ptr, byval len as integer)
declare sub xmlNodeAddContent cdecl alias "xmlNodeAddContent" (byval cur as xmlNodePtr, byval content as zstring ptr)
declare sub xmlNodeAddContentLen cdecl alias "xmlNodeAddContentLen" (byval cur as xmlNodePtr, byval content as zstring ptr, byval len as integer)
declare function xmlNodeGetContent cdecl alias "xmlNodeGetContent" (byval cur as xmlNodePtr) as zstring ptr
declare function xmlNodeBufGetContent cdecl alias "xmlNodeBufGetContent" (byval buffer as xmlBufferPtr, byval cur as xmlNodePtr) as integer
declare function xmlNodeGetLang cdecl alias "xmlNodeGetLang" (byval cur as xmlNodePtr) as zstring ptr
declare function xmlNodeGetSpacePreserve cdecl alias "xmlNodeGetSpacePreserve" (byval cur as xmlNodePtr) as integer
declare sub xmlNodeSetLang cdecl alias "xmlNodeSetLang" (byval cur as xmlNodePtr, byval lang as zstring ptr)
declare sub xmlNodeSetSpacePreserve cdecl alias "xmlNodeSetSpacePreserve" (byval cur as xmlNodePtr, byval val as integer)
declare function xmlNodeGetBase cdecl alias "xmlNodeGetBase" (byval doc as xmlDocPtr, byval cur as xmlNodePtr) as zstring ptr
declare sub xmlNodeSetBase cdecl alias "xmlNodeSetBase" (byval cur as xmlNodePtr, byval uri as zstring ptr)
declare function xmlRemoveProp cdecl alias "xmlRemoveProp" (byval cur as xmlAttrPtr) as integer
declare function xmlUnsetNsProp cdecl alias "xmlUnsetNsProp" (byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as zstring ptr) as integer
declare function xmlUnsetProp cdecl alias "xmlUnsetProp" (byval node as xmlNodePtr, byval name as zstring ptr) as integer
declare sub xmlBufferWriteCHAR cdecl alias "xmlBufferWriteCHAR" (byval buf as xmlBufferPtr, byval string as zstring ptr)
''''''' declare sub xmlBufferWriteChar cdecl alias "xmlBufferWriteChar" (byval buf as xmlBufferPtr, byval string as zstring ptr)
declare sub xmlBufferWriteQuotedString cdecl alias "xmlBufferWriteQuotedString" (byval buf as xmlBufferPtr, byval string as zstring ptr)
declare sub xmlAttrSerializeTxtContent cdecl alias "xmlAttrSerializeTxtContent" (byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval attr as xmlAttrPtr, byval string as zstring ptr)
declare function xmlReconciliateNs cdecl alias "xmlReconciliateNs" (byval doc as xmlDocPtr, byval tree as xmlNodePtr) as integer
declare sub xmlDocDumpFormatMemory cdecl alias "xmlDocDumpFormatMemory" (byval cur as xmlDocPtr, byval mem as zstring ptr ptr, byval size as integer ptr, byval format as integer)
declare sub xmlDocDumpMemory cdecl alias "xmlDocDumpMemory" (byval cur as xmlDocPtr, byval mem as zstring ptr ptr, byval size as integer ptr)
declare sub xmlDocDumpMemoryEnc cdecl alias "xmlDocDumpMemoryEnc" (byval out_doc as xmlDocPtr, byval doc_txt_ptr as zstring ptr ptr, byval doc_txt_len as integer ptr, byval txt_encoding as zstring ptr)
declare sub xmlDocDumpFormatMemoryEnc cdecl alias "xmlDocDumpFormatMemoryEnc" (byval out_doc as xmlDocPtr, byval doc_txt_ptr as zstring ptr ptr, byval doc_txt_len as integer ptr, byval txt_encoding as zstring ptr, byval format as integer)
declare function xmlDocFormatDump cdecl alias "xmlDocFormatDump" (byval f as FILE ptr, byval cur as xmlDocPtr, byval format as integer) as integer
declare function xmlDocDump cdecl alias "xmlDocDump" (byval f as FILE ptr, byval cur as xmlDocPtr) as integer
declare sub xmlElemDump cdecl alias "xmlElemDump" (byval f as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr)
declare function xmlSaveFile cdecl alias "xmlSaveFile" (byval filename as zstring ptr, byval cur as xmlDocPtr) as integer
declare function xmlSaveFormatFile cdecl alias "xmlSaveFormatFile" (byval filename as zstring ptr, byval cur as xmlDocPtr, byval format as integer) as integer
declare function xmlNodeDump cdecl alias "xmlNodeDump" (byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as integer, byval format as integer) as integer
declare function xmlSaveFileTo cdecl alias "xmlSaveFileTo" (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as zstring ptr) as integer
declare function xmlSaveFormatFileTo cdecl alias "xmlSaveFormatFileTo" (byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as zstring ptr, byval format as integer) as integer
declare sub xmlNodeDumpOutput cdecl alias "xmlNodeDumpOutput" (byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as integer, byval format as integer, byval encoding as zstring ptr)
declare function xmlSaveFormatFileEnc cdecl alias "xmlSaveFormatFileEnc" (byval filename as zstring ptr, byval cur as xmlDocPtr, byval encoding as zstring ptr, byval format as integer) as integer
declare function xmlSaveFileEnc cdecl alias "xmlSaveFileEnc" (byval filename as zstring ptr, byval cur as xmlDocPtr, byval encoding as zstring ptr) as integer
declare function xmlIsXHTML cdecl alias "xmlIsXHTML" (byval systemID as zstring ptr, byval publicID as zstring ptr) as integer
declare function xmlGetDocCompressMode cdecl alias "xmlGetDocCompressMode" (byval doc as xmlDocPtr) as integer
declare sub xmlSetDocCompressMode cdecl alias "xmlSetDocCompressMode" (byval doc as xmlDocPtr, byval mode as integer)
declare function xmlGetCompressMode cdecl alias "xmlGetCompressMode" () as integer
declare sub xmlSetCompressMode cdecl alias "xmlSetCompressMode" (byval mode as integer)

#include once "libxml/xmlmemory.bi"

#endif
