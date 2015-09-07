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
#include once "libxml/parser.bi"
#include once "libxml/dict.bi"

extern "C"

#define __XML_HASH_H__
type xmlHashTable as _xmlHashTable
type xmlHashTablePtr as xmlHashTable ptr
#define XML_CAST_FPTR(fptr) fptr
type xmlHashDeallocator as sub(byval payload as any ptr, byval name as xmlChar ptr)
type xmlHashCopier as function(byval payload as any ptr, byval name as xmlChar ptr) as any ptr
type xmlHashScanner as sub(byval payload as any ptr, byval data as any ptr, byval name as xmlChar ptr)
type xmlHashScannerFull as sub(byval payload as any ptr, byval data as any ptr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr)

declare function xmlHashCreate(byval size as long) as xmlHashTablePtr
declare function xmlHashCreateDict(byval size as long, byval dict as xmlDictPtr) as xmlHashTablePtr
declare sub xmlHashFree(byval table as xmlHashTablePtr, byval f as xmlHashDeallocator)
declare function xmlHashAddEntry(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval userdata as any ptr) as long
declare function xmlHashUpdateEntry(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as long
declare function xmlHashAddEntry2(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval userdata as any ptr) as long
declare function xmlHashUpdateEntry2(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as long
declare function xmlHashAddEntry3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr, byval userdata as any ptr) as long
declare function xmlHashUpdateEntry3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr, byval userdata as any ptr, byval f as xmlHashDeallocator) as long
declare function xmlHashRemoveEntry(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval f as xmlHashDeallocator) as long
declare function xmlHashRemoveEntry2(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval f as xmlHashDeallocator) as long
declare function xmlHashRemoveEntry3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr, byval f as xmlHashDeallocator) as long
declare function xmlHashLookup(byval table as xmlHashTablePtr, byval name as const xmlChar ptr) as any ptr
declare function xmlHashLookup2(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr) as any ptr
declare function xmlHashLookup3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr) as any ptr
declare function xmlHashQLookup(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval prefix as const xmlChar ptr) as any ptr
declare function xmlHashQLookup2(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval prefix as const xmlChar ptr, byval name2 as const xmlChar ptr, byval prefix2 as const xmlChar ptr) as any ptr
declare function xmlHashQLookup3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval prefix as const xmlChar ptr, byval name2 as const xmlChar ptr, byval prefix2 as const xmlChar ptr, byval name3 as const xmlChar ptr, byval prefix3 as const xmlChar ptr) as any ptr
declare function xmlHashCopy(byval table as xmlHashTablePtr, byval f as xmlHashCopier) as xmlHashTablePtr
declare function xmlHashSize(byval table as xmlHashTablePtr) as long
declare sub xmlHashScan(byval table as xmlHashTablePtr, byval f as xmlHashScanner, byval data as any ptr)
declare sub xmlHashScan3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr, byval f as xmlHashScanner, byval data as any ptr)
declare sub xmlHashScanFull(byval table as xmlHashTablePtr, byval f as xmlHashScannerFull, byval data as any ptr)
declare sub xmlHashScanFull3(byval table as xmlHashTablePtr, byval name as const xmlChar ptr, byval name2 as const xmlChar ptr, byval name3 as const xmlChar ptr, byval f as xmlHashScannerFull, byval data as any ptr)

end extern
