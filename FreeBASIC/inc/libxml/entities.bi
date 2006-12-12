''
''
'' entities -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_entities_bi__
#define __xml_entities_bi__

#include once "xmlversion.bi"
#include once "tree.bi"

enum xmlEntityType
	XML_INTERNAL_GENERAL_ENTITY = 1
	XML_EXTERNAL_GENERAL_PARSED_ENTITY = 2
	XML_EXTERNAL_GENERAL_UNPARSED_ENTITY = 3
	XML_INTERNAL_PARAMETER_ENTITY = 4
	XML_EXTERNAL_PARAMETER_ENTITY = 5
	XML_INTERNAL_PREDEFINED_ENTITY = 6
end enum


type _xmlEntity
	_private as any ptr
	type as xmlElementType
	name as zstring ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlDtd ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	orig as zstring ptr
	content as zstring ptr
	length as integer
	etype as xmlEntityType
	ExternalID as zstring ptr
	SystemID as zstring ptr
	nexte as _xmlEntity ptr
	URI as zstring ptr
	owner as integer
end type

type xmlEntitiesTable as _xmlHashTable
type xmlEntitiesTablePtr as xmlEntitiesTable ptr

extern "c"
declare sub xmlInitializePredefinedEntities ()
declare function xmlAddDocEntity (byval doc as xmlDocPtr, byval name as zstring ptr, byval type as integer, byval ExternalID as zstring ptr, byval SystemID as zstring ptr, byval content as zstring ptr) as xmlEntityPtr
declare function xmlAddDtdEntity (byval doc as xmlDocPtr, byval name as zstring ptr, byval type as integer, byval ExternalID as zstring ptr, byval SystemID as zstring ptr, byval content as zstring ptr) as xmlEntityPtr
declare function xmlGetPredefinedEntity (byval name as zstring ptr) as xmlEntityPtr
declare function xmlGetDocEntity (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlEntityPtr
declare function xmlGetDtdEntity (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlEntityPtr
declare function xmlGetParameterEntity (byval doc as xmlDocPtr, byval name as zstring ptr) as xmlEntityPtr
declare function xmlEncodeEntities (byval doc as xmlDocPtr, byval input as zstring ptr) as zstring ptr
declare function xmlEncodeEntitiesReentrant (byval doc as xmlDocPtr, byval input as zstring ptr) as zstring ptr
declare function xmlEncodeSpecialChars (byval doc as xmlDocPtr, byval input as zstring ptr) as zstring ptr
declare function xmlCreateEntitiesTable () as xmlEntitiesTablePtr
declare function xmlCopyEntitiesTable (byval table as xmlEntitiesTablePtr) as xmlEntitiesTablePtr
declare sub xmlFreeEntitiesTable (byval table as xmlEntitiesTablePtr)
declare sub xmlDumpEntitiesTable (byval buf as xmlBufferPtr, byval table as xmlEntitiesTablePtr)
declare sub xmlDumpEntityDecl (byval buf as xmlBufferPtr, byval ent as xmlEntityPtr)
declare sub xmlCleanupPredefinedEntities ()
end extern

#endif
