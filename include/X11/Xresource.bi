''
''
'' Xresource -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __Xresource_bi__
#define __Xresource_bi__

type XrmQuark as integer
type XrmQuarkList as integer ptr
type XrmString as byte ptr

declare function XrmQuarkToString cdecl alias "XrmQuarkToString" (byval as XrmQuark) as XrmString
declare function XrmUniqueQuark cdecl alias "XrmUniqueQuark" () as XrmQuark

enum XrmBinding
	XrmBindTightly
	XrmBindLoosely
end enum

type XrmName as XrmQuark
type XrmNameList as XrmQuarkList
type XrmClass as XrmQuark
type XrmClassList as XrmQuarkList
type XrmRepresentation as XrmQuark

type XrmValue
	size as uinteger
	addr as XPointer
end type

type XrmValuePtr as XrmValue ptr
type XrmHashBucket as _XrmHashBucketRec ptr
type XrmHashTable as XrmHashBucket ptr
type XrmSearchList as XrmHashTable ptr
type XrmDatabase as _XrmHashBucketRec ptr

declare sub XrmDestroyDatabase cdecl alias "XrmDestroyDatabase" (byval as XrmDatabase)
declare sub XrmQPutResource cdecl alias "XrmQPutResource" (byval as XrmDatabase ptr, byval as XrmBindingList, byval as XrmQuarkList, byval as XrmRepresentation, byval as XrmValue ptr)
declare function XrmQGetResource cdecl alias "XrmQGetResource" (byval as XrmDatabase, byval as XrmNameList, byval as XrmClassList, byval as XrmRepresentation ptr, byval as XrmValue ptr) as Bool
declare function XrmQGetSearchList cdecl alias "XrmQGetSearchList" (byval as XrmDatabase, byval as XrmNameList, byval as XrmClassList, byval as XrmSearchList, byval as integer) as Bool
declare function XrmQGetSearchResource cdecl alias "XrmQGetSearchResource" (byval as XrmSearchList, byval as XrmName, byval as XrmClass, byval as XrmRepresentation ptr, byval as XrmValue ptr) as Bool
declare sub XrmSetDatabase cdecl alias "XrmSetDatabase" (byval as Display ptr, byval as XrmDatabase)
declare function XrmGetDatabase cdecl alias "XrmGetDatabase" (byval as Display ptr) as XrmDatabase
declare sub XrmMergeDatabases cdecl alias "XrmMergeDatabases" (byval as XrmDatabase, byval as XrmDatabase ptr)
declare sub XrmCombineDatabase cdecl alias "XrmCombineDatabase" (byval as XrmDatabase, byval as XrmDatabase ptr, byval as Bool)

#define XrmEnumAllLevels 0
#define XrmEnumOneLevel 1

declare function XrmEnumerateDatabase cdecl alias "XrmEnumerateDatabase" (byval as XrmDatabase, byval as XrmNameList, byval as XrmClassList, byval as integer, byval as function cdecl(byval as XrmDatabase ptr, byval as XrmBindingList, byval as XrmQuarkList, byval as XrmRepresentation ptr, byval as XrmValue ptr, byval as XPointer) as Bool, byval as XPointer) as Bool
declare function XrmLocaleOfDatabase cdecl alias "XrmLocaleOfDatabase" (byval as XrmDatabase) as zstring ptr

enum XrmOptionKind
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

#endif
