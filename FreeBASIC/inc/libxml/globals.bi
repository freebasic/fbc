''
''
'' globals -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#define __xml_globals_bi__
#define __xml_globals_bi__

#include once "libxml/xmlversion.bi"
#include once "libxml/parser.bi"
#include once "libxml/xmlerror.bi"
#include once "libxml/parser.bi"
#include once "libxml/SAX.bi"
#include once "libxml/SAX2.bi"

declare sub xmlInitGlobals cdecl alias "xmlInitGlobals" ()
declare sub xmlCleanupGlobals cdecl alias "xmlCleanupGlobals" ()

type xmlParserInputBufferCreateFilenameFunc as xmlParserInputBufferPtr ptr
type xmlOutputBufferCreateFilenameFunc as xmlOutputBufferPtr ptr

declare function xmlParserInputBufferCreateFilenameDefault cdecl alias "xmlParserInputBufferCreateFilenameDefault" (byval func as xmlParserInputBufferCreateFilenameFunc) as xmlParserInputBufferCreateFilenameFunc
declare function xmlOutputBufferCreateFilenameDefault cdecl alias "xmlOutputBufferCreateFilenameDefault" (byval func as xmlOutputBufferCreateFilenameFunc) as xmlOutputBufferCreateFilenameFunc

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

#include once "libxml/threads.bi"

declare sub xmlInitializeGlobalState cdecl alias "xmlInitializeGlobalState" (byval gs as xmlGlobalStatePtr)
declare sub xmlThrDefSetGenericErrorFunc cdecl alias "xmlThrDefSetGenericErrorFunc" (byval ctx as any ptr, byval handler as xmlGenericErrorFunc)
declare sub xmlThrDefSetStructuredErrorFunc cdecl alias "xmlThrDefSetStructuredErrorFunc" (byval ctx as any ptr, byval handler as xmlStructuredErrorFunc)
declare function xmlRegisterNodeDefault cdecl alias "xmlRegisterNodeDefault" (byval func as xmlRegisterNodeFunc) as xmlRegisterNodeFunc
declare function xmlThrDefRegisterNodeDefault cdecl alias "xmlThrDefRegisterNodeDefault" (byval func as xmlRegisterNodeFunc) as xmlRegisterNodeFunc
declare function xmlDeregisterNodeDefault cdecl alias "xmlDeregisterNodeDefault" (byval func as xmlDeregisterNodeFunc) as xmlDeregisterNodeFunc
declare function xmlThrDefDeregisterNodeDefault cdecl alias "xmlThrDefDeregisterNodeDefault" (byval func as xmlDeregisterNodeFunc) as xmlDeregisterNodeFunc
declare function xmlThrDefOutputBufferCreateFilenameDefault cdecl alias "xmlThrDefOutputBufferCreateFilenameDefault" (byval func as xmlOutputBufferCreateFilenameFunc) as xmlOutputBufferCreateFilenameFunc
declare function xmlThrDefParserInputBufferCreateFilenameDefault cdecl alias "xmlThrDefParserInputBufferCreateFilenameDefault" (byval func as xmlParserInputBufferCreateFilenameFunc) as xmlParserInputBufferCreateFilenameFunc
declare function __docbDefaultSAXHandler cdecl alias "__docbDefaultSAXHandler" () as xmlSAXHandlerV1 ptr
declare function __htmlDefaultSAXHandler cdecl alias "__htmlDefaultSAXHandler" () as xmlSAXHandlerV1 ptr
declare function __xmlLastError cdecl alias "__xmlLastError" () as xmlError ptr
declare function __oldXMLWDcompatibility cdecl alias "__oldXMLWDcompatibility" () as integer ptr
declare function __xmlBufferAllocScheme cdecl alias "__xmlBufferAllocScheme" () as xmlBufferAllocationScheme ptr
declare function xmlThrDefBufferAllocScheme cdecl alias "xmlThrDefBufferAllocScheme" (byval v as xmlBufferAllocationScheme) as xmlBufferAllocationScheme
declare function __xmlDefaultBufferSize cdecl alias "__xmlDefaultBufferSize" () as integer ptr
declare function xmlThrDefDefaultBufferSize cdecl alias "xmlThrDefDefaultBufferSize" (byval v as integer) as integer
declare function __xmlDefaultSAXHandler cdecl alias "__xmlDefaultSAXHandler" () as xmlSAXHandlerV1 ptr
declare function __xmlDefaultSAXLocator cdecl alias "__xmlDefaultSAXLocator" () as xmlSAXLocator ptr
declare function __xmlDoValidityCheckingDefaultValue cdecl alias "__xmlDoValidityCheckingDefaultValue" () as integer ptr
declare function xmlThrDefDoValidityCheckingDefaultValue cdecl alias "xmlThrDefDoValidityCheckingDefaultValue" (byval v as integer) as integer
declare function __xmlGenericError cdecl alias "__xmlGenericError" () as xmlGenericErrorFunc ptr
declare function __xmlStructuredError cdecl alias "__xmlStructuredError" () as xmlStructuredErrorFunc ptr
declare function __xmlGenericErrorContext cdecl alias "__xmlGenericErrorContext" () as any ptr ptr
declare function __xmlGetWarningsDefaultValue cdecl alias "__xmlGetWarningsDefaultValue" () as integer ptr
declare function xmlThrDefGetWarningsDefaultValue cdecl alias "xmlThrDefGetWarningsDefaultValue" (byval v as integer) as integer
declare function __xmlIndentTreeOutput cdecl alias "__xmlIndentTreeOutput" () as integer ptr
declare function xmlThrDefIndentTreeOutput cdecl alias "xmlThrDefIndentTreeOutput" (byval v as integer) as integer
declare function __xmlTreeIndentString cdecl alias "__xmlTreeIndentString" () as byte ptr ptr
declare function xmlThrDefTreeIndentString cdecl alias "xmlThrDefTreeIndentString" (byval v as zstring ptr) as byte ptr
declare function __xmlKeepBlanksDefaultValue cdecl alias "__xmlKeepBlanksDefaultValue" () as integer ptr
declare function xmlThrDefKeepBlanksDefaultValue cdecl alias "xmlThrDefKeepBlanksDefaultValue" (byval v as integer) as integer
declare function __xmlLineNumbersDefaultValue cdecl alias "__xmlLineNumbersDefaultValue" () as integer ptr
declare function xmlThrDefLineNumbersDefaultValue cdecl alias "xmlThrDefLineNumbersDefaultValue" (byval v as integer) as integer
declare function __xmlLoadExtDtdDefaultValue cdecl alias "__xmlLoadExtDtdDefaultValue" () as integer ptr
declare function xmlThrDefLoadExtDtdDefaultValue cdecl alias "xmlThrDefLoadExtDtdDefaultValue" (byval v as integer) as integer
declare function __xmlParserDebugEntities cdecl alias "__xmlParserDebugEntities" () as integer ptr
declare function xmlThrDefParserDebugEntities cdecl alias "xmlThrDefParserDebugEntities" (byval v as integer) as integer
declare function __xmlParserVersion cdecl alias "__xmlParserVersion" () as byte ptr ptr
declare function __xmlPedanticParserDefaultValue cdecl alias "__xmlPedanticParserDefaultValue" () as integer ptr
declare function xmlThrDefPedanticParserDefaultValue cdecl alias "xmlThrDefPedanticParserDefaultValue" (byval v as integer) as integer
declare function __xmlSaveNoEmptyTags cdecl alias "__xmlSaveNoEmptyTags" () as integer ptr
declare function xmlThrDefSaveNoEmptyTags cdecl alias "xmlThrDefSaveNoEmptyTags" (byval v as integer) as integer
declare function __xmlSubstituteEntitiesDefaultValue cdecl alias "__xmlSubstituteEntitiesDefaultValue" () as integer ptr
declare function xmlThrDefSubstituteEntitiesDefaultValue cdecl alias "xmlThrDefSubstituteEntitiesDefaultValue" (byval v as integer) as integer
declare function __xmlRegisterNodeDefaultValue cdecl alias "__xmlRegisterNodeDefaultValue" () as xmlRegisterNodeFunc ptr
declare function __xmlDeregisterNodeDefaultValue cdecl alias "__xmlDeregisterNodeDefaultValue" () as xmlDeregisterNodeFunc ptr
declare function __xmlParserInputBufferCreateFilenameValue cdecl alias "__xmlParserInputBufferCreateFilenameValue" () as xmlParserInputBufferCreateFilenameFunc ptr
declare function __xmlOutputBufferCreateFilenameValue cdecl alias "__xmlOutputBufferCreateFilenameValue" () as xmlOutputBufferCreateFilenameFunc ptr

#endif
