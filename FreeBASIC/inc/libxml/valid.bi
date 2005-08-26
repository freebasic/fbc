''
''
'' valid -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __valid_bi__
#define __valid_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/tree.bi"
#include once "libxml/list.bi"
#include once "libxml/xmlautomata.bi"
#include once "libxml/xmlregexp.bi"

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

declare function xmlAddNotationDecl cdecl alias "xmlAddNotationDecl" (byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval name as zstring ptr, byval PublicID as zstring ptr, byval SystemID as zstring ptr) as xmlNotationPtr
declare function xmlCopyNotationTable cdecl alias "xmlCopyNotationTable" (byval table as xmlNotationTablePtr) as xmlNotationTablePtr
declare sub xmlFreeNotationTable cdecl alias "xmlFreeNotationTable" (byval table as xmlNotationTablePtr)
declare sub xmlDumpNotationDecl cdecl alias "xmlDumpNotationDecl" (byval buf as xmlBufferPtr, byval nota as xmlNotationPtr)
declare sub xmlDumpNotationTable cdecl alias "xmlDumpNotationTable" (byval buf as xmlBufferPtr, byval table as xmlNotationTablePtr)
declare function xmlNewElementContent cdecl alias "xmlNewElementContent" (byval name as zstring ptr, byval type as xmlElementContentType) as xmlElementContentPtr
declare function xmlCopyElementContent cdecl alias "xmlCopyElementContent" (byval content as xmlElementContentPtr) as xmlElementContentPtr
declare sub xmlFreeElementContent cdecl alias "xmlFreeElementContent" (byval cur as xmlElementContentPtr)
declare sub xmlSnprintfElementContent cdecl alias "xmlSnprintfElementContent" (byval buf as zstring ptr, byval size as integer, byval content as xmlElementContentPtr, byval glob as integer)
declare sub xmlSprintfElementContent cdecl alias "xmlSprintfElementContent" (byval buf as zstring ptr, byval content as xmlElementContentPtr, byval glob as integer)
declare function xmlAddElementDecl cdecl alias "xmlAddElementDecl" (byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval name as zstring ptr, byval type as xmlElementTypeVal, byval content as xmlElementContentPtr) as xmlElementPtr
declare function xmlCopyElementTable cdecl alias "xmlCopyElementTable" (byval table as xmlElementTablePtr) as xmlElementTablePtr
declare sub xmlFreeElementTable cdecl alias "xmlFreeElementTable" (byval table as xmlElementTablePtr)
declare sub xmlDumpElementTable cdecl alias "xmlDumpElementTable" (byval buf as xmlBufferPtr, byval table as xmlElementTablePtr)
declare sub xmlDumpElementDecl cdecl alias "xmlDumpElementDecl" (byval buf as xmlBufferPtr, byval elem as xmlElementPtr)
declare function xmlCreateEnumeration cdecl alias "xmlCreateEnumeration" (byval name as zstring ptr) as xmlEnumerationPtr
declare sub xmlFreeEnumeration cdecl alias "xmlFreeEnumeration" (byval cur as xmlEnumerationPtr)
declare function xmlCopyEnumeration cdecl alias "xmlCopyEnumeration" (byval cur as xmlEnumerationPtr) as xmlEnumerationPtr
declare function xmlAddAttributeDecl cdecl alias "xmlAddAttributeDecl" (byval ctxt as xmlValidCtxtPtr, byval dtd as xmlDtdPtr, byval elem as zstring ptr, byval name as zstring ptr, byval ns as zstring ptr, byval type as xmlAttributeType, byval def as xmlAttributeDefault, byval defaultValue as zstring ptr, byval tree as xmlEnumerationPtr) as xmlAttributePtr
declare function xmlCopyAttributeTable cdecl alias "xmlCopyAttributeTable" (byval table as xmlAttributeTablePtr) as xmlAttributeTablePtr
declare sub xmlFreeAttributeTable cdecl alias "xmlFreeAttributeTable" (byval table as xmlAttributeTablePtr)
declare sub xmlDumpAttributeTable cdecl alias "xmlDumpAttributeTable" (byval buf as xmlBufferPtr, byval table as xmlAttributeTablePtr)
declare sub xmlDumpAttributeDecl cdecl alias "xmlDumpAttributeDecl" (byval buf as xmlBufferPtr, byval attr as xmlAttributePtr)
declare function xmlAddID cdecl alias "xmlAddID" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval value as zstring ptr, byval attr as xmlAttrPtr) as xmlIDPtr
declare sub xmlFreeIDTable cdecl alias "xmlFreeIDTable" (byval table as xmlIDTablePtr)
declare function xmlGetID cdecl alias "xmlGetID" (byval doc as xmlDocPtr, byval ID as zstring ptr) as xmlAttrPtr
declare function xmlIsID cdecl alias "xmlIsID" (byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr) as integer
declare function xmlRemoveID cdecl alias "xmlRemoveID" (byval doc as xmlDocPtr, byval attr as xmlAttrPtr) as integer
declare function xmlAddRef cdecl alias "xmlAddRef" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval value as zstring ptr, byval attr as xmlAttrPtr) as xmlRefPtr
declare sub xmlFreeRefTable cdecl alias "xmlFreeRefTable" (byval table as xmlRefTablePtr)
declare function xmlIsRef cdecl alias "xmlIsRef" (byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr) as integer
declare function xmlRemoveRef cdecl alias "xmlRemoveRef" (byval doc as xmlDocPtr, byval attr as xmlAttrPtr) as integer
declare function xmlGetRefs cdecl alias "xmlGetRefs" (byval doc as xmlDocPtr, byval ID as zstring ptr) as xmlListPtr
declare function xmlNewValidCtxt cdecl alias "xmlNewValidCtxt" () as xmlValidCtxtPtr
declare sub xmlFreeValidCtxt cdecl alias "xmlFreeValidCtxt" (byval as xmlValidCtxtPtr)
declare function xmlValidateRoot cdecl alias "xmlValidateRoot" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateElementDecl cdecl alias "xmlValidateElementDecl" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlElementPtr) as integer
declare function xmlValidNormalizeAttributeValue cdecl alias "xmlValidNormalizeAttributeValue" (byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as zstring ptr
declare function xmlValidCtxtNormalizeAttributeValue cdecl alias "xmlValidCtxtNormalizeAttributeValue" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval name as zstring ptr, byval value as zstring ptr) as zstring ptr
declare function xmlValidateAttributeDecl cdecl alias "xmlValidateAttributeDecl" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval attr as xmlAttributePtr) as integer
declare function xmlValidateAttributeValue cdecl alias "xmlValidateAttributeValue" (byval type as xmlAttributeType, byval value as zstring ptr) as integer
declare function xmlValidateNotationDecl cdecl alias "xmlValidateNotationDecl" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval nota as xmlNotationPtr) as integer
declare function xmlValidateDtd cdecl alias "xmlValidateDtd" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval dtd as xmlDtdPtr) as integer
declare function xmlValidateDtdFinal cdecl alias "xmlValidateDtdFinal" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateDocument cdecl alias "xmlValidateDocument" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateElement cdecl alias "xmlValidateElement" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer
declare function xmlValidateOneElement cdecl alias "xmlValidateOneElement" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as integer
declare function xmlValidateOneAttribute cdecl alias "xmlValidateOneAttribute" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval attr as xmlAttrPtr, byval value as zstring ptr) as integer
declare function xmlValidateOneNamespace cdecl alias "xmlValidateOneNamespace" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval prefix as zstring ptr, byval ns as xmlNsPtr, byval value as zstring ptr) as integer
declare function xmlValidateDocumentFinal cdecl alias "xmlValidateDocumentFinal" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr) as integer
declare function xmlValidateNotationUse cdecl alias "xmlValidateNotationUse" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval notationName as zstring ptr) as integer
declare function xmlIsMixedElement cdecl alias "xmlIsMixedElement" (byval doc as xmlDocPtr, byval name as zstring ptr) as integer
declare function xmlGetDtdAttrDesc cdecl alias "xmlGetDtdAttrDesc" (byval dtd as xmlDtdPtr, byval elem as zstring ptr, byval name as zstring ptr) as xmlAttributePtr
declare function xmlGetDtdQAttrDesc cdecl alias "xmlGetDtdQAttrDesc" (byval dtd as xmlDtdPtr, byval elem as zstring ptr, byval name as zstring ptr, byval prefix as zstring ptr) as xmlAttributePtr
declare function xmlGetDtdNotationDesc cdecl alias "xmlGetDtdNotationDesc" (byval dtd as xmlDtdPtr, byval name as zstring ptr) as xmlNotationPtr
declare function xmlGetDtdQElementDesc cdecl alias "xmlGetDtdQElementDesc" (byval dtd as xmlDtdPtr, byval name as zstring ptr, byval prefix as zstring ptr) as xmlElementPtr
declare function xmlGetDtdElementDesc cdecl alias "xmlGetDtdElementDesc" (byval dtd as xmlDtdPtr, byval name as zstring ptr) as xmlElementPtr
declare function xmlValidGetPotentialChildren cdecl alias "xmlValidGetPotentialChildren" (byval ctree as xmlElementContent ptr, byval list as zstring ptr ptr, byval len as integer ptr, byval max as integer) as integer
declare function xmlValidGetValidElements cdecl alias "xmlValidGetValidElements" (byval prev as xmlNode ptr, byval next as xmlNode ptr, byval names as zstring ptr ptr, byval max as integer) as integer
declare function xmlValidateNameValue cdecl alias "xmlValidateNameValue" (byval value as zstring ptr) as integer
declare function xmlValidateNamesValue cdecl alias "xmlValidateNamesValue" (byval value as zstring ptr) as integer
declare function xmlValidateNmtokenValue cdecl alias "xmlValidateNmtokenValue" (byval value as zstring ptr) as integer
declare function xmlValidateNmtokensValue cdecl alias "xmlValidateNmtokensValue" (byval value as zstring ptr) as integer
declare function xmlValidBuildContentModel cdecl alias "xmlValidBuildContentModel" (byval ctxt as xmlValidCtxtPtr, byval elem as xmlElementPtr) as integer
declare function xmlValidatePushElement cdecl alias "xmlValidatePushElement" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval qname as zstring ptr) as integer
declare function xmlValidatePushCData cdecl alias "xmlValidatePushCData" (byval ctxt as xmlValidCtxtPtr, byval data as zstring ptr, byval len as integer) as integer
declare function xmlValidatePopElement cdecl alias "xmlValidatePopElement" (byval ctxt as xmlValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr, byval qname as zstring ptr) as integer

#endif
