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
#include once "libxml/xmlregexp.bi"
#include once "libxml/hash.bi"
#include once "libxml/dict.bi"

extern "C"

#define __XML_SCHEMA_INTERNALS_H__

type xmlSchemaValType as long
enum
	XML_SCHEMAS_UNKNOWN = 0
	XML_SCHEMAS_STRING
	XML_SCHEMAS_NORMSTRING
	XML_SCHEMAS_DECIMAL
	XML_SCHEMAS_TIME
	XML_SCHEMAS_GDAY
	XML_SCHEMAS_GMONTH
	XML_SCHEMAS_GMONTHDAY
	XML_SCHEMAS_GYEAR
	XML_SCHEMAS_GYEARMONTH
	XML_SCHEMAS_DATE
	XML_SCHEMAS_DATETIME
	XML_SCHEMAS_DURATION
	XML_SCHEMAS_FLOAT
	XML_SCHEMAS_DOUBLE
	XML_SCHEMAS_BOOLEAN
	XML_SCHEMAS_TOKEN
	XML_SCHEMAS_LANGUAGE
	XML_SCHEMAS_NMTOKEN
	XML_SCHEMAS_NMTOKENS
	XML_SCHEMAS_NAME
	XML_SCHEMAS_QNAME
	XML_SCHEMAS_NCNAME
	XML_SCHEMAS_ID
	XML_SCHEMAS_IDREF
	XML_SCHEMAS_IDREFS
	XML_SCHEMAS_ENTITY
	XML_SCHEMAS_ENTITIES
	XML_SCHEMAS_NOTATION
	XML_SCHEMAS_ANYURI
	XML_SCHEMAS_INTEGER
	XML_SCHEMAS_NPINTEGER
	XML_SCHEMAS_NINTEGER
	XML_SCHEMAS_NNINTEGER
	XML_SCHEMAS_PINTEGER
	XML_SCHEMAS_INT
	XML_SCHEMAS_UINT
	XML_SCHEMAS_LONG
	XML_SCHEMAS_ULONG
	XML_SCHEMAS_SHORT
	XML_SCHEMAS_USHORT
	XML_SCHEMAS_BYTE
	XML_SCHEMAS_UBYTE
	XML_SCHEMAS_HEXBINARY
	XML_SCHEMAS_BASE64BINARY
	XML_SCHEMAS_ANYTYPE
	XML_SCHEMAS_ANYSIMPLETYPE
end enum

type xmlSchemaTypeType as long
enum
	XML_SCHEMA_TYPE_BASIC = 1
	XML_SCHEMA_TYPE_ANY
	XML_SCHEMA_TYPE_FACET
	XML_SCHEMA_TYPE_SIMPLE
	XML_SCHEMA_TYPE_COMPLEX
	XML_SCHEMA_TYPE_SEQUENCE = 6
	XML_SCHEMA_TYPE_CHOICE
	XML_SCHEMA_TYPE_ALL
	XML_SCHEMA_TYPE_SIMPLE_CONTENT
	XML_SCHEMA_TYPE_COMPLEX_CONTENT
	XML_SCHEMA_TYPE_UR
	XML_SCHEMA_TYPE_RESTRICTION
	XML_SCHEMA_TYPE_EXTENSION
	XML_SCHEMA_TYPE_ELEMENT
	XML_SCHEMA_TYPE_ATTRIBUTE
	XML_SCHEMA_TYPE_ATTRIBUTEGROUP
	XML_SCHEMA_TYPE_GROUP
	XML_SCHEMA_TYPE_NOTATION
	XML_SCHEMA_TYPE_LIST
	XML_SCHEMA_TYPE_UNION
	XML_SCHEMA_TYPE_ANY_ATTRIBUTE
	XML_SCHEMA_TYPE_IDC_UNIQUE
	XML_SCHEMA_TYPE_IDC_KEY
	XML_SCHEMA_TYPE_IDC_KEYREF
	XML_SCHEMA_TYPE_PARTICLE = 25
	XML_SCHEMA_TYPE_ATTRIBUTE_USE
	XML_SCHEMA_FACET_MININCLUSIVE = 1000
	XML_SCHEMA_FACET_MINEXCLUSIVE
	XML_SCHEMA_FACET_MAXINCLUSIVE
	XML_SCHEMA_FACET_MAXEXCLUSIVE
	XML_SCHEMA_FACET_TOTALDIGITS
	XML_SCHEMA_FACET_FRACTIONDIGITS
	XML_SCHEMA_FACET_PATTERN
	XML_SCHEMA_FACET_ENUMERATION
	XML_SCHEMA_FACET_WHITESPACE
	XML_SCHEMA_FACET_LENGTH
	XML_SCHEMA_FACET_MAXLENGTH
	XML_SCHEMA_FACET_MINLENGTH
	XML_SCHEMA_EXTRA_QNAMEREF = 2000
	XML_SCHEMA_EXTRA_ATTR_USE_PROHIB
end enum

type xmlSchemaContentType as long
enum
	XML_SCHEMA_CONTENT_UNKNOWN = 0
	XML_SCHEMA_CONTENT_EMPTY = 1
	XML_SCHEMA_CONTENT_ELEMENTS
	XML_SCHEMA_CONTENT_MIXED
	XML_SCHEMA_CONTENT_SIMPLE
	XML_SCHEMA_CONTENT_MIXED_OR_ELEMENTS
	XML_SCHEMA_CONTENT_BASIC
	XML_SCHEMA_CONTENT_ANY
end enum

type xmlSchemaVal as _xmlSchemaVal
type xmlSchemaValPtr as xmlSchemaVal ptr
type xmlSchemaType as _xmlSchemaType
type xmlSchemaTypePtr as xmlSchemaType ptr
type xmlSchemaFacet as _xmlSchemaFacet
type xmlSchemaFacetPtr as xmlSchemaFacet ptr
type xmlSchemaAnnot as _xmlSchemaAnnot
type xmlSchemaAnnotPtr as xmlSchemaAnnot ptr

type _xmlSchemaAnnot
	next as _xmlSchemaAnnot ptr
	content as xmlNodePtr
end type

const XML_SCHEMAS_ANYATTR_SKIP = 1
const XML_SCHEMAS_ANYATTR_LAX = 2
const XML_SCHEMAS_ANYATTR_STRICT = 3
const XML_SCHEMAS_ANY_SKIP = 1
const XML_SCHEMAS_ANY_LAX = 2
const XML_SCHEMAS_ANY_STRICT = 3
const XML_SCHEMAS_ATTR_USE_PROHIBITED = 0
const XML_SCHEMAS_ATTR_USE_REQUIRED = 1
const XML_SCHEMAS_ATTR_USE_OPTIONAL = 2
const XML_SCHEMAS_ATTR_GLOBAL = 1 shl 0
const XML_SCHEMAS_ATTR_NSDEFAULT = 1 shl 7
const XML_SCHEMAS_ATTR_INTERNAL_RESOLVED = 1 shl 8
const XML_SCHEMAS_ATTR_FIXED = 1 shl 9
type xmlSchemaAttribute as _xmlSchemaAttribute
type xmlSchemaAttributePtr as xmlSchemaAttribute ptr

type _xmlSchemaAttribute
	as xmlSchemaTypeType type
	next as _xmlSchemaAttribute ptr
	name as const xmlChar ptr
	id as const xmlChar ptr
	ref as const xmlChar ptr
	refNs as const xmlChar ptr
	typeName as const xmlChar ptr
	typeNs as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	base as xmlSchemaTypePtr
	occurs as long
	defValue as const xmlChar ptr
	subtypes as xmlSchemaTypePtr
	node as xmlNodePtr
	targetNamespace as const xmlChar ptr
	flags as long
	refPrefix as const xmlChar ptr
	defVal as xmlSchemaValPtr
	refDecl as xmlSchemaAttributePtr
end type

type xmlSchemaAttributeLink as _xmlSchemaAttributeLink
type xmlSchemaAttributeLinkPtr as xmlSchemaAttributeLink ptr

type _xmlSchemaAttributeLink
	next as _xmlSchemaAttributeLink ptr
	attr as _xmlSchemaAttribute ptr
end type

const XML_SCHEMAS_WILDCARD_COMPLETE = 1 shl 0
type xmlSchemaWildcardNs as _xmlSchemaWildcardNs
type xmlSchemaWildcardNsPtr as xmlSchemaWildcardNs ptr

type _xmlSchemaWildcardNs
	next as _xmlSchemaWildcardNs ptr
	value as const xmlChar ptr
end type

type xmlSchemaWildcard as _xmlSchemaWildcard
type xmlSchemaWildcardPtr as xmlSchemaWildcard ptr

type _xmlSchemaWildcard
	as xmlSchemaTypeType type
	id as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	node as xmlNodePtr
	minOccurs as long
	maxOccurs as long
	processContents as long
	any as long
	nsSet as xmlSchemaWildcardNsPtr
	negNsSet as xmlSchemaWildcardNsPtr
	flags as long
end type

const XML_SCHEMAS_ATTRGROUP_WILDCARD_BUILDED = 1 shl 0
const XML_SCHEMAS_ATTRGROUP_GLOBAL = 1 shl 1
const XML_SCHEMAS_ATTRGROUP_MARKED = 1 shl 2
const XML_SCHEMAS_ATTRGROUP_REDEFINED = 1 shl 3
const XML_SCHEMAS_ATTRGROUP_HAS_REFS = 1 shl 4
type xmlSchemaAttributeGroup as _xmlSchemaAttributeGroup
type xmlSchemaAttributeGroupPtr as xmlSchemaAttributeGroup ptr

type _xmlSchemaAttributeGroup
	as xmlSchemaTypeType type
	next as _xmlSchemaAttribute ptr
	name as const xmlChar ptr
	id as const xmlChar ptr
	ref as const xmlChar ptr
	refNs as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	attributes as xmlSchemaAttributePtr
	node as xmlNodePtr
	flags as long
	attributeWildcard as xmlSchemaWildcardPtr
	refPrefix as const xmlChar ptr
	refItem as xmlSchemaAttributeGroupPtr
	targetNamespace as const xmlChar ptr
	attrUses as any ptr
end type

type xmlSchemaTypeLink as _xmlSchemaTypeLink
type xmlSchemaTypeLinkPtr as xmlSchemaTypeLink ptr

type _xmlSchemaTypeLink
	next as _xmlSchemaTypeLink ptr
	as xmlSchemaTypePtr type
end type

type xmlSchemaFacetLink as _xmlSchemaFacetLink
type xmlSchemaFacetLinkPtr as xmlSchemaFacetLink ptr

type _xmlSchemaFacetLink
	next as _xmlSchemaFacetLink ptr
	facet as xmlSchemaFacetPtr
end type

const XML_SCHEMAS_TYPE_MIXED = 1 shl 0
const XML_SCHEMAS_TYPE_DERIVATION_METHOD_EXTENSION = 1 shl 1
const XML_SCHEMAS_TYPE_DERIVATION_METHOD_RESTRICTION = 1 shl 2
const XML_SCHEMAS_TYPE_GLOBAL = 1 shl 3
const XML_SCHEMAS_TYPE_OWNED_ATTR_WILDCARD = 1 shl 4
const XML_SCHEMAS_TYPE_VARIETY_ABSENT = 1 shl 5
const XML_SCHEMAS_TYPE_VARIETY_LIST = 1 shl 6
const XML_SCHEMAS_TYPE_VARIETY_UNION = 1 shl 7
const XML_SCHEMAS_TYPE_VARIETY_ATOMIC = 1 shl 8
const XML_SCHEMAS_TYPE_FINAL_EXTENSION = 1 shl 9
const XML_SCHEMAS_TYPE_FINAL_RESTRICTION = 1 shl 10
const XML_SCHEMAS_TYPE_FINAL_LIST = 1 shl 11
const XML_SCHEMAS_TYPE_FINAL_UNION = 1 shl 12
const XML_SCHEMAS_TYPE_FINAL_DEFAULT = 1 shl 13
const XML_SCHEMAS_TYPE_BUILTIN_PRIMITIVE = 1 shl 14
const XML_SCHEMAS_TYPE_MARKED = 1 shl 16
const XML_SCHEMAS_TYPE_BLOCK_DEFAULT = 1 shl 17
const XML_SCHEMAS_TYPE_BLOCK_EXTENSION = 1 shl 18
const XML_SCHEMAS_TYPE_BLOCK_RESTRICTION = 1 shl 19
const XML_SCHEMAS_TYPE_ABSTRACT = 1 shl 20
const XML_SCHEMAS_TYPE_FACETSNEEDVALUE = 1 shl 21
const XML_SCHEMAS_TYPE_INTERNAL_RESOLVED = 1 shl 22
const XML_SCHEMAS_TYPE_INTERNAL_INVALID = 1 shl 23
const XML_SCHEMAS_TYPE_WHITESPACE_PRESERVE = 1 shl 24
const XML_SCHEMAS_TYPE_WHITESPACE_REPLACE = 1 shl 25
const XML_SCHEMAS_TYPE_WHITESPACE_COLLAPSE = 1 shl 26
const XML_SCHEMAS_TYPE_HAS_FACETS = 1 shl 27
const XML_SCHEMAS_TYPE_NORMVALUENEEDED = 1 shl 28
const XML_SCHEMAS_TYPE_FIXUP_1 = 1 shl 29
const XML_SCHEMAS_TYPE_REDEFINED = 1 shl 30

type _xmlSchemaType
	as xmlSchemaTypeType type
	next as _xmlSchemaType ptr
	name as const xmlChar ptr
	id as const xmlChar ptr
	ref as const xmlChar ptr
	refNs as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	subtypes as xmlSchemaTypePtr
	attributes as xmlSchemaAttributePtr
	node as xmlNodePtr
	minOccurs as long
	maxOccurs as long
	flags as long
	contentType as xmlSchemaContentType
	base as const xmlChar ptr
	baseNs as const xmlChar ptr
	baseType as xmlSchemaTypePtr
	facets as xmlSchemaFacetPtr
	redef as _xmlSchemaType ptr
	recurse as long
	attributeUses as xmlSchemaAttributeLinkPtr ptr
	attributeWildcard as xmlSchemaWildcardPtr
	builtInType as long
	memberTypes as xmlSchemaTypeLinkPtr
	facetSet as xmlSchemaFacetLinkPtr
	refPrefix as const xmlChar ptr
	contentTypeDef as xmlSchemaTypePtr
	contModel as xmlRegexpPtr
	targetNamespace as const xmlChar ptr
	attrUses as any ptr
end type

const XML_SCHEMAS_ELEM_NILLABLE = 1 shl 0
const XML_SCHEMAS_ELEM_GLOBAL = 1 shl 1
const XML_SCHEMAS_ELEM_DEFAULT = 1 shl 2
const XML_SCHEMAS_ELEM_FIXED = 1 shl 3
const XML_SCHEMAS_ELEM_ABSTRACT = 1 shl 4
const XML_SCHEMAS_ELEM_TOPLEVEL = 1 shl 5
const XML_SCHEMAS_ELEM_REF = 1 shl 6
const XML_SCHEMAS_ELEM_NSDEFAULT = 1 shl 7
const XML_SCHEMAS_ELEM_INTERNAL_RESOLVED = 1 shl 8
const XML_SCHEMAS_ELEM_CIRCULAR = 1 shl 9
const XML_SCHEMAS_ELEM_BLOCK_ABSENT = 1 shl 10
const XML_SCHEMAS_ELEM_BLOCK_EXTENSION = 1 shl 11
const XML_SCHEMAS_ELEM_BLOCK_RESTRICTION = 1 shl 12
const XML_SCHEMAS_ELEM_BLOCK_SUBSTITUTION = 1 shl 13
const XML_SCHEMAS_ELEM_FINAL_ABSENT = 1 shl 14
const XML_SCHEMAS_ELEM_FINAL_EXTENSION = 1 shl 15
const XML_SCHEMAS_ELEM_FINAL_RESTRICTION = 1 shl 16
const XML_SCHEMAS_ELEM_SUBST_GROUP_HEAD = 1 shl 17
const XML_SCHEMAS_ELEM_INTERNAL_CHECKED = 1 shl 18
type xmlSchemaElement as _xmlSchemaElement
type xmlSchemaElementPtr as xmlSchemaElement ptr

type _xmlSchemaElement
	as xmlSchemaTypeType type
	next as _xmlSchemaType ptr
	name as const xmlChar ptr
	id as const xmlChar ptr
	ref as const xmlChar ptr
	refNs as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	subtypes as xmlSchemaTypePtr
	attributes as xmlSchemaAttributePtr
	node as xmlNodePtr
	minOccurs as long
	maxOccurs as long
	flags as long
	targetNamespace as const xmlChar ptr
	namedType as const xmlChar ptr
	namedTypeNs as const xmlChar ptr
	substGroup as const xmlChar ptr
	substGroupNs as const xmlChar ptr
	scope as const xmlChar ptr
	value as const xmlChar ptr
	refDecl as _xmlSchemaElement ptr
	contModel as xmlRegexpPtr
	contentType as xmlSchemaContentType
	refPrefix as const xmlChar ptr
	defVal as xmlSchemaValPtr
	idcs as any ptr
end type

const XML_SCHEMAS_FACET_UNKNOWN = 0
const XML_SCHEMAS_FACET_PRESERVE = 1
const XML_SCHEMAS_FACET_REPLACE = 2
const XML_SCHEMAS_FACET_COLLAPSE = 3

type _xmlSchemaFacet
	as xmlSchemaTypeType type
	next as _xmlSchemaFacet ptr
	value as const xmlChar ptr
	id as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	node as xmlNodePtr
	fixed as long
	whitespace as long
	val as xmlSchemaValPtr
	regexp as xmlRegexpPtr
end type

type xmlSchemaNotation as _xmlSchemaNotation
type xmlSchemaNotationPtr as xmlSchemaNotation ptr

type _xmlSchemaNotation
	as xmlSchemaTypeType type
	name as const xmlChar ptr
	annot as xmlSchemaAnnotPtr
	identifier as const xmlChar ptr
	targetNamespace as const xmlChar ptr
end type

const XML_SCHEMAS_QUALIF_ELEM = 1 shl 0
const XML_SCHEMAS_QUALIF_ATTR = 1 shl 1
const XML_SCHEMAS_FINAL_DEFAULT_EXTENSION = 1 shl 2
const XML_SCHEMAS_FINAL_DEFAULT_RESTRICTION = 1 shl 3
const XML_SCHEMAS_FINAL_DEFAULT_LIST = 1 shl 4
const XML_SCHEMAS_FINAL_DEFAULT_UNION = 1 shl 5
const XML_SCHEMAS_BLOCK_DEFAULT_EXTENSION = 1 shl 6
const XML_SCHEMAS_BLOCK_DEFAULT_RESTRICTION = 1 shl 7
const XML_SCHEMAS_BLOCK_DEFAULT_SUBSTITUTION = 1 shl 8
const XML_SCHEMAS_INCLUDING_CONVERT_NS = 1 shl 9

type _xmlSchema
	name as const xmlChar ptr
	targetNamespace as const xmlChar ptr
	version as const xmlChar ptr
	id as const xmlChar ptr
	doc as xmlDocPtr
	annot as xmlSchemaAnnotPtr
	flags as long
	typeDecl as xmlHashTablePtr
	attrDecl as xmlHashTablePtr
	attrgrpDecl as xmlHashTablePtr
	elemDecl as xmlHashTablePtr
	notaDecl as xmlHashTablePtr
	schemasImports as xmlHashTablePtr
	_private as any ptr
	groupDecl as xmlHashTablePtr
	dict as xmlDictPtr
	includes as any ptr
	preserve as long
	counter as long
	idcDef as xmlHashTablePtr
	volatiles as any ptr
end type

declare sub xmlSchemaFreeType(byval type as xmlSchemaTypePtr)
declare sub xmlSchemaFreeWildcard(byval wildcard as xmlSchemaWildcardPtr)

end extern
