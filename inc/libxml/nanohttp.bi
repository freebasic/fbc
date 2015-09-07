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

extern "C"

#define __NANO_HTTP_H__
declare sub xmlNanoHTTPInit()
declare sub xmlNanoHTTPCleanup()
declare sub xmlNanoHTTPScanProxy(byval URL as const zstring ptr)
declare function xmlNanoHTTPFetch(byval URL as const zstring ptr, byval filename as const zstring ptr, byval contentType as zstring ptr ptr) as long
declare function xmlNanoHTTPMethod(byval URL as const zstring ptr, byval method as const zstring ptr, byval input as const zstring ptr, byval contentType as zstring ptr ptr, byval headers as const zstring ptr, byval ilen as long) as any ptr
declare function xmlNanoHTTPMethodRedir(byval URL as const zstring ptr, byval method as const zstring ptr, byval input as const zstring ptr, byval contentType as zstring ptr ptr, byval redir as zstring ptr ptr, byval headers as const zstring ptr, byval ilen as long) as any ptr
declare function xmlNanoHTTPOpen(byval URL as const zstring ptr, byval contentType as zstring ptr ptr) as any ptr
declare function xmlNanoHTTPOpenRedir(byval URL as const zstring ptr, byval contentType as zstring ptr ptr, byval redir as zstring ptr ptr) as any ptr
declare function xmlNanoHTTPReturnCode(byval ctx as any ptr) as long
declare function xmlNanoHTTPAuthHeader(byval ctx as any ptr) as const zstring ptr
declare function xmlNanoHTTPRedir(byval ctx as any ptr) as const zstring ptr
declare function xmlNanoHTTPContentLength(byval ctx as any ptr) as long
declare function xmlNanoHTTPEncoding(byval ctx as any ptr) as const zstring ptr
declare function xmlNanoHTTPMimeType(byval ctx as any ptr) as const zstring ptr
declare function xmlNanoHTTPRead(byval ctx as any ptr, byval dest as any ptr, byval len as long) as long
declare function xmlNanoHTTPSave(byval ctxt as any ptr, byval filename as const zstring ptr) as long
declare sub xmlNanoHTTPClose(byval ctx as any ptr)

end extern
