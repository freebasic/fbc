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
#include once "libxml/HTMLparser.bi"
#include once "libxml/chvalid.bi"

extern "C"

#define __XML_PARSER_INTERNALS_H__

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlParserMaxDepth as ulong
#else
	extern xmlParserMaxDepth as ulong
#endif

const XML_MAX_TEXT_LENGTH = 10000000
const XML_MAX_NAME_LENGTH = 50000
const XML_MAX_DICTIONARY_LIMIT = 10000000
const XML_MAX_LOOKUP_LIMIT = 10000000
const XML_MAX_NAMELEN = 100
const INPUT_CHUNK = 250
#define IS_BYTE_CHAR(c) xmlIsChar_ch(c)
#define IS_CHAR(c) xmlIsCharQ(c)
#define IS_CHAR_CH(c) xmlIsChar_ch(c)
#define IS_BLANK(c) xmlIsBlankQ(c)
#define IS_BLANK_CH(c) xmlIsBlank_ch(c)
#define IS_BASECHAR(c) xmlIsBaseCharQ(c)
#define IS_DIGIT(c) xmlIsDigitQ(c)
#define IS_DIGIT_CH(c) xmlIsDigit_ch(c)
#define IS_COMBINING(c) xmlIsCombiningQ(c)
#define IS_COMBINING_CH(c) 0
#define IS_EXTENDER(c) xmlIsExtenderQ(c)
#define IS_EXTENDER_CH(c) xmlIsExtender_ch(c)
#define IS_IDEOGRAPHIC(c) xmlIsIdeographicQ(c)
#define IS_LETTER(c) (IS_BASECHAR(c) orelse IS_IDEOGRAPHIC(c))
#define IS_LETTER_CH(c) xmlIsBaseChar_ch(c)
#define IS_ASCII_LETTER(c) (((&h41 <= (c)) andalso ((c) <= &h5a)) orelse ((&h61 <= (c)) andalso ((c) <= &h7a)))
#define IS_ASCII_DIGIT(c) ((&h30 <= (c)) andalso ((c) <= &h39))
#define IS_PUBIDCHAR(c) xmlIsPubidCharQ(c)
#define IS_PUBIDCHAR_CH(c) xmlIsPubidChar_ch(c)
#macro SKIP_EOL(p)
	scope
		if (*(p)) = &h13 then
			p += 1
			if (*(p)) = &h10 then
				p += 1
			end if
		end if
		if (*(p)) = &h10 then
			p += 1
			if (*(p)) = &h13 then
				p += 1
			end if
		end if
	end scope
#endmacro
#macro MOVETO_ENDTAG(p)
	while (*p) andalso ((*(p)) <> asc(">"))
		(p) += 1
	wend
#endmacro
#macro MOVETO_STARTTAG(p)
	while (*p) andalso ((*(p)) <> asc("<"))
		(p) += 1
	wend
#endmacro

#if defined(__FB_WIN32__) and (not defined(LIBXML_STATIC))
	extern import xmlStringText as const zstring * len("text")+1
	extern import xmlStringTextNoenc as const zstring * len("textnoenc")+1
	extern import xmlStringComment as const zstring * len("comment")+1
#else
	extern xmlStringText as const zstring * len("text")+1
	extern xmlStringTextNoenc as const zstring * len("textnoenc")+1
	extern xmlStringComment as const zstring * len("comment")+1
#endif

declare function xmlIsLetter(byval c as long) as long
declare function xmlCreateFileParserCtxt(byval filename as const zstring ptr) as xmlParserCtxtPtr
declare function xmlCreateURLParserCtxt(byval filename as const zstring ptr, byval options as long) as xmlParserCtxtPtr
declare function xmlCreateMemoryParserCtxt(byval buffer as const zstring ptr, byval size as long) as xmlParserCtxtPtr
declare function xmlCreateEntityParserCtxt(byval URL as const xmlChar ptr, byval ID as const xmlChar ptr, byval base as const xmlChar ptr) as xmlParserCtxtPtr
declare function xmlSwitchEncoding(byval ctxt as xmlParserCtxtPtr, byval enc as xmlCharEncoding) as long
declare function xmlSwitchToEncoding(byval ctxt as xmlParserCtxtPtr, byval handler as xmlCharEncodingHandlerPtr) as long
declare function xmlSwitchInputEncoding(byval ctxt as xmlParserCtxtPtr, byval input as xmlParserInputPtr, byval handler as xmlCharEncodingHandlerPtr) as long
declare function xmlNewStringInputStream(byval ctxt as xmlParserCtxtPtr, byval buffer as const xmlChar ptr) as xmlParserInputPtr
declare function xmlNewEntityInputStream(byval ctxt as xmlParserCtxtPtr, byval entity as xmlEntityPtr) as xmlParserInputPtr
declare function xmlPushInput(byval ctxt as xmlParserCtxtPtr, byval input as xmlParserInputPtr) as long
declare function xmlPopInput(byval ctxt as xmlParserCtxtPtr) as xmlChar
declare sub xmlFreeInputStream(byval input as xmlParserInputPtr)
declare function xmlNewInputFromFile(byval ctxt as xmlParserCtxtPtr, byval filename as const zstring ptr) as xmlParserInputPtr
declare function xmlNewInputStream(byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function xmlSplitQName(byval ctxt as xmlParserCtxtPtr, byval name as const xmlChar ptr, byval prefix as xmlChar ptr ptr) as xmlChar ptr
declare function xmlParseName(byval ctxt as xmlParserCtxtPtr) as const xmlChar ptr
declare function xmlParseNmtoken(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlParseEntityValue(byval ctxt as xmlParserCtxtPtr, byval orig as xmlChar ptr ptr) as xmlChar ptr
declare function xmlParseAttValue(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlParseSystemLiteral(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlParsePubidLiteral(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare sub xmlParseCharData(byval ctxt as xmlParserCtxtPtr, byval cdata as long)
declare function xmlParseExternalID(byval ctxt as xmlParserCtxtPtr, byval publicID as xmlChar ptr ptr, byval strict as long) as xmlChar ptr
declare sub xmlParseComment(byval ctxt as xmlParserCtxtPtr)
declare function xmlParsePITarget(byval ctxt as xmlParserCtxtPtr) as const xmlChar ptr
declare sub xmlParsePI(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseNotationDecl(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseEntityDecl(byval ctxt as xmlParserCtxtPtr)
declare function xmlParseDefaultDecl(byval ctxt as xmlParserCtxtPtr, byval value as xmlChar ptr ptr) as long
declare function xmlParseNotationType(byval ctxt as xmlParserCtxtPtr) as xmlEnumerationPtr
declare function xmlParseEnumerationType(byval ctxt as xmlParserCtxtPtr) as xmlEnumerationPtr
declare function xmlParseEnumeratedType(byval ctxt as xmlParserCtxtPtr, byval tree as xmlEnumerationPtr ptr) as long
declare function xmlParseAttributeType(byval ctxt as xmlParserCtxtPtr, byval tree as xmlEnumerationPtr ptr) as long
declare sub xmlParseAttributeListDecl(byval ctxt as xmlParserCtxtPtr)
declare function xmlParseElementMixedContentDecl(byval ctxt as xmlParserCtxtPtr, byval inputchk as long) as xmlElementContentPtr
declare function xmlParseElementChildrenContentDecl(byval ctxt as xmlParserCtxtPtr, byval inputchk as long) as xmlElementContentPtr
declare function xmlParseElementContentDecl(byval ctxt as xmlParserCtxtPtr, byval name as const xmlChar ptr, byval result as xmlElementContentPtr ptr) as long
declare function xmlParseElementDecl(byval ctxt as xmlParserCtxtPtr) as long
declare sub xmlParseMarkupDecl(byval ctxt as xmlParserCtxtPtr)
declare function xmlParseCharRef(byval ctxt as xmlParserCtxtPtr) as long
declare function xmlParseEntityRef(byval ctxt as xmlParserCtxtPtr) as xmlEntityPtr
declare sub xmlParseReference(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParsePEReference(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseDocTypeDecl(byval ctxt as xmlParserCtxtPtr)
declare function xmlParseAttribute(byval ctxt as xmlParserCtxtPtr, byval value as xmlChar ptr ptr) as const xmlChar ptr
declare function xmlParseStartTag(byval ctxt as xmlParserCtxtPtr) as const xmlChar ptr
declare sub xmlParseEndTag(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseCDSect(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseContent(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseElement(byval ctxt as xmlParserCtxtPtr)
declare function xmlParseVersionNum(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlParseVersionInfo(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlParseEncName(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlParseEncodingDecl(byval ctxt as xmlParserCtxtPtr) as const xmlChar ptr
declare function xmlParseSDDecl(byval ctxt as xmlParserCtxtPtr) as long
declare sub xmlParseXMLDecl(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseTextDecl(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseMisc(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParseExternalSubset(byval ctxt as xmlParserCtxtPtr, byval ExternalID as const xmlChar ptr, byval SystemID as const xmlChar ptr)

const XML_SUBSTITUTE_NONE = 0
const XML_SUBSTITUTE_REF = 1
const XML_SUBSTITUTE_PEREF = 2
const XML_SUBSTITUTE_BOTH = 3

declare function xmlStringDecodeEntities(byval ctxt as xmlParserCtxtPtr, byval str as const xmlChar ptr, byval what as long, byval end as xmlChar, byval end2 as xmlChar, byval end3 as xmlChar) as xmlChar ptr
declare function xmlStringLenDecodeEntities(byval ctxt as xmlParserCtxtPtr, byval str as const xmlChar ptr, byval len as long, byval what as long, byval end as xmlChar, byval end2 as xmlChar, byval end3 as xmlChar) as xmlChar ptr
declare function nodePush(byval ctxt as xmlParserCtxtPtr, byval value as xmlNodePtr) as long
declare function nodePop(byval ctxt as xmlParserCtxtPtr) as xmlNodePtr
declare function inputPush(byval ctxt as xmlParserCtxtPtr, byval value as xmlParserInputPtr) as long
declare function inputPop(byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function namePop(byval ctxt as xmlParserCtxtPtr) as const xmlChar ptr
declare function namePush(byval ctxt as xmlParserCtxtPtr, byval value as const xmlChar ptr) as long
declare function xmlSkipBlankChars(byval ctxt as xmlParserCtxtPtr) as long
declare function xmlStringCurrentChar(byval ctxt as xmlParserCtxtPtr, byval cur as const xmlChar ptr, byval len as long ptr) as long
declare sub xmlParserHandlePEReference(byval ctxt as xmlParserCtxtPtr)
declare function xmlCheckLanguageID(byval lang as const xmlChar ptr) as long
declare function xmlCurrentChar(byval ctxt as xmlParserCtxtPtr, byval len as long ptr) as long
declare function xmlCopyCharMultiByte(byval out as xmlChar ptr, byval val as long) as long
declare function xmlCopyChar(byval len as long, byval out as xmlChar ptr, byval val as long) as long
declare sub xmlNextChar(byval ctxt as xmlParserCtxtPtr)
declare sub xmlParserInputShrink(byval in as xmlParserInputPtr)
declare sub htmlInitAutoClose()
declare function htmlCreateFileParserCtxt(byval filename as const zstring ptr, byval encoding as const zstring ptr) as htmlParserCtxtPtr
type xmlEntityReferenceFunc as sub(byval ent as xmlEntityPtr, byval firstNode as xmlNodePtr, byval lastNode as xmlNodePtr)
declare sub xmlSetEntityReferenceFunc(byval func as xmlEntityReferenceFunc)
declare function xmlParseQuotedString(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare sub xmlParseNamespace(byval ctxt as xmlParserCtxtPtr)
declare function xmlNamespaceParseNSDef(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlScanName(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare function xmlNamespaceParseNCName(byval ctxt as xmlParserCtxtPtr) as xmlChar ptr
declare sub xmlParserHandleReference(byval ctxt as xmlParserCtxtPtr)
declare function xmlNamespaceParseQName(byval ctxt as xmlParserCtxtPtr, byval prefix as xmlChar ptr ptr) as xmlChar ptr
declare function xmlDecodeEntities(byval ctxt as xmlParserCtxtPtr, byval len as long, byval what as long, byval end as xmlChar, byval end2 as xmlChar, byval end3 as xmlChar) as xmlChar ptr
declare sub xmlHandleEntity(byval ctxt as xmlParserCtxtPtr, byval entity as xmlEntityPtr)

end extern
