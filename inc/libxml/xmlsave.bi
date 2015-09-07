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
#include once "libxml/xmlversion.bi"
#include once "libxml/tree.bi"
#include once "libxml/encoding.bi"
#include once "libxml/xmlIO.bi"

extern "C"

#define __XML_XMLSAVE_H__

type xmlSaveOption as long
enum
	XML_SAVE_FORMAT = 1 shl 0
	XML_SAVE_NO_DECL = 1 shl 1
	XML_SAVE_NO_EMPTY = 1 shl 2
	XML_SAVE_NO_XHTML = 1 shl 3
	XML_SAVE_XHTML = 1 shl 4
	XML_SAVE_AS_XML = 1 shl 5
	XML_SAVE_AS_HTML = 1 shl 6
	XML_SAVE_WSNONSIG = 1 shl 7
end enum

type xmlSaveCtxt as _xmlSaveCtxt
type xmlSaveCtxtPtr as xmlSaveCtxt ptr
declare function xmlSaveToFd(byval fd as long, byval encoding as const zstring ptr, byval options as long) as xmlSaveCtxtPtr
declare function xmlSaveToFilename(byval filename as const zstring ptr, byval encoding as const zstring ptr, byval options as long) as xmlSaveCtxtPtr
declare function xmlSaveToBuffer(byval buffer as xmlBufferPtr, byval encoding as const zstring ptr, byval options as long) as xmlSaveCtxtPtr
declare function xmlSaveToIO(byval iowrite as xmlOutputWriteCallback, byval ioclose as xmlOutputCloseCallback, byval ioctx as any ptr, byval encoding as const zstring ptr, byval options as long) as xmlSaveCtxtPtr
declare function xmlSaveDoc(byval ctxt as xmlSaveCtxtPtr, byval doc as xmlDocPtr) as clong
declare function xmlSaveTree(byval ctxt as xmlSaveCtxtPtr, byval node as xmlNodePtr) as clong
declare function xmlSaveFlush(byval ctxt as xmlSaveCtxtPtr) as long
declare function xmlSaveClose(byval ctxt as xmlSaveCtxtPtr) as long
declare function xmlSaveSetEscape(byval ctxt as xmlSaveCtxtPtr, byval escape as xmlCharEncodingOutputFunc) as long
declare function xmlSaveSetAttrEscape(byval ctxt as xmlSaveCtxtPtr, byval escape as xmlCharEncodingOutputFunc) as long

end extern
