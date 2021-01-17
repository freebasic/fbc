#ifndef __FBHELP_LINEBUFFER_BI__
#define __FBHELP_LINEBUFFER_BI__

''  fbhelp - FreeBASIC help viewer
''  Copyright (C) 2006-2021 Jeffery R. Marshall (coder[at]execulink.com)

''	This program is free software; you can redistribute it and/or modify
''	it under the terms of the GNU General Public License as published by
''	the Free Software Foundation; either version 2 of the License, or
''	(at your option) any later version.
''
''	This program is distributed in the hope that it will be useful,
''	but WITHOUT ANY WARRANTY; without even the implied warranty of
''	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
''	GNU General Public License for more details.
''
''	You should have received a copy of the GNU General Public License
''	along with this program; if not, write to the Free Software
''	Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02111-1301 USA.

	#include once "common.bi"

	const LINE_BUFFER_FLAG_CHANGED = 1

	type LINE_BUFFER_T
		mflags as integer
		msize as integer
		mlength as integer
		mindex as integer
		mdata as ubyte Ptr
	end type

	declare function LINE_BUFFER_Create alias "LINE_BUFFER_Create"  (byval startsize as integer) as LINE_BUFFER_T Ptr
	declare sub LINE_BUFFER_Destroy alias "LINE_BUFFER_Destroy" (ByVal buf as LINE_BUFFER_T Ptr)
	declare sub LINE_BUFFER_Clear alias "LINE_BUFFER_Clear" (byval buf as LINE_BUFFER_T Ptr)
	declare function LINE_BUFFER_GetBufferSize alias "LINE_BUFFER_GetBufferSize" (byval buf as LINE_BUFFER_T ptr) As integer
	declare sub LINE_BUFFER_SetBufferSize alias "LINE_BUFFER_SetBufferSize" (byval buf as LINE_BUFFER_T ptr, byval size As integer)
	declare function LINE_BUFFER_GetLength alias "LINE_BUFFER_GetLength" (byval buf as LINE_BUFFER_T Ptr) as integer
	declare function LINE_BUFFER_GetIndex alias "LINE_BUFFER_GetIndex" (ByVal buf as LINE_BUFFER_T Ptr) as integer
	declare function LINE_BUFFER_SetIndex alias "LINE_BUFFER_SetIndex" (ByVal buf as LINE_BUFFER_T Ptr, byval index as integer) as integer
	declare sub LINE_BUFFER_InsertChar alias "LINE_BUFFER_InsertChar" (ByVal buf as LINE_BUFFER_T Ptr, byval ch as integer)
	declare sub LINE_BUFFER_BackChar alias "LINE_BUFFER_BackChar" (ByVal buf as LINE_BUFFER_T Ptr)
	declare Sub LINE_BUFFER_DeleteChar alias "LINE_BUFFER_DeleteChar" (ByVal buf as LINE_BUFFER_T Ptr)
	declare function LINE_BUFFER_GetChar alias "LINE_BUFFER_GetChar" (byval buf as LINE_BUFFER_T Ptr, byval Index As integer) As Integer
	declare sub LINE_BUFFER_SetChar alias "LINE_BUFFER_SetChar" (byval buf as LINE_BUFFER_T Ptr, byval Index As integer, byval ch As Integer)
	declare function LINE_BUFFER_GetTextPtr alias "LINE_BUFFER_GetTextPtr" (ByVal buf as LINE_BUFFER_T Ptr) as zstring ptr
	declare function LINE_BUFFER_GetText alias "LINE_BUFFER_GetText" (ByVal buf as LINE_BUFFER_T Ptr, ByVal txt as ubyte ptr, ByVal size as integer) as integer
	declare function LINE_BUFFER_SetText alias "LINE_BUFFER_SetText" (ByVal buf as LINE_BUFFER_T Ptr, ByVal txt as ubyte ptr, ByVal size as integer) as integer
	declare sub LINE_BUFFER_ClearChanged alias "LINE_BUFFER_ClearChanged" (ByVal buf as LINE_BUFFER_T Ptr)
	declare function LINE_BUFFER_IsChanged alias "LINE_BUFFER_IsChanged" (ByVal buf as LINE_BUFFER_T Ptr) as integer

#endif