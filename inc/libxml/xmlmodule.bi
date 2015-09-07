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

#define __XML_MODULE_H__
type xmlModule as _xmlModule
type xmlModulePtr as xmlModule ptr

type xmlModuleOption as long
enum
	XML_MODULE_LAZY = 1
	XML_MODULE_LOCAL = 2
end enum

declare function xmlModuleOpen(byval filename as const zstring ptr, byval options as long) as xmlModulePtr
declare function xmlModuleSymbol(byval module as xmlModulePtr, byval name as const zstring ptr, byval result as any ptr ptr) as long
declare function xmlModuleClose(byval module as xmlModulePtr) as long
declare function xmlModuleFree(byval module as xmlModulePtr) as long

end extern
