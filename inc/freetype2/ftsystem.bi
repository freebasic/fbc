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

extern "C"

#define __FTSYSTEM_H__
type FT_Memory as FT_MemoryRec_ ptr
type FT_Alloc_Func as function(byval memory as FT_Memory, byval size as clong) as any ptr
type FT_Free_Func as sub(byval memory as FT_Memory, byval block as any ptr)
type FT_Realloc_Func as function(byval memory as FT_Memory, byval cur_size as clong, byval new_size as clong, byval block as any ptr) as any ptr

type FT_MemoryRec_
	user as any ptr
	alloc as FT_Alloc_Func
	free as FT_Free_Func
	realloc as FT_Realloc_Func
end type

type FT_Stream as FT_StreamRec_ ptr

union FT_StreamDesc_
	value as clong
	pointer as any ptr
end union

type FT_StreamDesc as FT_StreamDesc_
type FT_Stream_IoFunc as function(byval stream as FT_Stream, byval offset as culong, byval buffer as ubyte ptr, byval count as culong) as culong
type FT_Stream_CloseFunc as sub(byval stream as FT_Stream)

type FT_StreamRec_
	base as ubyte ptr
	size as culong
	pos as culong
	descriptor as FT_StreamDesc
	pathname as FT_StreamDesc
	read as FT_Stream_IoFunc
	close as FT_Stream_CloseFunc
	memory as FT_Memory
	cursor as ubyte ptr
	limit as ubyte ptr
end type

type FT_StreamRec as FT_StreamRec_

end extern
