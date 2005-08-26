''
''
'' encoding -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __encoding_bi__
#define __encoding_bi__

#include once "libxml/xmlversion.bi"

enum xmlCharEncoding
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

type xmlCharEncodingInputFunc as integer ptr
type xmlCharEncodingOutputFunc as integer ptr
type xmlCharEncodingHandler as _xmlCharEncodingHandler
type xmlCharEncodingHandlerPtr as xmlCharEncodingHandler ptr

type _xmlCharEncodingHandler
	name as byte ptr
	input as xmlCharEncodingInputFunc
	output as xmlCharEncodingOutputFunc
	iconv_in as integer
	iconv_out as integer
end type

declare sub xmlInitCharEncodingHandlers cdecl alias "xmlInitCharEncodingHandlers" ()
declare sub xmlCleanupCharEncodingHandlers cdecl alias "xmlCleanupCharEncodingHandlers" ()
declare sub xmlRegisterCharEncodingHandler cdecl alias "xmlRegisterCharEncodingHandler" (byval handler as xmlCharEncodingHandlerPtr)
declare function xmlGetCharEncodingHandler cdecl alias "xmlGetCharEncodingHandler" (byval enc as xmlCharEncoding) as xmlCharEncodingHandlerPtr
declare function xmlFindCharEncodingHandler cdecl alias "xmlFindCharEncodingHandler" (byval name as zstring ptr) as xmlCharEncodingHandlerPtr
declare function xmlNewCharEncodingHandler cdecl alias "xmlNewCharEncodingHandler" (byval name as zstring ptr, byval input as xmlCharEncodingInputFunc, byval output as xmlCharEncodingOutputFunc) as xmlCharEncodingHandlerPtr
declare function xmlAddEncodingAlias cdecl alias "xmlAddEncodingAlias" (byval name as zstring ptr, byval alias as zstring ptr) as integer
declare function xmlDelEncodingAlias cdecl alias "xmlDelEncodingAlias" (byval alias as zstring ptr) as integer
declare function xmlGetEncodingAlias cdecl alias "xmlGetEncodingAlias" (byval alias as zstring ptr) as byte ptr
declare sub xmlCleanupEncodingAliases cdecl alias "xmlCleanupEncodingAliases" ()
declare function xmlParseCharEncoding cdecl alias "xmlParseCharEncoding" (byval name as zstring ptr) as xmlCharEncoding
declare function xmlGetCharEncodingName cdecl alias "xmlGetCharEncodingName" (byval enc as xmlCharEncoding) as byte ptr
declare function xmlDetectCharEncoding cdecl alias "xmlDetectCharEncoding" (byval in as ubyte ptr, byval len as integer) as xmlCharEncoding
declare function xmlCharEncOutFunc cdecl alias "xmlCharEncOutFunc" (byval handler as xmlCharEncodingHandler ptr, byval out as xmlBufferPtr, byval in as xmlBufferPtr) as integer
declare function xmlCharEncInFunc cdecl alias "xmlCharEncInFunc" (byval handler as xmlCharEncodingHandler ptr, byval out as xmlBufferPtr, byval in as xmlBufferPtr) as integer
declare function xmlCharEncFirstLine cdecl alias "xmlCharEncFirstLine" (byval handler as xmlCharEncodingHandler ptr, byval out as xmlBufferPtr, byval in as xmlBufferPtr) as integer
declare function xmlCharEncCloseFunc cdecl alias "xmlCharEncCloseFunc" (byval handler as xmlCharEncodingHandler ptr) as integer
declare function UTF8Toisolat1 cdecl alias "UTF8Toisolat1" (byval out as ubyte ptr, byval outlen as integer ptr, byval in as ubyte ptr, byval inlen as integer ptr) as integer
declare function isolat1ToUTF8 cdecl alias "isolat1ToUTF8" (byval out as ubyte ptr, byval outlen as integer ptr, byval in as ubyte ptr, byval inlen as integer ptr) as integer

#endif
