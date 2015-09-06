'' FreeBASIC binding for libX11-1.6.3
''
'' based on the C header files:
''   *********************************************************
''
''   Copyright 1987, 1988, 1998  The Open Group
''
''   Permission to use, copy, modify, distribute, and sell this software and its
''   documentation for any purpose is hereby granted without fee, provided that
''   the above copyright notice appear in all copies and that both that
''   copyright notice and this permission notice appear in supporting
''   documentation.
''
''   The above copyright notice and this permission notice shall be included in
''   all copies or substantial portions of the Software.
''
''   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
''   IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
''   FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
''   OPEN GROUP BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
''   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
''   CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
''
''   Except as contained in this notice, the name of The Open Group shall not be
''   used in advertising or otherwise to promote the sale, use or other dealings
''   in this Software without prior written authorization from The Open Group.
''
''
''   Copyright 1987, 1988 by Digital Equipment Corporation, Maynard, Massachusetts.
''
''                           All Rights Reserved
''
''   Permission to use, copy, modify, and distribute this software and its
''   documentation for any purpose and without fee is hereby granted,
''   provided that the above copyright notice appear in all copies and that
''   both that copyright notice and this permission notice appear in
''   supporting documentation, and that the name of Digital not be
''   used in advertising or publicity pertaining to distribution of the
''   software without specific, written prior permission.
''
''   DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
''   ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
''   DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
''   ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
''   WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
''   ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
''   SOFTWARE.
''
''   *****************************************************************
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "X11/Xlib.bi"

extern "C"

#define _X11_XRESOURCE_H_
declare function Xpermalloc(byval as ulong) as zstring ptr
type XrmQuark as long
type XrmQuarkList as long ptr
const NULLQUARK = cast(XrmQuark, 0)
type XrmString as zstring ptr
const NULLSTRING = cast(XrmString, 0)
declare function XrmStringToQuark(byval as const zstring ptr) as XrmQuark
declare function XrmPermStringToQuark(byval as const zstring ptr) as XrmQuark
declare function XrmQuarkToString(byval as XrmQuark) as XrmString
declare function XrmUniqueQuark() as XrmQuark
#define XrmStringsEqual(a1, a2) (strcmp(a1, a2) = 0)

type XrmBinding as long
enum
	XrmBindTightly
	XrmBindLoosely
end enum

type XrmBindingList as XrmBinding ptr
declare sub XrmStringToQuarkList(byval as const zstring ptr, byval as XrmQuarkList)
declare sub XrmStringToBindingQuarkList(byval as const zstring ptr, byval as XrmBindingList, byval as XrmQuarkList)
type XrmName as XrmQuark
type XrmNameList as XrmQuarkList
#define XrmNameToString(name) XrmQuarkToString(name)
#define XrmStringToName(string) XrmStringToQuark(string)
#define XrmStringToNameList(str, name) XrmStringToQuarkList(str, name)
type XrmClass as XrmQuark
type XrmClassList as XrmQuarkList
#define XrmClassToString(c_class) XrmQuarkToString(c_class)
#define XrmStringToClass(c_class) XrmStringToQuark(c_class)
#define XrmStringToClassList(str, c_class) XrmStringToQuarkList(str, c_class)
type XrmRepresentation as XrmQuark
#define XrmStringToRepresentation(string) XrmStringToQuark(string)
#define XrmRepresentationToString(type) XrmQuarkToString(type)

type XrmValue
	size as ulong
	addr as XPointer
end type

type XrmValuePtr as XrmValue ptr
type XrmHashBucket as _XrmHashBucketRec ptr
type XrmHashTable as XrmHashBucket ptr
type XrmDatabase as _XrmHashBucketRec ptr

declare sub XrmDestroyDatabase(byval as XrmDatabase)
declare sub XrmQPutResource(byval as XrmDatabase ptr, byval as XrmBindingList, byval as XrmQuarkList, byval as XrmRepresentation, byval as XrmValue ptr)
declare sub XrmPutResource(byval as XrmDatabase ptr, byval as const zstring ptr, byval as const zstring ptr, byval as XrmValue ptr)
declare sub XrmQPutStringResource(byval as XrmDatabase ptr, byval as XrmBindingList, byval as XrmQuarkList, byval as const zstring ptr)
declare sub XrmPutStringResource(byval as XrmDatabase ptr, byval as const zstring ptr, byval as const zstring ptr)
declare sub XrmPutLineResource(byval as XrmDatabase ptr, byval as const zstring ptr)
declare function XrmQGetResource(byval as XrmDatabase, byval as XrmNameList, byval as XrmClassList, byval as XrmRepresentation ptr, byval as XrmValue ptr) as long
declare function XrmGetResource(byval as XrmDatabase, byval as const zstring ptr, byval as const zstring ptr, byval as zstring ptr ptr, byval as XrmValue ptr) as long
declare function XrmQGetSearchList(byval as XrmDatabase, byval as XrmNameList, byval as XrmClassList, byval as XrmHashTable ptr, byval as long) as long
declare function XrmQGetSearchResource(byval as XrmHashTable ptr, byval as XrmName, byval as XrmClass, byval as XrmRepresentation ptr, byval as XrmValue ptr) as long
declare sub XrmSetDatabase(byval as Display ptr, byval as XrmDatabase)
declare function XrmGetDatabase(byval as Display ptr) as XrmDatabase
declare function XrmGetFileDatabase(byval as const zstring ptr) as XrmDatabase
declare function XrmCombineFileDatabase(byval as const zstring ptr, byval as XrmDatabase ptr, byval as long) as long
declare function XrmGetStringDatabase(byval as const zstring ptr) as XrmDatabase
declare sub XrmPutFileDatabase(byval as XrmDatabase, byval as const zstring ptr)
declare sub XrmMergeDatabases(byval as XrmDatabase, byval as XrmDatabase ptr)
declare sub XrmCombineDatabase(byval as XrmDatabase, byval as XrmDatabase ptr, byval as long)
const XrmEnumAllLevels = 0
const XrmEnumOneLevel = 1
declare function XrmEnumerateDatabase(byval as XrmDatabase, byval as XrmNameList, byval as XrmClassList, byval as long, byval as function(byval as XrmDatabase ptr, byval as XrmBindingList, byval as XrmQuarkList, byval as XrmRepresentation ptr, byval as XrmValue ptr, byval as XPointer) as long, byval as XPointer) as long
declare function XrmLocaleOfDatabase(byval as XrmDatabase) as const zstring ptr

type XrmOptionKind as long
enum
	XrmoptionNoArg
	XrmoptionIsArg
	XrmoptionStickyArg
	XrmoptionSepArg
	XrmoptionResArg
	XrmoptionSkipArg
	XrmoptionSkipLine
	XrmoptionSkipNArgs
end enum

type XrmOptionDescRec
	option as zstring ptr
	specifier as zstring ptr
	argKind as XrmOptionKind
	value as XPointer
end type

type XrmOptionDescList as XrmOptionDescRec ptr
declare sub XrmParseCommand(byval as XrmDatabase ptr, byval as XrmOptionDescList, byval as long, byval as const zstring ptr, byval as long ptr, byval as zstring ptr ptr)

end extern
