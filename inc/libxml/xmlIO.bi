''
''
'' xmlIO -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xml_xmlIO_bi__
#define __xml_xmlIO_bi__

#include once "xmlversion.bi"

type xmlInputMatchCallback as integer ptr
type xmlInputOpenCallback as any ptr
type xmlInputReadCallback as integer ptr
type xmlInputCloseCallback as integer ptr
type xmlOutputMatchCallback as integer ptr
type xmlOutputOpenCallback as any ptr
type xmlOutputWriteCallback as integer ptr
type xmlOutputCloseCallback as integer ptr

#include once "globals.bi"
#include once "tree.bi"
#include once "parser.bi"
#include once "encoding.bi"


type _xmlParserInputBuffer
	context as any ptr
	readcallback as xmlInputReadCallback
	closecallback as xmlInputCloseCallback
	encoder as xmlCharEncodingHandlerPtr
	buffer as xmlBufferPtr
	raw as xmlBufferPtr
	compressed as integer
	error as integer
	rawconsumed as uinteger
end type

type _xmlOutputBuffer
	context as any ptr
	writecallback as xmlOutputWriteCallback
	closecallback as xmlOutputCloseCallback
	encoder as xmlCharEncodingHandlerPtr
	buffer as xmlBufferPtr
	conv as xmlBufferPtr
	written as integer
	error as integer
end type

extern "c"
declare sub xmlCleanupInputCallbacks ()
declare function xmlPopInputCallbacks () as integer
declare sub xmlRegisterDefaultInputCallbacks ()
declare function xmlAllocParserInputBuffer (byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFilename (byval URI as zstring ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFile (byval file as FILE ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFd (byval fd as integer, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateMem (byval mem as zstring ptr, byval size as integer, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateStatic (byval mem as zstring ptr, byval size as integer, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateIO (byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferRead (byval in as xmlParserInputBufferPtr, byval len as integer) as integer
declare function xmlParserInputBufferGrow (byval in as xmlParserInputBufferPtr, byval len as integer) as integer
declare function xmlParserInputBufferPush (byval in as xmlParserInputBufferPtr, byval len as integer, byval buf as zstring ptr) as integer
declare sub xmlFreeParserInputBuffer (byval in as xmlParserInputBufferPtr)
declare function xmlParserGetDirectory (byval filename as zstring ptr) as byte ptr
declare function xmlRegisterInputCallbacks (byval matchFunc as xmlInputMatchCallback, byval openFunc as xmlInputOpenCallback, byval readFunc as xmlInputReadCallback, byval closeFunc as xmlInputCloseCallback) as integer
declare function __xmlParserInputBufferCreateFilename (byval URI as zstring ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare sub xmlCleanupOutputCallbacks ()
declare sub xmlRegisterDefaultOutputCallbacks ()
declare function xmlAllocOutputBuffer (byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFilename (byval URI as zstring ptr, byval encoder as xmlCharEncodingHandlerPtr, byval compression as integer) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFile (byval file as FILE ptr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFd (byval fd as integer, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateIO (byval iowrite as xmlOutputWriteCallback, byval ioclose as xmlOutputCloseCallback, byval ioctx as any ptr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferWrite (byval out as xmlOutputBufferPtr, byval len as integer, byval buf as zstring ptr) as integer
declare function xmlOutputBufferWriteString (byval out as xmlOutputBufferPtr, byval str as zstring ptr) as integer
declare function xmlOutputBufferWriteEscape (byval out as xmlOutputBufferPtr, byval str as zstring ptr, byval escaping as xmlCharEncodingOutputFunc) as integer
declare function xmlOutputBufferFlush (byval out as xmlOutputBufferPtr) as integer
declare function xmlOutputBufferClose (byval out as xmlOutputBufferPtr) as integer
declare function xmlRegisterOutputCallbacks (byval matchFunc as xmlOutputMatchCallback, byval openFunc as xmlOutputOpenCallback, byval writeFunc as xmlOutputWriteCallback, byval closeFunc as xmlOutputCloseCallback) as integer
declare function __xmlOutputBufferCreateFilename (byval URI as zstring ptr, byval encoder as xmlCharEncodingHandlerPtr, byval compression as integer) as xmlOutputBufferPtr
declare sub xmlRegisterHTTPPostCallbacks ()
declare function xmlCheckHTTPInput (byval ctxt as xmlParserCtxtPtr, byval ret as xmlParserInputPtr) as xmlParserInputPtr
declare function xmlNoNetExternalEntityLoader (byval URL as zstring ptr, byval ID as zstring ptr, byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function xmlNormalizeWindowsPath (byval path as zstring ptr) as zstring ptr
declare function xmlCheckFilename (byval path as zstring ptr) as integer
declare function xmlFileMatch (byval filename as zstring ptr) as integer
declare function xmlFileOpen (byval filename as zstring ptr) as any ptr
declare function xmlFileRead (byval context as any ptr, byval buffer as zstring ptr, byval len as integer) as integer
declare function xmlFileClose (byval context as any ptr) as integer
declare function xmlIOHTTPMatch (byval filename as zstring ptr) as integer
declare function xmlIOHTTPOpen (byval filename as zstring ptr) as any ptr
declare function xmlIOHTTPOpenW (byval post_uri as zstring ptr, byval compression as integer) as any ptr
declare function xmlIOHTTPRead (byval context as any ptr, byval buffer as zstring ptr, byval len as integer) as integer
declare function xmlIOHTTPClose (byval context as any ptr) as integer
declare function xmlIOFTPMatch (byval filename as zstring ptr) as integer
declare function xmlIOFTPOpen (byval filename as zstring ptr) as any ptr
declare function xmlIOFTPRead (byval context as any ptr, byval buffer as zstring ptr, byval len as integer) as integer
declare function xmlIOFTPClose (byval context as any ptr) as integer
end extern

#endif
