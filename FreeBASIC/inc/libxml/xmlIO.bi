''
''
'' xmlIO -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __xmlIO_bi__
#define __xmlIO_bi__

#include once "libxml/xmlversion.bi"

type xmlInputMatchCallback as integer ptr
type xmlInputOpenCallback as any ptr
type xmlInputReadCallback as integer ptr
type xmlInputCloseCallback as integer ptr
type xmlOutputMatchCallback as integer ptr
type xmlOutputOpenCallback as any ptr
type xmlOutputWriteCallback as integer ptr
type xmlOutputCloseCallback as integer ptr

#include once "libxml/globals.bi"
#include once "libxml/tree.bi"
#include once "libxml/parser.bi"
#include once "libxml/encoding.bi"


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

declare sub xmlCleanupInputCallbacks cdecl alias "xmlCleanupInputCallbacks" ()
declare function xmlPopInputCallbacks cdecl alias "xmlPopInputCallbacks" () as integer
declare sub xmlRegisterDefaultInputCallbacks cdecl alias "xmlRegisterDefaultInputCallbacks" ()
declare function xmlAllocParserInputBuffer cdecl alias "xmlAllocParserInputBuffer" (byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFilename cdecl alias "xmlParserInputBufferCreateFilename" (byval URI as string, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFile cdecl alias "xmlParserInputBufferCreateFile" (byval file as FILE ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateFd cdecl alias "xmlParserInputBufferCreateFd" (byval fd as integer, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateMem cdecl alias "xmlParserInputBufferCreateMem" (byval mem as string, byval size as integer, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateStatic cdecl alias "xmlParserInputBufferCreateStatic" (byval mem as string, byval size as integer, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferCreateIO cdecl alias "xmlParserInputBufferCreateIO" (byval ioread as xmlInputReadCallback, byval ioclose as xmlInputCloseCallback, byval ioctx as any ptr, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare function xmlParserInputBufferRead cdecl alias "xmlParserInputBufferRead" (byval in as xmlParserInputBufferPtr, byval len as integer) as integer
declare function xmlParserInputBufferGrow cdecl alias "xmlParserInputBufferGrow" (byval in as xmlParserInputBufferPtr, byval len as integer) as integer
declare function xmlParserInputBufferPush cdecl alias "xmlParserInputBufferPush" (byval in as xmlParserInputBufferPtr, byval len as integer, byval buf as string) as integer
declare sub xmlFreeParserInputBuffer cdecl alias "xmlFreeParserInputBuffer" (byval in as xmlParserInputBufferPtr)
declare function xmlParserGetDirectory cdecl alias "xmlParserGetDirectory" (byval filename as string) as byte ptr
declare function xmlRegisterInputCallbacks cdecl alias "xmlRegisterInputCallbacks" (byval matchFunc as xmlInputMatchCallback, byval openFunc as xmlInputOpenCallback, byval readFunc as xmlInputReadCallback, byval closeFunc as xmlInputCloseCallback) as integer
declare function __xmlParserInputBufferCreateFilename cdecl alias "__xmlParserInputBufferCreateFilename" (byval URI as string, byval enc as xmlCharEncoding) as xmlParserInputBufferPtr
declare sub xmlCleanupOutputCallbacks cdecl alias "xmlCleanupOutputCallbacks" ()
declare sub xmlRegisterDefaultOutputCallbacks cdecl alias "xmlRegisterDefaultOutputCallbacks" ()
declare function xmlAllocOutputBuffer cdecl alias "xmlAllocOutputBuffer" (byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFilename cdecl alias "xmlOutputBufferCreateFilename" (byval URI as string, byval encoder as xmlCharEncodingHandlerPtr, byval compression as integer) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFile cdecl alias "xmlOutputBufferCreateFile" (byval file as FILE ptr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateFd cdecl alias "xmlOutputBufferCreateFd" (byval fd as integer, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferCreateIO cdecl alias "xmlOutputBufferCreateIO" (byval iowrite as xmlOutputWriteCallback, byval ioclose as xmlOutputCloseCallback, byval ioctx as any ptr, byval encoder as xmlCharEncodingHandlerPtr) as xmlOutputBufferPtr
declare function xmlOutputBufferWrite cdecl alias "xmlOutputBufferWrite" (byval out as xmlOutputBufferPtr, byval len as integer, byval buf as string) as integer
declare function xmlOutputBufferWriteString cdecl alias "xmlOutputBufferWriteString" (byval out as xmlOutputBufferPtr, byval str as string) as integer
declare function xmlOutputBufferWriteEscape cdecl alias "xmlOutputBufferWriteEscape" (byval out as xmlOutputBufferPtr, byval str as xmlChar ptr, byval escaping as xmlCharEncodingOutputFunc) as integer
declare function xmlOutputBufferFlush cdecl alias "xmlOutputBufferFlush" (byval out as xmlOutputBufferPtr) as integer
declare function xmlOutputBufferClose cdecl alias "xmlOutputBufferClose" (byval out as xmlOutputBufferPtr) as integer
declare function xmlRegisterOutputCallbacks cdecl alias "xmlRegisterOutputCallbacks" (byval matchFunc as xmlOutputMatchCallback, byval openFunc as xmlOutputOpenCallback, byval writeFunc as xmlOutputWriteCallback, byval closeFunc as xmlOutputCloseCallback) as integer
declare function __xmlOutputBufferCreateFilename cdecl alias "__xmlOutputBufferCreateFilename" (byval URI as string, byval encoder as xmlCharEncodingHandlerPtr, byval compression as integer) as xmlOutputBufferPtr
declare sub xmlRegisterHTTPPostCallbacks cdecl alias "xmlRegisterHTTPPostCallbacks" ()
declare function xmlCheckHTTPInput cdecl alias "xmlCheckHTTPInput" (byval ctxt as xmlParserCtxtPtr, byval ret as xmlParserInputPtr) as xmlParserInputPtr
declare function xmlNoNetExternalEntityLoader cdecl alias "xmlNoNetExternalEntityLoader" (byval URL as string, byval ID as string, byval ctxt as xmlParserCtxtPtr) as xmlParserInputPtr
declare function xmlNormalizeWindowsPath cdecl alias "xmlNormalizeWindowsPath" (byval path as xmlChar ptr) as xmlChar ptr
declare function xmlCheckFilename cdecl alias "xmlCheckFilename" (byval path as string) as integer
declare function xmlFileMatch cdecl alias "xmlFileMatch" (byval filename as string) as integer
declare function xmlFileOpen cdecl alias "xmlFileOpen" (byval filename as string) as any ptr
declare function xmlFileRead cdecl alias "xmlFileRead" (byval context as any ptr, byval buffer as string, byval len as integer) as integer
declare function xmlFileClose cdecl alias "xmlFileClose" (byval context as any ptr) as integer
declare function xmlIOHTTPMatch cdecl alias "xmlIOHTTPMatch" (byval filename as string) as integer
declare function xmlIOHTTPOpen cdecl alias "xmlIOHTTPOpen" (byval filename as string) as any ptr
declare function xmlIOHTTPOpenW cdecl alias "xmlIOHTTPOpenW" (byval post_uri as string, byval compression as integer) as any ptr
declare function xmlIOHTTPRead cdecl alias "xmlIOHTTPRead" (byval context as any ptr, byval buffer as string, byval len as integer) as integer
declare function xmlIOHTTPClose cdecl alias "xmlIOHTTPClose" (byval context as any ptr) as integer
declare function xmlIOFTPMatch cdecl alias "xmlIOFTPMatch" (byval filename as string) as integer
declare function xmlIOFTPOpen cdecl alias "xmlIOFTPOpen" (byval filename as string) as any ptr
declare function xmlIOFTPRead cdecl alias "xmlIOFTPRead" (byval context as any ptr, byval buffer as string, byval len as integer) as integer
declare function xmlIOFTPClose cdecl alias "xmlIOFTPClose" (byval context as any ptr) as integer

#endif
