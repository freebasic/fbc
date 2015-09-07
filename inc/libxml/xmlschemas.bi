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
#include once "libxml/tree.bi"

extern "C"

#define __XML_SCHEMA_H__

type xmlSchemaValidError as long
enum
	XML_SCHEMAS_ERR_OK = 0
	XML_SCHEMAS_ERR_NOROOT = 1
	XML_SCHEMAS_ERR_UNDECLAREDELEM
	XML_SCHEMAS_ERR_NOTTOPLEVEL
	XML_SCHEMAS_ERR_MISSING
	XML_SCHEMAS_ERR_WRONGELEM
	XML_SCHEMAS_ERR_NOTYPE
	XML_SCHEMAS_ERR_NOROLLBACK
	XML_SCHEMAS_ERR_ISABSTRACT
	XML_SCHEMAS_ERR_NOTEMPTY
	XML_SCHEMAS_ERR_ELEMCONT
	XML_SCHEMAS_ERR_HAVEDEFAULT
	XML_SCHEMAS_ERR_NOTNILLABLE
	XML_SCHEMAS_ERR_EXTRACONTENT
	XML_SCHEMAS_ERR_INVALIDATTR
	XML_SCHEMAS_ERR_INVALIDELEM
	XML_SCHEMAS_ERR_NOTDETERMINIST
	XML_SCHEMAS_ERR_CONSTRUCT
	XML_SCHEMAS_ERR_INTERNAL
	XML_SCHEMAS_ERR_NOTSIMPLE
	XML_SCHEMAS_ERR_ATTRUNKNOWN
	XML_SCHEMAS_ERR_ATTRINVALID
	XML_SCHEMAS_ERR_VALUE
	XML_SCHEMAS_ERR_FACET
	XML_SCHEMAS_ERR_
	XML_SCHEMAS_ERR_XXX
end enum

type xmlSchemaValidOption as long
enum
	XML_SCHEMA_VAL_VC_I_CREATE = 1 shl 0
end enum

type xmlSchema as _xmlSchema
type xmlSchemaPtr as xmlSchema ptr
type xmlSchemaValidityErrorFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlSchemaValidityWarningFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlSchemaParserCtxt as _xmlSchemaParserCtxt
type xmlSchemaParserCtxtPtr as xmlSchemaParserCtxt ptr
type xmlSchemaValidCtxt as _xmlSchemaValidCtxt
type xmlSchemaValidCtxtPtr as xmlSchemaValidCtxt ptr
type xmlSchemaValidityLocatorFunc as function(byval ctx as any ptr, byval file as const zstring ptr ptr, byval line as culong ptr) as long

declare function xmlSchemaNewParserCtxt(byval URL as const zstring ptr) as xmlSchemaParserCtxtPtr
declare function xmlSchemaNewMemParserCtxt(byval buffer as const zstring ptr, byval size as long) as xmlSchemaParserCtxtPtr
declare function xmlSchemaNewDocParserCtxt(byval doc as xmlDocPtr) as xmlSchemaParserCtxtPtr
declare sub xmlSchemaFreeParserCtxt(byval ctxt as xmlSchemaParserCtxtPtr)
declare sub xmlSchemaSetParserErrors(byval ctxt as xmlSchemaParserCtxtPtr, byval err as xmlSchemaValidityErrorFunc, byval warn as xmlSchemaValidityWarningFunc, byval ctx as any ptr)
declare sub xmlSchemaSetParserStructuredErrors(byval ctxt as xmlSchemaParserCtxtPtr, byval serror as xmlStructuredErrorFunc, byval ctx as any ptr)
declare function xmlSchemaGetParserErrors(byval ctxt as xmlSchemaParserCtxtPtr, byval err as xmlSchemaValidityErrorFunc ptr, byval warn as xmlSchemaValidityWarningFunc ptr, byval ctx as any ptr ptr) as long
declare function xmlSchemaIsValid(byval ctxt as xmlSchemaValidCtxtPtr) as long
declare function xmlSchemaParse(byval ctxt as xmlSchemaParserCtxtPtr) as xmlSchemaPtr
declare sub xmlSchemaFree(byval schema as xmlSchemaPtr)
declare sub xmlSchemaDump(byval output as FILE ptr, byval schema as xmlSchemaPtr)
declare sub xmlSchemaSetValidErrors(byval ctxt as xmlSchemaValidCtxtPtr, byval err as xmlSchemaValidityErrorFunc, byval warn as xmlSchemaValidityWarningFunc, byval ctx as any ptr)
declare sub xmlSchemaSetValidStructuredErrors(byval ctxt as xmlSchemaValidCtxtPtr, byval serror as xmlStructuredErrorFunc, byval ctx as any ptr)
declare function xmlSchemaGetValidErrors(byval ctxt as xmlSchemaValidCtxtPtr, byval err as xmlSchemaValidityErrorFunc ptr, byval warn as xmlSchemaValidityWarningFunc ptr, byval ctx as any ptr ptr) as long
declare function xmlSchemaSetValidOptions(byval ctxt as xmlSchemaValidCtxtPtr, byval options as long) as long
declare sub xmlSchemaValidateSetFilename(byval vctxt as xmlSchemaValidCtxtPtr, byval filename as const zstring ptr)
declare function xmlSchemaValidCtxtGetOptions(byval ctxt as xmlSchemaValidCtxtPtr) as long
declare function xmlSchemaNewValidCtxt(byval schema as xmlSchemaPtr) as xmlSchemaValidCtxtPtr
declare sub xmlSchemaFreeValidCtxt(byval ctxt as xmlSchemaValidCtxtPtr)
declare function xmlSchemaValidateDoc(byval ctxt as xmlSchemaValidCtxtPtr, byval instance as xmlDocPtr) as long
declare function xmlSchemaValidateOneElement(byval ctxt as xmlSchemaValidCtxtPtr, byval elem as xmlNodePtr) as long
declare function xmlSchemaValidateStream(byval ctxt as xmlSchemaValidCtxtPtr, byval input as xmlParserInputBufferPtr, byval enc as xmlCharEncoding, byval sax as xmlSAXHandlerPtr, byval user_data as any ptr) as long
declare function xmlSchemaValidateFile(byval ctxt as xmlSchemaValidCtxtPtr, byval filename as const zstring ptr, byval options as long) as long
declare function xmlSchemaValidCtxtGetParserCtxt(byval ctxt as xmlSchemaValidCtxtPtr) as xmlParserCtxtPtr
type xmlSchemaSAXPlugStruct as _xmlSchemaSAXPlug
type xmlSchemaSAXPlugPtr as xmlSchemaSAXPlugStruct ptr
declare function xmlSchemaSAXPlug(byval ctxt as xmlSchemaValidCtxtPtr, byval sax as xmlSAXHandlerPtr ptr, byval user_data as any ptr ptr) as xmlSchemaSAXPlugPtr
declare function xmlSchemaSAXUnplug(byval plug as xmlSchemaSAXPlugPtr) as long
declare sub xmlSchemaValidateSetLocator(byval vctxt as xmlSchemaValidCtxtPtr, byval f as xmlSchemaValidityLocatorFunc, byval ctxt as any ptr)

end extern
