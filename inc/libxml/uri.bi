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

#define __XML_URI_H__
type xmlURI as _xmlURI
type xmlURIPtr as xmlURI ptr

type _xmlURI
	scheme as zstring ptr
	opaque as zstring ptr
	authority as zstring ptr
	server as zstring ptr
	user as zstring ptr
	port as long
	path as zstring ptr
	query as zstring ptr
	fragment as zstring ptr
	cleanup as long
	query_raw as zstring ptr
end type

declare function xmlCreateURI() as xmlURIPtr
declare function xmlBuildURI(byval URI as const xmlChar ptr, byval base as const xmlChar ptr) as xmlChar ptr
declare function xmlBuildRelativeURI(byval URI as const xmlChar ptr, byval base as const xmlChar ptr) as xmlChar ptr
declare function xmlParseURI(byval str as const zstring ptr) as xmlURIPtr
declare function xmlParseURIRaw(byval str as const zstring ptr, byval raw as long) as xmlURIPtr
declare function xmlParseURIReference(byval uri as xmlURIPtr, byval str as const zstring ptr) as long
declare function xmlSaveUri(byval uri as xmlURIPtr) as xmlChar ptr
declare sub xmlPrintURI(byval stream as FILE ptr, byval uri as xmlURIPtr)
declare function xmlURIEscapeStr(byval str as const xmlChar ptr, byval list as const xmlChar ptr) as xmlChar ptr
declare function xmlURIUnescapeString(byval str as const zstring ptr, byval len as long, byval target as zstring ptr) as zstring ptr
declare function xmlNormalizeURIPath(byval path as zstring ptr) as long
declare function xmlURIEscape(byval str as const xmlChar ptr) as xmlChar ptr
declare sub xmlFreeURI(byval uri as xmlURIPtr)
declare function xmlCanonicPath(byval path as const xmlChar ptr) as xmlChar ptr
declare function xmlPathToURI(byval path as const xmlChar ptr) as xmlChar ptr

end extern
