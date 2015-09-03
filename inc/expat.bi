'' FreeBASIC binding for expat-2.1.0
''
'' based on the C header files:
''   Copyright (c) 1998, 1999, 2000 Thai Open Source Software Center Ltd
''                                  and Clark Cooper
''   Copyright (c) 2001, 2002, 2003, 2004, 2005, 2006 Expat maintainers.
''
''   Permission is hereby granted, free of charge, to any person obtaining
''   a copy of this software and associated documentation files (the
''   "Software"), to deal in the Software without restriction, including
''   without limitation the rights to use, copy, modify, merge, publish,
''   distribute, sublicense, and/or sell copies of the Software, and to
''   permit persons to whom the Software is furnished to do so, subject to
''   the following conditions:
''
''   The above copyright notice and this permission notice shall be included
''   in all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
''   EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
''   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
''   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
''   CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
''   TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
''   SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#ifdef XML_UNICODE
	#inclib "expatw"
#else
	#inclib "expat"
#endif

#include once "crt/long.bi"
#include once "crt/stdlib.bi"

extern "C"

const Expat_INCLUDED = 1
const Expat_External_INCLUDED = 1

#ifdef XML_UNICODE
	type XML_Char as wstring
	type XML_LChar as wstring
#else
	type XML_Char as zstring
	type XML_LChar as zstring
#endif

type XML_Index as clong
type XML_Size as culong
type XML_Parser as XML_ParserStruct ptr
type XML_Bool as ubyte
const XML_TRUE = cast(XML_Bool, 1)
const XML_FALSE = cast(XML_Bool, 0)

type XML_Status as long
enum
	XML_STATUS_ERROR = 0
	XML_STATUS_OK = 1
	XML_STATUS_SUSPENDED = 2
end enum

type XML_Error as long
enum
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
	XML_ERROR_RESERVED_PREFIX_XML
	XML_ERROR_RESERVED_PREFIX_XMLNS
	XML_ERROR_RESERVED_NAMESPACE_URI
end enum

type XML_Content_Type as long
enum
	XML_CTYPE_EMPTY = 1
	XML_CTYPE_ANY
	XML_CTYPE_MIXED
	XML_CTYPE_NAME
	XML_CTYPE_CHOICE
	XML_CTYPE_SEQ
end enum

type XML_Content_Quant as long
enum
	XML_CQUANT_NONE
	XML_CQUANT_OPT
	XML_CQUANT_REP
	XML_CQUANT_PLUS
end enum

type XML_Content as XML_cp

type XML_cp
	as XML_Content_Type type
	quant as XML_Content_Quant
	name as XML_Char ptr
	numchildren as ulong
	children as XML_Content ptr
end type

type XML_ElementDeclHandler as sub(byval userData as any ptr, byval name as const XML_Char ptr, byval model as XML_Content ptr)
declare sub XML_SetElementDeclHandler(byval parser as XML_Parser, byval eldecl as XML_ElementDeclHandler)
type XML_AttlistDeclHandler as sub(byval userData as any ptr, byval elname as const XML_Char ptr, byval attname as const XML_Char ptr, byval att_type as const XML_Char ptr, byval dflt as const XML_Char ptr, byval isrequired as long)
declare sub XML_SetAttlistDeclHandler(byval parser as XML_Parser, byval attdecl as XML_AttlistDeclHandler)
type XML_XmlDeclHandler as sub(byval userData as any ptr, byval version as const XML_Char ptr, byval encoding as const XML_Char ptr, byval standalone as long)
declare sub XML_SetXmlDeclHandler(byval parser as XML_Parser, byval xmldecl as XML_XmlDeclHandler)

type XML_Memory_Handling_Suite
	malloc_fcn as function(byval size as uinteger) as any ptr
	realloc_fcn as function(byval ptr as any ptr, byval size as uinteger) as any ptr
	free_fcn as sub(byval ptr as any ptr)
end type

declare function XML_ParserCreate(byval encoding as const XML_Char ptr) as XML_Parser

#ifdef XML_UNICODE
	declare function XML_ParserCreateNS(byval encoding as const XML_Char ptr, byval namespaceSeparator as wchar_t) as XML_Parser
#else
	declare function XML_ParserCreateNS(byval encoding as const XML_Char ptr, byval namespaceSeparator as byte) as XML_Parser
#endif

declare function XML_ParserCreate_MM(byval encoding as const XML_Char ptr, byval memsuite as const XML_Memory_Handling_Suite ptr, byval namespaceSeparator as const XML_Char ptr) as XML_Parser
declare function XML_ParserReset(byval parser as XML_Parser, byval encoding as const XML_Char ptr) as XML_Bool
type XML_StartElementHandler as sub(byval userData as any ptr, byval name as const XML_Char ptr, byval atts as const XML_Char ptr ptr)
type XML_EndElementHandler as sub(byval userData as any ptr, byval name as const XML_Char ptr)
type XML_CharacterDataHandler as sub(byval userData as any ptr, byval s as const XML_Char ptr, byval len as long)
type XML_ProcessingInstructionHandler as sub(byval userData as any ptr, byval target as const XML_Char ptr, byval data as const XML_Char ptr)
type XML_CommentHandler as sub(byval userData as any ptr, byval data as const XML_Char ptr)
type XML_StartCdataSectionHandler as sub(byval userData as any ptr)
type XML_EndCdataSectionHandler as sub(byval userData as any ptr)
type XML_DefaultHandler as sub(byval userData as any ptr, byval s as const XML_Char ptr, byval len as long)
type XML_StartDoctypeDeclHandler as sub(byval userData as any ptr, byval doctypeName as const XML_Char ptr, byval sysid as const XML_Char ptr, byval pubid as const XML_Char ptr, byval has_internal_subset as long)
type XML_EndDoctypeDeclHandler as sub(byval userData as any ptr)
type XML_EntityDeclHandler as sub(byval userData as any ptr, byval entityName as const XML_Char ptr, byval is_parameter_entity as long, byval value as const XML_Char ptr, byval value_length as long, byval base as const XML_Char ptr, byval systemId as const XML_Char ptr, byval publicId as const XML_Char ptr, byval notationName as const XML_Char ptr)
declare sub XML_SetEntityDeclHandler(byval parser as XML_Parser, byval handler as XML_EntityDeclHandler)
type XML_UnparsedEntityDeclHandler as sub(byval userData as any ptr, byval entityName as const XML_Char ptr, byval base as const XML_Char ptr, byval systemId as const XML_Char ptr, byval publicId as const XML_Char ptr, byval notationName as const XML_Char ptr)
type XML_NotationDeclHandler as sub(byval userData as any ptr, byval notationName as const XML_Char ptr, byval base as const XML_Char ptr, byval systemId as const XML_Char ptr, byval publicId as const XML_Char ptr)
type XML_StartNamespaceDeclHandler as sub(byval userData as any ptr, byval prefix as const XML_Char ptr, byval uri as const XML_Char ptr)
type XML_EndNamespaceDeclHandler as sub(byval userData as any ptr, byval prefix as const XML_Char ptr)
type XML_NotStandaloneHandler as function(byval userData as any ptr) as long
type XML_ExternalEntityRefHandler as function(byval parser as XML_Parser, byval context as const XML_Char ptr, byval base as const XML_Char ptr, byval systemId as const XML_Char ptr, byval publicId as const XML_Char ptr) as long
type XML_SkippedEntityHandler as sub(byval userData as any ptr, byval entityName as const XML_Char ptr, byval is_parameter_entity as long)

type XML_Encoding
	map(0 to 255) as long
	data as any ptr
	convert as function(byval data as any ptr, byval s as const zstring ptr) as long
	release as sub(byval data as any ptr)
end type

type XML_UnknownEncodingHandler as function(byval encodingHandlerData as any ptr, byval name as const XML_Char ptr, byval info as XML_Encoding ptr) as long
declare sub XML_SetElementHandler(byval parser as XML_Parser, byval start as XML_StartElementHandler, byval end as XML_EndElementHandler)
declare sub XML_SetStartElementHandler(byval parser as XML_Parser, byval handler as XML_StartElementHandler)
declare sub XML_SetEndElementHandler(byval parser as XML_Parser, byval handler as XML_EndElementHandler)
declare sub XML_SetCharacterDataHandler(byval parser as XML_Parser, byval handler as XML_CharacterDataHandler)
declare sub XML_SetProcessingInstructionHandler(byval parser as XML_Parser, byval handler as XML_ProcessingInstructionHandler)
declare sub XML_SetCommentHandler(byval parser as XML_Parser, byval handler as XML_CommentHandler)
declare sub XML_SetCdataSectionHandler(byval parser as XML_Parser, byval start as XML_StartCdataSectionHandler, byval end as XML_EndCdataSectionHandler)
declare sub XML_SetStartCdataSectionHandler(byval parser as XML_Parser, byval start as XML_StartCdataSectionHandler)
declare sub XML_SetEndCdataSectionHandler(byval parser as XML_Parser, byval end as XML_EndCdataSectionHandler)
declare sub XML_SetDefaultHandler(byval parser as XML_Parser, byval handler as XML_DefaultHandler)
declare sub XML_SetDefaultHandlerExpand(byval parser as XML_Parser, byval handler as XML_DefaultHandler)
declare sub XML_SetDoctypeDeclHandler(byval parser as XML_Parser, byval start as XML_StartDoctypeDeclHandler, byval end as XML_EndDoctypeDeclHandler)
declare sub XML_SetStartDoctypeDeclHandler(byval parser as XML_Parser, byval start as XML_StartDoctypeDeclHandler)
declare sub XML_SetEndDoctypeDeclHandler(byval parser as XML_Parser, byval end as XML_EndDoctypeDeclHandler)
declare sub XML_SetUnparsedEntityDeclHandler(byval parser as XML_Parser, byval handler as XML_UnparsedEntityDeclHandler)
declare sub XML_SetNotationDeclHandler(byval parser as XML_Parser, byval handler as XML_NotationDeclHandler)
declare sub XML_SetNamespaceDeclHandler(byval parser as XML_Parser, byval start as XML_StartNamespaceDeclHandler, byval end as XML_EndNamespaceDeclHandler)
declare sub XML_SetStartNamespaceDeclHandler(byval parser as XML_Parser, byval start as XML_StartNamespaceDeclHandler)
declare sub XML_SetEndNamespaceDeclHandler(byval parser as XML_Parser, byval end as XML_EndNamespaceDeclHandler)
declare sub XML_SetNotStandaloneHandler(byval parser as XML_Parser, byval handler as XML_NotStandaloneHandler)
declare sub XML_SetExternalEntityRefHandler(byval parser as XML_Parser, byval handler as XML_ExternalEntityRefHandler)
declare sub XML_SetExternalEntityRefHandlerArg(byval parser as XML_Parser, byval arg as any ptr)
declare sub XML_SetSkippedEntityHandler(byval parser as XML_Parser, byval handler as XML_SkippedEntityHandler)
declare sub XML_SetUnknownEncodingHandler(byval parser as XML_Parser, byval handler as XML_UnknownEncodingHandler, byval encodingHandlerData as any ptr)
declare sub XML_DefaultCurrent(byval parser as XML_Parser)
declare sub XML_SetReturnNSTriplet(byval parser as XML_Parser, byval do_nst as long)
declare sub XML_SetUserData(byval parser as XML_Parser, byval userData as any ptr)
#define XML_GetUserData(parser) (*cptr(any ptr ptr, (parser)))
declare function XML_SetEncoding(byval parser as XML_Parser, byval encoding as const XML_Char ptr) as XML_Status
declare sub XML_UseParserAsHandlerArg(byval parser as XML_Parser)
declare function XML_UseForeignDTD(byval parser as XML_Parser, byval useDTD as XML_Bool) as XML_Error
declare function XML_SetBase(byval parser as XML_Parser, byval base as const XML_Char ptr) as XML_Status
declare function XML_GetBase(byval parser as XML_Parser) as const XML_Char ptr
declare function XML_GetSpecifiedAttributeCount(byval parser as XML_Parser) as long
declare function XML_GetIdAttributeIndex(byval parser as XML_Parser) as long
declare function XML_Parse(byval parser as XML_Parser, byval s as const zstring ptr, byval len as long, byval isFinal as long) as XML_Status
declare function XML_GetBuffer(byval parser as XML_Parser, byval len as long) as any ptr
declare function XML_ParseBuffer(byval parser as XML_Parser, byval len as long, byval isFinal as long) as XML_Status
declare function XML_StopParser(byval parser as XML_Parser, byval resumable as XML_Bool) as XML_Status
declare function XML_ResumeParser(byval parser as XML_Parser) as XML_Status

type XML_Parsing as long
enum
	XML_INITIALIZED
	XML_PARSING
	XML_FINISHED
	XML_SUSPENDED
end enum

type XML_ParsingStatus
	parsing as XML_Parsing
	finalBuffer as XML_Bool
end type

declare sub XML_GetParsingStatus(byval parser as XML_Parser, byval status as XML_ParsingStatus ptr)
declare function XML_ExternalEntityParserCreate(byval parser as XML_Parser, byval context as const XML_Char ptr, byval encoding as const XML_Char ptr) as XML_Parser

type XML_ParamEntityParsing as long
enum
	XML_PARAM_ENTITY_PARSING_NEVER
	XML_PARAM_ENTITY_PARSING_UNLESS_STANDALONE
	XML_PARAM_ENTITY_PARSING_ALWAYS
end enum

declare function XML_SetParamEntityParsing(byval parser as XML_Parser, byval parsing as XML_ParamEntityParsing) as long
declare function XML_SetHashSalt(byval parser as XML_Parser, byval hash_salt as culong) as long
declare function XML_GetErrorCode(byval parser as XML_Parser) as XML_Error
declare function XML_GetCurrentLineNumber(byval parser as XML_Parser) as XML_Size
declare function XML_GetCurrentColumnNumber(byval parser as XML_Parser) as XML_Size
declare function XML_GetCurrentByteIndex(byval parser as XML_Parser) as XML_Index
declare function XML_GetCurrentByteCount(byval parser as XML_Parser) as long
declare function XML_GetInputContext(byval parser as XML_Parser, byval offset as long ptr, byval size as long ptr) as const zstring ptr
declare function XML_GetErrorLineNumber alias "XML_GetCurrentLineNumber"(byval parser as XML_Parser) as XML_Size
declare function XML_GetErrorColumnNumber alias "XML_GetCurrentColumnNumber"(byval parser as XML_Parser) as XML_Size
declare function XML_GetErrorByteIndex alias "XML_GetCurrentByteIndex"(byval parser as XML_Parser) as XML_Index
declare sub XML_FreeContentModel(byval parser as XML_Parser, byval model as XML_Content ptr)
declare function XML_MemMalloc(byval parser as XML_Parser, byval size as uinteger) as any ptr
declare function XML_MemRealloc(byval parser as XML_Parser, byval ptr as any ptr, byval size as uinteger) as any ptr
declare sub XML_MemFree(byval parser as XML_Parser, byval ptr as any ptr)
declare sub XML_ParserFree(byval parser as XML_Parser)
declare function XML_ErrorString(byval code as XML_Error) as const XML_LChar ptr
declare function XML_ExpatVersion() as const XML_LChar ptr

type XML_Expat_Version
	major as long
	minor as long
	micro as long
end type

declare function XML_ExpatVersionInfo() as XML_Expat_Version

type XML_FeatureEnum as long
enum
	XML_FEATURE_END = 0
	XML_FEATURE_UNICODE
	XML_FEATURE_UNICODE_WCHAR_T
	XML_FEATURE_DTD
	XML_FEATURE_CONTEXT_BYTES
	XML_FEATURE_MIN_SIZE
	XML_FEATURE_SIZEOF_XML_CHAR
	XML_FEATURE_SIZEOF_XML_LCHAR
	XML_FEATURE_NS
	XML_FEATURE_LARGE_SIZE
	XML_FEATURE_ATTR_INFO
end enum

type XML_Feature
	feature as XML_FeatureEnum
	name as const XML_LChar ptr
	value as clong
end type

declare function XML_GetFeatureList() as const XML_Feature ptr
const XML_MAJOR_VERSION = 2
const XML_MINOR_VERSION = 1
const XML_MICRO_VERSION = 0

end extern
