''
''
'' valid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_valid_bi__
#define __xml_valid_bi__

#include once "xmlversion.bi"
#include once "xmlerror.bi"
#include once "tree.bi"
#include once "list.bi"
#include once "xmlautomata.bi"
#include once "xmlregexp.bi"

type xmlValidState as _xmlValidState
type xmlValidStatePtr as xmlValidState ptr
type xmlValidityErrorFunc as any ptr
type xmlValidityWarningFunc as any ptr
type xmlValidCtxt as _xmlValidCtxt
type xmlValidCtxtPtr as xmlValidCtxt ptr

type _xmlValidCtxt
	userData as any ptr
	error as xmlValidityErrorFunc
	warning as xmlValidityWarningFunc
	node as xmlNodePtr
	nodeNr as integer
	nodeMax as integer
	nodeTab as xmlNodePtr ptr
	finishDtd as uinteger
	doc as xmlDocPtr
	valid as integer
	vstate as xmlValidState ptr
	vstateNr as integer
	vstateMax as integer
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

extern "c"
declare function xmlAddNotationDecl (byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval name as zstring ptr, byval PublicID as zstring ptr, byval SystemID as zstring ptr) as xmlNotationPtr
declare function xmlCopyNotationTable (byval table as xmlNotationTablePtr) as xmlNotationTablePtr
declare sub xmlFreeNotationTable (byval table as xmlNotationTablePtr)
declare sub xmlDumpNotationDecl (byval buf as xmlBufferPtr, byval nota as xmlNotationPtr)
declare sub xmlDumpNotationTable (byval buf as xmlBufferPtr, byval table as xmlNotationTablePtr)
declare function xmlNewElementContent (byval name as zstring ptr, byval type as xmlElementContentType) as xmlElementContentPtr
declare function xmlCopyElementContent (byval content as xmlElementContentPtr) as xmlElementContentPtr
declare sub xmlFreeElementContent (byval cur as xmlElementContentPtr)
declare sub xmlSnprintfElementContent (byval buf as zstring ptr, byval size as integer, byval content as xmlElementContentPtr, byval glob as integer)
declare sub xmlSprintfElementContent (byval buf as zstring ptr, byval content as xmlElementContentPtr, byval glob as integer)
declare function xmlAddElementDecl (byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval name as zstring ptr, byval type as xmlElementTypeVal, byval content as xmlElementContentPtr) as xmlElementPtr
declare function xmlCopyElementTable (byval table as xmlElementTablePtr) as xmlElementTablePtr
declare sub xmlFreeElementTable (byval table as xmlElementTablePtr)
declare sub xmlDumpElementTable (byval buf as xmlBufferPtr, byval table as xmlElementTablePtr)
declare sub xmlDumpElementDecl (byval buf as xmlBufferPtr, byval elem as xmlElementPtr)
declare function xmlCreateEnumeration (byval name as zstring ptr) as xmlEnumerationPtr
declare sub xmlFreeEnumeration (byval cur as xmlEnumerationPtr)
declare function xmlCopyEnumeration (byval cur as xmlEnumerationPtr) as xmlEnumerationPtr
declare function xmlAddAttributeDecl (byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval elem as zstring ptr, byval name as zstring ptr, byval ns as zstring ptr, byval type as xmlAttributeType, byval def as xmlAttributeDefault, byval defaultValue as zstring ptr, byval tree as xmlEnumerationPtr) as xmlAttributePtr
declare function xmlCopyAttributeTable (byval table as xmlAttributeTablePtr) as xmlAttributeTablePtr
declare sub xmlFreeAttributeTable (byval table as xmlAttributeTablePtr)
declare sub xmlDumpAttributeTable (byval buf as xmlBufferPtr, byval table as xmlAttributeTablePtr)
declare sub xmlDumpAttributeDecl (byval buf as xmlBufferPtr, byval attr as xmlAttributePtr)
declare function xmlAddID (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval value as zstring ptr, byval attr as xmlAttrPtr) as xmlIDPtr
declare sub xmlFreeIDTable (byval table as xmlIDTablePtr)
declare function xmlGetID (byval doc as xmlDocPtr, byval ID as zstring ptr) as xmlAttrPtr
declare function xmlIsID (byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr) as integer
declare function xmlRemoveID (byval doc as xmlDocPtr, byval attr as xmlAttrPtr) as integer
declare function xmlAddRef (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval value as zstring ptr, byval attr as xmlAttrPtr) as xmlRefPtr
declare sub xmlFreeRefTable (byval table as xmlRefTablePtr)
declare function xmlIsRef (byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr) as integer
declare function xmlRemoveRef (byval doc as xmlDocPtr, byval attr as xmlAttrPtr) as integer
declare function xmlGetRefs (byval doc as xmlDocPtr, byval ID as zstring ptr) as xmlListPtr
declare function xmlNewValidCtxt () as xmlValidCtxtPtr
declare sub xmlFreeValidCtxt (byval as xmlValidCtxtPtr)
declare function xmlValidateRoot (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateElementDecl (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlElementPtr) as integer
declare function xmlValidNormalizeAttributeValue (byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as zstring ptr
declare function xmlValidCtxtNormalizeAttributeValue (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as zstring ptr
declare function xmlValidateAttributeDecl (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval attr as xmlAttributePtr) as integer
declare function xmlValidateAttributeValue (byval type as xmlAttributeType, byval value as zstring ptr) as integer
declare function xmlValidateNotationDecl (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval nota as xmlNotationPtr) as integer
declare function xmlValidateDtd (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval dtd as xmlDtdPtr) as integer
declare function xmlValidateDtdFinal (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateDocument (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateElement (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer
declare function xmlValidateOneElement (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer
declare function xmlValidateOneAttribute (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr, byval value as zstring ptr) as integer
declare function xmlValidateOneNamespace (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval prefix as zstring ptr, byval ns as xmlNsPtr, byval value as zstring ptr) as integer
declare function xmlValidateDocumentFinal (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateNotationUse (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval notationName as zstring ptr) as integer
declare function xmlIsMixedElement (byval doc as xmlDocPtr, byval name as zstring ptr) as integer
declare function xmlGetDtdAttrDesc (byval dtd as xmlDtdPtr, byval elem as zstring ptr, byval name as zstring ptr) as xmlAttributePtr
declare function xmlGetDtdQAttrDesc (byval dtd as xmlDtdPtr, byval elem as zstring ptr, byval name as zstring ptr, byval prefix as zstring ptr) as xmlAttributePtr
declare function xmlGetDtdNotationDesc (byval dtd as xmlDtdPtr, byval name as zstring ptr) as xmlNotationPtr
declare function xmlGetDtdQElementDesc (byval dtd as xmlDtdPtr, byval name as zstring ptr, byval prefix as zstring ptr) as xmlElementPtr
declare function xmlGetDtdElementDesc (byval dtd as xmlDtdPtr, byval name as zstring ptr) as xmlElementPtr
declare function xmlValidGetPotentialChildren (byval ctree as xmlElementContent ptr, byval list as zstring ptr ptr, byval len as integer ptr, byval max as integer) as integer
declare function xmlValidGetValidElements (byval prev as xmlNode ptr, byval next as xmlNode ptr, byval names as zstring ptr ptr, byval max as integer) as integer
declare function xmlValidateNameValue (byval value as zstring ptr) as integer
declare function xmlValidateNamesValue (byval value as zstring ptr) as integer
declare function xmlValidateNmtokenValue (byval value as zstring ptr) as integer
declare function xmlValidateNmtokensValue (byval value as zstring ptr) as integer
declare function xmlValidBuildContentModel (byval ctxt as xmlValidCtxtPtr, byval elem as xmlElementPtr) as integer
declare function xmlValidatePushElement (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval qname as zstring ptr) as integer
declare function xmlValidatePushCData (byval ctxt as xmlValidCtxtPtr, byval data as zstring ptr, byval len as integer) as integer
declare function xmlValidatePopElement (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval qname as zstring ptr) as integer
end extern

#endif
