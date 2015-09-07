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
#include once "libxml/hash.bi"
#include once "libxml/xmlstring.bi"

extern "C"

#define __XML_RELAX_NG__
type xmlRelaxNG as _xmlRelaxNG
type xmlRelaxNGPtr as xmlRelaxNG ptr
type xmlRelaxNGValidityErrorFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlRelaxNGValidityWarningFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlRelaxNGParserCtxt as _xmlRelaxNGParserCtxt
type xmlRelaxNGParserCtxtPtr as xmlRelaxNGParserCtxt ptr
type xmlRelaxNGValidCtxt as _xmlRelaxNGValidCtxt
type xmlRelaxNGValidCtxtPtr as xmlRelaxNGValidCtxt ptr

type xmlRelaxNGValidErr as long
enum
	XML_RELAXNG_OK = 0
	XML_RELAXNG_ERR_MEMORY
	XML_RELAXNG_ERR_TYPE
	XML_RELAXNG_ERR_TYPEVAL
	XML_RELAXNG_ERR_DUPID
	XML_RELAXNG_ERR_TYPECMP
	XML_RELAXNG_ERR_NOSTATE
	XML_RELAXNG_ERR_NODEFINE
	XML_RELAXNG_ERR_LISTEXTRA
	XML_RELAXNG_ERR_LISTEMPTY
	XML_RELAXNG_ERR_INTERNODATA
	XML_RELAXNG_ERR_INTERSEQ
	XML_RELAXNG_ERR_INTEREXTRA
	XML_RELAXNG_ERR_ELEMNAME
	XML_RELAXNG_ERR_ATTRNAME
	XML_RELAXNG_ERR_ELEMNONS
	XML_RELAXNG_ERR_ATTRNONS
	XML_RELAXNG_ERR_ELEMWRONGNS
	XML_RELAXNG_ERR_ATTRWRONGNS
	XML_RELAXNG_ERR_ELEMEXTRANS
	XML_RELAXNG_ERR_ATTREXTRANS
	XML_RELAXNG_ERR_ELEMNOTEMPTY
	XML_RELAXNG_ERR_NOELEM
	XML_RELAXNG_ERR_NOTELEM
	XML_RELAXNG_ERR_ATTRVALID
	XML_RELAXNG_ERR_CONTENTVALID
	XML_RELAXNG_ERR_EXTRACONTENT
	XML_RELAXNG_ERR_INVALIDATTR
	XML_RELAXNG_ERR_DATAELEM
	XML_RELAXNG_ERR_VALELEM
	XML_RELAXNG_ERR_LISTELEM
	XML_RELAXNG_ERR_DATATYPE
	XML_RELAXNG_ERR_VALUE
	XML_RELAXNG_ERR_LIST
	XML_RELAXNG_ERR_NOGRAMMAR
	XML_RELAXNG_ERR_EXTRADATA
	XML_RELAXNG_ERR_LACKDATA
	XML_RELAXNG_ERR_INTERNAL
	XML_RELAXNG_ERR_ELEMWRONG
	XML_RELAXNG_ERR_TEXTWRONG
end enum

type xmlRelaxNGParserFlag as long
enum
	XML_RELAXNGP_NONE = 0
	XML_RELAXNGP_FREE_DOC = 1
	XML_RELAXNGP_CRNG = 2
end enum

declare function xmlRelaxNGInitTypes() as long
declare sub xmlRelaxNGCleanupTypes()
declare function xmlRelaxNGNewParserCtxt(byval URL as const zstring ptr) as xmlRelaxNGParserCtxtPtr
declare function xmlRelaxNGNewMemParserCtxt(byval buffer as const zstring ptr, byval size as long) as xmlRelaxNGParserCtxtPtr
declare function xmlRelaxNGNewDocParserCtxt(byval doc as xmlDocPtr) as xmlRelaxNGParserCtxtPtr
declare function xmlRelaxParserSetFlag(byval ctxt as xmlRelaxNGParserCtxtPtr, byval flag as long) as long
declare sub xmlRelaxNGFreeParserCtxt(byval ctxt as xmlRelaxNGParserCtxtPtr)
declare sub xmlRelaxNGSetParserErrors(byval ctxt as xmlRelaxNGParserCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc, byval warn as xmlRelaxNGValidityWarningFunc, byval ctx as any ptr)
declare function xmlRelaxNGGetParserErrors(byval ctxt as xmlRelaxNGParserCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc ptr, byval warn as xmlRelaxNGValidityWarningFunc ptr, byval ctx as any ptr ptr) as long
declare sub xmlRelaxNGSetParserStructuredErrors(byval ctxt as xmlRelaxNGParserCtxtPtr, byval serror as xmlStructuredErrorFunc, byval ctx as any ptr)
declare function xmlRelaxNGParse(byval ctxt as xmlRelaxNGParserCtxtPtr) as xmlRelaxNGPtr
declare sub xmlRelaxNGFree(byval schema as xmlRelaxNGPtr)
declare sub xmlRelaxNGDump(byval output as FILE ptr, byval schema as xmlRelaxNGPtr)
declare sub xmlRelaxNGDumpTree(byval output as FILE ptr, byval schema as xmlRelaxNGPtr)
declare sub xmlRelaxNGSetValidErrors(byval ctxt as xmlRelaxNGValidCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc, byval warn as xmlRelaxNGValidityWarningFunc, byval ctx as any ptr)
declare function xmlRelaxNGGetValidErrors(byval ctxt as xmlRelaxNGValidCtxtPtr, byval err as xmlRelaxNGValidityErrorFunc ptr, byval warn as xmlRelaxNGValidityWarningFunc ptr, byval ctx as any ptr ptr) as long
declare sub xmlRelaxNGSetValidStructuredErrors(byval ctxt as xmlRelaxNGValidCtxtPtr, byval serror as xmlStructuredErrorFunc, byval ctx as any ptr)
declare function xmlRelaxNGNewValidCtxt(byval schema as xmlRelaxNGPtr) as xmlRelaxNGValidCtxtPtr
declare sub xmlRelaxNGFreeValidCtxt(byval ctxt as xmlRelaxNGValidCtxtPtr)
declare function xmlRelaxNGValidateDoc(byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr) as long
declare function xmlRelaxNGValidatePushElement(byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as long
declare function xmlRelaxNGValidatePushCData(byval ctxt as xmlRelaxNGValidCtxtPtr, byval data as const xmlChar ptr, byval len as long) as long
declare function xmlRelaxNGValidatePopElement(byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as long
declare function xmlRelaxNGValidateFullElement(byval ctxt as xmlRelaxNGValidCtxtPtr, byval doc as xmlDocPtr, byval elem as xmlNodePtr) as long

end extern
