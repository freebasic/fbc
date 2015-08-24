'' FreeBASIC binding for freetype-2.6
''
'' based on the C header files:
''   /*    FreeType high-level API and common types (specification only).       */
''   /*                                                                         */
''   /*  Copyright 1996-2015 by                                                 */
''   /*  David Turner, Robert Wilhelm, and Werner Lemberg.                      */
''
''   This program is free software; you can redistribute it and/or modify
''   it under the terms of the GNU General Public License as published by
''   the Free Software Foundation; either version 2 of the License, or
''   (at your option) any later version.
''
''   This program is distributed in the hope that it will be useful,
''   but WITHOUT ANY WARRANTY; without even the implied warranty of
''   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''   GNU General Public License for more details.
''
''   You should have received a copy of the GNU General Public License
''   along with this program; if not, write to the Free Software
''   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
''
'' translated to FreeBASIC by:
''   Copyright © 2015 FreeBASIC development team

#pragma once

#include once "crt/long.bi"
#include once "config/ftconfig.bi"
#include once "ftsystem.bi"
#include once "ftimage.bi"
#include once "crt/stddef.bi"

'' The following symbols have been renamed:
''     #define FT_BOOL => FT_BOOL_

extern "C"

#define __FTTYPES_H__
type FT_Bool as ubyte
type FT_FWord as short
type FT_UFWord as ushort
type FT_Char as byte
type FT_Byte as ubyte
type FT_Bytes as const FT_Byte ptr
type FT_Tag as FT_UInt32
type FT_String as zstring
type FT_Short as short
type FT_UShort as ushort
type FT_Int as long
type FT_UInt as ulong
type FT_Long as clong
type FT_ULong as culong
type FT_F2Dot14 as short
type FT_F26Dot6 as clong
type FT_Fixed as clong
type FT_Error as long
type FT_Pointer as any ptr
type FT_Offset as uinteger
type FT_PtrDist as integer

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
	pointer as const FT_Byte ptr
	length as FT_Int
end type

type FT_Data as FT_Data_
type FT_Generic_Finalizer as sub(byval object as any ptr)

type FT_Generic_
	data as any ptr
	finalizer as FT_Generic_Finalizer
end type

type FT_Generic as FT_Generic_
#define FT_MAKE_TAG(_x1, _x2, _x3, _x4) cast(FT_Tag, (((cast(FT_ULong, _x1) shl 24) or (cast(FT_ULong, _x2) shl 16)) or (cast(FT_ULong, _x3) shl 8)) or cast(FT_ULong, _x4))
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
#define FT_IS_EMPTY(list) ((list).head = 0)
#define FT_BOOL_(x) cast(FT_Bool, (x))
#define FT_ERR_XCAT(x, y) x##y
#define FT_ERR_CAT(x, y) FT_ERR_XCAT(x, y)
#define FT_ERR(e) FT_ERR_CAT(FT_ERR_PREFIX, e)
#define FT_ERROR_BASE(x) ((x) and &hFF)
#define FT_ERROR_MODULE(x) ((x) and &hFF00u)
#define FT_ERR_EQ(x, e) (FT_ERROR_BASE(x) = FT_ERROR_BASE(FT_ERR(e)))
#define FT_ERR_NEQ(x, e) (FT_ERROR_BASE(x) <> FT_ERROR_BASE(FT_ERR(e)))

end extern
