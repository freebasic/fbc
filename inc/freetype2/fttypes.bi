''
''
'' fttypes -- header translated with help of SWIG FB wrapper
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __fttypes_bi__
#define __fttypes_bi__

#include once "config/ftconfig.bi"
#include once "ftsystem.bi"
#include once "ftimage.bi"
''#include once "stddef.bi"

type FT_Bool as ubyte
type FT_FWord as short
type FT_UFWord as ushort
type FT_Char as byte
type FT_Byte as ubyte
type FT_String as byte
type FT_Short as short
type FT_UShort as ushort
type FT_Int as integer
type FT_UInt as uinteger
type FT_Long as integer
type FT_ULong as uinteger
type FT_F2Dot14 as short
type FT_F26Dot6 as integer
type FT_Fixed as integer
type FT_Error as integer
type FT_Pointer as any ptr
type FT_Offset as size_t
type FT_PtrDist as size_t

type FT_UnitVector_
	x as FT_F2Dot14
	y as FT_F2Dot14
end type

type FT_UnitVector as FT_UnitVector_

type FT_Matrix_
	xx as FT_Fixed
	xy as FT_Fixed
	yx as FT_Fixed
	yy as FT_Fixed
end type

type FT_Matrix as FT_Matrix_

type FT_Data_
	pointer as FT_Byte ptr
	length as FT_Int
end type

type FT_Data as FT_Data_
type FT_Generic_Finalizer as sub cdecl(byval as any ptr)

type FT_Generic_
	data as any ptr
	finalizer as FT_Generic_Finalizer
end type

type FT_Generic as FT_Generic_
type FT_ListNode as FT_ListNodeRec_ ptr
type FT_List as FT_ListRec_ ptr

type FT_ListNodeRec_
	prev as FT_ListNode
	next as FT_ListNode
	data as any ptr
end type

type FT_ListNodeRec as FT_ListNodeRec_

type FT_ListRec_
	head as FT_ListNode
	tail as FT_ListNode
end type

type FT_ListRec as FT_ListRec_

#endif
