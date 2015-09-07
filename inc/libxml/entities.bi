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
#include once "libxml/tree.bi"

extern "C"

#define __XML_ENTITIES_H__

type xmlEntityType as long
enum
	XML_INTERNAL_GENERAL_ENTITY = 1
	XML_EXTERNAL_GENERAL_PARSED_ENTITY = 2
	XML_EXTERNAL_GENERAL_UNPARSED_ENTITY = 3
	XML_INTERNAL_PARAMETER_ENTITY = 4
	XML_EXTERNAL_PARAMETER_ENTITY = 5
	XML_INTERNAL_PREDEFINED_ENTITY = 6
end enum

type _xmlEntity
	_private as any ptr
	as xmlElementType type
	name as const xmlChar ptr
	children as _xmlNode ptr
	last as _xmlNode ptr
	parent as _xmlDtd ptr
	next as _xmlNode ptr
	prev as _xmlNode ptr
	doc as _xmlDoc ptr
	orig as xmlChar ptr
	content as xmlChar ptr
	length as long
	etype as xmlEntityType
	ExternalID as const xmlChar ptr
	SystemID as const xmlChar ptr
	nexte as _xmlEntity ptr
	URI as const xmlChar ptr
	owner as long
	checked as long
end type

type xmlEntitiesTable as _xmlHashTable
type xmlEntitiesTablePtr as xmlEntitiesTable ptr
declare sub xmlInitializePredefinedEntities()
declare function xmlNewEntity(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval type as long, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr, byval content as const xmlChar ptr) as xmlEntityPtr
declare function xmlAddDocEntity(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval type as long, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr, byval content as const xmlChar ptr) as xmlEntityPtr
declare function xmlAddDtdEntity(byval doc as xmlDocPtr, byval name as const xmlChar ptr, byval type as long, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr, byval content as const xmlChar ptr) as xmlEntityPtr
declare function xmlGetPredefinedEntity(byval name as const xmlChar ptr) as xmlEntityPtr
declare function xmlGetDocEntity(byval doc as const xmlDoc ptr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function xmlGetDtdEntity(byval doc as xmlDocPtr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function xmlGetParameterEntity(byval doc as xmlDocPtr, byval name as const xmlChar ptr) as xmlEntityPtr
declare function xmlEncodeEntities(byval doc as xmlDocPtr, byval input as const xmlChar ptr) as const xmlChar ptr
declare function xmlEncodeEntitiesReentrant(byval doc as xmlDocPtr, byval input as const xmlChar ptr) as xmlChar ptr
declare function xmlEncodeSpecialChars(byval doc as const xmlDoc ptr, byval input as const xmlChar ptr) as xmlChar ptr
declare function xmlCreateEntitiesTable() as xmlEntitiesTablePtr
declare function xmlCopyEntitiesTable(byval table as xmlEntitiesTablePtr) as xmlEntitiesTablePtr
declare sub xmlFreeEntitiesTable(byval table as xmlEntitiesTablePtr)
declare sub xmlDumpEntitiesTable(byval buf as xmlBufferPtr, byval table as xmlEntitiesTablePtr)
declare sub xmlDumpEntityDecl(byval buf as xmlBufferPtr, byval ent as xmlEntityPtr)
declare sub xmlCleanupPredefinedEntities()

end extern
