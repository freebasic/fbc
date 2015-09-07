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
#include once "libiconv.bi"
#include once "libxml/tree.bi"

extern "C"

#define __XML_CHAR_ENCODING_H__

type xmlCharEncoding as long
enum
	XML_CHAR_ENCODING_ERROR = -1
	XML_CHAR_ENCODING_NONE = 0
	XML_CHAR_ENCODING_UTF8 = 1
	XML_CHAR_ENCODING_UTF16LE = 2
	XML_CHAR_ENCODING_UTF16BE = 3
	XML_CHAR_ENCODING_UCS4LE = 4
	XML_CHAR_ENCODING_UCS4BE = 5
	XML_CHAR_ENCODING_EBCDIC = 6
	XML_CHAR_ENCODING_UCS4_2143 = 7
	XML_CHAR_ENCODING_UCS4_3412 = 8
	XML_CHAR_ENCODING_UCS2 = 9
	XML_CHAR_ENCODING_8859_1 = 10
	XML_CHAR_ENCODING_8859_2 = 11
	XML_CHAR_ENCODING_8859_3 = 12
	XML_CHAR_ENCODING_8859_4 = 13
	XML_CHAR_ENCODING_8859_5 = 14
	XML_CHAR_ENCODING_8859_6 = 15
	XML_CHAR_ENCODING_8859_7 = 16
	XML_CHAR_ENCODING_8859_8 = 17
	XML_CHAR_ENCODING_8859_9 = 18
	XML_CHAR_ENCODING_2022_JP = 19
	XML_CHAR_ENCODING_SHIFT_JIS = 20
	XML_CHAR_ENCODING_EUC_JP = 21
	XML_CHAR_ENCODING_ASCII = 22
end enum

type xmlCharEncodingInputFunc as function(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr) as long
type xmlCharEncodingOutputFunc as function(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr) as long
type xmlCharEncodingHandler as _xmlCharEncodingHandler
type xmlCharEncodingHandlerPtr as xmlCharEncodingHandler ptr

type _xmlCharEncodingHandler
	name as zstring ptr
	input as xmlCharEncodingInputFunc
	output as xmlCharEncodingOutputFunc
	iconv_in as iconv_t
	iconv_out as iconv_t
end type

declare sub xmlInitCharEncodingHandlers()
declare sub xmlCleanupCharEncodingHandlers()
declare sub xmlRegisterCharEncodingHandler(byval handler as xmlCharEncodingHandlerPtr)
declare function xmlGetCharEncodingHandler(byval enc as xmlCharEncoding) as xmlCharEncodingHandlerPtr
declare function xmlFindCharEncodingHandler(byval name as const zstring ptr) as xmlCharEncodingHandlerPtr
declare function xmlNewCharEncodingHandler(byval name as const zstring ptr, byval input as xmlCharEncodingInputFunc, byval output as xmlCharEncodingOutputFunc) as xmlCharEncodingHandlerPtr
declare function xmlAddEncodingAlias(byval name as const zstring ptr, byval alias as const zstring ptr) as long
declare function xmlDelEncodingAlias(byval alias as const zstring ptr) as long
declare function xmlGetEncodingAlias(byval alias as const zstring ptr) as const zstring ptr
declare sub xmlCleanupEncodingAliases()
declare function xmlParseCharEncoding(byval name as const zstring ptr) as xmlCharEncoding
declare function xmlGetCharEncodingName(byval enc as xmlCharEncoding) as const zstring ptr
declare function xmlDetectCharEncoding(byval in as const ubyte ptr, byval len as long) as xmlCharEncoding
declare function xmlCharEncOutFunc(byval handler as xmlCharEncodingHandler ptr, byval out as xmlBufferPtr, byval in as xmlBufferPtr) as long
declare function xmlCharEncInFunc(byval handler as xmlCharEncodingHandler ptr, byval out as xmlBufferPtr, byval in as xmlBufferPtr) as long
declare function xmlCharEncFirstLine(byval handler as xmlCharEncodingHandler ptr, byval out as xmlBufferPtr, byval in as xmlBufferPtr) as long
declare function xmlCharEncCloseFunc(byval handler as xmlCharEncodingHandler ptr) as long
declare function UTF8Toisolat1(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr) as long
declare function isolat1ToUTF8(byval out as ubyte ptr, byval outlen as long ptr, byval in as const ubyte ptr, byval inlen as long ptr) as long

end extern
