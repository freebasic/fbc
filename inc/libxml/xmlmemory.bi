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

extern "C"

#define __DEBUG_MEMORY_ALLOC__
type xmlFreeFunc as sub(byval mem as any ptr)
type xmlMallocFunc as function(byval size as uinteger) as any ptr
type xmlReallocFunc as function(byval mem as any ptr, byval size as uinteger) as any ptr
type xmlStrdupFunc as function(byval str as const zstring ptr) as zstring ptr

declare function xmlMemSetup(byval freeFunc as xmlFreeFunc, byval mallocFunc as xmlMallocFunc, byval reallocFunc as xmlReallocFunc, byval strdupFunc as xmlStrdupFunc) as long
declare function xmlMemGet(byval freeFunc as xmlFreeFunc ptr, byval mallocFunc as xmlMallocFunc ptr, byval reallocFunc as xmlReallocFunc ptr, byval strdupFunc as xmlStrdupFunc ptr) as long
declare function xmlGcMemSetup(byval freeFunc as xmlFreeFunc, byval mallocFunc as xmlMallocFunc, byval mallocAtomicFunc as xmlMallocFunc, byval reallocFunc as xmlReallocFunc, byval strdupFunc as xmlStrdupFunc) as long
declare function xmlGcMemGet(byval freeFunc as xmlFreeFunc ptr, byval mallocFunc as xmlMallocFunc ptr, byval mallocAtomicFunc as xmlMallocFunc ptr, byval reallocFunc as xmlReallocFunc ptr, byval strdupFunc as xmlStrdupFunc ptr) as long
declare function xmlInitMemory() as long
declare sub xmlCleanupMemory()
declare function xmlMemUsed() as long
declare function xmlMemBlocks() as long
declare sub xmlMemDisplay(byval fp as FILE ptr)
declare sub xmlMemDisplayLast(byval fp as FILE ptr, byval nbBytes as clong)
declare sub xmlMemShow(byval fp as FILE ptr, byval nr as long)
declare sub xmlMemoryDump()
declare function xmlMemMalloc(byval size as uinteger) as any ptr
declare function xmlMemRealloc(byval ptr as any ptr, byval size as uinteger) as any ptr
declare sub xmlMemFree(byval ptr as any ptr)
declare function xmlMemoryStrdup(byval str as const zstring ptr) as zstring ptr
declare function xmlMallocLoc(byval size as uinteger, byval file as const zstring ptr, byval line as long) as any ptr
declare function xmlReallocLoc(byval ptr as any ptr, byval size as uinteger, byval file as const zstring ptr, byval line as long) as any ptr
declare function xmlMallocAtomicLoc(byval size as uinteger, byval file as const zstring ptr, byval line as long) as any ptr
declare function xmlMemStrdupLoc(byval str as const zstring ptr, byval file as const zstring ptr, byval line as long) as zstring ptr

end extern

#include once "libxml/threads.bi"
#include once "libxml/globals.bi"
