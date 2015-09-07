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
#include once "crt/stdio.bi"
#include once "crt/limits.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/xmlstring.bi"

'' The following symbols have been renamed:
''     procedure xmlBufferWriteChar => xmlBufferWriteChar_

extern "C"

#define __XML_TREE_H__
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
type _xmlSAXHandler as _xmlSAXHandler_
type xmlSAXHandler as _xmlSAXHandler
type xmlSAXHandlerPtr as xmlSAXHandler ptr
type xmlEntity as _xmlEntity
type xmlEntityPtr as xmlEntity ptr
const BASE_BUFFER_SIZE = 4096

type xmlBufferAllocationScheme as long
enum
	XML_BUFFER_ALLOC_DOUBLEIT
	XML_BUFFER_ALLOC_EXACT
	XML_BUFFER_ALLOC_IMMUTABLE
	XML_BUFFER_ALLOC_IO
	XML_BUFFER_ALLOC_HYBRID
end enum

type xmlBuffer as _xmlBuffer
type xmlBufferPtr as xmlBuffer ptr

type _xmlBuffer
	content as xmlChar ptr
	use as ulong
	size as ulong
	alloc as xmlBufferAllocationScheme
	contentIO as xmlChar ptr
end type

type xmlBuf as _xmlBuf
type xmlBufPtr as xmlBuf ptr
declare function xmlBufContent(byval buf as const xmlBuf ptr) as xmlChar ptr
declare function xmlBufEnd(byval buf as xmlBufPtr) as xmlChar ptr
declare function xmlBufUse(byval buf as const xmlBufPtr) as uinteger
declare function xmlBufShrink(byval buf as xmlBufPtr, byval len as uinteger) as uinteger

#define LIBXML2_NEW_BUFFER
#define XML_XML_NAMESPACE cptr(const xmlChar ptr, @"http://www.w3.org/XML/1998/namespace")
#define XML_XML_ID cptr(const xmlChar ptr, @"xml:id")

type xmlElementType as long
enum
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

type xmlNotation as _xmlNotation
type xmlNotationPtr as xmlNotation ptr

type _xmlNotation
	name as const xmlChar ptr
	PublicID as const xmlChar ptr
	SystemID as const xmlChar ptr
end type

type xmlAttributeType as long
enum
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

type xmlAttributeDefault as long
enum
	XML_ATTRIBUTE_NONE = 1
	XML_ATTRIBUTE_REQUIRED
	XML_ATTRIBUTE_IMPLIED
	XML_ATTRIBUTE_FIXED
end enum

type xmlEnumeration as _xmlEnumeration
type xmlEnumerationPtr as xmlEnumeration ptr

type _xmlEnumeration
	next as _xmlEnumeration ptr
	name as const xmlChar ptr
end type

type xmlAttribute as _xmlAttribute
type xmlAttributePtr as xmlAttribute ptr
type _xmlNode as _xmlNode_
type _xmlDtd as _xmlDtd_
type _xmlDoc as _xmlDoc_

type _xmlAttribute
	_private as any ptr
	as xmlElementType type
	name as const xmlChar ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlDtd ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	nexth as _xmlAttribute ptr
	atype as xmlAttributeType
	def as xmlAttributeDefault
	defaultValue as const xmlChar ptr
	tree as xmlEnumerationPtr
	prefix as const xmlChar ptr
	elem as const xmlChar ptr
end type

type xmlElementContentType as long
enum
	XML_ELEMENT_CONTENT_PCDATA = 1
	XML_ELEMENT_CONTENT_ELEMENT
	XML_ELEMENT_CONTENT_SEQ
	XML_ELEMENT_CONTENT_OR
end enum

type xmlElementContentOccur as long
enum
	XML_ELEMENT_CONTENT_ONCE = 1
	XML_ELEMENT_CONTENT_OPT
	XML_ELEMENT_CONTENT_MULT
	XML_ELEMENT_CONTENT_PLUS
end enum

type xmlElementContent as _xmlElementContent
type xmlElementContentPtr as xmlElementContent ptr

type _xmlElementContent
	as xmlElementContentType type
	ocur as xmlElementContentOccur
	name as const xmlChar ptr
	c1 as _xmlElementContent ptr
	c2 as _xmlElementContent ptr
	parent as _xmlElementContent ptr
	prefix as const xmlChar ptr
end type

type xmlElementTypeVal as long
enum
	XML_ELEMENT_TYPE_UNDEFINED = 0
	XML_ELEMENT_TYPE_EMPTY = 1
	XML_ELEMENT_TYPE_ANY
	XML_ELEMENT_TYPE_MIXED
	XML_ELEMENT_TYPE_ELEMENT
end enum

end extern

#include once "libxml/xmlregexp.bi"

extern "C"

type xmlElement as _xmlElement
type xmlElementPtr as xmlElement ptr

type _xmlElement
	_private as any ptr
	as xmlElementType type
	name as const xmlChar ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlDtd ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	etype as xmlElementTypeVal
	content as xmlElementContentPtr
	attributes as xmlAttributePtr
	prefix as const xmlChar ptr
	contModel as xmlRegexpPtr
end type

const XML_LOCAL_NAMESPACE = XML_NAMESPACE_DECL
type xmlNsType as xmlElementType
type xmlNs as _xmlNs
type xmlNsPtr as xmlNs ptr

type _xmlNs
	next as _xmlNs ptr
	as xmlNsType type
	href as const xmlChar ptr
	prefix as const xmlChar ptr
	_private as any ptr
	context as _xmlDoc ptr
end type

type xmlDtd as _xmlDtd
type xmlDtdPtr as xmlDtd ptr

type _xmlDtd_
	_private as any ptr
	as xmlElementType type
	name as const xmlChar ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlDoc ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	notations as any ptr
	elements as any ptr
	attributes as any ptr
	entities as any ptr
	ExternalID as const xmlChar ptr
	SystemID as const xmlChar ptr
	pentities as any ptr
end type

type xmlAttr as _xmlAttr
type xmlAttrPtr as xmlAttr ptr

type _xmlAttr
	_private as any ptr
	as xmlElementType type
	name as const xmlChar ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlNode ptr
	next as _xmlAttr ptr
	prev as _xmlAttr ptr
	doc as _xmlDoc ptr
	ns as xmlNs ptr
	atype as xmlAttributeType
	psvi as any ptr
end type

type xmlID as _xmlID
type xmlIDPtr as xmlID ptr

type _xmlID
	next as _xmlID ptr
	value as const xmlChar ptr
	attr as xmlAttrPtr
	name as const xmlChar ptr
	lineno as long
	doc as _xmlDoc ptr
end type

type xmlRef as _xmlRef
type xmlRefPtr as xmlRef ptr

type _xmlRef
	next as _xmlRef ptr
	value as const xmlChar ptr
	attr as xmlAttrPtr
	name as const xmlChar ptr
	lineno as long
end type

type xmlNode as _xmlNode
type xmlNodePtr as xmlNode ptr

type _xmlNode_
	_private as any ptr
	as xmlElementType type
	name as const xmlChar ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlNode ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	ns as xmlNs ptr
	content as xmlChar ptr
	properties as _xmlAttr ptr
	nsDef as xmlNs ptr
	psvi as any ptr
	line as ushort
	extra as ushort
end type

#define XML_GET_CONTENT(n) iif((n)->type = XML_ELEMENT_NODE, NULL, (n)->content)
#define XML_GET_LINE(n) xmlGetLineNo(n)

type xmlDocProperties as long
enum
	XML_DOC_WELLFORMED = 1 shl 0
	XML_DOC_NSVALID = 1 shl 1
	XML_DOC_OLD10 = 1 shl 2
	XML_DOC_DTDVALID = 1 shl 3
	XML_DOC_XINCLUDE = 1 shl 4
	XML_DOC_USERBUILT = 1 shl 5
	XML_DOC_INTERNAL = 1 shl 6
	XML_DOC_HTML = 1 shl 7
end enum

type xmlDoc as _xmlDoc
type xmlDocPtr as xmlDoc ptr

type _xmlDoc_
	_private as any ptr
	as xmlElementType type
	name as zstring ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlNode ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	compression as long
	standalone as long
	intSubset as _xmlDtd ptr
	extSubset as _xmlDtd ptr
	oldNs as _xmlNs ptr
	version as const xmlChar ptr
	encoding as const xmlChar ptr
	ids as any ptr
	refs as any ptr
	URL as const xmlChar ptr
	charset as long
	dict as xmlDict ptr
	psvi as any ptr
	parseFlags as long
	properties as long
end type

type xmlDOMWrapCtxt as _xmlDOMWrapCtxt
type xmlDOMWrapCtxtPtr as xmlDOMWrapCtxt ptr
type xmlDOMWrapAcquireNsFunction as function(byval ctxt as xmlDOMWrapCtxtPtr, byval node as xmlNodePtr, byval nsName as const xmlChar ptr, byval nsPrefix as const xmlChar ptr) as xmlNsPtr

type _xmlDOMWrapCtxt
	_private as any ptr
	as long type
	namespaceMap as any ptr
	getNsForNodeFunc as xmlDOMWrapAcquireNsFunction
end type

#define xmlChildrenNode children
#define xmlRootNode children
declare function xmlValidateNCName(byval value as const xmlChar ptr, byval space as long) as long
declare function xmlValidateQName(byval value as const xmlChar ptr, byval space as long) as long
declare function xmlValidateName(byval value as const xmlChar ptr, byval space as long) as long
declare function xmlValidateNMToken(byval value as const xmlChar ptr, byval space as long) as long
declare function xmlBuildQName(byval ncname as const xmlChar ptr, byval prefix as const xmlChar ptr, byval memory as xmlChar ptr, byval len as long) as xmlChar ptr
declare function xmlSplitQName2(byval name as const xmlChar ptr, byval prefix as xmlChar ptr ptr) as xmlChar ptr
declare function xmlSplitQName3(byval name as const xmlChar ptr, byval len as long ptr) as const xmlChar ptr
declare sub xmlSetBufferAllocationScheme(byval scheme as xmlBufferAllocationScheme)
declare function xmlGetBufferAllocationScheme() as xmlBufferAllocationScheme
declare function xmlBufferCreate() as xmlBufferPtr
declare function xmlBufferCreateSize(byval size as uinteger) as xmlBufferPtr
declare function xmlBufferCreateStatic(byval mem as any ptr, byval size as uinteger) as xmlBufferPtr
declare function xmlBufferResize(byval buf as xmlBufferPtr, byval size as ulong) as long
declare sub xmlBufferFree(byval buf as xmlBufferPtr)
declare function xmlBufferDump(byval file as FILE ptr, byval buf as xmlBufferPtr) as long
declare function xmlBufferAdd(byval buf as xmlBufferPtr, byval str as const xmlChar ptr, byval len as long) as long
declare function xmlBufferAddHead(byval buf as xmlBufferPtr, byval str as const xmlChar ptr, byval len as long) as long
declare function xmlBufferCat(byval buf as xmlBufferPtr, byval str as const xmlChar ptr) as long
declare function xmlBufferCCat(byval buf as xmlBufferPtr, byval str as const zstring ptr) as long
declare function xmlBufferShrink(byval buf as xmlBufferPtr, byval len as ulong) as long
declare function xmlBufferGrow(byval buf as xmlBufferPtr, byval len as ulong) as long
declare sub xmlBufferEmpty(byval buf as xmlBufferPtr)
declare function xmlBufferContent(byval buf as const xmlBuffer ptr) as const xmlChar ptr
declare function xmlBufferDetach(byval buf as xmlBufferPtr) as xmlChar ptr
declare sub xmlBufferSetAllocationScheme(byval buf as xmlBufferPtr, byval scheme as xmlBufferAllocationScheme)
declare function xmlBufferLength(byval buf as const xmlBuffer ptr) as long
declare function xmlCreateIntSubset(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr) as xmlDtdPtr
declare function xmlNewDtd(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr) as xmlDtdPtr
declare function xmlGetIntSubset(byval doc as const xmlDoc ptr) as xmlDtdPtr
declare sub xmlFreeDtd(byval cur as xmlDtdPtr)
declare function xmlNewGlobalNs(byval doc as xmlDocPtr, byval href as const xmlChar ptr, byval prefix as const xmlChar ptr) as xmlNsPtr
declare function xmlNewNs(byval node as xmlNodePtr, byval href as const xmlChar ptr, byval prefix as const xmlChar ptr) as xmlNsPtr
declare sub xmlFreeNs(byval cur as xmlNsPtr)
declare sub xmlFreeNsList(byval cur as xmlNsPtr)
declare function xmlNewDoc(byval version as const xmlChar ptr) as xmlDocPtr
declare sub xmlFreeDoc(byval cur as xmlDocPtr)
declare function xmlNewDocProp(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlAttrPtr
declare function xmlNewProp(byval node as xmlNodePtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlAttrPtr
declare function xmlNewNsProp(byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlAttrPtr
declare function xmlNewNsPropEatName(byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as xmlChar ptr, byval value as const xmlChar ptr) as xmlAttrPtr
declare sub xmlFreePropList(byval cur as xmlAttrPtr)
declare sub xmlFreeProp(byval cur as xmlAttrPtr)
declare function xmlCopyProp(byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xmlCopyPropList(byval target as xmlNodePtr, byval cur as xmlAttrPtr) as xmlAttrPtr
declare function xmlCopyDtd(byval dtd as xmlDtdPtr) as xmlDtdPtr
declare function xmlCopyDoc(byval doc as xmlDocPtr, byval recursive as long) as xmlDocPtr
declare function xmlNewDocNode(byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewDocNodeEatName(byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewNode(byval ns as xmlNsPtr, byval name as const xmlChar ptr) as xmlNodePtr
declare function xmlNewNodeEatName(byval ns as xmlNsPtr, byval name as xmlChar ptr) as xmlNodePtr
declare function xmlNewChild(byval parent as xmlNodePtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewDocText(byval doc as const xmlDoc ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewText(byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewDocPI(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewPI(byval name as const xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewDocTextLen(byval doc as xmlDocPtr, byval content as const xmlChar ptr, byval len as long) as xmlNodePtr
declare function xmlNewTextLen(byval content as const xmlChar ptr, byval len as long) as xmlNodePtr
declare function xmlNewDocComment(byval doc as xmlDocPtr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewComment(byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewCDataBlock(byval doc as xmlDocPtr, byval content as const xmlChar ptr, byval len as long) as xmlNodePtr
declare function xmlNewCharRef(byval doc as xmlDocPtr, byval name as const xmlChar ptr) as xmlNodePtr
declare function xmlNewReference(byval doc as const xmlDoc ptr, byval name as const xmlChar ptr) as xmlNodePtr
declare function xmlCopyNode(byval node as xmlNodePtr, byval recursive as long) as xmlNodePtr
declare function xmlDocCopyNode(byval node as xmlNodePtr, byval doc as xmlDocPtr, byval recursive as long) as xmlNodePtr
declare function xmlDocCopyNodeList(byval doc as xmlDocPtr, byval node as xmlNodePtr) as xmlNodePtr
declare function xmlCopyNodeList(byval node as xmlNodePtr) as xmlNodePtr
declare function xmlNewTextChild(byval parent as xmlNodePtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewDocRawNode(byval doc as xmlDocPtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr, byval content as const xmlChar ptr) as xmlNodePtr
declare function xmlNewDocFragment(byval doc as xmlDocPtr) as xmlNodePtr
declare function xmlGetLineNo(byval node as const xmlNode ptr) as clong
declare function xmlGetNodePath(byval node as const xmlNode ptr) as xmlChar ptr
declare function xmlDocGetRootElement(byval doc as const xmlDoc ptr) as xmlNodePtr
declare function xmlGetLastChild(byval parent as const xmlNode ptr) as xmlNodePtr
declare function xmlNodeIsText(byval node as const xmlNode ptr) as long
declare function xmlIsBlankNode(byval node as const xmlNode ptr) as long
declare function xmlDocSetRootElement(byval doc as xmlDocPtr, byval root as xmlNodePtr) as xmlNodePtr
declare sub xmlNodeSetName(byval cur as xmlNodePtr, byval name as const xmlChar ptr)
declare function xmlAddChild(byval parent as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlAddChildList(byval parent as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlReplaceNode(byval old as xmlNodePtr, byval cur as xmlNodePtr) as xmlNodePtr
declare function xmlAddPrevSibling(byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare function xmlAddSibling(byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare function xmlAddNextSibling(byval cur as xmlNodePtr, byval elem as xmlNodePtr) as xmlNodePtr
declare sub xmlUnlinkNode(byval cur as xmlNodePtr)
declare function xmlTextMerge(byval first as xmlNodePtr, byval second as xmlNodePtr) as xmlNodePtr
declare function xmlTextConcat(byval node as xmlNodePtr, byval content as const xmlChar ptr, byval len as long) as long
declare sub xmlFreeNodeList(byval cur as xmlNodePtr)
declare sub xmlFreeNode(byval cur as xmlNodePtr)
declare sub xmlSetTreeDoc(byval tree as xmlNodePtr, byval doc as xmlDocPtr)
declare sub xmlSetListDoc(byval list as xmlNodePtr, byval doc as xmlDocPtr)
declare function xmlSearchNs(byval doc as xmlDocPtr, byval node as xmlNodePtr, byval nameSpace as const xmlChar ptr) as xmlNsPtr
declare function xmlSearchNsByHref(byval doc as xmlDocPtr, byval node as xmlNodePtr, byval href as const xmlChar ptr) as xmlNsPtr
declare function xmlGetNsList(byval doc as const xmlDoc ptr, byval node as const xmlNode ptr) as xmlNsPtr ptr
declare sub xmlSetNs(byval node as xmlNodePtr, byval ns as xmlNsPtr)
declare function xmlCopyNamespace(byval cur as xmlNsPtr) as xmlNsPtr
declare function xmlCopyNamespaceList(byval cur as xmlNsPtr) as xmlNsPtr
declare function xmlSetProp(byval node as xmlNodePtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlAttrPtr
declare function xmlSetNsProp(byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlAttrPtr
declare function xmlGetNoNsProp(byval node as const xmlNode ptr, byval name as const xmlChar ptr) as xmlChar ptr
declare function xmlGetProp(byval node as const xmlNode ptr, byval name as const xmlChar ptr) as xmlChar ptr
declare function xmlHasProp(byval node as const xmlNode ptr, byval name as const xmlChar ptr) as xmlAttrPtr
declare function xmlHasNsProp(byval node as const xmlNode ptr, byval name as const xmlChar ptr, byval nameSpace as const xmlChar ptr) as xmlAttrPtr
declare function xmlGetNsProp(byval node as const xmlNode ptr, byval name as const xmlChar ptr, byval nameSpace as const xmlChar ptr) as xmlChar ptr
declare function xmlStringGetNodeList(byval doc as const xmlDoc ptr, byval value as const xmlChar ptr) as xmlNodePtr
declare function xmlStringLenGetNodeList(byval doc as const xmlDoc ptr, byval value as const xmlChar ptr, byval len as long) as xmlNodePtr
declare function xmlNodeListGetString(byval doc as xmlDocPtr, byval list as const xmlNode ptr, byval inLine as long) as xmlChar ptr
declare function xmlNodeListGetRawString(byval doc as const xmlDoc ptr, byval list as const xmlNode ptr, byval inLine as long) as xmlChar ptr
declare sub xmlNodeSetContent(byval cur as xmlNodePtr, byval content as const xmlChar ptr)
declare sub xmlNodeSetContentLen(byval cur as xmlNodePtr, byval content as const xmlChar ptr, byval len as long)
declare sub xmlNodeAddContent(byval cur as xmlNodePtr, byval content as const xmlChar ptr)
declare sub xmlNodeAddContentLen(byval cur as xmlNodePtr, byval content as const xmlChar ptr, byval len as long)
declare function xmlNodeGetContent(byval cur as const xmlNode ptr) as xmlChar ptr
declare function xmlNodeBufGetContent(byval buffer as xmlBufferPtr, byval cur as const xmlNode ptr) as long
declare function xmlBufGetNodeContent(byval buf as xmlBufPtr, byval cur as const xmlNode ptr) as long
declare function xmlNodeGetLang(byval cur as const xmlNode ptr) as xmlChar ptr
declare function xmlNodeGetSpacePreserve(byval cur as const xmlNode ptr) as long
declare sub xmlNodeSetLang(byval cur as xmlNodePtr, byval lang as const xmlChar ptr)
declare sub xmlNodeSetSpacePreserve(byval cur as xmlNodePtr, byval val as long)
declare function xmlNodeGetBase(byval doc as const xmlDoc ptr, byval cur as const xmlNode ptr) as xmlChar ptr
declare sub xmlNodeSetBase(byval cur as xmlNodePtr, byval uri as const xmlChar ptr)
declare function xmlRemoveProp(byval cur as xmlAttrPtr) as long
declare function xmlUnsetNsProp(byval node as xmlNodePtr, byval ns as xmlNsPtr, byval name as const xmlChar ptr) as long
declare function xmlUnsetProp(byval node as xmlNodePtr, byval name as const xmlChar ptr) as long
declare sub xmlBufferWriteCHAR(byval buf as xmlBufferPtr, byval string as const xmlChar ptr)
declare sub xmlBufferWriteChar_ alias "xmlBufferWriteChar"(byval buf as xmlBufferPtr, byval string as const zstring ptr)
declare sub xmlBufferWriteQuotedString(byval buf as xmlBufferPtr, byval string as const xmlChar ptr)
declare sub xmlAttrSerializeTxtContent(byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval attr as xmlAttrPtr, byval string as const xmlChar ptr)
declare function xmlReconciliateNs(byval doc as xmlDocPtr, byval tree as xmlNodePtr) as long
declare sub xmlDocDumpFormatMemory(byval cur as xmlDocPtr, byval mem as xmlChar ptr ptr, byval size as long ptr, byval format as long)
declare sub xmlDocDumpMemory(byval cur as xmlDocPtr, byval mem as xmlChar ptr ptr, byval size as long ptr)
declare sub xmlDocDumpMemoryEnc(byval out_doc as xmlDocPtr, byval doc_txt_ptr as xmlChar ptr ptr, byval doc_txt_len as long ptr, byval txt_encoding as const zstring ptr)
declare sub xmlDocDumpFormatMemoryEnc(byval out_doc as xmlDocPtr, byval doc_txt_ptr as xmlChar ptr ptr, byval doc_txt_len as long ptr, byval txt_encoding as const zstring ptr, byval format as long)
declare function xmlDocFormatDump(byval f as FILE ptr, byval cur as xmlDocPtr, byval format as long) as long
declare function xmlDocDump(byval f as FILE ptr, byval cur as xmlDocPtr) as long
declare sub xmlElemDump(byval f as FILE ptr, byval doc as xmlDocPtr, byval cur as xmlNodePtr)
declare function xmlSaveFile(byval filename as const zstring ptr, byval cur as xmlDocPtr) as long
declare function xmlSaveFormatFile(byval filename as const zstring ptr, byval cur as xmlDocPtr, byval format as long) as long
declare function xmlBufNodeDump(byval buf as xmlBufPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as long, byval format as long) as uinteger
declare function xmlNodeDump(byval buf as xmlBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as long, byval format as long) as long
declare function xmlSaveFileTo(byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as const zstring ptr) as long
declare function xmlSaveFormatFileTo(byval buf as xmlOutputBufferPtr, byval cur as xmlDocPtr, byval encoding as const zstring ptr, byval format as long) as long
declare sub xmlNodeDumpOutput(byval buf as xmlOutputBufferPtr, byval doc as xmlDocPtr, byval cur as xmlNodePtr, byval level as long, byval format as long, byval encoding as const zstring ptr)
declare function xmlSaveFormatFileEnc(byval filename as const zstring ptr, byval cur as xmlDocPtr, byval encoding as const zstring ptr, byval format as long) as long
declare function xmlSaveFileEnc(byval filename as const zstring ptr, byval cur as xmlDocPtr, byval encoding as const zstring ptr) as long
declare function xmlIsXHTML(byval systemID as const xmlChar ptr, byval publicID as const xmlChar ptr) as long
declare function xmlGetDocCompressMode(byval doc as const xmlDoc ptr) as long
declare sub xmlSetDocCompressMode(byval doc as xmlDocPtr, byval mode as long)
declare function xmlGetCompressMode() as long
declare sub xmlSetCompressMode(byval mode as long)
declare function xmlDOMWrapNewCtxt() as xmlDOMWrapCtxtPtr
declare sub xmlDOMWrapFreeCtxt(byval ctxt as xmlDOMWrapCtxtPtr)
declare function xmlDOMWrapReconcileNamespaces(byval ctxt as xmlDOMWrapCtxtPtr, byval elem as xmlNodePtr, byval options as long) as long
declare function xmlDOMWrapAdoptNode(byval ctxt as xmlDOMWrapCtxtPtr, byval sourceDoc as xmlDocPtr, byval node as xmlNodePtr, byval destDoc as xmlDocPtr, byval destParent as xmlNodePtr, byval options as long) as long
declare function xmlDOMWrapRemoveNode(byval ctxt as xmlDOMWrapCtxtPtr, byval doc as xmlDocPtr, byval node as xmlNodePtr, byval options as long) as long
declare function xmlDOMWrapCloneNode(byval ctxt as xmlDOMWrapCtxtPtr, byval sourceDoc as xmlDocPtr, byval node as xmlNodePtr, byval clonedNode as xmlNodePtr ptr, byval destDoc as xmlDocPtr, byval destParent as xmlNodePtr, byval deep as long, byval options as long) as long
declare function xmlChildElementCount(byval parent as xmlNodePtr) as culong
declare function xmlNextElementSibling(byval node as xmlNodePtr) as xmlNodePtr
declare function xmlFirstElementChild(byval parent as xmlNodePtr) as xmlNodePtr
declare function xmlLastElementChild(byval parent as xmlNodePtr) as xmlNodePtr
declare function xmlPreviousElementSibling(byval node as xmlNodePtr) as xmlNodePtr

end extern

#include once "libxml/xmlmemory.bi"
