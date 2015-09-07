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

#include once "crt/stdarg.bi"
#include once "libxml/xmlversion.bi"

extern "C"

#define __XML_STRING_H__
type xmlChar as ubyte
declare function xmlStrdup(byval cur as const xmlChar ptr) as xmlChar ptr
declare function xmlStrndup(byval cur as const xmlChar ptr, byval len as long) as xmlChar ptr
declare function xmlCharStrndup(byval cur as const zstring ptr, byval len as long) as xmlChar ptr
declare function xmlCharStrdup(byval cur as const zstring ptr) as xmlChar ptr
declare function xmlStrsub(byval str as const xmlChar ptr, byval start as long, byval len as long) as xmlChar ptr
declare function xmlStrchr(byval str as const xmlChar ptr, byval val as xmlChar) as const xmlChar ptr
declare function xmlStrstr(byval str as const xmlChar ptr, byval val as const xmlChar ptr) as const xmlChar ptr
declare function xmlStrcasestr(byval str as const xmlChar ptr, byval val as const xmlChar ptr) as const xmlChar ptr
declare function xmlStrcmp(byval str1 as const xmlChar ptr, byval str2 as const xmlChar ptr) as long
declare function xmlStrncmp(byval str1 as const xmlChar ptr, byval str2 as const xmlChar ptr, byval len as long) as long
declare function xmlStrcasecmp(byval str1 as const xmlChar ptr, byval str2 as const xmlChar ptr) as long
declare function xmlStrncasecmp(byval str1 as const xmlChar ptr, byval str2 as const xmlChar ptr, byval len as long) as long
declare function xmlStrEqual(byval str1 as const xmlChar ptr, byval str2 as const xmlChar ptr) as long
declare function xmlStrQEqual(byval pref as const xmlChar ptr, byval name as const xmlChar ptr, byval str as const xmlChar ptr) as long
declare function xmlStrlen(byval str as const xmlChar ptr) as long
declare function xmlStrcat(byval cur as xmlChar ptr, byval add as const xmlChar ptr) as xmlChar ptr
declare function xmlStrncat(byval cur as xmlChar ptr, byval add as const xmlChar ptr, byval len as long) as xmlChar ptr
declare function xmlStrncatNew(byval str1 as const xmlChar ptr, byval str2 as const xmlChar ptr, byval len as long) as xmlChar ptr
declare function xmlStrPrintf(byval buf as xmlChar ptr, byval len as long, byval msg as const xmlChar ptr, ...) as long
declare function xmlStrVPrintf(byval buf as xmlChar ptr, byval len as long, byval msg as const xmlChar ptr, byval ap as va_list) as long
declare function xmlGetUTF8Char(byval utf as const ubyte ptr, byval len as long ptr) as long
declare function xmlCheckUTF8(byval utf as const ubyte ptr) as long
declare function xmlUTF8Strsize(byval utf as const xmlChar ptr, byval len as long) as long
declare function xmlUTF8Strndup(byval utf as const xmlChar ptr, byval len as long) as xmlChar ptr
declare function xmlUTF8Strpos(byval utf as const xmlChar ptr, byval pos as long) as const xmlChar ptr
declare function xmlUTF8Strloc(byval utf as const xmlChar ptr, byval utfchar as const xmlChar ptr) as long
declare function xmlUTF8Strsub(byval utf as const xmlChar ptr, byval start as long, byval len as long) as xmlChar ptr
declare function xmlUTF8Strlen(byval utf as const xmlChar ptr) as long
declare function xmlUTF8Size(byval utf as const xmlChar ptr) as long
declare function xmlUTF8Charcmp(byval utf1 as const xmlChar ptr, byval utf2 as const xmlChar ptr) as long

end extern
