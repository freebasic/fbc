''
''
'' HTMLparser -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_HTMLparser_bi__
#define __xml_HTMLparser_bi__

#include once "xmlversion.bi"
#include once "parser.bi"

type htmlParserCtxt as xmlParserCtxt
type htmlParserCtxtPtr as xmlParserCtxtPtr
type htmlParserNodeInfo as xmlParserNodeInfo
type htmlSAXHandler as xmlSAXHandler
type htmlSAXHandlerPtr as xmlSAXHandlerPtr
type htmlParserInput as xmlParserInput
type htmlParserInputPtr as xmlParserInputPtr
type htmlDocPtr as xmlDocPtr
type htmlNodePtr as xmlNodePtr
type htmlElemDesc as _htmlElemDesc
type htmlElemDescPtr as htmlElemDesc ptr

type _htmlElemDesc
	name as byte ptr
	startTag as byte
	endTag as byte
	saveEndTag as byte
	empty as byte
	depr as byte
	dtd as byte
	isinline as byte
	desc as byte ptr
	subelts as byte ptr ptr
	defaultsubelt as byte ptr
	attrs_opt as byte ptr ptr
	attrs_depr as byte ptr ptr
	attrs_req as byte ptr ptr
end type

type htmlEntityDesc as _htmlEntityDesc
type htmlEntityDescPtr as htmlEntityDesc ptr

type _htmlEntityDesc
	value as uinteger
	name as byte ptr
	desc as byte ptr
end type

enum htmlParserOption
	HTML_PARSE_NOERROR = 1 shl 5
	HTML_PARSE_NOWARNING = 1 shl 6
	HTML_PARSE_PEDANTIC = 1 shl 7
	HTML_PARSE_NOBLANKS = 1 shl 8
	HTML_PARSE_NONET = 1 shl 11
end enum

enum htmlStatus
	HTML_NA = 0
	HTML_INVALID = &h1
	HTML_DEPRECATED = &h2
	HTML_VALID = &h4
	HTML_REQUIRED = &hc
end enum

extern "c"
declare function htmlTagLookup (byval tag as zstring ptr) as htmlElemDesc ptr
declare function htmlEntityLookup (byval name as zstring ptr) as htmlEntityDesc ptr
declare function htmlEntityValueLookup (byval value as uinteger) as htmlEntityDesc ptr
declare function htmlIsAutoClosed (byval doc as htmlDocPtr, byval elem as htmlNodePtr) as integer
declare function htmlAutoCloseTag (byval doc as htmlDocPtr, byval name as zstring ptr, byval elem as htmlNodePtr) as integer
declare function htmlParseEntityRef (byval ctxt as htmlParserCtxtPtr, byval str as zstring ptr ptr) as htmlEntityDesc ptr
declare function htmlParseCharRef (byval ctxt as htmlParserCtxtPtr) as integer
declare sub htmlParseElement (byval ctxt as htmlParserCtxtPtr)
declare function htmlCreateMemoryParserCtxt (byval buffer as zstring ptr, byval size as integer) as htmlParserCtxtPtr
declare function htmlParseDocument (byval ctxt as htmlParserCtxtPtr) as integer
declare function htmlSAXParseDoc (byval cur as zstring ptr, byval encoding as zstring ptr, byval sax as htmlSAXHandlerPtr, byval userData as any ptr) as htmlDocPtr
declare function htmlParseDoc (byval cur as zstring ptr, byval encoding as zstring ptr) as htmlDocPtr
declare function htmlSAXParseFile (byval filename as zstring ptr, byval encoding as zstring ptr, byval sax as htmlSAXHandlerPtr, byval userData as any ptr) as htmlDocPtr
declare function htmlParseFile (byval filename as zstring ptr, byval encoding as zstring ptr) as htmlDocPtr
declare function UTF8ToHtml (byval out as ubyte ptr, byval outlen as integer ptr, byval in as ubyte ptr, byval inlen as integer ptr) as integer
declare function htmlEncodeEntities (byval out as ubyte ptr, byval outlen as integer ptr, byval in as ubyte ptr, byval inlen as integer ptr, byval quoteChar as integer) as integer
declare function htmlIsScriptAttribute (byval name as zstring ptr) as integer
declare function htmlHandleOmittedElem (byval val as integer) as integer
declare function htmlCreatePushParserCtxt (byval sax as htmlSAXHandlerPtr, byval user_data as any ptr, byval chunk as zstring ptr, byval size as integer, byval filename as zstring ptr, byval enc as xmlCharEncoding) as htmlParserCtxtPtr
declare function htmlParseChunk (byval ctxt as htmlParserCtxtPtr, byval chunk as zstring ptr, byval size as integer, byval terminate as integer) as integer
declare sub htmlFreeParserCtxt (byval ctxt as htmlParserCtxtPtr)
declare sub htmlCtxtReset (byval ctxt as htmlParserCtxtPtr)
declare function htmlCtxtUseOptions (byval ctxt as htmlParserCtxtPtr, byval options as integer) as integer
declare function htmlReadDoc (byval cur as zstring ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlReadFile (byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlReadMemory (byval buffer as zstring ptr, byval size as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlReadFd (byval fd as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlReadIO (byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlCtxtReadDoc (byval ctxt as xmlParserCtxtPtr, byval cur as zstring ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlCtxtReadFile (byval ctxt as xmlParserCtxtPtr, byval filename as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlCtxtReadMemory (byval ctxt as xmlParserCtxtPtr, byval buffer as zstring ptr, byval size as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlCtxtReadFd (byval ctxt as xmlParserCtxtPtr, byval fd as integer, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlCtxtReadIO (byval ctxt as xmlParserCtxtPtr, byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval URL as zstring ptr, byval encoding as zstring ptr, byval options as integer) as htmlDocPtr
declare function htmlAttrAllowed (byval as htmlElemDesc ptr, byval as zstring ptr, byval as integer) as htmlStatus
declare function htmlElementAllowedHere (byval as htmlElemDesc ptr, byval as zstring ptr) as integer
declare function htmlElementStatusHere (byval as htmlElemDesc ptr, byval as htmlElemDesc ptr) as htmlStatus
declare function htmlNodeStatus (byval as htmlNodePtr, byval as integer) as htmlStatus
end extern

#endif
