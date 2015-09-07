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
#include once "libxml/xmlversion.bi"
#include once "libxml/schemasInternals.bi"
#include once "libxml/xmlschemas.bi"

extern "C"

#define __XML_SCHEMA_TYPES_H__

type xmlSchemaWhitespaceValueType as long
enum
	XML_SCHEMA_WHITESPACE_UNKNOWN = 0
	XML_SCHEMA_WHITESPACE_PRESERVE = 1
	XML_SCHEMA_WHITESPACE_REPLACE = 2
	XML_SCHEMA_WHITESPACE_COLLAPSE = 3
end enum

declare sub xmlSchemaInitTypes()
declare sub xmlSchemaCleanupTypes()
declare function xmlSchemaGetPredefinedType(byval name as const xmlChar ptr, byval ns as const xmlChar ptr) as xmlSchemaTypePtr
declare function xmlSchemaValidatePredefinedType(byval type as xmlSchemaTypePtr, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr ptr) as long
declare function xmlSchemaValPredefTypeNode(byval type as xmlSchemaTypePtr, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr ptr, byval node as xmlNodePtr) as long
declare function xmlSchemaValidateFacet(byval base as xmlSchemaTypePtr, byval facet as xmlSchemaFacetPtr, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr) as long
declare function xmlSchemaValidateFacetWhtsp(byval facet as xmlSchemaFacetPtr, byval fws as xmlSchemaWhitespaceValueType, byval valType as xmlSchemaValType, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr, byval ws as xmlSchemaWhitespaceValueType) as long
declare sub xmlSchemaFreeValue(byval val as xmlSchemaValPtr)
declare function xmlSchemaNewFacet() as xmlSchemaFacetPtr
declare function xmlSchemaCheckFacet(byval facet as xmlSchemaFacetPtr, byval typeDecl as xmlSchemaTypePtr, byval ctxt as xmlSchemaParserCtxtPtr, byval name as const xmlChar ptr) as long
declare sub xmlSchemaFreeFacet(byval facet as xmlSchemaFacetPtr)
declare function xmlSchemaCompareValues(byval x as xmlSchemaValPtr, byval y as xmlSchemaValPtr) as long
declare function xmlSchemaGetBuiltInListSimpleTypeItemType(byval type as xmlSchemaTypePtr) as xmlSchemaTypePtr
declare function xmlSchemaValidateListSimpleTypeFacet(byval facet as xmlSchemaFacetPtr, byval value as const xmlChar ptr, byval actualLen as culong, byval expectedLen as culong ptr) as long
declare function xmlSchemaGetBuiltInType(byval type as xmlSchemaValType) as xmlSchemaTypePtr
declare function xmlSchemaIsBuiltInTypeFacet(byval type as xmlSchemaTypePtr, byval facetType as long) as long
declare function xmlSchemaCollapseString(byval value as const xmlChar ptr) as xmlChar ptr
declare function xmlSchemaWhiteSpaceReplace(byval value as const xmlChar ptr) as xmlChar ptr
declare function xmlSchemaGetFacetValueAsULong(byval facet as xmlSchemaFacetPtr) as culong
declare function xmlSchemaValidateLengthFacet(byval type as xmlSchemaTypePtr, byval facet as xmlSchemaFacetPtr, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr, byval length as culong ptr) as long
declare function xmlSchemaValidateLengthFacetWhtsp(byval facet as xmlSchemaFacetPtr, byval valType as xmlSchemaValType, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr, byval length as culong ptr, byval ws as xmlSchemaWhitespaceValueType) as long
declare function xmlSchemaValPredefTypeNodeNoNorm(byval type as xmlSchemaTypePtr, byval value as const xmlChar ptr, byval val as xmlSchemaValPtr ptr, byval node as xmlNodePtr) as long
declare function xmlSchemaGetCanonValue(byval val as xmlSchemaValPtr, byval retValue as const xmlChar ptr ptr) as long
declare function xmlSchemaGetCanonValueWhtsp(byval val as xmlSchemaValPtr, byval retValue as const xmlChar ptr ptr, byval ws as xmlSchemaWhitespaceValueType) as long
declare function xmlSchemaValueAppend(byval prev as xmlSchemaValPtr, byval cur as xmlSchemaValPtr) as long
declare function xmlSchemaValueGetNext(byval cur as xmlSchemaValPtr) as xmlSchemaValPtr
declare function xmlSchemaValueGetAsString(byval val as xmlSchemaValPtr) as const xmlChar ptr
declare function xmlSchemaValueGetAsBoolean(byval val as xmlSchemaValPtr) as long
declare function xmlSchemaNewStringValue(byval type as xmlSchemaValType, byval value as const xmlChar ptr) as xmlSchemaValPtr
declare function xmlSchemaNewNOTATIONValue(byval name as const xmlChar ptr, byval ns as const xmlChar ptr) as xmlSchemaValPtr
declare function xmlSchemaNewQNameValue(byval namespaceName as const xmlChar ptr, byval localName as const xmlChar ptr) as xmlSchemaValPtr
declare function xmlSchemaCompareValuesWhtsp(byval x as xmlSchemaValPtr, byval xws as xmlSchemaWhitespaceValueType, byval y as xmlSchemaValPtr, byval yws as xmlSchemaWhitespaceValueType) as long
declare function xmlSchemaCopyValue(byval val as xmlSchemaValPtr) as xmlSchemaValPtr
declare function xmlSchemaGetValType(byval val as xmlSchemaValPtr) as xmlSchemaValType

end extern
