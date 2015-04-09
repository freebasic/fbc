'' FreeBASIC binding for libX11-1.6.3

#pragma once

#include once "X11/Xlib.bi"

extern "C"

#define _X11_XRESOURCE_H_
declare function Xpermalloc(byval as ulong) as zstring ptr
type XrmQuark as long
type XrmQuarkList as long ptr
#define NULLQUARK cast(XrmQuark, 0)
type XrmString as zstring ptr
#define NULLSTRING cast(XrmString, 0)
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
