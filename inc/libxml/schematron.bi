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
#include once "libxml/tree.bi"

extern "C"

#define __XML_SCHEMATRON_H__

type xmlSchematronValidOptions as long
enum
	XML_SCHEMATRON_OUT_QUIET = 1 shl 0
	XML_SCHEMATRON_OUT_TEXT = 1 shl 1
	XML_SCHEMATRON_OUT_XML = 1 shl 2
	XML_SCHEMATRON_OUT_ERROR = 1 shl 3
	XML_SCHEMATRON_OUT_FILE = 1 shl 8
	XML_SCHEMATRON_OUT_BUFFER = 1 shl 9
	XML_SCHEMATRON_OUT_IO = 1 shl 10
end enum

type xmlSchematron as _xmlSchematron
type xmlSchematronPtr as xmlSchematron ptr
type xmlSchematronValidityErrorFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlSchematronValidityWarningFunc as sub(byval ctx as any ptr, byval msg as const zstring ptr, ...)
type xmlSchematronParserCtxt as _xmlSchematronParserCtxt
type xmlSchematronParserCtxtPtr as xmlSchematronParserCtxt ptr
type xmlSchematronValidCtxt as _xmlSchematronValidCtxt
type xmlSchematronValidCtxtPtr as xmlSchematronValidCtxt ptr

declare function xmlSchematronNewParserCtxt(byval URL as const zstring ptr) as xmlSchematronParserCtxtPtr
declare function xmlSchematronNewMemParserCtxt(byval buffer as const zstring ptr, byval size as long) as xmlSchematronParserCtxtPtr
declare function xmlSchematronNewDocParserCtxt(byval doc as xmlDocPtr) as xmlSchematronParserCtxtPtr
declare sub xmlSchematronFreeParserCtxt(byval ctxt as xmlSchematronParserCtxtPtr)
declare function xmlSchematronParse(byval ctxt as xmlSchematronParserCtxtPtr) as xmlSchematronPtr
declare sub xmlSchematronFree(byval schema as xmlSchematronPtr)
declare sub xmlSchematronSetValidStructuredErrors(byval ctxt as xmlSchematronValidCtxtPtr, byval serror as xmlStructuredErrorFunc, byval ctx as any ptr)
declare function xmlSchematronNewValidCtxt(byval schema as xmlSchematronPtr, byval options as long) as xmlSchematronValidCtxtPtr
declare sub xmlSchematronFreeValidCtxt(byval ctxt as xmlSchematronValidCtxtPtr)
declare function xmlSchematronValidateDoc(byval ctxt as xmlSchematronValidCtxtPtr, byval instance as xmlDocPtr) as long

end extern
