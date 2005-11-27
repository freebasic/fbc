''
''
'' expat -- XML parser library
''          (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __expat_bi__
#define __expat_bi__

#ifndef XML_UNICODE
# inclib "expat"
# define XML_Char zstring
# define XML_LChar zstring
#else
# inclib "expatw"
# define XML_Char wstring
# define XML_LChar wstring
#endif

type XML_Parser as XML_ParserStruct ptr
type XML_Bool as ubyte

enum XML_Status
	XML_STATUS_ERROR = 0
	XML_STATUS_OK = 1
	XML_STATUS_SUSPENDED = 2
end enum

enum XML_Error
	XML_ERROR_NONE
	XML_ERROR_NO_MEMORY
	XML_ERROR_SYNTAX
	XML_ERROR_NO_ELEMENTS
	XML_ERROR_INVALID_TOKEN
	XML_ERROR_UNCLOSED_TOKEN
	XML_ERROR_PARTIAL_CHAR
	XML_ERROR_TAG_MISMATCH
	XML_ERROR_DUPLICATE_ATTRIBUTE
	XML_ERROR_JUNK_AFTER_DOC_ELEMENT
	XML_ERROR_PARAM_ENTITY_REF
	XML_ERROR_UNDEFINED_ENTITY
	XML_ERROR_RECURSIVE_ENTITY_REF
	XML_ERROR_ASYNC_ENTITY
	XML_ERROR_BAD_CHAR_REF
	XML_ERROR_BINARY_ENTITY_REF
	XML_ERROR_ATTRIBUTE_EXTERNAL_ENTITY_REF
	XML_ERROR_MISPLACED_XML_PI
	XML_ERROR_UNKNOWN_ENCODING
	XML_ERROR_INCORRECT_ENCODING
	XML_ERROR_UNCLOSED_CDATA_SECTION
	XML_ERROR_EXTERNAL_ENTITY_HANDLING
	XML_ERROR_NOT_STANDALONE
	XML_ERROR_UNEXPECTED_STATE
	XML_ERROR_ENTITY_DECLARED_IN_PE
	XML_ERROR_FEATURE_REQUIRES_XML_DTD
	XML_ERROR_CANT_CHANGE_FEATURE_ONCE_PARSING
	XML_ERROR_UNBOUND_PREFIX
	XML_ERROR_UNDECLARING_PREFIX
	XML_ERROR_INCOMPLETE_PE
	XML_ERROR_XML_DECL
	XML_ERROR_TEXT_DECL
	XML_ERROR_PUBLICID
	XML_ERROR_SUSPENDED
	XML_ERROR_NOT_SUSPENDED
	XML_ERROR_ABORTED
	XML_ERROR_FINISHED
	XML_ERROR_SUSPEND_PE
end enum

enum XML_Content_Type
	XML_CTYPE_EMPTY = 1
	XML_CTYPE_ANY
	XML_CTYPE_MIXED
	XML_CTYPE_NAME
	XML_CTYPE_CHOICE
	XML_CTYPE_SEQ
end enum

enum XML_Content_Quant
	XML_CQUANT_NONE
	XML_CQUANT_OPT
	XML_CQUANT_REP
	XML_CQUANT_PLUS
end enum

type XML_Content as XML_cp

type XML_cp
	type as XML_Content_Type
	quant as XML_Content_Quant
	name as XML_Char ptr
	numchildren as uinteger
	children as XML_Content ptr
end type

type XML_ElementDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Content ptr)

declare sub XML_SetElementDeclHandler cdecl alias "XML_SetElementDeclHandler" (byval parser as XML_Parser, byval eldecl as XML_ElementDeclHandler)

type XML_AttlistDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as integer)

declare sub XML_SetAttlistDeclHandler cdecl alias "XML_SetAttlistDeclHandler" (byval parser as XML_Parser, byval attdecl as XML_AttlistDeclHandler)

type XML_XmlDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as integer)

declare sub XML_SetXmlDeclHandler cdecl alias "XML_SetXmlDeclHandler" (byval parser as XML_Parser, byval xmldecl as XML_XmlDeclHandler)

type XML_Memory_Handling_Suite
	malloc_fcn as sub cdecl(byval as integer)
	realloc_fcn as sub cdecl(byval as any ptr, byval as integer)
	free_fcn as sub cdecl(byval as any ptr)
end type

declare function XML_ParserCreate cdecl alias "XML_ParserCreate" (byval encoding as XML_Char ptr) as XML_Parser
declare function XML_ParserCreateNS cdecl alias "XML_ParserCreateNS" (byval encoding as XML_Char ptr, byval namespaceSeparator as integer) as XML_Parser
declare function XML_ParserCreate_MM cdecl alias "XML_ParserCreate_MM" (byval encoding as XML_Char ptr, byval memsuite as XML_Memory_Handling_Suite ptr, byval namespaceSeparator as XML_Char ptr) as XML_Parser
declare function XML_ParserReset cdecl alias "XML_ParserReset" (byval parser as XML_Parser, byval encoding as XML_Char ptr) as XML_Bool

type XML_StartElementHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr ptr)
type XML_EndElementHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr)
type XML_CharacterDataHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as integer)
type XML_ProcessingInstructionHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr)
type XML_CommentHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr)
type XML_StartCdataSectionHandler as sub cdecl(byval as any ptr)
type XML_EndCdataSectionHandler as sub cdecl(byval as any ptr)
type XML_DefaultHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as integer)
type XML_StartDoctypeDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as integer)
type XML_EndDoctypeDeclHandler as sub cdecl(byval as any ptr)
type XML_EntityDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as integer, byval as XML_Char ptr, byval as integer, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr)

declare sub XML_SetEntityDeclHandler cdecl alias "XML_SetEntityDeclHandler" (byval parser as XML_Parser, byval handler as XML_EntityDeclHandler)

type XML_UnparsedEntityDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr)
type XML_NotationDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr)
type XML_StartNamespaceDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Char ptr)
type XML_EndNamespaceDeclHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr)
type XML_NotStandaloneHandler as function cdecl(byval as any ptr) as integer
type XML_ExternalEntityRefHandler as function cdecl(byval as XML_Parser, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr, byval as XML_Char ptr) as integer
type XML_SkippedEntityHandler as sub cdecl(byval as any ptr, byval as XML_Char ptr, byval as integer)

type XML_Encoding
	map(0 to 256-1) as integer
	data as any ptr
	convert as function cdecl(byval as any ptr, byval as zstring ptr) as integer
	release as sub cdecl(byval as any ptr)
end type

type XML_UnknownEncodingHandler as function cdecl(byval as any ptr, byval as XML_Char ptr, byval as XML_Encoding ptr) as integer

declare sub XML_SetElementHandler cdecl alias "XML_SetElementHandler" (byval parser as XML_Parser, byval start as XML_StartElementHandler, byval end as XML_EndElementHandler)
declare sub XML_SetStartElementHandler cdecl alias "XML_SetStartElementHandler" (byval parser as XML_Parser, byval handler as XML_StartElementHandler)
declare sub XML_SetEndElementHandler cdecl alias "XML_SetEndElementHandler" (byval parser as XML_Parser, byval handler as XML_EndElementHandler)
declare sub XML_SetCharacterDataHandler cdecl alias "XML_SetCharacterDataHandler" (byval parser as XML_Parser, byval handler as XML_CharacterDataHandler)
declare sub XML_SetProcessingInstructionHandler cdecl alias "XML_SetProcessingInstructionHandler" (byval parser as XML_Parser, byval handler as XML_ProcessingInstructionHandler)
declare sub XML_SetCommentHandler cdecl alias "XML_SetCommentHandler" (byval parser as XML_Parser, byval handler as XML_CommentHandler)
declare sub XML_SetCdataSectionHandler cdecl alias "XML_SetCdataSectionHandler" (byval parser as XML_Parser, byval start as XML_StartCdataSectionHandler, byval end as XML_EndCdataSectionHandler)
declare sub XML_SetStartCdataSectionHandler cdecl alias "XML_SetStartCdataSectionHandler" (byval parser as XML_Parser, byval start as XML_StartCdataSectionHandler)
declare sub XML_SetEndCdataSectionHandler cdecl alias "XML_SetEndCdataSectionHandler" (byval parser as XML_Parser, byval end as XML_EndCdataSectionHandler)
declare sub XML_SetDefaultHandler cdecl alias "XML_SetDefaultHandler" (byval parser as XML_Parser, byval handler as XML_DefaultHandler)
declare sub XML_SetDefaultHandlerExpand cdecl alias "XML_SetDefaultHandlerExpand" (byval parser as XML_Parser, byval handler as XML_DefaultHandler)
declare sub XML_SetDoctypeDeclHandler cdecl alias "XML_SetDoctypeDeclHandler" (byval parser as XML_Parser, byval start as XML_StartDoctypeDeclHandler, byval end as XML_EndDoctypeDeclHandler)
declare sub XML_SetStartDoctypeDeclHandler cdecl alias "XML_SetStartDoctypeDeclHandler" (byval parser as XML_Parser, byval start as XML_StartDoctypeDeclHandler)
declare sub XML_SetEndDoctypeDeclHandler cdecl alias "XML_SetEndDoctypeDeclHandler" (byval parser as XML_Parser, byval end as XML_EndDoctypeDeclHandler)
declare sub XML_SetUnparsedEntityDeclHandler cdecl alias "XML_SetUnparsedEntityDeclHandler" (byval parser as XML_Parser, byval handler as XML_UnparsedEntityDeclHandler)
declare sub XML_SetNotationDeclHandler cdecl alias "XML_SetNotationDeclHandler" (byval parser as XML_Parser, byval handler as XML_NotationDeclHandler)
declare sub XML_SetNamespaceDeclHandler cdecl alias "XML_SetNamespaceDeclHandler" (byval parser as XML_Parser, byval start as XML_StartNamespaceDeclHandler, byval end as XML_EndNamespaceDeclHandler)
declare sub XML_SetStartNamespaceDeclHandler cdecl alias "XML_SetStartNamespaceDeclHandler" (byval parser as XML_Parser, byval start as XML_StartNamespaceDeclHandler)
declare sub XML_SetEndNamespaceDeclHandler cdecl alias "XML_SetEndNamespaceDeclHandler" (byval parser as XML_Parser, byval end as XML_EndNamespaceDeclHandler)
declare sub XML_SetNotStandaloneHandler cdecl alias "XML_SetNotStandaloneHandler" (byval parser as XML_Parser, byval handler as XML_NotStandaloneHandler)
declare sub XML_SetExternalEntityRefHandler cdecl alias "XML_SetExternalEntityRefHandler" (byval parser as XML_Parser, byval handler as XML_ExternalEntityRefHandler)
declare sub XML_SetExternalEntityRefHandlerArg cdecl alias "XML_SetExternalEntityRefHandlerArg" (byval parser as XML_Parser, byval arg as any ptr)
declare sub XML_SetSkippedEntityHandler cdecl alias "XML_SetSkippedEntityHandler" (byval parser as XML_Parser, byval handler as XML_SkippedEntityHandler)
declare sub XML_SetUnknownEncodingHandler cdecl alias "XML_SetUnknownEncodingHandler" (byval parser as XML_Parser, byval handler as XML_UnknownEncodingHandler, byval encodingHandlerData as any ptr)
declare sub XML_DefaultCurrent cdecl alias "XML_DefaultCurrent" (byval parser as XML_Parser)
declare sub XML_SetReturnNSTriplet cdecl alias "XML_SetReturnNSTriplet" (byval parser as XML_Parser, byval do_nst as integer)
declare sub XML_SetUserData cdecl alias "XML_SetUserData" (byval parser as XML_Parser, byval userData as any ptr)
declare function XML_SetEncoding cdecl alias "XML_SetEncoding" (byval parser as XML_Parser, byval encoding as XML_Char ptr) as XML_Status
declare sub XML_UseParserAsHandlerArg cdecl alias "XML_UseParserAsHandlerArg" (byval parser as XML_Parser)
declare function XML_UseForeignDTD cdecl alias "XML_UseForeignDTD" (byval parser as XML_Parser, byval useDTD as XML_Bool) as XML_Error
declare function XML_SetBase cdecl alias "XML_SetBase" (byval parser as XML_Parser, byval base as XML_Char ptr) as XML_Status
declare function XML_GetBase cdecl alias "XML_GetBase" (byval parser as XML_Parser) as XML_Char ptr
declare function XML_GetSpecifiedAttributeCount cdecl alias "XML_GetSpecifiedAttributeCount" (byval parser as XML_Parser) as integer
declare function XML_GetIdAttributeIndex cdecl alias "XML_GetIdAttributeIndex" (byval parser as XML_Parser) as integer
declare function XML_Parse cdecl alias "XML_Parse" (byval parser as XML_Parser, byval s as zstring ptr, byval len as integer, byval isFinal as integer) as XML_Status
declare function XML_GetBuffer cdecl alias "XML_GetBuffer" (byval parser as XML_Parser, byval len as integer) as any ptr
declare function XML_ParseBuffer cdecl alias "XML_ParseBuffer" (byval parser as XML_Parser, byval len as integer, byval isFinal as integer) as XML_Status
declare function XML_StopParser cdecl alias "XML_StopParser" (byval parser as XML_Parser, byval resumable as XML_Bool) as XML_Status
declare function XML_ResumeParser cdecl alias "XML_ResumeParser" (byval parser as XML_Parser) as XML_Status

enum XML_Parsing
	XML_INITIALIZED
	XML_PARSING
	XML_FINISHED
	XML_SUSPENDED
end enum

type XML_ParsingStatus
	parsing as XML_Parsing
	finalBuffer as XML_Bool
end type

declare sub XML_GetParsingStatus cdecl alias "XML_GetParsingStatus" (byval parser as XML_Parser, byval status as XML_ParsingStatus ptr)
declare function XML_ExternalEntityParserCreate cdecl alias "XML_ExternalEntityParserCreate" (byval parser as XML_Parser, byval context as XML_Char ptr, byval encoding as XML_Char ptr) as XML_Parser

enum XML_ParamEntityParsing
	XML_PARAM_ENTITY_PARSING_NEVER
	XML_PARAM_ENTITY_PARSING_UNLESS_STANDALONE
	XML_PARAM_ENTITY_PARSING_ALWAYS
end enum

declare function XML_SetParamEntityParsing cdecl alias "XML_SetParamEntityParsing" (byval parser as XML_Parser, byval parsing as XML_ParamEntityParsing) as integer
declare function XML_GetErrorCode cdecl alias "XML_GetErrorCode" (byval parser as XML_Parser) as XML_Error
declare function XML_GetCurrentLineNumber cdecl alias "XML_GetCurrentLineNumber" (byval parser as XML_Parser) as integer
declare function XML_GetCurrentColumnNumber cdecl alias "XML_GetCurrentColumnNumber" (byval parser as XML_Parser) as integer
declare function XML_GetCurrentByteIndex cdecl alias "XML_GetCurrentByteIndex" (byval parser as XML_Parser) as integer
declare function XML_GetCurrentByteCount cdecl alias "XML_GetCurrentByteCount" (byval parser as XML_Parser) as integer
declare function XML_GetInputContext cdecl alias "XML_GetInputContext" (byval parser as XML_Parser, byval offset as integer ptr, byval size as integer ptr) as zstring ptr
declare sub XML_FreeContentModel cdecl alias "XML_FreeContentModel" (byval parser as XML_Parser, byval model as XML_Content ptr)
declare function XML_MemMalloc cdecl alias "XML_MemMalloc" (byval parser as XML_Parser, byval size as integer) as any ptr
declare function XML_MemRealloc cdecl alias "XML_MemRealloc" (byval parser as XML_Parser, byval ptr as any ptr, byval size as integer) as any ptr
declare sub XML_MemFree cdecl alias "XML_MemFree" (byval parser as XML_Parser, byval ptr as any ptr)
declare sub XML_ParserFree cdecl alias "XML_ParserFree" (byval parser as XML_Parser)
declare function XML_ErrorString cdecl alias "XML_ErrorString" (byval code as XML_Error) as XML_LChar ptr
declare function XML_ExpatVersion cdecl alias "XML_ExpatVersion" () as XML_LChar ptr

type XML_Expat_Version
	major as integer
	minor as integer
	micro as integer
end type

declare function XML_ExpatVersionInfo cdecl alias "XML_ExpatVersionInfo" () as XML_Expat_Version

enum XML_FeatureEnum
	XML_FEATURE_END = 0
	XML_FEATURE_UNICODE
	XML_FEATURE_UNICODE_WCHAR_T
	XML_FEATURE_DTD
	XML_FEATURE_CONTEXT_BYTES
	XML_FEATURE_MIN_SIZE
	XML_FEATURE_SIZEOF_XML_CHAR
	XML_FEATURE_SIZEOF_XML_LCHAR
end enum

type XML_Feature
	feature as XML_FeatureEnum
	name as XML_LChar ptr
	value as integer
end type

declare function XML_GetFeatureList cdecl alias "XML_GetFeatureList" () as XML_Feature ptr

#define XML_MAJOR_VERSION 1
#define XML_MINOR_VERSION 95
#define XML_MICRO_VERSION 8

#endif
