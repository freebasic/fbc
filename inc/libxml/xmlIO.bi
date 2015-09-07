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

#include once "crt/long.bi"
#include once "crt/stdio.bi"
#include once "libxml/xmlversion.bi"
#include once "libxml/globals.bi"
#include once "libxml/tree.bi"
#include once "libxml/parser.bi"
#include once "libxml/encoding.bi"

extern "C"

#define __XML_IO_H__
type xmlInputMatchCallback as function(byval filename as const zstring ptr) as long
type xmlInputOpenCallback as function(byval filename as const zstring ptr) as any ptr
type xmlInputReadCallback as function(byval context as any ptr, byval buffer as zstring ptr, byval len as long) as long
type xmlInputCloseCallback as function(byval context as any ptr) as long
type xmlOutputMatchCallback as function(byval filename as const zstring ptr) as long
type xmlOutputOpenCallback as function(byval filename as const zstring ptr) as any ptr
type xmlOutputWriteCallback as function(byval context as any ptr, byval buffer as const zstring ptr, byval len as long) as long
type xmlOutputCloseCallback as function(byval context as any ptr) as long

type _xmlParserInputBuffer
	context as any ptr
	readcallback as xmlInputReadCallback
	closecallback as xmlInputCloseCallback
	encoder as xmlCharEncodingHandlerPtr
	buffer as xmlBufPtr
	raw as xmlBufPtr
	compressed as long
	error as long
	rawconsumed as culong
end type

type _xmlOutputBuffer
	context as any ptr
	writecallback as xmlOutputWriteCallback
	closecallback as xmlOutputCloseCallback
	encoder as xmlCharEncodingHandlerPtr
	buffer as xmlBufPtr
	conv as xmlBufPtr
	written as long
	error as long
end type

declare sub xmlCleanupInputCallbacks()
declare function xmlPopInputCallbacks() as long
declare sub xmlRegisterDefaultInputCallbacks()
declare function xmlAllocParserInputBuffer(byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFilename(byval URI as const zstring ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFile(byval file as FILE ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFd(byval fd as long, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateMem(byval mem as const zstring ptr, byval size as long, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateStatic(byval mem as const zstring ptr, byval size as long, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateIO(byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferRead(byval in as xmlParserInputBufferPtr, byval len as long) as long
declare function xmlParserInputBufferGrow(byval in as xmlParserInputBufferPtr, byval len as long) as long
declare function xmlParserInputBufferPush(byval in as xmlParserInputBufferPtr, byval len as long, byval buf as const zstring ptr) as long
declare sub xmlFreeParserInputBuffer(byval in as xmlParserInputBufferPtr)
declare function xmlParserGetDirectory(byval filename as const zstring ptr) as zstring ptr
declare function xmlRegisterInputCallbacks(byval matchFunc as xmlInputMatchCallback, byval openFunc as xmlInputOpenCallback, byval readFunc as xmlInputReadCallback, byval closeFunc as xmlInputCloseCallback) as long
declare function __xmlParserInputBufferCreateFilename(byval URI as const zstring ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare sub xmlCleanupOutputCallbacks()
declare sub xmlRegisterDefaultOutputCallbacks()
declare function xmlAllocOutputBuffer(byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFilename(byval URI as const zstring ptr, byval encoder as xmlCharEncodingHandlerPtr, byval compression as long) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFile(byval file as FILE ptr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateBuffer(byval buffer as xmlBufferPtr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFd(byval fd as long, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateIO(byval iowrite as xmlOutputWriteCallback, byval ioclose as xmlOutputCloseCallback, byval ioctx as any ptr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferGetContent(byval out as xmlOutputBufferPtr) as const xmlChar ptr
declare function xmlOutputBufferGetSize(byval out as xmlOutputBufferPtr) as uinteger
declare function xmlOutputBufferWrite(byval out as xmlOutputBufferPtr, byval len as long, byval buf as const zstring ptr) as long
declare function xmlOutputBufferWriteString(byval out as xmlOutputBufferPtr, byval str as const zstring ptr) as long
declare function xmlOutputBufferWriteEscape(byval out as xmlOutputBufferPtr, byval str as const xmlChar ptr, byval escaping as xmlCharEncodingOutputFunc) as long
declare function xmlOutputBufferFlush(byval out as xmlOutputBufferPtr) as long
declare function xmlOutputBufferClose(byval out as xmlOutputBufferPtr) as long
declare function xmlRegisterOutputCallbacks(byval matchFunc as xmlOutputMatchCallback, byval openFunc as xmlOutputOpenCallback, byval writeFunc as xmlOutputWriteCallback, byval closeFunc as xmlOutputCloseCallback) as long
declare function __xmlOutputBufferCreateFilename(byval URI as const zstring ptr, byval encoder as xmlCharEncodingHandlerPtr, byval compression as long) as xmlOutputBufferPtr
declare sub xmlRegisterHTTPPostCallbacks()
declare function xmlCheckHTTPInput(byval ctxt as xmlParserCtxtPtr, byval ret as xmlParserInputPtr) as xmlParserInputPtr
declare function xmlNoNetExternalEntityLoader(byval URL as const zstring ptr, byval ID as const zstring ptr, byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function xmlNormalizeWindowsPath(byval path as const xmlChar ptr) as xmlChar ptr
declare function xmlCheckFilename(byval path as const zstring ptr) as long
declare function xmlFileMatch(byval filename as const zstring ptr) as long
declare function xmlFileOpen(byval filename as const zstring ptr) as any ptr
declare function xmlFileRead(byval context as any ptr, byval buffer as zstring ptr, byval len as long) as long
declare function xmlFileClose(byval context as any ptr) as long
declare function xmlIOHTTPMatch(byval filename as const zstring ptr) as long
declare function xmlIOHTTPOpen(byval filename as const zstring ptr) as any ptr
declare function xmlIOHTTPOpenW(byval post_uri as const zstring ptr, byval compression as long) as any ptr
declare function xmlIOHTTPRead(byval context as any ptr, byval buffer as zstring ptr, byval len as long) as long
declare function xmlIOHTTPClose(byval context as any ptr) as long
declare function xmlIOFTPMatch(byval filename as const zstring ptr) as long
declare function xmlIOFTPOpen(byval filename as const zstring ptr) as any ptr
declare function xmlIOFTPRead(byval context as any ptr, byval buffer as zstring ptr, byval len as long) as long
declare function xmlIOFTPClose(byval context as any ptr) as long

end extern
