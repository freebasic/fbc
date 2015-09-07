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

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/tree.bi"
#include once "libxml/list.bi"
#include once "libxml/xmlautomata.bi"
#include once "libxml/xmlregexp.bi"

extern "C"

#define __XML_VALID_H__
type xmlValidState as _xmlValidState
type xmlValidStatePtr as xmlValidState ptr
type xmlValidityErrorFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlValidityWarningFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlValidCtxt as _xmlValidCtxt
type xmlValidCtxtPtr as xmlValidCtxt ptr

type _xmlValidCtxt
	userData as any ptr
	error as xmlValidityErrorFunc
	warning as xmlValidityWarningFunc
	node as xmlNodePtr
	nodeNr as long
	nodeMax as long
	nodeTab as xmlNodePtr ptr
	finishDtd as ulong
	doc as xmlDocPtr
	valid as long
	vstate as xmlValidState ptr
	vstateNr as long
	vstateMax as long
	vstateTab as xmlValidState ptr
	am as xmlAutomataPtr
	state as xmlAutomataStatePtr
end type

type xmlNotationTable as _xmlHashTable
type xmlNotationTablePtr as xmlNotationTable ptr
type xmlElementTable as _xmlHashTable
type xmlElementTablePtr as xmlElementTable ptr
type xmlAttributeTable as _xmlHashTable
type xmlAttributeTablePtr as xmlAttributeTable ptr
type xmlIDTable as _xmlHashTable
type xmlIDTablePtr as xmlIDTable ptr
type xmlRefTable as _xmlHashTable
type xmlRefTablePtr as xmlRefTable ptr

declare function xmlAddNotationDecl(byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval name as const xmlChar ptr, byval PublicID as const xmlChar ptr, byval SystemID as const xmlChar ptr) as xmlNotationPtr
declare function xmlCopyNotationTable(byval table as xmlNotationTablePtr) as xmlNotationTablePtr
declare sub xmlFreeNotationTable(byval table as xmlNotationTablePtr)
declare sub xmlDumpNotationDecl(byval buf as xmlBufferPtr, byval nota as xmlNotationPtr)
declare sub xmlDumpNotationTable(byval buf as xmlBufferPtr, byval table as xmlNotationTablePtr)
declare function xmlNewElementContent(byval name as const xmlChar ptr, byval type as xmlElementContentType) as xmlElementContentPtr
declare function xmlCopyElementContent(byval content as xmlElementContentPtr) as xmlElementContentPtr
declare sub xmlFreeElementContent(byval cur as xmlElementContentPtr)
declare function xmlNewDocElementContent(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval type as xmlElementContentType) as xmlElementContentPtr
declare function xmlCopyDocElementContent(byval doc as xmlDocPtr, byval content as xmlElementContentPtr) as xmlElementContentPtr
declare sub xmlFreeDocElementContent(byval doc as xmlDocPtr, byval cur as xmlElementContentPtr)
declare sub xmlSnprintfElementContent(byval buf as zstring ptr, byval size as long, byval content as xmlElementContentPtr, byval englob as long)
declare sub xmlSprintfElementContent(byval buf as zstring ptr, byval content as xmlElementContentPtr, byval englob as long)
declare function xmlAddElementDecl(byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval name as const xmlChar ptr, byval type as xmlElementTypeVal, byval content as xmlElementContentPtr) as xmlElementPtr
declare function xmlCopyElementTable(byval table as xmlElementTablePtr) as xmlElementTablePtr
declare sub xmlFreeElementTable(byval table as xmlElementTablePtr)
declare sub xmlDumpElementTable(byval buf as xmlBufferPtr, byval table as xmlElementTablePtr)
declare sub xmlDumpElementDecl(byval buf as xmlBufferPtr, byval elem as xmlElementPtr)
declare function xmlCreateEnumeration(byval name as const xmlChar ptr) as xmlEnumerationPtr
declare sub xmlFreeEnumeration(byval cur as xmlEnumerationPtr)
declare function xmlCopyEnumeration(byval cur as xmlEnumerationPtr) as xmlEnumerationPtr
declare function xmlAddAttributeDecl(byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval elem as const xmlChar ptr, byval name as const xmlChar ptr, byval ns as const xmlChar ptr, byval type as xmlAttributeType, byval def as xmlAttributeDefault, byval defaultValue as const xmlChar ptr, byval tree as xmlEnumerationPtr) as xmlAttributePtr
declare function xmlCopyAttributeTable(byval table as xmlAttributeTablePtr) as xmlAttributeTablePtr
declare sub xmlFreeAttributeTable(byval table as xmlAttributeTablePtr)
declare sub xmlDumpAttributeTable(byval buf as xmlBufferPtr, byval table as xmlAttributeTablePtr)
declare sub xmlDumpAttributeDecl(byval buf as xmlBufferPtr, byval attr as xmlAttributePtr)
declare function xmlAddID(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval value as const xmlChar ptr, byval attr as xmlAttrPtr) as xmlIDPtr
declare sub xmlFreeIDTable(byval table as xmlIDTablePtr)
declare function xmlGetID(byval doc as xmlDocPtr, byval ID as const xmlChar ptr) as xmlAttrPtr
declare function xmlIsID(byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr) as long
declare function xmlRemoveID(byval doc as xmlDocPtr, byval attr as xmlAttrPtr) as long
declare function xmlAddRef(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval value as const xmlChar ptr, byval attr as xmlAttrPtr) as xmlRefPtr
declare sub xmlFreeRefTable(byval table as xmlRefTablePtr)
declare function xmlIsRef(byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr) as long
declare function xmlRemoveRef(byval doc as xmlDocPtr, byval attr as xmlAttrPtr) as long
declare function xmlGetRefs(byval doc as xmlDocPtr, byval ID as const xmlChar ptr) as xmlListPtr
declare function xmlNewValidCtxt() as xmlValidCtxtPtr
declare sub xmlFreeValidCtxt(byval as xmlValidCtxtPtr)
declare function xmlValidateRoot(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as long
declare function xmlValidateElementDecl(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlElementPtr) as long
declare function xmlValidNormalizeAttributeValue(byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlChar ptr
declare function xmlValidCtxtNormalizeAttributeValue(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval name as const xmlChar ptr, byval value as const xmlChar ptr) as xmlChar ptr
declare function xmlValidateAttributeDecl(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval attr as xmlAttributePtr) as long
declare function xmlValidateAttributeValue(byval type as xmlAttributeType, byval value as const xmlChar ptr) as long
declare function xmlValidateNotationDecl(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval nota as xmlNotationPtr) as long
declare function xmlValidateDtd(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval dtd as xmlDtdPtr) as long
declare function xmlValidateDtdFinal(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as long
declare function xmlValidateDocument(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as long
declare function xmlValidateElement(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as long
declare function xmlValidateOneElement(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as long
declare function xmlValidateOneAttribute(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr, byval value as const xmlChar ptr) as long
declare function xmlValidateOneNamespace(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval prefix as const xmlChar ptr, byval ns as xmlNsPtr, byval value as const xmlChar ptr) as long
declare function xmlValidateDocumentFinal(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as long
declare function xmlValidateNotationUse(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval notationName as const xmlChar ptr) as long
declare function xmlIsMixedElement(byval doc as xmlDocPtr, byval name as const xmlChar ptr) as long
declare function xmlGetDtdAttrDesc(byval dtd as xmlDtdPtr, byval elem as const xmlChar ptr, byval name as const xmlChar ptr) as xmlAttributePtr
declare function xmlGetDtdQAttrDesc(byval dtd as xmlDtdPtr, byval elem as const xmlChar ptr, byval name as const xmlChar ptr, byval prefix as const xmlChar ptr) as xmlAttributePtr
declare function xmlGetDtdNotationDesc(byval dtd as xmlDtdPtr, byval name as const xmlChar ptr) as xmlNotationPtr
declare function xmlGetDtdQElementDesc(byval dtd as xmlDtdPtr, byval name as const xmlChar ptr, byval prefix as const xmlChar ptr) as xmlElementPtr
declare function xmlGetDtdElementDesc(byval dtd as xmlDtdPtr, byval name as const xmlChar ptr) as xmlElementPtr
declare function xmlValidGetPotentialChildren(byval ctree as xmlElementContent ptr, byval names as const xmlChar ptr ptr, byval len as long ptr, byval max as long) as long
declare function xmlValidGetValidElements(byval prev as xmlNode ptr, byval next as xmlNode ptr, byval names as const xmlChar ptr ptr, byval max as long) as long
declare function xmlValidateNameValue(byval value as const xmlChar ptr) as long
declare function xmlValidateNamesValue(byval value as const xmlChar ptr) as long
declare function xmlValidateNmtokenValue(byval value as const xmlChar ptr) as long
declare function xmlValidateNmtokensValue(byval value as const xmlChar ptr) as long
declare function xmlValidBuildContentModel(byval ctxt as xmlValidCtxtPtr, byval elem as xmlElementPtr) as long
declare function xmlValidatePushElement(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval qname as const xmlChar ptr) as long
declare function xmlValidatePushCData(byval ctxt as xmlValidCtxtPtr, byval data as const xmlChar ptr, byval len as long) as long
declare function xmlValidatePopElement(byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval qname as const xmlChar ptr) as long

end extern
