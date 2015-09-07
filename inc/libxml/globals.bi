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
#include once "libxml/parser.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/SAX.bi"
#include once "libxml/SAX2.bi"
#include once "libxml/xmlmemory.bi"

extern "C"

#define __XML_GLOBALS_H
declare sub xmlInitGlobals()
declare sub xmlCleanupGlobals()
type xmlParserInputBufferCreateFilenameFunc as function(byval URI as const zstring ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
type xmlOutputBufferCreateFilenameFunc as function(byval URI as const zstring ptr, byval encoder as xmlCharEncodingHandlerPtr, byval compression as long) as xmlOutputBufferPtr
declare function xmlParserInputBufferCreateFilenameDefault(byval func as xmlParserInputBufferCreateFilenameFunc) as xmlParserInputBufferCreateFilenameFunc
declare function xmlOutputBufferCreateFilenameDefault(byval func as xmlOutputBufferCreateFilenameFunc) as xmlOutputBufferCreateFilenameFunc
#undef docbDefaultSAXHandler
#undef htmlDefaultSAXHandler
#undef oldXMLWDcompatibility
#undef xmlBufferAllocScheme
#undef xmlDefaultBufferSize
#undef xmlDefaultSAXHandler
#undef xmlDefaultSAXLocator
#undef xmlDoValidityCheckingDefaultValue
#undef xmlFree
#undef xmlGenericError
#undef xmlStructuredError
#undef xmlGenericErrorContext
#undef xmlStructuredErrorContext
#undef xmlGetWarningsDefaultValue
#undef xmlIndentTreeOutput
#undef xmlTreeIndentString
#undef xmlKeepBlanksDefaultValue
#undef xmlLineNumbersDefaultValue
#undef xmlLoadExtDtdDefaultValue
#undef xmlMalloc
#undef xmlMallocAtomic
#undef xmlMemStrdup
#undef xmlParserDebugEntities
#undef xmlParserVersion
#undef xmlPedanticParserDefaultValue
#undef xmlRealloc
#undef xmlSaveNoEmptyTags
#undef xmlSubstituteEntitiesDefaultValue
#undef xmlRegisterNodeDefaultValue
#undef xmlDeregisterNodeDefaultValue
#undef xmlLastError
#undef xmlParserInputBufferCreateFilenameValue
#undef xmlOutputBufferCreateFilenameValue

type xmlRegisterNodeFunc as sub(byval node as xmlNodePtr)
type xmlDeregisterNodeFunc as sub(byval node as xmlNodePtr)
type xmlGlobalState as _xmlGlobalState
type xmlGlobalStatePtr as xmlGlobalState ptr

type _xmlGlobalState
	xmlParserVersion as const zstring ptr
	xmlDefaultSAXLocator as xmlSAXLocator
	xmlDefaultSAXHandler as xmlSAXHandlerV1
	docbDefaultSAXHandler as xmlSAXHandlerV1
	htmlDefaultSAXHandler as xmlSAXHandlerV1
	xmlFree as xmlFreeFunc
	xmlMalloc as xmlMallocFunc
	xmlMemStrdup as xmlStrdupFunc
	xmlRealloc as xmlReallocFunc
	xmlGenericError as xmlGenericErrorFunc
	xmlStructuredError as xmlStructuredErrorFunc
	xmlGenericErrorContext as any ptr
	oldXMLWDcompatibility as long
	xmlBufferAllocScheme as xmlBufferAllocationScheme
	xmlDefaultBufferSize as long
	xmlSubstituteEntitiesDefaultValue as long
	xmlDoValidityCheckingDefaultValue as long
	xmlGetWarningsDefaultValue as long
	xmlKeepBlanksDefaultValue as long
	xmlLineNumbersDefaultValue as long
	xmlLoadExtDtdDefaultValue as long
	xmlParserDebugEntities as long
	xmlPedanticParserDefaultValue as long
	xmlSaveNoEmptyTags as long
	xmlIndentTreeOutput as long
	xmlTreeIndentString as const zstring ptr
	xmlRegisterNodeDefaultValue as xmlRegisterNodeFunc
	xmlDeregisterNodeDefaultValue as xmlDeregisterNodeFunc
	xmlMallocAtomic as xmlMallocFunc
	xmlLastError as xmlError
	xmlParserInputBufferCreateFilenameValue as xmlParserInputBufferCreateFilenameFunc
	xmlOutputBufferCreateFilenameValue as xmlOutputBufferCreateFilenameFunc
	xmlStructuredErrorContext as any ptr
end type

end extern

#include once "libxml/threads.bi"

extern "C"

declare sub xmlInitializeGlobalState(byval gs as xmlGlobalStatePtr)
declare sub xmlThrDefSetGenericErrorFunc(byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xmlThrDefSetStructuredErrorFunc(byval ctx as any ptr, byval handler as xmlStructuredErrorFunc)
declare function xmlRegisterNodeDefault(byval func as xmlRegisterNodeFunc) as xmlRegisterNodeFunc
declare function xmlThrDefRegisterNodeDefault(byval func as xmlRegisterNodeFunc) as xmlRegisterNodeFunc
declare function xmlDeregisterNodeDefault(byval func as xmlDeregisterNodeFunc) as xmlDeregisterNodeFunc
declare function xmlThrDefDeregisterNodeDefault(byval func as xmlDeregisterNodeFunc) as xmlDeregisterNodeFunc
declare function xmlThrDefOutputBufferCreateFilenameDefault(byval func as xmlOutputBufferCreateFilenameFunc) as xmlOutputBufferCreateFilenameFunc
declare function xmlThrDefParserInputBufferCreateFilenameDefault(byval func as xmlParserInputBufferCreateFilenameFunc) as xmlParserInputBufferCreateFilenameFunc

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlMalloc as xmlMallocFunc
	extern import xmlMallocAtomic as xmlMallocFunc
	extern import xmlRealloc as xmlReallocFunc
	extern import xmlFree as xmlFreeFunc
	extern import xmlMemStrdup as xmlStrdupFunc
#else
	extern xmlMalloc as xmlMallocFunc
	extern xmlMallocAtomic as xmlMallocFunc
	extern xmlRealloc as xmlReallocFunc
	extern xmlFree as xmlFreeFunc
	extern xmlMemStrdup as xmlStrdupFunc
#endif

declare function __docbDefaultSAXHandler() as xmlSAXHandlerV1 ptr
#define docbDefaultSAXHandler (*__docbDefaultSAXHandler())
declare function __htmlDefaultSAXHandler() as xmlSAXHandlerV1 ptr
#define htmlDefaultSAXHandler (*__htmlDefaultSAXHandler())
declare function __xmlLastError() as xmlError ptr
#define xmlLastError (*__xmlLastError())
declare function __oldXMLWDcompatibility() as long ptr
#define oldXMLWDcompatibility (*__oldXMLWDcompatibility())
declare function __xmlBufferAllocScheme() as xmlBufferAllocationScheme ptr
#define xmlBufferAllocScheme (*__xmlBufferAllocScheme())
declare function xmlThrDefBufferAllocScheme(byval v as xmlBufferAllocationScheme) as xmlBufferAllocationScheme
declare function __xmlDefaultBufferSize() as long ptr
#define xmlDefaultBufferSize (*__xmlDefaultBufferSize())
declare function xmlThrDefDefaultBufferSize(byval v as long) as long
declare function __xmlDefaultSAXHandler() as xmlSAXHandlerV1 ptr
#define xmlDefaultSAXHandler (*__xmlDefaultSAXHandler())
declare function __xmlDefaultSAXLocator() as xmlSAXLocator ptr
#define xmlDefaultSAXLocator (*__xmlDefaultSAXLocator())
declare function __xmlDoValidityCheckingDefaultValue() as long ptr
#define xmlDoValidityCheckingDefaultValue (*__xmlDoValidityCheckingDefaultValue())
declare function xmlThrDefDoValidityCheckingDefaultValue(byval v as long) as long
declare function __xmlGenericError() as xmlGenericErrorFunc ptr
#define xmlGenericError (*__xmlGenericError())
declare function __xmlStructuredError() as xmlStructuredErrorFunc ptr
#define xmlStructuredError (*__xmlStructuredError())
declare function __xmlGenericErrorContext() as any ptr ptr
#define xmlGenericErrorContext (*__xmlGenericErrorContext())
declare function __xmlStructuredErrorContext() as any ptr ptr
#define xmlStructuredErrorContext (*__xmlStructuredErrorContext())
declare function __xmlGetWarningsDefaultValue() as long ptr
#define xmlGetWarningsDefaultValue (*__xmlGetWarningsDefaultValue())
declare function xmlThrDefGetWarningsDefaultValue(byval v as long) as long
declare function __xmlIndentTreeOutput() as long ptr
#define xmlIndentTreeOutput (*__xmlIndentTreeOutput())
declare function xmlThrDefIndentTreeOutput(byval v as long) as long
declare function __xmlTreeIndentString() as const zstring ptr ptr
#define xmlTreeIndentString (*__xmlTreeIndentString())
declare function xmlThrDefTreeIndentString(byval v as const zstring ptr) as const zstring ptr
declare function __xmlKeepBlanksDefaultValue() as long ptr
#define xmlKeepBlanksDefaultValue (*__xmlKeepBlanksDefaultValue())
declare function xmlThrDefKeepBlanksDefaultValue(byval v as long) as long
declare function __xmlLineNumbersDefaultValue() as long ptr
#define xmlLineNumbersDefaultValue (*__xmlLineNumbersDefaultValue())
declare function xmlThrDefLineNumbersDefaultValue(byval v as long) as long
declare function __xmlLoadExtDtdDefaultValue() as long ptr
#define xmlLoadExtDtdDefaultValue (*__xmlLoadExtDtdDefaultValue())
declare function xmlThrDefLoadExtDtdDefaultValue(byval v as long) as long
declare function __xmlParserDebugEntities() as long ptr
#define xmlParserDebugEntities (*__xmlParserDebugEntities())
declare function xmlThrDefParserDebugEntities(byval v as long) as long
declare function __xmlParserVersion() as const zstring ptr ptr
#define xmlParserVersion (*__xmlParserVersion())
declare function __xmlPedanticParserDefaultValue() as long ptr
#define xmlPedanticParserDefaultValue (*__xmlPedanticParserDefaultValue())
declare function xmlThrDefPedanticParserDefaultValue(byval v as long) as long
declare function __xmlSaveNoEmptyTags() as long ptr
#define xmlSaveNoEmptyTags (*__xmlSaveNoEmptyTags())
declare function xmlThrDefSaveNoEmptyTags(byval v as long) as long
declare function __xmlSubstituteEntitiesDefaultValue() as long ptr
#define xmlSubstituteEntitiesDefaultValue (*__xmlSubstituteEntitiesDefaultValue())
declare function xmlThrDefSubstituteEntitiesDefaultValue(byval v as long) as long
declare function __xmlRegisterNodeDefaultValue() as xmlRegisterNodeFunc ptr
#define xmlRegisterNodeDefaultValue (*__xmlRegisterNodeDefaultValue())
declare function __xmlDeregisterNodeDefaultValue() as xmlDeregisterNodeFunc ptr
#define xmlDeregisterNodeDefaultValue (*__xmlDeregisterNodeDefaultValue())
declare function __xmlParserInputBufferCreateFilenameValue() as xmlParserInputBufferCreateFilenameFunc ptr
#define xmlParserInputBufferCreateFilenameValue (*__xmlParserInputBufferCreateFilenameValue())
declare function __xmlOutputBufferCreateFilenameValue() as xmlOutputBufferCreateFilenameFunc ptr
#define xmlOutputBufferCreateFilenameValue (*__xmlOutputBufferCreateFilenameValue())

end extern
