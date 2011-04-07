''
''
'' globals -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_globals_bi__
#define __xml_globals_bi__

#include once "xmlversion.bi"
#include once "parser.bi"
#include once "xmlerror.bi"
#include once "parser.bi"
#include once "SAX.bi"
#include once "SAX2.bi"

type xmlParserInputBufferCreateFilenameFunc as xmlParserInputBufferPtr ptr
type xmlOutputBufferCreateFilenameFunc as xmlOutputBufferPtr ptr

type xmlRegisterNodeFunc as any ptr
type xmlDeregisterNodeFunc as any ptr
type xmlGlobalState as _xmlGlobalState
type xmlGlobalStatePtr as xmlGlobalState ptr

type _xmlGlobalState
	xmlParserVersion as byte ptr
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
	oldXMLWDcompatibility as integer
	xmlBufferAllocScheme as xmlBufferAllocationScheme
	xmlDefaultBufferSize as integer
	xmlSubstituteEntitiesDefaultValue as integer
	xmlDoValidityCheckingDefaultValue as integer
	xmlGetWarningsDefaultValue as integer
	xmlKeepBlanksDefaultValue as integer
	xmlLineNumbersDefaultValue as integer
	xmlLoadExtDtdDefaultValue as integer
	xmlParserDebugEntities as integer
	xmlPedanticParserDefaultValue as integer
	xmlSaveNoEmptyTags as integer
	xmlIndentTreeOutput as integer
	xmlTreeIndentString as byte ptr
	xmlRegisterNodeDefaultValue as xmlRegisterNodeFunc
	xmlDeregisterNodeDefaultValue as xmlDeregisterNodeFunc
	xmlMallocAtomic as xmlMallocFunc
	xmlLastError as xmlError
	xmlParserInputBufferCreateFilenameValue as xmlParserInputBufferCreateFilenameFunc
	xmlOutputBufferCreateFilenameValue as xmlOutputBufferCreateFilenameFunc
end type

#include once "threads.bi"

extern "c"
declare sub xmlInitGlobals ()
declare sub xmlCleanupGlobals ()
declare function xmlParserInputBufferCreateFilenameDefault (byval func as xmlParserInputBufferCreateFilenameFunc) as xmlParserInputBufferCreateFilenameFunc
declare function xmlOutputBufferCreateFilenameDefault (byval func as xmlOutputBufferCreateFilenameFunc) as xmlOutputBufferCreateFilenameFunc
declare sub xmlInitializeGlobalState (byval gs as xmlGlobalStatePtr)
declare sub xmlThrDefSetGenericErrorFunc (byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xmlThrDefSetStructuredErrorFunc (byval ctx as any ptr, byval handler as xmlStructuredErrorFunc)
declare function xmlRegisterNodeDefault (byval func as xmlRegisterNodeFunc) as xmlRegisterNodeFunc
declare function xmlThrDefRegisterNodeDefault (byval func as xmlRegisterNodeFunc) as xmlRegisterNodeFunc
declare function xmlDeregisterNodeDefault (byval func as xmlDeregisterNodeFunc) as xmlDeregisterNodeFunc
declare function xmlThrDefDeregisterNodeDefault (byval func as xmlDeregisterNodeFunc) as xmlDeregisterNodeFunc
declare function xmlThrDefOutputBufferCreateFilenameDefault (byval func as xmlOutputBufferCreateFilenameFunc) as xmlOutputBufferCreateFilenameFunc
declare function xmlThrDefParserInputBufferCreateFilenameDefault (byval func as xmlParserInputBufferCreateFilenameFunc) as xmlParserInputBufferCreateFilenameFunc
declare function __docbDefaultSAXHandler () as xmlSAXHandlerV1 ptr
declare function __htmlDefaultSAXHandler () as xmlSAXHandlerV1 ptr
declare function __xmlLastError () as xmlError ptr
declare function __oldXMLWDcompatibility () as integer ptr
declare function __xmlBufferAllocScheme () as xmlBufferAllocationScheme ptr
declare function xmlThrDefBufferAllocScheme (byval v as xmlBufferAllocationScheme) as xmlBufferAllocationScheme
declare function __xmlDefaultBufferSize () as integer ptr
declare function xmlThrDefDefaultBufferSize (byval v as integer) as integer
declare function __xmlDefaultSAXHandler () as xmlSAXHandlerV1 ptr
declare function __xmlDefaultSAXLocator () as xmlSAXLocator ptr
declare function __xmlDoValidityCheckingDefaultValue () as integer ptr
declare function xmlThrDefDoValidityCheckingDefaultValue (byval v as integer) as integer
declare function __xmlGenericError () as xmlGenericErrorFunc ptr
declare function __xmlStructuredError () as xmlStructuredErrorFunc ptr
declare function __xmlGenericErrorContext () as any ptr ptr
declare function __xmlGetWarningsDefaultValue () as integer ptr
declare function xmlThrDefGetWarningsDefaultValue (byval v as integer) as integer
declare function __xmlIndentTreeOutput () as integer ptr
declare function xmlThrDefIndentTreeOutput (byval v as integer) as integer
declare function __xmlTreeIndentString () as byte ptr ptr
declare function xmlThrDefTreeIndentString (byval v as zstring ptr) as byte ptr
declare function __xmlKeepBlanksDefaultValue () as integer ptr
declare function xmlThrDefKeepBlanksDefaultValue (byval v as integer) as integer
declare function __xmlLineNumbersDefaultValue () as integer ptr
declare function xmlThrDefLineNumbersDefaultValue (byval v as integer) as integer
declare function __xmlLoadExtDtdDefaultValue () as integer ptr
declare function xmlThrDefLoadExtDtdDefaultValue (byval v as integer) as integer
declare function __xmlParserDebugEntities () as integer ptr
declare function xmlThrDefParserDebugEntities (byval v as integer) as integer
declare function __xmlParserVersion () as byte ptr ptr
declare function __xmlPedanticParserDefaultValue () as integer ptr
declare function xmlThrDefPedanticParserDefaultValue (byval v as integer) as integer
declare function __xmlSaveNoEmptyTags () as integer ptr
declare function xmlThrDefSaveNoEmptyTags (byval v as integer) as integer
declare function __xmlSubstituteEntitiesDefaultValue () as integer ptr
declare function xmlThrDefSubstituteEntitiesDefaultValue (byval v as integer) as integer
declare function __xmlRegisterNodeDefaultValue () as xmlRegisterNodeFunc ptr
declare function __xmlDeregisterNodeDefaultValue () as xmlDeregisterNodeFunc ptr
declare function __xmlParserInputBufferCreateFilenameValue () as xmlParserInputBufferCreateFilenameFunc ptr
declare function __xmlOutputBufferCreateFilenameValue () as xmlOutputBufferCreateFilenameFunc ptr
end extern

#endif
